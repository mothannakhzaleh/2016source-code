//


#include "drPhysique.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drPathInfo.h"
#include "drAnimCtrl.h"
#include "drRenderImp.h"
#include "drResourceMgr.h"
#include "drD3D.h"
#include "drShaderMgr.h"
#include "drItem.h"
#include "drPredefinition.h"
#include <MyMemory.h>
#include <CPerformance.h>

DR_BEGIN

unsigned int __stdcall __load_bone(void* param)
{
	drPhysiqueBoneInfo* bone = (drPhysiqueBoneInfo*)param;
	try
	{
		bone->p->LoadBoneCatch( *bone );
		bone->p->decCount();
		delete bone;
	}
	catch( ... )
	{
		
	}	
    return 0;
}

unsigned int __stdcall __load_pri(void* param)
{
	drPhysiquePriInfo* pri = (drPhysiquePriInfo*)param;
	try
	{
		pri->p->LoadPriCatch( *pri );
		pri->p->decCount();
		delete pri;
	}
	catch( ... )
	{
		
	}	
	
    return 0;
}

drGeomManager g_GeomManager;

drGeomManager::drGeomManager()
{
	m_GeomobjMap.clear();
	m_AnimDataMap.clear();
}

drGeomManager::~drGeomManager()
{
	GEOMOBJ_MAP::iterator pos1 = m_GeomobjMap.begin();
	for( ; pos1 != m_GeomobjMap.end(); pos1++ )
	{
		delete (*pos1).second;
	}
	m_GeomobjMap.clear();

	ANIMDATA_MAP::iterator pos2 = m_AnimDataMap.begin();
	for( ; pos2 != m_AnimDataMap.end(); pos2++ )
	{
		(*pos2).second->Release();
	}
	m_AnimDataMap.clear();
}

drGeomObjInfo* drGeomManager::GetGeomObjInfo( const char file[] )
{
	GEOMOBJ_MAP::iterator pos = m_GeomobjMap.find( file );
	if( pos != m_GeomobjMap.end() )
	{
		return (*pos).second;
	}
	return NULL;
}

bool drGeomManager::LoadGeomobj( const char file[] )
{
	static char path[ DR_MAX_PATH ];
	_snprintf_s( path, DR_MAX_PATH,_TRUNCATE, "%s%s", "model\\character\\", file );
	drGeomObjInfo* pInfo = new drGeomObjInfo;
	if( DR_FAILED(pInfo->Load( path )) )
	{
		delete pInfo;
		return false;
	}
	m_GeomobjMap[file] = pInfo;
	return true;
}

drIAnimDataBone* drGeomManager::GetBoneData( const char file[] )
{
	ANIMDATA_MAP::iterator pos = m_AnimDataMap.find( file );
	if( pos != m_AnimDataMap.end() )
	{
		return (*pos).second;
	}
	return NULL;
}

bool drGeomManager::LoadBoneData( const char file[] )
{
	static char path[ DR_MAX_PATH ];
	_snprintf_s( path, DR_MAX_PATH, _TRUNCATE,"%s%s", "animation\\", file );
	drIAnimDataBone* i_data;
	drCreateObjectGUID((DR_VOID**)&i_data, DR_GUID_ANIMDATABONE);
	if( DR_FAILED( i_data->Load( path ) ) )
	{
		i_data->Release();
		return false;
	}
	m_AnimDataMap[file] = i_data;
	return true;
}



// drPhysique
DR_STD_ILELEMENTATION( drPhysique )

//#define DYNAMIC_LOADING

// begin construct
drPhysique::drPhysique( drIResourceMgr* res_mgr )
: _res_mgr( res_mgr ), _scene_mgr(0), _id( DR_INVALID_INDEX ), _anim_agent( 0 )
{
    _file_name[ 0 ] = '\0';
    drMatrix44Identity( &_mat_base );
    memset( _obj_seq, 0, sizeof(drIPrimitive*) * DR_MAX_SUBSKIN_NUM );
    _opacity = 1.0f;
	_count = 0;
	_start = false;
	_end = false;
}
// end construct

drPhysique::drPhysique()
: _id( DR_INVALID_INDEX ), _anim_agent( 0 )
{
    _res_mgr = drSysGraphics::GetActiveIGraphicsSystem()->GetResourceMgr();

    _file_name[ 0 ] = '\0';
    drMatrix44Identity( &_mat_base );
    memset( _obj_seq, 0, sizeof(drIPrimitive*) * DR_MAX_SUBSKIN_NUM );
}

