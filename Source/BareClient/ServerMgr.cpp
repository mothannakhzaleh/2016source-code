#include "StdAfx.h"
#include "afxdao.h"
#include ".\servermgr.h"
#include <iniFile.h>



CList<CServerMgr::sServerInfo*,CServerMgr::sServerInfo*> CServerMgr::m_ServerInfoList;


CServerMgr::CServerMgr(void)
{
}

CServerMgr::~CServerMgr(void)
{
}

bool CServerMgr::LoadServerInfo()
{
  try
  {
	dbc::IniFile ini("Servers.cfg");
	for(int i = 0; i < ini.SectCount(); ++i)
	{
	  auto					 serverInfo = std::make_unique<sServerInfo>();
	  dbc::IniSection& iniServer	= ini[i];
	  assert((iniServer.ItemCount() == 4));
	  serverInfo->strServerName			= iniServer["name"];
	  serverInfo->strServerIP			= iniServer["ip"];
	  serverInfo->bServerVerify			= iniServer["passport"] == "true" ? true : false;
	  serverInfo->bTomServer			= iniServer["TomServer"] == "true" ? true : false;
	  m_ServerInfoList.AddTail(serverInfo.release());
	}
  } catch(const std::exception& e)
  {
	MessageBox(NULL, e.what(), "Error: LoadServerInfo", MB_OK);
	return false;
  }

  return true;
}

void CServerMgr::FreeServerInfo()
{
	POSITION pos;
	while (pos=m_ServerInfoList.GetHeadPosition())
	{
		sServerInfo *pServerInfo=m_ServerInfoList.GetAt(pos);
		m_ServerInfoList.RemoveAt(pos);
		delete pServerInfo;
	}
}

CString CServerMgr::GetServerName(DWORD index)
{
	DWORD n=(DWORD)m_ServerInfoList.GetCount();
	if (index<n)
	{
		POSITION pos=m_ServerInfoList.FindIndex(index);
		if (pos==NULL) return NULL;
		return m_ServerInfoList.GetAt(pos)->strServerName;
	}
	return NULL;
}

CString CServerMgr::GetServerIP(DWORD index)
{
	DWORD n=(DWORD)m_ServerInfoList.GetCount();
	if (index<n)
	{
		POSITION pos=m_ServerInfoList.FindIndex(index);
		if (pos==NULL) return NULL;
		return m_ServerInfoList.GetAt(pos)->strServerIP;
	}
	return NULL;
}

CString CServerMgr::GetServerIP(CString strServerName)
{
	POSITION pos=m_ServerInfoList.GetHeadPosition();
	while (pos)
	{
		sServerInfo *pServerInfo=m_ServerInfoList.GetNext(pos);
		if (pServerInfo->strServerName==strServerName)
		{
			return pServerInfo->strServerIP;
		}
	}
	return NULL;
}

BOOL CServerMgr::IsServerNeedVerify(CString strServerName)
{
	POSITION pos=m_ServerInfoList.GetHeadPosition();
	while (pos)
	{
		sServerInfo *pServerInfo=m_ServerInfoList.GetNext(pos);
		if (pServerInfo->strServerName==strServerName)
		{
			return pServerInfo->bServerVerify;
		}
	}
	return FALSE;
}

BOOL CServerMgr::IsTomServer(CString strServerName)
{
	POSITION pos=m_ServerInfoList.GetHeadPosition();
	while (pos)
	{
		sServerInfo *pServerInfo=m_ServerInfoList.GetNext(pos);
		if (pServerInfo->strServerName==strServerName)
		{
			return pServerInfo->bTomServer;
		}
	}
	return FALSE;
}
