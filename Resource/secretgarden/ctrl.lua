--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    --MapCopyStartType(map, 1) --设置地图立即开始
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)
    MapType ( map , 2 )
end


function get_map_entry_pos_secretgarden()   --设置入口的位置的坐标（坐标（米））

	local POS_X=832
	local POS_Y=3760
	return POS_X , POS_Y

end

function init_entry(map)
    SetMapEntryMapName(map, "magicsea") --设置入口的位置（地图名，坐标（米））
    SetMapEntryTime(map, "2005/8/30/19/0", "1/0/0", "0/2/0", "0/2/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

function after_enter_secretgarden( role , map_copy )
    local map_copy = GetChaMapCopy(role)
    local RedSide_GuildID, BlueSide_GuildID
    RedSide_GuildID = GetMapCopyParam2(map_copy, 3 )
    BlueSide_GuildID = GetMapCopyParam2(map_copy, 4 )
    
	if RedSide_GuildID == GetChaGuildID( role ) then
		SetChaSideID(role, 2)
	end
	if BlueSide_GuildID == GetChaGuildID( role ) then
			SetChaSideID(role, 1)
	end
end

function before_leave_secretgarden ( role )
	local Cha = TurnToCha(role) 
	local i = 0
	local j = 0
	for i = 0 , PK_BagItemDelCheckNum ,1 do
		local j = RemoveChaItem ( Cha ,PK_BagItemDelCheck_ID[i],0,0,-1,2,1 )
		if j == 0 then 
		GUILDWAR_CTRL_LUA_000001 = GetResString("GUILDWAR_CTRL_LUA_000001")
		LG("RemoveChaItem",GUILDWAR_CTRL_LUA_000001)
		end
	end
end

function map_copy_first_run_secretgarden( map_copy )
    local RedSide_GuildID, BlueSide_GuildID
    RedSide_GuildID = GetMapCopyParam2(map_copy, 3 )
    BlueSide_GuildID = GetMapCopyParam2(map_copy, 4 )

    local GuildName = GetGuildName( BlueSide_GuildID )
    SetChaMotto ( BlueSide_BaseRole , GuildName )

    GuildName = GetGuildName( RedSide_GuildID )
    SetChaMotto ( RedSide_BaseRole , GuildName )

end


--胜利公会方的ID--
Guild_Winner_ID = 0
---
function map_copy_run_secretgarden( map_copy )
	if PK_Win_CountNum == 60 then
		local RedSide_GuildID, BlueSide_GuildID
		RedSide_GuildID = GetMapCopyParam2(map_copy, 3 )
		BlueSide_GuildID = GetMapCopyParam2(map_copy, 4 )

		local GuildName_Red = GetGuildName( RedSide_GuildID )
		local GuildName_Blue = GetGuildName ( BlueSide_GuildID )
		if CheckMonsterDead ( BlueSide_BaseRole ) == 1 then
			
			SECRETGARDEN_CTRL_LUA_000001 = GetResString("SECRETGARDEN_CTRL_LUA_000001")
			SECRETGARDEN_CTRL_LUA_000002 = GetResString("SECRETGARDEN_CTRL_LUA_000002")
			SECRETGARDEN_CTRL_LUA_000003 = GetResString("SECRETGARDEN_CTRL_LUA_000003")
			local Notice_all = SECRETGARDEN_CTRL_LUA_000003..GuildName_Red..SECRETGARDEN_CTRL_LUA_000002..GuildName_Blue..SECRETGARDEN_CTRL_LUA_000001
			Notice ( Notice_all )
			PK_Win_CountNum = PK_Win_CountNum - 1
			PK_JJHY_Winner = GuildName_Red
			PK_JJHY_Loser = GuildName_Blue
			SetMapCopyParam2(map_copy, 5, 1) --红方胜利
			Guild_Winner_ID = RedSide_GuildID
			-- DealAllActivePlayerInMap(map_copy,"Give_HZRYX")
		end

		if CheckMonsterDead ( RedSide_BaseRole ) == 1 then
			SECRETGARDEN_CTRL_LUA_000004 = GetResString("SECRETGARDEN_CTRL_LUA_000004")
			SECRETGARDEN_CTRL_LUA_000005 = GetResString("SECRETGARDEN_CTRL_LUA_000005")
			SECRETGARDEN_CTRL_LUA_000002 = GetResString("SECRETGARDEN_CTRL_LUA_000002")
			SECRETGARDEN_CTRL_LUA_000003 = GetResString("SECRETGARDEN_CTRL_LUA_000003")
			local Notice_all = SECRETGARDEN_CTRL_LUA_000003..GuildName_Blue..SECRETGARDEN_CTRL_LUA_000002..GuildName_Red..SECRETGARDEN_CTRL_LUA_000005..GuildName_Blue..SECRETGARDEN_CTRL_LUA_000004
			Notice ( Notice_all )
			PK_Win_CountNum = PK_Win_CountNum - 1
			PK_JJHY_Winner = GuildName_Blue
			PK_JJHY_Loser = GuildName_Red
			SetMapCopyParam2(map_copy, 5, 2) --蓝方胜利
			Guild_Winner_ID = BlueSide_GuildID	
			-- DealAllActivePlayerInMap(map_copy,"Give_HZRYX")
		end
		
		if CheckMonsterDead ( BlueSide_LCRole ) == 1 then
			if BlueSide_LCNotice == 0 then
				SECRETGARDEN_CTRL_LUA_000006 = GetResString("SECRETGARDEN_CTRL_LUA_000006")
				local Notice_all = "["..GuildName_Blue..SECRETGARDEN_CTRL_LUA_000006
				Notice ( Notice_all )
				AddState( BlueSide_BaseRole , BlueSide_BaseRole , STATE_PKLC, 10 , -1 )
				BlueSide_LCNotice = 1
			end
		end
		
		if CheckMonsterDead ( RedSide_LCRole ) == 1 then
			if RedSide_LCNotice == 0 then
				SECRETGARDEN_CTRL_LUA_000006 = GetResString("SECRETGARDEN_CTRL_LUA_000006")
				local Notice_all = "["..GuildName_Red..SECRETGARDEN_CTRL_LUA_000006
				Notice ( Notice_all )
				AddState( RedSide_BaseRole , RedSide_BaseRole , STATE_PKLC, 10 , -1 )
				RedSide_LCNotice = 1
			end
			
		end

		if CheckMonsterDead ( BlueSide_DYKRole ) == 1 then
			if BlueSide_DYKNotice == 0 then
				SECRETGARDEN_CTRL_LUA_000007 = GetResString("SECRETGARDEN_CTRL_LUA_000007")
				local Notice_all = "["..GuildName_Blue..SECRETGARDEN_CTRL_LUA_000007
				Notice ( Notice_all )
				AddState( BlueSide_BaseRole , BlueSide_BaseRole , STATE_PKDYK, 10 , -1 )
				BlueSide_DYKNotice = 1
			end
		end

		if CheckMonsterDead ( RedSide_DYKRole ) == 1 then
			if RedSide_DYKNotice == 0 then
				SECRETGARDEN_CTRL_LUA_000007 = GetResString("SECRETGARDEN_CTRL_LUA_000007")
				local Notice_all = "["..GuildName_Red..SECRETGARDEN_CTRL_LUA_000007
				Notice ( Notice_all )
				AddState( RedSide_BaseRole , RedSide_BaseRole , STATE_PKDYK, 10 , -1 )
				RedSide_DYKNotice = 1
			end		
		end
	else
		
		local Count = PK_Win_CountNum / 5
		if Count == math.floor ( Count ) then
			SECRETGARDEN_CTRL_LUA_000008 = GetResString("SECRETGARDEN_CTRL_LUA_000008")
			SECRETGARDEN_CTRL_LUA_000009 = GetResString("SECRETGARDEN_CTRL_LUA_000009")
			SECRETGARDEN_CTRL_LUA_000010 = GetResString("SECRETGARDEN_CTRL_LUA_000010")
			SECRETGARDEN_CTRL_LUA_000003 = GetResString("SECRETGARDEN_CTRL_LUA_000003")
			local Notice_all = SECRETGARDEN_CTRL_LUA_000003..PK_JJHY_Winner..SECRETGARDEN_CTRL_LUA_000010..PK_JJHY_Loser..SECRETGARDEN_CTRL_LUA_000009..PK_Win_CountNum..SECRETGARDEN_CTRL_LUA_000008
			Notice ( Notice_all )
		end
		PK_Win_CountNum = PK_Win_CountNum - 1
		if PK_Win_CountNum == 0 then
				PK_Win_CountNum = 60
				CloseMapEntry ( "secretgarden" )
				CloseMapCopy ( "secretgarden" )
				
		end
	end
end

--每5秒执行一次的
function map_run_secretgarden( map )
	local GuildLevel = 0
	GuildLevel = GetFightGuildLevel ( )
	if GuildLevel > 0 and GuildLevel < 4 then
		if GuildLevel ~= ReadyToFight then
			EndGuildBid ( GuildLevel )
			ReadyToFight = GuildLevel
		end
	end
end

--地图关闭时执行
function map_copy_close_secretgarden ( map_copy )
	local winner = 	GetMapCopyParam2( map_copy, 5 )
	local RedSide_GuildID = GetMapCopyParam2(map_copy, 3 )
	local BlueSide_GuildID = GetMapCopyParam2(map_copy, 4 )

	if winner == 1 then
		EndGuildChallenge ( RedSide_GuildID , BlueSide_GuildID , 1 )
		SECRETGARDEN_CTRL_LUA_000011 = GetResString("SECRETGARDEN_CTRL_LUA_000011")
		LG( "PK_JJHY",SECRETGARDEN_CTRL_LUA_000011 )
	elseif winner == 2 then
		EndGuildChallenge ( RedSide_GuildID , BlueSide_GuildID , 0 )
		SECRETGARDEN_CTRL_LUA_000012 = GetResString("SECRETGARDEN_CTRL_LUA_000012")
		LG( "PK_JJHY",SECRETGARDEN_CTRL_LUA_000012 )
	elseif winner == 0 then
		EndGuildChallenge ( RedSide_GuildID , BlueSide_GuildID , 1 )
		SECRETGARDEN_CTRL_LUA_000011 = GetResString("SECRETGARDEN_CTRL_LUA_000011")
		LG( "PK_JJHY",SECRETGARDEN_CTRL_LUA_000011 )

	else
		SECRETGARDEN_CTRL_LUA_000013 = GetResString("SECRETGARDEN_CTRL_LUA_000013")
		LG( "PK_JJHY",SECRETGARDEN_CTRL_LUA_000013 )
	end
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_secretgarden( map ) 
--	local time = GetTickCount ( ) 
	local Now_Week = GetNowWeek()
	if Now_Week >=5 and Now_Week < 7 then
		return 1
	end

	if Now_Week == 0 then
		return 1
	end

	return 0 
end 


-- 公会战结束，给胜利方奖励会战荣誉箱
-- function Give_HZRYX( role )
	-- local Guild_ID = GetChaGuildID(role)
	-- if Guild_ID == Guild_Winner_ID then
		-- local Item_CanGet = GetChaFreeBagGridNum ( role )
		-- if Item_CanGet <= 0 then
			-- GiveItemX ( role , 0 , 5716  , 1 , 4 )
		-- else
			-- GiveItem ( role , 0 , 5716  , 1 , 4 )
		-- end
	-- end
-- end	
