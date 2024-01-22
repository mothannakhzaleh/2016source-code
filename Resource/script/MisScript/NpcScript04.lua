--------------------------------------------------------------------------
--									--
--									--
--				NPCScript04.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading NPCScript04.lua" )


jp= JumpPage
amp=AutoMissionPage
ct=CloseTalk
am=AddMission
MissionCheck = HasFlag
mc=MissionCheck


------------------------------------------------------------
-- 春风镇 铁匠·武鑫
------------------------------------------------------------

function b_talk1()


	MISSCRIPT_NPCSCRIPT04_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000001")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000001 )
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT01_LUA_000014 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000014")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000014, OpenRepair)
	MISSCRIPT_NPCSCRIPT01_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000015")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000015, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT01_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000016")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000016, JumpPage, 3)

	MISSCRIPT_NPCSCRIPT04_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000002")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000002 )

	MISSCRIPT_NPCSCRIPT04_LUA_000003 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000003")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000003 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000004")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000004 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 4 )
	Start( GetMultiTrigger(), 2 )


	InitTrade()
	Weapon(	0023	)
	Weapon(	1399	)
	Weapon(	0021	)
	Weapon(	1378	)
	Weapon(	1387	)
	Weapon(	0084	)
	Weapon(	1426	)
	Weapon(	1461	)
	Weapon(	0108	)
	Weapon(	4302	)
	Weapon(	1438	)
	Weapon(	1441	)
	Weapon(	1473	)
	Weapon(	1476	)
	Weapon(	0045	)
	Weapon(	1414	)


	AddNpcMission ( 393 )
        AddNpcMission ( 567 )

	-------------铁匠·武鑫-------巨蟹
	AddNpcMission	(5817)
	AddNpcMission	(5818)
end


------------------------------------------------------------
-- 春风镇 客栈老板·龙女（卖回复品)
------------------------------------------------------------

function b_talk2()


	MISSCRIPT_NPCSCRIPT04_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000005")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000005)
	--Text( 1, "交易", BuyPage )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000006")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000006 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )


   	InitTrade()
	Other(	1078	)
	Other(	1079	)
	Other(	1080	)
	Other(	1082	)  
	Other(	1083	)

	AddNpcMission ( 394 )
	AddNpcMission ( 536 )
	AddNpcMission ( 537 )
	AddNpcMission ( 538 )
        AddNpcMission ( 569 )


	-------------客栈老板·龙女-------巨蟹
	AddNpcMission	(5819)
	AddNpcMission	(5820)
-------------客栈老板·龙女-------秋岛开发
	--AddNpcMission	(6174)
	--AddNpcMission	(6175)

end

------------------------------------------------------------
-- 春风镇 杂货商人·鲁娜儿(卖飞机票)
------------------------------------------------------------

function b_talk3()


	MISSCRIPT_NPCSCRIPT04_LUA_000007 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000007")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000007 )
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT04_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000008")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000008 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )



	InitTrade()
	Other(	3141	)
	Other(	4602	)
	Other(	4603	)
	Other(	4604	)

	AddNpcMission ( 395 )
	AddNpcMission ( 517 )
	AddNpcMission ( 519 )
	AddNpcMission ( 525 )
	AddNpcMission ( 526 )
	--AddNpcMission ( 535 )
        AddNpcMission ( 564 )

	-------------杂货商人·鲁娜儿-------巨蟹
	AddNpcMission	(5821)
	AddNpcMission	(5822)


end

------------------------------------------------------------
-- 春风镇 贸易商人·油李（航海贸易品
------------------------------------------------------------

function b_talk4()


	MISSCRIPT_NPCSCRIPT04_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000009")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000009 )
	--Text( 1, "交易", BuyPage )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 13 )
	TriggerAction( 1, TradeBerthList, 13 )
	TriggerFailure( 1, JumpPage, 2 )
	--Text( 1, "货物交易", MultiTrigger, GetMultiTrigger(), 1 )
	--Text( 1, "关于获得贸易证",JumpPage, 3)
	
	MISSCRIPT_NPCSCRIPT04_LUA_000010 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000010")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000010 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000003 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000003")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000003)
	MISSCRIPT_NPCSCRIPT03_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000004")
	Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000004,JumpPage, 7)
	MISSCRIPT_NPCSCRIPT03_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000005")
	Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000005,JumpPage, 4)
	MISSCRIPT_NPCSCRIPT03_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000006")
	Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000006,JumpPage, 5)
	MISSCRIPT_NPCSCRIPT03_LUA_000007 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000007")
	Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000007,JumpPage, 6)
	

	MISSCRIPT_NPCSCRIPT03_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000008")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000008)
	MISSCRIPT_NPCSCRIPT03_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000009")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000009)
	MISSCRIPT_NPCSCRIPT03_LUA_000010 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000010")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000010)
	MISSCRIPT_NPCSCRIPT03_LUA_000011 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000011")
	Talk( 7, MISSCRIPT_NPCSCRIPT03_LUA_000011)
	MISSCRIPT_NPCSCRIPT04_LUA_000011 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000011")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000011 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 8 )
	Start( GetMultiTrigger(), 2 )


	InitGoods()
	SaleGoodsData(	0	,	4573	,	900	,	279	,	62	)
	SaleGoodsData(	0	,	4574	,	800	,	342	,	76	)
	SaleGoodsData(	1	,	4575	,	700	,	391	,	87	)
	SaleGoodsData(	1	,	4576	,	480	,	432	,	96	)
	SaleGoodsData(	2	,	4577	,	300	,	495	,	110	)
	SaleGoodsData(	2	,	4578	,	240	,	522	,	116	)
	SaleGoodsData(	3	,	4579	,	60	,	589	,	131	)
	SaleGoodsData(	3	,	4580	,	40	,	648	,	144	)

	BuyGoodsData(0,	4581	,	-1	,	542	,	121	)
	BuyGoodsData(0,	4583	,	-1	,	724	,	161	)
	BuyGoodsData(0,	4585	,	-1	,	846	,	188	)
	BuyGoodsData(0,	4587	,	-1	,	846	,	564	)
	BuyGoodsData(0,	4593	,	-1	,	1000	,	223	)
	BuyGoodsData(0,	4595	,	-1	,	938	,	625	)
	BuyGoodsData(0,	4597	,	-1	,	881	,	195	)
	BuyGoodsData(0,	4598	,	-1	,	878	,	195	)
	BuyGoodsData(0,	4600	,	-1	,	866	,	577	)
	BuyGoodsData(0,	4552	,	-1	,	642	,	143	)
	BuyGoodsData(0,	4553	,	-1	,	789	,	175	)
	BuyGoodsData(0,	4554	,	-1	,	934	,	207	)
	BuyGoodsData(0,	4556	,	-1	,	870	,	193	)
	BuyGoodsData(0,	4557	,	-1	,	970	,	215	)
	BuyGoodsData(0,	4560	,	-1	,	1056	,	235	)
	BuyGoodsData(0,	4563	,	-1	,	909	,	202	)
	BuyGoodsData(0,	4566	,	-1	,	785	,	175	)
	BuyGoodsData(0,	4569	,	-1	,	1014	,	225	)
	BuyGoodsData(0,	4572	,	-1	,	924	,	205	)
	BuyGoodsData(0,	4547	,	-1	,	100	,	0	)
	BuyGoodsData(0,	4549	,	-1	,	500	,	0	)
	BuyGoodsData(0,	4548	,	-1	,	300	,	0	)
	BuyGoodsData(0,	4551	,	-1	,	20	,	0	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 30, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()

	AddNpcMission ( 396 )
	AddNpcMission ( 530 )
	AddNpcMission ( 545 )
	AddNpcMission ( 546 )
	AddNpcMission ( 547 )
        AddNpcMission ( 572 )

	-------------贸易商人·油李-------巨蟹
	AddNpcMission	(5825)
	AddNpcMission	(5826)


end

------------------------------------------------------------
-- 春风镇 传送使·春莉
------------------------------------------------------------

function b_talk5()
	--取消传送返回选择传送地点的对话内容和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000001")
	local ReSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000001
	local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 7

	--地图名称信息
	local CurMapName1 = "garner"
	local CurMapName2 = "magicsea"
	local CurMapName5 = "darkblue"

	--白银之城坐标
	local GoTo01X = 2231
	local GoTo01Y = 2788
	local GoTo01M = CurMapName1

	--沙岚之城坐标
	local GoTo02X = 890
	local GoTo02Y = 3575
	local GoTo02M = CurMapName2

	--冰狼堡坐标
	local GoTo04X = 1318
	local GoTo04Y = 510
	local GoTo04M = CurMapName5

	MISSCRIPT_NPCSCRIPT04_LUA_000012 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000012")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000012 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000004")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000004, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000006")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000006, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 5 )
	
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 11 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 2, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000013 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000013")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000013 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 2, CancelSelectTalk, JumpPage , CancelSelectPage )


	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 11 )
	TriggerAction( 1, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2,  GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000014 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000014")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000014 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 3, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 3, CancelSelectTalk, JumpPage , CancelSelectPage )


	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 11 )
	TriggerAction( 1, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerCondition( 2, HasMoney, 500 )
	TriggerAction( 2, TakeMoney, 500 )
	TriggerAction( 2, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerFailure( 2, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000015")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000015 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 4, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 4, CancelSelectTalk, JumpPage , CancelSelectPage )

	MISSCRIPT_NPCSCRIPT04_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000016")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000016 )
	BIRTH_BIRTH_CONF_LUA_000045 = GetResString("BIRTH_BIRTH_CONF_LUA_000045")
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000049, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000045 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT02_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000047")
	Talk( 6, MISSCRIPT_NPCSCRIPT02_LUA_000047 )

	MISSCRIPT_NPCSCRIPT02_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000009")
	Talk( 7, MISSCRIPT_NPCSCRIPT02_LUA_000009, CloseTalk )
	MISSCRIPT_NPCSCRIPT04_LUA_000017 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000017")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000017 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 8 )
	Start( GetMultiTrigger(), 2 )

	AddNpcMission ( 397 )
	 AddNpcMission ( 559 )
	MisListPage(8)

	------------- 传送使·春莉-------巨蟹
	AddNpcMission	(5827)
	AddNpcMission	(5828)	

end

------------------------------------------------------------
-- 春风镇 算命先生·算破天
------------------------------------------------------------

function b_talk6()


	MISSCRIPT_NPCSCRIPT04_LUA_000018 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000018")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000018 )
	MISSCRIPT_NPCSCRIPT04_LUA_000019 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000019")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000019, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000020 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000020")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000020, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000021 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000021")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000021, JumpPage, 6 )

	MISSCRIPT_NPCSCRIPT04_LUA_000022 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000022")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000022)
	CALCULATE_FORGE_LUA_000217 = GetResString("CALCULATE_FORGE_LUA_000217")
	Text( 6, CALCULATE_FORGE_LUA_000217,JumpPage,7)
	MISSCRIPT_NPCSCRIPT04_LUA_000023 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000023")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000023, JumpPage,8)
	MISSCRIPT_NPCSCRIPT04_LUA_000024 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000024")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000024, JumpPage,9)


	--InitTrigger() --兑换死神的遗容
	--TriggerCondition( 1, HasItem, 2846, 1 )
	--TriggerCondition( 1, HasItem, 2847, 1 )
	--TriggerCondition( 1, HasItem, 2848, 1 )
	--TriggerCondition( 1, HasItem, 2849, 1 )
	--TriggerCondition( 1, HasItem, 2850, 1 )
	--TriggerCondition( 1, HasItem, 2851, 1 )
	--TriggerCondition( 1, HasItem, 2852, 1 )
	--TriggerCondition( 1, HasItem, 2853, 1 )

       -- TriggerAction( 1, TakeItem,  2846, 1 )
	--TriggerAction( 1, TakeItem,  2847, 1 )
	--TriggerAction( 1, TakeItem,  2848, 1 )
	--TriggerAction( 1, TakeItem,  2849, 1 )
	--TriggerAction( 1, TakeItem,  2850, 1 )
	--TriggerAction( 1, TakeItem,  2851, 1 )
	--TriggerAction( 1, TakeItem,  2852, 1 )
	--TriggerAction( 1, TakeItem,  2853, 1 )
	--TriggerAction( 1, GiveItem,2934, 1,4 )
	--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000025 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000025")
	Talk(7, MISSCRIPT_NPCSCRIPT04_LUA_000025)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 7, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_7, 1) 

	MISSCRIPT_NPCSCRIPT04_LUA_000026 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000026")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000026)
	CALCULATE_FORGE_LUA_000216 = GetResString("CALCULATE_FORGE_LUA_000216")
	Text( 8, CALCULATE_FORGE_LUA_000216,JumpPage,11)
	CALCULATE_FORGE_LUA_000219 = GetResString("CALCULATE_FORGE_LUA_000219")
	Text( 8, CALCULATE_FORGE_LUA_000219, JumpPage,12)
	CALCULATE_FORGE_LUA_000221 = GetResString("CALCULATE_FORGE_LUA_000221")
	Text( 8, CALCULATE_FORGE_LUA_000221, JumpPage,13)
	CALCULATE_FORGE_LUA_000223 = GetResString("CALCULATE_FORGE_LUA_000223")
	Text( 8, CALCULATE_FORGE_LUA_000223, JumpPage,14)
	CALCULATE_FORGE_LUA_000225 = GetResString("CALCULATE_FORGE_LUA_000225")
	Text( 8, CALCULATE_FORGE_LUA_000225, JumpPage,15)
	CALCULATE_FORGE_LUA_000227 = GetResString("CALCULATE_FORGE_LUA_000227")
	Text( 8, CALCULATE_FORGE_LUA_000227, JumpPage,16)



	--InitTrigger() --兑换哈迪斯的诅咒
	
	--TriggerCondition( 1, HasItem, 2854, 1 )
	--TriggerCondition( 1, HasItem, 2855, 1 )
	--TriggerCondition( 1, HasItem, 2856, 1 )
	--TriggerCondition( 1, HasItem, 2857, 1 )
	--TriggerCondition( 1, HasItem, 2927, 1 )
      
	--TriggerAction( 1, TakeItem,  2854, 1 )
	--TriggerAction( 1, TakeItem,  2855, 1 )
	--TriggerAction( 1, TakeItem,  2856, 1 )
	--TriggerAction( 1, TakeItem,  2857, 1 )
	--TriggerAction( 1, TakeItem,  2927, 1 )
	--TriggerAction( 1, GiveItem,2935, 1,4 )
	--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000027 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000027")
	Talk(11, MISSCRIPT_NPCSCRIPT04_LUA_000027)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 11, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_8, 1) 


--InitTrigger() --兑换黑暗的诅咒	
--TriggerCondition( 1, HasItem, 2854, 1 )
--TriggerCondition( 1, HasItem, 2855, 1 )
--TriggerCondition( 1, HasItem, 2856, 1 )
--TriggerCondition( 1, HasItem, 2857, 1 )
--TriggerCondition( 1, HasItem, 2928, 1 )
--
--TriggerAction( 1, TakeItem,  2854, 1 )
--TriggerAction( 1, TakeItem,  2855, 1 )
--TriggerAction( 1, TakeItem,  2856, 1 )
--TriggerAction( 1, TakeItem,  2857, 1 )
--TriggerAction( 1, TakeItem,  2928, 1 )
--TriggerAction( 1, GiveItem,2936, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000028 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000028")
	Talk(12, MISSCRIPT_NPCSCRIPT04_LUA_000028)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 12, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_9, 1) 


--InitTrigger() --兑换地狱的诅咒

--TriggerCondition( 1, HasItem, 2854, 1 )
--TriggerCondition( 1, HasItem, 2855, 1 )
--TriggerCondition( 1, HasItem, 2856, 1 )
--TriggerCondition( 1, HasItem, 2857, 1 )
--TriggerCondition( 1, HasItem, 2929, 1 )

--TriggerAction( 1, TakeItem,  2854, 1 )
--TriggerAction( 1, TakeItem,  2855, 1 )
--TriggerAction( 1, TakeItem,  2856, 1 )
--TriggerAction( 1, TakeItem,  2857, 1 )
--TriggerAction( 1, TakeItem,  2929, 1 )
--TriggerAction( 1, GiveItem,2937, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000029 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000029")
	Talk(13, MISSCRIPT_NPCSCRIPT04_LUA_000029)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 13, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_10, 1) 



--InitTrigger() --兑换幽冥的诅咒
--TriggerCondition( 1, HasItem, 2854, 1 )
--TriggerCondition( 1, HasItem, 2855, 1 )
--TriggerCondition( 1, HasItem, 2856, 1 )
--TriggerCondition( 1, HasItem, 2857, 1 )
--TriggerCondition( 1, HasItem, 2931, 1 )

--TriggerAction( 1, TakeItem,  2854, 1 )
--TriggerAction( 1, TakeItem,  2855, 1 )
--TriggerAction( 1, TakeItem,  2856, 1 )
--TriggerAction( 1, TakeItem,  2857, 1 )
--TriggerAction( 1, TakeItem,  2931, 1 )
--TriggerAction( 1, GiveItem,2939, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000030")
	Talk(14, MISSCRIPT_NPCSCRIPT04_LUA_000030)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 14, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_11, 1) 

--	InitTrigger() --兑换冥河的诅咒
--TriggerCondition( 1, HasItem, 2854, 1 )
--TriggerCondition( 1, HasItem, 2855, 1 )
--TriggerCondition( 1, HasItem, 2856, 1 )
--TriggerCondition( 1, HasItem, 2857, 1 )
--TriggerCondition( 1, HasItem, 2932, 1 )
--
--TriggerAction( 1, TakeItem,  2854, 1 )
--TriggerAction( 1, TakeItem,  2855, 1 )
--TriggerAction( 1, TakeItem,  2856, 1 )
--TriggerAction( 1, TakeItem,  2857, 1 )
--TriggerAction( 1, TakeItem,  2932, 1 )
--TriggerAction( 1, GiveItem,2940, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000031 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000031")
	Talk(15, MISSCRIPT_NPCSCRIPT04_LUA_000031)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 15, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_12, 1) 



