--------------------------------------------------------------------------
--									--
--									--
--				MissionScript01.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "------------------------------------" )
print( "Loading NPC Files:" )
print( "------------------------------------" )
print( "Loading MissionScript01.lua" )


jp= JumpPage
amp=AutoMissionPage
ct=CloseTalk
am=AddMission
MissionCheck = HasFlag
mc=MissionCheck

----------------------------------------------------------
--							--
--							--
--		白银城[药草商人——帝姆]			--
--							--
--		224575,277025				--
----------------------------------------------------------
InitQuse()
function RobinMission003()

-----------------------------------药品店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000001")
	DefineMission( 707, MISSCRIPT_MISSIONSCRIPT01_LUA_000001, 703, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000002")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000002)
	MisResultCondition(NoRecord, 703)
	MisResultCondition(HasMission, 703)
	MisResultCondition(NoFlag, 703, 10)
	MisResultCondition(HasFlag, 703, 1)
	MisResultCondition(HasItem, 3952, 1)
	MisResultAction(TakeItem, 3952, 1)
	MisResultAction(SetFlag, 703, 10)
	MisResultAction(GiveItem, 1847, 10, 4)
	MisResultBagNeed(1)

--------------------------叶子收集
	MISSCRIPT_MISSIONSCRIPT01_LUA_000003 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000003")
	DefineMission( 733, MISSCRIPT_MISSIONSCRIPT01_LUA_000003, 721 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000004")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000004 )
	MisBeginCondition(NoMission, 721)
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(LvCheck, "<", 7 )
	MisBeginAction(AddMission, 721)
	MisBeginAction(SetFlag, 721, 1)
	MisBeginAction(AddTrigger, 7211, TE_GETITEM, 1573, 5 )
	MisBeginAction(AddTrigger, 7212, TE_GETITEM, 1574, 3 )
	MisCancelAction(ClearMission, 721)

	MisNeed(MIS_NEED_ITEM, 1573, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 1574, 3, 20, 3)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000005")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000005)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000006")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000006)
	MisResultCondition(HasMission, 721)
	MisResultCondition(HasItem, 1573, 5 )
	MisResultCondition(HasItem, 1574, 3 )
	MisResultAction(TakeItem, 1573, 5 )
	MisResultAction(TakeItem, 1574, 3 )
	MisResultAction(AddExp, 40, 70)
	MisResultAction(ClearMission, 721)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1573)	
	TriggerAction( 1, AddNextFlag, 721, 10, 5 )
	RegCurTrigger( 7211 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1574)	
	TriggerAction( 1, AddNextFlag, 721, 20, 3 )
	RegCurTrigger( 7212 )

--------------------------灵感配方
	MISSCRIPT_MISSIONSCRIPT01_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000007")
	DefineMission( 738, MISSCRIPT_MISSIONSCRIPT01_LUA_000007, 726 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000008 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000008")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000008 )
	MisBeginCondition(NoMission, 726)
	MisBeginCondition(LvCheck, ">", 120 )
	MisBeginCondition(NoRecord , 726 )
	MisBeginAction(AddMission, 726)
	MisBeginAction(SetFlag, 726, 1)
	MisBeginAction(AddTrigger, 7261, TE_GETITEM, 1777, 2 )
	MisBeginAction(AddTrigger, 7262, TE_GETITEM, 1579, 2 )
	MisBeginAction(AddTrigger, 7263, TE_GETITEM, 1705, 2 )
	MisCancelAction(ClearMission, 726)

	MisNeed(MIS_NEED_ITEM, 1777, 2, 10, 2)
	MisNeed(MIS_NEED_ITEM, 1579, 2, 20, 2)
	MisNeed(MIS_NEED_ITEM, 1705, 2, 30, 2)

	MisPrize(MIS_PRIZE_MONEY, 200, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000009")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000009)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000010 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000010")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000010)
	MisResultCondition(HasMission, 726)
	MisResultCondition(HasItem, 1777, 2 )
	MisResultCondition(HasItem, 1579, 2 )
	MisResultCondition(HasItem, 1705, 2 )
	MisResultAction(SetRecord , 726 )	
	MisResultAction(TakeItem, 1777, 2 )
	MisResultAction(TakeItem, 1579, 2 )
	MisResultAction(TakeItem, 1705, 2 )
	MisResultAction(AddExp, 70, 95)
	MisResultAction(ClearMission, 726)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1777)	
	TriggerAction( 1, AddNextFlag, 726, 10, 2 )
	RegCurTrigger( 7261 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1579)	
	TriggerAction( 1, AddNextFlag, 726, 20, 2 )
	RegCurTrigger( 7262 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1705)	
	TriggerAction( 1, AddNextFlag, 726, 30, 2 )
	RegCurTrigger( 7263 )

--------------------------蘑菇蘑菇
	MISSCRIPT_MISSIONSCRIPT01_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000011")
	DefineMission( 739, MISSCRIPT_MISSIONSCRIPT01_LUA_000011, 727 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000012")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000012 )
	MisBeginCondition(NoMission, 727)
	MisBeginCondition(LvCheck, ">", 7 )
	MisBeginCondition(LvCheck, "<", 9 )
	MisBeginAction(AddMission, 727)
	MisBeginAction(SetFlag, 727, 1)
	MisBeginAction(AddTrigger, 7271, TE_GETITEM, 3118, 4 )
	MisBeginAction(AddTrigger, 7272, TE_GETITEM, 1725, 8 )
	MisCancelAction(ClearMission, 727)

	MisNeed(MIS_NEED_ITEM, 3118, 4, 10, 4)
	MisNeed(MIS_NEED_ITEM, 1725, 8, 20, 8)

	MisPrize(MIS_PRIZE_MONEY, 300, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000013")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000013)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000014")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000014)
	MisResultCondition(HasMission, 727)
	MisResultCondition(HasItem, 3118, 4 )
	MisResultCondition(HasItem, 1725, 8 )
	MisResultAction(TakeItem, 3118, 4 )
	MisResultAction(TakeItem, 1725, 8 )
	MisResultAction(AddExp, 95, 125)
	MisResultAction(ClearMission, 727)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 3118)	
	TriggerAction( 1, AddNextFlag, 727, 10, 4 )
	RegCurTrigger( 7271 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1725)	
	TriggerAction( 1, AddNextFlag, 727, 20, 8 )
	RegCurTrigger( 7272 )


end
RobinMission003() --定义任务后结束时必须调用该函数


----------------------------------------------------------
--							--
--							--
--		白银城[冒险者导师·小山车]				--
--							--
--		219350,273050				--
----------------------------------------------------------
function RobinMission004()

-----------------------------------生存指南
	MISSCRIPT_MISSIONSCRIPT01_LUA_000015 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000015")
	DefineMission( 748, MISSCRIPT_MISSIONSCRIPT01_LUA_000015, 736 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000016 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000016")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000016 )
	MisBeginCondition(NoMission, 736)
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(CheckConvertProfession, MIS_RISKER )
	MisBeginAction(AddMission, 736)
	MisBeginAction(SetFlag, 736, 1)
	MisBeginAction(AddTrigger, 7361, TE_KILL, 104, 2 )
	MisBeginAction(AddTrigger, 7362, TE_KILL, 39, 10 )
	MisBeginAction(AddTrigger, 7363, TE_GETITEM, 1844, 5 )
	MisCancelAction(ClearMission, 736)
	
	MisNeed(MIS_NEED_KILL, 104, 5, 10, 5)
	MisNeed(MIS_NEED_KILL, 39, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 1844, 5, 30, 5)

	MisPrize(MIS_PRIZE_ITEM, 3962, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000017)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000018")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000018)
	MisResultCondition(HasMission, 736)
	MisResultCondition(HasFlag, 736, 14 )
	MisResultCondition(HasFlag, 736, 29 )
	MisResultCondition(HasItem, 1844, 5 )
	MisResultAction(TakeItem, 1844, 5)
	MisResultAction(ClearMission, 736)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 104 )	
	TriggerAction( 1, AddNextFlag, 736, 10, 5 )
	RegCurTrigger( 7361 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 39 )	
	TriggerAction( 1, AddNextFlag, 736, 20, 10 )
	RegCurTrigger( 7362 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1844 )	
	TriggerAction( 1, AddNextFlag, 736, 30, 5 )
	RegCurTrigger( 7363 )


-----------------------------------航海士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000019")
	DefineMission( 758, MISSCRIPT_MISSIONSCRIPT01_LUA_000019, 742 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000020 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000020")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000020 )
	MisBeginCondition(NoRecord, 742)
	MisBeginCondition(NoMission, 742)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(CheckZsExp)
	MisBeginCondition(PfEqual, 4 )
	MisBeginCondition(CheckConvertProfession, MIS_VOYAGE )
	MisBeginAction(AddMission, 742)
	MisCancelAction(ClearMission, 742)

	-- MisNeed(MIS_NEED_DESP, "找布尔兹(3254,3278)聊聊")
	-- MisNeed(MIS_NEED_DESP, "找赛瑟尼(2279,1112)聊聊")
	-- MisNeed(MIS_NEED_DESP, "找肥德拉德(3595,739)聊聊")
	MISSCRIPT_MISSIONSCRIPT01_LUA_000021 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000021")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000021)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000022")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000022)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000023")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000023)
	MisResultCondition(HasMission, 742)
	-- MisResultCondition(HasFlag, 742, 20 )
	-- MisResultCondition(HasFlag, 742, 30 )
	-- MisResultCondition(HasFlag, 742, 40 )
	MisResultCondition(HasFlag, 742, 50 )
	MisResultAction(ClearMission, 742)
	MisResultAction(SetRecord, 742)
	MisResultAction(SetProfession, 16)
	MisResultAction(GiveItem, 7579, 1, 4 )
	MisResultAction(Starteffect , 944)



