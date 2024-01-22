//
#include "drAnimCtrlObj.h"
#include "drPoseCtrl.h"
#include "drExpObj.h"

DR_BEGIN

// ===================
// drAnimCtrlObjMat
DR_STD_ILELEMENTATION(drAnimCtrlObjMat)

drAnimCtrlObjMat::drAnimCtrlObjMat(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _anim_ctrl(0)
{ 
    memset(&_type_info, 0, sizeof(_type_info));
    _type_info.type = THIS_TYPE;
    _type_info.data[0] = DR_INVALID_INDEX;
    _type_info.data[1] = DR_INVALID_INDEX;
    drPlayPoseInfo_Construct(&_ppi);
    drMatrix44Identity(&_rtm);
}
drAnimCtrlObjMat::~drAnimCtrlObjMat()
{
    DR_IF_RELEASE(_anim_ctrl);
}
DR_RESULT drAnimCtrlObjMat::Clone(drIAnimCtrlObjMat** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjMat* o = NULL;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&o, THIS_TYPE)))
        goto __ret;

    o->AttachAnimCtrl(_anim_ctrl);
    // 这里以后需要使用drAnimCtrl_Ref来获得引用计数
    if(_anim_ctrl->GetRegisterID() != DR_INVALID_INDEX)
    {
        _res_mgr->AddRefAnimCtrl(_anim_ctrl, 1);
    }

    if(DR_FAILED(o->PlayPose(&_ppi)))
        goto __ret;

    o->SetTypeInfo(&_type_info);
    
    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;

}
drIAnimCtrlMatrix* drAnimCtrlObjMat::AttachAnimCtrl(drIAnimCtrlMatrix* ctrl) 
{ 
    drIAnimCtrlMatrix* ret = _anim_ctrl; 
    _anim_ctrl = ctrl;  
    return ret; 
}
drIAnimCtrlMatrix* drAnimCtrlObjMat::DetachAnimCtrl()
{
    drIAnimCtrlMatrix* ret = _anim_ctrl; 
    _anim_ctrl = 0;  
    return ret; 
}

DR_RESULT drAnimCtrlObjMat::SetTypeInfo(drAnimCtrlObjTypeInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->type != THIS_TYPE)
        goto __ret;

    _type_info = *info;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjMat::GetTypeInfo(drAnimCtrlObjTypeInfo* info) 
{ 
    *info = _type_info;
    return DR_RET_OK;
}

