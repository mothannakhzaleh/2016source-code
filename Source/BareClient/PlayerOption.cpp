#include "StdAfx.h"
#include "GameThread.h"
#include "NetIF.h"
#include "SelfObject.h"
#include "TeleTable.h"
#include "CommandPrivateChat.h"
#include ".\playeroption.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CPlayerOption::CPlayerOption(CPlayer *player)
{
	m_pPlayer=player;
	m_dwLastMoveTick=0;
	m_dwLastTeleTick=0;
	m_dwLastGainPlayerCountTick=0;
	ResetAll();

	SetAutoMove(true);
}

CPlayerOption::~CPlayerOption(void)
{
}

bool CPlayerOption::Run()
{
	if (m_bAutoDrop_TestGateServer)
	{
		CPlayer::eLoginState state=m_pPlayer->GetLoginState();
		if (state==CPlayer::eLOGON_GROUP || state==CPlayer::eLOGON_ACCOUNT || state==CPlayer::eLOGON_GAME)
		{
			//CSystemInfo::Add(m_pPlayer->GetIndex(),"The shock group server function starts, automatically disconnects and reconnects");
			m_pPlayer->GetPlayerMessages().AddMsg("The shock group server function starts, automatically disconnects and reconnects");
			m_pPlayer->SetLoginState(CPlayer::eRESTART_LOGIN);
		}
	}
	if (m_bAutoDrop_TestAccountServer)
	{
		CPlayer::eLoginState state=m_pPlayer->GetLoginState();
		if (state==CPlayer::eLOGON_ACCOUNT || state==CPlayer::eLOGON_GAME)
		{
			//CSystemInfo::Add(m_pPlayer->GetIndex(),"The impact account server function is activated, and the connection is automatically disconnected and reconnected");
			m_pPlayer->GetPlayerMessages().AddMsg("The impact account server function is activated, and the connection is automatically disconnected and reconnected");
			m_pPlayer->SetLoginState(CPlayer::eRESTART_LOGIN);
		}
	}
	if (m_bAutoDrop_TestGameServer)
	{
		if ((m_pPlayer->GetLoginState()==CPlayer::eLOGON_GAME))
		{
			//CSystemInfo::Add(m_pPlayer->GetIndex(),"The impact game server function starts, automatically disconnects and reconnects");
			m_pPlayer->GetPlayerMessages().AddMsg("The impact game server function starts, automatically disconnects and reconnects");
			m_pPlayer->SetLoginState(CPlayer::eRESTART_LOGIN);
		}
	}
	if (m_bAutoMove)
	{
		if (m_pPlayer->GetLoginState()==CPlayer::eLOGON_GAME)
		{
			if (GetTickCount()-m_dwLastMoveTick>3000+(DWORD(rand())%4000))
			{
				CNetIF *pNet=m_pPlayer->GetPlayerGameThread()->GetNetIF();
				if (pNet)
				{
					DWORD moveToX=m_pPlayer->GetRoleMgr().GetSelfObject()->GetPositionX();
					DWORD moveToY=m_pPlayer->GetRoleMgr().GetSelfObject()->GetPositionY();
					moveToX=moveToX+(rand()%1000)-500;
					moveToY=moveToY+(rand()%1000)-500;
					pNet->GetSender().MoveTo(moveToX,moveToY);
				}
				m_dwLastMoveTick=GetTickCount();
			}
		}
	}
	if (m_bAutoTele)
	{
		if (m_pPlayer->GetLoginState()==CPlayer::eLOGON_GAME)
		{
			if (GetTickCount()-m_dwLastTeleTick>8000+(DWORD(rand())%5000))
			{
				CNetIF *pNet=m_pPlayer->GetPlayerGameThread()->GetNetIF();
				if (pNet)
				{
					CString strCommand=CTeleTable::GetRandomTeleCommand();
					pNet->GetSender().TeleCommand(strCommand);
				}
				m_dwLastTeleTick=GetTickCount();
			}
		}
	}
	if (m_bAutoGainPlayerCount)
	{
		if (m_pPlayer->GetLoginState()==CPlayer::eLOGON_GAME)
		{
			if (GetTickCount()-m_dwLastGainPlayerCountTick>60000)
			{
				CNetIF *pNet=m_pPlayer->GetPlayerGameThread()->GetNetIF();
				if (pNet)
				{
					CCommandPrivateChat::Create(m_pPlayer,"@","getusernum+");
				}
				m_dwLastGainPlayerCountTick=GetTickCount();
			}
		}
	}
	return true;
}

void CPlayerOption::SetDropTest_GateServer(bool bDrop)
{
	m_bAutoDrop_TestGateServer=bDrop;
	m_bAutoDrop_TestAccountServer=false;
	m_bAutoDrop_TestGameServer=false;
	m_bAutoTele=false;
	m_bAutoMove=false;
}

void CPlayerOption::SetDropTest_AccountServer(bool bDrop)
{
 	m_bAutoDrop_TestAccountServer=bDrop;
	m_bAutoDrop_TestGameServer=false;
	m_bAutoDrop_TestGateServer=false;
	m_bAutoMove=false;
	m_bAutoTele=false;
}

void CPlayerOption::SetDropTest_GameServer(bool bDrop)
{
	m_bAutoDrop_TestGameServer=bDrop;
	m_bAutoDrop_TestAccountServer=false;
	m_bAutoDrop_TestGateServer=false;
	m_bAutoMove=false;
	m_bAutoTele=false;
}

void CPlayerOption::SetAutoMove(bool bMove)
{
	m_bAutoMove=bMove;
	m_bAutoDrop_TestGameServer=false;
	m_bAutoDrop_TestAccountServer=false;
	m_bAutoDrop_TestGateServer=false;
	m_bAutoTele=false;
}

void CPlayerOption::SetAutoTele(bool bTele)
{
	m_bAutoTele=bTele;
	m_bAutoMove=false;
	m_bAutoDrop_TestGameServer=false;
	m_bAutoDrop_TestAccountServer=false;
	m_bAutoDrop_TestGateServer=false;
}

bool CPlayerOption::IsDropTest_GateServer()
{
	return m_bAutoDrop_TestGateServer;
}

bool CPlayerOption::IsDropTest_AccountServer()
{
	return m_bAutoDrop_TestAccountServer;
}

bool CPlayerOption::IsDropTest_GameServer()
{
	return m_bAutoDrop_TestGameServer;
}

bool CPlayerOption::IsAutoMove()
{
	return m_bAutoMove;
}

bool CPlayerOption::IsAutoTele()
{
	return m_bAutoTele;
}

bool CPlayerOption::IsAutoAutoGainPlayerCount()
{
	return m_bAutoGainPlayerCount;
}

void CPlayerOption::ResetAll()
{
	m_bAutoTele=false;
	m_bAutoMove=false;
	m_bAutoDrop_TestGateServer=false;
	m_bAutoDrop_TestGameServer=false;
	m_bAutoDrop_TestAccountServer=false;
	m_bAutoGainPlayerCount=true;
}