--InitTrigger() --兑换修罗的诅咒
--TriggerCondition( 1, HasItem, 2854, 1 )
--TriggerCondition( 1, HasItem, 2855, 1 )
--TriggerCondition( 1, HasItem, 2856, 1 )
--TriggerCondition( 1, HasItem, 2857, 1 )
--TriggerCondition( 1, HasItem, 2930, 1 )
--
--TriggerAction( 1, TakeItem,  2854, 1 )
--TriggerAction( 1, TakeItem,  2855, 1 )
--TriggerAction( 1, TakeItem,  2856, 1 )
--TriggerAction( 1, TakeItem,  2857, 1 )
--TriggerAction( 1, TakeItem,  2930, 1 )
--TriggerAction( 1, GiveItem,2938, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000032 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000032")
	Talk(16, MISSCRIPT_NPCSCRIPT04_LUA_000032)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 16, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_13, 1) 


	MISSCRIPT_NPCSCRIPT04_LUA_000033 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000033")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000033)
	CALCULATE_FORGE_LUA_000233 = GetResString("CALCULATE_FORGE_LUA_000233")
	Text( 9, CALCULATE_FORGE_LUA_000233,JumpPage,17)
	CALCULATE_FORGE_LUA_000235 = GetResString("CALCULATE_FORGE_LUA_000235")
	Text( 9, CALCULATE_FORGE_LUA_000235, JumpPage,18)
	CALCULATE_FORGE_LUA_000232 = GetResString("CALCULATE_FORGE_LUA_000232")
	Text( 9, CALCULATE_FORGE_LUA_000232, JumpPage,19)
	CALCULATE_FORGE_LUA_000231 = GetResString("CALCULATE_FORGE_LUA_000231")
	Text( 9, CALCULATE_FORGE_LUA_000231, JumpPage,20)
	CALCULATE_FORGE_LUA_000230 = GetResString("CALCULATE_FORGE_LUA_000230")
	Text( 9, CALCULATE_FORGE_LUA_000230, JumpPage,21)
	CALCULATE_FORGE_LUA_000234 = GetResString("CALCULATE_FORGE_LUA_000234")
	Text( 9, CALCULATE_FORGE_LUA_000234, JumpPage,22)
	MISSCRIPT_NPCSCRIPT04_LUA_000034 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000034")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000034, JumpPage,23)


--InitTrigger() --兑换哈迪斯的魂魄
--TriggerCondition( 1, HasItem, 2934, 1 )
--TriggerCondition( 1, HasItem, 2935, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--TriggerAction( 1, TakeItem,  2935, 1 )
--TriggerAction( 1, GiveItem,2562, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000035 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000035")
	Talk(17, MISSCRIPT_NPCSCRIPT04_LUA_000035)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 17, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_14, 1) 
--
--
--InitTrigger() --兑换黑暗的魂魄
--TriggerCondition( 1, HasItem, 2934, 1 )
--TriggerCondition( 1, HasItem, 2936, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--TriggerAction( 1, TakeItem,  2936, 1 )
--TriggerAction( 1, GiveItem,2563, 1,4 )
	--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000036 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000036")
	Talk(18, MISSCRIPT_NPCSCRIPT04_LUA_000036)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 18, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_15, 1) 



--InitTrigger() --兑换地狱的魂魄
--TriggerCondition( 1, HasItem, 2934, 1 )
--TriggerCondition( 1, HasItem, 2937, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--TriggerAction( 1, TakeItem,  2937, 1 )
--TriggerAction( 1, GiveItem,2564, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000037 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000037")
	Talk(19, MISSCRIPT_NPCSCRIPT04_LUA_000037)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 19, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_16, 1) 
--
--
--
--InitTrigger() --兑换幽冥的魂魄
--TriggerCondition( 1, HasItem, 2934, 1 )
--TriggerCondition( 1, HasItem, 2939, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--	TriggerAction( 1, TakeItem,  2939, 1 )
--TriggerAction( 1, GiveItem,2566, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000038 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000038")
	Talk(20, MISSCRIPT_NPCSCRIPT04_LUA_000038)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 20, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_17, 1) 
--
--
--InitTrigger() --兑换冥河的魂魄
--TriggerCondition( 1, HasItem, 2934, 1 )
--TriggerCondition( 1, HasItem, 2940, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--TriggerAction( 1, TakeItem,  2940, 1 )
--TriggerAction( 1, GiveItem,2567, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000039 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000039")
	Talk(21, MISSCRIPT_NPCSCRIPT04_LUA_000039)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 21, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_18, 1) 
--
--

--InitTrigger() --兑换修罗的魂魄
--TriggerCondition( 1, HasItem, 2934, 1 )
--TriggerCondition( 1, HasItem, 2938, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--TriggerAction( 1, TakeItem,  2938, 1 )
--TriggerAction( 1, GiveItem,2565, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000040 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000040")
	Talk(22, MISSCRIPT_NPCSCRIPT04_LUA_000040)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 22, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_19, 1) 
--
--InitTrigger() --兑换黑龙的魂魄
--TriggerCondition( 1, HasItem, 2562, 1 )
--TriggerCondition( 1, HasItem, 2563, 1 )
--TriggerCondition( 1, HasItem, 2564, 1 )
--TriggerCondition( 1, HasItem, 2565, 1 )
--TriggerCondition( 1, HasItem, 2566, 1 )
--TriggerCondition( 1, HasItem, 2567, 1 )
--TriggerCondition( 1, HasItem, 2933, 1 )
--TriggerCondition( 1, HasItem, 2934, 1 )
--
--TriggerAction( 1, TakeItem,  2562, 1 )
--TriggerAction( 1, TakeItem,  2563, 1 )
--TriggerAction( 1, TakeItem,  2564, 1 )
--TriggerAction( 1, TakeItem,  2565, 1 )
--TriggerAction( 1, TakeItem,  2566, 1 )
--TriggerAction( 1, TakeItem,  2567, 1 )
--TriggerAction( 1, TakeItem,  2933, 1 )
--TriggerAction( 1, TakeItem,  2934, 1 )
--TriggerAction( 1, GiveItem,2404, 1,4 )
--TriggerFailure( 1, JumpPage, 10 ) 
	MISSCRIPT_NPCSCRIPT04_LUA_000041 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000041")
	Talk(23, MISSCRIPT_NPCSCRIPT04_LUA_000041)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text( 23, MISSCRIPT_NPCSCRIPT01_LUA_001061,GetChaName_20, 1) 

	MISSCRIPT_NPCSCRIPT04_LUA_000042 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000042")
	Talk( 10, MISSCRIPT_NPCSCRIPT04_LUA_000042 )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 5000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeMoney, 5000)
	TriggerAction( 1, GiveItem, 3086,1, 4 )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT04_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000043")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000043 )
	MISSCRIPT_NPCSCRIPT04_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000044")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000044,MultiTrigger, GetMultiTrigger(), 1 ) 

	InitTrigger()
	TriggerCondition( 1, HasMoney, 5000 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, KitbagLock, 0 )
	TriggerAction( 1, TakeMoney, 5000)
	TriggerAction( 1, GiveItem, 3087,1, 4 )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT04_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000045")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000045 )
	MISSCRIPT_NPCSCRIPT04_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000044")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000044,MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT04_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000046")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000046 )

	MISSCRIPT_NPCSCRIPT04_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000047")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000047 )

	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 4 )
	Start( GetMultiTrigger(), 4 )
	
	AddNpcMission ( 520 )
        AddNpcMission ( 900 )
---------------------新历史任务
	AddNpcMission(	5065)
	AddNpcMission(	595	)
	AddNpcMission(	599	)
	AddNpcMission(	5000	)
	AddNpcMission(	5001	)
	AddNpcMission(	5002	)
	AddNpcMission(	5003 )
	AddNpcMission(	5066)

	------------- 算命先生·算破天-------巨蟹
	AddNpcMission	(5829)
	AddNpcMission	(5830)	

end
------------------------------------------------------------
-- 春风镇 酒店老板·裴蒂
------------------------------------------------------------

function b_talk7()


	MISSCRIPT_NPCSCRIPT04_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000048")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000048 )
   	--Text( 1, "交易", BuyPage )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000049")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000049 )

	InitTrade()
	Other(	1084	)
	Other(	1085	)
	Other(	1087	)
	Other(	1088	)
	Other(	1089	)
	Other(	1090	) 


	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )


	AddNpcMission ( 392 )
	AddNpcMission ( 514 )
	AddNpcMission ( 516 )
	AddNpcMission ( 527 )
	AddNpcMission ( 528 )
	AddNpcMission ( 529 )
	AddNpcMission ( 548 )
	AddNpcMission ( 550 )
	AddNpcMission ( 551 )
       AddNpcMission ( 558 )
       AddNpcMission ( 571 )
------------新增历史任务
	AddNpcMission(	592	)
	AddNpcMission(	5004	)
	AddNpcMission(	5005	)
	AddNpcMission(	5006	)
	AddNpcMission(	5007	)
	AddNpcMission(	5008	)
	AddNpcMission(	5043	)
	AddNpcMission(	5054	)
	AddNpcMission(	5055	)

	------------- 酒店老板·裴蒂-------巨蟹
	AddNpcMission	(5831)
	AddNpcMission	(5832)

end

------------------------------------------------------------
-- 春风镇 港口指挥·霜奇
------------------------------------------------------------

function b_talk8()


	MISSCRIPT_NPCSCRIPT04_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000050")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000050 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 13 )
	TriggerAction( 1, LuanchBerthList, 13, 3426, 2575, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 13 )
	TriggerAction( 2, RepairBerthList, 13 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 13 )
	TriggerAction( 2, SupplyBerthList, 13 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 13 )
	TriggerAction( 1, SalvageBerthList, 13 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )
	MISSCRIPT_NPCSCRIPT04_LUA_000051 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000051")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000051 )


	AddNpcMission ( 398 )
	AddNpcMission ( 565 )

	------------- 港口指挥·霜奇-------巨蟹
	AddNpcMission	(5833)
	AddNpcMission	(5834)

end

------------------------------------------------------------
-- 春风镇 银行总管·王墨
------------------------------------------------------------

function b_talk9()


	MISSCRIPT_NPCSCRIPT04_LUA_000052 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000052")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000052 )
	InitTrigger()
	TriggerCondition( 1, HasMoney, 200 )
	TriggerAction( 1, TakeMoney, 200 )
	TriggerAction( 1, OpenBank )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT01_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000213")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000213, MultiTrigger, GetMultiTrigger(), 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000053 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000053")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000053 )
	MISSCRIPT_NPCSCRIPT04_LUA_000054 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000054")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000054 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 3 )
	Start( GetMultiTrigger(), 2 )



	AddNpcMission ( 399 )
	AddNpcMission ( 510 )
	AddNpcMission ( 511 )
	AddNpcMission ( 512 )
	AddNpcMission ( 513 )
	AddNpcMission ( 543 )
	AddNpcMission ( 544 )
        AddNpcMission ( 570 )

	------------- 银行总管·王墨-------巨蟹
	AddNpcMission	(5839)
	AddNpcMission	(5840)
end

------------------------------------------------------------
-- 春风镇 卫兵·赵钱孙
------------------------------------------------------------

function b_talk10()


	MISSCRIPT_NPCSCRIPT04_LUA_000055 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000055")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000055 )
	MISSCRIPT_NPCSCRIPT04_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000056")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000056 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )

	------------- 卫兵·赵钱孙-------巨蟹
	AddNpcMission	(5835)
	AddNpcMission	(5836)

end

------------------------------------------------------------
-- 春风镇 卫兵·周吴郑
------------------------------------------------------------

function b_talk11()


	MISSCRIPT_NPCSCRIPT04_LUA_000057 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000057")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000057 )
	MISSCRIPT_NPCSCRIPT04_LUA_000058 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000058")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000058 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )

	AddNpcMission ( 531 )
	AddNpcMission ( 532 )
	AddNpcMission ( 533 )
	AddNpcMission ( 534 )

	------------- 卫兵·周吴郑-------巨蟹
	AddNpcMission	(5837)
	AddNpcMission	(5838)

end

------------------------------------------------------------
-- 春风镇 青年男子·流云
------------------------------------------------------------

function b_talk12()


	MISSCRIPT_NPCSCRIPT04_LUA_000059 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000059")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000059 )
	MISSCRIPT_NPCSCRIPT04_LUA_000060 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000060")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000060 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )
         
	 AddNpcMission ( 533 )
	 AddNpcMission ( 563 )

	------------- 青年男子·流云-------巨蟹
	AddNpcMission	(5841)
	AddNpcMission	(5842)
	---------------2.0新历史任务
	AddNpcMission ( 6320 )
	AddNpcMission ( 6321 )

end

------------------------------------------------------------
-- 春风镇 青年女子·水雾
------------------------------------------------------------

function b_talk13()


	MISSCRIPT_NPCSCRIPT04_LUA_000061 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000061")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000061 )
	MISSCRIPT_NPCSCRIPT04_LUA_000062 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000062")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000062 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )

	------------- 青年女子·水雾-------巨蟹
	AddNpcMission	(5843)
	AddNpcMission	(5844)
	---------------2.0新历史任务
	AddNpcMission ( 6318 )
	AddNpcMission ( 6319 )
	
end

------------------------------------------------------------
-- 春风镇 中年男子·比盖
------------------------------------------------------------

function b_talk14()


	MISSCRIPT_NPCSCRIPT04_LUA_000063 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000063")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000063 )
	MISSCRIPT_NPCSCRIPT04_LUA_000064 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000064")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000064 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )
	
	
    AddNpcMission ( 568 )
	------------中年男子·比盖-------奥运活动
	AddNpcMission	(6262)
	AddNpcMission	(6263)

	------------- 中年男子·比盖-------巨蟹
	AddNpcMission	(5847)
	AddNpcMission	(5848)
	
end

------------------------------------------------------------
-- 春风镇 中年女子·王蓉
------------------------------------------------------------

function b_talk15()


	MISSCRIPT_NPCSCRIPT04_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000065")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000065 )
	MISSCRIPT_NPCSCRIPT04_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000066")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000066 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )

	------------- 中年女子·王蓉-------巨蟹
	AddNpcMission	(5845)
	AddNpcMission	(5846)

end

------------------------------------------------------------
-- 春风镇 东方海盗·山田佐
------------------------------------------------------------

function b_talk16()


	MISSCRIPT_NPCSCRIPT04_LUA_000067 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000067")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000067 )
	MISSCRIPT_NPCSCRIPT04_LUA_000068 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000068")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000068 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )
-----------------东方海盗·山田佐---------金牛
	AddNpcMission	(5641)
	AddNpcMission	(5642)

	------------- 东方海盗·山田佐-------巨蟹
	AddNpcMission	(5849)
	AddNpcMission	(5850)

end

------------------------------------------------------------
-- 春风镇 潮流理发师
------------------------------------------------------------

function b_talk17()


	MISSCRIPT_NPCSCRIPT04_LUA_000069 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000069")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000069 )
        MISSCRIPT_NPCSCRIPT01_LUA_000840 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000840")
        Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000840, JumpPage, 2)
	InitTrigger()
	TriggerCondition( 1, HasItem, 1807, 1 )
	TriggerAction( 1, OpenHair )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000070 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000070")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000070)
	MISSCRIPT_NPCSCRIPT04_LUA_000071 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000071")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000071, MultiTrigger, GetMultiTrigger(), 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000072 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000072")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000072, CloseTalk )

	MISSCRIPT_NPCSCRIPT04_LUA_000073 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000073")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000073)
	MISSCRIPT_NPCSCRIPT04_LUA_000074 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000074")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000074 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 4 )
	Start( GetMultiTrigger(), 2 )

	AddNpcMission	(6003)
	AddNpcMission	(6004)
	AddNpcMission	(6005)
	AddNpcMission	(6006)
	AddNpcMission	(6007)
	AddNpcMission	(6008)
	AddNpcMission	(6009)


	-------------海港指挥·夏云-------巨蟹
	AddNpcMission	(5851)
	AddNpcMission	(5852)

end

------------------------------------------------------------
-- 春风镇 僵尸·裴永军
------------------------------------------------------------

function b_talk18()


	MISSCRIPT_NPCSCRIPT04_LUA_000075 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000075")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000075 )
	MISSCRIPT_NPCSCRIPT04_LUA_000076 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000076")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000076 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 2 )
	Start( GetMultiTrigger(), 2 )
	
	AddNpcMission ( 515 )
	AddNpcMission ( 518 )
	AddNpcMission ( 524 )
end

------------------------------------------------------------
--黑龙巢穴 一层to二层
------------------------------------------------------------

function b_talk21()


	--取消传送返回选择传送地点的对话内容和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000001")
	local ReSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000001
	local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 5

	--地图名称信息
	local CurMapName = "eastgoaf"


	--黑龙巢穴二层坐标
	local GoTo01X = 767
	local GoTo01Y = 602
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000077 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000077")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000077 )
	MISSCRIPT_NPCSCRIPT04_LUA_000078 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000078")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000078, JumpPage, 2 )

	InitTrigger()
	TriggerCondition( 1, HasItem, 179,1 )
	TriggerCondition( 1, HasItem, 3084,1 )
	TriggerCondition( 1, HasItem, 3085,1 )
	TriggerAction( 1, TakeItem, 179,1 )
	TriggerAction( 1, TakeItem, 3084,1 )
	TriggerAction( 1, TakeItem, 3085,1 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000079 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000079")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000079 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 2, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000080 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000080")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000080 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 3 )
	Start( GetMultiTrigger(), 3 )

	MISSCRIPT_NPCSCRIPT04_LUA_000081 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000081")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000081 )

	MISSCRIPT_NPCSCRIPT04_LUA_000082 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000082")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000082, CloseTalk )
end

------------------------------------------------------------
--黑龙巢穴 二层to一层
------------------------------------------------------------

function b_talk22()


	--取消传送返回选择传送地点的对话内容和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000001")
	local ReSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000001
	local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 4

	--地图名称信息
	local CurMapName = "eastgoaf"


	--黑龙巢穴三层坐标
	local GoTo01X = 847
	local GoTo01Y = 247
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000077 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000077")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000077 )
	MISSCRIPT_NPCSCRIPT04_LUA_000083 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000083")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000083, JumpPage, 2 )

	InitTrigger()
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	MISSCRIPT_NPCSCRIPT04_LUA_000084 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000084")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000084 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 2, CancelSelectTalk, JumpPage , CancelSelectPage )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000080 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000080")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000080 )



	InitTrigger()
	TriggerCondition( 1, HasRecord, 330 )
	TriggerAction( 1, JumpPage, 1 )
	TriggerCondition( 2, NoRecord, 330 )
	TriggerAction( 2, JumpPage, 3 )
	Start( GetMultiTrigger(), 3 )

	MISSCRIPT_NPCSCRIPT04_LUA_000082 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000082")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000082, CloseTalk )



end

------------------------------------------------------------
--黑龙巢穴 二层to三层
------------------------------------------------------------

function b_talk23()

	--地图名称信息
	local CurMapName = "eastgoaf"


	--黑龙巢穴三层坐标
	local GoTo01X = 772
	local GoTo01Y = 722
	local GoTo01M = CurMapName


	InitTrigger()
	TriggerCondition( 1, HasItem, 182,1 )
	--TriggerAction( 1, TakeItem, 1091,1 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000085 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000085")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000085 )
	MISSCRIPT_NPCSCRIPT04_LUA_000086 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000086")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000086, MultiTrigger, GetMultiTrigger(), 1 )

	--Talk( 3, "守护神雕像：“………………^$&#&^………………”" )
	--InitTrigger()
--	TriggerCondition( 1, HasRecord, 330 )
--	TriggerAction( 1, JumpPage, 1 )
--	TriggerCondition( 2, NoRecord, 330 )
--	TriggerAction( 2, JumpPage, 3 )
--	Start( GetMultiTrigger(), 3 )

	MISSCRIPT_NPCSCRIPT04_LUA_000087 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000087")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000087 )

--	Talk( 4, "雕像发出一股强大的力量挡住了我，似乎以我的力量无法超越她，看来我得想想其他办法了。" )


end

------------------------------------------------------------
--黑龙宝箱
------------------------------------------------------------

function b_talk24()

--	InitFuncList()
--	AddFuncList( GiveItem,	110	,	1	,	4)
--	AddFuncList( GiveItem,	112	,	1	,	4)
--	AddFuncList( GiveItem,	114	,	1	,	4)
--	AddFuncList( GiveItem,	116	,	1	,	4)
--	AddFuncList( GiveItem,	118	,	1	,	4)
--	AddFuncList( GiveItem,	120	,	1	,	4)
--	AddFuncList( GiveItem,	151	,	1	,	4)

	InitTrigger()
	TriggerCondition( 1, HasItem, 182, 1 )
	TriggerAction( 1, TakeItem, 182, 1 )
	TriggerAction( 1, AddMoney, 10000000 )
--	TriggerAction( 1, RandFunction, GetFuncList(), GetNumFunc() )
	TriggerAction(1, GiveItem, 0266, 1, 4)
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000088 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000088")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000088 )
	MISSCRIPT_NPCSCRIPT04_LUA_000089 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000089")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000089, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000090 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000090")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000090 )

