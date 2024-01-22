--------------------------------------------------------------------------
--									--
--									--
--				CharBornScript.lua 			--
--              							--
--									--
--------------------------------------------------------------------------
print( "Loading CharBornScript.lua" )


function PCBorn ()
	--填写角色出生时初始化触发器信息


	InitTrigger()
	BIRTH_BIRTH_CONF_LUA_000001 = GetResString("BIRTH_BIRTH_CONF_LUA_000001")
	TriggerCondition( 1, IsSpawnPos, BIRTH_BIRTH_CONF_LUA_000001 )
	TriggerAction( 1, ObligeAcceptMission, 1 )
	BIRTH_BIRTH_CONF_LUA_000003 = GetResString("BIRTH_BIRTH_CONF_LUA_000003")
	TriggerCondition( 2, IsSpawnPos, BIRTH_BIRTH_CONF_LUA_000003 )
	TriggerAction( 2, ObligeAcceptMission, 2 )
	BIRTH_BIRTH_CONF_LUA_000004 = GetResString("BIRTH_BIRTH_CONF_LUA_000004")
	TriggerCondition( 3, IsSpawnPos, BIRTH_BIRTH_CONF_LUA_000004 )
	TriggerAction( 3, ObligeAcceptMission, 3 )
	local triggerlist = GetMultiTrigger()
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000001 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000001")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000001 )
	TriggerAction( 1, AddTrigger, 60000, TE_LEVELUP, 2, 1 )
	TriggerAction( 1, AddTrigger, 60001, TE_LEVELUP, 5, 1 )
	TriggerAction( 1, AddTrigger, 60002, TE_LEVELUP, 10, 1 )
	TriggerAction( 1, AddTrigger, 60003, TE_LEVELUP, 15, 1 )
	TriggerAction( 1, AddTrigger, 60004, TE_LEVELUP, 37, 1 )
	TriggerAction( 1, AddTrigger, 60005, TE_LEVELUP, 25, 1 )
	TriggerAction( 1, AddTrigger, 60006, TE_LEVELUP, 30, 1 )	
	TriggerAction( 1, AddTrigger, 60007, TE_LEVELUP, 35, 1 )	
	TriggerAction( 1, AddTrigger, 60008, TE_LEVELUP, 40, 1 )	
	TriggerAction( 1, AddTrigger, 60009, TE_LEVELUP, 45, 1 )	
	--TriggerAction( 1, AddTrigger, 60010, TE_LEVELUP, 18, 1 )
	TriggerAction( 1, AddTrigger, 60011, TE_LEVELUP, 41, 1 )
	TriggerAction( 1, AddTrigger, 60012, TE_LEVELUP, 3, 1 )
	TriggerAction( 1, AddTrigger, 60013, TE_LEVELUP, 11, 1 )
	TriggerAction( 1, AddTrigger, 60014, TE_LEVELUP, 13, 1 )
	TriggerAction( 1, AddTrigger, 60015, TE_LEVELUP, 17, 1 )
	TriggerAction( 1, AddTrigger, 60016, TE_LEVELUP, 27, 1 )
	TriggerAction( 1, AddTrigger, 60017, TE_LEVELUP, 60, 1 )
	TriggerAction( 1, AddTrigger, 60018, TE_LEVELUP, 14, 1 )
	TriggerAction( 1, AddTrigger, 60019, TE_LEVELUP, 18, 1 )
	TriggerAction( 1, AddTrigger, 60020, TE_LEVELUP, 43, 1 )
	TriggerAction( 1, AddTrigger, 60021, TE_LEVELUP, 40, 1 )
	TriggerAction( 1, AddTrigger, 60022, TE_LEVELUP, 50, 1 )
	TriggerAction( 1, AddTrigger, 60023, TE_LEVELUP, 9, 1 )
	TriggerAction( 1, AddTrigger, 60024, TE_LEVELUP, 39, 1 )
	TriggerAction( 1, AddTrigger, 60025, TE_LEVELUP, 20, 1 )
	TriggerAction( 1, AddTrigger, 60026, TE_LEVELUP, 55, 1 )
	TriggerAction( 1, AddTrigger, 60027, TE_LEVELUP, 65, 1 )
	TriggerAction( 1, MultiTrigger, triggerlist, 3 )
	TriggerAction( 1, SaveMissionData )

	--将该触发器注册到ID为88888的全局触发器表中,该ID触发器默认为角色出生触发器
	RegTrigger( 88888, 1 )
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000002 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000002")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000002 )
	RegTrigger( 60000, 1 )
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000003 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000003")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000003 )
	RegTrigger( 60001, 1 )
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000004 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000004")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000004 )
	RegTrigger( 60002, 1 )
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,1,0,0)
	MISSCRIPT_CHARBORNSCRIPT_LUA_000005 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000005")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000005 )
	RegTrigger( 60003, 1 )

	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000006 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000006")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000006 )
	RegTrigger( 60004, 1 )

	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,1,0)
	MISSCRIPT_CHARBORNSCRIPT_LUA_000007 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000007")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000007 )
	RegTrigger( 60005, 1 )
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000008 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000008")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000008 )
	RegTrigger( 60006, 1 )	
	
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,3,0)
	MISSCRIPT_CHARBORNSCRIPT_LUA_000009 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000009")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000009 )
	RegTrigger( 60007, 1 )	
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,5,0)
	MISSCRIPT_CHARBORNSCRIPT_LUA_000010 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000010")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000010 )
	RegTrigger( 60008, 1 )	
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,9,0)
	MISSCRIPT_CHARBORNSCRIPT_LUA_000011 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000011")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000011 )
	RegTrigger( 60009, 1 )	

	-- InitTrigger()
	-- TriggerAction( 1, HelpInfo,MIS_HELP_DESP,"    恭喜你18级了,看着你成长的这么快,想必你也想成长得更快一些吧,你可以找一个师傅带领你进行游戏,这样你成长得会更快哦!另外打开海盗拜师宝箱,可以至白银城的海盗公主灵儿（2232,2801）那里领取神秘的任务" )
	-- RegTrigger( 60010, 1 )		
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000012 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000012")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000012 )
	RegTrigger( 60011, 1 )		
	
	InitTrigger()
	MISSCRIPT_CHARBORNSCRIPT_LUA_000013 = GetResString("MISSCRIPT_CHARBORNSCRIPT_LUA_000013")
	TriggerAction( 1, HelpInfo,MIS_HELP_DESP,MISSCRIPT_CHARBORNSCRIPT_LUA_000013 )
	RegTrigger( 60012, 1 )		
	
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6581)
	RegTrigger( 60013, 1 )
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6591)
	RegTrigger( 60014, 1 )
	
	
	InitTrigger()
	--TriggerAction( 1, ObligeAcceptMission,6593)
	RegTrigger( 60015, 1 )
	
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6595)
	RegTrigger( 60016, 1 )
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,0,2)
	TriggerAction( 1, ObligeAcceptMission,6597)
	RegTrigger( 60017, 1 )
	
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6599)
	RegTrigger( 60018, 1 )
	
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6601)
	RegTrigger( 60019, 1 )
	
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6603)
	RegTrigger( 60020, 1 )
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6605)
	RegTrigger( 60021, 1 )
	
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,15,0)
	TriggerAction( 1, ObligeAcceptMission,6607)
	RegTrigger( 60022, 1 )
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6611)
	RegTrigger( 60023, 1 )
	
	
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6615)
	RegTrigger( 60024, 1 )
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,0,1)
	RegTrigger( 60026, 1 )
	
	InitTrigger()
	--TriggerAction( 1, GiveMGHZ,0,0,3)
	RegTrigger( 60027, 1 )
	-----------------星空走廊------Alina---------------------------
	InitTrigger()
	TriggerAction( 1, ObligeAcceptMission,6885)
	RegTrigger( 60028, 1 )

end
PCBorn()

