#include "StdAfx.h"
#include "GroundObject.h"
#include "SelfObject.h"
#include ".\commandpickup.h"

CCommandPickup::CCommandPickup(CPlayer *pPlayer) : CCommandObject(pPlayer)
{
}

CCommandPickup::~CCommandPickup(void)
{
}

CString CCommandPickup::GetCommandName()
{
	return "Pickup";
}

bool CCommandPickup::Execute()
{
	CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return true;
	}
	CGroundObject *pGroundObject=pSelf->FindGroundItem(m_dwWorldID);
	if (!pGroundObject)
	{
		return true;
	}


	return true;
}

void CCommandPickup::Create(CPlayer *pPlayer,DWORD dwWorldID,bool bAfterAll)
{
	if (!pPlayer || dwWorldID==NULL)
	{
		return;
	}
	CCommandPickup *pCmd=new CCommandPickup(pPlayer);
	pCmd->m_pPlayer=pPlayer;
	pCmd->m_dwWorldID=dwWorldID;
	if (bAfterAll)
	{
		pPlayer->GetCommandMgr().PushToTail(pCmd);
	}
	else
	{
		pPlayer->GetCommandMgr().PushToHead(pCmd);
	}
}
