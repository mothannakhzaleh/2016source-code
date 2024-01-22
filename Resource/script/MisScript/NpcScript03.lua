--------------------------------------------------------------------------
--									--
--									--
--				NPCScript03.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading NPCScript03.lua" )


jp= JumpPage
amp=AutoMissionPage
ct=CloseTalk
am=AddMission
MissionCheck = HasFlag
mc=MissionCheck


----------------------------------------------------------
--							--
--							--
--		白银城[交易员·郝洛甫]			--
--							--
--		225538,280188				--
----------------------------------------------------------
-----------------------------------------------------------这里开始P话聊天
function r_talk10 ()
	
	
	MISSCRIPT_NPCSCRIPT03_LUA_000001 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000001")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000001 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 1 )
	TriggerAction( 1, TradeBerthList, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 )
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000002")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000002 )
	
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

	InitGoods(1)
	
	SaleGoodsData(	0	,	4552	,	64	,	500	,	1000	)
	SaleGoodsData(	1	,	4553	,	64	,	500	,	1000	)
	SaleGoodsData(	1	,	4554	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4555	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4556	,	32	,	900	,	1400	)

	BuyGoodsData(0,	4557	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4561	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4572	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4574	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4586	,	-1	,	1600	,	2000	)
	-- SaleGoodsData(	0	,	4573	,	900	,	279	,	62	)
	-- SaleGoodsData(	0	,	4574	,	800	,	342	,	76	)
	-- SaleGoodsData(	1	,	4575	,	700	,	391	,	87	)
	-- SaleGoodsData(	1	,	4576	,	480	,	432	,	96	)
	-- SaleGoodsData(	2	,	4577	,	300	,	495	,	110	)
	-- SaleGoodsData(	2	,	4578	,	240	,	522	,	116	)
	-- SaleGoodsData(	3	,	4579	,	60	,	589	,	131	)
	-- SaleGoodsData(	3	,	4580	,	40	,	648	,	144	)

	-- BuyGoodsData(0,	4581	,	-1	,	542	,	121	)
	-- BuyGoodsData(0,	4583	,	-1	,	724	,	161	)
	-- BuyGoodsData(0,	4585	,	-1	,	846	,	188	)
	-- BuyGoodsData(0,	4587	,	-1	,	846	,	564	)
	-- BuyGoodsData(0,	4593	,	-1	,	1000	,	223	)
	-- BuyGoodsData(0,	4595	,	-1	,	938	,	625	)
	-- BuyGoodsData(0,	4597	,	-1	,	881	,	195	)
	-- BuyGoodsData(0,	4598	,	-1	,	878	,	195	)
	-- BuyGoodsData(0,	4600	,	-1	,	866	,	577	)
	-- BuyGoodsData(0,	4552	,	-1	,	642	,	143	)
	-- BuyGoodsData(0,	4553	,	-1	,	789	,	175	)
	-- BuyGoodsData(0,	4554	,	-1	,	934	,	207	)
	-- BuyGoodsData(0,	4556	,	-1	,	870	,	193	)
	-- BuyGoodsData(0,	4557	,	-1	,	970	,	215	)
	-- BuyGoodsData(0,	4560	,	-1	,	1056	,	235	)
	-- BuyGoodsData(0,	4563	,	-1	,	909	,	202	)
	-- BuyGoodsData(0,	4566	,	-1	,	785	,	175	)
	-- BuyGoodsData(0,	4569	,	-1	,	1014	,	225	)
	-- BuyGoodsData(0,	4572	,	-1	,	924	,	205	)
	-- BuyGoodsData(0,	4547	,	-1	,	100	,	0	)
	-- BuyGoodsData(0,	4549	,	-1	,	500	,	0	)
	-- BuyGoodsData(0,	4548	,	-1	,	300	,	0	)
	-- BuyGoodsData(0,	4551	,	-1	,	20	,	0	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()

	AddNpcMission 	(443)
	AddNpcMission 	(445)
	AddNpcMission 	(447)
	AddNpcMission	(1020)
	AddNpcMission	(1076)
	AddNpcMission	(1132)
	AddNpcMission	(1183)
	AddNpcMission(	1226	)
	
end 

-----<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<交易员·郝洛甫



----------------------------------------------------------
--							--
--							--
--		雷霆堡[交易员·桑吉]			--
--							--
--		103877,127848				--
----------------------------------------------------------
-----------------------------------------------------------这里开始P话聊天
function r_talk27 ()
	
	
	MISSCRIPT_NPCSCRIPT03_LUA_000012 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000012")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000012 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 2 )
	TriggerAction( 1, TradeBerthList, 2 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000013 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000013")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000013 )	
	
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
	
	
	
	InitGoods( 2)
	SaleGoodsData(	1	,	4557	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4558	,	32	,	700	,	1200	)

	
	BuyGoodsData(0,	4553	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4568	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4571	,	-1	,	900		,	1000	)
	BuyGoodsData(0,	4575	,	-1	,	1300	,	1600	)
	
	-- SaleGoodsData(	1	,	4597	,	480	,	436	,	97	)
	-- SaleGoodsData(	2	,	4598	,	300	,	472	,	105	)
	-- SaleGoodsData(	2	,	4599	,	240	,	508	,	113	)
	-- SaleGoodsData(	3	,	4600	,	60	,	571	,	127	)
	-- SaleGoodsData(	3	,	4601	,	40	,	643	,	143	)
	
	-- BuyGoodsData(0,	4573	,	-1	,	554	,	123	)
	-- BuyGoodsData(0,	4574	,	-1	,	711	,	158	)
	-- BuyGoodsData(0,	4576	,	-1	,	872	,	193	)
	-- BuyGoodsData(0,	4581	,	-1	,	548	,	121	)
	-- BuyGoodsData(0,	4583	,	-1	,	740	,	165	)
	-- BuyGoodsData(0,	4587	,	-1	,	900	,	600	)
	-- BuyGoodsData(0,	4591	,	-1	,	880	,	195	)
	-- BuyGoodsData(0,	4593	,	-1	,	1029	,	229	)
	-- BuyGoodsData(0,	4595	,	-1	,	976	,	651	)
	-- BuyGoodsData(0,	4553	,	-1	,	826	,	183	)
	-- BuyGoodsData(0,	4555	,	-1	,	793	,	177	)
	-- BuyGoodsData(0,	4556	,	-1	,	860	,	191	)
	-- BuyGoodsData(0,	4557	,	-1	,	960	,	213	)
	-- BuyGoodsData(0,	4559	,	-1	,	920	,	205	)
	-- BuyGoodsData(0,	4560	,	-1	,	1039	,	231	)
	-- BuyGoodsData(0,	4563	,	-1	,	909	,	202	)
	-- BuyGoodsData(0,	4566	,	-1	,	831	,	185	)
	-- BuyGoodsData(0,	4569	,	-1	,	1089	,	243	)
	-- BuyGoodsData(0,	4572	,	-1	,	924	,	205	)
	-- BuyGoodsData(0,	4547	,	-1	,	100	,	0	)
	-- BuyGoodsData(0,	4549	,	-1	,	450	,	0	)
	-- BuyGoodsData(0,	4550	,	-1	,	1000	,	0	)
	-- BuyGoodsData(0,	4548	,	-1	,	300	,	0	)
	-- BuyGoodsData(0,	4551	,	-1	,	20	,	0	)
	-- BuyGoodsData(0,	3913	,	-1	,	1248	,	832 	)
	-- BuyGoodsData(0,	3912	,	-1	,	1395	,	930 	)
	-- BuyGoodsData(0,	3914	,	-1	,	1614	,	1077	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()

	AddNpcMission	(1021)
	AddNpcMission	(1077)
	AddNpcMission	(1133)
	AddNpcMission	(1184)
----------交易员·桑吉-------双子	--------------03
	AddNpcMission	(5728)
	AddNpcMission	(5729)
end 

----------------------------------------------------------
--							--
--							--
--		沙岚城[船工·弗兰克]			--
--							--
--		90391,366735				--
----------------------------------------------------------
-----------------------------------------------------------这里开始P话聊天
function r_talk60 ()
	
	MISSCRIPT_NPCSCRIPT03_LUA_000014 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000014")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000014 )
	InitTrigger()
	TriggerCondition( 1, IsBoatFull )
	MISSCRIPT_NPCSCRIPT03_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000015")
	TriggerAction( 1, SystemNotice, MISSCRIPT_NPCSCRIPT03_LUA_000015 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001185")
	Text( 1, MISSCRIPT_MISSIONSCRIPT05_LUA_001185, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3 )
	TriggerAction( 1, BoatLevelBerthList, 3 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000016")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000016, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, LvCheck, ">", 14 ) 
	TriggerCondition( 1, NoRecord, 1913 ) 
	TriggerCondition( 1, NoItem, 3988, 1 )
	TriggerCondition( 1, NoItem, 6042, 1 )
	TriggerCondition( 1, HasRecord , 1821 )
	TriggerAction( 1, GiveItem, 6042, 1, 4 )
	TriggerAction( 1, SetRecord, 1913 )
	TriggerAction( 1, JumpPage, 5 )
	TriggerFailure( 1, JumpPage, 6 )
	--Text( 1, "我的船只制造证明丢了，我还要领一张", MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000017 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000017")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000017 )
	InitTrigger()
	TriggerCondition( 1, HasItem, 6042, 1 )
	TriggerCondition( 1, BoatBuildCheck, 1 )
	TriggerAction( 1, TakeItem, 6042, 1 )
	TriggerAction( 1, CreateBoat, 1, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000018 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000018")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000018, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 5 )
	TriggerAction( 1, CreateBoat, 5, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000019 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000019")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000019, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 6 )
	TriggerAction( 1, CreateBoat, 6, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000020 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000020")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000020, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 4 )
	TriggerAction( 1, CreateBoat, 4, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000021 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000021")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000021, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 14 )
	TriggerAction( 1, CreateBoat, 14, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000022 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000022")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000022, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 15 )
	TriggerAction( 1, CreateBoat, 15, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000023 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000023")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000023, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000024 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000024")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000024 )

	MISSCRIPT_NPCSCRIPT03_LUA_000025 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000025")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000025)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000026 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000026")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000026 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000027 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000027")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000027 )
	
	AddNpcMission	(1116)
	AddNpcMission	(158)
	AddNpcMission	(159)
	AddNpcMission	(160)
	
--------主线任务	
	AddNpcMission ( 6784 )
	AddNpcMission ( 6785 )
	AddNpcMission ( 6786 )
	
	
end 

------------------------------------------------------------
-- 白银城-----海事所助理·罗拉娜
--           2247,2857
------------------------------------------------------------

function r_talk150()

	MISSCRIPT_NPCSCRIPT03_LUA_000028 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000028")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000028 )

	MISSCRIPT_NPCSCRIPT03_LUA_000029 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000029")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000029, JumpPage,2 )

	MISSCRIPT_NPCSCRIPT03_LUA_000030 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000030")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000030 )

	InitTrigger()
	TriggerCondition( 1, NoRecord,1467 )
	TriggerCondition( 1, NoRecord,1468 )
	TriggerCondition( 1, HasItem, 1866, 1 )---------巨蟹门票
	TriggerAction( 1, TakeItem, 1866, 1 )----------巨蟹门票
	TriggerAction( 1, SetRecord, 1466 )
	TriggerAction( 1, SetRecord, 1469 )
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	CALCULATE_FUNCTIONS_LUA_000632 = GetResString("CALCULATE_FUNCTIONS_LUA_000632")
	Text( 2, CALCULATE_FUNCTIONS_LUA_000632,MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, NoRecord,1466 )
	TriggerCondition( 1, NoRecord,1468 )
	TriggerCondition( 1, HasItem, 1866, 1 )---------巨蟹门票
	TriggerAction( 1, TakeItem, 1866, 1 )----------巨蟹门票
	TriggerAction( 1, SetRecord, 1467 )
	TriggerAction( 1, SetRecord, 1469 )
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT01_LUA_000292 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000292")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_000292,MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, NoRecord,1466 )
	TriggerCondition( 1, NoRecord,1467 )
	TriggerCondition( 1, HasItem, 1866, 1 )--------巨蟹门票
	TriggerAction( 1, TakeItem, 1866, 1 )----------巨蟹门票
	TriggerAction( 1, SetRecord, 1468 )
	TriggerAction( 1, SetRecord, 1469 )
	TriggerAction( 1, JumpPage, 3 )
	TriggerFailure( 1, JumpPage, 4 )
	CALCULATE_FUNCTIONS_LUA_000620 = GetResString("CALCULATE_FUNCTIONS_LUA_000620")
	Text( 2, CALCULATE_FUNCTIONS_LUA_000620,MultiTrigger, GetMultiTrigger(), 1)

	MISSCRIPT_NPCSCRIPT03_LUA_000031 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000031")
	Talk(3, MISSCRIPT_NPCSCRIPT03_LUA_000031 )
	MISSCRIPT_NPCSCRIPT03_LUA_000032 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000032")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000032)
	
	AddNpcMission 	(437)
	AddNpcMission 	(439)
	AddNpcMission 	(441)

------------罗拉娜
-----------------------巨蟹座
	AddNpcMission 	(5800)
	AddNpcMission 	(5801)
	AddNpcMission 	(5802)
	AddNpcMission 	(5803)
	AddNpcMission 	(5804)
	AddNpcMission 	(5805)
	AddNpcMission 	(5806)
	AddNpcMission 	(5807)
	AddNpcMission 	(5808)
	AddNpcMission 	(5809)
	AddNpcMission 	(5810)
	AddNpcMission 	(5811)
	AddNpcMission 	(5812)
	AddNpcMission 	(5813)
	AddNpcMission 	(5814)
	AddNpcMission 	(5815)
	AddNpcMission 	(5816)
	AddNpcMission 	(5857)
	AddNpcMission 	(5858)
	AddNpcMission 	(5862)
	AddNpcMission 	(5863)
	AddNpcMission 	(5864)

end

------------------------------------------------------------
-- 白银城-----船工·斯巴克
------------------------------------------------------------
function r_talk151 ()
		
	MISSCRIPT_NPCSCRIPT03_LUA_000033 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000033")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000033 )
	InitTrigger()
	TriggerCondition( 1, IsBoatFull )
	MISSCRIPT_NPCSCRIPT03_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000015")
	TriggerAction( 1, SystemNotice, MISSCRIPT_NPCSCRIPT03_LUA_000015 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001185")
	Text( 1, MISSCRIPT_MISSIONSCRIPT05_LUA_001185, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 1 )
	TriggerAction( 1, BoatLevelBerthList, 1 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000016")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000016, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, LvCheck, ">", 14 ) 
	TriggerCondition( 1, NoRecord, 1913 ) 
	TriggerCondition( 1, NoItem, 3988, 1 )
	TriggerCondition( 1, NoItem, 6042, 1 )
	TriggerCondition( 1, HasRecord , 1821 )
	TriggerAction( 1, GiveItem, 6042, 1, 4 )
	TriggerAction( 1, SetRecord, 1913 )
	TriggerAction( 1, JumpPage, 5 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000034 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000034")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000034, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000035 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000035")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000035 )
	InitTrigger()
	TriggerCondition( 1, HasItem, 6042, 1 )
	TriggerCondition( 1, BoatBuildCheck, 1 )
	TriggerAction( 1, TakeItem, 6042, 1 )
	TriggerAction( 1, CreateBoat, 1, 1 )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000018 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000018")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000018, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 2 )
	TriggerAction( 1, CreateBoat, 2, 1 )
	MISSCRIPT_NPCSCRIPT03_LUA_000036 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000036")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000036, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 3 )
	TriggerAction( 1, CreateBoat, 3, 1 )
	MISSCRIPT_NPCSCRIPT03_LUA_000037 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000037")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000037, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 6 )
	TriggerAction( 1, CreateBoat, 6, 1 )
	MISSCRIPT_NPCSCRIPT03_LUA_000020 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000020")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000020, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000038 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000038")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000038 )

	MISSCRIPT_NPCSCRIPT03_LUA_000039 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000039")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000039)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000040 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000040")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000040 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000041 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000041")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000041 )
--------主线任务	
	AddNpcMission ( 6784 )
	AddNpcMission ( 6785 )
	AddNpcMission ( 6786 )
	
end 

------------------------------------------------------------
-- 白银城-----海港指挥·雪莉
------------------------------------------------------------

function r_talk152()

	MISSCRIPT_NPCSCRIPT03_LUA_000042 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000042")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000042 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 1 )
	--TriggerAction( 1, RemoveYS )
	TriggerAction( 1, LuanchBerthList, 1, 2260,2829, 177 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 1 )
	TriggerAction( 2, RepairBerthList, 1 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 1 )
	TriggerAction( 2, SupplyBerthList, 1 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 1 )
	TriggerAction( 1, SalvageBerthList, 1 )
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

	AddNpcMission ( 289 )
	AddNpcMission ( 290 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6702 )
----------主线任务
	AddNpcMission ( 6787 )
	AddNpcMission ( 6788 )
	AddNpcMission ( 6789 )
	AddNpcMission ( 6790 )
	AddNpcMission ( 6791 )
	AddNpcMission ( 6792 )


end

------------------------------------------------------------
-- 沙岚城-----海港指挥·马克
------------------------------------------------------------

function r_talk153()

	MISSCRIPT_NPCSCRIPT03_LUA_000051 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000051")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000051 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 832, 3698, 180 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 3 )
	TriggerAction( 2, RepairBerthList, 3 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 3 )
	TriggerAction( 2, SupplyBerthList, 3 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 3 )
	TriggerAction( 1, SalvageBerthList, 3 )
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

-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6704 )

end

------------------------------------------------------------
--冰狼堡-----船工·乔治
------------------------------------------------------------
function r_talk155 ()
		
	MISSCRIPT_NPCSCRIPT03_LUA_000052 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000052")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000052 )
	InitTrigger()
	TriggerCondition( 1, IsBoatFull )
	MISSCRIPT_NPCSCRIPT03_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000015")
	TriggerAction( 1, SystemNotice, MISSCRIPT_NPCSCRIPT03_LUA_000015 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001185")
	Text( 1, MISSCRIPT_MISSIONSCRIPT05_LUA_001185, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 4 )
	TriggerAction( 1, BoatLevelBerthList, 4 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000016")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000016, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerCondition( 1, LvCheck, ">", 14 ) 
	TriggerCondition( 1, NoRecord, 1913 ) 
	TriggerCondition( 1, NoItem, 3988, 1 )
	TriggerCondition( 1, NoItem, 6042, 1 )
	TriggerCondition( 1, HasRecord , 1821 )
	TriggerAction( 1, GiveItem, 6042, 1, 4 )
	TriggerAction( 1, SetRecord, 1913 )
	TriggerAction( 1, JumpPage, 5 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000053 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000053")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000053, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000054 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000054")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000054 )
	InitTrigger()
	TriggerCondition( 1, HasItem, 6042, 1 )
	TriggerCondition( 1, BoatBuildCheck, 1 )
	TriggerAction( 1, TakeItem, 6042, 1 )
	TriggerAction( 1, CreateBoat, 1, 4 )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000018 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000018")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000018, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 2 )
	TriggerAction( 1, CreateBoat, 2, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000036 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000036")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000036, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 5 )
	TriggerAction( 1, CreateBoat, 5, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000019 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000019")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000019, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 3 )
	TriggerAction( 1, CreateBoat, 3, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000037 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000037")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000037, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 4 )
	TriggerAction( 1, CreateBoat, 4, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000021 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000021")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000021, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 16 )
	TriggerAction( 1, CreateBoat, 16, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000055 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000055")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000055, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000056 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000056")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000056 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000057 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000057")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000057)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000058 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000058")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000058 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000059 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000059")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000059 )
	
--------主线任务	
	AddNpcMission ( 6784 )
	AddNpcMission ( 6785 )
	AddNpcMission ( 6786 )
end 

------------------------------------------------------------
-- 冰狼堡-----海港指挥·席林
------------------------------------------------------------

function r_talk154()

	MISSCRIPT_NPCSCRIPT03_LUA_000060 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000060")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000060 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 4 )
	TriggerAction( 1, LuanchBerthList, 4, 1196,673, 177 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 4 )
	TriggerAction( 2, RepairBerthList, 4 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 4 )
	TriggerAction( 2, SupplyBerthList, 4 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 4 )
	TriggerAction( 1, SalvageBerthList, 4 )
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

	AddNpcMission ( 294 )
	AddNpcMission ( 295 )
	-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6708 )
end


------------------------------------------------------------
-- 海风岛-----海港指挥·路凡
------------------------------------------------------------

function r_talk178()

	MISSCRIPT_NPCSCRIPT03_LUA_000061 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000061")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000061 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 5 )
	TriggerAction( 1, LuanchBerthList, 5, 3240, 3314, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 5 )
	TriggerAction( 2, RepairBerthList, 5 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 5 )
	TriggerAction( 2, SupplyBerthList, 5 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 5 )
	TriggerAction( 1, SalvageBerthList, 5 )
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
	
end

------------------------------------------------------------
-- 碎冰岛-----海港指挥·诺尔德
------------------------------------------------------------

function r_talk179()

	MISSCRIPT_NPCSCRIPT03_LUA_000062 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000062")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000062 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 6 )
	TriggerAction( 1, LuanchBerthList, 6, 2301, 1144, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 6 )
	TriggerAction( 2, RepairBerthList, 6 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 6 )
	TriggerAction( 2, SupplyBerthList, 6 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 6 )
	TriggerAction( 1, SalvageBerthList, 6 )
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

end

------------------------------------------------------------
-- 雪贼岛-----海港指挥·鲁鲁伊
------------------------------------------------------------

function r_talk180()

	MISSCRIPT_NPCSCRIPT03_LUA_000063 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000063")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000063 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 7 )
	TriggerAction( 1, LuanchBerthList, 7, 3628, 770, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 7 )
	TriggerAction( 2, RepairBerthList, 7 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 7 )
	TriggerAction( 2, SupplyBerthList, 7 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 7 )
	TriggerAction( 1, SalvageBerthList, 7 )
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

end

------------------------------------------------------------
-- 萨拉补给站-----海港指挥·温亚塔
------------------------------------------------------------

function r_talk181()

	MISSCRIPT_NPCSCRIPT03_LUA_000064 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000064")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000064 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )


	AddNpcMission	(763)
	AddNpcMission(	1742	)
	AddNpcMission (	1938	)
	AddNpcMission (	1953	)
----------------吉尼斯---海港指挥·温亚塔--03
	AddNpcMission	(5511)
	AddNpcMission	(5512)
	

end

------------------------------------------------------------
-- 阿尔补给站-----海港指挥·达耶达
------------------------------------------------------------

function r_talk182()

	MISSCRIPT_NPCSCRIPT03_LUA_000067 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000067")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000067 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 


	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	AddNpcMission	(379)
	AddNpcMission	(380)
----------------吉尼斯---海港指挥·达耶达--03
	AddNpcMission (5533 )
	AddNpcMission (5534 )
-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6706 )
end

------------------------------------------------------------
-- 哈尔补给站-----海港指挥·瓦雷米
------------------------------------------------------------

function r_talk183()

	MISSCRIPT_NPCSCRIPT03_LUA_000068 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000068")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000068 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 
--Text( 1, "获得精灵之魂", JumpPage, 6 ) 
	
	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	InitTrigger()
	TriggerCondition( 1, HasItem, 3116, 50 )
	TriggerAction( 1, TakeItem, 3116, 50 )
	TriggerAction( 1, GiveItem, 3337, 1, 4 )
	TriggerFailure( 1, JumpPage, 7 )
	MISSCRIPT_NPCSCRIPT03_LUA_000069 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000069")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000069 )
	MISSCRIPT_NPCSCRIPT03_LUA_000070 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000070")
	Text( 6, MISSCRIPT_NPCSCRIPT03_LUA_000070, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000071 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000071")
	Talk( 7, MISSCRIPT_NPCSCRIPT03_LUA_000071 )


	AddNpcMission(	1740	)
	AddNpcMission (	1936	)
	AddNpcMission (	1951	)
	AddNpcMission (	381	)
	AddNpcMission (	382	)
----------------吉尼斯---海港指挥·瓦雷米--03
	AddNpcMission (5531 )
	AddNpcMission (5532 )
	-----------------海港指挥·瓦雷米---------金牛
	AddNpcMission	(5655)
	AddNpcMission	(5656)

	

end

------------------------------------------------------------
-- 弗里敦补给站-----海港指挥·法第尔
------------------------------------------------------------

function r_talk184()

	MISSCRIPT_NPCSCRIPT03_LUA_000072 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000072")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000072 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )


	AddNpcMission(	1739	)
	AddNpcMission (	1935	)
	AddNpcMission (	1950	)
	AddNpcMission (	383	)
	AddNpcMission (	384	)
	AddNpcMission (	385	)

	----------------吉尼斯---海港指挥·法第尔--03
	AddNpcMission (5529 )
	AddNpcMission (5530 )



end

------------------------------------------------------------
-- 海风岛-----交易员·布尔兹
------------------------------------------------------------

function r_talk185()

	MISSCRIPT_NPCSCRIPT03_LUA_000073 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000073")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000073 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 5 )
	TriggerAction( 1, TradeBerthList, 5 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)	

	MISSCRIPT_NPCSCRIPT03_LUA_000074 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000074")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000074 )	

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

	InitGoods(5)
	SaleGoodsData(	1	,	4567	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4568	,	32	,	700	,	1200	)
	SaleGoodsData(	2	,	4569	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4570	,	32	,	900	,	1400	)

	BuyGoodsData(0,	4552	,	-1	,	900	,	1000	)
	BuyGoodsData(0,	4558	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4560	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4573	,	-1	,	1300	,	1600 )
	BuyGoodsData(0,	4575	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4582	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4587	,	-1	,	1600	,	2000	)
	
	
	-- SaleGoodsData(	0	,	4552	,	800	,	315	,	70	)
	-- SaleGoodsData(	1	,	4553	,	700	,	405	,	90	)
	-- SaleGoodsData(	1	,	4554	,	480	,	477	,	106	)

	-- BuyGoodsData(0,	4574	,	-1	,	697	,	155	)
	-- BuyGoodsData(0,	4578	,	-1	,	960	,	213	)
	-- BuyGoodsData(0,	4580	,	-1	,	972	,	648	)
	-- BuyGoodsData(0,	4582	,	-1	,	664	,	147	)
	-- BuyGoodsData(0,	4584	,	-1	,	818	,	181	)
	-- BuyGoodsData(0,	4586	,	-1	,	895	,	199	)
	-- BuyGoodsData(0,	4588	,	-1	,	969	,	646	)
	-- BuyGoodsData(0,	4590	,	-1	,	725	,	161	)
	-- BuyGoodsData(0,	4592	,	-1	,	1017	,	226	)
	-- BuyGoodsData(0,	4594	,	-1	,	1071	,	238	)
	-- BuyGoodsData(0,	4598	,	-1	,	888	,	197	)
	-- BuyGoodsData(0,	4599	,	-1	,	955	,	213	)
	-- BuyGoodsData(0,	4601	,	-1	,	991	,	661	)
	-- BuyGoodsData(0,	4557	,	-1	,	981	,	218	)
	-- BuyGoodsData(0,	4560	,	-1	,	1124	,	249	)
	-- BuyGoodsData(0,	4563	,	-1	,	976	,	217	)
	-- BuyGoodsData(0,	4566	,	-1	,	763	,	169	)
	-- BuyGoodsData(0,	4569	,	-1	,	981	,	218	)
	-- BuyGoodsData(0,	4572	,	-1	,	950	,	211	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()



	-- AddNpcMission	(760)
		
end

------------------------------------------------------------
-- 碎冰岛-----交易员·赛瑟尼
------------------------------------------------------------

function r_talk186()

	MISSCRIPT_NPCSCRIPT03_LUA_000075 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000075")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000075 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 6 )
	TriggerAction( 1, TradeBerthList, 6 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)

	MISSCRIPT_NPCSCRIPT03_LUA_000076 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000076")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000076 )
	
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

	InitGoods(6)
	SaleGoodsData(	0	,	4571	,	64	,	500	,	1000	)
	SaleGoodsData(	1	,	4572	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4573	,	32	,	700	,	1200	)

	BuyGoodsData(0,	4553	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4568	,	-1	,	1300	,	1600	)
	
	-- SaleGoodsData(	1	,	4555	,	480	,	405	,	90	)
	-- SaleGoodsData(	2	,	4556	,	300	,	468	,	104	)
	-- SaleGoodsData(	2	,	4557	,	240	,	522	,	116	)

	-- BuyGoodsData(0,	4573	,	-1	,	554	,	123	)
	-- BuyGoodsData(0,	4574	,	-1	,	711	,	158	)
	-- BuyGoodsData(0,	4575	,	-1	,	780	,	173	)
	-- BuyGoodsData(0,	4585	,	-1	,	936	,	208	)
	-- BuyGoodsData(0,	4586	,	-1	,	970	,	215	)
	-- BuyGoodsData(0,	4590	,	-1	,	699	,	155	)
	-- BuyGoodsData(0,	4592	,	-1	,	963	,	214	)
	-- BuyGoodsData(0,	4594	,	-1	,	997	,	221	)
	-- BuyGoodsData(0,	4596	,	-1	,	1027	,	685	)
	-- BuyGoodsData(0,	4597	,	-1	,	855	,	190	)
	-- BuyGoodsData(0,	4600	,	-1	,	857	,	571	)
	-- BuyGoodsData(0,	4554	,	-1	,	991	,	221	)
	-- BuyGoodsData(0,	4558	,	-1	,	828	,	184	)
	-- BuyGoodsData(0,	4559	,	-1	,	910	,	203	)
	-- BuyGoodsData(0,	4562	,	-1	,	819	,	183	)
	-- BuyGoodsData(0,	4563	,	-1	,	879	,	195	)
	-- BuyGoodsData(0,	4566	,	-1	,	831	,	185	)
	-- BuyGoodsData(0,	4569	,	-1	,	1126	,	251	)
	-- BuyGoodsData(0,	4572	,	-1	,	924	,	205	)


	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()
		
	-- AddNpcMission	(761)

	-----------------交易员·赛瑟尼---------金牛
	AddNpcMission	(5643)
	AddNpcMission	(5644)
end

------------------------------------------------------------
-- 雪贼岛-----交易员·肥德拉德
------------------------------------------------------------

function r_talk187()

	MISSCRIPT_NPCSCRIPT03_LUA_000077 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000077")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000077 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 7 )
	TriggerAction( 1, TradeBerthList, 7 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)

	MISSCRIPT_NPCSCRIPT03_LUA_000078 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000078")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000078 )	

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


	InitGoods(7)
	SaleGoodsData(	1	,	4574	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4575	,	64	,	700	,	1200	)
	SaleGoodsData(	3	,	4576	,	32	,	900	,	1400	)

	BuyGoodsData(0,	4554	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4558	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4569	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4578	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4587	,	-1	,	1600	,	2000	)
	
	-- SaleGoodsData(	2	,	4558	,	300	,	450	,	100	)
	-- SaleGoodsData(	2	,	4559	,	240	,	495	,	110	)
	-- SaleGoodsData(	3	,	4560	,	60	,	571	,	127	)

	-- BuyGoodsData(0,	4576	,	-1	,	898	,	199	)
	-- BuyGoodsData(0,	4577	,	-1	,	930	,	207	)
	-- BuyGoodsData(0,	4585	,	-1	,	936	,	208	)
	-- BuyGoodsData(0,	4587	,	-1	,	938	,	625	)
	-- BuyGoodsData(0,	4589	,	-1	,	548	,	121	)
	-- BuyGoodsData(0,	4591	,	-1	,	844	,	187	)
	-- BuyGoodsData(0,	4593	,	-1	,	972	,	216	)
	-- BuyGoodsData(0,	4595	,	-1	,	900	,	600	)
	-- BuyGoodsData(0,	4597	,	-1	,	881	,	195	)
	-- BuyGoodsData(0,	4599	,	-1	,	945	,	210	)
	-- BuyGoodsData(0,	4600	,	-1	,	866	,	577	)
	-- BuyGoodsData(0,	4554	,	-1	,	1020	,	227	)
	-- BuyGoodsData(0,	4555	,	-1	,	793	,	177	)
	-- BuyGoodsData(0,	4556	,	-1	,	860	,	191	)
	-- BuyGoodsData(0,	4557	,	-1	,	960	,	213	)
	-- BuyGoodsData(0,	4561	,	-1	,	808	,	179	)
	-- BuyGoodsData(0,	4566	,	-1	,	876	,	195	)
	-- BuyGoodsData(0,	4569	,	-1	,	1089	,	243	)
	-- BuyGoodsData(0,	4572	,	-1	,	924	,	205	)



	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()


	-- AddNpcMission	(762)	
end

------------------------------------------------------------
-- 冰雪岛-----海港指挥·波尔
------------------------------------------------------------

function r_talk188()

	MISSCRIPT_NPCSCRIPT03_LUA_000079 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000079")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000079 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 8 )
	TriggerAction( 1, LuanchBerthList, 8, 2351, 767, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 8 )
	TriggerAction( 2, RepairBerthList, 8 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 8 )
	TriggerAction( 2, SupplyBerthList, 8 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 8 )
	TriggerAction( 1, SalvageBerthList, 8 )
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
	----------海港指挥·波尔-------双子--------03
	AddNpcMission	(5704)
	AddNpcMission	(5705)
end

------------------------------------------------------------
-- 鸣沙岛-----海港指挥·托玛
------------------------------------------------------------

function r_talk189()

	MISSCRIPT_NPCSCRIPT03_LUA_000080 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000080")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000080 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 9 )
	TriggerAction( 1, LuanchBerthList, 9, 1769, 3788, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 9 )
	TriggerAction( 2, RepairBerthList, 9 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 9 )
	TriggerAction( 2, SupplyBerthList, 9 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 9 )
	TriggerAction( 1, SalvageBerthList, 9 )
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

	-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6707 )
end

------------------------------------------------------------
-- 真爱岛-----海港指挥·夏德利
------------------------------------------------------------
function r_talk190()

	MISSCRIPT_NPCSCRIPT03_LUA_000081 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000081")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000081 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 10 )
	TriggerAction( 1, LuanchBerthList, 10, 2527, 2358, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 10 )
	TriggerAction( 2, RepairBerthList, 10 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 10 )
	TriggerAction( 2, SupplyBerthList, 10 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 10 )
	TriggerAction( 1, SalvageBerthList, 10 )
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
end

------------------------------------------------------------
-- 苏港补给站-----海港指挥·鲁西
------------------------------------------------------------
function r_talk191()

	MISSCRIPT_NPCSCRIPT03_LUA_000082 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000082")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000082 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )
	 -------------吉尼斯--苏港补给站,海港指挥·鲁西(464,468)--03
	AddNpcMission (5527 )
	AddNpcMission (5528 )


end

------------------------------------------------------------
-- 埃弗里补给站-----海港指挥·布纽
------------------------------------------------------------
function r_talk192()

	MISSCRIPT_NPCSCRIPT03_LUA_000083 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000083")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000083 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	AddNpcMission ( 304 )
	AddNpcMission ( 305 )
	AddNpcMission(	1743	)
	AddNpcMission (	1939	)
	AddNpcMission (	1954	)
	AddNpcMission (	386	)
	AddNpcMission (	387	)

	----------------吉尼斯---海港指挥·布纽--03
	AddNpcMission (5525 )
	AddNpcMission (5526 )
	
end


------------------------------------------------------------
-- 拉古补给站-----海港指挥·多廉达
------------------------------------------------------------
function r_talk193()

	MISSCRIPT_NPCSCRIPT03_LUA_000084 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000084")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000084 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	AddNpcMission(	1441	)
	AddNpcMission (	1931	)

	----------------吉尼斯---海港指挥·多廉达--03
	AddNpcMission (5523 )
	AddNpcMission (5524 )


end

------------------------------------------------------------
-- 其索单补给站-----海港指挥·特巴齐
------------------------------------------------------------
function r_talk194()

	MISSCRIPT_NPCSCRIPT03_LUA_000085 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000085")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000085 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

end

------------------------------------------------------------
-- 穆穆尔补给站-----海港指挥·巴奥
------------------------------------------------------------
function r_talk195()

	MISSCRIPT_NPCSCRIPT03_LUA_000086 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000086")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000086 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	AddNpcMission ( 291 )
	AddNpcMission ( 292 )
	AddNpcMission ( 293 )
	AddNpcMission(	1443	)
	AddNpcMission (	1932	)

	


end

------------------------------------------------------------
-- 小肯补给站-----海港指挥·迪迪萨
------------------------------------------------------------
function r_talk196()

	MISSCRIPT_NPCSCRIPT03_LUA_000087 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000087")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000087 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )
	----------------吉尼斯---海港指挥·迪迪萨--03
	AddNpcMission (5515 )
	AddNpcMission (5516 )
end

------------------------------------------------------------
-- 肖沸补给站-----海港指挥·丹尼斯
------------------------------------------------------------
function r_talk197()

	MISSCRIPT_NPCSCRIPT03_LUA_000088 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000088")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000088 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	----------------1.7
	AddNpcMission (5133 )
	AddNpcMission (5134 )
	AddNpcMission (5135 )

	----------------吉尼斯---海港指挥·丹尼斯--03
	AddNpcMission (5513 )
	AddNpcMission (5514 )
end

------------------------------------------------------------
-- 埃皮杜补给站-----海港指挥·索尔
------------------------------------------------------------
function r_talk198()

	MISSCRIPT_NPCSCRIPT03_LUA_000089 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000089")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000089 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )
	----------------吉尼斯---海港指挥·索尔--03
	AddNpcMission (5517 )
	AddNpcMission (5518 )
end

------------------------------------------------------------
-- 冰雪岛-----交易员·西尔班
------------------------------------------------------------

function r_talk199()

	MISSCRIPT_NPCSCRIPT03_LUA_000090 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000090")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000090 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 8 )
	TriggerAction( 1, TradeBerthList, 8 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)

	MISSCRIPT_NPCSCRIPT03_LUA_000091 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000091")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000091 )	

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

	InitGoods(8)
	SaleGoodsData(	1	,	4577	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4578	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4579	,	32	,	900	,	1400	)
	SaleGoodsData(	3	,	4580	,	32	,	900	,	1400	)

	BuyGoodsData(0,	4562	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4564	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4575	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4583	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4584	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4591	,	-1	,	1600	,	2000	)
	
	-- SaleGoodsData(	1	,	4561	,	480	,	400	,	89	)
	-- SaleGoodsData(	2	,	4562	,	300	,	436	,	97	)
	-- SaleGoodsData(	2	,	4563	,	240	,	468	,	104	)

	-- BuyGoodsData(0,	4578	,	-1	,	1014	,	225	)
	-- BuyGoodsData(0,	4580	,	-1	,	1056	,	705	)
	-- BuyGoodsData(0,	4586	,	-1	,	936	,	208	)
	-- BuyGoodsData(0,	4588	,	-1	,	1042	,	695	)
	-- BuyGoodsData(0,	4590	,	-1	,	673	,	149	)
	-- BuyGoodsData(0,	4592	,	-1	,	909	,	202	)
	-- BuyGoodsData(0,	4594	,	-1	,	954	,	212	)
	-- BuyGoodsData(0,	4596	,	-1	,	955	,	637	)
	-- BuyGoodsData(0,	4598	,	-1	,	954	,	212	)
	-- BuyGoodsData(0,	4599	,	-1	,	988	,	219	)
	-- BuyGoodsData(0,	4601	,	-1	,	1049	,	699	)
	-- BuyGoodsData(0,	4554	,	-1	,	1077	,	239	)
	-- BuyGoodsData(0,	4556	,	-1	,	879	,	195	)
	-- BuyGoodsData(0,	4558	,	-1	,	837	,	186	)
	-- BuyGoodsData(0,	4559	,	-1	,	920	,	205	)
	-- BuyGoodsData(0,	4560	,	-1	,	1039	,	231	)
	-- BuyGoodsData(0,	4566	,	-1	,	854	,	189	)
	-- BuyGoodsData(0,	4569	,	-1	,	1052	,	233	)
	-- BuyGoodsData(0,	4572	,	-1	,	872	,	193	)


	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()


	
end

------------------------------------------------------------
-- 鸣沙岛-----交易员·米索亚斯
------------------------------------------------------------

function r_talk200()

	MISSCRIPT_NPCSCRIPT03_LUA_000092 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000092")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000092 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 9 )
	TriggerAction( 1, TradeBerthList, 9 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)

	MISSCRIPT_NPCSCRIPT03_LUA_000093 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000093")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000093 )	
	
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

	InitGoods(9)
	SaleGoodsData(	0	,	4581	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4582	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4583	,	32	,	900	,	1400	)

	BuyGoodsData(0,	4559	,	-1	,	900		,	1000	)
	BuyGoodsData(0,	4569	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4579	,	-1	,	1600	,	2000	)
	
	-- SaleGoodsData(	0	,	4564	,	800	,	283	,	63	)
	-- SaleGoodsData(	1	,	4565	,	560	,	342	,	76	)
	-- SaleGoodsData(	1	,	4566	,	360	,	378	,	84	)

	-- BuyGoodsData(0,	4574	,	-1	,	724	,	161	)
	-- BuyGoodsData(0,	4575	,	-1	,	798	,	177	)
	-- BuyGoodsData(0,	4576	,	-1	,	898	,	199	)
	-- BuyGoodsData(0,	4581	,	-1	,	531	,	119	)
	-- BuyGoodsData(0,	4582	,	-1	,	651	,	145	)
	-- BuyGoodsData(0,	4590	,	-1	,	699	,	155	)
	-- BuyGoodsData(0,	4592	,	-1	,	963	,	214	)
	-- BuyGoodsData(0,	4596	,	-1	,	1027	,	685	)
	-- BuyGoodsData(0,	4598	,	-1	,	982	,	219	)
	-- BuyGoodsData(0,	4601	,	-1	,	1105	,	737	)
	-- BuyGoodsData(0,	4553	,	-1	,	807	,	179	)
	-- BuyGoodsData(0,	4554	,	-1	,	963	,	214	)
	-- BuyGoodsData(0,	4557	,	-1	,	1052	,	233	)
	-- BuyGoodsData(0,	4560	,	-1	,	1268	,	281	)
	-- BuyGoodsData(0,	4563	,	-1	,	976	,	217	)
	-- BuyGoodsData(0,	4567	,	-1	,	705	,	157	)
	-- BuyGoodsData(0,	4568	,	-1	,	860	,	191	)
	-- BuyGoodsData(0,	4569	,	-1	,	960	,	213	)
	-- BuyGoodsData(0,	4572	,	-1	,	872	,	193	)




	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()


----------交易员·米索亚斯-------双子---03
	AddNpcMission	(5710)
	AddNpcMission	(5711)
end

------------------------------------------------------------
-- 真爱岛-----交易员·尤卡
------------------------------------------------------------

function r_talk201()

	MISSCRIPT_NPCSCRIPT03_LUA_000094 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000094")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000094 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 10 )
	TriggerAction( 1, TradeBerthList, 10 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000095 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000095")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000095 )	

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

	InitGoods(10)
	SaleGoodsData(	1	,	4584	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4585	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4586	,	32	,	900	,	1400	)
	SaleGoodsData(	3	,	4587	,	32	,	900	,	1400	)
	
	BuyGoodsData(0,	4556	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4560	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4566	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4570	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4576	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4577	,	-1	,	1000	,	1200	)
	BuyGoodsData(0,	4581	,	-1	,	900		,	1000	)
	BuyGoodsData(0,	4590	,	-1	,	1300	,	1600	)
	
	-- SaleGoodsData(	1	,	4567	,	600	,	360	,	80	)
	-- SaleGoodsData(	2	,	4568	,	400	,	468	,	104	)
	-- SaleGoodsData(	2	,	4569	,	240	,	522	,	116	)

	-- BuyGoodsData(0,	4576	,	-1	,	924	,	205	)
	-- BuyGoodsData(0,	4577	,	-1	,	999	,	223	)
	-- BuyGoodsData(0,	4578	,	-1	,	1014	,	225	)
	-- BuyGoodsData(0,	4582	,	-1	,	664	,	147	)
	-- BuyGoodsData(0,	4584	,	-1	,	818	,	181	)
	-- BuyGoodsData(0,	4589	,	-1	,	542	,	121	)
	-- BuyGoodsData(0,	4593	,	-1	,	904	,	201	)
	-- BuyGoodsData(0,	4595	,	-1	,	846	,	564	)
	-- BuyGoodsData(0,	4597	,	-1	,	986	,	219	)
	-- BuyGoodsData(0,	4599	,	-1	,	1061	,	235	)
	-- BuyGoodsData(0,	4600	,	-1	,	1017	,	678	)
	-- BuyGoodsData(0,	4554	,	-1	,	991	,	221	)
	-- BuyGoodsData(0,	4557	,	-1	,	1126	,	251	)
	-- BuyGoodsData(0,	4560	,	-1	,	1220	,	271	)
	-- BuyGoodsData(0,	4563	,	-1	,	943	,	209	)
	-- BuyGoodsData(0,	4564	,	-1	,	577	,	129	)
	-- BuyGoodsData(0,	4565	,	-1	,	666	,	149	)
	-- BuyGoodsData(0,	4570	,	-1	,	550	,	123	)
	-- BuyGoodsData(0,	4571	,	-1	,	842	,	187	)





	
	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()

-----------------交易员·尤卡---------金牛
	AddNpcMission	(5633)
	AddNpcMission	(5634)
----------交易员·尤卡-------双子---------------------03
	AddNpcMission	(5716)
	AddNpcMission	(5717)
end

------------------------------------------------------------
-- 好运岛-----海港指挥·卢克
------------------------------------------------------------
function r_talk202()

	MISSCRIPT_NPCSCRIPT03_LUA_000096 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000096")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000096 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 11 )
	TriggerAction( 1, LuanchBerthList, 11, 1642, 2005, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 11 )
	TriggerAction( 2, RepairBerthList, 11 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 11 )
	TriggerAction( 2, SupplyBerthList, 11 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 11 )
	TriggerAction( 1, SalvageBerthList, 11 )
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
end

------------------------------------------------------------
-- 萨迪勒补给站-----海港指挥·乔尔尼
------------------------------------------------------------
function r_talk203()

	MISSCRIPT_NPCSCRIPT03_LUA_000097 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000097")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000097 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	-------奥运活动
	AddNpcMission (	6260 )
	AddNpcMission (	6261 )
	-----------------

	AddNpcMission(	1741	)
	AddNpcMission (	1937	)
	AddNpcMission (	1952	)
	------------------eleven
	AddNpcMission (	5063 )
	AddNpcMission (	5071 )
--------------------1.7
	AddNpcMission ( 5075	)
	AddNpcMission(	5091 )
	AddNpcMission (5105 )
	AddNpcMission (5106 )
	AddNpcMission (5107 )
	AddNpcMission (5108 )
	AddNpcMission (5115 )
	----------------吉尼斯---海港指挥·乔尔尼--03
	AddNpcMission (5521 )
	AddNpcMission (5522 )
end

------------------------------------------------------------
-- 卡马赛补给站-----海港指挥·奥登
------------------------------------------------------------
function r_talk204()

	MISSCRIPT_NPCSCRIPT03_LUA_000098 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000098")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000098 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )
	----------------吉尼斯---海港指挥·奥登--03
	AddNpcMission (5519 )
	AddNpcMission (5520 )
	-----------------海港指挥·奥登---------金牛
	AddNpcMission	(5635)
	AddNpcMission	(5636)
end

------------------------------------------------------------
-- 思思索补给站-----海港指挥·拉米修
------------------------------------------------------------
function r_talk205()

	MISSCRIPT_NPCSCRIPT03_LUA_000099 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000099")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000099 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerFailure( 1, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 1 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000065 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000065")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000065 )
	MISSCRIPT_NPCSCRIPT03_LUA_000066 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000066")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000066 )

	-----------------海港指挥·拉米修---------金牛
	AddNpcMission	(5659)
	AddNpcMission	(5660)
	----------海港指挥·拉米修-------双子--------------03
	AddNpcMission	(5724)
	AddNpcMission	(5725)
end

------------------------------------------------------------
-- 好运岛-----交易员·帕德琉斯
------------------------------------------------------------

function r_talk206()

	MISSCRIPT_NPCSCRIPT03_LUA_000100 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000100")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000100 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 11 )
	TriggerAction( 1, TradeBerthList, 11 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)

	MISSCRIPT_NPCSCRIPT03_LUA_000101 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000101")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000101 )	

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

	InitGoods(11)
	SaleGoodsData(	0	,	4588	,	64	,	500	,	1000	)
	SaleGoodsData(	1	,	4589	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4590	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4591	,	32	,	900	,	1400	)

	BuyGoodsData(0,	4563	,	-1	,	900	,	1000	)
	BuyGoodsData(0,	4580	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4585	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4592	,	-1	,	1000	,	1200	)
	
	-- SaleGoodsData(	1	,	4570	,	560	,	270	,	60	)
	-- SaleGoodsData(	1	,	4571	,	360	,	405	,	90	)
	-- SaleGoodsData(	2	,	4572	,	200	,	432	,	96	)

	-- BuyGoodsData(0,	4577	,	-1	,	1059	,	235	)
	-- BuyGoodsData(0,	4578	,	-1	,	1089	,	243	)
	-- BuyGoodsData(0,	4579	,	-1	,	1049	,	699	)
	-- BuyGoodsData(0,	4583	,	-1	,	740	,	165	)
	-- BuyGoodsData(0,	4584	,	-1	,	866	,	193	)
	-- BuyGoodsData(0,	4589	,	-1	,	537	,	119	)
	-- BuyGoodsData(0,	4591	,	-1	,	807	,	179	)
	-- BuyGoodsData(0,	4592	,	-1	,	909	,	202	)
	-- BuyGoodsData(0,	4597	,	-1	,	986	,	219	)
	-- BuyGoodsData(0,	4599	,	-1	,	1061	,	235	)
	-- BuyGoodsData(0,	4600	,	-1	,	1017	,	678	)
	-- BuyGoodsData(0,	4554	,	-1	,	1106	,	245	)
	-- BuyGoodsData(0,	4557	,	-1	,	1089	,	243	)
	-- BuyGoodsData(0,	4560	,	-1	,	1220	,	271	)
	-- BuyGoodsData(0,	4562	,	-1	,	881	,	195	)
	-- BuyGoodsData(0,	4563	,	-1	,	909	,	202	)
	-- BuyGoodsData(0,	4566	,	-1	,	808	,	179	)
	-- BuyGoodsData(0,	4568	,	-1	,	879	,	195	)
	-- BuyGoodsData(0,	4569	,	-1	,	981	,	218	)


	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()	


	

end

------------------------------------------------------------
-- 雷霆堡军港-----海港指挥·查可夫中尉
------------------------------------------------------------
function r_talk207()

	MISSCRIPT_NPCSCRIPT03_LUA_000102 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000102")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000102 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 2 )
	TriggerAction( 1, LuanchBerthList, 2, 1064, 1324, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 2 )
	TriggerAction( 2, RepairBerthList, 2 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 2 )
	TriggerAction( 2, SupplyBerthList, 2 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 2 )
	TriggerAction( 1, SalvageBerthList, 2 )
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

-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6703 )
end

------------------------------------------------------------
-- 沙岚新城-----交易员·西多夫
------------------------------------------------------------

function r_talk208()

	MISSCRIPT_NPCSCRIPT03_LUA_000103 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000103")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000103 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3 )
	TriggerAction( 1, TradeBerthList, 3 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)

	MISSCRIPT_NPCSCRIPT03_LUA_000104 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000104")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000104 )

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

	InitGoods(3)
	
	SaleGoodsData(	0	,	4559	,	64	,	500	,	1000	)
	SaleGoodsData(	1	,	4560	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4561	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4562	,	32	,	900	,	1400	)


	BuyGoodsData(0,	4555	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4567	,	-1	,	1300	,	1600	)
	BuyGoodsData(0,	4579	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4584	,	-1	,	1000	,	1200	)
	-- SaleGoodsData(	0	,	4581	,	900	,	270	,	60	)
	-- SaleGoodsData(	0	,	4582	,	800	,	319	,	71	)
	-- SaleGoodsData(	1	,	4583	,	700	,	355	,	79	)
	-- SaleGoodsData(	1	,	4584	,	480	,	405	,	90	)
	-- SaleGoodsData(	2	,	4585	,	300	,	450	,	100	)
	-- SaleGoodsData(	2	,	4586	,	240	,	481	,	107	)
	-- SaleGoodsData(	3	,	4587	,	60	,	549	,	122	)
	-- SaleGoodsData(	3	,	4588	,	40	,	639	,	142	)

	-- BuyGoodsData(0,	4573	,	-1	,	560	,	125	)
	-- BuyGoodsData(0,	4575	,	-1	,	798	,	177	)
	-- BuyGoodsData(0,	4577	,	-1	,	930	,	207	)
	-- BuyGoodsData(0,	4589	,	-1	,	548	,	121	)
	-- BuyGoodsData(0,	4591	,	-1	,	844	,	187	)
	-- BuyGoodsData(0,	4593	,	-1	,	972	,	216	)
	-- BuyGoodsData(0,	4595	,	-1	,	900	,	600	)
	-- BuyGoodsData(0,	4598	,	-1	,	954	,	212	)
	-- BuyGoodsData(0,	4599	,	-1	,	988	,	219	)
	-- BuyGoodsData(0,	4552	,	-1	,	655	,	145	)
	-- BuyGoodsData(0,	4553	,	-1	,	807	,	179	)
	-- BuyGoodsData(0,	4557	,	-1	,	1052	,	233	)
	-- BuyGoodsData(0,	4560	,	-1	,	1172	,	261	)
	-- BuyGoodsData(0,	4563	,	-1	,	909	,	202	)
	-- BuyGoodsData(0,	4564	,	-1	,	577	,	129	)
	-- BuyGoodsData(0,	4566	,	-1	,	740	,	165	)
	-- BuyGoodsData(0,	4568	,	-1	,	870	,	193	)
	-- BuyGoodsData(0,	4569	,	-1	,	970	,	215	)
	-- BuyGoodsData(0,	4572	,	-1	,	872	,	193	)
	-- BuyGoodsData(0,	4547	,	-1	,	200	,	0	)
	-- BuyGoodsData(0,	4549	,	-1	,	360	,	0	)
	-- BuyGoodsData(0,	4550	,	-1	,	1000	,	0	)
	-- BuyGoodsData(0,	4551	,	-1	,	20	,	0	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()

	AddNpcMission(	104	)
	AddNpcMission 	(198)
	AddNpcMission 	(199)
	AddNpcMission 	(149)
	AddNpcMission(	105	)
	AddNpcMission(	106	)

end

------------------------------------------------------------
-- 冰狼堡-----交易员·佩鲁诺
------------------------------------------------------------

function r_talk209()

	MISSCRIPT_NPCSCRIPT03_LUA_000105 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000105")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000105 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 4 )
	TriggerAction( 1, TradeBerthList, 4 )
	TriggerFailure( 1, JumpPage, 2 )
	Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 
	Text( 1, "Regarding Obtaining of Commerce Permit",JumpPage, 3)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000106 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000106")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000106 )	

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

	InitGoods(4)
	SaleGoodsData(	0	,	4563	,	64	,	500	,	1000	)
	SaleGoodsData(	1	,	4564	,	64	,	500	,	1000	)
	SaleGoodsData(	2	,	4565	,	32	,	700	,	1200	)
	SaleGoodsData(	3	,	4566	,	32	,	900	,	1400	)
	

	BuyGoodsData(0,	4577	,	-1	,	1000		,	1200	)
	BuyGoodsData(0,	4586	,	-1	,	1600	,	2000	)
	BuyGoodsData(0,	4588	,	-1	,	900		,	1000	)
	BuyGoodsData(0,	4593	,	-1	,	1300	,	1600	)
	
	-- SaleGoodsData(	0	,	4589	,	900	,	161	,	57	)
	-- SaleGoodsData(	0	,	4590	,	800	,	238	,	84	)
	-- SaleGoodsData(	1	,	4591	,	700	,	297	,	105	)
	-- SaleGoodsData(	1	,	4592	,	600	,	425	,	150	)
	-- SaleGoodsData(	2	,	4593	,	400	,	467	,	165	)
	-- SaleGoodsData(	2	,	4594	,	240	,	561	,	198	)
	-- SaleGoodsData(	3	,	4595	,	120	,	612	,	216	)
	-- SaleGoodsData(	1	,	4596	,	80	,	705	,	249	)

	-- BuyGoodsData(0,	4577	,	-1	,	750	,	643	)
	-- BuyGoodsData(0,	4578	,	-1	,	802	,	689	)
	-- BuyGoodsData(0,	4582	,	-1	,	471	,	403	)
	-- BuyGoodsData(0,	4584	,	-1	,	691	,	593	)
	-- BuyGoodsData(0,	4586	,	-1	,	737	,	633	)
	-- BuyGoodsData(0,	4597	,	-1	,	728	,	625	)
	-- BuyGoodsData(0,	4599	,	-1	,	1092	,	936	)
	-- BuyGoodsData(0,	4600	,	-1	,	1139	,	977	)
	-- BuyGoodsData(0,	4554	,	-1	,	844	,	725	)
	-- BuyGoodsData(0,	4557	,	-1	,	892	,	765	)
	-- BuyGoodsData(0,	4560	,	-1	,	992	,	851	)
	-- BuyGoodsData(0,	4561	,	-1	,	627	,	539	)
	-- BuyGoodsData(0,	4562	,	-1	,	649	,	557	)
	-- BuyGoodsData(0,	4563	,	-1	,	735	,	630	)
	-- BuyGoodsData(0,	4566	,	-1	,	569	,	487	)
	-- BuyGoodsData(0,	4568	,	-1	,	710	,	609	)
	-- BuyGoodsData(0,	4569	,	-1	,	761	,	653	)
	-- BuyGoodsData(0,	4571	,	-1	,	596	,	511	)
	-- BuyGoodsData(0,	4547	,	-1	,	300	,	0	)
	-- BuyGoodsData(0,	4550	,	-1	,	1000	,	0	)
	-- BuyGoodsData(0,	4548	,	-1	,	300	,	0	)
	-- BuyGoodsData(0,	4551	,	-1	,	20	,	0	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 10, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()


end

------------------------------------------------------------
-- 雷霆堡军港-----船工·阿憨
------------------------------------------------------------
function r_talk210 ()
		
	MISSCRIPT_NPCSCRIPT03_LUA_000107 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000107")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000107 )
	InitTrigger()
	TriggerCondition( 1, IsBoatFull )
	MISSCRIPT_NPCSCRIPT03_LUA_000015 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000015")
	TriggerAction( 1, SystemNotice, MISSCRIPT_NPCSCRIPT03_LUA_000015 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001185")
	Text( 1, MISSCRIPT_MISSIONSCRIPT05_LUA_001185, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 2 )
	TriggerAction( 1, BoatLevelBerthList, 2 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000016 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000016")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000016, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000108 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000108")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000108 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 3 )
	TriggerAction( 1, CreateBoat, 3, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000037 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000037")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000037, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 4 )
	TriggerAction( 1, CreateBoat, 4, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000021 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000021")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000021, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 6 )
	TriggerAction( 1, CreateBoat, 6, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000020 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000020")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000020, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 11 )
	TriggerAction( 1, CreateBoat, 11, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000109 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000109")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000109, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 12 )
	TriggerAction( 1, CreateBoat, 12, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000110 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000110")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000110, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, BoatBuildCheck, 13 )
	TriggerAction( 1, CreateBoat, 13, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000111 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000111")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000111, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000112 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000112")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000112 )
end 

------------------------------------------------------------
-- 白银城-----海盗情报员·戈瓦撒
------------------------------------------------------------

function r_talk211()

	MISSCRIPT_NPCSCRIPT03_LUA_000113 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000113")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000113 )
	InitTrigger()
	TriggerCondition( 1, IsGuildType, 1 )
	TriggerAction( 1, ListAllGuild, 1 )
	TriggerCondition( 2, IsGuildType, 0 )
	TriggerAction( 2, JumpPage, 2 )
	TriggerCondition( 3, NoGuild )
	TriggerAction( 3, ListAllGuild, 1 )
	TriggerFailure( 3, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000114 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000114")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000114, MultiTrigger, GetMultiTrigger(), 3)
	MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000005, CloseTalk)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000115 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000115")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000115 )

	MISSCRIPT_NPCSCRIPT03_LUA_000116 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000116")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000116 )

end

------------------------------------------------------------
-- 白银城-----海军情报员·达隆丹
------------------------------------------------------------

function r_talk212()

	MISSCRIPT_NPCSCRIPT03_LUA_000117 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000117")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000117 )
	InitTrigger()
	TriggerCondition( 1, IsGuildType, 0 )
	TriggerAction( 1, ListAllGuild, 0 )
	TriggerCondition( 2, IsGuildType, 1 )
	TriggerAction( 2, JumpPage, 3 )
	TriggerCondition( 3, NoGuild )
	TriggerCondition( 3, HasItem, 4110, 1 )
	TriggerAction( 3, TakeItem, 4110, 1 )
	TriggerAction( 3, ListAllGuild, 0 )
	TriggerFailure( 3, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000118 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000118")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000118, MultiTrigger, GetMultiTrigger(), 3)
	MISSCRIPT_NPCSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000005")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000005, CloseTalk)
	
	MISSCRIPT_NPCSCRIPT03_LUA_000119 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000119")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000119 )

	MISSCRIPT_NPCSCRIPT03_LUA_000120 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000120")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000120 )
		
end

------------------------------------------------------------
-- 白银城-----海军募兵小姐·蕾绮尔
------------------------------------------------------------

function r_talk213()

	MISSCRIPT_NPCSCRIPT03_LUA_000121 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000121")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000121 )
	InitTrigger()
	TriggerCondition( 1, HasItem, 4110, 1 )
	TriggerAction( 1, JumpPage, 2 )
	TriggerCondition( 2, IsGuildType, 0 )
	TriggerAction( 2, JumpPage, 4 )
	TriggerCondition( 3, IsGuildType, 1 )
	TriggerAction( 3, JumpPage, 5 )
	TriggerCondition( 4, HasLeaveBagGrid, 1 )
	TriggerCondition( 4, NoGuild )
	TriggerAction( 4, GiveItem, 4110, 1, 4 )
	TriggerFailure( 4, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000122 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000122")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000122,MultiTrigger, GetMultiTrigger(), 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000123 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000123")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000123, CloseTalk)

	MISSCRIPT_NPCSCRIPT03_LUA_000124 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000124")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000124 )

	MISSCRIPT_NPCSCRIPT03_LUA_000125 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000125")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000125 )

	MISSCRIPT_NPCSCRIPT03_LUA_000126 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000126")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000126 )

	MISSCRIPT_NPCSCRIPT03_LUA_000127 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000127")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000127 )

		
end

------------------------------------------------------------
-- 废矿补给站-----打包人·乎勒达
------------------------------------------------------------

function r_talk214()

	MISSCRIPT_NPCSCRIPT03_LUA_000128 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000128")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000128 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 1)
	TriggerAction( 1, PackBagList, 1, RES_MINE, 3 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000129 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000129")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000129, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000130 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000130")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000130 )
	----------打包人·乎勒达-------双子-------------03
	AddNpcMission	(5720)
	AddNpcMission	(5721)	
end

------------------------------------------------------------
-- 雷霆堡军港-----打包人·费德索拉
------------------------------------------------------------

function r_talk215()

	MISSCRIPT_NPCSCRIPT03_LUA_000131 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000131")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000131 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 2)
	TriggerAction( 1, PackBagList, 2, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000133 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000133")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000133 )
		
end

------------------------------------------------------------
-- 白银林区-----打包人·摩根
------------------------------------------------------------

function r_talk216()

	MISSCRIPT_NPCSCRIPT03_LUA_000134 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000134")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000134 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 1)
	TriggerAction( 1, PackBagList, 1, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000135 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000135")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000135 )

	AddNpcMission(	1436	)
	AddNpcMission (	1930	)
		
end

------------------------------------------------------------
-- 冰雪岛-----打包人·阿里西斯
------------------------------------------------------------

function r_talk217()

	MISSCRIPT_NPCSCRIPT03_LUA_000136 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000136")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000136 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 8)
	TriggerAction( 1, PackBagList, 8, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000137 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000137")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000137 )
		
end

------------------------------------------------------------
-- 鸣沙岛-----打包人·伊加卡班
------------------------------------------------------------

function r_talk218()

	MISSCRIPT_NPCSCRIPT03_LUA_000138 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000138")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000138 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 9)
	TriggerAction( 1, PackBagList, 9, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000139 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000139")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000139 )
		
end

------------------------------------------------------------
-- 沙岚新城-----打包人·安巴瓦而
------------------------------------------------------------

function r_talk219()

	MISSCRIPT_NPCSCRIPT03_LUA_000140 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000140")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000140 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3)
	TriggerAction( 1, PackBagList, 3, RES_MINE, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000141 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000141")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000141, MultiTrigger, GetMultiTrigger(), 1 )
	
	MISSCRIPT_NPCSCRIPT03_LUA_000142 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000142")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000142 )
		
end

------------------------------------------------------------
-- 阿兰比斯补给站-----打包人·阿加赖得
------------------------------------------------------------

function r_talk220()

	MISSCRIPT_NPCSCRIPT03_LUA_000143 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000143")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000143 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 4)
	TriggerAction( 1, PackBagList, 4, RES_MINE, 2 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000144 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000144")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000144, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 4)
	TriggerAction( 1, PackBagList, 4, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000145 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000145")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000145 )

	AddNpcMission(	1581	)
	AddNpcMission (	1933	)

	
end


------------------------------------------------------------
-- 卡尔加德雪原-----打包人·坎贝尔
------------------------------------------------------------

function r_talk243()

	MISSCRIPT_NPCSCRIPT03_LUA_000146 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000146")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000146 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 2)
	TriggerAction( 1, PackBagList, 2, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000147 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000147")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000147 )
		
end

------------------------------------------------------------
-- 德尔维平原-----打包人·索拉斯
------------------------------------------------------------

function r_talk244()

	MISSCRIPT_NPCSCRIPT03_LUA_000148 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000148")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000148 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 1)
	TriggerAction( 1, PackBagList, 1, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000149 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000149")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000149 )

end



------------------------------------------------------------
-- 帕克荒漠-----打包人·安塞拉
------------------------------------------------------------

function r_talk245()

	MISSCRIPT_NPCSCRIPT03_LUA_000150 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000150")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000150 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3)
	TriggerAction( 1, PackBagList, 3, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000151 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000151")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000151 )
		
end


------------------------------------------------------------
-- 冰极-----打包人·阿加西
------------------------------------------------------------

function r_talk246()

	MISSCRIPT_NPCSCRIPT03_LUA_000152 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000152")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000152 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 4)
	TriggerAction( 1, PackBagList, 4, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000153 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000153")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000153 )
	
end

------------------------------------------------------------
-- 迷之港口-----港口指挥◎迷
------------------------------------------------------------
function r_talk247()

	MISSCRIPT_NPCSCRIPT03_LUA_000154 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000154")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000154 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 1341, 3257, 0 )
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
	MISSCRIPT_NPCSCRIPT03_LUA_000155 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000155")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000155 )
	MISSCRIPT_NPCSCRIPT03_LUA_000156 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000156")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000156 )
	MISSCRIPT_NPCSCRIPT03_LUA_000157 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000157")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000157 )

end

------------------------------------------------------------
-- 迷之港口-----小花园北部商店海港指挥
------------------------------------------------------------
function r_talk248()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 116, 51, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	
	

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	

end

------------------------------------------------------------
-- 迷之港口-----小花园北部中央海港指挥
------------------------------------------------------------
function r_talk249()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 235, 123, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	

end


------------------------------------------------------------
-- 迷之港口-----小花园东部海港指挥
------------------------------------------------------------
function r_talk250()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 248, 352, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	

end

------------------------------------------------------------
-- 迷之港口-----小花园南部商店海港指挥
------------------------------------------------------------
function r_talk251()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 353, 428, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )


end

------------------------------------------------------------
-- 迷之港口-----小花园北部下海海港指挥
------------------------------------------------------------
function r_talk257()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 231,211, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )


end

------------------------------------------------------------
-- 迷之港口-----小花园南部下海海港指挥
------------------------------------------------------------
function r_talk258()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 231,256, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )


end


------------------------------------------------------------
-- 迷之港口-----阴暗沼泽海港指挥
------------------------------------------------------------
function r_talk261()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 295, 352, 0 )
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
	MISSCRIPT_NPCSCRIPT03_LUA_000155 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000155")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000155 )
	MISSCRIPT_NPCSCRIPT03_LUA_000156 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000156")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000156 )
	MISSCRIPT_NPCSCRIPT03_LUA_000157 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000157")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000157 )

end

------------------------------------------------------------
-- 迷之港口-----废灵之都海港指挥
------------------------------------------------------------
function r_talk262()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 299, 321, 0 )
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
	MISSCRIPT_NPCSCRIPT03_LUA_000155 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000155")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000155 )
	MISSCRIPT_NPCSCRIPT03_LUA_000156 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000156")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000156 )
	MISSCRIPT_NPCSCRIPT03_LUA_000157 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000157")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000157 )

end

----------------------------------------------------------
--							--
--							--
--		竞技花园[神秘商人]			--
--							--
--		225538,280188				--
----------------------------------------------------------
-----------------------------------------------------------这里开始P话聊天
function r_talk259 ()
	
	
	MISSCRIPT_NPCSCRIPT03_LUA_000159 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000159")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000159 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 12 )
	TriggerAction( 1, TradeBerthList, 12 )
	TriggerFailure( 1, JumpPage, 2 )
	--Text( 1, "交易", MultiTrigger, GetMultiTrigger(), 1 )

	
	MISSCRIPT_NPCSCRIPT03_LUA_000160 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000160")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000160 )
	
	InitGoods(12)
	SaleGoodsData(	0	,	1861	,	500	,	5000	,	5000	)

	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 52, TE_GAMETIME, TT_CYCLETIME, 15, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()

	AddNpcMission 	(443)
	AddNpcMission 	(445)
	AddNpcMission 	(447)
	AddNpcMission	(1020)
	AddNpcMission	(1076)
	AddNpcMission	(1132)
	AddNpcMission	(1183)
	AddNpcMission(	1226	)
	
end 



------------------------------------------------------------
-- 小花园-----药草商人
------------------------------------------------------------

function r_talk260()

	MISSCRIPT_NPCSCRIPT03_LUA_000161 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000161")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000161 )
	MISSCRIPT_NPCSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000002")
	Text( 1, MISSCRIPT_NPCSCRIPT01_LUA_000002, BuyPage )
	MISSCRIPT_NPCSCRIPT03_LUA_000162 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000162")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000162,CloseTalk )

	InitTrade()
	Other(	3460	)
	Other(	3461	)

end

------------------------------------------------------------
-- 沙岚新城-----神秘海港指挥
------------------------------------------------------------
function r_talk263()

	MISSCRIPT_NPCSCRIPT03_LUA_000163 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000163")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000163 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 12 )
	TriggerAction( 1, LuanchBerthList, 12, 832, 3698, 0 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, RepairBerthList, 12 )
	TriggerFailure( 2, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 12 )
	TriggerAction( 2, SupplyBerthList, 12 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 12 )
	TriggerAction( 1, SalvageBerthList, 12 )
	TriggerFailure( 1, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000155 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000155")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000155 )
	MISSCRIPT_NPCSCRIPT03_LUA_000156 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000156")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000156 )
	MISSCRIPT_NPCSCRIPT03_LUA_000157 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000157")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000157 )

end

----------------------------------------------------
--擂主公会特殊贸易品
----------------------------------------------------
--军火商


function r_talk264()
	MISSCRIPT_NPCSCRIPT03_LUA_000164 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000164")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000164 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3 )
	TriggerCondition( 1, HasGuildLevel, 1 )
	TriggerAction( 1, TradeBerthList, 3 )
	TriggerFailure( 1, JumpPage, 2 )
	--Text( 1, "购买", MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000165 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000165")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000165 )

	InitGoods(3)
	SaleGoodsData(	0	,	3914	,	150	,	990	,	220	)
	
	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 30, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()



end

--精密仪器供应商	

function r_talk265()
	MISSCRIPT_NPCSCRIPT03_LUA_000166 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000166")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000166 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3 )
	TriggerCondition( 1, HasGuildLevel, 2 )
	TriggerAction( 1, TradeBerthList, 3 )
	TriggerFailure( 1, JumpPage, 2 )
	--Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000167 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000167")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000167 )


	InitGoods(3)
	SaleGoodsData(	0	,	3912	,	200	,	855	,	190	)
	


	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 30, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()



end


--稀有金属供应商

function r_talk266()
	MISSCRIPT_NPCSCRIPT03_LUA_000168 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000168")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000168 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3 )
	TriggerCondition( 1, HasGuildLevel, 3 )
	TriggerAction( 1, TradeBerthList, 3 )
	TriggerFailure( 1, JumpPage, 2 )
	--Text( 1, "Goods Trade", MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000169 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000169")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000169 )


	InitGoods(3)
	SaleGoodsData(	0	,	3913	,	250	,	765	,	170	)
	
	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 51, TE_GAMETIME, TT_CYCLETIME, 30, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()



end



------------------------------------------------------------
-- 沙岚新城-----打包人·阿里七七
------------------------------------------------------------

function m_talk001()

	MISSCRIPT_NPCSCRIPT03_LUA_000170 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000170")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000170 )
	InitTrigger()
	TriggerCondition( 1, HasBoatInBerth, 3)
	TriggerAction( 1, PackBagList, 3, RES_WOOD, 1 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000132 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000132")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000132, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000171 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000171")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000171 )
	
------2.0历史任务-------
	AddNpcMission ( 6305 )
	AddNpcMission ( 6306 )
		
end


------------------------------------------------------------
-- 夏岛北港-----海港指挥·夏青
------------------------------------------------------------
function b_talk19()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 14 )
	TriggerAction( 1, LuanchBerthList, 14, 3662, 2645, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 14 )
	TriggerAction( 2, RepairBerthList, 14 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 14 )
	TriggerAction( 2, SupplyBerthList, 14 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 14 )
	TriggerAction( 1, SalvageBerthList, 14 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000172 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000172")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000172 )
	MISSCRIPT_NPCSCRIPT03_LUA_000173 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000173")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000173 )
	MISSCRIPT_NPCSCRIPT03_LUA_000174 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000174")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000174 )


	------------- 海港指挥·夏青-------巨蟹
	AddNpcMission	(5853)
	AddNpcMission	(5854)
	-----------2.0冬岛日常任务-----------
	AddNpcMission ( 6705 )

end


------------------------------------------------------------
-- 夏岛南港-----海港指挥·夏云
------------------------------------------------------------
function b_talk20()

	MISSCRIPT_NPCSCRIPT03_LUA_000158 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000158")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000158 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 15 )
	TriggerAction( 1, LuanchBerthList, 15, 3324, 3541, 0 )
	TriggerFailure( 1, JumpPage, 3 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, RepairBoat )
	TriggerCondition( 2, HasBoatInBerth, 15 )
	TriggerAction( 2, RepairBerthList, 15 )
	TriggerFailure( 2, JumpPage, 4 )
	MISSCRIPT_NPCSCRIPT03_LUA_000044 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000044")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000044, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasLuanchOut )
	TriggerAction( 1, SupplyBoat )
	TriggerCondition( 2, HasBoatInBerth, 15 )
	TriggerAction( 2, SupplyBerthList, 15 )
	TriggerFailure( 2, JumpPage, 5 )
	MISSCRIPT_NPCSCRIPT03_LUA_000045 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000045")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000045, MultiTrigger, GetMultiTrigger(), 2 ) 
	InitTrigger()
	TriggerCondition( 1, HasDeadBoatInBerth, 15 )
	TriggerAction( 1, SalvageBerthList, 15 )
	TriggerFailure( 1, JumpPage, 6 )
	MISSCRIPT_NPCSCRIPT03_LUA_000046 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000046")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000046, MultiTrigger, GetMultiTrigger(), 1 ) 

	MISSCRIPT_NPCSCRIPT03_LUA_000047 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000047")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000047 )
	MISSCRIPT_NPCSCRIPT03_LUA_000175 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000175")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000175 )
	MISSCRIPT_NPCSCRIPT03_LUA_000176 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000176")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000176 )
	MISSCRIPT_NPCSCRIPT03_LUA_000177 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000177")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000177 )

	------------- 海港指挥·夏云-------巨蟹
	AddNpcMission	(5855)
	AddNpcMission	(5856)


end

-----------黑市商人
function leo_talk10()	

	MISSCRIPT_NPCSCRIPT03_LUA_000178 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000178")
	Talk(1, MISSCRIPT_NPCSCRIPT03_LUA_000178)
	-- Text( 1, "听说你这里有东西可换？", JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000179 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000179")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000179, BuyPage)
	

	MISSCRIPT_NPCSCRIPT03_LUA_000180 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000180")
	Talk(2,MISSCRIPT_NPCSCRIPT03_LUA_000180)
	MISSCRIPT_NPCSCRIPT03_LUA_000181 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000181")
	Text(2,MISSCRIPT_NPCSCRIPT03_LUA_000181, SendExchangeData )

	--兑换所需物品 ID，数量，兑换所得物品数量，赋予的值
	InitExchange()

	--加载8个道具信息，在ScriptSDK里


	
	DoExchange()

	InitTrade()
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	Other(	rand()	)
	
	InitTrigger()
	TriggerAction( 1, AddNpcTrigger, 53, TE_GAMETIME, TT_CYCLETIME, 240, 0 )
	SetNpcTrigger( GetTrigger( 1 ) )
	SetNpcActive()
end

function rand()	--黑市随机装备列表
	local tabunknow = {}
	tabunknow[	1	] =	0088
	tabunknow[	2	] =	0089
	tabunknow[	3	] =	3302
	tabunknow[	4	] =	3303
	tabunknow[	5	] =	3304
	tabunknow[	6	] =	3305
	tabunknow[	7	] =	3306
	tabunknow[	8	] =	3307
	tabunknow[	9	] =	3308
	tabunknow[	10	] =	3309
	tabunknow[	11	] =	3310
	tabunknow[	12	] =	3311
	tabunknow[	13	] =	3312
	tabunknow[	14	] =	3313
	tabunknow[	15	] =	3314
	tabunknow[	16	] =	3315
	tabunknow[	17	] =	3316
	tabunknow[	18	] =	3317
	tabunknow[	19	] =	3318
	tabunknow[	20	] =	3319
	tabunknow[	21	] =	3320
	tabunknow[	22	] =	3321
	tabunknow[	23	] =	3322
	tabunknow[	24	] =	3323
	tabunknow[	25	] =	3324
	tabunknow[	26	] =	3325
	tabunknow[	27	] =	3326
	tabunknow[	28	] =	3327
	tabunknow[	29	] =	3328
	tabunknow[	30	] =	3329
	tabunknow[	31	] =	3330
	tabunknow[	32	] =	3331
	tabunknow[	33	] =	3332
	tabunknow[	34	] =	3333
	tabunknow[	35	] =	3334

	return tabunknow[math.floor(math.random(1,35))]
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零零
------------------------------------------------------------
function star_talk001()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 148 , 154, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零一
------------------------------------------------------------
function star_talk002()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 169 , 176, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零二
------------------------------------------------------------
function star_talk003()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 168 , 111, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零三
------------------------------------------------------------
function star_talk004()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 452 , 135, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零四
------------------------------------------------------------
function star_talk005()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 496 , 164, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零五
------------------------------------------------------------
function star_talk006()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 453 , 175, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零六
------------------------------------------------------------
function star_talk007()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3 , 262 , 181, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·零零七
------------------------------------------------------------
function star_talk008()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 348 , 175, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺零
------------------------------------------------------------
function star_talk009()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 110 , 460, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end

------------------------------------------------------------
-- 圣战-----海港指挥·幺幺一
------------------------------------------------------------
function star_talk010()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 169 , 493, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺二
------------------------------------------------------------
function star_talk011()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 82 , 456, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺三
------------------------------------------------------------
function star_talk012()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 463 , 453, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺四
------------------------------------------------------------
function star_talk013()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 492 , 460, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺五
------------------------------------------------------------
function star_talk014()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 453 , 506, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺六
------------------------------------------------------------
function star_talk015()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 357 , 450, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end
------------------------------------------------------------
-- 圣战-----海港指挥·幺幺七
------------------------------------------------------------
function star_talk016()
	MISSCRIPT_NPCSCRIPT03_LUA_000182 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000182")
	Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000182 )
	InitTrigger()
	TriggerCondition( 1, HasAllBoatInBerth, 3 )
	TriggerAction( 1, LuanchBerthList, 3, 256 , 450, 180 )
	TriggerFailure( 1, JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000043 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000043")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000043, MultiTrigger, GetMultiTrigger(), 1 )

	MISSCRIPT_NPCSCRIPT03_LUA_000183 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000183")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000183 )
end


------------------------------------------------------------
-- 圣战----海军前线指挥官--Roico
------------------------------------------------------------
function roico_talk001()
  MISSCRIPT_NPCSCRIPT03_LUA_000184 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000184")
  Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000184 )
  MISSCRIPT_NPCSCRIPT03_LUA_000185 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000185")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000185 ,JumpPage, 2)
  --Text( 1, "设置圣战复活点", SetSpawnPos, "圣战")
  MISSCRIPT_NPCSCRIPT03_LUA_000186 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000186")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000186, JumpPage, 3)
  MISSCRIPT_NPCSCRIPT03_LUA_000187 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000187")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000187, JumpPage, 4)
  MISSCRIPT_NPCSCRIPT03_LUA_000188 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000188")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000188, JumpPage, 13)
  --Text( 1, "继续战斗", JumpPage, 5)
  MISSCRIPT_NPCSCRIPT03_LUA_000189 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000189")
  Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000189)
  MISSCRIPT_NPCSCRIPT03_LUA_000190 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000190")
  Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000190)
  MISSCRIPT_NPCSCRIPT03_LUA_000191 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000191")
  Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000191 ,JumpPage, 6)
  MISSCRIPT_NPCSCRIPT03_LUA_000192 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000192")
  Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000192 ,JumpPage, 7)
  MISSCRIPT_NPCSCRIPT03_LUA_000193 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000193")
  Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000193)
  MISSCRIPT_NPCSCRIPT03_LUA_000194 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000194")
  Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000194 ,JumpPage, 8)
  MISSCRIPT_NPCSCRIPT03_LUA_000195 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000195")
  Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000195 ,JumpPage, 9)
  MISSCRIPT_NPCSCRIPT03_LUA_000196 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000196")
  Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000196 ,JumpPage, 10)





 InitTrigger()
	TriggerCondition( 1, HasItem, 2859, 25 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerAction( 1, TakeItem, 2859,25 )
	TriggerAction( 1, GiveItem, 2986, 1 , 4)
	TriggerAction( 1, JumpPage, 11 )
	TriggerFailure( 1, JumpPage, 12)
	MISSCRIPT_NPCSCRIPT03_LUA_000197 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000197")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000197)
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 6, MISSCRIPT_NPCSCRIPT01_LUA_000200,  MultiTrigger, GetMultiTrigger(), 1)
        MISSCRIPT_NPCSCRIPT03_LUA_000198 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000198")
        Talk(11, MISSCRIPT_NPCSCRIPT03_LUA_000198 )
	MISSCRIPT_NPCSCRIPT03_LUA_000199 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000199")
	Talk( 12, MISSCRIPT_NPCSCRIPT03_LUA_000199)

-- InitTrigger()
--	TriggerCondition( 1, HasItem, 3117, 20 )
--	TriggerAction( 1, TakeItem, 3117,20 )
--	TriggerAction( 1, GetChaName1_guildwar, 1 )
--	TriggerAction( 1, JumpPage, 13 )
--	TriggerFailure( 1, JumpPage, 14)
	MISSCRIPT_NPCSCRIPT03_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000200")
	Talk( 7, MISSCRIPT_NPCSCRIPT03_LUA_000200)
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 7, MISSCRIPT_NPCSCRIPT01_LUA_000200, GetChaName1_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000201 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000201")
	Talk( 8, MISSCRIPT_NPCSCRIPT03_LUA_000201)
	MISSCRIPT_NPCSCRIPT03_LUA_000202 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000202")
	Text( 8, MISSCRIPT_NPCSCRIPT03_LUA_000202, GetChaName2_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000203 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000203")
	Talk( 9, MISSCRIPT_NPCSCRIPT03_LUA_000203)
	MISSCRIPT_NPCSCRIPT03_LUA_000204 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000204")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000204, GetChaName4_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000205 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000205")
	Talk( 10, MISSCRIPT_NPCSCRIPT03_LUA_000205)
	MISSCRIPT_NPCSCRIPT03_LUA_000204 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000204")
	Text( 10, MISSCRIPT_NPCSCRIPT03_LUA_000204, GetChaName3_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000206 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000206")
	Talk( 13, MISSCRIPT_NPCSCRIPT03_LUA_000206)
	MISSCRIPT_NPCSCRIPT03_LUA_000207 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000207")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000207, JumpPage, 14)
	MISSCRIPT_NPCSCRIPT03_LUA_000208 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000208")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000208, JumpPage, 15)
	MISSCRIPT_NPCSCRIPT03_LUA_000209 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000209")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000209, JumpPage, 16)
	MISSCRIPT_NPCSCRIPT03_LUA_000210 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000210")
	Talk( 14, MISSCRIPT_NPCSCRIPT03_LUA_000210)
	MISSCRIPT_NPCSCRIPT03_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000211")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000211, GetChaName5_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000212")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000212, GetChaName6_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000213")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000213, GetChaName7_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000214")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000214, GetChaName8_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000215")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000215, GetChaName9_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000216")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000216, GetChaName10_guildwar, 1)
	--Text( 14, "战场中路", GetChaName11_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000217 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000217")
	Talk( 15, MISSCRIPT_NPCSCRIPT03_LUA_000217)
	MISSCRIPT_NPCSCRIPT03_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000211")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000211, GetChaName11_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000212")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000212, GetChaName12_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000213")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000213, GetChaName13_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000214")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000214, GetChaName14_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000215")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000215, GetChaName15_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000216")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000216, GetChaName16_guildwar, 1)
	--Text( 15, "战场中路", GetChaName18_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000218 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000218")
	Talk( 16, MISSCRIPT_NPCSCRIPT03_LUA_000218)
	MISSCRIPT_NPCSCRIPT03_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000211")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000211, GetChaName17_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000212")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000212, GetChaName18_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000213")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000213, GetChaName19_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000214")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000214, GetChaName20_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000215")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000215, GetChaName21_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000216")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000216, GetChaName22_guildwar, 1)

end
------------------------------------------------------------
-- 圣战----海盗前线指挥官--Roico
------------------------------------------------------------
function roico_talk002()
MISSCRIPT_NPCSCRIPT03_LUA_000219 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000219")
Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000219 )
  MISSCRIPT_NPCSCRIPT03_LUA_000185 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000185")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000185 ,JumpPage, 2)
  --Text( 1, "设置圣战复活点", SetSpawnPos, "圣战")
  MISSCRIPT_NPCSCRIPT03_LUA_000186 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000186")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000186, JumpPage, 3)
  MISSCRIPT_NPCSCRIPT03_LUA_000187 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000187")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000187, JumpPage, 4)
  MISSCRIPT_NPCSCRIPT03_LUA_000220 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000220")
  Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000220, JumpPage, 13)
  --Text( 1, "继续战斗", JumpPage, 5)
  MISSCRIPT_NPCSCRIPT03_LUA_000221 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000221")
  Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000221)
  MISSCRIPT_NPCSCRIPT03_LUA_000222 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000222")
  Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000222)
  MISSCRIPT_NPCSCRIPT03_LUA_000191 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000191")
  Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000191 ,JumpPage, 6)
  MISSCRIPT_NPCSCRIPT03_LUA_000192 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000192")
  Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000192 ,JumpPage, 7)
  MISSCRIPT_NPCSCRIPT03_LUA_000223 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000223")
  Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000223)
  MISSCRIPT_NPCSCRIPT03_LUA_000194 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000194")
  Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000194 ,JumpPage, 8)
  MISSCRIPT_NPCSCRIPT03_LUA_000195 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000195")
  Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000195 ,JumpPage, 9)
  MISSCRIPT_NPCSCRIPT03_LUA_000196 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000196")
  Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000196 ,JumpPage, 10)





 InitTrigger()
	TriggerCondition( 1, HasItem, 2858, 25 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerAction( 1, TakeItem, 2858,25 )
	TriggerAction( 1, GiveItem, 2986, 1 , 4)
	TriggerAction( 1, JumpPage, 11 )
	TriggerFailure( 1, JumpPage, 12)
	MISSCRIPT_NPCSCRIPT03_LUA_000224 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000224")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000224)
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 6, MISSCRIPT_NPCSCRIPT01_LUA_000200,  MultiTrigger, GetMultiTrigger(), 1)
        MISSCRIPT_NPCSCRIPT03_LUA_000225 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000225")
        Talk(11, MISSCRIPT_NPCSCRIPT03_LUA_000225 )
	MISSCRIPT_NPCSCRIPT03_LUA_000226 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000226")
	Talk( 12, MISSCRIPT_NPCSCRIPT03_LUA_000226)

