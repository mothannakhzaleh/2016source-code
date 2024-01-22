--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry, 2492,4) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    ABANDONEDCITY_ENTRY_LUA_000001 = GetResString("ABANDONEDCITY_ENTRY_LUA_000001")
    ABANDONEDCITY_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY_ENTRY_LUA_000002")
    Notice(ABANDONEDCITY_ENTRY_LUA_000002..posx..","..posy..ABANDONEDCITY_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

function after_destroy_entry_abandonedcity(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ABANDONEDCITY_ENTRY_LUA_000003 = GetResString("ABANDONEDCITY_ENTRY_LUA_000003")
    ABANDONEDCITY_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY_ENTRY_LUA_000002")
    Notice(ABANDONEDCITY_ENTRY_LUA_000002..posx..","..posy..ABANDONEDCITY_ENTRY_LUA_000003) 

end

function after_player_login_abandonedcity(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    ABANDONEDCITY_ENTRY_LUA_000001 = GetResString("ABANDONEDCITY_ENTRY_LUA_000001")
    ABANDONEDCITY_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY_ENTRY_LUA_000002")
    ChaNotice(player_name, ABANDONEDCITY_ENTRY_LUA_000002..posx..","..posy..ABANDONEDCITY_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_abandonedcity(role, copy_mgr)

	local Cha = TurnToCha(role)
  
	if Lv(Cha) >=30 and Lv(Cha) <=45 then
	
		-- local Num
		-- Num = CheckBagItem(Cha, 1812)
        	
		-- if Num >= 1 then
			return 1
	
		-- else
			-- SystemNotice(role, "没有古代定位仪，无法正确通过飓风到废灵之都")
			-- return 0
		-- end
		
	else
		ABANDONEDCITY_ENTRY_LUA_000004 = GetResString("ABANDONEDCITY_ENTRY_LUA_000004")
		SystemNotice(role, ABANDONEDCITY_ENTRY_LUA_000004)
		return 0    
	end
end



function begin_enter_abandonedcity(role, copy_mgr) 

	-- local Cha = TurnToCha(role)	
	-- local Dbag = 0
	-- Dbag = DelBagItem(Cha, 1812, 1)

	-- if Dbag == 1 then
		ABANDONEDCITY_ENTRY_LUA_000005 = GetResString("ABANDONEDCITY_ENTRY_LUA_000005")
		SystemNotice(role,ABANDONEDCITY_ENTRY_LUA_000005) 
		ABANDONEDCITY_ENTRY_LUA_000006 = GetResString("ABANDONEDCITY_ENTRY_LUA_000006")
		MoveCity(role, ABANDONEDCITY_ENTRY_LUA_000006)

	-- else
	
		-- SystemNotice(role, "收取古代定位仪失败，无法正确通过飓风到废灵之都")
	-- end


end
