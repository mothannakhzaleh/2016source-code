--------------------------------------------------------------------------
--									--
--									--
--				TemplateSdk.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading TemplateSDK.lua" )
print( "------------------------------------" )


function MisKillMonster( Talk, Param, Prize )

	--Created By BT 2005.01.28

	DefineMission( Param.CurMissionID, Param.MissionName, Param.CurMissionID )

	MisBeginTalk( Talk.Begin )
	MisBeginCondition( NoMission, Param.CurMissionID )
	MisBeginCondition( NoRecord, Param.CurMissionID )

	if Param.NeedRecord ~= nil then
	   MisBeginCondition( HasRecord, Param.NeedRecord )
	end

	MisBeginCondition( LvCheck, ">", Param.MissionMinLv )
	MisBeginCondition( LvCheck, "<", Param.MissionMaxLv )

	MisBeginAction( AddMission, Param.CurMissionID )

	MisBeginAction( AddTrigger, Param.CurTriggerID1, TE_KILL, Param.Kill_Number1, Param.CurMonsterID1 )
	MisNeed( MIS_NEED_KILL, Param.CurMonsterID1, Param.Kill_Number1 )

	if Param.CurMonsterID2 ~= nil and Param.CurTriggerID2 ~= nil and Param.Kill_Number2 ~= nil then
	   MisBeginAction( AddTrigger, Param.CurTriggerID2, TE_KILL, Param.Kill_Number2, Param.CurMonsterID2 )
	   MisNeed( MIS_NEED_KILL, Param.CurMonsterID2, Param.Kill_Number2 )
	end
	if Param.CurMonsterID3 ~= nil and Param.CurTriggerID3 ~= nil and Param.Kill_Number3 ~= nil then
	   MisBeginAction( AddTrigger, Param.CurTriggerID3, TE_KILL, Param.Kill_Number3, Param.CurMonsterID3 )
	   MisNeed( MIS_NEED_KILL, Param.CurMonsterID3, Param.Kill_Number3 )
	end
	if Param.CurMonsterID4 ~= nil and Param.CurTriggerID4 ~= nil and Param.Kill_Number4 ~= nil then
	   MisBeginAction( AddTrigger, Param.CurTriggerID4, TE_KILL, Param.Kill_Number4, Param.CurMonsterID4 )
	   MisNeed( MIS_NEED_KILL, Param.CurMonsterID4, Param.Kill_Number4 )
	end

	if Prize.Mode == nil then
	   MisPrizeSelOne()
	else
	   MisPrizeSelAll()
	end

	if Prize.Select1 ~= nil and Prize.ID1 ~= nil and Prize.Num1 ~= nil then
	   MisPrize( Prize.Select1, Prize.ID1, Prize.Num1 )
	end
	if Prize.Select2 ~= nil and Prize.ID2 ~= nil and Prize.Num2 ~= nil then
	   MisPrize( Prize.Select2, Prize.ID2, Prize.Num2 )
	end
	if Prize.Select3 ~= nil and Prize.ID3 ~= nil and Prize.Num3 ~= nil then
	   MisPrize( Prize.Select3, Prize.ID3, Prize.Num3 )
	end
	if Prize.Select4 ~= nil and Prize.ID4 ~= nil and Prize.Num4 ~= nil then
	   MisPrize( Prize.Select4, Prize.ID4, Prize.Num4 )
	end
	if Prize.Select5 ~= nil and Prize.ID5 ~= nil and Prize.Num5 ~= nil then
	   MisPrize( Prize.Select5, Prize.ID5, Prize.Num5 )
	end
	if Prize.Select6 ~= nil and Prize.ID6 ~= nil and Prize.Num6 ~= nil then
	   MisPrize( Prize.Select6, Prize.ID6, Prize.Num6 )
	end
	if Prize.Select7 ~= nil and Prize.ID7 ~= nil and Prize.Num7 ~= nil then
	   MisPrize( Prize.Select7, Prize.ID7, Prize.Num7 )
	end
	if Prize.Select8 ~= nil and Prize.ID8 ~= nil and Prize.Num8 ~= nil then
	   MisPrize( Prize.Select8, Prize.ID8, Prize.Num8 )
	end

	MisResultTalk( Talk.Result )
	MisHelpTalk( Talk.Help )

	MisResultCondition( HasMission, Param.CurMissionID )
	MisResultCondition( NoRecord, Param.CurMissionID )
	if Param.NeedRecord ~= nil then
	   MisResultCondition( HasRecord, Param.NeedRecord )
	end
	MisResultCondition( HasFlag, Param.CurMissionID, 79 + Param.Kill_Number1 )
	if Param.CurMonsterID2 ~= nil and Param.CurTriggerID2 ~= nil and Param.Kill_Number2 ~= nil then
	   MisResultCondition( HasFlag, Param.CurMissionID, 99 + Param.Kill_Number2 )
	end

	MisResultAction( AddExp, Param.MaxAddExp, Param.MinAddExp )
	MisResultAction( ClearMission, Param.CurMissionID )
	if Param.SetMisRecord ~= nil then
	   MisResultAction( SetRecord, Param.CurMissionID )
	end

	InitTrigger()
	TriggerCondition( 1, IsMonster, Param.CurMonsterID1 )
	TriggerAction( 1, AddNextFlag, Param.CurMissionID, 80, Param.Kill_Number1 )
	RegCurTrigger( Param.CurTriggerID1 )

	if Param.CurMonsterID2 ~= nil and Param.CurTriggerID2 ~= nil and Param.Kill_Number2 ~= nil then
	   InitTrigger()
	   TriggerCondition( 1, IsMonster, Param.CurMonsterID2 )
	   TriggerAction( 1, AddNextFlag, Param.CurMissionID, 100, Param.Kill_Number2 )
	   RegCurTrigger( Param.CurTriggerID2 )
	end

