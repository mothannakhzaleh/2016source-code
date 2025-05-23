#include "Character.h"
#include "Player.h"
#include "GameDB.h"
#include "GameApp.h"
#include "SubMap.h"

#ifdef XTRAP_S
#include "Xtrap_S_Interface.h"
extern unsigned char g_XTrapMap[CSFLIE_NUM][XTRAP_CS4_BUFSIZE_MAP];

void CCharacter::Session()
{
	WPACKET tPacket = GETWPACKET();
	int nRet;
	char sTemp[128]="";
	memset( sTemp, 0, sizeof(sTemp));
	tPacket.WriteCmd( XTRAP_CMD_STEP_ONE );
	
	nRet = XTrap_CS_Step1( SessionBuf, sTemp );
	//tPacket.WriteString( sTemp );
	WRITE_SEQ( tPacket, sTemp, 128 );
	this->ReflectINFof( this, tPacket );
	if( nRet!= XTRAP_CC_RETURN_OK )
	{
		unsigned int DetectCode=0;
		memcpy(&DetectCode, ((unsigned char *)sTemp+8), 4);
		LG("XTRAP","DetectCode value = %08x \n", DetectCode);	
		switch( nRet )
		{
		case XTRAP_CC_RETURN_ERROR:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_ERROR);
			break;
		case XTRAP_CC_RETURN_UNKNOWN:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_UNKNOWN);
			break;
		case XTRAP_CC_RETURN_INVALID_PARAMETER:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_INVALID_PARAMETER);
			break;
		case XTRAP_CC_RETURN_CRC:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_CRC);
			break;
		case XTRAP_CC_RETURN_TIMEOUT:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_TIMEOUT);
			break;
		case XTRAP_CC_RETURN_DETECTHACK:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), XTRAP_CC_RETURN_DETECTHACK);
			break;
		default:
			LG("XTRAP","Character[%s],ID[%ld] XTrap_CS_Step1 has error, reason = %d\n", this->GetName(), this->GetID(), nRet);
			break;
		}
		KICKPLAYER(this->GetPlayer(), 0);
		g_pGameApp->GoOutGame(this->GetPlayer(), true);
		return;
	}
}
#endif
//----------------------------------------------
//       所有Character自身的定时循环处理
//----------------------------------------------

