//
#include "drConsole.h"

DR_BEGIN

// drConsole
DR_STD_ILELEMENTATION(drConsole)

drConsole::drConsole()
: _handle(INVALID_HANDLE_VALUE)
{
}
drConsole::~drConsole()
{
    Destroy();
}

DR_RESULT drConsole::Alloc()
{
    return ::AllocConsole() ? DR_RET_OK : DR_RET_FAILED;
}

DR_RESULT drConsole::Create(DWORD desired_access, DWORD share_mode, const SECURITY_ATTRIBUTES* security_attr)
{
    _handle = ::CreateConsoleScreenBuffer(desired_access, share_mode, security_attr, CONSOLE_TEXTMODE_BUFFER, 0);

    return (_handle == INVALID_HANDLE_VALUE) ? DR_RET_FAILED : DR_RET_OK;
}

DR_RESULT drConsole::Destroy()
{
    if(_handle != INVALID_HANDLE_VALUE)
    {
        ::CloseHandle(_handle);
        _handle = INVALID_HANDLE_VALUE;
    }

    return DR_RET_OK;
}
DR_RESULT drConsole::Write(const char* str, ...)
{
    char buf[1024];
    
    va_list args;
    va_start(args, str);
    _vsntprintf_s(buf, 1024, _TRUNCATE, str, args);
    va_end(args);

    DWORD str_size = (DWORD)strlen(buf);

    BOOL b = ::WriteConsole(_handle, buf, str_size, &str_size, 0);

    return b ? DR_RET_OK : DR_RET_FAILED;
}
DR_RESULT drConsole::SetBufferSize(DWORD row, DWORD column)
{
    COORD d;
    d.X = (SHORT)row;
    d.Y = (SHORT)column;

    return ::SetConsoleScreenBufferSize(_handle, d) ? DR_RET_OK : DR_RET_FAILED;
}

DR_END
