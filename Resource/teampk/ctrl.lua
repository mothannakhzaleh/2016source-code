--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 800) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    MapCanTeam( map, 1 )
    MapType( map , 3 )
    MapCopyStartType( map , 3 )
	
end

function init_entry(map)
    SetMapEntryMapName(map, "garner") --设置入口的位置（地图名，坐标（米））
    SetMapEntryTime(map, "2005/8/30/13/0", "0/0/0", "0/0/0", "0/0/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

function map_copy_run_teampk(map_copy) 
--	local Start_time = GetMapCopyParam2(map_copy , 7)
--	if Start_time> 0 then
--		Start_time = Start_time -1
--		SetMapCopyParam2(map_copy, 7,Start_time)
--		return
--	end
--	if Start_time == 0 then
--	end
	local ply_num = GetMapCopyPlayerNum(map_copy) 
	if ply_num == 0 then 
	    CloseMapCopy ("teampk", GetMapCopyID2(map_copy)) 
	end
	local Map_Start = GetMapCopyParam2(map_copy, 8)
	local Map_Start = Map_Start + 1
	SetMapCopyParam2(map_copy, 8, Map_Start)
	local log_count = 0
	local PKMap_HasPlayers = 0
	local Team1_live = 0
	local Team2_live = 0
	local Team1_Num = GetMapCopyParam2(map_copy, 3)
	local Team2_Num = GetMapCopyParam2(map_copy, 4)
	local Max_PlayerNum = 11
	local Team_type = GetMapCopyParam2(map_copy, 1)
	local Team1_PlayerNum = 0
	local Team2_PlayerNum = 0
	local Team1_PlayerLv = 0
	local Team2_PlayerLv = 0
	
	local Winner_Is = GetMapCopyParam2( map_copy, 5 )
	if Winner_Is == -1 then
		SetMapCopyParam2(map_copy, 6, 11 )
	end
	if Winner_Is > -1 then
		local Time_count = GetMapCopyParam2(map_copy, 6)
		local Time_count = Time_count - 1
		SetMapCopyParam2(map_copy, 6,Time_count)
		
		if Time_count == 0 then
			CloseMapCopy ("teampk", GetMapCopyID2(map_copy))
		end
	end		
	
	BeginGetMapCopyPlayerCha ( map_copy )
	
	for i = 0 ,Max_PlayerNum - 1 , 1 do
		PKMap_HasPlayers = GetMapCopyNextPlayerCha ( map_copy )
		if PKMap_HasPlayers ~= 0 and PKMap_HasPlayers ~= nil then
			local Time_count = GetMapCopyParam2(map_copy, 6)
			local Time_num = Time_count / 5
			log_count = log_count + 1
			if Time_num == math.floor ( Time_num ) then
				TEAMPK_CTRL_LUA_000001 = GetResString("TEAMPK_CTRL_LUA_000001")
				TEAMPK_CTRL_LUA_000002 = GetResString("TEAMPK_CTRL_LUA_000002")
				SystemNotice ( PKMap_HasPlayers , TEAMPK_CTRL_LUA_000002..Time_count..TEAMPK_CTRL_LUA_000001)
				if Team_type == 1 then
					local Team_Num_get = GetChaTeamID( PKMap_HasPlayers )
					if Team_Num_get == Winner_Is then
						TEAMPK_CTRL_LUA_000003 = GetResString("TEAMPK_CTRL_LUA_000003")
						SystemNotice ( PKMap_HasPlayers , TEAMPK_CTRL_LUA_000003 )
					end
				end
				if Team_type == 2 then
					local Player = GetChaPlayer( PKMap_HasPlayers )
					local Player_ID_get = GetPlayerID( Player )
					if Player_ID_get == Winner_Is then
						TEAMPK_CTRL_LUA_000004 = GetResString("TEAMPK_CTRL_LUA_000004")
						SystemNotice ( PKMap_HasPlayers , TEAMPK_CTRL_LUA_000004 )
					end
				end
			end
			
				
			local Hp = Hp( PKMap_HasPlayers )		
			local Lv = Lv( PKMap_HasPlayers )
			if Hp > 0 then
				if Team_type == 1 then
					local Team_Num_get = GetChaTeamID( PKMap_HasPlayers )
					if Team_Num_get == 0 then
						TEAMPK_CTRL_LUA_000005 = GetResString("TEAMPK_CTRL_LUA_000005")
						LG("teampk",TEAMPK_CTRL_LUA_000005)
						Map_Start = 0
						SetMapCopyParam2(map_copy, 8, Map_Start)  -----如果队伍信息未到达则地图开启标志置0
						return
					end
					if Team1_Num == Team_Num_get then
						Team1_live = Team1_live + 1
						Team1_PlayerNum = Team1_PlayerNum + 1
						Team1_PlayerLv = Team1_PlayerLv + Lv

					elseif Team2_Num == Team_Num_get then
						Team2_live = Team2_live + 1
						Team2_PlayerNum = Team2_PlayerNum + 1
						Team2_PlayerLv = Team2_PlayerLv + Lv
					end
				elseif Team_type == 2 then
					local Player = GetChaPlayer( PKMap_HasPlayers )
					local Player_ID_get = GetPlayerID( Player )
					if Player_ID_get == 0 then
						TEAMPK_CTRL_LUA_000006 = GetResString("TEAMPK_CTRL_LUA_000006")
						LG("teampk",TEAMPK_CTRL_LUA_000006)
						Map_Start = 0
						SetMapCopyParam2(map_copy, 8, Map_Start)  -----如果队伍信息未到达则地图开启标志置0
						return
					end
					if Team1_Num == Player_ID_get then
						Team1_live = Team1_live + 1
						Team1_PlayerNum = Team1_PlayerNum + 1
						Team1_PlayerLv = Team1_PlayerLv + Lv
					elseif Team2_Num == Player_ID_get then
						Team2_live = Team2_live + 1
						Team2_PlayerNum = Team2_PlayerNum + 1
						Team2_PlayerLv = Team2_PlayerLv + Lv
					end
				end
				if Time_count == 1 then
					 BIRTH_BIRTH_CONF_LUA_000044 = GetResString("BIRTH_BIRTH_CONF_LUA_000044")
					 MoveCity( PKMap_HasPlayers, BIRTH_BIRTH_CONF_LUA_000044 )
				end
			end
		else
			if log_count <=1 and Map_Start == 1 then
				TEAMPK_CTRL_LUA_000007 = GetResString("TEAMPK_CTRL_LUA_000007")
				LG("teampk",TEAMPK_CTRL_LUA_000007..log_count )
			end
			if Map_Start == 1 then
--				Notice("第一次运行脚本")
				SetMapCopyParam2(map_copy , 11 ,Team1_PlayerNum )
				SetMapCopyParam2(map_copy , 12 ,Team2_PlayerNum )
				local Team1_Lv = math.floor ( Team1_PlayerLv / Team1_PlayerNum )
				local Team2_Lv = math.floor ( Team2_PlayerLv / Team2_PlayerNum )
				SetMapCopyParam2(map_copy , 9 , Team1_Lv )
				SetMapCopyParam2(map_copy , 10 , Team2_Lv )
--				Notice ("队伍1人数为"..Team1_PlayerNum)
--				Notice ("队伍2人数为"..Team2_PlayerNum)
--				Notice ("队伍1平均级别为"..Team1_Lv)
--				Notice ("队伍2平均级别为"..Team2_Lv)
			end
			if Team1_live == 0 and Team2_live > 0 and Winner_Is == -1 then
				SetMapCopyParam2(map_copy, 5, Team2_Num )
			end
			
			if Team1_live > 0 and Team2_live == 0 and Winner_Is == -1 then
				SetMapCopyParam2(map_copy, 5, Team1_Num )
			end
			return
		end
			
	end


end 


function before_leave_teampk ( role , map_copy )
--	SystemNotice (role , "离开啦")
	local Cha = TurnToCha( role ) 
	local Winner_Is = GetMapCopyParam2( map_copy, 5 )
	local Cha_TeamID = GetChaTeamID ( Cha )
	local Player = GetChaPlayer( Cha )
	local Cha_ID = GetPlayerID( Player )
	local PK_type = GetMapCopyParam2( map_copy , 1 )
	local Team1_ID = GetMapCopyParam2( map_copy , 3 )
	local Team2_ID = GetMapCopyParam2( map_copy , 4 )
	local base_rongyu = 2
	local rongyu_dif = 0
	local Team1_Lv = GetMapCopyParam2( map_copy , 9 )
	local Team2_Lv = GetMapCopyParam2( map_copy , 10)
	local Team1_PlayerNum = GetMapCopyParam2( map_copy , 11 )
	local Team2_PlayerNum = GetMapCopyParam2( map_copy , 12 )
	
	local Team1_Rongyu_get = ( base_rongyu * Team2_PlayerNum )
	local Team2_Rongyu_get = ( base_rongyu * Team1_PlayerNum )
	local Team1_Lv_dif = Team1_Lv - Team2_Lv
	local Team2_Lv_dif = Team2_Lv - Team1_Lv
	
	local Rongyu_get = 0
	local Player_Lv_dif = 0
		
--	SystemNotice(role , "队伍1平均等级="..Team1_Lv)
--	SystemNotice(role , "队伍2平均等级="..Team2_Lv)
--	SystemNotice(role , "队伍1人数="..Team1_PlayerNum)
--	SystemNotice(role , "队伍2人数="..Team2_PlayerNum)
	if PK_type == 1 then
--		SystemNotice ( role , "是队伍PK哦")
		if Cha_TeamID == Team1_ID then
			if Winner_Is == Cha_TeamID then
				Rongyu_get = Team1_Rongyu_get
			else
				Rongyu_get = Team2_Rongyu_get
			end
			Player_Lv_dif = Team1_Lv_dif
		elseif Cha_TeamID == Team2_ID then
			if Winner_Is == Cha_TeamID then
				Rongyu_get = Team2_Rongyu_get
			else
				Rongyu_get = Team1_Rongyu_get
			end
			Player_Lv_dif = Team2_Lv_dif
		else
			TEAMPK_CTRL_LUA_000008 = GetResString("TEAMPK_CTRL_LUA_000008")
			LG("teampk",TEAMPK_CTRL_LUA_000008 )
			return
		end
		local rongyu_add = 0
		
		if Player_Lv_dif > 0 then
			if Winner_Is == Cha_TeamID then 
				rongyu_add = math.floor ( Rongyu_get / math.floor ( (  Player_Lv_dif + 10 )/10 ) )
			else
--				SystemNotice(role , "计算失败荣誉")
				rongyu_add = math.floor ( Rongyu_get * math.min( 3 , math.floor ( (  Player_Lv_dif + 10 )/10 ) ) )
--				SystemNotice(role , "失败荣誉为"..rongyu_add)
			end
		end
		if Player_Lv_dif < 0 then
			if Winner_Is == Cha_TeamID then
				rongyu_add = math.floor ( Rongyu_get * -1 * math.max ( -3 , math.floor ( (  Player_Lv_dif - 10 )/10 ) ) )
			else
--				SystemNotice(role , "计算失败荣誉")
				rongyu_add = math.floor ( Rongyu_get * -1 / math.floor ( (  Player_Lv_dif - 10 )/10 ) )
--				SystemNotice(role , "失败荣誉为"..rongyu_add)
			end
		end
		
		if Player_Lv_dif ==  0 then
			rongyu_add = Rongyu_get
		end

		if Winner_Is == Cha_TeamID then
			local RYZ_Num = 0
			RYZ_Num = CheckBagItem( role,3849 )

			if RYZ_Num == 0 then
				return
			elseif RYZ_Num > 1 then
				TEAMPK_CTRL_LUA_000009 = GetResString("TEAMPK_CTRL_LUA_000009")
				LG("RYZ_PK",TEAMPK_CTRL_LUA_000009)
				return
			end
			local Cha_RYZ = GetChaItem2 ( Cha , 2 , 3849 )
			local attrtype = ITEMATTR_VAL_STA
			local attrtype_Rongyu = ITEMATTR_VAL_STR
			local num = 1
			local Rongyu = rongyu_add
--			SystemNotice ( role , "胜利增加胜利场数")
			Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype , num )
			TEAMPK_CTRL_LUA_000010 = GetResString("TEAMPK_CTRL_LUA_000010")
			SystemNotice ( role , TEAMPK_CTRL_LUA_000010..Rongyu )
			Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype_Rongyu , Rongyu )
		else
			local RYZ_Num = 0
			RYZ_Num = CheckBagItem( role,3849 )

			if RYZ_Num == 0 then
				return
			elseif RYZ_Num > 1 then
				TEAMPK_CTRL_LUA_000009 = GetResString("TEAMPK_CTRL_LUA_000009")
				LG("RYZ_PK",TEAMPK_CTRL_LUA_000009)
				return
			end
			local Cha_RYZ = GetChaItem2 ( Cha , 2 , 3849 )
			local attrtype_Rongyu = ITEMATTR_VAL_STR
			local Rongyu = -1 * rongyu_add
			TEAMPK_CTRL_LUA_000011 = GetResString("TEAMPK_CTRL_LUA_000011")
			SystemNotice ( role ,TEAMPK_CTRL_LUA_000011..rongyu_add )
			Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype_Rongyu , Rongyu )
		end
	elseif PK_type == 2 then
