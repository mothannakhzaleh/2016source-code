#pragma once

#include "CommRPC.h"
#include "PacketQueue.h"

class CPlayer;
class CNetIF;

class CGameThread : public dbc::PKQueue
{
public:
	CGameThread(CPlayer *player);
	~CGameThread(void);

	void SetThreadID(DWORD id);
	void SetThreadHandle(HANDLE handle);

	DWORD GetThreadID();
	HANDLE GetThreadHandle();

	static DWORD WINAPI Run(LPVOID lpParm);
	int ThreadBegin();
	void ThreadRun();
	int ThreadEnd();

	CNetIF *GetNetIF();

private:
	bool IsReadyToQuit( IN CONST MSG *lpMsg );
	bool CheckLogin();
	void OnProcessMsg( IN CONST MSG *lpMsg );
	void OnDisconnect(int reason);
	virtual void ProcessData(dbc::DataSocket *datasock,dbc::RPacket& recvbuf);


private:
	CPlayer* m_pPlayer;
	HANDLE m_hThreadHandle;
	DWORD m_dwThreadID;
	CNetIF* m_pNet;
	DWORD m_dwWaitForConnectTicks;
	static CCriticalSection m_Critical_SingleLogin;
	bool m_bExitFlag;
};
