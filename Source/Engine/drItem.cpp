//


#include "drItem.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drResourceMgr.h"
#include "drAnimCtrl.h"
#include "drRenderImp.h"
#include "drPathInfo.h"
#include "drD3D.h"
#include "drShaderMgr.h"
#include <MyMemory.h>

DR_BEGIN


//drItem
DR_STD_ILELEMENTATION( drItem )

drItem::drItem( drIResourceMgr* res_mgr )
: _id( DR_INVALID_INDEX ), _res_mgr( res_mgr ), _obj( 0 ), _link_ctrl( 0 )
{
    _opacity = 1.0f;
    drMatrix44Identity( &_mat_base );
}
drItem::~drItem()
{
    Destroy();
}

DR_RESULT drItem::Load(drIGeomObjInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_obj)
        goto __ret;


    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = 0;
    sys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );

    // create new item object
    drPrimitive* imp = DR_NEW( drPrimitive( _res_mgr ) );


    if( DR_FAILED( imp->Load(info, path_info->GetPath( PATH_TYPE_TEXTURE_ITEM ), NULL ) ) )
        goto __ret;

    _obj = imp;

    _res_mgr->RegisterObject( &_id, this, OBJ_TYPE_ITEM );

    RegisterSceneMgr(_res_mgr->GetSysGraphics()->GetSceneMgr());

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drItem::Load( const char* file, int arbitrary_flag )
{
    if( _obj )
    {
        return DR_RET_FAILED;
    }

    DR_RESULT ret = DR_RET_OK;


    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = 0;
    sys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );

    if(arbitrary_flag == 1)
        goto __a;

    // query model pool
    drItem* obj_model = 0;
    _res_mgr->QueryObject( (void**)&obj_model, OBJ_TYPE_ITEM, file );

    if( obj_model )
    {
        // copy
        obj_model->Copy(this);
    }
    else
    {
__a:
        char path[ DR_MAX_PATH ];
        _snprintf_s( path,DR_MAX_PATH, _TRUNCATE, "%s%s", path_info->GetPath( PATH_TYPE_MODEL_ITEM ), file );

        drResFile res;
        res.obj_id = 0;
        res.res_type = RES_FILE_TYPE_GEOMETRY;
        _tcsncpy_s( res.file_name, path, _TRUNCATE );

        // create new item object
        drPrimitive* imp = DR_NEW( drPrimitive( _res_mgr ) );


        // begin load mesh
        drGeomObjInfo info;

        if( DR_FAILED( info.Load( path ) ) )
            return DR_RET_FAILED;

        if( DR_FAILED( imp->Load( &info, path_info->GetPath( PATH_TYPE_TEXTURE_ITEM ), &res ) ) )
            return DR_RET_FAILED;

        _obj = imp;

        SetFileName( file );
    }

    _res_mgr->RegisterObject( &_id, this, OBJ_TYPE_ITEM );

    RegisterSceneMgr(_res_mgr->GetSysGraphics()->GetSceneMgr());

    return ret;

} 

DR_RESULT drItem::Destroy()
{
    if( _obj == 0 )
        return DR_RET_FAILED;
    
    _obj->Destroy();
    DR_DELETE( _obj );
    _obj = 0;

    _res_mgr->UnregisterObject( NULL, _id, OBJ_TYPE_ITEM );
    _id = DR_INVALID_INDEX;

    return DR_RET_OK;
}

DR_RESULT drItem::Copy( drIItem* src_obj )
{
    drItem* o = (drItem*)src_obj;

    _tcsncpy_s( _file_name, o->_file_name, _TRUNCATE );
    
    o->_obj->Clone( &_obj );

    _id = o->_id;
    _item_type = o->_item_type;
    _mat_base = o->_mat_base;
    _link_ctrl = o->_link_ctrl;
    _link_item_id = o->_link_item_id;
    _link_parent_id = o->_link_parent_id;

    return DR_RET_OK;

}

DR_RESULT drItem::Clone( drIItem** ret_obj )
{
    drItem* o;
    _res_mgr->CreateItem( (drIItem**)&o );

    o->Copy( this );

    *ret_obj = o;
    //_tcsncpy_s( o->_file_name, _file_name );
    //

    //drIPrimitive* p;
    //_obj->Clone( &p );

    //o->_obj = p;

    //o->_id = _id;
    //o->_item_type = _item_type;
    //o->_mat_base = _mat_base;
    //o->_link_ctrl = _link_ctrl;
    //o->_link_item_id = _link_item_id;
    //o->_link_parent_id = _link_parent_id;


    return DR_RET_OK;
}

DR_RESULT drItem::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    if( _obj )
    {
        //_link_ctrl = 0;
        if( _link_ctrl )
        {
            drMatrix44 mat_parent;

            if( DR_FAILED( _link_ctrl->GetLinkCtrlMatrix( &mat_parent, _link_parent_id ) ) )
                goto __ret;

            drMatrix44 mat_dummy;

            if( DR_FAILED( GetDummyMatrix( &mat_dummy, _link_item_id ) ) )
                goto __ret;


            drMatrix44InverseNoScaleFactor( &mat_dummy, &mat_dummy );

            drMatrix44Multiply( &_mat_base, &mat_dummy, &mat_parent );

        }

        _obj->SetMatrixParent( &_mat_base );

        if( DR_FAILED( _obj->Update() ) )
            goto __ret;
    }

    ret = DR_RET_OK;

__ret:

    return ret;
}

