//
#pragma once

#include "drHeader.h"
#include "drMath.h"
#include "drInterfaceExt.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drPrimitive.h"
#include "drLinkCtrl.h"

DR_BEGIN

class drItem : public drIItem
{
private:
    drIResourceMgr* _res_mgr;
    drISceneMgr* _scene_mgr;

    drLinkCtrl* _link_ctrl;
    DWORD _link_parent_id;
    DWORD _link_item_id;

    drStateCtrl _state_ctrl;
    char _file_name[ DR_MAX_NAME ];
    drIPrimitive* _obj;
    drMatrix44 _mat_base;
    DWORD _id;
    DWORD _item_type;
    float _opacity;

DR_STD_DECLARATION()

public:
    drItem( drIResourceMgr* res_mgr );
    ~drItem();

    void SetFileName( const char* file ) { _tcsncpy_s( _file_name, file, _TRUNCATE ); }
    char* GetFileName() { return _file_name; }

    virtual drIPrimitive* GetPrimitive() { return _obj; }

    DR_RESULT Copy( drIItem* src_obj );
    DR_RESULT Clone( drIItem** ret_obj );

    drMatrix44* GetMatrix() { return &_mat_base; }
    void SetMatrix( const drMatrix44* mat ) { _mat_base = *mat; }
    void SetOpacity(float opacity);

    DR_RESULT Load( const char* file, int arbitrary_flag = 0 );
    DR_RESULT Load(drIGeomObjInfo* info);
    DR_RESULT Update();
    DR_RESULT Render();
    DR_RESULT Destroy();

    DR_RESULT HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray );

    void SetMaterial( const drMaterial* mtl );

    void ShowBoundingObject( int show );

    const drMatrix44* GetObjDummyMatrix( DWORD id );
    const drMatrix44* GetObjBoneDummyMatrix( DWORD id );

    DR_RESULT PlayDefaultAnimation();


    // 这里我们定义如果道具具有骨骼动画，则dummy只有绑定在骨骼上才是有效的
    DR_RESULT GetDummyMatrix( drMatrix44* mat, DWORD id );
    DR_RESULT GetObjDummyRunTimeMatrix( drMatrix44* mat, DWORD id );

    DR_RESULT SetLinkCtrl( drLinkCtrl* ctrl, DWORD link_parent_id, DWORD link_item_id );
    DR_RESULT ClearLinkCtrl();

    void SetObjState( DWORD state, BYTE value ) { return _state_ctrl.SetState(state, value); }
    DWORD GetObjState( DWORD state ) const { return _state_ctrl.GetState(state); }
    DR_RESULT RegisterSceneMgr(drISceneMgr* scene_mgr) { _scene_mgr = scene_mgr; return DR_RET_OK; }

    DR_RESULT SetTextureLOD(DWORD level);
    float GetOpacity() { return _opacity; }
};


DR_END
