//
// logutil.cpp
//
//  created by claude fan at 2004-8-9
//

#include "pch.h"
#include "logutil.h"
#include "packet.h"
#include "log.h"
#include "log2.h"

//#include "ErrorHandler.h"



// 特点：只记录下当前时间点上的LOG（更新）
static HWND GPL_hwnd = NULL;
void GPL(char const* type, int x, int y, char const* format, ...)
    {

    }



// new interface
void LG_EnableAll(bool bEnable /* = true */)
{
    CLog2Mgr::Inst()->Enable(bEnable);
}
void LG_EnableMsgBox(bool bEnable /* = true */)
{
    CLog2Mgr::Inst()->EnableMsgBox(bEnable);
}
void LG_SetDir(char const* szDir)
{
    CLog2Mgr* pLogMgr = CLog2Mgr::Inst();
    
    pLogMgr->SetDirectory(szDir);
    pLogMgr->LogMgrReopen();
}
void LG_GetDir(std::string& strDir)
{
    CLog2Mgr* pLogMgr = CLog2Mgr::Inst();

	pLogMgr->GetDirectory(strDir);
}
void LG_CloseAll()
{
    CLog2Mgr::Inst()->CloseAll();
}
void LG_SetEraseMode(bool bEraseMode /* = true */)
{
    CLog2Mgr* pLogMgr = CLog2Mgr::Inst();

    pLogMgr->bEraseMode = bEraseMode;
}
void LG2(char const* type, char const* format, ...)
{
	if(type== NULL || format == NULL)
		return;

	//ErrorHandler::SetCurrent(format);

	try
	{
		// 检查是否使能LOG
		CLog2Mgr* pLogMgr = CLog2Mgr::Inst();
		if (pLogMgr == NULL || !pLogMgr->IsEnable()) return;

		CLog2* pLog = pLogMgr->Add(type);
		if (pLog == NULL || !pLog->IsEnable()) return;

		char buf[8192] = {0};
		int len;
		va_list args;
		va_start(args, format);
		//len = vsprintf(buf, format, args);
		len = vsnprintf_s(buf, sizeof(buf), _TRUNCATE, format, args);
		va_end(args);
		//if (len >= sizeof buf)
		if (len < 0)
		{
			pLogMgr->Log("stack buffer overflow when LG [%s]\n", type);
			return;
		}

		pLog->LogString(buf);
	}
	catch(...)
	{
		printf(" LG2(char const* type, char const* format, ...)");
	}
}

//void LG3(char const* type, char const* format, ...)
//{
//	ErrorHandler::SetCurrent(format);
//
//	try
//	{
//		// 检查是否使能LOG
//		CLog2Mgr* pLogMgr = CLog2Mgr::Inst();
//		if (pLogMgr == NULL || !pLogMgr->IsEnable()) return;
//
//		CLog2* pLog = pLogMgr->Add(type);
//		if (pLog == NULL || !pLog->IsEnable()) return;
//
//		char buf[8192] = {0};
//		int len;
//		va_list args;
//		va_start(args, format);
//		//len = vsprintf(buf, format, args);
//		len = vsnprintf_s(buf, sizeof(buf), _TRUNCATE, format, args);
//		va_end(args);
//		//if (len >= sizeof buf)
//		if (len < 0)
//		{
//			pLogMgr->Log("stack buffer overflow when LG [%s]\n", type);
//			return;
//		}
//
//		pLog->Log3(buf);
//	}
//	catch(...)
//	{
//		printf("LG3(char const* type, char const* format, ...)");
//	}
//}
