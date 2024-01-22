//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drInterface.h"
#include "drObjectMethod.h"
#include "drFrontAPI.h"
#include "LESceneItem.h"
#include "LECharacter.h"

DR_BEGIN


class DR_FRONT_API LESceneObject : public drMatrixCtrl
{
private:
    drIModel* _model;
//  这个变量游戏中大部分都没用到，改用vector能节省 (68-16) = 52 的内存，仍然保证了效率 
//  LESceneItem* _link_item_seq[ DR_MAX_LINK_ITEM_NUM ];
//	DWORD _link_item_num;
	vector<LESceneItem*> _link_item_seq;

public:
    LESceneObject();
    LESceneObject( drISysGraphics* sys_graphics );
    virtual ~LESceneObject();

    DR_RESULT Load( const char* file, DWORD model_id = DR_INVALID_INDEX );


    void FrameMove();
    void Render();
    void SetMaterial( const D3DMATERIALX* mtl );
    void SetOpacity(float opacity);

    void Destroy();

    drIPoseCtrl* GetObjImpPoseCtrl( DWORD skin_id, DWORD ctrl_type );
    DR_RESULT PlayObjImpPose( DWORD obj_id, DWORD ctrl_type, DWORD pose_id, DWORD play_type, float start_frame = 0.0f, float velocity = 1.0f );

    DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray );
    DR_RESULT HitTestHelperBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name ); 
    DR_RESULT HitTestHelperMesh( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name );
    DR_RESULT HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray );
    DR_RESULT HitTestPrimitiveHelperBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name ); 
    DR_RESULT HitTestPrimitiveHelperMesh( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name );

    drIPrimitive* GetPrimitive( DWORD id );

    void ShowHelperObject( int show );
    void ShowHelperMesh( int show );
    void ShowHelperBox( int show );
    void ShowBoundingObject( int show );

    DR_RESULT PlayDefaultAnimation();

    void SetObjState( DWORD state, BYTE value );
    DWORD GetObjState( DWORD state ) const;

    drIModel* GetObject() { return _model; }
    drIHelperObject* GetHelperObject() { return _model->GetHelperObject(); }
	drVector3 GetObjectSize();

    DR_RESULT SetItemLink( const drSceneItemLinkInfo* info );
    DR_RESULT UnwieldItem( const LESceneItem* obj );
    DWORD GetLinkItemNum() const { return (DWORD)_link_item_seq.size(); }
    LESceneItem* GetLinkItem( DWORD id );
    DWORD GetPrimitiveNum() const;
    int GetPrimitiveBox( DWORD id, D3DXVECTOR3* p1, D3DXVECTOR3* p2 );
    void SetTextureLOD(DWORD level);
    float GetOpacity();
    DWORD GetTransparentFlag() const;


};

typedef LESceneObject LESceneObject;

class DR_FRONT_API drSceneObjectChair : public drMatrixCtrl
{
private:
    drMatrix44 _mat;
    drBox _box;
    drIPrimitive* _obj;

public:
    drSceneObjectChair();
    ~drSceneObjectChair();


    DR_RESULT Create();
    DR_RESULT Render();
    DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray );
    void SetMatrix( const drMatrix44* mat ) { _mat = *mat; }
    drMatrix44* GetMatrix() { return &_mat; }
};

typedef drSceneObjectChair LESceneObjectChair;

DR_END