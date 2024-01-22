#include "StdAfx.h"
#include "SelfObject.h"
#include "LoginData.h"
#include ".\privaterivalmgr.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CPrivateRivalMgr::CPrivateRivalMgr(CPlayer *pPlayer)
{
	m_Pos=NULL;
	m_dwTotalInCounts=0;
	m_dwTotalOutCounts=0;
	m_bRivalChangeFlag=true;
	m_pPlayer=pPlayer;
}

CPrivateRivalMgr::~CPrivateRivalMgr(void)
{
	Clear();
}

CPrivateRivalMgr::sRivalData* CPrivateRivalMgr::FindRival(CString strRivalName)
{
	POSITION pos=m_RivalList.GetHeadPosition();
	while (pos)
	{
		sRivalData* pRival=m_RivalList.GetNext(pos);
		if (pRival->strName==strRivalName)
		{
			return pRival;
		}
	}
	return NULL;
}

void CPrivateRivalMgr::Remove(sRivalData* pRival)
{
	POSITION pos=m_RivalList.Find(pRival);
	if (pos)
	{
		SAFE_DELETE(pRival->pFile);
		SAFE_DELETE(pRival);
		m_RivalList.RemoveAt(pos);
	}
	m_Pos=NULL;
}

bool CPrivateRivalMgr::hasRival(sRivalData *pRival)
{
	return m_RivalList.Find(pRival)?true:false;
}

void CPrivateRivalMgr::OnRivalMessage(CString strRivalName,bool bOutMessage)
{
	sRivalData* pRival=FindRival(strRivalName);
	if (!pRival)
	{
		pRival=new sRivalData;
		pRival->strName=strRivalName;
		pRival->dwInCounts=pRival->dwOutCounts=0;
		pRival->bFlashColor=false;
		pRival->dwStartFlashTick=0;
		pRival->pFile=NULL;
		CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
		if (pSelf)
		{
			CString strSelfName=pSelf->GetName();
			CString strPathName="Chat\\";//+strSelfName+"\\"+CChannelChatMgr::GetChannelName(CChannelChatMgr::CHANNEL_PRIVATE)+"\\";
            CreateDirectory(strPathName,NULL);
            strPathName+=m_pPlayer->GetLoginData()->GetServiceName();
            strPathName+="\\";
			CreateDirectory(strPathName,NULL);
			strPathName+=strSelfName+"\\";
			CreateDirectory(strPathName,NULL);
			strPathName+=CChannelChatMgr::GetChannelName(CChannelChatMgr::CHANNEL_PRIVATE)+"\\";
			CreateDirectory(strPathName,NULL);
			strPathName+=strRivalName+".txt";
			pRival->pFile=new CStdioFile();
			if (!pRival->pFile->Open(strPathName,CFile::modeCreate|CFile::modeNoTruncate|CFile::shareDenyWrite|CFile::modeWrite|CFile::typeText))
			{
				SAFE_DELETE(pRival->pFile);
			}
			else
			{
				pRival->pFile->SeekToEnd();
			}
		}
		m_RivalList.AddTail(pRival);
		m_bRivalChangeFlag=true;
	}
	EnableFlashColor(pRival,true);
	if (bOutMessage)
	{
		pRival->dwOutCounts++;
		m_dwTotalOutCounts++;
	}
	else
	{
		pRival->dwInCounts++;
		m_dwTotalInCounts++;
	}
}

bool CPrivateRivalMgr::MoveToBegin()
{
	m_Pos=m_RivalList.GetHeadPosition();
	return (m_Pos)?true:false;
}

bool CPrivateRivalMgr::MoveToNext()
{
	if (!m_Pos)
	{
		return MoveToBegin();
	}
	else
	{
		POSITION pos=m_Pos;
		m_RivalList.GetNext(pos);
		if (pos)
		{
			m_Pos=pos;
			return true;
		}
		else
		{
			return false;
		}
	}
}

void CPrivateRivalMgr::Clear()
{
	m_Pos=NULL;
	m_dwTotalInCounts=0;
	m_dwTotalOutCounts=0;
	m_bRivalChangeFlag=true;
	while (m_RivalList.GetCount())
	{
		sRivalData *pRivalData=m_RivalList.GetHead();
		SAFE_DELETE(pRivalData->pFile);
		SAFE_DELETE(pRivalData);
		m_RivalList.RemoveHead();
	};
}

CPrivateRivalMgr::sRivalData* CPrivateRivalMgr::GetCurRival()
{
	if (!m_Pos)
	{
		return NULL;
	}
	return m_RivalList.GetAt(m_Pos);
}

CString CPrivateRivalMgr::GetCurRivalName()
{
	if (!m_Pos)
	{
		return NULL;
	}
	return m_RivalList.GetAt(m_Pos)->strName;
}

DWORD CPrivateRivalMgr::GetCurRivalInCounts()
{
	if (!m_Pos)
	{
		return NULL;
	}
	return m_RivalList.GetAt(m_Pos)->dwInCounts;
}

DWORD CPrivateRivalMgr::GetCurRivalOutCounts()
{
	if (!m_Pos)
	{
		return NULL;
	}
	return m_RivalList.GetAt(m_Pos)->dwOutCounts;
}

DWORD CPrivateRivalMgr::GetTotalInCounts()
{
	return m_dwTotalInCounts;
}

DWORD CPrivateRivalMgr::GetTotalOutCounts()
{
	return m_dwTotalOutCounts;
}

bool CPrivateRivalMgr::IsRefreshRival()
{
	bool bRet=m_bRivalChangeFlag;
	m_bRivalChangeFlag=false;
	return bRet;
}

void CPrivateRivalMgr::EnableFlashColor(sRivalData *pRivalData,bool bFlash)
{
	if (!pRivalData) return;
	if (bFlash)
	{
		pRivalData->bFlashColor=true;
		pRivalData->dwStartFlashTick=GetTickCount();
	}
	else
	{
		pRivalData->bFlashColor=false;
		pRivalData->dwStartFlashTick=0;
	}
}

COLORREF CPrivateRivalMgr::GetShowColor(sRivalData *pRivalData)
{
	static COLORREF color0=RGB(0,0,0);
	static COLORREF color1=RGB(0,0,0);
	static COLORREF color2=RGB(127,127,0);
	COLORREF *pColor=&color0;
	if (!pRivalData || !pRivalData->bFlashColor) return *pColor;
	DWORD dwInterval=GetTickCount()-pRivalData->dwStartFlashTick;
	if ((dwInterval/600)&1)
	{
		pColor=&color1;
	}
	else
	{
		pColor=&color2;
	}
	return *pColor;
}




