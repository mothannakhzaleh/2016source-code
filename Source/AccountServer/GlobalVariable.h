#pragma once

#ifndef _GLOBALVARIABLE_H_
#define _GLOBALVARIABLE_H_

//#include "BillThread.h"

#include "tlsindex.h"
#include "databasectrl.h"

#include <i18n.h> //Add by lark.li 20080307

extern std::string g_strCfgFile;

extern dbc::TLSIndex g_TlsIndex;
extern CDataBaseCtrl g_MainDBHandle;
extern HWND			 g_hMainWnd;
extern DWORD		 g_MainThreadID;

#define WM_USER_LOG		WM_USER + 100
#define WM_USER_LOG_MAP WM_USER + 101

struct sUserLog
{
  bool		  bLogin; //true:login  false:logout
  int		  nUserID;
  std::string strUserName;
  std::string strPassport;
  std::string strLoginIP;
};

#endif