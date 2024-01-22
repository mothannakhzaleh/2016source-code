//


#include "drPrimitive.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drAnimCtrl.h"
#include "drPathInfo.h"
#include "drD3D.h"
#include "drShaderMgr.h"
#include "drResourceMgr.h"
#include "drRenderImp.h"

#define USE_VS_INDEXED

DR_BEGIN

//DR_STD_RELEASE( drPrimitive )
//
//DR_RESULT drPrimitive::GetInterface( DR_VOID** i, drGUID guid )
//{ 
//    DR_RESULT ret = DR_RET_FAILED;
//
//    //switch( guid )
//    //{
//    //default:
//    //    ret = DR_RET_NULL;
//    //}
//
//    return ret;
//}
DR_STD_ILELEMENTATION(drPrimitive)

// drPrimitive
drPrimitive::drPrimitive( drIResourceMgr* mgr )
: _res_mgr(mgr), _id(DR_INVALID_INDEX), _parent_id( DR_INVALID_INDEX ), _helper_object(0)
{
    _anim_agent = NULL;
    _render_agent = NULL;
    _mesh_agent = NULL;

    memset(_mtltex_agent_seq, 0, sizeof(_mtltex_agent_seq));

    _state_ctrl.SetState(STATE_FRAMECULLING, 0);
}

drPrimitive::~drPrimitive()
{
    Destroy();
}

DR_RESULT drPrimitive::_UpdateTransparentState()
{
    // i recommend this procedure to be invoked when initialize and something changing
    // of transparent state such as opacity, additive/subtractive blend state.
    // consequently it is not advised to update per-frame
    BYTE state = 1;
    drIMtlTexAgent* mtltex_agent;

    if(_state_ctrl.GetState(STATE_UPDATETRANSPSTATE) == 0)
        goto __ret;

    for( DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++ )
    {
        if((mtltex_agent = _mtltex_agent_seq[ i ]) == NULL )
            break;

        if(mtltex_agent->GetOpacity() != 1.0f)
            goto __set_state;

        if(mtltex_agent->GetTransparencyType() != MTLTEX_TRANSP_FILTER)
            goto __set_state;
    }

    state = 0;

__set_state:
    _state_ctrl.SetState(STATE_TRANSPARENT, state);
__ret:
    return DR_RET_OK;
}

DR_RESULT drPrimitive::DestroyMtlTexAgent( DWORD subset )
{
    DR_SAFE_RELEASE( _mtltex_agent_seq[ subset ] );
    return DR_RET_OK;
}

DR_RESULT drPrimitive::DestroyMeshAgent()
{
    DR_SAFE_RELEASE( _mesh_agent );
    return DR_RET_OK;
}
DR_RESULT drPrimitive::DestroyRenderCtrlAgent()
{
    DR_SAFE_RELEASE(_render_agent);
    return DR_RET_OK;
}

DR_RESULT drPrimitive::Destroy()
{
    DestroyMeshAgent();

    for( DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++ )
    {
        DestroyMtlTexAgent( i );
    }

    DR_SAFE_RELEASE(_anim_agent);
    DR_SAFE_RELEASE(_helper_object);
    DestroyRenderCtrlAgent();

    return DR_RET_OK;
}


