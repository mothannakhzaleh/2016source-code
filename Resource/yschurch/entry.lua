--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀，如after_destroy_entry_testpk
--此文件每行最大字符个数为255，若有异议，请与程序探讨

function config_entry(entry) 
  --  SetMapEntryEntiID(entry, 193,1) --设置地图入口实体的编号（该编号对应于characterinfo.txt的索引）

end 

function after_create_entry(entry) 
  --  local copy_mgr = GetMapEntryCopyObj(entry, 0) --创建副本管理对象，此函数在有显式入口的地图中必须调用，对于隐式入口的地图（如队伍挑战）无要调用该接口

 --   map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
   -- Notice("海盗广播：有玩家发现，在魔女大陆有玩家在教堂举行华丽的庆典，该消息尚未核实，请有关单位注意。") --通知本组服务器的所有玩家

end

function after_destroy_entry_yslchurch(entry)
    --map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) 
   -- Notice("海盗广播：据玩家提供的消息，举行婚礼等庆典的教堂已经关门了。请大家继续关注我台的广播，祝您愉快～！") 

end

function after_player_login_yslchurch(entry, player_name)
  --  map_name, posx, posy, tmap_name = GetMapEntryPosInfo(entry) --取地图入口的位置信息（地图名，坐标，目标地图名）
   -- ChaNotice(player_name, "海盗广播：有玩家发现，在魔女大陆有玩家在教堂举行华丽的庆典，该消息尚未核实，请有关单位注意。") --通知本组服务器的所有玩家

end
