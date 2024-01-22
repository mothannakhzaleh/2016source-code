//


#include "drModel.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drResourceMgr.h"
#include "drAnimCtrl.h"
#include "drRenderImp.h"
#include "drPathInfo.h"
#include "drPreDefinition.h"
#include <MyMemory.h>

DR_BEGIN


//drModel
DR_STD_ILELEMENTATION(drModel)

drModel::drModel(drIResourceMgr* res_mgr)
: _id(DR_INVALID_INDEX), _res_mgr(res_mgr), _scene_mgr(0), _helper_object(0)
{
    _model_id = DR_INVALID_INDEX;
    _opacity = 1.0f;

    memset(_obj_seq, 0, sizeof(drIPrimitive*) * DR_MAX_MODEL_GEOM_OBJ_NUM);
    _obj_num = 0;
    drMatrix44Identity(&_mat_base);
}
drModel::~drModel()
{
    Destroy();
}

DR_RESULT drModel::Load(drIModelObjInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_obj_num > 0)
        goto __ret;

    drModelObjInfo* m_info = (drModelObjInfo*)info;

    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = sys->GetPathInfo();
    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    BYTE create_helper_primitive = opt_mgr->GetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE);

    for(DWORD i = 0; i < m_info->geom_obj_num; i++)
    {
        drIPrimitive* imp;
        _res_mgr->CreatePrimitive(&imp);

        imp->Load((drIGeomObjInfo*)m_info->geom_obj_seq[i], path_info->GetPath(PATH_TYPE_TEXTURE_SCENE), NULL);

        _obj_seq[_obj_num] = imp;
        _obj_num += 1;
    }

    if(m_info->helper_data.type != HELPER_TYPE_INVALID)
    {                
        if(_helper_object == 0)
        {
            _helper_object = DR_NEW(drHelperObject((drResourceMgr*)_res_mgr));
            if(DR_FAILED(_helper_object->LoadHelperInfo(&m_info->helper_data, create_helper_primitive)))
                goto __ret;
        }
    }

    drMatrix44Identity(&_mat_base);        

    _model_id = DR_INVALID_INDEX;

    _res_mgr->RegisterObject(&_id, this, OBJ_TYPE_MODEL);

    RegisterSceneMgr(_res_mgr->GetSysGraphics()->GetSceneMgr());


    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drModel::Load(const char* file, DWORD model_id)
{
    DR_RESULT ret = DR_RET_OK;

    if(_obj_num > 0)
    {
        return DR_RET_FAILED;
    }



    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = sys->GetPathInfo();
    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    BYTE create_helper_primitive = opt_mgr->GetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE);

    // query model pool
    drModel* obj_model = 0;
    if(model_id != DR_INVALID_INDEX)
    {
        _res_mgr->QueryModelObject((void**)&obj_model, model_id);
    }
    else
    {
        _res_mgr->QueryObject((void**)&obj_model, OBJ_TYPE_MODEL, file);
    }

    if(obj_model)
    {
        // copy
        Copy(obj_model);
    }
    else
    {
        // create new model object
        char path[DR_MAX_PATH];
        _snprintf_s(path, DR_MAX_PATH, _TRUNCATE,"%s%s", path_info->GetPath(PATH_TYPE_MODEL_SCENE), file);


#ifdef USE_MODEL_INFO_LOAD

        drModelObjInfo model_info;
        drModelObjInfo* model_info_ptr;

#if(defined USE_RES_BUF_MGR)

        drIResBufMgr* res_buf_mgr = _res_mgr->GetResBufMgr();

#if(defined LOAD_RES_BUF_RUNTIME)

        // use path query
        if(model_id == DR_INVALID_INDEX)
        {
            if(DR_FAILED(res_buf_mgr->QueryModelObjInfo((drIModelObjInfo**)&model_info_ptr, path)))
            {
                DR_HANDLE handle;
                if(DR_FAILED(res_buf_mgr->RegisterModelObjInfo(&handle, path)))
                    return DR_RET_FAILED;

                if(DR_FAILED(res_buf_mgr->GetModelObjInfo((drIModelObjInfo**)&model_info_ptr, handle)))
                    return DR_RET_FAILED;
            }
        }
        // USE_MODEL_ID_QUERY
        else
        {
            // first check object existed
            if(DR_FAILED(res_buf_mgr->GetModelObjInfo((drIModelObjInfo**)&model_info_ptr, model_id)))
            {
                if(DR_FAILED(res_buf_mgr->RegisterModelObjInfo(model_id, path)))
                    return DR_RET_FAILED;

                res_buf_mgr->GetModelObjInfo((drIModelObjInfo**)&model_info_ptr, model_id);
            }
            else
            {
                int x = 0;
            }
        }

        goto __load_model;

#else // LOAD_RES_BUF_RUNTIME
        if(model_id == DR_INVALID_INDEX)
        {
            if(DR_SUCCEEDED(res_buf_mgr->QueryModelObjInfo((drIModelObjInfo**)&model_info_ptr, path)))
                goto __load_model;
        }
        else
        {
            if(DR_FAILED(res_buf_mgr->GetModelObjInfo((drIModelObjInfo**)&model_info_ptr, model_id)))
                return DR_RET_FAILED;
        }
#endif

#endif


        if(DR_FAILED(model_info.Load(path)))
        {
            drMessageBox("invalid file name: %s when called drModel::Load", path);
            return DR_RET_FAILED;
        }

        model_info_ptr = &model_info;

__load_model:

        for(DWORD i = 0; i < model_info_ptr->geom_obj_num; i++)
        {
            drResFile res;
            res.obj_id = i;
            res.res_type = RES_FILE_TYPE_MODEL;
            _tcsncpy_s(res.file_name, path, _TRUNCATE);

            drIPrimitive* imp;
            _res_mgr->CreatePrimitive(&imp);

            imp->Load((drIGeomObjInfo*)model_info_ptr->geom_obj_seq[i], path_info->GetPath(PATH_TYPE_TEXTURE_SCENE), &res);

            _obj_seq[_obj_num] = imp;
            _obj_num += 1;
        }

        if(model_info_ptr->helper_data.type != HELPER_TYPE_INVALID)
        {                
            if(_helper_object == 0)
            {
                _helper_object = DR_NEW(drHelperObject((drResourceMgr*)_res_mgr));
                if(DR_FAILED(_helper_object->LoadHelperInfo(&model_info_ptr->helper_data, create_helper_primitive)))
                {
                    drMessageBox("load helper object error with file:%s", path);
                    return DR_RET_FAILED;
                }
            }
        }

#else

#error not support!!!

#endif

        SetFileName(file);

    }
    
    drMatrix44Identity(&_mat_base);        

    _model_id = model_id;

    _res_mgr->RegisterObject(&_id, this, OBJ_TYPE_MODEL);

    RegisterSceneMgr(_res_mgr->GetSysGraphics()->GetSceneMgr());
    //SortPrimitiveObj();

    //this->ShowBoundingObject(1);

    return ret;

} 