end

------------------------------------------------------------
-- 加勒比海盗版本 -----  铁匠
------------------------------------------------------------

function l_talk01()
	MISSCRIPT_NPCSCRIPT04_LUA_000091 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000091")
	Talk(1, MISSCRIPT_NPCSCRIPT04_LUA_000091)

	AddNpcMission(894)
	AddNpcMission(487)
	AddNpcMission(504)
	AddNpcMission(508)
	AddNpcMission(509)
	AddNpcMission(573)
	AddNpcMission(581)
	AddNpcMission(582)
	AddNpcMission(583)
	---------------2.0新历史任务
	AddNpcMission ( 6359 )
	AddNpcMission ( 6360 )
	AddNpcMission ( 6361 )

end

------------------------------------------------------------
-- 加勒比海盗版本 -----  杰克史派罗
------------------------------------------------------------

function l_talk02()
	MISSCRIPT_NPCSCRIPT04_LUA_000092 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000092")
	Talk(1, MISSCRIPT_NPCSCRIPT04_LUA_000092)

	AddNpcMission(895)
	AddNpcMission(896)
	AddNpcMission(482)
	AddNpcMission(485)
	AddNpcMission(486)
	AddNpcMission(574)
	AddNpcMission(575)
	AddNpcMission(584)
	AddNpcMission(585)
	AddNpcMission(586)

	----海港指挥·布纽--------杰克史派罗
	
	AddNpcMission	(5676)
	---------------2.0新历史任务
	AddNpcMission ( 6357 )
	AddNpcMission ( 6358 )
end

------------------------------------------------------------
-- 加勒比海盗版本 -----  诺灵顿将军
------------------------------------------------------------

function l_talk03()
	MISSCRIPT_NPCSCRIPT04_LUA_000093 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000093")
	Talk(1, MISSCRIPT_NPCSCRIPT04_LUA_000093)

	AddNpcMission(897)
	AddNpcMission(898)
	AddNpcMission(899)
	AddNpcMission(476)
	AddNpcMission(479)
	AddNpcMission(480)
	AddNpcMission(481)
	AddNpcMission(576)
	AddNpcMission(577)
	AddNpcMission(578)
	AddNpcMission(589)
	AddNpcMission(590)

end

------------------------------------------------------------
-- 加勒比海盗版本 -----  伊丽莎白
------------------------------------------------------------

function l_talk04()
	MISSCRIPT_NPCSCRIPT04_LUA_000094 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000094")
	Talk(1, MISSCRIPT_NPCSCRIPT04_LUA_000094)
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )

	InitTrade()
	Other(	3141	)
	Other(	4602	)
	Other(	4603	)
	Other(	4604	)

	AddNpcMission(505)
	AddNpcMission(506)
	AddNpcMission(507)
	AddNpcMission(579)
	AddNpcMission(580)
	AddNpcMission(587)
	AddNpcMission(588)
	AddNpcMission(591)

	---------------白羊
	AddNpcMission	(5573)
	AddNpcMission	(5574)

	-----------------伊丽莎白---------金牛
	AddNpcMission	(5661)
	AddNpcMission	(5662)

	-----------------勇者试炼
	AddNpcMission( 6171 )
	AddNpcMission( 6172 )
end

------------------------------------------------------------
-- 加勒比海盗版本 -----  藏宝海湾北海港指挥·彭尼
------------------------------------------------------------
function mmm_talk06()

	MISSCRIPT_NPCSCRIPT04_LUA_000095 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000095")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000095 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 650,999, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )
	MISSCRIPT_NPCSCRIPT04_LUA_000051 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000051")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000051 )




end

------------------------------------------------------------
-- 加勒比海盗版本 -----  藏宝海湾南海港指挥·凯奇
------------------------------------------------------------
function mmm_talk05()

	MISSCRIPT_NPCSCRIPT04_LUA_000096 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000096")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000096 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 625,925, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )
	MISSCRIPT_NPCSCRIPT04_LUA_000097 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000097")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000097 )




end
------------------------------------------------------------
-- 加勒比海盗版本 -----  骷髅海港指挥
------------------------------------------------------------
function mmm_talk07()
MISSCRIPT_NPCSCRIPT04_LUA_000098 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000098")
Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000098 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 620,628, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )
	MISSCRIPT_NPCSCRIPT04_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000099")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000099 )
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  神秘人出海人
------------------------------------------------------------
function mmm_talk08()
MISSCRIPT_NPCSCRIPT04_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000100")
Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000100 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 380,161, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )
	MISSCRIPT_NPCSCRIPT04_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000101")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000101 )
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  海军基地海港指挥
------------------------------------------------------------
function mmm_talk09()
MISSCRIPT_NPCSCRIPT04_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000102")
Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000102 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 1070,212, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )
	MISSCRIPT_NPCSCRIPT04_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000103")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000103 )
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  打包人·戴普
------------------------------------------------------------
function mmm_talk10()
MISSCRIPT_NPCSCRIPT04_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000104")
Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000104 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 12)
	TriggerAction( 1, PackBagList, 12, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 12)
	TriggerAction( 1, PackBagList, 12, RES_MINE, 3 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000129 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000129")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000129, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000105")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000105 )

end
------------------------------------------------------------
-- 加勒比海盗版本 -----  地狱传送使
------------------------------------------------------------
function mmm_talk11()
	--地图名称信息
	local CurMapName = "jialebi" 

	--黑龙巢穴三层坐标
	local GoTo01X = 190
	local GoTo01Y = 815
	local GoTo01M = CurMapName


	InitTrigger()
	TriggerCondition( 1, HasItem, 2438,20 )
	TriggerCondition( 1, HasItem, 2419,15 )
	TriggerCondition( 1, HasItem, 2386,15 )
	TriggerAction( 1, TakeItem, 2438,20 )
	TriggerAction( 1, TakeItem, 2419,15 )
	TriggerAction( 1, TakeItem, 2386,15 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000106 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000106")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000106 )
	MISSCRIPT_NPCSCRIPT04_LUA_000107 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000107")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000107, MultiTrigger, GetMultiTrigger(), 1 )

	--Talk( 3, "守护神雕像：“………………^$&#&^………………”" )

--InitTrigger()
--	TriggerCondition( 1, HasRecord, 330 )
--	TriggerAction( 1, JumpPage, 1 )
--	TriggerCondition( 2, NoRecord, 330 )
--	TriggerAction( 2, JumpPage, 3 )
--	Start( GetMultiTrigger(), 3 )

	MISSCRIPT_NPCSCRIPT04_LUA_000108 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000108")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000108 )

--	Talk( 4, "雕像发出一股强大的力量挡住了我，似乎以我的力量无法超越她，看来我得想想其他办法了。" )

---------------白羊
	AddNpcMission	(5593)
	AddNpcMission	(5594)
--------------奥运活动	
	AddNpcMission	(6264)
	AddNpcMission	(6265)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  天堂传送使
------------------------------------------------------------
function mmm_talk12()
--地图名称信息
	local CurMapName = "jialebi" 


	--黑龙巢穴三层坐标
	local GoTo01X = 1604
	local GoTo01Y = 906
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000109 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000109")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000109 )
	MISSCRIPT_NPCSCRIPT04_LUA_000110 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000110")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000110, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000111 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000111")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000111, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000112 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000112")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000112, JumpPage, 7 )

	InitTrigger()
	TriggerCondition( 1, HasItem, 2488,1 )
	TriggerCondition( 1, HasItem, 2489,1 )
	TriggerCondition( 1, HasItem, 2490,1 )
	TriggerCondition( 1, HasItem, 2436,1 )
	TriggerAction( 1, TakeItem, 2488,1 )
	TriggerAction( 1, TakeItem, 2489,1 )
	TriggerAction( 1, TakeItem, 2490,1 )
	TriggerAction( 1, TakeItem, 2436,1 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000113 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000113")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000113 )
	MISSCRIPT_NPCSCRIPT04_LUA_000114 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000114")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000114, MultiTrigger, GetMultiTrigger(), 1 )


	InitTrigger()
	TriggerCondition( 1, HasItem, 0938,1 )
	TriggerAction( 1, TakeItem, 0938,1 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT04_LUA_000115 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000115")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000115 )
	MISSCRIPT_NPCSCRIPT04_LUA_000114 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000114")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000114, MultiTrigger, GetMultiTrigger(), 1 )
	MISSCRIPT_NPCSCRIPT04_LUA_000116 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000116")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000116, JumpPage, 6 )
	


	MISSCRIPT_NPCSCRIPT04_LUA_000108 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000108")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000108 )
	MISSCRIPT_NPCSCRIPT04_LUA_000117 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000117")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000117 )
	MISSCRIPT_NPCSCRIPT04_LUA_000118 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000118")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000118 )

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, HasItem, 2386, 10 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, TakeItem, 2386, 10 )
	TriggerAction( 1, GiveItem, 0271, 1, 4 )
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000119 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000119")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000119 )
	MISSCRIPT_NPCSCRIPT04_LUA_000120 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000120")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000120, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000121 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000121")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000121 )
---------------白羊
	AddNpcMission	(5595)
	AddNpcMission	(5596)

	AddNpcMission ( 6056 )
	AddNpcMission ( 6057 )
	AddNpcMission ( 6058 )
	AddNpcMission ( 6059 )
	AddNpcMission ( 6060 )
----------天堂传送使-------双子-------------------04
	AddNpcMission	(5726)
	AddNpcMission	(5727)

end
------------------------------------------------------------
-- 加勒比海盗版本 -----  迷失的考古队成员A
------------------------------------------------------------
function mmm_talk13()
	MISSCRIPT_NPCSCRIPT04_LUA_000122 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000122")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000122 )
	MISSCRIPT_NPCSCRIPT04_LUA_000123 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000123")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000123, JumpPage, 2)

	MISSCRIPT_NPCSCRIPT04_LUA_000124 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000124")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000124 )
	MISSCRIPT_NPCSCRIPT04_LUA_000125 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000125")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000125, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000126 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000126")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000126, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000127 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000127")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000127, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT04_LUA_000128 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000128")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000128, JumpPage, 6)

	MISSCRIPT_NPCSCRIPT04_LUA_000129 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000129")
	Talk(3,MISSCRIPT_NPCSCRIPT04_LUA_000129)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2467, 1 )
	TriggerCondition( 1, HasItem, 3121, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2467, 1 )
	TriggerAction( 1, TakeItem, 3121, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0396, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000130 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000130")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000130, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000131 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000131")
	Talk(4,MISSCRIPT_NPCSCRIPT04_LUA_000131)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2473, 1 )
	TriggerCondition( 1, HasItem, 3121, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2473, 1 )
	TriggerAction( 1, TakeItem, 3121, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0588, 1 , 4)
	TriggerFailure( 1, JumpPage, 7)
	MISSCRIPT_NPCSCRIPT04_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000132")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000132, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000133 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000133")
	Talk(5,MISSCRIPT_NPCSCRIPT04_LUA_000133)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2479, 1 )
	TriggerCondition( 1, HasItem, 3121, 30 )
	TriggerCondition( 1, HasItem, 1657, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2479, 1 )
	TriggerAction( 1, TakeItem, 3121, 30 )
	TriggerAction( 1, TakeItem, 1657, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0748, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000134 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000134")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000134, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000135 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000135")
	Talk(6,MISSCRIPT_NPCSCRIPT04_LUA_000135)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2463, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2463, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0114, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000136 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000136")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000136, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000137")
	Talk(7,MISSCRIPT_NPCSCRIPT04_LUA_000137)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  迷失的考古队成员B
------------------------------------------------------------
function mmm_talk14()
	MISSCRIPT_NPCSCRIPT04_LUA_000138 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000138")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000138 )
	MISSCRIPT_NPCSCRIPT04_LUA_000139 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000139")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000139, JumpPage, 2)

	MISSCRIPT_NPCSCRIPT04_LUA_000140 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000140")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000140 )
	MISSCRIPT_NPCSCRIPT04_LUA_000141 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000141")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000141, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000142")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000142, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000143 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000143")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000143, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT04_LUA_000144 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000144")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000144, JumpPage, 6)

	MISSCRIPT_NPCSCRIPT04_LUA_000145 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000145")
	Talk(3,MISSCRIPT_NPCSCRIPT04_LUA_000145)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2468, 1 )
	TriggerCondition( 1, HasItem, 1593, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2468, 1 )
	TriggerAction( 1, TakeItem, 1593, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0398, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000146 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000146")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000146, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000147 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000147")
	Talk(4,MISSCRIPT_NPCSCRIPT04_LUA_000147)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2478, 1 )
	TriggerCondition( 1, HasItem, 1593, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2478, 1 )
	TriggerAction( 1, TakeItem, 1593, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0604, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000148 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000148")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000148, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000149 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000149")
	Talk(5,MISSCRIPT_NPCSCRIPT04_LUA_000149)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2484, 1 )
	TriggerCondition( 1, HasItem, 1593, 30 )
	TriggerCondition( 1, HasItem, 1657, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2484, 1 )
	TriggerAction( 1, TakeItem, 1593, 30 )
	TriggerAction( 1, TakeItem, 1657, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0830, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000150 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000150")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000150, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000151 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000151")
	Talk(6,MISSCRIPT_NPCSCRIPT04_LUA_000151)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2464, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2464, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0116, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000152 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000152")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000152, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000137")
	Talk(7,MISSCRIPT_NPCSCRIPT04_LUA_000137)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  迷失的考古队成员C
