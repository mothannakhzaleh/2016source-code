#ifndef __GAME_ERROR_REPORT_H
#define __GAME_ERROR_REPORT_H
#include "ErrorReport.h"
extern BOOL	  CheckDxVersion(DWORD& ver); // °æ±¾ºË¶Ô
extern void	  GameErrorLog(const char* format, ...);
extern void	  GameErrorReport(const char* format, ...);
extern void	  GameErrorClear();
extern string GetTimeStamp();

#endif //__GAME_ERROR_REPORT_H
