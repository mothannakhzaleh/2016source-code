#include "StdAfx.h"
#include "PlayerMgr.h"
#include "BKop.h"
#include "MainFrm.h"
#include "MainView.h"
#include ".\playermessage.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

bool volatile CPlayerMessage::m_bOnlyAddMainPlayerMessage=false;


CPlayerMessage::CPlayerMessage(CPlayer *pPlayer)
{
	m_pPlayer=pPlayer;
	m_MsgObject.SetSize(MESSAGE_INFORMATION_MAXNUM);
	m_bSystemFilter=m_bDebugFilter=m_bFilterBeforeAdd=false;
	m_dwTotalMessageCounts=m_nMsgStartIndex=m_nMsgEndIndex=0;
	m_nMsgCurrentIndex=-1;
}

CPlayerMessage::~CPlayerMessage(void)
{
	ClearAll();
}

void CPlayerMessage::IndexBoundCorrect(int &index)
{
	if (index>=MESSAGE_INFORMATION_MAXNUM)
		index%=MESSAGE_INFORMATION_MAXNUM;
}

int CPlayerMessage::GetMessageCount()
{
	if (m_nMsgStartIndex<=m_nMsgEndIndex)
	{
		return m_nMsgEndIndex-m_nMsgStartIndex;
	}
	else
	{
		return m_nMsgEndIndex+MESSAGE_INFORMATION_MAXNUM-m_nMsgStartIndex;
	}
}

int CPlayerMessage::GetNewMessageCount()
{
	if (m_nMsgCurrentIndex==-1)
	{
		return GetMessageCount();
	}
	else if (m_nMsgCurrentIndex<m_nMsgEndIndex)
	{
		return m_nMsgEndIndex-m_nMsgCurrentIndex-1;
	}
	else
	{
		return m_nMsgEndIndex+MESSAGE_INFORMATION_MAXNUM-m_nMsgCurrentIndex-1;
	}
}

CString CPlayerMessage::GetCurMsg()
{
	if (m_nMsgStartIndex==m_nMsgEndIndex || m_nMsgCurrentIndex==-1)
	{
		return "";
	}
	CPlayerMessageInfo* pMsgInfo=reinterpret_cast<CPlayerMessageInfo*>(m_MsgObject.GetAt(m_nMsgCurrentIndex));
	return pMsgInfo->GetMessage();
}

COLORREF CPlayerMessage::GetCurMsgColor()
{
	if (m_nMsgStartIndex==m_nMsgEndIndex || m_nMsgCurrentIndex==-1)
	{
		return RGB(255,255,255);
	}
	CPlayerMessageInfo* pMsgInfo=reinterpret_cast<CPlayerMessageInfo*>(m_MsgObject.GetAt(m_nMsgCurrentIndex));
	return pMsgInfo->GetMessageColor();
}

CPlayerMessageInfo::eMessageType CPlayerMessage::GetCurMsgType()
{
	if (m_nMsgStartIndex==m_nMsgEndIndex || m_nMsgCurrentIndex==-1)
	{
		return CPlayerMessageInfo::eNormal;
	}
	CPlayerMessageInfo* pMsgInfo=reinterpret_cast<CPlayerMessageInfo*>(m_MsgObject.GetAt(m_nMsgCurrentIndex));
	return pMsgInfo->GetMessageType();
}

void CPlayerMessage::ClearAll()
{
	int nCount=GetMessageCount();
	for (int i=0;i<nCount;i++,m_nMsgStartIndex++)
	{
		IndexBoundCorrect(m_nMsgStartIndex);
		CPlayerMessageInfo* pMsgInfo=reinterpret_cast<CPlayerMessageInfo*>(m_MsgObject.GetAt(m_nMsgStartIndex));
		SAFE_DELETE(pMsgInfo);
	}
	m_nMsgStartIndex=m_nMsgEndIndex=0;
	m_nMsgCurrentIndex=-1;
}

