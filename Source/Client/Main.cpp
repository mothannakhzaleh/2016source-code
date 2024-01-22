//------------------------------------------------------------------------
//	2005.3.25	Arcol	�����ַ���Ϊ�й���½����
//------------------------------------------------------------------------

// MPTest.cpp : Defines the entry point for the application.
//
#include "stdafx.h"

#include <iostream>
#include <sys/types.h>
#include <sys/stat.h>
//#define WIN32_LEAN_AND_MEAN
#include <Windows.h>
#include <Wingdi.h>

#include "Main.h"
#include "GameApp.h"
#include "SceneObjFile.h"
#include "UIImeinput.h"
#include "GameConfig.h"
#include "PacketCmd.h"
#include "UIsystemform.h"
#include "EffectObj.h"
#include "Lua_Platform.h"
#include "packfile.h"
#include "loginscene.h"
#include "d3des.h"
#include "Character.h"
#include "gameloading.h"
#include "SehException.h"
//#include "CallStack.h"
#include "CPerformance.h"
#include "CaLua.h"
#include "GameErrorReport.h"
#pragma warning(disable : 4311) //type cast warning
string g_serverset;

#ifdef _XTRAP_

#if(defined _MT)
#if(defined _DLL)
#pragma comment(lib, "XTrap4Client_mtDll")
#pragma comment(lib, "XTrap4Client_ClientPart_mtDll")
#pragma comment(lib, "XTrap_Unipher_mtDll")
#else
#pragma comment(lib, "XTrap4Client_mt")
#pragma comment(lib, "XTrap4Client_ClientPart_mt")
#pragma comment(lib, "XTrap_Unipher_mt")
#endif
#else
#pragma comment(lib, "XTrap4Client_st")
#pragma comment(lib, "XTrap4Client_ClientPart_st")
#pragma comment(lib, "XTrap_Unipher_st")
#endif
#include "Xtrap_C_Interface.h"

#endif

#define MAX_LOADSTRING 100

// Global Variables:
HINSTANCE hInst;						 // current instance
TCHAR	  szTitle[MAX_LOADSTRING];		 // The title bar text
TCHAR	  szWindowClass[MAX_LOADSTRING]; // the main window class name

// Forward declarations of functions included in this code module:
ATOM			 MyRegisterClass(HINSTANCE hInstance, HBRUSH brush);
HWND			 InitInstance(HINSTANCE, int);
LRESULT CALLBACK WndProc(HWND, UINT, WPARAM, LPARAM);

HBRUSH g_bk_brush;

void StdoutRedirect();
int	 InstallFont(const char* pszPath); // ���尲װ
void CenterWindow(HWND hWnd);		   //����λ������

bool g_IsAutoUpdate	 = false; // ���Ҫ�Զ�����ʱ��Ҫ�ȴ������˳�ʱ�����Զ�����
long g_nCurrentLogNo = 0;

////////////////////////////////////////
//
//  By Jampe
//  �����̽��ܹ���
//  2006/5/22
//
const unsigned char key[] = {0xda, 0x15, 0x1c, 0x10, 0x4f, 0x8c, 0x7a, 0x4a};

DWORD WINAPI LoadRes(LPVOID lpvThreadParam) // ����Դ
{
  g_bLoadRes = 1;

  return 0;
}