DR_RESULT drAnimCtrlObjMat::PlayPose(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_ctrl == NULL)
        goto __ret;

    if(DR_FAILED(drPlayPoseSmooth(&_ppi, info, _anim_ctrl->GetPoseCtrl())))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drAnimCtrlObjMat::UpdateAnimCtrl()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->UpdatePose(&_ppi)))
        goto __ret;

    if(DR_FAILED(_anim_ctrl->UpdateAnimData(&_ppi)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjMat::UpdateObject()
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->GetRTM(&_rtm)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlObjMat::GetRTM(drMatrix44* mat) 
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __ret;

    *mat = _rtm;

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drAnimCtrlObjBone
DR_STD_ILELEMENTATION(drAnimCtrlObjBone)

drAnimCtrlObjBone::drAnimCtrlObjBone(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _anim_ctrl(0)
{ 
    memset(&_type_info, 0, sizeof(_type_info));
    _type_info.type = THIS_TYPE;
    _type_info.data[0] = DR_INVALID_INDEX;
    _type_info.data[1] = DR_INVALID_INDEX;

    drPlayPoseInfo_Construct(&_ppi);

    _dummy_rtm_seq = 0;
    _dummy_rtm_num = 0;
    _bone_rtm_seq = 0;
    _bone_rtm_num = 0;
}
drAnimCtrlObjBone::~drAnimCtrlObjBone()
{
    DR_IF_RELEASE(_anim_ctrl);

    DR_SAFE_DELETE_A(_dummy_rtm_seq);
    DR_SAFE_DELETE_A(_bone_rtm_seq);
	//DR_SAFE_DELETE_A(mComputedBoneList);
}
DR_RESULT drAnimCtrlObjBone::Clone(drIAnimCtrlObjBone** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjBone* o = NULL;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&o, THIS_TYPE)))
        goto __ret;

    o->AttachAnimCtrl(_anim_ctrl);
    // 这里以后需要使用drAnimCtrl_Ref来获得引用计数
    if(_anim_ctrl->GetRegisterID() != DR_INVALID_INDEX)
    {
        _res_mgr->AddRefAnimCtrl(_anim_ctrl, 1);
    }

    if(DR_FAILED(o->PlayPose(&_ppi)))
        goto __ret;

    o->SetTypeInfo(&_type_info);
    
    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
drIAnimCtrlBone* drAnimCtrlObjBone::AttachAnimCtrl(drIAnimCtrlBone* ctrl) 
{ 
    drIAnimCtrlBone* ret = _anim_ctrl; 
    _anim_ctrl = ctrl;  
    return ret; 
}
drIAnimCtrlBone* drAnimCtrlObjBone::DetachAnimCtrl()
{
    drIAnimCtrlBone* ret = _anim_ctrl; 
    _anim_ctrl = 0;  
    return ret; 
}

DR_RESULT drAnimCtrlObjBone::SetTypeInfo(drAnimCtrlObjTypeInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->type != THIS_TYPE)
        goto __ret;

    _type_info = *info;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjBone::GetTypeInfo(drAnimCtrlObjTypeInfo* info) 
{ 
    *info = _type_info;
    return DR_RET_OK;
}

DR_RESULT drAnimCtrlObjBone::PlayPose(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_ctrl == NULL)
        goto __ret;

    if(DR_FAILED(drPlayPoseSmooth(&_ppi, info, _anim_ctrl->GetPoseCtrl())))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drAnimCtrlObjBone::UpdateAnimCtrl()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_ctrl == NULL || _ppi.type == PLAY_INVALID)
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->UpdatePose(&_ppi)))
        goto __ret;

    if(DR_FAILED(_anim_ctrl->UpdateAnimData(&_ppi)))
        goto __ret;

    if(DR_FAILED(_anim_ctrl->UpdatePoseKeyFrameProc(&_ppi)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlObjBone::UpdateObject(drIAnimCtrlObjBone* ctrl_obj, drIMesh* mesh_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    drAnimCtrlObjBone* o_ctrl_obj = (drAnimCtrlObjBone*)ctrl_obj;

    DWORD dummy_num = _anim_ctrl->GetDummyNum();
    DWORD bone_num = _anim_ctrl->GetBoneNum();

    if(mesh_obj)
    {
        drMeshInfo* mesh_info = mesh_obj->GetMeshInfo();

        if(mesh_info->bone_index_num > 0 && bone_num > 0)
        {
            drMatrix44* bone_rtm = _anim_ctrl->GetBoneRTMSeq();

            if(o_ctrl_obj->_bone_rtm_num == 0)
            {
                o_ctrl_obj->_bone_rtm_num = mesh_info->bone_index_num;
                o_ctrl_obj->_bone_rtm_seq = DR_NEW(drMatrix44[o_ctrl_obj->_bone_rtm_num]);
            }

            for(DWORD i = 0; i < mesh_info->bone_index_num; i++)
            {
				o_ctrl_obj->_bone_rtm_seq[i] = bone_rtm[mesh_info->bone_index_seq[i]];
            }
        }
    }

    if(dummy_num > 0)
    {
        if(o_ctrl_obj->_dummy_rtm_num == 0)
        {
            o_ctrl_obj->_dummy_rtm_num = dummy_num;
            o_ctrl_obj->_dummy_rtm_seq = DR_NEW(drIndexMatrix44[o_ctrl_obj->_dummy_rtm_num]);
        }

        drIndexMatrix44* dummy_rtm = _anim_ctrl->GetDummyRTMSeq();
        memcpy(o_ctrl_obj->_dummy_rtm_seq, dummy_rtm, sizeof(drIndexMatrix44) * o_ctrl_obj->_dummy_rtm_num); 
    }

__addr_ret_ok:
    ret = DR_RET_OK;

    return ret;
}

DR_RESULT drAnimCtrlObjBone::UpdateHelperObject(drIHelperObject* helper_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    // 这里不用IsPlaying()来作为判断条件，因为当drAnimCtrlObjBone为
    // 容器时，其并不做Playing，但是需要更新HelperObject
    //if(!IsPlaying() || helper_obj == 0)
    if(_dummy_rtm_num == 0 || helper_obj == 0)
        goto __addr_ret_ok;

    drIBoundingSphere* b = helper_obj->GetBoundingSphere();
    drIHelperDummy* d = helper_obj->GetHelperDummy();

    if(b)
    {
        drBoundingSphereInfo* s;
        DWORD num = b->GetObjNum();

        for(DWORD j = 0; j < num; j++)
        {
            s = b->GetDataInfo(j);

            assert(s->id < DR_MAX_BONEDUMMY_NUM);

            drMatrix44* mat = GetDummyRTM(s->id);
            if(mat)
            {
                s->mat = *mat;
            }
        }
    }

    if(d)
    {
        drHelperDummyInfo* di;
        DWORD num = d->GetObjNum();

        for(DWORD i = 0; i < num; i++)
        {
            di = d->GetDataInfo(i);
            // now only support 2
            if(di->parent_type == 2)
            {
                drMatrix44* mat = GetDummyRTM(di->parent_id);
                if(mat)
                {
                    //drMatrix44 inv_mat;
                    //drMatrix44Inverse(&inv_mat, NULL, &di->mat_local);
                    //drMatrix44Multiply(&di->mat, &inv_mat, mat);
                    drMatrix44Multiply(&di->mat, &di->mat_local, mat);
                }
            }
        }
    }

__addr_ret_ok:
    ret = DR_RET_OK;

    return ret;
}

drMatrix44* drAnimCtrlObjBone::GetDummyRTM(DWORD id)
{
    for(DWORD i = 0; i < _dummy_rtm_num; i++)
    {
        if(_dummy_rtm_seq[i].id == id)
            return &_dummy_rtm_seq[i].mat;
    }

    return NULL;
}

// drAnimCtrlObjTexUV
DR_STD_ILELEMENTATION(drAnimCtrlObjTexUV)

drAnimCtrlObjTexUV::drAnimCtrlObjTexUV(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _anim_ctrl(0)
{
    memset(&_type_info, 0, sizeof(_type_info));
    _type_info.type = THIS_TYPE;
    drPlayPoseInfo_Construct(&_ppi);
    drMatrix44Identity(&_rtm);
}
drAnimCtrlObjTexUV::~drAnimCtrlObjTexUV()
{
    DR_IF_RELEASE(_anim_ctrl);
}

DR_RESULT drAnimCtrlObjTexUV::Clone(drIAnimCtrlObjTexUV** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTexUV* o = NULL;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&o, THIS_TYPE)))
        goto __ret;

    o->AttachAnimCtrl(_anim_ctrl);
    // 这里以后需要使用drAnimCtrl_Ref来获得引用计数
    if(_anim_ctrl->GetRegisterID() != DR_INVALID_INDEX)
    {
        _res_mgr->AddRefAnimCtrl(_anim_ctrl, 1);
    }

    if(DR_FAILED(o->PlayPose(&_ppi)))
        goto __ret;

    o->SetTypeInfo(&_type_info);
    
    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;

}

