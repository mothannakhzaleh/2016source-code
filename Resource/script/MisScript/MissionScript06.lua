--------------------------------------------------------------------------
--									--
--									--
--				MissionScript06.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading MissionScript06.lua" )


jp= JumpPage
amp=AutoMissionPage
ct=CloseTalk
am=AddMission
MissionCheck = HasFlag
mc=MissionCheck

--------------------------------------------------


--                 副本任务


--------------------------------------------
function DuplicateMission001()
-----------------------------------酒鬼的秘密
	MISSCRIPT_MISSIONSCRIPT06_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000001")
	DefineMission( 500, MISSCRIPT_MISSIONSCRIPT06_LUA_000001, 500 )
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000002 )
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(NoMission, 500)
	MisBeginCondition(NoRecord, 500)
	MisBeginAction(AddMission, 500)
	MisBeginAction(AddTrigger, 5001, TE_GETITEM, 3916, 1 )
	MisCancelAction(ClearMission, 500)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000003 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000003")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000003)
	MisNeed(MIS_NEED_ITEM, 3916, 1, 10, 1)
		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000004")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000004)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000005")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000005)
	MisResultCondition(NoRecord, 500)
	MisResultCondition(HasMission, 500)
	MisResultCondition(HasItem, 3916, 1)
	MisResultAction(TakeItem, 3916, 1)
	MisResultAction(ClearMission, 500)
	MisResultAction(SetRecord, 500)
	MisResultAction(AddExp, 5000, 5000)
	--MisResultAction(AddMoney,270,270)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3916 )	
	TriggerAction( 1, AddNextFlag, 500, 10, 1 )
	RegCurTrigger( 5001 )

-----------------------------------再来一杯
	MISSCRIPT_MISSIONSCRIPT06_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000006")
	DefineMission( 501, MISSCRIPT_MISSIONSCRIPT06_LUA_000006, 501 )
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000007")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000007 )
	MisBeginCondition(NoMission, 501)
	MisBeginCondition(NoRecord, 501)
	MisBeginCondition(HasRecord, 500)
	MisBeginAction(AddMission, 501)
	MisBeginAction(AddTrigger, 5011, TE_GETITEM, 3926, 1 )
	MisBeginAction(AddTrigger, 5012, TE_GETITEM, 1478, 20 )
	MisCancelAction(ClearMission, 501)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000008 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000008")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000008)
	MisNeed(MIS_NEED_ITEM, 3926, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 1478, 20, 20, 20)
		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000009")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000009)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000010 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000010")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000010)
	MisResultCondition(NoRecord, 501)
	MisResultCondition(HasMission, 501)
	MisResultCondition(HasItem, 3926, 1)
	MisResultCondition(HasItem, 1478, 20)
	MisResultAction(TakeItem, 3926, 1)
	MisResultAction(TakeItem, 1478, 20)
	MisResultAction(ClearMission, 501)
	MisResultAction(SetRecord, 501)
	MisResultAction(AddExp, 10000, 10000)
	--MisResultAction(AddMoney,270,270)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3926 )	
	TriggerAction( 1, AddNextFlag, 501, 10, 1 )
	RegCurTrigger( 5011 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1478 )	
	TriggerAction( 1, AddNextFlag, 501, 20, 20 )
	RegCurTrigger( 5012 )

-----------------------------------醉生梦死
	MISSCRIPT_MISSIONSCRIPT06_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000011")
	DefineMission( 502, MISSCRIPT_MISSIONSCRIPT06_LUA_000011, 502 )
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000012")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000012 )
	MisBeginCondition(NoMission, 502)
	MisBeginCondition(NoRecord, 502)
	MisBeginCondition(HasRecord, 500)
	MisBeginCondition(HasMission, 501)
	MisBeginAction(AddMission, 502)
	MisBeginAction(AddTrigger, 5021, TE_GETITEM, 4377, 1 )
	MisBeginAction(AddTrigger, 5022, TE_GETITEM, 3121, 5 )
	MisBeginAction(AddTrigger, 5023, TE_GETITEM, 3131, 5 )
	MisBeginAction(AddTrigger, 5024, TE_GETITEM, 4352, 20 )
	MisCancelAction(ClearMission, 502)

	MisNeed(MIS_NEED_ITEM, 4377, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 3121, 5, 15, 5)
	MisNeed(MIS_NEED_ITEM, 3131, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 4352, 20, 30, 20)

	MisPrize(MIS_PRIZE_ITEM, 3926, 1, 4)
	MisPrizeSelAll()
		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000013")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000013)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000014")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000014)
	MisResultCondition(NoRecord, 502)
	MisResultCondition(HasMission, 502)
	MisResultCondition(HasItem, 4377, 1)
	MisResultCondition(HasItem, 3121, 5)
	MisResultCondition(HasItem, 3131, 5)
	MisResultCondition(HasItem, 4352, 20)
	MisResultCondition(HasMoney, 2000 )
	MisResultAction(TakeMoney, 2000 )
	MisResultAction(TakeItem, 4377, 1)
	MisResultAction(TakeItem, 3121, 5)
	MisResultAction(TakeItem, 3131, 5)
	MisResultAction(TakeItem, 4352, 20)
	MisResultAction(ClearMission, 502)
	MisResultAction(SetRecord, 502)
	MisResultAction(AddExp, 20000, 20000)
	--MisResultAction(AddMoney,270,270)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4377 )	
	TriggerAction( 1, AddNextFlag, 502, 10, 1 )
	RegCurTrigger( 5021 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3121 )	
	TriggerAction( 1, AddNextFlag, 502, 15, 5 )
	RegCurTrigger( 5022 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3131 )	
	TriggerAction( 1, AddNextFlag, 502, 20, 5 )
	RegCurTrigger( 5023 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4352 )	
	TriggerAction( 1, AddNextFlag, 502, 20, 20 )
	RegCurTrigger( 5024 )

-----------------------------------废灵武士骸骨
	MISSCRIPT_MISSIONSCRIPT06_LUA_000015 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000015")
	DefineMission( 503, MISSCRIPT_MISSIONSCRIPT06_LUA_000015, 503 )
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000016 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000016")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000016 )
	MisBeginCondition(NoMission, 503)
	MisBeginCondition(NoRecord, 503)
	MisBeginCondition(HasRecord, 501)
	MisBeginAction(AddMission, 503)
	MisBeginAction(AddTrigger, 5031, TE_GETITEM, 3434, 10 )
	MisBeginAction(AddTrigger, 5032, TE_GETITEM, 3435, 10 )
	MisBeginAction(AddTrigger, 5033, TE_GETITEM, 3436, 10 )
	MisBeginAction(AddTrigger, 5034, TE_GETITEM, 3437, 10 )
	MisCancelAction(ClearMission, 503)

	--MisNeed(MIS_NEED_DESP, "在废灵都市里找到一些废灵武士骸骨,一共是10个,把他们交给白银城的冒险者导师·小山车(2193,2730)")
	MisNeed(MIS_NEED_ITEM, 3434, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 3435, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 3436, 10, 30, 10)
	MisNeed(MIS_NEED_ITEM, 3437, 10, 40, 10)
		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000017")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000017)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000018")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000018)
	MisResultCondition(NoRecord, 503)
	MisResultCondition(HasMission, 503)
	MisResultCondition(HasItem, 3434, 10)
	MisResultCondition(HasItem, 3435, 10)
	MisResultCondition(HasItem, 3436, 10)
	MisResultCondition(HasItem, 3437, 10)
	MisResultAction(TakeItem, 3434, 10)
	MisResultAction(TakeItem, 3435, 10)
	MisResultAction(TakeItem, 3436, 10)
	MisResultAction(TakeItem, 3437, 10)
	MisResultAction(ClearMission, 503)
	MisResultAction(SetRecord, 503)
	MisResultAction(AddExp, 80000, 80000)
	--MisResultAction(AddMoney,270,270)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3434 )	
	TriggerAction( 1, AddNextFlag, 503, 10, 10 )
	RegCurTrigger( 5031 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3435 )	
	TriggerAction( 1, AddNextFlag, 503, 20, 10 )
	RegCurTrigger( 5032 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3436 )	
	TriggerAction( 1, AddNextFlag, 503, 30, 10 )
	RegCurTrigger( 5033 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3437 )	
	TriggerAction( 1, AddNextFlag, 503, 40, 10 )
	RegCurTrigger( 5034 )

----------------------------------------
--                                    --
--        加勒比海盗主线任务          --
--                                    --
----------------------------------------

----------------------------------------
--                                    --
--              主线任务              --
--                                    --
----------------------------------------

-- 铁匠 >> 铁匠的担忧
	MISSCRIPT_MISSIONSCRIPT06_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000019")
	DefineMission(504,MISSCRIPT_MISSIONSCRIPT06_LUA_000019,504)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000020 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000020")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000020)

	MisBeginCondition(NoRecord, 504)
	MisBeginCondition(NoMission, 504)

	MisBeginAction(AddMission, 504)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000021 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000021")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000021)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000022")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000022)
	
	MisResultCondition(AlwaysFailure)

-- 铁匠 >> 铁匠的担忧
	MISSCRIPT_MISSIONSCRIPT06_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000019")
	DefineMission(505,MISSCRIPT_MISSIONSCRIPT06_LUA_000019,504,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000023")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000023)
	MisResultCondition(HasMission, 504)
	MisBeginCondition(NoRecord, 504)
	
	MisResultAction(AddExp, 10000, 10000)
	MisResultAction(AddMoney, 25000, 25000)
	MisResultAction(ClearMission, 504)
	MisResultAction(SetRecord, 504)


-- 铁匠 >> 伊丽莎白的定情信物
	MISSCRIPT_MISSIONSCRIPT06_LUA_000024 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000024")
	DefineMission(506,MISSCRIPT_MISSIONSCRIPT06_LUA_000024,505)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000025")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000025)

	MisBeginCondition(HasRecord, 504)
	MisBeginCondition(NoMission, 505)
	MisBeginCondition(NoRecord, 505)

	MisBeginAction(AddMission, 505)
	MisBeginAction(AddTrigger, 5051, TE_GETITEM, 2415, 1)
	
	MisNeed(MIS_NEED_ITEM, 2415, 1, 10, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000026 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000026")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000026)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000027")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000027)

	MisResultCondition(HasMission, 505)
	MisResultCondition(HasItem, 2415, 1)
	MisResultCondition(NoRecord,505)

	MisResultAction(AddExp, 250000, 250000)
	MisResultAction(AddMoney, 150000, 150000)
	MisResultAction(ClearMission, 505)
	MisResultAction(TakeItem, 2415,1)
	MisResultAction(SetRecord, 505)

	InitTrigger()
	TriggerCondition(1,IsItem, 2415)
	TriggerAction(1, AddNextFlag, 505, 10, 1)
	RegCurTrigger(5051)