--		SystemNotice ( role , "是单挑哦" )
		if Cha_ID == Team1_ID then
--			SystemNotice(role , "我是1队的哦")
			Rongyu_get = Team1_Rongyu_get
			Player_Lv_dif = Team1_Lv_dif
		elseif Cha_ID == Team2_ID then
--			SystemNotice ( role , "我是2队的哦")
			Rongyu_get = Team2_Rongyu_get
			Player_Lv_dif = Team2_Lv_dif
		else
--			SystemNotice(role ,"我是幽灵哦")
			TEAMPK_CTRL_LUA_000012 = GetResString("TEAMPK_CTRL_LUA_000012")
			LG("teampk",TEAMPK_CTRL_LUA_000012 )
			return
		end
--		SystemNotice(role , "准备判断等级了")
--		SystemNotice(role , "Player_Lv_dif="..Player_Lv_dif)
		local rongyu_add = 0
		
		if Player_Lv_dif > 0 then
--			SystemNotice(role ,"欺负级低的了吧？")
			if Winner_Is == Cha_ID then 
				rongyu_add = math.floor ( Rongyu_get / math.floor ( (  Player_Lv_dif + 10 )/10 ) )
			else
				rongyu_add = math.floor ( Rongyu_get * math.min ( 3 ,math.floor ( (  Player_Lv_dif + 10 )/10 ) ) )
			end
		end
		if Player_Lv_dif < 0 then
