#include "StdAfx.h"
#include "SelfObject.h"
#include "PacketObject.h"
#include "Sender.h"
#include "GameThread.h"
#include "NetIF.h"
#include ".\commandunequip.h"

CCommandUnEquip::CCommandUnEquip(CPlayer *pPlayer) : CCommandObject(pPlayer)
{
}

CCommandUnEquip::~CCommandUnEquip(void)
{
}

CString CCommandUnEquip::GetCommandName()
{
	return "UnEquip";
}

bool CCommandUnEquip::Execute()
{
	CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return true;
	}
	if (!pSelf->GetEquip(m_nIndex))
	{
		return true;
	}
	CSender *pSender=&m_pPlayer->GetPlayerGameThread()->GetNetIF()->GetSender();
	pSender->UnEquip(m_nIndex);
	return true;
}

void CCommandUnEquip::Create(CPlayer *pPlayer,int nIndex,bool bAfterAll)
{
	if (!pPlayer)
	{
		return;
	}
	CCommandUnEquip *pCmd=new CCommandUnEquip(pPlayer);
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