-- InitTrigger()
--	TriggerCondition( 1, HasItem, 3117, 20 )
--	TriggerAction( 1, TakeItem, 3117,20 )
--	TriggerAction( 1, GetChaName1_guildwar, 1 )
--	TriggerAction( 1, JumpPage, 13 )
--	TriggerFailure( 1, JumpPage, 14)
	MISSCRIPT_NPCSCRIPT03_LUA_000227 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000227")
	Talk( 7, MISSCRIPT_NPCSCRIPT03_LUA_000227)
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 7, MISSCRIPT_NPCSCRIPT01_LUA_000200, GetChaName23_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000228 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000228")
	Talk( 8, MISSCRIPT_NPCSCRIPT03_LUA_000228)
	MISSCRIPT_NPCSCRIPT03_LUA_000202 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000202")
	Text( 8, MISSCRIPT_NPCSCRIPT03_LUA_000202, GetChaName24_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000229 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000229")
	Talk( 9, MISSCRIPT_NPCSCRIPT03_LUA_000229)
	MISSCRIPT_NPCSCRIPT03_LUA_000204 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000204")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000204, GetChaName26_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000230 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000230")
	Talk( 10, MISSCRIPT_NPCSCRIPT03_LUA_000230)
	MISSCRIPT_NPCSCRIPT03_LUA_000204 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000204")
	Text( 10, MISSCRIPT_NPCSCRIPT03_LUA_000204, GetChaName25_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000231 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000231")
	Talk( 13, MISSCRIPT_NPCSCRIPT03_LUA_000231)
	MISSCRIPT_NPCSCRIPT03_LUA_000207 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000207")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000207, JumpPage, 14)
	MISSCRIPT_NPCSCRIPT03_LUA_000208 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000208")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000208, JumpPage, 15)
	MISSCRIPT_NPCSCRIPT03_LUA_000209 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000209")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000209, JumpPage, 16)
	MISSCRIPT_NPCSCRIPT03_LUA_000232 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000232")
	Talk( 14, MISSCRIPT_NPCSCRIPT03_LUA_000232)
	MISSCRIPT_NPCSCRIPT03_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000211")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000211, GetChaName27_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000212")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000212, GetChaName28_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000213")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000213, GetChaName29_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000214")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000214, GetChaName30_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000215")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000215, GetChaName31_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000216")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000216, GetChaName32_guildwar, 1)
	--Text( 14, "战场中路", GetChaName11_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000233 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000233")
	Talk( 15, MISSCRIPT_NPCSCRIPT03_LUA_000233)
	MISSCRIPT_NPCSCRIPT03_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000211")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000211, GetChaName33_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000212")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000212, GetChaName34_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000213")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000213, GetChaName35_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000214")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000214, GetChaName36_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000215")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000215, GetChaName37_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000216")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000216, GetChaName38_guildwar, 1)
	--Text( 15, "战场中路", GetChaName18_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000234 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000234")
	Talk( 16, MISSCRIPT_NPCSCRIPT03_LUA_000234)
	MISSCRIPT_NPCSCRIPT03_LUA_000211 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000211")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000211, GetChaName39_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000212 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000212")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000212, GetChaName40_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000213 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000213")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000213, GetChaName41_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000214 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000214")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000214, GetChaName42_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000215 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000215")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000215, GetChaName43_guildwar, 1)
	MISSCRIPT_NPCSCRIPT03_LUA_000216 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000216")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000216, GetChaName44_guildwar, 1)
