--------------------------------------------------------------------------
--									--
--									--
--				MissionScript05.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading MissionScript05.lua" )


jp= JumpPage
amp=AutoMissionPage
ct=CloseTalk
am=AddMission
MissionCheck = HasFlag
mc=MissionCheck

----------------------------------------------------------
--							--
--							--
--		ÇøÓòÈÎÎñ	 				--
--							--
--							--
----------------------------------------------------------
	-->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Ö÷ÏßÈÎÎñ¿ªÊ¼
function AreaMission001()

-----------------------------------µÁÈ¡·ä³²
	MISSCRIPT_MISSIONSCRIPT05_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000001")
	DefineMission( 600, MISSCRIPT_MISSIONSCRIPT05_LUA_000001, 600 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000002 )
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 600)
	MisBeginCondition(NoRecord, 600)
	MisBeginAction(AddMission, 600)
	MisBeginAction(AddTrigger, 6001, TE_GETITEM, 4085, 1 )
	MisCancelAction(ClearMission, 600)

	MisNeed(MIS_NEED_ITEM, 4085, 1, 10, 1)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000003 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000003")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000003)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000004")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000004)
	MisResultCondition(NoRecord, 600)
	MisResultCondition(HasMission, 600)
	MisResultCondition(HasItem, 4085, 1)
	MisResultAction(TakeItem, 4085, 1)
	MisResultAction(ClearMission, 600)
	MisResultAction(SetRecord, 600)
	MisResultAction(AddExp, 800, 800)
	MisResultAction(AddMoney,270,270)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4085 )	
	TriggerAction( 1, AddNextFlag, 600, 10, 1 )
	RegCurTrigger( 6001 )

-----------------------------------¼ßÃðÒ°Âù·ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000005")
	DefineMission( 601, MISSCRIPT_MISSIONSCRIPT05_LUA_000005, 601 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000006")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000006 )
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(HasRecord, 600)
	MisBeginCondition(NoMission, 601)
	MisBeginCondition(NoRecord, 601)
	MisBeginAction(AddMission, 601)
	MisBeginAction(AddTrigger, 6011, TE_KILL, 139, 10 )
	MisCancelAction(ClearMission, 601)

	MisNeed(MIS_NEED_KILL, 139, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000007")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000007)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000008 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000008")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000008)
	MisResultCondition(NoRecord, 601)
	MisResultCondition(HasMission, 601)
	MisResultCondition(HasFlag, 601, 19 )
	MisResultAction(ClearMission, 601)
	MisResultAction(SetRecord, 601)
	MisResultAction(AddExp, 800, 800)
	MisResultAction(AddMoney,270,270)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 139 )	
	TriggerAction( 1, AddNextFlag, 601, 10, 10 )
	RegCurTrigger( 6011 )

-----------------------------------ÈÅÈËÇåÃÎ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000009")
	DefineMission( 602, MISSCRIPT_MISSIONSCRIPT05_LUA_000009, 602 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000010 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000010")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000010 )
	MisBeginCondition(LvCheck, ">", 20 )
	MisBeginCondition(HasRecord, 603)
	MisBeginCondition(NoMission, 602)
	MisBeginCondition(NoRecord, 602)
	MisBeginAction(AddMission, 602)
	MisBeginAction(AddTrigger, 6021, TE_KILL, 224, 10 )
	MisCancelAction(ClearMission, 602)

	MisNeed(MIS_NEED_KILL, 224, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000011")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000011)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000012")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000012)
	MisResultCondition(NoRecord, 602)
	MisResultCondition(HasMission, 602)
	MisResultCondition(HasFlag, 602, 19 )
	MisResultAction(ClearMission, 602)
	MisResultAction(SetRecord, 602)
	MisResultAction(AddExp, 1000, 1000)
	MisResultAction(AddMoney,285,285)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 224 )	
	TriggerAction( 1, AddNextFlag, 602, 10, 10 )
	RegCurTrigger( 6021 )


-----------------------------------Ñ§ÕßÃ¨Í·Ó¥
	MISSCRIPT_MISSIONSCRIPT05_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000013")
	DefineMission( 603, MISSCRIPT_MISSIONSCRIPT05_LUA_000013, 603 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000014")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000014 )
	MisBeginCondition(LvCheck, ">", 20 )
	MisBeginCondition(NoMission, 603)
	MisBeginCondition(NoRecord, 603)
	MisBeginAction(AddMission, 603)
	MisBeginAction(AddTrigger, 6031, TE_GETITEM, 4432, 5 )
	MisCancelAction(ClearMission, 603)

	MisNeed(MIS_NEED_ITEM, 4432, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000015 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000015")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000015)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000016 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000016")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000016)
	MisResultCondition(NoRecord, 603)
	MisResultCondition(HasMission, 603)
	MisResultCondition(HasItem, 4432, 5)
	MisResultAction(TakeItem, 4432, 5 )
	MisResultAction(ClearMission, 603)
	MisResultAction(SetRecord, 603)
	MisResultAction(AddExp, 1000, 1000)
	MisResultAction(AddMoney,571,571)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4432 )	
	TriggerAction( 1, AddNextFlag, 603, 10, 5 )
	RegCurTrigger( 6031 )

-----------------------------------¼éÕ©µÄÃ¨Í·Ó¥
	MISSCRIPT_MISSIONSCRIPT05_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000017")
	DefineMission( 604, MISSCRIPT_MISSIONSCRIPT05_LUA_000017, 604 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000018")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000018 )
	MisBeginCondition(LvCheck, ">", 21 )
	MisBeginCondition(NoMission, 604)
	MisBeginCondition(NoRecord, 604)
	MisBeginAction(AddMission, 604)
	MisBeginAction(AddTrigger, 6041, TE_GETITEM, 4086, 1 )
	MisCancelAction(ClearMission, 604)

	MisNeed(MIS_NEED_ITEM, 4086, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000019")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000019)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000020 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000020")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000020)
	MisResultCondition(NoRecord, 604)
	MisResultCondition(HasMission, 604)
	MisResultCondition(HasItem, 4086, 1)
	MisResultAction(TakeItem, 4086, 1 )
	MisResultAction(ClearMission, 604)
	MisResultAction(SetRecord, 604)
	MisResultAction(AddExp, 1100, 1100)
	MisResultAction(AddMoney,300,300)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4086 )	
	TriggerAction( 1, AddNextFlag, 604, 10, 1 )
	RegCurTrigger( 6041 )

-----------------------------------¿¾ÖíÎ²µÄÓÕ»ó
	MISSCRIPT_MISSIONSCRIPT05_LUA_000021 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000021")
	DefineMission( 605, MISSCRIPT_MISSIONSCRIPT05_LUA_000021, 605 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000022")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000022 )
	MisBeginCondition(LvCheck, ">", 22 )
	MisBeginCondition(NoMission, 605)
	MisBeginCondition(NoRecord, 605)
	MisBeginAction(AddMission, 605)
	MisBeginAction(AddTrigger, 6051, TE_GETITEM, 4433, 5 )
	MisCancelAction(ClearMission, 605)

	MisNeed(MIS_NEED_ITEM, 4433, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000023")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000023)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000024 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000024")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000024)
	MisResultCondition(NoRecord, 605)
	MisResultCondition(HasMission, 605)
	MisResultCondition(HasItem, 4433, 5)
	MisResultAction(TakeItem, 4433, 5 )
	MisResultAction(ClearMission, 605)
	MisResultAction(SetRecord, 605)
	MisResultAction(AddExp, 1300, 1300)
	MisResultAction(AddMoney,632,632)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4433 )	
	TriggerAction( 1, AddNextFlag, 605, 10, 5 )
	RegCurTrigger( 6051 )

-----------------------------------¼ýºÀÖíµÄ·´¿¹
	MISSCRIPT_MISSIONSCRIPT05_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000025")
	DefineMission( 606, MISSCRIPT_MISSIONSCRIPT05_LUA_000025, 606 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000026 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000026")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000026 )
	MisBeginCondition(LvCheck, ">", 22 )
	MisBeginCondition(HasRecord, 605)
	MisBeginCondition(NoMission, 606)
	MisBeginCondition(NoRecord, 606)
	MisBeginAction(AddMission, 606)
	MisBeginAction(AddTrigger, 6061, TE_KILL, 264, 10 )
	MisCancelAction(ClearMission, 606)

	MisNeed(MIS_NEED_KILL, 264, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000027")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000027)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000028")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000028)
	MisResultCondition(NoRecord, 606)
	MisResultCondition(HasMission, 606)
	MisResultCondition(HasFlag, 606, 19 )
	MisResultAction(ClearMission, 606)
	MisResultAction(SetRecord, 606)
	MisCancelAction(ClearMission, 607)
	MisResultAction(AddExp, 1300, 1300)
	MisResultAction(AddMoney,316,316)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 264 )	
	TriggerAction( 1, AddNextFlag, 606, 10, 10 )
	RegCurTrigger( 6061 )

-----------------------------------³ý³ôÐÐ¶¯
	MISSCRIPT_MISSIONSCRIPT05_LUA_000029 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000029")
	DefineMission( 607, MISSCRIPT_MISSIONSCRIPT05_LUA_000029, 607 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000030 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000030")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000030 )
	MisBeginCondition(HasRecord, 608)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 607)
	MisBeginCondition(NoRecord, 607)
	MisBeginAction(AddMission, 607)
	MisBeginAction(AddTrigger, 6071, TE_KILL, 295, 10 )
	MisCancelAction(ClearMission, 607)

	MisNeed(MIS_NEED_KILL, 295, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000031")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000031)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000032 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000032")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000032)
	MisResultCondition(NoRecord, 607)
	MisResultCondition(HasMission, 607)
	MisResultCondition(HasFlag, 607, 19 )
	MisResultAction(ClearMission, 607)
	MisResultAction(SetRecord, 607)
	MisResultAction(AddExp, 1500, 1500)
	MisResultAction(AddMoney,332,332)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 295 )	
	TriggerAction( 1, AddNextFlag, 607, 10, 10 )
	RegCurTrigger( 6071 )

-----------------------------------ÆæÌØÏãÄÒ
	HELP_MONSTERHELP_LUA_001232 = GetResString("HELP_MONSTERHELP_LUA_001232")
	DefineMission( 608, HELP_MONSTERHELP_LUA_001232, 608 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000033 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000033")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000033 )
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 608)
	MisBeginCondition(NoRecord, 608)
	MisBeginAction(AddMission, 608)
	MisBeginAction(AddTrigger, 6081, TE_GETITEM, 4460, 5 )
	MisCancelAction(ClearMission, 608)

	MisNeed(MIS_NEED_ITEM, 4460, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000034 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000034")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000034)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000035 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000035")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000035)
	MisResultCondition(NoRecord, 608)
	MisResultCondition(HasMission, 608)
	MisResultCondition(HasItem, 4460, 5)
	MisResultAction(TakeItem, 4460, 5 )
	MisResultAction(ClearMission, 608)
	MisResultAction(SetRecord, 608)
	MisResultAction(AddExp, 1500, 1500)
	MisResultAction(AddMoney,664,664)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4460 )	
	TriggerAction( 1, AddNextFlag, 608, 10, 5 )
	RegCurTrigger( 6081 )

-----------------------------------¶ªÊ§µÄ½ð±Ò
	MISSCRIPT_MISSIONSCRIPT05_LUA_000036 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000036")
	DefineMission( 609, MISSCRIPT_MISSIONSCRIPT05_LUA_000036, 609 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000037")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000037 )
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 609)
	MisBeginCondition(NoRecord, 609)
	MisBeginAction(AddMission, 609)
	MisBeginAction(AddTrigger, 6091, TE_GETITEM, 4087, 1 )
	MisCancelAction(ClearMission, 609)

	MisNeed(MIS_NEED_ITEM, 4087, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000038")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000038)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000039 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000039")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000039)
	MisResultCondition(NoRecord, 609)
	MisResultCondition(HasMission, 609)
	MisResultCondition(HasItem, 4087, 1)
	MisResultAction(TakeItem, 4087, 1 )
	MisResultAction(ClearMission, 609)
	MisResultAction(SetRecord, 609)
	MisResultAction(AddExp, 1800, 1800)
	MisResultAction(AddMoney,1394,1394)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4087 )	
	TriggerAction( 1, AddNextFlag, 609, 10, 1 )
	RegCurTrigger( 6091 )


-----------------------------------¿É¶ñµÄÉ½Ôô
	MISSCRIPT_MISSIONSCRIPT05_LUA_000040 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000040")
	DefineMission( 610, MISSCRIPT_MISSIONSCRIPT05_LUA_000040, 610 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000041 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000041")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000041 )
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 610)
	MisBeginCondition(NoRecord, 610)
	MisBeginAction(AddMission, 610)
	MisBeginAction(AddTrigger, 6101, TE_KILL, 93, 10 )
	MisCancelAction(ClearMission, 610)

	MisNeed(MIS_NEED_KILL, 93, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000042")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000042)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000043 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000043")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000043)
	MisResultCondition(NoRecord, 610)
	MisResultCondition(HasMission, 610)
	MisResultCondition(HasFlag, 610, 19 )
	MisResultAction(ClearMission, 610)
	MisResultAction(SetRecord, 610)
	MisResultAction(AddExp, 1800, 1800)
	MisResultAction(AddMoney,348,348)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 93 )	
	TriggerAction( 1, AddNextFlag, 610, 10, 10 )
	RegCurTrigger( 6101 )


-----------------------------------Ñýæ¬ÂüÍÓÂÞ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000044 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000044")
	DefineMission( 611, MISSCRIPT_MISSIONSCRIPT05_LUA_000044, 611 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000045")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000045 )
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 611)
	MisBeginCondition(NoRecord, 611)
	MisBeginAction(AddMission, 611)
	MisBeginAction(AddTrigger, 6111, TE_GETITEM, 4088, 2 )
	MisCancelAction(ClearMission, 611)

	MisNeed(MIS_NEED_ITEM, 4088, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000046")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000046)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000047")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000047)
	MisResultCondition(NoRecord, 611)
	MisResultCondition(HasMission, 611)
	MisResultCondition(HasItem, 4088, 2)
	MisResultAction(TakeItem, 4088, 2 )
	MisResultAction(ClearMission, 611)
	MisResultAction(SetRecord, 611)
	MisResultAction(AddExp, 2000, 2000)
	MisResultAction(AddMoney,730,730)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4088 )	
	TriggerAction( 1, AddNextFlag, 611, 10, 2 )
	RegCurTrigger( 6111 )

-----------------------------------²ù³ýÑý»¨
	MISSCRIPT_MISSIONSCRIPT05_LUA_000048 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000048")
	DefineMission( 612, MISSCRIPT_MISSIONSCRIPT05_LUA_000048, 612 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000049 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000049")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000049 )
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 612)
	MisBeginCondition(NoRecord, 612)
	MisBeginAction(AddMission, 612)
	MisBeginAction(AddTrigger, 6121, TE_KILL, 85, 20 )
	MisCancelAction(ClearMission, 612)

	MisNeed(MIS_NEED_KILL, 85, 20, 10, 20)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000050")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000050)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000051")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000051)
	MisResultCondition(NoRecord, 612)
	MisResultCondition(HasMission, 612)
	MisResultCondition(HasFlag, 612, 29 )
	MisResultAction(ClearMission, 612)
	MisResultAction(SetRecord, 612)
	MisResultAction(AddExp, 2000, 2000)
	MisResultAction(AddMoney,365,365)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 85 )	
	TriggerAction( 1, AddNextFlag, 612, 10, 20 )
	RegCurTrigger( 6121 )


-----------------------------------±ÈÎä´óÈü
	MISSCRIPT_MISSIONSCRIPT05_LUA_000052 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000052")
	DefineMission( 613, MISSCRIPT_MISSIONSCRIPT05_LUA_000052, 613 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000053 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000053")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000053 )
	MisBeginCondition(HasRecord, 614 )
	MisBeginCondition(LvCheck, ">", 25 )
	MisBeginCondition(NoMission, 613)
	MisBeginCondition(NoRecord, 613)
	MisBeginAction(AddMission, 613)
	MisBeginAction(AddTrigger, 6131, TE_KILL, 76, 10 )
	MisCancelAction(ClearMission, 613)

	MisNeed(MIS_NEED_KILL, 76, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000054 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000054")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000054)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000055")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000055)
	MisResultCondition(NoRecord, 613)
	MisResultCondition(HasMission, 613)
	MisResultCondition(HasFlag, 613, 19 )
	MisResultAction(ClearMission, 613)
	MisResultAction(SetRecord, 613)
	MisResultAction(AddExp, 2300, 2300)
	MisResultAction(AddMoney,382,382)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 76 )	
	TriggerAction( 1, AddNextFlag, 613, 10, 10 )
	RegCurTrigger( 6131 )

-----------------------------------È­»÷ÊÖÌ×
	HELP_MONSTERHELP_LUA_001231 = GetResString("HELP_MONSTERHELP_LUA_001231")
	DefineMission( 614, HELP_MONSTERHELP_LUA_001231, 614 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000056 )
	MisBeginCondition(LvCheck, ">", 25 )
	MisBeginCondition(NoMission, 614)
	MisBeginCondition(NoRecord, 614)
	MisBeginAction(AddMission, 614)
	MisBeginAction(AddTrigger, 6141, TE_GETITEM, 4435, 1 )
	MisCancelAction(ClearMission, 614)

	MisNeed(MIS_NEED_ITEM, 4435, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000057")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000057)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000058")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000058)
	MisResultCondition(NoRecord, 614)
	MisResultCondition(HasMission, 614)
	MisResultCondition(HasItem, 4435, 1)
	MisResultAction(TakeItem, 4435, 1 )
	MisResultAction(ClearMission, 614)
	MisResultAction(SetRecord, 614)
	MisResultAction(AddExp, 2300, 2300)
	MisResultAction(AddMoney,382,382)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4435 )	
	TriggerAction( 1, AddNextFlag, 614, 10, 1 )
	RegCurTrigger( 6141 )

-----------------------------------²ÝÔ­¹êµÄÔÖÄÑ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000059")
	DefineMission( 615, MISSCRIPT_MISSIONSCRIPT05_LUA_000059, 615 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000060")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000060 )
	MisBeginCondition(LvCheck, ">", 26 )
	MisBeginCondition(NoMission, 615)
	MisBeginCondition(NoRecord, 615)
	MisBeginAction(AddMission, 615)
	MisBeginAction(AddTrigger, 6151, TE_KILL, 135, 10 )
	MisCancelAction(ClearMission, 615)

	MisNeed(MIS_NEED_KILL, 135, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000061 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000061")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000061)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000062 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000062")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000062)
	MisResultCondition(NoRecord, 615)
	MisResultCondition(HasMission, 615)
	MisResultCondition(HasFlag, 615, 19 )
	MisResultAction(ClearMission, 615)
	MisResultAction(SetRecord, 615)
	MisResultAction(AddExp, 2600, 2600)
	MisResultAction(AddMoney,400,400)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 135 )	
	TriggerAction( 1, AddNextFlag, 615, 10, 10 )
	RegCurTrigger( 6151 )

-----------------------------------ÍµÇÔ¹êÂÑ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000063 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000063")
	DefineMission( 616, MISSCRIPT_MISSIONSCRIPT05_LUA_000063, 616 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000064 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000064")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000064 )
	MisBeginCondition(LvCheck, ">", 26 )
	MisBeginCondition(NoMission, 616)
	MisBeginCondition(NoRecord, 616)
	MisBeginAction(AddMission, 616)
	MisBeginAction(AddTrigger, 6161, TE_GETITEM, 4089, 1 )
	MisCancelAction(ClearMission, 616)

	MisNeed(MIS_NEED_ITEM, 4089, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000065 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000065")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000065)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000066 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000066")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000066)
	MisResultCondition(NoRecord, 616)
	MisResultCondition(HasMission, 616)
	MisResultCondition(HasItem, 4089, 1)
	MisResultAction(TakeItem, 4089, 1 )
	MisResultAction(ClearMission, 616)
	MisResultAction(SetRecord, 616)
	MisResultAction(AddExp, 2600, 2600)
	MisResultAction(AddMoney,400,400)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4089 )	
	TriggerAction( 1, AddNextFlag, 616, 10, 1 )
	RegCurTrigger( 6161 )

-----------------------------------×ßË½¹ê¼×
	MISSCRIPT_MISSIONSCRIPT05_LUA_000067 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000067")
	DefineMission( 617, MISSCRIPT_MISSIONSCRIPT05_LUA_000067, 617 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000068 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000068")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000068 )
	MisBeginCondition(HasRecord, 616)
	MisBeginCondition(LvCheck, ">", 27 )
	MisBeginCondition(NoMission, 617)
	MisBeginCondition(NoRecord, 617)
	MisBeginAction(AddMission, 617)
	MisBeginAction(AddTrigger, 6171, TE_GETITEM, 4465, 5 )
	MisCancelAction(ClearMission, 617)

	MisNeed(MIS_NEED_ITEM, 4465, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000069 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000069")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000069)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000070 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000070")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000070)
	MisResultCondition(NoRecord, 617)
	MisResultCondition(HasMission, 617)
	MisResultCondition(HasItem, 4465, 5)
	MisResultAction(TakeItem, 4465, 5 )
	MisResultAction(ClearMission, 617)
	MisResultAction(SetRecord, 617)
	MisResultAction(AddExp, 3000, 3000)
	MisResultAction(AddMoney,835,835)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4465 )	
	TriggerAction( 1, AddNextFlag, 617, 10, 5 )
	RegCurTrigger( 6171 )

-----------------------------------Ð°¶ñµÄ×çÖä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000071 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000071")
	DefineMission( 618, MISSCRIPT_MISSIONSCRIPT05_LUA_000071, 618 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000072")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000072)
	MisBeginCondition(LvCheck, ">", 27 )
	MisBeginCondition(NoMission, 618)
	MisBeginCondition(NoRecord, 618)
	MisBeginAction(AddMission, 618)
	MisBeginAction(AddTrigger, 6181, TE_GETITEM, 4443, 10 )
	MisCancelAction(ClearMission, 618)

	MisNeed(MIS_NEED_ITEM, 4443, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000073 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000073")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000073)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000074 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000074")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000074)
	MisResultCondition(NoRecord, 618)
	MisResultCondition(HasMission, 618)
	MisResultCondition(HasItem, 4443, 10)
	MisResultAction(TakeItem, 4443, 10 )
	MisResultAction(ClearMission, 618)
	MisResultAction(SetRecord, 618)
	MisResultAction(AddExp, 3000, 3000)
	MisResultAction(AddMoney,835,835)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4443 )	
	TriggerAction( 1, AddNextFlag, 618, 10, 10 )
	RegCurTrigger( 6181 )

-----------------------------------Ò°Öí¶ÀÁ¢ÈÕ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000075 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000075")
	DefineMission( 619, MISSCRIPT_MISSIONSCRIPT05_LUA_000075, 619 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000076 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000076")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000076)
	MisBeginCondition(HasRecord, 618)
	MisBeginCondition(LvCheck, ">", 28 )
	MisBeginCondition(NoMission, 619)
	MisBeginCondition(NoMission, 620)
	MisBeginCondition(NoRecord, 619)
	MisBeginAction(AddMission, 619)
	MisBeginAction(AddTrigger, 6191, TE_KILL, 64, 10 )
	MisCancelAction(ClearMission, 619)
 
	MisNeed(MIS_NEED_KILL, 64, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000077 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000077")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000077)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000078")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000078)
	MisResultCondition(NoRecord, 619)
	MisResultCondition(HasMission, 619)
	MisResultCondition(HasFlag, 619, 19 )
	MisResultAction(ClearMission, 619)
	MisResultAction(SetRecord, 619)
	MisResultAction(AddExp, 3400, 3400)
	MisResultAction(AddMoney,424,424)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6709,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 64 )	
	TriggerAction( 1, AddNextFlag, 619, 10, 10 )
	RegCurTrigger( 6191 )

-----------------------------------ÌôÕ½Ò°Öí
	MISSCRIPT_MISSIONSCRIPT05_LUA_000079 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000079")
	DefineMission( 620, MISSCRIPT_MISSIONSCRIPT05_LUA_000079, 620 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000080 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000080")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000080)
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(NoMission, 620)
	MisBeginCondition(NoMission, 619)
	MisBeginCondition(NoRecord, 620)
	MisBeginAction(AddMission, 620)
	MisBeginAction(AddTrigger, 6201, TE_KILL, 64, 5 )
	MisCancelAction(ClearMission, 620)

	MisNeed(MIS_NEED_KILL, 64, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000081 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000081")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000081)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000082 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000082")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000082)
	MisResultCondition(NoRecord, 620)
	MisResultCondition(HasMission, 620)
	MisResultCondition(HasFlag, 620, 14 )
	MisResultAction(ClearMission, 620)
	MisResultAction(SetRecord, 620)
	MisResultAction(AddExp, 3400, 3400)
	MisResultAction(AddMoney,424,424)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 64 )	
	TriggerAction( 1, AddNextFlag, 620, 10, 5 )
	RegCurTrigger( 6201 )

-----------------------------------Õä¹óµÄÒ©²Ý
	GARNER_GARNERENTITY_LUA_000010 = GetResString("GARNER_GARNERENTITY_LUA_000010")
	DefineMission( 621, GARNER_GARNERENTITY_LUA_000010, 621 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000083 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000083")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000083)
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(NoMission, 621)
	MisBeginCondition(NoRecord, 621)
	MisBeginAction(AddMission, 621)
	MisBeginAction(AddTrigger, 6211, TE_GETITEM, 4090, 1 )
	MisCancelAction(ClearMission, 621)

	MisNeed(MIS_NEED_ITEM, 4090, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000084 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000084")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000084)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000085 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000085")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000085)
	MisResultCondition(NoRecord, 621)
	MisResultCondition(HasMission, 621)
	MisResultCondition(HasItem, 4090, 1)
	MisResultAction(TakeItem, 4090, 1 )
	MisResultAction(ClearMission, 621)
	MisResultAction(SetRecord, 621)
	MisResultAction(AddExp, 3400, 3400)
	MisResultAction(AddMoney,424,424)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4090 )	
	TriggerAction( 1, AddNextFlag, 621, 10, 1 )
	RegCurTrigger( 6211 )

-----------------------------------²ÝÔ­Â¹µÄÃØÃÜ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000086 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000086")
	DefineMission( 622, MISSCRIPT_MISSIONSCRIPT05_LUA_000086, 622 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000087")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000087)
	MisBeginCondition(LvCheck, ">", 30 )
	MisBeginCondition(NoMission, 622)
	MisBeginCondition(NoRecord, 622)
	MisBeginAction(AddMission, 622)
	MisBeginAction(AddTrigger, 6221, TE_GETITEM, 4372, 5 )
	MisCancelAction(ClearMission, 622)

	MisNeed(MIS_NEED_ITEM, 4372, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000088")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000088)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000089")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000089)
	MisResultCondition(NoRecord, 622)
	MisResultCondition(HasMission, 622)
	MisResultCondition(HasItem, 4372, 5)
	MisResultAction(TakeItem, 4372, 5 )
	MisResultAction(ClearMission, 622)
	MisResultAction(SetRecord, 622)
	MisResultAction(AddExp, 3800, 3800)
	MisResultAction(AddMoney,863,863)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4372 )	
	TriggerAction( 1, AddNextFlag, 622, 10, 5 )
	RegCurTrigger( 6221 )

-----------------------------------Â¹Æ¤´óÒÂ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000090")
	DefineMission( 623, MISSCRIPT_MISSIONSCRIPT05_LUA_000090, 623 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000091 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000091")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000091)
	MisBeginCondition(LvCheck, ">", 30 )
	MisBeginCondition(NoMission, 623)
	MisBeginCondition(NoRecord, 623)
	MisBeginAction(AddMission, 623)
	MisBeginAction(AddTrigger, 6231, TE_GETITEM, 4091, 5 )
	MisCancelAction(ClearMission, 623)

	MisNeed(MIS_NEED_ITEM, 4091, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000092 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000092")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000092)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000093")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000093)
	MisResultCondition(NoRecord, 623)
	MisResultCondition(HasMission, 623)
	MisResultCondition(HasItem, 4091, 5)
	MisResultAction(TakeItem, 4091, 5 )
	MisResultAction(ClearMission, 623)
	MisResultAction(SetRecord, 623)
	MisResultAction(AddExp, 3800, 3800)
	MisResultAction(AddMoney,863,863)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4091 )	
	TriggerAction( 1, AddNextFlag, 623, 10, 5 )
	RegCurTrigger( 6231 )

-----------------------------------Ñ©°×Ã¨Í·Ó¥
	HELP_MONSTERHELP_LUA_000193 = GetResString("HELP_MONSTERHELP_LUA_000193")
	DefineMission( 624, HELP_MONSTERHELP_LUA_000193, 624 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000094 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000094")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000094)
	MisBeginCondition(LvCheck, ">", 31 )
	MisBeginCondition(NoMission, 624)
	MisBeginCondition(NoRecord, 624)
	MisBeginAction(AddMission, 624)
	MisBeginAction(AddTrigger, 6241, TE_KILL, 225, 5 )
	MisCancelAction(ClearMission, 624)

	MisNeed(MIS_NEED_KILL, 225, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000095 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000095")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000095)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000096")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000096)
	MisResultCondition(NoRecord, 624)
	MisResultCondition(HasMission, 624)
	MisResultCondition(HasFlag, 624, 14 )
	MisResultAction(ClearMission, 624)
	MisResultAction(SetRecord, 624)
	MisResultAction(AddExp, 4300, 4300)
	MisResultAction(AddMoney,438,438)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 225 )	
	TriggerAction( 1, AddNextFlag, 624, 10, 5 )
	RegCurTrigger( 6241 )

-----------------------------------±¨¸´ÐÐÎª
	MISSCRIPT_MISSIONSCRIPT05_LUA_000097 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000097")
	DefineMission( 625, MISSCRIPT_MISSIONSCRIPT05_LUA_000097, 625 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000098")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000098)
	MisBeginCondition(LvCheck, ">", 31 )
	MisBeginCondition(HasRecord, 621)
	MisBeginCondition(NoMission, 625)
	MisBeginCondition(NoRecord, 625)
	MisBeginAction(AddMission, 625)
	MisBeginAction(AddTrigger, 6251, TE_GETITEM, 4451, 5 )
	MisCancelAction(ClearMission, 625)

	MisNeed(MIS_NEED_ITEM, 4451, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000099 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000099")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000099)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000100 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000100")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000100)
	MisResultCondition(NoRecord, 625)
	MisResultCondition(HasMission, 625)
	MisResultCondition(HasItem, 4451, 5)
	MisResultAction(TakeItem, 4451, 5 )
	MisResultAction(ClearMission, 625)
	MisResultAction(SetRecord, 625)
	MisResultAction(AddExp, 4300, 4300)
	MisResultAction(AddMoney,877,877)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4451 )	
	TriggerAction( 1, AddNextFlag, 625, 10, 5 )
	RegCurTrigger( 6251 )

-----------------------------------ÇýÖð²ÝÔ­ÀÇ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000101 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000101")
	DefineMission( 626, MISSCRIPT_MISSIONSCRIPT05_LUA_000101, 626 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000102 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000102")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000102)
	MisBeginCondition(LvCheck, ">", 32 )
	MisBeginCondition(NoMission, 626)
	MisBeginCondition(NoRecord, 626)
	MisBeginAction(AddMission, 626)
	MisBeginAction(AddTrigger, 6261, TE_KILL, 136, 5 )
	MisCancelAction(ClearMission, 626)

	MisNeed(MIS_NEED_KILL, 136, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000103 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000103")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000103)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000104 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000104")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000104)
	MisResultCondition(NoRecord, 626)
	MisResultCondition(HasMission, 626)
	MisResultCondition(HasFlag, 626, 14 )
	MisResultAction(ClearMission, 626)
	MisResultAction(SetRecord, 626)
	MisResultAction(AddExp, 4800, 4800)
	MisResultAction(AddMoney,446,446)
		MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 136 )	
	TriggerAction( 1, AddNextFlag, 626, 10, 5 )
	RegCurTrigger( 6261 )


-----------------------------------²ÐÈÌµÄÍÀÉ±
	MISSCRIPT_MISSIONSCRIPT05_LUA_000105 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000105")
	DefineMission( 627, MISSCRIPT_MISSIONSCRIPT05_LUA_000105, 627 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000106 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000106")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000106)
	MisBeginCondition(HasRecord, 623)
	MisBeginCondition(LvCheck, ">", 32 )
	MisBeginCondition(NoMission, 627)
	MisBeginCondition(NoRecord, 627)
	MisBeginAction(AddMission, 627)
	MisBeginAction(AddTrigger, 6271, TE_GETITEM, 4469, 5 )
	MisCancelAction(ClearMission, 627)

	MisNeed(MIS_NEED_ITEM, 4469, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000107")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000107)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000108 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000108")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000108)
	MisResultCondition(NoRecord, 627)
	MisResultCondition(HasMission, 627)
	MisResultCondition(HasItem, 4469, 5)
	MisResultAction(TakeItem, 4469, 5 )
	MisResultAction(ClearMission, 627)
	MisResultAction(SetRecord, 627)
	MisResultAction(AddExp, 4800, 4800)
	MisResultAction(AddMoney,892,892)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4469 )	
	TriggerAction( 1, AddNextFlag, 627, 10, 5 )
	RegCurTrigger( 6271 )

-----------------------------------ÈÇÊÂÉú·ÇµÄ´üÊó
	MISSCRIPT_MISSIONSCRIPT05_LUA_000109 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000109")
	DefineMission( 628, MISSCRIPT_MISSIONSCRIPT05_LUA_000109, 628 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000110 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000110")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000110)
	MisBeginCondition(LvCheck, ">", 33 )
	MisBeginCondition(NoMission, 628)
	MisBeginCondition(NoRecord, 628)
	MisBeginAction(AddMission, 628)
	MisBeginAction(AddTrigger, 6281, TE_KILL, 80, 5 )
	MisCancelAction(ClearMission, 628)

	MisNeed(MIS_NEED_KILL, 80, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000111 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000111")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000111)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000112 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000112")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000112)
	MisResultCondition(NoRecord, 628)
	MisResultCondition(HasMission, 628)
	MisResultCondition(HasFlag, 628, 14 )
	MisResultAction(ClearMission, 628)
	MisResultAction(SetRecord, 628)
	MisResultAction(AddExp, 5400, 5400)
	MisResultAction(AddMoney,453,453)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 80 )	
	TriggerAction( 1, AddNextFlag, 628, 10, 5 )
	RegCurTrigger( 6281 )

-----------------------------------ÆíÔËÄ§·¨Ê¯
	GARNER_GARNERENTITY_LUA_000005 = GetResString("GARNER_GARNERENTITY_LUA_000005")
	DefineMission( 629, GARNER_GARNERENTITY_LUA_000005, 629 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000113 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000113")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000113)
	MisBeginCondition(LvCheck, ">", 33 )
	MisBeginCondition(NoMission, 629)
	MisBeginCondition(NoRecord, 629)
	MisBeginAction(AddMission, 629)
	MisBeginAction(AddTrigger, 6291, TE_GETITEM, 4092, 1 )
	MisCancelAction(ClearMission, 629)

	MisNeed(MIS_NEED_ITEM, 4092, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000114")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000114)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000115 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000115")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000115)
	MisResultCondition(NoRecord, 629)
	MisResultCondition(HasMission, 629)
	MisResultCondition(HasItem, 4092, 1)
	MisResultAction(TakeItem, 4092, 1 )
	MisResultAction(ClearMission, 629)
	MisResultAction(SetRecord, 629)
	MisResultAction(AddExp, 5400, 5400)
	MisResultAction(AddMoney,453,453)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4092 )	
	TriggerAction( 1, AddNextFlag, 629, 10, 1 )
	RegCurTrigger( 6291 )

-----------------------------------Ì½¾¿³Ù¶ÛÎÏÅ£
	MISSCRIPT_MISSIONSCRIPT05_LUA_000116 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000116")
	DefineMission( 630, MISSCRIPT_MISSIONSCRIPT05_LUA_000116, 630 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000117 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000117")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000117)
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(NoMission, 630)
	MisBeginCondition(NoRecord, 630)
	MisBeginAction(AddMission, 630)
	MisBeginAction(AddTrigger, 6301, TE_GETITEM, 4473, 5 )
	MisCancelAction(ClearMission, 630)

	MisNeed(MIS_NEED_ITEM, 4473, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000118 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000118")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000118)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000119 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000119")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000119)
	MisResultCondition(NoRecord, 630)
	MisResultCondition(HasMission, 630)
	MisResultCondition(HasItem, 4473, 5)
	MisResultAction(TakeItem, 4473, 5 )
	MisResultAction(ClearMission, 630)
	MisResultAction(SetRecord, 630)
	MisResultAction(AddExp, 6100, 6100)
	MisResultAction(AddMoney,923,923)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4473 )	
	TriggerAction( 1, AddNextFlag, 630, 10, 5 )
	RegCurTrigger( 6301 )

-----------------------------------ÂýÍÌÍÌµÄ³Ù¶ÛÎÏÅ£
	MISSCRIPT_MISSIONSCRIPT05_LUA_000120 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000120")
	DefineMission( 631, MISSCRIPT_MISSIONSCRIPT05_LUA_000120, 631 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000121")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000121)
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(NoMission, 631)
	MisBeginCondition(NoRecord, 631)
	MisBeginAction(AddMission, 631)
	MisBeginAction(AddTrigger, 6311, TE_KILL, 127, 10 )
	MisCancelAction(ClearMission, 631)

	MisNeed(MIS_NEED_KILL, 127, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000122 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000122")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000122)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000062 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000062")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000062)
	MisResultCondition(NoRecord, 631)
	MisResultCondition(HasMission, 631)
	MisResultCondition(HasFlag, 631, 19 )
	MisResultAction(ClearMission, 631)
	MisResultAction(SetRecord, 631)
	MisResultAction(AddExp, 6100, 6100)
	MisResultAction(AddMoney,461,461)
		MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 127 )	
	TriggerAction( 1, AddNextFlag, 631, 10, 10 )
	RegCurTrigger( 6311 )


-----------------------------------¶éÂäÖ®µÀ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000123 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000123")
	DefineMission( 632, MISSCRIPT_MISSIONSCRIPT05_LUA_000123, 632 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000124 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000124")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000124)
	MisBeginCondition(LvCheck, ">", 35 )
	MisBeginCondition(NoMission, 632)
	MisBeginCondition(NoRecord, 632)
	MisBeginAction(AddMission, 632)
	MisBeginAction(AddTrigger, 6321, TE_GETITEM, 4450, 5 )
	MisCancelAction(ClearMission, 632)

	MisNeed(MIS_NEED_ITEM, 4450, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000125 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000125")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000125)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000126 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000126")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000126)
	MisResultCondition(NoRecord, 632)
	MisResultCondition(HasMission, 632)
	MisResultCondition(HasItem, 4450, 5)
	MisResultAction(TakeItem, 4450, 5 )
	MisResultAction(ClearMission, 632)
	MisResultAction(SetRecord, 632)
	MisResultAction(AddExp, 6800, 6800)
	MisResultAction(AddMoney,939,939)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4450 )	
	TriggerAction( 1, AddNextFlag, 632, 10, 5 )
	RegCurTrigger( 6321 )

-----------------------------------´ÌÈÐ´äÄñµÄÍì¸è
	MISSCRIPT_MISSIONSCRIPT05_LUA_000127 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000127")
	DefineMission( 633, MISSCRIPT_MISSIONSCRIPT05_LUA_000127, 633 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000128 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000128")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000128)
	MisBeginCondition(LvCheck, ">", 36 )
	MisBeginCondition(NoMission, 633)
	MisBeginCondition(NoRecord, 633)
	MisBeginAction(AddMission, 633)
	MisBeginAction(AddTrigger, 6331, TE_KILL, 128, 10 )
	MisCancelAction(ClearMission, 633)

	MisNeed(MIS_NEED_KILL, 128, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000129 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000129")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000129)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000130 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000130")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000130)
	MisResultCondition(NoRecord, 633)
	MisResultCondition(HasMission, 633)
	MisResultCondition(HasFlag, 633, 19 )
	MisResultAction(ClearMission, 633)
	MisResultAction(SetRecord, 633)
	MisResultAction(AddExp, 7600, 7600)
	MisResultAction(AddMoney,477,477)
			MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 128 )	
	TriggerAction( 1, AddNextFlag, 633, 10, 10 )
	RegCurTrigger( 6331 )

-----------------------------------Í»·¢ÆæÏëµÄ¶·Åñ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000131")
	DefineMission( 634, MISSCRIPT_MISSIONSCRIPT05_LUA_000131, 634 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000132 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000132")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000132)
	MisBeginCondition(LvCheck, ">", 36 )
	MisBeginCondition(NoMission, 634)
	MisBeginCondition(NoRecord, 634)
	MisBeginAction(AddMission, 634)
	MisBeginAction(AddTrigger, 6341, TE_GETITEM, 4472, 5 )
	MisCancelAction(ClearMission, 634)

	MisNeed(MIS_NEED_ITEM, 4472, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000133 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000133")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000133)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000134 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000134")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000134)
	MisResultCondition(NoRecord, 634)
	MisResultCondition(HasMission, 634)
	MisResultCondition(HasItem, 4472, 5)
	MisResultAction(TakeItem, 4472, 5 )
	MisResultAction(ClearMission, 634)
	MisResultAction(SetRecord, 634)
	MisResultAction(AddExp, 7600, 7600)
	MisResultAction(AddMoney,955,955)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4472 )	
	TriggerAction( 1, AddNextFlag, 634, 10, 5 )
	RegCurTrigger( 6341 )

-----------------------------------··Âô¼Ù»¯Ê¯
	MISSCRIPT_MISSIONSCRIPT05_LUA_000135 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000135")
	DefineMission( 635, MISSCRIPT_MISSIONSCRIPT05_LUA_000135, 635 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000136 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000136")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000136)
	MisBeginCondition(LvCheck, ">", 37 )
	MisBeginCondition(NoMission, 635)
	MisBeginCondition(NoRecord, 635)
	MisBeginAction(AddMission, 635)
	MisBeginAction(AddTrigger, 6351, TE_GETITEM, 4093, 1 )
	MisCancelAction(ClearMission, 635)

	MisNeed(MIS_NEED_ITEM, 4093, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000137")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000137)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000138 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000138")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000138)
	MisResultCondition(NoRecord, 635)
	MisResultCondition(HasMission, 635)
	MisResultCondition(HasItem, 4093, 1)
	MisResultAction(TakeItem, 4093, 1 )
	MisResultAction(ClearMission, 635)
	MisResultAction(SetRecord, 635)
	MisResultAction(AddExp, 8500, 8500)
	MisResultAction(AddMoney,486,486)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4093 )	
	TriggerAction( 1, AddNextFlag, 635, 10, 1 )
	RegCurTrigger( 6351 )

-----------------------------------±ÌÂÌÌ¦Þº
	MISSCRIPT_MISSIONSCRIPT05_LUA_000139 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000139")
	DefineMission( 636, MISSCRIPT_MISSIONSCRIPT05_LUA_000139, 636 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000140")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000140)
	MisBeginCondition(LvCheck, ">", 38 )
	MisBeginCondition(NoMission, 636)
	MisBeginCondition(NoRecord, 636)
	MisBeginAction(AddMission, 636)
	MisBeginAction(AddTrigger, 6361, TE_GETITEM, 4094, 5 )
	MisCancelAction(ClearMission, 636)

	MisNeed(MIS_NEED_ITEM, 4094, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000141 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000141")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000141)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000142")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000142)
	MisResultCondition(NoRecord, 636)
	MisResultCondition(HasMission, 636)
	MisResultCondition(HasItem, 4094, 5)
	MisResultAction(TakeItem, 4094, 5 )
	MisResultAction(ClearMission, 636)
	MisResultAction(SetRecord, 636)
	MisResultAction(AddExp, 9500, 9500)
	MisResultAction(AddMoney,495,495)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4094 )	
	TriggerAction( 1, AddNextFlag, 636, 10, 5 )
	RegCurTrigger( 6361 )


-----------------------------------Ñ°ÕÒ¹â»¬µÄÊ¯Í·
	MISSCRIPT_MISSIONSCRIPT05_LUA_000143 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000143")
	DefineMission( 637, MISSCRIPT_MISSIONSCRIPT05_LUA_000143, 637 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000144 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000144")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000144)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(NoMission, 637)
	MisBeginCondition(NoRecord, 637)
	MisBeginAction(AddMission, 637)
	MisBeginAction(AddTrigger, 6371, TE_GETITEM, 4455, 5 )
	MisCancelAction(ClearMission, 637)

	MisNeed(MIS_NEED_ITEM, 4455, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000145 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000145")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000145)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000146")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000146)
	MisResultCondition(NoRecord, 637)
	MisResultCondition(HasMission, 637)
	MisResultCondition(HasItem, 4455, 5)
	MisResultAction(TakeItem, 4455, 5 )
	MisResultAction(ClearMission, 637)
	MisResultAction(SetRecord, 637)
	MisResultAction(AddExp, 10000, 10000)
	MisResultAction(AddMoney,1008,1008)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4455 )	
	TriggerAction( 1, AddNextFlag, 637, 10, 5 )
	RegCurTrigger( 6371 )



-----------------------------------¹Å¹ÖµÄÊÕ²Ø¼Ò
	MISSCRIPT_MISSIONSCRIPT05_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000147")
	DefineMission( 638, MISSCRIPT_MISSIONSCRIPT05_LUA_000147, 638 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000148 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000148")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000148)
	MisBeginCondition(LvCheck, ">", 9 )
	MisBeginCondition(NoMission, 638)
	MisBeginCondition(NoRecord, 638)
	MisBeginAction(AddMission, 638)
	MisBeginAction(AddTrigger, 6381, TE_GETITEM, 4415, 3 )
	MisCancelAction(ClearMission, 638)

	MisNeed(MIS_NEED_ITEM, 4415, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000149 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000149")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000149)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000150 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000150")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000150)
	MisResultCondition(NoRecord, 638)
	MisResultCondition(HasMission, 638)
	MisResultCondition(HasItem, 4415, 3)
	MisResultAction(TakeItem, 4415, 3 )
	MisResultAction(ClearMission, 638)
	MisResultAction(SetRecord, 638)
	MisResultAction(AddExp, 120, 120)
	MisResultAction(AddMoney,299,299)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4415 )	
	TriggerAction( 1, AddNextFlag, 638, 10, 3 )
	RegCurTrigger( 6381 )

-----------------------------------µ·¹íµÄÌøÌøòá
	MISSCRIPT_MISSIONSCRIPT05_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000151")
	DefineMission( 639, MISSCRIPT_MISSIONSCRIPT05_LUA_000151, 639 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000152")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000152)
	MisBeginCondition(LvCheck, ">", 9 )
	MisBeginCondition(NoMission, 639)
	MisBeginCondition(NoRecord, 639)
	MisBeginAction(AddMission, 639)
	MisBeginAction(AddTrigger, 6391, TE_KILL, 62, 10 )
	MisCancelAction(ClearMission, 639)

	MisNeed(MIS_NEED_KILL, 62, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000153 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000153")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000153)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000154 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000154")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000154)
	MisResultCondition(NoRecord, 639)
	MisResultCondition(HasMission, 639)
	MisResultCondition(HasFlag, 639, 19 )
	MisResultAction(ClearMission, 639)
	MisResultAction(SetRecord, 639)
	MisResultAction(AddExp, 120, 120)
	MisResultAction(AddMoney,149,149)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 62 )	
	TriggerAction( 1, AddNextFlag, 639, 10, 10 )
	RegCurTrigger( 6391 )


-----------------------------------ÌøÌøòáµÄ·ÖÃÚÎï
	MISSCRIPT_MISSIONSCRIPT05_LUA_000155 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000155")
	DefineMission( 640, MISSCRIPT_MISSIONSCRIPT05_LUA_000155, 640 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000156 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000156")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000156)
	MisBeginCondition(LvCheck, ">", 10 )
	MisBeginCondition(NoMission, 640)
	MisBeginCondition(NoRecord, 640)
	MisBeginAction(AddMission, 640)
	MisBeginAction(AddTrigger, 6401, TE_GETITEM, 4095, 3 )
	MisCancelAction(ClearMission, 640)

	MisNeed(MIS_NEED_ITEM, 4095, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000157 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000157")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000157)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000158 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000158")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000158)
	MisResultCondition(NoRecord, 640)
	MisResultCondition(HasMission, 640)
	MisResultCondition(HasItem, 4095, 3)
	MisResultAction(TakeItem, 4095, 3 )
	MisResultAction(ClearMission, 640)
	MisResultAction(SetRecord, 640)
	MisResultAction(AddExp, 150, 150)
	MisResultAction(AddMoney,318,318)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4095 )	
	TriggerAction( 1, AddNextFlag, 640, 10, 3 )
	RegCurTrigger( 6401 )


-----------------------------------ÇýÖðÐ¡ÀÇ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000159 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000159")
	DefineMission( 641, MISSCRIPT_MISSIONSCRIPT05_LUA_000159, 641 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000160 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000160")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000160)
	MisBeginCondition(LvCheck, ">", 10 )
	MisBeginCondition(NoMission, 641)
	MisBeginCondition(NoRecord, 641)
	MisBeginAction(AddMission, 641)
	MisBeginAction(AddTrigger, 6411, TE_KILL, 100, 10 )
	MisCancelAction(ClearMission, 641)

	MisNeed(MIS_NEED_KILL, 100, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000161 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000161")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000161)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000162 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000162")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000162)
	MisResultCondition(NoRecord, 641)
	MisResultCondition(HasMission, 641)
	MisResultCondition(HasFlag, 641, 19 )
	MisResultAction(ClearMission, 641)
	MisResultAction(SetRecord, 641)
	MisResultAction(AddExp, 150, 150)
	MisResultAction(AddMoney,159,159)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 100 )	
	TriggerAction( 1, AddNextFlag, 641, 10, 10 )
	RegCurTrigger( 6411 )

-----------------------------------ÍÀÉ±Ð¡ÀÇ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000163 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000163")
	DefineMission( 642, MISSCRIPT_MISSIONSCRIPT05_LUA_000163, 642 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000164 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000164")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000164)
	MisBeginCondition(LvCheck, ">", 11 )
	MisBeginCondition(NoMission, 642)
	MisBeginCondition(NoRecord, 642)
	MisBeginAction(AddMission, 642)
	MisBeginAction(AddTrigger, 6421, TE_GETITEM, 4096, 3 )
	MisCancelAction(ClearMission, 642)

	MisNeed(MIS_NEED_ITEM, 4096, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000165 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000165")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000165)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000166 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000166")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000166)
	MisResultCondition(NoRecord, 642)
	MisResultCondition(HasMission, 642)
	MisResultCondition(HasItem, 4096, 3)
	MisResultAction(TakeItem, 4096, 3 )
	MisResultAction(ClearMission, 642)
	MisResultAction(SetRecord, 642)
	MisResultAction(AddExp, 190, 190)
	MisResultAction(AddMoney,339,339)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4096 )	
	TriggerAction( 1, AddNextFlag, 642, 10, 3 )
	RegCurTrigger( 6421 )

-----------------------------------²ù³ýÉ±ÊÖÏÉÈËÕÆ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000167 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000167")
	DefineMission( 643, MISSCRIPT_MISSIONSCRIPT05_LUA_000167, 643 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000168 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000168")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000168)
	MisBeginCondition(LvCheck, ">", 12 )
	MisBeginCondition(NoMission, 643)
	MisBeginCondition(NoRecord, 643)
	MisBeginAction(AddMission, 643)
	MisBeginAction(AddTrigger, 6431, TE_KILL, 43, 10 )
	MisCancelAction(ClearMission, 643)

	MisNeed(MIS_NEED_KILL, 43, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000169 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000169")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000169)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000170 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000170")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000170)
	MisResultCondition(NoRecord, 643)
	MisResultCondition(HasMission, 643)
	MisResultCondition(HasFlag, 643, 19 )
	MisResultAction(ClearMission, 643)
	MisResultAction(SetRecord, 643)
	MisResultAction(AddExp, 240, 240)
	MisResultAction(AddMoney,180,180)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 43 )	
	TriggerAction( 1, AddNextFlag, 643, 10, 10 )
	RegCurTrigger( 6431 )



-----------------------------------Á¼Ò©¿à¿Ú
	MISSCRIPT_MISSIONSCRIPT05_LUA_000171 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000171")
	DefineMission( 644, MISSCRIPT_MISSIONSCRIPT05_LUA_000171, 644 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000172")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000172)
	MisBeginCondition(LvCheck, ">", 13 )
	MisBeginCondition(NoMission, 644)
	MisBeginCondition(NoRecord, 644)
	MisBeginAction(AddMission, 644)
	MisBeginAction(AddTrigger, 6441, TE_GETITEM, 4421, 3 )
	MisCancelAction(ClearMission, 644)

	MisNeed(MIS_NEED_ITEM, 4421, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000173 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000173")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000173)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000174 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000174")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000174)
	MisResultCondition(NoRecord, 644)
	MisResultCondition(HasMission, 644)
	MisResultCondition(HasItem, 4421, 3)
	MisResultAction(TakeItem, 4421, 3 )
	MisResultAction(ClearMission, 644)
	MisResultAction(SetRecord, 644)
	MisResultAction(AddExp, 290, 290)
	MisResultAction(AddMoney,384,384)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000175")
	MisResultAction(GiveNpcMission1,645,MISSCRIPT_MISSIONSCRIPT05_LUA_000175,3)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4421 )	
	TriggerAction( 1, AddNextFlag, 644, 10, 3 )
	RegCurTrigger( 6441 )


-----------------------------------ÏÉÈËÕÆµÄË®ÄÒ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000176 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000176")
	DefineMission( 645, MISSCRIPT_MISSIONSCRIPT05_LUA_000176, 645 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000177")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000177)
	MisBeginCondition(LvCheck, ">", 13 )
	MisBeginCondition(NoMission, 645)
	MisBeginCondition(HasRecord, 644)
	MisBeginCondition(NoRecord, 645)
	MisBeginAction(AddMission, 645)
	MisBeginAction(AddTrigger, 6451, TE_GETITEM, 4097, 3 )
	MisCancelAction(ClearMission, 645)

	MisNeed(MIS_NEED_ITEM, 4097, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000178 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000178")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000178)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000179 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000179")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000179)
	MisResultCondition(NoRecord, 645)
	MisResultCondition(HasMission, 645)
	MisResultCondition(HasItem, 4097, 3)
	MisResultAction(TakeItem, 4097, 3 )
	MisResultAction(ClearMission, 645)
	MisResultAction(SetRecord, 645)
	MisResultAction(AddExp, 290, 290)
	MisResultAction(AddMoney,384,384)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000175")
	MisResultAction(GiveNpcMission1,646,MISSCRIPT_MISSIONSCRIPT05_LUA_000175,4)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4097 )	
	TriggerAction( 1, AddNextFlag, 645, 10, 3 )
	RegCurTrigger( 6451 )

----------------------------------·­¹ö´óÏÉÈËÇò
	MISSCRIPT_MISSIONSCRIPT05_LUA_000180 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000180")
	DefineMission( 646, MISSCRIPT_MISSIONSCRIPT05_LUA_000180, 646 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000181 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000181")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000181)
	MisBeginCondition(LvCheck, ">", 14 )
	MisBeginCondition(NoMission, 646)
	MisBeginCondition(HasRecord, 645)
	MisBeginCondition(NoRecord, 646)
	MisBeginAction(AddMission, 646)
	MisBeginAction(AddTrigger, 6461, TE_KILL, 294, 10 )
	MisCancelAction(ClearMission, 646)

	MisNeed(MIS_NEED_KILL, 294, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000182 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000182")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000182)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000183 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000183")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000183)
	MisResultCondition(NoRecord, 646)
	MisResultCondition(HasMission, 646)
	MisResultCondition(HasFlag, 646, 19 )
	MisResultAction(ClearMission, 646)
	MisResultAction(SetRecord, 646)
	MisResultAction(AddExp, 360, 360)
	MisResultAction(AddMoney,204,204)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 294 )	
	TriggerAction( 1, AddNextFlag, 646, 10, 10 )
	RegCurTrigger( 6461 )

-----------------------------------¿àÎ¶¶àÖ­¹û
	HELP_MONSTERHELP_LUA_001211 = GetResString("HELP_MONSTERHELP_LUA_001211")
	DefineMission( 647, HELP_MONSTERHELP_LUA_001211, 647 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000184 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000184")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000184)
	MisBeginCondition(LvCheck, ">", 14 )
	MisBeginCondition(NoMission, 647)
	MisBeginCondition(NoRecord, 647)
	MisBeginAction(AddMission, 647)
	MisBeginAction(AddTrigger, 6471, TE_GETITEM, 4475, 3 )
	MisCancelAction(ClearMission, 647)

	MisNeed(MIS_NEED_ITEM, 4475, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000185")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000185)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000186 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000186")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000186)
	MisResultCondition(NoRecord, 647)
	MisResultCondition(HasMission, 647)
	MisResultCondition(HasItem, 4475, 3)
	MisResultAction(TakeItem, 4475, 3 )
	MisResultAction(ClearMission, 647)
	MisResultAction(SetRecord, 647)
	MisResultAction(AddExp, 360, 360)
	MisResultAction(AddMoney,408,408)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4475 )	
	TriggerAction( 1, AddNextFlag, 647, 10, 3 )
	RegCurTrigger( 6471 )

----------------------------------¹í¹ÖÊ÷´«Ëµ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000187 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000187")
	DefineMission( 648, MISSCRIPT_MISSIONSCRIPT05_LUA_000187, 648 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000188 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000188")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000188)
	MisBeginCondition(LvCheck, ">", 15 )
	MisBeginCondition(NoMission, 648)
	MisBeginCondition(NoRecord, 648)
	MisBeginAction(AddMission, 648)
	MisBeginAction(AddTrigger, 6481, TE_KILL, 203, 10 )
	MisCancelAction(ClearMission, 648)

	MisNeed(MIS_NEED_KILL, 203, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000189 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000189")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000189)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000190")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000190)
	MisResultCondition(NoRecord, 648)
	MisResultCondition(HasMission, 648)
	MisResultCondition(HasFlag, 648, 19 )
	MisResultAction(ClearMission, 648)
	MisResultAction(SetRecord, 648)
	MisResultAction(AddExp, 450, 450)
	MisResultAction(AddMoney,216,216)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 203 )	
	TriggerAction( 1, AddNextFlag, 648, 10, 10 )
	RegCurTrigger( 6481 )


-----------------------------------¿ÝÄ¾·ê´º
	MISSCRIPT_MISSIONSCRIPT05_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000191")
	DefineMission( 649, MISSCRIPT_MISSIONSCRIPT05_LUA_000191, 649 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000192 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000192")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000192)
	MisBeginCondition(LvCheck, ">", 16 )
	MisBeginCondition(NoMission, 649)
	MisBeginCondition(NoRecord, 649)
	MisBeginAction(AddMission, 649)
	MisBeginAction(AddTrigger, 6491, TE_GETITEM, 4098, 5 )
	MisCancelAction(ClearMission, 649)

	MisNeed(MIS_NEED_ITEM, 4098, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000193 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000193")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000193)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000194 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000194")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000194)
	MisResultCondition(NoRecord, 649)
	MisResultCondition(HasMission, 649)
	MisResultCondition(HasItem, 4098, 5)
	MisResultAction(TakeItem, 4098, 5 )
	MisResultAction(ClearMission, 649)
	MisResultAction(SetRecord, 649)
	MisResultAction(AddExp, 550, 550)
	MisResultAction(AddMoney,459,459)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4098 )	
	TriggerAction( 1, AddNextFlag, 649, 10, 5 )
	RegCurTrigger( 6491 )

-----------------------------------ÇîÐ×¼«¶ñ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000195 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000195")
	DefineMission( 650, MISSCRIPT_MISSIONSCRIPT05_LUA_000195, 650 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000196 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000196")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000196)
	MisBeginCondition(LvCheck, ">", 17 )
	MisBeginCondition(NoMission, 650)
	MisBeginCondition(NoRecord, 650)
	MisBeginAction(AddMission, 650)
	MisBeginAction(AddTrigger, 6501, TE_GETITEM, 4099, 1 )
	MisCancelAction(ClearMission, 650)

	MisNeed(MIS_NEED_ITEM, 4099, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000197 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000197")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000197)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000198 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000198")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000198)
	MisResultCondition(NoRecord, 650)
	MisResultCondition(HasMission, 650)
	MisResultCondition(HasItem, 4099, 1)
	MisResultAction(TakeItem, 4099, 1 )
	MisResultAction(ClearMission, 650)
	MisResultAction(SetRecord, 650)
	MisResultAction(AddExp, 650, 650)
	MisResultAction(AddMoney,242,242)
	MisResultAction(GiveItem,4668,1,4)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4099 )	
	TriggerAction( 1, AddNextFlag, 650, 10, 1 )
	RegCurTrigger( 6501 )


----------------------------------Î§½ËÇÔÔô
	MISSCRIPT_MISSIONSCRIPT05_LUA_000199 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000199")
	DefineMission( 651, MISSCRIPT_MISSIONSCRIPT05_LUA_000199, 651 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000200 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000200")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000200)
	MisBeginCondition(LvCheck, ">", 18 )
	MisBeginCondition(NoMission, 651)
	MisBeginCondition(NoRecord, 651)
	MisBeginAction(AddMission, 651)
	MisBeginAction(AddTrigger, 6511, TE_KILL, 131, 5 )
	MisCancelAction(ClearMission, 651)

	MisNeed(MIS_NEED_KILL, 131, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000201")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000201)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000202 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000202")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000202)
	MisResultCondition(NoRecord, 651)
	MisResultCondition(HasMission, 651)
	MisResultCondition(HasFlag, 651, 14 )
	MisResultAction(ClearMission, 651)
	MisResultAction(SetRecord, 651)
	MisResultAction(AddExp, 750, 750)
	MisResultAction(AddMoney,256,256)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 131 )	
	TriggerAction( 1, AddNextFlag, 651, 10, 5 )
	RegCurTrigger( 6511 )

----------------------------------Ð×ºÝ¶öÀÇ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000203 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000203")
	DefineMission( 652, MISSCRIPT_MISSIONSCRIPT05_LUA_000203, 652 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000204 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000204")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000204)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 652)
	MisBeginCondition(NoRecord, 652)
	MisBeginAction(AddMission, 652)
	MisBeginAction(AddTrigger, 6521, TE_KILL, 101, 10 )
	MisCancelAction(ClearMission, 652)

	MisNeed(MIS_NEED_KILL, 101, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000205 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000205")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000205)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000206 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000206")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000206)
	MisResultCondition(NoRecord, 652)
	MisResultCondition(HasMission, 652)
	MisResultCondition(HasFlag, 652, 19 )
	MisResultAction(ClearMission, 652)
	MisResultAction(SetRecord, 652)
	MisResultAction(AddExp, 880, 880)
	MisResultAction(AddMoney,270,270)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 101 )	
	TriggerAction( 1, AddNextFlag, 652, 10, 10 )
	RegCurTrigger( 6521 )

----------------------------------É³µØ¹êÖ®ÂÒ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000207 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000207")
	DefineMission( 653, MISSCRIPT_MISSIONSCRIPT05_LUA_000207, 653 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000208 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000208")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000208)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 653)
	MisBeginCondition(NoRecord, 653)
	MisBeginAction(AddMission, 653)
	MisBeginAction(AddTrigger, 6531, TE_KILL, 134, 10 )
	MisCancelAction(ClearMission, 653)

	MisNeed(MIS_NEED_KILL, 134, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000209 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000209")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000209)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000190")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000190)
	MisResultCondition(NoRecord, 653)
	MisResultCondition(HasMission, 653)
	MisResultCondition(HasFlag, 653, 19 )
	MisResultAction(ClearMission, 653)
	MisResultAction(SetRecord, 653)
	MisResultAction(AddExp, 880, 880)
	MisResultAction(AddMoney,270,270)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)



	InitTrigger()
	TriggerCondition( 1, IsMonster, 134 )	
	TriggerAction( 1, AddNextFlag, 653, 10, 10 )
	RegCurTrigger( 6531 )

-----------------------------------ÒÆ¶¯»¨ÆÔ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000210 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000210")
	DefineMission( 654, MISSCRIPT_MISSIONSCRIPT05_LUA_000210, 654 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000211 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000211")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000211)
	MisBeginCondition(LvCheck, ">", 20 )
	MisBeginCondition(NoMission, 654)
	MisBeginCondition(NoRecord, 654)
	MisBeginAction(AddMission, 654)
	MisBeginAction(AddTrigger, 6541, TE_GETITEM, 4466, 5 )
	MisCancelAction(ClearMission, 654)

	MisNeed(MIS_NEED_ITEM, 4466, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000212 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000212")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000212)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000213 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000213")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000213)
	MisResultCondition(NoRecord, 654)
	MisResultCondition(HasMission, 654)
	MisResultCondition(HasItem, 4466, 5)
	MisResultAction(TakeItem, 4466, 5 )
	MisResultAction(ClearMission, 654)
	MisResultAction(SetRecord, 654)
	MisResultAction(AddExp, 1000, 1000)
	MisResultAction(AddMoney,571,571)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4466 )	
	TriggerAction( 1, AddNextFlag, 654, 10, 5 )
	RegCurTrigger( 6541 )

----------------------------------Î´Óê³ñçÑ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000214 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000214")
	DefineMission( 655, MISSCRIPT_MISSIONSCRIPT05_LUA_000214, 655 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000215 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000215")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000215)
	MisBeginCondition(LvCheck, ">", 21 )
	MisBeginCondition(NoMission, 655)
	MisBeginCondition(NoRecord, 655)
	MisBeginAction(AddMission, 655)
	MisBeginAction(AddTrigger, 6551, TE_KILL, 45, 6 )
	MisCancelAction(ClearMission, 655)

	MisNeed(MIS_NEED_KILL, 45, 6, 10, 6)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000216")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000216)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000217 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000217")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000217)
	MisResultCondition(NoRecord, 655)
	MisResultCondition(HasMission, 655)
	MisResultCondition(HasFlag, 655, 15 )
	MisResultAction(ClearMission, 655)
	MisResultAction(SetRecord, 655)
	MisResultAction(AddExp, 1200, 1200)
	MisResultAction(AddMoney,300,300)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 45 )	
	TriggerAction( 1, AddNextFlag, 655, 10, 6 )
	RegCurTrigger( 6551 )

-----------------------------------Ä¢¹½Å¨ÌÀ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000218 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000218")
	DefineMission( 656, MISSCRIPT_MISSIONSCRIPT05_LUA_000218, 656 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000219 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000219")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000219)
	MisBeginCondition(LvCheck, ">", 22 )
	MisBeginCondition(NoMission, 656)
	MisBeginCondition(NoRecord, 656)
	MisBeginAction(AddMission, 656)
	MisBeginAction(AddTrigger, 6561, TE_GETITEM, 4476, 5 )
	MisCancelAction(ClearMission, 656)

	MisNeed(MIS_NEED_ITEM, 4476, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000220 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000220")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000220)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000221")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000221)
	MisResultCondition(NoRecord, 656)
	MisResultCondition(HasMission, 656)
	MisResultCondition(HasItem, 4476, 5)
	MisResultAction(TakeItem, 4476, 5 )
	MisResultAction(ClearMission, 656)
	MisResultAction(SetRecord, 656)
	MisResultAction(AddExp, 1400, 1400)
	MisResultAction(AddMoney,632,632)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4476 )	
	TriggerAction( 1, AddNextFlag, 656, 10, 5 )
	RegCurTrigger( 6561 )

-----------------------------------ÌÓÅÜµÄÉ³µØ¹½
	MISSCRIPT_MISSIONSCRIPT05_LUA_000222 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000222")
	DefineMission( 657, MISSCRIPT_MISSIONSCRIPT05_LUA_000222, 657 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000223 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000223")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000223)
	MisBeginCondition(LvCheck, ">", 22 )
	MisBeginCondition(NoMission, 657)
	MisBeginCondition(NoRecord, 657)
	MisBeginAction(AddMission, 657)
	MisBeginAction(AddTrigger, 6571, TE_GETITEM, 4100, 1 )
	MisCancelAction(ClearMission, 657)

	MisNeed(MIS_NEED_ITEM, 4100, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000224 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000224")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000224)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000225")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000225)
	MisResultCondition(NoRecord, 657)
	MisResultCondition(HasMission, 657)
	MisResultCondition(HasItem, 4100, 1)
	MisResultAction(TakeItem, 4100, 1 )
	MisResultAction(ClearMission, 657)
	MisResultAction(SetRecord, 657)
	MisResultAction(AddExp, 1400, 1400)
	MisResultAction(AddMoney,316,316)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4100 )	
	TriggerAction( 1, AddNextFlag, 657, 10, 1 )
	RegCurTrigger( 6571 )

-----------------------------------Äà½¬µÄÃîÓÃ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000226 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000226")
	DefineMission( 658, MISSCRIPT_MISSIONSCRIPT05_LUA_000226, 658 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000227 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000227")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000227)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 658)
	MisBeginCondition(NoRecord, 658)
	MisBeginAction(AddMission, 658)
	MisBeginAction(AddTrigger, 6581, TE_GETITEM, 4436, 5 )
	MisCancelAction(ClearMission, 658)

	MisNeed(MIS_NEED_ITEM, 4436, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000228 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000228")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000228)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000229")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000229)
	MisResultCondition(NoRecord, 658)
	MisResultCondition(HasMission, 658)
	MisResultCondition(HasItem, 4436, 5)
	MisResultAction(TakeItem, 4436, 5 )
	MisResultAction(ClearMission, 658)
	MisResultAction(SetRecord, 658)
	MisResultAction(AddExp, 1600, 1600)
	MisResultAction(AddMoney,664,664)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4436 )	
	TriggerAction( 1, AddNextFlag, 658, 10, 5 )
	RegCurTrigger( 6581 )

----------------------------------Ì°À·µÄÄàÈË
	MISSCRIPT_MISSIONSCRIPT05_LUA_000230 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000230")
	DefineMission( 659, MISSCRIPT_MISSIONSCRIPT05_LUA_000230, 659 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000231 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000231")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000231)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 659)
	MisBeginCondition(NoRecord, 659)
	MisBeginAction(AddMission, 659)
	MisBeginAction(AddTrigger, 6591, TE_KILL, 251, 10 )
	MisCancelAction(ClearMission, 659)

	MisNeed(MIS_NEED_KILL, 251, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000232")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000232)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000190")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000190)
	MisResultCondition(NoRecord, 659)
	MisResultCondition(HasMission, 659)
	MisResultCondition(HasFlag, 659, 19 )
	MisResultAction(ClearMission, 659)
	MisResultAction(SetRecord, 659)
	MisResultAction(AddExp, 1600, 1600)
	MisResultAction(AddMoney,332,332)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 251 )	
	TriggerAction( 1, AddNextFlag, 659, 10, 10 )
	RegCurTrigger( 6591 )

----------------------------------Î£ÏÕÉ³ÆïÊ¿
	MISSCRIPT_MISSIONSCRIPT05_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000233")
	DefineMission( 660, MISSCRIPT_MISSIONSCRIPT05_LUA_000233, 660 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000234 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000234")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000234)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 660)
	MisBeginCondition(NoRecord, 660)
	MisBeginAction(AddMission, 660)
	MisBeginAction(AddTrigger, 6601, TE_KILL, 49, 10 )
	MisCancelAction(ClearMission, 660)

	MisNeed(MIS_NEED_KILL, 49, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000235 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000235")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000235)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000236 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000236")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000236)
	MisResultCondition(NoRecord, 660)
	MisResultCondition(HasMission, 660)
	MisResultCondition(HasFlag, 660, 19 )
	MisResultAction(ClearMission, 660)
	MisResultAction(SetRecord, 660)
	MisResultAction(AddExp, 1800, 1800)
	MisResultAction(AddMoney,348,348)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 49 )	
	TriggerAction( 1, AddNextFlag, 660, 10, 10 )
	RegCurTrigger( 6601 )

----------------------------------²ù³ýÊ³ÈËÖ©Öë
	MISSCRIPT_MISSIONSCRIPT05_LUA_000237 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000237")
	DefineMission( 661, MISSCRIPT_MISSIONSCRIPT05_LUA_000237, 661 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000238 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000238")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000238)
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 661)
	MisBeginCondition(NoRecord, 661)
	MisBeginAction(AddMission, 661)
	MisBeginAction(AddTrigger, 6611, TE_KILL, 210, 10 )
	MisCancelAction(ClearMission, 661)

	MisNeed(MIS_NEED_KILL, 210, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000239 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000239")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000239)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000240 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000240")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000240)
	MisResultCondition(NoRecord, 661)
	MisResultCondition(HasMission, 661)
	MisResultCondition(HasFlag, 661, 19 )
	MisResultAction(ClearMission, 661)
	MisResultAction(SetRecord, 661)
	MisResultAction(AddExp, 2000, 2000)
	MisResultAction(AddMoney,365,365)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 210 )	
	TriggerAction( 1, AddNextFlag, 661, 10, 10 )
	RegCurTrigger( 6611 )

-----------------------------------Ö±Á¢ÐÐ×ßµÄÀÇ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000241 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000241")
	DefineMission( 662, MISSCRIPT_MISSIONSCRIPT05_LUA_000241, 662 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000242 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000242")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000242)
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 662)
	MisBeginCondition(NoRecord, 662)
	MisBeginAction(AddMission, 662)
	MisBeginAction(AddTrigger, 6621, TE_GETITEM, 4439, 5 )
	MisCancelAction(ClearMission, 662)

	MisNeed(MIS_NEED_ITEM, 4439, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000243")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000243)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000244")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000244)
	MisResultCondition(NoRecord, 662)
	MisResultCondition(HasMission, 662)
	MisResultCondition(HasItem, 4439, 5)
	MisResultAction(TakeItem, 4439, 5 )
	MisResultAction(ClearMission, 662)
	MisResultAction(SetRecord, 662)
	MisResultAction(AddExp, 2000, 2000)
	MisResultAction(AddMoney,730,730)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4439 )	
	TriggerAction( 1, AddNextFlag, 662, 10, 5 )
	RegCurTrigger( 6621 )

-----------------------------------½ð±ÒÖ©Öë
	MISSCRIPT_MISSIONSCRIPT05_LUA_000245 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000245")
	DefineMission( 663, MISSCRIPT_MISSIONSCRIPT05_LUA_000245, 663 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000246 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000246")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000246)
	MisBeginCondition(LvCheck, ">", 25 )
	MisBeginCondition(NoMission, 663)
	MisBeginCondition(NoRecord, 663)
	MisBeginAction(AddMission, 663)
	MisBeginAction(AddTrigger, 6631, TE_GETITEM, 4101, 1 )
	MisCancelAction(ClearMission, 663)

	MisNeed(MIS_NEED_ITEM, 4101, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000247 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000247")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000247)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000248 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000248")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000248)
	MisResultCondition(NoRecord, 663)
	MisResultCondition(HasMission, 663)
	MisResultCondition(HasItem, 4101, 1)
	MisResultAction(TakeItem, 4101, 1 )
	MisResultAction(ClearMission, 663)
	MisResultAction(SetRecord, 663)
	MisResultAction(AddExp, 2400, 2400)
	MisResultAction(AddMoney,382,382)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4101 )	
	TriggerAction( 1, AddNextFlag, 663, 10, 1 )
	RegCurTrigger( 6631 )

-----------------------------------ÍòÄÜÔ¿³×
	HELP_MONSTERHELP_LUA_001220 = GetResString("HELP_MONSTERHELP_LUA_001220")
	DefineMission( 664, HELP_MONSTERHELP_LUA_001220, 664 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000249 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000249")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000249)
	MisBeginCondition(LvCheck, ">", 25 )
	MisBeginCondition(NoMission, 664)
	MisBeginCondition(NoRecord, 664)
	MisBeginAction(AddMission, 664)
	MisBeginAction(AddTrigger, 6641, TE_GETITEM, 4478, 2 )
	MisCancelAction(ClearMission, 664)

	MisNeed(MIS_NEED_ITEM, 4478, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000250 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000250")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000250)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000251 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000251")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000251)
	MisResultCondition(NoRecord, 664)
	MisResultCondition(HasMission, 664)
	MisResultCondition(HasItem, 4478, 2)
	MisResultAction(TakeItem, 4478, 2 )
	MisResultAction(ClearMission, 664)
	MisResultAction(SetRecord, 664)
	MisResultAction(AddExp, 2400, 2400)
	MisResultAction(AddMoney,765,765)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4478 )	
	TriggerAction( 1, AddNextFlag, 664, 10, 2 )
	RegCurTrigger( 6641 )

----------------------------------ÇÜÔôÇÜÍõ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000252 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000252")
	DefineMission( 665, MISSCRIPT_MISSIONSCRIPT05_LUA_000252, 665 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000253 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000253")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000253)
	MisBeginCondition(LvCheck, ">", 26 )
	MisBeginCondition(NoMission, 665)
	MisBeginCondition(NoRecord, 665)
	MisBeginAction(AddMission, 665)
	MisBeginAction(AddTrigger, 6651, TE_KILL, 106, 1 )
	MisCancelAction(ClearMission, 665)

	MisNeed(MIS_NEED_KILL, 106, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000254 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000254")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000254)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000004")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000004)
	MisResultCondition(NoRecord, 665)
	MisResultCondition(HasMission, 665)
	MisResultCondition(HasFlag, 665, 10 )
	MisResultAction(ClearMission, 665)
	MisResultAction(SetRecord, 665)
	MisResultAction(AddExp, 2700, 2700)
	MisResultAction(AddMoney,400,400)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 106 )	
	TriggerAction( 1, AddNextFlag, 665, 10, 1 )
	RegCurTrigger( 6651 )

----------------------------------ÌôÕ½¶ÜÆïÊ¿
	MISSCRIPT_MISSIONSCRIPT05_LUA_000255 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000255")
	DefineMission( 666, MISSCRIPT_MISSIONSCRIPT05_LUA_000255, 666 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000256 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000256")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000256)
	MisBeginCondition(LvCheck, ">", 27 )
	MisBeginCondition(NoMission, 666)
	MisBeginCondition(NoRecord, 666)
	MisBeginAction(AddMission, 666)
	MisBeginAction(AddTrigger, 6661, TE_KILL, 200, 10 )
	MisCancelAction(ClearMission, 666)

	MisNeed(MIS_NEED_KILL, 200, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000257 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000257")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000257)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000258 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000258")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000258)
	MisResultCondition(NoRecord, 666)
	MisResultCondition(HasMission, 666)
	MisResultCondition(HasFlag, 666, 19 )
	MisResultAction(ClearMission, 666)
	MisResultAction(SetRecord, 666)
	MisResultAction(AddExp, 3000, 3000)
	MisResultAction(AddMoney,417,417)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 200 )	
	TriggerAction( 1, AddNextFlag, 666, 10, 10 )
	RegCurTrigger( 6661 )

-----------------------------------òáòæ»Ê¹Ú
	HELP_MONSTERHELP_LUA_001258 = GetResString("HELP_MONSTERHELP_LUA_001258")
	DefineMission( 667, HELP_MONSTERHELP_LUA_001258, 667 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000259 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000259")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000259)
	MisBeginCondition(LvCheck, ">", 28 )
	MisBeginCondition(NoMission, 667)
	MisBeginCondition(NoRecord, 667)
	MisBeginAction(AddMission, 667)
	MisBeginAction(AddTrigger, 6671, TE_GETITEM, 1757, 10 )
	MisCancelAction(ClearMission, 667)

	MisNeed(MIS_NEED_ITEM, 1757, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000260 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000260")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000260)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000261 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000261")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000261)
	MisResultCondition(NoRecord, 667)
	MisResultCondition(HasMission, 667)
	MisResultCondition(HasItem, 1757, 10)
	MisResultAction(TakeItem, 1757, 10 )
	MisResultAction(ClearMission, 667)
	MisResultAction(SetRecord, 667)
	MisResultAction(AddExp, 3400, 3400)
	MisResultAction(AddMoney,849,849)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6710,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1757 )	
	TriggerAction( 1, AddNextFlag, 667, 10, 10 )
	RegCurTrigger( 6671 )

-----------------------------------Ë®±øÃ±
	MISSCRIPT_MISSIONSCRIPT05_LUA_000262 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000262")
	DefineMission( 668, MISSCRIPT_MISSIONSCRIPT05_LUA_000262, 668 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000263 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000263")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000263)
	MisBeginCondition(LvCheck, ">", 9 )
	MisBeginCondition(NoMission, 668)
	MisBeginCondition(NoRecord, 668)
	MisBeginAction(AddMission, 668)
	MisBeginAction(AddTrigger, 6681, TE_GETITEM, 4102, 2 )
	MisCancelAction(ClearMission, 668)

	MisNeed(MIS_NEED_ITEM, 4102, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000264 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000264")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000264)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000265 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000265")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000265)
	MisResultCondition(NoRecord, 668)
	MisResultCondition(HasMission, 668)
	MisResultCondition(HasItem, 4102, 2)
	MisResultAction(TakeItem, 4102, 2 )
	MisResultAction(ClearMission, 668)
	MisResultAction(SetRecord, 668)
	MisResultAction(AddExp, 120, 120)
	MisResultAction(AddMoney,299,299)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4102 )	
	TriggerAction( 1, AddNextFlag, 668, 10, 2 )
	RegCurTrigger( 6681 )

-----------------------------------¾«ÁéÖ®ÐÄ
	HELP_MONSTERHELP_LUA_001201 = GetResString("HELP_MONSTERHELP_LUA_001201")
	DefineMission( 669, HELP_MONSTERHELP_LUA_001201, 669 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000266 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000266")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000266)
	MisBeginCondition(LvCheck, ">", 9 )
	MisBeginCondition(NoMission, 669)
	MisBeginCondition(NoRecord, 669)
	MisBeginAction(AddMission, 669)
	MisBeginAction(AddTrigger, 6691, TE_GETITEM, 4418, 2 )
	MisCancelAction(ClearMission, 669)

	MisNeed(MIS_NEED_ITEM, 4418, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000267 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000267")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000267)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000268 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000268")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000268)
	MisResultCondition(NoRecord, 669)
	MisResultCondition(HasMission, 669)
	MisResultCondition(HasItem, 4418, 2)
	MisResultAction(TakeItem, 4418, 2 )
	MisResultAction(ClearMission, 669)
	MisResultAction(SetRecord, 669)
	MisResultAction(AddExp, 120, 120)
	MisResultAction(AddMoney,299,299)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4418 )	
	TriggerAction( 1, AddNextFlag, 669, 10, 2 )
	RegCurTrigger( 6691 )

-----------------------------------ÍêÃÀË®¾§
	MISSCRIPT_MISSIONSCRIPT05_LUA_000269 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000269")
	DefineMission( 670, MISSCRIPT_MISSIONSCRIPT05_LUA_000269, 670 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000270")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000270)
	MisBeginCondition(LvCheck, ">", 10 )
	MisBeginCondition(NoMission, 670)
	MisBeginCondition(NoRecord, 670)
	MisBeginAction(AddMission, 670)
	MisBeginAction(AddTrigger, 6701, TE_GETITEM, 4103, 3 )
	MisCancelAction(ClearMission, 670)

	MisNeed(MIS_NEED_ITEM, 4103, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000271 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000271")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000271)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000272 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000272")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000272)
	MisResultCondition(NoRecord, 670)
	MisResultCondition(HasMission, 670)
	MisResultCondition(HasItem, 4103, 3)
	MisResultAction(TakeItem, 4103, 3 )
	MisResultAction(ClearMission, 670)
	MisResultAction(SetRecord, 670)
	MisResultAction(AddExp, 150, 150)
	MisResultAction(AddMoney,318,318)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4103 )	
	TriggerAction( 1, AddNextFlag, 670, 10, 3 )
	RegCurTrigger( 6701 )

----------------------------------÷çÂ¹°§Ãù
	MISSCRIPT_MISSIONSCRIPT05_LUA_000273 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000273")
	DefineMission( 671, MISSCRIPT_MISSIONSCRIPT05_LUA_000273, 671 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000274 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000274")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000274)
	MisBeginCondition(LvCheck, ">", 11 )
	MisBeginCondition(NoMission, 671)
	MisBeginCondition(NoRecord, 671)
	MisBeginAction(AddMission, 671)
	MisBeginAction(AddTrigger, 6711, TE_KILL, 266, 10 )
	MisCancelAction(ClearMission, 671)

	MisNeed(MIS_NEED_KILL, 266, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000275")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000275)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000276 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000276")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000276)
	MisResultCondition(NoRecord, 671)
	MisResultCondition(HasMission, 671)
	MisResultCondition(HasFlag, 671, 19 )
	MisResultAction(ClearMission, 671)
	MisResultAction(SetRecord, 671)
	MisResultAction(AddExp, 190, 190)
	MisResultAction(AddMoney,169,169)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 266 )	
	TriggerAction( 1, AddNextFlag, 671, 10, 10 )
	RegCurTrigger( 6711 )

----------------------------------·ÊÅÖµÄÐ¡¶«Î÷
	MISSCRIPT_MISSIONSCRIPT05_LUA_000277 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000277")
	DefineMission( 672, MISSCRIPT_MISSIONSCRIPT05_LUA_000277, 672 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000278 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000278")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000278)
	MisBeginCondition(LvCheck, ">", 12 )
	MisBeginCondition(NoMission, 672)
	MisBeginCondition(NoRecord, 672)
	MisBeginAction(AddMission, 672)
	MisBeginAction(AddTrigger, 6721, TE_KILL, 34, 10 )
	MisCancelAction(ClearMission, 672)

	MisNeed(MIS_NEED_KILL, 34, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000279 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000279")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000279)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000280")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000280)
	MisResultCondition(NoRecord, 672)
	MisResultCondition(HasMission, 672)
	MisResultCondition(HasFlag, 672, 19 )
	MisResultAction(ClearMission, 672)
	MisResultAction(SetRecord, 672)
	MisResultAction(AddExp, 240, 240)
	MisResultAction(AddMoney,180,180)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 34 )	
	TriggerAction( 1, AddNextFlag, 672, 10, 10 )
	RegCurTrigger( 6721 )

-----------------------------------ÏàË¼³ÉÔÖ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000281 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000281")
	DefineMission( 673, MISSCRIPT_MISSIONSCRIPT05_LUA_000281, 673 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000282 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000282")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000282)
	MisBeginCondition(LvCheck, ">", 13 )
	MisBeginCondition(NoMission, 673)
	MisBeginCondition(NoRecord, 673)
	MisBeginAction(AddMission, 673)
	MisBeginAction(AddTrigger, 6731, TE_GETITEM, 1839, 2 )
	MisCancelAction(ClearMission, 673)

	MisNeed(MIS_NEED_ITEM, 1839, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000283 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000283")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000283)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000284 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000284")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000284)
	MisResultCondition(NoRecord, 673)
	MisResultCondition(HasMission, 673)
	MisResultCondition(HasItem, 1839, 2)
	MisResultAction(TakeItem, 1839, 2 )
	MisResultAction(ClearMission, 673)
	MisResultAction(SetRecord, 673)
	MisResultAction(AddExp, 290, 290)
	MisResultAction(AddMoney,384,384)


	InitTrigger()
	TriggerCondition( 1, IsItem, 1839 )	
	TriggerAction( 1, AddNextFlag, 673, 10, 2 )
	RegCurTrigger( 6731 )


----------------------------------Âé·³µÄÑ©òùòð
	MISSCRIPT_MISSIONSCRIPT05_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000285")
	DefineMission( 674, MISSCRIPT_MISSIONSCRIPT05_LUA_000285, 674 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000286")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000286)
	MisBeginCondition(LvCheck, ">", 14 )
	MisBeginCondition(NoMission, 674)
	MisBeginCondition(NoRecord, 674)
	MisBeginAction(AddMission, 674)
	MisBeginAction(AddTrigger, 6741, TE_KILL, 46, 10 )
	MisCancelAction(ClearMission, 674)

	MisNeed(MIS_NEED_KILL, 46, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000287 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000287")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000287)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000288 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000288")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000288)
	MisResultCondition(NoRecord, 674)
	MisResultCondition(HasMission, 674)
	MisResultCondition(HasFlag, 674, 19 )
	MisResultAction(ClearMission, 674)
	MisResultAction(SetRecord, 674)
	MisResultAction(AddExp, 360, 360)
	MisResultAction(AddMoney,204,204)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 46 )	
	TriggerAction( 1, AddNextFlag, 674, 10, 10 )
	RegCurTrigger( 6741 )

-----------------------------------»ÃÊõ²ÄÁÏ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000289 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000289")
	DefineMission( 675, MISSCRIPT_MISSIONSCRIPT05_LUA_000289, 675 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000290")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000290)
	MisBeginCondition(LvCheck, ">", 14 )
	MisBeginCondition(NoMission, 675)
	MisBeginCondition(NoRecord, 675)
	MisBeginAction(AddMission, 675)
	MisBeginAction(AddTrigger, 6751, TE_GETITEM, 4427, 3 )
	MisCancelAction(ClearMission, 675)

	MisNeed(MIS_NEED_ITEM, 4427, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000291 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000291")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000291)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000292 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000292")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000292)
	MisResultCondition(NoRecord, 675)
	MisResultCondition(HasMission, 675)
	MisResultCondition(HasItem, 4427, 3)
	MisResultAction(TakeItem, 4427, 3 )
	MisResultAction(ClearMission, 675)
	MisResultAction(SetRecord, 675)
	MisResultAction(AddExp, 360, 360)
	MisResultAction(AddMoney,408,408)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4427 )	
	TriggerAction( 1, AddNextFlag, 675, 10, 3 )
	RegCurTrigger( 6751 )


----------------------------------ÅÁÅÁµÄÎÛÈ¾
	MISSCRIPT_MISSIONSCRIPT05_LUA_000293 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000293")
	DefineMission( 676, MISSCRIPT_MISSIONSCRIPT05_LUA_000293, 676 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000294 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000294")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000294)
	MisBeginCondition(LvCheck, ">", 15 )
	MisBeginCondition(NoMission, 676)
	MisBeginCondition(NoRecord, 676)
	MisBeginAction(AddMission, 676)
	MisBeginAction(AddTrigger, 6761, TE_KILL, 233, 10 )
	MisCancelAction(ClearMission, 676)

	MisNeed(MIS_NEED_KILL, 233, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000295")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000295)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000296 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000296")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000296)
	MisResultCondition(NoRecord, 676)
	MisResultCondition(HasMission, 676)
	MisResultCondition(HasFlag, 676, 19 )
	MisResultAction(ClearMission, 676)
	MisResultAction(SetRecord, 676)
	MisResultAction(AddExp, 450, 450)
	MisResultAction(AddMoney,216,216)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 233 )	
	TriggerAction( 1, AddNextFlag, 676, 10, 10 )
	RegCurTrigger( 6761 )

-----------------------------------ÅÁÅÁÃ±×Ó
	HELP_MONSTERHELP_LUA_001187 = GetResString("HELP_MONSTERHELP_LUA_001187")
	DefineMission( 677, HELP_MONSTERHELP_LUA_001187, 677 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000297 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000297")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000297)
	MisBeginCondition(LvCheck, ">", 15 )
	MisBeginCondition(NoMission, 677)
	MisBeginCondition(NoRecord, 677)
	MisBeginCondition(HasRecord, 668)
	MisBeginAction(AddMission, 677)
	MisBeginAction(AddTrigger, 6771, TE_GETITEM, 1840, 2 )
	MisCancelAction(ClearMission, 677)

	MisNeed(MIS_NEED_ITEM, 1840, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000298 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000298")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000298)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000299 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000299")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000299)
	MisResultCondition(NoRecord, 677)
	MisResultCondition(HasMission, 677)
	MisResultCondition(HasItem, 1840, 2)
	MisResultAction(TakeItem, 1840, 2 )
	MisResultAction(ClearMission, 677)
	MisResultAction(SetRecord, 677)
	MisResultAction(AddExp, 450, 450)
	MisResultAction(AddMoney,433,433)


	InitTrigger()
	TriggerCondition( 1, IsItem, 1840 )	
	TriggerAction( 1, AddNextFlag, 677, 10, 2 )
	RegCurTrigger( 6771 )

----------------------------------²ù³ýÑ©µØ¹½
	MISSCRIPT_MISSIONSCRIPT05_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000300")
	DefineMission( 678, MISSCRIPT_MISSIONSCRIPT05_LUA_000300, 678 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000301 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000301")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000301)
	MisBeginCondition(LvCheck, ">", 16 )
	MisBeginCondition(NoMission, 678)
	MisBeginCondition(NoRecord, 678)
	MisBeginAction(AddMission, 678)
	MisBeginAction(AddTrigger, 6781, TE_KILL, 130, 10 )
	MisCancelAction(ClearMission, 678)

	MisNeed(MIS_NEED_KILL, 130, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000302 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000302")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000302)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000303 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000303")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000303)
	MisResultCondition(NoRecord, 678)
	MisResultCondition(HasMission, 678)
	MisResultCondition(HasFlag, 678, 19 )
	MisResultAction(ClearMission, 678)
	MisResultAction(SetRecord, 678)
	MisResultAction(AddExp, 550, 550)
	MisResultAction(AddMoney,229,229)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 130 )	
	TriggerAction( 1, AddNextFlag, 678, 10, 10 )
	RegCurTrigger( 6781 )

-----------------------------------Ñ©µØÄ¢¹½
	MISSCRIPT_MISSIONSCRIPT05_LUA_000304 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000304")
	DefineMission( 679, MISSCRIPT_MISSIONSCRIPT05_LUA_000304, 679 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000305")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000305)
	MisBeginCondition(LvCheck, ">", 16 )
	MisBeginCondition(NoMission, 679)
	MisBeginCondition(NoRecord, 679)
	MisBeginAction(AddMission, 679)
	MisBeginAction(AddTrigger, 6791, TE_GETITEM, 4104, 3 )
	MisCancelAction(ClearMission, 679)

	MisNeed(MIS_NEED_ITEM, 4104, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000306 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000306")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000306)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000307 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000307")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000307)
	MisResultCondition(NoRecord, 679)
	MisResultCondition(HasMission, 679)
	MisResultCondition(HasItem, 4104, 3)
	MisResultAction(TakeItem, 4104, 3 )
	MisResultAction(ClearMission, 679)
	MisResultAction(SetRecord, 679)
	MisResultAction(AddExp, 550, 550)
	MisResultAction(AddMoney,459,459)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4104 )	
	TriggerAction( 1, AddNextFlag, 679, 10, 3 )
	RegCurTrigger( 6791 )


----------------------------------³Ù¶ÛµÄÑ©µØÎÏÅ£
	MISSCRIPT_MISSIONSCRIPT05_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000308")
	DefineMission( 680, MISSCRIPT_MISSIONSCRIPT05_LUA_000308, 680 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000309 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000309")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000309)
	MisBeginCondition(LvCheck, ">", 17 )
	MisBeginCondition(NoMission, 680)
	MisBeginCondition(NoRecord, 680)
	MisBeginAction(AddMission, 680)
	MisBeginAction(AddTrigger, 6801, TE_KILL, 228, 10 )
	MisCancelAction(ClearMission, 680)

	MisNeed(MIS_NEED_KILL, 228, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000310")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000310)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000311 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000311")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000311)
	MisResultCondition(NoRecord, 680)
	MisResultCondition(HasMission, 680)
	MisResultCondition(HasFlag, 680, 19 )
	MisResultAction(ClearMission, 680)
	MisResultAction(SetRecord, 680)
	MisResultAction(AddExp, 650, 650)
	MisResultAction(AddMoney,242,242)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 228 )	
	TriggerAction( 1, AddNextFlag, 680, 10, 10 )
	RegCurTrigger( 6801 )

-----------------------------------»¨ÓïÊ¯
	MISSCRIPT_MISSIONSCRIPT05_LUA_000312 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000312")
	DefineMission( 681, MISSCRIPT_MISSIONSCRIPT05_LUA_000312, 681 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000313 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000313")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000313)
	MisBeginCondition(LvCheck, ">", 18 )
	MisBeginCondition(NoMission, 681)
	MisBeginCondition(NoRecord, 681)
	MisBeginAction(AddMission, 681)
	MisBeginAction(AddTrigger, 6811, TE_GETITEM, 4105, 3 )
	MisCancelAction(ClearMission, 681)

	MisNeed(MIS_NEED_ITEM, 4105, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000314 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000314")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000314)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000315")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000315)
	MisResultCondition(NoRecord, 681)
	MisResultCondition(HasMission, 681)
	MisResultCondition(HasItem, 4105, 3)
	MisResultAction(TakeItem, 4105, 3 )
	MisResultAction(ClearMission, 681)
	MisResultAction(SetRecord, 681)
	MisResultAction(AddExp, 750, 750)
	MisResultAction(AddMoney,513,513)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4105 )	
	TriggerAction( 1, AddNextFlag, 681, 10, 3 )
	RegCurTrigger( 6811 )

-----------------------------------ÎÏÅ£´¥½Ç
	HELP_MONSTERHELP_LUA_001178 = GetResString("HELP_MONSTERHELP_LUA_001178")
	DefineMission( 682, HELP_MONSTERHELP_LUA_001178, 682 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000316 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000316")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000316)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 682)
	MisBeginCondition(NoRecord, 682)
	MisBeginAction(AddMission, 682)
	MisBeginAction(AddTrigger, 6821, TE_GETITEM, 4428, 3 )
	MisCancelAction(ClearMission, 682)

	MisNeed(MIS_NEED_ITEM, 4428, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000317 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000317")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000317)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000150 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000150")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000150)
	MisResultCondition(NoRecord, 682)
	MisResultCondition(HasMission, 682)
	MisResultCondition(HasItem, 4428, 3)
	MisResultAction(TakeItem, 4428, 3 )
	MisResultAction(ClearMission, 682)
	MisResultAction(SetRecord, 682)
	MisResultAction(AddExp, 880, 880)
	MisResultAction(AddMoney,541,541)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4428 )	
	TriggerAction( 1, AddNextFlag, 682, 10, 3 )
	RegCurTrigger( 6821 )

-----------------------------------Ñ°ÕÒ±ùÑ©Ö®ÐÄ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000318 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000318")
	DefineMission( 683, MISSCRIPT_MISSIONSCRIPT05_LUA_000318, 683 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000319 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000319")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000319)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 683)
	MisBeginCondition(NoRecord, 683)
	MisBeginAction(AddMission, 683)
	MisBeginAction(AddTrigger, 6831, TE_GETITEM, 4431, 3 )
	MisCancelAction(ClearMission, 683)

	MisNeed(MIS_NEED_ITEM, 4431, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000320")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000320)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000321 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000321")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000321)
	MisResultCondition(NoRecord, 683)
	MisResultCondition(HasMission, 683)
	MisResultCondition(HasItem, 4431, 3)
	MisResultAction(TakeItem, 4431, 3 )
	MisResultAction(ClearMission, 683)
	MisResultAction(SetRecord, 683)
	MisResultAction(AddExp, 880, 880)
	MisResultAction(AddMoney,541,541)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4431 )	
	TriggerAction( 1, AddNextFlag, 683, 10, 3 )
	RegCurTrigger( 6831 )


----------------------------------´¿ÇéÑ©ÍÞÍÞ
	HELP_MONSTERHELP_LUA_000364 = GetResString("HELP_MONSTERHELP_LUA_000364")
	DefineMission( 684, HELP_MONSTERHELP_LUA_000364, 684 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000322 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000322")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000322)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(NoMission, 684)
	MisBeginCondition(NoRecord, 684)
	MisBeginAction(AddMission, 684)
	MisBeginAction(AddTrigger, 6841, TE_KILL, 255, 10 )
	MisCancelAction(ClearMission, 684)

	MisNeed(MIS_NEED_KILL, 255, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000323 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000323")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000323)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000324 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000324")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000324)
	MisResultCondition(NoRecord, 684)
	MisResultCondition(HasMission, 684)
	MisResultCondition(HasFlag, 684, 19 )
	MisResultAction(ClearMission, 684)
	MisResultAction(SetRecord, 684)
	MisResultAction(AddExp, 880, 880)
	MisResultAction(AddMoney,270,270)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 255 )	
	TriggerAction( 1, AddNextFlag, 684, 10, 10 )
	RegCurTrigger( 6841 )

----------------------------------Ó×ÐÜ³ö¶´
	MISSCRIPT_MISSIONSCRIPT05_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000325")
	DefineMission( 685, MISSCRIPT_MISSIONSCRIPT05_LUA_000325, 685 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000326 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000326")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000326)
	MisBeginCondition(LvCheck, ">", 20 )
	MisBeginCondition(NoMission, 685)
	MisBeginCondition(NoRecord, 685)
	MisBeginAction(AddMission, 685)
	MisBeginAction(AddTrigger, 6851, TE_KILL, 142, 10 )
	MisCancelAction(ClearMission, 685)

	MisNeed(MIS_NEED_KILL, 142, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000327 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000327")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000327)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000328 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000328")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000328)
	MisResultCondition(NoRecord, 685)
	MisResultCondition(HasMission, 685)
	MisResultCondition(HasFlag, 685, 19 )
	MisResultAction(ClearMission, 685)
	MisResultAction(SetRecord, 685)
	MisResultAction(AddExp, 1000, 1000)
	MisResultAction(AddMoney,285,285)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 142 )	
	TriggerAction( 1, AddNextFlag, 685, 10, 10 )
	RegCurTrigger( 6851 )

-----------------------------------Ñ©Ö®Àá
	MISSCRIPT_MISSIONSCRIPT05_LUA_000329 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000329")
	DefineMission( 686, MISSCRIPT_MISSIONSCRIPT05_LUA_000329, 686 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000330")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000330)
	MisBeginCondition(LvCheck, ">", 21 )
	MisBeginCondition(NoMission, 686)
	MisBeginCondition(NoRecord, 686)
	MisBeginAction(AddMission, 686)
	MisBeginAction(AddTrigger, 6861, TE_GETITEM, 4438, 5 )
	MisCancelAction(ClearMission, 686)

	MisNeed(MIS_NEED_ITEM, 4438, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000331 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000331")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000331)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000332 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000332")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000332)
	MisResultCondition(NoRecord, 686)
	MisResultCondition(HasMission, 686)
	MisResultCondition(HasItem, 4438, 5)
	MisResultAction(TakeItem, 4438, 5 )
	MisResultAction(ClearMission, 686)
	MisResultAction(SetRecord, 686)
	MisResultAction(AddExp, 1200, 1200)
	MisResultAction(AddMoney,601,601)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4438 )	
	TriggerAction( 1, AddNextFlag, 686, 10, 5 )
	RegCurTrigger( 6861 )


-----------------------------------±ùÑ©¾§Ê¯
	DARKBLUE_DARKBLUEENTITY_LUA_000001 = GetResString("DARKBLUE_DARKBLUEENTITY_LUA_000001")
	DefineMission( 687, DARKBLUE_DARKBLUEENTITY_LUA_000001, 687 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000333 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000333")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000333)
	MisBeginCondition(LvCheck, ">", 22 )
	MisBeginCondition(NoMission, 687)
	MisBeginCondition(NoRecord, 687)
	MisBeginAction(AddMission, 687)
	MisBeginAction(AddTrigger, 6871, TE_GETITEM, 4106, 1 )
	MisCancelAction(ClearMission, 687)

	MisNeed(MIS_NEED_ITEM, 4106, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000334 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000334")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000334)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000335")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000335)
	MisResultCondition(NoRecord, 687)
	MisResultCondition(HasMission, 687)
	MisResultCondition(HasItem, 4106, 1)
	MisResultAction(TakeItem, 4106, 1 )
	MisResultAction(ClearMission, 687)
	MisResultAction(SetRecord, 687)
	MisResultAction(AddExp, 1400, 1400)
	MisResultAction(AddMoney,316,316)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4106 )	
	TriggerAction( 1, AddNextFlag, 687, 10, 1 )
	RegCurTrigger( 6871 )

----------------------------------ÓÄÔ¹Ñ©Å®
	MISSCRIPT_MISSIONSCRIPT05_LUA_000336 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000336")
	DefineMission( 688, MISSCRIPT_MISSIONSCRIPT05_LUA_000336, 688 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000337 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000337")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000337)
	MisBeginCondition(LvCheck, ">", 22 )
	MisBeginCondition(NoMission, 688)
	MisBeginCondition(NoRecord, 688)
	MisBeginAction(AddMission, 688)
	MisBeginAction(AddTrigger, 6881, TE_KILL, 281, 10 )
	MisCancelAction(ClearMission, 688)

	MisNeed(MIS_NEED_KILL, 281, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000338 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000338")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000338)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000339 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000339")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000339)
	MisResultCondition(NoRecord, 688)
	MisResultCondition(HasMission, 688)
	MisResultCondition(HasFlag, 688, 19 )
	MisResultAction(ClearMission, 688)
	MisResultAction(SetRecord, 688)
	MisResultAction(AddExp, 1400, 1400)
	MisResultAction(AddMoney,316,316)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 281 )	
	TriggerAction( 1, AddNextFlag, 688, 10, 10 )
	RegCurTrigger( 6881 )

----------------------------------³ÍÖÎÑ©µØÀÇ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000340")
	DefineMission( 689, MISSCRIPT_MISSIONSCRIPT05_LUA_000340, 689 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000341 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000341")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000341)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 689)
	MisBeginCondition(NoRecord, 689)
	MisBeginAction(AddMission, 689)
	MisBeginAction(AddTrigger, 6891, TE_KILL, 137, 10 )
	MisCancelAction(ClearMission, 689)

	MisNeed(MIS_NEED_KILL, 137, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000342 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000342")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000342)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000343 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000343")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000343)
	MisResultCondition(NoRecord, 689)
	MisResultCondition(HasMission, 689)
	MisResultCondition(HasFlag, 689, 19 )
	MisResultAction(ClearMission, 689)
	MisResultAction(SetRecord, 689)
	MisResultAction(AddExp, 1600, 1600)
	MisResultAction(AddMoney,332,332)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 137 )	
	TriggerAction( 1, AddNextFlag, 689, 10, 10 )
	RegCurTrigger( 6891 )

-----------------------------------ÓªÑø¹êÜß¸à
	MISSCRIPT_MISSIONSCRIPT05_LUA_000344 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000344")
	DefineMission( 690, MISSCRIPT_MISSIONSCRIPT05_LUA_000344, 690 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000345")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000345)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 690)
	MisBeginCondition(NoRecord, 690)
	MisBeginAction(AddMission, 690)
	MisBeginAction(AddTrigger, 6901, TE_GETITEM, 4442, 5 )
	MisCancelAction(ClearMission, 690)

	MisNeed(MIS_NEED_ITEM, 4442, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000346 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000346")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000346)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000347 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000347")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000347)
	MisResultCondition(NoRecord, 690)
	MisResultCondition(HasMission, 690)
	MisResultCondition(HasItem, 4442, 5)
	MisResultAction(TakeItem, 4442, 5 )
	MisResultAction(ClearMission, 690)
	MisResultAction(SetRecord, 690)
	MisResultAction(AddExp, 1800, 1800)
	MisResultAction(AddMoney,697,697)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4442 )	
	TriggerAction( 1, AddNextFlag, 690, 10, 5 )
	RegCurTrigger( 6901 )

----------------------------------³¤±Ç×ÓÎÚ¹ê
	MISSCRIPT_MISSIONSCRIPT05_LUA_000348 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000348")
	DefineMission( 691, MISSCRIPT_MISSIONSCRIPT05_LUA_000348, 691 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000349 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000349")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000349)
	MisBeginCondition(LvCheck, ">", 23 )
	MisBeginCondition(NoMission, 691)
	MisBeginCondition(NoRecord, 691)
	MisBeginAction(AddMission, 691)
	MisBeginAction(AddTrigger, 6911, TE_KILL, 265, 10 )
	MisCancelAction(ClearMission, 691)

	MisNeed(MIS_NEED_KILL, 265, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000350")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000350)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000351 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000351")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000351)
	MisResultCondition(NoRecord, 691)
	MisResultCondition(HasMission, 691)
	MisResultCondition(HasFlag, 691, 19 )
	MisResultAction(ClearMission, 691)
	MisResultAction(SetRecord, 691)
	MisResultAction(AddExp, 1800, 1800)
	MisResultAction(AddMoney,348,348)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 265 )	
	TriggerAction( 1, AddNextFlag, 691, 10, 10 )
	RegCurTrigger( 6911 )

----------------------------------Ò°ÂùÓ²¼×Ð·
	MISSCRIPT_MISSIONSCRIPT05_LUA_000352 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000352")
	DefineMission( 692, MISSCRIPT_MISSIONSCRIPT05_LUA_000352, 692 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000353 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000353")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000353)
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 692)
	MisBeginCondition(NoRecord, 692)
	MisBeginAction(AddMission, 692)
	MisBeginAction(AddTrigger, 6921, TE_KILL, 143, 10 )
	MisCancelAction(ClearMission, 692)

	MisNeed(MIS_NEED_KILL, 143, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000354 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000354")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000354)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000355")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000355)
	MisResultCondition(NoRecord, 692)
	MisResultCondition(HasMission, 692)
	MisResultCondition(HasFlag, 692, 19 )
	MisResultAction(ClearMission, 692)
	MisResultAction(SetRecord, 692)
	MisResultAction(AddExp, 2000, 2000)
	MisResultAction(AddMoney,365,365)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 143 )	
	TriggerAction( 1, AddNextFlag, 692, 10, 10 )
	RegCurTrigger( 6921 )

-----------------------------------×ÔÖÆÐ·ÂÑ½´
	MISSCRIPT_MISSIONSCRIPT05_LUA_000356 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000356")
	DefineMission( 693, MISSCRIPT_MISSIONSCRIPT05_LUA_000356, 693 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000357 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000357")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000357)
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(NoMission, 693)
	MisBeginCondition(NoRecord, 693)
	MisBeginAction(AddMission, 693)
	MisBeginAction(AddTrigger, 6931, TE_GETITEM, 4107, 5 )
	MisCancelAction(ClearMission, 693)

	MisNeed(MIS_NEED_ITEM, 4107, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000358 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000358")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000358)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000359 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000359")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000359)
	MisResultCondition(NoRecord, 693)
	MisResultCondition(HasMission, 693)
	MisResultCondition(HasItem, 4107, 5)
	MisResultAction(TakeItem, 4107, 5 )
	MisResultAction(ClearMission, 693)
	MisResultAction(SetRecord, 693)
	MisResultAction(AddExp, 2000, 2000)
	MisResultAction(AddMoney,730,730)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4107 )	
	TriggerAction( 1, AddNextFlag, 693, 10, 5 )
	RegCurTrigger( 6931 )

-----------------------------------ÃÀÊ³×¨¼Ò
	MISSCRIPT_MISSIONSCRIPT05_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000360")
	DefineMission( 694, MISSCRIPT_MISSIONSCRIPT05_LUA_000360, 694 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000361 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000361")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000361)
	MisBeginCondition(LvCheck, ">", 25 )
	MisBeginCondition(NoMission, 694)
	MisBeginCondition(NoRecord, 694)
	MisBeginAction(AddMission, 694)
	MisBeginAction(AddTrigger, 6941, TE_GETITEM, 4464, 5 )
	MisCancelAction(ClearMission, 694)

	MisNeed(MIS_NEED_ITEM, 4464, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000362 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000362")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000362)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000363 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000363")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000363)
	MisResultCondition(NoRecord, 694)
	MisResultCondition(HasMission, 694)
	MisResultCondition(HasItem, 4464, 5)
	MisResultAction(TakeItem, 4464, 5 )
	MisResultAction(ClearMission, 694)
	MisResultAction(SetRecord, 694)
	MisResultAction(AddExp, 2400, 2400)
	MisResultAction(AddMoney,765,765)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4464 )	
	TriggerAction( 1, AddNextFlag, 694, 10, 5 )
	RegCurTrigger( 6941 )

-----------------------------------²É¼¯´¿¾»Ö®Áé
	MISSCRIPT_MISSIONSCRIPT05_LUA_000364 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000364")
	DefineMission( 695, MISSCRIPT_MISSIONSCRIPT05_LUA_000364, 695 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000365")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000365)
	MisBeginCondition(LvCheck, ">", 26 )
	MisBeginCondition(NoMission, 695)
	MisBeginCondition(NoRecord, 695)
	MisBeginAction(AddMission, 695)
	MisBeginAction(AddTrigger, 6951, TE_GETITEM, 4481, 5 )
	MisCancelAction(ClearMission, 695)

	MisNeed(MIS_NEED_ITEM, 4481, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000366 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000366")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000366)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000367 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000367")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000367)
	MisResultCondition(NoRecord, 695)
	MisResultCondition(HasMission, 695)
	MisResultCondition(HasItem, 4481, 5)
	MisResultAction(TakeItem, 4481, 5 )
	MisResultAction(ClearMission, 695)
	MisResultAction(SetRecord, 695)
	MisResultAction(AddExp, 2700, 2700)
	MisResultAction(AddMoney,800,800)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4481 )	
	TriggerAction( 1, AddNextFlag, 695, 10, 5 )
	RegCurTrigger( 6951 )

----------------------------------ÄÕÈËµÄÑ©ÍÞÍÞ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000368")
	DefineMission( 696, MISSCRIPT_MISSIONSCRIPT05_LUA_000368, 696 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000369 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000369")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000369)
	MisBeginCondition(LvCheck, ">", 27 )
	MisBeginCondition(NoMission, 696)
	MisBeginCondition(NoRecord, 696)
	MisBeginAction(AddMission, 696)
	MisBeginAction(AddTrigger, 6961, TE_KILL, 256, 10 )
	MisCancelAction(ClearMission, 696)

	MisNeed(MIS_NEED_KILL, 256, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000370 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000370")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000370)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000371")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000371)
	MisResultCondition(NoRecord, 696)
	MisResultCondition(HasMission, 696)
	MisResultCondition(HasFlag, 696, 19 )
	MisResultAction(ClearMission, 696)
	MisResultAction(SetRecord, 696)
	MisResultAction(AddExp, 3000, 3000)
	MisResultAction(AddMoney,417,417)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 256 )	
	TriggerAction( 1, AddNextFlag, 696, 10, 10 )
	RegCurTrigger( 6961 )

----------------------------------Ô­Ê¼Ñ©ÈË
	MISSCRIPT_MISSIONSCRIPT05_LUA_000372 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000372")
	DefineMission( 697, MISSCRIPT_MISSIONSCRIPT05_LUA_000372, 697 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000373 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000373")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000373)
	MisBeginCondition(LvCheck, ">", 28 )
	MisBeginCondition(NoMission, 697)
	MisBeginCondition(NoRecord, 697)
	MisBeginAction(AddMission, 697)
	MisBeginAction(AddTrigger, 6971, TE_KILL, 98, 10 )
	MisCancelAction(ClearMission, 697)

	MisNeed(MIS_NEED_KILL, 98, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000374 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000374")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000374)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000371")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000371)
	MisResultCondition(NoRecord, 697)
	MisResultCondition(HasMission, 697)
	MisResultCondition(HasFlag, 697, 19 )
	MisResultAction(ClearMission, 697)
	MisResultAction(SetRecord, 697)
	MisResultAction(AddExp, 3400, 3400)
	MisResultAction(AddMoney,424,424)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6711,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 98 )	
	TriggerAction( 1, AddNextFlag, 697, 10, 10 )
	RegCurTrigger( 6971 )

-----------------------------------Ê§×ÙÊÂ¼þ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000375 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000375")
	DefineMission( 698, MISSCRIPT_MISSIONSCRIPT05_LUA_000375, 698 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000376 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000376")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000376)
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(NoMission, 698)
	MisBeginCondition(NoRecord, 698)
	MisBeginAction(AddMission, 698)
	MisBeginAction(AddTrigger, 6981, TE_GETITEM, 4446, 5 )
	MisCancelAction(ClearMission, 698)

	MisNeed(MIS_NEED_ITEM, 4446, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000377 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000377")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000377)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000378 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000378")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000378)
	MisResultCondition(NoRecord, 698)
	MisResultCondition(HasMission, 698)
	MisResultCondition(HasItem, 4446, 5)
	MisResultAction(TakeItem, 4446, 5 )
	MisResultAction(ClearMission, 698)
	MisResultAction(SetRecord, 698)
	MisResultAction(AddExp, 3400, 3400)
	MisResultAction(AddMoney,849,849)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4446 )	
	TriggerAction( 1, AddNextFlag, 698, 10, 5 )
	RegCurTrigger( 6981 )

----------------------------------ÕùÇ¿ºÃÊ¤µÄÖí
	MISSCRIPT_MISSIONSCRIPT05_LUA_000379 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000379")
	DefineMission( 699, MISSCRIPT_MISSIONSCRIPT05_LUA_000379, 699 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000380 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000380")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000380)
	MisBeginCondition(LvCheck, ">", 30 )
	MisBeginCondition(NoMission, 699)
	MisBeginCondition(NoRecord, 699)
	MisBeginAction(AddMission, 699)
	MisBeginAction(AddTrigger, 6991, TE_KILL, 296, 10 )
	MisCancelAction(ClearMission, 699)

	MisNeed(MIS_NEED_KILL, 296, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000381")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000381)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000382 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000382")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000382)
	MisResultCondition(NoRecord, 699)
	MisResultCondition(HasMission, 699)
	MisResultCondition(HasFlag, 699, 19 )
	MisResultAction(ClearMission, 699)
	MisResultAction(SetRecord, 699)
	MisResultAction(AddExp, 3900, 3900)
	MisResultAction(AddMoney,431,431)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 296 )	
	TriggerAction( 1, AddNextFlag, 699, 10, 10 )
	RegCurTrigger( 6991 )

----------------------------------µ·¹íµÄÑ©ÍÞÍÞ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000383 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000383")
	DefineMission( 800, MISSCRIPT_MISSIONSCRIPT05_LUA_000383, 800 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000384 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000384")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000384)
	MisBeginCondition(LvCheck, ">", 32 )
	MisBeginCondition(NoMission, 800)
	MisBeginCondition(NoRecord, 800)
	MisBeginAction(AddMission, 800)
	MisBeginAction(AddTrigger, 8001, TE_KILL, 257, 10 )
	MisCancelAction(ClearMission, 800)

	MisNeed(MIS_NEED_KILL, 257, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000385 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000385")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000385)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000386 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000386")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000386)
	MisResultCondition(NoRecord, 800)
	MisResultCondition(HasMission, 800)
	MisResultCondition(HasFlag, 800, 19 )
	MisResultAction(ClearMission, 800)
	MisResultAction(SetRecord, 800)
	MisResultAction(AddExp, 4900, 4900)
	MisResultAction(AddMoney,446,446)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 257 )	
	TriggerAction( 1, AddNextFlag, 800, 10, 10 )
	RegCurTrigger( 8001 )

-----------------------------------Áé»ê±¦Ê¯
	MISSCRIPT_MISSIONSCRIPT05_LUA_000387 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000387")
	DefineMission( 801, MISSCRIPT_MISSIONSCRIPT05_LUA_000387, 801 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000388 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000388")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000388)
	MisBeginCondition(LvCheck, ">", 33 )
	MisBeginCondition(NoMission, 801)
	MisBeginCondition(NoRecord, 801)
	MisBeginAction(AddMission, 801)
	MisBeginAction(AddTrigger, 8011, TE_GETITEM, 4108, 5 )
	MisCancelAction(ClearMission, 801)

	MisNeed(MIS_NEED_ITEM, 4108, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000389 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000389")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000389)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000390 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000390")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000390)
	MisResultCondition(NoRecord, 801)
	MisResultCondition(HasMission, 801)
	MisResultCondition(HasItem, 4108, 5)
	MisResultAction(TakeItem, 4108, 5 )
	MisResultAction(ClearMission, 801)
	MisResultAction(SetRecord, 801)
	MisResultAction(AddExp, 5500, 5500)
	MisResultAction(AddMoney,907,907)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4108 )	
	TriggerAction( 1, AddNextFlag, 801, 10, 5 )
	RegCurTrigger( 8011 )

----------------------------------ÀÄÉ±ÎÞ¹¼
	MISSCRIPT_MISSIONSCRIPT05_LUA_000391 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000391")
	DefineMission( 802, MISSCRIPT_MISSIONSCRIPT05_LUA_000391, 802 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000392 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000392")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000392)
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(NoMission, 802)
	MisBeginCondition(NoRecord, 802)
	MisBeginAction(AddMission, 802)
	MisBeginAction(AddTrigger, 8021, TE_KILL, 141, 10 )
	MisCancelAction(ClearMission, 802)

	MisNeed(MIS_NEED_KILL, 141, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000393 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000393")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000393)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000394 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000394")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000394)
	MisResultCondition(NoRecord, 802)
	MisResultCondition(HasMission, 802)
	MisResultCondition(HasFlag, 802, 19 )
	MisResultAction(ClearMission, 802)
	MisResultAction(SetRecord, 802)
	MisResultAction(AddExp, 6200, 6200)
	MisResultAction(AddMoney,461,461)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 141 )	
	TriggerAction( 1, AddNextFlag, 802, 10, 10 )
	RegCurTrigger( 8021 )

-----------------------------------ÄÑÒÔÓúºÏµÄÉË¿Ú
	MISSCRIPT_MISSIONSCRIPT05_LUA_000395 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000395")
	DefineMission( 803, MISSCRIPT_MISSIONSCRIPT05_LUA_000395, 803 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000396 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000396")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000396)
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(NoMission, 803)
	MisBeginCondition(NoRecord, 803)
	MisBeginAction(AddMission, 803)
	MisBeginAction(AddTrigger, 8031, TE_GETITEM, 4468, 5 )
	MisCancelAction(ClearMission, 803)

	MisNeed(MIS_NEED_ITEM, 4468, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000397 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000397")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000397)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000398 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000398")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000398)
	MisResultCondition(NoRecord, 803)
	MisResultCondition(HasMission, 803)
	MisResultCondition(HasItem, 4468, 5)
	MisResultAction(TakeItem, 4468, 5 )
	MisResultAction(ClearMission, 803)
	MisResultAction(SetRecord, 803)
	MisResultAction(AddExp, 6900, 6900)
	MisResultAction(AddMoney,939,939)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4468 )	
	TriggerAction( 1, AddNextFlag, 803, 10, 5 )
	RegCurTrigger( 8031 )

----------------------------------¶éÂäÖ®Ñò
	MISSCRIPT_MISSIONSCRIPT05_LUA_000399 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000399")
	DefineMission( 804, MISSCRIPT_MISSIONSCRIPT05_LUA_000399, 804 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000400 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000400")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000400)
	MisBeginCondition(LvCheck, ">", 36 )
	MisBeginCondition(NoMission, 804)
	MisBeginCondition(NoRecord, 804)
	MisBeginAction(AddMission, 804)
	MisBeginAction(AddTrigger, 8041, TE_KILL, 297, 10 )
	MisCancelAction(ClearMission, 804)

	MisNeed(MIS_NEED_KILL, 297, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000401 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000401")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000401)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000402 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000402")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000402)
	MisResultCondition(NoRecord, 804)
	MisResultCondition(HasMission, 804)
	MisResultCondition(HasFlag, 804, 19 )
	MisResultAction(ClearMission, 804)
	MisResultAction(SetRecord, 804)
	MisResultAction(AddExp, 7700, 7700)
	MisResultAction(AddMoney,477,477)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 297 )	
	TriggerAction( 1, AddNextFlag, 804, 10, 10 )
	RegCurTrigger( 8041 )

-----------------------------------ÃÍÐ«Ö®¶¾
	MISSCRIPT_MISSIONSCRIPT05_LUA_000403 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000403")
	DefineMission( 805, MISSCRIPT_MISSIONSCRIPT05_LUA_000403, 805 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000404 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000404")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000404)
	MisBeginCondition(LvCheck, ">", 37 )
	MisBeginCondition(NoMission, 805)
	MisBeginCondition(NoRecord, 805)
	MisBeginAction(AddMission, 805)
	MisBeginAction(AddTrigger, 8051, TE_GETITEM, 4482, 5 )
	MisCancelAction(ClearMission, 805)

	MisNeed(MIS_NEED_ITEM, 4482, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000405 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000405")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000405)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000406 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000406")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000406)
	MisResultCondition(NoRecord, 805)
	MisResultCondition(HasMission, 805)
	MisResultCondition(HasItem, 4482, 5)
	MisResultAction(TakeItem, 4482, 5 )
	MisResultAction(ClearMission, 805)
	MisResultAction(SetRecord, 805)
	MisResultAction(AddExp, 8600, 8600)
	MisResultAction(AddMoney,972,972)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4482 )	
	TriggerAction( 1, AddNextFlag, 805, 10, 5 )
	RegCurTrigger( 8051 )

----------------------------------¿ªÂ·ÏÈ·æ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000407")
	DefineMission( 806, MISSCRIPT_MISSIONSCRIPT05_LUA_000407, 806 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000408 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000408")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000408)
	MisBeginCondition(LvCheck, ">", 38 )
	MisBeginCondition(NoMission, 806)
	MisBeginCondition(NoRecord, 806)
	MisBeginAction(AddMission, 806)
	MisBeginAction(AddTrigger, 8061, TE_KILL, 259, 10 )
	MisCancelAction(ClearMission, 806)

	MisNeed(MIS_NEED_KILL, 259, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000409 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000409")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000409)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000410 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000410")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000410)
	MisResultCondition(NoRecord, 806)
	MisResultCondition(HasMission, 806)
	MisResultCondition(HasFlag, 806, 19 )
	MisResultAction(ClearMission, 806)
	MisResultAction(SetRecord, 806)
	MisResultAction(AddExp, 9600, 9600)
	MisResultAction(AddMoney,495,495)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 259 )	
	TriggerAction( 1, AddNextFlag, 806, 10, 10 )
	RegCurTrigger( 8061 )

-----------------------------------Ñ©Ó°½£
	MISSCRIPT_MISSIONSCRIPT05_LUA_000411 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000411")
	DefineMission( 807, MISSCRIPT_MISSIONSCRIPT05_LUA_000411, 807 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000412 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000412")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000412)
	MisBeginCondition(LvCheck, ">", 38 )
	MisBeginCondition(NoMission, 807)
	MisBeginCondition(NoRecord, 807)
	MisBeginAction(AddMission, 807)
	MisBeginAction(AddTrigger, 8071, TE_GETITEM, 4109, 1 )
	MisCancelAction(ClearMission, 807)

	MisNeed(MIS_NEED_ITEM, 4109, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000413 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000413")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000413)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000414")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000414)
	MisResultCondition(NoRecord, 807)
	MisResultCondition(HasMission, 807)
	MisResultCondition(HasItem, 4109, 1)
	MisResultAction(TakeItem, 4109, 1 )
	MisResultAction(ClearMission, 807)
	MisResultAction(SetRecord, 807)
	MisResultAction(AddExp, 9600, 9600)
	MisResultAction(AddMoney,495,495)
	MisResultAction(GiveItem,6945,1,4)
	MisResultBagNeed(1)
	InitTrigger()
	TriggerCondition( 1, IsItem, 4109 )	
	TriggerAction( 1, AddNextFlag, 807, 10, 1 )
	RegCurTrigger( 8071 )

----------------------------------ÎäÊ¿Íö»ê
	MISSCRIPT_MISSIONSCRIPT05_LUA_000415 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000415")
	DefineMission( 808, MISSCRIPT_MISSIONSCRIPT05_LUA_000415, 808 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000416 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000416")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000416)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(NoMission, 808)
	MisBeginCondition(NoRecord, 808)
	MisBeginAction(AddMission, 808)
	MisBeginAction(AddTrigger, 8081, TE_KILL, 268, 10 )
	MisCancelAction(ClearMission, 808)

	MisNeed(MIS_NEED_KILL, 268, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000417 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000417")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000417)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000418")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000418)
	MisResultCondition(NoRecord, 808)
	MisResultCondition(HasMission, 808)
	MisResultCondition(HasFlag, 808, 19 )
	MisResultAction(ClearMission, 808)
	MisResultAction(SetRecord, 808)
	MisResultAction(AddExp, 10600, 10600)
	MisResultAction(AddMoney,504,504)
	MisResultBagNeed(1)
	MisResultAction(GiveItem,6945,1,4)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 268 )	
	TriggerAction( 1, AddNextFlag, 808, 10, 10 )
	RegCurTrigger( 8081 )

----------------------------------ÎüÑªµÄ¹ÖÎï
	MISSCRIPT_MISSIONSCRIPT05_LUA_000419 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000419")
	DefineMission( 809, MISSCRIPT_MISSIONSCRIPT05_LUA_000419, 809 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000420 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000420")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000420)
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(NoMission, 809)
	MisBeginCondition(NoRecord, 809)
	MisBeginAction(AddMission, 809)
	MisBeginAction(AddTrigger, 8091, TE_KILL, 82, 10 )
	MisCancelAction(ClearMission, 809)

	MisNeed(MIS_NEED_KILL, 82, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000421 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000421")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000421)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000422 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000422")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000422)
	MisResultCondition(NoRecord, 809)
	MisResultCondition(HasMission, 809)
	MisResultCondition(HasFlag, 809, 19 )
	MisResultAction(ClearMission, 809)
	MisResultAction(SetRecord, 809)
	MisResultAction(AddExp, 3500, 3500)
	MisResultAction(AddMoney,424,424)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 82 )	
	TriggerAction( 1, AddNextFlag, 809, 10, 10 )
	RegCurTrigger( 8091 )

-----------------------------------÷úÊóµÄ°²È«Ã±
	HELP_MONSTERHELP_LUA_001262 = GetResString("HELP_MONSTERHELP_LUA_001262")
	DefineMission( 810, HELP_MONSTERHELP_LUA_001262, 810 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000423 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000423")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000423)
	MisBeginCondition(LvCheck, ">", 32 )
	MisBeginCondition(NoMission, 810)
	MisBeginCondition(NoRecord, 810)
	MisBeginAction(AddMission, 810)
	MisBeginAction(AddTrigger, 8101, TE_GETITEM, 4448, 2 )
	MisCancelAction(ClearMission, 810)

	MisNeed(MIS_NEED_ITEM, 4448, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000424 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000424")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000424)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000425 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000425")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000425)
	MisResultCondition(NoRecord, 810)
	MisResultCondition(HasMission, 810)
	MisResultCondition(HasItem, 4448, 2)
	MisResultAction(TakeItem, 4448, 2 )
	MisResultAction(ClearMission, 810)
	MisResultAction(SetRecord, 810)
	MisResultAction(AddExp, 4900, 4900)
	MisResultAction(AddMoney,892,892)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4448 )	
	TriggerAction( 1, AddNextFlag, 810, 10, 2 )
	RegCurTrigger( 8101 )


-----------------------------------ÆæÒìµÄÄà½¬
	MISSCRIPT_MISSIONSCRIPT05_LUA_000426 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000426")
	DefineMission( 811, MISSCRIPT_MISSIONSCRIPT05_LUA_000426, 811 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000427 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000427")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000427)
	MisBeginCondition(LvCheck, ">", 33 )
	MisBeginCondition(NoMission, 811)
	MisBeginCondition(NoRecord, 811)
	MisBeginAction(AddMission, 811)
	MisBeginAction(AddTrigger, 8111, TE_GETITEM, 4363, 5 )
	MisCancelAction(ClearMission, 811)

	MisNeed(MIS_NEED_ITEM, 4363, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000428 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000428")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000428)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000429 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000429")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000429)
	MisResultCondition(NoRecord, 811)
	MisResultCondition(HasMission, 811)
	MisResultCondition(HasItem, 4363, 5)
	MisResultAction(TakeItem, 4363, 5 )
	MisResultAction(ClearMission, 811)
	MisResultAction(SetRecord, 811)
	MisResultAction(AddExp, 5500, 5500)
	MisResultAction(AddMoney,907,907)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4363 )	
	TriggerAction( 1, AddNextFlag, 811, 10, 5 )
	RegCurTrigger( 8111 )

----------------------------------±¨¸´Äà½¬¹Ö
	MISSCRIPT_MISSIONSCRIPT05_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000430")
	DefineMission( 812, MISSCRIPT_MISSIONSCRIPT05_LUA_000430, 812 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000431 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000431")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000431)
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(NoMission, 812)
	MisBeginCondition(NoRecord, 812)
	MisBeginAction(AddMission, 812)
	MisBeginAction(AddTrigger, 8121, TE_KILL, 253, 10 )
	MisCancelAction(ClearMission, 812)

	MisNeed(MIS_NEED_KILL, 253, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000432 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000432")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000432)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000433 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000433")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000433)
	MisResultCondition(NoRecord, 812)
	MisResultCondition(HasMission, 812)
	MisResultCondition(HasFlag, 812, 19 )
	MisResultAction(ClearMission, 812)
	MisResultAction(SetRecord, 812)
	MisResultAction(AddExp, 6200, 6200)
	MisResultAction(AddMoney,461,461)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 253 )	
	TriggerAction( 1, AddNextFlag, 812, 10, 10 )
	RegCurTrigger( 8121 )


----------------------------------Ìú×¦÷úÊó
	MISSCRIPT_MISSIONSCRIPT05_LUA_000434 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000434")
	DefineMission( 813, MISSCRIPT_MISSIONSCRIPT05_LUA_000434, 813 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000435 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000435")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000435)
	MisBeginCondition(LvCheck, ">", 35 )
	MisBeginCondition(NoMission, 813)
	MisBeginCondition(NoRecord, 813)
	MisBeginAction(AddMission, 813)
	MisBeginAction(AddTrigger, 8131, TE_KILL, 88, 10 )
	MisCancelAction(ClearMission, 813)

	MisNeed(MIS_NEED_KILL, 88, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000436 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000436")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000436)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000437 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000437")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000437)
	MisResultCondition(NoRecord, 813)
	MisResultCondition(HasMission, 813)
	MisResultCondition(HasFlag, 813, 19 )
	MisResultAction(ClearMission, 813)
	MisResultAction(SetRecord, 813)
	MisResultAction(AddExp, 6900, 6900)
	MisResultAction(AddMoney,469,469)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 88 )	
	TriggerAction( 1, AddNextFlag, 813, 10, 10 )
	RegCurTrigger( 8131 )

-----------------------------------ÈÌÕßÊÖÀï½£
	HELP_MONSTERHELP_LUA_001275 = GetResString("HELP_MONSTERHELP_LUA_001275")
	DefineMission( 814, HELP_MONSTERHELP_LUA_001275, 814 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000438 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000438")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000438)
	MisBeginCondition(LvCheck, ">", 33 )
	MisBeginCondition(NoMission, 814)
	MisBeginCondition(NoRecord, 814)
	MisBeginAction(AddMission, 814)
	MisBeginAction(AddTrigger, 8141, TE_GETITEM, 3935, 10 )
	MisCancelAction(ClearMission, 814)

	MisNeed(MIS_NEED_ITEM, 3935, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000439 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000439")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000439)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000440 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000440")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000440)
	MisResultCondition(NoRecord, 814)
	MisResultCondition(HasMission, 814)
	MisResultCondition(HasItem, 3935, 10)
	MisResultAction(TakeItem, 3935, 10 )
	MisResultAction(ClearMission, 814)
	MisResultAction(SetRecord, 814)
	MisResultAction(AddExp, 8600, 8600)
	MisResultAction(AddMoney,972,972)


	InitTrigger()
	TriggerCondition( 1, IsItem, 3935 )	
	TriggerAction( 1, AddNextFlag, 814, 10, 10 )
	RegCurTrigger( 8141 )

-----------------------------------¿¼Ñé
	MISSCRIPT_MISSIONSCRIPT05_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000441")
	DefineMission( 837, MISSCRIPT_MISSIONSCRIPT05_LUA_000441, 837 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000442 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000442")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000442)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(NoMission, 837)
	MisBeginCondition(NoRecord, 837)
	MisBeginAction(AddMission, 837)
	MisBeginAction(AddTrigger, 8371, TE_KILL, 248, 5 )
	MisCancelAction(ClearMission, 837)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000443 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000443")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000443)
	MisNeed(MIS_NEED_KILL, 248, 5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000444 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000444")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000444)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000445 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000445")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000445)
	MisResultCondition(NoRecord, 837)
	MisResultCondition(HasMission, 837)
	MisResultCondition(HasFlag, 837, 14)
	MisResultAction(ClearMission, 837)
	MisResultAction(SetRecord, 837)
	MisResultAction(AddExp,15692,15692)
	MisResultAction(AddMoney,1026,1026)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 248 )	
	TriggerAction( 1, AddNextFlag, 837, 10, 5 )
	RegCurTrigger( 8371 )


-----------------------------------¿¼Ñé
	MISSCRIPT_MISSIONSCRIPT05_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000441")
	DefineMission( 838, MISSCRIPT_MISSIONSCRIPT05_LUA_000441, 838 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000446 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000446")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000446)
	--MisBeginCondition(LvCheck, ">", 40 )
	MisBeginCondition(HasRecord, 837)
	MisBeginCondition(NoMission, 838)
	MisBeginCondition(NoRecord, 838)
	MisBeginAction(AddMission, 838)
	MisBeginAction(AddTrigger, 8381, TE_KILL, 248, 30 )
	MisCancelAction(ClearMission, 838)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000447 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000447")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000447)
	MisNeed(MIS_NEED_KILL, 248, 30, 10, 30)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000448 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000448")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000448)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000449 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000449")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000449)
	MisResultCondition(NoRecord, 838)
	MisResultCondition(HasMission, 838)
	MisResultCondition(HasFlag, 838, 39)
	MisResultAction(ClearMission, 838)
	MisResultAction(SetRecord, 838)
	MisResultAction(AddExp,15692,15692)
	MisResultAction(AddMoney,1026,1026)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 248 )	
	TriggerAction( 1, AddNextFlag, 838, 10, 30 )
	RegCurTrigger( 8381 )


-----------------------------------ÕæÕýµÄÄ¿µÄ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000450 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000450")
	DefineMission( 839, MISSCRIPT_MISSIONSCRIPT05_LUA_000450, 839 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000451")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000451)
	--MisBeginCondition(LvCheck, ">", 40 )
	MisBeginCondition(HasRecord, 838)
	MisBeginCondition(NoMission, 839)
	MisBeginCondition(NoRecord, 839)
	MisBeginAction(AddMission, 839)
	MisBeginAction(AddTrigger, 8391, TE_GETITEM, 4914, 12 )
	MisCancelAction(ClearMission, 839)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000452 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000452")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000452)
	MisNeed(MIS_NEED_ITEM, 4914, 12, 10, 12)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000453 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000453")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000453)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000454 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000454")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000454)
	MisResultCondition(NoRecord, 839)
	MisResultCondition(HasMission, 839)
	MisResultCondition(HasItem, 4914, 12)
	MisResultAction(TakeItem, 4914, 12)
	MisResultAction(ClearMission, 839)
	MisResultAction(SetRecord, 839)
	MisResultAction(AddExp,15692,15692)
	MisResultAction(AddMoney,1026,1026)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4914 )	
	TriggerAction( 1, AddNextFlag, 839, 10, 12 )
	RegCurTrigger( 8391 )



-----------------------------------¸ùµñ°®ºÃÕß
	MISSCRIPT_MISSIONSCRIPT05_LUA_000455 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000455")
	DefineMission( 840, MISSCRIPT_MISSIONSCRIPT05_LUA_000455, 840 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000456 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000456")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000456)
	MisBeginCondition(LvCheck, ">", 42 )
	--MisBeginCondition(HasRecord, 838)
	MisBeginCondition(NoMission, 840)
	MisBeginCondition(NoRecord, 840)
	MisBeginAction(AddMission, 840)
	MisBeginAction(AddTrigger, 8401, TE_GETITEM, 4915, 5 )
	MisCancelAction(ClearMission, 840)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000457 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000457")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000457)
	MisNeed(MIS_NEED_ITEM, 4915, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000458")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000458)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000459 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000459")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000459)
	MisResultCondition(NoRecord, 840)
	MisResultCondition(HasMission, 840)
	MisResultCondition(HasItem, 4915, 5)
	MisResultAction(TakeItem, 4915, 5)
	MisResultAction(ClearMission, 840)
	MisResultAction(SetRecord, 840)
	MisResultAction(AddExp,19294,19294)	
	MisResultAction(AddMoney,1064,1064)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4915 )	
	TriggerAction( 1, AddNextFlag, 840, 10, 5 )
	RegCurTrigger( 8401 )

-----------------------------------²ÉÑù
	MISSCRIPT_MISSIONSCRIPT05_LUA_000460 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000460")
	DefineMission( 841, MISSCRIPT_MISSIONSCRIPT05_LUA_000460, 841 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000461 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000461")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000461)
	--MisBeginCondition(LvCheck, ">", 42 )
	MisBeginCondition(HasRecord, 844)
	MisBeginCondition(NoMission, 841)
	MisBeginCondition(NoRecord, 841)
	MisBeginAction(AddMission, 841)
	MisBeginAction(AddTrigger, 8411, TE_GETITEM, 4915, 1 )
	MisBeginAction(AddTrigger, 8412, TE_KILL, 107, 5 )
	MisCancelAction(ClearMission, 841)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000462")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000462)
	MisNeed(MIS_NEED_ITEM, 4915, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 107, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000463 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000463")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000463)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000464 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000464")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000464)
	MisResultCondition(NoRecord, 841)
	MisResultCondition(HasMission, 841)
	MisResultCondition(HasItem, 4915, 1)
	MisResultCondition(HasFlag, 841, 14)
	MisResultAction(TakeItem, 4915, 1)
	MisResultAction(ClearMission, 841)
	MisResultAction(SetRecord, 841)
	MisResultAction(AddExp,19294,19294)
	MisResultAction(AddMoney,1064,1064)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4915 )	
	TriggerAction( 1, AddNextFlag, 841, 20, 1 )
	RegCurTrigger( 8411 )
	InitTrigger()
	TriggerCondition( 1, IsMonster,	107 )	
	TriggerAction( 1, AddNextFlag, 841, 10, 5 )
	RegCurTrigger( 8412 )

-----------------------------------²»ÃðµÄÀ¯Öò
	MISSCRIPT_MISSIONSCRIPT05_LUA_000465 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000465")
	DefineMission( 842, MISSCRIPT_MISSIONSCRIPT05_LUA_000465, 842 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000466 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000466")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000466)
	--MisBeginCondition(LvCheck, ">", 42 )
	MisBeginCondition(HasRecord, 841)
	MisBeginCondition(NoMission, 842)
	MisBeginCondition(NoRecord, 842)
	MisBeginAction(AddMission, 842)
	MisBeginAction(AddTrigger, 8421, TE_GETITEM, 4915, 15 )
	MisCancelAction(ClearMission, 842)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000467 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000467")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000467)
	MisNeed(MIS_NEED_ITEM, 4915, 15, 10, 15)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000468 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000468")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000468)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000469 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000469")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000469)
	MisResultCondition(NoRecord, 842)
	MisResultCondition(HasMission, 842)
	MisResultCondition(HasItem, 4915, 15)
	MisResultAction(TakeItem, 4915, 15)
	MisResultAction(ClearMission, 842)
	MisResultAction(SetRecord, 842)
	MisResultAction(AddExp,19294,19294)	
	MisResultAction(AddMoney,1064,1064)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4915 )	
	TriggerAction( 1, AddNextFlag, 842, 10, 15 )
	RegCurTrigger( 8421 )

-----------------------------------ºÚÉ«¹ÖÊÞ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000470 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000470")
	DefineMission( 843, MISSCRIPT_MISSIONSCRIPT05_LUA_000470, 843 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000471 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000471")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000471)
	MisBeginCondition(LvCheck, ">", 42 )
	--MisBeginCondition(HasRecord, 844)
	MisBeginCondition(NoMission, 843)
	MisBeginCondition(NoRecord, 843)
	MisBeginAction(AddMission, 843)
	MisBeginAction(AddTrigger, 8431, TE_GETITEM, 4823, 1 )
	MisBeginAction(AddTrigger, 8432, TE_KILL, 503, 5 )
	MisCancelAction(ClearMission, 843)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000472 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000472")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000472)
	MisNeed(MIS_NEED_ITEM, 4823, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 503, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000473 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000473")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000473)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000474 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000474")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000474)
	MisResultCondition(NoRecord, 843)
	MisResultCondition(HasMission, 843)
	MisResultCondition(HasItem, 4823, 1)
	MisResultCondition(HasFlag, 843, 14)
	MisResultAction(TakeItem, 4823, 1)
	MisResultAction(ClearMission, 843)
	MisResultAction(SetRecord, 843)
	MisResultAction(AddExp,19294,19294)
	MisResultAction(AddMoney,1064,1064)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4823 )	
	TriggerAction( 1, AddNextFlag, 843, 20, 1 )
	RegCurTrigger( 8431 )
	InitTrigger()
	TriggerCondition( 1, IsMonster,	503 )	
	TriggerAction( 1, AddNextFlag, 843, 10, 5 )
	RegCurTrigger( 8432 )

-----------------------------------À¯ÖòÑÐ¾¿
	MISSCRIPT_MISSIONSCRIPT05_LUA_000475 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000475")
	DefineMission( 844, MISSCRIPT_MISSIONSCRIPT05_LUA_000475, 844 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000476 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000476")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000476)
	--MisBeginCondition(LvCheck, ">", 42 )
	MisBeginCondition(HasRecord, 843)
	MisBeginCondition(NoMission, 844)
	MisBeginCondition(NoRecord, 844)
	MisBeginAction(AddMission, 844)
	MisBeginAction(AddTrigger, 8441, TE_GETITEM, 4823, 10 )
	MisCancelAction(ClearMission, 844)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000477 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000477")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000477)
	MisNeed(MIS_NEED_ITEM, 4823, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000478 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000478")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000478)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000479 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000479")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000479)
	MisResultCondition(NoRecord, 844)
	MisResultCondition(HasMission, 844)
	MisResultCondition(HasItem, 4823, 10)
	MisResultAction(TakeItem, 4823, 10)
	MisResultAction(ClearMission, 844)
	MisResultAction(SetRecord, 844)
	MisResultAction(AddExp,19294,19294)
	MisResultAction(AddMoney,1064,1064)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4823 )	
	TriggerAction( 1, AddNextFlag, 844, 10, 10 )
	RegCurTrigger( 8441 )


-----------------------------------ÑÒÊ¯¹Ö
	HELP_MONSTERHELP_LUA_000195 = GetResString("HELP_MONSTERHELP_LUA_000195")
	DefineMission( 845, HELP_MONSTERHELP_LUA_000195, 845 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000480 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000480")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000480)
	MisBeginCondition(LvCheck, ">", 45 )
	--MisBeginCondition(HasRecord, 844)
	MisBeginCondition(NoMission, 845)
	MisBeginCondition(NoRecord, 845)
	MisBeginAction(AddMission, 845)
	MisBeginAction(AddTrigger, 8451, TE_GETITEM, 4825, 1 )
	MisBeginAction(AddTrigger, 8452, TE_KILL, 505, 5 )
	MisCancelAction(ClearMission, 845)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000481 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000481")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000481)
	MisNeed(MIS_NEED_ITEM, 4825, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 505, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000482 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000482")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000482)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000483 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000483")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000483)
	MisResultCondition(NoRecord, 845)
	MisResultCondition(HasMission, 845)
	MisResultCondition(HasItem, 4825, 1)
	MisResultCondition(HasFlag, 845, 14)
	MisResultAction(TakeItem, 4825, 1)
	MisResultAction(ClearMission, 845)
	MisResultAction(SetRecord, 845)
	MisResultAction(AddExp,26112,26112)	
	MisResultAction(AddMoney,1125,1125)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4825 )	
	TriggerAction( 1, AddNextFlag, 845, 20, 1 )
	RegCurTrigger( 8451 )
	InitTrigger()
	TriggerCondition( 1, IsMonster,	505 )	
	TriggerAction( 1, AddNextFlag, 845, 10, 5 )
	RegCurTrigger( 8452 )

-----------------------------------Î¢¹âÊ¯Í·µÄÑÐ¾¿
	MISSCRIPT_MISSIONSCRIPT05_LUA_000484 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000484")
	DefineMission( 846, MISSCRIPT_MISSIONSCRIPT05_LUA_000484, 846 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000485 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000485")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000485)
	--MisBeginCondition(LvCheck, ">", 42 )
	MisBeginCondition(HasRecord, 845)
	MisBeginCondition(NoMission, 846)
	MisBeginCondition(NoRecord, 846)
	MisBeginAction(AddMission, 846)
	MisBeginAction(AddTrigger, 8461, TE_GETITEM, 4825, 6 )
	MisCancelAction(ClearMission, 846)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000486 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000486")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000486)
	MisNeed(MIS_NEED_ITEM, 4825, 6, 10, 6)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000487 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000487")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000487)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000488 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000488")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000488)
	MisResultCondition(NoRecord, 846)
	MisResultCondition(HasMission, 846)
	MisResultCondition(HasItem, 4825, 6)
	MisResultAction(TakeItem, 4825, 6)
	MisResultAction(ClearMission, 846)
	MisResultAction(SetRecord, 846)
	MisResultAction(AddExp,26112,26112)	
	MisResultAction(AddMoney,1125,1125)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4825 )	
	TriggerAction( 1, AddNextFlag, 846, 10, 6 )
	RegCurTrigger( 8461 )


-----------------------------------ÑéÖ¤
	MISSCRIPT_MISSIONSCRIPT05_LUA_000489 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000489")
	DefineMission( 847, MISSCRIPT_MISSIONSCRIPT05_LUA_000489, 847 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000490")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000490)
	--MisBeginCondition(LvCheck, ">", 45 )
	MisBeginCondition(HasRecord, 846)
	MisBeginCondition(NoMission, 847)
	MisBeginCondition(NoRecord, 847)
	MisBeginAction(AddMission, 847)
	MisBeginAction(AddTrigger, 8471, TE_GETITEM, 4917, 1 )
	MisBeginAction(AddTrigger, 8472, TE_KILL, 267, 5 )
	MisCancelAction(ClearMission, 847)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000491 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000491")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000491)
	MisNeed(MIS_NEED_ITEM, 4917, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 267, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000492 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000492")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000492)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000493 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000493")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000493)
	MisResultCondition(NoRecord, 847)
	MisResultCondition(HasMission, 847)
	MisResultCondition(HasItem, 4917, 1)
	MisResultCondition(HasFlag, 847, 14)
	MisResultAction(TakeItem, 4917, 1)
	MisResultAction(ClearMission, 847)
	MisResultAction(SetRecord, 847)
	MisResultAction(AddExp,28832,28832)
	MisResultAction(AddMoney,1146,1146)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4917 )	
	TriggerAction( 1, AddNextFlag, 847, 20, 1 )
	RegCurTrigger( 8471 )
	InitTrigger()
	TriggerCondition( 1, IsMonster,	267 )	
	TriggerAction( 1, AddNextFlag, 847, 10, 5 )
	RegCurTrigger( 8472 )


-----------------------------------²»ÃðÍ·¿ø
	HELP_MONSTERHELP_LUA_001328 = GetResString("HELP_MONSTERHELP_LUA_001328")
	DefineMission( 848, HELP_MONSTERHELP_LUA_001328, 848 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000494 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000494")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000494)
	--MisBeginCondition(LvCheck, ">", 42 )
	MisBeginCondition(HasRecord, 847)
	MisBeginCondition(NoMission, 848)
	MisBeginCondition(NoRecord, 848)
	MisBeginAction(AddMission, 848)
	MisBeginAction(AddTrigger, 8481, TE_GETITEM, 4917, 10 )
	MisCancelAction(ClearMission, 848)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000495")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000495)
	MisNeed(MIS_NEED_ITEM, 4917, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000496 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000496")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000496)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000497 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000497")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000497)
	MisResultCondition(NoRecord, 848)
	MisResultCondition(HasMission, 848)
	MisResultCondition(HasItem, 4917, 10)
	MisResultAction(TakeItem, 4917, 10)
	MisResultAction(ClearMission, 848)
	MisResultAction(SetRecord, 848)
	MisResultAction(AddExp,28832,28832)
	MisResultAction(AddMoney,1146,1146)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4917 )	
	TriggerAction( 1, AddNextFlag, 848, 10, 10 )
	RegCurTrigger( 8481 )

-----------------------------------Íß½â
	MISSCRIPT_MISSIONSCRIPT05_LUA_000498 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000498")
	DefineMission( 849, MISSCRIPT_MISSIONSCRIPT05_LUA_000498, 849 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000499 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000499")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000499)
	MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(NoMission, 849)
	MisBeginCondition(NoRecord, 849)
	MisBeginAction(AddMission, 849)
	MisBeginAction(AddTrigger, 8491, TE_KILL, 513, 20 )
	MisCancelAction(ClearMission, 849)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000500 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000500")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000500)
	MisNeed(MIS_NEED_KILL, 513, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000501 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000501")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000501)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000502 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000502")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000502)
	MisResultCondition(NoRecord, 849)
	MisResultCondition(HasMission, 849)
	MisResultCondition(HasFlag, 849, 29)
	MisResultAction(ClearMission, 849)
	MisResultAction(SetRecord, 849)
	MisResultAction(AddExp,31809,31809)
	MisResultAction(AddMoney,1167,1167)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 513 )	
	TriggerAction( 1, AddNextFlag, 849, 10, 20 )
	RegCurTrigger( 8491 )

-----------------------------------ÑªÐÈµÄ´¸×Ó
	HELP_MONSTERHELP_LUA_001329 = GetResString("HELP_MONSTERHELP_LUA_001329")
	DefineMission( 850, HELP_MONSTERHELP_LUA_001329, 850 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000503 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000503")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000503)
	MisBeginCondition(LvCheck, ">", 48 )
	--MisBeginCondition(HasRecord, 847)
	MisBeginCondition(NoMission, 850)
	MisBeginCondition(NoRecord, 850)
	MisBeginAction(AddMission, 850)
	MisBeginAction(AddTrigger, 8501, TE_GETITEM, 4833, 10 )
	MisCancelAction(ClearMission, 850)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000504 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000504")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000504)
	MisNeed(MIS_NEED_ITEM, 4833, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000505")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000505)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000506 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000506")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000506)
	MisResultCondition(NoRecord, 850)
	MisResultCondition(HasMission, 850)
	MisResultCondition(HasItem, 4833, 10)
	MisResultAction(TakeItem, 4833, 10)
	MisResultAction(ClearMission, 850)
	MisResultAction(SetRecord, 850)
	MisResultAction(AddExp,35066,35066)	
	MisResultAction(AddMoney,1189,1189)



	InitTrigger()
	TriggerCondition( 1, IsItem, 4833 )	
	TriggerAction( 1, AddNextFlag, 850, 10, 10 )
	RegCurTrigger( 8501 )


-----------------------------------µÚÒ»ÖÖÔ­ÁÏ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000507 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000507")
	DefineMission( 851, MISSCRIPT_MISSIONSCRIPT05_LUA_000507, 851 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000508 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000508")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000508)
	MisBeginCondition(LvCheck, ">", 47 )
	--MisBeginCondition(HasRecord, 847)
	MisBeginCondition(NoMission, 851)
	MisBeginCondition(NoRecord, 851)
	MisBeginAction(AddMission, 851)
	MisBeginAction(AddTrigger, 8511, TE_GETITEM, 4883, 8 )
	MisCancelAction(ClearMission, 851)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000509 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000509")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000509)
	MisNeed(MIS_NEED_ITEM, 4883, 8, 10, 8)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000510 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000510")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000510)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000511 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000511")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000511)
	MisResultCondition(NoRecord, 851)
	MisResultCondition(HasMission, 851)
	MisResultCondition(HasItem, 4883, 8)
	MisResultAction(TakeItem, 4883, 8)
	MisResultAction(ClearMission, 851)
	MisResultAction(SetRecord, 851)
	MisResultAction(AddExp,31809,31809)	
	MisResultAction(AddMoney,1167,1167)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4883 )	
	TriggerAction( 1, AddNextFlag, 851, 10, 8 )
	RegCurTrigger( 8511 )

-----------------------------------¸´³ð
	MISSCRIPT_MISSIONSCRIPT05_LUA_000512 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000512")
	DefineMission( 852, MISSCRIPT_MISSIONSCRIPT05_LUA_000512, 852 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000513 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000513")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000513)
	MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(NoMission, 852)
	MisBeginCondition(NoRecord, 852)
	MisBeginAction(AddMission, 852)
	MisBeginAction(AddTrigger, 8521, TE_KILL, 41, 15 )
	MisCancelAction(ClearMission, 852)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000514 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000514")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000514)
	MisNeed(MIS_NEED_KILL, 41, 15, 10, 15)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000515 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000515")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000515)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000516 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000516")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000516)
	MisResultCondition(NoRecord, 852)
	MisResultCondition(HasMission, 852)
	MisResultCondition(HasFlag, 852, 24)
	MisResultAction(ClearMission, 852)
	MisResultAction(SetRecord, 852)
	MisResultAction(AddExp,31809,31809)	
	MisResultAction(AddMoney,1167,1167)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 41 )	
	TriggerAction( 1, AddNextFlag, 852, 10, 15 )
	RegCurTrigger( 8521 )

-----------------------------------µÚÈýÖÖÔ­ÁÏ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000517 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000517")
	DefineMission( 853, MISSCRIPT_MISSIONSCRIPT05_LUA_000517, 853 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000518 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000518")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000518)
	--MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(HasRecord, 854)
	MisBeginCondition(NoMission, 853)
	MisBeginCondition(NoRecord, 853)
	MisBeginAction(AddMission, 853)
	MisBeginAction(AddTrigger, 8531, TE_GETITEM, 4834, 10 )
	MisCancelAction(ClearMission, 853)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000519 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000519")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000519)
	MisNeed(MIS_NEED_ITEM, 4834, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000520 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000520")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000520)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000521 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000521")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000521)
	MisResultCondition(NoRecord, 853)
	MisResultCondition(HasMission, 853)
	MisResultCondition(HasItem, 4834, 10)
	MisResultAction(TakeItem, 4834, 10)
	MisResultAction(ClearMission, 853)
	MisResultAction(SetRecord, 853)
	MisResultAction(AddExp,35066,35066)	
	MisResultAction(AddMoney,1189,1189)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4834 )	
	TriggerAction( 1, AddNextFlag, 853, 10, 10 )
	RegCurTrigger( 8531 )

-----------------------------------µÚ¶þÖÖÔ­ÁÏ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000522 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000522")
	DefineMission( 854, MISSCRIPT_MISSIONSCRIPT05_LUA_000522, 854 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000523 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000523")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000523)
	--MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(HasRecord, 851)
	MisBeginCondition(NoMission, 854)
	MisBeginCondition(NoRecord, 854)
	MisBeginAction(AddMission, 854)
	MisBeginAction(AddTrigger, 8541, TE_GETITEM, 4884, 10 )
	MisCancelAction(ClearMission, 854)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000524 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000524")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000524)
	MisNeed(MIS_NEED_ITEM, 4884, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000525 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000525")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000525)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000526 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000526")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000526)
	MisResultCondition(NoRecord, 854)
	MisResultCondition(HasMission, 854)
	MisResultCondition(HasItem, 4884, 10)
	MisResultAction(TakeItem, 4884, 10)
	MisResultAction(ClearMission, 854)
	MisResultAction(SetRecord, 854)
	MisResultAction(AddExp,35066,35066)
	MisResultAction(AddMoney,1189,1189)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4884 )	
	TriggerAction( 1, AddNextFlag, 854, 10, 10 )
	RegCurTrigger( 8541 )

-----------------------------------µÖÓùÍöÁé
	MISSCRIPT_MISSIONSCRIPT05_LUA_000527 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000527")
	DefineMission( 855, MISSCRIPT_MISSIONSCRIPT05_LUA_000527, 855 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000528 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000528")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000528)
	--MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(HasRecord, 852)
	MisBeginCondition(NoMission, 855)
	MisBeginCondition(NoRecord, 855)
	MisBeginAction(AddMission, 855)
	MisBeginAction(AddTrigger, 8551, TE_KILL, 42, 15 )
	MisCancelAction(ClearMission, 855)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000529 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000529")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000529)
	MisNeed(MIS_NEED_KILL, 42, 15, 10, 15)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000530 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000530")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000530)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000531 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000531")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000531)
	MisResultCondition(NoRecord, 855)
	MisResultCondition(HasMission, 855)
	MisResultCondition(HasFlag, 855, 24)
	MisResultAction(ClearMission, 855)
	MisResultAction(SetRecord, 855)
	MisResultAction(AddExp,35066,35066)	
	MisResultAction(AddMoney,1189,1189)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 42 )	
	TriggerAction( 1, AddNextFlag, 855, 10, 15 )
	RegCurTrigger( 8551 )

-----------------------------------ÍÁÖøÎ§³Ç
	MISSCRIPT_MISSIONSCRIPT05_LUA_000532 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000532")
	DefineMission( 856, MISSCRIPT_MISSIONSCRIPT05_LUA_000532, 856 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000533 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000533")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000533)
	--MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(HasRecord, 849)
	MisBeginCondition(NoMission, 856)
	MisBeginCondition(NoRecord, 856)
	MisBeginAction(AddMission, 856)
	MisBeginAction(AddTrigger, 8561, TE_KILL, 515, 15 )
	MisBeginAction(AddTrigger, 8562, TE_KILL, 38, 5 )
	MisCancelAction(ClearMission, 856)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000534 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000534")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000534)
	MisNeed(MIS_NEED_KILL, 515, 15, 10, 15)
	MisNeed(MIS_NEED_KILL, 38, 5, 30, 5)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000535 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000535")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000535)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000536 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000536")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000536)
	MisResultCondition(NoRecord, 856)
	MisResultCondition(HasMission, 856)
	MisResultCondition(HasFlag, 856, 24)
	MisResultCondition(HasFlag, 856, 34)
	MisResultAction(ClearMission, 856)
	MisResultAction(SetRecord, 856)
	MisResultAction(AddExp,38628,38628)
	MisResultAction(AddMoney,1212,1212)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 515 )	
	TriggerAction( 1, AddNextFlag, 856, 10, 15 )
	RegCurTrigger( 8561 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 38 )	
	TriggerAction( 1, AddNextFlag, 856, 30, 5 )
	RegCurTrigger( 8562 )

-----------------------------------Õ½ÕùµÄ½±Àø
	MISSCRIPT_MISSIONSCRIPT05_LUA_000537 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000537")
	DefineMission( 857, MISSCRIPT_MISSIONSCRIPT05_LUA_000537, 857 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000538 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000538")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000538)
	--MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(HasRecord, 856)
	MisBeginCondition(NoMission, 857)
	MisBeginCondition(NoRecord, 857)
	MisBeginAction(AddMission, 857)
	MisBeginAction(AddTrigger, 8571, TE_GETITEM, 4919, 5 )
	MisBeginAction(AddTrigger, 8572, TE_GETITEM, 4835, 5 )
	MisCancelAction(ClearMission, 857)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000539 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000539")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000539)
	MisNeed(MIS_NEED_ITEM, 4919, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4835, 5, 20, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000540 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000540")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000540)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000541 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000541")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000541)
	MisResultCondition(NoRecord, 857)
	MisResultCondition(HasMission, 857)
	MisResultCondition(HasItem, 4919, 5)
	MisResultCondition(HasItem, 4835, 5)
	MisResultAction(TakeItem, 4835, 5)
	MisResultAction(TakeItem, 4919, 5)
	MisResultAction(ClearMission, 857)
	MisResultAction(SetRecord, 857)
	MisResultAction(AddExp,42522,42522)	
	MisResultAction(AddMoney,1235,1235)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4919 )	
	TriggerAction( 1, AddNextFlag, 857, 10, 5 )
	RegCurTrigger( 8571 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4835 )	
	TriggerAction( 1, AddNextFlag, 857, 20, 5 )
	RegCurTrigger( 8572 )

-----------------------------------ÐÂµÄÎäÆ÷
	MISSCRIPT_MISSIONSCRIPT05_LUA_000542 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000542")
	DefineMission( 858, MISSCRIPT_MISSIONSCRIPT05_LUA_000542, 858 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000543 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000543")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000543)
	--MisBeginCondition(LvCheck, ">", 47 )
	MisBeginCondition(HasRecord, 856)
	MisBeginCondition(NoMission, 858)
	MisBeginCondition(NoRecord, 858)
	MisBeginAction(AddMission, 858)
	MisBeginAction(AddTrigger, 8581, TE_GETITEM, 4918, 1 )
	MisBeginAction(AddTrigger, 8582, TE_GETITEM, 4921, 1 )
	MisCancelAction(ClearMission, 858)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000544 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000544")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000544)
	MisNeed(MIS_NEED_ITEM, 4918, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4921, 1, 20, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000545 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000545")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000545)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000546 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000546")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000546)
	MisResultCondition(NoRecord, 858)
	MisResultCondition(HasMission, 858)
	MisResultCondition(HasItem, 4918, 1)
	MisResultCondition(HasItem, 4921, 1)
	MisResultAction(TakeItem, 4921, 1)
	MisResultAction(TakeItem, 4918, 1)
	MisResultAction(ClearMission, 858)
	MisResultAction(SetRecord, 858)
	MisResultAction(AddExp,42522,42522)	
	MisResultAction(AddMoney,1235,1235)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4918 )	
	TriggerAction( 1, AddNextFlag, 858, 10, 1 )
	RegCurTrigger( 8581 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4921 )	
	TriggerAction( 1, AddNextFlag, 858, 20, 1 )
	RegCurTrigger( 8582 )

-----------------------------------¶éÂäÌìÊ¹
	MISSCRIPT_MISSIONSCRIPT05_LUA_000547 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000547")
	DefineMission( 859, MISSCRIPT_MISSIONSCRIPT05_LUA_000547, 859 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000548 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000548")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000548)
	MisBeginCondition(LvCheck, ">", 50 )
	--MisBeginCondition(HasRecord, 849)
	MisBeginCondition(NoMission, 859)
	MisBeginCondition(NoRecord, 859)
	MisBeginAction(AddMission, 859)
	MisBeginAction(AddTrigger, 8591, TE_KILL, 284, 12 )
	MisCancelAction(ClearMission, 859)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000549 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000549")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000549)
	MisNeed(MIS_NEED_KILL, 284, 12, 10, 12)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000550 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000550")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000550)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000551 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000551")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000551)
	MisResultCondition(NoRecord, 859)
	MisResultCondition(HasMission, 859)
	MisResultCondition(HasFlag, 859, 21)
	MisResultAction(ClearMission, 859)
	MisResultAction(SetRecord, 859)
	MisResultAction(AddExp,42522,42522)
	MisResultAction(AddMoney,1235,1235)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 284 )	
	TriggerAction( 1, AddNextFlag, 859, 10, 12 )
	RegCurTrigger( 8591 )

-----------------------------------Ô¶Õ÷
	MISSCRIPT_MISSIONSCRIPT05_LUA_000552 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000552")
	DefineMission( 860, MISSCRIPT_MISSIONSCRIPT05_LUA_000552, 860 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000553 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000553")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000553)
	MisBeginCondition(LvCheck, ">", 51 )
	MisBeginCondition(HasRecord, 858)
	MisBeginCondition(NoMission, 860)
	MisBeginCondition(NoRecord, 860)
	MisBeginAction(AddMission, 860)
	MisBeginAction(AddTrigger, 8601, TE_KILL, 521, 8 )
	MisBeginAction(AddTrigger, 8602, TE_KILL, 541, 8 )
	MisCancelAction(ClearMission, 860)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000554")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000554)
	MisNeed(MIS_NEED_KILL, 521, 8, 10, 8)
	MisNeed(MIS_NEED_KILL, 541, 8, 30, 8)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000555 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000555")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000555)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000556 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000556")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000556)
	MisResultCondition(NoRecord, 860)
	MisResultCondition(HasMission, 860)
	MisResultCondition(HasFlag, 860, 17)
	MisResultCondition(HasFlag, 860, 37)
	MisResultAction(ClearMission, 860)
	MisResultAction(SetRecord, 860)
	MisResultAction(AddExp,46776,46776)
	MisResultAction(AddMoney,1258,1258)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 521 )	
	TriggerAction( 1, AddNextFlag, 860, 10, 8 )
	RegCurTrigger( 8601 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 541 )	
	TriggerAction( 1, AddNextFlag, 860, 30, 8 )
	RegCurTrigger( 8602 )

-----------------------------------¶éÂäµÄÍ·¿ø
	HELP_MONSTERHELP_LUA_001337 = GetResString("HELP_MONSTERHELP_LUA_001337")
	DefineMission( 861, HELP_MONSTERHELP_LUA_001337, 861 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000557 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000557")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000557)
	MisBeginCondition(LvCheck, ">", 51 )
	MisBeginCondition(HasRecord, 850)
	MisBeginCondition(NoMission, 861)
	MisBeginCondition(NoRecord, 861)
	MisBeginAction(AddMission, 861)
	MisBeginAction(AddTrigger, 8611, TE_GETITEM, 4837, 5 )
	MisCancelAction(ClearMission, 861)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000558 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000558")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000558)
	MisNeed(MIS_NEED_ITEM, 4837, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000559 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000559")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000559)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000560 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000560")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000560)
	MisResultCondition(NoRecord, 861)
	MisResultCondition(HasMission, 861)
	MisResultCondition(HasItem, 4837, 5)
	MisResultAction(TakeItem, 4837, 5)
	MisResultAction(ClearMission, 861)
	MisResultAction(SetRecord, 861)
	MisResultAction(AddExp,46776,46776)
	MisResultAction(AddMoney,1258,1258)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4837 )	
	TriggerAction( 1, AddNextFlag, 861, 10, 5 )
	RegCurTrigger( 8611 )


-----------------------------------µÚËÄÖÖÔ­ÁÏ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000561 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000561")
	DefineMission( 862, MISSCRIPT_MISSIONSCRIPT05_LUA_000561, 862 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000562 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000562")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000562)
	MisBeginCondition(LvCheck, ">", 52 )
	MisBeginCondition(HasRecord, 853)
	MisBeginCondition(NoMission, 862)
	MisBeginCondition(NoRecord, 862)
	MisBeginAction(AddMission, 862)
	MisBeginAction(AddTrigger, 8621, TE_GETITEM, 4858, 8 )
	MisCancelAction(ClearMission, 862)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000563 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000563")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000563)
	MisNeed(MIS_NEED_ITEM, 4858, 8, 10, 8)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000564 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000564")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000564)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000565 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000565")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000565)
	MisResultCondition(NoRecord, 862)
	MisResultCondition(HasMission, 862)
	MisResultCondition(HasItem, 4858, 8)
	MisResultAction(TakeItem, 4858, 8)
	MisResultAction(ClearMission, 862)
	MisResultAction(SetRecord, 862)
	MisResultAction(AddExp,51423,51423)
	MisResultAction(AddMoney,1282,1282)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4858 )	
	TriggerAction( 1, AddNextFlag, 862, 10, 8 )
	RegCurTrigger( 8621 )

-----------------------------------Ê¥ÁÖ¿¼Ñé
	MISSCRIPT_MISSIONSCRIPT05_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000566")
	DefineMission( 863, MISSCRIPT_MISSIONSCRIPT05_LUA_000566, 863 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000567 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000567")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000567)
	MisBeginCondition(LvCheck, ">", 52 )
	--MisBeginCondition(HasRecord, 863)
	MisBeginCondition(NoMission, 863)
	MisBeginCondition(NoRecord, 863)
	MisBeginAction(AddMission, 863)
	MisBeginAction(AddTrigger, 8631, TE_KILL, 261, 10 )
	MisCancelAction(ClearMission, 863)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000568 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000568")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000568)
	MisNeed(MIS_NEED_KILL, 261, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000569 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000569")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000569)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000570 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000570")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000570)
	MisResultCondition(NoRecord, 863)
	MisResultCondition(HasMission, 863)
	MisResultCondition(HasFlag, 863, 19)
	MisResultAction(ClearMission, 863)
	MisResultAction(SetRecord, 863)
	MisResultAction(AddExp,51423,51423)
	MisResultAction(AddMoney,1282,1282)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 261 )	
	TriggerAction( 1, AddNextFlag, 863, 10, 10 )
	RegCurTrigger( 8631 )


-----------------------------------×îºóÒ»ÖÖÔ­ÁÏ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000571 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000571")
	DefineMission( 864, MISSCRIPT_MISSIONSCRIPT05_LUA_000571, 864 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000572 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000572")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000572)
	MisBeginCondition(LvCheck, ">", 53 )
	MisBeginCondition(HasRecord, 862)
	MisBeginCondition(NoMission, 864)
	MisBeginCondition(NoRecord, 864)
	MisBeginAction(AddMission, 864)
	MisBeginAction(AddTrigger, 8641, TE_GETITEM, 4886, 10 )
	MisCancelAction(ClearMission, 864)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000573")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000573)
	MisNeed(MIS_NEED_ITEM, 4886, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000574 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000574")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000574)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000575 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000575")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000575)
	MisResultCondition(NoRecord, 864)
	MisResultCondition(HasMission, 864)
	MisResultCondition(HasItem, 4886, 10)
	MisResultAction(TakeItem, 4886, 10)
	MisResultAction(ClearMission, 864)
	MisResultAction(SetRecord, 864)
	MisResultAction(AddExp,56496,56496)	
	MisResultAction(AddMoney,1306,1306)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4886 )	
	TriggerAction( 1, AddNextFlag, 864, 10, 10 )
	RegCurTrigger( 8641 )

-----------------------------------Ä»ºóµÄÒõÓ°
	MISSCRIPT_MISSIONSCRIPT05_LUA_000576 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000576")
	DefineMission( 865, MISSCRIPT_MISSIONSCRIPT05_LUA_000576, 865 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000577 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000577")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000577)
	MisBeginCondition(LvCheck, ">", 53 )
	MisBeginCondition(HasRecord, 855)
	MisBeginCondition(NoMission, 865)
	MisBeginCondition(NoRecord, 865)
	MisBeginAction(AddMission, 865)
	MisBeginAction(AddTrigger, 8651, TE_KILL, 52, 10 )
	MisCancelAction(ClearMission, 865)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000578 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000578")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000578)
	MisNeed(MIS_NEED_KILL, 52, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000579 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000579")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000579)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000580 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000580")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000580)
	MisResultCondition(NoRecord, 865)
	MisResultCondition(HasMission, 865)
	MisResultCondition(HasFlag, 865, 19)
	MisResultAction(ClearMission, 865)
	MisResultAction(SetRecord, 865)
	MisResultAction(AddExp,56496,56496)	
	MisResultAction(AddMoney,1306,1306)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 52 )	
	TriggerAction( 1, AddNextFlag, 865, 10, 10 )
	RegCurTrigger( 8651 )

-----------------------------------×îºóµÄµÐÈË
	MISSCRIPT_MISSIONSCRIPT05_LUA_000581 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000581")
	DefineMission( 866, MISSCRIPT_MISSIONSCRIPT05_LUA_000581, 866 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000582 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000582")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000582)
	MisBeginCondition(LvCheck, ">", 53 )
	MisBeginCondition(HasRecord, 860)
	MisBeginCondition(NoMission, 866)
	MisBeginCondition(NoRecord, 866)
	MisBeginAction(AddMission, 866)
	MisBeginAction(AddTrigger, 8661, TE_KILL, 565, 10 )
	MisBeginAction(AddTrigger, 8662, TE_GETITEM, 4879, 1 )
	MisCancelAction(ClearMission, 866)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000583")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000583)
	MisNeed(MIS_NEED_KILL, 565, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 4879, 1, 20, 1)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000584 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000584")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000584)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000585 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000585")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000585)
	MisResultCondition(NoRecord, 866)
	MisResultCondition(HasMission, 866)
	MisResultCondition(HasFlag, 866, 19)
	MisResultCondition(HasItem, 4879, 1)
	MisResultAction(TakeItem, 4879, 1)
	MisResultAction(ClearMission, 866)
	MisResultAction(SetRecord, 866)
	MisResultAction(AddExp,56496,56496)
	MisResultAction(AddMoney,1306,1306)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 565 )	
	TriggerAction( 1, AddNextFlag, 866, 10, 10 )
	RegCurTrigger( 8661 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4879 )	
	TriggerAction( 1, AddNextFlag, 866, 20, 1 )
	RegCurTrigger( 8662 )

-----------------------------------°µÑª¿¼Ñé
	MISSCRIPT_MISSIONSCRIPT05_LUA_000586 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000586")
	DefineMission( 867, MISSCRIPT_MISSIONSCRIPT05_LUA_000586, 867 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000587 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000587")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000587)
	MisBeginCondition(LvCheck, ">", 54 )
	--MisBeginCondition(HasRecord, 860)
	MisBeginCondition(NoMission, 867)
	MisBeginCondition(NoRecord, 867)
	MisBeginAction(AddMission, 867)
	MisBeginAction(AddTrigger, 8671, TE_KILL, 666, 15 )
	MisCancelAction(ClearMission, 867)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000588 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000588")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000588)
	MisNeed(MIS_NEED_KILL, 666, 15, 10, 15 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000589 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000589")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000589)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000590 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000590")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000590)
	MisResultCondition(NoRecord, 867)
	MisResultCondition(HasMission, 867)
	MisResultCondition(HasFlag, 867, 24)
	MisResultAction(ClearMission, 867)
	MisResultAction(SetRecord, 867)
	MisResultAction(AddExp,62032,62032)
	MisResultAction(AddMoney,1331,1331)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 666 )	
	TriggerAction( 1, AddNextFlag, 867, 10, 15 )
	RegCurTrigger( 8671 )

-----------------------------------°µÖ®¹­
	HELP_MONSTERHELP_LUA_001346 = GetResString("HELP_MONSTERHELP_LUA_001346")
	DefineMission( 868, HELP_MONSTERHELP_LUA_001346, 868 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000591 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000591")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000591)
	MisBeginCondition(LvCheck, ">", 54 )
	MisBeginCondition(HasRecord, 861)
	MisBeginCondition(NoMission, 868)
	MisBeginCondition(NoRecord, 868)
	MisBeginAction(AddMission, 868)
	MisBeginAction(AddTrigger, 8681, TE_GETITEM, 4922, 5 )
	MisCancelAction(ClearMission, 868)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000592")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000592)
	MisNeed(MIS_NEED_ITEM, 4922, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000593 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000593")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000593)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000594 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000594")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000594)
	MisResultCondition(NoRecord, 868)
	MisResultCondition(HasMission, 868)
	MisResultCondition(HasItem, 4922, 5)
	MisResultAction(TakeItem, 4922, 5)
	MisResultAction(ClearMission, 868)
	MisResultAction(SetRecord, 868)
	MisResultAction(AddExp,62032,62032)	
	MisResultAction(AddMoney,1331,1331)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4922 )	
	TriggerAction( 1, AddNextFlag, 868, 10, 5 )
	RegCurTrigger( 8681 )


-----------------------------------µÖ¿¹Ñ©¾ÞÈË
	MISSCRIPT_MISSIONSCRIPT05_LUA_000595 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000595")
	DefineMission( 869, MISSCRIPT_MISSIONSCRIPT05_LUA_000595, 869 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000596 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000596")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000596)
	MisBeginCondition(LvCheck, ">", 35 )
	--MisBeginCondition(HasRecord, 860)
	MisBeginCondition(NoMission, 869)
	MisBeginCondition(NoRecord, 869)
	MisBeginAction(AddMission, 869)
	MisBeginAction(AddTrigger, 8691, TE_KILL, 516, 15 )
	MisCancelAction(ClearMission, 869)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000597 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000597")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000597)
	MisNeed(MIS_NEED_KILL, 516, 15, 10, 15 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000598 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000598")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000598)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000599 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000599")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000599)
	MisResultCondition(NoRecord, 869)
	MisResultCondition(HasMission, 869)
	MisResultCondition(HasFlag, 869, 24)
	MisResultAction(ClearMission, 869)
	MisResultAction(SetRecord, 869)
	MisResultAction(AddExp,9170,9170)	
	MisResultAction(AddMoney,939,939)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 516 )	
	TriggerAction( 1, AddNextFlag, 869, 10, 15 )
	RegCurTrigger( 8691 )

-----------------------------------ÀÇÈËÈëÇÖ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000600 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000600")
	DefineMission( 870, MISSCRIPT_MISSIONSCRIPT05_LUA_000600, 870 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000601 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000601")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000601)
	MisBeginCondition(LvCheck, ">", 36 )
	--MisBeginCondition(HasRecord, 860)
	MisBeginCondition(NoMission, 870)
	MisBeginCondition(NoRecord, 870)
	MisBeginAction(AddMission, 870)
	MisBeginAction(AddTrigger, 8701, TE_KILL, 271, 15 )
	MisCancelAction(ClearMission, 870)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000602 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000602")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000602)
	MisNeed(MIS_NEED_KILL, 271, 15, 10, 15 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000603 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000603")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000603)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000604 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000604")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000604)
	MisResultCondition(NoRecord, 870)
	MisResultCondition(HasMission, 870)
	MisResultCondition(HasFlag, 870, 24)
	MisResultAction(ClearMission, 870)
	MisResultAction(SetRecord, 870)
	MisResultAction(AddExp,10238,10238)
	MisResultAction(AddMoney,955,955)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 271 )	
	TriggerAction( 1, AddNextFlag, 870, 10, 15 )
	RegCurTrigger( 8701 )

-----------------------------------ÊÕÆÆÀÃ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000605 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000605")
	DefineMission( 871, MISSCRIPT_MISSIONSCRIPT05_LUA_000605, 871 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000606 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000606")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000606)
	MisBeginCondition(LvCheck, ">", 36 )
	--MisBeginCondition(HasRecord, 861)
	MisBeginCondition(NoMission, 871)
	MisBeginCondition(NoRecord, 871)
	MisBeginAction(AddMission, 871)
	MisBeginAction(AddTrigger, 8711, TE_GETITEM, 4836, 5 )
	MisBeginAction(AddTrigger, 8712, TE_GETITEM, 4907, 5 )
	MisBeginAction(AddTrigger, 8713, TE_GETITEM, 4838, 5 )
	MisCancelAction(ClearMission, 871)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000607 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000607")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000607)
	MisNeed(MIS_NEED_ITEM, 4836, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4907, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4838, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000608 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000608")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000608)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000609 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000609")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000609)
	MisResultCondition(NoRecord, 871)
	MisResultCondition(HasMission, 871)
	MisResultCondition(HasItem, 4836, 5)
	MisResultCondition(HasItem, 4907, 5)
	MisResultCondition(HasItem, 4838, 5)
	MisResultAction(TakeItem, 4836, 5)
	MisResultAction(TakeItem, 4907, 5)
	MisResultAction(TakeItem, 4838, 5)
	MisResultAction(ClearMission, 871)
	MisResultAction(SetRecord, 871)
	MisResultAction(AddExp,10238,10238)	
	MisResultAction(AddMoney,955,955)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4836 )	
	TriggerAction( 1, AddNextFlag, 871, 10, 5 )
	RegCurTrigger( 8711 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4907 )	
	TriggerAction( 1, AddNextFlag, 871, 20, 5 )
	RegCurTrigger( 8712 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4838 )	
	TriggerAction( 1, AddNextFlag, 871, 30, 5 )
	RegCurTrigger( 8713 )


-----------------------------------Éý¼¶µÄÕ½Õù
	MISSCRIPT_MISSIONSCRIPT05_LUA_000610 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000610")
	DefineMission( 872, MISSCRIPT_MISSIONSCRIPT05_LUA_000610, 872 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000611 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000611")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000611)
	MisBeginCondition(LvCheck, ">", 37 )
	MisBeginCondition(HasRecord, 869)
	MisBeginCondition(NoMission, 872)
	MisBeginCondition(NoRecord, 872)
	MisBeginAction(AddMission, 872)
	MisBeginAction(AddTrigger, 8721, TE_KILL, 194, 15 )
	MisCancelAction(ClearMission, 872)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000612 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000612")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000612)
	MisNeed(MIS_NEED_KILL, 194, 15, 10, 15 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000613 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000613")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000613)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000614 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000614")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000614)
	MisResultCondition(NoRecord, 872)
	MisResultCondition(HasMission, 872)
	MisResultCondition(HasFlag, 872, 24)
	MisResultAction(ClearMission, 872)
	MisResultAction(SetRecord, 872)
	MisResultAction(AddExp,11413,11413)	
	MisResultAction(AddMoney,972,972)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 194 )	
	TriggerAction( 1, AddNextFlag, 872, 10, 15 )
	RegCurTrigger( 8721 )

-----------------------------------¾ÞÈË´óµ¶
	HELP_MONSTERHELP_LUA_001305 = GetResString("HELP_MONSTERHELP_LUA_001305")
	DefineMission( 873, HELP_MONSTERHELP_LUA_001305, 873 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000615")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000615)
	MisBeginCondition(LvCheck, ">", 38 )
	MisBeginCondition(HasRecord, 871)
	MisBeginCondition(NoMission, 873)
	MisBeginCondition(NoRecord, 873)
	MisBeginAction(AddMission, 873)
	MisBeginAction(AddTrigger, 8731, TE_GETITEM, 4861, 5 )
	MisCancelAction(ClearMission, 873)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000616")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000616)
	MisNeed(MIS_NEED_ITEM, 4861, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000617 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000617")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000617)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000618 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000618")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000618)
	MisResultCondition(NoRecord, 873)
	MisResultCondition(HasMission, 873)
	MisResultCondition(HasItem, 4861, 5)
	MisResultAction(TakeItem, 4861, 5)
	MisResultAction(ClearMission, 873)
	MisResultAction(SetRecord, 873)
	MisResultAction(AddExp,11413,11413)
	MisResultAction(AddMoney,972,972)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4861 )	
	TriggerAction( 1, AddNextFlag, 873, 10, 5 )
	RegCurTrigger(8731)

-----------------------------------µÖ¿¹Ñ©Ä§ÈË
	MISSCRIPT_MISSIONSCRIPT05_LUA_000619 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000619")
	DefineMission( 874, MISSCRIPT_MISSIONSCRIPT05_LUA_000619, 874 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000620 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000620")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000620)
	MisBeginCondition(LvCheck, ">", 38 )
	MisBeginCondition(HasRecord, 872)
	MisBeginCondition(NoMission, 874)
	MisBeginCondition(NoRecord, 874)
	MisBeginAction(AddMission, 874)
	MisBeginAction(AddTrigger, 8741, TE_KILL, 517, 12 )
	MisCancelAction(ClearMission, 874)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000621 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000621")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000621)
	MisNeed(MIS_NEED_KILL, 517, 12, 10, 12 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000622 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000622")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000622)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000623 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000623")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000623)
	MisResultCondition(NoRecord, 874)
	MisResultCondition(HasMission, 874)
	MisResultCondition(HasFlag, 874, 21)
	MisResultAction(ClearMission, 874)
	MisResultAction(SetRecord, 874)
	MisResultAction(AddExp,12706,12706)
	MisResultAction(AddMoney,990,990)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 517 )	
	TriggerAction( 1, AddNextFlag, 874, 10, 12 )
	RegCurTrigger( 8741 )

-----------------------------------²¶ÁÔÎÏÅ£
	MISSCRIPT_MISSIONSCRIPT05_LUA_000624 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000624")
	DefineMission( 875, MISSCRIPT_MISSIONSCRIPT05_LUA_000624, 875 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000625 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000625")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000625)
	MisBeginCondition(LvCheck, ">", 38 )
	--MisBeginCondition(HasRecord, 872)
	MisBeginCondition(NoMission, 875)
	MisBeginCondition(NoRecord, 875)
	MisBeginAction(AddMission, 875)
	MisBeginAction(AddTrigger, 8751, TE_KILL, 501, 20 )
	MisBeginAction(AddTrigger, 8752, TE_GETITEM, 4821, 6 )
	MisCancelAction(ClearMission, 875)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000626 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000626")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000626)
	MisNeed(MIS_NEED_KILL, 501, 20, 10, 20 )
	MisNeed(MIS_NEED_ITEM, 4821, 6, 40, 6 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000627 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000627")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000627)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000628 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000628")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000628)
	MisResultCondition(NoRecord, 875)
	MisResultCondition(HasMission, 875)
	MisResultCondition(HasFlag, 875, 29)
	MisResultCondition(HasItem, 4821, 6)
	MisResultAction(TakeItem, 4821, 6)
	MisResultAction(ClearMission, 875)
	MisResultAction(SetRecord, 875)
	MisResultAction(AddExp,12706,12706)
	MisResultAction(AddMoney,990,990)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 501 )	
	TriggerAction( 1, AddNextFlag, 875, 10, 20 )
	RegCurTrigger( 8751 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4821 )	
	TriggerAction( 1, AddNextFlag, 875, 40, 6 )
	RegCurTrigger( 8752 )

-----------------------------------ÐÂµÄÇÖÂÔÕß
	MISSCRIPT_MISSIONSCRIPT05_LUA_000629 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000629")
	DefineMission( 876, MISSCRIPT_MISSIONSCRIPT05_LUA_000629, 876 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000630 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000630")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000630)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(HasRecord, 870)
	MisBeginCondition(NoMission, 876)
	MisBeginCondition(NoRecord, 876)
	MisBeginAction(AddMission, 876)
	MisBeginAction(AddTrigger, 8761, TE_KILL, 270, 12 )
	MisCancelAction(ClearMission, 876)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000631 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000631")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000631)
	MisNeed(MIS_NEED_KILL, 270, 12, 10, 12 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000632 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000632")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000632)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000633 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000633")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000633)
	MisResultCondition(NoRecord, 876)
	MisResultCondition(HasMission, 876)
	MisResultCondition(HasFlag, 876, 21)
	MisResultAction(ClearMission, 876)
	MisResultAction(SetRecord, 876)
	MisResultAction(AddExp,14128,14128)	
	MisResultAction(AddMoney,1008,1008)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 270 )	
	TriggerAction( 1, AddNextFlag, 876, 10, 12 )
	RegCurTrigger( 8761 )

-----------------------------------÷¼÷Ã×°ÊÎÆ·
	MISSCRIPT_MISSIONSCRIPT05_LUA_000634 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000634")
	DefineMission( 877, MISSCRIPT_MISSIONSCRIPT05_LUA_000634, 877 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000635 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000635")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000635)
	MisBeginCondition(LvCheck, ">", 39 )
	--MisBeginCondition(HasRecord, 871)
	MisBeginCondition(NoMission, 877)
	MisBeginCondition(NoRecord, 877)
	MisBeginAction(AddMission, 877)
	MisBeginAction(AddTrigger, 8771, TE_GETITEM, 4911, 10 )
	MisCancelAction(ClearMission, 877)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000636 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000636")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000636)
	MisNeed(MIS_NEED_ITEM, 4911, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000637 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000637")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000637)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000638 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000638")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000638)
	MisResultCondition(NoRecord, 877)
	MisResultCondition(HasMission, 877)
	MisResultCondition(HasItem, 4911, 10)
	MisResultAction(TakeItem, 4911, 10)
	MisResultAction(ClearMission, 877)
	MisResultAction(SetRecord, 877)
	MisResultAction(AddExp,14128,14128)	
	MisResultAction(AddMoney,1008,1008)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4911 )	
	TriggerAction( 1, AddNextFlag, 877, 10, 10 )
	RegCurTrigger(8771)

-----------------------------------¼ÌÐøÉîÈë
	MISSCRIPT_MISSIONSCRIPT05_LUA_000639 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000639")
	DefineMission( 878, MISSCRIPT_MISSIONSCRIPT05_LUA_000639, 878 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000640 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000640")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000640)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(HasRecord, 874)
	MisBeginCondition(NoMission, 878)
	MisBeginCondition(NoRecord, 878)
	MisBeginAction(AddMission, 878)
	MisBeginAction(AddTrigger, 8781, TE_KILL, 195, 12 )
	MisCancelAction(ClearMission, 878)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000641 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000641")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000641)
	MisNeed(MIS_NEED_KILL, 195, 12, 10, 12 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000642 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000642")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000642)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000643 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000643")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000643)
	MisResultCondition(NoRecord, 878)
	MisResultCondition(HasMission, 878)
	MisResultCondition(HasFlag, 878, 21)
	MisResultAction(ClearMission, 878)
	MisResultAction(SetRecord, 878)
	MisResultAction(AddExp,14128,14128)
	MisResultAction(AddMoney,1008,1008)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 195 )	
	TriggerAction( 1, AddNextFlag, 878, 10, 12 )
	RegCurTrigger( 8781 )

-----------------------------------¾ÞÈËÄ¾°ô
	HELP_MONSTERHELP_LUA_001309 = GetResString("HELP_MONSTERHELP_LUA_001309")
	DefineMission( 879, HELP_MONSTERHELP_LUA_001309, 879 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000644 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000644")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000644)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(HasRecord, 873)
	MisBeginCondition(NoMission, 879)
	MisBeginCondition(NoRecord, 879)
	MisBeginAction(AddMission, 879)
	MisBeginAction(AddTrigger, 8791, TE_GETITEM, 4862, 10 )
	MisCancelAction(ClearMission, 879)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000645 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000645")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000645)
	MisNeed(MIS_NEED_ITEM, 4862, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000646 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000646")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000646)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000647 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000647")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000647)
	MisResultCondition(NoRecord, 879)
	MisResultCondition(HasMission, 879)
	MisResultCondition(HasItem, 4862, 10)
	MisResultAction(TakeItem, 4862, 10)
	MisResultAction(ClearMission, 879)
	MisResultAction(SetRecord, 879)
	MisResultAction(AddExp,14128,14128)
	MisResultAction(AddMoney,1008,1008)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4862 )	
	TriggerAction( 1, AddNextFlag, 879, 10, 10 )
	RegCurTrigger(8791)

-----------------------------------µÐºó
	MISSCRIPT_MISSIONSCRIPT05_LUA_000648 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000648")
	DefineMission( 880, MISSCRIPT_MISSIONSCRIPT05_LUA_000648, 880 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000649 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000649")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000649)
	MisBeginCondition(LvCheck, ">", 41 )
	MisBeginCondition(HasRecord, 876)
	MisBeginCondition(NoMission, 880)
	MisBeginCondition(NoRecord, 880)
	MisBeginAction(AddMission, 880)
	MisBeginAction(AddTrigger, 8801, TE_KILL, 502, 12 )
	MisCancelAction(ClearMission, 880)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000650 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000650")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000650)
	MisNeed(MIS_NEED_KILL, 502, 12, 10, 12 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000651 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000651")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000651)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000652 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000652")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000652)
	MisResultCondition(NoRecord, 880)
	MisResultCondition(HasMission, 880)
	MisResultCondition(HasFlag, 880, 21)
	MisResultAction(ClearMission, 880)
	MisResultAction(SetRecord, 880)
	MisResultAction(AddExp,17409,17409)
	MisResultAction(AddMoney,1045,1045)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 502 )	
	TriggerAction( 1, AddNextFlag, 880, 10, 12 )
	RegCurTrigger( 8801 )

-----------------------------------ÎôÈÕ»Ô»Í
	MISSCRIPT_MISSIONSCRIPT05_LUA_000653 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000653")
	DefineMission( 881, MISSCRIPT_MISSIONSCRIPT05_LUA_000653, 881 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000654 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000654")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000654)
	MisBeginCondition(LvCheck, ">", 41 )
	--MisBeginCondition(HasRecord, 873)
	MisBeginCondition(NoMission, 881)
	MisBeginCondition(NoRecord, 881)
	MisBeginAction(AddMission, 881)
	MisBeginAction(AddTrigger, 8811, TE_GETITEM, 4822, 8 )
	MisCancelAction(ClearMission, 881)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000655 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000655")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000655)
	MisNeed(MIS_NEED_ITEM, 4822, 8, 10, 8)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000651 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000651")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000651)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000652 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000652")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000652)
	MisResultCondition(NoRecord, 881)
	MisResultCondition(HasMission, 881)
	MisResultCondition(HasItem, 4822, 8)
	MisResultAction(TakeItem, 4822, 8)
	MisResultAction(ClearMission, 881)
	MisResultAction(SetRecord, 881)
	MisResultAction(AddExp,17409,17409)
	MisResultAction(AddMoney,1045,1045)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4822 )	
	TriggerAction( 1, AddNextFlag, 881, 10, 8 )
	RegCurTrigger(8811)

----------------------------------²¶ÁÔ±ùÁúÓ×áÌ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000656 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000656")
	DefineMission( 882, MISSCRIPT_MISSIONSCRIPT05_LUA_000656, 882 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000657 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000657")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000657)
	MisBeginCondition(LvCheck, ">", 41 )
	MisBeginCondition(HasRecord, 875)
	MisBeginCondition(NoMission, 882)
	MisBeginCondition(NoRecord, 882)
	MisBeginAction(AddMission, 882)
	MisBeginAction(AddTrigger, 8821, TE_KILL, 530, 10 )
	MisBeginAction(AddTrigger, 8822, TE_GETITEM, 4850, 1 )
	MisCancelAction(ClearMission, 882)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000658 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000658")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000658)
	MisNeed(MIS_NEED_KILL, 530, 10, 10, 10 )
	MisNeed(MIS_NEED_ITEM, 4850, 1, 20, 1 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000659 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000659")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000659)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000660 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000660")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000660)
	MisResultCondition(NoRecord, 882)
	MisResultCondition(HasMission, 882)
	MisResultCondition(HasFlag, 882, 19)
	MisResultCondition(HasItem, 4850, 1)
	MisResultAction(TakeItem, 4850, 1)
	MisResultAction(ClearMission, 882)
	MisResultAction(SetRecord, 882)
	MisResultAction(AddExp,17409,17409)
	MisResultAction(AddMoney,1045,1045)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 530 )	
	TriggerAction( 1, AddNextFlag, 882, 10, 10 )
	RegCurTrigger( 8821 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4850 )	
	TriggerAction( 1, AddNextFlag, 882, 20, 1 )
	RegCurTrigger( 8822 )

-----------------------------------±ù¾§Ö®ÃÕ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000661 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000661")
	DefineMission( 883, MISSCRIPT_MISSIONSCRIPT05_LUA_000661, 883 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000662 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000662")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000662)
	MisBeginCondition(LvCheck, ">", 41 )
	MisBeginCondition(HasRecord, 882)
	MisBeginCondition(NoMission, 883)
	MisBeginCondition(NoRecord, 883)
	MisBeginAction(AddMission, 883)
	MisBeginAction(AddTrigger, 8831, TE_GETITEM, 4850, 5 )
	MisCancelAction(ClearMission, 883)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000663 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000663")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000663)
	MisNeed(MIS_NEED_ITEM, 4850, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000664 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000664")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000664)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000665 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000665")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000665)
	MisResultCondition(NoRecord, 883)
	MisResultCondition(HasMission, 883)
	MisResultCondition(HasItem, 4850, 5)
	MisResultAction(TakeItem, 4850, 5)
	MisResultAction(ClearMission, 883)
	MisResultAction(SetRecord, 883)
	MisResultAction(AddExp,17409,17409)	
	MisResultAction(AddMoney,1045,1045)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4850 )	
	TriggerAction( 1, AddNextFlag, 883, 10, 5 )
	RegCurTrigger(8831)


-----------------------------------Ë®¾§ÐÄ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000666 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000666")
	DefineMission( 884, MISSCRIPT_MISSIONSCRIPT05_LUA_000666, 884 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000667 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000667")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000667)
	MisBeginCondition(LvCheck, ">", 43 )
	MisBeginCondition(HasRecord, 883)
	MisBeginCondition(NoMission, 884)
	MisBeginCondition(NoRecord, 884)
	MisBeginAction(AddMission, 884)
	MisBeginAction(AddTrigger, 8841, TE_GETITEM, 4895, 5 )
	MisCancelAction(ClearMission, 884)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000668 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000668")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000668)
	MisNeed(MIS_NEED_ITEM, 4895, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000669 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000669")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000669)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000670 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000670")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000670)
	MisResultCondition(NoRecord, 884)
	MisResultCondition(HasMission, 884)
	MisResultCondition(HasItem, 4895, 5)
	MisResultAction(TakeItem, 4895, 5)
	MisResultAction(ClearMission, 884)
	MisResultAction(SetRecord, 884)
	MisResultAction(AddExp,21361,21361)	
	MisResultAction(AddMoney,1084,1084)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4895 )	
	TriggerAction( 1, AddNextFlag, 884, 10, 5 )
	RegCurTrigger(8841)

-----------------------------------²¶ÁÔ¼«µØÐÜ
	MISSCRIPT_MISSIONSCRIPT05_LUA_000671 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000671")
	DefineMission( 885, MISSCRIPT_MISSIONSCRIPT05_LUA_000671, 885 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000672 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000672")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000672)
	MisBeginCondition(LvCheck, ">", 43 )
	MisBeginCondition(HasRecord, 882)
	MisBeginCondition(NoMission, 885)
	MisBeginCondition(NoRecord, 885)
	MisBeginAction(AddMission, 885)
	MisBeginAction(AddTrigger, 8851, TE_KILL, 504, 8 )
	MisBeginAction(AddTrigger, 8852, TE_GETITEM, 4824, 3 )
	MisCancelAction(ClearMission, 885)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000673 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000673")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000673)
	MisNeed(MIS_NEED_KILL, 504, 8, 10, 8 )
	MisNeed(MIS_NEED_ITEM, 4824, 3, 20, 3 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000674 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000674")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000674)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000675 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000675")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000675)
	MisResultCondition(NoRecord, 885)
	MisResultCondition(HasMission, 885)
	MisResultCondition(HasFlag, 885, 17)
	MisResultCondition(HasItem, 4824, 3)
	MisResultAction(TakeItem, 4824, 3)
	MisResultAction(ClearMission, 885)
	MisResultAction(SetRecord, 885)
	MisResultAction(AddExp,21361,21361)	
	MisResultAction(AddMoney,1084,1084)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 504 )	
	TriggerAction( 1, AddNextFlag, 885, 10, 8 )
	RegCurTrigger( 8851 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4824 )	
	TriggerAction( 1, AddNextFlag, 885, 20, 3 )
	RegCurTrigger( 8852 )

-----------------------------------¾ÞÈËÊ×Áì
	MISSCRIPT_MISSIONSCRIPT05_LUA_000676 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000676")
	DefineMission( 886, MISSCRIPT_MISSIONSCRIPT05_LUA_000676, 886 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000677 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000677")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000677)
	MisBeginCondition(LvCheck, ">", 44 )
	MisBeginCondition(HasRecord, 872)
	MisBeginCondition(NoMission, 886)
	MisBeginCondition(NoRecord, 886)
	MisBeginAction(AddMission, 886)
	MisBeginAction(AddTrigger, 8861, TE_KILL, 194, 16 )
	MisCancelAction(ClearMission, 886)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000678 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000678")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000678)
	MisNeed(MIS_NEED_KILL, 194, 16, 10, 16 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000679 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000679")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000679)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000680 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000680")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000680)
	MisResultCondition(NoRecord, 886)
	MisResultCondition(HasMission, 886)
	MisResultCondition(HasFlag, 886, 25)
	MisResultAction(ClearMission, 886)
	MisResultAction(SetRecord, 886)
	MisResultAction(AddExp,23628,23628)	
	MisResultAction(AddMoney,1104,1104)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 194 )	
	TriggerAction( 1, AddNextFlag, 886, 10, 16 )
	RegCurTrigger( 8861 )

-----------------------------------¿Ö²À¾ÞÈË´óµ¶
	HELP_MONSTERHELP_LUA_001319 = GetResString("HELP_MONSTERHELP_LUA_001319")
	DefineMission( 887, HELP_MONSTERHELP_LUA_001319, 887 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000681 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000681")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000681)
	MisBeginCondition(LvCheck, ">", 43 )
	MisBeginCondition(HasRecord, 883)
	MisBeginCondition(NoMission, 887)
	MisBeginCondition(NoRecord, 887)
	MisBeginAction(AddMission, 887)
	MisBeginAction(AddTrigger, 8871, TE_GETITEM, 4910, 5 )
	MisCancelAction(ClearMission, 887)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000682 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000682")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000682)
	MisNeed(MIS_NEED_ITEM, 4910, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000683 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000683")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000683)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000684 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000684")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000684)
	MisResultCondition(NoRecord, 887)
	MisResultCondition(HasMission, 887)
	MisResultCondition(HasItem, 4910, 5)
	MisResultAction(TakeItem, 4910, 5)
	MisResultAction(ClearMission, 887)
	MisResultAction(SetRecord, 887)
	MisResultAction(AddExp,23628,23628)	
	MisResultAction(AddMoney,1104,1104)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4910 )	
	TriggerAction( 1, AddNextFlag, 887, 10, 5 )
	RegCurTrigger(8871)

-----------------------------------ÀÇÈË¹­¼ýÊÖ
	HELP_MONSTERHELP_LUA_000416 = GetResString("HELP_MONSTERHELP_LUA_000416")
	DefineMission( 888, HELP_MONSTERHELP_LUA_000416, 888 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000685 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000685")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000685)
	MisBeginCondition(LvCheck, ">", 45 )
	MisBeginCondition(HasRecord, 880)
	MisBeginCondition(NoMission, 888)
	MisBeginCondition(NoRecord, 888)
	MisBeginAction(AddMission, 888)
	MisBeginAction(AddTrigger, 8881, TE_KILL, 272, 20 )
	MisBeginAction(AddTrigger, 8882, TE_GETITEM, 4916, 5 )
	MisCancelAction(ClearMission, 888)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000686 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000686")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000686)
	MisNeed(MIS_NEED_KILL, 272, 20, 10, 20 )
	MisNeed(MIS_NEED_ITEM, 4916, 5, 40, 5 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000687 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000687")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000687)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000688 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000688")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000688)
	MisResultCondition(NoRecord, 888)
	MisResultCondition(HasMission, 888)
	MisResultCondition(HasFlag, 888, 29)
	MisResultCondition(HasItem, 4916, 5)
	MisResultAction(TakeItem, 4916, 5)
	MisResultAction(ClearMission, 888)
	MisResultAction(SetRecord, 888)
	MisResultAction(AddExp,26112,26112)
	MisResultAction(AddMoney,1125,1125)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 272 )	
	TriggerAction( 1, AddNextFlag, 888, 10, 20 )
	RegCurTrigger( 8881 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4916 )	
	TriggerAction( 1, AddNextFlag, 888, 40, 5 )
	RegCurTrigger( 8882 )

-----------------------------------×îÖÕÄ§ÈË
	MISSCRIPT_MISSIONSCRIPT05_LUA_000689 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000689")
	DefineMission( 889, MISSCRIPT_MISSIONSCRIPT05_LUA_000689, 889 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000690 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000690")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000690)
	MisBeginCondition(LvCheck, ">", 45 )
	MisBeginCondition(HasRecord, 878)
	MisBeginCondition(NoMission, 889)
	MisBeginCondition(NoRecord, 889)
	MisBeginAction(AddMission, 889)
	MisBeginAction(AddTrigger, 8891, TE_KILL, 545, 15 )
	MisCancelAction(ClearMission, 889)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000691 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000691")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000691)
	MisNeed(MIS_NEED_KILL, 545, 15, 10, 15 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000692 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000692")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000692)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000693 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000693")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000693)
	MisResultCondition(NoRecord, 889)
	MisResultCondition(HasMission, 889)
	MisResultCondition(HasFlag, 889, 24)
	MisResultAction(ClearMission, 889)
	MisResultAction(SetRecord, 889)
	MisResultAction(AddExp,26112,26112)
	MisResultAction(AddMoney,1125,1125)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 545 )	
	TriggerAction( 1, AddNextFlag, 889, 10, 15 )
	RegCurTrigger( 8891 )

-----------------------------------¿Ö²À¾ÞÈËÄ¾°ô
	HELP_MONSTERHELP_LUA_001323 = GetResString("HELP_MONSTERHELP_LUA_001323")
	DefineMission( 890, HELP_MONSTERHELP_LUA_001323, 890 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000694 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000694")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000694)
	MisBeginCondition(LvCheck, ">", 45 )
	MisBeginCondition(HasRecord, 887)
	MisBeginCondition(NoMission, 890)
	MisBeginCondition(NoRecord, 890)
	MisBeginAction(AddMission, 890)
	MisBeginAction(AddTrigger, 8901, TE_GETITEM, 4912, 5 )
	MisCancelAction(ClearMission, 890)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000695 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000695")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000695)
	MisNeed(MIS_NEED_ITEM, 4912, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000696 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000696")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000696)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000697 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000697")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000697)
	MisResultCondition(NoRecord, 890)
	MisResultCondition(HasMission, 890)
	MisResultCondition(HasItem, 4912, 5)
	MisResultAction(TakeItem, 4912, 5)
	MisResultAction(ClearMission, 890)
	MisResultAction(SetRecord, 890)
	MisResultAction(AddExp,26112,26112)
	MisResultAction(AddMoney,1125,1125)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4912 )	
	TriggerAction( 1, AddNextFlag, 890, 10, 5 )
	RegCurTrigger(8901)

-----------------------------------ÎªÁËÈÙÓþ¶øÕ½
	MISSCRIPT_MISSIONSCRIPT05_LUA_000698 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000698")
	DefineMission( 891, MISSCRIPT_MISSIONSCRIPT05_LUA_000698, 891 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000699 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000699")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000699)
	MisBeginCondition(LvCheck, ">", 46 )
	MisBeginCondition(HasRecord, 888)
	MisBeginCondition(NoMission, 891)
	MisBeginCondition(NoRecord, 891)
	MisBeginAction(AddMission, 891)
	MisBeginAction(AddTrigger, 8911, TE_KILL, 506, 10 )
	MisBeginAction(AddTrigger, 8912, TE_GETITEM, 4826, 1 )
	MisCancelAction(ClearMission, 891)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000700 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000700")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000700)
	MisNeed(MIS_NEED_KILL, 506, 10, 10, 10 )
	MisNeed(MIS_NEED_ITEM, 4826, 1, 20, 1 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000701 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000701")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000701)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000702 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000702")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000702)
	MisResultCondition(NoRecord, 891)
	MisResultCondition(HasMission, 891)
	MisResultCondition(HasFlag, 891, 19)
	MisResultCondition(HasItem, 4826, 1)
	MisResultAction(TakeItem, 4826, 1)
	MisResultAction(ClearMission, 891)
	MisResultAction(SetRecord, 891)
	MisResultAction(AddExp,28832,28832)
	MisResultAction(AddMoney,1146,1146)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 506 )	
	TriggerAction( 1, AddNextFlag, 891, 10, 10 )
	RegCurTrigger( 8911 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4826 )	
	TriggerAction( 1, AddNextFlag, 891, 20, 1 )
	RegCurTrigger( 8912 )


-----------------------------------²¶ÁÔòáòæÈË---Ã»ÓÐÐÞ¸Ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000703 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000703")
	DefineMission( 892, MISSCRIPT_MISSIONSCRIPT05_LUA_000703, 892 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000704 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000704")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000704)
	MisBeginCondition(LvCheck, ">", 49 )
	MisBeginCondition(HasRecord, 885)
	MisBeginCondition(NoMission, 892)
	MisBeginCondition(NoRecord, 892)
	MisBeginAction(AddMission, 892)
	MisBeginAction(AddTrigger, 8921, TE_KILL, 196, 15 )
	MisCancelAction(ClearMission, 892)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000705 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000705")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000705)
	MisNeed(MIS_NEED_KILL, 196, 15, 10, 15 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000706 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000706")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000706)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000707 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000707")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000707)
	MisResultCondition(NoRecord, 892)
	MisResultCondition(HasMission, 892)
	MisResultCondition(HasFlag, 892, 24)
	MisResultAction(ClearMission, 892)
	MisResultAction(SetRecord, 892)
	MisResultAction(AddExp,38628,38628)
	MisResultAction(AddMoney,1212,1212)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 196 )	
	TriggerAction( 1, AddNextFlag, 892, 10, 15 )
	RegCurTrigger( 8921 )

-----------------------------------òáòæÈËÕ½¸«----Ã»ÓÐÐÞ¸Ä
	HELP_MONSTERHELP_LUA_001334 = GetResString("HELP_MONSTERHELP_LUA_001334")
	DefineMission( 893, HELP_MONSTERHELP_LUA_001334, 893 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000708 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000708")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000708)
	MisBeginCondition(LvCheck, ">", 49 )
	MisBeginCondition(HasRecord, 890)
	MisBeginCondition(NoMission, 893)
	MisBeginCondition(NoRecord, 893)
	MisBeginAction(AddMission, 893)
	MisBeginAction(AddTrigger, 8931, TE_GETITEM, 4920, 5 )
	MisCancelAction(ClearMission, 893)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000709 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000709")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000709)
	MisNeed(MIS_NEED_ITEM, 4920, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000710 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000710")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000710)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000711 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000711")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000711)
	MisResultCondition(NoRecord, 893)
	MisResultCondition(HasMission, 893)
	MisResultCondition(HasItem, 4920, 5)
	MisResultAction(TakeItem, 4920, 5)
	MisResultAction(ClearMission, 893)
	MisResultAction(SetRecord, 893)
	MisResultAction(AddExp,38628,38628)
	MisResultAction(AddMoney,1212,1212)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4920 )	
	TriggerAction( 1, AddNextFlag, 893, 10, 5 )
	RegCurTrigger(8931)


	---------------------------------------------------------------
	--							     --
	--			¼ÓÀÕ±Èº£µÁ°æ±¾			     --
	--							     --
	---------------------------------------------------------------


----------------------------------------
--                                    --
--              º£µÁÈÎÎñ              --
--                                    --
----------------------------------------

--Ìú½³ >> ·´Õì²é----Ã»ÓÐÐÞ¸Ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000712 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000712")
	DefineMission(894, MISSCRIPT_MISSIONSCRIPT05_LUA_000712, 894)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000713 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000713")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000713)
	
	MisBeginCondition(NoRecord, 894)
	MisBeginCondition(NoMission, 894)
	MisBeginCondition(HasPirateGuild)

	MisBeginAction(AddMission, 894)
	MisBeginAction(AddTrigger, 8941, TE_KILL, 801, 4)

	MisCancelAction(ClearMission, 894)

	MisNeed(MIS_NEED_KILL, 801, 4, 10, 4)
	

	MISSCRIPT_MISSIONSCRIPT05_LUA_000714 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000714")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000714)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000715 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000715")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000715)

	MisResultCondition(HasMission , 894)
	MisResultCondition(NoRecord, 894)
	MisResultCondition(HasFlag, 894, 13)
	MisResultCondition(HasPirateGuild)

	MisResultAction(ClearMission, 894)
	MisResultAction(SetRecord, 894)

	MisResultAction(AddExp, 80000,80000)
	MisResultAction(AddMoney, 40000,40000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 801)
	TriggerAction(1, AddNextFlag, 894, 10, 4)
	RegCurTrigger(8941)
		

--½Ü¿ËÊ·ÅÉÂÞ >> ×îÇ¿µÄº£µÁ----Ã»ÓÐÐÞ¸Ä

	MISSCRIPT_MISSIONSCRIPT05_LUA_000716 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000716")
	DefineMission(895, MISSCRIPT_MISSIONSCRIPT05_LUA_000716, 895)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000717 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000717")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000717)
	
	MisBeginCondition(HasRecord, 894)
	MisBeginCondition(NoRecord, 895)
	MisBeginCondition(NoMission, 895)
	MisBeginCondition(HasPirateGuild)

	MisBeginAction(AddMission, 895)
	MisBeginAction(AddTrigger, 8951, TE_KILL, 808, 30)
	MisBeginAction(AddTrigger, 8952, TE_KILL, 817, 15)

	MisCancelAction(ClearMission, 895)

	MisNeed(MIS_NEED_KILL, 808, 30, 30, 30)
	MisNeed(MIS_NEED_KILL, 817, 15, 70, 15)
	

	MISSCRIPT_MISSIONSCRIPT05_LUA_000718 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000718")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000718)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000719 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000719")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000719)

	MisResultCondition(HasMission ,895)
	MisResultCondition(NoRecord , 895)
	MisResultCondition(HasFlag, 895, 59)
	MisResultCondition(HasFlag, 895, 84)
	MisResultCondition(HasPirateGuild)

	MisResultAction(ClearMission, 895)
	MisResultAction(SetRecord, 895)

	MisResultAction(AddExp, 200000,200000)
	MisResultAction(AddMoney, 150000,150000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 808)
	TriggerAction(1, AddNextFlag, 895, 30, 30)
	RegCurTrigger(8951)
		
	InitTrigger()
	TriggerCondition(1, IsMonster, 817)
	TriggerAction(1, AddNextFlag, 895, 70, 15)
	RegCurTrigger(8952)
	
	
-- ½Ü¿ËÊ·ÅÉÂÞ >> ½«¾üµÄÊ×¼¶----Ã»ÓÐÐÞ¸Ä

	MISSCRIPT_MISSIONSCRIPT05_LUA_000720 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000720")
	DefineMission(896, MISSCRIPT_MISSIONSCRIPT05_LUA_000720, 896)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000721 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000721")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000721)
	
	MisBeginCondition(HasRecord, 895)
	MisBeginCondition(NoRecord, 896)
	MisBeginCondition(NoMission, 896)
	MisBeginCondition(HasPirateGuild)

	MisBeginAction(AddMission, 896)
	MisBeginAction(AddTrigger, 8961, TE_KILL, 807, 1)
	MisBeginAction(AddTrigger, 8962, TE_GETITEM, 2387, 1)

	MisCancelAction(ClearMission, 896)

	MisNeed(MIS_NEED_KILL, 807, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2387, 1, 20, 1)
	

	MISSCRIPT_MISSIONSCRIPT05_LUA_000722 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000722")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000722)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000723 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000723")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000723)

	MisResultCondition(HasMission, 896)
	MisResultCondition(NoRecord, 896)
	MisResultCondition(HasFlag, 896, 10)
	MisResultCondition(HasItem, 2387, 1)
	MisResultBagNeed(1)
	MisResultCondition(HasPirateGuild)

	MisResultAction(TakeItem, 2387, 1)
	MisResultAction(ClearMission, 896)
	MisResultAction(SetRecord, 896)

	MisResultAction(AddExp, 500000,500000)
	MisResultAction(AddMoney, 1000000,1000000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 807)
	TriggerAction(1, AddNextFlag, 896, 10, 1)
	RegCurTrigger(8961)
		
	InitTrigger()
	TriggerCondition(1, IsItem, 2387)
	TriggerAction(1, AddNextFlag, 896, 20, 1)
	RegCurTrigger(8962)




----------------------------------------
--                                    --
--              º£¾üÈÎÎñ              --
--                                    --
----------------------------------------

-- Áé¶Ù½«¾ü >> º£µÁµÄÊ³Îï----Ã»ÓÐÐÞ¸Ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000724 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000724")
	DefineMission(897, MISSCRIPT_MISSIONSCRIPT05_LUA_000724, 897)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000725 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000725")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000725)
	MisBeginCondition(NoRecord, 897)
	MisBeginCondition(NoMission,897)
	MisBeginCondition(HasNavyGuild)

	MisBeginAction(AddMission, 897)
	MisBeginAction(AddTrigger, 8971,TE_GETITEM, 2413, 5)
	MisBeginAction(AddTrigger, 8972,TE_GETITEM, 2414, 5)
	
	MisCancelAction(ClearMission, 897)

	MisNeed(MIS_NEED_ITEM, 2413, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 2414, 5, 20, 5)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000726 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000726")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000726)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000727 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000727")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000727)
	
	MisResultCondition(HasMission, 897)
	MisResultCondition(NoRecord, 897)
	MisResultCondition(HasItem, 2413, 5)
	MisResultCondition(HasItem, 2414, 5)
	MisResultCondition(HasNavyGuild)

	MisResultAction(TakeItem , 2413, 5)
	MisResultAction(TakeItem , 2414, 5)
	MisResultAction(ClearMission, 897)
	MisResultAction(SetRecord, 897)

	MisResultAction(AddExp ,200000, 200000)
	MisResultAction(AddMoney ,100000, 100000)

	InitTrigger()
	TriggerCondition(1, IsItem, 2413)
	TriggerAction(1,AddNextFlag, 897, 10, 5)
	RegCurTrigger(8971)

	InitTrigger()
	TriggerCondition(1, IsItem, 2414)
	TriggerAction(1,AddNextFlag, 897, 20, 5)
	RegCurTrigger(8972)
	
-- Áé¶Ù½«¾ü >>  ½ËÃðº£µÁ----Ã»ÓÐÐÞ¸Ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000728 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000728")
	DefineMission(898, MISSCRIPT_MISSIONSCRIPT05_LUA_000728, 898)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000729 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000729")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000729)
	MisBeginCondition(HasRecord, 897)
	MisBeginCondition(NoRecord, 898)
	MisBeginCondition(NoMission,898)
	MisBeginCondition(HasNavyGuild)

	MisBeginAction(AddMission, 898)
	MisBeginAction(AddTrigger, 8981, TE_GETITEM, 2419, 15)
	
	MisCancelAction(ClearMission, 898)

	MisNeed(MIS_NEED_ITEM, 2419, 15, 30, 15)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000730 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000730")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000730)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000731 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000731")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000731)
	
	MisResultCondition(HasMission, 898)
	MisResultCondition(NoRecord, 898)
	MisResultCondition(HasItem, 2419, 15)
	MisResultCondition(HasNavyGuild)

	MisResultAction(TakeItem , 2419, 15)
	MisResultAction(ClearMission, 898)
	MisResultAction(SetRecord, 898)

	MisResultAction(AddExp ,250000, 250000)
	MisResultAction(AddMoney ,150000, 150000)

	InitTrigger()
	TriggerCondition(1, IsItem, 2419)
	TriggerAction(1,AddNextFlag, 898, 30, 15)
	RegCurTrigger(8981)


-- Áé¶Ù½«¾ü >> ±»×çÖäµÄºÚÕäÖéºÅ----Ã»ÓÐÐÞ¸Ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000732 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000732")
	DefineMission(899, MISSCRIPT_MISSIONSCRIPT05_LUA_000732, 899)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000733 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000733")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000733)
	MisBeginCondition(HasRecord, 898)
	MisBeginCondition(NoRecord, 899)
	MisBeginCondition(NoMission,899)
	MisBeginCondition(HasNavyGuild)

	MisBeginAction(AddMission, 899)
	MisBeginAction(AddTrigger, 8991,TE_KILL, 815, 1)
	MisBeginAction(AddTrigger, 8992,TE_GETITEM, 2429, 1 )
	
	MisCancelAction(ClearMission, 899)

	MisNeed(MIS_NEED_KILL, 815, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2429, 1, 20, 1)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000734 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000734")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000734)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000735 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000735")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000735)
	
	MisResultCondition(HasMission, 899)
	MisResultCondition(NoRecord, 899)
	MisResultCondition(HasFlag, 899, 10)
	MisResultCondition(HasItem, 2429, 1)
	MisResultCondition(HasNavyGuild)

	MisResultAction(TakeItem , 2429, 1)
	MisResultAction(ClearMission, 899)
	MisResultAction(SetRecord, 899)

	MisResultAction(AddExp ,500000, 500000)
	MisResultAction(AddMoney ,1000000, 1000000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 815, 1)
	TriggerAction(1,AddNextFlag, 899, 10,1)
	RegCurTrigger(8991)

	InitTrigger()
	TriggerCondition(1, IsItem, 2429, 1)
	TriggerAction(1,AddNextFlag, 899, 20,1)
	RegCurTrigger(8992)

	
	------------------------ÇøÓòÈÎÎñmaojing  	
-----------------------------------garner¹ÅÀï¿©Àû²¹¸øÕ¾µÄ¸Ð¶÷----------°¢Àï¿ËË¹(1526,3089) 
	MISSCRIPT_MISSIONSCRIPT05_LUA_000736 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000736")
	DefineMission( 6500, MISSCRIPT_MISSIONSCRIPT05_LUA_000736, 1800 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000737 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000737")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000737)
	MisBeginCondition(NoRecord, 1800)
	MisBeginCondition(NoMission, 1800)
	MisBeginCondition(HasRecord, 600)
	MisBeginCondition(HasRecord, 601)
	MisBeginCondition(HasRecord, 602)
	MisBeginCondition(HasRecord, 603)
	MisBeginCondition(HasRecord, 604)
	MisBeginCondition(HasRecord, 605)
	MisBeginCondition(HasRecord, 606)
	MisBeginCondition(HasRecord, 607)
	MisBeginCondition(HasRecord, 608)
	MisBeginCondition(HasRecord, 609)
	MisBeginCondition(HasRecord, 610)
	MisBeginCondition(HasRecord, 611)
	MisBeginCondition(HasRecord, 612)
	MisBeginCondition(HasRecord, 613)
	MisBeginCondition(HasRecord, 614)
	MisBeginCondition(HasRecord, 615)
	MisBeginCondition(HasRecord, 616)
	MisBeginCondition(HasRecord, 617)
	MisBeginCondition(HasRecord, 618)
	MisBeginCondition(HasRecord, 619)
	MisBeginAction(AddMission, 1800)
	MisCancelAction(ClearMission, 1800) ---ÈÎÎñ¿ÉÉ¾³ý
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000738 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000738")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000738)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000739 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000739")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000739)
	MisResultCondition(AlwaysFailure )
-----------------------------------garner¹ÅÀï¿©Àû²¹¸øÕ¾µÄ¸Ð¶÷------------Á«ÄÈÒÌ(1510,3089)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000736 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000736")
	DefineMission( 6501, MISSCRIPT_MISSIONSCRIPT05_LUA_000736, 1800, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000740 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000740")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000740)
	MisResultCondition(NoRecord, 1800)
	MisResultCondition(HasMission, 1800)
	MisResultAction(ClearMission, 1800 )
	MisResultAction(SetRecord, 1800 )
	MisResultAction(AddExp,17000,17000)

-----------------------------------garnerÍß¶ûÅµ²¹¸øÕ¾µÄ¸Ð¶÷lv 29~39------------ÍßÈø·¨¶û(1136,2778)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000741 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000741")
	DefineMission( 6502, MISSCRIPT_MISSIONSCRIPT05_LUA_000741, 1801 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000742 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000742")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000742)
	MisBeginCondition(NoMission, 1801)
	MisBeginCondition(NoRecord, 1801)
	MisBeginCondition(HasRecord, 620)
	MisBeginCondition(HasRecord, 621)
	MisBeginCondition(HasRecord, 622)
	MisBeginCondition(HasRecord, 623)
	MisBeginCondition(HasRecord, 624)
	MisBeginCondition(HasRecord, 625)
	MisBeginCondition(HasRecord, 626)
	MisBeginCondition(HasRecord, 627)
	MisBeginCondition(HasRecord, 628)
	MisBeginCondition(HasRecord, 629)
	MisBeginCondition(HasRecord, 630)
	MisBeginCondition(HasRecord, 631)
	MisBeginCondition(HasRecord, 632)
	MisBeginCondition(HasRecord, 633)
	MisBeginCondition(HasRecord, 634)
	MisBeginCondition(HasRecord, 635)
	MisBeginCondition(HasRecord, 636)
	MisBeginCondition(HasRecord, 637)
	MisBeginAction(AddMission, 1801)
	MisBeginAction(AddTrigger, 18011, TE_KILL, 295, 5 )
	MisCancelAction(ClearMission, 1801)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000743 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000743")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000743)
	MisNeed(MIS_NEED_KILL, 295, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000744 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000744")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000744)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000745 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000745")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000745)
	MisResultCondition(NoRecord, 1801)
	MisResultCondition(HasMission, 1801)
	MisResultCondition(HasFlag, 1801, 14 )
	MisResultAction(ClearMission, 1801)
	MisResultAction(SetRecord, 1801)
	MisResultAction(AddExp, 50000, 50000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 295 )	
	TriggerAction( 1, AddNextFlag, 1801, 10, 5 )
	RegCurTrigger( 18011 )
	
-----------------------------------magicseaÉ³Èª²¹¸øÕ¾µÄ¸Ð¶÷lv9~19----------·Æ·Æ(797,3129) 
	MISSCRIPT_MISSIONSCRIPT05_LUA_000746 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000746")
	DefineMission( 6503, MISSCRIPT_MISSIONSCRIPT05_LUA_000746, 1802 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000747 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000747")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000747)
	MisBeginCondition(NoRecord, 1802)
	MisBeginCondition(NoMission, 1802)
	MisBeginCondition(HasRecord, 638)
	MisBeginCondition(HasRecord, 639)
	MisBeginCondition(HasRecord, 640)
	MisBeginCondition(HasRecord, 641)
	MisBeginCondition(HasRecord, 642)
	MisBeginCondition(HasRecord, 643)
	MisBeginCondition(HasRecord, 644)
	MisBeginCondition(HasRecord, 645)
	MisBeginCondition(HasRecord, 646)
	MisBeginCondition(HasRecord, 647)
	MisBeginCondition(HasRecord, 648)
	MisBeginCondition(HasRecord, 649)
	MisBeginCondition(HasRecord, 650)
	MisBeginCondition(HasRecord, 651)
	MisBeginCondition(HasRecord, 652)
	MisBeginAction(AddMission, 1802)
	MisCancelAction(ClearMission, 1802) ---ÈÎÎñ¿ÉÉ¾³ý
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000748 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000748")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000748)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000749 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000749")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000749)
	MisResultCondition(AlwaysFailure )
-----------------------------------magicseaÉ³Èª²¹¸øÕ¾µÄ¸Ð¶÷------------Î¬ÄÈ(781,3127)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000746 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000746")
	DefineMission( 6504, MISSCRIPT_MISSIONSCRIPT05_LUA_000746, 1802, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000750 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000750")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000750)
	MisResultCondition(NoRecord, 1802)
	MisResultCondition(HasMission, 1802)
	MisResultAction(ClearMission, 1802 )
	MisResultAction(SetRecord, 1802 )
	MisResultAction(AddExp,4400,4400)

---------magicsea°Í²¼²¹¸øÕ¾µÄ¸Ð¶÷ -------------------Ã×¶ûÃ×Àò(1244,3186)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000751 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000751")
	DefineMission( 6505, MISSCRIPT_MISSIONSCRIPT05_LUA_000751, 1803 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000752 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000752")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000752)
	MisBeginCondition(NoRecord, 1803)
	MisBeginCondition(NoMission, 1803)
	MisBeginCondition(HasRecord, 653)
	MisBeginCondition(HasRecord, 654)
	MisBeginCondition(HasRecord, 655)
	MisBeginCondition(HasRecord, 656)
	MisBeginCondition(HasRecord, 657)
	MisBeginCondition(HasRecord, 658)
	MisBeginCondition(HasRecord, 659)
	MisBeginCondition(HasRecord, 660)
	MisBeginCondition(HasRecord, 661)
	MisBeginCondition(HasRecord, 662)
	MisBeginCondition(HasRecord, 663)
	MisBeginCondition(HasRecord, 664)
	MisBeginCondition(HasRecord, 665)
	MisBeginCondition(HasRecord, 666)
	MisBeginCondition(HasRecord, 667)
	MisBeginAction(AddMission, 1803)
	MisBeginAction(AddTrigger, 18031, TE_GETITEM, 1848, 10 )
	MisCancelAction(ClearMission, 1803) ---ÈÎÎñ¿ÉÉ¾³ý
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000753 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000753")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000753)
	MisNeed(MIS_NEED_ITEM, 1848, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000754 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000754")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000754)--------------´ý¸Ä
	MISSCRIPT_MISSIONSCRIPT05_LUA_000755 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000755")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000755)
	MisResultCondition(NoRecord, 1803)
	MisResultCondition(HasMission, 1803)
	MisResultCondition(HasItem, 1848, 10)
	MisResultAction(TakeItem, 1848, 10)
	MisResultAction(ClearMission, 1803)
	MisResultAction(SetRecord, 1803)
	MisResultAction(AddExp,17000,17000)--------------´ý¸Ä

	InitTrigger()
	TriggerCondition( 1, IsItem, 1848 )	
	TriggerAction( 1, AddNextFlag, 1803, 10, 10 )
	RegCurTrigger( 18031 )
	
-----------------------------------darkblue±ù¶¼²¹¸øÕ¾------------¶¬´ïÃ×ÆÅÆÅ(795,363)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000756 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000756")
	DefineMission( 6506, MISSCRIPT_MISSIONSCRIPT05_LUA_000756, 1804 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000757 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000757")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000757)
	MisBeginCondition(NoRecord, 1804)
	MisBeginCondition(NoMission, 1804)
	MisBeginCondition(HasRecord, 668)
	MisBeginCondition(HasRecord, 669)
	MisBeginCondition(HasRecord, 670)
	MisBeginCondition(HasRecord, 671)
	MisBeginCondition(HasRecord, 672)
	MisBeginCondition(HasRecord, 673)
	MisBeginCondition(HasRecord, 674)
	MisBeginCondition(HasRecord, 675)
	MisBeginCondition(HasRecord, 676)
	MisBeginCondition(HasRecord, 677)
	MisBeginCondition(HasRecord, 678)
	MisBeginCondition(HasRecord, 679)
	MisBeginCondition(HasRecord, 680)
	MisBeginCondition(HasRecord, 681)
	MisBeginCondition(HasRecord, 682)
	MisBeginAction(AddMission, 1804)
	MisBeginAction(GiveItem, 6053, 1, 4)-------------°ü¹ü
	MisCancelAction(ClearMission, 1804) ---ÈÎÎñ¿ÉÉ¾³ý
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000758 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000758")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000758)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000759 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000759")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000759)
	MisResultCondition(AlwaysFailure )
-----------------------------------darkblue±ù¶¼²¹¸øÕ¾µÄ¸Ð¶÷------------ÄÎÄÎ(798,369)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000756 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000756")
	DefineMission( 6507, MISSCRIPT_MISSIONSCRIPT05_LUA_000756, 1804, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000760 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000760")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000760)
	MisResultCondition(NoRecord, 1804)
	MisResultCondition(HasMission, 1804)
	MisResultAction(ClearMission, 1804 )
	MisResultCondition(HasItem, 6053, 1)-------------°ü¹ü
	MisResultAction(TakeItem, 6053, 1)-------------°ü¹ü
	MisResultAction(SetRecord, 1804 )
	MisResultAction(AddExp,4400,4400)
	
-----------------darkblue°¢À¼±ÈË¹²¹¸øÕ¾µÄ¸Ð¶÷   --------------ÖìÀö²¼Âê(1049,673)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000761 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000761")
	DefineMission( 6508, MISSCRIPT_MISSIONSCRIPT05_LUA_000761, 1805 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000762 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000762")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000762)
	MisBeginCondition(NoRecord, 1805)
	MisBeginCondition(NoMission, 1805)
	MisBeginCondition(HasRecord, 683)
	MisBeginCondition(HasRecord, 684)
	MisBeginCondition(HasRecord, 685)
	MisBeginCondition(HasRecord, 686)
	MisBeginCondition(HasRecord, 687)
	MisBeginCondition(HasRecord, 688)
	MisBeginCondition(HasRecord, 689)
	MisBeginCondition(HasRecord, 690)
	MisBeginCondition(HasRecord, 691)
	MisBeginCondition(HasRecord, 692)
	MisBeginCondition(HasRecord, 693)
	MisBeginCondition(HasRecord, 694)
	MisBeginCondition(HasRecord, 695)
	MisBeginCondition(HasRecord, 696)
	MisBeginCondition(HasRecord, 697)
	MisBeginAction(AddMission, 1805)
	MisBeginAction(AddTrigger, 18051, TE_GETITEM, 1847, 1 )-----------Æ»¹û
	MisCancelAction(ClearMission, 1805) ---ÈÎÎñ¿ÉÉ¾³ý
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000763 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000763")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000763)
	MisNeed(MIS_NEED_ITEM, 1847, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000764 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000764")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000764)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000755 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000755")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000755)
	MisResultCondition(NoRecord, 1805)
	MisResultCondition(HasMission, 1805)
	MisResultCondition(HasItem, 1847, 1)-----------Æ»¹û
	MisResultAction(TakeItem, 1847, 1)-----------Æ»¹û
	MisResultAction(ClearMission, 1805)
	MisResultAction(SetRecord, 1805)
	
	MisResultAction(AddExp,17000,17000)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1847 )
	TriggerAction( 1, AddNextFlag, 1805, 10, 1 )
	RegCurTrigger( 18051 )
	
-----------------------------------darkblue÷¼÷ÃÓªµØ²¹¸øÕ¾µÄ¸Ð¶÷lv----------ÎûÎû¹þ¹þ(2142,556) 
	MISSCRIPT_MISSIONSCRIPT05_LUA_000765 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000765")
	DefineMission( 6509, MISSCRIPT_MISSIONSCRIPT05_LUA_000765, 1806 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000766 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000766")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000766)
	MisBeginCondition(NoRecord, 1806)
	MisBeginCondition(NoMission, 1806)
	MisBeginCondition(HasRecord, 802)
	MisBeginCondition(HasRecord, 803)
	MisBeginCondition(HasRecord, 804)
	MisBeginCondition(HasRecord, 805)
	MisBeginCondition(HasRecord, 806)
	MisBeginCondition(HasRecord, 807)
	MisBeginCondition(HasRecord, 808)
	MisBeginAction(AddMission, 1806)
	MisCancelAction(ClearMission, 1806) ---ÈÎÎñ¿ÉÉ¾³ý
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000767 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000767")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000767)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000768 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000768")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000768)
	MisResultCondition(AlwaysFailure )
-----------------------------------darkblue÷¼÷ÃÓªµØ²¹¸øÕ¾µÄ¸Ð¶÷------------ÐÞË¾(2138,545)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000765 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000765")
	DefineMission( 6510, MISSCRIPT_MISSIONSCRIPT05_LUA_000765, 1806, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000769 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000769")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000769)
	MisResultCondition(NoRecord, 1806)
	MisResultCondition(HasMission, 1806)
	MisResultAction(ClearMission, 1806 )
	MisResultAction(SetRecord, 1806 )
	MisResultAction(AddExp,53000,53000)
	
-----------------------------------garner·Ï¿ó²¹¸øÕ¾------------¿ËÀòÀòÑÅ(1914,2806)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000770 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000770")
	DefineMission( 6511, MISSCRIPT_MISSIONSCRIPT05_LUA_000770, 1807 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000771 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000771")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000771)
	MisBeginCondition(NoRecord, 1807)
	MisBeginCondition(NoMission, 1807)
	MisBeginCondition(HasRecord, 809)
	MisBeginCondition(HasRecord, 810)
	MisBeginCondition(HasRecord, 811)
	MisBeginCondition(HasRecord, 812)
	MisBeginCondition(HasRecord, 813)
	MisBeginCondition(HasRecord, 814)
	MisBeginCondition(NoRecord, 1807)
	MisBeginAction(AddMission, 1807)
	MisBeginAction(GiveItem, 6053, 1, 4)-------------°ü¹ü
	MisCancelAction(ClearMission, 1811) ---ÈÎÎñ¿ÉÉ¾³ý
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000772 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000772")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000772)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000773 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000773")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000773)
	MisResultCondition(AlwaysFailure )
-----------------------------------garner·Ï¿ó²¹¸øÕ¾µÄ¸Ð¶÷------------ÑÏÂÞËþ(1894,2798)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000770 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000770")
	DefineMission( 6512, MISSCRIPT_MISSIONSCRIPT05_LUA_000770, 1807, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000774 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000774")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000774)
	MisResultCondition(NoRecord, 1807)
	MisResultCondition(HasMission, 1807)
	MisResultAction(ClearMission, 1807 )
	MisResultCondition(HasItem, 6053, 1)-------------°ü¹ü
	MisResultAction(TakeItem, 6053, 1)-------------°ü¹ü
	MisResultAction(SetRecord, 1807 )
	MisResultAction(AddExp,43000,43000)
	
------------------garner¿¨¶û¼ÓµÂ²¹¸øÕ¾µÄ¸Ð¶÷  lv39~45 --------------º£À¶¡¤Î¢·ç(622,2106)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000775 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000775")
	DefineMission( 6513, MISSCRIPT_MISSIONSCRIPT05_LUA_000775, 1808 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000776 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000776")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000776)
	MisBeginCondition(NoRecord, 1808)
	MisBeginCondition(NoMission, 1808)
	MisBeginCondition(HasRecord, 837)
	MisBeginCondition(HasRecord, 838)
	MisBeginCondition(HasRecord, 839)
	MisBeginCondition(HasRecord, 840)
	MisBeginCondition(HasRecord, 841)
	MisBeginCondition(HasRecord, 842)
	MisBeginCondition(HasRecord, 843)
	MisBeginCondition(HasRecord, 844)
	MisBeginCondition(HasRecord, 845)
	MisBeginCondition(HasRecord, 846)
	MisBeginCondition(HasRecord, 847)
	MisBeginCondition(HasRecord, 848)
	MisBeginAction(AddMission, 1808)
	MisBeginAction(AddTrigger, 18081, TE_GETITEM, 1847, 1 )
	MisCancelAction(ClearMission, 1808) ---ÈÎÎñ¿ÉÉ¾³ý
	  
	MISSCRIPT_MISSIONSCRIPT05_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000777")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000777)
	MisNeed(MIS_NEED_ITEM, 1847, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000764 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000764")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000764)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000755 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000755")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000755)
	MisResultCondition(NoRecord, 1808)
	MisResultCondition(HasMission, 1808)
	MisResultCondition(HasItem, 1847, 1)
	MisResultAction(TakeItem, 1847, 1)
	MisResultAction(ClearMission, 1808)
	MisResultAction(SetRecord, 1808)
	MisResultAction(AddExp,144160,144160)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1847 )
	TriggerAction( 1, AddNextFlag, 1808, 10, 1 )
	RegCurTrigger( 18081 )
	
-----------------------------------darkblue±ù¼«²¹¸øÕ¾µÄ¸Ð¶÷lv------------Â³Â³(2668,634)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000778 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000778")
	DefineMission( 6514, MISSCRIPT_MISSIONSCRIPT05_LUA_000778, 1809 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000779 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000779")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000779)
	MisBeginCondition(NoMission, 1809)
	MisBeginCondition(NoRecord, 1809)
	MisBeginCondition(HasRecord, 869)
	MisBeginCondition(HasRecord, 870)
	MisBeginCondition(HasRecord, 871)
	MisBeginCondition(HasRecord, 872)
	MisBeginCondition(HasRecord, 873)
	MisBeginCondition(HasRecord, 874)
	MisBeginCondition(HasRecord, 875)
	MisBeginCondition(HasRecord, 876)
	MisBeginCondition(HasRecord, 877)
	MisBeginCondition(HasRecord, 878)
	MisBeginCondition(HasRecord, 879)
	MisBeginCondition(HasRecord, 880)
	MisBeginCondition(HasRecord, 881)
	MisBeginCondition(HasRecord, 882)
	MisBeginCondition(HasRecord, 883)
	MisBeginCondition(HasRecord, 884)
	MisBeginCondition(HasRecord, 885)
	MisBeginCondition(HasRecord, 886)
	MisBeginCondition(HasRecord, 887)
	MisBeginCondition(HasRecord, 888)
	MisBeginCondition(HasRecord, 889)
	MisBeginCondition(HasRecord, 890)
	MisBeginCondition(HasRecord, 891)
	MisBeginCondition(HasRecord, 892)
	MisBeginCondition(HasRecord, 893)	
	MisBeginAction(AddMission, 1809)
	MisBeginAction(AddTrigger, 18091, TE_KILL, 501, 5 )
	MisCancelAction(ClearMission, 1809)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000780 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000780")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000780)
	MisNeed(MIS_NEED_KILL, 501, 5, 10, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000781 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000781")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000781)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000782 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000782")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000782)
	MisResultCondition(NoRecord, 1809)
	MisResultCondition(HasMission, 1809)
	MisResultCondition(HasFlag, 1809, 14 )
	MisResultAction(ClearMission, 1809)
	MisResultAction(SetRecord, 1809)
	MisResultAction(AddExp, 193140, 193140)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 501 )	
	TriggerAction( 1, AddNextFlag, 1809, 10, 5 )
	RegCurTrigger( 18091 )	
	
----------------------------------------------ÐÂµºÇøÓòÈÎÎñ-----------------------------------------


------------------²¹¸øÕ¾µÄÓÉÀ´1--------------(¿ªÊ¼)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000783 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000783")
	DefineMission(6390, MISSCRIPT_MISSIONSCRIPT05_LUA_000783,1680)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000784")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000784)
	MisBeginCondition(NoRecord, 1680)
	MisBeginCondition(NoMission,1680)
	MisBeginCondition(LvCheck, ">", 89)
	MisBeginAction(AddMission, 1680)
	MisCancelAction(ClearMission, 1680)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000785 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000785")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000785)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000786 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000786")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000786)
	MisResultCondition(AlwaysFailure)
	
------------------²¹¸øÕ¾µÄÓÉÀ´1--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000783 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000783")
	DefineMission(6391, MISSCRIPT_MISSIONSCRIPT05_LUA_000783,1680, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000787 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000787")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000787)
	MisResultCondition(HasMission, 1680)
	MisResultCondition(NoRecord, 1680)
	MisResultAction(ClearMission, 1680)
	MisResultAction(SetRecord, 1680)
	MisResultAction(AddExp , 30000, 30000)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000788 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000788")
	MisResultAction(GiveNpcMission, 6392, MISSCRIPT_MISSIONSCRIPT05_LUA_000788, 2) 	
	
------------------ÌìÓîµÄÇëÇó--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000789 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000789")
	DefineMission(6392, MISSCRIPT_MISSIONSCRIPT05_LUA_000789,1681)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000790")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000790)
	MisBeginCondition(NoRecord, 1681)
	MisBeginCondition(NoMission,1681)
	MisBeginCondition(HasRecord,1680)
	MisBeginAction(AddMission, 1681)
	MisBeginAction(AddTrigger, 16811, TE_GETITEM, 6236, 15)
	MisBeginAction(AddTrigger, 16812, TE_GETITEM, 6237, 10)
	MisCancelAction(ClearMission, 1681)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000791 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000791")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000791)
	MisNeed(MIS_NEED_ITEM, 6236, 15, 10, 15)
	MisNeed(MIS_NEED_ITEM, 6237, 10, 30, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000792 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000792")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000792)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000793 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000793")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000793)
	MisResultCondition(HasMission, 1681)
	MisResultCondition(NoRecord, 1681)
	MisResultCondition(HasItem, 6236, 15)
	MisResultCondition(HasItem, 6237, 10)
	MisResultAction(ClearMission, 1681)
	MisResultAction(TakeItem, 6236, 15)
	MisResultAction(TakeItem, 6237, 10)
	MisResultAction(SetRecord, 1681)
	MisResultAction(AddExp, 675000, 675000)
	MisResultAction(AddMoney , 200000)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000788 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000788")
	MisResultAction(GiveNpcMission, 6393, MISSCRIPT_MISSIONSCRIPT05_LUA_000788, 3) 
	InitTrigger()
	TriggerCondition(1, IsItem, 6236)	
	TriggerAction(1, AddNextFlag,1681, 10, 15)
	RegCurTrigger(16811)

	InitTrigger()
	TriggerCondition(1, IsItem, 6237)	
	TriggerAction(1, AddNextFlag,1681, 30, 10)
	RegCurTrigger(16812)

------------------²¹¸øÕ¾µÄÓÉÀ´2--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000794 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000794")
	DefineMission(6393, MISSCRIPT_MISSIONSCRIPT05_LUA_000794,1682)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000795 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000795")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000795)
	MisBeginCondition(NoRecord, 1682)
	MisBeginCondition(NoMission,1682)
	MisBeginCondition(HasRecord, 1681)
	MisBeginAction(AddMission, 1682)
	MisCancelAction(ClearMission, 1682)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000796 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000796")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000796)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000797")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000797)
	MisResultCondition(AlwaysFailure)
	
------------------²¹¸øÕ¾µÄÓÉÀ´2--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000794 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000794")
	DefineMission(6394, MISSCRIPT_MISSIONSCRIPT05_LUA_000794,1682, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000798")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000798)
	MisResultCondition(HasMission, 1682)
	MisResultCondition(NoRecord, 1682)
	MisResultAction(ClearMission, 1682)
	MisResultAction(SetRecord, 1682)
	MisResultAction(AddExp , 30000, 30000)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000799 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000799")
	MisResultAction(GiveNpcMission, 6395, MISSCRIPT_MISSIONSCRIPT05_LUA_000799, 2)
------------------²¹¸øÕ¾µÄÓÉÀ´3--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000800 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000800")
	DefineMission(6395, MISSCRIPT_MISSIONSCRIPT05_LUA_000800,1683)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000801 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000801")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000801)
	MisBeginCondition(NoRecord, 1683)
	MisBeginCondition(NoMission,1683)
	MisBeginCondition(HasRecord, 1682)
	MisBeginAction(AddMission, 1683)
	MisCancelAction(ClearMission, 1683)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000802 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000802")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000802)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000803 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000803")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000803)
	MisResultCondition(AlwaysFailure)
	
------------------²¹¸øÕ¾µÄÓÉÀ´3--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000800 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000800")
	DefineMission(6396, MISSCRIPT_MISSIONSCRIPT05_LUA_000800,1683, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000804 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000804")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000804)
	MisResultCondition(HasMission, 1683)
	MisResultCondition(NoRecord, 1683)
	MisResultAction(ClearMission, 1683)
	MisResultAction(SetRecord, 1683)
	MisResultAction(AddExp , 30000, 30000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000805 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000805")
	MisResultAction(GiveNpcMission, 6397, MISSCRIPT_MISSIONSCRIPT05_LUA_000805, 2)
------------------²¹¸øÕ¾µÄÓÉÀ´4--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000806 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000806")
	DefineMission(6397, MISSCRIPT_MISSIONSCRIPT05_LUA_000806,1684)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000807 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000807")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000807)
	MisBeginCondition(NoRecord, 1684)
	MisBeginCondition(NoMission,1684)
	MisBeginCondition(HasRecord,1683)
	MisBeginAction(AddMission, 1684)
	MisBeginAction(AddTrigger, 16841, TE_GETITEM, 6241, 20)
	MisCancelAction(ClearMission, 1684)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000808 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000808")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000808)
	MisNeed(MIS_NEED_ITEM, 6241, 20, 10, 20)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000809 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000809")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000809)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000810 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000810")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000810)
	MisResultCondition(HasMission, 1684)
	MisResultCondition(NoRecord, 1684)
	MisResultCondition(HasItem, 6241, 20)
	MisResultAction(ClearMission, 1684)
	MisResultAction(TakeItem, 6241, 20)
	MisResultAction(SetRecord, 1684)
	MisResultAction(AddExp, 605000, 605000)
	MisResultAction(AddMoney ,150000)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6241)	
	TriggerAction(1, AddNextFlag,1684, 10, 20)
	RegCurTrigger(16841)

------------------·³ÄÕµÄÂêÀö°²--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000811 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000811")
	DefineMission(6398, MISSCRIPT_MISSIONSCRIPT05_LUA_000811,1685)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000812 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000812")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000812)
	MisBeginCondition(NoRecord, 1685)
	MisBeginCondition(NoMission,1685)
	MisBeginCondition(LvCheck, ">", 89)
	MisBeginAction(AddMission, 1685)
	MisBeginAction(AddTrigger, 16851, TE_KILL, 1083, 10)
	MisBeginAction(AddTrigger, 16852, TE_KILL, 1084, 15)
	MisBeginAction(AddTrigger, 16853, TE_KILL, 1085, 20)
	MisCancelAction(ClearMission, 1685)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000813 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000813")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000813)
	MisNeed(MIS_NEED_KILL, 1083, 10, 10,10)
	MisNeed(MIS_NEED_KILL, 1084, 15, 20,15)
	MisNeed(MIS_NEED_KILL, 1085, 20, 40,20)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000814 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000814")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000814)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000815 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000815")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000815)
	MisResultCondition(HasMission, 1685)
	MisResultCondition(NoRecord, 1685)
	MisResultCondition(HasFlag, 1685, 19)
	MisResultCondition(HasFlag, 1685, 34)
	MisResultCondition(HasFlag, 1685, 59)
	MisResultAction(ClearMission, 1685)
	MisResultAction(SetRecord, 1685)
	MisResultAction(AddExp, 675000, 675000)
	MisResultAction(AddMoney , 200000)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1083)	
	TriggerAction(1, AddNextFlag,1685, 10, 10)
	RegCurTrigger(16851)	
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1084)	
	TriggerAction(1, AddNextFlag,1685, 20, 15)
	RegCurTrigger(16852)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1085)	
	TriggerAction(1, AddNextFlag,1685, 40, 20)
	RegCurTrigger(16853)

------------------°ãÈôÊÀ½çµÄ´«ÎÅ--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000816 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000816")
	DefineMission(6399, MISSCRIPT_MISSIONSCRIPT05_LUA_000816,1686)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000817 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000817")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000817)
	MisBeginCondition(NoRecord, 1686)
	MisBeginCondition(NoMission,1686)
	MisBeginCondition(LvCheck, ">", 89)
	MisBeginAction(AddMission, 1686)
	MisCancelAction(ClearMission, 1686)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000818 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000818")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000818)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000819 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000819")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000819)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000820 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000820")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000820)
	MisResultCondition(HasMission, 1686)
	MisResultCondition(NoRecord, 1686)
	MisResultCondition(HasItem, 6221,1)
	MisResultCondition(HasItem, 6222,1)
	MisResultAction(ClearMission, 1686)
	MisResultAction(TakeItem, 6221, 1)
	MisResultAction(TakeItem, 6222, 1)
	MisResultAction(SetRecord, 1686)
	MisResultAction(AddExp , 675000, 675000)		

------------------¸ñ¹ÅÂåµÄÎ¢Ð¦--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000821 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000821")
	DefineMission(6400, MISSCRIPT_MISSIONSCRIPT05_LUA_000821,1687)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000822 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000822")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000822)
	MisBeginCondition(NoRecord, 1687)
	MisBeginCondition(NoMission,1687)
	MisBeginCondition(HasMission,1686)
	MisBeginAction(AddMission, 1687)
	MisBeginAction(AddTrigger, 16871, TE_GETITEM, 6239, 20)
	MisCancelAction(ClearMission, 1687)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000823 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000823")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000823)
	MisNeed(MIS_NEED_ITEM, 6239, 20, 10, 20)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000824 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000824")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000824)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000825 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000825")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000825)
	MisResultCondition(HasMission, 1687)
	MisResultCondition(NoRecord, 1687)
	MisResultCondition(HasItem, 6239, 20)
	MisResultAction(ClearMission, 1687)
	MisResultAction(TakeItem, 6239,20)
	MisResultAction(SetRecord, 1687)
	MisResultAction(GiveItem, 6221, 1,4)
	MisResultAction(AddExp, 605000, 605000)
	MisResultAction(AddMoney , 150000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6239)	
	TriggerAction(1, AddNextFlag,1687, 10, 20)
	RegCurTrigger(16871)

------------------´ï¶ûµÄ¸ß°Á--------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000826 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000826")
	DefineMission(6401, MISSCRIPT_MISSIONSCRIPT05_LUA_000826,1688)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000827 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000827")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000827)
	MisBeginCondition(NoRecord, 1688)
	MisBeginCondition(NoMission,1688)
	MisBeginCondition(HasMission,1686)
	MisBeginAction(AddMission, 1688)
	MisBeginAction(AddTrigger, 16881, TE_GETITEM, 6238, 10)
	MisCancelAction(ClearMission, 1688)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000828 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000828")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000828)
	MisNeed(MIS_NEED_ITEM, 6238, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000829 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000829")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000829)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000830 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000830")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000830)
	MisResultCondition(HasMission, 1688)
	MisResultCondition(NoRecord, 1688)
	MisResultCondition(HasItem, 6238, 10)
	MisResultAction(ClearMission, 1688)
	MisResultAction(TakeItem, 6238, 10)
	MisResultAction(SetRecord, 1688)
	MisResultAction(GiveItem, 6222, 1,4)
	MisResultAction(AddExp, 605000, 605000)
	MisResultAction(AddMoney , 150000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6238)	
	TriggerAction(1, AddNextFlag,1688, 10, 10)
	RegCurTrigger(16881)

------------------¶¬¼ÒËÄÐÖµÜ1--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000831 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000831")
	DefineMission(6402, MISSCRIPT_MISSIONSCRIPT05_LUA_000831,1689)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000832 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000832")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000832)
	MisBeginCondition(NoRecord, 1689)
	MisBeginCondition(NoMission,1689)
	MisBeginCondition(LvCheck, ">", 94)
	MisBeginAction(AddMission, 1689)
	MisCancelAction(ClearMission, 1689)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000833 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000833")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000833)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000834 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000834")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000834)
	MisResultCondition(AlwaysFailure)
	
------------------¶¬¼ÒËÄÐÖµÜ1--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000831 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000831")
	DefineMission(6403, MISSCRIPT_MISSIONSCRIPT05_LUA_000831,1689, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000835 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000835")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000835)
	MisResultCondition(HasMission, 1689)
	MisResultCondition(NoRecord, 1689)
	MisResultAction(ClearMission, 1689)
	MisResultAction(SetRecord, 1689)
	MisResultAction(AddExp , 30000, 30000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000836 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000836")
	MisResultAction(GiveNpcMission, 6404, MISSCRIPT_MISSIONSCRIPT05_LUA_000836, 2)
------------------¶¬¼ÒËÄÐÖµÜ2--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000837 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000837")
	DefineMission(6404, MISSCRIPT_MISSIONSCRIPT05_LUA_000837,1690)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000838 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000838")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000838)
	MisBeginCondition(NoRecord, 1690)
	MisBeginCondition(NoMission,1690)
	MisBeginCondition(HasRecord, 1689)
	MisBeginAction(AddMission, 1690)
	MisBeginAction(GiveItem, 6227, 1,4)
	MisBeginBagNeed(1)
	MisCancelAction(ClearMission, 1690)
	MisCancelAction(TakeItem, 6227,1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000839 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000839")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000839)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000840 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000840")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000840)
	MisResultCondition(AlwaysFailure)
	
------------------¶¬¼ÒËÄÐÖµÜ2--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000837 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000837")
	DefineMission(6405, MISSCRIPT_MISSIONSCRIPT05_LUA_000837,1690, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000841 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000841")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000841)
	MisResultCondition(HasMission, 1690)
	MisResultCondition(NoRecord, 1690)
	MisResultCondition(HasItem, 6227,1)
	MisResultAction(ClearMission, 1690)
	MisResultAction(TakeItem, 6227, 1)
	MisResultAction(SetRecord, 1690)
	MisResultAction(AddExp , 30000, 30000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000842 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000842")
	MisResultAction(GiveNpcMission, 6406, MISSCRIPT_MISSIONSCRIPT05_LUA_000842, 2)
------------------¶¬¼ÒËÄÐÖµÜ3--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000843 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000843")
	DefineMission(6406, MISSCRIPT_MISSIONSCRIPT05_LUA_000843,1691)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000844 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000844")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000844)
	MisBeginCondition(NoRecord, 1691)
	MisBeginCondition(NoMission,1691)
	MisBeginCondition(HasRecord, 1690)
	MisBeginAction(AddMission, 1691)
	MisCancelAction(ClearMission, 1691)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000845 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000845")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000845)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000846 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000846")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000846)
	MisResultCondition(AlwaysFailure)
	
------------------¶¬¼ÒËÄÐÖµÜ3--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000843 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000843")
	DefineMission(6407, MISSCRIPT_MISSIONSCRIPT05_LUA_000843,1691, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000847 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000847")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000847)
	MisResultCondition(HasMission, 1691)
	MisResultCondition(NoRecord, 1691)
	MisResultAction(ClearMission, 1691)
	MisResultAction(SetRecord, 1691)
	MisResultAction(AddExp , 30000, 30000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000848 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000848")
	MisResultAction(GiveNpcMission, 6408, MISSCRIPT_MISSIONSCRIPT05_LUA_000848, 2)
------------------¶¬¼ÒËÄÐÖµÜ4--------------	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000849 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000849")
	DefineMission(6408, MISSCRIPT_MISSIONSCRIPT05_LUA_000849,1692)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000850 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000850")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000850)
	MisBeginCondition(NoRecord, 1692)
	MisBeginCondition(NoMission,1692)
	MisBeginCondition(HasRecord, 1691)
	MisBeginAction(AddMission, 1692)
	MisBeginAction(AddTrigger, 16921, TE_KILL, 1082, 10)
	MisCancelAction(ClearMission, 1692)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000851 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000851")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000851)
	MisNeed(MIS_NEED_KILL, 1082, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000852 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000852")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000852)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000853 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000853")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000853)
	MisResultCondition(HasMission, 1692)
	MisResultCondition(NoRecord, 1692)
	MisResultCondition(HasFlag, 1692, 19)
	MisResultAction(ClearMission, 1692)
	MisResultAction(SetRecord, 1692)
	MisResultAction(AddExp, 675000, 675000)
	MisResultAction(AddMoney , 200000)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1082)	
	TriggerAction(1, AddNextFlag,1692, 10, 10)
	RegCurTrigger(16921)		
	
------------------Ñ©À­µºÊØ»¤ÕßÖ®Ö¤--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000854 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000854")
	DefineMission(6409, MISSCRIPT_MISSIONSCRIPT05_LUA_000854,1693)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000855 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000855")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000855)
	MisBeginCondition(NoRecord, 1693)
	MisBeginCondition(NoMission,1693)
	MisBeginCondition(LvCheck, ">", 94)
	MisBeginAction(AddMission, 1693)
	MisBeginAction(AddTrigger, 16931, TE_GETITEM, 6240, 1)
	MisBeginAction(AddTrigger, 16932, TE_GETITEM, 6242, 1)
	MisBeginAction(AddTrigger, 16933, TE_GETITEM, 1239, 1)
	MisBeginAction(AddTrigger, 16934, TE_GETITEM, 4453, 1)
	MisCancelAction(ClearMission, 1693)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000856 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000856")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000856)
	MisNeed(MIS_NEED_ITEM, 6240, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 6242, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 1239, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 4453, 1, 40, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000857 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000857")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000857)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000858 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000858")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000858)
	MisResultCondition(HasMission, 1693)
	MisResultCondition(NoRecord, 1693)
	MisResultCondition(HasItem, 6240,1)
	MisResultCondition(HasItem, 6242,1)
	MisResultCondition(HasItem, 1239,1)
	MisResultCondition(HasItem, 4453,1)
	MisResultAction(ClearMission, 1693)
	MisResultAction(TakeItem, 6240, 1)
	MisResultAction(TakeItem, 6242, 1)
	MisResultAction(TakeItem, 1239, 1)
	MisResultAction(TakeItem, 4453, 1)
	MisResultAction(GiveItem, 6223,1,4)
	MisResultAction(SetRecord, 1693)
	MisResultAction(AddExp, 800000, 800000)
	MisResultAction(AddMoney , 250000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6240)	
	TriggerAction(1, AddNextFlag, 1693, 10, 1)
	RegCurTrigger(16931)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6242)	
	TriggerAction(1, AddNextFlag, 1693, 20, 1)
	RegCurTrigger(16932)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 1239)	
	TriggerAction(1, AddNextFlag, 1693, 30, 1)
	RegCurTrigger(16933)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 4453)	
	TriggerAction(1, AddNextFlag, 1693, 40, 1)
	RegCurTrigger(16934)
	
------------------Ñ©Î¬µºÊØ»¤ÕßÖ®Ö¤--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000859 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000859")
	DefineMission(6410, MISSCRIPT_MISSIONSCRIPT05_LUA_000859,1694)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000860 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000860")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000860)
	MisBeginCondition(NoRecord, 1694)
	MisBeginCondition(NoMission,1694)
	MisBeginCondition(LvCheck, ">", 97)
	MisBeginAction(AddMission, 1694)
	MisBeginAction(AddTrigger, 16941, TE_KILL, 1090, 10)
	MisBeginAction(AddTrigger, 16942, TE_KILL, 1091, 15)
	MisBeginAction(AddTrigger, 16943, TE_KILL, 1092, 20)
	MisCancelAction(ClearMission, 1694)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000861 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000861")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000861)
	MisNeed(MIS_NEED_KILL, 1090, 10, 10, 10)
	MisNeed(MIS_NEED_KILL, 1091, 15, 20, 15)
	MisNeed(MIS_NEED_KILL, 1092, 20, 40, 20)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000862 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000862")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000862)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000863 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000863")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000863)
	MisResultCondition(HasMission, 1694)
	MisResultCondition(NoRecord, 1694)
	MisResultCondition(HasFlag, 1694, 19)
	MisResultCondition(HasFlag, 1694, 34)
	MisResultCondition(HasFlag, 1694, 59)
	MisResultAction(ClearMission, 1694)
	MisResultAction(GiveItem, 6224,1,4)
	MisResultAction(SetRecord, 1694)
	MisResultAction(AddExp, 900000, 900000)
	MisResultAction(AddMoney , 250000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1090)	
	TriggerAction(1, AddNextFlag,1694, 10, 10)
	RegCurTrigger(16941)			
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1091)	
	TriggerAction(1, AddNextFlag,1694, 20, 15)
	RegCurTrigger(16942)	
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1092)	
	TriggerAction(1, AddNextFlag,1694, 40, 20)
	RegCurTrigger(16943)	
	
------------------¶¬ºþµºÊØ»¤ÕßÖ®Ö¤--------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000864 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000864")
	DefineMission(6411, MISSCRIPT_MISSIONSCRIPT05_LUA_000864,1695)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000865 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000865")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000865)
	MisBeginCondition(NoRecord, 1695)
	MisBeginCondition(NoMission,1695)
	MisBeginCondition(LvCheck, ">", 99)
	MisBeginAction(AddMission, 1695)
	MisBeginAction(AddTrigger, 16951, TE_KILL, 1084, 10)
	MisBeginAction(AddTrigger, 16952, TE_KILL, 1085, 15)
	MisBeginAction(AddTrigger, 16953, TE_KILL, 1086, 20)
	MisBeginAction(AddTrigger, 16954, TE_GETITEM, 6244, 1)
	MisBeginAction(AddTrigger, 16955, TE_GETITEM, 4762, 1)
	MisBeginAction(AddTrigger, 16956, TE_GETITEM, 4808, 1)
	MisBeginAction(AddTrigger, 16957, TE_GETITEM, 4735, 1)
	MisCancelAction(ClearMission, 1695)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000866 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000866")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000866)
	MisNeed(MIS_NEED_KILL, 1084, 10, 10, 10)
	MisNeed(MIS_NEED_KILL, 1085, 15, 20, 15)
	MisNeed(MIS_NEED_KILL, 1086, 20, 40, 20)
	MisNeed(MIS_NEED_ITEM, 6244, 1, 60, 1)
	MisNeed(MIS_NEED_ITEM, 4762, 1, 70, 1)
	MisNeed(MIS_NEED_ITEM, 4808, 1, 80, 1)
	MisNeed(MIS_NEED_ITEM, 4735, 1, 90, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000867 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000867")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000867)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000868 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000868")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000868)
	MisResultCondition(HasMission, 1695)
	MisResultCondition(NoRecord, 1695)
	MisResultCondition(HasFlag, 1695, 19)
	MisResultCondition(HasFlag, 1695, 34)
	MisResultCondition(HasFlag, 1695, 59)
	MisResultCondition(HasItem, 6244,1)
	MisResultCondition(HasItem, 4762,1)
	MisResultCondition(HasItem, 4808,1)
	MisResultCondition(HasItem, 4735,1)
	MisResultAction(ClearMission, 1695)
	MisResultAction(TakeItem, 6244, 1)
	MisResultAction(TakeItem, 4762, 1)
	MisResultAction(TakeItem, 4808, 1)
	MisResultAction(TakeItem, 4735, 1)
	MisResultAction(GiveItem, 6225,1,4)
	MisResultAction(SetRecord, 1695)
	MisResultAction(AddExp, 1000000, 1000000)
	MisResultAction(AddMoney , 300000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1084)	
	TriggerAction(1, AddNextFlag,1695, 10, 10)
	RegCurTrigger(16951)			
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1085)	
	TriggerAction(1, AddNextFlag,1695, 20, 15)
	RegCurTrigger(16952)	
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1086)	
	TriggerAction(1, AddNextFlag,1695, 40, 20)
	RegCurTrigger(16953)	
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6244)	
	TriggerAction(1, AddNextFlag, 1695, 60, 1)
	RegCurTrigger(16954)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 4762)	
	TriggerAction(1, AddNextFlag, 1695, 70, 1)
	RegCurTrigger(16955)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 4808)	
	TriggerAction(1, AddNextFlag, 1695, 80, 1)
	RegCurTrigger(16956)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 4735)	
	TriggerAction(1, AddNextFlag, 1695, 90, 1)
	RegCurTrigger(16957)

------------------ÏþÔÂÔ²ÎèÕß--------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000869 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000869")
	DefineMission(6412, MISSCRIPT_MISSIONSCRIPT05_LUA_000869,1696)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000870 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000870")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000870)
	MisBeginCondition(NoRecord, 1696)
	MisBeginCondition(NoMission,1696)
	MisBeginCondition(LvCheck, ">", 99)
	MisBeginAction(AddMission, 1696)
	MisBeginAction(AddTrigger, 16961, TE_GETITEM, 6223, 1)
	MisBeginAction(AddTrigger, 16962, TE_GETITEM, 6224, 1)
	MisBeginAction(AddTrigger, 16963, TE_GETITEM, 6225, 1)
	MisCancelAction(ClearMission, 1696)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000871 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000871")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000871)
	MisNeed(MIS_NEED_ITEM, 6223, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 6224, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 6225, 1, 30, 1)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000872 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000872")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000872)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000873 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000873")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000873)
	MisResultCondition(HasMission, 1696)
	MisResultCondition(NoRecord, 1696)
	MisResultCondition(HasItem, 6223,1)
	MisResultCondition(HasItem, 6224,1)
	MisResultCondition(HasItem, 6225,1)
	MisResultAction(ClearMission, 1696)
	MisResultAction(TakeItem, 6223, 1)
	MisResultAction(TakeItem, 6224, 1)
	MisResultAction(TakeItem, 6225, 1)
	MisResultAction(GiveItem, 6226,1,4)
	MisResultAction(SetRecord, 1696)
	MisResultAction(AddExp, 1000000, 1000000)
	MisResultAction(AddMoney , 300000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6223)	
	TriggerAction(1, AddNextFlag, 1695, 10, 1)
	RegCurTrigger(16961)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6224)	
	TriggerAction(1, AddNextFlag, 1695, 20, 1)
	RegCurTrigger(16962)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6225)	
	TriggerAction(1, AddNextFlag, 1695, 30, 1)
	RegCurTrigger(16963)
	
------------------ÊØ»¤³¤µÄÇëÇó--------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000874 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000874")
	DefineMission(6413, MISSCRIPT_MISSIONSCRIPT05_LUA_000874,1697)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000875 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000875")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000875)
	MisBeginCondition(NoRecord, 1697)
	MisBeginCondition(NoMission,1697)
	MisBeginCondition(LvCheck, ">", 99)
	MisBeginAction(AddMission, 1697)
	MisBeginAction(AddTrigger, 16971, TE_KILL, 1095, 20)
	MisCancelAction(ClearMission, 1697)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000876 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000876")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000876)
	MisNeed(MIS_NEED_KILL, 1095, 20, 10, 20)

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000877 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000877")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000877)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000878 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000878")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000878)
	MisResultCondition(HasMission, 1697)
	MisResultCondition(NoRecord, 1697)
	MisResultCondition(HasFlag, 1697, 29)
	MisResultAction(ClearMission, 1697)
	MisResultAction(SetRecord, 1697)
	MisResultAction(AddExp, 1000000, 1000000)
	MisResultAction(AddMoney , 250000)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1095)	
	TriggerAction(1, AddNextFlag,1697, 10, 20)
	RegCurTrigger(16971)			

------------------¿ËÀïË¹µÄÇéÊé--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000879 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000879")
	DefineMission(6414, MISSCRIPT_MISSIONSCRIPT05_LUA_000879,1698)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000880 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000880")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000880)
	MisBeginCondition(NoRecord, 1698)
	MisBeginCondition(NoMission,1698)
	MisBeginCondition(LvCheck, ">", 94)
	MisBeginAction(GiveItem, 6228,1,4)
	MisBeginAction(AddMission, 1698)
	MisCancelAction(ClearMission, 1698)
	MisCancelAction(TakeItem, 6228,1)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000881 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000881")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000881)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000882 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000882")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000882)
	MisResultCondition(AlwaysFailure)
	
------------------¿ËÀïË¹µÄÇéÊé--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000879 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000879")
	DefineMission(6415, MISSCRIPT_MISSIONSCRIPT05_LUA_000879,1698, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000883 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000883")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000883)
	MisResultCondition(HasMission, 1698)
	MisResultCondition(NoRecord, 1698)
	MisResultCondition(HasItem, 6228,1)
	MisResultAction(ClearMission, 1698)
	MisResultAction(TakeItem, 6228, 1)
	MisResultAction(SetRecord, 1698)
	MisResultAction(AddExp , 50000, 50000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000884 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000884")
	MisResultAction(GiveNpcMission, 6416, MISSCRIPT_MISSIONSCRIPT05_LUA_000884, 2) 
------------------¼ª¶ûµÄ»ØÓ¦--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000884 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000884")
	DefineMission(6416, MISSCRIPT_MISSIONSCRIPT05_LUA_000884,1699)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000885 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000885")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000885)
	MisBeginCondition(NoRecord, 1699)
	MisBeginCondition(NoMission,1699)
	MisBeginCondition(HasRecord, 1698)
	MisBeginAction(GiveItem, 6229,1,4)
	MisBeginAction(AddMission, 1699)
	MisCancelAction(ClearMission, 1699)
	MisCancelAction(TakeItem, 6229,1)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000886 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000886")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000886)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000887 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000887")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000887)
	MisResultCondition(AlwaysFailure)
	
------------------¼ª¶ûµÄ»ØÓ¦--------------(½áÊø)	
			
	MISSCRIPT_MISSIONSCRIPT05_LUA_000884 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000884")
	DefineMission(6417, MISSCRIPT_MISSIONSCRIPT05_LUA_000884,1699, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000888 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000888")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000888)
	MisResultCondition(HasMission, 1699)
	MisResultCondition(NoRecord, 1699)
	MisResultCondition(HasItem, 6229,1)
	MisResultAction(ClearMission, 1699)
	MisResultAction(TakeItem, 6229, 1)
	MisResultAction(SetRecord, 1699)
	MisResultAction(AddExp , 50000, 50000)		
	
------------------²ÔÔÂÊ®×Ö¼Ü--------------(¿ªÊ¼)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000889 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000889")
	DefineMission(6418, MISSCRIPT_MISSIONSCRIPT05_LUA_000889,1700)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000890 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000890")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000890)
	MisBeginCondition(NoRecord, 1700)
	MisBeginCondition(NoMission,1700)
	MisBeginCondition(LvCheck, ">", 94)
	MisBeginAction(GiveItem, 6230,1,4)
	MisBeginAction(AddMission, 1700)
	MisCancelAction(ClearMission, 1700)
	MisCancelAction(TakeItem, 6230,1)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000891 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000891")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000891)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000892 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000892")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000892)
	MisResultCondition(AlwaysFailure)
	
------------------²ÔÔÂÊ®×Ö¼Ü--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000889 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000889")
	DefineMission(6419, MISSCRIPT_MISSIONSCRIPT05_LUA_000889,1700, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000893 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000893")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000893)
	MisResultCondition(HasMission, 1700)
	MisResultCondition(NoRecord, 1700)
	MisResultCondition(HasItem, 6230,1)
	MisResultAction(ClearMission, 1700)
	MisResultAction(TakeItem, 6230, 1)
	MisResultAction(SetRecord, 1700)
	MisResultAction(AddExp , 50000, 50000)		

-----------------Î¬¶ûµÄµ£ÐÄ---------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000894 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000894")
	DefineMission(6420, MISSCRIPT_MISSIONSCRIPT05_LUA_000894,1701)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000895 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000895")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000895)
	MisBeginCondition(NoRecord, 1701)
	MisBeginCondition(NoMission,1701)
	MisBeginCondition(LvCheck, ">", 104)
	MisBeginAction(AddMission, 1701)
	MisBeginAction(AddTrigger, 17011, TE_GETITEM, 6248, 1)
	MisCancelAction(ClearMission, 1701)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000896 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000896")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000896)
	MisNeed(MIS_NEED_ITEM, 6248, 1, 10,1)
	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000897 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000897")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000897)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000898 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000898")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000898)
	MisResultCondition(HasMission, 1701)
	MisResultCondition(NoRecord, 1701)
	MisResultCondition(HasItem, 6248, 1)
	MisResultAction(ClearMission, 1701)
	MisResultAction(TakeItem, 6248, 1)
	MisResultAction(SetRecord, 1701)
	MisResultAction(AddExp, 1200000, 1200000)
	MisResultAction(AddMoney , 400000)
	
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6248)	
	TriggerAction(1, AddNextFlag, 1701, 10, 1)
	RegCurTrigger(17011)
	
------------------------ÍþË¹ÌØµÄ¶Ê»ð-----------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000899 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000899")
	DefineMission(6421, MISSCRIPT_MISSIONSCRIPT05_LUA_000899,1702)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000900 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000900")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000900)
	MisBeginCondition(NoRecord, 1702)
	MisBeginCondition(NoMission,1702)
	MisBeginCondition(LvCheck, ">", 89)
	MisBeginAction(AddMission, 1702)
	MisBeginAction(AddTrigger, 17021, TE_KILL, 1089, 20)
	MisCancelAction(ClearMission, 1702)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000901 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000901")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000901)
	MisNeed(MIS_NEED_KILL, 1089, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000902 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000902")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000902)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000903 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000903")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000903)
	MisResultCondition(HasMission, 1702)
	MisResultCondition(NoRecord, 1702)
	MisResultCondition(HasFlag, 1702, 29)
	MisResultAction(ClearMission, 1702)
	MisResultAction(SetRecord, 1702)
	MisResultAction(AddExp, 675000, 675000)
	MisResultAction(AddMoney , 200000)
		
	InitTrigger()
	TriggerCondition(1, IsMonster, 1089)	
	TriggerAction(1, AddNextFlag,1702, 10, 20)
	RegCurTrigger(17021)

-------------------------·³ÈËµÄÔÓÎï----------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000904 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000904")
	DefineMission(6422, MISSCRIPT_MISSIONSCRIPT05_LUA_000904,1703)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000905 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000905")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000905)
	MisBeginCondition(NoRecord, 1703)
	MisBeginCondition(NoMission,1703)
	MisBeginCondition(LvCheck, ">", 104)
	MisBeginAction(AddMission, 1703)
	MisBeginAction(AddTrigger, 17031, TE_KILL, 1097,10)
	MisBeginAction(AddTrigger, 17032, TE_KILL, 1098,10)
	MisCancelAction(ClearMission, 1703)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000906 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000906")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000906)
	MisNeed(MIS_NEED_KILL, 1097, 10, 10, 10)
	MisNeed(MIS_NEED_KILL, 1098, 10, 20, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000907 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000907")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000907)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000908 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000908")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000908)
	MisResultCondition(HasMission, 1703)
	MisResultCondition(NoRecord, 1703)
	MisResultCondition(HasFlag, 1703, 19)
	MisResultCondition(HasFlag, 1703, 29)
	MisResultAction(ClearMission, 1703)
	MisResultAction(SetRecord, 1703)
	MisResultAction(AddExp, 1200000, 1200000)
	MisResultAction(AddMoney , 400000)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1097)	
	TriggerAction(1, AddNextFlag,1703, 10, 10)
	RegCurTrigger(17031)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1098)	
	TriggerAction(1, AddNextFlag,1703, 20, 10)
	RegCurTrigger(17032)
	
-------------------------ÉÏ¹Å¾íÖá--------------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000909 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000909")
	DefineMission(6423, MISSCRIPT_MISSIONSCRIPT05_LUA_000909,1704)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000910 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000910")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000910)
	MisBeginCondition(NoRecord, 1704)
	MisBeginCondition(NoMission,1704)
	MisBeginCondition(LvCheck, ">", 104)
	MisBeginAction(AddMission, 1704)
	MisBeginAction(AddTrigger, 17041, TE_GETITEM, 6249, 5)
	MisBeginAction(AddTrigger, 17042, TE_GETITEM, 6247, 5)
	MisBeginAction(AddTrigger, 17043, TE_GETITEM, 6243, 5)
	MisCancelAction(ClearMission, 1704)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000911 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000911")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000911)
	MisNeed(MIS_NEED_ITEM, 6249, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 6247, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 6243, 5, 30, 5)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000912 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000912")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000912)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000913 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000913")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000913)
	MisResultCondition(HasMission, 1704)
	MisResultCondition(NoRecord, 1704)
	MisResultCondition(HasItem, 6249, 5)
	MisResultCondition(HasItem, 6247, 5)
	MisResultCondition(HasItem, 6243, 5)
	MisResultAction(ClearMission, 1704)
	MisResultAction(TakeItem, 6249, 5)
	MisResultAction(TakeItem, 6247, 5)
	MisResultAction(TakeItem, 6243, 5)
	MisResultAction(GiveItem, 6235, 1,4)
	MisResultAction(SetRecord, 1704)
	MisResultAction(AddExp , 1200000, 1200000)
	MisResultAction(AddMoney , 400000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 6249)	
	TriggerAction(1, AddNextFlag,1704, 10, 5)
	RegCurTrigger(17041)

	InitTrigger()
	TriggerCondition(1, IsItem, 6247)	
	TriggerAction(1, AddNextFlag,1704, 20, 5)
	RegCurTrigger(17042)

	InitTrigger()
	TriggerCondition(1, IsItem, 6243)	
	TriggerAction(1, AddNextFlag,1704, 30, 5)
	RegCurTrigger(17043)
	
-------------------------ÎÞ¾¡µÄÄýÍû--------------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000914 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000914")
	DefineMission(6424, MISSCRIPT_MISSIONSCRIPT05_LUA_000914,1705)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000915 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000915")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000915)
	MisBeginCondition(NoRecord, 1705)
	MisBeginCondition(NoMission,1705)
	MisBeginCondition(LvCheck, ">", 99)
	MisBeginAction(AddMission, 1705)
	MisCancelAction(ClearMission, 1705)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000916 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000916")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000916)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000917 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000917")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000917)
	MisResultCondition(AlwaysFailure)
	
------------------ÎÞ¾¡µÄÄýÍû--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000914 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000914")
	DefineMission(6425, MISSCRIPT_MISSIONSCRIPT05_LUA_000914,1705, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000918 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000918")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000918)
	MisResultCondition(HasMission, 1705)
	MisResultCondition(NoRecord, 1705)
	MisResultAction(ClearMission, 1705)
	MisResultAction(SetRecord, 1705)
	MisResultAction(AddExp , 30000, 30000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000919 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000919")
	MisResultAction(GiveNpcMission, 6426, MISSCRIPT_MISSIONSCRIPT05_LUA_000919, 2) 
-------------------------µÆ»ðÀ»Éº´¦--------------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000920 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000920")
	DefineMission(6426, MISSCRIPT_MISSIONSCRIPT05_LUA_000920,1706)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000921 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000921")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000921)
	MisBeginCondition(NoRecord, 1706)
	MisBeginCondition(NoMission,1706)
	MisBeginCondition(HasRecord, 1705)
	MisBeginAction(AddMission, 1706)
	MisCancelAction(ClearMission, 1706)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000922 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000922")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000922)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000923 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000923")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000923)
	MisResultCondition(AlwaysFailure)
	
------------------µÆ»ðÀ»Éº´¦--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000920 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000920")
	DefineMission(6427, MISSCRIPT_MISSIONSCRIPT05_LUA_000920,1706, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000924 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000924")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000924)
	MisResultCondition(HasMission, 1706)
	MisResultCondition(NoRecord, 1706)
	MisResultAction(ClearMission, 1706)
	MisResultAction(SetRecord, 1706)
	MisResultAction(AddExp , 30000, 30000)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000925 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000925")
	MisResultAction(GiveNpcMission, 6428, MISSCRIPT_MISSIONSCRIPT05_LUA_000925, 3) 
-------------------------Ù»ÄáµÏµÄµ£ÓÇ----------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000926 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000926")
	DefineMission(6428, MISSCRIPT_MISSIONSCRIPT05_LUA_000926,1707)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000927 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000927")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000927)
	MisBeginCondition(NoRecord, 1707)
	MisBeginCondition(NoMission,1707)
	MisBeginCondition(HasRecord, 1706)
	MisBeginAction(AddMission, 1707)
	MisBeginAction(AddTrigger, 17071, TE_KILL, 1098,10)
	MisCancelAction(ClearMission, 1707)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000928 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000928")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000928)
	MisNeed(MIS_NEED_KILL, 1098, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000929 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000929")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000929)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000930 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000930")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000930)
	MisResultCondition(HasMission, 1707)
	MisResultCondition(NoRecord, 1707)
	MisResultCondition(HasFlag, 1707, 19)
	MisResultAction(ClearMission, 1707)
	MisResultAction(SetRecord, 1707)
	MisResultAction(AddExp, 675000, 675000)
	MisResultAction(AddMoney , 200000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1098)	
	TriggerAction(1, AddNextFlag,1707, 10, 10)
	RegCurTrigger(17071)

-------------------------°²µÒÃÀ°ÂµÄµ£ÓÇ----------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000931 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000931")
	DefineMission(6429, MISSCRIPT_MISSIONSCRIPT05_LUA_000931,1708)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000932 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000932")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000932)
	MisBeginCondition(NoRecord, 1708)
	MisBeginCondition(NoMission,1708)
	MisBeginCondition(HasRecord, 1706)
	MisBeginAction(AddMission, 1708)
	MisBeginAction(AddTrigger, 17081, TE_KILL, 1098,10)
	MisCancelAction(ClearMission, 1708)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000933 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000933")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000933)
	MisNeed(MIS_NEED_KILL, 1098, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000934 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000934")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000934)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000930 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000930")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000930)
	MisResultCondition(HasMission, 1708)
	MisResultCondition(NoRecord, 1708)
	MisResultCondition(HasFlag, 1708, 19)
	MisResultAction(ClearMission, 1708)
	MisResultAction(SetRecord, 1708)
	MisResultAction(AddExp, 675000, 675000)
	MisResultAction(AddMoney , 200000)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1098)	
	TriggerAction(1, AddNextFlag,1708, 10, 10)
	RegCurTrigger(17081)

-------------------------¶©ÇéÐÅÎï--------------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000935 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000935")
	DefineMission(6430, MISSCRIPT_MISSIONSCRIPT05_LUA_000935,1709)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000936 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000936")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000936)
	MisBeginCondition(NoRecord, 1709)
	MisBeginCondition(NoMission,1709)
	MisBeginCondition(HasRecord, 1707)
	MisBeginCondition(HasRecord, 1708)
	MisBeginAction(AddMission, 1709)
	MisBeginAction(AddTrigger, 17091, TE_GETITEM, 118, 1)
	MisCancelAction(ClearMission, 1709)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000937 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000937")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000937)
	MisNeed(MIS_NEED_ITEM, 118, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000938 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000938")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000938)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000939 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000939")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000939)
	MisResultCondition(HasMission, 1709)
	MisResultCondition(NoRecord, 1709)
	MisResultCondition(HasItem, 118, 1)
	MisResultAction(ClearMission, 1709)
	MisResultAction(TakeItem, 118, 1)
	MisResultAction(SetRecord, 1709)
	MisResultAction(AddExp , 400000,400000)
	MisResultBagNeed(1)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000919 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000919")
	MisResultAction(GiveNpcMission, 6431, MISSCRIPT_MISSIONSCRIPT05_LUA_000919, 5) 
	InitTrigger()
	TriggerCondition(1, IsItem, 118)	
	TriggerAction(1, AddNextFlag,1709, 10, 1)
	RegCurTrigger(17091)

-------------------------Çó»é--------------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_000940 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000940")
	DefineMission(6431, MISSCRIPT_MISSIONSCRIPT05_LUA_000940,1710)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000941 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000941")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000941)
	MisBeginCondition(NoRecord, 1710)
	MisBeginCondition(NoMission,1710)
	MisBeginCondition(HasRecord, 1709)
	MisBeginAction(AddMission, 1710)
	MisCancelAction(ClearMission, 1710)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000942 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000942")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000942)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000943 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000943")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000943)
	MisResultCondition(AlwaysFailure)
	
------------------Çó»é--------------(½áÊø)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000940 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000940")
	DefineMission(6432, MISSCRIPT_MISSIONSCRIPT05_LUA_000940,1710, COMPLETE_SHOW)
	MisBeginCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000944 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000944")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000944)
	MisResultCondition(HasMission, 1710)
	MisResultCondition(NoRecord, 1710)
	MisResultAction(ClearMission, 1710)
	MisResultAction(SetRecord, 1710)
	MisResultAction(AddExp , 400000, 400000)		


---------------5¼¶°ÝÊ¦Ñ§ÒÕ---------º£µÁ¹«Ö÷Áé¶ù(2232,2801)	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000116 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000116")
	DefineMission( 6559, MISSCRIPT_EUDEMONSCRIPT_LUA_000116, 1825 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000945 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000945")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000945)
	-- MisBeginCondition(LvCheck, ">", 5 )
	-- MisBeginCondition(LvCheck, "<", 45 )
	MisBeginCondition(NoRecord, 1825)
	MisBeginCondition(NoMission, 1825)
	MisBeginCondition(HasItem,6044,1)
	MisBeginAction(AddMission, 1825)
	MisCancelAction(ClearMission, 1825) ---ÈÎÎñ¿ÉÉ¾³ý
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000946 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000946")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000946)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000947 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000947")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000947)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000948 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000948")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000948)
	MisResultCondition(NoRecord, 1825)
	MisResultCondition(HasMission, 1825)
	MisResultCondition(HasItem,6044,1)
	MisResultAction(TakeItem, 6044,1)
	MisResultAction(ClearMission, 1825)
	MisResultAction(SetRecord, 1825)
	MisResultAction(AddMoney,1000,1000)
	MisResultAction(AddExp1)
	
---------------10¼¶-----ÕÒÅóÓÑ----------º£µÁ¹«Ö÷Áé¶ù(2232,2801)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000112 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000112")
	DefineMission( 6552, MISSCRIPT_EUDEMONSCRIPT_LUA_000112, 1821 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000949 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000949")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000949)
	MisBeginCondition(LvCheck, ">", 9 )
	MisBeginCondition(LvCheck, "<", 45 )
	MisBeginCondition(NoItem,6003,1)	
	MisBeginCondition(NoRecord, 1821)
	MisBeginCondition(NoMission, 1821)
	MisBeginCondition(HasRecord,1825)
	MisBeginAction(AddMission, 1821)
	MisCancelAction(ClearMission, 1821) ---ÈÎÎñ¿ÉÉ¾³ý
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000950 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000950")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000950)
	--MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_000951 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000951")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000951)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000952 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000952")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000952)
	MisResultCondition(NoRecord, 1821)
	MisResultCondition(HasMission, 1821)
	MisResultCondition(NoItem, 6014, 1)------------ÕÒÅóÓÑ
	MisResultCondition(NoItem, 6041, 1)------------ÕÒÅóÓÑ
	MisResultAction(ClearMission, 1821)
	MisResultAction(SetRecord, 1821)
	MisResultAction(AddMoney,10000,10000)
	MisResultAction(AddExp1)-----------------------½ÇÉ«µÈ¼¶¼Ó1º¯Êý

	

	
---------------³öº£²¶Óã---------º£µÁ¹«Ö÷Áé¶ù(2232,2801)	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000088 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000088")
	DefineMission( 6555, MISSCRIPT_EUDEMONSCRIPT_LUA_000088, 1824 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000953 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000953")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000953)
	MisBeginCondition(NoRecord, 1824)
	MisBeginCondition(NoMission, 1824)
	MisBeginCondition(HasItem, 6043, 1)------------²¶Óã½éÉÜÊé
	--MisBeginAction(AddTrigger, 18241, TE_GETITEM, 1478, 5 )
	MisBeginAction(AddMission, 1824)
	MisCancelAction(ClearMission, 1824) ---ÈÎÎñ¿ÉÉ¾³ý
	  
	  
	--MisNeed(MIS_NEED_ITEM, 1478, 5, 10, 5)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000954 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000954")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000954)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000955 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000955")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000955)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000956 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000956")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000956)
	MisResultCondition(NoRecord, 1824)
	MisResultCondition(HasMission, 1824)
	MisResultCondition(HasItem, 1478,5)
	MisResultCondition(HasItem, 6043,1)
	MisResultAction(TakeItem, 6043,1)
	MisResultAction(TakeItem, 1478,5)		
	MisResultAction(ClearMission, 1824)
	MisResultAction(SetRecord, 1824)
	MisResultAction(AddMoney,10000,10000)
	MisResultAction(AddExp1)-----------------------½ÇÉ«µÈ¼¶¼Ó1º¯Êý
	
	-- InitTrigger()
	-- TriggerCondition( 1, IsItem, 1478 )	
	-- TriggerAction( 1, AddNextFlag, 1824, 10, 5 )
	-- RegCurTrigger( 18241 )


	

	
---------------ÎÒÒªÑ§¿á×°ÈÛºÏ---------Ìú½³µÄÍ½µÜ---------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000092 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000092")
	DefineMission( 6556, MISSCRIPT_EUDEMONSCRIPT_LUA_000092, 1826 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000957 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000957")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000957)
	MisBeginCondition(NoRecord, 1826)
	MisBeginCondition(NoMission, 1826)
	MisBeginCondition(HasItem, 6028, 1)------------º£µÁÖ¸ÄÏÕë
	MisBeginAction(AddMission, 1826)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000958 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000958")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000958)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000959 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000959")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000959)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000960 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000960")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000960)
	MisResultCondition(NoRecord, 1826)
	MisResultCondition(HasMission, 1826)
	MisResultCondition( HasNoItem, 453)----------ÈÛºÏ¾íÖá
	MisResultAction(ClearMission, 1826)
	MisResultAction(SetRecord, 1826)
	MisResultAction(GiveItem, 6029, 1,4)---------¿á×°ÈÜºÏÑ§³ÉÊé
	MisResultAction(GiveItem, 453, 1,4)---------¿á×°ÈÜºÏÑ§³ÉÊé
	MisResultAction(AddMoney,10000,10000)
	MisResultBagNeed(2)
---------------ÎÒÒªÑ§µÀ¾ß¾«Á¶---------Ìú½³µÄÍ½µÜ	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000961 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000961")
	DefineMission( 6557, MISSCRIPT_MISSIONSCRIPT05_LUA_000961, 1827 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000962 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000962")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000962)
	MisBeginCondition(NoRecord, 1827)
	MisBeginCondition(NoMission, 1827)
	MisBeginCondition(HasItem, 6028, 1)------------º£µÁÖ¸ÄÏÕë
	MisBeginCondition(HasRecord,1826)
	--MisBeginAction(GiveItem, 883, 1, 4)----------ÔÂÖ®ÐÄ
	MisBeginAction(AddMission, 1827)
	--MisCancelAction(ClearMission, 1827) ---ÈÎÎñ¿ÉÉ¾³ý
	MisResultBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000963 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000963")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000963)
	
	--MisHelpTalk("È¥ÕÒÉ³á°³ÇÌú½³Í­Í­¹Ä(901,3496)½øÐÐ¾«Á¶")
	MISSCRIPT_MISSIONSCRIPT05_LUA_000964 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000964")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000964)
	MisResultCondition(NoRecord, 1827)
	MisResultCondition(HasMission, 1827)
	--MisResultCondition( HasNoItem, 6016)----------ÌØÖÆ¾«Á¶Ê¯
	MisResultAction(ClearMission, 1827)
	MisResultAction(SetRecord, 1827)
	MisResultAction(GiveItem, 6030, 1,4)---------µÀ¾ß¾«Á¶Ñ§³ÉÊé
	MisResultAction(AddMoney,10000,10000)
	MisResultBagNeed(1)

---------------ÎÒÒªÑ§±¦Ê¯ºÏ³É---------Ìú½³µÄÍ½µÜ	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000965 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000965")
	DefineMission( 6558, MISSCRIPT_MISSIONSCRIPT05_LUA_000965, 1828 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000966 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000966")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000966)
	MisBeginCondition(NoRecord, 1828)
	MisBeginCondition(NoMission, 1828)
	MisBeginCondition(HasItem, 6028, 1)------------º£µÁÖ¸ÄÏÕë
	MisBeginCondition(HasRecord,1827)
	MisBeginAction(GiveItem, 6016, 1, 4)----------ÌØÖÆ¾«Á¶Ê¯
	MisBeginAction(GiveItem, 886, 1, 4)--±¦Ê¯ºÏ³É¾í
	MisBeginAction(AddMission, 1828)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisResultBagNeed(1)
	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000967 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000967")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000967)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000968 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000968")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000968)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000969")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000969)
	MisResultCondition(NoRecord, 1828)
	MisResultCondition(HasMission, 1828)
	MisResultCondition(HasDiamondId)
	MisResultAction(ClearMission, 1828)
	MisResultAction(SetRecord, 1828)
	MisResultAction(GiveItem, 6031, 1,4)---------±¦Ê¯ºÏ³ÉÑ§³ÉÊé
	MisResultAction(AddMoney,10000,10000)
	MisResultBagNeed(1)
	
---------------------------Ñ§³Ì¹éÀ´------------Ìú½³Í½µÜ	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000970 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000970")
	DefineMission( 6553, MISSCRIPT_MISSIONSCRIPT05_LUA_000970, 1822 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_000971 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000971")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000971)
	MisBeginCondition(NoRecord, 1822)
	MisBeginCondition(NoMission, 1822)
	MisBeginCondition(HasRecord, 1826)
	MisBeginCondition(HasRecord, 1827)
	MisBeginCondition(HasRecord, 1828)
	MisBeginAction(AddMission, 1822)
	MisCancelAction(ClearMission, 1828) ---ÈÎÎñ¿ÉÉ¾³ý
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000972 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000972")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000972)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000973")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000973)
	MisResultCondition(AlwaysFailure )

-----------------------------------Ñ§³Ì¹éÀ´--------------º£µÁ¹«Ö÷Áé¶ù
	MISSCRIPT_MISSIONSCRIPT05_LUA_000974 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000974")
	DefineMission( 6554, MISSCRIPT_MISSIONSCRIPT05_LUA_000974, 1822, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000975 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000975")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000975)
	MisResultCondition(NoRecord, 1822)
	MisResultCondition(HasMission, 1822)
	MisResultCondition(HasItem, 6028,1)
	MisResultAction(SetRecord, 1822)
	MisResultAction(TakeItem, 6029, 1) -----¿á×°ÈÜºÏÑ§³ÉÊé
	MisResultAction(TakeItem, 6030, 1) ----------µÀ¾ß¾«Á¶Ñ§³ÉÊé
	MisResultAction(TakeItem, 6031, 1) ---------±¦Ê¯ºÏ³ÉÑ§³ÉÊé
	MisResultAction(TakeItem, 6028, 1) ---------Ö¸ÄÏÕë	
	MisResultAction(ClearMission, 1822)
	MisResultAction(ClearRecord, 1826)
	MisResultAction(ClearRecord, 1827)
	MisResultAction(ClearRecord, 1828)
	MisResultAction(SetRecord, 1822)
	MisResultAction(AddMoney,30000,30000)

------------------------ÎÒÒªÑ§PK------------º£µÁ¹«Ö÷Áé¶ù
	MISSCRIPT_EUDEMONSCRIPT_LUA_000096 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000096")
	DefineMission( 6570, MISSCRIPT_EUDEMONSCRIPT_LUA_000096, 1835 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000976 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000976")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000976 )
	MisBeginCondition(NoRecord, 1835)
	MisBeginCondition(NoMission, 1835)
	MisBeginCondition(HasItem, 6033,1)
	MisBeginAction(AddMission, 1835)
	MisCancelAction(ClearMission, 1835)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000977 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000977")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000977)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000978 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000978")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000978)
	MisResultCondition(AlwaysFailure )

-----------------------------------ÎÒÒªÑ§PK--------------¾º¼¼¹ÜÀíÔ±
	MISSCRIPT_EUDEMONSCRIPT_LUA_000096 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000096")
	DefineMission( 6571, MISSCRIPT_EUDEMONSCRIPT_LUA_000096, 1835, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000979 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000979")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000979)
	MisResultCondition(NoRecord, 1835)
	MisResultCondition(HasMission, 1835)
	MisResultAction(ClearMission, 1835 )
	MisResultAction(SetRecord, 1835 )


-----------------------------------ÎÒÒªÑ§PK--------------¾º¼¼¹ÜÀíÔ±	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000096 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000096")
	DefineMission( 6572, MISSCRIPT_EUDEMONSCRIPT_LUA_000096, 1836 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_000980 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000980")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000980 )
	MisBeginCondition(NoRecord, 1836)
	MisBeginCondition(NoMission, 1836)
	MisBeginCondition(HasRecord, 1835)
	MisBeginAction(AddMission, 1836)	
	MisCancelAction(ClearMission, 1836)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000981 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000981")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000981)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000982 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000982")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000982)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000983 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000983")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000983)
	MisResultCondition(HasMission, 1836)
	MisResultCondition(Get_ItemAttr_Join1)
	MisResultAction(ClearMission, 1836)
	MisResultAction(SetRecord, 1836 )
	MisResultAction(GiveItem, 2816 ,1 ,4 )-----ÈÙÓþ¼ÓµãÊé
	MisResultAction(GiveItem, 6034,1,4 )      ---------------º£µÁPKÑ§³ÉÊé
	MisResultBagNeed(2)


----------------------------ÎÒÒªÑ§PK------------¾º¼¼¹ÜÀíÔ±
	MISSCRIPT_EUDEMONSCRIPT_LUA_000096 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000096")
	DefineMission( 6573, MISSCRIPT_EUDEMONSCRIPT_LUA_000096, 1837 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000984 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000984")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000984 )
	MisBeginCondition(NoRecord, 1837)
	MisBeginCondition(NoMission, 1837)
	MisBeginCondition(HasRecord, 1836)
	MisBeginAction(AddMission, 1837)
	MisCancelAction(ClearMission, 1837)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_000985 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000985")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000985)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000986 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000986")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000986)
	MisResultCondition(AlwaysFailure )

-----------------------------------ÎÒÒªÑ§PK--------------º£µÁ¹«Ö÷Áé¶ù
	MISSCRIPT_EUDEMONSCRIPT_LUA_000096 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000096")
	DefineMission( 6574, MISSCRIPT_EUDEMONSCRIPT_LUA_000096, 1837, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000987 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000987")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000987)
	MisResultCondition(NoRecord, 1837)
	MisResultCondition(HasMission, 1837)
	MisResultCondition(HasItem, 6033,1)
	MisResultCondition(HasItem, 6034,1)       ---------------º£µÁPKÑ§³ÉÊé
	MisResultAction(TakeItem, 6034,1 )	
	MisResultAction(TakeItem, 6033,1 )	
	MisResultAction(ClearMission, 1837 )
	MisResultAction(SetRecord, 1837 )
	MisResultAction(AddMoney, 10000 )


-----------------------------------ÎÒÒªÈ¥·ÏÁé--------------º£µÁ¹«Ö÷Áé¶ù
	MISSCRIPT_EUDEMONSCRIPT_LUA_000100 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000100")
	DefineMission( 6575, MISSCRIPT_EUDEMONSCRIPT_LUA_000100, 1838 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000988 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000988")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000988 )
	MisBeginCondition(NoRecord, 1838)
	MisBeginCondition(NoMission, 1838)
	MisBeginCondition(HasItem, 6045,1)      --------------·ÏÁéÃÔ¹¬Ì½Ë÷Òýµ¼
	MisBeginAction(AddMission, 1838)
	MisBeginAction(AddTrigger, 18381, TE_KILL, 686, 1 )		 -------·ÏÁéÎäÊ¿
	MisCancelAction(ClearMission, 1838)
		
	MisNeed(MIS_NEED_KILL, 686, 1, 10, 1)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000989 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000989")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000989)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000990 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000990")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000990)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000991 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000991")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000991)
	MisResultCondition(HasMission, 1838)
	MisResultCondition(HasFlag, 1838, 10)
	MisResultCondition(HasItem, 6045, 1)
	MisResultAction(TakeItem, 6045, 1)
	MisResultAction(ClearMission, 1838)
	MisResultAction(SetRecord, 1838 )
	MisResultAction(AddExp, 60000, 60000)
	
	MisResultBagNeed(2)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 686)	
	TriggerAction( 1, AddNextFlag, 1838, 10, 1)
	RegCurTrigger( 18381 )

	
-----------------------------------¼ÓÈë»ìÕ½--------------º£µÁ¹«Ö÷Áé¶ù
	MISSCRIPT_EUDEMONSCRIPT_LUA_000104 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000104")
	DefineMission( 6576, MISSCRIPT_EUDEMONSCRIPT_LUA_000104, 1839 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000992 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000992")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000992 )
	MisBeginCondition(NoRecord, 1839)
	MisBeginCondition(NoMission, 1839)
	MisBeginCondition(HasItem, 6047,1)      --------------º£µÁ»ìÕ½Ö¸Òý
	MisBeginAction(AddMission, 1839)	
	MisCancelAction(ClearMission, 1839)

	MISSCRIPT_MISSIONSCRIPT05_LUA_000993 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000993")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000993)

	--MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_000994 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000994")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000994)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000995 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000995")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000995)
	MisResultCondition(HasMission, 1839)
	MisResultCondition(Get_ItemAttr_Join20)
	MisResultCondition(HasItem,6047,1)
	MisResultAction(TakeItem, 6047,1)
	MisResultAction(ClearMission, 1839)
	MisResultAction(SetRecord, 1839 )
	MisResultAction(AddMoney,3000,3000)
	MisResultAction(AddExp, 5000, 5000)
	
	--MisResultAction(GiveItem, 6019,1,4 )      ---------------×é¶Ó¾­Ñé¹û
	--MisResultBagNeed(1)

	
-------------------º£µÁÍõÊ¦Í½ÏµÍ³½éÉÜ------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000120 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000120")
	DefineMission( 6577, MISSCRIPT_EUDEMONSCRIPT_LUA_000120,1840 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_000996 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000996")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_000996)
	MisBeginCondition(LvCheck, ">", 40 )
	--MisBeginCondition(LvCheck, "<", 45 )
	MisBeginCondition(NoRecord, 1840)
	MisBeginCondition(NoMission, 1840)
	MisBeginCondition(HasRecord ,1839)
	
	
	MisBeginAction(AddMission, 1840)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_000997 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000997")
	MisNeed( MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_000997)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000998 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000998")
	MisResultTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000998)
	MISSCRIPT_MISSIONSCRIPT05_LUA_000999 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_000999")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_000999)
	MisResultCondition( HasMission, 1840)
	MisResultCondition( HasItem, 6049, 1)
	MisResultAction( TakeItem, 6049, 1)  ------ÇóÊ¦Ìù
	MisResultAction( ClearMission, 1840)
	MisResultAction( SetRecord, 1840 )
	MisResultAction(AddMoney,100000,100000)
	--MisResultAction(GiveItem, 6017, 5, 4)  -----ÌØÖÆÅ¬Á¦Ôö·ùÆ÷
	MisResultAction(AddExp, 100000, 100000)
	--MisResultBagNeed(1)
	
----------------------------Ñ°ÕÒÊ¥Õ½¹ÜÀíÔ±------------º£µÁ¹«Ö÷Áé¶ù
	MISSCRIPT_EUDEMONSCRIPT_LUA_000108 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000108")
	DefineMission( 6578, MISSCRIPT_EUDEMONSCRIPT_LUA_000108, 1841 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001000 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001000")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001000 )
	MisBeginCondition(NoRecord, 1841)
	MisBeginCondition(NoMission, 1841)
	MisBeginCondition(HasItem, 6036,1)
	MisBeginAction(AddMission, 1841)
	MisCancelAction(ClearMission, 1841)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001001 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001001")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001001)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001002 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001002")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001002)
	MisResultCondition(AlwaysFailure )

-----------------------------------Ñ°ÕÒÊ¥Õ½¹ÜÀíÔ±--------------¾º¼¼¹ÜÀíÔ±
	MISSCRIPT_EUDEMONSCRIPT_LUA_000108 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000108")
	DefineMission( 6579, MISSCRIPT_EUDEMONSCRIPT_LUA_000108, 1841, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001003 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001003")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001003)
	MisResultCondition(NoRecord, 1842)
	MisResultCondition(HasMission, 1841)
	MisResultAction(ClearMission, 1841 )
	MisResultAction(SetRecord, 1841 )
	MisResultAction(AddMoney,10000,10000)


-----------------------------------ÎÒÒª½øÊ¥Õ½--------------¾º¼¼¹ÜÀíÔ±	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001004 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001004")
	DefineMission( 6580, MISSCRIPT_MISSIONSCRIPT05_LUA_001004, 1842 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_001005 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001005")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001005 )
	MisBeginCondition(NoRecord, 1842)
	MisBeginCondition(NoMission, 1842)
	MisBeginCondition(HasRecord, 1841)
	MisBeginCondition(HasItem, 6036,1)
	MisBeginAction(AddTrigger, 18421, TE_GETITEM, 2382, 1 )
	MisBeginAction(AddMission, 1842)	
	MisCancelAction(ClearMission, 1842)
	
	MisNeed(MIS_NEED_ITEM, 2382, 1, 1, 1)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001006 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001006")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001006)

	MISSCRIPT_MISSIONSCRIPT05_LUA_001007 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001007")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001007)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001008 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001008")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001008)
	MisResultCondition(HasMission, 1842)
	MisResultCondition(HasItem,6036,1 )
	MisResultCondition(HasItem,2382,1 )  -----ÉúËÀÁî
	MisResultAction(ClearMission, 1842)
	MisResultAction(SetRecord, 1842 )
	MisResultAction( TakeItem, 6036, 1)  ------Ê¥Õ½Òýµ¼Í¼
	MisResultAction( AddMoney , 5000 , 5000 )
	MisResultAction( SetRecord, 1842 )
	--MisResultAction(GiveItem, 6019, 5, 4)  -----ÌØÖÆ×é¶Ó¾­Ñé¹û
	MisResultAction(AddExp, 5000, 5000)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2382 )	
	TriggerAction( 1, AddNextFlag, 1842, 1, 1 )
	RegCurTrigger( 18421 )
	
	
----------------------------------µÈ¼¶´¥·¢ÈÎÎñ--------------------------
----------11¼¶--------ÅàÑø¾«Áé---------º£µÁ¹«Ö÷Áé¶ù(2232,2801)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000084 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000084")
	DefineMission( 6551, MISSCRIPT_EUDEMONSCRIPT_LUA_000084, 1820  )
	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001009")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001009)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001010 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001010")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001010)
	MisResultCondition(NoRecord, 1820)
	MisResultCondition(HasMission, 1820)
	MisResultCondition(JL_lv)-------------¾«ÁéµÈ¼¶ÅÐ¶Ï
	MisResultAction(ClearMission, 1820)
	MisResultAction(SetRecord, 1820)
	MisResultAction(AddMoney,4000,4000)
	MisResultAction(AddExp1)-----------------------½ÇÉ«µÈ¼¶¼Ó1º¯Êý	
	
----------------------13¼¶¾«ÁéÑø³É----------------	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000124 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000124")
	DefineMission( 6592, MISSCRIPT_EUDEMONSCRIPT_LUA_000124, 1843 )
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001011 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001011")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001011)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001012 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001012")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001012)
	MisResultCondition(NoRecord, 1843)
	MisResultCondition(HasMission, 1843)
	MisResultCondition(JLTLZM)  ------ÅÐ¶Ï¾«ÁéµÄÌåÁ¦ÊÇ·ñÂú
	MisResultAction(ClearMission, 1843 )
	MisResultAction(SetRecord, 1843 )
	MisResultAction(GiveItem,6015,5,4 )---------ÌØÖÆ¾«ÁéËÇÁÏ
	MisResultBagNeed(1)
	

	

-------------17¼¶¾«ÁéÓ²±Ò---------------
	-- DefineMission( 6594, "¾«ÁéÓ²±ÒµÄ×÷ÓÃ",1844)
	-- MisBeginCondition(AlwaysFailure )	
	-- MisHelpTalk("ÔõÃ´,»¹Ã»µÃµ½¾«ÁéÓ²±Ò±¦ÏäÂð?")
	-- MisResultTalk("<t>¶÷£¬¿´À´ÄãÒÑ¾­µÃµ½ÁË¾«ÁéÓ²±Ò±¦ÏäÁË£¬ÄãÒ²Ó¦¸ÃÖªµÀÊ¹ÓÃµÄ·½·¨ÁË°É£¬ÆäÊµ¾«ÁéÓ²±Ò»¹»áÔÚÊ¹ÓÃ¾«Áé¼¼ÄÜµÄÊ±ºò»áÏûºÄ£¬»¹ÓÐºÜ¶àµÄÊ¹ÓÃ·½·¨£¬Äã¿ÉÒÔÔÚÓÎÏ·ÖÐÂýÂýÌåÑé£¡")
	-- MisResultCondition(NoRecord, 1844)
	-- MisResultCondition(HasMission, 1844)
	-- MisResultCondition(HasItem,1872,1)  ------¾«ÁéÓ²±Ò±¦Ïä
	-- MisResultAction(ClearMission, 1844 )
	-- MisResultAction(SetRecord, 1844 )
	-- MisResultAction(GiveItem,855,99,4 )---------¾«ÁéÓ²±Ò
	-- MisResultBagNeed(1)
	

	
	
-------------27¼¶¾«Áé¼¼ÄÜÈÎÎñ---------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000128 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000128")
	DefineMission( 6596, MISSCRIPT_EUDEMONSCRIPT_LUA_000128,1845)
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001013 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001013")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001013)
	MisResultCondition(NoRecord, 1845)
	MisResultCondition(HasMission, 1845)

	MisResultAction(ClearMission, 1845 )
	MisResultAction(SetRecord, 1845 )
	MisResultAction(AddExp, 5000, 5000)
	--MisResultAction(GiveItem,855,99,4 )---------¾«ÁéÓ²±Ò
	--MisResultAction(GiveItem,6015,10,4 )--------¾«ÁéËÇÁÏ
	MisResultBagNeed(1)

	
	
-------------60¼¶¾«Áé½á»éÈÎÎñ---------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000132 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000132")
	DefineMission( 6598, MISSCRIPT_EUDEMONSCRIPT_LUA_000132,1846 )
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001014 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001014")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001014)
	MisResultCondition(NoRecord, 1846)
	MisResultCondition(HasMission, 1846)

	MisResultAction(ClearMission, 1846 )
	MisResultAction(SetRecord, 1846 )
	MisResultAction(GiveItem,855,99,4 )---------¾«ÁéÓ²±Ò´ý¶¨
	--MisResultAction(GiveItem,6015,20,4 )--------¾«ÁéËÇÁÏ´ý¶¨
	MisResultBagNeed(1)
	

---------------14¼¶ºÃÓÑ½éÉÜ-------------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000136 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000136")
	DefineMission( 6600, MISSCRIPT_EUDEMONSCRIPT_LUA_000136,1847)
	MisBeginCondition(AlwaysFailure )		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001015 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001015")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001015)
	MisResultCondition(NoRecord, 1847)
	MisResultCondition(HasMission, 1847)

	MisResultAction(ClearMission, 1847)
	MisResultAction(SetRecord, 1847 )
	MisResultAction(GiveItem,1849,99,4 )--------µ°¸â
	MisResultBagNeed(1)
	
	
---------------18¼¶×é¶ÓÈÎÎñ----------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000141 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000141")
	DefineMission( 6602, MISSCRIPT_EUDEMONSCRIPT_LUA_000141,1848)	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001016 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001016")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001016)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001017 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001017)
	MisResultCondition(NoRecord, 1848)
	MisResultCondition(HasMission, 1848)
	MisResultCondition(TeamZd)  -----------ÅÐ¶ÏÊÇ·ñ×é¶Ó

	MisResultAction(ClearMission, 1848)
	MisResultAction(SetRecord, 1848 )
	MisResultAction(TeamZdJl)---------×é¶ÓË«±¶½±Àø
	MisResultAction(GiveItem,1849,198,4 )--------µ°¸â
	MisResultBagNeed(2)
	
-----------43¼¶¹«»áÈÎÎñ----------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001018")
	DefineMission( 6604, MISSCRIPT_MISSIONSCRIPT05_LUA_001018,1849)	
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001019 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001019")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001019)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001020 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001020")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001020)
	MisResultCondition(NoRecord, 1849)
	MisResultCondition(HasMission, 1849)
	MisResultCondition(GHPD)  -----------ÅÐ¶ÏÊÇ·ñÓÐ¹«»á

	MisResultAction(ClearMission, 1849)
	MisResultAction(SetRecord, 1849)
	-- MisResultAction(GiveItem, 6017,5,4)---------Ë«±¶¾­Ñé
	-- MisResultBagNeed(1)
	MisResultAction(AddExp, 100000, 100000)

	
	
-----------40¼¶Òõ°µÕÓÔóÈÎÎñ----------------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000149 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000149")
	DefineMission( 6606, MISSCRIPT_EUDEMONSCRIPT_LUA_000149,1850)
	MisBeginCondition(AlwaysFailure )	

	MISSCRIPT_MISSIONSCRIPT05_LUA_001021 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001021")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001021)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001022 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001022")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001022)
	MisResultCondition(NoRecord, 1850)
	MisResultCondition(HasMission, 1850)
	MisResultCondition(HasItem, 3442,10)
	MisResultAction(TakeItem, 3442,10)
	
	MisResultAction(ClearMission, 1850)
	MisResultAction(SetRecord, 1850)
	MisResultAction(GiveItem,3848,10,4 )--------ÌåÁ¦»Ö¸´Ò©¼Á
	MisResultAction(AddMoney, 5000,5000)
	MisResultBagNeed(1)
	

	
	
-----------50¼¶Ä§·½ÊÀ½çÈÎÎñ----------------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000153 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000153")
	DefineMission( 6608, MISSCRIPT_EUDEMONSCRIPT_LUA_000153,1851)	
	MisBeginCondition(AlwaysFailure )		

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001023 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001023")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001023)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001024 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001024")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001024)
	MisResultCondition(NoRecord, 1851)
	MisResultCondition(HasMission, 1851)
	MisResultCondition(HasItem, 3820,20)
	MisResultAction(TakeItem, 3820,20)
	
	MisResultAction(ClearMission, 1851)
	MisResultAction(SetRecord, 1851)
	MisResultAction(GiveItem,3848,99,4 )--------µ°¸â
	MisResultAction(AddMoney, 5000,5000)
	MisResultBagNeed(1)
	
	
---------------9¼¶Õ¼²·-----Õ¼²·ÀÏÌ«ÈÎÎñ--------------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000157 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000157")
	DefineMission( 6610, MISSCRIPT_EUDEMONSCRIPT_LUA_000157,1852)
	MisBeginCondition(AlwaysFailure )	
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001025 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001025")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001025)
	MisResultCondition(NoRecord, 1852)
	MisResultCondition(HasMission, 1852)

	MisResultAction(ClearMission, 1852)
	MisResultAction(SetRecord, 1852)
	MisResultAction(AddMoney, 1000,1000) -----------½±Àø1Q
	MISSCRIPT_MISSIONSCRIPT05_LUA_001026 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001026")
	MisResultAction(GiveNpcMission,6611,MISSCRIPT_MISSIONSCRIPT05_LUA_001026,2)
	
-----------9¼¶¾­ÑéÅ¨ËõÈÎÎñ-----Õ¼²·ÀÏÌ«-----------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001027 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001027")
	DefineWorldMission( 6611, MISSCRIPT_MISSIONSCRIPT05_LUA_001027, 1853 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_001028 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001028")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001028 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001028 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001028")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001028 )
	MisBeginCondition(NoRecord, 1853)
	MisBeginCondition(NoMission, 1853)
	--MisBeginCondition(HasRecord, 1852)
	MisBeginAction(AddMission, 1853)
	MisCancelAction(ClearMission, 1853)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001029 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001029")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001029)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001030 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001030")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001030)
	MisResultCondition(AlwaysFailure )

------------9¼¶Ä§ºÐÈÎÎñ----Ä§¾§´óÊ¹ 222400,276800---------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001027 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001027")
	DefineMission( 6612, MISSCRIPT_MISSIONSCRIPT05_LUA_001027, 1853, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001031 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001031")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001031)
	MisResultCondition(NoRecord, 1853)
	MisResultCondition(HasMission, 1853)
	MisResultAction(ClearMission, 1853 )
	MisResultAction(SetRecord, 1853 )
	MisResultAction(AddMoney,1500,1500)
	CALCULATE_FUNCTIONS_LUA_000701 = GetResString("CALCULATE_FUNCTIONS_LUA_000701")
	MisResultAction(GiveNpcMission,6613,CALCULATE_FUNCTIONS_LUA_000701,2)
	
--------9¼¶ÁìÈ¡Ë«±¶¾­Ñé---Ë«¶ùMM 222400,276800---------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001032 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001032")
	DefineMission( 6613, MISSCRIPT_MISSIONSCRIPT05_LUA_001032, 1854)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001033 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001033")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001033 )
	MisBeginCondition(NoRecord, 1854)
	MisBeginCondition(NoMission, 1854)
	MisBeginCondition(HasRecord, 1853)
	MisBeginAction(AddMission, 1854)
	MisCancelAction(ClearMission, 1854)
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001034 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001034")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001034)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001035 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001035")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001035)
	MisResultCondition(AlwaysFailure )
	
--------9¼¶ÁìÈ¡Ë«±¶¾­Ñé---Ë«¶ù----218400,277600
	MISSCRIPT_MISSIONSCRIPT05_LUA_001032 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001032")
	DefineMission( 6614, MISSCRIPT_MISSIONSCRIPT05_LUA_001032, 1854, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001036 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001036")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001036)
	MisResultCondition(NoRecord, 1854)
	MisResultCondition(HasMission, 1854)
	MisResultAction(ClearMission, 1854 )
	MisResultAction(SetRecord, 1854 )
	MisResultAction(AddMoney,5000,5000)

	
--------39¼¶ÍÚ±¦NPC---
	MISSCRIPT_EUDEMONSCRIPT_LUA_000161 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000161")
	DefineMission( 6616, MISSCRIPT_EUDEMONSCRIPT_LUA_000161, 1855)
	MisBeginCondition(AlwaysFailure )			
	MISSCRIPT_MISSIONSCRIPT05_LUA_001037 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001037")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001037)
	MisResultCondition(NoRecord, 1855)
	MisResultCondition(HasMission, 1855)
	MisResultAction(ClearMission, 1855)
	MisResultAction(SetRecord, 1855)
	MisResultAction(AddMoney,30000,30000)
	MisResultAction(GiveItem,6343,1,4)----±¦Í¼
	MisResultBagNeed(1)

-----------------Ö÷ÏßÈÎÎñ:Ñ§Ï°Ö°Òµ¼¼ÄÜ---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001039 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001039")
	DefineMission( 6735, MISSCRIPT_MISSIONSCRIPT05_LUA_001039, 1925 )
	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001040 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001040")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001040 )
	
	MisBeginCondition(CheckJobIsNew)
	MisBeginCondition(HasRecord , 1940 )
	MisBeginCondition(NoRecord, 1925)
	MisBeginCondition(NoMission, 1925)
	MisBeginAction(AddMission, 1925)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001041 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001041")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001041)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001042 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001042")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001042)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001043 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001043")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001043)
	MisResultCondition(CheckFirstSkill)
	MisResultCondition(NoRecord, 1925)
	MisResultCondition(HasMission, 1925)
	MisResultAction(ClearMission, 1925 )
	MisResultAction(SetRecord, 1925 )
	MisResultAction(AddExp, 1234, 1234)			-----------µÈ¼¶ÌáÉýÒ»¼¶
	MisResultAction(GiveNpcMission1,6736)	
	
	
	
-----------------Ö÷ÏßÈÎÎñ:ÌáÉýÊôÐÔµã---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001044 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001044")
	DefineMission( 6736, MISSCRIPT_MISSIONSCRIPT05_LUA_001044, 1926 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001045 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001045")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001045 )
	
	MisBeginCondition(HasRecord , 1925 )
	MisBeginCondition(NoRecord, 1926 )
	MisBeginCondition(NoMission, 1926 )
	MisBeginAction(AddMission, 1926 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001046 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001046")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001046)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001047 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001047")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001047)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001048 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001048")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001048)
	MisResultCondition(NoRecord, 1926)
	MisResultCondition(HasMission, 1926)
	MisResultCondition(CheckAttrRole)		-----¼ì²âÈËÎïÊôÐÔµã
	MisResultAction(ClearMission, 1926 )
	MisResultAction(SetRecord, 1926 )
	MisResultAction(AddExp, 1496, 1496)		-----------½±Àø30%¾­Ñé
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001049 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001049")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001049)
	
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(½£Ê¿)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6737, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1927 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001051 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001051")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001051 )
	
	MisBeginCondition(PfEqual1, 1 )
	MisBeginCondition(HasRecord , 1926 )
	MisBeginCondition(NoRecord, 1927 )
	MisBeginCondition(NoMission, 1927 )
	MisBeginAction(AddMission, 1927 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001052 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001052")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001052)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001053 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001053")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001053)
	
	MisResultCondition(AlwaysFailure )
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(½£Ê¿)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6738, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1927 ,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001054 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001054")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001054)
	MisResultCondition(NoRecord, 1927)
	MisResultCondition(HasMission, 1927)
	MisResultAction(ClearMission, 1927 )
	MisResultAction(SetRecord, 1927)
	MisResultAction(AddMoney , 2000 )	
	MisResultAction(AddExp, 1296, 1296)			
	
	MisResultAction(GiveNpcMission1,6739)	
	
-----------------Ö÷ÏßÈÎÎñ:¹ºÂòµÚÒ»¼þ×°±¸(½£Ê¿)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001055")
	DefineMission( 6739, MISSCRIPT_MISSIONSCRIPT05_LUA_001055, 1928 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001056 )
	MisBeginCondition(HasRecord , 1927 )
	MisBeginCondition(NoRecord, 1928 )
	MisBeginCondition(NoMission, 1928 )
	MisBeginAction(AddMission, 1928 )
	MisBeginAction(AddTrigger, 19281, TE_GETITEM, 0466, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001057 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001057")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001057)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001058)
	
	MisNeed(MIS_NEED_ITEM, 0466, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001059)
	
	MisResultCondition(NoRecord, 1928)	
	MisResultCondition(HasMission, 1928)
	MisResultCondition(HasItemShouTao, 0466)
	MisResultAction(ClearMission, 1928)
	MisResultAction(SetRecord, 1928 )
	MisResultAction(AddExp, 3111, 3111)		
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0466)	
	TriggerAction( 1, AddNextFlag, 1928, 10, 1 )
	RegCurTrigger( 19281 )
	
	MisResultAction(GiveNpcMission1,6749)	
	
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(ÁÔÈË)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6740, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1929 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001060 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001060")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001060 )
	
	MisBeginCondition(PfEqual1, 2 )
	MisBeginCondition(HasRecord , 1926 )
	MisBeginCondition(NoRecord, 1929 )
	MisBeginCondition(NoMission, 1929 )
	MisBeginAction(AddMission, 1929 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001061 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001061")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001061)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001062 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001062")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001062)
	
	MisResultCondition(AlwaysFailure )
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(ÁÔÈË)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6741, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1929 ,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001063 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001063")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001063)
	MisResultCondition(NoRecord, 1929)
	MisResultCondition(HasMission, 1929)
	MisResultAction(ClearMission, 1929 )
	MisResultAction(SetRecord, 1929)
	MisResultAction(AddMoney , 2000 )	
	MisResultAction(AddExp, 1296, 1296)
	
	MisResultAction(GiveNpcMission1,6742)	
	
-----------------Ö÷ÏßÈÎÎñ:¹ºÂòµÚÒ»¼þ×°±¸(ÁÔÈË)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001055")
	DefineMission( 6742, MISSCRIPT_MISSIONSCRIPT05_LUA_001055, 1930 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001056 )
	MisBeginCondition(HasRecord , 1929 )
	MisBeginCondition(NoRecord, 1928 )
	MisBeginCondition(NoMission, 1930 )
	MisBeginAction(AddMission, 1930 )
	MisBeginAction(AddTrigger, 19301, TE_GETITEM, 0481, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001064 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001064")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001064)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001058)
	
	MisNeed(MIS_NEED_ITEM, 0481, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001059)
	
	MisResultCondition(NoRecord, 1930)	
	MisResultCondition(HasMission, 1930)
	MisResultCondition(HasItemShouTao, 0481)
	MisResultAction(ClearMission, 1930)
	MisResultAction(SetRecord, 1928 )
	MisResultAction(AddExp, 3111, 3111)		
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0481)	
	TriggerAction( 1, AddNextFlag, 1930, 10, 1 )
	RegCurTrigger( 19301 )
	
	MisResultAction(GiveNpcMission1,6749)	
	
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(Ã°ÏÕÕß)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6754, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1937 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001065 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001065")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001065 )
	
	MisBeginCondition(PfEqual1, 4 )
	MisBeginCondition(HasRecord , 1926 )
	MisBeginCondition(NoRecord, 1937 )
	MisBeginCondition(NoMission, 1937 )
	MisBeginAction(AddMission, 1937 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001066 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001066")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001066)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001067 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001067")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001067)
	
	MisResultCondition(AlwaysFailure )
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(Ã°ÏÕÕß)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6755, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1937 ,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001068 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001068")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001068)
	MisResultCondition(NoRecord, 1937)
	MisResultCondition(HasMission, 1937)
	MisResultAction(ClearMission, 1937 )
	MisResultAction(SetRecord, 1937)
	MisResultAction(AddMoney , 2000 )
	
	MisResultAction(AddExp, 1296, 1296)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001069 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001069")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001069)	
	
-----------------Ö÷ÏßÈÎÎñ:¹ºÂòµÚÒ»¼þ×°±¸(Ã°ÏÕÕß)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001055")
	DefineMission( 6756, MISSCRIPT_MISSIONSCRIPT05_LUA_001055, 1938 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001056 )	
	MisBeginCondition(NoChaType , 2 )
	MisBeginCondition(NoChaType , 4 )
	MisBeginCondition(HasRecord , 1937 )
	MisBeginCondition(NoRecord, 1928 )
	MisBeginCondition(NoMission, 1938 )
	MisBeginAction(AddMission, 1938 )
	MisBeginAction(AddTrigger, 19381, TE_GETITEM, 0511, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001070 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001070")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001070)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001058)
	
	MisNeed(MIS_NEED_ITEM, 0511, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001059)
	
	MisResultCondition(NoRecord, 1938)	
	MisResultCondition(HasMission, 1938)
	MisResultCondition(HasItemShouTao, 0511)
	MisResultAction(ClearMission, 1938)
	MisResultAction(SetRecord, 1928 )
	MisResultAction(AddExp, 3111, 3111)		
	MisResultAction(GiveNpcMission1,6749)	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0511)	
	TriggerAction( 1, AddNextFlag, 1938, 10, 1 )
	RegCurTrigger( 19381 )	
	
	
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(Ò©Ê¦)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6746, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1932 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001071 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001071")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001071 )
	
	MisBeginCondition(PfEqual1, 5 )
	MisBeginCondition(HasRecord , 1926 )
	MisBeginCondition(NoRecord, 1932 )
	MisBeginCondition(NoMission, 1932 )
	MisBeginAction(AddMission, 1932 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001072 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001072")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001072)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001073 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001073")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001073)
	
	MisResultCondition(AlwaysFailure )
-----------------Ö÷ÏßÈÎÎñ:Ñ°ÕÒ·þ×°µêÖ÷(Ò©Ê¦)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001050")
	DefineMission( 6747, MISSCRIPT_MISSIONSCRIPT05_LUA_001050, 1932 ,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001074 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001074")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001074)
	MisResultCondition(NoRecord, 1932)
	MisResultCondition(HasMission, 1932)
	MisResultAction(ClearMission, 1932 )
	MisResultAction(SetRecord, 1932)
	MisResultAction(AddMoney , 2000 )
	
	MisResultAction(AddExp, 1296, 1296)		
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001075 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001075")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001075)	
	
-----------------Ö÷ÏßÈÎÎñ:¹ºÂòµÚÒ»¼þ×°±¸(Ò©Ê¦)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001055")
	DefineMission( 6748, MISSCRIPT_MISSIONSCRIPT05_LUA_001055, 1933 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001056 )
	MisBeginCondition(CheckChaTypeID,3 )
	MisBeginCondition(HasRecord , 1932 )
	MisBeginCondition(NoRecord, 1928 )
	MisBeginCondition(NoMission, 1933 )
	MisBeginAction(AddMission, 1933 )
	MisBeginAction(AddTrigger, 19331, TE_GETITEM, 0541, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001076 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001076")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001076)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001058)
	
	MisNeed(MIS_NEED_ITEM, 0541, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001059)
	
	MisResultCondition(NoRecord, 1933)	
	MisResultCondition(HasMission, 1933)
	MisResultCondition(HasItemShouTao, 0541)
	MisResultAction(ClearMission, 1933)
	MisResultAction(SetRecord, 1928 )
	MisResultAction(AddExp, 3111, 3111)		
	
	MisResultAction(GiveNpcMission1,6749)	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0541)	
	TriggerAction( 1, AddNextFlag, 1933, 10, 1 )
	RegCurTrigger( 19331 )
	
	
-----------------Ñ°ÕÒÔÓ»õÉÌÈË-------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001077 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001077")
	DefineMission( 6749, MISSCRIPT_MISSIONSCRIPT05_LUA_001077, 1934 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001078 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001078")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001078 )
	MisBeginCondition(HasRecord, 1928)
	MisBeginCondition(NoRecord, 1934)
	MisBeginCondition(NoMission, 1934)
	MisBeginAction(AddMission, 1934)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001079 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001079")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001079)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001080 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001080")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001080)	
	
	MisResultCondition(AlwaysFailure )	
-------------------Ñ°ÕÒÔÓ»õÉÌÈË----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001077 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001077")
	DefineMission( 6750, MISSCRIPT_MISSIONSCRIPT05_LUA_001077, 1934 ,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001081 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001081")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001081)
	MisResultCondition(NoRecord, 1934)
	MisResultCondition(HasMission, 1934)
	MisResultAction(ClearMission, 1934 )
	MisResultAction(SetRecord, 1934 )
	MisResultAction(AddExp, 1089, 1089)
	
	MisResultAction(GiveNpcMission1,6751)	
----------------------ÎªÃ°ÏÕ×ö×¼±¸-----------------------------------	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001082 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001082")
	DefineMission( 6751, MISSCRIPT_MISSIONSCRIPT05_LUA_001082, 1935 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001083 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001083")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001083 )
	MisBeginCondition(HasRecord, 1934)
	MisBeginCondition(NoRecord, 1935)
	MisBeginCondition(NoMission, 1935)
	MisBeginAction(AddMission,1935 )
	MisBeginAction(AddTrigger, 19351, TE_GETITEM, 3141, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001084 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001084")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001084)
	MisNeed(MIS_NEED_ITEM, 3141, 1, 10, 1)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001085 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001085")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001085)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001086 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001086")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001086)
	MisResultCondition(HasItem,3141,1 )
	MisResultCondition(NoRecord,1935 )
	MisResultCondition(HasMission,1935 )
	MisResultAction(ClearMission, 1935 )
	MisResultAction(AddMoney,500  )
	MisResultAction(SetRecord, 1935 )
	MisResultAction(AddExp, 3594, 3594)
	
	MisResultAction(GiveNpcMission1,6752)	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3141)	
	TriggerAction( 1, AddNextFlag, 1935, 10, 1 )
	RegCurTrigger( 19351 )
	
----------------------³ö³Ç-----------------------------------		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001087 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001087")
	DefineMission( 6752, MISSCRIPT_MISSIONSCRIPT05_LUA_001087, 1936 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001088 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001088")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001088 )
	MisBeginCondition(HasRecord,1935 )
	MisBeginCondition(NoRecord, 1936)
	MisBeginCondition(NoMission, 1936)
	MisBeginAction(AddMission,1936 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001089 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001089")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001089)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001090 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001090")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001090)			
	MisResultCondition(AlwaysFailure )		
--------------------³ö³Ç-------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001087 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001087")
	DefineMission( 6753, MISSCRIPT_MISSIONSCRIPT05_LUA_001087, 1936 ,COMPLETE_SHOW )	
	
	MisBeginCondition(AlwaysFailure )	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001091 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001091")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001091)	
	MisResultCondition(NoRecord, 1936)
	MisResultCondition(HasMission, 1936)
	MisResultAction(ClearMission,  1936)
	MisResultAction(SetRecord,  1936)
	MisResultAction(AddExp, 1557, 1557)
	
	MisResultAction(GiveNpcMission1,6760)	
	
-----------------Ö÷ÏßÈÎÎñ:¹ºÂòµÚÒ»¼þ×°±¸(Ò©Ê¦-°¬Ã×)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001055")
	DefineMission( 6757, MISSCRIPT_MISSIONSCRIPT05_LUA_001055, 1939 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001056 )
	MisBeginCondition(CheckChaTypeID,4 )
	MisBeginCondition(HasRecord , 1932 )
	MisBeginCondition(NoRecord, 1928 )
	MisBeginCondition(NoMission, 1939 )
	MisBeginAction(AddMission, 1939 )
	MisBeginAction(AddTrigger, 19391, TE_GETITEM, 0559, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001092 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001092")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001092)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001058)
	
	MisNeed(MIS_NEED_ITEM, 0559, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001059)
	
	MisResultCondition(NoRecord, 1939)	
	MisResultCondition(HasMission, 1939)
	MisResultCondition(HasItemShouTao, 0559 )
	MisResultAction(ClearMission, 1939)
	MisResultAction(SetRecord, 1928 )
	MisResultAction(AddExp, 3111, 3111)
	
	MisResultAction(GiveNpcMission1,6749)	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0559)	
	TriggerAction( 1, AddNextFlag, 1939, 10, 1 )
	RegCurTrigger( 19391 )
-------------------------------------ÈËÉúµÄ×ªÕÛ	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001093")
	DefineMission( 6758, MISSCRIPT_MISSIONSCRIPT05_LUA_001093, 1940 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001094 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001094")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001094 )
	MisBeginCondition(LvCheck, ">",8 )	
	MisBeginCondition(NoRecord,1940 )
	MisBeginCondition(NoMission,1940 )
	MisBeginAction(AddMission,1940 )
	MisCancelAction(ClearMission, 1940  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001095 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001095")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001095)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001096 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001096")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001096)
	MisResultCondition(AlwaysFailure )
-------------------------------------ÈËÉúµÄ×ªÕÛ
	MISSCRIPT_MISSIONSCRIPT05_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001093")
	DefineMission( 6759, MISSCRIPT_MISSIONSCRIPT05_LUA_001093,1940 , COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001097 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001097")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001097)
	MisResultCondition(CheckJobIsNew)
	MisResultCondition(NoRecord,1940 )
	MisResultCondition(HasMission, 1940)
	MisResultAction(ClearMission,1940)
	MisResultAction(SetRecord,1940 )
	MisResultAction(AddExp, 757, 757)
	
	MisResultAction(GiveNpcMission1,6735)	
		
------
		
--------------Ö÷ÏßÈÎÎñ£ºÌáÉýÊµÁ¦-------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001098 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001098")
	DefineMission( 6760, MISSCRIPT_MISSIONSCRIPT05_LUA_001098,1941 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001099 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001099")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001099 )
	MisBeginCondition(HasRecord,1936 )
	MisBeginCondition(NoRecord, 1941)
	MisBeginCondition(NoMission, 1941)
	MisBeginAction(AddMission,1941 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001100 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001100")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001100)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001101 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001101")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001101)
	
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£ºÌáÉýÊµÁ¦-----------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001098 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001098")
	DefineMission( 6761, MISSCRIPT_MISSIONSCRIPT05_LUA_001098,1941 )
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001102 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001102")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001102)
	MisResultCondition(NoRecord,1941 )
	MisResultCondition(HasMission, 1941)
	MisResultAction(ClearMission,1941)
	MisResultAction(SetRecord,1941 )
	MisResultAction(AddExp, 2569, 2569)
	
	MisResultAction(GiveNpcMission1,6762)
	
--------------Ö÷ÏßÈÎÎñ£ºÌáÉýÊµÁ¦-------------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001103 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001103")
	DefineMission( 6762, MISSCRIPT_MISSIONSCRIPT05_LUA_001103,1942 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001104 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001104")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001104 )
	MisBeginCondition(HasRecord,1941 )
	MisBeginCondition(NoRecord, 1942)
	MisBeginCondition(NoMission, 1942)
	MisBeginAction(AddMission,1942 )
	MisBeginAction(AddMoney,3900,3900)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001105 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001105")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001105)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001106 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001106")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001106)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001107 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001107")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001107)
	
	MisResultCondition( HasBagJieZhi )
	MisResultCondition(NoRecord,1942 )
	MisResultCondition(HasMission, 1942)
	MisResultAction(ClearMission,1942)
	MisResultAction(SetRecord,1942 )
	MisResultAction(AddExp, 5910, 5910)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001108 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001108")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001108)
	
	
--------------Ö÷ÏßÈÎÎñ£ºá÷ÁÔÌú¼×Ð·----------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001109 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001109")
	DefineMission( 6763, MISSCRIPT_MISSIONSCRIPT05_LUA_001109,1943 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001110")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001110 )
	MisBeginCondition(PfEqual1, 1 )	
	MisBeginCondition(HasRecord,1942 )
	MisBeginCondition(NoRecord, 1943)
	MisBeginCondition(NoMission, 1943)
	MisBeginAction(AddMission,1943 )
	MisBeginAction(AddTrigger, 19431, TE_KILL, 258, 10 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisNeed(MIS_NEED_KILL, 258, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001111 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001111")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001111)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001112 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001112")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001112)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001113 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001113")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001113)
	
	MisResultCondition(NoRecord,1943 )
	MisResultCondition(HasMission, 1943)
	MisResultCondition(HasFlag, 1943, 19 )
	MisResultAction(ClearMission,1943)
	MisResultAction(SetRecord, 1943 )
	MisResultAction(AddExp, 6402, 6402)
	
	MisResultAction(GiveNpcMission1,6767)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 258 )	
	TriggerAction( 1, AddNextFlag, 1943, 10, 10 )
	RegCurTrigger( 19431 )
	
--------------Ö÷ÏßÈÎÎñ£ºá÷ÁÔ²Ð±©É½Ñò----------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001114 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001114")
	DefineMission( 6764, MISSCRIPT_MISSIONSCRIPT05_LUA_001114,1944 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001115 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001115")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001115 )
	MisBeginCondition(PfEqual1, 2 )	
	MisBeginCondition(HasRecord,1942 )
	MisBeginCondition(NoRecord, 1943)
	MisBeginCondition(NoMission, 1944)
	MisBeginAction(AddMission,1944 )
	MisBeginAction(AddTrigger, 19441, TE_KILL, 126, 10 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisNeed(MIS_NEED_KILL, 126, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001116 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001116")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001116)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001112 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001112")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001112)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001113 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001113")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001113)
	
	MisResultCondition(NoRecord,1944 )
	MisResultCondition(HasMission, 1944)
	MisResultCondition(HasFlag, 1944, 19 )
	MisResultAction(ClearMission,1944)
	MisResultAction(SetRecord, 1943 )
	MisResultAction(AddExp, 6402, 6402)
	
	MisResultAction(GiveNpcMission1,6767)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 126 )	
	TriggerAction( 1, AddNextFlag, 1944, 10, 10 )
	RegCurTrigger( 19441 )
	
	
	
--------------Ö÷ÏßÈÎÎñ£ºá÷ÁÔÐÜ±¦±¦-(Ã°ÏÕ)---------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001109 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001109")
	DefineMission( 6765, MISSCRIPT_MISSIONSCRIPT05_LUA_001109,1945 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001117 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001117")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001117 )
	MisBeginCondition(PfEqual1, 4 )	
	MisBeginCondition(HasRecord,1942 )
	MisBeginCondition(NoRecord, 1943)
	MisBeginCondition(NoMission, 1945)
	MisBeginAction(AddMission,1945 )
	MisBeginAction(AddTrigger, 19451, TE_KILL, 258, 10 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisNeed(MIS_NEED_KILL, 258, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001118 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001118")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001118)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001112 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001112")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001112)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001113 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001113")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001113)
	
	MisResultCondition(NoRecord,1945 )
	MisResultCondition(HasMission, 1945)
	MisResultCondition(HasFlag, 1945, 19 )
	MisResultAction(ClearMission,1945)
	MisResultAction(SetRecord, 1943 )
	MisResultAction(AddExp, 6402, 6402)
	
	MisResultAction(GiveNpcMission1,6767)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 258 )	
	TriggerAction( 1, AddNextFlag, 1945, 10, 10 )
	RegCurTrigger( 19451 )
	
	
--------------Ö÷ÏßÈÎÎñ£ºá÷ÁÔÐÜ±¦±¦-(Ò©Ê¦)---------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001109 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001109")
	DefineMission( 6766, MISSCRIPT_MISSIONSCRIPT05_LUA_001109,1946 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001119 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001119")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001119 )
	MisBeginCondition(PfEqual1, 5 )	
	MisBeginCondition(HasRecord,1942 )
	MisBeginCondition(NoRecord, 1943)
	MisBeginCondition(NoMission, 1946)
	MisBeginAction(AddMission,1946 )
	MisBeginAction(AddTrigger, 19461, TE_KILL, 258, 10 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisNeed(MIS_NEED_KILL, 258, 10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001118 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001118")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001118)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001112 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001112")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001112)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001113 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001113")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001113)
	
	MisResultCondition(NoRecord,1946 )
	MisResultCondition(HasMission, 1946)
	MisResultCondition(HasFlag, 1946, 19 )
	MisResultAction(ClearMission,1946)
	MisResultAction(SetRecord, 1943 )
	MisResultAction(AddExp, 6402, 6402)
	
	MisResultAction(GiveNpcMission1,6767)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 258 )	
	TriggerAction( 1, AddNextFlag, 1946, 10, 10 )
	RegCurTrigger( 19461 )	
	
	
--------------Ö÷ÏßÈÎÎñ£ºÒøÐÐ³öÄÉ---------------
	CALCULATE_FUNCTIONS_LUA_000693 = GetResString("CALCULATE_FUNCTIONS_LUA_000693")
	DefineMission( 6767, CALCULATE_FUNCTIONS_LUA_000693,1947 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001120 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001120")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001120 )
	MisBeginCondition(HasRecord,1943 )
	MisBeginCondition(NoRecord, 1947)
	MisBeginCondition(NoMission, 1947)
	MisBeginAction(AddMission,1947 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001121 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001121")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001121)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001122 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001122")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001122)
	
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£ºÒøÐÐ³öÄÉ-----------
	CALCULATE_FUNCTIONS_LUA_000693 = GetResString("CALCULATE_FUNCTIONS_LUA_000693")
	DefineMission( 6768, CALCULATE_FUNCTIONS_LUA_000693,1947  , COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001123 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001123")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001123)
	MisResultCondition(NoRecord,1947 )
	MisResultCondition(HasMission, 1947)
	MisResultAction(ClearMission,1947)
	MisResultAction(SetRecord,1947 )
	MisResultAction(AddExp, 4801, 4801)
	
	MisResultAction(GiveNpcMission1,6769)
	
	
--------------Ö÷ÏßÈÎÎñ£ºµÚÒ»´Î´æÒøÐÐ--------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001124 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001124")
	DefineMission( 6769, MISSCRIPT_MISSIONSCRIPT05_LUA_001124,1948 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001125 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001125")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001125 )
	MisBeginCondition(HasRecord,1947 )
	MisBeginCondition(NoRecord, 1948)
	MisBeginCondition(NoMission, 1948)
	MisBeginAction(AddMission,1948 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001126 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001126")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001126)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001127 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001127")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001127)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001128 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001128")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001128)
	
	MisResultCondition(CheckBankItemOrLv,6020,1 )
	MisResultCondition(NoRecord,1948 )
	MisResultCondition(HasMission, 1948)
	MisResultAction(ClearMission,1948)
	MisResultAction(SetRecord, 1948 )
	MisResultAction(AddExp, 11043, 11043)
	
	MisResultAction(GiveNpcMission1,6770)
	
	
--------------Ö÷ÏßÈÎÎñ£ºÉñÃØµÄÕ¼²·Ê¦---------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001026 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001026")
	DefineMission( 6770, MISSCRIPT_MISSIONSCRIPT05_LUA_001026,1949 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001129 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001129")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001129 )
	MisBeginCondition(HasRecord,1948 )
	MisBeginCondition(NoRecord, 1949)
	MisBeginCondition(NoMission, 1949)
	MisBeginAction(AddMission,1949 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001130 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001130")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001130)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001131 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001131")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001131)
	
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£ºÉñÃØµÄÕ¼²·Ê¦ -----------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001026 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001026")
	DefineMission( 6771, MISSCRIPT_MISSIONSCRIPT05_LUA_001026,1949  , COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001132 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001132")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001132)
	MisResultCondition(NoRecord,1949 )
	MisResultCondition(HasMission, 1949)
	MisResultAction(ClearMission,1949)
	MisResultAction(SetRecord,1949 )
	MisResultAction(AddExp, 7178, 7178)
	
	MisResultAction(GiveNpcMission1,6772)
	
	
--------------Ö÷ÏßÈÎÎñ£ºµÚÒ»´ÎÕ¼²·--------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001133 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001133")
	DefineMission( 6772, MISSCRIPT_MISSIONSCRIPT05_LUA_001133,1950 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001134 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001134")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001134 )
	MisBeginCondition(HasRecord,1949 )
	MisBeginCondition(NoRecord, 1950)
	MisBeginCondition(NoMission, 1950)
	MisBeginAction(AddMission,1950 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001135 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001135")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001135)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001136 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001136")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001136)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001137 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001137")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001137 )
	
	MisResultCondition( CheckZBNowState )
	MisResultCondition( NoRecord,1950 )
	MisResultCondition( HasMission, 1950)
	MisResultAction( ClearMission,1950)
	MisResultAction( SetRecord, 1950 )
	MisResultAction(AddExp, 7154, 7154)
	
	MisResultAction(GiveNpcMission1,6773)
--------------Ö÷ÏßÈÎÎñ£ºÄªÃûµÄÃüÔË--------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001138 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001138")
	DefineMission( 6773, MISSCRIPT_MISSIONSCRIPT05_LUA_001138,1951 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001139 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001139")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001139 )
	MisBeginCondition(HasRecord,1950 )
	MisBeginCondition(NoRecord, 1951)
	MisBeginCondition(NoMission, 1951)
	MisBeginAction(AddMission,1951 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisResultCondition(AlwaysFailure)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001140 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001140")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001140)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001141 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001141")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001141)
--------------Ö÷ÏßÈÎÎñ£ºÄªÃûµÄÃüÔË--------------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001138 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001138")
	DefineMission( 6774, MISSCRIPT_MISSIONSCRIPT05_LUA_001138,1951 )	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001142 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001142")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001142 )
	MisBeginCondition( AlwaysFailure )
	MisResultCondition( NoRecord,1951 )
	MisResultCondition( HasMission, 1951)
	MisResultAction( ClearMission,1951)
	MisResultAction( SetRecord, 1951 )
	MisResultAction(AddExp, 7870, 7870)
	
	MisResultAction(GiveNpcMission1,6775)
-------------------------------½ô¼±ÅàÑµ
	MISSCRIPT_MISSIONSCRIPT05_LUA_001143 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001143")
	DefineMission( 6775, MISSCRIPT_MISSIONSCRIPT05_LUA_001143, 1952 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001144 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001144")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001144 )
	MisBeginCondition(HasRecord,1951 )
	MisBeginCondition(NoRecord,1952 )
	MisBeginCondition(NoMission,1952 )
	MisBeginAction(AddMission,1952 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001145 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001145")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001145)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001146 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001146")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001146)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001147 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001147")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001147)
	MisResultCondition(NoRecord,1952 )
	MisResultCondition(HasMission, 1952)
	MisResultAction(ClearMission,1952)
	MisResultAction(SetRecord,1952 )
	MisResultAction(AddExp, 16510, 16510)
	
	MisResultAction(GiveNpcMission1,6776)
---------------µÚÒ»´ÎÅàÑµ
	MISSCRIPT_MISSIONSCRIPT05_LUA_001148 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001148")
	DefineMission( 6776, MISSCRIPT_MISSIONSCRIPT05_LUA_001148, 1953 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001149 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001149")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001149 )
	MisBeginCondition(NoRecord,1953 )
	MisBeginCondition(HasRecord,1952 )
	MisBeginCondition(NoMission,1953 )
	MisBeginAction(AddMission,1953 )
	MisCancelAction(ClearMission, 1953  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001150 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001150")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001150)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001146 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001146")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001146)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001151 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001151")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001151)
	MisResultCondition(NoRecord,1953 )
	MisResultCondition(HasMission, 1953)
	MisResultAction(ClearMission,1953)
	MisResultAction(SetRecord,1953 )
	-- MisResultAction(AddExpRealPer2, 0.1 )
	
	MisResultAction(GiveNpcMission1,6777)
---------------µÚ¶þ´ÎÅàÑµ
	MISSCRIPT_MISSIONSCRIPT05_LUA_001152 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001152")
	DefineMission( 6777, MISSCRIPT_MISSIONSCRIPT05_LUA_001152, 1954 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001153 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001153")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001153)
	MisBeginCondition(NoRecord,1954 )
	MisBeginCondition(HasRecord,1953 )
	MisBeginCondition(NoMission,1954 )
	MisBeginAction(AddMission,1954 )
	MisCancelAction(ClearMission, 1954  )
	MisCancelAction(ClearRecord, 1953  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001154 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001154")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001154)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001146 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001146")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001146)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001155 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001155")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001155)
	MisResultCondition(NoRecord,1954 )
	MisResultCondition(HasMission, 1954)
	MisResultAction(ClearMission,1954)
	MisResultAction(SetRecord,1954 )
	-- MisResultAction(AddExpRealPer2, 0.1 )
	
	MisResultAction(GiveNpcMission1,6778)
------------µÚÈý´ÎÅàÑµ
	MISSCRIPT_MISSIONSCRIPT05_LUA_001156 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001156")
	DefineMission( 6778, MISSCRIPT_MISSIONSCRIPT05_LUA_001156, 1955 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001157 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001157")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001157 )
	MisBeginCondition(NoRecord,1955 )
	MisBeginCondition(HasRecord,1954 )
	MisBeginCondition(NoMission,1955 )
	MisBeginAction(AddMission,1955 )
	MisCancelAction(ClearMission, 1955  )
	MisCancelAction(ClearRecord, 1953  )
	MisCancelAction(ClearRecord, 1954  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001158 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001158")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001158)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001146 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001146")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001146)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001159 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001159")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001159)
	MisResultCondition(NoRecord,1955)
	MisResultCondition(HasMission, 1955)
	MisResultAction(ClearMission,1955)
	MisResultAction(SetRecord,1955)
	
	MisResultAction(GiveNpcMission1,6779)
------------¿¼ÊÔ
	MISSCRIPT_MISSIONSCRIPT05_LUA_001160 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001160")
	DefineMission( 6779, MISSCRIPT_MISSIONSCRIPT05_LUA_001160, 1956 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001161 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001161")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001161)
	MisBeginCondition(NoRecord,1956 )
	MisBeginCondition(HasRecord,1955 )
	MisBeginCondition(NoMission,1956 )
	MisBeginAction(AddMission,1956 )
	MisCancelAction(ClearMission, 1956  )
	MisCancelAction(ClearRecord, 1953  )
	MisCancelAction(ClearRecord, 1954  )
	MisCancelAction(ClearRecord, 1955  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001162 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001162")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001162)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001163 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001163")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001163)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001164 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001164")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001164)
	MisResultCondition(CheckXXBYPoint,">",0)
	MisResultCondition(NoRecord,1956)
	MisResultCondition(HasMission, 1956)
	MisResultAction(ClearMission,1956)
	MisResultAction(SetRecord,1956 )
	--MisResultAction(AddExpRealPer2, 1.2 )
	MisResultAction(GiveXXBYRewards)
	MisResultBagNeed(4)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001165 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001165")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001165)
		
	
-------ÀúÁ·(¹ÅÀï¿©Àû)---------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001166 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001166")
	DefineMission( 6780, MISSCRIPT_MISSIONSCRIPT05_LUA_001166, 1957 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001167 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001167")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001167)
	MisBeginCondition(LvCheck, "<",30 )	
	MisBeginCondition(HasRecord,1956 )
	MisBeginCondition(NoMission,1959 )
	MisBeginCondition(NoMission,1957)
	MisBeginCondition(NoMission,1958 )
	MisBeginAction(AddMission,1957 )
	MisCancelAction(ClearMission, 1957  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001168 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001168")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001168)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001169 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001169")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001169)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001170 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001170")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001170)
	MisResultCondition(HasItem , 6709 ,1 )
	MisResultCondition(HasMission, 1957)
	MisResultAction(ClearMission,1957)
	MisResultAction(SetRecord,1957 )
	MisResultAction(BLGLPrize)
	MisResultBagNeed(4)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001171")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001171,1)
	
-------ÀúÁ·(°Í²¼²¹¸øÕ¾)---------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001172 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001172")
	DefineMission( 6781, MISSCRIPT_MISSIONSCRIPT05_LUA_001172, 1958 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001173 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001173")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001173)
	MisBeginCondition(LvCheck, "<",30 )	
	MisBeginCondition(HasRecord,1956 )
	MisBeginCondition(NoMission,1959 )
	MisBeginCondition(NoMission,1957)
	MisBeginCondition(NoMission,1958 )
	MisBeginAction(AddMission,1958 )
	MisCancelAction(ClearMission, 1958  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001174 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001174")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001174)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001175 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001175)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001170 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001170")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001170)
	MisResultCondition(HasItem , 6710 ,1 )
	MisResultCondition(HasMission, 1958)
	MisResultAction(ClearMission,1958)
	MisResultAction(SetRecord,1957 )
	MisResultAction(BaBuPrize)
	MisResultBagNeed(4)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001171")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001171,2)
	
	
------ÀúÁ·(°¢À¼±ÈË¹²¹¸øÕ¾)---------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001176 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001176")
	DefineMission( 6782, MISSCRIPT_MISSIONSCRIPT05_LUA_001176, 1959 )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001177 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001177")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001177)
	MisBeginCondition(LvCheck, "<",30 )	
	MisBeginCondition(HasRecord,1956 )
	MisBeginCondition(NoMission,1959 )
	MisBeginCondition(NoMission,1957)
	MisBeginCondition(NoMission,1958 )
	MisBeginAction(AddMission,1959 )
	MisCancelAction(ClearMission, 1959  )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001178 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001178")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001178)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001179 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001179")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001179)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001170 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001170")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001170)
	MisResultCondition(HasItem , 6711 ,1 )
	MisResultCondition(HasMission, 1959)
	MisResultAction(SetRecord,1957 )
	MisResultAction(ClearMission,1959)
	MisResultAction(ALBSPrize)
	MisResultBagNeed(4)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001171")
	MisResultAction(GiveNpcMissionbyFunc,MISSCRIPT_MISSIONSCRIPT05_LUA_001171,3)
	
----------------Ö÷ÏßÈÎÎñ£ºÕÒµ½´¬¹¤ ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001180")
	DefineMission( 6783, MISSCRIPT_MISSIONSCRIPT05_LUA_001180, 1960 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001181 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001181")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001181 )
	MisBeginCondition(LvCheck, ">",29 )	
	MisBeginCondition(HasRecord,1956 )
	MisBeginCondition(NoRecord, 1960)
	MisBeginCondition(NoMission, 1960)
	MisBeginAction(AddMission, 1960)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001182 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001182")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001182)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001183 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001183")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001183)
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£ºÕÒµ½´¬¹¤ ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001180")
	DefineMission( 6784, MISSCRIPT_MISSIONSCRIPT05_LUA_001180, 1960 , COMPLETE_SHOW)	
	
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001184 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001184")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001184)
	
	MisResultCondition(HasMission, 1960)
	MisResultAction(ClearMission, 1960)
	MisResultAction(SetRecord, 1960 )
	MisBeginAction(GiveItem, 6042, 1, 4)
	MisResultAction(AddExp, 9544, 9544)
	MisResultAction(GiveNpcMission1,6785)
	
	MisResultBagNeed(1)
	
----------------Ö÷ÏßÈÎÎñ£º½¨Ôì´¬Ö»------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001185")
	DefineMission( 6785, MISSCRIPT_MISSIONSCRIPT05_LUA_001185, 1961 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001186 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001186")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001186 )
	MisBeginCondition(HasRecord, 1960)
	MisBeginCondition(NoRecord, 1961)
	MisBeginCondition(NoMission, 1961)
	MisBeginAction(AddMission, 1961)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001187 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001187")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001187)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001188 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001188")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001188)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001189 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001189")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001189)
	MisResultCondition(HasItem, 3988,1)	-----ÅÐ¶ÏÉíÉÏµÄ´¬Ö»Ö¤Ã÷
	MisResultCondition(HasMission, 1961)
	MisResultAction(ClearMission, 1961)
	MisResultAction(SetRecord, 1961 )
	MisResultAction(AddExp, 17577, 17577)
	
	MisResultAction(GiveNpcMission1,6786)
	
----------------Ö÷ÏßÈÎÎñ£ºº£¸ÛÖ¸»Ó ------------------	
	CALCULATE_FUNCTIONS_LUA_000698 = GetResString("CALCULATE_FUNCTIONS_LUA_000698")
	DefineMission( 6786, CALCULATE_FUNCTIONS_LUA_000698, 1962 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001190 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001190")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001190 )
	MisBeginCondition(HasRecord, 1961)
	MisBeginCondition(NoRecord, 1962)
	MisBeginCondition(NoMission, 1962)
	MisBeginAction(AddMission, 1962)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001191 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001191")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001191)		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001192 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001192")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001192)	
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£ºº£¸ÛÖ¸»Ó ------------------	
	CALCULATE_FUNCTIONS_LUA_000698 = GetResString("CALCULATE_FUNCTIONS_LUA_000698")
	DefineMission( 6787, CALCULATE_FUNCTIONS_LUA_000698, 1962 , COMPLETE_SHOW)	
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001193 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001193")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001193)
	
	MisResultCondition(HasMission, 1962)
	MisResultAction(ClearMission, 1962)
	MisResultAction(SetRecord, 1962 )
	MisBeginAction(GiveItem, 6042, 1, 4)
	MisResultAction(AddExp, 12392, 12392)
	
	MisResultAction(GiveNpcMission1,6788)
	
----------------Ö÷ÏßÈÎÎñ£ºµÚÒ»´Î³öº£------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001194 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001194")
	DefineMission( 6788, MISSCRIPT_MISSIONSCRIPT05_LUA_001194, 1963 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001195 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001195")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001195 )
	MisBeginCondition(HasRecord, 1962)
	MisBeginCondition(NoRecord, 1963)
	MisBeginCondition(NoMission, 1963)
	MisBeginAction(AddMission, 1963)
	MisBeginAction(AddTrigger, 19631, TE_KILL, 1184, 5 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MisNeed(MIS_NEED_KILL, 1184, 5, 10, 5)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001196 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001196")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001196)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001197")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001197)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001198 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001198")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001198)
	MisResultCondition(HasMission, 1963)
	MisResultCondition(HasFlag, 1963, 14 )
	MisResultAction(ClearMission, 1963)
	MisResultAction(SetRecord, 1963 )
	MisResultAction(AddExp, 22821, 22821)
	
	MisResultAction(GiveNpcMission1,6789)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 1184 )	
	TriggerAction( 1, AddNextFlag, 1963, 10, 5 )
	RegCurTrigger( 19631 )
	
----------------Ö÷ÏßÈÎÎñ£º´¬Ö»Éý¼¶------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001199 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001199")
	DefineMission( 6789, MISSCRIPT_MISSIONSCRIPT05_LUA_001199, 1964 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001200 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001200")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001200 )
	MisBeginCondition(HasRecord, 1963)
	MisBeginCondition(NoRecord, 1964)
	MisBeginCondition(NoMission, 1964)
	MisBeginAction(AddMission, 1964)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001201 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001201")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001201)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001202 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001202")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001202)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001203 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001203")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001203)
	
	MisResultCondition(HasCleckLevel)		--------ÅÐ¶Ï´¬Ö»µÈ¼¶
	MisResultCondition(HasMission, 1964)
	MisResultAction(ClearMission, 1964)
	MisResultAction(SetRecord, 1964 )
	MisResultAction(AddExp, 26815, 26815)
	
	MisResultAction(GiveNpcMission1,6790)
	
----------------Ö÷ÏßÈÎÎñ£º´¬Ö»²¹¸ø------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001204 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001204")
	DefineMission( 6790, MISSCRIPT_MISSIONSCRIPT05_LUA_001204, 1965 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001205 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001205")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001205 )
	MisBeginCondition(HasRecord, 1964)
	MisBeginCondition(NoRecord, 1965)
	MisBeginCondition(NoMission, 1965)
	MisBeginAction(AddMission, 1965)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001206 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001206")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001206)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001207 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001207")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001207)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001208 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001208")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001208)
	MisResultCondition(HasCleckSupply)		--------ÅÐ¶Ï´¬Ö»²¹¸ø
	MisResultCondition(HasMission, 1965)
	MisResultAction(ClearMission, 1965)
	MisResultAction(SetRecord, 1965 )
	MisResultAction(AddExp, 31508, 31508)
	
	MisResultAction(GiveNpcMission1,6791)
	
----------------Ö÷ÏßÈÎÎñ£º´¬Ö»´òÀÌ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001209 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001209")
	DefineMission( 6791, MISSCRIPT_MISSIONSCRIPT05_LUA_001209, 1966 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001210 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001210")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001210 )
	MisBeginCondition(HasRecord, 1965)
	MisBeginCondition(NoRecord, 1966)
	MisBeginCondition(NoMission, 1966)
	MisBeginAction(AddMission, 1966)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001211 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001211")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001211)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001212 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001212")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001212)
	MisResultCondition(HasMission, 1966)
	MisResultAction(ClearMission, 1966)
	MisResultAction(SetRecord, 1966 )
	MisResultAction(AddExp, 22213, 22213)
	
	MisResultAction(GiveNpcMission1,6792)
	
	
	
----------------Ö÷ÏßÈÎÎñ£º×°±¸Ç¿»¯------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001213 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001213")
	DefineMission( 6792, MISSCRIPT_MISSIONSCRIPT05_LUA_001213, 1967 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001214 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001214")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001214 )
	MisBeginCondition(HasRecord, 1966)
	MisBeginCondition(NoRecord, 1967)
	MisBeginCondition(NoMission, 1967)
	MisBeginAction(AddMission, 1967)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001215 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001215")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001215)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001216 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001216")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001216)
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£º×°±¸Ç¿»¯ ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001217 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001217")
	DefineMission( 6793, MISSCRIPT_MISSIONSCRIPT05_LUA_001217, 1967 , COMPLETE_SHOW)	
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001218 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001218")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001218)
	
	MisResultCondition(HasMission, 1967)
	MisResultAction(ClearMission, 1967)
	MisResultAction(SetRecord, 1967 )
	MisResultAction(AddExp, 24545, 24545)
	
	MisResultAction(GiveNpcMission1,6794)
	
----------------Ö÷ÏßÈÎÎñ£ºµÚÒ»´ÎÊ¹ÓÃÉÌ³Ç------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001219 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001219")
	DefineMission( 6794, MISSCRIPT_MISSIONSCRIPT05_LUA_001219, 1968 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001220 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001220")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001220 )
	MisBeginCondition(HasRecord, 1967)
	MisBeginCondition(NoRecord, 1968)
	MisBeginCondition(NoMission, 1968)
	MisBeginAction(AddMission, 1968)
	MisBeginAction(AddTrigger, 19681, TE_GETITEM, 6717, 1 )		--ÊÔÁ¶¾«Á¶Ê¯
	MisBeginAction(AddTrigger, 19682, TE_GETITEM, 6718, 1 )		--ÌåÖÊÖ®ÊÔÁ¶±¦Ê¯
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MisNeed(MIS_NEED_ITEM, 6717, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 6718, 1, 20, 1)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001221 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001221")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001221)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001222 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001222")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001222)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001223 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001223")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001223)
	MisResultCondition(HasItem, 6717 , 1 )
	MisResultCondition(HasItem, 6718 , 1 )
	MisResultCondition(HasMission, 1968)
	MisResultAction(ClearMission, 1968)
	MisResultAction(SetRecord, 1968 )
	MisResultAction(AddExp, 45204, 45204)
	
	MisResultAction(GiveNpcMission1,6795)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 6717)	
	TriggerAction( 1, AddNextFlag, 1968, 10, 1 )
	RegCurTrigger( 19681 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 6718)	
	TriggerAction( 1, AddNextFlag, 1968, 20, 1 )
	RegCurTrigger( 19682 )
	
----------------Ö÷ÏßÈÎÎñ£ºµÚÒ»´Î¾«Á¶------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001224 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001224")
	DefineMission( 6795, MISSCRIPT_MISSIONSCRIPT05_LUA_001224, 1969 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001225 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001225")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001225 )
	MisBeginCondition(HasRecord, 1968)
	MisBeginCondition(NoRecord, 1969)
	MisBeginCondition(NoMission, 1969)
	MisBeginAction(AddMission, 1969)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001226 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001226")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001226)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001227 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001227")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001227)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001228")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001228)
	
	MisResultCondition(CheckRoleLearnedForge)		-------¼ì²âÒÂ·þÊÇ·ñ¾«Á¶¹ý
	MisResultCondition(HasMission, 1969)
	MisResultAction(ClearMission, 1969)
	MisResultAction(SetRecord, 1969 )
	MisResultAction(AddExp, 53115, 53115)
	
	MisResultAction(GiveNpcMission1,6796)
	
----------------Ö÷ÏßÈÎÎñ£º±¦Ê¯ºÏ³É------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001229 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001229")
	DefineMission( 6796, MISSCRIPT_MISSIONSCRIPT05_LUA_001229, 1970 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001230 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001230")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001230 )
	MisBeginCondition(HasRecord, 1969)
	MisBeginCondition(NoRecord, 1970)
	MisBeginCondition(NoMission, 1970)
	MisBeginAction(AddMission, 1970)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001231 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001231")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001231)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001232 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001232")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001232)
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£º±¦Ê¯ºÏ³É ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001233 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001233")
	DefineMission( 6797, MISSCRIPT_MISSIONSCRIPT05_LUA_001233, 1970 , COMPLETE_SHOW)	
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001234 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001234")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001234)
	
	MisResultCondition(HasMission, 1970)
	MisResultAction(ClearMission, 1970)
	MisResultAction(SetRecord, 1970 )
	MisResultAction(AddExp, 37446, 37446)
	
	MisResultAction(GiveNpcMission1,6798)
	
	
----------------Ö÷ÏßÈÎÎñ£º±¦Ê¯ºÏ³É------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001235 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001235")
	DefineMission( 6798, MISSCRIPT_MISSIONSCRIPT05_LUA_001235, 1971 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001236 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001236")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001236 )
	MisBeginCondition(HasRecord, 1970)
	MisBeginCondition(NoRecord, 1971)
	MisBeginCondition(NoMission, 1971)
	MisBeginAction(AddMission, 1971)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001237 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001237")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001237)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001238 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001238")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001238)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001239 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001239")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001239)
	
	MisResultCondition(CheckBaoShiLV, 6718)		-------¼ì²â±¦Ê¯ÊÇ·ñºÏ³É
	MisResultCondition(HasMission, 1971)
	MisResultAction(ClearMission, 1971)
	MisResultAction(SetRecord, 1971 )
	MisResultAction(AddExp, 68963, 68963)
	
	MisResultAction(GiveNpcMission1,6800)
	
	
	
----------------Ö÷ÏßÈÎÎñ£ºµÚ¶þ´Î¿¼ÊÔ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001240")
	DefineMission( 6800, MISSCRIPT_MISSIONSCRIPT05_LUA_001240, 1972 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001241 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001241")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001241 )
	MisBeginCondition(HasRecord, 1971)
	MisBeginCondition(NoRecord, 1972)
	MisBeginCondition(NoMission, 1972)
	MisBeginAction(AddMission, 1972)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001242 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001242")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001242)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001243 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001243")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001243)
	
	MisResultCondition(AlwaysFailure )
	
----------------Ö÷ÏßÈÎÎñ£ºµÚ¶þ´Î¿¼ÊÔ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001240")
	DefineMission( 6801, MISSCRIPT_MISSIONSCRIPT05_LUA_001240, 1972 )
	MisBeginCondition( AlwaysFailure )	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001244 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001244")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001244)
	
	MisResultCondition(HasMission, 1972)
	MisResultAction(ClearMission, 1972)
	MisResultAction(SetRecord, 1972 )
	MisResultAction(AddExp, 81032, 81032)
	
	MisResultAction(GiveNpcMission1,6802)
		
----------------Ö÷ÏßÈÎÎñ£ºµÚ¶þ´Î¿¼ÊÔ------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001240")
	DefineMission( 6802, MISSCRIPT_MISSIONSCRIPT05_LUA_001240, 1973 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001245 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001245")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001245 )
	MisBeginCondition(HasRecord, 1972)
	MisBeginCondition(NoRecord, 1973)
	MisBeginCondition(NoMission, 1973)
	MisBeginAction(AddMission, 1973)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001246 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001246")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001246)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001247 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001247")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001247)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001248 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001248")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001248)
	
	MisResultCondition(CheckZXBYPoint,">",0)
	MisResultCondition(HasMission, 1973)
	MisResultAction(ClearMission, 1973)
	MisResultAction(SetRecord, 1973 )
	--MisResultAction(AddExpRealPer2, 0.5 )
	MisResultAction(GiveZXBYRewards)
	
	
-----------------Ö÷ÏßÈÎÎñ:¹ºÂòµÚÒ»¼þ×°±¸(Ã°ÏÕÕß--°¬Ã×)---------------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001055")
	DefineMission( 6803, MISSCRIPT_MISSIONSCRIPT05_LUA_001055, 1974 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001056 )
	
	MisBeginCondition(IsChaType , 4 )
	MisBeginCondition(HasRecord , 1937 )
	MisBeginCondition(NoRecord, 1928 )
	MisBeginCondition(NoMission, 1974 )
	MisBeginAction(AddMission, 1974 )
	MisBeginAction(AddTrigger, 19741, TE_GETITEM, 0556, 1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001249 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001249")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001249)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001058)
	
	MisNeed(MIS_NEED_ITEM, 0556, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001059)
	
	MisResultCondition(NoRecord, 1974)	
	MisResultCondition(HasMission, 1974)
	MisResultCondition(HasItemShouTao, 0556)
	MisResultAction(ClearMission, 1974)
	MisResultAction(SetRecord, 1928 )
	MisResultAction(AddExp, 3111, 3111)
	MisResultAction(GiveNpcMission1,6749)	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 0556)	
	TriggerAction( 1, AddNextFlag, 1974, 10, 1 )
	RegCurTrigger( 19741 )			
---------5¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001250 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001250")
	DefineMission( 6814, MISSCRIPT_MISSIONSCRIPT05_LUA_001250, 1984 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001251 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001251")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001251 )
	
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(NoRecord, 1984 )
	MisBeginCondition(NoMission, 1984 )
	MisBeginAction(AddMission, 1984 )
	MisBeginAction(AddTrigger, 19841, TE_GETITEM, 6717, 1 )		
	MisCancelAction(ClearMission, 1984)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001252 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001252")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001252)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001253 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001253")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001253)
	
	MisNeed(MIS_NEED_ITEM, 6717, 1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001254 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001254")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001254)
	
	MisResultCondition(NoRecord, 1984)	
	MisResultCondition(HasMission, 1984)
	MisResultCondition(HasItem, 6717, 1)
	MisResultAction(ClearMission, 1984)
	MisResultAction(SetRecord, 1984 )
	MisResultAction(GiveItem,6901,1,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 6717)	
	TriggerAction( 1, AddNextFlag, 1984, 10, 1 )
	RegCurTrigger( 19841 )	
	

---------10¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001255 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001255")
	DefineMission( 6815, MISSCRIPT_MISSIONSCRIPT05_LUA_001255, 1985 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001256 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001256")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001256 )
	
	MisBeginCondition(LvCheck, ">", 9 )
	MisBeginCondition(HasRecord, 1984 )
	MisBeginCondition(NoRecord, 1985 )
	MisBeginCondition(NoMission, 1985 )
	MisBeginAction(AddMission, 1985 )

	MisBeginAction(AddTrigger, 19851, TE_KILL, 62, 10 )
	MisCancelAction(ClearMission, 1985)

	MisNeed(MIS_NEED_KILL, 62, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001257 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001257")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001257)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001258 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001258")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001258)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001259 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001259")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001259)
	
	MisResultCondition(NoRecord, 1985)	
	MisResultCondition(HasMission, 1985)
	MisResultCondition(HasFlag, 1985, 19 )
	MisResultAction(ClearMission, 1985)
	MisResultAction(SetRecord, 1985 )
	MisResultAction(GiveItem,6901,2,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,62 )	
	TriggerAction( 1, AddNextFlag, 1985, 10, 10 )
	RegCurTrigger( 19851 )
	
	
---------15¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001260 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001260")
	DefineMission( 6816, MISSCRIPT_MISSIONSCRIPT05_LUA_001260, 1986 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001261 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001261")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001261 )
	
	MisBeginCondition(LvCheck, ">", 14 )
	MisBeginCondition(HasRecord, 1985 )
	MisBeginCondition(NoRecord, 1986 )
	MisBeginCondition(NoMission, 1986 )
	MisBeginAction(AddMission, 1986 )

	MisBeginAction(AddTrigger, 19861, TE_KILL, 31, 10 )
	MisCancelAction(ClearMission, 1986)

	MisNeed(MIS_NEED_KILL, 31, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001262 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001262")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001262)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001263 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001263")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001263)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001264 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001264")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001264)
	
	MisResultCondition(NoRecord, 1986)	
	MisResultCondition(HasMission, 1986)
	MisResultCondition(HasFlag, 1986, 19 )				
	MisResultCondition(CheckBoatSkill )				----ÅÐ¶Ï´¬Ö»ÊìÁ·¶È
	MisResultAction(ClearMission, 1986)
	MisResultAction(SetRecord, 1986 )
	MisResultAction(GiveItem,6901,2,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,31 )	
	TriggerAction( 1, AddNextFlag, 1986, 10, 10 )
	RegCurTrigger( 19861 )
	
	
---------20¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001265 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001265")
	DefineMission( 6817, MISSCRIPT_MISSIONSCRIPT05_LUA_001265, 1987 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001266 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001266")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001266 )
	
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginCondition(HasRecord, 1986 )
	MisBeginCondition(NoRecord, 1987 )
	MisBeginCondition(NoMission, 1987 )
	MisBeginAction(AddMission, 1987 )

	MisBeginAction(AddTrigger, 19871, TE_KILL, 94, 10 )
	MisCancelAction(ClearMission, 1987)

	MisNeed(MIS_NEED_KILL, 94, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001267 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001267")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001267)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001268 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001268")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001268)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001269 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001269")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001269)
	
	MisResultCondition(NoRecord, 1987)	
	MisResultCondition(HasMission, 1987)
	MisResultCondition(HasFlag, 1987, 19 )				
	MisResultCondition(CheckBagJL)				----±³°ü¾«Áé
	MisResultAction(ClearMission, 1987)
	MisResultAction(SetRecord, 1987 )
	MisResultAction(GiveItem,6901,10,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,94 )	
	TriggerAction( 1, AddNextFlag, 1987, 10, 10 )
	RegCurTrigger( 19871 )
	

---------25¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001270 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001270")
	DefineMission( 6818, MISSCRIPT_MISSIONSCRIPT05_LUA_001270, 1988 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001271 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001271")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001271 )
	
	MisBeginCondition(LvCheck, ">", 24 )
	MisBeginCondition(HasRecord, 1987 )
	MisBeginCondition(NoRecord, 1988 )
	MisBeginCondition(NoMission, 1988 )
	MisBeginAction(AddMission, 1988 )

	MisBeginAction(AddTrigger, 19881, TE_KILL, 298, 10 )
	MisCancelAction(ClearMission, 1988)

	MisNeed(MIS_NEED_KILL, 298, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001272 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001272")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001272)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001273 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001273")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001273)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001274 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001274")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001274)
	
	MisResultCondition(NoRecord, 1988)	
	MisResultCondition(HasMission, 1988)
	MisResultCondition(HasFlag, 1988, 19 )				
	MisResultCondition(JL_lv3 )				----¾«ÁéµÈ¼¶
	MisResultCondition(HasItem,2588,1 )				
	MisResultAction(ClearMission, 1988)
	MisResultAction(SetRecord, 1988 )
	MisResultAction(GiveItem,6901,10,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,298 )	
	TriggerAction( 1, AddNextFlag, 1988, 10, 10 )
	RegCurTrigger( 19881 )
	
	
	
	
-----30¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001275 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001275")
	DefineMission( 6819, MISSCRIPT_MISSIONSCRIPT05_LUA_001275, 1989 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001276 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001276")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001276 )
	
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(HasRecord, 1988 )
	MisBeginCondition(NoRecord, 1989 )
	MisBeginCondition(NoMission, 1989 )
	MisBeginAction(AddMission, 1989 )

	MisBeginAction(AddTrigger, 19891, TE_KILL, 296, 10 )
	MisCancelAction(ClearMission, 1989)

	MisNeed(MIS_NEED_KILL, 296, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001277 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001277")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001277)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001278 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001278")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001278)
	
	MisResultCondition(AlwaysFailure )
	
	
------------30¼¶Ë®¾§¶Ò»» -----------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001275 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001275")
	DefineMission( 6827, MISSCRIPT_MISSIONSCRIPT05_LUA_001275,1989  , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001279 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001279")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001279)
	
	MisResultCondition(NoRecord, 1989)	
	MisResultCondition(HasMission, 1989)
	MisResultCondition(HasFlag, 1989, 19 )				
	MisResultCondition(CheckBaoShiLV2)			----¶þ¼¶±¦Ê¯ÅÐ¶Ï
	MisResultCondition(HasCleckUnite)			----ÊÂ¼þÅÐ¶Ï		
	MisResultAction(ClearMission, 1989)
	MisResultAction(SetRecord, 1989 )
	MisResultAction(GiveItem,6901,10,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,296 )	
	TriggerAction( 1, AddNextFlag, 1989, 10, 10 )
	RegCurTrigger( 19891 )
	

	
---------35¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001280 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001280")
	DefineMission( 6820, MISSCRIPT_MISSIONSCRIPT05_LUA_001280, 1990 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001281 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001281")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001281 )
	
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(HasRecord, 1989 )
	MisBeginCondition(NoRecord, 1990 )
	MisBeginCondition(NoMission, 1990 )
	MisBeginAction(AddMission, 1990 )

	MisBeginAction(AddTrigger, 19901, TE_KILL, 686, 5 )
	MisCancelAction(ClearMission, 1990)

	MisNeed(MIS_NEED_KILL, 686, 5, 10, 5)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001282 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001282")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001282)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001283 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001283")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001283)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001284 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001284")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001284)
	
	MisResultCondition(NoRecord, 1990)	
	MisResultCondition(HasMission, 1990)
	MisResultCondition(HasFlag, 1990, 14 )				
	MisResultAction(ClearMission, 1990)
	MisResultAction(SetRecord, 1990 )
	MisResultAction(GiveItem,6901,10,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,686 )	
	TriggerAction( 1, AddNextFlag, 1990, 10, 5 )
	RegCurTrigger( 19901 )	
---------40¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001285 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001285")
	DefineMission( 6821, MISSCRIPT_MISSIONSCRIPT05_LUA_001285, 1991 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001286 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001286")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001286 )
	
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(HasRecord, 1990 )
	MisBeginCondition(NoRecord, 1991 )
	MisBeginCondition(NoMission, 1991 )
	MisBeginAction(AddMission, 1991 )

	MisBeginAction(AddTrigger, 19911, TE_KILL, 204, 10 )
	MisCancelAction(ClearMission, 1991)

	MisNeed(MIS_NEED_KILL, 204, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001287 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001287")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001287)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001288 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001288")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001288)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001289 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001289")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001289)
	
	MisResultCondition(NoRecord, 1991)	
	MisResultCondition(HasMission, 1991)
	MisResultCondition(HasFlag, 1991, 19 )				
	MisResultCondition(CheckNoNewJob )				
	MisResultAction(ClearMission, 1991)
	MisResultAction(SetRecord, 1991 )
	MisResultAction(GiveItem,6901,10,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,204 )	
	TriggerAction( 1, AddNextFlag, 1991, 10, 10 )
	RegCurTrigger( 19911 )
	
---------45¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001290 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001290")
	DefineMission( 6822, MISSCRIPT_MISSIONSCRIPT05_LUA_001290, 1992 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001291 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001291")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001291 )
	
	MisBeginCondition(LvCheck, ">", 44 )
	MisBeginCondition(HasRecord, 1991 )
	MisBeginCondition(NoRecord, 1992 )
	MisBeginCondition(NoMission, 1992 )
	MisBeginAction(AddMission, 1992 )

	MisBeginAction(AddTrigger, 19921, TE_KILL, 695, 5 )
	MisCancelAction(ClearMission, 1992)

	MisNeed(MIS_NEED_KILL, 695, 5, 10, 5)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001292 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001292")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001292)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001293 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001293")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001293)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001294 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001294")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001294)
	
	MisResultCondition(NoRecord, 1992)	
	MisResultCondition(HasMission, 1992)
	MisResultCondition(HasFlag, 1992, 14 )				
	MisResultAction(ClearMission, 1992)
	MisResultAction(SetRecord, 1992 )
	MisResultAction(GiveItem,6901,20,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,695 )	
	TriggerAction( 1, AddNextFlag, 1992, 10, 5 )
	RegCurTrigger( 19921 )	
	
	
---------50¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001295 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001295")
	DefineMission( 6823, MISSCRIPT_MISSIONSCRIPT05_LUA_001295, 1993 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001296 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001296")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001296 )
	
	MisBeginCondition(LvCheck, ">", 49 )
	MisBeginCondition(HasRecord, 1992 )
	MisBeginCondition(NoRecord, 1993 )
	MisBeginCondition(NoMission, 1993 )
	MisBeginAction(AddMission, 1993 )

	MisBeginAction(AddTrigger, 19931, TE_KILL, 669, 5 )
	MisCancelAction(ClearMission, 1993)

	MisNeed(MIS_NEED_KILL, 669, 5, 10, 5)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001297 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001297")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001297)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001298 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001298")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001298)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001299 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001299")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001299)
	
	MisResultCondition(NoRecord, 1993)	
	MisResultCondition(HasMission, 1993)
	MisResultCondition(HasFlag, 1993, 14 )				
	MisResultAction(ClearMission, 1993)
	MisResultAction(SetRecord, 1993 )
	MisResultAction(GiveItem,6901,30,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultAction(GiveItem,2224,1,4)			----ÐÂÊ½¿á×°±¦Ïä
	MisResultBagNeed(2)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,669 )	
	TriggerAction( 1, AddNextFlag, 1993, 10, 5 )
	RegCurTrigger( 19931 )	
	
	
-------55¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001300 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001300")
	DefineMission( 6824, MISSCRIPT_MISSIONSCRIPT05_LUA_001300, 1994 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001301 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001301")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001301 )
	
	MisBeginCondition(LvCheck, ">", 54 )
	MisBeginCondition(HasRecord, 1993 )
	MisBeginCondition(NoRecord, 1994 )
	MisBeginCondition(NoMission, 1994 )
	MisBeginAction(AddMission, 1994 )

	MisBeginAction(AddTrigger, 19941, TE_KILL, 38, 10 )
	MisCancelAction(ClearMission, 1994)

	MisNeed(MIS_NEED_KILL, 38, 10, 10, 10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001302 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001302")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001302)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001303 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001303")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001303)
	
	MisResultCondition(AlwaysFailure )
	
	
	
------------Ë®¾§½±Àø£º55¼¶Ë®¾§¶Ò»» -----------
	MISSCRIPT_MISSIONSCRIPT05_LUA_001300 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001300")
	DefineMission( 6828, MISSCRIPT_MISSIONSCRIPT05_LUA_001300,1994  , COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001304 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001304")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001304)
	
	MisResultCondition(NoRecord, 1994)	
	MisResultCondition(HasMission, 1994)
	MisResultCondition(HasFlag, 1994, 19 )				
	MisResultCondition(HasCleckFusion )		-----ÅÐ¶ÏÈÛºÏ		
	MisResultAction(ClearMission, 1994)
	MisResultAction(SetRecord, 1994 )
	MisResultAction(GiveItem,6901,50,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,38 )	
	TriggerAction( 1, AddNextFlag, 1994, 10, 10 )
	RegCurTrigger( 19941 )	
	
	
---------60¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001305 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001305")
	DefineMission( 6825, MISSCRIPT_MISSIONSCRIPT05_LUA_001305, 1995 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001306 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001306")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001306 )
	
	MisBeginCondition(LvCheck, ">", 59 )
	MisBeginCondition(HasRecord, 1994 )
	MisBeginCondition(NoRecord, 1995 )
	MisBeginCondition(NoMission, 1995 )
	MisBeginAction(AddMission, 1995 )

	MisBeginAction(AddTrigger, 19951, TE_KILL, 725, 10 )
	MisCancelAction(ClearMission, 1995)

	MisNeed(MIS_NEED_KILL, 725,10,10,10)	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001307 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001307")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001307)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001308 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001308")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001308)
	

	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001309 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001309")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001309)
	
	MisResultCondition(NoRecord, 1995)	
	MisResultCondition(HasMission, 1995)
	MisResultCondition(HasFlag, 1995, 16 )				
	MisResultCondition(CheckEquipPurify)		-----ÅÐ¶ÏÎäÆ÷+3		
	MisResultAction(ClearMission, 1995)
	MisResultAction(SetRecord, 1995 )
	MisResultAction(GiveItem,6901,99,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,725 )	
	TriggerAction( 1, AddNextFlag, 1995, 10, 10 )
	RegCurTrigger( 19951 )	
	
---------70¼¶Ë®¾§¶Ò»»ÈÎÎñ----------------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001310 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001310")
	DefineMission( 6826, MISSCRIPT_MISSIONSCRIPT05_LUA_001310, 1996 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001311 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001311")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001311 )
	
	MisBeginCondition(LvCheck, ">", 69 )
	MisBeginCondition(HasRecord, 1995 )
	MisBeginCondition(NoRecord, 1996 )
	MisBeginCondition(NoMission, 1996 )
	MisBeginAction(AddMission, 1996 )
	MisCancelAction(ClearMission, 1996)
	MisBeginAction(AddTrigger, 19961, TE_GETITEM, 3425, 30 )
	MisBeginAction(AddTrigger, 19962, TE_GETITEM, 3428, 30 )
	MisBeginAction(AddTrigger, 19963, TE_GETITEM, 3429, 30 )
	MisBeginAction(AddTrigger, 19964, TE_GETITEM, 3455, 30 )
	MisBeginAction(AddTrigger, 19965, TE_GETITEM, 3424, 1 )
	MisBeginAction(AddTrigger, 19966, TE_GETITEM, 6902, 1 )

	MISSCRIPT_MISSIONSCRIPT05_LUA_001312 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001312")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001312)
	MisNeed(MIS_NEED_ITEM, 3425, 30, 30, 30)
	MisNeed(MIS_NEED_ITEM, 3428, 30, 40, 30)
	MisNeed(MIS_NEED_ITEM, 3429, 30, 70, 30)
	MisNeed(MIS_NEED_ITEM, 3455, 30, 100, 30)
	MisNeed(MIS_NEED_ITEM, 3424, 1, 110, 1)
	MisNeed(MIS_NEED_ITEM, 6902, 1, 120, 1)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001313 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001313")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001313)
	
	MisResultCondition(NoRecord, 1996)	
	MisResultCondition(HasMission, 1996)
	MisResultCondition(HasItem, 3425, 30)
	MisResultCondition(HasItem, 3428, 30)
	MisResultCondition(HasItem, 3429, 30)
	MisResultCondition(HasItem, 3455, 30)
	MisResultCondition(HasItem, 3424, 1)
	MisResultCondition(HasItem, 6902, 1)
	MisResultAction(TakeItem, 3425, 30)
	MisResultAction(TakeItem, 3428, 30)
	MisResultAction(TakeItem, 3429, 30)
	MisResultAction(TakeItem, 3455, 30)
	MisResultAction(TakeItem, 3424, 1 )
	MisResultAction(TakeItem, 6902, 1 )
	MisResultAction(ClearMission, 1996)
	MisResultAction(SetRecord, 1996 )
	MisResultAction(GiveItem,6903,1,4)			----Ë®¾§¶Ò»»½±Àø
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3425 )	
	TriggerAction( 1, AddNextFlag, 1996,30, 30 )
	RegCurTrigger( 19961 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3428 )	
	TriggerAction( 1, AddNextFlag, 1996,30, 30 )
	RegCurTrigger( 19962 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3429 )	
	TriggerAction( 1, AddNextFlag, 1996,30, 30 )
	RegCurTrigger( 19963 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3455 )	
	TriggerAction( 1, AddNextFlag, 1996,30, 30 )
	RegCurTrigger( 19964 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3424 )	
	TriggerAction( 1, AddNextFlag, 1996,1, 1 )
	RegCurTrigger( 19965 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 6902 )	
	TriggerAction( 1, AddNextFlag, 1996,1, 1 )
	RegCurTrigger( 19966 )
	
------ÌôÕ½±ù´¨		
	MISSCRIPT_MISSIONSCRIPT05_LUA_001314 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001314")
	DefineMission(6831,MISSCRIPT_MISSIONSCRIPT05_LUA_001314,1999)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001315 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001315")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001315 )
	MisBeginCondition(LvCheck, ">", 34 )
	MisBeginCondition(NoRecord, 1999)
	MisBeginCondition(NoMission, 1999)
	MisBeginAction(AddMission, 1999)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001316 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001316")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001316)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001317 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001317")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001317)
------ÌôÕ½±ù´¨	
	MisResultCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT05_LUA_001318 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001318")
	DefineMission( 6832, MISSCRIPT_MISSIONSCRIPT05_LUA_001318, 1999 )
	MisBeginCondition( AlwaysFailure )	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001319 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001319")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001319)
	
	MisResultCondition(HasMission, 1999)
	MisResultAction(ClearMission, 1999)
	MisResultAction(SetRecord, 1999 )
	MisResultAction(AddExp, 27000, 27000)

-----ÌôÕ½É­ÁÖ----------	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001320 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001320")
	DefineMission(6833,MISSCRIPT_MISSIONSCRIPT05_LUA_001320,2003)
	MISSCRIPT_MISSIONSCRIPT05_LUA_001321 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001321")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT05_LUA_001321 )
	MisBeginCondition(NoRecord, 2003)
	MisBeginCondition(LvCheck, ">", 29 )
	MisBeginCondition(NoMission, 2003)
	MisBeginAction(AddMission, 2003)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001322 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001322")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT05_LUA_001322)
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001317 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001317")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001317)
	
	MisResultCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001323 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001323")
	DefineMission( 6834, MISSCRIPT_MISSIONSCRIPT05_LUA_001323, 2003 )
	MisBeginCondition( AlwaysFailure )	
	
	MISSCRIPT_MISSIONSCRIPT05_LUA_001319 = GetResString("MISSCRIPT_MISSIONSCRIPT05_LUA_001319")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT05_LUA_001319)
	
	MisResultCondition(HasMission, 2003)
	MisResultAction(ClearMission, 2003)
	MisResultAction(SetRecord, 2003 )
	MisResultAction(AddExp, 30000, 30000)
end

AreaMission001()