---------------------------------航海士转职任务
	-- DefineMission( 760, "航海士转职任务", 742, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("<t>呵呵,你想当航海士啊,那要努力哦,这个职业还是很有前途的！")
	-- MisResultCondition(NoRecord, 742)
	-- MisResultCondition(HasMission, 742)
	-- MisResultCondition(NoFlag, 742, 20)
	-- MisResultAction(SetFlag, 742, 20)


---------------------------------航海士转职任务
	-- DefineMission( 761, "航海士转职任务", 742, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("<t>哼,冒险者导师·小山车这家伙,现在才想起我来啊！")
	-- MisResultCondition(NoRecord, 742)
	-- MisResultCondition(HasMission, 742)
	-- MisResultCondition(NoFlag, 742, 30)
	-- MisResultAction(SetFlag, 742, 30)

---------------------------------航海士转职任务
	-- DefineMission( 762, "航海士转职任务", 742, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("<t>哦,新航海士啊,欢迎！<n><t>对了,看到冒险者导师·小山车别忘了跟他说,他借了我50000金,都5年了,该还了。")
	-- MisResultCondition(NoRecord, 742)
	-- MisResultCondition(HasMission, 742)
	-- MisResultCondition(NoFlag, 742, 40)
	-- MisResultAction(SetFlag, 742, 40)

-----------------------------------航海士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000019")
	DefineMission( 763, MISSCRIPT_MISSIONSCRIPT01_LUA_000019, 742, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000024 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000024")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000024)
	MisResultCondition(NoRecord, 742)
	MisResultCondition(HasMission, 742)
	MisResultCondition(NoFlag, 742, 50)
	MisResultAction(SetFlag, 742, 50)

end
RobinMission004()


----------------------------------------------------------
--							--
--							--
--		白银城[小金金]				--
--							--
--		224575,277025				--
----------------------------------------------------------
function RobinMission007()

-----------------------------------铁匠的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000025")
	DefineMission( 703, MISSCRIPT_MISSIONSCRIPT01_LUA_000025, 701, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000026 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000026")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000026)
	MisResultCondition(NoRecord, 701)
	MisResultCondition(HasMission, 701)
	MisResultCondition(NoFlag, 701, 10)
	MisResultCondition(HasItem, 3950, 1)
	MisResultAction(TakeItem, 3950, 1)
	MisResultAction(SetFlag, 701, 10)
	MisResultBagNeed(1)
	

end
RobinMission007()


----------------------------------------------------------
--							--
--							--
--		沙岚城[药师导师·甘地维拉]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission017()

-----------------------------------虔诚祷文
	MISSCRIPT_MISSIONSCRIPT01_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000027")
	DefineMission( 719, MISSCRIPT_MISSIONSCRIPT01_LUA_000027, 711 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000028")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000028 )
	MisBeginCondition(NoMission, 711)
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(CheckConvertProfession, MIS_DOCTOR )
	MisBeginAction(AddMission, 711)
	MisBeginAction(SetFlag, 711, 1)
	MisBeginAction(AddTrigger, 7111, TE_GETITEM, 3122, 1 )
	MisBeginAction(AddTrigger, 7112, TE_GETITEM, 3129, 2 )
	MisBeginAction(AddTrigger, 7113, TE_KILL, 247, 8 )
	MisCancelAction(ClearMission, 711)

	MisNeed(MIS_NEED_ITEM, 3122, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 3129, 2, 20, 2)
	MisNeed(MIS_NEED_KILL, 247, 8, 30, 8)

	MisPrize(MIS_PRIZE_ITEM, 3954, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000029 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000029")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000029)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000030 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000030")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000030)
	MisResultCondition(HasMission, 711)
	MisResultCondition(HasItem, 3122, 1 )
	MisResultCondition(HasItem, 3129, 2 )
	MisResultCondition(HasFlag, 711, 39 )
	MisResultAction(TakeItem, 3122, 1 )
	MisResultAction(TakeItem, 3129, 2 )
	MisResultAction(ClearMission, 711)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3122 )	
	TriggerAction( 1, AddNextFlag, 711, 10, 1 )
	RegCurTrigger( 7111 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 3129 )	
	TriggerAction( 1, AddNextFlag, 711, 20, 2 )
	RegCurTrigger( 7112 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 247 )	
	TriggerAction( 1, AddNextFlag, 711, 30, 8 )
	RegCurTrigger( 7113 )

-----------------------------------圣职者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000031")
	DefineMission( 751, MISSCRIPT_MISSIONSCRIPT01_LUA_000031, 739 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000032 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000032")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000032 )
	MisBeginCondition(NoRecord, 739)
	MisBeginCondition(NoMission, 740)
	MisBeginCondition(NoMission, 739)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(PfEqual, 5 )
	MisBeginCondition(CheckZsExp)
	MisBeginCondition(CheckConvertProfession, MIS_CLERGY )
	MisBeginAction(AddMission, 739)
	MisCancelAction(ClearMission, 739)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000033 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000033")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000033)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000034 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000034")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000034)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000035 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000035")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000035)
	MisResultCondition(HasMission, 739)
	MisResultCondition(HasFlag, 739, 10 )
	-- MisResultCondition(HasFlag, 739, 20 )
	MisResultAction(ClearMission, 739)
	MisResultAction(SetRecord, 739)
	MisResultAction(SetProfession, 13)
	MisResultAction(Starteffect , 944)
	
-----------------------------------圣职者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000031")
	DefineMission( 752, MISSCRIPT_MISSIONSCRIPT01_LUA_000031, 739, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000036 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000036")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000036)
	MisResultCondition(NoRecord, 739)
	MisResultCondition(HasMission, 739)
	MisResultCondition(NoFlag, 739, 10)
	MisResultCondition(HasItem, 3122, 6)
	MisResultAction(TakeItem, 3122, 6)
	MisResultAction(SetFlag, 739, 10)

---------------------------------圣职者转职任务
	-- DefineMission( 753, "圣职者转职任务", 739, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("嗯～是大神官派你过来的吧,我这里正好缺少这些药材,你来得真及时,我会向神官提起这件事的")
	-- MisResultCondition(NoRecord, 739)
	-- MisResultCondition(HasMission, 739)
	-- MisResultCondition(NoFlag, 739, 20)
	-- MisResultCondition(HasItem, 3122, 3)
	-- MisResultCondition(HasItem, 3146, 2)
	-- MisResultCondition(HasItem, 3130, 1)
	-- MisResultAction(TakeItem, 3122, 3)
	-- MisResultAction(TakeItem, 3146, 2)
	-- MisResultAction(TakeItem, 3130, 1)
	-- MisResultAction(SetFlag, 739, 20)



-----------------------------------封印师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000037")
	DefineMission( 755, MISSCRIPT_MISSIONSCRIPT01_LUA_000037, 740 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000038")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000038 )
	MisBeginCondition(NoRecord, 740)
	MisBeginCondition(NoMission, 740)
	MisBeginCondition(NoMission, 739)
	MisBeginCondition(CheckZsExp)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(PfEqual, 5 )
	MisBeginCondition(CheckConvertProfession, MIS_SEALER )
	MisBeginAction(AddMission, 740)
	MisCancelAction(ClearMission, 740)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000039 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000039")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000039)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000040 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000040")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000040)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000041 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000041")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000041)
	MisResultCondition(HasMission, 740)
	MisResultCondition(HasFlag, 740, 10 )
	MisResultAction(ClearMission, 740)
	MisResultAction(SetRecord, 740)
	MisResultAction(SetProfession, 14)
	MisResultAction(GiveItem, 7577, 1, 4 )
	MisResultAction(Starteffect , 944)

-----------------------------------封印师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000037")
	DefineMission( 756, MISSCRIPT_MISSIONSCRIPT01_LUA_000037, 740, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000042")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000042)
	MisResultCondition(NoRecord, 740)
	MisResultCondition(HasMission, 740)
	MisResultCondition(NoFlag, 740, 10)
	MisResultCondition(HasItem, 4471, 3)
	MisResultAction(TakeItem, 4471, 3)
	MisResultAction(SetFlag, 740, 10)


end
RobinMission017()

----------------------------------------------------------
--							--
--							--
--		沙岚城[铁匠·铜铜鼓]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission022()

---------------------------------------新手任务送小刀
	MISSCRIPT_MISSIONSCRIPT01_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000025")
	DefineMission( 713, MISSCRIPT_MISSIONSCRIPT01_LUA_000025, 707, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000043 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000043")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000043)
	MisResultCondition(NoRecord, 707)
	MisResultCondition(HasMission, 707)
	MisResultCondition(NoFlag, 707, 10)
	MisResultCondition(HasItem, 3956, 1)
	MisResultAction(TakeItem, 3956, 1)
	MisResultAction(SetFlag, 707, 10)
	MisResultBagNeed(1)

end
RobinMission022()

----------------------------------------------------------
--							--
--							--
--		白银城[新手指导·瑟安]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission024()

-----------------------------------新人报道
	MISSCRIPT_EUDEMONSCRIPT_LUA_000001 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000001")
	DefineMission( 701, MISSCRIPT_EUDEMONSCRIPT_LUA_000001, 1, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000044 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000044")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000044)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000045")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000045)
	MisResultCondition(NoRecord, 1)
	MisResultCondition(HasMission, 1)
	--MisResultCondition(HasFlag, 700, 10)
	--MisResultCondition(HasFlag, 700, 20)
	MisResultAction(ClearMission, 1)
	MisResultAction(SetRecord, 1)
	MisResultAction(AddExp, 6, 6)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000046")
	MisResultAction(GiveNpcMission,702,MISSCRIPT_MISSIONSCRIPT01_LUA_000046,2)

-----------------------------------铁匠的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000025")
	DefineMission( 702, MISSCRIPT_MISSIONSCRIPT01_LUA_000025, 701 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000047")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000047 )
	MisBeginCondition(HasRecord, 1)
	MisBeginCondition(NoRecord, 701)
	MisBeginCondition(NoMission, 701)
	MisBeginAction(AddMission, 701)
	MisBeginAction(SetFlag, 701, 1)
	MisBeginAction(GiveItem, 3950, 1, 4)
	MisCancelAction(ClearMission, 701 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000048 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000048")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000048)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000049 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000049")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000049)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000050")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000050)
	MisResultCondition(NoRecord, 701)
	MisResultCondition(HasMission, 701)
	MisResultCondition(HasFlag, 701, 10)
	MisResultAction(ClearMission, 701)
	MisResultAction(SetRecord, 701)
	MisResultAction(AddExp, 9, 9 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000046")
	MisResultAction(GiveNpcMission,704,MISSCRIPT_MISSIONSCRIPT01_LUA_000046,3)

-----------------------------------新人过三关      XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	MISSCRIPT_MISSIONSCRIPT01_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000051")
	DefineMission( 704, MISSCRIPT_MISSIONSCRIPT01_LUA_000051, 702 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000052 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000052")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000052 )
	MisBeginCondition(HasRecord, 701)
	MisBeginCondition(NoRecord, 702)
	MisBeginCondition(NoMission, 702)
	MisBeginAction(AddMission, 702)
	MisBeginAction(SetFlag, 702, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	--MisCancelAction(ClearMission, 702 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000053 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000053")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000053)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000054 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000054")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000054)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000055")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000055)
	MisResultCondition(NoRecord, 702)
	MisResultCondition(HasMission, 702)
	MisResultCondition(HasFlag, 702, 10)
	MisResultAction(ClearMission, 702)
	MisResultAction(SetRecord, 702)
	MisResultAction(AddExp, 21, 21 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000046")
	MisResultAction(GiveNpcMission,706,MISSCRIPT_MISSIONSCRIPT01_LUA_000046,4)

-----------------------------------药品店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000001")
	DefineMission( 706, MISSCRIPT_MISSIONSCRIPT01_LUA_000001, 703 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000056 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000056 )
	MisBeginCondition(HasRecord, 702)
	MisBeginCondition(NoRecord, 703)
	MisBeginCondition(NoMission, 703)
	MisBeginAction(AddMission, 703)
	MisBeginAction(SetFlag, 703, 1)
	MisBeginAction(GiveItem, 3952, 1, 4)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	--MisCancelAction(ClearMission, 703 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000057")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000057)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000058 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000058")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000058)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000059 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000059")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000059)
	MisResultCondition(NoRecord, 703)
	MisResultCondition(HasMission, 703)
	MisResultCondition(HasFlag, 703, 10)
	MisResultAction(ClearMission, 703)
	MisResultAction(SetRecord, 703)
	MisResultAction(AddExp, 66, 66 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000046")
	MisResultAction(GiveNpcMission,708,MISSCRIPT_MISSIONSCRIPT01_LUA_000046,5)


-----------------------------------战斗考核
	MISSCRIPT_MISSIONSCRIPT01_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000060")
	DefineMission( 708, MISSCRIPT_MISSIONSCRIPT01_LUA_000060, 704 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000061 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000061")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000061 )
	MisBeginCondition(HasRecord, 703)
	MisBeginCondition(NoRecord, 704)
	MisBeginCondition(NoMission, 704)
	MisBeginCondition(LvCheck, ">", 4 )
	--MisBeginCondition(LvCheck, "<", 10 )
	MisBeginAction(AddMission, 704)
	MisBeginAction(SetFlag, 704, 1)
	MisBeginAction(AddTrigger, 7041, TE_GETITEM, 1620, 1 )
	MisBeginAction(AddTrigger, 7042, TE_KILL, 103, 5 )
	MisCancelAction(ClearMission, 704)

	MisNeed(MIS_NEED_ITEM, 1620, 1, 10, 1)
	MisNeed(MIS_NEED_KILL, 103, 5, 20, 5)
	
	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000062 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000062")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000062)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000063 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000063")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000063)
	MisResultCondition(NoRecord, 704)
	MisResultCondition(HasMission, 704)
	MisResultCondition(HasItem, 1620, 1)
	MisResultCondition(HasFlag, 704, 24)
	MisResultAction(TakeItem, 1620, 1)
	MisResultAction(ClearMission, 704)
	MisResultAction(SetRecord, 704)
	MisResultAction(AddExp, 75, 75 )
	MisResultAction(GiveNpcMission1,51)	  --送信给马尔斯下线改为送信给帝姆

	InitTrigger()
	TriggerCondition( 1, IsItem, 1620 )	
	TriggerAction( 1, AddNextFlag, 704, 10, 1 )
	RegCurTrigger( 7041 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 103 )	
	TriggerAction( 1, AddNextFlag, 704, 20, 5 )
	RegCurTrigger( 7042 )

	
end
RobinMission024()

----------------------------------------------------------
--							--
--							--
--		白银城[服装店主·尼萨婆婆]			--
--							--
--		239185,277025				--
----------------------------------------------------------
--function RobinMission025()

---------------------------------服装店的问候
	-- DefineMission( 705, "服装店的问候", 702, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("<t>以前没见过你呢,有趣的孩子。<n><t>欢迎到白银城来。<n><t>我是服装店主尼萨婆婆。<n><t>既然瑟安给了你推荐信,我就专门为你定制一副新手手套吧,以后也要常来噢,可以和我聊聊天。<n><t>现在你要在回到<j新手指导·瑟安(2223,2785)>那里去,她应该还会给你介绍其他人。(尼萨婆婆送了你一个“新手手套”,你可以从物品背包中将其装备到手套部位。)")
	-- MisResultCondition(NoRecord, 702)
	-- MisResultCondition(HasMission, 702)
	-- MisResultCondition(NoFlag, 702, 10)
	-- MisResultCondition(HasFlag, 702, 1)
	-- MisResultCondition(HasItem, 3951, 1)
	-- MisResultAction(TakeItem, 3951, 1)
	-- MisResultAction(SetFlag, 702, 10)
	-- MisResultAction(GiveItem, 465, 1, 4)
	-- MisResultBagNeed(1)
	
--end
--RobinMission025()

----------------------------------------------------------
--							--
--							--
--		白银城[剑士导师·比特]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission026()

-----------------------------------勇气证书
	MISSCRIPT_MISSIONSCRIPT01_LUA_000064 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000064")
	DefineMission( 709, MISSCRIPT_MISSIONSCRIPT01_LUA_000064, 705 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000065 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000065")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000065 )
	MisBeginCondition(NoMission, 705)
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(CheckConvertProfession, MIS_FENCER )
	MisBeginAction(AddMission, 705)
	MisBeginAction(SetFlag, 705, 1)
	MisBeginAction(AddTrigger, 7051, TE_KILL, 237, 8 )
	MisBeginAction(AddTrigger, 7052, TE_KILL, 213, 8 )
	MisBeginAction(AddTrigger, 7053, TE_KILL, 125, 8 )
	MisCancelAction(ClearMission, 705)
	
	MisNeed(MIS_NEED_KILL, 237, 8, 10, 8)
	MisNeed(MIS_NEED_KILL, 213, 8, 20, 8)
	MisNeed(MIS_NEED_KILL, 125, 8, 30, 8)

	MisPrize(MIS_PRIZE_ITEM, 3953, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000066 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000066")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000066)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000067 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000067")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000067)
	MisResultCondition(HasMission, 705)
	MisResultCondition(HasFlag, 705, 19 )
	MisResultCondition(HasFlag, 705, 29 )
	MisResultCondition(HasFlag, 705, 39 )
	MisResultAction(ClearMission, 705)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 237 )	
	TriggerAction( 1, AddNextFlag, 705, 10, 8 )
	RegCurTrigger( 7051 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 213 )	
	TriggerAction( 1, AddNextFlag, 705, 20, 8 )
	RegCurTrigger( 7052 )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 125 )	
	TriggerAction( 1, AddNextFlag, 705, 30, 8 )
	RegCurTrigger( 7053 )
	

-----------------------------------双剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000068 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000068")
	DefineMission( 749, MISSCRIPT_MISSIONSCRIPT01_LUA_000068, 737 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000069 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000069")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000069 )
	MisBeginCondition(NoRecord, 737)
	MisBeginCondition(NoMission, 737)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(PfEqual, 1 )
	MisBeginCondition(TurnToJob, 2 )
	MisBeginCondition(CheckZsExp)
	MisBeginAction(AddMission, 737)
	MisBeginAction(AddTrigger, 7371, TE_GETITEM, 4474, 5 )
	MisCancelAction(ClearMission, 737)
	
	MisNeed(MIS_NEED_ITEM, 4474, 5, 20, 5)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000070 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000070")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000070)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000071 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000071")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000071)
	MisResultCondition(HasMission, 737)
	MisResultCondition(HasItem, 4474, 5 )
	MisResultAction(TakeItem, 4474, 5)
	MisResultAction(ClearMission, 737)
	MisResultAction(SetRecord, 737)
	MisResultAction(SetProfession, 9)
	MisResultAction(GiveItem, 7575, 2, 4 )
	MisResultAction(Starteffect , 944)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4474 )	
	TriggerAction( 1, AddNextFlag, 737, 20, 5 )
	RegCurTrigger( 7371 )

-----------------------------------巨剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000072")
	DefineMission( 750, MISSCRIPT_MISSIONSCRIPT01_LUA_000072, 738 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000073 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000073")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000073 )
	MisBeginCondition(NoRecord, 738)
	MisBeginCondition(NoMission, 738)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(PfEqual, 1 )
	MisBeginCondition(CheckZsExp)
	MisBeginCondition(CheckConvertProfession, MIS_LARGE_FENCER )
	MisBeginAction(AddMission, 738)
	MisBeginAction(AddTrigger, 7381, TE_GETITEM, 4368, 5 )
	MisCancelAction(ClearMission, 738)

	MisNeed(MIS_NEED_ITEM, 4368, 5, 20, 5)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000074 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000074")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000074)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000075 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000075")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000075)
	MisResultCondition(HasMission, 738)
	MisResultCondition(HasItem, 4368, 5 )
	MisResultAction(TakeItem, 4368, 5)
	MisResultAction(ClearMission, 738)
	MisResultAction(SetRecord, 738)
	MisResultAction(SetProfession, 8)
	MisResultAction(GiveItem, 7574, 1, 4 )
	MisResultAction(Starteffect , 944)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4368 )	
	TriggerAction( 1, AddNextFlag, 738, 20, 5 )
	RegCurTrigger( 7381 )

end
RobinMission026()

----------------------------------------------------------
--							--
--		沙岚城[新手指导·拉丝碧]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission027()

-----------------------------------新人报道
	MISSCRIPT_EUDEMONSCRIPT_LUA_000001 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000001")
	DefineMission( 711, MISSCRIPT_EUDEMONSCRIPT_LUA_000001, 2, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000076 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000076")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000076)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000077 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000077")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000077)
	MisResultCondition(NoRecord, 2)
	MisResultCondition(HasMission, 2)
	--MisResultCondition(HasFlag, 706, 10)
	--MisResultCondition(HasFlag, 706, 20)
	MisResultAction(ClearMission, 2)
	MisResultAction(SetRecord, 2)
	MisResultAction(AddExp, 6, 6)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000078")
	MisResultAction(GiveNpcMission, 712, MISSCRIPT_MISSIONSCRIPT01_LUA_000078, 2)

-----------------------------------铁匠的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000025")
	DefineMission( 712, MISSCRIPT_MISSIONSCRIPT01_LUA_000025, 707 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000079 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000079")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000079 )
	MisBeginCondition(HasRecord, 2)
	MisBeginCondition(NoRecord, 707)
	MisBeginCondition(NoMission, 707)
	MisBeginAction(AddMission, 707)
	MisBeginAction(SetFlag, 707, 1)
	MisBeginAction(GiveItem, 3956, 1, 4)
	MisCancelAction(ClearMission, 707 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000080 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000080")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000080)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000081 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000081")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000081)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000082 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000082")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000082)
	MisResultCondition(NoRecord, 707)
	MisResultCondition(HasMission, 707)
	MisResultCondition(HasFlag, 707, 10)
	MisResultAction(ClearMission, 707)
	MisResultAction(SetRecord, 707)
	MisResultAction(AddExp, 9, 9 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000078")
	MisResultAction(GiveNpcMission, 714, MISSCRIPT_MISSIONSCRIPT01_LUA_000078, 3)

-----------------------------------服装店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000051")
	DefineMission( 714, MISSCRIPT_MISSIONSCRIPT01_LUA_000051, 708 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000083 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000083")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000083 )
	MisBeginCondition(HasRecord, 707)
	MisBeginCondition(NoRecord, 708)
	MisBeginCondition(NoMission, 708)
	MisBeginAction(AddMission, 708)
	MisBeginAction(SetFlag, 708, 1)
	--MisBeginAction(GiveItem, 3957, 1, 4)
	--MisCancelAction(ClearMission, 708 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000084 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000084")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000084)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000085 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000085")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000085)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000086 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000086")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000086)
	MisResultCondition(NoRecord, 708)
	MisResultCondition(HasMission, 708)
	MisResultCondition(HasFlag, 708, 10)
	MisResultAction(ClearMission, 708)
	MisResultAction(SetRecord, 708)
	MisResultAction(AddExp, 21, 21 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000078")
	MisResultAction(GiveNpcMission, 716, MISSCRIPT_MISSIONSCRIPT01_LUA_000078, 4)
	
-----------------------------------药材店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000087")
	DefineMission( 716, MISSCRIPT_MISSIONSCRIPT01_LUA_000087, 709 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000088")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000088 )
	MisBeginCondition(HasRecord, 708)
	MisBeginCondition(NoRecord, 709)
	MisBeginCondition(NoMission, 709)
	MisBeginAction(AddMission, 709)
	MisBeginAction(SetFlag, 709, 1)
	MisBeginAction(GiveItem, 3958, 1, 4)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	--MisCancelAction(ClearMission, 709 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000089")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000089)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000090")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000090)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000091 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000091")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000091)
	MisResultCondition(NoRecord, 709)
	MisResultCondition(HasMission, 709)
	MisResultCondition(HasFlag, 709, 10)
	MisResultAction(ClearMission, 709)
	MisResultAction(SetRecord, 709)
	MisResultAction(AddExp, 66, 66 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000078")
	MisResultAction(GiveNpcMission, 718, MISSCRIPT_MISSIONSCRIPT01_LUA_000078, 5) 

-----------------------------------战斗训练
	MISSCRIPT_MISSIONSCRIPT01_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000060")
	DefineMission( 718, MISSCRIPT_MISSIONSCRIPT01_LUA_000060, 710 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000092 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000092")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000092 )
	MisBeginCondition(HasRecord, 709)
	MisBeginCondition(NoRecord, 710)
	MisBeginCondition(NoMission, 710)
	MisBeginCondition(LvCheck, ">", 4 )
	--MisBeginCondition(LvCheck, "<", 10 )
	MisBeginAction(AddMission, 710)
	MisBeginAction(SetFlag, 710, 1)
	MisBeginAction(AddTrigger, 7101, TE_GETITEM, 1691, 1 )
	MisBeginAction(AddTrigger, 7102, TE_KILL, 188, 5 )
	MisCancelAction(ClearMission, 710)

	MisNeed(MIS_NEED_ITEM, 1691, 1, 10, 1)
	MisNeed(MIS_NEED_KILL, 188, 5, 20, 5)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000093")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000093)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000094 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000094")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000094)
	MisResultCondition(NoRecord, 710)
	MisResultCondition(HasMission, 710)
	MisResultCondition(HasItem, 1691, 1)
	MisResultCondition(HasFlag, 710, 24)
	MisResultAction(TakeItem, 1691, 1)
	MisResultAction(ClearMission, 710)
	MisResultAction(SetRecord, 710)
	MisResultAction(AddExp, 75, 75 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000078")
	MisResultAction(GiveNpcMission, 83, MISSCRIPT_MISSIONSCRIPT01_LUA_000078, 8)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000078")
	MisResultAction(GiveNpcMission, 84, MISSCRIPT_MISSIONSCRIPT01_LUA_000078, 9) 

	InitTrigger()
	TriggerCondition( 1, IsItem, 1691 )	
	TriggerAction( 1, AddNextFlag, 710, 10, 1 )
	RegCurTrigger( 7101 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 188 )	
	TriggerAction( 1, AddNextFlag, 710, 20, 5 )
	RegCurTrigger( 7102 )


end
RobinMission027()




----------------------------------------------------------
--							--
--							--
--		沙岚城[服装店主·莫亚]			--
--							--
--		239185,277025				--
----------------------------------------------------------
-- function RobinMission028()

--服装店的问候
	-- DefineMission( 715, "服装店的问候", 708, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("<t>呵呵！呵呵！<n><t>是拉丝碧的推荐信呢。<n><t>好,按照惯例,这副手套作为我的礼物,送给你吧。<n><t>以后你到店里来买装备,我都会便宜卖给你的。<n><t>现在你要在回到<j新手指导·拉丝碧(876,3572)>那里去,她应该还会给你介绍其他人。<n><t>(莫亚送了你一个“新手手套”,你可以从物品背包中将其装备到手套部位。)")
	-- MisResultCondition(NoRecord, 708)
	-- MisResultCondition(HasMission, 708)
	-- MisResultCondition(NoFlag, 708, 10)
	-- MisResultCondition(HasItem, 3957, 1)
	-- MisResultAction(TakeItem, 3957, 1)
	-- MisResultAction(SetFlag, 708, 10)
	-- MisResultAction(GiveItem, 465, 1, 4)
	-- MisResultBagNeed(1)
	
--end
-- RobinMission028()



----------------------------------------------------------
--							--
--		冰狼堡[新手指导·安琪露]		--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission030()

-----------------------------------新人报道
	MISSCRIPT_EUDEMONSCRIPT_LUA_000001 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000001")
	DefineMission( 721, MISSCRIPT_EUDEMONSCRIPT_LUA_000001, 3, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000095 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000095")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000095)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000045")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000045)
	MisResultCondition(NoRecord, 3)
	MisResultCondition(HasMission, 3)
	--MisResultCondition(HasFlag, 712, 10)
	--MisResultCondition(HasFlag, 712, 20)
	MisResultAction(ClearMission, 3)
	MisResultAction(SetRecord, 3)
	MisResultAction(AddExp, 6, 6)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000096")
	MisResultAction(GiveNpcMission, 722, MISSCRIPT_MISSIONSCRIPT01_LUA_000096, 2) 


-----------------------------------铁匠的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000025")
	DefineMission( 722, MISSCRIPT_MISSIONSCRIPT01_LUA_000025, 713 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000097 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000097")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000097 )
	MisBeginCondition(HasRecord, 3)
	MisBeginCondition(NoRecord, 713)
	MisBeginCondition(NoMission, 713)
	MisBeginAction(AddMission, 713)
	MisBeginAction(SetFlag, 713, 1)
	MisBeginAction(GiveItem, 3959, 1, 4)
	MisCancelAction(ClearMission, 713 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000098")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000098)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000099 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000099")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000099)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000100 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000100")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000100)
	MisResultCondition(NoRecord, 713)
	MisResultCondition(HasMission, 713)
	MisResultCondition(HasFlag, 713, 10)
	MisResultAction(ClearMission, 713)
	MisResultAction(SetRecord, 713)
	MisResultAction(AddExp, 9, 9 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000096")
	MisResultAction(GiveNpcMission, 724, MISSCRIPT_MISSIONSCRIPT01_LUA_000096, 3) 


-----------------------------------新人过三关（原服装店的问候）
	MISSCRIPT_MISSIONSCRIPT01_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000051")
	DefineMission( 724, MISSCRIPT_MISSIONSCRIPT01_LUA_000051, 714 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000101 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000101")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000101 )
	MisBeginCondition(HasRecord, 713)
	MisBeginCondition(NoRecord, 714)
	MisBeginCondition(NoMission, 714)
	MisBeginAction(AddMission, 714)
	MisBeginAction(SetFlag, 714, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	--MisCancelAction(ClearMission, 714 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000102 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000102")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000102)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000103 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000103")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000103)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000104 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000104")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000104)
	MisResultCondition(NoRecord, 714)
	MisResultCondition(HasMission, 714)
	MisResultCondition(HasFlag, 714, 10)
	MisResultAction(ClearMission, 714)
	MisResultAction(SetRecord, 714)
	MisResultAction(AddExp, 21, 21 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000096")
	MisResultAction(GiveNpcMission, 726, MISSCRIPT_MISSIONSCRIPT01_LUA_000096, 4) 

-----------------------------------药品店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000001")
	DefineMission( 726, MISSCRIPT_MISSIONSCRIPT01_LUA_000001, 715 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000105 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000105")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000105 )
	MisBeginCondition(HasRecord, 714)
	MisBeginCondition(NoRecord, 715)
	MisBeginCondition(NoMission, 715)
	MisBeginAction(AddMission, 715)
	MisBeginAction(SetFlag, 715, 1)
	MisBeginAction(GiveItem, 3961, 1, 4)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
	--MisCancelAction(ClearMission, 715 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000106 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000106")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000106)
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000107")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000107)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000108 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000108")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000108)
	MisResultCondition(NoRecord, 715)
	MisResultCondition(HasMission, 715)
	MisResultCondition(HasFlag, 715, 10)
	MisResultAction(ClearMission, 715)
	MisResultAction(SetRecord, 715)
	MisResultAction(AddExp, 66, 66 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000096")
	MisResultAction(GiveNpcMission, 728, MISSCRIPT_MISSIONSCRIPT01_LUA_000096, 5) 

-----------------------------------战斗训练
	MISSCRIPT_MISSIONSCRIPT01_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000060")
	DefineMission( 728, MISSCRIPT_MISSIONSCRIPT01_LUA_000060, 716 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000109 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000109")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000109 )
	MisBeginCondition(HasRecord, 715)
	MisBeginCondition(NoRecord, 716)
	MisBeginCondition(NoMission, 716)
	MisBeginCondition(LvCheck, ">", 4 )
	--MisBeginCondition(LvCheck, "<", 10 )
	MisBeginAction(AddMission, 716)
	MisBeginAction(AddTrigger, 7161, TE_GETITEM, 1597, 1 )
	MisBeginAction(AddTrigger, 7162, TE_KILL, 234, 5 )
	MisBeginAction(SetFlag, 716, 1)
	MisCancelAction(ClearMission, 716)
	
	MisNeed(MIS_NEED_ITEM, 1597, 1, 10, 1)
	MisNeed(MIS_NEED_KILL, 234, 5, 20, 5)


	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000110 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000110")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000110)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000111 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000111")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000111)
	MisResultCondition(NoRecord, 716)
	MisResultCondition(HasMission, 716)
	MisResultCondition(HasItem, 1597, 1)
	MisResultCondition(HasFlag, 716, 24)
	MisResultAction(TakeItem, 1597, 1)
	MisResultAction(ClearMission, 716)
	MisResultAction(SetRecord, 716 )
	MisResultAction(AddExp, 75, 75 )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000096")
	MisResultAction(GiveNpcMission, 162, MISSCRIPT_MISSIONSCRIPT01_LUA_000096, 12) 
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1597 )	
	TriggerAction( 1, AddNextFlag, 716, 10, 1 )
	RegCurTrigger( 7161 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 234 )	
	TriggerAction( 1, AddNextFlag, 716, 20, 5 )
	RegCurTrigger( 7162 )


	
end
RobinMission030()


----------------------------------------------------------
--							--
--							--
--		冰狼堡[铁匠·暴冰]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission031()

---------------------------------------新手任务送小刀
	MISSCRIPT_MISSIONSCRIPT01_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000025")
	DefineMission( 723, MISSCRIPT_MISSIONSCRIPT01_LUA_000025, 713, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000112 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000112")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000112)
	MisResultCondition(NoRecord, 713)
	MisResultCondition(HasMission, 713)
	MisResultCondition(NoFlag, 713, 10)
	MisResultCondition(HasItem, 3959, 1)
	MisResultAction(TakeItem, 3959, 1)
	MisResultAction(SetFlag, 713, 10)
	MisResultBagNeed(1)

end
RobinMission031()


----------------------------------------------------------
--							--
--							--
--		冰狼堡[服装店主·翰娜]			--
--							--
--		239185,277025				--
----------------------------------------------------------
--function RobinMission032()

---------------------------------服装店的问候
	-- DefineMission( 725, "服装店的问候", 714, COMPLETE_SHOW)
	
	-- MisBeginCondition( AlwaysFailure )
		
	-- MisResultTalk("<t>你是新来的吧？呵呵,欢迎到冰狼堡来。<n><t>我是这里的服装店主·翰娜。谢谢你送信过来哦。<n><t>这个新手手套你拿去用吧,是我专门为你做的。<n><t>还有,回去的时候要记得告诉安琪露,信我收到了,叫她不要担心了。<n><t>现在你要在回到<j新手指导·安琪露(1315,507)>那里去,她应该还会给你介绍其他人。<n><t>(翰娜送了你一个“新手手套”,你可以从物品背包中将其装备到手套部位。)")
	-- MisResultCondition(NoRecord, 714)
	-- MisResultCondition(HasMission, 714)
	-- MisResultCondition(NoFlag, 714, 10)
	-- MisResultCondition(HasItem, 3960, 1)
	-- MisResultAction(TakeItem, 3960, 1)
	-- MisResultAction(SetFlag, 714, 10)
	-- MisResultAction(GiveItem, 465, 1, 4)
	-- MisResultBagNeed(1)
	
--end
-- RobinMission032()


----------------------------------------------------------
--							--
--							--
--		冰狼堡[药店老板·达赫]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission033()

-----------------------------------药材店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000087")
	DefineMission( 727, MISSCRIPT_MISSIONSCRIPT01_LUA_000087, 715, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000113 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000113")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000113)
	MisResultCondition(NoRecord, 715)
	MisResultCondition(HasMission, 715)
	MisResultCondition(NoFlag, 715, 10)
	MisResultCondition(HasItem, 3961, 1)
	MisResultAction(TakeItem, 3961, 1)
	MisResultAction(SetFlag, 715, 10)
	MisResultAction(GiveItem, 1847, 10, 4)
	MisResultBagNeed(1)

---------------------------------收集癖	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000114")
	DefineMission( 735, MISSCRIPT_MISSIONSCRIPT01_LUA_000114, 723 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000115 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000115")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000115 )
	MisBeginCondition(NoMission, 723)
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(LvCheck, "<", 7 )
	MisBeginAction(AddMission, 723)
	MisBeginAction(SetFlag, 723, 1)
	MisBeginAction(AddTrigger, 7231, TE_GETITEM, 1704, 5 )
	MisCancelAction(ClearMission, 723)

	MisNeed(MIS_NEED_ITEM, 1704, 5, 10, 5)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000116 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000116")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000116)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000117 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000117")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000117)
	MisResultCondition(HasMission, 723)
	MisResultCondition(HasItem, 1704, 5 )
	MisResultAction(TakeItem, 1704, 5 )
	MisResultAction(AddExp, 40, 70)
	MisResultAction(ClearMission, 723)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1704)	
	TriggerAction( 1, AddNextFlag, 723, 10, 5 )
	RegCurTrigger( 7231 )


	---------------------------------收集癖	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000114")
	DefineMission( 746, MISSCRIPT_MISSIONSCRIPT01_LUA_000114, 734 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000118 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000118")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000118 )
	MisBeginCondition(NoMission, 734)
	MisBeginCondition(NoMission, 723)
	MisBeginCondition(LvCheck, ">", 6 )
	MisBeginCondition(LvCheck, "<", 8 )
	MisBeginAction(AddMission, 734)
	MisBeginAction(SetFlag, 734, 1)
	MisBeginAction(AddTrigger, 7341, TE_GETITEM, 3372, 5 )
	MisCancelAction(ClearMission, 734)

	MisNeed(MIS_NEED_ITEM, 3372, 5, 10, 5)

	MisPrize(MIS_PRIZE_MONEY, 200, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000119 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000119")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000119)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000120 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000120")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000120)
	MisResultCondition(HasMission, 734)
	MisResultCondition(HasItem, 3372, 5 )
	MisResultAction(TakeItem, 3372, 5 )
	MisResultAction(AddExp, 70, 95)
	MisResultAction(ClearMission, 734)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 3372)	
	TriggerAction( 1, AddNextFlag, 734, 10, 5 )
	RegCurTrigger( 7341 )


---------------------------------收集癖	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000114")
	DefineMission( 747, MISSCRIPT_MISSIONSCRIPT01_LUA_000114, 735 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000121")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000121 )
	MisBeginCondition(NoMission, 735)
	MisBeginCondition(NoMission, 734)
	MisBeginCondition(NoMission, 723)
	MisBeginCondition(LvCheck, ">", 7 )
	MisBeginCondition(LvCheck, "<", 9 )
	MisBeginAction(AddMission, 735)
	MisBeginAction(SetFlag, 735, 1)
	MisBeginAction(AddTrigger, 7351, TE_GETITEM, 1779, 3 )
	MisCancelAction(ClearMission, 735)

	MisNeed(MIS_NEED_ITEM, 1779, 3, 10, 3)

	MisPrize(MIS_PRIZE_MONEY, 300, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000122 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000122")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000122)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000123 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000123")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000123)
	MisResultCondition(HasMission, 735)
	MisResultCondition(HasItem, 1779, 3 )
	MisResultAction(TakeItem, 1779, 3 )
	MisResultAction(AddExp, 95, 125)
	MisResultAction(ClearMission, 735)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1779)	
	TriggerAction( 1, AddNextFlag, 735, 10, 3 )
	RegCurTrigger( 7351 )



end
RobinMission033()

----------------------------------------------------------
--							--
--							--
--		冰狼堡[猎人导师·雷欧]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission034()

-----------------------------------猎人手册
	MISSCRIPT_MISSIONSCRIPT01_LUA_000124 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000124")
	DefineMission( 729, MISSCRIPT_MISSIONSCRIPT01_LUA_000124, 717 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000125 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000125")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000125 )
	MisBeginCondition(NoMission, 717)
	MisBeginCondition(LvCheck, ">", 6 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(CheckConvertProfession, MIS_HUNTER )
	MisBeginAction(AddMission, 717)
	MisBeginAction(SetFlag, 717, 1)
	MisBeginAction(AddTrigger, 7171, TE_KILL, 240, 8 )
	MisBeginAction(AddTrigger, 7172, TE_GETITEM, 3122, 1 )
	MisBeginAction(AddTrigger, 7173, TE_KILL, 238, 8 )
	MisCancelAction(ClearMission, 717)

	
	MisNeed(MIS_NEED_KILL, 240, 8, 10, 8)
	MisNeed(MIS_NEED_ITEM, 3122, 1, 20, 1)
	MisNeed(MIS_NEED_KILL, 238, 8, 30, 8)

	MisPrize(MIS_PRIZE_ITEM, 3955, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000126 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000126")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000126)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000127 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000127")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000127)
	MisResultCondition(HasMission, 717)
	MisResultCondition(HasItem, 3122, 1 )
	MisResultCondition(HasFlag, 717, 19 )
	MisResultCondition(HasFlag, 717, 39 )
	MisResultAction(TakeItem, 3122, 1)
	MisResultAction(ClearMission, 717)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 240 )	
	TriggerAction( 1, AddNextFlag, 717, 10, 8 )
	RegCurTrigger( 7171 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3122 )	
	TriggerAction( 1, AddNextFlag, 717, 20, 1 )
	RegCurTrigger( 7172 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 238 )	
	TriggerAction( 1, AddNextFlag, 717, 30, 8 )
	RegCurTrigger( 7173 )
	
-----------------------------------狙击手转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000128 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000128")
	DefineMission( 757, MISSCRIPT_MISSIONSCRIPT01_LUA_000128, 741 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000129 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000129")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000129 )
	MisBeginCondition(NoRecord, 741)
	MisBeginCondition(NoMission, 741)
	MisBeginCondition(LvCheck, ">", 39 )
	MisBeginCondition(CheckZsExp)
	MisBeginCondition(PfEqual, 2 )
	MisBeginCondition(CheckConvertProfession, MIS_GUNMAN )
	MisBeginAction(AddMission, 741)
	MisBeginAction(AddTrigger, 7411, TE_KILL, 269, 10 )
	-- MisBeginAction(AddTrigger, 7412, TE_KILL, 243, 10 )
	MisBeginAction(AddTrigger, 7413, TE_GETITEM, 4362, 5 )
	-- MisBeginAction(AddTrigger, 7414, TE_GETITEM, 4367, 5 )
	MisCancelAction(ClearMission, 741)
	
	MisNeed(MIS_NEED_KILL, 269, 10, 10, 10)
	-- MisNeed(MIS_NEED_KILL, 243, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 4362, 5, 30, 5)
	-- MisNeed(MIS_NEED_ITEM, 4367, 5, 40, 5)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000130 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000130")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000130)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000131")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000131)
	MisResultCondition(HasMission, 741)
	MisResultCondition(HasFlag, 741, 19 )
	-- MisResultCondition(HasFlag, 741, 29 )
	MisResultCondition(HasItem, 4362, 5 )
	-- MisResultCondition(HasItem, 4367, 5 )
	MisResultAction(TakeItem, 4362, 5)
	-- MisResultAction(TakeItem, 4367, 5)
	MisResultAction(ClearMission, 741)
	MisResultAction(SetRecord, 741)
	MisResultAction(SetProfession, 12)
	MisResultAction(GiveItem, 7576, 1, 4 )
	MisResultAction(Starteffect , 944)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 269 )	
	TriggerAction( 1, AddNextFlag, 741, 10, 10 )
	RegCurTrigger( 7411 )
	-- InitTrigger()
	-- TriggerCondition( 1, IsMonster, 243 )	
	-- TriggerAction( 1, AddNextFlag, 741, 20, 10 )
	-- RegCurTrigger( 7412 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4362 )	
	TriggerAction( 1, AddNextFlag, 741, 30, 5 )
	RegCurTrigger( 7413 )
	-- InitTrigger()
	-- TriggerCondition( 1, IsItem, 4367 )	
	-- TriggerAction( 1, AddNextFlag, 741, 30, 5 )
	-- RegCurTrigger( 7414 )

end
RobinMission034()


----------------------------------------------------------
--							--
--							--
--		白银城[巡逻兵·马尔斯]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission035()

-----------------------------------十万火急
	MISSCRIPT_MISSIONSCRIPT01_LUA_000132 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000132")
	DefineMission( 730, MISSCRIPT_MISSIONSCRIPT01_LUA_000132, 718 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000133 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000133")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000133 )
	MisBeginCondition(NoMission, 718)
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(LvCheck, "<", 7 )
	MisBeginAction(AddMission, 718)
	MisBeginAction(SetFlag, 718, 1)
	MisBeginAction(AddTrigger, 7181, TE_KILL, 206, 10 )
	MisCancelAction(ClearMission, 718)
	
	MisNeed(MIS_NEED_KILL, 206, 10, 10, 10)

	MisPrize(MIS_PRIZE_MONEY, 50, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000134 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000134")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000134)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000135 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000135")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000135)
	MisResultCondition(HasMission, 718)
	MisResultCondition(HasFlag, 718, 19 )
	MisResultAction(AddExp, 75, 125)
	MisResultAction(ClearMission, 718)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 206 )	
	TriggerAction( 1, AddNextFlag, 718, 10, 10 )
	RegCurTrigger( 7181 )


-----------------------------------蘑菇泛滥
	MISSCRIPT_MISSIONSCRIPT01_LUA_000136 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000136")
	DefineMission( 736, MISSCRIPT_MISSIONSCRIPT01_LUA_000136, 724 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000137")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000137 )
	MisBeginCondition(NoMission, 724)
	MisBeginCondition(NoMission, 718)
	MisBeginCondition(LvCheck, ">", 6 )
	MisBeginCondition(LvCheck, "<", 8 )
	MisBeginAction(AddMission, 724)
	MisBeginAction(SetFlag, 724, 1)
	MisBeginAction(AddTrigger, 7241, TE_KILL, 184, 12 )
	MisCancelAction(ClearMission, 724)
	
	MisNeed(MIS_NEED_KILL, 184, 12, 10, 12)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000138 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000138")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000138)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000139 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000139")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000139)
	MisResultCondition(HasMission, 724)
	MisResultCondition(HasFlag, 724, 24 )
	MisResultAction(AddExp, 125, 175)
	MisResultAction(ClearMission, 724)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 184 )	
	TriggerAction( 1, AddNextFlag, 724, 10, 12 )
	RegCurTrigger( 7241 )