// 总循环入口
void CCharacter::Run(DWORD dwCurTime)
{T_B
	LETimer	t;
	Char	chCount = 0;

	t.Begin();

	if (m_pCPlayer && !m_pCPlayer->IsValid())
		return;
	if (!GetSubMap())
		return;

	bool	bIsLiveing = IsLiveing();

	//extern CGameApp *g_pGameApp;
	//g_pGameApp->m_dwRunStep = 1000 + m_ID;

	m_dwCellRunTime[chCount++] = t.End();
#ifdef XTRAP_S
	if( m_xdrapTime.IsOK(dwCurTime) && (this->GetPlayer()) && (this->GetPlayer()->GetGMLev() == 0 ))
			Session();
#endif

	// 怪物(包含宠物等)生命时间检查
	if(IsPlayerCha()==false && IsNpc()==false) 
	{
		if(CheckLifeTime()) // 时间到
		{
			if(m_HostCha && m_HostCha->IsPlayerCha())
			{
				int nPetNum = m_HostCha->GetPlyMainCha()->GetPetNum();
				if(nPetNum > 0)
					m_HostCha->GetPlyMainCha()->SetPetNum(nPetNum - 1);
			}
			// 调用一个脚本作为事件通知 
			// Delete by lark.li 20090503 begin(没有找到脚本函数)
			//g_CParser.DoString("event_cha_lifetime", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
			// End
			Free(); // 释放, 视野通知
			// char szLua[255];
			// sprintf(szLua, "CreateCha(133, %d, %d, 145, 50)", this->GetPos().x, this->GetPos().y);
			// lua_dostring(g_pLuaState, szLua);
			return;
		}
	}

	//防外挂暂时不上
	/*if(IsPlayerCha() && !IsGMCha2() && ((!(GetAreaAttr() & enumAREA_TYPE_NOT_FIGHT)) || IsBoat()) && !GetPlyCtrlCha()->GetSubMap()->GetMapRes()->CanPK())
	{
		GetPlyMainCha()->CheatRun(dwCurTime);
	}*/

	//add by jilinlee 2007/4/20
	//是否在读书状态
    if(IsReadBook())
	{
		if(bIsLiveing)
		{
			if(m_SReadBook.dwLastReadCallTick == 0)
			{
				m_SReadBook.dwLastReadCallTick = dwCurTime;
			}

			static DWORD dwReadBookTime = 0;
			if(dwReadBookTime == 0 && g_CParser.DoString("ReadBookTime", enumSCRIPT_RETURN_NUMBER, 1, DOSTRING_PARAM_END))
			{
				dwReadBookTime = g_CParser.GetReturnNumber(0);
			}
			//else 
			//	dwReadBookTime = 600*1000;   //取不到的话，默认为十分钟。
			if(dwCurTime - m_SReadBook.dwLastReadCallTick >= dwReadBookTime)
			{
				//调用脚本函数
				char chSkillLv = 0;
				static short sSkillID = 0;
				if(sSkillID == 0 && g_CParser.DoString("ReadBookSkillId", enumSCRIPT_RETURN_NUMBER, 1, DOSTRING_PARAM_END))
				{
					sSkillID = g_CParser.GetReturnNumber(0);
				}
				SSkillGrid	*pSkill = this->m_CSkillBag.GetSkillContByID(sSkillID); //读书技能的技能ID
				if (pSkill)
				{
					chSkillLv = pSkill->chLv;
					g_CParser.DoString("Reading_Book", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this,enumSCRIPT_PARAM_NUMBER, 1, chSkillLv, DOSTRING_PARAM_END);
				}
				m_SReadBook.dwLastReadCallTick = dwCurTime;
			}
		}
		else
			SetReadBookState(FALSE);
		
	}

	t.Begin();
	if (bIsLiveing)
		m_CActCache.Run();
	m_dwCellRunTime[chCount++] = t.End();

	t.Begin();
	DWORD	dwResumeExecTime = m_timerScripts.IsOK(dwCurTime);
	if (dwResumeExecTime > 0)
		OnScriptTimer(dwResumeExecTime, true);
	m_dwCellRunTime[chCount++] = t.End();

	t.Begin();
	if (IsPlayerOwnCha())
		GetPlayer()->Run(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();

	// 定时器检查
	t.Begin();
	if (m_timerAI.IsOK(dwCurTime))         OnAI(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
	if (m_timerAreaCheck.IsOK(dwCurTime))  OnAreaCheck(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
	if (m_timerDie.IsOK(dwCurTime))        OnDie(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
	if (m_timerMission.IsOK(dwCurTime))	   OnMissionTime();
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
    if (m_timerTeam.IsOK(dwCurTime))       OnTeamNotice(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	
	t.Begin();
	if (bIsLiveing)
		if (m_timerSkillState.IsOK(dwCurTime)) OnSkillState(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
	if (bIsLiveing)
		OnMove(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
	if (bIsLiveing)
		OnFight(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();
	t.Begin();
	if (bIsLiveing)
		if (m_timerDBUpdate.IsOK(dwCurTime))   OnDBUpdate(dwCurTime);
	m_dwCellRunTime[chCount++] = t.End();

	t.Begin();
	if (IsPlayerCtrlCha())
	{
		if (m_timerPing.IsOK(dwCurTime))
			CheckPing();

		if (m_timerNetSendFreq.IsOK(dwCurTime) && m_ulNetSendLen > 0)
		{
			WPACKET WtPk	= GETWPACKET();
			WRITE_CMD(WtPk, 0xffff);
			for (uLong i = 0; i < m_ulNetSendLen; i++)
				WRITE_CHAR(WtPk, rand()/255);
			ReflectINFof(this, WtPk);
		}
	}
	m_dwCellRunTime[chCount++] = t.End();

T_E}

void CCharacter::RunEnd( DWORD dwCurTime )
{T_B
	if( m_byExit == CHAEXIT_BEGIN && m_timerExit.IsOK( dwCurTime ) )
	{
		// 正式退出
		Exit();
	}
T_E}

void CCharacter::StartExit()
{T_B
	//LG( "延时退出", "StartExit: Name = %s,exitcode = %d\n", this->GetName(), m_byExit );
	LG( "time too long exit", "StartExit: Name = %s,exitcode = %d\n", this->GetName(), m_byExit );
	if( m_byExit != CHAEXIT_BEGIN )
	{		
		DWORD dwExitTime = 20*1000;
		m_byExit = CHAEXIT_BEGIN;
		m_timerExit.Begin( dwExitTime );

		WPACKET	l_wpk	=GETWPACKET();
		WRITE_CMD( l_wpk, CMD_MC_STARTEXIT );
		WRITE_LONG( l_wpk, dwExitTime );
		ReflectINFof(this, l_wpk );
	}
T_E}

void CCharacter::CancelExit()
{T_B
	//LG( "延时退出", "CancelExit: Name = %s,exitcode = %d\n", this->GetName(), m_byExit );
	LG( "time too long exit", "CancelExit: Name = %s,exitcode = %d\n", this->GetName(), m_byExit );
	if( m_byExit == CHAEXIT_BEGIN )
	{		
		m_byExit = CHAEXIT_NONE;
		m_timerExit.Reset();

		WPACKET	l_wpk	=GETWPACKET();
		WRITE_CMD( l_wpk, CMD_MC_CANCELEXIT );
		ReflectINFof(this, l_wpk );
	}
T_E}

void CCharacter::Exit()
{T_B
	// 正式退出
	//LG( "延时退出", "Exit: Name = %s, exitcode = %d\n", this->GetName(), m_byExit );
	LG( "time too long exit", "Exit: Name = %s, exitcode = %d\n", this->GetName(), m_byExit );
	WPACKET	l_wpk	=GETWPACKET();
	WRITE_CMD( l_wpk, CMD_MT_PALYEREXIT );
	ReflectINFof(this, l_wpk );
	g_pGameApp->GoOutGame(this->GetPlayer(), true);

	m_byExit = CHAEXIT_NONE;
	m_timerExit.Reset();
T_E}

// 定时检查地域变化
void CCharacter::OnAreaCheck(DWORD dwCurTime)
{
}

void CCharacter::OnDBUpdate(DWORD dwCurTime)
{T_B
	CPlayer	*pCPlayer = GetPlayer();
	if (!pCPlayer)
		return;
	if (!pCPlayer->IsPlayer() || pCPlayer->GetMainCha() != this)
		return;

	//LG("Thread", "OnDBUpdate %d\n", ::GetCurrentThreadId());

	LG("enter_map", "OnDBUpdate start!\n");
#ifdef UPDATE_MUL_THREAD

	UpdateDBCall * pCall	= g_gmsvr->m_UpdateProc.Get();
	if(pCall)
	{
		pCall->Init(pCPlayer);
		g_gmsvr->GetProcessor()->AddTask(pCall);
	}
	else
	{
		LG("enter_map", "OnDBUpdate error!\n");
	}
	
#else
	LETimer	 t;
	t.Begin();
	game_db.SavePlayer(pCPlayer, enumSAVE_TYPE_TIMER);
	DWORD tock = t.End();

	//LG("FFF", "%u\n", tock);
#endif
	LG("enter_map", "OnDBUpdate end!\n");
T_E}

BOOL CCharacter::SaveMissionData()
{T_B
	CPlayer	*pCPlayer = GetPlayer();
	if( !pCPlayer ) return FALSE;
	if( !game_db.SaveMissionData( pCPlayer, pCPlayer->GetDBChaId() ) )
	{
		//SystemNotice( "新建角色《%s》存储角色初始任务信息失败！ID[0x%X]", this->GetName(), pCPlayer->GetDBChaId() );
		//SystemNotice( RES_STRING(GM_CHARACTERRUN_CPP_00001), this->GetName(), pCPlayer->GetDBChaId() );
		char szData[128];
		CFormatParameter param(2);
		param.setString( 0, this->GetName() );
		param.setLong( 1, pCPlayer->GetDBChaId() );
		RES_FORMAT_STRING( GM_CHARACTERRUN_CPP_00001, param, szData );
		SystemNotice( szData );
		return FALSE;
	}
	return TRUE;
T_E}

void CCharacter::OnTeamNotice(DWORD dwCurTime)
{T_B
	CPlayer	*pCPlayer = GetPlayer();
	if (!pCPlayer)	return;
	
	pCPlayer->NoticeTeamMemberData();
T_E}

// 脚本定时器，用于HP回复，宠物消耗等
void CCharacter::OnScriptTimer(DWORD dwExecTime, bool bNotice)
{T_B
	Long	lOldHP = (long)getAttr(ATTR_HP);
	m_CChaAttr.ResetChangeFlag();
	if (IsPlayerCha())
		GetKitbag()->SetChangeFlag(false);

	g_CParser.DoString("cha_timer", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 2, defCHA_SCRIPT_TIMER / 1000, dwExecTime, DOSTRING_PARAM_END);

	// 船在海上时会消耗生命
	if (lOldHP > 0 && getAttr(ATTR_HP) <= 0)
	{
		if (IsBoat() && IsPlayerCha())
		{
			SetItemHostObj(0);
			ItemCount(this);
			SetDie(g_pCSystemCha);
			Die();
			GetPlayer()->GetMainCha()->BoatDie(*this, *this);
		}
	}

	if (bNotice)
	{
		SynAttr(enumATTRSYN_AUTO_RESUME);
		if (IsPlayerCha())
			SynKitbagNew(enumSYN_KITBAG_ATTR);
	}
T_E}
