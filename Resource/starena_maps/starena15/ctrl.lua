--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
	MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    MapCanTeam( map, 1 )
    MapType( map , 3 )
    MapCopyStartType( map , 1 )
	MapCanStall(map , 0)
end


function get_map_entry_pos_starena15()   --设置入口的位置的坐标（坐标（米））
local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end

function init_entry(map)

end

function after_enter_starena15( role , map_copy )
	
end

function before_leave_starena15( role )
end

function map_copy_first_run_starena15( map_copy )
	
end

function map_copy_run_starena15( map_copy )
end

--每5秒执行一次的


function map_run_starena15( map )




end

--地图关闭时执行
function map_copy_close_starena15 ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_starena15( map ) 
end 