DR_RESULT drPrimitive::LoadMtlTex( DWORD mtl_id, drMtlTexInfo* info, const char* tex_path )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( mtl_id < 0 || mtl_id >= DR_MAX_SUBSET_NUM )
        goto __ret;

    if( DR_FAILED( _res_mgr->CreateMtlTexAgent( &_mtltex_agent_seq[ mtl_id ] ) ) )
        goto __ret;

    if( DR_FAILED( _mtltex_agent_seq[ mtl_id ]->LoadMtlTex( info, tex_path ) ) )
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::Load( drIGeomObjInfo* geom_info, const char* tex_path, const drResFile* res )
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD i;

    drGeomObjInfo* info = (drGeomObjInfo*)geom_info;

    drISystem* sys = _res_mgr->GetSysGraphics()->GetSystem();
    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    BYTE create_helper_primitive = opt_mgr->GetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE);

    //info->rcci.ctrl_id = 2;
    //info->rcci.vs_id = VST_PNDT0_LD_TT0;

    if(DR_FAILED(LoadRenderCtrl(&info->rcci)))
        goto __ret;

    // begin base info

    _id = info->id;
    _parent_id = info->parent_id;
    _render_agent->SetLocalMatrix( &info->mat_local );
    _state_ctrl = info->state_ctrl;
    //

    // mtltex info
    for( i = 0; i < info->mtl_num; i++ )
    {
        if( DR_FAILED( LoadMtlTex( i, &info->mtl_seq[ i ], tex_path ) ) )
            goto __ret;
    }

    // mesh info
    if( DR_FAILED( LoadMesh( &info->mesh ) ) )
        goto __ret;

    if( res )
    {
        drResFileMesh info;
        info.obj_id = res->obj_id;
        info.res_type = res->res_type;
        _tcsncpy_s( info.file_name, res->file_name, _TRUNCATE );

        _mesh_agent->GetMesh()->SetResFile( &info );
    }

    // helper info
    if( info->helper_data.type != HELPER_TYPE_INVALID )
    {
        DR_IF_RELEASE(_helper_object);
        _res_mgr->CreateHelperObject(&_helper_object);
        if(DR_FAILED(_helper_object->LoadHelperInfo(&info->helper_data, create_helper_primitive)))
        {
            drMessageBox("LoadHelperInfo");
        }
    }

    // anim info
    if( info->anim_size > 0 )
    {
        if( DR_FAILED( LoadAnimData( &info->anim_data, tex_path, res ) ) )
            goto __ret;
    }


    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::LoadMesh( drMeshInfo* info )
{
    DR_RESULT ret = DR_RET_FAILED;

    DR_SAFE_RELEASE( _mesh_agent );

    if( DR_FAILED( _res_mgr->CreateMeshAgent( &_mesh_agent ) ) )
        goto __ret;

    if( DR_FAILED( _mesh_agent->LoadMesh( info ) ) )
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::LoadMesh( const drResFileMesh* info )
{
    DR_RESULT ret = DR_RET_FAILED;

    DR_SAFE_RELEASE( _mesh_agent );

    if( DR_FAILED( _res_mgr->CreateMeshAgent( &_mesh_agent ) ) )
        goto __ret;

    if( DR_FAILED( _mesh_agent->LoadMesh( info ) ) )
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::LoadRenderCtrl(const drRenderCtrlCreateInfo* rcci)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIRenderCtrl* render_ctrl = 0;
    drIRenderCtrlAgent* render_agent = 0;

    if(_render_agent)
        goto __ret;


    render_agent = DR_NEW(drRenderCtrlAgent(_res_mgr));
    render_agent->SetVertexDeclaration(rcci->decl_id);
    render_agent->SetVertexShader(rcci->vs_id);

    if(DR_FAILED(render_agent->SetRenderCtrl(rcci->ctrl_id)))
        goto __ret;

    _render_agent = render_agent;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::LoadAnimData( drIAnimDataInfo* data_info, const char* tex_path, const drResFile* res )
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimDataInfo* info = (drAnimDataInfo*)data_info;

    void* data;
    drAnimCtrlObjTypeInfo type_info;

    //DR_SAFE_RELEASE(_anim_agent);
    if(_anim_agent == 0)
    {
        if(DR_FAILED(_res_mgr->CreateAnimCtrlAgent(&_anim_agent)))
            goto __ret;
    }


    if(info->anim_mat)
    {
        data = info->anim_mat;

        type_info.type = ANIM_CTRL_TYPE_MAT;
        type_info.data[0] = DR_INVALID_INDEX;
        type_info.data[1] = DR_INVALID_INDEX;

        drIAnimCtrlMatrix* ctrl = NULL;
        drIAnimCtrlObjMat* ctrl_obj = NULL;

        if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj, type_info.type)))
            goto __ret;

        if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl, type_info.type)))
            goto __ret;

        if(DR_FAILED(ctrl->LoadData(data)))
            goto __ret;

        ctrl_obj->AttachAnimCtrl(ctrl);
        ctrl_obj->SetTypeInfo(&type_info);
        _anim_agent->AddAnimCtrlObj(ctrl_obj);        
    }
    if(info->anim_bone)
    {
        data = info->anim_bone;

        type_info.type = ANIM_CTRL_TYPE_BONE;
        type_info.data[0] = DR_INVALID_INDEX;
        type_info.data[1] = DR_INVALID_INDEX;

        drIAnimCtrlMatrix* ctrl = NULL;
        drIAnimCtrlObjMat* ctrl_obj = NULL;



        if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj, type_info.type)))
            goto __ret;

        if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl, type_info.type)))
            goto __ret;

        if(DR_FAILED(ctrl->LoadData(data)))
            goto __ret;

        ctrl_obj->AttachAnimCtrl(ctrl);
        ctrl_obj->SetTypeInfo(&type_info);
        _anim_agent->AddAnimCtrlObj(ctrl_obj);        

    }


    for( DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++ )
    {
        if( _mtltex_agent_seq[ i ] == NULL )
            continue;

        if(info->anim_mtlopac[i])
        {
            data = info->anim_mtlopac[i];

            type_info.type = ANIM_CTRL_TYPE_MTLOPACITY;
            type_info.data[0] = i;
            type_info.data[1] = DR_INVALID_INDEX;


            drIAnimCtrlMtlOpacity* ctrl = NULL;
            drIAnimCtrlObjMtlOpacity* ctrl_obj = NULL;

            if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj, type_info.type)))
                goto __ret;

            if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl, type_info.type)))
                goto __ret;

            if(DR_FAILED(ctrl->LoadData(data)))
                goto __ret;

            ctrl_obj->AttachAnimCtrl(ctrl);
            ctrl_obj->SetTypeInfo(&type_info);
            _anim_agent->AddAnimCtrlObj(ctrl_obj); 
        }

        for( DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++ )
        {
            if(info->anim_tex[ i ][ j ])
            {
                data = info->anim_tex[ i ][ j ];

                type_info.type = ANIM_CTRL_TYPE_TEXUV;
                type_info.data[0] = i;
                type_info.data[1] = j;


                drIAnimCtrlTexUV* ctrl = NULL;
                drIAnimCtrlObjTexUV* ctrl_obj = NULL;

                if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj, type_info.type)))
                    goto __ret;

                if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl, type_info.type)))
                    goto __ret;

                if(DR_FAILED(ctrl->LoadData(data)))
                    goto __ret;

                ctrl_obj->AttachAnimCtrl(ctrl);
                ctrl_obj->SetTypeInfo(&type_info);
                _anim_agent->AddAnimCtrlObj(ctrl_obj);        
            }

            //continue;
            // image
            if(info->anim_img[i][j])
            {
                data = info->anim_img[i][j];

                type_info.type = ANIM_CTRL_TYPE_TEXIMG;
                type_info.data[0] = i;
                type_info.data[1] = j;

                _tcsncpy_s(info->anim_img[i][j]->_tex_path, tex_path, _TRUNCATE);

                drIAnimCtrlTexImg* ctrl = NULL;
                drIAnimCtrlObjTexImg* ctrl_obj = NULL;

                if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj, type_info.type)))
                    goto __ret;

                if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl, type_info.type)))
                    goto __ret;

                if(DR_FAILED(ctrl->LoadData(data)))
                    goto __ret;

                ctrl_obj->AttachAnimCtrl(ctrl);
                ctrl_obj->SetTypeInfo(&type_info);
                _anim_agent->AddAnimCtrlObj(ctrl_obj);        
            }

        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::Clone( drIPrimitive** ret_obj )
{
    DR_RESULT ret = DR_RET_FAILED;

    drIPrimitive* o;
    
    _res_mgr->CreatePrimitive( &o );

    o->SetID(_id);
    o->SetParentID( _parent_id );
    o->SetState(&_state_ctrl);

    if( _mesh_agent )
    {
        drIMeshAgent* mesh_agent;
        if(DR_FAILED(_mesh_agent->Clone(&mesh_agent )))
            goto __ret;

        o->SetMeshAgent( mesh_agent );
    }

    for( DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++ )
    {
        if( _mtltex_agent_seq[ i ] == NULL )
            continue;

        drIMtlTexAgent* mtltex_agent;
        if(DR_FAILED(_mtltex_agent_seq[ i ]->Clone( &mtltex_agent )))
            goto __ret;

        o->SetMtlTexAgent( i, mtltex_agent );
    }
        
    if(_anim_agent)
    {
        drIAnimCtrlAgent* anim_agent;
        if(DR_FAILED(_anim_agent->Clone(&anim_agent)))
            goto __ret;
        o->SetAnimCtrlAgent(anim_agent);
    }

    if(_render_agent)
    {
        drIRenderCtrlAgent* render_agent;
        if(DR_FAILED(_render_agent->Clone(&render_agent)))
            goto __ret;
        o->SetRenderCtrl(render_agent);
    }

    if(_helper_object)
    {
        drIHelperObject* helper_obj;
        _helper_object->Clone(&helper_obj);
        o->SetHelperObject(helper_obj);
    }

    *ret_obj = o;

    ret = DR_RET_OK;
__ret:
    return ret;
}
void drPrimitive::SetMatrixLocal( const drMatrix44* mat )
{
    if( _render_agent )
    {
        _render_agent->SetLocalMatrix( mat );
    }
}

