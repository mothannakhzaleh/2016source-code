--此文件在GameServer全部地图初始化完成后, 执行一次


function PM(monster)
    local filename = "script/monster/"..monster..".lua"
    MONSTER_MLIST_LUA_000001 = GetResString("MONSTER_MLIST_LUA_000001")
    LG("init", MONSTER_MLIST_LUA_000001, filename)
    dofile(GetResPath(filename))
end

local m = SetCurMap("garner")

if m==1 then --如果此服务器上地图存在
    local Now_Day = os.date("%d")
	local Now_Month = os.date("%m")
	local Now_Time = os.date("%H")
	local Now_Year = os.date("%y")
	local NowTimeNum = tonumber(Now_Time)
	local NowDayNum = tonumber(Now_Day)
	local NowMonthNum = tonumber(Now_Month)
	local NowYearNum = tonumber(Now_Year)
	local CheckDateNum = NowYearNum * 1000000 + NowMonthNum * 10000 + NowDayNum * 100 + NowTimeNum
	
    PM("baiyinlinqu")
    PM("lietinglinqu")
    PM("baiyinyuchang")
    PM("jianazuixiayuchang")
    PM("haifengyuchang")
    PM("jianayunshi")
    PM("bycduizhang")
    PM("bycdaoguai")
	
--	if CheckDateNum >= 8122200  then
--		if CheckDateNum <= 9010923 then
--			PM("baiyinhuoji")
--			PM("baiyinxieemilu")
--			PM("xuerenbaiyin")
--		end
--	end
--    PM("baiyinhuoji")
--    PM("baiyinxieemilu")
--    PM("xuerenbaiyin")

    MONSTER_MLIST_LUA_000002 = GetResString("MONSTER_MLIST_LUA_000002")
    LG("init", MONSTER_MLIST_LUA_000002)
end


m = SetCurMap("magicsea")
if m==1 then --如果此服务器上地图存在
    local Now_Day = os.date("%d")
	local Now_Month = os.date("%m")
	local Now_Time = os.date("%H")
	local Now_Year = os.date("%y")
	local NowTimeNum = tonumber(Now_Time)
	local NowDayNum = tonumber(Now_Day)
	local NowMonthNum = tonumber(Now_Month)
	local NowYearNum = tonumber(Now_Year)
	local CheckDateNum = NowYearNum * 1000000 + NowMonthNum * 10000 + NowDayNum * 100 + NowTimeNum
	
	PM("monvzhihaimeirenyuwang")

    PM("mingshapaota")
    PM("monv480")
    PM("shalanyuchang")
    PM("mingshayuchang")
    PM("shalanlinqu")
    PM("shalanmingshaxian")
    PM("shaxie")
    PM("shalanyunshi")
    PM("slcdaoguai")
    PM("slcduizhang")
    PM("WriteSheepKiper")
    PM("JinNiuKiper")
    PM("ShuangZiKiper")
    PM("juxieKiper")
--	if CheckDateNum >= 8122200  then
--		if CheckDateNum <= 9010923 then
--			PM("shalanhuoji")
--			PM("shalanxieemilu")
--			PM("xuerenshalan")
--		end
--	end
		-- PM("shalanhuoji")
		-- PM("shalanxieemilu")
		-- PM("xuerenshalan")
		-- PM("huojishalan")   

    MONSTER_MLIST_LUA_000003 = GetResString("MONSTER_MLIST_LUA_000003")
    LG("init", MONSTER_MLIST_LUA_000003)
end

m = SetCurMap("darkblue")
if m==1 then --如果此服务器上地图存在
    local Now_Day = os.date("%d")
	local Now_Month = os.date("%m")
	local Now_Time = os.date("%H")
	local Now_Year = os.date("%y")
	local NowTimeNum = tonumber(Now_Time)
	local NowDayNum = tonumber(Now_Day)
	local NowMonthNum = tonumber(Now_Month)
	local NowYearNum = tonumber(Now_Year)
	local CheckDateNum = NowYearNum * 1000000 + NowMonthNum * 10000 + NowDayNum * 100 + NowTimeNum
	
    PM("binglanglinqu")
    PM("binglangyuchang")
    PM("binglangyunshi")
    PM("chundaoguai")
    PM("qiudaoguai")
    PM("xiadaoguai")
    PM("blbdaoguai")
    PM("blbduizhang")
   -- PM("qiuxiang")
