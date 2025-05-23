//=============================================================================
// FileName: Character.cpp
// Creater: ZhangXuedong
// Date: 2004.10.19
// Comment: CCharacter class 
//=============================================================================

#include "stdafx.h"
#include "GameApp.h"
#include "Character.h"
#include "SubMap.h"
#include "NPC.h"
#include "Item.h"
#include "Script.h"
#include "CharTrade.h"
#include "Parser.h"
#include "GameDB.h"
#include "CommFunc.h"
#include "Player.h"
#include "ItemAttr.h"
#include "JobInitEquip.h"  
#include "GameAppNet.h"
#include "SkillStateRecord.h"
#include "EventHandler.h"
#include "Birthplace.h"
#include "CharBoat.h"
#include "HarmRec.h"
#include "lua_gamectrl.h"
#include "MapEntry.h"
#include "lua_gamectrl.h"

#pragma warning(disable: 4355)

#define defXTRAP_MAX (20*1000)
// 用于与脚本之间的交互
Point			g_SSkillPoint;
bool			g_bBeatBack = false;
unsigned char	g_uchFightID;
//
extern char g_skillstate[1024];

#ifdef XTRAP_S
#include "Xtrap_S_Interface.h"
extern unsigned char g_XTrapMap[CSFLIE_NUM][XTRAP_CS4_BUFSIZE_MAP];
#endif 
_DBC_USING

CCharacter::CCharacter() 
: m_CAction(this),
 m_CActCache(this),
 _dwLastAreaTick(0),
 m_AIType(0),
 m_AITarget(0),
 m_HostCha(0),
 _btBlockCnt(0),
 m_sChaseRange(1000),
 m_btPatrolState(0),
 m_pHate(NULL),
 m_dwBoatCtrlTick(0),
 m_bRelive(false),
 m_bVol(false),
 m_bInvited(false), 
 m_expFlag(false),
 m_ExpScale(100)
{T_B
    m_sPoseState = enumPoseStand;

	memset(&m_SChaPart, 0, sizeof(m_SChaPart));
	memset(&m_STempChaPart, 0, sizeof(m_STempChaPart));
	for (int i = 0; i < enumACTCONTROL_MAX; i++)
		SetActControl(i);

	m_pTradeData = NULL;
	m_lSideID = 0;

	m_pHate = new CHateMgr;

	m_pCKitbagTmp = 0;
#ifndef ALL_HAS_KITBAG
	m_pCKitbag = 0;
#endif

#ifdef SHUI_JING
	m_lFlatMoney = 0;
	m_cancelSaletick = 0;
	m_refreshtick = 0;
	m_getmoneytick = 0;
	m_buyNum = 0;
	m_saleNum = 0;
#endif
T_E}

CCharacter::~CCharacter()
{
	delete m_pHate;
	if(m_pCKitbagTmp)
	{
		delete m_pCKitbagTmp;
		m_pCKitbagTmp = 0;
	}

#ifndef ALL_HAS_KITBAG
	if(m_pCKitbag)
	{
		delete m_pCKitbag;
		m_pCKitbag = 0;
	}
#endif
}


void CCharacter::Initially()
{T_B
	CMoveAble::Initially();

	m_AIType = 0;
	m_AITarget = 0;
	m_nPatrolX = 0;
	m_nPatrolY = 0;
	m_sChaseRange = 0;
	m_btPatrolState = 0;
	m_sPoseState = enumPoseStand;
#ifdef ALL_HAS_KITBAG
	GetKitbag()->Init(defDEF_KBITEM_NUM_PER_TYPE);
#else
	m_pCKitbag = 0;
#endif
	memset(&m_CShortcut, 0, sizeof(m_CShortcut));
	memset(&m_SChaPart, 0, sizeof(m_SChaPart));
	for (int i = 0; i < enumACTCONTROL_MAX; i++)
		SetActControl(i);
	m_pHate->ClearHarmRec();
	m_chSelRelive = enumEPLAYER_RELIVE_NONE;
	m_chReliveLv = 0;
	//m_szMotto[0] = '\0';
	memset(m_szMotto, 0, sizeof(m_szMotto));

	m_usIcon = 0;
	m_SLean.chState = 1;
	m_SSeat.chIsSeat = 0;
	m_CAction.Interrupt();
	_btBlockCnt = 0;
	memset(&m_STempChaPart, 0, sizeof(m_STempChaPart));

	m_pTradeData = NULL;
	SetKitbagRecDBID(0);
    SetKitbagTmpRecDBID(0);
	SetStoreItemID(0);
	SetStoreBuy(false);
	SetPetNum(0);
	m_dwStoreTime = 0;

    m_timerAI.Begin(500);
    m_timerAreaCheck.Begin(2000);
	m_timerDBUpdate.Begin(g_Config.m_lDBSave);
	//m_timerDBUpdate.Begin(1000);

	m_timerDie.Begin(1000);
	m_timerMission.Begin( 60*1000 );
	m_timerSkillState.Begin(1000);
	m_timerTeam.Begin(1000);
	m_timerScripts.Begin(defCHA_SCRIPT_TIMER);
	m_timerPing.Begin(defPING_INTERVAL);
	m_ulPingDataLen = 0;
	m_timerExit.Reset();
	m_byExit = CHAEXIT_NONE;

	m_chPKCtrl = 0;
	m_lSideID = 0;

	m_dwPing = defDEFAULT_PING_VAL;
	memset(m_dwPingRec, 0, sizeof(DWORD) * defPING_RECORD_NUM);
	m_dwPingSendTick = 0;

	_dwLastSayTick = 0;
	SetInOutMapQueue(false);

	m_ulNetSendLen = 0;
	m_timerNetSendFreq.Begin(1 * 1000);

	_dwLifeTime = 0;

	ResetScriptParam();

	m_pCKitbagTmp = 0;

	memset(m_sTigerItemID, 0, sizeof(m_sTigerItemID));
	memset(m_sTigerSel, 0, sizeof(m_sTigerSel));

    m_ExpScale = 100;

	m_expFlag = false;

	InitCheatX();

	//m_pSkillGridTemp = 0;

	//add by jilinlee 2007/4/20
	SetReadBookState(false);
	m_SReadBook.dwLastReadCallTick=0;

	m_bRelive = false;
	m_bVol = false;
	m_bInvited = false;
	m_bStoreEnable = false;
#ifdef NEW_MAPCOPY
	memset( g_szTFightMapName, 0, sizeof(g_szTFightMapName));
#endif
#ifdef	XTRAP_S
	memset( SessionBuf, 0, sizeof(SessionBuf) );
	XTrap_S_SessionInit( 600, CSFLIE_NUM, g_XTrapMap, SessionBuf );
	m_xdrapTime.Begin(defXTRAP_MAX);
#endif
T_E}

void CCharacter::Finally()
{T_B
	try
	{
		m_timerExit.Reset();
		m_byExit = CHAEXIT_NONE;

		if(m_pCKitbagTmp)
		{
			delete m_pCKitbagTmp;
			m_pCKitbagTmp = 0;
		}
#ifndef ALL_HAS_KITBAG
	if(m_pCKitbag)
	{
		delete m_pCKitbag;
		m_pCKitbag = 0;
	}
#endif

		SetPetNum(0);

		m_bRelive = false;
		m_bVol = false;
		m_bInvited = false;
		/*if(m_pSkillGridTemp)
		{
			delete [] m_pSkillGridTemp;
			m_pSkillGridTemp = 0;
		}*/

        m_ExpScale = 100;

		BreakAction();
		m_AITarget = 0;
		if (m_submap)
			m_submap->GoOut(this);
		CMoveAble::Finally();
	}
	catch (...)
	{
		if (!GetPlayer())
			//LG("exception3", "角色[%s]释放时发生异常, [CCharacter::Finally]\n", GetLogName());
			LG("exception3", "when character[%s]release occured abnormity, [CCharacter::Finally]\n", GetLogName());
		else
			//LG("exception3", "玩家角色[名称 %s，数据库ID %u]释放时发生异常, [CCharacter::Finally]\n", GetLogName(), GetPlayer()->GetDBActId());
			LG("exception3", "character player[name %s，DatabaseID %u]release occured abnormity, [CCharacter::Finally]\n", GetLogName(), GetPlayer()->GetDBActId());
		throw;
	}
T_E}

void CCharacter::TradeClear( CPlayer& player )
{
	// 清除他的交易信息或者船只交易取消
	if( m_pTradeData )
	{
		g_TradeSystem.Clear( mission::TRADE_CHAR, *this );
	}

	BYTE byNumBoat = player.GetNumBoat();
	for( BYTE i = 0; i < byNumBoat; i++ )
	{
		CCharacter* pBoat = player.GetBoat( i );
		if( pBoat )
		{
			if( pBoat->m_pTradeData )
			{
				g_TradeSystem.Clear( mission::TRADE_BOAT, *pBoat );
			}
		}
	}
}


bool CCharacter::IsPlayerCha(void)
{
	return m_pCPlayer && m_pCPlayer->IsPlayer();
}

bool CCharacter::IsPlayerMainCha(void)
{
	return m_pCPlayer && (m_pCPlayer->GetMainCha() == this);
}

bool CCharacter::IsPlayerCtrlCha(void)
{
	return m_pCPlayer && (m_pCPlayer->GetCtrlCha() == this);
}

CCharacter* CCharacter::GetPlyCtrlCha(void)
{
	if (m_pCPlayer)
		return m_pCPlayer->GetCtrlCha();
	else
		return this;
}

CCharacter* CCharacter::GetPlyMainCha(void)
{
	if (m_pCPlayer)
		return m_pCPlayer->GetMainCha();
	else
		return this;
}

bool CCharacter::IsGMCha()
{
	if(m_pCPlayer && m_pCPlayer->GetGMLev() > 0 && m_pCPlayer->GetGMLev() < 10) return true;
	//if(m_pCPlayer && m_pCPlayer->GetGMLev() > 0) return true;
	
	return false;
}

bool CCharacter::IsGMCha2()
{
	if(m_pCPlayer && m_pCPlayer->GetGMLev() > 0) return true;
	
	return false;
}

inline bool CCharacter::IsPlayerFocusCha(void)
{
	return IsPlayerCha() && (m_pCPlayer->GetCtrlCha() == this);
}

bool CCharacter::IsPlayerOwnCha(void)
{
	return IsPlayerCha() && (getAttr(ATTR_CHATYPE) == enumCHACTRL_PLAYER);
}

void CCharacter::WritePK(WPACKET& wpk) //写入玩家本身及其所有附加结构(如召唤兽等)的所有数据
{T_B
	CMoveAble::WritePK(wpk);

	//ToDo:写入自己的数据
T_E}

void CCharacter::WriteCharPartInfo(WPACKET& packet)
{T_B
	WRITE_SEQ(packet, (cChar*)&this->m_SChaPart, sizeof(this->m_SChaPart));
	WRITE_LONG(packet, m_pCChaRecord->lID );
T_E}

void CCharacter::ReadPK(RPACKET& rpk) //重构玩家本身及其所有附加结构(如召唤兽等)
{T_B
	CMoveAble::ReadPK(rpk);

	//ToDo:读出自己的数据
	m_AITarget = 0;
	m_CAction.Interrupt();
T_E}

//=============================================================================
// 把自己从当前地图pCSrcMap，切换到目标地图szTarMapName，[lTarX,lTarY]是到目标地图后的位置(系统会根据碰撞信息进行调整，不一定精确到达)
// bNeedOutSrcMap 标示是否需要从原地图GoOut
//=============================================================================
void CCharacter::SwitchMap(SubMap* pCSrcMap, cChar* szTarMapName, Long lTarX, Long lTarY, bool bNeedOutSrcMap, Char chSwitchType, Long lTMapCpyNO)
{
  T_B if(!pCSrcMap) return;

  BreakAction();

  if(IsPlayerCha())
  {
	SetSubMap(pCSrcMap);
	GetPlayer()->MisGooutMap();
	SetSubMap(NULL);
  }

  if(bNeedOutSrcMap && pCSrcMap)
	pCSrcMap->GoOut(this);

  if(!strcmp(pCSrcMap->GetName(), szTarMapName)) 
  { // Same map
	if(GetPlayer())
	{
	  LG("enter_map", "SwitchMap(the same map switch,control player name %s[mainplayer %s],mapname %s)--------\n", GetLogName(), GetPlyMainCha()->GetLogName(), szTarMapName);
	}
	if(m_SMoveRedu.ulStartTick == 0xffffffff)
	{
	  m_SMoveRedu.ulStartTick = GetTickCount();
	}
	if(!IsPlayerCha()) // 非玩家角色，则在自己的出生点重生
	{
	  m_SFightInit.chTarType = 0;
	  m_CChaAttr.Init(GetCat());
	  Square SSrcShape = GetShape();
	  Square STarShape = {{lTarX, lTarY}, GetRadius()};
	  if(!pCSrcMap->Enter(&STarShape, this))
		pCSrcMap->Enter(&SSrcShape, this);
	} else
	{
	  SStateData2String(this, g_skillstate, 1024);
	  if(IsBoat())
		g_strChaState[1] = g_skillstate;
	  else
		g_strChaState[0] = g_skillstate;
	  Square SSrcShape = GetShape();
	  Square STarShape = {{lTarX, lTarY}, SSrcShape.radius};
	  if(!pCSrcMap->EnsurePos(&STarShape, this)) // 进入失败
	  {
		lTarX = SSrcShape.centre.x;
		lTarY = SSrcShape.centre.y;
	  }

	  GetPlayer()->GetMainCha()->Cmd_EnterMap(szTarMapName, lTMapCpyNO, lTarX, lTarY);

	  // 角色护送NPC同步地图切换
	  GetPlayer()->MisEnterMap();
	}

	SetExistState(enumEXISTS_WAITING);
	return;
  }

  { // Different map
	bool	bVolunteer = false;
	SubMap* pCBackM	   = GetSubMap();
	SetSubMap(pCSrcMap);
	pCSrcMap->BeforePlyOutMap(this);
	LG("enter_map", "SwitchMap(differ Server map switch,control player name %s[mainplayer %s],formerly map %s,aimmap %s)--------\n", GetLogName(), GetPlyMainCha()->GetLogName(), pCSrcMap->GetName(), szTarMapName);
	if(GetSubMap())
	  LG("enter_map", "character map name %s\n", GetSubMap()->GetName());
	// 资料写数据库
	CPlayer* pPlayer = GetPlayer();
	if(!pPlayer)
	  return;

	//组队面板修改
	if(GetPlyMainCha()->IsVolunteer())
	{
	  bVolunteer = true;
	  GetPlyMainCha()->Cmd_DelVolunteer();
	}

	game_db.SavePlayer(pPlayer, enumSAVE_TYPE_SWITCH, szTarMapName, lTarX, lTarY);

	//LG("enter_map", "保存数据成功\n");
	LG("enter_map", "save data succeed\n");

	// 角色护送NPC同步地图切换
	pPlayer->MisLogout();

	SetSubMap(pCBackM);

	// 发送协议
	WPACKET l_wpk = GETWPACKET();
	WRITE_CMD(l_wpk, CMD_MT_SWITCHMAP);
	WRITE_STRING(l_wpk, pCSrcMap->GetName());
	WRITE_LONG(l_wpk, pCSrcMap->GetCopyNO());
	WRITE_LONG(l_wpk, GetShape().centre.x);
	WRITE_LONG(l_wpk, GetShape().centre.y);
	WRITE_STRING(l_wpk, szTarMapName);
	WRITE_LONG(l_wpk, lTMapCpyNO);
	WRITE_LONG(l_wpk, lTarX);
	WRITE_LONG(l_wpk, lTarY);
	if(chSwitchType == enumSWITCHMAP_DIE) // 死亡导致的地图切换（如果目标地图不可达，则gate强制玩家下线，不会返回源地图）
	  WRITE_CHAR(l_wpk, 1);
	else
	  WRITE_CHAR(l_wpk, 0);
	ReflectINFof(this, l_wpk);

	g_pGameApp->DelPlayerIdx(pPlayer->GetDBChaId());
	g_pGameApp->m_dwPlayerCnt--;

	pPlayer->Free();
	pPlayer->OnLogoff();
	DELPLAYER(pPlayer);
	LG("enter_map", "finish enter map\n\n");
  }
  T_E
}

void CCharacter::OnBeginSee(Entity *obj)
{T_B
	if(!IsPlayerFocusCha()) // 该角色不是玩家当前的控制焦点
		return;

	obj->OnBeginSeen(this);	//ToDo:传输目标的完整信息以反映到客户端
T_E}

void CCharacter::OnEndSee(Entity *obj)
{T_B
	if(!IsPlayerFocusCha()) // 该角色不是玩家当前的控制焦点
		return;

	obj->OnEndSeen(this);	//ToDo:从客户端删除目标
T_E}

void CCharacter::ReflectINFof(Entity *srcent, WPACKET chginf)
{T_B
	if (!IsPlayerCha()) // 该角色不属于玩家
		return;

	if(srcent ==this)
	{
	}
	WRITE_LONG(chginf, GetPlayer()->GetDBChaId());
	WRITE_LONGLONG(chginf, GetPlayer()->GetGateAddr());
	WRITE_SHORT(chginf, 1);

	if(m_pCPlayer)
	{
		GateServer* pGate = m_pCPlayer->GetGate();
		
		if(pGate)
			pGate->SendData(chginf);
	}
T_E}

void CCharacter::OnBeginSeen(CCharacter *pCCha)
{T_B
	if (!pCCha->IsPlayerCha()) // 该角色不属于玩家
		return;

	LETimer tt;
	tt.Begin();

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_CHABEGINSEE);		//命令2字节
	if (GetPlayer() && GetPlayer() == pCCha->GetPlayer())
		WRITE_CHAR(pk, enumENTITY_SEEN_SWITCH);
	else
		WRITE_CHAR(pk, enumENTITY_SEEN_NEW);

	mission::CEventEntity* pEntity = IsEvent();
	if( pEntity )
	{
		uShort	usEventID = pEntity->GetInfoID();
		
		// 同步事件实体的激活状态信息
		BYTE byData;
		pEntity->GetState( *pCCha, byData );
		usEventID |= byData<<12;
		GetEvent().SetID(usEventID);
	}

	WriteBaseInfo(pk);

	BYTE byState = 0, byShowType = 0;
	mission::CNpc* pNpc = IsNpc();
	if( pNpc )
	{
		if( pNpc->GetType() == mission::CNpc::TALK )
		{
			// 先获取NPC状态信息
			mission::CTalkNpc* pTalk = (mission::CTalkNpc*)pNpc;
			pTalk->MissionProc( *pCCha, byState );
		}
		byShowType = pNpc->GetShowType();
	}

	WRITE_CHAR( pk, byShowType );
	WRITE_CHAR(pk,  byState );

	// pose状态数据
	WRITE_SHORT(pk, m_sPoseState);
	switch (m_sPoseState)
	{
	case	enumPoseLean:
		{
			WRITE_CHAR(pk, m_SLean.chState);
			WRITE_LONG(pk, m_SLean.lPose);
			WRITE_LONG(pk, m_SLean.lAngle);
			WRITE_LONG(pk, m_SLean.lPosX);
			WRITE_LONG(pk, m_SLean.lPosY);
			WRITE_LONG(pk, m_SLean.lHeight);
			break;
		}
	case	enumPoseSeat:
		{
			WRITE_SHORT(pk, m_SSeat.sAngle);
			WRITE_SHORT(pk, m_SSeat.sPose);
			break;
		}
	default:
		{
			break;
		}
	}

	if (IsPlayerCha())
		WriteAttr(pk, 0, ATTR_CLIENT_MAX - 1, enumATTRSYN_INIT);
	else
		WriteMonsAttr(pk, enumATTRSYN_INIT);
	WriteSkillState(pk);
	// WPacket www;
	
	pCCha->ReflectINFof(this,pk);//通告

	//printf("packet size = %d [%s]\n", pk.HasData(), GetName());
T_E}

void CCharacter::OnEndSeen(CCharacter *pCCha)
{T_B
	if (!pCCha->IsPlayerCha()) // 该角色不属于玩家
		return;

	if (m_pCPlayer && pCCha->m_pCPlayer && (GetID() == pCCha->GetID()))
		//LG("视野错误", "同名玩家角色 %s 出视野，他们的socket：%p，%p.\n", pCCha->GetLogName(), m_pCPlayer->GetGate(), pCCha->m_pCPlayer->GetGate());
		LG("eyeshot error", "the homonymy player %s out of eyeshot，their socket：%p，%p.\n", pCCha->GetLogName(), m_pCPlayer->GetGate(), pCCha->m_pCPlayer->GetGate());

	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_CHAENDSEE);		//命令2字节
	if (GetPlayer() && GetPlayer() == pCCha->GetPlayer() && getAttr(ATTR_CHATYPE) == enumCHACTRL_PLAYER)
		WRITE_CHAR(pk, enumENTITY_SEEN_SWITCH);
	else
		WRITE_CHAR(pk, enumENTITY_SEEN_NEW);

	WRITE_LONG(pk, m_ID);					//ID
	pCCha->ReflectINFof(this,pk);//通告

	// 任务npc信息状态同步
	mission::CNpc* pNpc = IsNpc();
	if( pNpc )
	{
		if( pNpc->GetType() == mission::CNpc::TALK )
		{
			// 先获取NPC状态信息
			mission::CTalkNpc* pTalk = (mission::CTalkNpc*)pNpc;
			pCCha->ClearMissionState( GetID() );
		}
	}
T_E}

bool CCharacter::CanSeen(CCharacter *pCCha)
{
	if (!pCCha)
		return false;

	if (pCCha == this)
		return true;

	if (pCCha->GetActControl(enumACTCONTROL_EYESHOT) && (GetActControl(enumACTCONTROL_NOHIDE) || !GetActControl(enumACTCONTROL_NOSHOW)))
		return true;

	if (IsFriend(pCCha) && !IsGMCha2())
		return true;

	return false;
}

bool CCharacter::CanSeen(CCharacter *pCCha, bool bThisEyeshot, bool bThisNoHide, bool bThisNoShow)
{
	if (!pCCha)
		return false;

	if (pCCha == this)
		return true;

	if (pCCha->GetActControl(enumACTCONTROL_EYESHOT) && (bThisNoHide || !bThisNoShow))
		return true;

	if (IsFriend(pCCha) && !IsGMCha2())
		return true;

	return false;
}

void CCharacter::SetRelive(Char chType, Char chLv, const Char *szInfo)
{
	if (chType == enumEPLAYER_RELIVE_ORIGIN)
	{
		m_chReliveLv = chLv;
		if (m_chReliveLv == 0)
			return;

		if (IsBoat()) // 船不能原地复活
			return;

		GetPlyMainCha()->SetChaRelive();
	}

	WPACKET pk = GETWPACKET();
	WRITE_CMD(pk, CMD_MC_QUERY_RELIVE);
	WRITE_LONG(pk, GetID());
	if (szInfo)
		WRITE_STRING(pk, szInfo);
	else
		WRITE_STRING(pk, "");
	WRITE_CHAR(pk, chType);
	ReflectINFof(this,pk);
}

DWORD CCharacter::GetTeamID()
{
	if (!GetPlayer()) return 0;
	return GetPlayer()->getTeamLeaderID();
}

bool CCharacter::IsTeamLeader()
{
	Long	lTeamID = GetTeamID();

	if (lTeamID == GetPlyMainCha()->GetID())
		return true;

	return false;
}

void CCharacter::SetSideID(Long lSideID)
{
	 if (m_lSideID != lSideID)
	 {
		 m_lSideID = lSideID;
		 SynSideInfo();
	 }
}

// chPosType 1，装备栏.2，道具栏
SItemGrid* CCharacter::GetItem(Char chPosType, Long lItemID)
{
	SItemGrid	*pSItemCont = 0;

	if (chPosType == 1)
	{
		for (Char i = enumEQUIP_HEAD; i < enumEQUIP_NUM; i++)
		{
			if (m_SChaPart.SLink[i].sID == (Short)lItemID)
			{
				pSItemCont = m_SChaPart.SLink + i;
				break;
			}
		}
	}
	else if (chPosType == 2)
	{
		Short	sUseGNum = GetKitbag()->GetUseGridNum();
		for (Short i = sUseGNum - 1; i >= 0; i--)
		{
			pSItemCont = GetKitbag()->GetGridContByNum(i);
			if (pSItemCont && pSItemCont->sID == (Short)lItemID)
				break;
			else
				pSItemCont = 0;
		}
	}

	return pSItemCont;
}

// chPosType 1，装备栏.2，道具栏
SItemGrid* CCharacter::GetItem2(Char chPosType, Long lPosID)
{
	SItemGrid	*pSItemCont = 0;

	if (chPosType == 1)
	{
		pSItemCont = GetEquipItem((Char)lPosID);
	}
	else if (chPosType == 2)
	{
		pSItemCont = GetKitbag()->GetGridContByID((Short)lPosID);
	}

	return pSItemCont;
}

// 设置装备的有效性，涉及到道具自身的数值加成，已经到距对技能的影响
bool CCharacter::SetEquipValid(dbc::Char chEquipPos, bool bValid, bool bSyn)
{
	if (!GetPlayer() || IsBoat())
		return false;
	if (chEquipPos < 0 || chEquipPos >= enumEQUIP_NUM)
		return false;
	SItemGrid	*pSEquipIt = m_SChaPart.SLink + chEquipPos;
	if (!g_IsRealItemID(pSEquipIt->sID))
		return false;

	CCharacter	*pCMainCha = GetPlyMainCha();
	if (bSyn)
	{
		pCMainCha->m_CSkillBag.SetChangeSkillFlag(false);
		m_CChaAttr.ResetChangeFlag();
		SetBoatAttrChangeFlag(false);
		m_CSkillState.ResetSkillStateChangeFlag();
		pCMainCha->SetLookChangeFlag();
	}

	if (bValid)
		CheckItemValid(pSEquipIt);
	ChangeItem(bValid, pSEquipIt, chEquipPos);
	if (!bValid)
		CheckItemValid(pSEquipIt);
	GetPlyCtrlCha()->SkillRefresh();

	if (bSyn)
	{
		GetPlyMainCha()->SynSkillBag(enumSYN_SKILLBAG_MODI);
		SynSkillStateToEyeshot();
		g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
		GetPlayer()->RefreshBoatAttr();
		SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
		SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
		pCMainCha->SynLook(enumSYN_LOOK_CHANGE);
	}

	return true;
}

// 设置背包道具的有效性，如果该道具满足宠物条件（宠物道具置于特殊位置），则还涉及到该道具作为装备对角色的加成
bool CCharacter::SetKitbagItemValid(dbc::Short sPosID, bool bValid, bool bRecheckAttr, bool bSyn)
{
	SItemGrid *pSEspeGrid = GetKitbag()->GetGridContByID(sPosID);
	if (!pSEspeGrid)
		return false;
	if (pSEspeGrid->IsValid() == bValid)
		return true;

	if (bSyn)
		GetKitbag()->SetChangeFlag(false);
	Short sEspeGridID = 1;
	if (sPosID == sEspeGridID)
	{
		CItemRecord* pItem = GetItemRecordInfo(pSEspeGrid->sID);
		if(pItem == NULL)
			return false;
		if (pItem->sType == enumItemTypePet) // 宠物
		{
			if (bSyn)
			{
				m_CChaAttr.ResetChangeFlag();
				SetBoatAttrChangeFlag(false);
			}
			pSEspeGrid->SetValid();
			ChangeItem(bValid, pSEspeGrid, enumEQUIP_HEAD);
			if (bRecheckAttr || bSyn)
			{
				g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
				if (GetPlayer())
					GetPlayer()->RefreshBoatAttr();
			}
			if (bSyn)
			{
				if (GetPlayer())
					SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
				SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
			}
		}
	}
	pSEspeGrid->SetValid(bValid);
	if (bSyn)
		SynKitbagNew(enumSYN_KITBAG_ATTR);

	return true;
}

// 设置背包道具的有效性，如果该道具满足宠物条件（宠物道具置于特殊位置），则还涉及到该道具作为装备对角色的加成
bool CCharacter::SetKitbagItemValid(SItemGrid* pSItem, bool bValid, bool bRecheckAttr, bool bSyn)
{
	Short	sPosID;
	if (!GetKitbag()->GetPosIDByGrid(pSItem, &sPosID))
		return false;
	return SetKitbagItemValid(sPosID, bValid, bRecheckAttr, bSyn);
}

// 影响外观的道具，如翅膀，宠物等.
bool CCharacter::ItemIsAppendLook(SItemGrid* pSItem)
{
	if (!pSItem)
		return false;
	CItemRecord* pItemRec = GetItemRecordInfo( pSItem->sID );
	if (!pItemRec)
		return false;
	return pItemRec->IsFaceItem();
}

void CCharacter::SetLookChangeFlag(bool bChange)
{
	for (Char i = enumEQUIP_HEAD; i < enumEQUIP_NUM; i++)
		m_SChaPart.SLink[i].SetChange(bChange);
}

void CCharacter::SetEspeItemChangeFlag(bool bChange)
{
	Short	sEspeGridID = 1;
	SItemGrid *pGrid = GetKitbag()->GetGridContByID(sEspeGridID);
	if (pGrid)
	{
		CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
		if(pItem && pItem->sType == enumItemTypePet) // 宠物道具
			GetKitbag()->SetSingleChangeFlag(sEspeGridID);
	}
}

Char CCharacter::GetLookChangeNum(void)
{
	Char	chNum = 0;
	for (Char i = enumEQUIP_HEAD; i < enumEQUIP_NUM; i++)
		if (m_SChaPart.SLink[i].IsChange())
			chNum++;

	return chNum;
}

bool CCharacter::AddKitbagCapacity(dbc::Short sAddVal)
{
	if (GetKitbag()->AddCapacity(sAddVal))
	{
		SynKitbagCapacity();
		return true;
	}
	else
		return false;
}

// 检查精炼道具是否合法（道具有效）
bool CCharacter::CheckForgeItem(SForgeItem *pSItem)
{
	CPlayer	*pCPly = GetPlayer();
	if (!pCPly)
		return false;
	if (!pSItem)
		pSItem = pCPly->GetForgeItem();
	SItemGrid	*pSGridCont;
	for (int i = 0; i < defMAX_ITEM_FORGE_GROUP; i++)
	{
		for (short j = 0; j < pSItem->SGroup[i].sGridNum; j++)
		{
			pSGridCont = GetKitbag()->GetGridContByID(pSItem->SGroup[i].SGrid[j].sGridID);
			if (!pSGridCont || pSGridCont->sNum < pSItem->SGroup[i].SGrid[j].sItemNum)
				return false;
		}
	}

	return true;
}

// 检查道具的有效性
void CCharacter::CheckItemValid(SItemGrid* pCItem)
{
	if (!pCItem)
		return;
	pCItem->CheckValid();
	if (pCItem->IsValid())
	{
		g_CParser.DoString("check_item_valid", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, this, pCItem, DOSTRING_PARAM_END);
		pCItem->SetValid(g_CParser.GetReturnNumber(0) != 0 ? true : false);
	}
}

// 加载特殊道具
void CCharacter::CheckEspeItemGrid(void)
{
	Short	sEspeGridID = 1;
	SItemGrid *pGrid = GetKitbag()->GetGridContByID(sEspeGridID);
	if (pGrid)
	{
		CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
		if(pItem && pItem->sType == enumItemTypePet) // 宠物道具
			ChangeItem(true, pGrid, enumEQUIP_HEAD);
	}
}

// 以下几个背包的操作函数均包含特殊道具（装备）的因数
Short CCharacter::KbPushItem(bool bRecheckAttr, bool bSynAttr, SItemGrid *pGrid, Short &sPosID, bool bCommit, bool bSureOpr)
{
	if (!pGrid)
		return enumKBACT_ERROR_PUSHITEMID;
	CheckItemValid(pGrid);
	Short	sEspeGridID = 1;
	bool b2HasItem = GetKitbag()->GetGridContByID(sEspeGridID) ? true : false;
	Short sPushRet = GetKitbag()->Push(pGrid, sPosID, bCommit, bSureOpr);
	if (sPushRet == enumKBACT_SUCCESS || sPushRet == enumKBACT_ERROR_FULL)
	{
		if (!b2HasItem && sPosID == sEspeGridID) // 特殊格原来是空的，现在有道具了.
		{
			CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
			if(pItem == NULL)
				return enumKBACT_ERROR_PUSHITEMID;
			if (pItem->sType == enumItemTypePet)
			{
				if (bSynAttr)
				{
					m_CChaAttr.ResetChangeFlag();
					SetBoatAttrChangeFlag(false);
				}
				ChangeItem(true, pGrid, enumEQUIP_HEAD);
				if (bRecheckAttr || bSynAttr)
				{
					g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
					if (GetPlayer())
						GetPlayer()->RefreshBoatAttr();
				}
				if (bSynAttr)
				{
					if (GetPlayer())
						SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
					SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
				}
			}
		}
	}

	return sPushRet;
}

Short CCharacter::KbPopItem(bool bRecheckAttr, bool bSynAttr, SItemGrid *pGrid, Short sPosID, bool bCommit)
{
	if (!pGrid)
		return enumKBACT_ERROR_PUSHITEMID;
	Short	sEspeGridID = 1;
	Short sPushRet = GetKitbag()->Pop(pGrid, sPosID, bCommit);
	if (sPosID == sEspeGridID && sPushRet == enumKBACT_SUCCESS) // 成功操作特殊格
	{
		bool b2HasItem = GetKitbag()->GetGridContByID(sEspeGridID) ? true : false;
		if (!b2HasItem) // 特殊格没有道具了.
		{
			CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
			if(pItem == NULL)
				return enumKBACT_ERROR_PUSHITEMID;
			if (pItem->sType == enumItemTypePet)
			{
				if (bSynAttr)
				{
					m_CChaAttr.ResetChangeFlag();
					SetBoatAttrChangeFlag(false);
				}
				ChangeItem(false, pGrid, enumEQUIP_HEAD);
				if (bRecheckAttr || bSynAttr)
				{
					g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
					if (GetPlayer())
						GetPlayer()->RefreshBoatAttr();
				}
				if (bSynAttr)
				{
					if (GetPlayer())
						SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
					SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
				}
			}
		}
	}

	return sPushRet;
}

