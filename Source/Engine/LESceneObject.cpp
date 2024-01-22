//

#include "LightEngineAPI.h"
#include "LESceneObject.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drInterface.h"
#include "drGraphicsUtil.h"
#include <CPerformance.h>
extern LIGHTENGINE_API int g_nTemp;
DR_BEGIN

LESceneObject::LESceneObject( drISysGraphics* sys_graphics )
:_model(0)
{
    sys_graphics->GetResourceMgr()->CreateModel( &_model );

    BindMatrix( _model->GetMatrix() );
}

LESceneObject::LESceneObject()
:_model(0)
{
    drSysGraphics::GetActiveIGraphicsSystem()->GetResourceMgr()->CreateModel( &_model );

    BindMatrix( _model->GetMatrix() );
}

LESceneObject::~LESceneObject()
{
	if( _model )
	{
		for(vector<LESceneItem*>::iterator it = _link_item_seq.begin(); it!=_link_item_seq.end(); it++)
			_model->ClearItemLink( (*it)->GetObject() );
		_model->Release();
		_model = NULL;
	}
	_link_item_seq.clear();
}


void LESceneObject::FrameMove()
{
	if( _model )
    _model->Update();
}

void LESceneObject::Render()
{
	if( _model )
		_model->Render();
}

DR_RESULT LESceneObject::Load( const char* file, DWORD model_id )
{
    DR_RESULT ret;
    if( DR_FAILED(ret = _model->Load(file, model_id)))
    {
        drMessageBox("Load LESceneObject %s error", file);
    }

    return ret;
}

void LESceneObject::SetMaterial( const D3DMATERIALX* mtl )
{
	if( _model )
    _model->SetMaterial( (drMaterial*)mtl );
}

void LESceneObject::Destroy()
{
	if( _model )
    _model->Destroy();
}

DR_RESULT LESceneObject::PlayObjImpPose( DWORD obj_id, DWORD ctrl_type, DWORD pose_id, DWORD play_type, float start_frame, float velocity )
{
    drPlayPoseInfo info;
    memset( &info, 0, sizeof( info ) );
    info.bit_mask = PPI_MASK_DEFAULT;

    info.velocity = velocity;
    info.pose = pose_id;
    info.frame = start_frame;
    info.type = play_type;

    drIPrimitive* p = _model->GetPrimitive( obj_id );
    if( p == NULL )
        return DR_RET_FAILED;

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    drIAnimCtrlObj* ctrl_obj = NULL;

    DR_RESULT ret = DR_RET_FAILED;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    switch( ctrl_type )
    {
    case ANIM_CTRL_TYPE_MAT:
        ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);
        break;
    case ANIM_CTRL_TYPE_BONE:
        ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);
        break;
    case ANIM_CTRL_TYPE_TEXUV:
        type_info.data[0] = 0;
        type_info.data[1] = 0;
        ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);
        break;
    case ANIM_CTRL_TYPE_TEXIMG:
        break;
    }

    if(ctrl_obj)
    {
        return ctrl_obj->PlayPose(&info);
    }

    return DR_INVALID_INDEX;
}

DR_RESULT LESceneObject::PlayDefaultAnimation()
{
	if( _model )
    return _model->PlayDefaultAnimation();
	return 0;
}


DR_RESULT LESceneObject::HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
	if( _model )
    return _model->HitTestPrimitive( info, org, ray );
	return 0;
}
DR_RESULT LESceneObject::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
	if( _model )
    return _model->HitTest( info, org, ray );
	return 0;
}
DR_RESULT LESceneObject::HitTestHelperMesh( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name )
{
	if( _model )
    return _model->HitTestHelperMesh( info, org, ray, type_name );
	return 0;
}

DR_RESULT LESceneObject::HitTestHelperBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name )
{
	if( _model )
    return _model->HitTestHelperBox( info, org, ray, type_name );
	return 0;
}
DR_RESULT LESceneObject::HitTestPrimitiveHelperMesh( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name )
{
	if( _model )
    return _model->HitTestPrimitiveHelperMesh( info, org, ray, type_name );
	return 0;
}
DR_RESULT LESceneObject::HitTestPrimitiveHelperBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name )
{
	if( _model )
    return _model->HitTestPrimitiveHelperBox( info, org, ray, type_name );
	return 0;
}