DR_RESULT drModel::Destroy()
{
    if(_obj_num == 0)
        return DR_RET_FAILED;
    
    for(DWORD i = 0; i < _obj_num; i++)
    {
        DR_SAFE_RELEASE(_obj_seq[i]);
    }
    _obj_num = 0;

    _res_mgr->UnregisterObject(NULL, _id, OBJ_TYPE_MODEL);
    _id = DR_INVALID_INDEX;

    DR_SAFE_RELEASE(_helper_object);

    return DR_RET_OK;
}

DR_RESULT drModel::Copy(drIModel* src_obj)
{
    drModel* o = (drModel*)src_obj;

    _tcsncpy_s(_file_name, o->_file_name, _TRUNCATE);
    _id = o->_id;
    _obj_num = o->_obj_num;
    _mat_base = o->_mat_base;
    
    for(DWORD i = 0; i < _obj_num; i++)
    {
        o->_obj_seq[i]->Clone(&_obj_seq[i]);
    }

    if(o->_helper_object)
    {
        o->_helper_object->Clone(&_helper_object);
    }

    return DR_RET_OK;
}

DR_RESULT drModel::Clone(drIModel** ret_obj)
{

    drModel* o;
    _res_mgr->CreateModel((drIModel**)&o);

    if(DR_FAILED(o->Copy(this)))
        return DR_RET_FAILED;

    *ret_obj = o;
    
    return DR_RET_OK;
}