-- 铁匠 >> 定情项链
	MISSCRIPT_MISSIONSCRIPT06_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000028")
	DefineMission(507,MISSCRIPT_MISSIONSCRIPT06_LUA_000028,506)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000029 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000029")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000029)

	MisBeginCondition(HasRecord, 505)
	MisBeginCondition(NoRecord, 506)
	MisBeginCondition(NoMission, 506)
	MisBeginBagNeed(1)

	MisBeginAction(AddMission, 506)
	MisBeginAction(GiveItem, 2415,1,4)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000030 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000030")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000030)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000031")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000031)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisResultCondition(AlwaysFailure)

-- 铁匠 >> 定情项链
	MISSCRIPT_MISSIONSCRIPT06_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000028")
	DefineMission(508,MISSCRIPT_MISSIONSCRIPT06_LUA_000028,506, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000032 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000032")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000032)
	MisResultCondition(HasMission, 506)
	MisResultCondition(NoRecord,506)
	MisResultCondition(HasItem, 2415, 1)

	MisResultAction(AddExp, 10000, 10000)
	MisResultAction(AddMoney, 25000, 25000)

	MisResultAction(TakeItem, 2415, 1)
	MisResultAction(ClearMission, 506)
	MisResultAction(SetRecord, 506)

-- 铁匠 >> 铁匠的约定
	MISSCRIPT_MISSIONSCRIPT06_LUA_000033 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000033")
	DefineMission(509,MISSCRIPT_MISSIONSCRIPT06_LUA_000033,507)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000034 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000034")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000034)

	MisBeginCondition(HasRecord, 506)
	MisBeginCondition(NoRecord, 507)
	MisBeginCondition(NoMission, 507)

	MisBeginAction(AddMission, 507)
	MisBeginAction(AddTrigger, 5071, TE_GETITEM, 2384, 1)

	MisNeed(MIS_NEED_ITEM, 2384, 1, 10, 1)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000035 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000035")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000035)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000036 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000036")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000036)

	MisResultCondition(HasMission, 507)
	MisResultCondition(HasItem, 2384, 1)
	MisResultCondition(NoRecord, 507)

	MisResultAction(TakeItem, 2384, 1)
	MisResultAction(AddExp, 200000, 200000)
	MisResultAction(AddMoney, 100000, 100000)

	MisResultAction(ClearMission, 507)
	MisResultAction(SetRecord, 507)

	InitTrigger()
	TriggerCondition(1, IsItem, 2384)
	TriggerAction(1, AddNextFlag, 507, 10, 1)
	RegCurTrigger(5071)

-- 铁匠 >> 特殊的武器
	MISSCRIPT_MISSIONSCRIPT06_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000037")
	DefineMission(573,MISSCRIPT_MISSIONSCRIPT06_LUA_000037,508)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000038")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000038)
	
	MisBeginBagNeed(1)
	MisBeginCondition(HasRecord, 507)
	MisBeginCondition(NoRecord, 508)
	MisBeginCondition(NoMission, 508)
	MisBeginBagNeed(1)

	MisBeginAction(AddMission, 508)
	MisBeginAction(GiveItem, 2384, 1,4)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000039 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000039")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000039)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000040 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000040")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000040)

	MisResultCondition(AlwaysFailure)


-- 杰克史派罗 >> 特殊的武器
	MISSCRIPT_MISSIONSCRIPT06_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000037")
	DefineMission(574,MISSCRIPT_MISSIONSCRIPT06_LUA_000037, 508,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000041 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000041")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000041)
	MisResultCondition(HasMission, 508)
	MisResultCondition(NoRecord, 508)
	MisResultCondition(HasItem, 2384, 1)

	MisResultAction(AddMoney, 25000, 25000)
	MisResultAction(TakeItem, 2384, 1)
	MisResultAction(ClearMission, 508)
	MisResultAction(SetRecord, 508)


-- 杰克史派罗 >> 海盗与海军
	MISSCRIPT_MISSIONSCRIPT06_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000042")
	DefineMission(575,MISSCRIPT_MISSIONSCRIPT06_LUA_000042,509)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000043 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000043")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000043)

	MisBeginCondition(HasRecord, 508)
	MisBeginCondition(NoRecord, 509)
	MisBeginCondition(NoMission, 509)

	MisBeginAction(AddMission, 509)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000044 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000044")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000044)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000045")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000045)
	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisResultCondition(AlwaysFailure)

-- 诺灵顿 >> 海盗与海军
	MISSCRIPT_MISSIONSCRIPT06_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000042")
	DefineMission(576, MISSCRIPT_MISSIONSCRIPT06_LUA_000042, 509,COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000046")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000046)

	MisResultCondition(HasMission, 509)
	MisResultCondition(NoRecord, 509)

	MisResultAction(AddMoney, 25000, 25000)
	MisResultAction(ClearMission, 509)
	MisResultAction(SetRecord, 509)

-- 诺灵顿 >> 将军的表白
	MISSCRIPT_MISSIONSCRIPT06_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000047")
	DefineMission(577,MISSCRIPT_MISSIONSCRIPT06_LUA_000047,510)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000048 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000048")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000048)

	MisBeginCondition(HasRecord, 509)
	MisBeginCondition(NoRecord, 510)
	MisBeginCondition(NoMission, 510)
	
	MisBeginAction(AddMission, 510)
	MisBeginAction(AddTrigger, 5101, TE_GETITEM, 2416, 1)
	MisNeed(MIS_NEED_ITEM, 2416, 1, 10, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000049 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000049")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000049)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000050")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000050)

	MisResultCondition(HasMission, 510)
	MisResultCondition(NoRecord, 510)
	MisResultCondition(HasItem, 2416, 1)
	
	MisResultAction(TakeItem, 2416, 1)
	MisResultAction(AddExp, 30000, 30000)
	MisResultAction(AddMoney, 35000, 35000)
	MisResultAction(ClearMission, 510)
	MisResultAction(SetRecord, 510)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 2416)
	TriggerAction(1, AddNextFlag, 510, 10, 1)
	RegCurTrigger(5101)

-- 诺灵顿 >> 将军的表白
	MISSCRIPT_MISSIONSCRIPT06_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000047")
	DefineMission(578,MISSCRIPT_MISSIONSCRIPT06_LUA_000047,511)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000051")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000051)

	MisBeginCondition(HasRecord, 510)
	MisBeginCondition(NoRecord, 511)
	MisBeginCondition(NoMission, 511)
	MisBeginBagNeed(1)

	MisBeginAction(AddMission, 511)
	MisBeginAction(GiveItem, 2416, 1,4)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000052 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000052")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000052)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000053 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000053")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000053)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisResultCondition(AlwaysFailure)

-- 伊丽莎白 >> 将军的表白
	MISSCRIPT_MISSIONSCRIPT06_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000047")
	DefineMission(579, MISSCRIPT_MISSIONSCRIPT06_LUA_000047, 511,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000054 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000054")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000054)
	MisResultCondition(HasMission, 511)
	MisResultCondition(NoRecord, 511)
	MisResultCondition(HasItem, 2416, 1)

	MisResultAction(AddMoney, 35000, 35000)
	MisResultAction(TakeItem, 2416, 1)
	MisResultAction(ClearMission, 511)
	MisResultAction(SetRecord, 511)

-- 伊丽莎白 >> 伊丽莎白的祈祷
	MISSCRIPT_MISSIONSCRIPT06_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000055")
	DefineMission(580,MISSCRIPT_MISSIONSCRIPT06_LUA_000055,512)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000056 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000056")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000056)

	MisBeginCondition(HasRecord, 511)
	MisBeginCondition(NoRecord, 512)
	MisBeginCondition(NoMission, 512)
	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginAction(AddMission, 512)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000057")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000057)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000058 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000058")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000058)

	MisResultCondition(AlwaysFailure)


-- 铁匠 >> 伊丽莎白的祈祷
	MISSCRIPT_MISSIONSCRIPT06_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000055")
	DefineMission(581, MISSCRIPT_MISSIONSCRIPT06_LUA_000055, 512,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000059 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000059)

	MisResultCondition(HasMission, 512)
	MisResultCondition(NoRecord, 512)
	
	MisResultAction(AddMoney, 35000, 35000)
	MisResultAction(ClearMission, 512)
	MisResultAction(SetRecord, 512)

-- 铁匠 >> 诅咒
	MISSCRIPT_MISSIONSCRIPT06_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000060")
	DefineMission(582,MISSCRIPT_MISSIONSCRIPT06_LUA_000060,513)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000061 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000061")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000061)
	
	MisBeginCondition(HasRecord, 512)
	MisBeginCondition(NoRecord, 513)
	MisBeginCondition(NoMission, 513)
	
	MisBeginAction(AddMission, 513)
	MisBeginAction(AddTrigger, 5131,TE_GETITEM, 2417, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisNeed(MIS_NEED_ITEM, 2417, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000062 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000062")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000062)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000063 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000063")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000063)

	MisResultCondition(HasMission, 513)
	MisResultCondition(NoRecord, 513)
	MisResultCondition(HasItem, 2417, 1)
	
	MisResultAction(TakeItem, 2417, 1)
	MisResultAction(AddExp, 500000, 500000)
	MisResultAction(AddMoney, 800000, 800000)
	MisResultAction(ClearMission, 513)
	MisResultAction(SetRecord, 513)

	InitTrigger()
	TriggerCondition(1, IsItem, 2417)
	TriggerAction(1, AddNextFlag, 513, 10, 1)
	RegCurTrigger(5131)

-- 铁匠 >> 诅咒

	MISSCRIPT_MISSIONSCRIPT06_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000060")
	DefineMission(583,MISSCRIPT_MISSIONSCRIPT06_LUA_000060,514)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000064 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000064")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000064)

	MisBeginCondition(HasRecord, 513)
	MisBeginCondition(NoRecord, 514)
	MisBeginCondition(NoMission, 514)

	MisBeginAction(AddMission, 514)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000065 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000065")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000065)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000066 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000066")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000066)

	MisResultCondition(AlwaysFailure)

