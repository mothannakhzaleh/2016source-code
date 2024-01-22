#pragma once

class CPlayer;

class CPlayerOption
{
public:
	CPlayerOption(CPlayer *player);
	~CPlayerOption(void);
	
	bool Run();
	void ResetAll();

	void SetDropTest_GateServer(bool bDrop);
	void SetDropTest_AccountServer(bool bDrop);
	void SetDropTest_GameServer(bool bDrop);
	void SetAutoMove(bool bMove);
	void SetAutoTele(bool bTele);

	bool IsDropTest_GateServer();
	bool IsDropTest_AccountServer();
	bool IsDropTest_GameServer();
	bool IsAutoMove();
	bool IsAutoTele();
	bool IsAutoAutoGainPlayerCount();


private:
	CPlayer *m_pPlayer;
	bool m_bAutoDrop_TestGateServer;
	bool m_bAutoDrop_TestAccountServer;
	bool m_bAutoDrop_TestGameServer;
	bool m_bAutoMove;
	bool m_bAutoTele;
	bool m_bAutoGainPlayerCount;
	DWORD m_dwLastMoveTick;
	DWORD m_dwLastTeleTick;
	DWORD m_dwLastGainPlayerCountTick;
};
