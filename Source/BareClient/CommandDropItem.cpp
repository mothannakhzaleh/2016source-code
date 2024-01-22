#include "StdAfx.h"
#include "SelfObject.h"
#include "PacketObject.h"
#include "GameThread.h"
#include "NetIF.h"
#include "Sender.h"
#include ".\commanddropitem.h"

CCommandDropItem::CCommandDropItem(CPlayer *pPlayer) : CCommandObject(pPlayer)
{
	m_nIndex=0;
	m_nNum=0;
}

CCommandDropItem::~CCommandDropItem(void)
{
}

CString CCommandDropItem::GetCommandName()
{
	return "DropItem";
}

bool CCommandDropItem::Execute()
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
	pSender->DropItem(m_nIndex,m_nNum);
	return true;
}

void CCommandDropItem::Create(CPlayer *pPlayer,int nIndex,WORD nNum,bool bAfterAll)
{
	if (!pPlayer)
	{
		return;
	}
	CCommandDropItem *pCmd=new CCommandDropItem(pPlayer);
	pCmd->m_nIndex=nIndex;
	pCmd->m_nNum=nNum;
	if (bAfterAll)
	{
		pPlayer->GetCommandMgr().PushToTail(pCmd);
	}
	else
	{
		pPlayer->GetCommandMgr().PushToHead(pCmd);
	}
}