-----------------------------------护绿行动
	MISSCRIPT_MISSIONSCRIPT01_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000140")
	DefineMission( 737, MISSCRIPT_MISSIONSCRIPT01_LUA_000140, 725 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000141 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000141")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000141 )
	MisBeginCondition(NoMission, 725)
	MisBeginCondition(NoMission, 724)
	MisBeginCondition(NoMission, 718)
	MisBeginCondition(LvCheck, ">", 7 )
	MisBeginCondition(LvCheck, "<", 9 )
	MisBeginAction(AddMission, 725)
	MisBeginAction(SetFlag, 725, 1)
	MisBeginAction(AddTrigger, 7251, TE_KILL, 119, 8 )
	MisCancelAction(ClearMission, 725)
	
	MisNeed(MIS_NEED_KILL, 119, 8, 10, 8)

	MisPrize(MIS_PRIZE_MONEY, 150, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000142")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000142)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000143 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000143")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000143)
	MisResultCondition(HasMission, 725)
	MisResultCondition(HasFlag, 725, 19 )
	MisResultAction(AddExp, 175, 250)
	MisResultAction(SetRecord, 725)
	MisResultAction(ClearMission, 725)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 119 )	
	TriggerAction( 1, AddNextFlag, 725, 10, 8 )
	RegCurTrigger( 7251 )

	
