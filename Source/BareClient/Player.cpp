#include "StdAfx.h"
#include "BKop.h"
#include "LoginData.h"
#include "LoginPage.h"
#include "MainFrm.h"
#include "GameThread.h"
#include "Player.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

const CPlayer::sLoginState CPlayer::m_sLoginStateList[]=
{
	//{	eERROR_GAME					,	"Failed to log in to the game server"			},
	{	eFREE						,	"Free"											},
	{	eSTART_THREAD				,	"Start thread"									},
	{	eLOGIN_GROUP				,	"Logging into group server"						},
	{   eLOGIN_HANDSHAKE            ,   "Performing RSA handshake"      				},
	{	eLOGON_GROUP				,	"Login to group server successfully"			},
	{	eLOGIN_ACCOUNT				,	"Logging in to account server"		 			},
	{	eLOGON_ACCOUNT				,	"Sucessfully logged into account server"		},
	{	eLOGIN_GAME					,	"Logging into game server"						},
	{	eLOGON_GAME					,	"Login to game server successfully" 			},
	{	eERROR_GROUP				,	"Login group servef failed"						},
	{	eERROR_ACCOUNT				,	"Failed to login account server"				},
	{	eERROR_TIMEOUT				,	"Login timed out"								},
	{	eERROR						,	"Error found"									},
	{	eDISCONNECTING				,	"Disconnecting"									},
	{	eDISCONNECTED   			,	"The connection has been disconnected"			},
	{	eRESTART_LOGIN				,	"Preparing to reconnect"						},
	{	eCREATE_CHAR_BEGIN			,	"Creating character"							},
	{	eCREATE_CHAR_END			,	"Create character successfully"					},
	{	eCREATE_CHAR_ERROR			,	"Failed to create character"					},
	{	eDELETE_CHAR_BEGIN			,	"Deleting character"							},
	{	eDELETE_CHAR_END			,	"Delete character successfully"					},
	{	eDELETE_CHAR_ERROR			,	"Failed to delete character"					},
	{	eCREATE_PASSWORD2_BEGIN		,	"Creating 2nd Password"							},
	{	eCREATE_PASSWORD2_END		,	"Successfully created 2nd Password"				},
	{	eCREATE_PASSWORD2_ERROR		,	"Failed to create 2nd Password"					}
};


#pragma warning(disable: 4355)	//warning C4355: 'this' : used in base member initializer list
CPlayer::CPlayer() : m_PlayerMessages(this),m_Option(this), m_RoleMgr(this), m_CommandMgr(this), m_ChatMgr(this)
{
	m_pLoginData=new CLoginData();
	m_pGameThread=NULL;
	m_LoginState=eFREE;
	m_nIndex=-1;
	m_nMainRoleIndex=-1;
	m_nRoleCount=0;
	m_dwTotalPlayerCount=0;
	m_is_new_account = false;
}

CPlayer::~CPlayer()
{
	StopRun();
	SAFE_DELETE(m_pLoginData);
	SAFE_DELETE(m_pGameThread);
}

void CPlayer::SetIndex(int nIndex)
{
	m_nIndex=nIndex;
}

int CPlayer::GetIndex()
{
	return m_nIndex;
}

CLoginData* CPlayer::GetLoginData()
{
	return m_pLoginData;
}

void CPlayer::SetLoginState(eLoginState state,DWORD WaitMillisecond)
{
	m_LoginState=state;
	//((CMainFrame*)theApp.m_pMainWnd)->GetLoginPage()->PostMessage(THREAD_MSG_REFRESH_STATE,0,(LPARAM)this);
	Sleep(WaitMillisecond);
}

CGameThread* CPlayer::GetPlayerGameThread()
{
	return m_pGameThread;
}

void CPlayer::RemovePlayerGameThread()
{
	//CSingleLock singleLock(&m_MUTEX_FOR_GameThread);
	//singleLock.Lock(3000);
	//SAFE_DELETE(m_pGameThread);
	//singleLock.Unlock();
}

CPlayer::eLoginState CPlayer::GetLoginState()
{
	return m_LoginState;
}

CString CPlayer::GetLoginStateInfo()
{
	int n=sizeof(m_sLoginStateList)/sizeof(m_sLoginStateList[0]);
	for (int i=0;i<n;i++)
	{
		if (m_sLoginStateList[i].eState==m_LoginState)
		{
			return m_sLoginStateList[i].strInfo;
		}
	}
	return "unknown status";
}