end


function DefSendItemMission( id, name, misid, npcid, areaid, sid )
	--定义一个任务（详见该函数说明，COMPLETE_SHOW函数参数表明该任务只有在角色完全符合条件可以交付时才会显示给玩家角色）
	DefineMission( id, name, misid, COMPLETE_SHOW )
	
	MisBeginCondition( AlwaysFailure )
	
	MISSCRIPT_SENDMISSION_LUA_000001 = GetResString("MISSCRIPT_SENDMISSION_LUA_000001")
	MisResultTalk(MISSCRIPT_SENDMISSION_LUA_000001)
	
	--填写接受送信条件判定姓习，详见函数说明
	MisResultCondition( HasRandMissionNpc, misid, npcid, areaid )
	MisResultCondition( NoRandNpcItemFlag, misid, npcid )
	
	--任务完成动作信息（见随机任务的物品提取函数TakeRandNpcItem信息说明,该函数必须有）
	MisResultAction( TakeRandNpcItem, misid, npcid, GetNpcName( npcid ) )
	MisResultAction( RefreshCompleteFlag, sid )
end



--设置转职限制信息
function ConvertProfession()
	--新手无转职限制 

	--剑士转职
	AddPfTable( 1, 8 )		--转职为巨剑士
	AddPfTable( 1, 9 )		--转职为双剑士
	AddPfTable( 1, 10 )		--转职为剑盾士
	
	--猎人转职
	AddPfTable( 2, 11 )		--转职为训兽师
	AddPfTable( 2, 12 )		--转职为狙击手
	
	--水手转职
	AddPfTable( 3, 15 )		--转职为船长
	
	--冒险者转职
	AddPfTable( 4, 16 ) 		--转职为航海士
	
	--祈愿使转职
	AddPfTable( 5, 13 )		--转职为圣职者
	AddPfTable( 5, 14 )		--转职为封印师
	
	--技师转职
	AddPfTable( 6, 18 )		--转职为工程师
	
	--商人转职
	AddPfTable( 7, 17 )		--转职为商人
	
	--角色体形限制
	--长发男转职
	AddCatTable( 1, 1 )		--转职为剑士
	AddCatTable( 1, 2 )		--转职为猎人
	AddCatTable( 1, 4 )		--转职为冒险者
	AddCatTable( 1, 7 )		--转职为商人
	AddCatTable( 1, 9 )		--转职为双剑士
	AddCatTable( 1, 10 )	--转职为剑盾士
	AddCatTable( 1, 11 )	--转职为驯兽师
	AddCatTable( 1, 12 )	--转职为狙击手
	AddCatTable( 1, 16 )	--转职为航海士
	AddCatTable( 1, 17 )	--转职为爆发户
	
	--魁梧男转职
	AddCatTable( 2, 1 )		--转职为剑士
	AddCatTable( 2, 3 )		--转职为水手
	AddCatTable( 2, 6 )		--转职为技师
	AddCatTable( 2, 7 )		--转职为商人
	AddCatTable( 2, 8 )		--转职为巨剑士
	AddCatTable( 2, 10 )	--转职为剑盾士
	AddCatTable( 2, 17 )	--转职为爆发户
	
	--女主角一转职
	AddCatTable( 3, 2 )		--转职为猎人
	AddCatTable( 3, 3 )		--转职为水手
	AddCatTable( 3, 4 )		--转职为冒险者
	AddCatTable( 3, 5 )		--转职为祈愿使
	AddCatTable( 3, 7 )		--转职为商人
	AddCatTable( 3, 11 )	--转职为训兽师
	AddCatTable( 3, 12 )	--转职为狙击手
	AddCatTable( 3, 13 )	--转职为圣职者
	AddCatTable( 3, 14 )	--转职为封印师
	AddCatTable( 3, 15 )	--转职为船长
	AddCatTable( 3, 16 )	--转职为航海士
	AddCatTable( 3, 17 )	--转职为暴发户
	
	
	--女主角二转职
	AddCatTable( 4, 4 )		--转职为冒险者
	AddCatTable( 4, 5 )		--转职为祈愿使
	AddCatTable( 4, 6 )		--转职为技师
	AddCatTable( 4, 7 )		--转职为商人
	AddCatTable( 4, 13 )	--转职为圣职者
	AddCatTable( 4, 14 )	--转职为封印师
	AddCatTable( 4, 16 )	--转职为航海士
	AddCatTable( 4, 17 )	--转职为暴发户
	AddCatTable( 4, 18 )	--转职为工程师
end
ConvertProfession()