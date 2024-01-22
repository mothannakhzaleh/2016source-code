#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drDirectX.h"
#include "drITypes.h"
#include "drInterface.h"

DR_BEGIN


DR_RESULT drInitInternalRenderCtrlVSProc(drIResourceMgr* mgr);

class drRenderCtrlVSFixedFunction : public drIRenderCtrlVS
{
    typedef drRenderCtrlVSFixedFunction this_type;

    DR_STD_DECLARATION();

public:
    DWORD GetType() { return RENDERCTRL_VS_FIXEDFUNCTION; }
    DR_RESULT Clone(drIRenderCtrlVS** obj);
    DR_RESULT Initialize(drIRenderCtrlAgent* agent);
    DR_RESULT BeginSet(drIRenderCtrlAgent* agent);
    DR_RESULT EndSet(drIRenderCtrlAgent* agent);
    DR_RESULT BeginSetSubset(DWORD subset, drIRenderCtrlAgent* agent);
    DR_RESULT EndSetSubset(DWORD subset, drIRenderCtrlAgent* agent);
};


DR_END