-- 杰克史派罗 >> 诅咒
	MISSCRIPT_MISSIONSCRIPT06_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000060")
	DefineMission(584, MISSCRIPT_MISSIONSCRIPT06_LUA_000060, 514,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000067 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000067")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000067)
	MisResultCondition(HasMission, 514)
	MisResultCondition(NoRecord, 514)

	MisResultAction(AddMoney, 30000, 30000)
	MisResultAction(ClearMission, 514)
	MisResultAction(SetRecord, 514)

-- 杰克史派罗 >> 真真的船长
	MISSCRIPT_MISSIONSCRIPT06_LUA_000068 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000068")
	DefineMission(585,MISSCRIPT_MISSIONSCRIPT06_LUA_000068,515)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000069 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000069")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000069)
	MisBeginCondition(HasRecord, 514)
	MisBeginCondition(NoRecord, 515)
	MisBeginCondition(NoMission,515)
	
	MisBeginAction(AddMission, 515)
	MisBeginAction(AddTrigger, 5151, TE_KILL, 805, 1)
	MisBeginAction(AddTrigger, 5152, TE_GETITEM, 2428, 1)

	MisNeed(MIS_NEED_KILL, 805, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2428, 1,20, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000070 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000070")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000070)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000071 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000071")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000071)

	MisResultCondition(HasMission, 515)
	MisResultCondition(HasFlag, 515, 10)
	MisResultCondition(HasItem, 2428,1)
	MisResultCondition(NoRecord, 515)

	MisResultAction(TakeItem, 2428, 1)
	MisResultAction(ClearMission, 515)
	MisResultAction(SetRecord, 515)

	MisResultAction(AddExp, 500000,500000)
	MisResultAction(AddMoney, 800000,800000)

	InitTrigger()
	TriggerCondition(1,IsMonster, 805)
	TriggerAction(1,AddNextFlag, 515, 10, 1)
	RegCurTrigger(5151)

	InitTrigger()
	TriggerCondition(1, IsItem, 2428)
	TriggerAction(1, AddNextFlag , 515, 20, 1)
	RegCurTrigger(5152)


-- 杰克史派罗 >> 贺礼
	MISSCRIPT_MISSIONSCRIPT06_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000072")
	DefineMission(586,MISSCRIPT_MISSIONSCRIPT06_LUA_000072,516)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000073 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000073")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000073)

	MisBeginCondition(HasRecord, 515)
	MisBeginCondition(NoRecord, 516)
	MisBeginCondition(NoMission, 516)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisBeginAction(AddMission, 516)
	MisBeginAction(GiveItem, 2433, 1,4)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000074 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000074")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000074)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000075 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000075")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000075)
	
	MisResultCondition(AlwaysFailure)

-- 杰克史派罗 >> 贺礼
	MISSCRIPT_MISSIONSCRIPT06_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000072")
	DefineMission(587,MISSCRIPT_MISSIONSCRIPT06_LUA_000072,516,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000076 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000076")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000076)
	MisResultCondition(HasMission, 516)
	MisResultCondition(NoRecord, 516)
	MisResultCondition(HasItem, 2433, 1)
	
	MisResultAction(TakeItem, 2433, 1)
	MisResultAction(AddMoney, 30000, 30000)
	MisResultAction(ClearMission, 516)
	MisResultAction(SetRecord, 516)

-- 伊丽莎白 >> 心有所属
	MISSCRIPT_MISSIONSCRIPT06_LUA_000077 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000077")
	DefineMission(588,MISSCRIPT_MISSIONSCRIPT06_LUA_000077,517)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000078")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000078)

	MisBeginCondition(HasRecord, 516)
	MisBeginCondition(NoRecord, 517)
	MisBeginCondition(NoMission, 517)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisBeginAction(AddMission, 517)
	MisBeginAction(GiveItem, 2416, 1,4)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000079 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000079")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000079)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000080 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000080")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000080)
	
	MisResultCondition(AlwaysFailure)

-- 诺灵顿 >> 心有所属
	MISSCRIPT_MISSIONSCRIPT06_LUA_000077 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000077")
	DefineMission(589,MISSCRIPT_MISSIONSCRIPT06_LUA_000077,517,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000081 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000081")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000081)
	MisResultCondition(HasMission, 517)
	MisResultCondition(NoRecord, 517)
	MisResultCondition(HasItem, 2416, 1)
	
	MisResultAction(TakeItem, 2416, 1)
	MisResultAction(AddMoney, 30000, 30000)
	MisResultAction(ClearMission, 517)
	MisResultAction(SetRecord, 517)

-- 诺灵顿  >> 诺灵顿的祝福
	MISSCRIPT_MISSIONSCRIPT06_LUA_000082 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000082")
	DefineMission(590,MISSCRIPT_MISSIONSCRIPT06_LUA_000082,518)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000083 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000083")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000083)

	MisBeginCondition(HasRecord, 517)
	MisBeginCondition(NoRecord, 518)
	MisBeginCondition(NoMission, 518)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisBeginAction(AddMission, 518)
	MisBeginAction(GiveItem, 2435, 1,4)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000084 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000084")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000084)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000085 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000085")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000085)
	
	MisResultCondition(AlwaysFailure)

-- 伊丽莎白>> 诺灵顿的祝福
	MISSCRIPT_MISSIONSCRIPT06_LUA_000082 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000082")
	DefineMission(591,MISSCRIPT_MISSIONSCRIPT06_LUA_000082,518,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000086 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000086")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000086)
	MisResultCondition(HasMission, 518)
	MisResultCondition(NoRecord, 518)
	MisResultCondition(HasItem, 2435, 1)
	
	MisResultAction(TakeItem, 2435, 1)
	MisResultAction(AddMoney,300000, 300000)
	MisResultAction(ClearMission, 518)
	MisResultAction(SetRecord, 518)
	
--------------------------------------------------
--						--
--		2.0日常任务			--
--						--
--------------------------------------------------

---------------------海港指挥的聚会-----------白银城
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6702, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6306,1)
	MisResultAction(TakeItem, 6306, 1)
	MisResultAction(GiveItem, 6313, 1,4)
	
----------------------海港指挥的聚会-----------雷霆堡
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6703, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6307,1)
	MisResultAction(TakeItem, 6307, 1)
	MisResultAction(GiveItem, 6314, 1,4)
	
----------------------海港指挥的聚会-----------沙岚新城
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6704, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6308,1)
	MisResultAction(TakeItem, 6308, 1)
	MisResultAction(GiveItem, 6315, 1,4)
	
----------------------海港指挥的聚会-----------春风镇
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6705, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6309,1)
	MisResultAction(TakeItem, 6309, 1)
	MisResultAction(GiveItem, 6316, 1,4)
	
----------------------海港指挥的聚会-----------阿尔补给站
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6706, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6310,1)
	MisResultAction(TakeItem, 6310, 1)
	MisResultAction(GiveItem, 6317, 1,4)
	
----------------------海港指挥的聚会-----------鸣沙岛
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6707, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6311,1)
	MisResultAction(TakeItem, 6311, 1)
	MisResultAction(GiveItem, 6318, 1,4)
	
----------------------海港指挥的聚会-----------阿兰比斯冰原
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6708, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000088")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000088)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(HasItem, 6312,1)
	MisResultAction(TakeItem, 6312, 1)
	MisResultAction(GiveItem, 6319, 1,4)

--------------------海港指挥的聚会----------------- 开始
	MISSCRIPT_MISSIONSCRIPT06_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000087")
	DefineMission(6701, MISSCRIPT_MISSIONSCRIPT06_LUA_000087,1900)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000089")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000089)
	MisBeginCondition(NoMission,1900)
	MisBeginCondition(LvCheck, ">",89)
	MisBeginCondition(Get_Day_Mission1)
	MisBeginAction(AddMission, 1900)
	MisBeginAction(GiveItem, 6306,1,4)
	MisBeginAction(GiveItem, 6307,1,4)
	MisBeginAction(GiveItem, 6308,1,4)
	MisBeginAction(GiveItem, 6309,1,4)
	MisBeginAction(GiveItem, 6310,1,4)
	MisBeginAction(GiveItem, 6311,1,4)
	MisBeginAction(GiveItem, 6312,1,4)
	MisCancelAction(ClearMission, 1900)
	MisCancelAction(TakeItem, 6306,1)
	MisCancelAction(TakeItem, 6307,1)
	MisCancelAction(TakeItem, 6308,1)
	MisCancelAction(TakeItem, 6309,1)
	MisCancelAction(TakeItem, 6310,1)
	MisCancelAction(TakeItem, 6311,1)
	MisCancelAction(TakeItem, 6312,1)
	
	MisBeginBagNeed(7)


	MisBeginAction(AddTrigger,19001, TE_GETITEM,6313, 1)
	MisBeginAction(AddTrigger,19002, TE_GETITEM,6314, 1)
	MisBeginAction(AddTrigger,19003, TE_GETITEM,6315, 1)
	MisBeginAction(AddTrigger,19004, TE_GETITEM,6316, 1)
	MisBeginAction(AddTrigger,19005, TE_GETITEM,6317, 1)
	MisBeginAction(AddTrigger,19006, TE_GETITEM,6318, 1)
	MisBeginAction(AddTrigger,19007, TE_GETITEM,6319, 1)

	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000090")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000090)

	MisNeed(MIS_NEED_ITEM, 6313, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 6314, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 6315, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 6316, 1, 40, 1)
	MisNeed(MIS_NEED_ITEM, 6317, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 6318, 1, 60, 1)
	MisNeed(MIS_NEED_ITEM, 6319, 1, 70, 1)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000091 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000091")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000091)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000092 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000092")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000092)
	MisResultCondition(HasMission, 1900)
	MisResultCondition(NoRecord, 1900)
	MisResultCondition(HasItem, 6313,1)
	MisResultCondition(HasItem, 6314,1)
	MisResultCondition(HasItem, 6315,1)
	MisResultCondition(HasItem, 6316,1)
	MisResultCondition(HasItem, 6317,1)
	MisResultCondition(HasItem, 6318,1)
	MisResultCondition(HasItem, 6319,1)

	MisResultAction(TakeItem, 6313,1)
	MisResultAction(TakeItem, 6314,1)
	MisResultAction(TakeItem, 6315,1)
	MisResultAction(TakeItem, 6316,1)
	MisResultAction(TakeItem, 6317,1)
	MisResultAction(TakeItem, 6318,1)
	MisResultAction(TakeItem, 6319,1)
	MisResultAction(AddExpPer, 0.1,0.3)
	MisResultAction(AddMoney , 30000)
	MisResultAction(AddItem_Mission1)
	MisResultAction(ClearMission, 1900)

	InitTrigger()
	TriggerCondition(1, IsItem, 6313)	
	TriggerAction(1, AddNextFlag, 1900, 10, 1)
	RegCurTrigger(19001)

	InitTrigger()
	TriggerCondition(1, IsItem, 6314)	
	TriggerAction(1, AddNextFlag, 1900, 20, 1)
	RegCurTrigger(19002)

	InitTrigger()
	TriggerCondition(1, IsItem, 6315)
	TriggerAction(1, AddNextFlag, 1900, 30, 1)
	RegCurTrigger(19003)

	InitTrigger()
	TriggerCondition(1, IsItem, 6316)	
	TriggerAction(1, AddNextFlag, 1900, 40, 1)
	RegCurTrigger(19004)

	InitTrigger()
	TriggerCondition(1, IsItem, 6317)	
	TriggerAction(1, AddNextFlag, 1900, 50, 1)
	RegCurTrigger(19005)

	InitTrigger()
	TriggerCondition(1, IsItem, 6318)
	TriggerAction(1, AddNextFlag, 1900, 60, 1)
	RegCurTrigger(19006)

	InitTrigger()
	TriggerCondition(1, IsItem, 6319)	
	TriggerAction(1, AddNextFlag, 1900, 70, 1)
	RegCurTrigger(19007)
	
	
	
	
