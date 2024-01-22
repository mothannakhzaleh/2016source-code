//
#if 1

#include "drNodeObject.h"
#include "drMisc.h"
#include "drIUtil.h"
#include "drPrimitiveHelper.h"
#include "drHelperGeometry.h"

DR_BEGIN

// drNodeBase
drNodeBase::drNodeBase()
{
    // base
    _type = MODELNODE_INVALID;
    _id = DR_INVALID_INDEX;
    _descriptor[0] = '\0';
    drMatrix44Identity(&_mat_local);
    drMatrix44Identity(&_mat_world);

    // state set
    _state_set.Alloc(OBJECT_STATE_NUM);
    _state_set.SetValue(STATE_VISIBLE, 1);
    _state_set.SetValue(STATE_ENABLE, 1);

    // link state
    _parent = 0;
    _link_parent_id = DR_INVALID_INDEX;
    _link_id = DR_INVALID_INDEX;

}

//DR_RESULT drNodeBase::_UpdateMatrix()
//{
//    DR_RESULT ret = DR_RET_FAILED;
//
//    if(_parent)
//    {
//        // update world matrix
//        drMatrix44 mat_parent;
//
//        if(DR_FAILED(_parent->GetLinkMatrix(&mat_parent, _link_parent_id)))
//            goto __ret;
//
//        if(_link_id != DR_INVALID_INDEX)
//        {
//            drMatrix44 mat_link;
//
//            if(DR_FAILED(GetLinkMatrix(&mat_link, _link_id)))
//                goto __ret;
//
//            drMatrix44InverseNoScaleFactor(&mat_link, &mat_link);
//
//            drMatrix44Multiply(&mat_parent, &mat_link, &mat_parent);
//        }
//
//        drMatrix44Multiply(&_mat_world, &_mat_local, &mat_parent);
//    }
//    else
//    {
//        _mat_world = _mat_local;
//    }
//
//    ret = DR_RET_OK;
//__ret:
//    return ret;
//}
//

static DWORD __tree_proc_loadmodel(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_ABORT;

    drIResourceMgr* res_mgr = (drIResourceMgr*)param;
    drModelNodeInfo* node_info = (drModelNodeInfo*)node->GetData();

    char* tex_path = res_mgr->GetTexturePath();

    drINode* model_node = 0;
    if(DR_FAILED(res_mgr->CreateNode(&model_node, node_info->_type)))
        goto __ret;

    model_node->SetID(node_info->_id);
    // for the reason of compatible,
    // link_id and link_parent_id cannot be asigned here
    // because the initialize value of them is zero 
    // which is valid for link_id and link_parent_id

    // now fixed it @_@
    model_node->SetLinkID(node_info->_link_id);
    model_node->SetParentLinkID(node_info->_link_parent_id);

    switch(node_info->_type)
    {
    case NODE_PRIMITIVE:
        if(DR_FAILED(((drINodePrimitive*)model_node)->Load((drIGeomObjInfo*)node_info->_data, tex_path, 0)))
            goto __ret;
        break;
    case NODE_BONECTRL:
        if(DR_FAILED(((drINodeBoneCtrl*)model_node)->Load((drIAnimDataBone*)node_info->_data)))
            goto __ret;
        break;
    case NODE_DUMMY:
        if(DR_FAILED(((drINodeDummy*)model_node)->Load((drIHelperDummyObjInfo*)node_info->_data)))
            goto __ret;
        break;
    case NODE_HELPER:
        assert(0);
        break;
    default:
        assert(0);
    }

    drITreeNode* model_tree;
    drGUIDCreateObject((DR_VOID**)&model_tree, DR_GUID_TREENODE);
    model_tree->SetData(model_node);

    // set param
    node_info->_param = model_tree;

    // link tree parent
    drITreeNode* node_parent = node->GetParent();
    if(node_parent)
    {
        drModelNodeInfo* parent_info = (drModelNodeInfo*)node_parent->GetData();
        drITreeNode* parent_obj_node = (drITreeNode*)parent_info->_param;

        parent_obj_node->InsertChild(0, model_tree);

        drINode* parent_obj_data = (drINode*)parent_obj_node->GetData();
        assert(parent_obj_data && "invalid parent_obj_data when called __tree_proc_loadmodel");

        model_node->SetParent(parent_obj_data);  
    }
    

    ret = TREENODE_PROC_RET_CONTINUE;
__ret:
    return ret;
}

DR_RESULT drLoadModelInfo(drITreeNode** ret_obj_tree, drModelInfo* info, drIResourceMgr* res_mgr)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->_obj_tree->EnumTree(__tree_proc_loadmodel, (void*)res_mgr, TREENODE_PROC_PREORDER) 
        == TREENODE_PROC_RET_ABORT)
        goto __ret;

    drModelNodeInfo* root_info = (drModelNodeInfo*)info->_obj_tree->GetData();

    *ret_obj_tree = (drITreeNode*)root_info->_param;

    ret = DR_RET_OK;
__ret:
    return ret;
}
// drNodePrimitive
DR_STD_ILELEMENTATION(drNodePrimitive)

drNodePrimitive::drNodePrimitive(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr)
{
    _type = NODE_PRIMITIVE;

    _mesh_agent = 0;
    _mtltex_agent_seq = 0;
    _anim_agent = 0;
    _render_agent = 0;
    _helper_object = 0;
    //_vertex_blend_ctrl = 0;
    _ref_ctrl_obj_bone = 0;

    _mtltex_agent_seqsize = 0;
}

drNodePrimitive::~drNodePrimitive()
{
    Destroy();
}

DR_RESULT drNodePrimitive::_DestroyMtlTexAgent()
{
    if(_mtltex_agent_seqsize > 0)
    {
        for(DWORD i = 0; i < _mtltex_agent_seqsize; i++)
        {
            DR_IF_RELEASE(_mtltex_agent_seq[i]);
        }
        DR_DELETE_A(_mtltex_agent_seq);
        _mtltex_agent_seqsize = 0;
    }

    return DR_RET_OK;
}

DR_RESULT drNodePrimitive::_UpdateBoundingObject(drIAnimCtrlObjBone* ctrl_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_helper_object == 0)
        goto __addr_ret_ok;

    drIBoundingSphere* b;
    drBoundingSphereInfo* s;

    if((b = _helper_object->GetBoundingSphere()) == 0)
        goto __addr_ret_ok;

    DWORD bs_num = b->GetObjNum();

    for(DWORD j = 0; j < bs_num; j++)
    {
        s = b->GetDataInfo(j);

        assert(s->id < DR_MAX_BONEDUMMY_NUM);

        drMatrix44* mat = ctrl_obj->GetDummyRTM(s->id);
        if(mat)
        {
            s->mat = *mat;
        }
    }

__addr_ret_ok:
    ret = DR_RET_OK;

    return ret;
}

DR_RESULT drNodePrimitive::_UpdateTransparentState()
{
    // i recommend this procedure to be invoked when initialize and something changing
    // of transparent state such as opacity, additive/subtractive blend state.
    // consequently it is not advised to update per-frame
    DWORD i;
    BYTE state;
    drIMtlTexAgent* mtltex_agent;

    if(_state_set.GetValue(STATE_UPDATETRANSPSTATE) == 0)
        goto __ret;

    state = 1;

    for(i = 0; i < _mtltex_agent_seqsize; i++)
    {
        if((mtltex_agent = _mtltex_agent_seq[i]) == NULL)
            break;

        if(mtltex_agent->GetOpacity() != 1.0f)
            goto __set_state;

        if(mtltex_agent->GetTransparencyType() != MTLTEX_TRANSP_FILTER)
            goto __set_state;
    }

    state = 0;

__set_state:
    _state_set.SetValue(STATE_TRANSPARENT, state);
__ret:
    return DR_RET_OK;
}

