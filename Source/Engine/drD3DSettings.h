//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drFrontAPI.h"
#include "drErrorCode.h"
#include "drITypes.h"

DR_BEGIN

DR_RESULT DR_FRONT_API drInitDefaultD3DCreateParam( drD3DCreateParam* param, HWND hwnd );

DR_RESULT DR_FRONT_API drLoadD3DSettings( drD3DCreateParam* param, const char* file );
DR_RESULT DR_FRONT_API drSaveD3DSettings( const char* file, const drD3DCreateParam* param );


DR_END
