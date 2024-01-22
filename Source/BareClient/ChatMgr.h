#pragma once

#include "ChannelChatMgr.h"
#include "PrivateRivalMgr.h"

class CChatMgr
{
public:
	CChatMgr(CPlayer *pPlayer);
	~CChatMgr(void);
	CChannelChatMgr& GetChannelChatMgr();
	CPrivateRivalMgr& GetPrivateRivalMgr();

private:
	CChannelChatMgr m_ChannelChatMgr;
	CPrivateRivalMgr m_PrivateRivalMgr;
	CPlayer *m_pPlayer;
};
