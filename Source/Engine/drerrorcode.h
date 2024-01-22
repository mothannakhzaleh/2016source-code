//
#pragma once

#include "drHeader.h"

DR_BEGIN

enum drErrCodeEnum
{
    DR_RET_OK_1 =           1,
    DR_RET_OK_2 =           2,
    DR_RET_OK_3 =           3,

    DR_RET_NULL =           1,

    DR_RET_FAILED_1 =       -1,
    DR_RET_FAILED_2 =       -2,
    DR_RET_FAILED_3 =       -3,

    DR_RET_UNKNOWN =        -1,

    ERR_INVALID_CALL =      -1,
    ERR_INVALID_PARAM =     -99,
    ERR_INVALID_DATA =      -2,

    // stream obj
    ERR_FULL_STREAMSIZE =               -2,
    ERR_STREAM_ENTRYSEQ_FULL =          -3,
    ERR_STREAM_FILLDATA_FAILED =        -4,
    ERR_STREAM_REGISTER_FAILED =        -5,
};

#define DR_FAILED( r )      ( (DR_RESULT)(r) < 0 )
#define DR_SUCCEEDED( r )   ( (DR_RESULT)(r) >= 0 )

DR_END
