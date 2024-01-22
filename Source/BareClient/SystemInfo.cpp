#include "StdAfx.h"
#include "BKop.h"
#include "MainFrm.h"
#include "MainView.h"
#include ".\systeminfo.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif

DWORD CSystemInfo::m_TotalMsg=0;
bool volatile CSystemInfo::m_bClose=false;
CArray<int,int&> CSystemInfo::m_IndexArray;
CArray<POSITION,POSITION&> CSystemInfo::m_dwArrayPos;
CSystemInfo::LInfo CSystemInfo::m_Infos;
CArray<CSystemInfo::LInfo,CSystemInfo::LInfo&> CSystemInfo::m_InfoArray;
CCriticalSection CSystemInfo::m_CriticalSection;

CSystemInfo::CSystemInfo(void)
{
}

CSystemInfo::~CSystemInfo(void)
{
}

void CSystemInfo::InitArraySize(DWORD dwSize)
{
	m_CriticalSection.Lock();
	m_InfoArray.SetSize(dwSize+1);
	m_IndexArray.SetSize(dwSize+1);
	m_dwArrayPos.SetSize(dwSize+1);
	for (DWORD i=0;i<=dwSize;i++)
	{
		m_IndexArray[i]=0;
		m_dwArrayPos[i]=NULL;//m_InfoArray[i].GetHeadPosition();
	}
	m_CriticalSection.Unlock();
}

void CSystemInfo::Add(int nPlayerIndex,CString str,...)
{
	m_CriticalSection.Lock();
	if (m_bClose)
	{
		m_CriticalSection.Unlock();
		return;
	}
	m_TotalMsg++;
	m_IndexArray[nPlayerIndex]++;
	sInfo si;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	si.strInfo.Format("[玩家%d](%d)：%s",nPlayerIndex,m_IndexArray[nPlayerIndex],strTemp);
	si.strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+si.strInfo;
	si.nIndex=m_IndexArray[nPlayerIndex];
	si.dwMsgCounts=m_TotalMsg;
	si.eLevel=eLeast;
	si.dwColor=eLeastColor;
	m_InfoArray[nPlayerIndex].AddTail(si);
	if (m_InfoArray[nPlayerIndex].GetCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		if (m_InfoArray[nPlayerIndex].GetHeadPosition()==m_dwArrayPos[nPlayerIndex])
		{
			m_InfoArray[nPlayerIndex].GetNext(m_dwArrayPos[nPlayerIndex]);
		}
		m_InfoArray[nPlayerIndex].RemoveHead();
	}
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->PostMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	m_CriticalSection.Unlock();
	//((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->SendMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	//Sleep(50);
}

void CSystemInfo::AddInfo(int nPlayerIndex,CString str,...)
{
	m_CriticalSection.Lock();
	if (m_bClose)
	{
		m_CriticalSection.Unlock();
		return;
	}
	m_TotalMsg++;
	m_IndexArray[nPlayerIndex]++;
	sInfo si;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	si.strInfo.Format("[玩家%d](%d)：%s",nPlayerIndex,m_IndexArray[nPlayerIndex],strTemp);
	si.strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+si.strInfo;
	si.nIndex=m_IndexArray[nPlayerIndex];
	si.dwMsgCounts=m_TotalMsg;
	si.eLevel=eNormal;
	si.dwColor=eNormalColor;
	m_InfoArray[nPlayerIndex].AddTail(si);
	if (m_InfoArray[nPlayerIndex].GetCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		if (m_InfoArray[nPlayerIndex].GetHeadPosition()==m_dwArrayPos[nPlayerIndex])
		{
			m_InfoArray[nPlayerIndex].GetNext(m_dwArrayPos[nPlayerIndex]);
		}
		m_InfoArray[nPlayerIndex].RemoveHead();
	}
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->PostMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	m_CriticalSection.Unlock();
	//((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->SendMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	//Sleep(50);
}

void CSystemInfo::AddSystemInfo(int nPlayerIndex,CString str,...)
{
	m_CriticalSection.Lock();
	if (m_bClose)
	{
		m_CriticalSection.Unlock();
		return;
	}
	m_TotalMsg++;
	m_IndexArray[nPlayerIndex]++;
	sInfo si;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	si.strInfo.Format("[玩家%d](%d)：%s",nPlayerIndex,m_IndexArray[nPlayerIndex],strTemp);
	si.strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+si.strInfo;	si.nIndex=m_IndexArray[nPlayerIndex];
	si.dwMsgCounts=m_TotalMsg;
	si.eLevel=eSystem;
	si.dwColor=eSystemColor;
	m_InfoArray[nPlayerIndex].AddTail(si);
	if (m_InfoArray[nPlayerIndex].GetCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		if (m_InfoArray[nPlayerIndex].GetHeadPosition()==m_dwArrayPos[nPlayerIndex])
		{
			m_InfoArray[nPlayerIndex].GetNext(m_dwArrayPos[nPlayerIndex]);
		}
		m_InfoArray[nPlayerIndex].RemoveHead();
	}
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->PostMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	m_CriticalSection.Unlock();
	//((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->SendMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	//Sleep(50);
}

