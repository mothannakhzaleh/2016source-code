--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)


end


function get_map_entry_pos_magicsea()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end

function init_entry(map)

end

function after_enter_magicsea( role , map_copy )
end

function before_leave_magicsea( role )
end

function map_copy_first_run_magicsea( map_copy )

end

function map_copy_run_magicsea( map_copy )
end

--每5秒执行一次的
function map_run_magicsea( map )
	
	local now_week= os.date("%w")		-------------星期几（十进制） 
	local now_hour= os.date("%H")		-------------时 
	local now_miniute= os.date("%M")	-------------分
	now_week= tonumber(now_week)	    
	now_hour= tonumber(now_hour)		
	now_miniute= tonumber(now_miniute)
	local CheckDateNum = now_hour*100 +now_miniute

	if now_week==1 then
		
		if CheckDateNum>=1800 and CheckDateNum<1830 and CHURCHSTAR_FLAG == 0 then
			MAGICSEA_CTRL_LUA_000001 = GetResString("MAGICSEA_CTRL_LUA_000001")
			StartAuction(1, MAGICSEA_CTRL_LUA_000001, 1, 1000000, 1000000) ---开始教堂开拍
			
			CHURCHSTAR_FLAG = 1
		end
		if CheckDateNum>=1830 and CheckDateNum<1840 and CHURCHSTAR_FLAG == 1 then
					--Notice( "教堂停拍")

			EndAuction(1) --------教堂停拍
						--Notice( "EndAuction(1) ")

			CHURCHSTAR_FLAG = 0
		end

		if CheckDateNum>=1840 and CheckDateNum<1910 and CHURCHSTAR_FLAG == 0 then
			MAGICSEA_CTRL_LUA_000001 = GetResString("MAGICSEA_CTRL_LUA_000001")
			StartAuction(1, MAGICSEA_CTRL_LUA_000001, 1, 1000000, 1000000) ---开始教堂开拍
			
			CHURCHSTAR_FLAG = 1
		end
		if CheckDateNum>=1910 and CheckDateNum<1920 and CHURCHSTAR_FLAG == 1 then
			EndAuction(1) --------教堂停拍
			
			CHURCHSTAR_FLAG = 0
		end


		if CheckDateNum>=1920 and CheckDateNum<1950 and CHURCHSTAR_FLAG == 0 then
			MAGICSEA_CTRL_LUA_000001 = GetResString("MAGICSEA_CTRL_LUA_000001")
			StartAuction(1, MAGICSEA_CTRL_LUA_000001, 1, 1000000, 1000000) ---开始教堂开拍
			
			CHURCHSTAR_FLAG = 1
		end
		if CheckDateNum>=1950 and CheckDateNum<2000 and CHURCHSTAR_FLAG == 1 then
			EndAuction(1) --------教堂停拍
			
			CHURCHSTAR_FLAG = 0
		end

		if CheckDateNum>=2000 and CheckDateNum<2030 and CHURCHSTAR_FLAG == 0 then
			MAGICSEA_CTRL_LUA_000001 = GetResString("MAGICSEA_CTRL_LUA_000001")
			StartAuction(1, MAGICSEA_CTRL_LUA_000001, 1, 1000000, 1000000) ---开始教堂开拍
			
			CHURCHSTAR_FLAG = 1
		end
		if CheckDateNum>=2030  and CHURCHSTAR_FLAG == 1 then
			EndAuction(1) --------教堂停拍
			
			CHURCHSTAR_FLAG = 0
		end

	end
	local now_scend=  os.date("%S")		-------------秒
	now_scend= tonumber(now_scend)	-------------秒
	--------------------------------------------------圣诞BOSS-------------------------------
	-- if now_miniute == 3 and now_scend>0 and now_scend <6 then
	    -- SDBOSS = CreateCha(1333, 100700, 352200, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS1 = CreateCha(1334, 101000, 352200, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS1,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS2 = CreateCha(1334, 101200, 352200, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS2,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS3 = CreateCha(1334, 101500, 352200, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS3,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS4 = CreateCha(1334, 101700, 352200, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS4,3600000)--存活时间1小时 单位.毫秒
		-- SDBOSS5 = CreateCha(1334, 102000, 352200, 90, 60)-----60.单位.秒
		-- SetChaLifeTime(SDBOSS5,3600000)--存活时间1小时 单位.毫秒
		-- ScrollNotice ( "<<Christmas Event-Siege of Evil Claus>>announcement: Evil Claus and his pet reindeer are committing atrocities near Shaitan City(1007,3522).Hurry now to apprenhend him~~~",1) 
	-- end
		
end
--地图关闭时执行
function map_copy_close_magicsea ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_magicsea( map ) 
end 



--地图关闭时执行
function map_copy_close_magicsea ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_magicsea( map ) 
end 