end
RobinMission035()


----------------------------------------------------------
--							--
--							--
--		沙岚城[药材商人·沙拉拉]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission036()

-----------------------------------药材店的问候
	MISSCRIPT_MISSIONSCRIPT01_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000087")
	DefineMission( 717, MISSCRIPT_MISSIONSCRIPT01_LUA_000087, 709, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT01_LUA_000144 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000144")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000144)
	MisResultCondition(NoRecord, 709)
	MisResultCondition(HasMission, 709)
	MisResultCondition(NoFlag, 709, 10)
	MisResultCondition(HasItem, 3958, 1)
	MisResultAction(TakeItem, 3958, 1)
	MisResultAction(SetFlag, 709, 10)
	MisResultAction(GiveItem, 1847, 10, 4)
	MisResultBagNeed(1)


---------------------------------嫁接试验	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000145 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000145")
	DefineMission( 734, MISSCRIPT_MISSIONSCRIPT01_LUA_000145, 722 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000146")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000146 )
	MisBeginCondition(NoMission, 722)
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(LvCheck, "<", 7 )
	MisBeginAction(AddMission, 722)
	MisBeginAction(SetFlag, 722, 1)
	MisBeginAction(AddTrigger, 7221, TE_GETITEM, 1691, 3 )
	MisBeginAction(AddTrigger, 7222, TE_GETITEM, 1597, 3 )
	MisCancelAction(ClearMission, 722)

	MisNeed(MIS_NEED_ITEM, 1691, 3, 10, 3)
	MisNeed(MIS_NEED_ITEM, 1597, 3, 20, 3)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000147")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000147)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000148 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000148")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000148)
	MisResultCondition(HasMission, 722)
	MisResultCondition(HasItem, 1691, 3 )
	MisResultCondition(HasItem, 1597, 3 )
	MisResultAction(TakeItem, 1691, 3 )
	MisResultAction(TakeItem, 1597, 3 )
	MisResultAction(AddExp, 40, 70)
	MisResultAction(ClearMission, 722)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1691)	
	TriggerAction( 1, AddNextFlag, 722, 10, 3 )
	RegCurTrigger( 7221 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1597)	
	TriggerAction( 1, AddNextFlag, 722, 20, 3 )
	RegCurTrigger( 7222 )


--------------------------------伪造礼物	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000149 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000149")
	DefineMission( 744, MISSCRIPT_MISSIONSCRIPT01_LUA_000149, 732 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000150 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000150")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000150 )
	MisBeginCondition(NoMission, 732)
	MisBeginCondition(NoMission, 722)
	MisBeginCondition(LvCheck, ">", 6 )
	MisBeginCondition(LvCheck, "<", 8 )
	MisBeginAction(AddMission, 732)
	MisBeginAction(SetFlag, 732, 1)
	MisBeginAction(AddTrigger, 7321, TE_GETITEM, 1648, 3 )
	MisBeginAction(AddTrigger, 7322, TE_GETITEM, 1777, 3 )
	MisCancelAction(ClearMission, 732)

	MisNeed(MIS_NEED_ITEM, 1648, 3, 10, 3)
	MisNeed(MIS_NEED_ITEM, 1777, 3, 20, 3)

	MisPrize(MIS_PRIZE_MONEY, 200, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000151")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000151)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000152")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000152)
	MisResultCondition(HasMission, 732)
	MisResultCondition(HasItem, 1648, 3 )
	MisResultCondition(HasItem, 1777, 3 )
	MisResultAction(TakeItem, 1648, 3 )
	MisResultAction(TakeItem, 1777, 3 )
	MisResultAction(AddExp, 70, 95)
	MisResultAction(ClearMission, 732)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1648)	
	TriggerAction( 1, AddNextFlag, 732, 10, 3 )
	RegCurTrigger( 7321 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1777)	
	TriggerAction( 1, AddNextFlag, 732, 20, 3 )
	RegCurTrigger( 7322 )


	--------------------------------配药材料	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000153 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000153")
	DefineMission( 745, MISSCRIPT_MISSIONSCRIPT01_LUA_000153, 733 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000154 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000154")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000154 )
	MisBeginCondition(NoMission, 733)
	MisBeginCondition(NoMission, 732)
	MisBeginCondition(NoMission, 722)
	MisBeginCondition(LvCheck, ">", 7 )
	MisBeginCondition(LvCheck, "<", 9 )
	MisBeginAction(AddMission, 733)
	MisBeginAction(SetFlag, 733, 1)
	MisBeginAction(AddTrigger, 7331, TE_GETITEM, 1692, 5 )
	MisBeginAction(AddTrigger, 7332, TE_GETITEM, 3117, 2 )
	MisCancelAction(ClearMission, 733)

	MisNeed(MIS_NEED_ITEM, 1692, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 3117, 2, 20, 2)

	MisPrize(MIS_PRIZE_MONEY, 300, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000155 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000155")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000155)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000156 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000156")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000156)
	MisResultCondition(HasMission, 733)
	MisResultCondition(HasItem, 1692, 5 )
	MisResultCondition(HasItem, 3117, 2 )
	MisResultAction(TakeItem, 1692, 5 )
	MisResultAction(TakeItem, 3117, 2 )
	MisResultAction(AddExp, 95, 125)
	MisResultAction(ClearMission, 733)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1692)	
	TriggerAction( 1, AddNextFlag, 733, 10, 5 )
	RegCurTrigger( 7331 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3117)	
	TriggerAction( 1, AddNextFlag, 733, 20, 2 )
	RegCurTrigger( 7332 )


end
RobinMission036()


----------------------------------------------------------
--							--
--							--
--		沙岚城[巡逻兵·迈克]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission037()

-----------------------------------抗击仙人掌
	MISSCRIPT_MISSIONSCRIPT01_LUA_000157 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000157")
	DefineMission( 731, MISSCRIPT_MISSIONSCRIPT01_LUA_000157, 719 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000158 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000158")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000158 )
	MisBeginCondition(NoMission, 719)
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(LvCheck, "<", 7 )
	MisBeginAction(AddMission, 719)
	MisBeginAction(SetFlag, 719, 1)
	MisBeginAction(AddTrigger, 7191, TE_KILL, 95, 12 )
	MisCancelAction(ClearMission, 719)
	
	MisNeed(MIS_NEED_KILL, 95, 12, 10, 12)

	MisPrize(MIS_PRIZE_MONEY, 50, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000159 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000159")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000159)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000160 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000160")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000160)
	MisResultCondition(HasMission, 719)
	MisResultCondition(HasFlag, 719, 24 )
	MisResultAction(AddExp, 75, 125)
	MisResultAction(ClearMission, 719)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 95 )	
	TriggerAction( 1, AddNextFlag, 719, 10, 12 )
	RegCurTrigger( 7191 )


	-----------------------------------踢人怪兽
	MISSCRIPT_MISSIONSCRIPT01_LUA_000161 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000161")
	DefineMission( 740, MISSCRIPT_MISSIONSCRIPT01_LUA_000161, 728 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000162 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000162")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000162 )
	MisBeginCondition(NoMission, 728)
	MisBeginCondition(NoMission, 719)
	MisBeginCondition(LvCheck, ">", 6 )
	MisBeginCondition(LvCheck, "<", 8 )
	MisBeginAction(AddMission, 728)
	MisBeginAction(SetFlag, 728, 1)
	MisBeginAction(AddTrigger, 7281, TE_KILL, 48, 8 )
	MisCancelAction(ClearMission, 728)
	
	MisNeed(MIS_NEED_KILL, 48, 8, 10, 8)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000163 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000163")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000163)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000164 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000164")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000164)
	MisResultCondition(HasMission, 728)
	MisResultCondition(HasFlag, 728, 19 )
	MisResultAction(AddExp, 125, 175)
	MisResultAction(ClearMission, 728)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 48)	
	TriggerAction( 1, AddNextFlag, 728, 10, 8 )
	RegCurTrigger( 7281 )
	
	-----------------------------------蝎子危机
	MISSCRIPT_MISSIONSCRIPT01_LUA_000165 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000165")
	DefineMission( 741, MISSCRIPT_MISSIONSCRIPT01_LUA_000165, 729 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000166 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000166")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000166 )
	MisBeginCondition(NoMission, 729)
	MisBeginCondition(NoMission, 728)
	MisBeginCondition(NoMission, 719)
	MisBeginCondition(LvCheck, ">", 7 )
	MisBeginCondition(LvCheck, "<", 9 )
	MisBeginAction(AddMission, 729)
	MisBeginAction(SetFlag, 729, 1)
	MisBeginAction(AddTrigger, 7291, TE_KILL, 247, 8 )
	MisCancelAction(ClearMission, 729)
	
	MisNeed(MIS_NEED_KILL, 247, 8, 10, 8)

	MisPrize(MIS_PRIZE_MONEY, 150, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000167 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000167")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000167)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000168 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000168")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000168)
	MisResultCondition(HasMission, 729)
	MisResultCondition(HasFlag, 729, 19 )
	MisResultAction(AddExp, 175, 250)
	MisResultAction(ClearMission, 729)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 247)	
	TriggerAction( 1, AddNextFlag, 729, 10, 8 )
	RegCurTrigger( 7291 )

end
RobinMission037()


----------------------------------------------------------
--							--
--							--
--		冰狼堡[巡逻兵·小莫]			--
--							--
--		239185,277025				--
----------------------------------------------------------
function RobinMission038()

-----------------------------------顽皮帕帕
	MISSCRIPT_MISSIONSCRIPT01_LUA_000169 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000169")
	DefineMission( 732, MISSCRIPT_MISSIONSCRIPT01_LUA_000169, 720 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000170 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000170")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000170 )
	MisBeginCondition(NoMission, 720)
	MisBeginCondition(LvCheck, ">", 4 )
	MisBeginCondition(LvCheck, "<", 7 )
	MisBeginAction(AddMission, 720)
	MisBeginAction(SetFlag, 720, 1)
	MisBeginAction(AddTrigger, 7201, TE_KILL, 235, 12 )
	MisCancelAction(ClearMission, 720)
	
	MisNeed(MIS_NEED_KILL, 235, 12, 10, 12)

	MisPrize(MIS_PRIZE_MONEY, 50, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000171 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000171")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000171)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000172")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000172)
	MisResultCondition(HasMission, 720)
	MisResultCondition(HasFlag, 720, 24 )
	MisResultAction(AddExp, 75, 125)
	MisResultAction(ClearMission, 720)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 235 )	
	TriggerAction( 1, AddNextFlag, 720, 10, 12 )
	RegCurTrigger( 7201 )
	
-----------------------------------猪口夺粮
	MISSCRIPT_MISSIONSCRIPT01_LUA_000173 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000173")
	DefineMission( 742, MISSCRIPT_MISSIONSCRIPT01_LUA_000173, 730 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000174 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000174")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000174 )
	MisBeginCondition(NoMission, 730)
	MisBeginCondition(NoMission, 720)
	MisBeginCondition(LvCheck, ">", 6 )
	MisBeginCondition(LvCheck, "<", 8 )
	MisBeginAction(AddMission, 730)
	MisBeginAction(SetFlag, 730, 1)
	MisBeginAction(AddTrigger, 7301, TE_KILL, 239, 8 )
	MisCancelAction(ClearMission, 730)

	MisNeed(MIS_NEED_KILL, 239, 8, 10, 8)

	MisPrize(MIS_PRIZE_MONEY, 100, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000175")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000175)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000176 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000176")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000176)
	MisResultCondition(HasMission, 730)
	MisResultCondition(HasFlag, 730, 19 )
	MisResultAction(AddExp, 125, 175)
	MisResultAction(ClearMission, 730)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 239 )	
	TriggerAction( 1, AddNextFlag, 730, 10, 8 )
	RegCurTrigger( 7301 )

	-----------------------------------错误迁移
	MISSCRIPT_MISSIONSCRIPT01_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000177")
	DefineMission( 743, MISSCRIPT_MISSIONSCRIPT01_LUA_000177, 731 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000178 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000178")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000178 )
	MisBeginCondition(NoMission, 731)
	MisBeginCondition(NoMission, 720)
	MisBeginCondition(NoMission, 730)
	MisBeginCondition(LvCheck, ">", 7 )
	MisBeginCondition(LvCheck, "<", 9 )
	MisBeginAction(AddMission, 731)
	MisBeginAction(SetFlag, 731, 1)
	MisBeginAction(AddTrigger, 7311, TE_KILL, 238, 8 )
	MisCancelAction(ClearMission, 731)
	
	MisNeed(MIS_NEED_KILL, 238, 8, 10, 8)

	MisPrize(MIS_PRIZE_MONEY, 150, 1)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000179 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000179")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000179)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000180 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000180")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000180)
	MisResultCondition(HasMission, 731)
	MisResultCondition(HasFlag, 731, 19 )
	MisResultAction(AddExp, 175, 250)
	MisResultAction(ClearMission, 731)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 238 )	
	TriggerAction( 1, AddNextFlag, 731, 10, 8 )
	RegCurTrigger( 7311 )

end
RobinMission038()


----------------------------------------------------------
--							--
--							--
--		新手任务					--
--							--
--							--
----------------------------------------------------------
function RobinMission039()

-----------------------------------送信给马尔斯
	MISSCRIPT_MISSIONSCRIPT01_LUA_000181 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000181")
	DefineMission( 50, MISSCRIPT_MISSIONSCRIPT01_LUA_000181, 50 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000182 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000182")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000182 )
	MisBeginCondition(HasRecord, 704)
	MisBeginCondition(LvCheck, ">", 120 )
	MisBeginCondition(NoRecord, 50)
	MisBeginCondition(NoMission, 50)
	MisBeginAction(AddMission, 50)
	MisBeginAction(GiveItem, 4111, 1, 4)
	MisCancelAction(ClearMission, 50 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000183 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000183")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000183)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000184 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000184")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000184)
	MisResultCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000185")
	MisResultAction(GiveNpcMission,53,MISSCRIPT_MISSIONSCRIPT01_LUA_000185,3)
	
-----------------------------------送信给帝姆
	MISSCRIPT_MISSIONSCRIPT01_LUA_000186 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000186")
	DefineMission( 51, MISSCRIPT_MISSIONSCRIPT01_LUA_000186, 51 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000187 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000187")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000187 )
	MisBeginCondition(HasRecord, 704)
	MisBeginCondition(NoRecord, 51)
	MisBeginCondition(NoMission, 51)
	MisBeginAction(AddMission, 51)
	MisBeginAction(GiveItem, 4112, 1, 4)
	MisCancelAction(ClearMission, 51  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000188 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000188")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000188)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000189 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000189")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000189)
	MisResultCondition(AlwaysFailure )
	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission,74,MISSCRIPT_MISSIONSCRIPT01_LUA_000190,12)

-----------------------------------送信给马尔斯
	MISSCRIPT_MISSIONSCRIPT01_LUA_000181 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000181")
	DefineMission( 52, MISSCRIPT_MISSIONSCRIPT01_LUA_000181, 50, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000191")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000191)
	MisResultCondition(NoRecord, 50)
	MisResultCondition(HasMission, 50)
	MisResultCondition(HasItem, 4111, 1)
	MisResultAction(TakeItem, 4111, 1)
	MisResultAction(ClearMission, 50)
	MisResultAction(SetRecord, 50)
	MisResultAction(AddExp, 50, 50)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000185")
	MisResultAction(GiveNpcMission,53,MISSCRIPT_MISSIONSCRIPT01_LUA_000185,3)

-----------------------------------十万火急
	MISSCRIPT_MISSIONSCRIPT01_LUA_000132 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000132")
	DefineMission( 53, MISSCRIPT_MISSIONSCRIPT01_LUA_000132, 52 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000192 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000192")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000192 )
	MisBeginCondition(HasRecord, 50)
	MisBeginCondition(NoMission, 52)
	MisBeginCondition(NoRecord, 52)
	MisBeginAction(AddMission, 52)
	MisBeginAction(AddTrigger, 521, TE_KILL, 206, 6 )
	MisCancelAction(ClearMission, 52)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000193 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000193")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000193)
	MisNeed(MIS_NEED_KILL, 206, 6, 10, 6)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000134 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000134")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000134)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000194 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000194")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000194)
	MisResultCondition(HasMission, 52)
	MisResultCondition(HasFlag, 52, 15 )
	MisResultAction(AddExp, 150, 150)
	MisResultAction(ClearMission, 52)
	MisResultAction(SetRecord, 52)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000185")
	MisResultAction(GiveNpcMission,54,MISSCRIPT_MISSIONSCRIPT01_LUA_000185,4)
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 206 )	
	TriggerAction( 1, AddNextFlag, 52, 10, 6 )
	RegCurTrigger( 521 )

-----------------------------------送信给斯克特
	MISSCRIPT_MISSIONSCRIPT01_LUA_000195 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000195")
	DefineMission( 54, MISSCRIPT_MISSIONSCRIPT01_LUA_000195, 53 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000196 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000196")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000196 )
	MisBeginCondition(HasRecord, 52)
	MisBeginCondition(NoRecord, 53)
	MisBeginCondition(NoMission, 53)
	MisBeginAction(AddMission, 53)
	MisBeginAction(GiveItem, 4113, 1, 4)
	MisCancelAction(ClearMission, 53  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000197 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000197")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000197)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000198 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000198")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000198)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给斯克特
	MISSCRIPT_MISSIONSCRIPT01_LUA_000199 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000199")
	DefineMission( 55, MISSCRIPT_MISSIONSCRIPT01_LUA_000199, 53, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000200 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000200")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000200)
	MisResultCondition(NoRecord, 53)
	MisResultCondition(HasMission, 53)
	MisResultCondition(HasItem, 4113, 1)
	MisResultAction(TakeItem, 4113, 1)
	MisResultAction(ClearMission, 53)
	MisResultAction(SetRecord, 53)
	MisResultAction(AddExp, 80, 80)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000201")
	MisResultAction(GiveNpcMission,56,MISSCRIPT_MISSIONSCRIPT01_LUA_000201,12)

-----------------------------------蘑菇泛滥
	MISSCRIPT_MISSIONSCRIPT01_LUA_000136 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000136")
	DefineMission( 56, MISSCRIPT_MISSIONSCRIPT01_LUA_000136, 54 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000202 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000202")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000202 )
	MisBeginCondition(HasRecord, 53)
	MisBeginCondition(NoMission, 54)
	MisBeginCondition(NoRecord, 54)
	MisBeginAction(AddMission, 54)
	MisBeginAction(AddTrigger, 541, TE_KILL, 184, 8 )
	MisCancelAction(ClearMission, 54)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000203 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000203")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000203)
	MisNeed(MIS_NEED_KILL, 184, 8, 10, 8)

	MisPrize(MIS_PRIZE_ITEM, 1848, 5, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000204 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000204")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000204)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000205 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000205")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000205)
	MisResultCondition(HasMission, 54)
	MisResultCondition(HasFlag, 54, 17 )
	MisResultAction(AddExp, 250, 250)
	MisResultAction(ClearMission, 54)
	MisResultAction(SetRecord, 54)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000201")
	MisResultAction(GiveNpcMission,57,MISSCRIPT_MISSIONSCRIPT01_LUA_000201,13)
	MisResultBagNeed(1)	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 184 )	
	TriggerAction( 1, AddNextFlag, 54, 10, 8 )
	RegCurTrigger( 541 )

