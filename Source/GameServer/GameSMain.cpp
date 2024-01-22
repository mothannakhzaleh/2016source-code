// GameServer.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"                           

#include "GameAppNet.h"
#include "GameApp.h"
#include "SystemDialog.h"
#include "Config.h"
#include "GameDB.h"
#include "PrivilegeCheck.h"
#include "LicenseManager.h"
//#include "ErrorHandler.h"
#include "SehException.h"
#ifdef XTRAP_S
#include "Xtrap_S_Interface.h"
unsigned char g_XTrapMap[CSFLIE_NUM][XTRAP_CS4_BUFSIZE_MAP];
#endif
//#pragma comment( linker, "/subsystem:\"windows\" /entry:\"mainCRTStartup\"" ) // ������ڵ�ַ 

extern BOOL GameServer_Begin(const char* configName);
extern void GameServer_End();
BOOL       g_bGameEnd = FALSE;
CGameApp*  g_pGameApp = NULL;
//std::string g_strLogName = "GameServerLog";
HANDLE     hGameT;

void DisableCloseButton();
void AppExit(void);

void InitCom()
{
    //CoInitialize(0);
}

void UninitCom()
{
    //CoUninitialize();
}

#ifdef XTRAP_S
bool ServerStart()
{
	DWORD dwRet = 0;
	FILE *fi;

	fi = fopen("Map.cs3","rb");
	if( fi == NULL )
		return false;
	memset( g_XTrapMap,0, sizeof(g_XTrapMap));
	fread( g_XTrapMap[0], XTRAP_CS4_BUFSIZE_MAP, 1, fi );
	fclose(fi);
	
	XTrap_S_LoadDll();
	XTrap_S_Start( 600, 1, g_XTrapMap, NULL);

	return true;
}
#endif
int main(int argc, char* argv[])
{
	//SEHTranslator translator;

	//ErrorHandler::Initialize();
	//ErrorHandler::DisableErrorDialogs();

	CResourceBundleManage::Instance("GameServer.loc"); //Add by lark.li 20080304
	SehExceptionBase::InitializeSehTranslator();

	T_B

	InitMessage();

	if (argc >= 2)
	{
		strncpy(szConfigFileN, argv[1], defCONFIG_FILE_NAME_LEN - 1);
		//strncpy_s( szConfigFileN, sizeof(szConfigFileN), argv[1], _TRUNCATE );
		szConfigFileN[defCONFIG_FILE_NAME_LEN - 1] = '\0';
	}

	if (!g_Config.Load(szConfigFileN))
	{
		LG("init", "config init...Fail!\n");
		return FALSE;		
	}
	//Add by sunny.sun 20081114
	//Begin
	if(!PrivilegeCheck::Instance()->Init("GMCmd.txt"))
	{
		LG("init","Load GMCmd.txt...Fail!\n");
		return FALSE;
	}
	//End
	// Add by lark.li 20080730 begin
	char fileName[512];
	int len = (int)strlen(g_Config.m_szLogDir);
	if(len > 0 && g_Config.m_szLogDir[len - 1] == '\\')
        //sprintf(fileName, "%s%s", g_Config.m_szLogDir, "memorymonitor.log");
		_snprintf_s(fileName,sizeof(fileName),_TRUNCATE,"%s%s", g_Config.m_szLogDir, "memorymonitor.log");

	else
		//sprintf(fileName, "%s\\%s", g_Config.m_szLogDir, "memorymonitor.log");
		_snprintf_s(fileName,sizeof(fileName),_TRUNCATE, "%s\\%s", g_Config.m_szLogDir, "memorymonitor.log");


	//pi_Memory m(fileName);
	//m.startMonitor(1);
	// End

#ifdef XTRAP_S
	if( !ServerStart())
		return -1;
#endif 

#ifdef __CATCH	
    LG("init", "Define __CATCH\n");
#endif

	atexit(AppExit);

	char	szPID[32];
	//sprintf(szPID, "%d", GetCurrentProcessId());
	_snprintf_s(szPID,sizeof(szPID),_TRUNCATE, "%d", GetCurrentProcessId());

	std::string	strConsoleT;
	strConsoleT += "[PID:";
	strConsoleT += szPID;
	strConsoleT += "]";

	//strConsoleT += "   ����������ر���Ӧ��Windows���ڣ�ֱ�ӹرձ�����̨�����ᴥ�����̲�����";
	// TODO: add this as .res
	strConsoleT += "[Yatops] GameServer";
    SetConsoleTitle(strConsoleT.c_str());
	DisableCloseButton();
	
	//WinExec("logvwr.exe", SW_SHOW); 
	if(!GameServer_Begin(szConfigFileN)) 
	{
		return 0;
	}
	
	MSG msg;
	while(!g_bGameEnd)
	{
		if( PeekMessage( &msg, NULL, 0U, 0U, PM_REMOVE ) )
		{
			TranslateMessage( &msg );
			DispatchMessage( &msg );
			if(msg.message==WM_QUIT)
			{
				if (!g_bGameEnd)
					g_pGameApp->SaveAllPlayer();
				g_bGameEnd = TRUE;
				break;
			}
		}
		else
		{
			SystemReport(GetTickCount());
			Sleep(50);
		}
	}

	// Add by lark.li 20080730 begin
	//m.stopMonitor();
	//m.wait();
	// End
#ifdef XTRAP_S
	XTrap_S_FreeDll();
#endif
	GameServer_End();
	//LG("init", "��Ϸ��ͼ�������ɹ��˳�\n"); 
	LG("init", "game map server succeed to exit\n"); 

	T_FINAL

	return 0;
}
 



