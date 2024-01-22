//


#include "LECharacter.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drInterface.h"
#include "drExpObj.h"
#include "drIUtil.h"
#include "drgraphicsutil.h"
#include "drPhysique.h"
#include <CPerformance.h>
DR_BEGIN


LECharacter::LECharacter( drISysGraphics* sys_graphics )
: _pose_proc( 0 ), _proc_param( 0 )
{
    sys_graphics->GetResourceMgr()->CreatePhysique( &_physique );

    BindMatrix( _physique->GetMatrix() );
}

LECharacter::LECharacter()
: _pose_proc( 0 ), _proc_param( 0 )
{
    drSysGraphics::GetActiveIGraphicsSystem()->GetResourceMgr()->CreatePhysique( &_physique );

    BindMatrix( _physique->GetMatrix() );
}

LECharacter::~LECharacter()
{
    Destroy();
    _physique->Release();
}

void LECharacter::Destroy()
{
    _physique->Destroy();
    //DR_SAFE_DELETE( _weapon );

	for(vector<LELinkInfo>::iterator it=_link_item_seq.begin(); it!=_link_item_seq.end(); it++)
    {
        if( (*it).obj )
            (*it).obj->GetObject()->ClearLinkCtrl();
    }
	_link_item_seq.clear();
}

DR_RESULT LECharacter::PlayPose( const drPlayPoseInfo* info )
{
	if( !_physique->isLoaded() ) return 0;
    drIAnimCtrlAgent* agent = _physique->GetAnimCtrlAgent();
    if( agent == NULL )
        return DR_RET_FAILED;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObj* ctrl_obj = agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == NULL)
        return DR_RET_FAILED;

    return ctrl_obj->PlayPose(info );
}

DR_RESULT LECharacter::PlayPose( DWORD pose_id, DWORD play_type, float start_frame, float velocity, DWORD blend_flag, DWORD blend_src_num )
{
    drPlayPoseInfo info;
    memset( &info, 0, sizeof( info ) );
    info.bit_mask = PPI_MASK_DEFAULT;
    if(blend_flag == 1)
    {
        info.bit_mask |= (PPI_MASK_BLENDINFO |PPI_MASK_BLENDINFO_SRCFRAMENUM);
        info.blend_info.src_frame_num = (float)blend_src_num;
    }

    info.pose = pose_id;
    info.frame = start_frame;
    info.velocity = velocity;
    info.type = play_type;

    return PlayPose( &info );
}

DR_RESULT LECharacter::PlayObjImpPose( DWORD obj_id, DWORD ctrl_type, const drPlayPoseInfo* info )
{
	if( !_physique->isLoaded() ) return 0;
    drIPrimitive* p = _physique->GetPrimitive( obj_id );
    if( p == NULL )
        return DR_RET_FAILED;

    drIAnimCtrlAgent* agent = p->GetAnimAgent();
    if(agent == NULL)
        return DR_RET_FAILED;

    DWORD subset;
    DWORD stage;
    
    switch(ctrl_type)
    {
    case ANIM_CTRL_TYPE_MAT:
        subset = DR_INVALID_INDEX;
        stage = DR_INVALID_INDEX;
        break;
    case ANIM_CTRL_TYPE_BONE:
        subset = DR_INVALID_INDEX;
        stage = DR_INVALID_INDEX;
        break;
    case ANIM_CTRL_TYPE_TEXUV:
        subset = 0;
        stage = 0;
        break;
    }

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = subset;
    type_info.data[1] = stage;

    drIAnimCtrlObj* ctrl_obj = agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == NULL)
        return DR_RET_FAILED;

    return ctrl_obj->PlayPose(info);

}


DR_RESULT LECharacter::PlayObjImpPose( DWORD obj_id, DWORD ctrl_type, DWORD pose_id, DWORD play_type, float start_frame, float velocity )
{
    drPlayPoseInfo info;
    memset( &info, 0, sizeof( info ) );
    info.bit_mask = PPI_MASK_DEFAULT;

    info.pose = pose_id;
    info.frame = start_frame;
    info.velocity = velocity;
    info.type = play_type;

    return PlayObjImpPose( obj_id, ctrl_type, &info );
}

DR_RESULT LECharacter::SetPoseKeyFrameProc( drPoseKeyFrameProc proc, void* proc_param )
{
    drPlayPoseInfo info;
    info.bit_mask = PPI_MASK_PROC;
    info.proc = proc;
    info.proc_param = proc_param;

    _pose_proc = proc;
    _proc_param = proc_param;

    return PlayPose( &info );
}

