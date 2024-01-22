//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drInterface.h"
#include "drObjectMethod.h"

#include "drFrontAPI.h"

DR_BEGIN


class DR_FRONT_API LESceneItem : public drMatrixCtrl
{
private:
    drIItem* _obj;

public:
    LESceneItem();
    LESceneItem( drISysGraphics* sys_graphics );
    virtual ~LESceneItem();

    drIItem* GetObject() { return _obj; }

    DR_RESULT Load( const char* file, int arbitrary_flag = 0 );


    void FrameMove();
    void Render();
    void SetMaterial( const D3DMATERIALX* mtl );
    void SetOpacity(float opacity);
    float GetOpacity();


    DR_RESULT Copy(const LESceneItem* obj);
    void Destroy();

    drIPoseCtrl* GetObjImpPoseCtrl( DWORD ctrl_type );
    DR_RESULT PlayObjImpPose( DWORD ctrl_type, DWORD pose_id, DWORD play_type, float start_frame = 0.0f, float velocity = 1.0f );

    DR_RESULT HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray );

    void ShowBoundingObject( int show );

    DR_RESULT GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD id );
    DR_RESULT PlayDefaultAnimation();
    //DR_RESULT ResetItemTexture( const char* file );
    DR_RESULT ResetItemTexture(DWORD subset, drITex* tex, drITex** old_tex);

    drIPrimitive* GetPrimitive();

    void SetObjState( DWORD state, BYTE value );
    DWORD GetObjState( DWORD state ) const;
    void SetTextureLOD(DWORD level);

public :
	void GetDummyLocalMatrix( drMatrix44* mat, DWORD id );
};

typedef LESceneItem MSPceneItem;



DR_END