drIAnimCtrlTexUV* drAnimCtrlObjTexUV::AttachAnimCtrl(drIAnimCtrlTexUV* ctrl) 
{ 
    drIAnimCtrlTexUV* ret = _anim_ctrl; 
    _anim_ctrl = ctrl;  
    return ret; 
}
drIAnimCtrlTexUV* drAnimCtrlObjTexUV::DetachAnimCtrl()
{
    drIAnimCtrlTexUV* ret = _anim_ctrl; 
    _anim_ctrl = 0;  
    return ret; 
}

DR_RESULT drAnimCtrlObjTexUV::SetTypeInfo(drAnimCtrlObjTypeInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->type != THIS_TYPE)
        goto __ret;

    _type_info = *info;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjTexUV::GetTypeInfo(drAnimCtrlObjTypeInfo* info) 
{ 
    *info = _type_info;
    return DR_RET_OK;
}

DR_RESULT drAnimCtrlObjTexUV::PlayPose(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_ctrl == NULL)
        goto __ret;

    if(DR_FAILED(drPlayPoseSmooth(&_ppi, info, _anim_ctrl->GetPoseCtrl())))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
//extern void* g_pAnimCtrlTexUV;
//void* g_drAnimCtrlObjTexUV = NULL;
DR_RESULT drAnimCtrlObjTexUV::UpdateAnimCtrl()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->UpdatePose(&_ppi)))
        goto __ret;