DR_RESULT drItem::Render()
{    
    DR_RESULT ret = DR_RET_FAILED;

    if( _state_ctrl.GetState( STATE_VISIBLE ) == 0 )
        goto __addr_ok;


    if(_obj)
    {     
        if(_scene_mgr && _obj->GetState(STATE_TRANSPARENT))
        {
            if(DR_FAILED(_scene_mgr->AddTransparentPrimitive(_obj)))
                goto __ret;
        }
        else
        {
            if(DR_FAILED(_obj->Render()))
                goto __ret;
        }
    }

__addr_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

void drItem::SetMaterial( const drMaterial* mtl )
{
    if( _obj )
    {
        _obj->SetMaterial(mtl);
    }
}

DR_RESULT drItem::HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    drPickInfo p, x;
    x.dis = -1.0f;

    if( DR_SUCCEEDED( _obj->HitTest( &p, org, ray ) ) )
    {
        if( (x.dis == -1.0f) || (x.dis > p.dis) )
        {
            x = p;
        }
    }

    if( x.dis == -1.0f )
    {
        return DR_RET_FAILED;
    }
    else
    {
        *info = x;
        return DR_RET_OK;
    }

}

void drItem::ShowBoundingObject( int show )
{
    if( _obj )
    {
        if(_obj->GetHelperObject())
        {
            _obj->GetHelperObject()->SetVisible(show);
        }
    }
}

const drMatrix44* drItem::GetObjDummyMatrix( DWORD id )
{
    drMatrix44* ret = 0;

    if( _obj == 0 )
        goto __ret;

    drIHelperObject* h = _obj->GetHelperObject();
    if(h == 0)
        goto __ret;

    drIHelperDummy* hd = h->GetHelperDummy();
    if(hd == 0)
        goto __ret;

    drHelperDummyInfo* info = hd->GetDataInfoWithID( id );

    if( info == 0 )
        goto __ret;

    ret = &info->mat;
__ret:
    return ret;
}

const drMatrix44* drItem::GetObjBoneDummyMatrix( DWORD id )
{
    drIAnimCtrlAgent* anim_agent = _obj->GetAnimAgent();
    
    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObj* aca_bone = (drIAnimCtrlObj*)anim_agent->GetAnimCtrlObj(&type_info);
    drIAnimCtrlBone* c = (drIAnimCtrlBone*)aca_bone->GetAnimCtrl();
    if( c == 0 )
        return NULL;

    DWORD rtmat_num = c->GetDummyNum();
    drIndexMatrix44* rtmat_seq = c->GetDummyRTMSeq();

    for( DWORD i = 0; i < rtmat_num; i++ )
    {
        if( rtmat_seq[ i ].id == id )
        {
            return &rtmat_seq[ id ].mat;
        }
    }

    return NULL;
}

DR_RESULT drItem::GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD id )
{
    DR_RESULT ret = DR_RET_FAILED;

    drMatrix44 mat_dummy;

    if( _obj == 0 )
        goto __ret;

    
    if( DR_FAILED( GetDummyMatrix( &mat_dummy, id ) ) )
        goto __ret;

    //drMatrix44Multiply( mat, &mat_dummy, &_mat_base );
    drMatrix44Multiply(mat, &mat_dummy, _obj->GetMatrixGlobal());
    // 这里定义道具没有骨骼数据
    //drIHelperObject* ho = _obj->GetHelperObject();
    //if(ho == 0)
    //    goto __ret;
    //drIHelperDummy* hd = ho->GetHelperDummy();
    //if(hd == 0)
    //    goto __ret;
    //drMatrix44Multiply(mat, &mat_dummy, hd->GetMatrixParent());

    ret = DR_RET_OK;

__ret:
    return ret;
}



DR_RESULT drItem::GetDummyMatrix( drMatrix44* mat, DWORD id )
{
    DR_RESULT ret = DR_RET_FAILED;

    const drMatrix44* mat_dummy;

    drIAnimCtrlAgent* anim_agent = _obj->GetAnimAgent();   
    if(anim_agent == 0)
        goto __addr_obj_dummy;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObj* ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == 0)
        goto __addr_obj_dummy;

    if(ctrl_obj->GetAnimCtrl() == 0)
        goto __addr_obj_dummy;


    mat_dummy = GetObjBoneDummyMatrix(id);
    goto __addr_1;

__addr_obj_dummy:
    mat_dummy = GetObjDummyMatrix( id );

__addr_1:
    if( mat_dummy == 0 )
        goto __ret;

    if( mat )
    {
        *mat = *mat_dummy;
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drItem::SetLinkCtrl( drLinkCtrl* ctrl, DWORD link_parent_id, DWORD link_item_id )
{
    if( DR_FAILED( GetDummyMatrix( NULL, link_item_id ) ) )
        return DR_RET_FAILED;

    _link_ctrl = ctrl;
    _link_parent_id = link_parent_id;
    _link_item_id = link_item_id;

    return DR_RET_OK;
}

DR_RESULT drItem::ClearLinkCtrl()
{
    _link_ctrl = 0;
    _link_parent_id = DR_INVALID_INDEX;
    _link_item_id = DR_INVALID_INDEX;

    return DR_RET_OK;
}

DR_RESULT drItem::PlayDefaultAnimation()
{
    return drPrimitivePlayDefaultAnimation( _obj );
}
void drItem::SetOpacity(float opacity)
{
    if(_obj)
    {
        _opacity = opacity;
        _obj->SetOpacity(opacity);
    }
}

DR_RESULT drItem::SetTextureLOD(DWORD level)
{
    if(_obj)
    {
        _obj->SetTextureLOD(level);
    }

    return DR_RET_OK;
}

DR_END
