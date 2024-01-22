--------------------------------------------------------------------------
--									--
--									--
--				MissionScript09.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading MissionScript09.lua" )


----------------------------铁人六项之一------------bragi（for 北美)----

	MISSCRIPT_MISSIONSCRIPT09_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000001")
	DefineMission( 6114, MISSCRIPT_MISSIONSCRIPT09_LUA_000001, 1444)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000002)
	MisBeginCondition( NoMission, 1444)
	MisBeginCondition( NoRecord, 1444)
	MisBeginAction( GiveItem, 3292, 1, 4)
	MisBeginAction( AddMission, 1444)
	MisCancelAction( ClearMission, 1444)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000003 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000003")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000003)
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000004")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000004)
	MisResultCondition( AlwaysFailure )

----------------------------铁人六项之一
	MISSCRIPT_MISSIONSCRIPT09_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000001")
	DefineMission( 6115, MISSCRIPT_MISSIONSCRIPT09_LUA_000001, 1444, COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT09_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000005")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000005)
	MisResultCondition( HasMission, 1444)
	MisResultCondition( HasItem, 3292, 1)
	MisResultCondition( NoRecord, 1444)
	MisResultAction( TakeItem, 3292, 1)
	MisResultAction( SetRecord, 1444)
	MisResultAction( AddExp_1)
	MisResultAction( ClearMission, 1444)

-----------------------------铁人六项之二

	MISSCRIPT_MISSIONSCRIPT09_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000006")
	DefineMission( 6116, MISSCRIPT_MISSIONSCRIPT09_LUA_000006, 1445)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000007")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000007)
	MisBeginCondition( CheckTime )
	MisBeginCondition( HasRecord, 1444)
	MisBeginCondition( NoMission, 1445)
	MisBeginCondition( NoRecord, 1445)
	MisBeginAction( AddMission, 1445)
	MisBeginAction(AddTrigger, 14451, TE_GETITEM, 3143, 1)
	MisCancelAction( ClearMission, 1445)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000008 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000008")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000008)
	MisNeed( MIS_NEED_ITEM, 3143, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000009")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000009)
	MisResultCondition( AlwaysFailure )

----------------------------铁人六项之二
	MISSCRIPT_MISSIONSCRIPT09_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000006")
	DefineMission( 6117, MISSCRIPT_MISSIONSCRIPT09_LUA_000006, 1445, COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT09_LUA_000010 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000010")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000010)
	MisResultCondition( HasMission, 1445)
	MisResultCondition( NoRecord, 1445)
	MisResultCondition( HasItem, 3143, 1)
	MisResultAction( SetRecord, 1445)
	MisResultAction( AddExp_1 )
	MisResultAction( ClearMission, 1445)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3143)	
	TriggerAction( 1, AddNextFlag, 1445, 10, 1 )
	RegCurTrigger( 14451 )

---------------------------铁人六项之三A
	MISSCRIPT_MISSIONSCRIPT09_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000011")
	DefineMission( 6118, MISSCRIPT_MISSIONSCRIPT09_LUA_000011, 1446)
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000012")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000012)
	MisBeginCondition( HasRecord, 1445)
	MisBeginCondition( NoMission, 1446)
	MisBeginCondition( NoRecord, 1446)
	MisBeginCondition( NoRecord, 1447)
	MisBeginCondition( LvCheck, "<", 40)
	MisBeginAction( AddMission, 1446)
	MisBeginAction( AddTrigger, 14461, TE_KILL, 299, 20 )
	MisCancelAction( ClearMission, 1446)
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000013")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000013)
	MisNeed( MIS_NEED_KILL, 299, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000014")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000014)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000015 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000015")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000015)
	MisResultCondition( HasMission, 1446)
	MisResultCondition( NoRecord, 1446)
	MisResultCondition( HasFlag, 1446, 29)
	MisResultAction( SetRecord, 1446)
	MisResultAction( SetRecord, 1447)
	MisResultAction( ClearMission, 1446)
	MisResultAction( AddExp, 13000, 13000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 299)	
	TriggerAction( 1, AddNextFlag, 1446, 10, 20 )
	RegCurTrigger( 14461 )

----------------------------铁人三项之三B
	MISSCRIPT_MISSIONSCRIPT09_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000011")
	DefineMission( 6119, MISSCRIPT_MISSIONSCRIPT09_LUA_000011, 1448)
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000012")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000012)
	MisBeginCondition( HasRecord, 1445)
	MisBeginCondition( NoMission, 1447)
	MisBeginCondition( NoRecord, 1447)
	MisBeginCondition( NoRecord, 1448)
	MisBeginCondition( LvCheck, ">", 39)
	MisBeginAction( AddMission, 1448)
	MisBeginAction( AddTrigger, 14481, TE_KILL, 37, 20 )
	MisCancelAction( ClearMission, 1448)
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000016 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000016")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000016)
	MisNeed( MIS_NEED_KILL, 37, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000014")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000014)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000017")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000017)
	MisResultCondition( HasMission, 1448)
	MisResultCondition( NoRecord, 1448)
	MisResultCondition( HasFlag, 1448, 29)
	MisResultAction( SetRecord, 1448)
	MisResultAction( SetRecord, 1447)
	MisResultAction( ClearMission, 1448)
	MisResultAction( AddExp_3)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 37)	
	TriggerAction( 1, AddNextFlag, 1448, 10, 20 )
	RegCurTrigger( 14481 )

