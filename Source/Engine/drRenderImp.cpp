//


#include "drRenderImp.h"
#include "drDeviceObject.h"
#include "drResourceMgr.h"
#include "drShaderMgr.h"
#include "drD3D.h"

DR_BEGIN

//
////////////////////////////
// drRenderCtrlAgent
DR_STD_ILELEMENTATION(drRenderCtrlAgent)

drRenderCtrlAgent::drRenderCtrlAgent(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _mesh_agent(0), _mtltex_agent(0), _anim_agent(0),
  _render_ctrl(0), _decl_type(VDT_INVALID), _vs_type(VST_INVALID)
{
    drMatrix44Identity(&_mat_local);
    drMatrix44Identity(&_mat_parent);
    drMatrix44Identity(&_mat_global);
}
drRenderCtrlAgent::~drRenderCtrlAgent()
{
    DR_IF_RELEASE(_render_ctrl);
}


void drRenderCtrlAgent::SetLocalMatrix(const drMatrix44* mat_local)
{
    _mat_local = *mat_local;
    drMatrix44Multiply(&_mat_global, &_mat_local, &_mat_parent);
}

void drRenderCtrlAgent::SetParentMatrix(const drMatrix44* mat_parent)
{
    _mat_parent = *mat_parent;
    drMatrix44Multiply(&_mat_global, &_mat_local, &_mat_parent);
}
DR_RESULT drRenderCtrlAgent::SetRenderCtrl(DWORD ctrl_type)
{
    DR_RESULT ret = DR_RET_FAILED;

    DR_IF_RELEASE(_render_ctrl);

    if(DR_FAILED(_res_mgr->CreateRenderCtrlVS(&_render_ctrl, ctrl_type)))
        goto __ret;

    if(DR_FAILED(_render_ctrl->Initialize(this)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drRenderCtrlAgent::Clone(drIRenderCtrlAgent** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIRenderCtrlAgent* o;

    if(DR_FAILED(_res_mgr->CreateRenderCtrlAgent(&o)))
        goto __ret;

    o->SetRenderCtrl(_render_ctrl->GetType());

    o->SetLocalMatrix(&_mat_local);
    o->SetParentMatrix(&_mat_parent);
    o->SetVertexDeclaration(_decl_type);
    o->SetVertexShader(_vs_type);

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:   
    return ret;
}
DR_RESULT drRenderCtrlAgent::BeginSet()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_mesh_agent == NULL || _render_ctrl == NULL)
        goto __ret;

    if(DR_FAILED(_mesh_agent->BeginSet()))
        goto __ret;

    if(DR_FAILED(_render_ctrl->BeginSet(this)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drRenderCtrlAgent::EndSet()
{
     DR_RESULT ret = DR_RET_FAILED;

     if(_mesh_agent == NULL || _render_ctrl == NULL)
         goto __ret;

     if(DR_FAILED(_mesh_agent->EndSet()))
         goto __ret;

     if(DR_FAILED(_render_ctrl->EndSet(this)))
         goto __ret;

     ret = DR_RET_OK;
__ret:
     return ret;
}
DR_RESULT drRenderCtrlAgent::BeginSetSubset(DWORD subset)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_mtltex_agent == 0 || _render_ctrl == 0)
        goto __ret;

    if(DR_FAILED(_mtltex_agent->BeginSet()))
        goto __ret;


    if(DR_FAILED(_render_ctrl->BeginSetSubset(subset, this)))
        goto __ret;


    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drRenderCtrlAgent::EndSetSubset(DWORD subset)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_mtltex_agent == 0 || _render_ctrl == 0)
        goto __ret;

    if(DR_FAILED(_mtltex_agent->EndSet()))
            goto __ret;

    if(DR_FAILED(_render_ctrl->EndSetSubset(subset, this)))
            goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drRenderCtrlAgent::DrawSubset(DWORD subset)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_mesh_agent == NULL)
        goto __ret;

    if(DR_FAILED(_mesh_agent->DrawSubset(subset)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}



DR_END