------------------生化危机--------------(开始)		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000093")
	DefineMission(6709, MISSCRIPT_MISSIONSCRIPT06_LUA_000093,1901)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000094 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000094")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000094)
	MisBeginCondition(NoRecord, 1901)
	MisBeginCondition(NoMission,1901)
	MisBeginCondition(LvCheck, ">",89)
	MisBeginCondition(Get_Day_Mission2)
	MisBeginAction(AddMission, 1901)
	MisCancelAction(ClearMission, 1901)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000095 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000095")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000095)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000096")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000096)
	MisResultCondition(AlwaysFailure)
	
------------------生化危机--------------(结束)	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000093")
	DefineMission(6710, MISSCRIPT_MISSIONSCRIPT06_LUA_000093,1901, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000097 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000097")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000097)
	MisResultCondition(HasMission, 1901)
	MisResultCondition(NoRecord, 1901)
	MisResultAction(ClearMission, 1901)
	MisResultAction(SetRecord, 1901)
	MisResultAction(AddExp , 40000, 40000)		
	MisResultAction(AddMoney , 15000)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000098")
	MisResultAction(GiveNpcMission, 6711, MISSCRIPT_MISSIONSCRIPT06_LUA_000098, 4)


------------------僵尸迷城--------------	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000099 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000099")
	DefineMission(6711, MISSCRIPT_MISSIONSCRIPT06_LUA_000099,1902)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000100 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000100")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000100)
	MisBeginCondition(NoRecord, 1902)
	MisBeginCondition(NoMission,1902)
	MisBeginCondition(HasRecord, 1901)
	MisBeginAction(AddMission, 1902)
	MisBeginAction(AddTrigger, 19021, TE_KILL, 41, 30)
	MisBeginAction(AddTrigger, 19022, TE_KILL, 42, 30)
	MisCancelAction(ClearMission, 1902)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000101 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000101")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000101)
	MisNeed(MIS_NEED_KILL, 41, 30, 10, 30)
	MisNeed(MIS_NEED_KILL, 42, 30, 40, 30)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000102 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000102")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000102)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000103 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000103")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000103)
	MisResultCondition(HasMission, 1902)
	MisResultCondition(NoRecord, 1902)
	MisResultCondition(HasFlag, 1902, 39)
	MisResultCondition(HasFlag, 1902, 69)
	MisResultAction(ClearMission, 1902)
	MisResultAction(SetRecord, 1902)
	MisResultAction(AddExp, 400000, 400000)
	MisResultAction(AddMoney , 350000)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000098")
	MisResultAction(GiveNpcMission, 6712, MISSCRIPT_MISSIONSCRIPT06_LUA_000098,5)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 41)	
	TriggerAction(1, AddNextFlag,1902, 10, 30)
	RegCurTrigger(19021)
	
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 42)	
	TriggerAction(1, AddNextFlag,1902, 40, 30)
	RegCurTrigger(19022)
	
	
	
------------------冬岛危机--------------(开始)		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000104 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000104")
	DefineMission(6712,MISSCRIPT_MISSIONSCRIPT06_LUA_000104,1903)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000105 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000105")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000105)
	MisBeginCondition(NoRecord, 1903)
	MisBeginCondition(NoMission,1903)
	MisBeginCondition(HasRecord, 1902)
	MisBeginAction(AddMission, 1903)
	MisCancelAction(ClearMission, 1903)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000106 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000106")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000106)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000107")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000107)
	MisResultCondition(AlwaysFailure)
	
------------------冬岛危机--------------(结束)	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000104 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000104")
	DefineMission(6713, MISSCRIPT_MISSIONSCRIPT06_LUA_000104,1903, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000108 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000108")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000108)
	MisResultCondition(HasMission, 1903)
	MisResultCondition(NoRecord, 1903)
	MisResultAction(ClearMission, 1903)
	MisResultAction(SetRecord, 1903)
	MisResultAction(AddExp , 100000, 100000)		
	MisResultAction(AddMoney , 150000)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000109 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000109")
	MisResultAction(GiveNpcMission, 6714, MISSCRIPT_MISSIONSCRIPT06_LUA_000109, 5)

	
	
------------------吉尔求救--------------(开始)		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000110 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000110")
	DefineMission(6714,MISSCRIPT_MISSIONSCRIPT06_LUA_000110,1904)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000111 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000111")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000111)
	MisBeginCondition(NoRecord, 1904)
	MisBeginCondition(NoMission,1904)
	MisBeginCondition(HasRecord, 1903)
	MisBeginAction(AddMission, 1904)
	MisCancelAction(ClearMission, 1904)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000112 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000112")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000112)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000113 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000113")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000113)
	MisResultCondition(AlwaysFailure)
	
------------------吉尔求救--------------(结束)	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000110 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000110")
	DefineMission(6715, MISSCRIPT_MISSIONSCRIPT06_LUA_000110,1904, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000114")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000114)
	MisResultCondition(HasMission, 1904)
	MisResultCondition(NoRecord, 1904)
	MisResultAction(ClearMission, 1904)
	MisResultAction(SetRecord, 1904)
	MisResultAction(AddExp , 100000, 100000)		
	MisResultAction(AddMoney , 150000)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000115 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000115")
	MisResultAction(GiveNpcMission, 6716, MISSCRIPT_MISSIONSCRIPT06_LUA_000115, 5)
	

------------------不死亡灵--------------	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000116 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000116")
	DefineMission(6716, MISSCRIPT_MISSIONSCRIPT06_LUA_000116,1905)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000117 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000117")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000117)
	MisBeginCondition(NoRecord, 1905)
	MisBeginCondition(NoMission,1904)
	MisBeginCondition(HasRecord, 1904)
	MisBeginAction(AddMission, 1905)
	MisBeginAction(AddTrigger, 19051, TE_KILL, 1086, 10)
	MisCancelAction(ClearMission, 1905)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000118 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000118")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000118)
	MisNeed(MIS_NEED_KILL, 1086, 10, 10, 10)

	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000119 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000119")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000119)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000120 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000120")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000120)
	MisResultCondition(HasMission, 1905)
	MisResultCondition(NoRecord, 1905)
	MisResultCondition(HasFlag, 1905, 19)
	MisResultAction(ClearMission, 1905)
	MisResultAction(SetRecord, 1905)
	MisResultAction(AddExp, 400000, 300000)
	MisResultAction(AddMoney , 350000)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000115 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000115")
	MisResultAction(GiveNpcMission, 6717, MISSCRIPT_MISSIONSCRIPT06_LUA_000115, 6)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1086)	
	TriggerAction(1, AddNextFlag,1905, 10, 10)
	RegCurTrigger(19051)
	
	
------------------T病毒原液--------------(开始)		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000121")
	DefineMission(6717,MISSCRIPT_MISSIONSCRIPT06_LUA_000121,1906)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000122 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000122")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000122)
	MisBeginCondition(NoRecord, 1906)
	MisBeginCondition(NoMission,1906)
	MisBeginCondition(HasRecord, 1905)
	MisBeginAction(AddMission, 1906)
	MisBeginAction(GiveItem, 6320,1,4)
	MisCancelAction(ClearMission, 1906)
	MisCancelAction(TakeItem, 6320,1)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000123 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000123")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000123)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000124 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000124")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000124)
	MisResultCondition(AlwaysFailure)
	
------------------T病毒原液--------------(结束)	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000121")
	DefineMission(6718, MISSCRIPT_MISSIONSCRIPT06_LUA_000121,1906, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000125 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000125")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000125)
	MisResultCondition(HasMission, 1906)
	MisResultCondition(NoRecord, 1906)
	MisResultCondition(HasItem, 6320,1)
	MisResultAction(ClearMission, 1906)
	MisResultAction(TakeItem, 6320,1)
	MisResultAction(SetRecord, 1906)
	MisResultAction(AddExp , 100000,100000)		
	MisResultAction(AddMoney , 200000)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000126 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000126")
	MisResultAction(GiveNpcMission, 6719, MISSCRIPT_MISSIONSCRIPT06_LUA_000126, 4)

	
------------------解毒剂--------------(开始)		
	MISSCRIPT_MISSIONSCRIPT06_LUA_000127 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000127")
	DefineMission(6719,MISSCRIPT_MISSIONSCRIPT06_LUA_000127,1907)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000128 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000128")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000128)
	MisBeginCondition(NoRecord, 1907)
	MisBeginCondition(NoMission,1907)
	MisBeginCondition(HasRecord, 1906)
	MisBeginAction(AddMission, 1907)
	MisBeginAction(GiveItem, 6321,1,4)
	MisCancelAction(ClearMission, 1907)
	MisCancelAction(TakeItem, 6321,1)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000129 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000129")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000129)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000130 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000130")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000130)
	MisResultCondition(AlwaysFailure)
	