Short CCharacter::KbClearItem(bool bRecheckAttr, bool bSynAttr, Short sPosID)
{
	Short	sEspeGridID = 1;
	if (sPosID == sEspeGridID) // 特殊格
	{
		SItemGrid SGrid;
		SItemGrid *pGrid = GetKitbag()->GetGridContByID(sEspeGridID);
		CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
		if(pItem == NULL)
			return enumKBACT_ERROR_PUSHITEMID;
		if (pItem->sType == enumItemTypePet)
			SGrid = *pGrid;
		Short sRet = GetKitbag()->Clear(sPosID);
		if (sRet == enumKBACT_SUCCESS)
		{
			if (pItem->sType == enumItemTypePet) // 宠物
			{
				if (bSynAttr)
				{
					m_CChaAttr.ResetChangeFlag();
					SetBoatAttrChangeFlag(false);
				}
				ChangeItem(false, &SGrid, enumEQUIP_HEAD);
				if (bRecheckAttr || bSynAttr)
				{
					g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
					if (GetPlayer())
						GetPlayer()->RefreshBoatAttr();
				}
				if (bSynAttr)
				{
					if (GetPlayer())
						SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
					SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
				}
			}
		}
		return sRet;
	}
	else
		return GetKitbag()->Clear(sPosID);
}

Short CCharacter::KbClearItem(bool bRecheckAttr, bool bSynAttr, SItemGrid *pGrid, Short sNum)
{
	if (!pGrid)
		return enumKBACT_ERROR_PUSHITEMID;
	CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
	if(pItem == NULL)
		return enumKBACT_ERROR_PUSHITEMID;
	if (pItem->sType == enumItemTypePet) // 宠物
	{
		Short sEspeGridID = 1;
		SItemGrid SGrid = *pGrid;
		Short sPosID;
		Short sRet = GetKitbag()->Clear(pGrid, sNum, &sPosID);
		if (sRet == enumKBACT_SUCCESS)
		{
			if (sPosID == sEspeGridID) // 特殊格
			{
				if (GetKitbag()->GetNum(sEspeGridID) <= 0)
				{
					if (bSynAttr)
					{
						m_CChaAttr.ResetChangeFlag();
						SetBoatAttrChangeFlag(false);
					}
					ChangeItem(false, &SGrid, enumEQUIP_HEAD);
					if (bRecheckAttr || bSynAttr)
					{
						g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
						if (GetPlayer())
							GetPlayer()->RefreshBoatAttr();
					}
					if (bSynAttr)
					{
						if (GetPlayer())
							SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
						SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
					}
				}
			}
		}
		return sRet;
	}
	else
		return GetKitbag()->Clear(pGrid, sNum);
}

Short CCharacter::KbRegroupItem(bool bRecheckAttr, bool bSynAttr, Short sSrcPosID, Short sSrcNum, Short sTarPosID)
{
	Short sEspeGridID = 1;
	if (sSrcPosID == sEspeGridID || sTarPosID == sEspeGridID)
	{
		if (bSynAttr)
		{
			m_CChaAttr.ResetChangeFlag();
			SetBoatAttrChangeFlag(false);
		}

		SItemGrid SEspeGridOld, *pSEspeGridOld = GetKitbag()->GetGridContByID(sEspeGridID);
		if (pSEspeGridOld) SEspeGridOld = *pSEspeGridOld;
		Short sRet = GetKitbag()->Regroup(sSrcPosID, sSrcNum, sTarPosID);
		SItemGrid *pSEspeGridNew = GetKitbag()->GetGridContByID(sEspeGridID);
		if (SEspeGridOld.sID != 0)
		{
			CItemRecord* pItem = GetItemRecordInfo(SEspeGridOld.sID);
			if(pItem == NULL)
				return enumKBACT_ERROR_PUSHITEMID;
			if (pItem->sType == enumItemTypePet) // 宠物
				ChangeItem(false, &SEspeGridOld, enumEQUIP_HEAD);
		}
		if (pSEspeGridNew)
		{
			CItemRecord* pItem = GetItemRecordInfo(pSEspeGridNew->sID);
			if(pItem == NULL)
				return enumKBACT_ERROR_PUSHITEMID;
			if (pItem->sType == enumItemTypePet) // 宠物
				ChangeItem(true, pSEspeGridNew, enumEQUIP_HEAD);
		}

		if (bRecheckAttr || bSynAttr)
		{
			g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
			if (GetPlayer())
				GetPlayer()->RefreshBoatAttr();
		}
		if (bSynAttr)
		{
			if (GetPlayer())
				SyncBoatAttr(enumATTRSYN_ITEM_EQUIP);
			SynAttrToSelf(enumATTRSYN_ITEM_EQUIP);
		}

		return sRet;
	}
	else
		return GetKitbag()->Regroup(sSrcPosID, sSrcNum, sTarPosID);
}

void CCharacter::CheckBagItemValid(CKitbag* pCBag)
{
	if (!pCBag)
		return;
	SItemGrid	*pGridCont;
	Short sUsedNum = pCBag->GetUseGridNum();
	for (int i = 0; i < sUsedNum; i++)
	{
		pGridCont = pCBag->GetGridContByNum(i);
		CheckItemValid(pGridCont);
	}
}

void CCharacter::CheckLookItemValid(void)
{
	for (int i = 0; i < enumEQUIP_NUM; i++)
		CheckItemValid(m_SChaPart.SLink + i);
}

bool CCharacter::String2LookDate(std::string &strData)
{
	if (::Strin2LookData(&m_SChaPart, strData))
	{
		CheckLookItemValid();
		return true;
	}

	return false;
}

bool CCharacter::String2KitbagData(std::string &strData)
{
	if (::String2KitbagData(this->GetKitbag(), strData))
	{
		CheckBagItemValid(this->GetKitbag());
		return true;
	}

	return false;
}

bool CCharacter::String2KitbagTmpData(std::string &strData)
{
	if(m_pCKitbagTmp != NULL)
	{
		delete m_pCKitbagTmp;
		m_pCKitbagTmp = 0;
	}
	m_pCKitbagTmp = new CKitbag;
	m_pCKitbagTmp->Init(16);

	if (::String2KitbagData(m_pCKitbagTmp, strData))
	{
		CheckBagItemValid(m_pCKitbagTmp);
		return true;
	}

	return false;
}

// 执行精炼脚本
bool CCharacter::DoForgeLikeScript(dbc::cChar *cszFunc, dbc::Long &lRet)
{
	CPlayer	*pCPly = GetPlayer();
	if (!pCPly)
		return false;
	SForgeItem *pSItem = pCPly->GetForgeItem();

	int	nParamNum = 0;
	int nRetNum = 1;
	lua_getglobal(g_pLuaState, cszFunc);
	if (!lua_isfunction(g_pLuaState, -1)) // 不是函数名
	{
		lua_pop(g_pLuaState, 1);
		return false;
	}
	lua_pushlightuserdata(g_pLuaState, this);
	nParamNum++;
	for (int i = 0; i < defMAX_ITEM_FORGE_GROUP; i++)
	{
		lua_pushnumber(g_pLuaState, pSItem->SGroup[i].sGridNum);
		nParamNum++;
		for (short j = 0; j < pSItem->SGroup[i].sGridNum; j++)
		{
			lua_pushnumber(g_pLuaState, pSItem->SGroup[i].SGrid[j].sGridID);
			lua_pushnumber(g_pLuaState, pSItem->SGroup[i].SGrid[j].sItemNum);
			nParamNum += 2;
		}
	}
	//int nState = lua_pcall(g_pLuaState, nParamNum, LUA_MULTRET, 0);
	int nState = CParser::docall(g_pLuaState, nParamNum, 0);
	if (nState != 0)
	{
		LG("lua_err", "DoString %s\n", cszFunc);
		lua_callalert(g_pLuaState, nState);
		lua_settop(g_pLuaState, 0);
		return false;
	}
	lRet = (Long)lua_tonumber(g_pLuaState, -1);
	lua_settop(g_pLuaState, 0);

	return true;
}

bool CCharacter::DoLifeSkillcript(dbc::cChar *cszFunc, dbc::Long &lRet)
{
	CPlayer	*pCPly = GetPlayer();
	if (!pCPly)
		return false;
	SLifeSkillItem *pSItem = pCPly->GetLifeSkillItem();
	if(!pSItem)
		return false;
	int	nParamNum = 0;
	int nRetNum = 1;
	lua_getglobal(g_pLuaState, cszFunc);
	if (!lua_isfunction(g_pLuaState, -1)) // 不是函数名
	{
		lua_pop(g_pLuaState, 1);
		return false;
	}

	lua_pushlightuserdata(g_pLuaState, this);
	nParamNum++;
	lua_pushnumber(g_pLuaState,pSItem->sbagCount);
	nParamNum++;

	for (int i = 0; i < pSItem->sbagCount; i++)
	{
		lua_pushnumber(g_pLuaState, pSItem->sGridID[i]);
		nParamNum ++;
	}
	
	lua_pushnumber(g_pLuaState,pSItem->sReturn);
	nParamNum++;
	//int nState = lua_pcall(g_pLuaState, nParamNum, LUA_MULTRET, 0);
	int nState = CParser::docall(g_pLuaState, nParamNum, 0);
	if (nState != 0)
	{
		LG("lua_err", "DoString %s\n", cszFunc);
		lua_callalert(g_pLuaState, nState);
		lua_settop(g_pLuaState, 0);
		return false;
	}
	lRet = (Long)lua_tonumber(g_pLuaState, -1);
	lua_settop(g_pLuaState, 0);
	return true;
}

bool CCharacter::DoTigerScript(dbc::cChar *cszFunc)
{
	CPlayer	*pCPly = GetPlayer();
	if (!pCPly)
		return false;

	if(!strcmp(cszFunc, "TigerStart"))
	{
		int	nParamNum = 0;
		short sRet = 0;
		lua_getglobal(g_pLuaState, cszFunc);
		if (!lua_isfunction(g_pLuaState, -1)) // 不是函数名
		{
			lua_pop(g_pLuaState, 1);
			return false;
		}
		lua_pushlightuserdata(g_pLuaState, this);
		nParamNum++;
		for(int i = 0; i < 3; i++)
		{
			lua_pushnumber(g_pLuaState, m_sTigerSel[i]);
			nParamNum++;
		}
		//int nState = lua_pcall(g_pLuaState, nParamNum, LUA_MULTRET, 0);
		int nState = CParser::docall(g_pLuaState, nParamNum, 0);
		if (nState != 0)
		{
			LG("lua_err", "DoString %s\n", cszFunc);
			lua_callalert(g_pLuaState, nState);
			lua_settop(g_pLuaState, 0);
			return false;
		}

		for(int i = 0; i < 9; i++)
		{
			sRet = (short)lua_tonumber(g_pLuaState, i+1);
			if(sRet <= 0)
			{
				memset(m_sTigerItemID, 0, sizeof(m_sTigerItemID));
				memset(m_sTigerSel, 0, sizeof(m_sTigerSel));
				LG("lua_err", "DoString %s\n", cszFunc);
				lua_callalert(g_pLuaState, nState);
				lua_settop(g_pLuaState, 0);
				return false;
			}
			m_sTigerItemID[i] = sRet;
		}
		
		lua_settop(g_pLuaState, 0);
	}
	else if(!strcmp(cszFunc, "TigerStop"))
	{
		int	nParamNum = 0;
		lua_getglobal(g_pLuaState, cszFunc);
		if (!lua_isfunction(g_pLuaState, -1)) // 不是函数名
		{
			lua_pop(g_pLuaState, 1);
			return false;
		}
		lua_pushlightuserdata(g_pLuaState, this);
		nParamNum++;
		for(int i = 0; i < 9; i++)
		{
			lua_pushnumber(g_pLuaState, m_sTigerItemID[i]);
			nParamNum++;
		}
		for(int i = 0; i < 3; i++)
		{
			lua_pushnumber(g_pLuaState, m_sTigerSel[i]);
			nParamNum++;
		}
		//int nState = lua_pcall(g_pLuaState, nParamNum, LUA_MULTRET, 0);
		int nState = CParser::docall(g_pLuaState, nParamNum, 0);
		if (nState != 0)
		{
			LG("lua_err", "DoString %s\n", cszFunc);
			lua_callalert(g_pLuaState, nState);
			lua_settop(g_pLuaState, 0);
			return false;
		}

		lua_settop(g_pLuaState, 0);
	}

	return true;
}

void CCharacter::Reset()
{
	BreakAction();
	m_CSkillState.ResetSkillState();
	for (int i = 0; i < enumACTCONTROL_MAX; i++)
		SetActControl(i);
	m_SSeat.chIsSeat = 0;

	setAttr(ATTR_HP, m_CChaAttr.GetAttr(ATTR_MXHP));	// 当前HP
	setAttr(ATTR_SP, m_CChaAttr.GetAttr(ATTR_MXSP));	// 当前SP
}

void CCharacter::OnDie(DWORD dwCurTime)
{T_B
	if (GetExistState() >= enumEXISTS_WITHERING) // 消失
	{
		if (m_SExistCtrl.lWitherTime == -1)
		{
			return;
		}
		else if (dwCurTime - m_SExistCtrl.ulTick >= (uLong)m_SExistCtrl.lWitherTime)
		{
			if (IsPlayerCha()) // 玩家角色，不会在地图外等待
			{
				if (m_chSelRelive != enumEPLAYER_RELIVE_NONE)
				{
					if (m_chSelRelive == enumEPLAYER_RELIVE_CITY) // 回城复活
					{
						if (IsBoat()) // 船只
						{
							BackToCity(true);

							g_CParser.DoString("Relive", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
							if (getAttr(ATTR_HP) <= 0)
								//LG("重生计算错误", "角色 %s(%d)重生后算出的HP非法\n", GetLogName(), getAttr(ATTR_JOB));
								LG("renascence compute error", "character %s(%d)after renascence compute HP is unlawful\n", GetLogName(), (long)getAttr(ATTR_JOB));

							m_chSelRelive = enumEPLAYER_RELIVE_NONE;
							m_chReliveLv = 0;

						}
						else
						{
							BackToCity(true);
							
							g_CParser.DoString("Relive", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
							if (getAttr(ATTR_HP) <= 0)
								//LG("重生计算错误", "角色 %s(%d)重生后算出的HP非法\n", GetLogName(), getAttr(ATTR_JOB));
								LG("renascence compute error", "character %s(%d)after renascence compute HP is unlawful\n", GetLogName(), (long)getAttr(ATTR_JOB));

							m_chSelRelive = enumEPLAYER_RELIVE_NONE;
							m_chReliveLv = 0;

						}
					}
					else if (m_chSelRelive == enumEPLAYER_RELIVE_ORIGIN)
					{
						if (m_chReliveLv > 0)
						{
							SubMap	*pCMap = GetSubMap();
							GetSubMap()->GoOut(this);
							SetExistState(enumEXISTS_NATALITY);
							//m_timerScripts.Reset();

							m_chSelRelive = enumEPLAYER_RELIVE_NONE;
							m_chReliveLv = 0;

							g_CParser.DoString("Relive_now", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, m_chReliveLv, DOSTRING_PARAM_END);
							if (getAttr(ATTR_HP) <= 0)
								//LG("重生计算错误", "角色 %s(%d)重生后算出的HP非法\n", GetLogName(), getAttr(ATTR_JOB));
								LG("renascence compute error", "character %s(%d)after renascence compute HP is unlawful\n", GetLogName(), (long)getAttr(ATTR_JOB));
							SwitchMap(pCMap, pCMap->GetName(), GetPos().x, GetPos().y, false, enumSWITCHMAP_DIE, pCMap->GetCopyNO());
						}
					}
					else if (m_chSelRelive == enumEPLAYER_RELIVE_MAP)
					{
						if (GetSubMap() && !GetSubMap()->GetMapRes()->IsRepatriateDie())
						{
							std::string	strScript = "get_repatriate_city_";
							strScript += GetSubMap()->GetName();
							if (g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_STRING, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END))
								BackToCity(true, g_CParser.GetReturnString(0));
						}
					}
				}
			}
		}
	}
T_E}


void CCharacter::AfterStepMove(void)
{
	// 处理船只切换地图
	if (IsBoat())
	{
		const long	clSwitchDist = 50 * 100;
		const long	clTarDist = 60 * 100;

		bool	bSwitch = false;
		Char	szTarMapName[MAX_MAPNAME_LENGTH];
		Long	lTarX, lTarY = GetPos().y;
		Point	SrcPos = {0, lTarY};

		SubMap	*pMap = GetSubMap();
		const Rect	&area = pMap->GetRange();
		if (!strcmp(pMap->GetName(), "garner"))
		{
			if (GetPos().x >= area.rbtm.x - clSwitchDist)
			{
				bSwitch = true;
				//strcpy(szTarMapName, "magicsea");
				strncpy_s( szTarMapName, sizeof(szTarMapName), "magicsea", _TRUNCATE );
				lTarX = clTarDist;
				SrcPos.x = area.rbtm.x - clTarDist;
				pMap->MoveTo(this, SrcPos);
				//LG("enter_map", "玩家船只即将从garner切换到magicsea\n");
				LG("enter_map", "character boat will switch garner to magicsea\n");
			}
		}
		else if (!strcmp(pMap->GetName(), "magicsea"))
		{
			if (GetPos().x >= area.rbtm.x - clSwitchDist)
			{
				bSwitch = true;
				//strcpy(szTarMapName, "darkblue");
				strncpy_s( szTarMapName, sizeof(szTarMapName), "darkblue", _TRUNCATE );
				lTarX = clTarDist;
				SrcPos.x = area.rbtm.x - clTarDist;
				pMap->MoveTo(this, SrcPos);
				//LG("enter_map", "玩家船只即将从magicsea切换到darkblue\n");
				LG("enter_map", "character boat will switch magicsea to darkblue\n");
			}
			else if (GetPos().x <= area.ltop.x + clSwitchDist)
			{
				bSwitch = true;
				//strcpy(szTarMapName, "garner");
				strncpy_s( szTarMapName, sizeof(szTarMapName), "garner", _TRUNCATE );
				lTarX = area.rbtm.x - clTarDist;
				SrcPos.x = area.ltop.x + clTarDist;
				pMap->MoveTo(this, SrcPos);
				//LG("enter_map", "玩家船只即将从magicsea切换到garner\n");
				LG("enter_map", "character boat will switch magicsea to garner\n");
			}
		}
		else if (!strcmp(pMap->GetName(), "darkblue"))
		{
			if (GetPos().x <= area.ltop.x + clSwitchDist)
			{
				bSwitch = true;
				//strcpy(szTarMapName, "magicsea");
				strncpy_s( szTarMapName, sizeof(szTarMapName), "magicsea", _TRUNCATE );
				lTarX = area.rbtm.x - clTarDist;
				SrcPos.x = area.ltop.x + clTarDist;
				pMap->MoveTo(this, SrcPos);
				//LG("enter_map", "玩家船只即将从darkblue切换到magicsea\n");
				LG("enter_map", "character boat will switch darkblue to magicsea\n");
			}
		}

		if (bSwitch) SwitchMap(pMap, szTarMapName, lTarX, lTarY);
	}
	//
}

void CCharacter::SubsequenceMove()
{T_B
	if (!IsLiveing())
	{
		m_SMoveRedu.ulStartTick = GetTickCount();
		return; // 移动过程中死亡（步入有害状态区）的情况，不经过此分支
	}

	if (GetMoveState() != enumMSTATE_ON)
	{
		SetExistState(GetMoveStopState());
		if (GetMoveStopState() == enumEXISTS_SLEEPING && m_pCChaRecord->sDormancy == 0)
		{
			// LG("host", "[%s] move to sleep end, set waiting\n", GetName());
			SetExistState(enumEXISTS_WAITING);
		}
	}

	if (GetMoveState() & enumMSTATE_BLOCK)
		AddBlockCnt();

	if (GetMoveState() & enumMSTATE_CANCEL || !(GetMoveState() & enumMSTATE_INRANGE))
		m_SMoveRedu.ulStartTick = GetTickCount();

	m_SMoveInit.STargetInfo.chType = 0;
	if(!m_CAction.DoNext(enumACTION_MOVE, m_SMoveProc.sState))
		m_SMoveRedu.ulStartTick = GetTickCount();
T_E}

void CCharacter::SubsequenceFight()
{T_B
	m_SMoveRedu.ulStartTick = GetTickCount();

	if (!IsLiveing())
	{
		return; // 因战斗死亡的情况，不经过此分支
	}
	else if (GetFightState() != enumFSTATE_ON)
	{
		SetExistState(GetFightStopState());
	}

	m_CAction.DoNext(enumACTION_SKILL, m_SFightProc.sState);
T_E}

//=============================================================================
// 通告行动失败原因
// chType 行动类型
// chReason 失败原因，参见.\client\scripts\table\NotifySet.txt
//=============================================================================
void CCharacter::FailedActionNoti(Char chType, Char chReason)
{T_B
	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_FAILEDACTION);
	WRITE_LONG(pk, GetID());
	WRITE_CHAR(pk, chType);
	WRITE_CHAR(pk, chReason);

	ReflectINFof(this, pk);
T_E}

void CCharacter::EndAction(RPACKET pk)
{T_B
	if (!IsLiveing())
	{
		m_CLog.Log("$$$PacketID:\t%u\n", m_ulPacketID);
		//m_CLog.Log("拒绝行动请求（自身不存在）\n\n");
		m_CLog.Log("refuse action requset(oneself is inexistence)\n\n");return;
	}

	m_CAction.End();

	// log
	m_CLog.Log("===Recieve(EndAction):\tTick %u\n", GetTickCount());
	//m_CLog.Log("\t全部行动数目：%d，当前行动号：%d.\n", m_CAction.GetActionNum(), m_CAction.GetCurActionNo());
	m_CLog.Log("\tall action numbers：%d,currently actionID%d.\n", m_CAction.GetActionNum(), m_CAction.GetCurActionNo());
	//
T_E}

void CCharacter::BreakAction(RPACKET pk)
{
	m_CAction.Interrupt();
	ResetMove();
	ResetFight();
}

void CCharacter::AfterAttrChange(int nIdx, LONG64 lOldVal, LONG64 lNewVal)
{
}

void CCharacter::Die()
{T_B
	SubMap	*pCMap = GetSubMap();

	BreakAction();
	m_CSkillState.ResetSkillState();
	for (int i = 0; i < enumACTCONTROL_MAX; i++)
		SetActControl(i);
	m_SSeat.chIsSeat = 0;
	m_chSelRelive = enumEPLAYER_RELIVE_NONE;
	m_chReliveLv = 0;
	if (IsPlayerOwnCha() && pCMap && !pCMap->GetMapRes()->IsRepatriateDie())
	{
		std::string	strScript = "check_repatriate_";
		strScript += pCMap->GetName();
		if (g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END))
		{
			if (!g_CParser.GetReturnNumber(0))
			{
				std::string	strScript = "get_repatriate_hint_";
				strScript += pCMap->GetName();
				if (g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_STRING, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END))
					SetRelive(enumEPLAYER_RELIVE_MAP, 0, g_CParser.GetReturnString(0));
			}
		}
	}

	//if(IsPlayerCha() && pCMap)//2006.10.12wsj
	//{
	//	pCMap->OnPlayerDie(this);
	//}

	if(IsPlayerCha())
	{
		GetPlyMainCha()->ResetChaRelive();
	}

	if(IsPlayerFocusCha()) // 玩家当前的控制焦点，则无时间控制
	{
		SetWitherTime(0);
		if (IsBoat())
			SetResumeTime(0);
		else
			SetResumeTime(-1);
	}

	// 取消他的交易信息或者船只交易取消
	if( GetPlayer() && (this == GetPlyMainCha() || IsBoat()) )
	{
		if( GetPlyMainCha()->m_pTradeData )
		{
			DWORD dwCharID = ( GetPlyMainCha() == GetPlyMainCha()->m_pTradeData->pRequest ) ? GetPlyMainCha()->m_pTradeData->pAccept->GetID():
					GetPlyMainCha()->m_pTradeData->pRequest->GetID();
			g_TradeSystem.Cancel( mission::TRADE_CHAR, *GetPlyMainCha(), dwCharID );
		}

		BYTE byNumBoat = GetPlayer()->GetNumBoat();
		for( BYTE i = 0; i < byNumBoat; i++ )
		{
			CCharacter* pBoat = GetPlayer()->GetBoat( i );
			if( pBoat )
			{
				if( pBoat->m_pTradeData )
				{
					DWORD dwCharID = ( pBoat == pBoat->m_pTradeData->pRequest ) ? pBoat->m_pTradeData->pAccept->GetID():
						pBoat->m_pTradeData->pRequest->GetID();
					g_TradeSystem.Cancel( mission::TRADE_BOAT, *pBoat, dwCharID );
				}
			}
		}
	}

	if (!IsPlayerCha() && pCMap)
	{
		if (InOutMapQueue())
		{
			//LG("重复的图外角色", "角色%s，已经存在于地图外队列!\n", GetLogName());
		}
		else
		{
			SetInOutMapQueue();
			SSwitchMapInfo	SwitchInfo;

			SwitchInfo.pSrcMap = pCMap;
			//strcpy(SwitchInfo.szSrcMapName, pCMap->GetName());
			strncpy_s( SwitchInfo.szSrcMapName, sizeof(SwitchInfo.szSrcMapName), pCMap->GetName(), _TRUNCATE );
			SwitchInfo.SSrcPos = GetShape().centre;
			m_SFightProc.sState = enumFSTATE_TARGET_NO;
			//strcpy(SwitchInfo.szTarMapName, SwitchInfo.szSrcMapName);
			strncpy_s( SwitchInfo.szTarMapName, sizeof(SwitchInfo.szTarMapName), SwitchInfo.szSrcMapName, _TRUNCATE );
			Point SPos;
			SPos = m_STerritory.centre;
			SPos.move(rand() % 360, 3 * 100);
			if (!pCMap->IsValidPos(SPos.x, SPos.y))
				SPos = m_STerritory.centre;
			SwitchInfo.STarPos = SPos;
			pCMap->m_COutMapCha.Add(this, GetID(), &SwitchInfo, enumCHA_TIMEER_ENTERMAP, m_SExistCtrl.lWitherTime, m_SExistCtrl.lResumeTime);
		}
	}
T_E}

void CCharacter::JustDie(CCharacter *pCSrcCha)
{
	g_EventHandler.Event_ChaDie(this, pCSrcCha);
}

//=============================================================================
// 只限于同种角色形态的位置切换
//=============================================================================
void CCharacter::MoveCity(cChar *szCityName, Long lMapCopyNO, Char chSwitchType)
{
	SBirthPoint	*pSBirthP;
	if (!strcmp(szCityName, ""))
		pSBirthP = GetRandBirthPoint(GetLogName(), GetBirthCity());
	else
		pSBirthP = GetRandBirthPoint(GetLogName(), szCityName);

	if(pSBirthP != NULL)
		SwitchMap(GetSubMap(), pSBirthP->szMapName, (pSBirthP->x + 2 - rand() % 4) * 100, (pSBirthP->y + 2 - rand() % 4) * 100, true, chSwitchType, lMapCopyNO);
	else
	{
		LG("birth_error", "invalid birth place\n");
	}
}

//=============================================================================
// 返回城市
//=============================================================================
void CCharacter::BackToCity(bool bDie, cChar *szCityName, Long lMapCpyNO, Char chSwitchType)
{
	SubMap	*pCMap = GetSubMap();
	pCMap->GoOut(this);
	SetToMainCha(bDie);
	CCharacter	*pCMainCha = GetPlyMainCha();
	pCMainCha->SetExistState(enumEXISTS_NATALITY);
	//pCMainCha->m_timerScripts.Reset();

	if(bDie && (!strcmp(pCMap->GetName(), "guildwar")))
	{
		if(GetGuildType() == emGldTypePirate)
		{
			szCityName = "guildwarpirateside";
		}
		else
		{
			szCityName = "guildwarnavyside";
		}
	}
	else if(bDie && (!strcmp(pCMap->GetName(), "guildwar2")))
	{
		if(GetGuildType() == emGldTypePirate)
		{
			szCityName = "guildwarpirateside2";
		}
		else
		{
			szCityName = "guildwarnavyside2";
		}
	}

	if (!szCityName || !strcmp(szCityName, ""))
		pCMainCha->ResetBirthInfo();
	else
	{
		SBirthPoint	*pSBirthP;
		pSBirthP = GetRandBirthPoint(GetLogName(), szCityName);
		SetBirthMap(pSBirthP->szMapName);
		SetPos(pSBirthP->x * 100, pSBirthP->y * 100);
	}
	pCMainCha->SwitchMap(pCMap, pCMainCha->GetBirthMap(), pCMainCha->GetPos().x, pCMainCha->GetPos().y, false, chSwitchType, lMapCpyNO);
}

void CCharacter::BackToCityEx(bool bDie, cChar *szCityName, Long lMapCpyNO, Char chSwitchType)
{
	SubMap	*pCMap = GetSubMap();
	pCMap->GoOut(this);
	SetToMainCha(bDie);
	CCharacter	*pCMainCha = GetPlyMainCha();
	pCMainCha->SetExistState(enumEXISTS_NATALITY);
	//pCMainCha->m_timerScripts.Reset();

	if (!szCityName || !strcmp(szCityName, ""))
		pCMainCha->ResetBirthInfo();
	else
	{
		SBirthPoint	*pSBirthP;
		pSBirthP = GetRandBirthPoint(GetLogName(), szCityName);
		SetBirthMap(pSBirthP->szMapName);
		SetPos(pSBirthP->x * 100, pSBirthP->y * 100);
	}
	pCMainCha->SwitchMap(pCMap, pCMainCha->GetBirthMap(), pCMainCha->GetPos().x, pCMainCha->GetPos().y, false, chSwitchType, lMapCpyNO);
}

void CCharacter::SetToMainCha(bool bDie)
{
	if (!IsPlayerCha())
		return;
	CCharacter	*pCMainC = GetPlyMainCha();
	m_pCPlayer->SetLoginCha(enumLOGIN_CHA_MAIN, 0);
	m_pCPlayer->SetCtrlCha(pCMainC);
	if (IsBoat())
	{
		if (bDie)
			pCMainC->BoatDie(*this, *this);
		SetBirthMap("");
		SetPos(-1, -1);
	}
}

void CCharacter::BickerNotice( const char szData[], ... )
{
	// Modify by lark.li 20080801 begin
	char szTemp[250];
	memset(szTemp, 0, sizeof(szTemp));
	va_list list;
	va_start( list, szData );
	//_vsnprintf(szTemp, sizeof(szTemp) - 1, szData, list );
	_vsnprintf_s(szTemp, sizeof(szTemp),_TRUNCATE, szData, list );
	//vsprintf( szTemp, szData, list );
	// End
	va_end( list );

	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_BICKER_NOTICE );
	WRITE_STRING(packet, szTemp);
	
	this->ReflectINFof( this, packet );
}

void CCharacter::SystemNotice( const char szData[], ... )
{T_B
	// Modify by lark.li 20080801 begin
	char szTemp[250];
	memset(szTemp, 0, sizeof(szTemp));
	va_list list;
	va_start( list, szData );
	//_vsnprintf(szTemp, sizeof(szTemp) - 1, szData, list );
	_vsnprintf_s(szTemp, sizeof(szTemp),_TRUNCATE, szData, list );
	//vsprintf( szTemp, szData, list );
	// End
	va_end( list );

	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_SYSINFO );
	WRITE_SEQ(packet, szTemp, uShort( strlen(szTemp) ) + 1 );
	
	this->ReflectINFof( this, packet );
T_E}

void CCharacter::PopupNotice( const char szData[], ... )
{T_B
	// Modify by lark.li 20080801 begin
	char szTemp[250];
	memset(szTemp, 0, sizeof(szTemp));
	va_list list;
	va_start( list, szData );
	//_vsnprintf(szTemp, sizeof(szTemp) - 1, szData, list );
	_vsnprintf_s(szTemp, sizeof(szTemp),_TRUNCATE, szData, list );
	//vsprintf( szTemp, szData, list );
	// End
	va_end( list );

	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_POPUP_NOTICE );
	WRITE_SEQ(packet, szTemp, uShort( strlen(szTemp) ) + 1 );

	this->ReflectINFof( this, packet );
T_E}

BOOL CCharacter::SetMissionPage( DWORD dwNpcID, BYTE byPrev, BYTE byNext, BYTE byState )
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisSetMissionPage( dwNpcID, byPrev, byNext, byState );
		return TRUE;
	}
	return FALSE;
T_E}

BOOL CCharacter::GetMissionPage( DWORD dwNpcID, BYTE& byPrev, BYTE& byNext, BYTE& byState )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetMissionPage( dwNpcID, byPrev, byNext, byState );
	}
	return FALSE;
T_E}

BOOL CCharacter::SetTempData( DWORD dwNpcID, WORD wID, BYTE byState, BYTE byType )
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisSetTempData( dwNpcID, wID, byState, byType );
		return TRUE;
	}
	return FALSE;
T_E}

BOOL CCharacter::GetTempData( DWORD dwNpcID, WORD& wID, BYTE& byState, BYTE& byType )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetTempData( dwNpcID, wID, byState, byType );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetNumMission( DWORD dwNpcID, BYTE& byNum )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetNumMission( dwNpcID, byNum );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetNextMission( DWORD dwNpcID, BYTE& byIndex, BYTE& byID, BYTE& byState )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetNextMission( dwNpcID, byIndex, byID, byState );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetMissionInfo( DWORD dwNpcID, BYTE byIndex, BYTE& byID, BYTE& byState )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetMissionInfo( dwNpcID, byIndex, byID, byState );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetCharMission( DWORD dwNpcID, BYTE byID, BYTE& byState )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetCharMission( dwNpcID, byID, byState );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetMissionState( DWORD dwNpcID, BYTE& byState )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetMissionState( dwNpcID, byState );
	}
	return FALSE;
T_E}

BOOL CCharacter::AddMissionState( DWORD dwNpcID, BYTE byID, BYTE byState )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisAddMissionState( dwNpcID, byID, byState );
	}
	return FALSE;
T_E}

void CCharacter::SetEntityTime( DWORD dwTime )
{
	if( GetPlayer() == NULL )
		return;
	GetPlayer()->SetEntityTime( dwTime );
}

DWORD CCharacter::GetEntityTime()
{
	if( GetPlayer() == NULL )
		return 0;
	
	DWORD dwTime;
	if( !GetPlayer()->GetEntityTime( dwTime ) )
		return 0;

	return GetTickCount() - dwTime;
}

BOOL CCharacter::SetEntityState( DWORD dwEntityID, BYTE byState )
{
	if( GetPlayer() == NULL )
		return FALSE;
	// 同步到客户端
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_ENTITY_CHGSTATE );
	WRITE_LONG(packet, dwEntityID );
	WRITE_CHAR(packet, byState );
	ReflectINFof( this, packet );
	return TRUE;
}

BOOL CCharacter::ResetMissionState( mission::CTalkNpc& npc )
{T_B
	if( GetPlayer() == NULL )
		return FALSE;
	DWORD dwNpcID = npc.GetID();
	GetPlayer()->MisClearMissionState( dwNpcID );

	BYTE byState = 0;
	npc.MissionProc( *this, byState );

	// 同步到客户端
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_NPCSTATECHG );
	WRITE_LONG(packet, npc.GetID() );
	WRITE_CHAR(packet, byState );
	ReflectINFof( this, packet );
	return TRUE;