HINSTANCE	 g_hInstance;
int APIENTRY _tWinMain(HINSTANCE hInstance,
					   HINSTANCE hPrevInstance,
					   LPTSTR	 lpCmdLine,
					   int		 nCmdShow)
{
#ifdef _XTRAP_
  CHAR szArg[] = "660970B4CA69D8148D326D9844CFE862E90DBF142D2D0AAA09926DB877AF45071DF9E4711FBFEA32C17329946C38DB39329DD458808E76E1983652DDB65D54250F7D04245246E41FB1670C4E95407619E96980387320B6505436FCED87B1E5752B8C7C7C";
  XTrap_C_Start((LPCSTR)szArg, NULL);
#endif

  SehExceptionBase::InitializeSehTranslator();
#ifdef __MEM_DEBUG__
  InitMemoryCheck();
#endif
#ifdef __FPS_DEBUG__
  CPerformance::InitPerformance();
#endif
  CResourceBundleManage::Instance("Game.loc"); //Add by lark.li 20080130

  DWORD dx_ver = DX_VERSION_X_X;

  
	  string strParam = lpCmdLine;

//�༭��������ͻ���ͨ�� by Waiting 2009-06-18
#ifdef __EDITOR__
  //	if(strParam.find("editor")!=-1) // ������Ϸ�༭��
  {
	g_Config.m_bEditor		 = TRUE;
	g_Config.m_IsShowConsole = true;
  }
#else
  //  else
  {
	g_Config.m_bEditor		= FALSE;
	g_Config.m_nCreateScene = 0;
  }
#endif //__EDITOR__

  g_hInstance = hInstance;

  //������ҵ��Զ�����Ļ����
  if(!g_stUISystem.m_isLoad)
  {
	g_stUISystem.LoadCustomProp(); //��ȡϵͳ���ò�Ӧ��
  }

  // Add by lark.li 20080730 begin
  //	pi_Memory m("memorymonitor.log");
  //	m.startMonitor(1);
  // End

  //  ��ʾloading����
  //GameLoading::Init(strParam)->Create();

  ::_setmaxstdio(2048); //   ���������ļ���

  //setlocale(LC_CTYPE, g_oLangRec.GetString(0)); // �Ĵ��ַ�����Դ�ļ����ȡ  Add by Philip.Wu  2006-07-19
  setlocale(LC_CTYPE, RES_STRING(CL_LANGUAGE_MATCH_0)); // �Ĵ��ַ�����Դ�ļ����ȡ  Add by Philip.Wu  2006-07-19

  InstallFont(".\\Font"); // �Զ���װ���� Add by Philip.Wu  2006-08-07

  if(CheckDxVersion(dx_ver) == 0)
  {
	MessageBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_187), "error", MB_OK);
	return 0;
  }

  // ����ͻ���ʹ�ò�ͬ��log�ļ���
  HANDLE hFile = CreateFileMapping(INVALID_HANDLE_VALUE, 0, PAGE_READWRITE, 0, sizeof(long), "KopClinetNO");
  if(!hFile)
  {
	int ret = GetLastError();
	switch(ret)
	{
	case ERROR_FILE_INVALID: //�����ͼ����һ���㳤�ȵ��ļ�ӳ��, Ӧ�д˱�
	  MessageBox(NULL, "FileMapping ERROR_FILE_INVALID", "error", MB_OK);
	  break;
	case ERROR_INVALID_HANDLE: //���������������ڴ�ռ�����е��ڴ�ӳ��, ������, �ź���, �ٽ���ͬ��
	  MessageBox(NULL, "FileMapping ERROR_INVALID_HANDLE", "error", MB_OK);
	  break;
	case ERROR_ALREADY_EXISTS: //�ڴ�ռ������Ѿ�����
	  MessageBox(NULL, "FileMapping ERROR_ALREADY_EXISTS", "error", MB_OK);
	  break;
	}
	return 0;
  }

  LGInfo lg_info;
  memset(&lg_info, 0, sizeof(lg_info));

  if(!g_Config.IsPower()) // ���Ǳ༭��ģʽʱlog�ر�
  {
	lg_info.bCloseAll = true;
  }

  long* pClientLogNO = NULL;
  pClientLogNO		 = (long*)MapViewOfFile(hFile, FILE_MAP_WRITE, 0, 0, 0);
  g_nCurrentLogNo	 = *pClientLogNO;
  (*pClientLogNO)++;
  if(g_nCurrentLogNo > 0)
  {
	//sprintf(lg_info.dir, "%s%d", "log", g_nCurrentLogNo);
	_snprintf_s(lg_info.dir, sizeof(lg_info.dir), _TRUNCATE, "%s%d", "log", g_nCurrentLogNo);
  } else
  {
	//sprintf(lg_info.dir, "%s", "log" );
	_snprintf_s(lg_info.dir, sizeof(lg_info.dir), _TRUNCATE, "%s", "log");
  }

  lg_info.bEnableAll = g_Config.m_bEnableLG != 0;
  lg_info.bMsgBox	 = g_Config.m_bEnableLGMsg != 0;
  lg_info.bEraseMode = true;

  // ɾ���Զ����³���ĸ���
  char szUpdateFileName[] = "kop_d.exe";
  SetFileAttributes(szUpdateFileName, FILE_ATTRIBUTE_NORMAL); //  �����Զ����¸���������
  DeleteFile(szUpdateFileName);

  // for trim obj file
  short i = 1;
  short j = i << 14;
  /*char * buff = NULL;*/
  _strlwr_s(lpCmdLine, strlen(lpCmdLine) + 1);
  if(_tcsstr(lpCmdLine, _TEXT("-objtrim+backup")) != NULL)
  //if (_tcsstr(_tcslwr_s(lpCmdLine,sizeof(lpCmdLine)), _TEXT("-objtrim+backup")) != NULL)
  {
	g_ObjFile.TrimDirectory("map", true);
	return 0;
  } else if(_tcsstr(lpCmdLine, _TEXT("-objtrim")) != NULL)
  //else if (_tcsstr(_tcslwr_s(lpCmdLine,sizeof(lpCmdLine)), _TEXT("-objtrim")) != NULL)
  {
	g_ObjFile.TrimDirectory("map", false);
	return 0;
  }

  MSG	 msg;
  HACCEL hAccelTable;

  HBRUSH brush = CreateSolidBrush(RGB(0, 0, 0));

  // Initialize global strings
  LoadString(hInstance, IDS_APP_TITLE, szTitle, MAX_LOADSTRING);
  LoadString(hInstance, IDC_KOP, szWindowClass, MAX_LOADSTRING);

  MyRegisterClass(hInstance, brush);						   // ע�ᶨ�����
  hAccelTable = LoadAccelerators(hInstance, (LPCTSTR)IDC_KOP); // ���ؿ�ݼ��� ��ñ����
  if(strParam.find("pack") != -1)
  {
	char* pszPos = lpCmdLine;
	pszPos += 4;
	while(*pszPos == ' ')
	{
	  pszPos++;
	}
	char pszpath[128];
	char pszFile[128];
	//sprintf(pszpath,"texture\\minimap\\%s",pszPos);
	//sprintf(pszFile,"texture\\minimap\\%s\\%s.pk",pszPos,pszPos);
	_snprintf_s(pszpath, 128, _TRUNCATE, "texture\\minimap\\%s", pszPos);
	_snprintf_s(pszFile, 128, _TRUNCATE, "texture\\minimap\\%s\\%s.pk", pszPos, pszPos);

	CMiniPack pkfile;
	if(pkfile.SaveToPack(pszpath, pszFile))
	  LG("ok", RES_STRING(CL_LANGUAGE_MATCH_188), pszPos);
	else
	  LG("ok", RES_STRING(CL_LANGUAGE_MATCH_189), pszPos);
	return 0;
  }

#if !defined(__FPS_DEBUG__) && !defined(_DEBUG)
  if(strParam.find("startgame") == -1)
  {
	LG("Error", RES_STRING(CL_LANGUAGE_MATCH_190));
	return 0;
  }
#endif

	g_serverset = "scripts/txt/server.tx";

#ifdef _LUA_GAME
  InitLuaPlatform();
#endif

#ifdef __FPS_DEBUG__
  LETimer t;
  t.Begin();
#endif
  g_pGameApp = new CGameApp();
  //g_pGameApp->LG_Config( lg_info );

  if(strParam.find("table_bin") != -1) //�����������table_bin �����ɶ����Ʊ�
  {
	extern void MakeBinTable();
	MakeBinTable();
	return FALSE;
  }

  int nScreenMode[2][2] = // ��Ļ��ʾ��ʽ
	  {
		  800, 600,
		  1024, 768};

  g_Config.m_bFullScreen = g_stUISystem.m_sysProp.m_videoProp.bFullScreen;
  int nWidth(0), nHeight(0), nDepth(0);
  if(g_stUISystem.m_sysProp.m_videoProp.bPixel1024)
  {
	nWidth	= 1024;
	nHeight = 768;
  } else
  {
	nWidth	= 800;
	nHeight = 600;
  }
  nDepth = g_stUISystem.m_sysProp.m_videoProp.bDepth32 ? 32 : 16;

  MPD3DCreateParamAdjustInfo cpai;
  cpai.multi_sample_type = (D3DMULTISAMPLE_TYPE)g_Config.m_dwFullScreenAntialias;

  g_Render.SetD3DCreateParamAdjustInfo(&cpai);

  // g_Render.EnableClearTarget(FALSE);
  g_Render.SetBackgroundColor(D3DCOLOR_XRGB(10, 10, 125));

  if(g_Config.m_bFullScreen)
  {
	nWidth	= GetSystemMetrics(SM_CXSCREEN);
	nHeight = GetSystemMetrics(SM_CYSCREEN);
  }

  if(!g_pGameApp->Init(hInstance, szWindowClass, nWidth, nHeight, nDepth, FALSE /*g_Config.m_bFullScreen*/))
  {
	ErrorReport(RES_STRING(CL_LANGUAGE_MATCH_191));
	g_pGameApp->End();
	return 0;
  }

#ifdef _XTRAP_
  XTrap_C_KeepAlive();
