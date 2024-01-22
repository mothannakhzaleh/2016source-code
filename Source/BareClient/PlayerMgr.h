#pragma once


class CPlayer;

class CPlayerMgr
{
public:
	CPlayerMgr(void);
	~CPlayerMgr(void);
	static CPlayer *AddPlayer(CString service,CString accountName,CString password,WORD nRole);
	static bool RemovePlayer(int nIndex);
	static void DeletePlayers(int index[],int indexArraySize);
	static void DeleteAllPlayers();
	static int GetTotalPlayers();
	static bool SetMainPlayer(CPlayer *player);
	static bool SetMainPlayer(int index);

	static CPlayer *GetFirstPlayer();
	static CPlayer *GetNextPlayer();
	static CPlayer *GetMainPlayer();
	static bool FindPlayer(CPlayer *player);

private:
	static CList<CPlayer*,CPlayer*> m_PlayersList;
	static POSITION m_Position;
	static CPlayer *m_pMainPlayer;
};