//void* g_drModel = NULL;
DR_RESULT drModel::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIPrimitive* imp;
    drIPrimitive* pp;

// 	if( g_drModel )
// 	{
// 		if( this!=g_drModel )
// 			return DR_RET_OK;
// 	}

    for(DWORD i = 0; i < _obj_num; i++)
    {
        imp = _obj_seq[i];

        // 有父子层次结构的矩阵连乘，以后可以改进
        drMatrix44 mat(_mat_base);
        pp = imp;
        while(pp->GetParentID() != DR_INVALID_INDEX)
        {
            if(_obj_seq[pp->GetParentID()])
            {
                drMatrix44Multiply(&mat, _obj_seq[pp->GetParentID()]->GetMatrixLocal(), &mat);
                pp = _obj_seq[pp->GetParentID()];
            }
            else
            {
                break;
            }
        }

        imp->SetMatrixParent(&mat);

        if(DR_FAILED(imp->Update()))
            goto __ret;

    }

    if(_helper_object)
    {
        _helper_object->SetParentMatrix(&_mat_base);
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}

//extern void* g_drPrimitive;
DR_RESULT drModel::Render()
{    
    if(_state_ctrl.GetState(STATE_VISIBLE) == 0)
        return DR_RET_OK;

#if 0
    drISysGraphics* sys_grh = _res_mgr->GetSysGraphics();
    drISceneMgr* scn_mgr = sys_grh->GetSceneMgr();
    drIOptionMgr* opt_mgr = sys_grh->GetSystem()->GetOptionMgr();
    BOOL cull_flag = opt_mgr->GetByteFlag(OPTION_FLAG_CULLPRIMITIVE_MODEL);

    //cull_flag = 0;

    drIPrimitive* p;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        p = _obj_seq[i];

        if(cull_flag)
        {
            if(DR_SUCCEEDED(scn_mgr->CullPrimitive(p)))
            {
                continue;
            }
        }

        if(_scene_mgr && p->GetState(STATE_TRANSPARENT))
        {
            _scene_mgr->AddTransparentPrimitive(p);
        }
        else
        {
            p->Render();
        }
    }
#endif

    drISysGraphics* sys_grh = _res_mgr->GetSysGraphics();
    drISceneMgr* scn_mgr = sys_grh->GetSceneMgr();

    drIPrimitive* p;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        p = _obj_seq[i];
        if(p == 0)
            continue;

        if(p->GetState(STATE_FRAMECULLING) == 1)
            continue;

// 		if( g_drPrimitive )
// 		{
// 			if( p!=g_drPrimitive )
// 				continue;
// 			else if( NULL==g_drModel )
// 				g_drModel = this;
// 		}

		if(_scene_mgr && p->GetState(STATE_TRANSPARENT))
        {
            _scene_mgr->AddTransparentPrimitive(p);
        }
        else
        {
            p->Render();
        }
    }

    if(_helper_object)
    {
        _helper_object->Render();
    }

    return DR_RET_OK;
}