#endif

  if(g_Config.m_bFullScreen)
  {
	g_pGameApp->ChangeVideoStyle(nWidth, nHeight, D3DFMT_D16, TRUE);
  }

  //DWORD ThreadID;
  //   HANDLE hThread = ::CreateThread(NULL,0,LoadRes,
  //                             0,0,&ThreadID);

  //g_pGameApp->LoadRes2();

  if(g_Config.m_bEditor) StdoutRedirect();

  //	LG("init", "init use time = %d ms\n", t.End());

  // Main message loop:
  ZeroMemory(&msg, sizeof(msg));

  DWORD st_dwtick	 = GetTickCount();
  DWORD st_tickcount = (GetTickCount() - st_dwtick) / unsigned long(g_NetIF->m_framedelay);

  g_NetIF->m_framedelay = 40; // ֡�ӳ�

  //string str( "Micro" );
  //string rstr( "soft" );
  //str.append( rstr, 14, 3 );

  g_pGameApp->Run();

  // Add by lark.li 20080730 begin
  // 	m.stopMonitor();
  // 	m.wait();
  // End

  g_pGameApp->End();
  SAFE_DELETE(g_pGameApp);

  ::DeleteObject(brush);

  UnmapViewOfFile(pClientLogNO);
  CloseHandle(hFile);
  //	GetRegionMgr()->Exit();
  CLog2Mgr::Exit();

  if(g_IsAutoUpdate) // ���Ҫ�Զ�����ʱ ��ʾԭʼ���� ����kop.exe
  {
	::WinExec("kop.exe", SW_SHOWNORMAL);
  }
  // �Զ�����ʱ �쳣�������
#ifdef __MEM_DEBUG__
  EndMemoryCheck();
  ResMgr.EndMemoryCheck();
  //CLU_EndMemoryCheck();
#endif
  

  if(g_Config.m_bGameBanner)
  {
	STARTUPINFO			si;
	PROCESS_INFORMATION pi;

	ZeroMemory(&si, sizeof(si));
	si.cb = sizeof(si);
	ZeroMemory(&pi, sizeof(pi));

	// Start the child process.
	if(!CreateProcess(NULL,				// No module name (use command line).
					  "GameBanner.exe", // Command line.
					  NULL,				// Process handle not inheritable.
					  NULL,				// Thread handle not inheritable.
					  FALSE,			// Set handle inheritance to FALSE.
					  0,				// No creation flags.
					  NULL,				// Use parent's environment block.
					  NULL,				// Use parent's starting directory.
					  &si,				// Pointer to STARTUPINFO structure.
					  &pi)				// Pointer to PROCESS_INFORMATION structure.
	)
	{
	  printf("CreateProcess failed (%d).\n", GetLastError());
	  return 0;
	}

	// Wait until child process exits.
	//WaitForSingleObject( pi.hProcess, INFINITE );

	// Close process and thread handles.
	CloseHandle(pi.hProcess);
	CloseHandle(pi.hThread);
  }
  return 0;
}

//
//  FUNCTION: MyRegisterClass()
//
//  PURPOSE: Registers the window class.
//
//  COMMENTS:
//
//    This function and its usage are only necessary if you want this code
//    to be compatible with Win32 systems prior to the 'RegisterClassEx'
//    function that was added to Windows 95. It is important to call this function
//    so that the application will get 'well formed' small icons associated
//    with it.
//
ATOM MyRegisterClass(HINSTANCE hInstance, HBRUSH brush)
{
  WNDCLASSEX wcex;

  wcex.cbSize = sizeof(WNDCLASSEX);

  wcex.style		 = CS_HREDRAW | CS_VREDRAW;
  wcex.lpfnWndProc	 = (WNDPROC)WndProc;
  wcex.cbClsExtra	 = 0;
  wcex.cbWndExtra	 = 0;
  wcex.hInstance	 = hInstance;
  wcex.hIcon		 = LoadIcon(hInstance, (LPCTSTR)IDI_KOP);
  wcex.hCursor		 = NULL;
  wcex.hbrBackground = (HBRUSH)brush; //(HBRUSH)(COLOR_BACKGROUND+1);
  wcex.lpszMenuName	 = (LPCTSTR)IDC_KOP;
  wcex.lpszClassName = szWindowClass;
  wcex.hIconSm		 = LoadIcon(wcex.hInstance, (LPCTSTR)IDI_SMALL);

  return RegisterClassEx(&wcex);
}

//
//   FUNCTION: InitInstance(HANDLE, int)
//
//   PURPOSE: Saves instance handle and creates main window
//
//   COMMENTS:
//
//        In this function, we save the instance handle in a global variable and
//        create and display the main program window.
//
HWND InitInstance(HINSTANCE hInstance, int nCmdShow)
{
  HWND hWnd;

  hInst = hInstance; // Store instance handle in our global variable

  hWnd = CreateWindow(szWindowClass, szTitle, WS_OVERLAPPEDWINDOW,
					  CW_USEDEFAULT, 0, CW_USEDEFAULT, 0, NULL, NULL, hInstance, NULL);

  if(!hWnd)
  {
	return 0;
  }

  ShowWindow(hWnd, nCmdShow);
  UpdateWindow(hWnd);

  return hWnd;
}

//
//  FUNCTION: WndProc(HWND, unsigned, WORD, LONG)
//
//  PURPOSE:  Processes messages for the main window.
//
//  WM_COMMAND	- process the application menu
//  WM_PAINT	- Paint the main window
//  WM_DESTROY	- post a quit message and return
//
//

extern void __timer_period_render();

