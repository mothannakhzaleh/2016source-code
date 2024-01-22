#include "StdAfx.h"
#include "Sender.h"
#include "GameThread.h"
#include "NetIF.h"
#include ".\commandprivatechat.h"

CCommandPrivateChat::CCommandPrivateChat(CPlayer *pPlayer) : CCommandObject(pPlayer)
{
}

CCommandPrivateChat::~CCommandPrivateChat(void)
{
}

CString CCommandPrivateChat::GetCommandName()
{
	return "PrivateChat";
}

bool CCommandPrivateChat::Execute()
{
	CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return true;
	}
	CSender *pSender=&m_pPlayer->GetPlayerGameThread()->GetNetIF()->GetSender();
	pSender->Chat_Channel_Private(m_strTargetName,m_strText);
	return true;
}

void CCommandPrivateChat::Create(CPlayer *pPlayer,CString strTargetName,CString strText,bool bAfterAll)
{
	if (!pPlayer)
	{
		return;
	}
	CCommandPrivateChat *pCmd=new CCommandPrivateChat(pPlayer);
	pCmd->m_pPlayer=pPlayer;
	pCmd->m_strTargetName=strTargetName;
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