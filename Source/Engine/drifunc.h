//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drClassDecl.h"
#include "drInterface.h"
#include "drITypes.h"

#include "drFrontAPI.h"


DR_BEGIN

enum drInitMeshLibErrorType
{
    INIT_ERR_CREATE_D3D =           -1000,
    INIT_ERR_CREATE_DEVICE =        -1001,
    INIT_ERR_DX_VERSION =           -1002,
};

DR_FRONT_API void drSetActiveIGraphicsSystem( drISysGraphics* sys_graphics );
DR_FRONT_API drISysGraphics* drGetActiveIGraphicsSystem();

DR_FRONT_API DR_RESULT drAdjustD3DCreateParam(IDirect3DX* d3d, drD3DCreateParam* param, drD3DCreateParamAdjustInfo* adjust_info);
DR_FRONT_API DR_RESULT drInitMeshLibSystem( drISystem** ret_sys, drISysGraphics** ret_sys_graphics);
DR_FRONT_API DR_RESULT drInitMeshLibSystem( drISystem** ret_sys, drISysGraphics** ret_sys_graphics, IDirect3DX* d3d, IDirect3DDeviceX* dev, HWND hwnd );
DR_FRONT_API DR_RESULT drInitMeshLibSystem( drISystem** ret_sys, drISysGraphics** ret_sys_graphics, drD3DCreateParam* param, drD3DCreateParamAdjustInfo* param_info);
DR_FRONT_API DR_RESULT drReleaseMeshLibSystem();

DR_FRONT_API void drSetActiveISystem( drISystem* sys );
DR_FRONT_API drISystem* drGetActiveISystem();

DR_FRONT_API DR_RESULT drReleaseD3DObject( drISystem* sys, drISysGraphics* sys_graphics );

DR_FRONT_API DR_RESULT drHitTestBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const drBox* box, const drMatrix44* mat );
DR_FRONT_API void drHelperSetForceIgnoreTexFlag( DWORD flag );

DR_FRONT_API void drWorldToScreen( int* x, int* y, float* z, const drVector3* vec, int width, int height, const drMatrix44* mat_proj, const drMatrix44* mat_view );
DR_FRONT_API void drUpdateSceneTransparentObject();

DR_FRONT_API DR_RESULT drRegisterOutputLoseDeviceProc(drOutputLoseDeviceProc proc);
DR_FRONT_API DR_RESULT drRegisterOutputResetDeviceProc(drOutputResetDeviceProc proc);
DR_FRONT_API DR_RESULT drUnregisterOutputLoseDeviceProc(drOutputLoseDeviceProc proc);
DR_FRONT_API DR_RESULT drUnregisterOutputResetDeviceProc(drOutputResetDeviceProc proc);

DR_FRONT_API DR_RESULT LoadResBuf(drIResourceMgr* res_mgr, const char* file);
DR_FRONT_API DR_RESULT LoadResModelBuf(drIResourceMgr* res_mgr, const char* file);

struct drInterfaceMgr
{
    drISystem* sys;
    drISysGraphics* sys_graphics;
    drIDeviceObject* dev_obj;
    drIResourceMgr* res_mgr;
    drIThreadPool* tp_loadres;
};

DR_FRONT_API DR_RESULT drDumpMeshInfo(const char* file, const drMeshInfo* info);

DR_END
