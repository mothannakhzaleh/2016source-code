//
#pragma once


#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

//////////////
//
DR_BEGIN

class drTexEncode
{
private:
    DR_RESULT _Encode0(drIBuffer* buf);
    DR_RESULT _Decode0(drIBuffer* buf);
    DR_RESULT _Encode1(drIBuffer* buf);
    DR_RESULT _Decode1(drIBuffer* buf);
public:
    DR_RESULT Encode(drIBuffer* buf);
    DR_RESULT Decode(drIBuffer* buf);
};


DR_END