-----------------------------------送信给小金金
	MISSCRIPT_MISSIONSCRIPT01_LUA_000206 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000206")
	DefineMission( 57, MISSCRIPT_MISSIONSCRIPT01_LUA_000206, 55 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000207 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000207")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000207 )
	MisBeginCondition(HasRecord, 54)
	MisBeginCondition(NoRecord, 55)
	MisBeginCondition(NoMission, 55)
	MisBeginAction(AddMission, 55)
	MisBeginAction(GiveItem, 4114, 1, 4)
	MisCancelAction(ClearMission, 55  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000208 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000208")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000208)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000209 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000209")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000209)
	MisResultCondition(AlwaysFailure )


-----------------------------------送信给小金金
	MISSCRIPT_MISSIONSCRIPT01_LUA_000206 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000206")
	DefineMission( 58, MISSCRIPT_MISSIONSCRIPT01_LUA_000206, 55, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000210 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000210")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000210)
	MisResultCondition(NoRecord, 55)
	MisResultCondition(HasMission, 55)
	MisResultCondition(HasItem, 4114, 1)
	MisResultAction(TakeItem, 4114, 1)
	MisResultAction(ClearMission, 55)
	MisResultAction(SetRecord, 55)
	MisResultAction(AddExp, 120, 120)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000211 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000211")
	MisResultAction(GiveNpcMission,59,MISSCRIPT_MISSIONSCRIPT01_LUA_000211,7)

-----------------------------------护绿行动
	MISSCRIPT_MISSIONSCRIPT01_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000140")
	DefineMission( 59, MISSCRIPT_MISSIONSCRIPT01_LUA_000140, 56 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000212 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000212")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000212 )
	MisBeginCondition(HasRecord, 55)
	MisBeginCondition(NoMission, 56)
	MisBeginCondition(NoRecord, 56)
	MisBeginAction(AddMission, 56)
	MisBeginAction(AddTrigger, 561, TE_KILL, 119, 12 )
	MisCancelAction(ClearMission, 56)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000213 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000213")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000213)
	MisNeed(MIS_NEED_KILL, 119, 12, 10, 12)

	MisPrize(MIS_PRIZE_ITEM, 4309, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000214 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000214")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000214)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000215 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000215")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000215)
	MisResultCondition(HasMission, 56)
	MisResultCondition(HasFlag, 56, 21 )
	MisResultAction(ClearMission, 56)
	MisResultAction(AddExp, 400, 400)
	MisResultAction(SetRecord, 56)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000211 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000211")
	MisResultAction(GiveNpcMission,60,MISSCRIPT_MISSIONSCRIPT01_LUA_000211,8)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 119 )	
	TriggerAction( 1, AddNextFlag, 56, 10, 12 )
	RegCurTrigger( 561 )


-----------------------------------送信给瑟安
	MISSCRIPT_MISSIONSCRIPT01_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000216")
	DefineMission( 60, MISSCRIPT_MISSIONSCRIPT01_LUA_000216, 57 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000217 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000217")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000217 )
	MisBeginCondition(HasRecord, 56)
	MisBeginCondition(NoRecord, 57)
	MisBeginCondition(NoMission, 57)
	MisBeginAction(AddMission, 57)
	MisBeginAction(GiveItem, 4115, 1, 4)
	MisCancelAction(ClearMission, 57  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000218 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000218")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000218)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000219 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000219")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000219)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给瑟安
	MISSCRIPT_MISSIONSCRIPT01_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000216")
	DefineMission( 61, MISSCRIPT_MISSIONSCRIPT01_LUA_000216, 57, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000220 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000220")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000220)
	MisResultCondition(NoRecord, 57)
	MisResultCondition(HasMission, 57)
	MisResultCondition(HasItem, 4115, 1)
	MisResultAction(TakeItem, 4115, 1)
	MisResultAction(ClearMission, 57)
	MisResultAction(SetRecord, 57)
	MisResultAction(AddExp, 200, 200)
	MisResultAction(GiveNpcMission1 ,6758)

-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 62, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 58 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000222 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000222")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000222)
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(TurnToJob, 1 )
	MisBeginCondition(NoRecord, 58)
	MisBeginCondition(NoRecord, 59)
	MisBeginCondition(NoRecord, 60)
	MisBeginCondition(NoRecord, 61)
	MisBeginCondition(NoMission, 58)
	MisBeginCondition(NoMission, 59)
	MisBeginCondition(NoMission, 60)
	MisBeginCondition(NoMission, 61)
	MisBeginAction(AddMission, 58)
	MisBeginAction(GiveItem, 4116, 1, 4)
	MisCancelAction(ClearMission, 58  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000223 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000223")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000223)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000224 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000224")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000224)
	MisResultCondition(AlwaysFailure )

-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 63, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 59 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000226 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000226")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000226 )
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(CheckConvertProfession, MIS_HUNTER )
	MisBeginCondition(NoRecord, 58)
	MisBeginCondition(NoRecord, 59)
	MisBeginCondition(NoRecord, 60)
	MisBeginCondition(NoRecord, 61)
	MisBeginCondition(NoMission, 58)
	MisBeginCondition(NoMission, 59)
	MisBeginCondition(NoMission, 60)
	MisBeginCondition(NoMission, 61)
	MisBeginAction(AddMission, 59)
	MisBeginAction(GiveItem, 4117, 1, 4)
	MisCancelAction(ClearMission, 59 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000227 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000227")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000227)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000228 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000228")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000228)
	MisResultCondition(AlwaysFailure )

-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 64, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 60 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000230 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000230")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000230 )
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(CheckConvertProfession, MIS_DOCTOR )
	MisBeginCondition(NoRecord, 58)
	MisBeginCondition(NoRecord, 59)
	MisBeginCondition(NoRecord, 60)
	MisBeginCondition(NoRecord, 61)
	MisBeginCondition(NoMission, 58)
	MisBeginCondition(NoMission, 59)
	MisBeginCondition(NoMission, 60)
	MisBeginCondition(NoMission, 61)
	MisBeginAction(AddMission, 60)
	MisBeginAction(GiveItem, 4118, 1, 4)
	MisCancelAction(ClearMission, 60 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000231 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000231")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000231)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000232")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000232)
	MisResultCondition(AlwaysFailure )

-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 65, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 61 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000234 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000234")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000234 )
	MisBeginCondition(LvCheck, ">", 8 )
	MisBeginCondition(PfEqual, 0 )
	MisBeginCondition(CheckConvertProfession, MIS_RISKER )
	MisBeginCondition(NoRecord, 58)
	MisBeginCondition(NoRecord, 59)
	MisBeginCondition(NoRecord, 60)
	MisBeginCondition(NoRecord, 61)
	MisBeginCondition(NoMission, 58)
	MisBeginCondition(NoMission, 59)
	MisBeginCondition(NoMission, 60)
	MisBeginCondition(NoMission, 61)
	MisBeginAction(AddMission, 61)
	MisBeginAction(GiveItem, 4119, 1, 4)
	MisCancelAction(ClearMission, 61 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000235 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000235")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000235)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000236 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000236")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000236)
	MisResultCondition(AlwaysFailure )


-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 66, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 58, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000237 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000237")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000237)
	MisResultCondition(NoRecord, 58)
	MisResultCondition(HasMission, 58)
	MisResultCondition(HasItem, 4116, 1)
	MisResultAction(TakeItem, 4116, 1)
	MisResultAction(ClearMission, 58)
	MisResultAction(SetRecord, 58)
	MisResultAction( SetProfession, 1  )
	MisResultAction( GiveItem, 3164, 1, 4 )
	MisResultAction( GiveItem, 1, 1, 4 )
	MisBeginBagNeed(2)
	MisResultAction(AddExp1)
	--MisResultAction(SetProfession,1)



-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 67, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 62 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000238 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000238")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000238 )
	MisBeginCondition(HasRecord, 58)
	MisBeginCondition(NoMission, 62)
	MisBeginCondition(NoRecord, 62)
	MisBeginAction(AddMission, 62)
	MisBeginAction(AddTrigger, 621, TE_KILL, 237, 12 )
	MisCancelAction(ClearMission, 62)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000239 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000239")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000239)
	MisNeed(MIS_NEED_KILL, 237, 12, 10, 12)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000240 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000240")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000240)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000241 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000241")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000241)
	MisResultCondition(HasMission, 62)
	MisResultCondition(HasFlag, 62, 21 )
	MisResultAction(ClearMission, 62)
	MisResultAction(SetRecord, 62)
	MisResultAction(AddExp, 300, 300)

		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 237 )	
	TriggerAction( 1, AddNextFlag, 62, 10, 12 )
	RegCurTrigger( 621 )


-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 68, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 63 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000242 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000242")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000242)
	MisBeginCondition(HasRecord, 62)
	MisBeginCondition(NoRecord, 63)
	MisBeginCondition(NoMission, 63)
	MisBeginAction(AddMission, 63)
	MisBeginAction(GiveItem, 4120, 1, 4)
	MisCancelAction(ClearMission, 63  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000243")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000243)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000244")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000244)
	MisResultCondition(AlwaysFailure )

-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 69, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 63, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000245 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000245")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000245)
	MisResultCondition(NoRecord, 63)
	MisResultCondition(HasMission, 63)
	MisResultCondition(HasItem, 4120, 1)
	MisResultAction(TakeItem, 4120, 1)
	MisResultAction(ClearMission, 63)
	MisResultAction(SetRecord, 63)
	MisResultAction(AddExp, 100, 100)

-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 70, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 64 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000246 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000246")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000246)
	MisBeginCondition(HasRecord, 63)
	MisBeginCondition(NoMission, 64)
	MisBeginCondition(NoRecord, 64)
	MisBeginAction(AddMission, 64)
	MisBeginAction(AddTrigger, 641, TE_GETITEM, 1678, 3 )
	MisCancelAction(ClearMission, 64)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000247 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000247")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000247)
	MisNeed(MIS_NEED_ITEM, 1678, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000248 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000248")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000248)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000249 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000249")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000249)
	MisResultCondition(HasMission, 64)
	MisResultCondition(HasItem, 1678, 3 )
	MisResultAction(TakeItem, 1678, 3)
	MisResultAction(ClearMission, 64)
	MisResultAction(SetRecord, 64)
	MisResultAction(AddExp, 300, 300)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1678 )	
	TriggerAction( 1, AddNextFlag, 64, 10, 3 )
	RegCurTrigger( 641 )

-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 71, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 65 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000250 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000250")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000250)
	MisBeginCondition(HasRecord, 64)
	MisBeginCondition(NoRecord, 65)
	MisBeginCondition(NoMission, 65)
	MisBeginAction(AddMission, 65)
	MisBeginAction(GiveItem, 3953, 1, 4)
	MisCancelAction(ClearMission, 65 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000251 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000251")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000251)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000252 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000252")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000252)
	MisResultCondition(AlwaysFailure )


-----------------------------------剑士转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000221")
	DefineMission( 72, MISSCRIPT_MISSIONSCRIPT01_LUA_000221, 65, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000253 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000253")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000253)
	MisResultCondition(NoRecord, 65)
	MisResultCondition(HasMission, 65)
	MisResultCondition(HasItem, 3953, 1)
	MisResultAction(TakeItem, 3953, 1)
	MisResultAction(ClearMission, 65)
	MisResultAction(SetRecord, 65)
	MisResultAction(AddExp, 100, 100)
	MisResultAction(SetProfession, 1)
	MisResultAction(GiveItem, 1, 1, 4)
	MisResultAction(GiveItem, 3164, 1, 4)
	MisResultBagNeed(2)

-----------------------------------送信给帝姆
	MISSCRIPT_MISSIONSCRIPT01_LUA_000186 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000186")
	DefineMission( 73, MISSCRIPT_MISSIONSCRIPT01_LUA_000186, 51, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000254 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000254")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000254)
	MisResultCondition(NoRecord, 51)
	MisResultCondition(HasMission, 51)
	MisResultCondition(HasItem, 4112, 1)
	MisResultAction(TakeItem, 4112, 1)
	MisResultAction(ClearMission, 51)
	MisResultAction(SetRecord, 51)
	MisResultAction(AddExp, 50, 50)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission,74,MISSCRIPT_MISSIONSCRIPT01_LUA_000190,12)


-----------------------------------灵感配方
	MISSCRIPT_MISSIONSCRIPT01_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000007")
	DefineMission( 74, MISSCRIPT_MISSIONSCRIPT01_LUA_000007, 66 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000255 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000255")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000255)
	MisBeginCondition(HasRecord, 51)
	MisBeginCondition(NoMission, 66)
	MisBeginCondition(NoRecord, 66)
	MisBeginAction(AddMission, 66)
	MisBeginAction(AddTrigger, 661, TE_GETITEM, 1705, 3 )
	MisCancelAction(ClearMission, 66)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000256 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000256")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000256)
	MisNeed(MIS_NEED_ITEM, 1705, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000009")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000009)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000257 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000257")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000257)
	MisResultCondition(HasMission, 66)
	MisResultCondition(HasItem, 1705, 3 )
	MisResultAction(TakeItem, 1705, 3)
	MisResultAction(ClearMission, 66)
	MisResultAction(SetRecord, 66)
	MisResultAction(AddExp, 250, 250)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission,75,MISSCRIPT_MISSIONSCRIPT01_LUA_000190,13)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1705 )	
	TriggerAction( 1, AddNextFlag, 66, 10, 3 )
	RegCurTrigger( 661 )

-----------------------------------送信给罗伊
	MISSCRIPT_MISSIONSCRIPT01_LUA_000258 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000258")
	DefineMission( 75, MISSCRIPT_MISSIONSCRIPT01_LUA_000258, 67 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000259 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000259")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000259)
	MisBeginCondition(HasRecord, 66)
	MisBeginCondition(NoRecord, 67)
	MisBeginCondition(NoMission, 67)
	MisBeginAction(AddMission, 67)
	MisBeginAction(GiveItem, 4121, 1, 4)
	MisCancelAction(ClearMission, 67 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000260 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000260")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000260)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000261 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000261")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000261)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给罗伊
	MISSCRIPT_MISSIONSCRIPT01_LUA_000258 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000258")
	DefineMission( 76, MISSCRIPT_MISSIONSCRIPT01_LUA_000258, 67, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000262 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000262")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000262)
	MisResultCondition(NoRecord, 67)
	MisResultCondition(HasMission, 67)
	MisResultCondition(HasItem, 4121, 1)
	MisResultAction(TakeItem, 4121, 1)
	MisResultAction(ClearMission, 67)
	MisResultAction(SetRecord, 67)
	MisResultAction(AddExp, 80, 80)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000263 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000263")
	MisResultAction(GiveNpcMission,77,MISSCRIPT_MISSIONSCRIPT01_LUA_000263,2)

-----------------------------------蘑菇蘑菇
	MISSCRIPT_MISSIONSCRIPT01_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000011")
	DefineMission( 77, MISSCRIPT_MISSIONSCRIPT01_LUA_000011, 68 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000264 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000264")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000264)
	MisBeginCondition(HasRecord, 67)
	MisBeginCondition(NoMission, 68)
	MisBeginCondition(NoRecord, 68)
	MisBeginAction(AddMission, 68)
	MisBeginAction(AddTrigger, 681, TE_GETITEM, 1725, 4 )
	MisCancelAction(ClearMission, 68)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000265 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000265")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000265)
	MisNeed(MIS_NEED_ITEM, 1725, 4, 10, 4)

	MisPrize(MIS_PRIZE_ITEM, 1848, 5, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000013")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000013)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000014")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000014)
	MisResultCondition(HasMission, 68)
	MisResultCondition(HasItem, 1725, 4 )
	MisResultAction(TakeItem, 1725, 4)
	MisResultAction(ClearMission, 68)
	MisResultAction(SetRecord, 68)
	MisResultAction(AddExp, 250, 250)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000263 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000263")
	MisResultAction(GiveNpcMission,78,MISSCRIPT_MISSIONSCRIPT01_LUA_000263,3)
	MisResultBagNeed(1)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1725 )	
	TriggerAction( 1, AddNextFlag, 68, 10, 4 )
	RegCurTrigger( 681 )

