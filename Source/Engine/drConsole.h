//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

DR_BEGIN

class drConsole : public drIConsole
{
    DR_STD_DECLARATION()

private:
    HANDLE _handle;

public:
    drConsole();
    ~drConsole();
    
    DR_RESULT Alloc();
    DR_RESULT Create(DWORD desired_access = GENERIC_READ|GENERIC_WRITE, DWORD share_mode = 0, const SECURITY_ATTRIBUTES* security_attr = 0);
    DR_RESULT Destroy();
    DR_RESULT Write(const char* str, ...);
    DR_RESULT SetBufferSize(DWORD row, DWORD column);
    BOOL SetActive() { return ::SetConsoleActiveScreenBuffer(_handle); }
    HANDLE GetHandle() const { return _handle; }
};

DR_END
