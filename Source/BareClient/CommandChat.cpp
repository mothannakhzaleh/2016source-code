#include "StdAfx.h"
#include "Sender.h"
#include "GameThread.h"
#include "NetIF.h"
#include ".\commandchat.h"

CCommandChat::CCommandChat(CPlayer *pPlayer) : CCommandObject(pPlayer)
{
}

CCommandChat::~CCommandChat(void)
{
}

CString CCommandChat::GetCommandName()
{
	return "Chat";
}

bool CCommandChat::Execute()
{
	CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return true;
	}
	CSender *pSender=&m_pPlayer->GetPlayerGameThread()->GetNetIF()->GetSender();
	switch(m_eChannel)
	{
	case eSight:
		{
			pSender->Chat_Channel_Sight(m_strText);
			break;
		}
	case eWorld:
		{
			pSender->Chat_Channel_World(m_strText);
			break;
		}
	case eTrade:
		{
			pSender->Chat_Channel_Trade(m_strText);
			break;
		}
	case eTeam:
		{
			pSender->Chat_Channel_Team(m_strText);
			break;
		}
	case ePublish:
		{
			pSender->Chat_Channel_Publish(m_strText);
			break;
		}
	case eGuild:
		{
			//pSender->Chat_Channel_Guild(m_strText);
			break;
		}
	default:
		{
		}
	}
	return true;
}

void CCommandChat::Create(CPlayer *pPlayer,eChannel eChannel,CString strText,bool bAfterAll)
{
	if (!pPlayer)
	{
		return;
	}
	CCommandChat *pCmd=new CCommandChat(pPlayer);
	pCmd->m_pPlayer=pPlayer;
	pCmd->m_eChannel=eChannel;
	pCmd->m_strText=strText;
	if (bAfterAll)
	{
		pPlayer->GetCommandMgr().PushToTail(pCmd);
	}
	else
	{
		pPlayer->GetCommandMgr().PushToHead(pCmd);
	}
}
