// stdafx.h : 标准系统包含文件的包含文件，
// 或是经常使用但不常更改的
// 项目特定的包含文件

#pragma once

#ifndef VC_EXTRALEAN
#define VC_EXTRALEAN		// 从 Windows 标头中排除不常使用的资料
#endif

// 如果您必须使用下列所指定的平台之前的平台，则修改下面的定义。
// 有关不同平台的相应值的最新信息，请参考 MSDN。
#ifndef WINVER				// 允许使用 Windows 95 和 Windows NT 4 或更高版本的特定功能。
#define WINVER 0x0501		//为 Windows98 和 Windows 2000 及更新版本改变为适当的值。
#endif

#ifndef _WIN32_WINNT		// 允许使用 Windows NT 4 或更高版本的特定功能。
#define _WIN32_WINNT 0x0501	//为 Windows98 和 Windows 2000 及更新版本改变为适当的值。
#endif						

#ifndef _WIN32_WINDOWS		// 允许使用 Windows 98 或更高版本的特定功能。
#define _WIN32_WINDOWS 0x0501 //为 Windows Me 及更新版本改变为适当的值。
#endif

#ifndef _WIN32_IE			// 允许使用 IE 4.0 或更高版本的特定功能。
#define _WIN32_IE 0x0501	//为 IE 5.0 及更新版本改变为适当的值。
#endif

#define _ATL_CSTRING_EXPLICIT_CONSTRUCTORS	// 某些 CString 构造函数将是显式的

// 关闭 MFC 对某些常见但经常被安全忽略的警告消息的隐藏
#define _AFX_ALL_WARNINGS

#include <afxwin.h>         // MFC 核心和标准组件
#include <afxext.h>         // MFC 扩展
#include <afxdisp.h>        // MFC 自动化类

#include <afxdtctl.h>		// Internet Explorer 4 公共控件的 MFC 支持
#ifndef _AFX_NO_AFXCMN_SUPPORT
#include <afxcmn.h>			// Windows 公共控件的 MFC 支持
#endif // _AFX_NO_AFXCMN_SUPPORT

//#include <afxsock.h>		// MFC 套接字扩展


//------------------------------------------------------------------------
//	以下是用户自定义数据
//------------------------------------------------------------------------

#ifndef SAFE_DELETE
	#define SAFE_DELETE(p)			{ if((p) != NULL) { delete (p);     (p)=NULL; } }
	#define SAFE_DELETE_ARRAY(p)	{ if((p) != NULL) { delete[] (p);   (p)=NULL; } }
	#define SAFE_RELEASE(p)			{ if((p) != NULL) { (p)->Release(); (p)=NULL; } }
#endif


//信息框可显示的最大行数
#define EDIT_MAX_VISIBLE_LINE 19
//角色数量限制
#define ROLE_LIST_MAXNUM 3
//帐号数最限制
#define ACCOUNT_MAXNUM 1000
//信息记录限制-废弃
#define SYSTEM_INFORMATION_MAXNUM 100
//信息显示的最大限制
#define MESSAGE_VISIBLE_MAXNUM 4000
//信息记录限制
#define MESSAGE_INFORMATION_MAXNUM 1000
//自动移动坐标列表大小限制
#define AUTO_TELE_TABLE_MAXNUM 200
//每一项聊天记录的最大限制>100
#define CHAT_CHANNEL_INFORMATION_MAXNUM 1000
//每个聊天记录显示列表的最大限制>100
#define CHAT_CHANNEL_LIST_MAXNUM 1000

#include "afxtempl.h"
#include <afxdlgs.h>

#include "SystemInfo.h"
#include "Player.h"

class CPlayerMgr;
class CNetModule;
class CAutoPublishMgr;

extern CPlayerMgr g_PlayerMgr;
extern CNetModule *g_pNet;
extern short g_nClientVersion;
extern CAutoPublishMgr g_AutoPublishMgr;
extern CString g_strPassport;
extern CString g_strDBPassword;

namespace dbc
{
	class ThreadPool;
}
extern dbc::ThreadPool *g_ThreadPool;


//通知主界面信息已更新
#define THREAD_MSG_REFRESH_INFO				WM_USER+101
//通知帐号列表刷新帐号状态
#define THREAD_MSG_REFRESH_STATE			WM_USER+102
//主窗口线程通知游戏线程切换当前玩家
#define MAIN_PLAYER_SELECT_CHANGE			WM_USER+103
//通知主窗口刷新新添加的系统消息
#define THREAD_MSG_ADD_SYSTEM_MESSAGE		WM_USER+104


//------------------------------------------------------------------------
//	网络回调事件
//------------------------------------------------------------------------
//网络断开
#define NETIF_DISCONNECT			WM_USER+1001
//接收到网络数据
#define NETIF_RECEIVE_DATA			WM_USER+1002


//------------------------------------------------------------------------
//	游戏线程回调事件
//------------------------------------------------------------------------
//进入地图后初始化所有信息
#define GAME_THREAD_RESET_ALL				WM_USER+2001
//进入地图后刷新所有信息
#define GAME_THREAD_FRESH_ALL				WM_USER+2002
//刷新自己的地图坐标
#define GAME_THREAD_FRESH_MAP_POSITION		WM_USER+2003
//刷新属性页
#define GAME_THREAD_FRESH_PAGE				WM_USER+2004	//wParam参数：页编号，从0起
//角色出现与消失
#define GAME_THREAD_FRESH_ROLE				WM_USER+2005	//wParam参数：0为消失 1为出现  lParam为角色CRoleObject指针
//角色位置变更
#define GAME_THREAD_FRESH_ROLE_POSITION		WM_USER+2006	//lParam为角色CRoleObject指针
//地面物品出现与消失
#define GAME_THREAD_FRESH_GROUND_ITEM		WM_USER+2007	//wParam参数：0为消失 1为出现  lParam为地面物品CGroundObject指针
//属性聊天内容
#define GAME_THREAD_FRESH_CHAT				WM_USER+2008	//wParam参数为频道索引

#define NET_PROTOCOL_ENCRYPT   1	// 网络协议是否加密（针对外挂的修改）
