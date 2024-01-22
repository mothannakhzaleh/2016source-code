#pragma once

#ifdef _DEBUG
#include <crtdbg.h>

//#pragma push_macro("dnew")
#define dnew new(_NORMAL_BLOCK, __FILE__, __LINE__)

extern void EnableMemLeakCheck();

//#pragma pop_macro("dnew")
#else
#define dnew new
#endif
