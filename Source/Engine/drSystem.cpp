//


#include "drSystem.h"
#include "drSysGraphics.h"
#include "drPathInfo.h"

DR_BEGIN

drISystem* drSystem::__system = DR_NULL;

DR_STD_RELEASE( drSystem )

DR_RESULT drSystem::GetInterface( DR_VOID** i, drGUID guid )
{
    DR_RESULT ret;

    switch( guid )
    {
    case DR_GUID_PATHINFO:
        *i = (DR_VOID*)_path_info;
        ret = DR_RET_OK;
        break;
    case DR_GUID_OPTIONMGR:
        *i = (DR_VOID*)_option_mgr;
        ret = DR_RET_OK;
        break;
    case DR_GUID_TIMER:
        *i = (DR_VOID*)_internal_timer;
        ret = DR_RET_OK;
        break;
    case DR_GUID_SYSTEMINFO:
        *i = (DR_VOID*)_system_info;
        ret = DR_RET_OK;
        break;
    default:
        ret = DR_RET_NULL;
    }

    return ret;
}

drSystem::drSystem()
{
    _path_info = 0;
    _option_mgr = 0;
    _system_info = 0;
    _internal_timer = 0;
}

drSystem::~drSystem()
{
    DR_SAFE_RELEASE(_path_info);
    DR_SAFE_RELEASE(_option_mgr);
    DR_SAFE_RELEASE(_system_info);
    DR_SAFE_RELEASE(_internal_timer);
}

DR_RESULT drSystem::Initialize()
{
    DR_RESULT ret = DR_RET_FAILED;

    _path_info = DR_NEW(drPathInfo);
    _option_mgr = DR_NEW(drOptionMgr);

    drGUIDCreateObject((DR_VOID**)&_system_info, DR_GUID_SYSTEMINFO);
    drGUIDCreateObject((DR_VOID**)&_internal_timer, DR_GUID_TIMER);

    if(DR_FAILED(_system_info->CheckDirectXVersion()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drSystem::CreateGraphicsSystem( drISysGraphics** sys )
{
    *sys = DR_NEW( drSysGraphics( this ) );

    return DR_RET_OK;
}


DR_END