drPhysique::~drPhysique()
{
    Destroy();
}

DR_RESULT drPhysique::GetLinkCtrlMatrix( drMatrix44* mat, DWORD link_id )
{
    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObjBone* bone_ctrl = (drIAnimCtrlObjBone*)_anim_agent->GetAnimCtrlObj(&type_info);
    if(bone_ctrl == NULL)
        goto __ret;

    drMatrix44* rtm = bone_ctrl->GetDummyRTM( link_id );

    if( rtm == NULL )
        goto __ret;

    drMatrix44Multiply( mat, rtm, &_mat_base );

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drPhysique::DestroyPrimitive( DWORD part_id )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( _obj_seq[ part_id ] == 0 )
    {
        ret = DR_RET_OK;
        goto __ret;
    }

    if( DR_FAILED( _obj_seq[ part_id ]->Destroy() ) )
        goto __ret;

    _obj_seq[ part_id ]->Release();
    _obj_seq[ part_id ] = 0;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drPhysique::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

#ifdef DYNAMIC_LOADING
	while( _count > 0 || (_start && !_end) )
	{
		Sleep( 1 );
	}
#endif 

    for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if( DR_FAILED( DestroyPrimitive( i ) ) )
        {
            assert( 0 && "call DestroyPrimitive in drPhysique::Destroy error" );
        }
    }

    DR_SAFE_RELEASE( _anim_agent );

    return DR_RET_OK;
}

DR_RESULT drPhysique::LoadBoneCatch( drPhysiqueBoneInfo& info )
{
	if(DR_FAILED(info.data->Load(info.str.c_str())))
		goto __addr_1;

	if(DR_FAILED(info.cb->LoadData(info.data)))
		goto __addr_1;

	info.cb->SetResFile(&info.res);

	info.bc->AttachAnimCtrl(info.cb);
	info.bc->SetTypeInfo(&info.tp);

__addr_1:
	info.data->Release();

	return DR_RET_OK;
}

DR_RESULT drPhysique::LoadBone( const char* file )
{
    DR_RESULT ret = DR_RET_FAILED;

    drResFileAnimData res;

    drIAnimCtrlObjBone* bone_ctrl;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

/*------------------------------------------------------------------
   这些 TInit TBegin TEnd 用于检测代码段间的效能，Release不起作用 
   这段代码主要在于检测创建人物时的耗时，未优化完 by Waiting
------------------------------------------------------------------*/
//TInit
    // check existing bone
    if(_anim_agent && _anim_agent->GetAnimCtrlObj(&type_info))
    {
        bone_ctrl = (drIAnimCtrlObjBone*)_anim_agent->RemoveAnimCtrlObj(&type_info);
        DR_SAFE_RELEASE(bone_ctrl);
        //goto __ret;
    }

    if(_anim_agent == NULL)
    {
        if(DR_FAILED(_res_mgr->CreateAnimCtrlAgent(&_anim_agent)))
            goto __ret;
    }

    if(DR_FAILED(_res_mgr->CreateAnimCtrlObj((drIAnimCtrlObj**)&bone_ctrl, ANIM_CTRL_TYPE_BONE)))
        goto __ret;

    if(DR_FAILED(_anim_agent->AddAnimCtrlObj(bone_ctrl)))
        goto __ret;

    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = 0;
    sys->GetInterface( (DR_VOID**)&path_info, DR_GUID_PATHINFO );

    char path[ DR_MAX_PATH ];
    _snprintf_s( path, DR_MAX_PATH,_TRUNCATE, "%s%s", path_info->GetPath( PATH_TYPE_ANIMATION ), file );

    DWORD ret_id;    
    
    res.obj_id = 0;
    res.res_type = RES_FILE_TYPE_GENERIC;
    res.anim_type = ANIM_CTRL_TYPE_BONE;
    _tcsncpy_s( res.file_name, path, _TRUNCATE );

    if(DR_SUCCEEDED(_res_mgr->QueryAnimCtrl(&ret_id, &res)))
    {
        drIAnimCtrlBone* anim_ctrl = NULL;
        if(DR_FAILED(_res_mgr->GetAnimCtrl((drIAnimCtrl**)&anim_ctrl, ret_id)))
            goto __ret;
        _res_mgr->AddRefAnimCtrl(anim_ctrl, 1);
        bone_ctrl->AttachAnimCtrl(anim_ctrl);
    }
    else
    {
#ifdef DYNAMIC_LOADING
        drIAnimCtrlBone* ctrl_bone;
        if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_bone, ANIM_CTRL_TYPE_BONE)))
            goto __ret;		

        drIAnimDataBone* i_data;
        drCreateObjectGUID((DR_VOID**)&i_data, DR_GUID_ANIMDATABONE);

		drPhysiqueBoneInfo* bi = new drPhysiqueBoneInfo;
		bi->p = this;
		bi->str = path;
		bi->data = i_data;
		bi->cb = ctrl_bone;
		bi->tp = type_info;
		bi->bc = bone_ctrl;
		bi->res = res;

		drIThreadPoolMgr* tp_mgr = _res_mgr->GetThreadPoolMgr();
		drIThreadPool* tp = tp_mgr->GetThreadPool(THREAD_POOL_LOADPHY);
		
		incCount();
		if(DR_FAILED(tp->RegisterTask(__load_bone, (void*)bi)))
		{
			char szData[128];
			_snprintf_s( szData, 128, _TRUNCATE,"Load bone file error!%s.", path );
			MessageBox( NULL, szData, "Error", MB_OK );
			return DR_RET_FAILED;
		}
