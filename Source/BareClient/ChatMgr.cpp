#include "StdAfx.h"
#include ".\chatmgr.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CChatMgr::CChatMgr(CPlayer *pPlayer) : m_ChannelChatMgr(pPlayer), m_PrivateRivalMgr(pPlayer)
{
	m_pPlayer=pPlayer;
}

CChatMgr::~CChatMgr(void)
{
}

CChannelChatMgr& CChatMgr::GetChannelChatMgr()
{
	return m_ChannelChatMgr;
}

CPrivateRivalMgr& CChatMgr::GetPrivateRivalMgr()
{
	return m_PrivateRivalMgr;
}
