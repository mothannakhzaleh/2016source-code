//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drFrontAPI.h"
#include "drStreamObj.h"
#include "drExpObj.h"
#include "drITypes.h"
#include "drInterfaceExt.h"
#include "drDeviceObject.h"
#include "drResourceMgr.h"
#include "drPrimitiveHelper.h"

DR_BEGIN


class drPrimitive : public drIPrimitive
{
DR_STD_DECLARATION()

protected:
    DWORD _id;
    DWORD _parent_id;
    drStateCtrl _state_ctrl;

    drIResourceMgr* _res_mgr;
    drIMeshAgent* _mesh_agent;
    drIMtlTexAgent* _mtltex_agent_seq[ DR_MAX_SUBSET_NUM ];
    drIAnimCtrlAgent* _anim_agent;
    drIRenderCtrlAgent* _render_agent;
    drIHelperObject* _helper_object;

private:
    DR_RESULT _UpdateTransparentState();

public:
    drPrimitive( drIResourceMgr* mgr );
    virtual ~drPrimitive();


    virtual void SetMatrixLocal( const drMatrix44* mat );
    virtual void SetMatrixParent( const drMatrix44* mat );

    drMatrix44* GetMatrixLocal();
    drMatrix44* GetMatrixGlobal();
    void SetID(DWORD id) { _id = id; }
    void SetParentID( DWORD id ) { _parent_id = id; }
    DWORD GetID() const { return _id; }
    DWORD GetParentID() const { return _parent_id; }
    


    DR_RESULT HitTest( drPickInfo* info, const drVector3* org, const drVector3* ray );

    DR_RESULT DestroyRenderCtrlAgent();
    DR_RESULT DestroyMeshAgent();
    DR_RESULT DestroyMtlTexAgent( DWORD subset );
    DR_RESULT Destroy();


    DR_RESULT Load( drIGeomObjInfo* info, const char* tex_path, const drResFile* res );
    DR_RESULT LoadMesh( drMeshInfo* info );
    DR_RESULT LoadMesh( const drResFileMesh* info );
    DR_RESULT LoadMtlTex( DWORD mtl_id, drMtlTexInfo* info, const char* tex_path );
    DR_RESULT LoadAnimData( drIAnimDataInfo* info, const char* tex_path, const drResFile* res );
    DR_RESULT LoadRenderCtrl(const drRenderCtrlCreateInfo* rcci);

    DR_RESULT ExtractGeomObjInfo(drIGeomObjInfo* info);

    virtual DR_RESULT Update();
    virtual DR_RESULT Render();
    virtual DR_RESULT RenderSubset( DWORD subset );

    DR_RESULT Clone( drIPrimitive** ret_obj );

    drIResourceMgr* GetResourceMgr() { return _res_mgr; }
    drIMtlTexAgent* GetMtlTexAgent( DWORD id ) { return _mtltex_agent_seq[ id ]; }
    drIMeshAgent* GetMeshAgent() { return _mesh_agent; }
    drIAnimCtrlAgent* GetAnimAgent() { return _anim_agent; }
    drIRenderCtrlAgent* GetRenderCtrlAgent() { return _render_agent; }
    drIHelperObject* GetHelperObject() { return _helper_object; }
    DR_RESULT GetSubsetNum(DWORD* subset_num);


    void SetMeshAgent( drIMeshAgent* agent ) { _mesh_agent = agent; }
    void SetMtlTexAgent( DWORD subset, drIMtlTexAgent* agent ) { _mtltex_agent_seq[ subset ] = agent; }
    void SetAnimCtrlAgent(drIAnimCtrlAgent* agent) { _anim_agent = agent; }
    void SetRenderCtrl( drIRenderCtrlAgent* obj ) { _render_agent = obj; }
    void SetHelperObject(drIHelperObject* obj) { _helper_object = obj; }
    void SetMaterial(const drMaterial* mtl);
    void SetOpacity(float opacity);

    // object state method
    void SetState(const drStateCtrl* ctrl) { _state_ctrl = *ctrl; }
    void SetState(DWORD state, BYTE value)
    { _state_ctrl.SetState(state, value); }
    BYTE GetState(DWORD state) const 
    { return _state_ctrl.GetState(state); }

    DR_RESULT SetTextureLOD(DWORD level);
    DR_RESULT PlayDefaultAnimation();
    DR_RESULT ResetTexture(DWORD subset, DWORD stage, const char* file, const char* tex_path);

	void setPixelShader( const std::string& filename )
	{
		_render_agent->setPixelShader( filename );
	}
};

DR_RESULT drPrimitivePlayDefaultAnimation( drIPrimitive* obj );

DR_END