#else
//TBegin
        drIAnimCtrlBone* ctrl_bone;
        drIAnimDataBone* i_data = g_GeomManager.GetBoneData( file );
		if( i_data == NULL )
		{
// 			IP("LoadBone: %s\n",  file );
			drCreateObjectGUID((DR_VOID**)&i_data, DR_GUID_ANIMDATABONE);
			if(DR_FAILED(i_data->Load(path)))
			{
				//TEnd
				goto __addr_1;
			}
			g_GeomManager.AttachBoneData(file, i_data);
		}
//TEnd
        if(DR_FAILED(_res_mgr->CreateAnimCtrl((drIAnimCtrl**)&ctrl_bone, ANIM_CTRL_TYPE_BONE)))
		{
			//TEnd
            goto __addr_1;
		}
//TBegin
        if(DR_FAILED(ctrl_bone->LoadData(i_data)))
		{
			//TEnd
            goto __addr_1;
		}
//TEnd
        ctrl_bone->SetResFile(&res);

        bone_ctrl->AttachAnimCtrl(ctrl_bone);
        bone_ctrl->SetTypeInfo(&type_info);

        //i_data->Release();
        goto __addr_2;
__addr_1:        
        goto __ret;

__addr_2:
        ;
#endif 
    }
//TEnd

    RegisterSceneMgr(_res_mgr->GetSysGraphics()->GetSceneMgr());

    ret = DR_RET_OK;
__ret:
    if(ret == DR_RET_FAILED)
    {
		//TBegin
        _anim_agent->Release();
        _anim_agent = 0;
		//TEnd
    }
    return ret;
}

