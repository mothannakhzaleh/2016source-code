--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

SPECIALSKILL = {}
SPECIALSKILL[10]=0
SPECIALSKILL[11]=0
SPECIALSKILL[12]=0
SPECIALSKILL[13]=0
SPECIALSKILL[14]=0
SPECIALSKILL[15]=0
SPECIALSKILL[16]=0
SPECIALSKILL[17]=0
SPECIALSKILL[18]=0
SPECIALSKILL[19]=0

SUMMONNUM = 20
SUMMONJG = 60

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    --MapCopyStartType(map, 1) --设置地图立即开始
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)
    MapType ( map , 4 )
end


function get_map_entry_pos_hell3()   --设置入口的位置的坐标（坐标（米））

	local POS_X=245
	local POS_Y=75
	return POS_X , POS_Y

end

function init_entry(map)
    SetMapEntryMapName(map, "hell2") --设置入口的位置（地图名，坐标（米））
    SetMapEntryTime(map, "2007/1/19/22/0", "1/0/0", "0/0/30", "0/5/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

function after_enter_hell3( role , map_copy )

local cha_name=GetChaDefaultName(role)

HELL3_CTRL_LUA_000001 = GetResString("HELL3_CTRL_LUA_000001")
HELL3_CTRL_LUA_000002 = GetResString("HELL3_CTRL_LUA_000002")
SystemNotice ( role, HELL3_CTRL_LUA_000002..cha_name..HELL3_CTRL_LUA_000001 ) 

end

function before_leave_hell3 ( role )

end

function map_copy_first_run_hell3( map_copy )



end

function startspecialskill (monsterID)

	local Notice_all = {}
	HELL3_CTRL_LUA_000003 = GetResString("HELL3_CTRL_LUA_000003")
	Notice_all[10] = HELL3_CTRL_LUA_000003
	HELL3_CTRL_LUA_000004 = GetResString("HELL3_CTRL_LUA_000004")
	Notice_all[11] = HELL3_CTRL_LUA_000004
	HELL3_CTRL_LUA_000005 = GetResString("HELL3_CTRL_LUA_000005")
	Notice_all[12] = HELL3_CTRL_LUA_000005
	HELL3_CTRL_LUA_000006 = GetResString("HELL3_CTRL_LUA_000006")
	Notice_all[13] = HELL3_CTRL_LUA_000006
	HELL3_CTRL_LUA_000007 = GetResString("HELL3_CTRL_LUA_000007")
	Notice_all[14] = HELL3_CTRL_LUA_000007
	HELL3_CTRL_LUA_000008 = GetResString("HELL3_CTRL_LUA_000008")
	Notice_all[15] = HELL3_CTRL_LUA_000008
	HELL3_CTRL_LUA_000009 = GetResString("HELL3_CTRL_LUA_000009")
	Notice_all[16] = HELL3_CTRL_LUA_000009
	HELL3_CTRL_LUA_000010 = GetResString("HELL3_CTRL_LUA_000010")
	Notice_all[17] = HELL3_CTRL_LUA_000010


	if monsterID == 10 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )
		local mspd = GetChaAttr( AZRAEL[monsterID] , ATTR_BMSPD ) *4
		SetCharaAttr(mspd , AZRAEL[monsterID] , ATTR_BMSPD ) 
		SPECIALSKILL[10]=1
	end

	if monsterID == 11 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )
		SetCharaAttr( 10000, AZRAEL[monsterID], ATTR_BCRT)													--[[赋值基本暴击率]]--
		SPECIALSKILL[11]=1
	end

	if monsterID == 12 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )

		local mnatk = GetChaAttr( AZRAEL[monsterID] , ATTR_BMNATK ) *2
		local mxatk = GetChaAttr( AZRAEL[monsterID] , ATTR_BMXATK ) *2

		SetCharaAttr(mnatk, AZRAEL[monsterID], ATTR_BMNATK )											--[[赋值基本最小伤害力]]--
		SetCharaAttr(mxatk, AZRAEL[monsterID], ATTR_BMXATK )												--[[赋值基本最大伤害力]]--
		SPECIALSKILL[12]=1

	end

	if monsterID == 13 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )

		local def = GetChaAttr( AZRAEL[monsterID] , ATTR_BDEF ) *2
		SetCharaAttr( def, AZRAEL[monsterID], ATTR_BDEF )												--[[赋值基本最大伤害力]]--
		SPECIALSKILL[13]=1

	end

	if monsterID == 14 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )

		local aspd = GetChaAttr( AZRAEL[monsterID] , ATTR_BASPD ) *2
		SetCharaAttr( aspd, AZRAEL[monsterID], ATTR_BASPD )												--[[赋值基本最大伤害力]]--
		SPECIALSKILL[14]=1


	end

	if monsterID == 15 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )

		local mxhp = GetChaAttr( AZRAEL[monsterID] , ATTR_BMXHP ) *2
		SetCharaAttr( mxhp, AZRAEL[monsterID], ATTR_HP )												--[[赋值基本最大伤害力]]--
		SPECIALSKILL[15]=1


	end

	if monsterID == 16 then

		if SUMMONJG == 60 then
			MapCopyNotice ( map_copy , Notice_all[monsterID] )

			local x, y = GetChaPos( AZRAEL[monsterID] )
			local x1 = x
			local x2 = x +700
			local x3 = x -700
			local y1 = y + 700
			local y2 = y - 700
			local y3 = y -700
			local new1 = CreateCha(827, x1, y1, 145, 21600)
			local new2 = CreateCha(828, x2, y2, 145, 21600)
			local new3 = CreateCha(828, x3, y3, 145, 21600)
			SUMMONNUM =  SUMMONNUM - 1
			SUMMONJG = SUMMONJG-1
		else
			SUMMONJG = SUMMONJG-1
			if SUMMONJG == 0 then
				SUMMONJG = 60
			end
		end

		if SUMMONNUM == 0 then
			SPECIALSKILL[16]=1
		end

	end

	if monsterID == 17 then
		MapCopyNotice ( map_copy , Notice_all[monsterID] )

		local x, y = GetChaPos( AZRAEL[monsterID] )
		local x1 = x
		local x2 = x +700
		local x3 = x -700
		local y1 = y + 700
		local y2 = y - 700
		local y3 = y -700
		local new1 = CreateCha(986,x1, y1, 145, 21600)
		local new2 = CreateCha(986,x2, y2, 145, 21600)
		local new3 = CreateCha(986, x3, y3, 145, 21600)
		SetCharaAttr( 1000000, new1, ATTR_HP )												--[[赋值基本最大伤害力]]--
		SetCharaAttr( 1000000, new1, ATTR_HP )												--[[赋值基本最大伤害力]]--
		SetCharaAttr( 1000000, new1, ATTR_HP )												--[[赋值基本最大伤害力]]--
		SPECIALSKILL[17]=1
	end