void drPrimitive::SetMatrixParent( const drMatrix44* mat )
{
    if( _render_agent )
    {
        _render_agent->SetParentMatrix( mat );
    }
}

void drPrimitive::SetMaterial(const drMaterial* mtl)
{
    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if( _mtltex_agent_seq[i] == NULL )
            continue;

        _mtltex_agent_seq[i]->SetMaterial(mtl);
    }
}

void drPrimitive::SetOpacity(float opacity)
{
    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(_mtltex_agent_seq[i] == NULL)
            continue;

        _mtltex_agent_seq[i]->SetOpacity(opacity);
    }

    //SetState(STATE_TRANSPARENT, opacity == 1.0f ? 0 : 1);
}

DR_RESULT drPrimitive::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_anim_agent)
    {
     if(DR_FAILED(_anim_agent->Update()))
         goto __ret;

        drAnimCtrlObjTypeInfo type_info;
        drIAnimCtrlObj* ctrl_obj;
        DWORD anim_ctrl_num = _anim_agent->GetAnimCtrlObjNum();
        for(DWORD i = 0; i < anim_ctrl_num; i++)
        {
            ctrl_obj = _anim_agent->GetAnimCtrlObj(i);

            if(ctrl_obj->GetAnimCtrl() && !ctrl_obj->IsPlaying())
                continue;

            ctrl_obj->GetTypeInfo(&type_info);
            switch(type_info.type)
            {
            case ANIM_CTRL_TYPE_MAT:
                {
                    if(DR_FAILED(((drIAnimCtrlObjMat*)ctrl_obj)->UpdateObject()))
                        goto __ret;

                    drMatrix44 mat;
                    if(DR_FAILED(((drIAnimCtrlObjMat*)ctrl_obj)->GetRTM(&mat)))
                        goto __ret;
                    _render_agent->SetLocalMatrix(&mat);
                }
                break;
            case ANIM_CTRL_TYPE_BONE:
                {
                    if(DR_FAILED(((drIAnimCtrlObjBone*)ctrl_obj)->UpdateObject((drIAnimCtrlObjBone*)ctrl_obj, _mesh_agent->GetMesh())))
                        goto __ret;

                    if(DR_FAILED(((drIAnimCtrlObjBone*)ctrl_obj)->UpdateHelperObject(_helper_object)))
                        goto __ret;
                }
                break;
            case ANIM_CTRL_TYPE_MTLOPACITY:
                {
                    if(DR_FAILED(((drIAnimCtrlObjMtlOpacity*)ctrl_obj)->UpdateObject()))
                        goto __ret;

                    drIMtlTexAgent* mtltex_agent;
                    mtltex_agent = GetMtlTexAgent(type_info.data[0]);
                    if(mtltex_agent == 0)
                        goto __ret;

                    float o = 1.0f;
                    ((drIAnimCtrlObjMtlOpacity*)ctrl_obj)->GetRunTimeOpacity(&o);
                    mtltex_agent->SetOpacity(o);
                }
                break;
            case ANIM_CTRL_TYPE_TEXUV:
                {
                   if(DR_FAILED(((drIAnimCtrlObjTexUV*)ctrl_obj)->UpdateObject()))
                       goto __ret;
                }
                break;
            case ANIM_CTRL_TYPE_TEXIMG:
                {
                     drITex* tex;
                     drIMtlTexAgent* mtltex_agent;

                     if(DR_FAILED(((drIAnimCtrlObjTexImg*)ctrl_obj)->UpdateObject()))
                         goto __ret;
 
                     if(DR_FAILED(((drIAnimCtrlObjTexImg*)ctrl_obj)->GetRunTimeTex(&tex)))
                         goto __ret;
 
                     mtltex_agent = GetMtlTexAgent(type_info.data[0]);
                     if(mtltex_agent == 0)
                         goto __ret;
 
                     mtltex_agent->SetTextureTransformImage(type_info.data[1], tex);
                }
                break;
            default:
                ;
            }
        }
    }

    if(_helper_object)
    {
        _helper_object->SetParentMatrix(_render_agent->GetGlobalMatrix());
    }

    _UpdateTransparentState();

    ret = DR_RET_OK;