drIPrimitive* LESceneObject::GetPrimitive( DWORD id )
{
	if( _model )
    return _model->GetPrimitive( id );
	return 0;
}

void LESceneObject::ShowHelperObject( int show )
{
	if( _model )
    _model->ShowHelperObject( show );
}
void LESceneObject::ShowHelperMesh( int show )
{
	if( _model )
    _model->ShowHelperMesh( show );
}
void LESceneObject::ShowHelperBox( int show )
{
	if( _model )
    _model->ShowHelperBox( show );
}
void LESceneObject::ShowBoundingObject( int show )
{
	if( _model )
    _model->ShowBoundingObject( show );
}

void LESceneObject::SetObjState( DWORD state, BYTE value )
{
	if( _model )
    _model->SetObjState( state, value );
}
DWORD LESceneObject::GetObjState( DWORD state ) const
{
	if( _model )
    return _model->GetObjState( state );
	return 0;
}

drVector3 LESceneObject::GetObjectSize()
{
	if( _model )
	{
		drVector3	vModelSizeMin( 0.0f, 0.0f, 0.0f );
		drVector3	vModelSizeMax( 0.0f, 0.0f, 0.0f );
		for ( DWORD i = 0; i < _model->GetPrimitiveNum(); i++ )
		{
			drVector3*	_seq = _model->GetPrimitive(i)->GetMeshAgent()->GetMesh()->GetMeshInfo()->vertex_seq;
			if ( _seq->x < vModelSizeMin.x )
			{
				vModelSizeMin.x = _seq->x;
			}
			if ( _seq->x > vModelSizeMax.x )
			{
				vModelSizeMax.x = _seq->x;
			}
			if ( _seq->y < vModelSizeMin.y )
			{
				vModelSizeMin.y = _seq->y;
			}
			if ( _seq->y > vModelSizeMax.y )
			{
				vModelSizeMax.y = _seq->y;
			}
			if ( _seq->z < vModelSizeMin.z )
			{
				vModelSizeMin.z = _seq->z;
			}
			if ( _seq->z > vModelSizeMax.z )
			{
				vModelSizeMax.z = _seq->z;
			}
		}
		return drVector3( vModelSizeMax.x - vModelSizeMin.x, vModelSizeMax.y - vModelSizeMin.y, vModelSizeMax.z - vModelSizeMin.z );
	}
	return 0;
}

DR_RESULT LESceneObject::SetItemLink( const drSceneItemLinkInfo* info )
{
    if( _link_item_seq.size() >= DR_MAX_LINK_ITEM_NUM )
        return DR_RET_FAILED;

    drItemLinkInfo ili;
    ili.id = info->id;
    ili.obj = info->obj->GetObject();
    ili.link_item_id = info->link_item_id;
    ili.link_parent_id = info->link_parent_id;

    if( DR_FAILED( _model->SetItemLink( &ili ) ) )
        return DR_RET_FAILED;

	_link_item_seq.push_back(info->obj);
	//IP("LESceneObject(%x)::link=%d\n",  (DWORD)this, _link_item_seq.size());

    return DR_RET_OK;
}

DR_RESULT LESceneObject::UnwieldItem( const LESceneItem* obj )
{
	for(vector<LESceneItem*>::iterator it = _link_item_seq.begin(); it!=_link_item_seq.end();)
	{
		if( (*it)==obj )
		{
			_model->ClearItemLink( (*it)->GetObject() );
			_link_item_seq.erase(it);
			return DR_RET_OK;
		}
		else
			it++;
	}
    return DR_RET_FAILED;
}

LESceneItem* LESceneObject::GetLinkItem( DWORD id )
{
    if( id < 0 || id >= _link_item_seq.size() )
        return NULL;

    return _link_item_seq[ id ];
}