static WNDPROC g_wpOrigEditProc = NULL;
// Subclass procedure
LRESULT APIENTRY EditSubclassProc(
	HWND   hwnd,
	UINT   uMsg,
	WPARAM wParam,
	LPARAM lParam)
{
  if(uMsg == WM_GETDLGCODE)
	return DLGC_WANTALLKEYS;

  switch(uMsg)
  {
  case WM_KEYDOWN:
	if(wParam == VK_UP || wParam == VK_DOWN)
	{
	  WndProc(hwnd, uMsg, wParam, lParam);
	  return 0;
	}
  case WM_CHAR:
  case WM_SYSKEYDOWN:
	WndProc(hwnd, uMsg, wParam, lParam);
	break;
  case WM_SYSKEYUP:
	if(wParam == VK_MENU || wParam == VK_F10)
	{
	  return 0;
	}
	WndProc(hwnd, uMsg, wParam, lParam);
	break;
	//case WM_INPUTLANGCHANGEREQUEST:
	//case WM_INPUTLANGCHANGE:
	//case WM_IME_NOTIFY:
	//case WM_IME_STARTCOMPOSITION:
	//case WM_IME_ENDCOMPOSITION:
	//    {
	//        WndProc( hwnd, uMsg, wParam, lParam);
	//    }
	//    break;
	//case WM_IME_COMPOSITION:
	//case WM_IME_SETCONTEXT:
	//    {
	//        WndProc( hwnd, uMsg, wParam, lParam);
	//        if(g_Config.m_bFullScreen)
	//        {
	//            return 0;
	//        }
	//    }
	//    break;
  }
  return CallWindowProc(g_wpOrigEditProc, hwnd, uMsg, wParam, lParam);
}
/*
string _WMMsgName(UINT uMsg) {
	char szMsg[64] = "";
	switch(uMsg) {
	case WM_NULL                         :strcpy(szMsg, "WM_NULL"                  ); break;
	case WM_CREATE                       :strcpy(szMsg, "WM_CREATE"                ); break;
	case WM_DESTROY                      :strcpy(szMsg, "WM_DESTROY"               ); break;
	case WM_MOVE                         :strcpy(szMsg, "WM_MOVE"                  ); break;
	case WM_SIZE                         :strcpy(szMsg, "WM_SIZE"                  ); break;
	case WM_ACTIVATE                     :strcpy(szMsg, "WM_ACTIVATE"              ); break;
	case WM_SETFOCUS                     :strcpy(szMsg, "WM_SETFOCUS"              ); break;
	case WM_KILLFOCUS                    :strcpy(szMsg, "WM_KILLFOCUS"             ); break;
	case WM_ENABLE                       :strcpy(szMsg, "WM_ENABLE"                ); break;
	case WM_SETREDRAW                    :strcpy(szMsg, "WM_SETREDRAW"             ); break;
	case WM_SETTEXT                      :strcpy(szMsg, "WM_SETTEXT"               ); break;
	case WM_GETTEXT                      :strcpy(szMsg, "WM_GETTEXT"               ); break;
	case WM_GETTEXTLENGTH                :strcpy(szMsg, "WM_GETTEXTLENGTH"         ); break;
	case WM_PAINT                        :strcpy(szMsg, "WM_PAINT"                 ); break;
	case WM_CLOSE                        :strcpy(szMsg, "WM_CLOSE"                 ); break;
	case WM_QUERYENDSESSION              :strcpy(szMsg, "WM_QUERYENDSESSION"       ); break;
	case WM_QUIT                         :strcpy(szMsg, "WM_QUIT"                  ); break;
	case WM_QUERYOPEN                    :strcpy(szMsg, "WM_QUERYOPEN"             ); break;
	case WM_ERASEBKGND                   :strcpy(szMsg, "WM_ERASEBKGND"            ); break;
	case WM_SYSCOLORCHANGE               :strcpy(szMsg, "WM_SYSCOLORCHANGE"        ); break;
	case WM_ENDSESSION                   :strcpy(szMsg, "WM_ENDSESSION"            ); break;
	case WM_SHOWWINDOW                   :strcpy(szMsg, "WM_SHOWWINDOW"            ); break;
	case WM_WININICHANGE                 :strcpy(szMsg, "WM_WININICHANGE"          ); break;

	case WM_DEVMODECHANGE                :strcpy(szMsg, "WM_DEVMODECHANGE"         ); break;
	case WM_ACTIVATEAPP                  :strcpy(szMsg, "WM_ACTIVATEAPP"           ); break;
	case WM_FONTCHANGE                   :strcpy(szMsg, "WM_FONTCHANGE"            ); break;
	case WM_TIMECHANGE                   :strcpy(szMsg, "WM_TIMECHANGE"            ); break;
	case WM_CANCELMODE                   :strcpy(szMsg, "WM_CANCELMODE"            ); break;
	case WM_SETCURSOR                    :strcpy(szMsg, "WM_SETCURSOR"             ); break;
	case WM_MOUSEACTIVATE                :strcpy(szMsg, "WM_MOUSEACTIVATE"         ); break;
	case WM_CHILDACTIVATE                :strcpy(szMsg, "WM_CHILDACTIVATE"         ); break;
	case WM_QUEUESYNC                    :strcpy(szMsg, "WM_QUEUESYNC"             ); break;

	case WM_GETMINMAXINFO                :strcpy(szMsg, "WM_GETMINMAXINFO"         ); break;
	case WM_PAINTICON                    :strcpy(szMsg, "WM_PAINTICON"             ); break;
	case WM_ICONERASEBKGND               :strcpy(szMsg, "WM_ICONERASEBKGND"        ); break;
	case WM_NEXTDLGCTL                   :strcpy(szMsg, "WM_NEXTDLGCTL"            ); break;
	case WM_SPOOLERSTATUS                :strcpy(szMsg, "WM_SPOOLERSTATUS"         ); break;
	case WM_DRAWITEM                     :strcpy(szMsg, "WM_DRAWITEM"              ); break;
	case WM_MEASUREITEM                  :strcpy(szMsg, "WM_MEASUREITEM"           ); break;
	case WM_DELETEITEM                   :strcpy(szMsg, "WM_DELETEITEM"            ); break;
	case WM_VKEYTOITEM                   :strcpy(szMsg, "WM_VKEYTOITEM"            ); break;
	case WM_CHARTOITEM                   :strcpy(szMsg, "WM_CHARTOITEM"            ); break;
	case WM_SETFONT                      :strcpy(szMsg, "WM_SETFONT"               ); break;
	case WM_GETFONT                      :strcpy(szMsg, "WM_GETFONT"               ); break;
	case WM_SETHOTKEY                    :strcpy(szMsg, "WM_SETHOTKEY"             ); break;
	case WM_GETHOTKEY                    :strcpy(szMsg, "WM_GETHOTKEY"             ); break;
	case WM_QUERYDRAGICON                :strcpy(szMsg, "WM_QUERYDRAGICON"         ); break;
	case WM_COMPAREITEM                  :strcpy(szMsg, "WM_COMPAREITEM"           ); break;

#if(WINVER >= 0x0500)
	case WM_GETOBJECT                    :strcpy(szMsg, "WM_GETOBJECT"             ); break;
#endif

	case WM_COMPACTING                   :strcpy(szMsg, "WM_COMPACTING"            ); break;
	case WM_COMMNOTIFY                   :strcpy(szMsg, "WM_COMMNOTIFY"            ); break;
	case WM_WINDOWPOSCHANGING            :strcpy(szMsg, "WM_WINDOWPOSCHANGING"     ); break;
	case WM_WINDOWPOSCHANGED             :strcpy(szMsg, "WM_WINDOWPOSCHANGED"      ); break;

	case WM_POWER                        :strcpy(szMsg, "WM_POWER"                 ); break;
	case WM_COPYDATA                     :strcpy(szMsg, "WM_COPYDATA"              ); break;
	case WM_CANCELJOURNAL                :strcpy(szMsg, "WM_CANCELJOURNAL"         ); break;

#if(WINVER >= 0x0400)
	case WM_NOTIFY                       :strcpy(szMsg, "WM_NOTIFY"                ); break;
	case WM_INPUTLANGCHANGEREQUEST       :strcpy(szMsg, "WM_INPUTLANGCHANGEREQUEST"); break;
	case WM_INPUTLANGCHANGE              :strcpy(szMsg, "WM_INPUTLANGCHANGE"       ); break;
	case WM_TCARD                        :strcpy(szMsg, "WM_TCARD"                 ); break;
	case WM_HELP                         :strcpy(szMsg, "WM_HELP"                  ); break;
	case WM_USERCHANGED                  :strcpy(szMsg, "WM_USERCHANGED"           ); break;
	case WM_NOTIFYFORMAT                 :strcpy(szMsg, "WM_NOTIFYFORMAT"          ); break;
	case WM_CONTEXTMENU                  :strcpy(szMsg, "WM_CONTEXTMENU"           ); break;
	case WM_STYLECHANGING                :strcpy(szMsg, "WM_STYLECHANGING"         ); break;
	case WM_STYLECHANGED                 :strcpy(szMsg, "WM_STYLECHANGED"          ); break;
	case WM_DISPLAYCHANGE                :strcpy(szMsg, "WM_DISPLAYCHANGE"         ); break;
	case WM_GETICON                      :strcpy(szMsg, "WM_GETICON"               ); break;
	case WM_SETICON                      :strcpy(szMsg, "WM_SETICON"               ); break;
#endif

	case WM_NCCREATE                     :strcpy(szMsg, "WM_NCCREATE"              ); break;
	case WM_NCDESTROY                    :strcpy(szMsg, "WM_NCDESTROY"             ); break;
	case WM_NCCALCSIZE                   :strcpy(szMsg, "WM_NCCALCSIZE"            ); break;
	case WM_NCHITTEST                    :strcpy(szMsg, "WM_NCHITTEST"             ); break;
	case WM_NCPAINT                      :strcpy(szMsg, "WM_NCPAINT"               ); break;
	case WM_NCACTIVATE                   :strcpy(szMsg, "WM_NCACTIVATE"            ); break;
	case WM_GETDLGCODE                   :strcpy(szMsg, "WM_GETDLGCODE"            ); break;
	case WM_SYNCPAINT                    :strcpy(szMsg, "WM_SYNCPAINT"             ); break;
	case WM_NCMOUSEMOVE                  :strcpy(szMsg, "WM_NCMOUSEMOVE"           ); break;
	case WM_NCLBUTTONDOWN                :strcpy(szMsg, "WM_NCLBUTTONDOWN"         ); break;
	case WM_NCLBUTTONUP                  :strcpy(szMsg, "WM_NCLBUTTONUP"           ); break;
	case WM_NCLBUTTONDBLCLK              :strcpy(szMsg, "WM_NCLBUTTONDBLCLK"       ); break;
	case WM_NCRBUTTONDOWN                :strcpy(szMsg, "WM_NCRBUTTONDOWN"         ); break;
	case WM_NCRBUTTONUP                  :strcpy(szMsg, "WM_NCRBUTTONUP"           ); break;
	case WM_NCRBUTTONDBLCLK              :strcpy(szMsg, "WM_NCRBUTTONDBLCLK"       ); break;
	case WM_NCMBUTTONDOWN                :strcpy(szMsg, "WM_NCMBUTTONDOWN"         ); break;
	case WM_NCMBUTTONUP                  :strcpy(szMsg, "WM_NCMBUTTONUP"           ); break;
	case WM_NCMBUTTONDBLCLK              :strcpy(szMsg, "WM_NCMBUTTONDBLCLK"       ); break;

	case WM_KEYDOWN                      :strcpy(szMsg, "WM_KEYDOWN"               ); break;
	case WM_KEYUP                        :strcpy(szMsg, "WM_KEYUP"                 ); break;
	case WM_CHAR                         :strcpy(szMsg, "WM_CHAR"                  ); break;
	case WM_DEADCHAR                     :strcpy(szMsg, "WM_DEADCHAR"              ); break;
	case WM_SYSKEYDOWN                   :strcpy(szMsg, "WM_SYSKEYDOWN"            ); break;
	case WM_SYSKEYUP                     :strcpy(szMsg, "WM_SYSKEYUP"              ); break;
	case WM_SYSCHAR                      :strcpy(szMsg, "WM_SYSCHAR"               ); break;
	case WM_SYSDEADCHAR                  :strcpy(szMsg, "WM_SYSDEADCHAR"           ); break;
	case WM_KEYLAST                      :strcpy(szMsg, "WM_KEYLAST"               ); break;

#if(WINVER >= 0x0400)                   
	case WM_IME_STARTCOMPOSITION         :strcpy(szMsg, "WM_IME_STARTCOMPOSITION"  ); break;
	case WM_IME_ENDCOMPOSITION           :strcpy(szMsg, "WM_IME_ENDCOMPOSITION"    ); break;
	case WM_IME_COMPOSITION              :strcpy(szMsg, "WM_IME_COMPOSITION"       ); break;
#endif                                  

	case WM_INITDIALOG                   :strcpy(szMsg, "WM_INITDIALOG"            ); break;
	case WM_COMMAND                      :strcpy(szMsg, "WM_COMMAND"               ); break;
	case WM_SYSCOMMAND                   :strcpy(szMsg, "WM_SYSCOMMAND"            ); break;
	case WM_TIMER                        :strcpy(szMsg, "WM_TIMER"                 ); break;
	case WM_HSCROLL                      :strcpy(szMsg, "WM_HSCROLL"               ); break;
	case WM_VSCROLL                      :strcpy(szMsg, "WM_VSCROLL"               ); break;
	case WM_INITMENU                     :strcpy(szMsg, "WM_INITMENU"              ); break;
	case WM_INITMENUPOPUP                :strcpy(szMsg, "WM_INITMENUPOPUP"         ); break;
	case WM_MENUSELECT                   :strcpy(szMsg, "WM_MENUSELECT"            ); break;
	case WM_MENUCHAR                     :strcpy(szMsg, "WM_MENUCHAR"              ); break;
	case WM_ENTERIDLE                    :strcpy(szMsg, "WM_ENTERIDLE"             ); break;

#if(WINVER >= 0x0500)
	case WM_MENURBUTTONUP                :strcpy(szMsg, "WM_MENURBUTTONUP"         ); break;
	case WM_MENUDRAG                     :strcpy(szMsg, "WM_MENUDRAG"              ); break;
	case WM_MENUGETOBJECT                :strcpy(szMsg, "WM_MENUGETOBJECT"         ); break;
	case WM_UNINITMENUPOPUP              :strcpy(szMsg, "WM_UNINITMENUPOPUP"       ); break;
	case WM_MENUCOMMAND                  :strcpy(szMsg, "WM_MENUCOMMAND"           ); break;
#endif                                  


	case WM_CTLCOLORMSGBOX               :strcpy(szMsg, "WM_CTLCOLORMSGBOX"        ); break;
	case WM_CTLCOLOREDIT                 :strcpy(szMsg, "WM_CTLCOLOREDIT"          ); break;
	case WM_CTLCOLORLISTBOX              :strcpy(szMsg, "WM_CTLCOLORLISTBOX"       ); break;
	case WM_CTLCOLORBTN                  :strcpy(szMsg, "WM_CTLCOLORBTN"           ); break;
	case WM_CTLCOLORDLG                  :strcpy(szMsg, "WM_CTLCOLORDLG"           ); break;
	case WM_CTLCOLORSCROLLBAR            :strcpy(szMsg, "WM_CTLCOLORSCROLLBAR"     ); break;
	case WM_CTLCOLORSTATIC               :strcpy(szMsg, "WM_CTLCOLORSTATIC"        ); break;


	case WM_MOUSEMOVE                    :strcpy(szMsg, "WM_MOUSEMOVE"             ); break;
	case WM_LBUTTONDOWN                  :strcpy(szMsg, "WM_LBUTTONDOWN"           ); break;
	case WM_LBUTTONUP                    :strcpy(szMsg, "WM_LBUTTONUP"             ); break;
	case WM_LBUTTONDBLCLK                :strcpy(szMsg, "WM_LBUTTONDBLCLK"         ); break;
	case WM_RBUTTONDOWN                  :strcpy(szMsg, "WM_RBUTTONDOWN"           ); break;
	case WM_RBUTTONUP                    :strcpy(szMsg, "WM_RBUTTONUP"             ); break;
	case WM_RBUTTONDBLCLK                :strcpy(szMsg, "WM_RBUTTONDBLCLK"         ); break;
	case WM_MBUTTONDOWN                  :strcpy(szMsg, "WM_MBUTTONDOWN"           ); break;
	case WM_MBUTTONUP                    :strcpy(szMsg, "WM_MBUTTONUP"             ); break;
	case WM_MBUTTONDBLCLK                :strcpy(szMsg, "WM_MBUTTONDBLCLK"         ); break;

#if (_WIN32_WINNT >= 0x0400) || (_WIN32_WINDOWS > 0x0400)
	case WM_MOUSEWHEEL                   :strcpy(szMsg, "WM_MOUSEWHEEL"            ); break;
#else
	case WM_MOUSELAST                    :strcpy(szMsg, "WM_MOUSELAST"             ); break;
#endif / * if (_WIN32_WINNT < 0x0400) * /

	case WM_PARENTNOTIFY                 :strcpy(szMsg, "WM_PARENTNOTIFY"          ); break;
	case WM_ENTERMENULOOP                :strcpy(szMsg, "WM_ENTERMENULOOP"         ); break;
	case WM_EXITMENULOOP                 :strcpy(szMsg, "WM_EXITMENULOOP"          ); break;

#if(WINVER >= 0x0400)
	case WM_NEXTMENU                     :strcpy(szMsg, "WM_NEXTMENU"              ); break;
	case WM_SIZING                       :strcpy(szMsg, "WM_SIZING"                ); break;
	case WM_CAPTURECHANGED               :strcpy(szMsg, "WM_CAPTURECHANGED"        ); break;
	case WM_MOVING                       :strcpy(szMsg, "WM_MOVING"                ); break;
	case WM_POWERBROADCAST               :strcpy(szMsg, "WM_POWERBROADCAST"        ); break;
	case WM_DEVICECHANGE                 :strcpy(szMsg, "WM_DEVICECHANGE"          ); break;
#endif / * WINVER >= 0x0400 * /

	case WM_MDICREATE                    :strcpy(szMsg, "WM_MDICREATE"             ); break;
	case WM_MDIDESTROY                   :strcpy(szMsg, "WM_MDIDESTROY"            ); break;
	case WM_MDIACTIVATE                  :strcpy(szMsg, "WM_MDIACTIVATE"           ); break;
	case WM_MDIRESTORE                   :strcpy(szMsg, "WM_MDIRESTORE"            ); break;
	case WM_MDINEXT                      :strcpy(szMsg, "WM_MDINEXT"               ); break;
	case WM_MDIMAXIMIZE                  :strcpy(szMsg, "WM_MDIMAXIMIZE"           ); break;
	case WM_MDITILE                      :strcpy(szMsg, "WM_MDITILE"               ); break;
	case WM_MDICASCADE                   :strcpy(szMsg, "WM_MDICASCADE"            ); break;
	case WM_MDIICONARRANGE               :strcpy(szMsg, "WM_MDIICONARRANGE"        ); break;
	case WM_MDIGETACTIVE                 :strcpy(szMsg, "WM_MDIGETACTIVE"          ); break;
	case WM_MDISETMENU                   :strcpy(szMsg, "WM_MDISETMENU"            ); break;
	case WM_ENTERSIZEMOVE                :strcpy(szMsg, "WM_ENTERSIZEMOVE"         ); break;
	case WM_EXITSIZEMOVE                 :strcpy(szMsg, "WM_EXITSIZEMOVE"          ); break;
	case WM_DROPFILES                    :strcpy(szMsg, "WM_DROPFILES"             ); break;
	case WM_MDIREFRESHMENU               :strcpy(szMsg, "WM_MDIREFRESHMENU"        ); break;


#if(WINVER >= 0x0400)
	case WM_IME_SETCONTEXT               :strcpy(szMsg, "WM_IME_SETCONTEXT"        ); break;
	case WM_IME_NOTIFY                   :strcpy(szMsg, "WM_IME_NOTIFY"            ); break;
	case WM_IME_CONTROL                  :strcpy(szMsg, "WM_IME_CONTROL"           ); break;
	case WM_IME_COMPOSITIONFULL          :strcpy(szMsg, "WM_IME_COMPOSITIONFULL"   ); break;
	case WM_IME_SELECT                   :strcpy(szMsg, "WM_IME_SELECT"            ); break;
	case WM_IME_CHAR                     :strcpy(szMsg, "WM_IME_CHAR"              ); break;
#endif / * WINVER >= 0x0400 * /

#if(WINVER >= 0x0500)
	case WM_IME_REQUEST                  :strcpy(szMsg, "WM_IME_REQUEST"           ); break;
#endif / * WINVER >= 0x0500 * /

#if(WINVER >= 0x0400)
	case WM_IME_KEYDOWN                  :strcpy(szMsg, "WM_IME_KEYDOWN"           ); break;
	case WM_IME_KEYUP                    :strcpy(szMsg, "WM_IME_KEYUP"             ); break;
#endif / * WINVER >= 0x0400 * /


#if(_WIN32_WINNT >= 0x0400)
	case WM_MOUSEHOVER                   :strcpy(szMsg, "WM_MOUSEHOVER"            ); break;
	case WM_MOUSELEAVE                   :strcpy(szMsg, "WM_MOUSELEAVE"            ); break;
#endif / * _WIN32_WINNT >= 0x0400 * /

	case WM_CUT                          :strcpy(szMsg, "WM_CUT"                   ); break;
	case WM_COPY                         :strcpy(szMsg, "WM_COPY"                  ); break;
	case WM_PASTE                        :strcpy(szMsg, "WM_PASTE"                 ); break;
	case WM_CLEAR                        :strcpy(szMsg, "WM_CLEAR"                 ); break;
	case WM_UNDO                         :strcpy(szMsg, "WM_UNDO"                  ); break;
	case WM_RENDERFORMAT                 :strcpy(szMsg, "WM_RENDERFORMAT"          ); break;
	case WM_RENDERALLFORMATS             :strcpy(szMsg, "WM_RENDERALLFORMATS"      ); break;
	case WM_DESTROYCLIPBOARD             :strcpy(szMsg, "WM_DESTROYCLIPBOARD"      ); break;
	case WM_DRAWCLIPBOARD                :strcpy(szMsg, "WM_DRAWCLIPBOARD"         ); break;
	case WM_PAINTCLIPBOARD               :strcpy(szMsg, "WM_PAINTCLIPBOARD"        ); break;
	case WM_VSCROLLCLIPBOARD             :strcpy(szMsg, "WM_VSCROLLCLIPBOARD"      ); break;
	case WM_SIZECLIPBOARD                :strcpy(szMsg, "WM_SIZECLIPBOARD"         ); break;
	case WM_ASKCBFORMATNAME              :strcpy(szMsg, "WM_ASKCBFORMATNAME"       ); break;
	case WM_CHANGECBCHAIN                :strcpy(szMsg, "WM_CHANGECBCHAIN"         ); break;
	case WM_HSCROLLCLIPBOARD             :strcpy(szMsg, "WM_HSCROLLCLIPBOARD"      ); break;
	case WM_QUERYNEWPALETTE              :strcpy(szMsg, "WM_QUERYNEWPALETTE"       ); break;
	case WM_PALETTEISCHANGING            :strcpy(szMsg, "WM_PALETTEISCHANGING"     ); break;
	case WM_PALETTECHANGED               :strcpy(szMsg, "WM_PALETTECHANGED"        ); break;
	case WM_HOTKEY                       :strcpy(szMsg, "WM_HOTKEY"                ); break;

#if(WINVER >= 0x0400)
	case WM_PRINT                        :strcpy(szMsg, "WM_PRINT"                 ); break;
	case WM_PRINTCLIENT                  :strcpy(szMsg, "WM_PRINTCLIENT"           ); break;
	case WM_HANDHELDFIRST                :strcpy(szMsg, "WM_HANDHELDFIRST"         ); break;
	case WM_HANDHELDLAST                 :strcpy(szMsg, "WM_HANDHELDLAST"          ); break;
	case WM_AFXFIRST                     :strcpy(szMsg, "WM_AFXFIRST"              ); break;
	case WM_AFXLAST                      :strcpy(szMsg, "WM_AFXLAST"               ); break;
#endif / * WINVER >= 0x0400 * /

	case WM_PENWINFIRST                  :strcpy(szMsg, "WM_PENWINFIRST"           ); break;
	case WM_PENWINLAST                   :strcpy(szMsg, "WM_PENWINLAST"            ); break;

#if(WINVER >= 0x0400)
	case WM_APP                          :strcpy(szMsg, "WM_APP"                   ); break;
#endif / * WINVER >= 0x0400 * /

	default:
		if( uMsg>WM_USER )
			sprintf(szMsg, "WM_USER+%d", uMsg-WM_USER);
		else
			sprintf(szMsg, "0x%08x", uMsg);
		break;
	}
	return szMsg;
}
#define WMMsgName(x) _WMMsgName(x).data()
*/
HWND g_InputEdit = NULL;
#include "inputbox.h"
LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{
  //switch (message)
  //{
  //case WM_ACTIVATE:
  //	// Add by lark.li 20080903 begin
  //	if(GameLoading::Init()->Active())
  //		return 0;
  //	// End
  //
  //	break;
  //case WM_NCACTIVATE:
  //case WM_ACTIVATEAPP:
  //	// Add by lark.li 20080903 begin
  //	if(GameLoading::Init()->Active())
  //		return 0;
  //	// End

  //	if( g_pGameApp && g_pGameApp->IsInit() )
  //		g_pGameApp->SetInputActive( LOWORD(wParam)!=WA_INACTIVE );
  //	break;
  //}

  if(g_pGameApp)
  {
	g_pGameApp->HandleWindowMsg(message, (DWORD)wParam, (DWORD)lParam);
	//		if( GetRegionMgr()->OnMessage( message, wParam, lParam ) )
	//			return 0;
  }
  //	LG("Sleep", "[%s] %s) w(%08x) l(%08x)\n", GetTimeStamp(), WMMsgName(message), wParam, lParam);

  switch(message)
  {
#ifdef USE_TIMERPERIOD
  case WM_USER_TIMER:
	__timer_period_render();
	return 0;
	break;
#endif

  case WM_ACTIVATE:
	// Add by lark.li 20080903 begin
	//if(GameLoading::Init()->Active())
	//	return 0;
	// End

	break;
  case WM_NCACTIVATE:
  case WM_ACTIVATEAPP:
	// Add by lark.li 20080903 begin
	//if(GameLoading::Init()->Active())
	//	return 0;
	// End

	if(g_pGameApp && g_pGameApp->IsInit())
	  g_pGameApp->SetInputActive(LOWORD(wParam) != WA_INACTIVE);
	break;
  case WM_CREATE:
  {
	CenterWindow(hWnd);

	g_InputEdit = CreateWindow(TEXT("EDIT"),
							   TEXT(RES_STRING(CL_LANGUAGE_MATCH_192)),
							   WS_CHILD | WS_VISIBLE,
							   0, 0,
							   0, 0,
							   hWnd,
							   (HMENU)IDC_EDIT1,
							   ((LPCREATESTRUCT)lParam)->hInstance,
							   NULL);

	g_wpOrigEditProc = (WNDPROC)(LONG64)SetWindowLong(g_InputEdit, GWL_WNDPROC, (LONG)(LONG64)EditSubclassProc);

	extern CInputBox g_InputBox;
	g_InputBox.SetEditWindow(g_InputEdit);

	CImeInput::s_Ime.OnCreate(hWnd, hInst);
  }
  break;
  case WM_KEYDOWN:
  case WM_CHAR:
	break;
  case WM_LBUTTONDOWN:
  case WM_MOUSEMOVE:
  case WM_RBUTTONDOWN:
  case WM_RBUTTONUP:
  {
	break;
  }
  case WM_COMMAND:
  {
	int wmId	= LOWORD(wParam);
	int wmEvent = HIWORD(wParam);
	// Parse the menu selections:
	switch(wmId)
	{
	case IDM_EXIT:
	  DestroyWindow(hWnd);
	  break;
	default:
	  return DefWindowProc(hWnd, message, wParam, lParam);
	}
  }
  break;
  case WM_PAINT:
	break;
  case WM_CLOSE:
	//{
	//	if( g_Config.m_bEditor )
	//		break;

	//	if( !g_NetIF->IsConnected() )
	//		break;

	//	if( !dynamic_cast<CWorldScene*>( CGameApp::GetCurScene() ) )
	//		break;

	//	CForm* f = CFormMgr::s_Mgr.Find( "frmAskExit" );
	//	if( f )
	//	{
	//		long lState = GetWindowLong(hWnd, GWL_STYLE);
	//		if( lState & WS_MINIMIZE )
	//		{
	//			ShowWindow(hWnd, SW_SHOWNORMAL);
	//		}

	//		f->SetIsShow(true);
	//		g_stUISystem.GetSystemForm()->SetIsShow(false);
	//		return 0;
	//	}
	//}
	break;
  case WM_QUIT:
	break;
  case WM_DESTROY:
  {
	CS_Logout();
	CS_Disconnect(DS_DISCONN);

	SetWindowLong(g_InputEdit, GWL_WNDPROC, (LONG)(LONG64)g_wpOrigEditProc);

	PostQuitMessage(0);
	if(g_pGameApp) g_pGameApp->SetIsRun(false);
	break;
  }
  case WM_MUSICEND: // ���ֲ���ϵͳ
  {
	if(g_pGameApp) g_pGameApp->PlayMusic(0);
	break;
  }
  case WM_SYSKEYUP:
	if(wParam == VK_MENU || wParam == VK_F10)
	{
	  return 0;
	}
	//case WM_IME_STARTCOMPOSITION:
	//case WM_IME_ENDCOMPOSITION:
	//case WM_IME_NOTIFY:
	//case WM_IME_COMPOSITION:
	//case WM_IME_SETCONTEXT:
	//case WM_INPUTLANGCHANGEREQUEST:
	//case WM_INPUTLANGCHANGE:
	//    {
	//        return 0;
	//    }
	//    break;

  case WM_ERASEBKGND:
	return 0;
  }

  return DefWindowProc(hWnd, message, wParam, lParam);
}

