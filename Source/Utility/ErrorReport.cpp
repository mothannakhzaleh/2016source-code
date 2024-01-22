#include <Windows.h>
#include <stdio.h>
#include "ErrorReport.h"
#include "log.h"

void DefaultErrorReport(const char* format, ...)
{
	char buf[1000];
	va_list args;
	va_start(args, format);
	_vsnprintf_s(buf, sizeof(buf), _TRUNCATE, format, args);	
	va_end(args);

	strncat_s(buf, _countof(buf), "\nProgram will exit!\n",  _TRUNCATE);
	LG2("error", buf);
	MessageBox(NULL, buf, "Error", MB_OK | MB_ICONERROR);
	exit(0);
};

ERR_FUNC _pErrorReport = DefaultErrorReport;
ERR_FUNC _pErrorLog = DefaultErrorReport;