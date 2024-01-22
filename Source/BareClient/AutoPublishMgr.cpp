#include "StdAfx.h"
#include "AutoPublishDlg.h"
#include ".\autopublishmgr.h"

CAutoPublishMgr::CAutoPublishMgr(void)
{
}

CAutoPublishMgr::~CAutoPublishMgr(void)
{
	POSITION pos=m_AutoPublishList.GetHeadPosition();
	while (pos)
	{
		CAutoPublishData *pData=m_AutoPublishList.GetNext(pos);
		delete pData;
	}
	m_AutoPublishList.RemoveAll();
}

void CAutoPublishMgr::Add(CPlayer *pPlayer, CTime ctStartTime, int nIntervalTime, int nRepeatCount, CString strText)
{
	CAutoPublishData *pData=new CAutoPublishData(pPlayer,ctStartTime,nIntervalTime,nRepeatCount,strText);
	m_AutoPublishList.AddTail(pData);
}

void CAutoPublishMgr::Remove(CAutoPublishData *pData)
{
	POSITION pos=m_AutoPublishList.Find(pData);
	if (!pos) return;
	m_AutoPublishList.RemoveAt(pos);
}

CAutoPublishData *CAutoPublishMgr::GetAutoPublishData(int nIndex)
{
	if (m_AutoPublishList.GetCount()<=nIndex) return NULL;
	POSITION pos=m_AutoPublishList.FindIndex(nIndex);
	return m_AutoPublishList.GetAt(pos);
}

void CAutoPublishMgr::Run()
{
	POSITION pos=m_AutoPublishList.GetHeadPosition();
	while (pos)
	{
		CAutoPublishData *pData=m_AutoPublishList.GetNext(pos);
		pData->Execute();
	}
}