-----------------------------------送信给海云
	MISSCRIPT_MISSIONSCRIPT01_LUA_000266 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000266")
	DefineMission( 78, MISSCRIPT_MISSIONSCRIPT01_LUA_000266, 69 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000267 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000267")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000267)
	MisBeginCondition(HasRecord, 68)
	MisBeginCondition(NoRecord, 69)
	MisBeginCondition(NoMission, 69)
	MisBeginAction(AddMission, 69)
	MisBeginAction(GiveItem, 4122, 1, 4)
	MisCancelAction(ClearMission, 69 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000268 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000268")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000268)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000269 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000269")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000269)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给海云
	MISSCRIPT_MISSIONSCRIPT01_LUA_000266 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000266")
	DefineMission( 79, MISSCRIPT_MISSIONSCRIPT01_LUA_000266, 69, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000262 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000262")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000262)
	MisResultCondition(NoRecord, 69)
	MisResultCondition(HasMission, 69)
	MisResultCondition(HasItem, 4122, 1)
	MisResultAction(TakeItem, 4122, 1)
	MisResultAction(ClearMission, 69)
	MisResultAction(SetRecord, 69)
	MisResultAction(AddExp, 120, 120)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000270")
	MisResultAction(GiveNpcMission,80,MISSCRIPT_MISSIONSCRIPT01_LUA_000270,3)

-----------------------------------损失的货物
	MISSCRIPT_MISSIONSCRIPT01_LUA_000271 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000271")
	DefineMission( 80, MISSCRIPT_MISSIONSCRIPT01_LUA_000271, 70 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000272 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000272")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000272)
	MisBeginCondition(HasRecord, 69)
	MisBeginCondition(NoMission, 70)
	MisBeginCondition(NoRecord, 70)
	MisBeginAction(AddMission, 70)
	MisBeginAction(AddTrigger, 701, TE_GETITEM, 1844, 2 )
	MisCancelAction(ClearMission, 70)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000273 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000273")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000273)
	MisNeed(MIS_NEED_ITEM, 1844, 2, 10, 2)
	
	MisPrize(MIS_PRIZE_ITEM, 4310, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000274 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000274")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000274)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000275")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000275)
	MisResultCondition(HasMission, 70)
	MisResultCondition(HasItem, 1844, 2 )
	MisResultAction(TakeItem, 1844, 2)
	MisResultAction(ClearMission, 70)
	MisResultAction(SetRecord, 70)
	MisResultAction(AddExp, 400, 400)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000270")
	MisResultAction(GiveNpcMission,81,MISSCRIPT_MISSIONSCRIPT01_LUA_000270,4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1844 )	
	TriggerAction( 1, AddNextFlag, 70, 10, 2 )
	RegCurTrigger( 701 )

-----------------------------------送信给瑟安
	MISSCRIPT_MISSIONSCRIPT01_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000216")
	DefineMission( 81, MISSCRIPT_MISSIONSCRIPT01_LUA_000216, 71 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000276 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000276")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000276)
	MisBeginCondition(HasRecord, 70)
	MisBeginCondition(NoRecord, 71)
	MisBeginCondition(NoMission, 71)
	MisBeginAction(AddMission, 71)
	MisBeginAction(GiveItem, 4115, 1, 4)
	MisCancelAction(ClearMission, 71 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000277 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000277")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000277)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000219 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000219")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000219)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给瑟安
	MISSCRIPT_MISSIONSCRIPT01_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000216")
	DefineMission( 82, MISSCRIPT_MISSIONSCRIPT01_LUA_000216, 71, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000220 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000220")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000220)
	MisResultCondition(NoRecord, 71)
	MisResultCondition(HasMission, 71)
	MisResultCondition(HasItem, 4115, 1)
	MisResultAction(TakeItem, 4115, 1)
	MisResultAction(ClearMission, 71)
	MisResultAction(SetRecord, 71)
	MisResultAction(AddExp, 200, 200)

-----------------------------------送信给迈克
	MISSCRIPT_MISSIONSCRIPT01_LUA_000278 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000278")
	DefineMission( 83, MISSCRIPT_MISSIONSCRIPT01_LUA_000278, 72 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000279 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000279")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000279)
	MisBeginCondition(HasRecord, 710)
	MisBeginCondition(NoRecord, 72)
	MisBeginCondition(LvCheck, ">", 120 )
	MisBeginCondition(NoMission, 72)
	MisBeginAction(AddMission, 72)
	MisBeginAction(GiveItem, 4123, 1, 4)
	MisCancelAction(ClearMission, 72 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000280")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000280)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000281 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000281")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000281)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给艾墨
	MISSCRIPT_MISSIONSCRIPT01_LUA_000282 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000282")
	DefineMission( 84, MISSCRIPT_MISSIONSCRIPT01_LUA_000282, 73 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000283 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000283")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000283)
	MisBeginCondition(HasRecord, 710)
	MisBeginCondition(NoRecord, 73)
	MisBeginCondition(NoMission, 73)
	MisBeginAction(AddMission, 73)
	MisBeginAction(GiveItem, 4124, 1, 4)
	MisCancelAction(ClearMission, 73  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000284 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000284")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000284)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000285")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000285)
	MisResultCondition(AlwaysFailure )


-----------------------------------送信给迈克
	MISSCRIPT_MISSIONSCRIPT01_LUA_000278 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000278")
	DefineMission( 85, MISSCRIPT_MISSIONSCRIPT01_LUA_000278, 72, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000191")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000191)
	MisResultCondition(NoRecord, 72)
	MisResultCondition(HasMission, 72)
	MisResultCondition(HasItem, 4123, 1)
	MisResultAction(TakeItem, 4123, 1)
	MisResultAction(ClearMission, 72)
	MisResultAction(SetRecord, 72)
	MisResultAction(AddExp, 50, 50)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000286")
	MisResultAction(GiveNpcMission, 86, MISSCRIPT_MISSIONSCRIPT01_LUA_000286, 6) 

-----------------------------------抗击仙人掌
	MISSCRIPT_MISSIONSCRIPT01_LUA_000157 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000157")
	DefineMission( 86, MISSCRIPT_MISSIONSCRIPT01_LUA_000157, 74 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000287 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000287")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000287)
	MisBeginCondition(HasRecord, 72)
	MisBeginCondition(NoMission, 74)
	MisBeginCondition(NoRecord, 74)
	MisBeginAction(AddMission, 74)
	MisBeginAction(AddTrigger, 741, TE_KILL, 95, 6 )
	MisCancelAction(ClearMission, 74)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000288 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000288")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000288)
	MisNeed(MIS_NEED_KILL, 95, 6, 10, 6)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000159 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000159")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000159)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000289 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000289")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000289)
	MisResultCondition(HasMission, 74)
	MisResultCondition(HasFlag, 74, 15 )
	MisResultAction(AddExp, 150, 150)
	MisResultAction(ClearMission, 74)
	MisResultAction(SetRecord, 74)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000286")
	MisResultAction(GiveNpcMission, 87, MISSCRIPT_MISSIONSCRIPT01_LUA_000286, 7) 
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 95 )	
	TriggerAction( 1, AddNextFlag, 74, 10, 6 )
	RegCurTrigger( 741 )


-----------------------------------送信给鹧鸪草
	MISSCRIPT_MISSIONSCRIPT01_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000290")
	DefineMission( 87, MISSCRIPT_MISSIONSCRIPT01_LUA_000290, 75 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000291 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000291")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000291)
	MisBeginCondition(HasRecord, 74)
	MisBeginCondition(NoRecord, 75)
	MisBeginCondition(NoMission, 75)
	MisBeginAction(AddMission, 75)
	MisBeginAction(GiveItem, 4125, 1, 4)
	MisCancelAction(ClearMission, 75  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000292 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000292")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000292)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000293 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000293")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000293)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给鹧鸪草
	MISSCRIPT_MISSIONSCRIPT01_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000290")
	DefineMission( 88, MISSCRIPT_MISSIONSCRIPT01_LUA_000290, 75, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000294 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000294")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000294)
	MisResultCondition(NoRecord, 75)
	MisResultCondition(HasMission, 75)
	MisResultCondition(HasItem, 4125, 1)
	MisResultAction(TakeItem, 4125, 1)
	MisResultAction(ClearMission, 75)
	MisResultAction(SetRecord, 75)
	MisResultAction(AddExp, 80, 80)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000295")
	MisResultAction(GiveNpcMission, 89, MISSCRIPT_MISSIONSCRIPT01_LUA_000295, 8) 	
-----------------------------------踢人怪兽
	MISSCRIPT_MISSIONSCRIPT01_LUA_000161 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000161")
	DefineMission( 89, MISSCRIPT_MISSIONSCRIPT01_LUA_000161, 76 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000296 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000296")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000296)
	MisBeginCondition(HasRecord, 75)
	MisBeginCondition(NoMission, 76)
	MisBeginCondition(NoRecord, 76)
	MisBeginAction(AddMission, 76)
	MisBeginAction(AddTrigger, 761, TE_KILL, 48, 8 )
	MisCancelAction(ClearMission, 76)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000297 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000297")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000297)
	MisNeed(MIS_NEED_KILL, 48, 8, 10, 8)

	MisPrize(MIS_PRIZE_ITEM, 1848, 5, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000163 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000163")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000163)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000164 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000164")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000164)
	MisResultCondition(HasMission, 76)
	MisResultCondition(HasFlag, 76, 17 )
	MisResultAction(AddExp, 250, 250)
	MisResultAction(ClearMission, 76)
	MisResultAction(SetRecord, 76)
	MisResultBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000295")
	MisResultAction(GiveNpcMission, 90, MISSCRIPT_MISSIONSCRIPT01_LUA_000295, 9) 	
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 48 )	
	TriggerAction( 1, AddNextFlag, 76, 10, 8 )
	RegCurTrigger( 761 )

-----------------------------------送信给铜铜鼓
	MISSCRIPT_MISSIONSCRIPT01_LUA_000298 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000298")
	DefineMission( 90, MISSCRIPT_MISSIONSCRIPT01_LUA_000298, 77 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000299 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000299")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000299 )
	MisBeginCondition(HasRecord, 76)
	MisBeginCondition(NoRecord, 77)
	MisBeginCondition(NoMission, 77)
	MisBeginAction(AddMission, 77)
	MisBeginAction(GiveItem, 4126, 1, 4)
	MisCancelAction(ClearMission, 77  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000300")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000300)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000301 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000301")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000301)
	MisResultCondition(AlwaysFailure )


-----------------------------------送信给铜铜鼓
	MISSCRIPT_MISSIONSCRIPT01_LUA_000298 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000298")
	DefineMission( 91, MISSCRIPT_MISSIONSCRIPT01_LUA_000298, 77, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000302 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000302")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000302)
	MisResultCondition(NoRecord, 77)
	MisResultCondition(HasMission, 77)
	MisResultCondition(HasItem, 4126, 1)
	MisResultAction(TakeItem, 4126, 1)
	MisResultAction(ClearMission, 77)
	MisResultAction(SetRecord, 77)
	MisResultAction(AddExp, 120, 120)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000303 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000303")
	MisResultAction(GiveNpcMission, 92, MISSCRIPT_MISSIONSCRIPT01_LUA_000303, 7) 	

-----------------------------------惧蝎证
	MISSCRIPT_MISSIONSCRIPT01_LUA_000304 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000304")
	DefineMission( 92, MISSCRIPT_MISSIONSCRIPT01_LUA_000304, 78 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000305")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000305)
	MisBeginCondition(HasRecord, 77)
	MisBeginCondition(NoMission, 78)
	MisBeginCondition(NoRecord, 78)
	MisBeginAction(AddMission, 78)
	MisBeginAction(AddTrigger, 781, TE_KILL, 247, 10 )
	MisCancelAction(ClearMission, 78)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000306 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000306")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000306)
	MisNeed(MIS_NEED_KILL, 247, 10, 10, 10)

	MisPrize(MIS_PRIZE_ITEM, 4309, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000307 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000307")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000307)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000168 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000168")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000168)
	MisResultCondition(HasMission, 78)
	MisResultCondition(HasFlag, 78, 19 )
	MisResultAction(ClearMission, 78)
	MisResultAction(AddExp, 400, 400)
	MisResultAction(SetRecord, 78)
	MisResultBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000303 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000303")
	MisResultAction(GiveNpcMission, 93, MISSCRIPT_MISSIONSCRIPT01_LUA_000303, 8) 	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 247 )	
	TriggerAction( 1, AddNextFlag, 78, 10, 10 )
	RegCurTrigger( 781 )


-----------------------------------送信给拉碧丝
	MISSCRIPT_MISSIONSCRIPT01_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000308")
	DefineMission( 93, MISSCRIPT_MISSIONSCRIPT01_LUA_000308, 79 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000309 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000309")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000309 )
	MisBeginCondition(HasRecord, 78)
	MisBeginCondition(NoRecord, 79)
	MisBeginCondition(NoMission, 79)
	MisBeginAction(AddMission, 79)
	MisBeginAction(GiveItem, 4127, 1, 4)
	MisCancelAction(ClearMission, 79  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000310")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000310)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000311 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000311")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000311)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给拉碧丝
	MISSCRIPT_MISSIONSCRIPT01_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000308")
	DefineMission( 94, MISSCRIPT_MISSIONSCRIPT01_LUA_000308, 79, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000312 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000312")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000312)
	MisResultCondition(NoRecord, 79)
	MisResultCondition(HasMission, 79)
	MisResultCondition(HasItem, 4127, 1)
	MisResultAction(TakeItem, 4127, 1)
	MisResultAction(ClearMission, 79)
	MisResultAction(SetRecord, 79)
	MisResultAction(AddExp, 200, 200)
	


-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 95, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 60, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000313 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000313")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000313)
	MisResultCondition(NoRecord, 60)
	MisResultCondition(HasMission, 60)
	MisResultCondition(HasItem, 4118, 1)
	MisBeginBagNeed(2)
	MisResultAction(TakeItem, 4118, 1)
	MisResultAction(ClearMission, 60)
	MisResultAction(SetRecord, 60)
	MisResultAction( SetProfession, 5  )
	MisResultAction( GiveItem, 3206, 1, 4 )
	MisResultAction( GiveItem, 97, 1, 4 )
	MisResultAction(AddExp1)

-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 96, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 80 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000314 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000314")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000314 )
	MisBeginCondition(HasRecord, 60)
	MisBeginCondition(NoMission, 80)
	MisBeginCondition(NoRecord, 80)
	MisBeginAction(AddMission, 80)
	MisBeginAction(AddTrigger, 801, TE_KILL, 247, 4 )
	MisCancelAction(ClearMission, 80)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000315")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000315)
	MisNeed(MIS_NEED_KILL, 43, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000316 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000316")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000316)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000317 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000317")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000317)
	MisResultCondition(HasMission, 80)
	MisResultCondition(HasFlag, 80, 11 )
	MisResultAction(ClearMission, 80)
	MisResultAction(SetRecord, 80)
	MisResultAction(AddExp, 300, 300)

		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 43 )	
	TriggerAction( 1, AddNextFlag, 80, 10, 2 )
	RegCurTrigger( 801 )


-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 97, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 81 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000318 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000318")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000318)
	MisBeginCondition(HasRecord, 80)
	MisBeginCondition(NoRecord, 81)
	MisBeginCondition(NoMission, 81)
	MisBeginAction(AddMission, 81)
	MisBeginAction(GiveItem, 4128, 1, 4)
	MisCancelAction(ClearMission, 81  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000319 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000319")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000319)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000244")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000244)
	MisResultCondition(AlwaysFailure )

-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 98, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 81, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000320")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000320)
	MisResultCondition(NoRecord, 81)
	MisResultCondition(HasMission, 81)
	MisResultCondition(HasItem, 4128, 1)
	MisResultAction(TakeItem, 4128, 1)
	MisResultAction(ClearMission, 81)
	MisResultAction(SetRecord, 81)
	MisResultAction(AddExp, 100, 100)

-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 99, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 82 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000321 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000321")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000321)
	MisBeginCondition(HasRecord, 81)
	MisBeginCondition(NoMission, 82)
	MisBeginCondition(NoRecord, 82)
	MisBeginAction(AddMission, 82)
	MisBeginAction(AddTrigger, 821, TE_GETITEM, 3129, 3 )
	MisCancelAction(ClearMission, 82)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000322 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000322")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000322)
	MisNeed(MIS_NEED_ITEM, 3129, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000323 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000323")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000323)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000324 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000324")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000324)
	MisResultCondition(HasMission, 82)
	MisResultCondition(HasItem, 3129, 3 )
	MisResultAction(TakeItem, 3129, 3)
	MisResultAction(ClearMission, 82)
	MisResultAction(SetRecord, 82)
	MisResultAction(AddExp, 300, 300)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3129 )	
	TriggerAction( 1, AddNextFlag, 82, 10, 3 )
	RegCurTrigger( 821 )

-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 150, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 83 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000325")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000325)
	MisBeginCondition(HasRecord, 82)
	MisBeginCondition(NoRecord, 83)
	MisBeginCondition(NoMission, 83)
	MisBeginAction(AddMission, 83)
	MisBeginAction(GiveItem, 3954, 1, 4)
	MisCancelAction(ClearMission, 83 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000326 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000326")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000326)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000327 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000327")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000327)
	MisResultCondition(AlwaysFailure )


