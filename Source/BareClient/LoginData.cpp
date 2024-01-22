#include "StdAfx.h"
#include "ServerMgr.h"
#include ".\logindata.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CLoginData::CLoginData(void)
{
	m_strServiceName="";
	m_strServiceIP="";
	m_strAccountName="";
	m_strPassword="";
	m_bServerVerify=FALSE;
	m_bTomServer=FALSE;
}

CLoginData::~CLoginData(void)
{
}

void CLoginData::SetServiceName(CString serviceName)
{
	m_strServiceName=serviceName;
	m_strServiceIP=CServerMgr::GetServerIP(serviceName);
	m_bServerVerify=CServerMgr::IsServerNeedVerify(serviceName);
	m_bTomServer=CServerMgr::IsTomServer(serviceName);
}

void CLoginData::SetAccountName(CString accountName)
{
	m_strAccountName=accountName;
}

void CLoginData::SetPassword(CString password)
{
	m_strPassword=password;
}

CString	CLoginData::GetServiceName()
{
	return m_strServiceName;
}

CString	CLoginData::GetServiceIP()
{
	return m_strServiceIP;
}

CString	CLoginData::GetAccountName()
{
	return m_strAccountName;
}

CString	CLoginData::GetPassword()
{
	return m_strPassword;
}

CString CLoginData::GetPassport()
{
	if (m_bServerVerify)
	{
		//Œ¥ µœ÷
		return "";
	}
	else
	{
		return g_strPassport;
	}
}

BOOL CLoginData::IsTomServer()
{
	return m_bTomServer;
}
