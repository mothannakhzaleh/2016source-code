--------------------------------------------------------------------------
--									--
--									--
--				SendMission.lua 			--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading SendMission.lua" )


--设置NPC随机任务中的，送信接受完成任务信息。
function TestDefMission( id, name, misid, npcid, areaid )
	DefineMission( id, name, misid, COMPLETE_SHOW )

	MisBeginCondition( AlwaysFailure )

	MISSCRIPT_SENDMISSION_LUA_000001 = GetResString("MISSCRIPT_SENDMISSION_LUA_000001")
	MisReultTalk(MISSCRIPT_SENDMISSION_LUA_000001)
	
	MisResultCondition( HasRandMissionNpc, misid, npcid, areaid )
	MisResultCondition( NoRandNpcItemFlag, misid, npcid )
	
	MisResultAction( TakeRandNpcItem, misid, npcid )
end

--样例
--TestDefMission( 1, "比特的包裹", 8, 3, 1 )
--TestDefMission( 2, "沙岚传送使的包裹", 8, 4, 1 )