-----------------------------------药师转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000229")
	DefineMission( 151, MISSCRIPT_MISSIONSCRIPT01_LUA_000229, 83, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000328 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000328")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000328)
	MisResultCondition(NoRecord, 83)
	MisResultCondition(HasMission, 83)
	MisResultCondition(HasItem, 3954, 1)
	MisResultAction(TakeItem, 3954, 1)
	MisResultAction(ClearMission, 83)
	MisResultAction(SetRecord, 83)
	MisResultAction(AddExp, 100, 100)
	MisResultAction(SetProfession, 5)
	MisResultAction(GiveItem, 3206, 1, 4)
	MisResultAction(GiveItem, 97, 1, 4)
	MisResultBagNeed(2)


-----------------------------------送信给艾墨
	MISSCRIPT_MISSIONSCRIPT01_LUA_000282 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000282")
	DefineMission( 152, MISSCRIPT_MISSIONSCRIPT01_LUA_000282, 73, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000254 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000254")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000254)
	MisResultCondition(NoRecord, 73)
	MisResultCondition(HasMission, 73)
	MisResultCondition(HasItem, 4124, 1)
	MisResultAction(TakeItem, 4124, 1)
	MisResultAction(ClearMission, 73)
	MisResultAction(SetRecord, 73)
	MisResultAction(AddExp, 50, 50)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000329 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000329")
	MisResultAction(GiveNpcMission, 153, MISSCRIPT_MISSIONSCRIPT01_LUA_000329, 3)


-----------------------------------嫁接实验
	MISSCRIPT_MISSIONSCRIPT01_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000330")
	DefineMission( 153, MISSCRIPT_MISSIONSCRIPT01_LUA_000330, 84 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000331 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000331")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000331)
	MisBeginCondition(HasRecord, 73)
	MisBeginCondition(NoMission, 84)
	MisBeginCondition(NoRecord, 84)
	MisBeginAction(AddMission, 84)
	MisBeginAction(AddTrigger, 841, TE_GETITEM, 1691, 3 )
	MisCancelAction(ClearMission, 84)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000332 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000332")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000332)
	MisNeed(MIS_NEED_ITEM, 1691, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000147")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000147)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000333 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000333")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000333)
	MisResultCondition(HasMission, 84)
	MisResultCondition(HasItem, 1691, 3 )
	MisResultAction(TakeItem, 1691, 3)
	MisResultAction(ClearMission, 84)
	MisResultAction(SetRecord, 84)
	MisResultAction(AddExp, 150, 150)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000329 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000329")
	MisResultAction(GiveNpcMission, 154, MISSCRIPT_MISSIONSCRIPT01_LUA_000329, 4) 
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1691 )	
	TriggerAction( 1, AddNextFlag, 84, 10, 3 )
	RegCurTrigger( 841 )

-----------------------------------送信给莉娜
	MISSCRIPT_MISSIONSCRIPT01_LUA_000334 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000334")
	DefineMission( 154, MISSCRIPT_MISSIONSCRIPT01_LUA_000334, 85 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000335")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000335)
	MisBeginCondition(HasRecord, 84)
	MisBeginCondition(NoRecord, 85)
	MisBeginCondition(NoMission, 85)
	MisBeginAction(AddMission, 85)
	MisBeginAction(GiveItem, 4129, 1, 4)
	MisCancelAction(ClearMission, 85 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000336 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000336")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000336)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000337 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000337")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000337)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给莉娜
	MISSCRIPT_MISSIONSCRIPT01_LUA_000334 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000334")
	DefineMission( 155, MISSCRIPT_MISSIONSCRIPT01_LUA_000334, 85, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000338 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000338")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000338)
	MisResultCondition(NoRecord, 85)
	MisResultCondition(HasMission, 85)
	MisResultCondition(HasItem, 4129, 1)
	MisResultAction(TakeItem, 4129, 1)
	MisResultAction(ClearMission, 85)
	MisResultAction(SetRecord, 85)
	MisResultAction(AddExp, 80, 80)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000339 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000339")
	MisResultAction(GiveNpcMission, 156, MISSCRIPT_MISSIONSCRIPT01_LUA_000339, 3) 

-----------------------------------伪造物品
	MISSCRIPT_MISSIONSCRIPT01_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000340")
	DefineMission( 156, MISSCRIPT_MISSIONSCRIPT01_LUA_000340, 86 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000341 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000341")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000341)
	MisBeginCondition(HasRecord, 85)
	MisBeginCondition(NoMission, 86)
	MisBeginCondition(NoRecord, 86)
	MisBeginAction(AddMission, 86)
	MisBeginAction(AddTrigger, 861, TE_GETITEM, 1648, 3 )
	MisCancelAction(ClearMission, 86)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000342 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000342")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000342)
	MisNeed(MIS_NEED_ITEM, 1648, 3, 10, 3)

	MisPrize(MIS_PRIZE_ITEM, 1848, 5, 4)
	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT01_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000151")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000151)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000152")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000152)
	MisResultCondition(HasMission, 86)
	MisResultCondition(HasItem, 1648, 3 )
	MisResultAction(TakeItem, 1648, 3)
	MisResultAction(ClearMission, 86)
	MisResultAction(SetRecord, 86)
	MisResultAction(AddExp, 250, 250)
	MisResultBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000339 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000339")
	MisResultAction(GiveNpcMission, 157, MISSCRIPT_MISSIONSCRIPT01_LUA_000339, 4) 

	InitTrigger()
	TriggerCondition( 1, IsItem, 1648 )	
	TriggerAction( 1, AddNextFlag, 86, 10, 3 )
	RegCurTrigger( 861 )

-----------------------------------送信给弗兰克
	MISSCRIPT_MISSIONSCRIPT01_LUA_000343 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000343")
	DefineMission( 157, MISSCRIPT_MISSIONSCRIPT01_LUA_000343, 87 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000344 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000344")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000344)
	MisBeginCondition(HasRecord, 86)
	MisBeginCondition(NoRecord, 87)
	MisBeginCondition(NoMission, 87)
	MisBeginAction(AddMission, 87)
	MisBeginAction(GiveItem, 4130, 1, 4)
	MisCancelAction(ClearMission, 87 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000345")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000345)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000346 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000346")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000346)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给弗兰克
	MISSCRIPT_MISSIONSCRIPT01_LUA_000343 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000343")
	DefineMission( 158, MISSCRIPT_MISSIONSCRIPT01_LUA_000343, 87, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000347 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000347")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000347)
	MisResultCondition(NoRecord, 87)
	MisResultCondition(HasMission, 87)
	MisResultCondition(HasItem, 4130, 1)
	MisResultAction(TakeItem, 4130, 1)
	MisResultAction(ClearMission, 87)
	MisResultAction(SetRecord, 87)
	MisResultAction(AddExp, 120, 120)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000348 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000348")
	MisResultAction(GiveNpcMission, 159, MISSCRIPT_MISSIONSCRIPT01_LUA_000348, 3) 

-----------------------------------晕船药
	MISSCRIPT_MISSIONSCRIPT01_LUA_000349 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000349")
	DefineMission( 159, MISSCRIPT_MISSIONSCRIPT01_LUA_000349, 88 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000350")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000350)
	MisBeginCondition(HasRecord, 87)
	MisBeginCondition(NoMission, 88)
	MisBeginCondition(NoRecord, 88)
	MisBeginAction(AddMission, 88)
	MisBeginAction(AddTrigger, 881, TE_GETITEM, 1692, 3 )
	MisCancelAction(ClearMission, 88)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000351 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000351")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000351)
	MisNeed(MIS_NEED_ITEM, 1692, 3, 10, 3)

	MisPrize(MIS_PRIZE_ITEM, 4310, 1, 4)
	MisPrizeSelAll()	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000155 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000155")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000155)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000156 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000156")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000156)
	MisResultCondition(HasMission, 88)
	MisResultCondition(HasItem, 1692, 3 )
	MisResultAction(TakeItem, 1692, 3)
	MisResultAction(ClearMission, 88)
	MisResultAction(SetRecord, 88)
	MisResultAction(AddExp, 400, 400)
	MisResultBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000348 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000348")
	MisResultAction(GiveNpcMission, 160, MISSCRIPT_MISSIONSCRIPT01_LUA_000348, 4) 
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1692 )	
	TriggerAction( 1, AddNextFlag, 88, 10, 3 )
	RegCurTrigger( 881 )

-----------------------------------送信给拉碧丝
	MISSCRIPT_MISSIONSCRIPT01_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000308")
	DefineMission( 160, MISSCRIPT_MISSIONSCRIPT01_LUA_000308, 89 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000352 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000352")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000352)
	MisBeginCondition(HasRecord, 88)
	MisBeginCondition(NoRecord, 89)
	MisBeginCondition(NoMission, 89)
	MisBeginAction(AddMission, 89)
	MisBeginAction(GiveItem, 4127, 1, 4)
	MisCancelAction(ClearMission, 89 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000310")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000310)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000311 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000311")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000311)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给拉碧丝
	MISSCRIPT_MISSIONSCRIPT01_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000308")
	DefineMission( 161, MISSCRIPT_MISSIONSCRIPT01_LUA_000308, 89, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000312 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000312")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000312)
	MisResultCondition(NoRecord, 89)
	MisResultCondition(HasMission, 89)
	MisResultCondition(HasItem, 4127, 1)
	MisResultAction(TakeItem, 4127, 1)
	MisResultAction(ClearMission, 89)
	MisResultAction(SetRecord, 89)
	MisResultAction(AddExp, 800, 800)
	MisResultAction(GiveNpcMission1 ,6758)
	
 


---------------------------------送信给小莫
	MISSCRIPT_MISSIONSCRIPT01_LUA_000353 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000353")
	DefineMission( 162, MISSCRIPT_MISSIONSCRIPT01_LUA_000353, 90 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000354 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000354")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000354)
	MisBeginCondition(HasRecord, 716)
	MisBeginCondition(NoRecord, 90)
	MisBeginCondition(NoMission, 90)
	MisBeginAction(AddMission, 90)
	MisBeginAction(GiveItem, 4131, 1, 4)
	MisCancelAction(ClearMission, 90 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000355")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000355)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000356 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000356")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000356)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给伯鲁
	MISSCRIPT_MISSIONSCRIPT01_LUA_000357 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000357")
	DefineMission( 163, MISSCRIPT_MISSIONSCRIPT01_LUA_000357, 91 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000358 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000358")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000358)
	MisBeginCondition(HasRecord, 716)
	MisBeginCondition(LvCheck, ">", 120 )
	MisBeginCondition(NoRecord, 91)
	MisBeginCondition(NoMission, 91)
	MisBeginAction(AddMission, 91)
	MisBeginAction(GiveItem, 4132, 1, 4)
	MisCancelAction(ClearMission, 91  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000359 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000359")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000359)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000360")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000360)
	MisResultCondition(AlwaysFailure )


-----------------------------------送信给小莫
	MISSCRIPT_MISSIONSCRIPT01_LUA_000353 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000353")
	DefineMission( 164, MISSCRIPT_MISSIONSCRIPT01_LUA_000353, 90, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000191")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000191)
	MisResultCondition(NoRecord, 90)
	MisResultCondition(HasMission, 90)
	MisResultCondition(HasItem, 4131, 1)
	MisResultAction(TakeItem, 4131, 1)
	MisResultAction(ClearMission, 90)
	MisResultAction(SetRecord, 90)
	MisResultAction(AddExp, 50, 50)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000361 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000361")
	MisResultAction(GiveNpcMission, 165, MISSCRIPT_MISSIONSCRIPT01_LUA_000361, 5) 

-----------------------------------顽皮帕帕
	MISSCRIPT_MISSIONSCRIPT01_LUA_000169 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000169")
	DefineMission( 165, MISSCRIPT_MISSIONSCRIPT01_LUA_000169, 92 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000362 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000362")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000362)
	MisBeginCondition(HasRecord, 90)
	MisBeginCondition(NoMission, 92)
	MisBeginCondition(NoRecord, 92)
	MisBeginAction(AddMission, 92)
	MisBeginAction(AddTrigger, 921, TE_KILL, 235, 6 )
	MisCancelAction(ClearMission, 92)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000363 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000363")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000363)
	MisNeed(MIS_NEED_KILL, 235, 6, 10, 6)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000171 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000171")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000171)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000172")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000172)
	MisResultCondition(HasMission, 92)
	MisResultCondition(HasFlag, 92, 15 )
	MisResultAction(AddExp, 150, 150)
	MisResultAction(ClearMission, 92)
	MisResultAction(SetRecord, 92)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000361 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000361")
	MisResultAction(GiveNpcMission, 166, MISSCRIPT_MISSIONSCRIPT01_LUA_000361, 6) 
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 235 )	
	TriggerAction( 1, AddNextFlag, 92, 10, 6 )
	RegCurTrigger( 921 )

-----------------------------------送信给雷欧
	MISSCRIPT_MISSIONSCRIPT01_LUA_000364 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000364")
	DefineMission( 166, MISSCRIPT_MISSIONSCRIPT01_LUA_000364, 93 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000365")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000365)
	MisBeginCondition(HasRecord, 92)
	MisBeginCondition(NoRecord, 93)
	MisBeginCondition(NoMission, 93)
	MisBeginAction(AddMission, 93)
	MisBeginAction(GiveItem, 4133, 1, 4)
	MisCancelAction(ClearMission, 93  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000227 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000227")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000227)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000366 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000366")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000366)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给雷欧
	MISSCRIPT_MISSIONSCRIPT01_LUA_000364 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000364")
	DefineMission( 167, MISSCRIPT_MISSIONSCRIPT01_LUA_000364, 93, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000367 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000367")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000367)
	MisResultCondition(NoRecord, 93)
	MisResultCondition(HasMission, 93)
	MisResultCondition(HasItem, 4133, 1)
	MisResultAction(TakeItem, 4133, 1)
	MisResultAction(ClearMission, 93)
	MisResultAction(SetRecord, 93)
	MisResultAction(AddExp, 80, 80)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000368")
	MisResultAction(GiveNpcMission, 168, MISSCRIPT_MISSIONSCRIPT01_LUA_000368, 8) 
	

-----------------------------------猪口夺粮
	MISSCRIPT_MISSIONSCRIPT01_LUA_000173 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000173")
	DefineMission( 168, MISSCRIPT_MISSIONSCRIPT01_LUA_000173, 94 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000369 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000369")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000369)
	MisBeginCondition(HasRecord, 93)
	MisBeginCondition(NoMission, 94)
	MisBeginCondition(NoRecord, 94)
	MisBeginAction(AddMission, 94)
	MisBeginAction(AddTrigger, 941, TE_KILL, 239, 8 )
	MisCancelAction(ClearMission, 94)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000370 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000370")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000370)
	MisNeed(MIS_NEED_KILL, 239, 8, 10, 8)

	MisPrize(MIS_PRIZE_ITEM, 1848, 5, 4)
	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT01_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000175")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000175)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000176 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000176")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000176)
	MisResultCondition(HasMission, 94)
	MisResultCondition(HasFlag, 94, 17 )
	MisResultAction(AddExp, 250, 250)
	MisResultAction(ClearMission, 94)
	MisResultAction(SetRecord, 94)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000368")
	MisResultAction(GiveNpcMission, 169, MISSCRIPT_MISSIONSCRIPT01_LUA_000368, 9) 
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 239 )	
	TriggerAction( 1, AddNextFlag, 94, 10, 8 )
	RegCurTrigger( 941 )

-----------------------------------送信给翰娜
	MISSCRIPT_MISSIONSCRIPT01_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000371")
	DefineMission( 169, MISSCRIPT_MISSIONSCRIPT01_LUA_000371, 95 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000372 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000372")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000372 )
	MisBeginCondition(HasRecord, 94)
	MisBeginCondition(NoRecord, 95)
	MisBeginCondition(NoMission, 95)
	MisBeginAction(AddMission, 95)
	MisBeginAction(GiveItem, 4134, 1, 4)
	MisCancelAction(ClearMission, 95  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000373 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000373")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000373)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000374 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000374")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000374)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给翰娜
	MISSCRIPT_MISSIONSCRIPT01_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000371")
	DefineMission( 170, MISSCRIPT_MISSIONSCRIPT01_LUA_000371, 95, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000375 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000375")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000375)
	MisResultCondition(NoRecord, 95)
	MisResultCondition(HasMission, 95)
	MisResultCondition(HasItem, 4134, 1)
	MisResultAction(TakeItem, 4134, 1)
	MisResultAction(ClearMission, 95)
	MisResultAction(SetRecord, 95)
	MisResultAction(AddExp, 120, 120)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000376 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000376")
	MisResultAction(GiveNpcMission, 171, MISSCRIPT_MISSIONSCRIPT01_LUA_000376, 3) 

-----------------------------------错误迁移
	MISSCRIPT_MISSIONSCRIPT01_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000177")
	DefineMission( 171, MISSCRIPT_MISSIONSCRIPT01_LUA_000177, 96 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000377 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000377")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000377)
	MisBeginCondition(HasRecord, 95)
	MisBeginCondition(NoMission, 96)
	MisBeginCondition(NoRecord, 96)
	MisBeginAction(AddMission, 96)
	MisBeginAction(AddTrigger, 961, TE_KILL, 238, 12 )
	MisCancelAction(ClearMission, 56)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000378 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000378")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000378)
	MisNeed(MIS_NEED_KILL, 238, 12, 10, 12)

	MisPrize(MIS_PRIZE_ITEM, 4309, 1, 4)
	MisPrizeSelAll()
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000379 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000379")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000379)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000380 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000380")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000380)
	MisResultCondition(HasMission, 96)
	MisResultCondition(HasFlag, 96, 21 )
	MisResultAction(ClearMission, 96)
	MisResultAction(AddExp, 400, 400)
	MisResultAction(SetRecord, 96)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000376 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000376")
	MisResultAction(GiveNpcMission, 172, MISSCRIPT_MISSIONSCRIPT01_LUA_000376, 4) 
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 238 )	
	TriggerAction( 1, AddNextFlag, 96, 10, 12 )
	RegCurTrigger( 961 )


-----------------------------------送信给安琪露
	MISSCRIPT_MISSIONSCRIPT01_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000381")
	DefineMission( 172, MISSCRIPT_MISSIONSCRIPT01_LUA_000381, 97 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000382 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000382")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000382)
	MisBeginCondition(HasRecord, 96)
	MisBeginCondition(NoRecord, 97)
	MisBeginCondition(NoMission, 97)
	MisBeginAction(AddMission, 97)
	MisBeginAction(GiveItem, 4135, 1, 4)
	MisCancelAction(ClearMission, 97  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000383 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000383")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000383)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000384 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000384")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000384)
	MisResultCondition(AlwaysFailure )


-----------------------------------送信给安琪露
	MISSCRIPT_MISSIONSCRIPT01_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000381")
	DefineMission( 173, MISSCRIPT_MISSIONSCRIPT01_LUA_000381, 97, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000385 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000385")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000385)
	MisResultCondition(NoRecord, 97)
	MisResultCondition(HasMission, 97)
	MisResultCondition(HasItem, 4135, 1)
	MisResultAction(TakeItem, 4135, 1)
	MisResultAction(ClearMission, 97)
	MisResultAction(SetRecord, 97)
	MisResultAction(AddExp, 200, 200)
	MisResultAction(GiveNpcMission1 ,6758)
-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 174, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 59, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000386 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000386")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000386)
	MisResultCondition(NoRecord, 59)
	MisResultCondition(HasMission, 59)
	MisResultCondition(HasItem, 4117, 1)
	MisResultAction(TakeItem, 4117, 1)
	MisResultAction(ClearMission, 59)
	MisResultAction(SetRecord, 59)
	MisResultAction( SetProfession, 2  )
	MisResultAction( GiveItem, 3187, 1, 4 )
	MisResultAction( GiveItem, 25, 1, 4 )
	MisBeginBagNeed(2)
	MisResultAction(AddExp1)

-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 175, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 98 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000387 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000387")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000387)
	MisBeginCondition(HasRecord, 59)
	MisBeginCondition(NoMission, 98)
	MisBeginCondition(NoRecord, 98)
	MisBeginAction(AddMission, 98)
	MisBeginAction(AddTrigger, 981, TE_KILL, 240, 12 )
	MisCancelAction(ClearMission, 98)
	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000388 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000388")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000388)
	MisNeed(MIS_NEED_KILL, 240, 12, 10, 12)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000389 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000389")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000389)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000390 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000390")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000390)
	MisResultCondition(HasMission, 98)
	MisResultCondition(HasFlag, 98, 21 )
	MisResultAction(ClearMission, 98)
	MisResultAction(SetRecord, 98)
	MisResultAction(AddExp, 300, 300)

		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 240 )	
	TriggerAction( 1, AddNextFlag, 98, 10, 12 )
	RegCurTrigger( 981 )


-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 176, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 99 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000391 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000391")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000391)
	MisBeginCondition(HasRecord, 98)
	MisBeginCondition(NoRecord, 99)
	MisBeginCondition(NoMission, 99)
	MisBeginAction(AddMission, 99)
	MisBeginAction(GiveItem, 4136, 1, 4)
	MisCancelAction(ClearMission, 99  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000392 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000392")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000392)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000356 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000356")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000356)
	MisResultCondition(AlwaysFailure )

-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 177, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 99, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000393 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000393")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000393)
	MisResultCondition(NoRecord, 99)
	MisResultCondition(HasMission, 99)
	MisResultCondition(HasItem, 4136, 1)
	MisResultAction(TakeItem, 4136, 1)
	MisResultAction(ClearMission, 99)
	MisResultAction(SetRecord, 99)
	MisResultAction(AddExp, 100, 100)

-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 178, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 150 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000394 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000394")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000394)
	MisBeginCondition(HasRecord, 99)
	MisBeginCondition(NoMission, 150)
	MisBeginCondition(NoRecord, 150)
	MisBeginAction(AddMission, 150)
	MisBeginAction(AddTrigger, 1501, TE_GETITEM, 1779, 3 )
	MisCancelAction(ClearMission, 150)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000395 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000395")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000395)
	MisNeed(MIS_NEED_ITEM, 1779, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000248 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000248")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000248)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000396 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000396")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000396)
	MisResultCondition(HasMission, 150)
	MisResultCondition(HasItem, 1779, 3 )
	MisResultAction(TakeItem, 1779, 3)
	MisResultAction(ClearMission, 150)
	MisResultAction(SetRecord, 150)
	MisResultAction(AddExp, 300, 300)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1779 )	
	TriggerAction( 1, AddNextFlag, 150, 10, 3 )
	RegCurTrigger( 1501 )

