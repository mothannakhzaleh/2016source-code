--------------------------------------------------------------------------
--									--
--									--
--				MissionScript07.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading MissionScript07.lua" )


 ---------------------------------------------宠宠总动员(1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000001")
	DefineMission( 900, MISSCRIPT_MISSIONSCRIPT07_LUA_000001, 900)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000002)
	MisBeginCondition(LvCheck, ">", 59 )
	MisBeginCondition(HasItem, 0844, 1)
	MisBeginCondition(NoMission, 900)
	MisBeginAction(AddMission, 900)
	MisBeginAction(AddTrigger, 9001, TE_KILL, 748, 10 )
	MisCancelAction(ClearMission, 900)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000003 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000003")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000003)	
	MisNeed(MIS_NEED_KILL, 748, 10, 10, 10)
	 
	MISSCRIPT_MISSIONSCRIPT07_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000004")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000004)	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000005")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000005)
	MisResultCondition(HasMission, 900)
	MisResultCondition(HasFlag, 900, 19 )
	MisResultCondition(HasItem,0844,1)
	MisResultAction(TakeItem, 0844,1)
	MisResultAction(ClearMission,900)
	MisResultAction(GiveItem, 1852, 1, 4)
	MisResultBagNeed(1)
		
	InitTrigger() 
	TriggerCondition( 1, IsMonster, 748 )	
	TriggerAction( 1, AddNextFlag, 900, 10, 10 )
	RegCurTrigger(9001)



	-------------------------------------------------宠宠总动员(2)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000001")
	DefineMission(901,MISSCRIPT_MISSIONSCRIPT07_LUA_000001,901)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000006")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000006)

	MisBeginCondition(LvCheck, "<", 60 )
	MisBeginCondition(HasItem, 0844, 1)
	MisBeginCondition(NoMission,901)
	MisBeginAction(AddMission, 901) 
	MisBeginAction(AddTrigger, 9011, TE_KILL, 103, 20)
	MisBeginAction(AddTrigger, 9012, TE_KILL, 70, 20)
	MisBeginAction(AddTrigger, 9013, TE_KILL, 253, 10)
	MisBeginAction(AddTrigger, 9014, TE_KILL, 85, 10)
	MisBeginAction(AddTrigger, 9015, TE_KILL, 76, 10)
	MisCancelAction(ClearMission, 901)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000007")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000007)
	MisNeed(MIS_NEED_KILL, 103, 20, 10, 20)
	MisNeed(MIS_NEED_KILL, 70, 20, 30, 20)
	MisNeed(MIS_NEED_KILL, 253, 10, 50, 10)
	MisNeed(MIS_NEED_KILL, 85, 10, 60, 10)
	MisNeed(MIS_NEED_KILL, 76, 10, 70, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000008 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000008")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000008)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000005")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000005)
	MisResultCondition(HasMission, 901)
	MisResultCondition(HasFlag, 901, 29)
	MisResultCondition(HasFlag, 901, 49)
	MisResultCondition(HasFlag, 901, 59)
	MisResultCondition(HasFlag, 901, 69)
	MisResultCondition(HasFlag, 901, 79)
	MisResultCondition(HasItem, 0844, 1)
	MisResultAction(TakeItem, 0844, 1)
	MisResultAction(ClearMission, 901)
	MisResultAction(GiveItem, 1852, 1, 4)
	MisResultBagNeed(1) 

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 103 )	
	TriggerAction( 1, AddNextFlag, 901, 10, 20 )
	RegCurTrigger(9011)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 70 )	
	TriggerAction( 1, AddNextFlag, 901, 30, 20 )
	RegCurTrigger(9012)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 253 )	
	TriggerAction( 1, AddNextFlag, 901, 50, 10 )
	RegCurTrigger(9013)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 85 )	
	TriggerAction( 1, AddNextFlag, 901, 60, 10 )
	RegCurTrigger(9014)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 76 )	
	TriggerAction( 1, AddNextFlag, 901, 70, 10 )
	RegCurTrigger(9015)


	-------------------------------------------------端午佳节吃粽子 雄黄艾草辟百邪
	MISSCRIPT_MISSIONSCRIPT07_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000009")
	DefineMission( 902, MISSCRIPT_MISSIONSCRIPT07_LUA_000009, 902)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000010 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000010")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000010)

	MisBeginCondition(LvCheck, ">",15  )
	MisBeginCondition(NoMission,902)
	MisBeginCondition(NoRecord,902)
	MisBeginAction(AddMission,902)
	MisBeginAction(AddTrigger, 9021, TE_GETITEM, 3116, 10 )		--精灵果
	MisBeginAction(AddTrigger, 9022, TE_GETITEM, 3131, 10 )		--奇异果实
	MisBeginAction(AddTrigger, 9023, TE_GETITEM, 4419, 5 )		--坏掉的蜂蜜
	MisCancelAction(ClearMission, 902)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000011")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000011)
	MisNeed(MIS_NEED_ITEM, 3116, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 3131, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 4419, 5, 30, 5)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000012")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000012)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000013")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000013)
	MisResultCondition(HasMission, 902)
	MisResultCondition(NoRecord,902)
	MisResultCondition(HasItem, 3116, 10)
	MisResultCondition(HasItem, 3131, 10 )
	MisResultCondition(HasItem, 4419, 5 )
	MisResultAction(TakeItem, 3116, 10 )
	MisResultAction(TakeItem, 3131, 10 )
	MisResultAction(TakeItem, 4419, 5 )
	MisResultAction(ClearMission, 902)
	MisResultAction(SetRecord, 902 )
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 902, 10, 10 )
	RegCurTrigger( 9021 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3131)	
	TriggerAction( 1, AddNextFlag, 902, 20, 10 )
	RegCurTrigger( 9022 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4419)	
	TriggerAction( 1, AddNextFlag, 902, 30, 5 )
	RegCurTrigger( 9023 )

	-------------------------------------------------- 端午佳节吃粽子 雄黄艾草辟百邪
	MISSCRIPT_MISSIONSCRIPT07_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000009")
	DefineMission( 903, MISSCRIPT_MISSIONSCRIPT07_LUA_000009, 903)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000014")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000014)
	MisBeginCondition(NoMission,902)
	MisBeginCondition(NoMission,903)
	MisBeginCondition(HasRecord,902)
	MisBeginCondition(NoRecord,903)
	MisBeginAction(AddMission,903)
	MisBeginAction(AddTrigger, 9031, TE_GETITEM, 1779, 10 )		--药瓶 
	MisBeginAction(AddTrigger, 9032, TE_GETITEM, 1584, 20 )		--有毒的刺 
	MisBeginAction(AddTrigger, 9033, TE_GETITEM, 1650, 10 )		--有疗效的水
	MisCancelAction(ClearMission, 903)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000015 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000015")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000015)
	MisNeed(MIS_NEED_ITEM, 1779, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 1584, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 1650, 10, 40, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000016 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000016")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000016)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000017)
	MisResultCondition(HasMission, 903)
	MisResultCondition(NoRecord,903)
	MisResultCondition(HasItem, 1779, 10)
	MisResultCondition(HasItem, 1584, 20 )
	MisResultCondition(HasItem, 1650, 10 )
	MisResultAction(TakeItem, 1779, 10 )
	MisResultAction(TakeItem, 1584, 20 )
	MisResultAction(TakeItem, 1650, 10 )
	MisResultAction(ClearMission, 903)
	MisResultAction(SetRecord, 903 )


	InitTrigger()
	TriggerCondition( 1, IsItem, 1779)	
	TriggerAction( 1, AddNextFlag, 903, 10, 10 )
	RegCurTrigger( 9031 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1584)	
	TriggerAction( 1, AddNextFlag, 903, 20, 20 )
	RegCurTrigger( 9032 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1650)	
	TriggerAction( 1, AddNextFlag, 903, 40, 10 )
	RegCurTrigger( 9033 )


-------------------------------------------------- 端午佳节吃粽子 雄黄艾草辟百邪
	MISSCRIPT_MISSIONSCRIPT07_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000009")
	DefineMission( 904, MISSCRIPT_MISSIONSCRIPT07_LUA_000009, 904)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000018")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000018)

	MisBeginCondition(NoMission,904)
	MisBeginCondition(NoRecord,904)
	MisBeginCondition(HasRecord,903)
	MisBeginAction(AddMission,904)
	MisBeginAction(AddTrigger, 9041, TE_GETITEM, 3129, 5 )		--药用草叶
	MisBeginAction(AddTrigger, 9042, TE_GETITEM, 1681, 5 )		--眼泪
	MisCancelAction(ClearMission, 904)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000019")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000019)
	MisNeed(MIS_NEED_ITEM, 3129, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 1681, 5, 20, 5)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000020 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000020")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000020)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000021 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000021")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000021)
	MisResultCondition(HasMission, 904)
	MisResultCondition(NoRecord,904)
	MisResultCondition(HasItem, 3129, 5)
	MisResultCondition(HasItem, 1681, 5 )
	MisResultAction(TakeItem, 3129, 5 )
	MisResultAction(TakeItem, 1681, 5 )
	MisResultAction(GiveItem, 263, 3, 4)
	MisResultAction(GiveItem, 264, 3, 4)
	MisResultAction(GiveItem, 265, 3 ,4)
	MisResultAction(ClearMission, 904)
	MisResultAction(SetRecord,  904 )
	MisResultBagNeed(3)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3129)	
	TriggerAction( 1, AddNextFlag, 904, 10, 5 )
	RegCurTrigger( 9041 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1681)	
	TriggerAction( 1, AddNextFlag, 904, 20, 5 )
	 RegCurTrigger( 9042 )
	 
  -------------------------------------------------- 海盗王的生日
	MISSCRIPT_MISSIONSCRIPT07_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000022")
	DefineMission( 905, MISSCRIPT_MISSIONSCRIPT07_LUA_000022, 905)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000023")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000023)
	MisBeginCondition(NoMission,905)
	MisBeginCondition(HasItem, 1097, 1 )
	MisBeginCondition(NoRecord,905)
	MisBeginAction(AddMission,905)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000024 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000024")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000024)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000025")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000025)
	
	MisResultCondition(AlwaysFailure )


	 -------------------------------------------------- 海盗王的生日
	MISSCRIPT_MISSIONSCRIPT07_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000022")
	DefineMission ( 906, MISSCRIPT_MISSIONSCRIPT07_LUA_000022, 905,COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000026 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000026")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000026)
	MisResultCondition(HasMission,905)
	MisResultCondition(HasItem, 1097, 1 )
	MisResultAction(ClearMission, 905 )
	MisResultAction(TakeItem, 1097, 1 )
	MisResultAction(GiveItem, 3338, 1, 4 )
	MisResultAction(SetRecord, 905 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)	

	-------------------------------寻找遗失的爱情之鱼儿寻找花瓣
	MISSCRIPT_MISSIONSCRIPT07_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000027")
	DefineMission( 907, MISSCRIPT_MISSIONSCRIPT07_LUA_000027, 906)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000028")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000028)
	MisBeginCondition(NoRecord, 913 )
	MisBeginCondition(NoMission, 906 )
	MisBeginAction(AddMission, 906 )
	MisCancelAction(ClearMission, 906)
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_000029 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000029")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000029)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000030 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000030")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000030)
	MisResultCondition(AlwaysFailure )

	---------------------------------------寻找遗失的爱情之鱼儿寻找花瓣

	MISSCRIPT_MISSIONSCRIPT07_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000027")
	DefineMission(908,MISSCRIPT_MISSIONSCRIPT07_LUA_000027,906,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000031")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000031)
	MisResultCondition(HasMission, 906)
	MisBeginCondition(NoRecord, 913)
	MisResultAction(ClearMission, 906)
	MisResultAction(SetRecord, 913)

	----------------------------------寻找遗失的爱情之舞蝶喜欢吃月饼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000032 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000032")
	DefineMission ( 909, MISSCRIPT_MISSIONSCRIPT07_LUA_000032, 907)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000033 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000033")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000033)
	MisBeginCondition(HasRecord,913)
	MisBeginCondition(NoMission,907)
	MisBeginCondition(NoRecord,907)
	MisBeginAction(AddMission,907)
	MisBeginAction(AddTrigger, 9071, TE_GETITEM, 3915, 10)
	MisCancelAction(ClearMission, 907)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000034 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000034")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000034)
	MisNeed(MIS_NEED_ITEM, 3915, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000035 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000035")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000035)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000036 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000036")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000036) 
	
	MisResultCondition(HasMission, 907)
	MisResultCondition(NoRecord,907)
	MisResultCondition(HasItem, 3915, 10)
	MisResultAction(TakeItem, 3915, 10 )
	MisResultAction(ClearMission, 907)
	MisResultAction(SetRecord, 907 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3915)	
	TriggerAction( 1, AddNextFlag, 907, 10, 10 )
	RegCurTrigger( 9071 )
	
-------------------------------------------------------	寻找遗失的爱情之花瓣的遗信
	MISSCRIPT_MISSIONSCRIPT07_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000037")
	DefineMission(910,MISSCRIPT_MISSIONSCRIPT07_LUA_000037,908)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000038")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000038)

	MisBeginCondition(HasRecord, 907)
	MisBeginCondition(NoRecord, 908)
	MisBeginCondition(NoMission, 908)
	MisBeginBagNeed(1)

	MisBeginAction(AddMission, 908)
	MisBeginAction(GiveItem, 1005,1,4)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000039 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000039")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000039)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000040 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000040")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000040)

	MisCancelAction(ClearMission, 908)

	MisResultCondition(AlwaysFailure)




-----------------------------------寻找遗失的爱情之花瓣的遗信
	MISSCRIPT_MISSIONSCRIPT07_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000037")
	DefineMission( 911, MISSCRIPT_MISSIONSCRIPT07_LUA_000037, 908, COMPLETE_SHOW )

	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_000041 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000041")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000041)
	MisResultCondition(HasMission, 908)
	MisResultCondition(NoRecord,908)
	MisResultCondition(HasItem, 1005, 1)
	MisResultAction(TakeItem, 1005, 1)
	MisResultAction(GiveItem, 1006, 1, 4)
	MisResultAction(ClearMission, 908)
	MisResultAction(SetRecord, 908)

	
	-------------------------------------------------------------寻找遗失的爱情之鱼儿想忘情
	MISSCRIPT_MISSIONSCRIPT07_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000042")
	DefineMission ( 912, MISSCRIPT_MISSIONSCRIPT07_LUA_000042, 909)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000043 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000043")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000043)
	
	MisBeginCondition(HasRecord,908)
	MisBeginCondition(NoRecord,909)
	MisBeginCondition(NoMission,909)
	MisBeginAction(AddMission,909)
	MisCancelAction(ClearMission, 909)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000044 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000044")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000044)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000045")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000045)


	MisResultCondition(AlwaysFailure)


------------------------------------------------------------------------寻找遗失的爱情之鱼儿想忘情



	MISSCRIPT_MISSIONSCRIPT07_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000042")
	DefineMission(913,MISSCRIPT_MISSIONSCRIPT07_LUA_000042, 909,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000046")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000046)
	MisResultCondition(HasMission, 909)
	MisResultCondition(NoRecord, 909)
	MisResultAction(ClearMission, 909)
	MisResultAction(SetRecord, 909)



	
	
	-------------------------------------------------------------寻找遗失的爱情之制造忘情水
	MISSCRIPT_MISSIONSCRIPT07_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000047")
	DefineMission ( 914, MISSCRIPT_MISSIONSCRIPT07_LUA_000047, 910)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000048 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000048")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000048)
	
	MisBeginCondition(NoMission,910)
	MisBeginCondition(HasRecord,909)
	MisBeginCondition(NoRecord,910)
	MisBeginAction(AddMission,910)
	MisBeginAction(AddTrigger, 9101, TE_GETITEM, 1649, 1)
	MisBeginAction(AddTrigger, 9102, TE_GETITEM, 4418, 1)
	MisBeginAction(AddTrigger, 9103, TE_GETITEM, 3129, 2)
	MisBeginAction(AddTrigger, 9104, TE_GETITEM, 1650, 3)	
	MisCancelAction(ClearMission, 910)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000049 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000049")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000049)
	MisNeed(MIS_NEED_ITEM, 1649, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4418, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 3129, 2, 30, 2)
	MisNeed(MIS_NEED_ITEM, 1650, 3, 40, 3)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000050")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000050)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000051")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000051)
	MisResultCondition(HasMission, 910)
	MisResultCondition(NoRecord,910)
	MisResultCondition(HasItem, 1649, 1)
	MisResultCondition(HasItem, 4418, 1)
	MisResultCondition(HasItem, 3129, 2)
	MisResultCondition(HasItem, 1650, 3)
	MisResultAction(TakeItem, 1649, 1 )
	MisResultAction(TakeItem, 4418, 1)
	MisResultAction(TakeItem, 3129, 2 )
	MisResultAction(TakeItem,1650, 3 )
	MisResultAction(ClearMission, 910)
	MisResultAction(SetRecord, 910 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1649)	
	TriggerAction( 1, AddNextFlag, 910, 10, 1 )
	RegCurTrigger( 9101 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4418)	
	TriggerAction( 1, AddNextFlag, 910, 20, 1 )
	RegCurTrigger( 9102 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3129)	
	TriggerAction( 1, AddNextFlag, 910, 30, 2 )
	RegCurTrigger( 9103 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1650)	
	TriggerAction( 1, AddNextFlag, 910, 40, 3 )
	RegCurTrigger( 9104 )
	
	
	-----------------------------------------------------------------寻找遗失的爱情之购买玉金瓶
	MISSCRIPT_MISSIONSCRIPT07_LUA_000052 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000052")
	DefineMission ( 915, MISSCRIPT_MISSIONSCRIPT07_LUA_000052, 911)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000053 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000053")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000053)

	MisBeginCondition(NoMission,911)
	MisBeginCondition(HasRecord,910)
	MisBeginCondition(NoRecord,911)
	MisBeginAction(AddMission,911)
	MisBeginAction(AddTrigger, 9111, TE_GETITEM, 1007, 1)
	MisCancelAction(ClearMission, 911)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000054 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000054")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000054)
	MisNeed(MIS_NEED_ITEM, 1007, 1, 80, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000055")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000055)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000056 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000056")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000056)


	MisResultCondition(HasMission, 911)
	MisResultCondition(NoRecord,911)
	MisResultCondition(HasItem, 1007, 1)
	MisResultAction(TakeItem, 1007, 1 )
	MisResultAction(ClearMission, 911)
	MisResultAction(SetRecord,  911 )

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1007)	
	TriggerAction( 1, AddNextFlag, 911, 80, 1 )
	RegCurTrigger( 9111 )


-------------------------------------------------------------------寻找遗失的爱情之忘情水

MISSCRIPT_MISSIONSCRIPT07_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000057")
DefineMission(916,MISSCRIPT_MISSIONSCRIPT07_LUA_000057,912)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000058 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000058")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000058)

	MisBeginCondition(HasRecord, 911)
	MisBeginCondition(NoRecord, 912)
	MisBeginCondition(NoMission, 912)
	MisBeginBagNeed(1)

	MisBeginAction(AddMission, 912)
	MisBeginAction(GiveItem, 1008,1,4)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000059 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000059")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000059)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000060")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000060)

	MisCancelAction(ClearMission, 912)
	MisResultCondition(AlwaysFailure)




-------------------------------------------------------------------寻找遗失的爱情之忘情水
	MISSCRIPT_MISSIONSCRIPT07_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000057")
	DefineMission( 917, MISSCRIPT_MISSIONSCRIPT07_LUA_000057, 912, COMPLETE_SHOW )

	MisBeginCondition(AlwaysFailure )

	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000061 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000061")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000061)
	MisResultCondition(HasMission, 912)
	MisResultCondition(NoRecord,912)
	MisResultCondition(HasItem, 1008, 1)
	MisResultAction(TakeItem, 1008, 1 )
	MisResultAction(GiveItem, 1009, 1 ,4)
	MisResultAction(ClearMission, 912)
	MisResultAction(SetRecord, 912 )
	MisResultAction(ClearRecord, 909)
	MisResultAction(ClearRecord, 910)
	MisResultAction(ClearRecord, 911)
	MisResultAction(ClearRecord, 912)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1008)	
	TriggerAction( 1, AddNextFlag, 912, 10, 1 )
	RegCurTrigger( 9121 ) 


	--------------------------------------------------------------------爱情重生

	MISSCRIPT_MISSIONSCRIPT07_LUA_000062 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000062")
	DefineMission( 918, MISSCRIPT_MISSIONSCRIPT07_LUA_000062, 914 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000063 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000063")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000063)
	MisBeginCondition(NoMission, 914)
	MisBeginCondition(HasItem,1010,1)------------有纯真之心使用后的枯竭之心
	MisBeginCondition(NoRecord,914)
	MisBeginAction(AddMission,914)
	MisBeginAction(AddTrigger, 9141, TE_GETITEM, 1008, 1)
	MisCancelAction(ClearMission, 914)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000064 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000064")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000064)
	MisNeed(MIS_NEED_ITEM, 1008, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000065 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000065")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000065)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000066 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000066")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000066)

	MisResultCondition(HasMission, 914)
	MisResultCondition(NoRecord,914)
	MisResultCondition(HasItem, 1008, 1)
	MisResultCondition(HasItem, 1010, 1)------------有枯竭之心
	MisResultAction(TakeItem, 1008, 1 )
	MisResultAction(TakeItem, 1010, 1 )
	MisResultAction(GiveItem, 1013,1,4)------------给重生之心
	MisResultAction(ClearMission, 914)
	MisResultAction(SetRecord, 914)
	MisResultAction(ClearRecord, 914)---------------可以反复接

	InitTrigger()
	TriggerCondition( 1, IsItem, 1008)	
	TriggerAction( 1, AddNextFlag, 914, 10, 1 )
	RegCurTrigger( 9141 )
	
	
	-----------------------------------------------------------------------血腥的高跟鞋
	MISSCRIPT_MISSIONSCRIPT07_LUA_000067 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000067")
	DefineMission( 919, MISSCRIPT_MISSIONSCRIPT07_LUA_000067, 915)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000068 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000068")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000068)
	MisBeginCondition(NoRecord, 915 )
	MisBeginCondition(NoMission, 915 )
	MisBeginAction(AddMission, 915 )
	MisBeginAction(GiveItem, 1026,1,4)------白银医院验伤单
	MisCancelAction(ClearMission, 915)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000069 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000069")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000069)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000070 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000070")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000070)
	MisResultCondition(AlwaysFailure )

------------------------------------------------------------------------------血腥的高跟鞋
	MISSCRIPT_MISSIONSCRIPT07_LUA_000067 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000067")
	DefineMission( 920, MISSCRIPT_MISSIONSCRIPT07_LUA_000067, 915, COMPLETE_SHOW )

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000071 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000071")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000071)
	MisResultCondition(HasMission, 915)
	MisResultCondition(NoRecord,915)
	MisResultCondition(HasItem, 1026, 1)
	MisResultAction(TakeItem, 1026, 1 )
	MisResultAction(ClearMission, 915)
	MisResultAction(SetRecord, 915 )
	 
-------------------------------------------------------------------------------向巡逻兵求证

	MISSCRIPT_MISSIONSCRIPT07_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000072")
	DefineMission( 921, MISSCRIPT_MISSIONSCRIPT07_LUA_000072, 916 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000073 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000073")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000073)
	MisBeginCondition(NoMission, 916)
	MisBeginCondition(HasRecord,915)
	MisBeginCondition(NoRecord,916)
	MisBeginAction(AddMission, 916 )
	MisCancelAction(ClearMission, 916)
	MisResultCondition(AlwaysFailure )
	-------------------------------------------------------------------向巡逻兵求证
	MISSCRIPT_MISSIONSCRIPT07_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000072")
	DefineMission( 922, MISSCRIPT_MISSIONSCRIPT07_LUA_000072, 916, COMPLETE_SHOW )

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000074 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000074")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000074)
	MisResultCondition(HasMission, 916)
	MisResultCondition(NoRecord,916)
	MisResultAction(ClearMission, 916)
	MisResultAction(SetRecord, 916 )

	 
	---------------------------------------------------------------高跟鞋案件调查
	MISSCRIPT_MISSIONSCRIPT07_LUA_000075 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000075")
	DefineMission( 923, MISSCRIPT_MISSIONSCRIPT07_LUA_000075, 917)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000076 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000076")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000076)
	MisBeginCondition(NoRecord, 917 )
	MisBeginCondition(NoMission, 917)
	MisBeginCondition(HasRecord, 916 )
	MisBeginAction(AddMission, 917 )
	MisBeginAction(GiveItem, 1027,1,4)------女老板的验伤单
	MisBeginAction(AddTrigger, 9171, TE_GETITEM, 1030, 1)
	MisBeginBagNeed(1)

	MisCancelAction(ClearMission, 917)
	MisNeed(MIS_NEED_ITEM, 1030, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000077 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000077")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000077)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000078")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000078)
	MisResultCondition(HasMission,  917)
	MisResultCondition(NoRecord , 917)
	MisResultCondition(HasItem,1030,1 )
	MisResultAction(TakeItem, 1030, 1 )-------
	MisResultAction(ClearMission,   917)
	MisResultAction(SetRecord,  917 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1030)	
	TriggerAction( 1, AddNextFlag, 917, 10, 1 )
	RegCurTrigger( 9171 )
-------------------------------------------------------------------------高跟鞋案件凶器--------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_000079 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000079")
	DefineMission( 924, MISSCRIPT_MISSIONSCRIPT07_LUA_000079, 918)------------

	MISSCRIPT_MISSIONSCRIPT07_LUA_000080 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000080")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000080)---------------
	MisBeginCondition(NoRecord, 918 )
	--MisBeginCondition(NoMission, 918 )
	MisBeginCondition(HasRecord, 917 )
	--MisBeginAction(AddMission, 918 )
	MisBeginAction(GiveItem, 1029,1,4)----------
	MisBeginAction(AddExp,500,500)
	--MisBeginAction(ClearMission, 918 )
	MisBeginAction(SetRecord, 918 )
	MisCancelAction(ClearMission, 918)
	MisBeginBagNeed(1)---------------

	MISSCRIPT_MISSIONSCRIPT07_LUA_000081 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000081")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000081)----------

	MisResultCondition(AlwaysFailure )---------


	--------------------------------------------------------------------艰难任务1

	MISSCRIPT_MISSIONSCRIPT07_LUA_000082 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000082")
	DefineMission( 6000, MISSCRIPT_MISSIONSCRIPT07_LUA_000082, 1000 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000083 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000083")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000083)
	MisBeginCondition(NoMission, 1000)
	MisBeginCondition(NoRecord,1000)
	MisBeginCondition(HasCredit,9999)
	MisBeginAction(AddMission,1000)
	MisBeginAction(AddTrigger, 10001, TE_GETITEM, 2226, 1)
	MisBeginAction(AddTrigger, 10002, TE_GETITEM, 2227, 1)
	MisBeginAction(AddTrigger, 10003, TE_GETITEM, 2228, 1)
	MisBeginAction(AddTrigger, 10004, TE_GETITEM, 2229, 1)
	MisBeginAction(AddTrigger, 10005, TE_GETITEM, 2230, 1)
	MisBeginAction(AddTrigger, 10006, TE_GETITEM, 2231, 1)
	MisBeginAction(AddTrigger, 10007, TE_GETITEM, 2232, 1)
	MisBeginAction(AddTrigger, 10008, TE_GETITEM, 2233, 1)
	
	
	MisCancelAction(ClearMission, 1000)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000084 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000084")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000084)
	MisNeed(MIS_NEED_ITEM, 2226, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2227, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 2228, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 2229, 1, 40, 1)
	MisNeed(MIS_NEED_ITEM, 2230, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 2231, 1, 60, 1)
	MisNeed(MIS_NEED_ITEM, 2232, 1, 70, 1)
	MisNeed(MIS_NEED_ITEM, 2233, 1, 80, 1)
	
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000085 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000085")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000085)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000086 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000086")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000086)

	MisResultCondition(HasMission, 1000)
	MisResultCondition(NoRecord,1000)
	MisResultCondition(HasItem, 2226, 1)
	MisResultCondition(HasItem, 2227, 1)
	MisResultCondition(HasItem, 2228, 1)
	MisResultCondition(HasItem, 2229, 1)
	MisResultCondition(HasItem, 2230, 1)
	MisResultCondition(HasItem, 2231, 1)
	MisResultCondition(HasItem, 2232, 1)
	MisResultCondition(HasItem, 2233, 1)
	
	
	MisResultAction(TakeItem, 2226, 1 )
	MisResultAction(TakeItem, 2227, 1 )
	MisResultAction(TakeItem, 2228, 1 )
	MisResultAction(TakeItem, 2229, 1 )
	MisResultAction(TakeItem, 2230, 1 )
	MisResultAction(TakeItem, 2231, 1 )
	MisResultAction(TakeItem, 2232, 1 )
	MisResultAction(TakeItem, 2233, 1 )
	
	
	MisResultAction(GiveItem, 2235,1,4)------------给再生之石
	MisResultAction(ClearMission, 1000)
	MisResultAction(ZSSTOP)
	MisResultAction(SetRecord, 1000)
	MisResultBagNeed(1)
	


	InitTrigger()
	TriggerCondition( 1, IsItem, 2226)	
	TriggerAction( 1, AddNextFlag, 1000, 10, 1 )
	RegCurTrigger( 10001 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2227)	
	TriggerAction( 1, AddNextFlag, 1000, 20, 1 )
	RegCurTrigger( 10002 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2228)	
	TriggerAction( 1, AddNextFlag, 1000, 30, 1 )
	RegCurTrigger( 10003 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2229)	
	TriggerAction( 1, AddNextFlag, 1000, 40, 1 )
	RegCurTrigger( 10004 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2230)	
	TriggerAction( 1, AddNextFlag, 1000, 50, 1 )
	RegCurTrigger( 10005 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2231)	
	TriggerAction( 1, AddNextFlag, 1000, 60, 1 )
	RegCurTrigger( 10006 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2232)	
	TriggerAction( 1, AddNextFlag, 1000, 70, 1 )
	RegCurTrigger( 10007 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2233)	
	TriggerAction( 1, AddNextFlag, 1000, 80, 1 )
	RegCurTrigger( 10008 )
	
-------------------------------------------------打雪仗	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000087")
	DefineMission (5500, MISSCRIPT_MISSIONSCRIPT07_LUA_000087, 818)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000088")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000088)

	MisBeginCondition(NoMission,818)
	MisBeginCondition(NoRecord,818)
	MisBeginAction(AddMission,818)
	MisBeginAction(AddTrigger, 8181, TE_KILL, 218, 20 )
	MisCancelAction(ClearMission, 818)
	
	--MisNeed(MIS_NEED_DESP, "消灭20个精灵草")
	MisNeed(MIS_NEED_KILL, 218, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000089")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000089)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000090")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000090)


	MisResultCondition(HasMission, 818)
	MisResultCondition(NoRecord,818)
	MisResultCondition(HasFlag, 818, 29 )
	MisResultAction(ClearMission, 818)
	MisResultAction(SetRecord,  818 )
	MisResultAction(ClearRecord, 818)---------------可以反复接
	MisResultAction(GiveItem, 2896, 10, 4)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 218)	
	TriggerAction( 1, AddNextFlag, 818, 10, 20 )
	RegCurTrigger( 8181 )

	-------------------------------------------------打雪仗	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000087")
	DefineMission (5501, MISSCRIPT_MISSIONSCRIPT07_LUA_000087, 819)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000091 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000091")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000091)

	MisBeginCondition(NoMission,819)
	MisBeginCondition(NoRecord,819)
	MisBeginAction(AddMission,819)
	MisBeginAction(AddTrigger, 8191, TE_KILL, 75, 20 )
	MisCancelAction(ClearMission, 819)
	
	--MisNeed(MIS_NEED_DESP, "消灭20个黄色精灵草")
	MisNeed(MIS_NEED_KILL, 75, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000089")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000089)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000090")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000090)


	MisResultCondition(HasMission, 819)
	MisResultCondition(NoRecord,819)
	MisResultCondition(HasFlag, 819, 29 )
	MisResultAction(ClearMission, 819)
	MisResultAction(SetRecord,  819 )
	MisResultAction(ClearRecord, 819)---------------可以反复接
	MisResultAction(GiveItem, 2896, 10, 4)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 75)	
	TriggerAction( 1, AddNextFlag, 819, 10, 20 )
	RegCurTrigger( 8191 )

-------------------------------------------------打雪仗	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000087")
	DefineMission (5502, MISSCRIPT_MISSIONSCRIPT07_LUA_000087, 820)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000092 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000092")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000092)

	MisBeginCondition(NoMission,820)
	MisBeginCondition(NoRecord,820)
	MisBeginAction(AddMission,820)
	MisBeginAction(AddTrigger, 8201, TE_KILL, 216, 20 )
	MisCancelAction(ClearMission, 820)
	
	--MisNeed(MIS_NEED_DESP, "消灭20个雪地精灵草")
	MisNeed(MIS_NEED_KILL, 216, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000089")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000089)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000090")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000090)


	MisResultCondition(HasMission, 820)
	MisResultCondition(NoRecord,820)
	MisResultCondition(HasFlag, 820, 29 )
	MisResultAction(ClearMission, 820)
	MisResultAction(SetRecord,  820 )
	MisResultAction(ClearRecord, 820)---------------可以反复接
	MisResultAction(GiveItem, 2896, 10, 4)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 216)	
	TriggerAction( 1, AddNextFlag, 820, 10, 20 )
	RegCurTrigger( 8201 )

-----------------------------------------------勇士的证明
	MISSCRIPT_MISSIONSCRIPT07_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000093")
	DefineMission(6001,MISSCRIPT_MISSIONSCRIPT07_LUA_000093,1002)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000094 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000094")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000094)

      MisBeginCondition(HasRecord,1001)
      MisBeginCondition(NoRecord,1002)
      MisBeginCondition(NoMission,1002)
      MisBeginCondition(HasCredit,9999 )
      MisBeginAction(TakeCredit, 9999 )
      MisBeginAction(AddMission,1002)
      MisBeginAction(AddTrigger, 10021, TE_KILL,525, 15)
      MisBeginAction(AddTrigger, 10022, TE_KILL,526, 15)
      MisBeginAction(AddTrigger, 10023, TE_KILL, 532, 15)
      MisBeginAction(AddTrigger, 10024, TE_KILL, 550, 15)
      MisBeginAction(AddTrigger, 10025, TE_KILL, 554, 15)
      MisBeginAction(AddTrigger, 10026, TE_KILL, 553, 15)
      MisCancelAction(ClearMission, 1002)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000095 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000095")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000095)
      MisNeed(MIS_NEED_KILL, 525, 15, 10, 15)
      MisNeed(MIS_NEED_KILL, 526, 15, 30, 15)
      MisNeed(MIS_NEED_KILL, 532, 15, 50, 15)
      MisNeed(MIS_NEED_KILL, 550, 15, 70, 15)
      MisNeed(MIS_NEED_KILL, 554, 15, 90, 15)
      MisNeed(MIS_NEED_KILL, 553, 15, 110, 15)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000096")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000096)  
      MISSCRIPT_MISSIONSCRIPT07_LUA_000097 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000097")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000097)
      MisResultCondition(HasMission,1002 )
      MisResultCondition(NoRecord,1002)
      MisResultCondition(HasFlag, 1002, 24)
      MisResultCondition(HasFlag, 1002, 44)
      MisResultCondition(HasFlag, 1002, 64)
      MisResultCondition(HasFlag, 1002, 84)
      MisResultCondition(HasFlag, 1002, 104)
      MisResultCondition(HasFlag, 1002, 124)
      MisResultAction(GiveItem, 2228, 1, 4 )
      MisResultAction(ClearMission, 1002 )
      MisResultAction(SetRecord, 1002)
      MisResultBagNeed(1)

      InitTrigger()
      TriggerCondition( 1, IsMonster, 525 )
      TriggerAction( 1, AddNextFlag, 1002, 10, 15 )
      RegCurTrigger( 10021 )
       InitTrigger()
      TriggerCondition( 1, IsMonster, 526 )
      TriggerAction( 1, AddNextFlag, 1002, 30, 15 )
      RegCurTrigger( 10022 )
       InitTrigger()
      TriggerCondition( 1, IsMonster,532  )
      TriggerAction( 1, AddNextFlag, 1002, 50, 15 )
      RegCurTrigger( 10023 )
       InitTrigger()
      TriggerCondition( 1, IsMonster, 550 )
      TriggerAction( 1, AddNextFlag, 1002, 70, 15 )
      RegCurTrigger( 10024 )
       InitTrigger()
      TriggerCondition( 1, IsMonster, 554 )
      TriggerAction( 1, AddNextFlag, 1002, 90, 15 )
      RegCurTrigger( 10025 )
       InitTrigger()
      TriggerCondition( 1, IsMonster,553)
      TriggerAction( 1, AddNextFlag, 1002, 110, 15 )
      RegCurTrigger( 10026 )




------------------------------------------------------小镇神秘人
	MISSCRIPT_MISSIONSCRIPT07_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000098")
	DefineMission( 6002, MISSCRIPT_MISSIONSCRIPT07_LUA_000098, 1003 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000099 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000099")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000099 )------------
	MisBeginCondition(NoRecord,   1003)
	MisBeginCondition(HasRecord, 1002)
	MisBeginCondition(NoMission,  1003)
	MisBeginAction(AddMission,  1003)
	MisCancelAction(ClearMission, 1003)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000100 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000100")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000100)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000101 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000101")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000101)
	
	MisResultCondition(AlwaysFailure)
	
-------------------------------------------------------小镇神秘人
	MISSCRIPT_MISSIONSCRIPT07_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000098")
	DefineMission( 6003, MISSCRIPT_MISSIONSCRIPT07_LUA_000098, 1003, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_000102 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000102")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000102)
	MisResultCondition(NoRecord,  1003)
	MisResultCondition(HasMission,  1003)
	MisResultAction(SetRecord,  1003)
	MisResultAction(ClearMission,  1003)

------------------------------------------------------------简单任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_000103 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000103")
	DefineMission( 6004, MISSCRIPT_MISSIONSCRIPT07_LUA_000103, 1004 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000104 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000104")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000104 )
	MisBeginCondition(NoRecord, 1004)
	MisBeginCondition(HasRecord, 1003)
	MisBeginCondition(NoMission, 1004)
	MisBeginAction(AddMission, 1004)
	MisBeginAction(AddTrigger, 10041, TE_GETITEM, 4730, 30 )
	MisBeginAction(AddTrigger, 10042, TE_GETITEM, 1358, 30 )
	MisBeginAction(AddTrigger, 10043, TE_GETITEM, 2619, 30 )
	MisCancelAction(ClearMission, 1004)
	
	MisNeed(MIS_NEED_ITEM, 4730, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 1358, 30, 50, 30)
	MisNeed(MIS_NEED_ITEM, 2619, 30, 90, 30)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000105 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000105")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000105)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000106 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000106")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000106)
	MisResultCondition(HasMission, 1004)
	MisResultCondition(HasItem, 4730, 30 )
	MisResultCondition(HasItem, 1358, 30 )
	MisResultCondition(HasItem, 2619, 30 )
	MisResultAction(TakeItem, 4730, 30 )
	MisResultAction(TakeItem, 1358, 30 )
	MisResultAction(TakeItem, 2619, 30 )
	MisResultAction(ClearMission, 1004)
	MisResultAction(SetRecord, 1004 )
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4730)	
	TriggerAction( 1, AddNextFlag, 1004, 10, 30 )
	RegCurTrigger( 10041 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1358)	
	TriggerAction( 1, AddNextFlag, 1004, 50, 30 )
	RegCurTrigger( 10042 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2619)	
	TriggerAction( 1, AddNextFlag, 1004, 90, 30 )
	RegCurTrigger( 10043 )




------------------------------------------------------------戒酒记
	MISSCRIPT_MISSIONSCRIPT07_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000107")
	DefineMission( 6005, MISSCRIPT_MISSIONSCRIPT07_LUA_000107, 1005)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000108 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000108")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000108 )
	MisBeginCondition(NoRecord, 1005)
	MisBeginCondition(HasRecord, 1004)
	MisBeginCondition(NoMission, 1005)
	MisBeginAction(AddMission, 1005)
	MisBeginAction(AddTrigger, 10051, TE_GETITEM, 1087, 30 )		
	MisCancelAction(ClearMission, 1005)
	
	MisNeed(MIS_NEED_ITEM, 1087, 30, 10, 30)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000109 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000109")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000109)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000110 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000110)
	MisResultCondition(HasMission, 1005)
	MisResultCondition(HasItem, 1087, 30 )
	MisResultAction(TakeItem, 1087, 30 )
	MisResultAction(ClearMission, 1005)
	MisResultAction(SetRecord, 1005 )
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1087)	
	TriggerAction( 1, AddNextFlag, 1005, 10, 30 )
	RegCurTrigger( 10051 )

------------------------------------------------------------戒酒记
	MISSCRIPT_MISSIONSCRIPT07_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000107")
	DefineMission( 6006, MISSCRIPT_MISSIONSCRIPT07_LUA_000107, 1006)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000111 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000111")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000111 )
	MisBeginCondition(NoRecord, 1006)
	MisBeginCondition(HasRecord, 1005)
	MisBeginCondition(NoMission, 1006)
	MisBeginAction(AddMission, 1006)
	MisBeginAction(AddTrigger, 10061, TE_GETITEM, 1088, 20 )		--
	MisCancelAction(ClearMission, 1006)
	
	MisNeed(MIS_NEED_ITEM, 1088, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000112 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000112")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000112)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000113 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000113")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000113)
	MisResultCondition(HasMission, 1006)
	MisResultCondition(HasItem, 1088, 20 )
	MisResultAction(TakeItem, 1088, 20 )
	MisResultAction(ClearMission, 1006)
	MisResultAction(SetRecord, 1006 )
	

	InitTrigger()
	TriggerCondition( 1, IsItem, 1088)	
	TriggerAction( 1, AddNextFlag, 1006, 10, 20 )
	RegCurTrigger( 10061 )



------------------------------------------------------------戒酒记
	MISSCRIPT_MISSIONSCRIPT07_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000107")
	DefineMission( 6007, MISSCRIPT_MISSIONSCRIPT07_LUA_000107, 1007)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000114")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000114 )
	MisBeginCondition(NoRecord, 1007)
	MisBeginCondition(HasRecord, 1006)
	MisBeginCondition(NoMission, 1007)
	MisBeginAction(AddMission, 1007)
	MisBeginAction(AddTrigger, 10071, TE_GETITEM, 1087, 20 )		--
	MisCancelAction(ClearMission, 1007)
	
	MisNeed(MIS_NEED_ITEM, 1087, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000115 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000115")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000115)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000116 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000116")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000116)
	MisResultCondition(HasMission, 1007)
	MisResultCondition(HasItem, 1087, 20 )
	MisResultAction(TakeItem, 1087, 20 )
	MisResultAction(ClearMission, 1007)
	MisResultAction(SetRecord, 1007 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1087)	
	TriggerAction( 1, AddNextFlag, 1007, 10, 20 )
	RegCurTrigger( 10071 )

------------------------------------------------------------戒酒记
	MISSCRIPT_MISSIONSCRIPT07_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000107")
	DefineMission( 6008, MISSCRIPT_MISSIONSCRIPT07_LUA_000107, 1008)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000117 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000117")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000117 )
	MisBeginCondition(NoRecord, 1008)
	MisBeginCondition(HasRecord, 1007)
	MisBeginCondition(NoMission, 1008)
	MisBeginAction(AddMission, 1008)
	MisBeginAction(AddTrigger, 10081, TE_GETITEM, 1089, 15 )		--
	MisCancelAction(ClearMission, 1008)
	
	MisNeed(MIS_NEED_ITEM, 1089, 15, 10, 15)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000118 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000118")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000118)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000119 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000119")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000119)
	MisResultCondition(HasMission, 1008)
	MisResultCondition(HasItem, 1089, 15 )
	MisResultAction(TakeItem, 1089, 15 )
	MisResultAction(ClearMission, 1008)
	MisResultAction(SetRecord, 1008 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1089)	
	TriggerAction( 1, AddNextFlag, 1008, 10, 15 )
	RegCurTrigger( 10081 )


------------------------------------------------------寻访魔方导游
	MISSCRIPT_MISSIONSCRIPT07_LUA_000120 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000120")
	DefineMission( 6009, MISSCRIPT_MISSIONSCRIPT07_LUA_000120, 1009 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000121")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000121 )
	MisBeginCondition(NoRecord,   1009)
	MisBeginCondition(HasRecord, 1008)
	MisBeginCondition(NoMission,  1009)
	MisBeginAction(AddMission,  1009)
	MisBeginAction(GiveItem, 2227, 1, 4 )
	MisCancelAction(ClearMission, 1009)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000122 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000122")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000122)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000123 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000123")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000123)
	
	MisResultCondition(AlwaysFailure)
	
-------------------------------------------------------寻访魔方导游
	MISSCRIPT_MISSIONSCRIPT07_LUA_000120 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000120")
	DefineMission( 6010, MISSCRIPT_MISSIONSCRIPT07_LUA_000120, 1009, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_000124 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000124")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000124)
	MisResultCondition(NoRecord,  1009)
	MisResultCondition(HasMission,  1009)
	MisResultAction(SetRecord,  1009)
	MisResultAction(ClearMission,  1009)
----------------------------------------------------------加勒比观光游
	MISSCRIPT_MISSIONSCRIPT07_LUA_000125 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000125")
	DefineMission( 6011, MISSCRIPT_MISSIONSCRIPT07_LUA_000125, 1010 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000126 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000126")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000126)
				
	MisBeginCondition(NoMission, 1010)
	MisBeginCondition(HasRecord, 1009)
	MisBeginCondition(NoRecord,1010)	
	MisBeginAction(AddMission,1010)
	MisBeginAction(AddTrigger, 10101, TE_KILL, 807, 1)--亡灵司令(807)  
	MisCancelAction(ClearMission, 1010)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000127 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000127")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000127)
	MisNeed(MIS_NEED_KILL, 807,1, 10, 1)
	
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000128 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000128")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000128)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000129 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000129")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000129)
	MisResultCondition(HasMission,  1010)
	MisResultCondition(HasFlag, 1010, 10)
	MisResultCondition(NoRecord , 1010)
	MisResultAction(ClearMission,  1010)
	MisResultAction(SetRecord,  1010 )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 807)	
	TriggerAction( 1, AddNextFlag, 1010, 10, 1 )
	RegCurTrigger( 10101 )

	


----------------------------------------------------------加勒比观光游
	MISSCRIPT_MISSIONSCRIPT07_LUA_000130 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000130")
	DefineMission( 6012, MISSCRIPT_MISSIONSCRIPT07_LUA_000130, 1011 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000131")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000131)
				
	MisBeginCondition(NoMission, 1011)
	MisBeginCondition(NoRecord,1011)
	MisBeginCondition(HasRecord, 1010)
	MisBeginAction(AddMission,1011)
	MisBeginAction(AddTrigger, 10111, TE_KILL, 805, 1)--巴伯萨(805)
	MisCancelAction(ClearMission, 1011)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000132 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000132")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000132)
	MisNeed(MIS_NEED_KILL, 805,1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000133 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000133")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000133)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000134 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000134")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000134)
	MisResultCondition(HasMission,  1011)
	MisResultCondition(HasFlag, 1011, 10)
	MisResultCondition(NoRecord , 1011)
	MisResultAction(ClearMission,  1011)
	MisResultAction(SetRecord,  1011 )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 805)	
	TriggerAction( 1, AddNextFlag, 1011, 10, 1 )
	RegCurTrigger( 10111 )
	
	----------------------------------------------------------加勒比观光游
	MISSCRIPT_MISSIONSCRIPT07_LUA_000135 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000135")
	DefineMission( 6013, MISSCRIPT_MISSIONSCRIPT07_LUA_000135, 1012 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000136 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000136")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000136)
				
	MisBeginCondition(NoMission, 1012)
	MisBeginCondition(NoRecord,1012)
	MisBeginCondition(HasRecord, 1011)
	MisBeginAction(AddMission,1012)
	MisBeginAction(AddTrigger, 10121, TE_KILL, 796, 1)---史前大章鱼
	
	MisCancelAction(ClearMission, 1012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000137")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000137)
	MisNeed(MIS_NEED_KILL, 796,1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000138 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000138")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000138)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000139 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000139")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000139)
	MisResultCondition(HasMission,  1012)
	MisResultCondition(HasFlag, 1012, 10)
	MisResultCondition(NoRecord , 1012)
	MisResultAction(GiveItem, 2226, 1, 4 )
	MisResultAction(ClearMission,  1012)
	MisResultAction(SetRecord,  1012 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 796)	
	TriggerAction( 1, AddNextFlag, 1012, 10, 1 )
	RegCurTrigger( 10121 )
	
	------------------------------------------------------谁是守护者
	MISSCRIPT_MISSIONSCRIPT07_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000140")
	DefineMission( 6014, MISSCRIPT_MISSIONSCRIPT07_LUA_000140, 1013 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000141 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000141")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000141 )
	MisBeginCondition(NoRecord,   1013)
	MisBeginCondition(HasRecord, 1012)
	MisBeginCondition(NoMission,  1013)
	MisBeginAction(AddMission,  1013)
	MisCancelAction(ClearMission, 1013)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000142")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000142)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000143 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000143")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000143)
	
	MisResultCondition(AlwaysFailure)

	-------------------------------------------------情人节的礼物----------沙泉补给站找NPC菲菲对话：（男性角色）	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000144 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000144")
	DefineMission (5503, MISSCRIPT_MISSIONSCRIPT07_LUA_000144, 825)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000145 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000145")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000145)

	MisBeginCondition(NoMission,825)
	MisBeginCondition(NoRecord,825)
	MisBeginCondition(LvCheck, ">",30)
	MisBeginCondition(NoChaType,3)
	MisBeginCondition(NoChaType,4)
	MisBeginAction(AddMission,825)
	MisBeginAction(AddTrigger, 8251, TE_GETITEM, 3343, 1)
	MisBeginAction(AddTrigger, 8252, TE_GETITEM, 4418, 10)
	MisCancelAction(ClearMission, 825)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000146")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000146)
	MisNeed(MIS_NEED_ITEM, 3343, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4418, 10, 20, 10 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000147")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000147)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000148 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000148")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000148)


	MisResultCondition(HasMission, 825)
	MisResultCondition(NoRecord,825)
	MisResultCondition(HasItem, 3343, 1)
	MisResultCondition(HasItem, 4418, 10)
	MisResultAction(TakeItem, 3343, 1 )
	MisResultAction(TakeItem, 4418, 10 )
	MisResultAction(ClearMission, 825)
	MisResultAction(SetRecord,  825 )
	MisResultAction(GiveItem, 2904, 1, 4)
	MisResultBagNeed(1)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3343)	
	TriggerAction( 1, AddNextFlag, 825, 10, 1 )
	RegCurTrigger( 8251 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4418)	
	TriggerAction( 1, AddNextFlag, 825, 20, 10 )
	RegCurTrigger( 8252 )

-------------------------------------------------情人节的礼物----------冰极补给站找NPC法迪尔对话：（女性角色）	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000144 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000144")
	DefineMission (5504, MISSCRIPT_MISSIONSCRIPT07_LUA_000144, 826)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000145 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000145")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000145)

	MisBeginCondition(NoMission,826)
	MisBeginCondition(NoRecord,826)
	MisBeginCondition(LvCheck, ">",30)
	MisBeginCondition(NoChaType,1)
	MisBeginCondition(NoChaType,2)
	MisBeginAction(AddMission,826)
	MisBeginAction(AddTrigger, 8261, TE_GETITEM, 3343, 1)
	MisBeginAction(AddTrigger, 8262, TE_GETITEM, 4418, 10)
	MisCancelAction(ClearMission, 826)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000146")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000146)
	MisNeed(MIS_NEED_ITEM, 3343, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4418, 10, 20, 10 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000147")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000147)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000149 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000149")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000149)


	MisResultCondition(HasMission, 826)
	MisResultCondition(NoRecord,826)
	MisResultCondition(HasItem, 3343, 1)
	MisResultCondition(HasItem, 4418, 10)
	MisResultAction(TakeItem, 3343, 1 )
	MisResultAction(TakeItem, 4418, 10 )
	MisResultAction(ClearMission, 826)
	MisResultAction(SetRecord,  826 )
	MisResultAction(GiveItem, 2905, 1, 4)
	MisResultBagNeed(1)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3343)	
	TriggerAction( 1, AddNextFlag, 826, 10, 1 )
	RegCurTrigger( 8261 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4418)	
	TriggerAction( 1, AddNextFlag, 826, 20, 10 )
	RegCurTrigger( 8262 )


-----------------------------------------------七猪开泰---------玛拉依兰
	MISSCRIPT_MISSIONSCRIPT07_LUA_000150 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000150")
	DefineMission(5505,MISSCRIPT_MISSIONSCRIPT07_LUA_000150,827)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000151")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000151)

      MisBeginCondition(NoRecord,827)
      MisBeginCondition(NoMission,827)
      MisBeginAction(AddMission,827)
      MisBeginAction(AddTrigger, 8271, TE_KILL,239, 1)
      MisBeginAction(AddTrigger, 8272, TE_KILL,237, 1)
      MisBeginAction(AddTrigger, 8273, TE_KILL, 264, 1)
      MisBeginAction(AddTrigger, 8274, TE_KILL, 295, 1)
      MisBeginAction(AddTrigger, 8275, TE_KILL, 64, 1)
      MisBeginAction(AddTrigger, 8276, TE_KILL, 296, 1)
      MisBeginAction(AddTrigger, 8277, TE_KILL, 144, 1)
      MisCancelAction(ClearMission, 827)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000152")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000152)
      MisNeed(MIS_NEED_KILL, 239, 1, 10, 1)
      MisNeed(MIS_NEED_KILL, 237, 1, 20, 1)
      MisNeed(MIS_NEED_KILL, 264, 1, 30, 1)
      MisNeed(MIS_NEED_KILL, 295, 1, 40, 1)
      MisNeed(MIS_NEED_KILL, 64, 1, 50, 1)
      MisNeed(MIS_NEED_KILL, 296, 1, 60, 1)
      MisNeed(MIS_NEED_KILL, 144, 1, 70, 1)


      MISSCRIPT_MISSIONSCRIPT07_LUA_000153 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000153")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000153)  
      MISSCRIPT_MISSIONSCRIPT07_LUA_000154 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000154")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000154)
      MisResultCondition(HasMission,827 )
      MisResultCondition(NoRecord,827)
      MisResultCondition(HasFlag, 827, 10)
      MisResultCondition(HasFlag, 827, 20)
      MisResultCondition(HasFlag, 827, 30)
      MisResultCondition(HasFlag, 827, 40)
      MisResultCondition(HasFlag, 827, 50)
      MisResultCondition(HasFlag, 827, 60)
      MisResultCondition(HasFlag, 827, 70)
      MisResultAction(GiveItem, 855, 10, 4 )
      MisResultAction(ClearMission, 827 )
      MisResultAction(SetRecord, 827)
      MisResultBagNeed(1)

      InitTrigger()
      TriggerCondition( 1, IsMonster, 239 )
      TriggerAction( 1, AddNextFlag, 827, 10, 1 )
      RegCurTrigger( 8271 )
       InitTrigger()
      TriggerCondition( 1, IsMonster, 237 )
      TriggerAction( 1, AddNextFlag, 827, 20, 1 )
      RegCurTrigger( 8272 )
       InitTrigger()
      TriggerCondition( 1, IsMonster,264  )
      TriggerAction( 1, AddNextFlag, 827, 30, 1 )
      RegCurTrigger( 8273 )
       InitTrigger()
      TriggerCondition( 1, IsMonster, 295 )
      TriggerAction( 1, AddNextFlag, 827, 40, 1 )
      RegCurTrigger( 8274 )
       InitTrigger()
      TriggerCondition( 1, IsMonster, 64 )
      TriggerAction( 1, AddNextFlag, 827, 50, 1 )
      RegCurTrigger( 8275 )
       InitTrigger()
      TriggerCondition( 1, IsMonster,296)
      TriggerAction( 1, AddNextFlag, 827, 60, 1 )
      RegCurTrigger( 8276 )

      InitTrigger()
      TriggerCondition( 1, IsMonster,144)
      TriggerAction( 1, AddNextFlag, 827, 70, 1 )
      RegCurTrigger( 8277 )

-------------------------------------------------幸运猪猪----------玛拉依兰	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000155 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000155")
	DefineMission (5506, MISSCRIPT_MISSIONSCRIPT07_LUA_000155, 828)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000156 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000156")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000156)

	MisBeginCondition(NoMission,828)
	MisBeginCondition(HasRecord,827)
	MisBeginCondition(NoRecord,828)
	MisBeginAction(AddMission,828)
	MisBeginAction(AddTrigger, 8281, TE_GETITEM, 2908, 1)
	MisCancelAction(ClearMission, 828)
	
	MisNeed(MIS_NEED_ITEM, 2908, 1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000157 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000157")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000157)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000158 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000158")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000158)

	MisResultCondition(HasMission, 828)
	MisResultCondition(NoRecord,828)
	MisResultCondition(HasItem, 2908, 1)
	MisResultCondition(HasMoney, 30000)
	MisResultAction(TakeItem, 2908, 1 )
	MisResultAction(TakeMoney,30000 )
	MisResultAction(ClearMission, 828)
	MisResultAction(SetRecord,  828 )
	MisResultAction(GiveItem, 2909, 1, 4)
	MisResultAction(ClearRecord, 828)---------------可以反复接
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2908)	
	TriggerAction( 1, AddNextFlag, 828, 10, 1 )
	RegCurTrigger( 8281 )

	
-----------------------------------------------海盗王压岁大礼---------白银商城新手指导
	MISSCRIPT_MISSIONSCRIPT07_LUA_000159 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000159")
	DefineMission(5507,MISSCRIPT_MISSIONSCRIPT07_LUA_000159,829)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000160 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000160")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000160)

      MisBeginCondition(NoRecord,829)
      MisBeginCondition(NoMission,829)
      MisBeginCondition(LvCheck, ">",45)
      MisBeginAction(AddMission,829)
      MisBeginAction(AddTrigger, 8291, TE_KILL,237, 20)
      MisCancelAction(ClearMission, 829)

      MISSCRIPT_MISSIONSCRIPT07_LUA_000161 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000161")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000161)
      MisNeed(MIS_NEED_KILL, 237, 20, 10, 20)
     
      MISSCRIPT_MISSIONSCRIPT07_LUA_000162 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000162")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000162)  
      MISSCRIPT_MISSIONSCRIPT07_LUA_000163 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000163")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000163)
      MisResultCondition(HasMission,829 )
      MisResultCondition(NoRecord,829)
      MisResultCondition(HasFlag, 829, 29)
      MisResultAction(GiveItem, 2910, 1, 4 )
      MisResultAction(ClearMission, 829 )
      MisResultAction(SetRecord, 829)
      MisResultBagNeed(1)

      InitTrigger()
      TriggerCondition( 1, IsMonster, 237 )
      TriggerAction( 1, AddNextFlag, 829, 10, 20 )
      RegCurTrigger( 8291 )
       
-------------------------------------------------情为何物----------玛拉依兰	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000164 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000164")
	DefineMission (5508, MISSCRIPT_MISSIONSCRIPT07_LUA_000164, 830)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000165 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000165")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000165)

	MisBeginCondition(NoMission,830)
	MisBeginCondition(LvCheck, ">",30)
	MisBeginCondition(NoRecord,830)
	MisBeginAction(AddMission,830)
	MisBeginAction(AddTrigger, 8301, TE_GETITEM, 4418, 10 )
	MisCancelAction(ClearMission, 830)
	
	MisNeed(MIS_NEED_ITEM, 4418, 10, 10, 10 )
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000166 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000166")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000166)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000167 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000167")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000167)

	MisResultCondition(HasMission, 830)
	MisResultCondition(NoRecord,830)
	MisResultCondition(HasItem, 4418, 10)
	MisResultAction(TakeItem, 4418, 10 )
	MisResultAction(ClearMission, 830)
	MisResultAction(SetRecord,  830 )
	MisResultAction(GiveItem, 2916, 1, 4)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4418)	
	TriggerAction( 1, AddNextFlag, 830, 10, 10 )
	RegCurTrigger( 8301 )


	-------------------------------------------------倾城之恋----------玛拉依兰	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000168 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000168")
	DefineMission (5509, MISSCRIPT_MISSIONSCRIPT07_LUA_000168, 831)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000169 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000169")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000169)

	MisBeginCondition(NoMission,831)
	MisBeginCondition(NoMission,832)
	MisBeginCondition(HasRecord,830)
	MisBeginCondition(NoRecord,831)
	MisBeginCondition(NoRecord,832)
	MisBeginCondition(NoChaType,1)
	MisBeginCondition(NoChaType,2)
	MisBeginCondition(HasItem, 2902, 1)
	MisBeginAction(AddTrigger, 8311, TE_GETITEM, 2903, 1 )
	MisBeginAction(AddTrigger, 8312, TE_GETITEM, 2845, 1 )
	MisBeginAction(AddMission,831)
	MisCancelAction(ClearMission, 831)
	

	MisNeed(MIS_NEED_ITEM, 2903, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 2845, 1, 20, 1 )


	MISSCRIPT_MISSIONSCRIPT07_LUA_000170 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000170")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000170)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000171 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000171")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000171)

	MisResultCondition(HasMission, 831)
	MisResultCondition(NoRecord,831)
	MisResultCondition(HasItem, 2902, 1)
	MisResultCondition(HasItem, 2903, 1)
	MisResultCondition(HasItem, 2845, 1)
	MisResultCondition(CheckItem,2902,2903)
	MisResultAction(TakeItem, 2902, 1 )
	MisResultAction(TakeItem, 2903, 1 )
	MisResultAction(TakeItem, 2845, 1 )
	MisResultAction(ClearMission, 831)
	MisResultAction(SetRecord,  831 )
	MisResultAction(GiveItem, 2915, 2, 4)
	MisResultAction(Starteffect,  370 )
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2903)	
	TriggerAction( 1, AddNextFlag, 831, 10, 1 )
	RegCurTrigger( 8311 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2845)	
	TriggerAction( 1, AddNextFlag, 831, 20, 1 )
	RegCurTrigger( 8312 )
		-------------------------------------------------倾城之恋----------玛拉依兰	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000168 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000168")
	DefineMission (6808, MISSCRIPT_MISSIONSCRIPT07_LUA_000168, 832)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000169 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000169")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000169)

	MisBeginCondition(NoMission,832)
	MisBeginCondition(NoMission,831)
	MisBeginCondition(HasRecord,830)
	MisBeginCondition(NoRecord,831)
	MisBeginCondition(NoRecord,832)
	MisBeginCondition(NoChaType,3)
	MisBeginCondition(NoChaType,4)
	MisBeginCondition(HasItem, 2903, 1)
	MisBeginAction(AddTrigger, 8321, TE_GETITEM, 2902, 1 )
	MisBeginAction(AddTrigger, 8322, TE_GETITEM, 2845, 1 )
	MisBeginAction(AddMission,832)
	MisCancelAction(ClearMission, 832)
	

	MisNeed(MIS_NEED_ITEM, 2902, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 2845, 1, 20, 1 )


	MISSCRIPT_MISSIONSCRIPT07_LUA_000170 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000170")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000170)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000171 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000171")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000171)

	MisResultCondition(HasMission, 832)
	MisResultCondition(NoRecord,832)
	MisResultCondition(HasItem, 2902, 1)
	MisResultCondition(HasItem, 2903, 1)
	MisResultCondition(HasItem, 2845, 1)
	MisResultCondition(CheckItem,2902,2903)
	MisResultAction(TakeItem, 2902, 1 )
	MisResultAction(TakeItem, 2903, 1 )
	MisResultAction(TakeItem, 2845, 1 )
	MisResultAction(ClearMission, 832)
	MisResultAction(SetRecord,  832 )
	MisResultAction(GiveItem, 2915, 2, 4)
	MisResultAction(Starteffect,  370 )
	MisResultBagNeed(2)


	InitTrigger()
	TriggerCondition( 1, IsItem, 2902)	
	TriggerAction( 1, AddNextFlag, 832, 10, 1 )
	RegCurTrigger( 8321 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2845)	
	TriggerAction( 1, AddNextFlag, 832, 20, 1 )
	RegCurTrigger( 8322 )



	-------------------------------------------------挑战吉尼斯1	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000172")
	DefineMission (5510, MISSCRIPT_MISSIONSCRIPT07_LUA_000172, 743)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000173 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000173")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000173)

	MisBeginCondition(NoMission,743)
	MisBeginCondition(NoRecord,743)
	MisBeginCondition(CheckBagEmp,0)
	MisBeginAction(AddMission,743)
	MisBeginAction(AddChaItem1, 2911)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000174 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000174")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000174)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯1

	MISSCRIPT_MISSIONSCRIPT07_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000172")
	DefineMission(5511,MISSCRIPT_MISSIONSCRIPT07_LUA_000172,743,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000176 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000176")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000176)
	MisResultCondition(HasMission, 743)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultCondition(NoRecord,743)
	MisResultAction(ClearMission, 743)
	MisResultAction(SetRecord,743 )
	


	-------------------------------------------------挑战吉尼斯2	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000177")
	DefineMission (5512, MISSCRIPT_MISSIONSCRIPT07_LUA_000177, 744)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000178 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000178")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000178)

	MisBeginCondition(NoMission,744)
	MisBeginCondition(HasRecord, 743)
	MisBeginCondition(NoRecord,744)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,744)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000179 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000179")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000179)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯2

	MISSCRIPT_MISSIONSCRIPT07_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000177")
	DefineMission(5513,MISSCRIPT_MISSIONSCRIPT07_LUA_000177,744,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000180 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000180")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000180)
	MisResultCondition(HasMission, 744)
	MisResultCondition(NoRecord,744)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 744)
	MisResultAction(SetRecord,  744 )

	

	-------------------------------------------------挑战吉尼斯3	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000181 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000181")
	DefineMission (5514, MISSCRIPT_MISSIONSCRIPT07_LUA_000181, 745)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000182 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000182")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000182)

	MisBeginCondition(NoMission,745)
	MisBeginCondition(HasRecord, 744)
	MisBeginCondition(NoRecord,745)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,745)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000183 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000183")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000183)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯3

	MISSCRIPT_MISSIONSCRIPT07_LUA_000181 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000181")
	DefineMission(5515,MISSCRIPT_MISSIONSCRIPT07_LUA_000181,745,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000184 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000184")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000184)
	MisResultCondition(HasMission, 745)
	MisResultCondition(NoRecord,745)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 745)
	MisResultAction(SetRecord,  745 )



	-------------------------------------------------挑战吉尼斯4	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000185")
	DefineMission (5516, MISSCRIPT_MISSIONSCRIPT07_LUA_000185, 746)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000186 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000186")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000186)

	MisBeginCondition(NoMission,746)
	MisBeginCondition(HasRecord, 745)
	MisBeginCondition(NoRecord,746)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,746)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000187 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000187")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000187)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯4

	MISSCRIPT_MISSIONSCRIPT07_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000185")
	DefineMission(5517,MISSCRIPT_MISSIONSCRIPT07_LUA_000185,746,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000188 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000188")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000188)
	MisResultCondition(HasMission, 746)
	MisResultCondition(NoRecord,746)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 746)
	MisResultAction(SetRecord,  746 )
	


	-------------------------------------------------挑战吉尼斯5	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000189 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000189")
	DefineMission (5518, MISSCRIPT_MISSIONSCRIPT07_LUA_000189, 747)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000190")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000190)

	MisBeginCondition(NoMission,747)
	MisBeginCondition(HasRecord,746)
	MisBeginCondition(NoRecord,747)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,747)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000191")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000191)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯5

	MISSCRIPT_MISSIONSCRIPT07_LUA_000189 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000189")
	DefineMission(5519,MISSCRIPT_MISSIONSCRIPT07_LUA_000189,747,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000192 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000192")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000192)
	MisResultCondition(HasMission, 747)
	MisResultCondition(NoRecord,747)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 747)
	MisResultAction(SetRecord,  747 )
	


	-------------------------------------------------挑战吉尼斯6	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000193 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000193")
	DefineMission (5520, MISSCRIPT_MISSIONSCRIPT07_LUA_000193, 748)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000194 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000194")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000194)

	MisBeginCondition(NoMission,748)
	MisBeginCondition(HasRecord,747)
	MisBeginCondition(NoRecord,748)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,748)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000195 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000195")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000195)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯6

	MISSCRIPT_MISSIONSCRIPT07_LUA_000193 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000193")
	DefineMission(5521,MISSCRIPT_MISSIONSCRIPT07_LUA_000193,748,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000196 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000196")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000196)
	MisResultCondition(HasMission, 748)
	MisResultCondition(NoRecord,748)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 748)
	MisResultAction(SetRecord,  748 )
	


	-------------------------------------------------挑战吉尼斯7	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000197 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000197")
	DefineMission (5522, MISSCRIPT_MISSIONSCRIPT07_LUA_000197, 749)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000198 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000198")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000198)

	MisBeginCondition(NoMission,749)
	MisBeginCondition(HasRecord,748)
	MisBeginCondition(NoRecord,749)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,749)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000199 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000199")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000199)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯7

	MISSCRIPT_MISSIONSCRIPT07_LUA_000197 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000197")
	DefineMission(5523,MISSCRIPT_MISSIONSCRIPT07_LUA_000197,749,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000200 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000200")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000200)
	MisResultCondition(HasMission, 749)
	MisResultCondition(NoRecord,749)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 749)
	MisResultAction(SetRecord,  749 )
	


	-------------------------------------------------挑战吉尼斯8	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000201")
	DefineMission (5524, MISSCRIPT_MISSIONSCRIPT07_LUA_000201, 750)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000202 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000202")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000202)

	MisBeginCondition(NoMission,750)
	MisBeginCondition(HasRecord,749)
	MisBeginCondition(NoRecord,750)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,750)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000203 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000203")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000203)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯8

	MISSCRIPT_MISSIONSCRIPT07_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000201")
	DefineMission(5525,MISSCRIPT_MISSIONSCRIPT07_LUA_000201,750,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000204 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000204")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000204)
	MisResultCondition(HasMission, 750)
	MisResultCondition(NoRecord,750)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 750)
	MisResultAction(SetRecord,  750 )
	
	

	-------------------------------------------------挑战吉尼斯9	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000205 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000205")
	DefineMission (5526, MISSCRIPT_MISSIONSCRIPT07_LUA_000205, 751)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000206 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000206")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000206)

	MisBeginCondition(NoMission,751)
	MisBeginCondition(HasRecord,750)
	MisBeginCondition(NoRecord,751)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,751)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000207 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000207")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000207)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯9

	MISSCRIPT_MISSIONSCRIPT07_LUA_000205 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000205")
	DefineMission(5527,MISSCRIPT_MISSIONSCRIPT07_LUA_000205,751,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000208 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000208")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000208)
	MisResultCondition(HasMission, 751)
	MisResultCondition(NoRecord,751)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 751)
	MisResultAction(SetRecord,  751 )
	



	-------------------------------------------------挑战吉尼斯10	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000209 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000209")
	DefineMission (5528, MISSCRIPT_MISSIONSCRIPT07_LUA_000209, 752)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000210 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000210")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000210)

	MisBeginCondition(NoMission,752)
	MisBeginCondition(HasRecord,751)
	MisBeginCondition(NoRecord,752)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,752)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000211 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000211")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000211)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯10

	MISSCRIPT_MISSIONSCRIPT07_LUA_000209 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000209")
	DefineMission(5529,MISSCRIPT_MISSIONSCRIPT07_LUA_000209,752,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000212 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000212")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000212)
	MisResultCondition(HasMission, 752)
	MisResultCondition(NoRecord,752)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 752)
	MisResultAction(SetRecord,  752 )
	


	-------------------------------------------------挑战吉尼斯11	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000213 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000213")
	DefineMission (5530, MISSCRIPT_MISSIONSCRIPT07_LUA_000213, 753)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000214 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000214")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000214)

	MisBeginCondition(NoMission,753)
	MisBeginCondition(HasRecord,752)
	MisBeginCondition(NoRecord,753)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,753)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000215 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000215")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000215)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯11

	MISSCRIPT_MISSIONSCRIPT07_LUA_000213 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000213")
	DefineMission(5531,MISSCRIPT_MISSIONSCRIPT07_LUA_000213,753,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000216")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000216)
	MisResultCondition(HasMission, 753)
	MisResultCondition(NoRecord,753)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 753)
	MisResultAction(SetRecord,  753 )
	
	


	-------------------------------------------------挑战吉尼斯12	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000217 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000217")
	DefineMission (5532, MISSCRIPT_MISSIONSCRIPT07_LUA_000217, 754)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000218 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000218")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000218)

	MisBeginCondition(NoMission,754)
	MisBeginCondition(HasRecord,753)
	MisBeginCondition(NoRecord,754)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,754)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000219 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000219")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000219)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯12

	MISSCRIPT_MISSIONSCRIPT07_LUA_000217 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000217")
	DefineMission(5533,MISSCRIPT_MISSIONSCRIPT07_LUA_000217,754,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000220 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000220")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000220)
	MisResultCondition(HasMission, 754)
	MisResultCondition(NoRecord,754)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(ClearMission, 754)
	MisResultAction(SetRecord,  754 )
	
	


	
	-------------------------------------------------挑战吉尼斯13	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000221")
	DefineMission (5534, MISSCRIPT_MISSIONSCRIPT07_LUA_000221, 755)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000222 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000222")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000222)

	MisBeginCondition(NoMission,755)
	MisBeginCondition(HasRecord,754)
	MisBeginCondition(NoRecord,755)
	MisBeginCondition(CheckBag, 2911,0,1)
	MisBeginAction(AddMission,755)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000223 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000223")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000223)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000175)
	MisResultCondition(AlwaysFailure )

	---------------------------------------挑战吉尼斯13

	MISSCRIPT_MISSIONSCRIPT07_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000221")
	DefineMission(5535,MISSCRIPT_MISSIONSCRIPT07_LUA_000221,755,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000224 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000224")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000224)
	MisResultCondition(HasMission, 755)
	MisResultCondition(NoRecord,755)
	MisResultCondition(HasItem,2911,1)
	MisResultCondition(CheckBag, 2911,0,1)
	MisResultAction(AddChaItem2, 2912)
	MisResultAction(ClearMission, 755)
	MisResultAction(SetRecord,  755 )
	MisResultBagNeed(2)
	MisResultAction(ClearRecord, 743)---------------可以反复接
	MisResultAction(ClearRecord, 744)---------------可以反复接
	MisResultAction(ClearRecord, 745)---------------可以反复接
	MisResultAction(ClearRecord, 746)---------------可以反复接
	MisResultAction(ClearRecord, 747)---------------可以反复接
	MisResultAction(ClearRecord, 748)---------------可以反复接
	MisResultAction(ClearRecord, 749)---------------可以反复接
	MisResultAction(ClearRecord, 750)---------------可以反复接
	MisResultAction(ClearRecord, 751)---------------可以反复接
	MisResultAction(ClearRecord, 752)---------------可以反复接
	MisResultAction(ClearRecord, 753)---------------可以反复接
	MisResultAction(ClearRecord, 754)---------------可以反复接
	MisResultAction(ClearRecord, 755)---------------可以反复接

	-------------------------------------------------乱斗英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000225")
	DefineMission (5536, MISSCRIPT_MISSIONSCRIPT07_LUA_000225, 1060)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000226 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000226")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000226)

	MisBeginCondition(NoMission,1060)
	MisBeginCondition(HasRecord,833)
	MisBeginCondition(NoRecord,1060)
	MisBeginAction(AddMission,1060)
	MisCancelAction(ClearMission, 1060)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000227 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000227")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000227)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000228 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000228")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000228)

	MisResultCondition(HasMission, 1060)
	MisResultCondition(NoRecord,1060)
	MisResultCondition(HasFightingPoint,10)
	MisResultAction(TakeFightingPoint, 10 )
	MisResultAction(ClearMission, 1060)
	MisResultAction(SetRecord,  1060 )
	MisResultAction(GiveItem, 2944, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000229")
	DefineMission (5537, MISSCRIPT_MISSIONSCRIPT07_LUA_000229, 1061)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000230 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000230")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000230)

	MisBeginCondition(NoMission,1061)
	MisBeginCondition(HasRecord,833)
	MisBeginCondition(NoRecord,1061)
	MisBeginAction(AddMission,1061)
	MisCancelAction(ClearMission, 1061)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000231 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000231")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000231)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000232")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000232)

	MisResultCondition(HasMission, 1061)
	MisResultCondition(NoRecord,1061)
	MisResultCondition(HasCredit,500 )
	MisResultAction(TakeCredit, 500 )
	MisResultAction(ClearMission, 1061)
	MisResultAction(SetRecord,  1061 )
	MisResultAction(GiveItem, 2945, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000233")
	DefineMission (5538, MISSCRIPT_MISSIONSCRIPT07_LUA_000233, 1062)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000234 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000234")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000234)

	MisBeginCondition(NoMission,1062)
	MisBeginCondition(HasRecord,833)
	MisBeginCondition(NoRecord,1062)
	MisBeginAction(AddMission,1062)
	MisCancelAction(ClearMission, 1062)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000235 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000235")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000235)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000236 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000236")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000236)

	MisResultCondition(HasMission, 1062)
	MisResultCondition(NoRecord,1062)
	MisResultCondition(LvCheck, ">", 39 )
	MisResultAction(ClearMission, 1062)
	MisResultAction(SetRecord,  1062 )
	MisResultAction(GiveItem, 2946, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000237 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000237")
	DefineMission (5539, MISSCRIPT_MISSIONSCRIPT07_LUA_000237, 1063)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000238 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000238")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000238)

	MisBeginCondition(NoMission,1063)
	MisBeginCondition(HasRecord,833)
	MisBeginCondition(NoRecord,1063)
	MisBeginAction(AddMission,1063)
	MisCancelAction(ClearMission, 1063)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000239 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000239")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000239)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000240 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000240")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000240)

	MisResultCondition(HasMission, 1063)
	MisResultCondition(NoRecord,1063)
	MisResultCondition(HasHonorPoint,100 )
	MisResultAction(TakeHonorPoint, 100 )
	MisResultAction(ClearMission, 1063)
	MisResultAction(SetRecord,  1063 )
	MisResultAction(GiveItem, 2947, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000241 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000241")
	DefineMission (5540, MISSCRIPT_MISSIONSCRIPT07_LUA_000241, 1064)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000242 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000242")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000242)

	MisBeginCondition(NoMission,1064)
	MisBeginCondition(HasRecord,833)
	MisBeginCondition(NoRecord,1064)
	MisBeginAction(AddMission,1064)
	MisBeginAction(AddTrigger, 10641, TE_GETITEM, 3116, 15 )---------------精灵果15
	MisBeginAction(AddTrigger, 10642, TE_GETITEM, 1678, 15 )---------------羊绒15
	MisBeginAction(AddTrigger, 10643, TE_GETITEM, 4809, 15 )-------------南瓜头15
	MisBeginAction(AddTrigger, 10644, TE_GETITEM, 0855, 20 )---------------精灵硬币20
	MisBeginAction(AddTrigger, 10645, TE_GETITEM, 4503, 1 )---------------皇冠1个
	MisBeginAction(AddTrigger, 10646, TE_GETITEM, 1848, 50 )-------------面包50
	MisCancelAction(ClearMission, 1064)
	

	MisNeed(MIS_NEED_ITEM, 3116, 15, 1, 15 )
	MisNeed(MIS_NEED_ITEM, 1678, 15, 16, 15 )
	MisNeed(MIS_NEED_ITEM, 4809, 15, 31, 15 )
	MisNeed(MIS_NEED_ITEM, 0855, 20, 46, 20 )
	MisNeed(MIS_NEED_ITEM, 4503, 1, 66, 1 )
	MisNeed(MIS_NEED_ITEM, 1848, 50, 67, 50 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000243")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000243)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000244")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000244)

	MisResultCondition(HasMission, 1064)
	MisResultCondition(NoRecord,1064)
	MisResultCondition(HasItem, 3116, 15 )
	MisResultCondition(HasItem, 1678, 15 )
	MisResultCondition(HasItem, 4809, 15 )
	MisResultCondition(HasItem, 0855, 20 )
	MisResultCondition(HasItem, 4503, 1 )
	MisResultCondition(HasItem, 1848, 50 )

	MisResultAction(TakeItem, 3116, 15 )
	MisResultAction(TakeItem, 1678, 15 )
	MisResultAction(TakeItem, 4809, 15 )
	MisResultAction(TakeItem, 0855, 20 )
	MisResultAction(TakeItem, 4503, 1 )
	MisResultAction(TakeItem, 1848, 50 )
	MisResultAction(ClearMission, 1064)
	MisResultAction(SetRecord,  1064 )
	MisResultAction(GiveItem, 2948, 1, 4)
	MisResultAction(GiveItem, 2990, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 1064, 1, 15 )
	RegCurTrigger( 10641 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1678)	
	TriggerAction( 1, AddNextFlag, 1064, 16, 15 )
	RegCurTrigger( 10642 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4809)	
	TriggerAction( 1, AddNextFlag, 1064, 31, 15 )
	RegCurTrigger( 10643 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0855)	
	TriggerAction( 1, AddNextFlag, 1064, 46, 20 )
	RegCurTrigger( 10644 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4503)	
	TriggerAction( 1, AddNextFlag, 1064, 66, 1 )
	RegCurTrigger( 10645 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1848)	
	TriggerAction( 1, AddNextFlag, 1064, 67, 50 )
	RegCurTrigger( 10646 )

	----------------------------------------------------------沉睡的白羊----------少女莘蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000245 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000245")
	DefineMission( 5541, MISSCRIPT_MISSIONSCRIPT07_LUA_000245, 1065 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000246 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000246")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000246)
				
	MisBeginCondition(NoMission, 1065)
	MisBeginCondition(HasRecord,836)
	MisBeginCondition(NoRecord,1065)
	MisBeginAction(AddMission,1065)
	MisBeginAction(AddTrigger, 10651, TE_KILL, 1009, 1)---白羊守护者
	
	MisCancelAction(ClearMission, 1065)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000247 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000247")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000247)
	MisNeed(MIS_NEED_KILL, 1009,1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000248 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000248")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000248)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000249 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000249")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000249)
	MisResultCondition(HasMission,  1065)
	MisResultCondition(HasFlag, 1065, 10)
	MisResultCondition(NoRecord , 1065)
	MisResultAction(GiveItem, 2950, 1, 4 )
	MisResultAction(ClearMission,  1065)
	MisResultAction(SetRecord,  1065 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1009)	
	TriggerAction( 1, AddNextFlag, 1065, 10, 1 )
	RegCurTrigger( 10651 )






-------------------------------------------------乱斗英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000225")
	DefineMission (5542, MISSCRIPT_MISSIONSCRIPT07_LUA_000225, 1066)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000250 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000250")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000250)

	MisBeginCondition(NoMission,1066)
	MisBeginCondition(HasRecord,834)
	MisBeginCondition(NoRecord,1066)
	MisBeginAction(AddMission,1066)
	MisCancelAction(ClearMission, 1066)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000251 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000251")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000251)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000252 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000252")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000252)

	MisResultCondition(HasMission, 1066)
	MisResultCondition(NoRecord,1066)
	MisResultCondition(HasFightingPoint,20 )
	MisResultAction(TakeFightingPoint, 20 )
	MisResultAction(ClearMission, 1066)
	MisResultAction(SetRecord,  1066 )
	MisResultAction(GiveItem, 2944, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000229")
	DefineMission (5543, MISSCRIPT_MISSIONSCRIPT07_LUA_000229, 1067)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000253 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000253")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000253)

	MisBeginCondition(NoMission,1067)
	MisBeginCondition(HasRecord,834)
	MisBeginCondition(NoRecord,1067)
	MisBeginAction(AddMission,1067)
	MisCancelAction(ClearMission, 1067)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000231 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000231")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000231)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000232")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000232)

	MisResultCondition(HasMission, 1067)
	MisResultCondition(NoRecord,1067)
	MisResultCondition(HasCredit,1000 )
	MisResultAction(TakeCredit, 1000 )
	MisResultAction(ClearMission, 1067)
	MisResultAction(SetRecord,  1067 )
	MisResultAction(GiveItem, 2945, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000233")
	DefineMission (5544, MISSCRIPT_MISSIONSCRIPT07_LUA_000233, 1068)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000254 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000254")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000254)

	MisBeginCondition(NoMission,1068)
	MisBeginCondition(HasRecord,834)
	MisBeginCondition(NoRecord,1068)
	MisBeginAction(AddMission,1068)
	MisCancelAction(ClearMission, 1068)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000255 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000255")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000255)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000236 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000236")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000236)

	MisResultCondition(HasMission, 1068)
	MisResultCondition(NoRecord,1068)
	MisResultCondition(LvCheck, ">", 44 )
	MisResultAction(ClearMission, 1068)
	MisResultAction(SetRecord,  1068 )
	MisResultAction(GiveItem, 2946, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000237 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000237")
	DefineMission (5545, MISSCRIPT_MISSIONSCRIPT07_LUA_000237, 1069)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000256 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000256")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000256)

	MisBeginCondition(NoMission,1069)
	MisBeginCondition(HasRecord,834)
	MisBeginCondition(NoRecord,1069)
	MisBeginAction(AddMission,1069)
	MisCancelAction(ClearMission, 1069)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000239 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000239")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000239)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000240 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000240")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000240)

	MisResultCondition(HasMission, 1069)
	MisResultCondition(NoRecord,1069)
	MisResultCondition(HasHonorPoint,200 )
	MisResultAction(TakeHonorPoint, 200 )
	MisResultAction(ClearMission, 1069)
	MisResultAction(SetRecord,  1069 )
	MisResultAction(GiveItem, 2947, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000241 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000241")
	DefineMission (5546, MISSCRIPT_MISSIONSCRIPT07_LUA_000241, 1070)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000242 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000242")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000242)

	MisBeginCondition(NoMission,1070)
	MisBeginCondition(HasRecord,834)
	MisBeginCondition(NoRecord,1070)
	MisBeginAction(AddMission,1070)
	MisBeginAction(AddTrigger, 10701, TE_GETITEM, 3116, 15 )---------------精灵果15
	MisBeginAction(AddTrigger, 10702, TE_GETITEM, 1678, 15 )---------------羊绒15
	MisBeginAction(AddTrigger, 10703, TE_GETITEM, 4809, 15 )-------------南瓜头15
	MisBeginAction(AddTrigger, 10704, TE_GETITEM, 0855, 20 )---------------精灵硬币20
	MisBeginAction(AddTrigger, 10705, TE_GETITEM, 4503, 1 )---------------皇冠1个
	MisBeginAction(AddTrigger, 10706, TE_GETITEM, 1848, 40 )-------------蛋糕40
	MisBeginAction(AddTrigger, 10707, TE_GETITEM, 2673, 10 )-------------幻影发生器LV1  10
	MisCancelAction(ClearMission, 1070)
	

	MisNeed(MIS_NEED_ITEM, 3116, 15, 1, 15 )
	MisNeed(MIS_NEED_ITEM, 1678, 15, 16, 15 )
	MisNeed(MIS_NEED_ITEM, 4809, 15, 31, 15 )
	MisNeed(MIS_NEED_ITEM, 0855, 20, 46, 20 )
	MisNeed(MIS_NEED_ITEM, 4503, 1, 66, 1 )
	MisNeed(MIS_NEED_ITEM, 1848, 40, 67, 40 )
	MisNeed(MIS_NEED_ITEM, 2673, 10, 107, 10 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000243")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000243)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000244")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000244)

	MisResultCondition(HasMission, 1070)
	MisResultCondition(NoRecord,1070)
	MisResultCondition(HasItem, 3116, 15 )
	MisResultCondition(HasItem, 1678, 15 )
	MisResultCondition(HasItem, 4809, 15 )
	MisResultCondition(HasItem, 0855, 20 )
	MisResultCondition(HasItem, 4503, 1 )
	MisResultCondition(HasItem, 1848, 40 )
	MisResultCondition(HasItem, 2673, 10 )

	MisResultAction(TakeItem, 3116, 15 )
	MisResultAction(TakeItem, 1678, 15 )
	MisResultAction(TakeItem, 4809, 15 )
	MisResultAction(TakeItem, 0855, 20 )
	MisResultAction(TakeItem, 4503, 1 )
	MisResultAction(TakeItem, 1848, 40 )
	MisResultAction(TakeItem, 2673, 10 )
	MisResultAction(ClearMission, 1070)
	MisResultAction(SetRecord,  1070 )
	MisResultAction(GiveItem, 2948, 1, 4)
	MisResultAction(GiveItem, 2990, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 1070, 1, 15 )
	RegCurTrigger( 10701 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1678)	
	TriggerAction( 1, AddNextFlag, 1070, 16, 15 )
	RegCurTrigger( 10702 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4809)	
	TriggerAction( 1, AddNextFlag, 1070, 31, 15 )
	RegCurTrigger( 10703 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0855)	
	TriggerAction( 1, AddNextFlag, 1070, 46, 20 )
	RegCurTrigger( 10704 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4503)	
	TriggerAction( 1, AddNextFlag, 1070, 66, 1 )
	RegCurTrigger( 10705 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1848)	
	TriggerAction( 1, AddNextFlag, 1070, 67, 40 )
	RegCurTrigger( 10706 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2673)	
	TriggerAction( 1, AddNextFlag, 1070, 107, 10 )
	RegCurTrigger( 10707 )

	



-------------------------------------------------乱斗英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000225")
	DefineMission (5547, MISSCRIPT_MISSIONSCRIPT07_LUA_000225, 1071)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000257 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000257")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000257)

	MisBeginCondition(NoMission,1071)
	MisBeginCondition(HasRecord,835)
	MisBeginCondition(NoRecord,1071)
	MisBeginAction(AddMission,1071)
	MisCancelAction(ClearMission, 1071)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000258 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000258")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000258)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000259 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000259")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000259)

	MisResultCondition(HasMission, 1071)
	MisResultCondition(NoRecord,1071)
	MisResultCondition(HasFightingPoint,50 )
	MisResultAction(TakeFightingPoint, 50 )
	MisResultAction(ClearMission, 1071)
	MisResultAction(SetRecord,  1071 )
	MisResultAction(GiveItem, 2944, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000229")
	DefineMission (5548, MISSCRIPT_MISSIONSCRIPT07_LUA_000229, 1072)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000260 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000260")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000260)

	MisBeginCondition(NoMission,1072)
	MisBeginCondition(HasRecord,835)
	MisBeginCondition(NoRecord,1072)
	MisBeginAction(AddMission,1072)
	MisCancelAction(ClearMission, 1072)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000231 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000231")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000231)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000232")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000232)

	MisResultCondition(HasMission, 1072)
	MisResultCondition(NoRecord,1072)
	MisResultCondition(HasCredit,3000 )
	MisResultAction(TakeCredit, 3000 )
	MisResultAction(ClearMission, 1072)
	MisResultAction(SetRecord,  1072 )
	MisResultAction(GiveItem, 2945, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000233")
	DefineMission (5549, MISSCRIPT_MISSIONSCRIPT07_LUA_000233, 1073)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000261 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000261")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000261)

	MisBeginCondition(NoMission,1073)
	MisBeginCondition(HasRecord,835)
	MisBeginCondition(NoRecord,1073)
	MisBeginAction(AddMission,1073)
	MisCancelAction(ClearMission, 1073)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000262 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000262")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000262)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000236 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000236")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000236)

	MisResultCondition(HasMission, 1073)
	MisResultCondition(NoRecord,1073)
	MisResultCondition(LvCheck, ">", 49 )
	MisResultAction(ClearMission, 1073)
	MisResultAction(SetRecord,  1073 )
	MisResultAction(GiveItem, 2946, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000237 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000237")
	DefineMission (5550, MISSCRIPT_MISSIONSCRIPT07_LUA_000237, 1074)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000263 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000263")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000263)

	MisBeginCondition(NoMission,1074)
	MisBeginCondition(HasRecord,835)
	MisBeginCondition(NoRecord,1074)
	MisBeginAction(AddMission,1074)
	MisCancelAction(ClearMission, 1074)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000239 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000239")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000239)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000240 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000240")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000240)

	MisResultCondition(HasMission, 1074)
	MisResultCondition(NoRecord,1074)
	MisResultCondition(HasHonorPoint,500 )
	MisResultAction(TakeHonorPoint, 500 )
	MisResultAction(ClearMission, 1074)
	MisResultAction(SetRecord,  1074 )
	MisResultAction(GiveItem, 2947, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------少女莘蒂	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000241 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000241")
	DefineMission (5551, MISSCRIPT_MISSIONSCRIPT07_LUA_000241, 1075)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000242 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000242")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000242)

	MisBeginCondition(NoMission,1075)
	MisBeginCondition(HasRecord,835)
	MisBeginCondition(NoRecord,1075)
	MisBeginAction(AddMission,1075)
	MisBeginAction(AddTrigger, 10751, TE_GETITEM, 3116, 15 )---------------精灵果15
	MisBeginAction(AddTrigger, 10752, TE_GETITEM, 1678, 15 )---------------羊绒15
	MisBeginAction(AddTrigger, 10753, TE_GETITEM, 4809, 15 )-------------南瓜头15
	MisBeginAction(AddTrigger, 10754, TE_GETITEM, 0855, 20 )---------------精灵硬币20
	MisBeginAction(AddTrigger, 10755, TE_GETITEM, 4503, 1 )---------------皇冠1个
	MisBeginAction(AddTrigger, 10756, TE_GETITEM, 1848, 40 )-------------蛋糕40
	MisBeginAction(AddTrigger, 10757, TE_GETITEM, 2673, 10 )-------------幻影发生器LV1  10
	MisBeginAction(AddTrigger, 10758, TE_GETITEM, 0227, 4 )-------------守护精灵饲料  4
	MisCancelAction(ClearMission, 1075)
	

	MisNeed(MIS_NEED_ITEM, 3116, 15, 1, 15 )
	MisNeed(MIS_NEED_ITEM, 1678, 15, 16, 15 )
	MisNeed(MIS_NEED_ITEM, 4809, 15, 31, 15 )
	MisNeed(MIS_NEED_ITEM, 0855, 20, 46, 20 )
	MisNeed(MIS_NEED_ITEM, 4503, 1, 66, 1 )
	MisNeed(MIS_NEED_ITEM, 1848, 40, 67, 40 )
	MisNeed(MIS_NEED_ITEM, 2673, 10, 107, 10 )
	MisNeed(MIS_NEED_ITEM, 0227, 4, 117, 4 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000243")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000243)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000244")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000244)

	MisResultCondition(HasMission, 1075)
	MisResultCondition(NoRecord,1075)
	MisResultCondition(HasItem, 3116, 15 )
	MisResultCondition(HasItem, 1678, 15 )
	MisResultCondition(HasItem, 4809, 15 )
	MisResultCondition(HasItem, 0855, 20 )
	MisResultCondition(HasItem, 4503, 1 )
	MisResultCondition(HasItem, 1848, 40 )
	MisResultCondition(HasItem, 2673, 10 )
	MisResultCondition(HasItem, 0227, 4 )

	MisResultAction(TakeItem, 3116, 15 )
	MisResultAction(TakeItem, 1678, 15 )
	MisResultAction(TakeItem, 4809, 15 )
	MisResultAction(TakeItem, 0855, 20 )
	MisResultAction(TakeItem, 4503, 1 )
	MisResultAction(TakeItem, 1848, 40 )
	MisResultAction(TakeItem, 2673, 10 )
	MisResultAction(TakeItem, 0227, 4 )
	MisResultAction(ClearMission, 1075)
	MisResultAction(SetRecord,  1075 )
	MisResultAction(GiveItem, 2948, 1, 4)
	MisResultAction(GiveItem, 2990, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 1075, 1, 15 )
	RegCurTrigger( 10751 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1678)	
	TriggerAction( 1, AddNextFlag, 1075, 16, 15 )
	RegCurTrigger( 10752 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4809)	
	TriggerAction( 1, AddNextFlag, 1075, 31, 15 )
	RegCurTrigger( 10753 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0855)	
	TriggerAction( 1, AddNextFlag, 1075, 46, 20 )
	RegCurTrigger( 10754 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4503)	
	TriggerAction( 1, AddNextFlag, 1075, 66, 1 )
	RegCurTrigger( 10755 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1848)	
	TriggerAction( 1, AddNextFlag, 1075, 67, 40 )
	RegCurTrigger( 10756 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2673)	
	TriggerAction( 1, AddNextFlag, 1075, 107, 10 )
	RegCurTrigger( 10757 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0227)	
	TriggerAction( 1, AddNextFlag, 1075, 117, 4 )
	RegCurTrigger( 10758 )


	

	----------------------------------------------------------社交大使----------少女莘蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000264 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000264")
	DefineMission( 5552, MISSCRIPT_MISSIONSCRIPT07_LUA_000264, 1076 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000265 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000265")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000265)
				
	MisBeginCondition(NoMission, 1076)
	MisBeginCondition(NoRecord,1076)
	MisBeginCondition(HasRecord, 836)
	MisBeginAction(AddMission,1076)
	MisCancelAction(ClearMission, 1076)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000266 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000266")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000266)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000267 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000267")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000267)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使-----------------人鱼王子·哈沙特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000268 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000268")
	DefineMission(5553, MISSCRIPT_MISSIONSCRIPT07_LUA_000268, 1076, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000269 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000269")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000269)
	MisResultCondition(NoRecord, 1076)
	MisResultCondition(HasMission,1076)
	MisResultAction(ClearMission,1076)
	MisResultAction(SetRecord, 1076)

	----------------------------------------------------------社交大使1----------人鱼王子·哈沙特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission( 5554, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1077 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000271 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000271")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000271)
	MisBeginCondition(NoMission, 1077)
	MisBeginCondition(NoRecord,1077)
	MisBeginCondition(HasRecord, 1076)
	MisBeginAction(AddMission,1077)
	MisCancelAction(ClearMission, 1077)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000272 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000272")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000272)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000273 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000273")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000273)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使1-------------草莓优优
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission(5555, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1077, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000274 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000274")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000274)
	MisResultCondition(NoRecord, 1077)
	MisResultCondition(HasMission,1077)
	MisResultAction(ClearMission,1077)
	MisResultAction(SetRecord, 1077)

	----------------------------------------------------------社交大使2----------草莓优优
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission( 5556, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1078 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000276 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000276")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000276)
				
	MisBeginCondition(NoMission, 1078)
	MisBeginCondition(NoRecord,1078)
	MisBeginCondition(HasRecord, 1077)
	MisBeginAction(AddMission,1078)
	MisCancelAction(ClearMission, 1078)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000277 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000277")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000277)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000278 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000278")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000278)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使2--------老者·糊涂山人
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission(5557, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1078, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000279 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000279")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000279)
	MisResultCondition(NoRecord, 1078)
	MisResultCondition(HasMission,1078)
	MisResultAction(ClearMission,1078)
	MisResultAction(SetRecord, 1078)



	----------------------------------------------------------社交大使3----------老者·糊涂山人
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission( 5558, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1079 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000281 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000281")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000281)
				
	MisBeginCondition(NoMission, 1079)
	MisBeginCondition(NoRecord,1079)
	MisBeginCondition(HasRecord, 1078)
	MisBeginAction(AddMission,1079)
	MisCancelAction(ClearMission, 1079)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000282 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000282")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000282)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000283 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000283")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000283)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使3--------乐器专家·沙梅洱
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission(5559, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1079, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000284 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000284")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000284)
	MisResultCondition(NoRecord, 1079)
	MisResultCondition(HasMission,1079)
	MisResultAction(ClearMission,1079)
	MisResultAction(SetRecord, 1079)


	----------------------------------------------------------社交大使4----------乐器专家·沙梅洱
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission( 5560, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1080 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000286")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000286)
				
	MisBeginCondition(NoMission, 1080)
	MisBeginCondition(NoRecord,1080)
	MisBeginCondition(HasRecord, 1079)
	MisBeginAction(AddMission,1080)
	MisCancelAction(ClearMission, 1080)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000287 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000287")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000287)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000288 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000288")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000288)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使4--------鲁鲁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission(5561, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1080, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000289 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000289")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000289)
	MisResultCondition(NoRecord, 1080)
	MisResultCondition(HasMission,1080)
	MisResultAction(ClearMission,1080)
	MisResultAction(SetRecord, 1080)


	----------------------------------------------------------社交大使5----------鲁鲁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission( 5562, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1081 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000291 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000291")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000291)
				
	MisBeginCondition(NoMission, 1081)
	MisBeginCondition(NoRecord,1081)
	MisBeginCondition(HasRecord, 1080)
	MisBeginAction(AddMission,1081)
	MisCancelAction(ClearMission, 1081)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000292 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000292")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000292)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000293 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000293")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000293)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使5--------古力果
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission(5563, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1081, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000294 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000294")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000294)
	MisResultCondition(NoRecord, 1081)
	MisResultCondition(HasMission,1081)
	MisResultAction(ClearMission,1081)
	MisResultAction(SetRecord, 1081)



	----------------------------------------------------------社交大使6----------古力果
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission( 5564, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1082 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000296 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000296")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000296)
				
	MisBeginCondition(NoMission, 1082)
	MisBeginCondition(NoRecord,1082)
	MisBeginCondition(HasRecord, 1081)
	MisBeginAction(AddMission,1082)
	MisCancelAction(ClearMission, 1082)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000297 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000297")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000297)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000298 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000298")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000298)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使6--------小羊·威利
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission(5565, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1082, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000299 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000299")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000299)
	MisResultCondition(NoRecord, 1082)
	MisResultCondition(HasMission,1082)
	MisResultAction(ClearMission,1082)
	MisResultAction(SetRecord, 1082)


	----------------------------------------------------------社交大使7----------小羊·威利
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission( 5566, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1083 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000301 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000301")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000301)
				
	MisBeginCondition(NoMission, 1083)
	MisBeginCondition(NoRecord,1083)
	MisBeginCondition(HasRecord, 1082)
	MisBeginAction(AddMission,1083)
	MisCancelAction(ClearMission, 1083)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000302 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000302")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000302)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000303 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000303")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000303)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使8--------旅行医生·米奈希尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission(5567, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1083, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000304 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000304")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000304)
	MisResultCondition(NoRecord, 1083)
	MisResultCondition(HasMission,1083)
	MisResultAction(ClearMission,1083)
	MisResultAction(SetRecord, 1083)


	----------------------------------------------------------社交大使8----------旅行医生·米奈希尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission( 5568, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1084 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000306 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000306")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000306)
				
	MisBeginCondition(NoMission, 1084)
	MisBeginCondition(NoRecord,1084)
	MisBeginCondition(HasRecord, 1083)
	MisBeginAction(AddMission,1084)
	MisCancelAction(ClearMission, 1084)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000307 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000307")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000307)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000308")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000308)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使8--------菲菲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission(5569, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1084, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000309 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000309")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000309)
	MisResultCondition(NoRecord, 1084)
	MisResultCondition(HasMission,1084)
	MisResultAction(ClearMission,1084)
	MisResultAction(SetRecord, 1084)

	----------------------------------------------------------社交大使10----------菲菲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission( 5572, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1086 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000311 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000311")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000311)
				
	MisBeginCondition(NoMission, 1086)
	MisBeginCondition(NoRecord,1086)
	MisBeginCondition(HasRecord, 1084)
	MisBeginAction(AddMission,1086)
	MisCancelAction(ClearMission, 1086)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000312 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000312")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000312)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000313 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000313")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000313)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使10--------伊丽莎白
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission(5573, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1086, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000314 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000314")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000314)
	MisResultCondition(NoRecord, 1086)
	MisResultCondition(HasMission,1086)
	MisResultAction(ClearMission,1086)
	MisResultAction(SetRecord, 1086)

	----------------------------------------------------------社交大使11----------伊丽莎白
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission( 5574, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1087 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000316 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000316")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000316)
				
	MisBeginCondition(NoMission, 1087)
	MisBeginCondition(NoRecord,1087)
	MisBeginCondition(HasRecord, 1086)
	MisBeginAction(AddMission,1087)
	MisCancelAction(ClearMission, 1087)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000317 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000317")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000317)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000318 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000318")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000318)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使11--------海军总部指挥官·基.埃斯西准将
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission(5575, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1087, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000319 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000319")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000319)
	MisResultCondition(NoRecord, 1087)
	MisResultCondition(HasMission,1087)
	MisResultAction(ClearMission,1087)
	MisResultAction(SetRecord, 1087)

	----------------------------------------------------------社交大使12----------海军总部指挥官·基.埃斯西准将
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission( 5576, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1088 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000321 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000321")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000321)
				
	MisBeginCondition(NoMission, 1088)
	MisBeginCondition(NoRecord,1088)
	MisBeginCondition(HasRecord, 1087)
	MisBeginAction(AddMission,1088)
	MisCancelAction(ClearMission, 1088)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000322 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000322")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000322)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000323 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000323")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000323)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使12--------蘑蘑
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission(5577, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1088, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000324 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000324")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000324)
	MisResultCondition(NoRecord, 1088)
	MisResultCondition(HasMission,1088)
	MisResultAction(ClearMission,1088)
	MisResultAction(SetRecord, 1088)


	----------------------------------------------------------社交大使13----------蘑蘑
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission( 5578, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1089 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000326 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000326")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000326)
				
	MisBeginCondition(NoMission, 1089)
	MisBeginCondition(NoRecord,1089)
	MisBeginCondition(HasRecord, 1088)
	MisBeginAction(AddMission,1089)
	MisCancelAction(ClearMission, 1089)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000327 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000327")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000327)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000328 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000328")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000328)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使13--------淘淘
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission(5579, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1089, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000329 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000329")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000329)
	MisResultCondition(NoRecord, 1089)
	MisResultCondition(HasMission,1089)
	MisResultAction(ClearMission,1089)
	MisResultAction(SetRecord, 1089)

	----------------------------------------------------------社交大使14----------淘淘
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission( 5580, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1090 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000331 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000331")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000331)
				
	MisBeginCondition(NoMission, 1090)
	MisBeginCondition(NoRecord,1090)
	MisBeginCondition(HasRecord, 1089)
	MisBeginAction(AddMission,1090)
	MisCancelAction(ClearMission, 1090)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000332 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000332")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000332)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000333 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000333")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000333)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使14--------温莉·冰泉        
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission(5581, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1090, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000334 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000334")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000334)
	MisResultCondition(NoRecord, 1090)
	MisResultCondition(HasMission,1090)
	MisResultAction(ClearMission,1090)
	MisResultAction(SetRecord, 1090)

	----------------------------------------------------------社交大使15----------温莉·冰泉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission( 5582, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1091 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000336 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000336")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000336)
				
	MisBeginCondition(NoMission, 1091)
	MisBeginCondition(NoRecord,1091)
	MisBeginCondition(HasRecord, 1090)
	MisBeginAction(AddMission,1091)
	MisCancelAction(ClearMission, 1091)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000337 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000337")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000337)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000338 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000338")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000338)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使15-------- 瑞得·皮戈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission(5583, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1091, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000339 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000339")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000339)
	MisResultCondition(NoRecord, 1091)
	MisResultCondition(HasMission,1091)
	MisResultAction(ClearMission,1091)
	MisResultAction(SetRecord, 1091)


	----------------------------------------------------------社交大使16----------瑞得·皮戈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission( 5584, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1092 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000341 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000341")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000341)
				
	MisBeginCondition(NoMission, 1092)
	MisBeginCondition(NoRecord,1092)
	MisBeginCondition(HasRecord, 1091)
	MisBeginAction(AddMission,1092)
	MisCancelAction(ClearMission, 1092)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000342 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000342")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000342)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000343 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000343")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000343)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使16-------- 通灵者·月光眼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission(5585, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1092, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000344 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000344")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000344)
	MisResultCondition(NoRecord, 1092)
	MisResultCondition(HasMission,1092)
	MisResultAction(ClearMission,1092)
	MisResultAction(SetRecord, 1092)


	----------------------------------------------------------社交大使17----------通灵者·月光眼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission( 5586, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1093 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000346 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000346")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000346)
				
	MisBeginCondition(NoMission, 1093)
	MisBeginCondition(NoRecord,1093)
	MisBeginCondition(HasRecord, 1092)
	MisBeginAction(AddMission,1093)
	MisCancelAction(ClearMission, 1093)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000347 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000347")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000347)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000348 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000348")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000348)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使17-------- 榴莲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission(5587, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1093, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000349 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000349")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000349)
	MisResultCondition(NoRecord, 1093)
	MisResultCondition(HasMission,1093)
	MisResultAction(ClearMission,1093)
	MisResultAction(SetRecord, 1093)

	----------------------------------------------------------社交大使18----------榴莲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission( 5588, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1094 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000351 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000351")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000351)
				
	MisBeginCondition(NoMission, 1094)
	MisBeginCondition(NoRecord,1094)
	MisBeginCondition(HasRecord, 1093)
	MisBeginAction(AddMission,1094)
	MisCancelAction(ClearMission, 1094)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000352 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000352")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000352)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000353 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000353")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000353)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使18-------- 奈奈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission(5589, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1094, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000354 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000354")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000354)
	MisResultCondition(NoRecord, 1094)
	MisResultCondition(HasMission,1094)
	MisResultAction(ClearMission,1094)
	MisResultAction(SetRecord, 1094)

	----------------------------------------------------------社交大使19----------奈奈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission( 5590, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1095 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000356 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000356")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000356)
				
	MisBeginCondition(NoMission, 1095)
	MisBeginCondition(NoRecord,1095)
	MisBeginCondition(HasRecord, 1094)
	MisBeginAction(AddMission,1095)
	MisCancelAction(ClearMission, 1095)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000357 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000357")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000357)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000358 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000358")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000358)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使19-------- 海蓝·微风
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission(5591, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1095, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000359 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000359")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000359)
	MisResultCondition(NoRecord, 1095)
	MisResultCondition(HasMission,1095)
	MisResultAction(ClearMission,1095)
	MisResultAction(SetRecord, 1095)


		----------------------------------------------------------社交大使20----------海蓝·微风
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission( 5592, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1096 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000361 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000361")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000361)
				
	MisBeginCondition(NoMission, 1096)
	MisBeginCondition(NoRecord,1096)
	MisBeginCondition(HasRecord, 1095)
	MisBeginAction(AddMission,1096)
	MisCancelAction(ClearMission, 1096)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000362 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000362")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000362)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000363 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000363")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000363)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使20-------- 地狱传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission(5593, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1096, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000364 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000364")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000364)
	MisResultCondition(NoRecord, 1096)
	MisResultCondition(HasMission,1096)
	MisResultAction(ClearMission,1096)
	MisResultAction(SetRecord, 1096)

		----------------------------------------------------------社交大使21----------地狱传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000365")
	DefineMission( 5594, MISSCRIPT_MISSIONSCRIPT07_LUA_000365, 1097 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000366 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000366")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000366)
				
	MisBeginCondition(NoMission, 1097)
	MisBeginCondition(NoRecord,1097)
	MisBeginCondition(HasRecord, 1096)
	MisBeginAction(AddMission,1097)
	MisCancelAction(ClearMission, 1097)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000367 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000367")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000367)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000368")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000368)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使21-------- 天堂传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000365")
	DefineMission(5595, MISSCRIPT_MISSIONSCRIPT07_LUA_000365, 1097, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000369 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000369")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000369)
	MisResultCondition(NoRecord, 1097)
	MisResultCondition(HasMission,1097)
	MisResultAction(ClearMission,1097)
	MisResultAction(SetRecord, 1097)

	----------------------------------------------------------社交英雄22----------天堂传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000370 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000370")
	DefineMission( 5596, MISSCRIPT_MISSIONSCRIPT07_LUA_000370, 1098 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000371")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000371)
				
	MisBeginCondition(NoMission, 1098)
	MisBeginCondition(NoRecord,1098)
	MisBeginCondition(HasRecord, 1097)
	MisBeginAction(AddMission,1098)
	MisCancelAction(ClearMission, 1098)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000372 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000372")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000372)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000368")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000368)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交英雄22------- 辛蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000370 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000370")
	DefineMission(5597, MISSCRIPT_MISSIONSCRIPT07_LUA_000370, 1098, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000373 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000373")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000373)
	MisResultCondition(NoRecord, 1098)
	MisResultCondition(HasMission,1098)
	MisResultAction(ClearMission,1098)
	MisResultAction(SetRecord, 1098)
	MisResultAction(GiveItem, 2949, 1, 4)
	MisResultBagNeed(1)




	

	-------------------------------------------------特别任务	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000374 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000374")
	DefineMission (5600, MISSCRIPT_MISSIONSCRIPT07_LUA_000374, 1101)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000375 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000375")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000375)

	MisBeginCondition(NoMission,1101)
	MisBeginCondition(NoRecord,1101)
	MisBeginCondition(HasRecord,835)
	MisBeginCondition(HasRecord,1071)
	MisBeginCondition(HasRecord,1072)
	MisBeginCondition(HasRecord,1073)
	MisBeginCondition(HasRecord,1074)
	MisBeginCondition(HasRecord,1075)
	MisBeginCondition(HasRecord,1065)
	MisBeginCondition(HasRecord,1098)
	MisBeginAction(AddMission,1101)
	MisBeginAction(AddChaItem3, 2952)---------特别行动卡
	MisBeginAction(AddTrigger, 11011, TE_KILL, 75, 99 )
	MisCancelAction(ClearMission, 1101)
	MisBeginBagNeed(1)
	
	MisNeed(MIS_NEED_KILL, 75, 99, 1, 99)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000376 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000376")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000376)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000377 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000377")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000377)


	MisResultCondition(HasMission, 1101)
	MisResultCondition(NoRecord,1101)
	MisResultCondition(HasFlag, 1101, 99 )
	MisResultAction(AddChaItem4, 2952)----特别行动卡
	MisResultAction(ClearMission, 1101)
	MisResultAction(SetRecord,  1101 )
	MisResultAction(GiveItem, 2955, 1, 4)------------白羊船长酷装宝箱
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 75)	
	TriggerAction( 1, AddNextFlag, 1101, 1, 99 )
	RegCurTrigger( 11011 )





	----------------------------------------------------------愚人节的果实
	MISSCRIPT_MISSIONSCRIPT07_LUA_000378 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000378")
	DefineMission( 5601, MISSCRIPT_MISSIONSCRIPT07_LUA_000378, 1102)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000379 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000379")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000379 )
	MisBeginCondition(NoRecord, 1102)
	MisBeginCondition(NoMission, 1102)
	MisBeginCondition(LvCheck, ">", 10 )
	MisBeginAction(AddMission, 1102)
	MisBeginAction(AddTrigger, 11021, TE_GETITEM, 3116, 100 )		
	MisCancelAction(ClearMission, 1102)
	
	MisNeed(MIS_NEED_ITEM, 3116, 100, 10, 100)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000380 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000380")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000380)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000381")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000381)
	MisResultCondition(HasMission, 1102)
	MisResultCondition(HasItem, 3116, 100 )
	MisResultAction(TakeItem, 3116, 100 )
	MisResultAction(ClearMission, 1102)
	MisResultAction(SetRecord, 1102 )
	MisResultAction(GiveItem, 2953, 1, 4)------------愚人节的礼物
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 1102, 10, 100 )
	RegCurTrigger( 11021 )



	------------------------------------------------------愚人节的慷慨
	MISSCRIPT_MISSIONSCRIPT07_LUA_000382 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000382")
	DefineMission( 5602, MISSCRIPT_MISSIONSCRIPT07_LUA_000382, 1103)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000383 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000383")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000383 )
	MisBeginCondition(NoRecord, 1103)
	MisBeginCondition(HasRecord, 1102)
	MisBeginCondition(NoMission, 1103)
	MisBeginAction(AddMission, 1103)	
	MisCancelAction(ClearMission, 1103)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000384 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000384")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000384)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000385 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000385")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000385)
	MisResultCondition(HasMission, 1103)
	MisResultCondition(HasMoney, 1000000 )
	MisResultAction(TakeMoney, 1000000 )
	MisResultAction(ClearMission, 1103)
	MisResultAction(SetRecord, 1103 )



	------------------------------------------------------愚人节的死神
	MISSCRIPT_MISSIONSCRIPT07_LUA_000386 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000386")
	DefineMission( 5603, MISSCRIPT_MISSIONSCRIPT07_LUA_000386, 1104)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000387 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000387")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000387 )
	MisBeginCondition(NoRecord, 1104)
	MisBeginCondition(HasRecord, 1103)
	MisBeginCondition(NoMission, 1104)
	MisBeginCondition(HaveNoItem, 2954)
	MisBeginAction(AddMission, 1104)	
	MisBeginAction(GiveItem, 2954, 1, 4)------------死亡证明
	MisCancelAction(ClearMission, 1104)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000388 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000388")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000388)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000389 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000389")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000389)
	MisResultCondition(HasMission, 1104)
	MisResultCondition(CheckPoint, 2954 )
	MisResultAction(TakeItem, 2954,1,4)
	MisResultAction(GiveItem, 0853,1,4)
	MisResultAction(ClearMission, 1104)
	MisResultAction(SetRecord, 1104 )
	MisResultBagNeed(1)


--------------------------------------------------谁是守护者--------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000140")
	DefineMission( 6015, MISSCRIPT_MISSIONSCRIPT07_LUA_000140, 1013, COMPLETE_SHOW )

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000390 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000390")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000390)
	MisResultCondition(NoRecord, 1013)
	MisResultCondition(HasMission, 1013)
	MisResultAction(SetRecord, 1013)
	MisResultAction(ClearMission, 1013)

--------------------------------------------------难？还是烦？-------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000391 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000391")
	DefineMission( 6016, MISSCRIPT_MISSIONSCRIPT07_LUA_000391, 1014)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000392 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000392")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000392)
	MisBeginCondition(NoRecord, 1014)
	MisBeginCondition(NoMission, 1014)
	MisBeginCondition(HasRecord, 1013)
	MisBeginAction(AddMission, 1014)
	MisBeginAction(ZSSTART)
	MisCancelAction(ClearMission, 1014)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000393 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000393")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000393)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000394 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000394")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000394)

	MisResultCondition(AlwaysFailure)



---------------------------------------------------难？还是烦？----------氏族长·阿布多罗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000395 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000395")
	DefineMission( 6017, MISSCRIPT_MISSIONSCRIPT07_LUA_000395, 1014, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000396 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000396")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000396)
	MisResultCondition(NoRecord, 1014)
	MisResultCondition(HasMission, 1014)
	MisResultCondition(HasRecord, 1059)
	MisResultAction(ClearMission, 1014)
	MisResultAction(SetRecord, 1014)

---------------------------------------------------继续转生之路-----------氏族长·阿布多罗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000397 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000397")
	DefineMission( 6018, MISSCRIPT_MISSIONSCRIPT07_LUA_000397, 1017)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000398 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000398")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000398)
	MisBeginCondition(NoRecord, 1017)
	MisBeginCondition(NoMission, 1017)
	MisBeginCondition(HasRecord, 1014)
	MisBeginAction(AddMission, 1017)
	MisCancelAction(ClearMission, 1017)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000399 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000399")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000399)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000400 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000400")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000400)

	MisResultCondition(AlwaysFailure)

--------------------------------------------------继续转生之路---------------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000397 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000397")
	DefineMission( 6019, MISSCRIPT_MISSIONSCRIPT07_LUA_000397, 1017, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000401 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000401")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000401)
	MisResultCondition(NoRecord, 1017)
	MisResultCondition(HasMission, 1017)
	MisResultAction(ClearMission, 1017)
	MisResultAction(SetRecord, 1017)

---------------------------------------------------艰巨的任务---------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000402 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000402")
	DefineMission( 6020, MISSCRIPT_MISSIONSCRIPT07_LUA_000402, 1018)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000403 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000403")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000403)
	MisBeginCondition(NoRecord,1000)
	MisBeginCondition(HasRecord,1017)
	MisBeginCondition(HasRecord,1015)
	MisBeginCondition(NoRecord,1018)
	MisBeginCondition(NoMission,1018)
	MisBeginAction(AddMission,1018)
	MisBeginAction(AddTrigger, 10181, TE_KILL,678, 1)
	MisBeginAction(AddTrigger, 10182, TE_KILL,679, 1)
	MisBeginAction(AddTrigger, 10183, TE_KILL,789, 1)
	MisCancelAction(ClearMission,1018)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000404 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000404")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000404)
	MisNeed(MIS_NEED_KILL, 678, 1, 10, 1)
	MisNeed(MIS_NEED_KILL, 679, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 789, 1, 30, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000405 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000405")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000405)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000406 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000406")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000406)
	MisResultCondition(HasMission,1018)
	MisResultCondition(NoRecord,1018)
	MisResultCondition(HasFlag, 1018, 10)
	MisResultCondition(HasFlag, 1018, 20)
	MisResultCondition(HasFlag, 1018, 30)
	MisResultAction(SetRecord,1018)
	MisResultAction(SetRecord,1056)
	MisResultAction(ClearMission,1018)
	MisResultAction(GiveItem, 2229, 1, 4)
	MisResultAction(GiveItem, 2230, 1, 4)
	MisResultAction(GiveItem, 2231, 1, 4)
	MisResultAction(GiveItem, 2232, 1, 4)
	MisResultAction(GiveItem, 2233, 1, 4)
	MisResultBagNeed(5)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 678 )
	TriggerAction( 1, AddNextFlag, 1018, 10, 1 )
	RegCurTrigger( 10181 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 679 )
	TriggerAction( 1, AddNextFlag, 1018, 20, 1 )
	RegCurTrigger( 10182 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 789 )
	TriggerAction( 1, AddNextFlag, 1018, 30, 1 )
	RegCurTrigger( 10183 )

----------------------------------------------限时的挑战---------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000407")
	DefineMission( 6021, MISSCRIPT_MISSIONSCRIPT07_LUA_000407, 1019)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000408 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000408")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000408)
	MisBeginCondition( NoRecord, 1000)
	MisBeginCondition( NoRecord, 1019)
	MisBeginCondition( NoMission, 1019)
	MisBeginCondition( HasRecord, 1017)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1019)
	MisBeginAction(SetFlag, 1019, 1)
	MisBeginAction(AddTrigger, 10191, TE_GETITEM, 4528, 5 )
	MisBeginAction(AddTrigger, 10192, TE_GETITEM, 4515, 5 )
	MisBeginAction(AddTrigger, 10193, TE_GETITEM, 1310, 5 )
	MisBeginAction(AddTrigger, 10194, TE_GETITEM, 4998, 5 )
	MisBeginAction(AddTrigger, 10195, TE_GETITEM, 4991, 5 )
	MisCancelAction(ClearMission,1019)

	--MisNeed(MIS_NEED_DESP, "在30分钟内完成挑战吉尼斯")
	MisNeed(MIS_NEED_ITEM, 4528, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4515, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 1310, 5, 30, 5)
	MisNeed(MIS_NEED_ITEM, 4998, 5, 40, 5)
	MisNeed(MIS_NEED_ITEM, 4991, 5, 50, 5)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000409 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000409")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000409)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000410 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000410")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000410)
	MisResultCondition( HasItem, 4528, 5)
	MisResultCondition( HasItem, 4515, 5)
	MisResultCondition( HasItem, 1310, 5)
	MisResultCondition( HasItem, 4998, 5)
	MisResultCondition( HasItem, 4991, 5)
	--MisResultCondition( LessTime, 1800)
	MisResultCondition( NoRecord, 1019)
	MisResultCondition( HasMission, 1019)
	MisResultAction(TakeItem, 4528, 5 )
	MisResultAction(TakeItem, 4515, 5 )
	MisResultAction(TakeItem, 1310, 5 )
	MisResultAction(TakeItem, 4998, 5 )
	MisResultAction(TakeItem, 4991, 5 )
	MisResultAction( SetRecord, 1019)
	MisResultAction( ClearMission, 1019)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4528)	
	TriggerAction( 1, AddNextFlag, 1019, 10, 5 )
	RegCurTrigger( 10191 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4515)	
	TriggerAction( 1, AddNextFlag, 1019, 20, 5 )
	RegCurTrigger( 10192 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1310)	
	TriggerAction( 1, AddNextFlag, 1019, 30, 5 )
	RegCurTrigger( 10193 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4998)	
	TriggerAction( 1, AddNextFlag, 1019, 40, 5 )
	RegCurTrigger( 10194 )	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4991)	
	TriggerAction( 1, AddNextFlag, 1019, 50, 5 )
	RegCurTrigger( 10195 )	
	
	

--------------------------------------------限时的挑战-------------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000407")
	DefineMission( 6022, MISSCRIPT_MISSIONSCRIPT07_LUA_000407, 1020)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000411 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000411")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000411)
	MisBeginCondition( NoRecord, 1020)
	MisBeginCondition( NoMission, 1020)
	MisBeginCondition( HasRecord, 1019)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1020)
	MisBeginAction(SetFlag, 1020, 1)
	MisBeginAction(AddTrigger, 10201, TE_GETITEM, 4523, 5 )
	MisBeginAction(AddTrigger, 10202, TE_GETITEM, 4958, 5 )
	MisBeginAction(AddTrigger, 10203, TE_GETITEM, 4979, 5 )
	MisBeginAction(AddTrigger, 10204, TE_GETITEM, 1183, 5 )
	MisBeginAction(AddTrigger, 10205, TE_GETITEM, 4975, 5 )
	MisCancelAction( ClearMission, 1020)
	

	--MisNeed(MIS_NEED_DESP, "完成吉尼斯并且挑战时间必须大于7小时小于8小时")
	
	MisNeed(MIS_NEED_ITEM, 4523, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4958, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 4979, 5, 30, 5)
	MisNeed(MIS_NEED_ITEM, 1183, 5, 40, 5)
	MisNeed(MIS_NEED_ITEM, 4975, 5, 50, 5)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000409 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000409")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000409)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000412 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000412)
	--MisResultCondition( MoreTime, 25200)
	--MisResultCondition( LessTime, 28800)

	MisResultCondition( HasItem, 4523, 5)
	MisResultCondition( HasItem, 4958, 5)
	MisResultCondition( HasItem, 4979, 5)
	MisResultCondition( HasItem, 1183, 5)
	MisResultCondition( HasItem, 4975, 5)
	MisResultCondition( NoRecord, 1020)
	MisResultCondition( HasMission, 1020)
	
	MisResultAction(TakeItem, 4523, 5 )
	MisResultAction(TakeItem, 4958, 5 )
	MisResultAction(TakeItem, 4979, 5 )
	MisResultAction(TakeItem, 1183, 5 )
	MisResultAction(TakeItem, 4975, 5 )
	MisResultAction( SetRecord, 1020)
	MisResultAction( ClearMission, 1020)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4523)	
	TriggerAction( 1, AddNextFlag, 1020, 10, 5 )
	RegCurTrigger( 10201 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4958)	
	TriggerAction( 1, AddNextFlag, 1020, 20, 5 )
	RegCurTrigger( 10202 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4979)	
	TriggerAction( 1, AddNextFlag, 1020, 30, 5 )
	RegCurTrigger( 10203 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1183)	
	TriggerAction( 1, AddNextFlag, 1020, 40, 5 )
	RegCurTrigger( 10204 )	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4975)	
	TriggerAction( 1, AddNextFlag, 1020, 50, 5 )
	RegCurTrigger( 10205 )	



-----------------------------------------------限时的挑战------------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000407")
	DefineMission( 6023, MISSCRIPT_MISSIONSCRIPT07_LUA_000407, 1021)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000413")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000413)
	MisBeginCondition( NoRecord, 1021)
	MisBeginCondition( NoMission, 1021)
	MisBeginCondition( HasRecord, 1020)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1021)
	MisBeginAction(SetFlag, 1021, 1)
	MisBeginAction(AddTrigger, 10211, TE_GETITEM, 1188, 5 )
	MisBeginAction(AddTrigger, 10212, TE_GETITEM, 4513, 5 )
	MisBeginAction(AddTrigger, 10213, TE_GETITEM, 4927, 5 )
	MisBeginAction(AddTrigger, 10214, TE_GETITEM, 1200, 5 )
	MisBeginAction(AddTrigger, 10215, TE_GETITEM, 1312, 5 )
	MisCancelAction( ClearMission, 1021)

	--MisNeed(MIS_NEED_DESP, "完成吉尼斯并且挑战时间必须小于5个半小时但大于5小时")
	MisNeed(MIS_NEED_ITEM, 1188, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4513, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 4927, 5, 30, 5)
	MisNeed(MIS_NEED_ITEM, 1200, 5, 40, 5)
	MisNeed(MIS_NEED_ITEM, 1312, 5, 50, 5)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000409 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000409")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000409)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000414")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000414)
	
	--MisResultCondition( LessTime, 19800)
	--MisResultCondition( MoreTime, 18000)
	
	MisResultCondition( HasItem, 1188, 5)
	MisResultCondition( HasItem, 4513, 5)
	MisResultCondition( HasItem, 4927, 5)
	MisResultCondition( HasItem, 1200, 5)
	MisResultCondition( HasItem, 1312, 5)
	MisResultCondition( NoRecord, 1021)
	MisResultCondition( HasMission, 1021)
	
	MisResultAction(TakeItem, 1188, 5 )
	MisResultAction(TakeItem, 4513, 5 )
	MisResultAction(TakeItem, 4927, 5 )
	MisResultAction(TakeItem, 1200, 5 )
	MisResultAction(TakeItem, 1312, 5 )

	MisResultAction( SetRecord, 1021)
	MisResultAction( ClearMission, 1021)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1188)	
	TriggerAction( 1, AddNextFlag, 1021, 10, 5 )
	RegCurTrigger( 10211 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4513)	
	TriggerAction( 1, AddNextFlag, 1021, 20, 5 )
	RegCurTrigger( 10212 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4927)	
	TriggerAction( 1, AddNextFlag, 1021, 30, 5 )
	RegCurTrigger( 10213 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1200)	
	TriggerAction( 1, AddNextFlag, 1021, 40, 5 )
	RegCurTrigger( 10214 )	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1312)	
	TriggerAction( 1, AddNextFlag, 1021, 50, 5 )
	RegCurTrigger( 10215 )	

---------------------------------------------寻访雷霆守护者------路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000415 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000415")
	DefineMission( 6024, MISSCRIPT_MISSIONSCRIPT07_LUA_000415, 1022)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000416 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000416")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000416)
	MisBeginCondition( NoRecord, 1022)
	MisBeginCondition( NoMission, 1022)
	MisBeginCondition( HasRecord, 1021)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1022)
	MisCancelAction( ClearMission, 1022)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000417 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000417")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000417)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000418)

	MisResultCondition(AlwaysFailure)

-----------------------------------------------寻访雷霆守护者--------白银城驻雷霆堡大使·伊塔多
	MISSCRIPT_MISSIONSCRIPT07_LUA_000415 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000415")
	DefineMission( 6025, MISSCRIPT_MISSIONSCRIPT07_LUA_000415, 1022,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000419 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000419")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000419)
	MisResultCondition( NoRecord, 1022)
	MisResultCondition( HasMission, 1022)
	MisResultAction( SetRecord, 1022)
	MisResultAction( ClearMission, 1022)

-------------------------------------------------白羊宫的战斗---------------白银城驻雷霆堡大使·伊塔多
	MISSCRIPT_MISSIONSCRIPT07_LUA_000420 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000420")
	DefineMission( 6026, MISSCRIPT_MISSIONSCRIPT07_LUA_000420, 1023)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000421 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000421")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000421)
	MisBeginCondition( NoRecord, 1023)
	MisBeginCondition( NoMission, 1023)
	MisBeginCondition( HasRecord, 1022)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1023)
	MisBeginAction(AddTrigger, 10231, TE_GETITEM, 2942, 1 )
	MisCancelAction( ClearMission, 1023)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000422 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000422")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000422)
	MisNeed(MIS_NEED_ITEM, 2942, 1, 10 ,1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000423 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000423")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000423)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000424 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000424")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000424)
	MisResultCondition( HasItem, 2942, 1)
	MisResultCondition( BaiyangOn )
	MisResultAction( SetRecord, 1023)
	MisResultAction( ClearMission, 1023)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2942)	
	TriggerAction( 1, AddNextFlag, 1023, 10, 1 )
	RegCurTrigger( 10231 )

--------------------------------------------------寻访沙岚守护者--------------------白银城驻雷霆堡大使·伊塔多
	MISSCRIPT_MISSIONSCRIPT07_LUA_000425 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000425")
	DefineMission( 6027, MISSCRIPT_MISSIONSCRIPT07_LUA_000425, 1024)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000426 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000426")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000426)
	MisBeginCondition( NoRecord, 1024)
	MisBeginCondition( NoMission, 1024)
	MisBeginCondition( HasRecord, 1023)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1024)
	MisCancelAction( ClearMission, 1024)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000427 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000427")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000427)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000428 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000428")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000428)
	
	MisResultCondition(AlwaysFailure)

-----------------------------------------------------寻访沙岚守护者--------------------路人·珊瑚虫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000425 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000425")
	DefineMission( 6028, MISSCRIPT_MISSIONSCRIPT07_LUA_000425, 1024, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000429")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000429)
	MisResultCondition( NoRecord, 1024)
	MisResultCondition( HasMission, 1024)
	MisResultAction( SetRecord, 1024)
	MisResultAction( ClearMission, 1024)

-------------------------------------------------------环球旅行--------------------路人·珊瑚虫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6029, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1025)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000431 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000431")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000431)
	MisBeginCondition( NoMission, 1025)
	MisBeginCondition( NoRecord, 1025)
	MisBeginCondition( HasRecord, 1024)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1025)
	MisCancelAction( ClearMission, 1025)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000432 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000432")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000432)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000433 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000433")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000433)

	MisResultCondition(AlwaysFailure)

-------------------------------------------------------环球旅行-----------------严罗塔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6030, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1025, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000434 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000434")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000434)
	MisResultCondition( NoRecord, 1025)
	MisResultCondition( HasMission, 1025)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1025)
	MisResultAction( ClearMission, 1025)

--------------------------------------------------------环球旅行------------------严罗塔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6031, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1026)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000435 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000435")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000435)
	MisBeginCondition( NoMission, 1026)
	MisBeginCondition( NoRecord, 1026)
	MisBeginCondition( HasRecord, 1025)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1026)
	MisCancelAction( ClearMission, 1026)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000436 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000436")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000436)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000437 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000437")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000437)

	MisResultCondition(AlwaysFailure)

---------------------------------------------------------环球旅行----------------米尔米莉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6032, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1026, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000434 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000434")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000434)
	MisResultCondition( NoRecord, 1026)
	MisResultCondition( HasMission, 1026)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1026)
	MisResultAction( ClearMission, 1026)

----------------------------------------------------------环球旅行-----------------米尔米莉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6033, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1027)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000438 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000438")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000438)
	MisBeginCondition( NoMission, 1027)
	MisBeginCondition( NoRecord, 1027)
	MisBeginCondition( HasRecord, 1026)
	MisBeginCondition( HasRecord, 1016)
 	MisBeginAction( AddMission,1027)
	MisCancelAction( ClearMission, 1027)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000439 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000439")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000439)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000440 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000440")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000440)

	MisResultCondition(AlwaysFailure)

---------------------------------------------------------环球旅行-------------------薇莉尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6034, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1027, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1027)
	MisResultCondition( HasMission, 1027)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1027)
	MisResultAction( ClearMission, 1027)

-----------------------------------------------------------环球旅行------------------薇莉尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6035, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1028)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000442 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000442")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000442)
	MisBeginCondition( NoMission, 1028)
	MisBeginCondition( NoRecord, 1028)
	MisBeginCondition( HasRecord, 1027)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1028)
	MisCancelAction( ClearMission, 1028)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000443 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000443")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000443)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000444 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000444")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000444)

	MisResultCondition(AlwaysFailure)

------------------------------------------------------------环球旅行---------------博尔芬尼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6036, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1028, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1028)
	MisResultCondition( HasMission, 1028)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1028)
	MisResultAction( ClearMission, 1028)

---------------------------------------------------------------环球旅行------------博尔芬尼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6037, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1029)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000445 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000445")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000445)
	MisBeginCondition( NoMission, 1029)
	MisBeginCondition( NoRecord, 1029)
	MisBeginCondition( HasRecord, 1028)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1029)
	MisCancelAction( ClearMission, 1029)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000446 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000446")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000446)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000447 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000447")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000447)

	MisResultCondition(AlwaysFailure)

--------------------------------------------------------------环球旅行-----------迪迪马修
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6038, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1029, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1029)
	MisResultCondition( HasMission, 1029)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1029)
	MisResultAction( ClearMission, 1029)

--------------------------------------------------------------环球旅行-----------迪迪马修
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6039, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1030)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000448 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000448")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000448)
	MisBeginCondition( NoMission, 1030)
	MisBeginCondition( NoRecord, 1030)
	MisBeginCondition( HasRecord, 1029)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1030)
	MisCancelAction( ClearMission, 1030)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000449 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000449")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000449)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000450 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000450")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000450)

	MisResultCondition(AlwaysFailure)

--------------------------------------------------------------环球旅行-----------鲁鲁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6040, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1030, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1030)
	MisResultCondition( HasMission, 1030)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1030)
	MisResultAction( ClearMission, 1030)

--------------------------------------------------------------环球旅行-----------鲁鲁
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6041, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1031)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000451")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000451)
	MisBeginCondition( NoMission, 1031)
	MisBeginCondition( NoRecord, 1031)
	MisBeginCondition( HasRecord, 1030)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1031)
	MisCancelAction( ClearMission, 1031)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000452 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000452")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000452)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000453 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000453")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000453)

	MisResultCondition(AlwaysFailure)

--------------------------------------------------------------环球旅行-------------榴莲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6042, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1031, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1031)
	MisResultCondition( HasMission, 1031)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1031)
	MisResultAction( ClearMission, 1031)

--------------------------------------------------------------环球旅行-------------榴莲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6043, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1032)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000454 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000454")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000454)
	MisBeginCondition( NoMission, 1032)
	MisBeginCondition( NoRecord, 1032)
	MisBeginCondition( HasRecord, 1031)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1032)
	MisCancelAction( ClearMission, 1032)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000455 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000455")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000455)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000456 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000456")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000456)

	MisResultCondition(AlwaysFailure)

---------------------------------------------------------------环球旅行--------------琳达
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6044, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1032, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1032)
	MisResultCondition( HasMission, 1032)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( GiveItem, 3128, 10, 4)
	MisResultAction( SetRecord, 1032)
	MisResultAction( ClearMission, 1032)
	MisResultBagNeed(1)


---------------------------------------------------------------环球旅行--------------琳达
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6045, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1033)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000457 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000457")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000457)
	MisBeginCondition( NoMission, 1033)
	MisBeginCondition( NoRecord, 1033)
	MisBeginCondition( HasRecord, 1032)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1033)
	MisCancelAction( ClearMission, 1033)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000458")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000458)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000459 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000459")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000459)

	MisResultCondition(AlwaysFailure)

----------------------------------------------------------------环球旅行--------------修司
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6046, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1033, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1033)
	MisResultCondition( HasMission, 1033)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1033)
	MisResultAction( ClearMission, 1033)

----------------------------------------------------------------环球旅行--------------修司
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6047, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1034)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000460 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000460")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000460)
	MisBeginCondition( NoMission, 1034)
	MisBeginCondition( NoRecord, 1034)
	MisBeginCondition( HasRecord, 1033)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1034)
	MisCancelAction( ClearMission, 1034)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000461 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000461")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000462)

	MisResultCondition(AlwaysFailure)

-----------------------------------------------------------------环球旅行-------------海蓝·微风
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6048, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1034, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1034)
	MisResultCondition( HasMission, 1034)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1034)
	MisResultAction( ClearMission, 1034)

-----------------------------------------------------------------环球旅行-------------海蓝·微风
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6049, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1035)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000463 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000463")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000463)
	MisBeginCondition( NoMission, 1035)
	MisBeginCondition( NoRecord, 1035)
	MisBeginCondition( HasRecord, 1034)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1035)
	MisCancelAction( ClearMission, 1035)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000464 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000464")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000464)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000465 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000465")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000465)

	MisResultCondition(AlwaysFailure)

----------------------------------------------------------------环球旅行---------------奈奈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6050, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1035, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1035)
	MisResultCondition( HasMission, 1035)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1035)
	MisResultAction( ClearMission, 1035)

----------------------------------------------------------------环球旅行---------------奈奈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6051, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1036)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000466 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000466")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000466)
	MisBeginCondition( NoMission, 1036)
	MisBeginCondition( NoRecord, 1036)
	MisBeginCondition( HasRecord, 1035)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1036)
	MisCancelAction( ClearMission, 1036)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000467 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000467")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000467)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000468 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000468")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000468)

	MisResultCondition(AlwaysFailure)

----------------------------------------------------------------环球旅行---------------米奈希尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6052, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1036, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000441")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000441)
	MisResultCondition( NoRecord, 1036)
	MisResultCondition( HasMission, 1036)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( GiveItem, 3139, 10, 4)
	MisResultAction( SetRecord, 1036)
	MisResultAction( ClearMission, 1036)
	MisResultBagNeed(1)


----------------------------------------------------------------环球旅行-------------------米奈希尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6053, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1037)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000469 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000469")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000469)
	MisBeginCondition( NoMission, 1037)
	MisBeginCondition( NoRecord, 1037)
	MisBeginCondition( HasRecord, 1036)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1037)
	MisCancelAction( ClearMission, 1037)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000470 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000470")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000470)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000471 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000471")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000471)

	MisResultCondition(AlwaysFailure)

---------------------------------------------------------------环球旅行--------------------路人·珊瑚虫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000430")
	DefineMission( 6054, MISSCRIPT_MISSIONSCRIPT07_LUA_000430, 1037, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000472 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000472")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000472)
	MisResultCondition( NoRecord, 1037)
	MisResultCondition( HasMission, 1037)
	MisResultCondition( HasCredit, 500)
	MisResultAction( DelRoleCredit, 500)
	MisResultAction( SetRecord, 1037)
	MisResultAction( ClearMission, 1037)

--------------------------------------------------------------寻访天堂守护者--------------路人·珊瑚虫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000473 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000473")
	DefineMission( 6055, MISSCRIPT_MISSIONSCRIPT07_LUA_000473, 1038)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000474 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000474")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000474)
	MisBeginCondition( NoMission, 1038)
	MisBeginCondition( NoRecord, 1038)
	MisBeginCondition( HasRecord, 1037)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission,1038)
	MisCancelAction( ClearMission, 1038)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000475 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000475")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000475)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000476 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000476")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000476)

	MisResultCondition(AlwaysFailure)

-------------------------------------------------------------寻访天堂守护者--------------天堂传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000473 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000473")
	DefineMission( 6056, MISSCRIPT_MISSIONSCRIPT07_LUA_000473, 1038, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000477 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000477")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000477)
	MisResultCondition( NoRecord, 1038)
	MisResultCondition( HasMission, 1038)
	MisResultAction( SetRecord, 1038)
	MisResultAction( ClearMission, 1038)
	
------------------------------------------------------------虔诚的证明-------------------天堂传送使
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 6057, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 1039)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000478 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000478")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000478)
	MisBeginCondition( NoRecord, 1039)
	MisBeginCondition( NoMission, 1039)
	MisBeginCondition( HasRecord, 1038)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction(AddTrigger, 10391, TE_GETITEM, 3007, 9 )
	MisBeginAction( AddMission, 1039)
	MisBeginAction( GiveItem, 3006, 9, 4)
	MisBeginBagNeed(1)
	MisCancelAction( ClearMission, 1039)

	MisNeed(MIS_NEED_ITEM, 3007, 9, 10, 9)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000479 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000479")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000479)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000480 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000480")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000480)
	MisResultCondition( NoRecord, 1039)
	MisResultCondition( HasMission, 1039)
	MisResultCondition( HasItem, 3007, 9)
	MisResultAction( TakeItem, 3007, 9)
	MisResultAction( SetRecord, 1039)
	MisResultAction( ClearMission, 1039)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3007)	
	TriggerAction( 1, AddNextFlag, 1039, 10, 9 )
	RegCurTrigger( 10391 )


------------------------------------------------------------虔诚的证明-------------------天堂传送使
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 6058, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 1040)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000481 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000481")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000481)
	MisBeginCondition( NoRecord, 1040)
	MisBeginCondition( NoMission, 1040)
	MisBeginCondition( HasRecord, 1039)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction(AddTrigger, 10401, TE_GETITEM, 3007, 99 )
	MisBeginAction( AddMission, 1040)
	MisBeginAction( GiveItem, 3006, 99, 4)
	MisBeginBagNeed(1)
	MisCancelAction( ClearMission, 1040)

	MisNeed(MIS_NEED_ITEM, 3007, 99, 10, 99)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000482 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000482")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000482)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000480 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000480")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000480)
	MisResultCondition( NoRecord, 1040)
	MisResultCondition( HasMission, 1040)
	MisResultCondition( HasItem, 3007, 99)
	MisResultAction( TakeItem, 3007, 99)
	MisResultAction( SetRecord, 1040)
	MisResultAction( ClearMission, 1040)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3007)	
	TriggerAction( 1, AddNextFlag, 1040, 10, 99 )
	RegCurTrigger( 10401 )

------------------------------------------------------------虔诚的证明-------------------天堂传送使
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 6059, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 1041)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000483 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000483")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000483)
	MisBeginCondition( NoRecord, 1041)
	MisBeginCondition( NoMission, 1041)
	MisBeginCondition( HasRecord, 1040)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction(AddTrigger, 10411, TE_GETITEM, 3010, 1 )
	MisBeginAction( AddMission, 1041)
	MisBeginAction( GiveNSDX, 3010 )
	MisBeginBagNeed(1)
	MisCancelAction( ClearMission, 1041)
	
	MisNeed(MIS_NEED_ITEM, 3010, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000484 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000484")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000484)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000440 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000440")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000440)
	MisResultCondition( NoRecord, 1041)
	MisResultCondition( HasMission, 1041)
	MisResultCondition( CheckEnergy )
	MisResultAction( TakeItem, 3010, 1)
	MisResultAction( SetRecord, 1041)
	MisResultAction( ClearMission, 1041)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3010)	
	TriggerAction( 1, AddNextFlag, 1041, 10, 1 )
	RegCurTrigger( 10411 )

----------------------------------------------------------寻访白银守护者--------------天堂传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000485 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000485")
	DefineMission( 6060, MISSCRIPT_MISSIONSCRIPT07_LUA_000485, 1042)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000486 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000486")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000486)
	MisBeginCondition( NoRecord, 1042)
	MisBeginCondition( NoMission, 1042)
	MisBeginCondition( HasRecord, 1041)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1042)
	MisCancelAction( ClearMission, 1042)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000487 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000487")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000487)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000488 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000488")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000488)

	MisResultCondition(AlwaysFailure)

-----------------------------------------------------------寻访白银守护者--------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000485 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000485")
	DefineMission( 6061, MISSCRIPT_MISSIONSCRIPT07_LUA_000485, 1042, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000489 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000489")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000489)
	MisResultCondition( NoRecord, 1042)
	MisResultCondition( HasMission, 1042)
	MisResultAction( SetRecord, 1042)
	MisResultAction( ClearMission, 1042)

------------------------------------------------------------疯狂的游戏-----------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6062, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1043)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000491 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000491")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000491)
	MisBeginCondition( NoRecord, 1043)
	MisBeginCondition( NoMission, 1043)
	MisBeginCondition( HasRecord, 1042)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1043)
	MisBeginAction( AddTrigger, 10431, TE_KILL, 75, 110)
	MisCancelAction( ClearMission, 1043)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000492 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000492")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000492)
	MisNeed(MIS_NEED_KILL, 75, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000493 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000493")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000493)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000494 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000494")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000494)
	MisResultCondition( NoRecord, 1043)
	MisResultCondition( HasMission, 1043)
	MisResultCondition( HasFlag, 1043, 119)
	MisResultCondition( HasRecord, 1058)
	MisResultAction( SetRecord, 1043)
	MisResultAction( ClearMission, 1043)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 75 )
	TriggerAction( 1, AddNextFlag, 1043, 10, 110 )
	RegCurTrigger( 10431 )

------------------------------------------------------------疯狂的游戏-----------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6063, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1046)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000495")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000495)
	MisBeginCondition( NoRecord, 1046)
	MisBeginCondition( NoMission, 1046)
	MisBeginCondition( HasRecord, 1043)
	MisBeginCondition( HasRecord, 1044)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1046)
	MisBeginAction( AddTrigger, 10461, TE_KILL, 218, 110)
	MisCancelAction( ClearMission, 1046)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000496 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000496")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000496)
	MisNeed(MIS_NEED_KILL, 218, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000493 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000493")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000493)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000497 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000497")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000497)
	MisResultCondition( NoRecord, 1046)
	MisResultCondition( HasMission, 1046)
	MisResultCondition( HasFlag, 1046, 119)
	MisResultCondition( HasRecord, 1058)
	MisResultAction( SetRecord, 1046)
	MisResultAction( SetRecord, 1057)
	MisResultAction( ClearMission, 1046)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 218 )
	TriggerAction( 1, AddNextFlag, 1046, 10, 110 )
	RegCurTrigger( 10461 )

---------------------------------------------------------------疯狂的游戏------------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6064, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1047)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000498 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000498")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000498)
	MisBeginCondition( NoRecord, 1047)
	MisBeginCondition( NoMission, 1047)
	MisBeginCondition( HasRecord, 1045)
	MisBeginCondition( HasRecord, 1043)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1047)
	MisBeginAction( AddTrigger, 10471, TE_KILL, 216, 110)
	MisCancelAction( ClearMission, 1047)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000499 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000499")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000499)
	MisNeed(MIS_NEED_KILL, 216, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000493 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000493")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000493)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000497 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000497")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000497)
	MisResultCondition( NoRecord, 1047)
	MisResultCondition( HasMission, 1047)
	MisResultCondition( HasFlag, 1047, 119)
	MisResultCondition( HasRecord, 1058)
	MisResultAction( SetRecord, 1047)
	MisResultAction( SetRecord, 1057)
	MisResultAction( ClearMission, 1047)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 216 )
	TriggerAction( 1, AddNextFlag, 1047, 10, 110 )
	RegCurTrigger( 10471 )

---------------------------------------------------------------疯狂的游戏------------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6065, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1048)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000500 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000500")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000500)
	MisBeginCondition( NoRecord, 1048)
	MisBeginCondition( NoMission, 1048)
	MisBeginCondition( HasRecord, 1057)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1048)
	MisBeginAction( AddTrigger, 10481, TE_KILL, 233, 110)
	MisCancelAction( ClearMission, 1048)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000501 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000501")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000501)
	MisNeed(MIS_NEED_KILL, 233, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000502 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000502")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000502)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000503 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000503")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000503)
	MisResultCondition( NoRecord, 1048)
	MisResultCondition( HasMission, 1048)
	MisResultCondition( HasFlag, 1048, 119)
	MisResultAction( SetRecord, 1048)
	MisResultAction( ClearMission, 1048)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 233)
	TriggerAction( 1, AddNextFlag, 1048, 10, 110 )
	RegCurTrigger( 10481 )

---------------------------------------------------------------疯狂的游戏------------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6066, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1049)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000504 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000504")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000504)
	MisBeginCondition( NoRecord, 1049)
	MisBeginCondition( NoMission, 1049)
	MisBeginCondition( HasRecord, 1048)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1049)
	MisBeginAction( AddTrigger, 10491, TE_KILL, 235, 110)
	MisCancelAction( ClearMission, 1049)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000505")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000505)
	MisNeed(MIS_NEED_KILL, 235, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000502 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000502")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000502)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000506 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000506")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000506)
	MisResultCondition( NoRecord, 1049)
	MisResultCondition( HasMission, 1049)
	MisResultCondition( HasFlag, 1049, 119)
	MisResultAction( SetRecord, 1049)
	MisResultAction( ClearMission, 1049)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 235)
	TriggerAction( 1, AddNextFlag, 1049, 10, 110 )
	RegCurTrigger( 10491 )

---------------------------------------------------------------疯狂的游戏------------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6067, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1050)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000507 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000507")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000507)
	MisBeginCondition( NoRecord, 1050)
	MisBeginCondition( NoMission, 1050)
	MisBeginCondition( HasRecord, 1049)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1050)
	MisBeginAction( AddTrigger, 10501, TE_KILL, 232, 110)
	MisCancelAction( ClearMission, 1050)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000508 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000508")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000508)
	MisNeed(MIS_NEED_KILL, 232, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000502 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000502")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000502)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000509 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000509")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000509)
	MisResultCondition( NoRecord, 1050)
	MisResultCondition( HasMission, 1050)
	MisResultCondition( HasFlag, 1050, 119)
	MisResultAction( SetRecord, 1050)
	MisResultAction( ClearMission, 1050)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 232)
	TriggerAction( 1, AddNextFlag, 1050, 10, 110 )
	RegCurTrigger( 10501 )

---------------------------------------------------------------疯狂的游戏------------------水手·海云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000490")
	DefineMission( 6068, MISSCRIPT_MISSIONSCRIPT07_LUA_000490, 1051)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000510 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000510")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000510)
	MisBeginCondition( NoRecord, 1051)
	MisBeginCondition( NoMission, 1051)
	MisBeginCondition( HasRecord, 1050)
	MisBeginCondition( HasRecord, 1016)
	MisBeginAction( AddMission, 1051)
	MisBeginAction( AddTrigger, 10511, TE_KILL, 234, 110)
	MisCancelAction( ClearMission, 1051)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000511 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000511")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000511)
	MisNeed(MIS_NEED_KILL, 234, 110, 10, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000512 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000512")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000512)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000513 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000513")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000513)
	MisResultCondition( NoRecord, 1051)
	MisResultCondition( HasMission, 1051)
	MisResultCondition( HasFlag, 1051, 119)
	MisResultAction( SetRecord, 1051)
	MisResultAction( SetRecord, 1056)
	MisResultAction( ClearMission, 1051)
	MisResultAction(GiveItem, 2229, 1, 4)
	MisResultAction(GiveItem, 2230, 1, 4)
	MisResultAction(GiveItem, 2231, 1, 4)
	MisResultAction(GiveItem, 2232, 1, 4)
	MisResultAction(GiveItem, 2233, 1, 4)
	MisResultBagNeed(5)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 234)
	TriggerAction( 1, AddNextFlag, 1051, 10, 110 )
	RegCurTrigger( 10511 )

-------------------------------------------------做寿司的原料----------司面包	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000514 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000514")
	DefineMission (5604, MISSCRIPT_MISSIONSCRIPT07_LUA_000514, 1107)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000515 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000515")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000515)

	MisBeginCondition(NoMission,1107)
	MisBeginCondition(NoRecord,1107)
	MisBeginAction(AddMission,1107)
	MisBeginAction(AddTrigger, 11071, TE_GETITEM, 1649, 1 )---------------1个纯净的水
	MisBeginAction(AddTrigger, 11072, TE_GETITEM, 1690, 1 )---------------1个蜗牛触角
	MisBeginAction(AddTrigger, 11073, TE_GETITEM, 3116, 1 )-------------1个精灵果
	MisCancelAction( ClearMission, 1107)
	
	MisNeed(MIS_NEED_ITEM, 1649, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 1690, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 3116, 1, 30, 1 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000243")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000243)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000516 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000516")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000516)

	MisResultCondition(HasMission, 1107)
	MisResultCondition(NoRecord,1107)
	MisResultCondition(HasItem, 1649, 1 )
	MisResultCondition(HasItem, 1690, 1 )
	MisResultCondition(HasItem, 3116, 1 )
	
	MisResultAction(TakeItem, 1649, 1 )
	MisResultAction(TakeItem, 1690, 1 )
	MisResultAction(TakeItem, 3116, 1 )
	
	MisResultAction(ClearMission, 1107)
	MisResultAction(SetRecord,  1107 )
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1649)	
	TriggerAction( 1, AddNextFlag, 1107, 10, 1 )
	RegCurTrigger( 11071 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1690)	
	TriggerAction( 1, AddNextFlag, 1107, 20, 1 )
	RegCurTrigger( 11072 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 1107, 30, 1 )
	RegCurTrigger( 11073 )


	-------------------------------------------------超级寿司----------司面包	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000517 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000517")
	DefineMission (5605, MISSCRIPT_MISSIONSCRIPT07_LUA_000517, 1108)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000518 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000518")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000518)

	MisBeginCondition(NoMission,1108)
	MisBeginCondition(HasRecord,1107)
	MisBeginCondition(NoRecord,1108)
	MisBeginAction(AddMission,1108)
	MisBeginAction(AddTrigger, 11081, TE_GETITEM, 1097, 2 )---------------2个蛋糕品尝券
	MisCancelAction( ClearMission, 1108)
	
	MisNeed(MIS_NEED_ITEM, 1097, 2, 10, 2 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000519 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000519")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000519)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000520 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000520")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000520)

	MisResultCondition(HasMission, 1108)
	MisResultCondition(NoRecord,1108)
	MisResultCondition(HasItem, 1097, 2 )
	MisResultAction(TakeItem, 1097, 2 )
	MisResultAction(GiveItem, 2989,1,4)-------超级寿司
	MisResultAction(ClearMission, 1108)
	MisResultAction(SetRecord,  1108 )
	MisResultAction(ClearRecord, 1107)---------------可以反复接
	MisResultAction(ClearRecord, 1108)---------------可以反复接
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1097)	
	TriggerAction( 1, AddNextFlag, 1108, 10, 2 )
	RegCurTrigger( 11081 )

	-------------------------------------------------蛋糕勇士----------司面包	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000521 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000521")
	DefineMission (5606, MISSCRIPT_MISSIONSCRIPT07_LUA_000521, 1109)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000522 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000522")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000522)

	MisBeginCondition(NoMission,1109)
	MisBeginCondition(NoRecord,1109)
	MisBeginAction(AddMission,1109)
	MisBeginAction(AddTrigger, 11091, TE_GETITEM, 3849, 1 )---------------1个勇者之证
	MisCancelAction( ClearMission, 1109)
	
	MisNeed(MIS_NEED_ITEM, 3849, 1, 10, 1 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000519 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000519")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000519)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000520 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000520")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000520)

	MisResultCondition(HasMission, 1109)
	MisResultCondition(NoRecord,1109)
	MisResultCondition(HasItem, 3849, 1 )
	MisResultAction(ClearMission, 1109)
	MisResultAction(SetRecord,  1109 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3849)	
	TriggerAction( 1, AddNextFlag, 1109, 10, 1 )
	RegCurTrigger( 11091 )


	-------------------------------------------------品牌蛋糕----------司面包	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000523 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000523")
	DefineMission (5607, MISSCRIPT_MISSIONSCRIPT07_LUA_000523, 1110)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000524 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000524")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000524)

	MisBeginCondition(NoMission,1110)
	MisBeginCondition(HasRecord,1109)
	MisBeginCondition(NoRecord,1110)
	MisBeginAction(AddMission,1110)
	MisBeginAction(AddTrigger, 11101, TE_GETITEM, 1097, 1 )---------------1个蛋糕品尝券
	MisCancelAction( ClearMission, 1110)
	
	MisNeed(MIS_NEED_ITEM, 1097, 1, 10, 1 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000525 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000525")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000525)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000526 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000526")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000526)
	

	MisResultCondition(HasMission, 1110)
	MisResultCondition(NoRecord,1110)
	MisResultCondition(HasItem, 1097, 1 )
	MisResultAction(TakeItem, 1097, 1 )
	MisResultAction(GiveItem, 2988,1,4)------品牌蛋糕
	MisResultAction(ClearMission, 1110)
	MisResultAction(SetRecord,  1110 )
	MisResultAction(ClearRecord, 1109)---------------可以反复接
	MisResultAction(ClearRecord, 1110)---------------可以反复接
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1097)	
	TriggerAction( 1, AddNextFlag, 1110, 10, 1 )
	RegCurTrigger( 11101 )


--	-----------------------------------------------------马来西亚开服献礼
--	DefineMission( 6069, "开服献礼", 1400)
--
--	MisBeginTalk( "<t>最近有点囊中羞涩吗？只要你帮我个小忙，我就会给你丰厚的回报哦")
--	MisBeginCondition( LvCheck, ">", 10)
--	MisBeginCondition( NoRecord, 1400)
--	MisBeginCondition( NoMission, 1400)
--	MisBeginAction( AddMission, 1400 )
--	MisBeginAction( AddTrigger, 14001, TE_GETITEM, 1604, 10 )
--	MisBeginAction( AddTrigger, 14002, TE_GETITEM, 1777, 5 )
--	MisBeginAction( AddTrigger, 14002, TE_GETITEM, 1692, 5 )
--	MisBeginAction( AddTrigger, 14002, TE_GETITEM, 4334, 5 )
--	MisBeginAction( AddTrigger, 14002, TE_GETITEM, 4511, 1 )
--	MisCancelAction(ClearMission, 1400)
--
--	MisNeed(MIS_NEED_ITEM, 1604, 10, 10, 10)
--	MisNeed(MIS_NEED_ITEM, 1779, 5, 20, 5)
--	MisNeed(MIS_NEED_ITEM, 1692, 5, 30, 5)
--	MisNeed(MIS_NEED_ITEM, 4334, 5, 40, 5)
--	MisNeed(MIS_NEED_ITEM, 4511, 1, 50, 1)
--
--	MisResultTalk("<t>干的不错哦，该给你的奖励不会少的！")
--	MisHelpTalk("<t>鬃毛是熊宝宝（加纳 1905，2853）掉的，玻璃杯是森灵（加纳 2220，2638）掉的，仙人掌的花是杀手仙人掌（魔女884，3156）掉的，企鹅毛皮是水兵企鹅（深蓝 994，365）掉的，粘乎乎的水草是水草（加纳海域3000，2566）掉的")
--	MisResultCondition( HasMission, 1400)
--	MisResultCondition( NoRecord, 1400)
--	MisResultCondition( HasItem, 1604, 10)
--	MisResultCondition( HasItem, 1777, 5)
--	MisResultCondition( HasItem, 1692, 5)
--	MisResultCondition( HasItem, 4334, 5)
--	MisResultCondition( HasItem, 4511, 1)
--	MisResultAction( TakeItem, 1604, 10)
--	MisResultAction( TakeItem, 1777, 5)
--	MisResultAction( TakeItem, 1692, 5)
--	MisResultAction( TakeItem, 4334, 5)
--	MisResultAction( TakeItem, 4511, 1)
--	MisResultAction( SetRecord, 1400)
--	MisResultAction( ClearMission, 1400)
--	MisResultAction( AddMoney, 10000, 10000)
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 1604)	
--	TriggerAction( 1, AddNextFlag, 1400, 10, 10 )
--	RegCurTrigger( 14001 )
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 1777)	
--	TriggerAction( 1, AddNextFlag, 1400, 20, 5 )
--	RegCurTrigger( 14002 )
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 1692)	
--	TriggerAction( 1, AddNextFlag, 1400, 30, 5 )
--	RegCurTrigger( 14003 )
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4334)	
--	TriggerAction( 1, AddNextFlag, 1400, 40, 5 )
--	RegCurTrigger( 14004 )
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4511)	
--	TriggerAction( 1, AddNextFlag, 1400, 50, 1 )
--	RegCurTrigger( 14005 )
--
--
--	----------------------------------------------------------马来西亚幸运大宝箱
--	DefineMission ( 6070 , "幸运大宝箱 " , 1401 )
--	MisBeginTalk("<t>想得到幸运大宝箱吗？想要的话就帮我解决以下这些怪物吧：30个山贼，20个铁爪鼹鼠，10个土著战士，5个山贼首领?蝰蛇，5个宝石海豚，5个骨鱼，20个迟钝的乌贼和20个食人水母！")
--	MisBeginCondition( NoMission, 1401)
--	MisBeginCondition( NoRecord, 1401)
--	MisBeginAction( AddMission, 1401)
--	MisBeginAction( AddTrigger, 14011, TE_KILL, 93, 30)
--	MisBeginAction( AddTrigger, 14012, TE_KILL, 88, 20)
--	MisBeginAction( AddTrigger, 14013, TE_KILL, 248, 10)
--	MisBeginAction( AddTrigger, 14014, TE_KILL, 211, 5)
--	MisBeginAction( AddTrigger, 14015, TE_KILL, 58, 5)
--	MisBeginAction( AddTrigger, 14016, TE_KILL, 242, 5)
--	MisBeginAction( AddTrigger, 14017, TE_KILL, 578, 20)
--	MisBeginAction( AddTrigger, 14018, TE_KILL, 596, 20)
--	MisCancelAction(ClearMission, 1401)
--
--	MisNeed(MIS_NEED_KILL, 93, 30, 10, 30)
--	MisNeed(MIS_NEED_KILL, 88, 20, 20, 20)
--	MisNeed(MIS_NEED_KILL, 248, 10, 30, 10)
--	MisNeed(MIS_NEED_KILL, 211, 5, 40, 5)
--	MisNeed(MIS_NEED_KILL, 58, 5, 50, 5)
--	MisNeed(MIS_NEED_KILL, 242, 5, 60, 5)
--	MisNeed(MIS_NEED_KILL, 578, 20, 70, 20)
--	MisNeed(MIS_NEED_KILL, 596, 20, 80, 20)
--
--	MisResultTalk("<t>祝你好运哦~")
--	MisHelpTalk("<t>海上的怪必须开船去打哦")
--	MisResultCondition( HasMission, 1401)
--	MisResultCondition( NoRecord, 1401)
--	MisResultCondition( HasFlag, 1401, 10)
--	MisResultCondition( HasFlag, 1401, 20)
--	MisResultCondition( HasFlag, 1401, 30)
--	MisResultCondition( HasFlag, 1401, 40)
--	MisResultCondition( HasFlag, 1401, 50)
--	MisResultCondition( HasFlag, 1401, 60)
--	MisResultCondition( HasFlag, 1401, 70)
--	MisResultCondition( HasFlag, 1401, 80)
--	MisResultAction( SetRecord, 1401)
--	MisResultAction( ClearMission, 1401)
--	MisResultAction( GiveItem, 4312)
--	MisResultBagNeed(1)
--
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 93 )
--	TriggerAction( 1, AddNextFlag, 1401, 10, 30 )
--	RegCurTrigger( 14011 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 88 )
--	TriggerAction( 1, AddNextFlag, 1401, 20, 20 )
--	RegCurTrigger( 14012 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 248 )
--	TriggerAction( 1, AddNextFlag, 1401, 30, 10 )
--	RegCurTrigger( 14013 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 211 )
--	TriggerAction( 1, AddNextFlag, 1401, 40, 5 )
--	RegCurTrigger( 14014 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 58 )
--	TriggerAction( 1, AddNextFlag, 1401, 50, 5 )
--	RegCurTrigger( 14015 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 242 )
--	TriggerAction( 1, AddNextFlag, 1401, 60, 5 )
--	RegCurTrigger( 14016 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 578 )
--	TriggerAction( 1, AddNextFlag, 1401, 70, 20 )
--	RegCurTrigger( 14017 )
--	InitTrigger()
--	TriggerCondition( 1, IsMonster, 596 )
--	TriggerAction( 1, AddNextFlag, 1401, 80, 30 )
--	RegCurTrigger( 14018 )


------------------------------------------------------------------新的磨练---转生天使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000527 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000527")
	DefineMission( 6071, MISSCRIPT_MISSIONSCRIPT07_LUA_000527, 1402)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000528 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000528")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000528)
	MisBeginCondition( CheckZS )
	MisBeginCondition( NoRecord, 1402)
	MisBeginCondition( NoMission, 1402)
	MisBeginAction( AddMission, 1402)
	MisCancelAction( ClearMission ,1402)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000529 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000529")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000529)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000530 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000530")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000530)

	MisResultCondition( AlwaysFailure )

-------------------------------------------------------------------新的磨练---怨念草
	MISSCRIPT_MISSIONSCRIPT07_LUA_000527 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000527")
	DefineMission( 6072, MISSCRIPT_MISSIONSCRIPT07_LUA_000527, 1402, COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000531 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000531")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000531)
	MisResultCondition( HasMission, 1402)
	MisResultCondition( NoRecord, 1402)
	MisResultAction( AddSailExp , 10, 10)
	MisResultAction( SetRecord, 1402)
	MisResultAction( ClearMission, 1402)

-----------------------------------------------------------------精灵草的怨念----怨念草
	MISSCRIPT_MISSIONSCRIPT07_LUA_000532 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000532")
	DefineMission( 6073, MISSCRIPT_MISSIONSCRIPT07_LUA_000532, 1403)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000533 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000533")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000533)
	MisBeginCondition( CheckZS )
	MisBeginCondition( HasRecord, 1402)
	MisBeginCondition( NoRecord, 1403)
	MisBeginCondition( NoMission, 1403)
	MisBeginAction( AddMission, 1403)
	MisCancelAction( ClearMission, 1403)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000534 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000534")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000534)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000535 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000535")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000535)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000536 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000536")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000536)
	MisResultCondition( HasRecord, 1404)
	MisResultCondition( HasMission, 1403)
	MisResultAction( SetRecord, 1403)
	MisResultAction( ClearMission, 1403)
	MisResultAction( AddSailExp, 10, 10)

---------------------------------------------------------------怨念草的要求------怨念草
	MISSCRIPT_MISSIONSCRIPT07_LUA_000537 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000537")
	DefineMission( 6074, MISSCRIPT_MISSIONSCRIPT07_LUA_000537, 1408)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000538 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000538")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000538)
	MisBeginCondition( NoMission, 1408)
	MisBeginCondition( NoRecord, 1408)
	MisBeginCondition( HasRecord, 1403)
	MisBeginCondition( HasRecord, 1405)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1408)
	MisBeginAction( AddTrigger, 14081, TE_GETITEM, 2383, 20 )
	MisCancelAction( ClearMission, 1408)

	MisNeed( MIS_NEED_ITEM, 2383 , 20, 10, 20)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000539 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000539")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000539)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000540 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000540")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000540)
	MisResultCondition( HasMission, 1408)
	MisResultCondition( NoRecord, 1408)
	MisResultCondition( HasItem, 2383, 20)
	MisResultAction( TakeItem ,2383, 20)
	MisResultAction( AddSailExp, 20, 20)
	MisResultAction( SetRecord, 1408)
	MisResultAction( SetRecord, 1409)
	MisResultAction( ClearMission, 1408)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2383)	
	TriggerAction( 1, AddNextFlag, 1408, 10, 20 )
	RegCurTrigger( 14081 )

-------------------------------------------------------------怨念草的要求------怨念草
	MISSCRIPT_MISSIONSCRIPT07_LUA_000537 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000537")
	DefineMission( 6075, MISSCRIPT_MISSIONSCRIPT07_LUA_000537, 1410)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000541 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000541")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000541)
	MisBeginCondition( NoRecord, 1410)
	MisBeginCondition( NoMission, 1410)
	MisBeginCondition( HasRecord, 1406)
	MisBeginCondition( HasRecord, 1403)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1410)
	MisBeginAction( AddTrigger, 14101, TE_GETITEM, 1649, 10 )
	MisCancelAction( ClearMission, 1410)

	MisNeed( MIS_NEED_ITEM, 1649 , 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000542 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000542")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000542)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000543 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000543")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000543)
	MisResultCondition( HasMission, 1410)
	MisResultCondition( NoRecord, 1410)
	MisResultCondition( HasItem, 1649, 10)
	MisResultAction( SetRecord, 1410)
	MisResultAction( SetRecord, 1405)
	MisResultAction( TakeItem, 1649, 10)
	MisResultAction( ClearMission, 1410)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1649)	
	TriggerAction( 1, AddNextFlag, 1410, 10, 10 )
	RegCurTrigger( 14101 )

-------------------------------------------------------怨念草的要求
	MISSCRIPT_MISSIONSCRIPT07_LUA_000537 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000537")
	DefineMission( 6076, MISSCRIPT_MISSIONSCRIPT07_LUA_000537, 1411)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000544 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000544")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000544)
	MisBeginCondition( NoRecord, 1411)
	MisBeginCondition( NoMission, 1411)
	MisBeginCondition( HasRecord, 1403)
	MisBeginCondition( HasRecord, 1407)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1411)
	MisCancelAction( ClearMission, 1411)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000545 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000545")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000545)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000546 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000546")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000546)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000547 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000547")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000547)
	MisResultCondition( HasMission, 1411)
	MisResultCondition( NoRecord, 1411)
	MisResultCondition( HasMoney, 1000000)
	MisResultAction( TakeMoney, 1000000)
	MisResultAction( AddSailExp, 20, 20)
	MisResultAction( SetRecord, 1411)
	MisResultAction( SetRecord, 1409)
	MisResultAction( ClearMission, 1411)

---------------------------------------------------------汇报情况-------怨念草
	MISSCRIPT_MISSIONSCRIPT07_LUA_000548 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000548")
	DefineMission( 6077, MISSCRIPT_MISSIONSCRIPT07_LUA_000548, 1412)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000549 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000549")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000549)
	MisBeginCondition( NoRecord, 1412)
	MisBeginCondition( NoMission, 1412)
	MisBeginCondition( HasRecord, 1409)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1412)
	MisCancelAction( ClearMission, 1412)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000550 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000550")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000550)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000551 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000551")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000551)

	MisResultCondition( AlwaysFailure )

---------------------------------------------------------汇报情况------剑士导师·比特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000548 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000548")
	DefineMission( 6078, MISSCRIPT_MISSIONSCRIPT07_LUA_000548, 1412, COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000552 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000552")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000552)
	MisResultCondition( HasMission, 1412)
	MisResultCondition( NoRecord, 1412)
	MisResultAction( SetRecord, 1412)
	MisResultAction( ClearMission, 1412)
	MisResultAction( AddSailExp, 5, 5)

---------------------------------------------------------收集羽毛-------剑士导师·比特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000553 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000553")
	DefineMission( 6079, MISSCRIPT_MISSIONSCRIPT07_LUA_000553, 1413)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000554")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000554)
	MisBeginCondition( NoMission, 1413)
	MisBeginCondition( NoRecord, 1413)
	MisBeginCondition( HasRecord, 1412)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1413)
	MisBeginAction( AddTrigger, 14131, TE_GETITEM, 4364, 100)
	MisBeginAction( AddTrigger, 14132, TE_GETITEM, 4347, 100)
	MisCancelAction( ClearMission, 1413)

	MisNeed( MIS_NEED_ITEM, 4364, 100, 10, 100)
	MisNeed( MIS_NEED_ITEM, 4347, 100, 20, 100)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000555 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000555")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000555)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000556 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000556")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000556)
	MisResultCondition( HasMission, 1413)
	MisResultCondition( NoRecord, 1413)
	MisResultCondition( HasItem, 4364, 100)
	MisResultCondition( HasItem, 4347, 100)
	MisResultAction( TakeItem, 4364, 100)
	MisResultAction( TakeItem, 4347, 100)
	MisResultAction( AddSailExp, 40, 40)
	MisResultAction( SetRecord, 1413)
	MisResultAction( ClearMission, 1413)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4364)	
	TriggerAction( 1, AddNextFlag, 1413, 10, 100 )
	RegCurTrigger( 14131 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4347)	
	TriggerAction( 1, AddNextFlag, 1413, 20, 100 )
	RegCurTrigger( 14132 )

--------------------------------------------------------帮助他人--------剑士导师·比特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000557 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000557")
	DefineMission( 6080, MISSCRIPT_MISSIONSCRIPT07_LUA_000557, 1414)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000558 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000558")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000558)
	MisBeginCondition( HasRecord, 1413)
	MisBeginCondition( NoRecord, 1414)
	MisBeginCondition( NoMission, 1414)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1414)
	MisCancelAction( ClearMission, 1414)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000559 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000559")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000559)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000560 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000560")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000560)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000561 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000561")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000561)
	MisResultCondition( HasMission, 1414)
	MisResultCondition( NoRecord, 1414)
	MisResultCondition( HasRecord, 1428)
	MisResultCondition( HasRecord, 1417)
	MisResultCondition( HasRecord, 1420)
	MisResultCondition( HasRecord, 1422)
	MisResultCondition( HasRecord, 1424)
	MisResultAction( AddSailExp, 10,10)
	MisResultAction( SetRecord, 1414)
	MisResultAction( ClearMission, 1414)

---------------------------------------------------------玫瑰的魅力----酒吧女·蒂娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_000562 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000562")
	DefineMission( 6081, MISSCRIPT_MISSIONSCRIPT07_LUA_000562, 1415)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000563 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000563")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000563)
	MisBeginCondition( NoChaType, 3)
	MisBeginCondition( NoChaType, 4)
	MisBeginCondition( HasMission, 1414)
	MisBeginCondition( CheckZS )
	MisBeginCondition( NoMission, 1415)
	MisBeginCondition( NoRecord, 1415)
	MisBeginAction( AddMission, 1415)
	MisCancelAction( ClearMission, 1415)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000564 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000564")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000564)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000565 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000565")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000565)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000566")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000566)
	MisResultCondition( HasState, 110)
	MisResultCondition( HasMission, 1415)
	MisResultCondition( NoRecord, 1415)
	MisResultAction( SetRecord, 1415)
	MisResultAction( AddSailExp, 20, 20)
	MisResultAction( SetRecord, 1428)
	MisResultAction( ClearMission, 1415)


---------------------------------------------------------玫瑰的魅力----酒鬼·芬德内
	MISSCRIPT_MISSIONSCRIPT07_LUA_000562 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000562")
	DefineMission( 6082, MISSCRIPT_MISSIONSCRIPT07_LUA_000562, 1416)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000567 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000567")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000567)
	MisBeginCondition( HasMission, 1414)
	MisBeginCondition( NoRecord, 1416)
	MisBeginCondition( NoMission, 1416)
	MisBeginCondition( NoChaType, 1)
	MisBeginCondition( NoChaType, 2)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1416)
	MisCancelAction( ClearMission, 1416)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000568 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000568")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000568)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000569 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000569")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000569)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000566")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000566)
	MisResultCondition( HasState, 110)
	MisResultCondition( HasMission, 1416)
	MisResultCondition( NoRecord, 1416)
	MisResultAction( SetRecord, 1416)
	MisResultAction( SetRecord, 1428)
	MisResultAction( AddSailExp, 20, 20)
	MisResultAction( ClearMission, 1416)
---------------------------------------------------------倒霉的模特----潮流发型师·卡特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000570 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000570")
	DefineMission( 6085, MISSCRIPT_MISSIONSCRIPT07_LUA_000570, 1417)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000571 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000571")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000571)
	MisBeginCondition( NoMission, 1417)
	MisBeginCondition( NoRecord, 1417)
	MisBeginCondition( HasMission, 1414)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1417)
	MisBeginAction( AddTrigger, 14171, TE_GETITEM, 1804, 5)
	MisBeginAction( AddTrigger, 14172, TE_GETITEM, 1805, 5)
	MisCancelAction( ClearMission, 1417)

	MisNeed( MIS_NEED_ITEM, 1804, 5, 10, 5)
	MisNeed( MIS_NEED_ITEM, 1805, 5, 20, 5)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000572 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000572")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000572)
	MisResultCondition( HasMission, 1417)
	MisResultCondition( HasItem, 1804, 5)
	MisResultCondition( HasItem, 1805, 5)
	MisResultCondition( NoRecord, 1417)
	MisResultAction( TakeItem, 1804, 5)
	MisResultAction( TakeItem, 1805, 5)
	MisResultAction( AddSailExp, 20, 20)
	MisResultAction( SetRecord, 1417)
	MisResultAction( ClearMission, 1417)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1804)	
	TriggerAction( 1, AddNextFlag, 1417, 10, 5 )
	RegCurTrigger( 14171 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1805)	
	TriggerAction( 1, AddNextFlag, 1417, 20, 5 )
	RegCurTrigger( 14172 )


----------------------------------------------------------跑龙套的梦想----路人·甲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000573")
	DefineMission( 6086, MISSCRIPT_MISSIONSCRIPT07_LUA_000573, 1418)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000574 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000574")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000574)
	MisBeginCondition( NoMission, 1418)
	MisBeginCondition( NoRecord, 1418)
	MisBeginCondition( CheckZS )
	MisBeginCondition( HasMission, 1414)
	MisBeginAction( AddMission, 1418)
	MisCancelAction( ClearMission, 1418)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000575 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000575")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000575)

	MisResultCondition( AlwaysFailure )

------------------------------------------------------------跑龙套的梦想----海军司令官·德斯塔罗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000573")
	DefineMission( 6087, MISSCRIPT_MISSIONSCRIPT07_LUA_000573, 1418, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000576 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000576")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000576)
	MisResultCondition( HasMission, 1418)
	MisResultCondition( NoRecord, 1418)
	MisResultAction( SetRecord, 1418)
	MisResultAction( AddSailExp, 5, 5)
	MisResultAction( ClearMission, 1418)

-------------------------------------------------------------跑龙套的梦想----海军司令官·德斯塔罗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000573")
	DefineMission( 6088, MISSCRIPT_MISSIONSCRIPT07_LUA_000573, 1419)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000577 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000577")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000577)
	MisBeginCondition( NoMission, 1419)
	MisBeginCondition( NoRecord, 1419)
	MisBeginCondition( HasMission, 1414)
	MisBeginCondition( HasRecord, 1418)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1419)
	MisCancelAction( ClearMission, 1419)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000578 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000578")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000578)

	MisResultCondition( AlwaysFailure )


--------------------------------------------------------------跑龙套的梦想----路人·甲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000573")
	DefineMission( 6089, MISSCRIPT_MISSIONSCRIPT07_LUA_000573, 1419, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000579 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000579")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000579)
	MisResultCondition( HasMission, 1419)
	MisResultCondition( NoRecord, 1419)
	MisResultAction( AddSailExp, 5, 5)
	MisResultAction( SetRecord, 1419)
	MisResultAction( ClearMission, 1419)

-------------------------------------------------------------跑龙套的梦想----路人·甲
	MISSCRIPT_MISSIONSCRIPT07_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000573")
	DefineMission( 6090, MISSCRIPT_MISSIONSCRIPT07_LUA_000573, 1420)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000580 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000580")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000580)
	MisBeginCondition( NoMission, 1420)
	MisBeginCondition( NoRecord, 1420)
	MisBeginCondition( HasMission, 1414)
	MisBeginCondition( HasRecord, 1419)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1420)
	MisBeginAction( AddTrigger, 14201, TE_KILL, 630, 5)
	MisBeginAction( AddTrigger, 14202, TE_KILL, 631, 5)
	MisCancelAction( ClearMission, 1420)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000581 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000581")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000581)
	MisNeed( MIS_NEED_KILL, 630, 5, 10, 5)
	MisNeed( MIS_NEED_KILL, 631, 5, 20, 5)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000582 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000582")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000582)
	MisResultCondition( HasMission, 1420)
	MisResultCondition( NoRecord, 1420)
	MisResultCondition( HasFlag, 1420, 14)
	MisResultCondition( HasFlag, 1420, 24)
	MisResultAction( SetRecord, 1420)
	MisResultAction( ClearMission, 1420)
	MisResultAction( AddSailExp, 20, 20)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 630 )
	TriggerAction( 1, AddNextFlag, 1420, 10, 5 )
	RegCurTrigger( 14201 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 631 )
	TriggerAction( 1, AddNextFlag, 1420, 20, 5 )
	RegCurTrigger( 14202 )


---------------------------------------------------------------紧急快递-----------银行出纳·摩妮雅
	MISSCRIPT_MISSIONSCRIPT07_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000583")
	DefineMission( 6091, MISSCRIPT_MISSIONSCRIPT07_LUA_000583, 1421)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000584 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000584")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000584)
	MisBeginCondition( NoMission, 1421)
	MisBeginCondition( NoRecord, 1421)
	MisBeginCondition( CheckZS )
	MisBeginCondition( HasMission, 1414)
	MisBeginAction( AddMission, 1421)
	MisCancelAction( ClearMission, 1421)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000585")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000585)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000586 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000586")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000586)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000587 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000587")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000587)
	MisResultCondition( HasMission, 1421)
	MisResultCondition( NoRecord, 1421)
	MisResultCondition( CheckSpeed, 550)
	MisResultAction( SetRecord, 1421)
	MisResultAction( AddSailExp, 20, 20)
	MisResultAction( ClearMission, 1421)

---------------------------------------------------------------紧急快递-----------银行出纳·摩妮雅
	MISSCRIPT_MISSIONSCRIPT07_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000583")
	DefineMission( 6092, MISSCRIPT_MISSIONSCRIPT07_LUA_000583, 1422)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000588 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000588")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000588)
	MisBeginCondition( NoMission, 1422)
	MisBeginCondition( NoRecord, 1422)
	MisBeginCondition( HasRecord, 1421)
	MisBeginAction( AddMission, 1422)
	MisBeginAction( GiveItem, 956, 1, 4)
	MisCancelAction( ClearMission, 1422)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000589 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000589")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000589)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000590 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000590")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000590)

	MisResultCondition( AlwaysFailure )

------------------------------------------------------------紧急快递--------------银行出纳·布丽娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000583")
	DefineMission( 6093, MISSCRIPT_MISSIONSCRIPT07_LUA_000583, 1422, COMPLETE)
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000591 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000591")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000591)
	MisResultCondition( HasMission, 1422)
	MisResultCondition( NoRecord, 1422)
	MisResultCondition( HasItem, 956, 1)
	MisResultAction( TakeItem, 956, 1)
	MisResultAction( SetRecord, 1422)
	MisResultAction( ClearMission, 1422)
	MisResultAction( AddSailExp, 5, 5)

----------------------------------------------------------开卷有益----------------老者·糊涂山人
	MISSCRIPT_MISSIONSCRIPT07_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000592")
	DefineMission( 6094, MISSCRIPT_MISSIONSCRIPT07_LUA_000592, 1423)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000593 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000593")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000593)
	MisBeginCondition( NoRecord, 1423)
	MisBeginCondition( NoMission, 1423)
	MisBeginCondition( HasMission, 1414)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1423)
	MisBeginAction( GiveItem, 957, 1, 4)
	MisCancelAction( ClearMission, 1423)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000594 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000594")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000594)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000595 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000595")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000595)

	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------开卷有益-----------------托马斯·图图
	MISSCRIPT_MISSIONSCRIPT07_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000592")
	DefineMission( 6095, MISSCRIPT_MISSIONSCRIPT07_LUA_000592, 1423)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000596 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000596")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000596)
	MisResultCondition( HasMission, 1423)
	MisResultCondition( NoRecord, 1423)
	MisResultCondition( HasItem, 957, 1)
	MisResultAction( TakeItem, 957, 1)
	MisResultAction( AddSailExp, 5, 5)
	MisResultAction( SetRecord, 1423)
	MisResultAction( ClearMission, 1423)

-----------------------------------------------------------开卷有益-----------------托马斯·图图
	MISSCRIPT_MISSIONSCRIPT07_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000592")
	DefineMission( 6096, MISSCRIPT_MISSIONSCRIPT07_LUA_000592, 1424)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000597 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000597")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000597)
	MisBeginCondition( NoMission, 1424)
	MisBeginCondition( NoRecord, 1424)
	MisBeginCondition( HasRecord, 1423)
	MisBeginAction( AddMission, 1424)
	MisCancelAction( ClearMission, 1424)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000598")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000599 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000599")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000599)
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_000600 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000600")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000600)
	MisResultCondition( HasMission, 1424)
	MisResultCondition( NoRecord, 1424)
	MisResultCondition( HasRecord, 1429)
	MisResultAction( AddSailExp, 5, 5)
	MisResultAction( SetRecord, 1424)
	MisResultAction( ClearMission, 1424)

-----------------------------------------------------------刺探军情--------------剑士导师·比特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000601 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000601")
	DefineMission( 6097, MISSCRIPT_MISSIONSCRIPT07_LUA_000601, 1425)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000602 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000602")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000602)
	MisBeginCondition( NoMission, 1425)
	MisBeginCondition( NoRecord, 1425)
	MisBeginCondition( HasRecord, 1414)
	MisBeginCondition( CheckZS )
	MisBeginAction( AddMission, 1425)
	MisCancelAction( ClearMission, 1425)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000603 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000603")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000603)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000604 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000604")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000604)
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------刺探军情--------------重伤的无名战士
	MISSCRIPT_MISSIONSCRIPT07_LUA_000601 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000601")
	DefineMission( 6098, MISSCRIPT_MISSIONSCRIPT07_LUA_000601, 1425, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000605 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000605")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000605)
	MisResultCondition( HasMission, 1425)
	MisResultCondition( NoRecord, 1425)
	MisResultAction( SetRecord, 1425)
	MisResultAction( AddSailExp, 10, 10)
	MisResultAction( ClearMission, 1425)

-----------------------------------------------------------刺探军情---------------重伤的无名战士
	MISSCRIPT_MISSIONSCRIPT07_LUA_000601 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000601")
	DefineMission( 6099, MISSCRIPT_MISSIONSCRIPT07_LUA_000601, 1426)
	MisBeginCondition( NoMission, 1426)
	MisBeginCondition( NoRecord, 1426)
	MisBeginCondition( HasRecord, 1425)
	MisBeginAction( AddMission, 1426)
	MisBeginAction( GiveItem, 958, 1, 4)
	MisCancelAction( ClearMission, 1426)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000606 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000606")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000606)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000607 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000607")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000607)

	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------刺探军情--------------剑士导师·比特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000601 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000601")
	DefineMission( 6100, MISSCRIPT_MISSIONSCRIPT07_LUA_000601, 1426, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000608 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000608")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000608)
	MisResultCondition( HasMission, 1426)
	MisResultCondition( NoRecord, 1426)
	MisResultCondition( HasItem, 958, 1)
	MisResultAction( TakeItem, 958, 1)
	MisResultAction( AddSailExp, 10, 10)
	MisResultAction( SetRecord, 1426)
	MisResultAction( ClearMission, 1426)

-----------------------------------------------------------比特的复仇-----------剑士导师·比特
	MISSCRIPT_MISSIONSCRIPT07_LUA_000609 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000609")
	DefineMission( 6101, MISSCRIPT_MISSIONSCRIPT07_LUA_000609, 1427)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000610 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000610")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000610)
	MisBeginCondition( NoMission, 1427)
	MisBeginCondition( NoRecord, 1427)
	MisBeginCondition( HasRecord, 1426)
	MisBeginAction( AddMission, 1427)
	MisBeginAction( AddTrigger, 14271, TE_KILL, 791, 1)
	MisBeginAction( AddTrigger, 14272, TE_KILL, 793, 1)
	MisBeginAction( AddTrigger, 14273, TE_KILL, 794, 1)
	MisCancelAction( ClearMission, 1427)

	MisNeed( MIS_NEED_KILL, 791, 1, 10, 1)
	MisNeed( MIS_NEED_KILL, 793, 1, 30, 1)
	MisNeed( MIS_NEED_KILL, 794, 1, 50, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000611 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000611")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000611)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000612 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000612")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000612)
	MisResultCondition( HasMission, 1427)
	MisResultCondition( NoRecord, 1427)
	MisResultCondition( HasFlag, 1427, 10)
	MisResultCondition( HasFlag, 1427, 30)
	MisResultCondition( HasFlag, 1427, 50)
	MisResultAction( AddSailExp, 50, 50)
	MisResultAction( SetRecord, 1427)
	MisResultAction( ClearMission, 1427)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 791 )
	TriggerAction( 1, AddNextFlag, 1427, 10, 1 )
	RegCurTrigger( 14271 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 793 )
	TriggerAction( 1, AddNextFlag, 1427, 30, 1 )
	RegCurTrigger( 14272 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 794 )
	TriggerAction( 1, AddNextFlag, 1427, 50, 1 )
	RegCurTrigger( 14273 )


----------------------------------------------------挑战·黑龙----------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000613 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000613")
	DefineMission( 6102, MISSCRIPT_MISSIONSCRIPT07_LUA_000613, 1430)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000614 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000614")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000614)
	MisBeginCondition( NoMission, 1430)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1430)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14301, TE_KILL, 789, 1)
	MisCancelAction( ClearMission, 1430)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 789, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1430, 10)
	MisResultCondition( HasMission, 1430)
	MisResultAction( AddSailExp, 120, 120)
	MisResultAction( ClearMission, 1430)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 789 )
	TriggerAction( 1, AddNextFlag, 1430, 10, 1 )
	RegCurTrigger( 14301 )

------------------------------------------------------挑战·雪殇灵--------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000617 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000617")
	DefineMission( 6103, MISSCRIPT_MISSIONSCRIPT07_LUA_000617, 1432)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000618 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000618")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000618)
	MisBeginCondition( NoMission, 1432)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1432)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14321, TE_KILL, 679, 1)
	MisCancelAction( ClearMission, 1432)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 679, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1432, 10)
	MisResultCondition( HasMission, 1432)
	MisResultAction( AddSailExp, 50, 50)
	MisResultAction( ClearMission, 1432)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 679 )
	TriggerAction( 1, AddNextFlag, 1432, 10, 1 )
	RegCurTrigger( 14321 )

------------------------------------------------------挑战·巨人首领--------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000619 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000619")
	DefineMission( 6104, MISSCRIPT_MISSIONSCRIPT07_LUA_000619, 1433)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000620 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000620")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000620)
	MisBeginCondition( NoMission, 1433)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1433)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14331, TE_KILL, 678, 1)
	MisCancelAction( ClearMission, 1433)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 678, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1433, 10)
	MisResultCondition( HasMission, 1433)
	MisResultAction( AddSailExp, 50, 50)
	MisResultAction( ClearMission, 1433)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 678 )
	TriggerAction( 1, AddNextFlag, 1433, 10, 1 )
	RegCurTrigger( 14331 )

-------------------------------------------------------挑战·巴伯萨--------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000621 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000621")
	DefineMission( 6105, MISSCRIPT_MISSIONSCRIPT07_LUA_000621, 1434)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000622 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000622")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000622)
	MisBeginCondition( NoMission, 1434)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1434)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14341, TE_KILL, 805, 1)
	MisCancelAction( ClearMission, 1434)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 805, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1434, 10)
	MisResultCondition( HasMission, 1434)
	MisResultAction( AddSailExp, 75, 75)
	MisResultAction( ClearMission, 1434)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 805 )
	TriggerAction( 1, AddNextFlag, 1434, 10, 1 )
	RegCurTrigger( 14341 )

-------------------------------------------------------挑战·亡灵司令--------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000623 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000623")
	DefineMission( 6106, MISSCRIPT_MISSIONSCRIPT07_LUA_000623, 1435)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000624 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000624")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000624)
	MisBeginCondition( NoMission, 1435)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1435)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14351, TE_KILL, 807, 1)
	MisCancelAction( ClearMission, 1435)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 807, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1435, 10)
	MisResultCondition( HasMission, 1435)
	MisResultAction( AddSailExp, 75, 75)
	MisResultAction( ClearMission, 1435)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 807 )
	TriggerAction( 1, AddNextFlag, 1435, 10, 1 )
	RegCurTrigger( 14351 )

-------------------------------------------------------挑战·大章鱼--------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000625 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000625")
	DefineMission( 6107, MISSCRIPT_MISSIONSCRIPT07_LUA_000625, 1436)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000626 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000626")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000626)
	MisBeginCondition( NoMission, 1436)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1436)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14361, TE_KILL, 796, 1)
	MisCancelAction( ClearMission, 1436)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 796, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1436, 10)
	MisResultCondition( HasMission, 1436)
	MisResultAction( AddSailExp, 75, 75)
	MisResultAction( ClearMission, 1436)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 796 )
	TriggerAction( 1, AddNextFlag, 1436, 10, 1 )
	RegCurTrigger( 14361 )

-------------------------------------------------------挑战·黑珍珠--------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000627 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000627")
	DefineMission( 6108, MISSCRIPT_MISSIONSCRIPT07_LUA_000627, 1437)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000628 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000628")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000628)
	MisBeginCondition( NoMission, 1437)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1437)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14371, TE_KILL, 815, 1)
	MisCancelAction( ClearMission, 1437)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 815, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1437, 10)
	MisResultCondition( HasMission, 1437)
	MisResultAction( AddSailExp, 75, 75)
	MisResultAction( ClearMission, 1437)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 815 )
	TriggerAction( 1, AddNextFlag, 1437, 10, 1 )
	RegCurTrigger( 14371 )

-------------------------------------------------------挑战·绝望骑士-塞拉------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000629 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000629")
	DefineMission( 6109, MISSCRIPT_MISSIONSCRIPT07_LUA_000629, 1438)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000630 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000630")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000630)
	MisBeginCondition( NoMission, 1438)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1438)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14381, TE_KILL, 974, 1)
	MisCancelAction( ClearMission, 1438)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 974, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1438, 10)
	MisResultCondition( HasMission, 1438)
	MisResultAction( AddSailExp, 90, 90)
	MisResultAction( ClearMission, 1438)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 974 )
	TriggerAction( 1, AddNextFlag, 1438, 10, 1 )
	RegCurTrigger( 14381 )

-------------------------------------------------------挑战·冥泥怪-卡普顿------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000631 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000631")
	DefineMission( 6110, MISSCRIPT_MISSIONSCRIPT07_LUA_000631, 1439)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000632 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000632")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000632)
	MisBeginCondition( NoMission, 1439)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1439)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14391, TE_KILL, 975, 1)
	MisCancelAction( ClearMission, 1439)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 975, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1439, 10)
	MisResultCondition( HasMission, 1439)
	MisResultAction( AddSailExp, 90, 90)
	MisResultAction( ClearMission, 1439)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 975 )
	TriggerAction( 1, AddNextFlag, 1439, 10, 1 )
	RegCurTrigger( 14391 )

-------------------------------------------------------挑战·冥囚-阿尔提斯------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000633 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000633")
	DefineMission( 6111, MISSCRIPT_MISSIONSCRIPT07_LUA_000633, 1440)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000634 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000634")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000634)
	MisBeginCondition( NoMission, 1440)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1440)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14401, TE_KILL, 976, 1)
	MisCancelAction( ClearMission, 1440)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 976, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1440, 10)
	MisResultCondition( HasMission, 1440)
	MisResultAction( AddSailExp, 90, 90)
	MisResultAction( ClearMission, 1440)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 976 )
	TriggerAction( 1, AddNextFlag, 1440, 10, 1 )
	RegCurTrigger( 14401 )

-------------------------------------------------------挑战·冥妖-萨库西斯------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000635 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000635")
	DefineMission( 6112, MISSCRIPT_MISSIONSCRIPT07_LUA_000635, 1441)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000636 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000636")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000636)
	MisBeginCondition( NoMission, 1441)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1441)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14411, TE_KILL, 977, 1)
	MisCancelAction( ClearMission, 1441)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 977, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1441, 10)
	MisResultCondition( HasMission, 1441)
	MisResultAction( AddSailExp, 90, 90)
	MisResultAction( ClearMission, 1441)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 977 )
	TriggerAction( 1, AddNextFlag, 1441, 10, 1 )
	RegCurTrigger( 14411 )

-------------------------------------------------------挑战·冥界兽-咕咕------BOSS挑战登记员
	MISSCRIPT_MISSIONSCRIPT07_LUA_000637 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000637")
	DefineMission( 6113, MISSCRIPT_MISSIONSCRIPT07_LUA_000637, 1442)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000638 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000638")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000638)
	MisBeginCondition( NoMission, 1442)
	MisBeginCondition( NoRecord, 1431)
	MisBeginCondition( HasRecord, 1427)
	MisBeginCondition( Checksailexpless, 9880)
	MisBeginAction(	AddMission, 1442)
	MisBeginAction( SetRecord, 1431)
	MisBeginAction( AddTrigger, 14421, TE_KILL, 978, 1)
	MisCancelAction( ClearMission, 1442)
	MisCancelAction( ClearRecord, 1431)

	MisNeed( MIS_NEED_KILL, 978, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000615")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000615)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000616")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000616)
	MisResultCondition( HasFlag, 1442, 10)
	MisResultCondition( HasMission, 1442)
	MisResultAction( AddSailExp, 90, 90)
	MisResultAction( ClearMission, 1442)
	MisResultAction( ClearRecord, 1431)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 978 )
	TriggerAction( 1, AddNextFlag, 1442, 10, 1 )
	RegCurTrigger( 14422 )

	-------------------------------------------------乱斗英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000639 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000639")
	DefineMission (5608, MISSCRIPT_MISSIONSCRIPT07_LUA_000639, 1114)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000640 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000640")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000640)

	MisBeginCondition(NoMission,1114)
	MisBeginCondition(HasRecord,1111)
	MisBeginCondition(NoRecord,1114)
	MisBeginAction(AddMission,1114)
	MisCancelAction(ClearMission, 1114)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000641 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000641")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000641)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000642 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000642")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000642)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000643 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000643")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000643)

	MisResultCondition(HasMission, 1114)
	MisResultCondition(NoRecord,1114)
	MisResultCondition(HasFightingPoint,30 )
	MisResultAction(TakeFightingPoint, 30 )
	MisResultAction(ClearMission, 1114)
	MisResultAction(SetRecord,  1114 )
	MisResultAction(GiveItem, 3028, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000644 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000644")
	DefineMission (5609, MISSCRIPT_MISSIONSCRIPT07_LUA_000644, 1115)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000645 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000645")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000645)

	MisBeginCondition(NoMission,1115)
	MisBeginCondition(HasRecord,1111)
	MisBeginCondition(NoRecord,1115)
	MisBeginAction(AddMission,1115)
	MisCancelAction(ClearMission, 1115)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000646 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000646")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000646)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000647 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000647")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000647)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000648 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000648")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000648)

	MisResultCondition(HasMission, 1115)
	MisResultCondition(NoRecord,1115)
	MisResultCondition(HasCredit,1000 )
	MisResultAction(TakeCredit, 1000 )
	MisResultAction(ClearMission, 1115)
	MisResultAction(SetRecord,  1115 )
	MisResultAction(GiveItem, 3029, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000649 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000649")
	DefineMission (5610, MISSCRIPT_MISSIONSCRIPT07_LUA_000649, 1116)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000650 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000650")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000650)

	MisBeginCondition(NoMission,1116)
	MisBeginCondition(HasRecord,1111)
	MisBeginCondition(NoRecord,1116)
	MisBeginAction(AddMission,1116)
	MisCancelAction(ClearMission, 1116)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000651 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000651")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000651)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000652 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000652")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000652)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000653 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000653")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000653)

	MisResultCondition(HasMission, 1116)
	MisResultCondition(NoRecord,1116)
	MisResultCondition(LvCheck, ">", 54 )
	MisResultAction(ClearMission, 1116)
	MisResultAction(SetRecord,  1116 )
	MisResultAction(GiveItem, 3030, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000654 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000654")
	DefineMission (5611, MISSCRIPT_MISSIONSCRIPT07_LUA_000654, 1117)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000655 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000655")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000655)

	MisBeginCondition(NoMission,1117)
	MisBeginCondition(HasRecord,1111)
	MisBeginCondition(NoRecord,1117)
	MisBeginAction(AddMission,1117)
	MisCancelAction(ClearMission, 1117)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000656 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000656")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000656)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000657 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000657")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000657)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000658 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000658")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000658)

	MisResultCondition(HasMission, 1117)
	MisResultCondition(NoRecord,1117)
	MisResultCondition(HasHonorPoint,300 )
	MisResultAction(TakeHonorPoint, 300 )
	MisResultAction(ClearMission, 1117)
	MisResultAction(SetRecord,  1117 )
	MisResultAction(GiveItem, 3031, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000659 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000659")
	DefineMission (5612, MISSCRIPT_MISSIONSCRIPT07_LUA_000659, 1118)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000660 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000660")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000660)

	MisBeginCondition(NoMission,1118)
	MisBeginCondition(HasRecord,1111)
	MisBeginCondition(NoRecord,1118)
	MisBeginAction(AddMission,1118)
	MisBeginAction(AddTrigger, 11181, TE_GETITEM, 4804, 10 )---------------带刺的曼陀罗花10
	MisBeginAction(AddTrigger, 11182, TE_GETITEM, 4720, 10 )---------------巨大的熊掌10
	MisBeginAction(AddTrigger, 11183, TE_GETITEM, 3129, 10 )-------------药用草叶10
	MisBeginAction(AddTrigger, 11184, TE_GETITEM, 2588, 5 )--------------精灵辉印5张
	MisBeginAction(AddTrigger, 11185, TE_GETITEM, 4494, 1 )--------------巨大的蟹钳1个
	MisBeginAction(AddTrigger, 11186, TE_GETITEM, 1682, 50 )-------------犬齿50个
	MisBeginAction(AddTrigger, 11187, TE_GETITEM, 1138, 10 )--------------幽灵探测器LV1  10个
	MisBeginAction(AddTrigger, 11188, TE_GETITEM, 0227, 1 )-------------守护精灵饲料1个
	MisCancelAction(ClearMission, 1118)
	

	MisNeed(MIS_NEED_ITEM, 4804, 10, 1, 10 )
	MisNeed(MIS_NEED_ITEM, 4720, 10, 11, 10 )
	MisNeed(MIS_NEED_ITEM, 3129, 10, 21, 10 )
	MisNeed(MIS_NEED_ITEM, 2588, 5, 31, 5 )
	MisNeed(MIS_NEED_ITEM, 4494, 1, 36, 1 )
	MisNeed(MIS_NEED_ITEM, 1682, 50, 37, 50 )
	MisNeed(MIS_NEED_ITEM, 1138, 10, 87, 10 )
	MisNeed(MIS_NEED_ITEM, 0227, 1, 97, 1 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000661 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000661")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000661)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000662 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000662")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000662)

	MisResultCondition(HasMission, 1118)
	MisResultCondition(NoRecord,1118)
	MisResultCondition(HasItem, 4804, 10 )
	MisResultCondition(HasItem, 4720, 10 )
	MisResultCondition(HasItem, 3129, 10 )
	MisResultCondition(HasItem, 2588, 5 )
	MisResultCondition(HasItem, 4494, 1 )
	MisResultCondition(HasItem, 1682, 50 )
	MisResultCondition(HasItem, 1138, 10 )
	MisResultCondition(HasItem, 0227, 1 )

	MisResultAction(TakeItem, 4804, 10 )
	MisResultAction(TakeItem, 4720, 10 )
	MisResultAction(TakeItem, 3129, 10 )
	MisResultAction(TakeItem, 2588, 5 )
	MisResultAction(TakeItem, 4494, 1 )
	MisResultAction(TakeItem, 1682, 50 )
	MisResultAction(TakeItem, 1138, 10 )
	MisResultAction(TakeItem, 0227, 1 )
	MisResultAction(ClearMission, 1118)
	MisResultAction(SetRecord,  1118 )
	MisResultAction(GiveItem, 3032, 1, 4)
	MisResultAction(GiveItem, 3036, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4804)	
	TriggerAction( 1, AddNextFlag, 1118, 1, 10 )
	RegCurTrigger( 11181 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4720)	
	TriggerAction( 1, AddNextFlag, 1118, 11, 10 )
	RegCurTrigger( 11182 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3129)	
	TriggerAction( 1, AddNextFlag, 1118, 21, 10 )
	RegCurTrigger( 11183 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2588)	
	TriggerAction( 1, AddNextFlag, 1118, 31, 5 )
	RegCurTrigger( 11184 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4494)	
	TriggerAction( 1, AddNextFlag, 1118, 36, 1 )
	RegCurTrigger( 11185 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1682)	
	TriggerAction( 1, AddNextFlag, 1118, 37, 50 )
	RegCurTrigger( 11186 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1138)	
	TriggerAction( 1, AddNextFlag, 1118, 87, 10 )
	RegCurTrigger( 11187 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0227)	
	TriggerAction( 1, AddNextFlag, 1118, 97, 1 )
	RegCurTrigger( 11188 )


	----------------------------------------------------------金牛末日----------芭芭拉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000663 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000663")
	DefineMission( 5613, MISSCRIPT_MISSIONSCRIPT07_LUA_000663, 1119 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000664 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000664")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000664)
				
	MisBeginCondition(NoMission, 1119)
	MisBeginCondition(HasRecord,1152)
	MisBeginCondition(NoRecord,1119)
	MisBeginAction(AddMission,1119)
	MisBeginAction(AddTrigger, 11191, TE_KILL, 1038, 1)---金牛守护者
	
	MisCancelAction(ClearMission, 1119)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000665 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000665")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000665)
	MisNeed(MIS_NEED_KILL, 1038,1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000666 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000666")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000666)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000667 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000667")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000667)
	MisResultCondition(HasMission,  1119)
	MisResultCondition(HasFlag, 1119, 10)
	MisResultCondition(NoRecord , 1119)
	MisResultAction(GiveItem, 3034, 1, 4 )
	MisResultAction(ClearMission,  1119)
	MisResultAction(SetRecord,  1119 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1038)	
	TriggerAction( 1, AddNextFlag, 1119, 10, 1 )
	RegCurTrigger( 11191 )






-------------------------------------------------乱斗英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000639 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000639")
	DefineMission (5614, MISSCRIPT_MISSIONSCRIPT07_LUA_000639, 1120)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000640 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000640")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000640)

	MisBeginCondition(NoMission,1120)
	MisBeginCondition(HasRecord,1112)
	MisBeginCondition(NoRecord,1120)
	MisBeginAction(AddMission,1120)
	MisCancelAction(ClearMission, 1120)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000668 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000668")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000668)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000669 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000669")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000669)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000643 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000643")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000643)

	MisResultCondition(HasMission, 1120)
	MisResultCondition(NoRecord,1120)
	MisResultCondition(HasFightingPoint,60 )
	MisResultAction(TakeFightingPoint, 60 )
	MisResultAction(ClearMission, 1120)
	MisResultAction(SetRecord,  1120 )
	MisResultAction(GiveItem, 3028, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000644 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000644")
	DefineMission (5615, MISSCRIPT_MISSIONSCRIPT07_LUA_000644, 1121)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000670 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000670")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000670)

	MisBeginCondition(NoMission,1121)
	MisBeginCondition(HasRecord,1112)
	MisBeginCondition(NoRecord,1121)
	MisBeginAction(AddMission,1121)
	MisCancelAction(ClearMission, 1121)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000671 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000671")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000671)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000647 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000647")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000647)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000648 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000648")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000648)

	MisResultCondition(HasMission, 1121)
	MisResultCondition(NoRecord,1121)
	MisResultCondition(HasCredit,3000 )
	MisResultAction(TakeCredit,3000  )
	MisResultAction(ClearMission, 1121)
	MisResultAction(SetRecord,  1121 )
	MisResultAction(GiveItem, 3029, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000649 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000649")
	DefineMission (5616, MISSCRIPT_MISSIONSCRIPT07_LUA_000649, 1122)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000672 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000672")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000672)

	MisBeginCondition(NoMission,1122)
	MisBeginCondition(HasRecord,1112)
	MisBeginCondition(NoRecord,1122)
	MisBeginAction(AddMission,1122)
	MisCancelAction(ClearMission, 1122)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000673 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000673")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000673)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000674 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000674")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000674)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000653 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000653")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000653)

	MisResultCondition(HasMission, 1122)
	MisResultCondition(NoRecord,1122)
	MisResultCondition(LvCheck, ">", 59 )
	MisResultAction(ClearMission, 1122)
	MisResultAction(SetRecord,  1122 )
	MisResultAction(GiveItem, 3030, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000654 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000654")
	DefineMission (5617, MISSCRIPT_MISSIONSCRIPT07_LUA_000654, 1123)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000675 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000675")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000675)

	MisBeginCondition(NoMission,1123)
	MisBeginCondition(HasRecord,1112)
	MisBeginCondition(NoRecord,1123)
	MisBeginAction(AddMission,1123)
	MisCancelAction(ClearMission, 1123)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000676 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000676")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000676)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000657 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000657")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000657)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000658 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000658")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000658)

	MisResultCondition(HasMission, 1123)
	MisResultCondition(NoRecord,1123)
	MisResultCondition(HasHonorPoint,500 )
	MisResultAction(TakeHonorPoint, 500 )
	MisResultAction(ClearMission, 1123)
	MisResultAction(SetRecord,  1123 )
	MisResultAction(GiveItem, 3031, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000659 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000659")
	DefineMission (5618, MISSCRIPT_MISSIONSCRIPT07_LUA_000659, 1124)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000677 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000677")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000677)

	MisBeginCondition(NoMission,1124)
	MisBeginCondition(HasRecord,1112)
	MisBeginCondition(NoRecord,1124)
	MisBeginAction(AddMission,1124)
	MisBeginAction(AddTrigger, 11241, TE_GETITEM, 4804, 15 )-------------------带刺的曼陀罗花15    
	MisBeginAction(AddTrigger, 11242, TE_GETITEM, 4720, 15 )-------------------巨大的熊掌15          
	MisBeginAction(AddTrigger, 11243, TE_GETITEM, 3129, 15 )-----------------药用草叶15               
	MisBeginAction(AddTrigger, 11244, TE_GETITEM, 2588, 10 )----------------精灵辉印10张               
	MisBeginAction(AddTrigger, 11245, TE_GETITEM, 4494, 1 )------------------巨大的蟹钳1个            
	MisBeginAction(AddTrigger, 11246, TE_GETITEM, 1682, 40 )-----------------犬齿40个                  
	MisBeginAction(AddTrigger, 11247, TE_GETITEM, 1138, 20 )------------------幽灵探测器LV1  20个 
	MisBeginAction(AddTrigger, 11248, TE_GETITEM, 0227, 3 )---------------守护精灵饲料3个          
	MisCancelAction(ClearMission, 1124)
	

	MisNeed(MIS_NEED_ITEM, 4804, 15, 1, 15 )
	MisNeed(MIS_NEED_ITEM, 4720, 15, 16, 15 )
	MisNeed(MIS_NEED_ITEM, 3129, 15, 31, 15 )
	MisNeed(MIS_NEED_ITEM, 2588, 10, 46, 10 )
	MisNeed(MIS_NEED_ITEM, 4494, 1, 56, 1 )
	MisNeed(MIS_NEED_ITEM, 1682, 40, 57, 40 )
	MisNeed(MIS_NEED_ITEM, 1138, 20, 97, 20 )
	MisNeed(MIS_NEED_ITEM, 0227, 3, 117, 3 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000661 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000661")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000661)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000662 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000662")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000662)

	MisResultCondition(HasMission, 1124)
	MisResultCondition(NoRecord,1124)
	MisResultCondition(HasItem, 4804, 15 )
	MisResultCondition(HasItem, 4720, 15 )
	MisResultCondition(HasItem, 3129, 15 )
	MisResultCondition(HasItem, 2588, 10 )
	MisResultCondition(HasItem, 4494, 1 )
	MisResultCondition(HasItem, 1682, 40 )
	MisResultCondition(HasItem, 1138, 20 )
	MisResultCondition(HasItem, 0227, 3 )

	MisResultAction(TakeItem, 4804, 15 )
	MisResultAction(TakeItem, 4720, 15 )
	MisResultAction(TakeItem, 3129, 15 )
	MisResultAction(TakeItem, 2588, 10 )
	MisResultAction(TakeItem, 4494, 1 )
	MisResultAction(TakeItem, 1682, 40 )
	MisResultAction(TakeItem, 1138, 20 )
	MisResultAction(TakeItem, 0227, 3 )
	MisResultAction(ClearMission, 1124)
	MisResultAction(SetRecord,  1124 )
	MisResultAction(GiveItem, 3032, 1, 4)
	MisResultAction(GiveItem, 3036, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4804)	
	TriggerAction( 1, AddNextFlag, 1124, 1, 15 )
	RegCurTrigger( 11241 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4720)	
	TriggerAction( 1, AddNextFlag, 1124, 16, 15 )
	RegCurTrigger( 11242 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3129)	
	TriggerAction( 1, AddNextFlag, 1124, 31, 15 )
	RegCurTrigger( 11243 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2588)	
	TriggerAction( 1, AddNextFlag, 1124, 46, 10 )
	RegCurTrigger( 11244 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4494)	
	TriggerAction( 1, AddNextFlag, 1124, 56, 1 )
	RegCurTrigger( 11245 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1682)	
	TriggerAction( 1, AddNextFlag, 1124, 57, 40 )
	RegCurTrigger( 11246 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1138)	
	TriggerAction( 1, AddNextFlag, 1124, 97, 20 )
	RegCurTrigger( 11247 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0227)	
	TriggerAction( 1, AddNextFlag, 1124, 117, 3 )
	RegCurTrigger( 11248 )

	



-------------------------------------------------乱斗英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000639 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000639")
	DefineMission (5619, MISSCRIPT_MISSIONSCRIPT07_LUA_000639, 1125)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000678 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000678")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000678)

	MisBeginCondition(NoMission,1125)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(NoRecord,1125)
	MisBeginAction(AddMission,1125)
	MisCancelAction(ClearMission, 1125)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000679 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000679")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000679)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000680 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000680")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000680)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000643 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000643")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000643)

	MisResultCondition(HasMission, 1125)
	MisResultCondition(NoRecord,1125)
	MisResultCondition(HasFightingPoint,100 )
	MisResultAction(TakeFightingPoint, 100 )
	MisResultAction(ClearMission, 1125)
	MisResultAction(SetRecord,  1125 )
	MisResultAction(GiveItem, 3028, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000644 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000644")
	DefineMission (5620, MISSCRIPT_MISSIONSCRIPT07_LUA_000644, 1126)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000681 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000681")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000681)

	MisBeginCondition(NoMission,1126)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(NoRecord,1126)
	MisBeginAction(AddMission,1126)
	MisCancelAction(ClearMission, 1126)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000682 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000682")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000682)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000647 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000647")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000647)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000648 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000648")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000648)

	MisResultCondition(HasMission, 1126)
	MisResultCondition(NoRecord,1126)
	MisResultCondition(HasCredit,5000 )
	MisResultAction(TakeCredit, 5000 )
	MisResultAction(ClearMission, 1126)
	MisResultAction(SetRecord,  1126 )
	MisResultAction(GiveItem, 3029, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000649 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000649")
	DefineMission (5621, MISSCRIPT_MISSIONSCRIPT07_LUA_000649, 1127)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000683 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000683")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000683)

	MisBeginCondition(NoMission,1127)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(NoRecord,1127)
	MisBeginAction(AddMission,1127)
	MisCancelAction(ClearMission, 1127)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000684 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000684")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000684)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000685 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000685")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000685)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000653 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000653")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000653)

	MisResultCondition(HasMission, 1127)
	MisResultCondition(NoRecord,1127)
	MisResultCondition(LvCheck, ">", 64 )
	MisResultAction(ClearMission, 1127)
	MisResultAction(SetRecord,  1127 )
	MisResultAction(GiveItem, 3030, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000654 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000654")
	DefineMission (5622, MISSCRIPT_MISSIONSCRIPT07_LUA_000654, 1128)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000686 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000686")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000686)

	MisBeginCondition(NoMission,1128)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(NoRecord,1128)
	MisBeginAction(AddMission,1128)
	MisCancelAction(ClearMission, 1128)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000687 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000687")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000687)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000657 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000657")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000657)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000658 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000658")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000658)

	MisResultCondition(HasMission, 1128)
	MisResultCondition(NoRecord,1128)
	MisResultCondition(HasHonorPoint,800 )
	MisResultAction(TakeHonorPoint, 800 )
	MisResultAction(ClearMission, 1128)
	MisResultAction(SetRecord,  1128 )
	MisResultAction(GiveItem, 3031, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000659 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000659")
	DefineMission (5623, MISSCRIPT_MISSIONSCRIPT07_LUA_000659, 1129)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000677 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000677")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000677)

	MisBeginCondition(NoMission,1129)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(NoRecord,1129)
	MisBeginAction(AddMission,1129)
	MisBeginAction(AddTrigger, 11291, TE_GETITEM, 4804, 10 )---------------------带刺的曼陀罗花10    
	MisBeginAction(AddTrigger, 11292, TE_GETITEM, 4720, 10 )---------------------巨大的熊掌10          
	MisBeginAction(AddTrigger, 11293, TE_GETITEM, 3129, 10 )-------------------药用草叶10               
	MisBeginAction(AddTrigger, 11294, TE_GETITEM, 2588, 15 )------------------精灵辉印15张             
	MisBeginAction(AddTrigger, 11295, TE_GETITEM, 4494, 5 )--------------------巨大的蟹钳5个             
	MisBeginAction(AddTrigger, 11296, TE_GETITEM, 1682, 40 )-------------------犬齿40个                  
	MisBeginAction(AddTrigger, 11297, TE_GETITEM, 1138, 25 )--------------------幽灵探测器LV1  25个 
	MisBeginAction(AddTrigger, 11298, TE_GETITEM, 0227, 5 )----------------------守护精灵饲料5个            
	MisCancelAction(ClearMission, 1129)						                                     
	

	MisNeed(MIS_NEED_ITEM, 4804, 10, 1, 10 )
	MisNeed(MIS_NEED_ITEM, 4720, 10, 11, 10 )
	MisNeed(MIS_NEED_ITEM, 3129, 10, 21, 10 )
	MisNeed(MIS_NEED_ITEM, 2588, 15, 31, 15 )
	MisNeed(MIS_NEED_ITEM, 4494, 5, 46, 5)
	MisNeed(MIS_NEED_ITEM, 1682, 40, 51, 40 )
	MisNeed(MIS_NEED_ITEM, 1138, 25, 91, 25 )
	MisNeed(MIS_NEED_ITEM, 0227, 5, 116, 5 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000661 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000661")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000661)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000662 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000662")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000662)

	MisResultCondition(HasMission, 1129)
	MisResultCondition(NoRecord,1129)
	MisResultCondition(HasItem, 4804, 10 )
	MisResultCondition(HasItem, 4720, 10 )
	MisResultCondition(HasItem, 3129, 10 )
	MisResultCondition(HasItem, 2588, 15 )
	MisResultCondition(HasItem, 4494,  5 )
	MisResultCondition(HasItem, 1682, 40 )
	MisResultCondition(HasItem, 1138, 25 )
	MisResultCondition(HasItem, 0227, 5 )

	MisResultAction(TakeItem, 4804, 10 )
	MisResultAction(TakeItem, 4720, 10 )
	MisResultAction(TakeItem, 3129, 10 )
	MisResultAction(TakeItem, 2588, 15 )
	MisResultAction(TakeItem, 4494, 5 )
	MisResultAction(TakeItem, 1682, 40 )
	MisResultAction(TakeItem, 1138, 25 )
	MisResultAction(TakeItem, 0227, 5 )
	MisResultAction(ClearMission, 1129)
	MisResultAction(SetRecord,  1129 )
	MisResultAction(GiveItem, 3032, 1, 4)
	MisResultAction(GiveItem, 3036, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4804)	
	TriggerAction( 1, AddNextFlag, 1129, 1, 10 )
	RegCurTrigger( 11291 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4720)	
	TriggerAction( 1, AddNextFlag, 1129, 11, 10 )
	RegCurTrigger( 11292 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3129)	
	TriggerAction( 1, AddNextFlag, 1129, 21, 10 )
	RegCurTrigger( 11293 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2588)	
	TriggerAction( 1, AddNextFlag, 1129, 31, 15 )
	RegCurTrigger( 11294 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4494)	
	TriggerAction( 1, AddNextFlag, 1129, 46, 5 )
	RegCurTrigger( 11295 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1682)	
	TriggerAction( 1, AddNextFlag, 1129, 51, 40 )
	RegCurTrigger( 11296 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1138)	
	TriggerAction( 1, AddNextFlag, 1129, 91, 25 )
	RegCurTrigger( 11297 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0227)	
	TriggerAction( 1, AddNextFlag, 1129, 116, 5 )
	RegCurTrigger( 11298 )


	

	----------------------------------------------------------社交大使----------芭芭拉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000688 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000688")
	DefineMission( 5624, MISSCRIPT_MISSIONSCRIPT07_LUA_000688, 1130 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000689 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000689")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000689)
				
	MisBeginCondition(NoMission, 1130)
	MisBeginCondition(NoRecord,1130)
	MisBeginCondition(HasRecord, 1152)-------------------新的id,最后的id
	MisBeginAction(AddMission,1130)
	MisCancelAction(ClearMission, 1130)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000690 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000690")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000690)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000691 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000691")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000691)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使-----------------賽·魔力

	MISSCRIPT_MISSIONSCRIPT07_LUA_000268 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000268")
	DefineMission(5625, MISSCRIPT_MISSIONSCRIPT07_LUA_000268, 1130, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000692 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000692")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000692)
	MisResultCondition(NoRecord, 1130)
	MisResultCondition(HasMission,1130)
	MisResultAction(ClearMission,1130)
	MisResultAction(SetRecord, 1130)

	----------------------------------------------------------社交大使2----------賽·魔力
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission( 5626, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1131 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000693 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000693")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000693)
				
	MisBeginCondition(NoMission, 1131)
	MisBeginCondition(NoRecord,1131)
	MisBeginCondition(HasRecord, 1130)
	MisBeginAction(AddMission,1131)
	MisCancelAction(ClearMission, 1131)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000694 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000694")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000694)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000695 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000695")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000695)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使2-------------圣女·艾达
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission(5627, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1131, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000696 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000696")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000696)
	MisResultCondition(NoRecord, 1131)
	MisResultCondition(HasMission,1131)
	MisResultAction(ClearMission,1131)
	MisResultAction(SetRecord, 1131)

	----------------------------------------------------------社交大使3----------圣女·艾达
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission( 5628, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1132 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000697 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000697")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000697)
				
	MisBeginCondition(NoMission, 1132)
	MisBeginCondition(NoRecord,1132)
	MisBeginCondition(HasRecord, 1131)
	MisBeginAction(AddMission,1132)
	MisCancelAction(ClearMission, 1132)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000698 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000698")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000698)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000699 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000699")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000699)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使3--------阿泰
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission(5629, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1132, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000700 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000700")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000700)
	MisResultCondition(NoRecord, 1132)
	MisResultCondition(HasMission,1132)
	MisResultAction(ClearMission,1132)
	MisResultAction(SetRecord, 1132)



	----------------------------------------------------------社交大使4----------阿泰
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission( 5630, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1133 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000701 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000701")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000701)
				
	MisBeginCondition(NoMission, 1133)
	MisBeginCondition(NoRecord,1133)
	MisBeginCondition(HasRecord, 1132)
	MisBeginAction(AddMission,1133)
	MisCancelAction(ClearMission, 1133)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000702 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000702")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000702)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000703 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000703")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000703)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使4--------老奶奶·贝蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission(5631, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1133, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000704 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000704")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000704)
	MisResultCondition(NoRecord, 1133)
	MisResultCondition(HasMission,1133)
	MisResultAction(ClearMission,1133)
	MisResultAction(SetRecord, 1133)


	----------------------------------------------------------社交大使5----------老奶奶·贝蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission( 5632, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1134 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000705 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000705")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000705)
				
	MisBeginCondition(NoMission, 1134)
	MisBeginCondition(NoRecord,1134)
	MisBeginCondition(HasRecord, 1133)
	MisBeginAction(AddMission,1134)
	MisCancelAction(ClearMission, 1134)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000706 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000706")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000706)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000707 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000707")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000707)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使5--------交易员·尤卡
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission(5633, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1134, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000708 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000708")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000708)
	MisResultCondition(NoRecord, 1134)
	MisResultCondition(HasMission,1134)
	MisResultAction(ClearMission,1134)
	MisResultAction(SetRecord, 1134)


	----------------------------------------------------------社交大使6----------交易员·尤卡
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission( 5634, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1135 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000709 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000709")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000709)
				
	MisBeginCondition(NoMission, 1135)
	MisBeginCondition(NoRecord,1135)
	MisBeginCondition(HasRecord, 1134)
	MisBeginAction(AddMission,1135)
	MisCancelAction(ClearMission, 1135)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000710 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000710")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000710)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000711 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000711")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000711)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使6--------海港指挥·奥登
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission(5635, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1135, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000712 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000712")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000712)
	MisResultCondition(NoRecord, 1135)
	MisResultCondition(HasMission,1135)
	MisResultAction(ClearMission,1135)
	MisResultAction(SetRecord, 1135)



	----------------------------------------------------------社交大使7----------海港指挥·奥登
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission( 5636, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1136 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000713 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000713")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000713)
				
	MisBeginCondition(NoMission, 1136)
	MisBeginCondition(NoRecord,1136)
	MisBeginCondition(HasRecord, 1135)
	MisBeginAction(AddMission,1136)
	MisCancelAction(ClearMission, 1136)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000714 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000714")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000714)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000715 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000715")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000715)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使7--------贝壳商人·拉姆
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission(5637, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1136, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000716 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000716")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000716)
	MisResultCondition(NoRecord, 1136)
	MisResultCondition(HasMission,1136)
	MisResultAction(ClearMission,1136)
	MisResultAction(SetRecord, 1136)


	----------------------------------------------------------社交大使8----------贝壳商人·拉姆
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission( 5638, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1137 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000717 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000717")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000717)
				
	MisBeginCondition(NoMission, 1137)
	MisBeginCondition(NoRecord,1137)
	MisBeginCondition(HasRecord, 1136)
	MisBeginAction(AddMission,1137)
	MisCancelAction(ClearMission, 1137)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000718 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000718")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000718)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000719 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000719")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000719)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使8--------杰克船长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission(5639, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1137, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000720 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000720")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000720)
	MisResultCondition(NoRecord, 1137)
	MisResultCondition(HasMission,1137)
	MisResultAction(ClearMission,1137)
	MisResultAction(SetRecord, 1137)


	----------------------------------------------------------社交大使9----------杰克船长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission( 5640, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1138 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000721 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000721")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000721)
				
	MisBeginCondition(NoMission, 1138)
	MisBeginCondition(NoRecord,1138)
	MisBeginCondition(HasRecord, 1137)
	MisBeginAction(AddMission,1138)
	MisCancelAction(ClearMission, 1138)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000722 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000722")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000722)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000723 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000723")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000723)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使9--------东方海盗·山田佐
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission(5641, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1138, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000724 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000724")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000724)
	MisResultCondition(NoRecord, 1138)
	MisResultCondition(HasMission,1138)
	MisResultAction(ClearMission,1138)
	MisResultAction(SetRecord, 1138)

	----------------------------------------------------------社交大使10----------东方海盗·山田佐
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission( 5642, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1139 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000725 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000725")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000725)
				
	MisBeginCondition(NoMission, 1139)
	MisBeginCondition(NoRecord,1139)
	MisBeginCondition(HasRecord, 1138)
	MisBeginAction(AddMission,1139)
	MisCancelAction(ClearMission, 1139)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000726 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000726")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000726)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000727 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000727")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000727)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使10--------交易员·赛瑟尼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission(5643, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1139, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000728 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000728")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000728)
	MisResultCondition(NoRecord, 1139)
	MisResultCondition(HasMission,1139)
	MisResultAction(ClearMission,1139)
	MisResultAction(SetRecord, 1139)

	----------------------------------------------------------社交大使11----------交易员·赛瑟尼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission( 5644, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1140 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000729 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000729")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000729)
				
	MisBeginCondition(NoMission, 1140)
	MisBeginCondition(NoRecord,1140)
	MisBeginCondition(HasRecord, 1139)
	MisBeginAction(AddMission,1140)
	MisCancelAction(ClearMission, 1140)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000730 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000730")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000730)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000731 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000731")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000731)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使11--------汉姆
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission(5645, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1140, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000732 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000732")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000732)
	MisResultCondition(NoRecord, 1140)
	MisResultCondition(HasMission,1140)
	MisResultAction(ClearMission,1140)
	MisResultAction(SetRecord, 1140)

	----------------------------------------------------------社交大使12----------汉姆
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission( 5646, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1141 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000733 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000733")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000733)
				
	MisBeginCondition(NoMission, 1141)
	MisBeginCondition(NoRecord,1141)
	MisBeginCondition(HasRecord, 1140)
	MisBeginAction(AddMission,1141)
	MisCancelAction(ClearMission, 1141)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000734 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000734")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000734)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000735 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000735")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000735)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使12--------朱比
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission(5647, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1141, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000736 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000736")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000736)
	MisResultCondition(NoRecord, 1141)
	MisResultCondition(HasMission,1141)
	MisResultAction(ClearMission,1141)
	MisResultAction(SetRecord, 1141)


	----------------------------------------------------------社交大使13----------朱比
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission( 5648, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1142 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000737 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000737")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000737)
				
	MisBeginCondition(NoMission, 1142)
	MisBeginCondition(NoRecord,1142)
	MisBeginCondition(HasRecord, 1141)
	MisBeginAction(AddMission,1142)
	MisCancelAction(ClearMission, 1142)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000738 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000738")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000738)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000739 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000739")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000739)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使13--------饰品商人·里克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission(5649, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1142, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000740 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000740")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000740)
	MisResultCondition(NoRecord, 1142)
	MisResultCondition(HasMission,1142)
	MisResultAction(ClearMission,1142)
	MisResultAction(SetRecord, 1142)

	----------------------------------------------------------社交大使14----------饰品商人·里克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission( 5650, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1143 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000741 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000741")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000741)
				
	MisBeginCondition(NoMission, 1143)
	MisBeginCondition(NoRecord,1143)
	MisBeginCondition(HasRecord, 1142)
	MisBeginAction(AddMission,1143)
	MisCancelAction(ClearMission, 1143)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000742 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000742")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000742)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000743 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000743")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000743)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使14--------海盗杰里米        
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission(5651, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1143, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000744 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000744")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000744)
	MisResultCondition(NoRecord, 1143)
	MisResultCondition(HasMission,1143)
	MisResultAction(ClearMission,1143)
	MisResultAction(SetRecord, 1143)

	----------------------------------------------------------社交大使15----------海盗杰里米
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission( 5652, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1144 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000745 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000745")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000745)
				
	MisBeginCondition(NoMission, 1144)
	MisBeginCondition(NoRecord,1144)
	MisBeginCondition(HasRecord, 1143)
	MisBeginAction(AddMission,1144)
	MisCancelAction(ClearMission, 1144)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000746 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000746")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000746)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000338 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000338")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000338)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使15-------- 雷斯·小虫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission(5653, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1144, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000747 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000747")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000747)
	MisResultCondition(NoRecord, 1144)
	MisResultCondition(HasMission,1144)
	MisResultAction(ClearMission,1144)
	MisResultAction(SetRecord, 1144)


	----------------------------------------------------------社交大使16----------雷斯·小虫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission( 5654, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1145 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000748 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000748")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000748)
				
	MisBeginCondition(NoMission, 1145)
	MisBeginCondition(NoRecord,1145)
	MisBeginCondition(HasRecord, 1144)
	MisBeginAction(AddMission,1145)
	MisCancelAction(ClearMission, 1145)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000749 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000749")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000749)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000750 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000750")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000750)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使16-------- 海港指挥·瓦雷米
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission(5655, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1145, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000751 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000751")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000751)
	MisResultCondition(NoRecord, 1145)
	MisResultCondition(HasMission,1145)
	MisResultAction(ClearMission,1145)
	MisResultAction(SetRecord, 1145)


	----------------------------------------------------------社交大使17----------海港指挥·瓦雷米
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission( 5656, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1146 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000752 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000752")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000752)
				
	MisBeginCondition(NoMission, 1146)
	MisBeginCondition(NoRecord,1146)
	MisBeginCondition(HasRecord, 1145)
	MisBeginAction(AddMission,1146)
	MisCancelAction(ClearMission, 1146)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000753 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000753")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000753)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000754 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000754")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000754)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使17-------- 索拉姆·萨加
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission(5657, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1146, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000755 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000755")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000755)
	MisResultCondition(NoRecord, 1146)
	MisResultCondition(HasMission,1146)
	MisResultAction(ClearMission,1146)
	MisResultAction(SetRecord, 1146)

	----------------------------------------------------------社交大使18----------索拉姆·萨加
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission( 5658, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1147 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000756 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000756")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000756)
				
	MisBeginCondition(NoMission, 1147)
	MisBeginCondition(NoRecord,1147)
	MisBeginCondition(HasRecord, 1146)
	MisBeginAction(AddMission,1147)
	MisCancelAction(ClearMission, 1147)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000757 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000757")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000757)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000758 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000758")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000758)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使18-------- 海港指挥·拉米修
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission(5659, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1147, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000759 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000759")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000759)
	MisResultCondition(NoRecord, 1147)
	MisResultCondition(HasMission,1147)
	MisResultAction(ClearMission,1147)
	MisResultAction(SetRecord, 1147)

	----------------------------------------------------------社交大使19----------海港指挥·拉米修
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission( 5660, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1148 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000760 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000760")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000760)
				
	MisBeginCondition(NoMission, 1148)
	MisBeginCondition(NoRecord,1148)
	MisBeginCondition(HasRecord, 1147)
	MisBeginAction(AddMission,1148)
	MisCancelAction(ClearMission, 1148)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000312 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000312")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000312)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000761 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000761")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000761)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使19-------- 伊丽莎白
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission(5661, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1148, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000762 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000762")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000762)
	MisResultCondition(NoRecord, 1148)
	MisResultCondition(HasMission,1148)
	MisResultAction(ClearMission,1148)
	MisResultAction(SetRecord, 1148)


		----------------------------------------------------------社交大使20----------伊丽莎白
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission( 5662, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1149 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000763 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000763")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000763)
				
	MisBeginCondition(NoMission, 1149)
	MisBeginCondition(NoRecord,1149)
	MisBeginCondition(HasRecord, 1148)
	MisBeginAction(AddMission,1149)
	MisCancelAction(ClearMission, 1149)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000764 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000764")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000764)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000363 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000363")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000363)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使20-------- 矿工大肚腩
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission(5663, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1149, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000765 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000765")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000765)
	MisResultCondition(NoRecord, 1149)
	MisResultCondition(HasMission,1149)
	MisResultAction(ClearMission,1149)
	MisResultAction(SetRecord, 1149)

		----------------------------------------------------------社交大使21----------矿工大肚腩
	MISSCRIPT_MISSIONSCRIPT07_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000365")
	DefineMission( 5664, MISSCRIPT_MISSIONSCRIPT07_LUA_000365, 1150 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000766 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000766")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000766)
				
	MisBeginCondition(NoMission, 1150)
	MisBeginCondition(NoRecord,1150)
	MisBeginCondition(HasRecord, 1149)
	MisBeginAction(AddMission,1150)
	MisCancelAction(ClearMission, 1150)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000767 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000767")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000767)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000768 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000768")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000768)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交英雄21------- 芭芭拉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000769 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000769")
	DefineMission(5667, MISSCRIPT_MISSIONSCRIPT07_LUA_000769, 1150, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000373 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000373")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000373)
	MisResultCondition(NoRecord, 1150)
	MisResultCondition(HasMission,1150)
	MisResultAction(ClearMission,1150)
	MisResultAction(SetRecord, 1150)
	MisResultAction(GiveItem, 3033, 1, 4)
	MisResultBagNeed(1)

--	-------------------------------------------------特别任务	--------芭芭拉
--	DefineMission (5668, "血溅金牛之特别行动", 1153)
--	
--	MisBeginTalk("<t>这个任务是金牛宫特别行动,你可以不参加,当然不参加的没有礼物拿.<b10分钟内航行到弗里补给站找海港指挥·布纽(2042,6351)>")
--
--	MisBeginCondition(NoMission,1153)
--	MisBeginCondition(NoRecord,1153)
--	MisBeginCondition(HasRecord,1113)
--	MisBeginCondition(HasRecord,1114)
--	MisBeginCondition(HasRecord,1115)
--	MisBeginCondition(HasRecord,1116)
--	MisBeginCondition(HasRecord,1117)
--	MisBeginCondition(HasRecord,1118)
--	MisBeginCondition(HasRecord,1150)
--	MisBeginCondition(HasRecord,1119)
--	MisBeginAction(AddMission,1153)
--	MisBeginAction(AddChaItem3, 2952)---------金牛特别行动卡
--	MisCancelAction(ClearMission, 1153)
--	MisBeginBagNeed(1)
--	
--	MisNeed(MIS_NEED_DESP, "航行到埃弗里补给站找海港指挥·布纽(2042,635)聊聊")
--	MisHelpTalk("<t>快去吧,你只有15分钟哦")
--
--	MisResultCondition(AlwaysFailure)	
--
--	--------------------------------------特别任务----海港指挥·布纽
--
--	DefineMission(5669, "血溅金牛之特别行动", 1153, COMPLETE_SHOW )
--	
--	MisBeginCondition(AlwaysFailure )
--
--	MisResultTalk("<t>还不错嘛.不会让你后悔的.")
--	MisResultCondition(HasMission, 1153)
--	MisResultCondition(NoRecord,1153)
--	MisResultAction(AddChaItem5, 2952)----特别行动卡
--	MisResultAction(ClearMission, 1153)
--	MisResultAction(SetRecord,  1153 )
--	MisResultAction(GiveItem, 3035, 1, 4)------------金牛船长酷装宝箱
--	MisResultBagNeed(1)
	
---------------------------------------------------特别任务	--------芭芭拉
--	DefineMission (5673, "血溅金牛之特别行动", 1159)
--	
--	MisBeginTalk("<t>这个任务是金牛宫特别行动,你可以不参加,当然不参加的没有礼物拿.<b10分钟内航行到弗里补给站找海港指挥·布纽(2042,6351)>")
--
--	MisBeginCondition(NoMission,1159)
--	MisBeginCondition(NoRecord,1159)
--	MisBeginCondition(HasRecord,1112)
--	MisBeginCondition(HasRecord,1120)
--	MisBeginCondition(HasRecord,1121)
--	MisBeginCondition(HasRecord,1122)
--	MisBeginCondition(HasRecord,1123)
--	MisBeginCondition(HasRecord,1124)
--	MisBeginCondition(HasRecord,1150)
--	MisBeginCondition(HasRecord,1119)
--	MisBeginAction(AddMission,1159)
--	MisBeginAction(AddChaItem3, 2952)---------金牛特别行动卡
--	MisCancelAction(ClearMission, 1159)
--	MisBeginBagNeed(1)
--	
--	MisNeed(MIS_NEED_DESP, "航行到埃弗里补给站找海港指挥·布纽(2042,635)聊聊")
--	MisHelpTalk("<t>快去吧,你只有15分钟哦")
--
--	MisResultCondition(AlwaysFailure)	
--
--	--------------------------------------特别任务----海港指挥·布纽
--
--	DefineMission(5674, "血溅金牛之特别行动", 1159, COMPLETE_SHOW )
--	
--	MisBeginCondition(AlwaysFailure )
--
--	MisResultTalk("<t>还不错嘛.不会让你后悔的.")
--	MisResultCondition(HasMission, 1159)
--	MisResultCondition(NoRecord,1159)
--	MisResultAction(AddChaItem5, 2952)----特别行动卡
--	MisResultAction(ClearMission, 1159)
--	MisResultAction(SetRecord,  1159 )
--	MisResultAction(GiveItem, 3035, 1, 4)------------金牛船长酷装宝箱
--	MisResultBagNeed(1)
--	
-------------------------------------------------特别任务	--------芭芭拉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000770 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000770")
	DefineMission (5675, MISSCRIPT_MISSIONSCRIPT07_LUA_000770, 1160)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000771 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000771")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000771)

	MisBeginCondition(NoMission,1160)
	MisBeginCondition(NoRecord,1160)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(HasRecord,1125)
	MisBeginCondition(HasRecord,1126)
	MisBeginCondition(HasRecord,1127)
	MisBeginCondition(HasRecord,1128)
	MisBeginCondition(HasRecord,1129)
	MisBeginCondition(HasRecord,1150)
	MisBeginCondition(HasRecord,1119)
	MisBeginAction(AddMission,1160)
	MisBeginAction(AddChaItem3, 2952)---------金牛特别行动卡
	MisCancelAction(ClearMission, 1160)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000772 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000772")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000772)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000773 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000773")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000773)

	MisResultCondition(AlwaysFailure)	

	--------------------------------------特别任务----杰克史派罗

	MISSCRIPT_MISSIONSCRIPT07_LUA_000770 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000770")
	DefineMission(5676, MISSCRIPT_MISSIONSCRIPT07_LUA_000770, 1160, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000774 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000774")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000774)
	MisResultCondition(HasMission, 1160)
	MisResultCondition(NoRecord,1160)
	MisResultAction(AddChaItem5, 2952)----特别行动卡
	MisResultAction(ClearMission, 1160)
	MisResultAction(SetRecord,  1160 )
	MisResultAction(GiveItem, 3035, 1, 4)------------金牛船长酷装宝箱
	MisResultBagNeed(1)
	


-------------------------------------------------金牛之水手过关奖励----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000775 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000775")
	DefineMission (5670, MISSCRIPT_MISSIONSCRIPT07_LUA_000775, 1156)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000776 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000776")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000776)

	MisBeginCondition(NoMission,1156)
	MisBeginCondition(HasRecord,1111)
	MisBeginCondition(HasRecord,1114)
	MisBeginCondition(HasRecord,1115)
	MisBeginCondition(HasRecord,1116)
	MisBeginCondition(HasRecord,1117)
	MisBeginCondition(HasRecord,1118)
	MisBeginCondition(HasRecord,1150)
	MisBeginCondition(HasRecord,1119)
	MisBeginCondition(NoRecord,1156)
	MisBeginAction(AddMission,1156)  
	MisBeginAction(AddTrigger, 11561, TE_GETITEM, 3028, 1 )		
	MisBeginAction(AddTrigger, 11562, TE_GETITEM, 3029, 1 )		
	MisBeginAction(AddTrigger, 11563, TE_GETITEM, 3030, 1 )		
 	MisBeginAction(AddTrigger, 11564, TE_GETITEM, 3031, 1 )		
	MisBeginAction(AddTrigger, 11565, TE_GETITEM, 3032, 1 )		
	MisBeginAction(AddTrigger, 11566, TE_GETITEM, 3033, 1 )		
	MisBeginAction(AddTrigger, 11567, TE_GETITEM, 3034, 1 )	
	MisCancelAction(ClearMission, 1156)						                                     
	
	MisNeed(MIS_NEED_ITEM, 3028, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 3029, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 3030, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 3031, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 3032, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 3033, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 3034, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000778 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000778")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000778)

	MisResultCondition(HasMission, 1156)
	MisResultCondition(NoRecord,1156)
	MisResultCondition(HasItem, 3028, 1 )
	MisResultCondition(HasItem, 3029, 1 )
	MisResultCondition(HasItem, 3030, 1 )
	MisResultCondition(HasItem, 3031, 1 )
	MisResultCondition(HasItem, 3032, 1 )
	MisResultCondition(HasItem, 3033, 1 )
	MisResultCondition(HasItem, 3034, 1 )

	MisResultAction(TakeItem, 3028, 1 )
	MisResultAction(TakeItem, 3029, 1 )
	MisResultAction(TakeItem, 3030, 1 )
	MisResultAction(TakeItem, 3031, 1 )
	MisResultAction(TakeItem, 3032, 1 )
	MisResultAction(TakeItem, 3033, 1 )
	MisResultAction(TakeItem, 3034, 1 )

	MisResultAction(ClearMission, 1156)
	MisResultAction(SetRecord,  1156 )
	MisResultAction(GiveItem, 3026, 1, 4)
	MisResultAction(GiveItem, 3027, 1, 4)
	MisResultAction(GiveItem, 0227, 10, 4)
	MisResultAction(AddMoney,100000,100000)
	MisResultAction(JINNiuSS)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3028)	
	TriggerAction( 1, AddNextFlag, 1156, 10, 1 )
	RegCurTrigger( 11561 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3029)	
	TriggerAction( 1, AddNextFlag, 1156, 20, 1 )
	RegCurTrigger( 11562 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3030)	
	TriggerAction( 1, AddNextFlag, 1156, 30, 1 )
	RegCurTrigger( 11563 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3031)	
	TriggerAction( 1, AddNextFlag, 1156, 40, 1 )
	RegCurTrigger( 11564 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3032)	
	TriggerAction( 1, AddNextFlag, 1156, 50, 1 )
	RegCurTrigger( 11565 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3033)	
	TriggerAction( 1, AddNextFlag, 1156, 60, 1 )
	RegCurTrigger( 11566 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3034)	
	TriggerAction( 1, AddNextFlag, 1156, 70, 1 )
	RegCurTrigger( 11567 )
----------------------------------------------金牛之海盗过关奖励----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000779 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000779")
	DefineMission (5671, MISSCRIPT_MISSIONSCRIPT07_LUA_000779, 1157)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000776 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000776")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000776)

	MisBeginCondition(NoMission,1157)
	MisBeginCondition(HasRecord,1112)
	MisBeginCondition(HasRecord,1120)
	MisBeginCondition(HasRecord,1121)
	MisBeginCondition(HasRecord,1122)
	MisBeginCondition(HasRecord,1123)
	MisBeginCondition(HasRecord,1124)
	MisBeginCondition(HasRecord,1150)
	MisBeginCondition(HasRecord,1119)
	MisBeginCondition(NoRecord,1157)
	MisBeginAction(AddMission,1157)
	MisBeginAction(AddTrigger, 11571, TE_GETITEM, 3028, 1 )		
	MisBeginAction(AddTrigger, 11572, TE_GETITEM, 3029, 1 )		
	MisBeginAction(AddTrigger, 11573, TE_GETITEM, 3030, 1 )		
 	MisBeginAction(AddTrigger, 11574, TE_GETITEM, 3031, 1 )		
	MisBeginAction(AddTrigger, 11575, TE_GETITEM, 3032, 1 )		
	MisBeginAction(AddTrigger, 11576, TE_GETITEM, 3033, 1 )		
	MisBeginAction(AddTrigger, 11577, TE_GETITEM, 3034, 1 )		
	MisCancelAction(ClearMission, 1157)						                                     
	
	MisNeed(MIS_NEED_ITEM, 3028, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 3029, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 3030, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 3031, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 3032, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 3033, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 3034, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000778 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000778")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000778)

	MisResultCondition(HasMission, 1157)
	MisResultCondition(NoRecord,1157)
	MisResultCondition(HasItem, 3028, 1 )
	MisResultCondition(HasItem, 3029, 1 )
	MisResultCondition(HasItem, 3030, 1 )
	MisResultCondition(HasItem, 3031, 1 )
	MisResultCondition(HasItem, 3032, 1 )
	MisResultCondition(HasItem, 3033, 1 )
	MisResultCondition(HasItem, 3034, 1 )

	MisResultAction(TakeItem, 3028, 1 )
	MisResultAction(TakeItem, 3029, 1 )
	MisResultAction(TakeItem, 3030, 1 )
	MisResultAction(TakeItem, 3031, 1 )
	MisResultAction(TakeItem, 3032, 1 )
	MisResultAction(TakeItem, 3033, 1 )
	MisResultAction(TakeItem, 3034, 1 )

	MisResultAction(ClearMission, 1157)
	MisResultAction(SetRecord,  1157 )
	MisResultAction(GiveItem, 3026, 1, 4)
	MisResultAction(GiveItem, 3027, 1, 4)
	MisResultAction(GiveItem, 0227, 20, 4)
	MisResultAction(AddMoney,200000,200000)
	MisResultAction(JINNiuHD)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3028)	
	TriggerAction( 1, AddNextFlag, 1157, 10, 1 )
	RegCurTrigger( 11571 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3029)	
	TriggerAction( 1, AddNextFlag, 1157, 20, 1 )
	RegCurTrigger( 11572 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3030)	
	TriggerAction( 1, AddNextFlag, 1157, 30, 1 )
	RegCurTrigger( 11573 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3031)	
	TriggerAction( 1, AddNextFlag, 1157, 40, 1 )
	RegCurTrigger( 11574 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3032)	
	TriggerAction( 1, AddNextFlag, 1157, 50, 1 )
	RegCurTrigger( 11575 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3033)	
	TriggerAction( 1, AddNextFlag, 1157, 60, 1 )
	RegCurTrigger( 11576 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3034)	
	TriggerAction( 1, AddNextFlag, 1157, 70, 1 )
	RegCurTrigger( 11577 )

	---------------------------------------------金牛之船长过关奖励----------芭芭拉	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000780 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000780")
	DefineMission (5672, MISSCRIPT_MISSIONSCRIPT07_LUA_000780, 1158)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000776 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000776")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000776)

	MisBeginCondition(NoMission,1158)
	MisBeginCondition(HasRecord,1113)
	MisBeginCondition(HasRecord,1125)
	MisBeginCondition(HasRecord,1126)
	MisBeginCondition(HasRecord,1127)
	MisBeginCondition(HasRecord,1128)
	MisBeginCondition(HasRecord,1129)
	MisBeginCondition(HasRecord,1150)
	MisBeginCondition(HasRecord,1119)
	MisBeginCondition(NoRecord,1158)
	MisBeginAction(AddMission,1158)   
	MisBeginAction(AddTrigger, 11581, TE_GETITEM, 3028, 1 )		
	MisBeginAction(AddTrigger, 11582, TE_GETITEM, 3029, 1 )		
	MisBeginAction(AddTrigger, 11583, TE_GETITEM, 3030, 1 )		
 	MisBeginAction(AddTrigger, 11584, TE_GETITEM, 3031, 1 )		
	MisBeginAction(AddTrigger, 11585, TE_GETITEM, 3032, 1 )		
	MisBeginAction(AddTrigger, 11586, TE_GETITEM, 3033, 1 )		
	MisBeginAction(AddTrigger, 11587, TE_GETITEM, 3034, 1 )	
	MisCancelAction(ClearMission, 1158)						                                     
	
	MisNeed(MIS_NEED_ITEM, 3028, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 3029, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 3030, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 3031, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 3032, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 3033, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 3034, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000778 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000778")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000778)

	MisResultCondition(HasMission, 1158)
	MisResultCondition(NoRecord,1158)
	MisResultCondition(HasItem, 3028, 1 )
	MisResultCondition(HasItem, 3029, 1 )
	MisResultCondition(HasItem, 3030, 1 )
	MisResultCondition(HasItem, 3031, 1 )
	MisResultCondition(HasItem, 3032, 1 )
	MisResultCondition(HasItem, 3033, 1 )
	MisResultCondition(HasItem, 3034, 1 )

	MisResultAction(TakeItem, 3028, 1 )
	MisResultAction(TakeItem, 3029, 1 )
	MisResultAction(TakeItem, 3030, 1 )
	MisResultAction(TakeItem, 3031, 1 )
	MisResultAction(TakeItem, 3032, 1 )
	MisResultAction(TakeItem, 3033, 1 )
	MisResultAction(TakeItem, 3034, 1 )

	MisResultAction(ClearMission, 1158)
	MisResultAction(SetRecord,  1158 )
	MisResultAction(GiveItem, 3026, 1, 4)
	MisResultAction(GiveItem, 3027, 1, 4)
	MisResultAction(GiveItem, 0227, 30, 4)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(JINNiuCZ)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3028)	
	TriggerAction( 1, AddNextFlag, 1158, 10, 1 )
	RegCurTrigger( 11581 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3029)	
	TriggerAction( 1, AddNextFlag, 1158, 20, 1 )
	RegCurTrigger( 11582 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3030)	
	TriggerAction( 1, AddNextFlag, 1158, 30, 1 )
	RegCurTrigger( 11583 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3031)	
	TriggerAction( 1, AddNextFlag, 1158, 40, 1 )
	RegCurTrigger( 11584 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3032)	
	TriggerAction( 1, AddNextFlag, 1158, 50, 1 )
	RegCurTrigger( 11585 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3033)	
	TriggerAction( 1, AddNextFlag, 1158, 60, 1 )
	RegCurTrigger( 11586 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3034)	
	TriggerAction( 1, AddNextFlag, 1158, 70, 1 )
	RegCurTrigger( 11587 )

--	-----------------------------------------------------猪光宝气-----------马来西亚
--
--       DefineMission(6126,"猪光宝气",1452)
--
--	MisBeginTalk("<t>最近我再研究一道新菜色需要些特别的材料,我猜你一定愿意帮忙,因为回报够好哦.")
--	MisBeginCondition(NoMission, 1452)
--	MisBeginCondition(NoRecord,1452)
--	MisBeginAction(AddMission,1452)
--	MisBeginAction(AddTrigger, 14521, TE_GETITEM, 4325, 5)
--	MisBeginAction(AddTrigger, 14522, TE_GETITEM, 1680, 5)
--	MisBeginAction(AddTrigger, 14523, TE_GETITEM, 4433, 5)
--	MisBeginAction(AddTrigger, 14524, TE_GETITEM, 4357, 5)
--	MisBeginAction(AddTrigger, 14525, TE_GETITEM, 4461, 40)
--	MisBeginAction(AddTrigger, 14526, TE_GETITEM, 4462, 40)
--
--
--	MisCancelAction(ClearMission, 1452)
--
--	MisNeed(MIS_NEED_DESP, "收集到雪白猪尾 5个(深蓝1179,371),粉红猪尾 5个(加纳1950,2563),豪猪短尾 5个(加纳1384,3065),粗糙的猪尾 5个(加纳910,2971),变异猪蹄 40 深蓝1455,560)及 强壮猪蹄 40(深蓝2266,590).")
--	MisNeed(MIS_NEED_ITEM, 4325, 5, 10, 5)
--	MisNeed(MIS_NEED_ITEM, 1680, 5, 15, 5)
--	MisNeed(MIS_NEED_ITEM, 4433, 5, 20, 5)
--	MisNeed(MIS_NEED_ITEM, 4357, 5, 25, 5)
--	MisNeed(MIS_NEED_ITEM, 4461, 40, 30, 40)
--	MisNeed(MIS_NEED_ITEM, 4462, 40, 70, 40)
--
--	
--	
--	MisHelpTalk("<t>及早回来复命,我会给您最好的犒赏")
--	MisResultTalk("<t>这个神秘的幸运猪宝箱就是我要送给你的奖赏了,我有很多事需要帮忙,你可以经常过来找我.")
--
--	MisResultCondition(HasMission, 1452)
--	MisResultCondition(NoRecord,1452)
--	MisResultCondition(HasItem, 4325, 5)
--	MisResultCondition(HasItem, 1680, 5)
--	MisResultCondition(HasItem, 4433, 5)
--	MisResultCondition(HasItem, 4357, 5)
--	MisResultCondition(HasItem, 4461, 40)
--	MisResultCondition(HasItem, 4462, 40)
--
--	
--	
--	MisResultAction(TakeItem, 4325, 5 )
--	MisResultAction(TakeItem, 1680, 5 )
--	MisResultAction(TakeItem, 4433, 5 )
--	MisResultAction(TakeItem, 4357, 5 )
--	MisResultAction(TakeItem, 4461, 40 )
--	MisResultAction(TakeItem, 4462, 40 )
--
--	
--	
--	MisResultAction(GiveItem, 2909,1,4)------------给幸运猪宝箱
--	MisResultAction(ClearMission, 1452)
--	MisResultAction(SetRecord, 1452)
--	MisResultAction(ClearRecord, 1452)---------------可以反复接
--	MisResultBagNeed(1)
--	
--
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4325)	
--	TriggerAction( 1, AddNextFlag, 1452, 10, 5 )
--	RegCurTrigger( 14521 )
--
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 1680)	
--	TriggerAction( 1, AddNextFlag, 1452, 15, 5 )
--	RegCurTrigger( 14522 )
--	
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4433)	
--	TriggerAction( 1, AddNextFlag, 1452, 20, 5 )
--	RegCurTrigger( 14523 )
--	
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4357)	
--	TriggerAction( 1, AddNextFlag, 1452, 25, 5 )
--	RegCurTrigger( 14524 )
--	
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4461)	
--	TriggerAction( 1, AddNextFlag, 1452, 30, 40 )
--	RegCurTrigger( 14525 )
--	
--	InitTrigger()
--	TriggerCondition( 1, IsItem, 4462)	
--	TriggerAction( 1, AddNextFlag, 1452, 70, 40 )
--	RegCurTrigger( 14526 )

-------------------------------------------------乱斗英雄----------海盗·德克	--------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000781 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000781")
	DefineMission (5673, MISSCRIPT_MISSIONSCRIPT07_LUA_000781, 1163)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000782 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000782")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000782)

	MisBeginCondition(NoMission,1163)
	MisBeginCondition(HasRecord,1159)
	MisBeginCondition(NoRecord,1163)
	MisBeginAction(AddMission,1163)
	MisCancelAction(ClearMission, 1163)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000783 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000783")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000783)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000784")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000785 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000785")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000785)

	MisResultCondition(HasMission, 1163)
	MisResultCondition(NoRecord,1163)
	MisResultCondition(HasFightingPoint,5 )
	MisResultAction(TakeFightingPoint, 5 )
	MisResultAction(ClearMission, 1163)
	MisResultAction(SetRecord,  1163 )
	MisResultAction(GiveItem, 1874, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------海盗·德克	--------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000786 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000786")
	DefineMission (5674, MISSCRIPT_MISSIONSCRIPT07_LUA_000786, 1164)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000787 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000787")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000787)

	MisBeginCondition(NoMission,1164)
	MisBeginCondition(HasRecord,1159)
	MisBeginCondition(NoRecord,1164)
	MisBeginAction(AddMission,1164)
	MisCancelAction(ClearMission, 1164)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000788 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000788")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000788)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000789 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000789")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000789)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000790")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000790)

	MisResultCondition(HasMission, 1164)
	MisResultCondition(NoRecord,1164)
	MisResultCondition(HasCredit,2000 )
	MisResultAction(TakeCredit, 2000 )
	MisResultAction(ClearMission, 1164)
	MisResultAction(SetRecord,  1164 )
	MisResultAction(GiveItem, 1875, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------海盗·德克	---------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000791 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000791")
	DefineMission (5741, MISSCRIPT_MISSIONSCRIPT07_LUA_000791, 1165)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000792 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000792")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000792)

	MisBeginCondition(NoMission,1165)
	MisBeginCondition(HasRecord,1159)
	MisBeginCondition(NoRecord,1165)
	MisBeginAction(AddMission,1165)
	MisCancelAction(ClearMission, 1165)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000673 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000673")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000673)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000793 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000793")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000793)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000794 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000794")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000794)

	MisResultCondition(HasMission, 1165)
	MisResultCondition(NoRecord,1165)
	MisResultCondition(LvCheck, ">", 59 )
	MisResultAction(ClearMission, 1165)
	MisResultAction(SetRecord,  1165 )
	MisResultAction(GiveItem, 1876, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------海盗·德克	----------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000795 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000795")
	DefineMission (5742, MISSCRIPT_MISSIONSCRIPT07_LUA_000795, 1166)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000796 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000796")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000796)

	MisBeginCondition(NoMission,1166)
	MisBeginCondition(HasRecord,1159)
	MisBeginCondition(NoRecord,1166)
	MisBeginAction(AddMission,1166)
	MisCancelAction(ClearMission, 1166)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000676 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000676")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000676)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000797)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000798)

	MisResultCondition(HasMission, 1166)
	MisResultCondition(NoRecord,1166)
	MisResultCondition(HasHonorPoint,500 )
	MisResultAction(TakeHonorPoint, 500 )
	MisResultAction(ClearMission, 1166)
	MisResultAction(SetRecord,  1166 )
	MisResultAction(GiveItem, 1877, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------海盗·德克	------------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000799 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000799")
	DefineMission (5677, MISSCRIPT_MISSIONSCRIPT07_LUA_000799, 1167)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000800 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000800")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000800)

	MisBeginCondition(NoMission,1167)
	MisBeginCondition(HasRecord,1159)
	MisBeginCondition(NoRecord,1167)
	MisBeginAction(AddMission,1167)
	MisBeginAction(AddTrigger, 11671, TE_GETITEM, 1346, 10 )---------------血腥的蝌蚪血10
	MisBeginAction(AddTrigger, 11672, TE_GETITEM, 4526, 10 )--------------- 生锈的长矛10
	MisBeginAction(AddTrigger, 11673, TE_GETITEM, 1608, 10 )-------------动物皮毛10--------
	MisBeginAction(AddTrigger, 11674, TE_GETITEM, 4495, 1 )--------------山贼腰带1个
	MisBeginAction(AddTrigger, 11675, TE_GETITEM, 1612, 20 )--------------锋利的角20个
	MisBeginAction(AddTrigger, 11676, TE_GETITEM, 1140, 20 )-------------船只喷射器LV1 20个
	MisBeginAction(AddTrigger, 11677, TE_GETITEM, 3094, 5 )--------------努力增幅器5个
	MisCancelAction(ClearMission, 1167)
	

	MisNeed(MIS_NEED_ITEM, 1346, 10, 1, 10 )
	MisNeed(MIS_NEED_ITEM, 4526, 10, 11, 10 )
	MisNeed(MIS_NEED_ITEM, 1608, 10, 21, 10 )
	MisNeed(MIS_NEED_ITEM, 4495, 1, 31, 1 )
	MisNeed(MIS_NEED_ITEM, 1612, 20, 32, 20 )
	MisNeed(MIS_NEED_ITEM, 1140, 20, 52, 20 )
	MisNeed(MIS_NEED_ITEM, 3094, 5, 72, 5 )
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000801 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000801")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000801)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000802 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000802")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000802)

	MisResultCondition(HasMission, 1167)
	MisResultCondition(NoRecord,1167)
	MisResultCondition(HasItem, 1346, 10 )
	MisResultCondition(HasItem, 4526, 10 )
	MisResultCondition(HasItem, 1608, 10 )
	MisResultCondition(HasItem, 4495, 1 )
	MisResultCondition(HasItem, 1612, 20 )
	MisResultCondition(HasItem, 1140, 20 )
	MisResultCondition(HasItem, 3094, 5 )


	MisResultAction(TakeItem, 1346, 10 )
	MisResultAction(TakeItem, 4526, 10 )
	MisResultAction(TakeItem, 1608, 10 )
	MisResultAction(TakeItem, 4495, 1)
	MisResultAction(TakeItem, 1612, 20 )
	MisResultAction(TakeItem, 1140, 20 )
	MisResultAction(TakeItem, 3094, 5 )
	
	MisResultAction(ClearMission, 1167)
	MisResultAction(SetRecord,  1167 )
	MisResultAction(GiveItem, 1878, 1, 4)
	MisResultAction(GiveItem, 1882, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1346)	
	TriggerAction( 1, AddNextFlag, 1167, 1, 10 )
	RegCurTrigger( 11671 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4526)	
	TriggerAction( 1, AddNextFlag, 1167, 11, 10 )
	RegCurTrigger( 11672 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1608)	
	TriggerAction( 1, AddNextFlag, 1167, 21, 10 )
	RegCurTrigger( 11673 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4495)	
	TriggerAction( 1, AddNextFlag, 1167, 31, 1 )
	RegCurTrigger( 11674 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1612)	
	TriggerAction( 1, AddNextFlag, 1167, 36, 20 )
	RegCurTrigger( 11675 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1140)	
	TriggerAction( 1, AddNextFlag, 1167, 37, 20 )
	RegCurTrigger( 11676 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3094)	
	TriggerAction( 1, AddNextFlag, 1167, 87, 5 )
	RegCurTrigger( 11677 )


	----------------------------------------------------------双子末日----------海盗·德克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000803 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000803")
	DefineMission( 5678, MISSCRIPT_MISSIONSCRIPT07_LUA_000803, 1168 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000804 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000804")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000804)
				
	MisBeginCondition(NoMission, 1168)
	MisBeginCondition(HasRecord,1162)
	MisBeginCondition(NoRecord,1168)
	MisBeginAction(AddMission,1168)
	MisBeginAction(AddTrigger, 11681, TE_KILL, 1039, 1)---双子守护者
	
	MisCancelAction(ClearMission, 1168)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000805 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000805")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000805)
	MisNeed(MIS_NEED_KILL, 1039,1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000806 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000806")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000806)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000807 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000807")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000807)
	MisResultCondition(HasMission,  1168)
	MisResultCondition(HasFlag, 1168, 10)
	MisResultCondition(NoRecord , 1168)
	MisResultAction(GiveItem, 1880, 1, 4 )
	MisResultAction(ClearMission,  1168)
	MisResultAction(SetRecord,  1168 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1039)	
	TriggerAction( 1, AddNextFlag, 1168, 10, 1 )
	RegCurTrigger( 11681 )

-------------------------------------------------乱斗英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000781 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000781")
	DefineMission (5679, MISSCRIPT_MISSIONSCRIPT07_LUA_000781, 1169)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000782 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000782")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000782)

	MisBeginCondition(NoMission,1169)
	MisBeginCondition(HasRecord,1204)
	MisBeginCondition(NoRecord,1169)
	MisBeginAction(AddMission,1169)
	MisCancelAction(ClearMission, 1169)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000808 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000808")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000808)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000784")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000785 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000785")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000785)

	MisResultCondition(HasMission, 1169)
	MisResultCondition(NoRecord,1169)
	MisResultCondition(HasFightingPoint,10 )
	MisResultAction(TakeFightingPoint, 10 )
	MisResultAction(ClearMission, 1169)
	MisResultAction(SetRecord,  1169 )
	MisResultAction(GiveItem, 1874, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000786 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000786")
	DefineMission (5680, MISSCRIPT_MISSIONSCRIPT07_LUA_000786, 1170)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000809 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000809")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000809)

	MisBeginCondition(NoMission,1170)
	MisBeginCondition(HasRecord,1204)
	MisBeginCondition(NoRecord,1170)
	MisBeginAction(AddMission,1170)
	MisCancelAction(ClearMission, 1170)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000682 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000682")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000682)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000810 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000810")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000810)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000790")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000790)

	MisResultCondition(HasMission, 1170)
	MisResultCondition(NoRecord,1170)
	MisResultCondition(HasCredit,5000 )
	MisResultAction(TakeCredit,5000  )
	MisResultAction(ClearMission, 1170)
	MisResultAction(SetRecord,  1170 )
	MisResultAction(GiveItem, 1875, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000791 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000791")
	DefineMission (5681, MISSCRIPT_MISSIONSCRIPT07_LUA_000791, 1171)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000792 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000792")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000792)

	MisBeginCondition(NoMission,1171)
	MisBeginCondition(HasRecord,1204)
	MisBeginCondition(NoRecord,1171)
	MisBeginAction(AddMission,1171)
	MisCancelAction(ClearMission, 1171)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000684 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000684")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000684)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000811 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000811")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000811)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000794 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000794")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000794)

	MisResultCondition(HasMission, 1171)
	MisResultCondition(NoRecord,1171)
	MisResultCondition(LvCheck, ">", 64 )
	MisResultAction(ClearMission, 1171)
	MisResultAction(SetRecord,  1171 )
	MisResultAction(GiveItem, 1876, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000795 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000795")
	DefineMission (5682, MISSCRIPT_MISSIONSCRIPT07_LUA_000795, 1172)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000812 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000812")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000812)

	MisBeginCondition(NoMission,1172)
	MisBeginCondition(HasRecord,1204)
	MisBeginCondition(NoRecord,1172)
	MisBeginAction(AddMission,1172)
	MisCancelAction(ClearMission, 1172)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000813 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000813")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000813)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000797)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000798)

	MisResultCondition(HasMission, 1172)
	MisResultCondition(NoRecord,1172)
	MisResultCondition(HasHonorPoint,700 )
	MisResultAction(TakeHonorPoint, 700 )
	MisResultAction(ClearMission, 1172)
	MisResultAction(SetRecord,  1172 )
	MisResultAction(GiveItem, 1877, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000799 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000799")
	DefineMission (5683, MISSCRIPT_MISSIONSCRIPT07_LUA_000799, 1173)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000800 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000800")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000800)

	MisBeginCondition(NoMission,1173)
	MisBeginCondition(HasRecord,1204)
	MisBeginCondition(NoRecord,1173)
	MisBeginAction(AddMission,1173)
	MisBeginAction(AddTrigger, 11731, TE_GETITEM, 1346, 15 )-------------------血腥的蝌蚪血15
	MisBeginAction(AddTrigger, 11732, TE_GETITEM, 4526, 15 )-------------------生锈的长矛15          
	MisBeginAction(AddTrigger, 11733, TE_GETITEM, 1608, 15 )-----------------动物皮毛15               
	MisBeginAction(AddTrigger, 11734, TE_GETITEM, 4495, 2 )----------------山贼腰带2个               
	MisBeginAction(AddTrigger, 11735, TE_GETITEM, 1612, 30)------------------锋利的角30个            
	MisBeginAction(AddTrigger, 11736, TE_GETITEM, 2724, 20 )-----------------船只喷射器LV2 20个                  
	MisBeginAction(AddTrigger, 11737, TE_GETITEM, 3094, 10 )------------------努力增幅器10个          
	MisCancelAction(ClearMission, 1173)
	

	MisNeed(MIS_NEED_ITEM, 1346, 15, 1, 15 )
	MisNeed(MIS_NEED_ITEM, 4526, 15, 16, 15 )
	MisNeed(MIS_NEED_ITEM, 1608, 15, 31, 15 )
	MisNeed(MIS_NEED_ITEM, 4495,  2, 46, 2 )
	MisNeed(MIS_NEED_ITEM, 1612, 30, 48, 30 )
	MisNeed(MIS_NEED_ITEM, 2724, 20, 78, 20 )
	MisNeed(MIS_NEED_ITEM, 3094, 10, 98, 10 )
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000801 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000801")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000801)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000814 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000814")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000814)

	MisResultCondition(HasMission, 1173)
	MisResultCondition(NoRecord,1173)
	MisResultCondition(HasItem, 1346, 15 )
	MisResultCondition(HasItem, 4526, 15 )
	MisResultCondition(HasItem, 1608, 15 )
	MisResultCondition(HasItem, 4495, 2 )
	MisResultCondition(HasItem, 1612, 30 )
	MisResultCondition(HasItem, 2724, 20 )
	MisResultCondition(HasItem, 3094, 10 )


	MisResultAction(TakeItem, 1346, 15 )
	MisResultAction(TakeItem, 4526, 15 )
	MisResultAction(TakeItem, 1608, 15 )
	MisResultAction(TakeItem, 4495, 2 )
	MisResultAction(TakeItem, 1612, 30 )
	MisResultAction(TakeItem, 2724, 20 )
	MisResultAction(TakeItem, 3094, 10 )

	MisResultAction(ClearMission, 1173)
	MisResultAction(SetRecord,  1173 )
	MisResultAction(GiveItem, 1878, 1, 4)
	MisResultAction(GiveItem, 1882, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1346)	
	TriggerAction( 1, AddNextFlag, 1173, 1, 15 )
	RegCurTrigger( 11731 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4526)	
	TriggerAction( 1, AddNextFlag, 1173, 16, 15 )
	RegCurTrigger( 11732 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1608)	
	TriggerAction( 1, AddNextFlag, 1173, 31, 15 )
	RegCurTrigger( 11733 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4495)	
	TriggerAction( 1, AddNextFlag, 1173, 46, 2 )
	RegCurTrigger( 11734 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1612)	
	TriggerAction( 1, AddNextFlag, 1173, 48, 30 )
	RegCurTrigger( 11735 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2724)	
	TriggerAction( 1, AddNextFlag, 1173,78, 20 )
	RegCurTrigger( 11736 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3094)	
	TriggerAction( 1, AddNextFlag, 1173, 98, 10 )
	RegCurTrigger( 11737 )


-------------------------------------------------乱斗英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000781 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000781")
	DefineMission (5684, MISSCRIPT_MISSIONSCRIPT07_LUA_000781, 1174)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000815 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000815")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000815)

	MisBeginCondition(NoMission,1174)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(NoRecord,1174)
	MisBeginAction(AddMission,1174)
	MisCancelAction(ClearMission, 1174)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000816 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000816")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000816)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000784")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000785 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000785")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000785)

	MisResultCondition(HasMission, 1174)
	MisResultCondition(NoRecord,1174)
	MisResultCondition(HasFightingPoint,15 )
	MisResultAction(TakeFightingPoint, 15 )
	MisResultAction(ClearMission, 1174)
	MisResultAction(SetRecord,  1174 )
	MisResultAction(GiveItem, 1874, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000786 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000786")
	DefineMission (5685, MISSCRIPT_MISSIONSCRIPT07_LUA_000786, 1175)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000809 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000809")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000809)

	MisBeginCondition(NoMission,1175)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(NoRecord,1175)
	MisBeginAction(AddMission,1175)
	MisCancelAction(ClearMission, 1175)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000817 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000817")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000817)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000818 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000818")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000818)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000790")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000790)

	MisResultCondition(HasMission, 1175)
	MisResultCondition(NoRecord,1175)
	MisResultCondition(HasCredit,8000 )
	MisResultAction(TakeCredit, 8000 )
	MisResultAction(ClearMission, 1175)
	MisResultAction(SetRecord,  1175 )
	MisResultAction(GiveItem, 1875, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000791 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000791")
	DefineMission (5686, MISSCRIPT_MISSIONSCRIPT07_LUA_000791, 1176)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000819 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000819")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000819)

	MisBeginCondition(NoMission,1176)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(NoRecord,1176)
	MisBeginAction(AddMission,1176)
	MisCancelAction(ClearMission, 1176)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000820 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000820")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000820)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000821 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000821")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000821)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000794 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000794")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000794)

	MisResultCondition(HasMission, 1176)
	MisResultCondition(NoRecord,1176)
	MisResultCondition(LvCheck, ">", 69 )
	MisResultAction(ClearMission, 1176)
	MisResultAction(SetRecord,  1176 )
	MisResultAction(GiveItem, 1876, 1, 4)
	MisResultBagNeed(1)
	

	-------------------------------------------------荣誉英雄----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000795 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000795")
	DefineMission (5687, MISSCRIPT_MISSIONSCRIPT07_LUA_000795, 1177)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000812 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000812")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000812)

	MisBeginCondition(NoMission,1177)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(NoRecord,1177)
	MisBeginAction(AddMission,1177)
	MisCancelAction(ClearMission, 1177)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000822 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000822")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000822)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000797)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000798)

	MisResultCondition(HasMission, 1177)
	MisResultCondition(NoRecord,1177)
	MisResultCondition(HasHonorPoint,1000 )
	MisResultAction(TakeHonorPoint, 1000 )
	MisResultAction(ClearMission, 1177)
	MisResultAction(SetRecord,  1177 )
	MisResultAction(GiveItem, 1877, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------采集大使----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000799 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000799")
	DefineMission (5688, MISSCRIPT_MISSIONSCRIPT07_LUA_000799, 1178)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000800 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000800")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000800)

	MisBeginCondition(NoMission,1178)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(NoRecord,1178)
	MisBeginAction(AddMission,1178)
	MisBeginAction(AddTrigger, 11781, TE_GETITEM, 1346, 20 )---------------------血腥的蝌蚪血20 
	MisBeginAction(AddTrigger, 11782, TE_GETITEM, 3433, 1 )---------------------费诺符石1个          
	MisBeginAction(AddTrigger, 11783, TE_GETITEM, 4495, 3 )-------------------山贼腰带3个               
	MisBeginAction(AddTrigger, 11784, TE_GETITEM, 1612, 30 )------------------锋利的角30个             
	MisBeginAction(AddTrigger, 11785, TE_GETITEM, 2724, 30 )--------------------船只喷射器LV2 30个             
	MisBeginAction(AddTrigger, 11786, TE_GETITEM, 3094, 30 )-------------------努力增幅器30个                              
	MisCancelAction(ClearMission, 1178)						                                     
	

	MisNeed(MIS_NEED_ITEM, 1346, 20, 1, 20 )
	MisNeed(MIS_NEED_ITEM, 3433, 1, 21, 1 )
	MisNeed(MIS_NEED_ITEM, 4495, 3, 22, 3 )
	MisNeed(MIS_NEED_ITEM, 1612, 30, 25, 30 )
	MisNeed(MIS_NEED_ITEM, 2724, 30, 55, 30)
	MisNeed(MIS_NEED_ITEM, 3094, 30, 85, 30 )


	MISSCRIPT_MISSIONSCRIPT07_LUA_000801 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000801")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000801)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000802 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000802")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000802)

	MisResultCondition(HasMission, 1178)
	MisResultCondition(NoRecord,1178)
	MisResultCondition(HasItem, 1346, 20 )
	MisResultCondition(HasItem, 3433, 1 )
	MisResultCondition(HasItem, 4495, 3 )
	MisResultCondition(HasItem, 1612, 30 )
	MisResultCondition(HasItem, 2724, 30 )
	MisResultCondition(HasItem, 3094, 30 )


	MisResultAction(TakeItem, 1346, 20 )
	MisResultAction(TakeItem, 3433, 1 )
	MisResultAction(TakeItem, 4495, 3 )
	MisResultAction(TakeItem, 1612, 30 )
	MisResultAction(TakeItem, 2724, 30 )
	MisResultAction(TakeItem, 3094, 30 )

	MisResultAction(ClearMission, 1178)
	MisResultAction(SetRecord,  1178 )
	MisResultAction(GiveItem, 1878, 1, 4)
	MisResultAction(GiveItem, 1882, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1346)	
	TriggerAction( 1, AddNextFlag, 1178, 1, 20 )
	RegCurTrigger( 11781 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3433)	
	TriggerAction( 1, AddNextFlag, 1178, 21, 1 )
	RegCurTrigger( 11782 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4495)	
	TriggerAction( 1, AddNextFlag, 1178, 22, 3 )
	RegCurTrigger( 11783 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1612)	
	TriggerAction( 1, AddNextFlag, 1178, 25, 30 )
	RegCurTrigger( 11784 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2724)	
	TriggerAction( 1, AddNextFlag, 1178, 55, 30 )
	RegCurTrigger( 11785 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3094)	
	TriggerAction( 1, AddNextFlag, 1178, 85, 30 )
	RegCurTrigger( 11786 )

	----------------------------------------------------------社交大使----------海盗·德克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000823 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000823")
	DefineMission( 5689, MISSCRIPT_MISSIONSCRIPT07_LUA_000823, 1179 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000824 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000824")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000824)
				
	MisBeginCondition(NoMission, 1179)
	MisBeginCondition(NoRecord,1179)
	MisBeginCondition(HasRecord, 1162)-------------------新的id,最后的id
	MisBeginAction(AddMission,1179)
	MisCancelAction(ClearMission, 1179)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000825 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000825")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000825)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000826 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000826")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000826)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使-----------------护卫·尼松

	MISSCRIPT_MISSIONSCRIPT07_LUA_000268 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000268")
	DefineMission(5690, MISSCRIPT_MISSIONSCRIPT07_LUA_000268, 1179, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000827 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000827")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000827)
	MisResultCondition(NoRecord, 1179)
	MisResultCondition(HasMission,1179)
	MisResultAction(ClearMission,1179)
	MisResultAction(SetRecord, 1179)

	----------------------------------------------------------社交大使2----------护卫·尼松
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission( 5691, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1180 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000828 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000828")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000828)
				
	MisBeginCondition(NoMission, 1180)
	MisBeginCondition(NoRecord,1180)
	MisBeginCondition(HasRecord, 1179)
	MisBeginAction(AddMission,1180)
	MisCancelAction(ClearMission, 1180)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000829 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000829")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000829)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000830 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000830")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000830)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使2-------------巡逻兵·迈克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission(5692, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1180, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000831 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000831")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000831)
	MisResultCondition(NoRecord, 1180)
	MisResultCondition(HasMission,1180)
	MisResultAction(ClearMission,1180)
	MisResultAction(SetRecord, 1180)

	----------------------------------------------------------社交大使3----------巡逻兵·迈克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission( 5693, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1181 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000832 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000832")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000832)
				
	MisBeginCondition(NoMission, 1181)
	MisBeginCondition(NoRecord,1181)
	MisBeginCondition(HasRecord, 1180)
	MisBeginAction(AddMission,1181)
	MisCancelAction(ClearMission, 1181)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000833 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000833")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000833)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000834 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000834")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000834)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使3--------修司
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission(5694, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1181, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000835 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000835")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000835)
	MisResultCondition(NoRecord, 1181)
	MisResultCondition(HasMission,1181)
	MisResultAction(ClearMission,1181)
	MisResultAction(SetRecord, 1181)



	----------------------------------------------------------社交大使4----------修司
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission( 5695, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1182 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000836 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000836")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000836)
				
	MisBeginCondition(NoMission, 1182)
	MisBeginCondition(NoRecord,1182)
	MisBeginCondition(HasRecord, 1181)
	MisBeginAction(AddMission,1182)
	MisCancelAction(ClearMission, 1182)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000837 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000837")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000837)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000838 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000838")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000838)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使4--------巡逻兵·马尔斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission(5696, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1182, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000839 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000839")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000839)
	MisResultCondition(NoRecord, 1182)
	MisResultCondition(HasMission,1182)
	MisResultAction(ClearMission,1182)
	MisResultAction(SetRecord, 1182)


	----------------------------------------------------------社交大使5----------巡逻兵·马尔斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission( 5697, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1183 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000840 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000840")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000840)
				
	MisBeginCondition(NoMission, 1183)
	MisBeginCondition(NoRecord,1183)
	MisBeginCondition(HasRecord, 1182)
	MisBeginAction(AddMission,1183)
	MisCancelAction(ClearMission, 1183)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000841 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000841")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000841)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000842 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000842")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000842)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使5--------俄克琉西斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission(5698, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1183, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000843 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000843")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000843)
	MisResultCondition(NoRecord, 1183)
	MisResultCondition(HasMission,1183)
	MisResultAction(ClearMission,1183)
	MisResultAction(SetRecord, 1183)


	----------------------------------------------------------社交大使6----------俄克琉西斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission( 5699, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1184 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000844 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000844")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000844)
				
	MisBeginCondition(NoMission, 1184)
	MisBeginCondition(NoRecord,1184)
	MisBeginCondition(HasRecord, 1183)
	MisBeginAction(AddMission,1184)
	MisCancelAction(ClearMission, 1184)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000845 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000845")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000845)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000846 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000846")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000846)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使6--------奈奈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission(5700, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1184, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000847 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000847")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000847)
	MisResultCondition(NoRecord, 1184)
	MisResultCondition(HasMission,1184)
	MisResultAction(ClearMission,1184)
	MisResultAction(SetRecord, 1184)


	----------------------------------------------------------社交大使7----------奈奈
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission( 5701, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1185 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000848 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000848")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000848)
				
	MisBeginCondition(NoMission, 1185)
	MisBeginCondition(NoRecord,1185)
	MisBeginCondition(HasRecord, 1184)
	MisBeginAction(AddMission,1185)
	MisCancelAction(ClearMission, 1185)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000849 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000849")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000849)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000850 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000850")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000850)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使7--------古博拉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission(5702, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1185, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000851 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000851")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000851)
	MisResultCondition(NoRecord, 1185)
	MisResultCondition(HasMission,1185)
	MisResultAction(ClearMission,1185)
	MisResultAction(SetRecord, 1185)


	----------------------------------------------------------社交大使8----------古博拉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission( 5703, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1186 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000852 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000852")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000852)
				
	MisBeginCondition(NoMission, 1186)
	MisBeginCondition(NoRecord,1186)
	MisBeginCondition(HasRecord, 1185)
	MisBeginAction(AddMission,1186)
	MisCancelAction(ClearMission, 1186)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000853 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000853")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000853)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000854 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000854")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000854)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使8--------海港指挥·波尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission(5704, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1186, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000855 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000855")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000855)
	MisResultCondition(NoRecord, 1186)
	MisResultCondition(HasMission,1186)
	MisResultAction(ClearMission,1186)
	MisResultAction(SetRecord, 1186)


	----------------------------------------------------------社交大使9----------海港指挥·波尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission( 5705, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1187 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000856 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000856")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000856)
				
	MisBeginCondition(NoMission, 1187)
	MisBeginCondition(NoRecord,1187)
	MisBeginCondition(HasRecord, 1186)
	MisBeginAction(AddMission,1187)
	MisCancelAction(ClearMission, 1187)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000857 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000857")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000857)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000858 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000858")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000858)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使9--------草莓优优
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission(5706, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1187, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000859 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000859")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000859)
	MisResultCondition(NoRecord, 1187)
	MisResultCondition(HasMission,1187)
	MisResultAction(ClearMission,1187)
	MisResultAction(SetRecord, 1187)

	----------------------------------------------------------社交大使10----------草莓优优
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission( 5707, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1188 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000860 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000860")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000860)
				
	MisBeginCondition(NoMission, 1188)
	MisBeginCondition(NoRecord,1188)
	MisBeginCondition(HasRecord, 1187)
	MisBeginAction(AddMission,1188)
	MisCancelAction(ClearMission, 1188)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000861 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000861")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000861)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000862 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000862")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000862)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使10--------瓦萨法尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission(5708, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1188, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000863 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000863")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000863)
	MisResultCondition(NoRecord, 1188)
	MisResultCondition(HasMission,1188)
	MisResultAction(ClearMission,1188)
	MisResultAction(SetRecord, 1188)

	----------------------------------------------------------社交大使11----------瓦萨法尔
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission( 5709, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1189 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000864 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000864")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000864)
				
	MisBeginCondition(NoMission, 1189)
	MisBeginCondition(NoRecord,1189)
	MisBeginCondition(HasRecord, 1188)
	MisBeginAction(AddMission,1189)
	MisCancelAction(ClearMission, 1189)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000865 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000865")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000865)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000866 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000866")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000866)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使11--------交易员·米索亚斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission(5710, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1189, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000867 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000867")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000867)
	MisResultCondition(NoRecord, 1189)
	MisResultCondition(HasMission,1189)
	MisResultAction(ClearMission,1189)
	MisResultAction(SetRecord, 1189)

	----------------------------------------------------------社交大使12----------交易员·米索亚斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission( 5711, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1190 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000868 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000868")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000868)
				
	MisBeginCondition(NoMission, 1190)
	MisBeginCondition(NoRecord,1190)
	MisBeginCondition(HasRecord, 1189)
	MisBeginAction(AddMission,1190)
	MisCancelAction(ClearMission, 1190)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000869 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000869")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000869)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000870 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000870")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000870)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使12--------饰品商人·瑞恩
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission(5712, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1190, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000871 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000871")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000871)
	MisResultCondition(NoRecord, 1190)
	MisResultCondition(HasMission,1190)
	MisResultAction(ClearMission,1190)
	MisResultAction(SetRecord, 1190)


	----------------------------------------------------------社交大使13----------饰品商人·瑞恩
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission( 5713, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1191 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000872 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000872")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000872)
				
	MisBeginCondition(NoMission, 1191)
	MisBeginCondition(NoRecord,1191)
	MisBeginCondition(HasRecord, 1190)
	MisBeginAction(AddMission,1191)
	MisCancelAction(ClearMission, 1191)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000873 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000873")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000873)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000874 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000874")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000874)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使13--------卡休·碎石
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission(5714, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1191, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000875 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000875")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000875)
	MisResultCondition(NoRecord, 1191)
	MisResultCondition(HasMission,1191)
	MisResultAction(ClearMission,1191)
	MisResultAction(SetRecord, 1191)

	----------------------------------------------------------社交大使14----------卡休·碎石
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission( 5715, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1192 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000876 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000876")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000876)
				
	MisBeginCondition(NoMission, 1192)
	MisBeginCondition(NoRecord,1192)
	MisBeginCondition(HasRecord, 1191)
	MisBeginAction(AddMission,1192)
	MisCancelAction(ClearMission, 1192)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000706 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000706")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000706)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000877 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000877")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000877)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使14--------交易员·尤卡        
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission(5716, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1192, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000878 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000878")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000878)
	MisResultCondition(NoRecord, 1192)
	MisResultCondition(HasMission,1192)
	MisResultAction(ClearMission,1192)
	MisResultAction(SetRecord, 1192)

	----------------------------------------------------------社交大使15----------交易员·尤卡
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission( 5717, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1193 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000879 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000879")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000879)
				
	MisBeginCondition(NoMission, 1193)
	MisBeginCondition(NoRecord,1193)
	MisBeginCondition(HasRecord, 1192)
	MisBeginAction(AddMission,1193)
	MisCancelAction(ClearMission, 1193)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000880 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000880")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000880)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000881 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000881")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000881)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使15-------- 尤塔里尼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission(5718, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1193, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000882 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000882")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000882)
	MisResultCondition(NoRecord, 1193)
	MisResultCondition(HasMission,1193)
	MisResultAction(ClearMission,1193)
	MisResultAction(SetRecord, 1193)


	----------------------------------------------------------社交大使16----------尤塔里尼
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission( 5719, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1194 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000883 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000883")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000883)
				
	MisBeginCondition(NoMission, 1194)
	MisBeginCondition(NoRecord,1194)
	MisBeginCondition(HasRecord, 1193)
	MisBeginAction(AddMission,1194)
	MisCancelAction(ClearMission, 1194)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000884 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000884")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000884)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000885 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000885")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000885)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使16-------- 打包人·乎勒达
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission(5720, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1194, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000886 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000886")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000886)
	MisResultCondition(NoRecord, 1194)
	MisResultCondition(HasMission,1194)
	MisResultAction(ClearMission,1194)
	MisResultAction(SetRecord, 1194)


	----------------------------------------------------------社交大使17----------打包人·乎勒达
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission( 5721, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1195 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000887 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000887")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000887)
				
	MisBeginCondition(NoMission, 1195)
	MisBeginCondition(NoRecord,1195)
	MisBeginCondition(HasRecord, 1194)
	MisBeginAction(AddMission,1195)
	MisCancelAction(ClearMission, 1195)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000888 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000888")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000888)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000889 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000889")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000889)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使17-------- 米尔米莉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission(5722, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1195, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000890 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000890")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000890)
	MisResultCondition(NoRecord, 1195)
	MisResultCondition(HasMission,1195)
	MisResultAction(ClearMission,1195)
	MisResultAction(SetRecord, 1195)

	----------------------------------------------------------社交大使18----------米尔米莉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission( 5723, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1196 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000891 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000891")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000891)
				
	MisBeginCondition(NoMission, 1196)
	MisBeginCondition(NoRecord,1196)
	MisBeginCondition(HasRecord, 1195)
	MisBeginAction(AddMission,1196)
	MisCancelAction(ClearMission, 1196)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000757 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000757")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000757)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000892 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000892")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000892)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使18-------- 海港指挥·拉米修
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission(5724, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1196, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000893 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000893")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000893)
	MisResultCondition(NoRecord, 1196)
	MisResultCondition(HasMission,1196)
	MisResultAction(ClearMission,1196)
	MisResultAction(SetRecord, 1196)

	----------------------------------------------------------社交大使19----------海港指挥·拉米修
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission( 5725, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1197 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000894 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000894")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000894)
				
	MisBeginCondition(NoMission, 1197)
	MisBeginCondition(NoRecord,1197)
	MisBeginCondition(HasRecord, 1196)
	MisBeginAction(AddMission,1197)
	MisCancelAction(ClearMission, 1197)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000367 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000367")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000367)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000895 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000895")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000895)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使19-------- 天堂传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission(5726, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1197, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000896 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000896")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000896)
	MisResultCondition(NoRecord, 1197)
	MisResultCondition(HasMission,1197)
	MisResultAction(ClearMission,1197)
	MisResultAction(SetRecord, 1197)


		----------------------------------------------------------社交大使20----------天堂传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission( 5727, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1198 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000897 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000897")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000897)
				
	MisBeginCondition(NoMission, 1198)
	MisBeginCondition(NoRecord,1198)
	MisBeginCondition(HasRecord, 1197)
	MisBeginAction(AddMission,1198)
	MisCancelAction(ClearMission, 1198)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000898 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000898")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000898)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000899 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000899")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000899)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交大使20-------- 交易员·桑吉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission(5728, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1198, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000900 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000900")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000900)
	MisResultCondition(NoRecord, 1198)
	MisResultCondition(HasMission,1198)
	MisResultAction(ClearMission,1198)
	MisResultAction(SetRecord, 1198)

		----------------------------------------------------------社交大使21----------交易员·桑吉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000365")
	DefineMission( 5729, MISSCRIPT_MISSIONSCRIPT07_LUA_000365, 1199 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000901 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000901")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000901)
				
	MisBeginCondition(NoMission, 1199)
	MisBeginCondition(NoRecord,1199)
	MisBeginCondition(HasRecord, 1198)
	MisBeginAction(AddMission,1199)
	MisCancelAction(ClearMission, 1199)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000902 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000902")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000902)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000903 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000903")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000903)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------社交英雄21------- 海盗·德克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000769 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000769")
	DefineMission(5730, MISSCRIPT_MISSIONSCRIPT07_LUA_000769, 1199, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000904 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000904")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000904)
	MisResultCondition(NoRecord, 1199)
	MisResultCondition(HasMission,1199)
	MisResultAction(ClearMission,1199)
	MisResultAction(SetRecord, 1199)
	MisResultAction(GiveItem, 1879, 1, 4)
	MisResultBagNeed(1)


-------------------------------------------------特别任务	--------海盗·德克
	MISSCRIPT_MISSIONSCRIPT07_LUA_000905 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000905")
	DefineMission (5731, MISSCRIPT_MISSIONSCRIPT07_LUA_000905, 1200)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000906 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000906")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000906)

	MisBeginCondition(NoMission,1200)
	MisBeginCondition(NoRecord,1200)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(HasRecord,1174)
	MisBeginCondition(HasRecord,1175)
	MisBeginCondition(HasRecord,1176)
	MisBeginCondition(HasRecord,1177)
	MisBeginCondition(HasRecord,1178)
	MisBeginCondition(HasRecord,1199)
	MisBeginCondition(HasRecord,1168)
	MisBeginAction(AddMission,1200)
	MisBeginAction(AddTrigger, 12001, TE_GETITEM, 0854, 1 )---------------------百万大钞 
	MisCancelAction(ClearMission, 1200)
	
	
	MisNeed(MIS_NEED_ITEM, 0854, 1, 1, 1 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000907 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000907")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000907)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000908 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000908")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000908)

	MisResultCondition(HasMission, 1200)
	MisResultCondition(NoRecord,1200)
	MisResultCondition(HasItem, 0854, 1 )
	MisResultAction(TakeItem, 0854, 1 )
	MisResultAction(GiveItem, 1881, 1, 4)
	MisResultAction(ClearMission, 1200)
	MisResultAction(SetRecord,  1200 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 0854)	
	TriggerAction( 1, AddNextFlag, 1200, 1, 1 )
	RegCurTrigger( 12001 )	


	
-------------------------------------------------双子之水手过关奖励----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000909 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000909")
	DefineMission (5733, MISSCRIPT_MISSIONSCRIPT07_LUA_000909, 1201)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000910 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000910")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000910)

	MisBeginCondition(NoMission,1201)
	MisBeginCondition(HasRecord,1159)
	MisBeginCondition(HasRecord,1163)
	MisBeginCondition(HasRecord,1164)
	MisBeginCondition(HasRecord,1165)
	MisBeginCondition(HasRecord,1166)
	MisBeginCondition(HasRecord,1167)
	MisBeginCondition(HasRecord,1168)
	MisBeginCondition(HasRecord,1199)
	MisBeginCondition(NoRecord,1201)
	MisBeginAction(AddMission,1201)  
	MisBeginAction(AddTrigger, 12011, TE_GETITEM, 1874, 1 )		
	MisBeginAction(AddTrigger, 12012, TE_GETITEM, 1875, 1 )		
	MisBeginAction(AddTrigger, 12013, TE_GETITEM, 1876, 1 )		
 	MisBeginAction(AddTrigger, 12014, TE_GETITEM, 1877, 1 )		
	MisBeginAction(AddTrigger, 12015, TE_GETITEM, 1878, 1 )		
	MisBeginAction(AddTrigger, 12016, TE_GETITEM, 1879, 1 )		
	MisBeginAction(AddTrigger, 12017, TE_GETITEM, 1880, 1 )	
	MisCancelAction(ClearMission, 1201)						                                     
	
	MisNeed(MIS_NEED_ITEM, 1874, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 1875, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 1876, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 1877, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 1878, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 1879, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 1880, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000911 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000911")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000911)

	MisResultCondition(HasMission, 1201)
	MisResultCondition(NoRecord,1201)
	MisResultCondition(HasItem, 1874, 1 )
	MisResultCondition(HasItem, 1875, 1 )
	MisResultCondition(HasItem, 1876, 1 )
	MisResultCondition(HasItem, 1877, 1 )
	MisResultCondition(HasItem, 1878, 1 )
	MisResultCondition(HasItem, 1879, 1 )
	MisResultCondition(HasItem, 1880, 1 )

	MisResultAction(TakeItem, 1874, 1 )
	MisResultAction(TakeItem, 1875, 1 )
	MisResultAction(TakeItem, 1876, 1 )
	MisResultAction(TakeItem, 1877, 1 )
	MisResultAction(TakeItem, 1878, 1 )
	MisResultAction(TakeItem, 1879, 1 )
	MisResultAction(TakeItem, 1880, 1 )

	MisResultAction(ClearMission, 1201)
	MisResultAction(SetRecord,  1201 )
	MisResultAction(GiveItem, 1865, 1, 4)
	MisResultAction(GiveItem, 1866, 1, 4)
	MisResultAction(GiveItem, 1002, 30, 4)
	MisResultAction(AddMoney,500000,500000)
	MisResultAction(ShuangZiSS)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1874)	
	TriggerAction( 1, AddNextFlag, 1201, 10, 1 )
	RegCurTrigger( 12011 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1875)	
	TriggerAction( 1, AddNextFlag, 1201, 20, 1 )
	RegCurTrigger( 12012 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1876)	
	TriggerAction( 1, AddNextFlag, 1201, 30, 1 )
	RegCurTrigger( 12013 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1877)	
	TriggerAction( 1, AddNextFlag, 1201, 40, 1 )
	RegCurTrigger( 12014 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1878)	
	TriggerAction( 1, AddNextFlag, 1201, 50, 1 )
	RegCurTrigger( 12015 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1879)	
	TriggerAction( 1, AddNextFlag, 1201, 60, 1 )
	RegCurTrigger( 12016 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1880)	
	TriggerAction( 1, AddNextFlag, 1201, 70, 1 )
	RegCurTrigger( 12017 )
----------------------------------------------双子之海盗过关奖励----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000912 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000912")
	DefineMission (5734, MISSCRIPT_MISSIONSCRIPT07_LUA_000912, 1202)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000910 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000910")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000910)

	MisBeginCondition(NoMission,1202)
	MisBeginCondition(HasRecord,1204)
	MisBeginCondition(HasRecord,1169)
	MisBeginCondition(HasRecord,1170)
	MisBeginCondition(HasRecord,1171)
	MisBeginCondition(HasRecord,1172)
	MisBeginCondition(HasRecord,1173)
	MisBeginCondition(HasRecord,1168)
	MisBeginCondition(HasRecord,1199)
	MisBeginCondition(NoRecord,1202)
	MisBeginAction(AddMission,1202)
	MisBeginAction(AddTrigger, 11571, TE_GETITEM, 1874, 1 )		
	MisBeginAction(AddTrigger, 11572, TE_GETITEM, 1875, 1 )		
	MisBeginAction(AddTrigger, 11573, TE_GETITEM, 1876, 1 )		
 	MisBeginAction(AddTrigger, 11574, TE_GETITEM, 1877, 1 )		
	MisBeginAction(AddTrigger, 11575, TE_GETITEM, 1878, 1 )		
	MisBeginAction(AddTrigger, 11576, TE_GETITEM, 1879, 1 )		
	MisBeginAction(AddTrigger, 11577, TE_GETITEM, 1880, 1 )		
	MisCancelAction(ClearMission, 1202)						                                     
	
	MisNeed(MIS_NEED_ITEM, 1874, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 1875, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 1876, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 1877, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 1878, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 1879, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 1880, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000911 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000911")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000911)

	MisResultCondition(HasMission, 1202)
	MisResultCondition(NoRecord,1202)
	MisResultCondition(HasItem, 1874, 1 )
	MisResultCondition(HasItem, 1875, 1 )
	MisResultCondition(HasItem, 1876, 1 )
	MisResultCondition(HasItem, 1877, 1 )
	MisResultCondition(HasItem, 1878, 1 )
	MisResultCondition(HasItem, 1879, 1 )
	MisResultCondition(HasItem, 1880, 1 )

	MisResultAction(TakeItem, 1874, 1 )
	MisResultAction(TakeItem, 1875, 1 )
	MisResultAction(TakeItem, 1876, 1 )
	MisResultAction(TakeItem, 1877, 1 )
	MisResultAction(TakeItem, 1878, 1 )
	MisResultAction(TakeItem, 1879, 1 )
	MisResultAction(TakeItem, 1880, 1 )

	MisResultAction(ClearMission, 1202)
	MisResultAction(SetRecord,  1202 )
	MisResultAction(GiveItem, 1865, 1, 4)
	MisResultAction(GiveItem, 1866, 1, 4)
	MisResultAction(GiveItem, 1002, 60, 4)
	MisResultAction(AddMoney,700000,700000)
	MisResultAction(ShuangZiHD)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1874)	
	TriggerAction( 1, AddNextFlag, 1157, 10, 1 )
	RegCurTrigger( 12021 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1875)	
	TriggerAction( 1, AddNextFlag, 1202, 20, 1 )
	RegCurTrigger( 12022 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1876)	
	TriggerAction( 1, AddNextFlag, 1202, 30, 1 )
	RegCurTrigger( 12023 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1877)	
	TriggerAction( 1, AddNextFlag, 1202, 40, 1 )
	RegCurTrigger( 12024 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1878)	
	TriggerAction( 1, AddNextFlag, 1202, 50, 1 )
	RegCurTrigger( 12025 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1879)	
	TriggerAction( 1, AddNextFlag, 1202, 60, 1 )
	RegCurTrigger( 12026 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1880)	
	TriggerAction( 1, AddNextFlag, 1202, 70, 1 )
	RegCurTrigger( 12027 )

	--------------------------------------------双子之船长过关奖励----------海盗·德克	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000913 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000913")
	DefineMission (5735, MISSCRIPT_MISSIONSCRIPT07_LUA_000913, 1203)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000910 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000910")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000910)

	MisBeginCondition(NoMission,1203)
	MisBeginCondition(HasRecord,1161)
	MisBeginCondition(HasRecord,1174)
	MisBeginCondition(HasRecord,1175)
	MisBeginCondition(HasRecord,1176)
	MisBeginCondition(HasRecord,1177)
	MisBeginCondition(HasRecord,1178)
	MisBeginCondition(HasRecord,1199)
	MisBeginCondition(HasRecord,1168)
	MisBeginCondition(NoRecord,1203)
	MisBeginAction(AddMission,1203)   
	MisBeginAction(AddTrigger, 11581, TE_GETITEM, 1874, 1 )		
	MisBeginAction(AddTrigger, 11582, TE_GETITEM, 1875, 1 )		
	MisBeginAction(AddTrigger, 11583, TE_GETITEM, 1876, 1 )		
 	MisBeginAction(AddTrigger, 11584, TE_GETITEM, 1877, 1 )		
	MisBeginAction(AddTrigger, 11585, TE_GETITEM, 1878, 1 )		
	MisBeginAction(AddTrigger, 11586, TE_GETITEM, 1879, 1 )		
	MisBeginAction(AddTrigger, 11587, TE_GETITEM, 1880, 1 )	
	MisCancelAction(ClearMission, 1203)						                                     
	
	MisNeed(MIS_NEED_ITEM, 1874, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 1875, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 1876, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 1877, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 1878, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 1879, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 1880, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000911 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000911")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000911)

	MisResultCondition(HasMission, 1203)
	MisResultCondition(NoRecord,1203)
	MisResultCondition(HasItem, 1874, 1 )
	MisResultCondition(HasItem, 1875, 1 )
	MisResultCondition(HasItem, 1876, 1 )
	MisResultCondition(HasItem, 1877, 1 )
	MisResultCondition(HasItem, 1878, 1 )
	MisResultCondition(HasItem, 1879, 1 )
	MisResultCondition(HasItem, 1880, 1 )

	MisResultAction(TakeItem, 1874, 1 )
	MisResultAction(TakeItem, 1875, 1 )
	MisResultAction(TakeItem, 1876, 1 )
	MisResultAction(TakeItem, 1877, 1 )
	MisResultAction(TakeItem, 1878, 1 )
	MisResultAction(TakeItem, 1879, 1 )
	MisResultAction(TakeItem, 1880, 1 )

	MisResultAction(ClearMission, 1203)
	MisResultAction(SetRecord,  1203 )
	MisResultAction(GiveItem, 1865, 1, 4)
	MisResultAction(GiveItem, 1866, 1, 4)
	MisResultAction(GiveItem, 1002, 90, 4)
	MisResultAction(AddMoney,900000,900000)
	MisResultAction(ShuangZiCZ)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1874)	
	TriggerAction( 1, AddNextFlag, 1203, 10, 1 )
	RegCurTrigger( 12031 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1875)	
	TriggerAction( 1, AddNextFlag, 1203, 20, 1 )
	RegCurTrigger( 12032 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1876)	
	TriggerAction( 1, AddNextFlag, 1203, 30, 1 )
	RegCurTrigger( 12033 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1877)	
	TriggerAction( 1, AddNextFlag, 1203, 40, 1 )
	RegCurTrigger( 12034 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1878)	
	TriggerAction( 1, AddNextFlag, 1203, 50, 1 )
	RegCurTrigger( 12035 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1879)	
	TriggerAction( 1, AddNextFlag, 1203, 60, 1 )
	RegCurTrigger( 12036 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1880)	
	TriggerAction( 1, AddNextFlag, 1203, 70, 1 )
	RegCurTrigger( 12037 )

	----------------------------------天仙配传奇--------月老
	MISSCRIPT_MISSIONSCRIPT07_LUA_000914 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000914")
	DefineMission ( 5736, MISSCRIPT_MISSIONSCRIPT07_LUA_000914, 1205)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000915 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000915")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000915)

	MisBeginCondition(NoMission,1205)
	MisBeginCondition(NoRecord,1205)
	MisBeginAction(AddMission,1205)
	MisBeginAction(AddTrigger, 12051, TE_GETITEM, 4418, 10)
	MisCancelAction(ClearMission, 1205)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000916 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000916")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000916)
	MisNeed(MIS_NEED_ITEM, 4418, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000917 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000917")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000917)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000918 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000918")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000918) 
	
	MisResultCondition(HasMission, 1205)
	MisResultCondition(NoRecord,1205)
	MisResultCondition(HasItem, 4418, 10)
	MisResultAction(TakeItem, 4418, 10 )
	MisResultAction(ClearMission, 1205)
	MisResultAction(SetRecord, 1205 )
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4418)	
	TriggerAction( 1, AddNextFlag, 1205, 10, 10 )
	RegCurTrigger( 12051 )

	-------------------------------鹊桥情事--------月老
	MISSCRIPT_MISSIONSCRIPT07_LUA_000919 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000919")
	DefineMission( 5737, MISSCRIPT_MISSIONSCRIPT07_LUA_000919, 1206)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000920 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000920")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000920)
	MisBeginCondition(HasRecord, 1205 )
	MisBeginCondition(NoRecord, 1206 )
	MisBeginCondition(NoMission, 1206 )
	MisBeginAction(AddMission, 1206 )
	MisCancelAction(ClearMission, 1206)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000921 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000921")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000921)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000922 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000922")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000922)
	MisResultCondition(AlwaysFailure )

	---------------------------------------鹊桥情事-------牛郎

	MISSCRIPT_MISSIONSCRIPT07_LUA_000919 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000919")
	DefineMission(5738,MISSCRIPT_MISSIONSCRIPT07_LUA_000919,1206,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000923 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000923")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000923)
	MisResultCondition(HasMission, 1206)
	MisBeginCondition(NoRecord, 1206)
	MisResultAction(ClearMission, 1206)
	MisResultAction(SetRecord, 1206)


	-------------------------------千里传书------牛郎
	MISSCRIPT_MISSIONSCRIPT07_LUA_000924 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000924")
	DefineMission( 5739, MISSCRIPT_MISSIONSCRIPT07_LUA_000924, 1207)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000925 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000925")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000925)
	MisBeginCondition(HasRecord, 1206 )
	MisBeginCondition(NoRecord, 1207 )
	MisBeginCondition(NoMission, 1207 )
	MisBeginAction(AddMission, 1207 )
	MisBeginAction(GiveItem, 2669, 1, 4)----------牛郎的情书
	MisCancelAction(ClearMission, 1207)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000926 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000926")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000926)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000927 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000927")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000927)
	MisResultCondition(AlwaysFailure )

	---------------------------------------千里传书----织女

	MISSCRIPT_MISSIONSCRIPT07_LUA_000924 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000924")
	DefineMission(5740,MISSCRIPT_MISSIONSCRIPT07_LUA_000924,1207,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000928 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000928")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000928)
	MisResultCondition(HasMission, 1207)
	MisBeginCondition(NoRecord, 1207)
	MisResultCondition(HasItem,2669,1)---------牛郎的情书
	MisResultAction(TakeItem, 2669,1)
	MisResultAction(GiveItem, 2670, 1, 4)----------天衣宝箱
	MisResultAction(ClearMission, 1207)
	MisResultAction(SetRecord, 1207)
	MisResultAction(ClearRecord, 1205 )
	MisResultAction(ClearRecord, 1206 )
	MisResultAction(ClearRecord, 1207 )
	MisResultBagNeed(1)

-------------------------------------------------------昂贵的学费----------雷诺校长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000929 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000929")
	DefineMission( 6127, MISSCRIPT_MISSIONSCRIPT07_LUA_000929, 1453)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000930 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000930")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000930)
	MisBeginCondition( NoMission, 1453)
	MisBeginCondition( NoRecord, 1453)
	MisBeginAction( AddMission, 1453)
	MisBeginAction(AddTrigger, 14531, TE_GETITEM, 3909, 99)
	MisCancelAction( ClearMission, 1453)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000931 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000931")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000931)
	MisNeed( MIS_NEED_ITEM, 3909, 99, 10, 99)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000932 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000932")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000932)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000933 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000933")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000933)
	MisResultCondition( HasMission, 1453)
	MisResultCondition( NoRecord, 1453)
	MisResultCondition( HasItem, 3909, 99)
	MisResultAction( ClearMission, 1453)
	MisResultAction( TakeItem, 3909, 99)
	MisResultAction( SetRecord, 1453)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3909)	
	TriggerAction( 1, AddNextFlag, 1453, 10, 99 )
	RegCurTrigger( 14531 )

-------------------------------------------------------更多的朋友----------雷诺校长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000934 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000934")
	DefineMission( 6128, MISSCRIPT_MISSIONSCRIPT07_LUA_000934, 1454)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000935 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000935")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000935)
	MisBeginCondition( NoMission, 1454)
	MisBeginCondition( NoRecord, 1454)
	MisBeginCondition( HasRecord, 1453)
	MisBeginAction( AddMission, 1454)
	MisCancelAction( ClearMission, 1454)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000936 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000936")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000936)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000937 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000937")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000937)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000938 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000938")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000938)
	MisResultCondition( HasMission, 1454)
	MisResultCondition( NoRecord, 1454)
	MisResultCondition( CheckTeam1, 5)					------检测有几个队友
	MisResultAction( ClearMission, 1454)
	MisResultAction( SetRecord, 1454)

-------------------------------------------------------体育锻炼----------雷诺校长

	MISSCRIPT_MISSIONSCRIPT07_LUA_000939 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000939")
	DefineMission( 6129, MISSCRIPT_MISSIONSCRIPT07_LUA_000939, 1455)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000940 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000940")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000940)
	MisBeginCondition( NoMission, 1455)
	MisBeginCondition( NoRecord, 1455)
	MisBeginCondition( HasRecord, 1454)
	MisBeginAction( AddMission, 1455)
	MisBeginAction(AddTrigger, 14551, TE_KILL, 75, 10 )
	MisCancelAction( ClearMission, 1455)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000941 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000941")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000941)
	MisNeed( MIS_NEED_KILL, 75, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000942 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000942")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000942)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000943 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000943")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000943)
	MisResultCondition( HasMission, 1455)
	MisResultCondition( NoRecord, 1455)
	MisResultCondition( HasFlag, 1455, 19)
	MisResultAction( ClearMission, 1455)
	MisResultAction( SetRecord, 1455)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 75 )	
	TriggerAction( 1, AddNextFlag, 1455, 10, 10 )
	RegCurTrigger(14551)

-------------------------------------------------------入学证书----------雷诺校长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000944 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000944")
	DefineMission( 6130, MISSCRIPT_MISSIONSCRIPT07_LUA_000944, 1456)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000945 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000945")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000945)
	MisBeginCondition( NoMission, 1456)
	MisBeginCondition( NoRecord, 1456)
	MisBeginCondition( HasRecord, 1455)
	MisBeginAction( AddMission, 1456)
	MisBeginAction(AddTrigger, 14561, TE_GETITEM, 854, 1)
	MisCancelAction( ClearMission, 1456)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000946 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000946")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000946)
	MisNeed( MIS_NEED_ITEM, 854, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000947 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000947")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000947)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000948 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000948")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000948)
	MisResultCondition( HasMission, 1456)
	MisResultCondition( NoRecord, 1456)
	MisResultCondition( HasItem, 854, 1)
	MisResultAction( ClearMission, 1456)
	MisResultAction( TakeItem, 854, 1)
	MisResultAction( GiveItem, 579, 1, 4)
	MisResultAction( SetRecord, 1456)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 854)	
	TriggerAction( 1, AddNextFlag, 1456, 10, 1 )
	RegCurTrigger( 14561 )

-------------------------------------------------------开学报到----------雷诺校长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000949 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000949")
	DefineMission( 6131, MISSCRIPT_MISSIONSCRIPT07_LUA_000949, 1457)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000950 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000950")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000950)
	MisBeginCondition( NoMission, 1457)
	MisBeginCondition( NoRecord, 1457)
	MisBeginCondition( HasRecord, 1456)
	MisBeginAction( AddMission, 1457)
	MisCancelAction( ClearMission, 1457)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000951 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000951")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000951)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000952 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000952")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000952)
	MisResultCondition( AlwaysFailure )

-------------------------------------------------------开学报到----------昂莉娜老师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000949 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000949")
	DefineMission( 6132, MISSCRIPT_MISSIONSCRIPT07_LUA_000949, 1457, COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000953 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000953")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000953)
	MisResultCondition( HasMission, 1457)
	MisResultCondition( NoRecord, 1457)
	MisResultCondition( HasItem, 579, 1)
	MisResultAction( ClearMission, 1457)
	MisResultAction( SetRecord, 1457)
	
-------------------------------------------------------入学考试----------昂莉娜老师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000954 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000954")
	DefineMission( 6133, MISSCRIPT_MISSIONSCRIPT07_LUA_000954, 1458)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000955 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000955")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000955)
	MisBeginCondition( NoMission, 1458)
	MisBeginCondition( NoRecord, 1458)
	MisBeginCondition( HasRecord, 1457)
	MisBeginAction( AddMission, 1458)
	MisCancelAction( ClearMission, 1458)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000956 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000956")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000956)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000957 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000957")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000957)
	MisResultCondition( AlwaysFailure )

-------------------------------------------------------入学考试----------昂莉娜老师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000954 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000954")
	DefineMission( 6134, MISSCRIPT_MISSIONSCRIPT07_LUA_000954, 1458, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000958 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000958")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000958)
	MisResultCondition( HasMission, 1458)
	MisResultCondition( NoRecord, 1463)
	MisResultCondition( HasRecord, 1461)
	MisResultCondition( CheckRightNum )
	MisResultAction( SetRecord, 1463)
	MisResultAction( SetRecord, 1458)
	MisResultAction( TakeItem, 579, 1)
	MisResultAction( GiveItem, 47, 1, 4)
	MisResultAction( ClearMission, 1458)
	MisResultBagNeed(1)

-------------------------------------------------------入学考试----------昂莉娜老师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000954 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000954")
	DefineMission( 6135, MISSCRIPT_MISSIONSCRIPT07_LUA_000954, 1458, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000959 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000959")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000959)
	MisResultCondition( HasMission, 1458)
	MisResultCondition( NoRecord, 1463)
	MisResultCondition( HasRecord, 1461)
	MisResultCondition( CheckErroNum )
	MisResultAction( SetRecord, 1463)
	MisResultAction( SetRecord, 1458)
	MisResultAction( SetRecord, 1460)
	MisResultAction( TakeItem, 579, 1)
	MisResultAction( ClearMission, 1458)

-------------------------------------------------------真假友人----------昂莉娜老师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000960 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000960")
	DefineMission( 6136, MISSCRIPT_MISSIONSCRIPT07_LUA_000960, 1464)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000961 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000961")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000961)
	MisBeginCondition( NoMission, 1464)
	MisBeginCondition( NoRecord, 1464)
	MisBeginCondition( HasRecord, 1460)
	MisBeginAction( AddMission, 1464)
	MisBeginAction(AddTrigger, 14641, TE_GETITEM, 3050, 10)
	MisBeginAction( GiveItem, 500, 1, 4)
	MisCancelAction( ClearMission, 1464)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000962 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000962")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000962)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000963 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000963")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000963)
	
	MisResultCondition( AlwaysFailure )

-------------------------------------------------------真假友人----------库拉托斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000960 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000960")
	DefineMission( 6137, MISSCRIPT_MISSIONSCRIPT07_LUA_000960, 1464, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000964 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000964")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_000964)
	MisResultCondition( HasMission, 1464)
	MisResultCondition( NoRecord, 1464)
	MisResultCondition( HasRecord, 1465)
	MisResultCondition( HasItem, 500, 1)
	MisResultCondition( HasItem, 3050, 10)
	MisResultAction( SetRecord, 1464)
	MisResultAction( TakeItem, 500, 1)
	MisResultAction( TakeItem, 3050, 10)
	MisResultAction( ClearMission, 1464)
	MisResultAction( GiveItem, 47, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3050)	
	TriggerAction( 1, AddNextFlag, 1464, 10, 10 )
	RegCurTrigger( 14641 )

	-----------------------------------------乱斗英雄----------海事所助理·罗拉娜--------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000965 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000965")
	DefineMission (5800, MISSCRIPT_MISSIONSCRIPT07_LUA_000965, 1470)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000966 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000966")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000966)

	MisBeginCondition(NoMission,1470)
	MisBeginCondition(HasRecord,1466)
	MisBeginCondition(NoRecord,1470)
	MisBeginAction(AddMission,1470)
	MisCancelAction(ClearMission, 1470)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000967 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000967")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000967)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000784")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000968 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000968")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000968)

	MisResultCondition(HasMission, 1470)
	MisResultCondition(NoRecord,1470)
	MisResultCondition(HasFightingPoint,80 )
	MisResultAction(TakeFightingPoint, 80 )
	MisResultAction(ClearMission, 1470)
	MisResultAction(SetRecord,  1470 )
	MisResultAction(GiveItem, 2568, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------名声英雄----------海事所助理·罗拉娜	--------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000969")
	DefineMission (5801, MISSCRIPT_MISSIONSCRIPT07_LUA_000969, 1471)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000970 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000970")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000970)

	MisBeginCondition(NoMission,1471)
	MisBeginCondition(HasRecord,1466)
	MisBeginCondition(NoRecord,1471)
	MisBeginAction(AddMission,1471)
	MisCancelAction(ClearMission, 1471)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000671 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000671")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000671)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000971 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000971")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000971)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000790")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000790)

	MisResultCondition(HasMission, 1471)
	MisResultCondition(NoRecord,1471)
	MisResultCondition(HasCredit,3000 )
	MisResultAction(TakeCredit, 3000 )
	MisResultAction(ClearMission, 1471)
	MisResultAction(SetRecord,  1471 )
	MisResultAction(GiveItem, 2569, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------等级英雄----------海事所助理·罗拉娜	---------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000972 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000972")
	DefineMission (5802, MISSCRIPT_MISSIONSCRIPT07_LUA_000972, 1472)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000973")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000973)

	MisBeginCondition(NoMission,1472)
	MisBeginCondition(HasRecord,1466)
	MisBeginCondition(NoRecord,1472)
	MisBeginAction(AddMission,1472)
	MisCancelAction(ClearMission, 1472)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000684 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000684")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000684)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000811 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000811")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000811)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000974 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000974")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000974)

	MisResultCondition(HasMission, 1472)
	MisResultCondition(NoRecord,1472)
	MisResultCondition(LvCheck, ">", 64 )
	MisResultAction(ClearMission, 1472)
	MisResultAction(SetRecord,  1472 )
	MisResultAction(GiveItem, 2570, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------荣誉英雄----------海事所助理·罗拉娜	----------水手
	MISSCRIPT_MISSIONSCRIPT07_LUA_000975 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000975")
	DefineMission (5803, MISSCRIPT_MISSIONSCRIPT07_LUA_000975, 1473)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000976 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000976")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000976)

	MisBeginCondition(NoMission,1473)
	MisBeginCondition(HasRecord,1466)
	MisBeginCondition(NoRecord,1473)
	MisBeginAction(AddMission,1473)
	MisCancelAction(ClearMission, 1473)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000977 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000977")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000977)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000797)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000798)

	MisResultCondition(HasMission, 1473)
	MisResultCondition(NoRecord,1473)
	MisResultCondition(HasHonorPoint,600 )
	MisResultAction(TakeHonorPoint, 600 )
	MisResultAction(ClearMission, 1473)
	MisResultAction(SetRecord,  1473 )
	MisResultAction(GiveItem, 2571, 1, 4)
	MisResultBagNeed(1)	

	-------------------------------------------------采集大使----------海事所助理·罗拉娜	----------水手	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000978 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000978")
	DefineMission (5804, MISSCRIPT_MISSIONSCRIPT07_LUA_000978, 1474)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000979 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000979")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000979)

	MisBeginCondition(NoMission,1474)
	MisBeginCondition(HasRecord,1466)
	MisBeginCondition(NoRecord,1474)
	MisBeginAction(AddMission,1474)
	MisBeginAction(AddTrigger, 14741, TE_GETITEM, 1693, 10 )-------------------蝎甲10个
	MisBeginAction(AddTrigger, 14742, TE_GETITEM, 2677, 10 )-------------------链弹LV1 10          
	MisBeginAction(AddTrigger, 14743, TE_GETITEM, 3909, 1 )-----------------食神水饺1               
	MisBeginAction(AddTrigger, 14744, TE_GETITEM, 2589, 5 )----------------精灵王辉印5               
	MisBeginAction(AddTrigger, 14745, TE_GETITEM, 3094, 5)------------------努力增幅器5            
	MisBeginAction(AddTrigger, 14746, TE_GETITEM, 3827, 1 )-----------------情之殇1             
	MisCancelAction(ClearMission, 1474)
	

	MisNeed(MIS_NEED_ITEM, 1693, 10,  1, 10 )
	MisNeed(MIS_NEED_ITEM, 2677, 10, 11, 10 )
	MisNeed(MIS_NEED_ITEM, 3909, 1,  21, 1 )
	MisNeed(MIS_NEED_ITEM, 2589, 5,  22, 5 )
	MisNeed(MIS_NEED_ITEM, 3094, 5,  27, 5 )
	MisNeed(MIS_NEED_ITEM, 3827, 1,  32, 1 )
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000980 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000980")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000980)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000981 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000981")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000981)

	MisResultCondition(HasMission, 1474)
	MisResultCondition(NoRecord,1474)
	MisResultCondition(HasItem, 1693, 10 )
	MisResultCondition(HasItem, 2677, 10 )
	MisResultCondition(HasItem, 3909, 1 )
	MisResultCondition(HasItem, 2589, 5 )
	MisResultCondition(HasItem, 3094, 5 )
	MisResultCondition(HasItem, 3827, 1 )


	MisResultAction(TakeItem, 1693, 10 )
	MisResultAction(TakeItem, 2677, 10 )
	MisResultAction(TakeItem, 3909, 1 )
	MisResultAction(TakeItem, 2589, 5 )
	MisResultAction(TakeItem, 3094, 5 )
	MisResultAction(TakeItem, 3827, 1 )

	MisResultAction(ClearMission, 1474)
	MisResultAction(SetRecord,  1474 )
	MisResultAction(GiveItem, 2572, 1, 4)
	MisResultAction(GiveItem, 2576, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1693)	
	TriggerAction( 1, AddNextFlag, 1474, 1, 10 )
	RegCurTrigger( 14741 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2677)	
	TriggerAction( 1, AddNextFlag, 1474, 11, 10 )
	RegCurTrigger( 14742 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3909)	
	TriggerAction( 1, AddNextFlag, 1474, 21, 1 )
	RegCurTrigger( 14743 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2589)	
	TriggerAction( 1, AddNextFlag, 1474, 22, 5 )
	RegCurTrigger( 14744 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3094)	
	TriggerAction( 1, AddNextFlag, 1474, 27, 5 )
	RegCurTrigger( 14745 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3827)	
	TriggerAction( 1, AddNextFlag, 1474,32, 1 )
	RegCurTrigger( 14746 )

	----------------------------------------------------------巨蟹末日----------海事所助理·罗拉娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_000982 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000982")
	DefineMission( 5805, MISSCRIPT_MISSIONSCRIPT07_LUA_000982, 1475 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000983 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000983")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000983)
				
	MisBeginCondition(NoMission, 1475)
	MisBeginCondition(HasRecord,1469)
	MisBeginCondition(NoRecord,1475)
	MisBeginAction(AddMission,1475)
	MisBeginAction(AddTrigger, 14751, TE_KILL, 1040, 1)---巨蟹守护者
	
	MisCancelAction(ClearMission, 1475)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000984 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000984")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000984)
	MisNeed(MIS_NEED_KILL, 1040,1, 10, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_000985 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000985")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000985)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000986 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000986")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000986)
	MisResultCondition(HasMission,  1475)
	MisResultCondition(HasFlag, 1475, 10)
	MisResultCondition(NoRecord , 1475)
	MisResultAction(GiveItem, 2574, 1, 4 )
	MisResultAction(ClearMission,  1475)
	MisResultAction(SetRecord,  1475 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1040)	
	TriggerAction( 1, AddNextFlag, 1475, 10, 1 )
	RegCurTrigger( 14751 )


	-----------------------------------------乱斗英雄----------海事所助理·罗拉娜--------海盗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000965 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000965")
	DefineMission (5806, MISSCRIPT_MISSIONSCRIPT07_LUA_000965, 1476)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000966 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000966")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000966)

	MisBeginCondition(NoMission,1476)
	MisBeginCondition(HasRecord,1467)
	MisBeginCondition(NoRecord,1476)
	MisBeginAction(AddMission,1476)
	MisCancelAction(ClearMission, 1476)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000987 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000987")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000987)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000784")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000968 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000968")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000968)

	MisResultCondition(HasMission, 1476)
	MisResultCondition(NoRecord,1476)
	MisResultCondition(HasFightingPoint,150 )
	MisResultAction(TakeFightingPoint, 150 )
	MisResultAction(ClearMission, 1476)
	MisResultAction(SetRecord,  1476 )
	MisResultAction(GiveItem, 2568, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------名声英雄----------海事所助理·罗拉娜	--------海盗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000969")
	DefineMission (5807, MISSCRIPT_MISSIONSCRIPT07_LUA_000969, 1477)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000970 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000970")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000970)

	MisBeginCondition(NoMission,1477)
	MisBeginCondition(HasRecord,1467)
	MisBeginCondition(NoRecord,1477)
	MisBeginAction(AddMission,1477)
	MisCancelAction(ClearMission, 1477)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000988 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000988")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000988)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000989 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000989")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000989)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000790")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000790)

	MisResultCondition(HasMission, 1477)
	MisResultCondition(NoRecord,1477)
	MisResultCondition(HasCredit,6000 )
	MisResultAction(TakeCredit, 6000 )
	MisResultAction(ClearMission, 1477)
	MisResultAction(SetRecord,  1477 )
	MisResultAction(GiveItem, 2569, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------海事所助理·罗拉娜	---------海盗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000972 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000972")
	DefineMission (5808, MISSCRIPT_MISSIONSCRIPT07_LUA_000972, 1600)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000973")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000973)

	MisBeginCondition(NoMission,1600)
	MisBeginCondition(HasRecord,1467)
	MisBeginCondition(NoRecord,1600)
	MisBeginAction(AddMission,1600)
	MisCancelAction(ClearMission, 1600)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000820 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000820")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000820)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000821 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000821")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000821)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000974 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000974")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000974)

	MisResultCondition(HasMission, 1600)
	MisResultCondition(NoRecord,1600)
	MisResultCondition(LvCheck, ">", 69 )
	MisResultAction(ClearMission, 1600)
	MisResultAction(SetRecord,  1600 )
	MisResultAction(GiveItem, 2570, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------荣誉英雄----------海事所助理·罗拉娜	----------海盗
	MISSCRIPT_MISSIONSCRIPT07_LUA_000975 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000975")
	DefineMission (5809, MISSCRIPT_MISSIONSCRIPT07_LUA_000975, 1479)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000976 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000976")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000976)

	MisBeginCondition(NoMission,1479)
	MisBeginCondition(HasRecord,1467)
	MisBeginCondition(NoRecord,1479)
	MisBeginAction(AddMission,1479)
	MisCancelAction(ClearMission, 1479)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000990 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000990")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000990)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000797)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000798)

	MisResultCondition(HasMission, 1479)
	MisResultCondition(NoRecord,1479)
	MisResultCondition(HasHonorPoint,900 )
	MisResultAction(TakeHonorPoint, 900 )
	MisResultAction(ClearMission, 1479)
	MisResultAction(SetRecord,  1479 )
	MisResultAction(GiveItem, 2571, 1, 4)
	MisResultBagNeed(1)	

	-------------------------------------------------采集大使----------海事所助理·罗拉娜	----------海盗	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000978 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000978")
	DefineMission (5810, MISSCRIPT_MISSIONSCRIPT07_LUA_000978, 1480)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000979 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000979")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000979)

	MisBeginCondition(NoMission,1480)
	MisBeginCondition(HasRecord,1467)
	MisBeginCondition(NoRecord,1480)
	MisBeginAction(AddMission,1480)
	MisBeginAction(AddTrigger, 14801, TE_GETITEM, 1693, 20 )-------------------蝎甲20个
	MisBeginAction(AddTrigger, 14802, TE_GETITEM, 2677, 20 )-------------------链弹LV1 20个          
	MisBeginAction(AddTrigger, 14803, TE_GETITEM, 3909, 5 )-----------------食神水饺5个               
	MisBeginAction(AddTrigger, 14804, TE_GETITEM, 2589, 5 )----------------精灵王辉印5               
	MisBeginAction(AddTrigger, 14805, TE_GETITEM, 3094, 10)------------------努力增幅器10个         
	MisBeginAction(AddTrigger, 14806, TE_GETITEM, 3827, 1 )-----------------情之殇1     
	MisBeginAction(AddTrigger, 14807, TE_GETITEM, 0271, 1 )-----------------天使骰子1个         
	MisCancelAction(ClearMission, 1480)
	

	MisNeed(MIS_NEED_ITEM, 1693, 20,  1, 20 )
	MisNeed(MIS_NEED_ITEM, 2677, 20, 21, 20 )
	MisNeed(MIS_NEED_ITEM, 3909, 5,  41, 5 )
	MisNeed(MIS_NEED_ITEM, 2589, 5,  46, 5 )
	MisNeed(MIS_NEED_ITEM, 3094, 10, 51, 10 )
	MisNeed(MIS_NEED_ITEM, 3827, 1,  61, 1 )
	MisNeed(MIS_NEED_ITEM, 0271, 1,  62, 1 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000980 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000980")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000980)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000981 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000981")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000981)

	MisResultCondition(HasMission, 1480)
	MisResultCondition(NoRecord,1480)
	MisResultCondition(HasItem, 1693, 20 )
	MisResultCondition(HasItem, 2677, 20 )
	MisResultCondition(HasItem, 3909, 5 )
	MisResultCondition(HasItem, 2589, 5 )
	MisResultCondition(HasItem, 3094, 10 )
	MisResultCondition(HasItem, 3827, 1 )
	MisResultCondition(HasItem, 0271, 1 )

	MisResultAction(TakeItem, 1693, 20 )
	MisResultAction(TakeItem, 2677, 20 )
	MisResultAction(TakeItem, 3909, 5 )
	MisResultAction(TakeItem, 2589, 5 )
	MisResultAction(TakeItem, 3094, 10 )
	MisResultAction(TakeItem, 3827, 1 )
	MisResultAction(TakeItem, 0271, 1 )

	MisResultAction(ClearMission, 1480)
	MisResultAction(SetRecord,  1480 )
	MisResultAction(GiveItem, 2572, 1, 4)
	MisResultAction(GiveItem, 2576, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1693)	
	TriggerAction( 1, AddNextFlag, 1480, 1, 20 )
	RegCurTrigger( 14801 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2677)	
	TriggerAction( 1, AddNextFlag, 1480, 21, 20 )
	RegCurTrigger( 14802 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3909)	
	TriggerAction( 1, AddNextFlag, 1480, 41, 5 )
	RegCurTrigger( 14803 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2589)	
	TriggerAction( 1, AddNextFlag, 1480, 46, 5 )
	RegCurTrigger( 14804 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3094)	
	TriggerAction( 1, AddNextFlag, 1480, 51, 10 )
	RegCurTrigger( 14805 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3827)	
	TriggerAction( 1, AddNextFlag, 1480,61, 1 )
	RegCurTrigger( 14806 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0271)	
	TriggerAction( 1, AddNextFlag, 1480,62, 1 )
	RegCurTrigger( 14807 )


	-----------------------------------------乱斗英雄----------海事所助理·罗拉娜--------船长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000965 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000965")
	DefineMission (5811, MISSCRIPT_MISSIONSCRIPT07_LUA_000965, 1481)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000966 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000966")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000966)

	MisBeginCondition(NoMission,1481)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(NoRecord,1481)
	MisBeginAction(AddMission,1481)
	MisCancelAction(ClearMission, 1481)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000991 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000991")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000991)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000784")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000968 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000968")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000968)

	MisResultCondition(HasMission, 1481)
	MisResultCondition(NoRecord,1481)
	MisResultCondition(HasFightingPoint,200 )
	MisResultAction(TakeFightingPoint, 200 )
	MisResultAction(ClearMission, 1481)
	MisResultAction(SetRecord,  1481 )
	MisResultAction(GiveItem, 2568, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------名声英雄----------海事所助理·罗拉娜	--------船长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000969")
	DefineMission (5812, MISSCRIPT_MISSIONSCRIPT07_LUA_000969, 1482)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000970 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000970")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000970)

	MisBeginCondition(NoMission,1482)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(NoRecord,1482)
	MisBeginAction(AddMission,1482)
	MisCancelAction(ClearMission, 1482)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000992 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000992")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000992)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000993 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000993")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000993)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000790")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000790)

	MisResultCondition(HasMission, 1482)
	MisResultCondition(NoRecord,1482)
	MisResultCondition(HasCredit,10000 )
	MisResultAction(TakeCredit, 10000 )
	MisResultAction(ClearMission, 1482)
	MisResultAction(SetRecord,  1482 )
	MisResultAction(GiveItem, 2569, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------等级英雄----------海事所助理·罗拉娜	---------船长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000972 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000972")
	DefineMission (5813, MISSCRIPT_MISSIONSCRIPT07_LUA_000972, 1483)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000973")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000973)

	MisBeginCondition(NoMission,1483)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(NoRecord,1483)
	MisBeginAction(AddMission,1483)
	MisCancelAction(ClearMission, 1483)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000994 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000994")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000994)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000995 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000995")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000995)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000974 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000974")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000974)

	MisResultCondition(HasMission, 1483)
	MisResultCondition(NoRecord,1483)
	MisResultCondition(LvCheck, ">", 74 )
	MisResultAction(ClearMission, 1483)
	MisResultAction(SetRecord,  1483 )
	MisResultAction(GiveItem, 2570, 1, 4)
	MisResultBagNeed(1)

	-------------------------------------------------荣誉英雄----------海事所助理·罗拉娜	----------船长
	MISSCRIPT_MISSIONSCRIPT07_LUA_000975 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000975")
	DefineMission (5814, MISSCRIPT_MISSIONSCRIPT07_LUA_000975, 1484)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000976 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000976")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000976)

	MisBeginCondition(NoMission,1484)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(NoRecord,1484)
	MisBeginAction(AddMission,1484)
	MisCancelAction(ClearMission, 1484)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000996 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000996")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000996)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000797)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000798)

	MisResultCondition(HasMission, 1484)
	MisResultCondition(NoRecord,1484)
	MisResultCondition(HasHonorPoint,1200 )
	MisResultAction(TakeHonorPoint, 1200 )
	MisResultAction(ClearMission, 1484)
	MisResultAction(SetRecord,  1484 )
	MisResultAction(GiveItem, 2571, 1, 4)
	MisResultBagNeed(1)	


	-------------------------------------------------采集大使----------海事所助理·罗拉娜	----------船长	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000978 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000978")
	DefineMission (5815, MISSCRIPT_MISSIONSCRIPT07_LUA_000978, 1485)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000979 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000979")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000979)

	MisBeginCondition(NoMission,1485)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(NoRecord,1485)
	MisBeginAction(AddMission,1485)
	MisBeginAction(AddTrigger, 14851, TE_GETITEM, 1693, 30 )-------------------蝎甲30个
	MisBeginAction(AddTrigger, 14852, TE_GETITEM, 2677, 30 )-------------------链弹LV1 30个          
	MisBeginAction(AddTrigger, 14853, TE_GETITEM, 3909, 10 )-----------------食神水饺10个               
	MisBeginAction(AddTrigger, 14854, TE_GETITEM, 2589, 10 )----------------精灵王辉印10               
	MisBeginAction(AddTrigger, 14855, TE_GETITEM, 3094, 20)------------------努力增幅器20个         
	MisBeginAction(AddTrigger, 14856, TE_GETITEM, 3827, 1 )-----------------情之殇1     
	MisBeginAction(AddTrigger, 14857, TE_GETITEM, 0271, 2 )-----------------天使骰子2个         
	MisCancelAction(ClearMission, 1485)
	

	MisNeed(MIS_NEED_ITEM, 1693, 30,  1, 30 )
	MisNeed(MIS_NEED_ITEM, 2677, 30, 31, 30 )
	MisNeed(MIS_NEED_ITEM, 3909, 10, 61, 10 )
	MisNeed(MIS_NEED_ITEM, 2589, 10, 71, 10 )
	MisNeed(MIS_NEED_ITEM, 3094, 20, 81, 20 )
	MisNeed(MIS_NEED_ITEM, 3827, 1,  101, 1 )
	MisNeed(MIS_NEED_ITEM, 0271, 2,  102, 2 )

	MISSCRIPT_MISSIONSCRIPT07_LUA_000980 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000980")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000980)
	MISSCRIPT_MISSIONSCRIPT07_LUA_000981 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000981")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000981)

	MisResultCondition(HasMission, 1485)
	MisResultCondition(NoRecord,1485)
	MisResultCondition(HasItem, 1693, 30 )
	MisResultCondition(HasItem, 2677, 30 )
	MisResultCondition(HasItem, 3909, 10 )
	MisResultCondition(HasItem, 2589, 10 )
	MisResultCondition(HasItem, 3094, 20 )
	MisResultCondition(HasItem, 3827, 1 )
	MisResultCondition(HasItem, 0271, 2 )

	MisResultAction(TakeItem, 1693, 30 )
	MisResultAction(TakeItem, 2677, 30 )
	MisResultAction(TakeItem, 3909, 10 )
	MisResultAction(TakeItem, 2589, 10 )
	MisResultAction(TakeItem, 3094, 20 )
	MisResultAction(TakeItem, 3827, 1 )
	MisResultAction(TakeItem, 0271, 2 )

	MisResultAction(ClearMission, 1485)
	MisResultAction(SetRecord,  1485 )
	MisResultAction(GiveItem, 2572, 1, 4)
	MisResultAction(GiveItem, 2576, 1, 4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1693)	
	TriggerAction( 1, AddNextFlag, 1485, 1, 30 )
	RegCurTrigger( 14851 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2677)	
	TriggerAction( 1, AddNextFlag, 1485, 31, 30 )
	RegCurTrigger( 14852 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3909)	
	TriggerAction( 1, AddNextFlag, 1485, 61, 10 )
	RegCurTrigger( 14853 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2589)	
	TriggerAction( 1, AddNextFlag, 1485, 71, 10 )
	RegCurTrigger( 14854 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3094)	
	TriggerAction( 1, AddNextFlag, 1485, 81, 20 )
	RegCurTrigger( 14855 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3827)	
	TriggerAction( 1, AddNextFlag, 1485,101, 1 )
	RegCurTrigger( 14856 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0271)	
	TriggerAction( 1, AddNextFlag, 1485,102, 2 )
	RegCurTrigger( 14857 )


	----------------------------------------------------------社交大使----------海事所助理·罗拉娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_000997 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000997")
	DefineMission( 5816, MISSCRIPT_MISSIONSCRIPT07_LUA_000997, 1486 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_000998 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000998")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000998)
				
	MisBeginCondition(NoMission, 1486)
	MisBeginCondition(NoRecord,1486)
	MisBeginCondition(HasRecord, 1469)
	MisBeginAction(AddMission,1486)
	MisCancelAction(ClearMission, 1486)

	MISSCRIPT_MISSIONSCRIPT07_LUA_000999 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000999")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_000999)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001000 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001000")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001000)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使-----------------铁匠·武鑫

	MISSCRIPT_MISSIONSCRIPT07_LUA_000997 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000997")
	DefineMission(5817, MISSCRIPT_MISSIONSCRIPT07_LUA_000997, 1486, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001001 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001001")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001001)
	MisResultCondition(NoRecord, 1486)
	MisResultCondition(HasMission,1486)
	MisResultAction(ClearMission,1486)
	MisResultAction(SetRecord, 1486)

	----------------------------------------------------------社交大使2----------铁匠·武鑫
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission( 5818, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1487 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001002 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001002")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001002)
				
	MisBeginCondition(NoMission, 1487)
	MisBeginCondition(NoRecord,1487)
	MisBeginCondition(HasRecord, 1486)
	MisBeginAction(AddMission,1487)
	MisCancelAction(ClearMission, 1487)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001003 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001003")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001003)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001004 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001004")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001004)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使2-------------客栈老板·龙女
	MISSCRIPT_MISSIONSCRIPT07_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000270")
	DefineMission(5819, MISSCRIPT_MISSIONSCRIPT07_LUA_000270, 1487, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001005 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001005")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001005)
	MisResultCondition(NoRecord, 1487)
	MisResultCondition(HasMission,1487)
	MisResultAction(ClearMission,1487)
	MisResultAction(SetRecord, 1487)

	----------------------------------------------------------社交大使3----------客栈老板·龙女
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission( 5820, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1488 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001006 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001006")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001006)
				
	MisBeginCondition(NoMission, 1488)
	MisBeginCondition(NoRecord,1488)
	MisBeginCondition(HasRecord, 1487)
	MisBeginAction(AddMission,1488)
	MisCancelAction(ClearMission, 1488)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001007 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001007")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001007)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001008 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001008")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001008)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使3--------杂货商人·鲁娜儿
	MISSCRIPT_MISSIONSCRIPT07_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000275")
	DefineMission(5821, MISSCRIPT_MISSIONSCRIPT07_LUA_000275, 1488, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001009")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001009)
	MisResultCondition(NoRecord, 1488)
	MisResultCondition(HasMission,1488)
	MisResultAction(ClearMission,1488)
	MisResultAction(SetRecord, 1488)

	----------------------------------------------------------社交大使4----------杂货商人·鲁娜儿
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission( 5822, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1489 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001010 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001010")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001010)
				
	MisBeginCondition(NoMission, 1489)
	MisBeginCondition(NoRecord,  1489)
	MisBeginCondition(HasRecord, 1488)
	MisBeginAction(AddMission, 1489)
	MisCancelAction(ClearMission, 1489)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001011 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001011")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001011)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001012 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001012")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001012)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使4--------霍金斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000280")
	DefineMission(5823, MISSCRIPT_MISSIONSCRIPT07_LUA_000280, 1489, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001013 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001013")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001013)
	MisResultCondition(NoRecord, 1489)
	MisResultCondition(HasMission,1489)
	MisResultAction(ClearMission,1489)
	MisResultAction(SetRecord, 1489)


	----------------------------------------------------------社交大使5----------霍金斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission( 5824, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1490 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001014 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001014")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001014)
				
	MisBeginCondition(NoMission, 1490)
	MisBeginCondition(NoRecord,  1490)
	MisBeginCondition(HasRecord, 1489)
	MisBeginAction(AddMission,1490)
	MisCancelAction(ClearMission, 1490)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001015 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001015")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001015)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001016 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001016")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001016)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使5--------贸易商人·油李
	MISSCRIPT_MISSIONSCRIPT07_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000285")
	DefineMission(5825, MISSCRIPT_MISSIONSCRIPT07_LUA_000285, 1490, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001017 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001017)
	MisResultCondition(NoRecord, 1490)
	MisResultCondition(HasMission,1490)
	MisResultAction(ClearMission,1490)
	MisResultAction(SetRecord, 1490)


	----------------------------------------------------------社交大使6----------贸易商人·油李
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission( 5826, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1491)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001018")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001018)
				
	MisBeginCondition(NoMission, 1491)
	MisBeginCondition(NoRecord,1491)
	MisBeginCondition(HasRecord, 1490)
	MisBeginAction(AddMission,1491)
	MisCancelAction(ClearMission, 1491)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001019 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001019")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001019)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001020 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001020")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001020)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使6--------传送使·春莉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000290")
	DefineMission(5827, MISSCRIPT_MISSIONSCRIPT07_LUA_000290, 1491, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001021 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001021")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001021)
	MisResultCondition(NoRecord, 1491)
	MisResultCondition(HasMission,1491)
	MisResultAction(ClearMission,1491)
	MisResultAction(SetRecord, 1491)


	----------------------------------------------------------社交大使7----------传送使·春莉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission( 5828, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1492 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001022 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001022")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001022)
				
	MisBeginCondition(NoMission, 1492)
	MisBeginCondition(NoRecord,1492)
	MisBeginCondition(HasRecord, 1491)
	MisBeginAction(AddMission,1492)
	MisCancelAction(ClearMission, 1492)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001023 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001023")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001023)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001024 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001024")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001024)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使7--------算命先生·算破天
	MISSCRIPT_MISSIONSCRIPT07_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000295")
	DefineMission(5829, MISSCRIPT_MISSIONSCRIPT07_LUA_000295, 1492, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001025 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001025")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001025)
	MisResultCondition(NoRecord, 1492)
	MisResultCondition(HasMission,1492)
	MisResultAction(ClearMission,1492)
	MisResultAction(SetRecord, 1492)


	----------------------------------------------------------社交大使8----------算命先生·算破天
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission( 5830, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1493 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001026 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001026")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001026)
				
	MisBeginCondition(NoMission, 1493)
	MisBeginCondition(NoRecord,  1493)
	MisBeginCondition(HasRecord, 1492)
	MisBeginAction(AddMission,1493)
	MisCancelAction(ClearMission, 1493)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001027 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001027")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001027)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001028 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001028")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001028)
	MisResultCondition(AlwaysFailure)
	
	-----------------------------------------社交大使8--------酒店老板·裴蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000300")
	DefineMission(5831, MISSCRIPT_MISSIONSCRIPT07_LUA_000300, 1493, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001029 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001029")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001029)
	MisResultCondition(NoRecord, 1493)
	MisResultCondition(HasMission,1493)
	MisResultAction(ClearMission,1493)
	MisResultAction(SetRecord, 1493)


	----------------------------------------------------------社交大使9----------酒店老板·裴蒂
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission( 5832, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1494 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001030 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001030")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001030)
				
	MisBeginCondition(NoMission, 1494)
	MisBeginCondition(NoRecord,  1494)
	MisBeginCondition(HasRecord, 1493)
	MisBeginAction(AddMission,1494)
	MisCancelAction(ClearMission, 1494)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001031 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001031")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001031)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001032 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001032")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001032)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使9--------港口指挥·霜奇
	MISSCRIPT_MISSIONSCRIPT07_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000305")
	DefineMission(5833, MISSCRIPT_MISSIONSCRIPT07_LUA_000305, 1494, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001033 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001033")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001033)
	MisResultCondition(NoRecord, 1494)
	MisResultCondition(HasMission,1494)
	MisResultAction(ClearMission,1494)
	MisResultAction(SetRecord, 1494)

	----------------------------------------------------------社交大使10----------港口指挥·霜奇
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission( 5834, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1495 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001034 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001034")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001034)
				
	MisBeginCondition(NoMission, 1495)
	MisBeginCondition(NoRecord, 1495)
	MisBeginCondition(HasRecord, 1494)
	MisBeginAction(AddMission, 1495)
	MisCancelAction(ClearMission, 1495)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001035 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001035")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001035)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001036 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001036")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001036)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使10--------卫兵·赵钱孙
	MISSCRIPT_MISSIONSCRIPT07_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000310")
	DefineMission(5835, MISSCRIPT_MISSIONSCRIPT07_LUA_000310, 1495, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001037 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001037")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001037)
	MisResultCondition(NoRecord, 1495)
	MisResultCondition(HasMission,1495)
	MisResultAction(ClearMission,1495)
	MisResultAction(SetRecord, 1495)

	----------------------------------------------------------社交大使11----------卫兵·赵钱孙
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission( 5836, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1496 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001038 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001038")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001038)
				
	MisBeginCondition(NoMission, 1496)
	MisBeginCondition(NoRecord,1496)
	MisBeginCondition(HasRecord, 1495)
	MisBeginAction(AddMission,1496)
	MisCancelAction(ClearMission, 1496)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001039 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001039")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001039)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001040 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001040")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001040)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使11--------卫兵·周吴郑
	MISSCRIPT_MISSIONSCRIPT07_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000315")
	DefineMission(5837, MISSCRIPT_MISSIONSCRIPT07_LUA_000315, 1496, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001041 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001041")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001041)
	MisResultCondition(NoRecord, 1496)
	MisResultCondition(HasMission,1496)
	MisResultAction(ClearMission,1496)
	MisResultAction(SetRecord, 1496)

	----------------------------------------------------------社交大使12----------卫兵·周吴郑
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission( 5838, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1497 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001042 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001042")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001042)
				
	MisBeginCondition(NoMission, 1497)
	MisBeginCondition(NoRecord,1497)
	MisBeginCondition(HasRecord, 1496)
	MisBeginAction(AddMission,1497)
	MisCancelAction(ClearMission, 1497)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001043 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001043")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001043)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001044 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001044")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001044)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使12--------银行总管·王墨
	MISSCRIPT_MISSIONSCRIPT07_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000320")
	DefineMission(5839, MISSCRIPT_MISSIONSCRIPT07_LUA_000320, 1497, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001045 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001045")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001045)
	MisResultCondition(NoRecord, 1497)
	MisResultCondition(HasMission,1497)
	MisResultAction(ClearMission,1497)
	MisResultAction(SetRecord, 1497)


	----------------------------------------------------------社交大使13----------银行总管·王墨
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission( 5840, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1498 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001046 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001046")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001046)
				
	MisBeginCondition(NoMission, 1498)
	MisBeginCondition(NoRecord,1498)
	MisBeginCondition(HasRecord, 1497)
	MisBeginAction(AddMission,1498)
	MisCancelAction(ClearMission, 1498)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001047 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001047")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001047)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001048 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001048")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001048)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使13--------青年男子·流云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000325")
	DefineMission(5841, MISSCRIPT_MISSIONSCRIPT07_LUA_000325, 1498, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001049 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001049")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001049)
	MisResultCondition(NoRecord, 1498)
	MisResultCondition(HasMission,1498)
	MisResultAction(ClearMission,1498)
	MisResultAction(SetRecord, 1498)

	----------------------------------------------------------社交大使14----------青年男子·流云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission( 5842, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1499 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001050")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001050)
				
	MisBeginCondition(NoMission, 1499)
	MisBeginCondition(NoRecord,1499)
	MisBeginCondition(HasRecord, 1498)
	MisBeginAction(AddMission,1499)
	MisCancelAction(ClearMission, 1499)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001051 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001051")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001051)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001052 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001052")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001052)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使14--------青年女子·水雾        
	MISSCRIPT_MISSIONSCRIPT07_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000330")
	DefineMission(5843, MISSCRIPT_MISSIONSCRIPT07_LUA_000330, 1499, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001053 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001053")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001053)
	MisResultCondition(NoRecord, 1499)
	MisResultCondition(HasMission,1499)
	MisResultAction(ClearMission,1499)
	MisResultAction(SetRecord, 1499)

	----------------------------------------------------------社交大使15----------青年女子·水雾
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission( 5844, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1601 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001054 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001054")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001054)
				
	MisBeginCondition(NoMission, 1601)
	MisBeginCondition(NoRecord,1601)
	MisBeginCondition(HasRecord, 1499)
	MisBeginAction(AddMission,1601)
	MisCancelAction(ClearMission, 1601)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001055")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001055)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001056")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001056)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使15-------- 中年女子·王蓉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000335")
	DefineMission(5845, MISSCRIPT_MISSIONSCRIPT07_LUA_000335, 1601, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001057 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001057")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001057)
	MisResultCondition(NoRecord, 1601)
	MisResultCondition(HasMission,1601)
	MisResultAction(ClearMission,1601)
	MisResultAction(SetRecord, 1601)


	----------------------------------------------------------社交大使16----------中年女子·王蓉
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission( 5846, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1602 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001058")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001058)
				
	MisBeginCondition(NoMission, 1602)
	MisBeginCondition(NoRecord,1602)
	MisBeginCondition(HasRecord, 1601)
	MisBeginAction(AddMission,1602)
	MisCancelAction(ClearMission, 1602)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001059")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001059)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001060 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001060")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001060)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使16-------- 中年男子·比盖
	MISSCRIPT_MISSIONSCRIPT07_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000340")
	DefineMission(5847, MISSCRIPT_MISSIONSCRIPT07_LUA_000340, 1602, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001061 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001061")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001061)
	MisResultCondition(NoRecord, 1602)
	MisResultCondition(HasMission,1602)
	MisResultAction(ClearMission,1602)
	MisResultAction(SetRecord, 1602)


	----------------------------------------------------------社交大使17----------中年男子·比盖
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission( 5848, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1502 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001062 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001062")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001062)
				
	MisBeginCondition(NoMission, 1502)
	MisBeginCondition(NoRecord,1502)
	MisBeginCondition(HasRecord, 1602)
	MisBeginAction(AddMission,1502)
	MisCancelAction(ClearMission, 1502)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001063 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001063")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001063)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001064 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001064")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001064)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使17-------- 东方海盗·山田佐
	MISSCRIPT_MISSIONSCRIPT07_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000345")
	DefineMission(5849, MISSCRIPT_MISSIONSCRIPT07_LUA_000345, 1502, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001065 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001065")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001065)
	MisResultCondition(NoRecord, 1502)
	MisResultCondition(HasMission,1502)
	MisResultAction(ClearMission,1502)
	MisResultAction(SetRecord, 1502)

	----------------------------------------------------------社交大使18----------东方海盗·山田佐
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission( 5850, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1603 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001066 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001066")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001066)
				
	MisBeginCondition(NoMission, 1603)
	MisBeginCondition(NoRecord,1603)
	MisBeginCondition(HasRecord, 1502)
	MisBeginAction(AddMission,1603)
	MisCancelAction(ClearMission, 1603)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001067 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001067")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001067)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001068 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001068")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001068)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使18-------- 潮流理发师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000350")
	DefineMission(5851, MISSCRIPT_MISSIONSCRIPT07_LUA_000350, 1603, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001069 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001069")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001069)
	MisResultCondition(NoRecord, 1603)
	MisResultCondition(HasMission,1603)
	MisResultAction(ClearMission,1603)
	MisResultAction(SetRecord, 1603)

	----------------------------------------------------------社交大使19----------潮流理发师
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission( 5852, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1604 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001070 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001070")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001070)
				
	MisBeginCondition(NoMission, 1604)
	MisBeginCondition(NoRecord,1604)
	MisBeginCondition(HasRecord, 1603)
	MisBeginAction(AddMission,1604)
	MisCancelAction(ClearMission, 1604)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001071 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001071")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001071)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001072 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001072")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001072)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使19-------- 海港指挥·夏青
	MISSCRIPT_MISSIONSCRIPT07_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000355")
	DefineMission(5853, MISSCRIPT_MISSIONSCRIPT07_LUA_000355, 1604, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001073 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001073")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001073)
	MisResultCondition(NoRecord, 1604)
	MisResultCondition(HasMission,1604)
	MisResultAction(ClearMission,1604)
	MisResultAction(SetRecord, 1604)


	----------------------------------------------------------社交大使20----------海港指挥·夏青
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission( 5854, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1605 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001074 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001074")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001074)
				
	MisBeginCondition(NoMission, 1605)
	MisBeginCondition(NoRecord,1605)
	MisBeginCondition(HasRecord, 1604)
	MisBeginAction(AddMission,1605)
	MisCancelAction(ClearMission, 1605)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001075 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001075")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001075)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001076 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001076")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001076)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交大使20-------- 海港指挥·夏云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000360")
	DefineMission(5855, MISSCRIPT_MISSIONSCRIPT07_LUA_000360, 1605, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001077 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001077")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001077)
	MisResultCondition(NoRecord, 1605)
	MisResultCondition(HasMission,1605)
	MisResultAction(ClearMission,1605)
	MisResultAction(SetRecord, 1605)

	----------------------------------------------------------社交大使21----------海港指挥·夏云
	MISSCRIPT_MISSIONSCRIPT07_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000365")
	DefineMission( 5856, MISSCRIPT_MISSIONSCRIPT07_LUA_000365, 1606 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001078 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001078")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001078)
				
	MisBeginCondition(NoMission, 1606)
	MisBeginCondition(NoRecord,1606)
	MisBeginCondition(HasRecord, 1605)
	MisBeginAction(AddMission,1606)
	MisCancelAction(ClearMission, 1606)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001079 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001079")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001079)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001080 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001080")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001080)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------社交英雄21------- 海事所助理·罗拉娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_000769 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000769")
	DefineMission(5857, MISSCRIPT_MISSIONSCRIPT07_LUA_000769, 1606, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001081 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001081")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001081)
	MisResultCondition(NoRecord, 1606)
	MisResultCondition(HasMission,1606)
	MisResultAction(ClearMission,1606)
	MisResultAction(SetRecord, 1606)
	MisResultAction(GiveItem, 2573, 1, 4)
	MisResultBagNeed(1)


	-------------------------------------------------特别任务一--------海事所助理·罗拉娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_001082 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001082")
	DefineMission (5858, MISSCRIPT_MISSIONSCRIPT07_LUA_001082, 1607)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001083 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001083")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001083)

	MisBeginCondition(NoMission,1607)
	MisBeginCondition(NoRecord,1607)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(HasRecord,1481)
	MisBeginCondition(HasRecord,1482)
	MisBeginCondition(HasRecord,1483)
	MisBeginCondition(HasRecord,1484)
	MisBeginCondition(HasRecord,1485)
	MisBeginCondition(HasRecord,1475)
	MisBeginCondition(HasRecord,1606)
	MisBeginAction(AddMission,1607)
	MisCancelAction(ClearMission, 1607)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001084 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001084")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001084)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001085 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001085")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001085)

	MisResultCondition(AlwaysFailure)	


	-------------------------------------------------特别任务一--------冰狼堡的路人·丁
	MISSCRIPT_MISSIONSCRIPT07_LUA_001082 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001082")
	DefineMission (5859, MISSCRIPT_MISSIONSCRIPT07_LUA_001082 , 1607, COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001086 = GetResString("Have you already completed the quest of Alena? Great! Don't look down upon me, I am a hiden big pot! Emm, did you see my name? is it cool? Here is your reward. ")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001086)	
	MisResultCondition(NoRecord, 1607)
	MisResultCondition(HasMission,1607)
	MisResultAction(ClearMission,1607)
	MisResultAction(SetRecord, 1607)
	MisResultAction(GiveItem, 2575, 1, 4)------------巨蟹船长酷装宝箱
	MisResultBagNeed(1)


	--------------------------------------特别任务二----冰狼堡的路人·丁

	MISSCRIPT_MISSIONSCRIPT07_LUA_001087 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001087")
	DefineMission(5860, MISSCRIPT_MISSIONSCRIPT07_LUA_001087, 1608 )	
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001088 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001088")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001088)

	MisBeginCondition(NoMission,1608)
	MisBeginCondition(NoRecord,1608)
	MisBeginCondition(HasRecord,1607)
	MisBeginAction(AddMission,1608)
	MisBeginAction(AddChaItem3, 2952)---------巨蟹特别行动卡
	MisCancelAction(ClearMission, 1608)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001089 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001089")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001089)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001090 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001090")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001090)

	MisResultCondition(AlwaysFailure)	

	--------------------------------------特别任务二----旅行商人

	MISSCRIPT_MISSIONSCRIPT07_LUA_001087 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001087")
	DefineMission(5861, MISSCRIPT_MISSIONSCRIPT07_LUA_001087, 1608, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001091 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001091")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001091)
	MisResultCondition(HasMission, 1608)
	MisResultCondition(NoRecord,1608)
	MisResultAction(AddChaItem4, 2952)----特别行动卡
	MisResultAction(ClearMission, 1608)
	MisResultAction(SetRecord,  1608 )
	MisResultAction(GiveItem, 2575, 1, 4)------------巨蟹船长酷装宝箱
	MisResultBagNeed(1)

-------------------------------------------------巨蟹之水手过关奖励----------海事所助理·罗拉娜
	MISSCRIPT_MISSIONSCRIPT07_LUA_001092 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001092")
	DefineMission (5862, MISSCRIPT_MISSIONSCRIPT07_LUA_001092, 1609)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001093")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001093)

	MisBeginCondition(NoMission,1609)
	MisBeginCondition(HasRecord,1466)
	MisBeginCondition(HasRecord,1470)
	MisBeginCondition(HasRecord,1471)
	MisBeginCondition(HasRecord,1472)
	MisBeginCondition(HasRecord,1473)
	MisBeginCondition(HasRecord,1474)
	MisBeginCondition(HasRecord,1475)
	MisBeginCondition(HasRecord,1606)
	MisBeginCondition(NoRecord,1609)
	MisBeginAction(AddMission,1609)  
	MisBeginAction(AddTrigger, 16091, TE_GETITEM, 2568, 1 )		
	MisBeginAction(AddTrigger, 16092, TE_GETITEM, 2569, 1 )		
	MisBeginAction(AddTrigger, 16093, TE_GETITEM, 2570, 1 )		
 	MisBeginAction(AddTrigger, 16094, TE_GETITEM, 2571, 1 )		
	MisBeginAction(AddTrigger, 16095, TE_GETITEM, 2572, 1 )		
	MisBeginAction(AddTrigger, 16096, TE_GETITEM, 2573, 1 )		
	MisBeginAction(AddTrigger, 16097, TE_GETITEM, 2574, 1 )	
	MisCancelAction(ClearMission, 1609)						                                     
	
	MisNeed(MIS_NEED_ITEM, 2568, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 2569, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 2570, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 2571, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 2572, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 2573, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 2574, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001094 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001094")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001094)

	MisResultCondition(HasMission, 1609)
	MisResultCondition(NoRecord,1609)
	MisResultCondition(HasItem, 2568, 1 )
	MisResultCondition(HasItem, 2569, 1 )
	MisResultCondition(HasItem, 2570, 1 )
	MisResultCondition(HasItem, 2571, 1 )
	MisResultCondition(HasItem, 2572, 1 )
	MisResultCondition(HasItem, 2573, 1 )
	MisResultCondition(HasItem, 2574, 1 )

	MisResultAction(TakeItem, 2568, 1 )
	MisResultAction(TakeItem, 2569, 1 )
	MisResultAction(TakeItem, 2570, 1 )
	MisResultAction(TakeItem, 2571, 1 )
	MisResultAction(TakeItem, 2572, 1 )
	MisResultAction(TakeItem, 2573, 1 )
	MisResultAction(TakeItem, 2574, 1 )

	MisResultAction(ClearMission, 1609)
	MisResultAction(SetRecord,  1609 )
	MisResultAction(GiveItem, 2273, 1, 4)
	MisResultAction(GiveItem, 2274, 1, 4)
	MisResultAction(GiveItem, 3877, 1, 4)
	MisResultAction(AddMoney,1000000,1000000)
	MisResultAction(ShuangZiSS)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1874)	
	TriggerAction( 1, AddNextFlag, 1609, 10, 1 )
	RegCurTrigger( 16091 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1875)	
	TriggerAction( 1, AddNextFlag, 1609, 20, 1 )
	RegCurTrigger( 16092 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1876)	
	TriggerAction( 1, AddNextFlag, 1609, 30, 1 )
	RegCurTrigger( 16093 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1877)	
	TriggerAction( 1, AddNextFlag, 1609, 40, 1 )
	RegCurTrigger( 16094 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1878)	
	TriggerAction( 1, AddNextFlag, 1609, 50, 1 )
	RegCurTrigger( 16095 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1879)	
	TriggerAction( 1, AddNextFlag, 1609, 60, 1 )
	RegCurTrigger( 16096 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1880)	
	TriggerAction( 1, AddNextFlag, 1609, 70, 1 )
	RegCurTrigger( 16097 )
----------------------------------------------巨蟹之海盗过关奖励----------海事所助理·罗拉娜	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001095 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001095")
	DefineMission (5863, MISSCRIPT_MISSIONSCRIPT07_LUA_001095, 1610)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001093")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001093)

	MisBeginCondition(NoMission,1610)
	MisBeginCondition(HasRecord,1467)
	MisBeginCondition(HasRecord,1476)
	MisBeginCondition(HasRecord,1477)
	MisBeginCondition(HasRecord,1600)
	MisBeginCondition(HasRecord,1479)
	MisBeginCondition(HasRecord,1480)
	MisBeginCondition(HasRecord,1475)
	MisBeginCondition(HasRecord,1606)
	MisBeginCondition(NoRecord,1610)
	MisBeginAction(AddMission,1610)
	MisBeginAction(AddTrigger, 16101, TE_GETITEM, 2568, 1 )		
	MisBeginAction(AddTrigger, 16102, TE_GETITEM, 2569, 1 )		
	MisBeginAction(AddTrigger, 16103, TE_GETITEM, 2570, 1 )		
 	MisBeginAction(AddTrigger, 16104, TE_GETITEM, 2571, 1 )		
	MisBeginAction(AddTrigger, 16105, TE_GETITEM, 2572, 1 )		
	MisBeginAction(AddTrigger, 16106, TE_GETITEM, 2573, 1 )		
	MisBeginAction(AddTrigger, 16107, TE_GETITEM, 2574, 1 )		
	MisCancelAction(ClearMission, 1610)						                                     
	
	MisNeed(MIS_NEED_ITEM, 2568, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 2569, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 2570, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 2571, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 2572, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 2573, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 2574, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001094 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001094")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001094)

	MisResultCondition(HasMission, 1610)
	MisResultCondition(NoRecord,1610)
	MisResultCondition(HasItem, 2568, 1 )
	MisResultCondition(HasItem, 2569, 1 )
	MisResultCondition(HasItem, 2570, 1 )
	MisResultCondition(HasItem, 2571, 1 )
	MisResultCondition(HasItem, 2572, 1 )
	MisResultCondition(HasItem, 2573, 1 )
	MisResultCondition(HasItem, 2574, 1 )

	MisResultAction(TakeItem, 2568, 1 )
	MisResultAction(TakeItem, 2569, 1 )
	MisResultAction(TakeItem, 2570, 1 )
	MisResultAction(TakeItem, 2571, 1 )
	MisResultAction(TakeItem, 2572, 1 )
	MisResultAction(TakeItem, 2573, 1 )
	MisResultAction(TakeItem, 2574, 1 )

	MisResultAction(ClearMission, 1610)
	MisResultAction(SetRecord,  1610 )
	MisResultAction(GiveItem, 2273, 1, 4)
	MisResultAction(GiveItem, 2274, 1, 4)
	MisResultAction(GiveItem, 3877, 2, 4)
	MisResultAction(AddMoney,2000000,2000000)
	MisResultAction(ShuangZiHD)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2568)	
	TriggerAction( 1, AddNextFlag, 1610, 10, 1 )
	RegCurTrigger( 16101 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2569)	
	TriggerAction( 1, AddNextFlag, 1610, 20, 1 )
	RegCurTrigger( 16102 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2570)	
	TriggerAction( 1, AddNextFlag, 1610, 30, 1 )
	RegCurTrigger( 16103 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2571)	
	TriggerAction( 1, AddNextFlag, 1610, 40, 1 )
	RegCurTrigger( 16104 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2572)	
	TriggerAction( 1, AddNextFlag, 1610, 50, 1 )
	RegCurTrigger( 16105 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2573)	
	TriggerAction( 1, AddNextFlag, 1610, 60, 1 )
	RegCurTrigger( 16106 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2574)	
	TriggerAction( 1, AddNextFlag, 1610, 70, 1 )
	RegCurTrigger( 16107 )

	--------------------------------------------巨蟹之船长过关奖励----------海事所助理·罗拉娜	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001096 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001096")
	DefineMission (5864, MISSCRIPT_MISSIONSCRIPT07_LUA_001096, 1611)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001093")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001093)

	MisBeginCondition(NoMission,1611)
	MisBeginCondition(HasRecord,1468)
	MisBeginCondition(HasRecord,1481)
	MisBeginCondition(HasRecord,1482)
	MisBeginCondition(HasRecord,1483)
	MisBeginCondition(HasRecord,1484)
	MisBeginCondition(HasRecord,1485)
	MisBeginCondition(HasRecord,1475)
	MisBeginCondition(HasRecord,1606)
	MisBeginCondition(NoRecord,1611)
	MisBeginAction(AddMission,1611)   
	MisBeginAction(AddTrigger, 16111, TE_GETITEM, 2568, 1 )		
	MisBeginAction(AddTrigger, 16112, TE_GETITEM, 2569, 1 )		
	MisBeginAction(AddTrigger, 16113, TE_GETITEM, 2570, 1 )		
 	MisBeginAction(AddTrigger, 16114, TE_GETITEM, 2571, 1 )		
	MisBeginAction(AddTrigger, 16115, TE_GETITEM, 2572, 1 )		
	MisBeginAction(AddTrigger, 16116, TE_GETITEM, 2573, 1 )		
	MisBeginAction(AddTrigger, 16117, TE_GETITEM, 2574, 1 )	
	MisCancelAction(ClearMission, 1611)						                                     
	
	MisNeed(MIS_NEED_ITEM, 2568, 1, 10, 1 )
	MisNeed(MIS_NEED_ITEM, 2569, 1, 20, 1 )
	MisNeed(MIS_NEED_ITEM, 2570, 1, 30, 1 )
	MisNeed(MIS_NEED_ITEM, 2571, 1, 40, 1 )
	MisNeed(MIS_NEED_ITEM, 2572, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 2573, 1, 60, 1 )
	MisNeed(MIS_NEED_ITEM, 2574, 1, 70, 1 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_000777")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_000777)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001094 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001094")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001094)

	MisResultCondition(HasMission, 1611)
	MisResultCondition(NoRecord,1611)
	MisResultCondition(HasItem, 2568, 1 )
	MisResultCondition(HasItem, 2569, 1 )
	MisResultCondition(HasItem, 2570, 1 )
	MisResultCondition(HasItem, 2571, 1 )
	MisResultCondition(HasItem, 2572, 1 )
	MisResultCondition(HasItem, 2573, 1 )
	MisResultCondition(HasItem, 2574, 1 )

	MisResultAction(TakeItem, 2568, 1 )
	MisResultAction(TakeItem, 2569, 1 )
	MisResultAction(TakeItem, 2570, 1 )
	MisResultAction(TakeItem, 2571, 1 )
	MisResultAction(TakeItem, 2572, 1 )
	MisResultAction(TakeItem, 2573, 1 )
	MisResultAction(TakeItem, 2574, 1 )

	MisResultAction(ClearMission, 1611)
	MisResultAction(SetRecord,  1611 )
	MisResultAction(GiveItem, 2273, 1, 4)
	MisResultAction(GiveItem, 2274, 1, 4)
	MisResultAction(GiveItem, 3877, 3, 4)
	MisResultAction(AddMoney,3000000,3000000)
	MisResultAction(ShuangZiCZ)
	MisResultBagNeed(3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2568)	
	TriggerAction( 1, AddNextFlag, 1611, 10, 1 )
	RegCurTrigger( 16111 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2569)	
	TriggerAction( 1, AddNextFlag, 1611, 20, 1 )
	RegCurTrigger( 16112 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2570)	
	TriggerAction( 1, AddNextFlag, 1611, 30, 1 )
	RegCurTrigger( 16113 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2571)	
	TriggerAction( 1, AddNextFlag, 1611, 40, 1 )
	RegCurTrigger( 16114 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2572)	
	TriggerAction( 1, AddNextFlag, 1611, 50, 1 )
	RegCurTrigger( 16115 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2573)	
	TriggerAction( 1, AddNextFlag, 1611, 60, 1 )
	RegCurTrigger( 16116 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2574)	
	TriggerAction( 1, AddNextFlag, 1611, 70, 1 )
	RegCurTrigger( 16117 )


----------------------------------------金秋十月大闸蟹活动（一）---------白银城老奶奶·贝蒂（2277,2769）

	MISSCRIPT_MISSIONSCRIPT07_LUA_001097 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001097")
	DefineMission(5865,MISSCRIPT_MISSIONSCRIPT07_LUA_001097,1208)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001098 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001098")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001098)

	MisBeginCondition(NoMission, 1208)
	MisBeginCondition(NoRecord, 1208)
	MisBeginAction(AddMission, 1208)
	MisBeginAction(AddTrigger, 12081, TE_GETITEM, 4490, 1)          
	MisBeginAction(AddTrigger, 12082, TE_GETITEM, 4426, 2)
	MisBeginAction(AddTrigger, 12083, TE_GETITEM, 4393, 8)

	MisCancelAction(ClearMission,1208)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001099 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001099")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001099)
	MisNeed(MIS_NEED_ITEM, 4490, 1, 10, 1)               ---------蟹壳
	MisNeed(MIS_NEED_ITEM, 4426, 2, 20, 2)               ---------锋利的蟹钳
	MisNeed(MIS_NEED_ITEM, 4393, 8, 30, 8)               ---------无法食用的蟹脚

	MISSCRIPT_MISSIONSCRIPT07_LUA_001100 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001100")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001100)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001101 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001101")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001101)

	MisResultCondition(HasMission, 1208)
	MisResultCondition(NoRecord, 1208)
	MisResultCondition(HasItem, 4490, 1)
	MisResultCondition(HasItem, 4426, 2)
	MisResultCondition(HasItem, 4393, 8)

	MisResultAction(TakeItem, 4490, 1)
	MisResultAction(TakeItem, 4426, 2)
	MisResultAction(TakeItem, 4393, 8)

	MisResultAction(GiveItem, 0048, 1, 4)                          ---------毛蟹
	MisResultAction(ClearMission, 1208)                        
	MisResultAction(SetRecord, 1208)
	MisResultAction(ClearRecord, 1208)                          ----------任务可以反复接
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 4490)
	TriggerAction(1, AddNextFlag, 1208, 10, 1)
	RegCurTrigger(12081)


	InitTrigger()
	TriggerCondition(1, IsItem, 4426)
	TriggerAction(1, AddNextFlag, 1208, 20, 2)
	RegCurTrigger(12082)


	InitTrigger()
	TriggerCondition(1, IsItem, 4393)
	TriggerAction(1, AddNextFlag, 1208, 30, 8)
	RegCurTrigger(12083)


----------------------------------------金秋十月大闸蟹活动（二）---------白银城老奶奶·贝蒂（2277,2769）

	MISSCRIPT_MISSIONSCRIPT07_LUA_001102 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001102")
	DefineMission(5866,MISSCRIPT_MISSIONSCRIPT07_LUA_001102,1209)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001103 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001103")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001103)

	
	MisBeginCondition(NoMission, 1209)
	MisBeginCondition(NoRecord, 1209)
	MisBeginAction(AddMission,1209)
	MisBeginAction(AddTrigger, 12091, TE_GETITEM, 4342, 1)
	MisBeginAction(AddTrigger, 12092, TE_GETITEM, 4793, 2)
	MisBeginAction(AddTrigger, 12093, TE_GETITEM, 4500, 1)
	MisBeginAction(AddTrigger, 12094, TE_GETITEM, 0057, 1)


	MisCancelAction(ClearMission, 1209)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001104 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001104")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001104)
       
	
	MisNeed(MIS_NEED_ITEM, 4342, 1, 10, 1)                       ---------坚硬的蟹壳
	MisNeed(MIS_NEED_ITEM, 4793, 2, 20, 2)                       ---------长绒蟹钳
	MisNeed(MIS_NEED_ITEM, 4500, 1, 30, 1)                       ---------猩红的蟹壳
	MisNeed(MIS_NEED_ITEM, 0057, 1, 40, 1)                       ---------蟹绳

	MISSCRIPT_MISSIONSCRIPT07_LUA_001105 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001105")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001105)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001106 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001106")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001106)

	MisResultCondition(HasMission, 1209)
	MisResultCondition(NoRecord, 1209)
	MisResultCondition(HasItem, 4342, 1)
	MisResultCondition(HasItem, 4793, 2)
	MisResultCondition(HasItem, 4500, 1)
	MisResultCondition(HasItem, 0057, 1)

	MisResultAction(TakeItem, 4342, 1)
	MisResultAction(TakeItem, 4793, 2)
	MisResultAction(TakeItem, 4500, 1)
	MisResultAction(TakeItem, 0057, 1)

	MisResultAction(GiveItem, 0056, 1, 4)                                   ---------大闸蟹
	MisResultAction(ClearMission, 1209)
	MisResultAction(SetRecord, 1209)
	MisResultAction(ClearRecord, 1209)                                   ----------任务可以反复接
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 4342)
	TriggerAction(1, AddNextFlag, 1209, 10, 1)
	RegCurTrigger(12091)


	InitTrigger()
	TriggerCondition(1, IsItem, 4793)
	TriggerAction(1, AddNextFlag, 1209, 20, 2)
	RegCurTrigger(12092)

	InitTrigger()
	TriggerCondition(1, IsItem, 4500)
	TriggerAction(1, AddNextFlag, 1209, 30, 1)
	RegCurTrigger(12093)

	InitTrigger()
	TriggerCondition(1, IsItem, 0057)
	TriggerAction(1, AddNextFlag, 1209, 40, 1)
	RegCurTrigger(12094)


----------------------------------------金秋十月大闸蟹活动（三）---------白银城老奶奶·贝蒂（2277,2769）

	MISSCRIPT_MISSIONSCRIPT07_LUA_001107 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001107")
	DefineMission(5867, MISSCRIPT_MISSIONSCRIPT07_LUA_001107, 1210)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001108 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001108")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001108)

	MisBeginCondition(NoMission, 1210)
	MisBeginCondition(NoRecord, 1210)
	MisBeginAction(AddMission, 1210)
	MisBeginAction(AddTrigger, 12101, TE_KILL, 273, 10)
	MisBeginAction(AddTrigger, 12102, TE_KILL, 186, 10)
	MisBeginAction(AddTrigger, 12103, TE_GETITEM, 4259, 5)
	MisBeginAction(AddTrigger, 12104, TE_GETITEM, 4890, 5)


	MisCancelAction(ClearMission, 1210)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001109 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001109")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001109)
	MisNeed(MIS_NEED_KILL, 273, 10, 10, 10)                  ----------长绒蟹
	MisNeed(MIS_NEED_KILL, 186, 10, 20, 10)                  ----------沙蟹
	MisNeed(MIS_NEED_ITEM, 4259, 5, 30, 5)                  -----------火绒
	MisNeed(MIS_NEED_ITEM, 4890, 5, 40, 5)                  -----------有沙子的蟹肉



	MISSCRIPT_MISSIONSCRIPT07_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001110)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001111 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001111")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001111)
	
	MisResultCondition(HasMission, 1210)
	MisResultCondition(NoRecord, 1210)
	MisResultCondition(HasFlag, 1210, 19)
	MisResultCondition(HasFlag, 1210, 29)
	MisResultCondition(HasItem, 4259, 5)
	MisResultCondition(HasItem, 4890, 5)

	MisResultAction(TakeItem, 4259, 5)
	MisResultAction(TakeItem, 4890, 5)


	MisResultAction(ClearMission, 1210)
	MisResultAction(SetRecord, 1210)
	MisResultAction(ClearRecord, 1210)                                   ----------任务可以反复接
	MisResultAction(Givecrab, 0058)                                   ---------蟹苗
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsMonster, 273)
	TriggerAction(1, AddNextFlag, 1210, 10, 10)
	RegCurTrigger(12101)

	InitTrigger()
	TriggerCondition(1, IsMonster, 186)
	TriggerAction(1, AddNextFlag, 1210, 20, 10)
	RegCurTrigger(12102)

	InitTrigger()
	TriggerCondition(1, IsItem, 4259)
	TriggerAction(1, AddNextFlag, 1210, 30, 5)
	RegCurTrigger(12103)

	InitTrigger()
	TriggerCondition(1, IsItem, 4890)
	TriggerAction(1, AddNextFlag, 1210, 40, 5)
	RegCurTrigger(12104)



-----------------------------kokora---------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------升级考试1	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001112 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001112")
	DefineMission( 6138, MISSCRIPT_MISSIONSCRIPT07_LUA_001112, 1211)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001113 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001113")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001113)
	MisBeginCondition( CheckXSZCh,2 )				------检测学生证中储存的学分是否达到上限
	MisBeginCondition( HasItem , 3280,1 )
	MisBeginCondition( HasNoItem, 3282)
	MisBeginCondition( NoMission ,1211)
	MisBeginAction( AddMission, 1211)
	MisBeginAction(AddTrigger, 12111, TE_GETITEM, 3116, 30 )
	MisCancelAction( ClearMission, 1211)

	MisNeed(MIS_NEED_ITEM, 3116, 30, 10, 30 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001114 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001114")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001114)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001115 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001115")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001115)
	MisResultCondition( HasMission, 1211)
	MisResultCondition( HasItem, 3116, 30)
	MisResultAction( TakeItem, 3116, 30)
	MisResultAction( ClearMission, 1211)
	MisResultAction( GiveItem, 3282, 1, 4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 1211, 10, 30 )
	RegCurTrigger( 12111 )


--------------------------------------------------------------------拯救剑客裴梦

	MISSCRIPT_MISSIONSCRIPT07_LUA_001116 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001116")
	DefineMission( 6139, MISSCRIPT_MISSIONSCRIPT07_LUA_001116, 1212 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001117 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001117")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001117)
	MisBeginCondition(NoMission, 1212)
	MisBeginCondition(NoRecord,1212)
	MisBeginAction(AddMission,1212)
	MisBeginAction(AddTrigger, 12121, TE_GETITEM, 3854, 2)
	MisBeginAction(AddTrigger, 12122, TE_GETITEM, 3858, 1)
	MisBeginAction(AddTrigger, 12123, TE_GETITEM, 3863, 1)
	MisBeginAction(AddTrigger, 12124, TE_GETITEM, 3865, 1)
	MisBeginAction(AddTrigger, 12125, TE_GETITEM, 3862, 1)
	MisBeginAction(AddTrigger, 12126, TE_GETITEM, 3856, 1)
	
	MisCancelAction(ClearMission, 1212)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001118 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001118")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001118)
	MisNeed(MIS_NEED_ITEM, 3854, 2, 10, 2)
	MisNeed(MIS_NEED_ITEM, 3858, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 3863, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 3865, 1, 40, 1)
	MisNeed(MIS_NEED_ITEM, 3862, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 3856, 1, 60, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001119 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001119")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001119)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001120 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001120")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001120)

	MisResultCondition(HasMission, 1212)
	MisResultCondition(NoRecord,1212)
	MisResultCondition(HasItem, 3854, 2)
	MisResultCondition(HasItem, 3858, 1)
	MisResultCondition(HasItem, 3863, 1)
	MisResultCondition(HasItem, 3865, 1)
	MisResultCondition(HasItem, 3862, 1)
	MisResultCondition(HasItem, 3856, 1)

	MisResultAction(TakeItem, 3854, 2 )
	MisResultAction(TakeItem, 3858, 1 )
	MisResultAction(TakeItem, 3863, 1 )
	MisResultAction(TakeItem, 3865, 1 )
	MisResultAction(TakeItem, 3862, 1 )
	MisResultAction(TakeItem, 3856, 1 )

	
	MisResultAction(GiveItem, 3673,1,4)------------夏天的魔法盒
	MisResultAction(ClearMission, 1212)
	--MisResultAction(ZSSTOP)
	MisResultAction(SetRecord, 1212)
	MisResultBagNeed(1)
	


	InitTrigger()
	TriggerCondition( 1, IsItem, 3854)	
	TriggerAction( 1, AddNextFlag, 1212, 10, 2 )
	RegCurTrigger( 12121 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3858)	
	TriggerAction( 1, AddNextFlag, 1212, 20, 1 )
	RegCurTrigger( 12122 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3863)	
	TriggerAction( 1, AddNextFlag, 1212, 30, 1 )
	RegCurTrigger( 12123 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3865)	
	TriggerAction( 1, AddNextFlag, 1212, 40, 1 )
	RegCurTrigger( 12124 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3862)	
	TriggerAction( 1, AddNextFlag, 1212, 50, 1 )
	RegCurTrigger( 12125 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3856)	
	TriggerAction( 1, AddNextFlag, 1212, 60, 1 )
	RegCurTrigger( 12126 )

	----------------------------------------------------------守门人透漏的信息----------洛克家的守门人
	MISSCRIPT_MISSIONSCRIPT07_LUA_001121 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001121")
	DefineMission( 6140, MISSCRIPT_MISSIONSCRIPT07_LUA_001121, 1213 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001122 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001122")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001122)
				
	MisBeginCondition(NoMission, 1213)
	MisBeginCondition(NoRecord,1213)
	MisBeginCondition(HasMission, 1212)
	MisBeginCondition(NoRecord, 1212)
	MisBeginAction(AddMission,1213)
	MisCancelAction(ClearMission, 1213)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001123 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001123")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001123)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001124 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001124")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001124)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------守门人透漏的信息--------洛克家的男佣
	MISSCRIPT_MISSIONSCRIPT07_LUA_001121 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001121")
	DefineMission(6141, MISSCRIPT_MISSIONSCRIPT07_LUA_001121, 1213, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001125 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001125")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001125)
	MisResultCondition(NoRecord, 1213)
	MisResultCondition(HasMission,1213)
	MisResultAction(ClearMission,1213)
	MisResultAction(SetRecord, 1213)


	---------------------------------------------男佣的不满---------洛克家的男佣
	MISSCRIPT_MISSIONSCRIPT07_LUA_001126 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001126")
	DefineMission(6142,MISSCRIPT_MISSIONSCRIPT07_LUA_001126,1214)

      MISSCRIPT_MISSIONSCRIPT07_LUA_001127 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001127")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001127)

      MisBeginCondition(NoRecord,1214)
      MisBeginCondition(NoMission,1214)
      MisBeginCondition(HasRecord, 1213)
      MisBeginAction(AddMission,1214)
      MisBeginAction(AddTrigger, 12141, TE_GETITEM, 4739, 25 )
      MisBeginAction(AddTrigger, 12142, TE_GETITEM, 4740, 25 )          
      MisBeginAction(AddTrigger, 12143, TE_GETITEM, 4741, 25 )               
      MisBeginAction(AddTrigger, 12144, TE_GETITEM, 1486, 25 )               
	MisCancelAction(ClearMission, 1214)

      MISSCRIPT_MISSIONSCRIPT07_LUA_001128 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001128")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001128)
      MisNeed(MIS_NEED_ITEM, 4739, 25,  1, 25 )
      MisNeed(MIS_NEED_ITEM, 4740, 25, 26, 25 )
      MisNeed(MIS_NEED_ITEM, 4741, 25,  51, 25 )
      MisNeed(MIS_NEED_ITEM, 1486, 25,  76, 25 )

      MISSCRIPT_MISSIONSCRIPT07_LUA_001129 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001129")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001129)  
      MISSCRIPT_MISSIONSCRIPT07_LUA_001130 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001130")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001130)
      MisResultCondition(HasMission,1214 )
      MisResultCondition(NoRecord,1214)
      MisResultCondition(HasItem, 4739, 25 )
      MisResultCondition(HasItem, 4740, 25 )
      MisResultCondition(HasItem, 4741, 25 )
      MisResultCondition(HasItem, 1486, 25 )

        MisResultAction(TakeItem, 4739, 25 )
	MisResultAction(TakeItem, 4740, 25 )
	MisResultAction(TakeItem, 4741, 25 )
	MisResultAction(TakeItem, 1486, 25 )

      MisResultAction(GiveItem, 3865, 1, 4 )
      MisResultAction(ClearMission, 1214 )
      MisResultAction(SetRecord, 1214)
      MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4739)	
	TriggerAction( 1, AddNextFlag, 1214, 1, 25 )
	RegCurTrigger( 12141 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4740)	
	TriggerAction( 1, AddNextFlag, 1214, 26, 25 )
	RegCurTrigger( 12142 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4741)	
	TriggerAction( 1, AddNextFlag, 1214, 51, 25 )
	RegCurTrigger( 12143 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1486)	
	TriggerAction( 1, AddNextFlag, 1214, 76, 25 )
	RegCurTrigger( 12144 )
  
----------------------------------------------------------奇怪的女佣----------洛克家的男佣
	MISSCRIPT_MISSIONSCRIPT07_LUA_001131 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001131")
	DefineMission( 6143, MISSCRIPT_MISSIONSCRIPT07_LUA_001131, 1215 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001132 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001132")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001132)
				
	MisBeginCondition(NoMission, 1215)
	MisBeginCondition(NoRecord,1215)
	MisBeginCondition(HasRecord, 1214)
	MisBeginAction(AddMission,1215)
	MisCancelAction(ClearMission, 1215)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001133 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001133")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001133)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001134 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001134")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001134)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------奇怪的女佣--------洛克家的女佣
	MISSCRIPT_MISSIONSCRIPT07_LUA_001131 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001131")
	DefineMission(6144, MISSCRIPT_MISSIONSCRIPT07_LUA_001131, 1215, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001135 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001135")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001135)
	MisResultCondition(NoRecord, 1215)
	MisResultCondition(HasMission,1215)
	MisResultAction(ClearMission,1215)
	MisResultAction(SetRecord, 1215)

	---------------------------------------------治疗多嘴的秘方---------洛克家的女佣
	MISSCRIPT_MISSIONSCRIPT07_LUA_001136 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001136")
	DefineMission(6145,MISSCRIPT_MISSIONSCRIPT07_LUA_001136,1216)

      MISSCRIPT_MISSIONSCRIPT07_LUA_001137 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001137")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001137)

      MisBeginCondition(NoRecord,1216)
      MisBeginCondition(NoMission,1216)
      MisBeginCondition(HasRecord, 1215)
      MisBeginAction(AddMission,1216)
      MisBeginAction(AddTrigger, 12161, TE_GETITEM, 4742, 35 )
      MisBeginAction(AddTrigger, 12162, TE_GETITEM, 4743, 35 )          
      MisBeginAction(AddTrigger, 12163, TE_GETITEM, 4745, 35 )                           
	  MisCancelAction(ClearMission, 1216)

      MISSCRIPT_MISSIONSCRIPT07_LUA_001138 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001138")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001138)
      MisNeed(MIS_NEED_ITEM, 4742, 35,  1, 35 )
      MisNeed(MIS_NEED_ITEM, 4743, 35, 36, 35 )
      MisNeed(MIS_NEED_ITEM, 4745, 35,  71, 35 )

      MISSCRIPT_MISSIONSCRIPT07_LUA_001139 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001139")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001139)  
      MISSCRIPT_MISSIONSCRIPT07_LUA_001140 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001140")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001140)
      MisResultCondition(HasMission,1216 )
      MisResultCondition(NoRecord,1216)
      MisResultCondition(HasItem, 4742, 35 )
      MisResultCondition(HasItem, 4743, 35 )
      MisResultCondition(HasItem, 4745, 35 )

        MisResultAction(TakeItem, 4742, 35 )
	MisResultAction(TakeItem, 4743, 35 )
	MisResultAction(TakeItem, 4745, 35 )


      MisResultAction(GiveItem, 3854, 1, 4 )
      MisResultAction(ClearMission, 1216 )
      MisResultAction(SetRecord, 1216)
      MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4742)	
	TriggerAction( 1, AddNextFlag, 1216, 1, 35 )
	RegCurTrigger( 12161 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4743)	
	TriggerAction( 1, AddNextFlag, 1216, 36, 35 )
	RegCurTrigger( 12162 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4745)	
	TriggerAction( 1, AddNextFlag, 1216, 71, 35 )
	RegCurTrigger(12163 )
----------------------------------------------------------洛克家的小秘----------洛克家的女佣
	MISSCRIPT_MISSIONSCRIPT07_LUA_001141 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001141")
	DefineMission( 6146, MISSCRIPT_MISSIONSCRIPT07_LUA_001141, 1217 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001142 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001142")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001142)
				
	MisBeginCondition(NoMission, 1217)
	MisBeginCondition(NoRecord,1217)
	MisBeginCondition(HasRecord, 1216)
	MisBeginAction(AddMission,1217)
	MisCancelAction(ClearMission, 1217)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001143 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001143")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001143)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001144 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001144")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001144)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------洛克家的小秘--------洛克家的小秘
	MISSCRIPT_MISSIONSCRIPT07_LUA_001141 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001141")
	DefineMission(6147, MISSCRIPT_MISSIONSCRIPT07_LUA_001141, 1217, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001145 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001145")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001145)
	MisResultCondition(NoRecord, 1217)
	MisResultCondition(HasMission,1217)
	MisResultAction(ClearMission,1217)
	MisResultAction(SetRecord, 1217)

	--------------------------------------------------------------------小秘的梦想------洛克家的小秘

	MISSCRIPT_MISSIONSCRIPT07_LUA_001146 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001146")
	DefineMission( 6148, MISSCRIPT_MISSIONSCRIPT07_LUA_001146, 1218 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001147 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001147")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001147)
	MisBeginCondition(NoMission, 1218)
	MisBeginCondition(NoRecord,1218)
	MisBeginCondition(HasRecord, 1217)
	MisBeginAction(AddMission,1218)
	MisBeginAction(AddTrigger, 12181, TE_GETITEM, 1501, 20)
	MisBeginAction(AddTrigger, 12182, TE_GETITEM, 1490, 20)
	MisBeginAction(AddTrigger, 12183, TE_GETITEM, 4748, 20)
	MisBeginAction(AddTrigger, 12184, TE_GETITEM, 4749, 20)
	MisBeginAction(AddTrigger, 12185, TE_GETITEM, 4725, 20)
	MisBeginAction(AddTrigger, 12186, TE_GETITEM, 4747, 20)
	MisCancelAction(ClearMission, 1218)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001148 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001148")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001148)
	MisNeed(MIS_NEED_ITEM, 1501, 20, 1, 20)
	MisNeed(MIS_NEED_ITEM, 1490, 20, 21, 20)
	MisNeed(MIS_NEED_ITEM, 4748, 20, 41, 20)
	MisNeed(MIS_NEED_ITEM, 4749, 20, 61, 20)
	MisNeed(MIS_NEED_ITEM, 4725, 20, 81, 20)
	MisNeed(MIS_NEED_ITEM, 4747, 20, 101, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001149 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001149")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001149)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001150 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001150")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001150)

	MisResultCondition(HasMission, 1218)
	MisResultCondition(NoRecord,1218)
	MisResultCondition(HasItem, 1501, 20)
	MisResultCondition(HasItem, 1490, 20)
	MisResultCondition(HasItem, 4748, 20)
	MisResultCondition(HasItem, 4749, 20)
	MisResultCondition(HasItem, 4725, 20)
	MisResultCondition(HasItem, 4747, 20)

	MisResultAction(TakeItem, 1501, 20 )
	MisResultAction(TakeItem, 1490, 20 )
	MisResultAction(TakeItem, 4748, 20 )
	MisResultAction(TakeItem, 4749, 20 )
	MisResultAction(TakeItem, 4725, 20 )
	MisResultAction(TakeItem, 4747, 20 )

	
	MisResultAction(GiveItem, 3858,1,4)------------i
	MisResultAction(ClearMission, 1218)
	MisResultAction(SetRecord, 1218)
	MisResultBagNeed(1)
	


	InitTrigger()
	TriggerCondition( 1, IsItem, 1501)	
	TriggerAction( 1, AddNextFlag, 1218, 1, 20 )
	RegCurTrigger( 12181 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1490)	
	TriggerAction( 1, AddNextFlag, 1218, 21, 20 )
	RegCurTrigger( 12182 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4748)	
	TriggerAction( 1, AddNextFlag, 1218, 41, 20 )
	RegCurTrigger( 12183 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4749)	
	TriggerAction( 1, AddNextFlag, 1218, 61, 20 )
	RegCurTrigger( 12184 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4725)	
	TriggerAction( 1, AddNextFlag, 1218, 81, 20 )
	RegCurTrigger( 12185 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4747)	
	TriggerAction( 1, AddNextFlag, 1218, 101, 20 )
	RegCurTrigger( 12186 )

	----------------------------------------------------------严肃的守护者----------洛克家的小秘
	MISSCRIPT_MISSIONSCRIPT07_LUA_001151 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001151")
	DefineMission( 6149, MISSCRIPT_MISSIONSCRIPT07_LUA_001151, 1219 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001152 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001152")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001152)
				
	MisBeginCondition(NoMission, 1219)
	MisBeginCondition(NoRecord,1219)
	MisBeginCondition(HasRecord, 1218)
	MisBeginAction(AddMission,1219)
	MisCancelAction(ClearMission, 1219)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001153 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001153")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001153)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001154 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001154")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001154)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------严肃的守护者--------洛克家的守护者
	MISSCRIPT_MISSIONSCRIPT07_LUA_001151 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001151")
	DefineMission(6150, MISSCRIPT_MISSIONSCRIPT07_LUA_001151, 1219, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001155 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001155")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001155)
	MisResultCondition(NoRecord, 1219)
	MisResultCondition(HasMission,1219)
	MisResultAction(ClearMission,1219)
	MisResultAction(SetRecord, 1219)

--------------------------------------------------------------------一个人情又一个人情------洛克家的守护者

	MISSCRIPT_MISSIONSCRIPT07_LUA_001156 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001156")
	DefineMission( 6151, MISSCRIPT_MISSIONSCRIPT07_LUA_001156, 1220 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001157 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001157")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001157)
	MisBeginCondition(NoMission, 1220)
	MisBeginCondition(NoRecord,1220)
	MisBeginCondition(HasRecord, 1219)
	MisBeginAction(AddMission,1220)
	MisBeginAction(AddTrigger, 12201, TE_GETITEM, 4750,50)
	MisBeginAction(AddTrigger, 12202, TE_GETITEM, 4763, 50)
	MisCancelAction(ClearMission, 1220)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001158 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001158")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001158)
	MisNeed(MIS_NEED_ITEM, 4750, 50, 1, 50)
	MisNeed(MIS_NEED_ITEM, 4763, 50, 51, 50)


	MISSCRIPT_MISSIONSCRIPT07_LUA_001159 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001159")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001159)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001160 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001160")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001160)

	MisResultCondition(HasMission, 1220)
	MisResultCondition(NoRecord,1220)
	MisResultCondition(HasItem, 4750, 50)
	MisResultCondition(HasItem, 4763,50)
	MisResultAction(TakeItem, 4750, 50 )
	MisResultAction(TakeItem, 4763, 50 )
	
	MisResultAction(GiveItem, 3862,1,4)----------m
	MisResultAction(ClearMission, 1220)
	MisResultAction(SetRecord, 1220)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4750)	
	TriggerAction( 1, AddNextFlag, 1220, 1, 50 )
	RegCurTrigger( 12201 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4763)	
	TriggerAction( 1, AddNextFlag, 1220, 21, 50 )
	RegCurTrigger( 12202 )

----------------------------------------------------------还是一份人情----------洛克家的守护者
	MISSCRIPT_MISSIONSCRIPT07_LUA_001161 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001161")
	DefineMission( 6152, MISSCRIPT_MISSIONSCRIPT07_LUA_001161, 1221 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001162 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001162")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001162)
				
	MisBeginCondition(NoMission, 1221)
	MisBeginCondition(NoRecord,1221)
	MisBeginCondition(HasRecord, 1220)
	MisBeginAction(AddMission,1221)
	MisCancelAction(ClearMission, 1221)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001163 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001163")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001163)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001164 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001164")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001164)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------还是一份人情--------洛克家的管家
	MISSCRIPT_MISSIONSCRIPT07_LUA_001161 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001161")
	DefineMission(6153, MISSCRIPT_MISSIONSCRIPT07_LUA_001161, 1221, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001165 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001165")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001165)
	MisResultCondition(NoRecord, 1221)
	MisResultCondition(HasMission,1221)
	MisResultAction(ClearMission,1221)
	MisResultAction(SetRecord, 1221)


	--------------------------------------------------------------------管家的烦恼------洛克家的管家

	MISSCRIPT_MISSIONSCRIPT07_LUA_001166 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001166")
	DefineMission( 6154, MISSCRIPT_MISSIONSCRIPT07_LUA_001166, 1222 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001167 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001167")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001167)
	MisBeginCondition(NoMission, 1222)
	MisBeginCondition(NoRecord,1222)
	MisBeginCondition(HasRecord, 1221)
	MisBeginAction(AddMission,1222)
	MisBeginAction(AddTrigger, 12221, TE_GETITEM, 4770, 35)
	MisBeginAction(AddTrigger, 12222, TE_GETITEM, 4766, 35)
	MisBeginAction(AddTrigger, 12223, TE_GETITEM, 4772, 35)
	MisCancelAction(ClearMission, 1222)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001168 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001168")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001168)
	MisNeed(MIS_NEED_ITEM, 4770, 35, 1, 35)
	MisNeed(MIS_NEED_ITEM, 4766, 35, 36, 35)
	MisNeed(MIS_NEED_ITEM, 4772, 35, 71, 35)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001169 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001169")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001169)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001170 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001170")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001170)

	MisResultCondition(HasMission, 1222)
	MisResultCondition(NoRecord,1222)
	MisResultCondition(HasItem, 4770, 35)
	MisResultCondition(HasItem, 4766, 35)
	MisResultCondition(HasItem, 4772, 35)

	MisResultAction(TakeItem, 4770, 35 )
	MisResultAction(TakeItem, 4766, 35 )
	MisResultAction(TakeItem, 4772, 35 )
	
	MisResultAction(GiveItem, 3863,1,4)----------n
	MisResultAction(ClearMission, 1222)
	MisResultAction(SetRecord, 1222)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4770)	
	TriggerAction( 1, AddNextFlag, 1222, 1, 35 )
	RegCurTrigger( 12221 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4766)	
	TriggerAction( 1, AddNextFlag, 1222, 36, 35 )
	RegCurTrigger( 12222 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4772)	
	TriggerAction( 1, AddNextFlag, 1222, 71, 35 )
	RegCurTrigger( 12223 )

---------------------------------------------------------管家的报复----------洛克家的管家
	MISSCRIPT_MISSIONSCRIPT07_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001171")
	DefineMission( 6155, MISSCRIPT_MISSIONSCRIPT07_LUA_001171, 1223 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001172 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001172")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001172)
				
	MisBeginCondition(NoMission, 1223)
	MisBeginCondition(NoRecord,1223)
	MisBeginCondition(HasRecord, 1222)
	MisBeginAction(AddMission,1223)
	MisCancelAction(ClearMission, 1223)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001173 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001173")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001173)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001174 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001174")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001174)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------管家的报复--------洛克的情人
	MISSCRIPT_MISSIONSCRIPT07_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001171")
	DefineMission(6156, MISSCRIPT_MISSIONSCRIPT07_LUA_001171, 1223, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001175 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001175")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001175)
	MisResultCondition(NoRecord, 1223)
	MisResultCondition(HasMission,1223)
	MisResultAction(ClearMission,1223)
	MisResultAction(SetRecord, 1223)
--------------------------------------------------------------------美女的奇特爱好------洛克的情人

	MISSCRIPT_MISSIONSCRIPT07_LUA_001176 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001176")
	DefineMission( 6157, MISSCRIPT_MISSIONSCRIPT07_LUA_001176, 1224 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001177 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001177")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001177)
	MisBeginCondition(NoMission, 1224)
	MisBeginCondition(NoRecord,1224)
	MisBeginCondition(HasRecord, 1223)
	MisBeginAction(AddMission,1224)
	MisBeginAction(AddTrigger, 12241, TE_GETITEM, 1503, 110)
	MisCancelAction(ClearMission, 1224)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001178 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001178")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001178)
	MisNeed(MIS_NEED_ITEM, 1503, 110, 1, 110)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001179 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001179")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001179)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001180")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001180)

	MisResultCondition(HasMission, 1224)
	MisResultCondition(NoRecord,1224)
	MisResultCondition(HasItem, 1503, 110)
	MisResultAction(TakeItem, 1503, 110 )

	MisResultAction(GiveItem, 3856,1,4)----------G
	MisResultAction(ClearMission, 1224)
	MisResultAction(SetRecord, 1224)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1503)	
	TriggerAction( 1, AddNextFlag, 1224, 1, 110 )
	RegCurTrigger( 12241 )

------------------------------------------------------赌气的旺财----------洛克的情人
	MISSCRIPT_MISSIONSCRIPT07_LUA_001181 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001181")
	DefineMission( 6158, MISSCRIPT_MISSIONSCRIPT07_LUA_001181, 1225 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001182 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001182")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001182)
				
	MisBeginCondition(NoMission, 1225)
	MisBeginCondition(NoRecord,1225)
	MisBeginCondition(HasRecord, 1224)
	MisBeginAction(AddMission,1225)
	MisCancelAction(ClearMission, 1225)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001183 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001183")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001183)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001184 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001184")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001184)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------赌气的旺财--------洛克家的旺财
	MISSCRIPT_MISSIONSCRIPT07_LUA_001181 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001181")
	DefineMission(6159, MISSCRIPT_MISSIONSCRIPT07_LUA_001181, 1225, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001185")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001185)
	MisResultCondition(NoRecord, 1225)
	MisResultCondition(HasMission,1225)
	MisResultAction(ClearMission,1225)
	MisResultAction(SetRecord, 1225)


	--------------------------------------------------------------------旺财也不是好惹的------洛克家的旺财

	MISSCRIPT_MISSIONSCRIPT07_LUA_001186 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001186")
	DefineMission( 6160, MISSCRIPT_MISSIONSCRIPT07_LUA_001186, 1226 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001187 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001187")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001187)
	MisBeginCondition(NoMission, 1226)
	MisBeginCondition(NoRecord,1226)
	MisBeginCondition(HasRecord, 1225)
	MisBeginAction(AddMission,1226)
	MisBeginAction(AddTrigger, 12261, TE_GETITEM, 4884, 99)
	MisCancelAction(ClearMission, 1226)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001188 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001188")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001188)
	MisNeed(MIS_NEED_ITEM, 4884, 99, 1, 99)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001189 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001189")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001189)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001190 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001190")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001190)

	MisResultCondition(HasMission, 1226)
	MisResultCondition(NoRecord,1226)
	MisResultCondition(HasItem, 4884, 99)
	MisResultAction(TakeItem, 4884, 99 )

	MisResultAction(GiveItem, 3854,1,4)----------E
	MisResultAction(ClearMission, 1226)
	MisResultAction(SetRecord, 1226)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4884)	
	TriggerAction( 1, AddNextFlag, 1226, 1, 99 )
	RegCurTrigger( 12261 )


-----------------------------------------------------哦!没钥匙----------魔法师夏天
	MISSCRIPT_MISSIONSCRIPT07_LUA_001191 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001191")
	DefineMission( 6161, MISSCRIPT_MISSIONSCRIPT07_LUA_001191, 1227 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001192 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001192")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001192)
				
	MisBeginCondition(NoMission, 1227)
	MisBeginCondition(NoRecord,1227)
	MisBeginCondition(HasRecord, 1212)
	MisBeginAction(AddMission,1227)
	MisCancelAction(ClearMission, 1227)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001193 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001193")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001193)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001194 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001194")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001194)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------哦!没钥匙--------秋岛导游小姐
	MISSCRIPT_MISSIONSCRIPT07_LUA_001191 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001191")
	DefineMission(6162, MISSCRIPT_MISSIONSCRIPT07_LUA_001191, 1227, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001195 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001195")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001195)
	MisResultCondition(NoRecord, 1227)
	MisResultCondition(HasMission,1227)
	MisResultAction(ClearMission,1227)
	MisResultAction(SetRecord, 1227)



	--------------------------------------------------------------------导游小姐的请求------秋岛导游小姐

	MISSCRIPT_MISSIONSCRIPT07_LUA_001196 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001196")
	DefineMission( 6163, MISSCRIPT_MISSIONSCRIPT07_LUA_001196, 1228 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001197")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001197)
	MisBeginCondition(NoMission, 1228)
	MisBeginCondition(NoRecord,1228)
	MisBeginCondition(HasRecord, 1227)
	MisBeginAction(AddMission,1228)
	MisBeginAction(AddTrigger, 12281, TE_GETITEM, 0154, 20)
	MisBeginAction(AddTrigger, 12282, TE_GETITEM, 0156, 20)
	MisBeginAction(AddTrigger, 12283, TE_GETITEM, 0158, 20)
	MisCancelAction(ClearMission, 1228)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001198 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001198")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001198)
	MisNeed(MIS_NEED_ITEM, 0154, 20, 1, 20)
	MisNeed(MIS_NEED_ITEM, 0156, 20, 21, 20)
	MisNeed(MIS_NEED_ITEM, 0158, 20, 41, 20)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001199 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001199")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001199)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001200 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001200")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001200)

	MisResultCondition(HasMission, 1228)
	MisResultCondition(NoRecord,1228)
	MisResultCondition(HasItem, 0154, 20)
	MisResultCondition(HasItem, 0156, 20)
	MisResultCondition(HasItem, 0158, 20)

	MisResultAction(TakeItem, 0154, 20 )
	MisResultAction(TakeItem, 0156, 20 )
	MisResultAction(TakeItem, 0158, 20 )
	
	MisResultAction(ClearMission, 1228)
	MisResultAction(SetRecord, 1228)

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0154)	
	TriggerAction( 1, AddNextFlag, 1228, 1, 20 )
	RegCurTrigger( 12281 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0156)	
	TriggerAction( 1, AddNextFlag, 1228, 36, 20 )
	RegCurTrigger( 12282 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 0158)	
	TriggerAction( 1, AddNextFlag, 1228, 71, 20 )
	RegCurTrigger( 12283 )


		--------------------------------------------------------------------告慰亡灵------秋岛导游小姐

	MISSCRIPT_MISSIONSCRIPT07_LUA_001201 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001201")
	DefineMission( 6164, MISSCRIPT_MISSIONSCRIPT07_LUA_001201, 1229 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001202 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001202")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001202)
	MisBeginCondition(NoMission, 1229)
	MisBeginCondition(NoRecord,1229)
	MisBeginCondition(HasRecord, 1228)
	MisBeginAction(AddMission,1229)
	MisBeginAction(AddTrigger, 12291, TE_GETITEM, 3436, 50)
	MisBeginAction(AddTrigger, 12292, TE_GETITEM, 3434, 50)
	MisCancelAction(ClearMission, 1229)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001203 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001203")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001203)
	MisNeed(MIS_NEED_ITEM, 3436, 50, 1, 50)
	MisNeed(MIS_NEED_ITEM, 3434, 50, 51, 50)


	MISSCRIPT_MISSIONSCRIPT07_LUA_001204 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001204")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001204)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001205 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001205")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001205)

	MisResultCondition(HasMission, 1229)
	MisResultCondition(NoRecord,1229)
	MisResultCondition(HasItem, 3436, 50)
	MisResultCondition(HasItem, 3434, 50)

	MisResultAction(TakeItem, 3436, 50 )
	MisResultAction(TakeItem, 3434, 50 )

	MisResultAction(GiveItem, 3674,1,4)----------钥匙
	MisResultAction(ClearMission, 1229)
	MisResultAction(SetRecord, 1229)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3436)	
	TriggerAction( 1, AddNextFlag, 1229, 1, 50 )
	RegCurTrigger( 12291 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3434)	
	TriggerAction( 1, AddNextFlag, 1229, 51, 50 )
	RegCurTrigger( 12292 )

----------------------------------------------------一把钥匙开一把锁---------秋岛导游小姐
	MISSCRIPT_MISSIONSCRIPT07_LUA_001206 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001206")
	DefineMission( 6165, MISSCRIPT_MISSIONSCRIPT07_LUA_001206, 1230 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001207 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001207")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001207)
				
	MisBeginCondition(NoMission, 1230)
	MisBeginCondition(NoRecord,1230)
	MisBeginCondition(HasRecord, 1229)
	MisBeginAction(AddMission,1230)
	MisCancelAction(ClearMission, 1230)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001208 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001208")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001208)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001209 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001209")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001209)
	MisResultCondition(AlwaysFailure)	
	-----------------------------------------一把钥匙开一把锁---------魔法师夏天
	MISSCRIPT_MISSIONSCRIPT07_LUA_001206 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001206")
	DefineMission(6166, MISSCRIPT_MISSIONSCRIPT07_LUA_001206, 1230, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001210 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001210")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001210)
	MisResultCondition(NoRecord, 1230)
	MisResultCondition(HasMission,1230)
	MisResultCondition(HasItem, 3673, 1)
	MisResultCondition(HasItem, 3674, 1)
	MisResultAction(TakeItem, 3673, 1 )
	MisResultAction(TakeItem, 3674, 1 )
	MisResultAction(GiveItem, 3672,1,4)----------黑匣子
	MisResultAction(ClearMission,1230)
	MisResultAction(SetRecord, 1230)
	MisResultBagNeed(1)

	MisResultAction(ClearRecord, 1212)---------------可以反复接
	MisResultAction(ClearRecord, 1213)---------------可以反复接
	MisResultAction(ClearRecord, 1214)---------------可以反复接
	MisResultAction(ClearRecord, 1215)---------------可以反复接
	MisResultAction(ClearRecord, 1216)---------------可以反复接
	MisResultAction(ClearRecord, 1217)---------------可以反复接
	MisResultAction(ClearRecord, 1218)---------------可以反复接
	MisResultAction(ClearRecord, 1219)---------------可以反复接
	MisResultAction(ClearRecord, 1220)---------------可以反复接
	MisResultAction(ClearRecord, 1221)---------------可以反复接
	MisResultAction(ClearRecord, 1222)---------------可以反复接
	MisResultAction(ClearRecord, 1223)---------------可以反复接
	MisResultAction(ClearRecord, 1224)---------------可以反复接
	MisResultAction(ClearRecord, 1225)---------------可以反复接
	MisResultAction(ClearRecord, 1226)---------------可以反复接
	MisResultAction(ClearRecord, 1227)---------------可以反复接
	MisResultAction(ClearRecord, 1228)---------------可以反复接
	MisResultAction(ClearRecord, 1229)---------------可以反复接
	MisResultAction(ClearRecord, 1230)---------------可以反复接


--------------------------------------------------------勇者的足迹	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001211 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001211")
	DefineMission( 6167, MISSCRIPT_MISSIONSCRIPT07_LUA_001211, 1231)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001212 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001212")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001212)
	MisBeginCondition( LvCheck, ">", 44)
	MisBeginCondition( LvCheck, "<", 66)
	MisBeginCondition( NoMission, 1231)
	MisBeginCondition( NoRecord, 1231)
	MisBeginAction( AddMission, 1231)
	MisBeginAction( AddTrigger, 12311, TE_KILL, 514, 30 )
	MisCancelAction(ClearMission, 1231)

	MisNeed(MIS_NEED_KILL, 514, 30, 10, 30)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001213 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001213")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001213)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001214 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001214")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001214)
	MisResultCondition( HasFlag, 1231, 39 )
	MisResultCondition( HasMission, 1231)
	MisResultCondition( NoRecord, 1231)
	MisResultAction( ClearMission, 1231)
	MisResultAction( SetRecord, 1231)
	MisResultAction( AddExpPer, 1)
	MisResultAction( AddMoney, 1000)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 514 )	
	TriggerAction( 1, AddNextFlag, 1231, 10, 30 )
	RegCurTrigger(12311)

	----------------------------------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001211 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001211")
	DefineMission( 6168, MISSCRIPT_MISSIONSCRIPT07_LUA_001211, 1232)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001215 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001215")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001215)
	MisBeginCondition( NoMission, 1232)
	MisBeginCondition( NoRecord, 1232)
	MisBeginCondition( HasRecord, 1231)
	MisBeginAction( AddMission, 1232)
	MisBeginAction( AddTrigger, 12321, TE_KILL, 284, 50 )
	MisCancelAction( ClearMission, 1232)

	MisNeed( MIS_NEED_KILL, 284, 50, 10, 50)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001216 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001216")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001216)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001217 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001217")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001217)
	MisResultCondition( HasMission, 1232)
	MisResultCondition( NoRecord, 1232)
	MisResultCondition( HasFlag, 1232, 59)
	MisResultAction( ClearMission, 1232)
	MisResultAction( SetRecord, 1232)
	MisResultAction( AddExpPer, 1)
	MisResultAction( AddMoney, 3000)

	InitTrigger() 
	TriggerCondition( 1, IsMonster, 284 )	
	TriggerAction( 1, AddNextFlag, 1232, 10, 50 )
	RegCurTrigger(12321)

	----------------------------------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001211 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001211")
	DefineMission( 6169, MISSCRIPT_MISSIONSCRIPT07_LUA_001211, 1233)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001218 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001218")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001218)
	MisBeginCondition( NoMission, 1233)
	MisBeginCondition( NoRecord, 1233)
	MisBeginCondition( HasRecord, 1232)
	MisBeginAction( AddMission, 1233)
	MisBeginAction( AddTrigger, 12331, TE_KILL, 65, 10 )
	MisBeginAction( AddTrigger, 12332, TE_GETITEM, 1783, 50)
	MisCancelAction( ClearMission, 1233)

	MisNeed( MIS_NEED_KILL, 65, 10, 10, 10)
	MisNeed( MIS_NEED_ITEM, 1783, 50, 20, 50)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001219 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001219")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001219)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001220 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001220")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001220)
	MisResultCondition( HasMission, 1233)
	MisResultCondition( NoRecord, 1233)
	MisResultCondition( HasFlag, 1233, 19)
	MisResultCondition( HasItem, 1783, 50)
	MisResultAction( TakeItem, 1783, 50)
	MisResultAction( ClearMission, 1233)
	MisResultAction( SetRecord, 1233)
	MisResultAction( AddExpPer, 1)
	MisResultAction( AddMoney , 5000)
	MisResultAction( AddExpAndType, 2, 80000, 80000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 65)
	TriggerAction(1, AddNextFlag, 1233, 10, 10)
	RegCurTrigger(12331)

	InitTrigger()
	TriggerCondition(1, IsItem, 1783)
	TriggerAction(1, AddNextFlag, 1233, 20, 50)
	RegCurTrigger(12332)

	----------------------------------------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001221 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001221")
	DefineMission( 6170, MISSCRIPT_MISSIONSCRIPT07_LUA_001221, 1234)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001222 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001222")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001222)
	MisBeginCondition( NoMission, 1234)
	MisBeginCondition( NoRecord, 1234)
	MisBeginCondition( HasRecord, 1233)
	MisBeginAction( AddMission, 1234)
	MisBeginAction( GiveItem, 2671, 1, 4)
	MisBeginAction( AddTrigger, 12341, TE_GETITEM, 2671, 1)
	MisBeginAction( AddTrigger, 12342, TE_GETITEM, 4503, 1)
	MisBeginAction( AddTrigger, 12343, TE_GETITEM, 3361, 89)
	MisCancelAction( ClearMission, 1234)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001223 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001223")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001223)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001224 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001224")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001224)
	MisNeed( MIS_NEED_ITEM, 2671, 1, 10, 1)
	MisNeed( MIS_NEED_ITEM, 4503, 1, 20, 1)
	MisNeed( MIS_NEED_ITEM, 3361, 89, 30, 89)

	MisResultCondition( AlwaysFailure )
	---------------------------------------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001221 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001221")
	DefineMission( 6171, MISSCRIPT_MISSIONSCRIPT07_LUA_001221, 1234, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001225 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001225")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001225)
	MisResultCondition( HasItem, 2671, 1)
	MisResultCondition( HasItem, 4503, 1)
	MisResultCondition( HasItem, 3361, 89)
	MisResultCondition( HasMission, 1234)
	MisResultCondition( NoRecord, 1234)
	MisResultAction( TakeItem, 2671, 1)
	MisResultAction( TakeItem, 4503, 1)
	MisResultAction( TakeItem, 3361, 89)
	MisResultAction( ClearMission, 1234)
	MisResultAction( SetRecord, 1234)
	MisResultAction( AddExpPer, 2)
	MisResultAction( AddMoney, 300000)
	MisResultAction( AddReadingBook )                       ------给予本职业的初级读物

	InitTrigger()
	TriggerCondition(1, IsItem, 2671)
	TriggerAction(1, AddNextFlag, 1234, 10, 1)
	RegCurTrigger(12341)

	InitTrigger()
	TriggerCondition(1, IsItem, 4503)
	TriggerAction(1, AddNextFlag, 1234, 20, 1)
	RegCurTrigger(12342)

	InitTrigger()
	TriggerCondition(1, IsItem, 3361)
	TriggerAction(1, AddNextFlag, 1234, 30, 89)
	RegCurTrigger(12343)


	-------------------------------------------------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001221 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001221")
	DefineMission( 6172, MISSCRIPT_MISSIONSCRIPT07_LUA_001221, 1235)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001226 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001226")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001226)
	MisBeginCondition( NoMission, 1235)
	MisBeginCondition( NoRecord, 1235)
	MisBeginCondition( HasRecord, 1234)
	MisBeginAction( AddMission, 1235)
	MisCancelAction( ClearMission, 1235)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001227 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001227")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001227)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001228")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001228)

	MisResultCondition( AlwaysFailure )
	--------------------------------------------------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001221 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001221")
	DefineMission( 6173, MISSCRIPT_MISSIONSCRIPT07_LUA_001221, 1235, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001229 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001229")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001229)
	MisResultCondition( HasMission, 1235)
	MisResultCondition( NoRecord, 1235)
	MisResultAction( ClearMission, 1235)
	MisResultAction( SetRecord, 1235)
	MisResultAction( AddMoney, 88)

	MisResultAction(ClearRecord, 1231)---------------可以反复接
	MisResultAction(ClearRecord, 1232)---------------可以反复接
	MisResultAction(ClearRecord, 1233)---------------可以反复接
	MisResultAction(ClearRecord, 1234)---------------可以反复接
	MisResultAction(ClearRecord, 1235)---------------可以反复接

	-------------------------------四季发财----------客栈老板·龙女
	MISSCRIPT_MISSIONSCRIPT07_LUA_001230 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001230")
	DefineMission( 6174, MISSCRIPT_MISSIONSCRIPT07_LUA_001230, 1236)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001231 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001231")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001231)
	MisBeginCondition( NoMission, 1236)
	MisBeginCondition( NoRecord, 1236)
	MisBeginCondition( LvCheck, "<", 80)
	MisBeginAction( AddMission, 1236)
	MisBeginAction( AddTrigger, 12361, TE_GETITEM, 2969, 1)
	MisBeginAction( AddTrigger, 12362, TE_GETITEM, 2970, 1)
	MisBeginAction( AddTrigger, 12363, TE_GETITEM, 2971, 1)
	MisBeginAction( AddTrigger, 12364, TE_GETITEM, 2972, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001232 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001232")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001232)
	MisNeed( MIS_NEED_ITEM, 2969, 1, 10, 1)
	MisNeed( MIS_NEED_ITEM, 2970, 1, 20, 1)
	MisNeed( MIS_NEED_ITEM, 2971, 1, 30, 1)
	MisNeed( MIS_NEED_ITEM, 2972, 1, 40, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001233 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001233")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001233)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001234 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001234")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001234)
	MisResultCondition( HasMission, 1236)
	MisResultCondition( NoRecord, 1236)
	MisResultCondition( HasItem, 2969, 1)
	MisResultCondition( HasItem, 2970, 1)
	MisResultCondition( HasItem, 2971, 1)
	MisResultCondition( HasItem, 2972, 1)
	MisResultAction( TakeItem, 2969, 1)
	MisResultAction( TakeItem, 2970, 1)
	MisResultAction( TakeItem, 2971, 1)
	MisResultAction( TakeItem, 2972, 1)
	MisResultAction( ClearMission, 1236)
	MisResultAction( SetRecord, 1236)
	MisResultAction( AddExpNextLv1 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2969)	
	TriggerAction( 1, AddNextFlag, 1236, 10, 1 )
	RegCurTrigger( 12361 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2970)	
	TriggerAction( 1, AddNextFlag, 1236, 20, 1 )
	RegCurTrigger( 12362 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2971)	
	TriggerAction( 1, AddNextFlag, 1236, 30, 1 )
	RegCurTrigger( 12363 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2972)	
	TriggerAction( 1, AddNextFlag, 1236, 40, 1 )
	RegCurTrigger( 12364 )

---------------------------------八方进宝------------客栈老板·龙女
	MISSCRIPT_MISSIONSCRIPT07_LUA_001235 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001235")
	DefineMission( 6175, MISSCRIPT_MISSIONSCRIPT07_LUA_001235, 1237)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001236 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001236")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001236)
	MisBeginCondition( NoMission, 1237)
	MisBeginCondition( NoRecord, 1237)
	MisBeginCondition( LvCheck, "<", 90)
	MisBeginAction( AddMission, 1237)
	MisBeginAction( AddTrigger, 12371, TE_GETITEM, 2969, 1)
	MisBeginAction( AddTrigger, 12372, TE_GETITEM, 2970, 1)
	MisBeginAction( AddTrigger, 12373, TE_GETITEM, 2971, 1)
	MisBeginAction( AddTrigger, 12374, TE_GETITEM, 2972, 1)
	MisBeginAction( AddTrigger, 12375, TE_GETITEM, 2973, 1)
	MisBeginAction( AddTrigger, 12376, TE_GETITEM, 2974, 1)
	MisBeginAction( AddTrigger, 12377, TE_GETITEM, 2975, 1)
	MisBeginAction( AddTrigger, 12378, TE_GETITEM, 2976, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001237 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001237")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001237)
	MisNeed( MIS_NEED_ITEM, 2969, 1, 10, 1)
	MisNeed( MIS_NEED_ITEM, 2970, 1, 20, 1)
	MisNeed( MIS_NEED_ITEM, 2971, 1, 30, 1)
	MisNeed( MIS_NEED_ITEM, 2972, 1, 40, 1)
	MisNeed( MIS_NEED_ITEM, 2973, 1, 50, 1)
	MisNeed( MIS_NEED_ITEM, 2974, 1, 60, 1)
	MisNeed( MIS_NEED_ITEM, 2975, 1, 70, 1)
	MisNeed( MIS_NEED_ITEM, 2976, 1, 80, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001238 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001238")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001238)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001239 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001239")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001239)
	MisResultCondition( HasMission, 1237)
	MisResultCondition( NoRecord, 1237)
	MisResultCondition( HasItem, 2969, 1)
	MisResultCondition( HasItem, 2970, 1)
	MisResultCondition( HasItem, 2971, 1)
	MisResultCondition( HasItem, 2972, 1)
	MisResultCondition( HasItem, 2973, 1)
	MisResultCondition( HasItem, 2974, 1)
	MisResultCondition( HasItem, 2975, 1)
	MisResultCondition( HasItem, 2976, 1)
	MisResultAction( TakeItem, 2969, 1)
	MisResultAction( TakeItem, 2970, 1)
	MisResultAction( TakeItem, 2971, 1)
	MisResultAction( TakeItem, 2972, 1)
	MisResultAction( TakeItem, 2973, 1)
	MisResultAction( TakeItem, 2974, 1)
	MisResultAction( TakeItem, 2975, 1)
	MisResultAction( TakeItem, 2976, 1)
	MisResultAction( ClearMission, 1237)
	MisResultAction( SetRecord, 1237)
	MisResultAction( AddExpNextLv2 )
	MisResultAction(ClearRecord, 1236)---------------可以反复接
	MisResultAction(ClearRecord, 1237)---------------可以反复接
	MisResultAction(ClearRecord, 1238)---------------可以反复接
	MisResultAction(ClearRecord, 1239)---------------可以反复接
	MisResultAction(ClearRecord, 1240)---------------可以反复接
	MisResultAction(ClearRecord, 1241)---------------可以反复接
	MisResultAction(ClearRecord, 1242)---------------可以反复接
	MisResultAction(ClearRecord, 1243)---------------可以反复接
	MisResultAction(ClearRecord, 1244)---------------可以反复接
	MisResultAction(ClearRecord, 1245)---------------可以反复接
	MisResultAction(ClearRecord, 1246)---------------可以反复接

	InitTrigger()
	TriggerCondition( 1, IsItem, 2969)	
	TriggerAction( 1, AddNextFlag, 1237, 10, 1 )
	RegCurTrigger( 12371 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2970)	
	TriggerAction( 1, AddNextFlag, 1237, 20, 1 )
	RegCurTrigger( 12372 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2971)	
	TriggerAction( 1, AddNextFlag, 1237, 30, 1 )
	RegCurTrigger( 12373 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2972)	
	TriggerAction( 1, AddNextFlag, 1237, 40, 1 )
	RegCurTrigger( 12374 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2973)	
	TriggerAction( 1, AddNextFlag, 1237, 50, 1 )
	RegCurTrigger( 12375 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2974)	
	TriggerAction( 1, AddNextFlag, 1237, 60, 1 )
	RegCurTrigger( 12376 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2975)	
	TriggerAction( 1, AddNextFlag, 1237, 70, 1 )
	RegCurTrigger( 12377 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2976)	
	TriggerAction( 1, AddNextFlag, 1237,80, 1 )
	RegCurTrigger( 12378 )

----------------------------------心之锁----------西门庆
	MISSCRIPT_MISSIONSCRIPT07_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001240")
	DefineMission( 6176, MISSCRIPT_MISSIONSCRIPT07_LUA_001240, 1238)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001241 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001241")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001241)
	MisBeginCondition( NoMission, 1238)
	MisBeginCondition( NoRecord, 1238)
	MisBeginCondition( HasMission, 1237)
	MisBeginAction( AddMission, 1238)
	MisBeginAction( AddTrigger, 12381, TE_GETITEM, 2965, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001242 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001242")
	MisNeed( MIS_NEED_DESP,MISSCRIPT_MISSIONSCRIPT07_LUA_001242)
	MisNeed( MIS_NEED_ITEM, 2965, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001243 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001243")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001243)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001244 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001244")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001244)
	MisResultCondition( HasMission, 1238)
	MisResultCondition( NoRecord, 1238)
	MisResultCondition( HasItem, 2965, 1)
	MisResultAction( TakeItem, 2965, 1)
	MisResultAction( ClearMission, 1238)
	MisResultAction( SetRecord, 1238)
	MisResultAction( GiveItem, 2974, 1, 4)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition( 1, IsItem, 2965)	
	TriggerAction( 1, AddNextFlag, 1238, 10, 1 )
	RegCurTrigger( 12381 )

----------------------------------心之锁----------沙岚城大使·席巴
	MISSCRIPT_MISSIONSCRIPT07_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001240")
	DefineMission( 6177, MISSCRIPT_MISSIONSCRIPT07_LUA_001240, 1239)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001245 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001245")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001245)
	MisBeginCondition( HasMission, 1238)
	MisBeginCondition( NoRecord, 1239)
	MisBeginCondition( NoMission, 1239)
	MisBeginAction( AddMission, 1239)
	MisBeginAction( AddTrigger, 12391, TE_GETITEM, 3362, 2)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001246 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001246")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001246)
	MisNeed( MIS_NEED_ITEM, 3362, 2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001247 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001247")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001247)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001248 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001248")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001248)
	MisResultCondition( HasMission, 1239)
	MisResultCondition( NoRecord, 1239)
	MisResultCondition( HasItem, 3362, 2)
	MisResultAction( TakeItem, 3362, 2)
	MisResultAction( ClearMission, 1239)
	MisResultAction( SetRecord, 1239)
	MisResultAction( GiveItem, 2965, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3362)	
	TriggerAction( 1, AddNextFlag, 1239, 10, 2 )
	RegCurTrigger( 12391 )
	
---------------------------------陈年的红酒-----------西门庆
	MISSCRIPT_MISSIONSCRIPT07_LUA_001249 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001249")
	DefineMission( 6178, MISSCRIPT_MISSIONSCRIPT07_LUA_001249, 1240)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001250 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001250")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001250)
	MisBeginCondition( NoMission, 1240)
	MisBeginCondition( NoRecord, 1240)
	MisBeginCondition( HasMission, 1237)
	MisBeginCondition( HasRecord, 1238)
	MisBeginAction( AddMission, 1240)
	MisBeginAction( AddTrigger, 12401, TE_GETITEM, 2977, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001251 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001251")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001251)
	MisNeed( MIS_NEED_ITEM, 2977, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001252 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001252")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001252)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001253 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001253")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001253)
	MisResultCondition( HasMission, 1240)
	MisResultCondition( NoRecord, 1240)
	MisResultCondition( HasItem, 2977, 1)
	MisResultAction( TakeItem, 2977, 1)
	MisResultAction( ClearMission, 1240)
	MisResultAction( SetRecord, 1240)
	MisResultAction( GiveItem, 2976, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2977)	
	TriggerAction( 1, AddNextFlag, 1240, 10, 1 )
	RegCurTrigger( 12401 )

---------------------------------陈年的红酒------------旅店老板·约瑟夫
	MISSCRIPT_MISSIONSCRIPT07_LUA_001249 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001249")
	DefineMission( 6179, MISSCRIPT_MISSIONSCRIPT07_LUA_001249, 1241)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001254 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001254")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001254)
	MisBeginCondition( NoMission, 1241)
	MisBeginCondition( NoRecord, 1241)
	MisBeginCondition( HasMission, 1240)
	MisBeginAction( AddMission, 1241)
	
	MisBeginAction( AddTrigger, 12411, TE_GETITEM, 0172, 3)
	MisBeginAction( AddTrigger, 12412, TE_GETITEM, 0173, 3)
	MisBeginAction( AddTrigger, 12413, TE_GETITEM, 0174, 3)
	MisBeginAction( AddTrigger, 12414, TE_GETITEM, 3916, 70)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001255 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001255")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001255)
	
	MisNeed( MIS_NEED_ITEM, 0172, 3, 5, 3)
	MisNeed( MIS_NEED_ITEM, 0173, 3, 10, 3)
	MisNeed( MIS_NEED_ITEM, 0174, 3, 15, 3)
	MisNeed( MIS_NEED_ITEM, 3916, 70, 20, 70)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001256 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001256")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001256)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001257 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001257")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001257)
	MisResultCondition( HasMission, 1241)
	MisResultCondition( NoRecord, 1241)
	MisResultCondition( HasItem, 3916, 70)
	MisResultCondition( HasItem, 172, 3)
	MisResultCondition( HasItem, 173, 3)
	MisResultCondition( HasItem, 174, 3)
	MisResultAction( TakeItem, 3916, 70)
	MisResultAction( TakeItem, 172, 3)
	MisResultAction( TakeItem, 173, 3)
	MisResultAction( TakeItem, 174, 3)
	MisResultAction( ClearMission, 1241)
	MisResultAction( SetRecord, 1241)



	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0172)	
	TriggerAction( 1, AddNextFlag, 1241, 5, 3 )
	RegCurTrigger( 12411 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 0173)	
	TriggerAction( 1, AddNextFlag, 1241, 10, 3)
	RegCurTrigger( 12412 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 0174)	
	TriggerAction( 1, AddNextFlag, 1241, 15, 3 )
	RegCurTrigger( 12413 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3916)	
	TriggerAction( 1, AddNextFlag, 1241, 20, 70 )
	RegCurTrigger( 12414 )
	
	
--------------------------------陈年的红酒------------旅店老板·约瑟夫
	MISSCRIPT_MISSIONSCRIPT07_LUA_001249 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001249")
	DefineMission( 6180, MISSCRIPT_MISSIONSCRIPT07_LUA_001249, 1242)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001258 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001258")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001258)
	MisBeginCondition( NoMission, 1242)
	MisBeginCondition( NoRecord, 1242)
	MisBeginCondition( HasRecord, 1241)
	MisBeginAction( AddMission, 1242)
	MisBeginAction( AddChaHJ )--------耐久为1440
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001259 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001259")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001259)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001260 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001260")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001260)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001261 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001261")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001261)
	MisResultCondition( CheckHJ )-----1分钟扣1点,扣到0
	MisResultCondition( NoRecord, 1242)
	MisResultCondition( HasMission, 1242)
	MisResultAction( ClearMission, 1242)
	MisResultAction( SetRecord, 1242)
	MisResultAction( TakeItem, 2967, 1)
	MisResultAction( GiveItem, 2977, 1, 4)
	MisResultBagNeed(1)

----------------------------------找回玫瑰花瓣-------------西门庆
	MISSCRIPT_MISSIONSCRIPT07_LUA_001262 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001262")
	DefineMission( 6181, MISSCRIPT_MISSIONSCRIPT07_LUA_001262, 1243)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001263 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001263")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001263)
	MisBeginCondition( NoMission, 1243)
	MisBeginCondition( NoRecord, 1243)
	MisBeginCondition( HasMission, 1237)
	MisBeginCondition( HasRecord, 1238)
	MisBeginCondition( HasRecord, 1240)
	MisBeginAction( AddMission, 1243)
	MisBeginAction( AddTrigger, 12431, TE_GETITEM, 2968, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001264 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001264")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001264)
	MisNeed( MIS_NEED_ITEM, 2968, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001265 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001265")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001265)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001266 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001266")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001266)
	MisResultCondition( HasMission, 1243)
	MisResultCondition( NoRecord, 1243)
	MisResultCondition( HasItem, 2968, 1)
	MisResultAction( ClearMission, 1243)
	MisResultAction( SetRecord, 1243)
	MisResultAction( TakeItem, 2968, 1)
	MisResultAction( GiveItem, 2973, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2968)	
	TriggerAction( 1, AddNextFlag, 1243, 10, 1 )
	RegCurTrigger( 12431 )

----------------------------------找回玫瑰花瓣-------------米歇尔梅林芬
	MISSCRIPT_MISSIONSCRIPT07_LUA_001262 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001262")
	DefineMission( 6182, MISSCRIPT_MISSIONSCRIPT07_LUA_001262, 1244)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001267 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001267")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001267)
	MisBeginCondition( NoMission, 1244)
	MisBeginCondition( NoRecord, 1244)
	MisBeginCondition( HasMission, 1243)
	MisBeginAction( AddMission, 1244)
	MisBeginAction( AddTrigger, 12441, TE_GETITEM, 4259, 3)
	MisBeginAction( AddTrigger, 12442, TE_GETITEM, 1774, 3)
	MisBeginAction( AddTrigger, 12443, TE_GETITEM, 1632, 3)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001268 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001268")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001268)
	MisNeed( MIS_NEED_ITEM, 4259, 3, 10, 3)
	MisNeed( MIS_NEED_ITEM, 1774, 3, 20, 3)
	MisNeed( MIS_NEED_ITEM, 1632, 3, 30, 3)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001269 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001269")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001269)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001270 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001270")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001270)
	MisResultCondition( HasMission, 1244)
	MisResultCondition( NoRecord, 1244)
	MisResultCondition( HasItem, 4259, 3)
	MisResultCondition( HasItem, 1774, 3)
	MisResultCondition( HasItem, 1632, 3)
	MisResultAction( TakeItem, 4259, 3)
	MisResultAction( TakeItem, 1774, 3)
	MisResultAction( TakeItem, 1632, 3)
	MisResultAction( SetRecord, 1244)
	MisResultAction( ClearMission, 1244)
	MisResultAction( GiveItem, 2968, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4259)	
	TriggerAction( 1, AddNextFlag, 1244, 10, 3 )
	RegCurTrigger( 12441 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1774)	
	TriggerAction( 1, AddNextFlag, 1244, 10, 1 )
	RegCurTrigger( 12442 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1632)	
	TriggerAction( 1, AddNextFlag, 1244, 10, 1 )
	RegCurTrigger( 12443 )

---------------------------------找回精美的蜡烛-----------西门庆
	MISSCRIPT_MISSIONSCRIPT07_LUA_001271 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001271")
	DefineMission( 6183, MISSCRIPT_MISSIONSCRIPT07_LUA_001271, 1245)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001272 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001272")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001272)
	MisBeginCondition( NoMission, 1245)
	MisBeginCondition( NoRecord, 1245)
	MisBeginCondition( HasMission, 1237)
	MisBeginCondition( HasRecord, 1238)
	MisBeginCondition( HasRecord, 1240)
	MisBeginCondition( HasRecord, 1243)
	MisBeginAction( AddMission, 1245)
	MisBeginAction( AddTrigger, 12451, TE_GETITEM, 2966, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001273 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001273")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001273)
	MisNeed( MIS_NEED_ITEM, 2966, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001274 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001274")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001274)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001275 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001275")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001275)
	MisResultCondition( HasMission, 1245)
	MisResultCondition( NoRecord, 1245)
	MisResultCondition( HasItem, 2966, 1)
	MisResultAction( TakeItem, 2966, 1)
	MisResultAction( SetRecord, 1245)
	MisResultAction( ClearMission, 1245)
	MisResultAction( GiveItem, 2975, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 2966)	
	TriggerAction( 1, AddNextFlag, 1245, 10, 1 )
	RegCurTrigger( 12451 )

----------------------------------找回精美的蜡烛------------小羊·威力
	MISSCRIPT_MISSIONSCRIPT07_LUA_001271 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001271")
	DefineMission( 6184, MISSCRIPT_MISSIONSCRIPT07_LUA_001271, 1246)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001276 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001276")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001276)
	MisBeginCondition( NoMission, 1246)
	MisBeginCondition( NoRecord, 1246)
	MisBeginCondition( HasMission, 1245)
	MisBeginAction( AddMission, 1246)
	MisBeginAction( AddTrigger, 12461, TE_GETITEM, 3367,2)
	MisBeginAction( AddTrigger, 12462, TE_GETITEM, 3380,2)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001277 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001277")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001277)
	MisNeed( MIS_NEED_ITEM, 3367, 2, 10, 2)
	MisNeed( MIS_NEED_ITEM, 3380, 2, 20, 2)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001278 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001278")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001278)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001279 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001279")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001279)
	MisResultCondition( HasMission, 1246)
	MisResultCondition( NoRecord, 1246)
	MisResultCondition( HasItem, 3367, 2)
	MisResultCondition( HasItem, 3380, 2)
	MisResultAction( TakeItem, 3380, 2)
	MisResultAction( TakeItem, 3367, 2)
	MisResultAction( SetRecord, 1246)
	MisResultAction( ClearMission, 1246)
	MisResultAction( GiveItem, 2966, 1, 4)

	MisResultBagNeed(1)

        InitTrigger()
	TriggerCondition( 1, IsItem, 3367)	
	TriggerAction( 1, AddNextFlag, 1246, 10, 2 )
	RegCurTrigger( 12461 )

	 InitTrigger()
	TriggerCondition( 1, IsItem, 3380)	
	TriggerAction( 1, AddNextFlag, 1246, 20, 2 )
	RegCurTrigger( 12462 )

------------------------护送圣诞老人------------ 	冰狼堡NPC圣诞老人（1216，550）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001280")
	DefineMission( 6185, MISSCRIPT_MISSIONSCRIPT07_LUA_001280, 1247)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001281 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001281")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001281)
	MisBeginCondition( NoMission, 1247)
	MisBeginCondition( NoRecord, 1247)
	MisBeginCondition( HasItem, 2878, 1)
	MisBeginAction( TakeItem, 2878, 1)
	MisBeginAction( AddMission, 1247)
	MisBeginAction( CreatBBBB, 929)
	MisCancelAction( ClearMission, 1247)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001282 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001282")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001282)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001283 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001283")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001283)

	MisResultCondition( AlwaysFailure )


--------------------------------------------------------护送圣诞老人--------冰极骷髅营地补给站(2111,557)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001280 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001280")
	DefineMission( 6186, MISSCRIPT_MISSIONSCRIPT07_LUA_001280, 1247, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001284 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001284")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001284)
	MisResultCondition( HasMission, 1247)
	MisResultCondition( NoRecord, 1247)
	MisResultAction( CheckBBBB)
	MisResultAction( ClearMission, 1247)
	MisResultAction( SetRecord, 1247)
	MisResultAction( GiveItem, 2888, 1, 4)
	MisResultAction( GiveItem, 2889, 1, 4)
	MisResultAction( GiveItem, 3240, 1, 4)
	MisResultBagNeed(3)
	
------------------------------火鸡大猎捕	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001285 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001285")
	DefineMission( 6187, MISSCRIPT_MISSIONSCRIPT07_LUA_001285, 1248)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001286 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001286")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001286)
	MisBeginCondition( NoMission, 1248)
	MisBeginCondition( NoRecord, 1248)
	MisBeginAction( AddMission, 1248)
	MisBeginAction(AddTrigger, 12481, TE_GETITEM, 2879, 100 )
	MisCancelAction( ClearMission, 1248)

	MisNeed(MIS_NEED_ITEM, 2879, 100, 10, 100 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001287 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001287")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001287)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001288 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001288")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001288)
	MisResultCondition( HasMission, 1248)
	MisResultCondition( NoRecord, 1248)
	MisResultCondition( HasItem, 2879, 100)
	MisResultAction( TakeItem, 2879, 100)
	MisResultAction( GiveItem, 2882, 1, 4)
	MisResultAction( CpHuojiNum )
	MisResultAction( ClearMission, 1248)
	MisResultAction( SetRecord, 1248)
	MisResultAction( ClearRecord, 1248)


	InitTrigger()
	TriggerCondition( 1, IsItem, 2879)	
	TriggerAction( 1, AddNextFlag, 1248, 10, 100 )
	RegCurTrigger( 12481 )

------------------------------麋鹿大猎捕	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001289 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001289")
	DefineMission( 6188, MISSCRIPT_MISSIONSCRIPT07_LUA_001289, 1249)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001290 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001290")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001290)
	MisBeginCondition( NoMission, 1249)
	MisBeginCondition( NoRecord, 1249)
	MisBeginAction( AddMission, 1249)
	MisBeginAction(AddTrigger, 12491, TE_GETITEM, 2881, 100 )
	MisCancelAction( ClearMission, 1249)

	MisNeed(MIS_NEED_ITEM, 2881, 100, 10, 100 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001291 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001291")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001291)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001288 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001288")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001288)
	MisResultCondition( HasMission, 1249)
	MisResultCondition( NoRecord, 1249)
	MisResultCondition( HasItem, 2881, 100)
	MisResultAction( TakeItem, 2881, 100)
	MisResultAction( GiveItem, 2882, 1, 4)
	MisResultAction( CpMiluNum )
	MisResultAction( ClearMission, 1249)
	MisResultAction( SetRecord, 1249)
	MisResultAction( ClearRecord, 1249)


	InitTrigger()
	TriggerCondition( 1, IsItem, 2881)	
	TriggerAction( 1, AddNextFlag, 1249, 10, 100 )
	RegCurTrigger( 12491 )

------------------------------雪人大猎捕	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001292 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001292")
	DefineMission( 6189, MISSCRIPT_MISSIONSCRIPT07_LUA_001292, 1250)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001293 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001293")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001293)
	MisBeginCondition( NoMission, 1250)
	MisBeginCondition( NoRecord, 1250)
	MisBeginAction( AddMission, 1250)
	MisBeginAction(AddTrigger, 12501, TE_GETITEM, 2880, 100 )
	MisCancelAction( ClearMission, 1250)

	MisNeed(MIS_NEED_ITEM, 2880, 100, 10, 100 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001294 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001294")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001294)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001288 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001288")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001288)
	MisResultCondition( HasMission, 1250)
	MisResultCondition( NoRecord, 1250)
	MisResultCondition( HasItem, 2880, 100)
	MisResultAction( TakeItem, 2880, 100)
	MisResultAction( GiveItem, 2882, 1, 4)
	MisResultAction( CpXuerenNum )
	MisResultAction( ClearMission, 1250)
	MisResultAction( SetRecord, 1250)
	MisResultAction( ClearRecord, 1250)


	InitTrigger()
	TriggerCondition( 1, IsItem, 2880)	
	TriggerAction( 1, AddNextFlag, 1250, 10, 100 )
	RegCurTrigger( 12501 )


	----------------------------------------------------------不忍错过的圣诞任务(一)--------------圣诞村传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001295")
	DefineMission( 6190, MISSCRIPT_MISSIONSCRIPT07_LUA_001295, 1251)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001296 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001296")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001296)
	MisBeginCondition( NoMission, 1251)
	MisBeginCondition( NoRecord, 1251)
	MisBeginAction( AddMission, 1251)
	MisCancelAction( ClearMission, 1251)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001297 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001297")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001297)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001298 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001298")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001298)
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------不忍错过的圣诞任务(一)--------------斐谢特(220,41)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001295 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001295")
	DefineMission( 6191, MISSCRIPT_MISSIONSCRIPT07_LUA_001295, 1251, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001299 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001299")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001299)
	MisResultCondition( HasMission, 1251)
	MisResultCondition( NoRecord, 1251)
	MisResultAction( SetRecord, 1251)
	MisResultAction( GiveItem, 2883, 2, 4)
	MisResultAction( ClearMission, 1251)
	MisResultBagNeed(1)


	--------------------------------------------------------不忍错过的圣诞任务(二)-----------------圣诞村传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001300")
	DefineMission( 6192, MISSCRIPT_MISSIONSCRIPT07_LUA_001300, 1252)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001301 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001301")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001301)
	MisBeginCondition( NoMission, 1252)
	MisBeginCondition( NoRecord, 1252)
	MisBeginAction( AddMission, 1252)
	MisCancelAction( ClearMission, 1252)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001302 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001302")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001302)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001303 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001303")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001303)
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------不忍错过的圣诞任务(二)--------------科恩(144,252)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001300 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001300")
	DefineMission( 6193, MISSCRIPT_MISSIONSCRIPT07_LUA_001300, 1252, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001304 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001304")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001304)
	MisResultCondition( HasMission, 1252)
	MisResultCondition( NoRecord, 1252)
	MisResultAction( SetRecord, 1252)
	MisResultAction( GiveItem, 2883, 2, 4)
	MisResultAction( ClearMission, 1252)
	MisResultBagNeed(1)

	--------------------------------------------------------不忍错过的圣诞任务(三)--------------圣诞村传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001305")
	DefineMission( 6194, MISSCRIPT_MISSIONSCRIPT07_LUA_001305, 1253)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001306 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001306")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001306)
	MisBeginCondition( NoMission, 1253)
	MisBeginCondition( NoRecord, 1253)
	MisBeginAction( AddMission, 1253)
	MisCancelAction( ClearMission, 1253)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001307 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001307")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001307)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001308 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001308")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001308)
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------不忍错过的圣诞任务(三)--------------圣诞老人的洗衣机(84,37)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001305 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001305")
	DefineMission( 6195, MISSCRIPT_MISSIONSCRIPT07_LUA_001305, 1253, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001309 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001309")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001309)
	MisResultCondition( HasMission, 1253)
	MisResultCondition( NoRecord, 1253)
	MisResultAction( SetRecord, 1253)
	MisResultAction( GiveItem, 2883, 2, 4)
	MisResultAction( ClearMission, 1253)
	MisResultBagNeed(1)

	--------------------------------------------------------不忍错过的圣诞任务(四)--------------圣诞村传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001310")
	DefineMission( 6196, MISSCRIPT_MISSIONSCRIPT07_LUA_001310, 1254)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001311 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001311")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001311)
	MisBeginCondition( NoMission, 1254)
	MisBeginCondition( NoRecord, 1254)
	MisBeginAction( AddMission, 1254)
	MisCancelAction( ClearMission, 1254)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001312 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001312")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001312)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001313 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001313")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001313)
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------不忍错过的圣诞任务(四)--------------圣诞杂货商(197,251)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001310 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001310")
	DefineMission( 6197, MISSCRIPT_MISSIONSCRIPT07_LUA_001310, 1254, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001314 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001314")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001314)
	MisResultCondition( HasMission, 1254)
	MisResultCondition( NoRecord, 1254)
	MisResultAction( SetRecord, 1254)
	MisResultAction( GiveItem, 2883, 2, 4)
	MisResultAction( ClearMission, 1254)
	MisResultBagNeed(1)


	--------------------------------------------------------不忍错过的圣诞任务(五)--------------圣诞村传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001315")
	DefineMission( 6198, MISSCRIPT_MISSIONSCRIPT07_LUA_001315, 1255)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001316 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001316")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001316)
	MisBeginCondition( NoMission, 1255)
	MisBeginCondition( NoRecord, 1255)
	MisBeginAction( AddMission, 1255)
	MisCancelAction( ClearMission, 1255)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001317 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001317")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001317)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001318 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001318")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001318)
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------不忍错过的圣诞任务(五)--------------圣诞商人·我行我酷(125,253)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001315 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001315")
	DefineMission( 6199, MISSCRIPT_MISSIONSCRIPT07_LUA_001315, 1255, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001319 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001319")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001319)
	MisResultCondition( HasMission, 1255)
	MisResultCondition( NoRecord, 1255)
	MisResultAction( SetRecord, 1255)
	MisResultAction( GiveItem, 2883, 2, 4)
	MisResultAction( ClearMission, 1255)
	MisResultBagNeed(1)


	--------------------------------------------------------不忍错过的圣诞任务(六)--------------圣诞村传送使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001320")
	DefineMission( 6200, MISSCRIPT_MISSIONSCRIPT07_LUA_001320, 1256)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001321 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001321")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001321)
	MisBeginCondition( NoMission, 1256)
	MisBeginCondition( NoRecord, 1256)
	MisBeginAction( AddMission, 1256)
	MisCancelAction( ClearMission, 1256)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001322 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001322")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001322)
	MisHelpTalk( "<t>merry christmas!")
	
	MisResultCondition( AlwaysFailure )

-----------------------------------------------------------不忍错过的圣诞任务(六)-------------圣诞老人(144,166)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001320 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001320")
	DefineMission( 6201, MISSCRIPT_MISSIONSCRIPT07_LUA_001320, 1256, COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001323 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001323")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001323)
	MisResultCondition( HasMission, 1256)
	MisResultCondition( NoRecord, 1256)
	MisResultAction( SetRecord, 1256)
	MisResultAction( GiveItem, 2883, 2, 4)
	MisResultAction( ClearMission, 1256)
	MisResultBagNeed(1)

-----------------------------------------------------------幻觉任务------------不可能接到
	MISSCRIPT_MISSIONSCRIPT07_LUA_001324 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001324")
	DefineMission( 6202, MISSCRIPT_MISSIONSCRIPT07_LUA_001324, 1257)		------------圣诞老人

	MISSCRIPT_MISSIONSCRIPT07_LUA_001325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001325")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001325)
	MisBeginCondition( XmasNotice, 1 )
	MisBeginCondition( AlwaysFailure )
	MisBeginAction( AddMission, 1257)
	MisCancelAction( ClearMission, 1257)

	MisResultCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001324 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001324")
	DefineMission( 6203, MISSCRIPT_MISSIONSCRIPT07_LUA_001324, 1258)		------------圣诞篝火

	MISSCRIPT_MISSIONSCRIPT07_LUA_001325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001325")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001325)
	MisBeginCondition( XmasNotice, 2 )
	MisBeginCondition( AlwaysFailure )
	MisBeginAction( AddMission, 1258)
	MisCancelAction( ClearMission, 1258)

	MisResultCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001324 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001324")
	DefineMission( 6204, MISSCRIPT_MISSIONSCRIPT07_LUA_001324, 1259)		------------科恩

	MISSCRIPT_MISSIONSCRIPT07_LUA_001325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001325")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001325)
	MisBeginCondition( XmasNotice, 3 )
	MisBeginCondition( AlwaysFailure )
	MisBeginAction( AddMission, 1259)
	MisCancelAction( ClearMission, 1259)

	MisResultCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001324 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001324")
	DefineMission( 6205, MISSCRIPT_MISSIONSCRIPT07_LUA_001324, 1260)		------------小汤姆

	MISSCRIPT_MISSIONSCRIPT07_LUA_001325 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001325")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001325)
	MisBeginCondition( XmasNotice, 4 )
	MisBeginCondition( AlwaysFailure )
	MisBeginAction( AddMission, 1260)
	MisCancelAction( ClearMission, 1260)

	MisResultCondition( AlwaysFailure )

	----------------------------------------------------------------------08鼠年春节活动kokora-------------------------------------------------------------

	------------------------------------------------------------------------白银城[新手指导·瑟安](2223,2785)-----------------------------------------------

        ------------------------------------------祥鼠闹春送礼包(一)---------白银城新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001326 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001326")
	DefineMission(6205,MISSCRIPT_MISSIONSCRIPT07_LUA_001326,1257)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001327 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001327")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001327)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(LvCheck, ">",29)
	MisBeginCondition(LvCheck, "<",65)
	MisBeginAction(AddMission, 1257)
	MisBeginAction(AddTrigger, 12571, TE_GETITEM, 3116, 99)          

	MisCancelAction(ClearMission,1257)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001328 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001328")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001328)
	MisNeed(MIS_NEED_ITEM, 3116, 99, 10, 99)               ---------精灵果


	MISSCRIPT_MISSIONSCRIPT07_LUA_001329 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001329")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001329)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001330")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001330)

	MisResultCondition(HasMission, 1257)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)
	MisResultCondition(HasItem, 3116, 99)

	MisResultAction(TakeItem, 3116, 99)

	MisResultAction(GiveItem, 5648, 1, 4)                          ---------新手鼠年红包
	MisResultAction(ClearMission, 1257) 
	MisResultAction(SetRecord, 1257) 
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 3116)
	TriggerAction(1, AddNextFlag, 1257, 10, 99)
	RegCurTrigger(12571)

       ------------------------------------------祥鼠闹春大礼到(二)---------白银城新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001331 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001331")
	DefineMission(6206,MISSCRIPT_MISSIONSCRIPT07_LUA_001331,1258)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001332 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001332")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001332)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(LvCheck, ">",64)
	MisBeginCondition(LvCheck, "<",85)
	MisBeginAction(AddMission, 1258)
	MisBeginAction(AddTrigger, 12581, TE_GETITEM, 4495, 1)          

	MisCancelAction(ClearMission,1258)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001333 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001333")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001333)
	MisNeed(MIS_NEED_ITEM, 4495, 1, 10, 1)               ---------山贼腰带


	MISSCRIPT_MISSIONSCRIPT07_LUA_001334 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001334")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001334)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001335")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001335)

	MisResultCondition(HasMission, 1258)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)
	MisResultCondition(HasItem, 4495, 1)

	MisResultAction(TakeItem, 4495, 1)

	MisResultAction(GiveItem, 5649, 1, 4)                          ---------高级鼠年红包
	MisResultAction(ClearMission, 1258)                        
	MisResultAction(SetRecord, 1258)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 4495)
	TriggerAction(1, AddNextFlag, 1258, 10, 1)
	RegCurTrigger(12581)

	------------------------------------------祥鼠闹春庆盛典(三)---------白银城新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001336 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001336")
	DefineMission(6207,MISSCRIPT_MISSIONSCRIPT07_LUA_001336,1259)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001337 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001337")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001337)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(LvCheck, ">",84)
	MisBeginCondition(LvCheck, "<",101)
	MisBeginAction(AddMission, 1259)
	MisBeginAction(AddTrigger, 12591, TE_GETITEM, 0179, 10)          

	MisCancelAction(ClearMission,1259)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001338 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001338")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001338)
	MisNeed(MIS_NEED_ITEM, 0179, 10, 10, 10)               ---------永动机械


	MISSCRIPT_MISSIONSCRIPT07_LUA_001339 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001339")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001339)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001340")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001340)

	MisResultCondition(HasMission, 1259)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)
	MisResultCondition(HasItem, 0179, 10)

	MisResultAction(TakeItem, 0179, 10)

	MisResultAction(GiveItem, 5650, 1, 4)                          ---------超级鼠年红包
	MisResultAction(ClearMission, 1259)                        
	MisResultAction(SetRecord, 1259)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 0179)
	TriggerAction(1, AddNextFlag, 1259, 10, 10)
	RegCurTrigger(12591)


	------------------------------------------------------------------------冰狼堡[新手指导·安琪露](1315,507)重复-----------------------------------------------
       
       ------------------------------------------祥鼠闹春送礼包(一)---------冰狼堡新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001326 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001326")
	DefineMission(6208,MISSCRIPT_MISSIONSCRIPT07_LUA_001326,1260)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001341 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001341")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001341)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(LvCheck, ">",29)
	MisBeginCondition(LvCheck, "<",65)
	MisBeginAction(AddMission, 1260)
	MisBeginAction(AddTrigger, 12601, TE_GETITEM, 3116, 99)          

	MisCancelAction(ClearMission,1260)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001328 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001328")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001328)
	MisNeed(MIS_NEED_ITEM, 3116, 99, 10, 99)               ---------精灵果


	MISSCRIPT_MISSIONSCRIPT07_LUA_001329 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001329")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001329)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001330")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001330)

	MisResultCondition(HasMission, 1260)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)

	MisResultCondition(HasItem, 3116, 99)

	MisResultAction(TakeItem, 3116, 99)

	MisResultAction(GiveItem, 5648, 1, 4)                          ---------新手鼠年红包
	MisResultAction(ClearMission, 1260)                        
	MisResultAction(SetRecord, 1260)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 3116)
	TriggerAction(1, AddNextFlag, 1260, 10, 99)
	RegCurTrigger(12601)

       ------------------------------------------祥鼠闹春大礼到(二)---------冰狼堡新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001331 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001331")
	DefineMission(6209,MISSCRIPT_MISSIONSCRIPT07_LUA_001331,1261)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001342 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001342")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001342)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(LvCheck, ">",64)
	MisBeginCondition(LvCheck, "<",85)
	MisBeginAction(AddMission, 1261)
	MisBeginAction(AddTrigger, 12611, TE_GETITEM, 4495, 1)          

	MisCancelAction(ClearMission,1261)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001333 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001333")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001333)
	MisNeed(MIS_NEED_ITEM, 4495, 1, 10, 1)               ---------山贼腰带


	MISSCRIPT_MISSIONSCRIPT07_LUA_001334 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001334")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001334)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001335")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001335)

	MisResultCondition(HasMission, 1261)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1262)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)

	MisResultCondition(HasItem, 4495, 1)

	MisResultAction(TakeItem, 4495, 1)

	MisResultAction(GiveItem, 5649, 1, 4)                          ---------高级鼠年红包
	MisResultAction(ClearMission, 1261)                        
	MisResultAction(SetRecord, 1261)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 4495)
	TriggerAction(1, AddNextFlag, 1261, 10, 1)
	RegCurTrigger(12611)

	------------------------------------------祥鼠闹春庆盛典(三)---------冰狼堡新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001336 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001336")
	DefineMission(6210,MISSCRIPT_MISSIONSCRIPT07_LUA_001336,1262)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001343 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001343")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001343)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(LvCheck, ">",84)
	MisBeginCondition(LvCheck, "<",101)
	MisBeginAction(AddMission, 1262)
	MisBeginAction(AddTrigger, 12621, TE_GETITEM, 0179, 10)          

	MisCancelAction(ClearMission,1262)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001338 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001338")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001338)
	MisNeed(MIS_NEED_ITEM, 0179, 10, 10, 10)               ---------永动机械


	MISSCRIPT_MISSIONSCRIPT07_LUA_001339 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001339")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001339)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001344 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001344")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001344)

	MisResultCondition(HasMission, 1262)
	MisResultCondition(NoRecord, 1262)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)

	MisResultCondition(HasItem, 0179, 10)

	MisResultAction(TakeItem, 0179, 10)

	MisResultAction(GiveItem, 5650, 1, 4)                          ---------超级鼠年红包
	MisResultAction(ClearMission, 1262)                        
	MisResultAction(SetRecord, 1262)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 0179)
	TriggerAction(1, AddNextFlag, 1262, 10, 10)
	RegCurTrigger(12621)

	------------------------------------------------------------------------沙岚城[新手指导·拉丝碧](876,3572)重复-----------------------------------------------
       
       ------------------------------------------祥鼠闹春送礼包(一)---------沙岚城新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001326 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001326")
	DefineMission(6211,MISSCRIPT_MISSIONSCRIPT07_LUA_001326,1263)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001345 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001345")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001345)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(LvCheck, ">",29)
	MisBeginCondition(LvCheck, "<",65)
	MisBeginAction(AddMission, 1263)
	MisBeginAction(AddTrigger, 12631, TE_GETITEM, 3116, 99)          

	MisCancelAction(ClearMission,1263)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001328 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001328")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001328)
	MisNeed(MIS_NEED_ITEM, 3116, 99, 10, 99)               ---------精灵果


	MISSCRIPT_MISSIONSCRIPT07_LUA_001329 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001329")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001329)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001330 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001330")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001330)

	MisResultCondition(HasMission, 1263)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1265)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)

	MisResultCondition(HasItem, 3116, 99)

	MisResultAction(TakeItem, 3116, 99)

	MisResultAction(GiveItem, 5648, 1, 4)                          ---------新手鼠年红包
	MisResultAction(ClearMission, 1263) 
	MisResultAction(SetRecord, 1263) 
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 3116)
	TriggerAction(1, AddNextFlag, 1263, 10, 99)
	RegCurTrigger(12631)

       ------------------------------------------祥鼠闹春大礼到(二)---------沙岚城新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001331 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001331")
	DefineMission(6212,MISSCRIPT_MISSIONSCRIPT07_LUA_001331,1264)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001346 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001346")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001346)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(LvCheck, ">",64)
	MisBeginCondition(LvCheck, "<",85)
	MisBeginAction(AddMission, 1264)
	MisBeginAction(AddTrigger, 12641, TE_GETITEM, 4495, 1)          

	MisCancelAction(ClearMission,1264)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001333 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001333")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001333)
	MisNeed(MIS_NEED_ITEM, 4495, 1, 10, 1)               ---------山贼腰带


	MISSCRIPT_MISSIONSCRIPT07_LUA_001334 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001334")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001334)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001335 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001335")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001335)

	MisResultCondition(HasMission, 1264)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1265)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)


	MisResultCondition(HasItem, 4495, 1)

	MisResultAction(TakeItem, 4495, 1)

	MisResultAction(GiveItem, 5649, 1, 4)                          ---------高级鼠年红包
	MisResultAction(ClearMission, 1264)                        
	MisResultAction(SetRecord, 1264)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 4495)
	TriggerAction(1, AddNextFlag, 1264, 10, 1)
	RegCurTrigger(12641)

	------------------------------------------祥鼠闹春庆盛典(三)---------沙岚城新手指导

	MISSCRIPT_MISSIONSCRIPT07_LUA_001336 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001336")
	DefineMission(6213,MISSCRIPT_MISSIONSCRIPT07_LUA_001336,1265)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001347 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001347")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001347)

	MisBeginCondition(NoMission, 1257)
	MisBeginCondition(NoMission, 1258)
	MisBeginCondition(NoMission, 1259)
	MisBeginCondition(NoMission, 1260)
	MisBeginCondition(NoMission, 1261)
	MisBeginCondition(NoMission, 1262)
	MisBeginCondition(NoMission, 1263)
	MisBeginCondition(NoMission, 1264)
	MisBeginCondition(NoMission, 1265)
	--MisBeginCondition(NoMission, 1265)
	MisBeginCondition(NoRecord, 1265)
	MisBeginCondition(NoRecord, 1263)
	MisBeginCondition(NoRecord, 1264)
	MisBeginCondition(NoRecord, 1257)
	MisBeginCondition(NoRecord, 1258)
	MisBeginCondition(NoRecord, 1259)
	MisBeginCondition(NoRecord, 1260)
	MisBeginCondition(NoRecord, 1261)
	MisBeginCondition(NoRecord, 1262)
	MisBeginCondition(LvCheck, ">",84)
	MisBeginCondition(LvCheck, "<",101)
	MisBeginAction(AddMission, 1265)
	MisBeginAction(AddTrigger, 12651, TE_GETITEM, 0179, 10)          

	MisCancelAction(ClearMission,1265)                         ---------可以取消此任务

	MISSCRIPT_MISSIONSCRIPT07_LUA_001338 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001338")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001338)
	MisNeed(MIS_NEED_ITEM, 0179, 10, 10, 10)               ---------永动机械


	MISSCRIPT_MISSIONSCRIPT07_LUA_001339 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001339")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001339)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001340 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001340")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001340)

	MisResultCondition(HasMission, 1265)
	MisResultCondition(NoRecord, 1265)
	MisResultCondition(NoRecord, 1263)
	MisResultCondition(NoRecord, 1264)
	MisResultCondition(NoRecord, 1257)
	MisResultCondition(NoRecord, 1258)
	MisResultCondition(NoRecord, 1259)
	MisResultCondition(NoRecord, 1260)
	MisResultCondition(NoRecord, 1261)
	MisResultCondition(NoRecord, 1262)

	MisResultCondition(HasItem, 0179, 10)

	MisResultAction(TakeItem, 0179, 10)

	MisResultAction(GiveItem, 5650, 1, 4)                          ---------超级鼠年红包
	MisResultAction(ClearMission, 1265)                        
	MisResultAction(SetRecord, 1265)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition(1, IsItem, 0179)
	TriggerAction(1, AddNextFlag, 1265, 10, 10)
	RegCurTrigger(12651)

	--------------------------------------------------------------kokora(end)------------------------------------------------------------------

--------------------------------------------------------------dina二次转生任务(begin)------------------------------------------------------------------
	-------------------------------------------------------浴火重生之一--------教皇史昂
	MISSCRIPT_MISSIONSCRIPT07_LUA_001348 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001348")
	DefineMission( 6214, MISSCRIPT_MISSIONSCRIPT07_LUA_001348, 1266 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001349 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001349")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001349)
	MisBeginCondition(NoMission, 1266)
	MisBeginCondition(NoRecord,1266)
	MisBeginCondition( Checksailexpmore, 9880)
	MisBeginAction(AddMission,1266)
	MisBeginAction(AddTrigger, 12661, TE_GETITEM, 5753, 1)
	MisBeginAction(AddTrigger, 12662, TE_GETITEM, 5754, 1)
	MisBeginAction(AddTrigger, 12663, TE_GETITEM, 5755, 1)
	MisBeginAction(AddTrigger, 12664, TE_GETITEM, 5756, 1)
	MisBeginAction(AddTrigger, 12665, TE_GETITEM, 5757, 1)
	MisBeginAction(AddTrigger, 12666, TE_GETITEM, 5758, 1)
	
	--MisCancelAction(ClearMission, 1266)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001350 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001350")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001350)
	MisNeed(MIS_NEED_ITEM, 5753, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 5754, 1, 15, 1)
	MisNeed(MIS_NEED_ITEM, 5755, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 5756, 1, 25, 1)
	MisNeed(MIS_NEED_ITEM, 5757, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 5758, 1, 35, 1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001351 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001351")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001351)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001352 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001352")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001352)

	MisResultCondition(HasMission, 1266)
	MisResultCondition(NoRecord,1266)
	MisResultCondition(HasItem, 5753, 1)
	MisResultCondition(HasItem, 5754, 1)
	MisResultCondition(HasItem, 5755, 1)
	MisResultCondition(HasItem, 5756, 1)
	MisResultCondition(HasItem, 5757, 1)
	MisResultCondition(HasItem, 5758, 1)
		
	MisResultAction(TakeItem, 5753, 1 )
	MisResultAction(TakeItem, 5754, 1 )
	MisResultAction(TakeItem, 5755, 1 )
	MisResultAction(TakeItem, 5756, 1 )
	MisResultAction(TakeItem, 5757, 1 )
	MisResultAction(TakeItem, 5758, 1 )
	
	
	MisResultAction(ClearMission, 1266)
	MisResultAction(SetRecord, 1266)
	

	InitTrigger()
	TriggerCondition( 1, IsItem, 5753)	
	TriggerAction( 1, AddNextFlag, 1266, 10, 1 )
	RegCurTrigger( 12661 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5754)	
	TriggerAction( 1, AddNextFlag, 1266, 15, 1 )
	RegCurTrigger( 12662 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5755)	
	TriggerAction( 1, AddNextFlag, 1266, 20, 1 )
	RegCurTrigger( 12663 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5756)	
	TriggerAction( 1, AddNextFlag, 1266, 25, 1 )
	RegCurTrigger( 12664 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5757)	
	TriggerAction( 1, AddNextFlag, 1266, 30, 1 )
	RegCurTrigger( 12665 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5758)	
	TriggerAction( 1, AddNextFlag, 1266, 35, 1 )
	RegCurTrigger( 12666 )
		
	-------------------------------------------------------穆的符文--------穆
	MISSCRIPT_MISSIONSCRIPT07_LUA_001353 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001353")
	DefineMission( 6215, MISSCRIPT_MISSIONSCRIPT07_LUA_001353,1267 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001354 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001354")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001354)
	MisBeginCondition( NoMission, 1267)
	MisBeginCondition( NoRecord, 1267)
	MisBeginCondition( HasMission, 1266)
	MisBeginAction(	AddMission, 1267)
	MisBeginAction( AddTrigger, 12671, TE_KILL, 974, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 974, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001355 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001355")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001355)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001356 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001356")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001356)
	MisResultCondition( HasFlag, 1267, 10)
	MisResultAction(GiveItem, 5753,1,4)------------给MU符文
	MisResultCondition( HasMission, 1267)
	MisResultAction( ClearMission, 1267)
	MisResultAction(SetRecord, 1267)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 974 )
	TriggerAction( 1, AddNextFlag, 1267, 10, 1 )
	RegCurTrigger( 12671 )

	
	-------------------------------------------------------阿鲁狄巴符文--------阿鲁狄巴
	MISSCRIPT_MISSIONSCRIPT07_LUA_001357 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001357")
	DefineMission( 6216, MISSCRIPT_MISSIONSCRIPT07_LUA_001357,1268 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001358 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001358")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001358)
	MisBeginCondition( NoMission, 1268)
	MisBeginCondition( NoRecord, 1268)
	MisBeginCondition( HasMission, 1266)
	MisBeginCondition( HasRecord, 1267)
	MisBeginAction(	AddMission, 1268)
	MisBeginAction( AddTrigger, 12681, TE_KILL, 975, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 975, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001359 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001359")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001359)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001360 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001360")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001360)
	MisResultCondition( HasFlag, 1268, 10)
	MisResultAction(GiveItem, 5754,1,4)------------给ALDEBA符文  
	MisResultCondition( HasMission, 1268)
	MisResultAction( ClearMission, 1268)
	MisResultAction(SetRecord, 1268)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 975 )
	TriggerAction( 1, AddNextFlag, 1268, 10, 1 )
	RegCurTrigger( 12681 )
	
	-------------------------------------------------------撒加符文--------撒加
	MISSCRIPT_MISSIONSCRIPT07_LUA_001361 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001361")
	DefineMission( 6217, MISSCRIPT_MISSIONSCRIPT07_LUA_001361,1269 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001362 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001362")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001362)
	MisBeginCondition( NoMission, 1269)
	MisBeginCondition( NoRecord, 1269)
	MisBeginCondition( HasMission, 1266)
	MisBeginCondition( HasRecord, 1268)
	MisBeginAction(	AddMission, 1269)
	MisBeginAction( AddTrigger, 12691, TE_KILL, 976, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 976, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001363 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001363")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001363)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001364 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001364")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001364)
	MisResultCondition( HasFlag, 1269, 10)
	MisResultAction(GiveItem, 5755,1,4)------------给撒加符文  
	MisResultCondition( HasMission, 1269)
	MisResultAction( ClearMission, 1269)
	MisResultAction(SetRecord, 1269)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 976 )
	TriggerAction( 1, AddNextFlag, 1269, 10, 1 )
	RegCurTrigger( 12691 )
	
	-------------------------------------------------------狄马斯符文--------狄马斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_001365 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001365")
	DefineMission( 6218, MISSCRIPT_MISSIONSCRIPT07_LUA_001365,1270 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001366 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001366")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001366)
	MisBeginCondition( NoMission, 1270)
	MisBeginCondition( NoRecord, 1270)
	MisBeginCondition( HasMission, 1266)
	MisBeginCondition( HasRecord, 1269)
	MisBeginAction(	AddMission, 1270)
	MisBeginAction( AddTrigger, 12701, TE_KILL, 977, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 977, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001367 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001367")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001367)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001368 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001368")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001368)
	MisResultCondition( HasFlag, 1270, 10)
	MisResultAction(GiveItem, 5756,1,4)------------给狄马斯符文  
	MisResultCondition( HasMission, 1270)
	MisResultAction( ClearMission, 1270)
	MisResultAction(SetRecord, 1270)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 977 )
	TriggerAction( 1, AddNextFlag, 1270, 10, 1 )
	RegCurTrigger( 12701 )
	
	-------------------------------------------------------艾奥利亚符文--------艾奥利亚
	MISSCRIPT_MISSIONSCRIPT07_LUA_001369 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001369")
	DefineMission( 6219, MISSCRIPT_MISSIONSCRIPT07_LUA_001369,1271 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001370 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001370")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001370)
	MisBeginCondition( NoMission, 1271)
	MisBeginCondition( NoRecord, 1271)
	MisBeginCondition( HasMission, 1266)
	MisBeginCondition( HasRecord, 1270)
	MisBeginAction(	AddMission, 1271)
	MisBeginAction( AddTrigger, 12711, TE_KILL, 979, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 979, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001371 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001371")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001371)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001372 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001372")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001372)
	MisResultCondition( HasFlag, 1271, 10)
	MisResultAction(GiveItem, 5757,1,4)------------给艾奥利亚符文  
	MisResultCondition( HasMission, 1271)
	MisResultAction( ClearMission, 1271)
	MisResultAction(SetRecord, 1271)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 979 )
	TriggerAction( 1, AddNextFlag, 1271, 10, 1 )
	RegCurTrigger( 12711 )
	
	-------------------------------------------------------沙加符文--------沙加利亚
	MISSCRIPT_MISSIONSCRIPT07_LUA_001373 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001373")
	DefineMission( 6220, MISSCRIPT_MISSIONSCRIPT07_LUA_001373,1272 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001374 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001374")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001374)
	MisBeginCondition( NoMission, 1272)
	MisBeginCondition( NoRecord, 1272)
	MisBeginCondition( HasMission, 1266)
	MisBeginCondition( HasRecord, 1271)
	MisBeginAction(	AddMission, 1272)
	MisBeginAction( AddTrigger, 12721, TE_KILL, 980, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 980, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001375 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001375")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001375)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001376 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001376")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001376)
	MisResultCondition( HasFlag, 1272, 10)
	MisResultAction(GiveItem, 5758,1,4)------------给沙加符文  
	MisResultCondition( HasMission, 1272)
	MisResultAction( ClearMission, 1272)
	MisResultAction(SetRecord, 1272)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 980 )
	TriggerAction( 1, AddNextFlag, 1272, 10, 1 )
	RegCurTrigger( 12721 )
	
	-------------------------------------------------------童虎符文--------童虎
	MISSCRIPT_MISSIONSCRIPT07_LUA_001377 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001377")
	DefineMission( 6221, MISSCRIPT_MISSIONSCRIPT07_LUA_001377,1273 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001378 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001378")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001378)
	MisBeginCondition( NoMission, 1273)
	MisBeginCondition( NoRecord, 1273)
	MisBeginCondition( HasMission, 1279)
	MisBeginCondition( HasRecord, 1272)
	MisBeginAction(	AddMission, 1273)
	MisBeginAction( AddTrigger, 12731, TE_KILL, 981, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 981, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001379 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001379")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001379)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001380 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001380")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001380)
	MisResultCondition( HasFlag, 1273, 10)
	MisResultAction(GiveItem, 5759,1,4)------------给童虎符文  
	MisResultCondition( HasMission, 1273)
	MisResultAction( ClearMission, 1273)
	MisResultAction(SetRecord, 1273)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 981 )
	TriggerAction( 1, AddNextFlag, 1273, 10, 1 )
	RegCurTrigger( 12731 )
	
	-------------------------------------------------------米罗符文--------米罗
	MISSCRIPT_MISSIONSCRIPT07_LUA_001381 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001381")
	DefineMission( 6222, MISSCRIPT_MISSIONSCRIPT07_LUA_001381,1274 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001382 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001382")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001382)
	MisBeginCondition( NoMission, 1274)
	MisBeginCondition( NoRecord, 1274)
	MisBeginCondition( HasMission, 1279)
	MisBeginCondition( HasRecord, 1273)
	MisBeginAction(	AddMission, 1274)
	MisBeginAction( AddTrigger, 12741, TE_KILL, 982, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 982, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001383 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001383")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001383)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001384 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001384")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001384)
	MisResultCondition( HasFlag, 1274, 10)
	MisResultAction(GiveItem, 5760,1,4)------------给米罗符文  
	MisResultCondition( HasMission, 1274)
	MisResultAction( ClearMission, 1274)
	MisResultAction(SetRecord, 1274)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 982 )
	TriggerAction( 1, AddNextFlag, 1274, 10, 1 )
	RegCurTrigger( 12741 )
	
	-------------------------------------------------------艾俄罗斯符文-------艾俄罗斯
	MISSCRIPT_MISSIONSCRIPT07_LUA_001385 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001385")
	DefineMission( 6223, MISSCRIPT_MISSIONSCRIPT07_LUA_001385,1275 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001386 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001386")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001386)
	MisBeginCondition( NoMission, 1275)
	MisBeginCondition( NoRecord, 1275)
	MisBeginCondition( HasMission, 1279)
	MisBeginCondition( HasRecord, 1274)
	MisBeginAction(	AddMission, 1275)
	MisBeginAction( AddTrigger, 12751, TE_KILL, 983, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 983, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001387 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001387")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001387)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001388 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001388")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001388)
	MisResultCondition( HasFlag, 1275, 10)
	MisResultAction(GiveItem, 5761,1,4)------------给艾俄罗斯符文  
	MisResultCondition( HasMission, 1275)
	MisResultAction( ClearMission, 1275)
	MisResultAction(SetRecord, 1275)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 983 )
	TriggerAction( 1, AddNextFlag, 1275, 10, 1 )
	RegCurTrigger( 12751 )
	
	-------------------------------------------------------修罗符文-------修罗
	MISSCRIPT_MISSIONSCRIPT07_LUA_001389 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001389")
	DefineMission( 6224, MISSCRIPT_MISSIONSCRIPT07_LUA_001389,1276 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001390 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001390")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001390)
	MisBeginCondition( NoMission, 1276)
	MisBeginCondition( NoRecord, 1276)
	MisBeginCondition( HasMission, 1279)
	MisBeginCondition( HasRecord, 1275)
	MisBeginAction(	AddMission, 1276)
	MisBeginAction( AddTrigger, 12761, TE_KILL, 984, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 984, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001391 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001391")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001391)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001392 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001392")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001392)
	MisResultCondition( HasFlag, 1276, 10)
	MisResultAction(GiveItem, 5762,1,4)------------给修罗符文  
	MisResultCondition( HasMission, 1276)
	MisResultAction( ClearMission, 1276)
	MisResultAction(SetRecord, 1276)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 984 )
	TriggerAction( 1, AddNextFlag, 1276, 10, 1 )
	RegCurTrigger( 12761 )
	
	-------------------------------------------------------加妙符文-------加妙
	MISSCRIPT_MISSIONSCRIPT07_LUA_001393 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001393")
	DefineMission( 6225, MISSCRIPT_MISSIONSCRIPT07_LUA_001393,1277 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001394 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001394")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001394)
	MisBeginCondition( NoMission, 1277)
	MisBeginCondition( NoRecord, 1277)
	MisBeginCondition( HasMission, 1279)
	MisBeginCondition( HasRecord, 1276)
	MisBeginAction(	AddMission, 1277)
	MisBeginAction( AddTrigger, 12771, TE_KILL, 985, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 985, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001395 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001395")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001395)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001396 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001396")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001396)
	MisResultCondition( HasFlag, 1277, 10)
	MisResultAction(GiveItem, 5763,1,4)------------给加妙符文  
	MisResultCondition( HasMission, 1277)
	MisResultAction( ClearMission, 1277)
	MisResultAction(SetRecord, 1277)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 985 )
	TriggerAction( 1, AddNextFlag, 1277, 10, 1 )
	RegCurTrigger( 12771 )
	
	-------------------------------------------------------阿布罗狄符文-------阿布罗狄
	MISSCRIPT_MISSIONSCRIPT07_LUA_001393 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001393")
	DefineMission( 6226, MISSCRIPT_MISSIONSCRIPT07_LUA_001393,1278 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001397 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001397")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001397)
	MisBeginCondition( NoMission, 1278)
	MisBeginCondition( NoRecord, 1278)
	MisBeginCondition( HasMission, 1279)
	MisBeginCondition( HasRecord, 1277)
	MisBeginAction(	AddMission, 1278)
	MisBeginAction( AddTrigger, 12781, TE_KILL, 986, 1)
	-- MisCancelAction( ClearMission, 1266)

	MisNeed( MIS_NEED_KILL, 986, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001398 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001398")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001398)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001399 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001399")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001399)
	MisResultCondition( HasFlag, 1278, 10)
	MisResultAction(GiveItem, 5764,1,4)------------给阿布罗狄符文  
	MisResultCondition( HasMission, 1278)
	MisResultAction( ClearMission, 1278)
	MisResultAction(SetRecord, 1278)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 986 )
	TriggerAction( 1, AddNextFlag, 1278, 10, 1 )
	RegCurTrigger( 12781 )
	
		
	-------------------------------------------------------浴火重生之二--------教皇史昂
	MISSCRIPT_MISSIONSCRIPT07_LUA_001400 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001400")
	DefineMission( 6227, MISSCRIPT_MISSIONSCRIPT07_LUA_001400, 1279 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001401 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001401")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001401)
	MisBeginCondition(NoMission, 1279)
	MisBeginCondition(NoRecord,1279)
	MisBeginCondition(HasRecord,1266)
	MisBeginAction(AddMission,1279)
	MisBeginAction(AddTrigger, 12791, TE_GETITEM, 5759, 1)
	MisBeginAction(AddTrigger, 12792, TE_GETITEM, 5760, 1)
	MisBeginAction(AddTrigger, 12793, TE_GETITEM, 5761, 1)
	MisBeginAction(AddTrigger, 12794, TE_GETITEM, 5762, 1)
	MisBeginAction(AddTrigger, 12795, TE_GETITEM, 5763, 1)
	MisBeginAction(AddTrigger, 12796, TE_GETITEM, 5764, 1)

	--MisCancelAction(ClearMission, 1279)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001402 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001402")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001402)
	MisNeed(MIS_NEED_ITEM, 5759, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 5760, 1, 15, 1)
	MisNeed(MIS_NEED_ITEM, 5761, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 5762, 1, 25, 1)
	MisNeed(MIS_NEED_ITEM, 5763, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 5764, 1, 35, 1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001403 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001403")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001403)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001404 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001404")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001404)

	MisResultCondition(HasMission, 1279)
	MisResultCondition(NoRecord,1279)
	MisResultCondition(HasItem, 5759, 1)
	MisResultCondition(HasItem, 5760, 1)
	MisResultCondition(HasItem, 5761, 1)
	MisResultCondition(HasItem, 5762, 1)
	MisResultCondition(HasItem, 5763, 1)
	MisResultCondition(HasItem, 5764, 1)
		
	MisResultAction(TakeItem, 5759, 1 )
	MisResultAction(TakeItem, 5760, 1 )
	MisResultAction(TakeItem, 5761, 1 )
	MisResultAction(TakeItem, 5762, 1 )
	MisResultAction(TakeItem, 5763, 1 )
	MisResultAction(TakeItem, 5764, 1 )
	
	
	MisResultAction(GiveItem, 5765,1,4)------------给浴火重生石
	MisResultAction(ClearMission, 1279)
	MisResultAction(SetRecord, 1279)
	

	InitTrigger()
	TriggerCondition( 1, IsItem, 5759)	
	TriggerAction( 1, AddNextFlag, 1279, 10, 1 )
	RegCurTrigger( 12791 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5760)	
	TriggerAction( 1, AddNextFlag, 1279, 15, 1 )
	RegCurTrigger( 12792 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5761)	
	TriggerAction( 1, AddNextFlag, 1279, 20, 1 )
	RegCurTrigger( 12793 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5762)	
	TriggerAction( 1, AddNextFlag, 1279, 25, 1 )
	RegCurTrigger( 12794 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5763)	
	TriggerAction( 1, AddNextFlag, 1279, 30, 1 )
	RegCurTrigger( 12795 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5764)	
	TriggerAction( 1, AddNextFlag, 1279, 35, 1 )
	RegCurTrigger( 12796 )
		

	------------------------------------------------------dina(end)
	

------------------监狱指引---------监狱长
	MISSCRIPT_MISSIONSCRIPT07_LUA_001405 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001405")
	DefineMission ( 6230, MISSCRIPT_MISSIONSCRIPT07_LUA_001405, 1280 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001406 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001406")
	MisBeginTalk ( MISSCRIPT_MISSIONSCRIPT07_LUA_001406)
	MisBeginCondition( NoMission, 1280)
	MisBeginCondition( NoRecord, 1280)
	MisBeginAction( AddMission, 1280)
	MisCancelAction( ClearMission, 1280)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001407 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001407")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001407)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001408 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001408")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001408)
	MisResultCondition ( AlwaysFailure )

------------------监狱指引----------狱警
	MISSCRIPT_MISSIONSCRIPT07_LUA_001405 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001405")
	DefineMission ( 6231, MISSCRIPT_MISSIONSCRIPT07_LUA_001405, 1280, COMPLETE_SHOW )

	MisBeginCondition ( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001409 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001409")
	MisResultTalk ( MISSCRIPT_MISSIONSCRIPT07_LUA_001409)
	MisResultCondition( HasMission, 1280)
	MisResultCondition( NoRecord, 1280)
	MisResultAction( ClearMission, 1280)
	MisResultAction( SetRecord, 1280)

	
------------------1级圣王宝藏--------挑战废灵迷宫
	MISSCRIPT_MISSIONSCRIPT07_LUA_001410 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001410")
	DefineMission( 6232, MISSCRIPT_MISSIONSCRIPT07_LUA_001410, 1281 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001411 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001411")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001411)
	MisBeginCondition(NoMission, 1281)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5776, 1)
	MisBeginCondition(NoItem, 5786, 1)
	MisBeginCondition(NoItem, 5787, 1)
	MisBeginCondition(NoItem, 5788, 1)
	MisBeginCondition(NoItem, 5789, 1)
	MisBeginCondition(NoItem, 5790, 1)
	MisBeginAction(TakeItem, 5776, 1 )
	MisBeginAction(AddMission, 1281)
	
	MisBeginAction(AddTrigger, 12811, TE_GETITEM, 3434, 15 )
	MisBeginAction(AddTrigger, 12812, TE_GETITEM, 3435, 10 )
	MisBeginAction(AddTrigger, 12813, TE_GETITEM, 3436, 15 )
	MisCancelAction(ClearMission, 1281)
	MisNeed(MIS_NEED_ITEM, 3434, 15, 10, 15)
	MisNeed(MIS_NEED_ITEM, 3435, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 3436, 15, 30, 15)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001412 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001412)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001413)
	MisResultCondition(HasMission, 1281)	
	MisResultCondition(HasItem, 3434, 15 )
	MisResultCondition(HasItem, 3435, 10 )
	MisResultCondition(HasItem, 3436, 15 )
	MisResultAction(SetRecord, 1281)   --添加record1281
	MisResultAction(TakeItem, 3434, 15 )
	MisResultAction(TakeItem, 3435, 10 )
	MisResultAction(TakeItem, 3436, 15 )	
	MisResultAction(ClearMission, 1281)	      
	
	MisResultAction(GiveItem, 5786, 1, 4)    ----------给予玩家废旧的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 3434)	
	TriggerAction( 1, AddNextFlag, 1281, 10, 15)
	RegCurTrigger( 12811 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3435)	
	TriggerAction( 1, AddNextFlag, 1281, 20, 10 )
	RegCurTrigger( 12812 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3436)	
	TriggerAction( 1, AddNextFlag, 1281, 30, 15 )
	RegCurTrigger( 12813 )

	





	------------------1级圣王宝藏--------挑战沼泽迷宫
	MISSCRIPT_MISSIONSCRIPT07_LUA_001414 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001414")
	DefineMission( 6233, MISSCRIPT_MISSIONSCRIPT07_LUA_001414, 1282 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001415 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001415")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001415)
	MisBeginCondition(NoMission, 1282)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5791, 1)   --加纳罗伊的密函B
	MisBeginCondition(NoItem, 5786, 1)    --废旧的月光宝盒
	MisBeginCondition(NoItem, 5787, 1)    --陈旧的月光宝盒
	MisBeginCondition(NoItem, 5788, 1)    --崭新的月光宝盒
	MisBeginCondition(NoItem, 5789, 1)    --精致的月光宝盒
	MisBeginCondition(NoItem, 5790, 1)    --卓越的月光宝盒
	MisBeginAction(TakeItem, 5791, 1 )
	MisBeginAction(AddMission, 1282)
	
	MisBeginAction(AddTrigger, 12821, TE_GETITEM, 3445, 15 )
	MisBeginAction(AddTrigger, 12822, TE_GETITEM, 3443, 10 )
	MisBeginAction(AddTrigger, 12823, TE_GETITEM, 3444, 15 )
	MisCancelAction(ClearMission, 1282)
	MisNeed(MIS_NEED_ITEM, 3445, 15, 10, 15)
	MisNeed(MIS_NEED_ITEM, 3443, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 3444, 15, 30, 15)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001412 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001412)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001413)
	MisResultCondition(HasMission, 1282)
	MisResultCondition(HasItem, 3445, 15 )
	MisResultCondition(HasItem, 3443, 10 )
	MisResultCondition(HasItem, 3444, 15 )
	MisResultAction(SetRecord, 1282)   --添加record1282
	MisResultAction(TakeItem, 3445, 15 )
	MisResultAction(TakeItem, 3443, 10 )
	MisResultAction(TakeItem, 3444, 15 )	
	MisResultAction(ClearMission, 1282)
	      
	
	MisResultAction(GiveItem, 5786, 1, 4)    ----------废旧的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 3445)	
	TriggerAction( 1, AddNextFlag, 1282, 10, 15)
	RegCurTrigger( 12821 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3443)	
	TriggerAction( 1, AddNextFlag, 1282, 20, 10 )
	RegCurTrigger( 12822 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3444)	
	TriggerAction( 1, AddNextFlag, 1282, 30, 15 )
	RegCurTrigger( 12823 )
	
	
	------------------1级圣王宝藏--------挑战魔方迷宫
	MISSCRIPT_MISSIONSCRIPT07_LUA_001416 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001416")
	DefineMission( 6234, MISSCRIPT_MISSIONSCRIPT07_LUA_001416, 1283 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001417 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001417")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001417)
	MisBeginCondition(NoMission, 1283)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5792, 1)   --加纳罗伊的密函C
	MisBeginCondition(NoItem, 5786, 1)    --废旧的月光宝盒
	MisBeginCondition(NoItem, 5787, 1)    --陈旧的月光宝盒
	MisBeginCondition(NoItem, 5788, 1)    --崭新的月光宝盒
	MisBeginCondition(NoItem, 5789, 1)    --精致的月光宝盒
	MisBeginCondition(NoItem, 5790, 1)    --卓越的月光宝盒
	MisBeginAction(TakeItem, 5792, 1 )
	MisBeginAction(AddMission, 1283)
	MisBeginAction(AddTrigger, 12831, TE_GETITEM, 3820, 30 )
	MisBeginAction(AddTrigger, 12832, TE_GETITEM, 3821, 30 )
	MisBeginAction(AddTrigger, 12833, TE_GETITEM, 3822, 30 )
	MisCancelAction(ClearMission, 1283)
	MisNeed(MIS_NEED_ITEM, 3820, 30, 50, 30)
	MisNeed(MIS_NEED_ITEM, 3821, 30, 60, 30)
	MisNeed(MIS_NEED_ITEM, 3822, 30, 70, 30)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001412 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001412)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001413)
	MisResultCondition(HasMission, 1283)
	MisResultCondition(HasItem, 3820, 30 )
	MisResultCondition(HasItem, 3821, 30 )
	MisResultCondition(HasItem, 3822, 30 )
	MisResultAction(TakeItem, 3820, 30 )
	MisResultAction(TakeItem, 3821, 30 )
	MisResultAction(TakeItem, 3822, 30 )	
	MisResultAction(ClearMission, 1283)
	MisResultAction(SetRecord, 1283)   --添加record1283   
	
	MisResultAction(GiveItem, 5786, 1, 4)    ----------废旧的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 3820)	
	TriggerAction( 1, AddNextFlag, 1283, 50, 30 )
	RegCurTrigger( 12831 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3821)	
	TriggerAction( 1, AddNextFlag, 1283, 60, 30 )
	RegCurTrigger( 12832 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3822)	
	TriggerAction( 1, AddNextFlag, 1283, 70, 30 )
	RegCurTrigger( 12833 )

------------------2级圣王宝藏钥匙--------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001418 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001418")
	DefineMission( 6235, MISSCRIPT_MISSIONSCRIPT07_LUA_001418, 1284 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001419 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001419")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001419)
	MisBeginCondition(NoMission, 1284)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5793, 1)   --2级宝藏钥匙密函
	MisBeginCondition(NoItem, 5786, 1)    --废旧的月光宝盒
	MisBeginCondition(NoItem, 5787, 1)    --陈旧的月光宝盒
	MisBeginCondition(NoItem, 5788, 1)    --崭新的月光宝盒
	MisBeginCondition(NoItem, 5789, 1)    --精致的月光宝盒
	MisBeginCondition(NoItem, 5790, 1)    --卓越的月光宝盒
	MisBeginAction(TakeItem, 5793, 1 )    --取走道具2级宝藏钥匙密函
	MisBeginAction(AddMission, 1284)
	MisBeginAction(AddTrigger, 12841, TE_GETITEM, 2588, 10 )
	MisBeginAction(AddTrigger, 12842, TE_GETITEM, 0855, 99 )
	MisCancelAction(ClearMission, 1284)
	MisNeed(MIS_NEED_ITEM, 2588, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 0855, 99, 20, 99)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001420 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001420")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001420)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001413)
	MisResultCondition(HasMission, 1284)
	MisResultCondition(HasItem, 2588, 10 )
	MisResultCondition(HasItem, 0855, 99 )
	MisResultAction(TakeItem, 2588, 10 )
	MisResultAction(TakeItem, 0855, 99 )
	MisResultAction(ClearMission, 1284)
	MisResultAction(SetRecord, 1284)      --添加record1283   
	
	MisResultAction(GiveItem, 5787, 1, 4)    ----------陈旧的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 2588)	
	TriggerAction( 1, AddNextFlag, 1284, 10, 10)
	RegCurTrigger( 12841 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 0855)	
	TriggerAction( 1, AddNextFlag, 1284, 20, 99 )
	RegCurTrigger( 12842 )
	



------------------3级圣王宝藏钥匙--------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001421 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001421")
	DefineMission( 6236, MISSCRIPT_MISSIONSCRIPT07_LUA_001421, 1285 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001422 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001422")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001422)
	MisBeginCondition(NoMission, 1285)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5794, 1)   --3级宝藏钥匙密函
	MisBeginCondition(NoItem, 5786, 1)    --废旧的月光宝盒
	MisBeginCondition(NoItem, 5787, 1)    --陈旧的月光宝盒
	MisBeginCondition(NoItem, 5788, 1)    --崭新的月光宝盒
	MisBeginCondition(NoItem, 5789, 1)    --精致的月光宝盒
	MisBeginCondition(NoItem, 5790, 1)    --卓越的月光宝盒
	MisBeginAction(TakeItem, 5794, 1 )    --取走道具3级宝藏钥匙密函
	MisBeginAction(AddMission, 1285)
	MisBeginAction(AddTrigger, 12851, TE_GETITEM, 4511, 30 )
	MisBeginAction(AddTrigger, 12852, TE_GETITEM, 0855, 99 )
	MisCancelAction(ClearMission, 1285)
	MisNeed(MIS_NEED_ITEM, 4511, 30, 10, 30)
	MisNeed(MIS_NEED_ITEM, 0855, 99, 20, 99)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001423 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001423")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001423)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001424 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001424")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001424)
	MisResultCondition(HasMission, 1285)
	MisResultCondition(HasItem, 4511, 30 )
	MisResultCondition(HasItem, 0855, 99 )
	MisResultCondition(HasCredit, 1000 )       --需要名声1000
	MisResultCondition(HasHonorPoint, 50 )     --需要荣誉50
	MisResultAction(TakeItem, 4511, 30 )
	MisResultAction(TakeItem, 0855, 99 )
	MisResultAction(ClearMission, 1285)
	MisResultAction(SetRecord, 1285)   --添加record1283      
	
	MisResultAction(GiveItem, 5788, 1, 4)    ----------崭新的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 4511)	
	TriggerAction( 1, AddNextFlag, 1285, 10, 30)
	RegCurTrigger( 12851 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 0855)	
	TriggerAction( 1, AddNextFlag, 1285, 20, 99 )
	RegCurTrigger( 12852 )


------------------4级圣王宝藏钥匙--------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001425 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001425")
	DefineMission( 6237, MISSCRIPT_MISSIONSCRIPT07_LUA_001425, 1286 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001419 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001419")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001419)
	MisBeginCondition(NoMission, 1286)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5795, 1)   --4级宝藏钥匙密函
	MisBeginCondition(NoItem, 5786, 1)    --废旧的月光宝盒
	MisBeginCondition(NoItem, 5787, 1)    --陈旧的月光宝盒
	MisBeginCondition(NoItem, 5788, 1)    --崭新的月光宝盒
	MisBeginCondition(NoItem, 5789, 1)    --精致的月光宝盒
	MisBeginCondition(NoItem, 5790, 1)    --卓越的月光宝盒
	MisBeginAction(TakeItem, 5795, 1 )    --取走道具4级宝藏钥匙密函
	MisBeginAction(AddMission, 1286)
	MisBeginAction(AddTrigger, 12861, TE_GETITEM, 0266, 1 )
	MisBeginAction(AddTrigger, 12862, TE_GETITEM, 2589, 1 )
	MisBeginAction(AddTrigger, 12863, TE_GETITEM, 3000, 1 )
	MisCancelAction(ClearMission, 1286)
	MisNeed(MIS_NEED_ITEM, 0266, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2589, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 3000, 1, 30, 1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001426 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001426")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001426)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001413)
	MisResultCondition(HasMission, 1286)
	MisResultCondition(HasItem, 0266, 1 )
	MisResultCondition(HasItem, 2589, 1 )
	MisResultCondition(HasItem, 3000, 1 )
	MisResultAction(TakeItem, 0266, 1 )
	MisResultAction(TakeItem, 2589, 1 )
	MisResultAction(TakeItem, 3000, 1 )
	MisResultAction(ClearMission, 1286)
	MisResultAction(SetRecord, 1286)      --添加record1286 
	
	MisResultAction(GiveItem, 5789, 1, 4)    ---------精致的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 0266)	
	TriggerAction( 1, AddNextFlag, 1286, 10, 1)
	RegCurTrigger( 12861 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 2589)	
	TriggerAction( 1, AddNextFlag, 1286, 20, 1 )
	RegCurTrigger( 12862 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3000)	
	TriggerAction( 1, AddNextFlag, 1286, 40, 1 )
	RegCurTrigger( 12863 )

------------------5级圣王宝藏钥匙--------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001427 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001427")
	DefineMission( 6238, MISSCRIPT_MISSIONSCRIPT07_LUA_001427, 1287 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001419 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001419")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001419)
	MisBeginCondition(NoMission, 1287)
	MisBeginCondition(NoRecord, 1281)
	MisBeginCondition(NoRecord, 1282)
	MisBeginCondition(NoRecord, 1283)
	MisBeginCondition(NoRecord, 1284)
	MisBeginCondition(NoRecord, 1285)
	MisBeginCondition(NoRecord, 1286)
	MisBeginCondition(NoRecord, 1287)
	MisBeginCondition(HasItem, 5796, 1)   --5级宝藏钥匙密函
	MisBeginCondition(NoItem, 5786, 1)    --废旧的月光宝盒
	MisBeginCondition(NoItem, 5787, 1)    --陈旧的月光宝盒
	MisBeginCondition(NoItem, 5788, 1)    --崭新的月光宝盒
	MisBeginCondition(NoItem, 5789, 1)    --精致的月光宝盒
	MisBeginCondition(NoItem, 5790, 1)    --卓越的月光宝盒
	MisBeginAction(TakeItem, 5796, 1 )    --取走道具4级宝藏钥匙密函
	MisBeginAction(AddMission, 1287)
	MisBeginAction(AddTrigger, 12871, TE_GETITEM, 2589, 5 )
	MisBeginAction(AddTrigger, 12872, TE_GETITEM, 5703, 2 )
	MisBeginAction(AddTrigger, 12873, TE_GETITEM, 3000, 1 )
	MisBeginAction(AddTrigger, 12874, TE_GETITEM, 3122, 5 )
	MisCancelAction(ClearMission, 1287)
	MisNeed(MIS_NEED_ITEM, 2589, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 5703, 2, 20, 2)
	MisNeed(MIS_NEED_ITEM, 3000, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 3122, 5, 40, 5)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001428 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001428")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001428)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001413)
	MisResultCondition(HasMission, 1287)
	MisResultCondition(HasItem, 2589, 5 )
	MisResultCondition(HasItem, 5703, 2 )
	MisResultCondition(HasItem, 3000, 1 )
	MisResultCondition(HasItem, 3122, 5 )
	MisResultAction(TakeItem, 2589, 5 )
	MisResultAction(TakeItem, 5703, 2 )
	MisResultAction(TakeItem, 3000, 1 )
	MisResultAction(TakeItem, 3122, 5 )
	MisResultAction(ClearMission, 1287)
	MisResultAction(SetRecord, 1287)      --添加record1287 
	
	MisResultAction(GiveItem, 5790, 1, 4)    ---------卓越的月光宝盒
	MisResultBagNeed(1)                     ---------因为任务完成要给道具给玩家，所以注意留下背包空格

	InitTrigger()
	TriggerCondition( 1, IsItem, 2589)	
	TriggerAction( 1, AddNextFlag, 1287, 10, 5)
	RegCurTrigger( 12871 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5703)	
	TriggerAction( 1, AddNextFlag, 1287, 20, 2 )
	RegCurTrigger( 12872 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3000)	
	TriggerAction( 1, AddNextFlag, 1287, 30, 1 )
	RegCurTrigger( 12873 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3122)	
	TriggerAction( 1, AddNextFlag, 1287, 40, 5 )
	RegCurTrigger( 12874 )	

--------------------圣斗士的cosplay----------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001429")
	DefineMission( 6239, MISSCRIPT_MISSIONSCRIPT07_LUA_001429, 1288 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001430 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001430")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001430)
	MisBeginCondition(NoMission, 1288)
	MisBeginCondition(NoRecord, 1288)
	MisBeginCondition(NoRecord, 1300)
	MisBeginCondition(NoRecord, 1303)
	MisBeginCondition(NoRecord, 1304)
	MisBeginAction(AddMission, 1288)
	MisBeginAction(SetRecord, 1288)
	MisCancelAction(ClearMission, 1288)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001431 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001431")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001431)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001432 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001432")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001432)
	MisResultCondition(AlwaysFailure)	
-------------------圣斗士的cosplay——星矢----------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001429")
	DefineMission( 6240, MISSCRIPT_MISSIONSCRIPT07_LUA_001429, 1288 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001433 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001433")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001433)
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001434 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001434")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001434)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasMission,1288)
	MisResultCondition(NoRecord,1289)
	MisResultAction(SetRecord,1289)
	
---------------星矢的考验---------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001435 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001435")
	DefineMission( 6241, MISSCRIPT_MISSIONSCRIPT07_LUA_001435, 1289)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001436 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001436")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001436)
	
	MisBeginCondition(HasMission, 1288)
	MisBeginCondition(HasRecord, 1288)
	MisBeginCondition(HasRecord, 1289)	
	MisBeginCondition(NoRecord, 1291)	
	MisBeginAction(AddMission, 1289)
	MisBeginAction(SetRecord, 1290)
	MisCancelAction(ClearMission, 1289)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001437 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001437")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001437)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001438 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001438")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001438)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001439 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001439")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001439)

	MisResultCondition(HasMission, 1289)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasRecord, 1289)
	MisResultCondition(HasRecord, 1290)

	MisResultCondition(HasItem, 3116, 30)
	MisResultCondition(HasItem, 4495, 1)
	

	MisResultAction(TakeItem, 3116, 30)
	MisResultAction(TakeItem, 4495, 1)
	MisResultAction(ClearRecord, 1290)
	

	MisResultAction(GiveItem, 5813, 1, 4)                          
	MisResultAction(GiveItem, 3094, 1, 4)                          
	MisResultAction(ClearMission, 1289) 
	MisResultAction(SetRecord, 1291) 
	MisResultBagNeed(2)

-------------------圣斗士的cosplay——紫龙----------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001429")
	DefineMission( 6242, MISSCRIPT_MISSIONSCRIPT07_LUA_001429, 1288 )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001433 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001433")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001433)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001434 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001434")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001434)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasMission,1288)
	MisResultCondition(NoRecord,1292)
	MisResultAction(SetRecord,1292)
---------------紫龙的考验---------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001440 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001440")
	DefineMission( 6243, MISSCRIPT_MISSIONSCRIPT07_LUA_001440, 1290)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001441 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001441")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001441)
	MisBeginCondition(HasMission, 1288)
	MisBeginCondition(HasRecord, 1288)
	MisBeginCondition(HasRecord, 1292)	
	MisBeginCondition(NoRecord, 1294)	
	MisBeginCondition(NoRecord, 1295)		
	MisBeginAction(AddMission, 1290)
	MisBeginAction(SetRecord, 1294)
	MisCancelAction(ClearMission, 1290)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001442 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001442")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001442)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001443 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001443")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001443)
	
	
	MisResultCondition(HasMission, 1290)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasRecord, 1292)
	MisResultCondition(HasRecord, 1293)
	MisResultCondition(HasRecord, 1294)
	
	
	MisResultAction(GiveItem, 5814, 1, 4)
	MisResultAction(GiveItem, 3094, 1, 4)	                          
	MisResultAction(ClearMission, 1290) 
	MisResultAction(ClearRecord, 1294) 	
	MisResultAction(ClearRecord, 1293) 	
	MisResultAction(SetRecord, 1295) 
	MisResultBagNeed(2)

-----------圣斗士的cosplay——冰河---------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001429")
	DefineMission( 6244, MISSCRIPT_MISSIONSCRIPT07_LUA_001429, 1288 )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001433 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001433")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001433)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001434 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001434")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001434)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasMission,1288)
	MisResultCondition(NoRecord,1296)
	MisResultAction(SetRecord,1296)
---------------冰河的考验---------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001444 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001444")
	DefineMission( 6245, MISSCRIPT_MISSIONSCRIPT07_LUA_001444, 1291)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001445 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001445")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001445)
	MisBeginCondition(HasMission, 1288)
	MisBeginCondition(HasRecord, 1288)
	MisBeginCondition(HasRecord, 1296)	
	MisBeginCondition(NoRecord, 1297)	
	MisBeginCondition(NoRecord, 1298)		
	MisBeginAction(AddMission, 1291)
	MisBeginAction(SetRecord, 1297)
	MisBeginAction(AddTrigger, 12911, TE_KILL, 1070, 1)
	MisCancelAction(ClearMission, 1291)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001446 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001446")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001446)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001447 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001447")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001447)
	
	MisResultCondition( HasFlag, 1291, 10)
	MisResultCondition(HasMission, 1291)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasRecord, 1297)
	MisResultCondition(HasRecord, 1296)
	MisResultCondition(HasRecord, 1298)
	

	MisResultAction(GiveItem, 5815, 1, 4)
	MisResultAction(ClearMission, 1291) 
	MisResultAction(ClearRecord, 1297)
	MisResultAction(ClearRecord, 1298)
	MisResultAction(SetRecord, 1299) 
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1070)	
	TriggerAction( 1, AddNextFlag, 1291, 10, 1 )
	RegCurTrigger( 12911 )
---------------瞬的考验---------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001429")
	DefineMission( 6246, MISSCRIPT_MISSIONSCRIPT07_LUA_001429, 1288 )
	MisBeginCondition(AlwaysFailure )
    MISSCRIPT_MISSIONSCRIPT07_LUA_001433 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001433")
    MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001433)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001448 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001448")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001448)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasMission,1288)
	MisResultCondition(NoMission,1289)
	MisResultCondition(NoMission,1290)
	MisResultCondition(NoMission,1291)	
	MisResultCondition(HasRecord, 1289)
	MisResultCondition(HasRecord, 1291)
	MisResultCondition(HasRecord, 1292)
	MisResultCondition(HasRecord, 1295)
	MisResultCondition(HasRecord, 1296)
	MisResultCondition(HasRecord, 1299)
	MisResultAction(ClearRecord, 1289)
	MisResultAction(ClearRecord, 1291)
	MisResultAction(ClearRecord, 1292)
	MisResultAction(ClearRecord, 1295)
	MisResultAction(ClearRecord, 1296)
	MisResultAction(ClearRecord, 1299)
	MisResultAction(SetRecord, 1300)
	MisResultAction(SetRecord, 1301)	
	MisResultAction(GiveItem, 5806, 1, 4)
	MisResultAction(TakeItem, 5815, 1, 4)
	MisResultAction(TakeItem, 5814, 1, 4)
	MisResultAction(TakeItem, 5813, 1, 4)
	MisResultBagNeed(1)

------------------------------------------一辉的考验--------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001429")
	DefineMission( 6247, MISSCRIPT_MISSIONSCRIPT07_LUA_001429, 1288 )
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT07_LUA_001449 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001449")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001449)
	MisResultCondition(HasRecord, 1288)
	MisResultCondition(HasMission,1288)
	MisResultCondition(HasRecord, 1300)
	MisResultCondition(HasRecord, 1301)
	MisResultAction(ClearRecord, 1288)
	MisResultAction(ClearRecord, 1301)
	MisResultAction(ClearMission, 1288)
	MisResultAction(SetRecord, 1302)
--------------------------------------击杀邪恶教皇----------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001450 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001450")
	DefineMission( 6248, MISSCRIPT_MISSIONSCRIPT07_LUA_001450, 1292 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001451 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001451")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001451)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001452 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001452")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001452)
	MisBeginCondition(HasRecord, 1302)
	MisBeginCondition(LvCheck, ">", 54 )
	MisBeginCondition(NoRecord, 1303)
	MisBeginCondition(NoRecord, 1304)	
	MisBeginCondition(NoMission, 1291)		
	MisBeginAction(AddMission, 1292)
	MisBeginAction(SetRecord, 1303)
	MisBeginAction(AddTrigger, 12921, TE_KILL, 1071, 1)
	MisNeed(MIS_NEED_KILL, 1071, 1, 10, 1)
	MisCancelAction(ClearMission, 1292)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 1071)	
	TriggerAction( 1, AddNextFlag, 1292, 10, 1 )
	RegCurTrigger( 12921 )

	MisResultCondition(AlwaysFailure)	
------------------------------------兑换六.一礼物------------
	MISSCRIPT_MISSIONSCRIPT07_LUA_001450 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001450")
	DefineMission( 6249, MISSCRIPT_MISSIONSCRIPT07_LUA_001450, 1292 )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001453 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001453")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001453)

	MisResultCondition( HasFlag, 1292, 10)
	MisResultCondition(HasMission, 1292)
	MisResultCondition(HasRecord, 1303)
	MisResultCondition(HasRecord, 1305)
	
	

	MisResultAction(GiveItem, 5812, 1, 4)
	MisResultAction(ClearMission, 1292) 
	MisResultAction(ClearRecord, 1303)
	MisResultAction(SetRecord, 1304) 
	MisResultBagNeed(1)
	
	------------------------------------奥运活动 之 失踪的圣火------------  圣火传递大使
	MISSCRIPT_MISSIONSCRIPT07_LUA_001454 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001454")
	DefineMission( 6250, MISSCRIPT_MISSIONSCRIPT07_LUA_001454, 1306 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001455 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001455")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001455)
	MisBeginCondition(NoMission, 1306)
	MisBeginCondition(NoRecord, 1306)
	MisBeginCondition(NoRecord, 1307)
	MisBeginCondition(NoRecord, 1308)
	MisBeginCondition(NoRecord, 1309)
	MisBeginCondition(NoRecord, 1314)
	MisBeginCondition(NoRecord, 1315)
	MisBeginCondition(NoRecord, 1316)
	MisBeginCondition(NoRecord, 1317)
	MisBeginCondition(NoRecord, 1318)
	MisBeginCondition(NoRecord, 1319)
	MisBeginCondition(NoRecord, 1321)
	MisBeginCondition(NoRecord, 1322)
	MisBeginCondition(NoRecord, 1323)
	MisBeginAction(AddMission, 1306)
	MisCancelAction(ClearMission, 1306)
	MisBeginAction(AddTrigger, 13061, TE_KILL, 45, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001456 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001456")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001456)
	MisNeed(MIS_NEED_KILL, 45, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001457 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001457")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001457)	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001458 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001458")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001458)
	MisResultCondition(HasMission, 1306)
	MisResultCondition(HasFlag, 1306, 19)	
	
	MisResultAction(ClearMission,1306)
	MisResultAction(SetRecord,1306)
	MisResultBagNeed(2)
	MisResultAction(GiveItem, 5802, 1, 4)
	MisResultAction(GiveItem, 5841, 1, 4)
	MisResultAction( AddMoney , 5000)
	
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 45)	
	TriggerAction( 1, AddNextFlag, 1306, 10, 10 )
	RegCurTrigger( 13061 )
	
	
	----------------------------------奥运活动 之 重铸圣火火炬------------ 铁匠暴冰
	MISSCRIPT_MISSIONSCRIPT07_LUA_001459 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001459")
	DefineMission( 6251, MISSCRIPT_MISSIONSCRIPT07_LUA_001459,1307 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001460 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001460")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001460)
	MisBeginCondition(NoMission, 1307)
	MisBeginCondition(HasRecord, 1306)
	MisBeginCondition(HasItem, 5802, 1)
	MisBeginCondition(HasItem, 5841, 1)
	
	MisBeginAction(AddMission, 1307)
	MisCancelAction(ClearMission, 1307)
	MisBeginAction(TakeItem, 5841, 1, 4)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001461 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001461")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001461)
	
	MisBeginAction( AddTrigger, 13071, TE_GETITEM, 3989, 15)
	MisBeginAction( AddTrigger, 13072, TE_GETITEM, 4546, 10)
	
	MisNeed( MIS_NEED_ITEM, 3989, 15, 10, 15)
	MisNeed( MIS_NEED_ITEM, 4546, 10, 20, 10)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001462 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001462")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001462)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001463 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001463")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001463)
	MisResultCondition( HasMission, 1307)
	MisResultCondition( HasRecord, 1306)
	MisResultCondition( HasItem, 3989, 15)
	MisResultCondition( HasItem, 4546, 10)
	MisResultCondition( HasItem, 5802, 1)


	MisResultAction( TakeItem, 3989, 15)
	MisResultAction( TakeItem, 4546, 10)
	MisResultAction( TakeItem, 5802, 1)
	MisResultAction( AddMoney , 5000)
	MisResultAction( ClearMission, 1307)
	MisResultAction( ClearRecord, 1306)
	MisResultAction( SetRecord, 1307)
	
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3989)	
	TriggerAction( 1, AddNextFlag, 1307, 10, 15)
	RegCurTrigger( 13071 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4546)	
	TriggerAction( 1, AddNextFlag, 1307, 20, 10)
	RegCurTrigger( 13072 )
	
	----------------------------------奥运活动 之 铁匠的要求------------  铁匠暴冰
	MISSCRIPT_MISSIONSCRIPT07_LUA_001459 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001459")
	DefineMission( 6252, MISSCRIPT_MISSIONSCRIPT07_LUA_001459,1308 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001464 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001464")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001464)
	MisBeginCondition(NoMission, 1308)
	MisBeginCondition(NoRecord, 1308)
	MisBeginCondition(HasRecord, 1307)
	
	MisBeginAction(AddMission, 1308)
	MisCancelAction(ClearMission, 1308)
	
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001465 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001465")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001465)
	
	MisBeginAction( AddTrigger, 13081, TE_GETITEM, 3117, 10)
	MisBeginAction( AddTrigger, 13082, TE_GETITEM, 3136, 10)
	
	MisNeed( MIS_NEED_ITEM, 3117, 10, 10, 10)
	MisNeed( MIS_NEED_ITEM, 3136, 10, 20, 10)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001466 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001466")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001466)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001467 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001467")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001467)
	MisResultCondition( HasMission, 1308)
	MisResultCondition( HasRecord, 1307)
	MisResultCondition( HasItem, 3117, 10)
	MisResultCondition( HasItem, 3136, 10)

	MisResultBagNeed(1)
	MisResultAction( TakeItem, 3117, 10)
	MisResultAction( TakeItem, 3136, 10)
	MisResultAction(GiveItem, 5842, 1, 4)       
	MisResultAction( ClearMission, 1308)
	MisResultAction( ClearRecord, 1307)
	MisResultAction( SetRecord, 1308)
	MisResultAction( AddMoney , 5000)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3117)	
	TriggerAction( 1, AddNextFlag, 1308, 10, 10)
	RegCurTrigger( 13081 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3136)	
	TriggerAction( 1, AddNextFlag, 1308, 20, 10)
	RegCurTrigger( 13082 )
	
----------------------------------奥运活动 之 点燃圣火------------铁匠暴冰（开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001468 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001468")
	DefineMission( 6253, MISSCRIPT_MISSIONSCRIPT07_LUA_001468,1309 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001469 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001469")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001469)
	MisBeginCondition(NoRecord, 1309 )
	MisBeginCondition(NoMission, 1309 )
	MisBeginCondition(HasRecord, 1308 )
	MisBeginAction(AddMission, 1309 )
	MisCancelAction(ClearMission, 1309)
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001470 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001470")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001470)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001471 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001471")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001471)
	MisResultCondition( AlwaysFailure )
	
----------------------------------奥运活动 之 点燃圣火------------圣火传递大使（结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001468 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001468")
	DefineMission( 6254, MISSCRIPT_MISSIONSCRIPT07_LUA_001468,1309, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001472 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001472")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001472)
	MisResultCondition( HasMission, 1309)
	MisResultCondition( NoRecord, 1309)
	MisResultCondition( HasItem, 5842, 1)
	MisResultAction( ClearMission, 1309)
	MisResultAction( SetRecord, 1309)
	MisResultAction( AddMoney , 5000)

----------------------------------奥运活动 之 仁爱之心------------圣火传递大使	（开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001473 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001473")
	DefineMission( 6255, MISSCRIPT_MISSIONSCRIPT07_LUA_001473,1310 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001474 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001474")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001474)
	MisBeginCondition(NoRecord, 1310 )
	MisBeginCondition(NoMission, 1310 )
	MisBeginCondition(HasRecord, 1309 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1310)
	MisCancelAction(ClearMission, 1310)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001475 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001475")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001475)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001476 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001476")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001476)
	MisResultCondition( AlwaysFailure )
----------------------------------奥运活动 之 仁爱之心------------路人·巴比	（结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001473 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001473")
	DefineMission( 6256, MISSCRIPT_MISSIONSCRIPT07_LUA_001473,1310, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001477 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001477")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001477)
	MisResultCondition( HasMission, 1310)
	MisResultCondition( NoRecord, 1310)
	MisResultCondition( HasItem, 5842, 1)
	MisResultAction( ClearMission, 1310)
	MisResultAction( SetRecord, 1310)
	MisResultAction( AddMoney , 5000)
----------------------------------奥运活动 之 仁爱之心2------------路人·巴比	（开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001478 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001478")
	DefineMission( 6257, MISSCRIPT_MISSIONSCRIPT07_LUA_001478,1311 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001479 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001479")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001479)
	MisBeginCondition(NoRecord, 1311 )
	MisBeginCondition(NoMission, 1311 )
	MisBeginCondition(HasRecord, 1310 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1311)
	MisCancelAction(ClearMission, 1311)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001480 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001480")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001480)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001481 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001481")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001481)
	MisResultCondition( AlwaysFailure )
----------------------------------奥运活动 之 仁爱之心2------------人鱼王子·哈沙特	（结束）
    MISSCRIPT_MISSIONSCRIPT07_LUA_001478 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001478")
    DefineMission( 6258, MISSCRIPT_MISSIONSCRIPT07_LUA_001478,1311, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001482 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001482")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001482)
	MisResultCondition( HasMission, 1311)
	MisResultCondition( NoRecord, 1311)
	MisResultCondition( HasItem, 5842, 1)
	MisResultAction( ClearMission, 1311)
	MisResultAction( SetRecord, 1311)
	MisResultAction( AddMoney , 5000)
----------------------------------奥运活动 之 仁爱之心3------------人鱼王子·哈沙特	（开始）
    MISSCRIPT_MISSIONSCRIPT07_LUA_001483 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001483")
    DefineMission( 6259, MISSCRIPT_MISSIONSCRIPT07_LUA_001483,1312 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001484 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001484")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001484)
	MisBeginCondition(NoRecord, 1312 )
	MisBeginCondition(NoMission, 1312)
	MisBeginCondition(HasRecord, 1311 )
	MisBeginCondition( HasItem, 5842, 1)
   	MisBeginAction(AddMission, 1312)
	MisCancelAction(ClearMission, 1312)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001485 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001485")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001485)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001486 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001486")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001486)
	MisResultCondition( AlwaysFailure )
----------------------------------奥运活动 之 仁爱之心3------------海港指挥·乔尔尼	（结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001483 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001483")
	DefineMission( 6260, MISSCRIPT_MISSIONSCRIPT07_LUA_001483,1312, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001487 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001487")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001487)
	MisResultCondition( HasMission, 1312)
	MisResultCondition( NoRecord, 1312)
	MisResultCondition( HasItem, 5842, 1)
	MisResultAction( ClearMission, 1312)
	MisResultAction( SetRecord, 1312)
	MisResultAction( AddMoney , 5000)
----------------------------------奥运活动 之 仁爱之心4------------海港指挥·乔尔尼	（开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001488 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001488")
	DefineMission( 6261, MISSCRIPT_MISSIONSCRIPT07_LUA_001488,1313 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001489 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001489")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001489)
	MisBeginCondition(NoRecord, 1313 )
	MisBeginCondition(NoMission, 1313)
	MisBeginCondition(HasRecord, 1312 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1313)
	MisCancelAction(ClearMission, 1313)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001490 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001490")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001490)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001491 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001491")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001491)
	MisResultCondition( AlwaysFailure )
----------------------------------奥运活动 之 仁爱之心4------------中年男子·比盖	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001488 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001488")
	DefineMission( 6262, MISSCRIPT_MISSIONSCRIPT07_LUA_001488,1313, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001492 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001492")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001492)
	MisResultCondition( HasMission, 1313)
	MisResultCondition( NoRecord, 1313)
	MisResultCondition( HasItem, 5842, 1)
	MisResultAction( ClearMission, 1313)
	MisResultAction( SetRecord, 1313)
	MisResultAction( AddMoney , 5000)
----------------------------------奥运活动 之 仁爱之心5------------中年男子·比盖	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001493 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001493")
	DefineMission( 6263, MISSCRIPT_MISSIONSCRIPT07_LUA_001493,1314 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001494 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001494")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001494)
	MisBeginCondition(NoRecord, 1314 )
	MisBeginCondition(NoMission, 1314)
	MisBeginCondition(HasRecord, 1313 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1314)
	MisCancelAction(ClearMission, 1314)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001495 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001495")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001495)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001496 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001496")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001496)
	MisResultCondition( AlwaysFailure )
----------------------------------奥运活动 之 仁爱之心5------------地狱传送使	 （结束）
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001493 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001493")
	DefineMission( 6264, MISSCRIPT_MISSIONSCRIPT07_LUA_001493,1314, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001497 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001497")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001497)
	MisResultCondition( HasMission, 1314)
	MisResultCondition( NoRecord, 1314)
	MisResultCondition( HasItem, 5842, 1)
	MisResultAction( ClearMission, 1314)
	MisResultAction( SetRecord, 1314)
	MisResultAction( AddMoney , 5000)
----------------------------------奥运活动 之 仁爱之心6-----------地狱传送使	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001498 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001498")
	DefineMission( 6265, MISSCRIPT_MISSIONSCRIPT07_LUA_001498,1315 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001499 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001499")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001499)
	MisBeginCondition(NoRecord, 1315 )
	MisBeginCondition(NoMission, 1315)
	MisBeginCondition(HasRecord, 1314 )
	MisBeginCondition( HasItem, 5842, 1)
    	MisBeginAction(AddMission, 1315)
	MisCancelAction(ClearMission, 1315)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001500 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001500")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001500)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001501 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001501")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001501)
	MisResultCondition( AlwaysFailure )

----------------------------------奥运活动 之 仁爱之心6------------圣火传递大使	 （结束）
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001498 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001498")
	DefineMission( 6266, MISSCRIPT_MISSIONSCRIPT07_LUA_001498,1315, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001502 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001502")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001502)
	MisResultCondition( HasMission, 1315)
	MisResultCondition( NoRecord, 1315)
	MisResultCondition( HasItem, 5842, 1)
	--MisResultCondition( ItemAttrNum, 5825, 6, 10000, 0)
	MisResultBagNeed(1)
	MisResultAction( ClearMission, 1315)
	MisResultAction( SetRecord, 1315)

	MisResultAction( GiveItem, 5797 , 1 , 4)
	MisResultAction( AddMoney , 5000)

	
	----------------------------------奥运活动  之 无谓之心------------圣火传递大使	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001503 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001503")
	DefineMission( 6267, MISSCRIPT_MISSIONSCRIPT07_LUA_001503,1316 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001504 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001504")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001504)
	MisBeginCondition(NoRecord, 1316)
	MisBeginCondition(NoMission, 1316)
	MisBeginCondition(HasRecord, 1315 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1316)
	MisCancelAction(ClearMission, 1316)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001505 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001505")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001505)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001506 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001506")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001506)
	MisResultCondition( AlwaysFailure )
	
	---------------------------------奥运活动 之 无谓之心------------乱斗管理员	 （结束）	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001503 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001503")
	DefineMission( 6268, MISSCRIPT_MISSIONSCRIPT07_LUA_001503,1316, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001507 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001507")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001507)
	MisResultCondition( HasMission, 1316)
	MisResultCondition( NoRecord, 1316)
	MisResultCondition( HasItem, 5842, 1)	
	MisResultAction( ClearMission, 1316)
	MisResultAction( ClearRecord, 1315)
	MisResultAction( SetRecord, 1316)
	MisResultAction( AddMoney , 5000)
	
	----------------------------------奥运活动  之 无谓之心一------------乱斗管理员	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001508 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001508")
	DefineMission( 6269, MISSCRIPT_MISSIONSCRIPT07_LUA_001508,1317 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001509 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001509")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001509)
	MisResultBagNeed(1)
	MisBeginCondition(NoRecord, 1317)
	MisBeginCondition(NoMission, 1317)
	MisBeginCondition(HasRecord, 1316 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1317)
	
	MisBeginAction(GiveItem, 5803, 1 ,41)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SysteamNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisResultCondition( AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001510 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001510")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001510)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001511 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001511")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001511)
	MisBeginBagNeed(1)
	
	---------------------------------奥运活动 之 无谓之心一------------圣火传递大使	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001508 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001508")
	DefineMission( 6270, MISSCRIPT_MISSIONSCRIPT07_LUA_001508,1317)
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001512 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001512")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001512)	
	
	MisResultCondition(HasMission, 1317)
	MisResultCondition(HasRecord, 1316)	
	MisResultCondition(HasItem, 5842, 1)
	MisResultCondition(CheckPoint, 5803)

	MisResultBagNeed(2)
	MisResultAction(TakeItem, 5803, 1)
	MisResultAction(ClearMission, 1317) 
	MisResultAction(ClearRecord, 1316)
	MisResultAction(GiveItem, 5798, 1, 4)
	MisResultAction(GiveItem, 3096, 2, 4)
	MisResultAction(ClearRecord, 1316)
	MisResultAction(SetRecord, 1317) 
	MisResultAction( AddMoney , 5000)
	MisResultBagNeed(1)
	
	---------------------------------奥运活动 之 奉献之心------------圣火传递大使	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001513 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001513")
	DefineMission( 6271, MISSCRIPT_MISSIONSCRIPT07_LUA_001513,1318 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001514 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001514")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001514)
	MisBeginCondition(NoRecord, 1318)
	MisBeginCondition(NoMission, 1318)
	MisBeginCondition(HasRecord, 1317 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1318)
	MisCancelAction(ClearMission, 1318)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001515 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001515")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001515)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001516 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001516")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001516)
	MisResultCondition( AlwaysFailure )
	
	---------------------------------奥运活动 之 奉献之心------------矿工大肚腩	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001513 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001513")
	DefineMission( 6272, MISSCRIPT_MISSIONSCRIPT07_LUA_001513,1318, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001517 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001517")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001517)	
	MisResultCondition(HasMission, 1318)
	MisResultCondition(HasRecord, 1317)	
	MisResultCondition(HasItem, 5842, 1)
	MisResultAction(ClearMission, 1318)
	MisResultAction(ClearRecord, 1317)
	MisResultAction(SetRecord, 1318) 
	MisResultAction( AddMoney , 5000)
	
	---------------------------------奥运活动 之 奉献之心一------------矿工大肚腩	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001518 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001518")
	DefineMission( 6273, MISSCRIPT_MISSIONSCRIPT07_LUA_001518,1319 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001519 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001519")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001519)
	MisBeginCondition(NoRecord, 1319)
	MisBeginCondition(NoMission, 1319)
	MisBeginCondition(HasRecord, 1318 )	
	MisBeginAction(AddMission, 1319)
	MisCancelAction(ClearMission, 1319)

	MISSCRIPT_MISSIONSCRIPT07_LUA_001520 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001520")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001520)	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001521 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001521")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001521)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001522 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001522")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001522)	
	
	MisResultCondition(HasMission, 1319)
	MisResultCondition(HasRecord, 1318)
	MisResultCondition(HasItem, 2588, 5)
	
	MisResultAction(ClearMission, 1319)	
	MisResultAction(TakeItem, 2588,5)
	MisResultAction(ClearRecord, 1318)
	MisResultAction(SetRecord, 1319) 
	MisResultAction( AddMoney , 5000)


	---------------------------------奥运活动 之 奉献之心二------------矿工大肚腩	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001523 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001523")
	DefineMission( 6274, MISSCRIPT_MISSIONSCRIPT07_LUA_001523,1320 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001524 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001524")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001524)
	MisBeginCondition(NoRecord, 1320)
	MisBeginCondition(NoMission, 1320)
	MisBeginCondition(HasRecord, 1319 )
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1320)
	MisCancelAction(ClearMission, 1320)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001525 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001525")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001525)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001526 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001526")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001526)
	MisResultCondition( AlwaysFailure )
	
	---------------------------------奥运活动 之 奉献之心二------------圣火传递大使	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001523 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001523")
	DefineMission( 6275, MISSCRIPT_MISSIONSCRIPT07_LUA_001523,1320, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001527 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001527")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001527)	
	MisResultCondition(HasMission, 1320)
	MisResultCondition(HasRecord, 1319)	
	MisResultCondition(HasItem, 5842, 1)

	MisResultBagNeed(1)
	MisResultAction(ClearMission, 1320)
	MisResultAction(ClearRecord, 1319)
	MisResultAction(SetRecord, 1320) 
	MisResultAction(GiveItem, 5800,1,4)
	MisResultAction( AddMoney , 5000)

	
	---------------------------------奥运活动 之 智慧之心-----------圣火传递大使 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001528 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001528")
	DefineMission( 6276, MISSCRIPT_MISSIONSCRIPT07_LUA_001528,1321 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001529 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001529")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001529)
	MisBeginCondition(NoRecord, 1321)
	MisBeginCondition(NoMission, 1321)
	MisBeginCondition(HasRecord, 1320)
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1321)
	MisCancelAction(ClearMission, 1321)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001530 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001530")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001530)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001531 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001531")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001531)
	MisResultCondition( AlwaysFailure )
	
	---------------------------------奥运活动 之 智慧之心------------女神	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001528 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001528")
	DefineMission( 6277, MISSCRIPT_MISSIONSCRIPT07_LUA_001528,1321, COMPLETE_SHOW )
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001532 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001532")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001532)	
	MisResultCondition(HasMission, 1321)
	MisResultCondition(HasRecord, 1320)	
	MisResultCondition(HasItem, 5842, 1)
	MisResultAction(ClearMission, 1321)
	MisResultAction(ClearRecord, 1320)
	MisResultAction(SetRecord, 1321) 
	MisResultAction( AddMoney , 5000)
	
	---------------------------------奥运活动 之 智慧之心一------------女神	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001533 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001533")
	DefineMission( 6278, MISSCRIPT_MISSIONSCRIPT07_LUA_001533,1322 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001534 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001534")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001534)
	MisBeginCondition(NoRecord, 1322)
	MisBeginCondition(NoMission, 1322)
	MisBeginCondition(HasRecord, 1321)
	MisBeginCondition( HasItem, 5842, 1)
    MisBeginAction(AddMission, 1322)
	MisCancelAction(ClearMission, 1322)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001535 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001535")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001535)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001536 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001536")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001536)
	MisBeginAction(AddTrigger, 13221, TE_GETITEM, 4435, 1)          
	MisBeginAction(AddTrigger, 13222, TE_GETITEM, 4468, 1)	
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4435)	
	TriggerAction( 1, AddNextFlag, 1322, 10, 1)
	RegCurTrigger( 13221 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4468)	
	TriggerAction( 1, AddNextFlag, 1322, 20, 1)
	RegCurTrigger( 13222 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001537 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001537")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001537)

	MisResultCondition(HasMission, 1322)
	MisResultCondition(NoRecord, 1322)
	MisResultCondition(HasRecord, 1321)
	MisResultCondition(HasItem, 5842, 1)
	MisResultCondition(HasItem, 4435, 1)
	MisResultCondition(HasItem, 4468, 1)
	MisResultAction(TakeItem, 4435, 1)
	MisResultAction(TakeItem, 4468, 1)	
	MisResultAction(ClearMission, 1322)
	MisResultAction( AddMoney , 5000)
	MisResultAction(ClearRecord, 1321)
	MisResultAction(SetRecord, 1322)  ----在NPC对话处会用到此record  用来触发接下去的对话
	
	
	---------------------------------奥运活动 之 圣火台------------圣火传递大使	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001538 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001538")
	DefineMission( 6279, MISSCRIPT_MISSIONSCRIPT07_LUA_001538,1323 )	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001539 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001539")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001539)
	
	MisResultBagNeed(1)
	MisBeginCondition(NoRecord, 1322)
	
	MisBeginCondition(HasItem, 5801, 1)
	MisBeginCondition(NoMission, 1323)
	MisBeginAction(AddMission, 1323)		
	MisBeginAction(GiveItem, 5799, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001540 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001540")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001540) 
	MISSCRIPT_MISSIONSCRIPT07_LUA_001541 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001541")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001541)
	MisResultCondition( AlwaysFailure )
	
	---------------------------------奥运活动 之 圣火台------------圣火台	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001538 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001538")
	DefineMission( 6280, MISSCRIPT_MISSIONSCRIPT07_LUA_001538,1323, COMPLETE_SHOW )	
	MisBeginCondition( AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001542 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001542")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001542)	
	MisResultCondition(HasMission, 1323)		
	MisResultCondition(HasItem, 5842, 1)   --玩家老火炬
	MisResultCondition(HasItem, 5797, 1)   --仁爱之心 
	MisResultCondition(HasItem, 5798, 1)   --无畏之心
	MisResultCondition(HasItem, 5799, 1)   --坚定之心
	MisResultCondition(HasItem, 5800, 1)   --奉献之心
	MisResultCondition(HasItem, 5801, 1)   --智慧之心
	
	
	MisResultAction(ClearMission, 1323)	
	MisResultAction(SetRecord, 1324)
	MisResultAction(ClearRecord, 1323)	
	MisResultAction( AddMoney , 5000)
	
	---------------------------------新年活动------------玛格丽特	 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001543 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001543")
	DefineMission (6628, MISSCRIPT_MISSIONSCRIPT07_LUA_001543, 1860)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001544 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001544")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001544)
	MisBeginCondition(NoRecord, 1860)
	MisBeginCondition(NoRecord, 1863)
	MisBeginCondition(NoMission, 1860)
	MisBeginAction(AddMission, 1860)		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001545 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001545")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001545) 
	MISSCRIPT_MISSIONSCRIPT07_LUA_001546 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001546")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001546)
	MisCancelAction(ClearMission, 1860)
	MisResultCondition( AlwaysFailure )
	
	---------------------------------新年活动------------芬德内	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001543 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001543")
	DefineMission( 6623, MISSCRIPT_MISSIONSCRIPT07_LUA_001543,1860, COMPLETE_SHOW )	
	MisBeginCondition( AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001547 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001547")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001547)	
	MisResultCondition(HasMission, 1860)
	MisResultAction(SetRecord, 1860)
	MisResultAction(ClearMission, 1860)
	
	---------------------------------新年活动2------------芬德内
	MISSCRIPT_MISSIONSCRIPT07_LUA_001548 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001548")
	DefineMission (6624, MISSCRIPT_MISSIONSCRIPT07_LUA_001548, 1861)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001549 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001549")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001549)
	MisBeginCondition(HasRecord, 1860)
	MisBeginCondition(NoRecord, 1861)
	MisBeginCondition(NoMission, 1861)
	MisBeginAction(AddMission, 1861)
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001550 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001550")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001550) 
	MISSCRIPT_MISSIONSCRIPT07_LUA_001551 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001551")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001551)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001552 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001552")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001552)

	MisResultCondition(Jiu_Check)
	MisResultAction(Jiu_Action)
	MisCancelAction(ClearMission, 1861)
	
	-------------------------------新年活动3-----------芬德内 （开始）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001553 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001553")
	DefineMission (6625, MISSCRIPT_MISSIONSCRIPT07_LUA_001553, 1862)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001554 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001554")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001554)
	MisBeginCondition(NoRecord, 1862)	
	MisBeginCondition(HasRecord, 1861)
	MisBeginCondition(NoMission, 1862)
	MisBeginAction(AddMission, 1862)		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001555 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001555")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001555) 
	MISSCRIPT_MISSIONSCRIPT07_LUA_001556 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001556")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001556)
	MisCancelAction(ClearMission, 1862)

	MisResultCondition( AlwaysFailure )
	
	---------------------------------新年活动3------------玛格丽特	 （结束）
	MISSCRIPT_MISSIONSCRIPT07_LUA_001553 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001553")
	DefineMission( 6626, MISSCRIPT_MISSIONSCRIPT07_LUA_001553,1862, COMPLETE_SHOW )	
	MisBeginCondition( AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001557 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001557")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001557)	
	MisResultCondition(HasMission, 1862)
	MisResultAction(SetRecord, 1862)
	MisResultAction(ClearMission, 1862)	

	---------------------------------新年活动4-----------玛格丽特
	MISSCRIPT_MISSIONSCRIPT07_LUA_001558 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001558")
	DefineMission (6627, MISSCRIPT_MISSIONSCRIPT07_LUA_001558, 1863)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001559 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001559")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001559)
	MisBeginCondition(HasRecord, 1862)
	MisBeginCondition(NoRecord, 1863)
	MisBeginCondition(NoMission, 1863)
	MisBeginAction(AddMission, 1863)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001560 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001560")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT07_LUA_001560)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001561 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001561")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001561)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001562 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001562")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001562)
	
	MisResultBagNeed(1)
	MisResultCondition(HasMoney, 1888888)
	MisResultAction(TakeMoney, 1888888)
	MisResultAction(GiveItem, 6610, 1, 4)
	MisResultAction(SetRecord, 1863)
	MisResultAction(ClearMission, 1863)
	MisCancelAction(ClearMission, 1863)	
		
		---------------------------------伪造的单身证明------------好人四维
	MISSCRIPT_MISSIONSCRIPT07_LUA_001563 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001563")
	DefineMission( 6629, MISSCRIPT_MISSIONSCRIPT07_LUA_001563, 1920 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001564 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001564")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001564 )
	MisBeginCondition(NoMission, 1920)
	MisBeginCondition(NoRecord, 1920)
	MisBeginAction(AddMission, 1920)

	MisBeginAction(AddTrigger, 19201, TE_GETITEM, 1638, 20 )
	MisBeginAction(AddTrigger, 19202, TE_GETITEM, 1641, 20 )
	MisBeginAction(AddTrigger, 19203, TE_GETITEM, 3363, 20 )
	MisBeginAction(AddTrigger, 19204, TE_GETITEM, 1644, 20 )
	MisBeginAction(AddTrigger, 19205, TE_GETITEM, 3362, 20 )
	MisBeginAction(AddTrigger, 19206, TE_GETITEM, 3360, 1 )
	MisCancelAction(ClearMission, 1920)


	MisNeed(MIS_NEED_ITEM, 1638, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 1641, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 3363, 20, 40, 20)
	MisNeed(MIS_NEED_ITEM, 1644, 20, 60, 20)
	MisNeed(MIS_NEED_ITEM, 3362, 20, 80, 20)
	MisNeed(MIS_NEED_ITEM, 3360, 1, 100, 1)
		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001565 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001565")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001565)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 1920)
	MisResultCondition(HasMission, 1920)
	MisResultCondition(HasItem, 3360, 1)
	MisResultCondition(HasItem, 1638, 20)
	MisResultCondition(HasItem, 1641, 20)
	MisResultCondition(HasItem, 3363, 20)
	MisResultCondition(HasItem, 1644, 20)
	MisResultCondition(HasItem, 3362, 20)
	MisResultCondition(HasMoney, 990000)
	MisResultAction(TakeItem, 3360, 1)
	MisResultAction(TakeItem, 1638, 20)
	MisResultAction(TakeItem, 1641, 20)
	MisResultAction(TakeItem, 3363, 20)
	MisResultAction(TakeItem, 1644, 20)
	MisResultAction(TakeItem, 3362, 20)
	MisResultAction(TakeMoney, 990000)
	MisResultAction(GiveItem, 6703, 1,4)    --道具暂时没有制作   先给个短剑测试一下
	MisResultAction(ClearMission, 1920)
	MisResultAction(SetRecord, 1920)
	--MisResultAction(AddExp, 800, 800)
--	MisResultAction(AddMoney,270,270)



	InitTrigger()
	TriggerCondition( 1, IsItem, 1638 )	
	TriggerAction( 1, AddNextFlag, 1920, 20, 20 )
	RegCurTrigger( 19201 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1641 )	
	TriggerAction( 1, AddNextFlag, 1920, 40, 20 )
	RegCurTrigger( 19202 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3363 )	
	TriggerAction( 1, AddNextFlag, 1920, 60, 20 )
	RegCurTrigger( 19203 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1644 )	
	TriggerAction( 1, AddNextFlag, 1920, 80, 20 )
	RegCurTrigger( 19204 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3362 )	
	TriggerAction( 1, AddNextFlag, 1920, 100, 20 )
	RegCurTrigger( 19205 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3360 )	
	TriggerAction( 1, AddNextFlag, 1920, 110, 1 )
	RegCurTrigger( 19206 )
----2009.2.3 北美特殊需求 丝绸之路任务 任务ID从6629开始 record编号从1920开始  任务制作期间大陆若需制作任务请联系戴晓玮确定任务编号
---------第一次寻找蛋蛋----
	MISSCRIPT_MISSIONSCRIPT07_LUA_001567 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001567")
	DefineMission( 6811, MISSCRIPT_MISSIONSCRIPT07_LUA_001567, 1980 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001568 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001568")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001568 )
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 1980)
	MisBeginCondition(NoRecord, 1980)
	MisBeginAction(AddMission, 1980)
	MisCancelAction(ClearMission, 1980)

	MisBeginAction(AddTrigger, 19801, TE_GETITEM, 1681, 10 )

	MisNeed(MIS_NEED_ITEM, 1681, 10, 0, 10)

		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001569 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001569")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001569)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001570 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001570")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001570)
	MisResultCondition(NoRecord, 1980)
	MisResultCondition(HasMission, 1980)
	MisResultCondition(HasItem, 1681, 10)
	MisResultAction(TakeItem, 1681, 10)
	MisResultAction(GiveFHItem) 
	MisResultAction(ClearMission, 1980)
	MisResultAction(SetRecord, 1980)
	MisResultAction(GiveNpcMission1,6812)
		MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 1681 )	
	TriggerAction( 1, AddNextFlag, 1980, 10, 10 )
	RegCurTrigger( 19801 )
	
---------第二次寻找蛋蛋----
	MISSCRIPT_MISSIONSCRIPT07_LUA_001571 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001571")
	DefineMission( 6812, MISSCRIPT_MISSIONSCRIPT07_LUA_001571, 1981 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001572 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001572")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001572 )
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(HasRecord, 1980)
	MisBeginCondition(NoMission, 1981)
	MisBeginCondition(NoRecord, 1981)
	MisBeginAction(AddMission, 1981)
	MisCancelAction(ClearMission, 1981)

	MisBeginAction(AddTrigger, 19811, TE_GETITEM, 1789, 50 )
	MisBeginAction(AddTrigger, 19812, TE_GETITEM, 1787, 10 )
	MisBeginAction(AddTrigger, 19813, TE_GETITEM, 3144, 10 )

	MisNeed(MIS_NEED_ITEM, 1789, 50, 0, 50)
	MisNeed(MIS_NEED_ITEM, 1787, 10, 50, 10)
	MisNeed(MIS_NEED_ITEM, 3144, 10, 60, 10)

		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001573 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001573")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001573)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001574 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001574")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001574)
	MisResultCondition(NoRecord, 1981)
	MisResultCondition(HasMission, 1981)
	MisResultCondition(HasItem, 1789, 50)
	MisResultCondition(HasItem, 1787, 10)
	MisResultCondition(HasItem, 3144, 10)
	MisResultAction(TakeItem, 1789, 50)
	MisResultAction(TakeItem, 1787, 10)
	MisResultAction(TakeItem, 3144, 10)
	MisResultAction(GiveFHItem)    
	MisResultAction(ClearMission, 1981)
	MisResultAction(SetRecord, 1981)
	MisResultAction(GiveNpcMission1,6813)
	MisResultBagNeed(1)	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1789 )	
	TriggerAction( 1, AddNextFlag, 1981, 50, 50 )
	RegCurTrigger( 19811 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1787 )	
	TriggerAction( 1, AddNextFlag, 1981, 60, 60 )
	RegCurTrigger( 19812 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3144 )	
	TriggerAction( 1, AddNextFlag, 1981, 70, 70 )
	RegCurTrigger( 19813 )

---------第三次寻找蛋蛋----
	MISSCRIPT_MISSIONSCRIPT07_LUA_001575 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001575")
	DefineMission( 6813, MISSCRIPT_MISSIONSCRIPT07_LUA_001575, 1982 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001576 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001576")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001576 )
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(HasRecord, 1981)
	MisBeginCondition(NoMission, 1982)
	MisBeginCondition(NoRecord, 1982)
	MisBeginAction(AddMission, 1982)
	MisCancelAction(ClearMission, 1982)

	MisBeginAction(AddTrigger, 19821, TE_GETITEM, 3933, 20 )
	MisBeginAction(AddTrigger, 19822, TE_GETITEM, 3382, 1 )
	MisBeginAction(AddTrigger, 19823, TE_GETITEM, 0182, 1 )
	MisBeginAction(AddTrigger, 19824, TE_GETITEM, 1763, 10 )

	MisNeed(MIS_NEED_ITEM, 3933, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 3382, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 0182, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 1763, 10, 40, 10)

		
	MISSCRIPT_MISSIONSCRIPT07_LUA_001577 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001577")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001577)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001578 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001578")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001578)
	MisResultCondition(NoRecord, 1982)
	MisResultCondition(HasMission, 1982)
	MisResultCondition(HasItem, 3933, 20)
	MisResultCondition(HasItem, 3382, 1)
	MisResultCondition(HasItem, 0182, 1)
	MisResultCondition(HasItem, 1763, 10)
	MisResultAction(TakeItem, 3933, 20)
	MisResultAction(TakeItem, 3382, 1)
	MisResultAction(TakeItem, 0182, 1)
	MisResultAction(TakeItem, 1763, 10)
	MisResultAction(GiveFHItem)    
	MisResultAction(ClearMission, 1982)
	MisResultAction(SetRecord, 1982)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3933 )	
	TriggerAction( 1, AddNextFlag, 1982, 20, 20 )
	RegCurTrigger( 19821 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3382 )	
	TriggerAction( 1, AddNextFlag, 1982, 1, 1 )
	RegCurTrigger( 19822 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 0182 )	
	TriggerAction( 1, AddNextFlag, 1982, 1, 1 )
	RegCurTrigger( 19823 )	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1763 )	
	TriggerAction( 1, AddNextFlag, 1982, 10, 10 )
	RegCurTrigger( 19824 )	
	
---------制作未知的勤劳宝箱----
	MISSCRIPT_MISSIONSCRIPT07_LUA_001579 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001579")
	DefineMission( 6830, MISSCRIPT_MISSIONSCRIPT07_LUA_001579, 1998 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001580 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001580")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001580 )
	MisBeginCondition(NoRecord, 1998)
	MisBeginAction(AddMission, 1998)
	MisCancelAction(ClearMission, 1998)

	MisBeginAction(AddTrigger, 19981, TE_GETITEM, 6930, 1 )
	MisNeed(MIS_NEED_ITEM, 6930, 1, 0, 1)
	                   
	MISSCRIPT_MISSIONSCRIPT07_LUA_001581 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001581")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001581)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001582 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001582")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001582)
	MisResultCondition(NoRecord, 1998)
	MisResultCondition(HasMission, 1998)
	MisResultCondition(HasItem, 6930, 1)
	MisResultAction(AddExp,8888,8888)
	MisResultAction(ClearMission, 1998)
	MisResultAction(SetRecord, 1998)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 6930 )	
	TriggerAction( 1, AddNextFlag, 1998, 1, 1 )
	RegCurTrigger( 19981 )

	
----------------------------------------------------------
--							--
--							--
--		情比金坚项链积分任务					--
--							--
--							--
----------------------------------------------------------	
-----------------------------------第一次任务收集
	MISSCRIPT_MISSIONSCRIPT07_LUA_001583 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001583")
	DefineMission( 6835, MISSCRIPT_MISSIONSCRIPT07_LUA_001583, 2004 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001584 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001584")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001584 )

	MisBeginCondition(NoRecord, 2004)
	MisBeginCondition(NoMission, 2004)
	MisBeginAction(AddMission, 2004)
	MisBeginAction(AddTrigger, 20041, TE_GETITEM, 3822, 10 )
	MisBeginAction(AddTrigger, 20042, TE_GETITEM, 3823, 10 )
	MisBeginAction(AddTrigger, 20043, TE_GETITEM, 4797, 10 )
	MisBeginAction(AddTrigger, 20044, TE_GETITEM, 4901, 10 )
	MisBeginAction(AddTrigger, 20045, TE_GETITEM, 5721, 5 )
	MisBeginAction(AddTrigger, 20046, TE_GETITEM, 6959, 1 )	
	MisCancelAction(ClearMission, 2004 )

	MisNeed(MIS_NEED_ITEM, 3822, 10, 0, 10)
	MisNeed(MIS_NEED_ITEM, 3823, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 4797, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 4901, 10, 30, 10)
	MisNeed(MIS_NEED_ITEM, 5721, 5, 40, 5)
	MisNeed(MIS_NEED_ITEM, 6959, 1, 45, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_001585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001585")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001585)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 2004)
	MisResultCondition(HasMission, 2004)
	MisResultCondition(HasItem, 3822, 10)
	MisResultCondition(HasItem, 3823, 10)
	MisResultCondition(HasItem, 4797, 10)
	MisResultCondition(HasItem, 4901, 10)
	MisResultCondition(HasItem, 5721, 5)
	MisResultCondition(HasItem, 6959, 1)

	MisResultAction(TakeItem, 3822, 10)
	MisResultAction(TakeItem, 3823, 10)
	MisResultAction(TakeItem, 4797, 10)
	MisResultAction(TakeItem, 4901, 10)
	MisResultAction(TakeItem, 5721, 5)
	MisResultAction(AddLovePoint, 2)    --给爱情证书上增加2点积分
	MisResultAction(ClearMission, 2004)
	MisResultAction(SetRecord, 2004)
	--MisResultAction(GiveNpcMission,2005,"丘比特",2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3822 )	
	TriggerAction( 1, AddNextFlag, 2004, 10, 10 )
	RegCurTrigger( 20041 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3823 )	
	TriggerAction( 1, AddNextFlag, 2004, 20, 10 )
	RegCurTrigger( 20042 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4797 )	
	TriggerAction( 1, AddNextFlag, 2004, 30, 10 )
	RegCurTrigger( 20043 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4901 )	
	TriggerAction( 1, AddNextFlag, 2004, 40, 10 )
	RegCurTrigger( 20044 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5721 )	
	TriggerAction( 1, AddNextFlag, 2004, 50, 5 )
	RegCurTrigger( 20045 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6959 )	
	TriggerAction( 1, AddNextFlag, 2004, 55, 1 )
	RegCurTrigger( 20046 )	
	
	
-----------------------------------第二次任务收集
	MISSCRIPT_MISSIONSCRIPT07_LUA_001586 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001586")
	DefineMission( 6836, MISSCRIPT_MISSIONSCRIPT07_LUA_001586, 2005 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001587 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001587")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001587 )
	MisBeginCondition(HasRecord,2004)
	MisBeginCondition(NoRecord, 2005)
	MisBeginCondition(NoMission, 2005)
	MisBeginAction(AddMission, 2005)
	MisBeginAction(AddTrigger, 20051, TE_GETITEM, 3822, 20 )
	MisBeginAction(AddTrigger, 20052, TE_GETITEM, 3823, 20 )
	MisBeginAction(AddTrigger, 20053, TE_GETITEM, 4798, 10 )
	MisBeginAction(AddTrigger, 20054, TE_GETITEM, 4902, 20 )
	MisBeginAction(AddTrigger, 20055, TE_GETITEM, 5721, 10 )
	MisBeginAction(AddTrigger, 20056, TE_GETITEM, 6959, 1 )	
	MisCancelAction(ClearMission, 2005 )

	MisNeed(MIS_NEED_ITEM, 3822, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 3823, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 4798, 10, 40, 10)
	MisNeed(MIS_NEED_ITEM, 4902, 20, 50, 20)
	MisNeed(MIS_NEED_ITEM, 5721, 10, 70, 10)
	MisNeed(MIS_NEED_ITEM, 6959, 1, 80, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_001585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001585")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001585)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 2005)
	MisResultCondition(HasMission, 2005)
	MisResultCondition(HasItem, 3822, 20)
	MisResultCondition(HasItem, 3823, 20)
	MisResultCondition(HasItem, 4798, 10)
	MisResultCondition(HasItem, 4902, 20)
	MisResultCondition(HasItem, 5721, 10)
	MisResultCondition(HasItem, 6959, 1)

	MisResultAction(TakeItem, 3822, 20)
	MisResultAction(TakeItem, 3823, 20)
	MisResultAction(TakeItem, 4798, 10)
	MisResultAction(TakeItem, 4902, 20)
	MisResultAction(TakeItem, 5721, 10)
	MisResultAction(AddLovePoint, 4)    --给爱情证书上增加4点积分
	MisResultAction(ClearMission, 2005)
	MisResultAction(SetRecord, 2005)
	--MisResultAction(GiveNpcMission,2006,"丘比特",3)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3822 )	
	TriggerAction( 1, AddNextFlag, 2005, 20, 20 )
	RegCurTrigger( 20051 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3823 )	
	TriggerAction( 1, AddNextFlag, 2005, 40, 20 )
	RegCurTrigger( 20052 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4798 )	
	TriggerAction( 1, AddNextFlag, 2005, 60, 10 )
	RegCurTrigger( 20053 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4902 )	
	TriggerAction( 1, AddNextFlag, 2005, 70, 20 )
	RegCurTrigger( 20054 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 5721 )	
	TriggerAction( 1, AddNextFlag, 2005, 90, 10 )
	RegCurTrigger( 20055 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6959 )	
	TriggerAction( 1, AddNextFlag, 2005, 100, 1 )
	RegCurTrigger( 20056 )	

-----------------------------------第三次任务收集
	MISSCRIPT_MISSIONSCRIPT07_LUA_001588 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001588")
	DefineMission( 6837, MISSCRIPT_MISSIONSCRIPT07_LUA_001588, 2006 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001589 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001589")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001589 )
	MisBeginCondition(HasRecord,2005)
	MisBeginCondition(NoRecord, 2006)
	MisBeginCondition(NoMission, 2006)
	MisBeginAction(AddMission, 2006)
	
	MisBeginAction(AddTrigger, 20061, TE_GETITEM, 4799, 20 )
	MisBeginAction(AddTrigger, 20062, TE_GETITEM, 4903, 20 )
	MisBeginAction(AddTrigger, 20063, TE_GETITEM, 1480, 20 )
	MisBeginAction(AddTrigger, 20064, TE_GETITEM, 6410, 3 )
	MisBeginAction(AddTrigger, 20065, TE_GETITEM, 6959, 1 )
	MisCancelAction(ClearMission, 2006 )

	MisNeed(MIS_NEED_ITEM, 4799, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 4903, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 1480, 20, 40, 20)
	MisNeed(MIS_NEED_ITEM, 6410, 3, 60, 3)
	MisNeed(MIS_NEED_ITEM, 6959, 1, 63, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_001585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001585")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001585)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 2006)
	MisResultCondition(HasMission, 2006)
	MisResultCondition(HasItem, 4799, 20)
	MisResultCondition(HasItem, 4903, 20)
	MisResultCondition(HasItem, 1480, 20)
	MisResultCondition(HasItem, 6410, 3)
	MisResultCondition(HasItem, 6959, 1)

	MisResultAction(TakeItem, 4799, 20)
	MisResultAction(TakeItem, 4903, 20)
	MisResultAction(TakeItem, 1480, 20)
	MisResultAction(TakeItem, 6410, 3)
	MisResultAction(AddLovePoint, 10)    --给爱情证书上增加10点积分
	MisResultAction(ClearMission, 2006)
	MisResultAction(SetRecord, 2006)
	--MisResultAction(GiveNpcMission,2007,"丘比特",4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4799 )	
	TriggerAction( 1, AddNextFlag, 2006, 20, 20 )
	RegCurTrigger( 20061 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4903 )	
	TriggerAction( 1, AddNextFlag, 2006, 40, 20 )
	RegCurTrigger( 20062 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1480 )	
	TriggerAction( 1, AddNextFlag, 2006, 60, 20 )
	RegCurTrigger( 20063 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6410 )	
	TriggerAction( 1, AddNextFlag, 2006, 80, 3 )
	RegCurTrigger( 20064 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6959 )	
	TriggerAction( 1, AddNextFlag, 2006, 83, 1 )
	RegCurTrigger( 20065 )


-----------------------------------第四次任务收集
	MISSCRIPT_MISSIONSCRIPT07_LUA_001590 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001590")
	DefineMission( 6838, MISSCRIPT_MISSIONSCRIPT07_LUA_001590, 2007 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001591 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001591")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001591 )
	MisBeginCondition(HasRecord,2006)
	MisBeginCondition(NoRecord, 2007)
	MisBeginCondition(NoMission, 2007)
	MisBeginAction(AddMission, 2007)
	MisBeginAction(AddTrigger, 20071, TE_GETITEM, 1481, 20 )
	MisBeginAction(AddTrigger, 20072, TE_GETITEM, 4800, 20 )
	MisBeginAction(AddTrigger, 20073, TE_GETITEM, 4904, 20 )
	MisBeginAction(AddTrigger, 20074, TE_GETITEM, 6410, 10 )
	MisBeginAction(AddTrigger, 20075, TE_GETITEM, 6959, 1 )
	MisCancelAction(ClearMission, 2007 )

	MisNeed(MIS_NEED_ITEM, 1481, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 4800, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 4904, 20, 40, 20)
	MisNeed(MIS_NEED_ITEM, 6410, 10, 60, 10)
	MisNeed(MIS_NEED_ITEM, 6959, 1, 70, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_001585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001585")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001585)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 2007)
	MisResultCondition(HasMission, 2007)
	MisResultCondition(HasItem, 1481, 20)
	MisResultCondition(HasItem, 4800, 20)
	MisResultCondition(HasItem, 4904, 20)
	MisResultCondition(HasItem, 6410, 10)
	MisResultCondition(HasItem, 6959, 1)

	MisResultAction(TakeItem, 1481, 20)
	MisResultAction(TakeItem, 4800, 20)
	MisResultAction(TakeItem, 4904, 20)
	MisResultAction(TakeItem, 6410, 10)
	MisResultAction(AddLovePoint, 30)    --给爱情证书上增加30点积分
	MisResultAction(ClearMission, 2007)
	MisResultAction(SetRecord, 2007)
	--MisResultAction(GiveNpcMission,2008,"丘比特",5)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1481 )	
	TriggerAction( 1, AddNextFlag, 2007, 20, 20 )
	RegCurTrigger( 20071 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4800 )	
	TriggerAction( 1, AddNextFlag, 2007, 40, 20 )
	RegCurTrigger( 20072 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4904 )	
	TriggerAction( 1, AddNextFlag, 2007, 60, 20 )
	RegCurTrigger( 20073 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6410 )	
	TriggerAction( 1, AddNextFlag, 2007, 80, 10 )
	RegCurTrigger( 20074 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6959 )	
	TriggerAction( 1, AddNextFlag, 2007, 90, 1 )
	RegCurTrigger( 20075 )	
	
-----------------------------------第五次任务收集
	MISSCRIPT_MISSIONSCRIPT07_LUA_001592 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001592")
	DefineMission( 6839, MISSCRIPT_MISSIONSCRIPT07_LUA_001592, 2008 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001593 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001593")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001593 )
	MisBeginCondition(HasRecord,2007)
	MisBeginCondition(NoRecord, 2008)
	MisBeginCondition(NoMission, 2008)
	MisBeginAction(AddMission, 2008)
	MisBeginAction(AddTrigger, 20081, TE_GETITEM, 4801, 20 )
	MisBeginAction(AddTrigger, 20082, TE_GETITEM, 4905, 20 )
	MisBeginAction(AddTrigger, 20083, TE_GETITEM, 6410, 15 )
	MisBeginAction(AddTrigger, 20084, TE_GETITEM, 6959, 1 )
	MisCancelAction(ClearMission, 2008 )

	MisNeed(MIS_NEED_ITEM, 4801, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 4905, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 6410, 15, 40, 15)
	MisNeed(MIS_NEED_ITEM, 6959, 1, 55, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_001585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001585")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001585)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 2008)
	MisResultCondition(HasMission, 2008)
	MisResultCondition(HasItem, 4801, 20)
	MisResultCondition(HasItem, 4905, 20)
	MisResultCondition(HasItem, 6410, 15)
	MisResultCondition(HasItem, 6959, 1)

	MisResultAction(TakeItem, 4801, 20)
	MisResultAction(TakeItem, 4905, 20)
	MisResultAction(TakeItem, 6410, 15)
	MisResultAction(AddLovePoint, 40)    --给爱情证书上增加40点积分
	MisResultAction(ClearMission, 2008)
	MisResultAction(SetRecord, 2008)
	--MisResultAction(GiveNpcMission,2009,"丘比特",6)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4801 )	
	TriggerAction( 1, AddNextFlag, 2008, 20, 20 )
	RegCurTrigger( 20081 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4905 )	
	TriggerAction( 1, AddNextFlag, 2008, 40, 20 )
	RegCurTrigger( 20082 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6410 )	
	TriggerAction( 1, AddNextFlag, 2008, 60, 15 )
	RegCurTrigger( 20083 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6959 )	
	TriggerAction( 1, AddNextFlag, 2008, 75, 1 )
	RegCurTrigger( 20084 )

-----------------------------------第六次任务收集
	MISSCRIPT_MISSIONSCRIPT07_LUA_001594 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001594")
	DefineMission( 6840, MISSCRIPT_MISSIONSCRIPT07_LUA_001594, 2009 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001595 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001595")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001595 )
	MisBeginCondition(HasRecord,2008)
	MisBeginCondition(NoRecord, 2009)
	MisBeginCondition(NoMission, 2009)
	MisBeginAction(AddMission, 2009)
	MisBeginAction(AddTrigger, 20091, TE_GETITEM, 4802, 20 )
	MisBeginAction(AddTrigger, 20092, TE_GETITEM, 4906, 20 )
	MisBeginAction(AddTrigger, 20093, TE_GETITEM, 1018, 10 )
	MisBeginAction(AddTrigger, 20094, TE_GETITEM, 6959, 1 )
	MisCancelAction(ClearMission, 2009 )

	MisNeed(MIS_NEED_ITEM, 4802, 20, 0, 20)
	MisNeed(MIS_NEED_ITEM, 4906, 20, 20, 20)
	MisNeed(MIS_NEED_ITEM, 1018, 10, 40, 10)
	MisNeed(MIS_NEED_ITEM, 6959, 1, 50, 1)
	

	MISSCRIPT_MISSIONSCRIPT07_LUA_001585 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001585")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001585)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001566 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001566")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001566)
	MisResultCondition(NoRecord, 2009)
	MisResultCondition(HasMission, 2009)
	MisResultCondition(HasItem, 4802, 20)
	MisResultCondition(HasItem, 4906, 20)
	MisResultCondition(HasItem, 1018, 10)
	MisResultCondition(HasItem, 6959, 1)

	MisResultAction(TakeItem, 4802, 20)
	MisResultAction(TakeItem, 4906, 20)
	MisResultAction(TakeItem, 1018, 10)
	MisResultAction(AddLovePoint, 50)    --给爱情证书上增加50点积分
	MisResultAction(ClearMission, 2009)
	MisResultAction(SetRecord, 2009)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4802 )	
	TriggerAction( 1, AddNextFlag, 2009, 20, 20 )
	RegCurTrigger( 20091 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4906 )	
	TriggerAction( 1, AddNextFlag, 2009, 40, 20 )
	RegCurTrigger( 20092 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1018 )	
	TriggerAction( 1, AddNextFlag, 2009, 60, 10 )
	RegCurTrigger( 20093 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6959 )	
	TriggerAction( 1, AddNextFlag, 2009, 70, 1 )
	RegCurTrigger( 20094 )	
	
	
----------------------------------------------------------
--							--
--							--
--		暑假日常任务		--
--							--
--							--
----------------------------------------------------------	
-----------------------------------废灵日常任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_001596 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001596")
	DefineMission( 6844, MISSCRIPT_MISSIONSCRIPT07_LUA_001596, 2013 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001597 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001597")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001597 )
	MisBeginCondition(HasItem,7055,1)
	MisBeginCondition(LvCheck, ">",29)
	MisBeginCondition(LvCheck, "<",46)	
	MisBeginCondition(NoMission, 2013)
	MisBeginCondition(Get_Day_Mission6)	
	MisBeginAction(AddMission, 2013)
	MisBeginAction(AddTrigger, 20131, TE_KILL, 686, 5)
	--MisBeginAction(AddTrigger, 20132, TE_GETITEM, 7055, 1 )	
	MisCancelAction(ClearMission, 2013 )

	MisNeed(MIS_NEED_KILL, 686, 5, 0, 5)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001598")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001599 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001599")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001599)

	MisResultCondition(HasMission, 2013)
	MisResultCondition(HasFlag, 2013, 4)	
	MisResultBagNeed(1)
	--MisResultCondition(HasItem, 7055, 1)
	
	MisResultAction(AddItem_Mission6)
	MisResultAction(AddExp_10persent)    --增加10%经验
	MisResultAction(GiveItem, 7056, 1, 4)	
	MisResultAction(ClearMission, 2013)

	InitTrigger()
	TriggerCondition(1, IsMonster, 686)	
	TriggerAction(1, AddNextFlag,2013, 0, 5)
	RegCurTrigger(20131)
	-- TriggerCondition( 1, IsItem, 7055 )	
	-- TriggerAction( 1, AddNextFlag, 2013, 30, 1 )
	-- RegCurTrigger( 20132 )	
	

-----------------------------------沼泽日常任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_001600 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001600")
	DefineMission( 6845, MISSCRIPT_MISSIONSCRIPT07_LUA_001600, 2014 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001601 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001601")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001601 )
	MisBeginCondition(HasItem,7055,1)
	MisBeginCondition(LvCheck, ">",39)
	MisBeginCondition(LvCheck, "<",56)	
	MisBeginCondition(NoMission, 2014)
	MisBeginCondition(Get_Day_Mission7)	
	MisBeginAction(AddMission, 2014)
	MisBeginAction(AddTrigger, 20141, TE_KILL, 695, 5)
	--MisBeginAction(AddTrigger, 20142, TE_GETITEM, 7055, 1 )	
	MisCancelAction(ClearMission, 2014 )

	MisNeed(MIS_NEED_KILL, 695, 5, 0, 5)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001598")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001602 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001602")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001602)

	MisResultCondition(HasMission, 2014)
	MisResultCondition(HasFlag, 2014, 4)	
	MisResultBagNeed(1)
	--MisResultCondition(HasItem, 7055, 1)
	
	MisResultAction(AddItem_Mission7)	
	MisResultAction(AddExp_10persent)    --增加10%经验
	MisResultAction(GiveItem, 7056, 1, 4)
	MisResultAction(ClearMission, 2014)

	InitTrigger()
	TriggerCondition(1, IsMonster, 695)	
	TriggerAction(1, AddNextFlag,2014, 0, 5)
	RegCurTrigger(20141)

	
-----------------------------------小圣战日常任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_001603 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001603")
	DefineMission( 6846, MISSCRIPT_MISSIONSCRIPT07_LUA_001603, 2015 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001604 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001604")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001604 )
	MisBeginCondition(HasItem,7055,1)
	MisBeginCondition(LvCheck, ">",44)
	MisBeginCondition(LvCheck, "<",65)	
	MisBeginCondition(NoMission, 2015)
	MisBeginCondition(Get_Day_Mission8)	
	MisBeginAction(AddMission, 2015)
	MisBeginAction(AddTrigger, 20151, TE_KILL, 220, 1)
	MisBeginAction(AddTrigger, 20152, TE_KILL, 219, 1)
	MisBeginAction(AddTrigger, 20153, TE_KILL, 217, 1)
	MisBeginAction(AddTrigger, 20154, TE_KILL, 218, 1)	
	--MisBeginAction(AddTrigger, 20152, TE_GETITEM, 7055, 1 )	
	MisCancelAction(ClearMission, 2015 )

	MisNeed(MIS_NEED_KILL, 220, 1, 10, 1)
	MisNeed(MIS_NEED_KILL, 219, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 217, 1, 30, 1)
	MisNeed(MIS_NEED_KILL, 218, 1, 40, 1)	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001598")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001605 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001605")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001605)

	MisResultCondition(HasMission, 2015)
	MisResultCondition(HasFlag, 2015, 10)
	MisResultCondition(HasFlag, 2015, 20)
	MisResultCondition(HasFlag, 2015, 30)
	MisResultCondition(HasFlag, 2015, 40)	
	--MisResultCondition(HasItem, 7055, 1)

	MisResultAction(AddItem_Mission8)	
	MisResultAction(AddExp_5persent)    --增加5%经验
	MisResultAction(GiveItem, 7056, 1, 4)
	MisResultAction(ClearMission, 2015)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 220)	
	TriggerAction(1, AddNextFlag,2015, 10, 1)
	RegCurTrigger(20151)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 219)	
	TriggerAction(1, AddNextFlag,2015, 20, 1)
	RegCurTrigger(20152)		

	InitTrigger()
	TriggerCondition(1, IsMonster, 217)	
	TriggerAction(1, AddNextFlag,2015, 30, 1)
	RegCurTrigger(20153)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 218)	
	TriggerAction(1, AddNextFlag,2015, 40, 1)
	RegCurTrigger(20154)	
	
-----------------------------------大圣战日常任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_001606 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001606")
	DefineMission( 6847, MISSCRIPT_MISSIONSCRIPT07_LUA_001606, 2016 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001607 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001607")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001607 )
	MisBeginCondition(HasItem,7055,1)
	MisBeginCondition(LvCheck, ">",64)
	MisBeginCondition(LvCheck, "<",80)	
	MisBeginCondition(NoMission, 2016)
	MisBeginCondition(Get_Day_Mission9)	
	MisBeginAction(AddMission, 2016)
	MisBeginAction(AddTrigger, 20161, TE_KILL, 220, 1)
	MisBeginAction(AddTrigger, 20162, TE_KILL, 219, 1)
	MisBeginAction(AddTrigger, 20163, TE_KILL, 217, 1)
	MisBeginAction(AddTrigger, 20164, TE_KILL, 218, 1)	
	--MisBeginAction(AddTrigger, 20162, TE_GETITEM, 7055, 1 )	
	MisCancelAction(ClearMission, 2016 )

	MisNeed(MIS_NEED_KILL, 220, 1, 10, 1)
	MisNeed(MIS_NEED_KILL, 219, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 217, 1, 30, 1)
	MisNeed(MIS_NEED_KILL, 218, 1, 40, 1)	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001598")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001608 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001608")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001608)

	MisResultCondition(HasMission, 2016)
	MisResultCondition(HasFlag, 2016, 10)
	MisResultCondition(HasFlag, 2016, 20)
	MisResultCondition(HasFlag, 2016, 30)
	MisResultCondition(HasFlag, 2016, 40)	
	--MisResultCondition(HasItem, 7055, 1)

	MisResultAction(AddItem_Mission9)	
	MisResultAction(AddExp_3persent)    --增加3%经验
	MisResultAction(GiveItem, 7056, 1, 4)
	MisResultAction(ClearMission, 2016)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 220)	
	TriggerAction(1, AddNextFlag,2016, 10, 1)
	RegCurTrigger(20161)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 219)	
	TriggerAction(1, AddNextFlag,2016, 20, 1)
	RegCurTrigger(20162)		

	InitTrigger()
	TriggerCondition(1, IsMonster, 217)	
	TriggerAction(1, AddNextFlag,2016, 30, 1)
	RegCurTrigger(20163)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 218)	
	TriggerAction(1, AddNextFlag,2016, 40, 1)
	RegCurTrigger(20164)	
	
-----------------------------------魔方日常任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_001609 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001609")
	DefineMission( 6848, MISSCRIPT_MISSIONSCRIPT07_LUA_001609, 2017 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001610 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001610")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001610 )
	MisBeginCondition(HasItem,7055,1)
	MisBeginCondition(LvCheck, ">",49)
	MisBeginCondition(LvCheck, "<",80)	
	MisBeginCondition(NoMission, 2017)
	MisBeginCondition(Get_Day_Mission10)	
	MisBeginAction(AddMission, 2017)
	MisBeginAction(AddTrigger, 20171, TE_KILL, 671, 5)
	--MisBeginAction(AddTrigger, 20172, TE_GETITEM, 7055, 1 )	
	MisCancelAction(ClearMission, 2017 )

	MisNeed(MIS_NEED_KILL, 671, 5, 0, 5)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001598")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001611 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001611")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001611)

	MisResultCondition(HasMission, 2017)
	MisResultCondition(HasFlag, 2017, 4)	
	--MisResultCondition(HasItem, 7055, 1)
	
	MisResultAction(AddItem_Mission10)	
	MisResultAction(AddExp_3persent)    --增加3%经验
	MisResultAction(GiveItem, 7056, 1, 4)
	MisResultAction(ClearMission, 2017)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 671)	
	TriggerAction(1, AddNextFlag,2017, 0, 5)
	RegCurTrigger(20171)
	
	
-----------------------------------地狱日常任务
	MISSCRIPT_MISSIONSCRIPT07_LUA_001612 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001612")
	DefineMission( 6849, MISSCRIPT_MISSIONSCRIPT07_LUA_001612, 2018 )
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001613 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001613")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT07_LUA_001613 )
	MisBeginCondition(HasItem,7055,1)
	MisBeginCondition(LvCheck, ">",79)	
	MisBeginCondition(NoMission, 2018)
	MisBeginCondition(Get_Day_Mission11)	
	MisBeginAction(AddMission, 2018)
	MisBeginAction(AddTrigger, 20181, TE_KILL, 827, 5)
	--MisBeginAction(AddTrigger, 20182, TE_GETITEM, 7055, 1 )	
	MisCancelAction(ClearMission, 2018 )

	MisNeed(MIS_NEED_KILL, 827, 5, 0, 5)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001598 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001598")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001598)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001614 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001614")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001614)

	MisResultCondition(HasMission, 2018)
	MisResultCondition(HasFlag, 2018, 4)	
	--MisResultCondition(HasItem, 7055, 1)
	
	MisResultAction(AddItem_Mission11)	
	MisResultAction(AddExp_05persent)    --增加0.5%经验
	MisResultAction(GiveItem, 7056, 1, 4)
	MisResultAction(ClearMission, 2018)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 827)	
	TriggerAction(1, AddNextFlag,2018, 0, 5)
	RegCurTrigger(20181)	
	
	
	----------------------------------------------------------消灭机械魔甲
	MISSCRIPT_MISSIONSCRIPT07_LUA_001615 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001615")
	DefineMission( 6841, MISSCRIPT_MISSIONSCRIPT07_LUA_001615, 2010 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001616 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001616")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001616)
				
	MisBeginCondition(NoMission, 2010)
	MisBeginCondition(NoMission, 2011)
	MisBeginCondition(NoMission, 2012)	
	MisBeginCondition(NoRecord,2010)
	MisBeginCondition(NoRecord,2011)
	MisBeginCondition(NoRecord,2012)
	MisBeginCondition(LvCheck, "<",56)
	MisBeginAction(AddMission,2010)
	MisBeginAction(AddTrigger, 20101, TE_KILL, 1195, 1)---机械魔甲	
	MisCancelAction(ClearMission, 2010)
	MisNeed(MIS_NEED_KILL, 1195,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001617 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001617")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001617)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001618 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001618")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001618)
	MisResultCondition(HasMission,  2010)
	MisResultCondition(HasFlag, 2010, 10)
	MisResultCondition(NoRecord , 2010)
	MisResultAction(GiveItem, 7055, 1, 4 )
	MisResultAction(GiveItem, 7059, 1, 4 )	
	MisResultAction(GiveItem, 5616, 1, 4 )	
	MisResultAction(AddExp_10persent)    --增加10%经验		
	MisResultAction(ClearMission,  2010)
	MisResultAction(SetRecord,  2010 )
	MisResultBagNeed(3)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1195)	
	TriggerAction( 1, AddNextFlag, 2010, 10, 1 )
	RegCurTrigger( 20101 )	
	
	----------------------------------------------------------消灭冰晶幽龙
	MISSCRIPT_MISSIONSCRIPT07_LUA_001619 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001619")
	DefineMission( 6842, MISSCRIPT_MISSIONSCRIPT07_LUA_001619, 2011 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001620 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001620")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001620)
				
	MisBeginCondition(NoMission, 2010)
	MisBeginCondition(NoMission, 2011)
	MisBeginCondition(NoMission, 2012)
	MisBeginCondition(NoRecord,2010)
	MisBeginCondition(NoRecord,2011)
	MisBeginCondition(NoRecord,2012)
	MisBeginCondition(LvCheck, ">",55)
	MisBeginCondition(LvCheck, "<",81)
	MisBeginAction(AddMission,2011)
	MisBeginAction(SetFlag, 2011, 1)
	MisBeginAction(AddTrigger, 20111, TE_KILL, 1196, 1)---冰晶幽龙	
	MisBeginAction(AddTrigger, 20112, TE_GETITEM, 2589, 1 )--精灵王辉印
	MisCancelAction(ClearMission, 2011)
	MisNeed(MIS_NEED_KILL, 1196,1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2589, 1, 20, 1)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001617 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001617")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001617)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001621 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001621")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001621)
	MisResultCondition(HasMission,  2011)
	MisResultCondition(HasItem, 2589, 1 )	
	MisResultCondition(HasFlag, 2011, 10)
	MisResultCondition(NoRecord , 2011)
	MisResultAction(TakeItem, 2589, 1)	
	MisResultAction(GiveItem, 7055, 1, 4 )
	MisResultAction(AddExp_3persent)    --增加3%经验	
	MisResultAction(ClearMission,  2011)
	MisResultAction(SetRecord,  2011 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1196)	
	TriggerAction( 1, AddNextFlag, 2011, 10, 1 )
	RegCurTrigger( 20111 )		
	InitTrigger()
	TriggerCondition( 1, IsItem, 2589 )	
	TriggerAction( 1, AddNextFlag, 2011, 20, 1 )
	RegCurTrigger( 20112 )	
	
	
	----------------------------------------------------------消灭烈焰领主
	MISSCRIPT_MISSIONSCRIPT07_LUA_001622 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001622")
	DefineMission( 6843, MISSCRIPT_MISSIONSCRIPT07_LUA_001622, 2012 )
	MISSCRIPT_MISSIONSCRIPT07_LUA_001623 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001623")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001623)
				
	MisBeginCondition(NoMission, 2010)
	MisBeginCondition(NoMission, 2011)
	MisBeginCondition(NoMission, 2012)
	MisBeginCondition(NoRecord,2010)
	MisBeginCondition(NoRecord,2011)
	MisBeginCondition(NoRecord,2012)
	MisBeginCondition(LvCheck, ">",80)
	MisBeginAction(AddMission,2012)
	MisBeginAction(SetFlag, 2012, 1)
	MisBeginAction(AddTrigger, 20121, TE_KILL, 1197, 1)---烈焰领主	
	MisBeginAction(AddTrigger, 20122, TE_GETITEM, 2589, 10 )--精灵王辉印
	MisCancelAction(ClearMission, 2012)
	MisNeed(MIS_NEED_KILL, 1197,1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2589, 10, 20, 10)
	
	MISSCRIPT_MISSIONSCRIPT07_LUA_001617 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001617")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001617)
	MISSCRIPT_MISSIONSCRIPT07_LUA_001624 = GetResString("MISSCRIPT_MISSIONSCRIPT07_LUA_001624")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT07_LUA_001624)
	MisResultCondition(HasMission,  2012)
	MisResultCondition(HasItem, 2589, 10 )	
	MisResultCondition(HasFlag, 2012, 10)
	MisResultCondition(NoRecord , 2012)
	MisResultAction(TakeItem, 2589, 10)	
	MisResultAction(GiveItem, 7055, 1, 4 )
	MisResultAction(AddExp_3persent)    --增加3%经验	
	MisResultAction(ClearMission,  2012)
	MisResultAction(SetRecord,  2012 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1197)	
	TriggerAction( 1, AddNextFlag, 2012, 10, 1 )
	RegCurTrigger( 20121 )		
	InitTrigger()
	TriggerCondition( 1, IsItem, 2589 )	
	TriggerAction( 1, AddNextFlag, 2012, 20, 10 )
	RegCurTrigger( 20122 )		

	
	
		--------------------------------zhangliang--------------------------新加坡第四季需求任务1-------------------------------------------
	DefineMission( 6865, "Memories of my beloved (Repeatable for 5 times)", 2034 )
	MisBeginTalk("<t> warrior, bring along the [Heart of Warrior] I gave and go teach the evil snow doll a lesson! Lord be with you! <n><t> Mission item required: <r30 Crystal of enhancement, 30 Heart of Sorrow, 30 Crystal of Nimbleness, 30 Heart of Misery><n><t> warrior finish the quest and come look for me at <j garner (908,1073)>.")
				
	--MisBeginCondition(NoMission, 2035)
	MisBeginCondition(NoRecord,2034)
	MisBeginAction(AddMission,2034)
	MisBeginAction(SetFlag, 2034, 1)
	MisBeginAction(AddTrigger, 20341, TE_GETITEM, 3820, 30)--拥有物品数量计数器
	MisBeginAction(AddTrigger, 20342, TE_GETITEM, 3821, 30)
	MisBeginAction(AddTrigger, 20343, TE_GETITEM, 3822, 30)
	MisBeginAction(AddTrigger, 20344, TE_GETITEM, 3823, 30)
	--MisBeginAction(SystemNotice, "该任务无法中断")	
	--
	--这里要写一个函数判断玩家身上是否有任务物品，有则不给，没有则给
	--
	MisBeginAction(CheckFuShenItem, 7142)
	--
	--end
	--
	MisCancelAction(ClearMission, 2034)
	MisNeed(MIS_NEED_ITEM, 3820,30, 3, 30)--完成条件ID， 拥有物品数量，计数器起点 ，记的个数
	MisNeed(MIS_NEED_ITEM, 3821,30, 33, 30)
	MisNeed(MIS_NEED_ITEM, 3822,30, 63, 30)
	MisNeed(MIS_NEED_ITEM, 3823,30, 93, 30)
	-- MisNeed(MIS_NEED_ITEM, 2589, 10, 20, 10)
	
	MisResultTalk("<t> warrior, have collected what I asked you to? Then come receive your rewards! <n>")
	MisHelpTalk("<t> Young warrior, hurry and go teach the evil snow doll a lesson! <n><t> Mission item required: <r30 Crystal of enhancement, 30 Heart of Sorrow, 30 Crystal of Nimbleness, 30 Heart of Misery><n><t> Mission monster kill: <r30 Snow Doll Spirit, 30 Imaginary Snow Doll, 30 Evil Snow Doll Spirit, 30 Confused Snow Doll> ")
	MisResultCondition(HasMission,  2034)
	-- MisResultCondition(HasItem, 2589, 10 )
	MisResultCondition(HasItem, 3820, 30 )
	MisResultCondition(HasItem, 3821, 30 )
	MisResultCondition(HasItem, 3822, 30 )
	MisResultCondition(HasItem, 3823, 30 )
	--MisResultCondition(HasFlag, 2034, 32)------判断任务完成，计数器标志位是否达到要求
	--MisResultCondition(HasFlag, 2034, 62)
	--MisResultCondition(HasFlag, 2034, 92)
	--MisResultCondition(HasFlag, 2034, 122)
	MisResultCondition(NoRecord , 2034)
	
	-- MisResultAction(AddExp_3persent)    --增加3%经验	
	--MisResultAction()--根据任务次数给奖励 ----------------------------------------------------------------进度-到此-----  自己写的函数需要到missionSDK里面注册---函数体写在function里面--------
	MisResultBagNeed(3)--要三个空背包格子
	MisResultAction(TakeItem, 3820, 30)
	MisResultAction(TakeItem, 3821, 30)
	MisResultAction(TakeItem, 3822, 30)
	MisResultAction(TakeItem, 3823, 30)
	MisResultAction(GivePointsAndMoney,7142) 
	MisResultAction(ClearMission,  2034)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3820)	
	TriggerAction( 1, AddNextFlag, 2034, 3, 30 )--计数器ID ，起点，个数
	RegCurTrigger( 20341 )		
	InitTrigger()
	TriggerCondition( 1, IsItem, 3821 )	
	--MisBeginAction(SystemNotice, "该任务无法中断")	
	TriggerAction( 1, AddNextFlag, 2034, 33, 30 )
	RegCurTrigger( 20342 )	
    InitTrigger()
	TriggerCondition( 1, IsItem, 3822)	
	TriggerAction( 1, AddNextFlag, 2034, 63, 30 )
	RegCurTrigger( 20343 )
    InitTrigger()
	TriggerCondition( 1, IsItem, 3823)	
	TriggerAction( 1, AddNextFlag, 2034, 93, 30 )
	RegCurTrigger( 20344 )	
	
	--------------------------------zhangliang--------------------------新加坡第四季需求任务2-------------------------------------------
	DefineMission( 6866, "The last revenge (Repeatable for 5 times)", 2035 )
	MisBeginTalk("<t> warrior, bring along the [Heart of Warrior] I gave and go teach the evil snowman a lesson! Lord be with you! <n><t> Mission required: <r30 Demonic Giant Blade, 30 Demonic Giant Stick, 30 Ter Runestone, 30 Fa Runestone><n><t> warrior finish the quest and come look for me at <j Ascaron (908,1073)>.")
				
	--MisBeginCondition(NoMission, 2035)
	MisBeginCondition(NoRecord,2035)
	MisBeginAction(AddMission,2035)
	MisBeginAction(SetFlag, 2035, 1)
	MisBeginAction(AddTrigger, 20351, TE_GETITEM, 3824, 30)--杀死怪物数量计数器
	MisBeginAction(AddTrigger, 20352, TE_GETITEM, 3825, 30)
	MisBeginAction(AddTrigger, 20353, TE_GETITEM, 3455, 30)
	MisBeginAction(AddTrigger, 20354, TE_GETITEM, 3456, 30)
	--MisBeginAction(SystemNotice, "该任务无法中断")	
	--
	--这里要写一个函数判断玩家身上是否有任务物品，有则不给，没有则给
	--
	MisBeginAction(CheckFuShenItem, 7143)
	--
	--end
	--
	MisCancelAction(ClearMission, 2035)
	MisNeed(MIS_NEED_ITEM, 3824,30, 3, 30)--完成条件ID， 杀死数量，计数器起点 ，记的个数
	MisNeed(MIS_NEED_ITEM, 3825,30, 33, 30)
	MisNeed(MIS_NEED_ITEM, 3455,30, 63, 30)
	MisNeed(MIS_NEED_ITEM, 3456,30, 93, 30)
	-- MisNeed(MIS_NEED_ITEM, 2589, 10, 20, 10)
	
	MisResultTalk("<t> warrior, have collected what I asked you to? Then come receive your rewards! <n>")
	MisHelpTalk("<t> Young warrior, hurry and go teach the Snowman a lesson! <n><t> Mission item required: Mission item required: <r30 Demonic Giant Blade, 30 Demonic Giant Stick, 30 Ter Runestone, 30 Fa Runestone><t> Mission monster kill: <r50 Demonic Snowman, 50 Demonic Yeti><n>")
	MisResultCondition(HasMission,  2035)
	-- MisResultCondition(HasItem, 2589, 10 )
	MisResultCondition(HasItem, 3824, 30 )
	MisResultCondition(HasItem, 3825, 30 )
	MisResultCondition(HasItem, 3455, 30 )
	MisResultCondition(HasItem, 3456, 30 )
	--MisResultCondition(HasFlag, 2035, 109)------判断任务完成，计数器标志位是否达到要求
	--MisResultCondition(HasFlag, 2035, 209)
	--MisResultCondition(HasFlag, 2035, 259)
	--MisResultCondition(HasFlag, 2035, 309)
	MisResultCondition(NoRecord , 2035)
	
	-- MisResultAction(AddExp_3persent)    --增加3%经验	
	--MisResultAction()--根据任务次数给奖励 ----------------------------------------------------------------进度-到此-----  自己写的函数需要到missionSDK里面注册---函数体写在function里面--------
	MisResultBagNeed(1)--要三个空背包格子
	MisResultAction(TakeItem, 3824, 30)
	MisResultAction(TakeItem, 3825, 30)
	MisResultAction(TakeItem, 3455, 30)
	MisResultAction(TakeItem, 3456, 30)
	MisResultAction(GivePointsAndMoney,7143) 
	MisResultAction(ClearMission,  2035)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3824)	
	TriggerAction( 1, AddNextFlag, 2035, 3, 60 )--计数器ID ，起点，个数
	RegCurTrigger( 20351 )		
	InitTrigger()
	TriggerCondition( 1, IsItem, 3825 )		
	TriggerAction( 1, AddNextFlag, 2035, 33, 60 )
	RegCurTrigger( 20352 )	
    InitTrigger()
	TriggerCondition( 1, IsItem, 3455)	
	TriggerAction( 1, AddNextFlag, 2035, 63, 30 )
	RegCurTrigger( 20353 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3456)	
	TriggerAction( 1, AddNextFlag, 2035, 93, 30 )
	RegCurTrigger( 20354 )	
	
	-----------------------------------X1------------愚人节活动-------------------------------------------------------------
	-----------------------------------------------任务：寻找4个兄弟---------------------------------------------------
	DefineMission( 6870, "Search for my beloved brothers (Inquire family news)", 2039 )
	MisBeginTalk("<t>It has been a long time I've last seen my brothers. Help me to send regards and collect their keepsake for me.")

	MisBeginCondition(NoRecord,2039)
	MisBeginAction(AddMission,2039)
	MisBeginAction(SetRecord, 2039)
    MisBeginAction(SetFlag, 2039, 1)
	MisBeginAction(AddTrigger, 20391, TE_GETITEM, 7373, 1)----------------拥有物品数量计数器
	MisBeginAction(AddTrigger, 20392, TE_GETITEM, 7374, 1)
	MisBeginAction(AddTrigger, 20393, TE_GETITEM, 7375, 1)
	MisBeginAction(AddTrigger, 20394, TE_GETITEM, 7376, 1)


	MisCancelAction(ClearMission, 2039)
	MisNeed(MIS_NEED_ITEM, 7373,1, 10, 1)--完成条件ID， 拥有物品数量，计数器起点 ，记的个数
	MisNeed(MIS_NEED_ITEM, 7374,1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 7375,1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 7376,1, 40, 1)
		
	MisResultTalk("<t> Thank you for helping me to find my brother. I shall give you this ancient incantation to express my thanks. <n>")
	MisHelpTalk("<t> Young warrior, have you not found my brothers yet? My second brother Yay should be located at <j Magical Ocean(797,3554)><n> ")
	MisResultCondition(HasMission,  2039)
	MisResultCondition(HasItem, 7373, 1)
	MisResultCondition(HasItem, 7374, 1)
	MisResultCondition(HasItem, 7375, 1)
	MisResultCondition(HasItem, 7376, 1)
	--MisResultCondition(HasFlag, 2034, 32)------判断任务完成，计数器标志位是否达到要求
	--MisResultCondition(HasFlag, 2034, 62)
	--MisResultCondition(HasFlag, 2034, 92)
	--MisResultCondition(HasFlag, 2034, 122)
	--MisResultCondition(NoRecord , 2034)
	
	MisResultBagNeed(1)----------------------要1个空背包格子
	MisResultAction(TakeItem, 7373, 1)
	MisResultAction(TakeItem, 7374, 1)
	MisResultAction(TakeItem, 7375, 1)
	MisResultAction(TakeItem, 7376, 1)
	MisResultAction(GiveItem, 7377, 1 ,4) 
	MisResultAction(ClearMission,  2039)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 7373 )	
	TriggerAction( 1, AddNextFlag, 2039, 10, 1 )-----------------计数器                 ID ，起点，个数
	RegCurTrigger( 20391 )		
	InitTrigger()
	TriggerCondition( 1, IsItem, 7374 )	
	TriggerAction( 1, AddNextFlag, 2039, 20, 1 )
	RegCurTrigger( 20392 )	
    InitTrigger()
	TriggerCondition( 1, IsItem, 7375 )
	TriggerAction( 1, AddNextFlag, 2039, 30, 1 )
	RegCurTrigger( 20393 )
    InitTrigger()
	TriggerCondition( 1, IsItem, 7376 )	
	TriggerAction( 1, AddNextFlag, 2039, 40, 1 )
	RegCurTrigger( 20394 )	
	
	--------------------------------------------老二的信物------------------------------------------------------
	DefineMission( 6871, "Tourist - Yay's keepsake", 2040 )
	MisBeginTalk("<t>Today's weather is great! I'm practicing my cooking, so do not disturb me now. Why don't you get me 10 Sashimi first.")

	MisBeginCondition(NoRecord,2040)
	MisBeginCondition(HasMission,2039)
	MisBeginAction(AddMission,2040)
	MisBeginAction(SetRecord, 2040)
    MisBeginAction(SetFlag, 2040, 1)
	MisBeginAction(AddTrigger, 20401, TE_GETITEM, 1478, 10)----------------拥有物品数量计数器

	MisCancelAction(ClearMission, 2040)
	MisNeed(MIS_NEED_ITEM, 1478,10, 10, 10)-------完成条件ID， 拥有物品数量，计数器起点 ，记的个数
		
	MisResultTalk("<t> Thank you for finding me these sashimi. You can proceed on to look for my third brother Bey. He is at  <j Ascaron(669,1554)> <n>")
	MisHelpTalk("<t> Hurry go search for some sashimi.. <n> ")
	MisResultCondition(HasMission,  2039)
	MisResultCondition(HasItem, 1478, 10)
	
	MisResultBagNeed(1)----------------------要1个空背包格子
	MisResultAction(TakeItem, 1478, 10)
	MisResultAction(GiveItem, 7373, 1 ,4) 
	MisResultAction(ClearMission,  2040)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1478 )	
	TriggerAction( 1, AddNextFlag, 2040, 10, 10 )-----------------计数器                 ID ，起点，个数
	RegCurTrigger( 20401 )		

	--------------------------------------------老三的信物------------------------------------------------------
	DefineMission( 6872, "Tourist - Bey's keepsake", 2041 )
	MisBeginTalk("<t>Today's weather is great! I'm practicing flower deco, so do not disturb me now. Why don't you get me 10 Sweet Smelling.")

	MisBeginCondition(NoRecord,2041)
	MisBeginCondition(HasMission,2039)
	MisBeginCondition(HasItem,7373,1)
	MisBeginAction(AddMission,2041)
	MisBeginAction(SetRecord, 2041)
    MisBeginAction(SetFlag, 2041, 1)
	MisBeginAction(AddTrigger, 20411, TE_GETITEM, 4322, 10)----------------拥有物品数量计数器
	MisCancelAction(ClearMission, 2041)
	MisNeed(MIS_NEED_ITEM, 4322,10, 10, 10)-------完成条件ID， 拥有物品数量，计数器起点 ，记的个数
		
	MisResultTalk("<t> Thank you for finding me these Sweet Smelling Flower. You can proceed on to look for my fourth brother Tink. He is at <j Deep Blue(1335,469)> <n>")
	MisHelpTalk("<t> Hurry go search for some Sweet Smelling Flower.. <n> ")
	MisResultCondition(HasMission,  2041)
	MisResultCondition(HasItem, 4322, 10)

	MisResultBagNeed(1)----------------------要1个空背包格子
	MisResultAction(TakeItem, 4322, 10)
	MisResultAction(GiveItem, 7374, 1 ,4) 
	MisResultAction(ClearMission,  2041)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4322 )	
	TriggerAction( 1, AddNextFlag, 2041, 10, 10 )-----------------计数器                 ID ，起点，个数
	RegCurTrigger( 20411 )		
	
		--------------------------------------------老四的信物------------------------------------------------------
	DefineMission( 6873, "Tourist - Tink's keepsake", 2042 )
	MisBeginTalk("<t>Today's weather is great! I'm practicing calligraphy, so do not disturb me now. Why don't you get me 10 Frozen Squid Ink first.")

	MisBeginCondition(NoRecord,2042)
	MisBeginCondition(HasMission,2039)
	MisBeginCondition(HasItem,7374,1)
	MisBeginAction(AddMission,2042)
	MisBeginAction(SetRecord, 2042)
    MisBeginAction(SetFlag, 2042, 1)
	MisBeginAction(AddTrigger, 20421, TE_GETITEM, 4318, 10)----------------拥有物品数量计数器
	MisCancelAction(ClearMission, 2042)
	MisNeed(MIS_NEED_ITEM, 4318,10, 10, 10)-------完成条件ID， 拥有物品数量，计数器起点 ，记的个数
		
	MisResultTalk("<t> Thank you for finding me these Frozen Squid Ink. You can proceed on to look for my fifth brother Seb. He is at <j Deep Blue(3201,2470)> <n>")
	MisHelpTalk("<t> Hurry go search for some Frozen Squid Ink.. <n> ")
	MisResultCondition(HasMission,  2042)
	MisResultCondition(HasItem, 4318, 10)

	MisResultBagNeed(1)----------------------要三个空背包格子
	MisResultAction(TakeItem, 4318, 10)
	MisResultAction(GiveItem, 7375, 1 ,4) 
	MisResultAction(ClearMission,  2042)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4318 )	
	TriggerAction( 1, AddNextFlag, 2042, 10, 10 )-----------------计数器                 ID ，起点，个数
	RegCurTrigger( 20421 )	
	
	----------------------老5的信物--------------------------
	DefineMission( 6874, "Tourist - Seb's keepsake", 2043 )
	
	
	------------------------麋鹿被绑架了
    DefineMission(7023, "Kidnapped Reindeer", 2230)

	MisBeginTalk("<t>My reindeer has been kidnapped by Evil Claus!Can you get it back for me?Evil Claus's boat has been sighted near Deep Blue (1204,795)!")

	MisBeginCondition(NoMission, 2230)
	MisBeginCondition(NoRecord, 2030)
	MisBeginCondition(Sdhd_check)
	MisBeginAction(AddMission, 2230)
	MisBeginAction(AddTrigger, 22301, TE_GETITEM, 7719, 1)
    MisCancelAction(ClearMission, 2230)
	-- MisCancelAction(SystemNotice, "Unable to abandon Christmas loop quest")

	MisNeed(MIS_NEED_DESP, "Recover the kidnapped reindeer!")
	MisNeed(MIS_NEED_ITEM, 7719, 1, 1, 1)

	MisHelpTalk("<t>Evil Claus's boat is sighted near Deep Blue (1204,795),help me to recover my reindeer!")
	MisResultTalk("<t>My reindeer has been recovered.Thank you so much but now my snow sledge has broken down.")

	MisResultCondition(HasMission, 2230)
	MisResultCondition(HasItem, 7719, 1)

	MisResultAction(ClearMission, 2230)
	MisResultAction(TakeItem, 7719,1)
	MisResultAction(SetRecord, 2030)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 7719)
	TriggerAction(1, AddNextFlag, 2230, 1, 1)
	RegCurTrigger( 22301 )

	
-------------------------被摧毁的雪橇车	
    DefineMission(7024, "Destroyed snow sledge", 2231)

	MisBeginTalk("<t>My snow sledge has been destroyed by Evil Claus,can you find some materials to repair the damage?")

	MisBeginCondition(NoMission, 2231)
	MisBeginCondition(NoRecord, 2031)
	MisBeginCondition(HasRecord, 2030)
	MisBeginAction(AddMission, 2231)
	MisBeginAction(AddTrigger, 22311, TE_GETITEM, 4543, 5)
    MisBeginAction(AddTrigger, 22312, TE_GETITEM, 4544, 5)
	MisBeginAction(AddTrigger, 22313, TE_GETITEM, 4545, 5)
    MisBeginAction(AddTrigger, 22314, TE_GETITEM, 4546, 5)
	-- MisCancelAction(SystemNotice, "Unable to abandon Christmas loop quest")
    MisCancelAction(ClearMission, 2231)
	MisNeed(MIS_NEED_DESP, "Search for the alloy and timber to repair the snow sledge")
	MisNeed(MIS_NEED_ITEM, 4543, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4544, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4545, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4546, 5, 10, 5)

	
	
	MisHelpTalk("<t>Farm Iron Ore to obtain iron ore,farm Stone Ore to obtain energy ore,farm crystal ore to ")
	MisResultTalk("<t>obtain crystal ore and chop Pine Tree to obtain wood.")

	MisResultCondition(HasMission, 2231)
	MisResultCondition(HasItem, 4543, 5)
	MisResultCondition(HasItem, 4544, 5)
	MisResultCondition(HasItem, 4545, 5)
	MisResultCondition(HasItem, 4546, 5)

	MisResultAction(ClearMission, 2231)
	MisResultAction(SetRecord, 2031)
	MisResultAction(TakeItem, 4543,5)
	MisResultAction(TakeItem, 4544,5)
	MisResultAction(TakeItem, 4545,5)
	MisResultAction(TakeItem, 4546,5)
			
			
	InitTrigger()
	TriggerCondition(1, IsItem, 4543)
	TriggerAction(1, AddNextFlag, 2231, 5, 5)
	RegCurTrigger( 22311 )
	
	InitTrigger()
	TriggerCondition(1, IsItem, 4544)
	TriggerAction(1, AddNextFlag, 2231, 5, 5)
	RegCurTrigger( 22312 )
	
		InitTrigger()
	TriggerCondition(1, IsItem, 4545)
	TriggerAction(1, AddNextFlag, 2231, 5, 5)
	RegCurTrigger( 22313 )
	
		InitTrigger()
	TriggerCondition(1, IsItem, 4546)
	TriggerAction(1, AddNextFlag, 2231, 5, 5)
	RegCurTrigger( 22314 )
		
		

-------------------------饥饿的麋鹿	
    DefineMission(7025, "Famished Reindeer", 2232)

	MisBeginTalk("<t>The reindeer is so frail.Find some fish for it to recover its energy")

	MisBeginCondition(NoMission,  2232)
	MisBeginCondition(NoRecord, 2032)
	MisBeginCondition(HasRecord, 2031)
	MisBeginAction(AddMission, 2232)
	MisBeginAction(AddTrigger, 22321, TE_GETITEM, 4551, 10)
	-- MisCancelAction(SystemNotice, "Unable to abandon Christmas loop quest")
    MisCancelAction(ClearMission, 2232)
	MisNeed(MIS_NEED_DESP, "Catch some fish in the sea for the reindeer")
	MisNeed(MIS_NEED_ITEM, 4551, 10, 20, 10)

	
	MisHelpTalk("<t>Schools of fish has been spotted in the sea near Argent City, hurry and catch some!")
	MisResultTalk("<t>Normal fish has no effect if it wasn't processed with the Mysterious Formula. ")

	MisResultCondition(HasMission, 2232)
	MisResultCondition(HasItem, 4551, 10)

	MisResultAction(ClearMission, 2232)
	MisResultAction(SetRecord, 2032)
	MisResultAction(TakeItem, 4551,10)
 

	InitTrigger()
	TriggerCondition(1, IsItem, 4551)
	TriggerAction(1, AddNextFlag, 2232, 20, 10)
	RegCurTrigger( 22321 )
	
	
	
-------------------------神秘配方	
    DefineMission(7026, "Mysterious formula", 2233)

	MisBeginTalk("<t>Current fish need to be processed with the Mysterious Formula to obtain the best effect.")

	MisBeginCondition(NoMission, 2233)
	MisBeginCondition(NoRecord, 2033)
	MisBeginCondition(HasRecord, 2032)
	MisBeginAction(AddMission, 2233)
	MisBeginAction(AddTrigger, 22331, TE_GETITEM, 7718, 1)
	-- MisCancelAction(SystemNotice, "Unable to abandon Christmas loop quest")
    MisCancelAction(ClearMission, 2233)
	MisNeed(MIS_NEED_DESP, "Salvage the lost sunken ship to obtain the Mysterious Formula")
	MisNeed(MIS_NEED_ITEM, 7718, 1, 20, 1)

	
	MisHelpTalk("<t>Sunken boats are found in the sea near the main cities,go salvage it now!")
	MisResultTalk("<t>Reindeer has recovered!Now to find my lost presents.Keep it up!")

	MisResultCondition(HasMission, 2233)
	MisResultCondition(HasItem, 7718, 1)

	MisResultAction(ClearMission, 2233)
	MisResultAction(SetRecord, 2033)
	MisResultAction(TakeItem, 7718,1)
 

	InitTrigger()
	TriggerCondition(1, IsItem, 7718)
	TriggerAction(1, AddNextFlag, 2233, 20, 1)
	RegCurTrigger( 22331 )
	
-------------------------丢失的礼物	
    DefineMission(7027, "Lost present", 2234)

	MisBeginTalk("<t>Santa Claus accidentally dropped some presents around the world due to negligance a month ")

	MisBeginCondition(NoMission,  2234)
	MisBeginCondition(HasRecord, 2033)
	MisBeginAction(AddMission, 2234)
	MisBeginAction(AddTrigger, 22341, TE_GETITEM, 7717, 5)
	-- MisCancelAction(SystemNotice, "Unable to abandon Christmas loop quest")
    MisCancelAction(ClearMission, 2234)
	MisNeed(MIS_NEED_DESP, "Find the lost presents")
	MisNeed(MIS_NEED_ITEM, 7717, 5, 20, 5)

	
	MisHelpTalk("<t>Sunken boats are found in the sea near the main cities,the presents might be there.Go check ")
	MisResultTalk("<t>it out.")

	MisResultCondition(HasMission, 2234)
	MisResultCondition(HasItem, 7717, 5)

	MisResultAction(ClearMission, 2234)
	MisResultAction(GiveSDItem_SetAttr)
	MisResultAction(ClearRecord, 2030)
	MisResultAction(ClearRecord, 2031)
	MisResultAction(ClearRecord, 2032)
	MisResultAction(ClearRecord, 2033)
	MisResultAction(TakeItem, 7717,5)
 	MisResultAction(GiveItem, 7720,1,4)

	InitTrigger()
	TriggerCondition(1, IsItem, 7717)
	TriggerAction(1, AddNextFlag, 2234, 20, 5)
	RegCurTrigger( 22341 )
	
	
	---------------------------------------送贺卡任务-------------------------------------KIMI
	DefineMission( 7028, "Deliver Christmas Card", 2235 )
	
	MisBeginTalk( "Hi!I hadn't have time to send Christmas Card to Christmas Granny as I'm busy giving out ")
	MisBeginCondition(NoMission, 2235)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoRecord, 2235) 
	MisBeginAction(jsq)             --给予记时器的道具    记录时间
	MisBeginAction(AddMission, 2235)
	MisCancelAction(ClearMission, 2235)
	
	
	MisNeed(MIS_NEED_DESP, "Christmas Granny is always moving around,find clues to her whereabouts by going to Argent City 2292,2508.")
	MisHelpTalk("Aren't you on the way yet?")
    MisResultCondition(AlwaysFailure)
	------------------------------------送贺卡任务----------------------------------------KIMI
    DefineMission(7030, "Deliver Christmas Card", 2235, COMPLETE_SHOW )
   
	MisResultTalk("<t>Ah!Thank you dear kid!I have a present for you.")
	MisBeginCondition(NoMission, 2235)
    MisBeginCondition(HasMission, 2235)
	MisResultCondition(NoRecord, 2235)
	MisResultCondition(HasMission,2235)
	MisResultAction(ClearMission,2235)
	MisResultAction(SetRecord, 2235)
	MisResultCondition(HasItem, 8737, 1 )
	MisResultAction(TakeItem, 8737, 1 )
	
	MisResultAction(wcjsq)  ------根据时间判断奖励
	--------------------------------------------------------老奶奶的行踪---------------------KIMI
   DefineMission( 7029, "Christmas Granny's Whereabouts", 2236 )
	
	MisBeginTalk( "<t>I do know where Granny is,but recently Little Squidy has been pestering me.Teach it a lesson and i will tell you her whereabouts.")

	MisBeginCondition(NoMission, 2236)
    MisBeginCondition(HasMission, 2235)
	MisBeginCondition(NoRecord, 2235)
	MisBeginCondition(NoRecord, 2236)
	MisBeginAction(AddMission, 2236)
	MisBeginAction(AddTrigger, 22361, TE_KILL, 70,10)
	MisCancelAction(ClearMission, 2236)

	MisNeed(MIS_NEED_KILL, 70,10, 10,10)
	
	MisHelpTalk("<t>Teach 10 <bLittle Squidy> a lesson to complete the quest.")
	MisResultTalk("<t>You have done well.Here's a note with Christmas Granny's coordinates.Take it.")
	MisResultCondition(NoRecord, 2236)
	MisResultCondition(HasMission, 2236)
	MisResultCondition(HasFlag, 2236, 19 )
	MisResultAction(ClearMission, 2236)
	MisResultAction(SetRecord, 2236)
	
	MisResultBagNeed(1)
	MisResultAction(GiveItem,8737,1,4)

	InitTrigger()                              
	TriggerCondition( 1, IsMonster, 70 )	
	TriggerAction( 1, AddNextFlag, 2236, 10,10)
	RegCurTrigger( 22361 )
	
	
	--------------------------------------------2010七夕-------------------------------------------------------------
-------------------------------喜鹊之灵------织女-----------
	DefineMission( 7015, "Magpie Spirit", 2222 ) 
	MisBeginTalk("<t>Every year, Magpies' will come and help us by creating a Magpie Bridge. But this year, we heard no news of them coming over to help us. Watching as time goes by, i wonder why are they not here yet? Or is it fated that we won't be able to meet each other this year? Kind one, please help me collect 50 Magpie Spirit, that allows me to send message to Magpies'!")

	MisBeginCondition(HasMission, 2224 )
	MisBeginCondition(NoRecord,2222)
	MisBeginCondition(NoMission, 2222 )
	MisBeginAction(AddMission,2222)
	MisBeginAction(AddTrigger, 22221, TE_GETITEM, 7113, 50)----------------拥有物品数量计数器
	MisCancelAction(ClearMission, 2222)
	
	MisHelpTalk("<t> Help ZhiNu send message by collecting 50 Magpie Spirit")
	MisNeed(MIS_NEED_DESP, "Collect 50 Magpie Spirit from Dark Swamp Swamp Warden, Swamp Man, Swamp Watcher or Abanddon Hell Pharaoh A, Hell Pharaoh B, Deathsoul Speed Boat and hand it to ZhiNu.")
	MisNeed(MIS_NEED_ITEM, 7113,50, 1, 50)--完成条件ID， 拥有物品数量，计数器起点 ，记的个数
	MisResultTalk("<t> Thank you very much, kind one! Could you bring Golden Silk Armor to NiuLang(3734,2649) at Summer Island, please tell him I miss him, no matter what I will wait for him to see me~<n>")

	MisResultCondition(HasMission, 2222)
	MisResultCondition(NoRecord,2222)
	MisResultCondition(HasItem, 7113, 50)
	MisResultAction(TakeItem, 7113,50)
	MisResultAction(GiveItem, 8424, 1, 4 )
	MisResultAction(ClearMission, 2222)
	MisResultAction(SetRecord, 2222 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 7113)	
	TriggerAction( 1, AddNextFlag, 2222, 1, 50 )
	RegCurTrigger( 22221 )
	
-------------------------------红绳情丝------牛郎-----------
	DefineMission( 7016, "Red String of Love", 2223)
	
	MisBeginTalk( "<t>Golden Silk Armor? So it was ZhiNu who ask you to come, but this doesn't allow us to meet with each other. Kind one, could you do me a favor by collecting another 30 Red String.")
	MisBeginCondition(HasRecord, 2222 )
	MisBeginCondition(NoRecord, 2223 )
	MisBeginCondition(NoMission, 2223 )
	MisBeginAction(AddMission,2223)
	MisBeginAction(AddTrigger, 22231, TE_GETITEM, 2845, 30)----------------拥有物品数量计数器
	MisCancelAction(ClearMission, 2223)
	
	MisHelpTalk("<t> Help NiuLang collect 30 Red String of Love ")
	MisNeed(MIS_NEED_DESP, "Collect 30 Red String from Demonic World Evil Snow Doll Spirit, Confused Snow Doll, Demonic Snowman and Mirage Level 3 Ice Guard, Berserk Snowboar, Snow Mistress and hand it to NiuLang")
	MisNeed(MIS_NEED_ITEM, 2845,30, 1, 30)--完成条件ID， 拥有物品数量，计数器起点 ，记的个数
	MisResultTalk("<t> That was fast! Kind one, we have no idea how to thank you for your help. Could you also do me a favor by bringing this letter and Golden Silk Armor to YueLao(2232,2778) at Argent City, let him tie the Red String on our wrist.<n>")

	MisResultCondition(HasMission, 2223)
	MisResultCondition(HasItem, 2845, 30)
	MisResultAction(TakeItem, 2845,30)
	MisResultAction(GiveItem, 8425, 1, 4 )
	MisResultAction(ClearMission, 2223)
	MisResultAction(SetRecord, 2223 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 2845)	
	TriggerAction( 1, AddNextFlag, 2223, 1, 30 )
	RegCurTrigger( 22231 )

-------------------------------一线情缘------月老-----------
	DefineMission( 7017, "Line of Love", 2224 ) 
	MisBeginTalk("<t>The love between NiuLang and ZhiNu all depends on their miss for each other, bonding them together. Till now, we have yet to see the magpie coming to build the bridge. Let me do a divination.... <n>Oh! There will be a savior that will comefore to help them and the savior is no other than you!")

	MisBeginCondition(NoRecord,2224)
	MisBeginCondition(NoMission, 2224 )
	MisBeginAction(AddMission,2224)
	MisBeginAction(AddTrigger, 22241, TE_GETITEM, 8424, 1)----------------拥有物品数量计数器
	MisBeginAction(AddTrigger, 22242, TE_GETITEM, 8425, 1)
	MisCancelAction(ClearMission, 2224)
	
	MisHelpTalk("<t> Take ZhiNu and NiuLang pledge of love to YueLao")
	MisNeed(MIS_NEED_DESP, "Firstly, go to Spring Island and help ZhiNu(3219,2489) fulfil her request, following on go to Summer Island and look for NiuLang(3734,2649).  <n>Complete all of their request than come back and look for YueLao.")
	MisNeed(MIS_NEED_ITEM, 8424,1, 1, 1)--完成条件ID， 拥有物品数量，计数器起点 ，记的个数
	MisNeed(MIS_NEED_ITEM, 8425,1, 2, 1)
	MisResultTalk("<t>NiuLang is able to meet ZhiNu is all possible by your helping hand~ As a reward, Take this Seventh Moon Chest as a reward. This is an Immortal Item!")

	MisResultCondition(HasMission, 2224)
	MisResultCondition(NoRecord,2224)
	MisResultCondition(HasItem, 8424, 1)
	MisResultCondition(HasItem, 8425, 1)
	MisResultAction(TakeItem, 8424,1)
	MisResultAction(TakeItem, 8425,1)
	MisResultAction(GiveItem, 8426, 1, 4 )
	MisResultAction(ClearMission, 2224)
	MisResultAction(SetRecord, 2224 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 8424)	
	TriggerAction( 1, AddNextFlag, 2224, 1, 1 )
	RegCurTrigger( 22241 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 8425)	
	TriggerAction( 1, AddNextFlag, 2224, 2, 1 )
	RegCurTrigger( 22242 )
	
	-----------------2011大版本二期活动------ Cindy--------
	DefineMission(7046, "D-Dragon Revive",2248)
	MisBeginTalk("<t>Rumors says Ascaron WangZeng uses a cursed seal D-Dragon Revive to win enemy invasion. I know how to create this seal. However, i'm still short of 1 material. Can you help me get it? Some says it can be found at the Item Mall. In return, i will give you this D-Dragon Cake. All you need is the D-Dragon Scale. This is all i need to solve the mystery of the cursed seal.")
	MisBeginCondition(NoRecord,2248)
	MisBeginCondition(NoMission, 2248)
	MisBeginAction(AddMission, 2248)
	MisBeginAction(AddTrigger, 22481, TE_GETITEM, 7681, 1 )
	MisCancelAction(ClearMission, 2248)
	MisNeed(MIS_NEED_ITEM, 7681, 1, 10, 1)
	MisResultTalk("<t>Great, this is just what I need. In return, I shall give you this D-Dragon Cake. It will gives you additional stat points!")
	MisHelpTalk("<t>Rumors says it was once seen in Item Mall! Quick help me look for it!")

	MisResultCondition(HasMission, 2248)
	MisResultCondition(HasItem, 7681, 1 )------判断任务完成，计数器标志位是否达到要求
	MisResultAction(TakeItem, 7681, 1 )
	MisResultAction(GiveItem, 7682,1,4)
	MisResultAction(ClearMission, 2248)
	MisResultAction(SetRecord, 2248 )
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1,IsItem, 7681)
	TriggerAction(1,AddNextFlag, 2248, 10, 1)
	RegCurTrigger(22481)