DR_RESULT LECharacter::SetObjImpPoseKeyFrameProc( DWORD obj_id, DWORD ctrl_type, drPoseKeyFrameProc proc, void* proc_param )
{
    drPlayPoseInfo info;
    info.bit_mask = PPI_MASK_PROC;
    info.proc = proc;
    info.proc_param = proc_param;

    return PlayObjImpPose( obj_id, ctrl_type, &info );
}

void LECharacter::FrameMove()
{
	if( _physique->isLoaded() )
	{
		_physique->Update();
	}
}

void LECharacter::Render()
{
	if( _physique->isLoaded() )
	{
		_physique->Render();
	}

}

DR_RESULT LECharacter::Load( const LEChaLoadInfo* info )
{
    DR_RESULT ret = DR_RET_FAILED;

    if( strlen( info->bone ) > 0 )
    {
        if( DR_FAILED( _physique->LoadBone( info->bone ) ) )
            goto __ret;
    }
  

    for( int i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if( strlen( info->part[i] ) == 0 )
            continue;

        if( DR_FAILED( LoadPart( i, info->part[i] ) ) )
            goto __ret;
    }
    ret = DR_RET_OK;

__ret:
    return ret;

}


DR_RESULT LECharacter::Load( DWORD obj_id, DWORD group_id, DWORD* skin_id_seq, int load_bone )
{
    DR_RESULT ret = DR_RET_FAILED;

    
    if( load_bone == 1 )
    {
        char path_bone[ DR_MAX_PATH ];
        _snprintf_s( path_bone,DR_MAX_PATH, _TRUNCATE,"%04d.lab", obj_id );

        if( DR_FAILED( _physique->LoadBone( path_bone ) ) )
            goto __ret;
    }
 
    DWORD file_id;

    for( int i = 0; i < DR_MAX_SUBSKIN_NUM; i++ )
    {
        if( skin_id_seq[ i ] == 0 )
            continue;

        file_id = obj_id * 1000000 + group_id * 10000 + i;

        if( DR_FAILED( LoadPart( i, file_id ) ) )
            goto __ret;
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}
void LECharacter::StartLoad()
{
	_physique->Start();
}

void LECharacter::EndLoad()
{
	_physique->End();
}
	
bool LECharacter::IsLoaded()
{
	return _physique->isLoaded();
}

extern drGeomManager g_GeomManager;

BOOL LECharacter::InitBone( const char* file )
{
	g_GeomManager.LoadBoneData( file );
	return TRUE;
}

DR_RESULT LECharacter::LoadBone( const char* file )
{
    return _physique->LoadBone( file );
}

DR_RESULT LECharacter::LoadPart( DWORD part_id, DWORD file_id )
{
    DR_RESULT ret = DR_RET_OK;

    char path_mesh[ DR_MAX_NAME ];
    _snprintf_s( path_mesh, DR_MAX_NAME, _TRUNCATE,"%010d.lgo", file_id );

    
    if( DR_SUCCEEDED( ret = _physique->CheckPrimitive( part_id ) ) )
    {
        if( DR_FAILED( ret = _physique->DestroyPrimitive( part_id ) ) )
            goto __ret;
    }

    if( DR_FAILED( ret = _physique->LoadPrimitive( part_id, path_mesh ) ) )
    {
        drMessageBox("Load LECharacter %s error", path_mesh);
        goto __ret;
    }

    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT LECharacter::LoadPart( DWORD part_id, const char* file )
{
    DR_RESULT ret = DR_RET_OK;
    
    if( DR_SUCCEEDED( ret = _physique->CheckPrimitive( part_id ) ) )
    {
        if( DR_FAILED( ret = _physique->DestroyPrimitive( part_id ) ) )
            goto __ret;
    }

    if( DR_FAILED( ret = _physique->LoadPrimitive( part_id, file ) ) )
    {
        drMessageBox("Load LECharacter %s error", file);
        goto __ret;
    }

    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT LECharacter::DestroyPart( DWORD part_id )
{
    DR_RESULT ret = DR_RET_OK;

    if( DR_SUCCEEDED( ret = _physique->CheckPrimitive( part_id ) ) )
    {
        if( DR_FAILED( ret = _physique->DestroyPrimitive( part_id ) ) )
            goto __ret;
    }
    ret = DR_RET_OK;

__ret:
    return ret;

}


drIPoseCtrl* LECharacter::GetPoseCtrl()
{	
    drIPoseCtrl* ret = NULL;
	if( !_physique->isLoaded() ) goto __ret;
    drIAnimCtrlAgent* anim_agent = _physique->GetAnimCtrlAgent();
    if(anim_agent == NULL)
        goto __ret;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;


    drIAnimCtrlObjBone* ctrl_obj = (drIAnimCtrlObjBone*)anim_agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj == NULL)
        goto __ret;

    ret = ctrl_obj->GetAnimCtrl()->GetPoseCtrl();

__ret:
    return ret;  
}
drIPoseCtrl* LECharacter::GetObjImpPoseCtrl( DWORD skin_id, DWORD ctrl_type )
{
    drIPrimitive* p = _physique->GetPrimitive( skin_id );
    if( p == NULL )
        return NULL;

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;

    switch(ctrl_type)
    {
    case ANIM_CTRL_TYPE_MAT:
        {
            type_info.data[0] = DR_INVALID_INDEX;
            type_info.data[1] = DR_INVALID_INDEX;
            drIAnimCtrlObjMat* ctrl_obj = (drIAnimCtrlObjMat*)anim_agent->GetAnimCtrlObj(&type_info);
            if(ctrl_obj == NULL)
                return NULL;

            return ctrl_obj->GetAnimCtrl()->GetPoseCtrl();
        }
        break;
    case ANIM_CTRL_TYPE_BONE:
        {
            type_info.data[0] = DR_INVALID_INDEX;
            type_info.data[1] = DR_INVALID_INDEX;
            drIAnimCtrlObjBone* ctrl_obj = (drIAnimCtrlObjBone*)anim_agent->GetAnimCtrlObj(&type_info);
            if(ctrl_obj == NULL)
                return NULL;

            return ctrl_obj->GetAnimCtrl()->GetPoseCtrl();
        }
        break;
    case ANIM_CTRL_TYPE_TEXUV:
        {
            type_info.data[0] = 0;
            type_info.data[1] = 0;
            drIAnimCtrlObjTexUV* ctrl_obj = (drIAnimCtrlObjTexUV*)anim_agent->GetAnimCtrlObj(&type_info);
            if(ctrl_obj == NULL)
                return NULL;

            return ctrl_obj->GetAnimCtrl()->GetPoseCtrl();
        }
        break;
    }


    return 0;
}

drPlayPoseInfo* LECharacter::GetPlayPoseInfo()
{
    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIAnimCtrlObj* ctrl_obj = _physique->GetAnimCtrlAgent()->GetAnimCtrlObj(&type_info);
    return ctrl_obj->GetPlayPoseInfo();
}

drPlayPoseInfo* LECharacter::GetObjImpPlayPoseInfo( DWORD obj_id, DWORD ctrl_type )
{
    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    drIPrimitive* p = _physique->GetPrimitive(obj_id);
    drIAnimCtrlObj* ctrl_obj = p->GetAnimAgent()->GetAnimCtrlObj(&type_info);
    return ctrl_obj->GetPlayPoseInfo();
}

DR_RESULT LECharacter::HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    return _physique->HitTestPrimitive( info, org, ray );
}
DR_RESULT LECharacter::HitTestPhysique( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    return _physique->HitTestPhysique( info, org, ray );
}

void LECharacter::ShowHelperObject( int show )
{
    _physique->ShowHelperObject( show );
}
void LECharacter::ShowBoundingObjectPhysique( int show )
{
    _physique->ShowBoundingObjectPhysique( show );
}
DR_RESULT LECharacter::AttachItem( const LEItemLinkInfo* info )
{
    drItemLinkInfo ili;
    ili.id = 0;
    ili.obj = info->obj->GetObject();
    ili.link_item_id = info->link_item_id;
    ili.link_parent_id = info->link_parent_id;

    if( info->data == -1 )
    {
        if( DR_FAILED( _physique->SetItemLink( &ili ) ) )
            return DR_RET_FAILED;
    }
    else
    {
        assert(0);
        // 以下接口可能需要修改
        //drIPrimitive* p = _physique->GetPrimitive( info->data );
        //if( p == NULL )
        //    return DR_RET_FAILED;

        //if( DR_FAILED( p->SetItemLink( &ili ) ) )
        //    return DR_RET_FAILED;

    }

    return DR_RET_OK;

}

DR_RESULT LECharacter::SetItemLink( const drSceneItemLinkInfo* info )
{
    if( _link_item_seq.size() >= DR_MAX_LINK_ITEM_NUM )
        return DR_RET_FAILED;

    drItemLinkInfo ili;
    ili.id = info->id;
    ili.obj = info->obj->GetObject();
    ili.link_item_id = info->link_item_id;
    ili.link_parent_id = info->link_parent_id;

    if( DR_FAILED( _physique->SetItemLink( &ili ) ) )
        return DR_RET_FAILED;

	LELinkInfo New;
	New.obj = info->obj;
	New.data = info->data;
    _link_item_seq.push_back(New);
	//IP("LECharacter(%x)::link=%d\n",  (DWORD)this, _link_item_seq.size());

    return DR_RET_OK;
}

DR_RESULT LECharacter::UnwieldItem( const LESceneItem* obj )
{
	for(vector<LELinkInfo>::iterator it=_link_item_seq.begin(); it!=_link_item_seq.end();it++)
    {
		if( (*it).obj == obj )
        {
            (*it).obj->GetObject()->ClearLinkCtrl();
            _link_item_seq.erase(it);
            return DR_RET_OK;
        }
    }

    return DR_RET_FAILED;
}
DR_RESULT LECharacter::SetSubObjItemLink( DWORD obj_id, const drSceneItemLinkInfo* info )
{
    if( _link_item_seq.size() >= DR_MAX_LINK_ITEM_NUM )
        return DR_RET_FAILED;

    assert(0);

    //drItemLinkInfo ili;
    //ili.id = info->id;
    //ili.obj = info->obj->GetObject();
    //ili.link_item_id = info->link_item_id;
    //ili.link_parent_id = info->link_parent_id;

    //drIPrimitive* p = _physique->GetPrimitive( obj_id );
    //if( p == NULL )
    //    return DR_RET_FAILED;

    //if( DR_FAILED( p->SetItemLink( &ili ) ) )
    //    return DR_RET_FAILED;

// 	LELinkInfo New;
// 	New.obj = info->obj;
// 	New.data = info->data;
// 	_link_item_seq.push_back(New);
// 	IP("%x link=%d\n",  (DWORD)this, _link_item_seq.size());
	return DR_RET_OK;
}

DR_RESULT LECharacter::ClearItemLink( DWORD type )
{
	for(vector<LELinkInfo>::iterator it=_link_item_seq.begin(); it!=_link_item_seq.end();)
	{
		if( (*it).data == type )
			_link_item_seq.erase(it);
		else
			it++;
	}
    return DR_RET_OK;
}

DWORD LECharacter::CheckPosePlayingStatus()
{
    const drIPoseCtrl* ctrl = GetPoseCtrl();

    if( ctrl == 0 )
    {
        // no bone pose ctrl, we return 0;
        return 0;
    }

    return ctrl->IsPosePlaying( GetPlayPoseInfo() );
}

LESceneItem* LECharacter::GetLinkItem( DWORD id )
{
    if( id < 0 || id >= _link_item_seq.size() )
        return NULL;

    return _link_item_seq[ id ].obj;
}

void LECharacter::SetObjState( DWORD state, BYTE value )
{
    _physique->SetObjState( state, value );
}
DWORD LECharacter::GetObjState( DWORD state ) const
{
    return _physique->GetObjState( state );
}

DR_RESULT LECharacter::GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD obj_id, DWORD dummy_id )
{
    DR_RESULT ret = DR_RET_FAILED;

    drIPrimitive* p = _physique->GetPrimitive( obj_id );   
    if(p == NULL)
        goto __ret;

    drIHelperObject* h = p->GetHelperObject();
    if(h == 0)
        goto __ret;

    drIHelperDummy* dummy = h->GetHelperDummy();
    if( dummy == NULL )
        goto __ret;

    drHelperDummyInfo* dummy_info = dummy->GetDataInfoWithID( dummy_id );

    if( dummy_info == NULL )
        goto __ret;

    drMatrix44Multiply( mat, &dummy_info->mat, dummy->GetMatrixParent() );

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT LECharacter::GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD dummy_id )
{
    DR_RESULT ret = DR_RET_FAILED;

    drIAnimCtrlAgent* anim_agent = _physique->GetAnimCtrlAgent();
    if(anim_agent == 0)
        goto __ret;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ANIM_CTRL_TYPE_BONE;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;


    drIAnimCtrlObjBone* ctrl_obj_bone = (drIAnimCtrlObjBone*)anim_agent->GetAnimCtrlObj(&type_info);
    if(ctrl_obj_bone == 0)
        goto __ret;
    
    drMatrix44* m = ctrl_obj_bone->GetDummyRTM(dummy_id);

    if( m == NULL )
        return DR_RET_FAILED;

    drMatrix44Multiply( mat, m, _mat_ptr );
    //*mat = *m;

    ret = DR_RET_OK;

__ret:
    return ret;
}

void LECharacter::SetMaterial(const D3DMATERIALX* mtl)
{
    drPhysiqueSetMaterial(_physique, (drMaterial*)mtl);
}
void LECharacter::SetOpacity(float opacity)
{
    _physique->SetOpacity(opacity);
}
void LECharacter::SetTextureLOD(DWORD level)
{
    _physique->SetTextureLOD(level);
}
float LECharacter::GetOpacity()
{
    return _physique->GetOpacity();
}

DR_END
