#include "StdAfx.h"
#include "LoginData.h"
#include "GameThread.h"
#include ".\playermgr.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

POSITION CPlayerMgr::m_Position=NULL;
CList<CPlayer*,CPlayer*> CPlayerMgr::m_PlayersList;
CPlayer *CPlayerMgr::m_pMainPlayer=NULL;

CPlayerMgr::CPlayerMgr(void)
{
}

CPlayerMgr::~CPlayerMgr(void)
{
	while (m_PlayersList.GetCount()>0)
	{
		CPlayer *player=m_PlayersList.GetHead();
		delete player;
		m_PlayersList.RemoveHead();
	}
}

CPlayer *CPlayerMgr::AddPlayer(CString service,CString accountName,CString password,WORD nRole)
{
	CPlayer *player=new CPlayer();
	player->GetLoginData()->SetServiceName(service);
	player->GetLoginData()->SetAccountName(accountName);
	player->GetLoginData()->SetPassword(password);
	player->SetMainRoleIndex(nRole);
	m_PlayersList.AddTail(player);
	return player;
}

bool CPlayerMgr::RemovePlayer(int nIndex)
{
	POSITION playerPos=m_PlayersList.GetHeadPosition();
	while (playerPos)
	{
		CPlayer *player=m_PlayersList.GetAt(playerPos);
		if (player->GetIndex()==nIndex)
		{
			m_PlayersList.RemoveAt(playerPos);
			delete player;
			return true;
		}
		m_PlayersList.GetNext(playerPos);
	}
	return false;
}

void CPlayerMgr::DeletePlayers(int index[],int indexArraySize)
{
	int i=0;
	for (;i<indexArraySize;i++)
	{
		POSITION playerPos=m_PlayersList.GetHeadPosition();
		for (int j=0;j<m_PlayersList.GetCount();j++)
		{
			CPlayer *player=m_PlayersList.GetNext(playerPos);
			if (index[i]==player->GetIndex() && player->GetPlayerGameThread())
			{
				PostThreadMessage(player->GetPlayerGameThread()->GetThreadID(),WM_QUIT,0,NULL);
			}
		}
	}
	for (i=0;i<indexArraySize;i++)
	{
		POSITION playerPos=m_PlayersList.GetHeadPosition();
		while (playerPos)
		{
			CPlayer *player=m_PlayersList.GetAt(playerPos);
			if (player->GetIndex()==index[i])
			{
				m_PlayersList.RemoveAt(playerPos);
				delete player;
				playerPos=m_PlayersList.GetHeadPosition();
				continue;
			}
			m_PlayersList.GetNext(playerPos);
		}
	}
}

void CPlayerMgr::DeleteAllPlayers()
{
	POSITION playerPos=m_PlayersList.GetHeadPosition();
	for (int i=0;i<m_PlayersList.GetCount();i++)
	{
		CPlayer *player=m_PlayersList.GetNext(playerPos);
		if (player->GetPlayerGameThread())
		{
			PostThreadMessage(player->GetPlayerGameThread()->GetThreadID(),WM_QUIT,0,NULL);
		}
	}
	while (m_PlayersList.GetCount()>0)
	{
		CPlayer *player=m_PlayersList.GetHead();
		delete player;
		m_PlayersList.RemoveHead();
	}
}

int CPlayerMgr::GetTotalPlayers()
{
	return (int)m_PlayersList.GetCount();
}

CPlayer *CPlayerMgr::GetFirstPlayer()
{
	if (m_PlayersList.IsEmpty())
	{
		return NULL;
	}
	m_Position=m_PlayersList.GetHeadPosition();
	return m_PlayersList.GetNext(m_Position);
}

CPlayer *CPlayerMgr::GetNextPlayer()
{
	if (!m_Position)
	{
		return NULL;
	}
	CPlayer *player=m_PlayersList.GetNext(m_Position);
	return player;
}

bool CPlayerMgr::FindPlayer(CPlayer *player)
{
	POSITION playerPos=m_PlayersList.GetHeadPosition();
	for (int i=0;i<m_PlayersList.GetCount();i++)
	{
		if (player==m_PlayersList.GetNext(playerPos))
		{
			return true;
		}
	}
	return false;
}

bool CPlayerMgr::SetMainPlayer(CPlayer *player)
{
	POSITION playerPos=m_PlayersList.GetHeadPosition();
	while (playerPos)
	{
		CPlayer *playerInList=m_PlayersList.GetAt(playerPos);
		if (playerInList==player)
		{
			m_pMainPlayer=player;
			return true;
		}
		m_PlayersList.GetNext(playerPos);
	}
	ASSERT(false);
	return false;
}

bool CPlayerMgr::SetMainPlayer(int index)
{
	POSITION playerPos=m_PlayersList.GetHeadPosition();
	while (playerPos)
	{
		CPlayer *player=m_PlayersList.GetAt(playerPos);
		if (player->GetIndex()==index)
		{
			m_pMainPlayer=player;
			return true;
		}
		m_PlayersList.GetNext(playerPos);
	}
	ASSERT(false);
	return false;
}

CPlayer *CPlayerMgr::GetMainPlayer()
{
	if (m_PlayersList.GetCount()==0)
	{
		m_pMainPlayer=NULL;
	}
	return m_pMainPlayer;
}




CPlayerMgr g_PlayerMgr;	//must be constructed last