T_E}

BOOL CCharacter::ClearMissionState( DWORD dwNpcID )
{T_B	
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearMissionState( dwNpcID );
	}
	return FALSE;
T_E}

void CCharacter::MisLog()
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisGetMisLog();
	}
T_E}

void CCharacter::MisLogInfo( WORD wMisID )
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisGetMisLogInfo( wMisID );
	}
T_E}

void CCharacter::MisLogClear( WORD wMisID )
{T_B
	if( GetPlayer() )
	{
		if( GetPlayer()->IsLuanchOut() )
		{
			if( GetPlayer()->GetLuanchOut()->m_pTradeData ) 
			{
				//SystemNotice( "当前交易状态,不可以中断任务!" );
				SystemNotice( RES_STRING(GM_CHARACTER_CPP_00001) );
				return;
			}
		}

		if( m_pTradeData )
		{
			//SystemNotice( "当前交易状态,不可以中断任务!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00001) );
			return;
		}
		GetPlayer()->MisCancelRole( wMisID );
	}
T_E}

BOOL CCharacter::ConvoyNpc( WORD wRoleID, BYTE byIndex, WORD wNpcCharID, BYTE byAiType )
{T_B
	if( GetPlayer() )
	{
		Point pos;
		pos = GetPos();
		pos.x += rand()%100;
		pos.y += rand()%100;
		CCharacter* pNpc = this->GetSubMap()->ChaSpawn( wNpcCharID, enumCHACTRL_NPC, rand()%360, &pos, TRUE );
		if( !pNpc )
		{
			return FALSE;
		}

		// 设置两者相关性
		pNpc->m_AIType = byAiType;
		pNpc->m_AITarget = this;

		if( !GetPlayer()->MisAddFollowNpc( wRoleID, byIndex, wNpcCharID, pNpc, byAiType ) )
		{
			pNpc->Free();
			return FALSE;
		}
		return TRUE;
	}
	return FALSE;
T_E}

BOOL CCharacter::ClearConvoyNpc( WORD wRoleID, BYTE byIndex )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearFollowNpc( wRoleID, byIndex );
	}
	return FALSE;
T_E}

BOOL CCharacter::ClearAllConvoyNpc( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearAllFollowNpc( wRoleID );
	}
	return FALSE;	
T_E}

BOOL CCharacter::HasConvoyNpc( WORD wRoleID, BYTE byIndex )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisHasFollowNpc( wRoleID, byIndex );
	}
	return FALSE;
T_E}

BOOL CCharacter::IsConvoyNpc( WORD wRoleID, BYTE byIndex, WORD wNpcCharID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisIsFollowNpc( wRoleID, byIndex, wNpcCharID );
	}
	return FALSE;
T_E}

BOOL CCharacter::AddTrigger( const mission::TRIGGER_DATA& Data )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisAddTrigger( Data );
	}
	return FALSE;
T_E}

BOOL CCharacter::ClearTrigger( WORD wTriggerID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearTrigger( wTriggerID );
	}
	return FALSE;
T_E}

BOOL CCharacter::DeleteTrigger( WORD wTriggerID )
{
	if( GetPlayer() )
	{
		return GetPlayer()->MisDelTrigger( wTriggerID );
	}

	return FALSE;
}

BOOL CCharacter::AddRole( WORD wID, WORD wParam )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisAddRole( wID, wParam );
	}
	return FALSE;
T_E}

BOOL CCharacter::HasRole( WORD wID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisHasRole( wID );
	}
	return FALSE;
T_E}

BOOL CCharacter::ClearRole( WORD wID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearRole( wID );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetMisScriptID( WORD wID, WORD& wScriptID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetMisScript( wID, wScriptID );
	}
	return FALSE;	
T_E}
BOOL CCharacter::SetMissionPending( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisSetMissionPending( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::SetMissionComplete( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisSetMissionComplete( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::SetMissionFailure( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisSetMissionFailure( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::HasMissionFailure( WORD wRoleID )
{
	if( GetPlayer() )
	{
		return GetPlayer()->MisHasMissionFailure( wRoleID );
	}
	return FALSE;
}

BOOL CCharacter::IsRoleFull()
{T_B
	if( GetPlayer() ) 
	{
		return GetPlayer()->MisIsRoleFull(); 
	}
	return TRUE; 
T_E}

BOOL CCharacter::SetFlag( WORD wID, WORD wFlag )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisSetFlag( wID, wFlag );
	}
	return FALSE;
T_E}

BOOL CCharacter::ClearFlag( WORD wID, WORD wFlag )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearFlag( wID, wFlag );
	}
	return FALSE;
T_E}

BOOL CCharacter::IsFlag( WORD wID, WORD wFlag )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisIsSet( wID, wFlag );
	}
	return FALSE;
T_E}

BOOL CCharacter::IsValidFlag( WORD wFlag )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisIsValid( wFlag );
	}
	return FALSE;
T_E}

BOOL CCharacter::SetRecord( WORD wRec )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisSetRecord( wRec );
	}
	return FALSE;
T_E}

BOOL CCharacter::ClearRecord( WORD wRec )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisClearRecord( wRec );
	}
	return FALSE;
T_E}

BOOL CCharacter::IsRecord( WORD wRec )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisIsRecord( wRec );
	}
	return FALSE;
T_E}

BOOL CCharacter::IsValidRecord( WORD wRec )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisIsValidRecord( wRec );
	}
	return FALSE;
T_E}

BOOL CCharacter::HasRandMission( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisHasRandMission( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::AddRandMission( WORD wRoleID, WORD wScriptID, BYTE byType, BYTE byLevel, DWORD dwExp, DWORD dwMoney, USHORT sPrizeData, USHORT sPrizeType, BYTE byNumData )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisAddRandMission( wRoleID, wScriptID, byType, byLevel, dwExp, dwMoney, sPrizeData, sPrizeType, byNumData );
	}
	return FALSE;
T_E}

BOOL CCharacter::SetRandMissionData( WORD wRoleID, BYTE byIndex, const mission::MISSION_DATA& RandData )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisSetRandMissionData( wRoleID, byIndex, RandData );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetRandMission( WORD wRoleID, BYTE& byType, BYTE& byLevel, DWORD& dwExp, DWORD& dwMoney, USHORT& sPrizeData, USHORT& sPrizeType, BYTE& byNumData )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetRandMission( wRoleID, byType, byLevel, dwExp, dwMoney, sPrizeData, sPrizeType, byNumData );
	}
	return FALSE;
T_E}

BOOL CCharacter::GetRandMissionData( WORD wRoleID, BYTE byIndex, mission::MISSION_DATA& RandData )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetRandMissionData( wRoleID, byIndex, RandData );
	}
	return FALSE;
T_E}

BOOL CCharacter::HasSendNpcItemFlag( WORD wRoleID, WORD wNpcID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisHasSendNpcItemFlag( wRoleID, wNpcID );
	}
	return FALSE;
T_E}

BOOL CCharacter::NoSendNpcItemFlag( WORD wRoleID, WORD wNpcID )
{
	if( GetPlayer() )
	{
		return GetPlayer()->MisNoSendNpcItemFlag( wRoleID, wNpcID );
	}
	return FALSE;
}

BOOL CCharacter::HasRandMissionNpc( WORD wRoleID, WORD wNpcID, WORD wAreaID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisHasRandMissionNpc( wRoleID, wNpcID, wAreaID );
	}
	return FALSE;
T_E}

BOOL CCharacter::CompleteRandMission( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisCompleteRandMission( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::FailureRandMission( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisFailureRandMission( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::AddRandMissionNum( WORD wRoleID )
{
	if( GetPlayer() )
	{
		return GetPlayer()->MisAddRandMissionNum( wRoleID );
	}
	return FALSE;
}

BOOL CCharacter::ResetRandMission( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisResetRandMission( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::ResetRandMissionNum( WORD wRoleID )
{
	return ( GetPlayer() ) ? GetPlayer()->MisResetRandMissionNum( wRoleID ) : FALSE;
}

BOOL CCharacter::HasRandMissionCount( WORD wRoleID, WORD wCount )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisGetRandMissionCount( wRoleID ) >= wCount;
	}
	return FALSE;
T_E}

BOOL CCharacter::GetRandMissionCount( WORD wRoleID, WORD& wCount )
{T_B
	if( GetPlayer() )
	{
		wCount = GetPlayer()->MisGetRandMissionCount( wRoleID );
		return TRUE;
	}
	return FALSE;
T_E}

BOOL CCharacter::GetRandMissionNum( WORD wRoleID, WORD& wNum )
{T_B
	if( GetPlayer() ) 
	{
		wNum = GetPlayer()->MisGetRandMissionNum( wRoleID );
		return TRUE;
	}
	return FALSE;
T_E}

BOOL CCharacter::SafeSale( BYTE byIndex, BYTE byCount, WORD& wItemID, DWORD& dwMoney )
{T_B
	MONITOR
	if(GetPlyMainCha()->GetKitbag()->IsPwdLocked())
	{
		//SystemNotice("道具栏已锁定!");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00002));
		return FALSE;
	}

	//add by ALLEN 2007-10-16
		if(GetPlyMainCha()->IsReadBook())
	{
		//SystemNotice("正在读书，不可以交易!");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00003));
		return FALSE;
	}

	USHORT sSize = GetKitbag()->GetCapacity();
	if( byIndex >= sSize )
	{
		//SystemNotice( "物品栏位索引错误!ID = %d", byIndex );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00004), byIndex );
		return FALSE;
	}

	wItemID = (WORD)GetKitbag()->GetID(byIndex);
	CItemRecord* pItem = GetItemRecordInfo( wItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "物品ID错误，无法找到该物品信息!ID = %d", wItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00005), wItemID );
		return FALSE;
	}

	if( !pItem->chIsTrade )
	{
		//SystemNotice( "该物品《%s》不可交易!", pItem->szName );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00006), pItem->szName );
		return FALSE;
	}

	//	2008-9-17	yangyinyu	change	begin!
	::SItemGrid*	sig	=	GetKitbag()->GetGridContByID(	byIndex	);

	if(	sig	)
	{
		if(	sig->dwDBID )
		{
			SystemNotice(	RES_STRING(GM_CHARACTER_CPP_00117)	);
			return	FALSE;
		}
	};
	//	2008-9-17	yangyinyu	change	end!

	if( !GetKitbag()->HasItem( byIndex ) )
	{
		//SystemNotice( "未发现该物品索引栏位(%d)的物品信息!", byIndex );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00007), byIndex );
		return FALSE;
	}

	if( GetKitbag()->GetNum(byIndex) < byCount )
	{
		//SystemNotice( "出售物品《%s》数量(%d)不足，总数(%d)!", pItem->szName, byCount, wItemID );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00008), pItem->szName, byCount, wItemID );
		char szData[128];
		CFormatParameter param(3);
		param.setString( 0, pItem->szName );
		param.setDouble( 1, byCount );
		param.setLong( 2, wItemID );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00008, param, szData );
		SystemNotice( szData );
		return FALSE;
	}
	
	// 判断丢弃船长证明
	DWORD dwPrice = pItem->lPrice;
	if( pItem->sType == enumItemTypeBoat )
	{
		DWORD dwBoatID = (DWORD)GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, byIndex );
		CCharacter* pBoat = GetPlayer()->GetBoat( dwBoatID );
		if( !pBoat )
		{
			//SystemNotice( "获取船只价格信息失败!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00009) );
			return FALSE;
		}
		dwPrice = (long)pBoat->getAttr( ATTR_BOAT_PRICE );

		if( !BoatClear( GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, byIndex ) ) )
		{
			//SystemNotice( "出售《%s》失败，你正在使用该船!", pItem->szName );			
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00010), pItem->szName );			
			return enumITEMOPT_ERROR_UNUSE;
		}
	}

	GetKitbag()->SetChangeFlag( false );
	m_CChaAttr.ResetChangeFlag();
	SetBoatAttrChangeFlag(false);
	
	SItemGrid Grid;
	Grid.sNum = byCount;
	KbPopItem( true, false, &Grid, byIndex );

	if( Grid.sEndure[0] == Grid.sEndure[1] )
	{
		dwMoney = (dwPrice>>1) * byCount;
	}
	else
	{
		dwMoney = (dwPrice>>3) * byCount;
	}
	DWORD dwCharMoney = (long)getAttr( ATTR_GD );
	dwCharMoney += dwMoney;

	setAttr( ATTR_GD, dwCharMoney );
	SynAttr( enumATTRSYN_TRADE );
	SyncBoatAttr(enumATTRSYN_TRADE);
	
	//SystemNotice( "你出售了%d个《%s》物品，获得了(%d)金钱，总额(%d)!", byCount, pItem->szName, dwMoney, dwCharMoney );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00011), byCount, pItem->szName, dwMoney, dwCharMoney );
	char szData[128]="";
	CFormatParameter param(4);
	param.setDouble( 0, byCount );
	param.setString( 1,pItem->szName );
	param.setLong( 2, dwMoney );
	param.setLong( 3, dwCharMoney );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00011, param, szData );
	SystemNotice( szData );
	char szLog[128] = "";
	//sprintf( szLog, "%d个%s", byCount, pItem->szName );
	_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", byCount, pItem->szName );
	TL( CHA_SELL, GetName(), "", szLog );

	// 更新任务物品计数
	RefreshNeedItem( wItemID );

	// 同步物品数据
	SynKitbagNew( enumSYN_KITBAG_FROM_NPC );

	// 数据库保存
	SaveAssets();
	LogAssets(enumLASSETS_TRADE);

	//	2008-8-19	yangyinyu	add	begin!
	//::lgtool_PrintGetType( RES_STRING(GM_CHARACTER_CPP_00118) );
	//CItemRecord*	cir	=	::GetItemRecordInfo(	Grid.sID	);
	//::lgtool_PrintItem(	GetPlyMainCha()->GetName(),	GetPlyMainCha()->m_ID,	byCount,	cir,	&Grid	);
	//	2008-8-19	yangyinyu	add	end!

	return TRUE;
T_E}

BOOL CCharacter::ExchangeReq(short sSrcID, short sSrcNum, short sTarID, short sTarNum)
{
	//char szNpc[128] = "系统";
	char szNpc[128];
	//strncpy( szNpc, RES_STRING(GM_CHARACTER_CPP_00012), 128 - 1 );
	strncpy_s( szNpc, sizeof(szNpc), RES_STRING(GM_CHARACTER_CPP_00012), _TRUNCATE );

	if (!GetPlyMainCha()->HasItem( sSrcID, sSrcNum ))
	{
		//SystemNotice("你没有兑换所需的物品!");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00013));

		WPACKET packet = GETWPACKET();
		WRITE_CMD(packet, CMD_MC_BLACKMARKET_EXCHANGE_ASR);
		WRITE_CHAR(packet, 0);
		this->ReflectINFof( this, packet );

		return FALSE;
	}

	//add by jilinlee 2007.8.3  防止玩家传入源道具数量为0，进行复制
	if (g_CParser.DoString("Can_Exchange", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_NUMBER, 4, sSrcID, sSrcNum, sTarID, sTarNum, DOSTRING_PARAM_END))
	{
		if(!g_CParser.GetReturnNumber(0))
		{
			//SystemNotice("数据错误，兑换失败!");
			SystemNotice(RES_STRING(GM_CHARACTER_CPP_00014));
			return FALSE;
		}
	}
	else
	{
		return FALSE;
	}
	//~~

	GetPlyMainCha()->TakeItem( sSrcID, sSrcNum, szNpc );
	GetPlyMainCha()->AddItem( sTarID, sTarNum, szNpc );
	//SystemNotice("兑换成功!");

	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_BLACKMARKET_EXCHANGE_ASR);
	WRITE_CHAR(packet, 1);
	WRITE_SHORT(packet, sSrcID);
	WRITE_SHORT(packet, sSrcNum);
	WRITE_SHORT(packet, sTarID);
	WRITE_SHORT(packet, sTarNum);
	this->ReflectINFof( this, packet );

	return TRUE;
}

BOOL CCharacter::SafeBuy( WORD wItemID, BYTE byCount, BYTE byIndex, DWORD& dwMoney )
{T_B
	MONITOR
	if(GetPlyMainCha()->GetKitbag()->IsPwdLocked())
	{
		//SystemNotice("道具栏已锁定!");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00002));
		return FALSE;
	}

	//add by ALLEN 2007-10-16
		if(GetPlyMainCha()->IsReadBook())
	{
		//SystemNotice("正在读书，不可以交易!");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00003));
		return FALSE;
	}

	CItemRecord* pItem = GetItemRecordInfo( wItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "物品ID错误，无法找到该物品信息!ID = %d", wItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00005), wItemID );
		return FALSE;
	}

	if(byCount <= 0)
	{
		//SystemNotice("数据错误，购买失败!");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00015));
		return FALSE;
	}
	
	dwMoney = pItem->lPrice * byCount;
	USHORT sSize = GetKitbag()->GetCapacity();
	if( byIndex >= sSize )
	{
		//SystemNotice( "物品栏位索引(%d)无效!", byIndex );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00016), byIndex );
		return FALSE;
	}

	if( GetKitbag()->GetID( byIndex ) == wItemID )
	{
		if( !pItem->GetIsPile() )
		{
			//SystemNotice( "该物品《%s》不可以堆叠存放!", pItem->szName );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00017), pItem->szName );
			return FALSE;
		}
	}

	DWORD dwCharMoney = (long)getAttr( ATTR_GD );
	if( dwCharMoney < dwMoney )
	{
		//SystemNotice( "你的金钱(%d)不够购买%d个物品《%s》!单价(%d)", dwCharMoney,byCount, pItem->szName, pItem->lPrice );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00018), dwCharMoney,byCount, pItem->szName, pItem->lPrice );
		char szData[128];
		CFormatParameter param(4);
		param.setLong( 0, dwCharMoney );
		param.setDouble( 1, byCount );
		param.setString( 2, pItem->szName );
		param.setLong( 3, pItem->lPrice );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00018, param, szData );
		SystemNotice( szData );
		return FALSE;
	}

	USHORT sNum = byCount;

	SItemGrid SGridCont;
	SGridCont.sID = wItemID;
	SGridCont.sNum = byCount;
	ItemInstance( enumITEM_INST_BUY, &SGridCont );
	
	GetKitbag()->SetChangeFlag(false);
	m_CChaAttr.ResetChangeFlag();
	SetBoatAttrChangeFlag(false);
	// 存入实例化物品
	Short sPushPos = defKITBAG_DEFPUSH_POS;
	Short sPushRet = KbPushItem( true, false, &SGridCont, sPushPos );
	SynKitbagNew( enumSYN_KITBAG_FROM_NPC );
	if( sPushRet == enumKBACT_ERROR_LOCK ) // 道具栏被锁定
	{
		ItemOprateFailed( enumITEMOPT_ERROR_KBLOCK );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_PUSHITEMID ) // 道具不存在
	{
		ItemOprateFailed( enumITEMOPT_ERROR_NONE );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_FULL ) // 道具栏已满，减少购买数量
	{
		// 获得物品触发事件
		sNum = sNum - SGridCont.sNum;
		if( sNum == 0 ) 
		{
			//SystemNotice( "你的道具栏已满，不可以购买物品!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00019) );
			return TRUE;
		}
		// 获得物品触发事件
		AfterPeekItem( wItemID, sNum );
	}
	else if( sPushRet == enumKBACT_SUCCESS )
	{
		// 获得物品触发事件
		AfterPeekItem( wItemID, sNum );
	}

	dwMoney = sNum * pItem->lPrice;
	dwCharMoney -= dwMoney;
	setAttr( ATTR_GD, dwCharMoney );
	SynAttr( enumATTRSYN_TRADE );
	SyncBoatAttr(enumATTRSYN_TRADE);

	//SystemNotice( "你购买了%d个《%s》，花费(%d)金钱!余额(%d)", sNum, pItem->szName, dwMoney, dwCharMoney );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00020), sNum, pItem->szName, dwMoney, dwCharMoney );
	char szData[128]="";
	CFormatParameter param(4);
	param.setDouble( 0, sNum );
	param.setString( 1, pItem->szName );
	param.setLong( 2, dwMoney );
	param.setLong( 3, dwCharMoney );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00020, param, szData );
	char szLog[128] = "";
	//sprintf( szLog, "%d个%s", sNum, pItem->szName );
	_snprintf_s( szLog,sizeof(szLog),_TRUNCATE,"%d %s", sNum, pItem->szName );
	TL( CHA_BUY, GetName(), "", szLog );

	//	2008-8-19	yangyinyu	add	begin!
	//lgtool_PrintGetType( RES_STRING(GM_CHARACTER_CPP_00119) );
	//lgtool_PrintItem(	this->GetName(),	this->m_ID,	sNum,	pItem,	&SGridCont	);
	//	2008-8-19	yangyinyu	add	end!

	// 数据库保存
	SaveAssets();
	LogAssets(enumLASSETS_TRADE);

	return TRUE;
T_E}

BOOL CCharacter::GetSaleGoodsItem( DWORD dwBoatID, BYTE byIndex, WORD& wItemID )
{T_B
	if( m_pCPlayer )
	{
		USHORT sBerthID, sxPos, syPos, sDir;
		m_pCPlayer->GetBerth( sBerthID, sxPos, syPos, sDir );

		BYTE byNumBoat = m_pCPlayer->GetNumBoat();
		for( BYTE i = 0; i < byNumBoat; i++ )
		{
			CCharacter* pBoat = m_pCPlayer->GetBoat( i );
			if( pBoat && pBoat->GetID() == dwBoatID /*&& sBerthID == pBoat->getAttr( ATTR_BOAT_BERTH )*/ )
			{
				USHORT sSize = pBoat->GetKitbag()->GetCapacity();
				if( byIndex >= sSize )
				{
        			//SystemNotice( "物品栏位索引错误!ID = %d", byIndex );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00004), byIndex );
					return FALSE;
				}

				wItemID = (WORD)pBoat->GetKitbag()->GetID( byIndex );
				return TRUE;
			}
		}
	}
	return FALSE;
T_E}

BOOL CCharacter::SafeSaleGoods( DWORD dwBoatID, BYTE byIndex, BYTE byCount, WORD& wItemID, DWORD& dwMoney )
{T_B
	MONITOR
	if( m_pCPlayer )
	{
		USHORT sBerthID, sxPos, syPos, sDir;
		m_pCPlayer->GetBerth( sBerthID, sxPos, syPos, sDir );

		BYTE byNumBoat = m_pCPlayer->GetNumBoat();
		for( BYTE i = 0; i < byNumBoat; i++ )
		{
			CCharacter* pBoat = m_pCPlayer->GetBoat( i );
			if( pBoat && pBoat->GetID() == dwBoatID/* && sBerthID == pBoat->getAttr( ATTR_BOAT_BERTH )*/ )
			{
				USHORT sSize = pBoat->GetKitbag()->GetCapacity();

				if(GetPlyMainCha()->GetKitbag()->IsPwdLocked())
				{
					//SystemNotice( "道具栏已锁定!" );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00002) );
					return FALSE;
				}

				//add by ALLEN 2007-10-16
				if(GetPlyMainCha()->IsReadBook())
				{
					//SystemNotice( "正在读书，不可以交易!" );
					SystemNotice(RES_STRING(GM_CHARACTER_CPP_00003));
					return FALSE;
				}
				if( byIndex >= sSize )
				{
					//SystemNotice( "物品栏位索引错误!ID = %d", byIndex );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00004), byIndex );
					return FALSE;
				}

				wItemID = (WORD)pBoat->GetKitbag()->GetID(byIndex);
				CItemRecord* pItem = GetItemRecordInfo( wItemID );
				if( pItem == NULL )
				{
					//SystemNotice( "物品ID错误，无法找到该物品信息!ID = %d", wItemID );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00005), wItemID );
					return FALSE;
				}

				if( pItem->sType == enumItemTypeMission )
				{
					//SystemNotice( "任务道具《%s》不可以交易!", pItem->szName );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00021), pItem->szName );
					return FALSE;
				}

				if( !pBoat->GetKitbag()->HasItem( byIndex ) )
				{
					//SystemNotice( "未发现该物品索引栏位(%d)的物品信息!", byIndex );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00007), byIndex );
					return FALSE;
				}

				if( pBoat->GetKitbag()->GetNum(byIndex) < byCount )
				{
					//SystemNotice( "出售物品《%s》数量(%d)不足，总数(%d)!", pItem->szName, byCount, wItemID );
					//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00008), pItem->szName, byCount, wItemID );
					char szData[128];
					CFormatParameter param(3);
					param.setString( 0, pItem->szName );
					param.setDouble( 1, byCount );
					param.setLong( 2, wItemID );
					RES_FORMAT_STRING( GM_CHARACTER_CPP_00008, param, szData );
					SystemNotice( szData );
					return FALSE;
				}

				// 判断丢弃船长证明
				if( pItem->sType == enumItemTypeBoat )
				{
					if( !BoatClear( pBoat->GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, byIndex ) ) )
					{
						//SystemNotice( "出售《%s》失败，你正在使用该船!", pItem->szName );
						SystemNotice( RES_STRING(GM_CHARACTER_CPP_00010), pItem->szName );
						return enumITEMOPT_ERROR_UNUSE;
					}
				}

				pBoat->GetKitbag()->SetChangeFlag( false );
				m_CChaAttr.ResetChangeFlag();
				SetBoatAttrChangeFlag(false);

				SItemGrid Grid;
				Grid.sNum = byCount;
				if( pBoat->KbPopItem( true, false, &Grid, byIndex ) != enumKBACT_SUCCESS )
				{
					//SystemNotice( "提取%s船舱出售货物失败!", pBoat->GetName() );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00022), pBoat->GetName() );
					//LG( "trade_error", "提取角色%s船只%s船舱出售货物失败!ID[%d], Count[%d]", GetName(), pBoat->GetName(), wItemID, byCount );
					LG( "trade_error", "distill character %s boat %s cabin sale goods failed!ID[%d], Count[%d]\n", GetName(), pBoat->GetName(), wItemID, byCount );
					return FALSE;
				}

				// 同步物品数据
				pBoat->SynKitbagNew( enumSYN_KITBAG_FROM_NPC );

				DWORD dwPrice = ( dwMoney > 0 ) ? dwMoney : (pItem->lPrice)>>1;
				dwMoney = dwPrice * byCount;
				DWORD dwCharMoney = (long)getAttr( ATTR_GD );
				dwCharMoney += dwMoney;

				setAttr( ATTR_GD, dwCharMoney );
				SynAttr( enumATTRSYN_TRADE );
				SyncBoatAttr(enumATTRSYN_TRADE);

				// 数据库保存
				pBoat->SaveAssets();
				SaveAssets();
				pBoat->LogAssets(enumLASSETS_TRADE);

				//SystemNotice( "你出售了%d个《%s》物品，获得了(%d)金钱，总额(%d)!", byCount, pItem->szName, dwMoney, dwCharMoney );				
				//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00011), byCount, pItem->szName, dwMoney, dwCharMoney );				
				char szData[128]="";
				CFormatParameter param(4);
				param.setDouble( 0, byCount );
				param.setString( 1,pItem->szName );
				param.setLong( 2, dwMoney );
				param.setLong( 3, dwCharMoney );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00011, param, szData );
				SystemNotice( szData );
				
				char szLog[128] = "";
				//sprintf( szLog, "%d个%s", byCount, pItem->szName );
				_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", byCount, pItem->szName );
				TL( BOAT_SYS, GetName(), "", szLog );
				return TRUE;
			}
		}
	}
	
	return FALSE;
T_E}

BOOL CCharacter::SafeBuyGoods( DWORD dwBoatID, WORD wItemID, BYTE byCount, BYTE byIndex, DWORD& dwMoney )
{T_B
	MONITOR
	if( m_pCPlayer )
	{
		USHORT sBerthID, sxPos, syPos, sDir;
		m_pCPlayer->GetBerth( sBerthID, sxPos, syPos, sDir );

		BYTE byNumBoat = m_pCPlayer->GetNumBoat();
		for( BYTE i = 0; i < byNumBoat; i++ )
		{
			CCharacter* pBoat = m_pCPlayer->GetBoat( i );
			if( pBoat && pBoat->GetID() == dwBoatID/* && sBerthID == pBoat->getAttr( ATTR_BOAT_BERTH )*/ )
			{
				CItemRecord* pItem = GetItemRecordInfo( wItemID );
				if( pItem == NULL )
				{
					//SystemNotice( "物品ID错误，无法找到该物品信息!ID = %d", wItemID );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00005), wItemID );
					return FALSE;
				}

				USHORT sSize =  pBoat->GetKitbag()->GetCapacity();
				if(GetPlyMainCha()->GetKitbag()->IsPwdLocked())
				{
					//SystemNotice( "道具栏已锁定!" );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00002) );
					return FALSE;
				}

				//add by ALLEN 2007-10-16
				if(GetPlyMainCha()->IsReadBook())
				{
					//SystemNotice( "正在读书，不可以交易!" );
					SystemNotice(RES_STRING(GM_CHARACTER_CPP_00003));
					return FALSE;
				}

				if( byIndex >= sSize )
				{
					//SystemNotice( "物品栏位索引(%d)无效!", byIndex );
					SystemNotice(RES_STRING(GM_CHARACTER_CPP_00016), byIndex );
					return FALSE;
				}

				if(  pBoat->GetKitbag()->GetID( byIndex ) == wItemID )
				{
					if( !pItem->GetIsPile() )
					{
						//SystemNotice( "该物品《%s》不可以堆叠存放!", pItem->szName );
						SystemNotice( RES_STRING(GM_CHARACTER_CPP_00017), pItem->szName );
						return FALSE;
					}
				}

				// 计算物品总价
				USHORT sNum = byCount;
				DWORD dwPrice = ( dwMoney > 0 ) ? dwMoney : pItem->lPrice;
				dwMoney = sNum * dwPrice;

				DWORD dwCharMoney = (long)getAttr( ATTR_GD );
				if( dwCharMoney < dwMoney )
				{
					//SystemNotice( "你的金钱(%d)不够购买%d个物品《%s》!单价(%d)", dwCharMoney,byCount, pItem->szName, dwPrice );
					//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00018), dwCharMoney,byCount, pItem->szName, dwPrice );
					char szData[128];
					CFormatParameter param(4);
					param.setLong( 0, dwCharMoney );
					param.setDouble( 1, byCount );
					param.setString( 2, pItem->szName );
					param.setLong( 3, pItem->lPrice );
					RES_FORMAT_STRING( GM_CHARACTER_CPP_00018, param, szData );
					SystemNotice( szData );
					return FALSE;
				}				

				SItemGrid SGridCont;
				SGridCont.sID = wItemID;
				SGridCont.sNum = byCount;
				ItemInstance( enumITEM_INST_BUY, &SGridCont );

				pBoat->GetKitbag()->SetChangeFlag(false);
				m_CChaAttr.ResetChangeFlag();
				SetBoatAttrChangeFlag(false);
				// 存入实例化物品
				Short sPushPos = defKITBAG_DEFPUSH_POS;
				Short sPushRet = pBoat->KbPushItem( true, false, &SGridCont, sPushPos );
				pBoat->SynKitbagNew( enumSYN_KITBAG_FROM_NPC );
				if( sPushRet == enumKBACT_ERROR_LOCK ) // 道具栏被锁定
				{
					ItemOprateFailed( enumITEMOPT_ERROR_KBLOCK );
					return FALSE;
				}
				else if( sPushRet == enumKBACT_ERROR_PUSHITEMID ) // 道具不存在
				{
					ItemOprateFailed( enumITEMOPT_ERROR_NONE );
					return FALSE;
				}
				else if( sPushRet == enumKBACT_ERROR_FULL ) // 道具栏已满，减少购买数量
				{
					// 获得物品触发事件
					sNum = sNum - SGridCont.sNum;
					if( sNum == 0 ) 
					{
						//SystemNotice( "你的道具栏已满，不可以购买物品!" );
						SystemNotice( RES_STRING(GM_CHARACTER_CPP_00019) );
						return TRUE;
					}
					// 获得物品触发事件
					AfterPeekItem( wItemID, sNum );
				}
				else if( sPushRet == enumKBACT_SUCCESS )
				{
					// 获得物品触发事件
					AfterPeekItem( wItemID, sNum );
				}

				dwCharMoney -= dwMoney;
				setAttr( ATTR_GD, dwCharMoney );
				SynAttr( enumATTRSYN_TRADE );
				SyncBoatAttr(enumATTRSYN_TRADE);

				// 数据库保存
				pBoat->SaveAssets();
				SaveAssets();
				pBoat->LogAssets(enumLASSETS_TRADE);

				//SystemNotice( "你购买了%d个《%s》，花费(%d)金钱!余额(%d)", sNum, pItem->szName, dwMoney, dwCharMoney );
				//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00020), sNum, pItem->szName, dwMoney, dwCharMoney );
				char szData[128]="";
				CFormatParameter param(4);
				param.setDouble( 0, sNum );
				param.setString( 1, pItem->szName );
				param.setLong( 2, dwMoney );
				param.setLong( 3, dwCharMoney );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00020, param, szData );
				
				char szLog[128] = "";
				//sprintf( szLog, "%d个%s", sNum, pItem->szName );
				_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", sNum, pItem->szName );
				TL( SYS_BOAT, GetName(), "", szLog );

				return TRUE;
			}
		}
	}
	
	return FALSE;
T_E}

bool CCharacter::SetNarmalSkillState(bool bAdd, uChar uchStateID, uChar uchStateLv)
{T_B
	if (bAdd)
		return AddSkillState(0, GetID(), GetHandle(), enumSKILL_TYPE_SELF, enumSKILL_TAR_LORS, enumSKILL_EFF_HELPFUL, uchStateID, uchStateLv, -1);
	else
		return DelSkillState(uchStateID);
T_E}

bool CCharacter::StallAction(bool bLock)
{T_B
	SSkillGrid	*pSSkillCont = m_CSkillBag.GetSkillContByID(241);
	if (pSSkillCont)
		return SetNarmalSkillState(bLock, SSTATE_STALL, pSSkillCont->chLv);
	else
		return false;
T_E}

void CCharacter::AddMoney( const char szName[], DWORD dwMoney, const char* szNotice )
{T_B
	m_CChaAttr.ResetChangeFlag();
	DWORD dwCharMoney = (long)this->getAttr( ATTR_GD );
	dwCharMoney += dwMoney;
	setAttr( ATTR_GD, dwCharMoney );

	SynAttr( enumATTRSYN_TASK );
	if( !strcmp(szNotice,"") )
	{
		//SystemNotice( "%s给了你%d金钱，总额(%d)!", szName, dwMoney, dwCharMoney );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00023), szName, dwMoney, dwCharMoney );
		char szData[128];
		CFormatParameter param(3);
		param.setString( 0, szName );
		param.setLong( 1, dwMoney );
		param.setLong( 2, dwCharMoney );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00023, param, szData );
		SystemNotice( szData );
	}
	else
		SystemNotice( szNotice );
