function config(map)
    MapCanSavePos(map, 1) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 0) --设置地图是否可以PK，此设置影响该地图的所有副本
  --  MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
  --  SingleMapCopyPlyNum(map, 300)
  --  MapCanTeam(map , 1)
 --   MapType ( map , 4 )

end

function init_entry(map)

end

function map_run_winterland ( map )
	local now_hour= tonumber(os.date("%H"))		-------------时 
	local now_miniute= tonumber(os.date("%M"))	-------------分    
	local CheckDateNum = now_hour*100 +now_miniute
	local NowSecond = tonumber(os.date("%S"))			-------秒
	if now_hour == 0  and now_miniute == 0 and  NowSecond < 6 then
		MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
		Clear_Event_Record_By_Event_Name( MISSCRIPT_MISSIONSCRIPT06_LUA_000087 )
		MISSCRIPT_MISSIONSCRIPT06_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000093")
		Clear_Event_Record_By_Event_Name( MISSCRIPT_MISSIONSCRIPT06_LUA_000093 )
		MISSCRIPT_MISSIONSCRIPT06_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000137")
		Clear_Event_Record_By_Event_Name( MISSCRIPT_MISSIONSCRIPT06_LUA_000137 )
		MISSCRIPT_MISSIONSCRIPT06_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000142")
		Clear_Event_Record_By_Event_Name( MISSCRIPT_MISSIONSCRIPT06_LUA_000142 )
		MISSCRIPT_MISSIONSCRIPT06_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000146")
		Clear_Event_Record_By_Event_Name( MISSCRIPT_MISSIONSCRIPT06_LUA_000146 )
	end
end
function get_map_entry_pos_winterland()   --设置入口的位置的坐标（坐标（米））
local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end
function after_enter_winterland( role , map_copy )
end
function map_copy_run_winterland( map_copy )
end