CRoleList& CPlayer::GetRoleFormList(int n)
{
	if (n<0 || n>=ROLE_LIST_MAXNUM)
	{
		ASSERT(false);
	}
	return m_RoleList[n];
}

void CPlayer::SetMainRoleIndex(int nIndex)
{
	if (nIndex<0 || nIndex>=ROLE_LIST_MAXNUM)
	{
		ASSERT(false);
	}
	m_nMainRoleIndex=nIndex;
}

int CPlayer::GetMainRoleIndex()
{
	return m_nMainRoleIndex;
}

CRoleList& CPlayer::GetMainRole()
{
	if (m_nMainRoleIndex<0 || m_nMainRoleIndex>=ROLE_LIST_MAXNUM)
	{
		ASSERT(false);
	}
	return m_RoleList[m_nMainRoleIndex];
}

bool CPlayer::StartRun()
{
	if (GetLoginState()!=eFREE) return true;
	//CSystemInfo::AddDetailDebugInfo(GetIndex(),"Preparing to create thread...");
	GetPlayerMessages().AddDebugMsg("Preparing to create thread...");
	SAFE_DELETE(m_pGameThread);
	m_pGameThread=new CGameThread(this);
	SetLoginState(eSTART_THREAD,0);
	DWORD id;
	HANDLE handle=CreateThread(NULL,0,CGameThread::Run,m_pGameThread,0,&id);
	if (!handle)
	{
		//CSystemInfo::AddDetailDebugInfo(GetIndex(),"thread creation failed!");
		GetPlayerMessages().AddDebugMsg("thread creation failed!");
		return false;
	}
	SetThreadPriority(handle,THREAD_PRIORITY_BELOW_NORMAL);
	//CString str;
	//str.Format("Index=%d  ->  ThreadID=%d",GetIndex(),id);
	//CSystemInfo::AddDetailDebugInfo(0,str);
	m_pGameThread->SetThreadHandle(handle);
	m_pGameThread->SetThreadID(id);
	return true;
}

bool CPlayer::StopRun()
{
	//CSingleLock singleLock(&m_MUTEX_FOR_GameThread);
	//singleLock.Lock();
	if (!GetPlayerGameThread()) return true;
	//CSystemInfo::AddDebugInfo(GetIndex(),"Ending game...");
	GetPlayerMessages().AddDebugMsg("Ending game...");
	PostThreadMessage(GetPlayerGameThread()->GetThreadID(),WM_QUIT,0,NULL);
	MSG msg;
	while (WaitForSingleObject(GetPlayerGameThread()->GetThreadHandle(),50)==WAIT_TIMEOUT)
	{
		while(PeekMessage(&msg,NULL,0U,0U,PM_REMOVE))
		{
			if (msg.message==THREAD_MSG_ADD_SYSTEM_MESSAGE || msg.message==WM_PAINT)
			{
				TranslateMessage(&msg);
				DispatchMessage(&msg);
			}
		}
	}
	return true;
}

void CPlayer::SetRoleCount(int nCount)
{
	m_nRoleCount=nCount;
}

int CPlayer::GetRoleCount()
{
	return m_nRoleCount;
}

CKopMap& CPlayer::GetMap()
{
	return m_Map;
}

CPlayerOption& CPlayer::GetOption()
{
	return m_Option;
}

CRoleMgr& CPlayer::GetRoleMgr()
{
	return m_RoleMgr;
}

CCommandMgr& CPlayer::GetCommandMgr()
{
	return m_CommandMgr;
}

CPlayerMessage& CPlayer::GetPlayerMessages()
{
	return m_PlayerMessages;
}

CChatMgr& CPlayer::GetChatMgr()
{
	return m_ChatMgr;
}

void CPlayer::SetTotalPlayerCount(DWORD nIndex)
{
	m_dwTotalPlayerCount=nIndex;
}

DWORD CPlayer::GetTotalPlayerCount()
{
	return m_dwTotalPlayerCount;
}

void CPlayer::SetTotalPlayerCount(CString str)
{
	if (str.IsEmpty() && !str.Find("Current Login/Game Players:")) return;
	int nCut=str.ReverseFind('/');
	if (nCut<22) return;
	nCut=str.GetLength()-nCut-1;
	if (nCut<=0 || nCut>8) return;
	CString strNum=str.Right(nCut);
	DWORD n=(DWORD)atol(strNum);
	if (n>10000000) n=0;
	SetTotalPlayerCount(n);
}