DR_RESULT drPhysique::LoadPrimitive(DWORD part_id, drIGeomObjInfo* geom_info)
{
    if( part_id < 0 || part_id >= DR_MAX_SUBSKIN_NUM )
        return ERR_INVALID_PARAM;


    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = sys->GetPathInfo();
    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    BYTE create_helper_primitive = opt_mgr->GetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE);

    char* tex_path = path_info->GetPath( PATH_TYPE_TEXTURE_CHARACTER );

    drGeomObjInfo* info = (drGeomObjInfo*)geom_info;

    // query mesh pool
    drIPrimitive* imp;
    drIMeshAgent* mesh_agent;
    drIMtlTexAgent* mtltex_agent;

    _res_mgr->CreatePrimitive( &imp );
    _res_mgr->CreateMeshAgent( &mesh_agent );
    
    
    // mesh
    mesh_agent->LoadMesh( &info->mesh );

    imp->SetMeshAgent(mesh_agent);

    // material and texture
    for( DWORD j = 0; j < info->mtl_num; j++ )
    {
        _res_mgr->CreateMtlTexAgent( &mtltex_agent );

        drMtlTexInfo* mti = &info->mtl_seq[ j ];

        mtltex_agent->SetTranspType(mti->transp_type);
        mtltex_agent->SetMaterial( &mti->mtl );

        mtltex_agent->GetMtlRenderStateSet()->Load(mti->rs_set, DR_MTL_RS_NUM);

        mtltex_agent->SetOpacity(mti->opacity);

        for( DWORD i = 0; i < DR_MAX_TEXTURESTAGE_NUM; i++ )
        {
            drTexInfo* tex_info = &mti->tex_seq[ i ];

            if(tex_info->stage == DR_INVALID_INDEX)
                break;

            mtltex_agent->LoadTextureStage(tex_info, tex_path);
        }

        imp->SetMtlTexAgent( j, mtltex_agent );
    }
    // end

    // =======================
    // create render ctrl agent
    imp->LoadRenderCtrl(&info->rcci);
    // state ctrl
    imp->SetState(&info->state_ctrl);

    // create anim ctrl agent and anim ctrl obj bone
    drIAnimCtrlObj* ctrl_obj = NULL;
    drIAnimCtrlAgent* anim_agent = NULL;
    _res_mgr->CreateAnimCtrlObj(&ctrl_obj, ANIM_CTRL_TYPE_BONE);

    if((anim_agent = imp->GetAnimAgent()) == 0)
    {
        _res_mgr->CreateAnimCtrlAgent(&anim_agent);
        imp->SetAnimCtrlAgent(anim_agent);
    }

    anim_agent->AddAnimCtrlObj(ctrl_obj);
    

    // 设置父子关系
    imp->SetID(info->id);
    imp->SetParentID( info->parent_id );

    // local matrix
    imp->SetMatrixLocal( &info->mat_local );

    if( info->helper_size > 0 )
    {
        drIHelperObject* h;
        _res_mgr->CreateHelperObject(&h);
        if(DR_FAILED(h->LoadHelperInfo(&info->helper_data, create_helper_primitive)))
        {
            drMessageBox("LoadHelperInfo error");
        }
        imp->SetHelperObject(h);
    }

    // 这里把ObjImp的动画数据载入也放在LoadMesh中执行
    if( info->anim_size > 0 )
    {
        imp->LoadAnimData( &info->anim_data, tex_path, 0 );
    }

    DR_SAFE_RELEASE( _obj_seq[ part_id ] );

    _obj_seq[ part_id ] = imp;


    _res_mgr->RegisterObject( &_id, this, OBJ_TYPE_CHARACTER );

    return DR_RET_OK;

}

DR_RESULT drPhysique::LoadPriCatch( const drPhysiquePriInfo& info )
{
	return DR_RET_OK;
}