------------------------------------------------------------
function mmm_talk15()
	MISSCRIPT_NPCSCRIPT04_LUA_000153 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000153")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000153 )
	MISSCRIPT_NPCSCRIPT04_LUA_000154 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000154")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000154, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT04_LUA_000155 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000155")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000155, JumpPage, 9)

	MISSCRIPT_NPCSCRIPT04_LUA_000156 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000156")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000156 )
	MISSCRIPT_NPCSCRIPT04_LUA_000157 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000157")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000157, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000158")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000158, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000159 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000159")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000159, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT04_LUA_000160 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000160")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000160, JumpPage, 6)
	MISSCRIPT_NPCSCRIPT04_LUA_000161 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000161")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000161, JumpPage, 7)

	MISSCRIPT_NPCSCRIPT04_LUA_000162 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000162")
	Talk(3,MISSCRIPT_NPCSCRIPT04_LUA_000162)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2472, 1 )
	TriggerCondition( 1, HasItem, 1778, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2472, 1 )
	TriggerAction( 1, TakeItem, 1778, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0413, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000163 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000163")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000163, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000164 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000164")
	Talk(4,MISSCRIPT_NPCSCRIPT04_LUA_000164)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2477, 1 )
	TriggerCondition( 1, HasItem, 1778, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2477, 1 )
	TriggerAction( 1, TakeItem, 1778, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0602, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000165 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000165")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000165, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000166 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000166")
	Talk(5,MISSCRIPT_NPCSCRIPT04_LUA_000166)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2483, 1 )
	TriggerCondition( 1, HasItem, 1778, 30 )
	TriggerCondition( 1, HasItem, 1657, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2483, 1 )
	TriggerAction( 1, TakeItem, 1778, 30 )
	TriggerAction( 1, TakeItem, 1657, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0824, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000167 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000167")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000167, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000168 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000168")
	Talk(6,MISSCRIPT_NPCSCRIPT04_LUA_000168)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2487, 1 )
	TriggerCondition( 1, HasItem, 1778, 30 )
	TriggerCondition( 1, HasItem, 1631, 20 )
	TriggerCondition( 1, HasItem, 3391, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2487, 1 )
	TriggerAction( 1, TakeItem, 1778, 30 )
	TriggerAction( 1, TakeItem, 1631, 20 )
	TriggerAction( 1, TakeItem, 3391, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 2223, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000169 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000169")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000169, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000170 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000170")
	Talk(7,MISSCRIPT_NPCSCRIPT04_LUA_000170)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2466, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2466, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0151, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000171 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000171")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000171, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000137")
	Talk(8,MISSCRIPT_NPCSCRIPT04_LUA_000137)

	MISSCRIPT_NPCSCRIPT04_LUA_000172 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000172")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000172 )
	MISSCRIPT_NPCSCRIPT04_LUA_000173 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000173")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000173, JumpPage, 10)
	MISSCRIPT_NPCSCRIPT04_LUA_000174 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000174")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000174, JumpPage, 11)
	MISSCRIPT_NPCSCRIPT04_LUA_000175 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000175")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000175, JumpPage, 12)
	MISSCRIPT_NPCSCRIPT04_LUA_000176 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000176")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000176, JumpPage, 7)

	MISSCRIPT_NPCSCRIPT04_LUA_000177 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000177")
	Talk(10,MISSCRIPT_NPCSCRIPT04_LUA_000177)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2472, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2472, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0411, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000178 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000178")
	Text( 10, MISSCRIPT_NPCSCRIPT04_LUA_000178, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000179 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000179")
	Talk(11,MISSCRIPT_NPCSCRIPT04_LUA_000179)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2474, 1 )
	TriggerCondition( 1, HasItem, 1699, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2474, 1 )
	TriggerAction( 1, TakeItem, 1699, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0600, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000180 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000180")
	Text( 11, MISSCRIPT_NPCSCRIPT04_LUA_000180, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000181 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000181")
	Talk(12,MISSCRIPT_NPCSCRIPT04_LUA_000181)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2479, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1631, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2479, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1631, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0760, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000182")
	Text( 12, MISSCRIPT_NPCSCRIPT04_LUA_000182, MultiTrigger, GetMultiTrigger(), 1)
end

------------------------------------------------------------
-- 加勒比海盗版本 -----  迷失的考古队成员D
------------------------------------------------------------
function mmm_talk26()
	MISSCRIPT_NPCSCRIPT04_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000183")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000183 )
	MISSCRIPT_NPCSCRIPT04_LUA_000184 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000184")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000184, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT04_LUA_000185 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000185")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000185, JumpPage, 9)

	MISSCRIPT_NPCSCRIPT04_LUA_000186 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000186")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000186 )
	MISSCRIPT_NPCSCRIPT04_LUA_000187 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000187")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000187, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000188 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000188")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000188, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000189 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000189")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000189, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT04_LUA_000190 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000190")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000190, JumpPage, 6)
	MISSCRIPT_NPCSCRIPT04_LUA_000191 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000191")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000191, JumpPage, 7)

	MISSCRIPT_NPCSCRIPT04_LUA_000192 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000192")
	Talk(3,MISSCRIPT_NPCSCRIPT04_LUA_000192)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2471, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2471, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0408, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000193 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000193")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000193, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000194 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000194")
	Talk(4,MISSCRIPT_NPCSCRIPT04_LUA_000194)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2476, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2476, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0598, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000195 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000195")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000195, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000196 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000196")
	Talk(5,MISSCRIPT_NPCSCRIPT04_LUA_000196)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2482, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1657, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2482, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1657, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0758, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000197 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000197")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000197, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000198 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000198")
	Talk(6,MISSCRIPT_NPCSCRIPT04_LUA_000198)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2486, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1631, 20 )
	TriggerCondition( 1, HasItem, 3391, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2486, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1631, 20 )
	TriggerAction( 1, TakeItem, 3391, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 2221, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000199 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000199")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000199, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000200")
	Talk(7,MISSCRIPT_NPCSCRIPT04_LUA_000200)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2461, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2461, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0110, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000201 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000201")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000201, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000137")
	Talk(8,MISSCRIPT_NPCSCRIPT04_LUA_000137)

	MISSCRIPT_NPCSCRIPT04_LUA_000202 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000202")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000202 )
	MISSCRIPT_NPCSCRIPT04_LUA_000203 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000203")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000203, JumpPage, 10)
	MISSCRIPT_NPCSCRIPT04_LUA_000204 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000204")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000204, JumpPage, 11)
	MISSCRIPT_NPCSCRIPT04_LUA_000205 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000205")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000205, JumpPage, 12)
	MISSCRIPT_NPCSCRIPT04_LUA_000206 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000206")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000206, JumpPage, 7)

	MISSCRIPT_NPCSCRIPT04_LUA_000207 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000207")
	Talk(10,MISSCRIPT_NPCSCRIPT04_LUA_000207)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2468, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1631, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2468, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1631, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0406, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000208 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000208")
	Text( 10, MISSCRIPT_NPCSCRIPT04_LUA_000208, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000209 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000209")
	Talk(11,MISSCRIPT_NPCSCRIPT04_LUA_000209)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2476, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2476, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0596, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000210 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000210")
	Text( 11, MISSCRIPT_NPCSCRIPT04_LUA_000210, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000211")
	Talk(12,MISSCRIPT_NPCSCRIPT04_LUA_000211)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2480, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1631, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2480, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1631, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0756, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000212")
	Text( 12, MISSCRIPT_NPCSCRIPT04_LUA_000212, MultiTrigger, GetMultiTrigger(), 1)
end

------------------------------------------------------------
-- 加勒比海盗版本 -----  迷失的考古队成员E
------------------------------------------------------------
function mmm_talk27()
	MISSCRIPT_NPCSCRIPT04_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000213")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000213 )
	MISSCRIPT_NPCSCRIPT04_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000214")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000214, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT04_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000215")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000215, JumpPage, 9)

	MISSCRIPT_NPCSCRIPT04_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000216")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000216 )
	MISSCRIPT_NPCSCRIPT04_LUA_000217 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000217")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000217, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000218 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000218")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000218, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000219 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000219")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000219, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT04_LUA_000220 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000220")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000220, JumpPage, 6)
	MISSCRIPT_NPCSCRIPT04_LUA_000221 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000221")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000221, JumpPage, 7)

	MISSCRIPT_NPCSCRIPT04_LUA_000222 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000222")
	Talk(3,MISSCRIPT_NPCSCRIPT04_LUA_000222)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2470, 1 )
	TriggerCondition( 1, HasItem, 1699, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2470, 1 )
	TriggerAction( 1, TakeItem, 1699, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0404, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000223 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000223")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000223, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000224 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000224")
	Talk(4,MISSCRIPT_NPCSCRIPT04_LUA_000224)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2475, 1 )
	TriggerCondition( 1, HasItem, 1699, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2475, 1 )
	TriggerAction( 1, TakeItem, 1699, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0594, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000225 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000225")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000225, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000226 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000226")
	Talk(5,MISSCRIPT_NPCSCRIPT04_LUA_000226)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2481, 1 )
	TriggerCondition( 1, HasItem, 1699, 30 )
	TriggerCondition( 1, HasItem, 1657, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2481, 1 )
	TriggerAction( 1, TakeItem, 1699, 30 )
	TriggerAction( 1, TakeItem, 1657, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0754, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000227 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000227")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000227, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000228 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000228")
	Talk(6,MISSCRIPT_NPCSCRIPT04_LUA_000228)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2485, 1 )
	TriggerCondition( 1, HasItem, 1699, 30 )
	TriggerCondition( 1, HasItem, 1631, 20 )
	TriggerCondition( 1, HasItem, 3391, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2485, 1 )
	TriggerAction( 1, TakeItem, 1699, 30 )
	TriggerAction( 1, TakeItem, 1631, 20 )
	TriggerAction( 1, TakeItem, 3391, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 2219, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000229 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000229")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000229, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000230 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000230")
	Talk(7,MISSCRIPT_NPCSCRIPT04_LUA_000230)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2462, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2462, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0112, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000231 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000231")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000231, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000137")
	Talk(8,MISSCRIPT_NPCSCRIPT04_LUA_000137)

	MISSCRIPT_NPCSCRIPT04_LUA_000232 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000232")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000232 )
	MISSCRIPT_NPCSCRIPT04_LUA_000233 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000233")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000233, JumpPage, 10)
	MISSCRIPT_NPCSCRIPT04_LUA_000234 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000234")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000234, JumpPage, 11)
	MISSCRIPT_NPCSCRIPT04_LUA_000235 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000235")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000235, JumpPage, 12)
	MISSCRIPT_NPCSCRIPT04_LUA_000236 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000236")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000236, JumpPage, 7)

	MISSCRIPT_NPCSCRIPT04_LUA_000237 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000237")
	Talk(10,MISSCRIPT_NPCSCRIPT04_LUA_000237)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2470, 1 )
	TriggerCondition( 1, HasItem, 1699, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2470, 1 )
	TriggerAction( 1, TakeItem, 1699, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0402, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000238 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000238")
	Text( 10, MISSCRIPT_NPCSCRIPT04_LUA_000238, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000239 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000239")
	Talk(11,MISSCRIPT_NPCSCRIPT04_LUA_000239)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2478, 1 )
	TriggerCondition( 1, HasItem, 1630, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2478, 1 )
	TriggerAction( 1, TakeItem, 1630, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0592, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000240 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000240")
	Text( 11, MISSCRIPT_NPCSCRIPT04_LUA_000240, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000241 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000241")
	Talk(12,MISSCRIPT_NPCSCRIPT04_LUA_000241)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2482, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2482, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0752, 1 , 4)
	TriggerFailure( 1, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000242 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000242")
	Text( 12, MISSCRIPT_NPCSCRIPT04_LUA_000242, MultiTrigger, GetMultiTrigger(), 1)
end

------------------------------------------------------------
-- 加勒比海盗版本 -----  迷失的考古队成员F
------------------------------------------------------------
function mmm_talk28()
	MISSCRIPT_NPCSCRIPT04_LUA_000243 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000243")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000243 )
	MISSCRIPT_NPCSCRIPT04_LUA_000244 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000244")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000244, JumpPage, 2)

	MISSCRIPT_NPCSCRIPT04_LUA_000245 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000245")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000245 )
	MISSCRIPT_NPCSCRIPT04_LUA_000246 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000246")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000246, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000247 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000247")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000247, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000248 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000248")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000248, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT04_LUA_000249 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000249")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000249, JumpPage, 6)

	MISSCRIPT_NPCSCRIPT04_LUA_000250 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000250")
	Talk(3,MISSCRIPT_NPCSCRIPT04_LUA_000250)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2469, 1 )
	TriggerCondition( 1, HasItem, 3364, 30 )
	TriggerCondition( 1, HasItem, 1608, 20 )
	TriggerCondition( 1, HasItem, 3385, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2469, 1 )
	TriggerAction( 1, TakeItem, 3364, 30 )
	TriggerAction( 1, TakeItem, 1608, 20 )
	TriggerAction( 1, TakeItem, 3385, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0400, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000251 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000251")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000251, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000252 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000252")
	Talk(4,MISSCRIPT_NPCSCRIPT04_LUA_000252)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2474, 1 )
	TriggerCondition( 1, HasItem, 3364, 30 )
	TriggerCondition( 1, HasItem, 1614, 20 )
	TriggerCondition( 1, HasItem, 1658, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2474, 1 )
	TriggerAction( 1, TakeItem, 3364, 30 )
	TriggerAction( 1, TakeItem, 1614, 20 )
	TriggerAction( 1, TakeItem, 1658, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0590, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000253")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000253, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000254 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000254")
	Talk(5,MISSCRIPT_NPCSCRIPT04_LUA_000254)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2480, 1 )
	TriggerCondition( 1, HasItem, 3364, 30 )
	TriggerCondition( 1, HasItem, 1657, 20 )
	TriggerCondition( 1, HasItem, 3361, 10 )
	TriggerCondition( 1, HasMoney, 50000 )
	TriggerAction( 1, TakeItem, 2480, 1 )
	TriggerAction( 1, TakeItem, 3364, 30 )
	TriggerAction( 1, TakeItem, 1657, 20 )
	TriggerAction( 1, TakeItem, 3361, 10 )
	TriggerAction( 1, TakeMoney, 50000 )

	TriggerAction( 1, GiveItem, 0750, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000255 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000255")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000255, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000256 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000256")
	Talk(6,MISSCRIPT_NPCSCRIPT04_LUA_000256)
	InitTrigger()
	TriggerCondition( 1, HasItem, 2465, 1 )
	TriggerCondition( 1, HasItem, 3380, 30 )
	TriggerCondition( 1, HasItem, 1652, 20 )
	TriggerCondition( 1, HasItem, 1626, 10 )
	TriggerCondition( 1, HasMoney, 100000 )
	TriggerAction( 1, TakeItem, 2465, 1 )
	TriggerAction( 1, TakeItem, 3380, 30 )
	TriggerAction( 1, TakeItem, 1652, 20 )
	TriggerAction( 1, TakeItem, 1626, 10 )
	TriggerAction( 1, TakeMoney, 100000 )

	TriggerAction( 1, GiveItem, 0118, 1 , 4)
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000257 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000257")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000257, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000137")
	Talk(7,MISSCRIPT_NPCSCRIPT04_LUA_000137)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  陆地一层传送使
------------------------------------------------------------
function mmm_talk16()
	--地图名称信息
	local CurMapName = "jialebi"


	--海军码头坐标
	local GoTo01X = 1250
	local GoTo01Y = 1010
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000258 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000258")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000258 )
	MISSCRIPT_NPCSCRIPT04_LUA_000259 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000259")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000259, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000260 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000260")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000260, JumpPage, 3 )

	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000261 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000261")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000261 )
	MISSCRIPT_NPCSCRIPT04_LUA_000262 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000262")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000262, MultiTrigger,GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000263 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000263")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000263 )
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264, CloseTalk)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  实验室看守人A
------------------------------------------------------------
function mmm_talk17()
	--地图名称信息
	local CurMapName = "jialebi"

	--实验室A坐标
	local GoTo01X = 968
	local GoTo01Y = 828
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000265")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000265 )
	MISSCRIPT_NPCSCRIPT04_LUA_000259 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000259")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000259, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000260 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000260")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000260, JumpPage, 3 )
	
	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )

	MISSCRIPT_NPCSCRIPT04_LUA_000266 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000266")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000266 )
	MISSCRIPT_NPCSCRIPT04_LUA_000267 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000267")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000267, MultiTrigger,GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000263 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000263")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000263 )
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264, CloseTalk)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  实验室看守人B2386
------------------------------------------------------------
function mmm_talk18()
	--地图名称信息
	local CurMapName = "jialebi"


	--实验室B坐标
	local GoTo01X = 968
	local GoTo01Y = 906
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000268 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000268")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000268 )
	MISSCRIPT_NPCSCRIPT04_LUA_000269 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000269")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000269, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000270 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000270")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000270, JumpPage, 3 )

	InitTrigger()
	TriggerCondition( 1, HasItem, 2386, 20 )
	TriggerAction( 1, TakeItem, 2386, 20 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )

	MISSCRIPT_NPCSCRIPT04_LUA_000271 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000271")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000271 )
	MISSCRIPT_NPCSCRIPT04_LUA_000272 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000272")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000272, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000263 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000263")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000263 )
	MISSCRIPT_NPCSCRIPT04_LUA_000273 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000273")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000273, CloseTalk)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  实验室看守人C
------------------------------------------------------------
function mmm_talk19()
	--地图名称信息
	local CurMapName = "jialebi"


	--实验室C坐标
	local GoTo01X = 968
	local GoTo01Y = 993
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000265")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000265 )
	MISSCRIPT_NPCSCRIPT04_LUA_000259 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000259")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000259, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000260 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000260")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000260, JumpPage, 3 )

	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )

	MISSCRIPT_NPCSCRIPT04_LUA_000274 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000274")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000274 )
	MISSCRIPT_NPCSCRIPT04_LUA_000275 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000275")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000275, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000263 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000263")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000263 )
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264, CloseTalk)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  地下船坞守卫
------------------------------------------------------------
function mmm_talk20()
	--地图名称信息
	local CurMapName = "jialebi"


	--实验室坐标
	local GoTo01X = 1076
	local GoTo01Y = 869
	local GoTo01M = CurMapName

	MISSCRIPT_NPCSCRIPT04_LUA_000276 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000276")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000276 )
	MISSCRIPT_NPCSCRIPT04_LUA_000277 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000277")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000277, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000278")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000278, JumpPage, 3 )

	InitTrigger()
	TriggerCondition(1,HasItem , 2408,1)
	TriggerCondition(1,HasItem , 2409,1)
	TriggerCondition(1,HasItem , 2410,1)
	TriggerCondition(1,HasItem , 2411,1)
	TriggerCondition(1,HasItem , 2412,1)

	TriggerAction(1,TakeItem,2408,1)
	TriggerAction(1,TakeItem,2409,1)
	TriggerAction(1,TakeItem,2410,1)
	TriggerAction(1,TakeItem,2411,1)
	TriggerAction(1,TakeItem,2412,1)

	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000279 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000279")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000279 )
	MISSCRIPT_NPCSCRIPT04_LUA_000280 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000280")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000280, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000281 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000281")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000281 )
	MISSCRIPT_NPCSCRIPT04_LUA_000282 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000282")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000282, CloseTalk)
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  地狱一层炼狱人
------------------------------------------------------------
function mmm_talk22()
	--地图名称信息
	local CurMapName = "jialebi"


	--地狱二层坐标
	local GoTo01X = 79
	local GoTo01Y = 823
	local GoTo01M = CurMapName


	MISSCRIPT_NPCSCRIPT04_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000265")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000265 )
	MISSCRIPT_NPCSCRIPT04_LUA_000259 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000259")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000259, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000260 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000260")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000260, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000283 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000283")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000283, JumpPage, 5 )


	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )

	MISSCRIPT_NPCSCRIPT04_LUA_000284 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000284")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000284 )
	MISSCRIPT_NPCSCRIPT04_LUA_000285 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000285")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000285, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000263 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000263")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000263 )
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264 ,CloseTalk)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 1 )
	TriggerAction( 1, TakeItem, 3457, 1 )
	TriggerAction( 1, GiveItem, 0267, 1, 4 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000286 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000286")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000286 )
	MISSCRIPT_NPCSCRIPT04_LUA_000287 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000287")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000287, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000288 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000288")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000288 )
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  地狱二层炼狱人
------------------------------------------------------------
function mmm_talk23()
	--地图名称信息
	local CurMapName = "jialebi"


	--地狱一层坐标
	local GoTo01X = 199
	local GoTo01Y = 824
	local GoTo01M = CurMapName

	--地狱三层坐标
	local GoTo02X = 70
	local GoTo02Y = 952
	local GoTo02M = CurMapName


	MISSCRIPT_NPCSCRIPT04_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000265")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000265 )
	MISSCRIPT_NPCSCRIPT04_LUA_000289 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000289")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000289, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000290 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000290")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000290, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000283 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000283")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000283, JumpPage, 5 )

	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000291 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000291")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000291 )
	MISSCRIPT_NPCSCRIPT04_LUA_000292 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000292")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000292, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition(2,HasMoney,5000)
	TriggerAction(2,TakeMoney,5000)
	TriggerAction( 2, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000293 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000293")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000293 )
	MISSCRIPT_NPCSCRIPT04_LUA_000294 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000294")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000294, MultiTrigger, GetMultiTrigger(),2 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264 ,CloseTalk)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 1 )
	TriggerAction( 1, TakeItem, 3457, 1 )
	TriggerAction( 1, GiveItem, 0268, 1, 4 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000295 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000295")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000295 )
	MISSCRIPT_NPCSCRIPT04_LUA_000296 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000296")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000296, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000297 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000297")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000297 )
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  地狱三层炼狱人
------------------------------------------------------------
function mmm_talk24()

	--地图名称信息
	local CurMapName = "jialebi"


	--地狱二层坐标
	local GoTo01X = 79
	local GoTo01Y = 823
	local GoTo01M = CurMapName

	--地狱四层坐标
	local GoTo02X = 209
	local GoTo02Y = 955
	local GoTo02M = CurMapName


	MISSCRIPT_NPCSCRIPT04_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000265")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000265 )
	MISSCRIPT_NPCSCRIPT04_LUA_000298 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000298")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000298, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000299 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000299")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000299, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000283 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000283")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000283, JumpPage, 5 )

	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000284 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000284")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000284 )
	MISSCRIPT_NPCSCRIPT04_LUA_000285 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000285")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000285, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition(2,HasMoney,5000)
	TriggerAction(2,TakeMoney,5000)
	TriggerAction( 2, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000300 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000300")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000300 )
	MISSCRIPT_NPCSCRIPT04_LUA_000301 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000301")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000301, MultiTrigger, GetMultiTrigger(), 2 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264 ,CloseTalk)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 1 )
	TriggerAction( 1, TakeItem, 3457, 1 )
	TriggerAction( 1, GiveItem, 0269, 1, 4 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000302 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000302")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000302 )
	MISSCRIPT_NPCSCRIPT04_LUA_000303 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000303")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000303, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000304 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000304")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000304 )
end
------------------------------------------------------------
-- 加勒比海盗版本 -----  地狱四层炼狱人
------------------------------------------------------------
function mmm_talk25()

		--地图名称信息
	local CurMapName = "jialebi"


	--地狱三层坐标
	local GoTo01X = 70
	local GoTo01Y = 952
	local GoTo01M = CurMapName

	--藏宝海湾坐标
	local GoTo02X = 690
	local GoTo02Y = 1043
	local GoTo02M = CurMapName


	MISSCRIPT_NPCSCRIPT04_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000265")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000265 )
	MISSCRIPT_NPCSCRIPT04_LUA_000305 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000305")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000305, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000306 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000306")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000306, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000283 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000283")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000283, JumpPage, 5 )

	InitTrigger()
	TriggerCondition(1,HasMoney,5000)
	TriggerAction(1,TakeMoney,5000)
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000293 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000293")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000293 )
	MISSCRIPT_NPCSCRIPT04_LUA_000294 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000294")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000294, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition(2,HasMoney,5000)
	TriggerAction(2,TakeMoney,5000)
	TriggerAction( 2, GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000307 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000307")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000307 )
	MISSCRIPT_NPCSCRIPT04_LUA_000308 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000308")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000308, MultiTrigger, GetMultiTrigger(), 2 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000264")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000264 ,CloseTalk)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 1 )
	TriggerAction( 1, TakeItem, 3457, 1 )
	TriggerAction( 1, GiveItem, 0270, 1, 4 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000309 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000309")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000309 )
	MISSCRIPT_NPCSCRIPT04_LUA_000310 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000310")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000310, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000311 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000311")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000311 )
