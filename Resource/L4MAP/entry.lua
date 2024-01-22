function config_entry(entry) 
    SetMapEntryEntiID(entry, 193,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
    local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    Notice("PKO Broadcast: Ascaron Region ["..posx..","..posy.."] coords spotted a Black Dragon Portal") --通知本组服务器的所有玩家
end

function after_destroy_entry_L4MAP(entry)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
    Notice("PKO Broadcast: Black Dragon Portal has vanished. Hope you enjoy it!") 

end

function after_player_login_L4MAP(entry, player_name)
    map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
    ChaNotice(player_name, "PKO Broadcast: Ascaron Region ["..posx..","..posy.."] coords spotted a Black Dragon Portal") --通知本组服务器的所有玩家

end









--用于检测进入条件
--返回值：0，不满足进入条件。1，成功进入。
function check_can_enter_L4MAP( role, copy_mgr )
	if Lv(role) >=50 then
			return 1
				
	else
		SystemNotice(role, "Requires level 50 and above to enter Black Dragon Portal
")
		return 0    
	end
end

function begin_enter_L4MAP(role, copy_mgr) 
    
		SystemNotice(role,"Entering Black Dragon") 
		MoveCity(role, "L4MAP")
	
end
