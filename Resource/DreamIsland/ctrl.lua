--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
	
end


function get_map_entry_pos_DreamIsland()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end

function init_entry(map)

end

function after_enter_DreamIsland( role , map_copy )
end

function before_leave_DreamIsland( role )
end

function map_copy_first_run_DreamIsland( map_copy )

end

function map_copy_run_DreamIsland( map_copy )
end
wangxiaohu = nil
wangxiaohuflag = nil --1.活 0.死
--每5秒执行一次的
function map_run_DreamIsland( map )

	------------------------罂粟花开----------------------活动BOSS测试用-------------------------------
	local Now_Time = tonumber(os.date("%H"))
	local Now_Minite =tonumber(os.date("%M"))
	local Now_Scend =  tonumber(os.date("%S"))
	local X = math.random(299,495)
	local Y = math.random(665,694)
	local X1 = X*100
	local Y1 = Y*100
	if Now_Time == 19 and Now_Minite ==30 and Now_Scend>0 and Now_Scend <6 then
	      if CheckWXHDead ( wangxiaohu ) == 2 or wangxiaohuflag== 0 then
		    wangxiaohu = CreateCha(1281, X1, Y1, 90, 60)-----60.单位.秒
			SetChaLifeTime(wangxiaohu,10800000)--存活时间3小时 单位.毫秒
			wangxiaohuflag = 1
			ScrollNotice ( "Night event Boss announcement: Wang Xiao Hu is at City of Dream ("..X..","..Y.."). What item will this unlucky bandit have on him?",1) 
		 end
	end
	
	if wangxiaohuflag == 1 then 
		local a = CheckWXHDead ( wangxiaohu ,1281)
	end
	
	if Now_Time == 22 and Now_Minite ==30 and Now_Scend>0 and Now_Scend <6 then
	   if wangxiaohuflag == 1 then
			ScrollNotice ( "Daily Boss Event Announcement: The wicked robber Wang Xiao Hu has been captured by Private - Goldy. Thank you everyone for the help!",1)
			wangxiaohuflag =0
		end
	end
	--ScrollNotice ( "虎="..CheckMonsterDead ( wangxiaohu ))
	------------------------罂粟花开----------------------活动BOSS测试用-------------------------------clear_target(c)
	-- local nowTime = GetNowTimeW()
	
	-- if math.fmod(nowTime,1200)<5 then 
		-- ZTLBalance()
	-- end	
	-- if math.fmod(nowTime,86400)<5 then 
		-- clear()
	-- end
	-- if math.fmod(nowTime,1200)<5 then 
		-- Notice (" 各单位注意：白银城 2202，2776 出现了一头会说话的猪，据小道消息，该猪身上携带大量暑期礼物！")
	-- end	
	-- if math.fmod(nowTime,1200)<5 then 
		-- Notice (" 年年七夕今又至，翩翩飞鹊各不同。银河渡桥人依旧，相思离苦化雨愁。织女正苦于没有喜鹊帮她搭鹊桥，快去废矿补给站门口1909,2800帮助她吧！")
	-- end	
	-- if math.fmod(nowTime,86400)<5 then 
		-- XiqueNum = 0
		-- ScrollNotice (" 本日的七夕多倍经验奖励已经结束，新的一天新的开始，越早达成织女的心愿，可以获得的多倍经验时间就越长，更有想不到的奇遇在等着你！",3)
		-- Notice (" 本日的七夕多倍经验奖励已经结束，新的一天新的开始，越早达成织女的心愿，可以获得的多倍经验时间就越长，更有想不到的奇遇在等着你！")
	-- end	
end

--地图关闭时执行
function map_copy_close_DreamIsland ( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_DreamIsland( map ) 
end 

function map_copy_run_special_DreamIsland(map)
end
