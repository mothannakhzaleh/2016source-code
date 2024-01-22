#pragma once

#include "AutoPublishData.h"

class CAutoPublishMgr
{
public:
	CAutoPublishMgr(void);
	~CAutoPublishMgr(void);
	void Add(CPlayer *pPlayer, CTime ctStartTime, int nIntervalTime, int nRepeatCount, CString strText);
	void Remove(CAutoPublishData *pData);
	CAutoPublishData *GetAutoPublishData(int nIndex);
	void Run();

private:
	CList<CAutoPublishData*,CAutoPublishData*> m_AutoPublishList;
};
