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


class drModel : public drIModel, public drLinkCtrl
{
private:
    drIResourceMgr* _res_mgr;
    drISceneMgr* _scene_mgr;

    drStateCtrl _state_ctrl;
    char _file_name[ DR_MAX_NAME ];
    drIPrimitive* _obj_seq[ DR_MAX_MODEL_GEOM_OBJ_NUM ];
    DWORD _obj_num;
    drMatrix44 _mat_base;
    DWORD _id;
    DWORD _model_id;

    drIHelperObject* _helper_object;
    float _opacity;

DR_STD_DECLARATION()

public:
    drModel( drIResourceMgr* res_mgr );
    ~drModel();

    DWORD GetModelID() const { return _model_id; }
    void SetFileName( const char* file ) { _tcsncpy_s( _file_name, file, _TRUNCATE ); }
    char* GetFileName() { return _file_name; }

    DR_RESULT Clone( drIModel** ret_obj );
    DR_RESULT Copy( drIModel* src_obj );

    drMatrix44* GetMatrix() { return &_mat_base; }
    void SetMatrix( const drMatrix44* mat ) { _mat_base = *mat; }

    DR_RESULT Load(drIModelObjInfo* info);
    DR_RESULT Load( const char* file, DWORD model_id = DR_INVALID_INDEX );
    DR_RESULT Update();
    DR_RESULT Render();
    DR_RESULT RenderPrimitive( DWORD id );
    DR_RESULT RenderHelperObject();
    DR_RESULT Destroy();

    void SetMaterial( const drMaterial* mtl );
    void SetOpacity(float opacity);


    DR_RESULT HitTestPrimitive( drPickInfo* info, const drVector3* org, const drVector3* ray );
    DR_RESULT HitTestPrimitiveHelperMesh( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name );
    DR_RESULT HitTestPrimitiveHelperBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name ); 
    DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray );
    DR_RESULT HitTestHelperMesh( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name );
    DR_RESULT HitTestHelperBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name ); 

    DR_RESULT PlayDefaultAnimation();

    DR_RESULT SortPrimitiveObj();


    void ShowHelperObject( int show );
    void ShowHelperMesh( int show );
    void ShowHelperBox( int show );
    void ShowBoundingObject( int show );
    drIHelperObject* GetHelperObject() { return _helper_object; }

    DWORD GetPrimitiveNum() const { return _obj_num; }
    drIPrimitive* GetPrimitive( DWORD id ) { return _obj_seq[ id ]; }

    void SetObjState( DWORD state, BYTE value ) { return _state_ctrl.SetState( state, value ); }
    DWORD GetObjState( DWORD state ) const { return _state_ctrl.GetState( state ); }

    DR_RESULT RegisterSceneMgr(drISceneMgr* scene_mgr) { _scene_mgr = scene_mgr; return DR_RET_OK; }

    DR_RESULT SetItemLink( const drItemLinkInfo* info );
    DR_RESULT ClearItemLink( drIItem* obj );

    // link ctrl method
    virtual DR_RESULT GetLinkCtrlMatrix( drMatrix44* mat, DWORD link_id );

    DR_RESULT SetTextureLOD(DWORD level);
    float GetOpacity() { return _opacity; }

    DR_RESULT CullPrimitive();
    DWORD GetCullingPrimitiveNum();
    DR_RESULT ExtractModelInfo(drIModelObjInfo* out_info);
};


DR_END