// 	if( NULL==g_drAnimCtrlObjTexUV )
// 	{
// 		if( _anim_ctrl==g_pAnimCtrlTexUV )
// 			g_drAnimCtrlObjTexUV = this;
// 	}

    if(DR_FAILED(_anim_ctrl->UpdateAnimData(&_ppi)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjTexUV::UpdateObject()
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->GetRunTimeMatrix(&_rtm)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlObjTexUV::GetRTM(drMatrix44* mat) 
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __ret;

    *mat = _rtm;

    ret = DR_RET_OK;
__ret:
    return ret;
}


// drAnimCtrlObjTexImg
DR_STD_ILELEMENTATION(drAnimCtrlObjTexImg)

drAnimCtrlObjTexImg::drAnimCtrlObjTexImg(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _anim_ctrl(0)
{
    memset(&_type_info, 0, sizeof(_type_info));
    _type_info.type = THIS_TYPE;
    drPlayPoseInfo_Construct(&_ppi);
    _rt_tex = 0;
}
drAnimCtrlObjTexImg::~drAnimCtrlObjTexImg()
{
    DR_IF_RELEASE(_anim_ctrl);
}
DR_RESULT drAnimCtrlObjTexImg::Clone(drIAnimCtrlObjTexImg** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTexImg* o = NULL;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&o, THIS_TYPE)))
        goto __ret;

    o->AttachAnimCtrl(_anim_ctrl);
    // 这里以后需要使用drAnimCtrl_Ref来获得引用计数
    if(_anim_ctrl->GetRegisterID() != DR_INVALID_INDEX)
    {
        _res_mgr->AddRefAnimCtrl(_anim_ctrl, 1);
    }

    if(DR_FAILED(o->PlayPose(&_ppi)))
        goto __ret;

    o->SetTypeInfo(&_type_info);

    o->_rt_tex = _rt_tex;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;

}
drIAnimCtrlTexImg* drAnimCtrlObjTexImg::AttachAnimCtrl(drIAnimCtrlTexImg* ctrl) 
{ 
    drIAnimCtrlTexImg* ret = _anim_ctrl; 
    _anim_ctrl = ctrl;  
    return ret; 
}
drIAnimCtrlTexImg* drAnimCtrlObjTexImg::DetachAnimCtrl()
{
    drIAnimCtrlTexImg* ret = _anim_ctrl; 
    _anim_ctrl = 0;  
    return ret; 
}

DR_RESULT drAnimCtrlObjTexImg::SetTypeInfo(drAnimCtrlObjTypeInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->type != THIS_TYPE)
        goto __ret;

    _type_info = *info;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjTexImg::GetTypeInfo(drAnimCtrlObjTypeInfo* info) 
{ 
    *info = _type_info;
    return DR_RET_OK;
}