DR_RESULT drPhysique::LoadPrimitive( DWORD part_id, const char* file )
{
    if( part_id < 0 || part_id >= DR_MAX_SUBSKIN_NUM )
        return ERR_INVALID_PARAM;


    drISysGraphics* sys_graphics = _res_mgr->GetSysGraphics();
    drISystem* sys = sys_graphics->GetSystem();
    drIPathInfo* path_info = sys->GetPathInfo();
    drIOptionMgr* opt_mgr = sys->GetOptionMgr();
    BYTE create_helper_primitive = opt_mgr->GetByteFlag(OPTION_FLAG_CREATEHELPERPRIMITIVE);

    char* tex_path = path_info->GetPath( PATH_TYPE_TEXTURE_CHARACTER );

    // query mesh pool
    DWORD ret_id;

    char path[ DR_MAX_PATH ];
    _snprintf_s( path, DR_MAX_PATH, _TRUNCATE, "%s%s", path_info->GetPath(PATH_TYPE_MODEL_CHARACTER), file );
    
    drResFile res;
    res.obj_id = 0;
    res.res_type = RES_FILE_TYPE_GEOMETRY;
    _tcsncpy_s( res.file_name, path, _TRUNCATE );

    //drGeomObjInfo info;
    //if( DR_FAILED( info.Load( path ) ) )
    //{
    //    return DR_RET_FAILED;
    //}

	drGeomObjInfo* pInfo = g_GeomManager.GetGeomObjInfo( file );
	if( !pInfo )
	{
//IP("LoadPrimitive: %s\n", path);
		g_GeomManager.LoadGeomobj( file );
		pInfo = g_GeomManager.GetGeomObjInfo( file );
		if( !pInfo )
			return DR_RET_FAILED;
	}

    drIPrimitive* imp;
    drIMeshAgent* mesh_agent;
    drIMtlTexAgent* mtltex_agent;
    drIMesh* mesh;
    drITex* tex;

    _res_mgr->CreatePrimitive( &imp );
    _res_mgr->CreateMeshAgent( &mesh_agent );
    
    
    // mesh
    drResFileMesh rfm;
    rfm.obj_id = 0;
    rfm.res_type = RES_FILE_TYPE_GEOMETRY;
    _tcsncpy_s( rfm.file_name, path, _TRUNCATE );

    if( DR_SUCCEEDED( _res_mgr->QueryMesh( &ret_id, &rfm ) ) )
    {
        _res_mgr->GetMesh( &mesh, ret_id );
        _res_mgr->AddRefMesh( mesh, 1 );

        mesh_agent->SetMesh( mesh );
    }
    else
    {
		mesh_agent->LoadMesh( &pInfo->mesh/*&info.mesh*/ );
    }

    mesh_agent->GetMesh()->SetResFile( &rfm );

    imp->SetMeshAgent(mesh_agent);

    // material and texture
    DWORD tex_id;    

    for( DWORD j = 0; j < pInfo->mtl_num; j++ )
    {
        _res_mgr->CreateMtlTexAgent( &mtltex_agent );

        drMtlTexInfo* mti = &pInfo->mtl_seq[ j ];

        mtltex_agent->SetTranspType(mti->transp_type);
        mtltex_agent->SetMaterial( &mti->mtl );

        mtltex_agent->GetMtlRenderStateSet()->Load(mti->rs_set, DR_MTL_RS_NUM);

        mtltex_agent->SetOpacity(mti->opacity);

        for( DWORD i = 0; i < DR_MAX_TEXTURESTAGE_NUM; i++ )
        {
            drTexInfo* tex_info = &mti->tex_seq[ i ];

            if(tex_info->stage == DR_INVALID_INDEX)
                break;

            _snprintf_s( path, DR_MAX_PATH, _TRUNCATE ,"%s%s", tex_path, tex_info->file_name );

            if( DR_SUCCEEDED( _res_mgr->QueryTex( &tex_id, path ) ) )
            {
                _res_mgr->GetTex( &tex, tex_id );
                _res_mgr->AddRefTex( tex, 1 );

                drITex* ret_tex = 0;
                mtltex_agent->SetTex( i, tex, &ret_tex );
                //DR_SAFE_RELEASE(ret_tex);
                if(ret_tex)
                {
                    if(ret_tex->GetRegisterID() != DR_INVALID_INDEX)
                        _res_mgr->UnregisterTex(ret_tex);
                    else
                        ret_tex->Release();
                }
            }
            else
            {
                {
                    tex_info->level = D3DX_DEFAULT;
                }

                mtltex_agent->LoadTextureStage(tex_info, tex_path);
            }
        }

        imp->SetMtlTexAgent( j, mtltex_agent );
    }
    // end

    // =======================
    // create render ctrl agent
    imp->LoadRenderCtrl(&pInfo->rcci);
    // state ctrl
    imp->SetState(&pInfo->state_ctrl);

    // create anim ctrl agent and anim ctrl obj bone
    drIAnimCtrlObj* ctrl_obj = NULL;
    drIAnimCtrlAgent* anim_agent = NULL;
    _res_mgr->CreateAnimCtrlObj(&ctrl_obj, ANIM_CTRL_TYPE_BONE);

    if((anim_agent = imp->GetAnimAgent()) == 0)
    {
        _res_mgr->CreateAnimCtrlAgent(&anim_agent);
        imp->SetAnimCtrlAgent(anim_agent);
    }

    anim_agent->AddAnimCtrlObj(ctrl_obj);
    

    // 设置父子关系
    imp->SetID(pInfo->id);
    imp->SetParentID( pInfo->parent_id );

    // local matrix
    imp->SetMatrixLocal( &pInfo->mat_local );

    if( pInfo->helper_size > 0 )
    {
        drIHelperObject* h;
        _res_mgr->CreateHelperObject(&h);
        if(DR_FAILED(h->LoadHelperInfo(&pInfo->helper_data, create_helper_primitive)))
        {
            drMessageBox("LoadHelperInfo error");
        }
        imp->SetHelperObject(h);
    }

    // 这里把ObjImp的动画数据载入也放在LoadMesh中执行
    if( pInfo->anim_size > 0 )
    {
        imp->LoadAnimData( &pInfo->anim_data, tex_path, &res );
    }

    DR_SAFE_RELEASE( _obj_seq[ part_id ] );

    _obj_seq[ part_id ] = imp;


    _res_mgr->RegisterObject( &_id, this, OBJ_TYPE_CHARACTER );

    return DR_RET_OK;

}