DR_RESULT drModel::RenderPrimitive(DWORD id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(id >= _obj_num)
        goto __ret;

    drIPrimitive* p = _obj_seq[id];

    if(_scene_mgr && p->GetState(STATE_TRANSPARENT))
    {
        if(DR_FAILED(_scene_mgr->AddTransparentPrimitive(p)))
            goto __ret;
    }
    else
    {
        if(DR_FAILED(p->Render()))
            goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drModel::RenderHelperObject()
{
    if(_helper_object)
    {
        return _helper_object->Render();
    }

    return DR_RET_OK;
}

void drModel::SetMaterial(const drMaterial* mtl)
{
    for(DWORD i = 0; i < _obj_num; i++)
    {
        _obj_seq[i]->SetMaterial(mtl);
    }
}

void drModel::SetOpacity(float opacity)
{
    _opacity = opacity;
    for(DWORD i = 0; i < _obj_num; i++)
    {
        _obj_seq[i]->SetOpacity(opacity);
    }
}

DR_RESULT drModel::HitTestPrimitive(drPickInfo* info, const drVector3* org, const drVector3* ray)
{
    drIPrimitive* p;

    drPickInfo u, v;
    v.obj_id = DR_INVALID_INDEX;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        if((p = _obj_seq[i]) == 0)
            continue;

        if(DR_SUCCEEDED(p->HitTest(&u, org, ray)))
        {
            if((v.obj_id == DR_INVALID_INDEX) || (v.dis > u.dis))
            {
                v = u;
                v.obj_id = i;
            }
        }
    }

    if(v.obj_id == DR_INVALID_INDEX)
    {
        return DR_RET_FAILED;
    }

    *info = v;

    return DR_RET_OK;
}

DR_RESULT drModel::HitTestPrimitiveHelperMesh(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name)
{
    drPickInfo u, v;
    v.obj_id = DR_INVALID_INDEX;

    drHelperMesh* obj;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        obj = (drHelperMesh*)_obj_seq[i]->GetHelperObject()->GetHelperMesh();

        if(obj == 0 || obj->IsValidObject() == 0)
            continue;

        if(DR_FAILED(obj->HitTest(&u, org, ray, _obj_seq[i]->GetMatrixGlobal(), type_name)))
            continue;

        if(v.obj_id == DR_INVALID_INDEX || v.dis > u.dis)
        {
            v = u;
            v.data = i;
        }
    }

    if(v.obj_id == DR_INVALID_INDEX)
        return DR_RET_FAILED;

    *info = v;

    return DR_RET_OK;
}

DR_RESULT drModel::HitTestPrimitiveHelperBox(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name)
{
    drPickInfo u, v;
    v.obj_id = DR_INVALID_INDEX;

    drHelperBox* obj;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        obj = (drHelperBox*)_obj_seq[i]->GetHelperObject()->GetHelperBox();

        if(obj == 0 || obj->IsValidObject() == 0)
            continue;

        if(DR_FAILED(obj->HitTest(&u, org, ray, _obj_seq[i]->GetMatrixGlobal(), type_name)))
            continue;

        if(v.obj_id == DR_INVALID_INDEX || v.dis > u.dis)
        {
            v = u;
            v.data = i;
        }
    }

    if(v.obj_id == DR_INVALID_INDEX)
        return DR_RET_FAILED;

    *info = v;

    return DR_RET_OK;
}


DR_RESULT drModel::HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray)
{
    if(_helper_object == 0)
        return DR_RET_FAILED_2;

    DR_RESULT r1 = DR_RET_FAILED;
    DR_RESULT r2 = DR_RET_FAILED;

    drPickInfo u;
    memset(&u, 0, sizeof(u));

    drIBoundingSphere* bs = _helper_object->GetBoundingSphere();
    drIBoundingBox* bb = _helper_object->GetBoundingBox();

    if(bs && DR_SUCCEEDED(r1 = bs->HitTest(&u, org, ray, &_mat_base)))
    {
        *info = u;
    }
    if(bb && DR_SUCCEEDED(r2 = bb->HitTest(&u, org, ray, &_mat_base)))
    {
        if(DR_FAILED(r1))
        {
            *info = u;
        }
        else if(info->dis > u.dis)
        {
            *info = u;
        }
    }

    return (DR_SUCCEEDED(r1) || DR_SUCCEEDED(r2)) ? DR_RET_OK : DR_RET_FAILED;
}

