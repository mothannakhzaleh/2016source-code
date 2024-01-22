--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)
    MapType ( map , 4 )
end


function get_map_entry_pos_PKmap()   --设置入口的位置的坐标（坐标（米））
end

function init_entry(map)
end


function can_open_entry_PKmap( map ) 
end 
