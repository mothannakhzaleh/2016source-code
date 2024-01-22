#include "StdAfx.h"
#include ".\talksessionbase.h"



CTalkSessionBase::CTalkSessionBase(CChannelChatMgr::eChannel channel)
{
	m_eChannel=channel;
}

CTalkSessionBase::~CTalkSessionBase(void)
{
}

CString CTalkSessionBase::GetChannelName()
{
	return CChannelChatMgr::GetChannelName(m_eChannel);
}