bool CPlayerMessage::MoveToNext()
{
	if (m_nMsgStartIndex==m_nMsgEndIndex)
	{
		return false;
	}
	else if (m_nMsgCurrentIndex==-1)
	{
		m_nMsgCurrentIndex=m_nMsgStartIndex;
		return true;
	}
	int nNextIndex=m_nMsgCurrentIndex+1;
	IndexBoundCorrect(nNextIndex);
	if (nNextIndex==m_nMsgEndIndex)
	{
		return false;
	}
	m_nMsgCurrentIndex=nNextIndex;
	return true;
}

bool CPlayerMessage::MoveToBegin()
{
	if (m_nMsgCurrentIndex==-1 && m_nMsgStartIndex==m_nMsgEndIndex)
	{
		return false;
	}
	m_nMsgCurrentIndex=m_nMsgStartIndex;
	return (m_nMsgStartIndex==m_nMsgEndIndex)?false:true;
}

bool CPlayerMessage::MoveToNextAvailable()
{
	while (MoveToNext())
	{
		CPlayerMessageInfo::eMessageType eType=GetCurMsgType();
		if ( (m_bSystemFilter && eType==CPlayerMessageInfo::eSystem) ||
			 (m_bDebugFilter && eType==CPlayerMessageInfo::eDebug) )
		{
			continue;
		}
		return true;
	}
	return false;
}

bool CPlayerMessage::MoveToFirstAvailable()
{
	if (!MoveToBegin())
	{
		return false;
	}
	CPlayerMessageInfo::eMessageType eType=GetCurMsgType();
	if ( (m_bSystemFilter && eType==CPlayerMessageInfo::eSystem) ||
		(m_bDebugFilter && eType==CPlayerMessageInfo::eDebug) )
	{
		return MoveToNextAvailable();
	}
	return true;
}

void CPlayerMessage::SetSystemMessageFilter(bool bFilter)
{
	m_bSystemFilter=bFilter;
}

void CPlayerMessage::SetDebugMessageFilter(bool bFilter)
{
	m_bDebugFilter=bFilter;
}

void CPlayerMessage::SetFilterBeforeAdd(bool bYes)
{
	m_bFilterBeforeAdd=bYes;
}

bool CPlayerMessage::GetSystemMessageFilter()
{
	return m_bSystemFilter;
}

bool CPlayerMessage::GetDebugMessageFilter()
{
	return m_bDebugFilter;
}

bool CPlayerMessage::GetFilterBeforeAdd()
{
	return m_bFilterBeforeAdd;
}

void CPlayerMessage::SetOnlyAddMainPlayerMessage(bool bYes)	//Static function, setting: only add the current user's information
{
	m_bOnlyAddMainPlayerMessage=bYes;
}

bool CPlayerMessage::GetOnlyAddMainPlayerMessage()
{
	return m_bOnlyAddMainPlayerMessage;
}