void CSystemInfo::AddDebugInfo(int nPlayerIndex,CString str,...)
{
	m_CriticalSection.Lock();
	if (m_bClose)
	{
		m_CriticalSection.Unlock();
		return;
	}
	m_TotalMsg++;
	m_IndexArray[nPlayerIndex]++;
	sInfo si;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	si.strInfo.Format("[玩家%d](%d)：%s",nPlayerIndex,m_IndexArray[nPlayerIndex],strTemp);
	si.strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+si.strInfo;	si.nIndex=m_IndexArray[nPlayerIndex];
	si.dwMsgCounts=m_TotalMsg;
	si.eLevel=eDebug;
	si.dwColor=eDebugColor;
	m_InfoArray[nPlayerIndex].AddTail(si);
	if (m_InfoArray[nPlayerIndex].GetCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		if (m_InfoArray[nPlayerIndex].GetHeadPosition()==m_dwArrayPos[nPlayerIndex])
		{
			m_InfoArray[nPlayerIndex].GetNext(m_dwArrayPos[nPlayerIndex]);
		}
		m_InfoArray[nPlayerIndex].RemoveHead();
	}
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->PostMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	m_CriticalSection.Unlock();
	//((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->SendMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	//Sleep(50);
}

void CSystemInfo::AddDetailDebugInfo(int nPlayerIndex,CString str,...)
{
	m_CriticalSection.Lock();
	if (m_bClose)
	{
		m_CriticalSection.Unlock();
		return;
	}
	m_TotalMsg++;
	m_IndexArray[nPlayerIndex]++;
	sInfo si;
	CString strTemp;
	va_list argList;
	va_start( argList, str );
	strTemp.FormatV(str,argList);
	va_end( argList );
	si.strInfo.Format("[玩家%d](%d)：%s",nPlayerIndex,m_IndexArray[nPlayerIndex],strTemp);
	si.strInfo=CTime::GetCurrentTime().Format("<%H:%M:%S>")+si.strInfo;	si.nIndex=m_IndexArray[nPlayerIndex];
	si.dwMsgCounts=m_TotalMsg;
	si.eLevel=eDetailDebug;
	si.dwColor=eDetailDebugColor;
	m_InfoArray[nPlayerIndex].AddTail(si);
	if (m_InfoArray[nPlayerIndex].GetCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		if (m_InfoArray[nPlayerIndex].GetHeadPosition()==m_dwArrayPos[nPlayerIndex])
		{
			m_InfoArray[nPlayerIndex].GetNext(m_dwArrayPos[nPlayerIndex]);
		}
		m_InfoArray[nPlayerIndex].RemoveHead();
	}
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->PostMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	m_CriticalSection.Unlock();
	//((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->SendMessage(THREAD_MSG_REFRESH_INFO,nPlayerIndex);
	//Sleep(50);
}

void CSystemInfo::ResetAllPosition()
{
	m_CriticalSection.Lock();
	for (DWORD i=0;i<(DWORD)m_dwArrayPos.GetCount();i++)
	{
		m_dwArrayPos[i]=NULL;
	}
	m_CriticalSection.Unlock();
}

void CSystemInfo::ResetPosition(int index)
{
	m_CriticalSection.Lock();
	m_dwArrayPos[index]=NULL;
	m_CriticalSection.Unlock();
}

void CSystemInfo::DeleteInfo(int nPlayerIndex)
{
	m_CriticalSection.Lock();
	m_IndexArray[nPlayerIndex]=0;
	m_dwArrayPos[nPlayerIndex]=NULL;
	m_InfoArray[nPlayerIndex].RemoveAll();
	m_CriticalSection.Unlock();
}

void CSystemInfo::DeleteAllInfos()
{
	m_CriticalSection.Lock();
	for (int i=0;i<(int)m_InfoArray.GetSize();i++)
	{
		m_IndexArray[i]=0;
		m_dwArrayPos[i]=NULL;
		m_InfoArray[i].RemoveAll();
	}
	m_CriticalSection.Unlock();
}

DWORD CSystemInfo::GetNextInfoOrder(int nPlayerIndex)
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	if (m_dwArrayPos[nPlayerIndex]==NULL)
	{
		if (m_InfoArray[nPlayerIndex].IsEmpty())
		{
			return 0;
		}
		else
		{
			return m_InfoArray[nPlayerIndex].GetHead().dwMsgCounts;
		}
	}
	else
	{
		POSITION pos=m_dwArrayPos[nPlayerIndex];
		sInfo si=m_InfoArray[nPlayerIndex].GetNext(pos);
		if (pos!=NULL)
		{
			return si.dwMsgCounts;
		}
		else
		{
			return 0;
		}
	}
}

CString CSystemInfo::GetNowLine(int nPlayerIndex)
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	if (m_dwArrayPos[nPlayerIndex])
	{
		return m_InfoArray[nPlayerIndex].GetAt(m_dwArrayPos[nPlayerIndex]).strInfo;
	}
	return NULL;
}

COLORREF CSystemInfo::GetNowLineColor(int nPlayerIndex)
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	if (m_dwArrayPos[nPlayerIndex])
	{
		return m_InfoArray[nPlayerIndex].GetAt(m_dwArrayPos[nPlayerIndex]).dwColor;
	}
	return 0;
}

CSystemInfo::eInfoLevel CSystemInfo::GetNowLineLevel(int nPlayerIndex)
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	if (m_dwArrayPos[nPlayerIndex])
	{
		return m_InfoArray[nPlayerIndex].GetAt(m_dwArrayPos[nPlayerIndex]).eLevel;
	}
	return eLeast;
}

bool CSystemInfo::MoveNext(int nPlayerIndex)
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	POSITION pos=m_dwArrayPos[nPlayerIndex];
	if (pos==NULL)
	{
		pos=m_InfoArray[nPlayerIndex].GetHeadPosition();
	}
	else
	{
		m_InfoArray[nPlayerIndex].GetNext(pos);
	}
	if (pos)
	{
		m_dwArrayPos[nPlayerIndex]=pos;
		return true;
	}
	return false;
}

void CSystemInfo::Close()
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	m_bClose=true;
}

void CSystemInfo::Open()
{
	CSingleLock sLock(&m_CriticalSection);
	sLock.Lock();
	m_bClose=false;
}