//_DBC_USING
ThreadPool	*l_proc = NULL;
ThreadPool	*l_comm = NULL;

// Add by lark.li 20090112 begin
//ThreadPool* m_mmsproc, * m_mmscomm;	//ͬMMS�������
//ToMMS* g_ToMMS;	//ͬMMS�����Ӷ��������������ƣ�
// End

extern DWORD WINAPI g_GameLogicProcess(LPVOID lpParameter);
BOOL GameServer_Begin(const char* configName)
{T_B
	//MONITOR

	_setmaxstdio(2048);

	//LG("init", "��Ϸ��ͼ������[%s]����...\n", g_Config.m_szName);
	LG("init", "game map server [%s] startup...\n", g_Config.m_szName);

	g_pGameApp = new CGameApp();
	if(!g_pGameApp->Init())
	{
		//LG("init", "GameApp ��ʼ��ʧ��, �˳�!\n");
		LG("init", "GameApp initialization failed, exit!\n");
		return FALSE;
	}
	
    TcpCommApp::WSAStartup();
    l_proc = ThreadPool::CreatePool(8, 8, 512);
    l_comm = ThreadPool::CreatePool(8, 8, 512);//,THREAD_PRIORITY_ABOVE_NORMAL);

	g_gmsvr	= new GameServerApp(l_proc, l_comm);

    // ���� GateServer �����߳�
   // LG("init", "����Gate�����������߳�...\n");
	 LG("init", "startup Gate server connect thread...\n");
    l_comm->AddTask(new ConnectGateServer(g_gmsvr));

    //���Ӳ�����TradeServer
	//LG("init", "������Ϣ�����������߳�...\n");
	LG("init", "startup information server connect thread...\n");
    l_comm->AddTask(new ToTradeServer(g_gmsvr));
	
	// Add by lark.li 20090112 begin
	//m_mmsproc = ThreadPool::CreatePool(1, 2, 24, THREAD_PRIORITY_NORMAL);
	//m_mmscomm = ThreadPool::CreatePool(2, 4, 56, THREAD_PRIORITY_ABOVE_NORMAL);
	//g_ToMMS = new ToMMS(configName, m_mmsproc, m_mmscomm);
	//m_mmsproc->AddTask(new ConnectMMS(g_ToMMS));
	// End

	// ������Ϸ�߳�
	//LG("init", "������Ϸ�߳�...\n");
	LG("init", "startup game thread...\n");
	DWORD	dwThreadID;
	hGameT = CreateThread(NULL, 0, g_GameLogicProcess, 0, 0, &dwThreadID);
	LG("init", "Game Thread ID = %d\n", dwThreadID);
	//

	//LG("init",  "��ʼ����Win32 ���ƶԻ���\n");
	LG("init",  "start create Win32 control dialog box\n");
	HINSTANCE hInst = GetModuleHandle(0);
	CreateMainDialog(hInst, NULL);

	//Log("����", "GameServer����", g_Config.m_szMapList[0], "", "", "");
	Log("restart", "GameServer restart", g_Config.m_szMapList[0], "", "", "");
	
	return TRUE;
T_E}


