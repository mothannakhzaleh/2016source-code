//
#pragma once

#include "drHeader.h"

DR_BEGIN


class drLinkCtrl
{
public:
    virtual DR_RESULT GetLinkCtrlMatrix( drMatrix44* mat, DWORD link_id ) = 0;
};


DR_END
