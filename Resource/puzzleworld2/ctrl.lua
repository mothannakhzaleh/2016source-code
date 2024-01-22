--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
	MapCanTeam(map , 1)
    MapType ( map , 4 )
end


function get_map_entry_pos_puzzleworld2()   --设置入口的位置的坐标（坐标（米））

	local POS_X=172
	local POS_Y=165
	local a = 100
	local k = math.random ( 1 , a )
	if k < 25 then
		POS_X = 172
		POS_Y = 165
	end
	if k >= 25 and k < 50 then
		POS_X = 147
		POS_Y = 384
	end
	if k >= 50 and k < 75 then
		POS_X = 365
		POS_Y = 381
	end
	if k >= 75 then
		POS_X = 365
		POS_Y = 171
	end
	
	return POS_X , POS_Y

--172,165
--147,384
--365,381
--365,171



end

function init_entry(map)
    SetMapEntryMapName(map, "puzzleworld") --设置入口的位置（地图名）
    SetMapEntryTime(map, "2005/8/30/0/0", "0/3/0", "0/0/80", "0/2/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。

end

function map_run_puzzleworld2(map)
end
