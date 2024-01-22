--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry,193,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    GUILDWAR_ENTRY_LUA_000001 = GetResString("GUILDWAR_ENTRY_LUA_000001")
    GUILDWAR_ENTRY_LUA_000002 = GetResString("GUILDWAR_ENTRY_LUA_000002")
    Notice(GUILDWAR_ENTRY_LUA_000002..posx..","..posy..GUILDWAR_ENTRY_LUA_000001)
	--通知本组服务器的所有玩家


    
--local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口
--    SetMapCopyParam(copy_mgr, 1, 3) --在第一个位置存入分边类型
--    SetMapCopyParam(copy_mgr, 2, 2) --在第二个位置存入分边数
--    SetMapCopyParam(copy_mgr, 3, HaiJunSide) 
--    SetMapCopyParam(copy_mgr, 4, HaiDaoSide)
--    SetMapCopyParam(copy_mgr, 5, 0) --在第5个位置放入胜负关系初值
--    FinishSetMapEntryCopy(entry, 1) 

    --local RedSideName = GetGuildName( RedSide_GuildID ) 
    --local BlueSideName = GetGuildName( BlueSide_GuildID ) 

    GUILDWAR_ENTRY_LUA_000003 = GetResString("GUILDWAR_ENTRY_LUA_000003")
    local EntryName = GUILDWAR_ENTRY_LUA_000003
    SetMapEntryEventName( entry, EntryName )
    
    --map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    --Notice("海盗广播：公会挑战赛现在开始，对阵的双方公会是－－红方擂主 “["..RedSideName.."]”，蓝方挑战者“["..BlueSideName.."]”，双方公会的成员可以通过魔女之海“["..posx..","..posy.."]”处的漩涡进入竞技花园") --通知本组服务器的所有玩家

end

function after_destroy_entry_guildwar(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    GUILDWAR_ENTRY_LUA_000004 = GetResString("GUILDWAR_ENTRY_LUA_000004")
    Notice(GUILDWAR_ENTRY_LUA_000004) 

end

function after_player_login_guildwar(entry, player_name)
--    local copy_mgr = GetMapEntryCopyObj(entry, 1) 
--    local RedSide_GuildID = GetMapCopyParam(copy_mgr, 3 )
--    local BlueSide_GuildID = GetMapCopyParam(copy_mgr, 4 )
--    local RedSideName = GetGuildName( RedSide_GuildID ) 
--    local BlueSideName = GetGuildName( BlueSide_GuildID ) 

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
   GUILDWAR_ENTRY_LUA_000001 = GetResString("GUILDWAR_ENTRY_LUA_000001")
   GUILDWAR_ENTRY_LUA_000002 = GetResString("GUILDWAR_ENTRY_LUA_000002")
   ChaNotice(player_name, GUILDWAR_ENTRY_LUA_000002..posx..","..posy..GUILDWAR_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end




--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_guildwar( role, copy_mgr )

local FightingBook_Num = 0
      FightingBook_Num = CheckBagItem( role,3849 )

if FightingBook_Num <= 0 then
		GUILDWAR_ENTRY_LUA_000005 = GetResString("GUILDWAR_ENTRY_LUA_000005")
		SystemNotice(role,GUILDWAR_ENTRY_LUA_000005)
		--Notice("您身上没有勇者之证,不能进入圣战,请到竞技管理员处领取勇者之证")
		return 0
	elseif FightingBook_Num > 1 then
		GARNER2_ENTRY_LUA_000006 = GetResString("GARNER2_ENTRY_LUA_000006")
		LG("RYZ_PK",GARNER2_ENTRY_LUA_000006)
		return 0
	end


local Team_In = IsInTeam(role)
	if Team_In == 1 then
		GUILDWAR_ENTRY_LUA_000006 = GetResString("GUILDWAR_ENTRY_LUA_000006")
		SystemNotice ( role , GUILDWAR_ENTRY_LUA_000006 )
		return 0
		
	end

	--local Cha = TurnToCha(role)

    --local RedSide_GuildID = GetMapCopyParam(copy_mgr, 3 )
    --local BlueSide_GuildID = GetMapCopyParam(copy_mgr, 4 )



 if  GetChaGuildID(role) == 0 then
	

     GUILDWAR_ENTRY_LUA_000007 = GetResString("GUILDWAR_ENTRY_LUA_000007")
     SystemNotice(role,GUILDWAR_ENTRY_LUA_000007)
     return 0
		
	
elseif Lv(role) < 65  then

	GUILDWAR_ENTRY_LUA_000008 = GetResString("GUILDWAR_ENTRY_LUA_000008")
	SystemNotice(role, GUILDWAR_ENTRY_LUA_000008)
	     return 0    
	end


        local Num_1= CheckBagItem(role,4661)
	if Num_1 >= 1 then
		GUILDWAR_ENTRY_LUA_000009 = GetResString("GUILDWAR_ENTRY_LUA_000009")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000009)	
		return 0
	end

	local Num_2= CheckBagItem(role,4546)
	if Num_2 >= 1 then
		GUILDWAR_ENTRY_LUA_000010 = GetResString("GUILDWAR_ENTRY_LUA_000010")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000010)	
		return 0
	end

	local Num_3= CheckBagItem(role,1684)
	if Num_3 >= 1 then
		GUILDWAR_ENTRY_LUA_000011 = GetResString("GUILDWAR_ENTRY_LUA_000011")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000011)	
		return 0
	end

	local Num_4= CheckBagItem(role,1683)
	if Num_4 >= 1 then
		GUILDWAR_ENTRY_LUA_000012 = GetResString("GUILDWAR_ENTRY_LUA_000012")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000012)	
		return 0
	end

	local Num_5= CheckBagItem(role,4012)
	if Num_5 >= 1 then
		GUILDWAR_ENTRY_LUA_000013 = GetResString("GUILDWAR_ENTRY_LUA_000013")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000013)	
		return 0
	end

	local Num_6= CheckBagItem(role,4013)
	if Num_6 >= 1 then
		GUILDWAR_ENTRY_LUA_000014 = GetResString("GUILDWAR_ENTRY_LUA_000014")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000014)	
		return 0
	end

        local Num_7= CheckBagItem(role,2964)
	if Num_7 >= 1 then
		GUILDWAR_ENTRY_LUA_000015 = GetResString("GUILDWAR_ENTRY_LUA_000015")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000015)	
		return 0
	end

	local Num_8= CheckBagItem(role,3001)
	if Num_8 >= 1 then
		GUILDWAR_ENTRY_LUA_000016 = GetResString("GUILDWAR_ENTRY_LUA_000016")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000016)	
		return 0
	end

	local Num_9= CheckBagItem(role,4011)
	if Num_9 >= 1 then
		GUILDWAR_ENTRY_LUA_000017 = GetResString("GUILDWAR_ENTRY_LUA_000017")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000017)	
		return 0
	end

	local Num_10= CheckBagItem(role,1720)
	if Num_10 >= 1 then
		GUILDWAR_ENTRY_LUA_000018 = GetResString("GUILDWAR_ENTRY_LUA_000018")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000018)	
		return 0
	end

	local Num_11= CheckBagItem(role,2382)
	if Num_11 < 1 then
		GUILDWAR_ENTRY_LUA_000019 = GetResString("GUILDWAR_ENTRY_LUA_000019")
		SystemNotice(role, GUILDWAR_ENTRY_LUA_000019)	
		return 0
	end