----------------------------------铁人六项之四
	MISSCRIPT_MISSIONSCRIPT09_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000018")
	DefineMission( 6120, MISSCRIPT_MISSIONSCRIPT09_LUA_000018, 1449)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000019")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000019)
	MisBeginCondition( HasRecord, 1447)
	MisBeginCondition( NoMission, 1449)
	MisBeginCondition( NoRecord, 1449)
	MisBeginAction( AddMission, 1449)
	MisBeginAction(AddTrigger, 14491, TE_GETITEM, 4543, 10 )
	MisBeginAction(AddTrigger, 14492, TE_GETITEM, 4545, 10 )
	MisCancelAction( ClearMission, 1449)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000020 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000020")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000020)
	MisNeed( MIS_NEED_ITEM, 4543, 10, 10, 10)
	MisNeed( MIS_NEED_ITEM, 4545, 10, 20, 10)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000021 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000021")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000021)
	MisResultCondition( AlwaysFailure )

---------------------------------铁人六项之四
	MISSCRIPT_MISSIONSCRIPT09_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000018")
	DefineMission( 6121, MISSCRIPT_MISSIONSCRIPT09_LUA_000018, 1449, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT09_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000022")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000022)
	MisResultCondition( HasMission, 1449)
	MisResultCondition( NoRecord, 1449)
	MisResultCondition( HasItem, 4543, 10)
	MisResultCondition( HasItem, 4545, 10)
	MisResultAction( TakeItem, 4543, 10)
	MisResultAction( TakeItem, 4545, 10)
	MisResultAction( SetRecord, 1449)
	MisResultAction( ClearMission, 1449)
	MisResultAction( AddExp_4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4543)	
	TriggerAction( 1, AddNextFlag, 1449, 10, 10 )
	RegCurTrigger( 14491 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4545)	
	TriggerAction( 1, AddNextFlag, 1449, 20, 10 )
	RegCurTrigger( 14492 )


-----------------------------------铁人六项之五
	MISSCRIPT_MISSIONSCRIPT09_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000023")
	DefineMission( 6122, MISSCRIPT_MISSIONSCRIPT09_LUA_000023, 1450)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000024 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000024")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000024)
	MisBeginCondition( HasRecord, 1449)
	MisBeginCondition( NoMission, 1450)
	MisBeginCondition( NoRecord, 1450)
	MisBeginAction( AddMission, 1450)
	MisBeginAction(AddTrigger, 14501, TE_GETITEM, 3363, 2 )
	MisCancelAction( ClearMission, 1450)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000025")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000025)
	MisNeed( MIS_NEED_ITEM, 3363, 2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000026 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000026")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000026)
	MisResultCondition( AlwaysFailure )

-----------------------------------铁人六项之五
	MISSCRIPT_MISSIONSCRIPT09_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000023")
	DefineMission( 6123, MISSCRIPT_MISSIONSCRIPT09_LUA_000023, 1450, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000027")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000027)
	MisResultCondition( HasMission, 1450)
	MisResultCondition( NoRecord, 1450)
	MisResultCondition( HasItem, 3363, 2)
	MisResultAction( TakeItem, 3363, 2)
	MisResultAction( SetRecord, 1450)
	MisResultAction( ClearMission, 1450)
	MisResultAction( AddExp_5)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3363)	
	TriggerAction( 1, AddNextFlag, 1450, 10, 2 )
	RegCurTrigger( 14501 )

-----------------------------------铁人六项之六
	MISSCRIPT_MISSIONSCRIPT09_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000028")
	DefineMission( 6124, MISSCRIPT_MISSIONSCRIPT09_LUA_000028, 1451)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000029 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000029")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000029)
	MisBeginCondition( HasRecord, 1450)
	MisBeginCondition( NoMission, 1451)
	MisBeginCondition( NoRecord, 1451)
	MisBeginAction( AddMission, 1451)
	MisCancelAction( ClearMission, 1451)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000030 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000030")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT09_LUA_000030)

	MisResultCondition( AlwaysFailure )
-----------------------------------铁人六项结束

-----------------------------------------------------猪光宝气---------马来西亚

       MISSCRIPT_MISSIONSCRIPT09_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000031")
       DefineMission(6126,MISSCRIPT_MISSIONSCRIPT09_LUA_000031,1452)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000032 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000032")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000032)
	MisBeginCondition(NoMission, 1452)
	MisBeginCondition(NoRecord,1452)
	MisBeginAction(AddMission,1452)
	MisBeginAction(AddTrigger, 14521, TE_GETITEM, 4325, 5)
	MisBeginAction(AddTrigger, 14522, TE_GETITEM, 1680, 5)
	MisBeginAction(AddTrigger, 14523, TE_GETITEM, 4433, 5)
	MisBeginAction(AddTrigger, 14524, TE_GETITEM, 4357, 5)
	MisBeginAction(AddTrigger, 14525, TE_GETITEM, 4461, 40)
	MisBeginAction(AddTrigger, 14526, TE_GETITEM, 4462, 40)


	MisCancelAction(ClearMission, 1452)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000033 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000033")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000033)
	MisNeed(MIS_NEED_ITEM, 4325, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 1680, 5, 15, 5)
	MisNeed(MIS_NEED_ITEM, 4433, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 4357, 5, 25, 5)
	MisNeed(MIS_NEED_ITEM, 4461, 40, 30, 40)
	MisNeed(MIS_NEED_ITEM, 4462, 40, 70, 40)

	
	
	MISSCRIPT_MISSIONSCRIPT09_LUA_000034 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000034")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000034)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000035 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000035")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000035)

	MisResultCondition(HasMission, 1452)
	MisResultCondition(NoRecord,1452)
	MisResultCondition(HasItem, 4325, 5)
	MisResultCondition(HasItem, 1680, 5)
	MisResultCondition(HasItem, 4433, 5)
	MisResultCondition(HasItem, 4357, 5)
	MisResultCondition(HasItem, 4461, 40)
	MisResultCondition(HasItem, 4462, 40)

	
	
	MisResultAction(TakeItem, 4325, 5 )
	MisResultAction(TakeItem, 1680, 5 )
	MisResultAction(TakeItem, 4433, 5 )
	MisResultAction(TakeItem, 4357, 5 )
	MisResultAction(TakeItem, 4461, 40 )
	MisResultAction(TakeItem, 4462, 40 )

	
	
	MisResultAction(GiveItem, 2909,1,4)------------给幸运猪宝箱
	MisResultAction(ClearMission, 1452)
	MisResultAction(SetRecord, 1452)
	MisResultAction(ClearRecord, 1452)---------------可以反复接
	MisResultBagNeed(1)
	


	InitTrigger()
	TriggerCondition( 1, IsItem, 4325)	
	TriggerAction( 1, AddNextFlag, 1452, 10, 5 )
	RegCurTrigger( 14521 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1680)	
	TriggerAction( 1, AddNextFlag, 1452, 15, 5 )
	RegCurTrigger( 14522 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4433)	
	TriggerAction( 1, AddNextFlag, 1452, 20, 5 )
	RegCurTrigger( 14523 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4357)	
	TriggerAction( 1, AddNextFlag, 1452, 25, 5 )
	RegCurTrigger( 14524 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4461)	
	TriggerAction( 1, AddNextFlag, 1452, 30, 40 )
	RegCurTrigger( 14525 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4462)	
	TriggerAction( 1, AddNextFlag, 1452, 70, 40 )
	RegCurTrigger( 14526 )
	
	----------------------------------马来西亚-------拥抱小熊活动（闯5关）----------之第一关

	------------------------------活动NPC---------白银城医护小姐岚岚(2244,2770)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000036 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000036")
	DefineMission(5868,MISSCRIPT_MISSIONSCRIPT09_LUA_000036,1350)

        MISSCRIPT_MISSIONSCRIPT09_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000037")
        MisBeginTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000037)
	MisBeginCondition(NoMission, 1350)
	MisBeginCondition(NoRecord, 1350)
	MisBeginCondition(LvCheck, ">",19)
	MisBeginAction(AddMission, 1350)
	MisBeginAction(AddTrigger, 13501, TE_KILL, 258, 20)


	MISSCRIPT_MISSIONSCRIPT09_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000038")
	MisCancelAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT09_LUA_000038)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000039 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000039")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000039)
	MisNeed(MIS_NEED_KILL, 258, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000040 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000040")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000040)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000041 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000041")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000041)


	MisResultCondition(HasMission, 1350)
	MisResultCondition(NoRecord, 1350)
	MisResultCondition(HasFlag, 1350, 29)


	MisResultAction(ClearMission, 1350)
	MisResultAction(SetRecord, 1350)


	InitTrigger()
	TriggerCondition(1, IsMonster, 258)
	TriggerAction(1, AddNextFlag, 1350, 10, 20)
	RegCurTrigger( 13501)


	----------------------------------马来西亚-------拥抱小熊活动（闯5关）----------之第二关

	------------------------------活动NPC---------白银城居民·玛格丽特(2281,2745)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000042")
	DefineMission(5869,MISSCRIPT_MISSIONSCRIPT09_LUA_000042, 1351)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000043 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000043")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000043)
	MisBeginCondition(NoMission, 1351)
	MisBeginCondition(NoRecord, 1351)
	MisBeginCondition(HasRecord, 1350)
	MisBeginAction(AddMission, 1351)
	MisBeginAction(AddTrigger, 13511, TE_KILL, 189, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000038")
	MisCancelAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT09_LUA_000038)


	MISSCRIPT_MISSIONSCRIPT09_LUA_000044 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000044")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000044)
	MisNeed(MIS_NEED_KILL, 189, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000045")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000045)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000046")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000046)

	MisResultCondition(HasMission, 1351)
	MisResultCondition(NoRecord, 1351)
	MisResultCondition(HasFlag, 1351, 29)


	
	MisResultAction(ClearMission, 1351)
	MisResultAction(SetRecord, 1351)

	InitTrigger()
	TriggerCondition(1, IsMonster, 189)
	TriggerAction(1, AddNextFlag, 1351, 10, 20)
	RegCurTrigger( 13511 )


	----------------------------------马来西亚-------拥抱小熊活动（闯5关）----------之第三关

	------------------------------活动NPC---------冰狼堡商會會長．艾立克(1294,498)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000047")
	DefineMission(5870, MISSCRIPT_MISSIONSCRIPT09_LUA_000047, 1352)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000048 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000048")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000048)
	MisBeginCondition(NoMission, 1352)
	MisBeginCondition(NoRecord, 1352)
	MisBeginCondition(HasRecord, 1351)
	MisBeginAction(AddMission, 1352)
	MisBeginAction(AddTrigger, 13521, TE_KILL, 142, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000038")
	MisCancelAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT09_LUA_000038)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000049 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000049")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000049)
	MisNeed(MIS_NEED_KILL, 142, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000050")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000050)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000051")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000051)

	MisResultCondition(HasMission, 1352)
	MisResultCondition(NoRecord, 1352)
	MisResultCondition(HasFlag, 1352, 29)


	MisResultAction(ClearMission, 1352)
	MisResultAction(SetRecord, 1352)

	InitTrigger()
	TriggerCondition(1, IsMonster, 142)
	TriggerAction(1, AddNextFlag, 1352, 10, 20)
	RegCurTrigger( 13521 )


	----------------------------------马来西亚-------拥抱小熊活动（闯5关）----------之第四关

	------------------------------活动NPC---------海盜．德克(792,3670)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000052 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000052")
	DefineMission(5871, MISSCRIPT_MISSIONSCRIPT09_LUA_000052, 1353)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000053 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000053")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000053)

	MisBeginCondition(NoMission, 1353)
	MisBeginCondition(NoRecord, 1353)
	MisBeginCondition(HasRecord, 1352)
	MisBeginAction(AddMission, 1353)
	MisBeginAction(AddTrigger, 13531, TE_KILL, 259, 15)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000038")
	MisCancelAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT09_LUA_000038)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000054 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000054")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000054)
	MisNeed(MIS_NEED_KILL, 259, 15, 10, 15)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000055")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000055)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000056 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000056")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000056)

	MisResultCondition(HasMission, 1353)
	MisResultCondition(NoRecord, 1353)
	MisResultCondition(HasFlag, 1353, 24)


	MisResultAction(ClearMission, 1353)
	MisResultAction(SetRecord, 1353)

	InitTrigger()
	TriggerCondition(1, IsMonster, 259)
	TriggerAction(1, AddNextFlag, 1353, 10, 15)
	RegCurTrigger( 13531 )


	----------------------------------马来西亚-------拥抱小熊活动（闯5关）----------之第五关

	------------------------------活动NPC---------冰狼堡劍士．雷歐(1365,570)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000057")
	DefineMission(5872, MISSCRIPT_MISSIONSCRIPT09_LUA_000057, 1354)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000058 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000058")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000058)

	MisBeginCondition(NoMission, 1354)
	MisBeginCondition(NoRecord, 1354)
	MisBeginCondition(HasRecord, 1353)
	MisBeginAction(AddMission, 1354)
	MisBeginAction(AddTrigger, 13541, TE_KILL, 504, 10)
	MisBeginAction(AddTrigger, 13542, TE_GETITEM, 4824, 1)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000038")
	MisCancelAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT09_LUA_000038)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000059 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000059")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT09_LUA_000059)
	MisNeed(MIS_NEED_KILL, 504, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 4824, 1, 20, 1)

	MISSCRIPT_MISSIONSCRIPT09_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000060")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000060)
	MISSCRIPT_MISSIONSCRIPT09_LUA_000061 = GetResString("MISSCRIPT_MISSIONSCRIPT09_LUA_000061")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT09_LUA_000061)

	MisResultCondition(HasMission, 1354)
	MisResultCondition(NoRecord, 1354)
	MisResultCondition(HasFlag, 1354, 19)
	MisResultCondition(HasItem, 4824, 1)


	MisResultAction(ClearMission, 1354)
	MisResultAction(SetRecord, 1354)
	MisResultAction(ClearRecord, 1354)
	MisResultAction(ClearRecord, 1353)
	MisResultAction(ClearRecord, 1352)
	MisResultAction(ClearRecord, 1351)                          ----------------清空所有的任务可重复接
	MisResultAction(ClearRecord, 1350)
	MisResultAction(TakeItem, 4824,1)
	MisResultAction(GiveItem, 144, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsMonster, 504)
	TriggerAction(1, AddNextFlag, 1354, 10, 10)
	RegCurTrigger( 13541 )

	InitTrigger()
	TriggerCondition(1, IsItem, 4824)
	TriggerAction(1, AddNextFlag, 1354, 20, 1)
	RegCurTrigger( 13542 )

	-------------------------------------------kokora-----------------------------------------------