--    PM("binglanghuoji")
--    PM("binglangxieemilu")
--    PM("xuerenbinglang")
--	if CheckDateNum >= 8122200  then
--		if CheckDateNum <= 9010923 then
--			PM("binglanghuoji")
--			PM("binglangxieemilu")
--			PM("xuerenbinglang")
--		end
--	end
    MONSTER_MLIST_LUA_000004 = GetResString("MONSTER_MLIST_LUA_000004")
    LG("init", MONSTER_MLIST_LUA_000004)
end

m = SetCurMap("lonetower")
if m==1 then --如果此服务器上地图存在

    PM("jimozhita")

    MONSTER_MLIST_LUA_000005 = GetResString("MONSTER_MLIST_LUA_000005")
    LG("init", MONSTER_MLIST_LUA_000005)
end

m = SetCurMap("secretgarden")
if m==1 then --如果此服务器上地图存在

    PM("HY_RedSide")

    MONSTER_MLIST_LUA_000006 = GetResString("MONSTER_MLIST_LUA_000006")
    LG("init" , MONSTER_MLIST_LUA_000006)
end

m = SetCurMap("secretgarden")
if m==1 then --如果此服务器上地图存在

    PM("HY_BlueSide")

    MONSTER_MLIST_LUA_000007 = GetResString("MONSTER_MLIST_LUA_000007")
    LG("init" , MONSTER_MLIST_LUA_000007)
end

m = SetCurMap("secretgarden")
if m==1 then --如果此服务器上地图存在

    PM("PK_Monsters")

    MONSTER_MLIST_LUA_000008 = GetResString("MONSTER_MLIST_LUA_000008")
    LG("init" , MONSTER_MLIST_LUA_000008)
end

m = SetCurMap("eastgoaf")
if m==1 then --如果此服务器上地图存在
    PM("haidisuidao")
    PM("xiashuidao")
    PM("heilong1")
    PM("heilong2")
    MONSTER_MLIST_LUA_000009 = GetResString("MONSTER_MLIST_LUA_000009")
    LG("init", MONSTER_MLIST_LUA_000009)
end

m = SetCurMap("guildwar")
if m==1 then --如果此服务器上地图存在
    PM("haidaohaijun_side")
    
    MONSTER_MLIST_LUA_000010 = GetResString("MONSTER_MLIST_LUA_000010")
    LG("init", MONSTER_MLIST_LUA_000010)
end


m = SetCurMap("guildwar2")
if m==1 then --如果此服务器上地图存在
    PM("haidaohaijun_side2")
    
    MONSTER_MLIST_LUA_000011 = GetResString("MONSTER_MLIST_LUA_000011")
    LG("init", MONSTER_MLIST_LUA_000011)
end

m = SetCurMap("guildwar")
if m==1 then --如果此服务器上地图存在
    PM("yeguai_guildwar")
    
    MONSTER_MLIST_LUA_000012 = GetResString("MONSTER_MLIST_LUA_000012")
    LG("init", MONSTER_MLIST_LUA_000012)
end

m = SetCurMap("guildwar2")
if m==1 then --如果此服务器上地图存在
    PM("yeguai_guildwar2")
    
    MONSTER_MLIST_LUA_000013 = GetResString("MONSTER_MLIST_LUA_000013")
    LG("init", MONSTER_MLIST_LUA_000013)
end

m = SetCurMap("07xmas2")
if m==1 then --如果此服务器上地图存在
    PM("xieeshengdan")
    
    MONSTER_MLIST_LUA_000014 = GetResString("MONSTER_MLIST_LUA_000014")
    LG("init", MONSTER_MLIST_LUA_000014)
end

m = SetCurMap("sdBoss")
if m==1 then --如果此服务器上地图存在
    
    PM("sd_jingjichang")
    

    MONSTER_MLIST_LUA_000015 = GetResString("MONSTER_MLIST_LUA_000015")
    LG("init", MONSTER_MLIST_LUA_000015)
end