// return value:
// DR_RET_FAILED_2: no valid helper mesh
// DR_RET_FAILED: hit test failed
// DR_RET_OK: hit test succeeded
DR_RESULT drModel::HitTestHelperMesh(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name)
{
    drPickInfo u;

    DR_RESULT ret = DR_RET_FAILED;

    if(_helper_object == 0)
    {
        ret = DR_RET_FAILED_2;
        goto __ret;
    }

    // first check bounding object
#if 0
    if(_helper_object->GetBoundingBox() == 0
        && _helper_object->GetBoundingSphere() == 0)
    {
        return DR_RET_FAILED_2;
    }

    if(DR_FAILED(HitTest(&u, org, ray)))
    {
        return DR_RET_FAILED_2;
    }
#endif
    // end

    drHelperMesh* obj = (drHelperMesh*)_helper_object->GetHelperMesh();

    if(obj == 0 || obj->IsValidObject() == 0)
    {
        ret = DR_RET_FAILED_2;
        goto __ret;
    }


    if(DR_FAILED(ret = obj->HitTest(&u, org, ray, &_mat_base, type_name)))
        goto __ret;

    *info = u;

__ret:
    return ret;
}
// return value:
// DR_RET_FAILED_2: no valid helper mesh
// DR_RET_FAILED: hit test failed
// DR_RET_OK: hit test succeeded
DR_RESULT drModel::HitTestHelperBox(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name)
{
    if(_helper_object == 0)
        return DR_RET_FAILED_2;

    drHelperBox* obj = (drHelperBox*)_helper_object->GetHelperBox();

    if(obj->IsValidObject() == 0)
        return DR_RET_FAILED_2;

    drPickInfo u;

    if(DR_FAILED(obj->HitTest(&u, org, ray, &_mat_base, type_name)))
        return DR_RET_FAILED;

    *info = u;

    return DR_RET_OK;
}

void drModel::ShowHelperObject(int show)
{
    if(_helper_object)
    {
        _helper_object->SetVisible(show);
    }

    drIHelperObject* helper_obj;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        if((helper_obj = _obj_seq[i]->GetHelperObject()) != 0)
        {
            helper_obj->SetVisible(show);
        }
    }
}
void drModel::ShowHelperMesh(int show)
{
    drIHelperMesh* h;

    if(_helper_object)
    {
        if(h = _helper_object->GetHelperMesh())
        {
            h->SetVisible(show);
        }
    }

    for(DWORD i = 0; i < _obj_num; i++)
    {
        if(h = _obj_seq[i]->GetHelperObject()->GetHelperMesh())
        {
            h->SetVisible(show);
        }
    }
}
void drModel::ShowHelperBox(int show)
{
    for(DWORD i = 0; i < _obj_num; i++)
    {
        _obj_seq[i]->GetHelperObject()->GetHelperBox()->SetVisible(show);
    }
}
void drModel::ShowBoundingObject(int show)
{
    drIBoundingBox* bb;
    drIBoundingSphere* bs;

    for(DWORD i = 0; i < _obj_num; i++)
    { 
        if(bb = _obj_seq[i]->GetHelperObject()->GetBoundingBox())
        {
            bb->SetVisible(show);
        }
        if(bs = _obj_seq[i]->GetHelperObject()->GetBoundingSphere())
        {
            bs->SetVisible(show);
        }
    }
}

DR_RESULT drModel::SortPrimitiveObj()
{
    drIPrimitive* p;

    for(DWORD i = 0; i < _obj_num - 1; i++)
    {
        for(DWORD j = i + 1; j< _obj_num; j++)
        {
            p = _obj_seq[i];
            _obj_seq[i] = _obj_seq[j];
            _obj_seq[j] = p;
            //if(_obj_seq[j]->_
        }
    }

    return DR_RET_OK;
}