------------------解毒剂--------------(结束)	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000127 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000127")
	DefineMission(6720, MISSCRIPT_MISSIONSCRIPT06_LUA_000127,1907, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000131")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000131)
	MisResultCondition(HasMission, 1907)
	MisResultCondition(NoRecord, 1907)
	MisResultCondition(HasItem, 6321,1)
	MisResultAction(ClearMission, 1907)
	MisResultAction(TakeItem, 6321,1)
	MisResultAction(ClearRecord, 1901)
	MisResultAction(ClearRecord, 1902)
	MisResultAction(ClearRecord, 1903)
	MisResultAction(ClearRecord, 1904)
	MisResultAction(ClearRecord, 1905)
	MisResultAction(ClearRecord, 1906)
	MisResultAction(AddItem_Mission2)
	MisResultAction(AddExp , 100000, 100000)		
	MisResultAction(AddMoney , 200000)
	

--------------------随从兑换宝箱-----------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000132 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000132")
	DefineMission(6721, MISSCRIPT_MISSIONSCRIPT06_LUA_000132,1908)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000133 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000133")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000133)
	MisBeginCondition(NoRecord, 1908)
	MisBeginCondition(NoMission,1908)
	MisBeginAction(AddMission, 1908)

	MisBeginAction(AddTrigger,19081, TE_GETITEM,6236, 5)
	MisBeginAction(AddTrigger,19082, TE_GETITEM,6237, 5)
	MisBeginAction(AddTrigger,19083, TE_GETITEM,6238, 5)
	MisBeginAction(AddTrigger,19084, TE_GETITEM,6239, 5)
	MisBeginAction(AddTrigger,19085, TE_GETITEM,6240, 5)

	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000134 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000134")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000134)

	MisNeed(MIS_NEED_ITEM, 6236, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 6237, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 6238, 5, 30, 5)
	MisNeed(MIS_NEED_ITEM, 6239, 5, 40, 5)
	MisNeed(MIS_NEED_ITEM, 6240, 5, 50, 5)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000135 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000135")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000135)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000136 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000136")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000136)
	MisResultCondition(HasMission, 1908)
	MisResultCondition(NoRecord, 1908)
	MisResultCondition(HasItem, 6236,5)
	MisResultCondition(HasItem, 6237,5)
	MisResultCondition(HasItem, 6238,5)
	MisResultCondition(HasItem, 6239,5)
	MisResultCondition(HasItem, 6240,5)
	MisResultAction(TakeItem, 6236,5)
	MisResultAction(TakeItem, 6237,5)
	MisResultAction(TakeItem, 6238,5)
	MisResultAction(TakeItem, 6239,5)
	MisResultAction(TakeItem, 6240,5)
	MisResultAction(ClearMission, 1908)
	MisResultAction(SetRecord, 1908)


	InitTrigger()
	TriggerCondition(1, IsItem, 6236)	
	TriggerAction(1, AddNextFlag, 1908, 10, 5)
	RegCurTrigger(19081)

	InitTrigger()
	TriggerCondition(1, IsItem, 6237)	
	TriggerAction(1, AddNextFlag, 1908, 20, 5)
	RegCurTrigger(19082)

	InitTrigger()
	TriggerCondition(1, IsItem, 6238)
	TriggerAction(1, AddNextFlag, 1908, 30, 5)
	RegCurTrigger(19083)

	InitTrigger()
	TriggerCondition(1, IsItem, 6239)	
	TriggerAction(1, AddNextFlag, 1908, 40, 5)
	RegCurTrigger(19084)

	InitTrigger()
	TriggerCondition(1, IsItem, 6240)	
	TriggerAction(1, AddNextFlag, 1908, 50, 5)
	RegCurTrigger(19085)


------------------------维尔傀儡娃娃------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000137")
	DefineMission( 6722, MISSCRIPT_MISSIONSCRIPT06_LUA_000137, 1909)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000138 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000138")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000138)
	MisBeginCondition(LvCheck, ">",99)
	MisBeginCondition( NoMission, 1909)
	MisBeginCondition(Get_Day_Mission3)
	MisBeginAction( AddMission, 1909)
	MisBeginAction( CreatBBBB, 1137)
	MisCancelAction( killBBBB)
	MisCancelAction(ClearMission, 1909)
	
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000139 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000139")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000139)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000140")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000140)
	MisResultCondition( AlwaysFailure )


------------------------维尔傀儡娃娃------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000137")
	DefineMission( 6723, MISSCRIPT_MISSIONSCRIPT06_LUA_000137, 1909, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT06_LUA_000141 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000141")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000141)
	MisResultCondition( HasMission, 1909)
	MisResultAction( CheckBBBB)
	MisResultAction( ClearMission, 1909)
	MisResultAction(AddExp , 240000, 240000)		
	MisResultAction(AddMoney , 30000)
	MisResultAction(AddItem_Mission3)

------------------------卡拉傀儡娃娃------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000142")
	DefineMission( 6724, MISSCRIPT_MISSIONSCRIPT06_LUA_000142, 1910)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000143 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000143")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000143)
	MisBeginCondition(LvCheck, ">",99)
	MisBeginCondition( NoMission, 1910)
	MisBeginCondition(Get_Day_Mission4)
	MisBeginAction( AddMission, 1910)
	MisBeginAction( CreatBBBB, 1138)
	MisCancelAction( killBBBB)
	MisCancelAction(ClearMission, 1910)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000144 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000144")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000144)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000140")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000140)
	MisResultCondition( AlwaysFailure )


------------------------卡拉傀儡娃娃------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000142")
	DefineMission( 6725, MISSCRIPT_MISSIONSCRIPT06_LUA_000142, 1910, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT06_LUA_000145 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000145")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000145)
	MisResultCondition( HasMission, 1910)
	MisResultAction( CheckBBBB)
	MisResultAction( ClearMission, 1910)
	MisResultAction(AddExp , 240000, 240000)		
	MisResultAction(AddMoney , 30000)
	MisResultAction(AddItem_Mission4)

------------------------黑龙情报员------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000146")
	DefineMission( 6726, MISSCRIPT_MISSIONSCRIPT06_LUA_000146, 1911)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000147")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000147)
	MisBeginCondition(LvCheck, ">",99)
	MisBeginCondition( NoMission, 1911)
	MisBeginCondition( NoMission, 1912)
	MisBeginCondition(Get_Day_Mission5)
	MisBeginAction( AddMission, 1911)
	MisBeginAction(GiveItem, 6322,1,4)
	MisBeginAction( CreatBBBB, 1139)
	MisCancelAction(ClearMission, 1911)
	MisCancelAction(TakeItem, 6322,1)
	MisCancelAction( killBBBB)

	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000148 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000148")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000148)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000149 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000149")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000149)
	MisResultCondition( AlwaysFailure )