end

function map_copy_run_hell3( map_copy )

--特殊技能发动开始
for i = 1 , 8 , 1 do
	local j = i + 9
	local hp = GetChaAttr( AZRAEL[j] , ATTR_HP ) 
	local mxhp = GetChaAttr( AZRAEL[j] , ATTR_MXHP )
	local percent = hp/mxhp
	if percent < 0.5 and SPECIALSKILL[j]==0 then
		startspecialskill ( j )
	end
end
--特殊技能发动结束


---死亡吼叫开始
	if CheckMonsterDead ( AZRAEL[10] ) == 1 then
		
		if CRY[10]==0 then
			HELL3_CTRL_LUA_000011 = GetResString("HELL3_CTRL_LUA_000011")
			local Notice_all = HELL3_CTRL_LUA_000011
			MapCopyNotice ( map_copy , Notice_all )
			CRY[10]=1
			BOSSXYSJ[979] = 1
			BOSSSJSJ[979] = 8	
			BOSSTJSJ[979] = 8	
			BOSSXZSJ[979] = 12	
			BOSSAYSJ[979] = 12
		end
	end
	
		if CheckMonsterDead ( AZRAEL[11] ) == 1 then
		
		if CRY[11]==0 then
			HELL3_CTRL_LUA_000012 = GetResString("HELL3_CTRL_LUA_000012")
			local Notice_all = HELL3_CTRL_LUA_000012
			MapCopyNotice ( map_copy , Notice_all )
			CRY[11]=1
			BOSSXYSJ[980] = 12
			BOSSSJSJ[980] = 1	
			BOSSTJSJ[980] = 1	
			BOSSXZSJ[980] = 12	
			BOSSAYSJ[980] = 12

		end
	end

		if CheckMonsterDead ( AZRAEL[12] ) == 1 then
		
		if CRY[12]==0 then
			HELL3_CTRL_LUA_000013 = GetResString("HELL3_CTRL_LUA_000013")
			local Notice_all = HELL3_CTRL_LUA_000013
			MapCopyNotice ( map_copy , Notice_all )
			CRY[12]=1
			BOSSXYSJ[981] = 6
			BOSSSJSJ[981] = 6	
			BOSSTJSJ[981] = 6	
			BOSSXZSJ[981] = 16	
			BOSSAYSJ[981] = 16

		end
	end

		if CheckMonsterDead ( AZRAEL[13] ) == 1 then
		
		if CRY[13]==0 then
			HELL3_CTRL_LUA_000014 = GetResString("HELL3_CTRL_LUA_000014")
			local Notice_all = HELL3_CTRL_LUA_000014
			MapCopyNotice ( map_copy , Notice_all )
			CRY[13]=1
			BOSSXYSJ[982] = 4
			BOSSSJSJ[982] = 4	
			BOSSTJSJ[982] = 4	
			BOSSXZSJ[982] = 16	
			BOSSAYSJ[982] = 16

		end
	end

		if CheckMonsterDead ( AZRAEL[14] ) == 1 then
		
		if CRY[14]==0 then
			HELL3_CTRL_LUA_000015 = GetResString("HELL3_CTRL_LUA_000015")
			local Notice_all = HELL3_CTRL_LUA_000015
			MapCopyNotice ( map_copy , Notice_all )
			CRY[14]=1
			BOSSXYSJ[983] = 12
			BOSSSJSJ[983] = 12	
			BOSSTJSJ[983] = 12	
			BOSSXZSJ[983] = 12	
			BOSSAYSJ[983] = 12

		end
	end

		if CheckMonsterDead ( AZRAEL[15] ) == 1 then
		
		if CRY[15]==0 then
			HELL3_CTRL_LUA_000016 = GetResString("HELL3_CTRL_LUA_000016")
			local Notice_all = HELL3_CTRL_LUA_000016
			MapCopyNotice ( map_copy , Notice_all )
			CRY[15]=1
			BOSSXYSJ[984] = 16
			BOSSSJSJ[984] = 16	
			BOSSTJSJ[984] = 16	
			BOSSXZSJ[984] = 4	
			BOSSAYSJ[984] = 4

		end
	end

		if CheckMonsterDead ( AZRAEL[16] ) == 1 then
		
		if CRY[16]==0 then
			HELL3_CTRL_LUA_000017 = GetResString("HELL3_CTRL_LUA_000017")
			local Notice_all = HELL3_CTRL_LUA_000017
			MapCopyNotice ( map_copy , Notice_all )
			CRY[16]=1
			BOSSXYSJ[985] = 16
			BOSSSJSJ[985] = 16	
			BOSSTJSJ[985] = 16	
			BOSSXZSJ[985] = 1	
			BOSSAYSJ[985] = 1

		end
	end

		if CheckMonsterDead ( AZRAEL[17] ) == 1 then
		
		if CRY[17]==0 then
			HELL3_CTRL_LUA_000018 = GetResString("HELL3_CTRL_LUA_000018")
			local Notice_all = HELL3_CTRL_LUA_000018
			MapCopyNotice ( map_copy , Notice_all )
			CRY[17]=1
			BOSSXYSJ[986] = 12
			BOSSSJSJ[986] = 12	
			BOSSTJSJ[986] = 12	
			BOSSXZSJ[986] = 6	
			BOSSAYSJ[986] = 6

		end
	end
