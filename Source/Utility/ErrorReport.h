#ifndef __ERROR_REPORT_H
#define __ERROR_REPORT_H

typedef void (*ERR_FUNC)(const char* format, ...);

extern ERR_FUNC     _pErrorReport;
#define ErrorReport _pErrorReport
inline void SetErrorReportFunc(ERR_FUNC pFunc) { _pErrorReport = pFunc; }

extern ERR_FUNC   _pErrorLog;
#define ErrorLog  _pErrorLog
inline void SetErrorLogFunc(ERR_FUNC pFunc) { _pErrorLog = pFunc; }

#endif//__ERROR_REPORT_H