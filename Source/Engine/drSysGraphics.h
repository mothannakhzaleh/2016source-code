//
#pragma once

#include "drHeader.h"
#include "drInterfaceExt.h"
#include "drStdInc.h"
#include "drDirectX.h"
#include "drClassDecl.h"
#include "drCoordinateSys.h"

DR_BEGIN

class drSysGraphics : public drISysGraphics
{
public:
    static drISysGraphics* __sys_graphics;
    static void SetActiveIGraphicsSystem( drISysGraphics* sys ) { __sys_graphics = sys; }
    static drISysGraphics* GetActiveIGraphicsSystem() { return __sys_graphics; }
private:
    drSystem* _sys;

    drIDeviceObject* _dev_obj;
    drIResourceMgr* _res_mgr;
    drISceneMgr* _scene_mgr;

    drCoordinateSys _coord_sys;

    drOutputLoseDeviceProc _lose_dev_proc;
    drOutputResetDeviceProc _reset_dev_proc;     

DR_STD_DECLARATION();

public:
    drSysGraphics( drSystem* sys );
    ~drSysGraphics();

    drISystem* GetSystem() { return (drISystem*)_sys; }
    drIDeviceObject* GetDeviceObject() { return _dev_obj; }
    drIResourceMgr* GetResourceMgr() { return _res_mgr; }
    drISceneMgr* GetSceneMgr() { return _scene_mgr; }
    drICoordinateSys* GetCoordinateSys() { return &_coord_sys; }

    DR_RESULT CreateDeviceObject(drIDeviceObject** ret_obj);
    DR_RESULT CreateResourceManager(drIResourceMgr** ret_obj);
    DR_RESULT CreateSceneManager(drISceneMgr** ret_obj);

    DR_RESULT ToggleFullScreen(D3DPRESENT_PARAMETERS* d3dpp, drWndInfo* wnd_info);
    DR_RESULT TestCooperativeLevel();

    void SetOutputLoseDeviceProc(drOutputLoseDeviceProc proc) { _lose_dev_proc = proc; }
    void SetOutputResetDeviceProc(drOutputResetDeviceProc proc) { _reset_dev_proc = proc; }

};

DR_END
