//


#include "drSysGraphics.h"
#include "drDeviceObject.h"
#include "drResourceMgr.h"
#include "drSceneMgr.h"
#include <CPerformance.h>

DR_BEGIN

drISysGraphics* drSysGraphics::__sys_graphics = DR_NULL;


DR_STD_RELEASE( drSysGraphics );
//DR_STD_ILELEMENTATION( drSysGraphics );

DR_RESULT drSysGraphics::GetInterface( DR_VOID** i, drGUID guid )
{
    DR_RESULT ret = DR_RET_FAILED;

    switch( guid )
    {
    case DR_GUID_DEVICEOBJECT:
        *i = (DR_VOID*)_dev_obj;
        ret = DR_RET_OK;
        break;
    case DR_GUID_RESOURCEMGR:
        *i = (DR_VOID*)( static_cast< drIResourceMgr* >( _res_mgr ) );
        ret = DR_RET_OK;
        break;
    default:
        ret = DR_RET_NULL;
    }

    return ret;
}

drSysGraphics::drSysGraphics( drSystem* sys )
: _sys(sys), _dev_obj(0), _res_mgr(0), _scene_mgr(0), _lose_dev_proc(0), _reset_dev_proc(0)
{
    _dev_obj = DR_NEW(drDeviceObject(this));
    _res_mgr = DR_NEW(drResourceMgr(this));  
    _scene_mgr = DR_NEW(drSceneMgr(this));  
}

drSysGraphics::~drSysGraphics()
{
    DR_IF_RELEASE(_scene_mgr);
    DR_IF_RELEASE(_res_mgr);
    DR_IF_RELEASE(_dev_obj);
}

DR_RESULT drSysGraphics::CreateDeviceObject(drIDeviceObject** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drDeviceObject* o = DR_NEW(drDeviceObject(this));

    if(o == 0)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drSysGraphics::CreateResourceManager(drIResourceMgr** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drResourceMgr* o = DR_NEW(drResourceMgr(this));

    if(o == 0)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drSysGraphics::CreateSceneManager(drISceneMgr** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drSceneMgr* o = DR_NEW(drSceneMgr(this));

    if(o == 0)
        goto __ret;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drSysGraphics::ToggleFullScreen(D3DPRESENT_PARAMETERS* d3dpp, drWndInfo* wnd_info)
{
    DR_RESULT ret = DR_RET_FAILED;

    HWND hwnd = wnd_info->hwnd;

    //d3dcp->present_param.Windowed
    if(_lose_dev_proc)
    {
        if(DR_FAILED((*_lose_dev_proc)()))
            goto __ret;
    }

    if(DR_FAILED(_res_mgr->LoseDevice()))
        goto __ret;

    //AdjustWindowForChange
    LONG style;
    if(d3dpp->Windowed)
    {
        // Set windowed-mode style
        style = wnd_info->windowed_style;
    }
    else
    {
        // Set fullscreen-mode style
        style = WS_POPUP|WS_VISIBLE;
    }

    if(SetWindowLong(hwnd, GWL_STYLE, style) == 0)
        goto __ret;

    if(DR_FAILED(_dev_obj->ResetDevice(d3dpp)))
        goto __ret;

    if(d3dpp->Windowed)
    {
        if(SetWindowPos(hwnd, HWND_NOTOPMOST,
            wnd_info->left,
            wnd_info->top,
            wnd_info->width,
            wnd_info->height,
            SWP_SHOWWINDOW) == 0)
        {
            goto __ret;
        }
    }

    if(DR_FAILED(_dev_obj->UpdateWindowRect()))
        goto __ret;

    if(DR_FAILED(_dev_obj->ResetDeviceStateCache()))
        goto __ret;
    
    if(DR_FAILED(_dev_obj->ResetDeviceTransformMatrix()))
        goto __ret;

    if(DR_FAILED(_dev_obj->InitCapsInfo()))
        goto __ret;


    if(DR_FAILED(_res_mgr->ResetDevice()))
        goto __ret;

    if(_reset_dev_proc)
    {
        if(DR_FAILED((*_reset_dev_proc)()))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drSysGraphics::TestCooperativeLevel()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    HRESULT hr = _dev_obj->GetDevice()->TestCooperativeLevel();

    //LG("ttt", "&&& %d\n", GetTickCount());

    if(SUCCEEDED(hr))
    {
        ret = DR_RET_OK;
        goto __ret;
    }

    if(hr == D3DERR_DEVICELOST)
    {
        ret = D3DERR_DEVICELOST;
        goto __ret;
    }

    if(hr != D3DERR_DEVICENOTRESET)
        goto __ret;

    // hr == D3DERR_DEVICENOTRESET
    drD3DCreateParam* d3dcp = _dev_obj->GetD3DCreateParam();

    // check windowed mode and use desktop backbuffer format
    if(d3dcp->present_param.Windowed == 1)
    {
		D3DDISPLAYMODE dm;
        _dev_obj->GetDirect3D()->GetAdapterDisplayMode(D3DADAPTER_DEFAULT, &dm);
        d3dcp->present_param.BackBufferFormat = dm.Format;
    }

    if(_lose_dev_proc)
    {
        if(DR_FAILED((*_lose_dev_proc)()))
            goto __ret;
    }

    if(DR_FAILED(_res_mgr->LoseDevice()))
        goto __ret;

    if(DR_FAILED(_dev_obj->ResetDevice(&d3dcp->present_param)))
        goto __ret;

    //LG("ttt", "*** %\n", GetTickCount());

    if(DR_FAILED(_dev_obj->ResetDeviceStateCache()))
        goto __ret;

    if(DR_FAILED(_dev_obj->ResetDeviceTransformMatrix()))
        goto __ret;

    if(DR_FAILED(_res_mgr->ResetDevice()))
        goto __ret;

    if(_reset_dev_proc)
    {
        if(DR_FAILED((*_reset_dev_proc)()))
            goto __ret;
    }

    ret = DR_RET_OK_1;
__ret:
    return ret;
}

DR_END