T_E}

BOOL CCharacter::TakeMoney( const char szName[], DWORD dwMoney, const char* szNotice )
{T_B
	m_CChaAttr.ResetChangeFlag();
	DWORD dwCharMoney = (long)this->getAttr( ATTR_GD );
	if( dwCharMoney < dwMoney )
		return FALSE;
	dwCharMoney -= dwMoney;
	setAttr( ATTR_GD, dwCharMoney );

	// 同步金钱
	SynAttr( enumATTRSYN_TASK );
	//SystemNotice( "%s取走了你%d金钱，余额(%d)!", szName, dwMoney, dwCharMoney );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00024), szName, dwMoney, dwCharMoney );
	if( !strcmp(szNotice,"") )
	{
		char szData[128] = "";
		CFormatParameter param(3);
		param.setString( 0, szName );
		param.setLong( 1, dwMoney );
		param.setLong( 2, dwCharMoney );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00024, param, szData );
		SystemNotice( szData );
	}
	else
		SystemNotice( szNotice );
	return TRUE;
T_E}

BOOL CCharacter::HasMoney( DWORD dwMoney )
{T_B
	return (DWORD)getAttr( ATTR_GD ) >= dwMoney;
T_E}

BOOL CCharacter::MakeItem( USHORT sItemID, USHORT sCount, USHORT& sItemPos, BYTE byAddType, BYTE bySoundType )
{T_B
	if( sCount <= 0 ) return FALSE;
	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "MakeItem:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00025), sItemID );
		return FALSE;
	}

	SItemGrid SGridCont;
	SGridCont.sID = sItemID;
	SGridCont.sNum = sCount;
	ItemInstance( byAddType, &SGridCont );
	
	// 存入实例化物品
	GetKitbag()->SetChangeFlag(false);
	Short sPushPos = defKITBAG_DEFPUSH_POS;
	Short sPushRet = KbPushItem( true, true, &SGridCont, sPushPos );
	if( sPushRet == enumKBACT_ERROR_LOCK ) // 道具栏被锁定
	{
		ItemOprateFailed( enumITEMOPT_ERROR_KBLOCK );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_PUSHITEMID ) // 道具不存在
	{
		ItemOprateFailed( enumITEMOPT_ERROR_NONE );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_FULL ) // 道具栏已满，丢到地面
	{
		ItemOprateFailed( enumKBACT_ERROR_FULL );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_SUCCESS )
	{
		// 获得物品触发事件
		AfterPeekItem( sItemID, sCount );
	}

	sItemPos = sPushPos;
	SynKitbagNew( enumSYN_KITBAG_SYSTEM );
	//SystemNotice( "%s给了你%d个《%s》物品!", "系统", sCount, pItem->szName );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00026), RES_STRING(GM_CHARACTER_CPP_00012), sCount, pItem->szName );
	char szData[128] = "";
	CFormatParameter param(3);
	param.setString( 0, RES_STRING(GM_CHARACTER_CPP_00012));
	param.setDouble( 1, sCount );
	param.setString( 2, pItem->szName );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00026, param, szData );
	SystemNotice( szData );
	char szLog[128] = "";
	//sprintf( szLog, "%d个%s", sCount, pItem->szName );
	_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", sCount, pItem->szName );
	TL( CHA_MIS, GetName(), "", szLog );
	
	//	2008-8-19	yangyinyu	add	begin!
	//lgtool_PrintGetType( RES_STRING(GM_CHARACTER_CPP_00120) );
	//lgtool_PrintItem(	this->GetName(),	this->m_ID,	sCount,		pItem,	&SGridCont	);
	//	2008-8-19	yangyinyu	add	end!

	return TRUE;
T_E}

BOOL CCharacter::GiveItem( USHORT sItemID, USHORT sCount, BYTE byAddType, BYTE bySoundType )
{T_B
	if( sCount <= 0 ) return TRUE;
	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "GiveItem:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00027), sItemID );
		return FALSE;
	}

	SItemGrid SGridCont;
	SGridCont.sID = sItemID;
	SGridCont.sNum = sCount;
	ItemInstance( byAddType, &SGridCont );
	
	// 存入实例化物品
	GetKitbag()->SetChangeFlag(false);
	Short sPushPos = defKITBAG_DEFPUSH_POS;
	Short sPushRet = KbPushItem( true, true, &SGridCont, sPushPos );
	if( sPushRet == enumKBACT_ERROR_LOCK ) // 道具栏被锁定
	{
		ItemOprateFailed( enumITEMOPT_ERROR_KBLOCK );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_PUSHITEMID ) // 道具不存在
	{
		ItemOprateFailed( enumITEMOPT_ERROR_NONE );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_FULL ) // 道具栏已满，丢到地面
	{
		// 获得物品触发事件
		USHORT sNum = sCount - SGridCont.sNum;
		if( sNum > 0 ) AfterPeekItem( sItemID, sNum );

		CCharacter	*pCCtrlCha = GetPlyCtrlCha(), *pCMainCha = GetPlyMainCha();
		Long	lPosX, lPosY;
		pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
		pCCtrlCha->GetSubMap()->ItemSpawn( &SGridCont, lPosX, lPosY, enumITEM_APPE_THROW, pCCtrlCha->GetID(), pCMainCha->GetID(), pCMainCha->GetHandle() );
		ItemOprateFailed( enumITEMOPT_ERROR_KBFULL );
	}
	else if( sPushRet == enumKBACT_SUCCESS )
	{
		// 获得物品触发事件
		AfterPeekItem( sItemID, sCount );
	}

	SynKitbagNew( enumSYN_KITBAG_SYSTEM );
			
	//	2008-8-19	yangyinyu	add	begin!
	//lgtool_PrintItem(	this->GetName(),	this->m_ID,	sCount,	pItem,	&SGridCont	);
	//	2008-8-19	yangyinyu	add	end!

	return TRUE;
T_E}

BOOL CCharacter::GiveItem2KitbagTemp( USHORT sItemID, USHORT sCount, ItemInfo *pItemAttr, BYTE bySoundType )
{T_B
	if( sCount <= 0 ) return TRUE;
	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "GiveItem2KitbagTemp:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00028), sItemID );
		return FALSE;
	}

	SItemGrid SGridCont;
	SGridCont.sID = sItemID;
	SGridCont.sNum = sCount;
	if(pItemAttr == NULL)
	{
		ItemInstance( enumITEM_INST_BUY, &SGridCont );
	}
	else
	{
		ItemInstance( enumITEM_INST_BUY, &SGridCont );

		int i;
		for(i = 0; i < defITEM_INSTANCE_ATTR_NUM; i++)
		{
			SGridCont.sInstAttr[i][0] = (short)pItemAttr->itemAttrID[i];
			SGridCont.sInstAttr[i][1] = (short)pItemAttr->itemAttrVal[i];
		}

		//设置槽数
		unsigned long ulForgeP = SGridCont.GetDBParam(enumITEMDBP_FORGE);
		short sHole = static_cast<short>(ulForgeP / 1000000000);
		ulForgeP = ulForgeP + (pItemAttr->itemFlute - sHole) * 1000000000;
		SGridCont.SetDBParam(enumITEMDBP_FORGE, static_cast<long>(ulForgeP));
	}

	// 存入实例化物品
	m_pCKitbagTmp->SetChangeFlag(false);
	Short sPushPos = defKITBAG_DEFPUSH_POS;
	Short sPushRet = m_pCKitbagTmp->Push(&SGridCont, sPushPos);
	if( sPushRet == enumKBACT_ERROR_LOCK ) // 道具栏被锁定
	{
		ItemOprateFailed( enumITEMOPT_ERROR_KBLOCK );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_PUSHITEMID ) // 道具不存在
	{
		ItemOprateFailed( enumITEMOPT_ERROR_NONE );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_FULL ) // 道具栏已满，丢到地面
	{
		// 获得物品触发事件
		USHORT sNum = sCount - SGridCont.sNum;
		if( sNum > 0 ) AfterPeekItem( sItemID, sNum );

		CCharacter	*pCCtrlCha = GetPlyCtrlCha(), *pCMainCha = GetPlyMainCha();
		Long	lPosX, lPosY;
		pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
		pCCtrlCha->GetSubMap()->ItemSpawn( &SGridCont, lPosX, lPosY, enumITEM_APPE_THROW, pCCtrlCha->GetID(), pCMainCha->GetID(), pCMainCha->GetHandle() );
		ItemOprateFailed( enumITEMOPT_ERROR_KBFULL );
	}
	else if( sPushRet == enumKBACT_SUCCESS )
	{
		// 获得物品触发事件
		AfterPeekItem( sItemID, sCount );
	}

	SynKitbagTmpNew( enumSYN_KITBAG_SYSTEM );

	return TRUE;
T_E}

BOOL CCharacter::AddItem( USHORT sItemID, USHORT sCount, const char szName[], BYTE byAddType, BYTE bySoundType )
{T_B
	//char szItem[128] = "未知";
	char szItem[128] = "";

	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "AddItem:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00029), sItemID );
		return FALSE;
	}
	//strncpy( szItem, pItem->szName,128 - 1 );//此处要注意，szItem长度要够，否则海外版本会有道具名超长而造成掉线，故设为128
	strncpy_s( szItem, sizeof(szItem), pItem->szName, _TRUNCATE );
				
	//	2008-8-19	yangyinyu	add	begin!
	//lgtool_PrintGetType( RES_STRING(GM_CHARACTER_CPP_00121) );
	//	2008-8-19	yangyinyu	add	end!

	if( GiveItem( sItemID, sCount, byAddType, bySoundType ) )
	{
		//SystemNotice( "%s给了你%d个《%s》物品!", szName, sCount, szItem );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00026), szName, sCount, szItem );
		char szData[128] = "";
		CFormatParameter param(3);
		param.setString( 0, szName );
		param.setDouble( 1, sCount );
		param.setString( 2, szItem );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00026, param, szData );
		SystemNotice( szData );
		char szLog[128] = "";
		//sprintf( szLog, "%d个%s", sCount, szItem );
		_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", sCount, szItem );
		TL( CHA_MIS, GetName(), "", szLog );

		return TRUE;
	}
	else
	{
		//SystemNotice( "%s给你%d个《%s》物品，操作失败!", szName, sCount, szItem );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00030), szName, sCount, szItem );
		char szData[128];
		CFormatParameter param(3);
		param.setString( 0, szName );
		param.setDouble( 1, sCount );
		param.setString( 2, szItem );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00030, param, szData );
		SystemNotice( szData );
	}

	return FALSE;
T_E}

BOOL CCharacter::AddItem2KitbagTemp( USHORT sItemID, USHORT sCount, ItemInfo *pItemAttr, BYTE bySoundType )
{T_B
	//char szItem[32] = "未知";
	char szItem[80];
	//strncpy( szItem, RES_STRING(GM_CHARACTER_CPP_00031), 32 - 1 );
	strncpy_s( szItem, sizeof(szItem), RES_STRING(GM_CHARACTER_CPP_00031), _TRUNCATE );

	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "AddItem2KitbagTemp:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00032), sItemID );
		return FALSE;
	}
	//strcpy( szItem, pItem->szName );
	strncpy_s( szItem, sizeof(szItem), pItem->szName, _TRUNCATE );

	if( GiveItem2KitbagTemp( sItemID, sCount, pItemAttr, bySoundType ) )
	{
		//SystemNotice( "你购买了%d个《%s》物品!", sCount, szItem );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00033), sCount, szItem );		
		char szData[128];
		CFormatParameter param(2);
		param.setDouble( 0, sCount );
		param.setString( 1, szItem );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00033, param, szData );
		SystemNotice( szData );

		return TRUE;
	}
	else
	{
		//SystemNotice( "你购买%d个《%s》物品，操作失败!", sCount, szItem );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00034), sCount, szItem );
		char szData[128];
		CFormatParameter param(2);
		param.setDouble( 0, sCount );
		param.setString( 1, szItem );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00034, param, szData );
		SystemNotice( szData );
	}

	return FALSE;
T_E}

BOOL CCharacter::AddItem2KitbagTemp( USHORT sItemID, USHORT sCount, const char szName[], BYTE byAddType, BYTE bySoundType )
{T_B
	//char szItem[32] = "未知";
	char szItem[80];
	//strncpy( szItem, RES_STRING(GM_CHARACTER_CPP_00031), 32 - 1 );
	strncpy_s( szItem, sizeof(szItem), RES_STRING(GM_CHARACTER_CPP_00031), _TRUNCATE );

	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "AddItem2KitbagTemp:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00032), sItemID );
		return FALSE;
	}
	//strcpy( szItem, pItem->szName );
	strncpy_s( szItem, sizeof(szItem), pItem->szName, _TRUNCATE );
	if( GiveItem2KitbagTemp( sItemID, sCount, byAddType, bySoundType ) )
	{
		//SystemNotice( "%s给了你%d个《%s》物品!", szName, sCount, szItem );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00026), szName, sCount, szItem );
		char szData[128] = "";
		CFormatParameter param(3);
		param.setString( 0, szName );
		param.setDouble( 1, sCount );
		param.setString( 2, szItem );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00026, param, szData );
		SystemNotice( szData );
		char szLog[128] = "";
		//sprintf( szLog, "%d %s", sCount, szItem );
		_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", sCount, szItem );
		TL( CHA_MIS, GetName(), "", szLog );
		return TRUE;
	}
	else
	{
		//SystemNotice( "%s给你%d个《%s》物品，操作失败!", szName, sCount, szItem );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00030), szName, sCount, szItem );
		char szData[128];
		CFormatParameter param(3);
		param.setString( 0, szName );
		param.setDouble( 1, sCount );
		param.setString( 2, szItem );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00030, param, szData );
		SystemNotice( szData );
	}

	return FALSE;
T_E}

BOOL CCharacter::GiveItem2KitbagTemp( USHORT sItemID, USHORT sCount, BYTE byAddType, BYTE bySoundType )
{T_B
	if( sCount <= 0 ) return TRUE;
	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "GiveItem2KitbagTemp:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00028), sItemID );
		return FALSE;
	}
	
	SItemGrid SGridCont;
	SGridCont.sID = sItemID;
	SGridCont.sNum = sCount;
	ItemInstance( byAddType, &SGridCont );

	// 存入实例化物品
	m_pCKitbagTmp->SetChangeFlag(false);
	Short sPushPos = defKITBAG_DEFPUSH_POS;
	Short sPushRet = m_pCKitbagTmp->Push(&SGridCont, sPushPos);
	if( sPushRet == enumKBACT_ERROR_LOCK ) // 道具栏被锁定
	{
		ItemOprateFailed( enumITEMOPT_ERROR_KBLOCK );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_PUSHITEMID ) // 道具不存在
	{
		ItemOprateFailed( enumITEMOPT_ERROR_NONE );
		return FALSE;
	}
	else if( sPushRet == enumKBACT_ERROR_FULL ) // 道具栏已满，丢到地面
	{
		// 获得物品触发事件
		USHORT sNum = sCount - SGridCont.sNum;
		if( sNum > 0 ) AfterPeekItem( sItemID, sNum );

		CCharacter	*pCCtrlCha = GetPlyCtrlCha(), *pCMainCha = GetPlyMainCha();
		Long	lPosX, lPosY;
		pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
		pCCtrlCha->GetSubMap()->ItemSpawn( &SGridCont, lPosX, lPosY, enumITEM_APPE_THROW, pCCtrlCha->GetID(), pCMainCha->GetID(), pCMainCha->GetHandle() );
		ItemOprateFailed( enumITEMOPT_ERROR_KBFULL );
	}
	else if( sPushRet == enumKBACT_SUCCESS )
	{
		// 获得物品触发事件
		AfterPeekItem( sItemID, sCount );
	}

	SynKitbagTmpNew( enumSYN_KITBAG_SYSTEM );
/*
	//	2008-8-19	yangyinyu	add	begin!
	//	加道具到临时背包。
	short			sNum	=	sCount;
	SItemGrid*		sig	=	&SGridCont;
	CItemRecord*	cir		=	GetItemRecordInfo( sig->sID );
	lgtool_PrintItem(	GetName(),	sNum,	cir,	sig	);
	//	2008-8-19	yangyinyu	add	end!
*/
	return TRUE;
T_E}

BOOL CCharacter::TakeItemBagTemp(USHORT sItemID, USHORT sCount, const char szName[])
{T_B
	int nNum = 0, nCount = 0;
	//char szItem[32] = "未知";
	char szItem[80];
	//strncpy( szItem, RES_STRING(GM_CHARACTER_CPP_00031), 32 - 1 );
	strncpy_s( szItem, sizeof(szItem), RES_STRING(GM_CHARACTER_CPP_00031), _TRUNCATE );

	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "TakeItem:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00035), sItemID );
		return FALSE;
	}
	//strcpy( szItem, pItem->szName );
	strncpy_s( szItem, sizeof(szItem),  pItem->szName, _TRUNCATE );
	USHORT sSize = m_pCKitbagTmp->GetUseGridNum();
	Short sIndex[defMAX_KBITEM_NUM_PER_TYPE][2];
	memset( sIndex, 0, sizeof(Short)*sSize );
	SItemGrid	*pGrid;
	SItemGrid SGridCont;
	for( int i = 0; i < sSize; i++ )
	{
		pGrid = m_pCKitbagTmp->GetGridContByNum(i);
		if (!pGrid)
			continue;
		if( pGrid->sID == sItemID )
		{
			sIndex[nNum][0] = m_pCKitbagTmp->GetPosIDByNum(i);
			sIndex[nNum][1] = sCount - nCount;
			if (sIndex[nNum][1] > pGrid->sNum)
				sIndex[nNum][1] = pGrid->sNum;
			nNum++;
			nCount += pGrid->sNum;
			if( nCount >= sCount )
			{
				nCount = sCount;
				break;
			}
		}
	}

	if( nCount < sCount )
	{
		//SystemNotice( "需要提取%d个《%s》物品，但是数量(%d)不足!", sCount, szItem, nCount );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00036), sCount, szItem, nCount );
		char szData[128];
		CFormatParameter param(3);
		param.setDouble( 0, sCount );
		param.setString( 1, szItem );
		param.setDouble( 2, nCount );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00036, param, szData );
		SystemNotice( szData );
		return FALSE;
	}

	m_pCKitbagTmp->SetChangeFlag(false);
	for( int i = 0; i < nNum; i++ )
	{
		SGridCont.sNum = sIndex[i][1];
		m_pCKitbagTmp->Pop(&SGridCont, sIndex[i][0]);
		/*if( KbPopItem(true, true, &SGridCont, sIndex[i][0]) != enumKBACT_SUCCESS )
		{
			SystemNotice( "%s不能取走你的%d个《%s》物品!GridID = %d, NumItem = %d", szName, sCount, szItem, sIndex[i][0], sIndex[i][1] );
			return FALSE;
		}*/
	}

	// 同步背包信息
	SynKitbagTmpNew( enumSYN_KITBAG_SYSTEM );
	//SystemNotice( "%s取走了你的%d个《%s》物品!", szName, sCount, szItem );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00038), szName, sCount, szItem );
	char szData[128]= "";
	CFormatParameter param(3);
	param.setString( 0, szName );
	param.setDouble( 1, sCount );
	param.setString( 2, szItem );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00038, param, szData );
	SystemNotice( szData );
	char szLog[128] = "";
	//sprintf( szLog, "%d个%s", sCount, szItem );
	_snprintf_s( szLog,sizeof(szLog),_TRUNCATE,"%d %s", sCount, szItem );
	TL( MIS_CHA, GetName(), "", szLog );

	// 刷新任务道具计数
	RefreshNeedItem( sItemID );
	return TRUE;
T_E}

BOOL CCharacter::TakeItem( USHORT sItemID, USHORT sCount, const char szName[] )
{T_B
	int nNum = 0, nCount = 0;
	//char szItem[32] = "未知";
	char szItem[80];
	//strncpy( szItem, RES_STRING(GM_CHARACTER_CPP_00031), 32 - 1 );
	strncpy_s( szItem, sizeof(szItem), RES_STRING(GM_CHARACTER_CPP_00031), _TRUNCATE );

	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "TakeItem:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00035), sItemID );
		return FALSE;
	}
	//strcpy( szItem, pItem->szName );
	strncpy_s( szItem, sizeof(szItem),  pItem->szName, _TRUNCATE );
	USHORT sSize = GetKitbag()->GetUseGridNum();
	Short sIndex[defMAX_KBITEM_NUM_PER_TYPE][2];
	memset( sIndex, 0, sizeof(Short)*sSize );
	SItemGrid	*pGrid;
	SItemGrid SGridCont;
	for( int i = 0; i < sSize; i++ )
	{
		pGrid = GetKitbag()->GetGridContByNum(i);
		if (!pGrid)
			continue;
		if( pGrid->sID == sItemID )
		{
			sIndex[nNum][0] = GetKitbag()->GetPosIDByNum(i);
			sIndex[nNum][1] = sCount - nCount;
			if (sIndex[nNum][1] > pGrid->sNum)
				sIndex[nNum][1] = pGrid->sNum;
			nNum++;
			nCount += pGrid->sNum;
			if( nCount >= sCount )
			{
				nCount = sCount;
				break;
			}
		}
	}

	if( nCount < sCount )
	{
		//SystemNotice( "需要提取%d个《%s》物品，但是数量(%d)不足!", sCount, szItem, nCount );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00036), sCount, szItem, nCount );
		char szData[128];
		CFormatParameter param(3);
		param.setDouble( 0, sCount );
		param.setString( 1, szItem );
		param.setDouble( 2, nCount );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00036, param, szData );
		SystemNotice( szData );
        		return FALSE;
	}

	GetKitbag()->SetChangeFlag(false);
	for( int i = 0; i < nNum; i++ )
	{
		SGridCont.sNum = sIndex[i][1];
		if( KbPopItem(true, true, &SGridCont, sIndex[i][0]) != enumKBACT_SUCCESS )
		{
			//SystemNotice( "%s不能取走你的%d个《%s》物品!GridID = %d, NumItem = %d", szName, sCount, szItem, sIndex[i][0], sIndex[i][1] );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00037), szName, sCount, szItem, sIndex[i][0], sIndex[i][1] );
			char szData[128];
			//CFormatParameter param(5);
			CFormatParameter param(3);
			param.setString( 0, szName );
			param.setDouble( 1, sCount );
			param.setString( 2, szItem );
			//param.setDouble( 3, sIndex[i][0] );
			//param.setDouble( 4, sIndex[i][1] );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00037, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
	}

	// 同步背包信息
	SynKitbagNew( enumSYN_KITBAG_SYSTEM );
	//SystemNotice( "%s取走了你的%d个《%s》物品!", szName, sCount, szItem );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00038), szName, sCount, szItem );
	char szData[128]= "";
	CFormatParameter param(3);
	param.setString( 0, szName );
	param.setDouble( 1, sCount );
	param.setString( 2, szItem );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00038, param, szData );
	SystemNotice( szData );
	char szLog[128] = "";
	//sprintf( szLog, "%d个%s", sCount, szItem );
	_snprintf_s( szLog,sizeof(szLog),_TRUNCATE, "%d %s", sCount, szItem );
	TL( MIS_CHA, GetName(), "", szLog );

	// 刷新任务道具计数
	RefreshNeedItem( sItemID );
	return TRUE;
T_E}

BOOL CCharacter::TakeAllRandItem( WORD wRoleID )
{T_B
	if( GetPlayer() )
	{
		return GetPlayer()->MisTakeAllRandNpcItem( wRoleID );
	}
	return FALSE;
T_E}

BOOL CCharacter::TakeRandNpcItem( WORD wRoleID, WORD wNpcID, const char szNpc[] )
{T_B
	if( GetPlayer() )
	{
		USHORT sItemID;
		if( !GetPlayer()->MisTakeRandMissionNpcItem( wRoleID, wNpcID, sItemID ) )
		{
			//SystemNotice( "TakeRandItem:获取随机任务物品信息失败!RoleID = %d, NpcID = %d", wRoleID, wNpcID );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00039), wRoleID, wNpcID );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, wRoleID );
			param.setLong( 1, wNpcID );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00039, param, szData );
			SystemNotice( szData );
			return FALSE;
		}

		//char szNpc[NPC_MAXSIZE_NAME] = "未知";
		//if( this->m_submap )
		//{
		//	CNpcRecord* pRec = m_submap->GetNpcInfo( wNpcID );
		//	if( pRec )
		//	{
		//		strncpy( szNpc, pRec->szName, NPC_MAXSIZE_NAME - 1 );
		//	}
		//}

		if( !GetPlyMainCha()->TakeItem( sItemID, 1, szNpc ) )
		{
			//SystemNotice( "TakeRandItem:%s取走随机任务物品操作失败!sItemID = %d", szNpc, sItemID );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00040), szNpc, sItemID );
			char szData[128];
			CFormatParameter param(2);
			param.setString( 0, szNpc );
			param.setDouble( 1, sItemID );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00040, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
		return TRUE;
	}

	return FALSE;
T_E}

BOOL CCharacter::IsMisNeedItem( USHORT sItemID )
{T_B
	return ( GetPlayer() ) ? GetPlayer()->MisNeedItem( sItemID ) : FALSE;
T_E}

BOOL CCharacter::GetMisNeedItemCount( WORD wRoleID, USHORT sItemID, USHORT& sCount )
{
	return ( GetPlayer() ) ? GetPlayer()->MisGetItemCount( wRoleID, sItemID, sCount ) : FALSE;
}

void CCharacter::RefreshNeedItem( USHORT sItemID )
{
	if( GetPlayer() ) {
		GetPlayer()->MisRefreshItemCount( sItemID );
	}
}

BOOL CCharacter::HasItem( USHORT sItemID, USHORT sCount )
{T_B
	int nCount = 0;
	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "HasItem:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00041), sItemID );
		return FALSE;
	}

	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	if( !pItem->GetIsPile() )
	{
		for( int i = 0; i < sNum; i++ )
		{
			pGridCont = GetKitbag()->GetGridContByNum( i );
			if( pGridCont )
			{
				if( sItemID == pGridCont->sID )
				{
					nCount++;
					if( nCount >= sCount )
						break;
				}
			}
		}
	}
	else
	{
		for( int i = 0; i < sNum; i++ )
		{
			pGridCont = GetKitbag()->GetGridContByNum( i );
			if( pGridCont )
			{
				if( sItemID == pGridCont->sID )
				{
					nCount += (USHORT)pGridCont->sNum;;
					if( nCount >= sCount )
						break;
				}
			}
		}
	}

	return nCount >= sCount;
T_E}

BOOL CCharacter::HasItemBagTemp(USHORT sItemID, USHORT sCount)
{T_B
	int nCount = 0;
	CItemRecord* pItem = GetItemRecordInfo( sItemID );
	if( pItem == NULL )
	{
		//SystemNotice( "HasItemBagTemp:错误的物品数据类型!ID = %d", sItemID );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00042), sItemID );
		return FALSE;
	}

	if(!m_pCKitbagTmp)
	{
		//SystemNotice( "HasItemBagTemp: 没有临时背包!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00043) );
		return FALSE;
	}

	USHORT sNum = m_pCKitbagTmp->GetUseGridNum();
	SItemGrid *pGridCont;
	if( !pItem->GetIsPile() )
	{
		for( int i = 0; i < sNum; i++ )
		{
			pGridCont = m_pCKitbagTmp->GetGridContByNum( i );
			if( pGridCont )
			{
				if( sItemID == pGridCont->sID )
				{
					nCount++;
					if( nCount >= sCount )
						break;
				}
			}
		}
	}
	else
	{
		for( int i = 0; i < sNum; i++ )
		{
			pGridCont = m_pCKitbagTmp->GetGridContByNum( i );
			if( pGridCont )
			{
				if( sItemID == pGridCont->sID )
				{
					nCount += (USHORT)pGridCont->sNum;;
					if( nCount >= sCount )
						break;
				}
			}
		}
	}

	return nCount >= sCount;
T_E}

BOOL CCharacter::GetNumItem( USHORT sItemID, USHORT& sCount )
{T_B
	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	for( int i = 0; i < sNum; i++ )
	{
		pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont )
		{
			if( sItemID == pGridCont->sID )
			{
				sCount += (USHORT)pGridCont->sNum;
			}
		}
	}
	return TRUE;
T_E}

BOOL CCharacter::HasTradeItemLevel( BYTE byLevel )
{
	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	for( int i = 0; i < sNum; i++ )
	{
		pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont )
		{
			CItemRecord* pItem = GetItemRecordInfo( pGridCont->sID );
			if( pItem && pItem->sType == enumItemTypeTrade )
			{
				return pGridCont->sEnergy[0] >= byLevel;
			}
		}
	}

	return FALSE;
}

BOOL CCharacter::SetTradeItemLevel( BYTE byLevel )
{
	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	Short	sPosID;
	for( int i = 0; i < sNum; i++ )
	{
		pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont )
		{
			CItemRecord* pItem = GetItemRecordInfo( pGridCont->sID );
			if( pItem && pItem->sType == enumItemTypeTrade )
			{				
				sPosID = GetKitbag()->GetPosIDByNum( i );
				//LG( "TradeCess", "角色%s添加贸易等级Level = %d, CurLevel = %d.", GetName(), byLevel, GetKitbag()->GetEnergy( false, sPosID ) );
				LG( "TradeCess", "character %s add trade level:Level = %d, CurLevel = %d.", GetName(), byLevel, GetKitbag()->GetEnergy( false, sPosID ) );
				GetKitbag()->SetChangeFlag(false);
				GetKitbag()->SetEnergy(false, byLevel, sPosID);
				GetKitbag()->SetSingleChangeFlag( sPosID );
				SynKitbagNew( enumSYN_KITBAG_FROM_NPC );
				return TRUE;
			}
		}
	}

	return FALSE;
}

BOOL CCharacter::GetTradeItemLevel( BYTE& byLevel )
{
	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	for( int i = 0; i < sNum; i++ )
	{
		pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont )
		{
			CItemRecord* pItem = GetItemRecordInfo( pGridCont->sID );
			if( pItem && pItem->sType == enumItemTypeTrade )
			{
				byLevel = (BYTE)pGridCont->sEnergy[0];
				return TRUE;
			}
		}
	}

	return FALSE;
}
BOOL CCharacter::AdjustTradeItemCess( USHORT sLowCess, USHORT sData )
{	
	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	Short	sPosID;
	for( int i = 0; i < sNum; i++ )
	{
		pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont )
		{
			CItemRecord* pItem = GetItemRecordInfo( pGridCont->sID );
			if( pItem && pItem->sType == enumItemTypeTrade )
			{
				sPosID = GetKitbag()->GetPosIDByNum( i );
				GetKitbag()->SetChangeFlag(false);
				//LG( "TradeCess", "角色%s添加贸易税点LowCess = %d, sData = %d, CurData = %d.", GetName(), sLowCess, sData, GetKitbag()->GetEnergy( true, sPosID ) );
				LG( "TradeCess", "character %s add trade lowCess:LowCess = %d, sData = %d, CurData = %d.", GetName(), sLowCess, sData, GetKitbag()->GetEnergy( true, sPosID ) );
				if( pGridCont->sEnergy[1] + sData >= sLowCess )
				{
					GetKitbag()->SetEnergy(true, sLowCess, sPosID);
				}
				else
				{
					GetKitbag()->SetEnergy(true, pGridCont->sEnergy[1] + sData, sPosID);
				}
				GetKitbag()->SetSingleChangeFlag( sPosID );
				SynKitbagNew( enumSYN_KITBAG_FROM_NPC );
				return TRUE;
			}
		}
	}

	return FALSE;
}

BOOL CCharacter::GetTradeItemData( BYTE& byLevel, USHORT& sCess )
{
	USHORT sNum = GetKitbag()->GetUseGridNum();
	SItemGrid *pGridCont;
	for( int i = 0; i < sNum; i++ )
	{
		pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont )
		{
			CItemRecord* pItem = GetItemRecordInfo( pGridCont->sID );
			if( pItem && pItem->sType == enumItemTypeTrade )
			{
				sCess  = (USHORT)pGridCont->sEnergy[1];
				byLevel = (BYTE)pGridCont->sEnergy[0];
				return TRUE;
			}
		}
	}

	return FALSE;
}

BOOL CCharacter::HasLeaveBagGrid( USHORT sNum )
{
	return sNum <= GetKitbag()->GetCapacity() - GetKitbag()->GetUseGridNum();
}

BOOL CCharacter::HasLeaveBagTempGrid( USHORT sNum )
{
	return sNum <= m_pCKitbagTmp->GetCapacity() - m_pCKitbagTmp->GetUseGridNum();
}