DR_RESULT drNodePrimitive::Destroy()
{
    DR_SAFE_RELEASE(_mesh_agent);
    DR_SAFE_RELEASE(_anim_agent);
    DR_SAFE_RELEASE(_render_agent);
    DR_SAFE_RELEASE(_helper_object);

    _DestroyMtlTexAgent();

    return DR_RET_OK;
}

DR_RESULT drNodePrimitive::AllocateMtlTexAgentSeq(DWORD num)
{
    _DestroyMtlTexAgent();

    _mtltex_agent_seq = DR_NEW(drIMtlTexAgent*[num]);
    _mtltex_agent_seqsize = num;
    memset(_mtltex_agent_seq, 0, sizeof(drIMtlTexAgent*) * num);

    return DR_RET_OK;
}

DR_RESULT drNodePrimitive::Load(drIGeomObjInfo* geom_info, const char* tex_path, const drResFile* res)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD i;

    drGeomObjInfo* info = (drGeomObjInfo*)geom_info;

    drISystem* sys = _res_mgr->GetSysGraphics()->GetSystem();
    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    BYTE create_helper_primitive = opt_mgr->GetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE);

    LoadRenderCtrl(&info->rcci);

    // base info
    // warning:注意，这里的_type用来表示MODELNODE_的类型
    // 不能用导出的信息type来覆盖！！！
    //_type = info->type;

    // 基本信息_id, _link_id, _link_parent_id等已经在drLoadModelInfo中设置
    //_id = info->id;
    _mat_local = info->mat_local;
    //_state_ctrl = info->state_ctrl;
    _state_set.SetValueSeq(0, info->state_ctrl._state_seq, OBJECT_STATE_NUM);
    //_parent;
    //

    // mtltex info
    if(DR_FAILED(AllocateMtlTexAgentSeq(info->mtl_num)))
        goto __ret;

    for(i = 0; i < info->mtl_num; i++)
    {
        if(DR_FAILED(LoadMtlTex(i, &info->mtl_seq[i], tex_path)))
            goto __ret;
    }

    // mesh info
    if(DR_FAILED(LoadMesh(&info->mesh)))
        goto __ret;

    if(res)
    {
        drResFileMesh info;
        info.obj_id = res->obj_id;
        info.res_type = res->res_type;
        _tcsncpy_s(info.file_name, res->file_name, _TRUNCATE);

        _mesh_agent->GetMesh()->SetResFile(&info);
    }

    // helper info
    if(info->helper_data.type != HELPER_TYPE_INVALID)
    {
        DR_IF_RELEASE(_helper_object);
        _res_mgr->CreateHelperObject(&_helper_object);
        if(DR_FAILED(_helper_object->LoadHelperInfo(&info->helper_data, create_helper_primitive)))
        {
            drMessageBox("LoadHelperInfo");
        }
    }

    // anim info
    if(info->anim_size > 0)
    {
        if(DR_FAILED(LoadAnimData(&info->anim_data, tex_path, res)))
            goto __ret;
    }


    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNodePrimitive::LoadMesh(drMeshInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    DR_IF_RELEASE(_mesh_agent);

    if(DR_FAILED(_res_mgr->CreateMeshAgent(&_mesh_agent)))
        goto __ret;

    if(DR_FAILED(_mesh_agent->LoadMesh(info)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodePrimitive::LoadMtlTex(DWORD mtl_id, drMtlTexInfo* info, const char* tex_path)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(mtl_id < 0 || mtl_id >= DR_MAX_SUBSET_NUM)
        goto __ret;

    if(DR_FAILED(_res_mgr->CreateMtlTexAgent(&_mtltex_agent_seq[mtl_id])))
        goto __ret;

    if(DR_FAILED(_mtltex_agent_seq[mtl_id]->LoadMtlTex(info, tex_path)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNodePrimitive::LoadAnimData(drIAnimDataInfo* data_info, const char* tex_path, const drResFile* res)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimDataInfo* info = (drAnimDataInfo*)data_info;

    void* data;
    DR_SAFE_RELEASE(_anim_agent);

    if(DR_FAILED(_res_mgr->CreateAnimCtrlAgent(&_anim_agent)))
        goto __ret;

    drAnimCtrlObjTypeInfo type_info;

    if(info->anim_mat)
    {
        drIAnimCtrlMatrix* ctrl = NULL;
        drIAnimCtrlObjMat* ctrl_obj = NULL;

        data = info->anim_mat;

        type_info.type = ANIM_CTRL_TYPE_MAT;
        type_info.data[0] = DR_INVALID_INDEX;
        type_info.data[1] = DR_INVALID_INDEX;

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
        drIAnimCtrlBone* ctrl = NULL;
        drIAnimCtrlObjBone* ctrl_obj = NULL;

        data = info->anim_bone;

        type_info.type = ANIM_CTRL_TYPE_BONE;
        type_info.data[0] = DR_INVALID_INDEX;
        type_info.data[1] = DR_INVALID_INDEX;

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


    for(DWORD i = 0; i < _mtltex_agent_seqsize; i++)
    {
        if(_mtltex_agent_seq[i] == NULL)
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

        for(DWORD j = 0; j < DR_MAX_TEXTURESTAGE_NUM; j++)
        {
            if(info->anim_tex[i][j])
            {
                drIAnimCtrlTexUV* ctrl = NULL;
                drIAnimCtrlObjTexUV* ctrl_obj = NULL;

                data = info->anim_tex[i][j];

                type_info.type = ANIM_CTRL_TYPE_TEXUV;
                type_info.data[0] = i;
                type_info.data[1] = j;

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
                drIAnimCtrlTexImg* ctrl = NULL;
                drIAnimCtrlObjTexImg* ctrl_obj = NULL;

                data = info->anim_img[i][j];

                type_info.type = ANIM_CTRL_TYPE_TEXIMG;
                type_info.data[0] = i;
                type_info.data[1] = j;

                _tcsncpy_s(info->anim_img[i][j]->_tex_path, tex_path, _TRUNCATE);

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
DR_RESULT drNodePrimitive::LoadRenderCtrl(const drRenderCtrlCreateInfo* rcci)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIRenderCtrlAgent* render_agent = 0;

    if(_render_agent)
        goto __ret;

    if(DR_FAILED(_res_mgr->CreateRenderCtrlAgent(&render_agent)))
        goto __ret;

    if(DR_FAILED(render_agent->SetRenderCtrl(rcci->ctrl_id)))
        goto __ret;

    render_agent->SetVertexDeclaration(rcci->decl_id);
    render_agent->SetVertexShader(rcci->vs_id);
    
    _render_agent = render_agent;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodePrimitive::Copy(drINodePrimitive* src_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    _id = src_obj->GetID();
    _mat_local = *src_obj->GetLocalMatrix();
    _mat_world = *src_obj->GetWorldMatrix();

    _parent = src_obj->GetParent();
    _link_id = src_obj->GetLinkID();
    _link_parent_id = src_obj->GetParentLinkID();
    
    drIMeshAgent* src_mesh_agent = src_obj->GetMeshAgent();
    if(src_mesh_agent)
    {
        if(DR_FAILED(src_mesh_agent->Clone(&_mesh_agent)))
            goto __ret;
    }

    drIMtlTexAgent* src_mtltex_agent;
    DWORD src_mtltex_agent_seqsize = GetMtlTexAgentSeqSize();

    AllocateMtlTexAgentSeq(src_mtltex_agent_seqsize);

    for(DWORD i = 0; i < src_mtltex_agent_seqsize; i++)
    {
        if((src_mtltex_agent = src_obj->GetMtlTexAgent(i)) == NULL)
            continue;

        if(DR_FAILED(src_mtltex_agent->Clone(&_mtltex_agent_seq[i])))
            goto __ret;
    }

    drIAnimCtrlAgent* src_anim_agent = src_obj->GetAnimCtrlAgent();
    if(src_anim_agent)
    {
        if(DR_FAILED(src_anim_agent->Clone(&_anim_agent)))
            goto __ret;
    }

    drIRenderCtrlAgent* src_render_agent = src_obj->GetRenderCtrlAgent();
    if(src_render_agent)
    {
        if(DR_FAILED(_render_agent->Clone(&_render_agent)))
            goto __ret;
    }

    drIHelperObject* src_helper_object = src_obj->GetHelperObject();
    if(src_helper_object)
    {
        if(DR_FAILED(src_helper_object->Clone(&_helper_object)))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNodePrimitive::Update()
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

                    if(DR_FAILED(((drIAnimCtrlObjMat*)ctrl_obj)->GetRTM(&_mat_local)))
                        goto __ret;
                }
                break;
            case ANIM_CTRL_TYPE_BONE:
                {
                    if(DR_FAILED(((drIAnimCtrlObjBone*)ctrl_obj)->UpdateObject((drIAnimCtrlObjBone*)ctrl_obj, _mesh_agent->GetMesh())))
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
                    if(DR_FAILED(((drIAnimCtrlObjTexImg*)ctrl_obj)->UpdateObject()))
                        goto __ret;

                    drITex* tex;
                    drIMtlTexAgent* mtltex_agent;

                    if(DR_FAILED(((drIAnimCtrlTexImg*)ctrl_obj)->GetRunTimeTex(&tex)))
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

    /*
    if(_vertex_blend_ctrl)
    {
        // update world matrix
        drMatrix44 mat_parent;

        if(DR_FAILED(_vertex_blend_ctrl->GetLinkMatrix(&mat_parent, DR_INVALID_INDEX)))
            goto __ret;

        drMatrix44Multiply(&_mat_world, &_mat_local, &mat_parent);

        // update render ctrl blend matrix
        drIAnimCtrlObjBone* ctrl_obj = _vertex_blend_ctrl->GetAnimCtrlObj();
        if(ctrl_obj == 0)
            goto __ret;

        ctrl_obj->UpdateObject(_ref_ctrl_obj_bone, this);

        // update bounding object
        // has been done in ctrl_obj->UpdateObject
        //if(DR_FAILED(_UpdateBoundingObject(ctrl_obj)))
        //    goto __ret;
    }
    // update world matrix
    else 
    */
    if(_parent)
    {
        if(_ref_ctrl_obj_bone)
        {
            // update world matrix
            drMatrix44 mat_parent;

            if(DR_FAILED(_parent->GetLinkMatrix(&mat_parent, DR_INVALID_INDEX)))
                goto __ret;

            drMatrix44Multiply(&_mat_world, &_mat_local, &mat_parent);

            // update render ctrl blend matrix
            drIAnimCtrlObjBone* ctrl_obj = ((drINodeBoneCtrl*)_parent)->GetAnimCtrlObj();
            if(ctrl_obj == 0)
                goto __ret;

            if(DR_FAILED(ctrl_obj->UpdateObject(_ref_ctrl_obj_bone, _mesh_agent->GetMesh())))
                goto __ret;

            if(DR_FAILED(ctrl_obj->UpdateHelperObject(_helper_object)))
                goto __ret;
        }
        else
        {
            drMatrix44 mat_parent;

            if(DR_FAILED(_parent->GetLinkMatrix(&mat_parent, _link_parent_id)))
                goto __ret;

            if(_link_id != DR_INVALID_INDEX)
            {
                drMatrix44 mat_link;

                if(DR_FAILED(GetLinkMatrix(&mat_link, _link_id)))
                    goto __ret;

                drMatrix44InverseNoScaleFactor(&mat_link, &mat_link);

                drMatrix44Multiply(&mat_parent, &mat_link, &mat_parent);
            }

            drMatrix44Multiply(&_mat_world, &_mat_local, &mat_parent);
        }
    }
    else
    {
        _mat_world = _mat_local;
    }

    if(_helper_object)
    {
        _helper_object->SetParentMatrix(&_mat_world);
    }

    _UpdateTransparentState();

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodePrimitive::Render()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!_CheckVisibleState())
        goto __addr_ret_ok;

    _render_agent->SetMatrix(&_mat_world);
    _render_agent->BindAnimCtrlAgent(_anim_agent);
    _render_agent->BindMeshAgent(_mesh_agent);

    if(DR_FAILED(_render_agent->BeginSet()))
        goto __ret;

    for(DWORD i = 0; i < _mtltex_agent_seqsize; i++)
    {
        if(_mtltex_agent_seq[i] == NULL)
            continue;

        _render_agent->BindMtlTexAgent(_mtltex_agent_seq[i]);

        if(_mtltex_agent_seq[i]->BeginPass() == RES_PASS_DEFAULT)
        {
            if(DR_FAILED(_render_agent->BeginSetSubset(i)))
                goto __ret;

            if(DR_FAILED(_render_agent->DrawSubset(i)))
                goto __ret;

            if(DR_FAILED(_render_agent->EndSetSubset(i)))
                goto __ret;
        }

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
DR_RESULT drNodePrimitive::RenderSubset(DWORD subset)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(subset < 0 || subset >= DR_MAX_SUBSET_NUM)
        goto __ret;

    if(_mtltex_agent_seq[subset] == NULL)
        goto __ret;

    _render_agent->BindAnimCtrlAgent(_anim_agent);
    _render_agent->BindMeshAgent(_mesh_agent);
    _render_agent->BindMtlTexAgent(_mtltex_agent_seq[subset]);

    if(DR_FAILED(_render_agent->BeginSet()))
        goto __ret;

    if(DR_FAILED(_render_agent->BeginSetSubset(subset)))
        goto __ret;

    if(DR_FAILED(_render_agent->DrawSubset(subset)))
        goto __ret;

    if(DR_FAILED(_render_agent->EndSetSubset(subset)))
        goto __ret;

    if(DR_FAILED(_render_agent->EndSet()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drNodePrimitive::RenderHelperObject()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_helper_object == 0)
        goto __ret;

    if(DR_FAILED(_helper_object->Render()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drNodePrimitive::HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray)
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

DR_RESULT drNodePrimitive::GetLinkMatrix(drMatrix44* mat, DWORD link_id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(link_id == DR_INVALID_INDEX)
    {
        *mat = _mat_world;
    }
    else
    {
        if(_helper_object == 0)
            goto __ret;

        drIHelperDummy* hd = _helper_object->GetHelperDummy();
        if(hd == 0)
            goto __ret;

        drHelperDummyInfo* info = hd->GetDataInfoWithID(link_id);

        if(info == 0)
            goto __ret;

        *mat = info->mat;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

void drNodePrimitive::SetMaterial(const drMaterial* mtl)
{
    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(_mtltex_agent_seq[i] == NULL)
            continue;

        _mtltex_agent_seq[i]->SetMaterial(mtl);
    }
}
void drNodePrimitive::SetOpacity(float opacity)
{
    for(DWORD i = 0; i < DR_MAX_SUBSET_NUM; i++)
    {
        if(_mtltex_agent_seq[i] == NULL)
            continue;

        _mtltex_agent_seq[i]->SetOpacity(opacity);
    }

    //_state_ctrl.SetState(STATE_TRANSPARENT, opacity == 1.0f ? 0 : 1);
}

// SetParent对于parent是VertexBlendCtrl时的问题
// 1.调整drAnimCtrlAgent中ANIM_CTRL_TYPE_BONE的对象
// 2.重设_ref_ctrl_obj_bone
// 3.重设drRenderCtrlAgent中vs_type和vs_ctrl，因为vs_type具有自定义性质
//   所以无法通过fvf或者其他方式进行内部匹配，这里建议vs_type和vs_ctrl
//   做外部显示重设
//   可以不需要重设vs_type（重设效率略高）,需要重设vs_ctrl
DR_RESULT drNodePrimitive::SetParent(drINode* parent)
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_MAT;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    //check parent model type
    if(parent == 0)
    {
        if(_parent == 0)
            goto __addr_ret_ok;

        if(_parent->GetType() == NODE_BONECTRL)
        {
            if(_anim_agent)
            {
                drIAnimCtrlObj* ctrl_obj = _anim_agent->RemoveAnimCtrlObj(&type_info);

                DR_IF_RELEASE(ctrl_obj);
                _ref_ctrl_obj_bone = 0;
            }
        }

        _parent = 0;
        goto __addr_ret_ok;
    }

    // clear current parent
    if(DR_FAILED(SetParent(0)))
        goto __ret;

    if(parent->GetType() == NODE_BONECTRL)
    {
        drIAnimCtrlObj* ctrl_obj = 0;

        // create anim ctrl agent
        if(_anim_agent == 0)
        {
            if(DR_FAILED(_res_mgr->CreateAnimCtrlAgent(&_anim_agent)))
                goto __ret;
        }
        else
        {
            ctrl_obj = _anim_agent->GetAnimCtrlObj(&type_info);
        }

        // create ctrl bone 
        if(ctrl_obj == 0)
        {
            if(DR_FAILED(_res_mgr->CreateAnimCtrlObj(&ctrl_obj, ANIM_CTRL_TYPE_BONE)))
                goto __ret;

            _anim_agent->AddAnimCtrlObj(ctrl_obj);

            _ref_ctrl_obj_bone = (drIAnimCtrlObjBone*)ctrl_obj;
        }                
        
    }

    _parent = parent;


__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNodePrimitive::GetSubsetNum(DWORD* subset_num)
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

/*
DR_RESULT drNodePrimitive::SetVertexBlendCtrl(drINodeBoneCtrl* ctrl)
{
    DR_RESULT ret = DR_RET_FAILED;

    // add
    if(ctrl)
    {
        drIAnimCtrlObj* ctrl_obj = 0;

        // create anim ctrl agent
        if(_anim_agent == 0)
        {
            if(DR_FAILED(_res_mgr->CreateAnimCtrlAgent(&_anim_agent)))
                goto __ret;
        }
        else
        {
            ctrl_obj = _anim_agent->GetAnimCtrlObj(DR_INVALID_INDEX, DR_INVALID_INDEX, ANIM_CTRL_TYPE_MAT);
        }

        // create ctrl bone 
        if(ctrl_obj == 0)
        {
            if(DR_FAILED(_res_mgr->CreateAnimCtrlObj(&ctrl_obj, ANIM_CTRL_TYPE_BONE)))
                goto __ret;

            _anim_agent->AddAnimCtrlObj(ctrl_obj);

            _ref_ctrl_obj_bone = (drIAnimCtrlObjBone*)ctrl_obj;
        }                
    }
    // remove
    else
    {
        if(_anim_agent)
        {
            drIAnimCtrlObj* ctrl_obj = _anim_agent->RemoveAnimCtrlObj(DR_INVALID_INDEX, DR_INVALID_INDEX, ANIM_CTRL_TYPE_MAT);
            DR_IF_RELEASE(ctrl_obj);

            _ref_ctrl_obj_bone = 0;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}
*/
// drNodeBoneCtrl
DR_STD_ILELEMENTATION(drNodeBoneCtrl)

drNodeBoneCtrl::drNodeBoneCtrl(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _ctrl_obj(0)
{
    _type = NODE_BONECTRL;
}
drNodeBoneCtrl::~drNodeBoneCtrl()
{
    DR_IF_RELEASE(_ctrl_obj);
}
DR_RESULT drNodeBoneCtrl::GetLinkMatrix(drMatrix44* mat, DWORD link_id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_ctrl_obj == 0)
        goto __ret;

    if(link_id == DR_INVALID_INDEX)
    {
        *mat = _mat_world;
        goto __addr_ret_ok;
    }

    drMatrix44* rtm = _ctrl_obj->GetDummyRTM(link_id);

    if(rtm == NULL)
        goto __ret;

    drMatrix44Multiply(mat, rtm, &_mat_world);

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drNodeBoneCtrl::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    // update world matrix
    if(_parent)
    {
        drMatrix44 mat_parent;

        if(DR_FAILED(_parent->GetLinkMatrix(&mat_parent, _link_parent_id)))
            goto __ret;

        if(_link_id != DR_INVALID_INDEX)
        {
            drMatrix44 mat_link;

            if(DR_FAILED(GetLinkMatrix(&mat_link, _link_id)))
                goto __ret;

            drMatrix44InverseNoScaleFactor(&mat_link, &mat_link);

            drMatrix44Multiply(&mat_parent, &mat_link, &mat_parent);
        }

        drMatrix44Multiply(&_mat_world, &_mat_local, &mat_parent);
    }
    else
    {
        _mat_world = _mat_local;
    }

    if(_ctrl_obj == 0)
        goto __addr_ret_ok;

    if(DR_FAILED(_ctrl_obj->UpdateAnimCtrl()))
        goto __ret;

    if(DR_FAILED(_ctrl_obj->UpdateObject(_ctrl_obj, NULL)))
        goto __ret;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNodeBoneCtrl::Load(drIAnimDataBone* data)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrlBone* ctrl_bone = 0;
    drIAnimCtrlObjBone* ctrl_obj_bone = 0;
    
    if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_bone, ANIM_CTRL_TYPE_BONE)))
        goto __ret;

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&ctrl_obj_bone, ANIM_CTRL_TYPE_BONE)))
        goto __ret;

    if(DR_FAILED(ctrl_bone->LoadData((void*)data)))
        goto __ret;

    ctrl_obj_bone->AttachAnimCtrl(ctrl_bone);

    _ctrl_obj = ctrl_obj_bone;

    ctrl_obj_bone = 0;
    ctrl_bone = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_RELEASE(ctrl_bone);
    DR_IF_RELEASE(ctrl_obj_bone);

    return ret;

}

DR_RESULT drNodeBoneCtrl::PlayPose(const drPlayPoseInfo* info)
{
    return _ctrl_obj->PlayPose(info);
}
drIPoseCtrl* drNodeBoneCtrl::GetPoseCtrl()
{
    return drIAnimCtrlObj_GetPoseCtrl(_ctrl_obj);
}
drPlayPoseInfo* drNodeBoneCtrl::GetPlayPoseInfo()
{
    return drIAnimCtrlObj_GetPlayPoseInfo(_ctrl_obj);
}


//drNodeDummy
DR_STD_ILELEMENTATION(drNodeDummy)
drNodeDummy::drNodeDummy(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _ctrl_obj(0), _ass_obj(0)
{
    _type = NODE_DUMMY;
}
drNodeDummy::~drNodeDummy()
{
    DR_IF_RELEASE(_ass_obj);
    DR_IF_RELEASE(_ctrl_obj);
}
DR_RESULT drNodeDummy::GetLinkMatrix(drMatrix44* mat, DWORD link_id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(link_id != DR_INVALID_INDEX)
        goto __ret;

    *mat = _mat_world;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drNodeDummy::Load(drIHelperDummyObjInfo* data)
{
    DR_RESULT ret = DR_RET_FAILED;

    drHelperDummyObjInfo* info = (drHelperDummyObjInfo*)data;

    _id = info->GetID();
    _mat_local = *info->GetMatrix();

    DR_SAFE_RELEASE(_ctrl_obj);
    drIAnimDataMatrix* anim_data = info->GetAnimDataMatrix();
    if(anim_data)
    {
        drIAnimCtrlMatrix* ctrl;

        if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl, ANIM_CTRL_TYPE_MAT)))
            goto __ret;

        if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&_ctrl_obj, ANIM_CTRL_TYPE_MAT)))
            goto __ret;

        if(DR_FAILED(ctrl->LoadData(anim_data)))
            goto __ret;

        _ctrl_obj->AttachAnimCtrl(ctrl);
    }

    if(_res_mgr->GetByteSet()->GetValue(OPT_CREATE_ASSISTANTOBJECT))
    {
        drAssObjInfo info;
        _res_mgr->GetAssObjInfo(&info);

        if(DR_FAILED(CreateAssistantObject(&info.size, info.color)))
            goto __ret;

        _ass_obj->GetStateSet()->SetValue(STATE_VISIBLE, 0);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drNodeDummy::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    // first update anim data
    if(_ctrl_obj)
    {
        if(DR_FAILED(_ctrl_obj->UpdateAnimCtrl()))
            goto __ret;

        if(DR_FAILED(_ctrl_obj->UpdateObject()))
            goto __ret;

        if(DR_FAILED(_ctrl_obj->GetRTM(&_mat_local)))
            goto __ret;
    }

    // update world matrix
    if(_parent)
    {
        drMatrix44 mat_parent;

        if(DR_FAILED(_parent->GetLinkMatrix(&mat_parent, _link_parent_id)))
            goto __ret;

        if(_link_id != DR_INVALID_INDEX)
        {
            drMatrix44 mat_link;

            if(DR_FAILED(GetLinkMatrix(&mat_link, _link_id)))
                goto __ret;

            drMatrix44InverseNoScaleFactor(&mat_link, &mat_link);

            drMatrix44Multiply(&mat_parent, &mat_link, &mat_parent);
        }

        drMatrix44Multiply(&_mat_world, &_mat_local, &mat_parent);
    }
    else
    {
        _mat_world = _mat_local;
    }

    if(_ass_obj)
    {
        _ass_obj->Update();
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodeDummy::Render()
{
    if(_ass_obj)
    {
        _ass_obj->Render();
    }

    return DR_RET_OK;
}
DR_RESULT drNodeDummy::CreateAssistantObject(const drVector3* size, DWORD color)
{
    DR_RESULT ret = DR_RET_FAILED;

    drVector3 s = *size / 2;

    drVector3 axis_x(s.x, 0.0f, 0.0f);
    drVector3 axis_y(0.0f, s.y, 0.0f);
    drVector3 axis_z(0.0f, 0.0f, s.z);

    //drMatrix44 coord_mat;
    //drICoordinateSys* coord_sys = _res_mgr->GetSysGraphics()->GetCoordinateSys();
    //coord_sys->GetCurCoordSysMatrix(&coord_mat);

    //drVec3Mat44Mul(&axis_x, &coord_mat);
    //drVec3Mat44Mul(&axis_y, &coord_mat);
    //drVec3Mat44Mul(&axis_z, &coord_mat);


    if(DR_FAILED(_res_mgr->CreateNode((drINode**)&_ass_obj, NODE_PRIMITIVE)))
        goto __ret;

    if(DR_FAILED(_ass_obj->SetParent(this)))
        goto __ret;

    const int v_num = 24 + 6;
    drVector3 vert_buf[v_num] =
    {
        // axis
        drVector3(0.0f, 0.0f, 0.0f),
        drVector3(axis_x),
        drVector3(0.0f, 0.0f, 0.0f),
        drVector3(axis_y),
        drVector3(0.0f, 0.0f, 0.0f),
        drVector3(axis_z),

        // bottom
        drVector3(- s.x, - s.y, - s.z),
        drVector3(- s.x, - s.y,   s.z),

        drVector3(- s.x, - s.y,   s.z),
        drVector3(  s.x, - s.y,   s.z),

        drVector3(  s.x, - s.y,   s.z),
        drVector3(  s.x, - s.y, - s.z),

        drVector3(  s.x, - s.y, - s.z),
        drVector3(- s.x, - s.y, - s.z),

        // top
        drVector3(- s.x,   s.y, - s.z),
        drVector3(- s.x,   s.y,   s.z),

        drVector3(- s.x,   s.y,   s.z),
        drVector3(  s.x,   s.y,   s.z),

        drVector3(  s.x,   s.y,   s.z),
        drVector3(  s.x,   s.y, - s.z),

        drVector3(  s.x,   s.y, - s.z),
        drVector3(- s.x,   s.y, - s.z),

        // side
        drVector3(- s.x, - s.y, - s.z),
        drVector3(- s.x,   s.y, - s.z),

        drVector3(- s.x, - s.y,   s.z),
        drVector3(- s.x,   s.y,   s.z),

        drVector3(  s.x, - s.y,   s.z),
        drVector3(  s.x,   s.y,   s.z),

        drVector3(  s.x, - s.y, - s.z),
        drVector3(  s.x,   s.y, - s.z),
    };
        

    DWORD cor_buf[v_num];
    for(DWORD i = 0; i < v_num; i++)
    {
        if(i < 6)
        {
            const DWORD c[3] =
            {
                0xffff0000,
                0xff00ff00,
                0xff0000ff,
            };

            cor_buf[i] = c[i / 2];
        }
        else
        {
            cor_buf[i] = color;
        }
    }

    drSubsetInfo subset;
    drSubsetInfo_Construct(&subset, v_num / 2, 0, v_num, 0);

    if(DR_FAILED(drLoadPrimitiveLineList(_ass_obj, "assistant_object", v_num, vert_buf, cor_buf, &subset, 1)))
    {
        _ass_obj->Release();
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drNodeHelper
DR_STD_ILELEMENTATION(drNodeHelper)

drNodeHelper::drNodeHelper(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr)
{
    _type = NODE_HELPER;

    _obj_dummy = 0;
    _obj_box = 0;
    _obj_mesh = 0;
}
drNodeHelper::~drNodeHelper()
{
    Destroy();
}

DR_RESULT drNodeHelper::Destroy()
{
    DR_SAFE_RELEASE(_obj_dummy);
    DR_SAFE_RELEASE(_obj_box);
    DR_SAFE_RELEASE(_obj_mesh);

    return DR_RET_OK;
}

DR_RESULT drNodeHelper::LoadHelperInfo(const drHelperInfo* info, int create_instance_flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(info->type & HELPER_TYPE_DUMMY)
    {
        drHelperDummy* d = DR_NEW(drHelperDummy);

        d->SetResourceMgr(_res_mgr);
        d->SetDataInfo(&info->dummy_seq[0], info->dummy_num);

        if(create_instance_flag)
        {
            if(DR_FAILED(d->CreateInstance()))
                goto __ret;
        }

        DR_IF_RELEASE(_obj_dummy);
        _obj_dummy = d;

    }

    if(info->type & HELPER_TYPE_BOX)
    {

        drHelperBox* b = DR_NEW(drHelperBox);

        b->SetResourceMgr(_res_mgr);
        b->SetDataInfo(&info->box_seq[0], info->box_num);

        if(create_instance_flag)
        {
            if(DR_FAILED(b->CreateInstance()))
                goto __ret;
        }

        DR_IF_RELEASE(_obj_box);
        _obj_box = b;
    }

    if(info->type & HELPER_TYPE_MESH)
    {

        drHelperMesh* m = DR_NEW(drHelperMesh);

        m->SetResourceMgr(_res_mgr);
        m->SetDataInfo(&info->mesh_seq[0], info->mesh_num);

        if(create_instance_flag)
        {
            if(DR_FAILED(m->CreateInstance()))
                goto __ret;
        }

        DR_IF_RELEASE(_obj_mesh);
        _obj_mesh = m;
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodeHelper::Copy(const drINodeHelper* src)
{
    drNodeHelper* s = (drNodeHelper*)src;

    if(s->_obj_dummy)
    {
        drHelperDummy* d = DR_NEW(drHelperDummy);
        d->Clone((drHelperDummy*)s->_obj_dummy);
        _obj_dummy = d;
    }
    if(s->_obj_box)
    {
        drHelperBox* b =DR_NEW(drHelperBox);
        b->Clone((drHelperBox*)s->_obj_box);
        _obj_box = b;
    }
    if(s->_obj_mesh)
    {
        drHelperMesh* m = DR_NEW(drHelperMesh);
        m->Clone((drHelperMesh*)s->_obj_mesh);
        _obj_mesh = m;
    }

    return DR_RET_OK;

}

DR_RESULT drNodeHelper::Render()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(!_CheckVisibleState())
        goto __ret_ok;

    if(_obj_dummy)
    {
        if(DR_FAILED(_obj_dummy->Render()))
            goto __ret;
    }
    if(_obj_box)
    {
        if(DR_FAILED(_obj_box->Render()))
            goto __ret;
    }
    if(_obj_mesh)
    {
        if(DR_FAILED(_obj_mesh->Render()))
            goto __ret;
    }

__ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drNodeHelper::GetLinkMatrix(drMatrix44* mat, DWORD link_id)
{
    __asm int 3;
    return 0;
}
DR_RESULT drNodeHelper::Update()
{
    return 0;
}

// drNodeObject
static DWORD __tree_enum_update(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_ABORT;

    drINode* obj = (drINode*)node->GetData();
    if(obj == 0)
    {
        assert(0 && "call __tree_enum_update error");
        goto __ret;
    }

    if(DR_FAILED(obj->Update()))
        goto __ret;

    ret = TREENODE_PROC_RET_CONTINUE;
__ret:
    return ret;
}

static DWORD __tree_enum_render(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_ABORT;

    drINode* obj = (drINode*)node->GetData();
    if(obj == 0)
    {
        assert(0 && "call __tree_enum_render error");
        goto __ret;
    }

    //if(obj->GetType() == NODE_PRIMITIVE)
    //{
        if(DR_FAILED(((drINodePrimitive*)obj)->Render()))
            goto __ret;
    //}

    ret = TREENODE_PROC_RET_CONTINUE;
__ret:
    return ret;
}

static DWORD __tree_proc_cullprimitive(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_ABORT;

    drISceneMgr* scn_mgr = (drISceneMgr*)param;
    drINode* obj = (drINode*)node->GetData();

    if(obj == 0)
    {
        assert(0 && "call __tree_proc_cullprimitive error");
        goto __ret;
    }

    if(obj->GetType() == NODE_PRIMITIVE)
    {
        __asm { int 3 }
        //BYTE v = DR_SUCCEEDED(scn_mgr->CullPrimitive(obj)) ? 1 : 0;
        //obj->GetStateCtrl()->SetState(STATE_FRAMECULLING, v);
    }

    ret = TREENODE_PROC_RET_CONTINUE;
__ret:
    return ret;
}


static DWORD __tree_enum_destroy(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_ABORT;

    drINode* obj = (drINode*)node->GetData();
    if(obj == 0)
    {
        assert(0 && "call __tree_enum_destroy error");
        goto __ret;
    }

    if(obj->GetType() == NODE_PRIMITIVE)
    {
        if(DR_FAILED(obj->Release()))
            goto __ret;
    }

    ret = TREENODE_PROC_RET_CONTINUE;
__ret:
    return ret;
}
static DWORD __tree_enum_query(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_CONTINUE;

    drINode* obj = (drINode*)node->GetData();
    if(obj == 0)
    {
        assert(0 && "call __tree_enum_query error");
        goto __ret;
    }

    drModelNodeQueryInfo* info = (drModelNodeQueryInfo*)param;

    if(info->mask & MNQI_ID)
    {
        if(obj->GetID() != info->id)
            goto __ret;
    }
    if(info->mask & MNQI_TYPE)
    {
        if(obj->GetType() != info->type)
            goto __ret;
    }
    if(info->mask & MNQI_DATA)
    {
        if(obj != info->data)
            goto __ret;
    }
    if(info->mask & MNQI_DESCRIPTOR)
    {
        if(_tcscmp(obj->GetDescriptor(), info->descriptor))
            goto __ret;
    }
    if(info->mask & MNQI_USERPROC)
    {
        if((*info->proc)(node, info->proc_param) == TREENODE_PROC_RET_CONTINUE)
            goto __ret;
    }

    info->node = node;

    ret = TREENODE_PROC_RET_ABORT;

__ret:
    return ret;
}

DR_RESULT drDestroyNodeObject(drITreeNode* node)
{
    DR_RESULT ret = DR_RET_FAILED;


    if(node->EnumTree(__tree_enum_destroy, 0, TREENODE_PROC_INORDER) == TREENODE_PROC_RET_ABORT)
        goto __ret;

    drReleaseTreeNodeList(node);

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_STD_ILELEMENTATION(drNodeObject)

drNodeObject::drNodeObject(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr), _obj_root(0)
{
    _name[0] = '\0';

    drGUIDCreateObject((DR_VOID**)&_obj_root, DR_GUID_TREENODE);
    drINode* node = 0;
    _res_mgr->CreateNode(&node, NODE_DUMMY);
    _obj_root->SetData(node);
}
drNodeObject::~drNodeObject()
{
    Destroy();

    DR_IF_RELEASE(((drINode*)_obj_root->GetData()));
    DR_RELEASE(_obj_root);
}
DR_RESULT drNodeObject::Update()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    if(_obj_root->EnumTree(__tree_enum_update, 0, TREENODE_PROC_PREORDER) == TREENODE_PROC_RET_ABORT)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodeObject::Render()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_obj_root->EnumTree(__tree_enum_render, 0, TREENODE_PROC_PREORDER) == TREENODE_PROC_RET_ABORT)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drNodeObject::IgnoreNodesRender( const IgnoreStruct* is )
{
	DR_RESULT ret = DR_RET_FAILED;

	if(_obj_root->EnumTree(__tree_enum_render, ( void* ) is, TREENODE_PROC_PREORDER_IGNORE ) == TREENODE_PROC_RET_ABORT)
		goto __ret;

	ret = DR_RET_OK;
__ret:
	return ret;
}

DR_RESULT drNodeObject::CullPrimitive()
{
    DR_RESULT ret = DR_RET_FAILED;

    drISysGraphics* sys_grh = _res_mgr->GetSysGraphics();
    drISceneMgr* scn_mgr = sys_grh->GetSceneMgr();
    drIOptionMgr* opt_mgr = sys_grh->GetSystem()->GetOptionMgr();
    BOOL cull_flag = opt_mgr->GetByteFlag(OPTION_FLAG_CULLPRIMITIVE_MODEL);

    if(cull_flag == 0)
        goto __ret_ok;

    if(_obj_root->EnumTree(__tree_proc_cullprimitive, (void*)scn_mgr, TREENODE_PROC_PREORDER) == TREENODE_PROC_RET_ABORT)
        goto __ret;

__ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drNodeObject::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

    drITreeNode* obj_node = _obj_root->GetChild();
    if(obj_node == 0)
        goto __addr_ret_ok;

    if(DR_FAILED(drDestroyNodeObject(obj_node)))
        goto __ret;

    _obj_root->SetChild(0);

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

void drNodeObject::SetMatrix(const drMatrix44* mat)
{
    drINodeDummy* o = (drINodeDummy*)_obj_root->GetData();
    o->SetLocalMatrix(mat);
}

drMatrix44* drNodeObject::GetMatrix()
{
    drINodeDummy* o = (drINodeDummy*)_obj_root->GetData();
    return o->GetWorldMatrix();
}
drIByteSet* drNodeObject::GetStateSet()
{
    drINodeDummy* o = (drINodeDummy*)_obj_root->GetData();
    return o->GetStateSet();
}

DR_RESULT drNodeObject::QueryTreeNode(drModelNodeQueryInfo* info)
{
    return _obj_root->EnumTree(__tree_enum_query, (void*)info, TREENODE_PROC_PREORDER) == TREENODE_PROC_RET_ABORT ? DR_RET_OK : DR_RET_FAILED;
}

DR_RESULT drNodeObject::InsertTreeNode(drITreeNode* parent_node, drITreeNode* prev_node, drITreeNode* node)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(parent_node == 0)
    {
        parent_node = _obj_root;
    }

    if(DR_FAILED(parent_node->InsertChild(prev_node, node)))
        goto __ret;

    drITreeNode* parent = node->GetParent();
    assert(parent && "invalid parent when called drNodeObject::InsertTreeNode");

    drINode* model_parent = (drINode*)parent->GetData();
    assert(model_parent && "invalid model_parent when called drNodeObject::InsertTreeNode");

    drINode* model = (drINode*)node->GetData();
    assert(model && "invalid model when called drNodeObject::InsertTreeNode");

    if(DR_FAILED(model->SetParent(model_parent)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodeObject::RemoveTreeNode(drITreeNode* node)
{
    DR_RESULT ret = DR_RET_FAILED;

    drITreeNode* parent = node->GetParent();

    assert(parent && "invalid node when called drNodeObject::RemoveTreeNode");

    if(parent == 0)
        goto __ret;

    if(DR_FAILED(parent->RemoveChild(node)))
        goto __ret;

    drINode* model = (drINode*)node->GetData();
    if(model == 0)
        goto __ret;

    if(DR_FAILED(model->SetParent(0)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

#if 0
    // process parent relation of children of node
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_obj_root->RemoveChild(node)))
        goto __ret;

    drINode* root_dummy = (drINode*)_obj_root->GetData();

    // set children of node to root node
    drITreeNode* c = node->GetChild();
    if(c)
    {
        drINode* n = (drINode*)node->GetData();

        /* for vertex blend ctrl version
        // check node type with vertex blend ctrl
        if(n->GetType() == NODE_BONECTRL)
        {
            drITreeNode* d = c;

            // set vertex blend ctrl
            while(d)
            {
                drINodePrimitive* p = (drINodePrimitive*)d->GetData();
                p->SetVertexBlendCtrl(0);

                d = d->GetSibling();
            }

            // set parent
            d = c;

            while(d)
            {
                drINode* m = (drINodePrimitive*)d->GetData();
                drINode* m_p = m->GetParent();
                if(m_p)
                {
                    drITreeNode* n_p = _obj_root->FindNode((void*)m_p);
                    if(n_p)
                    {
                        n_p->InsertChild(0, d);
                    }
                    else
                    {
                        m->SetParent(root_dummy);
                        _obj_root->InsertChild(0, d);
                    }
                }
                else
                {
                    m->SetParent(root_dummy);
                    _obj_root->InsertChild(0, d);
                }

                d = d->GetSibling();
            }
        }
        // reset children's parent node
        else
        */
        {
            drITreeNode* d = c;        
            while(d)
            {
                drINode* p = (drINode*)d->GetData();
                p->SetParent(root_dummy);
                _obj_root->InsertChild(0, d);

                d = d->GetSibling();
            }     
        }

        node->SetChild(0);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
#endif
}
DR_RESULT drNodeObject::Load(const char* file, DWORD flag, drITreeNode* parent_node)
{
    DR_RESULT ret = DR_RET_FAILED;

    drModelInfo info;
    drITreeNode* tree_node = 0;

    if(flag != MODELOBJECT_LOAD_RESET
        && flag != MODELOBJECT_LOAD_MERGE
        && flag != MODELOBJECT_LOAD_MERGE2)        
    {
        goto __ret;
    }

    if(DR_FAILED(info.Load(file)))
        goto __ret;


    if(DR_FAILED(drLoadModelInfo(&tree_node, &info, _res_mgr)))
        goto __ret;

    if(flag == MODELOBJECT_LOAD_RESET || flag == MODELOBJECT_LOAD_MERGE)
    {
        if(flag == MODELOBJECT_LOAD_RESET)
        {
            if(DR_FAILED(Destroy()))
                goto __ret;
        }

        drITreeNode* child_node = tree_node->GetChild();
        drITreeNode* sibling_node;

        while(child_node)
        {
            sibling_node = child_node->GetSibling();

            if(DR_FAILED(InsertTreeNode(parent_node, 0, child_node)))
                goto __ret;

            child_node = sibling_node;
        }
        
        tree_node->SetChild(0);
        // release root dummy node
        //DR_RELEASE((drINodeDummy*)tree_node->GetData());
    }
    else if(flag == MODELOBJECT_LOAD_MERGE2)
    {
        if(DR_FAILED(InsertTreeNode(parent_node, 0, tree_node)))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    if(tree_node)
    {
        drDestroyNodeObject(tree_node);
    }
    //DR_IF_RELEASE(tree_node);
    return ret;
}

// assistant proc
DWORD __tree_proc_play_pose(drITreeNode* node, void* param)
{
    DWORD ret = TREENODE_PROC_RET_ABORT;

    drPlayPoseInfo* info = (drPlayPoseInfo*)param;
    drINode* base_node = (drINode*)node->GetData();
    if(base_node == 0)
        goto __ret;

    switch(base_node->GetType())
    {
    case NODE_PRIMITIVE:
        if(DR_FAILED(drNodePrimitive_PlayPoseAll((drINodePrimitive*)base_node, info)))
            goto __ret;
        break;
    case NODE_BONECTRL:
        if(DR_FAILED(drNodeBoneCtrl_PlayPose((drINodeBoneCtrl*)base_node, info)))
            goto __ret;
        break;
    case NODE_DUMMY:        
        if(DR_FAILED(drNodeDummy_PlayPose((drINodeDummy*)base_node, info)))
            goto __ret;
        break;
    case NODE_HELPER:
        break;
    default:
        __asm int 3;
    }

    ret = TREENODE_PROC_RET_CONTINUE;
__ret:
    return ret;
}

DR_RESULT drNodeObject_PlayDefaultPose(drINodeObject* obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drPlayPoseInfo ppi;
    memset(&ppi, 0, sizeof(ppi));
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.pose = 0;
    ppi.frame = 0.0f;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;

    if(obj->GetTreeNodeRoot()->EnumTree(__tree_proc_play_pose,(void*)&ppi, TREENODE_PROC_PREORDER)
        != TREENODE_PROC_RET_CONTINUE)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drNodePrimitive_PlayPose(drINodePrimitive* obj, const drPlayPoseInfo* info, DWORD ctrl_type, DWORD subset, DWORD stage)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrlAgent* anim_agent = obj->GetAnimCtrlAgent();
    if(anim_agent == 0)
    {
        ret = DR_RET_OK_1;
        goto __ret;
    }

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = subset;
    type_info.data[1] = stage;

    drIAnimCtrlObj* ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == 0)
    {
        ret = DR_RET_OK_1;
        goto __ret;
    }

    if(DR_FAILED(ctrl_obj->PlayPose(info)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodePrimitive_PlayPoseAll(drINodePrimitive* obj, const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrlAgent* anim_agent = obj->GetAnimCtrlAgent();
    if(anim_agent == 0)
    {
        ret = DR_RET_OK_1;
        goto __ret;
    }

    drAnimCtrlObjTypeInfo type_info;
    drIAnimCtrlObj* ctrl_obj;
    DWORD n = anim_agent->GetAnimCtrlObjNum();

    for(DWORD i = 0; i < n; i++)
    {
        ctrl_obj = anim_agent->GetAnimCtrlObj(i);

        // drAnimCtrlObjBone在drPrimitive中最为容器而非动画控制器
        ctrl_obj->GetTypeInfo(&type_info);
        if(type_info.type == ANIM_CTRL_TYPE_BONE)
            continue;

        if(DR_FAILED(ctrl_obj->PlayPose(info)))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNodeBoneCtrl_PlayPose(drINodeBoneCtrl* obj, const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrlObjBone* ctrl_obj_bone = obj->GetAnimCtrlObj();
    if(ctrl_obj_bone == 0)
    {
        ret = DR_RET_OK_1;
        goto __ret;
    }

    if(DR_FAILED(ctrl_obj_bone->PlayPose(info)))
        goto __ret;


    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drNodeDummy_PlayPose(drINodeDummy* obj, const drPlayPoseInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrlObjMat* ctrl_obj = obj->GetAnimCtrlObj();
    if(ctrl_obj == 0)
    {
        ret = DR_RET_OK_1;
        goto __ret;
    }

    if(DR_FAILED(ctrl_obj->PlayPose(info)))
        goto __ret;


    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drNode_ShowBoundingObject(drINode* obj, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIHelperObject* helper_obj;
    drINodePrimitive* dummy_obj;

    DWORD type = obj->GetType();

    switch(type)
    {
    case NODE_PRIMITIVE:
        helper_obj = ((drINodePrimitive*)obj)->GetHelperObject();
        if(helper_obj)
        {
            helper_obj->SetVisible(flag);
        }
        ret = DR_RET_OK;
        break;
    case NODE_BONECTRL:
        ret = DR_RET_OK;
        break;
    case NODE_HELPER:
        ret = DR_RET_OK;
        break;
    case NODE_LIGHT:
        ret = DR_RET_OK;
        break;
    case NODE_CAMERA:
        ret = DR_RET_OK;
        break;
    case NODE_DUMMY:
        dummy_obj = ((drINodeDummy*)obj)->GetAssistantObject();
        if(dummy_obj)
        {
            dummy_obj->GetStateSet()->SetValue(STATE_VISIBLE, (BYTE)flag);
        }
        ret = DR_RET_OK;
        break;
    default:
        ;
    }

    return ret;
}

static DWORD __tree_proc_show_bo(drITreeNode* node, void* param)
{
    if(DR_FAILED(drNode_ShowBoundingObject((drINode*)node->GetData(), *(DWORD*)param)))
    {
        return TREENODE_PROC_RET_ABORT;
    }

    return TREENODE_PROC_RET_CONTINUE;
}


static DWORD __tree_proc_dump_objtree(drITreeNode* node, void* param)
{
    drINode* obj_node = (drINode*)node->GetData();
    FILE* fp = (FILE*)param;

    DWORD l = node->GetDepthLevel();
    DWORD c = 0;
    drINode* p = obj_node->GetParent();
    while(p)
    {
        c++;
        p = p->GetParent();
    }
    assert(l == c);

    for(DWORD i = 0; i < l; i++)
    {
        fprintf(fp, "\t");
    }

    fprintf(fp, "type: %d, id: %d, parent: %d\n", 
        obj_node->GetType(), 
        obj_node->GetID(),
        l == 0 ? -1 : obj_node->GetParent()->GetID());


    return TREENODE_PROC_RET_CONTINUE;
}
static DWORD __tree_proc_getprinum(drITreeNode* node, void* param)
{
    drINode* obj = (drINode*)node->GetData();
    
    if(obj->GetType() == NODE_PRIMITIVE)
    {
        if(obj->GetStateSet()->GetValue(STATE_FRAMECULLING))
        {
            *((DWORD*)param) += 1;
        }

    }

    return TREENODE_PROC_RET_CONTINUE;
}

DR_RESULT drNodeObject_ShowBoundingObject(drINodeObject* obj, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(obj->GetTreeNodeRoot()->EnumTree(__tree_proc_show_bo,(void*)&flag, TREENODE_PROC_PREORDER)
        != TREENODE_PROC_RET_CONTINUE)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drNodeObject_DumpObjectTree(drINodeObject* obj, const char* file)
{
    DR_RESULT ret = DR_RET_FAILED;

    FILE* fp;
	fopen_s( &fp, file, "wt");
    if(fp == 0)
        goto __ret;

    if(obj->GetTreeNodeRoot()->EnumTree(__tree_proc_dump_objtree,(void*)fp, TREENODE_PROC_PREORDER)
        != TREENODE_PROC_RET_CONTINUE)
        goto __ret;

    ret = DR_RET_OK;


__ret:
    if(fp)
    {
        fclose(fp);
    }
    return ret;
}

DR_RESULT drNodeObject_GetPrimitiveCullingNum(drINodeObject* obj, DWORD* num)
{
    DR_RESULT ret = DR_RET_FAILED;

    *num = 0;

    if(obj->GetTreeNodeRoot()->EnumTree(__tree_proc_getprinum,(void*)num, TREENODE_PROC_PREORDER)
        != TREENODE_PROC_RET_CONTINUE)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
    
}


DR_END

#endif
