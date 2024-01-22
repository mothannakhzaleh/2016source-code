--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 0) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1---------
    SingleMapCopyPlyNum(map, 300)   --设置一个副本的玩家数
    MapCanTeam(map , 1)
    MapType ( map , 1 )
end


function get_map_entry_pos_yschurch()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y

end

function init_entry(map)
	  --SetMapEntryTime(map, "2006/10/18/14/0", "0/0/0", "0/0/0", "0/0/0") --设置入口的时间，地图对象，首次开启时间（年/月/日/时/分），以后再次开启的间隔（日/时/分，全０表示只有首次开启），每次开启到入口消失的间隔（日/时/分，全０表示永不消失），每次开启到地图关闭的间隔（日/时/分，全０表示永不关闭）。。
end

function after_enter_yschurch( role , map_copy )
end

function before_leave_yschurch( role )
end

function map_copy_first_run_yschurch( map_copy )

end

function map_copy_run_yschurch( map_copy )


 local closetime = CHURCHCLOSETIME
     -- for i = 1 , CHURCHNOTICE , 1 do
		--if closetime == CHURCHCLOSESHOW[i] then
			-- local Notice_all = "距离教堂活动结束时间还有"..closetime.."秒！请抓紧时间拉！"
			--MapCopyNotice ( map_copy ,Notice_all )
		--end
	--end
	--CHURCHCLOSETIME = CHURCHCLOSETIME - 1
	KillMonsterInChurch(map_copy)
	KillMonsterInChurch(map_copy)
	DealAllActivePlayerInMap(map_copy,"Goto_ShaLan")
	--Notice("Goto_ShaLan  ")
end


function can_open_entry_yschurch( map )  
	
end 
---------每5s运行一次
function map_run_yschurch ( map )
	
   
end
-----------------------------------传送回沙岚城
function Goto_ShaLan (role)

	local now_week= os.date("%w")		-------------星期几（十进制） 
	local now_hour= os.date("%H")		-------------时 
	local now_miniute= os.date("%M")	-------------分
	now_week= tonumber(now_week)
	now_hour= tonumber(now_hour)		
	now_miniute= tonumber(now_miniute)
	local CheckDateNum = now_hour*100 +now_miniute
	--Notice("CheckDateNum = "..CheckDateNum)
	
	if now_week==1 then
	if CheckDateNum==1710  then
		MoveTo( role,  824, 3530,  "magicsea" )
		
		else
		return
		end
	elseif now_week==6 or  now_week==0 then
		if CheckDateNum==2000  or CheckDateNum==2210 then
		MoveTo( role,  910, 3571,  "magicsea" )
		--Notice("MoveTo1 = ".."910,3751")
		else
		return
		end
	
	end
	
end

function KillMonsterInChurch ( map_copy )
	local now_week= os.date("%w")		-------------星期几（十进制） 
	local now_hour= os.date("%H")		-------------时 
	local now_miniute= os.date("%M")	-------------分
	now_week= tonumber(now_week)
	now_hour= tonumber(now_hour)		
	now_miniute= tonumber(now_miniute)
	local CheckDateNum = now_hour*100 +now_miniute
	--Notice("CheckDateNum = "..CheckDateNum)
	
	if now_week==1 then
		if CheckDateNum==1710  then
			YSCHURCH_CTRL_LUA_000001 = GetResString("YSCHURCH_CTRL_LUA_000001")
			KillMonsterInMapByName(map_copy,YSCHURCH_CTRL_LUA_000001)
			YSCHURCH_CTRL_LUA_000002 = GetResString("YSCHURCH_CTRL_LUA_000002")
			KillMonsterInMapByName(map_copy,YSCHURCH_CTRL_LUA_000002)
		else
			return
		end
	elseif now_week==6 or  now_week==0 then
		if CheckDateNum==2000  or CheckDateNum==2210 then
			YSCHURCH_CTRL_LUA_000001 = GetResString("YSCHURCH_CTRL_LUA_000001")
			KillMonsterInMapByName(map_copy,YSCHURCH_CTRL_LUA_000001)
			YSCHURCH_CTRL_LUA_000002 = GetResString("YSCHURCH_CTRL_LUA_000002")
			KillMonsterInMapByName(map_copy,YSCHURCH_CTRL_LUA_000002)
		else
			return
		end
	end
end


--地图关闭时执行
function map_copy_close_yschurch ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_yschurch( map ) 
end 