DR_RESULT drPhysique::Update()
{
    DR_RESULT ret = DR_RET_FAILED;

    // update physique bone animation
    if( _anim_agent )
    {
        if(DR_FAILED(_anim_agent->Update()))
            goto __ret;

        drAnimCtrlObjTypeInfo type_info;
        type_info.type = ANIM_CTRL_TYPE_BONE;
        type_info.data[0] = DR_INVALID_INDEX;
        type_info.data[1] = DR_INVALID_INDEX;

        drIAnimCtrlObjBone* ctrl_obj = (drIAnimCtrlObjBone*)_anim_agent->GetAnimCtrlObj(&type_info);
        drIAnimCtrlBone* ctrl = (drIAnimCtrlBone*)ctrl_obj->GetAnimCtrl();


        if(DR_FAILED(ctrl_obj->UpdateObject(ctrl_obj, NULL)))
            goto __ret;

        drIPrimitive* pri;
        drIAnimCtrlObjBone* pri_ctrl;

        for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
        {
            if( (pri = _obj_seq[ i ]) == 0 )
                continue;

            pri_ctrl = (drIAnimCtrlObjBone*)pri->GetAnimAgent()->GetAnimCtrlObj(&type_info);

            if(pri_ctrl == 0)
            {
                drMessageBox("crash!!!, call jack");
                __asm int 3;
            }

            if(DR_FAILED(ctrl_obj->UpdateObject(pri_ctrl, pri->GetMeshAgent()->GetMesh())))
                goto __ret;
        }
    }    

    // update object
    drIPrimitive* imp;
    drIPrimitive* pp;

    for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if( (imp = _obj_seq[ i ]) == 0 )
            continue;


        // 有父子层次结构的矩阵连乘，以后可以改进
        drMatrix44 mat( _mat_base );
        pp = imp;
        while( pp->GetParentID() != DR_INVALID_INDEX )
        {
            if( _obj_seq[ pp->GetParentID() ] )
            {
                drMatrix44Multiply( &mat, _obj_seq[ pp->GetParentID() ]->GetMatrixLocal(), &mat );
                pp = _obj_seq[ pp->GetParentID() ];
            }
            else
            {
                break;
            }
        }

        imp->SetMatrixParent( &mat );

        imp->Update();
    }


    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drPhysique::Render()
{
    DR_RESULT ret = DR_RET_FAILED;

    if( _state_ctrl.GetState( STATE_VISIBLE ) == 0 )
        goto __addr_ret_ok;

    drIPrimitive* p;

	IDirect3DDeviceX* device = _res_mgr->GetDeviceObject()->GetDevice();
	device->SetRenderState( D3DRS_ZENABLE, D3DZB_TRUE );
	device->SetRenderState( D3DRS_ZWRITEENABLE, TRUE );
	device->SetTexture(1, 0);

    for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if((p = _obj_seq[i]) == 0)
            continue;

        if(_scene_mgr && p->GetState(STATE_TRANSPARENT))
        {
            if(DR_FAILED(_scene_mgr->AddTransparentPrimitive(p)))
                goto __ret;
        }
		else
		{
            /*---------------------------------------------------------------------------
              保存iter的方法，能省掉3次的查找，虽然这个变量大部分都没有用到。。。
            ---------------------------------------------------------------------------*/
			IndexColourFilterPairList::iterator it = mIndexColourFilterList.find( i );

			if( it != mIndexColourFilterList.end() )
			{
				IDirect3DDeviceX* device = _res_mgr->GetDeviceObject()->GetDevice();

				static IDirect3DTexture8* texture = 0;
				if( !texture )
				{
					texture = _res_mgr->getMonochromaticTexture( (*it).second.first, (*it).second.second );
				}
				device->SetTexture( 1, texture );
				device->SetTextureStageState( 1, D3DTSS_COLOROP, mIndexTextureOPList[ i ] );
				device->SetTextureStageState( 1, D3DTSS_COLORARG1, D3DTA_CURRENT );
				device->SetTextureStageState( 1, D3DTSS_COLORARG2, D3DTA_TEXTURE );

				device->SetTextureStageState( 1, D3DTSS_ALPHAOP, D3DTOP_MODULATE );
				device->SetTextureStageState( 1, D3DTSS_ALPHAARG1, D3DTA_CURRENT );
				device->SetTextureStageState( 1, D3DTSS_ALPHAARG2, D3DTA_TEXTURE );
			}


            if(DR_FAILED(p->Render()))
                goto __ret;

			if( it != mIndexColourFilterList.end() )
			{
				IDirect3DDevice8* device = _res_mgr->GetDeviceObject()->GetDevice();
				device->SetTexture( 1, 0 );
				device->SetTextureStageState( 1, D3DTSS_TEXCOORDINDEX, 1 );
				device->SetTextureStageState( 1, D3DTSS_COLOROP, D3DTOP_DISABLE );
				device->SetTextureStageState( 1, D3DTSS_COLORARG1, D3DTOP_DISABLE );
				device->SetTextureStageState( 1, D3DTSS_COLORARG2, D3DTOP_DISABLE );

				device->SetTextureStageState( 1, D3DTSS_ALPHAARG1, D3DTOP_DISABLE );
				device->SetTextureStageState( 1, D3DTSS_ALPHAARG2, D3DTOP_DISABLE );
				device->SetTextureStageState( 1, D3DTSS_ALPHAOP, D3DTOP_DISABLE );
			}
        }
    }

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drPhysique::HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    drIPrimitive* imp_generic;

    drPickInfo x, xx;
    DWORD obj_id = DR_INVALID_INDEX;

    for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if( (imp_generic = _obj_seq[ i ]) == 0 )
            continue;

        if( DR_SUCCEEDED( imp_generic->HitTest( &x, org, ray ) ) )
        {
            if( (obj_id == DR_INVALID_INDEX) || (xx.dis > x.dis) )
            {
                xx = x;
                obj_id = i;
            }
        }
    }

    if( obj_id == DR_INVALID_INDEX )
    {
        return DR_RET_FAILED;
    }
    else
    {
        *info = xx;
        info->obj_id = obj_id;
        
        return DR_RET_OK;
    }
}
DR_RESULT drPhysique::HitTestPhysique( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    return DR_RET_FAILED;
}