// 学习，升级技能并通告
// sSkillID，技能编号.chLv，等级.bSetLv，设置等级（true，设置等级 false，增加等级）.bUsePoint，是否消耗技能点
// 返回是否学习成功
bool CCharacter::LearnSkill(Short sSkillID, Char chLv, bool bSetLv, bool bUsePoint, bool bLimit)
{T_B
	//m_CLog.Log("开始学习技能：编号 %d，等级 %d，是否设置等级 %d.\n", sSkillID, chLv, bSetLv);
	m_CLog.Log("start study skill:skillID %d，level %d，whether set level %d.\n", sSkillID, chLv, bSetLv);
	if (sSkillID > defMAX_SKILL_NO)
	{
		//SystemNotice("技能不存在，超出索引范围.%d", sSkillID);
		SystemNotice(RES_STRING(GM_CHARACTERPRL_CPP_00040), sSkillID);
		//m_CLog.Log("学习失败：技能最大编号 %d\n", defMAX_SKILL_NO);
		m_CLog.Log("study failed:Max_skill_No %d\n", defMAX_SKILL_NO);
		return false;
	}

	CSkillRecord *pCSkill = GetSkillRecordInfo(sSkillID);
	if (!pCSkill)
	{
		//SystemNotice("技能不存在");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00044));
		//m_CLog.Log("学习失败：找不到该技能\n");
		m_CLog.Log("Study failed: can't find the skill\n");
		return false;
	}
	if (chLv < 0)
	{
		//SystemNotice("学习的技能等级[%d]错误", chLv);
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00045), chLv);
		//m_CLog.Log("学习失败：等级非法\n");
		m_CLog.Log("Study failed:level unlawful\n");
		return false;
	}

	SSkillGrid	*pSkillGrid, SAddSkill;
	Char		chOldLv, chNewLv;
	bool		bIsNewSkill = false;
	pSkillGrid = m_CSkillBag.GetSkillContByID(sSkillID);
	if (!pSkillGrid) // 新的技能
	{
		bIsNewSkill = true;
		chOldLv = 0;
		chNewLv = chLv;
	}
	else
	{
		chOldLv = pSkillGrid->chLv;
		if (bSetLv) // 设置等级
		{
			chNewLv = chLv;
			if (chNewLv <= chOldLv)
			{
				//SystemNotice("技能已存在，且等级高于学习值");
				SystemNotice(RES_STRING(GM_CHARACTER_CPP_00046));
				//m_CLog.Log("学习失败：等级非法，当前等级 %d，要设置的等级 %d.\n", chOldLv, chNewLv);
				m_CLog.Log("Study failed:level unlawful,currently level %d,will set level: %d.\n", chOldLv, chNewLv);
				return false;
			}
		}
		else // 增加等级
		{
			chNewLv = chOldLv + chLv;
		}
		SAddSkill.chState = pSkillGrid->chState;
	}

	if (bLimit && !CanLearnSkill(pCSkill, chNewLv)) // 不能学习该技能
	{
		//m_CLog.Log("学习失败：不能学习.\n");
		m_CLog.Log("Study failed:can't study.\n");
		return false;
	}

	m_CSkillBag.SetChangeSkillFlag(false);
	m_CChaAttr.ResetChangeFlag();
	SetBoatAttrChangeFlag(false);

	if (bUsePoint)
	{
		Long	lPExpend = pCSkill->chPointExpend * (chNewLv - chOldLv);
		if (pCSkill->chFightType == enumSKILL_LAND_LIVE || pCSkill->chFightType == enumSKILL_SEE_LIVE) // 生活技能，消耗生活技能点.
		{
			Long	lCurLP = (long)m_CChaAttr.GetAttr(ATTR_LIFETP);
			if (lPExpend > lCurLP) // 技能点不够
			{
				//SystemNotice("生活技能点不足：当前点 %d，需求点 %d.", lCurLP, lPExpend);
				//SystemNotice(RES_STRING(GM_CHARACTER_CPP_00047), lCurLP, lPExpend);
				char szData[128];
				CFormatParameter param(2);
				param.setLong( 0, lCurLP );
				param.setLong( 1, lPExpend );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00047, param, szData );
				SystemNotice( szData );
				//m_CLog.Log("学习失败：技能点不够.\n");
				m_CLog.Log("Study failed:Skillpoint not enough.\n");
				return false;
			}
			setAttr(ATTR_LIFETP, lCurLP - lPExpend);
		}
		else
		{
			Long	lCurTP = (long)m_CChaAttr.GetAttr(ATTR_TP);
			if (lPExpend > lCurTP) // 技能点不够
			{
				//SystemNotice("技能点不足：当前点 %d，需求点 %d.", lCurTP, lPExpend);
				//SystemNotice(RES_STRING(GM_CHARACTER_CPP_00048), lCurTP, lPExpend);
				char szData[128];
				CFormatParameter param(2);
				param.setLong( 0, lCurTP );
				param.setLong( 1, lPExpend );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00048, param, szData );
				SystemNotice( szData );
				//m_CLog.Log("学习失败：技能点不够.\n");
				m_CLog.Log("Study failed:skillpoint not enough.\n");
				return false;
			}
			setAttr(ATTR_TP, lCurTP - lPExpend);
		}
	}

	Long	lLastSkillTick = 0;
	if (pSkillGrid)
		lLastSkillTick = pSkillGrid->lColdDownT;
	SAddSkill.chLv = chNewLv;
	SAddSkill.sID = sSkillID;
	bool	bAddResult = m_CSkillBag.AddSkill(&SAddSkill);
	if (pSkillGrid)
		pSkillGrid->lColdDownT = lLastSkillTick;
	if (!bAddResult)
	{
		//SystemNotice("加入技能包失败");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00049));
		//m_CLog.Log("学习失败：加入技能包失败.\n");
		m_CLog.Log("Study failed:add skilpoint failed.\n");
		return false;
	}

	ChangeItem(false, m_SChaPart.SLink + enumEQUIP_LHAND, enumEQUIP_LHAND);
	if (bIsNewSkill)
	{
		GetPlyCtrlCha()->SkillRefresh();
		GetPlyMainCha()->SynSkillBag(enumSYN_SKILLBAG_ADD);
	}
	else
	{
		if (SAddSkill.chState == enumSUSTATE_ACTIVE) // 激活的技能，则先停止改变等级以前的技能，再激活改变等级后的技能
		{
			g_CParser.DoString(pCSkill->szInactive, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, chOldLv, DOSTRING_PARAM_END);
			g_CParser.DoString(pCSkill->szActive, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, chNewLv, DOSTRING_PARAM_END);
		}
		GetPlyMainCha()->SynSkillBag(enumSYN_SKILLBAG_MODI);
	}

	ChangeItem(true, m_SChaPart.SLink + enumEQUIP_LHAND, enumEQUIP_LHAND);

	g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
	if (GetPlayer())
	{
		GetPlayer()->RefreshBoatAttr();
		SyncBoatAttr(enumATTRSYN_REASSIGN);
	}
	SynAttrToSelf(enumATTRSYN_REASSIGN);

	//m_CLog.Log("学习成功.\n");
	m_CLog.Log("study succeed.\n");
	return true;
T_E}

// 职业，等级，前置技能（等级）的判断
bool CCharacter::CanLearnSkill(CSkillRecord *pCSkill, Char chToLv)
{
	bool	bJobOk = false;
	char	chJob = (char)m_CChaAttr.GetAttr(ATTR_JOB);
	for (int i = 0; i < defSKILL_JOB_SELECT_NUM; i++)
	{
		if (pCSkill->chJobSelect[i][0] == cchSkillRecordKeyValue)
			break;
		if (pCSkill->chJobSelect[i][0] == -1)
		{
			if (chToLv <= pCSkill->chJobSelect[i][1])
				bJobOk = true;
			break;
		}
		if (pCSkill->chJobSelect[i][0] == chJob)
		{
			if (chToLv <= pCSkill->chJobSelect[i][1])
				bJobOk = true;
			break;
		}
	}
	if (!bJobOk) // 职业，技能等级不符合
	{
		//SystemNotice("职业不符，或学习等级超过该职业的限制");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00050));
		//m_CLog.Log("不能学习：职业，技能等级不符合\n");
		m_CLog.Log("can't study:profession,skill level is not accord\n");
		return false;
	}

	if (pCSkill->sLevelDemand > m_CChaAttr.GetAttr(ATTR_LV)) // 等级不够
	{
		//SystemNotice("角色等级不够，当前等级 %d，需求等级 %d.", m_CChaAttr.GetAttr(ATTR_LV), pCSkill->sLevelDemand);
		//SystemNotice("RES_STRING(GM_CHARACTER_CPP_00051)", m_CChaAttr.GetAttr(ATTR_LV), pCSkill->sLevelDemand);
		char szData[128];
		CFormatParameter param(2);
		param.setInt64( 0, m_CChaAttr.GetAttr(ATTR_LV) );
		param.setDouble( 1, pCSkill->sLevelDemand );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00051, param, szData );
		SystemNotice( szData );
		//m_CLog.Log("不能学习：角色等级不够，当前等级 %d，需求等级 %d.\n", m_CChaAttr.GetAttr(ATTR_LV), pCSkill->sLevelDemand);
		m_CLog.Log("can't study:character level not enough%d，remand level %d.\n", m_CChaAttr.GetAttr(ATTR_LV), pCSkill->sLevelDemand);
		return false;
	}

	bool	bNeedSkill = true;
	SSkillGrid	*pSkillGrid;
	for (int i = 0; i < defSKILL_PRE_SKILL_NUM; i++)
	{
		if (pCSkill->sPremissSkill[i][0] == cchSkillRecordKeyValue)
			break;
		if (pCSkill->sPremissSkill[i][0] == -1)
			break;
		pSkillGrid = m_CSkillBag.GetSkillContByID(pCSkill->sPremissSkill[i][0]);
		if (!pSkillGrid || pSkillGrid->chLv < pCSkill->sPremissSkill[i][1])
		{
			bNeedSkill = false;
			break;
		}
	}
	if (!bNeedSkill) // 前置技能不符合
	{

		//SystemNotice("前置技能不符");
		SystemNotice(RES_STRING(GM_CHARACTER_CPP_00052));
		//m_CLog.Log("不能学习：前置技能不符合 .\n");
		m_CLog.Log("can't study:bNeedSkill is not accord.\n");
		return false;
	}

	return true;
}

// 修改：添加新增熔合道具装备检测条件
dbc::Short CCharacter::CanEquipItemNew(dbc::Short sItemID1, dbc::Short sItemID2 )
{
	CItemRecord* pItem1 = GetItemRecordInfo( sItemID1 );
	CItemRecord* pItem2 = ( sItemID2 > 0 ) ? GetItemRecordInfo( sItemID2 ) : NULL;

	if( !pItem1 ) return enumITEMOPT_ERROR_NONE;
	if( !pItem1->IsAllowEquip( m_pCChaRecord->lID ) ) {
		return enumITEMOPT_ERROR_BODY;
	}
	if( pItem2 && !pItem2->IsAllowEquip( m_pCChaRecord->lID ) )	{
		return enumITEMOPT_ERROR_BODY;
	}

	if( pItem2 )
	{
		if( pItem1->sNeedLv > pItem2->sNeedLv )
		{
			if( m_CChaAttr.GetAttr(ATTR_LV) < pItem1->sNeedLv )
			{
				return enumITEMOPT_ERROR_EQUIPLV;
			}
		}
		else
		{
			if( m_CChaAttr.GetAttr(ATTR_LV) < pItem2->sNeedLv )
			{
				return enumITEMOPT_ERROR_EQUIPLV;
			}
		}
	}
	else if( m_CChaAttr.GetAttr(ATTR_LV) < pItem1->sNeedLv )
	{
		return enumITEMOPT_ERROR_EQUIPLV;
	}

	char chJob = (char)m_CChaAttr.GetAttr( ATTR_JOB );
	for( char i = 0; i < MAX_JOB_TYPE; ++i )
	{
		if( pItem1->szWork[i] == cchItemRecordKeyValue ) 
		{
			break;
		}
		else if( pItem1->szWork[i] == char(-1) || pItem1->szWork[i] == chJob )
		{
			if( !pItem2 ) {
				return enumITEMOPT_SUCCESS;
			}

			for( char j = 0; j < MAX_JOB_TYPE; ++j )
			{
				if( pItem2->szWork[j] == char(-1) || pItem2->szWork[j] == chJob ) {
					return enumITEMOPT_SUCCESS;
				}
				else if( pItem2->szWork[j] == cchItemRecordKeyValue ) {
					break;
				}
			}
			break;
		}
	}

	return enumITEMOPT_ERROR_EQUIPJOB;
}

Short CCharacter::CanEquipItem(dbc::Short sItemID)
{
	CItemRecord	*pCItemRec = GetItemRecordInfo(sItemID);
	if (!pCItemRec)
		return enumITEMOPT_ERROR_NONE;
	if (!pCItemRec->IsAllowEquip(m_pCChaRecord->lID))
		return enumITEMOPT_ERROR_BODY;

	if (m_CChaAttr.GetAttr(ATTR_LV) < pCItemRec->sNeedLv)
		return enumITEMOPT_ERROR_EQUIPLV;
	for (char i = 0; i < MAX_JOB_TYPE; i++)
	{
		if (pCItemRec->szWork[i] == cchItemRecordKeyValue)
			break;
		if (pCItemRec->szWork[i] == -1)
			return enumITEMOPT_SUCCESS;
		if (m_CChaAttr.GetAttr(ATTR_JOB) == pCItemRec->szWork[i])
			return enumITEMOPT_SUCCESS;
	}

	return enumITEMOPT_ERROR_EQUIPJOB;
}

// 增加技能状态
bool CCharacter::AddSkillState(uChar uchFightID, uLong ulSrcWorldID, Long lSrcHandle, Char chObjType, Char chObjHabitat, Char chEffType,
							   uChar uchStateID, uChar uchStateLv, Long lOnTick, dbc::Char chType, bool bNotice)
{T_B
	if (uchStateID > SKILL_STATE_MAXID || uchStateLv > SKILL_STATE_LEVEL)
		return false;

	CCharacter	*pCCha = 0;
	Entity	*pCEnt = g_pGameApp->IsValidEntity(ulSrcWorldID, lSrcHandle);
	if (!pCEnt)
		return false;
	pCCha = pCEnt->IsCharacter();

	if (bNotice)
	{
		GetPlyMainCha()->SetLookChangeFlag();
		m_CChaAttr.ResetChangeFlag();
		m_CSkillState.ResetSkillStateChangeFlag();
		if (pCCha != g_pCSystemCha)
		{
			pCCha->GetPlyMainCha()->SetLookChangeFlag();
			pCCha->m_CChaAttr.ResetChangeFlag();
			pCCha->m_CSkillState.ResetSkillStateChangeFlag();
		}
	}

	CSkillStateRecord	*pSSkillState = GetCSkillStateRecordInfo(uchStateID);
	if (!pSSkillState)
		return false;

	SSkillStateUnit	*pState = m_CSkillState.GetSStateByID(uchStateID);
	bool	bAlreadyHas = false;
	uChar	uchOldLv = 0;
	if (pState)
	{
		bAlreadyHas = true;
		uchOldLv = pState->GetStateLv();
	}
	Char chAddType = pSSkillState->chAddType;
	if (chType != enumSSTATE_ADD_UNDEFINED)
		chAddType = chType;
	if (!m_CSkillState.AddSkillState(uchFightID, ulSrcWorldID, lSrcHandle, chObjType, chObjHabitat, chEffType, uchStateID, uchStateLv, GetTickCount(), lOnTick, chAddType))
		return false;
	if (!bAlreadyHas)
	{
		if (!pSSkillState->bCanMove)
			SetActControl(enumACTCONTROL_MOVE, false);
		if (!pSSkillState->bCanGSkill)
			SetActControl(enumACTCONTROL_USE_GSKILL, false);
		if (!pSSkillState->bCanMSkill)
			SetActControl(enumACTCONTROL_USE_MSKILL, false);
		if (!pSSkillState->bCanTrade)
			SetActControl(enumACTCONTROL_TRADE, false);
		if (!pSSkillState->bCanItem)
			SetActControl(enumACTCONTROL_USE_ITEM, false);
		if (!pSSkillState->bCanUnbeatable)
			SetActControl(enumACTCONTROL_INVINCIBLE, false);
		if (!pSSkillState->bCanItemmed)
			SetActControl(enumACTCONTROL_BEUSE_ITEM, false);
		if (!pSSkillState->bCanSkilled)
			SetActControl(enumACTCONTROL_BEUSE_SKILL, false);
		if (!pSSkillState->bOptItem)
			SetActControl(enumACTCONTROL_ITEM_OPT, false);
		if (!pSSkillState->bTalkToNPC)
			SetActControl(enumACTCONTROL_TALKTO_NPC, false);
		if (!pSSkillState->bNoHide)
		{
			if (GetSubMap())
				GetSubMap()->RefreshEyeshot(this, GetActControl(enumACTCONTROL_EYESHOT), false, GetActControl(enumACTCONTROL_NOSHOW));
			SetActControl(enumACTCONTROL_NOHIDE, false);
		}
		if (!pSSkillState->bNoShow)
		{
			if (GetSubMap())
				GetSubMap()->RefreshEyeshot(this, GetActControl(enumACTCONTROL_EYESHOT), GetActControl(enumACTCONTROL_NOHIDE), false);
			SetActControl(enumACTCONTROL_NOSHOW, false);
		}
	}

	Long	lOldHP = (long)m_CChaAttr.GetAttr(ATTR_HP);
	bool	bDie = false;
	if (bAlreadyHas)
	{
		if (uchOldLv != uchStateLv)
		{
			g_CParser.DoString(pSSkillState->szSubState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, uchOldLv, DOSTRING_PARAM_END);
			g_CParser.DoString(pSSkillState->szAddState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, uchStateLv, DOSTRING_PARAM_END);
		}
		else
			return false;
	}
	else
		g_CParser.DoString(pSSkillState->szAddState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, uchStateLv, DOSTRING_PARAM_END);
	BeUseSkill(lOldHP, (long)m_CChaAttr.GetAttr(ATTR_HP), pCCha, chEffType);

	if (lOldHP > 0 && m_CChaAttr.GetAttr(ATTR_HP) <= 0) // 死亡
	{
		SetDie(pCCha);
		bDie = true;
	}

	if (bNotice)
	{
		GetPlyMainCha()->SynLook(enumSYN_LOOK_CHANGE);
		SynSkillStateToEyeshot();
		SynAttr(enumATTRSYN_SKILL_STATE);
		if (pCCha != g_pCSystemCha)
		{
			pCCha->GetPlyMainCha()->SynLook(enumSYN_LOOK_CHANGE);
			pCCha->SynSkillStateToEyeshot();
			pCCha->SynAttr(enumATTRSYN_ATTACK);
		}
	}

	if (bDie) // 死亡
	{
		//m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
		Die();
		return true;
	}

	return true;
T_E}

// 删除状态
#ifdef COMPACT_MEM_2
bool CCharacter::DelSkillState(map<unsigned char, SSkillStateUnit>::iterator& pUnit, bool bNotice)
{T_B
	dbc::uChar uchStateID = pUnit->first;
	if (bNotice)
	{
		m_CChaAttr.ResetChangeFlag();
		m_CSkillState.ResetSkillStateChangeFlag();
	}

	CSkillStateRecord	*pSSkillState = GetCSkillStateRecordInfo(uchStateID);
	if (!pSSkillState)
		return false;
	SSkillStateUnit	*pState = m_CSkillState.GetSStateByID(uchStateID);
	if (!pState)
		return false;
	uChar	uchStateLv = pState->GetStateLv();
	bool	bDie = false;
	if (pState)
	{
		CCharacter	*pCCha = 0;
		Entity	*pCEnt = g_pGameApp->IsValidEntity(pState->ulSrcWorldID, pState->lSrcHandle);
		if (pCEnt)
			pCCha = pCEnt->IsCharacter();
		char	chEffType = pState->chEffType;

		m_CSkillState.m_SStateMap.erase(pUnit++);

		bool	bNoHide = GetActControl(enumACTCONTROL_NOHIDE);
		bool	bNoShow = GetActControl(enumACTCONTROL_NOSHOW);
		bool	bToNoHide = true, bToNoShow = true;
		for (int i = 0; i < enumACTCONTROL_MAX; i++)
			SetActControl(i);
		SetActControl(enumACTCONTROL_NOHIDE, bNoHide);
		SetActControl(enumACTCONTROL_NOSHOW, bNoShow);
		CSkillStateRecord	*pSTempSkillState;
		SSkillStateUnit		*pTempState;

		for (map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pTempState = &it->second;
			pSTempSkillState = GetCSkillStateRecordInfo(pTempState->GetStateID());
			if (!pSTempSkillState)
				continue;
			if (!pSTempSkillState->bCanMove)
				SetActControl(enumACTCONTROL_MOVE, false);
			if (!pSTempSkillState->bCanGSkill)
				SetActControl(enumACTCONTROL_USE_GSKILL, false);
			if (!pSTempSkillState->bCanMSkill)
				SetActControl(enumACTCONTROL_USE_MSKILL, false);
			if (!pSTempSkillState->bCanTrade)
				SetActControl(enumACTCONTROL_TRADE, false);
			if (!pSTempSkillState->bCanItem)
				SetActControl(enumACTCONTROL_USE_ITEM, false);
			if (!pSTempSkillState->bCanUnbeatable)
				SetActControl(enumACTCONTROL_INVINCIBLE, false);
			if (!pSTempSkillState->bCanItemmed)
				SetActControl(enumACTCONTROL_BEUSE_ITEM, false);
			if (!pSTempSkillState->bCanSkilled)
				SetActControl(enumACTCONTROL_BEUSE_SKILL, false);
			if (!pSTempSkillState->bOptItem)
				SetActControl(enumACTCONTROL_ITEM_OPT, false);
			if (!pSTempSkillState->bTalkToNPC)
				SetActControl(enumACTCONTROL_TALKTO_NPC, false);
			if (!pSTempSkillState->bNoHide)
				bToNoHide = false;
			if (!pSTempSkillState->bNoShow)
				bToNoShow = false;
		}
		if (bToNoHide != bNoHide || bToNoShow != bNoShow)
			if (GetSubMap())
				GetSubMap()->RefreshEyeshot(this, true, bToNoHide, bToNoShow);
		SetActControl(enumACTCONTROL_NOHIDE, bToNoHide);
		SetActControl(enumACTCONTROL_NOSHOW, bToNoShow);

		Long	lOldHP = (long)m_CChaAttr.GetAttr(ATTR_HP);

		g_CParser.DoString(pSSkillState->szSubState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, uchStateLv, DOSTRING_PARAM_END);

		BeUseSkill(lOldHP, (long)m_CChaAttr.GetAttr(ATTR_HP), pCCha, chEffType);
		if (lOldHP > 0 && m_CChaAttr.GetAttr(ATTR_HP) <= 0) // 死亡
		{
			SetDie(pCCha);
			bDie = true;
		}
	}

	if (bNotice)
	{
		SynSkillStateToEyeshot();
		SynAttr(enumATTRSYN_SKILL_STATE);
	}

	if (bDie) // 死亡
	{
		//m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
		Die();
		return true;
	}

	return true;
T_E}

#endif

bool CCharacter::DelSkillState(dbc::uChar uchStateID, bool bNotice)
{T_B
	if (bNotice)
	{
		m_CChaAttr.ResetChangeFlag();
		m_CSkillState.ResetSkillStateChangeFlag();
	}

	CSkillStateRecord	*pSSkillState = GetCSkillStateRecordInfo(uchStateID);
	if (!pSSkillState)
		return false;
	SSkillStateUnit	*pState = m_CSkillState.GetSStateByID(uchStateID);
	if (!pState)
		return false;
	uChar	uchStateLv = pState->GetStateLv();
	bool	bDie = false;
	if (pState)
	{
		CCharacter	*pCCha = 0;
		Entity	*pCEnt = g_pGameApp->IsValidEntity(pState->ulSrcWorldID, pState->lSrcHandle);
		if (pCEnt)
			pCCha = pCEnt->IsCharacter();
		char	chEffType = pState->chEffType;

		if (!m_CSkillState.DelSkillState(uchStateID))
			return false;

		bool	bNoHide = GetActControl(enumACTCONTROL_NOHIDE);
		bool	bNoShow = GetActControl(enumACTCONTROL_NOSHOW);
		bool	bToNoHide = true, bToNoShow = true;
		for (int i = 0; i < enumACTCONTROL_MAX; i++)
			SetActControl(i);
		SetActControl(enumACTCONTROL_NOHIDE, bNoHide);
		SetActControl(enumACTCONTROL_NOSHOW, bNoShow);
		CSkillStateRecord	*pSTempSkillState;
		SSkillStateUnit		*pTempState;
#ifdef COMPACT_MEM_2
		for (map<unsigned char, SSkillStateUnit>::iterator it = m_CSkillState.m_SStateMap.begin(); it != m_CSkillState.m_SStateMap.end(); it++)
		{
			pTempState = &it->second;
#else
		for (int i = 0; i < m_CSkillState.GetStateNum(); i++)
		{
			pTempState = m_CSkillState.GetSStateByNum(i);

			if (!pTempState)
				continue;
#endif
			pSTempSkillState = GetCSkillStateRecordInfo(pTempState->GetStateID());
			if (!pSTempSkillState)
				continue;
			if (!pSTempSkillState->bCanMove)
				SetActControl(enumACTCONTROL_MOVE, false);
			if (!pSTempSkillState->bCanGSkill)
				SetActControl(enumACTCONTROL_USE_GSKILL, false);
			if (!pSTempSkillState->bCanMSkill)
				SetActControl(enumACTCONTROL_USE_MSKILL, false);
			if (!pSTempSkillState->bCanTrade)
				SetActControl(enumACTCONTROL_TRADE, false);
			if (!pSTempSkillState->bCanItem)
				SetActControl(enumACTCONTROL_USE_ITEM, false);
			if (!pSTempSkillState->bCanUnbeatable)
				SetActControl(enumACTCONTROL_INVINCIBLE, false);
			if (!pSTempSkillState->bCanItemmed)
				SetActControl(enumACTCONTROL_BEUSE_ITEM, false);
			if (!pSTempSkillState->bCanSkilled)
				SetActControl(enumACTCONTROL_BEUSE_SKILL, false);
			if (!pSTempSkillState->bOptItem)
				SetActControl(enumACTCONTROL_ITEM_OPT, false);
			if (!pSTempSkillState->bTalkToNPC)
				SetActControl(enumACTCONTROL_TALKTO_NPC, false);
			if (!pSTempSkillState->bNoHide)
				bToNoHide = false;
			if (!pSTempSkillState->bNoShow)
				bToNoShow = false;
		}
		if (bToNoHide != bNoHide || bToNoShow != bNoShow)
			if (GetSubMap())
				GetSubMap()->RefreshEyeshot(this, true, bToNoHide, bToNoShow);
		SetActControl(enumACTCONTROL_NOHIDE, bToNoHide);
		SetActControl(enumACTCONTROL_NOSHOW, bToNoShow);

		Long	lOldHP = (long)m_CChaAttr.GetAttr(ATTR_HP);

		g_CParser.DoString(pSSkillState->szSubState, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, uchStateLv, DOSTRING_PARAM_END);

		BeUseSkill(lOldHP, (long)m_CChaAttr.GetAttr(ATTR_HP), pCCha, chEffType);
		if (lOldHP > 0 && m_CChaAttr.GetAttr(ATTR_HP) <= 0) // 死亡
		{
			SetDie(pCCha);
			bDie = true;
		}
	}

	if (bNotice)
	{
		SynSkillStateToEyeshot();
		SynAttr(enumATTRSYN_SKILL_STATE);
	}

	if (bDie) // 死亡
	{
		//m_CLog.Log("!!!死亡\tTick %u\n", GetTickCount());
		Die();
		return true;
	}

	return true;
T_E}

void CCharacter::RestoreHp( BYTE byHpRate )
{T_B
	m_CChaAttr.ResetChangeFlag();
	DWORD dwCharHp = (long)this->getAttr( ATTR_HP );
	dwCharHp += byHpRate*(long)getAttr( ATTR_MXHP )/100;
	if( dwCharHp > (DWORD)getAttr( ATTR_MXHP ) )
	{
		dwCharHp = (long)getAttr( ATTR_MXHP );
	}
	DWORD dwHp = dwCharHp - (long)getAttr( ATTR_HP );
	setAttr( ATTR_HP, dwCharHp );
	SynAttr( enumATTRSYN_TASK );
	//SystemNotice( "恢复HP值(%d)点，当前HP(%d).", dwHp, dwCharHp );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00053), dwHp, dwCharHp );
	char szData[128] = "";
	CFormatParameter param(2);
	param.setLong( 0, dwHp );
	param.setLong( 1, dwCharHp );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00053, param, szData );
	SystemNotice( szData );
T_E}

void CCharacter::RestoreSp( BYTE bySpRate )
{T_B
	m_CChaAttr.ResetChangeFlag();
	DWORD dwCharSp = (long)this->getAttr( ATTR_SP );
	dwCharSp += bySpRate*(long)getAttr( ATTR_MXSP )/100;
	if( dwCharSp > (DWORD)getAttr( ATTR_MXSP ) )
	{
		dwCharSp = (long)getAttr( ATTR_MXSP );
	}
	DWORD dwSp = dwCharSp - (DWORD)getAttr( ATTR_SP );
	setAttr( ATTR_SP, dwCharSp );
	SynAttr( enumATTRSYN_TASK );
	//SystemNotice( "恢复SP值(%d)点，当前SP(%d).", dwSp, dwCharSp );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00054), dwSp, dwCharSp );
	//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00053), dwHp, dwCharHp );
	char szData[128] = "";
	CFormatParameter param(2);
	param.setLong( 0, dwSp );
	param.setLong( 1, dwCharSp );
	RES_FORMAT_STRING( GM_CHARACTER_CPP_00054, param, szData );
	SystemNotice( szData );
T_E}

void CCharacter::RestoreAllHp()
{T_B
	m_CChaAttr.ResetChangeFlag();
	setAttr( ATTR_HP, (long)getAttr( ATTR_MXHP ) );
	SynAttr( enumATTRSYN_TASK );
	//SystemNotice( "恢复所有HP值，当前HP(%d).", getAttr( ATTR_HP ) );
	SystemNotice( RES_STRING(GM_CHARACTER_CPP_00055), (long)getAttr( ATTR_HP ) );
T_E}

void CCharacter::RestoreAllSp()
{T_B
	m_CChaAttr.ResetChangeFlag();
	setAttr( ATTR_SP, (long)getAttr( ATTR_MXSP ) );
	SynAttr( enumATTRSYN_TASK ); 
	//SystemNotice( "恢复所有SP值，当前SP(%d).", getAttr( ATTR_SP ) );
	SystemNotice( RES_STRING(GM_CHARACTER_CPP_00056), (long)getAttr( ATTR_SP ) );
T_E}

void CCharacter::RestoreAll()
{T_B
	m_CChaAttr.ResetChangeFlag();
	setAttr( ATTR_HP, (long)getAttr( ATTR_MXHP ) );
	setAttr( ATTR_SP, (long)getAttr( ATTR_MXSP ) );
	SynAttr( enumATTRSYN_TASK );
	//SystemNotice( "恢复所有HP值，当前HP(%d).", getAttr( ATTR_HP ) );
	SystemNotice( RES_STRING(GM_CHARACTER_CPP_00055), (long)getAttr( ATTR_HP ) );
	//SystemNotice( "恢复所有SP值，当前SP(%d).", getAttr( ATTR_SP ) );
	SystemNotice(RES_STRING(GM_CHARACTER_CPP_00056), (long)getAttr( ATTR_SP ) );
T_E}

long CCharacter::ExecuteEvent(Entity *pCObj, dbc::uShort usEventID)
{T_B
	long	lRet = 1;

	switch (pCObj->GetEvent().GetTouchType())
	{
	case	enumEVENTT_RANGE:
		{
			if (!IsRangePoint(pCObj->GetPos(), defRANGE_TOUCH_DIS))
				break;

			uShort	usEventEType = pCObj->GetEvent().GetExecType();
			void	*pTableRec = pCObj->GetEvent().GetTableRec();
			if (usEventEType == enumEVENTE_SMAP_ENTRY)
			{
				CSwitchMapRecord *pCSwitchMapRecord = (CSwitchMapRecord *)pTableRec;
				//m_CLog.Log("从当前地图[%s],切换到目标地图[%s]\n\n", m_submap->GetName(), pCSwitchMapRecord->szTarMapName);
				m_CLog.Log("from currently map[%s],switch to aim map[%s]\n\n", m_submap->GetName(), pCSwitchMapRecord->szTarMapName);

				SwitchMap(GetSubMap(), pCSwitchMapRecord->szTarMapName, pCSwitchMapRecord->STarPos.x, pCSwitchMapRecord->STarPos.y);
			}
			else if (usEventEType == enumEVENTE_DMAP_ENTRY)
			{
				CDynMapEntryCell	*pCEntry = (CDynMapEntryCell*)pTableRec;
				CMapEntryCopyCell	*pCCopyInfo = pCEntry->GetCopy(0);
				if (!pCCopyInfo)
				{
					//SystemNotice("副本不存在");
					SystemNotice(RES_STRING(GM_CHARACTER_CPP_00057));
					break;
				}
				if (!pCCopyInfo->HasFreePlyCount(1)) // 数量不足
				{
					//SystemNotice("人数已满");
					SystemNotice(RES_STRING(GM_CHARACTER_CPP_00058));
					break;
				}
				string	strScript = "check_can_enter_";
				strScript += pCEntry->GetTMapName();
				if (g_CParser.StringIsFunction(strScript.c_str()))
				{
					if (g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, this, pCCopyInfo, DOSTRING_PARAM_END))
					{
						if (!g_CParser.GetReturnNumber(0))
							break;
					}
				}
				pCCopyInfo->AddCurPlyNum(1);

				string	strScript1 = "begin_enter_";
				strScript1 += pCEntry->GetTMapName();

				g_CParser.DoString(strScript1.c_str(), enumSCRIPT_RETURN_NUMBER, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, this, pCCopyInfo, DOSTRING_PARAM_END);
			}
		}
		break;
	default:
		break;
	}

	return lRet;
T_E}

void CCharacter::AfterObjDie(CCharacter *pCAtk, CCharacter *pCDead)
{T_B
	if (GetPlayer())
	{
		bool	bExecProc = true;
		if (pCAtk != this)
		{
			g_CParser.DoString("CheckExpShare", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, this, pCAtk, DOSTRING_PARAM_END);
			if (g_CParser.GetReturnNumber(0) == 0)
				bExecProc = false;
		}
		if (bExecProc)
			GetPlayer()->MisEventProc( mission::TE_KILL, (uShort)pCDead->GetCat(), pCDead->GetID() );
	}
T_E}

void CCharacter::AfterPeekItem(dbc::Short sItemID, dbc::Short sNum) 
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisEventProc( mission::TE_GET_ITEM, sItemID, sNum );
	}
T_E}

void CCharacter::AfterEquipItem(dbc::Short sItemID, dbc::uShort sTriID)
{T_B
	if( GetPlayer() && sTriID != 0 )
	{
		GetPlayer()->MisEventProc( mission::TE_EQUIP_ITEM, sItemID, sTriID );
	}
T_E}

void CCharacter::EntryMapUnit( BYTE byMapID, WORD wxPos, WORD wyPos )
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisEventProc( mission::TE_GOTO_MAP, byMapID, (wxPos<<16)|wyPos );
	}
T_E}

void CCharacter::OnMissionTime()
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisEventProc( mission::TE_GAME_TIME, 0, 0 );
	}
	mission::CNpc* pNpc = this->IsNpc();
	if( pNpc )
	{
		pNpc->EventProc( mission::TE_GAME_TIME, 0, 0 );
	}
T_E}

void CCharacter::OnLevelUp( USHORT sLevel )
{T_B
	if( GetPlayer() )
	{
		
		//通知GroupServer
		if(sLevel == 41)
		{
			CCharacter *pMainCha = GetPlyMainCha();
			WPacket l_wpk = GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MP_MASTER_FINISH);
			WRITE_LONG(l_wpk,pMainCha->GetPlayer()->GetDBChaId());
			pMainCha->ReflectINFof(pMainCha,l_wpk);
		}
		
		GetPlayer()->MisEventProc( mission::TE_LEVEL_UP, sLevel, 0 );
	}
T_E}

void CCharacter::OnSailLvUp( USHORT sLevel )
{T_B
T_E}

void CCharacter::OnLifeLvUp( USHORT sLevel )
{T_B
T_E}

void CCharacter::OnCharBorn()
{T_B
	if( GetPlayer() )
	{
		GetPlayer()->MisEventProc( mission::TE_MAP_INIT, 0, 0 );
	}
T_E}