DR_RESULT drAnimCtrlObjTexImg::PlayPose(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_ctrl == NULL)
        goto __ret;

    if(DR_FAILED(drPlayPoseSmooth(&_ppi, info, _anim_ctrl->GetPoseCtrl())))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drAnimCtrlObjTexImg::UpdateAnimCtrl()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->UpdatePose(&_ppi)))
        goto __ret;

    if(DR_FAILED(_anim_ctrl->UpdateAnimData(&_ppi)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjTexImg::UpdateObject()
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->GetRunTimeTex(&_rt_tex)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlObjTexImg::GetRunTimeTex(drITex** tex)
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __ret;

    *tex = _rt_tex;

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drAnimCtrlObjMtlOpacity
DR_STD_ILELEMENTATION(drAnimCtrlObjMtlOpacity)

drAnimCtrlObjMtlOpacity::drAnimCtrlObjMtlOpacity(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _anim_ctrl(0)
{
    memset(&_type_info, 0, sizeof(_type_info));
    _type_info.type = THIS_TYPE;
    drPlayPoseInfo_Construct(&_ppi);
    _rt_opacity = 0;
}
drAnimCtrlObjMtlOpacity::~drAnimCtrlObjMtlOpacity()
{
    DR_IF_RELEASE(_anim_ctrl);
}
DR_RESULT drAnimCtrlObjMtlOpacity::Clone(drIAnimCtrlObjMtlOpacity** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjMtlOpacity* o = NULL;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&o, THIS_TYPE)))
        goto __ret;

    o->AttachAnimCtrl(_anim_ctrl);
    // 这里以后需要使用drAnimCtrl_Ref来获得引用计数
    if(_anim_ctrl->GetRegisterID() != DR_INVALID_INDEX)
    {
        _res_mgr->AddRefAnimCtrl(_anim_ctrl, 1);
    }

    if(DR_FAILED(o->PlayPose(&_ppi)))
        goto __ret;

    o->SetTypeInfo(&_type_info);

    o->_rt_opacity = _rt_opacity;

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;

}
drIAnimCtrlMtlOpacity* drAnimCtrlObjMtlOpacity::AttachAnimCtrl(drIAnimCtrlMtlOpacity* ctrl) 
{ 
    drIAnimCtrlMtlOpacity* ret = _anim_ctrl; 
    _anim_ctrl = ctrl;  
    return ret; 
}
drIAnimCtrlMtlOpacity* drAnimCtrlObjMtlOpacity::DetachAnimCtrl()
{
    drIAnimCtrlMtlOpacity* ret = _anim_ctrl; 
    _anim_ctrl = 0;  
    return ret; 
}

DR_RESULT drAnimCtrlObjMtlOpacity::SetTypeInfo(drAnimCtrlObjTypeInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->type != THIS_TYPE)
        goto __ret;

    _type_info = *info;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjMtlOpacity::GetTypeInfo(drAnimCtrlObjTypeInfo* info) 
{ 
    *info = _type_info;
    return DR_RET_OK;
}

