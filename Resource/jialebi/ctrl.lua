function config(map)
    MapCanSavePos(map, 1) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
  --  MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
  --  MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
  --  SingleMapCopyPlyNum(map, 300)
  --  MapCanTeam(map , 1)
 --   MapType ( map , 4 )
	MapType ( map , 4 )
	MapCanPK( map, 1 )	--全地图PK
end

function init_entry(map)
end

function map_run_jialebi(map)
end
function get_map_entry_pos_jialebi()   --设置入口的位置的坐标（坐标（米））

	local POS_X=0	
	local POS_Y=0	
	return POS_X , POS_Y

end
