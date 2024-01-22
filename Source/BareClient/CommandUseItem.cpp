#include "StdAfx.h"
#include "SelfObject.h"
#include "PacketObject.h"
#include "Sender.h"
#include "GameThread.h"
#include "NetIF.h"
#include ".\commanduseitem.h"

CCommandUseItem::CCommandUseItem(CPlayer *pPlayer) : CCommandObject(pPlayer)
{
}

CCommandUseItem::~CCommandUseItem(void)
{
}

CString CCommandUseItem::GetCommandName()
{
	return "UseItem";
}

bool CCommandUseItem::Execute()
{
	CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return true;
	}
	CPacketObject* pPacketObject=pSelf->FindPacketItem(m_nIndex);
	if (!pPacketObject)
	{
		return true;
	}
	CSender *pSender=&m_pPlayer->GetPlayerGameThread()->GetNetIF()->GetSender();
	pSender->UseItem(m_nIndex);
	return true;
}

void CCommandUseItem::Create(CPlayer *pPlayer,int nIndex,bool bAfterAll)
{
	if (!pPlayer)
	{
		return;
	}
	CCommandUseItem *pCmd=new CCommandUseItem(pPlayer);
	pCmd->m_pPlayer=pPlayer;
	pCmd->m_nIndex=nIndex;
	if (bAfterAll)
	{
		pPlayer->GetCommandMgr().PushToTail(pCmd);
	}
	else
	{
		pPlayer->GetCommandMgr().PushToHead(pCmd);
	}
}