void CCharacter::Hide()
{T_B
	SSkillStateUnit	*pCState = m_CSkillState.GetSStateByID(SSTATE_HIDE);
	if (pCState)
		return;

	AddSkillState(0, g_pCSystemCha->GetID(), g_pCSystemCha->GetHandle(), enumSKILL_TYPE_SELF, enumSKILL_TAR_LORS, enumSKILL_EFF_HELPFUL, SSTATE_HIDE, 1, 10);
T_E}

void CCharacter::Show()
{T_B
	SSkillStateUnit	*pCState = m_CSkillState.GetSStateByID(SSTATE_HIDE);
	if (!pCState)
		return;

	DelSkillState(SSTATE_HIDE);
T_E}

//=============================================================================
// 计算由装备变化带来的角色属性的变化
// bEquip：0，卸下装备.1，装备.
// lItemID：装备编号
//=============================================================================
void CCharacter::ChangeItem(bool bEquip, SItemGrid *pItemCont, Char chLinkID)
{T_B
	//add by ALLEN 2007-10-16
	if(this->IsReadBook())
		return;

	if (!pItemCont->IsValid())
		return;

	CItemRecord	*pCItemRec = GetItemRecordInfo(pItemCont->sID);
	if (!pCItemRec) // 道具表中没有该道具
		return;

	char	chType = 1;
	if (!bEquip) // 卸下装备
		chType = -1;

	float	fBalance;
	if (chLinkID == enumEQUIP_LHAND)
		fBalance = 1 - pCItemRec->sLHandValu * (100 - m_CChaAttr.GetAttr(ATTR_LHAND_ITEMV)) / float(100);
	else
		fBalance = 1;

	long	lChaAttrType;
	float fLvEffect1 = 1.0;
	float fLvEffect2 = 0.0;
	float fLvEffect3 = 0.0;
	int nLv = 10;

	// modify by ning.yan  20080821  begin
	//if( pItemCont->sID >= CItemRecord::enumItemFusionStart && pItemCont->sID < CItemRecord::enumItemFusionEnd && pItemCont->GetFusionItemID() )
	CItemRecord * pItem = GetItemRecordInfo(pItemCont->sID);
	if(CItemRecord::IsVaildFusionID(pItem) && pItemCont->GetFusionItemID() ) // ning.yan end
	{
		fLvEffect1 = float(80)/100;
		fLvEffect2 = float(pItemCont->GetItemLevel() * 2)/100;
		fLvEffect3 = float((pItemCont->GetItemLevel() - nLv) * 2)/100;

		for (int i = ITEMATTR_COE_STR; i <= ITEMATTR_COE_COL; i++)
		{
			lChaAttrType = g_ConvItemAttrTypeToCha(i);
			long lTemp = pItemCont->GetAttr(i);
			m_CChaAttr.AddAttr(lChaAttrType, Long(chType * lTemp * (lTemp > 0 ? fLvEffect1 + fLvEffect2 : float(1.0) - fLvEffect3) ));
		}
		for (int i = ITEMATTR_VAL_STR; i <= ITEMATTR_VAL_PDEF; i++)
		{
			lChaAttrType = g_ConvItemAttrTypeToCha(i);
			long lTemp = pItemCont->GetAttr(i);
			m_CChaAttr.AddAttr(lChaAttrType, Long(chType * lTemp * (lTemp > 0 ? fLvEffect1 + fLvEffect2 : float(1.0) - fLvEffect3) ));
		}
	}
	else
	{
		for (int i = ITEMATTR_COE_STR; i <= ITEMATTR_COE_COL; i++)
		{
			lChaAttrType = g_ConvItemAttrTypeToCha(i);
			long lTemp = pItemCont->GetAttr(i);
			m_CChaAttr.AddAttr(lChaAttrType, Long(chType * pItemCont->GetAttr(i)));
		}
		for (int i = ITEMATTR_VAL_STR; i <= ITEMATTR_VAL_PDEF; i++)
		{
			lChaAttrType = g_ConvItemAttrTypeToCha(i);
			m_CChaAttr.AddAttr(lChaAttrType, Long(chType * pItemCont->GetAttr(i)));
		}
	}

	m_CChaAttr.AddAttr(ATTR_ITEMV_MNATK, -1 * chType * pItemCont->GetAttr(ITEMATTR_VAL_MNATK));
	m_CChaAttr.AddAttr(ATTR_ITEMV_MXATK, -1 * chType * pItemCont->GetAttr(ITEMATTR_VAL_MXATK));
	m_CChaAttr.AddAttr(ATTR_ITEMV_MNATK, Long(chType * pItemCont->GetAttr(ITEMATTR_VAL_MNATK) * fBalance));
	m_CChaAttr.AddAttr(ATTR_ITEMV_MXATK, Long(chType * pItemCont->GetAttr(ITEMATTR_VAL_MXATK) * fBalance));
T_E}

void CCharacter::SkillRefresh()
{T_B
	CCharacter	*pCMainCha = GetPlyMainCha();
	CCharacter	*pCCtrlCha = GetPlyCtrlCha();
	CCharacter	*pCExecCha;

	bool		bIsBoat = pCCtrlCha->IsBoat();

	CSkillBag	*pCSkillBag = &pCMainCha->m_CSkillBag;
	stNetChangeChaPart	*pCLook = &pCMainCha->m_SChaPart;

	pCMainCha->m_sDefSkillNo = 0;
	SSkillGrid		*pSkillGrid;
	short sSkillNum = pCSkillBag->GetSkillNum();
	int nActive;
	CSkillRecord	*pCSkillRecord;
#ifdef COMPACT_MEM	
	for(map<short,  SSkillGrid>::iterator it = pCSkillBag->m_SBagMap.begin(); it != pCSkillBag->m_SBagMap.end(); it++)
	{
		pSkillGrid = &it->second;
#else
	for (short i = 0; i < sSkillNum; i++)
	{
		pSkillGrid = pCSkillBag->GetSkillContByNum(i);
#endif
		if (!pSkillGrid)
			continue;
		pCSkillRecord = GetSkillRecordInfo(pSkillGrid->sID);
		if (!pCSkillRecord)
			continue;
		if (pCSkillRecord->chFightType == enumSKILL_SEE_LIVE) // 海上生活技能
			nActive = g_IsUseSeaLiveSkill((long)getAttr(ATTR_BOAT_PART), pCSkillRecord);
		else
			nActive = g_IsUseSkill(pCLook, pCSkillRecord);

		if (pCSkillRecord->chType == enumSKILL_ACTIVE || pCSkillRecord->chType == enumSKILL_INBORN) // 主动技能或默认技能，根据角色形态，决定是否激活
		{
			//if (IsPlayerCha()) // 怪物角色不会进行技能刷新
			{
				if (bIsBoat && (pCSkillRecord->chSrcType == enumSKILL_SRC_HUMAN))
					nActive = 0;
				else if (!bIsBoat && (pCSkillRecord->chSrcType == enumSKILL_SRC_BOAT))
					nActive = 0;
			}
		}

		if (nActive == 1)
		{
			if (pCSkillRecord->chType == enumSKILL_INBORN)
				pCMainCha->m_sDefSkillNo = pSkillGrid->sID;
			if (pSkillGrid->chState != enumSUSTATE_ACTIVE)
			{
				if (strcmp(pCSkillRecord->szActive, "0"))
				{
					if (pCSkillRecord->chType == enumSKILL_PASSIVE) // 被动技能,由人形角色计算
						pCExecCha = pCMainCha;
					else
						pCExecCha = pCCtrlCha;
					g_CParser.DoString(pCSkillRecord->szActive, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCExecCha, enumSCRIPT_PARAM_NUMBER, 1, pSkillGrid->chLv, DOSTRING_PARAM_END);
				}
				pCSkillBag->SetSkillState(pSkillGrid->sID, enumSUSTATE_ACTIVE);
			}
		}
		else if (nActive == 0)
		{
			if (pSkillGrid->chState != enumSUSTATE_INACTIVE)
			{
				if (strcmp(pCSkillRecord->szInactive, "0"))
				{
					if (pCSkillRecord->chType == enumSKILL_PASSIVE) // 被动技能,由人形角色计算
						pCExecCha = pCMainCha;
					else
						pCExecCha = pCCtrlCha;
					g_CParser.DoString(pCSkillRecord->szInactive, enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCExecCha, enumSCRIPT_PARAM_NUMBER, 1, pSkillGrid->chLv, DOSTRING_PARAM_END);
				}
				pCSkillBag->SetSkillState(pSkillGrid->sID, enumSUSTATE_INACTIVE);
			}
		}
	}

	if (bIsBoat) // 船角色
	{
#ifdef COMPACT_MEM
		pSkillGrid = pCCtrlCha->m_CSkillBag.GetFirstSkill();
#else
		pSkillGrid = pCCtrlCha->m_CSkillBag.GetSkillContByNum(0);
#endif
		if (pSkillGrid)
			if (GetPlayer())
				pCMainCha->m_sDefSkillNo = pSkillGrid->sID;
	}
T_E}

// 转职
BOOL CCharacter::SetProfession( BYTE byPf )
{
	m_CChaAttr.ResetChangeFlag();
	setAttr(ATTR_JOB, byPf);
	SetBoatAttrChangeFlag(false);
	g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
	if (GetPlayer())
	{
		GetPlayer()->RefreshBoatAttr();
		SyncBoatAttr(enumATTRSYN_CHANGE_JOB);
	}
	SynAttrToSelf(enumATTRSYN_CHANGE_JOB);
	return TRUE;
}

// 同步道具栏
void CCharacter::SynKitbagNew(Char chType)
{T_B
	if (!GetKitbag()->IsChange())
		return;

	WPACKET WtPk = GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	// 通告行动
	WRITE_LONG(WtPk, GetID());
	WRITE_LONG(WtPk, m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_KITBAG);
	WriteKitbag(this->GetKitbag(), WtPk, chType);
	ReflectINFof(this, WtPk);

	SynAppendLook();
T_E}

//同步临时背包
void CCharacter::SynKitbagTmpNew(Char chType)
{T_B
	if (!m_pCKitbagTmp->IsChange())
		return;

	WPACKET WtPk = GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	// 通告行动
	WRITE_LONG(WtPk, GetID());
	WRITE_LONG(WtPk, m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_KITBAGTMP);
	WriteKitbag(m_pCKitbagTmp, WtPk, chType);
	ReflectINFof(this, WtPk);

	//SynAppendLook();
T_E}

// 同步快捷栏
void CCharacter::SynShortcut()
{T_B
	WPACKET WtPk = GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
	WRITE_LONG(WtPk, GetID());
	WRITE_LONG(WtPk, m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_SHORTCUT);
	WriteShortcut(WtPk);
	ReflectINFof(this, WtPk);
T_E}

// 同步角色外观(角色外观信息写包)
void CCharacter::SynLook(dbc::Char chSynType)
{T_B
	if (GetLookChangeNum() == 0)
		return;

	WPACKET WtPk=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
	WRITE_LONG(WtPk, GetID());
	WRITE_LONG(WtPk, m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_LOOK);
	WriteLookData(WtPk, 0, chSynType);

	if (chSynType == enumSYN_LOOK_SWITCH)
		NotiChgToEyeshot(WtPk);//通告
	else
		ReflectINFof(this, WtPk);
T_E}

void CCharacter::ChaInitEquip(void)
{T_B
	CJobEquipRecord	*pCInitEquip = GetJobEquipRecordInfo((long)m_CChaAttr.GetAttr(ATTR_JOB));
	if (!pCInitEquip)
		return;

	SItemGrid	GridCont;
	for (short i = 0; i < defJOB_INIT_EQUIP_MAX; i++)
	{
		if (pCInitEquip->sItemID[i] > 0)
		{
			GridCont.sID = pCInitEquip->sItemID[i];
			GridCont.sNum = 1;
			GridCont.SetDBParam(-1, 0);
			ItemInstance(enumITEM_INST_BUY, &GridCont);
			KbPushItem(false, false, &GridCont, i);
		}
	}
T_E}

void CCharacter::ResetBirthInfo(void)
{
	SBirthPoint	*pSBirthP = GetRandBirthPoint(GetLogName(), GetBirthCity());
	SetBirthMap(pSBirthP->szMapName);
	SetPos(pSBirthP->x * 100, pSBirthP->y * 100);
}

void CCharacter::NewChaInit(void)
{T_B
	m_CChaAttr.Init(GetCat());
	GetKitbag()->Init(GetKitbag()->GetCapacity());
	ChaInitEquip();

	EnrichSkillBag();
T_E}

// 精炼道具并同步
bool CCharacter::ItemForge(SItemGrid *pItem, dbc::Char chAddLv)
{T_B
	bool	bForge = false;
	// 根据道具安定值，判定是否精炼成功
	bForge = true;

	if (bForge)
	{
		//pItem->sForgeAttr[0][0] = 0;
		//pItem->chForgeLv = chAddLv;
		//g_CParser.DoString("Creat_Item", enumSCRIPT_RETURN_NUMBER, nRetNum, enumSCRIPT_PARAM_NUMBER, 3, pCItemRec->sType, pCItemRec->sNeedLv, chType);
	}

	return bForge;
T_E}

//=============================================================================
// 同步技能栏
// chType 同步类型.
// 当chType == enumSYN_SKILLBAG_MODI时，sModiSkillID表示修改的技能ID(-1为全部修改).
// chType为其他类型时，sModiSkillID无意义
//=============================================================================
void CCharacter::SynSkillBag(Char chType)
{T_B
	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_SYNSKILLBAG);
	WRITE_LONG(pk, GetID());
	WriteSkillbag(pk, chType);

	ReflectINFof(this, pk);
T_E}

void CCharacter::SynAddItemCha(CCharacter *pCItemCha)
{
	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_ADD_ITEM_CHA);
	WRITE_LONG(pk, GetPlayer()->GetMainCha()->GetID());
	WriteItemChaBoat(pk, pCItemCha);

	ReflectINFof(this, pk);
}

void CCharacter::SynDelItemCha(CCharacter *pCItemCha)
{
	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_DEL_ITEM_CHA);
	WRITE_LONG(pk, GetPlayer()->GetMainCha()->GetID());
	WRITE_LONG(pk, pCItemCha->GetID());

	ReflectINFof(this, pk);
}

void CCharacter::CheckPing(void)
{
	WPACKET WtPk	=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_CHECK_PING);	//通告行动
	for (uLong i = 0; i < m_ulPingDataLen; i++)
		WRITE_CHAR(WtPk, rand()/255);
	ReflectINFof(this, WtPk);//通告

	m_dwPingSendTick = GetTickCount();
}

void CCharacter::SendPreMoveTime(void)
{
	WPACKET WtPk	=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_PREMOVE_TIME);	//通告行动
	if (m_lSetPing >= 0)
		WRITE_LONG(WtPk, m_lSetPing);
	else
		WRITE_LONG(WtPk, m_dwPing);
	ReflectINFof(this, WtPk);//通告
}

void CCharacter::SynPKCtrl(void)
{
	WPACKET WtPk	=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
	WRITE_LONG(WtPk, m_ID);
	WRITE_LONG(WtPk, m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_PK_CTRL);
	WritePKCtrl(WtPk);
	NotiChgToEyeshot(WtPk);//通告
	//ReflectINFof(this, WtPk);//通告
}

void CCharacter::SynSideInfo(void)
{
	WPACKET WtPk	=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_SIDE_INFO);	//通告行动
	WRITE_LONG(WtPk, m_ID);
	WriteSideInfo(WtPk);
	NotiChgToEyeshot(WtPk);//通告
}

void CCharacter::TerminalMessage(Long lMessageID)
{T_B
	WPACKET pk	=GETWPACKET();
	WRITE_CMD(pk, CMD_MC_MESSAGE);
	WRITE_LONG(pk, GetID());
	WRITE_LONG(pk, lMessageID);

	ReflectINFof(this, pk);
T_E}

void CCharacter::ItemOprateFailed(Short sFailedID)
{
	WPACKET WtPk	=GETWPACKET();
	WRITE_CMD(WtPk, CMD_MC_NOTIACTION);	//通告行动
	WRITE_LONG(WtPk, m_ID);
	WRITE_LONG(WtPk, m_ulPacketID);
	WRITE_CHAR(WtPk, enumACTION_ITEM_FAILED);
	WRITE_SHORT(WtPk, sFailedID);
	ReflectINFof(this, WtPk);//通告
}

void CCharacter::AreaChange(void)
{
	//if ((m_usAreaAttr[0] & enumAREA_TYPE_NOT_PK) != (m_usAreaAttr[1] & enumAREA_TYPE_NOT_PK))
	//{
	//	Cmd_SetInGymkhana(m_usAreaAttr[1] & enumAREA_TYPE_NOT_PK);
	//	SynPKCtrl();
	//}
}

void CCharacter::SetEnterGymkhana(bool bEnter)
{
	CPlayer	*pPlayer = GetPlayer();
	if(!pPlayer)
		return;
	//if (bEnter)
	//	game_db.SavePlayerPos(pPlayer);

	Cmd_SetInGymkhana(bEnter);
	SynPKCtrl();
}

// 船只操作接口函数
// 检验船只创建和更新数据是否符合要求,并储存数据库
BOOL CCharacter::BoatCreate( const BOAT_DATA& Data )
{T_B	

	return FALSE;
T_E}

BOOL CCharacter::BoatUpdate( BYTE byIndex, const BOAT_DATA& Data )
{T_B
	return FALSE;
T_E}

// 角色船只装载创建
BOOL CCharacter::BoatLoad( const BOAT_LOAD_INFO& Info )
{T_B
	return FALSE;
T_E}

// 船只死亡处理
void CCharacter::BoatDie( CCharacter& Attacker, CCharacter& Boat )
{
	GetPlayer()->SetLuanchOut( -1 );
	if( Boat.OnBoatDie( Attacker ) )
	{
		//BickerNotice( "船只%s损坏严重无法修补已被销毁!", Boat.GetName() );
		BickerNotice( RES_STRING(GM_CHARACTER_CPP_00059), Boat.GetName() );
		
		// 销毁船长证明
		DWORD dwBoatID = (long)Boat.getAttr( ATTR_BOAT_DBID );
		USHORT sNumGird = GetKitbag()->GetUseGridNum();
		for( int i = 0; i < sNumGird; i++ )
		{
			SItemGrid *pGridCont = GetKitbag()->GetGridContByNum( i );
			if( pGridCont )
			{
				CItemRecord* pItem = GetItemRecordInfo( pGridCont->sID );
				if( pItem == NULL )
				{
					//SystemNotice( "物品ID错误，无法找到该物品信息!ID = %d", pGridCont->sID );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00005), pGridCont->sID );
					//LG( "boat_error", "物品ID错误，无法找到该物品信息!ID = %d", pGridCont->sID );
					//LG( "boat_error", "物品ID错误，无法找到该物品信息!ID = %d", pGridCont->sID );
					LG( "boat_error", "GridID error，can't find the gridID = %d", pGridCont->sID );
					continue;
				}
				if( pItem->sType == enumItemTypeBoat && dwBoatID == pGridCont->GetDBParam( enumITEMDBP_INST_ID ) )
				{
					short sPosID = GetKitbag()->GetPosIDByNum(i);
					if (sPosID < 0)
					{
						//SystemNotice( "物品ID错误，无法找到该物品信息!ID = %d", pGridCont->sID );
						SystemNotice( RES_STRING(GM_CHARACTER_CPP_00005), pGridCont->sID );
						//LG( "boat_error", "物品ID错误，无法找到该物品信息!ID = %d", pGridCont->sID );
						LG( "boat_error", "GridID error，can't find the gridID = %d", pGridCont->sID );
						continue;
					}
					if( KbClearItem(true, true, sPosID) != enumKBACT_SUCCESS )
					{
						// 销毁船长证明失败
						//SystemNotice( "BoatDie:销毁船长证明失败!ID[0x%X]", dwBoatID );
						SystemNotice( RES_STRING(GM_CHARACTER_CPP_00060), dwBoatID );
						//LG( "boat_error", "BoatDie:销毁船长证明失败!ID[0x%X]", dwBoatID );
						LG( "boat_error", "BoatDie:destroy captain prove failed! ID[0x%X]", dwBoatID );
						break;
					}
				}
			}
		}
		
		// 销毁船只
		if( !GetPlayer()->ClearBoat( dwBoatID ) )
		{
			char szData[128];
			//sprintf( szData, "BoatDie:销毁船只%s失败!ID[%d]", Boat.GetName(), Boat.getAttr( ATTR_BOAT_DBID ) );
			//sprintf( szData, RES_STRING(GM_CHARACTER_CPP_00061), Boat.GetName(), Boat.getAttr( ATTR_BOAT_DBID ) );
			//_snprintf_s( szData,sizeof(szData),_TRUNCATE, RES_STRING(GM_CHARACTER_CPP_00061), Boat.GetName(), Boat.getAttr( ATTR_BOAT_DBID ) );
			CFormatParameter param(2);
			param.setString( 0, Boat.GetName() );
			param.setInt64( 1, Boat.getAttr( ATTR_BOAT_DBID ) );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00061, param, szData );
			SystemNotice( szData );
			LG( "boat_error", szData );
		}
		return;
	}

	//g_CParser.DoString( "Ship_ShipDieAttr", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, &Boat, DOSTRING_PARAM_END );
	//BickerNotice( "船只%s损坏沉入海底，请找出海NPC打捞!", Boat.GetName() );
	BickerNotice( RES_STRING(GM_CHARACTER_CPP_00062), Boat.GetName() );
}

BOOL CCharacter::OnBoatDie( CCharacter& Attacker )
{
	setAttr( ATTR_BOAT_ISDEAD, 1 );
	game_db.SaveBoatTempData( *this );

	return FALSE;
}

BOOL CCharacter::GetBoatID( BYTE byIndex, DWORD& dwBoatID )
{
	if( GetPlayer() )
	{
		USHORT sBerthID, sxPos, syPos, sDir;
		GetPlayer()->GetBerth( sBerthID, sxPos, syPos, sDir );

		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "BoatSelected:你没有停泊在该港口的修理船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00063) );
			return TRUE;
		}

		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatSelected:选择修理船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00064), byIndex );
			return FALSE;
		}

		CCharacter* pBoat = GetPlayer()->GetBoat( Data.byID[byIndex] );
		if( !pBoat )
		{
			return FALSE;
		}
		dwBoatID = pBoat->GetID();
		return TRUE;
	}
	return FALSE;
}

//	*
void	lgtool_printBoat(	const	char*	sType,	CCharacter*	pCCha	);

// 船只停泊
BOOL CCharacter::BoatBerth( USHORT sBerthID, USHORT sxPos, USHORT syPos, USHORT sDir )
{T_B
	CCharacter* pBoat = GetPlayer()->GetLuanchOut();
	if( !pBoat || pBoat != this ) {
		//SystemNotice( "找不到你的出海船只!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00065) );
		return FALSE;
	}

	// 设置船只位于新的港口
	this->setAttr( ATTR_BOAT_BERTH, sBerthID );

	if (!pBoat->SkillOutBoat(sxPos * 100, syPos * 100, sDir))
		return FALSE;

	g_CParser.DoString( "Ship_ExAttrCheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pBoat->GetPlayer()->GetMainCha(), pBoat, DOSTRING_PARAM_END );

	//	2008-8-21	yangyinyu	add	begin!
	//CCharacter*	c	=	this->GetBoat();
	//this->GetPlayer()->GetMainCha()->SetBoat(	pBoat	);
	//lgtool_printBoat( "@停泊@",	this->GetPlayer()->GetMainCha()	);
	//this->GetPlayer()->GetMainCha()->SetBoat(	c	);
	//	2008-8-21	yangyinyu	add	end!

	pBoat->SkillPushBoat(pBoat, false);

	// 重设出海标记
	m_pCPlayer->SetLuanchOut( -1 );

	return TRUE;
T_E}

// 船只出海
BOOL CCharacter::BoatEnterMap( CCharacter& Boat, DWORD dwxPos, DWORD dwyPos, USHORT sDir )
{T_B
	// 船只进入地图
	if (!SkillPopBoat(&Boat, dwxPos, dwyPos, sDir))
	{
		//SystemNotice( "船只进入地图失败!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00066) );
		return FALSE;
	}
	SkillInBoat(&Boat);

	// 设置出海船只
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	m_pCPlayer->SetLuanchOut( dwBoatID );

	//	2008-8-21	yangyinyu	add	begin!
	//CCharacter*	c	=	this->GetBoat();
	//this->SetBoat(	&Boat	);
	//lgtool_printBoat( RES_STRING(GM_CHARACTER_CPP_00122),	this	);
	//this->SetBoat(	c	);
	//	2008-8-21	yangyinyu	add	end!

	return TRUE;
T_E}

// 船只出海
BOOL CCharacter::BoatLaunch( BYTE byIndex, USHORT sBerthID, USHORT sxPos, USHORT syPos, USHORT sDir )
{T_B
	// 已经出海
	if( m_pCPlayer->IsLuanchOut() )
	{
		//SystemNotice( "你的船只已经出海了!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00067) );
		return FALSE;
	}

	CCharacter* pBoat = GetPlayer()->GetBoat( byIndex );
	if( !pBoat )
	{
		return FALSE;
	}

	if( pBoat->getAttr( ATTR_BOAT_ISDEAD ) != 0 )
	{
		//SystemNotice( "船只%s已经沉没，请先打捞!", pBoat->GetName() );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00068), pBoat->GetName() );
		return TRUE;
	}

	// 判断是否符合条件出海
	if( g_CharBoat.BoatLimit( *GetPlayer()->GetMainCha(), (USHORT)pBoat->getAttr( ATTR_BOAT_SHIP ) ) )
	{
		return TRUE;
	}

	if( pBoat->getAttr( ATTR_HP ) <= 0 )
	{
		//SystemNotice( "船只损坏严重，需要修理后才能出海!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00069) );
		return TRUE;
	}

	//if( pBoat->getAttr( ATTR_HP ) < pBoat->getAttr( ATTR_MXHP ) )
	//{
	//	SystemNotice( "船只损坏，需要修理!" );
	//}

	//if( pBoat->getAttr( ATTR_SP ) < pBoat->getAttr( ATTR_MXSP ) )
	//{
	//	SystemNotice( "船只需要补给!" );
	//}

	if(g_CParser.DoString("RemoveYS", enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END))
	{
		int ret = g_CParser.GetReturnNumber(0);
		if(ret != 1)
		{
			//LG("RemoveYS_error", "RemoveYS失败!\n");
			LG("RemoveYS_error", "RemoveYS failed\n");
		}
	}

	// 船只进入地图
	if( !BoatEnterMap( *pBoat, sxPos * 100, syPos * 100, sDir ) )
	{
		//SystemNotice( "船只进入地图失败!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00070) );
		return FALSE;
	}

	return TRUE;
T_E}

BOOL CCharacter::BoatSelLuanch( BYTE byIndex )
{
	if( GetPlayer() )
	{
        if(GetKitbag()->IsLock())
        {
           // SystemNotice( "背包锁定时不允许出海!" );
			 SystemNotice( RES_STRING(GM_CHARACTER_CPP_00071) );
            return FALSE;
        }
		// 设置角色出海数据信息
		USHORT sBerthID, sxPos, syPos, sDir;
		GetPlayer()->GetBerth( sBerthID, sxPos, syPos, sDir );
		
		// 检测角色是否在npc20米范围内
		//if( !IsDist( GetShape().centre.x, GetShape().centre.y, sxPos*100, syPos*100, 40 ) )
		//{
		//	SystemNotice( "你现在出海的位置不在港口!" );
		//	return FALSE;
		//}

		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetAllBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "你没有停泊在该港口的船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00072) );
			return TRUE;
		}

		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatSelLuance:选择出海船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00073), byIndex );
			return FALSE;
		}

		return BoatLaunch( Data.byID[byIndex], sBerthID, sxPos, syPos, sDir );
	}
	return TRUE;
}

// 船只货舱数据交易
BOOL CCharacter::BoatTrade( USHORT sBerthID )
{T_B
	// 设置角色出海数据信息
	if( m_pCPlayer )
	{
		m_pCPlayer->SetBerth( sBerthID, 0, 0, 0 );
		return TRUE;
	}

	return FALSE;
T_E}

BOOL CCharacter::HasAllBoatInBerth( USHORT sBerthID )
{
	return ( GetPlayer() ) ? GetPlayer()->HasAllBoatInBerth( sBerthID ) : FALSE; 
}

BOOL CCharacter::HasBoatInBerth( USHORT sBerthID )
{ 
	return ( GetPlayer() ) ? GetPlayer()->HasBoatInBerth( sBerthID ) : FALSE; 
}

BOOL CCharacter::HasDeadBoatInBerth( USHORT sBerthID )
{
	return ( GetPlayer() ) ? GetPlayer()->HasDeadBoatInBerth( sBerthID ) : FALSE; 
}

BOOL CCharacter::IsNeedRepair()
{
	if( GetPlayer() )
	{
		CCharacter* pBoat = GetPlayer()->GetLuanchOut();
		if( pBoat == NULL )
		{
			return FALSE;
		}
		return pBoat->getAttr( ATTR_BOAT_DIECOUNT ) > 0;
	}
	return FALSE;
}

BOOL CCharacter::IsNeedSupply()
{
	if( GetPlayer() )
	{
		CCharacter* pBoat = GetPlayer()->GetLuanchOut();
		if( pBoat == NULL )
		{
			return FALSE;
		}
		return pBoat->getAttr( ATTR_MXSP ) > pBoat->getAttr( ATTR_SP );
	}
	return FALSE;
}

void CCharacter::RepairBoat()
{
	if( GetPlayer() )
	{
		CCharacter* pChar = GetPlayer()->GetMainCha();
		CCharacter* pBoat = GetPlayer()->GetLuanchOut();
		if( pBoat == NULL )
		{
			//SystemNotice( "你的船只还没有出海，快速修理失败!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00074) );
			return;
		}
		DWORD dwMaxHp = (DWORD)pBoat->getAttr( ATTR_MXHP );		
		if( dwMaxHp - pBoat->getAttr( ATTR_HP ) == 0 || dwMaxHp <= (DWORD)pBoat->getAttr( ATTR_HP ) )
		{
			//SystemNotice( "船只%s状况很好，不需要修理.", pBoat->GetName() );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00075), pBoat->GetName() );
			return;
		}

		DWORD dwReHp = dwMaxHp - (long)pBoat->getAttr( ATTR_HP );
		USHORT sLv = (USHORT)pChar->getAttr( ATTR_LV );
		if( sLv > 10 )
		{
			DWORD dwCharMoney = (long)pChar->getAttr( ATTR_GD );			
			DWORD dwMoney = DWORD(float(dwReHp)*0.05) + sLv * 20;
			//if( !pChar->TakeMoney( "系统", dwMoney ) )
			if( !pChar->TakeMoney( RES_STRING(GM_CHARACTER_CPP_00012), dwMoney ) )
			{
				//SystemNotice( "修理船只%s需要金钱(%d)G，你的金钱(%d)不足.", pBoat->GetName(), dwMoney, dwCharMoney );
				//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00076), pBoat->GetName(), dwMoney, dwCharMoney );
				char szData[128];
				CFormatParameter param(3);
				param.setString( 0, pBoat->GetName() );
				param.setLong( 1, dwMoney );
				param.setLong( 2, dwCharMoney );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00076, param, szData );
				SystemNotice( szData );
				return;
			}
		}
		
		pBoat->m_CChaAttr.ResetChangeFlag();
		pBoat->setAttr( ATTR_HP, dwMaxHp );
		pBoat->SyncBoatAttr( enumATTRSYN_TASK, FALSE );
		//SystemNotice( "船只“%s”修理完毕，恢复耐久%d点!", pBoat->GetName(), dwReHp );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00077), pBoat->GetName(), dwReHp );
		char szData[128] = "";
		CFormatParameter param(2);
		param.setString( 0, pBoat->GetName() );
		param.setLong( 1, dwReHp );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00077, param, szData );
		SystemNotice( szData );
		g_CParser.DoString( "Ship_ExAttrCheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pChar, pBoat, DOSTRING_PARAM_END );
	}
}

void CCharacter::SupplyBoat()
{
	if( GetPlayer() )
	{
		CCharacter* pChar = GetPlayer()->GetMainCha();
		CCharacter* pBoat = GetPlayer()->GetLuanchOut();
		if( pBoat == NULL )
		{
			//SystemNotice( "你的船只还没有出海，快速补给失败!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00078) );
			return;
		}

		DWORD dwMaxSp = (DWORD)pBoat->getAttr( ATTR_MXSP );		
		if( dwMaxSp - pBoat->getAttr( ATTR_SP ) == 0  || dwMaxSp <= (DWORD)pBoat->getAttr( ATTR_SP ) )
		{
			//SystemNotice( "船只%s给养充足!", pBoat->GetName() );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00079), pBoat->GetName() );
			return;
		}

		DWORD dwReSp = dwMaxSp - (long)pBoat->getAttr( ATTR_SP );
		USHORT sLv = (USHORT)pChar->getAttr( ATTR_LV );
		if( sLv > 10 )
		{
			DWORD dwCharMoney = (long)pChar->getAttr( ATTR_GD );
			DWORD dwMoney = dwReSp + sLv * 20;
			//if( !pChar->TakeMoney( "系统", dwMoney ) )
			if( !pChar->TakeMoney( RES_STRING(GM_CHARACTER_CPP_00012), dwMoney ) )
			{
				//SystemNotice( "补给船只%s需要金钱(%d)G，你的金钱(%d)不足.", pBoat->GetName(), dwMoney, dwCharMoney );
				//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00080), pBoat->GetName(), dwMoney, dwCharMoney );
				char szData[128] = "";
				CFormatParameter param(3);
				param.setString( 0, pBoat->GetName() );
				param.setLong( 1, dwMoney );
				param.setLong( 2, dwCharMoney );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00080, param, szData );
				SystemNotice( szData );
				return;
			}
		}

		pBoat->m_CChaAttr.ResetChangeFlag();
		pBoat->setAttr( ATTR_SP, dwMaxSp );
		pBoat->SyncBoatAttr( enumATTRSYN_TASK, FALSE );
		//SystemNotice( "船只“%s”补给完毕，补充给养%d点!", pBoat->GetName(), dwReSp );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00081), pBoat->GetName(), dwReSp );
		char szData[128] = "";
		CFormatParameter param(2);
		param.setString( 0, pBoat->GetName() );
		param.setLong( 1, dwReSp );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00081, param, szData );
		SystemNotice( szData );

		// 重设船只属性
		g_CParser.DoString( "Ship_ExAttrCheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, GetPlayer()->GetMainCha(), pBoat, DOSTRING_PARAM_END );
	}
}