__ret:
    return ret;
}


drMatrix44* drPrimitive::GetMatrixLocal() 
{ 
    return _render_agent ? _render_agent->GetLocalMatrix() : NULL; 
}
drMatrix44* drPrimitive::GetMatrixGlobal() 
{ 
    return _render_agent ? _render_agent->GetGlobalMatrix() : NULL; 
}

//extern void* g_drAnimCtrlAgent;
//void* g_drPrimitive = NULL;
//extern __declspec(dllimport) int g_nTemp;
DR_RESULT drPrimitive::Render()
{

    DR_RESULT ret = DR_RET_FAILED;

    if(_state_ctrl.GetState(STATE_VISIBLE) == 0)
        goto __addr_ret_ok;

//#if(defined MULTITHREAD_LOADING_MESH)
    if(_mesh_agent->GetMesh()->IsLoadingOK() == 0)
    {
        goto __addr_ret_ok;
    }
//#endif

// 	if( _anim_agent && _anim_agent==g_drAnimCtrlAgent )
// 	{
// 		if( g_drPrimitive==NULL )
// 			g_drPrimitive = this;
// 	}
// 	else if( g_drAnimCtrlAgent && _anim_agent )
// 		goto __addr_ret_ok;
//	else if( g_nTemp )
//		goto __addr_ret_ok;

	_render_agent->BindAnimCtrlAgent(_anim_agent);
    _render_agent->BindMeshAgent( _mesh_agent );

    if(DR_FAILED(_render_agent->BeginSet()))
        goto __ret;

    for( DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++ )
    {
        if( _mtltex_agent_seq[ i ] == NULL )
            break;

//#if(defined MULTITHREAD_LOADING_TEXTURE)
        //if(_mtltex_agent_seq[i]->IsTextureLoadingOK() == 0)
        //    continue;
//#endif
        if(!_mtltex_agent_seq[i]->GetRenderFlag())
            continue;

        if(_mtltex_agent_seq[i]->BeginPass() != RES_PASS_DEFAULT)
            continue;

        _render_agent->BindMtlTexAgent( _mtltex_agent_seq[ i ] );

        if(DR_FAILED(ret = _render_agent->BeginSetSubset(i)))
            goto __ret;

        if(ret == DR_RET_OK_1)
            goto __ret;

       if(DR_FAILED(_render_agent->DrawSubset( i )))
            goto __ret;

        if(DR_FAILED(_render_agent->EndSetSubset(i)))
            goto __ret;

        _mtltex_agent_seq[i]->EndPass();
    }

    if(DR_FAILED(_render_agent->EndSet()))
        goto __ret;

    if(_helper_object)
    {
        _helper_object->Render();
    }

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::RenderSubset( DWORD subset )
{
    if( subset < 0 || subset >= DR_MAX_SUBSET_NUM )
        return ERR_INVALID_PARAM;

    if( _mtltex_agent_seq[ subset ] == NULL )
        return ERR_INVALID_PARAM;

    _render_agent->BindAnimCtrlAgent(_anim_agent);
    _render_agent->BindMeshAgent( _mesh_agent );
    _render_agent->BindMtlTexAgent( _mtltex_agent_seq[ subset ] );

    _render_agent->BeginSet();
    _render_agent->BeginSetSubset(subset);
    _render_agent->DrawSubset( subset );
    _render_agent->EndSetSubset(subset);
    _render_agent->EndSet();

    // subset render doest not render helper object
    //_dummy_object.Render( dev_obj, &mat );
    //_bounding_object.Render( dev_obj, &mat );


    return DR_RET_OK;
}

DR_RESULT drPrimitive::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_helper_object == 0)
        goto __ret;

    drIBoundingSphere* bs = 0;
    drIBoundingBox* bb = 0;

    drMatrix44* mat = _render_agent->GetGlobalMatrix();

    if((bs = _helper_object->GetBoundingSphere()) != 0)
    {
        if(DR_SUCCEEDED(bs->HitTest(info, org, ray, mat)))
            goto __addr_ret_ok;
    }

    if((bb = _helper_object->GetBoundingBox()) != 0)
    {
        if(DR_SUCCEEDED(bb->HitTest(info, org, ray, mat)))
            goto __addr_ret_ok;
    }

    goto __ret;

