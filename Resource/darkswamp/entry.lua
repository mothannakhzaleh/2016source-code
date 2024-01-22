--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry, 2492,4) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）
end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    DARKSWAMP_ENTRY_LUA_000001 = GetResString("DARKSWAMP_ENTRY_LUA_000001")
    ABANDONEDCITY_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY_ENTRY_LUA_000002")
    Notice(ABANDONEDCITY_ENTRY_LUA_000002..posx..","..posy..DARKSWAMP_ENTRY_LUA_000001) --通知本组服务器的所有玩家
end

function after_destroy_entry_darkswamp(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    ABANDONEDCITY_ENTRY_LUA_000003 = GetResString("ABANDONEDCITY_ENTRY_LUA_000003")
    ABANDONEDCITY_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY_ENTRY_LUA_000002")
    Notice(ABANDONEDCITY_ENTRY_LUA_000002..posx..","..posy..ABANDONEDCITY_ENTRY_LUA_000003) 

end

function after_player_login_darkswamp(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    DARKSWAMP_ENTRY_LUA_000001 = GetResString("DARKSWAMP_ENTRY_LUA_000001")
    ABANDONEDCITY_ENTRY_LUA_000002 = GetResString("ABANDONEDCITY_ENTRY_LUA_000002")
    ChaNotice(player_name, ABANDONEDCITY_ENTRY_LUA_000002..posx..","..posy..DARKSWAMP_ENTRY_LUA_000001) --通知本组服务器的所有玩家
end


--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_darkswamp( role, copy_mgr )
    local Cha = TurnToCha(role)
  
	if Lv(Cha) >=40 and Lv(Cha) <=55 then
		
		return 1
		
	else
		DARKSWAMP_ENTRY_LUA_000002 = GetResString("DARKSWAMP_ENTRY_LUA_000002")
		SystemNotice(role, DARKSWAMP_ENTRY_LUA_000002)
		return 0
	end
end


function begin_enter_darkswamp(role, copy_mgr) 

	DARKSWAMP_ENTRY_LUA_000003 = GetResString("DARKSWAMP_ENTRY_LUA_000003")
	SystemNotice(role,DARKSWAMP_ENTRY_LUA_000003) 
	DARKSWAMP_ENTRY_LUA_000004 = GetResString("DARKSWAMP_ENTRY_LUA_000004")
	MoveCity(role, DARKSWAMP_ENTRY_LUA_000004)
end 