end

function begin_enter_guildwar(role, copy_mgr) 

--local role_RY = GetChaItem2 ( role , 2 , 3849 )
--local HonorPoint = GetItemAttr ( role_RY , ITEMATTR_VAL_STR)
--local HonorPoint_now = HonorPoint - 15
--
--	if HonorPoint < 15 then
--		SystemNotice ( role , "您的荣誉值不够,不能进入圣战" )
--		return 0
--	else
--
--	SetItemAttr( role_RY , ITEMATTR_VAL_STR , HonorPoint_now )
--	        
--	end

    --local RedSide_GuildID, BlueSide_GuildID
    --RedSide_GuildID = GetMapCopyParam(copy_mgr, 3)
    --BlueSide_GuildID = GetMapCopyParam(copy_mgr, 4)

     local Cha = TurnToCha(role)
     if  GetChaGuildID(Cha) <= 100 and GetChaGuildID(Cha) > 0 then
	     if count_haijun < 45 then
	       GUILDWAR_ENTRY_LUA_000020 = GetResString("GUILDWAR_ENTRY_LUA_000020")
	       SystemNotice(role,GUILDWAR_ENTRY_LUA_000020)
		MoveCity(role, "guildwarnavyside")
	       
                count_haijun = count_haijun + 1
	      else 
	        GUILDWAR_ENTRY_LUA_000021 = GetResString("GUILDWAR_ENTRY_LUA_000021")
	        SystemNotice(role,GUILDWAR_ENTRY_LUA_000021)
	      end
	
     end	        
		
     if GetChaGuildID(Cha) > 100 and GetChaGuildID(Cha) <= 200 then
             if count_haidao < 45 then
	        GUILDWAR_ENTRY_LUA_000020 = GetResString("GUILDWAR_ENTRY_LUA_000020")
	        SystemNotice(role,GUILDWAR_ENTRY_LUA_000020)
			
		MoveCity(role, "guildwarpirateside")
		count_haidao=count_haidao + 1
	     else
	        GUILDWAR_ENTRY_LUA_000022 = GetResString("GUILDWAR_ENTRY_LUA_000022")
	        SystemNotice(role,GUILDWAR_ENTRY_LUA_000022)
	     end

     end 
end