void GameServer_End()
{T_B
	//LG("init", "��ʼ������Ϸ��ͼ������\n");
	LG("init", "start to exit game map server\n");
	//GameServerLG(g_strLogName.c_str(), "GameServer End!\n");
	CloseHandle(hGameT);

	// �����Ϣ
	MONITOR_DUMP

	HWND hConsole = GetConsoleWindow();
	if(hConsole)
	{
		SendMessage(hConsole, WM_CLOSE, 0, 0);
	}
	
	Sleep(400);

	SAFE_DELETE(g_pGameApp);

	delete g_gmsvr;

	// Add by lark.li 20090112 begin
	//delete g_ToMMS;
	//m_mmsproc->DestroyPool();
	//m_mmscomm->DestroyPool();
	// End

	l_comm->DestroyPool();
	l_proc->DestroyPool();

	TcpCommApp::WSACleanup();

T_E}

typedef HWND (*LPGETCONSOLEWINDOW)(void);
void DisableCloseButton()
{
	HMODULE hMod = LoadLibrary("kernel32.dll");

	LPGETCONSOLEWINDOW lpfnGetConsoleWindow =
		(LPGETCONSOLEWINDOW)GetProcAddress(hMod, "GetConsoleWindow");

	HWND hWnd = lpfnGetConsoleWindow();
	HMENU hMenu = GetSystemMenu(hWnd, FALSE);
	if (hMenu != NULL)
	{
		EnableMenuItem(hMenu, SC_CLOSE, MF_BYCOMMAND | MF_GRAYED);
	}

	FreeLibrary(hMod);
}

void AppExit(void)
{
	//int	*p = NULL;
	// *p = 1;
}

/*
 GameServer���

 GameServer������Ϸ�߼��Ĵ���

 ��������Ҫģ���� 
 
[GameData]
������������ 
Map        ��ͼ 
MgrUnit    ��ͼ������Ԫ
Player     ���
Character  ��ɫ
Item       ����
Skill      ����
SkillState ����״̬
Mission    ����

 
GameDataӦ�õ�������Ϊ��������

[GameControl]
App       Ӧ�ó����� 
TimerMgr  ��ʱ������
AI        AI����

[EventHandler] �¼�������

GameServer��������ʽΪ 

��GameControl����Ӧ�ó���, ����AI��ʱ��, ������ײ��ⶨʱ��

GameControl �� EventHandler ����Event, ����AI�¼�, ����ת����ײ
�ͻ��� �� EventHandler ����Event, ������������, ����ʹ�ü���, ����ʹ�õ���

EventHandler��Event�Ĵ���ΪӦ��ʽ, ����ʱ���ؽ��, ���κ��м�״̬

EventHandler�ڶ�Event�Ĵ���������, ����Modify GameData�Ĳ���

��ʱEventHandler���ڷ������ڲ��߼������Կͻ��˵����� ����Ϊһ��˫���ͷ, ������
Ψһ�Ľ��Modify GameData


Control -> Event 
 





*/


