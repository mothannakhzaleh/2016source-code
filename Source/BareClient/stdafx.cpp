//// stdafx.cpp : 只包括标准包含文件的源文件
// BKop.pch 将是预编译头
// stdafx.obj 将包含预编译类型信息

#include "stdafx.h"
#include "threadpool.h"
#include "AutoPublishMgr.h"


// 与服务器对应的版本号
short g_nClientVersion = 110;


CNetModule *g_pNet=NULL;
dbc::ThreadPool *g_ThreadPool=NULL;
CAutoPublishMgr g_AutoPublishMgr;
CString g_strPassport="nobill";		//对于非收费服务器,登陆时默认的passport字符串
CString g_strDBPassword=";PWD=zxcvbnm";

