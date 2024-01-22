//
#pragma once

#include "drHeader.h"
#include "drInterfaceExt.h"
#include "drClassDecl.h"

DR_BEGIN

class drSystem : public drISystem
{
public:
    static drISystem* __system;
    static void SetActiveISystem( drISystem* sys ) { __system = sys; }
    static drISystem* GetActiveISystem() { return __system; }

private:
    drIPathInfo* _path_info;
    drIOptionMgr* _option_mgr;
    drITimer* _internal_timer;
    drISystemInfo* _system_info;

DR_STD_DECLARATION()

public:
    drSystem();
    ~drSystem();

    DR_RESULT Initialize();
    DR_RESULT CreateGraphicsSystem( drISysGraphics** sys );

    drIPathInfo* GetPathInfo() { return _path_info; }
    drIOptionMgr* GetOptionMgr() { return _option_mgr; }
    drISystemInfo* GetSystemInfo() { return _system_info; }
};

DR_END