DR_RESULT drAnimCtrlObjMtlOpacity::PlayPose(const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_ctrl == NULL)
        goto __ret;

    if(DR_FAILED(drPlayPoseSmooth(&_ppi, info, _anim_ctrl->GetPoseCtrl())))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drAnimCtrlObjMtlOpacity::UpdateAnimCtrl()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->UpdatePose(&_ppi)))
        goto __ret;

    if(DR_FAILED(_anim_ctrl->UpdateAnimData(&_ppi)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drAnimCtrlObjMtlOpacity::UpdateObject()
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __addr_ret_ok;

    if(DR_FAILED(_anim_ctrl->GetRunTimeOpacity(&_rt_opacity)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlObjMtlOpacity::GetRunTimeOpacity(float* opacity)
{ 
    DR_RESULT ret = DR_RET_FAILED;

    if(!IsPlaying())
        goto __ret;

    *opacity = _rt_opacity;

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drAnimCtrlAgent
DR_STD_ILELEMENTATION(drAnimCtrlAgent)

drAnimCtrlAgent::drAnimCtrlAgent(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _obj_seq(0), _obj_num(0)
{
}

drAnimCtrlAgent::~drAnimCtrlAgent()
{
    for(DWORD i = 0; i < _obj_num; i++)
    {
        _obj_seq[i]->Release();
    }

    DR_SAFE_DELETE_A(_obj_seq);
}

DR_RESULT drAnimCtrlAgent::AddAnimCtrlObj(drIAnimCtrlObj* obj)
{
    if(_obj_num == 0)
    {
        _obj_seq = DR_NEW(drIAnimCtrlObj*[1]);
    }
    else
    {
        drIAnimCtrlObj** new_buf = DR_NEW(drIAnimCtrlObj*[_obj_num+1]);
        memcpy(new_buf, _obj_seq, sizeof(drIAnimCtrlObj*) * _obj_num);
        DR_DELETE_A(_obj_seq);
        _obj_seq = new_buf;
    }

    _obj_seq[_obj_num++] = obj;

    return DR_RET_OK;
}
drIAnimCtrlObj* drAnimCtrlAgent::RemoveAnimCtrlObj(drAnimCtrlObjTypeInfo* info)
{
    drIAnimCtrlObj* o;
    drAnimCtrlObjTypeInfo o_info;
    for(DWORD i = 0; i < _obj_num; i++)
    {
        o = _obj_seq[i];
        o->GetTypeInfo(&o_info);

        if(o_info.type == info->type 
            && o_info.data[0] == info->data[0]
            && o_info.data[1] == info->data[1])
        {
            if(_obj_num == 1)
            {
                DR_DELETE_A(_obj_seq);
                _obj_seq = 0;
            }
            else
            {
                drIAnimCtrlObj** new_buf = DR_NEW(drIAnimCtrlObj*[_obj_num-1]);
                memcpy(new_buf, _obj_seq, sizeof(drIAnimCtrlObj*) * i);
                memcpy(&new_buf[i], &_obj_seq[i+1], sizeof(drIAnimCtrlObj*) * (_obj_num - i - 1));
                DR_DELETE_A(_obj_seq);
                _obj_seq = new_buf;
            }
            _obj_num -= 1;

            return o;
        }
    }

    return NULL;
}

drIAnimCtrlObj* drAnimCtrlAgent::GetAnimCtrlObj(drAnimCtrlObjTypeInfo* info)
{
    drIAnimCtrlObj* o;
    drAnimCtrlObjTypeInfo o_info;
    for(DWORD i = 0; i < _obj_num; i++)
    {
        o = _obj_seq[i];
        o->GetTypeInfo(&o_info);

        if(o_info.type == info->type 
            && o_info.data[0] == info->data[0]
            && o_info.data[1] == info->data[1])
        {
            return o;
        }
    }
    return NULL;
}

//void* g_drAnimCtrlAgent = NULL;
DR_RESULT drAnimCtrlAgent::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        if(DR_FAILED(_obj_seq[i]->UpdateAnimCtrl()))
            goto __ret;

// 		if( NULL==g_drAnimCtrlAgent )
// 		{
// 			if( _obj_seq[i]==g_drAnimCtrlObjTexUV )
// 				g_drAnimCtrlAgent = this;
// 		}
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drAnimCtrlAgent::Clone(drIAnimCtrlAgent** ret_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTypeInfo type_info;
    drIAnimCtrlAgent* agent = 0;


    drIAnimCtrlObj* obj = 0;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlAgent(&agent)))
        goto __ret;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        _obj_seq[i]->GetTypeInfo(&type_info);

        switch(type_info.type)
        {
        case ANIM_CTRL_TYPE_MAT:
            ret = ((drIAnimCtrlObjMat*)_obj_seq[i])->Clone((drIAnimCtrlObjMat**)&obj);
            break;
        case ANIM_CTRL_TYPE_BONE:
            ret = ((drIAnimCtrlObjBone*)_obj_seq[i])->Clone((drIAnimCtrlObjBone**)&obj);
            break;
        case ANIM_CTRL_TYPE_TEXUV:
            ret = ((drIAnimCtrlObjTexUV*)_obj_seq[i])->Clone((drIAnimCtrlObjTexUV**)&obj);
            break;
        case ANIM_CTRL_TYPE_TEXIMG:
            ret = ((drIAnimCtrlObjTexImg*)_obj_seq[i])->Clone((drIAnimCtrlObjTexImg**)&obj);
            break;
        case ANIM_CTRL_TYPE_MTLOPACITY:
            ret = ((drIAnimCtrlObjMtlOpacity*)_obj_seq[i])->Clone((drIAnimCtrlObjMtlOpacity**)&obj);
            break;
        default:
            __asm int 3;
        }

        if(DR_FAILED(ret))
            goto __ret;

        if(DR_FAILED(agent->AddAnimCtrlObj(obj)))
            goto __ret;

        obj = 0;
    }

    *ret_obj = agent;
    agent = 0;

    ret = DR_RET_OK;
__ret:
    if(obj)
        obj->Release();
    if(agent)
        agent->Release();
    return ret;
}

DR_RESULT drAnimCtrlAgent::ExtractAnimData(drIAnimDataInfo* data_info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTypeInfo type_info;

    drAnimDataInfo* a = (drAnimDataInfo*)data_info;
    
    for(DWORD i = 0; i < _obj_num; i++)
    {
        drIAnimCtrlObj* aco = _obj_seq[i];
        aco->GetTypeInfo(&type_info);

        DWORD ctrl_type = type_info.type;
        DWORD subset = type_info.data[0];
        DWORD stage = type_info.data[1];

        switch(ctrl_type)
        {
        case ANIM_CTRL_TYPE_MAT:
            {
                drIAnimCtrlMatrix* ctrl_obj = (drIAnimCtrlMatrix*)aco->GetAnimCtrl();
                drAnimDataMatrix* out_data = DR_NEW(drAnimDataMatrix);
                if(DR_FAILED(ctrl_obj->ExtractAnimData(out_data)))
                    goto __ret;
                a->anim_mat = out_data;
            }
            break;
        case ANIM_CTRL_TYPE_BONE:
            {
                drIAnimCtrlBone* ctrl_obj = (drIAnimCtrlBone*)aco->GetAnimCtrl();
                drAnimDataBone* out_data = DR_NEW(drAnimDataBone);
                if(DR_FAILED(ctrl_obj->ExtractAnimData(out_data)))
                    goto __ret;
                a->anim_bone = out_data;
            }
            break;
        case ANIM_CTRL_TYPE_TEXUV:
            {
                drIAnimCtrlTexUV* ctrl_obj = (drIAnimCtrlTexUV*)aco->GetAnimCtrl();;  
                drAnimDataTexUV* out_data = DR_NEW(drAnimDataTexUV);
                if(DR_FAILED(ctrl_obj->ExtractAnimData(out_data)))
                    goto __ret;
                a->anim_tex[subset][stage] = out_data;
            }
            break;
        case ANIM_CTRL_TYPE_TEXIMG:
            {
                drIAnimCtrlTexImg* ctrl_obj = (drIAnimCtrlTexImg*)aco->GetAnimCtrl();           
                drAnimDataTexImg* out_data = DR_NEW(drAnimDataTexImg);
                if(DR_FAILED(ctrl_obj->ExtractAnimData(out_data)))
                    goto __ret;
                a->anim_img[subset][stage] = out_data;
            }
            break;
        default:
            goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_END