end


------------------------------------------------------------
-- 藏宝海湾 传送使
------------------------------------------------------------

function mmm_talk29()
	--取消传送返回选择传送地点的对话内容和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000001")
	local ReSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000001
	local ReSelectPage = 1

	--取消传送和退出传送的对话和页面编号
	MISSCRIPT_NPCSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000002")
	local CancelSelectTalk = MISSCRIPT_NPCSCRIPT02_LUA_000002
	local CancelSelectPage = 7

	--地图名称信息
	local CurMapName1 = "garner"
	local CurMapName2 = "magicsea"
	local CurMapName5 = "darkblue"

	--白银之城坐标
	local GoTo01X = 2231
	local GoTo01Y = 2788
	local GoTo01M = CurMapName1

	--沙岚之城坐标
	local GoTo02X = 890
	local GoTo02Y = 3575
	local GoTo02M = CurMapName2

	--冰狼堡坐标
	local GoTo04X = 1318
	local GoTo04Y = 510
	local GoTo04M = CurMapName5

	MISSCRIPT_NPCSCRIPT04_LUA_000312 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000312")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000312 )
	MISSCRIPT_NPCSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000030")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000030, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000004")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000004, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000006")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000006, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text( 1, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 5 )
	
	InitTrigger()
	TriggerCondition( 1, HasMoney, 500 )
	TriggerAction( 1, TakeMoney, 500 )
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000313 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000313")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000313 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2 ) 
	Text( 2, CancelSelectTalk, JumpPage , CancelSelectPage )


	InitTrigger()
	TriggerCondition( 1, HasMoney, 500 )
	TriggerAction( 1, TakeMoney, 500 )
	TriggerAction( 1,  GoTo, GoTo02X, GoTo02Y, GoTo02M )
	TriggerFailure( 2, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000314 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000314")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000314 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 3, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 3, CancelSelectTalk, JumpPage , CancelSelectPage )


	InitTrigger()
	TriggerCondition( 1, HasMoney, 500 )
	TriggerAction( 1, TakeMoney, 500 )
	TriggerAction( 1, GoTo, GoTo04X, GoTo04Y, GoTo04M )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000315 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000315")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000315 )
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 4, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 2)
	Text( 4, CancelSelectTalk, JumpPage , CancelSelectPage )

	MISSCRIPT_NPCSCRIPT02_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000047")
	Talk( 6, MISSCRIPT_NPCSCRIPT02_LUA_000047 )

	MISSCRIPT_NPCSCRIPT02_LUA_000009 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000009")
	Talk( 7, MISSCRIPT_NPCSCRIPT02_LUA_000009, CloseTalk )
	MISSCRIPT_NPCSCRIPT04_LUA_000316 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000316")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000316 )



	InitTrigger()
	TriggerAction( 1, JumpPage, 1 )
	TriggerAction( 2, JumpPage, 8 )
	Start( GetMultiTrigger(), 2 )

	

end


-- 女神
------------------------------------------------------------

	
function mmm_talk30()

	local CurMapName1 = "garner"
	local CurMapName2 = "magicsea"
	local CurMapName5 = "darkblue"

	--白银之城坐标
	local GoTo01X = 2231
	local GoTo01Y = 2788
	local GoTo01M = CurMapName1	

	MISSCRIPT_NPCSCRIPT04_LUA_000317 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000317")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000317 )
	MISSCRIPT_NPCSCRIPT04_LUA_000318 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000318")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000318, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000319 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000319")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000319, JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT04_LUA_000320 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000320")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000320, CloseTalk )	
	InitTrigger()
	TriggerAction( 1, GoTo, 631, 927, "jialebi" )
	MISSCRIPT_NPCSCRIPT04_LUA_000321 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000321")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000321, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasRecord, 1322 )
	TriggerAction ( 1, JumpPage, 25 )
	TriggerFailure( 1, JumpPage, 26 )
	--Text( 1, "智慧之心", MultiTrigger, GetMultiTrigger() ,1 )    -------智慧之心-------
	
	MISSCRIPT_NPCSCRIPT04_LUA_000322 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000322")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000322 )
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 41 )
	TriggerCondition( 1, LvCheck, ">", 14 )
	TriggerAction ( 1, JumpPage, 4 )
	TriggerFailure( 1, JumpPage, 16 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000323 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000323")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000323,MultiTrigger, GetMultiTrigger() ,1)

	InitTrigger()
	TriggerCondition( 1, LvCheck, ">", 40 )
	TriggerCondition( 1, LvCheck, "<", 61 )
	TriggerAction ( 1, JumpPage, 5 )
	TriggerFailure( 1, JumpPage, 16 )

	MISSCRIPT_NPCSCRIPT04_LUA_000324 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000324")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000324,MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, LvCheck, ">", 60 )
	TriggerAction ( 1, JumpPage, 6 )
	TriggerFailure( 1, JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT04_LUA_000325 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000325")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000325,MultiTrigger, GetMultiTrigger(), 1)


	MISSCRIPT_NPCSCRIPT04_LUA_000326 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000326")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000326 )
	MISSCRIPT_NPCSCRIPT04_LUA_000327 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000327")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000327, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000328 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000328")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000328, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000329 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000329")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000329, JumpPage, 9 )


	MISSCRIPT_NPCSCRIPT04_LUA_000326 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000326")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000326 )
	MISSCRIPT_NPCSCRIPT04_LUA_000327 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000327")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000327, JumpPage, 10 )
	MISSCRIPT_NPCSCRIPT04_LUA_000328 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000328")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000328, JumpPage, 11 )
	MISSCRIPT_NPCSCRIPT04_LUA_000329 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000329")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000329, JumpPage, 12 )

	MISSCRIPT_NPCSCRIPT04_LUA_000326 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000326")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000326 )
	MISSCRIPT_NPCSCRIPT04_LUA_000327 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000327")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000327, JumpPage, 13 )
	MISSCRIPT_NPCSCRIPT04_LUA_000328 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000328")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000328, JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT04_LUA_000329 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000329")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000329, JumpPage, 15 )

		InitFuncList()
	AddFuncList( CreditExchange,0 )
	MISSCRIPT_NPCSCRIPT04_LUA_000330 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000330")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000330 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 7,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange,3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000332 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000332")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000332 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 8, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 8,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange, 6 )--对换钱
	MISSCRIPT_NPCSCRIPT04_LUA_000333 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000333")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000333 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 9, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 9,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )


	InitFuncList()
	AddFuncList( CreditExchange,1 )
	MISSCRIPT_NPCSCRIPT04_LUA_000330 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000330")
	Talk( 10, MISSCRIPT_NPCSCRIPT04_LUA_000330 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 10, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 10,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange,4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000332 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000332")
	Talk( 11, MISSCRIPT_NPCSCRIPT04_LUA_000332 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 11, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 11,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange, 7 )--对换钱
	MISSCRIPT_NPCSCRIPT04_LUA_000333 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000333")
	Talk( 12, MISSCRIPT_NPCSCRIPT04_LUA_000333 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 12, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 12,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange,2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000330 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000330")
	Talk( 13, MISSCRIPT_NPCSCRIPT04_LUA_000330 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 13, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 13,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange,5 )
	MISSCRIPT_NPCSCRIPT04_LUA_000332 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000332")
	Talk( 14, MISSCRIPT_NPCSCRIPT04_LUA_000332 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 14, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 14,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	InitFuncList()
	AddFuncList( CreditExchange, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000333 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000333")
	Talk( 15, MISSCRIPT_NPCSCRIPT04_LUA_000333 )
	MISSCRIPT_NPCSCRIPT04_LUA_000331 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000331")
	Text( 15, MISSCRIPT_NPCSCRIPT04_LUA_000331, MultiFunc, GetFuncList(), GetNumFunc() ) 
	MISSCRIPT_NPCSCRIPT01_LUA_001509 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001509")
	Text( 15,MISSCRIPT_NPCSCRIPT01_LUA_001509,JumpPage , 4 )

	MISSCRIPT_NPCSCRIPT04_LUA_000334 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000334")
	Talk( 16, MISSCRIPT_NPCSCRIPT04_LUA_000334 )

	InitTrigger()
	TriggerAction( 1, GoTo, GoTo01X, GoTo01Y, GoTo01M )
	MISSCRIPT_NPCSCRIPT04_LUA_000335 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000335")
	Text( 16, MISSCRIPT_NPCSCRIPT04_LUA_000335, MultiTrigger, GetMultiTrigger(), 1 )
	MISSCRIPT_NPCSCRIPT04_LUA_000336 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000336")
	Text( 16,MISSCRIPT_NPCSCRIPT04_LUA_000336,JumpPage , 2 )

	
	MISSCRIPT_NPCSCRIPT04_LUA_000337 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000337")
	Talk( 17, MISSCRIPT_NPCSCRIPT04_LUA_000337 )
	MISSCRIPT_NPCSCRIPT04_LUA_000338 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000338")
	Text( 17, MISSCRIPT_NPCSCRIPT04_LUA_000338, JumpPage, 18)
	MISSCRIPT_NPCSCRIPT04_LUA_000339 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000339")
	Text( 17, MISSCRIPT_NPCSCRIPT04_LUA_000339, JumpPage, 19)
	MISSCRIPT_NPCSCRIPT04_LUA_000340 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000340")
	Text( 17, MISSCRIPT_NPCSCRIPT04_LUA_000340, JumpPage, 20)
	MISSCRIPT_NPCSCRIPT04_LUA_000341 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000341")
	Text( 17, MISSCRIPT_NPCSCRIPT04_LUA_000341, JumpPage, 21)
	MISSCRIPT_NPCSCRIPT04_LUA_000342 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000342")
	Text( 17, MISSCRIPT_NPCSCRIPT04_LUA_000342, JumpPage, 22)
	MISSCRIPT_NPCSCRIPT04_LUA_000343 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000343")
	Text( 17, MISSCRIPT_NPCSCRIPT04_LUA_000343, JumpPage, 23)  
	
	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, LvCheck, ">", 59 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, GiveItem, 2530, 1, 4 )
	TriggerFailure( 1, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT04_LUA_000344 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000344")
	Talk( 18, MISSCRIPT_NPCSCRIPT04_LUA_000344 )
	MISSCRIPT_NPCSCRIPT04_LUA_000345 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000345")
	Text( 18, MISSCRIPT_NPCSCRIPT04_LUA_000345, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, LvCheck, ">", 59 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, GiveItem, 2533, 1, 4 )
	TriggerFailure( 1, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT04_LUA_000344 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000344")
	Talk( 19, MISSCRIPT_NPCSCRIPT04_LUA_000344 )
	MISSCRIPT_NPCSCRIPT04_LUA_000346 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000346")
	Text( 19, MISSCRIPT_NPCSCRIPT04_LUA_000346, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, LvCheck, ">", 59 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, GiveItem, 2536, 1, 4 )
	TriggerFailure( 1, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT04_LUA_000344 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000344")
	Talk( 20, MISSCRIPT_NPCSCRIPT04_LUA_000344 )
	MISSCRIPT_NPCSCRIPT04_LUA_000347 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000347")
	Text( 20, MISSCRIPT_NPCSCRIPT04_LUA_000347, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, LvCheck, ">", 59 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, GiveItem, 2539, 1, 4 )
	TriggerFailure( 1, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT04_LUA_000344 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000344")
	Talk( 21, MISSCRIPT_NPCSCRIPT04_LUA_000344 )
	MISSCRIPT_NPCSCRIPT04_LUA_000348 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000348")
	Text( 21, MISSCRIPT_NPCSCRIPT04_LUA_000348, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, LvCheck, ">", 59 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, GiveItem, 2542, 1, 4 )
	TriggerFailure( 1, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT04_LUA_000344 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000344")
	Talk( 22, MISSCRIPT_NPCSCRIPT04_LUA_000344 )
	MISSCRIPT_NPCSCRIPT04_LUA_000349 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000349")
	Text( 22, MISSCRIPT_NPCSCRIPT04_LUA_000349, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 3457, 5 )
	TriggerCondition( 1, LvCheck, ">", 59 )
	TriggerAction( 1, TakeItem, 3457, 5 )
	TriggerAction( 1, GiveItem, 2545, 1, 4 )
	TriggerFailure( 1, JumpPage, 24 )
	MISSCRIPT_NPCSCRIPT04_LUA_000344 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000344")
	Talk( 23, MISSCRIPT_NPCSCRIPT04_LUA_000344 )
	MISSCRIPT_NPCSCRIPT04_LUA_000350 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000350")
	Text( 23, MISSCRIPT_NPCSCRIPT04_LUA_000350, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000351 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000351")
	Talk( 24, MISSCRIPT_NPCSCRIPT04_LUA_000351)
	
	
	MISSCRIPT_NPCSCRIPT04_LUA_000352 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000352")
	Talk( 25, MISSCRIPT_NPCSCRIPT04_LUA_000352)  ---------奥运活动相关对话----------
	MISSCRIPT_NPCSCRIPT04_LUA_000353 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000353")
	Text( 25, MISSCRIPT_NPCSCRIPT04_LUA_000353, JumpPage, 27)
	MISSCRIPT_NPCSCRIPT04_LUA_000354 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000354")
	Text( 25, MISSCRIPT_NPCSCRIPT04_LUA_000354, CloseTalk )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000355 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000355")
	Talk( 26, MISSCRIPT_NPCSCRIPT04_LUA_000355)
	MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
	Text( 26, MISSCRIPT_NPCSCRIPT01_LUA_000005, CloseTalk )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000356 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000356")
	Talk( 27, MISSCRIPT_NPCSCRIPT04_LUA_000356)
	MISSCRIPT_NPCSCRIPT04_LUA_000357 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000357")
	Text( 27, MISSCRIPT_NPCSCRIPT04_LUA_000357, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000358 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000358")
	Text( 27, MISSCRIPT_NPCSCRIPT04_LUA_000358, JumpPage, 29)                   --正确
	MISSCRIPT_NPCSCRIPT04_LUA_000359 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000359")
	Text( 27, MISSCRIPT_NPCSCRIPT04_LUA_000359, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000360 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000360")
	Text( 27, MISSCRIPT_NPCSCRIPT04_LUA_000360, JumpPage, 28)
	
	MISSCRIPT_NPCSCRIPT04_LUA_000361 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000361")
	Talk( 28, MISSCRIPT_NPCSCRIPT04_LUA_000361)    ---回答错误
	MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
	Text( 28, MISSCRIPT_NPCSCRIPT01_LUA_000005, CloseTalk )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000362 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000362")
	Talk( 29, MISSCRIPT_NPCSCRIPT04_LUA_000362)
	MISSCRIPT_NPCSCRIPT04_LUA_000363 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000363")
	Text( 29, MISSCRIPT_NPCSCRIPT04_LUA_000363, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000364 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000364")
	Text( 29, MISSCRIPT_NPCSCRIPT04_LUA_000364, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000365 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000365")
	Text( 29, MISSCRIPT_NPCSCRIPT04_LUA_000365, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000366 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000366")
	Text( 29, MISSCRIPT_NPCSCRIPT04_LUA_000366, JumpPage, 30)          ---正确
	MISSCRIPT_NPCSCRIPT04_LUA_000367 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000367")
	Text( 29, MISSCRIPT_NPCSCRIPT04_LUA_000367, JumpPage, 28)
	
	MISSCRIPT_NPCSCRIPT04_LUA_000368 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000368")
	Talk( 30, MISSCRIPT_NPCSCRIPT04_LUA_000368)
	MISSCRIPT_NPCSCRIPT04_LUA_000369 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000369")
	Text( 30, MISSCRIPT_NPCSCRIPT04_LUA_000369, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000370 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000370")
	Text( 30, MISSCRIPT_NPCSCRIPT04_LUA_000370, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000371 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000371")
	Text( 30, MISSCRIPT_NPCSCRIPT04_LUA_000371, JumpPage, 31)      --正确
	MISSCRIPT_NPCSCRIPT04_LUA_000372 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000372")
	Text( 30, MISSCRIPT_NPCSCRIPT04_LUA_000372, JumpPage, 28)
	
	MISSCRIPT_NPCSCRIPT04_LUA_000373 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000373")
	Talk( 31, MISSCRIPT_NPCSCRIPT04_LUA_000373)
	MISSCRIPT_NPCSCRIPT04_LUA_000374 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000374")
	Text( 31, MISSCRIPT_NPCSCRIPT04_LUA_000374, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000375 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000375")
	Text( 31, MISSCRIPT_NPCSCRIPT04_LUA_000375, JumpPage, 32)                     --正确
	MISSCRIPT_NPCSCRIPT04_LUA_000376 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000376")
	Text( 31, MISSCRIPT_NPCSCRIPT04_LUA_000376, JumpPage, 28)
	MISSCRIPT_NPCSCRIPT04_LUA_000377 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000377")
	Text( 31, MISSCRIPT_NPCSCRIPT04_LUA_000377, JumpPage, 28)	
	
	-- Talk( 32, "女神：恭喜你！都答对啦，最后让你猜猜我会给你什么奖品呢？")
	-- Text( 32, "海盗币", JumpPage, 28)
	-- Text( 32, "智慧之心", JumpPage, 33)
	-- Text( 32, "黑龙之瞳", JumpPage, 28)
	-- Text( 32, "经验值", JumpPage, 28)
	
	
	MISSCRIPT_NPCSCRIPT04_LUA_000378 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000378")
	Talk( 32, MISSCRIPT_NPCSCRIPT04_LUA_000378)
	InitTrigger()
	TriggerCondition( 1, HasRecord, 1322 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerAction( 1, ClearRecord, 1322 )
	TriggerAction( 1, GiveItem, 5801, 1, 4 )  --给予智慧之心
	TriggerAction( 1, SetRecord, 1323 )
	TriggerFailure( 1, JumpPage, 26 )	
	MISSCRIPT_NPCSCRIPT04_LUA_000379 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000379")
	Text( 32, MISSCRIPT_NPCSCRIPT04_LUA_000379, MultiTrigger, GetMultiTrigger(), 1 )
	MISSCRIPT_NPCSCRIPT01_LUA_002361 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_002361")
	Text( 32, MISSCRIPT_NPCSCRIPT01_LUA_002361, CloseTalk )
	
	-- Talk( 32, "女神：请问北京奥运会是历史上第几届奥运会？")
	-- Text( 32, "第26届", JumpPage, 28)
	-- Text( 32, "第27届", JumpPage, 28)
	-- Text( 32, "第28届", JumpPage, 28)
	-- Text( 32, "第29届", JumpPage, 34)                    --正确
	
	-- Talk( 33, "女神：请问以下哪个项目不是奥运会的比赛项目？")
	-- Text( 33, "击剑", JumpPage, 28)
	-- Text( 33, "彩票", JumpPage, 34)                      --正确
	-- Text( 33, "足球", JumpPage, 28)
	-- Text( 33, "游泳", JumpPage, 28)                      --正确
	
	
	
	
	
	
	
	
	AddNpcMission(6000)
	--奥运
	AddNpcMission (6277)
	AddNpcMission (6278)
	---------------2.0新历史任务
	AddNpcMission ( 6366 )
	AddNpcMission ( 6367 )
	AddNpcMission ( 6380 )
	AddNpcMission ( 6381 )
end

function dydz_talk()


	MISSCRIPT_NPCSCRIPT04_LUA_000380 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000380")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000380 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 40,74, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT04_LUA_000381 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000381")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000381 )
	MISSCRIPT_NPCSCRIPT04_LUA_000382 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000382")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000382 )
	MISSCRIPT_NPCSCRIPT04_LUA_000383 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000383")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000383 )
	MISSCRIPT_NPCSCRIPT04_LUA_000384 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000384")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000384 )
	MISSCRIPT_NPCSCRIPT04_LUA_000385 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000385")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000385 )

end


function dysr_talk ()

	MISSCRIPT_NPCSCRIPT04_LUA_000386 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000386")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000386 )
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage)
	MISSCRIPT_NPCSCRIPT01_LUA_000014 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000014")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000014, OpenRepair)

	InitTrade()
	Other(	1847	)
	Other(	1848	)
	Other(	1849	)
	Other(	3143	)
	Other(	637	)
	Other(	819	)
	Other(	869	)
	Other(	874	)


end 


function zsts_talk()
	MISSCRIPT_NPCSCRIPT04_LUA_000387 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000387")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000387)
	MISSCRIPT_NPCSCRIPT04_LUA_000388 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000388")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000388, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT04_LUA_000389 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000389")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000389, JumpPage, 6)

	MISSCRIPT_NPCSCRIPT04_LUA_000390 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000390")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000390)
	MISSCRIPT_NPCSCRIPT04_LUA_000391 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000391")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000391, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000392 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000392")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000392, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000393 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000393")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000393, JumpPage, 5)
	
	MISSCRIPT_NPCSCRIPT04_LUA_000394 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000394")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000394)
	MISSCRIPT_NPCSCRIPT04_LUA_000395 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000395")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000395, CloseTalk)

	MISSCRIPT_NPCSCRIPT04_LUA_000396 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000396")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000396)
	MISSCRIPT_NPCSCRIPT04_LUA_000395 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000395")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000395, CloseTalk)

	MISSCRIPT_NPCSCRIPT04_LUA_000397 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000397")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000397)
	MISSCRIPT_NPCSCRIPT04_LUA_000395 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000395")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000395, CloseTalk)

	MISSCRIPT_NPCSCRIPT04_LUA_000398 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000398")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000398 )
	MISSCRIPT_NPCSCRIPT01_LUA_001896 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001896")
	Text( 6, MISSCRIPT_NPCSCRIPT01_LUA_001896,  GetChaName1_born, 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000399 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000399")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000399,  GetChaName2_born, 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000400 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000400")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000400,  GetChaName3_born, 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000401 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000401")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000401,  GetChaName4_born, 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000402 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000402")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000402, GetChaName5_born, 1)
	MISSCRIPT_NPCSCRIPT04_LUA_000403 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000403")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000403, GetChaName6_born, 1)

	AddNpcMission ( 6071 )

end

------------------------------------------------------------
--藏宝海湾 百慕大守护者（66900，106400）
------------------------------------------------------------

function k_talk002()


	MISSCRIPT_NPCSCRIPT04_LUA_000404 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000404")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000404 )
	MISSCRIPT_NPCSCRIPT04_LUA_000405 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000405")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000405, JumpPage, 2)

	MISSCRIPT_NPCSCRIPT04_LUA_000406 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000406")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000406)	
	InitTrigger()
	TriggerCondition( 1, HasItem, 1097, 1)             ------------蛋糕品尝券
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
	TriggerAction(1, TakeItem, 1097, 1)
	TriggerAction(1, GiveItem, 1104, 1, 4)              ----------百慕大宝箱
	TriggerFailure(1, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text(2,MISSCRIPT_NPCSCRIPT01_LUA_001061, MultiTrigger, GetMultiTrigger(), 1) 	

	MISSCRIPT_NPCSCRIPT04_LUA_000407 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000407")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000407)

	MISSCRIPT_NPCSCRIPT04_LUA_000408 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000408")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000408, JumpPage, 4)

	MISSCRIPT_NPCSCRIPT04_LUA_000409 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000409")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000409)	
	InitTrigger()
	TriggerCondition( 1, HasItem, 2989, 1)             ------------超级寿司
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
	TriggerAction(1, TakeItem, 2989, 1)
	TriggerAction(1, GiveItem, 0992, 10, 4)              ----------成长快餐10个
	TriggerFailure(1, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text(4,MISSCRIPT_NPCSCRIPT01_LUA_001061, MultiTrigger, GetMultiTrigger(), 1) 	

	MISSCRIPT_NPCSCRIPT04_LUA_000410 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000410")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000410)

	---------------2.0新历史任务
	AddNpcMission ( 6362 )
	AddNpcMission ( 6363 )
end

------------------------------------------------------------
--天堂 誉之神仆（175440,90279）
------------------------------------------------------------

function k_talk003()


	MISSCRIPT_NPCSCRIPT04_LUA_000411 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000411")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000411 )
	MISSCRIPT_NPCSCRIPT04_LUA_000412 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000412")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000412, JumpPage, 2)

	MISSCRIPT_NPCSCRIPT04_LUA_000413 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000413")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000413)	
	InitTrigger()
	TriggerCondition( 1, HasItem, 5709, 1)             ------------85级神装宝箱
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
	TriggerAction(1, TakeItem, 5709, 1)
	TriggerAction(1, GiveItem, 5714, 1, 4)              ----------无双宝箱
	TriggerFailure(1, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text(2,MISSCRIPT_NPCSCRIPT01_LUA_001061, MultiTrigger, GetMultiTrigger(), 1) 	

	MISSCRIPT_NPCSCRIPT04_LUA_000414 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000414")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000414)

	MISSCRIPT_NPCSCRIPT04_LUA_000415 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000415")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000415, JumpPage, 4)

	MISSCRIPT_NPCSCRIPT04_LUA_000416 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000416")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000416)	
	InitTrigger()
	TriggerCondition( 1, HasItem, 2941, 1)             ------------转生卡
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
	TriggerAction(1, TakeItem, 2941, 1)
	TriggerAction(1, GiveItem, 5712, 1, 4)              ----------真龙宝箱
	TriggerFailure(1, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT01_LUA_001061 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001061")
	Text(4,MISSCRIPT_NPCSCRIPT01_LUA_001061, MultiTrigger, GetMultiTrigger(), 1) 	

	MISSCRIPT_NPCSCRIPT04_LUA_000414 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000414")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000414)

end

-------------------------
-----冬月补给站　铁匠·大澎
----------------------
function d_talk1()

        MISSCRIPT_NPCSCRIPT04_LUA_000417 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000417")
        Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000417)

	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT01_LUA_000014 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000014")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000014, OpenRepair )
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )

	InitTrade()
	Weapon(	4197	)
	Weapon(	4199	)
	Weapon(	4201	)
	Weapon(	4207	)
	Weapon(	4211	)
	Weapon(	4213	)
	Weapon(	4214	)
	Weapon(	4215	)
	Weapon(	4218	)
	-- Weapon(	0127	)
	-- Weapon(	0110	)
	-- Weapon(	0112	)
	-- Weapon(	0114	)
	-- Weapon(	0116	)
	-- Weapon(	0118	)
	-- Weapon(	0120	)
	-- Weapon(	0151	)

	AddNpcMission ( 6390 )


end

--------------------
------冬月补给站　杂货商人·天宇
-------------------
function d_talk2()

        MISSCRIPT_NPCSCRIPT04_LUA_000418 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000418")
        Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000418)
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )
	
	InitTrade()
	Other(	1611	)
	Other(	1682	)
	Other(	1842	)
	Other(	1612	)
	Other(	1710	)
	Other(	1693	)
	Other(	4716	)
	Other(	1716	)
	Other(	1711	)
	Other(	3384	)
	Other(	3932	)
	Other(	1619	)
	Other(	2396	)
	Other(	1729	)
	Other(	4459	)
	Other(	1697	)
	Other(	1730	)
	Other(	1712	)
	Other(	1734	)
	Other(	1621	)
	Other(	1703	)

	AddNpcMission ( 6391 )
	AddNpcMission ( 6392 )
	AddNpcMission ( 6393 )
	
end 
---------------------
-------冬月补给站　药材商人·格古洛
----------------------
function d_talk3()

        MISSCRIPT_NPCSCRIPT04_LUA_000419 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000419")
        Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000419)
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )

	InitTrade()
	Other(	6203	)
	Other(	6204	)
	Other(	1847	)
	Other(	1848	)
	Other(	1849	)
	Other(	3143	)
	--Leo
	Other(	1576	)
	Other(	4049	)
	Other(	4050	)
	Other(	1578	)
	Other(	4060	)
	Other(	4055	)
	Other(	4061	)
	Other(	2225	)
	Other(	4057	)
	Other(	1768	)


	AddNpcMission ( 6394 )
	AddNpcMission ( 6395 )
	AddNpcMission ( 6400 )

end
---------------------
------冬月补给站　服装店主·达尔
---------------------
function d_talk4()

        MISSCRIPT_NPCSCRIPT04_LUA_000420 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000420")
        Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000420)
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )

	InitTrade()
	Defence(	4147	)
	Defence(	4149	)
	Defence(	4151	)
	Defence(	4153	)
	Defence(	4154	)
	Defence(	4157	)
	Defence(	4158	)
	Defence(	4161	)
	Defence(	4162	)
	Defence(	4165	)
	Defence(	4167	)
	Defence(	4169	)
	Defence(	4170	)
	Defence(	4173	)
	Defence(	4174	)
	Defence(	4177	)
	Defence(	4178	)
	Defence(	4181	)
	Defence(	4183	)
	Defence(	4185	)
	Defence(	4186	)
	Defence(	4189	)
	Defence(	4190	)
	Defence(	4193	)
	Defence(	4194	)
	-- Defence(	0396	)
	-- Defence(	0398	)
	-- Defence(	0400	)
	-- Defence(	0402	)
	-- Defence(	0404	)
	-- Defence(	0406	)
	-- Defence(	0408	)
	-- Defence(	0411	)
	-- Defence(	0413	)
	-- Defence(	0588	)
	-- Defence(	0590	)
	-- Defence(	0592	)
	-- Defence(	0594	)
	-- Defence(	0596	)
	-- Defence(	0598	)
	-- Defence(	0600	)
	-- Defence(	0602	)
	-- Defence(	0604	)
	-- Defence(	0748	)
	-- Defence(	0750	)
	-- Defence(	0752	)
	-- Defence(	0754	)
	-- Defence(	0756	)
	-- Defence(	0758	)
	-- Defence(	0760	)
	-- Defence(	0824	)
	-- Defence(	0830	)
	-- Defence(	2219	)
	-- Defence(	2221	)
	-- Defence(	2223	)


	AddNpcMission ( 6396 )
	AddNpcMission ( 6397 )
	AddNpcMission ( 6401 )
	
end
-------------------
--------冬月补给站　宠物商人·礼刚
----------------------
--彩票下线修改
function d_talk5()

    MISSCRIPT_NPCSCRIPT04_LUA_000421 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000421")
    Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000421)
	InitTrigger()
	TriggerCondition( 1, HasRecord, 1908 )
	TriggerAction( 1, JumpPage, 2)
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000422 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000422")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000422,MultiTrigger, GetMultiTrigger(), 1)
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000423 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000423")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000423 )
	
	InitTrigger()
	TriggerCondition( 1, HasRecord, 1908 )
	TriggerCondition( 1, HasItem, 6374, 10 )
	TriggerCondition( 1, HasItem, 6375, 10 )
	TriggerAction( 1, TakeItem, 6374, 10 )
	TriggerAction( 1, TakeItem, 6375, 10 )
	TriggerAction( 1, GiveItem, 6294, 1, 4 )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000424 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000424")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000424, MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT04_LUA_000425 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000425")
	Talk(3,	MISSCRIPT_NPCSCRIPT04_LUA_000425)
	MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
	Text( 3, MISSCRIPT_NPCSCRIPT01_LUA_000005,CloseTalk )

	MISSCRIPT_NPCSCRIPT04_LUA_000426 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000426")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000426 )

	AddNpcMission ( 6721 )

end



-------------------
--------冬岛传送使
--------------------

function d_talk6 ()
	MISSCRIPT_NPCSCRIPT04_LUA_000427 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000427")
	Talk ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000427)
	MISSCRIPT_NPCSCRIPT04_LUA_000428 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000428")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000428, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT04_LUA_000429 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000429")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000429, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000430 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000430")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000430, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000008")
	Text ( 1, MISSCRIPT_NPCSCRIPT02_LUA_000008, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text ( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )


	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 2187,2776, "garner")
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT02_LUA_000120 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000120")
	Talk( 2, MISSCRIPT_NPCSCRIPT02_LUA_000120)
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 918,3562, "magicsea")
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000431 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000431")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000431)
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 3, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasMoney, 2000 )
	TriggerAction( 1, TakeMoney, 2000 )
	TriggerAction( 1, GoTo, 1323,544, "darkblue")
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000432 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000432")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000432)
	MISSCRIPT_NPCSCRIPT01_LUA_001550 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_001550")
	Text( 4, MISSCRIPT_NPCSCRIPT01_LUA_001550,MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000433 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000433")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000433 )
	BIRTH_BIRTH_CONF_LUA_000053 = GetResString("BIRTH_BIRTH_CONF_LUA_000053")
	MISSCRIPT_NPCSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000049")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000049, SetSpawnPos, BIRTH_BIRTH_CONF_LUA_000053 )
	MISSCRIPT_NPCSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT02_LUA_000050")
	Text( 5, MISSCRIPT_NPCSCRIPT02_LUA_000050,CloseTalk )

	MISSCRIPT_NPCSCRIPT04_LUA_000434 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000434")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000434 )

	AddNpcMission ( 6398 )

end


-------------------
--------冬月岛　海港指挥·冬日
--------------------
function d_talk7()

        MISSCRIPT_NPCSCRIPT04_LUA_000435 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000435")
        Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000435)

	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 34 )
	TriggerAction( 1, LuanchBerthList, 34, 337,965, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, RepairBerthList, 34 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, SupplyBerthList, 34 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 34 )
	TriggerAction( 1, SalvageBerthList, 34 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )


	AddNpcMission ( 6402 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6701 )

