#pragma once

class CServerMgr
{
public:
	CServerMgr(void);
	~CServerMgr(void);

	static bool LoadServerInfo();
	static void FreeServerInfo();

	static CString GetServerName(DWORD index);
	static CString GetServerIP(DWORD index);
	static CString GetServerIP(CString strServerName);
	static BOOL IsServerNeedVerify(CString strServerName);
	static BOOL IsTomServer(CString strServerName);

private:
	struct sServerInfo
	{
		CString strServerName;
		CString strServerIP;
		BOOL bServerVerify;
		BOOL bTomServer;
	};
	static CList<sServerInfo*,sServerInfo*> m_ServerInfoList;
};
