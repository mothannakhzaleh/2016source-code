--此文件中，凡是可能被多次执行的函数，函数名都要加上地图名前缀

function config(map)
    MapCanSavePos(map, 0) --设置地图是否保存角色位置（地图，坐标，方向），此设置影响该地图的所有副本
    MapCanPK(map, 1) --设置地图是否可以PK，此设置影响该地图的所有副本
    --MapCopyNum(map, 1) --设置地图的副本数目，如果不调用该语句，则使用默认值1
    SingleMapCopyPlyNum(map, 300)
    MapCanTeam(map , 1)
    MapType ( map , 4 )
end


function get_map_entry_pos_sdBoss()   --设置入口的位置的坐标（坐标（米））
	local POS_X=0
	local POS_Y=0
	return POS_X , POS_Y
end

function init_entry(map)

end

function after_enter_sdBoss( role , map_copy )
end

function before_leave_sdBoss( role )
end

function map_copy_first_run_sdBoss( map_copy )

end

--每5秒执行一次的
function map_copy_run_sdBoss( map_copy )
	if CheckBossLifeTime1 > 0 then
		CheckBossLifeTime1 = CheckBossLifeTime1 + 1
	end
	if CheckBossLifeTime2 > 0 then
		CheckBossLifeTime1 = CheckBossLifeTime2 + 1
	end
	if CheckBossLifeTime3 > 0 then
		CheckBossLifeTime3 = CheckBossLifeTime3 + 1
	end
	if CheckBossLifeTime4 > 0 then
		CheckBossLifeTime4 = CheckBossLifeTime4 + 1
	end
	if CheckBossLifeTime5 > 0 then
		CheckBossLifeTime5 = CheckBossLifeTime5 + 1
	end
	if XmasMonsterNum1 >= 2100 then
		if CheckBoss1Dead == 1 then
			SDBOSS_CTRL_LUA_000001 = GetResString("SDBOSS_CTRL_LUA_000001")
			ScrollNotice ( SDBOSS_CTRL_LUA_000001,5)
			monster1 = CreateChaEx(1179, 6312, 5519, 175, 1000,map_copy)
			SetChaLifeTime(monster1,3600000)
			XmasMonsterNum1 = 0
			CheckBossLifeTime1 = 1
		else
			if CheckBossLifeTime1 > 3600 then
				SDBOSS_CTRL_LUA_000001 = GetResString("SDBOSS_CTRL_LUA_000001")
				ScrollNotice ( SDBOSS_CTRL_LUA_000001,5)
				monster1 = CreateChaEx(1179, 6312, 5519, 175, 1000,map_copy)
				SetChaLifeTime(monster1,3600000)
				XmasMonsterNum1 = 0
				CheckBossLifeTime1 = 1
			end
		end
	end
	if XmasMonsterNum2 >= 2008 then
		if CheckBoss2Dead==1 then
			SDBOSS_CTRL_LUA_000002 = GetResString("SDBOSS_CTRL_LUA_000002")
			ScrollNotice ( SDBOSS_CTRL_LUA_000002,5)
			monster2 = CreateChaEx(1180, 49612, 5519, 175, 1000,map_copy)
			SetChaLifeTime(monster2,3600000)
			XmasMonsterNum2 = 0
			CheckBossLifeTime2 = 1
		else
			if CheckBossLifeTime2 > 3600 then
				SDBOSS_CTRL_LUA_000002 = GetResString("SDBOSS_CTRL_LUA_000002")
				ScrollNotice ( SDBOSS_CTRL_LUA_000002,5)
				monster2 = CreateChaEx(1180, 49612, 5519, 175, 1000,map_copy)
				SetChaLifeTime(monster2,3600000)
				XmasMonsterNum2 = 0
				CheckBossLifeTime2 = 1
			end
		end
	end
	if XmasMonsterNum3 >= 2008 then
		if CheckBoss3Dead==1 then
			SDBOSS_CTRL_LUA_000003 = GetResString("SDBOSS_CTRL_LUA_000003")
			ScrollNotice ( SDBOSS_CTRL_LUA_000003,5)
			monster3 = CreateChaEx(1183, 92812, 5519, 175, 1000,map_copy)
			SetChaLifeTime(monster3,3600000)
			XmasMonsterNum3 = 0
			CheckBossLifeTime3 = 1
		else
			if CheckBossLifeTime3 > 3600 then
				SDBOSS_CTRL_LUA_000003 = GetResString("SDBOSS_CTRL_LUA_000003")
				ScrollNotice ( SDBOSS_CTRL_LUA_000003,5)
				monster3 = CreateChaEx(1183, 92812, 5519, 175, 1000,map_copy)
				SetChaLifeTime(monster3,3600000)
				XmasMonsterNum3 = 0
				CheckBossLifeTime3 = 1
			end
		end
	end
	if XmasMonsterNum4 >= 6000 then
		if CheckBoss4Dead==1 then
			SDBOSS_CTRL_LUA_000004 = GetResString("SDBOSS_CTRL_LUA_000004")
			ScrollNotice ( SDBOSS_CTRL_LUA_000004,5)
			monster4 = CreateChaEx(1182, 6312, 43019, 175, 1000,map_copy)
			SetChaLifeTime(monster4,3600000)
			XmasMonsterNum4 = 0
			CheckBossLifeTime4 = 1
		else
			if CheckBossLifeTime4 > 3600 then
				SDBOSS_CTRL_LUA_000004 = GetResString("SDBOSS_CTRL_LUA_000004")
				ScrollNotice ( SDBOSS_CTRL_LUA_000004,5)
				monster4 = CreateChaEx(1182, 6312, 43019, 175, 1000,map_copy)
				SetChaLifeTime(monster4,3600000)
				XmasMonsterNum4 = 0
				CheckBossLifeTime4 = 1
			end
		end
	end
	if XmasMonsterNum5 >= 8000 then
		if CheckBoss5Dead==1 then
			SDBOSS_CTRL_LUA_000005 = GetResString("SDBOSS_CTRL_LUA_000005")
			ScrollNotice ( SDBOSS_CTRL_LUA_000005,5)
			monster5 = CreateChaEx(1181, 49612, 43019, 175, 1000,map_copy)
			SetChaLifeTime(monster5,3600000)
			XmasMonsterNum5 = 0
			CheckBossLifeTime5 = 1
		else
			if CheckBossLifeTime5 > 3600 then
				SDBOSS_CTRL_LUA_000005 = GetResString("SDBOSS_CTRL_LUA_000005")
				ScrollNotice ( SDBOSS_CTRL_LUA_000005,5)
				monster5 = CreateChaEx(1181, 49612, 43019, 175, 1000,map_copy)
				SetChaLifeTime(monster5,3600000)
				XmasMonsterNum5 = 0
				CheckBossLifeTime5 = 1
			end
		end
	end
	CheckBoss1Dead	= CheckMonsterDead ( monster1 )
	CheckBoss2Dead	= CheckMonsterDead ( monster2 )
	CheckBoss3Dead	= CheckMonsterDead ( monster3 )
	CheckBoss4Dead	= CheckMonsterDead ( monster4 )
	CheckBoss5Dead	= CheckMonsterDead ( monster5 )
end

--地图关闭时执行
function map_copy_close_sdBoss( map_copy )
end
		
--地图开关判断——————————————————————————————————————————

function can_open_entry_sdBoss( map ) 
end 