void MakeBinTable()
{
  g_bBinaryTable = FALSE;
  //LGInfo lg_info;
  //lg_info = *g_pGameApp->GetLGConfig();
  //lg_info.bMsgBox = true;
  //lg_info.bEnableAll  = true;
  //g_pGameApp->LG_Config( lg_info );

  g_pGameApp->InitAllTable();

  g_pGameApp->ReleaseAllTable();

  // 	LEResourceSet* pResourceSet = new LEResourceSet(0, g_Config.m_nMaxResourceNum);
  // 	pResourceSet->LoadRawDataInfo("scripts/table/ResourceInfo", g_bBinaryTable);

  MessageBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_193), "Info", 0);
}

list<CCharacter*> g_Loading;

HANDLE		 hOutputReadTmp = 0;
HANDLE		 hOutputWrite	= 0;
DWORD WINAPI ReadStdout(LPVOID lpvThreadParam)
{
  //  CHAR lpBuffer[256];
  //  DWORD nBytesRead;

  //extern CMyIDEApp theApp;

  while(TRUE)
  {
	if(g_Loading.size() > 0)
	{
	} else
	{
	  Sleep(1);
	}

	//  if (!ReadFile(hOutputReadTmp, lpBuffer,sizeof(lpBuffer),
	//                                   &nBytesRead,NULL) || !nBytesRead)
	//  {
	//     if (GetLastError() == ERROR_BROKEN_PIPE)
	//        break; // pipe done - normal exit path.
	//     else
	//        IP("ReadFile"); // Something bad happened.
	//  }
	//
	//  if (nBytesRead >0 )
	//  {
	//      //��ȡ��printf�����
	//      lpBuffer[nBytesRead] = 0;
	////if(theApp.m_pMainWnd)
	////{
	////CMyIDEDlg *pDlg = (CMyIDEDlg*)theApp.m_pMainWnd; //��Edit�ؼ�д����ܵ����ַ������
	////pDlg->m_edit1.ReplaceSel(lpBuffer);
	//   //}
	//if( g_pGameApp )
	//{
	// g_pGameApp->SysInfo( "lua printf:%s", lpBuffer );
	//}
	//  }
  }

  return 0;
}