--死亡吼叫结束

	if CRY[10]==1 and CRY[11]==1 and CRY[12]==1 and CRY[13]==1 and CRY[14]==1 and CRY[15]==1 and CRY[16]==1 and CRY[17]==1  then
		
		if HELLCLOSETIME==300 then
			HELL3_CTRL_LUA_000019 = GetResString("HELL3_CTRL_LUA_000019")
			Notice(HELL3_CTRL_LUA_000019)
			HELLCLOSETIME = HELLCLOSETIME - 120
		end

		local closetime = HELLCLOSETIME
		for i = 1 , MAXNOTICE , 1 do
			if closetime ==NOTICETIME[i] then
				HELL_CTRL_LUA_000008 = GetResString("HELL_CTRL_LUA_000008")
				HELL3_CTRL_LUA_000020 = GetResString("HELL3_CTRL_LUA_000020")
				local Notice_all = HELL3_CTRL_LUA_000020..closetime..HELL_CTRL_LUA_000008
				MapCopyNotice ( map_copy ,Notice_all )
			end
		end

		HELLCLOSETIME = HELLCLOSETIME-1

		if HELLCLOSETIME == 0 then


			HELLCLOSETIME = 300
			CRY[10]=0
			CRY[11]=0
			CRY[12]=0
			CRY[13]=0
			CRY[14]=0
			CRY[15]=0
			CRY[16]=0
			CRY[17]=0
			SPECIALSKILL[10]=0
			SPECIALSKILL[11]=0
			SPECIALSKILL[12]=0
			SPECIALSKILL[13]=0
			SPECIALSKILL[14]=0
			SPECIALSKILL[15]=0
			SPECIALSKILL[16]=0
			SPECIALSKILL[17]=0
			CloseMapEntry ( "hell3" )
			CloseMapCopy ( "hell3" )
		end
	end



end

--每5秒执行一次的
function map_run_hell3( map )


end

--地图关闭时执行
function map_copy_close_hell3 ( map_copy )

			HELLCLOSETIME = 300
			CRY[10]=0
			CRY[11]=0
			CRY[12]=0
			CRY[13]=0
			CRY[14]=0
			CRY[15]=0
			CRY[16]=0
			CRY[17]=0
			SPECIALSKILL[10]=0
			SPECIALSKILL[11]=0
			SPECIALSKILL[12]=0
			SPECIALSKILL[13]=0
			SPECIALSKILL[14]=0
			SPECIALSKILL[15]=0
			SPECIALSKILL[16]=0
			SPECIALSKILL[17]=0

end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_hell3( map ) 

--	local time = GetTickCount ( ) 
	local Now_Week = GetNowWeek()
	if Now_Week >=5 and Now_Week < 7 then
		return 1
	end


		return 0
end 