__addr_ret_ok:

    ret = DR_RET_OK;

__ret:

    return ret;
}

DR_RESULT drPrimitive::SetTextureLOD(DWORD level)
{
    for( DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++ )
    {
        if( _mtltex_agent_seq[ i ] == NULL )
            continue;

        _mtltex_agent_seq[ i ]->SetTextureLOD(level);
    }

    return DR_RET_OK;
}

DR_RESULT drPrimitive::GetSubsetNum(DWORD* subset_num)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(subset_num == 0)
        goto __ret;

    // use mesh subset?
    if(_mesh_agent == 0)
        goto __ret;

    drIMesh* mesh = _mesh_agent->GetMesh();
    if(mesh == 0)
        goto __ret;

    drMeshInfo* info = mesh->GetMeshInfo();
    if(info == 0)
        goto __ret;

    *subset_num = info->subset_num;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPrimitive::ExtractGeomObjInfo(drIGeomObjInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drGeomObjInfo* a = (drGeomObjInfo*)info;

    // render ctrl state
    a->rcci.ctrl_id = _render_agent->GetRenderCtrlVS()->GetType();
    a->rcci.vs_id = _render_agent->GetVertexShader();
    a->rcci.decl_id = _render_agent->GetVertexDeclaration();

    a->id = _id;
    a->parent_id = _parent_id;
    a->mat_local = *_render_agent->GetLocalMatrix();
    a->state_ctrl = _state_ctrl;

    // mesh
    if(_mesh_agent == 0)
        goto __ret;

    drIMesh* mesh = _mesh_agent->GetMesh();
    if(mesh == 0)
        goto __ret;

    if(DR_FAILED(mesh->ExtractMesh(&a->mesh)))
        goto __ret;

    // mtltex
	DWORD i = 0;
    for( i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(_mtltex_agent_seq[i] == 0)
            break;

        if(DR_FAILED(_mtltex_agent_seq[i]->ExtractMtlTex(&a->mtl_seq[i])))
            goto __ret;

    }
    a->mtl_num = i;

    // animation
    if(_anim_agent)
    {
        if(DR_FAILED(_anim_agent->ExtractAnimData(&a->anim_data)))
            goto __ret;
    }


    // helper info
    if(_helper_object)
    {
        if(DR_FAILED(_helper_object->ExtractHelperInfo(&a->helper_data)))
            goto __ret;
    }

    //
    a->mtl_size = drGetMtlTexInfoSize(&a->mtl_seq[0], a->mtl_num);
    a->mesh_size = drMeshInfo_GetDataSize(&a->mesh);
    a->helper_size = a->helper_data.GetDataSize();
    a->anim_size = a->anim_data.GetDataSize();

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drPrimitive::PlayDefaultAnimation()
{
    DR_RESULT ret = DR_RET_FAILED;

    drPlayPoseInfo ppi;
    memset( &ppi, 0, sizeof( ppi ) );
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.pose = 0;
    ppi.frame = 0.0f;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;

    if(_anim_agent == NULL)
        goto __ret_ok;

    //drAnimCtrlObjTypeInfo type_info;

    drIAnimCtrlObj* ctrl_obj;
    DWORD n = _anim_agent->GetAnimCtrlObjNum();
    for(DWORD i = 0; i < n; i++)
    {
        ctrl_obj = _anim_agent->GetAnimCtrlObj(i);
        ctrl_obj->PlayPose(&ppi);

        //if(DR_SUCCEEDED(ctrl_obj->GetTypeInfo(&type_info)))
        //{
        //    if(type_info.type == ANIM_CTRL_TYPE_MTLOPACITY)
        //    {
        //        SetState(STATE_TRANSPARENT, TRUE);
        //    }
        //}
    }

__ret_ok:
    ret = DR_RET_OK;
    return ret;

}
DR_RESULT drPrimitivePlayDefaultAnimation( drIPrimitive* obj )
{
	if(!obj)
		return DR_RET_FAILED;

    drPlayPoseInfo ppi;
    memset( &ppi, 0, sizeof( ppi ) );
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.pose = 0;
    ppi.frame = 0.0f;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;

    drIAnimCtrlAgent* anim_agent = obj->GetAnimAgent();
    if(anim_agent == NULL)
        return DR_RET_FAILED;

    //drAnimCtrlObjTypeInfo type_info;

    drIAnimCtrlObj* ctrl_obj;
    DWORD n = anim_agent->GetAnimCtrlObjNum();
    for(DWORD i = 0; i < n; i++)
    {
        ctrl_obj = anim_agent->GetAnimCtrlObj(i);
        ctrl_obj->PlayPose(&ppi);

        //if(DR_SUCCEEDED(ctrl_obj->GetTypeInfo(&type_info)))
        //{
        //    if(type_info.type == ANIM_CTRL_TYPE_MTLOPACITY)
        //    {
        //        obj->SetState(STATE_TRANSPARENT, TRUE);
        //    }
        //}
    }

    return DR_RET_OK;

}

DR_RESULT drPrimitive::ResetTexture(DWORD subset, DWORD stage, const char* file, const char* tex_path)
{
	DR_RESULT ret = DR_RET_FAILED;

	drTexInfo tex_info;
	drITex* new_tex;

	if(subset >= DR_MAX_SUBSET_NUM)
		goto __ret;
	if(_mtltex_agent_seq[subset] == 0)
		goto __ret;

	drITex* tex = _mtltex_agent_seq[subset]->GetTex(stage);
	if(tex == 0)
		goto __ret;

	tex->GetTexInfo(&tex_info);
	_tcsncpy_s(tex_info.file_name, file, _TRUNCATE);
	tex_info.level = D3DX_DEFAULT;
	tex_info.type = TEX_TYPE_FILE;

	DR_FAILED_RET(_res_mgr->CreateTex(&new_tex));
	DR_FAILED_RET(new_tex->LoadTexInfo(&tex_info, tex_path));
	DR_FAILED_RET(new_tex->LoadVideoMemory());
	_mtltex_agent_seq[subset]->SetTex(stage, new_tex, &tex);
	DR_RELEASE(tex);

	ret = DR_RET_OK;
__ret:
	return ret;
}


DR_END