end

-----------------
--------冬月岛　考古学家·杨翼
-------------------
function d_talk8()

	MISSCRIPT_NPCSCRIPT04_LUA_000436 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000436")
	Talk( 1,MISSCRIPT_NPCSCRIPT04_LUA_000436)
	MISSCRIPT_NPCSCRIPT04_LUA_000437 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000437")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000437,JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000438 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000438")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000438,JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000439 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000439")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000439,JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT04_LUA_000440 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000440")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000440,JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000441 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000441")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000441,JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000442 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000442")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000442,JumpPage, 8 )

        MISSCRIPT_NPCSCRIPT04_LUA_000443 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000443")
        Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000443 )

	MISSCRIPT_NPCSCRIPT04_LUA_000444 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000444")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000444 )
	MISSCRIPT_NPCSCRIPT04_LUA_000445 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000445")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000445,JumpPage, 9 )
	MISSCRIPT_NPCSCRIPT04_LUA_000446 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000446")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000446,JumpPage, 10 )
	MISSCRIPT_NPCSCRIPT04_LUA_000447 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000447")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000447,JumpPage, 11 )
	MISSCRIPT_NPCSCRIPT04_LUA_000448 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000448")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000448,JumpPage, 12 )

	MISSCRIPT_NPCSCRIPT04_LUA_000449 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000449")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000449 )
	MISSCRIPT_NPCSCRIPT04_LUA_000450 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000450")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000450,JumpPage, 13 )
	MISSCRIPT_NPCSCRIPT04_LUA_000451 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000451")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000451,JumpPage, 14 )
	MISSCRIPT_NPCSCRIPT04_LUA_000452 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000452")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000452,JumpPage, 15 )
	MISSCRIPT_NPCSCRIPT04_LUA_000453 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000453")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000453,JumpPage, 16 )

	MISSCRIPT_NPCSCRIPT04_LUA_000454 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000454")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000454 )
	MISSCRIPT_NPCSCRIPT04_LUA_000455 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000455")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000455,JumpPage, 17 )
	MISSCRIPT_NPCSCRIPT04_LUA_000456 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000456")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000456,JumpPage, 18 )
	MISSCRIPT_NPCSCRIPT04_LUA_000457 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000457")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000457,JumpPage, 19 )
	MISSCRIPT_NPCSCRIPT04_LUA_000458 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000458")
	Text( 5, MISSCRIPT_NPCSCRIPT04_LUA_000458,JumpPage, 20 )

	MISSCRIPT_NPCSCRIPT04_LUA_000459 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000459")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000459 )
	MISSCRIPT_NPCSCRIPT04_LUA_000460 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000460")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000460,JumpPage, 21 )
	MISSCRIPT_NPCSCRIPT04_LUA_000461 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000461")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000461,JumpPage, 22 )
	MISSCRIPT_NPCSCRIPT04_LUA_000462 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000462")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000462,JumpPage, 23 )
	MISSCRIPT_NPCSCRIPT04_LUA_000463 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000463")
	Text( 6, MISSCRIPT_NPCSCRIPT04_LUA_000463,JumpPage, 24 )

	MISSCRIPT_NPCSCRIPT04_LUA_000464 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000464")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000464 )
	MISSCRIPT_NPCSCRIPT04_LUA_000465 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000465")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000465,JumpPage, 25 )
	MISSCRIPT_NPCSCRIPT04_LUA_000466 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000466")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000466,JumpPage, 26 )
	MISSCRIPT_NPCSCRIPT04_LUA_000467 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000467")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000467,JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT04_LUA_000468 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000468")
	Text( 7, MISSCRIPT_NPCSCRIPT04_LUA_000468,JumpPage, 28)

	MISSCRIPT_NPCSCRIPT04_LUA_000469 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000469")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000469 )
	MISSCRIPT_NPCSCRIPT04_LUA_000470 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000470")
	Text( 8, MISSCRIPT_NPCSCRIPT04_LUA_000470,JumpPage, 29 )
	MISSCRIPT_NPCSCRIPT04_LUA_000471 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000471")
	Text( 8, MISSCRIPT_NPCSCRIPT04_LUA_000471,JumpPage, 30 )
	MISSCRIPT_NPCSCRIPT04_LUA_000472 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000472")
	Text( 8, MISSCRIPT_NPCSCRIPT04_LUA_000472,JumpPage, 31 )
	MISSCRIPT_NPCSCRIPT04_LUA_000473 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000473")
	Text( 8, MISSCRIPT_NPCSCRIPT04_LUA_000473,JumpPage, 32 )

	InitTrigger()
	TriggerCondition( 1, PfEqual, 12 )
	TriggerCondition( 1, HasItem, 6173, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6173, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6104, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000474 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000474")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000474 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 9, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 12 )
	TriggerCondition( 1, HasItem, 6174, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6174, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6105, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000475 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000475")
	Talk( 10, MISSCRIPT_NPCSCRIPT04_LUA_000475 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 10, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 12 )
	TriggerCondition( 1, HasItem, 6175, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6175, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6106, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000476 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000476")
	Talk( 11, MISSCRIPT_NPCSCRIPT04_LUA_000476 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 11, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 12 )
	TriggerCondition( 1, HasItem, 6176, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6176, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6107, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000477 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000477")
	Talk( 12, MISSCRIPT_NPCSCRIPT04_LUA_000477 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 12, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 9 )
	TriggerCondition( 1, HasItem, 6177, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6177, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6108, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000478 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000478")
	Talk( 13, MISSCRIPT_NPCSCRIPT04_LUA_000478 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 13, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 9 )
	TriggerCondition( 1, HasItem, 6178, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6178, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6109, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000479 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000479")
	Talk( 14, MISSCRIPT_NPCSCRIPT04_LUA_000479 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 14, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 9 )
	TriggerCondition( 1, HasItem, 6179, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6179, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6110, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000480 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000480")
	Talk( 15, MISSCRIPT_NPCSCRIPT04_LUA_000480 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 15, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 9 )
	TriggerCondition( 1, HasItem, 6180, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6180, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6111, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000481 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000481")
	Talk( 16, MISSCRIPT_NPCSCRIPT04_LUA_000481 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 16, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 8 )
	TriggerCondition( 1, HasItem, 6181, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6181, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6112, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000482 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000482")
	Talk( 17, MISSCRIPT_NPCSCRIPT04_LUA_000482 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 17, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 8 )
	TriggerCondition( 1, HasItem, 6182, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6182, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6113, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000483 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000483")
	Talk( 18, MISSCRIPT_NPCSCRIPT04_LUA_000483 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 18, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 8 )
	TriggerCondition( 1, HasItem, 6183, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6183, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6114, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000484 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000484")
	Talk( 19, MISSCRIPT_NPCSCRIPT04_LUA_000484 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 19, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 8 )
	TriggerCondition( 1, HasItem, 6184, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6184, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6115, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000485 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000485")
	Talk( 20, MISSCRIPT_NPCSCRIPT04_LUA_000485 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 20, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 16 )
	TriggerCondition( 1, HasItem, 6185, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6185, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6116, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000486 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000486")
	Talk( 21, MISSCRIPT_NPCSCRIPT04_LUA_000486 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 21, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 16 )
	TriggerCondition( 1, HasItem, 6186, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6186, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6117, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000487 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000487")
	Talk( 22, MISSCRIPT_NPCSCRIPT04_LUA_000487 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 22, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 16 )
	TriggerCondition( 1, HasItem, 6187, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6187, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6118, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000488 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000488")
	Talk( 23, MISSCRIPT_NPCSCRIPT04_LUA_000488 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 23, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 16 )
	TriggerCondition( 1, HasItem, 6188, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6188, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6119, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000489 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000489")
	Talk( 24, MISSCRIPT_NPCSCRIPT04_LUA_000489 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 24, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 13 )
	TriggerCondition( 1, HasItem, 6189, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6189, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6120, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000490 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000490")
	Talk( 25, MISSCRIPT_NPCSCRIPT04_LUA_000490 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 25, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 13 )
	TriggerCondition( 1, HasItem, 6190, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6190, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6121, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000491 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000491")
	Talk( 26, MISSCRIPT_NPCSCRIPT04_LUA_000491 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 26, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 13 )
	TriggerCondition( 1, HasItem, 6191, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6191, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6122, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000492 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000492")
	Talk( 27, MISSCRIPT_NPCSCRIPT04_LUA_000492 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 27, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 13 )
	TriggerCondition( 1, HasItem, 6192, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6192, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6123, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000493 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000493")
	Talk( 28, MISSCRIPT_NPCSCRIPT04_LUA_000493 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 28, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 14 )
	TriggerCondition( 1, HasItem, 6193, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6193, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6124, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000494 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000494")
	Talk( 29, MISSCRIPT_NPCSCRIPT04_LUA_000494 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 29, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 14 )
	TriggerCondition( 1, HasItem, 6194, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6194, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6125, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000495 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000495")
	Talk( 30, MISSCRIPT_NPCSCRIPT04_LUA_000495 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 30, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 14 )
	TriggerCondition( 1, HasItem, 6195, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6195, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6126, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000496 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000496")
	Talk( 31, MISSCRIPT_NPCSCRIPT04_LUA_000496 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 31, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, PfEqual, 14 )
	TriggerCondition( 1, HasItem, 6196, 1 )
	TriggerCondition( 1, HasItem, 6231, 2 )
	TriggerCondition( 1, HasItem, 6232, 2 )
	TriggerCondition( 1, HasItem, 6233, 1 )
	TriggerCondition( 1, HasItem, 6234, 1 )
	TriggerAction( 1, TakeItem, 6196, 1 )
	TriggerAction( 1, TakeItem, 6231, 2 )
	TriggerAction( 1, TakeItem, 6232, 2 )
	TriggerAction( 1, TakeItem, 6233, 1 )
	TriggerAction( 1, TakeItem, 6234, 1 )
	TriggerAction( 1, GiveItem, 6127, 1, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT04_LUA_000497 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000497")
	Talk( 32, MISSCRIPT_NPCSCRIPT04_LUA_000497 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 32, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	AddNpcMission ( 6327 )
	AddNpcMission ( 6332 )
	AddNpcMission ( 6419 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6709 )
	AddNpcMission ( 6720 )

end

-------------------
---雪拉岛　海港指挥·冬月
-------------------

function d_talk9()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000498 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000498")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000498)

	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 34 )
	TriggerAction( 1, LuanchBerthList, 34, 702,720, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, RepairBerthList, 34 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, SupplyBerthList, 34 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 34 )
	TriggerAction( 1, SalvageBerthList, 34 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )


	AddNpcMission ( 6403 )
	AddNpcMission ( 6404 )

end
-------------------
------雪拉岛　探索者·威斯特
--------------------

function d_talk10()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000499 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000499")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000499)

	AddNpcMission ( 6328 )
	AddNpcMission ( 6421 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6710 )
	AddNpcMission ( 6711 )
	AddNpcMission ( 6712 )

end
-----------------
---雪拉岛　雪拉岛守护者
-------------------


function d_talk11()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000500 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000500")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000500)

	AddNpcMission ( 6333 )
	AddNpcMission ( 6334 )
	AddNpcMission ( 6409 )

end
------------------
---雪维岛　海港指挥·冬星
-----------------


function d_talk12()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000501 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000501")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000501)

	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 34 )
	TriggerAction( 1, LuanchBerthList, 34, 1043, 629, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, RepairBerthList, 34 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, SupplyBerthList, 34 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 34 )
	TriggerAction( 1, SalvageBerthList, 34 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )


	AddNpcMission ( 6405 )
	AddNpcMission ( 6406 )

end
-------------------
--雪维岛　探索者·克里斯
----------------


function d_talk13()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000502 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000502")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000502)

	AddNpcMission ( 6329 )
	AddNpcMission ( 6414 )
	AddNpcMission ( 6417 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6713 )
	AddNpcMission ( 6714 )

end
---------------
--雪维岛　雪维岛守护者
---------------


function d_talk14()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000503 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000503")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000503)

	AddNpcMission ( 6335 )
	AddNpcMission ( 6336 )
	AddNpcMission ( 6410 )

end
---------------
--冬湖岛　海港指挥·冬辰
-------------------


function d_talk15()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000504 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000504")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000504)

	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 34 )
	TriggerAction( 1, LuanchBerthList, 34, 246,1185, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, RepairBerthList, 34 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 34 )
	TriggerAction( 2, SupplyBerthList, 34 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 

	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 34 )
	TriggerAction( 1, SalvageBerthList, 34 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000048 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000048")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000048 )
	MISSCRIPT_NPCSCRIPT03_LUA_000049 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000049")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000049 )
	MISSCRIPT_NPCSCRIPT03_LUA_000050 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000050")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000050 )

	AddNpcMission ( 6407 )
	AddNpcMission ( 6408 )

end
--------------------
---冬湖岛　父神维尔
-------------------


function d_talk16()
      
	MISSCRIPT_NPCSCRIPT04_LUA_000505 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000505")
	Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000505)
	MISSCRIPT_NPCSCRIPT04_LUA_000506 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000506")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000506, JumpPage, 2)
	MISSCRIPT_NPCSCRIPT04_LUA_000507 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000507")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000507, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT04_LUA_000508 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000508")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000508, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT04_LUA_000509 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000509")
	Text ( 1, MISSCRIPT_NPCSCRIPT04_LUA_000509, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000142")
	Text ( 1, MISSCRIPT_NPCSCRIPT01_LUA_000142,CloseTalk )

	InitTrigger()
	TriggerCondition( 1, HasRecord, 1648 )
	TriggerAction( 1, GoTo, 1970,950, "winterland" )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000510 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000510")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000510)
	MISSCRIPT_NPCSCRIPT04_LUA_000511 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000511")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000511,MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasRecord, 1664 )
	TriggerCondition( 1, goto_mj1_time )
	TriggerAction( 1, GoTo, 366,395, "mjing1")
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000512 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000512")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000512)
	MISSCRIPT_NPCSCRIPT04_LUA_000511 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000511")
	Text( 3, MISSCRIPT_NPCSCRIPT04_LUA_000511,MultiTrigger, GetMultiTrigger(), 1 )

	InitTrigger()
	TriggerCondition( 1, HasRecord, 1664 )
	TriggerCondition( 1, goto_mj2_time )
	TriggerAction( 1, mj3sjc )
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000513 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000513")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000513)
	MISSCRIPT_NPCSCRIPT04_LUA_000511 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000511")
	Text( 4, MISSCRIPT_NPCSCRIPT04_LUA_000511,MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000514 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000514")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000514 )
	MISSCRIPT_NPCSCRIPT04_LUA_000515 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000515")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000515)
	MISSCRIPT_NPCSCRIPT04_LUA_000516 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000516")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000516 )

	InitTrigger()
	TriggerCondition( 1, PfEqual, 8 )
	TriggerCondition( 1, HasRecord, 1671 )
	TriggerCondition( 1, NoRecord, 1891 )
	TriggerAction( 1, GiveItem, 6251, 1, 4 )
	TriggerAction( 1, SetRecord, 1891 )
	TriggerCondition( 2, PfEqual, 9 )
	TriggerCondition( 2, HasRecord, 1671 )
	TriggerCondition( 2, NoRecord, 1891 )
	TriggerAction( 2, GiveItem, 6250, 1, 4 )
	TriggerAction( 2, SetRecord, 1891 )
	TriggerCondition( 3, PfEqual, 12 )
	TriggerCondition( 3, HasRecord, 1671 )
	TriggerCondition( 3, NoRecord, 1891 )
	TriggerAction( 3, GiveItem, 6252, 1, 4 )
	TriggerAction( 3, SetRecord, 1891 )
	TriggerCondition( 4, PfEqual, 13 )
	TriggerCondition( 4, HasRecord, 1671 )
	TriggerCondition( 4, NoRecord, 1891 )
	TriggerAction( 4, GiveItem, 6255, 1, 4 )
	TriggerAction( 4, SetRecord, 1891 )
	TriggerCondition( 5, PfEqual, 14 )
	TriggerCondition( 5, HasRecord, 1671 )
	TriggerCondition( 5, NoRecord, 1891 )
	TriggerAction( 5, GiveItem, 6254, 1, 4 )
	TriggerAction( 5, SetRecord, 1891 )
	TriggerCondition( 6, PfEqual, 16 )
	TriggerCondition( 6, HasRecord, 1671 )
	TriggerCondition( 6, NoRecord, 1891 )
	TriggerAction( 6, GiveItem, 6253, 1, 4 )
	TriggerAction( 6, SetRecord, 1891 )
	TriggerFailure( 6, JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000517 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000517")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000517 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 5, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 6)

	AddNpcMission ( 6809 )
	AddNpcMission ( 6341 )
	AddNpcMission ( 6342 )
	AddNpcMission ( 6348 )
	AddNpcMission ( 6349 )
	AddNpcMission ( 6368 )
	AddNpcMission ( 6369 )
	AddNpcMission ( 6379 )
	AddNpcMission ( 6420 )
	AddNpcMission ( 6622 )
end


------------------
----冬湖岛　探索者·里昂
------------------


function d_talk17()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000518 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000518")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000518)

	AddNpcMission ( 6330 )
	AddNpcMission ( 6418 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6718 )
	AddNpcMission ( 6719 )

end
----------------
----冬湖岛　探索者·吉尔
------------------


function d_talk18()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000519 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000519")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000519)

	AddNpcMission ( 6331 )
	AddNpcMission ( 6415 )
	AddNpcMission ( 6416 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6715 )
	AddNpcMission ( 6716 )
	AddNpcMission ( 6717 )

end
-----------------
--冬湖岛　冬湖岛守护者
-----------------


function d_talk19()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000520 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000520")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000520)

	AddNpcMission ( 6337 )
	AddNpcMission ( 6338 )
	AddNpcMission ( 6339 )
	AddNpcMission ( 6340 )
	AddNpcMission ( 6411 )

end
------------------
--冰封岛　上古遗迹守护长
--------------------


function d_talk20()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000521 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000521")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000521)
	   
	AddNpcMission ( 6810 )
	AddNpcMission ( 6343 )
	AddNpcMission ( 6344 )
	AddNpcMission ( 6347 )
	AddNpcMission ( 6412 )
	AddNpcMission ( 6413 )
	AddNpcMission ( 6723 )
	AddNpcMission ( 6725 )


end
-------------------
--冰封岛　卡拉的雕像
------------------


function d_talk21()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000522 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000522")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000522)

	AddNpcMission ( 6345 )
	AddNpcMission ( 6422 )
	AddNpcMission ( 6722 )

end
-------------------
--冰封岛　维尔的雕像
---------------------


function d_talk22()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000523 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000523")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000523)

	AddNpcMission ( 6346 )
	AddNpcMission ( 6423 )
	AddNpcMission ( 6724 )

end
--------------------
---秋岛　维尔分身
--------------------


function d_talk23()
     -- Talk(1,"维尔分身：冬岛目前还没有开放,尽请期待下次更新！") 
	MISSCRIPT_NPCSCRIPT04_LUA_000524 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000524")
	Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000524)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001340 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001340")
	Text ( 1, MISSCRIPT_MISSIONSCRIPT02_LUA_001340, JumpPage, 2)

	InitTrigger()
	TriggerCondition( 1, HasRecord, 1636 )
	TriggerCondition( 1, HasAllBoatInBerth, 13 )
	TriggerAction( 1, LuanchBerthList, 13, 2583,3235, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000525 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000525")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000525)
	MISSCRIPT_NPCSCRIPT04_LUA_000511 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000511")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000511, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000526 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000526")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000526 )

	AddNpcMission ( 6325 )
	AddNpcMission ( 6326 )

end
---------------------
--光明秘境第一境界　光明秘境守护者
-----------------------


function d_talk24()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000527 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000527")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000527)

	AddNpcMission ( 6370 )
	AddNpcMission ( 6371 )
	AddNpcMission ( 6619)	
end
--------------------
--光明秘境第一境界　维尔分身
----------------------


function d_talk25()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000528 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000528")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000528)

	AddNpcMission ( 6372 )
	AddNpcMission ( 6373 )
	AddNpcMission ( 6620 )

end
---------------------
--暗黑秘境第一境界　暗黑秘境守护者
----------------------


function d_talk26()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000529 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000529")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000529)

	AddNpcMission ( 6374 )
	AddNpcMission ( 6375 )
	AddNpcMission ( 6376 )
	AddNpcMission ( 6728 )

end
-----------------------
--暗黑秘境第二境界　卡拉分身
-----------------------


function d_talk27()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000530 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000530")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000530)

	AddNpcMission ( 6377 )
	AddNpcMission ( 6378 )
	AddNpcMission ( 6726 )
	AddNpcMission(6621)

end


----------------------------------------------------------
--							--
--							--
-- 冬月补给站[护士小姐——倩尼迪]	--
--							--
--		25400,88100			--
----------------------------------------------------------

---------------加血恢复的判定


----------------普通对话开始
function d_talk28 ()

	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, ReAll )
	TriggerCondition( 2, LvCheck, ">", 39 )
	TriggerCondition( 2, HasMoney, 1000 )
	TriggerAction( 2, TakeMoney, 1000 )
	TriggerAction( 2, ReAll )
	TriggerFailure( 2, JumpPage, 2 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000531 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000531")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000531 )
	MISSCRIPT_NPCSCRIPT01_LUA_000106 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000106")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000106, MultiTrigger,GetMultiTrigger(),2)
	 
	MISSCRIPT_NPCSCRIPT04_LUA_000532 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000532")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000532)


	AddNpcMission ( 6424 )
	AddNpcMission ( 6427 )
	AddNpcMission ( 6428 )
	AddNpcMission ( 6432 )

end

-----------------------
--冬月补给站　船工·安狄美奥
-----------------------

function d_talk29()
	
	MISSCRIPT_NPCSCRIPT04_LUA_000533 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000533")
	Talk( 1, MISSCRIPT_NPCSCRIPT04_LUA_000533 )
	InitTrigger()
	TriggerCondition( 1, IsBoatFull )
	MISSCRIPT_NPCSCRIPT03_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000015")
	TriggerAction( 1, SystemNotice, MISSCRIPT_NPCSCRIPT03_LUA_000015 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001185")
	Text( 1, MISSCRIPT_MISSIONSCRIPT05_LUA_001185, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 34 )
	TriggerAction( 1, BoatLevelBerthList, 34 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000016")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000016, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT04_LUA_000534 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000534")
	Talk( 2, MISSCRIPT_NPCSCRIPT04_LUA_000534 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 1 )
	TriggerAction( 1, CreateBoat, 1, 34 )
	MISSCRIPT_NPCSCRIPT04_LUA_000535 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000535")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000535, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 5 )
	TriggerAction( 1, CreateBoat, 5, 34 )
	MISSCRIPT_NPCSCRIPT03_LUA_000019 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000019")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000019, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 6 )
	TriggerAction( 1, CreateBoat, 6, 34 )
	MISSCRIPT_NPCSCRIPT03_LUA_000020 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000020")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000020, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 4 )
	TriggerAction( 1, CreateBoat, 4, 34 )
	MISSCRIPT_NPCSCRIPT03_LUA_000021 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000021")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000021, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 14 )
	TriggerAction( 1, CreateBoat, 14, 34 )
	MISSCRIPT_NPCSCRIPT03_LUA_000022 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000022")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000022, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 15 )
	TriggerAction( 1, CreateBoat, 15, 34 )
	MISSCRIPT_NPCSCRIPT03_LUA_000023 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000023")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000023, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT04_LUA_000536 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000536")
	Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000536 )

	AddNpcMission ( 6425 )
	AddNpcMission ( 6426 )
	AddNpcMission ( 6429 )
	AddNpcMission ( 6430 )
	AddNpcMission ( 6431 )

end

-----------------------
--暗黑秘境第二境界　神秘人·冬仔
-----------------------


function d_talk30()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000537 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000537")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000537)

	AddNpcMission ( 6727 )

end

-----------------
--------冬月岛　考古学家·月铃
-------------------
function d_talk31()
      
       MISSCRIPT_NPCSCRIPT04_LUA_000538 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000538")
       Talk(1,MISSCRIPT_NPCSCRIPT04_LUA_000538)

	MISSCRIPT_NPCSCRIPT04_LUA_000539 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000539")
	Text( 1, MISSCRIPT_NPCSCRIPT04_LUA_000539,JumpPage, 2 )


	MISSCRIPT_NPCSCRIPT04_LUA_000540 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000540")
	Talk( 2,MISSCRIPT_NPCSCRIPT04_LUA_000540)
	MISSCRIPT_NPCSCRIPT04_LUA_000541 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000541")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000541,JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT04_LUA_000542 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000542")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000542,JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT04_LUA_000543 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000543")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000543,JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT04_LUA_000544 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000544")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000544,JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT04_LUA_000545 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000545")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000545,JumpPage, 8 )
	MISSCRIPT_NPCSCRIPT04_LUA_000546 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000546")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000546,JumpPage, 9 )
	MISSCRIPT_NPCSCRIPT04_LUA_000547 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000547")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000547,JumpPage, 10 )
	MISSCRIPT_NPCSCRIPT04_LUA_000548 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000548")
	Text( 2, MISSCRIPT_NPCSCRIPT04_LUA_000548,JumpPage, 11 )

        MISSCRIPT_NPCSCRIPT04_LUA_000549 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000549")
        Talk( 3, MISSCRIPT_NPCSCRIPT04_LUA_000549 )

	InitTrigger()
	TriggerCondition( 1, HasItem, 6165, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6165, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6096, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000550 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000550")
	Talk( 4, MISSCRIPT_NPCSCRIPT04_LUA_000550 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 4, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6166, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6166, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6097, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000551 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000551")
	Talk( 5, MISSCRIPT_NPCSCRIPT04_LUA_000551 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 5, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6167, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6167, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6098, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000552 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000552")
	Talk( 6, MISSCRIPT_NPCSCRIPT04_LUA_000552 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 6, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6168, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6168, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6099, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000553 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000553")
	Talk( 7, MISSCRIPT_NPCSCRIPT04_LUA_000553 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 7, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6169, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6169, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6100, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000554 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000554")
	Talk( 8, MISSCRIPT_NPCSCRIPT04_LUA_000554 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 8, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6170, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6170, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6101, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000555 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000555")
	Talk( 9, MISSCRIPT_NPCSCRIPT04_LUA_000555 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 9, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6171, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6171, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6102, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000556 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000556")
	Talk( 10, MISSCRIPT_NPCSCRIPT04_LUA_000556 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 10, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 6172, 1 )
	TriggerCondition( 1, HasItem, 6231, 1 )
	TriggerCondition( 1, HasItem, 6232, 1 )
	TriggerCondition( 1, HasItem, 6233, 2 )
	TriggerCondition( 1, HasItem, 6234, 2 )
	TriggerAction( 1, TakeItem, 6172, 1 )
	TriggerAction( 1, TakeItem, 6231, 1 )
	TriggerAction( 1, TakeItem, 6232, 1 )
	TriggerAction( 1, TakeItem, 6233, 2 )
	TriggerAction( 1, TakeItem, 6234, 2 )
	TriggerAction( 1, GiveItem, 6103, 1, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT04_LUA_000557 = GetResString("MISSCRIPT_NPCSCRIPT04_LUA_000557")
	Talk( 11, MISSCRIPT_NPCSCRIPT04_LUA_000557 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 11, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)

	AddNpcMission ( 6399 )
end

------------------------------------------------------------------
--------------------------------------------------星空走廊　旅祸侍者·米酷
--------------------------------------------------------------------
function stway_talk01()
 
    Talk(1,"Dear Time Traveler, welcome to Starry Sky!")
	Text( 1, "What is this place?",JumpPage, 2 )
	
	Talk( 2,"What is this place? Here is the Sky.")
	Text( 2, "Sky?",JumpPage, 3 )
	
	Talk( 3,"Still don't understand? Let me say it to you in this way. Comparing with your Pirate Era, here is the parallel space. As here is currently in chaos, survival instinct  of the living beings are abnormally high, so please be careful.")
	Text( 3, "What is parallel space?",JumpPage, 4 )
	
	Talk( 4, "Space is the 3rd dimension, with time as the 4th dimension, parrarllel space is the 5th dimension of the dimension layers. Got it?" )
	Text( 4, "What 3rd, 4th and 5th dimension?! All I want to know is what so good about it?",JumpPage, 5 )
	
	Talk( 5, "Don't look down on the space civilization. Technology is far more advanced than what you have at your dimension. Here is known as the future in your dimension world, Card Tool." )
	Text( 5, "Card Tool?",JumpPage, 6 )
	
	Talk( 6, "Yes! You won't understand. Give you one of the most basic cards to let you try." )
	InitTrigger()
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
	TriggerCondition( 1,NoItem, 7518 , 1 )
	TriggerAction( 1, GiveItem,	7518, 1,4 )
	TriggerAction( 1, JumpPage, 26 )
	TriggerFailure( 1, JumpPage, 27 )
	Text( 6, "Thanks ya… (quickly put the card in the bad)", MultiTrigger, GetMultiTrigger(), 1)
	Text( 6, "Thou I don't really need this kind of useless junk items. (turn around and go off)",JumpPage, 7 )
	
	Talk( 7, "Hold on Traveler! If you could complete my request, I can give you more fasinating rewards." )
	InitTrigger()
	TriggerCondition( 1, NoRecord , 2054 )
	TriggerCondition( 1, NoMission , 2054 )
	TriggerAction( 1, ObligeAcceptMission, 6885)   
	TriggerFailure( 1, JumpPage, 25 )
	Text( 7 , "Well, he look kind of pitiful, why not help him a little." , MultiTrigger, GetMultiTrigger(), 1)
	Text( 7 , "Previous page",JumpPage , 6 )
	
	Talk( 25, "You currently holding or have completed the quest, thus unable to take the task" )
	Talk( 26, "Have any doubts, feel free to ask the Card Researchers." )
	Talk( 27, "You could have already possess those items, inventory bag is full either wise your inventory bag is locked." )
	
	AddNpcMission ( 6886 )
end

-----------------------------------------------------------------
---------------------------------------------星空走廊　卡械技术研究员·米酷
--------------------------------------------------------------------
function stway_talk02()
	
	Talk(1,"What can I help you with?")
	Text( 1, "What is Card Tool?",JumpPage, 2 )
	Text( 1, "What is Skill Card?",JumpPage, 3 )
	Text( 1, "What is Energy Card?",JumpPage, 4 )
	Text( 1, "What is Energy Crystal?",JumpPage, 5 )
	Text( 1, "What color is for which type of Card and Energy Crystal?",JumpPage, 6 )
	
	Talk( 2, "Card Tool is in use with same grade of Energy Card and Skill Card, to create that one's professional skills can never achieve in, unique equipment." )
	Text( 2 , "Previous page",JumpPage , 1 )
	
	Talk( 3, "Just as it's name, it contains different skill card, and must go through Card Tool and Energy to activate. Definitely, technically if the power is too strong, the Card Tool will get burned." )
	Text( 3 , "Previous page",JumpPage , 1 )
	
	Talk( 4, "Releasing the energy is the basic knowledge one must have when possess a Energy Card. Can be obtain from Energy Crystals." )
	Text( 4 , "Previous page",JumpPage , 1 )
	
	Talk( 5, "Starry Sky monsters body contains energy crystal. Players can obtain them from slaying monsters. You can also obtain them from black market." )
	Text( 5 , "Previous page",JumpPage , 1 )
	
	Talk( 6, "Card Ranking:F E D C B A S F is the lowest while S is the highest. Energy Crystal Color Grading:Red,Orange,Yellow,Dark Green,Light Green,Blue and Purple. Red is the lowest whereas Purple is the best. Certainly all have it's own usefulness." )
	Text( 6 , "Previous page",JumpPage , 1 )
end
-------------------------------------------------------
---------------------------------------------------星空走廊　赤级制卡师·熏
-------------------------------------------------------
function stway_talk03()
	
	Talk(1,"Dear Time Traveler, welcome to Starry Sky!")
	Text( 1, "Manufacture F-Grade Skill Card",JumpPage, 2 )
	Text( 1, "Manufacture F-Grade Energy Card",JumpPage, 3 )
	Text( 1, "Synthetic Red Energy Crystal",JumpPage, 4 )
	
	Talk( 2 ,"What type of F-Grade Skill Card you would like to manufacture? Take your time to pick")
	Text( 2, "F-Grade Power Strike Skill Card",JumpPage, 9 )
	Text( 2, "F-Grade Stealth Skill Card",JumpPage, 10 )
	Text( 2, "F-Grade Energy Shield Skill Card",JumpPage, 11 )
	Text( 2, "F-Grade Energy Binding Skill Card",JumpPage, 12 )
	Text( 2, "F-Grade Holy Light Energy Skill Card",JumpPage, 13 )
	Text( 2 , "Previous Page",JumpPage , 1 )	
	
	Talk( 9 ,"F-Grade Power Strike Skill Card = 1 Blank Card + 10 Red Energy Crystal + Skill Nucleus - Power Strike")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 1 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 10 )	------赤色能量结晶
	TriggerCondition( 1, HasItem, 7521, 1 )		------技能晶核-附能斩
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 1 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeItem, 7521, 1 )		
	TriggerAction( 1, GiveItem,	7526, 1,4 )		------F级附能斩技能卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 9 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 9 , "Previous Page",JumpPage , 2 )

	Talk( 10 ,"F-Grade Stealth Skill Card = 1 Blank Card + 10 Red Energy Crystal + Skill Nucleus - Stealth")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 1 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 10 )	------赤色能量结晶
	TriggerCondition( 1, HasItem, 7522, 1 )		------技能晶核-附能斩
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 1 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeItem, 7522, 1 )		
	TriggerAction( 1, GiveItem,	7527, 1,4 )		------F级化雾技能卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 10 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 10 , "Previous Page",JumpPage , 2 )	
	
	Talk( 11 ,"F-Grade Energy Shield Skill Card = 1 Blank Card + 10 Red Energy Crystal + Skill Nucleus - Energy Shield")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 1 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 10 )	------赤色能量结晶
	TriggerCondition( 1, HasItem, 7523, 1 )		------技能晶核-能量盾
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 1 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeItem, 7523, 1 )		
	TriggerAction( 1, GiveItem,	7528, 1,4 )		------F级能量盾技能卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 11 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 11 , "Previous Page",JumpPage , 2 )
	
	Talk( 12 ,"F-Grade Energy Binding Skill Card = 1 Blank Card + 10 Red Energy Crystal + Skill Nucleus - Energy Binding")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 1 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 10 )	------赤色能量结晶
	TriggerCondition( 1, HasItem, 7524, 1 )		------技能晶核-能量束缚网
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 1 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeItem, 7524, 1 )		
	TriggerAction( 1, GiveItem,	7529, 1,4 )		------F级能量束缚网技能卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 12 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 12 , "Previous Page",JumpPage , 2 )
	
	Talk( 13 ,"F-Grade Holy Light Skill Card = 1 Blank Card + 10 Red Energy Crystal + Skill Nucleus - Holy Light")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 1 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 10 )	------赤色能量结晶
	TriggerCondition( 1, HasItem, 7525, 1 )		------技能晶核-圣光救赎
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 1 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeItem, 7525, 1 )		
	TriggerAction( 1, GiveItem,	7530, 1,4 )		------F级圣光救赎技能卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 13 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 13 , "Previous Page",JumpPage , 2 )
	
	Talk( 3 ,"How many F-Grade Skill Card you would like to manufacture?")
	Text( 3, "1 x F-Grade Energy Card",JumpPage, 14 )
	Text( 3, "10 x F-Grade Energy Card",JumpPage, 15 )
	Text( 3, "99 x F-Grade Energy Card",JumpPage, 16 )
	Text( 3 , "Previous Page",JumpPage , 1 )
	
	
	Talk( 14 ,"1 x F-Grade Energy Card = 1 Blank Card + Red Energy Crystal + 5000")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 1 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 1 )		------赤色能量结晶
	TriggerCondition( 1, HasMoney, 5000 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 1 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeMoney, 5000 )			
	TriggerAction( 1, GiveItem,	7519, 1,4 )		------F级能量卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 14 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 14 , "Previous Page",JumpPage , 3 )	
	
	Talk( 15 ,"10 x F-Grade Energy Card = 10 Blank Card + 10 Red Energy Crystal + 50000")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 10 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 10 )		------赤色能量结晶
	TriggerCondition( 1, HasMoney, 50000 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 10 )	
	TriggerAction( 1, TakeItem, 7517, 10 )
	TriggerAction( 1, TakeMoney, 50000 )			
	TriggerAction( 1, GiveItem,	7519, 10 ,4 )		------F级能量卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 15 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 15 , "Previous Page",JumpPage , 3 )
	
	Talk( 16 ,"1 x F-Grade Energy Card = 99 Blank Card + 99 Red Energy Crystal + 490000")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7520, 99 )		------空白卡
	TriggerCondition( 1, HasItem, 7517, 99 )		------赤色能量结晶
	TriggerCondition( 1, HasMoney, 490000 )		
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7520, 99 )	
	TriggerAction( 1, TakeItem, 7517, 99 )
	TriggerAction( 1, TakeMoney, 490000 )			
	TriggerAction( 1, GiveItem,	7519, 99,4 )		------F级能量卡
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 16 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 16 , "Previous Page",JumpPage , 3 )
	
	Talk( 4 ,"Synthetic each Red Energy Crystal requires 10 Red Energy Debris.")		
	InitTrigger()
	TriggerCondition( 1, HasItem, 7516, 10 )	------赤色能量碎片
	TriggerCondition(1, HasLeaveBagGrid, 1)
	TriggerCondition(1, KitbagLock, 0 )
    TriggerAction( 1, TakeItem, 7516, 10 )	
	TriggerAction( 1, GiveItem,	7517, 1,4 )		------赤色能量结晶
	TriggerAction( 1, JumpPage, 8 )
	TriggerFailure( 1, JumpPage, 7 )
	Text( 4 , "Confirm Manufacture?",MultiTrigger, GetMultiTrigger(), 1 )	
	Text( 4 , "Previous Page",JumpPage , 1 )

	Talk( 7, "Seems like you have insufficient materials, insufficient inventory space or inventory is being locked." )
	Talk( 8, "Thanks for your patronage. Remember to come back if you need more" )
	
	---------------
	AddNpcMission ( 6883 )
	AddNpcMission ( 6884 )
end

--------------------------------------------------------
-------------------------------------------星空走廊　卡片材料商·米酷
--------------------------------------------------------
function stway_talk04()

	Talk( 1, "Welcome~ I have many card materials. Hehe.. You will never find these items anywhere else." )
	Text( 1, "Come and have a look", BuyPage )
	Text( 1, "It's nothing,I'm just here to buy some soy sauce",CloseTalk )

	InitTrade()
	Other(	7520	) 	------空白卡
	Other(	7517	)	------赤色能量结晶
	----------------Other(	7516	)	-----赤色能量碎片	

end	

-------------------------------------------------------
------------------------------------------------星空走廊　黑市商·郁
----------------------------------------------------------
function stway_talk05()

	Talk( 1, "Here have things that you can never find in any market. Open your eyes big big and see!" )
	Text( 1, "(⊙o⊙)Oh.. Come have a look", BuyPage )
	Text( 1, "Getting tired is what I wish for~",CloseTalk )

	InitTrade()
	Other(	7521	) 	------技能晶核-附能斩
	Other(	7522	)	------技能晶核-化雾
	Other(	7523	)	------技能晶核-能量盾	
	Other(	7524	)	------技能晶核-能量束缚网
	Other(	7525	)	------技能晶核-圣光救赎
end	

----------------------------
-----------------------------------星空走廊　赤级制械师·米酷
----------------------------
function stway_talk06()

	Talk( 1, "Provide me with the necessary materials and I will be able to manufacture the Card Tool for you." )
	Text( 1, "Manufacture F-Grade Card Tool",JumpPage , 2)

	Talk( 2 ,"*Headache* Headache please go away!")		---------------待定
	
end	
--------------------------------
-----------------------------------星空走廊　星寰爷爷
----------------------------------
function stway_talk07()

	Talk( 1, "Heard from past travelers, every territory have their own guardian." )

end	

-----------------------------------------
--------------------------------------星空走廊　星芯
-------------------------------------------
function stway_talk08()

	Talk( 1, "My grandpa says, at the very end of the space, have a very big Maze." )

end	

------------------------------------------
-------------------------------------星空走廊　月隐
-------------------------------------------
function stway_talk09()

	Talk( 1, "Tell you a secret, some monsters knows how to camouflage! Not only that, there is a secret lies in the hottest place in the space." )

end

-------------------------------------------------
--------------------------------------星空走廊　空域跳跃门
----------------------------------------------------
function stway_move()

	Talk( 1, "Welcometo the place of no return! Ha ha ha…." )
	Text ( 1, "Teleport to Argent City", JumpPage, 2)
	Text ( 1, "Teleport to Shaitan City", JumpPage, 3)
	Text ( 1, "Teleport to Icicle City", JumpPage, 4)
	Text ( 1, "Scary~! I will never come again!",CloseTalk )

	Talk( 2, "Teleport to Argent City? Hehe~ that would cost you 2000gold. If you are level 40 and below is free of charge!")
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 2223,22806, "garner")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 2223,2806, "garner")
	TriggerFailure( 2, JumpPage, 6 )
	Text( 2, "GO",MultiTrigger, GetMultiTrigger(), 2)

	Talk( 3, "Teleport to Shaitan City? Hehe~ that would cost you 2000gold. If you are level 40 and below is free of charge!")
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 918,3562, "magicsea")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 918,3562, "magicsea")
	TriggerFailure( 2, JumpPage, 6 )
	Text( 3, "Commence teleport",MultiTrigger, GetMultiTrigger(), 2)

	Talk( 4, "Teleport to Icicle City? Hehe~ that would cost you 2000gold. If you are level 40 and below is free of charge!")
	InitTrigger()
	TriggerCondition( 1, LvCheck, "<", 40 )
	TriggerAction( 1, GoTo, 1323,544, "darkblue")
	TriggerCondition( 2, HasMoney, 2000 )
	TriggerAction( 2, TakeMoney, 2000 )
	TriggerAction( 2, GoTo, 1323,544, "darkblue")
	TriggerFailure( 2, JumpPage, 6 )
	Text( 4, "Commence teleport",MultiTrigger, GetMultiTrigger(), 2 )
	
	Talk( 6, "Sorry but I won't accept if the money is doesn't stinks!" )

end	