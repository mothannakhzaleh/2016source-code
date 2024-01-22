--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    -----MapCanPK(map, 0) --设置地图是否可以PK，此设置影响该地图的所有副本
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)  --设置地图是否可以操作队伍，参数：地图指针，是否可操作（1，可操作。0，不可操作）
    MapType ( map , 1 )  --设置地图类型，参数：地图对象，类型（1，普通地图。2，公会战地图。3，队伍战地图）
end


function get_map_entry_pos_starwalkway()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end

--地图开关判断
function init_entry(map)
end


function can_open_entry_starwalkway( map ) 
end 
