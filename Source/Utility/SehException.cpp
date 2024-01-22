#include "SehException.h"
#include <minidumpapiset.h>
#include <sstream>
#include <dbghelp.h>
#include <shellapi.h>
#include <shlobj.h>
#include <strsafe.h>
#pragma warning(disable : 4311) //type cast warning
#pragma warning(disable : 4312) //warning C4312: 'type cast' : conversion from 'DWORD' to 'void *' of greater size

//----------------------------------------------------------------------------
// Structure Definitions
//----------------------------------------------------------------------------


typedef BOOL(WINAPI* MINIDUMPWRITEDUMP)(HANDLE hProcess, DWORD dwPid, HANDLE hFile, MINIDUMP_TYPE DumpType, CONST PMINIDUMP_EXCEPTION_INFORMATION ExceptionParam,
	CONST PMINIDUMP_USER_STREAM_INFORMATION UserStreamParam, CONST PMINIDUMP_CALLBACK_INFORMATION CallbackParam);

LONG WINAPI UnExcept(
	EXCEPTION_POINTERS* pExceptionPointers) ///< Pointer to information about the exception
{

  BOOL								bMiniDumpSuccessful;
  CHAR								szPath[MAX_PATH];
  CHAR								szFileName[MAX_PATH];
  CHAR									szAppName[]	 = "Yatops";
  CHAR									szVersion[] = "v1.0";
  DWORD								dwBufferSize = MAX_PATH;
  HANDLE								hDumpFile;
  SYSTEMTIME							stLocalTime;
  MINIDUMP_EXCEPTION_INFORMATION		ExpParam;
  GetLocalTime(&stLocalTime);
  
  StringCchPrintf(szFileName, MAX_PATH, "dumps\\%s-%04d%02d%02d-%02d%02d%02d-%ld-%ld.dmp",
				  szAppName, szVersion,
				  stLocalTime.wYear, stLocalTime.wMonth, stLocalTime.wDay,
				  stLocalTime.wHour, stLocalTime.wMinute, stLocalTime.wSecond,
				  GetCurrentProcessId(), GetCurrentThreadId());

  // Unhandled exception.
  HMODULE mhLib = ::LoadLibrary("dbghelp.dll");
  MINIDUMPWRITEDUMP pDump = (MINIDUMPWRITEDUMP)::GetProcAddress(mhLib, "MiniDumpWriteDump");

	
  CreateDirectory("dumps", NULL);
  HANDLE hFile = ::CreateFile((szFileName), GENERIC_WRITE, FILE_SHARE_WRITE, NULL, CREATE_ALWAYS,
							  FILE_ATTRIBUTE_NORMAL, NULL);

  _MINIDUMP_EXCEPTION_INFORMATION ExInfo;
  ExInfo.ThreadId		   = ::GetCurrentThreadId();
  ExInfo.ExceptionPointers = pExceptionPointers;
  ExInfo.ClientPointers	   = TRUE;

  BOOL d = (*pDump)(GetCurrentProcess(), GetCurrentProcessId(), hFile, MiniDumpNormal, &ExInfo, NULL, NULL);
  CloseHandle(hFile);

  return EXCEPTION_EXECUTE_HANDLER;
}

void SehExceptionBase::InitializeSehTranslator()
{
  SetUnhandledExceptionFilter(UnExcept);
}
