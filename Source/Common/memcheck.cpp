#include "memcheck.h"

#ifdef _DEBUG

void EnableMemLeakCheck()
{
  _CrtSetDbgFlag(_CrtSetDbgFlag(_CRTDBG_REPORT_FLAG) | _CRTDBG_LEAK_CHECK_DF);
}

#endif