BOOL CCharacter::BoatSelected( BYTE byType, BYTE byIndex )
{
	if( !GetPlayer() ) {
		return FALSE;
	}

	// 判断是否在交易状态
	if( GetTradeData() )
	{
		//SystemNotice( "你正在和其他角色交易，不可以和npc对话!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00082) );
		return FALSE;
	}

	// 设置角色出海数据信息
	USHORT sBerthID, sxPos, syPos, sDir;
	GetPlayer()->GetBerth( sBerthID, sxPos, syPos, sDir );
	CCharacter* pChar = GetPlayer()->GetMainCha();

	if( byType == mission::BERTH_REPAIR_LIST )
	{
		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "BoatSelected:你没有停泊在该港口的修理船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00083) );
			return TRUE;
		}
		
		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatSelected:选择修理船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00064), byIndex );
			return FALSE;
		}

		CCharacter* pBoat = GetPlayer()->GetBoat( Data.byID[byIndex] );
		if( !pBoat )
		{
			//SystemNotice( "BoatSelected:选择修理船只ID[%d]指针错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00084), byIndex );
			return FALSE;
		}

		DWORD dwMaxHp = (DWORD)pBoat->getAttr( ATTR_MXHP );		
		if( dwMaxHp - pBoat->getAttr( ATTR_HP ) == 0 || dwMaxHp <= (DWORD)pBoat->getAttr( ATTR_HP ) )
		{
			//SystemNotice( "船只%s状况很好，不需要修理.", pBoat->GetName() );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00075), pBoat->GetName() );
			return TRUE;
		}

		DWORD dwReHp = dwMaxHp - (long)pBoat->getAttr( ATTR_HP );
		USHORT sLv = (USHORT)pChar->getAttr( ATTR_LV );
		if( sLv > 10 )
		{
			DWORD dwCharMoney = (long)pChar->getAttr( ATTR_GD );			
			DWORD dwMoney = DWORD(float(dwReHp)*0.05) + sLv * 20;
			//if( !pChar->TakeMoney( "系统", dwMoney ) )
			if( !pChar->TakeMoney( RES_STRING(GM_CHARACTER_CPP_00012), dwMoney ) )
			{
				//SystemNotice( "修理船只%s需要金钱(%d)G，你的金钱(%d)不足.", pBoat->GetName(), dwMoney, dwCharMoney );
				//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00076), pBoat->GetName(), dwMoney, dwCharMoney );
				char szData[128];
				CFormatParameter param(3);
				param.setString( 0, pBoat->GetName() );
				param.setLong( 1, dwMoney );
				param.setLong( 2, dwCharMoney );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00076, param, szData );
				SystemNotice( szData );
				return TRUE;
			}
		}
		
		pBoat->m_CChaAttr.ResetChangeFlag();
		pBoat->setAttr( ATTR_HP, dwMaxHp );
		pBoat->SyncBoatAttr( enumATTRSYN_TASK, FALSE );
		//SystemNotice( "船只“%s”修理完毕，恢复耐久%d点!", pBoat->GetName(), dwReHp );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00077), pBoat->GetName(), dwReHp );
		char szData[128] = "";
		CFormatParameter param(2);
		param.setString( 0, pBoat->GetName() );
		param.setLong( 1, dwReHp );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00077, param, szData );
		SystemNotice( szData );
		g_CParser.DoString( "Ship_ExAttrCheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pChar, pBoat, DOSTRING_PARAM_END );
	}
	else if( byType == mission::BERTH_SALVAGE_LIST )
	{
		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetDeadBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "BoatSelected:你没有停泊在该港口的沉没船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00085) );
			return TRUE;
		}

		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatSelected:选择打捞沉没船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00086), byIndex );
			return FALSE;
		}

		CCharacter* pBoat = GetPlayer()->GetBoat( Data.byID[byIndex] );
		if( !pBoat )
		{
			//SystemNotice( "BoatSelected:选择打捞沉没船只ID[%d]指针错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00087), byIndex );
			return FALSE;
		}
		
		DWORD dwCharMoney = (long)pChar->getAttr( ATTR_GD );
		DWORD dwMoney = 1000;
		//if( !pChar->TakeMoney( "系统", dwMoney ) )
		if( !pChar->TakeMoney( RES_STRING(GM_CHARACTER_CPP_00012), dwMoney ) )
		{
			//SystemNotice( "打捞船只%s需要金钱(%d)G，你的金钱(%d)不足.", pBoat->GetName(), dwMoney, dwCharMoney );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00088), pBoat->GetName(), dwMoney, dwCharMoney );
			char szData[128];
			CFormatParameter param(3);
			param.setString( 0, pBoat->GetName() );
			param.setLong( 1, dwMoney );
			param.setLong( 2, dwCharMoney );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00088, param, szData );
			SystemNotice( szData );
			return FALSE;
		}

		pBoat->setAttr( ATTR_BOAT_ISDEAD, 0 );
		if( !game_db.SaveBoatTempData( *pBoat ) )
		{
			//SystemNotice( "BoatSelected:打捞船只存取数据库操作失败!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00089) );
			//LG( "boat_error", "BoatSelected:打捞船只存取数据库操作失败!" );
			LG( "boat_error", "BoatSelected:salve boat deposit data operator failed!" );
		}
		else
		{
			//SystemNotice( "船只“%s”已被成功打捞!", pBoat->GetName() );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00090), pBoat->GetName() );
		}
		g_CParser.DoString( "Ship_ExAttrCheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pChar, pBoat, DOSTRING_PARAM_END );
	}
	else if( byType == mission::BERTH_SUPPLY_LIST )
	{
		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "BoatSelected:你没有停泊在该港口的补给船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00091) );
			return TRUE;
		}

		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatSelected:选择补给船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00092), byIndex );
			return FALSE;
		}

		CCharacter* pBoat = GetPlayer()->GetBoat( Data.byID[byIndex] );
		if( !pBoat )
		{
			//SystemNotice( "BoatSelected:选择补给船只ID[%d]指针错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00093), byIndex );
			return FALSE;
		}
		
		DWORD dwMaxSp = (DWORD)pBoat->getAttr( ATTR_MXSP );		
		if( dwMaxSp - pBoat->getAttr( ATTR_SP ) == 0  || dwMaxSp <= (DWORD)pBoat->getAttr( ATTR_SP ))
		{
			//SystemNotice( "船只%s给养充足!", pBoat->GetName() );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00079), pBoat->GetName() );
			return TRUE;
		}

		DWORD dwReSp = dwMaxSp - (long)pBoat->getAttr( ATTR_SP );
		USHORT sLv = (USHORT)pChar->getAttr( ATTR_LV );
		if( sLv > 10 )
		{
			DWORD dwCharMoney = (long)pChar->getAttr( ATTR_GD );
			DWORD dwMoney = dwReSp + sLv * 20;
			//if( !pChar->TakeMoney( "系统", dwMoney ) )
			if( !pChar->TakeMoney( RES_STRING(GM_CHARACTER_CPP_00012), dwMoney ) )
			{
				//SystemNotice( "补给船只%s需要金钱%dG，你的金钱(%d)不足.", pBoat->GetName(), dwMoney, dwCharMoney );
				//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00080), pBoat->GetName(), dwMoney, dwCharMoney );
				char szData[128] = "";
				CFormatParameter param(3);
				param.setString( 0, pBoat->GetName() );
				param.setLong( 1, dwMoney );
				param.setLong( 2, dwCharMoney );
				RES_FORMAT_STRING( GM_CHARACTER_CPP_00080, param, szData );
				SystemNotice( szData );
				return TRUE;
			}
		}
		
		pBoat->m_CChaAttr.ResetChangeFlag();
		pBoat->setAttr( ATTR_SP, dwMaxSp );
		pBoat->SyncBoatAttr( enumATTRSYN_TASK, FALSE );
		//SystemNotice( "船只“%s”补给完毕，补充给养%d点!", pBoat->GetName(), dwReSp );
		//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00081), pBoat->GetName(), dwReSp );
		char szData[128] = "";
		CFormatParameter param(2);
		param.setString( 0, pBoat->GetName() );
		param.setLong( 1, dwReSp );
		RES_FORMAT_STRING( GM_CHARACTER_CPP_00081, param, szData );
		SystemNotice( szData );
		g_CParser.DoString( "Ship_ExAttrCheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, pChar, pBoat, DOSTRING_PARAM_END );
	}
	else if( byType == mission::BERTH_BOATLEVEL_LIST )
	{
		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "BoatSelected:你没有停泊在该港口的补给船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00091) );
			return TRUE;
		}

		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatSelected:选择补给船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00092), byIndex );
			return FALSE;
		}

		CCharacter* pBoat = GetPlayer()->GetBoat( Data.byID[byIndex] );
		if( !pBoat )
		{
			//SystemNotice( "BoatSelected:选择补给船只ID[%d]指针错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00093), byIndex );
			return FALSE;
		}

		// 船只升级函数调用
		lua_getglobal( g_pLuaState, "BoatLevelUp" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "BoatLevelUp" );
			return FALSE;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)this );
		lua_pushlightuserdata( g_pLuaState, (void*)pBoat );
		lua_pushnumber( g_pLuaState, (long)pBoat->getAttr( ATTR_LV ) + 1 );
		//int nStatus = lua_pcall( g_pLuaState, 3, 1, 0 );
		int nStatus = CParser::docall(g_pLuaState, 3, 0);
		if( nStatus )
		{
			//SystemNotice( "角色[%s]的脚本船只升级处理函数[BoatLevelUp]调用失败!", m_name );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00094), m_name );
			lua_settop(g_pLuaState, 0);
			return FALSE;
		}

		DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
		lua_settop(g_pLuaState, 0);
		if( dwResult != LUA_TRUE )
		{
			//SystemNotice( "角色[%s]的脚本船只升级处理函数[BoatLevelUp]返回失败!", m_name );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00095), m_name );
			return FALSE;
		}

		return TRUE;
	}
	else
	{
		//SystemNotice( "BoatSelected:船只选择错误的类型Type[%d]", byType );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00096), byType );
		return FALSE;
	}
	
	return TRUE;
}

BOOL CCharacter::BoatBerthList( DWORD dwNpcID, BYTE byType, USHORT sBerthID, USHORT sxPos, USHORT syPos, USHORT sDir )
{
	if( GetPlayer() )
	{
		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		if( byType == mission::BERTH_SALVAGE_LIST )
		{
			GetPlayer()->GetDeadBerthBoat( sBerthID, byNumBoat, Data );
		}
		else if( byType == mission::BERTH_LUANCH_LIST )
		{
			GetPlayer()->GetAllBerthBoat( sBerthID, byNumBoat, Data );
		}
		else
		{
			GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		}
		if( byNumBoat == 0 )
		{
			//SystemNotice( "你没有停泊在该港口的船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00072) );
			return TRUE;
		}

		// 设置角色出海数据信息
		GetPlayer()->SetBerth( sBerthID, sxPos, syPos, sDir );

		WPACKET packet = GETWPACKET();
		WRITE_CMD( packet, CMD_MC_BERTH_LIST );
		WRITE_LONG( packet, dwNpcID );
		WRITE_CHAR( packet, byType );
		WRITE_CHAR( packet, byNumBoat );

		for( BYTE i = 0;i < byNumBoat; i++ )
		{
			WRITE_STRING( packet, Data.szName[i] );
		}

		ReflectINFof( this, packet );
		return TRUE;
	}

	return FALSE;
}

BOOL CCharacter::BoatAdd( CCharacter& Boat )
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BOAT_ADD );
	WRITE_LONG( packet, Boat.GetID() );

	ReflectINFof( this, packet );
	return TRUE;
}

BOOL CCharacter::BoatClear( CCharacter& Boat )
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BOAT_CLEAR );
	WRITE_LONG( packet, Boat.GetID() );

	ReflectINFof( this, packet );

	return TRUE;
}

BOOL CCharacter::BoatAdd( DWORD dwDBID )
{
	if( GetPlayer()->GetBoat( dwDBID ) )
		return FALSE;
	if( g_CharBoat.CreateBoat( *this, dwDBID, 2 ) )
	{
		CCharacter* pBoat = GetPlayer()->GetBoat( dwDBID );
		if( pBoat )
		{
			g_CParser.DoString("Ship_Tran", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 2, this, pBoat, DOSTRING_PARAM_END);
		}
		return TRUE;
	}
	return FALSE;
}

BOOL CCharacter::BoatClear( DWORD dwDBID )
{
	if( GetPlayer() )
	{
		if( GetPlayer()->GetLuanchID() == dwDBID )
			return FALSE;
		return GetPlayer()->ClearBoat( dwDBID );
	}
	return FALSE;
}

BOOL CCharacter::BoatPackBagList( USHORT sBerthID, BYTE byType, BYTE byLevel )
{
	if( GetPlayer() )
	{
		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "你没有停泊在该港口的船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00072) );
			return TRUE;
		}

		// 设置角色出海数据信息
		GetPlayer()->SetBerth( sBerthID, byType, byLevel, 0 );

		WPACKET packet = GETWPACKET();
		WRITE_CMD( packet, CMD_MC_BERTH_LIST );
		WRITE_LONG( packet, 0 );
		WRITE_CHAR( packet, mission::BERTH_BAG_LIST );
		WRITE_CHAR( packet, byNumBoat );

		for( BYTE i = 0;i < byNumBoat; i++ )
		{
			WRITE_STRING( packet, Data.szName[i] );
		}

		ReflectINFof( this, packet );
		return TRUE;
	}

	return FALSE;
}

BOOL CCharacter::PackBag( CCharacter& Boat, USHORT sItemID, USHORT sCount, USHORT sPileID, USHORT& sNumPack )
{
	USHORT sTemp = Boat.GetKitbag()->GetCapacity() - Boat.GetKitbag()->GetUseGridNum();
	if( sTemp == 0 )
	{
		sNumPack = 0;
		//SystemNotice( "船只%s货舱已满!", Boat.GetName() );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00097), Boat.GetName() );
		return TRUE;
	}

	struct GRID_DATA
	{
		BYTE byIndex;
		USHORT sNum;
	};
	GRID_DATA Data[100];
	memset( &Data, 0, sizeof(GRID_DATA)*100 );

	USHORT sGridID = 0;
	USHORT sNumItem = 0;
	USHORT sNumGird = GetKitbag()->GetUseGridNum();
	for( int i = 0; i < sNumGird; i++ )
	{
		SItemGrid *pGridCont = GetKitbag()->GetGridContByNum( i );
		if( pGridCont && pGridCont->sID == sItemID )
		{
			sNumItem += pGridCont->sNum;
			Data[sGridID].byIndex = (BYTE)GetKitbag()->GetPosIDByNum( i );
			Data[sGridID].sNum = pGridCont->sNum;
			if( ++sGridID >= 100 )
			{
				break;
			}
		}
	}

	GetKitbag()->SetChangeFlag( false );
	Boat.GetKitbag()->SetChangeFlag( false );

	USHORT sStartGrid = 0;
	sNumPack = sNumItem/sCount;	
	if( sNumPack > sTemp ) 
	{
		sNumPack = sTemp;
	}
	if( sNumPack == 0 )
	{
		//SystemNotice( "物品数量不够打包!" );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00098) );
		return TRUE;
	}

	for( int i = 0; i < sNumPack && !Boat.GetKitbag()->IsFull(); i++ )
	{
		USHORT sNum = sCount;
		for( int n = sStartGrid; n < sGridID; n++ )
		{
			SItemGrid g;
			if( Data[n].sNum >= sNum )
			{
				// 打包一个堆
				g.sNum = sNum;
				if( KbPopItem( true, false, &g, Data[n].byIndex ) != enumKBACT_SUCCESS )
				{
					//SystemNotice( "错误：打包提取物品栏位ID[%d]的%d个物品失败!" );
					//SystemNotice( "错误：打包提取物品失败!" );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00099) );
					return FALSE;
				}
				//if( !Boat.AddItem( sPileID, 1, "系统" ) )
				if( !Boat.AddItem( sPileID, 1, RES_STRING(GM_CHARACTER_CPP_00012) ) )
				{
					//SystemNotice( "错误：系统给你%d打包物品失败!ID[%d]", 1, sPileID );
					//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00100), 1, sPileID );
					char szData[128];
					CFormatParameter param(2);
					param.setString( 0, "1");
					param.setDouble( 1, sPileID );
					RES_FORMAT_STRING( GM_CHARACTER_CPP_00100, param, szData );
					SystemNotice( szData );
					return FALSE;
				}
				Data[n].sNum -= sNum;
				if( Data[n].sNum == 0 ) 
				{
					sStartGrid = n + 1;
				}
				else
				{
					sStartGrid = n;
				}
				break;
			}
			else
			{
				g.sNum = Data[n].sNum;
				if( KbPopItem( true, false, &g, Data[n].byIndex ) != enumKBACT_SUCCESS )
				{
					//SystemNotice( "错误：打包提取物品栏位ID[%d]的%d个物品失败!" );
					//SystemNotice( "错误：打包提取物品失败!" );
					SystemNotice( RES_STRING(GM_CHARACTER_CPP_00099) );
					return FALSE;
				}
				sNum -= Data[n].sNum;
				Data[n].sNum = 0;
				sStartGrid = n;
			}
		}
	}

	SynKitbagNew( enumSYN_KITBAG_SYSTEM );
	Boat.SynKitbagNew( enumSYN_KITBAG_SYSTEM );
	return TRUE;
}

BOOL CCharacter::PackBag( CCharacter& boat, BYTE byType, BYTE byLevel )
{
	// 调用脚本货物打包处理函数
	lua_getglobal( g_pLuaState, "PackBagGoods" );
	if( !lua_isfunction( g_pLuaState, -1 ) )
	{
		lua_pop( g_pLuaState, 1 );
		LG( "lua_invalidfunc", "PackBagGoods" );
		return FALSE;
	}

	lua_pushlightuserdata( g_pLuaState, (void*)this );
	lua_pushlightuserdata( g_pLuaState, (void*)&boat );
	lua_pushnumber( g_pLuaState, byType );
	lua_pushnumber( g_pLuaState, byLevel );
	//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
	int nStatus = CParser::docall(g_pLuaState, 4, 0);
	if( nStatus )
	{
		//SystemNotice( "角色[%s]的脚本打包处理函数[PackBagGoods]调用失败!", m_name );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00101), m_name );
		lua_callalert( g_pLuaState, nStatus );
		lua_settop(g_pLuaState, 0);
		return FALSE;
	}

	DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
	lua_settop(g_pLuaState, 0);
	if( dwResult != LUA_TRUE )
	{
		//SystemNotice( "角色[%s]的脚本打包处理函数[PackBagGoods]返回失败!", m_name );
		SystemNotice( RES_STRING(GM_CHARACTER_CPP_00102), m_name );
		return FALSE;
	}

	return TRUE;
}

BOOL CCharacter::BoatPackBag( BYTE byIndex )
{
	if( GetPlayer() )
	{
        if(GetPlyMainCha()->GetKitbag()->IsPwdLocked())
        {
            //GetPlyMainCha()->SystemNotice( "道具栏已锁定!" );
			GetPlyMainCha()->SystemNotice( RES_STRING(GM_CHARACTER_CPP_00002) );
			return FALSE;
        }
        
		// 设置角色出海数据信息
		USHORT sBerthID, sType, sLevel, sDir;
		GetPlayer()->GetBerth( sBerthID, sType, sLevel, sDir );

		BOAT_BERTH_DATA Data;
		memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
		BYTE byNumBoat;
		GetPlayer()->GetBerthBoat( sBerthID, byNumBoat, Data );
		if( byNumBoat == 0 )
		{
			//SystemNotice( "你没有停泊在该港口的可以打包物品的船只!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00103) );
			return TRUE;
		}

		if( byIndex >= byNumBoat )
		{
			//SystemNotice( "BoatPackBag:选择出海船只ID[%d]错误!", byIndex );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00104), byIndex );
			return FALSE;
		}

		// 打包货舱		
		if( m_pCPlayer->IsLuanchOut() )
		{
			//SystemNotice( "你的船只已经出海了!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00067) );
			return FALSE;
		}

		CCharacter* pBoat = GetPlayer()->GetBoat( Data.byID[byIndex] );
		if( !pBoat )
		{
			return FALSE;
		}

		if( pBoat->GetKitbag()->IsFull() )
		{
			//SystemNotice( "你选择的船只货舱已满，请选择其他船只打包!" );
			SystemNotice( RES_STRING(GM_CHARACTER_CPP_00105) );
			return FALSE;
		}

		return PackBag( *pBoat, (BYTE)sType, (BYTE)sLevel );
	}
	return TRUE;
}

void CCharacter::SetGuildName(dbc::cChar *szGuildName) 
{
	if (GetPlayer())
	{
		//strncpy(GetPlayer()->m_szGuildName, szGuildName, defGUILD_NAME_LEN - 1);
		strncpy_s( GetPlayer()->m_szGuildName, sizeof(GetPlayer()->m_szGuildName), szGuildName, _TRUNCATE );
		GetPlayer()->m_szGuildName[defGUILD_NAME_LEN - 1] = '\0';
	}
}

dbc::cChar*	CCharacter::GetGuildName(void) 
{
	if (GetPlayer())
		return GetPlayer()->m_szGuildName;
	else
		return "";
}

dbc::cChar*	CCharacter::GetValidGuildName(void) 
{
	if (GetPlayer() && GetGuildState() == emGldMembStatNormal)
		return GetPlayer()->m_szGuildName;
	else
		return "";
}

void CCharacter::SetGuildMotto(dbc::cChar *szGuildMotto) 
{
	if (GetPlayer())
	{
		//strncpy(GetPlayer()->m_szGuildMotto, szGuildMotto, defGUILD_MOTTO_LEN - 1);
		strncpy_s( GetPlayer()->m_szGuildMotto, sizeof(GetPlayer()->m_szGuildMotto), szGuildMotto, _TRUNCATE );
		GetPlayer()->m_szGuildMotto[defGUILD_MOTTO_LEN - 1] = '\0';
	}
}

dbc::cChar*	CCharacter::GetGuildMotto(void) 
{
	if (GetPlayer())
		return GetPlayer()->m_szGuildMotto;
	else
		return "";
}

void CCharacter::SetStallName(dbc::cChar *szStallName) 
{
	if (GetPlayer())
	{
		//strncpy(GetPlayer()->m_szStallName, szStallName, ROLE_MAXNUM_STALL_NUM - 1);
		strncpy_s( GetPlayer()->m_szStallName, sizeof(GetPlayer()->m_szStallName), szStallName, _TRUNCATE );
		GetPlayer()->m_szStallName[ROLE_MAXNUM_STALL_NUM -1] = '\0';
	}
}

dbc::cChar*	CCharacter::GetStallName(void) 
{
	if (GetPlayer())
		return GetPlayer()->m_szStallName;
	else
		return "";
}

dbc::cChar*	CCharacter::GetValidGuildMotto(void) 
{
	if (GetPlayer() && GetGuildState() == emGldMembStatNormal)
		return GetPlayer()->m_szGuildMotto;
	else
		return "";
}

void CCharacter::SetGuildID( DWORD dwGuildID )
{
	if (GetPlayer())
		GetPlayer()->m_lGuildID = dwGuildID;
}

DWORD CCharacter::GetGuildID()
{
	if (GetPlayer())
		return GetPlayer()->m_lGuildID;
	else
		return 0;
}
DWORD CCharacter::GetValidGuildID()
{
	if (GetPlayer())
	{
		if (GetGuildState() == emGldMembStatNormal)
			return GetPlayer()->m_lGuildID;
		else
			return 0;
	}
	else
		return 0;
}
void CCharacter::SetGuildType( BYTE byType )
{
	GetPlayer()->m_cGuildType = byType;
}

BYTE CCharacter::GetGuildType()
{
	if( GetPlayer() && GetGuildState() == emGldMembStatNormal )
	{
		return GetPlayer()->m_cGuildType;
	}
	return 0;
}

void CCharacter::SetGuildState( uLong lState )
{
	GetPlayer()->m_GuildStatus = lState;
}

uLong CCharacter::GetGuildState()
{
	return GetPlayer()->m_GuildStatus;
}

void CCharacter::SyncGuildInfo()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_GUILD_INFO );
	WRITE_LONG( packet, this->GetID() );
	WRITE_LONG( packet, this->GetPlayer()->m_lGuildID );
	WRITE_STRING( packet, this->GetGuildName() );
	WRITE_STRING( packet, this->GetGuildMotto() );
	this->NotiChgToEyeshot( packet );
}

void CCharacter::SynStallName()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_STALL_NAME );
	WRITE_LONG( packet, GetID() );
	WRITE_STRING( packet, GetStallName() );
	NotiChgToEyeshot( packet );
}

void CCharacter::SynBeginItemRepair()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_REPAIR );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemForge()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_FORGE );
	ReflectINFof(this, packet);
}


//Add by sunny.sun 20090311
void CCharacter::SynBeginGetDisTime()
{
	int distime = 0;
	if( GetPlayer() )
	{
		game_db.CalculateDisTime( this, distime );
	}
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_LEAVE_TIME_ASR );
	WRITE_LONG( packet, distime );
	ReflectINFof(this, packet);	
}

//Add by sunny.sun 20090401
void CCharacter::SynBeginItemJewelryUp()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_JEWELRYUP );
	ReflectINFof(this, packet);
}
//End

#ifdef SHUI_JING
void CCharacter::SynGetCrystalState()
{
	DWORD dwNum[2];//挂单的个数
	memset( dwNum,0,sizeof( dwNum ));
	DWORD dwPrice[2];//挂单价格
	memset( dwNum,0,sizeof( dwPrice ));
	DWORD dwtotalnum[2];//原单个数
	memset( dwNum,0,sizeof( dwtotalnum ));
	CrystalTradeType::TradeState istate[2];//挂单状态
	memset( istate,0,sizeof( istate ));
	if( GetPlayer() )
	{
		WPACKET packet = GETWPACKET();
		WRITE_CMD( packet, CMD_MC_GET_CRYSTALSTATE );
		//查询买卖单的状态
		bool flagbuy = game_db.GetCrystalState( this, CrystalTradeType::enumbuy, istate[0], dwNum[0], dwPrice[0], dwtotalnum[0] );
		bool flagsale = game_db.GetCrystalState( this, CrystalTradeType::enumsale, istate[1], dwNum[1], dwPrice[1], dwtotalnum[1] );
		//没有则不做
		if( !flagbuy && !flagsale )
			return;
		//类型0，存在买单，不存在卖单
		if( flagbuy&& !flagsale )
		{
			WRITE_CHAR( packet, 0 );//类型0
			WRITE_SHORT( packet, istate[0] );//买单状态
			switch( istate[0] )
			{
			case CrystalTradeType::enumstop:
			case CrystalTradeType::enumend://单子停掉和交易结束发送消息相同
				  {
					  WRITE_LONGLONG( packet, dwNum[0] );
					  WRITE_LONGLONG( packet, dwPrice[0] );
					  ReflectINFof(this, packet);					  
					  break;
				  }
			case CrystalTradeType::enumhang://单子挂者，判断是否交易了部分
				  {	
					  if( dwtotalnum[0] - dwNum[0] > 0 )
					  {		
						  WRITE_CHAR( packet, 'T' );//交易了部分
						  WRITE_LONGLONG( packet, dwNum[0] );
						  WRITE_LONGLONG( packet, dwPrice[0] );
						  WRITE_LONGLONG( packet, dwtotalnum[0] );
						  game_db.ResetCrystalTotalNum( this, dwNum[0], CrystalTradeType::enumbuy );
					  }
					  else
					  {
						  WRITE_CHAR( packet, 'N' );//没有交易
					  }
					  ReflectINFof(this, packet);					  
					  break;
				  }
			default:
				{
					break;
				}
			}
		}
		//类型1，不存在买单，存在卖单
		else if( !flagbuy && flagsale )
		{
			WRITE_CHAR( packet, 1 );
			WRITE_SHORT( packet, istate[1] );
			switch( istate[1] )
			{
			case CrystalTradeType::enumstop:
			case CrystalTradeType::enumend:
				  {
					  WRITE_LONGLONG( packet, dwNum[1] );
					  WRITE_LONGLONG( packet, dwPrice[1] );
					  ReflectINFof(this, packet);					  
					  break;
				  }
			case CrystalTradeType::enumhang:
				  {	
					  if( dwtotalnum[1] - dwNum[1] > 0 )
					  {
						  WRITE_CHAR( packet, 'T' );
						  WRITE_LONGLONG( packet, dwNum[1] );
						  WRITE_LONGLONG( packet, dwPrice[1] );
						  WRITE_LONGLONG( packet, dwtotalnum[1] );
						  game_db.ResetCrystalTotalNum( this, dwNum[1], CrystalTradeType::enumsale );
					  }
					  else
					  {
						  WRITE_CHAR( packet, 'N' );
					  }
					  ReflectINFof(this, packet);					  
					  break;
				  }
			default:
				{
					break;
				}
			}
		}
		//类型2，存在买单也存在卖单
		else
		{
			WRITE_CHAR( packet, 2 );
			WRITE_SHORT( packet, istate[0] );//买单状态
			WRITE_SHORT( packet, istate[1] );//卖单状态
			//停掉和交易成功相同
			if( istate[0] == CrystalTradeType::enumstop || istate[0] == CrystalTradeType::enumend )
			{
				WRITE_LONGLONG( packet, dwNum[0] );
				WRITE_LONGLONG( packet, dwPrice[0] );
				//判断卖单状态
				switch( istate[1] )
				{
				case CrystalTradeType::enumstop:
				case CrystalTradeType::enumend:
					  {
						  WRITE_LONGLONG( packet, dwNum[1] );
						  WRITE_LONGLONG( packet, dwPrice[1] );
						  ReflectINFof(this, packet);					  
						  break;
					  }
				case CrystalTradeType::enumhang:
					  {
						  if( dwtotalnum[1] - dwNum[1] > 0 )
						  {
							  WRITE_CHAR( packet, 'T' );
							  WRITE_LONGLONG( packet, dwNum[1] );
							  WRITE_LONGLONG( packet, dwPrice[1] );
							  WRITE_LONGLONG( packet, dwtotalnum[1] );
							  game_db.ResetCrystalTotalNum( this, dwNum[1], CrystalTradeType::enumsale );
						  }
						  else
						  {
							  WRITE_CHAR( packet, 'N' );
						  }
						  ReflectINFof(this, packet);					  
						  break;
					  }
				default:
					{
						ReflectINFof(this, packet);					  
						break;
					}
				}
			}
			//买单挂者
			else if ( istate[0] == CrystalTradeType::enumhang )
			{
				//买单是否交易了部分
				if( dwtotalnum[0] - dwNum[0] > 0 )
				{
					WRITE_CHAR( packet, 'T' );
					WRITE_LONGLONG( packet, dwNum[0] );
					WRITE_LONGLONG( packet, dwPrice[0] );
					WRITE_LONGLONG( packet, dwtotalnum[0] );
					game_db.ResetCrystalTotalNum( this, dwNum[0], CrystalTradeType::enumbuy );
				}
				else
				{
					WRITE_CHAR( packet, 'N' );
				}
				switch( istate[1] )
				{
				case CrystalTradeType::enumstop:
				case CrystalTradeType::enumend:
					  {
						  WRITE_LONGLONG( packet, dwNum[1] );
						  WRITE_LONGLONG( packet, dwPrice[1] );
						  ReflectINFof(this, packet);					  
						  break;
					  }
				case CrystalTradeType::enumhang:
					  {	
						  if( dwtotalnum[1] - dwNum[1] > 0 )
						  {
							  WRITE_CHAR( packet, 'T' );
							  WRITE_LONGLONG( packet, dwNum[1] );
							  WRITE_LONGLONG( packet, dwPrice[1] );
							  WRITE_LONGLONG( packet, dwtotalnum[1] );
							  game_db.ResetCrystalTotalNum( this, dwNum[1], CrystalTradeType::enumsale );
						  }
						  else
						  {
							  WRITE_CHAR( packet, 'N' );
						  }
						  ReflectINFof(this, packet);					  
						  break;
					  }
				default:
					{
						break;
					}

				}
			}
			//买单是开始，卖单状态
			else if( istate[0] == CrystalTradeType::enumstart )
			{
				//判断卖单状态
				switch( istate[1] )
				{
				case CrystalTradeType::enumstop:
				case CrystalTradeType::enumend:
					  {
						  WRITE_LONGLONG( packet, dwNum[1] );
						  WRITE_LONGLONG( packet, dwPrice[1] );
						  ReflectINFof(this, packet);					  
						  break;
					  }
				case CrystalTradeType::enumhang:
					  {
						  if( dwtotalnum[1] - dwNum[1] > 0 )
						  {
							  WRITE_CHAR( packet, 'T' );
							  WRITE_LONGLONG( packet, dwNum[1] );
							  WRITE_LONGLONG( packet, dwPrice[1] );
							  WRITE_LONGLONG( packet, dwtotalnum[1] );
							  game_db.ResetCrystalTotalNum( this, dwNum[1], CrystalTradeType::enumsale );
						  }
						  else
						  {
							  WRITE_CHAR( packet, 'N' );
						  }
						  ReflectINFof(this, packet);					  
						  break;
					  }
				default:
					{
						break;
					}
				}
			
			}
		}
	}
}
#endif
void CCharacter::SynBeginItemUnite()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_UNITE );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemMilling()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_MILLING );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemFusion()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_FUSION );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemUpgrade()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_UPGRADE );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemEidolonMetempsychosis()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_EIDOLON_METEMPSYCHOSIS );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemEidolonFusion()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_EIDOLON_FUSION );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemPurify()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_PURIFY );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginItemFix()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_FIX );
	ReflectINFof(this, packet);
} 

void CCharacter::SynBeginItemEnergy()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_ITEM_ENERGY );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginGMSend()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_GM_SEND );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginGMRecv(DWORD dwNpcID)
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_GM_RECV );
	WRITE_LONG(packet, dwNpcID);
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginGetStone()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_GET_STONE );
	ReflectINFof(this, packet);
}

void CCharacter::SynBeginTiger()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD( packet, CMD_MC_BEGIN_TIGER );
	ReflectINFof(this, packet);
}

void CCharacter::SynAppendLook()
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_APPEND_LOOK);
	WRITE_LONG(packet, GetID());
	if (WriteAppendLook(this->GetKitbag(), packet))
		NotiChgToEyeshot(packet);
}

void CCharacter::SynItemUseSuc(Short sItemID)
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_ITEM_USE_SUC);
	WRITE_LONG(packet, GetID());
	WRITE_SHORT(packet, sItemID);
	NotiChgToEyeshot(packet);
}

void CCharacter::SynKitbagCapacity(void)
{
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_KITBAG_CAPACITY);
	WRITE_LONG(packet, GetID());
	WRITE_SHORT(packet, GetKitbag()->GetCapacity());
	ReflectINFof(this, packet);
}

