--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
    SetMapEntryEntiID(entry, 2492,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 

    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口
    HELL_ENTRY_LUA_000001 = GetResString("HELL_ENTRY_LUA_000001")
    local EntryName = HELL_ENTRY_LUA_000001
    SetMapEntryEventName( entry, EntryName )
    
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    HELL3_ENTRY_LUA_000001 = GetResString("HELL3_ENTRY_LUA_000001")
    HELL3_ENTRY_LUA_000002 = GetResString("HELL3_ENTRY_LUA_000002")
    Notice(HELL3_ENTRY_LUA_000002..posx..","..posy..HELL3_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

function after_destroy_entry_hell3(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    --Notice("海盗广播：今天的公会挑战赛已经结束了") 

end

function after_player_login_hell3(entry, player_name)

end

--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_hell3( role, copy_mgr )

if CRY[9]==0 then
	HELL2_ENTRY_LUA_000004 = GetResString("HELL2_ENTRY_LUA_000004")
	SystemNotice(role,HELL2_ENTRY_LUA_000004)
	return 0
end
return 1

end

function begin_enter_hell3(role, copy_mgr) 
    

		HELL_ENTRY_LUA_000004 = GetResString("HELL_ENTRY_LUA_000004")
		SystemNotice(role,HELL_ENTRY_LUA_000004)
		HELL3_ENTRY_LUA_000003 = GetResString("HELL3_ENTRY_LUA_000003")
		MoveCity(role, HELL3_ENTRY_LUA_000003)
	

end 