bool CPlayerMessage::AddMsg(CString str,...)
{
	m_dwTotalMessageCounts++;
	if (GetOnlyAddMainPlayerMessage() && CPlayerMgr::GetMainPlayer()!=m_pPlayer)
	{
		return false;
	}
	CString strInfo;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	strInfo.Format("[player%d](%d)£º%s",m_pPlayer->GetIndex(),m_dwTotalMessageCounts,strTemp);
	strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+strInfo;
	CPlayerMessageInfo *pPlayerMessage=new CPlayerMessageInfo(CPlayerMessageInfo::eNormal,strInfo);
	while (!((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetSystemPage().PostMessage(THREAD_MSG_ADD_SYSTEM_MESSAGE,(WPARAM)(LPVOID)m_pPlayer,(LPARAM)pPlayerMessage))
	{
		Sleep(50);
	};
	return true;
}

bool CPlayerMessage::AddSystemMsg(CString str,...)
{
	m_dwTotalMessageCounts++;
	if (GetOnlyAddMainPlayerMessage() && CPlayerMgr::GetMainPlayer()!=m_pPlayer)
	{
		return false;
	}
	if (GetFilterBeforeAdd() && GetSystemMessageFilter())
	{
		return false;
	}
	CString strInfo;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	strInfo.Format("[player%d](%d)£º%s",m_pPlayer->GetIndex(),m_dwTotalMessageCounts,strTemp);
	strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+strInfo;
	CPlayerMessageInfo *pPlayerMessage=new CPlayerMessageInfo(CPlayerMessageInfo::eSystem,strInfo);
	while (!((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetSystemPage().PostMessage(THREAD_MSG_ADD_SYSTEM_MESSAGE,(WPARAM)(LPVOID)m_pPlayer,(LPARAM)pPlayerMessage))
	{
		Sleep(50);
	};
	return true;
}

bool CPlayerMessage::AddDebugMsg(CString str,...)
{
	m_dwTotalMessageCounts++;
	if (GetOnlyAddMainPlayerMessage() && CPlayerMgr::GetMainPlayer()!=m_pPlayer)
	{
		return false;
	}
	if (GetFilterBeforeAdd() && GetDebugMessageFilter())
	{
		return false;
	}
	CString strInfo;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	strInfo.Format("[player%d](%d)£º%s",m_pPlayer->GetIndex(),m_dwTotalMessageCounts,strTemp);
	strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+strInfo;
	CPlayerMessageInfo *pPlayerMessage=new CPlayerMessageInfo(CPlayerMessageInfo::eDebug,strInfo);
	while (!((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetSystemPage().PostMessage(THREAD_MSG_ADD_SYSTEM_MESSAGE,(WPARAM)(LPVOID)m_pPlayer,(LPARAM)pPlayerMessage))
	{
		Sleep(50);
	};
	return true;
}

bool CPlayerMessage::AddCustomMsg(CPlayerMessageInfo::eMessageType type,COLORREF color,CString str,...)
{
	m_dwTotalMessageCounts++;
	if (GetOnlyAddMainPlayerMessage() && CPlayerMgr::GetMainPlayer()!=m_pPlayer)
	{
		return false;
	}
	if (GetFilterBeforeAdd())
	{
		if ( (m_bSystemFilter && type==CPlayerMessageInfo::eSystem) ||
			(m_bDebugFilter && type==CPlayerMessageInfo::eDebug) )
		{
			return false;
		}
	}
	CString strInfo;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	strInfo.Format("[player%d](%d)£º%s",m_pPlayer->GetIndex(),m_dwTotalMessageCounts,strTemp);
	strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+strInfo;
	CPlayerMessageInfo *pPlayerMessage=new CPlayerMessageInfo(type,strInfo);
	pPlayerMessage->SetMessageColor(color);
	while (!((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetSystemPage().PostMessage(THREAD_MSG_ADD_SYSTEM_MESSAGE,(WPARAM)(LPVOID)m_pPlayer,(LPARAM)pPlayerMessage))
	{
		Sleep(50);
	};
	return true;
}

void CPlayerMessage::AddToMessageArray(CPlayerMessageInfo* msg)
{
	m_MsgObject.SetAt(m_nMsgEndIndex,msg);
	IndexBoundCorrect(++m_nMsgEndIndex);
	if (m_nMsgEndIndex==m_nMsgStartIndex)
	{
		if (m_nMsgCurrentIndex==m_nMsgStartIndex)
		{
			IndexBoundCorrect(++m_nMsgCurrentIndex);
		}
		CPlayerMessageInfo* pPlayerMessage=reinterpret_cast<CPlayerMessageInfo*>(m_MsgObject.GetAt(m_nMsgStartIndex));
		SAFE_DELETE(pPlayerMessage);
		IndexBoundCorrect(++m_nMsgStartIndex);
	}
}