------------------------黑龙情报员------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000146")
	DefineMission( 6727, MISSCRIPT_MISSIONSCRIPT06_LUA_000146, 1911, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT06_LUA_000150 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000150")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT06_LUA_000150)
	MisResultCondition( HasMission, 1911)
	MisResultAction( CheckBBBB)
	MisResultCondition(HasItem, 6322,1)
	MisResultAction(TakeItem, 6322, 1)
	MisResultAction( ClearMission, 1911)
	MisResultAction(AddExp , 400000, 400000)		
	MisResultAction(AddMoney , 30000)
	MisResultAction(AddItem_Mission5)

--------------------劫持情报-----------------
	MISSCRIPT_MISSIONSCRIPT06_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000151")
	DefineMission(6728, MISSCRIPT_MISSIONSCRIPT06_LUA_000151,1912)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000152")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000152)
	MisBeginCondition(LvCheck, ">",99)
	MisBeginCondition(NoRecord, 1912)
	MisBeginCondition(NoMission, 1911)
	MisBeginCondition(NoMission,1912)
	MisBeginAction(AddMission, 1912)
	MisCancelAction(ClearMission, 1912)

	MisBeginAction(AddTrigger,19121, TE_GETITEM,6322, 1)
	
	MISSCRIPT_MISSIONSCRIPT06_LUA_000153 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000153")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT06_LUA_000153)
	MisNeed(MIS_NEED_ITEM, 6322, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT06_LUA_000154 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000154")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000154)
	MISSCRIPT_MISSIONSCRIPT06_LUA_000155 = GetResString("MISSCRIPT_MISSIONSCRIPT06_LUA_000155")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT06_LUA_000155)
	MisResultCondition(HasMission, 1912)
	MisResultCondition(NoRecord, 1912)
	MisResultCondition(HasItem, 6322,1)
	MisResultAction(TakeItem, 6322,1)
	MisResultAction(ClearMission, 1912)
	MisResultAction(AddExp , 120000, 120000)		
	MisResultAction(AddMoney , 20000)

	InitTrigger()
	TriggerCondition(1, IsItem, 6322)	
	TriggerAction(1, AddNextFlag, 1912, 10, 5)
	RegCurTrigger(19121)
	-----------------------------------------罂粟花开-------------------抓捕王小虎---------------------------
	DefineMission(6890, "Capture the fearsome Wang Xiao Hu",2044)
	MisBeginTalk("<t>Everynight at 7:30, the event for capturing Wang Xiao Hu start. Then, the marquee will show the location of<rWang Xiao Hu>. <n><t> You can come to me to get quest at 7:10!")
	MisBeginCondition(NoMission, 2044)
	MisBeginCondition(checkWXHtime)
	MisBeginAction(AddMission, 2044)
	MisBeginCondition(Get_Day_Mission14)
	MisCancelAction(ClearMission, 2044)
	MisBeginAction(AddTrigger,20441, TE_GETITEM,7363, 1)
	MisNeed(MIS_NEED_ITEM, 7363, 1, 10, 1)
	MisResultTalk("<t>If you return the stolen item, I will reward you with a pirate medal; if not, you can abandon the quest")
	MisHelpTalk("<t>Lets hurry before someone else grab it!")
	--MisResultBagNeed(1)
	--MisResultCondition(HasFlag, 2037, 29)
	MisResultCondition(HasMission, 2044)
	MisResultCondition(HasItem, 7363, 1 )------判断任务完成，计数器标志位是否达到要求
	MisResultAction(TakeItem, 7363, 1 )
	MisResultAction(AddItem_Mission14)
	MisResultAction(ClearMission, 2044)
	MisResultAction(AddMoney,100000,100000)---给钱
	MisResultAction(Addsafe_exp , nil, 100000,nil)----p1按百分比加（可打大于1），p2按数值加，P3按等级加（提升玩家等级）
	InitTrigger()
	TriggerCondition(1, IsItem, 7363)	
	TriggerAction(1, AddNextFlag, 2044, 10, 1)
	RegCurTrigger(20441)
	-----------------------------------------罂粟花开----------------------------------------------
	--------------------------------支持世博任务---------------------------------
	DefineMission(6888, "Donate for EXPO",2051)
	MisBeginTalk("<t>Love EXPO, For You and Me; Be Polite, Be harmonic")
	--MisBeginCondition(LvCheck, ">",47)
	--MisBeginCondition(check_yourjob)
	MisBeginCondition(NoRecord, 2051)
	MisBeginCondition(NoMission, 2051)
	MisBeginAction(AddMission, 2051)
	MisBeginAction(ClearRecord, 2044)
	MisBeginAction(ClearRecord, 2045)
	MisBeginAction(ClearRecord, 2046)
	MisBeginAction(ClearRecord, 2047)
	MisBeginAction(ClearRecord, 2048)
	MisCancelAction(ClearMission, 2051)
	
	MisResultTalk("<t>Thanks for donating! You can go for the quest about new equipment of Lvl 55. You may ask Hotel Owner - Dust firstly.")
	MisHelpTalk("<t>It will charge you 10 Golds. Thanks!")
	MisResultCondition(HasMission, 2051)
	MisResultCondition(NoRecord, 2051)
	MisResultAction(TakeMoney, 10 )
	MisResultAction(SetRecord, 2051)
	MisResultAction(ClearMission, 2051)
	MisResultAction(Addsafe_exp , nil, 10000,nil)	
    --------------------------------支持世博任务---------------------------------	

	
	------------------55-----第一个手镯任务----------------
	DefineMission(6943, "Bar Owner's reward",2093)
	MisBeginTalk("<t>Hey, seems like you are pretty free. Help me out. If you do I'll give you a surprise. <n><t> Recently business is so good that I ran out of stock. Please help me collect the raw material: <r30 Orange Grass, 30 Rookie Boxeroo's Glove, 30 Snow Heart, 30 White Elven Fruit, 30 Black Elven Fruit>, this items can be found in <jDream City(296,494)> <bOrange Spirit Grass>, <jArgent City(1056,2921)><bBoxing Kangeroo> ,<jIciccle(1403,632)>< bSnowman>, <jIcicle(1403,632)> <bSnowman>, <jRegion of Demon(587,112)> <bCreepy White Spirit Cat>, <jRegion of Demon(587,112)> <bCreepy Black Spirit Cat>. <n><t> Come <jDream City(437,658)> find me after you have got it all")
	MisBeginCondition(LvCheck, ">",47)
	MisBeginCondition(HasRecord,2051)
	MisBeginCondition(check_yourjob)
	MisBeginCondition(NoRecord, 2093)
	MisBeginCondition(NoMission, 2093)
	MisBeginAction(AddMission, 2093)
	MisCancelAction(ClearMission, 2093)

	MisBeginAction(AddTrigger,20931, TE_GETITEM,7330, 30)
	MisBeginAction(AddTrigger,20932, TE_GETITEM,7331, 30)
	MisBeginAction(AddTrigger,20933, TE_GETITEM,7332, 30)
	MisBeginAction(AddTrigger,20934, TE_GETITEM,7333, 30)
	MisBeginAction(AddTrigger,20935, TE_GETITEM,7334, 30)
	
	--MisNeed(MIS_NEED_DESP, "杀死正在做[黑龙情报员]日常任务，身上携带有情报的其他玩家,将情报文件交给<j暗黑遗迹守护者(360,117)>。")
	MisNeed(MIS_NEED_ITEM, 7330, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 7331, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 7332, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 7333, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 7334, 30, 130, 30)

	MisResultTalk("<t>Thank you for your help~ As we have agreed, you will get what you deserved.")
	MisHelpTalk("<t>Come back soon, I won't ill-treat you with the rewards")
	MisResultBagNeed(1)
	MisResultCondition(HasMission, 2093)
	MisResultCondition(NoRecord, 2093)
	MisResultCondition(HasItem, 7330,30)
	MisResultCondition(HasItem, 7331,30)
	MisResultCondition(HasItem, 7332,30)
	MisResultCondition(HasItem, 7333,30)
	MisResultCondition(HasItem, 7334,30)
	MisResultAction(TakeItem, 7330,30)
	MisResultAction(TakeItem, 7331,30)
	MisResultAction(TakeItem, 7332,30)
	MisResultAction(TakeItem, 7333,30)
	MisResultAction(TakeItem, 7334,30)
	MisResultAction(ClearMission, 2093)
	MisResultAction(SetRecord, 2093)
	MisResultAction(GiveXinZhuangBei, 2093)
	MisResultAction(Addsafe_exp , nil, 100000,nil)		
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsItem, 7330)	
	TriggerAction(1, AddNextFlag, 2093, 10, 30)
	RegCurTrigger(20931)
	InitTrigger()
	TriggerCondition(1, IsItem, 7331)	
	TriggerAction(1, AddNextFlag, 2093, 40, 30)
	RegCurTrigger(20932)
	InitTrigger()
	TriggerCondition(1, IsItem, 7332)	
	TriggerAction(1, AddNextFlag, 2093, 70, 30)
	RegCurTrigger(20933)
	InitTrigger()
	TriggerCondition(2, IsItem, 7333)	
	TriggerAction(2, AddNextFlag, 2093, 100, 30)
	RegCurTrigger(20934)
	InitTrigger()
	TriggerCondition(2, IsItem, 7334)	
	TriggerAction(2, AddNextFlag, 2093, 130, 30)
	RegCurTrigger(20935)
	
	-------55-----第二个手镯任务------------
	DefineMission(6944, "Aunt Susan's Wish",2094)
	MisBeginTalk("<t>Hey kid, I have always love to cook some special food. But now I'm old and can't get special ingredients. Can you help me? I'll reward you after. <n><t> The list is: <r30 Ice Blue Grass, 30 Mad Boar Tooth, 30 Heart of Dexterity, 30 Fruit of Ice Dragon, 30 Gold Scorpion Venom>, this item can be found in <jDream City(354,491)> <bSnow Spirit Grass>, <jArgent City(865,2915)> <bWild Boar>, <jIcicicle(860,810)> <bSnow Spirit> ,<jForgotten Island(138,100)> <bBaby Icy Dragon>, <jRegion of Demon(628,282)> <bGolden Scorpion> . <n><t> Come <jDream City(404,639)> find me after you have everything.")
	MisBeginCondition(LvCheck, ">",47)
	MisBeginCondition(check_yourjob)
	MisBeginCondition(HasRecord, 2093)
	MisBeginCondition(NoRecord, 2094)
	MisBeginCondition(NoMission, 2094)
	MisBeginAction(AddMission, 2094)
	MisCancelAction(ClearMission, 2094)

	MisBeginAction(AddTrigger,20941, TE_GETITEM,7335, 30)
	MisBeginAction(AddTrigger,20942, TE_GETITEM,7336, 30)
	MisBeginAction(AddTrigger,20943, TE_GETITEM,7337, 30)
	MisBeginAction(AddTrigger,20944, TE_GETITEM,7338, 30)
	MisBeginAction(AddTrigger,20945, TE_GETITEM,7339, 30)
	
	--MisNeed(MIS_NEED_DESP, "杀死正在做[黑龙情报员]日常任务，身上携带有情报的其他玩家,将情报文件交给<j暗黑遗迹守护者(360,117)>。")
	MisNeed(MIS_NEED_ITEM, 7335, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 7336, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 7337, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 7338, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 7339, 30, 130, 30)

	MisResultTalk("<t>Thank you for your help~ As we have agreed, you will get what you deserved.")
	MisHelpTalk("<t>Come back soon, I won't ill-treat you with the rewards")
	MisResultBagNeed(1)
	MisResultCondition(HasMission, 2094)
	MisResultCondition(NoRecord, 2094)
	MisResultCondition(HasItem, 7335,30)
	MisResultCondition(HasItem, 7336,30)
	MisResultCondition(HasItem, 7337,30)
	MisResultCondition(HasItem, 7338,30)
	MisResultCondition(HasItem, 7339,30)
	MisResultAction(TakeItem, 7335,30)
	MisResultAction(TakeItem, 7336,30)
	MisResultAction(TakeItem, 7337,30)
	MisResultAction(TakeItem, 7338,30)
	MisResultAction(TakeItem, 7339,30)
	MisResultAction(ClearMission, 2094)
	MisResultAction(SetRecord, 2094)
	MisResultAction(GiveXinZhuangBei, 2094)
	MisResultAction(Addsafe_exp , nil, 100000,nil)		
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsItem, 7335)	
	TriggerAction(1, AddNextFlag, 2094, 10, 30)
	RegCurTrigger(20941)
	InitTrigger()
	TriggerCondition(1, IsItem, 7336)	
	TriggerAction(1, AddNextFlag, 2094, 40, 30)
	RegCurTrigger(20942)
	InitTrigger()
	TriggerCondition(1, IsItem, 7337)	
	TriggerAction(1, AddNextFlag, 2094, 70, 30)
	RegCurTrigger(20943)
	InitTrigger()
	TriggerCondition(2, IsItem, 7338)	
	TriggerAction(2, AddNextFlag, 2094, 100, 30)
	RegCurTrigger(20944)
	InitTrigger()
	TriggerCondition(2, IsItem, 7339)	
	TriggerAction(2, AddNextFlag, 2094, 130, 30)
	RegCurTrigger(20945)
	
	-------55-----护腕任务------------
	DefineMission(6945, "Red-Bearded Grandpa's Entrustment",2095)
	MisBeginTalk("<t>Hey kid, when I'm as you as you, I am the greatest pirate of the sea. Now that I'm old, I can only rest here. I wanted to eat something but I can hunt for it. Can you help me? The items are: <r30 Bright Red Fruit, 30 Unknown Smuggled Goods, 30 Mini Pig Tail, 30 Black Bobcat's Beard, 30 Gold Barbed Tail>. They can be found at <jDream City(411,494)> <bRed Spirit Grass>, <jArgent City(1570,2984)> <bSmuggler>, <jIcicle(1403,529)> <bMini Battle Pig>, <jRegion of Demons(587,112)> <bCreepy Spirit Cat>，<jRegion of Demons(628,282)> <Golden Scoprion>. <n><t> Come <jDream City(390,652)> and look for me after you got everything.")
	MisBeginCondition(LvCheck, ">",47)
	MisBeginCondition(check_yourjob)
	MisBeginCondition(HasRecord, 2094)
	MisBeginCondition(NoRecord, 2095)
	MisBeginCondition(NoMission, 2095)
	MisBeginAction(AddMission, 2095)
	MisCancelAction(ClearMission, 2095)

	MisBeginAction(AddTrigger,20951, TE_GETITEM,7340, 30)
	MisBeginAction(AddTrigger,20952, TE_GETITEM,7341, 30)
	MisBeginAction(AddTrigger,20953, TE_GETITEM,7342, 30)
	MisBeginAction(AddTrigger,20954, TE_GETITEM,7343, 30)
	MisBeginAction(AddTrigger,20955, TE_GETITEM,7344, 30)
	
	--MisNeed(MIS_NEED_DESP, "杀死正在做[黑龙情报员]日常任务，身上携带有情报的其他玩家,将情报文件交给<j暗黑遗迹守护者(360,117)>。")
	MisNeed(MIS_NEED_ITEM, 7340, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 7341, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 7342, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 7343, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 7344, 30, 130, 30)

	MisResultTalk("<t>Thank you for your help~ As we have agreed, you will get what you deserved.")
	MisHelpTalk("<t>Come back soon, I won't ill-treat you with the rewards")
	MisResultBagNeed(1)
	MisResultCondition(HasMission, 2095)
	MisResultCondition(NoRecord, 2095)
	MisResultCondition(HasItem, 7340,30)
	MisResultCondition(HasItem, 7341,30)
	MisResultCondition(HasItem, 7342,30)
	MisResultCondition(HasItem, 7343,30)
	MisResultCondition(HasItem, 7344,30)
	MisResultAction(TakeItem, 7340,30)
	MisResultAction(TakeItem, 7341,30)
	MisResultAction(TakeItem, 7342,30)
	MisResultAction(TakeItem, 7343,30)
	MisResultAction(TakeItem, 7344,30)
	MisResultAction(ClearMission, 2095)
	MisResultAction(SetRecord, 2095)
	MisResultAction(GiveXinZhuangBei, 2095)
	MisResultAction(Addsafe_exp , nil, 100000,nil)		
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsItem, 7340)	
	TriggerAction(1, AddNextFlag, 2095, 10, 30)
	RegCurTrigger(20951)
	InitTrigger()
	TriggerCondition(1, IsItem, 7341)	
	TriggerAction(1, AddNextFlag, 2095, 40, 30)
	RegCurTrigger(20952)
	InitTrigger()
	TriggerCondition(1, IsItem, 7342)	
	TriggerAction(1, AddNextFlag, 2095, 70, 30)
	RegCurTrigger(20953)
	InitTrigger()
	TriggerCondition(2, IsItem, 7343)	
	TriggerAction(2, AddNextFlag, 2095, 100, 30)
	RegCurTrigger(20954)
	InitTrigger()
	TriggerCondition(2, IsItem, 7344)	
	TriggerAction(2, AddNextFlag, 2095, 130, 30)
	RegCurTrigger(20955)
	-------65-----第一个手镯任务------------
	DefineMission(6946, "Olda's Request",2096)
	MisBeginTalk("<t>I'm troubled, I cannot sleep. Doctors told me only a special medicine can cure it. Can you help me get the ingredients? The items are: <r30 Yellow Juice,30 White Hair, 30 Heart of Giants, 30 Heart of Demons, 30 Golden Shell, 30 Dawn Feather>. You can find them at <jDream City(320,667)> <bYellow Spirit Grass>, <jArgent City(1261,2600)><bFlying Panda>, <jIcicle(2522,410)> <bHuge Snowman>, <jIcicle(2810,401)> <bSnow Demon Man>, <jRegion of Demons(628,282)> <bGolden Scorpion>, <jRegion of Demons(671,140)> <Dawn Owl>. <n><t> Come <jDream City(390,652)> and look for me after you got everything.")
	MisBeginCondition(LvCheck, ">",59)
	MisBeginCondition(check_yourjob)
	MisBeginCondition(NoRecord, 2096)
	MisBeginCondition(NoMission, 2096)
	MisBeginAction(AddMission, 2096)
	MisCancelAction(ClearMission, 2096)

	MisBeginAction(AddTrigger,20961, TE_GETITEM,7345, 30)
	MisBeginAction(AddTrigger,20962, TE_GETITEM,7346, 30)
	MisBeginAction(AddTrigger,20963, TE_GETITEM,7347, 30)
	MisBeginAction(AddTrigger,20964, TE_GETITEM,7348, 30)
	MisBeginAction(AddTrigger,20965, TE_GETITEM,7349, 30)
	MisBeginAction(AddTrigger,20966, TE_GETITEM,7350, 30)
	--MisNeed(MIS_NEED_DESP, "杀死正在做[黑龙情报员]日常任务，身上携带有情报的其他玩家,将情报文件交给<j暗黑遗迹守护者(360,117)>。")
	MisNeed(MIS_NEED_ITEM, 7345, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 7346, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 7347, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 7348, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 7349, 30, 130, 30)
	MisNeed(MIS_NEED_ITEM, 7350, 30, 160, 30)
	MisResultTalk("<t>Thank you for your help~ As we have agreed, you will get what you deserved.")
	MisHelpTalk("<t>Come back soon, I won't ill-treat you with the rewards")
	MisResultBagNeed(1)
	MisResultCondition(HasMission, 2096)
	MisResultCondition(NoRecord, 2096)
	MisResultCondition(HasItem, 7345,30)
	MisResultCondition(HasItem, 7346,30)
	MisResultCondition(HasItem, 7347,30)
	MisResultCondition(HasItem, 7348,30)
	MisResultCondition(HasItem, 7349,30)
	MisResultCondition(HasItem, 7350,30)
	MisResultAction(TakeItem, 7345,30)
	MisResultAction(TakeItem, 7346,30)
	MisResultAction(TakeItem, 7347,30)
	MisResultAction(TakeItem, 7348,30)
	MisResultAction(TakeItem, 7349,30)
	MisResultAction(TakeItem, 7350,30)
	MisResultAction(ClearMission, 2096)
	MisResultAction(SetRecord, 2096)
	MisResultAction(GiveXinZhuangBei, 2096)
	MisResultAction(Addsafe_exp , nil, 100000,nil)		
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsItem, 7345)	
	TriggerAction(1, AddNextFlag, 2096, 10, 30)
	RegCurTrigger(20961)
	InitTrigger()
	TriggerCondition(1, IsItem, 7346)	
	TriggerAction(1, AddNextFlag, 2096, 40, 30)
	RegCurTrigger(20962)
	InitTrigger()
	TriggerCondition(1, IsItem, 7347)	
	TriggerAction(1, AddNextFlag, 2096, 70, 30)
	RegCurTrigger(20963)
	InitTrigger()
	TriggerCondition(2, IsItem, 7348)	
	TriggerAction(2, AddNextFlag, 2096, 100, 30)
	RegCurTrigger(20964)
	InitTrigger()
	TriggerCondition(2, IsItem, 7349)	
	TriggerAction(2, AddNextFlag, 2096, 130, 30)
	RegCurTrigger(20965)
	InitTrigger()
	TriggerCondition(2, IsItem, 7350)	
	TriggerAction(2, AddNextFlag, 2096, 160, 30)
	RegCurTrigger(20966)
	
	-------65-----第二个手镯任务------------
	DefineMission(6947, "Alex's Wish",2097)
	MisBeginTalk("<t>Tell you a secret, I love to collect funny things. But as  lord I can't go out like others. Maybe you can help me collect? The items are: <r30 Blue Grass, 30 Unknown Fruit, 30 Broken Bow, 30 Heart of Slow, 30 Dawn Beak, 30 Shimizu Pig Toys>, they can be found at <jDream City(320,667)> <bViolet Spirit Grass>, <jArgent City(1261,2600)><bOwl>, <jIcicle(2522,410)> <bSkeletal Archer>, <jIcicle(2810,401)> <bSlow Snowman>, <jForgotten Island(628,282)> <bDawn Owl>, <jRegion of Demons(671,140)> <Shimizu Pig>. <n><t> Come <jDream City(390,652)> and look for me after you got everything.")
	MisBeginCondition(LvCheck, ">",59)
	MisBeginCondition(check_yourjob)
	MisBeginCondition(HasRecord, 2096)
	MisBeginCondition(NoRecord, 2097)
	MisBeginCondition(NoMission, 2097)
	MisBeginAction(AddMission, 2097)
	MisCancelAction(ClearMission, 2097)

	MisBeginAction(AddTrigger,20971, TE_GETITEM,7351, 30)
	MisBeginAction(AddTrigger,20972, TE_GETITEM,7352, 30)
	MisBeginAction(AddTrigger,20973, TE_GETITEM,7353, 30)
	MisBeginAction(AddTrigger,20974, TE_GETITEM,7354, 30)
	MisBeginAction(AddTrigger,20975, TE_GETITEM,7355, 30)
	MisBeginAction(AddTrigger,20976, TE_GETITEM,7356, 30)
	--MisNeed(MIS_NEED_DESP, "杀死正在做[黑龙情报员]日常任务，身上携带有情报的其他玩家,将情报文件交给<j暗黑遗迹守护者(360,117)>。")
	MisNeed(MIS_NEED_ITEM, 7351, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 7352, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 7353, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 7354, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 7355, 30, 130, 30)
	MisNeed(MIS_NEED_ITEM, 7356, 30, 160, 30)
	MisResultTalk("<t>Thank you for your help~ As we have agreed, you will get what you deserved.")
	MisHelpTalk("<t>Come back soon, I won't ill-treat you with the rewards")
	MisResultBagNeed(1)
	MisResultCondition(HasMission, 2097)
	MisResultCondition(NoRecord, 2097)
	MisResultCondition(HasItem, 7351,30)
	MisResultCondition(HasItem, 7352,30)
	MisResultCondition(HasItem, 7353,30)
	MisResultCondition(HasItem, 7354,30)
	MisResultCondition(HasItem, 7355,30)
	MisResultCondition(HasItem, 7356,30)
	MisResultAction(TakeItem, 7351,30)
	MisResultAction(TakeItem, 7352,30)
	MisResultAction(TakeItem, 7353,30)
	MisResultAction(TakeItem, 7354,30)
	MisResultAction(TakeItem, 7355,30)
	MisResultAction(TakeItem, 7356,30)
	MisResultAction(ClearMission, 2097)
	MisResultAction(SetRecord, 2097)
	MisResultAction(GiveXinZhuangBei, 2097)
	MisResultAction(Addsafe_exp , nil, 100000,nil)		
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsItem, 7351)	
	TriggerAction(1, AddNextFlag, 2097, 10, 30)
	RegCurTrigger(20971)
	InitTrigger()
	TriggerCondition(1, IsItem, 7352)	
	TriggerAction(1, AddNextFlag, 2097, 40, 30)
	RegCurTrigger(20972)
	InitTrigger()
	TriggerCondition(1, IsItem, 7353)	
	TriggerAction(1, AddNextFlag, 2097, 70, 30)
	RegCurTrigger(20973)
	InitTrigger()
	TriggerCondition(2, IsItem, 7354)	
	TriggerAction(2, AddNextFlag, 2097, 100, 30)
	RegCurTrigger(20974)
	InitTrigger()
	TriggerCondition(2, IsItem, 7355)	
	TriggerAction(2, AddNextFlag, 2097, 130, 30)
	RegCurTrigger(20975)
	InitTrigger()
	TriggerCondition(2, IsItem, 7356)	
	TriggerAction(2, AddNextFlag, 2097, 160, 30)
	RegCurTrigger(20976)
	
	-------65-----护腕任务------------
	DefineMission(6948, "Sheep's Hobby",2098)
	MisBeginTalk("<t>You are here means you have help a lot of people. I'll give you ~~<n><t> if you get me the following: <r30 Llama's Stamp, 30 Smelly Mud, 30 Fragments of Slow, 30 Heart of Terror, 30 Shimizu Pig Collections, 30 Demon Wolf Fang>, this item can be found at <jDream City(461,525)> <bLlama>, <jArgent City(886,2682)> <bMud Monster>, <jIcicle(2740,510)> <bSlow Snowman>, <jIcicle(3091,550)> <bScary Snowman>, <jForgotten Island(138,100)> <bFresh Water Pig>, <jForgotten Island(156,212)><Demon Wolf>. <n><t> Come <jDream City(366,568)> to find me")
	MisBeginCondition(LvCheck, ">",59)
	MisBeginCondition(check_yourjob)
	MisBeginCondition(HasRecord, 2097)
	MisBeginCondition(NoRecord, 2098)
	MisBeginCondition(NoMission, 2098)
	MisBeginAction(AddMission, 2098)
	MisCancelAction(ClearMission, 2098)

	MisBeginAction(AddTrigger,20981, TE_GETITEM,7357, 30)
	MisBeginAction(AddTrigger,20982, TE_GETITEM,7358, 30)
	MisBeginAction(AddTrigger,20983, TE_GETITEM,7359, 30)
	MisBeginAction(AddTrigger,20984, TE_GETITEM,7360, 30)
	MisBeginAction(AddTrigger,20985, TE_GETITEM,7361, 30)
	MisBeginAction(AddTrigger,20986, TE_GETITEM,7362, 30)
	--MisNeed(MIS_NEED_DESP, "杀死正在做[黑龙情报员]日常任务，身上携带有情报的其他玩家,将情报文件交给<j暗黑遗迹守护者(360,117)>。")
	MisNeed(MIS_NEED_ITEM, 7357, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 7358, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 7359, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 7360, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 7361, 30, 130, 30)
	MisNeed(MIS_NEED_ITEM, 7362, 30, 160, 30)
	MisResultTalk("<t>Thank you for your help~ As we have agreed, you will get what you deserved.")
	MisHelpTalk("<t>Come back soon, I won't ill-treat you with the rewards")
	MisResultBagNeed(1)
	MisResultCondition(HasMission, 2098)
	MisResultCondition(NoRecord, 2098)
	MisResultCondition(HasItem, 7357,30)
	MisResultCondition(HasItem, 7358,30)
	MisResultCondition(HasItem, 7359,30)
	MisResultCondition(HasItem, 7360,30)
	MisResultCondition(HasItem, 7361,30)
	MisResultCondition(HasItem, 7362,30)
	MisResultAction(TakeItem, 7357,30)
	MisResultAction(TakeItem, 7358,30)
	MisResultAction(TakeItem, 7359,30)
	MisResultAction(TakeItem, 7361,30)
	MisResultAction(TakeItem, 7362,30)
	MisResultAction(TakeItem, 7360,30)
	MisResultAction(ClearMission, 2098)
	MisResultAction(SetRecord, 2098)
	MisResultAction(GiveXinZhuangBei, 2098)
	MisResultAction(Addsafe_exp , nil, 100000,nil)		
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsItem, 7357)	
	TriggerAction(1, AddNextFlag, 2098, 10, 30)
	RegCurTrigger(20981)
	InitTrigger()
	TriggerCondition(1, IsItem, 7358)	
	TriggerAction(1, AddNextFlag, 2098, 40, 30)
	RegCurTrigger(20982)
	InitTrigger()
	TriggerCondition(1, IsItem, 7359)	
	TriggerAction(1, AddNextFlag, 2098, 70, 30)
	RegCurTrigger(20983)
	InitTrigger()
	TriggerCondition(2, IsItem, 7360)	
	TriggerAction(2, AddNextFlag, 2098, 100, 30)
	RegCurTrigger(20984)
	InitTrigger()
	TriggerCondition(2, IsItem, 7361)	
	TriggerAction(2, AddNextFlag, 2098, 130, 30)
	RegCurTrigger(20985)
	InitTrigger()
	TriggerCondition(2, IsItem, 7362)	
	TriggerAction(2, AddNextFlag, 2098, 160, 30)
	RegCurTrigger(20986)

		----------Alina------------星空走廊任务--------一切的基础，能量！
	DefineMission( 6883, "The foundation of all energy!", 2052 )
	
	MisBeginTalk( "<t>I would need some <bRed Energy Debris> to do some research and if you could help me, I would reward you with prizes in exchange.")
	MisBeginCondition(NoMission, 2052)
	MisBeginCondition(NoRecord, 2052)
	MisBeginAction(AddMission, 2052)
	MisBeginAction(AddTrigger, 20521, TE_GETITEM, 7516, 50 )
	MisCancelAction(ClearMission, 2052)

	MisNeed(MIS_NEED_DESP, "Help <jCard Master - Xun(112,449)> collect <b50 Red Energy Debris>.")	
	MisNeed(MIS_NEED_ITEM, 7516, 50, 10, 50)
	
	MisHelpTalk("<t>Hurry up! <bRed Energy Debris> is the key material for research.")
	MisResultTalk("<t>Thanks you very much. These are for your hard work.")
	MisResultCondition(NoRecord, 2052)
	MisResultCondition(HasMission, 2052)
	MisResultCondition(HasItem, 7516, 50)
	MisResultAction(TakeItem, 7516, 50 )
	MisResultAction(ClearMission, 2052)
	MisResultAction(SetRecord, 2052)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,7519,20,4)		------F级能量卡

	InitTrigger()
	TriggerCondition( 1, IsItem, 7516 )	
	TriggerAction( 1, AddNextFlag, 2052, 10, 50 )
	RegCurTrigger( 20521 )
	
	----------Alina------------星空走廊任务--------独特的技能卡
	DefineMission( 6884, "Unique Skill Card", 2053 )
	
	MisBeginTalk( "<t>This is the fruit of my research. Like to have one? Exchange using <bRed Energy Crystal> and <bRed Energy Debris> for it!")
	MisBeginCondition(HasRecord, 2052)
	MisBeginCondition(NoMission, 2053)
	MisBeginCondition(NoRecord, 2053)
	MisBeginAction(AddMission, 2053)
	MisBeginAction(AddTrigger, 20531, TE_GETITEM, 7517, 50 )
	MisBeginAction(AddTrigger, 20532, TE_GETITEM, 7516, 50 )
	MisCancelAction(ClearMission, 2053)

	MisNeed(MIS_NEED_DESP, "Help <jCard Master - Xun(112,449)> collect <b50Red Enery Crystal> and <b50 Red Energy Debris>.")	
	MisNeed(MIS_NEED_ITEM, 7517, 50, 10, 50)
	MisNeed(MIS_NEED_ITEM, 7516, 50, 60, 50)
	
	MisHelpTalk("<t>New research requires <bRed Energy Crystal> to carry on.")
	MisResultTalk("<t>Oh! Not bad. This is my secret skill card")
	MisResultCondition(NoRecord, 2053)
	MisResultCondition(HasMission, 2053)
	MisResultCondition(HasItem, 7517, 50)
	MisResultCondition(HasItem, 7516, 50)
	MisResultAction(TakeItem, 7517, 50 )
	MisResultAction(TakeItem, 7516, 50 )
	MisResultAction(ClearMission, 2053)
	MisResultAction(SetRecord, 2053)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,7526,1,4)	------F级附能斩技能卡

	InitTrigger()
	TriggerCondition( 1, IsItem, 7517 )	
	TriggerAction( 1, AddNextFlag, 2053, 10, 50 )
	RegCurTrigger( 20531 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 7516 )	
	TriggerAction( 1, AddNextFlag, 2053, 60, 50 )
	RegCurTrigger( 20532 )
	
	----------Alina-------------星空走廊任务--------时空旅行者
	DefineWorldMission( 6885, "Time Traveler", 2054 )
	
	MisBeginTalk( "<n><t>Requirement is not difficult. All you need is to bring me <b10 Red Energy Crystal>, which can be found somewhere near Alley of Starry Sky. Could be a certain monster drops it but I can't recall which. It shouldn't be hard for you to find it, right?")
	MisBeginCondition(NoMission, 2054)
	MisBeginCondition(NoRecord, 2054)
	MisBeginAction(AddMission, 2054)
	MisBeginAction(AddTrigger, 20541, TE_GETITEM, 7517, 10 )
	MisCancelAction(ClearMission, 2054)

	MisHelpTalk("<t>Go to Starry Sky Alley to look for it!")
	
	MisNeed(MIS_NEED_DESP, "Help <jTravel Agent - Miku(97,446)> collect <b10 Red Energy Crystal>.")	
	MisNeed(MIS_NEED_ITEM, 7517, 10, 10, 10)
	MisResultCondition(AlwaysFailure )
	
	----------------------星空走廊任务--------
	DefineMission( 6886, "Time Traveler", 2054, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	
	MisResultTalk("<t>Didn't expect you have collected <b10 Red Energy Crystal> at such a fast speed. As promised, these are for you. <n><t>Don't forget, <bF-Grade Production Card> can’t be used on E-Grade Skill Card. You need to look for Primary Tool Master to upgrade to <bE Grade Production Card Tool>.")
	MisResultCondition(NoRecord, 2054)
	MisResultCondition(HasMission, 2054)
	MisResultCondition(HasItem, 7517, 10)
	MisResultAction(TakeItem, 7517, 10 )
	MisResultAction(ClearMission, 2054)
	MisResultAction(SetRecord, 2054)
	MisResultBagNeed(2)
	MisResultAction(GiveItem,7518,1,4)	------F级量产型卡械
	MisResultAction(GiveItem,7519,20,4)	------F级能量卡

	InitTrigger()
	TriggerCondition( 1, IsItem, 7517 )	
	TriggerAction( 1, AddNextFlag, 2054, 10, 10 )
	RegCurTrigger( 20541 )
	
	
end
DuplicateMission001()
