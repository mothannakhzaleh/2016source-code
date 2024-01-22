--------------------------------------------------------------------------
--									--
--									--
--				NPCScript02.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading NPCScript02.lua" )


------------------------------------------------------------
-- 通用传送脚本
------------------------------------------------------------

function GoToWhere()

	--取消传送返回选择传送地点的对话内容和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000001")
	local ReSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000001
	local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 3

	--地图名称信息
	local CurMapName1 = "garner"
	local CurMapName2 = "magicsea"
	local CurMapName3 = "eastgoaf"
	local CurMapName4 = "lonetower"
	local CurMapName5 = "darkblue"

	--白银之城坐标
	local GoTo01X = 2231
	local GoTo01Y = 2788
	local GoTo01M = CurMapName1

	--沙岚之城坐标
	local GoTo02X = 890
	local GoTo02Y = 3575
	local GoTo02M = CurMapName2

	--雷霆堡坐标
	local GoTo03X = 735
	local GoTo03Y = 1590
	local GoTo03M = CurMapName1

	--冰狼堡坐标
	local GoTo04X = 1318
	local GoTo04Y = 510
	local GoTo04M = CurMapName5

	--卡尔加德坐标
	local GoTo05X = 633
	local GoTo05Y = 2100
	local GoTo05M = CurMapName1

	--赖安森林坐标
	local GoTo06X = 1007
	local GoTo06Y = 2966
	local GoTo06M = CurMapName1

	--岛屿3号坐标
	local GoTo07X = 1507
	local GoTo07Y = 2039
	local GoTo07M = CurMapName1

	--岛屿8号坐标
	local GoTo08X = 1711
	local GoTo08Y = 3448
	local GoTo08M = CurMapName1

	--岛屿2号坐标
	local GoTo09X = 2501
	local GoTo09Y = 2997
	local GoTo09M = CurMapName1

	--岛屿5号坐标
	local GoTo10X = 3197
	local GoTo10Y = 1254
	local GoTo10M = CurMapName1
	
	--废矿补给站
	local GoTo11X = 1903
	local GoTo11Y = 2807
	local GoTo11M = CurMapName1

	--古里咯利补给站
	local GoTo12X = 1517
	local GoTo12Y = 3091
	local GoTo12M = CurMapName1

	--瓦尔诺补给站
	local GoTo13X = 1120
	local GoTo13Y = 2773
	local GoTo13M = CurMapName1

	--温拿补给站
	local GoTo14X = 535
	local GoTo14Y = 2433
	local GoTo14M = CurMapName1
	
	--沙泉补给站
	local GoTo15X = 787
	local GoTo15Y = 3121
	local GoTo15M = CurMapName2

	--巴布补给站
	local GoTo16X = 1214
	local GoTo16Y = 3203
	local GoTo16M = CurMapName2

	--冰都补给站
	local GoTo17X = 807
	local GoTo17Y = 360
	local GoTo17M = CurMapName5

	--阿兰比斯补给站
	local GoTo18X = 1050
	local GoTo18Y = 656
	local GoTo18M = CurMapName5

	--骷髅营地补给站
	local GoTo19X = 2146
	local GoTo19Y = 542
	local GoTo19M = CurMapName5

	MISSCRIPT_NPCSCRIPT02_LUA_000003 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000003")
	Talk( 1, MISSCRIPT_NPCSCRIPT02_LUA_000003 )
	Text ( 1, "Teleport to Dream City", JumpPage, 2)
	MISSCRIPT_NPCSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000004")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000004, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT02_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000005")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000005, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000006")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000006, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT02_LUA_000007 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000007")
	Text( 1,MISSCRIPT_NPCSCRIPT02_LUA_000007 , JumpPage, 10 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 29 )
	Text ( 1, "Nothing, just looking around",CloseTalk )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoToDream, "DreamIsland")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoToDream, "DreamIsland")
	TriggerFailure( 2, JumpPage, 28)
	Talk(2, "Teleport to Dream City! Please pay 2000g. Thank you. Lv40 and below newbie are free!")
	Text(2, "Teleport in Progress",MultiTrigger, GetMultiTrigger(), 2 )
	Text(2, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	Talk(3,"Welcome you to here again!")
		--Text( 1, "我去东部废矿！", JumpPage, 8 )
	--Text( 1, "我要去岛屿逛！", JumpPage, 3 )

	--MISSCRIPT_NPCSCRIPT02_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000009")
	--Talk( 2, MISSCRIPT_NPCSCRIPT02_LUA_000009, CloseTalk )

--	Talk( 3, "请问想去哪个岛屿逛逛呢？" )
--	Text( 3, "岛屿一号", JumpPage, 9 )
--	Text( 3, "岛屿二号", JumpPage, 10 )
--	Text( 3, "岛屿三号", JumpPage, 11 )
--	Text( 3, "岛屿四号", JumpPage, 12 )
--	Text( 3, "岛屿五号", JumpPage, 13 )
--	Text( 3, "随便去一个吧", JumpPage, 14 )

	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000010 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000010")
	Talk( 4, MISSCRIPT_NPCSCRIPT02_LUA_000010 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 4, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 4, CancelSelectTalk, JumpPage , CancelSelectPage )


	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2,  GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000011 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000011")
	Talk( 5, MISSCRIPT_NPCSCRIPT02_LUA_000011 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 5, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 5, CancelSelectTalk, JumpPage , CancelSelectPage )


	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo03X, GoTo03Y, GoTo03M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2,  GoTo, GoTo03X, GoTo03Y, GoTo03M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000012")
	Talk( 6, MISSCRIPT_NPCSCRIPT02_LUA_000012 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 6, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 )
	Text( 6, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000013 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000013")
	Talk( 7, MISSCRIPT_NPCSCRIPT02_LUA_000013 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 7, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 7, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000014 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000014")
	Talk( 8, MISSCRIPT_NPCSCRIPT02_LUA_000014 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 8, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 8, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo06X, GoTo06Y, GoTo06M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo06X, GoTo06Y, GoTo06M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000015")
	Talk( 9, MISSCRIPT_NPCSCRIPT02_LUA_000015 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 9, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 9, CancelSelectTalk, JumpPage , CancelSelectPage )

	MISSCRIPT_NPCSCRIPT02_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000016")
	Talk( 10,MISSCRIPT_NPCSCRIPT02_LUA_000016 )
	MISSCRIPT_NPCSCRIPT02_LUA_000017 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000017")
	Text( 10,MISSCRIPT_NPCSCRIPT02_LUA_000017, JumpPage,11 )
	MISSCRIPT_NPCSCRIPT02_LUA_000018 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000018")
	Text( 10,MISSCRIPT_NPCSCRIPT02_LUA_000018, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000019 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000019")
	Text( 10,MISSCRIPT_NPCSCRIPT02_LUA_000019, JumpPage, 12 )
	MISSCRIPT_NPCSCRIPT02_LUA_000020 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000020")
	Text( 10,MISSCRIPT_NPCSCRIPT02_LUA_000020, JumpPage, 13 )
	MISSCRIPT_NPCSCRIPT02_LUA_000021 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000021")
	Text( 10,MISSCRIPT_NPCSCRIPT02_LUA_000021, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000022 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000022")
	Text( 10,MISSCRIPT_NPCSCRIPT02_LUA_000022, JumpPage,14 )
	Text( 10, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo11X, GoTo11Y, GoTo11M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo11X, GoTo11Y, GoTo11M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000023 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000023")
	Talk( 11, MISSCRIPT_NPCSCRIPT02_LUA_000023 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 11, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 11, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo12X, GoTo12Y, GoTo12M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo12X, GoTo12Y, GoTo12M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000024 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000024")
	Talk( 12, MISSCRIPT_NPCSCRIPT02_LUA_000024 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 12, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 12, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo13X, GoTo13Y, GoTo13M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo13X, GoTo13Y, GoTo13M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000025 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000025")
	Talk( 13, MISSCRIPT_NPCSCRIPT02_LUA_000025 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 13, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 13, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo14X, GoTo14Y, GoTo14M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo14X, GoTo14Y, GoTo14M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000026 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000026")
	Talk( 14, MISSCRIPT_NPCSCRIPT02_LUA_000026 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 14, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 14, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000027 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000027")
	Talk( 15, MISSCRIPT_NPCSCRIPT02_LUA_000027 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 15, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 15, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo06X, GoTo06Y, GoTo06M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo06X, GoTo06Y, GoTo06M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000028 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000028")
	Talk( 16, MISSCRIPT_NPCSCRIPT02_LUA_000028 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 16, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 16, CancelSelectTalk, JumpPage , CancelSelectPage )

	
	MISSCRIPT_NPCSCRIPT02_LUA_000029 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000029")
	Talk( 18, MISSCRIPT_NPCSCRIPT02_LUA_000029 )
	Text ( 18, "Teleport to Dream City", JumpPage, 2)
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 18, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT02_LUA_000031 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000031")
	Text( 18,MISSCRIPT_NPCSCRIPT02_LUA_000031,JumpPage, 19)
	MISSCRIPT_NPCSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000006")
	Text( 18, MISSCRIPT_NPCSCRIPT02_LUA_000006, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 18, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 30 )

	
	MISSCRIPT_NPCSCRIPT02_LUA_000032 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000032")
	Talk( 19,MISSCRIPT_NPCSCRIPT02_LUA_000032 )
	MISSCRIPT_NPCSCRIPT02_LUA_000033 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000033")
	Text( 19,MISSCRIPT_NPCSCRIPT02_LUA_000033, JumpPage,20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000034 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000034")
	Text( 19,MISSCRIPT_NPCSCRIPT02_LUA_000034, JumpPage, 21 )
	Text( 19, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo15X, GoTo15Y, GoTo15M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo15X, GoTo15Y, GoTo15M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000035 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000035")
	Talk( 20, MISSCRIPT_NPCSCRIPT02_LUA_000035 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 20, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 20, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo16X, GoTo16Y, GoTo16M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo16X, GoTo16Y, GoTo16M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000036 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000036")
	Talk( 21, MISSCRIPT_NPCSCRIPT02_LUA_000036 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 21, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 21, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	

	MISSCRIPT_NPCSCRIPT02_LUA_000037 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000037")
	Talk( 22, MISSCRIPT_NPCSCRIPT02_LUA_000037 )
	Text ( 22, "Teleport to Dream City", JumpPage, 2)
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 22, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000004")
	Text( 22, MISSCRIPT_NPCSCRIPT02_LUA_000004, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000006")
	Text( 22, MISSCRIPT_NPCSCRIPT02_LUA_000006, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 22, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 31 )

	MISSCRIPT_NPCSCRIPT02_LUA_000038 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000038")
	Talk( 23, MISSCRIPT_NPCSCRIPT02_LUA_000038 )
	Text ( 23, "Teleport to Dream City", JumpPage, 2)
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 23, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000004")
	Text( 23, MISSCRIPT_NPCSCRIPT02_LUA_000004, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT02_LUA_000039 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000039")
	Text( 23, MISSCRIPT_NPCSCRIPT02_LUA_000039, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 23, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 32 )

	
	MISSCRIPT_NPCSCRIPT02_LUA_000040 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000040")
	Talk( 24, MISSCRIPT_NPCSCRIPT02_LUA_000040)
	Text ( 24, "Teleport to Dream City", JumpPage, 2)
	MISSCRIPT_NPCSCRIPT02_LUA_000041 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000041")
	Text( 24, MISSCRIPT_NPCSCRIPT02_LUA_000041, JumpPage, 25 )
	MISSCRIPT_NPCSCRIPT02_LUA_000042 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000042")
	Text( 24, MISSCRIPT_NPCSCRIPT02_LUA_000042, JumpPage,26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000043")
	Text( 24, MISSCRIPT_NPCSCRIPT02_LUA_000043, JumpPage, 27 )
	Text( 24, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo17X, GoTo17Y, GoTo17M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo17X, GoTo17Y, GoTo17M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000044")
	Talk( 25, MISSCRIPT_NPCSCRIPT02_LUA_000044 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 25, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 25, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo18X, GoTo18Y, GoTo18M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo18X, GoTo18Y, GoTo18M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000045")
	Talk( 26, MISSCRIPT_NPCSCRIPT02_LUA_000045 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 26, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 26, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo19X, GoTo19Y, GoTo19M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo19X, GoTo19Y, GoTo19M )
	TriggerFailure( 2, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000046")
	Talk( 27, MISSCRIPT_NPCSCRIPT02_LUA_000046 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 27, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 27, CancelSelectTalk, JumpPage , CancelSelectPage )


	MISSCRIPT_NPCSCRIPT02_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000047")
	Talk( 28, MISSCRIPT_NPCSCRIPT02_LUA_000047 )

	MISSCRIPT_NPCSCRIPT02_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000048")
	Talk( 29, MISSCRIPT_NPCSCRIPT02_LUA_000048 )
	BIRTH_BIRTH_CONF_LUA_000001 = GetResString("BIRTH_BIRTH_CONF_LUA_000001")
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 29, MISSCRIPT_NPCSCRIPT02_LUA_000049, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000001 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 29, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000051 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000051")
	Talk( 30, MISSCRIPT_NPCSCRIPT02_LUA_000051 )
	BIRTH_BIRTH_CONF_LUA_000003 = GetResString("BIRTH_BIRTH_CONF_LUA_000003")
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 30, MISSCRIPT_NPCSCRIPT02_LUA_000049, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000003 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 30, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000052 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000052")
	Talk( 31, MISSCRIPT_NPCSCRIPT02_LUA_000052 )
	BIRTH_BIRTH_CONF_LUA_000002 = GetResString("BIRTH_BIRTH_CONF_LUA_000002")
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 31, MISSCRIPT_NPCSCRIPT02_LUA_000049, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000002 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 31, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000053 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000053")
	Talk( 32, MISSCRIPT_NPCSCRIPT02_LUA_000053 )
	BIRTH_BIRTH_CONF_LUA_000004 = GetResString("BIRTH_BIRTH_CONF_LUA_000004")
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 32, MISSCRIPT_NPCSCRIPT02_LUA_000049, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000004 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 32, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	-- Talk( 33, "竞技管理员：你好，我是PK岛竞技管理员，你想去哪里呢？" )
	-- Text( 33, "我要回城！", JumpPage, 29 )
	-- Text( 33, "不，不用了",CloseTalk )
	
	-- InitTrigger()
	-- TriggerCondition( 1, HasMoney, 2000 )
	-- TriggerAction( 1, TakeMoney, 2000 )
	-- TriggerAction( 1, SetPkState, 0 )
	-- TriggerAction( 1, MoveCity, "" )
	-- TriggerFailure( 1, JumpPage, 30 )
	-- Talk( 34, "你想回城是吧，对于懦弱的逃跑者将予以扣除2000G的处罚，你还是坚持要走么？！" )
	-- Text( 34, "是的，我支付2000G现金让我走吧",MultiTrigger, GetMultiTrigger(), 1 ) 
	-- Text( 34, "不，我不走了" )

	-- Talk( 35, "想逃跑还没有现金？对不起，如果你不支付2000G费用的话，你只有在这里战斗到最后了。" )

	-- Talk( 36, "玛卡珊：要记录在卡尔加德补给站？对么？" )
	-- Text( 36, "是的，请记录吧", SetSpawnPos, "卡尔加德补给站" )
	-- Text( 36, "不，不用了",CloseTalk )

	-- Talk( 37, "温蒂：要记录在赖安森林补给站？对么？" )
	-- Text( 37, "是的，请记录吧", SetSpawnPos, "赖安森林补给站" )
	-- Text( 37, "不，不用了",CloseTalk )


	

	InitTrigger()

	TriggerCondition( 1, IsMapNpc, "garner", 0 )
	TriggerAction( 1, JumpPage, 1 )

	TriggerCondition( 2, IsMapNpc, "magicsea", 0 )
	TriggerAction( 2, JumpPage, 18 )

	TriggerCondition( 3, IsMapNpc, "garner", 43 )
	TriggerAction( 3, JumpPage, 22 )

	TriggerCondition( 4, IsMapNpc, "darkblue", 12 )
	TriggerAction( 4, JumpPage, 23 )

	-- TriggerCondition( 5, IsMapNpc, "darkblue", 15 )
	-- TriggerAction( 5, JumpPage, 28 )
	

	--TriggerCondition( 6, IsMapNpc, "garner", 55 )
	--TriggerAction( 6, JumpPage, 21 )

	--TriggerCondition( 7, IsMapNpc, "garner", 56 )
	--TriggerAction( 7, JumpPage, 22 )

	--TriggerCondition( 9, IsMapNpc, "加纳大陆", 8 )
	--TriggerAction( 9, JumpPage, 22 )

	--TriggerCondition( 10, IsMapNpc, "加纳大陆", 9 )
	--TriggerAction( 10, JumpPage, 22 )

	--TriggerCondition( 11, IsMapNpc, "加纳大陆", 27 )
	--TriggerAction( 11, JumpPage, 21 )

	Start( GetMultiTrigger(), 5 )

end




------------------------------------------------------------
-- 补给站传送脚本
------------------------------------------------------------

function transmittal()

	--取消传送返回选择传送地点的对话内容和页面编号
	--local ReSelectTalk = "我再考虑考虑..."
	--local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 27

	--地图名称信息
	local CurMapName1 = "garner"
	local CurMapName2 = "magicsea"
	local CurMapName3 = "eastgoaf"
	local CurMapName4 = "lonetower"
	local CurMapName5 = "darkblue"

	--废矿补给站
	local GoTo01X = 1903
	local GoTo01Y = 2807
	local GoTo01M = CurMapName1

	--古里咯利补给站
	local GoTo02X = 1517
	local GoTo02Y = 3091
	local GoTo02M = CurMapName1

	--瓦尔诺补给站
	local GoTo03X = 1120
	local GoTo03Y = 2773
	local GoTo03M = CurMapName1

	--温那补给站
	local GoTo04X = 535
	local GoTo04Y = 2433
	local GoTo04M = CurMapName1

	--卡尔加德坐标
	local GoTo05X = 633
	local GoTo05Y = 2100
	local GoTo05M = CurMapName1

	--赖安森林坐标
	local GoTo06X = 1007
	local GoTo06Y = 2966
	local GoTo06M = CurMapName1

	--沙泉补给站
	local GoTo07X = 787
	local GoTo07Y = 3121
	local GoTo07M = CurMapName2

	--巴布补给站
	local GoTo08X = 1214
	local GoTo08Y = 3203
	local GoTo08M = CurMapName2

	--冰都补给站
	local GoTo09X = 807
	local GoTo09Y = 360
	local GoTo09M = CurMapName5

	--阿兰比斯补给站
	local GoTo10X = 1050
	local GoTo10Y = 656
	local GoTo10M = CurMapName5

	--骷髅营地补给站
	local GoTo11X = 2146
	local GoTo11Y = 542
	local GoTo11M = CurMapName5

	--冰极补给站
	local GoTo12X = 2681
	local GoTo12Y = 647
	local GoTo12M = CurMapName5
	
	--白银之城坐标
	local GoTo13X = 2231
	local GoTo13Y = 2788
	local GoTo13M = CurMapName1
	
	--沙岚之城坐标
	local GoTo14X = 890
	local GoTo14Y = 3575
	local GoTo14M = CurMapName2
	
	--冰狼堡坐标
	local GoTo15X = 1318
	local GoTo15Y = 510
	local GoTo15M = CurMapName5
	

	MISSCRIPT_NPCSCRIPT02_LUA_000054 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000054")
	Talk( 1, MISSCRIPT_NPCSCRIPT02_LUA_000054 )
	MISSCRIPT_NPCSCRIPT02_LUA_000055 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000055")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000055, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000056")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000056, JumpPage , 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--废矿补给站
	
	MISSCRIPT_NPCSCRIPT02_LUA_000057 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000057")
	Talk( 2, MISSCRIPT_NPCSCRIPT02_LUA_000057 )
	MISSCRIPT_NPCSCRIPT02_LUA_000058 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000058")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000058, JumpPage, 13 )
	MISSCRIPT_NPCSCRIPT02_LUA_000059 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000059")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000059, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000056")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000056, JumpPage , 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--古里咯利补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000060")
	Talk( 3, MISSCRIPT_NPCSCRIPT02_LUA_000060 )
	MISSCRIPT_NPCSCRIPT02_LUA_000061 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000061")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000061, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000055 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000055")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000055, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000056")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000056, JumpPage , 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--赖安森林补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000062 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000062")
	Talk( 4, MISSCRIPT_NPCSCRIPT02_LUA_000062 )
	MISSCRIPT_NPCSCRIPT02_LUA_000063 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000063")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000063, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000059 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000059")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000059, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000056")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000056, JumpPage , 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--瓦尔诺补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000064 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000064")
	Talk( 5, MISSCRIPT_NPCSCRIPT02_LUA_000064 )
	MISSCRIPT_NPCSCRIPT02_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000065")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000065, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000061 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000061")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000061, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000056")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000056, JumpPage , 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--温拿补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000066")
	Talk( 6, MISSCRIPT_NPCSCRIPT02_LUA_000066 )
	MISSCRIPT_NPCSCRIPT02_LUA_000063 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000063")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000063, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000056")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000056, JumpPage , 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--卡尔加德补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000067 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000067")
	Talk( 7, MISSCRIPT_NPCSCRIPT02_LUA_000067 )
	MISSCRIPT_NPCSCRIPT02_LUA_000068 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000068")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000068, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000069 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000069")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000069, JumpPage , 30 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--沙泉补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000070 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000070")
	Talk( 8, MISSCRIPT_NPCSCRIPT02_LUA_000070 )
	MISSCRIPT_NPCSCRIPT02_LUA_000071 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000071")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000071, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000069 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000069")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000069, JumpPage , 30 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--巴布补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000072 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000072")
	Talk( 9, MISSCRIPT_NPCSCRIPT02_LUA_000072 )
	MISSCRIPT_NPCSCRIPT02_LUA_000073 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000073")
	Text( 9, MISSCRIPT_NPCSCRIPT02_LUA_000073, JumpPage, 22 )
	MISSCRIPT_NPCSCRIPT02_LUA_000074 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000074")
	Text( 9, MISSCRIPT_NPCSCRIPT02_LUA_000074, JumpPage , 31 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 9, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--冰都补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000075 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000075")
	Talk( 10, MISSCRIPT_NPCSCRIPT02_LUA_000075 )
	MISSCRIPT_NPCSCRIPT02_LUA_000076 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000076")
	Text( 10, MISSCRIPT_NPCSCRIPT02_LUA_000076, JumpPage, 23 )
	MISSCRIPT_NPCSCRIPT02_LUA_000077 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000077")
	Text( 10, MISSCRIPT_NPCSCRIPT02_LUA_000077, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000074 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000074")
	Text( 10, MISSCRIPT_NPCSCRIPT02_LUA_000074, JumpPage , 31 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 10, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--阿兰比斯补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000078 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000078")
	Talk( 11, MISSCRIPT_NPCSCRIPT02_LUA_000078 )
	MISSCRIPT_NPCSCRIPT02_LUA_000079 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000079")
	Text( 11, MISSCRIPT_NPCSCRIPT02_LUA_000079, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT02_LUA_000080 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000080")
	Text( 11, MISSCRIPT_NPCSCRIPT02_LUA_000080, JumpPage, 22 )
	MISSCRIPT_NPCSCRIPT02_LUA_000074 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000074")
	Text( 11, MISSCRIPT_NPCSCRIPT02_LUA_000074, JumpPage , 31 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 11, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--骷髅营地补给站

	MISSCRIPT_NPCSCRIPT02_LUA_000081 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000081")
	Talk( 12, MISSCRIPT_NPCSCRIPT02_LUA_000081 )
	MISSCRIPT_NPCSCRIPT02_LUA_000076 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000076")
	Text( 12, MISSCRIPT_NPCSCRIPT02_LUA_000076, JumpPage, 23 )
	MISSCRIPT_NPCSCRIPT02_LUA_000074 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000074")
	Text( 12, MISSCRIPT_NPCSCRIPT02_LUA_000074, JumpPage , 31 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 12, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--冰极补给站
	
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000082 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000082")
	Talk( 13, MISSCRIPT_NPCSCRIPT02_LUA_000082 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 13, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 13, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000083 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000083")
	Talk( 14, MISSCRIPT_NPCSCRIPT02_LUA_000083 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 14, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 14, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo03X, GoTo03Y, GoTo03M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo03X, GoTo03Y, GoTo03M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000084 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000084")
	Talk( 15, MISSCRIPT_NPCSCRIPT02_LUA_000084 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 15, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 15, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000085 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000085")
	Talk( 16, MISSCRIPT_NPCSCRIPT02_LUA_000085 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 16, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 16, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000086 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000086")
	Talk( 17, MISSCRIPT_NPCSCRIPT02_LUA_000086 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 17, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 17, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo06X, GoTo06Y, GoTo06M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo06X, GoTo06Y, GoTo06M  )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000087 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000087")
	Talk( 18, MISSCRIPT_NPCSCRIPT02_LUA_000087 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 18, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 18, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo07X, GoTo07Y, GoTo07M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo07X, GoTo07Y, GoTo07M )	
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000088 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000088")
	Talk( 19, MISSCRIPT_NPCSCRIPT02_LUA_000088 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 19, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 19, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo08X, GoTo08Y, GoTo08M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, 
	GoTo08X, GoTo08Y, GoTo08M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000089 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000089")
	Talk( 20, MISSCRIPT_NPCSCRIPT02_LUA_000089 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 20, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 20, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo09X, GoTo09Y, GoTo09M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo09X, GoTo09Y, GoTo09M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000090 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000090")
	Talk( 21, MISSCRIPT_NPCSCRIPT02_LUA_000090 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 21, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 21, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo10X, GoTo10Y, GoTo10M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo10X, GoTo10Y, GoTo10M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000091 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000091")
	Talk( 22, MISSCRIPT_NPCSCRIPT02_LUA_000091 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 22, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 22, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo11X, GoTo11Y, GoTo11M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo11X, GoTo11Y, GoTo11M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000092 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000092")
	Talk( 23, MISSCRIPT_NPCSCRIPT02_LUA_000092 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 23, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 23, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, GoTo, GoTo12X, GoTo12Y, GoTo12M )
	TriggerCondition( 2, LvCheck, "<", 40 )
	TriggerAction( 2, GoTo, GoTo12X, GoTo12Y, GoTo12M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000093 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000093")
	Talk( 24, MISSCRIPT_NPCSCRIPT02_LUA_000093 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 24, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 24, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, IsMapNpc, "garner", 96 )
	BIRTH_BIRTH_CONF_LUA_000008 = GetResString("BIRTH_BIRTH_CONF_LUA_000008")
	TriggerAction( 1, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000008)
	TriggerCondition( 2, IsMapNpc, "garner", 94 )
	BIRTH_BIRTH_CONF_LUA_000009 = GetResString("BIRTH_BIRTH_CONF_LUA_000009")
	TriggerAction( 2, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000009)
	TriggerCondition( 3, IsMapNpc, "garner", 95 )
	BIRTH_BIRTH_CONF_LUA_000010 = GetResString("BIRTH_BIRTH_CONF_LUA_000010")
	TriggerAction( 3, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000010)
	TriggerCondition( 4, IsMapNpc, "garner", 97 )
	BIRTH_BIRTH_CONF_LUA_000011 = GetResString("BIRTH_BIRTH_CONF_LUA_000011")
	TriggerAction( 4, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000011)
	TriggerCondition( 5, IsMapNpc, "garner", 55 )
	BIRTH_BIRTH_CONF_LUA_000006 = GetResString("BIRTH_BIRTH_CONF_LUA_000006")
	TriggerAction( 5, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000006)
	TriggerCondition( 6, IsMapNpc, "garner", 56 )
	BIRTH_BIRTH_CONF_LUA_000007 = GetResString("BIRTH_BIRTH_CONF_LUA_000007")
	TriggerAction( 6, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000007)
	TriggerCondition( 7, IsMapNpc, "magicsea", 50 )
	BIRTH_BIRTH_CONF_LUA_000012 = GetResString("BIRTH_BIRTH_CONF_LUA_000012")
	TriggerAction( 7, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000012)
	TriggerCondition( 8, IsMapNpc, "magicsea", 46 )
	BIRTH_BIRTH_CONF_LUA_000013 = GetResString("BIRTH_BIRTH_CONF_LUA_000013")
	TriggerAction( 8, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000013)
	TriggerCondition( 9, IsMapNpc, "darkblue", 56 )
	BIRTH_BIRTH_CONF_LUA_000014 = GetResString("BIRTH_BIRTH_CONF_LUA_000014")
	TriggerAction( 9, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000014)
	TriggerCondition( 10, IsMapNpc, "darkblue", 42 )
	BIRTH_BIRTH_CONF_LUA_000015 = GetResString("BIRTH_BIRTH_CONF_LUA_000015")
	TriggerAction( 10, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000015)
	TriggerCondition( 11, IsMapNpc, "darkblue", 46 )
	BIRTH_BIRTH_CONF_LUA_000016 = GetResString("BIRTH_BIRTH_CONF_LUA_000016")
	TriggerAction( 11, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000016)
	TriggerCondition( 12, IsMapNpc, "darkblue", 51 )
	BIRTH_BIRTH_CONF_LUA_000017 = GetResString("BIRTH_BIRTH_CONF_LUA_000017")
	TriggerAction( 12, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000017)
	TriggerFailure( 12, JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT02_LUA_000094 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000094")
	Talk( 25, MISSCRIPT_NPCSCRIPT02_LUA_000094 )
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 25, MISSCRIPT_NPCSCRIPT02_LUA_000049, MultiTrigger, GetMultiTrigger(), 12 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 25, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000047")
	Talk( 26, MISSCRIPT_NPCSCRIPT02_LUA_000047 )

	MISSCRIPT_NPCSCRIPT02_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000009")
	Talk( 27, MISSCRIPT_NPCSCRIPT02_LUA_000009, CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000095 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000095")
	Talk( 28, MISSCRIPT_NPCSCRIPT02_LUA_000095, CloseTalk )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo13X, GoTo13Y, GoTo13M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo13X, GoTo13Y, GoTo13M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000096 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000096")
	Talk( 29, MISSCRIPT_NPCSCRIPT02_LUA_000096 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 29, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 29, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo14X, GoTo14Y, GoTo14M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo14X, GoTo14Y, GoTo14M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000097 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000097")
	Talk( 30, MISSCRIPT_NPCSCRIPT02_LUA_000097 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 30, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 30, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, GoTo15X, GoTo15Y, GoTo15M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo15X, GoTo15Y, GoTo15M )
	TriggerFailure( 2, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000013 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000013")
	Talk( 31, MISSCRIPT_NPCSCRIPT02_LUA_000013 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 31, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 31, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	
	
	InitTrigger()
	TriggerCondition( 1, IsMapNpc, "garner", 96 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, IsMapNpc, "garner", 94 )
	TriggerAction( 2, JumpPage, 2 )
	TriggerCondition( 3, IsMapNpc, "garner", 95 )
	TriggerAction( 3, JumpPage, 4 )
	TriggerCondition( 4, IsMapNpc, "garner", 97 )
	TriggerAction( 4, JumpPage, 5 )
	TriggerCondition( 5, IsMapNpc, "garner", 55 )
	TriggerAction( 5, JumpPage, 6 )
	TriggerCondition( 6, IsMapNpc, "garner", 56 )
	TriggerAction( 6, JumpPage, 3 )
	TriggerCondition( 7, IsMapNpc, "magicsea", 50 )
	TriggerAction( 7, JumpPage, 7 )
	TriggerCondition( 8, IsMapNpc, "magicsea", 46 )
	TriggerAction( 8, JumpPage, 8 )
	TriggerCondition( 9, IsMapNpc, "darkblue", 56 )
	TriggerAction( 9, JumpPage, 9 )
	TriggerCondition( 10, IsMapNpc, "darkblue", 42 )
	TriggerAction( 10, JumpPage, 10 )
	TriggerCondition( 11, IsMapNpc, "darkblue", 46 )
	TriggerAction( 11, JumpPage, 11 )
	TriggerCondition( 12, IsMapNpc, "darkblue", 51 )
	TriggerAction( 12, JumpPage, 12 )
	Start( GetMultiTrigger(), 12 )

end



------------------------------------------------------------
-- 岛屿传送脚本
------------------------------------------------------------

function island()

	--取消传送返回选择传送地点的对话内容和页面编号
	--local ReSelectTalk = "我再考虑考虑..."
	--local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 27

	--地图名称信息
	local CurMapName1 = "garner"
	local CurMapName2 = "magicsea"
	local CurMapName3 = "eastgoaf"
	local CurMapName4 = "lonetower"
	local CurMapName5 = "darkblue"
	local CurMapName6 = "PKmap"
	--海风岛
	local GoTo01X = 3260
	local GoTo01Y = 3280
	local GoTo01M = CurMapName1

	--碎冰岛
	local GoTo02X = 2273
	local GoTo02Y = 1122
	local GoTo02M = CurMapName1

	--雪贼岛
	local GoTo03X = 3590
	local GoTo03Y = 755
	local GoTo03M = CurMapName1

	--冰雪岛
	local GoTo04X = 2376
	local GoTo04Y = 725
	local GoTo04M = CurMapName2

	--鸣沙岛
	local GoTo05X = 1730
	local GoTo05Y = 3775
	local GoTo05M = CurMapName2

	--真爱岛
	local GoTo06X = 2529
	local GoTo06Y = 2406
	local GoTo06M = CurMapName2

	--好运岛
	local GoTo07X = 1631
	local GoTo07Y = 1974
	local GoTo07M = CurMapName5

	--白银城
	local GoTo08X = 2231
	local GoTo08Y = 2788
	local GoTo08M = CurMapName1

    --PKMap
	local GoTo09X = 64
	local GoTo09Y = 43
	local GoTo09M = CurMapName6	
	
	
	MISSCRIPT_NPCSCRIPT02_LUA_000098 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000098")
	Talk( 1, MISSCRIPT_NPCSCRIPT02_LUA_000098 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	Text( 1, "Go to PKMap", JumpPage, 29 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--白银城
	
	MISSCRIPT_NPCSCRIPT02_LUA_000106 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000106")
	Talk( 2, MISSCRIPT_NPCSCRIPT02_LUA_000106 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 2, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )		--海风岛

	MISSCRIPT_NPCSCRIPT02_LUA_000107 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000107")
	Talk( 3, MISSCRIPT_NPCSCRIPT02_LUA_000107 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 3, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )	--碎冰岛

	MISSCRIPT_NPCSCRIPT02_LUA_000108 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000108")
	Talk( 4, MISSCRIPT_NPCSCRIPT02_LUA_000108 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 4, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )          ---雪贼岛

	MISSCRIPT_NPCSCRIPT02_LUA_000109 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000109")
	Talk( 5, MISSCRIPT_NPCSCRIPT02_LUA_000109 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )          ---冰雪岛

	MISSCRIPT_NPCSCRIPT02_LUA_000110 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000110")
	Talk( 6, MISSCRIPT_NPCSCRIPT02_LUA_000110 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 6, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )          ---鸣沙岛

	MISSCRIPT_NPCSCRIPT02_LUA_000111 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000111")
	Talk( 7, MISSCRIPT_NPCSCRIPT02_LUA_000111 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000105")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000105, JumpPage, 20 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 7, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )          ---真爱岛

	MISSCRIPT_NPCSCRIPT02_LUA_000112 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000112")
	Talk( 8, MISSCRIPT_NPCSCRIPT02_LUA_000112 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000099")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000099, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000100")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000100, JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000101")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000101, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000102")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000102, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000103")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000103, JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000104")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000104, JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 8, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 25 )          ---好运岛

	Talk( 9, "Niecy: Hi, I am the island teleporter! How can I help you?" )
	Text( 9, "Go to Argent City!", JumpPage, 21 )
	Text( 9, "Go to Glacier Isle!", JumpPage, 15 )
	Text( 9, "Go to Outlaw Isle!", JumpPage, 16 )
	Text( 9, "Go to Isle of Chill!", JumpPage, 17 )
	Text( 9, "Go to Canary Isle!", JumpPage, 18 )
	Text( 9, "Go to Cupid Isle!", JumpPage, 19 )
	Text( 9, "Go to Isle of Fortune!", JumpPage, 20 )
	Text( 9, "Record Spawn point", JumpPage, 25 )          ---PKMap


	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000113 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000113")
	Talk( 14, MISSCRIPT_NPCSCRIPT02_LUA_000113 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 14, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 14, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000114 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000114")
	Talk( 15, MISSCRIPT_NPCSCRIPT02_LUA_000114 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 15, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 15, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo03X, GoTo03Y, GoTo03M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000115 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000115")
	Talk( 16, MISSCRIPT_NPCSCRIPT02_LUA_000115 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 16, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 16, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000116 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000116")
	Talk( 17, MISSCRIPT_NPCSCRIPT02_LUA_000116 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 17, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 17, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo05X, GoTo05Y, GoTo05M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000117 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000117")
	Talk( 18, MISSCRIPT_NPCSCRIPT02_LUA_000117 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 18, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 18, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo06X, GoTo06Y, GoTo06M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000118 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000118")
	Talk( 19, MISSCRIPT_NPCSCRIPT02_LUA_000118 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 19, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 19, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo07X, GoTo07Y, GoTo07M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000119 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000119")
	Talk( 20, MISSCRIPT_NPCSCRIPT02_LUA_000119 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 20, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 20, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, GoTo08X, GoTo08Y, GoTo08M )
	TriggerFailure( 1, JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT02_LUA_000120 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000120")
	Talk( 21, MISSCRIPT_NPCSCRIPT02_LUA_000120 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 21, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 21, CancelSelectTalk, JumpPage , CancelSelectPage )

	InitTrigger()                                ---PKMap
	TriggerCondition( 1, HasMoney, 5000 )
	TriggerAction( 1, TakeMoney, 5000 )
	TriggerAction( 1, GoTo, GoTo09X, GoTo09Y, GoTo09M )
	TriggerFailure( 1, JumpPage, 26 )
	Talk( 29, "PKMap? No problem, just give me 5000 Gold, thank you!" )
	Text( 29, "Teleport",MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 29, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	InitTrigger()
	TriggerCondition( 1, IsMapNpc, "garner", 123 )
	BIRTH_BIRTH_CONF_LUA_000001 = GetResString("BIRTH_BIRTH_CONF_LUA_000001")
	TriggerAction( 1, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000001)
	TriggerCondition( 2, IsMapNpc, "garner", 124 )
	BIRTH_BIRTH_CONF_LUA_000018 = GetResString("BIRTH_BIRTH_CONF_LUA_000018")
	TriggerAction( 2, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000018)
	TriggerCondition( 3, IsMapNpc, "garner", 125 )
	BIRTH_BIRTH_CONF_LUA_000019 = GetResString("BIRTH_BIRTH_CONF_LUA_000019")
	TriggerAction( 3, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000019)
	TriggerCondition( 4, IsMapNpc, "garner", 126 )
	BIRTH_BIRTH_CONF_LUA_000020 = GetResString("BIRTH_BIRTH_CONF_LUA_000020")
	TriggerAction( 4, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000020)
	TriggerCondition( 5, IsMapNpc, "magicsea", 69 )
	BIRTH_BIRTH_CONF_LUA_000021 = GetResString("BIRTH_BIRTH_CONF_LUA_000021")
	TriggerAction( 5, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000021)
	TriggerCondition( 6, IsMapNpc, "magicsea", 70)
	BIRTH_BIRTH_CONF_LUA_000022 = GetResString("BIRTH_BIRTH_CONF_LUA_000022")
	TriggerAction( 6, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000022)
	TriggerCondition( 7, IsMapNpc, "magicsea", 71 )
	BIRTH_BIRTH_CONF_LUA_000023 = GetResString("BIRTH_BIRTH_CONF_LUA_000023")
	TriggerAction( 7, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000023)
	TriggerCondition( 8, IsMapNpc, "darkblue", 65 )
	BIRTH_BIRTH_CONF_LUA_000024 = GetResString("BIRTH_BIRTH_CONF_LUA_000024")
	TriggerAction( 8, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000024)
	TriggerCondition( 9, IsMapNpc, "PKmap", 0 )
	TriggerAction( 9, SetSpawnPos, "PKmap")
	TriggerFailure( 9, JumpPage, 28 )
	
	MISSCRIPT_NPCSCRIPT02_LUA_000094 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000094")
	Talk( 25, MISSCRIPT_NPCSCRIPT02_LUA_000094 )
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 25, MISSCRIPT_NPCSCRIPT02_LUA_000049, MultiTrigger, GetMultiTrigger(), 8 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 25, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000047")
	Talk( 26, MISSCRIPT_NPCSCRIPT02_LUA_000047 )

	MISSCRIPT_NPCSCRIPT02_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000009")
	Talk( 27, MISSCRIPT_NPCSCRIPT02_LUA_000009, CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000095 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000095")
	Talk( 28, MISSCRIPT_NPCSCRIPT02_LUA_000095, CloseTalk )

	InitTrigger()
	TriggerCondition( 1, IsMapNpc, "garner", 123 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, IsMapNpc, "garner", 124 )
	TriggerAction( 2, JumpPage, 2 )
	TriggerCondition( 3, IsMapNpc, "garner", 125 )
	TriggerAction( 3, JumpPage, 3 )
	TriggerCondition( 4, IsMapNpc, "garner", 126 )
	TriggerAction( 4, JumpPage, 4 )
	TriggerCondition( 5, IsMapNpc, "magicsea", 69 )
	TriggerAction( 5, JumpPage, 5)
	TriggerCondition( 6, IsMapNpc, "magicsea", 70)
	TriggerAction( 6, JumpPage, 6 )
	TriggerCondition( 7, IsMapNpc, "magicsea", 71 )
	TriggerAction( 7, JumpPage, 7)
	TriggerCondition( 8, IsMapNpc, "darkblue", 65 )
	TriggerAction( 8, JumpPage, 8 )
	TriggerCondition( 9, IsMapNpc, "PKmap", 0 )
	TriggerAction( 9, JumpPage, 9)
    Start( GetMultiTrigger(), 9 )
end
