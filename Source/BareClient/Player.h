#pragma once

#include "RoleList.h"
#include "KopMap.h"
#include "PlayerOption.h"
#include "RoleMgr.h"
#include "CommandMgr.h"
#include "PlayerMessage.h"
#include "ChatMgr.h"
#include "afxmt.h"


class CLoginData;
class CGameThread;

class CPlayer
{
public:
	enum eLoginState
	{
		eFREE,eSTART_THREAD,
		eLOGIN_GROUP,eLOGIN_HANDSHAKE, eLOGON_GROUP,eLOGIN_ACCOUNT,eLOGON_ACCOUNT,eLOGIN_GAME,eLOGON_GAME,
		eERROR_GROUP,eERROR_ACCOUNT,eERROR_TIMEOUT,eERROR,
		eDISCONNECTING,eDISCONNECTED,eRESTART_LOGIN,
		eCREATE_CHAR_BEGIN,eCREATE_CHAR_END,eCREATE_CHAR_ERROR,
		eDELETE_CHAR_BEGIN,eDELETE_CHAR_END,eDELETE_CHAR_ERROR,
		eCREATE_PASSWORD2_BEGIN,eCREATE_PASSWORD2_END,eCREATE_PASSWORD2_ERROR
	};

	CPlayer();
	~CPlayer();

	bool StartRun();
	bool StopRun();

	//Corresponding to the serial number of the login List, reusable
	void SetIndex(int nIndex);
	int GetIndex();

	CGameThread* GetPlayerGameThread();

public:
	void SetLoginState(eLoginState state,DWORD WaitMillisecond=500);
	void RemovePlayerGameThread();
	void SetRoleCount(int nCount);
	void SetMainRoleIndex(int nIndex);
	void SetTotalPlayerCount(DWORD nIndex);				//Set the number of game server players
	void SetTotalPlayerCount(CString str);				//Set the number of game server players by the string returned by the GM command


	DWORD GetTotalPlayerCount();				//Get the number of game server players
	CPlayerMessage& GetPlayerMessages();
	CLoginData* GetLoginData();
	eLoginState GetLoginState();
	CString GetLoginStateInfo();
	CRoleList& GetRoleFormList(int n);
	CRoleList& GetMainRole();
	CRoleMgr& GetRoleMgr();
	CCommandMgr& GetCommandMgr();
	CPlayerOption& GetOption();
	CKopMap& GetMap();
	CChatMgr& GetChatMgr();
	int GetRoleCount();
	int GetMainRoleIndex();

	bool m_is_new_account;

private:
	struct sLoginState{eLoginState eState;CString strInfo;};
	static const sLoginState m_sLoginStateList[];
	int m_nIndex;
	DWORD m_dwID;
	CLoginData *volatile m_pLoginData;
	CGameThread* m_pGameThread;
	CMutex m_MUTEX_FOR_GameThread;
	eLoginState m_LoginState;
	int m_nMainRoleIndex;
	int m_nRoleCount;
	
	CRoleList m_RoleList[ROLE_LIST_MAXNUM];
	CRoleMgr m_RoleMgr;
	CKopMap m_Map;
	CPlayerOption m_Option;
	CCommandMgr m_CommandMgr;
	CPlayerMessage m_PlayerMessages;
	CChatMgr m_ChatMgr;
	volatile DWORD m_dwTotalPlayerCount;
};
