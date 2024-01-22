#include "stdafx.h"
#include "BKop.h"
#include "NetModule.h"
#include "threadpool.h"
#include "ItemDataMgr.h"
#include "MainFrm.h"
#include "ServerMgr.h"
#include ".\bkop.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CBKopApp

BEGIN_MESSAGE_MAP(CBKopApp, CWinApp)
	ON_COMMAND(ID_APP_ABOUT, OnAppAbout)
END_MESSAGE_MAP()


// CBKopApp 构造

CBKopApp::CBKopApp()
{
	EnableHtmlHelp();
}


// 唯一的一个 CBKopApp 对象

CBKopApp theApp;

// CBKopApp 初始化

BOOL CBKopApp::InitInstance()
{
	// 如果一个运行在 Windows XP 上的应用程序清单指定要
	// 使用 ComCtl32.dll 版本 6 或更高版本来启用可视化方式，
	//则需要 InitCommonControls()。否则，将无法创建窗口。
	
	InitCommonControls();
	AfxInitRichEdit();

	CWinApp::InitInstance();
	srand((unsigned)time( NULL ));
	//if (!AfxSocketInit())
	//{
	//	AfxMessageBox(IDP_SOCKETS_INIT_FAILED);
	//	return FALSE;
	//}

	// 初始化 OLE 库
	if (!AfxOleInit())
	{
		AfxMessageBox(IDP_OLE_INIT_FAILED);
		return FALSE;
	}
	AfxEnableControlContainer();
	// 标准初始化
	// 如果未使用这些功能并希望减小
	// 最终可执行文件的大小，则应移除下列
	// 不需要的特定初始化例程
	// 更改用于存储设置的注册表项
	// TODO: 应适当修改该字符串，
	// 例如修改为公司或组织名
	SetRegistryKey(_T("应用程序向导生成的本地应用程序"));
	// 若要创建主窗口，此代码将创建新的框架窗口
	// 对象，然后将其设置为应用程序的主窗口对象


	//NOTE(Ogge): Its in clients system folder, piggybacking on client resource for now
	CResourceBundleManage::Instance("Game.loc");

//TODO: Disabled to be able to start - need fix or replace with alternative
/* if(!CItemDataMgr::LoadItemsInfo())
	{
		MessageBox(NULL,"Failed to read props data! Please check whether the file and path are correct","Error",MB_OK);
	}
*/
	if (!CServerMgr::LoadServerInfo())
	{
		MessageBox(NULL,"Failed to read server list data! Please check whether the file and path are correct","Error",MB_OK);
		return FALSE;
	}


	g_pNet=new CNetModule(ThreadPool::CreatePool(10,ACCOUNT_MAXNUM,2048));

	CMainFrame* pFrame = new CMainFrame;
	if (!pFrame)
		return FALSE;
	m_pMainWnd = pFrame;
	// 创建并加载带有其资源的框架
	pFrame->LoadFrame(IDR_MAINFRAME,
		WS_OVERLAPPEDWINDOW | FWS_ADDTOTITLE, NULL,
		NULL);
	// 唯一的一个窗口已初始化，因此显示它并对其进行更新
	pFrame->ShowWindow(SW_SHOW);
	pFrame->UpdateWindow();
	// 仅当存在后缀时才调用 DragAcceptFiles，
	//  在 SDI 应用程序中，这应在 ProcessShellCommand  之后发生
	return TRUE;
}









// CBKopApp 消息处理程序



// 用于应用程序“关于”菜单项的 CAboutDlg 对话框

class CAboutDlg : public CDialog
{
public:
	CAboutDlg();

// 对话框数据
	enum { IDD = IDD_ABOUTBOX };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV 支持

// 实现
protected:
	DECLARE_MESSAGE_MAP()
};

CAboutDlg::CAboutDlg() : CDialog(CAboutDlg::IDD)
{
}

void CAboutDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}

BEGIN_MESSAGE_MAP(CAboutDlg, CDialog)
END_MESSAGE_MAP()

// 用于运行对话框的应用程序命令
void CBKopApp::OnAppAbout()
{
	CAboutDlg aboutDlg;
	aboutDlg.DoModal();
}


// CBKopApp 消息处理程序