DWORD LESceneObject::GetPrimitiveNum() const
{
    return _model->GetPrimitiveNum();
}
int LESceneObject::GetPrimitiveBox( DWORD id, D3DXVECTOR3* p1, D3DXVECTOR3* p2 )
{
    drIPrimitive* p = _model->GetPrimitive( id );
    if( p == NULL )
        return 0;
   
    drIHelperObject* h = p->GetHelperObject();
    drIBoundingBox* b = h->GetBoundingBox();
    if( b == NULL )
        return 0;

    drBoundingBoxInfo* bbi = b->GetDataInfo( 0 );
    if( bbi == NULL )
        return 0;

    drMatrix44 mat;
    drMatrix44Multiply( &mat, &bbi->mat, p->GetMatrixGlobal() );
    drVector3 x1 = bbi->box.c - bbi->box.r;
    drVector3 x2 = bbi->box.c + bbi->box.r;
    drVec3Mat44Mul( &x1, &mat );
    drVec3Mat44Mul( &x2, &mat );

    *p1 = *(D3DXVECTOR3*)&x1;
    *p2 = *(D3DXVECTOR3*)&x2;

    return 1;
}
void LESceneObject::SetOpacity(float opacity)
{
	if( _model )
		_model->SetOpacity(opacity);
}

void LESceneObject::SetTextureLOD(DWORD level)
{
	if( _model )
		_model->SetTextureLOD(level);
}
float LESceneObject::GetOpacity()
{
	if( _model )
		return _model->GetOpacity();
	return 1.0f;
}
DWORD LESceneObject::GetTransparentFlag() const
{
    DWORD pri_num = _model->GetPrimitiveNum();
    for(DWORD i = 0; i < pri_num; i++)
    {
		if( _model )
        if(_model->GetPrimitive(i)->GetState(STATE_TRANSPARENT))
            return 1;
    }

    return 0;
}

// drSceneObjectChair
DR_FRONT_API DR_RESULT drLoadPrimitiveLineList( drIPrimitive* obj, const char* name, DWORD vert_num, const drVector3* vert_buf, const DWORD* color_buf );

drSceneObjectChair::drSceneObjectChair()
: _obj( 0 )
{
    BindMatrix( &_mat );
}

drSceneObjectChair::~drSceneObjectChair()
{
    DR_SAFE_DELETE( _obj );
}

DR_RESULT drSceneObjectChair::Create()
{
    drMatrix44Identity( &_mat );

    _box.c = drVector3( 0.0f, 0.0f, 0.0f );
    _box.r = drVector3( 0.5f, 0.5f, 0.5f );

    drSysGraphics::GetActiveIGraphicsSystem()->GetResourceMgr()->CreatePrimitive( &_obj );

    const DWORD vert_num = 24 + 6;
    drVector3 vert_buf[ vert_num ];
    drGetBoxVertLineList( vert_buf, &_box );

    DWORD c = 0xff00ffff;
    DWORD color_buf[ vert_num  ];
    for( DWORD i = 0; i < 24; i++ )
    {
        color_buf[ i ] = c;
    }

    // axis
    const float len = 1.0f;
    drVector3 ver_buf[ 6 ] = 
    {
		drVector3( 0.0f, 0.0f, 0.0f ),
		drVector3(  len, 0.0f, 0.0f ),
		drVector3( 0.0f, 0.0f, 0.0f ),
		drVector3( 0.0f,  len, 0.0f ),
		drVector3( 0.0f, 0.0f, 0.0f ),
		drVector3( 0.0f, 0.0f,  len )
	};

    memcpy( &vert_buf[ 24 ], &ver_buf[ 0 ], sizeof( drVector3 ) * 6 );

    DWORD* color_axis = &color_buf[ 24 ];
    color_axis[ 0 ] = color_axis[ 1 ] = 0xffff0000;
    color_axis[ 2 ] = color_axis[ 3 ] = 0xff00ff00;
    color_axis[ 4 ] = color_axis[ 5 ] = 0xff0000ff;
    

    drLoadPrimitiveLineList( _obj, "ChairBox", vert_num, vert_buf, color_buf );

    return DR_RET_OK;
}

DR_RESULT drSceneObjectChair::Render()
{
    if( _obj )
    {
        _obj->SetMatrixParent( &_mat );
        _obj->Render();
    }

    return DR_RET_OK;
}

DR_RESULT drSceneObjectChair::HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    return drHitTestBox( info, org, ray, &_box, &_mat );
}


DR_END