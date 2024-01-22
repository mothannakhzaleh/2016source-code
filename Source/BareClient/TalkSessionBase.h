#pragma once

#include "ChannelChatMgr.h"

class CTalkSessionBase
{
public:
	CTalkSessionBase(CChannelChatMgr::eChannel channel);
	virtual ~CTalkSessionBase(void);

	virtual void Renew()=0;				//全部刷新
	virtual void Clear()=0;				//清空频道
	virtual LPVOID GetThisPage()=0;		//取实例地址

	CString GetChannelName();			//取频道名字

	virtual void RefreshSelfChannel()=0;	//往后刷新自己的频道
	virtual void RefreshTotalChannel()=0;	//往后刷新全部频道

protected:
	CChannelChatMgr::eChannel m_eChannel;
};
