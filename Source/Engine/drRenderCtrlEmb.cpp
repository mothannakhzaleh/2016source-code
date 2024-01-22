//


#include "drRenderCtrlEmb.h"

DR_BEGIN

drIRenderCtrlVS* __RenderCtrlVSProcFixedFuntion()
{
    return DR_NEW(drRenderCtrlVSFixedFunction);
}

DR_RESULT drInitInternalRenderCtrlVSProc(drIResourceMgr* mgr)
{
    mgr->RegisterRenderCtrlProc(RENDERCTRL_VS_FIXEDFUNCTION, __RenderCtrlVSProcFixedFuntion);

    return DR_RET_OK;
}

// drRenderCtrlVSFixedFunction
DR_STD_ILELEMENTATION(drRenderCtrlVSFixedFunction);

DR_RESULT drRenderCtrlVSFixedFunction::Clone(drIRenderCtrlVS** obj)
{
    this_type* o = DR_NEW(this_type);
    *o = *this;

    *obj = o;

    return DR_RET_OK;
}
DR_RESULT drRenderCtrlVSFixedFunction::Initialize(drIRenderCtrlAgent* agent)
{
    return DR_RET_OK;
}

DR_RESULT drRenderCtrlVSFixedFunction::BeginSet(drIRenderCtrlAgent* agent)
{
    drIResourceMgr* res_mgr = agent->GetResourceMgr();
    drIDeviceObject* dev_obj = res_mgr->GetDeviceObject();
    dev_obj->SetTransformWorld(agent->GetGlobalMatrix());
    
    return DR_RET_OK;
}
DR_RESULT drRenderCtrlVSFixedFunction::EndSet(drIRenderCtrlAgent* agent)
{
    return DR_RET_OK;
}
DR_RESULT drRenderCtrlVSFixedFunction::BeginSetSubset(DWORD subset, drIRenderCtrlAgent* agent)
{
    drIResourceMgr* res_mgr = agent->GetResourceMgr();
    drIDeviceObject* dev_obj = res_mgr->GetDeviceObject();

    drIAnimCtrlAgent* anim_agent = agent->GetAnimCtrlAgent();

    if(anim_agent == 0)
        goto __ret;

    DWORD animobj_num = anim_agent->GetAnimCtrlObjNum();
    drIAnimCtrlObj* animctrl_obj;
    drAnimCtrlObjTypeInfo type_info;

    for(DWORD i = 0; i < animobj_num; i++)
    {
        animctrl_obj = anim_agent->GetAnimCtrlObj(i);
        animctrl_obj->GetTypeInfo(&type_info);

        BOOL play_type = animctrl_obj->IsPlaying();

        if((type_info.data[0] == subset) && play_type)
        {
            DWORD anim_type = type_info.type;
            DWORD stage_id = type_info.data[1];

            if(anim_type == ANIM_CTRL_TYPE_TEXUV)
            {
                drIAnimCtrlObjTexUV* this_ctrl = (drIAnimCtrlObjTexUV*)animctrl_obj;

                drMatrix44 mat;
                this_ctrl->GetRTM(&mat);

                dev_obj->SetTransform((D3DTRANSFORMSTATETYPE)(D3DTS_TEXTURE0 + stage_id), &mat);
                dev_obj->SetTextureStageState(stage_id, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_COUNT2);
            }
            // moved into Primitive.Update procedure
            //else if(anim_type == ANIM_CTRL_TYPE_MTLOPACITY)
            //{
            //    drIAnimCtrlObjMtlOpacity* this_ctrl = (drIAnimCtrlObjMtlOpacity*)animctrl_obj;

            //    float opacity = 1.0f;
            //    if(DR_SUCCEEDED(this_ctrl->GetRunTimeOpacity(&opacity)))
            //    {
            //        agent->GetMtlTexAgent()->SetOpacity(opacity);
            //    }
            //}
        }
    }
__ret:
    return DR_RET_OK;
}
DR_RESULT drRenderCtrlVSFixedFunction::EndSetSubset(DWORD subset, drIRenderCtrlAgent* agent)
{
    drIResourceMgr* res_mgr = agent->GetResourceMgr();
    drIDeviceObject* dev_obj = res_mgr->GetDeviceObject();

    drIAnimCtrlAgent* anim_agent = agent->GetAnimCtrlAgent();

    if(anim_agent == 0)
        goto __ret;

    DWORD animobj_num = anim_agent->GetAnimCtrlObjNum();
    drIAnimCtrlObj* animctrl_obj;
    drAnimCtrlObjTypeInfo type_info;

    for(DWORD i = 0; i < animobj_num; i++)
    {
        animctrl_obj = anim_agent->GetAnimCtrlObj(i);
        animctrl_obj->GetTypeInfo(&type_info);

        BOOL play_type = animctrl_obj->IsPlaying();

        if((type_info.data[0] == subset) && (play_type != PLAY_INVALID))
        {
            DWORD anim_type = type_info.type;
            DWORD stage_id = type_info.data[1];

            if(anim_type == ANIM_CTRL_TYPE_TEXUV)
            {
                dev_obj->SetTextureStageState(stage_id, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_DISABLE);
            }
            //else if(anim_type == ANIM_CTRL_TYPE_TEXIMG)
            //{
            //    drIAnimCtrlObjTexImg* this_ctrl = (drIAnimCtrlObjTexImg*)animctrl_obj;
            //    drITex* this_tex = this_ctrl->GetRunTimeTex();
            //    this_tex->EndSet();
            //}
        }
    }

__ret:
    return DR_RET_OK;
}


DR_END