void drPhysique::ShowHelperObject( int show )
{
    drIHelperObject* helper_obj;

    for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if( _obj_seq[ i ] == 0 )
            continue;

        if((helper_obj = _obj_seq[i]->GetHelperObject()) != 0)
        {
            helper_obj->SetVisible(show);
        }
    }

}
void drPhysique::ShowBoundingObjectPhysique( int show )
{
}

DR_RESULT drPhysique::SetItemLink( const drItemLinkInfo* info )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( _anim_agent == NULL )
        goto __ret;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObjBone* ctrl_obj = (drIAnimCtrlObjBone*)_anim_agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == NULL)
        goto __ret;

    drIAnimCtrlBone* ctrl_bone = (drIAnimCtrlBone*)ctrl_obj->GetAnimCtrl();

    if( ctrl_bone == NULL  )
        goto __ret;

    if( ctrl_bone->GetDummyRTM( info->link_parent_id ) == NULL )
        goto __ret;

    if( info->obj->GetPrimitive() == 0 )
        goto __ret;

    ret = info->obj->SetLinkCtrl( this, info->link_parent_id, info->link_item_id );

__ret:
    return ret;
}

DR_RESULT drPhysique::ClearItemLink( drIItem* obj )
{
    return obj->ClearLinkCtrl();
}

void drPhysique::SetOpacity(float opacity)
{
    _opacity = opacity;

    for(DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++)
    {
        if(_obj_seq[i] == 0)
            continue;

        _obj_seq[i]->SetOpacity(opacity);
    }

}
DR_RESULT drPhysique::SetTextureLOD(DWORD level)
{
    for( DWORD i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if(_obj_seq[i] == 0)
            continue;

        _obj_seq[i]->SetTextureLOD(level);
    }

    return DR_RET_OK;
}

DR_END
