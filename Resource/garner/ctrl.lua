--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
	

end


function get_map_entry_pos_garner()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end

function init_entry(map)

end

function after_enter_garner( role , map_copy )
end

function before_leave_garner( role )
end

function map_copy_first_run_garner( map_copy )

end

function map_copy_run_garner( map_copy )
end

--每5秒执行一次的
function map_run_garner( map )
	local nowTime = GetNowTimeW()
	
	if math.fmod(nowTime,1200)<5 then 
		ZTLBalance()
	end	
	if math.fmod(nowTime,86400)<5 then 
		clear()
	end
	-------------------------------------zhangliang--------------------抓捕王小虎----------
	local now_hour= tonumber(os.date("%H"))		-------------时 
	local now_miniute= tonumber(os.date("%M"))	-------------分    
	local CheckDateNum = now_hour*100 +now_miniute
	local NowSecond = tonumber(os.date("%S"))			-------秒
	if now_hour == 0  and now_miniute == 0 and  NowSecond < 6 then
		Clear_Event_Record_By_Event_Name( "Capture the fearsome Wang Xiao Hu" )
	end
	
	--------------------------------------------------圣诞BOSS-------------------------------
	-- local now_miniute= os.date("%M")	-------------分 
	-- local now_scend=  os.date("%S")		-------------秒
	
	-- now_miniute= tonumber(now_miniute)
	-- now_scend= tonumber(now_scend)	-------------秒
	-- if now_miniute == 2 and now_scend>0 and now_scend <6 then
	    -- SDBOSS = CreateCha(1333, 207300, 276500, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS1 = CreateCha(1334, 207500, 276500, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS1,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS2 = CreateCha(1334, 207700, 276500, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS2,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS3 = CreateCha(1334, 208000, 276500, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS3,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS4 = CreateCha(1334, 208200, 276500, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS4,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS5 = CreateCha(1334, 208500, 276500, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS5,3600000)--存活时间1小时 单位.毫秒
		-- ScrollNotice ( "<<Christmas Event-Siege of Evil Claus>>announcement: Evil Claus and his pet reindeer are committing atrocities near Argent City(2073,2765).Hurry now to apprenhend him~~~",1) 
	-- end	
end

--地图关闭时执行
function map_copy_close_garner ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_garner( map ) 
end 

function map_copy_run_special_garner(map)
end