--			SystemNotice(role , "被级高的 K 了？")
			if Winner_Is == Cha_ID then
				rongyu_add = math.floor ( Rongyu_get * -1 * math.max ( -3 , math.floor ( (  Player_Lv_dif - 10 )/10 ) ) )
			else
				rongyu_add = math.floor ( Rongyu_get * -1 / math.floor ( (  Player_Lv_dif - 10 )/10 ) )
			end
		end
		if Player_Lv_dif == 0 then
--			SystemNotice(role , "这么巧，级别一样？")
			rongyu_add = Rongyu_get
		end
	
		if Winner_Is == Cha_ID then
--			SystemNotice(role ,"其实我不想赢")
			local RYZ_Num = 0
			RYZ_Num = CheckBagItem( role,3849 )

			if RYZ_Num == 0 then
				return
			elseif RYZ_Num > 1 then
				TEAMPK_CTRL_LUA_000009 = GetResString("TEAMPK_CTRL_LUA_000009")
				LG("RYZ_PK",TEAMPK_CTRL_LUA_000009)
				return
			end
			local Cha_RYZ = GetChaItem2 ( Cha , 2 , 3849 )
			local attrtype = ITEMATTR_VAL_STA
			local attrtype_Rongyu = ITEMATTR_VAL_STR
			local num = 1
			local Rongyu = rongyu_add