-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 179, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 151 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000397 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000397")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000397)
	MisBeginCondition(HasRecord, 150)
	MisBeginCondition(NoRecord, 151)
	MisBeginCondition(NoMission, 151)
	MisBeginAction(AddMission, 151)
	MisBeginAction(GiveItem, 3955, 1, 4)
	MisCancelAction(ClearMission, 151 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000398 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000398")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000398)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000327 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000327")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000327)
	MisResultCondition(AlwaysFailure )


-----------------------------------猎人转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000225")
	DefineMission( 180, MISSCRIPT_MISSIONSCRIPT01_LUA_000225, 151, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000399 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000399")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000399)
	MisResultCondition(NoRecord, 151)
	MisResultCondition(HasMission, 151)
	MisResultCondition(HasItem, 3955, 1)
	MisResultCondition(PfEqual, 0 )
	MisResultAction(TakeItem, 3955, 1)
	MisResultAction(ClearMission, 151)
	MisResultAction(SetRecord, 151)
	MisResultAction(AddExp, 100, 100)
	MisResultAction(SetProfession, 2)
	MisResultAction(GiveItem, 3187, 1, 4)
	MisResultAction(GiveItem, 25, 1, 4)
	MisResultBagNeed(2)


-----------------------------------送信给伯鲁
	MISSCRIPT_MISSIONSCRIPT01_LUA_000357 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000357")
	DefineMission( 181, MISSCRIPT_MISSIONSCRIPT01_LUA_000357, 91, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000254 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000254")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000254)
	MisResultCondition(NoRecord, 91)
	MisResultCondition(HasMission, 91)
	MisResultCondition(HasItem, 4132, 1)
	MisResultAction(TakeItem, 4132, 1)
	MisResultAction(ClearMission, 91)
	MisResultAction(SetRecord, 91)
	MisResultAction(AddExp, 50, 50)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000400 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000400")
	MisResultAction(GiveNpcMission, 182, MISSCRIPT_MISSIONSCRIPT01_LUA_000400, 6) 
	

-----------------------------------收集触手
	MISSCRIPT_MISSIONSCRIPT01_LUA_000401 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000401")
	DefineMission( 182, MISSCRIPT_MISSIONSCRIPT01_LUA_000401, 152 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000402 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000402")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000402)
	MisBeginCondition(HasRecord, 91)
	MisBeginCondition(NoMission, 152)
	MisBeginCondition(NoRecord, 152)
	MisBeginAction(AddMission, 152)
	MisBeginAction(AddTrigger, 1521, TE_GETITEM, 1704, 3 )
	MisCancelAction(ClearMission, 152)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000403 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000403")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000403)
	MisNeed(MIS_NEED_ITEM, 1704, 3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000404 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000404")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000404)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000117 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000117")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000117)
	MisResultCondition(HasMission, 152)
	MisResultCondition(HasItem, 1704, 3 )
	MisResultAction(TakeItem, 1704, 3)
	MisResultAction(ClearMission, 152)
	MisResultAction(SetRecord, 152)
	MisResultAction(AddExp, 150, 150)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000400 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000400")
	MisResultAction(GiveNpcMission, 183, MISSCRIPT_MISSIONSCRIPT01_LUA_000400, 7) 
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 1704 )	
	TriggerAction( 1, AddNextFlag, 152, 10, 3 )
	RegCurTrigger( 1521 )

-----------------------------------送信给约瑟夫
	MISSCRIPT_MISSIONSCRIPT01_LUA_000405 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000405")
	DefineMission( 183, MISSCRIPT_MISSIONSCRIPT01_LUA_000405, 153 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000406 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000406")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000406)
	MisBeginCondition(HasRecord, 152)
	MisBeginCondition(NoRecord, 153)
	MisBeginCondition(NoMission, 153)
	MisBeginAction(AddMission, 153)
	MisBeginAction(GiveItem, 4137, 1, 4)
	MisCancelAction(ClearMission, 153 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000407")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000407)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000408 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000408")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000408)
	MisResultCondition(AlwaysFailure )

-----------------------------------送信给约瑟夫
	MISSCRIPT_MISSIONSCRIPT01_LUA_000405 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000405")
	DefineMission( 184, MISSCRIPT_MISSIONSCRIPT01_LUA_000405, 153, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000409 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000409")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000409)
	MisResultCondition(NoRecord, 153)
	MisResultCondition(HasMission, 153)
	MisResultCondition(HasItem, 4137, 1)
	MisResultAction(TakeItem, 4137, 1)
	MisResultAction(ClearMission, 153)
	MisResultAction(SetRecord, 153)
	MisResultAction(AddExp, 80, 80)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000410 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000410")
	MisResultAction(GiveNpcMission, 185, MISSCRIPT_MISSIONSCRIPT01_LUA_000410, 3) 

-----------------------------------调料瓶
	MISSCRIPT_MISSIONSCRIPT01_LUA_000411 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000411")
	DefineMission( 185, MISSCRIPT_MISSIONSCRIPT01_LUA_000411, 154 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000412 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000412")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000412)
	MisBeginCondition(HasRecord, 153)
	MisBeginCondition(NoMission, 154)
	MisBeginCondition(NoRecord, 154)
	MisBeginAction(AddMission, 154)
	MisBeginAction(AddTrigger, 1541, TE_GETITEM, 1779, 2 )
	MisCancelAction(ClearMission, 154)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000413 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000413")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000413)
	MisNeed(MIS_NEED_ITEM, 1779, 2, 10, 2)

	MisPrize(MIS_PRIZE_ITEM, 1848, 5, 4)
	MisPrizeSelAll()	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000414")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000414)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000415 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000415")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000415)
	MisResultCondition(HasMission, 154)
	MisResultCondition(HasItem, 1779, 2 )
	MisResultAction(TakeItem, 1779, 2)
	MisResultAction(ClearMission, 154)
	MisResultAction(SetRecord, 154)
	MisResultAction(AddExp, 250, 250)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000410 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000410")
	MisResultAction(GiveNpcMission, 186, MISSCRIPT_MISSIONSCRIPT01_LUA_000410, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1779 )	
	TriggerAction( 1, AddNextFlag, 154, 10, 2 )
	RegCurTrigger( 1541 )

-----------------------------------送信给布丽娜
	MISSCRIPT_MISSIONSCRIPT01_LUA_000416 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000416")
	DefineMission( 186, MISSCRIPT_MISSIONSCRIPT01_LUA_000416, 155 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000417 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000417")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000417)
	MisBeginCondition(HasRecord, 154)
	MisBeginCondition(NoRecord, 155)
	MisBeginCondition(NoMission, 155)
	MisBeginAction(AddMission, 155)
	MisBeginAction(GiveItem, 4138, 1, 4)
	MisCancelAction(ClearMission, 155 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000418")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000418)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000419 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000419")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000419)
	MisResultCondition(AlwaysFailure )
-----------------------------------送信给布丽娜
	MISSCRIPT_MISSIONSCRIPT01_LUA_000416 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000416")
	DefineMission( 187, MISSCRIPT_MISSIONSCRIPT01_LUA_000416, 155, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000420 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000420")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000420)
	MisResultCondition(NoRecord, 155)
	MisResultCondition(HasMission, 155)
	MisResultCondition(HasItem, 4138, 1)
	MisResultAction(TakeItem, 4138, 1)
	MisResultAction(ClearMission, 155)
	MisResultAction(SetRecord, 155)
	MisResultAction(AddExp, 120, 120)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000421 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000421")
	MisResultAction(GiveNpcMission, 188, MISSCRIPT_MISSIONSCRIPT01_LUA_000421, 3)

-----------------------------------眼泪
	MISSCRIPT_MISSIONSCRIPT01_LUA_000422 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000422")
	DefineMission( 188, MISSCRIPT_MISSIONSCRIPT01_LUA_000422, 156 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000423 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000423")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000423)
	MisBeginCondition(HasRecord, 155)
	MisBeginCondition(NoMission, 156)
	MisBeginCondition(NoRecord, 156)
	MisBeginAction(AddMission, 156)
	MisBeginAction(AddTrigger, 1561, TE_GETITEM, 1681, 1 )
	MisCancelAction(ClearMission, 156)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000424 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000424")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000424)
	MisNeed(MIS_NEED_ITEM, 1681, 1, 10, 1)

	MisPrize(MIS_PRIZE_ITEM, 4310, 1, 4)
	MisPrizeSelAll()	

	MISSCRIPT_MISSIONSCRIPT01_LUA_000425 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000425")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000425)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000426 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000426")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000426)
	MisResultCondition(HasMission, 156)
	MisResultCondition(HasItem, 1681, 1 )
	MisResultAction(TakeItem, 1681, 1)
	MisResultAction(ClearMission, 156)
	MisResultAction(SetRecord, 156)
	MisResultAction(AddExp, 400, 400)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000421 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000421")
	MisResultAction(GiveNpcMission, 189, MISSCRIPT_MISSIONSCRIPT01_LUA_000421, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1681 )	
	TriggerAction( 1, AddNextFlag, 156, 10, 1 )
	RegCurTrigger( 1561 )

-----------------------------------送信给安琪露
	MISSCRIPT_MISSIONSCRIPT01_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000381")
	DefineMission( 189, MISSCRIPT_MISSIONSCRIPT01_LUA_000381, 157 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000427 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000427")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000427)
	MisBeginCondition(HasRecord, 156)
	MisBeginCondition(NoRecord, 157)
	MisBeginCondition(NoMission, 157)
	MisBeginAction(AddMission, 157)
	MisBeginAction(GiveItem, 4135, 1, 4)
	MisCancelAction(ClearMission, 157 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000383 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000383")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000383)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000384 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000384")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000384)
	MisResultCondition(AlwaysFailure )
	
	
-----------------------------------送信给安琪露
	MISSCRIPT_MISSIONSCRIPT01_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000381")
	DefineMission( 190, MISSCRIPT_MISSIONSCRIPT01_LUA_000381, 157, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000385 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000385")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000385)
	MisResultCondition(NoRecord, 157)
	MisResultCondition(HasMission, 157)
	MisResultCondition(HasItem, 4135, 1)
	MisResultAction(TakeItem, 4135, 1)
	MisResultAction(ClearMission, 157)
	MisResultAction(SetRecord, 157)
	MisResultAction(AddExp, 200, 200)


-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 191, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 61, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000428 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000428")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000428)
	MisResultCondition(NoRecord, 61)
	MisResultCondition(HasMission, 61)
	MisResultCondition(HasItem, 4119, 1)
	MisResultAction(TakeItem, 4119, 1)
	MisResultAction(ClearMission, 61)
	MisResultAction(SetRecord, 61)
	MisResultAction( SetProfession, 4  )
	MisResultAction( GiveItem, 3227, 1, 4 )
	MisResultAction( GiveItem, 73, 1, 4 )
	MisBeginBagNeed(2)
	MisResultAction(AddExp1)

-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 192, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 158 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000429 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000429")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000429)
	MisBeginCondition(HasRecord, 61)
	MisBeginCondition(NoMission, 158)
	MisBeginCondition(NoRecord, 158)
	MisBeginAction(AddMission, 158)
	MisBeginAction(AddTrigger, 1581, TE_KILL, 237, 12 )
	MisCancelAction(ClearMission, 158)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000430")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000430)
	MisNeed(MIS_NEED_KILL, 237, 12, 10, 12)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000431 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000431")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000431)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000018")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000018)
	MisResultCondition(HasMission, 158)
	MisResultCondition(HasFlag, 158, 21 )
	MisResultAction(ClearMission, 158)
	MisResultAction(SetRecord, 158)
	MisResultAction(AddExp, 300, 300)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 237 )	
	TriggerAction( 1, AddNextFlag, 158, 10, 12 )
	RegCurTrigger( 1581 )


-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 193, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 159 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000432 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000432")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000432)
	MisBeginCondition(HasRecord, 158)
	MisBeginCondition(NoRecord, 159)
	MisBeginCondition(NoMission, 159)
	MisBeginAction(AddMission, 159)
	MisBeginAction(GiveItem, 4139, 1, 4)
	MisCancelAction(ClearMission, 159  )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000243")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000243)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000433 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000433")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000433)
	MisResultCondition(AlwaysFailure )
-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 194, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 159, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000434 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000434")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000434)
	MisResultCondition(NoRecord, 159)
	MisResultCondition(HasMission, 159)
	MisResultCondition(HasItem, 4139, 1)
	MisResultAction(TakeItem, 4139, 1)
	MisResultAction(ClearMission, 159)
	MisResultAction(SetRecord, 159)
	MisResultAction(AddExp, 100, 100)

-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 195, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 160 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000435 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000435")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000435)
	MisBeginCondition(HasRecord, 159)
	MisBeginCondition(NoMission, 160)
	MisBeginCondition(NoRecord, 160)
	MisBeginAction(AddMission, 160)
	MisBeginAction(AddTrigger, 1601, TE_GETITEM, 1595, 2 )
	MisCancelAction(ClearMission, 160)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000436 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000436")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000436)
	MisNeed(MIS_NEED_ITEM, 1595, 2, 10, 2)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000437 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000437")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000437)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000438 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000438")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000438)
	MisResultCondition(HasMission, 160)
	MisResultCondition(HasItem, 1595, 2 )
	MisResultAction(TakeItem, 1595, 2)
	MisResultAction(ClearMission, 160)
	MisResultAction(SetRecord, 160)
	MisResultAction(AddExp, 300, 300)

	InitTrigger()
	TriggerCondition( 1, IsItem, 1595 )	
	TriggerAction( 1, AddNextFlag, 160, 10, 2 )
	RegCurTrigger( 1601 )

-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 196, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 161 )
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000439 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000439")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000439)
	MisBeginCondition(HasRecord, 160)
	MisBeginCondition(NoRecord, 161)
	MisBeginCondition(NoMission, 161)
	MisBeginAction(AddMission, 161)
	MisBeginAction(GiveItem, 3962, 1, 4)
	MisCancelAction(ClearMission, 161 )
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000440 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000440")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000440)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000441")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000441)
	MisResultCondition(AlwaysFailure )

-----------------------------------冒险者转职任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000233")
	DefineMission( 197, MISSCRIPT_MISSIONSCRIPT01_LUA_000233, 161, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000442 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000442")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000442)
	MisResultCondition(NoRecord, 161)
	MisResultCondition(HasMission, 161)
	MisResultCondition(HasItem, 3962, 1)
	MisResultAction(TakeItem, 3962, 1)
	MisResultAction(ClearMission, 161)
	MisResultAction(SetRecord, 161)
	MisResultAction(AddExp, 100, 100)
	MisResultAction(SetProfession, 4)
	MisResultAction(GiveItem, 867, 1, 4)
	MisResultAction(GiveItem, 3227, 1, 4)
	MisResultBagNeed(2)


-----------------------------------初级贸易证任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000443 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000443")
	DefineMission( 198, MISSCRIPT_MISSIONSCRIPT01_LUA_000443, 162 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000444 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000444")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000444)
	MisBeginCondition(NoMission, 162)
	MisBeginCondition(NoItem, 4605, 1)
	MisBeginCondition(LvCheck, ">", 19 )
	MisBeginAction(AddMission, 162)
	MisBeginAction(AddTrigger, 1621, TE_GETITEM, 4543, 40 )
	MisCancelAction(ClearMission, 162)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000445 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000445")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000445)
	MisNeed(MIS_NEED_ITEM, 4543, 40, 10, 40)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000446 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000446")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000446)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000447 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000447")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000447)
	MisResultCondition(HasMission, 162)
	MisResultCondition(HasItem, 4543, 40 )
	MisResultAction(TakeItem, 4543, 40 )
	MisResultAction(ClearMission, 162)
	MisResultAction(SetRecord, 162)
	MisResultAction(GiveItem, 4605, 1, 4)
	MisResultAction(SetTradeItemLevel, 1 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4543 )	
	TriggerAction( 1, AddNextFlag, 162, 10, 40 )
	RegCurTrigger( 1621 )

-----------------------------------中级贸易证任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000448 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000448")
	DefineMission( 199, MISSCRIPT_MISSIONSCRIPT01_LUA_000448, 163 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000449 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000449")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000449)
	MisBeginCondition(NoMission, 163)
	MisBeginCondition(HasItem, 4605, 1)
	MisBeginCondition(TradeItemDataCheck, ">", 99 )
	MisBeginCondition(LvCheck, ">", 39)
	MisBeginCondition(TradeItemLevelCheck, "=", 1)
	MisBeginAction(AddMission, 163)
	MisBeginAction(AddTrigger, 1631, TE_GETITEM, 4546, 40 )
	MisCancelAction(ClearMission, 163)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000450 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000450")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000450)
	MisNeed(MIS_NEED_ITEM, 4546, 40, 10, 40)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000451")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000451)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000447 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000447")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000447)
	MisResultCondition(HasMission, 163)
	MisResultCondition(HasItem, 4546, 40 )
	MisResultCondition(HasItem, 4605, 1 )
	MisResultAction(TakeItem, 4546, 40)
	MisResultAction(ClearMission, 163)
	MisResultAction(SetRecord, 163)
	MisResultAction(SetTradeItemLevel, 2 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4546 )	
	TriggerAction( 1, AddNextFlag, 163, 10, 40 )
	RegCurTrigger( 1631 )


-----------------------------------高级贸易证任务
	MISSCRIPT_MISSIONSCRIPT01_LUA_000452 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000452")
	DefineMission( 149, MISSCRIPT_MISSIONSCRIPT01_LUA_000452, 164 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000453 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000453")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT01_LUA_000453)
	MisBeginCondition(NoMission, 164)
	MisBeginCondition(HasItem, 4605, 1)
	MisBeginCondition(TradeItemDataCheck, ">", 399 )
	MisBeginCondition(LvCheck, ">", 59)
	MisBeginCondition(TradeItemLevelCheck, "=", 2)
	MisBeginAction(AddMission, 164)
	MisBeginAction(AddTrigger, 1641, TE_GETITEM, 4544, 40 )
	MisCancelAction(ClearMission, 164)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000454 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000454")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT01_LUA_000454)
	MisNeed(MIS_NEED_ITEM, 4544, 40, 10, 40)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000455 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000455")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000455)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000447 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000447")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT01_LUA_000447)
	MisResultCondition(HasMission, 164)
	MisResultCondition(HasItem, 4544, 40 )
	MisResultCondition(HasItem, 4605, 1 )
	MisResultAction(TakeItem, 4544, 40)
	MisResultAction(ClearMission, 164)
	MisResultAction(SetRecord, 164)
	MisResultAction(SetTradeItemLevel, 3 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4544 )
	TriggerAction( 1, AddNextFlag, 164, 10, 40 )
	RegCurTrigger( 1641 )

end
RobinMission039()