end

function roico_talk()
        MISSCRIPT_NPCSCRIPT03_LUA_000235 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000235")
        Talk( 1, MISSCRIPT_NPCSCRIPT03_LUA_000235 )
        MISSCRIPT_NPCSCRIPT03_LUA_000236 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000236")
        Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000236,JumpPage, 2 )
	MISSCRIPT_NPCSCRIPT03_LUA_000237 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000237")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000237,JumpPage, 16 )
	MISSCRIPT_NPCSCRIPT03_LUA_000238 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000238")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000238,JumpPage, 28 )
	MISSCRIPT_NPCSCRIPT03_LUA_000239 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000239")
	Text( 1, MISSCRIPT_NPCSCRIPT03_LUA_000239,JumpPage, 29 )

	MISSCRIPT_NPCSCRIPT03_LUA_000240 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000240")
	Talk( 2, MISSCRIPT_NPCSCRIPT03_LUA_000240 )
        MISSCRIPT_NPCSCRIPT03_LUA_000241 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000241")
        Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000241, JumpPage, 3)
	MISSCRIPT_NPCSCRIPT03_LUA_000242 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000242")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000242, JumpPage, 4)
	MISSCRIPT_NPCSCRIPT03_LUA_000243 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000243")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000243, JumpPage, 5)
	MISSCRIPT_NPCSCRIPT03_LUA_000244 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000244")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000244, JumpPage, 6)
	MISSCRIPT_NPCSCRIPT03_LUA_000245 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000245")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000245, JumpPage, 7)
	MISSCRIPT_NPCSCRIPT03_LUA_000246 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000246")
	Text( 2, MISSCRIPT_NPCSCRIPT03_LUA_000246, JumpPage, 8)
	MISSCRIPT_NPCSCRIPT01_LUA_000520 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000520")
	Text( 2, MISSCRIPT_NPCSCRIPT01_LUA_000520, JumpPage, 9)
	MISSCRIPT_NPCSCRIPT03_LUA_000240 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000240")
	Talk( 9, MISSCRIPT_NPCSCRIPT03_LUA_000240 )
	MISSCRIPT_NPCSCRIPT03_LUA_000247 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000247")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000247, JumpPage, 10)
	MISSCRIPT_NPCSCRIPT03_LUA_000248 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000248")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000248, JumpPage, 11)
	MISSCRIPT_NPCSCRIPT03_LUA_000249 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000249")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000249, JumpPage, 12)
	MISSCRIPT_NPCSCRIPT03_LUA_000250 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000250")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000250, JumpPage, 13)
	MISSCRIPT_NPCSCRIPT03_LUA_000251 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000251")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000251, JumpPage, 14)
	MISSCRIPT_NPCSCRIPT03_LUA_000252 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000252")
	Text( 9, MISSCRIPT_NPCSCRIPT03_LUA_000252, JumpPage, 15)
	MISSCRIPT_NPCSCRIPT01_LUA_000521 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000521")
	Text( 9, MISSCRIPT_NPCSCRIPT01_LUA_000521, JumpPage, 2) 


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2532, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 3, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000254 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000254")
	Text( 3, MISSCRIPT_NPCSCRIPT03_LUA_000254, MultiTrigger, GetMultiTrigger(), 1)



	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2535, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 4, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000255 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000255")
	Text( 4, MISSCRIPT_NPCSCRIPT03_LUA_000255, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2538, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 5, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000256 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000256")
	Text( 5, MISSCRIPT_NPCSCRIPT03_LUA_000256, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2541, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 6, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000257 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000257")
	Text( 6, MISSCRIPT_NPCSCRIPT03_LUA_000257, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2544, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 7, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000258 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000258")
	Text( 7, MISSCRIPT_NPCSCRIPT03_LUA_000258, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2547, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 8, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000259 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000259")
	Text( 8, MISSCRIPT_NPCSCRIPT03_LUA_000259, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2531, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 10, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000260 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000260")
	Text( 10, MISSCRIPT_NPCSCRIPT03_LUA_000260, MultiTrigger, GetMultiTrigger(), 1)



	
	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2534, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 11, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000261 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000261")
	Text( 11, MISSCRIPT_NPCSCRIPT03_LUA_000261, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2537, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 12, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000262 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000262")
	Text( 12, MISSCRIPT_NPCSCRIPT03_LUA_000262, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2540, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 13, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000263 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000263")
	Text( 13, MISSCRIPT_NPCSCRIPT03_LUA_000263, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2543, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 14, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000264 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000264")
	Text( 14, MISSCRIPT_NPCSCRIPT03_LUA_000264, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 300 )
	TriggerCondition( 1, LvCheck, ">", 64 )
	TriggerAction( 1, TakeItem, 2383, 300 )
	TriggerAction( 1, GiveItem, 2546, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000253 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000253")
	Talk( 15, MISSCRIPT_NPCSCRIPT03_LUA_000253 )
	MISSCRIPT_NPCSCRIPT03_LUA_000265 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000265")
	Text( 15, MISSCRIPT_NPCSCRIPT03_LUA_000265, MultiTrigger, GetMultiTrigger(), 1)


	MISSCRIPT_NPCSCRIPT03_LUA_000266 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000266")
	Talk( 16, MISSCRIPT_NPCSCRIPT03_LUA_000266 )
        MISSCRIPT_NPCSCRIPT03_LUA_000267 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000267")
        Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000267, JumpPage, 17)
	MISSCRIPT_NPCSCRIPT03_LUA_000268 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000268")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000268, JumpPage, 18)
	MISSCRIPT_NPCSCRIPT03_LUA_000269 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000269")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000269, JumpPage, 19)
	MISSCRIPT_NPCSCRIPT03_LUA_000270 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000270")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000270, JumpPage, 20)
	MISSCRIPT_NPCSCRIPT03_LUA_000271 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000271")
	Text( 16, MISSCRIPT_NPCSCRIPT03_LUA_000271, JumpPage, 21)
	MISSCRIPT_NPCSCRIPT01_LUA_000520 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000520")
	Text( 16, MISSCRIPT_NPCSCRIPT01_LUA_000520, JumpPage, 30)

	MISSCRIPT_NPCSCRIPT03_LUA_000266 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000266")
	Talk( 30, MISSCRIPT_NPCSCRIPT03_LUA_000266 )
	MISSCRIPT_NPCSCRIPT03_LUA_000272 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000272")
	Text( 30, MISSCRIPT_NPCSCRIPT03_LUA_000272, JumpPage, 22)
	MISSCRIPT_NPCSCRIPT03_LUA_000273 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000273")
	Text( 30, MISSCRIPT_NPCSCRIPT03_LUA_000273, JumpPage, 23)
	MISSCRIPT_NPCSCRIPT03_LUA_000274 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000274")
	Text( 30, MISSCRIPT_NPCSCRIPT03_LUA_000274, JumpPage, 24)
	MISSCRIPT_NPCSCRIPT03_LUA_000275 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000275")
	Text( 30, MISSCRIPT_NPCSCRIPT03_LUA_000275, JumpPage, 25)
	MISSCRIPT_NPCSCRIPT03_LUA_000276 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000276")
	Text( 30, MISSCRIPT_NPCSCRIPT03_LUA_000276, JumpPage, 26)
	MISSCRIPT_NPCSCRIPT01_LUA_000521 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000521")
	Text( 30, MISSCRIPT_NPCSCRIPT01_LUA_000521, JumpPage, 16)



	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 20 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerAction( 1, TakeItem, 2383, 20 )
	TriggerAction( 1, GiveItem, 5331, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000277 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000277")
	Talk( 17, MISSCRIPT_NPCSCRIPT03_LUA_000277 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 17, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)



	
	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 50 )
	TriggerCondition( 1, HasItem, 5331, 1 )
	TriggerAction( 1, TakeItem, 2383, 50 )
	TriggerAction( 1, TakeItem, 5331, 1 )
	TriggerAction( 1, GiveItem, 5332, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000279 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000279")
	Talk( 18, MISSCRIPT_NPCSCRIPT03_LUA_000279 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 18, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)

	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 100 )
	TriggerCondition( 1, HasItem, 5332, 1 )
	TriggerAction( 1, TakeItem, 2383, 100 )
	TriggerAction( 1, TakeItem, 5332, 1 )
	TriggerAction( 1, GiveItem, 5333, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000280 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000280")
	Talk( 19, MISSCRIPT_NPCSCRIPT03_LUA_000280 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 19, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 250 )
	TriggerCondition( 1, HasItem, 5333, 1 )
	TriggerAction( 1, TakeItem, 2383, 250 )
	TriggerAction( 1, TakeItem, 5333, 1 )
	TriggerAction( 1, GiveItem, 5334, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000281 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000281")
	Talk( 20, MISSCRIPT_NPCSCRIPT03_LUA_000281 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 20, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 400 )
	TriggerCondition( 1, HasItem, 5334, 1 )
	TriggerAction( 1, TakeItem, 2383, 400 )
	TriggerAction( 1, TakeItem, 5334, 1 )
	TriggerAction( 1, GiveItem, 5335, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000282 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000282")
	Talk( 21, MISSCRIPT_NPCSCRIPT03_LUA_000282 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 21, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 650 )
	TriggerCondition( 1, HasItem, 5335, 1 )
	TriggerAction( 1, TakeItem, 2383, 650 )
	TriggerAction( 1, TakeItem, 5335, 1 )
	TriggerAction( 1, GiveItem, 5336, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000283 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000283")
	Talk( 22, MISSCRIPT_NPCSCRIPT03_LUA_000283 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 22, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)



	InitTrigger()
	TriggerCondition( 1, HasItem, 2865, 55 )
	TriggerCondition( 1, HasItem, 5336, 1 )
	TriggerAction( 1, TakeItem, 2865, 55 )
	TriggerAction( 1, TakeItem, 5336, 1 )
	TriggerAction( 1, GiveItem, 5337, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000284 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000284")
	Talk( 23, MISSCRIPT_NPCSCRIPT03_LUA_000284 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 23, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2865, 80 )
        TriggerCondition( 1, HasItem, 5337, 1)
	TriggerAction( 1, TakeItem, 2865, 80 )
	TriggerAction( 1, TakeItem, 5337, 1 )
	TriggerAction( 1, GiveItem, 5338, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000285 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000285")
	Talk( 24, MISSCRIPT_NPCSCRIPT03_LUA_000285 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 24, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2865, 110 )
	TriggerCondition( 1, HasItem, 5338, 1)
	TriggerAction( 1, TakeItem, 2865, 110 )
	TriggerAction( 1, TakeItem, 5338, 1 )
	TriggerAction( 1, GiveItem, 5339, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000286 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000286")
	Talk( 25, MISSCRIPT_NPCSCRIPT03_LUA_000286 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 25, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)


	InitTrigger()
	TriggerCondition( 1, HasItem, 2865, 155 )
	TriggerCondition( 1, HasItem, 5339, 1)
	TriggerAction( 1, TakeItem, 2865, 155 )
	TriggerAction( 1, TakeItem, 5339, 1 )
	TriggerAction( 1, GiveItem, 5340, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000287 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000287")
	Talk( 26, MISSCRIPT_NPCSCRIPT03_LUA_000287 )
	MISSCRIPT_NPCSCRIPT03_LUA_000278 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000278")
	Text( 26, MISSCRIPT_NPCSCRIPT03_LUA_000278, MultiTrigger, GetMultiTrigger(), 1)
        MISSCRIPT_NPCSCRIPT03_LUA_000288 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000288")
        Talk( 27, MISSCRIPT_NPCSCRIPT03_LUA_000288 )




	InitTrigger()
	TriggerCondition( 1, HasItem, 2383, 20 )
	TriggerCondition( 1, HasLeaveBagGrid, 1 )
	TriggerAction( 1, TakeItem, 2383, 20 )
	TriggerAction( 1, GiveItem, 2865, 1, 4 )
	TriggerFailure( 1, JumpPage, 27 )
	MISSCRIPT_NPCSCRIPT03_LUA_000289 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000289")
	Talk( 28, MISSCRIPT_NPCSCRIPT03_LUA_000289 )
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 28, MISSCRIPT_NPCSCRIPT01_LUA_000200, MultiTrigger, GetMultiTrigger(), 1)


	
	MISSCRIPT_NPCSCRIPT03_LUA_000290 = GetResString("MISSCRIPT_NPCSCRIPT03_LUA_000290")
	Talk( 29, MISSCRIPT_NPCSCRIPT03_LUA_000290)
	MISSCRIPT_NPCSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_NPCSCRIPT01_LUA_000200")
	Text( 29, MISSCRIPT_NPCSCRIPT01_LUA_000200, GetChaName45_guildwar, 1)
	AddNpcMission ( 6579 )
	AddNpcMission ( 6580 )
end

