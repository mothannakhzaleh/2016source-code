//
#pragma once

#include "drHeader.h"
#include "drInterfaceExt.h"
#include "drClassDecl.h"

DR_BEGIN

class drSystemInfo : public drISystemInfo
{
    DR_STD_DECLARATION();

private:
    drDxVerInfo _dx_ver_info;

public:
    drSystemInfo();
    ~drSystemInfo();

    DR_RESULT CheckDirectXVersion();
    DR_RESULT GetDirectXVersion(drDxVerInfo* o_info) { *o_info = _dx_ver_info; return DR_RET_OK; }
    DWORD GetDirectXVersion();
};

DR_END
