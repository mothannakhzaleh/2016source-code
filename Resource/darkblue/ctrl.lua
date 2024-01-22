--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
	

end


function get_map_entry_pos_darkblue()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y

end

function init_entry(map)

end

function after_enter_darkblue( role , map_copy )
end

function before_leave_darkblue( role )
end

function map_copy_first_run_darkblue( map_copy )

end

function map_copy_run_darkblue( map_copy )
end

--每5秒执行一次的
function map_run_darkblue( map )
	-- GMSendNotice()
end

--地图关闭时执行
function map_copy_close_darkblue ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_darkblue( map ) 
end 
--每5秒执行一次的
function map_run_darkblue( map )
	local now_week= os.date("%w")		-------------星期几（十进制） 
	local now_hour= os.date("%H")		-------------时 
	local now_miniute= os.date("%M")	-------------分 
	local now_scend=  os.date("%S")		-------------秒
	now_week= tonumber(now_week)	    
	now_hour= tonumber(now_hour)		
	now_miniute= tonumber(now_miniute)
	now_scend= tonumber(now_scend)	-------------秒
	
	local CheckTimeNum_all = now_hour*10000+now_miniute*100 + now_scend
	
	if CheckTimeNum_all >0 and CheckTimeNum_all < 7 then
		
		Clear_Event_Record_By_Event_Name ("Daily Christmas Fun")
		Clear_Event_Record_By_Event_Name ("Help Wynne II")
		Clear_Event_Record_By_Event_Name ("Help Wynne")
		Clear_Event_Record_By_Event_Name ("Silk Road")
	end
	--------------------------------------------------圣诞BOSS-------------------------------
	-- if now_miniute == 1 and now_scend>0 and now_scend <6 then
	    -- SDBOSS = CreateCha(1333, 144500, 55600, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS1 = CreateCha(1334, 145000, 55600, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS1,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS2 = CreateCha(1334, 145200, 55600, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS2,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS3 = CreateCha(1334, 145500, 55600, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS3,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS4 = CreateCha(1334, 145700, 55600, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS4,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS5 = CreateCha(1334, 146000, 55600, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS5,3600000)--存活时间1小时 单位.毫秒
		-- ScrollNotice ( "<<Christmas Event-Siege of Evil Claus>>announcement: Evil Claus and his pet reindeer are committing atrocities near Icicle Castle(1445,556).Hurry now to apprenhend him~~~",1) 
	-- end
end