void CCharacter::SynEspeItem(void)
{
	Short	sEspeGridID = 1;
	SItemGrid *pGrid = GetKitbag()->GetGridContByID(sEspeGridID);
	if (pGrid)
	{
		CItemRecord* pItem = GetItemRecordInfo(pGrid->sID);
		if(pItem && pItem->sType == enumItemTypePet) // 宠物道具
			if (GetKitbag()->IsSingleChange(sEspeGridID))
			{
				WPACKET packet = GETWPACKET();
				WRITE_CMD(packet, CMD_MC_ESPE_ITEM);
				WRITE_LONG(packet, GetID());
				WRITE_CHAR(packet, 1);
				WRITE_SHORT(packet, sEspeGridID);
				WRITE_SHORT(packet, pGrid->sEndure[0]);
				WRITE_SHORT(packet, pGrid->sEnergy[0]);
				ReflectINFof(this, packet);
			}
	}
}

void CCharacter::SynVolunteerState(BOOL bState)
{
	if (!GetPlayer())
		return;
	char chState = (bState ? 1 : 0);
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_VOLUNTER_STATE);
	WRITE_CHAR(packet, chState);
	ReflectINFof(this, packet);
}

void CCharacter::SynTigerString(cChar *szString)
{
	if (!GetPlayer())
		return;
	WPACKET packet = GETWPACKET();
	WRITE_CMD(packet, CMD_MC_TIGER_STOP);
	WRITE_STRING(packet, szString);
	ReflectINFof(this, packet);
}

void CCharacter::SyncBoatAttr(Short sSynType, bool bAllBoat)
{
	if (!GetPlayer())
		return;

	if (!bAllBoat) // 只同步自己
	{
		SynAttrToSelf(sSynType);
		return;
	}

	CCharacter*	pBoat;
	BYTE byNumBoat = GetPlayer()->GetNumBoat();
	for (BYTE i = 0; i < byNumBoat; i++)
	{
		pBoat = GetPlayer()->GetBoat( i );
		if( !pBoat ) continue;

		pBoat->SynAttrToSelf(sSynType);
	}
}

void CCharacter::SetBoatAttrChangeFlag(bool bSet)
{
	if (!GetPlayer())
		return;

	BYTE byNumBoat = GetPlayer()->GetNumBoat();

	for (BYTE i = 0; i < byNumBoat; i++)
	{
		CCharacter* pBoat = GetPlayer()->GetBoat( i );
		if( !pBoat ) continue;

		if (bSet)
			pBoat->m_CChaAttr.SetChangeFlag();
		else
			pBoat->m_CChaAttr.ResetChangeFlag();
	}
}

BOOL CCharacter::AddAttr( int nIndex, DWORD dwValue, dbc::Short sNotiType )
{
	m_CChaAttr.ResetChangeFlag();
	setAttr(nIndex, m_CChaAttr.GetAttr( nIndex ) + dwValue);
	SynAttr(sNotiType);
	return TRUE;
}

BOOL CCharacter::TakeAttr( int nIndex, DWORD dwValue, dbc::Short sNotiType )
{
	m_CChaAttr.ResetChangeFlag();
	DWORD dwTemp = ( (DWORD)m_CChaAttr.GetAttr( nIndex ) > dwValue ) ? (long)m_CChaAttr.GetAttr( nIndex ) - dwValue : 0;
	setAttr(nIndex, dwTemp);
	SynAttr(sNotiType);
	return TRUE;
}

void CCharacter::SetBoat( CCharacter* pBoat ) 
{ 
	GetPlayer()->SetMakingBoat( pBoat ); 
}

CCharacter* CCharacter::GetBoat() 
{ 
	return GetPlayer()->GetMakingBoat(); 
}

BOOL CCharacter::ViewItemInfo( RPACKET& pk )
{
	BYTE byType = READ_CHAR( pk );
	if( byType == mission::VIEW_CHAR_BAG )
	{
		Short	sGridID = READ_SHORT(pk);
		CItemRecord* pItem = (CItemRecord*)GetItemRecordInfo( GetKitbag()->GetID( sGridID ) );
		if( pItem == NULL )
		{
			//SystemNotice( "ViewItemInfo::物品ID错误，无法找到该物品信息!ID = %d, grid = %d", GetKitbag()->GetID( sGridID ), sGridID );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00106), GetKitbag()->GetID( sGridID ), sGridID );
			char szData[128];
			CFormatParameter param(2);
			param.setDouble( 0, GetKitbag()->GetID( sGridID ));
			param.setDouble( 1, sGridID );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00106, param, szData );
			SystemNotice( szData );
			return FALSE;
		}

		if( pItem->sType == enumItemTypeBoat )
		{
			return g_CharBoat.GetBoatInfo( *this, GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, sGridID ) );
		}
	}
	else 
	{
		BYTE byIndex = (BYTE)READ_SHORT( pk );
		USHORT sItemID;
		DWORD dwBoatID;
		CCharacter* pOwner = NULL;
		if( byType == mission::VIEW_CHARTRADE_SELF )
		{

			if( this->m_pTradeData )
			{
				if( m_pTradeData->pAccept == this )
				{
					if( m_pTradeData->AcpTradeData.ItemArray[byIndex].sItemID == 0 || 
						!GetKitbag()->HasItem( m_pTradeData->AcpTradeData.ItemArray[byIndex].byIndex ) )
					{
						return FALSE;
					}

					sItemID = GetKitbag()->GetID( m_pTradeData->AcpTradeData.ItemArray[byIndex].byIndex );
					dwBoatID = GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, m_pTradeData->AcpTradeData.ItemArray[byIndex].byIndex );
					pOwner = this;
				}
				else if( m_pTradeData->pRequest == this )
				{
					if( m_pTradeData->ReqTradeData.ItemArray[byIndex].sItemID == 0 || 
						!GetKitbag()->HasItem( m_pTradeData->ReqTradeData.ItemArray[byIndex].byIndex ) )
					{
						return FALSE;
					}

					sItemID = GetKitbag()->GetID( m_pTradeData->ReqTradeData.ItemArray[byIndex].byIndex );
					dwBoatID = GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, m_pTradeData->ReqTradeData.ItemArray[byIndex].byIndex );
					pOwner = this;
				}
				else
				{
					return FALSE;
				}
			}
		}
		else if( byType == mission::VIEW_CHARTRADE_OTHER )
		{
			if( this->m_pTradeData )
			{
				if( m_pTradeData->pAccept == this )
				{
					if( m_pTradeData->ReqTradeData.ItemArray[byIndex].sItemID == 0 || 
						!m_pTradeData->pRequest->GetKitbag()->HasItem( m_pTradeData->ReqTradeData.ItemArray[byIndex].byIndex ) )
					{
						return FALSE;
					}

					sItemID = m_pTradeData->pRequest->GetKitbag()->GetID( m_pTradeData->ReqTradeData.ItemArray[byIndex].byIndex );
					dwBoatID = m_pTradeData->pRequest->GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, m_pTradeData->ReqTradeData.ItemArray[byIndex].byIndex );
					pOwner = m_pTradeData->pRequest;
				}
				else if( m_pTradeData->pRequest == this )
				{
					if( m_pTradeData->AcpTradeData.ItemArray[byIndex].sItemID == 0 || 
						!m_pTradeData->pAccept->GetKitbag()->HasItem( m_pTradeData->AcpTradeData.ItemArray[byIndex].byIndex ) )
					{
						return FALSE;
					}

					sItemID = m_pTradeData->pAccept->GetKitbag()->GetID( m_pTradeData->AcpTradeData.ItemArray[byIndex].byIndex );
					dwBoatID = m_pTradeData->pAccept->GetKitbag()->GetDBParam( enumITEMDBP_INST_ID, m_pTradeData->AcpTradeData.ItemArray[byIndex].byIndex );
					pOwner = m_pTradeData->pAccept;
				}
				else
				{
				}
			}
		}
		else
		{
			return FALSE;
		}

		CItemRecord* pItem = (CItemRecord*)GetItemRecordInfo( sItemID );
		if( pItem == NULL )
		{
			//SystemNotice( "ViewItemInfo:物品ID错误，无法找到该物品信息!Index = %d, ID = %d", byIndex, sItemID );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00107), byIndex, sItemID );
			char szData[128];
			CFormatParameter param(2);
			param.setDouble( 0, byIndex );
			param.setDouble( 1, sItemID );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00107, param, szData );
			SystemNotice( szData );
			return FALSE;
		}

		if( pItem->sType == enumItemTypeBoat )
		{
			return g_CharBoat.GetTradeBoatInfo( *this, *pOwner, dwBoatID );
		}
		else
		{
			//SystemNotice( "viewiteminfo:该物品没有船只信息!Index[%d], ID[%d]", byIndex, sItemID );
			//SystemNotice( RES_STRING(GM_CHARACTER_CPP_00108), byIndex, sItemID );
			char szData[128];
			CFormatParameter param(2);
			param.setDouble( 0, byIndex );
			param.setDouble( 1, sItemID );
			RES_FORMAT_STRING( GM_CHARACTER_CPP_00108, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
	}

	return TRUE;
}

BOOL CCharacter::HasGuild()
{
	return GetGuildID() > 0 && GetGuildState() == emGldMembStatNormal;
}

BOOL CCharacter::IsGuildType( BYTE byType )
{	
	return ( HasGuild() ) ? GetGuildType() == byType : FALSE;
}

void CCharacter::SetStallData( mission::CStallData* pData )
{
	if( GetPlayer() ) GetPlayer()->SetStallData( pData );
}

mission::CStallData* CCharacter::GetStallData()
{
	return GetPlayer() ? GetPlayer()->GetStallData() : NULL;
}

BYTE CCharacter::GetStallNum()
{
	if (!GetActControl(enumACTCONTROL_USE_MSKILL)) // 不能使用摆摊技能
		return 0;

	Char	chLv;

	SSkillGrid	*pSSkillCont = m_CSkillBag.GetSkillContByID(241);
	if (!pSSkillCont)
		chLv = 0;
	else
		chLv = pSSkillCont->chLv;

	return chLv * 6;
}

//add by jilinlee 2007/4/20
//读书
BOOL CCharacter::IsReadBook()
{
	return m_SReadBook.bIsReadState;
}
void CCharacter::SetReadBookState(bool bIsReadBook)
{
	m_SReadBook.bIsReadState = bIsReadBook;
	m_SReadBook.dwLastReadCallTick = 0;
}

//extern char	g_kitbag[];
//extern char g_kitbagTmp[];
void CCharacter::LogAssets(Char chLType)
{
	return;
}

bool CCharacter::SaveAssets(void)
{
	return game_db.SaveChaAssets(this);
}

bool CCharacter::IsRangePoint(dbc::Long lPosX, dbc::Long lPosY, dbc::Long lDist)
{
	Point	CurPos = GetPlyCtrlCha()->GetPos();
	__int64	llErr = 100 * 100;

	__int64	llDistX = lPosX - CurPos.x;
	__int64 llDistY = lPosY - CurPos.y;
	__int64 llDistXY2 = llDistX * llDistX + llDistY * llDistY;
	if (llDistXY2 > (lDist * lDist + llErr))
		return false;

	return true;
}

bool CCharacter::IsRangePoint2(dbc::Long lPosX, dbc::Long lPosY, dbc::Long lDist2)
{
	Point	CurPos = GetPlyCtrlCha()->GetPos();
	__int64	llErr = 0;

	__int64	llDistX = lPosX - CurPos.x;
	__int64 llDistY = lPosY - CurPos.y;
	__int64 llDistXY2 = llDistX * llDistX + llDistY * llDistY;
	if (llDistXY2 > (lDist2 + llErr))
		return false;

	return true;
}

void CCharacter::AddMasterCredit(long lCredit)
{
	unsigned long lMasterID = GetMasterDBID();

	if(lMasterID == 0)
	{
		return;
	}

	CPlayer *pMasterPly = g_pGameApp->GetPlayerByDBID(lMasterID);
	CCharacter *pMaster = NULL;
	if(pMasterPly)
	{
		pMaster = pMasterPly->GetMainCha();
	}

	if(!pMaster)
	{
		//game_db.AddCreditByDBID(lMasterID, lCredit);
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_ADDCREDIT);
		WRITE_LONG(WtPk, GetID());
		WRITE_LONG(WtPk, lMasterID);
		WRITE_LONG(WtPk, lCredit);
		ReflectINFof(this, WtPk);//通告
		return;
	}

	pMaster->SetCredit((long)pMaster->GetCredit() + lCredit);
	pMaster->SynAttr(enumATTRSYN_TASK);

	return;
}

unsigned long CCharacter::GetMasterDBID()
{
	return game_db.GetPlayerMasterDBID(GetPlayer());
}

void CCharacter::InitCheatX()
{
#ifdef SET_CHEAT
	m_sCheatX.dwInterval =  GetCheatInterval(0);
	m_sCheatX.dwLastTime = GetTickCount();
	m_sCheatX.Xerror = 0;
	m_sCheatX.Xnum.clear();
	m_sCheatX.Xtype = 1;
	m_sCheatX.Xright = 0;
	m_sCheatX.Xcount = 0;
	m_sCheatX.Xn = 2;
#endif
}

DWORD CCharacter::GetCheatInterval(int state)
{
#ifdef SET_CHEAT
	#define RAND_IN_NUM(x) (rand() % ((x) + 1))
	const int MS_IN_ONE_MINUTE = 60 * 1000;
	const int MS_IN_ONE_SECOND = 1000;

	DWORD ret = 0;
	
	switch(state)
	{
	case 0://刚上线
		ret = 20 * MS_IN_ONE_SECOND + 100 * RAND_IN_NUM(MS_IN_ONE_SECOND);
		break;
	case 1://回答问题限时
		ret = 65 * MS_IN_ONE_SECOND;
		break;
	case 3://提问间隔
		ret = (m_sCheatX.Xn > 3) ? (40 * MS_IN_ONE_MINUTE) : (60 * RAND_IN_NUM(MS_IN_ONE_SECOND) + 10 * m_sCheatX.Xn * MS_IN_ONE_MINUTE);
		break;
	default:
		ret = 20 * MS_IN_ONE_SECOND + 100 * RAND_IN_NUM(MS_IN_ONE_SECOND);
		break;
	}
	return ret;
#else
	return 0;
#endif
}

void CCharacter::CheatRun(DWORD dwCurTime)
{
#ifdef SET_CHEAT
	if(dwCurTime - m_sCheatX.dwLastTime < m_sCheatX.dwInterval)
	{
		return;
	}

	switch(m_sCheatX.Xtype)
	{
	case 1://答题完成后
		{
			if(GetStallData() || IsStoreEnable())
			{
				if(m_sCheatX.Xcount > 0)
				{
					m_sCheatX.dwInterval = GetCheatInterval(3);
				}
				else
				{
					m_sCheatX.dwInterval = GetCheatInterval(0);
				}
			}
			else
			{
				m_sCheatX.Xtype = 2;
				char buf[5];
				buf[0] = g_pGameApp->m_PicSet->RandGetID();
				buf[1] = g_pGameApp->m_PicSet->RandGetID();
				buf[2] = g_pGameApp->m_PicSet->RandGetID();
				buf[3] = g_pGameApp->m_PicSet->RandGetID();
				buf[4] = '\0';
				m_sCheatX.Xnum = buf;

				WPACKET WtPk = GETWPACKET();
				WRITE_CMD(WtPk, CMD_MC_CHEAT_CHECK);
				WRITE_SHORT(WtPk, 4);
				for(int i = 0; i < 4; i++)
				{
					CPicture *pPic = g_pGameApp->m_PicSet->GetPicture(buf[i]);
					uInt nSize = pPic->GetSize();

					WRITE_SHORT(WtPk, nSize);
					for(int j = 0; (uInt)j < nSize; j++)
					{
						WRITE_CHAR(WtPk, pPic->GetImgByte(j));
					}
				}
				ReflectINFof(this, WtPk);

				m_sCheatX.dwInterval = GetCheatInterval(1);
				m_sCheatX.Xcount++;
			}

			m_sCheatX.dwLastTime = dwCurTime;
		}
		break;

	case 2://提问后
		{
			m_sCheatX.Xn = (m_sCheatX.Xn > 0) ? (m_sCheatX.Xn - 1) : 0;
			m_sCheatX.dwInterval = GetCheatInterval(3);
			m_sCheatX.dwLastTime = dwCurTime;
			m_sCheatX.Xerror++;
			m_sCheatX.Xright = 0;
			m_sCheatX.Xtype = 1;
			m_sCheatX.Xnum.clear();

			if(m_sCheatX.Xerror >= 3)
			{
				CheatConfirm();
			}
			else
			{
				//SystemNotice("你没有答,你还有%d次机会!", 3 - m_sCheatX.Xerror);
				SystemNotice(RES_STRING(GM_CHARACTER_CPP_00115), 3 - m_sCheatX.Xerror);
			}
		}
		break;

	default:
		{
			InitCheatX();
		}
		break;
	}
#endif
}

void CCharacter::CheatCheck(cChar *answer)
{
#ifdef SET_CHEAT
	if(m_sCheatX.Xtype != 2)
		return;

	if(!m_sCheatX.Xnum.empty() && !lstrcmpi(answer, m_sCheatX.Xnum.c_str()))
	{
		m_sCheatX.dwLastTime = GetTickCount();
		m_sCheatX.Xerror = 0;
		m_sCheatX.Xright++;
		m_sCheatX.Xnum.clear();
		m_sCheatX.Xtype = 1;
		m_sCheatX.Xn++;
		m_sCheatX.dwInterval = GetCheatInterval(3);

		if(m_sCheatX.Xcount > 1)
		{
			//奖励
			g_CParser.DoString("WGPrizeBegin", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, enumSCRIPT_PARAM_NUMBER, 1, m_sCheatX.Xright, DOSTRING_PARAM_END);
		}
	}
	else
	{
		m_sCheatX.dwLastTime = GetTickCount();
		m_sCheatX.Xerror++;
		m_sCheatX.Xright = 0;
		m_sCheatX.Xnum.clear();
		m_sCheatX.Xtype = 1;
		m_sCheatX.Xn = (m_sCheatX.Xn > 0) ? (m_sCheatX.Xn - 1) : 0;
		m_sCheatX.dwInterval = GetCheatInterval(3);

		if(m_sCheatX.Xerror >= 3)
		{
			CheatConfirm();
		}
		else
		{
			//SystemNotice("你答错啦,你还有%d次机会!", 3 - m_sCheatX.Xerror);
			SystemNotice(RES_STRING(GM_CHARACTER_CPP_00116), 3 - m_sCheatX.Xerror);
		}
	}
#endif
}

void CCharacter::CheatConfirm()
{
#ifdef SET_CHEAT
	if(IsStoreEnable())
	{
		m_sCheatX.dwLastTime = GetTickCount();
		m_sCheatX.Xright = 0;
		m_sCheatX.Xtype = 1;
		m_sCheatX.Xn = 2;
		m_sCheatX.dwInterval = GetCheatInterval(0);
	}
	else
	{
		//LG("Cheat", "玩家 %s 使用外挂,被踢下线!\n", GetName());
		LG("Cheat", "character %s use waigua,kick it!\n", GetName());

		GatePlayer *pGatePlyer = (GatePlayer *)GetPlayer();
		g_gmsvr->KickPlayer2(pGatePlyer);
		g_pGameApp->GoOutGame(GetPlayer(), true);
	}
#endif
}

//=============================================================================
// 技能状态数据转换为字符串
char* SStateData2String(CCharacter *pCCha, char *szSStateBuf, int nLen)
{
	if (!pCCha || !szSStateBuf) return NULL;

	CSkillState *pSState = &pCCha->m_CSkillState;

	char	szData[512];
	int		nBufLen = 0, nDataLen;
	szSStateBuf[0] = '\0';

	//sprintf(szData, "%d", pSState->GetStateNum());
	_snprintf_s(szData,sizeof(szData),_TRUNCATE, "%d", pSState->GetStateNum());
	nDataLen = (int)strlen(szData);
	if (nBufLen + nDataLen >= nLen) return NULL;
	//strcat(szSStateBuf, szData);
	strncat_s( szSStateBuf,nLen, szData,_TRUNCATE);
	nBufLen += nDataLen;

	SSkillStateUnit *pStateUnit;
	long	lOnTick, lOverTick;
#ifdef COMPACT_MEM_2
		for (map<unsigned char, SSkillStateUnit>::iterator it = pSState->m_SStateMap.begin(); it != pSState->m_SStateMap.end(); it++)
		{
			pStateUnit = &it->second;
#else
	for (unsigned char i = 0; i < pSState->GetStateNum(); i++)
	{
		pStateUnit = pSState->GetSStateByNum(i);
		if (!pStateUnit)
			continue;
#endif
		lOnTick = pStateUnit->lOnTick;
		if (lOnTick <= 0)
			continue;

		lOverTick = (pStateUnit->ulLastTick - pStateUnit->ulStartTick) / 1000;
		if (lOnTick > lOverTick)
			lOnTick -= lOverTick;
		else // 时间已经耗完
			continue;

		//sprintf(szData, ";%d,%d,%d",
		//	pStateUnit->GetStateID(), pStateUnit->GetStateLv(), lOnTick);
		_snprintf_s(szData,sizeof(szData),_TRUNCATE, ";%d,%d,%d",
			pStateUnit->GetStateID(), pStateUnit->GetStateLv(), lOnTick);

		nDataLen = (int)strlen(szData);
		if (nBufLen + nDataLen >= nLen) return NULL;
		//strcat(szSStateBuf, szData);
		strncat_s( szSStateBuf,nLen, szData,_TRUNCATE);
		nBufLen += nDataLen;
	}

	return szSStateBuf;
}

const char* SStateData2StringEx(CCharacter *pCCha, StringPoolL& pool, int index)
{
	if (!pCCha) return NULL;

	CSkillState *pSState = &pCCha->m_CSkillState;

	char	szData[512];

	pool[index].Printf("%d", pSState->GetStateNum());

	SSkillStateUnit *pStateUnit;
	long	lOnTick, lOverTick;
#ifdef COMPACT_MEM_2
	for (map<unsigned char, SSkillStateUnit>::iterator it = pSState->m_SStateMap.begin(); it != pSState->m_SStateMap.end(); it++)
	{
		pStateUnit = &it->second;
#else
	for (unsigned char i = 0; i < pSState->GetStateNum(); i++)
	{
		pStateUnit = pSState->GetSStateByNum(i);
		if (!pStateUnit)
			continue;
#endif
		lOnTick = pStateUnit->lOnTick;
		if (lOnTick <= 0)
			continue;

		lOverTick = (pStateUnit->ulLastTick - pStateUnit->ulStartTick) / 1000;
		if (lOnTick > lOverTick)
			lOnTick -= lOverTick;
		else // 时间已经耗完
			continue;

		_snprintf_s(szData,sizeof(szData),_TRUNCATE, ";%d,%d,%d",
			pStateUnit->GetStateID(), pStateUnit->GetStateLv(), lOnTick);

		pool[index] += szData;
	}

	return (const char*)pool[index];
}

// 字符串转换为技能状态数据
bool Strin2SStateData(CCharacter *pCCha, std::string &strData)
{
	if (!pCCha)
		return false;

	std::string strList[SKILL_STATE_MAXID + 1];
	const short csSubNum = 3;
	std::string strSubList[csSubNum];
	int nSegNum = Util_ResolveTextLine(strData.c_str(), strList, SKILL_STATE_MAXID + 1, ';');
	if (nSegNum < 1)
		return false;

	Util_ResolveTextLine(strList[0].c_str(), strSubList, 3, ','); // 状态个数
	uChar	uchStateNum = Str2Int(strSubList[0]);
	uChar	uchStateID, uchStateLv;
	Long	lOnTick;

	short	sTCount;
	for (uChar i = 0; i < uchStateNum; i++)
	{
		sTCount = 0;
		Util_ResolveTextLine(strList[i + 1].c_str(), strSubList, csSubNum, ',');
		uchStateID = Str2Int(strSubList[sTCount++]);
		uchStateLv = Str2Int(strSubList[sTCount++]);
		lOnTick = Str2Int(strSubList[sTCount++]);
		pCCha->AddSkillState(0, g_pCSystemCha->GetID(), g_pCSystemCha->GetHandle(), 0, 0, 0, uchStateID, uchStateLv, lOnTick, enumSSTATE_ADD_EQUALORLARGER, false);
	}

	return true;
}

// 扩展属性转换成字符串
char*	ChaExtendAttr2String(CCharacter *pCCha, char *szAttrBuf, int nLen)
{
	if (!pCCha || !szAttrBuf)
		return NULL;

	//sprintf(szAttrBuf, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
	//					(int)pCCha->getAttr(ATTR_EXTEND0), (int)pCCha->getAttr(ATTR_EXTEND1), (int)pCCha->getAttr(ATTR_EXTEND2), 
	//					(int)pCCha->getAttr(ATTR_EXTEND3), (int)pCCha->getAttr(ATTR_EXTEND4), (int)pCCha->getAttr(ATTR_EXTEND5), 
	//					(int)pCCha->getAttr(ATTR_EXTEND6), (int)pCCha->getAttr(ATTR_EXTEND7), (int)pCCha->getAttr(ATTR_EXTEND8), 
	//					(int)pCCha->getAttr(ATTR_EXTEND9));
	_snprintf_s( szAttrBuf, nLen, _TRUNCATE, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
		(int)pCCha->getAttr(ATTR_EXTEND0), (int)pCCha->getAttr(ATTR_EXTEND1), (int)pCCha->getAttr(ATTR_EXTEND2), 
		(int)pCCha->getAttr(ATTR_EXTEND3), (int)pCCha->getAttr(ATTR_EXTEND4), (int)pCCha->getAttr(ATTR_EXTEND5), 
		(int)pCCha->getAttr(ATTR_EXTEND6), (int)pCCha->getAttr(ATTR_EXTEND7), (int)pCCha->getAttr(ATTR_EXTEND8), 
		(int)pCCha->getAttr(ATTR_EXTEND9),(int)pCCha->getAttr(ATTR_EXTEND10));

	return szAttrBuf;
}

const char*	ChaExtendAttr2StringEx(CCharacter *pCCha, StringPoolL& pool, int index)
{
	pool[index].Printf("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
		(int)pCCha->getAttr(ATTR_EXTEND0), (int)pCCha->getAttr(ATTR_EXTEND1), (int)pCCha->getAttr(ATTR_EXTEND2), 
		(int)pCCha->getAttr(ATTR_EXTEND3), (int)pCCha->getAttr(ATTR_EXTEND4), (int)pCCha->getAttr(ATTR_EXTEND5), 
		(int)pCCha->getAttr(ATTR_EXTEND6), (int)pCCha->getAttr(ATTR_EXTEND7), (int)pCCha->getAttr(ATTR_EXTEND8), 
		(int)pCCha->getAttr(ATTR_EXTEND9),(int)pCCha->getAttr(ATTR_EXTEND10));

	return (const char*)pool[index];
}

// 字符串转换成扩展属性
bool		Strin2ChaExtendAttr(CCharacter *pCCha, std::string &strAttr)
{
	if (!pCCha || strAttr.length() < 19)
		return false;

	//int val[10];
	int val[11];

	// 初始化
	memset(val, 0, sizeof(val));

	//sscanf(strAttr.c_str(), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d", &val[0], &val[1], &val[2], &val[3], &val[4], &val[5], 
	//														&val[6], &val[7], &val[8], &val[9]);
	sscanf_s(strAttr.c_str(), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d", &val[0], &val[1], &val[2], &val[3], &val[4], &val[5], 
		&val[6], &val[7], &val[8], &val[9], &val[10]);

//	for(int i=0;i<10;i++)
	for(int i=0;i<11;i++)
	{
		pCCha->setAttr(ATTR_COUNT_BASE10 + i, val[i]);
	}

	return true;
}
// ============================
// YATOPS DEFINITIONS
// ============================


float CCharacter::GetDropRate()
{
	CPlayer* cPly		= GetPlayer();
	float	 partyBonus = 1.0;
	float	 ampBonus	= 1.0;
	float	 fairyBonus = 1.0;
	float	 globalRate = g_pGameApp->GetGlobalDropRate();
	if(!globalRate)
	{
		return 0;
	}
	if(cPly && cPly->HasTeam())
	{
		partyBonus += 0.025 * (cPly->GetTeamMemberCnt() - 1);
	}
	// Fortune Lot, Charmed Berry, Amplifier of Luck, Loveless Tear
	if(m_CSkillState.HasState(49) || m_CSkillState.HasState(211) || m_CSkillState.HasState(214) || m_CSkillState.HasState(216))
	{
		ampBonus = 2.0;
	}
	// Special Lucky Fruit
	else if(m_CSkillState.HasState(212))
	{
		ampBonus = 2.5;
	}
	// Super Lucky Fruit and Hi-Amplifier of Luck
	else if(m_CSkillState.HasState(213) || m_CSkillState.HasState(215))
	{
		ampBonus = 3.25;
	}
	SItemGrid* fairy = GetEquipItem(enumEQUIP_FAIRY);
	if(fairy && GetItemRecordInfo(fairy->sID)->sType == enumItemTypePet && (m_CSkillState.HasState(173) || m_CSkillState.HasState(174)))
	{
		// Fairy of Luck, Mordo Jr
		int fairyLv = fairy->GetAttr(ITEMATTR_VAL_STR) + fairy->GetAttr(ITEMATTR_VAL_CON) + fairy->GetAttr(ITEMATTR_VAL_AGI) + fairy->GetAttr(ITEMATTR_VAL_DEX) + fairy->GetAttr(ITEMATTR_VAL_STA);
		switch(fairy->sID)
		{
		case 231: // Fairy of Luck
			fairyBonus += fairyLv * 0.025;
			break;
		case 681: // Mordo Jr
			fairyBonus += fairyLv * 0.02;
			break;
			//case 7126:
			//	// Angela Jr
			//	fairyBonus += 1.5;
		}
	}
	return partyBonus * ampBonus * fairyBonus * globalRate;
}

float CCharacter::GetExpRate()
{
	CPlayer* cPly		= GetPlayer();
	float	 ampBonus	= 1.0;
	float	 fairyBonus = 1.0;
	float	 globalRate = g_pGameApp->GetGlobalExpRate();
	int		 partyCnt	= 0;
	int		 shareCnt	= 0;
	bool	 isTooFar	= false;

	// Lambda definitions
	auto GetDistance = [&](CCharacter* p1, CCharacter* p2) -> long
	{
	  long x1	= p1->GetShape().centre.x;
	  long y1	= p1->GetShape().centre.y;
	  long x2	= p2->GetShape().centre.x;
	  long y2	= p2->GetShape().centre.y;
	  long dist = (long)sqrt(double((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2)));
	  return dist;
	};
	auto NoticeTooFar = [&]
	{
	  isTooFar = true;
	  SystemNotice("Party members are too far away to receive bonuses from Party EXP Fruit!");
	};
	//

	if(!globalRate)
	{
		return 0;
	}
	if(cPly && cPly->HasTeam())
	{
		partyCnt = shareCnt = cPly->GetTeamMemberCnt();
	}

	// Solo-exp Fruits
	// Career Lot, Heaven's Berry, Amplifier of Strive, Mystical Fruit, Mini Amplifier of Strive
	if(m_CSkillState.HasState(48) || m_CSkillState.HasState(200) || m_CSkillState.HasState(201) || m_CSkillState.HasState(204) || m_CSkillState.HasState(205))
	{
		ampBonus = 2.0;
	}
	// Hi-Amplifier of Strive, Super Mystic Fruit
	else if(m_CSkillState.HasState(202) || m_CSkillState.HasState(203))
	{
		ampBonus = 2.5;
	}
	// Level Pushing Machine, Hairy Crab
	else if(m_CSkillState.HasState(206) || m_CSkillState.HasState(208))
	{
		ampBonus = 5.0;
	}
	// Super Booster, Steamed Crab, Thruster of Mystic
	else if(m_CSkillState.HasState(207) || m_CSkillState.HasState(209) || m_CSkillState.HasState(210))
	{
		ampBonus = 10.0;
	}

	// Party-exp fruits
	if(m_CSkillState.HasState(217) || m_CSkillState.HasState(218))
	{
		for(int i = 0; i < partyCnt; i++)
		{
			CPlayer* pMember1 = g_pGameApp->GetPlayerByDBID(cPly->GetTeamMemberDBID(i));
			if(!pMember1) continue;
			for(int k = 0; k < partyCnt; k++)
			{
					// Main cha is not included as TeamMember, so check if he's near another members individually here
					if(GetDistance(pMember1->GetCtrlCha(), this) > 4000)
					{
						NoticeTooFar();
					}
					if(i == k) continue;
					CPlayer* pMember2 = g_pGameApp->GetPlayerByDBID(cPly->GetTeamMemberDBID(k));
					if(!pMember2) continue;
					if(GetDistance(pMember1->GetCtrlCha(), pMember2->GetCtrlCha()) > 4000)
					{
						NoticeTooFar();
					}
			}
		}
		ampBonus *= isTooFar == true ? 1.0 : 1.5;
	}

	SItemGrid* fairy = GetEquipItem(enumEQUIP_FAIRY);
	if(fairy && GetItemRecordInfo(fairy->sID)->sType == enumItemTypePet && (m_CSkillState.HasState(173) || m_CSkillState.HasState(174)))
	{
		// Fairy of Evil, Mordo Jr
		int fairyLv = fairy->GetAttr(ITEMATTR_VAL_STR) + fairy->GetAttr(ITEMATTR_VAL_CON) + fairy->GetAttr(ITEMATTR_VAL_AGI) + fairy->GetAttr(ITEMATTR_VAL_DEX) + fairy->GetAttr(ITEMATTR_VAL_STA);
		switch(fairy->sID)
		{
		case 237: // Fairy of Evil
			fairyBonus += fairyLv * 0.025;
			break;
		case 681: // Mordo Jr
			fairyBonus += fairyLv * 0.02;
			break;
			//case 7126:
			//	// Angela Jr
			//	fairyBonus += 1.5;
		}
	}
	try
	{
		// Check how many members are receiving the EXP, and do not share with those outside the maximum lua range (4000)
		for(int i = 0; i < partyCnt; i++)
		{
			CPlayer* pMember = g_pGameApp->GetPlayerByDBID(cPly->GetTeamMemberDBID(i));
			// Check if this player is too far from any other party member. If he isn't, then we should not decrease shareCnt.
			// If he is, then decrease shareCnt, because the other player is already excluded from receiving EXP (this is done is lua side, CheckExpShare)
			if(pMember && GetDistance(pMember->GetMainCha(), this) > 4000)
			{
					shareCnt--;
			}
		}
	} catch(...)
	{
		printf("\nException handling: pMember was invalid\n partyCnt = %d", partyCnt);
	}
	switch(shareCnt)
	{
	case 0: return ampBonus * fairyBonus * globalRate * 1.0;
	case 1: return ampBonus * fairyBonus * globalRate * 0.9;
	case 2: return ampBonus * fairyBonus * globalRate * 0.85;
	case 3: return ampBonus * fairyBonus * globalRate * 0.80;
	case 4: return ampBonus * fairyBonus * globalRate * 0.75;
	}
}