#include <io.h>
#include <FCNTL.h>
void StdoutRedirect()
{
  if(!CreatePipe(&hOutputReadTmp, &hOutputWrite, 0, 0))
	IP("CreatePipe");

  int	hCrt;
  FILE* hf;
  //AllocConsole();
  hCrt	  = _open_osfhandle((long)hOutputWrite, _O_TEXT);
  hf	  = _fdopen(hCrt, "w");
  *stdout = *hf;
  int i	  = setvbuf(stdout, NULL, _IONBF, 0);

  // Launch the thread that gets the input and sends it to the child.
  DWORD	 ThreadID;
  HANDLE hThread = ::CreateThread(NULL, 0, ReadStdout, //�����߳�
								  0, 0, &ThreadID);
}

// ��װ����
int InstallFont(const char* pszPath)
{
  int  nRet			 = 0;
  char szWindow[256] = {0};
  char szBuffer[256] = {0};

  // �ж��Ƿ��Ѿ���װ�������壬���û�а�װ���Զ���װ
  GetWindowsDirectory(szWindow, sizeof(szWindow) / sizeof(szWindow[0])); // ��ȡWindowsĿ¼������·����
  //sprintf(szBuffer, "%s\\fonts\\simsun.ttc", szWindow);
  _snprintf_s(szBuffer, sizeof(szBuffer), _TRUNCATE, "%s\\fonts\\simsun.ttc", szWindow);
  //	if(-1 !=access(szBuffer, 0))
  if(-1 != _access(szBuffer, 0))
  {
	return nRet;
  } else
  {
	//sprintf(szBuffer, "%s\\simsun.ttc", pszPath);
	_snprintf_s(szBuffer, sizeof(szBuffer), _TRUNCATE, "%s\\simsun.ttc", pszPath);
	nRet += AddFontResource(szBuffer);
  }

  //WIN32_FIND_DATA oFinder;

  //_snprintf_s( szBuffer, _countof( szBuffer ), _TRUNCATE  "%s%s", pszPath, "*.*");
  //HANDLE hFind = FindFirstFile(szBuffer, &oFinder);

  //if(hFind == INVALID_HANDLE_VALUE)
  //{
  //	return 0;
  //}

  //// �����������Ŀ¼
  //while(FindNextFile(hFind, &oFinder) != 0)
  //{
  //	if(oFinder.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
  //	{
  //		continue;
  //	}

  //	_snprintf_s( szBuffer, _countof( szBuffer ), _TRUNCATE  "%s%s", pszPath, oFinder.cFileName);
  //	nRet += AddFontResource(szBuffer);	//AddFontResourceEx(szBuffer, FR_NOT_ENUM, 0);
  //}

  //FindClose(hFind);

  if(nRet)
  {
	SendMessage(HWND_BROADCAST, WM_FONTCHANGE, 0, 0); // �㲥֪ͨϵͳ
  }

  return nRet;
}

void CenterWindow(HWND hWnd) // ��������Ļ��ʾλ������
{
  RECT rc;
  GetWindowRect(hWnd, &rc); // ������������Ļ�е�����

  int x = (GetSystemMetrics(SM_CXSCREEN) - (rc.right - rc.left)) / 2;	// ������߽�
  int y = (GetSystemMetrics(SM_CYSCREEN) - (rc.bottom - rc.top)) / 2;	// �����߽�
  MoveWindow(hWnd, x, y, rc.right - rc.left, rc.bottom - rc.top, TRUE); // ָ�����ڵ�λ�úͳߴ�
}