DR_RESULT drModel::PlayDefaultAnimation()
{
    drPlayPoseInfo ppi;
    memset(&ppi, 0, sizeof(ppi));
    ppi.bit_mask = PPI_MASK_DEFAULT;
    ppi.pose = 0;
    ppi.frame = 0.0f;
    ppi.type = PLAY_LOOP;
    ppi.velocity = 1.0f;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        drPrimitivePlayDefaultAnimation(_obj_seq[i]);
    }

    return DR_RET_OK;
}

DR_RESULT drModel::GetLinkCtrlMatrix(drMatrix44* mat, DWORD link_id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_helper_object == NULL)
        goto __ret;

    drIHelperDummy* d = _helper_object->GetHelperDummy();
    if(d == NULL)
        goto __ret;

    drHelperDummyInfo* hdi = d->GetDataInfoWithID(link_id);
    if(hdi == NULL)
        goto __ret;

    drMatrix44* mat_parent = d->GetMatrixParent();
    drMatrix44Multiply(mat, &hdi->mat, mat_parent);

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drModel::SetItemLink(const drItemLinkInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_helper_object == NULL)
        goto __ret;

    drIHelperDummy* d = _helper_object->GetHelperDummy();
    if(d == NULL)
        goto __ret;

    drHelperDummyInfo* hdi = d->GetDataInfoWithID(info->link_parent_id);
    if(hdi == NULL)
        goto __ret;

    ret = info->obj->SetLinkCtrl(this, info->link_parent_id, info->link_item_id);

__ret:
    return ret;
}

DR_RESULT drModel::ClearItemLink(drIItem* obj)
{
    return obj->ClearLinkCtrl();
}

DR_RESULT drModel::SetTextureLOD(DWORD level)
{
    for(DWORD i = 0; i < _obj_num; i++)
    {
        _obj_seq[i]->SetTextureLOD(level);
    }

    return DR_RET_OK;
}
DR_RESULT drModel::CullPrimitive()
{
    DR_RESULT ret = DR_RET_FAILED;

    drISysGraphics* sys_grh = _res_mgr->GetSysGraphics();
    drISceneMgr* scn_mgr = sys_grh->GetSceneMgr();
    drIOptionMgr* opt_mgr = sys_grh->GetSystem()->GetOptionMgr();
    BOOL cull_flag = opt_mgr->GetByteFlag(OPTION_FLAG_CULLPRIMITIVE_MODEL);

    if(cull_flag == 0)
        goto __ret_ok;

    drIPrimitive* p;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        p = _obj_seq[i];
        if(p == 0)
            continue;

        BYTE v = DR_SUCCEEDED(scn_mgr->CullPrimitive(p)) ? 1 : 0;

        p->SetState(STATE_FRAMECULLING, v);
    }

__ret_ok:
    ret = DR_RET_OK;
    return ret;
}
DWORD drModel::GetCullingPrimitiveNum()
{
    DWORD n = 0;
    drIPrimitive* p;

    for(DWORD i = 0; i < _obj_num; i++)
    {
        p = _obj_seq[i];
        if(p == 0)
            continue;

        if(p->GetState(STATE_FRAMECULLING))
        {
            n++;
        }
    }

    return n;
}

DR_RESULT drModel::ExtractModelInfo(drIModelObjInfo* out_info)
{
    DR_RESULT ret = DR_RET_FAILED;

    drModelObjInfo* a = (drModelObjInfo*)out_info;

    DWORD pri_num = _obj_num;
    drIPrimitive* pri = 0;

    // primitive
    for(DWORD i = 0; i < pri_num; i++)
    {
        pri = _obj_seq[i];
        a->geom_obj_seq[i] = DR_NEW(drGeomObjInfo);
        if(DR_FAILED(pri->ExtractGeomObjInfo(a->geom_obj_seq[i])))
            goto __ret;
    }
    a->geom_obj_num = pri_num;

    // helper object
    if(_helper_object)
    {
        if(DR_FAILED(_helper_object->ExtractHelperInfo(&a->helper_data)))
            goto __ret;
    }

    
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_END
