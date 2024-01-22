--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
   SetMapEntryEntiID(entry, 193,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    MJING2_ENTRY_LUA_000001 = GetResString("MJING2_ENTRY_LUA_000001")
    Notice(MJING2_ENTRY_LUA_000001) --通知本组服务器的所有玩家

end

function after_destroy_entry_mjing2(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    MJING1_ENTRY_LUA_000002 = GetResString("MJING1_ENTRY_LUA_000002")
    Notice(MJING1_ENTRY_LUA_000002) 

end

function after_player_login_mjing2(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    MJING2_ENTRY_LUA_000002 = GetResString("MJING2_ENTRY_LUA_000002")
    ChaNotice(player_name, MJING2_ENTRY_LUA_000002) --通知本组服务器的所有玩家

end
