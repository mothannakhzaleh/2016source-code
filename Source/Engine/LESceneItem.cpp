//


#include "LESceneItem.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drInterface.h"
#include "drGraphicsUtil.h"


DR_BEGIN

LESceneItem::LESceneItem( drISysGraphics* sys_graphics )
{
    sys_graphics->GetResourceMgr()->CreateItem( &_obj );

    BindMatrix( _obj->GetMatrix() );
}

LESceneItem::LESceneItem()
{
    drSysGraphics::GetActiveIGraphicsSystem()->GetResourceMgr()->CreateItem( &_obj );

    BindMatrix( _obj->GetMatrix() );
}

LESceneItem::~LESceneItem()
{
    _obj->Release();
}


void LESceneItem::FrameMove()
{
    _obj->Update();
}

void LESceneItem::Render()
{
    _obj->Render();

}

DR_RESULT LESceneItem::Load( const char* file, int arbitrary_flag )
{
    DR_RESULT ret;
    if( DR_FAILED( ret = _obj->Load( file, arbitrary_flag ) ) )
    {
        drMessageBox("Load LESceneItem %s error", file);
    }

    return ret;
}

void LESceneItem::SetMaterial( const D3DMATERIALX* mtl )
{
    _obj->SetMaterial( (drMaterial*)mtl );
}
void LESceneItem::SetOpacity(float opacity)
{
    _obj->SetOpacity(opacity);
}
float LESceneItem::GetOpacity()
{
    return _obj->GetOpacity();
}
DR_RESULT LESceneItem::Copy(const LESceneItem* obj)
{
    DR_RESULT ret = DR_RET_FAILED;
    drIItem* item = 0;

    DR_FAILED_RET(obj->_obj->Clone(&item));
    _obj = item;
    BindMatrix( _obj->GetMatrix() );

    ret = DR_RET_OK;
__ret:
    return ret;
}
void LESceneItem::Destroy()
{
    _obj->Destroy();
}

DR_RESULT LESceneItem::PlayObjImpPose( DWORD ctrl_type, DWORD pose_id, DWORD play_type, float start_frame, float velocity )
{
    DR_RESULT ret = DR_RET_FAILED;

    drPlayPoseInfo info;
    memset( &info, 0, sizeof( info ) );
    info.bit_mask = PPI_MASK_DEFAULT;

    info.velocity = velocity;
    info.pose = pose_id;
    info.frame = start_frame;
    info.type = play_type;

    drIPrimitive* p = _obj->GetPrimitive();
    if( p == NULL )
        goto __ret;

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    if(anim_agent == 0)
        goto __ret;

    drIAnimCtrlObj* ctrl_obj = NULL;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;
    type_info.data[0] = DR_INVALID_INDEX;
    type_info.data[1] = DR_INVALID_INDEX;

    switch( ctrl_type )
    {
    case ANIM_CTRL_TYPE_MAT:
        break;
    case ANIM_CTRL_TYPE_BONE:
        break;
    case ANIM_CTRL_TYPE_TEXUV:
    type_info.data[0] = 0;
    type_info.data[1] = 0;
        break;
    case ANIM_CTRL_TYPE_TEXIMG:
        break;
    }

    ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);

    if(ctrl_obj == 0)
        goto __ret;
  
    if(DR_FAILED(ctrl_obj->PlayPose(&info)))
        goto __ret;    

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT LESceneItem::HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray )
{
    return _obj->HitTestPrimitive( info, org, ray );
}

drIPoseCtrl* LESceneItem::GetObjImpPoseCtrl( DWORD ctrl_type )
{
    drIPrimitive* p = _obj->GetPrimitive();
    if( p == NULL )
        return NULL;

    drIAnimCtrlAgent* anim_agent = p->GetAnimAgent();
    drIAnimCtrlObj* ctrl_obj = NULL;

    drAnimCtrlObjTypeInfo type_info;
    type_info.type = ctrl_type;

    switch( ctrl_type )
    {
    case ANIM_CTRL_TYPE_MAT:
    case ANIM_CTRL_TYPE_BONE:
        type_info.data[0] = DR_INVALID_INDEX;
        type_info.data[1] = DR_INVALID_INDEX;
        break;
    case ANIM_CTRL_TYPE_TEXUV:
    case ANIM_CTRL_TYPE_TEXIMG:
        type_info.data[0] = 0;
        type_info.data[1] = 0;
        break;
    }

    ctrl_obj = anim_agent->GetAnimCtrlObj(&type_info);

    if(ctrl_obj == NULL)
        return NULL;

    drIAnimCtrl* c = 0;

    switch( ctrl_type )
    {
    case ANIM_CTRL_TYPE_MAT:
        c = ((drIAnimCtrlObjMat*)ctrl_obj)->GetAnimCtrl();
        break;
    case ANIM_CTRL_TYPE_BONE:
        c = ((drIAnimCtrlObjBone*)ctrl_obj)->GetAnimCtrl();
        break;
    case ANIM_CTRL_TYPE_TEXUV:
        c = ((drIAnimCtrlObjTexUV*)ctrl_obj)->GetAnimCtrl();
        break;
    case ANIM_CTRL_TYPE_TEXIMG:
        c = ((drIAnimCtrlObjTexImg*)ctrl_obj)->GetAnimCtrl();
        break;
    }

    if(c == NULL)
        return NULL;

    return c->GetPoseCtrl();
}

DR_RESULT LESceneItem::PlayDefaultAnimation()
{
    return _obj->PlayDefaultAnimation();
}

void LESceneItem::ShowBoundingObject( int show )
{
    _obj->ShowBoundingObject( show );
}
DR_RESULT LESceneItem::GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD id )
{
    return _obj->GetObjDummyRunTimeMatrix( mat, id );
}

void LESceneItem::GetDummyLocalMatrix( drMatrix44* mat, DWORD id )
{
	_obj->GetDummyMatrix( mat, id );
}

drIPrimitive* LESceneItem::GetPrimitive()
{
    return _obj->GetPrimitive();
}
void LESceneItem::SetObjState( DWORD state, BYTE value )
{
    _obj->SetObjState( state, value );
}
DWORD LESceneItem::GetObjState( DWORD state ) const
{
    return _obj->GetObjState( state );
}
//DR_RESULT LESceneItem::ResetItemTexture( const char* file )
//{
//    drIPrimitive* p = _obj->GetPrimitive();
//    drIMtlTexAgent* mtltex_agent = p->GetMtlTexAgent(0);
//    mtltex_agent->DestroyTextureStage(0);
//
//    drTexInfo info;
//    drTexInfo_Construct(&info);
//
//    info.stage = 0;
//    info.colorkey_type = COLORKEY_TYPE_NONE;
//    strcpy_s( info.file_name, file );
//    
//    return mtltex_agent->LoadTextureStage(&info, NULL);
//
//}

DR_RESULT LESceneItem::ResetItemTexture(DWORD subset, drITex* tex, drITex** old_tex)
{
    drIPrimitive* p = _obj->GetPrimitive();
    drIMtlTexAgent* mtltex_agent = p->GetMtlTexAgent(subset);

    if(mtltex_agent == 0)
        return DR_RET_FAILED;

    return mtltex_agent->SetTex(tex->GetStage(), tex, old_tex);
}
void LESceneItem::SetTextureLOD(DWORD level)
{
    _obj->SetTextureLOD(level);
}

DR_END