--			SystemNotice ( role , "胜利增加胜利场数")
			Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype , num )
			TEAMPK_CTRL_LUA_000010 = GetResString("TEAMPK_CTRL_LUA_000010")
			SystemNotice ( role , TEAMPK_CTRL_LUA_000010..Rongyu)
			Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype_Rongyu , Rongyu )
		else
--			SystemNotice(role ,"我是让他的")
			local RYZ_Num = 0
			RYZ_Num = CheckBagItem( role,3849 )

			if RYZ_Num == 0 then
				return
			elseif RYZ_Num > 1 then
				TEAMPK_CTRL_LUA_000009 = GetResString("TEAMPK_CTRL_LUA_000009")
				LG("RYZ_PK",TEAMPK_CTRL_LUA_000009)
				return
			end
			local Cha_RYZ = GetChaItem2 ( Cha , 2 , 3849 )
			local attrtype_Rongyu = ITEMATTR_VAL_STR
			local Rongyu = -1 * rongyu_add
			TEAMPK_CTRL_LUA_000011 = GetResString("TEAMPK_CTRL_LUA_000011")
			SystemNotice ( role ,TEAMPK_CTRL_LUA_000011..rongyu_add)
			Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype_Rongyu , Rongyu )
		end
	end
end

function after_enter_teampk ( role , map_copy )
	local RYZ_Num = 0
	RYZ_Num = CheckBagItem( role,3849 )

	if RYZ_Num == 0 then
		return
	elseif RYZ_Num > 1 then
		TEAMPK_CTRL_LUA_000009 = GetResString("TEAMPK_CTRL_LUA_000009")
		LG("RYZ_PK",TEAMPK_CTRL_LUA_000009)
		return
	end

	local Cha_RYZ = GetChaItem2 ( role , 2 , 3849 )
	local attrtype = ITEMATTR_VAL_CON
	local num = 1
--	SystemNotice ( role , "增加参加场数" )
	Add_ItemAttr_RYZ ( role , Cha_RYZ , attrtype , num )
end

function map_run_teampk(map)
end
function get_map_entry_pos_teampk()   --设置入口的位置的坐标（坐标（米））
local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end
