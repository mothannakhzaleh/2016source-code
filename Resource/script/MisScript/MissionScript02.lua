--------------------------------------------------------------------------
--									--
--									--
--				MissionScript02.lua 			-- 
--									--
--									--
--------------------------------------------------------------------------
print( "Loading MissionScript02.lua" )


jp= JumpPage
amp=AutoMissionPage
ct=CloseTalk
am=AddMission
MissionCheck = HasFlag
mc=MissionCheck

----------------------------------------------------------
--							--
--							--
--		历史任务	 				--
--							--
--		227725,276925				--
----------------------------------------------------------
	-->历史任务开始
function HistoryMission001()

----------------------------首席秘书的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000001")
	DefineMission( 200, MISSCRIPT_MISSIONSCRIPT02_LUA_000001, 200 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000002 )
	MisBeginCondition(NoRecord, 200)
	MisBeginCondition(NoMission, 200)
	MisBeginCondition(NoMission, 201)
	MisBeginCondition(NoMission, 202)
	MisBeginCondition(LvCheck, ">",9)
	MisBeginAction(AddMission, 200)
	MisCancelAction(ClearMission, 200)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000003 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000003")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000003)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000004")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000004)
	MisResultCondition(AlwaysFailure )

	



----------------------------首席秘书的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000001")
	DefineMission( 201, MISSCRIPT_MISSIONSCRIPT02_LUA_000001, 201 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000002 )
	MisBeginCondition(NoRecord, 200)
	MisBeginCondition(NoMission, 200)
	MisBeginCondition(NoMission, 201)
	MisBeginCondition(NoMission, 202)
	MisBeginCondition(LvCheck, ">",9)
	MisBeginAction(AddMission, 201)
	MisCancelAction(ClearMission, 201)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000005")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000005)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000004")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000004)
	MisResultCondition(AlwaysFailure )


----------------------------首席秘书的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000001")
	DefineMission( 202, MISSCRIPT_MISSIONSCRIPT02_LUA_000001, 202 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000002")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000002 )
	MisBeginCondition(NoRecord, 200)
	MisBeginCondition(NoMission, 200)
	MisBeginCondition(NoMission, 201)
	MisBeginCondition(NoMission, 202)
	MisBeginCondition(LvCheck, ">",9)
	MisBeginAction(AddMission, 202)
	MisCancelAction(ClearMission, 202)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000005 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000005")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000005)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000004 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000004")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000004)
	MisResultCondition(AlwaysFailure )


-----------------------------------首席秘书的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000001")
	DefineMission( 203, MISSCRIPT_MISSIONSCRIPT02_LUA_000001, 200, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000006")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000006)
	MisResultCondition(NoRecord, 200)
	MisResultCondition(HasMission, 200)
	MisResultAction(ClearMission, 200 )
	MisResultAction(SetRecord, 200 )
	MisResultAction(AddExp,250,250)
	MisResultAction(AddMoney,999,999)
	MisResultAction(AddExpAndType,2,875,875)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000201")
	MisResultAction(GiveNpcMission1, 206, MISSCRIPT_MISSIONSCRIPT01_LUA_000201, 4) 


-----------------------------------首席秘书的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000001")
	DefineMission( 204, MISSCRIPT_MISSIONSCRIPT02_LUA_000001, 201, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000006")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000006)
	MisResultCondition(NoRecord, 200)
	MisResultCondition(HasMission, 201)
	MisResultAction(ClearMission, 201 )
	MisResultAction(SetRecord, 200 )
	MisResultAction(AddExp,250,250)
	MisResultAction(AddMoney,999,999)
	MisResultAction(AddExpAndType,2,875,875)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000201")
	MisResultAction(GiveNpcMission1, 206, MISSCRIPT_MISSIONSCRIPT01_LUA_000201, 4) 

-----------------------------------首席秘书的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000001")
	DefineMission( 205, MISSCRIPT_MISSIONSCRIPT02_LUA_000001, 202, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000006 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000006")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000006)
	MisResultCondition(NoRecord, 200)
	MisResultCondition(HasMission, 202)
	MisResultAction(ClearMission, 202 )
	MisResultAction(SetRecord, 200 )
	MisResultAction(AddExp,250,250)
	MisResultAction(AddMoney,999,999)
	MisResultAction(AddExpAndType,2,875,875)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000201")
	MisResultAction(GiveNpcMission1, 206, MISSCRIPT_MISSIONSCRIPT01_LUA_000201, 4) 


----------------------------小小的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000007")
	DefineMission( 206, MISSCRIPT_MISSIONSCRIPT02_LUA_000007, 203 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000008 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000008")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000008 )
	MisBeginCondition(NoRecord, 203)
	MisBeginCondition(NoMission, 203)
	MisBeginCondition(HasRecord, 200)
	MisBeginAction(AddMission, 203)
	MisCancelAction(ClearMission, 203)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000009")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000009)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000010 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000010")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000010)
	MisResultCondition(AlwaysFailure )

-----------------------------------小小的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000007 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000007")
	DefineMission( 207, MISSCRIPT_MISSIONSCRIPT02_LUA_000007, 203, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000011 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000011")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000011)
	MisResultCondition(NoRecord, 203)
	MisResultCondition(HasMission, 203)
	MisResultAction(ClearMission, 203 )
	MisResultAction(SetRecord, 203 )
	MisResultAction(AddExp,230,230)
	MisResultAction(AddMoney,1000,1000)
	MisResultAction(AddExpAndType,2,875,875)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000012")
	MisResultAction(GiveNpcMission1, 208, MISSCRIPT_MISSIONSCRIPT02_LUA_000012, 2) 

-------------------------------------------------海军的伙食配料
	MISSCRIPT_MISSIONSCRIPT02_LUA_000013 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000013")
	DefineMission( 208, MISSCRIPT_MISSIONSCRIPT02_LUA_000013, 204 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000014 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000014")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000014)
	MisBeginCondition(NoRecord, 204)
	MisBeginCondition(HasRecord, 203)
	MisBeginCondition(NoMission, 204)
	MisBeginAction(AddMission, 204)
	MisBeginAction(AddTrigger, 2041, TE_GETITEM, 3963, 5 )		--射水贝肉
	MisBeginAction(AddTrigger, 2042, TE_GETITEM, 3964, 5 )		--海螺肉
	MisBeginAction(AddTrigger, 2043, TE_GETITEM, 3116, 3 )
	MisCancelAction(ClearMission, 204)

	MisNeed(MIS_NEED_ITEM, 3963, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 3964, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 3116, 3, 30, 3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000015 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000015")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000015)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000016 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000016")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000016)
	MisResultCondition(HasMission, 204)
	MisResultCondition(HasItem, 3963, 5 )
	MisResultCondition(HasItem, 3964, 5 )
	MisResultCondition(HasItem, 3116, 3 )
	MisResultAction(TakeItem, 3963, 5 )
	MisResultAction(TakeItem, 3964, 5 )
	MisResultAction(TakeItem, 3116, 3 )
	MisResultAction(ClearMission, 204)
	MisResultAction(SetRecord, 204 )
	MisResultAction(AddExp,230,230)
	MisResultAction(AddMoney,1000,1000)	
	MisResultAction(AddExpAndType,2,875,875)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000012")
	MisResultAction(GiveNpcMission1, 209, MISSCRIPT_MISSIONSCRIPT02_LUA_000012, 3) 	

	InitTrigger()
	TriggerCondition( 1, IsItem, 3963)	
	TriggerAction( 1, AddNextFlag, 204, 10, 5 )
	RegCurTrigger( 2041 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3964)	
	TriggerAction( 1, AddNextFlag, 204, 20, 5 )
	RegCurTrigger( 2042 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3116)	
	TriggerAction( 1, AddNextFlag, 204, 30, 3 )
	RegCurTrigger( 2043 )

----------------------------走失的唐德
	MISSCRIPT_MISSIONSCRIPT02_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000017")
	DefineMission( 209, MISSCRIPT_MISSIONSCRIPT02_LUA_000017, 205 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000018 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000018")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000018 )
	MisBeginCondition(NoRecord, 205)
	MisBeginCondition(HasRecord, 204)
	MisBeginCondition(NoMission, 205)
	MisBeginAction(AddMission, 205)
	MisCancelAction(ClearMission, 205)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000019 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000019")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000019)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000020 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000020")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000020)
	MisResultCondition(AlwaysFailure )

-----------------------------------走失的唐德
	MISSCRIPT_MISSIONSCRIPT02_LUA_000017 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000017")
	DefineMission( 210, MISSCRIPT_MISSIONSCRIPT02_LUA_000017, 205, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000021 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000021")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000021)
	MisResultCondition(NoRecord, 205)
	MisResultCondition(HasMission, 205)
	MisResultAction(ClearMission, 205 )
	MisResultAction(SetRecord, 205 )
	MisResultAction(AddExp,230,230)
	MisResultAction(AddMoney,1100,1100)
	MisResultAction(AddExpAndType,2,875,875)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000022 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000022")
	MisResultAction(GiveNpcMission1, 211, MISSCRIPT_MISSIONSCRIPT02_LUA_000022, 2) 	


----------------------------向少将回报
	MISSCRIPT_MISSIONSCRIPT02_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000023")
	DefineMission( 211, MISSCRIPT_MISSIONSCRIPT02_LUA_000023, 206 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000024 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000024")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000024 )
	MisBeginCondition(NoRecord, 206)
	MisBeginCondition(HasRecord, 205)
	MisBeginCondition(NoMission, 206)
	MisBeginAction(AddMission, 206)
	MisBeginAction(GiveItem, 3965, 1, 4)		--唐德的信
	MisCancelAction(ClearMission, 206)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000025 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000025")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000025)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000026 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000026")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000026)
	MisResultCondition(AlwaysFailure )

-----------------------------------向少将回报
	MISSCRIPT_MISSIONSCRIPT02_LUA_000023 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000023")
	DefineMission( 212, MISSCRIPT_MISSIONSCRIPT02_LUA_000023, 206, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000027 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000027")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000027)
	MisResultCondition(NoRecord, 206)
	MisResultCondition(HasMission, 206)
	MisResultCondition(HasItem, 3965, 1)		--唐德的信
	MisResultAction(TakeItem, 3965, 1 ) 
	MisResultAction(ClearMission, 206 )
	MisResultAction(SetRecord, 206 )
	MisResultAction(AddExp,230,230)
	MisResultAction(AddMoney,1100,1100)	
	MisResultAction(AddExpAndType,2,875,875)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000012")
	MisResultAction(GiveNpcMission1, 213, MISSCRIPT_MISSIONSCRIPT02_LUA_000012, 5) 	
-------------------------------------------------全体食物中毒
	MISSCRIPT_MISSIONSCRIPT02_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000028")
	DefineMission( 213, MISSCRIPT_MISSIONSCRIPT02_LUA_000028, 207 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000029 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000029")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000029 )
	MisBeginCondition(NoRecord, 207)
	MisBeginCondition(HasRecord, 206)
	MisBeginCondition(NoMission, 207)
	MisBeginAction(AddMission, 207)
	MisBeginAction(GiveItem, 3966, 1, 4)			--午餐样本
	MisBeginAction(AddTrigger, 2071, TE_GETITEM, 3967, 1 )		--射水贝肉
	MisCancelAction(ClearMission, 207)
	MisBeginBagNeed(1)

	MisNeed(MIS_NEED_ITEM, 3967, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000030 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000030")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000030)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000031 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000031")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000031)
	MisResultCondition(HasMission, 207)
	MisResultCondition(HasItem, 3967, 1 )
	MisResultAction(TakeItem, 3967, 1 )
	MisResultAction(ClearMission, 207)
	MisResultAction(SetRecord, 207 )
	MisResultAction(AddExp,250,250)
	MisResultAction(AddMoney,1200,1200)
	MisResultAction(AddExpAndType,2,875,875)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000012")
	MisResultAction(GiveNpcMission1, 216, MISSCRIPT_MISSIONSCRIPT02_LUA_000012, 6) 	

	InitTrigger()
	TriggerCondition( 1, IsItem, 3967)	
	TriggerAction( 1, AddNextFlag, 207, 10, 1 )
	RegCurTrigger( 2071 )

-----------------------------------全体食物中毒
	MISSCRIPT_MISSIONSCRIPT02_LUA_000028 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000028")
	DefineMission( 214, MISSCRIPT_MISSIONSCRIPT02_LUA_000028, 207, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000032 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000032")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000032)
	MisResultCondition(NoRecord, 207)
	MisResultCondition(NoFlag, 207, 1 )
	MisResultCondition(HasMission, 207)
	MisResultCondition(HasItem, 3966, 1)		--唐德的信
	MisResultAction(TakeItem, 3966, 1 ) 
	MisResultAction(SetFlag, 207, 1 )

	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission1, 215, MISSCRIPT_MISSIONSCRIPT01_LUA_000190, 4) 	
-------------------------------------------------解药原料
	MISSCRIPT_MISSIONSCRIPT02_LUA_000033 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000033")
	DefineMission( 215, MISSCRIPT_MISSIONSCRIPT02_LUA_000033, 208 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000034 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000034")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000034 )
	MisBeginCondition(NoRecord, 208)
	MisBeginCondition(HasMission, 207)
	MisBeginCondition(NoMission, 208)
	MisBeginCondition(HasFlag, 207, 1)
	MisBeginAction(AddMission, 208)
	MisBeginAction(AddTrigger, 2081, TE_GETITEM, 1678, 3 )		--羊绒
	MisBeginAction(AddTrigger, 2082, TE_GETITEM, 3968, 3 )		--小猪尾巴
	MisBeginAction(AddTrigger, 2083, TE_GETITEM, 1614, 3 )		--坚硬的壳
	MisCancelAction(ClearMission, 208)

	MisNeed(MIS_NEED_ITEM, 1678, 3, 10, 3)
	MisNeed(MIS_NEED_ITEM, 3968, 3, 20, 3)
	MisNeed(MIS_NEED_ITEM, 1614, 3, 30, 3)

	MisPrize(MIS_PRIZE_ITEM, 3967, 1, 4)
	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_000035 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000035")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000035)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000036 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000036")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000036)
	MisResultCondition(HasMission, 208)
	MisResultCondition(HasItem, 1678, 3 )
	MisResultCondition(HasItem, 3968, 3 )
	MisResultCondition(HasItem, 1614, 3 )
	MisResultAction(TakeItem, 1678, 3 )
	MisResultAction(TakeItem, 3968, 3 )
	MisResultAction(TakeItem, 1614, 3 )
	MisResultAction(ClearMission, 208)
	MisResultAction(SetRecord, 208 )
	MisResultAction(AddExp,250,250)
	MisResultAction(AddMoney,1200,1200)
	MisResultAction(AddExpAndType,2,875,875)
	MisResultBagNeed(1)
	


	InitTrigger()
	TriggerCondition( 1, IsItem, 1678)	
	TriggerAction( 1, AddNextFlag, 208, 10, 3 )
	RegCurTrigger( 2081 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3968)	
	TriggerAction( 1, AddNextFlag, 208, 20, 3 )
	RegCurTrigger( 2082 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1614)	
	TriggerAction( 1, AddNextFlag, 208, 30, 3 )
	RegCurTrigger( 2083 )

----------------------------唐德的委托
	MISSCRIPT_MISSIONSCRIPT02_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000037")
	DefineMission( 216, MISSCRIPT_MISSIONSCRIPT02_LUA_000037, 209 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000038 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000038")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000038 )
	MisBeginCondition(NoRecord, 209)
	MisBeginCondition(HasRecord, 207)
	MisBeginCondition(NoMission, 209)
	MisBeginAction(AddMission, 209)
	MisCancelAction(ClearMission, 209)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000039 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000039")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000039)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000040 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000040")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000040)
	MisResultCondition(AlwaysFailure )

-----------------------------------唐德的委托
	MISSCRIPT_MISSIONSCRIPT02_LUA_000037 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000037")
	DefineMission( 217, MISSCRIPT_MISSIONSCRIPT02_LUA_000037, 209, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000041 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000041")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000041)
	MisResultCondition(NoRecord, 209)
	MisResultCondition(HasMission, 209)
	MisResultAction(ClearMission, 209 )
	MisResultAction(SetRecord, 209 )
	MisResultAction(AddExp,280,280)
	MisResultAction(AddMoney,1300,1300)
	MisResultAction(AddExpAndType,2,875,875)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission1, 218, MISSCRIPT_MISSIONSCRIPT01_LUA_000190, 6) 


-------------------------------------------------疯狂的原因
	MISSCRIPT_MISSIONSCRIPT02_LUA_000042 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000042")
	DefineMission( 218, MISSCRIPT_MISSIONSCRIPT02_LUA_000042, 210 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000043 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000043")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000043 )
	MisBeginCondition(NoRecord, 210)
	MisBeginCondition(HasRecord, 209)
	MisBeginCondition(NoMission, 210)
	MisBeginAction(AddMission, 210)
	MisBeginAction(AddTrigger, 2101, TE_GETITEM, 3969, 3 )		--残暴山羊的口水
	MisCancelAction(ClearMission, 210)

	MisNeed(MIS_NEED_ITEM, 3969, 3, 10, 3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000044 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000044")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000044)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000045 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000045")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000045)
	MisResultCondition(HasMission, 210)
	MisResultCondition(HasItem, 3969, 3 )
	MisResultAction(TakeItem, 3969, 3 )
	MisResultAction(ClearMission, 210)
	MisResultAction(SetRecord, 210 )
	MisResultAction(AddExp,280,280)
	MisResultAction(AddMoney,1300,1300)
	MisResultAction(AddExpAndType,2,875,875)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission1, 219, MISSCRIPT_MISSIONSCRIPT01_LUA_000190, 7) 


	InitTrigger()
	TriggerCondition( 1, IsItem, 3969)	
	TriggerAction( 1, AddNextFlag, 210, 10, 3 )
	RegCurTrigger( 2101 )

-------------------------------------------------深入调查
	MISSCRIPT_MISSIONSCRIPT02_LUA_000046 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000046")
	DefineMission( 219, MISSCRIPT_MISSIONSCRIPT02_LUA_000046, 211 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000047 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000047")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000047 )
	MisBeginCondition(NoRecord, 211)
	MisBeginCondition(HasRecord, 210)
	MisBeginCondition(NoMission, 211)
	MisBeginAction(AddMission, 211)
	MisBeginAction(AddTrigger, 2111, TE_GETITEM, 3970, 1 )		--残暴山羊的口水
	MisCancelAction(ClearMission, 211)

	MisNeed(MIS_NEED_ITEM, 3970, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000048 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000048")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000048)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000049 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000049")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000049)
	MisResultCondition(HasMission, 211)
	MisResultCondition(HasItem, 3970, 1 )
	MisResultAction(TakeItem, 3970, 1 )
	MisResultAction(ClearMission, 211)
	MisResultAction(SetRecord, 211 )
	MisResultAction(AddExp,1500,1500)
	MisResultAction(AddMoney,6000,6000)	
	MisResultAction(AddExpAndType,2,875,875)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000190")
	MisResultAction(GiveNpcMission1, 220, MISSCRIPT_MISSIONSCRIPT01_LUA_000190, 8) 	

	InitTrigger()
	TriggerCondition( 1, IsItem, 3970)	
	TriggerAction( 1, AddNextFlag, 211, 10, 1 )
	RegCurTrigger( 2111 )

----------------------------帝姆的报告书
	MISSCRIPT_MISSIONSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000050")
	DefineMission( 220, MISSCRIPT_MISSIONSCRIPT02_LUA_000050, 212 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000051 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000051")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000051 )
	MisBeginCondition(NoRecord, 212)
	MisBeginCondition(HasRecord, 211)
	MisBeginCondition(NoMission, 212)
	MisBeginAction(AddMission, 212)
	MisBeginAction(GiveItem, 3971, 1, 4)
	MisCancelAction(ClearMission, 212)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000052 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000052")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000052)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000053 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000053")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000053)
	MisResultCondition(AlwaysFailure )

-----------------------------------帝姆的报告书
	MISSCRIPT_MISSIONSCRIPT02_LUA_000050 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000050")
	DefineMission( 221, MISSCRIPT_MISSIONSCRIPT02_LUA_000050, 212, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000054 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000054")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000054)
	MisResultCondition(NoRecord, 212)
	MisResultCondition(HasMission, 212)
	MisResultCondition(HasItem, 3971, 1)
	MisResultAction(TakeItem, 3971, 1 )
	MisResultAction(ClearMission, 212 )
	MisResultAction(SetRecord, 212 )
	MisResultAction(AddExp,350,350)
	MisResultAction(AddMoney,1500,1500)
	MisResultAction(AddExpAndType,2,3400,3400)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000201")
	MisResultAction(GiveNpcMission1, 222, MISSCRIPT_MISSIONSCRIPT01_LUA_000201, 6) 	


----------------------------新任务
	MISSCRIPT_MISSIONSCRIPT02_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000055")
	DefineMission( 222, MISSCRIPT_MISSIONSCRIPT02_LUA_000055, 213 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000056 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000056")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000056 )
	MisBeginCondition(NoRecord, 213)
	MisBeginCondition(HasRecord, 212)
	MisBeginCondition(NoMission, 213)
	MisBeginAction(AddMission, 213)
	MisBeginAction(GiveItem, 3972, 1, 4)
	MisCancelAction(ClearMission, 213)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000057 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000057")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000057)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000058 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000058")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000058)
	MisResultCondition(AlwaysFailure )

-----------------------------------新任务
	MISSCRIPT_MISSIONSCRIPT02_LUA_000055 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000055")
	DefineMission( 223, MISSCRIPT_MISSIONSCRIPT02_LUA_000055, 213, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000059 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000059)
	MisResultCondition(NoRecord, 213)
	MisResultCondition(HasMission, 213)
	MisResultCondition(HasItem , 3972, 1)
	MisResultAction(TakeItem , 3972, 1 )
	MisResultAction(ClearMission, 213 )
	MisResultAction(SetRecord, 213 )
	MisResultAction(AddExp,400,400)
	MisResultAction(AddMoney,1500,1500)	
	MisResultAction(AddExpAndType,2,3401,3401)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 224, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 2) 	


-------------------------------------------------寻找丢失的工具
	MISSCRIPT_MISSIONSCRIPT02_LUA_000061 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000061")
	DefineMission( 224, MISSCRIPT_MISSIONSCRIPT02_LUA_000061, 214 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000062 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000062")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000062 )
	MisBeginCondition(NoRecord, 214)
	MisBeginCondition(HasRecord, 213)
	MisBeginCondition(NoMission, 214)
	MisBeginAction(AddMission, 214)
	MisBeginAction(AddTrigger, 2141, TE_GETITEM, 3973, 1 )		--被盗的铁锹
	MisBeginAction(AddTrigger, 2142, TE_GETITEM, 3974, 1 )		--被盗的安全帽
	MisBeginAction(AddTrigger, 2143, TE_GETITEM, 3975, 1 )		--被盗的矿灯
	MisCancelAction(ClearMission, 214)

	MisNeed(MIS_NEED_ITEM, 3973, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 3974, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 3975, 1, 30, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000063 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000063")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000063)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000064 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000064")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000064)
	MisResultCondition(HasMission, 214)
	MisResultCondition(HasItem, 3973, 1 )
	MisResultCondition(HasItem, 3974, 1 )
	MisResultCondition(HasItem, 3975, 1 )
	MisResultAction(TakeItem, 3973, 1 )
	MisResultAction(TakeItem, 3974, 1 )
	MisResultAction(TakeItem, 3975, 1 )
	MisResultAction(ClearMission, 214)
	MisResultAction(SetRecord, 214 )
	MisResultAction(AddExp,450,450)
	MisResultAction(AddMoney,1600,1600)	
	MisResultAction(AddExpAndType,2,3402,3402)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 225, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 3) 


	InitTrigger()
	TriggerCondition( 1, IsItem, 3973)	
	TriggerAction( 1, AddNextFlag, 214, 10, 1 )
	RegCurTrigger( 2141 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3974)	
	TriggerAction( 1, AddNextFlag, 214, 20, 1 )
	RegCurTrigger( 2142 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3975)	
	TriggerAction( 1, AddNextFlag, 214, 30, 1 )
	RegCurTrigger( 2143 )

-------------------------------------------------清理利齿菇
	MISSCRIPT_MISSIONSCRIPT02_LUA_000065 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000065")
	DefineMission( 225, MISSCRIPT_MISSIONSCRIPT02_LUA_000065, 215 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000066 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000066")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000066 )
	MisBeginCondition(NoRecord, 215)
	MisBeginCondition(HasRecord, 214)
	MisBeginCondition(NoMission, 215)
	MisBeginAction(AddMission, 215)
	MisBeginAction(AddTrigger, 2151, TE_KILL, 252, 10 )		--利齿菇
	MisCancelAction(ClearMission, 215)

	MisNeed(MIS_NEED_KILL, 252, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000067 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000067")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000067)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000068 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000068")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000068)
	MisResultCondition(HasMission, 215)
	MisResultCondition(HasFlag, 215, 19 )
	MisResultAction(ClearMission, 215)
	MisResultAction(SetRecord, 215 )
	MisResultAction(AddExp,500,500)
	MisResultAction(AddMoney,1700,1700)	
	MisResultAction(AddExpAndType,2,3403,3403)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 226, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 4) 

	InitTrigger()
	TriggerCondition( 1, IsMonster, 252)	
	TriggerAction( 1, AddNextFlag, 215, 10, 10 )
	RegCurTrigger( 2151 )

-------------------------------------------------帝姆的委托
	MISSCRIPT_MISSIONSCRIPT02_LUA_000069 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000069")
	DefineMission( 226, MISSCRIPT_MISSIONSCRIPT02_LUA_000069, 216 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000070 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000070")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000070 )
	MisBeginCondition(NoRecord, 216)
	MisBeginCondition(HasRecord, 215)
	MisBeginCondition(NoMission, 216)
	MisBeginAction(AddMission, 216)
	MisBeginAction(AddTrigger, 2161, TE_GETITEM, 3976, 1 )		--蟹王的胃结石
	MisCancelAction(ClearMission, 216)

	MisNeed(MIS_NEED_ITEM, 3976, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000071 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000071")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000071)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000072 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000072")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000072)
	MisResultCondition(HasMission, 216)
	MisResultCondition(HasItem, 3976, 1 )
	MisResultAction(TakeItem, 3976, 1)
	MisResultAction(ClearMission, 216)
	MisResultAction(SetRecord, 216 )
	MisResultAction(AddExp,3000,3000)
	MisResultAction(AddMoney,9000,9000)	
	MisResultAction(AddExpAndType,2,3404,3404)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 227, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 5) 


	InitTrigger()
	TriggerCondition( 1, IsItem, 3976 )	
	TriggerAction( 1, AddNextFlag, 216, 10, 1 )
	RegCurTrigger( 2161 )

-------------------------------------------------山贼势力图
	MISSCRIPT_MISSIONSCRIPT02_LUA_000073 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000073")
	DefineMission( 227, MISSCRIPT_MISSIONSCRIPT02_LUA_000073, 217 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000074 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000074")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000074 )
	MisBeginCondition(NoRecord, 217)
	MisBeginCondition(HasRecord, 216)
	MisBeginCondition(NoMission, 217)
	MisBeginAction(AddMission, 217)
	MisBeginAction(AddTrigger, 2171, TE_GETITEM, 3977, 1 )		--山贼势力图
	MisCancelAction(ClearMission, 217)

	MisNeed(MIS_NEED_ITEM, 3977, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000075 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000075")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000075)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000076 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000076")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000076)
	MisResultCondition(HasMission, 217)
	MisResultCondition(HasItem, 3977, 1 )
	MisResultAction(TakeItem, 3977, 1)
	MisResultAction(ClearMission, 217)
	MisResultAction(SetRecord, 217 )
	MisResultAction(AddExp,750,750)
	MisResultAction(AddMoney,2000,2000)
	MisResultAction(AddExpAndType,2,11833,11833)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 228, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 6) 

	InitTrigger()
	TriggerCondition( 1, IsItem, 3977 )	
	TriggerAction( 1, AddNextFlag, 217, 10, 1 )
	RegCurTrigger( 2171 )

-------------------------------------------------突袭山贼团
	MISSCRIPT_MISSIONSCRIPT02_LUA_000077 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000077")
	DefineMission( 228, MISSCRIPT_MISSIONSCRIPT02_LUA_000077, 218 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000078 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000078")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000078 )
	MisBeginCondition(NoRecord, 218)
	MisBeginCondition(HasRecord, 217)
	MisBeginCondition(NoMission, 218)
	MisBeginAction(AddMission, 218)
	MisBeginAction(AddTrigger, 2181, TE_GETITEM, 1841, 3 )		--山贼的项链
	MisCancelAction(ClearMission, 218)

	MisNeed(MIS_NEED_ITEM, 1841, 3, 10, 3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000079 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000079")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000079)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000080 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000080")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000080)
	MisResultCondition(HasMission, 218)
	MisResultCondition(HasItem, 1841, 3 )
	MisResultAction(TakeItem, 1841, 3 )
	MisResultAction(ClearMission, 218)
	MisResultAction(SetRecord, 218 )
	MisResultAction(AddExp,1000,1000)
	MisResultAction(AddMoney,2200,2200)	
	MisResultAction(AddExpAndType,2,11833,11833)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 229, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 7) 	

	InitTrigger()
	TriggerCondition( 1, IsItem, 1841 )	
	TriggerAction( 1, AddNextFlag, 218, 10, 3 )
	RegCurTrigger( 2181 )

-------------------------------------------------悬赏令
	MISSCRIPT_MISSIONSCRIPT02_LUA_000081 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000081")
	DefineMission( 229, MISSCRIPT_MISSIONSCRIPT02_LUA_000081, 219 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000082 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000082")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000082 )
	MisBeginCondition(NoRecord, 219)
	MisBeginCondition(HasRecord, 218)
	MisBeginCondition(NoMission, 219)
	MisBeginAction(AddMission, 219)
	MisBeginAction(AddTrigger, 2191, TE_KILL, 211, 1 )		--山贼首领·蝰蛇
	MisCancelAction(ClearMission, 219)

	MisNeed(MIS_NEED_KILL, 211, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000083 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000083")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000083)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000084 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000084")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000084)
	MisResultCondition(HasMission, 219)
	MisResultCondition(HasFlag, 219, 10 )
	MisResultAction(ClearMission, 219)
	MisResultAction(SetRecord, 219 )
	MisResultAction(AddExp,5000,5000)
	MisResultAction(AddMoney,10000,10000)	
	MisResultAction(AddExpAndType,2,11833,11833)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000060")
	MisResultAction(GiveNpcMission1, 230, MISSCRIPT_MISSIONSCRIPT02_LUA_000060, 8) 		

	InitTrigger()
	TriggerCondition( 1, IsMonster, 211 )	
	TriggerAction( 1, AddNextFlag, 219, 10, 1 )
	RegCurTrigger( 2191 )

----------------------------去沙漠
	MISSCRIPT_MISSIONSCRIPT02_LUA_000085 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000085")
	DefineMission( 230, MISSCRIPT_MISSIONSCRIPT02_LUA_000085, 220 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000086 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000086")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000086 )
	MisBeginCondition(NoRecord, 220)
	MisBeginCondition(HasRecord, 219)
	MisBeginCondition(NoMission, 220)
	MisBeginAction(AddMission, 220)
	MisBeginAction(GiveItem, 3978, 1, 4)
	MisCancelAction(ClearMission, 220)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000087 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000087")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000087)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000088 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000088")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000088)
	MisResultCondition(AlwaysFailure )

-----------------------------------去沙漠
	MISSCRIPT_MISSIONSCRIPT02_LUA_000085 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000085")
	DefineMission( 231, MISSCRIPT_MISSIONSCRIPT02_LUA_000085, 220, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000089 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000089")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000089)
	MisResultCondition(NoRecord, 220)
	MisResultCondition(HasMission, 220)
	MisResultCondition(HasItem, 3978, 1)
	MisResultAction(TakeItem, 3978, 1 )
	MisResultAction(ClearMission, 220 )
	MisResultAction(SetRecord, 220 )
	MisResultAction(AddExp,1100,1100)
	MisResultAction(AddMoney,2300,2300)
	MisResultAction(AddExpAndType,2,5000,5000)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000090")
	MisResultAction(GiveNpcMission1, 232, MISSCRIPT_MISSIONSCRIPT02_LUA_000090, 2) 	
	
----------------------------变异的原因
	MISSCRIPT_MISSIONSCRIPT02_LUA_000091 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000091")
	DefineMission( 232, MISSCRIPT_MISSIONSCRIPT02_LUA_000091, 221 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000092 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000092")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000092 )
	MisBeginCondition(NoRecord, 221)
	MisBeginCondition(HasRecord, 220)
	MisBeginCondition(NoMission, 221)
	MisBeginAction(AddMission, 221)
	MisCancelAction(ClearMission, 221)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000093")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000093)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000094 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000094")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000094)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000095 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000095")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000095)
	MisResultCondition(HasMission, 221 )
	MisResultCondition(NoRecord, 221 )
	MisResultCondition(HasFlag, 221, 1 )
	MisResultAction(ClearMission, 221 )
	MisResultAction(SetRecord, 221 )
	MisResultAction(AddExp,1200,1200)
	MisResultAction(AddMoney,2400,2400)	
	MisResultAction(AddExpAndType,2,5000,5000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000090")
	MisResultAction(GiveNpcMission1, 234, MISSCRIPT_MISSIONSCRIPT02_LUA_000090, 3) 		

-----------------------------------变异的原因
	MISSCRIPT_MISSIONSCRIPT02_LUA_000091 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000091")
	DefineMission( 233, MISSCRIPT_MISSIONSCRIPT02_LUA_000091, 221, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000096 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000096")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000096)
	MisResultCondition(NoRecord, 221)
	MisResultCondition(HasMission, 221)
	MisResultCondition(NoFlag, 221, 1)
	MisResultAction(SetFlag, 221, 1 )
	


----------------------------罗森的笔记本
	MISSCRIPT_MISSIONSCRIPT02_LUA_000097 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000097")
	DefineMission( 234, MISSCRIPT_MISSIONSCRIPT02_LUA_000097, 222 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000098 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000098")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000098 )
	MisBeginCondition(NoRecord, 222)
	MisBeginCondition(HasRecord, 221)
	MisBeginCondition(NoMission, 222)
	MisBeginAction(AddMission, 222)
	MisCancelAction(ClearMission, 222)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000099 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000099")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000099)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000100 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000100")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000100)
	MisResultCondition(AlwaysFailure )

-----------------------------------罗森的笔记本
	MISSCRIPT_MISSIONSCRIPT02_LUA_000097 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000097")
	DefineMission( 235, MISSCRIPT_MISSIONSCRIPT02_LUA_000097, 222, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000101 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000101")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000101)
	MisResultCondition(NoRecord, 222)
	MisResultCondition(HasMission, 222)
	MisResultAction(ClearMission, 222 )
	MisResultAction(SetRecord, 222 )
	MisResultAction(AddExp,1200,1200)
	MisResultAction(AddMoney,2400,2400)
	MisResultAction(AddExpAndType,2,5000,5000)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000286")
	MisResultAction(GiveNpcMission1, 236, MISSCRIPT_MISSIONSCRIPT01_LUA_000286, 2) 		


----------------------------线索
	MISSCRIPT_MISSIONSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000102")
	DefineMission( 236, MISSCRIPT_MISSIONSCRIPT02_LUA_000102, 223 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000103 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000103")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000103 )
	MisBeginCondition(NoRecord, 223)
	MisBeginCondition(HasRecord, 222)
	MisBeginCondition(NoMission, 223)
	MisBeginAction(AddMission, 223)
	MisCancelAction(ClearMission, 223)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000104 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000104")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000104)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000105 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000105")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000105)
	MisResultCondition(AlwaysFailure )

-----------------------------------线索
	MISSCRIPT_MISSIONSCRIPT02_LUA_000102 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000102")
	DefineMission( 237, MISSCRIPT_MISSIONSCRIPT02_LUA_000102, 223, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000106 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000106")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000106)
	MisResultCondition(NoRecord, 223)
	MisResultCondition(HasMission, 223)
	MisResultAction(ClearMission, 223 )
	MisResultAction(SetRecord, 223 )
	MisResultAction(AddExp,600,600)
	MisResultAction(AddMoney,2400,2400)
	MisResultAction(AddExpAndType,2,5000,5000)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000107")
	MisResultAction(GiveNpcMission1, 238, MISSCRIPT_MISSIONSCRIPT02_LUA_000107, 2) 		


-------------------------------------------------内奸
	MISSCRIPT_MISSIONSCRIPT02_LUA_000108 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000108")
	DefineMission( 238, MISSCRIPT_MISSIONSCRIPT02_LUA_000108, 224 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000109 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000109")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000109 )
	MisBeginCondition(NoRecord, 224)
	MisBeginCondition(HasRecord, 223)
	MisBeginCondition(NoMission, 224)
	MisBeginAction(AddMission, 224)
	MisBeginAction(AddTrigger, 2241, TE_KILL, 45, 10 )		--沙匪
	MisBeginAction(AddTrigger, 2242, TE_KILL, 49, 5 )		--沙骑士
	MisCancelAction(ClearMission, 224)

	MisNeed(MIS_NEED_KILL, 45, 10, 10, 10)
	MisNeed(MIS_NEED_KILL, 49, 5, 20, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000110")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000110)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000111 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000111")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000111)
	MisResultCondition(HasMission, 224)
	MisResultCondition(HasFlag, 224, 19 )
	MisResultCondition(HasFlag, 224, 24 )
	MisResultAction(ClearMission, 224)
	MisResultAction(SetRecord, 224 )
	MisResultAction(AddExp,1400,1400)
	MisResultAction(AddMoney,2550,2550)	
	MisResultAction(AddExpAndType,2,5000,5000)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000107")
	MisResultAction(GiveNpcMission1, 239, MISSCRIPT_MISSIONSCRIPT02_LUA_000107, 3) 	
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 45 )	
	TriggerAction( 1, AddNextFlag, 224, 10, 10 )
	RegCurTrigger( 2241 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 49 )	
	TriggerAction( 1, AddNextFlag, 224, 20, 5 )
	RegCurTrigger( 2242 )

-------------------------------------------------战斗的沙漠
	MISSCRIPT_MISSIONSCRIPT02_LUA_000112 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000112")
	DefineMission( 239, MISSCRIPT_MISSIONSCRIPT02_LUA_000112, 225 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000113 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000113")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000113 )
	MisBeginCondition(NoRecord, 225)
	MisBeginCondition(HasRecord, 224)
	MisBeginCondition(NoMission, 225)
	MisBeginAction(AddMission, 225)
	MisBeginAction(AddTrigger, 2251, TE_GETITEM, 3979, 1 )		--沙漠王者之证
	MisCancelAction(ClearMission, 225)

	MisNeed(MIS_NEED_ITEM, 3979, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000114 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000114")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000114)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000115 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000115")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000115)
	MisResultCondition(HasMission, 225 )
	MisResultCondition(HasItem, 3979, 1 )
	MisResultAction(TakeItem, 3979, 1 )
	MisResultAction(ClearMission, 225 )
	MisResultAction(SetRecord, 225 )
	MisResultAction(AddExp,669,669)
	MisResultAction(AddMoney,1275,1275)	
	MisResultAction(AddExpAndType,2,5000,5000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000107 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000107")
	MisResultAction(GiveNpcMission1, 240, MISSCRIPT_MISSIONSCRIPT02_LUA_000107, 4) 	

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3979 )	
	TriggerAction( 1, AddNextFlag, 225, 10, 1 )
	RegCurTrigger( 2251 )

----------------------------真相
	MISSCRIPT_MISSIONSCRIPT02_LUA_000116 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000116")
	DefineMission( 240, MISSCRIPT_MISSIONSCRIPT02_LUA_000116, 226 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000117 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000117")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000117 )
	MisBeginCondition(NoRecord, 226)
	MisBeginCondition(HasRecord, 225)
	MisBeginCondition(NoMission, 226)
	MisBeginAction(AddMission, 226)
	MisCancelAction(ClearMission, 226)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000118 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000118")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000118)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000119 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000119")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000119)
	MisResultCondition(AlwaysFailure )

-----------------------------------真相
	MISSCRIPT_MISSIONSCRIPT02_LUA_000116 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000116")
	DefineMission( 241, MISSCRIPT_MISSIONSCRIPT02_LUA_000116, 226, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000120 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000120")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000120)
	MisResultCondition(NoRecord, 226)
	MisResultCondition(HasMission, 226)
	MisResultAction(ClearMission, 226 )
	MisResultAction(SetRecord, 226 )
	MisResultAction(AddExp,1500,1500)
	MisResultAction(AddMoney,2650,2650)
	MisResultAction(AddExpAndType,2,5000,5000)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000286")
	MisResultAction(GiveNpcMission1, 242, MISSCRIPT_MISSIONSCRIPT01_LUA_000286, 4) 	


----------------------------海盗的消息
	MISSCRIPT_MISSIONSCRIPT02_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000121")
	DefineMission( 242, MISSCRIPT_MISSIONSCRIPT02_LUA_000121, 227 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000122 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000122")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000122 )
	MisBeginCondition(NoRecord, 227)
	MisBeginCondition(HasRecord, 226)
	MisBeginCondition(NoMission, 227)
	MisBeginAction(AddMission, 227)
	MisCancelAction(ClearMission, 227)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000123 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000123")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000123)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000124 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000124")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000124)
	MisResultCondition(AlwaysFailure )

-----------------------------------海盗的消息
	MISSCRIPT_MISSIONSCRIPT02_LUA_000121 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000121")
	DefineMission( 243, MISSCRIPT_MISSIONSCRIPT02_LUA_000121, 227, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000125 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000125")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000125)
	MisResultCondition(NoRecord, 227 )
	MisResultCondition(HasMission, 227 )
	MisResultAction(ClearMission, 227 )
	MisResultAction(SetRecord, 227 )
	MisResultAction(AddExp,749,749)
	MisResultAction(AddMoney,1333,1333)	
	MisResultAction(AddExpAndType,2,5000,5000)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000295")
	MisResultAction(GiveNpcMission1, 244, MISSCRIPT_MISSIONSCRIPT01_LUA_000295, 2) 	


----------------------------杰克海盗团
	MISSCRIPT_MISSIONSCRIPT02_LUA_000126 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000126")
	DefineMission( 244, MISSCRIPT_MISSIONSCRIPT02_LUA_000126, 228 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000127 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000127")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000127 )
	MisBeginCondition(NoRecord, 228)
	MisBeginCondition(HasRecord, 227)
	MisBeginCondition(NoMission, 228)
	MisBeginAction(AddMission, 228)
	MisCancelAction(ClearMission, 228)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000128 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000128")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000128)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000129 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000129")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000129)
	MisResultCondition(AlwaysFailure )

-----------------------------------黑杰克海盗团
	MISSCRIPT_MISSIONSCRIPT02_LUA_000126 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000126")
	DefineMission( 245, MISSCRIPT_MISSIONSCRIPT02_LUA_000126, 228, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000130 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000130")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000130)
	MisResultCondition(NoRecord, 228 )
	MisResultCondition(HasMission, 228 )
	MisResultAction(ClearMission, 228 )
	MisResultAction(SetRecord, 228 )
	MisResultAction(AddExp,1700,1700)
	MisResultAction(AddMoney,2800,2800)
	MisResultAction(AddExpAndType,2,5000,5000)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000131")
	MisResultAction(GiveNpcMission1, 246, MISSCRIPT_MISSIONSCRIPT02_LUA_000131, 2) 	
-------------------------------------------------费克船长
	HELP_MONSTERHELP_LUA_000248 = GetResString("HELP_MONSTERHELP_LUA_000248")
	DefineMission( 246, HELP_MONSTERHELP_LUA_000248, 229 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000132 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000132")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000132 )
	MisBeginCondition(NoRecord, 229)
	MisBeginCondition(HasRecord, 228)
	MisBeginCondition(NoMission, 229)
	MisBeginAction(AddMission, 229)
	MisBeginAction(AddTrigger, 2291, TE_GETITEM, 3980, 1 )		--费克的小包
	MisCancelAction(ClearMission, 229)

	MisNeed(MIS_NEED_ITEM, 3980, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000133 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000133")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000133)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000134 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000134")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000134)
	MisResultCondition(HasMission, 229 )
	MisResultCondition(HasItem, 3980, 1 )
	MisResultAction(TakeItem, 3980, 1 )
	MisResultAction(ClearMission, 229 )
	MisResultAction(SetRecord, 229 )
	MisResultAction(AddExp,4680,4680)
	MisResultAction(AddMoney,7075,7075)	
	MisResultAction(AddExpAndType,2,5000,5000)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000131")
	MisResultAction(GiveNpcMission1, 247, MISSCRIPT_MISSIONSCRIPT02_LUA_000131, 3) 	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3980 )	
	TriggerAction( 1, AddNextFlag, 229, 10, 1 )
	RegCurTrigger( 2291 )

----------------------------寻找收信人
	MISSCRIPT_MISSIONSCRIPT02_LUA_000135 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000135")
	DefineMission( 247, MISSCRIPT_MISSIONSCRIPT02_LUA_000135, 230 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000136 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000136")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000136 )
	MisBeginCondition(NoRecord, 230)
	MisBeginCondition(HasRecord, 229)
	MisBeginCondition(NoMission, 230)
	MisBeginAction(AddMission, 230)
	MisBeginAction(GiveItem, 3981, 1, 4 )
	MisCancelAction(ClearMission, 230)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000137 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000137")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000137)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000138 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000138")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000138)
	MisResultCondition(AlwaysFailure )

-----------------------------------寻找收信人
	MISSCRIPT_MISSIONSCRIPT02_LUA_000135 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000135")
	DefineMission( 248, MISSCRIPT_MISSIONSCRIPT02_LUA_000135, 230, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000139 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000139")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000139)
	MisResultCondition(NoRecord, 230 )
	MisResultCondition(HasMission, 230 )
	MisResultCondition(HasItem, 3981, 1 )
	MisResultAction(TakeItem, 3981, 1 )
	MisResultAction(ClearMission, 230 )
	MisResultAction(SetRecord, 230 )
	MisResultAction(ObligeAcceptMission, 5 )
	MisResultAction(AddExp,936,936)
	MisResultAction(AddMoney,1415,1415)	
	MisResultAction(AddExpAndType,2,7000,7000)
	



----------------------------汇报收信人
	MISSCRIPT_EUDEMONSCRIPT_LUA_000014 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000014")
	DefineMission( 249, MISSCRIPT_EUDEMONSCRIPT_LUA_000014, 5, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000140 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000140")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000140)
	MisResultCondition(HasMission, 5 )
	MisResultCondition(NoRecord, 5 )
	MisResultAction(ClearMission, 5 )
	MisResultAction(SetRecord, 5 )
	MisResultAction(AddExp,2000,2000)
	MisResultAction(AddMoney,2800,2800)
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000131 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000131")
	MisResultAction(GiveNpcMission1, 250, MISSCRIPT_MISSIONSCRIPT02_LUA_000131, 5) 	

----------------------------去北方
	MISSCRIPT_MISSIONSCRIPT02_LUA_000141 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000141")
	DefineMission( 250, MISSCRIPT_MISSIONSCRIPT02_LUA_000141, 232 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000142 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000142")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000142 )
	MisBeginCondition(NoRecord, 232)
	MisBeginCondition(HasRecord, 5 )
	MisBeginCondition(NoMission, 232)
	MisBeginAction(AddMission, 232)
	MisCancelAction(ClearMission, 232)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000143 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000143")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000143)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000144 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000144")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000144)
	MisResultCondition(AlwaysFailure )

-----------------------------------去北方
	MISSCRIPT_MISSIONSCRIPT02_LUA_000141 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000141")
	DefineMission( 251, MISSCRIPT_MISSIONSCRIPT02_LUA_000141, 232, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000145 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000145")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000145)
	MisResultCondition(NoRecord, 232 )
	MisResultCondition(HasMission, 232 )
	MisResultAction(ClearMission, 232 )
	MisResultAction(SetRecord, 232 )
	MisResultAction(AddExp,2000,2000)
	MisResultAction(AddMoney,2900,2900)
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000368")
	MisResultAction(GiveNpcMission1, 252, MISSCRIPT_MISSIONSCRIPT01_LUA_000368, 3) 	


----------------------------冰狼堡的危机
	MISSCRIPT_MISSIONSCRIPT02_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000146")
	DefineMission( 252, MISSCRIPT_MISSIONSCRIPT02_LUA_000146, 233 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000147 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000147")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000147 )
	MisBeginCondition(NoRecord, 233)
	MisBeginCondition(HasRecord, 232)
	MisBeginCondition(NoMission, 233)
	MisBeginAction(AddMission, 233)
	MisCancelAction(ClearMission, 233)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000148 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000148")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000148)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000149 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000149")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000149)
	MisResultCondition(AlwaysFailure )

-----------------------------------去北方
	MISSCRIPT_MISSIONSCRIPT02_LUA_000146 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000146")
	DefineMission( 253, MISSCRIPT_MISSIONSCRIPT02_LUA_000146, 233, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000150 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000150")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000150)
	MisResultCondition(NoRecord, 233 )
	MisResultCondition(HasMission, 233 )
	MisResultAction(ClearMission, 233 )
	MisResultAction(SetRecord, 233 )
	MisResultAction(AddExp,2000,2000)
	MisResultAction(AddMoney,2900,2900)
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000151")
	MisResultAction(GiveNpcMission1, 254, MISSCRIPT_MISSIONSCRIPT02_LUA_000151, 2) 	


----------------------------补给
	MISSCRIPT_MISSIONSCRIPT02_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000152")
	DefineMission( 254, MISSCRIPT_MISSIONSCRIPT02_LUA_000152, 234 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000153 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000153")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000153 )
	MisBeginCondition(NoRecord, 234)
	MisBeginCondition(HasRecord, 233)
	MisBeginCondition(NoMission, 234)
	MisBeginAction(AddMission, 234)
	MisCancelAction(ClearMission, 234)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000154 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000154")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000154)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000155 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000155")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000155)
	MisResultCondition(AlwaysFailure )

-----------------------------------补给
	MISSCRIPT_MISSIONSCRIPT02_LUA_000152 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000152")
	DefineMission( 255, MISSCRIPT_MISSIONSCRIPT02_LUA_000152, 234, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000156 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000156")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000156)
	MisResultCondition(NoRecord, 234 )
	MisResultCondition(HasMission, 234 )
	MisResultAction(ClearMission, 234 )
	MisResultAction(SetRecord, 234 )
	MisResultAction(AddExp,2000,2000)
	MisResultAction(AddMoney,2800,2800)
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT01_LUA_000361 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000361")
	MisResultAction(GiveNpcMission1, 256, MISSCRIPT_MISSIONSCRIPT01_LUA_000361, 2) 	


----------------------------寻找补给队
	MISSCRIPT_MISSIONSCRIPT02_LUA_000157 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000157")
	DefineMission( 256, MISSCRIPT_MISSIONSCRIPT02_LUA_000157, 235 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000158 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000158")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000158 )
	MisBeginCondition(NoRecord, 235)
	MisBeginCondition(HasRecord, 234)
	MisBeginCondition(NoMission, 235)
	MisBeginAction(AddMission, 235)
	MisCancelAction(ClearMission, 235)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000159 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000159")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000159)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000160 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000160")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000160)
	MisResultCondition(AlwaysFailure )

-----------------------------------寻找补给队
	MISSCRIPT_MISSIONSCRIPT02_LUA_000157 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000157")
	DefineMission( 257, MISSCRIPT_MISSIONSCRIPT02_LUA_000157, 235, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000161 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000161")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000161)
	MisResultCondition(NoRecord, 235 )
	MisResultCondition(HasMission, 235 )
	MisResultAction(ClearMission, 235 )
	MisResultAction(SetRecord, 235 )
	MisResultAction(AddExp,2000,2000)
	MisResultAction(AddMoney,2800,2800)	
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000162 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000162")
	MisResultAction(GiveNpcMission1, 258, MISSCRIPT_MISSIONSCRIPT02_LUA_000162, 2) 	


-------------------------------------------------补给品夺回
	MISSCRIPT_MISSIONSCRIPT02_LUA_000163 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000163")
	DefineMission( 258, MISSCRIPT_MISSIONSCRIPT02_LUA_000163, 236 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000164 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000164")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000164 )
	MisBeginCondition(NoRecord, 236)
	MisBeginCondition(HasRecord, 235)
	MisBeginCondition(NoMission, 236)
	MisBeginAction(AddMission, 236)
	MisBeginAction(AddTrigger, 2361, TE_GETITEM, 3982, 10 )		--被抢的补给品
	MisCancelAction(ClearMission, 236)

	MisNeed(MIS_NEED_ITEM, 3982, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000165 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000165")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000165)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000166 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000166")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000166)
	MisResultCondition(HasMission, 236 )
	MisResultCondition(HasItem, 3982, 10 )
	MisResultAction(TakeItem, 3982, 10 )
	MisResultAction(ClearMission, 236 )
	MisResultAction(SetRecord, 236 )
	MisResultAction(AddExp,2000,2000)
	MisResultAction(AddMoney,2800,2800)
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000162 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000162")
	MisResultAction(GiveNpcMission1, 259, MISSCRIPT_MISSIONSCRIPT02_LUA_000162, 3) 	

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3982 )	
	TriggerAction( 1, AddNextFlag, 236, 10, 10 )
	RegCurTrigger( 2361 )


----------------------------护送补给品
	MISSCRIPT_MISSIONSCRIPT02_LUA_000167 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000167")
	DefineMission( 259, MISSCRIPT_MISSIONSCRIPT02_LUA_000167, 237 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000168 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000168")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000168 )
	MisBeginCondition(NoRecord, 237)
	MisBeginCondition(HasRecord, 236)
	MisBeginCondition(NoMission, 237)
	MisBeginAction(AddMission, 237)
	MisBeginAction(GiveItem, 3983, 10, 4)
	MisCancelAction(ClearMission, 237)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000169 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000169")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000169)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000170 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000170")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000170)
	MisResultCondition(AlwaysFailure )

-----------------------------------护送补给品
	MISSCRIPT_MISSIONSCRIPT02_LUA_000167 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000167")
	DefineMission( 260, MISSCRIPT_MISSIONSCRIPT02_LUA_000167, 237, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000171 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000171")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000171)
	MisResultCondition(NoRecord, 237 )
	MisResultCondition(HasMission, 237)
	MisResultCondition(HasItem, 3983, 10 )
	MisResultAction(TakeItem, 3983, 10 )
	MisResultAction(ClearMission, 237 )
	MisResultAction(SetRecord, 237 )
	MisResultAction(AddExp,2300,2300)
	MisResultAction(AddMoney,2900,2900)	
	MisResultAction(AddExpAndType,2,7000,7000)

	MISSCRIPT_MISSIONSCRIPT01_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000368")
	MisResultAction(GiveNpcMission1, 261, MISSCRIPT_MISSIONSCRIPT01_LUA_000368, 5) 	
	
----------------------------事件调查
	MISSCRIPT_MISSIONSCRIPT02_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000172")
	DefineMission( 261, MISSCRIPT_MISSIONSCRIPT02_LUA_000172, 238 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000173 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000173")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000173 )
	MisBeginCondition(NoRecord, 238)
	MisBeginCondition(HasRecord, 237)
	MisBeginCondition(NoMission, 238)
	MisBeginAction(AddMission, 238)
	MisCancelAction(ClearMission, 238)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000174 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000174")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000174)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000175 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000175")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000175)
	MisResultCondition(AlwaysFailure )

-----------------------------------事件调查
	MISSCRIPT_MISSIONSCRIPT02_LUA_000172 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000172")
	DefineMission( 262, MISSCRIPT_MISSIONSCRIPT02_LUA_000172, 238, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000176 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000176")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000176)
	MisResultCondition(NoRecord, 238 )
	MisResultCondition(HasMission, 238)
	MisResultAction(ClearMission, 238 )
	MisResultAction(SetRecord, 238 )
	MisResultAction(AddExp,2600,2600)
	MisResultAction(AddMoney,3000,3000)
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000177")
	MisResultAction(GiveNpcMission1, 263, MISSCRIPT_MISSIONSCRIPT02_LUA_000177, 2) 	


-------------------------------------------------雪原生物
	MISSCRIPT_MISSIONSCRIPT02_LUA_000178 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000178")
	DefineMission( 263, MISSCRIPT_MISSIONSCRIPT02_LUA_000178, 239 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000179 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000179")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000179 )
	MisBeginCondition(NoRecord, 239)
	MisBeginCondition(HasRecord, 238)
	MisBeginCondition(NoMission, 239)
	MisBeginAction(AddMission, 239)
	MisBeginAction(AddTrigger, 2391, TE_GETITEM, 3984, 5 )		--雪娃娃的记忆石
	MisBeginAction(AddTrigger, 2392, TE_GETITEM, 4069, 5 )		--雪女的记忆石
	MisBeginAction(AddTrigger, 2393, TE_GETITEM, 4070, 5 )		--雪人的记忆石
	MisCancelAction(ClearMission, 239)

	MisNeed(MIS_NEED_ITEM, 3984, 5, 10, 5)
	MisNeed(MIS_NEED_ITEM, 4069, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 4070, 5, 30, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000180 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000180")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000180)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000181 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000181")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000181)
	MisResultCondition(HasMission, 239 )
	MisResultCondition(HasItem, 3984, 5 )
	MisResultCondition(HasItem, 4069, 5 )
	MisResultCondition(HasItem, 4069, 5 )
	MisResultAction(TakeItem, 3984, 5 )
	MisResultAction(TakeItem, 4069, 5 )
	MisResultAction(TakeItem, 4070, 5 )
	MisResultAction(ClearMission, 239 )
	MisResultAction(SetRecord, 239 )
	MisResultAction(AddExp,3000,3000)
	MisResultAction(AddMoney,3000,3000)	
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000177")
	MisResultAction(GiveNpcMission1, 264, MISSCRIPT_MISSIONSCRIPT02_LUA_000177, 3) 

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3984 )	
	TriggerAction( 1, AddNextFlag, 239, 10, 5 )
	RegCurTrigger( 2391 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4069 )	
	TriggerAction( 1, AddNextFlag, 239, 20, 5 )
	RegCurTrigger( 2392 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4070 )	
	TriggerAction( 1, AddNextFlag, 239, 30, 5 )
	RegCurTrigger( 2393 )

-------------------------------------------------寻找雪人王
	MISSCRIPT_MISSIONSCRIPT02_LUA_000182 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000182")
	DefineMission( 264, MISSCRIPT_MISSIONSCRIPT02_LUA_000182, 240 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000183 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000183")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000183 )
	MisBeginCondition(NoRecord, 240)
	MisBeginCondition(HasRecord, 239)
	MisBeginCondition(NoMission, 240)
	MisBeginAction(AddMission, 240)
	MisBeginAction(AddTrigger, 2401, TE_GETITEM, 4071, 1 )		--雪娃娃的记忆石
	MisCancelAction(ClearMission, 240)

	MisNeed(MIS_NEED_ITEM, 4071, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000184 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000184")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000184)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000185 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000185")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000185)
	MisResultCondition(HasMission, 240 )
	MisResultCondition(HasItem, 4071, 1 )
	MisResultAction(TakeItem, 4071, 1 )
	MisResultAction(ClearMission, 240 )
	MisResultAction(SetRecord, 240 )
	MisResultAction(AddExp,16000,16000)
	MisResultAction(AddMoney,16000,16000)	
	MisResultAction(AddExpAndType,2,7000,7000)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000177 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000177")
	MisResultAction(GiveNpcMission1, 265, MISSCRIPT_MISSIONSCRIPT02_LUA_000177, 4) 

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4071 )	
	TriggerAction( 1, AddNextFlag, 240, 10, 1 )
	RegCurTrigger( 2401 )

----------------------------白银城的智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_000186 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000186")
	DefineMission( 265, MISSCRIPT_MISSIONSCRIPT02_LUA_000186, 241 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000187 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000187")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000187 )
	MisBeginCondition(NoRecord, 241 )
	MisBeginCondition(HasRecord, 240 )
	MisBeginCondition(NoMission, 241 )
	MisBeginAction(AddMission, 241 )
	MisCancelAction(ClearMission, 241 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000188 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000188")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000188)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000189 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000189")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000189)
	MisResultCondition(AlwaysFailure )

-----------------------------------白银城的智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_000186 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000186")
	DefineMission( 266, MISSCRIPT_MISSIONSCRIPT02_LUA_000186, 241, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000190 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000190")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000190)
	MisResultCondition(NoRecord, 241 )
	MisResultCondition(HasMission, 241)
	MisResultAction(ClearMission, 241 )
	MisResultAction(SetRecord, 241 )
	MisResultAction(AddExp,3200,3200)
	MisResultAction(AddMoney,3100,3100)	
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000191")
	MisResultAction(GiveNpcMission1, 267, MISSCRIPT_MISSIONSCRIPT02_LUA_000191, 2) 



-------------------------------------------------糊涂山人
	MISSCRIPT_MISSIONSCRIPT02_LUA_000192 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000192")
	DefineMission( 267, MISSCRIPT_MISSIONSCRIPT02_LUA_000192, 242 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000193 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000193")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000193 )
	MisBeginCondition(NoRecord, 242)
	MisBeginCondition(HasRecord, 241)
	MisBeginCondition(NoMission, 242)
	MisBeginAction(AddMission, 242)
	MisBeginAction(AddTrigger, 2421, TE_GETITEM, 4072, 1 )		--雪娃娃的记忆石
	MisCancelAction(ClearMission, 242)

	MisNeed(MIS_NEED_ITEM, 4072, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000194 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000194")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000194)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000195 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000195")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000195)
	MisResultCondition(HasMission, 242 )
	MisResultCondition(HasItem, 4072, 1 )
	MisResultAction(TakeItem, 4072, 1 )
	MisResultAction(ClearMission, 242 )
	MisResultAction(SetRecord, 242 )
	MisResultAction(AddExp,7000,7000)
	MisResultAction(AddMoney,6000,6000)	
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000191")
	MisResultAction(GiveNpcMission1, 270, MISSCRIPT_MISSIONSCRIPT02_LUA_000191, 3) 
	
	
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 4072 )	
	TriggerAction( 1, AddNextFlag, 242, 10, 1 )
	RegCurTrigger( 2421 )

-----------------------------------糊涂山人
	MISSCRIPT_MISSIONSCRIPT02_LUA_000192 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000192")
	DefineMission( 268, MISSCRIPT_MISSIONSCRIPT02_LUA_000192, 242, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000196 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000196")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000196)
	MisResultCondition(NoRecord, 242 )
	MisResultCondition(HasMission, 242)
	MisResultCondition(NoFlag, 242, 1 )
	MisResultAction(SetFlag, 242, 1 )


-------------------------------------------------山珍八宝酒
	MISSCRIPT_MISSIONSCRIPT02_LUA_000197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000197")
	DefineMission( 269, MISSCRIPT_MISSIONSCRIPT02_LUA_000197, 243 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000198 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000198")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000198 )
	MisBeginCondition(NoRecord, 243)
	MisBeginCondition(HasMission, 242)
	MisBeginCondition(HasFlag, 242, 1)
	MisBeginCondition(NoMission, 243)
	MisBeginAction(AddMission, 243)
	MisBeginAction(AddTrigger, 2431, TE_GETITEM, 4073, 2 )		--恐龟蛋
	MisBeginAction(AddTrigger, 2432, TE_GETITEM, 4074, 2 )		--野猪的腱子肉
	MisBeginAction(AddTrigger, 2433, TE_GETITEM, 4075, 2 )		--曼陀罗的藤蔓
	MisBeginAction(AddTrigger, 2434, TE_GETITEM, 4076, 2 )		--矿物的结晶粉末
	MisCancelAction(ClearMission, 243)

	MisNeed(MIS_NEED_ITEM, 4073, 2, 10, 2)
	MisNeed(MIS_NEED_ITEM, 4074, 2, 12, 2)
	MisNeed(MIS_NEED_ITEM, 4075, 2, 14, 2)
	MisNeed(MIS_NEED_ITEM, 4076, 2, 16, 2)


	MISSCRIPT_MISSIONSCRIPT02_LUA_000199 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000199")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000199)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000200 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000200")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000200)
	MisResultCondition(HasMission, 243 )
	MisResultCondition(HasItem, 4073, 2 )
	MisResultCondition(HasItem, 4074, 2 )
	MisResultCondition(HasItem, 4075, 2 )
	MisResultCondition(HasItem, 4076, 2 )
	MisResultAction(TakeItem, 4073, 2 )
	MisResultAction(TakeItem, 4074, 2 )
	MisResultAction(TakeItem, 4075, 2 )
	MisResultAction(TakeItem, 4076, 2 )
	MisResultAction(ClearMission, 243 )
	MisResultAction(SetRecord, 243 )
	MisResultAction(AddExp,3200,3200)
	MisResultAction(AddMoney,3100,3100)
	MisResultAction(AddExpAndType,2,9035,9035)
	

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4073 )	
	TriggerAction( 1, AddNextFlag, 243, 10, 2 )
	RegCurTrigger( 2431 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4074 )	
	TriggerAction( 1, AddNextFlag, 243, 12, 2 )
	RegCurTrigger( 2432 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4075 )	
	TriggerAction( 1, AddNextFlag, 243, 14, 2 )
	RegCurTrigger( 2433 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4076 )	
	TriggerAction( 1, AddNextFlag, 243, 16, 2 )
	RegCurTrigger( 2434 )


----------------------------陈年旧事
	MISSCRIPT_MISSIONSCRIPT02_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000201")
	DefineMission( 270, MISSCRIPT_MISSIONSCRIPT02_LUA_000201, 244 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000202 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000202")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000202 )
	MisBeginCondition(NoRecord, 244 )
	MisBeginCondition(HasRecord, 242 )
	MisBeginCondition(NoMission, 244 )
	MisBeginAction(AddMission, 244 )
	MisCancelAction(ClearMission, 244 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000203 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000203")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000203)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000204 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000204")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000204)
	MisResultCondition(AlwaysFailure )

-----------------------------------陈年旧事
	MISSCRIPT_MISSIONSCRIPT02_LUA_000201 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000201")
	DefineMission( 271, MISSCRIPT_MISSIONSCRIPT02_LUA_000201, 244, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000205 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000205")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000205)
	MisResultCondition(NoRecord, 244 )
	MisResultCondition(HasMission, 244)
	MisResultAction(ClearMission, 244 )
	MisResultAction(SetRecord, 244 )
	MisResultAction(ObligeAcceptMission, 6 )
	MISSCRIPT_MISSIONSCRIPT02_LUA_000206 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000206")
	MisResultAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT02_LUA_000206 )
	MisResultAction(AddExp,3500,3500)
	MisResultAction(AddMoney,3150,3150)
	MisResultAction(AddExpAndType,2,9035,9035)
	
	



----------------------------询问未果
	MISSCRIPT_EUDEMONSCRIPT_LUA_000017 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000017")
	DefineMission( 272, MISSCRIPT_EUDEMONSCRIPT_LUA_000017, 6 )
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000207 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000207")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000207)
	MisResultCondition(HasMission, 6 )
	MisResultAction(ClearMission, 6 )
	MisResultAction(SetRecord, 6 )
	MisResultAction(AddExp,1768,1768)
	MisResultAction(AddMoney,1565,1565)
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000191")
	MisResultAction(GiveNpcMission1, 273, MISSCRIPT_MISSIONSCRIPT02_LUA_000191, 5) 
	



----------------------------会长的把柄
	MISSCRIPT_MISSIONSCRIPT02_LUA_000208 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000208")
	DefineMission( 273, MISSCRIPT_MISSIONSCRIPT02_LUA_000208, 246 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000209 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000209")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000209 )
	MisBeginCondition(NoRecord, 246 )
	MisBeginCondition(HasRecord, 6 )
	MisBeginCondition(NoMission, 246 )
	MisBeginAction(AddMission, 246 )
	MisCancelAction(ClearMission, 246 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000210 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000210")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000210)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000211 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000211")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000211)
	MisResultCondition(AlwaysFailure )

-----------------------------------会长的把柄
	MISSCRIPT_MISSIONSCRIPT02_LUA_000208 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000208")
	DefineMission( 274, MISSCRIPT_MISSIONSCRIPT02_LUA_000208, 246, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000212 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000212")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000212)
	MisResultCondition(NoRecord, 246 )
	MisResultCondition(HasMission, 246)
	MisResultAction(ClearMission, 246 )
	MisResultAction(SetRecord, 246 )
	MisResultAction(AddExp,3600,3600)
	MisResultAction(AddMoney,3100,3100)	
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000012")
	MisResultAction(GiveNpcMission1, 275, MISSCRIPT_MISSIONSCRIPT02_LUA_000012, 8) 


-------------------------------------------------废矿探索
	MISSCRIPT_MISSIONSCRIPT02_LUA_000213 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000213")
	DefineMission( 275, MISSCRIPT_MISSIONSCRIPT02_LUA_000213, 247 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000214 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000214")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000214 )
	MisBeginCondition(NoRecord, 247)
	MisBeginCondition(HasRecord, 246)
	MisBeginCondition(NoMission, 247)
	MisBeginAction(AddMission, 247)
	MisBeginAction(AddTrigger, 2471, TE_GETITEM, 4081, 10 )		--破旧的纸片
	MisCancelAction(ClearMission, 247)

	MisNeed(MIS_NEED_ITEM, 4081, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000215 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000215")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000215)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000216 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000216")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000216)
	MisResultCondition(HasMission, 247 )
	MisResultCondition(HasItem, 4081, 10 )
	MisResultAction(TakeItem, 4081, 10 )
	MisResultAction(ClearMission, 247 )
	MisResultAction(SetRecord, 247 )
	MisResultAction(AddExp,4000,4000)
	MisResultAction(AddMoney,3200,3200)
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000012")
	MisResultAction(GiveNpcMission1, 276, MISSCRIPT_MISSIONSCRIPT02_LUA_000012, 9) 

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4081 )	
	TriggerAction( 1, AddNextFlag, 247, 10, 10 )
	RegCurTrigger( 2471 )

----------------------------纸片的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_000217 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000217")
	DefineMission( 276, MISSCRIPT_MISSIONSCRIPT02_LUA_000217, 248 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000218 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000218")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000218 )
	MisBeginCondition(NoRecord, 248 )
	MisBeginCondition(HasRecord, 247 )
	MisBeginCondition(NoMission, 248 )
	MisBeginAction(AddMission, 248 )
	MisBeginAction(GiveItem, 4082, 1, 4 )
	MisCancelAction(ClearMission, 248 )
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000219 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000219")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000219)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000220 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000220")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000220)
	MisResultCondition(AlwaysFailure )

-----------------------------------纸片的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_000217 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000217")
	DefineMission( 277, MISSCRIPT_MISSIONSCRIPT02_LUA_000217, 248, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000221 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000221")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000221)
	MisResultCondition(NoRecord, 248 )
	MisResultCondition(HasMission, 248)
	MisResultCondition(HasItem, 4082, 1)
	MisResultAction(ClearMission, 248 )
	MisResultAction(SetRecord, 248 )
	MisResultAction(AddExp,4000,4000)
	MisResultAction(AddMoney,3200,3200)
	MisResultAction(AddExpAndType,2,9035,9035)
	
	--MisResultAction(GiveNpcMission1, 278, "会长·劳伦迪马斯", 3) 


----------------------------逃跑的巨兽
	MISSCRIPT_MISSIONSCRIPT02_LUA_000222 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000222")
	DefineMission( 278, MISSCRIPT_MISSIONSCRIPT02_LUA_000222, 249 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000223 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000223")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000223 )
	MisBeginCondition(NoRecord, 249 )
	MisBeginCondition(HasRecord, 248 )
	MisBeginCondition(NoMission, 249 )
	MisBeginAction(AddMission, 249 )
	MisCancelAction(ClearMission, 249 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000224 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000224")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000224)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000225 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000225")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000225)
	MisResultCondition(AlwaysFailure )

-----------------------------------逃跑的巨兽
	MISSCRIPT_MISSIONSCRIPT02_LUA_000222 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000222")
	DefineMission( 279, MISSCRIPT_MISSIONSCRIPT02_LUA_000222, 249, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000226 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000226")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000226)
	MisResultCondition(NoRecord, 249 )
	MisResultCondition(HasMission, 249)
	MisResultAction(ClearMission, 249 )
	MisResultAction(SetRecord, 249 )
	MisResultAction(AddExp,5000,5000)
	MisResultAction(AddMoney,1700,1700)	
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000227 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000227")
	MisResultAction(GiveNpcMission1, 281, MISSCRIPT_MISSIONSCRIPT02_LUA_000227, 4) 




-------------------------------------------------古老的悬赏令
	MISSCRIPT_MISSIONSCRIPT02_LUA_000228 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000228")
	DefineMission( 280, MISSCRIPT_MISSIONSCRIPT02_LUA_000228, 250 )

--	DefineMission( 280, "古老的悬赏令", 250 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000229 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000229")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000229 )
	MisBeginCondition(NoRecord, 250)
	MisBeginCondition(HasRecord, 248)
	MisBeginCondition(NoMission, 250)
	MisBeginCondition(HasItem, 4082, 1)
	MisBeginAction(AddMission, 250)
	MisBeginAction(AddTrigger, 2501, TE_GETITEM, 4083, 1 )		--镣铐x1
	MisCancelAction(ClearMission, 250)

	MisNeed(MIS_NEED_ITEM, 4083, 1, 10, 1)

	MisPrize(MIS_PRIZE_MONEY, 34464, 1)
	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_000230 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000230")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000230)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000231 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000231")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000231)
	MisResultCondition(HasMission, 250 )
	MisResultCondition(HasItem, 4083, 1 )
	MisResultCondition(HasItem, 4082, 1 )
	MisResultAction(TakeItem, 4083, 1 )
	MisResultAction(TakeItem, 4082, 1 )
	MisResultAction(ClearMission, 250 )
	MisResultAction(SetRecord, 250 )
	MisResultAction(AddExp,13245,13245)
	MisResultAction(AddExpAndType,2,9035,9035)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4083 )	
	TriggerAction( 1, AddNextFlag, 250, 10, 1 )
	RegCurTrigger( 2501 )

----------------------------可怕的怪物
	MISSCRIPT_MISSIONSCRIPT02_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000232")
	DefineMission( 281, MISSCRIPT_MISSIONSCRIPT02_LUA_000232, 251 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000233 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000233")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000233 )
	MisBeginCondition(NoRecord, 251 )
	MisBeginCondition(HasRecord, 249 )
	MisBeginCondition(NoMission, 251 )
	MisBeginAction(AddMission, 251 )
	MisCancelAction(ClearMission, 251 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000234 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000234")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000234)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000235 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000235")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000235)
	MisResultCondition(AlwaysFailure )

-----------------------------------可怕的怪物
	MISSCRIPT_MISSIONSCRIPT02_LUA_000232 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000232")
	DefineMission( 282, MISSCRIPT_MISSIONSCRIPT02_LUA_000232, 251, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000236 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000236")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000236)
	MisResultCondition(NoRecord, 251 )
	MisResultCondition(HasMission, 251)
	MisResultAction(ClearMission, 251 )
	MisResultAction(SetRecord, 251 )
	MisResultAction(AddExp,4000,4000)
	MisResultAction(AddMoney,2000,2000)	
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000237 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000237")
	MisResultAction(GiveNpcMission1, 283, MISSCRIPT_MISSIONSCRIPT02_LUA_000237, 2) 	


----------------------------老奶奶的糕点
	MISSCRIPT_MISSIONSCRIPT02_LUA_000238 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000238")
	DefineMission( 283, MISSCRIPT_MISSIONSCRIPT02_LUA_000238, 252 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000239 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000239")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000239 )
	MisBeginCondition(NoRecord, 252 )
	MisBeginCondition(HasRecord, 251 )
	MisBeginCondition(NoMission, 252 )
	MisBeginAction(AddMission, 252 )
	MisCancelAction(ClearMission, 252 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000240 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000240")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000240)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000241 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000241")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000241)
	MisResultCondition(AlwaysFailure )

-----------------------------------老奶奶的糕点
	MISSCRIPT_MISSIONSCRIPT02_LUA_000238 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000238")
	DefineMission( 284, MISSCRIPT_MISSIONSCRIPT02_LUA_000238, 252, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000242 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000242")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000242)
	MisResultCondition(NoRecord, 252 )
	MisResultCondition(HasMission, 252)
	MisResultAction(ClearMission, 252 )
	MisResultAction(SetRecord, 252 )
	MisResultAction(AddExp,4000,4000)
	MisResultAction(AddMoney,2000,2000)
	MisResultAction(AddExpAndType,2,9035,9035)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000243 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000243")
	MisResultAction(GiveNpcMission1, 285, MISSCRIPT_MISSIONSCRIPT02_LUA_000243, 5) 	


-------------------------------------------------被夺走的便当
	MISSCRIPT_MISSIONSCRIPT02_LUA_000244 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000244")
	DefineMission( 285, MISSCRIPT_MISSIONSCRIPT02_LUA_000244, 253 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000245 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000245")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000245 )
	MisBeginCondition(HasRecord, 252)
	MisBeginCondition(NoMission, 253)
	MisBeginCondition(NoRecord, 250)
	MisBeginCondition(NoRecord, 253)  --暂时不许重复接
	MisBeginCondition(NoMission, 4)
	MisBeginAction(AddMission, 253)
	MisBeginAction(AddTrigger, 2531, TE_GETITEM, 4084, 1 )		--便当x1
	MisCancelAction(ClearMission, 253)

	MisNeed(MIS_NEED_ITEM, 4084, 1, 10, 1)

	MisPrize(MIS_PRIZE_ITEM, 3917, 1, 4)
	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_000246 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000246")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000246)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000247 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000247")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000247)
	MisResultCondition(HasMission, 253 )
	MisResultCondition(HasItem, 4084, 1 )
	MisResultAction(TakeItem, 4084, 1 )
	MisResultAction(ClearMission, 253 )
	MisResultAction(SetRecord, 253 )
	MisResultAction(ObligeAcceptMission, 4 )
	MisResultAction(AddTrigger, 109, TE_KILL, 99, 1 )
	--MisResultAction(AddTrigger, 108, TE_GAMETIME, TT_MULTITIME, 60, 1 )
	MisResultAction(AddExp,4500,4500)
	MisResultAction(AddMoney,2000,2000)
	MisResultAction(AddExpAndType,2,9035,9035)
	MisResultBagNeed(1)


	InitTrigger()
	TriggerCondition( 1, IsItem, 4084 )	
	TriggerAction( 1, AddNextFlag, 253, 10, 1 )
	RegCurTrigger( 2531 )
	InitTrigger()
	TriggerCondition( 1, NoMisssionFailure, 4 )
	TriggerCondition( 1, IsMonster, 99 )
	TriggerAction( 1, AddNextFlag, 4, 10, 1 )
	RegCurTrigger( 109 )
	--InitTrigger()
	--TriggerCondition( 1, NoFlag, 4, 10 )
	--TriggerAction( 1, SystemNotice, "任务时间计时已到,引诱巨兽任务失败！" )
	--TriggerAction( 1, SetMissionFailure, 4 )
	--RegCurTrigger( 108 )

-------------------------------------------------海上补给站
	MISSCRIPT_MISSIONSCRIPT02_LUA_000248 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000248")
	DefineMission( 286, MISSCRIPT_MISSIONSCRIPT02_LUA_000248, 254 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000249 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000249")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000249 )
	MisBeginCondition(NoRecord, 254)
	MisBeginCondition(HasRecord, 250)
	MisBeginCondition(NoMission, 254)
	MisBeginAction(AddMission, 254)
	MisCancelAction(ClearMission, 254)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000250 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000250")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000250)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000251 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000251")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000251)
	MisResultCondition(AlwaysFailure )

-------------------------------------------------山珍八宝酒
	MISSCRIPT_MISSIONSCRIPT02_LUA_000197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000197")
	DefineMission( 288, MISSCRIPT_MISSIONSCRIPT02_LUA_000197, 255 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000252 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000252")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000252 )
	MisBeginCondition(NoRecord, 255)
	MisBeginCondition(HasRecord, 243)
	MisBeginCondition(HasMission, 242)
	MisBeginCondition(NoMission, 255)
	MisBeginAction(AddMission, 255)
	MisBeginAction(AddTrigger, 2551, TE_GETITEM, 4077, 2 )		--竹叶上的露珠
	MisBeginAction(AddTrigger, 2552, TE_GETITEM, 4078, 2 )		--养颜的珍珠粉
	MisBeginAction(AddTrigger, 2553, TE_GETITEM, 4079, 2 )		--走私香料
	MisBeginAction(AddTrigger, 2554, TE_GETITEM, 4080, 3 )		--袋鼠的私酿
	MisCancelAction(ClearMission, 255)

	MisNeed(MIS_NEED_ITEM, 4077, 2, 18, 2)
	MisNeed(MIS_NEED_ITEM, 4078, 2, 20, 2)
	MisNeed(MIS_NEED_ITEM, 4079, 2, 22, 2)
	MisNeed(MIS_NEED_ITEM, 4080, 3, 24, 3)

	MisPrize(MIS_PRIZE_ITEM, 4072, 1, 4)
	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_000253 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000253")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000253)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000200 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000200")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000200)
	MisResultCondition(HasMission, 255 )
	MisResultCondition(HasItem, 4077, 2 )
	MisResultCondition(HasItem, 4078, 2 )
	MisResultCondition(HasItem, 4079, 2 )
	MisResultCondition(HasItem, 4080, 3 )
	MisResultAction(TakeItem, 4077, 2 )
	MisResultAction(TakeItem, 4078, 2 )
	MisResultAction(TakeItem, 4079, 2 )
	MisResultAction(TakeItem, 4080, 3 )
	MisResultAction(ClearMission, 255 )
	MisResultAction(SetRecord, 255 )
	MisResultAction(AddExp,1595,1595)
	MisResultAction(AddMoney,1538,1538)
	MisResultAction(AddExpAndType,2,9035,9035)
	MisResultBagNeed(1)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4077 )	
	TriggerAction( 1, AddNextFlag, 255, 18, 2 )
	RegCurTrigger( 2551 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4078 )	
	TriggerAction( 1, AddNextFlag, 255, 20, 2 )
	RegCurTrigger( 2552 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4079 )	
	TriggerAction( 1, AddNextFlag, 255, 22, 2 )
	RegCurTrigger( 2553 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4080 )	
	TriggerAction( 1, AddNextFlag, 255, 24, 3 )
	RegCurTrigger( 2554 )

-----------------------------------海上补给站
	MISSCRIPT_MISSIONSCRIPT02_LUA_000248 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000248")
	DefineMission( 289, MISSCRIPT_MISSIONSCRIPT02_LUA_000248, 254, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000254 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000254")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000254)
	MisResultCondition(NoRecord, 254 )
	MisResultCondition(HasMission, 254)
	MisResultAction(ClearMission, 254 )
	MisResultAction(SetRecord, 254 )
	MisResultAction(AddExp,5000,5000)	
	MisResultAction(AddMoney,2000,2000)	
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------航线活地图
	MISSCRIPT_MISSIONSCRIPT02_LUA_000255 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000255")
	DefineMission( 290, MISSCRIPT_MISSIONSCRIPT02_LUA_000255, 256 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000256 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000256")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000256 )
	MisBeginCondition(NoRecord, 256)
	MisBeginCondition(HasRecord, 254)
	MisBeginCondition(NoMission, 256)
	MisBeginAction(AddMission, 256)
	MisCancelAction(ClearMission, 256)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000257 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000257")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000257)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000258 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000258")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000258)
	MisResultCondition(AlwaysFailure )

-----------------------------------航线活地图
	MISSCRIPT_MISSIONSCRIPT02_LUA_000255 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000255")
	DefineMission( 291, MISSCRIPT_MISSIONSCRIPT02_LUA_000255, 256, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000259 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000259")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000259)
	MisResultCondition(NoRecord, 256 )
	MisResultCondition(HasMission, 256)
	MisResultAction(ClearMission, 256 )
	MisResultAction(SetRecord, 256 )
	MisResultAction(AddExp,2649,2649)
	MisResultAction(AddMoney,1680,1680)
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------挑战水母
	MISSCRIPT_MISSIONSCRIPT02_LUA_000260 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000260")
	DefineMission( 292, MISSCRIPT_MISSIONSCRIPT02_LUA_000260, 257 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000261 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000261")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000261 )
	MisBeginCondition(NoRecord, 257)
	MisBeginCondition(HasRecord, 256)
	MisBeginCondition(NoMission, 257)
	MisBeginAction(AddMission, 257)
	MisBeginAction(AddTrigger, 2571, TE_GETITEM, 4140, 15 )		--竹叶上的露珠
	MisCancelAction(ClearMission, 257)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000262 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000262")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000262)
	MisNeed(MIS_NEED_ITEM, 4140, 15, 10, 15)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000263 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000263")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000263)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000264 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000264")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000264)
	MisResultCondition(HasMission, 257 )
	MisResultCondition(HasItem, 4140, 15 )
	MisResultAction(TakeItem, 4140, 15 )
	MisResultAction(ClearMission, 257 )
	MisResultAction(SetRecord, 257 )
	MisResultAction(AddExp,5848,5848)
	MisResultAction(AddMoney,3422,3422)	
	MisResultAction(AddExpAndType,2,26625,26625)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4140 )	
	TriggerAction( 1, AddNextFlag, 257, 10, 15 )
	RegCurTrigger( 2571 )

-------------------------------------------------跑船
	MISSCRIPT_MISSIONSCRIPT02_LUA_000265 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000265")
	DefineMission( 293, MISSCRIPT_MISSIONSCRIPT02_LUA_000265, 258 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000266 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000266")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000266 )
	MisBeginCondition(NoRecord, 258)
	MisBeginCondition(HasRecord, 257)
	MisBeginCondition(NoMission, 258)
	MisBeginAction(AddMission, 258)
	MisBeginAction(GiveItem, 4141, 1, 4)
	MisCancelAction(ClearMission, 258)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000267 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000267")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000267)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000268 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000268")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000268)
	MisResultCondition(AlwaysFailure )

-----------------------------------跑船
	MISSCRIPT_MISSIONSCRIPT02_LUA_000265 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000265")
	DefineMission( 294, MISSCRIPT_MISSIONSCRIPT02_LUA_000265, 258, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000269 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000269")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000269)
	MisResultCondition(NoRecord, 258 )
	MisResultCondition(HasMission, 258)
	MisResultCondition(HasItem, 4141, 1)
	MisResultAction(TakeItem, 4141, 1 )
	MisResultAction(ClearMission, 258 )
	MisResultAction(SetRecord, 258 )
	MisResultAction(AddExp,2924,2924)	
	MisResultAction(AddMoney,1711,1711)	
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------孪生兄弟
	MISSCRIPT_MISSIONSCRIPT02_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000270")
	DefineMission( 295, MISSCRIPT_MISSIONSCRIPT02_LUA_000270, 259 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000271 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000271")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000271 )
	MisBeginCondition(NoRecord, 259)
	MisBeginCondition(HasRecord, 258)
	MisBeginCondition(NoMission, 259)
	MisBeginAction(AddMission, 259)
	MisBeginAction(GiveItem, 4142, 1, 4)
	MisBeginBagNeed(1)
	MisCancelAction(ClearMission, 259)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000272 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000272")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000272)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000273 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000273")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000273)
	MisResultCondition(AlwaysFailure )

-----------------------------------孪生兄弟
	MISSCRIPT_MISSIONSCRIPT02_LUA_000270 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000270")
	DefineMission( 296, MISSCRIPT_MISSIONSCRIPT02_LUA_000270, 259, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000274 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000274")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000274)
	MisResultCondition(NoRecord, 259 )
	MisResultCondition(HasMission, 259)
	MisResultCondition(HasItem, 4142, 1)
	MisResultAction(TakeItem, 4142, 1 )
	MisResultAction(ClearMission, 259 )
	MisResultAction(SetRecord, 259 )
	MisResultAction(AddExp,3225,3225)	
	MisResultAction(AddMoney,1742,1742)	
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------准备活动
	MISSCRIPT_MISSIONSCRIPT02_LUA_000275 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000275")
	DefineMission( 297, MISSCRIPT_MISSIONSCRIPT02_LUA_000275, 260 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000276 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000276")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000276)
	MisBeginCondition(NoRecord, 260)
	MisBeginCondition(HasRecord, 259)
	MisBeginCondition(NoMission, 260)
	MisBeginAction(AddMission, 260)
	MisBeginAction(AddTrigger, 2601, TE_GETITEM, 4143, 12)		
	MisCancelAction(ClearMission, 260)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000277 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000277")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000277)
	MisNeed(MIS_NEED_ITEM, 4143, 12, 10, 12)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000278 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000278")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000278)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000279 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000279")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000279)
	MisResultCondition(HasMission, 260 )
	MisResultCondition(HasItem, 4143, 12 )
	MisResultAction(TakeItem, 4143, 12 )
	MisResultAction(GiveItem, 4144, 1, 4 )
	MisResultAction(ClearMission, 260 )
	MisResultAction(SetRecord, 260 )
	MisResultAction(AddExp,7110,7110)	
	MisResultAction(AddMoney,3548,3548)	
	MisResultAction(AddExpAndType,2,26625,26625)
	MisResultBagNeed(1)

	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4143 )	
	TriggerAction( 1, AddNextFlag, 260, 10, 12 )
	RegCurTrigger( 2601 )

-------------------------------------------------祝福之手
	MISSCRIPT_MISSIONSCRIPT02_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000280")
	DefineMission( 298, MISSCRIPT_MISSIONSCRIPT02_LUA_000280, 261 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000281 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000281")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000281 )
	MisBeginCondition(NoRecord, 261)
	MisBeginCondition(NoMission, 261)
	MisBeginCondition(HasRecord, 260)
	MisBeginAction(AddMission, 261)
	MisCancelAction(ClearMission, 261)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000282 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000282")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000282)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000283 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000283")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000283)
	MisResultCondition(AlwaysFailure )

-----------------------------------祝福之手
	MISSCRIPT_MISSIONSCRIPT02_LUA_000280 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000280")
	DefineMission( 299, MISSCRIPT_MISSIONSCRIPT02_LUA_000280, 261, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000284 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000284")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000284)
	MisResultCondition(NoRecord, 261)
	MisResultCondition(HasMission, 261)
	MisResultAction(ClearMission, 261 )
	MisResultAction(SetRecord, 261 )
	MisResultAction(AddExp,3916,3916)
	MisResultAction(AddMoney,1807,1807)
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------心灵力量
	MISSCRIPT_MISSIONSCRIPT02_LUA_000285 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000285")
	DefineMission( 300, MISSCRIPT_MISSIONSCRIPT02_LUA_000285, 262 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000286 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000286")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000286)
	MisBeginCondition(NoRecord, 262)
	MisBeginCondition(HasRecord, 261)
	MisBeginCondition(NoMission, 262)
	MisBeginAction(AddMission, 262)
	MisBeginAction(AddTrigger, 2621, TE_GETITEM, 4145, 1)
	MisBeginAction(AddTrigger, 2622, TE_GETITEM, 4144, 1)	
	MisCancelAction(ClearMission, 262)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000287 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000287")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000287)
	MisNeed(MIS_NEED_ITEM, 4145, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4144, 1, 20, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000288 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000288")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000288)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000289 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000289")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000289)
	MisResultCondition(HasMission, 262 )
	MisResultCondition(HasItem, 4144, 1 )
	MisResultCondition(HasItem, 4145, 1 )
	MisResultAction(TakeItem, 4145, 1 )
	MisResultAction(TakeItem, 4144, 1 )
	MisResultAction(GiveItem, 4146, 1 , 4)
	MisResultAction(ClearMission, 262 )
	MisResultAction(SetRecord, 262 )
	MISSCRIPT_MISSIONSCRIPT02_LUA_000290 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000290")
	MisResultAction(SystemNotice, MISSCRIPT_MISSIONSCRIPT02_LUA_000290 )
	MisResultAction(ObligeAcceptMission, 7 )
	MisResultAction(AddExp,8620,8620)	
	MisResultAction(AddMoney,3682,3682)	
	MisResultAction(AddExpAndType,2,26625,26625)
	MisResultBagNeed(1)

		
	InitTrigger()
	TriggerCondition( 1, IsItem, 4145 )	
	TriggerAction( 1, AddNextFlag, 262, 10, 1 )
	RegCurTrigger( 2621 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4144 )	
	TriggerAction( 1, AddNextFlag, 262, 20, 1 )
	RegCurTrigger( 2622 )

-----------------------------------返回冰狼
	MISSCRIPT_EUDEMONSCRIPT_LUA_000020 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000020")
	DefineMission( 302, MISSCRIPT_EUDEMONSCRIPT_LUA_000020, 7, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000291 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000291")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000291)
	MisResultCondition(NoRecord, 7 )
	MisResultCondition(HasMission, 7)
	MisResultAction(ClearMission, 7 )
	MisResultAction(SetRecord, 7 )
	MisResultAction(AddExp,5211,5211)	
	MisResultAction(AddMoney,1910,1910)	
	MisResultAction(AddExpAndType,2,26625,26625)



-------------------------------------------------前往t9
	MISSCRIPT_MISSIONSCRIPT02_LUA_000292 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000292")
	DefineMission( 303, MISSCRIPT_MISSIONSCRIPT02_LUA_000292, 264 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000293 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000293")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000293 )
	MisBeginCondition(NoRecord, 264)
	MisBeginCondition(HasRecord, 7)
	MisBeginCondition(NoMission, 264)
	MisBeginAction(AddMission, 264)
	MisCancelAction(ClearMission, 264)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000294 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000294")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000294)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000295")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000295)
	MisResultCondition(AlwaysFailure )

-----------------------------------前往t9
	MISSCRIPT_MISSIONSCRIPT02_LUA_000292 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000292")
	DefineMission( 304, MISSCRIPT_MISSIONSCRIPT02_LUA_000292, 264, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000296 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000296")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000296)
	MisResultCondition(NoRecord, 264 )
	MisResultCondition(HasMission, 264)
	MisResultAction(ClearMission, 264 )
	MisResultAction(SetRecord, 264 )
	MisResultAction(AddExp,12572,12572)
	MisResultAction(AddMoney,3966,3966)	
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------前往t9
	MISSCRIPT_MISSIONSCRIPT02_LUA_000297 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000297")
	DefineMission( 305, MISSCRIPT_MISSIONSCRIPT02_LUA_000297, 265 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000298 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000298")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000298 )
	MisBeginCondition(NoRecord, 265)
	MisBeginCondition(HasRecord, 264)
	MisBeginCondition(NoMission, 265)
	MisBeginAction(AddMission, 265)
	MisCancelAction(ClearMission, 265)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000299 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000299")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000299)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000295 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000295")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000295)
	MisResultCondition(AlwaysFailure )

-----------------------------------前往t9
	MISSCRIPT_MISSIONSCRIPT02_LUA_000297 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000297")
	DefineMission( 306, MISSCRIPT_MISSIONSCRIPT02_LUA_000297, 265, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000300 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000300")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000300)
	MisResultCondition(NoRecord, 265 )
	MisResultCondition(HasMission, 265)
	MisResultAction(ClearMission, 265 )
	MisResultAction(SetRecord, 265 )
	MisResultAction(AddExp,8292,8292)	
	MisResultAction(AddMoney,2097,2097)	
	MisResultAction(AddExpAndType,2,26625,26625)


-------------------------------------------------海军别动队
	MISSCRIPT_MISSIONSCRIPT02_LUA_000301 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000301")
	DefineMission( 307, MISSCRIPT_MISSIONSCRIPT02_LUA_000301, 266 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000302 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000302")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000302)
	MisBeginCondition(NoRecord, 266)
	MisBeginCondition(HasRecord, 265)
	MisBeginCondition(NoMission, 262)
	MisBeginAction(AddMission, 266)
	MisBeginAction(AddTrigger, 2661, TE_KILL, 667, 5)		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000303 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000303")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000303)
	MisNeed(MIS_NEED_KILL, 667, 5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000304 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000304")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000304)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000305 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000305")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000305)
	MisResultCondition(HasMission, 266 )
	MisResultCondition(HasFlag, 266 , 14)
	MisResultAction(ClearMission, 266 )
	MisResultAction(SetRecord, 266 )
	MisResultAction(AddExp,21776,21776)	
	MisResultAction(AddMoney,4436,4436)	
	MisResultAction(AddExpAndType,2,26625,26625)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 667 )
	TriggerAction( 1, AddNextFlag, 266, 10, 5 )
	RegCurTrigger( 2661 )

-------------------------------------------------又见杰克
	MISSCRIPT_MISSIONSCRIPT02_LUA_000306 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000306")
	DefineMission( 308, MISSCRIPT_MISSIONSCRIPT02_LUA_000306, 267 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000307 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000307")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000307 )
	MisBeginCondition(NoRecord, 267)
	MisBeginCondition(HasRecord, 266)
	MisBeginCondition(NoMission, 267)
	MisBeginAction(AddMission, 267)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000308 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000308")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000308)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000309 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000309")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000309)
	MisResultCondition(AlwaysFailure )

-----------------------------------又见杰克
	MISSCRIPT_MISSIONSCRIPT02_LUA_000306 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000306")
	DefineMission( 309, MISSCRIPT_MISSIONSCRIPT02_LUA_000306, 267, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000310 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000310")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000310)
	MisResultCondition(NoRecord, 267 )
	MisResultCondition(HasMission, 267)
	MisResultAction(ClearMission, 267 )
	MisResultAction(SetRecord, 267 )
	MisResultAction(AddExp,13026,13026)
	MisResultAction(AddMoney,2303,2303)
	MisResultAction(AddExpAndType,2,26625,26625)



-------------------------------------------------稍后再来
	MISSCRIPT_MISSIONSCRIPT02_LUA_000311 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000311")
	DefineMission( 310, MISSCRIPT_MISSIONSCRIPT02_LUA_000311, 268 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000312 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000312")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000312 )
	MisBeginCondition(NoRecord, 268)
	MisBeginCondition(HasRecord, 267)
	MisBeginCondition(NoMission, 268)
	MisBeginAction(AddMission, 268)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000313 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000313")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000313)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000314 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000314")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000314)
	MisResultCondition(AlwaysFailure )


-----------------------------------引诱巨兽
	MISSCRIPT_EUDEMONSCRIPT_LUA_000008 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000008")
	DefineMission( 311, MISSCRIPT_EUDEMONSCRIPT_LUA_000008, 4, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000315 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000315")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000315)
	MisResultCondition(HasMission, 4 )
	MisResultCondition(NoRecord, 4 )
	MisResultCondition(NoMisssionFailure, 4 )
	MisResultCondition(HasFlag, 4, 10 )
	MisResultAction(ClearMission, 4 )
	MisResultAction(SetRecord, 4 )
	MisResultAction(AddExp,2649,2649)
	MisResultAction(AddMoney,1680,1680)
	MisResultAction(AddExpAndType,2,9035,9035)
	--MisResultAction(ClearTrigger, 108)


-------------------------------------------------“调查”
	MISSCRIPT_MISSIONSCRIPT02_LUA_000316 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000316")
	DefineMission( 312, MISSCRIPT_MISSIONSCRIPT02_LUA_000316, 269 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000317 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000317")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000317)
	MisBeginCondition(NoRecord, 269)
	MisBeginCondition(HasRecord, 267)
	MisBeginCondition(NoMission, 269)
	MisBeginCondition(HasMission, 268)
	MisBeginAction(AddMission, 269)
	MisBeginAction(ClearMission, 268 )
	MisBeginAction(SetRecord, 268 )
	MisBeginAction(AddTrigger, 2691, TE_GETITEM, 3790, 1)
	MisBeginAction(AddTrigger, 2692, TE_GETITEM, 3791, 1)
	MisBeginAction(AddTrigger, 2693, TE_GETITEM, 3792, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisNeed(MIS_NEED_ITEM, 3790, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 3791, 1, 11, 1)
	MisNeed(MIS_NEED_ITEM, 3792, 1, 12, 1)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000318 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000318")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000318)


	MISSCRIPT_MISSIONSCRIPT02_LUA_000319 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000319")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000319)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000320 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000320")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000320)
	MisResultCondition(HasMission, 269 )
	MisResultCondition(HasItem, 3790 , 1)
	MisResultCondition(HasItem, 3791 , 1)
	MisResultCondition(HasItem, 3792 , 1)
	MisResultAction(TakeItem, 3790, 1 )
	MisResultAction(TakeItem, 3791, 1 )
	MisResultAction(TakeItem, 3792, 1 )
	MisResultAction(ClearMission, 269 )
	MisResultAction(SetRecord, 269 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 3790 )
	TriggerAction( 1, AddNextFlag, 269, 10, 1 )
	RegCurTrigger( 2691 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3791 )
	TriggerAction( 1, AddNextFlag, 269, 11, 1 )
	RegCurTrigger( 2692 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3792)
	TriggerAction( 1, AddNextFlag, 269, 12, 1 )
	RegCurTrigger( 2693 )

-------------------------------------------------鲁德安的遗物
	MISSCRIPT_MISSIONSCRIPT02_LUA_000321 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000321")
	DefineMission( 313, MISSCRIPT_MISSIONSCRIPT02_LUA_000321, 270 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000322 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000322")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000322)
	MisBeginCondition(NoRecord, 270)
	MisBeginCondition(HasRecord, 269)
	MisBeginCondition(NoMission, 270)
	MisBeginAction(AddMission, 270)
	MisBeginAction(AddTrigger, 2701, TE_GETITEM, 4219, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000323 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000323")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000323)
	MisNeed(MIS_NEED_ITEM, 4219, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000324 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000324")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000324)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000325 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000325")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000325)
	MisResultCondition(HasMission, 270 )
	MisResultCondition(HasItem, 4219 , 1)
	MisResultAction(TakeItem, 4219, 1 )
	MisResultAction(GiveItem, 4220, 1, 4 )
	MisResultAction(ClearMission, 270 )
	MisResultAction(SetRecord, 270 )
	MisResultAction(AddExp,30000,30000)
	MisResultAction(AddMoney,5000,5000)
	MisResultAction(AddExpAndType,2,20000,20000)
	MisResultAction(GiveItem,1815,1,4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4219 )
	TriggerAction( 1, AddNextFlag, 270, 10, 1 )
	RegCurTrigger( 2701 )


-----------------------------------海盗之血1
	MISSCRIPT_EUDEMONSCRIPT_LUA_000023 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000023")
	DefineMission( 314, MISSCRIPT_EUDEMONSCRIPT_LUA_000023, 8, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000326 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000326")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000326)
	MisResultCondition(NoRecord, 8 )
	MisResultCondition(HasMission, 8)
	MisResultAction(ClearMission, 8 )
	MisResultAction(SetRecord, 8 )
	MisResultAction(ObligeAcceptMission, 11 )

-----------------------------------海军之魂1
	MISSCRIPT_EUDEMONSCRIPT_LUA_000026 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000026")
	DefineMission( 315, MISSCRIPT_EUDEMONSCRIPT_LUA_000026, 9, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000327 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000327")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000327)
	MisResultCondition(NoRecord, 9 )
	MisResultCondition(HasMission, 9)
	MisResultAction(ClearMission, 9)
	MisResultAction(SetRecord, 9 )
	MisResultAction(ObligeAcceptMission, 12 )

-----------------------------------无名之人1
	MISSCRIPT_EUDEMONSCRIPT_LUA_000028 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000028")
	DefineMission( 316, MISSCRIPT_EUDEMONSCRIPT_LUA_000028, 10, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000328 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000328")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000328)
	MisResultCondition(NoRecord, 10 )
	MisResultCondition(HasMission, 10)
	MisResultAction(ClearMission, 10)
	MisResultAction(SetRecord, 10 )
	MisResultAction(ObligeAcceptMission, 13 )

-------------------------------------------------海盗之血2
	MISSCRIPT_EUDEMONSCRIPT_LUA_000023 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000023")
	DefineMission( 317, MISSCRIPT_EUDEMONSCRIPT_LUA_000023, 271 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000329 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000329")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000329)
	MisBeginCondition(NoRecord, 271)
	MisBeginCondition(NoMission, 271)
	MisBeginCondition(HasMission, 11)
	MisBeginCondition(HasItem, 4221 , 1)
	MisBeginAction(ClearMission, 11)
	MisBeginAction(SetRecord, 11)
	MisBeginAction(AddMission, 271)
	MisBeginAction(AddTrigger, 2711, TE_KILL, 667, 30)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000330")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000330)
	MisNeed(MIS_NEED_KILL, 667, 30, 10, 30)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000331 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000331")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000331)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000332 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000332")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000332)
	MisResultCondition(HasMission, 271 )
	MisResultCondition(HasItem, 4221 , 1)
	MisResultCondition(HasFlag, 271, 39)
	MisResultAction(TakeItem, 4221, 1 )
	MisResultAction(GiveItem, 4222, 1, 4 )
	MisResultAction(ClearMission, 271 )
	MisResultAction(SetRecord, 271 )
	MisResultAction(AddExp,50000,50000)
	MisResultAction(AddMoney,5000,5000)
	MisResultAction(AddExpAndType,2,20000,20000)
	MisResultAction(GiveItem,1814,1,4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 667 )
	TriggerAction( 1, AddNextFlag, 271, 10, 30 )
	RegCurTrigger( 2711 )

-------------------------------------------------海军之魂2
	MISSCRIPT_EUDEMONSCRIPT_LUA_000026 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000026")
	DefineMission( 318, MISSCRIPT_EUDEMONSCRIPT_LUA_000026, 272 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000333 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000333")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000333)
	MisBeginCondition(NoRecord, 272)
	MisBeginCondition(NoMission, 272)
	MisBeginCondition(HasMission, 12)
	MisBeginCondition(HasItem, 4221 , 1)
	MisBeginAction(ClearMission, 12)
	MisBeginAction(SetRecord, 12)
	MisBeginAction(AddMission, 272)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000334 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000334")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000334)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000335 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000335")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000335)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000336 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000336")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000336)
	MisResultCondition(HasMission, 272 )
	MisResultCondition(HasItem, 4221 , 1)
	MisResultCondition(HasMoney, 2000000 )
	MisResultAction(TakeItem, 4221, 1 )
	MisResultAction(GiveItem, 4222, 1, 4 )
	MisResultAction(ClearMission, 272 )
	MisResultAction(SetRecord, 272 )
	MisResultAction(AddExp,80000,80000)
	MisResultAction(AddMoney,8000,8000)
	MisResultAction(AddExpAndType,2,30000,30000)
	MisResultAction(GiveItem,1814,1,4)
	MisResultBagNeed(2)

-------------------------------------------------无名之人3
	MISSCRIPT_EUDEMONSCRIPT_LUA_000028 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000028")
	DefineMission( 319, MISSCRIPT_EUDEMONSCRIPT_LUA_000028, 273 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000337 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000337")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000337)
	MisBeginCondition(NoRecord, 273)
	MisBeginCondition(NoMission, 273)
	MisBeginCondition(HasMission, 13)
	MisBeginCondition(HasItem, 4221 , 1)
	MisBeginAction(ClearMission, 13)
	MisBeginAction(SetRecord, 13)
	MisBeginAction(AddMission, 273)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000338 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000338")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000338)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000339 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000339")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000339)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000340 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000340")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000340)
	MisResultCondition(HasMission, 273 )
	MisResultCondition(HasMission, 14 )
	MisResultCondition(HasItem, 4221 , 1)
	MisResultAction(TakeItem, 4221, 1 )
	MisResultAction(GiveItem, 4222, 1, 4 )
	MisResultAction(ClearMission, 273 )
	MisResultAction(SetRecord, 14 )
	MisResultAction(ClearMission, 14 )
	MisResultAction(SetRecord, 273 )
	MisResultAction(AddExp,80000,80000)
	MisResultAction(AddMoney,8000,8000)
	MisResultAction(AddExpAndType,2,30000,30000)
	MisResultBagNeed(1)

-------------------------------------------------鲁德安的遗物
	MISSCRIPT_EUDEMONSCRIPT_LUA_000039 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000039")
	DefineMission( 320, MISSCRIPT_EUDEMONSCRIPT_LUA_000039, 274 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000341 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000341")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000341)
	MisBeginCondition(NoRecord, 274)
	MisBeginCondition(NoMission, 274)
	MisBeginCondition(HasMission, 15)
	MisBeginCondition(HasItem, 4222, 1)
	MisBeginAction(AddMission, 274)
	MisBeginAction(ClearMission, 15)
	MisBeginAction(SetRecord, 15)
	MisBeginAction(AddTrigger, 2741, TE_GETITEM, 4223, 1)
	MisBeginAction(AddTrigger, 2742, TE_GETITEM, 4224, 1)
	MisBeginAction(AddTrigger, 2743, TE_GETITEM, 4225, 1)
	MisBeginAction(AddTrigger, 2744, TE_GETITEM, 4226, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000342 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000342")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000342)
	MisNeed(MIS_NEED_ITEM, 4223, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4224, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 4225, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 4226, 1, 40, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000343 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000343")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000343)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000344 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000344")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000344)
	MisResultCondition(HasMission, 274 )
	MisResultCondition(HasItem, 4223 , 1)
	MisResultCondition(HasItem, 4224 , 1)
	MisResultCondition(HasItem, 4225 , 1)
	MisResultCondition(HasItem, 4226 , 1)
	MisResultCondition(HasItem, 4222 , 1)
	MisResultAction(TakeItem, 4222, 1 )
	MisResultAction(TakeItem, 4223, 1 )
	MisResultAction(TakeItem, 4224, 1 )
	MisResultAction(TakeItem, 4225, 1 )
	MisResultAction(TakeItem, 4226, 1 )
	MisResultAction(GiveItem, 4227, 1, 4 )
	MisResultAction(ClearMission, 274 )
	MisResultAction(SetRecord, 274 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4223 )
	TriggerAction( 1, AddNextFlag, 274, 10, 1 )
	RegCurTrigger( 2741 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4224 )
	TriggerAction( 1, AddNextFlag, 274, 20, 1 )
	RegCurTrigger( 2742 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4225 )
	TriggerAction( 1, AddNextFlag, 274, 30, 1 )
	RegCurTrigger( 2743 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4226 )
	TriggerAction( 1, AddNextFlag, 274, 40, 1 )
	RegCurTrigger( 2744 )

-------------------------------------------------海盗的朋友
	MISSCRIPT_MISSIONSCRIPT02_LUA_000345 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000345")
	DefineMission( 321, MISSCRIPT_MISSIONSCRIPT02_LUA_000345, 275 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000346 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000346")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000346)
	MisBeginCondition(NoRecord, 275)
	MisBeginCondition(NoRecord, 276)
	MisBeginCondition(NoMission, 275)
	MisBeginCondition(HasMission, 274)
	MisBeginCondition(HasNavyGuild)
	MisBeginAction(AddMission, 275)
	MisBeginAction(AddTrigger, 2751, TE_KILL, 667, 30)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000330 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000330")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000330)
	MisNeed(MIS_NEED_KILL, 667, 30, 10, 30)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000347 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000347")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000347)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000348 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000348")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000348)
	MisResultCondition(HasMission, 275 )
	MisResultCondition(HasFlag, 275, 39)
	MisResultAction(GiveItem, 4223, 1, 4 )
	MisResultAction(ClearMission, 275 )
	MisResultAction(SetRecord, 275 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 667 )
	TriggerAction( 1, AddNextFlag, 275, 10, 30 )
	RegCurTrigger( 2751 )

-----------------------------------我不是海军
	MISSCRIPT_MISSIONSCRIPT02_LUA_000349 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000349")
	DefineMission( 322, MISSCRIPT_MISSIONSCRIPT02_LUA_000349, 274, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000350 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000350")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000350)
	MisResultCondition(NoRecord, 274 )
	MisResultCondition(NoRecord, 275 )
	MisResultCondition(NoFlag, 274, 1 )
	MisResultCondition(HasMission, 274)
	MisResultCondition(NoNavyGuild)
	MisResultAction(GiveItem, 4223, 1, 4)
	MisResultAction(SetFlag, 274, 1 )
	MisResultBagNeed(1)

-------------------------------------------------脱离关系
	MISSCRIPT_MISSIONSCRIPT02_LUA_000351 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000351")
	DefineMission( 323, MISSCRIPT_MISSIONSCRIPT02_LUA_000351, 277 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000352 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000352")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000352)
	MisBeginCondition(NoRecord, 277)
	MisBeginCondition(NoRecord, 278 )
	MisBeginCondition(NoMission, 277)
	MisBeginCondition(HasMission, 274)
	MisBeginCondition(HasPirateGuild)
	MisBeginAction(AddMission, 277)
	MisBeginAction(AddTrigger, 2771, TE_KILL, 145, 10)
	MisBeginAction(AddTrigger, 2772, TE_KILL, 146, 10)
	MisBeginAction(AddTrigger, 2773, TE_KILL, 291, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000353 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000353")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000353)
	MisNeed(MIS_NEED_KILL, 145, 10, 10, 10)
	MisNeed(MIS_NEED_KILL, 146, 10, 20, 10)
	MisNeed(MIS_NEED_KILL, 291, 10, 30, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000354 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000354")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000354)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000355 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000355")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000355)
	MisResultCondition(HasMission, 277 )
	MisResultCondition(HasFlag, 277, 19)
	MisResultCondition(HasFlag, 277, 29)
	MisResultCondition(HasFlag, 277, 39)
	MisResultAction(GiveItem, 4224, 1, 4 )
	MisResultAction(ClearMission, 277 )
	MisResultAction(SetRecord, 277 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 145 )
	TriggerAction( 1, AddNextFlag, 277, 10, 10 )
	RegCurTrigger( 2771 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 146 )
	TriggerAction( 1, AddNextFlag, 277, 20, 10 )
	RegCurTrigger( 2772 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 291 )
	TriggerAction( 1, AddNextFlag, 277, 30, 10 )
	RegCurTrigger( 2773 )

-----------------------------------我不是海盗
	MISSCRIPT_MISSIONSCRIPT02_LUA_000356 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000356")
	DefineMission( 324, MISSCRIPT_MISSIONSCRIPT02_LUA_000356, 274, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000357 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000357")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000357)
	MisResultCondition(NoRecord, 274 )
	MisResultCondition(NoRecord, 277 )
	MisResultCondition(HasMission, 274)
	MisResultCondition(NoFlag, 274, 2 )
	MisResultCondition(NoPirateGuild)
	MisResultAction(GiveItem, 4224, 1, 4)
	MisResultAction(SetFlag, 274, 2 )
	MisResultBagNeed(1)

-------------------------------------------------孤独的战士
	MISSCRIPT_MISSIONSCRIPT02_LUA_000358 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000358")
	DefineMission( 325, MISSCRIPT_MISSIONSCRIPT02_LUA_000358, 279 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000359 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000359")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000359)
	MisBeginCondition(NoRecord, 279)
	MisBeginCondition(NoRecord, 280 )
	MisBeginCondition(NoMission, 279)
	MisBeginCondition(HasMission, 274)
	MisBeginCondition(NoGuild)
	MisBeginAction(AddMission, 279)
	MisBeginAction(AddTrigger, 2791, TE_KILL, 145, 5)
	MisBeginAction(AddTrigger, 2792, TE_KILL, 146, 5)
	MisBeginAction(AddTrigger, 2793, TE_KILL, 291, 5)
	MisBeginAction(AddTrigger, 2794, TE_KILL, 667, 5)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000360 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000360")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000360)
	MisNeed(MIS_NEED_KILL, 145, 5, 10, 5)
	MisNeed(MIS_NEED_KILL, 146, 5, 20, 5)
	MisNeed(MIS_NEED_KILL, 291, 5, 30, 5)
	MisNeed(MIS_NEED_KILL, 667, 5, 40, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000361 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000361")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000361)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000362 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000362")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000362)
	MisResultCondition(HasMission, 279 )
	MisResultCondition(HasFlag, 279, 14)
	MisResultCondition(HasFlag, 279, 24)
	MisResultCondition(HasFlag, 279, 34)
	MisResultCondition(HasFlag, 279, 44)
	MisResultAction(GiveItem, 4225, 1, 4 )
	MisResultAction(ClearMission, 279 )
	MisResultAction(SetRecord, 279 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 145 )
	TriggerAction( 1, AddNextFlag, 279, 10, 5 )
	RegCurTrigger( 2791 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 146 )
	TriggerAction( 1, AddNextFlag, 279, 20, 5 )
	RegCurTrigger( 2792 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 291 )
	TriggerAction( 1, AddNextFlag, 279, 30, 5 )
	RegCurTrigger( 2793 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 667 )
	TriggerAction( 1, AddNextFlag, 279, 40, 5 )
	RegCurTrigger( 2794 )

-----------------------------------强大的后盾
	MISSCRIPT_MISSIONSCRIPT02_LUA_000363 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000363")
	DefineMission( 326, MISSCRIPT_MISSIONSCRIPT02_LUA_000363, 274, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000364 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000364")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000364)
	MisResultCondition(NoRecord, 274 )
	MisResultCondition(NoRecord, 279 )
	MisResultCondition(NoFlag, 274, 3 )
	MisResultCondition(HasMission, 274)
	MisResultCondition(HasGuild)
	MisResultAction(GiveItem, 4225, 1, 4)
	MisResultAction(SetFlag, 274, 3 )
	MisResultBagNeed(1)

-------------------------------------------------洗刷罪恶
	MISSCRIPT_MISSIONSCRIPT02_LUA_000365 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000365")
	DefineMission( 327, MISSCRIPT_MISSIONSCRIPT02_LUA_000365, 281 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000366 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000366")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000366)
	MisBeginCondition(NoRecord, 281)
	MisBeginCondition(NoMission, 281)
	MisBeginCondition(HasMission, 274)
	MisBeginAction(AddMission, 281)
	MisBeginAction(AddTrigger, 2811, TE_KILL, 620, 30)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000367 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000367")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000367)
	MisNeed(MIS_NEED_KILL, 620, 30, 10, 30)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000368")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000368)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000369 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000369")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000369)
	MisResultCondition(HasMission, 281 )
	MisResultCondition(HasFlag, 281, 39)
	MisResultAction(GiveItem, 4226, 1, 4 )
	MisResultAction(ClearMission, 281 )
	MisResultAction(SetRecord, 281 )
	MisResultAction(AddExp,80000,80000)
	MisResultAction(AddMoney,10000,10000)
	MisResultAction(AddExpAndType,2,30000,30000)
	MisResultAction(GiveItem,3885,1,4)
	MisResultBagNeed(2)


	InitTrigger()
	TriggerCondition( 1, IsMonster, 620 )
	TriggerAction( 1, AddNextFlag, 281, 10, 30 )
	RegCurTrigger( 2811 )

-----------------------------------鲁德安的遗书
	MISSCRIPT_EUDEMONSCRIPT_LUA_000042 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000042")
	DefineMission( 328, MISSCRIPT_EUDEMONSCRIPT_LUA_000042, 16, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000370 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000370")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000370)
	MisResultCondition(NoRecord, 16 )
	MisResultCondition(HasMission, 16)
	MisResultCondition(HasItem, 4227, 1)
	MisResultAction(ClearMission, 16)
	MisResultAction(SetRecord, 16 )

----------------------------遗书的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000371")
	DefineMission( 329, MISSCRIPT_MISSIONSCRIPT02_LUA_000371, 282 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000372 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000372")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000372 )
	MisBeginCondition(NoRecord, 282)
	MisBeginCondition(HasRecord, 16)
	MisBeginCondition(NoMission, 282)
	MisBeginCondition(HasItem, 4227, 1)
	MisBeginAction(AddMission, 282)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000373 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000373")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000373)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000374 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000374")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000374)
	MisResultCondition(AlwaysFailure )

-----------------------------------遗书的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_000371 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000371")
	DefineMission( 330, MISSCRIPT_MISSIONSCRIPT02_LUA_000371, 282, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000375 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000375")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000375)
	MisResultCondition(NoRecord, 282 )
	MisResultCondition(HasMission, 282)
	MisResultCondition(HasItem, 4227, 1)
	MisResultAction(ClearMission, 282)
	MisResultAction(SetRecord, 282 )

----------------------------杰克介绍
	MISSCRIPT_MISSIONSCRIPT02_LUA_000376 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000376")
	DefineMission( 331, MISSCRIPT_MISSIONSCRIPT02_LUA_000376, 283 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000377 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000377")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000377 )
	MisBeginCondition(NoRecord, 283)
	MisBeginCondition(HasRecord, 282)
	MisBeginCondition(NoMission, 283)
	MisBeginCondition(NoRecord, 284)
	MisBeginCondition(NoMission, 284)
	MisBeginCondition(HasItem, 4227, 1)
	MisBeginAction(AddMission, 283)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000378 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000378")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000378)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000379 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000379")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000379)
	MisResultCondition(AlwaysFailure )

-------------------------------------------------酒馆传闻
	MISSCRIPT_MISSIONSCRIPT02_LUA_000380 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000380")
	DefineMission( 332, MISSCRIPT_MISSIONSCRIPT02_LUA_000380, 284 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000381 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000381")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000381)
	MisBeginCondition(NoRecord, 284)
	MisBeginCondition(NoMission, 284)
	MisBeginCondition(NoMission, 283)
	MisBeginCondition(NoRecord, 283)
	MisBeginCondition(HasRecord, 282)
	MisBeginCondition(HasItem, 4227, 1)
	MisBeginAction(AddMission, 284)
	MisBeginAction(AddTrigger, 2841, TE_GETITEM, 1255, 3)
	MisBeginAction(AddTrigger, 2842, TE_GETITEM, 1291, 5)
	MisBeginAction(AddTrigger, 2843, TE_GETITEM, 1365, 7)
	MisBeginAction(AddTrigger, 2844, TE_GETITEM, 1292, 9)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000382 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000382")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000382)
	MisNeed(MIS_NEED_ITEM, 1255, 3, 10, 3)
	MisNeed(MIS_NEED_ITEM, 1291, 5, 20, 5)
	MisNeed(MIS_NEED_ITEM, 1365, 7, 30, 7)
	MisNeed(MIS_NEED_ITEM, 1292, 9, 40, 9)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000383 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000383")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000383)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000384 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000384")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000384)
	MisResultCondition(HasMission, 284 )
	MisResultCondition(HasItem, 1255, 3)
	MisResultCondition(HasItem, 1291, 5)
	MisResultCondition(HasItem, 1365, 7)
	MisResultCondition(HasItem, 1292, 9)
	MisResultAction(TakeItem, 1255, 3)
	MisResultAction(TakeItem, 1291, 5)
	MisResultAction(TakeItem, 1365, 7)
	MisResultAction(TakeItem, 1292, 9)
	MisResultAction(GiveItem, 4228, 1, 4)
	MisResultAction(SetRecord, 284 )
	MisResultAction(ClearMission, 284 )
	MisResultBagNeed(1)
	

	InitTrigger()
	TriggerCondition( 1, IsItem, 1255 )
	TriggerAction( 1, AddNextFlag, 284, 10, 3 )
	RegCurTrigger( 2841 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1291 )
	TriggerAction( 1, AddNextFlag, 284, 20, 5 )
	RegCurTrigger( 2842 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1365 )
	TriggerAction( 1, AddNextFlag, 284, 30, 7 )
	RegCurTrigger( 2843 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1292 )
	TriggerAction( 1, AddNextFlag, 284, 40, 9 )
	RegCurTrigger( 2844 )

----------------------------感情纠纷
	MISSCRIPT_EUDEMONSCRIPT_LUA_000045 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000045")
	DefineMission( 333, MISSCRIPT_EUDEMONSCRIPT_LUA_000045, 285 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000385 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000385")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000385 )
	MisBeginCondition(NoRecord, 285)
	MisBeginCondition(HasMission, 283)
	MisBeginCondition(NoMission, 285)
	MisBeginAction(AddMission, 285)
	MisBeginAction(SetRecord, 283)
	MisBeginAction(ClearMission, 283)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000386 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000386")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000386)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000387 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000387")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000387)
	MisResultCondition(AlwaysFailure )

-------------------------------------------------感情纠纷
	MISSCRIPT_EUDEMONSCRIPT_LUA_000045 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000045")
	DefineMission( 334, MISSCRIPT_EUDEMONSCRIPT_LUA_000045, 286 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000388 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000388")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000388)
	MisBeginCondition(NoRecord, 286)
	MisBeginCondition(NoMission, 286)
	MisBeginCondition(HasRecord, 283)
	MisBeginCondition(HasMission, 285)
	MisBeginAction(AddMission, 286)
	MisBeginAction(AddTrigger, 2861, TE_GETITEM, 4735, 1)
	MisBeginAction(SetRecord, 285)
	MisBeginAction(ClearMission, 285)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000389 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000389")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000389)
	MisNeed(MIS_NEED_ITEM, 4735, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000390 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000390")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000390)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000391 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000391")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000391)
	MisResultCondition(HasMission, 286 )
	MisResultCondition(HasItem, 4735, 1)
	MisResultAction(TakeItem, 4735, 1)
	MisResultAction(GiveItem, 4229, 1, 4)
	MisResultAction(SetRecord, 286 )
	MisResultAction(ClearMission, 286 )
	MisResultAction(ObligeAcceptMission, 17 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4735 )
	TriggerAction( 1, AddNextFlag, 286, 10, 1 )
	RegCurTrigger( 2861 )

-----------------------------------感情纠纷
	MISSCRIPT_EUDEMONSCRIPT_LUA_000045 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000045")
	DefineMission( 335, MISSCRIPT_EUDEMONSCRIPT_LUA_000045, 17, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000392 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000392")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000392)
	MisResultCondition(NoRecord, 17 )
	MisResultCondition(HasMission, 17 )
	MisResultCondition(HasItem, 4229, 1)
	MisResultAction(TakeItem, 4229, 1 )
	MisResultAction(SetRecord, 17 )
	MisResultAction(ClearMission, 17 )
	MisResultAction(GiveItem, 4228, 1, 4 )
	MisResultBagNeed(1)

-------------------------------------------------海盗语言
	MISSCRIPT_EUDEMONSCRIPT_LUA_000048 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000048")
	DefineMission( 336, MISSCRIPT_EUDEMONSCRIPT_LUA_000048, 287 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000393 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000393")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000393)
	MisBeginCondition(NoRecord, 287)
	MisBeginCondition(NoRecord, 18)
	MisBeginCondition(HasMission, 18)
	MisBeginCondition(HasItem, 4227, 1)
	MisBeginAction(TakeItem, 4227, 1)
	MisBeginAction(AddMission, 287)
	MisBeginAction(AddTrigger, 2871, TE_GETITEM, 4230, 1)
	MisBeginAction(SetRecord, 18)
	MisBeginAction(ClearMission, 18)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000394 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000394")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000394)
	MisNeed(MIS_NEED_ITEM, 4230, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000395 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000395")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000395)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000396 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000396")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000396)
	MisResultCondition(HasMission, 287 )
	MisResultCondition(HasItem, 4230, 1)
	MisResultAction(SetRecord, 287 )
	MisResultAction(ClearMission, 287 )
	MisResultAction(ObligeAcceptMission, 19 )
	MisResultAction(AddExp,300000,300000)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,30000,30000)
	MisResultAction(GiveItem,3463,10,4)
	MisResultAction(GiveItem,1092,5,4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4230 )
	TriggerAction( 1, AddNextFlag, 287, 10, 1 )
	RegCurTrigger( 2871 )

-----------------------------------迷的日记
	MISSCRIPT_EUDEMONSCRIPT_LUA_000054 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000054")
	DefineMission( 337, MISSCRIPT_EUDEMONSCRIPT_LUA_000054, 20, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000397 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000397")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000397)
	MisResultCondition(NoRecord, 20 )
	MisResultCondition(HasMission, 20 )
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(SetRecord, 20 )
	MisResultAction(ClearMission, 20 )
	
----------------------------女神的追随者
	MISSCRIPT_MISSIONSCRIPT02_LUA_000398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000398")
	DefineMission( 338, MISSCRIPT_MISSIONSCRIPT02_LUA_000398, 288 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000399 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000399")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000399 )
	MisBeginCondition(NoRecord, 288)
	MisBeginCondition(HasRecord, 20)
	MisBeginCondition(NoMission, 288)
	MisBeginCondition(HasItem, 4231, 1)
	MisBeginAction(AddMission, 288)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000400 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000400")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000400)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000401 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000401")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000401)
	MisResultCondition(AlwaysFailure )

-----------------------------------女神的追随者
	MISSCRIPT_MISSIONSCRIPT02_LUA_000398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000398")
	DefineMission( 339, MISSCRIPT_MISSIONSCRIPT02_LUA_000398, 288, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000402 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000402")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000402)
	MisResultCondition(NoRecord, 288)
	MisResultCondition(HasMission, 288 )
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(SetRecord, 288 )
	MisResultAction(ClearMission, 288 )

----------------------------圣女
	MISSCRIPT_MISSIONSCRIPT02_LUA_000403 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000403")
	DefineMission( 340, MISSCRIPT_MISSIONSCRIPT02_LUA_000403, 289 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000404 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000404")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000404 )
	MisBeginCondition(NoRecord, 289)
	MisBeginCondition(HasRecord, 288)
	MisBeginCondition(NoMission, 289)
	MisBeginCondition(HasItem, 4231, 1)
	MisBeginAction(AddMission, 289)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000405 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000405")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000405)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000406 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000406")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000406)
	MisResultCondition(AlwaysFailure )

-------------------------------------------------虔诚的证明
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 341, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 290 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000408 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000408")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000408)
	MisBeginCondition(NoRecord, 290)
	MisBeginCondition(HasMission, 289)
	MisBeginCondition(HasItem, 4231, 1)
	MisBeginAction(AddMission, 290)
	MisBeginAction(AddTrigger, 2901, TE_GETITEM, 3954, 1)
	MisBeginAction(SetRecord, 289)
	MisBeginAction(ClearMission, 289)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000409 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000409")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000409)
	MisNeed(MIS_NEED_ITEM, 3954, 1, 15, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000410 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000410")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000410)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000411 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000411")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000411)
	MisResultCondition(HasMission, 290 )
	MisResultCondition(HasItem, 3954, 1)
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(TakeItem, 4231, 1)
	MisResultAction(TakeItem, 3954, 1)
	MisResultAction(GiveItem, 4232, 1, 4)
	MisResultAction(SetRecord, 290 )
	MisResultAction(ClearMission, 290 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 3954 )
	TriggerAction( 1, AddNextFlag, 290, 15, 1 )
	RegCurTrigger( 2901 )


-----------------------------------虔诚的证明
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 342, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 290, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000412 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000412)
	MisResultCondition(NoRecord, 290)
	MisResultCondition(NoItem, 3954, 1)
	MisResultCondition(HasMission, 290 )
	MisResultCondition(PfEqual, 5)
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(GiveItem, 3954, 1, 4 )
	MisResultBagNeed(1)
	
-----------------------------------虔诚的证明
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 343, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 290, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000412 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000412)
	MisResultCondition(NoRecord, 290)
	MisResultCondition(NoItem, 3954, 1)
	MisResultCondition(HasMission, 290 )
	MisResultCondition(PfEqual, 13)
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(GiveItem, 3954, 1, 4 )
	MisResultBagNeed(1)
	
-----------------------------------虔诚的证明
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 344, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 290, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000412 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000412")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000412)
	MisResultCondition(NoRecord, 290)
	MisResultCondition(NoItem, 3954, 1)
	MisResultCondition(HasMission, 290 )
	MisResultCondition(PfEqual, 14)
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(GiveItem, 3954, 1, 4 )
	MisResultBagNeed(1)
	
-----------------------------------虔诚的证明
	MISSCRIPT_MISSIONSCRIPT02_LUA_000407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000407")
	DefineMission( 345, MISSCRIPT_MISSIONSCRIPT02_LUA_000407, 290, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000413 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000413")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000413)
	MisResultCondition(NoRecord, 290)
	MisResultCondition(NoFlag, 290, 1)
	MisResultCondition(NoItem, 3954, 1)
	MisResultCondition(HasMission, 290 )
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(HasItem, 4231, 1)
	MisResultAction(SetFlag, 290, 1 )

-----------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 346, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 291 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000415 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000415")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000415)
	MisBeginCondition(NoRecord, 291)
	MisBeginCondition(HasMission, 290)
	MisBeginCondition(HasFlag, 290, 1)
	MisBeginAction(AddMission, 291)
	MisBeginAction(AddTrigger, 2911, TE_KILL, 42, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000416 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000416")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000416)
	MisNeed(MIS_NEED_KILL, 42, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000417 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000417")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000417)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 291 )
	MisResultCondition(HasFlag, 291, 19)
	MisResultAction(SetRecord, 291 )
	MisResultAction(ClearMission, 291 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 42 )
	TriggerAction( 1, AddNextFlag, 291, 10, 10 )
	RegCurTrigger( 2911 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 347, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 292 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000419 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000419")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000419)
	MisBeginCondition(NoRecord, 292)
	MisBeginCondition(HasRecord, 291)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 292)
	MisBeginAction(AddTrigger, 2921, TE_KILL, 267, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000420 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000420")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000420)
	MisNeed(MIS_NEED_KILL, 267, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000421 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000421")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000421)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 292 )
	MisResultCondition(HasFlag, 292, 19)
	MisResultAction(SetRecord, 292 )
	MisResultAction(ClearMission, 292 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 267 )
	TriggerAction( 1, AddNextFlag, 292, 10, 10 )
	RegCurTrigger( 2921 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 348, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 293 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000422 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000422")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000422)
	MisBeginCondition(NoRecord, 293)
	MisBeginCondition(HasRecord, 292)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 293)
	MisBeginAction(AddTrigger, 2931, TE_KILL, 541, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000423 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000423")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000423)
	MisNeed(MIS_NEED_KILL, 541, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000424 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000424")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000424)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 293 )
	MisResultCondition(HasFlag, 293, 19)
	MisResultAction(SetRecord, 293 )
	MisResultAction(ClearMission, 293 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 541 )
	TriggerAction( 1, AddNextFlag, 293, 10, 10 )
	RegCurTrigger( 2931 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 349, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 294 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000425 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000425")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000425)
	MisBeginCondition(NoRecord, 294)
	MisBeginCondition(HasRecord, 293)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 294)
	MisBeginAction(AddTrigger, 2941, TE_KILL, 565, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000426 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000426")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000426)
	MisNeed(MIS_NEED_KILL, 565, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000427 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000427")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000427)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 294 )
	MisResultCondition(HasFlag, 294, 19)
	MisResultAction(SetRecord, 294 )
	MisResultAction(ClearMission, 294 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 565 )
	TriggerAction( 1, AddNextFlag, 294, 10, 10 )
	RegCurTrigger( 2941 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 350, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 295 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000428 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000428")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000428)
	MisBeginCondition(NoRecord, 295)
	MisBeginCondition(HasRecord, 294)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 295)
	MisBeginAction(AddTrigger, 2951, TE_KILL, 52, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000429 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000429")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000429)
	MisNeed(MIS_NEED_KILL, 52, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000430 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000430")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000430)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 295 )
	MisResultCondition(HasFlag, 295, 19)
	MisResultAction(SetRecord, 295 )
	MisResultAction(ClearMission, 295 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 52 )
	TriggerAction( 1, AddNextFlag, 295, 10, 10 )
	RegCurTrigger( 2951 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 351, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 296 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000431 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000431")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000431)
	MisBeginCondition(NoRecord, 296)
	MisBeginCondition(HasRecord, 295)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 296)
	MisBeginAction(AddTrigger, 2961, TE_KILL, 666, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000432 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000432")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000432)
	MisNeed(MIS_NEED_KILL, 666, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000433 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000433")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000433)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 296 )
	MisResultCondition(HasFlag, 296, 19)
	MisResultAction(SetRecord, 296 )
	MisResultAction(ClearMission, 296 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 666 )
	TriggerAction( 1, AddNextFlag, 296, 10, 10 )
	RegCurTrigger( 2961 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 352, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 297 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000434 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000434")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000434)
	MisBeginCondition(NoRecord, 297)
	MisBeginCondition(HasRecord, 296)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 297)
	MisBeginAction(AddTrigger, 2971, TE_KILL, 508, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000435 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000435")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000435)
	MisNeed(MIS_NEED_KILL, 508, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000436 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000436")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000436)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 297 )
	MisResultCondition(HasFlag, 297, 19)
	MisResultAction(SetRecord, 297 )
	MisResultAction(ClearMission, 297 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 508 )
	TriggerAction( 1, AddNextFlag, 297, 10, 10 )
	RegCurTrigger( 2971 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 353, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 298 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000437 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000437")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000437)
	MisBeginCondition(NoRecord, 298)
	MisBeginCondition(HasRecord, 297)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 298)
	MisBeginAction(AddTrigger, 2981, TE_KILL, 518, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000438 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000438")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000438)
	MisNeed(MIS_NEED_KILL, 518, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000439 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000439")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000439)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 298 )
	MisResultCondition(HasFlag, 298, 19)
	MisResultAction(SetRecord, 298 )
	MisResultAction(ClearMission, 298 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 518 )
	TriggerAction( 1, AddNextFlag, 298, 10, 10 )
	RegCurTrigger( 2981 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 354, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 299 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000440 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000440")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000440)
	MisBeginCondition(NoRecord, 299)
	MisBeginCondition(HasRecord, 298)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 299)
	MisBeginAction(AddTrigger, 2991, TE_KILL, 547, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000441 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000441")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000441)
	MisNeed(MIS_NEED_KILL, 547, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000442 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000442")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000442)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 299 )
	MisResultCondition(HasFlag, 299, 19)
	MisResultAction(SetRecord, 299 )
	MisResultAction(ClearMission, 299 )
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 547 )
	TriggerAction( 1, AddNextFlag, 299, 10, 10 )
	RegCurTrigger( 2991 )

-------------------------------------------------女神的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000414")
	DefineMission( 355, MISSCRIPT_MISSIONSCRIPT02_LUA_000414, 300 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000443 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000443")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000443)
	MisBeginCondition(NoRecord, 300)
	MisBeginCondition(HasRecord, 299)
	MisBeginCondition(HasMission, 290)
	MisBeginAction(AddMission, 300)
	MisBeginAction(AddTrigger, 3001, TE_KILL, 190, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000444 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000444")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000444)
	MisNeed(MIS_NEED_KILL, 190, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000445 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000445")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000445)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000418")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000418)
	MisResultCondition(HasMission, 300 )
	MisResultCondition(HasFlag, 300, 10)
	MisResultAction(SetRecord, 300 )
	MisResultAction(ClearMission, 300 )
	MisResultAction(GiveItem, 3954, 1, 4 )
	MisResultAction(AddExp,350000,350000)
	MisResultAction(AddMoney,10000,10000)
	MisResultAction(AddExpAndType,2,40000,40000)
	MisResultAction(GiveItem,3844,15,4)
	MisResultBagNeed(2)

		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 190 )
	TriggerAction( 1, AddNextFlag, 300, 10, 1 )
	RegCurTrigger( 3001 )



-----------------------------------神秘小镇
	MISSCRIPT_EUDEMONSCRIPT_LUA_000057 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000057")
	DefineMission( 356, MISSCRIPT_EUDEMONSCRIPT_LUA_000057, 21, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000446 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000446")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000446)
	MisResultCondition(NoRecord, 21)
	MisResultCondition(HasMission, 21 )
	MisResultAction(SetRecord, 21 )
	MisResultAction(ClearMission, 21 )

----------------------------春风小镇
	MISSCRIPT_MISSIONSCRIPT02_LUA_000447 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000447")
	DefineMission( 357, MISSCRIPT_MISSIONSCRIPT02_LUA_000447, 301 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000448 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000448")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000448 )
	MisBeginCondition(NoRecord, 301)
	MisBeginCondition(HasRecord, 21)
	MisBeginCondition(NoMission, 301)
	MisBeginAction(AddMission, 301)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000449 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000449")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000449)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000450 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000450")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000450)
	MisResultCondition(AlwaysFailure )

-------------------------------------------------冒险精神
	MISSCRIPT_MISSIONSCRIPT02_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000451")
	DefineMission( 358, MISSCRIPT_MISSIONSCRIPT02_LUA_000451, 302 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000452 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000452")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000452)
	MisBeginCondition(NoRecord, 302)
	MisBeginCondition(HasMission, 301)
	MisBeginCondition(HasItem, 4232, 1)
	MisBeginAction(AddMission, 302)
	MisBeginAction(SetRecord, 301)
	MisBeginAction(ClearMission, 301)
	MisBeginAction(AddTrigger, 3021, TE_GETITEM, 3962, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000453 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000453")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000453)
	MisNeed(MIS_NEED_ITEM, 3962, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000454 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000454")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000454)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000455 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000455")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000455)
	MisResultCondition(HasMission, 302 )
	MisResultCondition(HasItem, 3962, 1 )
	MisResultCondition(HasItem, 4232, 1 )
	MisResultAction(TakeItem, 4232, 1 )
	MisResultAction(TakeItem, 3962, 1 )
	MisResultAction(SetRecord, 302 )
	MisResultAction(SetRecord, 312 )
	MisResultAction(ClearMission, 302 )
			
	InitTrigger()
	TriggerCondition( 1, IsItem, 3962 )
	TriggerAction( 1, AddNextFlag, 302, 10, 1 )
	RegCurTrigger( 3021 )

-----------------------------------冒险精神
	MISSCRIPT_MISSIONSCRIPT02_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000451")
	DefineMission( 359, MISSCRIPT_MISSIONSCRIPT02_LUA_000451, 302, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000456 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000456")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000456)
	MisResultCondition(NoRecord, 302)
	MisResultCondition(NoRecord, 312)
	MisResultCondition(NoItem, 3962, 1)
	MisResultCondition(HasMission, 302 )
	MisResultCondition(PfEqual, 4)
	MisResultAction(GiveItem, 3962, 1, 4 )
	MisResultBagNeed(1)

-----------------------------------冒险精神
	MISSCRIPT_MISSIONSCRIPT02_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000451")
	DefineMission( 360, MISSCRIPT_MISSIONSCRIPT02_LUA_000451, 302, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000456 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000456")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000456)
	MisResultCondition(NoRecord, 302)
	MisResultCondition(NoRecord, 312)
	MisResultCondition(NoItem, 3962, 1)
	MisResultCondition(HasMission, 302 )
	MisResultCondition(PfEqual, 16)
	MisResultAction(GiveItem, 3962, 1, 4 )
	MisResultBagNeed(1)

-----------------------------------冒险精神
	MISSCRIPT_MISSIONSCRIPT02_LUA_000451 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000451")
	DefineMission( 361, MISSCRIPT_MISSIONSCRIPT02_LUA_000451, 302, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000457 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000457")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000457)
	MisResultCondition(NoRecord, 302)
	MisResultCondition(NoRecord, 312)
	MisResultCondition(NoFlag, 302, 5)
	MisResultCondition(NoItem, 3962, 1)
	MisResultCondition(HasMission, 302 )
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(SetFlag, 302, 5 )

-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 362, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 303 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000459 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000459")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000459)
	MisBeginCondition(NoRecord, 303)
	MisBeginCondition(HasFlag, 302, 5)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 303)
	MisBeginAction(AddTrigger, 3031, TE_KILL, 574, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000460 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000460")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000460)
	MisNeed(MIS_NEED_KILL, 574, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000461 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000461")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000461)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 303 )
	MisResultCondition(HasFlag, 303, 19)
	MisResultAction(SetRecord, 303 )
	MisResultAction(ClearMission, 303 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 574 )
	TriggerAction( 1, AddNextFlag, 303, 10, 10 )
	RegCurTrigger( 3031 )

-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 363, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 304 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000463 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000463")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000463)
	MisBeginCondition(NoRecord, 304)
	MisBeginCondition(HasRecord, 303)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 304)
	MisBeginAction(AddTrigger, 3041, TE_KILL, 638, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000464 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000464")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000464)
	MisNeed(MIS_NEED_KILL, 638, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000465 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000465")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000465)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 304 )
	MisResultCondition(HasFlag, 304, 19)
	MisResultAction(SetRecord, 304 )
	MisResultAction(ClearMission, 304 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 638 )
	TriggerAction( 1, AddNextFlag, 304, 10, 10 )
	RegCurTrigger( 3041 )



-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 364, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 305 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000466 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000466")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000466)
	MisBeginCondition(NoRecord, 305)
	MisBeginCondition(HasRecord, 304)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 305)
	MisBeginAction(AddTrigger, 3051, TE_KILL, 583, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000467 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000467")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000467)
	MisNeed(MIS_NEED_KILL, 583, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000468 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000468")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000468)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 305 )
	MisResultCondition(HasFlag, 305, 19)
	MisResultAction(SetRecord, 305 )
	MisResultAction(ClearMission, 305 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 583 )
	TriggerAction( 1, AddNextFlag, 305, 10, 10 )
	RegCurTrigger( 3051 )

-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 365, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 306 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000469 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000469")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000469)
	MisBeginCondition(NoRecord, 306)
	MisBeginCondition(HasRecord, 305)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 306)
	MisBeginAction(AddTrigger, 3061, TE_KILL, 660, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000470 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000470")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000470)
	MisNeed(MIS_NEED_KILL, 660, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000471 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000471")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000471)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 306 )
	MisResultCondition(HasFlag, 306, 19)
	MisResultAction(SetRecord, 306 )
	MisResultAction(ClearMission, 306 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 660 )
	TriggerAction( 1, AddNextFlag, 306, 10, 10 )
	RegCurTrigger( 3061 )




-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 366, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 307 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000472 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000472")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000472)
	MisBeginCondition(NoRecord, 307)
	MisBeginCondition(HasRecord, 306)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 307)
	MisBeginAction(AddTrigger, 3071, TE_KILL, 584, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000473 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000473")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000473)
	MisNeed(MIS_NEED_KILL, 584, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000474 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000474")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000474)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 307 )
	MisResultCondition(HasFlag, 307, 19)
	MisResultAction(SetRecord, 307 )
	MisResultAction(ClearMission, 307 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 584 )
	TriggerAction( 1, AddNextFlag, 307, 10, 10 )
	RegCurTrigger( 3071 )

-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 367, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 308 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000475 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000475")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000475)
	MisBeginCondition(NoRecord, 308)
	MisBeginCondition(HasRecord, 307)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 308)
	MisBeginAction(AddTrigger, 3081, TE_KILL, 603, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000476 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000476")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000476)
	MisNeed(MIS_NEED_KILL, 603, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000477 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000477")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000477)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 308 )
	MisResultCondition(HasFlag, 308, 19)
	MisResultAction(SetRecord, 308 )
	MisResultAction(ClearMission, 308 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 603 )
	TriggerAction( 1, AddNextFlag, 308, 10, 10 )
	RegCurTrigger( 3081 )


-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 368, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 309 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000478 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000478")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000478)
	MisBeginCondition(NoRecord, 309)
	MisBeginCondition(HasRecord, 308)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 309)
	MisBeginAction(AddTrigger, 3091, TE_KILL, 622, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000479 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000479")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000479)
	MisNeed(MIS_NEED_KILL, 622, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000480 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000480")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000480)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 309 )
	MisResultCondition(HasFlag, 309, 19)
	MisResultAction(SetRecord, 309 )
	MisResultAction(ClearMission, 309 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 622 )
	TriggerAction( 1, AddNextFlag, 309, 10, 10 )
	RegCurTrigger( 3091 )




-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 369, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 310 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000481 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000481")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000481)
	MisBeginCondition(NoRecord, 310)
	MisBeginCondition(HasRecord, 309)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 310)
	MisBeginAction(AddTrigger, 3101, TE_KILL, 650, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000482 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000482")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000482)
	MisNeed(MIS_NEED_KILL, 650, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000483 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000483")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000483)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 310 )
	MisResultCondition(HasFlag, 310, 19)
	MisResultAction(SetRecord, 310 )
	MisResultAction(ClearMission, 310 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 650 )
	TriggerAction( 1, AddNextFlag, 310, 10, 10 )
	RegCurTrigger( 3101 )


-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 370, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 311 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000484 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000484")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000484)
	MisBeginCondition(NoRecord, 311)
	MisBeginCondition(HasRecord, 310)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 311)
	MisBeginAction(AddTrigger, 3111, TE_KILL, 585, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000485 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000485")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000485)
	MisNeed(MIS_NEED_KILL, 585, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000486 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000486")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000486)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 311 )
	MisResultCondition(HasFlag, 311, 19)
	MisResultAction(SetRecord, 311 )
	MisResultAction(ClearMission, 311 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 585 )
	TriggerAction( 1, AddNextFlag, 311, 10, 10 )
	RegCurTrigger( 3111 )

-------------------------------------------------冒险考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_000458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000458")
	DefineMission( 371, MISSCRIPT_MISSIONSCRIPT02_LUA_000458, 312 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000487 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000487")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000487)
	MisBeginCondition(NoRecord, 312)
	MisBeginCondition(HasRecord, 311)
	MisBeginCondition(HasMission, 302)
	MisBeginAction(AddMission, 312)
	MisBeginAction(AddTrigger, 3121, TE_KILL, 611, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000488 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000488")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000488)
	MisNeed(MIS_NEED_KILL, 611, 10, 10, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000489 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000489")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000489)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000462")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000462)
	MisResultCondition(HasMission, 312 )
	MisResultCondition(HasFlag, 312, 19)
	MisResultAction(SetRecord, 312 )
	MisResultAction(ClearMission, 312 )
        MisResultAction(GiveItem, 3962, 1, 4 )	
	MisResultAction(AddExp,250000,250000)
	MisResultAction(AddMoney,50000,50000)
	MisResultAction(AddExpAndType,2,40000,40000)
	MisResultAction(GiveItem,3845,6,4)
	MisResultBagNeed(2)

			
	InitTrigger()
	TriggerCondition( 1, IsMonster, 611 )
	TriggerAction( 1, AddNextFlag, 312, 10, 10 )
	RegCurTrigger( 3121 )

----------------------------贝蒂
	MISSCRIPT_MISSIONSCRIPT02_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000490")
	DefineMission( 372, MISSCRIPT_MISSIONSCRIPT02_LUA_000490, 313 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000491 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000491")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000491 )
	MisBeginCondition(NoRecord, 313)
	MisBeginCondition(HasRecord, 302)
	MisBeginCondition(NoMission, 313)
	MisBeginAction(AddMission, 313)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000492 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000492")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000492)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000493 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000493")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000493)
	MisResultCondition(AlwaysFailure )


----------------------------贝蒂
	MISSCRIPT_MISSIONSCRIPT02_LUA_000490 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000490")
	DefineMission( 373, MISSCRIPT_MISSIONSCRIPT02_LUA_000490, 313, COMPLETE_SHOW )

	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000494 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000494")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000494)
	MisResultCondition(NoRecord, 313)
	MisResultCondition(HasMission, 313)
	MisResultAction(SetRecord, 313 )
	MisResultAction(ClearMission, 313 )

-----------------------------------家乡
	MISSCRIPT_MISSIONSCRIPT02_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000495")
	DefineMission( 374, MISSCRIPT_MISSIONSCRIPT02_LUA_000495, 315 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000496 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000496")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000496)
	MisBeginCondition(NoRecord, 315)
	MisBeginCondition(HasRecord, 313)
	MisBeginCondition(NoMission, 315)
	MisBeginAction(AddMission, 315)
	MisBeginAction(AddTrigger, 3151, TE_GETITEM, 4235, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000497 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000497")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000497)
	MisNeed(MIS_NEED_ITEM, 4235, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000498 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000498")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000498)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000499 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000499")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000499)
	MisResultCondition(HasMission, 315 )
	MisResultCondition(HasItem, 4235, 1)
	MisResultAction(GiveItem, 4237, 1 , 4)
	MisResultAction(SetRecord, 315 )
	MisResultAction(ClearMission, 315 )
	MisResultBagNeed(1)
	
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 4235 )
	TriggerAction( 1, AddNextFlag, 315, 1, 1 )
	RegCurTrigger( 3151 )


-----------------------------------贝蒂的耳环
	MISSCRIPT_MISSIONSCRIPT02_LUA_000500 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000500")
	DefineMission( 375, MISSCRIPT_MISSIONSCRIPT02_LUA_000500, 316 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000501 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000501")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000501)
	MisBeginCondition(NoRecord, 316)
	MisBeginCondition(HasMission, 315)
	MisBeginCondition(NoMission, 316)
	MisBeginCondition(NoPfEqual, 1)
	MisBeginCondition(NoPfEqual, 2)
	MisBeginCondition(NoPfEqual, 8)
	MisBeginCondition(NoPfEqual, 9)
	MisBeginCondition(NoPfEqual, 12)
	MisBeginAction(AddMission, 316)
	MisBeginAction(AddTrigger, 3161, TE_KILL, 504, 100)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000502 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000502")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000502)
	MisNeed(MIS_NEED_KILL, 504, 100, 1, 100)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000503 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000503")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000503)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000504 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000504")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000504)
	MisResultCondition(HasMission, 316 )
	MisResultCondition(HasFlag, 316, 100)
	MisResultAction(SetRecord, 316 )
	MisResultAction(ClearMission, 316 )
        MisResultAction(GiveItem, 4235, 1, 4 )	
	MisResultBagNeed(1)
 		
	InitTrigger()
	TriggerCondition( 1, IsMonster, 504 )
	TriggerAction( 1, AddNextFlag, 316, 1, 100 )
	RegCurTrigger( 3161 )


-------------------------------------------------家乡
	MISSCRIPT_MISSIONSCRIPT02_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000495")
	DefineMission( 376, MISSCRIPT_MISSIONSCRIPT02_LUA_000495, 315 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000505")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000505)
	MisResultCondition(NoRecord, 315)
	MisResultCondition(NoFlag, 315, 10)
	MisResultCondition(NoItem, 4235, 1)
	MisResultCondition(HasMission, 315 )
	MisResultCondition(PfEqual, 1)
	MisResultAction(GiveItem, 4235, 1, 4 )
	MisResultAction(SetFlag, 315, 10 )
	MisResultBagNeed(1)

-------------------------------------------------家乡
	MISSCRIPT_MISSIONSCRIPT02_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000495")
	DefineMission( 377, MISSCRIPT_MISSIONSCRIPT02_LUA_000495, 315 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000505")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000505)
	MisResultCondition(NoRecord, 315)
	MisResultCondition(NoFlag, 315, 20)
	MisResultCondition(NoItem, 4235, 1)
	MisResultCondition(HasMission, 315 )
	MisResultCondition(PfEqual, 8)
	MisResultAction(GiveItem, 4235, 1, 4 )
	MisResultAction(SetFlag, 315, 20 )
	MisResultBagNeed(1)

-------------------------------------------------家乡
	MISSCRIPT_MISSIONSCRIPT02_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000495")
	DefineMission( 560, MISSCRIPT_MISSIONSCRIPT02_LUA_000495, 315 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000505")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000505)
	MisResultCondition(NoRecord, 315)
	MisResultCondition(NoFlag, 315, 30)
	MisResultCondition(NoItem, 4235, 1)
	MisResultCondition(HasMission, 315 )
	MisResultCondition(PfEqual, 9)
	MisResultAction(GiveItem, 4235, 1, 4 )
	MisResultAction(SetFlag, 315, 30 )
	MisResultBagNeed(1)

-------------------------------------------------家乡
	MISSCRIPT_MISSIONSCRIPT02_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000495")
	DefineMission( 561, MISSCRIPT_MISSIONSCRIPT02_LUA_000495, 315 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000505")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000505)
	MisResultCondition(NoRecord, 315)
	MisResultCondition(NoFlag, 315, 40)
	MisResultCondition(NoItem, 4235, 1)
	MisResultCondition(HasMission, 315 )
	MisResultCondition(PfEqual, 2)
	MisResultAction(GiveItem, 4235, 1, 4 )
	MisResultAction(SetFlag, 315, 40 )
	MisResultBagNeed(1)

-------------------------------------------------家乡
	MISSCRIPT_MISSIONSCRIPT02_LUA_000495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000495")
	DefineMission( 562, MISSCRIPT_MISSIONSCRIPT02_LUA_000495, 315 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000505 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000505")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000505)
	MisResultCondition(NoRecord, 315)
	MisResultCondition(NoFlag, 315, 50)
	MisResultCondition(NoItem, 4235, 1)
	MisResultCondition(HasMission, 315 )
	MisResultCondition(PfEqual, 12)
	MisResultAction(GiveItem, 4235, 1, 4 )
	MisResultAction(SetFlag, 315, 50 )
	MisResultBagNeed(1)



-----------------------------------古老的胸针
	MISSCRIPT_MISSIONSCRIPT02_LUA_000506 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000506")
	DefineMission( 378, MISSCRIPT_MISSIONSCRIPT02_LUA_000506, 317 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000507 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000507")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000507)
	MisBeginCondition(NoRecord, 317)
	MisBeginCondition(HasRecord, 316)
	MisBeginCondition(HasItem, 4235, 1)
	MisBeginCondition(NoMission, 317)
	MisBeginAction(AddMission, 317)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000508 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000508")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000508)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000509 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000509")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000509)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000510 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000510")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000510)
	MisResultCondition(HasMoney, 100000 )
	MisResultCondition(HasMission, 317 )
	MisResultAction(TakeMoney, 100000 )
	MisResultAction(GiveItem, 4236, 1, 4 )
	MisResultAction(SetRecord, 317 )
	MisResultAction(ClearMission, 317 )
	MisResultAction(AddExp,180000,180000)
	MisResultAction(AddMoney,15000,15000)
	MisResultAction(AddExpAndType,2,40000,40000)
	MisResultAction(GiveItem,3848,30,4)
	MisResultBagNeed(2)
	

-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 379, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 318 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000511 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000511")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000511)
	MisBeginCondition(NoRecord, 318)
	MisBeginCondition(HasMission, 22)
	MisBeginCondition(NoMission, 318)
	MisBeginAction(SetRecord, 22)
	MisBeginAction(ClearMission, 22)
	MisBeginAction(AddMission, 318)
	MisBeginAction(AddTrigger, 3181, TE_GETITEM, 4238, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000512 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000512")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000512)
	MisNeed(MIS_NEED_ITEM, 4238, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000513 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000513")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000513)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000514 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000514")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000514)
	MisResultCondition(HasMission, 318 )
	MisResultCondition(HasItem, 4238, 1 )
	MisResultAction(TakeItem, 4238, 1 )
	MisResultAction(SetRecord, 318 )
	MisResultAction(ClearMission, 318 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4238 )
	TriggerAction( 1, AddNextFlag, 318, 1, 1 )
	RegCurTrigger( 3181 )


----------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 380, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 319 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000515 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000515")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000515 )
	MisBeginCondition(NoRecord, 319)
	MisBeginCondition(HasRecord, 318)
	MisBeginCondition(NoMission, 319)
	MisBeginAction(AddMission, 319)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000516 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000516")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000516)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000517 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000517")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000517)
	MisResultCondition(AlwaysFailure )



-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 381, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 320 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000518 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000518")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000518)
	MisBeginCondition(NoRecord, 320)
	MisBeginCondition(HasMission, 319)
	MisBeginCondition(NoMission, 320)
	MisBeginAction(ClearMission, 319)
	MisBeginAction(SetRecord, 319)
	MisBeginAction(AddMission, 320)
	MisBeginAction(AddTrigger, 3201, TE_GETITEM, 1478, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000519 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000519")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000519)
	MisNeed(MIS_NEED_ITEM, 1478, 20, 1, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000520 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000520")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000520)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000521 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000521")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000521)
	MisResultCondition(HasMission, 320)
	MisResultCondition(HasItem, 1478, 20 )
        MisResultAction(TakeItem, 1478, 20 )
	MisResultAction(SetRecord, 320 )
	MisResultAction(ClearMission, 320 )
  	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 1478 )
	TriggerAction( 1, AddNextFlag, 320, 1, 20 )
	RegCurTrigger( 3201 )



-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 382, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 321 )
	MisBeginCondition(NoMission, 321)
	MisBeginCondition(HasRecord, 320)
	MisBeginCondition(NoMission, 321)
	MisBeginAction(AddMission, 321)	

	MISSCRIPT_MISSIONSCRIPT02_LUA_000522 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000522")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000522)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000523 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000523")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000523)
	
	MisResultCondition(AlwaysFailure )


-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 383, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 321, COMPLETE_SHOW )
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000524 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000524")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000524)
	MisResultCondition(NoRecord, 321)
	MisResultCondition(HasMission, 321)
	MisResultAction(ClearMission, 321)
	MisResultAction(SetRecord, 321)

-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 384, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 323 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000525 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000525")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000525)
	MisBeginCondition(NoRecord, 323)
	MisBeginCondition(HasRecord, 321)
	MisBeginCondition(NoMission, 323)
	MisBeginAction(AddMission, 323)
	MisBeginAction(AddTrigger, 3231, TE_GETITEM, 4938, 30)
	MisBeginAction(AddTrigger, 3232, TE_GETITEM, 4957, 30)
	MisBeginAction(AddTrigger, 3233, TE_GETITEM, 4976, 30)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000526 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000526")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000526)
	MisNeed(MIS_NEED_ITEM, 4938, 30, 1, 30)
	MisNeed(MIS_NEED_ITEM, 4957, 30, 31, 30)
	MisNeed(MIS_NEED_ITEM, 4976, 30, 61, 30)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000527 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000527")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000527)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000528 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000528")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000528)
	MisResultCondition(HasMission, 323 )
	MisResultCondition(HasItem, 4938, 30)
	MisResultCondition(HasItem, 4957, 30)
	MisResultCondition(HasItem, 4976, 30)
	MisResultAction(TakeItem, 4938, 30 )
	MisResultAction(TakeItem, 4957, 30 )
	MisResultAction(TakeItem, 4976, 30 )
	MisResultAction(SetRecord, 323 )
	MisResultAction(ClearMission, 323 )
	
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 4938 )
	TriggerAction( 1, AddNextFlag, 323, 1, 30 )
	RegCurTrigger( 3231 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4957 )
	TriggerAction( 1, AddNextFlag, 323, 31, 30 )
	RegCurTrigger( 3232 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4976 )
	TriggerAction( 1, AddNextFlag, 323, 61, 30 )
	RegCurTrigger( 3233 )



-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 385, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 324 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000529 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000529")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000529)
	MisBeginCondition(NoRecord, 324)
	MisBeginCondition(HasRecord, 323)
	MisBeginCondition(NoMission, 324)
	MisBeginAction(AddMission, 324)
	MisBeginAction(AddTrigger, 3241, TE_GETITEM, 4254, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000530 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000530")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000530)
	MisNeed(MIS_NEED_ITEM, 4254, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000531 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000531")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000531)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000532 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000532")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000532)
	MisResultCondition(HasMission, 324 )
	MisResultCondition(HasMission, 325 )
	MisResultCondition(HasItem, 4254, 1)
	MisResultAction(TakeItem, 4254, 1)
	MisResultAction(SetRecord, 324 )
	MisResultAction(ClearMission, 324 )

		
	InitTrigger()
	TriggerCondition( 1, IsItem, 4254 )
	TriggerAction( 1, AddNextFlag, 324, 1, 1 )
	RegCurTrigger( 3241 )

-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 386, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 325 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000533 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000533")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000533)
	MisBeginCondition(NoRecord, 325)
	MisBeginCondition(HasMission, 324)
	MisBeginCondition(NoMission, 325)
	MisBeginAction(AddMission, 325)
	MisBeginAction(GiveItem, 4254, 1, 4 )	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000534 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000534")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000534)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000535 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000535")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000535)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000536 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000536")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000536)
	MisResultCondition(HasMission, 325)
	MisResultCondition(HasRecord, 324)
	MisResultAction(SetRecord, 325 )
	MisResultAction(ClearMission, 325 )	

-----------------------------------命运之轮
	MISSCRIPT_EUDEMONSCRIPT_LUA_000060 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000060")
	DefineMission( 387, MISSCRIPT_EUDEMONSCRIPT_LUA_000060, 326 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000537 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000537")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000537)
	MisBeginCondition(NoRecord, 326)
	MisBeginCondition(HasRecord, 325)
	MisBeginCondition(NoMission, 326)
	MisBeginAction(AddMission, 326)
	MisBeginAction(AddTrigger, 3261, TE_GETITEM, 4255, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000538 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000538")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000538)
	MisNeed(MIS_NEED_ITEM, 4255, 10, 1, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000539 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000539")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000539)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000540 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000540")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000540)
	MisResultCondition(HasMission, 326 )
	MisResultCondition(HasItem, 4255, 10)
	MisResultAction(TakeItem, 4255, 10 )
	MisResultAction(SetRecord, 326 )
	MisResultAction(SetRecord, 330 )
	MisResultAction(ClearMission, 326 )
	MisResultAction(AddExp,320000,320000)
	MisResultAction(AddExpAndType,2,50000,50000)
	MisResultAction(GiveItem,3846,1,4)
	MisResultBagNeed(1)
		
	InitTrigger()
	TriggerCondition( 1, IsItem, 4255 )
	TriggerAction( 1, AddNextFlag, 326, 1, 10)
	RegCurTrigger( 3261 )

----------------------------语言问题
	MISSCRIPT_EUDEMONSCRIPT_LUA_000081 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000081")
	DefineMission( 559, MISSCRIPT_EUDEMONSCRIPT_LUA_000081, 387 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000541 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000541")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000541 )
	MisBeginCondition(NoRecord, 387)
	MisBeginCondition(NoMission, 387)
	MisBeginCondition(NoRecord, 327)
	MisBeginCondition(NoRecord, 330)
	MisBeginAction( AddMission, 387 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012 )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000492 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000492")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000492)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000542 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000542")
	MisHelpTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000542 )
	MisResultCondition( AlwaysFailure )

----------------------------语言问题
	MISSCRIPT_EUDEMONSCRIPT_LUA_000081 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000081")
	DefineMission( 388, MISSCRIPT_EUDEMONSCRIPT_LUA_000081, 327)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000543 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000543")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000543 )
	MisBeginCondition(NoRecord, 327)
	MisBeginCondition(HasMission, 387)
	MisBeginCondition(NoMission, 327)
	MisBeginAction(SetRecord, 387)
	MisBeginAction(ClearMission, 387)
	MisBeginAction(AddMission, 327)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000544 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000544")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000544)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000545 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000545")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000545)
	MisResultCondition(AlwaysFailure )



-----------------------------------语言问题
	MISSCRIPT_EUDEMONSCRIPT_LUA_000081 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000081")
	DefineMission( 389, MISSCRIPT_EUDEMONSCRIPT_LUA_000081, 328 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000546 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000546")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000546)
	MisBeginCondition(NoRecord, 328)
	MisBeginCondition(HasMission, 327)
	MisBeginCondition(NoMission, 328)
	MisBeginAction(SetRecord, 327)
	MisBeginAction(ClearMission, 327)
	MisBeginAction(AddMission, 328)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000547 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000547")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000547)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000548 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000548")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000548)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000549 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000549")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000549)
	MisResultCondition(HasMoney, 100000 )
	MisResultCondition(HasMission, 328 )
	MisResultAction(TakeMoney, 100000 )
	MisResultAction(SetRecord, 328 )
	MisResultAction(ClearMission, 328 )
        MisResultAction(GiveItem, 4256, 1, 4 )
	MisResultBagNeed(1)


-----------------------------------语言问题
	MISSCRIPT_EUDEMONSCRIPT_LUA_000081 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000081")
	DefineMission( 391, MISSCRIPT_EUDEMONSCRIPT_LUA_000081, 330 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000550 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000550")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000550)
	MisBeginCondition(NoRecord, 30)
	MisBeginCondition(NoRecord, 330)
	MisBeginCondition(HasMission, 30)
	MisBeginAction(AddMission, 330)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000551 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000551")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000551)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000552 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000552")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000552)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000553 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000553")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000553)
	MisResultCondition(HasMission, 330 )
	MisResultCondition(HasItem, 4938, 30)
	MisResultCondition(HasItem, 4957, 30)
	MisResultCondition(HasItem, 4976, 30)
	MisResultCondition(HasItem, 4974, 10)
	MisResultCondition(HasMoney, 50000 )
	MisResultAction(SetRecord, 30)
	MisResultAction(ClearMission, 30)
	MisResultAction(TakeItem, 4938, 30)
	MisResultAction(TakeItem, 4957, 30)
	MisResultAction(TakeItem, 4976, 30)
	MisResultAction(TakeItem, 4974, 10)
	MisResultAction(TakeMoney, 50000 )
	MisResultAction(SetRecord, 330 )
	MisResultAction(ClearMission, 330 )
      	MisResultAction(AddExp,550000,550000)
	MisResultAction(AddMoney,10000,10000)
	MisResultAction(AddExpAndType,2,50000,50000)
	MisResultAction(GiveItem,3908,1,4)	
	MisResultAction(GiveItem,4708,1,4)
	MisResultBagNeed(3)

----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 392, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000555 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000555")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000555 )
	MisBeginCondition(NoRecord, 331)
	MisBeginCondition(HasRecord, 315)
	MisBeginCondition(NoMission, 331)
	MisBeginAction(AddTrigger, 3311, TE_GETITEM, 4242, 7 )
	MisBeginAction(AddMission, 331)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000556 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000556")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000556)
	MisNeed(MIS_NEED_ITEM, 4242, 7, 10, 7)	

	MISSCRIPT_MISSIONSCRIPT02_LUA_000557 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000557")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000557)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000558 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000558")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000558)
	MisResultCondition(HasMission, 331)
	MisResultCondition(HasItem, 4242, 7)
	MisResultAction(TakeItem, 4242, 7 )
	MisResultAction(SetRecord, 331 )
	MisResultAction(ClearMission, 331 )
	MisResultAction(AddExp,100000,100000)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,50000,50000)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4242 )
	TriggerAction( 1, AddNextFlag, 331, 10, 7)
	RegCurTrigger( 3311 )

----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 393, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000559 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000559")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000559)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 1)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 1)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)

----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 394, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000560 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000560")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000560)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 2)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 2)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)
	
----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 395, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000561 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000561")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000561)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 3)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 3)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)
	
---------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 396, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000562 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000562")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000562)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 4)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 4)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)
	
----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 397, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000563 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000563")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000563)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 5)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 5)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)
	

----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 398, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000564 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000564")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000564)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 6)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 6)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)

----------------------------远来是客
	MISSCRIPT_MISSIONSCRIPT02_LUA_000554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000554")
	DefineMission( 399, MISSCRIPT_MISSIONSCRIPT02_LUA_000554, 331, COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000565 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000565")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000565)
	MisResultCondition(NoRecord, 331)
	MisResultCondition(NoFlag, 331, 7)
	MisResultCondition(HasMission, 331)
	MisResultAction(SetFlag, 331, 7)
	MisResultAction(GiveItem, 4242, 1, 4)
	MisResultBagNeed(1)

-----------------------------------画龙点睛
	MISSCRIPT_MISSIONSCRIPT02_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000566")
	DefineMission( 510, MISSCRIPT_MISSIONSCRIPT02_LUA_000566, 339 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000567 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000567")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000567)
	MisBeginCondition(NoRecord, 339)
	MisBeginCondition(HasRecord, 338)
	MisBeginCondition(NoMission, 339)
        MisBeginCondition(HasItem, 4236,1)
	MisBeginAction(AddMission, 339)
	MisBeginAction(AddTrigger, 3391, TE_GETITEM, 4236, 1 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000568 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000568")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000568)
	MisNeed(MIS_NEED_ITEM, 4236, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000569 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000569")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000569)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000570 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000570")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000570)
	MisResultCondition(HasMission, 339 )
	MisResultCondition(HasItem, 4236, 1 )
	MisResultAction(TakeItem, 4236, 1 )	
	MisResultAction(SetRecord, 339 )
	MisResultAction(ClearMission, 339 )
    


-----------------------------------画龙点睛
	MISSCRIPT_MISSIONSCRIPT02_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000566")
	DefineMission( 511, MISSCRIPT_MISSIONSCRIPT02_LUA_000566, 340 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000571 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000571")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000571)
	MisBeginCondition(NoRecord, 340)
	MisBeginCondition(HasRecord, 339)
	MisBeginCondition(NoMission, 340)
	MisBeginAction(AddMission, 340)
	MisBeginAction(AddTrigger, 3401, TE_GETITEM, 1787, 5)
	MisBeginAction(AddTrigger, 3402, TE_GETITEM, 1788, 5)
	MisBeginAction(AddTrigger, 3403, TE_GETITEM, 1789, 5)
	MisBeginAction(AddTrigger, 3404, TE_GETITEM, 1790, 5)
	MisBeginAction(AddTrigger, 3405, TE_GETITEM, 1791, 5)
	MisBeginAction(AddTrigger, 3406, TE_GETITEM, 1792, 5)
	MisBeginAction(AddTrigger, 3407, TE_GETITEM, 1793, 5)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000572 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000572")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000572)
	MisNeed(MIS_NEED_ITEM, 1787, 5, 1, 5)
	MisNeed(MIS_NEED_ITEM, 1788, 5, 6, 5)
	MisNeed(MIS_NEED_ITEM, 1789, 5, 11, 5)
	MisNeed(MIS_NEED_ITEM, 1790, 5, 16, 5)
	MisNeed(MIS_NEED_ITEM, 1791, 5, 21, 5)
	MisNeed(MIS_NEED_ITEM, 1792, 5, 26, 5)
	MisNeed(MIS_NEED_ITEM, 1793, 5, 31, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000573 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000573")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000573)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000574 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000574")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000574)
	MisResultCondition(HasMission, 340)
	MisResultCondition(HasItem, 1787, 5)
	MisResultCondition(HasItem, 1787, 5)
	MisResultCondition(HasItem, 1788, 5)
	MisResultCondition(HasItem, 1789, 5)
	MisResultCondition(HasItem, 1790, 5)
	MisResultCondition(HasItem, 1791, 5)
	MisResultCondition(HasItem, 1792, 5)
	MisResultCondition(HasItem, 1793, 5)
	MisResultAction(TakeItem, 1787, 5 )	
	MisResultAction(TakeItem, 1788, 5 )	
	MisResultAction(TakeItem, 1789, 5 )	
	MisResultAction(TakeItem, 1790, 5 )	
	MisResultAction(TakeItem, 1791, 5 )	
	MisResultAction(TakeItem, 1792, 5 )	
	MisResultAction(TakeItem, 1793, 5 )	
	MisResultAction(SetRecord, 340 )
	MisResultAction(ClearMission, 340 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1787 )
	TriggerAction( 1, AddNextFlag, 340, 1, 5 )
	RegCurTrigger( 3401 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1788 )
	TriggerAction( 1, AddNextFlag, 340, 6, 5 )
	RegCurTrigger( 3402 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1789 )
	TriggerAction( 1, AddNextFlag, 340, 11, 5 )
	RegCurTrigger( 3403 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1790 )
	TriggerAction( 1, AddNextFlag, 340, 16, 5 )
	RegCurTrigger( 3404 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1791 )
	TriggerAction( 1, AddNextFlag, 340, 21, 5 )
	RegCurTrigger( 3405 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1792 )
	TriggerAction( 1, AddNextFlag, 340, 26, 5 )
	RegCurTrigger( 3406 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1793 )
	TriggerAction( 1, AddNextFlag, 340, 31, 5 )
	RegCurTrigger( 3407 )

-----------------------------------画龙点睛
	MISSCRIPT_MISSIONSCRIPT02_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000566")
	DefineMission( 512, MISSCRIPT_MISSIONSCRIPT02_LUA_000566, 341 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000575 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000575")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000575)
	MisBeginCondition(NoRecord, 341)
	MisBeginCondition(HasRecord, 340)
	MisBeginCondition(NoMission, 341)
	MisBeginAction(AddMission, 341)
	MisBeginAction(AddTrigger, 3411, TE_GETITEM, 1649, 30)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000576 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000576")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000576)
	MisNeed(MIS_NEED_ITEM, 1649, 30, 1, 30)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000577 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000577")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000577)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000578 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000578")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000578)
	MisResultCondition(HasMission, 341)
	MisResultCondition(HasItem, 1649, 30)
	MisResultAction(TakeItem, 1649, 30 )
	MisResultAction(SetRecord, 341 )
	MisResultAction(ClearMission, 341 )

	InitTrigger()
	TriggerCondition( 1, IsItem, 1649 )
	TriggerAction( 1, AddNextFlag, 341, 1, 30 )
	RegCurTrigger( 3411 )
	

-----------------------------------画龙点睛
	MISSCRIPT_MISSIONSCRIPT02_LUA_000566 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000566")
	DefineMission( 513, MISSCRIPT_MISSIONSCRIPT02_LUA_000566, 342 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000579 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000579")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000579)
	MisBeginCondition(NoMission, 342)
	MisBeginCondition(NoRecord, 342)
	MisBeginCondition(HasRecord, 341)
	MisBeginAction(AddMission, 342)
	MisBeginAction(AddTrigger, 3421, TE_GETITEM, 165, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000580 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000580")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000580)
	MisNeed(MIS_NEED_ITEM, 165, 10, 1, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000581 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000581")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000581)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000582 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000582")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000582)
	MisResultCondition(HasMission, 342)
	MisResultCondition(HasItem, 165, 10)
	MisResultAction(TakeItem, 165, 10 )
	MisResultAction(SetRecord, 342 )
	MisResultAction(ClearMission, 342 )
	MisResultAction(AddExp,700000,700000)
	MisResultAction(AddMoney,10000,10000)
	MisResultAction(GiveItem,3885,1,4)	
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 165 )
	TriggerAction( 1, AddNextFlag, 342, 1, 10 )
	RegCurTrigger( 3421 )


-----------------------------------失踪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000583")
	DefineMission( 514, MISSCRIPT_MISSIONSCRIPT02_LUA_000583, 343 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000584 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000584")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000584)
	MisBeginCondition(NoRecord, 343)
	MisBeginCondition(NoMission, 343)
	MisBeginCondition(HasRecord, 331)
   	MisBeginAction(AddMission, 343)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000585 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000585")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000585)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000586 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000586")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000586)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000587 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000587")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000587)
	MisResultCondition(HasMission, 343 )
	MisResultCondition(HasFlag, 343, 2 )
	MisResultAction(SetRecord, 343 )
	MisResultAction(ClearMission, 343 )

-----------------------------------失踪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000583")
	DefineMission( 515, MISSCRIPT_MISSIONSCRIPT02_LUA_000583, 343 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000588 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000588")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000588)
	MisResultCondition(NoRecord, 343)
	MisResultCondition(HasMission, 343)
	MisResultCondition(NoFlag, 343, 2)
	MisResultAction(SetFlag, 343, 2)
	
-----------------------------------失踪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000583")
	DefineMission( 516, MISSCRIPT_MISSIONSCRIPT02_LUA_000583, 345 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000589 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000589")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000589)
	MisBeginCondition(NoRecord, 345)
	MisBeginCondition(NoRecord, 347)
	MisBeginCondition(HasRecord, 343)
	MisBeginCondition(NoMission, 345)
  	MisBeginAction(AddMission, 345)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000590 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000590")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000590)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000591 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000591")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000591)
	MisResultCondition(AlwaysFailure )

-----------------------------------灵符
	MISSCRIPT_MISSIONSCRIPT02_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000592")
	DefineMission( 517, MISSCRIPT_MISSIONSCRIPT02_LUA_000592, 346 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000593 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000593")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000593)
	MisBeginCondition(NoRecord, 346)
	MisBeginCondition(HasMission, 345)
	MisBeginCondition(NoMission, 346)
  	MisBeginAction(AddMission, 346)
	MisBeginAction(AddTrigger, 3461, TE_GETITEM, 4262, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000594 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000594")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000594)
	MisNeed(MIS_NEED_ITEM, 4262, 20, 1, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000595 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000595")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000595)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000596 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000596")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000596)
	MisResultCondition(HasMission, 346 )
	MisResultCondition(HasItem, 4262, 20)
	MisResultAction(TakeItem, 4262,20 )
	MisResultAction(GiveItem, 4244, 1, 4)
	MisResultAction(SetRecord, 346 )
	MisResultAction(ClearMission, 346 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4262 )
	TriggerAction( 1, AddNextFlag, 346, 1, 20 )
	RegCurTrigger( 3461 )

-----------------------------------灵符
	MISSCRIPT_MISSIONSCRIPT02_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000592")
	DefineMission( 518, MISSCRIPT_MISSIONSCRIPT02_LUA_000592, 347 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000597 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000597")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000597)
	MisBeginCondition(NoRecord, 347)
	MisBeginCondition(NoMission, 347)
	MisBeginCondition(HasRecord, 346)
	MisBeginCondition(HasItem, 4244, 1)
	MisBeginAction(TakeItem, 4244, 1)
  	MisBeginAction(AddMission, 347)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000598 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000598")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000598)
	
	MisResultCondition(AlwaysFailure )

-----------------------------------灵符
	MISSCRIPT_MISSIONSCRIPT02_LUA_000592 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000592")
	DefineMission( 519, MISSCRIPT_MISSIONSCRIPT02_LUA_000592, 347 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000599 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000599")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000599)
	MisResultCondition(NoRecord, 347)
	MisResultCondition(HasMission, 347)
	MisResultAction(SetRecord, 347)
	MisResultAction(ClearMission, 347)
	MisResultAction(AddExp,1000000,1000000)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(GiveItem, 3883, 5, 4)
	MisResultAction(GiveItem, 3884, 5, 4)
	MisResultBagNeed(2)

-----------------------------------爱的奇迹
	MISSCRIPT_MISSIONSCRIPT02_LUA_000600 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000600")
	DefineMission( 520, MISSCRIPT_MISSIONSCRIPT02_LUA_000600, 349 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000601 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000601")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000601)
	MisBeginCondition(NoRecord, 349)
	MisBeginCondition(NoRecord, 356)
	MisBeginCondition(HasRecord, 347)
	MisBeginCondition(NoMission, 349)
	MisBeginCondition(NoMission, 356)
	MisBeginAction(AddMission, 349)
	MisBeginAction(AddTrigger, 3491, TE_GETITEM, 4245, 1 )
	MisBeginAction(AddTrigger, 3492, TE_GETITEM, 4246, 1 )
	MisBeginAction(AddTrigger, 3493, TE_GETITEM, 4247, 1 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000602 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000602")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000602)
	MisNeed(MIS_NEED_ITEM, 4245, 1, 5, 1)
	MisNeed(MIS_NEED_ITEM, 4246, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4247, 1, 15, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000603 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000603")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000603)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000604 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000604")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000604)
	MisResultCondition(HasMission, 349 )
	MisResultCondition(HasItem, 4245, 1 )	
	MisResultCondition(HasItem, 4246, 1 )	
	MisResultCondition(HasItem, 4247, 1 )
	MisResultAction(TakeItem, 4245, 1 )	
	MisResultAction(TakeItem, 4246, 1 )	
	MisResultAction(TakeItem, 4247, 1 )
        MisResultAction(GiveItem, 4248, 1 ,4)	
	MisResultAction(SetRecord, 349 )
	MisResultAction(ClearMission, 349 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4245)	
	TriggerAction( 1, AddNextFlag, 349, 5, 1 )
	RegCurTrigger( 3491 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4246)	
	TriggerAction( 1, AddNextFlag, 349, 10, 1 )
	RegCurTrigger( 3492 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4247)	
	TriggerAction( 1, AddNextFlag, 349, 15, 1 )
	RegCurTrigger( 3493 )

-----------------------------------女神的眼泪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000605 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000605")
	DefineMission( 521, MISSCRIPT_MISSIONSCRIPT02_LUA_000605, 350 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000606 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000606")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000606)
	MisBeginCondition(NoRecord, 350)
	MisBeginCondition(NoMission, 350)
	MisBeginCondition(HasMission, 349)
 	MisBeginAction(AddMission, 350)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000607 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000607")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000607)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000608 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000608")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000608)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000609 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000609")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000609)
	MisResultCondition(HasMission, 350)
	MisResultCondition(HasItem, 4245, 1)
 	MisResultAction(SetRecord, 350 )
	MisResultAction(ClearMission, 350 )



-----------------------------------人鱼的心脏
	MISSCRIPT_MISSIONSCRIPT02_LUA_000610 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000610")
	DefineMission( 522, MISSCRIPT_MISSIONSCRIPT02_LUA_000610, 351 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000611 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000611")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000611)
	MisBeginCondition(NoRecord, 351)
	MisBeginCondition(NoMission, 351)
	MisBeginCondition(HasMission, 349)
 	MisBeginAction(AddMission, 351)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000612 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000612")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000612)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000613 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000613")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000613)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000614 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000614")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000614)
	MisResultCondition(HasMission, 351)
	MisResultCondition(HasItem, 4246, 1)
 	MisResultAction(SetRecord, 351 )
	MisResultAction(ClearMission, 351 )

	-----------------------------------飞鸟的羽毛
	MISSCRIPT_MISSIONSCRIPT02_LUA_000615 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000615")
	DefineMission( 523, MISSCRIPT_MISSIONSCRIPT02_LUA_000615, 352 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000616 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000616")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000616)
	MisBeginCondition(NoRecord, 352)
	MisBeginCondition(NoMission, 352)
	MisBeginCondition(HasMission, 349)
 	MisBeginAction(AddMission, 352)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000617 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000617")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000617)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000618 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000618")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000618)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000619 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000619")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000619)
	MisResultCondition(HasMission, 352)
	MisResultCondition(HasItem, 4247, 1)
 	MisResultAction(SetRecord, 352 )
	MisResultAction(ClearMission, 352 )

-----------------------------------爱的奇迹
	MISSCRIPT_MISSIONSCRIPT02_LUA_000600 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000600")
	DefineMission( 524, MISSCRIPT_MISSIONSCRIPT02_LUA_000600, 353 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000620 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000620")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000620)
	MisBeginCondition(NoRecord, 353)
	MisBeginCondition(NoMission, 353)
	MisBeginCondition(HasRecord, 349)
	MisBeginCondition(HasItem, 4248,1)
	MisBeginAction(TakeItem, 4248, 1)
  	MisBeginAction(AddMission, 353)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000621 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000621")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000621)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000622 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000622")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000622)
	MisResultCondition(AlwaysFailure )

-----------------------------------爱的奇迹
	MISSCRIPT_MISSIONSCRIPT02_LUA_000600 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000600")
	DefineMission( 525, MISSCRIPT_MISSIONSCRIPT02_LUA_000600, 353 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000623 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000623")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000623)
	MisResultCondition(NoRecord, 353)
	MisResultCondition(HasMission, 353)
	MisResultAction(SetRecord, 353)
	MisResultAction(ClearMission, 353)	
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddExpAndType,2,50000,50000)
	MisResultAction(GiveItem,3348,10,4)
	MisResultAction(GiveItem,3349,10,4)
	MisResultAction(GiveItem,3350,10,4)
	MisResultBagNeed(3)

-----------------------------------尸毒
	MISSCRIPT_MISSIONSCRIPT02_LUA_000624 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000624")
	DefineMission( 526, MISSCRIPT_MISSIONSCRIPT02_LUA_000624, 355 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000625 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000625")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000625)
	MisBeginCondition(NoRecord, 355)
	MisBeginCondition(NoMission, 355)
	MisBeginCondition(HasRecord, 353)
 	MisBeginAction(AddMission, 355)
	MisBeginAction(AddTrigger, 3551, TE_GETITEM, 4262, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000626 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000626")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000626)
	MisNeed(MIS_NEED_ITEM, 4262, 20, 1, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000627 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000627")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000627)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000628 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000628")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000628)
	MisResultCondition(HasMission, 355)
	MisResultCondition(HasItem, 4262, 20)
	MisResultAction(TakeItem, 4262, 20)
        MisResultAction(GiveItem, 4249, 12 ,4)	
 	MisResultAction(SetRecord, 355 )
	MisResultAction(ClearMission, 355 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4262 )
	TriggerAction( 1, AddNextFlag, 355, 1, 20 )
	RegCurTrigger( 3551 )

-----------------------------------失踪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000583")
	DefineMission( 527, MISSCRIPT_MISSIONSCRIPT02_LUA_000583, 345, COMPLETE_SHOW )

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000629 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000629")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000629)
	MisResultCondition(HasRecord, 347)
	MisResultCondition(NoRecord, 353)
	MisResultCondition(NoRecord, 345)
	MisResultCondition(NoRecord, 349)
	MisResultCondition(HasMission, 345)
	MisResultCondition(NoMission, 353)
	MisResultCondition(NoMission, 349)
	MisResultAction(ClearMission, 345 )
	MisResultAction(SetRecord, 345 )
	
-----------------------------------失踪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000583 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000583")
	DefineMission( 528, MISSCRIPT_MISSIONSCRIPT02_LUA_000583, 345 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000630 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000630")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000630)
	MisResultCondition(HasRecord, 353)
	MisResultCondition(NoRecord, 345)
	MisResultCondition(HasMission, 345)
	MisResultAction(ClearMission, 345 )
	MisResultAction(SetRecord, 345 )
	MisResultAction(SetRecord, 354 )

-----------------------------------神奇果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000631 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000631")
	DefineMission( 529, MISSCRIPT_MISSIONSCRIPT02_LUA_000631, 358 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000632 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000632")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000632)
	MisBeginCondition(NoRecord, 358)
	MisBeginCondition(HasRecord, 345)
	MisBeginCondition(NoMission, 358)
  	MisBeginAction(AddMission, 358)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000633 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000633")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000633)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000634 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000634")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000634)
	MisResultCondition(AlwaysFailure )
-----------------------------------神奇果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000631 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000631")
	DefineMission( 530, MISSCRIPT_MISSIONSCRIPT02_LUA_000631, 359 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000635 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000635")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000635)
	MisBeginCondition(NoRecord, 359)
	MisBeginCondition(NoMission, 359)
	MisBeginCondition(HasMission, 358)
	MisBeginAction(SetRecord, 358 )
	MisBeginAction(ClearMission, 358 )
  	MisBeginAction(AddMission, 359)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000636 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000636")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000636)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000637 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000637")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000637)
	MisResultCondition(AlwaysFailure )

-----------------------------------神奇果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000631 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000631")
	DefineMission( 531, MISSCRIPT_MISSIONSCRIPT02_LUA_000631, 360 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000638 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000638")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000638)
	MisBeginCondition(NoRecord, 360)
	MisBeginCondition(NoMission, 360)
	MisBeginCondition(HasMission, 359)
	MisBeginAction(ClearMission, 359 )
  	MisBeginAction(AddMission, 360)
	MisBeginAction(AddTrigger, 3601, TE_GETITEM, 4263, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000639 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000639")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000639)
	MisNeed(MIS_NEED_ITEM, 4263, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000640 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000640")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000640)
	MisResultCondition(AlwaysFailure )

	InitTrigger()
	TriggerCondition( 1, IsItem, 4263 )
	TriggerAction( 1, AddNextFlag, 360, 1, 1 )
	RegCurTrigger( 3601 )

-----------------------------------恶魔的果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000641 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000641")
	DefineMission( 532, MISSCRIPT_MISSIONSCRIPT02_LUA_000641, 361 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000642 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000642")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000642)
	MisBeginCondition(NoRecord, 361)
	MisBeginCondition(HasMission, 360)
	MisBeginCondition(NoMission, 361)
	MisBeginCondition(HasItem, 4263, 1)
	MisBeginAction(ClearMission, 360 )
 	MisBeginAction(AddMission, 361)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000643 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000643")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000643)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000644 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000644")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000644)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000645 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000645")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000645)
	MisResultCondition(HasMission, 361)
	MisResultCondition(NoItem, 4263, 1)
   	MisResultAction(SetRecord, 361 )
	MisResultAction(ClearMission, 361 )

-----------------------------------周吴郑的信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000646 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000646")
	DefineMission( 533, MISSCRIPT_MISSIONSCRIPT02_LUA_000646, 362 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000647 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000647")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000647)
	MisBeginCondition(NoRecord, 362)
	MisBeginCondition(NoMission, 362)
	MisBeginCondition(HasRecord, 361)
 	MisBeginAction(AddMission, 362)
 	MisBeginAction(GiveItem, 4250,1,4)
	MisBeginBagNeed(1)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000648 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000648")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000648)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000649 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000649")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000649)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000650 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000650")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000650)
	MisResultCondition(HasMission, 362)
	MisResultCondition(HasFlag, 362, 10)
   	MisResultAction(SetRecord, 362 )
	MisResultAction(ClearMission, 362 )

-----------------------------------恶魔的果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000641 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000641")
	DefineMission( 534, MISSCRIPT_MISSIONSCRIPT02_LUA_000641, 363 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000651 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000651")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000651)
	MisBeginCondition(NoRecord, 363)
	MisBeginCondition(NoMission, 363)
	MisBeginCondition(HasRecord, 362)
  	MisBeginAction(AddMission, 363)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000652 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000652")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000652)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000653 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000653")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000653)
	MisResultCondition(AlwaysFailure )
	

-----------------------------------防腐剂
	MISSCRIPT_MISSIONSCRIPT02_LUA_000654 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000654")
	DefineMission( 535, MISSCRIPT_MISSIONSCRIPT02_LUA_000654, 364 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000655 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000655")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000655)
	MisBeginCondition(NoMission, 364)
 	MisBeginAction(AddMission, 364)
	MisBeginAction(AddTrigger, 3641, TE_GETITEM, 4259, 3)
	MisBeginAction(AddTrigger, 3642, TE_GETITEM, 4260, 3)
	MisBeginAction(AddTrigger, 3643, TE_GETITEM, 4261, 3)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000656 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000656")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000656)
	MisNeed(MIS_NEED_ITEM, 4259, 3, 1, 3)
	MisNeed(MIS_NEED_ITEM, 4260, 3, 5, 3)
	MisNeed(MIS_NEED_ITEM, 4261, 3, 10, 3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000657 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000657")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000657)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000658 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000658")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000658)
	MisResultCondition(HasMission, 364)
	MisResultCondition(HasItem, 4259, 3)
	MisResultCondition(HasItem, 4260, 3)
	MisResultCondition(HasItem, 4261, 3)
	MisResultAction(TakeItem, 4259, 3)
	MisResultAction(TakeItem, 4260, 3)
	MisResultAction(TakeItem, 4261, 3)
	MisResultAction(GiveItem, 4251, 1 ,4)	
 	MisResultAction(SetRecord, 364 )
 	MisResultAction(ClearMission, 364 )
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4259 )
	TriggerAction( 1, AddNextFlag, 364, 1, 3 )
	RegCurTrigger( 3641 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4260 )
	TriggerAction( 1, AddNextFlag, 364, 5, 3 )
	RegCurTrigger( 3642 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 4261 )
	TriggerAction( 1, AddNextFlag, 364, 10, 3 )
	RegCurTrigger( 3643)

-----------------------------------龙之泪
	MISSCRIPT_EUDEMONSCRIPT_LUA_000063 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000063")
	DefineMission( 536, MISSCRIPT_EUDEMONSCRIPT_LUA_000063, 24 , COMPLETE_SHOW)
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000659 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000659")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000659)
	MisResultCondition(NoRecord, 24)
	MisResultCondition(HasMission, 24)
	MisResultCondition(HasItem, 4252, 1)
	MisResultAction(SetRecord, 24)
	MisResultAction(ClearMission, 24)

-----------------------------------变卖龙之泪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000660 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000660")
	DefineMission( 537, MISSCRIPT_MISSIONSCRIPT02_LUA_000660, 366 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000661 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000661")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000661)
	MisBeginCondition(NoRecord, 366)
	MisBeginCondition(NoMission, 366)
	MisBeginCondition(NoMission, 367)
	MisBeginCondition(NoRecord, 367)
	MisBeginCondition(HasRecord, 24)	
	MisBeginCondition(HasItem, 4252,1)	
 	MisBeginAction(AddMission, 366)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000662 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000662")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000662)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000663 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000663")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000663)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000664 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000664")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000664)
	MisResultCondition(HasMission, 366)
	MisResultCondition(HasItem, 4252,1)
        MisResultAction(TakeItem, 4252, 1)	
        MisResultAction(AddMoney, 200000, 200000)	
 	MisResultAction(SetRecord, 366 )
 	MisResultAction(ClearMission, 366 )

-----------------------------------龙之泪的传说
	MISSCRIPT_MISSIONSCRIPT02_LUA_000665 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000665")
	DefineMission( 538, MISSCRIPT_MISSIONSCRIPT02_LUA_000665, 367 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000666 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000666")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000666)
	MisBeginCondition(NoRecord, 366)
	MisBeginCondition(HasRecord, 24)
	MisBeginCondition(NoMission, 366)
	MisBeginCondition(NoMission, 367)
	MisBeginCondition(NoRecord, 367)
	MisBeginCondition(HasItem, 4252,1)
	MisBeginAction(AddMission, 367)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000667 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000667")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000667)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000668 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000668")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000668)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000669 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000669")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000669)
	MisResultCondition(HasMission, 367)
	MisResultCondition(HasItem, 4252, 1)
	MisResultAction(SetRecord, 367 )
 	MisResultAction(ClearMission, 367 )
	MisResultAction(ObligeAcceptMission, 25 )




-----------------------------------龙之泪的秘密
	MISSCRIPT_EUDEMONSCRIPT_LUA_000066 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000066")
	DefineMission( 539, MISSCRIPT_EUDEMONSCRIPT_LUA_000066, 25, COMPLETE_SHOW )
	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000670 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000670")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000670)
	MisResultCondition(NoRecord, 25)
	MisResultCondition(HasMission, 25)
	MisResultCondition(HasItem, 4252, 1)
	MisResultAction(SetRecord, 25)
	MisResultAction(ClearMission, 25)

-----------------------------------圣水
	MISSCRIPT_MISSIONSCRIPT02_LUA_000671 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000671")
	DefineMission( 540, MISSCRIPT_MISSIONSCRIPT02_LUA_000671, 369 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000672 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000672")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000672)
	MisBeginCondition(NoRecord, 369)
	MisBeginCondition(NoMission, 369)
	MisBeginCondition(HasRecord, 25 )
	MisBeginAction(GiveItem, 4239,1,4)
 	MisBeginAction(AddMission, 369)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000673 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000673")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000673)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000674 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000674")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000674)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000675 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000675")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000675)
	MisResultCondition(HasMission, 369 )
	MisResultCondition(HasItem, 4257,1)
        MisResultAction(TakeItem, 4257, 1)
	MisResultAction(GiveItem, 4240, 1, 4)
	MisResultAction(SetRecord, 369 )
 	MisResultAction(ClearMission, 369 )
	MisResultBagNeed(1)
 
 -----------------------------------圣水
	MISSCRIPT_MISSIONSCRIPT02_LUA_000676 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000676")
	DefineMission( 541, MISSCRIPT_MISSIONSCRIPT02_LUA_000676, 370 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000677 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000677")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000677)
	MisBeginCondition(HasRecord, 369)
	MisBeginCondition(NoRecord, 370)
	MisBeginCondition(NoMission, 370)
	MisBeginAction(AddMission, 370)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000678 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000678")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000678)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000679 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000679")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000679)
	MisResultCondition(AlwaysFailure )
	
 
 -----------------------------------海砂的存款
	MISSCRIPT_EUDEMONSCRIPT_LUA_000069 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000069")
	DefineMission( 542, MISSCRIPT_EUDEMONSCRIPT_LUA_000069, 26 , COMPLETE_SHOW)
	
	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000680 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000680")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000680)
	MisResultCondition(NoRecord, 26)
	MisResultCondition(HasMission, 26)
	MisResultAction(ClearMission, 26)
	MisResultAction(SetRecord, 26)
        MisResultAction(AddMoney, 200000)	
	MisResultAction(AddExp,1000000,1000000)
	MisResultAction(AddMoney,250000,250000)
	MisResultAction(AddExpAndType,2,60000,60000)

-----------------------------------周吴郑的情书
	MISSCRIPT_EUDEMONSCRIPT_LUA_000072 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000072")
	DefineMission( 543, MISSCRIPT_EUDEMONSCRIPT_LUA_000072, 372 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000681 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000681")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000681)
	MisBeginCondition(NoRecord, 372)
	MisBeginCondition(NoMission, 372)
	MisBeginCondition(HasMission, 27)
 	MisBeginAction(AddMission, 372)
	MisBeginAction(SetRecord, 27)
	MisBeginAction(ClearMission, 27)
	MisBeginAction(AddTrigger, 3721, TE_GETITEM, 4241, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000682 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000682")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000682)
	MisNeed(MIS_NEED_ITEM, 4241, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000683 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000683")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000683)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000684 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000684")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000684)
	MisResultCondition(HasMission, 372)
	MisResultCondition(HasItem, 4241, 1)
	MisResultAction(TakeItem, 4241, 1 )
 	MisResultAction(SetRecord, 372 )
	MisResultAction(ClearMission, 372 )
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4241 )
	TriggerAction( 1, AddNextFlag, 372, 1, 1 )
	RegCurTrigger( 3721 )
 


 -----------------------------------周吴郑的信
	MISSCRIPT_MISSIONSCRIPT02_LUA_000646 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000646")
	DefineMission( 544, MISSCRIPT_MISSIONSCRIPT02_LUA_000646, 362 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000685 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000685")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000685)
	MisResultCondition(NoRecord, 362)
	MisResultCondition(NoFlag, 362, 10)
	MisResultCondition(HasMission, 362)
	MisResultCondition(HasItem, 4250, 1)
	MisResultAction(TakeItem, 4250, 1)
	MisResultAction(SetFlag, 362, 10)
	
-----------------------------------新货
	MISSCRIPT_MISSIONSCRIPT02_LUA_000686 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000686")
	DefineMission( 545, MISSCRIPT_MISSIONSCRIPT02_LUA_000686, 372 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000687 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000687")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000687)
	MisResultCondition(NoRecord, 372)
	MisResultCondition(NoFlag, 372, 10)
	MisResultCondition(HasMission, 372)
	MisResultAction(SetFlag, 372, 10)
	
-----------------------------------出海打探
	MISSCRIPT_EUDEMONSCRIPT_LUA_000075 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000075")
	DefineMission( 546, MISSCRIPT_EUDEMONSCRIPT_LUA_000075, 375 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000688 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000688")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000688)
	MisBeginCondition(NoRecord, 375)
	MisBeginCondition(NoMission, 376)
	MisBeginCondition(NoMission, 375)
	MisBeginCondition(NoRecord, 376)
	MisBeginCondition(HasMission, 372)
	MisBeginCondition(HasFlag, 372, 10)
	MisBeginAction(AddMission, 375)
	MisBeginAction(GiveItem, 4258,1,4)
	MisBeginBagNeed(1)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000689 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000689")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000689)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000690 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000690")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000690)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000691 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000691")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000691)
       	MisResultCondition(HasMission, 28)
	MisResultCondition(HasItem, 4258, 1)
	MisResultAction(TakeItem, 4258, 1)
	MisResultAction(GiveItem, 4241, 1,4)	
 	MisResultAction(SetRecord, 375 )
 	MisResultAction(ClearMission, 375 )
 	MisResultAction(ClearMission, 28 )
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultBagNeed(1)

 -----------------------------------购买新衣
	MISSCRIPT_MISSIONSCRIPT02_LUA_000692 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000692")
	DefineMission( 547, MISSCRIPT_MISSIONSCRIPT02_LUA_000692, 376 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000693 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000693")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000693)
	MisBeginCondition(NoRecord, 375)
	MisBeginCondition(NoMission, 376)
	MisBeginCondition(NoMission, 375)
	MisBeginCondition(NoRecord, 376)
	MisBeginCondition(HasMission, 372)	
	MisBeginAction(AddMission, 376)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000694 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000694")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000694)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000695 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000695")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000695)
	MisResultCondition(HasMission, 376)
	MisResultCondition(HasMoney, 100000)
        MisResultAction(TakeMoney, 100000)	
        MisResultAction(GiveItem, 4241, 1,4)	
 	MisResultAction(SetRecord, 376 )
 	MisResultAction(ClearMission, 376 )
	MisResultBagNeed(1)

-----------------------------------恶魔的果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000641 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000641")
	DefineMission( 548, MISSCRIPT_MISSIONSCRIPT02_LUA_000641, 363 , COMPLETE_SHOW)

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000696 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000696")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000696)
	MisResultCondition(NoRecord, 363)
	MisResultCondition(NoFlag, 363, 22)
	MisResultCondition(HasMission, 363)
	MisResultAction(SetFlag, 363, 22)
	MisResultAction(AddExp,2500000,2500000)
	MisResultAction(AddExpAndType,2,50000,50000)

-----------------------------------恶魔的果实
	MISSCRIPT_MISSIONSCRIPT02_LUA_000641 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000641")
	DefineMission( 550, MISSCRIPT_MISSIONSCRIPT02_LUA_000641, 363, COMPLETE_SHOW )

	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000697 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000697")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000697)
	MisResultCondition(NoRecord, 363)
	MisResultCondition(HasFlag, 363, 22)
	MisResultCondition(HasMission, 363)
	MisResultCondition(HasItem, 4235, 1)
	MisResultAction(TakeItem, 4235, 1)
	MisResultAction(SetRecord, 363)
	MisResultAction(ClearMission, 363)
	MisResultAction(AddMoney,50000,50000)
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultAction(GiveItem,3351,15,4)
	MisResultAction(GiveItem,3352,15,4)
	MisResultAction(GiveItem,3353,15,4)
	MisResultBagNeed(3)


 -----------------------------------罗森
	MISSCRIPT_MISSIONSCRIPT02_LUA_000698 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000698")
	DefineMission( 551, MISSCRIPT_MISSIONSCRIPT02_LUA_000698, 380 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000699 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000699")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000699)
	MisBeginCondition(HasRecord, 363)
	MisBeginCondition(NoRecord, 380)
	MisBeginCondition(NoMission, 380)
	MisBeginAction(AddMission, 380)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000700 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000700")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000700)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000701 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000701")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000701)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000702 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000702")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000702)
	MisResultCondition(HasRecord, 386)
	MisResultCondition(HasMission, 380)
  	MisResultAction(SetRecord, 380 )
 	MisResultAction(ClearMission, 380 )
	


-----------------------------------悲剧
	MISSCRIPT_EUDEMONSCRIPT_LUA_000078 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000078")
	DefineMission( 552, MISSCRIPT_EUDEMONSCRIPT_LUA_000078, 381 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000703 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000703")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000703)
	MisBeginCondition(NoRecord, 381)
	MisBeginCondition(NoMission, 381)
	MisBeginCondition(HasRecord, 290)
	MisBeginAction(AddMission, 381)
  	MisBeginAction(GiveItem,4253,1,4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000704 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000704")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000704)
	MisResultCondition(AlwaysFailure )


-----------------------------------悲剧
	MISSCRIPT_EUDEMONSCRIPT_LUA_000078 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000078")
	DefineMission( 553, MISSCRIPT_EUDEMONSCRIPT_LUA_000078, 382 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000705 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000705")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000705)
	MisBeginCondition(NoMission, 382)
	MisBeginCondition(HasMission, 29)
	MisBeginCondition(HasItem, 4233,1)
	MisBeginAction(ClearMission, 29)
	MisBeginAction(SetRecord, 29)
	MisBeginAction(AddMission, 382)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000706 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000706")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000706)
	
	MisResultCondition(AlwaysFailure )
-----------------------------------悲剧
	MISSCRIPT_EUDEMONSCRIPT_LUA_000078 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000078")
	DefineMission( 554, MISSCRIPT_EUDEMONSCRIPT_LUA_000078, 382, COMPLETE_SHOW )


	MisBeginCondition( AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000707 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000707")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000707)
	MisResultCondition(HasMission, 382)
	MisResultCondition(HasItem, 4233, 1)
	MisResultAction(TakeItem, 4233, 1)
	MisResultAction(ClearMission, 382)
	MisResultAction(SetRecord, 382)

-----------------------------------悲剧
	MISSCRIPT_EUDEMONSCRIPT_LUA_000078 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000078")
	DefineMission( 555, MISSCRIPT_EUDEMONSCRIPT_LUA_000078, 383 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000708 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000708")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000708)
	MisBeginCondition(NoRecord, 383)
 	MisBeginCondition(HasRecord, 382)
 	MisBeginCondition(NoMission, 383)
	MisBeginAction(AddMission, 383)
	MisBeginAction(AddTrigger, 3831, TE_KILL, 594, 10)
	MisBeginAction(AddTrigger, 3832, TE_KILL, 593, 5)
	MisBeginAction(AddTrigger, 3833, TE_KILL, 656, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000709 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000709")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000709)
	MisNeed(MIS_NEED_KILL, 594, 10, 1, 10)
	MisNeed(MIS_NEED_KILL, 593, 5, 11, 5)
	MisNeed(MIS_NEED_KILL, 656, 1, 16, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000710 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000710")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000710)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000711 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000711")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000711)
	MisResultCondition(HasMission, 383 )
	MisResultCondition(HasFlag, 383, 10)
	MisResultCondition(HasFlag, 383, 15)
	MisResultCondition(HasFlag, 383, 16)
 	MisResultAction(SetRecord, 383 )
 	MisResultAction(ClearMission, 383 )
	MisResultAction(AddMoney,100000,100000)
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultAction(GiveItem,3878,1,4)
	MisResultAction(GiveItem,4715,1,4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 594 )
	TriggerAction( 1, AddNextFlag, 383, 1, 10 )
	RegCurTrigger( 3831 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 593 )
	TriggerAction( 1, AddNextFlag, 383, 11, 5 )
	RegCurTrigger( 3832 )
	InitTrigger()
	TriggerCondition( 1, IsMonster, 656 )
	TriggerAction( 1, AddNextFlag, 383, 16, 1 )
	RegCurTrigger( 3833 )

-----------------------------------过去
	MISSCRIPT_MISSIONSCRIPT02_LUA_000712 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000712")
	DefineMission( 556, MISSCRIPT_MISSIONSCRIPT02_LUA_000712, 384 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000713 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000713")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000713)
	MisBeginCondition(NoRecord, 384)
	MisBeginCondition(NoMission, 384)
	MisBeginCondition(HasRecord, 290)
 	MisBeginAction(AddMission, 384)
	MisBeginAction(AddTrigger, 3841, TE_GETITEM, 4234, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000714 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000714")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000714)
	MisNeed(MIS_NEED_ITEM, 4234, 1, 1, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000715 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000715")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000715)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000716 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000716")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000716)
	MisResultCondition(HasMission, 384)
	MisResultCondition(HasItem,4234,1)
	MisResultAction(TakeItem, 4234,1 )
 	MisResultAction(SetRecord, 384 )
	MisResultAction(ClearMission, 384 )
	MisResultAction(AddExpAndType,2,60000,60000)
	
	MisResultAction(GiveItem,3878,1,4)
	MisResultBagNeed(2)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4234 )
	TriggerAction( 1, AddNextFlag, 384, 1, 1 )
	RegCurTrigger( 3841 )

-----------------------------------过去
	MISSCRIPT_MISSIONSCRIPT02_LUA_000712 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000712")
	DefineMission( 557, MISSCRIPT_MISSIONSCRIPT02_LUA_000712, 384, COMPLETE_SHOW )

	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000717 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000717")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000717)
	MisResultCondition(NoRecord, 384)
	MisResultCondition(HasMission, 384)
	MisResultCondition(NoItem, 4234, 1)
	MisResultCondition(NoFlag, 384, 10)
	MisResultAction(SetFlag, 384, 10)

	
-----------------------------------------讨债
      MISSCRIPT_MISSIONSCRIPT02_LUA_000718 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000718")
      DefineMission(558,MISSCRIPT_MISSIONSCRIPT02_LUA_000718,386)

      MisBeginCondition(HasMission,380)
      MisBeginCondition(NoRecord,386)
      MisBeginCondition(NoMission,386)
 
      MISSCRIPT_MISSIONSCRIPT02_LUA_000719 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000719")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000719)
      MisBeginAction(AddMission,386)
      MisBeginAction(GiveItem,0948,1,4)
      MisBeginBagNeed(1)
      MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
      MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012) 

      MISSCRIPT_MISSIONSCRIPT02_LUA_000720 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000720")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000720) 
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000721 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000721")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000721)
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000722 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000722")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000722)
    
      MisResultCondition(NoRecord,386)
      MisResultCondition(HasFlag,386, 100)
      MisResultCondition(HasFlag ,386, 101)
      MisResultCondition(HasFlag,386, 102)
      MisResultCondition(HasRecord,389)
      MisResultCondition(HasRecord,391)
      MisResultCondition(HasRecord,400)
      MisResultCondition(HasRecord,393)
	  MisResultCondition(HasItem,0948,1)
      MisResultCondition(HasMoney,2000000)
      MisResultAction(TakeMoney,2000000)
      MisResultAction(TakeItem,0948,1)
      MisResultAction(GiveItem,0189,1,4)
      MisResultBagNeed(1)
      MisResultAction(ClearMission,380)
      MisResultAction(ClearMission, 386 )
      MisResultAction(SetRecord, 380 )
      MisResultAction(SetRecord,386)

      ----------------------------------讨债      (武鑫)
      MISSCRIPT_MISSIONSCRIPT02_LUA_000718 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000718")
      DefineMission(567,MISSCRIPT_MISSIONSCRIPT02_LUA_000718,386, COMPLETE_SHOW )
      
      MisBeginCondition( AlwaysFailure )
      MISSCRIPT_MISSIONSCRIPT02_LUA_000723 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000723")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000723)
      MisResultCondition(HasMission,386)
      MisResultCondition(HasItem,0948,1)
      MisResultCondition(NoRecord,386)
      MisResultCondition(NoFlag, 386, 100)
      MisResultAction(AddMoney,200000)
      MisResultAction(SetFlag, 386, 100)
     


      ------------------------------------讨债
       MISSCRIPT_MISSIONSCRIPT02_LUA_000718 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000718")
       DefineMission(568,MISSCRIPT_MISSIONSCRIPT02_LUA_000718,386, COMPLETE_SHOW )
      
      MisBeginCondition( AlwaysFailure )
      MISSCRIPT_MISSIONSCRIPT02_LUA_000724 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000724")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000724)
      MisResultCondition(HasMission,386)
      MisResultCondition(HasItem,0948,1)
      MisResultCondition(NoRecord,386)
      MisResultCondition(NoFlag,386,101)
      MisResultAction(AddMoney,100000)
      MisResultAction(SetFlag,386,101)
    


      ----------------------------------------龙女的债务
      MISSCRIPT_MISSIONSCRIPT02_LUA_000725 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000725")
      DefineMission(569,MISSCRIPT_MISSIONSCRIPT02_LUA_000725,389)

      MisBeginCondition(HasMission,386)
      MisBeginCondition(HasItem,0948,1)
      MisBeginCondition(NoRecord,389 )
      MisBeginCondition(NoMission,389 )
      MisBeginAction(AddMission,389)
      MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
      MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000726 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000726")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000726)
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000727 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000727")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000727)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000728 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000728")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000728)
       
     MisResultCondition(AlwaysFailure)

-------------------------------------------龙女的债务
     MISSCRIPT_MISSIONSCRIPT02_LUA_000729 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000729")
     DefineMission(570,MISSCRIPT_MISSIONSCRIPT02_LUA_000729,389, COMPLETE_SHOW)

     MisBeginCondition(AlwaysFailure)

     MISSCRIPT_MISSIONSCRIPT02_LUA_000730 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000730")
     MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000730)

     MisResultCondition(HasMission,389)
     MisResultCondition(NoRecord,389)
     MisResultCondition(HasMoney,200)
     MisResultAction(TakeMoney,200)
     MisResultAction(AddMoney,200000)
     MisResultAction(ClearMission, 389 )
     MisResultAction(SetRecord, 389 )
     


---------------------------------------------讨债
     MISSCRIPT_MISSIONSCRIPT02_LUA_000718 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000718")
     DefineMission(563,MISSCRIPT_MISSIONSCRIPT02_LUA_000718,386, COMPLETE_SHOW )
      
      MisBeginCondition( AlwaysFailure )
      MISSCRIPT_MISSIONSCRIPT02_LUA_000731 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000731")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000731)
      MisResultCondition(HasMission,386)
      MisResultCondition(HasItem,0948,1)
      MisResultCondition(NoRecord,386)
      MisResultCondition(NoFlag, 386, 102)
      MisResultAction(AddMoney,200000)
      MisResultAction(SetFlag, 386, 102)



     ---------------------------------------------杂货商人的债务
      MISSCRIPT_MISSIONSCRIPT02_LUA_000732 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000732")
      DefineMission(564,MISSCRIPT_MISSIONSCRIPT02_LUA_000732,391)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000733 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000733")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000733)
      MisBeginCondition(HasMission,386)
      MisBeginCondition(HasItem,0948,1)
      MisBeginCondition(NoRecord,391)
      MisBeginCondition(NoMission,391)
      MisBeginAction(AddMission,391)
   
      MisBeginAction(AddTrigger, 3911, TE_GETITEM, 0176, 3 )		--残缺的裹尸布
      MisBeginAction(AddTrigger, 3912, TE_GETITEM, 0177, 3 )		--破损的裹尸布
      MisBeginAction(AddTrigger, 3913, TE_GETITEM, 0178, 3 )		--完整的裹尸布
      MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
      MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000734 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000734")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000734)
      MisNeed(MIS_NEED_ITEM, 0176, 3, 10, 3)
      MisNeed(MIS_NEED_ITEM, 0177, 3, 20, 3)
      MisNeed(MIS_NEED_ITEM, 0178, 3, 30, 3)
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000735 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000735")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000735)  
      MISSCRIPT_MISSIONSCRIPT02_LUA_000736 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000736")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000736)
      MisResultCondition(HasMission, 391 )
      MisResultCondition(HasItem, 0176, 3 )
      MisResultCondition(HasItem, 0177, 3 )
      MisResultCondition(HasItem, 0178, 3 )
      MisResultAction(TakeItem, 0176, 3 )
      MisResultAction(TakeItem, 0177, 3 )
      MisResultAction(TakeItem, 0178, 3 )
      MisResultAction(AddMoney,420000)
      MisResultAction(ClearMission, 391 )
      MisResultAction(SetRecord, 391 )
      
      InitTrigger() 
   TriggerCondition( 1, IsItem, 0176 )	
   TriggerAction( 1, AddNextFlag, 391, 10, 3 )
    RegCurTrigger(3911)
    
      InitTrigger() 
   TriggerCondition( 1, IsItem, 0177 )	
   TriggerAction( 1, AddNextFlag, 391, 20, 3 )
    RegCurTrigger(3912) 
     
      InitTrigger() 
   TriggerCondition( 1, IsItem, 0178 )	
   TriggerAction( 1, AddNextFlag, 391, 30, 3 )
    RegCurTrigger(3913)

--------------------------------------------------------港口指挥·霜奇的债务
     MISSCRIPT_MISSIONSCRIPT02_LUA_000737 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000737")
     DefineMission(565,MISSCRIPT_MISSIONSCRIPT02_LUA_000737,392)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000738 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000738")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000738)
      MisBeginCondition(HasMission,386)
      MisBeginCondition(HasItem,0948,1)
      MisBeginCondition(NoRecord,392)
      MisBeginCondition(NoMission,392)
      MisBeginAction(AddMission,392)
      MisBeginAction(GiveItem,0949,1,4)
      MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
      MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
      MisBeginBagNeed(1)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000739 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000739")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000739)
      MISSCRIPT_MISSIONSCRIPT02_LUA_000740 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000740")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000740)
       
      MISSCRIPT_MISSIONSCRIPT02_LUA_000741 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000741")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000741 )
      MisResultCondition(HasRecord,392) 
      MisResultAction(AddMoney,420000)
      MisResultAction(ClearMission,392 )
      MisResultAction(SetRecord,400)

  -------------------------------------------------------港口指挥·霜奇的债务

  MISSCRIPT_MISSIONSCRIPT02_LUA_000737 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000737")
  DefineMission(566,MISSCRIPT_MISSIONSCRIPT02_LUA_000737,392, COMPLETE_SHOW )

      MisBeginCondition( AlwaysFailure )
      MISSCRIPT_MISSIONSCRIPT02_LUA_000742 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000742")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000742)
      MisResultCondition(HasMission,392)
      MisResultCondition(NoRecord,392)
      MisResultCondition(HasItem,0949,1)
      MisResultAction(TakeItem,0949,1)
      MisResultAction(SetRecord,392)
      
       

   -----------------------------------------------------贸易商人·油李的债务

      MISSCRIPT_MISSIONSCRIPT02_LUA_000743 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000743")
      DefineMission(572,MISSCRIPT_MISSIONSCRIPT02_LUA_000743,393)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000744 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000744")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000744)

      MisBeginCondition(HasMission,386)
      MisBeginCondition(HasItem,0948,1)
      MisBeginCondition(NoRecord,393)
      MisBeginCondition(NoMission,393)
      MisBeginAction(AddMission,393)
   
      MisBeginAction(AddTrigger, 3931, TE_GETITEM, 1864, 5 )		 
      MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
      MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000745 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000745")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000745)
      MisNeed(MIS_NEED_ITEM, 1864, 5, 10, 5)
      
      
      MISSCRIPT_MISSIONSCRIPT02_LUA_000746 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000746")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000746)  
      MISSCRIPT_MISSIONSCRIPT02_LUA_000747 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000747")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000747)
      MisResultCondition(HasMission, 393 )
      MisResultCondition(HasItem, 1864, 5 )
      MisResultAction(TakeItem, 1864, 5 )
      MisResultAction(AddMoney,420000)
      MisResultAction(ClearMission, 393 )
      MisResultAction(SetRecord, 393)

	  InitTrigger() 
   TriggerCondition( 1, IsItem, 1864 )	
   TriggerAction( 1, AddNextFlag, 393, 10, 5 )
    RegCurTrigger(3931)

--------------------------------------------罗森
     MISSCRIPT_MISSIONSCRIPT02_LUA_000698 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000698")
     DefineMission(571,MISSCRIPT_MISSIONSCRIPT02_LUA_000698,394)
     MISSCRIPT_MISSIONSCRIPT02_LUA_000748 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000748")
     MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000748)
     MisBeginCondition(HasRecord,386)
      MisBeginCondition(NoMission, 394)
     MisBeginCondition(NoRecord, 394)
     MisBeginAction(AddMission, 394)
     MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
     MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

     MISSCRIPT_MISSIONSCRIPT02_LUA_000749 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000749")
     MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000749)
     MISSCRIPT_MISSIONSCRIPT02_LUA_000750 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000750")
     MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000750)
      MISSCRIPT_MISSIONSCRIPT02_LUA_000751 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000751")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000751)
     MisResultCondition(NoRecord, 394)
     MisResultCondition(HasMission, 394)
     MisResultAction(SetRecord, 394 )
     MisResultAction(ClearMission, 394 )

----------------------------------------追忆
	 MISSCRIPT_MISSIONSCRIPT02_LUA_000752 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000752")
	 DefineMission(592,MISSCRIPT_MISSIONSCRIPT02_LUA_000752,395)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000753 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000753")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000753 )
	MisBeginCondition(NoRecord, 395)
	MisBeginCondition(NoMission, 395)
	MisBeginCondition(HasRecord,394)
	MisBeginAction(AddMission,395)
	MisBeginAction(GiveItem, 1051, 1, 4)	----------------莫邪项链	
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000754 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000754")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000754)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000755 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000755")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000755)
	MisResultCondition(AlwaysFailure)	
-----------------------------------------追忆
	MISSCRIPT_MISSIONSCRIPT02_LUA_000752 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000752")
	DefineMission(593, MISSCRIPT_MISSIONSCRIPT02_LUA_000752, 395, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000756 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000756")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000756)
	MisResultCondition(NoRecord, 395)
	MisResultCondition(HasMission,395)
	MisResultAction(ClearMission,395)
	MisResultAction(SetRecord, 395)
       -----------------------------------------------------达赫的恶梦
	MISSCRIPT_MISSIONSCRIPT02_LUA_000757 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000757")
	DefineMission(594,MISSCRIPT_MISSIONSCRIPT02_LUA_000757,396)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000758 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000758")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000758 )
	MisBeginCondition(NoRecord, 396)
	MisBeginCondition(NoMission, 396)
	MisBeginCondition(HasRecord,395)
	MisBeginAction(AddMission,396)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000759 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000759")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000759)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000760 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000760")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000760)
	MisResultCondition(AlwaysFailure)
----------------------------------------------------达赫的恶梦
	MISSCRIPT_MISSIONSCRIPT02_LUA_000757 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000757")
	DefineMission(5065,MISSCRIPT_MISSIONSCRIPT02_LUA_000757,396)

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000761 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000761")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000761)
	MisResultCondition(NoRecord, 396)
	MisResultCondition(HasMission,396)
	MisResultAction(ClearMission,396)
	MisResultAction(SetRecord, 396)
	

---------------------------------------------------------------狐道士作怪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000762 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000762")
	DefineMission(595,MISSCRIPT_MISSIONSCRIPT02_LUA_000762,397)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000763 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000763")
      MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000763)

      MisBeginCondition(HasRecord,396)
      MisBeginCondition(NoRecord,397)
      MisBeginCondition(NoMission,397)
      MisBeginCondition(HasItem,1051,1)----------莫邪项链
      MisBeginAction(TakeItem,1051,1)
      MisBeginAction(AddMission,397)
      MisBeginAction(AddTrigger, 3971, TE_KILL, 748, 10)
   
      MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
      MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
      MISSCRIPT_MISSIONSCRIPT02_LUA_000764 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000764")
      MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000764)
      MisNeed(MIS_NEED_KILL, 748, 10, 10, 10)

      MISSCRIPT_MISSIONSCRIPT02_LUA_000765 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000765")
      MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000765)  
      MISSCRIPT_MISSIONSCRIPT02_LUA_000766 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000766")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000766)
      MisResultCondition(HasMission, 397 )
      MisResultCondition(HasFlag, 397, 19)
      MisResultAction(AddMoney,100000)
      MisResultAction(ClearMission, 397 )
      MisResultAction(SetRecord, 397)

      InitTrigger()
      TriggerCondition( 1, IsMonster, 748 )
      TriggerAction( 1, AddNextFlag, 397, 10, 10 )
      RegCurTrigger( 3971 )
-------------------------------------------------------为达赫解梦
	MISSCRIPT_MISSIONSCRIPT02_LUA_000767 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000767")
	DefineMission(5066,MISSCRIPT_MISSIONSCRIPT02_LUA_000767,992)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000768 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000768")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000768 )
	
	MisBeginCondition(HasRecord,397)
	MisBeginCondition(NoRecord, 992)
	MisBeginCondition(NoMission, 992)
	MisBeginAction(AddMission,992)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000769 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000769")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000769)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000770 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000770")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000770)
	MisResultCondition(AlwaysFailure)
----------------------------------------------------为达赫解梦
	MISSCRIPT_MISSIONSCRIPT02_LUA_000767 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000767")
	DefineMission(5067,MISSCRIPT_MISSIONSCRIPT02_LUA_000767,992)

	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000771 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000771")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000771)

	MisResultCondition(HasMission,992)
	MisResultCondition(NoRecord, 992)
	MisResultAction(ClearMission,992)
	MisResultAction(SetRecord, 992)
	MisResultAction(AddMoney,20000)

	------------------------------------------------------------布丽娜的恶梦
       MISSCRIPT_MISSIONSCRIPT02_LUA_000772 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000772")
       DefineMission(596,MISSCRIPT_MISSIONSCRIPT02_LUA_000772,398)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000773 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000773")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000773 )
	MisBeginCondition(NoRecord, 398)
	MisBeginCondition(NoMission, 398)
	MisBeginCondition(HasRecord,992)
	MisBeginAction(AddMission,398)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000774 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000774")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000774)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000775 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000775")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000775)
	MisResultCondition(AlwaysFailure)
	----------------------------------------------布丽娜的恶梦
	 MISSCRIPT_MISSIONSCRIPT02_LUA_000772 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000772")
	 DefineMission(597,MISSCRIPT_MISSIONSCRIPT02_LUA_000772,398)
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000776 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000776")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000776)
	MisResultCondition(NoRecord, 398)
	MisResultCondition(HasMission,398)
	MisResultAction(ClearMission,398)
	MisResultAction(SetRecord, 398)	
	------------------------------------------------解救布丽娜
	 MISSCRIPT_MISSIONSCRIPT02_LUA_000777 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000777")
	 DefineMission(598,MISSCRIPT_MISSIONSCRIPT02_LUA_000777,399)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000778 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000778")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000778 )
	MisBeginCondition(NoRecord, 399)
	MisBeginCondition(NoMission, 399)
	MisBeginCondition(HasRecord,398)
	MisBeginAction(AddMission,399)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000779 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000779")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000779)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000760 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000760")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000760)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000780 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000780")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000780)
	MisResultCondition(NoRecord, 399)
	MisResultCondition(HasMission,399)
	MisResultCondition(HasRecord,950)
	MisResultAction(ClearMission,399)
	MisResultAction(SetRecord, 399)

	--------------------------------------------------------灵异水晶球
	MISSCRIPT_MISSIONSCRIPT02_LUA_000781 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000781")
	DefineMission( 599, MISSCRIPT_MISSIONSCRIPT02_LUA_000781, 996 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000782 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000782")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000782 )------------++++++
	MisBeginCondition(NoRecord, 399)
	MisBeginCondition(NoRecord, 996)
	MisBeginCondition(NoMission, 996)
	MisBeginCondition(HasMission,399)
	MisBeginAction(AddMission, 996)
	MisBeginAction(AddTrigger, 9961, TE_GETITEM, 3366,2 )		--蓝色水晶
	MisBeginAction(AddTrigger, 9962, TE_GETITEM, 1635, 3 )		--水晶纯石
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

        MISSCRIPT_MISSIONSCRIPT02_LUA_000783 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000783")
        MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000783)
	MisNeed(MIS_NEED_ITEM, 3366,2, 10, 2)
	MisNeed(MIS_NEED_ITEM, 1635, 3, 20, 3)


	MISSCRIPT_MISSIONSCRIPT02_LUA_000784 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000784")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000784)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000785 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000785")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000785)
	MisResultCondition(HasMission, 996)
	MisResultCondition(HasItem, 3366, 2 )
	MisResultCondition(HasItem, 1635, 3 )
	
	MisResultAction(TakeItem, 3366, 2 )
	MisResultAction(TakeItem, 1635, 3 )
	
	MisResultAction(ClearMission, 996)
	MisResultAction(SetRecord, 996 )---------------------set996
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	


	InitTrigger()
	TriggerCondition( 1, IsItem,3366)	
	TriggerAction( 1, AddNextFlag, 996, 10, 2 )
	RegCurTrigger( 9961 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1635)	
	TriggerAction( 1, AddNextFlag, 996, 20, 3 )
	RegCurTrigger(9962 )

	----------------------------------------------------------------------------狐妖作怪
	MISSCRIPT_MISSIONSCRIPT02_LUA_000786 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000786")
	DefineMission( 5000, MISSCRIPT_MISSIONSCRIPT02_LUA_000786, 950 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000787 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000787")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000787 )
	MisBeginCondition(NoRecord, 950)
	MisBeginCondition(NoRecord, 399)
	MisBeginCondition(NoMission, 950)
	MisBeginCondition(HasRecord,996)-----------------
	MisBeginAction(AddMission,  950)
	MisBeginAction(AddTrigger,  9501, TE_KILL,761, 5 )	----------狐妖
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000788 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000788")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000788)
	MisNeed(MIS_NEED_KILL,761,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000789 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000789")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000789)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000790 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000790")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000790)
	MisResultCondition(HasMission,  950 )
	MisResultCondition(NoRecord,  950)
	MisResultCondition(HasFlag,  950, 14 )
	MisResultAction(ClearMission, 950 )
	MisResultAction(SetRecord,  950  )
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddMoney,800000,800000)	
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 761)	
	TriggerAction( 1, AddNextFlag,   950 , 10,5)
	RegCurTrigger(   9501 )

---------------------------------------------------------------------狐仙作怪

	MISSCRIPT_MISSIONSCRIPT02_LUA_000791 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000791")
	DefineMission( 5001, MISSCRIPT_MISSIONSCRIPT02_LUA_000791, 951 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000792 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000792")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000792 )--------++++++0
	MisBeginCondition(NoRecord, 951 )
	MisBeginCondition(HasRecord, 399)
	MisBeginCondition(NoMission, 951 )
	MisBeginAction(AddMission,  951)
	MisBeginAction(AddTrigger,  9511, TE_KILL, 776, 1 )----------------狐仙
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000793 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000793")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000793)
	MisNeed(MIS_NEED_KILL,776,1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000794 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000794")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000794)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000795 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000795")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000795)
	MisResultCondition(HasMission,  951)
	MisResultCondition(NoRecord,  951)
	MisResultCondition(HasFlag,  951, 10 )
	MisResultAction(ClearMission,  951 )
	MisResultAction(SetRecord,  951  )
	MisResultAction(AddExp,2500000,2500000)
	MisResultAction(AddMoney,800000,800000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 776)	
	TriggerAction( 1, AddNextFlag,  951 , 10,1)
	RegCurTrigger(   9511 )

-----------------------------------------------------------------------重大秘密

	MISSCRIPT_MISSIONSCRIPT02_LUA_000796 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000796")
	DefineMission( 5002, MISSCRIPT_MISSIONSCRIPT02_LUA_000796,952 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000797 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000797")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000797 )
	MisBeginCondition(NoRecord,952 )
	MisBeginCondition(HasRecord, 951)
	MisBeginCondition(NoMission,952 )
	MisBeginAction(AddMission, 952)
	MisBeginAction(AddTrigger,9521, TE_KILL, 621, 1 )		----迅捷的暴风水母
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	 MISSCRIPT_MISSIONSCRIPT02_LUA_000798 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000798")
	 MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000798)----------++++1
	MisNeed(MIS_NEED_KILL,621,1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000799 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000799")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000799)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000800 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000800")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000800)
	MisResultCondition(HasMission,952 )
	MisResultCondition(HasFlag, 952, 10 )
	MisResultAction(ClearMission, 952 )
	MisResultAction(SetRecord,952 )
	MisResultAction(AddMoney,800000,800000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 621)	
	TriggerAction( 1, AddNextFlag,  952 , 10,1)
	RegCurTrigger( 9521 )
------------------------------------------------------------------罗森精神

	MISSCRIPT_MISSIONSCRIPT02_LUA_000801 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000801")
	DefineMission( 5003, MISSCRIPT_MISSIONSCRIPT02_LUA_000801, 953)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000802 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000802")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000802)
	MisBeginCondition(NoRecord, 953 )
	MisBeginCondition(HasRecord, 952)
	MisBeginCondition(NoMission, 953 )
	MisBeginAction(AddMission, 953 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000803 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000803")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000803)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000804 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000804")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000804)
	MisResultCondition(AlwaysFailure )

	---------------------------------------罗森精神

	MISSCRIPT_MISSIONSCRIPT02_LUA_000801 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000801")
	DefineMission(5004,MISSCRIPT_MISSIONSCRIPT02_LUA_000801,953,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000805 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000805")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000805)
	MisResultCondition(HasMission, 953)
	MisResultCondition(NoRecord, 953)
	MisResultAction(ClearMission, 953)
	MisResultAction(SetRecord, 953)

-----------------------------------------------------治疗裴蒂

	MISSCRIPT_MISSIONSCRIPT02_LUA_000806 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000806")
	DefineMission( 5005, MISSCRIPT_MISSIONSCRIPT02_LUA_000806, 954 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000807 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000807")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000807 )
	MisBeginCondition(NoRecord, 954)
	MisBeginCondition(HasRecord,  953)
	MisBeginCondition(NoMission, 954)
	MisBeginAction(AddMission,  954)
	MisBeginAction(AddTrigger,  9541, TE_GETITEM,  0376,1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	 MISSCRIPT_MISSIONSCRIPT02_LUA_000808 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000808")
	 MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000808)
	MisNeed(MIS_NEED_ITEM,  0376,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000809 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000809")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000809)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000810 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000810")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000810)-------------------+++++2
	MisResultCondition(HasMission,  954)
	MisResultCondition(NoRecord, 954)
	MisResultCondition(HasItem, 0376, 1 )
	MisResultAction(TakeItem,  0376, 1 )
	MisResultAction(ClearMission,  954)
	MisResultAction(SetRecord,  954 )
	MisResultAction(AddExp,1000000,1000000)
	MisResultAction(AddMoney,800000,800000)	
	

	InitTrigger()
	TriggerCondition( 1, IsItem,0376)	
	TriggerAction( 1, AddNextFlag,954, 10, 1 )
	RegCurTrigger( 9541 )

------------------------------------------------------------------魔力骨头粉

	MISSCRIPT_MISSIONSCRIPT02_LUA_000811 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000811")
	DefineMission( 5006, MISSCRIPT_MISSIONSCRIPT02_LUA_000811, 955 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000812 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000812")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000812 )
	MisBeginCondition(NoRecord,  955)
	MisBeginCondition(HasRecord,  954)
	MisBeginCondition(NoMission, 955)
	MisBeginAction(AddMission,  955)
	MisBeginAction(AddTrigger,  9551, TE_GETITEM,  1626,3 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	 MISSCRIPT_MISSIONSCRIPT02_LUA_000813 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000813")
	 MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000813)
	MisNeed(MIS_NEED_ITEM,  1626,3, 10, 3)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000814 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000814")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000814)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000815 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000815")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000815)--------------------++++++3
	MisResultCondition(HasMission,  955)
	MisResultCondition(NoRecord, 955)
	MisResultCondition(HasItem, 1626, 3 )
	MisResultAction(TakeItem,  1626, 3 )
	MisResultAction(ClearMission,  955)
	MisResultAction(SetRecord,  955 )
	MisResultAction(AddExp,200000,200000)
	MisResultAction(AddMoney,700000,700000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsItem,1626)	
	TriggerAction( 1, AddNextFlag, 955, 10, 3 )
	RegCurTrigger( 9551 )
------------------------------------------------------------------------高级营养品

	MISSCRIPT_MISSIONSCRIPT02_LUA_000816 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000816")
	DefineMission( 5007, MISSCRIPT_MISSIONSCRIPT02_LUA_000816, 956)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000817 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000817")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000817 )
	MisBeginCondition(NoRecord,  956)
	MisBeginCondition(HasRecord,  955)
	MisBeginCondition(NoMission, 956)
	MisBeginAction(AddMission,  956)
	MisBeginAction(AddTrigger,  9561, TE_GETITEM,  4783,1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000818 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000818")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000818)
	MisNeed(MIS_NEED_ITEM,  4783,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000819 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000819")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000819)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000820 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000820")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000820)
	MisResultCondition(HasMission,  956)
	MisResultCondition(NoRecord, 956)
	MisResultCondition(HasItem, 4783, 1)
	MisResultAction(TakeItem,  4783, 1 )
	MisResultAction(ClearMission,  956)
	MisResultAction(SetRecord,  956)
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,100000,100000)	
	

	InitTrigger()
	TriggerCondition( 1, IsItem,4783)	
	TriggerAction( 1, AddNextFlag, 956, 10, 1 )
	RegCurTrigger( 9561 )
---------------------------------------------------------------------------遗忘的过去
	 MISSCRIPT_MISSIONSCRIPT02_LUA_000821 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000821")
	 DefineMission(5008,MISSCRIPT_MISSIONSCRIPT02_LUA_000821,957)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000822 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000822")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000822 )
	MisBeginCondition(NoRecord, 957)
	MisBeginCondition(NoMission, 957)
	MisBeginCondition(HasRecord,956)
	MisBeginAction(AddMission,957)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000823 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000823")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000823)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000824 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000824")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000824)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000825 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000825")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000825)
	MisResultCondition(NoRecord, 957)
	MisResultCondition(HasMission, 957)
	MisResultCondition(HasRecord, 999)---
	MisResultAction(ClearMission, 957)
	MisResultAction(SetRecord,  957 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)


------------------------------------------------------------------------克隆之回魂汤(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000826 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000826")
	DefineMission(5009,MISSCRIPT_MISSIONSCRIPT02_LUA_000826,958)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000827 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000827")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000827 )
	MisBeginCondition(NoRecord, 958)
	MisBeginCondition(NoMission, 958)
	MisBeginCondition(HasMission, 957)
	MisBeginCondition(NoRecord,957)
	MisBeginCondition(IsChaType,1)
	MisBeginAction(AddMission,958)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000828 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000828")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000828)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000829 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000829")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000829)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000830 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000830")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000830)
	
	MisResultCondition(NoRecord, 958)
	MisResultCondition(HasRecord, 962)
	MisResultCondition(HasMission, 958)
	MisResultCondition(HasItem, 1043, 1 )--------回魂汤
	MisResultAction(TakeItem,  1043, 1 )
	MisResultAction(ClearMission, 958)
	MisResultAction(SetRecord,  958 )
	MisResultAction(SetRecord,  999 )------
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddMoney,600000,600000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	
---------------------------------------------------------------------------血石(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000831 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000831")
	DefineMission(5010,MISSCRIPT_MISSIONSCRIPT02_LUA_000831,959)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000832 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000832")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000832 )
	MisBeginCondition(NoRecord, 959)
	MisBeginCondition(NoMission, 959)
	MisBeginCondition(HasMission, 958)
	MisBeginCondition(NoRecord,958)
	MisBeginAction(AddMission,959)

	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000833 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000833")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000833)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000834 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000834")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000834)
	

	MISSCRIPT_MISSIONSCRIPT02_LUA_000835 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000835")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000835)
	MisResultCondition(NoRecord, 959)
	MisResultCondition(HasMission, 959)
	MisResultCondition(HasRecord, 960)
	MisResultCondition(HasItem, 1040, 1)
	MisResultAction(TakeItem, 1040, 1 )
	MisResultAction(ClearMission, 959)
	MisResultAction(SetRecord,  959 )

	
---------------------------------------------------------------------------邀请函(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000836 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000836")
	DefineMission( 5011, MISSCRIPT_MISSIONSCRIPT02_LUA_000836, 960 )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000837 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000837")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000837 )
	MisBeginCondition(NoRecord, 960)
	MisBeginCondition(HasMission, 959)
	MisBeginCondition(NoMission,960)
	MisBeginCondition(NoRecord,959)
	MisBeginAction(AddMission, 960)
	MisBeginAction(GiveItem, 1041, 1, 4)	----------邀请函	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000838 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000838")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000838)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000839 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000839")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000839)
	MisResultCondition(AlwaysFailure)
	
-----------------------------------------------------------------------邀请函(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000836 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000836")
	DefineMission(5012,MISSCRIPT_MISSIONSCRIPT02_LUA_000836,960,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000840 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000840")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000840)
	MisResultCondition(NoRecord, 960)
	MisResultCondition(HasMission, 960)
	MisResultCondition(HasItem, 1041, 1)
	MisResultAction(TakeItem, 1041, 1 )
	MisResultAction(GiveItem, 1040, 1,4)--------------血石
	MisResultAction(ClearMission, 960 )
	MisResultAction(SetRecord,  960 )
	MisResultBagNeed(1)

	-----------------------------------------------------------------回魂汤药方(1) 
	MISSCRIPT_MISSIONSCRIPT02_LUA_000841 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000841")
	DefineMission(5014, MISSCRIPT_MISSIONSCRIPT02_LUA_000841, 961 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000842 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000842")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000842 )
	MisBeginCondition(NoRecord, 961)
	MisBeginCondition(HasRecord, 959)
	MisBeginCondition(NoMission, 961)
	MisBeginAction(AddMission, 961)
	MisBeginAction(AddTrigger, 9611, TE_GETITEM, 1234,10)		
	MisBeginAction(AddTrigger, 9612, TE_GETITEM, 1260, 1 )
	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	 MISSCRIPT_MISSIONSCRIPT02_LUA_000843 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000843")
	 MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000843)
	MisNeed(MIS_NEED_ITEM, 1234,10, 10,10)
	MisNeed(MIS_NEED_ITEM, 1260, 1, 20, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000844 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000844")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000844)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000845 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000845")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000845)
	MisResultCondition(HasMission,961)
	MisResultCondition(NoRecord, 961)
	MisResultCondition(HasItem, 1234, 10 )
	MisResultCondition(HasItem, 1260, 1 )
	
	MisResultAction(TakeItem, 1234, 10 )
	MisResultAction(TakeItem, 1260, 1 )
	
	MisResultAction(ClearMission, 961)
	MisResultAction(SetRecord, 961 )
	MisResultAction(GiveItem, 1043, 1, 4)-------回魂汤
	MisResultAction(AddExp,800000,800000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem,1234)	
	TriggerAction( 1, AddNextFlag, 961, 10, 10 )
	RegCurTrigger(9611 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 1260)	
	TriggerAction( 1, AddNextFlag, 961, 20, 1 )
	RegCurTrigger(9612 )
	
	
------------------------------------------------------降温黑珍珠(1) 

	MISSCRIPT_MISSIONSCRIPT02_LUA_000846 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000846")
	DefineMission( 5015, MISSCRIPT_MISSIONSCRIPT02_LUA_000846, 962 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000847 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000847")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000847 )
	MisBeginCondition(NoRecord,  962)
	MisBeginCondition(HasRecord,  961)
	MisBeginCondition(NoMission,962)
	MisBeginAction(AddMission,  962)
	MisBeginAction(AddTrigger,  9621, TE_GETITEM,  3362,1)--------黑珍珠		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000848 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000848")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000848)
	MisNeed(MIS_NEED_ITEM,  3362,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000849 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000849")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000849)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000850 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000850")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000850)-------------------++++++++4
	MisResultCondition(HasMission,  962)
	MisResultCondition(NoRecord,962)
	MisResultCondition(HasItem, 3362, 1 )
	MisResultAction(TakeItem,  3362, 1 )
	MisResultAction(ClearMission,  962)
	MisResultAction(SetRecord,  962)
	MisResultAction(AddExp,500000,500000)
	MisResultAction(AddMoney,200000,200000)

	InitTrigger()
	TriggerCondition( 1, IsItem,3362)	
	TriggerAction( 1, AddNextFlag, 962, 10, 1 )
	RegCurTrigger( 9621 )



------------------------------------------------------------------女神的基因之健忆胶囊(2)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000851 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000851")
	DefineMission(5017,MISSCRIPT_MISSIONSCRIPT02_LUA_000851,963)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000852 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000852")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000852 )
	MisBeginCondition(NoRecord, 963)
	MisBeginCondition(NoMission, 963)
	MisBeginCondition(HasMission, 957)
	MisBeginCondition(NoRecord, 957)
	MisBeginCondition(IsChaType,3)----菲利尔
	MisBeginAction(AddMission,963)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000853 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000853")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000853)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000854 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000854")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000854)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000855 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000855")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000855) 
	MisResultCondition(NoRecord, 963)
	MisResultCondition(HasMission, 963)
	MisResultCondition(HasRecord, 967)
	MisResultCondition(HasItem,  1050, 1 )-------健忆胶囊
	MisResultAction(TakeItem,  1050,1 )
	MisResultAction(ClearMission, 963)
	MisResultAction(SetRecord,  963 )
	MisResultAction(SetRecord,  999 )------
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddMoney,600000,600000)	
	MisResultAction(AddExpAndType,2,60000,60000)

--------------------------------------------------------------------泪之琥珀(2)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000856 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000856")
	DefineMission(5018,MISSCRIPT_MISSIONSCRIPT02_LUA_000856,964)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000857 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000857")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000857 )
	MisBeginCondition(NoRecord, 964)
	MisBeginCondition(NoMission, 964)
	MisBeginCondition(HasMission, 963)
	MisBeginCondition(NoRecord,963)
	MisBeginAction(AddMission,964)
	MisBeginAction(GiveItem, 2303, 1, 4)---------+++++????
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000858 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000858")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000858)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000859 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000859")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000859)
	
	MisResultCondition(AlwaysFailure)
	----------------------------------------------------------------------泪之琥珀(2)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000860 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000860")
	DefineMission(5019,MISSCRIPT_MISSIONSCRIPT02_LUA_000860,964,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000861 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000861")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000861)
	MisResultCondition(NoRecord, 964)
	MisResultCondition(HasMission, 964)
	MisResultCondition(HasItem,2303, 1)-------------++++++???
	MisResultAction(TakeItem, 2303, 1 )-------------++++++????
	MisResultAction(ClearMission,964)
	MisResultAction(SetRecord,  964)
	MisResultAction(AddMoney,80000,80000)	
		
	

---------------------------------------------------------------补钙(２)


	MISSCRIPT_MISSIONSCRIPT02_LUA_000862 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000862")
	DefineMission( 5020, MISSCRIPT_MISSIONSCRIPT02_LUA_000862, 965)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000863 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000863")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000863 )--------------+++++5
	MisBeginCondition(NoRecord,  965)
	MisBeginCondition(HasRecord,  964)
	MisBeginCondition(NoMission,965)
	MisBeginAction(AddMission,  965)
	MisBeginAction(AddTrigger,  9651, TE_GETITEM,  1296,1)	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000864 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000864")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000864)
	MisNeed(MIS_NEED_ITEM,  1296,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000865 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000865")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000865)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000866 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000866")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000866)
	MisResultCondition(HasMission,965)
	MisResultCondition(NoRecord, 965)
	MisResultCondition(HasItem, 1296, 1 )
	MisResultAction(TakeItem,  1296, 1)
	MisResultAction(ClearMission,  965)
	MisResultAction(SetRecord,  965)
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsItem,1296)	
	TriggerAction( 1, AddNextFlag,965, 10, 1 )
	RegCurTrigger( 9651 )

--------------------------------------------------复活叶(２)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000867 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000867")
	DefineMission(5021, MISSCRIPT_MISSIONSCRIPT02_LUA_000867, 966 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000868 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000868")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000868  )
	MisBeginCondition(NoRecord,  966 )
	MisBeginCondition(HasRecord,  965)
	MisBeginCondition(NoMission, 966 )
	MisBeginAction(AddMission,  966 )
	MisBeginAction(AddTrigger,  9661, TE_GETITEM,  3143,1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

        MISSCRIPT_MISSIONSCRIPT02_LUA_000869 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000869")
        MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000869)
	MisNeed(MIS_NEED_ITEM,  3143,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000870 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000870")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000870)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000871 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000871")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000871)-----------------------++++++++6
	MisResultCondition(HasMission,  966 )
	MisResultCondition(NoRecord, 966 )
	MisResultCondition(HasItem, 3143, 1 )
	MisResultAction(TakeItem,  3143,1 )
	MisResultAction(ClearMission,  966 )
	MisResultAction(SetRecord, 966 )
	MisResultAction(AddExp,800000,800000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsItem,3143)	
	TriggerAction( 1, AddNextFlag, 966 , 10, 1 )
	RegCurTrigger( 9661 )

--------------------------------------------------------------------------------------副作用(2)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000872 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000872")
	DefineMission( 5022, MISSCRIPT_MISSIONSCRIPT02_LUA_000872, 967 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000873 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000873")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000873 )------------------++++++++7
	MisBeginCondition(NoRecord,  967)
	MisBeginCondition(HasRecord,  966 )
	MisBeginCondition(NoMission, 967)
	MisBeginAction(AddMission,  967)
	MisBeginAction(AddTrigger,  9671, TE_GETITEM,  1351,1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000874 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000874")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000874)
	MisNeed(MIS_NEED_ITEM,  1351,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000875 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000875")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000875)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000876 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000876")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000876)
	MisResultCondition(HasMission, 967)
	MisResultCondition(NoRecord, 967)
	MisResultCondition(HasItem, 1351, 1 )
	MisResultAction(TakeItem,  1351,1 )
	MisResultAction(ClearMission, 967)
	MisResultAction(SetRecord,  967)
	MisResultAction(GiveItem, 1050, 1, 4)-------健忆胶囊
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem,1351)	
	TriggerAction( 1, AddNextFlag, 967, 10, 1 )
	RegCurTrigger( 9671 )


		
	
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------混血儿之美丽过往(3) 
	MISSCRIPT_MISSIONSCRIPT02_LUA_000877 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000877")
	DefineMission(5024,MISSCRIPT_MISSIONSCRIPT02_LUA_000877,968)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000878 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000878")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000878 )
	MisBeginCondition(NoRecord, 968)
	MisBeginCondition(NoMission, 968)
	MisBeginCondition(HasMission, 957)
	MisBeginCondition(NoRecord,957)
	MisBeginCondition(IsChaType,2)
	MisBeginAction(AddMission,968)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000879 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000879")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000879)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000880 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000880")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000880)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000881 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000881")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000881) 
	MisResultCondition(NoRecord, 968)
	MisResultCondition(HasMission, 968)
	MisResultCondition(HasRecord, 972)
	MisResultCondition(HasItem, 1042, 1 )
	MisResultAction(TakeItem, 1042, 1 )
	MisResultAction(ClearMission, 968)
	MisResultAction(SetRecord,  968 )
	MisResultAction(SetRecord,  999 )------
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddMoney,800000,800000)	
	MisResultAction(AddExpAndType,2,60000,60000)
---------------------------------------------------烧过的蜡烛(3)
	HELP_MONSTERHELP_LUA_001316 = GetResString("HELP_MONSTERHELP_LUA_001316")
	DefineMission(5025, HELP_MONSTERHELP_LUA_001316, 969 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000882 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000882")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000882 )------------------++++++8
	MisBeginCondition(NoRecord,  969)
	MisBeginCondition(HasMission, 968)
	MisBeginCondition(NoRecord,  968)
	MisBeginCondition(NoMission, 969)
	MisBeginAction(AddMission,  969)
	MisBeginAction(AddTrigger,  9691, TE_GETITEM,  4823,1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000883 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000883")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000883)
	MisNeed(MIS_NEED_ITEM,  4823,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000884 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000884")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000884)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000885 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000885")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000885)
	MisResultCondition(HasMission, 969)
	MisResultCondition(NoRecord, 969)
	MisResultCondition(HasItem, 4823, 1 )
	MisResultAction(TakeItem,  4823,1)
	MisResultAction(ClearMission,  969)
	MisResultAction(SetRecord,  969)
	MisResultAction(AddExp,80000,80000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsItem,4823)	
	TriggerAction( 1, AddNextFlag, 969, 10, 1 )
	RegCurTrigger( 9691 )

---------------------------------------------------------复原往事(3)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000886 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000886")
	DefineMission(5026,MISSCRIPT_MISSIONSCRIPT02_LUA_000886,970)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000887 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000887")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000887 )
	MisBeginCondition(NoRecord, 970)
	MisBeginCondition(NoMission, 970)
	MisBeginCondition(HasRecord, 969)
	MisBeginAction(AddMission,970)
	MisBeginAction(AddTrigger,  9701, TE_GETITEM,  1042,1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000888 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000888")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000888)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000889 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000889")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000889)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000890 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000890")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000890)
	MisResultCondition(HasMission,970)
	MisResultCondition(NoRecord, 970)
	MisResultCondition(HasRecord, 971)
	MisResultCondition(HasItem,1042, 1 )----------复原剂
	MisResultAction(TakeItem, 1042, 1 )
	MisResultAction(ClearMission, 970)
	MisResultAction(SetRecord, 970)
	MisResultAction(GiveItem, 1042, 1, 4)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem,1042)	
	TriggerAction( 1, AddNextFlag, 970, 10, 1 )
	RegCurTrigger(9701 )

	--------------------------------------------------复原剂原料(3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000891 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000891")
	DefineMission( 5027, MISSCRIPT_MISSIONSCRIPT02_LUA_000891, 971 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000892 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000892")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000892 )-------------++++++9
	MisBeginCondition(NoRecord, 971 )
	MisBeginCondition(HasMission, 970)
	MisBeginCondition(NoRecord, 970)
	MisBeginCondition(NoMission, 971)
	MisBeginAction(AddMission, 971 )
	MisBeginAction(AddTrigger, 9711, TE_GETITEM, 1351,1)		
	MisBeginAction(AddTrigger, 9712, TE_GETITEM, 3134, 3 )
	MisBeginAction(AddTrigger, 9713, TE_GETITEM, 3147, 3 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000893 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000893")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000893)
	MisNeed(MIS_NEED_ITEM, 1351,1, 10,1)
	MisNeed(MIS_NEED_ITEM, 3134, 3, 20, 3)
	MisNeed(MIS_NEED_ITEM,  3147,3, 30, 3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000894 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000894")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000894)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000895 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000895")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000895)
	MisResultCondition(HasMission, 971)
	MisResultCondition(NoRecord, 971)
	MisResultCondition(HasItem, 1351, 1 )
	MisResultCondition(HasItem, 3134, 3 )
	MisResultCondition(HasItem,  3147, 3)
	
	MisResultAction(TakeItem, 1351, 1 )
	MisResultAction(TakeItem, 3134, 3 )
	MisResultAction(TakeItem,  3147, 3 )
	
	MisResultAction(GiveItem, 1042, 1, 4)
	MisResultAction(ClearMission, 971)
	MisResultAction(SetRecord, 971 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem,1351)	
	TriggerAction( 1, AddNextFlag, 971, 10, 1 )
	RegCurTrigger(9711 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3134)	
	TriggerAction( 1, AddNextFlag, 971, 20, 3 )
	RegCurTrigger(9712 )
	InitTrigger()
	TriggerCondition( 1, IsItem,  3147)	
	TriggerAction( 1, AddNextFlag, 971, 30, 3 )
	RegCurTrigger(9713 )
	--------------------------------------------------------------释放爱情(3)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000896 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000896")
	DefineMission( 5028, MISSCRIPT_MISSIONSCRIPT02_LUA_000896, 972)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000897 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000897")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000897 )
	MisBeginCondition(NoRecord, 972)
	MisBeginCondition(HasRecord, 971)
	MisBeginCondition(NoMission, 972)
	MisBeginCondition(HasItem, 1042, 1 )
	MisBeginAction(AddMission, 972)
	MisBeginAction(GiveItem, 1054, 1, 4)		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000898 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000898")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000898)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000899 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000899")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000899)
	MisResultCondition(AlwaysFailure)
------------------------------------------------------------------释放爱情(3)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000896 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000896")
	DefineMission(5029, MISSCRIPT_MISSIONSCRIPT02_LUA_000896, 972 ,COMPLETE_SHOW)

	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000900 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000900")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000900) 
	MisResultCondition(NoRecord, 972)
	MisResultCondition(HasMission, 972)
	MisResultCondition(HasItem, 1054, 1 )
	MisResultAction(TakeItem, 1054, 1 )
	MisResultAction(ClearMission, 972)
	MisResultAction(SetRecord,  972)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------诞生之太极石(4)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000901 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000901")
	DefineMission(5031,MISSCRIPT_MISSIONSCRIPT02_LUA_000901,973)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000902 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000902")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000902 )----------------++++++10
	MisBeginCondition(NoRecord, 973)
	MisBeginCondition(NoMission, 973)
	MisBeginCondition(HasMission, 957)
	MisBeginCondition(NoRecord, 957)
	MisBeginCondition(IsChaType,4)
	MisBeginAction(AddMission,973)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000903 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000903")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000903)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000904 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000904")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000904)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000905 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000905")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000905) 
	MisResultCondition(NoRecord, 973)
	MisResultCondition(HasMission, 973)
	MisResultCondition(HasRecord,  977)
	MisResultCondition(HasItem, 1045, 1)----------阴石
	MisResultCondition(HasItem, 1048, 1)-----------阳石
	MisResultAction(TakeItem,  1045, 1 )
	MisResultAction(TakeItem,  1048, 1 )
	MisResultAction(ClearMission, 973)
	MisResultAction(SetRecord,  973 )
	MisResultAction(SetRecord,  999 )------
	MisResultAction(AddExp,2000000,2000000)
	MisResultAction(AddMoney,800000,800000)	
	MisResultAction(AddExpAndType,2,60000,60000)
------------------------------------------------------诚信藏宝图
	MISSCRIPT_MISSIONSCRIPT02_LUA_000906 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000906")
	DefineMission(5032,MISSCRIPT_MISSIONSCRIPT02_LUA_000906,974)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000907 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000907")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000907 )
	MisBeginCondition(NoRecord, 974)
	MisBeginCondition(NoMission,974)
	MisBeginCondition(HasMission, 973)
	MisBeginCondition(NoRecord,973)
	MisBeginAction(GiveItem, 1053, 1, 4)------诚信藏宝图
	MisBeginAction(AddMission,974)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	--MisBeginAction(AddTrigger, 9741, TE_GETITEM, 1044,1)
	MisBeginBagNeed(1)	
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000908 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000908")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000908)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000909 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000909")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000909)
	
	MisResultCondition(AlwaysFailure)

	------------------------------------------诚信藏宝图

	MISSCRIPT_MISSIONSCRIPT02_LUA_000906 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000906")
	DefineMission(5033,MISSCRIPT_MISSIONSCRIPT02_LUA_000906,974,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000910 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000910")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000910)
	MisResultCondition(NoRecord, 974)
	MisResultCondition(HasMission,974)
	MisResultCondition(HasItem,1053, 1)
	MisResultAction(TakeItem, 1053, 1 )
	MisResultAction(ClearMission, 974)
	MisResultAction(SetRecord, 974)
	MisResultAction(GiveItem, 1045, 1, 4)--------阴石
	MisResultBagNeed(1)
	--------------------------------------------------阳石的下落
	MISSCRIPT_MISSIONSCRIPT02_LUA_000911 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000911")
	DefineMission(5034,MISSCRIPT_MISSIONSCRIPT02_LUA_000911,975)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000912 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000912")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000912 )
	MisBeginCondition(NoRecord, 975)
	MisBeginCondition(NoMission, 975)
	MisBeginCondition(HasRecord, 974)
	MisBeginAction(GiveItem, 1046, 1, 4)-------推荐信
	MisBeginAction(AddMission,975)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000913 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000913")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000913)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000914 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000914")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000914)
	MisResultCondition(AlwaysFailure)

--------------------------------------------------阳石的下落
	MISSCRIPT_MISSIONSCRIPT02_LUA_000911 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000911")
	DefineMission(5035,MISSCRIPT_MISSIONSCRIPT02_LUA_000911,975,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000915 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000915")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000915)
	MisResultCondition(NoRecord, 975)
	MisResultCondition(HasMission,975)
	MisResultCondition(HasItem,1046, 1)
	MisResultAction(TakeItem, 1046, 1 )
	MisResultAction(ClearMission, 975 )
	MisResultAction(SetRecord, 975)
	----------------------------------------------养眼水

	MISSCRIPT_MISSIONSCRIPT02_LUA_000916 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000916")
	DefineMission( 5036, MISSCRIPT_MISSIONSCRIPT02_LUA_000916, 976 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000917 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000917")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000917 )
	MisBeginCondition(NoRecord, 976 )
	MisBeginCondition(HasRecord, 975)
	MisBeginCondition(NoMission, 976)
	MisBeginAction(AddMission, 976 )
	MisBeginAction(AddTrigger, 9761, TE_GETITEM, 1362,1)		
	MisBeginAction(AddTrigger, 9762, TE_GETITEM, 3134, 3 )
	MisBeginAction(AddTrigger, 9763, TE_GETITEM, 1649, 10 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000918 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000918")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000918)
	MisNeed(MIS_NEED_ITEM, 1362,1, 10,1)
	MisNeed(MIS_NEED_ITEM, 3134, 3, 20, 3)
	MisNeed(MIS_NEED_ITEM, 1649,10, 30, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000919 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000919")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000919)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000920 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000920")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000920)
	MisResultCondition(HasMission, 976 )
	MisResultCondition(NoRecord, 976)
	MisResultCondition(HasItem, 1362, 1 )
	MisResultCondition(HasItem, 3134, 3 )
	MisResultCondition(HasItem,1649, 10)
	
	MisResultAction(TakeItem, 1362, 1 )
	MisResultAction(TakeItem, 3134, 3 )
	MisResultAction(TakeItem,1649, 10 )
	
	MisResultAction(GiveItem, 1047, 1, 4)------------- 养眼水
	MisResultAction(ClearMission, 976 )
	MisResultAction(SetRecord, 976  )
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem,1362)	
	TriggerAction( 1, AddNextFlag, 976, 10, 1 )
	RegCurTrigger(9761 )
	InitTrigger()
	TriggerCondition( 1, IsItem, 3134)	
	TriggerAction( 1, AddNextFlag, 976 , 20, 3 )
	RegCurTrigger(9762 )
	InitTrigger()
	TriggerCondition( 1, IsItem,1649)	
	TriggerAction( 1, AddNextFlag, 976 , 30, 10 )
	RegCurTrigger(9763 )

--------------------------------------------------------------------------岁月之尘
	MISSCRIPT_MISSIONSCRIPT02_LUA_000921 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000921")
	DefineMission(5037, MISSCRIPT_MISSIONSCRIPT02_LUA_000921, 977)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000922 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000922")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000922 )
	MisBeginCondition(NoRecord,  977)
	MisBeginCondition(HasRecord,  976)
	MisBeginCondition(NoMission, 977)
	MisBeginCondition(HasItem, 1047, 1 )
	MisBeginAction(TakeItem, 1047, 1 )
	MisBeginAction(AddMission,  977)
	MisBeginAction(AddTrigger,  9771, TE_GETITEM,  4782,1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000923 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000923")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000923)
	MisNeed(MIS_NEED_ITEM,  4782,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000924 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000924")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000924)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000925 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000925")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000925)
	MisResultCondition(HasMission,  977)
	MisResultCondition(HasItem, 4782, 1)
	MisResultAction(TakeItem,  4782, 1 )
	MisResultAction(GiveItem, 1048, 1, 4)------------- 阳石
	MisResultAction(ClearMission,  977)
	MisResultAction(SetRecord,  977 )
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsItem,4782)	
	TriggerAction( 1, AddNextFlag, 977, 10, 1 )
	RegCurTrigger( 9771 )


	--------------------------------------------------魔咒

	MISSCRIPT_MISSIONSCRIPT02_LUA_000926 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000926")
	DefineMission( 5043, MISSCRIPT_MISSIONSCRIPT02_LUA_000926, 978)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000927 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000927")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000927 )
	MisBeginCondition(NoRecord,  978)
	MisBeginCondition(HasRecord, 957)
	MisBeginCondition(NoMission, 978)
	MisBeginAction(AddMission, 978)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000928 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000928")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000928)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000929 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000929")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000929)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000930 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000930")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000930)
	MisResultCondition(HasMission, 978)
	MisResultCondition(NoRecord,  978)
	MisResultCondition(HasItem, 1052, 1 )--------圣灵护符
	MisResultAction(TakeItem, 1052, 1 )
	MisResultAction(ClearMission, 978)
	MisResultAction(SetRecord, 978 )
	MisResultAction(AddExp,1000000,1000000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)	
	

-------------------------------------------------土著长矛
	HELP_MONSTERHELP_LUA_000834 = GetResString("HELP_MONSTERHELP_LUA_000834")
	DefineMission( 5045, HELP_MONSTERHELP_LUA_000834, 979 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000931 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000931")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000931 )
	MisBeginCondition(NoRecord, 979 )
	MisBeginCondition(HasMission, 978)
	MisBeginCondition(NoRecord, 978 )
	MisBeginCondition(NoMission, 979 )
	MisBeginAction(AddMission, 979)

	MisBeginAction(AddTrigger, 9791, TE_GETITEM, 4739, 1 )		--长矛
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000932 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000932")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000932)
	MisNeed(MIS_NEED_ITEM, 4739,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000933 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000933")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000933)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000934 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000934")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000934)
	MisResultCondition(HasMission, 979)
	MisResultCondition(NoRecord, 979 )
	MisResultCondition(HasItem, 4739, 1 )
	MisResultAction(TakeItem, 4739, 1 )

	MisResultAction(ClearMission, 979)
	MisResultAction(SetRecord, 979)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsItem, 4739)	
	TriggerAction( 1, AddNextFlag, 979, 10, 1)
	RegCurTrigger( 9791 )
----------------------------------------------------讨伐恐怖的诅咒古尸

	MISSCRIPT_MISSIONSCRIPT02_LUA_000935 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000935")
	DefineMission(5046, MISSCRIPT_MISSIONSCRIPT02_LUA_000935, 980 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000936 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000936")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000936)
	MisBeginCondition(NoRecord,   980)
	MisBeginCondition(HasRecord,  979)
	MisBeginCondition(NoMission,  980)
	MisBeginAction(AddMission,   980)
	MisBeginAction(AddTrigger,   9801, TE_KILL, 508,1 )		
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisNeed(MIS_NEED_KILL,  508,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000937 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000937")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000937)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000938 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000938")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000938)----------------+++++11
	MisResultCondition(HasMission,  980)
	MisResultCondition(HasFlag, 980, 10 )
	MisResultAction(ClearMission,   980)
	MisResultAction(SetRecord,   980 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	

	InitTrigger()
	TriggerCondition( 1, IsMonster,508)	
	TriggerAction( 1, AddNextFlag,  980, 10, 1 )
	RegCurTrigger(  9801 )

----------------------------------------------------佐罗面具

	MISSCRIPT_MISSIONSCRIPT02_LUA_000939 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000939")
	DefineMission(5047,MISSCRIPT_MISSIONSCRIPT02_LUA_000939,981)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000940 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000940")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000940 )
	MisBeginCondition(NoRecord, 981)
	MisBeginCondition(NoMission, 981)
	MisBeginCondition(HasRecord, 980)
	MisBeginAction(GiveItem, 1025, 1, 4)----------佐罗面具
	MisBeginAction(AddMission,981)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000941 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000941")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000941)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000942 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000942")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000942)-----------------------++++++12
	MisResultCondition(AlwaysFailure)
	------------------------------------------------佐罗面具
	MISSCRIPT_MISSIONSCRIPT02_LUA_000939 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000939")
	DefineMission(5048,MISSCRIPT_MISSIONSCRIPT02_LUA_000939,981,COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000943 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000943")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000943)
	MisResultCondition(NoRecord, 981)
	MisResultCondition(HasMission,981)
	MisResultCondition(HasItem,1025, 1)
	MisResultAction(TakeItem, 1025, 1 )
	MisResultAction(ClearMission, 981 )
	MisResultAction(SetRecord, 981 )
-----------------------------------------------------终极密码
	MISSCRIPT_MISSIONSCRIPT02_LUA_000944 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000944")
	DefineMission( 5049, MISSCRIPT_MISSIONSCRIPT02_LUA_000944, 982 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000945 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000945")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000945 )
	MisBeginCondition(NoRecord, 982  )
	MisBeginCondition(HasRecord,981)
	MisBeginCondition(NoMission, 982  )
	MisBeginAction(AddMission, 982 )
	MisBeginAction(AddTrigger, 9821, TE_GETITEM, 4261, 1 )		--水芒
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000946 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000946")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000946)
	MisNeed(MIS_NEED_ITEM,4261,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000947 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000947")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000947)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000948 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000948")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000948)
	MisResultCondition(HasMission, 982 )
	MisResultCondition(NoRecord,982 )
	MisResultCondition(HasItem, 4261,1 )
	MisResultAction(TakeItem, 4261,1 )
	
	MisResultAction(ClearMission, 982 )
	MisResultAction(SetRecord, 982 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4261)	
	TriggerAction( 1, AddNextFlag,  982 , 10,1)
	RegCurTrigger( 9821 )
-------------------------------------------------宿命之石

	MISSCRIPT_MISSIONSCRIPT02_LUA_000949 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000949")
	DefineMission( 5050, MISSCRIPT_MISSIONSCRIPT02_LUA_000949, 983 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000950 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000950")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000950 )
	MisBeginCondition(NoRecord, 983)
	MisBeginCondition(HasRecord,  982 )
	MisBeginCondition(NoMission, 983 )
	MisBeginAction(AddMission, 983)
	MisBeginAction(AddTrigger, 9831, TE_GETITEM, 2487, 1 )		--兽丹石
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000951 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000951")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000951)
	MisNeed(MIS_NEED_ITEM,2487,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000952 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000952")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000952)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000953 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000953")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000953)
	MisResultCondition(HasMission, 983)
	MisResultCondition(NoRecord, 983)
	MisResultCondition(HasItem, 2487,1 )
	MisResultAction(TakeItem, 2487,1 )
	MisResultAction(ClearMission,983)
	MisResultAction(SetRecord, 983)
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2487)	
	TriggerAction( 1, AddNextFlag,  983, 10,1)
	RegCurTrigger(  9831 )

----------------------------------------------------------销毁面具

	MISSCRIPT_MISSIONSCRIPT02_LUA_000954 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000954")
	DefineMission( 5051, MISSCRIPT_MISSIONSCRIPT02_LUA_000954, 984 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000955 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000955")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000955 )
	MisBeginCondition(NoRecord,  984)
	MisBeginCondition(HasRecord,  983)
	MisBeginCondition(NoMission,  984 )
	MisBeginAction(AddMission,  984)
	MisBeginAction(AddTrigger,  9841, TE_GETITEM,4738, 1 )		--破碎的天使光环
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000956 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000956")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000956)
	MisNeed(MIS_NEED_ITEM,4738,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000957 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000957")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000957)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000958 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000958")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000958)
	MisResultCondition(HasMission, 984)
	MisResultCondition(NoRecord,  984)
	MisResultCondition(HasItem, 4738,1 )
	MisResultAction(TakeItem, 4738,1 )
	
	MisResultAction(ClearMission,  984)
	MisResultAction(SetRecord,  984)
	MisResultAction(AddMoney,300000,300000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 4738)	
	TriggerAction( 1, AddNextFlag,   984, 10,1)
	RegCurTrigger(   9841 )

-------------------------------------------------------魔布口袋
	MISSCRIPT_MISSIONSCRIPT02_LUA_000959 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000959")
	DefineMission( 5052, MISSCRIPT_MISSIONSCRIPT02_LUA_000959, 985 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000960 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000960")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000960 )
	MisBeginCondition(NoRecord,   985)
	MisBeginCondition(HasRecord, 984)
	MisBeginCondition(NoMission,  985)
	MisBeginAction(AddMission,  985)
	MisBeginAction(GiveItem, 1025, 1, 4)----------佐罗面具
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000961 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000961")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000961)----------------++++13
	MISSCRIPT_MISSIONSCRIPT02_LUA_000962 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000962")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000962)
	
	MisResultCondition(AlwaysFailure)
	
-------------------------------------------------------魔布口袋
	MISSCRIPT_MISSIONSCRIPT02_LUA_000959 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000959")
	DefineMission( 5053, MISSCRIPT_MISSIONSCRIPT02_LUA_000959, 985, COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000963 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000963")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000963)
	MisResultCondition(NoRecord,  985)
	MisResultCondition(HasMission,  985)
	MisResultCondition(HasItem,1025, 1)
	MisResultAction(TakeItem, 1025, 1 )
	MisResultAction(ClearMission,  985)
	MisResultAction(SetRecord,  985)
	MisResultAction(GiveItem, 1052, 1,4)
	MisResultAction(AddMoney,80000,80000)
	MisResultBagNeed(1)
	
------------------------------------------------------灵符上的金粉

	MISSCRIPT_MISSIONSCRIPT02_LUA_000964 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000964")
	DefineMission( 5054, MISSCRIPT_MISSIONSCRIPT02_LUA_000964, 986 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000965 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000965")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000965 )
	MisBeginCondition(NoRecord, 986)
	MisBeginCondition(HasRecord, 978)
	MisBeginCondition(NoMission,986 )
	MisBeginAction(AddMission, 986)
	MisBeginAction(AddTrigger, 9861, TE_GETITEM, 2438, 10 )		--金币
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000966 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000966")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000966)
	MisNeed(MIS_NEED_ITEM,2438,10, 10, 10)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000967 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000967")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000967)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000968 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000968")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000968)
	MisResultCondition(HasMission, 986)
	MisResultCondition(NoRecord,986)
	MisResultCondition(HasItem,2438,10 )
	MisResultAction(TakeItem, 2438,10 )
	MisResultAction(ClearMission, 986)
	MisResultAction(SetRecord,986)
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2438)	
	TriggerAction( 1, AddNextFlag,  986, 10,10)
	RegCurTrigger( 9861 )
-------------------------------------------------------裴蒂的指点
	MISSCRIPT_MISSIONSCRIPT02_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000969")
	DefineMission(5055,MISSCRIPT_MISSIONSCRIPT02_LUA_000969,987)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000970 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000970")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000970 )
	MisBeginCondition(NoRecord, 987)
	MisBeginCondition(NoMission,987)
	MisBeginCondition(HasRecord,986)
	MisBeginAction(AddMission,987)	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000971 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000971")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000971)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000972 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000972")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000972)
	MisResultCondition(AlwaysFailure)
-----------------------------------------------------裴蒂的指点(比特)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000969")
	DefineMission(5056, MISSCRIPT_MISSIONSCRIPT02_LUA_000969, 987, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000973")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000973)
	MisResultCondition(NoRecord, 987)
	MisResultCondition(HasMission,987)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 12)
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(ClearMission,987)
	MisResultAction(SetRecord, 987)

-----------------------------------------------------裴蒂的指点(雷欧)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000969")
	DefineMission(5057, MISSCRIPT_MISSIONSCRIPT02_LUA_000969, 987, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000973")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000973)
	MisResultCondition(NoRecord, 987)
	MisResultCondition(HasMission,987)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(ClearMission,987)
	MisResultAction(SetRecord, 987)

	-----------------------------------------------------裴蒂的指点(冒险者导师·小山车)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000969")
	DefineMission(5058, MISSCRIPT_MISSIONSCRIPT02_LUA_000969, 987 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000973")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000973)
	MisResultCondition(NoRecord, 987)
	MisResultCondition(HasMission,987)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 12)
	MisResultAction(ClearMission,987)
	MisResultAction(SetRecord, 987)

	-----------------------------------------------------裴蒂的指点(甘地维拉)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000969 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000969")
	DefineMission(5059, MISSCRIPT_MISSIONSCRIPT02_LUA_000969, 987 , COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000973 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000973")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000973)
	MisResultCondition(NoRecord, 987)
	MisResultCondition(HasMission,987)
	MisResultCondition(NoPfEqual,1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 12)
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(ClearMission,987)
	MisResultAction(SetRecord, 987)


-----------------------------------------------------职业介绍人的建议(if剑士)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000974 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000974")
	DefineMission( 5060, MISSCRIPT_MISSIONSCRIPT02_LUA_000974,988 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000975 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000975")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000975 )
	MisBeginCondition(NoRecord, 988)
	MisBeginCondition(HasRecord, 987)
	MisBeginCondition(NoMission, 988 )
	MisBeginCondition(NoPfEqual, 5)
	MisBeginCondition(NoPfEqual, 13)
	MisBeginCondition(NoPfEqual, 14)
	MisBeginCondition(NoPfEqual, 2)
	MisBeginCondition(NoPfEqual, 12)
	MisBeginCondition(NoPfEqual, 4)
	MisBeginCondition(NoPfEqual, 16)
	MisBeginAction(AddMission, 988 )
	MisBeginAction(AddTrigger, 9881, TE_KILL, 524, 1 )		--暴怒的蜥蜴人
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisNeed(MIS_NEED_KILL,524,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000976 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000976")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000976)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000977 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000977")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000977)
	MisResultCondition(HasMission, 988 )
	MisResultCondition(HasFlag, 988, 10 )
	MisResultAction(ClearMission, 988 )
	MisResultAction(SetRecord, 988 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 524)	
	TriggerAction( 1, AddNextFlag,  988 , 10,1)
	RegCurTrigger(  9881 )

-----------------------------------------------------雷欧的建议(if猎人)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000978 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000978")
	DefineMission( 5061, MISSCRIPT_MISSIONSCRIPT02_LUA_000978, 989 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000979 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000979")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000979 )
	MisBeginCondition(NoRecord, 989)
	MisBeginCondition(HasRecord, 987)
	MisBeginCondition(NoMission, 989 )
	MisBeginCondition(NoPfEqual, 5)
	MisBeginCondition(NoPfEqual, 13)
	MisBeginCondition(NoPfEqual, 14)
	MisBeginCondition(NoPfEqual, 1)
	MisBeginCondition(NoPfEqual, 8)
	MisBeginCondition(NoPfEqual, 4)
	MisBeginCondition(NoPfEqual, 9)
	MisBeginCondition(NoPfEqual, 16)
	MisBeginAction(AddMission, 989 )
	MisBeginAction(AddTrigger, 9891, TE_GETITEM, 4789, 1 )		
	MisBeginAction(AddTrigger, 9892, TE_GETITEM, 4741, 1 )	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000980 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000980")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000980)
	MisNeed(MIS_NEED_ITEM, 4789,1, 10, 1)
	MisNeed(MIS_NEED_ITEM,4741,1, 20, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_000981 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000981")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000981)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000982 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000982")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000982)
	MisResultCondition(HasMission,989 )
	MisResultCondition(HasItem, 4789,1 )
	MisResultCondition(HasItem,4741,1 )
	MisResultAction(TakeItem,  4789,1 )
	MisResultAction(TakeItem, 4741,1 )
	MisResultAction(ClearMission, 989 )
	MisResultAction(SetRecord, 989 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	
	InitTrigger()
	TriggerCondition( 1, IsMonster,  4789)	
	TriggerAction( 1, AddNextFlag,  989 , 10,1)
	RegCurTrigger(  9891 )
	InitTrigger()
	TriggerCondition( 1, IsMonster,4741)	
	TriggerAction( 1, AddNextFlag,  989 , 20,1)
	RegCurTrigger(  9892 )

---------------------------------------------------------------冒险者导师·小山车的建议(if冒险者)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000983 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000983")
	DefineMission( 5062, MISSCRIPT_MISSIONSCRIPT02_LUA_000983, 990 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000984 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000984")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000984 )
	MisBeginCondition(NoRecord, 990)
	MisBeginCondition(HasRecord, 987)
	MisBeginCondition(NoMission, 990 )
	MisBeginCondition(NoPfEqual, 5)
	MisBeginCondition(NoPfEqual, 13)
	MisBeginCondition(NoPfEqual, 14)
	MisBeginCondition(NoPfEqual, 1)
	MisBeginCondition(NoPfEqual, 8)
	MisBeginCondition(NoPfEqual, 2)
	MisBeginCondition(NoPfEqual, 9)
	MisBeginCondition(NoPfEqual, 12)
	MisBeginAction(AddMission, 990 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000985 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000985")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000985)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000986 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000986")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000986)

	MisResultCondition(AlwaysFailure)
---------------------------------------------------------------职业介绍人的建议
	MISSCRIPT_MISSIONSCRIPT02_LUA_000983 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000983")
	DefineMission( 5063, MISSCRIPT_MISSIONSCRIPT02_LUA_000983, 990,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_000987 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000987")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000987)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000988 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000988")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000988)
	MisResultCondition(NoRecord, 990)
	MisResultCondition(HasMission,990)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 12)
	MisResultAction(ClearMission, 990 )
	MisResultAction(SetRecord, 990 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)
	-------------------------------------------------------甘地维拉的建议(if药师)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000989 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000989")
	DefineMission( 5064, MISSCRIPT_MISSIONSCRIPT02_LUA_000989, 991 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000990 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000990")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000990 )
	MisBeginCondition(NoRecord, 991)
	MisBeginCondition(HasRecord, 987)
	MisBeginCondition(NoMission, 991 )
	MisBeginCondition(NoPfEqual,1)
	MisBeginCondition(NoPfEqual, 8)
	MisBeginCondition(NoPfEqual, 9)
	MisBeginCondition(NoPfEqual, 2)
	MisBeginCondition(NoPfEqual, 12)
	MisBeginCondition(NoPfEqual, 4)
	MisBeginCondition(NoPfEqual, 16)
	MisBeginAction(AddMission, 991 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000991 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000991")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000991)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000899 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000899")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000899)
	MisResultCondition(AlwaysFailure)

-------------------------------甘地维拉的建议
	MISSCRIPT_MISSIONSCRIPT02_LUA_000989 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000989")
	DefineMission( 5072, MISSCRIPT_MISSIONSCRIPT02_LUA_000989, 991,COMPLETE_SHOW )
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000992 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000992")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000992)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000993 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000993")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000993)
	MisResultCondition(NoRecord, 991)
	MisResultCondition(HasMission,991)
	MisResultAction(ClearMission, 991 )
	MisResultAction(SetRecord, 991 )

	
	-------------------------------------------------------石化的意志
	MISSCRIPT_MISSIONSCRIPT02_LUA_000994 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000994")
	DefineMission( 5073, MISSCRIPT_MISSIONSCRIPT02_LUA_000994, 998 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_000995 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000995")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_000995 )
	MisBeginCondition(NoRecord, 998)
	MisBeginCondition(HasRecord, 991)
	MisBeginCondition(NoMission, 998 )
	MisBeginAction(AddMission, 998 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_000996 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000996")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_000996)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000997 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000997")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000997)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000998 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000998")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_000998)

	MisResultCondition(HasMission, 998 )
	MisResultCondition(HasState, 92 )
	MisResultAction(ClearMission, 998 )
	MisResultAction(SetRecord, 998 )
	MisResultAction(AddExp,800000,800000)
	MisResultAction(AddMoney,200000,200000)	
	MisResultAction(AddExpAndType,2,60000,60000)
		
	----------------------------------------智者的事
     MISSCRIPT_MISSIONSCRIPT02_LUA_000999 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000999")
     DefineMission(5068,MISSCRIPT_MISSIONSCRIPT02_LUA_000999,993)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001000 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001000")
     MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001000)
     MisBeginCondition(HasRecord,988)
     MisBeginCondition(NoMission, 993)
     MisBeginCondition(NoRecord, 993)
     MisBeginAction(AddMission, 993)
     MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
     MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

     MISSCRIPT_MISSIONSCRIPT02_LUA_001001 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001001")
     MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001001)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001002")
     MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001002)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001003 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001003")
     MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001003)
     MisResultCondition(NoRecord, 993)---------应改为NoRecord
     MisResultCondition(HasMission, 993)
     MisResultAction(SetRecord, 993 )
     MisResultAction(ClearMission, 993 )
----------------------------------------智者的事
      MISSCRIPT_MISSIONSCRIPT02_LUA_000999 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000999")
      DefineMission(5069,MISSCRIPT_MISSIONSCRIPT02_LUA_000999,994)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001000 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001000")
     MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001000)
     MisBeginCondition(HasRecord,989)
      MisBeginCondition(NoMission, 994)
     MisBeginCondition(NoRecord, 994)
     MisBeginAction(AddMission, 994)
     MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
     MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

     MISSCRIPT_MISSIONSCRIPT02_LUA_001004 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001004")
     MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001004)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001002")
     MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001002)
      MISSCRIPT_MISSIONSCRIPT02_LUA_001003 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001003")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001003)
     MisResultCondition(NoRecord, 994)---------应改为NoRecord
     MisResultCondition(HasMission, 994)
     MisResultAction(SetRecord, 994 )
     MisResultAction(ClearMission, 994 )

     ----------------------------------------智者的事
      MISSCRIPT_MISSIONSCRIPT02_LUA_000999 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000999")
      DefineMission(5070,MISSCRIPT_MISSIONSCRIPT02_LUA_000999,995)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001005 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001005")
     MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001005)
     MisBeginCondition(HasRecord,998)
      MisBeginCondition(NoMission, 995)
     MisBeginCondition(NoRecord, 995)
     MisBeginAction(AddMission, 995)
     MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
     MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

     MISSCRIPT_MISSIONSCRIPT02_LUA_001006 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001006")
     MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001006)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001002")
     MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001002)
      MISSCRIPT_MISSIONSCRIPT02_LUA_001007 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001007")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001007)
     MisResultCondition(NoRecord, 995)---------应改为NoRecord
     MisResultCondition(HasMission, 995)
     MisResultAction(SetRecord, 995 )
     MisResultAction(ClearMission, 995 )
	----------------------------------------智者的事
      MISSCRIPT_MISSIONSCRIPT02_LUA_000999 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000999")
      DefineMission(5071,MISSCRIPT_MISSIONSCRIPT02_LUA_000999,997)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001005 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001005")
     MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001005)
     MisBeginCondition(HasRecord,990)
      MisBeginCondition(NoMission, 997)
     MisBeginCondition(NoRecord, 997)
     MisBeginAction(AddMission, 997)
     MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
     MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

     MISSCRIPT_MISSIONSCRIPT02_LUA_001008 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001008")
     MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001008)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001002 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001002")
     MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001002)
      MISSCRIPT_MISSIONSCRIPT02_LUA_001003 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001003")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001003)
     MisResultCondition(NoRecord, 997)---------应改为NoRecord
     MisResultCondition(HasMission, 997)
     MisResultAction(SetRecord, 997 )
     MisResultAction(ClearMission, 997 )

-------------------------------------------------------谁是智者-------------白银城商会会长·劳伦迪马斯
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5167, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1500 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001010 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001010")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001010 )
	MisBeginCondition(NoRecord,1500)
	MisBeginCondition(HasRecord, 993)
	MisBeginCondition(NoMission, 1500 )
	MisBeginAction(AddMission, 1500 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001011 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001011")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001011)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001012")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001012)
	MisResultCondition(AlwaysFailure)




-------------------------------------------------------谁是智者---------雷欧
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5168, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1501 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001013 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001013")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001013 )
	MisBeginCondition(NoRecord,1501)
	MisBeginCondition(HasRecord, 994)
	MisBeginCondition(NoMission, 1501 )
	MisBeginAction(AddMission, 1501 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001011 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001011")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001011)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001014 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001014")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001014)
	MisResultCondition(AlwaysFailure)



	-------------------------------------------------------谁是智者------------米尔米莉
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5074, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1502 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001013 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001013")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001013 )
	MisBeginCondition(NoRecord,1502)
	MisBeginCondition(HasRecord, 995)
	MisBeginCondition(NoMission, 1502 )
	MisBeginAction(AddMission, 1502 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001011 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001011")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001011)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001012")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001012)
	MisResultCondition(AlwaysFailure)

	


-------------------------------------------------------谁是智者------------乔尔尼
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5075, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1503 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001013 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001013")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001013 )
	MisBeginCondition(NoRecord,1503)
	MisBeginCondition(HasRecord, 997)
	MisBeginCondition(NoMission, 1503 )
	MisBeginAction(AddMission, 1503 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001011 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001011")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001011)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001012 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001012")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001012)
	MisResultCondition(AlwaysFailure)

	


	
-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5076, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1500,COMPLETE_SHOW )----------白银城商会会长·劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001015 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001015")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001015)
	MisResultCondition(NoRecord, 1500)
	MisResultCondition(HasMission,1500)
	MisResultAction(ClearMission, 1500 )
	MisResultAction(SetRecord, 1500 )
	MisResultAction(SetRecord, 1504 )

	-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5077, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1501,COMPLETE_SHOW )----------白银城商会会长·劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001015 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001015")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001015)
	MisResultCondition(NoRecord, 1501)
	MisResultCondition(HasMission,1501)
	MisResultAction(ClearMission, 1501 )
	MisResultAction(SetRecord, 1501 )
	MisResultAction(SetRecord, 1504 )

	-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5078, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1502,COMPLETE_SHOW )----------白银城商会会长·劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001015 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001015")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001015)
	MisResultCondition(NoRecord, 1502)
	MisResultCondition(HasMission,1502)
	MisResultAction(ClearMission, 1502 )
	MisResultAction(SetRecord, 1502 )
	MisResultAction(SetRecord, 1504 )

	-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5079, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1503,COMPLETE_SHOW )----------白银城商会会长·劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001015 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001015")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001015)
	MisResultCondition(NoRecord, 1503)
	MisResultCondition(HasMission,1503)
	MisResultAction(ClearMission, 1503 )
	MisResultAction(SetRecord, 1503 )
	MisResultAction(SetRecord, 1504 )
-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5080, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1500,COMPLETE_SHOW )----------郎拿督
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001016 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001016")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001016)
	MisResultCondition(NoRecord, 1500)
	MisResultCondition(HasMission,1500)
	MisResultAction(ClearMission, 1500 )
	MisResultAction(SetRecord, 1500 )
	MisResultAction(SetRecord, 1505 )


-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5081, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1501,COMPLETE_SHOW )-----------郎拿督
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001016 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001016")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001016)
	MisResultCondition(NoRecord, 1501)
	MisResultCondition(HasMission,1501)
	MisResultAction(ClearMission, 1501 )
	MisResultAction(SetRecord, 1501 )
	MisResultAction(SetRecord, 1505 )

-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5082, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1502,COMPLETE_SHOW )-----------郎拿督
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001016 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001016")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001016)
	MisResultCondition(NoRecord, 1502)
	MisResultCondition(HasMission,1502)
	MisResultAction(ClearMission, 1502 )
	MisResultAction(SetRecord, 1502 )
	MisResultAction(SetRecord, 1505 )

-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5083, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1503,COMPLETE_SHOW )-----------郎拿督
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001016 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001016")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001016)
	MisResultCondition(NoRecord, 1503)
	MisResultCondition(HasMission,1503)
	MisResultAction(ClearMission, 1503 )
	MisResultAction(SetRecord, 1503 )
	MisResultAction(SetRecord, 1505 )


	-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5084, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1500,COMPLETE_SHOW )----------艾立克
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001017 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001017)
	MisResultCondition(NoRecord, 1500)
	MisResultCondition(HasMission,1500)
	MisResultAction(ClearMission, 1500 )
	MisResultAction(SetRecord, 1500 )
	MisResultAction(SetRecord, 1506 )


-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5085, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1501,COMPLETE_SHOW )-----------艾立克
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001017 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001017)
	MisResultCondition(NoRecord, 1501)
	MisResultCondition(HasMission,1501)
	MisResultAction(ClearMission, 1501 )
	MisResultAction(SetRecord, 1501 )
	MisResultAction(SetRecord, 1506 )

-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5086, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1502,COMPLETE_SHOW )-----------艾立克
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001017 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001017)
	MisResultCondition(NoRecord, 1502)
	MisResultCondition(HasMission,1502)
	MisResultAction(ClearMission, 1502 )
	MisResultAction(SetRecord, 1502 )
	MisResultAction(SetRecord, 1506 )

-------------------------------谁是智者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001009 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001009")
	DefineMission( 5087, MISSCRIPT_MISSIONSCRIPT02_LUA_001009, 1503,COMPLETE_SHOW )-----------艾立克
	
	MisBeginCondition(AlwaysFailure )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001017 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001017")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001017)
	MisResultCondition(NoRecord, 1503)
	MisResultCondition(HasMission,1503)
	MisResultAction(ClearMission, 1503 )
	MisResultAction(SetRecord, 1503 )
	MisResultAction(SetRecord, 1506 )

-------------------------------------------------------金牌门徒-------------白银城商会会长·劳伦迪马斯
	MISSCRIPT_MISSIONSCRIPT02_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001018")
	DefineMission( 5088, MISSCRIPT_MISSIONSCRIPT02_LUA_001018, 1507 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001019 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001019")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001019 )
	MisBeginCondition(NoRecord,1507)
	MisBeginCondition(HasRecord, 1504)
	MisBeginCondition(NoMission, 1507 )
	MisBeginAction(AddMission, 1507 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001020 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001020")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001020)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001021 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001021")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001021)
	MisResultCondition(AlwaysFailure)
--------------------------------------------------------金牌门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001018")
	DefineMission( 5089, MISSCRIPT_MISSIONSCRIPT02_LUA_001018, 1507,COMPLETE_SHOW )--------比特
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001022 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001022")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001022)
	MisResultCondition(NoRecord, 1507)
	MisResultCondition(HasMission,1507)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 12)
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(ClearMission,1507)
	MisResultAction(SetRecord, 1507)
	MisResultAction(SetRecord, 1514)

	


	--------------------------------------------------------金牌门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001018")
	DefineMission( 5090, MISSCRIPT_MISSIONSCRIPT02_LUA_001018, 1507,COMPLETE_SHOW )---------雷欧
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001022 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001022")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001022)
	MisResultCondition(NoRecord, 1507)
	MisResultCondition(HasMission,1507)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(ClearMission,1507)
	MisResultAction(SetRecord, 1507)
	MisResultAction(SetRecord, 1515)

--------------------------------------------------------金牌门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001018")
	DefineMission( 5091, MISSCRIPT_MISSIONSCRIPT02_LUA_001018, 1507,COMPLETE_SHOW )---------乔尔尼
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001023 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001023")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001023)
	MisResultCondition(NoRecord, 1507)
	MisResultCondition(HasMission,1507)
	MisResultCondition(NoPfEqual, 5)
	MisResultCondition(NoPfEqual, 13)
	MisResultCondition(NoPfEqual, 14)
	MisResultCondition(NoPfEqual, 1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 12)
	MisResultAction(ClearMission,1507)
	MisResultAction(SetRecord, 1507)
	MisResultAction(SetRecord, 1516)

	--------------------------------------------------------金牌门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001018 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001018")
	DefineMission( 5092, MISSCRIPT_MISSIONSCRIPT02_LUA_001018, 1507,COMPLETE_SHOW )---------米尔米莉
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001024 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001024")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001024)
	MisResultCondition(NoRecord, 1507)
	MisResultCondition(HasMission,1507)
	MisResultCondition(NoPfEqual,1)
	MisResultCondition(NoPfEqual, 8)
	MisResultCondition(NoPfEqual, 9)
	MisResultCondition(NoPfEqual, 2)
	MisResultCondition(NoPfEqual, 12)
	MisResultCondition(NoPfEqual, 4)
	MisResultCondition(NoPfEqual, 16)
	MisResultAction(ClearMission,1507)
	MisResultAction(SetRecord, 1507)
	MisResultAction(SetRecord, 1517)

---------------------------------------------------------------------比特初级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001025 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001025")
	DefineMission( 5093, MISSCRIPT_MISSIONSCRIPT02_LUA_001025, 1508 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001026 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001026")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001026 )
	MisBeginCondition(NoRecord, 1508 )
	MisBeginCondition(HasRecord, 1507 )
	MisBeginCondition(HasRecord, 1514 )
	MisBeginCondition(NoMission, 1508 )
	MisBeginAction(AddMission,  1508)
	MisBeginAction(AddTrigger,  15081, TE_KILL, 67, 5 )----------------地精战士
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001027 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001027")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001027)
	MisNeed(MIS_NEED_KILL,67,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001028 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001028")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001028)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001029 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001029")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001029)
	MisResultCondition(HasMission,  1508)
	MisResultCondition(NoRecord,  1508)
	MisResultCondition(HasFlag,  1508, 14 )
	MisResultAction(ClearMission,  1508 )
	MisResultAction(SetRecord,  1508  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 67)	
	TriggerAction( 1, AddNextFlag,  1508 , 10,5)
	RegCurTrigger(   15081 )

	---------------------------------------------------------------------比特二级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001030 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001030")
	DefineMission( 5094, MISSCRIPT_MISSIONSCRIPT02_LUA_001030, 1509 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001031 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001031")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001031 )
	MisBeginCondition(NoRecord, 1509 )
	MisBeginCondition(HasRecord, 1508 )
	MisBeginCondition(NoMission, 1509 )
	MisBeginAction(AddMission,  1509)
	MisBeginAction(AddTrigger,  15091, TE_KILL, 549, 5 )----------------邪恶的不灭武
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001032 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001032")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001032)
	MisNeed(MIS_NEED_KILL,549,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001033 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001033")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001033)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001034 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001034")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001034)
	MisResultCondition(HasMission,  1509)
	MisResultCondition(NoRecord,  1509)
	MisResultCondition(HasFlag,  1509, 14 )
	MisResultAction(ClearMission,  1509 )
	MisResultAction(SetRecord,  1509  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 549)	
	TriggerAction( 1, AddNextFlag,  1509 , 10,5)
	RegCurTrigger(   15091 )

	---------------------------------------------------------------------比特三级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001035 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001035")
	DefineMission( 5095, MISSCRIPT_MISSIONSCRIPT02_LUA_001035, 1510 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001036 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001036")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001036 )
	MisBeginCondition(NoRecord, 1510 )
	MisBeginCondition(HasRecord, 1509 )
	MisBeginCondition(NoMission, 1510 )
	MisBeginAction(AddMission,  1510)
	MisBeginAction(AddTrigger,  15101, TE_KILL, 546, 6 )----------------邪恶的南瓜骑士
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001037 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001037")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001037)
	MisNeed(MIS_NEED_KILL,546,6, 10, 6)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001038 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001038")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001038)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001039 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001039")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001039)
	MisResultCondition(HasMission,  1510)
	MisResultCondition(NoRecord,  1510)
	MisResultCondition(HasFlag,  1510, 15 )
	MisResultAction(ClearMission,  1510 )
	MisResultAction(SetRecord,  1510  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 546)	
	TriggerAction( 1, AddNextFlag,  1510 , 10,6)
	RegCurTrigger(   15101 )



---------------------------------------------------------------------比特高级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001040 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001040")
	DefineMission( 5096, MISSCRIPT_MISSIONSCRIPT02_LUA_001040, 1511 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001041 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001041")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001041 )
	MisBeginCondition(NoRecord, 1511 )
	MisBeginCondition(HasRecord, 1510 )
	MisBeginCondition(NoMission, 1511 )
	MisBeginAction(AddMission,  1511)
	MisBeginAction(AddTrigger,  15111, TE_KILL, 201, 8 )----------------暗影猎手
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001042 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001042")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001042)
	MisNeed(MIS_NEED_KILL,201,8, 10, 8)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001043 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001043")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001043)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001044 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001044")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001044)
	MisResultCondition(HasMission,  1511)
	MisResultCondition(NoRecord,  1511)
	MisResultCondition(HasFlag,  1511, 17 )
	MisResultAction(ClearMission,  1511 )
	MisResultAction(SetRecord,  1511  )
	MisResultAction(AddExp,1500000,1500000)
	MisResultAction(AddMoney,500000,500000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 201)	
	TriggerAction( 1, AddNextFlag,  1511 , 10,8)
	RegCurTrigger(   15111 )


	
	---------------------------------------------------------------------雷欧初级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001025 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001025")
	DefineMission( 5097, MISSCRIPT_MISSIONSCRIPT02_LUA_001025, 1512 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001045 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001045")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001045 )
	MisBeginCondition(NoRecord, 1512 )
	MisBeginCondition(HasRecord, 1507 )
	MisBeginCondition(HasRecord, 1515 )
	MisBeginCondition(NoMission, 1512 )
	MisBeginAction(AddMission,  1512)
	MisBeginAction(AddTrigger,  15121, TE_KILL, 187, 5 )----------------小冰龙
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001046 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001046")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001046)
	MisNeed(MIS_NEED_KILL,187,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001047 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001047")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001047)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001048 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001048")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001048)
	MisResultCondition(HasMission,  1512)
	MisResultCondition(NoRecord,  1512)
	MisResultCondition(HasFlag,  1512, 14 )
	MisResultAction(ClearMission,  1512 )
	MisResultAction(SetRecord,  1512  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 187)	
	TriggerAction( 1, AddNextFlag,  1512 , 10,5)
	RegCurTrigger(   15121 )


	---------------------------------------------------------------------雷欧二级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001030 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001030")
	DefineMission( 5098, MISSCRIPT_MISSIONSCRIPT02_LUA_001030, 1513 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001049 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001049")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001049 )
	MisBeginCondition(NoRecord, 1513 )
	MisBeginCondition(HasRecord, 1512 )
	MisBeginCondition(NoMission, 1513 )
	MisBeginAction(AddMission,  1513)
	MisBeginAction(AddTrigger,  15131, TE_KILL, 543, 5 )----------------疯狂的土著人
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001050 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001050")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001050)
	MisNeed(MIS_NEED_KILL,543,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001051 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001051")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001051)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001052 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001052")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001052)
	MisResultCondition(HasMission,  1513)
	MisResultCondition(NoRecord,  1513)
	MisResultCondition(HasFlag,  1513, 14 )
	MisResultAction(ClearMission,  1513 )
	MisResultAction(SetRecord,  1513  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 543)	
	TriggerAction( 1, AddNextFlag,  1513 , 10,5)
	RegCurTrigger(   15131 )


	---------------------------------------------------------------------雷欧三级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001035 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001035")
	DefineMission( 5099, MISSCRIPT_MISSIONSCRIPT02_LUA_001035, 1518 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001053 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001053")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001053 )
	MisBeginCondition(NoRecord, 1518 )
	MisBeginCondition(HasRecord, 1513 )
	MisBeginCondition(NoMission, 1518 )
	MisBeginAction(AddMission,  1518)
	MisBeginAction(AddTrigger,  15181, TE_KILL, 566, 6 )----------------狼人战士队长
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001054 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001054")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001054)
	MisNeed(MIS_NEED_KILL,566,6, 10, 6)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001055 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001055")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001055)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001056 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001056")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001056)
	MisResultCondition(HasMission,  1518)
	MisResultCondition(NoRecord,  1518)
	MisResultCondition(HasFlag,  1518, 15 )
	MisResultAction(ClearMission,  1518 )
	MisResultAction(SetRecord,  1518  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 566)	
	TriggerAction( 1, AddNextFlag,  1518 , 10,6)
	RegCurTrigger(   15181 )


	---------------------------------------------------------------------雷欧高级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001040 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001040")
	DefineMission( 5100, MISSCRIPT_MISSIONSCRIPT02_LUA_001040, 1519 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001057 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001057")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001057 )
	MisBeginCondition(NoRecord, 1519 )
	MisBeginCondition(HasRecord, 1518 )
	MisBeginCondition(NoMission, 1519 )
	MisBeginAction(AddMission,  1519)
	MisBeginAction(AddTrigger,  15191, TE_KILL, 511, 8)----------------巨型树人
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001058 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001058")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001058)
	MisNeed(MIS_NEED_KILL,511,8, 10, 8)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001059 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001059")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001059)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001060 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001060")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001060)
	MisResultCondition(HasMission,  1519)
	MisResultCondition(NoRecord,  1519)
	MisResultCondition(HasFlag,  1519, 17 )
	MisResultAction(ClearMission,  1519 )
	MisResultAction(SetRecord,  1519  )
	MisResultAction(AddExp,1500000,1500000)
	MisResultAction(AddMoney,500000,500000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 511)	
	TriggerAction( 1, AddNextFlag,  1519 , 10,8)
	RegCurTrigger(   15191 )

	---------------------------------------------------------------------米尔初级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001025 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001025")
	DefineMission( 5101, MISSCRIPT_MISSIONSCRIPT02_LUA_001025, 1520 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001061 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001061")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001061 )
	MisBeginCondition(NoRecord, 1520 )
	MisBeginCondition(HasRecord, 1507 )
	MisBeginCondition(HasRecord, 1517)
	MisBeginCondition(NoMission, 1520 )
	MisBeginAction(AddMission,  1520)
	MisBeginAction(AddTrigger,  15201, TE_KILL, 549, 5 )----------------邪恶的不灭武士
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001062 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001062")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001062)
	MisNeed(MIS_NEED_KILL,549,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001063 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001063")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001063)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001064 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001064")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001064)
	MisResultCondition(HasMission,  1520)
	MisResultCondition(NoRecord,  1520)
	MisResultCondition(HasFlag,  1520, 14 )
	MisResultAction(ClearMission,  1520 )
	MisResultAction(SetRecord,  1520  )

	InitTrigger()
	TriggerCondition( 1, IsMonster, 549)	
	TriggerAction( 1, AddNextFlag,  1520 , 10,5)
	RegCurTrigger(   15201 )



---------------------------------------------------------------------米尔二级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001030 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001030")
	DefineMission( 5102, MISSCRIPT_MISSIONSCRIPT02_LUA_001030, 1521 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001065 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001065")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001065 )
	MisBeginCondition(NoRecord, 1521 )
	MisBeginCondition(HasRecord, 1520 )
	MisBeginCondition(NoMission, 1521 )
	MisBeginAction(AddMission,  1521)
	MisBeginAction(AddTrigger,  15211, TE_KILL, 587, 2 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001066 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001066")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001066)
	MisNeed(MIS_NEED_KILL,587,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001067 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001067")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001067)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001068 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001068")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001068)
	MisResultCondition(HasMission,  1521)
	MisResultCondition(NoRecord,  1521)
	MisResultCondition(HasFlag,  1521, 11 )
	MisResultAction(ClearMission,  1521 )
	MisResultAction(SetRecord,  1521  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 587)	
	TriggerAction( 1, AddNextFlag,  1521 , 10,2)
	RegCurTrigger(   15211 )



	---------------------------------------------------------------------米尔三级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001035 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001035")
	DefineMission( 5103, MISSCRIPT_MISSIONSCRIPT02_LUA_001035, 1522 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001069 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001069")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001069 )
	MisBeginCondition(NoRecord, 1522 )
	MisBeginCondition(HasRecord, 1521 )
	MisBeginCondition(NoMission, 1522 )
	MisBeginAction(AddMission,  1522)
	MisBeginAction(AddTrigger,  15221, TE_KILL, 606, 3 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001070 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001070")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001070)
	MisNeed(MIS_NEED_KILL,606,3, 10, 3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001071 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001071")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001071)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001072 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001072")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001072)
	MisResultCondition(HasMission,  1522)
	MisResultCondition(NoRecord,  1522)
	MisResultCondition(HasFlag,  1522, 12 )
	MisResultAction(ClearMission,  1522 )
	MisResultAction(SetRecord,  1522  )
	
	InitTrigger()
	TriggerCondition( 1, IsMonster, 606)	
	TriggerAction( 1, AddNextFlag,  1522 , 10,3)
	RegCurTrigger(   15221 )

---------------------------------------------------------------------米尔高级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001040 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001040")
	DefineMission( 5104, MISSCRIPT_MISSIONSCRIPT02_LUA_001040, 1523 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001073 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001073")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001073 )
	MisBeginCondition(NoRecord, 1523 )
	MisBeginCondition(HasRecord, 1522 )
	MisBeginCondition(NoMission, 1523 )
	MisBeginAction(AddMission,  1523)
	MisBeginAction(AddTrigger,  15231, TE_KILL, 735, 8 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001074 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001074")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001074)
	MisNeed(MIS_NEED_KILL,735,8, 10,8)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001075 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001075")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001075)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001076 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001076")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001076)
	MisResultCondition(HasMission,  1523)
	MisResultCondition(NoRecord,  1523)
	MisResultCondition(HasFlag,  1523, 17 )
	MisResultAction(ClearMission,  1523 )
	MisResultAction(SetRecord,  1523  )
	MisResultAction(AddExp,1500000,1500000)
	MisResultAction(AddMoney,500000,500000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 735)	
	TriggerAction( 1, AddNextFlag,  1523 , 10,8)
	RegCurTrigger(   15231 )


---------------------------------------------------------------------乔尔初级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001025 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001025")
	DefineMission( 5105, MISSCRIPT_MISSIONSCRIPT02_LUA_001025, 1524 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001077 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001077")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001077 )
	MisBeginCondition(NoRecord, 1524 )
	MisBeginCondition(HasRecord, 1516 )
	MisBeginCondition(HasRecord, 1507 )
	MisBeginCondition(NoMission, 1524 )
	MisBeginAction(AddMission,  1524)
	MisBeginAction(AddTrigger,  15241, TE_GETITEM, 1350, 2 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001078 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001078")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001078)
	MisNeed(MIS_NEED_ITEM,1350,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001079 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001079")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001079)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001080 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001080")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001080)
	MisResultCondition(HasMission,  1524)
	MisResultCondition(NoRecord,  1524)
	MisResultCondition(HasItem, 1350, 2)
	MisResultAction(TakeItem,  1350, 2 )
	MisResultAction(ClearMission,  1524 )
	MisResultAction(SetRecord,  1524  )
	
	InitTrigger()
	TriggerCondition( 1, IsItem,1350)	
	TriggerAction( 1, AddNextFlag, 1524, 10, 2 )
	RegCurTrigger( 15241 )

	---------------------------------------------------------------------乔尔二级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001030 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001030")
	DefineMission( 5106, MISSCRIPT_MISSIONSCRIPT02_LUA_001030, 1525 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001081 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001081")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001081 )
	MisBeginCondition(NoRecord, 1525 )
	MisBeginCondition(HasRecord, 1524 )
	MisBeginCondition(NoMission, 1525 )
	MisBeginAction(AddMission,  1525)
	MisBeginAction(AddTrigger,  15251, TE_GETITEM, 1295, 2 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001082 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001082")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001082)
	MisNeed(MIS_NEED_ITEM,1295,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001083 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001083")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001083)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001084 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001084")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001084)
	MisResultCondition(HasMission,  1525)
	MisResultCondition(NoRecord,  1525)
	MisResultCondition(HasItem, 1295, 2)
	MisResultAction(TakeItem,  1295, 2 )
	MisResultAction(ClearMission,  1525 )
	MisResultAction(SetRecord,  1525  )
	
	InitTrigger()
	TriggerCondition( 1, IsItem,1295)	
	TriggerAction( 1, AddNextFlag, 1525, 10, 2 )
	RegCurTrigger( 15251 )



---------------------------------------------------------------------乔尔三级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001035 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001035")
	DefineMission( 5107, MISSCRIPT_MISSIONSCRIPT02_LUA_001035, 1526 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001085 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001085")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001085 )
	MisBeginCondition(NoRecord, 1526 )
	MisBeginCondition(HasRecord, 1525 )
	MisBeginCondition(NoMission, 1526 )
	MisBeginAction(AddMission,  1526)
	MisBeginAction(AddTrigger,  15261, TE_GETITEM, 3116, 99 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001086 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001086")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001086)
	MisNeed(MIS_NEED_ITEM,3116,99, 10, 99)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001087 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001087")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001087)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001088 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001088")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001088)
	MisResultCondition(HasMission,  1526)
	MisResultCondition(NoRecord,  1526)
	MisResultCondition(HasItem, 3116, 99)
	MisResultAction(TakeItem,  3116, 99 )
	MisResultAction(ClearMission,  1526 )
	MisResultAction(SetRecord,  1526  )
	
	InitTrigger()
	TriggerCondition( 1, IsItem,3116)	
	TriggerAction( 1, AddNextFlag, 1526, 10, 99 )
	RegCurTrigger( 15261 )


	---------------------------------------------------------------------乔尔高级门徒

	MISSCRIPT_MISSIONSCRIPT02_LUA_001040 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001040")
	DefineMission( 5108, MISSCRIPT_MISSIONSCRIPT02_LUA_001040, 1527 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001089 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001089")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001089 )
	MisBeginCondition(NoRecord, 1527 )
	MisBeginCondition(HasRecord, 1526 )
	MisBeginCondition(NoMission, 1527 )
	MisBeginAction(AddMission,  1527)
	MisBeginAction(AddTrigger,  15271, TE_GETITEM, 4802, 1 )----------------
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001090 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001090")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001090)
	MisNeed(MIS_NEED_ITEM,4802,1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001091 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001091")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001091)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001092 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001092")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001092)
	MisResultCondition(HasMission,  1527)
	MisResultCondition(NoRecord,  1527)
	MisResultCondition(HasItem, 4802, 1)
	MisResultAction(TakeItem,  4802, 1 )
	MisResultAction(ClearMission,  1527 )
	MisResultAction(SetRecord,  1527  )
	MisResultAction(AddExp,1500000,1500000)
	MisResultAction(AddMoney,500000,500000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsItem,4802)	
	TriggerAction( 1, AddNextFlag, 1527, 10, 1 )
	RegCurTrigger( 15271 )

-------------------------------------------------------合格的门徒--------比特
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5109, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1528 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001094 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001094")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001094 )
	MisBeginCondition(NoRecord,1528)
	MisBeginCondition(HasRecord, 1511)
	MisBeginCondition(NoMission, 1528 )
	MisBeginAction(AddMission, 1528 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001095 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001095")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001095)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001096 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001096")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001096)
	MisResultCondition(AlwaysFailure)



--------------------------------------------------------合格的门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5110, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1528,COMPLETE_SHOW )----------白银城商会会长·劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001097 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001097")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001097)
	MisResultCondition(NoRecord, 1528)
	MisResultCondition(HasMission, 1528)
	MisResultAction(ClearMission,1528)
	MisResultAction(SetRecord, 1528)
	MisResultAction(SetRecord, 1577)-------------
	

-------------------------------------------------------合格的门徒--------雷欧
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5111, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1529 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001094 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001094")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001094 )
	MisBeginCondition(NoRecord,1529)
	MisBeginCondition(HasRecord, 1519)
	MisBeginCondition(NoMission, 1529 )
	MisBeginAction(AddMission, 1529 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001095 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001095")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001095)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001096 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001096")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001096)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------合格的门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5112, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1529,COMPLETE_SHOW )------白银城商会会长·劳伦迪马斯(2242,2748)
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001097 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001097")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001097)
	MisResultCondition(NoRecord, 1529)
	MisResultCondition(HasMission, 1529)
	MisResultAction(ClearMission,1529)
	MisResultAction(SetRecord, 1529)
	MisResultAction(SetRecord, 1577)-------------


	-------------------------------------------------------合格的门徒--------米尔
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5113, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1530 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001098 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001098")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001098 )
	MisBeginCondition(NoRecord,1530)
	MisBeginCondition(HasRecord, 1523)
	MisBeginCondition(NoMission, 1530 )
	MisBeginAction(AddMission, 1530 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001095 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001095")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001095)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001096 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001096")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001096)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------合格的门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5114, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1530,COMPLETE_SHOW )------劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001097 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001097")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001097)
	MisResultCondition(NoRecord, 1530)
	MisResultCondition(HasMission, 1530)
	MisResultAction(ClearMission,1530)
	MisResultAction(SetRecord, 1530)
	MisResultAction(SetRecord, 1577)-------------

	-------------------------------------------------------合格的门徒--------乔尔
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5115, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1531 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001099 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001099")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001099 )
	MisBeginCondition(NoRecord,1531)
	MisBeginCondition(HasRecord, 1527)
	MisBeginCondition(NoMission, 1531 )
	MisBeginAction(AddMission, 1531 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001095 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001095")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001095)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001096 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001096")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001096)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------合格的门徒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001093 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001093")
	DefineMission( 5116, MISSCRIPT_MISSIONSCRIPT02_LUA_001093, 1531,COMPLETE_SHOW )------劳伦迪马斯
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001100 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001100")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001100)
	MisResultCondition(NoRecord, 1531)
	MisResultCondition(HasMission, 1531)
	MisResultAction(ClearMission,1531)
	MisResultAction(SetRecord, 1531)
	MisResultAction(SetRecord, 1577)-------------

-------------------------------------------------------伟大的神谕----------朗拿度
	MISSCRIPT_MISSIONSCRIPT02_LUA_001101 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001101")
	DefineMission( 5117, MISSCRIPT_MISSIONSCRIPT02_LUA_001101, 1532 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001102 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001102")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001102 )
	MisBeginCondition(NoRecord,1532)
	MisBeginCondition(HasRecord, 1505)
	MisBeginCondition(NoMission, 1532 )
	MisBeginAction(AddMission, 1532 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001103 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001103")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001103)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001104 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001104")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001104)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------伟大的神谕
	MISSCRIPT_MISSIONSCRIPT02_LUA_001101 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001101")
	DefineMission( 5118, MISSCRIPT_MISSIONSCRIPT02_LUA_001101, 1532,COMPLETE_SHOW )-------------服装店助理·蓓蓓
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001105 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001105")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001105)
	MisResultCondition(NoRecord, 1532)
	MisResultCondition(HasMission, 1532)
	MisResultAction(ClearMission,1532)
	MisResultAction(SetRecord, 1532)



---------------------------------------------------------------------一重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001106 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001106")
	DefineMission( 5119, MISSCRIPT_MISSIONSCRIPT02_LUA_001106, 1533 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001107 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001107")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001107 )------服装店助理·蓓蓓
	MisBeginCondition(NoRecord, 1533 )
	MisBeginCondition(HasRecord, 1532 )
	MisBeginCondition(NoMission, 1533 )
	MisBeginAction(AddMission,  1533)
	MisBeginAction(AddTrigger,  15331, TE_KILL, 642, 2 )----------------凶猛的骨鱼
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001108 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001108")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001108)
	MisNeed(MIS_NEED_KILL,642,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001109 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001109")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001109)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1533)
	MisResultCondition(NoRecord,  1533)
	MisResultCondition(HasFlag,  1533, 11 )
	MisResultAction(ClearMission,  1533 )
	MisResultAction(SetRecord,  1533  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 642)	
	TriggerAction( 1, AddNextFlag,  1533 , 10,2)
	RegCurTrigger(   15331 )


-------------------------------------------------------告别一重门------------服装店助理·蓓蓓
	MISSCRIPT_MISSIONSCRIPT02_LUA_001111 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001111")
	DefineMission( 5120, MISSCRIPT_MISSIONSCRIPT02_LUA_001111, 1534 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001112 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001112")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001112 )
	MisBeginCondition(NoRecord,1534)
	MisBeginCondition(HasRecord, 1533)
	MisBeginCondition(NoMission, 1534 )
	MisBeginAction(AddMission, 1534 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001113 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001113")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001113)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001114 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001114")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001114)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别一重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001111 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001111")
	DefineMission( 5121, MISSCRIPT_MISSIONSCRIPT02_LUA_001111, 1534,COMPLETE_SHOW )-------------克拉拉大师
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001115 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001115")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001115)
	MisResultCondition(NoRecord, 1534)
	MisResultCondition(HasMission, 1534)
	MisResultAction(ClearMission,1534)
	MisResultAction(SetRecord, 1534)

---------------------------------------------------------------------二重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001116 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001116")
	DefineMission( 5122, MISSCRIPT_MISSIONSCRIPT02_LUA_001116, 1535 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001117 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001117")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001117 )------克拉拉大师
	MisBeginCondition(NoRecord, 1535 )
	MisBeginCondition(HasRecord, 1534 )
	MisBeginCondition(NoMission, 1535 )
	MisBeginAction(AddMission,  1535)
	MisBeginAction(AddTrigger,  15351, TE_KILL, 652, 2 )----------------凶猛的宝石海豚
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001118 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001118")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001118)
	MisNeed(MIS_NEED_KILL,652,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001119 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001119")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001119)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1535)
	MisResultCondition(NoRecord,  1535)
	MisResultCondition(HasFlag,  1535, 11 )
	MisResultAction(ClearMission,  1535 )
	MisResultAction(SetRecord,  1535  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 652)	
	TriggerAction( 1, AddNextFlag,  1535 , 10,2)
	RegCurTrigger(   15351 )


-------------------------------------------------------告别二重门------------克拉拉大师
	MISSCRIPT_MISSIONSCRIPT02_LUA_001120 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001120")
	DefineMission( 5123, MISSCRIPT_MISSIONSCRIPT02_LUA_001120, 1536 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001121 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001121")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001121 )
	MisBeginCondition(NoRecord,1536)
	MisBeginCondition(HasRecord, 1535)
	MisBeginCondition(NoMission, 1536 )
	MisBeginAction(AddMission, 1536 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001122 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001122")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001122)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001123 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001123")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001123)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别二重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001120 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001120")
	DefineMission( 5124, MISSCRIPT_MISSIONSCRIPT02_LUA_001120, 1536,COMPLETE_SHOW )-------------马洛
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001124 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001124")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001124)
	MisResultCondition(NoRecord, 1536)
	MisResultCondition(HasMission, 1536)
	MisResultAction(ClearMission,1536)
	MisResultAction(SetRecord, 1536)

---------------------------------------------------------------------三重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001125 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001125")
	DefineMission( 5125, MISSCRIPT_MISSIONSCRIPT02_LUA_001125, 1537 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001126 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001126")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001126 )------马洛
	MisBeginCondition(NoRecord, 1537 )
	MisBeginCondition(HasRecord, 1536 )
	MisBeginCondition(NoMission, 1537 )
	MisBeginAction(AddMission,  1537)
	MisBeginAction(AddTrigger,  15371, TE_KILL, 587, 2 )----------------凶猛的宝石海豚
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001127 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001127")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001127)
	MisNeed(MIS_NEED_KILL,587,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001128 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001128")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001128)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1537)
	MisResultCondition(NoRecord,  1537)
	MisResultCondition(HasFlag,  1537, 11 )
	MisResultAction(ClearMission,  1537 )
	MisResultAction(SetRecord,  1537  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 587)	
	TriggerAction( 1, AddNextFlag,  1537 , 10,2)
	RegCurTrigger(   15371 )


-------------------------------------------------------告别三重门------------马洛
	MISSCRIPT_MISSIONSCRIPT02_LUA_001129 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001129")
	DefineMission( 5126, MISSCRIPT_MISSIONSCRIPT02_LUA_001129, 1538 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001130 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001130")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001130 )
	MisBeginCondition(NoRecord,1538)
	MisBeginCondition(HasRecord, 1537)
	MisBeginCondition(NoMission, 1538 )
	MisBeginAction(AddMission, 1538 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001131 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001131")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001131)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001132 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001132")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001132)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别三重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001129 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001129")
	DefineMission( 5127, MISSCRIPT_MISSIONSCRIPT02_LUA_001129, 1538,COMPLETE_SHOW )-------------修司
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001133 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001133")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001133)
	MisResultCondition(NoRecord, 1538)
	MisResultCondition(HasMission, 1538)
	MisResultAction(ClearMission,1538)
	MisResultAction(SetRecord, 1538)



---------------------------------------------------------------------四重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001134 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001134")
	DefineMission( 5128, MISSCRIPT_MISSIONSCRIPT02_LUA_001134, 1539 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001135 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001135")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001135 )------修司
	MisBeginCondition(NoRecord, 1539 )
	MisBeginCondition(HasRecord, 1538 )
	MisBeginCondition(NoMission, 1539 )
	MisBeginAction(AddMission,  1539)
	MisBeginAction(AddTrigger,  15391, TE_KILL, 570, 5 )----------------红胡子海盗团战斗员
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001136 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001136")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001136)
	MisNeed(MIS_NEED_KILL,570,5, 10, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001137 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001137")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001137)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1539)
	MisResultCondition(NoRecord,  1539)
	MisResultCondition(HasFlag,  1539, 14 )
	MisResultAction(ClearMission,  1539 )
	MisResultAction(SetRecord,  1539  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 570)	
	TriggerAction( 1, AddNextFlag,  1539 , 10,5)
	RegCurTrigger(   15391 )


-------------------------------------------------------告别四重门------------修司
	MISSCRIPT_MISSIONSCRIPT02_LUA_001138 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001138")
	DefineMission( 5129, MISSCRIPT_MISSIONSCRIPT02_LUA_001138, 1540 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001139 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001139")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001139 )
	MisBeginCondition(NoRecord,1540)
	MisBeginCondition(HasRecord, 1539)
	MisBeginCondition(NoMission, 1540 )
	MisBeginAction(AddMission, 1540 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001140 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001140")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001140)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001141 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001141")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001141)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别四重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001138 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001138")
	DefineMission( 5130, MISSCRIPT_MISSIONSCRIPT02_LUA_001138, 1540,COMPLETE_SHOW )-------------军医·玛沙
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001142 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001142")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001142)
	MisResultCondition(NoRecord, 1540)
	MisResultCondition(HasMission, 1540)
	MisResultAction(ClearMission,1540)
	MisResultAction(SetRecord, 1540)


---------------------------------------------------------------------五重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001143 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001143")
	DefineMission( 5131, MISSCRIPT_MISSIONSCRIPT02_LUA_001143, 1541 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001144 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001144")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001144 )------军医·玛沙
	MisBeginCondition(NoRecord, 1541 )
	MisBeginCondition(HasRecord, 1540 )
	MisBeginCondition(NoMission, 1541 )
	MisBeginAction(AddMission,  1541)
	MisBeginAction(AddTrigger,  15411, TE_KILL, 589, 2 )----------------海妖弓手
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001145 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001145")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001145)
	MisNeed(MIS_NEED_KILL,589,2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001146 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001146")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001146)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1541)
	MisResultCondition(NoRecord,  1541)
	MisResultCondition(HasFlag,  1541, 11 )
	MisResultAction(ClearMission,  1541 )
	MisResultAction(SetRecord,  1541  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 589)	
	TriggerAction( 1, AddNextFlag,  1541 , 10,2)
	RegCurTrigger(   15411 )


-------------------------------------------------------告别五重门------------军医·玛沙
	MISSCRIPT_MISSIONSCRIPT02_LUA_001147 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001147")
	DefineMission( 5132, MISSCRIPT_MISSIONSCRIPT02_LUA_001147, 1542 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001148 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001148")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001148 )
	MisBeginCondition(NoRecord,1542)
	MisBeginCondition(HasRecord, 1541)
	MisBeginCondition(NoMission, 1542 )
	MisBeginAction(AddMission, 1542 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001149 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001149")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001149)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001150 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001150")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001150)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别五重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001147 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001147")
	DefineMission( 5133, MISSCRIPT_MISSIONSCRIPT02_LUA_001147, 1542,COMPLETE_SHOW )-------------丹尼斯
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001151 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001151")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001151)
	MisResultCondition(NoRecord, 1542)
	MisResultCondition(HasMission, 1542)
	MisResultAction(ClearMission,1542)
	MisResultAction(SetRecord, 1542)

---------------------------------------------------------------------六重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001152 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001152")
	DefineMission( 5134, MISSCRIPT_MISSIONSCRIPT02_LUA_001152, 1543 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001153 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001153")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001153 )------丹尼斯
	MisBeginCondition(NoRecord, 1543 )
	MisBeginCondition(HasRecord, 1542 )
	MisBeginCondition(NoMission, 1543 )
	MisBeginAction(AddMission,  1543)
	MisBeginAction(AddTrigger,  15431, TE_KILL, 36, 6 )----------------白灵猫
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001154 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001154")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001154)
	MisNeed(MIS_NEED_KILL,36,6, 10, 6)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001155 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001155")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001155)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1543)
	MisResultCondition(NoRecord,  1543)
	MisResultCondition(HasFlag,  1543, 15 )
	MisResultAction(ClearMission,  1543 )
	MisResultAction(SetRecord,  1543  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 36)	
	TriggerAction( 1, AddNextFlag,  1543 , 10,6)
	RegCurTrigger(   15431 )

-------------------------------------------------------告别六重门------------丹尼斯
	MISSCRIPT_MISSIONSCRIPT02_LUA_001156 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001156")
	DefineMission( 5135, MISSCRIPT_MISSIONSCRIPT02_LUA_001156, 1544 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001157 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001157")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001157 )
	MisBeginCondition(NoRecord,1544)
	MisBeginCondition(HasRecord, 1543)
	MisBeginCondition(NoMission, 1544 )
	MisBeginAction(AddMission, 1544 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001158 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001158")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001158)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001159 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001159")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001159)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别六重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001156 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001156")
	DefineMission( 5136, MISSCRIPT_MISSIONSCRIPT02_LUA_001156, 1544,COMPLETE_SHOW )-------------朱比
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001160 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001160")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001160)
	MisResultCondition(NoRecord, 1544)
	MisResultCondition(HasMission, 1544)
	MisResultAction(ClearMission,1544)
	MisResultAction(SetRecord, 1544)

---------------------------------------------------------------------七重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001161 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001161")
	DefineMission( 5137, MISSCRIPT_MISSIONSCRIPT02_LUA_001161, 1545 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001162 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001162")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001162 )------朱比
	MisBeginCondition(NoRecord, 1545 )
	MisBeginCondition(HasRecord, 1544 )
	MisBeginCondition(NoMission, 1545 )
	MisBeginAction(AddMission,  1545)
	MisBeginAction(AddTrigger,  15451, TE_KILL, 263, 7 )----------------地精战士长
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001163 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001163")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001163)
	MisNeed(MIS_NEED_KILL,263,7, 10, 7)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001164 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001164")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001164)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001110 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001110")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001110)
	MisResultCondition(HasMission,  1545)
	MisResultCondition(NoRecord,  1545)
	MisResultCondition(HasFlag,  1545, 16 )
	MisResultAction(ClearMission,  1545 )
	MisResultAction(SetRecord,  1545  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 263)	
	TriggerAction( 1, AddNextFlag,  1545 , 10,7)
	RegCurTrigger(   15451 )

-------------------------------------------------------告别七重门------------朱比
	MISSCRIPT_MISSIONSCRIPT02_LUA_001165 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001165")
	DefineMission( 5138, MISSCRIPT_MISSIONSCRIPT02_LUA_001165, 1546 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001166 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001166")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001166 )
	MisBeginCondition(NoRecord,1546)
	MisBeginCondition(HasRecord, 1545)
	MisBeginCondition(NoMission, 1546 )
	MisBeginAction(AddMission, 1546 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001167 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001167")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001167)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001168 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001168")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001168)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------告别七重门
	MISSCRIPT_MISSIONSCRIPT02_LUA_001165 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001165")
	DefineMission( 5139, MISSCRIPT_MISSIONSCRIPT02_LUA_001165, 1546,COMPLETE_SHOW )-------------琳达
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001169 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001169")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001169)
	MisResultCondition(NoRecord, 1546)
	MisResultCondition(HasMission, 1546)
	MisResultAction(ClearMission,1546)
	MisResultAction(SetRecord, 1546)

---------------------------------------------------------------------八重门

	MISSCRIPT_MISSIONSCRIPT02_LUA_001170 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001170")
	DefineMission( 5140, MISSCRIPT_MISSIONSCRIPT02_LUA_001170, 1547 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001171 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001171")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001171 )------琳达
	MisBeginCondition(NoRecord, 1547 )
	MisBeginCondition(HasRecord, 1546 )
	MisBeginCondition(NoMission, 1547 )
	MisBeginAction(AddMission,  1547)
	MisBeginAction(AddTrigger,  15471, TE_KILL, 808, 8 )----------------亡灵士兵
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001172 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001172")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001172)
	MisNeed(MIS_NEED_KILL,808,8, 10,8)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001173 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001173")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001173)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001174 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001174")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001174)
	MisResultCondition(HasMission,  1547)
	MisResultCondition(NoRecord,  1547)
	MisResultCondition(HasFlag,  1547, 17 )
	MisResultAction(ClearMission,  1547 )
	MisResultAction(SetRecord,  1547  )
	MisResultAction(AddExp,3000000,3000000)
	MisResultAction(AddMoney,1000000,1000000)	
	MisResultAction(AddExpAndType,2,120000,120000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 808)	
	TriggerAction( 1, AddNextFlag,  1547 , 10,8)
	RegCurTrigger(   15471 )

-------------------------------------------------------终结门的指示------------琳达
	MISSCRIPT_MISSIONSCRIPT02_LUA_001175 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001175")
	DefineMission( 5141, MISSCRIPT_MISSIONSCRIPT02_LUA_001175, 1548 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001176 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001176")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001176 )
	MisBeginCondition(NoRecord,1548)
	MisBeginCondition(HasRecord, 1547)
	MisBeginCondition(NoMission, 1548 )
	MisBeginAction(AddMission, 1548 )
	MisBeginAction(GiveItem, 2917,1,4)----------------------------------------------------神谕
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001177 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001177")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001177)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001178 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001178")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001178)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------终结门的指示
	MISSCRIPT_MISSIONSCRIPT02_LUA_001175 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001175")
	DefineMission( 5142, MISSCRIPT_MISSIONSCRIPT02_LUA_001175, 1548,COMPLETE_SHOW )-------------郎拿度
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001179 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001179")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001179)
	MisResultCondition(NoRecord, 1548)
	MisResultCondition(HasMission, 1548)
	MisResultCondition(HasItem,2917,1)--------------神谕
	MisResultAction(TakeItem, 2917,1)-------------神谕
	MisResultAction(ClearMission,1548)
	MisResultAction(SetRecord, 1548)

	---------------------------------------------------------------------完美海盗任务

	MISSCRIPT_MISSIONSCRIPT02_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001180")
	DefineMission( 5143, MISSCRIPT_MISSIONSCRIPT02_LUA_001180, 1549 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001181 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001181")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001181 )------艾立克
	MisBeginCondition(NoRecord, 1549 )
	MisBeginCondition(HasRecord, 1506 )
	MisBeginCondition(NoMission, 1549 )
	MisBeginAction(AddMission,  1549)
	MisBeginAction(AddTrigger,  15491, TE_KILL, 546, 10 )----------------邪恶的南瓜骑士
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001182 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001182")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001182)
	MisNeed(MIS_NEED_KILL,546,10, 10,10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001183 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001183")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001183)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001184 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001184")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001184)
	MisResultCondition(HasMission,  1549)
	MisResultCondition(NoRecord,  1549)
	MisResultCondition(HasFlag,  1549, 19 )
	MisResultAction(ClearMission,  1549 )
	MisResultAction(SetRecord,  1549  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 546)	
	TriggerAction( 1, AddNextFlag,  1549 , 10,10)
	RegCurTrigger(   15491 )



---------------------------------------------------------------------完美海盗任务

	MISSCRIPT_MISSIONSCRIPT02_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001180")
	DefineMission( 5144, MISSCRIPT_MISSIONSCRIPT02_LUA_001180, 1550 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001185 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001185")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001185 )------艾立克
	MisBeginCondition(NoRecord, 1550 )
	MisBeginCondition(HasRecord, 1549 )
	MisBeginCondition(NoMission, 1550 )
	MisBeginAction(AddMission,  1550)
	MisBeginAction(AddTrigger,  15501, TE_GETITEM, 4893, 2 )----------------王室佩剑
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001186 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001186")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001186)
	MisNeed(MIS_NEED_ITEM, 4893, 2, 10, 2)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001187 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001187")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001187)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001188 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001188")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001188)
	MisResultCondition(HasMission,  1550)
	MisResultCondition(NoRecord,  1550)
	MisResultCondition(HasItem, 4893, 2)
	MisResultAction(TakeItem, 4893, 2 )
	MisResultAction(ClearMission,  1550 )
	MisResultAction(SetRecord,  1550  )
	

	InitTrigger()
	TriggerCondition( 1, IsItem, 4893)	
	TriggerAction( 1, AddNextFlag,  1550 , 10,2)
	RegCurTrigger(   15501 )


---------------------------------------------------------------------完美海盗任务

	MISSCRIPT_MISSIONSCRIPT02_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001180")
	DefineMission( 5145, MISSCRIPT_MISSIONSCRIPT02_LUA_001180, 1551 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001189 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001189")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001189 )------艾立克
	MisBeginCondition(NoRecord, 1551 )
	MisBeginCondition(HasRecord, 1550 )
	MisBeginCondition(NoMission, 1551 )
	MisBeginAction(AddMission,  1551)
	MisBeginAction(AddTrigger,  15511, TE_KILL, 606, 3 )----------------深蓝海妖
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001190 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001190")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001190)
	MisNeed(MIS_NEED_KILL,606,3, 10,3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001191 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001191")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001191)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001192 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001192")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001192)
	MisResultCondition(HasMission,  1551)
	MisResultCondition(NoRecord,  1551)
	MisResultCondition(HasFlag,  1551, 12 )
	MisResultAction(ClearMission,  1551 )
	MisResultAction(SetRecord,  1551  )
	

	InitTrigger()
	TriggerCondition( 1, IsMonster, 606)	
	TriggerAction( 1, AddNextFlag,  1551 , 10,3)
	RegCurTrigger(   15511 )

---------------------------------------------------------------------完美海盗任务

	MISSCRIPT_MISSIONSCRIPT02_LUA_001180 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001180")
	DefineMission( 5146, MISSCRIPT_MISSIONSCRIPT02_LUA_001180, 1552 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001193 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001193")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001193 )------艾立克
	MisBeginCondition(NoRecord, 1552 )
	MisBeginCondition(HasRecord, 1551 )
	MisBeginCondition(NoMission, 1552 )
	MisBeginAction(AddMission,  1552)
	MisBeginAction(AddTrigger,  15521, TE_KILL, 589, 3 )----------------海妖弓手
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001194 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001194")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001194)
	MisNeed(MIS_NEED_KILL,589,3, 10,3)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001195 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001195")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001195)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001196 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001196")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001196)
	MisResultCondition(HasMission,  1552)
	MisResultCondition(NoRecord,  1552)
	MisResultCondition(HasFlag,  1552, 12 )
	MisResultAction(ClearMission,  1552 )
	MisResultAction(SetRecord,  1552  )
	MisResultAction(AddExp1500000,1500000)
	MisResultAction(AddMoney,500000,500000)	
	MisResultAction(AddExpAndType,2,60000,60000)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 589)	
	TriggerAction( 1, AddNextFlag,  1552 , 10,3)
	RegCurTrigger(   15521 )

-------------------------------------------------------谜底揭晓------------劳伦迪马斯
	MISSCRIPT_MISSIONSCRIPT02_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001197")
	DefineMission( 5147, MISSCRIPT_MISSIONSCRIPT02_LUA_001197, 1553 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001198 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001198")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001198 )
	MisBeginCondition(NoRecord,1553)
	MisBeginCondition(HasRecord, 1577)
	MisBeginCondition(NoMission, 1553 )
	MisBeginAction(GiveItem, 2918, 1, 4)		------------蒙德石
	MisBeginAction(AddMission, 1553 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001199 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001199")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001199)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001200 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001200")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001200)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------谜底揭晓
	MISSCRIPT_MISSIONSCRIPT02_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001197")
	DefineMission( 5148, MISSCRIPT_MISSIONSCRIPT02_LUA_001197, 1553,COMPLETE_SHOW )-------------怪叟爷爷
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001201 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001201")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001201)
	MisResultCondition(NoRecord, 1553)
	MisResultCondition(HasMission, 1553)
	MisResultCondition(HasItem, 2918, 1)------------蒙德石
	MisResultAction(TakeItem, 2918, 1 )-----蒙德石
	MisResultAction(ClearMission,1553)
	MisResultAction(SetRecord, 1553)
	MisResultAction(SetRecord, 1556)

-------------------------------------------------------谜底揭晓------------郎拿度
	MISSCRIPT_MISSIONSCRIPT02_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001197")
	DefineMission( 5149, MISSCRIPT_MISSIONSCRIPT02_LUA_001197, 1554 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001202 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001202")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001202 )
	MisBeginCondition(NoRecord,1554)
	MisBeginCondition(HasRecord, 1548)
	MisBeginCondition(NoMission, 1554 )
	MisBeginAction(GiveItem, 2918, 1, 4)		------------蒙德石
	MisBeginAction(AddMission, 1554 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001203 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001203")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001203)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001200 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001200")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001200)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------谜底揭晓
	MISSCRIPT_MISSIONSCRIPT02_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001197")
	DefineMission( 5150, MISSCRIPT_MISSIONSCRIPT02_LUA_001197, 1554,COMPLETE_SHOW )-------------怪叟爷爷
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001201 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001201")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001201)
	MisResultCondition(NoRecord, 1554)
	MisResultCondition(HasMission, 1554)
	MisResultCondition(HasItem, 2918, 1)------------蒙德石
	MisResultAction(TakeItem, 2918, 1 )-----蒙德石
	MisResultAction(ClearMission,1554)
	MisResultAction(SetRecord, 1554)
	MisResultAction(SetRecord, 1556)

-------------------------------------------------------谜底揭晓------------艾立克
	MISSCRIPT_MISSIONSCRIPT02_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001197")
	DefineMission( 5151, MISSCRIPT_MISSIONSCRIPT02_LUA_001197, 1555 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001204 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001204")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001204 )
	MisBeginCondition(NoRecord,1555)
	MisBeginCondition(HasRecord, 1552)
	MisBeginCondition(NoMission, 1555 )
	MisBeginAction(GiveItem, 2918, 1, 4)		------------蒙德石
	MisBeginAction(AddMission, 1555 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MisBeginBagNeed(1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001203 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001203")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001203)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001200 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001200")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001200)
	MisResultCondition(AlwaysFailure)

	--------------------------------------------------------谜底揭晓
	MISSCRIPT_MISSIONSCRIPT02_LUA_001197 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001197")
	DefineMission( 5152, MISSCRIPT_MISSIONSCRIPT02_LUA_001197, 1555,COMPLETE_SHOW )-------------怪叟爷爷
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001201 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001201")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001201)
	MisResultCondition(NoRecord, 1555)
	MisResultCondition(HasMission, 1555)
	MisResultCondition(HasItem, 2918, 1)------------蒙德石
	MisResultAction(TakeItem, 2918, 1 )-----蒙德石
	MisResultAction(ClearMission,1555)
	MisResultAction(SetRecord, 1555)
	MisResultAction(SetRecord, 1556)

------------------------------------------------------老朽们的纠纷------------怪叟爷爷
	MISSCRIPT_MISSIONSCRIPT02_LUA_001205 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001205")
	DefineMission( 5169, MISSCRIPT_MISSIONSCRIPT02_LUA_001205, 1557 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001206 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001206")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001206 )
	MisBeginCondition(NoRecord,1557)
	MisBeginCondition(HasRecord, 1556)
	MisBeginCondition(NoMission, 1557 )
	MisBeginAction(AddMission, 1557 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001207 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001207")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001207)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001208 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001208")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001208)
	MisResultCondition(AlwaysFailure)


	--------------------------------------------------------老朽们的纠纷
	MISSCRIPT_MISSIONSCRIPT02_LUA_001205 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001205")
	DefineMission( 5153, MISSCRIPT_MISSIONSCRIPT02_LUA_001205, 1557,COMPLETE_SHOW )-------------冬达米婆婆
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001209 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001209")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001209)
	MisResultCondition(NoRecord, 1557)
	MisResultCondition(HasMission, 1557)
	MisResultAction(ClearMission,1557)
	MisResultAction(SetRecord, 1557)
	
---------------------------------------------------------------------老太婆的智慧

	MISSCRIPT_MISSIONSCRIPT02_LUA_001210 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001210")
	DefineMission( 5154, MISSCRIPT_MISSIONSCRIPT02_LUA_001210, 1561 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001211 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001211")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001211 )------冬达米婆婆
	MisBeginCondition(NoRecord,1561)
	MisBeginCondition(HasRecord, 1558)
	MisBeginCondition(HasRecord, 1559)
	MisBeginCondition(NoMission, 1561 )
	MisBeginAction(AddMission, 1561 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001212 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001212")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001212)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001213 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001213")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001213)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001214 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001214")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001214)
	MisResultCondition(NoRecord, 1561)
	MisResultCondition(HasMission, 1561)
	MisResultCondition(HasRecord, 1562)
	MisResultCondition(HasRecord, 1564)
	MisResultAction(ClearMission,1561)
	MisResultAction(SetRecord, 1561)
	

---------------------------------------------------------------------治疗传染病

	MISSCRIPT_MISSIONSCRIPT02_LUA_001215 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001215")
	DefineMission( 5155, MISSCRIPT_MISSIONSCRIPT02_LUA_001215, 1566 )-----冬达米婆婆

	MISSCRIPT_MISSIONSCRIPT02_LUA_001216 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001216")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001216 )------冬达米婆婆
	MisBeginCondition(NoRecord,1566)
	MisBeginCondition(HasRecord, 1558)
	MisBeginCondition(HasRecord, 1560)
	MisBeginCondition(NoMission, 1566 )
	MisBeginAction(AddMission, 1566 )
	MisBeginAction(AddTrigger,  15661, TE_GETITEM, 2743, 1 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001217 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001217")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001217)
	MisNeed(MIS_NEED_ITEM,2743,1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001218 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001218")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001218)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001219 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001219")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001219)
	MisResultCondition(NoRecord, 1566)
	MisResultCondition(HasMission, 1566)
	MisResultCondition(HasItem, 2743, 1)
	MisResultAction(TakeItem,  2743, 1 )
	MisResultAction(ClearMission,1566)
	MisResultAction(SetRecord, 1566)
	MisResultAction(SetRecord, 1559)


	InitTrigger()
	TriggerCondition( 1, IsItem,2743)	
	TriggerAction( 1, AddNextFlag, 1566, 10, 1 )
	RegCurTrigger( 15661 )
---------------------------------------------------------------------手动治疗法

	MISSCRIPT_MISSIONSCRIPT02_LUA_001220 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001220")
	DefineMission( 5156, MISSCRIPT_MISSIONSCRIPT02_LUA_001220, 1567 )-----冬达米婆婆

	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001221 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001221")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001221 )------冬达米婆婆
	MisBeginCondition(NoRecord,1567)
	MisBeginCondition(HasRecord, 1562)
	MisBeginCondition(HasRecord, 1565)
	MisBeginCondition(HasRecord, 1561)
	MisBeginCondition(NoMission, 1567 )
	MisBeginAction(AddMission, 1567 )
	MisBeginAction(AddTrigger,  15671, TE_GETITEM, 2744, 1 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001222 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001222")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001222)
	MisNeed(MIS_NEED_ITEM,2744,1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001218 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001218")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001218)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001219 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001219")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001219)
	MisResultCondition(NoRecord, 1567)
	MisResultCondition(HasMission, 1567)
	MisResultCondition(HasItem, 2744, 1)
	MisResultAction(TakeItem,  2744, 1 )
	MisResultAction(ClearMission,1567)
	MisResultAction(SetRecord, 1567)
	


	InitTrigger()
	TriggerCondition( 1, IsItem,2744)	
	TriggerAction( 1, AddNextFlag, 1567, 10, 1 )
	RegCurTrigger( 15671 )



-------------------------------------------------------真理守护者-----------------冬达米婆婆
	MISSCRIPT_MISSIONSCRIPT02_LUA_001223 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001223")
	DefineMission( 5157, MISSCRIPT_MISSIONSCRIPT02_LUA_001223, 1568 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001224 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001224")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001224 )
	MisBeginCondition(NoRecord,1568)
	MisBeginCondition(HasRecord, 1561)
	MisBeginCondition(HasRecord, 1564)
	MisBeginCondition(NoMission, 1568 )
	MisBeginAction(AddMission, 1568 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001225 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001225")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001225)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001226 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001226")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001226)
	
	MisResultCondition(AlwaysFailure)

	-------------------------------------------------------真理守护者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001223 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001223")
	DefineMission( 5158, MISSCRIPT_MISSIONSCRIPT02_LUA_001223, 1568,COMPLETE_SHOW )-------------怪叟
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001227 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001227")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001227)
	MisResultCondition(NoRecord, 1568)
	MisResultCondition(HasMission, 1568)
	MisResultAction(ClearMission,1568)
	MisResultAction(SetRecord, 1568)
	MisResultAction(SetRecord, 1571)


	-------------------------------------------------------真理守护者-----------------冬达米婆婆
	MISSCRIPT_MISSIONSCRIPT02_LUA_001223 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001223")
	DefineMission( 5159, MISSCRIPT_MISSIONSCRIPT02_LUA_001223, 1569 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001224 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001224")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001224 )
	MisBeginCondition(NoRecord,1569)
	MisBeginCondition(HasRecord, 1567)
	MisBeginCondition(NoMission, 1569 )
	MisBeginAction(AddMission, 1569 )
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001225 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001225")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001225)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001226 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001226")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001226)
	
	MisResultCondition(AlwaysFailure)


--------------------------------------------------------真理守护者

	MISSCRIPT_MISSIONSCRIPT02_LUA_001223 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001223")
	DefineMission( 5160, MISSCRIPT_MISSIONSCRIPT02_LUA_001223, 1569,COMPLETE_SHOW )-------------怪叟
	
	MisBeginCondition(AlwaysFailure )
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001227 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001227")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001227)
	MisResultCondition(NoRecord, 1569)
	MisResultCondition(HasMission, 1569)
	MisResultAction(ClearMission,1569)
	MisResultAction(SetRecord, 1569)
	MisResultAction(SetRecord, 1571)

	MisResultAction(AddExp,300000,300000)
	MisResultAction(AddMoney,100000,100000)	
	MisResultAction(AddExpAndType,2,20000,20000)
-----------------------------------------------------神秘的咒语

	MISSCRIPT_MISSIONSCRIPT02_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001228")
	DefineMission( 5161, MISSCRIPT_MISSIONSCRIPT02_LUA_001228,1570 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001229 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001229")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001229 )
	MisBeginCondition(NoRecord, 1570)
	MisBeginCondition(HasRecord, 1571)
	MisBeginCondition(NoMission,1570 )
	MisBeginAction(AddMission, 1570)
	MisBeginAction(AddTrigger, 15701, TE_GETITEM, 2408, 1 )		--口令AB
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001230 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001230")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001230)
	MisNeed(MIS_NEED_ITEM,2408,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001231 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001231")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001231)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001232 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001232")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001232)
	MisResultCondition(HasMission, 1570)
	MisResultCondition(NoRecord,1570)
	MisResultCondition(HasItem,2408,1 )
	MisResultAction(TakeItem, 2408,1 )
	MisResultAction(ClearMission, 1570)
	MisResultAction(SetRecord,1570)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2408)	
	TriggerAction( 1, AddNextFlag,  1570, 10,1)
	RegCurTrigger( 15701 )

----------------------------------------------------神秘的咒语

	MISSCRIPT_MISSIONSCRIPT02_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001228")
	DefineMission( 5162, MISSCRIPT_MISSIONSCRIPT02_LUA_001228,1572 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001233 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001233")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001233 )
	MisBeginCondition(NoRecord, 1572)
	MisBeginCondition(HasRecord, 1570)
	MisBeginCondition(NoMission,1572 )
	MisBeginAction(AddMission, 1572)
	MisBeginAction(AddTrigger, 15721, TE_GETITEM, 2409, 1 )		--口令BC
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001234 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001234")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001234)
	MisNeed(MIS_NEED_ITEM,2409,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001235 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001235")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001235)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001236 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001236")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001236)
	MisResultCondition(HasMission, 1572)
	MisResultCondition(NoRecord,1572)
	MisResultCondition(HasItem,2409,1 )
	MisResultAction(TakeItem, 2409,1 )
	MisResultAction(ClearMission, 1572)
	MisResultAction(SetRecord,1572)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2409)	
	TriggerAction( 1, AddNextFlag,  1572, 10,1)
	RegCurTrigger( 15721 )


	----------------------------------------------------神秘的咒语

	MISSCRIPT_MISSIONSCRIPT02_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001228")
	DefineMission( 5163, MISSCRIPT_MISSIONSCRIPT02_LUA_001228,1573 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001237 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001237")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001237 )
	MisBeginCondition(NoRecord, 1573)
	MisBeginCondition(HasRecord, 1572)
	MisBeginCondition(NoMission,1573 )
	MisBeginAction(AddMission, 1573)
	MisBeginAction(AddTrigger, 15731, TE_GETITEM, 2410, 1 )		--口令CD
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001238 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001238")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001238)
	MisNeed(MIS_NEED_ITEM,2410,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001239 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001239")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001239)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001240")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001240)
	MisResultCondition(HasMission, 1573)
	MisResultCondition(NoRecord,1573)
	MisResultCondition(HasItem,2410,1 )
	MisResultAction(TakeItem, 2410,1 )
	MisResultAction(ClearMission, 1573)
	MisResultAction(SetRecord,1573)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2410)	
	TriggerAction( 1, AddNextFlag,  1573, 10,1)
	RegCurTrigger( 15731 )


----------------------------------------------------神秘的咒语

	MISSCRIPT_MISSIONSCRIPT02_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001228")
	DefineMission( 5164, MISSCRIPT_MISSIONSCRIPT02_LUA_001228,1574 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001241 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001241")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001241 )
	MisBeginCondition(NoRecord, 1574)
	MisBeginCondition(HasRecord, 1573)
	MisBeginCondition(NoMission,1574 )
	MisBeginAction(AddMission, 1574)
	MisBeginAction(AddTrigger, 15741, TE_GETITEM, 2411, 1 )		--口令DE
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001242 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001242")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001242)
	MisNeed(MIS_NEED_ITEM,2411,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001243 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001243")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001243)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001240 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001240")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001240)
	MisResultCondition(HasMission, 1574)
	MisResultCondition(NoRecord,1574)
	MisResultCondition(HasItem,2411,1 )
	MisResultAction(TakeItem, 2411,1 )
	MisResultAction(ClearMission, 1574)
	MisResultAction(SetRecord,1574)
	
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2411)	
	TriggerAction( 1, AddNextFlag,  1574, 10,1)
	RegCurTrigger( 15741 )


----------------------------------------------------神秘的咒语

	MISSCRIPT_MISSIONSCRIPT02_LUA_001228 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001228")
	DefineMission( 5165, MISSCRIPT_MISSIONSCRIPT02_LUA_001228,1575 )

	MISSCRIPT_MISSIONSCRIPT02_LUA_001244 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001244")
	MisBeginTalk( MISSCRIPT_MISSIONSCRIPT02_LUA_001244 )
	MisBeginCondition(NoRecord, 1575)
	MisBeginCondition(HasRecord, 1574)
	MisBeginCondition(NoMission,1575 )
	MisBeginAction(AddMission, 1575)
	MisBeginAction(AddTrigger, 15751, TE_GETITEM, 2412, 1 )		--口令EF
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001245 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001245")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001245)
	MisNeed(MIS_NEED_ITEM,2412,1, 10, 1)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001246 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001246")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001246)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001247 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001247")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001247)
	MisResultCondition(HasMission, 1575)
	MisResultCondition(NoRecord,1575)
	MisResultCondition(HasItem,2412,1 )
	MisResultAction(TakeItem, 2412,1 )
	MisResultAction(ClearMission, 1575)
	MisResultAction(SetRecord,1575)
	MisResultAction(AddExp,1500000,1500000)
	MisResultAction(AddMoney,400000,400000)	
	MisResultAction(AddExpAndType,2,80000,80000)
	
	InitTrigger()
	TriggerCondition( 1, IsItem, 2412)	
	TriggerAction( 1, AddNextFlag,  1575, 10,1)
	RegCurTrigger( 15751 )


----------------------------------------咒语的研究结果
     MISSCRIPT_MISSIONSCRIPT02_LUA_001248 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001248")
     DefineMission(5166,MISSCRIPT_MISSIONSCRIPT02_LUA_001248,1576)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001246 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001246")
     MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001246)
     MisBeginCondition(NoRecord,1576)
      MisBeginCondition(NoMission, 1576)
     MisBeginCondition(HasRecord, 1575)
     MisBeginAction(AddMission, 1576)
     MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
     MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

     MISSCRIPT_MISSIONSCRIPT02_LUA_001249 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001249")
     MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001249)
     MISSCRIPT_MISSIONSCRIPT02_LUA_001250 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001250")
     MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001250)
      MISSCRIPT_MISSIONSCRIPT02_LUA_001251 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001251")
      MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001251)
     MisResultCondition(NoRecord, 1576)---------应改为NoRecord
     MisResultCondition(HasMission, 1576)
	 MisResultAction(AddExp,2000000,2000000)
	 MisResultAction(AddMoney,40000,40000)	
     MisResultAction(ClearMission, 1576 )
     MisResultAction(SetRecord, 1576 )




----------------------------------
--				--
--	2.0历史任务开始		--
--				--
----------------------------------


----------------------------火球的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_001252 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001252")
	DefineMission(6300, MISSCRIPT_MISSIONSCRIPT02_LUA_001252,1620)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001253 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001253")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001253)
	MisBeginCondition(NoRecord, 1620)
	MisBeginCondition(NoMission,1620)
	MisBeginCondition(LvCheck, ">",84)
	MisBeginAction(AddMission, 1620)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001254 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001254")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001254)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001255 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001255")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001255)
	MisResultCondition(AlwaysFailure)

----------------------------火球的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_001252 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001252")
	DefineMission(6301, MISSCRIPT_MISSIONSCRIPT02_LUA_001252,1620, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001256 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001256")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001256)
	MisResultCondition(NoRecord, 1620)
	MisResultCondition(HasMission, 1620)
	MisResultAction(ClearMission, 1620)
	MisResultAction(SetRecord, 1620)
	MisResultAction(AddExpAndType,2,200,200)
	HELP_ADDHELPNPC_LUA_000001 = GetResString("HELP_ADDHELPNPC_LUA_000001")
	MisResultAction(GiveNpcMission1, 6302, HELP_ADDHELPNPC_LUA_000001, 7) 
----------------------------寻找梦十夜
	MISSCRIPT_MISSIONSCRIPT02_LUA_001257 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001257")
	DefineMission(6302, MISSCRIPT_MISSIONSCRIPT02_LUA_001257,1621)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001258 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001258")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001258)
	MisBeginCondition(NoRecord, 1621)
	MisBeginCondition(NoMission,1621)
	MisBeginCondition(NoRecord, 1622)
	MisBeginCondition(HasRecord, 1620)
	MisBeginAction(AddMission, 1621)
	MisBeginAction(AddTrigger,16211, TE_GETITEM, 6206, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisBeginAction(SetFlag, 1621, 1)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001259 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001259")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001259)	
	MisNeed(MIS_NEED_ITEM, 6206, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001260 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001260")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001260)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001261 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001261")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001261)
	MisResultCondition(HasMission, 1621)
	MisResultCondition(NoRecord,1621)
	MisResultCondition(HasItem, 6206, 1)
	MisResultAction(TakeItem, 6206, 1)
	MisResultAction(ClearMission, 1621)
	MisResultAction(SetRecord, 1621)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,250,250)
	HELP_ADDHELPNPC_LUA_000001 = GetResString("HELP_ADDHELPNPC_LUA_000001")
	MisResultAction(GiveNpcMission1, 6304, HELP_ADDHELPNPC_LUA_000001, 8) 

	InitTrigger()
	TriggerCondition(1, IsItem, 6206)	
	TriggerAction(1, AddNextFlag, 1621, 10, 1)
	RegCurTrigger(16211)

----------------------------调制梦十夜
	MISSCRIPT_MISSIONSCRIPT02_LUA_001262 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001262")
	DefineMission(6303, MISSCRIPT_MISSIONSCRIPT02_LUA_001262,1622)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001263 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001263")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001263)
	MisBeginCondition(NoRecord, 1622)
	MisBeginCondition(NoMission,1622)
	MisBeginCondition(HasMission, 1621)
	MisBeginCondition(NoRecord, 1621)
	MisBeginAction(AddMission, 1622)
	MisBeginAction(SetFlag, 1622, 1)

	MisBeginAction(AddTrigger, 16221, TE_GETITEM, 4890, 1)
	MisBeginAction(AddTrigger, 16222, TE_GETITEM, 4606, 10)
	MisBeginAction(AddTrigger, 16223, TE_GETITEM, 1691, 20)
	MisBeginAction(AddTrigger, 16224, TE_GETITEM, 1779, 5)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001264 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001264")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001264)	

	MisNeed(MIS_NEED_ITEM, 4890, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 4606, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 1691, 20, 40, 20)
	MisNeed(MIS_NEED_ITEM, 1779, 5, 70, 5)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001265 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001265")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001265)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001266 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001266")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001266)
	MisBeginCondition(NoRecord, 1622)
	MisResultCondition(HasMission, 1622)
	MisResultCondition(HasItem, 4890, 1)
	MisResultCondition(HasItem, 4606, 10)
	MisResultCondition(HasItem, 1691, 20)
	MisResultCondition(HasItem, 1779, 5)

	MisResultAction(TakeItem, 4890, 1)
	MisResultAction(TakeItem, 4606, 10)
	MisResultAction(TakeItem, 1691, 20)
	MisResultAction(TakeItem, 1779, 5)

	MisResultAction(GiveItem, 6206, 1, 4)
	MisResultAction(ClearMission, 1622)
	MisResultAction(SetRecord, 1622)
	MisResultAction(AddMoney,20000,20000)

	InitTrigger()
	TriggerCondition(1, IsItem, 4890)	
	TriggerAction(1, AddNextFlag, 1622, 10, 1)
	RegCurTrigger(16221)

	InitTrigger()
	TriggerCondition(1, IsItem, 4606)	
	TriggerAction(1, AddNextFlag, 1622, 20, 10)
	RegCurTrigger(16222)

	InitTrigger()
	TriggerCondition(1, IsItem, 1691)	
	TriggerAction(1, AddNextFlag, 1622, 40, 20)
	RegCurTrigger(16223)

	InitTrigger()
	TriggerCondition(1, IsItem, 1779)	
	TriggerAction(1, AddNextFlag, 1622, 70, 5)
	RegCurTrigger(16224)


----------------------------去沙岚城询问
	MISSCRIPT_MISSIONSCRIPT02_LUA_001267 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001267")
	DefineMission(6304, MISSCRIPT_MISSIONSCRIPT02_LUA_001267,1623)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001268 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001268")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001268)
	MisBeginCondition(NoRecord, 1623)
	MisBeginCondition(NoMission,1623)
	MisBeginCondition(HasRecord, 1621)
	MisBeginAction(AddMission, 1623)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001269 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001269")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001269)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001270 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001270")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001270)
	MisResultCondition(AlwaysFailure)

----------------------------去沙岚城询问
	MISSCRIPT_MISSIONSCRIPT02_LUA_001267 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001267")
	DefineMission(6305, MISSCRIPT_MISSIONSCRIPT02_LUA_001267,1623, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001271 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001271")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001271--[[对了，你去找<j旅店老板·哈根（810，3499）>吧，他是我的朋友，知道的东西不比我少。"]])
	MisResultCondition(NoRecord, 1623)
	MisResultCondition(HasMission, 1623)
	MisResultAction(ClearMission, 1623)
	MisResultAction(SetRecord, 1623)
	MisResultAction(AddExpAndType,2,300,300)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001272 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001272")
	MisResultAction(GiveNpcMission1, 6306, MISSCRIPT_MISSIONSCRIPT02_LUA_001272, 2)

----------------------------冬岛的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_001273 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001273")
	DefineMission(6306, MISSCRIPT_MISSIONSCRIPT02_LUA_001273,1624)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001274 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001274")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001274)
	MisBeginCondition(NoRecord, 1624)
	MisBeginCondition(NoMission,1624)
	MisBeginCondition(HasRecord, 1623)
	MisBeginAction(AddMission, 1624)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001275 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001275")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001275)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001276 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001276")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001276)
	MisResultCondition(AlwaysFailure)

----------------------------冬岛的秘密
	MISSCRIPT_MISSIONSCRIPT02_LUA_001273 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001273")
	DefineMission(6307, MISSCRIPT_MISSIONSCRIPT02_LUA_001273,1624, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001277 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001277")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001277)
	MisResultCondition(NoRecord, 1624)
	MisResultCondition(HasMission, 1624)
	MisResultAction(ClearMission, 1624)
	MisResultAction(SetRecord, 1624)
	MisResultAction(AddExpAndType,2,350,350)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001278 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001278")
	MisResultAction(GiveNpcMission1, 6308, MISSCRIPT_MISSIONSCRIPT02_LUA_001278,15)
----------------------------神秘的父神维尔
	MISSCRIPT_MISSIONSCRIPT02_LUA_001279 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001279")
	DefineMission(6308, MISSCRIPT_MISSIONSCRIPT02_LUA_001279,1625)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001280 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001280")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001280)
	MisBeginCondition(NoRecord, 1625)
	MisBeginCondition(NoMission,1625)
	MisBeginCondition(NoRecord, 1626)
	MisBeginCondition(HasRecord, 1624)
	MisBeginAction(AddMission, 1625)
	MisBeginAction(AddTrigger,16251, TE_GETITEM,4301, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001281 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001281")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001281)	
	MisNeed(MIS_NEED_ITEM, 4301, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001282 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001282")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001282)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001283 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001283")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001283)
	MisResultCondition(HasMission, 1625)
	MisResultCondition(NoRecord,1625)
	MisResultCondition(HasItem, 4301, 1)
	MisResultAction(TakeItem, 4301, 1)
	MisResultAction(ClearMission, 1625)
	MisResultAction(SetRecord, 1625)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,400,400)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001278 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001278")
	MisResultAction(GiveNpcMission1, 6310, MISSCRIPT_MISSIONSCRIPT02_LUA_001278,16)
	
	InitTrigger()
	TriggerCondition(1, IsItem, 4301)	
	TriggerAction(1, AddNextFlag, 1625, 10, 1)
	RegCurTrigger(16251)

----------------------------不安的魔方世界
	MISSCRIPT_MISSIONSCRIPT02_LUA_001284 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001284")
	DefineMission(6309, MISSCRIPT_MISSIONSCRIPT02_LUA_001284,1626)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001285 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001285")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001285)
	MisBeginCondition(NoRecord, 1626)
	MisBeginCondition(NoMission,1626)
	MisBeginCondition(HasMission, 1625)
	MisBeginCondition(NoRecord, 1625)
	MisBeginAction(AddMission, 1626)

	MisBeginAction(AddTrigger, 16261, TE_KILL, 559, 50)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001286 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001286")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001286)	

	MisNeed(MIS_NEED_KILL, 559, 50, 10, 50)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001287 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001287")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001287)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001288 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001288")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001288)

	MisBeginCondition(NoRecord, 1626)
	MisResultCondition(HasMission, 1626)
	MisResultCondition(HasFlag, 1626, 59)
	MisResultAction(GiveItem, 4301, 1, 4)
	MisResultAction(ClearMission, 1626)
	MisResultAction(SetRecord, 1626)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,450,450)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition( 1, IsMonster, 559 )
	TriggerAction( 1, AddNextFlag, 1626, 10, 50 )
	RegCurTrigger( 16261 )

----------------------------维尔的下落一
	MISSCRIPT_MISSIONSCRIPT02_LUA_001289 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001289")
	DefineMission(6310, MISSCRIPT_MISSIONSCRIPT02_LUA_001289,1627)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001290 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001290")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001290)
	MisBeginCondition(NoRecord, 1627)
	MisBeginCondition(NoMission,1627)
	MisBeginCondition(HasRecord, 1625)
	MisBeginAction(AddMission, 1627)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001291 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001291")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001291)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001292 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001292")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001292)
	MisResultCondition(AlwaysFailure)

----------------------------维尔的下落一
	MISSCRIPT_MISSIONSCRIPT02_LUA_001289 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001289")
	DefineMission(6311, MISSCRIPT_MISSIONSCRIPT02_LUA_001289,1627, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001293 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001293")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001293)
	MisResultCondition(NoRecord, 1627)
	MisResultCondition(HasMission, 1627)
	MisResultAction(ClearMission, 1627)
	MisResultAction(SetRecord, 1627)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001294 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001294")
	MisResultAction(GiveNpcMission1, 6312, MISSCRIPT_MISSIONSCRIPT02_LUA_001294, 17)
----------------------------维尔的下落二
	MISSCRIPT_MISSIONSCRIPT02_LUA_001295 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001295")
	DefineMission(6312, MISSCRIPT_MISSIONSCRIPT02_LUA_001295,1628)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001296 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001296")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001296)
	MisBeginCondition(NoRecord, 1628)
	MisBeginCondition(NoMission,1628)
	MisBeginCondition(HasRecord, 1627)
	MisBeginAction(AddMission, 1628)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001297 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001297")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001297)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001298 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001298")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001298)
	MisResultCondition(AlwaysFailure)

----------------------------维尔的下落二
	MISSCRIPT_MISSIONSCRIPT02_LUA_001295 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001295")
	DefineMission(6313, MISSCRIPT_MISSIONSCRIPT02_LUA_001295,1628, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001299 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001299")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001299)
	MisResultCondition(NoRecord, 1628)
	MisResultCondition(HasMission, 1628)
	MisResultAction(ClearMission, 1628)
	MisResultAction(SetRecord, 1628)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001300 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001300")
	MisResultAction(GiveNpcMission1, 6314, MISSCRIPT_MISSIONSCRIPT02_LUA_001300, 7)
----------------------------杰里米的刁难
	MISSCRIPT_MISSIONSCRIPT02_LUA_001301 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001301")
	DefineMission(6314, MISSCRIPT_MISSIONSCRIPT02_LUA_001301,1629)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001302 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001302")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001302)
	MisBeginCondition(NoRecord, 1629)
	MisBeginCondition(NoMission,1629)
	MisBeginCondition(HasRecord, 1628)
	MisBeginAction(AddMission, 1629)
	MisBeginAction(AddTrigger,16291, TE_GETITEM,3116, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001303 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001303")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001303)	
	MisNeed(MIS_NEED_ITEM, 3116, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001304 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001304")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001304)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001305 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001305")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001305)
	MisResultCondition(HasMission, 1629)
	MisResultCondition(NoRecord,1629)
	MisResultCondition(HasItem, 3116, 20)
	MisResultAction(TakeItem, 3116, 20)
	MisResultAction(ClearMission, 1629)
	MisResultAction(SetRecord, 1629)
	MisResultAction(AddMoney,20000,20000)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001300 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001300")
	MisResultAction(GiveNpcMission1, 6315, MISSCRIPT_MISSIONSCRIPT02_LUA_001300, 8)
	InitTrigger()
	TriggerCondition(1, IsItem, 3116)	
	TriggerAction(1, AddNextFlag, 1629, 10, 20)
	RegCurTrigger(16291)

----------------------------杰里米的书信
	MISSCRIPT_MISSIONSCRIPT02_LUA_001306 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001306")
	DefineMission(6315, MISSCRIPT_MISSIONSCRIPT02_LUA_001306,1630)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001307 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001307")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001307)
	MisBeginCondition(NoRecord, 1630)
	MisBeginCondition(NoMission,1630)
	MisBeginCondition(HasRecord, 1629)
	MisBeginAction(AddMission, 1630)
	MisBeginAction(GiveItem, 6207, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001308 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001308")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001308)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001309 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001309")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001309)
	MisResultCondition(AlwaysFailure)

----------------------------杰里米的书信
	MISSCRIPT_MISSIONSCRIPT02_LUA_001306 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001306")
	DefineMission(6316, MISSCRIPT_MISSIONSCRIPT02_LUA_001306,1630, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001310 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001310")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001310)
	MisResultCondition(NoRecord, 1630)
	MisResultCondition(HasMission, 1630)
	MisResultCondition(HasItem, 6207, 1)
	MisResultAction(TakeItem, 6207, 1)
	MisResultAction(ClearMission, 1630)
	MisResultAction(SetRecord, 1630)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000151 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000151")
	MisResultAction(GiveNpcMission1, 6317, MISSCRIPT_MISSIONSCRIPT02_LUA_000151, 17)

----------------------------前往春风镇
	MISSCRIPT_MISSIONSCRIPT02_LUA_001311 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001311")
	DefineMission(6317, MISSCRIPT_MISSIONSCRIPT02_LUA_001311,1631)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001312 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001312")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001312)
	MisBeginCondition(NoRecord, 1631)
	MisBeginCondition(NoMission,1631)
	MisBeginCondition(HasRecord, 1630)
	MisBeginAction(AddMission, 1631)
	MisBeginAction(GiveItem, 6208, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001313 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001313")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001313)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001314 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001314")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001314)
	MisResultCondition(AlwaysFailure)

----------------------------前往春风镇
	MISSCRIPT_MISSIONSCRIPT02_LUA_001311 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001311")
	DefineMission(6318, MISSCRIPT_MISSIONSCRIPT02_LUA_001311,1631, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001315 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001315")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001315)
	MisResultCondition(NoRecord, 1631)
	MisResultCondition(HasMission, 1631)
	MisResultCondition(HasItem, 6208, 1)
	MisResultAction(TakeItem, 6208, 1)
	MisResultAction(ClearMission, 1631)
	MisResultAction(SetRecord, 1631) 
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001316 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001316")
	MisResultAction(GiveNpcMission1, 6319, MISSCRIPT_MISSIONSCRIPT02_LUA_001316, 4)

----------------------------水雾的嫉妒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001317 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001317")
	DefineMission(6319, MISSCRIPT_MISSIONSCRIPT02_LUA_001317,1632)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001318 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001318")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001318)
	MisBeginCondition(NoRecord, 1632)
	MisBeginCondition(NoMission,1632)
	MisBeginCondition(HasRecord, 1631)
	MisBeginAction(AddMission, 1632)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001319 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001319")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001319)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001320 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001320")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001320)
	MisResultCondition(AlwaysFailure)
	
----------------------------水雾的嫉妒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001317 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001317")
	DefineMission(6320, MISSCRIPT_MISSIONSCRIPT02_LUA_001317,1632, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001321 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001321")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001321)
	MisResultCondition(NoRecord, 1632)
	MisResultCondition(HasMission, 1632)
	MisResultAction(ClearMission, 1632)
	MisResultAction(SetRecord, 1632)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001322 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001322")
	MisResultAction(GiveNpcMission1, 6321, MISSCRIPT_MISSIONSCRIPT02_LUA_001322, 6)
----------------------------流云的烦恼
	MISSCRIPT_MISSIONSCRIPT02_LUA_001323 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001323")
	DefineMission(6321, MISSCRIPT_MISSIONSCRIPT02_LUA_001323,1633)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001324 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001324")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001324)
	MisBeginCondition(NoRecord, 1633)
	MisBeginCondition(NoMission,1633)
	MisBeginCondition(HasRecord, 1632)
	MisBeginAction(AddMission, 1633)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001325 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001325")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001325)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001326 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001326")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001326)
	MisResultCondition(AlwaysFailure)

----------------------------流云的烦恼
	MISSCRIPT_MISSIONSCRIPT02_LUA_001323 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001323")
	DefineMission(6322, MISSCRIPT_MISSIONSCRIPT02_LUA_001323,1633, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001327 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001327")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001327)
	MisResultCondition(NoRecord, 1633)
	MisResultCondition(HasMission, 1633)
	MisResultAction(ClearMission, 1633)
	MisResultAction(SetRecord, 1633)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001328 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001328")
	MisResultAction(GiveNpcMission1, 6323, MISSCRIPT_MISSIONSCRIPT02_LUA_001328, 2)
----------------------------导游的请求
	MISSCRIPT_MISSIONSCRIPT02_LUA_001329 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001329")
	DefineMission(6323, MISSCRIPT_MISSIONSCRIPT02_LUA_001329,1634)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001330 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001330")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001330)
	MisBeginCondition(NoRecord, 1634)
	MisBeginCondition(NoMission,1634)
	MisBeginCondition(HasRecord, 1633)
	MisBeginAction(AddMission, 1634)

	MisBeginAction(AddTrigger, 16341, TE_KILL, 734, 25)
	MisBeginAction(AddTrigger, 16342, TE_KILL, 735, 30)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001331 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001331")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001331)	

	MisNeed(MIS_NEED_KILL, 734, 25, 10, 25)
	MisNeed(MIS_NEED_KILL, 735, 30, 40, 30)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001332 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001332")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001332)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001333 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001333")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001333)

	MisBeginCondition(NoRecord, 1634)
	MisResultCondition(HasMission, 1634)
	MisResultCondition(HasFlag, 1634, 34)

	MisResultCondition(HasFlag, 1634, 69)
	MisResultAction(ClearMission, 1634)
	MisResultAction(SetRecord, 1634)
	MisResultAction(AddMoney,20000,20000)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001328 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001328")
	MisResultAction(GiveNpcMission1, 6324, MISSCRIPT_MISSIONSCRIPT02_LUA_001328, 3)
	InitTrigger()
	TriggerCondition(1, IsMonster, 734)
	TriggerAction(1, AddNextFlag, 1634, 10, 25)
	RegCurTrigger(16341)

	InitTrigger()
	TriggerCondition(1, IsMonster, 735)
	TriggerAction(1, AddNextFlag, 1634, 40, 30)
	RegCurTrigger(16342)


----------------------------导游的爱慕
	MISSCRIPT_MISSIONSCRIPT02_LUA_001334 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001334")
	DefineMission(6324, MISSCRIPT_MISSIONSCRIPT02_LUA_001334,1635)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001335 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001335")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001335)
	MisBeginCondition(NoRecord, 1635)
	MisBeginCondition(NoMission,1635)
	MisBeginCondition(HasRecord, 1634)
	MisBeginAction(AddMission, 1635)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001336 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001336")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001336)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001337 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001337")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001337)
	MisResultCondition(AlwaysFailure)
	
----------------------------导游的爱慕
	MISSCRIPT_MISSIONSCRIPT02_LUA_001334 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001334")
	DefineMission(6325, MISSCRIPT_MISSIONSCRIPT02_LUA_001334,1635, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001338 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001338")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001338)
	MisResultCondition(NoRecord, 1635)
	MisResultCondition(HasMission, 1635)
	MisResultAction(ClearMission, 1635)
	MisResultAction(SetRecord, 1635)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001339 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001339")
	MisResultAction(GiveNpcMission1, 6326, MISSCRIPT_MISSIONSCRIPT02_LUA_001339, 2)

----------------------------前往冬岛
	MISSCRIPT_MISSIONSCRIPT02_LUA_001340 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001340")
	DefineMission(6326, MISSCRIPT_MISSIONSCRIPT02_LUA_001340,1636)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001341 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001341")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001341)
	MisBeginCondition(NoRecord, 1636)
	MisBeginCondition(NoMission,1636)
	MisBeginCondition(HasRecord, 1635)
	MisBeginAction(AddMission, 1636)
	MisBeginAction(AddTrigger,16361, TE_GETITEM,3362, 10)
	MisBeginAction(AddTrigger,16362, TE_GETITEM,4848, 10)
	MisBeginAction(AddTrigger,16363, TE_GETITEM,3366, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001342 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001342")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001342)	
	MisNeed(MIS_NEED_ITEM, 3362, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 4848, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 3366, 10, 30, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001343 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001343")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001343)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001344 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001344")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001344)
	MisResultCondition(HasMission, 1636)
	MisResultCondition(NoRecord,1636)
	MisResultCondition(HasItem, 3362, 10)
	MisResultCondition(HasItem, 4848, 10)
	MisResultCondition(HasItem, 3366, 10)
	MisResultAction(TakeItem, 3362, 10)
	MisResultAction(TakeItem, 4848, 10)
	MisResultAction(TakeItem, 3366, 10)
	MisResultAction(ClearMission, 1636)
	MisResultAction(SetRecord, 1636)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,500,500)

	InitTrigger()
	TriggerCondition(1, IsItem, 3362)	
	TriggerAction(1, AddNextFlag, 1636, 10, 10)
	RegCurTrigger(16361)

	InitTrigger()
	TriggerCondition(1, IsItem, 4848)	
	TriggerAction(1, AddNextFlag, 1636, 20, 10)
	RegCurTrigger(16362)

	InitTrigger()
	TriggerCondition(1, IsItem, 3366)	
	TriggerAction(1, AddNextFlag, 1636, 30, 10)
	RegCurTrigger(16363)

----------------------------冬岛探密
	MISSCRIPT_MISSIONSCRIPT02_LUA_001345 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001345")
	DefineMission(6327, MISSCRIPT_MISSIONSCRIPT02_LUA_001345,1637)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001346 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001346")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001346)
	MisBeginCondition(NoRecord, 1637)
	MisBeginCondition(NoMission,1637)
	MisBeginCondition(HasRecord, 1636)
	MisBeginCondition(NoRecord, 1638)
	MisBeginCondition(NoRecord, 1639)
	MisBeginCondition(NoRecord, 1640)
	MisBeginCondition(NoRecord, 1641)
	MisBeginAction(AddMission, 1637)
	MisBeginAction(AddTrigger,16371, TE_GETITEM,6209, 1)
	MisBeginAction(AddTrigger,16372, TE_GETITEM,6210, 1)
	MisBeginAction(AddTrigger,16373, TE_GETITEM,6211, 1)
	MisBeginAction(AddTrigger,16374, TE_GETITEM,6212, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001347 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001347")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001347)	
	MisNeed(MIS_NEED_ITEM, 6209, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 6210, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 6211, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 6212, 1, 40, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001348 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001348")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001348)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001349 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001349")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001349)
	MisResultCondition(HasMission, 1637)
	MisResultCondition(NoRecord,1637)
	MisResultCondition(HasItem, 6209, 1)
	MisResultCondition(HasItem, 6210, 1)
	MisResultCondition(HasItem, 6211, 1)
	MisResultCondition(HasItem, 6212, 1)
	MisResultAction(TakeItem, 6209, 1)
	MisResultAction(TakeItem, 6210, 1)
	MisResultAction(TakeItem, 6211, 1)
	MisResultAction(TakeItem, 6212, 1)
	MisResultAction(ClearMission, 1637)
	MisResultAction(SetRecord, 1637)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001350 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001350")
	MisResultAction(GiveNpcMission1, 6332, MISSCRIPT_MISSIONSCRIPT02_LUA_001350,2)

	InitTrigger()
	TriggerCondition(1, IsItem, 6209)	
	TriggerAction(1, AddNextFlag, 1637, 10, 1)
	RegCurTrigger(16371)

	InitTrigger()
	TriggerCondition(1, IsItem, 6210)	
	TriggerAction(1, AddNextFlag, 1637, 20, 1)
	RegCurTrigger(16372)

	InitTrigger()
	TriggerCondition(1, IsItem, 6211)
	TriggerAction(1, AddNextFlag, 1637, 30, 1)
	RegCurTrigger(16373)

	InitTrigger()
	TriggerCondition(1, IsItem, 6212)	
	TriggerAction(1, AddNextFlag, 1637, 40, 1)
	RegCurTrigger(16374)

----------------------------威斯特的请求
	MISSCRIPT_MISSIONSCRIPT02_LUA_001351 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001351")
	DefineMission(6328, MISSCRIPT_MISSIONSCRIPT02_LUA_001351,1638)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001352 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001352")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001352)
	MisBeginCondition(NoRecord, 1638)
	MisBeginCondition(NoMission,1638)
	MisBeginCondition(HasMission, 1637)
	MisBeginCondition(NoRecord, 1637)
	MisBeginAction(AddMission, 1638)

	MisBeginAction(AddTrigger, 16381, TE_KILL, 1090, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001353 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001353")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001353)	

	MisNeed(MIS_NEED_KILL, 1090, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001354 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001354")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001354)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001355 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001355")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001355)

	MisBeginCondition(NoRecord, 1638)
	MisResultCondition(HasMission, 1638)
	MisResultCondition(HasFlag, 1638, 29)
	MisResultAction(GiveItem, 6209, 1, 4)
	MisResultAction(ClearMission, 1638)
	MisResultAction(SetRecord, 1638)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,400,400)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1090)
	TriggerAction(1, AddNextFlag, 1638, 10, 20)
	RegCurTrigger(16381)

----------------------------克里斯的请求
	MISSCRIPT_MISSIONSCRIPT02_LUA_001356 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001356")
	DefineMission(6329, MISSCRIPT_MISSIONSCRIPT02_LUA_001356,1639)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001357 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001357")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001357)
	MisBeginCondition(NoRecord, 1639)
	MisBeginCondition(NoMission,1639)
	MisBeginCondition(HasMission, 1637)
	MisBeginCondition(NoRecord, 1637)
	MisBeginAction(AddMission, 1639)

	MisBeginAction(AddTrigger, 16391, TE_KILL, 1091, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001358 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001358")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001358)	

	MisNeed(MIS_NEED_KILL, 1091, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001354 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001354")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001354)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001355 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001355")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001355)

	MisBeginCondition(NoRecord, 1639)
	MisResultCondition(HasMission, 1639)
	MisResultCondition(HasFlag, 1639, 29)
	MisResultAction(GiveItem, 6210, 1, 4)
	MisResultAction(ClearMission, 1639)
	MisResultAction(SetRecord, 1639)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,400,400)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1091)
	TriggerAction(1, AddNextFlag, 1639, 10, 20)
	RegCurTrigger(16391)

----------------------------里昂的答复
	MISSCRIPT_MISSIONSCRIPT02_LUA_001359 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001359")
	DefineMission(6330, MISSCRIPT_MISSIONSCRIPT02_LUA_001359,1640)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001360 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001360")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001360)
	MisBeginCondition(NoRecord, 1640)
	MisBeginCondition(NoMission,1640)
	MisBeginCondition(HasMission, 1637)
	MisBeginCondition(NoRecord, 1637)
	MisBeginAction(AddMission, 1640)

	MisBeginAction(AddTrigger, 16401, TE_KILL, 1085, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001361 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001361")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001361)	

	MisNeed(MIS_NEED_KILL, 1085, 20, 10, 29)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001354 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001354")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001354)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001362 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001362")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001362)

	MisBeginCondition(NoRecord, 1640)
	MisResultCondition(HasMission, 1640)
	MisResultCondition(HasFlag, 1640, 29)
	MisResultAction(GiveItem, 6211, 1, 4)
	MisResultAction(ClearMission, 1640)
	MisResultAction(SetRecord, 1640)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,400,400)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1085)
	TriggerAction(1, AddNextFlag, 1640, 10, 20)
	RegCurTrigger(16401)

----------------------------吉尔的答复
	MISSCRIPT_MISSIONSCRIPT02_LUA_001363 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001363")
	DefineMission(6331, MISSCRIPT_MISSIONSCRIPT02_LUA_001363,1641)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001364 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001364")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001364)
	MisBeginCondition(NoRecord, 1641)
	MisBeginCondition(NoMission,1641)
	MisBeginCondition(HasMission, 1637)
	MisBeginCondition(NoRecord, 1637)
	MisBeginAction(AddMission, 1641)

	MisBeginAction(AddTrigger, 16411, TE_KILL, 1086, 20)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001365 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001365")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001365)	

	MisNeed(MIS_NEED_KILL, 1086, 20, 10, 20)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001354 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001354")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001354)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001366 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001366")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001366)

	MisBeginCondition(NoRecord, 1641)
	MisResultCondition(HasMission, 1641)
	MisResultCondition(HasFlag, 1641, 29)
	MisResultAction(GiveItem, 6212, 1, 4)
	MisResultAction(ClearMission, 1641)
	MisResultAction(SetRecord, 1641)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,400,400)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1086)
	TriggerAction(1, AddNextFlag, 1641, 10, 20)
	RegCurTrigger(16411)

----------------------------考古学家的疑问
	MISSCRIPT_MISSIONSCRIPT02_LUA_001367 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001367")
	DefineMission(6332, MISSCRIPT_MISSIONSCRIPT02_LUA_001367,1642)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001368 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001368")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001368)
	MisBeginCondition(NoRecord, 1642)
	MisBeginCondition(NoMission,1642)
	MisBeginCondition(HasRecord, 1637)
	MisBeginAction(AddMission, 1642)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001369 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001369")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001369)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001370 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001370")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001370)
	MisResultCondition(AlwaysFailure)

----------------------------考古学家的疑问
	MISSCRIPT_MISSIONSCRIPT02_LUA_001367 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001367")
	DefineMission(6333, MISSCRIPT_MISSIONSCRIPT02_LUA_001367,1642, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001371 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001371")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001371)
	MisResultCondition(NoRecord, 1642)
	MisResultCondition(HasMission, 1642)
	MisResultAction(ClearMission, 1642)
	MisResultAction(SetRecord, 1642)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001372 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001372")
	MisResultAction(GiveNpcMission1, 6334, MISSCRIPT_MISSIONSCRIPT02_LUA_001372, 2)

----------------------------守护者的指引一
	MISSCRIPT_MISSIONSCRIPT02_LUA_001373 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001373")
	DefineMission(6334, MISSCRIPT_MISSIONSCRIPT02_LUA_001373,1643)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001374 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001374")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001374)
	MisBeginCondition(NoRecord, 1643)
	MisBeginCondition(NoMission,1643)
	MisBeginCondition(HasRecord, 1642)
	MisBeginAction(AddMission, 1643)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001375 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001375")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001375)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001376 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001376")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001376)
	MisResultCondition(AlwaysFailure)

----------------------------守护者的指引一
	MISSCRIPT_MISSIONSCRIPT02_LUA_001373 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001373")
	DefineMission(6335, MISSCRIPT_MISSIONSCRIPT02_LUA_001373,1643, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001377 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001377")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001377)
	MisResultCondition(NoRecord, 1643)
	MisResultCondition(HasMission, 1643)
	MisResultAction(ClearMission, 1643)
	MisResultAction(SetRecord, 1643)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001378 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001378")
	MisResultAction(GiveNpcMission1, 6336, MISSCRIPT_MISSIONSCRIPT02_LUA_001378, 2)

----------------------------守护者的指引二
	MISSCRIPT_MISSIONSCRIPT02_LUA_001379 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001379")
	DefineMission(6336, MISSCRIPT_MISSIONSCRIPT02_LUA_001379,1644)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001380 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001380")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001380)
	MisBeginCondition(NoRecord, 1644)
	MisBeginCondition(NoMission,1644)
	MisBeginCondition(HasRecord, 1643)
	MisBeginAction(AddMission, 1644)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001381 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001381")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001381)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001382 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001382")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001382)
	MisResultCondition(AlwaysFailure)

----------------------------守护者的指引二
	MISSCRIPT_MISSIONSCRIPT02_LUA_001379 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001379")
	DefineMission(6337, MISSCRIPT_MISSIONSCRIPT02_LUA_001379,1644, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001383 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001383")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001383)
	MisResultCondition(NoRecord, 1644)
	MisResultCondition(HasMission, 1644)
	MisResultAction(ClearMission, 1644)
	MisResultAction(SetRecord, 1644)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001378 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001378")
	MisResultAction(GiveNpcMission1, 6338, MISSCRIPT_MISSIONSCRIPT02_LUA_001378, 2)

----------------------------守护者的考验一
	MISSCRIPT_MISSIONSCRIPT02_LUA_001384 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001384")
	DefineMission(6338, MISSCRIPT_MISSIONSCRIPT02_LUA_001384,1645)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001385 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001385")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001385)
	MisBeginCondition(NoRecord, 1645)
	MisBeginCondition(NoMission,1645)
	MisBeginCondition(HasRecord, 1644)
	MisBeginAction(AddMission, 1645)

	MisBeginAction(AddTrigger, 16451, TE_KILL, 1083, 30)
	MisBeginAction(AddTrigger, 16452, TE_KILL, 1084, 35)
	MisBeginAction(AddTrigger, 16453, TE_KILL, 1086, 25)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001386 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001386")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001386)

	MisNeed(MIS_NEED_KILL, 1083, 30, 10, 30)
	MisNeed(MIS_NEED_KILL, 1084, 35, 50, 35)
	MisNeed(MIS_NEED_KILL, 1086, 25, 90, 25)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001387 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001387")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001387)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001388 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001388")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001388)

	MisBeginCondition(NoRecord, 1645)
	MisResultCondition(HasMission, 1645)
	MisResultCondition(HasFlag, 1645, 39)
	MisResultCondition(HasFlag, 1645, 84)
	MisResultCondition(HasFlag, 1645, 114)
	MisResultAction(ClearMission, 1645)
	MisResultAction(SetRecord, 1645)
	MisResultAction(AddMoney,30000,30000)
	MisResultAction(AddExpAndType,2,550,550)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001378 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001378")
	MisResultAction(GiveNpcMission1, 6339, MISSCRIPT_MISSIONSCRIPT02_LUA_001378, 3)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1083)
	TriggerAction(1, AddNextFlag, 1645, 10, 30)
	RegCurTrigger(16451)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1084)
	TriggerAction(1, AddNextFlag, 1645, 50, 35)
	RegCurTrigger(16452)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1086)
	TriggerAction(1, AddNextFlag, 1645, 90, 25)
	RegCurTrigger(16453)

----------------------------守护者的考验二
	MISSCRIPT_MISSIONSCRIPT02_LUA_001389 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001389")
	DefineMission(6339, MISSCRIPT_MISSIONSCRIPT02_LUA_001389,1646)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001390 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001390")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001390)
	MisBeginCondition(NoRecord, 1646)
	MisBeginCondition(NoMission,1646)
	MisBeginCondition(HasRecord, 1645)
	MisBeginAction(AddMission, 1646)
	MisBeginAction(AddTrigger,16461, TE_GETITEM,6237, 10)
	MisBeginAction(AddTrigger,16462, TE_GETITEM,1201, 10)
	MisBeginAction(AddTrigger,16463, TE_GETITEM,6240, 10)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001391 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001391")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001391)	
	MisNeed(MIS_NEED_ITEM, 6237, 10, 10, 10)
	MisNeed(MIS_NEED_ITEM, 1201, 10, 20, 10)
	MisNeed(MIS_NEED_ITEM, 6240, 10, 30, 10)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001387 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001387")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001387)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001392 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001392")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001392)
	MisResultCondition(HasMission, 1646)
	MisResultCondition(NoRecord,1646)
	MisResultCondition(HasItem, 6237, 10)
	MisResultCondition(HasItem, 1201, 10)
	MisResultCondition(HasItem, 6240, 10)
	MisResultAction(TakeItem, 6237, 10)
	MisResultAction(TakeItem, 1201, 10)
	MisResultAction(TakeItem, 6240, 10)
	MisResultAction(ClearMission, 1646)
	MisResultAction(SetRecord, 1646)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,550,550)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001378 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001378")
	MisResultAction(GiveNpcMission1, 6340, MISSCRIPT_MISSIONSCRIPT02_LUA_001378, 4)

	InitTrigger()
	TriggerCondition(1, IsItem, 6237)	
	TriggerAction(1, AddNextFlag, 1646, 10, 10)
	RegCurTrigger(16461)

	InitTrigger()
	TriggerCondition(1, IsItem, 1201)	
	TriggerAction(1, AddNextFlag, 1646, 20, 10)
	RegCurTrigger(16462)

	InitTrigger()
	TriggerCondition(1, IsItem, 6240)	
	TriggerAction(1, AddNextFlag, 1646, 30, 10)
	RegCurTrigger(16463)


----------------------------守护者的担忧
	MISSCRIPT_MISSIONSCRIPT02_LUA_001393 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001393")
	DefineMission(6340, MISSCRIPT_MISSIONSCRIPT02_LUA_001393,1647)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001394 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001394")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001394)
	MisBeginCondition(NoRecord, 1647)
	MisBeginCondition(NoMission,1647)
	MisBeginCondition(HasRecord, 1646)
	MisBeginAction(AddMission, 1647)
	MisBeginAction(GiveItem, 6213, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001395 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001395")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001395)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001396 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001396")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001396)
	MisResultCondition(AlwaysFailure)

----------------------------守护者的担忧
	MISSCRIPT_MISSIONSCRIPT02_LUA_001393 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001393")
	DefineMission(6341, MISSCRIPT_MISSIONSCRIPT02_LUA_001393,1647, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001397 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001397")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001397)
	MisResultCondition(NoRecord, 1647)
	MisResultCondition(HasMission, 1647)
	MisResultCondition(HasItem, 6213, 1)
	MisResultAction(TakeItem, 6213, 1)
	MisResultAction(ClearMission, 1647)
	MisResultAction(SetRecord, 1647)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001398")
	MisResultAction(GiveNpcMission1, 6342, MISSCRIPT_MISSIONSCRIPT02_LUA_001398, 2)

----------------------------维尔的悲哀
	MISSCRIPT_MISSIONSCRIPT02_LUA_001399 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001399")
	DefineMission(6342, MISSCRIPT_MISSIONSCRIPT02_LUA_001399,1648)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001400 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001400")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001400)
	MisBeginCondition(NoRecord, 1648)
	MisBeginCondition(NoMission,1648)
	MisBeginCondition(HasRecord, 1647)
	MisBeginAction(AddMission, 1648)

	MisBeginAction(AddTrigger, 16481, TE_GETITEM, 6200, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001401 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001401")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001401)	

	MisNeed(MIS_NEED_ITEM, 6200, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001402 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001402")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001402)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001403 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001403")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001403)
	MisBeginCondition(NoRecord, 1648)
	MisResultCondition(HasMission, 1648)
	MisResultCondition(HasItem, 6200, 1)
	MisResultAction(TakeItem, 6200, 1)
	MisResultAction(GiveItem, 6213, 1, 4)
	MisResultAction(ClearMission, 1648)
	MisResultAction(SetRecord, 1648)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,600,600)
	MisResultBagNeed(1)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001398")
	MisResultAction(GiveNpcMission1, 6809, MISSCRIPT_MISSIONSCRIPT02_LUA_001398, 1)

	InitTrigger()
	TriggerCondition(1, IsItem, 6200)	
	TriggerAction(1, AddNextFlag, 1648, 10, 1)
	RegCurTrigger(16481)
	
	
---------------------------上古文明的遗迹1
	MISSCRIPT_MISSIONSCRIPT02_LUA_001404 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001404")
	DefineMission(6809, MISSCRIPT_MISSIONSCRIPT02_LUA_001404,1979)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001405 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001405")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001405)
	MisBeginCondition(NoRecord, 1979)
	MisBeginCondition(NoMission,1979)
	MisBeginCondition(HasRecord, 1648)
	MisBeginAction(AddMission, 1979)	
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001406 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001406")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001406)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001396 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001396")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001396)
	MisResultCondition(AlwaysFailure)
---------------------------上古文明的遗迹2	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001404 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001404")
	DefineMission(6810, MISSCRIPT_MISSIONSCRIPT02_LUA_001404,1979, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001407 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001407")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001407)
	MisResultCondition(NoRecord, 1979)
	MisResultCondition(HasMission, 1979)	
	MisResultAction(ClearMission, 1979)
	MisResultAction(SetRecord, 1979)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001408 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001408")
	MisResultAction(GiveNpcMission1, 6343, MISSCRIPT_MISSIONSCRIPT02_LUA_001408, 2)
	

----------------------------冰封之岛
	MISSCRIPT_MISSIONSCRIPT02_LUA_001409 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001409")
	DefineMission(6343, MISSCRIPT_MISSIONSCRIPT02_LUA_001409,1649)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001410 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001410")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001410)
	MisBeginCondition(NoRecord, 1649)
	MisBeginCondition(NoMission,1649)
	MisBeginCondition(HasRecord, 1648)
	MisBeginCondition(HasItem, 6213, 1, 4)
	MisBeginAction(AddMission, 1649)

	MisBeginAction(AddTrigger, 16491, TE_KILL, 1095, 30)
	MisBeginAction(AddTrigger, 16492, TE_KILL, 1097, 35)
	MisBeginAction(AddTrigger, 16493, TE_KILL, 1098, 25)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001411 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001411")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001411)

	MisNeed(MIS_NEED_KILL, 1095, 30, 10, 30)
	MisNeed(MIS_NEED_KILL, 1097, 35, 50, 35)
	MisNeed(MIS_NEED_KILL, 1098, 25, 90, 25)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001412 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001412")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001412)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001413 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001413")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001413)

	MisBeginCondition(NoRecord, 1649)
	MisResultCondition(HasMission, 1649)
	MisResultCondition(HasFlag, 1649, 39)
	MisResultCondition(HasFlag, 1649, 84)
	MisResultCondition(HasFlag, 1649, 114)
	MisResultCondition (HasItem, 6213, 1)
	MisResultAction (TakeItem, 6213, 1)
	MisResultAction(ClearMission, 1649)
	MisResultAction(SetRecord, 1649)
	MisResultAction(AddMoney,30000,30000)
	MisResultAction(AddExpAndType,2,650,650)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001408 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001408")
	MisResultAction(GiveNpcMission1, 6344, MISSCRIPT_MISSIONSCRIPT02_LUA_001408, 2)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1095)
	TriggerAction(1, AddNextFlag, 1649, 10, 30)
	RegCurTrigger(16491)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1097)
	TriggerAction(1, AddNextFlag, 1649, 50, 35)
	RegCurTrigger(16492)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1098)
	TriggerAction(1, AddNextFlag, 1649, 90, 25)
	RegCurTrigger(16493)


----------------------------真爱永恒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001414 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001414")
	DefineMission(6344, MISSCRIPT_MISSIONSCRIPT02_LUA_001414,1650)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001415 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001415")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001415)
	MisBeginCondition(NoRecord, 1650)
	MisBeginCondition(NoMission,1650)
	MisBeginCondition(HasRecord, 1649)
	MisBeginCondition(NoRecord, 1651)
	MisBeginCondition(NoRecord, 1652)
	MisBeginAction(AddMission, 1650)
	MisBeginAction(AddTrigger,16501, TE_GETITEM,6214, 1)
	MisBeginAction(AddTrigger,16502, TE_GETITEM,6216, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001416 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001416")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001416)	
	MisNeed(MIS_NEED_ITEM, 6214, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 6216, 1, 20, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001417 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001417")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001417)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001418 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001418")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001418)
	MisResultCondition(HasMission, 1650)
	MisResultCondition(NoRecord,1650)
	MisResultCondition(HasItem, 6214, 1)
	MisResultCondition(HasItem, 6216, 1)
	MisResultAction(TakeItem, 6214, 1)
	MisResultAction(TakeItem, 6216, 1)
	MisResultAction(ClearMission, 1650)
	MisResultAction(SetRecord, 1650)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,600,600)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001408 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001408")
	MisResultAction(GiveNpcMission1, 6347, MISSCRIPT_MISSIONSCRIPT02_LUA_001408, 3)

	InitTrigger()
	TriggerCondition(1, IsItem, 6214)	
	TriggerAction(1, AddNextFlag, 1650, 10, 1)
	RegCurTrigger(16501)

	InitTrigger()
	TriggerCondition(1, IsItem, 6216)	
	TriggerAction(1, AddNextFlag, 1650, 20, 1)
	RegCurTrigger(16502) 

----------------------------深邃幻想
	MISSCRIPT_MISSIONSCRIPT02_LUA_001419 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001419")
	DefineMission(6345, MISSCRIPT_MISSIONSCRIPT02_LUA_001419,1651)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001420 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001420")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001420)
	MisBeginCondition(NoRecord, 1651)
	MisBeginCondition(NoMission,1651)
	MisBeginCondition(HasMission, 1650)
	MisBeginCondition(NoRecord, 1650)
	MisBeginAction(AddMission, 1651)

	MisBeginAction(AddTrigger, 16511, TE_GETITEM, 6215, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001421 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001421")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001421)	

	MisNeed(MIS_NEED_ITEM, 6215, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001422 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001422")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001422)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001423 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001423")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001423)
	MisBeginCondition(NoRecord, 1651)
	MisResultCondition(HasMission, 1651)
	MisResultCondition(HasItem, 6215, 1)
	MisResultAction(TakeItem, 6215, 1)
	MisResultAction(GiveItem, 6214, 1, 4)
	MisResultAction(ClearMission, 1651)
	MisResultAction(SetRecord, 1651)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,500,500)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsItem, 6215)	
	TriggerAction(1, AddNextFlag, 1651, 10, 1)
	RegCurTrigger(16511)

----------------------------青空幻想
	MISSCRIPT_MISSIONSCRIPT02_LUA_001424 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001424")
	DefineMission(6346, MISSCRIPT_MISSIONSCRIPT02_LUA_001424,1652)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001425 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001425")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001425)
	MisBeginCondition(NoRecord, 1652)
	MisBeginCondition(NoMission,1652)
	MisBeginCondition(HasMission, 1650)
	MisBeginCondition(NoRecord, 1650)
	MisBeginAction(AddMission, 1652)

	MisBeginAction(AddTrigger, 16521, TE_GETITEM, 6217, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001426 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001426")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001426)	

	MisNeed(MIS_NEED_ITEM, 6217, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001427 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001427")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001427)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001428 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001428")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001428)
	MisBeginCondition(NoRecord, 1652)
	MisResultCondition(HasMission, 1652)
	MisResultCondition(HasItem, 6217, 1)
	MisResultAction(TakeItem, 6217, 1)
	MisResultAction(GiveItem, 6216, 1, 4)
	MisResultAction(ClearMission, 1652)
	MisResultAction(SetRecord, 1652)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,500,500)
	MisResultBagNeed(1)

	InitTrigger()
	TriggerCondition(1, IsItem, 6217)	
	TriggerAction(1, AddNextFlag, 1652, 10, 1)
	RegCurTrigger(16521)



----------------------------海洋之心
	MISSCRIPT_MISSIONSCRIPT02_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001429")
	DefineMission(6347, MISSCRIPT_MISSIONSCRIPT02_LUA_001429,1653)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001430 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001430")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001430)
	MisBeginCondition(NoRecord, 1653)
	MisBeginCondition(NoMission,1653)
	MisBeginCondition(HasRecord, 1650)
	MisBeginAction(AddMission, 1653)
	MisBeginAction(GiveItem, 6218, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001431 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001431")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001431)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001432 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001432")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001432)
	MisResultCondition(AlwaysFailure)

----------------------------海洋之心
	MISSCRIPT_MISSIONSCRIPT02_LUA_001429 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001429")
	DefineMission(6348, MISSCRIPT_MISSIONSCRIPT02_LUA_001429,1653, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001433 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001433")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001433)
	MisResultCondition(NoRecord, 1653)
	MisResultCondition(HasMission, 1653)
	MisResultCondition(HasItem, 6218, 1)
	MisResultAction(TakeItem, 6218, 1)
	MisResultAction(ClearMission, 1653)
	MisResultAction(SetRecord, 1653)
	MisResultAction(AddExpAndType,2,400,400)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001398")
	MisResultAction(GiveNpcMission1, 6349, MISSCRIPT_MISSIONSCRIPT02_LUA_001398, 4)

----------------------------守护者的心灵
	MISSCRIPT_MISSIONSCRIPT02_LUA_001434 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001434")
	DefineMission(6349, MISSCRIPT_MISSIONSCRIPT02_LUA_001434,1654)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001435 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001435")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001435)
	MisBeginCondition(NoRecord, 1654)
	MisBeginCondition(NoMission,1654)
	MisBeginCondition(HasRecord, 1653)
	MisBeginAction(AddMission, 1654)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001436 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001436")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001436)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001437 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001437")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001437)
	MisResultCondition(AlwaysFailure)

----------------------------守护者的心灵
	MISSCRIPT_MISSIONSCRIPT02_LUA_001434 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001434")
	DefineMission(6350, MISSCRIPT_MISSIONSCRIPT02_LUA_001434,1654, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001438 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001438")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001438)
	MisResultCondition(NoRecord, 1654)
	MisResultCondition(HasMission, 1654)
	MisResultAction(ClearMission, 1654)
	MisResultAction(SetRecord, 1654)
	MisResultAction(AddExpAndType,2,400,400)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000191 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000191")
	MisResultAction(GiveNpcMission1, 6351, MISSCRIPT_MISSIONSCRIPT02_LUA_000191, 20)

----------------------------暗黑潮涌
	MISSCRIPT_MISSIONSCRIPT02_LUA_001439 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001439")
	DefineMission(6351, MISSCRIPT_MISSIONSCRIPT02_LUA_001439,1655)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001440 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001440")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001440)
	MisBeginCondition(NoRecord, 1655)
	MisBeginCondition(NoMission,1655)
	MisBeginCondition(HasRecord, 1654)
	MisBeginAction(AddMission, 1655)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001441 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001441")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001441)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001442 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001442")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001442)
	MisResultCondition(AlwaysFailure)

----------------------------暗黑潮涌
	MISSCRIPT_MISSIONSCRIPT02_LUA_001439 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001439")
	DefineMission(6352, MISSCRIPT_MISSIONSCRIPT02_LUA_001439,1655, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001443 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001443")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001443)
	MisResultCondition(NoRecord, 1655)
	MisResultCondition(HasMission, 1655)
	MisResultAction(ClearMission, 1655)
	MisResultAction(SetRecord, 1655)
	MisResultAction(AddExpAndType,2,400,400)
	MISSCRIPT_MISSIONSCRIPT02_LUA_000090 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_000090")
	MisResultAction(GiveNpcMission1, 6353, MISSCRIPT_MISSIONSCRIPT02_LUA_000090, 15)

----------------------------多事之秋
	MISSCRIPT_MISSIONSCRIPT02_LUA_001444 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001444")
	DefineMission(6353, MISSCRIPT_MISSIONSCRIPT02_LUA_001444,1656)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001445 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001445")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001445)
	MisBeginCondition(NoRecord, 1656)
	MisBeginCondition(NoMission,1656)
	MisBeginCondition(HasRecord, 1655)
	MisBeginAction(AddMission, 1656)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001446 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001446")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001446)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001447 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001447")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001447)
	MisResultCondition(AlwaysFailure)

----------------------------多事之秋
	MISSCRIPT_MISSIONSCRIPT02_LUA_001444 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001444")
	DefineMission(6354, MISSCRIPT_MISSIONSCRIPT02_LUA_001444,1656, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001448 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001448")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001448)
	MisResultCondition(NoRecord, 1656)
	MisResultCondition(HasMission, 1656)
	MisResultAction(ClearMission, 1656)
	MisResultAction(SetRecord, 1656)
	MisResultAction(AddExpAndType,2,400,400)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001449 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001449")
	MisResultAction(GiveNpcMission1, 6355, MISSCRIPT_MISSIONSCRIPT02_LUA_001449, 11)

----------------------------王子的新衣
	MISSCRIPT_MISSIONSCRIPT02_LUA_001450 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001450")
	DefineMission(6355, MISSCRIPT_MISSIONSCRIPT02_LUA_001450,1657)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001451 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001451")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001451)
	MisBeginCondition(NoRecord, 1657)
	MisBeginCondition(NoMission,1657)
	MisBeginCondition(HasRecord, 1656)
	MisBeginAction(AddMission, 1657)

	MisBeginAction(AddTrigger, 16571, TE_GETITEM, 0400, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001452 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001452")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001452)	

	MisNeed(MIS_NEED_ITEM, 0400, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001453 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001453")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001453)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001454 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001454")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001454)
	MisBeginCondition(NoRecord, 1657)
	MisResultCondition(HasMission, 1657)
	MisResultCondition(HasItem, 0400, 1)
	MisResultAction(TakeItem, 0400, 1)
	MisResultAction(ClearMission, 1657)
	MisResultAction(SetRecord, 1657)
	MisResultAction(AddMoney,20000,20000)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001449 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001449")
	MisResultAction(GiveNpcMission1, 6356, MISSCRIPT_MISSIONSCRIPT02_LUA_001449, 12)

	InitTrigger()
	TriggerCondition(1, IsItem, 0400)	
	TriggerAction(1, AddNextFlag, 1657, 10, 1)
	RegCurTrigger(16571)

----------------------------人鱼之祸
	MISSCRIPT_MISSIONSCRIPT02_LUA_001455 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001455")
	DefineMission(6356, MISSCRIPT_MISSIONSCRIPT02_LUA_001455,1658)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001456 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001456")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001456)
	MisBeginCondition(NoRecord, 1658)
	MisBeginCondition(NoMission,1658)
	MisBeginCondition(HasRecord, 1657)
	MisBeginAction(AddMission, 1658)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001457 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001457")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001457)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001458 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001458")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001458)
	MisResultCondition(AlwaysFailure)

----------------------------人鱼之祸
	MISSCRIPT_MISSIONSCRIPT02_LUA_001455 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001455")
	DefineMission(6357, MISSCRIPT_MISSIONSCRIPT02_LUA_001455,1658, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001459 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001459")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001459)
	MisResultCondition(NoRecord, 1658)
	MisResultCondition(HasMission, 1658)
	MisResultAction(ClearMission, 1658)
	MisResultAction(SetRecord, 1658)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001460 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001460")
	MisResultAction(GiveNpcMission1, 6358, MISSCRIPT_MISSIONSCRIPT02_LUA_001460, 13)

----------------------------加勒比的异变
	MISSCRIPT_MISSIONSCRIPT02_LUA_001461 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001461")
	DefineMission(6358, MISSCRIPT_MISSIONSCRIPT02_LUA_001461,1659)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001462 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001462")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001462)
	MisBeginCondition(NoRecord, 1659)
	MisBeginCondition(NoMission,1659)
	MisBeginCondition(HasRecord, 1658)
	MisBeginAction(AddMission, 1659)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001463 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001463")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001463)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001464 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001464")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001464)
	MisResultCondition(AlwaysFailure)

----------------------------加勒比的异变
	MISSCRIPT_MISSIONSCRIPT02_LUA_001461 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001461")
	DefineMission(6359, MISSCRIPT_MISSIONSCRIPT02_LUA_001461,1659, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001465 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001465")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001465)
	MisResultCondition(NoRecord, 1659)
	MisResultCondition(HasMission, 1659)
	MisResultAction(ClearMission, 1659)
	MisResultAction(SetRecord, 1659)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001466 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001466")
	MisResultAction(GiveNpcMission1, 6360, MISSCRIPT_MISSIONSCRIPT02_LUA_001466, 11)

----------------------------铁匠的要求
	MISSCRIPT_MISSIONSCRIPT02_LUA_001467 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001467")
	DefineMission(6360, MISSCRIPT_MISSIONSCRIPT02_LUA_001467,1660)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001468 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001468")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001468)
	MisBeginCondition(NoRecord, 1660)
	MisBeginCondition(NoMission,1660)
	MisBeginCondition(HasRecord, 1659)
	MisBeginAction(AddMission, 1660)

	MisBeginAction(AddTrigger, 16601, TE_GETITEM, 2463, 1)
	MisBeginAction(AddTrigger, 16602, TE_GETITEM, 2468, 1)
	MisBeginAction(AddTrigger, 16603, TE_GETITEM, 2469, 1)
	MisBeginAction(AddTrigger, 16604, TE_GETITEM, 2470, 1)
	MisBeginAction(AddTrigger, 16605, TE_GETITEM, 2474, 1)
	MisBeginAction(AddTrigger, 16606, TE_GETITEM, 2478, 1)
	MisBeginAction(AddTrigger, 16607, TE_GETITEM, 2484, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001469 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001469")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001469)	

	MisNeed(MIS_NEED_ITEM, 2463, 1, 10, 1)
	MisNeed(MIS_NEED_ITEM, 2468, 1, 20, 1)
	MisNeed(MIS_NEED_ITEM, 2469, 1, 30, 1)
	MisNeed(MIS_NEED_ITEM, 2470, 1, 40, 1)
	MisNeed(MIS_NEED_ITEM, 2474, 1, 50, 1)
	MisNeed(MIS_NEED_ITEM, 2478, 1, 60, 1)
	MisNeed(MIS_NEED_ITEM, 2484, 1, 70, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001470 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001470")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001470)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001471 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001471")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001471)
	MisBeginCondition(NoRecord, 1660)
	MisResultCondition(HasMission, 1660)
	MisResultCondition(HasItem, 2463, 1)
	MisResultCondition(HasItem, 2468, 1)
	MisResultCondition(HasItem, 2469, 1)
	MisResultCondition(HasItem, 2470, 1)
	MisResultCondition(HasItem, 2474, 1)
	MisResultCondition(HasItem, 2478, 1)
	MisResultCondition(HasItem, 2484, 1)
	MisResultAction(TakeItem, 2463, 1)
	MisResultAction(TakeItem, 2468, 1)
	MisResultAction(TakeItem, 2469, 1)
	MisResultAction(TakeItem, 2470, 1)
	MisResultAction(TakeItem, 2474, 1)
	MisResultAction(TakeItem, 2478, 1)
	MisResultAction(TakeItem, 2484, 1)
	MisResultAction(ClearMission, 1660)
	MisResultAction(SetRecord, 1660)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,600,600)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001466 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001466")
	MisResultAction(GiveNpcMission1, 6361, MISSCRIPT_MISSIONSCRIPT02_LUA_001466, 12)

	InitTrigger()
	TriggerCondition(1, IsItem, 2463)	
	TriggerAction(1, AddNextFlag, 1660, 10, 1)
	RegCurTrigger(16601)

	InitTrigger()
	TriggerCondition(1, IsItem, 2468)	
	TriggerAction(1, AddNextFlag, 1660, 20, 1)
	RegCurTrigger(16602)

	InitTrigger()
	TriggerCondition(1, IsItem, 2469)	
	TriggerAction(1, AddNextFlag, 1660, 30, 1)
	RegCurTrigger(16603)

	InitTrigger()
	TriggerCondition(1, IsItem, 2470)	
	TriggerAction(1, AddNextFlag, 1660, 40, 1)
	RegCurTrigger(16604)

	InitTrigger()
	TriggerCondition(1, IsItem, 2474)	
	TriggerAction(1, AddNextFlag, 1660, 50, 1)
	RegCurTrigger(16605)

	InitTrigger()
	TriggerCondition(1, IsItem, 2478)	
	TriggerAction(1, AddNextFlag, 1660, 60, 1)
	RegCurTrigger(16606)

	InitTrigger()
	TriggerCondition(1, IsItem, 2484)	
	TriggerAction(1, AddNextFlag, 1660, 70, 1)
	RegCurTrigger(16607)


----------------------------神秘百慕大
	MISSCRIPT_MISSIONSCRIPT02_LUA_001472 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001472")
	DefineMission(6361, MISSCRIPT_MISSIONSCRIPT02_LUA_001472,1661)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001473 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001473")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001473)
	MisBeginCondition(NoRecord, 1661)
	MisBeginCondition(NoMission,1661)
	MisBeginCondition(HasRecord, 1660)
	MisBeginAction(AddMission, 1661)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001474 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001474")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001474)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001475 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001475")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001475)
	MisResultCondition(AlwaysFailure)

----------------------------神秘百慕大
	MISSCRIPT_MISSIONSCRIPT02_LUA_001472 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001472")
	DefineMission(6362, MISSCRIPT_MISSIONSCRIPT02_LUA_001472,1661, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001476 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001476")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001476)
	MisResultCondition(NoRecord, 1661)
	MisResultCondition(HasMission, 1661)
	MisResultAction(ClearMission, 1661)
	MisResultAction(SetRecord, 1661)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001477 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001477")
	MisResultAction(GiveNpcMission1, 6363, MISSCRIPT_MISSIONSCRIPT02_LUA_001477, 2)

----------------------------变异与守护者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001478 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001478")
	DefineMission(6363, MISSCRIPT_MISSIONSCRIPT02_LUA_001478,1662)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001479 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001479")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001479)
	MisBeginCondition(NoRecord, 1662)
	MisBeginCondition(NoMission,1662)
	MisBeginCondition(HasRecord, 1661)
	MisBeginAction(AddMission, 1662)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001480 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001480")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001480)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001481 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001481")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001481)
	MisResultCondition(AlwaysFailure)

----------------------------变异与守护者
	MISSCRIPT_MISSIONSCRIPT02_LUA_001478 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001478")
	DefineMission(6364, MISSCRIPT_MISSIONSCRIPT02_LUA_001478,1662, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001482 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001482")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001482)
	MisResultCondition(NoRecord, 1662)
	MisResultCondition(HasMission, 1662)
	MisResultAction(ClearMission, 1662)
	MisResultAction(SetRecord, 1662)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001483 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001483")
	MisResultAction(GiveNpcMission1, 6365, MISSCRIPT_MISSIONSCRIPT02_LUA_001483, 6)

----------------------------霍金斯的指引
	MISSCRIPT_MISSIONSCRIPT02_LUA_001484 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001484")
	DefineMission(6365, MISSCRIPT_MISSIONSCRIPT02_LUA_001484,1663)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001485 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001485")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001485)
	MisBeginCondition(NoRecord, 1663)
	MisBeginCondition(NoMission,1663)
	MisBeginCondition(HasRecord, 1662)
	MisBeginAction(AddMission, 1663)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001486 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001486")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001486)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001487 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001487")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001487)
	MisResultCondition(AlwaysFailure)

----------------------------霍金斯的指引
	MISSCRIPT_MISSIONSCRIPT02_LUA_001484 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001484")
	DefineMission(6366, MISSCRIPT_MISSIONSCRIPT02_LUA_001484,1663, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001488 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001488")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001488)
	MisResultCondition(NoRecord, 1663)
	MisResultCondition(HasMission, 1663)
	MisResultAction(ClearMission, 1663)
	MisResultAction(SetRecord, 1663)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001489 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001489")
	MisResultAction(GiveNpcMission1, 6367, MISSCRIPT_MISSIONSCRIPT02_LUA_001489, 5)

----------------------------女神的请求
	MISSCRIPT_MISSIONSCRIPT02_LUA_001490 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001490")
	DefineMission(6367, MISSCRIPT_MISSIONSCRIPT02_LUA_001490,1664)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001491 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001491")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001491)
	MisBeginCondition(NoRecord, 1664)
	MisBeginCondition(NoMission,1664)
	MisBeginCondition(HasRecord, 1663)
	MisBeginAction(AddMission, 1664)
	MisBeginAction(GiveItem, 6219, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001492 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001492")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001492)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001493 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001493")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001493)
	MisResultCondition(AlwaysFailure)

----------------------------女神的请求
	MISSCRIPT_MISSIONSCRIPT02_LUA_001490 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001490")
	DefineMission(6368, MISSCRIPT_MISSIONSCRIPT02_LUA_001490,1664, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001494 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001494")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001494)
	MisResultCondition(NoRecord, 1664)
	MisResultCondition(HasMission, 1664)
	MisResultCondition(HasItem, 6219, 1)
	MisResultAction(TakeItem, 6219, 1)
	MisResultAction(ClearMission, 1664)
	MisResultAction(SetRecord, 1664)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001398")
	MisResultAction(GiveNpcMission1, 6369, MISSCRIPT_MISSIONSCRIPT02_LUA_001398, 6)

----------------------------神之救赎
	MISSCRIPT_MISSIONSCRIPT02_LUA_001495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001495")
	DefineMission(6369, MISSCRIPT_MISSIONSCRIPT02_LUA_001495,1665)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001496 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001496")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001496)
	MisBeginCondition(NoRecord, 1665)
	MisBeginCondition(NoMission,1665)
	MisBeginCondition(HasRecord, 1664)
	MisBeginAction(AddMission, 1665)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001497 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001497")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001497)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001498 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001498")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001498)
	MisResultCondition(AlwaysFailure)

----------------------------神之救赎
	MISSCRIPT_MISSIONSCRIPT02_LUA_001495 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001495")
	DefineMission(6370, MISSCRIPT_MISSIONSCRIPT02_LUA_001495,1665, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001499 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001499")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001499)
	MisResultCondition(NoRecord, 1665)
	MisResultCondition(HasMission, 1665)
	MisResultAction(ClearMission, 1665)
	MisResultAction(SetRecord, 1665)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001500 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001500")
	MisResultAction(GiveNpcMission1, 6371, MISSCRIPT_MISSIONSCRIPT02_LUA_001500, 2)

----------------------------光明的考验
	MISSCRIPT_MISSIONSCRIPT02_LUA_001501 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001501")
	DefineMission(6371, MISSCRIPT_MISSIONSCRIPT02_LUA_001501,1666)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001502 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001502")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001502)
	MisBeginCondition(NoRecord, 1666)
	MisBeginCondition(NoMission,1666)
	MisBeginCondition(HasRecord, 1665)
	MisBeginAction(AddMission, 1666)
	MisBeginAction(AddTrigger,16661, TE_GETITEM,6231, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001503 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001503")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001503)	
	MisNeed(MIS_NEED_ITEM, 6231, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001504 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001504")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001504)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001505 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001505")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001505)
	MisResultCondition(HasMission, 1666)
	MisResultCondition(NoRecord,1666)
	MisResultCondition(HasItem, 6231, 1)
	MisResultAction(TakeItem, 6231, 1)
	MisResultAction(ClearMission, 1666)
	MisResultAction(SetRecord, 1666)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,700,700)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001500 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001500")
	MisResultAction(GiveNpcMission1, 6619, MISSCRIPT_MISSIONSCRIPT02_LUA_001500, 3)

	InitTrigger()
	TriggerCondition(1, IsItem, 6231)	
	TriggerAction(1, AddNextFlag, 1666, 10, 1)
	RegCurTrigger(16661)
--光明遗迹守护者的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_001506 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001506")
	DefineMission(6619 , MISSCRIPT_MISSIONSCRIPT02_LUA_001506,1857)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001507 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001507")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001507)
	MisBeginCondition(NoRecord, 1857)
	MisBeginCondition(NoMission,1857)
	MisBeginCondition(HasRecord, 1666)
	MisBeginAction(AddMission, 1857)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001508 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001508")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001508)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001509 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001509")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001509)
	MisResultCondition(AlwaysFailure)
----------------------------光明遗迹守护者的口信
	MISSCRIPT_MISSIONSCRIPT02_LUA_001506 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001506")
	DefineMission(6620, MISSCRIPT_MISSIONSCRIPT02_LUA_001506,1857, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001510 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001510")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001510)
	MisResultCondition(NoRecord, 1857)
	MisResultCondition(HasMission, 1857)
	MisResultAction(ClearMission, 1857)
	MisResultAction(SetRecord, 1857)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001339 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001339")
	MisResultAction(GiveNpcMission1, 6372, MISSCRIPT_MISSIONSCRIPT02_LUA_001339, 1)
----------------------------前途崎岖
	MISSCRIPT_MISSIONSCRIPT02_LUA_001511 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001511")
	DefineMission(6372, MISSCRIPT_MISSIONSCRIPT02_LUA_001511,1667)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001512 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001512")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001512)
	MisBeginCondition(NoRecord, 1667)
	MisBeginCondition(NoMission,1667)
	MisBeginCondition(HasRecord, 1857)
	MisBeginAction(AddMission, 1667)

	MisBeginAction(AddTrigger, 16671, TE_KILL, 1109, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001513 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001513")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001513)	

	MisNeed(MIS_NEED_KILL, 1109, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001514 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001514")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001514)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001515 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001515")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001515)

	MisBeginCondition(NoRecord, 1667)
	MisResultCondition(HasMission, 1667)
	MisResultCondition(HasFlag, 1667, 10)
	MisResultAction(ClearMission, 1667)
	MisResultAction(SetRecord, 1667)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,700,700)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001339 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001339")
	MisResultAction(GiveNpcMission1, 6373, MISSCRIPT_MISSIONSCRIPT02_LUA_001339,2)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1109)
	TriggerAction(1, AddNextFlag, 1667, 10, 1)
	RegCurTrigger(16671)

----------------------------转战暗黑秘境
	MISSCRIPT_MISSIONSCRIPT02_LUA_001516 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001516")
	DefineMission(6373, MISSCRIPT_MISSIONSCRIPT02_LUA_001516,1668)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001517 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001517")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001517)
	MisBeginCondition(NoRecord, 1668)
	MisBeginCondition(NoMission,1668)
	MisBeginCondition(HasRecord, 1667)
	MisBeginAction(AddMission, 1668)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001518 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001518")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001518)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001519 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001519")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001519)
	MisResultCondition(AlwaysFailure)

----------------------------转战暗黑秘境
	MISSCRIPT_MISSIONSCRIPT02_LUA_001516 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001516")
	DefineMission(6374, MISSCRIPT_MISSIONSCRIPT02_LUA_001516,1668, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001520 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001520")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001520)
	MisResultCondition(NoRecord, 1668)
	MisResultCondition(HasMission, 1668)
	MisResultAction(ClearMission, 1668)
	MisResultAction(SetRecord, 1668)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001521 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001521")
	MisResultAction(GiveNpcMission1, 6375, MISSCRIPT_MISSIONSCRIPT02_LUA_001521, 2)

----------------------------暗之咒印
	MISSCRIPT_MISSIONSCRIPT02_LUA_001522 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001522")
	DefineMission(6375, MISSCRIPT_MISSIONSCRIPT02_LUA_001522,1669)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001523 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001523")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001523)
	MisBeginCondition(NoRecord, 1669)
	MisBeginCondition(NoMission,1669)
	MisBeginCondition(HasRecord, 1668)
	MisBeginAction(AddMission, 1669)

	MisBeginAction(AddTrigger, 16691, TE_KILL, 1113, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001524 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001524")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001524)	

	MisNeed(MIS_NEED_KILL, 1113, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001525 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001525")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001525)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001526 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001526")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001526)

	MisBeginCondition(NoRecord, 1669)
	MisResultCondition(HasMission, 1669)
	MisResultCondition(HasFlag, 1669, 10)
	MisResultAction(ClearMission, 1669)
	MisResultAction(SetRecord, 1669)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,700,700)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001521 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001521")
	MisResultAction(GiveNpcMission1, 6376, MISSCRIPT_MISSIONSCRIPT02_LUA_001521, 3)
	
	InitTrigger()
	TriggerCondition(1, IsMonster, 1113)
	TriggerAction(1, AddNextFlag, 1669, 10, 1)
	RegCurTrigger(16691)

----------------------------无罪的叹息
	MISSCRIPT_MISSIONSCRIPT02_LUA_001527 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001527")
	DefineMission(6376, MISSCRIPT_MISSIONSCRIPT02_LUA_001527,1670)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001528 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001528")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001528)
	MisBeginCondition(NoRecord, 1670)
	MisBeginCondition(NoMission,1670)
	MisBeginCondition(HasRecord, 1669)
	MisBeginAction(AddMission, 1670)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001529 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001529")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001529)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001530 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001530")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001530)
	MisResultCondition(AlwaysFailure)

----------------------------无罪的叹息
	MISSCRIPT_MISSIONSCRIPT02_LUA_001527 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001527")
	DefineMission(6377, MISSCRIPT_MISSIONSCRIPT02_LUA_001527,1670, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001531 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001531")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001531)
	MisResultCondition(NoRecord, 1670)
	MisResultCondition(HasMission, 1670)
	MisResultAction(ClearMission, 1670)
	MisResultAction(SetRecord, 1670)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001532 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001532")
	MisResultAction(GiveNpcMission1, 6378, MISSCRIPT_MISSIONSCRIPT02_LUA_001532, 2)

----------------------------废墟的影像
	MISSCRIPT_MISSIONSCRIPT02_LUA_001533 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001533")
	DefineMission(6378, MISSCRIPT_MISSIONSCRIPT02_LUA_001533,1671)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001534 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001534")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001534)
	MisBeginCondition(NoRecord, 1671)
	MisBeginCondition(NoMission,1671)
	MisBeginCondition(HasRecord, 1670)
	MisBeginAction(AddMission, 1671)

	MisBeginAction(AddTrigger, 16711, TE_KILL, 1117, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001535 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001535")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001535)	

	MisNeed(MIS_NEED_KILL, 1117, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001536 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001536")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001536)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001537 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001537")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001537)

	MisBeginCondition(NoRecord, 1671)
	MisResultCondition(HasMission, 1671)
	MisResultCondition(HasFlag, 1671, 10)
	MisResultAction(ClearMission, 1671)
	MisResultAction(SetRecord, 1671)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,700,700)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001532 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001532")
	MisResultAction(GiveNpcMission1, 6621, MISSCRIPT_MISSIONSCRIPT02_LUA_001532, 4)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1117)
	TriggerAction(1, AddNextFlag, 1671, 10, 1)
	RegCurTrigger(16711)
----向维尔报告
	MISSCRIPT_MISSIONSCRIPT02_LUA_001538 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001538")
	DefineMission(6621 , MISSCRIPT_MISSIONSCRIPT02_LUA_001538,1858)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001539 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001539")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001539)
	MisBeginCondition(NoRecord, 1858)
	MisBeginCondition(NoMission,1858)
	MisBeginCondition(HasRecord, 1671)
	MisBeginAction(AddMission, 1858)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001540 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001540")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001540)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001509 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001509")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001509)
	MisResultCondition(AlwaysFailure)
----------------------------向维尔报告
	MISSCRIPT_MISSIONSCRIPT02_LUA_001538 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001538")
	DefineMission(6622, MISSCRIPT_MISSIONSCRIPT02_LUA_001538,1858, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001541 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001541")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001541)
	MisResultCondition(NoRecord, 1858)
	MisResultCondition(HasMission, 1858)
	MisResultAction(ClearMission, 1858)
	MisResultAction(SetRecord, 1858)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001398 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001398")
	MisResultAction(GiveNpcMission1, 6379, MISSCRIPT_MISSIONSCRIPT02_LUA_001398, 7)

----------------------------传达维尔的信息
	MISSCRIPT_MISSIONSCRIPT02_LUA_001542 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001542")
	DefineMission(6379, MISSCRIPT_MISSIONSCRIPT02_LUA_001542,1672)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001543 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001543")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001543)
	MisBeginCondition(NoRecord, 1672)
	MisBeginCondition(NoMission,1672)
	MisBeginCondition(HasRecord, 1858)
	MisBeginAction(AddMission, 1672)
	MisBeginAction(GiveItem, 6220, 1, 4)
	MisBeginBagNeed(1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001544 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001544")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001544)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001545 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001545")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001545)
	MisResultCondition(AlwaysFailure)

----------------------------传达维尔的信息
	MISSCRIPT_MISSIONSCRIPT02_LUA_001542 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001542")
	DefineMission(6380, MISSCRIPT_MISSIONSCRIPT02_LUA_001542,1672, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001546 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001546")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001546)
	MisResultCondition(NoRecord, 1672)
	MisResultCondition(HasMission, 1672)
	MisResultCondition(HasItem, 6220, 1)
	MisResultAction(TakeItem, 6220, 1)
	MisResultAction(ClearMission, 1672)
	MisResultAction(SetRecord, 1672)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001489 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001489")
	MisResultAction(GiveNpcMission1, 6381, MISSCRIPT_MISSIONSCRIPT02_LUA_001489, 7)
----------------------------摩尔克族的愤怒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001547 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001547")
	DefineMission(6381, MISSCRIPT_MISSIONSCRIPT02_LUA_001547,1673)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001548 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001548")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001548)
	MisBeginCondition(NoRecord, 1673)
	MisBeginCondition(NoMission,1673)
	MisBeginCondition(HasRecord, 1672)
	MisBeginAction(AddMission, 1673)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001549 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001549")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001549)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001550 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001550")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001550)
	MisResultCondition(AlwaysFailure)

----------------------------摩尔克族的愤怒
	MISSCRIPT_MISSIONSCRIPT02_LUA_001547 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001547")
	DefineMission(6382, MISSCRIPT_MISSIONSCRIPT02_LUA_001547,1673, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001551 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001551")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001551)
	MisResultCondition(NoRecord, 1673)
	MisResultCondition(HasMission, 1673)
	MisResultAction(ClearMission, 1673)
	MisResultAction(SetRecord, 1673)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT01_LUA_000368 = GetResString("MISSCRIPT_MISSIONSCRIPT01_LUA_000368")
	MisResultAction(GiveNpcMission1, 6383, MISSCRIPT_MISSIONSCRIPT01_LUA_000368, 26)
----------------------------魔尔克族的少女
	MISSCRIPT_MISSIONSCRIPT02_LUA_001552 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001552")
	DefineMission(6383, MISSCRIPT_MISSIONSCRIPT02_LUA_001552,1674)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001553 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001553")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001553)
	MisBeginCondition(NoRecord, 1674)
	MisBeginCondition(NoMission,1674)
	MisBeginCondition(HasRecord, 1673)
	MisBeginAction(AddMission, 1674)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001554 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001554")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001554)
	
	MISSCRIPT_MISSIONSCRIPT02_LUA_001555 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001555")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001555)
	MisResultCondition(AlwaysFailure)

----------------------------魔尔克族的少女
	MISSCRIPT_MISSIONSCRIPT02_LUA_001552 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001552")
	DefineMission(6384, MISSCRIPT_MISSIONSCRIPT02_LUA_001552,1674, COMPLETE_SHOW)
	
	MisBeginCondition(AlwaysFailure)
		
	MISSCRIPT_MISSIONSCRIPT02_LUA_001556 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001556")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001556)
	MisResultCondition(NoRecord, 1674)
	MisResultCondition(HasMission, 1674)
	MisResultAction(ClearMission, 1674)
	MisResultAction(SetRecord, 1674)
	MisResultAction(AddExpAndType,2,500,500)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001557 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001557")
	MisResultAction(GiveNpcMission1, 6385, MISSCRIPT_MISSIONSCRIPT02_LUA_001557, 7)
----------------------------使命征程
	MISSCRIPT_MISSIONSCRIPT02_LUA_001558 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001558")
	DefineMission(6385, MISSCRIPT_MISSIONSCRIPT02_LUA_001558,1675)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001559 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001559")
	MisBeginTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001559)
	MisBeginCondition(NoRecord, 1675)
	MisBeginCondition(NoMission,1675)
	MisBeginCondition(HasRecord, 1674)
	MisBeginAction(AddMission, 1675)

	MisBeginAction(AddTrigger, 16751, TE_KILL, 1101, 1)
	MISSCRIPT_EUDEMONSCRIPT_LUA_000012 = GetResString("MISSCRIPT_EUDEMONSCRIPT_LUA_000012")
	MisCancelAction(SystemNotice, MISSCRIPT_EUDEMONSCRIPT_LUA_000012)

	MisPrizeSelAll()

	MISSCRIPT_MISSIONSCRIPT02_LUA_001560 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001560")
	MisNeed(MIS_NEED_DESP, MISSCRIPT_MISSIONSCRIPT02_LUA_001560)	

	MisNeed(MIS_NEED_KILL, 1101, 1, 10, 1)

	MISSCRIPT_MISSIONSCRIPT02_LUA_001561 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001561")
	MisHelpTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001561)
	MISSCRIPT_MISSIONSCRIPT02_LUA_001562 = GetResString("MISSCRIPT_MISSIONSCRIPT02_LUA_001562")
	MisResultTalk(MISSCRIPT_MISSIONSCRIPT02_LUA_001562)
	MisBeginCondition(NoRecord, 1675)
	MisResultCondition(HasMission, 1675)
	MisResultCondition(HasFlag, 1675, 10)
	MisResultAction(ClearMission, 1675)
	MisResultAction(SetRecord, 1675)
	MisResultAction(AddMoney,300000,300000)
	MisResultAction(AddExpAndType,2,50000,50000)

	InitTrigger()
	TriggerCondition(1, IsMonster, 1101)	
	TriggerAction(1, AddNextFlag, 1675, 10, 1)
	RegCurTrigger(16751)


end

HistoryMission001()
