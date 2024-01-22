#include "Win32Guid.h"

Win32Guid::Win32Guid(void)
{
}

Win32Guid::~Win32Guid(void)
{
}

void Win32Guid::Generate()
{
    UuidCreate(&this->uuid);
}

string Win32Guid::AsString() const
{
    const char* uuidStr;
    UuidToString((UUID*) &this->uuid, (RPC_CSTR*) &uuidStr);
    string result = uuidStr;
    RpcStringFree((RPC_CSTR*)&uuidStr);
    return result;
}
