//
#include "drSceneMgr.h"

DR_BEGIN

static int __qsort_transparent_primitive(const void *e1, const void *e2)
{
    return ((drSortPriInfo*)e1)->d < ((drSortPriInfo*)e2)->d;
}

//drSceneMgr
DR_STD_ILELEMENTATION(drSceneMgr)

drSceneMgr::drSceneMgr(drISysGraphics* sys_graphics)
: _sys_graphics(sys_graphics), _vf(0)
, _sort_obj_seq(0), _sort_obj_seq_size(0), _sort_obj_num(0), _max_sort_num(0)
{
    _vf = DR_NEW(drViewFrustum);

    // default sort_obj_size is 1024
    _sort_obj_seq_size = 1024;
    _sort_obj_seq = DR_NEW(drSortPriInfo[_sort_obj_seq_size]);

    _sppi.proc = 0;
    _sppi.param = 0;    

    memset(&_frame_info, 0, sizeof(_frame_info));
}
drSceneMgr::~drSceneMgr()
{
    _vf->Release();
    DR_IF_DELETE_A(_sort_obj_seq);
}

DR_RESULT drSceneMgr::Update()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    _frame_info._update_count++;

    return ret;
}
DR_RESULT drSceneMgr::BeginRender()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    _frame_info._render_count++;

    _cull_pri_info.total_cnt = 0;
    _cull_pri_info.culling_cnt = 0;

    drIDeviceObject *dev_obj = _sys_graphics->GetDeviceObject();

    _vf->Update(dev_obj->GetMatViewProj());

    return ret;
}
DR_RESULT drSceneMgr::EndRender()
{
    DR_RESULT ret = DR_RET_FAILED;

    _frame_info._tex_cpf = 0;

    return ret;
}


DR_RESULT drSceneMgr::Render()
{
    return DR_RET_OK;
}

DR_RESULT drSceneMgr::RenderTransparentPrimitive()
{
    DR_RESULT ret = DR_RET_FAILED;

    drSortPriInfo* spi;
    for(DWORD i = 0; i < _sort_obj_num; i++)
    {
        spi = &_sort_obj_seq[i];
        if(spi->sppi.proc)
        {
            (*spi->sppi.proc)(spi->obj, spi->sppi.param);
        }
        else
        {
            if(DR_FAILED(spi->obj->Render()))
            {
            }
        }
    }

    if(_sort_obj_num > _max_sort_num)
    {
        _max_sort_num = _sort_obj_num;
    }

    _sort_obj_num = 0;

    return ret;
}

DR_RESULT drSceneMgr::AddTransparentPrimitive(drIPrimitive *obj)
{
    if(_sort_obj_num == _sort_obj_seq_size)
    {
        DWORD new_size = _sort_obj_seq_size * 2;
        drSortPriInfo *new_seq = DR_NEW(drSortPriInfo[new_size]);
        memcpy(new_seq, _sort_obj_seq, sizeof(drSortPriInfo) * _sort_obj_num);

        DR_DELETE_A(_sort_obj_seq);

        _sort_obj_seq_size = new_size;
        _sort_obj_seq = new_seq;        
    }

    drSortPriInfo* spi = &_sort_obj_seq[_sort_obj_num++];
    spi->obj = obj;
    spi->sppi = _sppi;

    return DR_RET_OK;
}


DR_RESULT drSceneMgr::SortTransparentPrimitive()
{
    drPlane* p = _vf->GetPlane(VIEWFRUSTUM_FRONT);
    drSortPriInfo* o;

    for(DWORD i = 0; i < _sort_obj_num; i++)
    {
        o = &_sort_obj_seq[i];
        o->d = drPlaneClassify(p, (drVector3*)&o->obj->GetMatrixGlobal()->_41);
    }

    // now use quick sort algorithm
    qsort(_sort_obj_seq, _sort_obj_num, sizeof(drSortPriInfo), __qsort_transparent_primitive);

    return DR_RET_OK;
}

DR_RESULT drSceneMgr::CullPrimitive(drIPrimitive* obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD d = 0;
    drMatrix44 mat;
    drBox box;

    drIHelperObject* hb = obj->GetHelperObject();
    if(hb == 0)
    {
        ret = DR_RET_FAILED_2;
        goto __ret;
    }

    drIBoundingSphere* bs = hb->GetBoundingSphere();
    drIBoundingBox* bb = hb->GetBoundingBox();

    if((bs == 0) && (bb == 0))
    {
        ret = DR_RET_FAILED_2;
        goto __ret;
    }

    if(bs)
    {
        drSphere s;
        drBoundingSphereInfo* bsi;
        DWORD bs_num = bs->GetObjNum();
        for(DWORD i = 0; i < bs_num; i++)
        {
            bsi = bs->GetDataInfo(i);
            drMatrix44Multiply(&mat, &bsi->mat, bs->GetMatrixParent());
            
            s = bsi->sphere;
            drVec3Mat44Mul(&s.c, &mat);

            d = bs->GetData();
            ret = _vf->IsSphereInFrustum(&s, &d) ? DR_RET_FAILED : DR_RET_OK;
            if(DR_SUCCEEDED(ret))
            {
                bs->SetData(d);
                break;
            }
        }

    }
    else
    {
        drBoundingBoxInfo* bbi = bb->GetDataInfo(0);
        if(bbi == 0)
        {
            ret = DR_RET_FAILED_2;
            goto __ret;
        }

        // for the compatible checking
        box = bbi->box;
        if(box.r.x < 0.0f)
        {
            box.r.x = -box.r.x;
        }
        if(box.r.y < 0.0f)
        {
            box.r.y = -box.r.y;
        }
        if(box.r.z < 0.0f)
        {
            box.r.z = -box.r.z;
        }

        drMatrix44Multiply(&mat, &bbi->mat, bb->GetMatrixParent());

        d = bb->GetData();

        // begin defined
        //#define BOX_CP
#define SPHERE_CP

#if(defined BOX_CP)
        ret = _vf->IsBoxInFrustum(&box, &mat, &d) ? DR_RET_FAILED : DR_RET_OK;
#endif

#if(defined SPHERE_CP)
        {
            drSphere s;

            //s.c = box.p + box.s / 2;
            //s.r = max(max(box.s.x, box.s.y), box.s.z);
            //drVec3Mat44Mul(&s.c, &mat);

            s.c = box.c;
            drVec3Mat44Mul(&s.c, &mat);
            s.r = drVector3Magnitude(&box.r);


            ret = _vf->IsSphereInFrustum(&s, &d) ? DR_RET_FAILED : DR_RET_OK;
        }
#endif

#undef SPHERE_CP

        bb->SetData(d);

    }

// end

__ret:
    _cull_pri_info.total_cnt += 1;
    if(ret == DR_RET_OK)
    {
        _cull_pri_info.culling_cnt++;
    }

    return ret;
}

DR_END
