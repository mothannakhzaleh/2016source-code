//
#pragma once

#include <string>
#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drDirectX.h"
#include "drGuidObj.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drITypes2.h"
#include "drShaderTypes.h"

DR_BEGIN


class drISystem;
class drISysGraphics;
class drIDeviceObject;
class drIHelperObject;
class drIShaderMgr;
class drIMeshAgent;
class drIMtlTexAgent;
class drIRenderCtrl;
class drIRenderCtrlAgent;
class drIResourceMgr;
class drIAnimCtrlObj;
class drIAnimCtrlObjMat;
class drIAnimCtrlObjBone;
class drIAnimCtrlAgent;
class drIPrimitive;
class drIRenderCtrlVSBone;
class drISceneMgr;
class drIAnimKeySetPRS;
class drILockableStreamVB;
class drILockableStreamIB;
class drINode;
class drINodePrimitive;
class drINodeBoneCtrl;
class drINodeObject;
class drIPathInfo;
class drIOptionMgr;
class drIThreadPool;
class drIRenderStateAtomSet;
class drIVertexBuffer;
class drIIndexBuffer;
class drISystemInfo;
class drIMesh;
class drITex;
class drIAnimKeySetFloat;
class drICoordinateSys;
class drIFileStream;
// ============= begin base interface method =============
class drInterface
{
public:
    virtual DR_RESULT Release() PURE_METHOD;
    virtual DR_RESULT GetInterface(DR_VOID** i, drGUID guid) PURE_METHOD;    
};

#define DR_STD_DECLARATION() \
    public: \
    virtual DR_RESULT Release(); \
    virtual DR_RESULT GetInterface( DR_VOID** i, drGUID guid );


#define DR_STD_RELEASE( cls ) \
DR_RESULT cls::Release() \
{ DR_DELETE( this ); return DR_RET_OK; }

#define DR_STD_GETINTERFACE( cls ) \
DR_RESULT cls::GetInterface( DR_VOID** i, drGUID guid ) \
{ return DR_RET_NULL; };

#define DR_STD_ILELEMENTATION( cls ) \
DR_STD_RELEASE( cls ) \
DR_STD_GETINTERFACE( cls )

// ============= end base interface method =============

class DR_DECLSPEC_NOVTABLE drIPoseCtrl : public drInterface
{
public:
    virtual DR_RESULT Load(const char* file) PURE_METHOD;
    virtual DR_RESULT Save(const char* file) const PURE_METHOD;

    virtual DR_RESULT InsertPose(DWORD id, const drPoseInfo* pi, int num) PURE_METHOD; 
    virtual DR_RESULT ReplacePose(DWORD id, const drPoseInfo* pi) PURE_METHOD;
    virtual DR_RESULT RemovePose(DWORD id) PURE_METHOD;
    virtual DR_RESULT RemoveAll() PURE_METHOD;

    virtual void SetFrameNum(int frame) PURE_METHOD;
    virtual DWORD GetPoseNum() const PURE_METHOD;
    virtual drPoseInfo* GetPoseInfo(DWORD id) PURE_METHOD;
    
    virtual DWORD GetPoseFrameNum(DWORD pose_id) const PURE_METHOD;
    virtual int IsPosePlaying(const drPlayPoseInfo* info) const PURE_METHOD;
    
    virtual DR_RESULT PlayPose(drPlayPoseInfo* info) PURE_METHOD;    
}; 

class DR_DECLSPEC_NOVTABLE drIMtlTexInfo : public drInterface
{
public:
};
class DR_DECLSPEC_NOVTABLE drIHelperInfo : public drInterface
{
public:
};
class DR_DECLSPEC_NOVTABLE drIAnimData : public drInterface
{
public:
    //virtual DWORD GetAnimDataType() const PURE_METHOD;
    //virtual DWORD GetSubsetType() const PURE_METHOD;
    //virtual void SetSubsetType(DWORD subset_type) PURE_METHOD;
    //virtual DR_RESULT Load(FILE* fp, DWORD version) PURE_METHOD;
    //virtual DR_RESULT Save(FILE* fp) const PURE_METHOD;
    //virtual DR_RESULT Load(const char* file) PURE_METHOD;
    //virtual DR_RESULT Save(const char* file) const PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIAnimDataBone : public drIAnimData
{
public:
    virtual DR_RESULT Load(const char* file) PURE_METHOD;
    virtual DR_RESULT Save(const char* file) const PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimDataMatrix : public drIAnimData
{
public:
    virtual DWORD GetFrameNum() PURE_METHOD;
    virtual DR_RESULT GetValue(drMatrix44* mat, float frame) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIAnimDataTexUV : public drIAnimData
{
public:
    virtual DR_RESULT SetData(const drMatrix44* mat_seq, DWORD mat_num) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIAnimDataTexImg : public drIAnimData
{
public:
};
class DR_DECLSPEC_NOVTABLE drIAnimDataMtlOpacity : public drIAnimData
{
public:
    virtual DR_RESULT Clone(drIAnimDataMtlOpacity** obj) PURE_METHOD;
    virtual drIAnimKeySetFloat* GetAnimKeySet() PURE_METHOD;
    virtual void SetAnimKeySet(drIAnimKeySetFloat* aks_ctrl) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimDataInfo : public drInterface
{
public:
};



class DR_DECLSPEC_NOVTABLE drIAnimCtrl : public drInterface
{
public:
    virtual DR_DWORD GetCtrlType() const PURE_METHOD;
    virtual DR_VOID SetRegisterID(DR_DWORD id) PURE_METHOD;
    virtual DR_DWORD GetRegisterID() const PURE_METHOD;
    virtual void SetResFile(const drResFileAnimData* info) PURE_METHOD;
    virtual drResFileAnimData* GetResFileInfo() PURE_METHOD;
    virtual drIPoseCtrl* GetPoseCtrl() PURE_METHOD;

    virtual DR_RESULT LoadData(const void* data) PURE_METHOD;
    virtual DR_RESULT UpdatePose(drPlayPoseInfo* info) PURE_METHOD;
    virtual DR_RESULT UpdateAnimData(const drPlayPoseInfo* info) PURE_METHOD;



};

class DR_DECLSPEC_NOVTABLE drIAnimCtrlBone : public drIAnimCtrl
{
public:
    virtual DR_RESULT UpdatePoseKeyFrameProc(drPlayPoseInfo* info) PURE_METHOD;
    virtual drMatrix44* GetBoneRTMSeq() PURE_METHOD;
    virtual drIndexMatrix44* GetDummyRTMSeq() PURE_METHOD;
    virtual drMatrix44* GetDummyRTM(DWORD id) PURE_METHOD;
    virtual DWORD GetDummyNum() PURE_METHOD;
    virtual DWORD GetBoneNum() PURE_METHOD;
    virtual DR_RESULT CreateRunTimeDataBuffer() PURE_METHOD;
    virtual DR_RESULT EnableRunTimeFrameBuffer(DWORD frame, DWORD flag) PURE_METHOD;
    virtual DR_RESULT ExtractAnimData(drIAnimDataBone* out_data) PURE_METHOD;
    virtual DR_RESULT DumpRunTimeBoneData(const char* file) PURE_METHOD;
    virtual DR_RESULT DumpInitInvMat(const char* file) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIAnimCtrlMatrix : public drIAnimCtrl
{
public:
    virtual DR_RESULT GetRTM(drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT ExtractAnimData(drIAnimDataMatrix* out_data) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimCtrlTexUV : public drIAnimCtrl
{
public:
    virtual DR_RESULT LoadData(const void* data) PURE_METHOD;
    virtual DR_RESULT LoadData(const drMatrix44* mat_seq, DWORD mat_num) PURE_METHOD;
    virtual void SetAnimKeySetPRS(drIAnimKeySetPRS* keyset) PURE_METHOD;
    virtual DR_RESULT ExtractAnimData(drIAnimDataTexUV* out_data) PURE_METHOD;
    virtual DR_RESULT GetRunTimeMatrix(drMatrix44* mat) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIAnimCtrlTexImg : public drIAnimCtrl
{
public:
    virtual DR_RESULT ExtractAnimData(drIAnimDataTexImg* out_data) PURE_METHOD;
    virtual DR_RESULT GetRunTimeTex(drITex** tex) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIAnimCtrlMtlOpacity : public drIAnimCtrl
{
public:
    virtual DR_RESULT ExtractAnimData(drIAnimDataMtlOpacity* out_data) PURE_METHOD;
    virtual DR_RESULT GetRunTimeOpacity(float* opacity) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIMeshInfo : public drInterface
{
public:
};
class DR_DECLSPEC_NOVTABLE drIGeomObjInfo : public drInterface
{
public:
    virtual DR_RESULT Load(const char* file) PURE_METHOD;
    virtual DR_RESULT Save(const char* file) PURE_METHOD;
    virtual drMeshInfo* GetMeshInfo() PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIModelObjInfo : public drInterface
{
public:
    virtual DR_RESULT Load(const char* file) PURE_METHOD;
    virtual DR_RESULT Save(const char* file) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIHelperDummyObjInfo : public drInterface
{
public:
};

class DR_DECLSPEC_NOVTABLE drIPrimitive : public drInterface
{
public:
    virtual DR_RESULT Load(drIGeomObjInfo* info, const char* tex_path, const drResFile* res) PURE_METHOD;
    virtual DR_RESULT LoadMesh(drMeshInfo* info) PURE_METHOD;
    virtual DR_RESULT LoadMesh(const drResFileMesh* info) PURE_METHOD;
    virtual DR_RESULT LoadMtlTex(DWORD mtl_id, drMtlTexInfo* info, const char* tex_path) PURE_METHOD;
    virtual DR_RESULT LoadAnimData(drIAnimDataInfo* info, const char* tex_path, const drResFile* res) PURE_METHOD;
    virtual DR_RESULT LoadRenderCtrl(const drRenderCtrlCreateInfo* rcci) PURE_METHOD;

    virtual DR_RESULT ExtractGeomObjInfo(drIGeomObjInfo* info) PURE_METHOD;

    virtual DR_RESULT DestroyRenderCtrlAgent() PURE_METHOD;
    virtual DR_RESULT DestroyMeshAgent() PURE_METHOD;
    virtual DR_RESULT DestroyMtlTexAgent(DWORD subset) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Clone(drIPrimitive** ret_obj) PURE_METHOD;

    virtual drIResourceMgr* GetResourceMgr() PURE_METHOD;
    virtual drIMtlTexAgent* GetMtlTexAgent(DWORD id) PURE_METHOD;
    virtual drIMeshAgent* GetMeshAgent() PURE_METHOD;
    virtual drIAnimCtrlAgent* GetAnimAgent() PURE_METHOD;
    virtual drIRenderCtrlAgent* GetRenderCtrlAgent() PURE_METHOD;
    virtual drIHelperObject* GetHelperObject() PURE_METHOD;
    virtual DR_RESULT GetSubsetNum(DWORD* subset_num) PURE_METHOD;

    virtual void SetMeshAgent(drIMeshAgent* agent) PURE_METHOD;
    virtual void SetMtlTexAgent(DWORD subset, drIMtlTexAgent* agent) PURE_METHOD;
    virtual void SetAnimCtrlAgent(drIAnimCtrlAgent* agent) PURE_METHOD;
    virtual void SetRenderCtrl(drIRenderCtrlAgent* obj) PURE_METHOD;
    virtual void SetHelperObject(drIHelperObject* obj) PURE_METHOD;
    virtual void SetMaterial(const drMaterial* mtl) PURE_METHOD;
    virtual void SetOpacity(float opacity) PURE_METHOD;

    virtual void SetMatrixLocal(const drMatrix44* mat_local) PURE_METHOD;
    virtual void SetMatrixParent(const drMatrix44* mat_parent) PURE_METHOD;
    virtual drMatrix44* GetMatrixLocal() PURE_METHOD;
    virtual drMatrix44* GetMatrixGlobal() PURE_METHOD;
    virtual void SetID(DWORD id) PURE_METHOD;
    virtual void SetParentID(DWORD id) PURE_METHOD;
    virtual DWORD GetID() const PURE_METHOD;
    virtual DWORD GetParentID() const PURE_METHOD;


    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual DR_RESULT RenderSubset(DWORD subset) PURE_METHOD;

    virtual DR_RESULT HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;

    virtual void SetState(const drStateCtrl* ctrl) PURE_METHOD;
    virtual void SetState(DWORD state, BYTE value) PURE_METHOD;
    virtual BYTE GetState(DWORD state) const PURE_METHOD;
    virtual DR_RESULT SetTextureLOD(DWORD level) PURE_METHOD;
    virtual DR_RESULT PlayDefaultAnimation() PURE_METHOD;
    virtual DR_RESULT ResetTexture(DWORD subset, DWORD stage, const char* file, const char* tex_path) PURE_METHOD;

	virtual void setPixelShader( const std::string& filename ) PURE_METHOD;

};


class DR_FRONT_API DR_DECLSPEC_NOVTABLE drIPhysique : public drInterface
{
public:
    virtual drIResourceMgr* GetResourceMgr() PURE_METHOD;

    virtual DR_RESULT Destroy() PURE_METHOD;

    virtual DR_RESULT LoadBone(const char* file) PURE_METHOD;
    virtual DR_RESULT LoadPrimitive(DWORD part_id, const char* file) PURE_METHOD;
    virtual DR_RESULT LoadPrimitive(DWORD part_id, drIGeomObjInfo* geom_info) PURE_METHOD;
    virtual DR_RESULT DestroyPrimitive(DWORD part_id) PURE_METHOD;
    virtual DR_RESULT CheckPrimitive(DWORD part_id) PURE_METHOD;

    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;

    virtual drMatrix44* GetMatrix() PURE_METHOD;
    virtual void SetMatrix(const drMatrix44* mat) PURE_METHOD;

    virtual void SetOpacity(float opacity) PURE_METHOD;

    virtual DR_RESULT HitTestPrimitive(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;
    virtual DR_RESULT HitTestPhysique(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;

    virtual void ShowHelperObject(int show) PURE_METHOD;
    virtual void ShowBoundingObjectPhysique(int show) PURE_METHOD;

    virtual DR_RESULT SetItemLink(const drItemLinkInfo* info) PURE_METHOD;
    virtual DR_RESULT ClearItemLink(drIItem* obj) PURE_METHOD;

    virtual void SetObjState(DWORD state, BYTE value) PURE_METHOD;
    virtual DWORD GetObjState(DWORD state) const PURE_METHOD;

    virtual drIPrimitive* GetPrimitive(DWORD id) PURE_METHOD;
    virtual drIAnimCtrlAgent* GetAnimCtrlAgent() PURE_METHOD;

    virtual DR_RESULT RegisterSceneMgr(drISceneMgr* scene_mgr) PURE_METHOD;
    virtual DR_RESULT SetTextureLOD(DWORD level) PURE_METHOD;
    virtual float GetOpacity() PURE_METHOD;
	virtual void Start() PURE_METHOD;
	virtual void End() PURE_METHOD;
	virtual bool isLoaded() PURE_METHOD;
	virtual void setComponentColour( size_t index, D3DCOLOR colour, const std::string& filterTextureName ) PURE_METHOD;
	virtual void setTextureOperation( size_t index, D3DTEXTUREOP operation ) PURE_METHOD;
	virtual const char* getTextureOperationDescription( size_t operation ) PURE_METHOD;
	virtual void setPixelShader( size_t index, const std::string& filename ) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIModel : public drInterface
{
public:
    virtual DR_RESULT Load(drIModelObjInfo* info) PURE_METHOD;
    virtual DR_RESULT Load(const char* file, DWORD model_id = DR_INVALID_INDEX) PURE_METHOD;
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual DR_RESULT RenderPrimitive(DWORD id) PURE_METHOD;
    virtual DR_RESULT RenderHelperObject() PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;

    virtual drMatrix44* GetMatrix() PURE_METHOD;
    virtual void SetMatrix(const drMatrix44* mat) PURE_METHOD;
    virtual void SetMaterial(const drMaterial* mtl) PURE_METHOD;
    virtual void SetOpacity(float opacity) PURE_METHOD;

    virtual DR_RESULT HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;
    virtual DR_RESULT HitTestHelperBox(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name) PURE_METHOD;
    virtual DR_RESULT HitTestHelperMesh(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name) PURE_METHOD;
    virtual DR_RESULT HitTestPrimitive(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;
    virtual DR_RESULT HitTestPrimitiveHelperBox(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name) PURE_METHOD;
    virtual DR_RESULT HitTestPrimitiveHelperMesh(drPickInfo* info, const drVector3* org, const drVector3* ray, const char* type_name) PURE_METHOD;

    virtual DR_RESULT PlayDefaultAnimation() PURE_METHOD;

    virtual void ShowHelperObject(int show) PURE_METHOD;
    virtual void ShowHelperMesh(int show);
    virtual void ShowHelperBox(int show);
    virtual void ShowBoundingObject(int show);

    virtual DWORD GetPrimitiveNum() const PURE_METHOD;
    virtual drIPrimitive* GetPrimitive(DWORD id) PURE_METHOD;
    virtual drIHelperObject* GetHelperObject() PURE_METHOD;

    virtual void SetObjState(DWORD state, BYTE value) PURE_METHOD;
    virtual DWORD GetObjState(DWORD state) const PURE_METHOD;

    virtual DR_RESULT RegisterSceneMgr(drISceneMgr* scene_mgr) PURE_METHOD;

    virtual DR_RESULT SetItemLink(const drItemLinkInfo* info) PURE_METHOD;
    virtual DR_RESULT ClearItemLink(drIItem* obj) PURE_METHOD;
    virtual DR_RESULT SetTextureLOD(DWORD level) PURE_METHOD;
    virtual float GetOpacity() PURE_METHOD;

    virtual DR_RESULT CullPrimitive() PURE_METHOD;
    virtual DWORD GetCullingPrimitiveNum() PURE_METHOD;
    virtual DR_RESULT ExtractModelInfo(drIModelObjInfo* out_info) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIItem : public drInterface
{
public:
    virtual drMatrix44* GetMatrix() PURE_METHOD;
    virtual void SetMatrix(const drMatrix44* mat) PURE_METHOD;

    virtual DR_RESULT Load(drIGeomObjInfo* info) PURE_METHOD;
    virtual DR_RESULT Load(const char* file, int arbitrary_flag = 0) PURE_METHOD;
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;

    virtual DR_RESULT Copy(drIItem* src_obj) PURE_METHOD;
    virtual DR_RESULT Clone(drIItem** ret_obj) PURE_METHOD;

    virtual drIPrimitive* GetPrimitive() PURE_METHOD;

    virtual DR_RESULT HitTestPrimitive(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;

    virtual void SetMaterial(const drMaterial* mtl) PURE_METHOD;
    virtual void SetOpacity(float opacity) PURE_METHOD;

    virtual void ShowBoundingObject(int show) PURE_METHOD;

    virtual DR_RESULT PlayDefaultAnimation() PURE_METHOD;

	virtual DR_RESULT GetDummyMatrix( drMatrix44* mat, DWORD id ) PURE_METHOD;
    virtual const drMatrix44* GetObjDummyMatrix(DWORD id) PURE_METHOD;
    virtual DR_RESULT GetObjDummyRunTimeMatrix(drMatrix44* mat, DWORD id) PURE_METHOD;

    virtual DR_RESULT SetLinkCtrl(drLinkCtrl* ctrl, DWORD link_parent_id, DWORD link_item_id) PURE_METHOD;
    virtual DR_RESULT ClearLinkCtrl() PURE_METHOD;
    virtual void SetObjState(DWORD state, BYTE value) PURE_METHOD;
    virtual DWORD GetObjState(DWORD state) const PURE_METHOD;

    virtual DR_RESULT RegisterSceneMgr(drISceneMgr* scene_mgr) PURE_METHOD;
    virtual DR_RESULT SetTextureLOD(DWORD level) PURE_METHOD;
    virtual float GetOpacity() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drISysGraphics : public drInterface
{
public:
    virtual drISystem* GetSystem()PURE_METHOD;
    virtual drIDeviceObject* GetDeviceObject() PURE_METHOD;
    virtual drIResourceMgr* GetResourceMgr() PURE_METHOD;
    virtual drISceneMgr* GetSceneMgr() PURE_METHOD;
    virtual drICoordinateSys* GetCoordinateSys() PURE_METHOD;

    virtual DR_RESULT CreateDeviceObject(drIDeviceObject** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateResourceManager(drIResourceMgr** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateSceneManager(drISceneMgr** ret_obj) PURE_METHOD;

    virtual DR_RESULT ToggleFullScreen(D3DPRESENT_PARAMETERS* d3dpp, drWndInfo* wnd_info) PURE_METHOD;
    virtual DR_RESULT TestCooperativeLevel() PURE_METHOD;
    virtual void SetOutputLoseDeviceProc(drOutputLoseDeviceProc proc) PURE_METHOD;
    virtual void SetOutputResetDeviceProc(drOutputResetDeviceProc proc) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drISystem : public drInterface
{
public:
    virtual DR_RESULT Initialize() PURE_METHOD;
    virtual DR_RESULT CreateGraphicsSystem(drISysGraphics** sys) PURE_METHOD;
    virtual drIPathInfo* GetPathInfo() PURE_METHOD;
    virtual drIOptionMgr* GetOptionMgr() PURE_METHOD;
    virtual drISystemInfo* GetSystemInfo() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIPathInfo : public drInterface
{
public:
    virtual char* SetPath(DWORD type, const char* path) PURE_METHOD;
    virtual char* GetPath(DWORD type) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIOptionMgr : public drInterface
{
public:
    virtual void SetIgnoreModelTexFlag(BYTE flag) PURE_METHOD;
    virtual BYTE GetIgnoreModelTexFlag() const PURE_METHOD;
    virtual void SetByteFlag(DWORD type, BYTE value) PURE_METHOD;
    virtual BYTE GetByteFlag(DWORD type) const PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIByteSet : public drInterface
{
public:
    virtual DR_RESULT Alloc(DWORD size) PURE_METHOD;
    virtual DR_RESULT Free() PURE_METHOD;
    virtual DR_RESULT SetValueSeq(DWORD start, BYTE* buf, DWORD num) PURE_METHOD;
    virtual void SetValue(DWORD type, BYTE value) PURE_METHOD;
    virtual BYTE GetValue(DWORD type) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIStaticStreamMgr : public drInterface
{
public:
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT CreateStreamEntitySeq(DWORD entity_vb_num, DWORD entity_ib_num) PURE_METHOD;
    virtual DR_RESULT CreateVertexBufferStream(DWORD stream_id, DWORD stream_size) PURE_METHOD;
    virtual DR_RESULT CreateIndexBufferStream(DWORD stream_id, DWORD stream_size) PURE_METHOD;
    virtual DR_RESULT RegisterVertexBuffer(DR_HANDLE* out_handle, void* data, DWORD size, DWORD stride) PURE_METHOD;
    virtual DR_RESULT RegisterIndexBuffer(DR_HANDLE* out_handle, void* data, DWORD size, DWORD stride) PURE_METHOD;
    virtual DR_RESULT UnregisterVertexBuffer(DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT UnregisterIndexBuffer(DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT BindVertexBuffer(DR_HANDLE handle, UINT channel) PURE_METHOD;
    virtual DR_RESULT BindIndexBuffer(DR_HANDLE handle) PURE_METHOD;
    virtual DWORD GetVertexEntityOffset() PURE_METHOD;
    virtual DWORD GetIndexEntityOffset() PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;
    virtual DR_RESULT GetDebugInfo(drStaticStreamMgrDebugInfo* info) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIDynamicStreamMgr : public drInterface
{
public:
    virtual DR_RESULT Create(DWORD vb_size, DWORD ib_size) PURE_METHOD;
    virtual DR_RESULT DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT count, const void* vert_data, UINT vert_stride, D3DFORMAT fvf) PURE_METHOD;
    virtual DR_RESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, UINT min_vert_index, UINT num_vert_indices, UINT count,
        const void* index_data, D3DFORMAT index_format, const void* vertex_data, UINT vert_stride, D3DFORMAT fvf) PURE_METHOD;

    virtual DR_RESULT BindDataVB(DWORD channel, const void* data, DWORD size, UINT stride) PURE_METHOD;
    virtual DR_RESULT BindDataIB(const void* data, DWORD size, DWORD stride) PURE_METHOD;
    virtual DR_RESULT DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT start_vert, UINT count) PURE_METHOD;
    virtual DR_RESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT num_vert, UINT start_index, UINT count) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drILockableStreamMgr : public drInterface
{
public:
    virtual DR_RESULT RegisterVertexBuffer(DR_HANDLE* handle, void* data, DWORD size, DWORD usage, DWORD fvf) PURE_METHOD;
    virtual DR_RESULT RegisterIndexBuffer(DR_HANDLE* handle, void* data, DWORD size, DWORD usage, DWORD fvf) PURE_METHOD;
    virtual DR_RESULT UnregisterVertexBuffer(DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT UnregisterIndexBuffer(DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT BindVertexBuffer(DR_HANDLE handle, UINT channel, UINT offset_byte, UINT stride) PURE_METHOD;
    virtual DR_RESULT BindIndexBuffer(DR_HANDLE handle, UINT base_vert_index) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;
    virtual drILockableStreamVB* GetStreamVB(DR_HANDLE handle) PURE_METHOD;
    virtual drILockableStreamIB* GetStreamIB(DR_HANDLE handle) PURE_METHOD;


};

class DR_DECLSPEC_NOVTABLE drILockableStream : public drInterface
{
public:
    virtual DR_RESULT Lock(UINT offset, UINT size, void** data, DWORD flag) PURE_METHOD;
    virtual DR_RESULT Unlock() PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drILockableStreamVB : public drILockableStream
{
public:
};
class DR_DECLSPEC_NOVTABLE drILockableStreamIB : public drILockableStream
{
public:
};

class DR_DECLSPEC_NOVTABLE drISurfaceStream : public drInterface
{
public:
    virtual DR_RESULT CreateRenderTarget(UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateDepthStencilSurface(UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;
    virtual void SetRegisterID(DWORD id) PURE_METHOD;
    virtual DWORD GetRegisterID() const PURE_METHOD;
    virtual IDirect3DSurfaceX* GetSurface() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drISurfaceStreamMgr : public drInterface
{
public:
    // for dx8, multi_sample_quality and handle are null
    virtual DR_RESULT CreateRenderTarget(DR_HANDLE* ret_handle, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateDepthStencilSurface(DR_HANDLE* ret_handle, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT UnregisterSurface(DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;
    virtual drIResourceMgr* GetResourceMgr() PURE_METHOD;
    virtual drISurfaceStream* GetSurfaceStream(DR_HANDLE handle) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIDeviceObject : public drInterface
{
public:
    virtual DR_RESULT CreateDirect3D() PURE_METHOD;
    virtual DR_RESULT CreateDevice(drD3DCreateParam* param) PURE_METHOD;
    virtual DR_RESULT ResetDevice(D3DPRESENT_PARAMETERS* d3dpp) PURE_METHOD;
    virtual DR_RESULT ResetDeviceStateCache() PURE_METHOD;
    virtual DR_RESULT ResetDeviceTransformMatrix() PURE_METHOD;

    virtual DR_RESULT SetDirect3D(IDirect3DX* d3d) PURE_METHOD;
    virtual DR_RESULT SetDevice(IDirect3DDeviceX* dev) PURE_METHOD;
    virtual IDirect3DX* GetDirect3D() PURE_METHOD;
    virtual IDirect3DDeviceX* GetDevice() PURE_METHOD;
    virtual drD3DCreateParam* GetD3DCreateParam() PURE_METHOD;
    virtual D3DDISPLAYMODE* GetAdapterDisplayMode() PURE_METHOD;
    virtual D3DCAPSX* GetDeviceCaps() PURE_METHOD;
    virtual drBackBufferFormatsInfo* GetBackBufferFormatsCaps() PURE_METHOD;

    virtual DR_RESULT SetStreamSource(UINT stream_num, IDirect3DVertexBufferX* stream_data, UINT offset_byte, UINT stride) PURE_METHOD;
    virtual DR_RESULT SetIndices(IDirect3DIndexBufferX* index_data, UINT base_vert_index) PURE_METHOD;
    virtual DR_RESULT DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT start_vertex, UINT count) PURE_METHOD;
    virtual DR_RESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT vert_num, UINT start_index, UINT count) PURE_METHOD;
    virtual DR_RESULT DrawPrimitiveUP(D3DPRIMITIVETYPE pt_type, UINT count, const void* data, UINT stride) PURE_METHOD;
    virtual DR_RESULT DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE pt_type, UINT min_vert_index, UINT vert_num, UINT count, const void *index_data, D3DFORMAT index_data_fmt, const void* vert_data, UINT vert_stride) PURE_METHOD;
    
    virtual DR_RESULT SetTransform(D3DTRANSFORMSTATETYPE state, const drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT SetTransformView(const drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT SetTransformProj(const drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT SetTransformWorld(const drMatrix44* mat) PURE_METHOD;

    virtual DR_RESULT SetMaterial(drMaterial* mtl) PURE_METHOD;

    virtual DR_RESULT SetTexture(DWORD stage, IDirect3DBaseTextureX* tex) PURE_METHOD;
    virtual DR_RESULT SetRenderState(D3DRENDERSTATETYPE state, DWORD value) PURE_METHOD;
    virtual DR_RESULT SetTextureStageState(DWORD stage, D3DTEXTURESTAGESTATETYPE type, DWORD value) PURE_METHOD;
    virtual DR_RESULT SetTextureForced(DWORD stage, IDirect3DTextureX* tex) PURE_METHOD;
    virtual DR_RESULT SetRenderStateForced(D3DRENDERSTATETYPE state, DWORD value) PURE_METHOD;
    virtual DR_RESULT SetTextureStageStateForced(DWORD stage, D3DTEXTURESTAGESTATETYPE type, DWORD value) PURE_METHOD;
#if(defined DR_USE_DX9)
    virtual DR_RESULT SetSamplerState(DWORD sampler, D3DSAMPLERSTATETYPE type, DWORD value) PURE_METHOD;
    virtual DR_RESULT SetSamplerStateForced(DWORD sampler, D3DSAMPLERSTATETYPE type, DWORD value) PURE_METHOD;
#endif

#if (defined DR_USE_DX9)
    virtual DR_RESULT SetFVF(DWORD fvf) PURE_METHOD;
    virtual DR_RESULT SetVertexShader(IDirect3DVertexShaderX* shader) PURE_METHOD;
    virtual DR_RESULT SetVertexShaderForced(IDirect3DVertexShaderX* shader) PURE_METHOD;
    virtual DR_RESULT SetVertexDeclaration(IDirect3DVertexDeclarationX* decl);
    virtual DR_RESULT SetVertexDeclarationForced(IDirect3DVertexDeclarationX* decl);
    virtual DR_RESULT SetVertexShaderConstantF(UINT reg_id, const float* data, UINT v_num) PURE_METHOD;
#elif (defined DR_USE_DX8)

    virtual DR_RESULT SetVertexShader(IDirect3DVertexShaderX shader) PURE_METHOD;
    virtual DR_RESULT SetVertexShaderConstant(UINT reg_id, const void* data, UINT v_num) PURE_METHOD;

#endif

    virtual DR_RESULT GetRenderState(DWORD state, DWORD* value) PURE_METHOD;
    virtual DR_RESULT GetTextureStageState(DWORD stage, DWORD state, DWORD* value) PURE_METHOD;
#if(defined DR_USE_DX9)
    virtual DR_RESULT GetSamplerState(DWORD sampler, D3DSAMPLERSTATETYPE state, DWORD* value) PURE_METHOD;
#endif
    virtual DR_RESULT GetTexture(DWORD stage, IDirect3DBaseTextureX** tex) PURE_METHOD;
    virtual const drMatrix44* GetMatView() PURE_METHOD;
    virtual const drMatrix44* GetMatProj() PURE_METHOD;
    virtual const drMatrix44* GetMatViewProj() PURE_METHOD;

    virtual DR_RESULT SetLight(DWORD id, const D3DLIGHTX* light) PURE_METHOD;
    virtual DR_RESULT GetLight(DWORD id, D3DLIGHTX* light) PURE_METHOD;
    virtual DR_RESULT LightEnable(DWORD id, BOOL flag) PURE_METHOD;
    virtual DR_RESULT LightEnableForced(DWORD id, BOOL flag) PURE_METHOD;
    virtual DR_RESULT GetLightEnable(DWORD id, BOOL* flag) PURE_METHOD;
    virtual DR_RESULT UpdateWindowRect() PURE_METHOD;
    virtual DR_RESULT GetWindowRect(RECT* rc_wnd, RECT* rc_client) PURE_METHOD;


    virtual DR_RESULT InitStateCache() PURE_METHOD;
    virtual DR_RESULT InitCapsInfo() PURE_METHOD;

    virtual DR_RESULT CreateVertexBuffer(UINT length, DWORD usage, DWORD fvf, D3DPOOL pool, IDirect3DVertexBufferX** vb, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateIndexBuffer(UINT length, DWORD usage, D3DFORMAT fmt, D3DPOOL pool, IDirect3DIndexBufferX** ib, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateTexture(IDirect3DTextureX** out_tex, const drTexDataInfo* info, DWORD level, DWORD usage, DWORD format, D3DPOOL pool) PURE_METHOD;
    virtual DR_RESULT CreateTexture(IDirect3DTextureX** out_tex, UINT width, UINT height, UINT level, DWORD usage, D3DFORMAT format, D3DPOOL pool) PURE_METHOD;
    virtual DR_RESULT CreateTextureFromFileInMemory(IDirect3DTextureX** out_tex, void* data, UINT data_size, UINT width, UINT height, UINT mip_level, DWORD usage, D3DFORMAT format, D3DPOOL pool, DWORD filter, DWORD mip_filter, D3DCOLOR colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette) PURE_METHOD;
    virtual DR_RESULT CreateVertexBuffer(drIVertexBuffer** out_obj) PURE_METHOD;
    virtual DR_RESULT CreateIndexBuffer(drIIndexBuffer** out_obj) PURE_METHOD;
    virtual DR_RESULT CreateRenderTarget(IDirect3DSurfaceX** o_surface, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateDepthStencilSurface(IDirect3DSurfaceX** o_surface, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateCubeTexture(IDirect3DCubeTextureX** o_tex, UINT edge_length, UINT levels, DWORD usage, D3DFORMAT format, D3DPOOL pool, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT CreateOffscreenPlainSurface(IDirect3DSurfaceX** surface, UINT width, UINT height, D3DFORMAT format, DWORD pool, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT ReleaseTex(IDirect3DTextureX* tex) PURE_METHOD;
    virtual DR_RESULT ReleaseVertexBuffer(IDirect3DVertexBufferX* vb) PURE_METHOD;
    virtual DR_RESULT ReleaseIndexBuffer(IDirect3DIndexBufferX* ib) PURE_METHOD;

    virtual void BeginBenchMark() PURE_METHOD;
    virtual void EndBenchMark() PURE_METHOD;
    virtual DWORD GetMarkPolygonNum() const PURE_METHOD;
    virtual drWatchDevVideoMemInfo* GetWatchVideoMemInfo() PURE_METHOD;

    virtual DR_RESULT CheckCurrentDeviceFormat(DWORD type, D3DFORMAT check_fmt) PURE_METHOD;
    virtual DR_RESULT ScreenToWorld(drVector3* org, drVector3* ray, int x, int y) PURE_METHOD;
    virtual DR_RESULT WorldToScreen(int* x, int* y, float* z, const drVector3* v) PURE_METHOD;

    virtual DR_RESULT DumpRenderState(const char* file) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drITex : public drInterface
{
public:
    //virtual DR_RESULT Register() PURE_METHOD;
    //virtual DR_RESULT Unregister() PURE_METHOD;
    virtual int AddRef(int i) PURE_METHOD;
    virtual int GetRef() PURE_METHOD;

    virtual DR_RESULT LoadTexInfo(const drTexInfo* info, const char* tex_path) PURE_METHOD;
    virtual DR_RESULT LoadSystemMemory() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemory() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemoryMT() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemoryEx() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemoryDirect() PURE_METHOD;
    virtual DR_RESULT UnloadSystemMemory() PURE_METHOD;
    virtual DR_RESULT UnloadVideoMemory() PURE_METHOD;
    virtual DR_RESULT Unload() PURE_METHOD;
    virtual DR_RESULT BeginSet() PURE_METHOD;
    virtual DR_RESULT EndSet() PURE_METHOD;
    virtual void SetRegisterID(DWORD id) PURE_METHOD;
    virtual DWORD GetRegisterID() const PURE_METHOD;
    virtual drTexDataInfo* GetDataInfo() PURE_METHOD;
    virtual IDirect3DTextureX* GetTex() PURE_METHOD;
    virtual drColorValue4b GetColorKey() const PURE_METHOD;
    virtual char* GetFileName() PURE_METHOD;
    virtual DWORD GetStage() const PURE_METHOD;
    virtual DWORD GetState() const PURE_METHOD;
    virtual void GetTexInfo(drTexInfo* info) PURE_METHOD;
    virtual BOOL IsLoadingOK() const PURE_METHOD;
    virtual DWORD SetLOD(DWORD level) PURE_METHOD;
    virtual void SetLoadFlag(DWORD flag) PURE_METHOD;
    virtual void SetMTFlag(DWORD flag) PURE_METHOD;
    virtual DWORD GetMTFlag() PURE_METHOD;

    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;

    virtual DR_RESULT BeginPass() PURE_METHOD;
    virtual DR_RESULT EndPass() PURE_METHOD;

    virtual void SetLoadResType(DWORD type) PURE_METHOD;
    virtual void SetLoadResMask(DWORD add_mask, DWORD remove_mask) PURE_METHOD;
    virtual DWORD GetLoadResMask() PURE_METHOD;
    virtual DWORD GetLoadResType() PURE_METHOD;

};


class DR_DECLSPEC_NOVTABLE drIMesh : public drInterface
{
public:
    virtual DR_RESULT LoadSystemMemory(const drMeshInfo* info) PURE_METHOD;
    virtual DR_RESULT LoadSystemMemoryMT(const drMeshInfo* info) PURE_METHOD;
    virtual DR_RESULT LoadSystemMemory() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemory() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemoryMT() PURE_METHOD;
    virtual DR_RESULT LoadVideoMemoryEx() PURE_METHOD;
    virtual DR_RESULT UnloadSystemMemory() PURE_METHOD;
    virtual DR_RESULT UnloadVideoMemory() PURE_METHOD;
    virtual DR_RESULT Unload() PURE_METHOD;
    virtual DR_RESULT ExtractMesh(drMeshInfo* info) PURE_METHOD;

    virtual drResFileMesh* GetResFileMesh() PURE_METHOD;
    virtual DWORD GetState() const PURE_METHOD;
    virtual drMeshInfo* GetMeshInfo() PURE_METHOD;
    virtual DR_HANDLE GetVBHandle() const PURE_METHOD;
    virtual DR_HANDLE GetIBHandle() const PURE_METHOD;
    virtual DR_RESULT SetResFile(const drResFileMesh* info) PURE_METHOD;
    virtual void SetRegisterID(DWORD id) PURE_METHOD;
    virtual DWORD GetRegisterID() const PURE_METHOD;
    virtual void SetStreamType(DWORD type) PURE_METHOD;
    virtual DWORD GetStreamType() const PURE_METHOD;
    virtual void SetColorkey(DWORD key) PURE_METHOD;

    //virtual DR_RESULT Register() PURE_METHOD;
    //virtual DR_RESULT Unregister() PURE_METHOD;

	virtual DR_RESULT AddStateToSet(DWORD state, DWORD value) PURE_METHOD; //添加 RenderState 如果渲染状态表满了，则返回失败，最多8个 
	virtual DR_RESULT BeginSet() PURE_METHOD;
    virtual DR_RESULT EndSet() PURE_METHOD;
    virtual DR_RESULT DrawSubset(DWORD subset) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;

    virtual drILockableStreamVB* GetLockableStreamVB() PURE_METHOD;
    virtual drILockableStreamIB* GetLockableStreamIB() PURE_METHOD;

    virtual BOOL IsLoadingOK() const PURE_METHOD;
    virtual void SetMTFlag(DWORD flag) PURE_METHOD;
    virtual DWORD GetMTFlag() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIMtlTexAgent : public drInterface
{
public:
    virtual DR_RESULT BeginPass() PURE_METHOD;
    virtual DR_RESULT EndPass() PURE_METHOD;

    virtual DR_RESULT BeginSet() PURE_METHOD;
    virtual DR_RESULT EndSet() PURE_METHOD;

    virtual DR_RESULT LoadMtlTex(drMtlTexInfo* info, const char* tex_path) PURE_METHOD;
    virtual DR_RESULT LoadTextureStage(const drTexInfo* info, const char* tex_path) PURE_METHOD;
    virtual DR_RESULT ExtractMtlTex(drMtlTexInfo* info) PURE_METHOD;

    virtual DR_RESULT DestroyTextureStage(DWORD stage) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Clone(drIMtlTexAgent** ret_obj) PURE_METHOD;

    virtual void SetOpacity(float opacity) PURE_METHOD;
    virtual void SetTranspType(DWORD type) PURE_METHOD;
    virtual DR_RESULT SetTex(DWORD stage, drITex* obj, drITex** ret_obj) PURE_METHOD;
    virtual void SetMaterial(const drMaterial* mtl) PURE_METHOD;
    virtual void SetRenderFlag(BOOL flag) PURE_METHOD;
    virtual float GetOpacity() const PURE_METHOD;
    virtual DWORD GetTransparencyType() const PURE_METHOD;
    virtual drMaterial* GetMaterial() PURE_METHOD;
    virtual drITex* GetTex(DWORD stage) PURE_METHOD;
    virtual BOOL GetRenderFlag() PURE_METHOD;
    virtual DR_RESULT SetTextureTransformMatrix(DWORD stage, const drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT SetTextureTransformImage(DWORD stage, drITex* tex) PURE_METHOD;
    virtual drIRenderStateAtomSet* GetMtlRenderStateSet() PURE_METHOD;
    virtual DR_RESULT SetTextureLOD(DWORD level) PURE_METHOD;
    virtual BOOL IsTextureLoadingOK() const PURE_METHOD;


};
class DR_DECLSPEC_NOVTABLE drIMeshAgent : public drInterface
{
public:
    virtual void SetRenderState(DWORD begin_end, DWORD state, DWORD value) PURE_METHOD;
    virtual void SetRenderState(drRenderStateSetMtl2* rs_set) PURE_METHOD;
    virtual void SetMesh(drIMesh* mesh) PURE_METHOD;
    virtual drIMesh* GetMesh() PURE_METHOD;

    virtual DR_RESULT BeginSet() PURE_METHOD;
    virtual DR_RESULT EndSet() PURE_METHOD;
    virtual DR_RESULT DrawSubset(DWORD subset) PURE_METHOD;
    virtual DR_RESULT LoadMesh(const drMeshInfo* info) PURE_METHOD;
    virtual DR_RESULT LoadMesh(const drResFileMesh* info) PURE_METHOD;
    virtual DR_RESULT DestroyMesh() PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Clone(drIMeshAgent** ret_obj) PURE_METHOD;

    
};  

class DR_DECLSPEC_NOVTABLE drIAnimCtrlObj : public drInterface
{
public:
    virtual DR_RESULT UpdateAnimCtrl() PURE_METHOD;
    virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
    virtual DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual drIAnimCtrl* GetAnimCtrl() PURE_METHOD;
    virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;
    virtual BOOL IsPlaying() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimCtrlObjMat : public drIAnimCtrlObj
{
public:
    virtual DR_RESULT Clone(drIAnimCtrlObjMat** ret_obj) PURE_METHOD;
    virtual drIAnimCtrlMatrix* AttachAnimCtrl(drIAnimCtrlMatrix* ctrl) PURE_METHOD;
    virtual drIAnimCtrlMatrix* DetachAnimCtrl() PURE_METHOD;
    virtual drIAnimCtrl* GetAnimCtrl() PURE_METHOD;
    virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;
    virtual DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
    virtual BOOL IsPlaying() PURE_METHOD;

    virtual DR_RESULT UpdateAnimCtrl() PURE_METHOD;
    virtual DR_RESULT UpdateObject() PURE_METHOD;
    virtual DR_RESULT GetRTM(drMatrix44* mat) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIAnimCtrlObjBone : public drIAnimCtrlObj
{
public:
    virtual DR_RESULT Clone(drIAnimCtrlObjBone** ret_obj) PURE_METHOD;
    virtual drIAnimCtrlBone* AttachAnimCtrl(drIAnimCtrlBone* ctrl) PURE_METHOD;
    virtual drIAnimCtrlBone* DetachAnimCtrl() PURE_METHOD;
    virtual drIAnimCtrl* GetAnimCtrl() PURE_METHOD;
    virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;
    virtual void SetPlayPoseInfo(const drPlayPoseInfo* ppi) PURE_METHOD;
    virtual DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
    virtual BOOL IsPlaying() PURE_METHOD;

    virtual DR_RESULT UpdateAnimCtrl() PURE_METHOD;
    virtual DR_RESULT UpdateObject(drIAnimCtrlObjBone* ctrl_obj, drIMesh* mesh_obj) PURE_METHOD;
    virtual DR_RESULT UpdateHelperObject(drIHelperObject* helper_obj) PURE_METHOD;

    virtual drMatrix44* GetBoneRTMSeq() PURE_METHOD;
    virtual drMatrix44* GetDummyRTM(DWORD id) PURE_METHOD;
    virtual drIndexMatrix44* GetDummyRTMSeq() PURE_METHOD;
    virtual DWORD GetBoneRTTMNum() PURE_METHOD;
    virtual DWORD GetDummyRTMNum() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimCtrlObjTexUV : public drIAnimCtrlObj
{
public:
     virtual DR_RESULT Clone(drIAnimCtrlObjTexUV** ret_obj) PURE_METHOD;
     virtual drIAnimCtrlTexUV* AttachAnimCtrl(drIAnimCtrlTexUV* ctrl) PURE_METHOD;
     virtual drIAnimCtrlTexUV* DetachAnimCtrl() PURE_METHOD;
     virtual drIAnimCtrl* GetAnimCtrl() PURE_METHOD;
     virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;
     virtual DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
     virtual DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
     virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
     virtual BOOL IsPlaying() PURE_METHOD;

    virtual DR_RESULT UpdateAnimCtrl() PURE_METHOD;
    virtual DR_RESULT UpdateObject() PURE_METHOD;

    virtual DR_RESULT GetRTM(drMatrix44* mat) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIAnimCtrlObjTexImg : public drIAnimCtrlObj
{
public:
    virtual DR_RESULT Clone(drIAnimCtrlObjTexImg** ret_obj) PURE_METHOD;
    virtual drIAnimCtrlTexImg* AttachAnimCtrl(drIAnimCtrlTexImg* ctrl) PURE_METHOD;
    virtual drIAnimCtrlTexImg* DetachAnimCtrl() PURE_METHOD;
    virtual drIAnimCtrl* GetAnimCtrl() PURE_METHOD;
    virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;
    virtual DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
    virtual BOOL IsPlaying() PURE_METHOD;

    virtual DR_RESULT UpdateAnimCtrl() PURE_METHOD;
    virtual DR_RESULT UpdateObject() PURE_METHOD;
    
    virtual DR_RESULT GetRunTimeTex(drITex** tex) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIAnimCtrlObjMtlOpacity : public drIAnimCtrlObj
{
public:
    virtual DR_RESULT Clone(drIAnimCtrlObjMtlOpacity** ret_obj) PURE_METHOD;
    virtual drIAnimCtrlMtlOpacity* AttachAnimCtrl(drIAnimCtrlMtlOpacity* ctrl) PURE_METHOD;
    virtual drIAnimCtrlMtlOpacity* DetachAnimCtrl() PURE_METHOD;
    virtual drIAnimCtrl* GetAnimCtrl() PURE_METHOD;
    virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;
    virtual DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
    virtual BOOL IsPlaying() PURE_METHOD;

    virtual DR_RESULT UpdateAnimCtrl() PURE_METHOD;
    virtual DR_RESULT UpdateObject() PURE_METHOD;
    
    virtual DR_RESULT GetRunTimeOpacity(float* opacity) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimCtrlAgent : public drInterface
{
public:
    virtual DR_RESULT AddAnimCtrlObj(drIAnimCtrlObj* obj) PURE_METHOD;
    virtual drIAnimCtrlObj* RemoveAnimCtrlObj(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual drIAnimCtrlObj* GetAnimCtrlObj(drAnimCtrlObjTypeInfo* info) PURE_METHOD;
    virtual drIAnimCtrlObj* GetAnimCtrlObj(DWORD id) PURE_METHOD;
    virtual DWORD GetAnimCtrlObjNum() PURE_METHOD;
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Clone(drIAnimCtrlAgent** ret_obj) PURE_METHOD;
    virtual DR_RESULT ExtractAnimData(drIAnimDataInfo* data_info) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIShaderDeclMgr : public drInterface
{
public:
    virtual DR_RESULT CreateShaderDeclSet(DWORD decl_type, DWORD buf_size) PURE_METHOD;
    virtual DR_RESULT SetShaderDeclInfo(drShaderDeclCreateInfo* info) PURE_METHOD;
    virtual DR_RESULT QueryShaderHandle(DWORD* shader_handle, const drShaderDeclQueryInfo* info) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIShaderMgr : public drInterface
{
public:
#if (defined DR_USE_DX8)
    virtual drIShaderDeclMgr* GetShaderDeclMgr() PURE_METHOD;
    virtual DR_RESULT Init(DWORD vs_buf_size, DWORD ps_buf_size) PURE_METHOD;
    virtual DR_RESULT RegisterVertexShader(DWORD type, DWORD* data, DWORD size, DWORD usage, DWORD* decl, DWORD decl_size) PURE_METHOD;
    virtual DR_RESULT RegisterVertexShader(DWORD type, const char* file, DWORD usage, DWORD* decl, DWORD decl_size, DWORD binary_flag) PURE_METHOD;
    virtual DR_RESULT UnregisterVertexShader(DWORD type) PURE_METHOD;
    virtual DR_RESULT QueryVertexShader(DWORD* ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;

#endif

#if (defined DR_USE_DX9)
    virtual drIShaderDeclMgr* GetShaderDeclMgr() PURE_METHOD;
    virtual DR_RESULT Init(DWORD vs_buf_size, DWORD decl_buf_size, DWORD ps_buf_size) PURE_METHOD;
    virtual DR_RESULT RegisterVertexShader(DWORD type, BYTE* data, DWORD size) PURE_METHOD;
    virtual DR_RESULT RegisterVertexShader(DWORD type, const char* file, DWORD binary_flag) PURE_METHOD;
    virtual DR_RESULT RegisterVertexDeclaration(DWORD type, D3DVERTEXELEMENT9* data) PURE_METHOD;
    virtual DR_RESULT QueryVertexShader(IDirect3DVertexShaderX** ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT QueryVertexDeclaration(IDirect3DVertexDeclarationX** ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;
    virtual drVertexShaderInfo* GetVertexShaderInfo(DWORD type) PURE_METHOD;
#endif
};

class DR_DECLSPEC_NOVTABLE drIResBufMgr : public drInterface
{
public:
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT RegisterSysMemTex(DR_HANDLE* handle, const drSysMemTexInfo* info) PURE_METHOD;
    virtual DR_RESULT QuerySysMemTex(drSysMemTexInfo* info) PURE_METHOD;
    virtual DR_RESULT QuerySysMemTex(drSysMemTexInfo** info, const char* file) PURE_METHOD;
    virtual DR_RESULT GetSysMemTex(drSysMemTexInfo** info, DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT UnregisterSysMemTex(DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT RegisterModelObjInfo(DR_HANDLE* handle, const char* file) PURE_METHOD;
    virtual DR_RESULT RegisterModelObjInfo(DR_HANDLE handle, const char* file) PURE_METHOD;
    virtual DR_RESULT QueryModelObjInfo(drIModelObjInfo** info, const char* file) PURE_METHOD;
    virtual DR_RESULT GetModelObjInfo(drIModelObjInfo** info, DR_HANDLE handle) PURE_METHOD;
    virtual DR_RESULT UnregisterModelObjInfo(DR_HANDLE handle) PURE_METHOD;
    virtual void SetLimitModelObjInfo(DWORD lmt_size, DWORD lmt_time) PURE_METHOD;
};   
class DR_DECLSPEC_NOVTABLE drIThreadPoolMgr : public drInterface
{
public:
    virtual DR_RESULT Create() PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual drIThreadPool* GetThreadPool(DWORD type) PURE_METHOD;
    virtual void LockCriticalSection(DWORD type) PURE_METHOD;
    virtual void UnlockCriticalSection(DWORD type) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIResourceMgr : public drInterface
{
public:
    virtual drISysGraphics* GetSysGraphics() PURE_METHOD;
    virtual drIDeviceObject* GetDeviceObject() PURE_METHOD;
    virtual drIShaderMgr* GetShaderMgr() PURE_METHOD;
    virtual drIStaticStreamMgr* GetStaticStreamMgr() PURE_METHOD;
    virtual drIDynamicStreamMgr* GetDynamicStreamMgr() PURE_METHOD;
    virtual drILockableStreamMgr* GetLockableStreamMgr() PURE_METHOD;
    virtual drISurfaceStreamMgr* GetSurfaceStreamMgr() PURE_METHOD;
    virtual drIResBufMgr* GetResBufMgr() PURE_METHOD;
    virtual drIThreadPoolMgr* GetThreadPoolMgr() PURE_METHOD;
    virtual drIByteSet* GetByteSet() PURE_METHOD;

    virtual DR_RESULT SetAssObjInfo(DWORD mask, const drAssObjInfo* info) PURE_METHOD;
    virtual DR_RESULT GetAssObjInfo(drAssObjInfo* info) PURE_METHOD;

    virtual DR_RESULT CreateMesh(drIMesh** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateTex(drITex** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateAnimCtrl(drIAnimCtrl** ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT CreateAnimCtrlObj(drIAnimCtrlObj** ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT CreateMeshAgent(drIMeshAgent** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateMtlTexAgent(drIMtlTexAgent** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateAnimCtrlAgent(drIAnimCtrlAgent** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateRenderCtrlAgent(drIRenderCtrlAgent** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateRenderCtrlVS(drIRenderCtrlVS** ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT CreatePrimitive(drIPrimitive** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateHelperObject(drIHelperObject** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreatePhysique(drIPhysique** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateModel(drIModel** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateItem(drIItem** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateNode(drINode** ret_obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT CreateNodeObject(drINodeObject** ret_obj) PURE_METHOD;
    virtual DR_RESULT CreateStaticStreamMgr(drIStaticStreamMgr** mgr) PURE_METHOD;
    virtual DR_RESULT CreateDynamicStreamMgr(drIDynamicStreamMgr** mgr) PURE_METHOD;

    virtual DR_RESULT RegisterMesh(drIMesh* obj) PURE_METHOD;
    virtual DR_RESULT RegisterTex(drITex* obj) PURE_METHOD;
    virtual DR_RESULT RegisterAnimCtrl(drIAnimCtrl* obj) PURE_METHOD;
    virtual DR_RESULT RegisterRenderCtrlProc(DWORD id, drRenderCtrlVSCreateProc proc) PURE_METHOD;
    virtual DR_RESULT UnregisterMesh(drIMesh* obj) PURE_METHOD;
    virtual DR_RESULT UnregisterTex(drITex* obj) PURE_METHOD;
    virtual DR_RESULT UnregisterAnimCtrl(drIAnimCtrl* obj) PURE_METHOD;

    virtual DR_RESULT GetMesh(drIMesh** ret_obj, DWORD id) PURE_METHOD;
    virtual DR_RESULT GetTex(drITex** ret_obj, DWORD id) PURE_METHOD;
    virtual DR_RESULT GetAnimCtrl(drIAnimCtrl** ret_obj, DWORD id) PURE_METHOD;

    virtual DR_RESULT AddRefMesh(drIMesh* obj, DWORD ref_cnt) PURE_METHOD;
    virtual DR_RESULT AddRefTex(drITex* obj, DWORD ref_cnt) PURE_METHOD;
    virtual DR_RESULT AddRefAnimCtrl(drIAnimCtrl* ret_obj, DWORD ref_cnt) PURE_METHOD;

    virtual DR_ULONG QueryTexRefCnt(drITex* obj) PURE_METHOD;

    virtual DR_RESULT QueryMesh(DWORD* ret_id, const drResFileMesh* info) PURE_METHOD;
    virtual DR_RESULT QueryTex(DWORD* ret_id, const char* file_name) PURE_METHOD;
    virtual DR_RESULT QueryAnimCtrl(DWORD* ret_id, const drResFileAnimData* info) PURE_METHOD;

    virtual DR_RESULT RegisterObject(DWORD* ret_id, void* obj, DWORD type) PURE_METHOD;
    virtual DR_RESULT UnregisterObject(void** ret_obj, DWORD id, DWORD type) PURE_METHOD;
    virtual DR_RESULT QueryObject(void** ret_obj, DWORD type, const char* file_name) PURE_METHOD;
    virtual DR_RESULT QueryModelObject(void** ret_obj, DWORD model_id) PURE_METHOD;
    virtual DR_RESULT LoseDevice() PURE_METHOD;
    virtual DR_RESULT ResetDevice() PURE_METHOD;

    virtual void SetTexturePath(const char* path) PURE_METHOD;
    virtual char* GetTexturePath() PURE_METHOD;
	virtual IDirect3DTexture8* getMonochromaticTexture( D3DCOLOR colour, const std::string& filterTexture ) PURE_METHOD;
	virtual const char* getTextureOperationDescription( size_t operation ) PURE_METHOD;
};


class DR_DECLSPEC_NOVTABLE drIRenderCtrlAgent : public drInterface
{
public:
    virtual void SetMatrix(const drMatrix44* mat) PURE_METHOD;
    virtual void SetLocalMatrix(const drMatrix44* mat_local) PURE_METHOD;
    virtual void SetParentMatrix(const drMatrix44* mat_parent) PURE_METHOD;
    virtual drMatrix44* GetLocalMatrix() PURE_METHOD;
    virtual drMatrix44* GetParentMatrix() PURE_METHOD;
    virtual drMatrix44* GetGlobalMatrix() PURE_METHOD;

    virtual void BindMeshAgent(drIMeshAgent* agent) PURE_METHOD;
    virtual void BindMtlTexAgent(drIMtlTexAgent* agent) PURE_METHOD;
    virtual void BindAnimCtrlAgent(drIAnimCtrlAgent* agent) PURE_METHOD;
    virtual void SetVertexShader(DWORD type) PURE_METHOD;
    virtual void SetVertexDeclaration(DWORD type) PURE_METHOD;
    virtual DR_RESULT SetRenderCtrl(DWORD ctrl_type) PURE_METHOD;
    virtual DWORD GetVertexShader() const PURE_METHOD;
    virtual DWORD GetVertexDeclaration() const PURE_METHOD;

    virtual drIResourceMgr* GetResourceMgr() PURE_METHOD;
    virtual drIMeshAgent* GetMeshAgent() PURE_METHOD;
    virtual drIMtlTexAgent* GetMtlTexAgent() PURE_METHOD;
    virtual drIAnimCtrlAgent* GetAnimCtrlAgent() PURE_METHOD;
    virtual drIRenderCtrlVS* GetRenderCtrlVS() PURE_METHOD;

    virtual DR_RESULT Clone(drIRenderCtrlAgent** ret_obj) PURE_METHOD;
    virtual DR_RESULT BeginSet() PURE_METHOD;
    virtual DR_RESULT EndSet() PURE_METHOD;
    virtual DR_RESULT BeginSetSubset(DWORD subset) PURE_METHOD;
    virtual DR_RESULT EndSetSubset(DWORD subset) PURE_METHOD;

    virtual DR_RESULT DrawSubset(DWORD subset) PURE_METHOD;
	virtual void setPixelShader( const std::string& filename ) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIBoundingBox : public drInterface
{
public:
    virtual int IsValidObject() const PURE_METHOD;
    virtual int IsVisible() const PURE_METHOD;
    virtual void SetVisible(int flag) PURE_METHOD;
    virtual drBoundingBoxInfo* GetDataInfoWithID(DWORD obj_id) PURE_METHOD;
    virtual drBoundingBoxInfo* GetDataInfo(DWORD id) PURE_METHOD;
    virtual DWORD GetObjNum() const PURE_METHOD;
    virtual drMatrix44* GetMatrixParent() PURE_METHOD;

    virtual DR_RESULT HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat_parent) PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual void SetData(DWORD data) PURE_METHOD;
    virtual DWORD GetData() const PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIBoundingSphere : public drInterface
{
public:
    virtual int IsValidObject() const PURE_METHOD;
    virtual int IsVisible() const PURE_METHOD;
    virtual void SetVisible(int flag) PURE_METHOD;
    virtual drBoundingSphereInfo* GetDataInfoWithID(DWORD obj_id) PURE_METHOD;
    virtual drBoundingSphereInfo* GetDataInfo(DWORD id) PURE_METHOD;
    virtual DWORD GetObjNum() const PURE_METHOD;
    virtual drMatrix44* GetMatrixParent() PURE_METHOD;

    virtual DR_RESULT HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray, const drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual void SetData(DWORD data) PURE_METHOD;
    virtual DWORD GetData() const PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIHelperDummy : public drInterface
{
public:
    virtual DR_RESULT Render() PURE_METHOD;
    virtual int IsValidObject() const PURE_METHOD;
    virtual int IsVisible() const PURE_METHOD;
    virtual void SetVisible(int flag) PURE_METHOD;
    virtual DWORD GetObjNum() PURE_METHOD;
    virtual drHelperDummyInfo* GetDataInfo(DWORD id) PURE_METHOD;
    virtual drHelperDummyInfo* GetDataInfoWithID(DWORD obj_id) PURE_METHOD;
    virtual drMatrix44* GetMatrixParent() PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIHelperMesh : public drInterface
{
public:
    virtual DR_RESULT Render() PURE_METHOD;
    virtual int IsValidObject() const PURE_METHOD;
    virtual int IsVisible() const PURE_METHOD;
    virtual void SetVisible(int flag) PURE_METHOD;
    virtual drHelperMeshInfo* GetDataInfoWithID(DWORD obj_id) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIHelperBox : public drInterface
{
public:
    virtual DR_RESULT Render() PURE_METHOD;
    virtual int IsValidObject() const PURE_METHOD;
    virtual int IsVisible() const PURE_METHOD;
    virtual void SetVisible(int flag) PURE_METHOD;
    virtual drHelperBoxInfo* GetDataInfoWithID(DWORD obj_id) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIHelperObject : public drInterface
{
public:
    virtual DR_RESULT LoadHelperInfo(const drHelperInfo* info, int create_instance_flag) PURE_METHOD;
    virtual DR_RESULT Copy(const drIHelperObject* src) PURE_METHOD;
    virtual DR_RESULT Clone(drIHelperObject** ret_obj) PURE_METHOD;
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;

    virtual void SetParentMatrix(const drMatrix44* mat) PURE_METHOD;
    virtual void SetVisible(int flag) PURE_METHOD;
    virtual drIHelperDummy* GetHelperDummy() PURE_METHOD;
    virtual drIHelperBox* GetHelperBox() PURE_METHOD;
    virtual drIHelperMesh* GetHelperMesh() PURE_METHOD;
    virtual drIBoundingBox* GetBoundingBox() PURE_METHOD;
    virtual drIBoundingSphere* GetBoundingSphere() PURE_METHOD;

    virtual DR_RESULT ExtractHelperInfo(drIHelperInfo* out_info) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIActionBase : public drInterface
{
public:
   virtual DR_RESULT Run() PURE_METHOD;
   virtual DR_RESULT Update() PURE_METHOD;
   virtual DWORD GetState() const PURE_METHOD;
   virtual void SetState(DWORD state) PURE_METHOD;
   virtual DR_RESULT Pause() PURE_METHOD;
   virtual DR_RESULT Continue() PURE_METHOD;


};

class DR_DECLSPEC_NOVTABLE drIActionGeneric : public drIActionBase
{
public:
    virtual void SetPose(DWORD pose_id) PURE_METHOD;
    virtual void SetPlayType(DWORD type) PURE_METHOD;

    virtual void SetKeyFrameProc(drPoseKeyFrameProc proc, void* param) PURE_METHOD;
    virtual DR_RESULT PlayPoseOnce() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIActionMove : public drIActionBase
{
public:
    virtual void SetPose(DWORD pose_id) PURE_METHOD;
    virtual void SetMoveSpeed(float speed) PURE_METHOD;
    virtual void SetTurnSpeedCofficient(float speed) PURE_METHOD;
    virtual void SetLoaction(const drVector3* location_seq, DWORD location_num) PURE_METHOD;
    virtual void AddLocation(const drVector3* location_seq, DWORD location_num) PURE_METHOD;
    virtual float GetMovedDistance() const PURE_METHOD;
    virtual drVector3* GetActMoveDir() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIActionTurn : public drIActionBase
{
public:
    virtual void SetPose(DWORD pose_id) PURE_METHOD;

    virtual void SetTurnSpeed(float speed) PURE_METHOD;
    virtual void SetTurnAngle(float angle) PURE_METHOD;
    virtual void SetTargetAngle(float angle) PURE_METHOD;
    virtual void SetTargetDirection(const drVector3* dst_dir) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIActionMTG : public drIActionBase
{
public:
    virtual drIActionBase* GetSubAction(DWORD act_type) PURE_METHOD;
    virtual void SetBlockType(DWORD type) PURE_METHOD;
    virtual DWORD GetCurSubAction() const PURE_METHOD;
};


class DR_DECLSPEC_NOVTABLE drIActionAgent: public drInterface
{
public:
    virtual drActionObject* GetActionObject() PURE_METHOD;
    virtual DR_RESULT CreateAction(void** obj, DWORD type) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIActionSmith : public drInterface
{
public:
    virtual void AllocActionBuffer(DWORD act_num) PURE_METHOD;
    virtual DR_RESULT Init(drActionObject* act_obj, DWORD act_num) PURE_METHOD;
    virtual void SetNextActionType(DWORD dst_act_type, DWORD next_act_type) PURE_METHOD;

    virtual drIActionAgent* GetActionAgent() PURE_METHOD;
    virtual drActionObject* GetActionObject() PURE_METHOD;
    virtual drActImpBase* GetActionImp(DWORD act_type) PURE_METHOD;
    virtual drActImpBase* GetCurActionImp() PURE_METHOD;
    virtual DWORD GetCurActionImpType() const PURE_METHOD;
    virtual DR_RESULT LoadActionImp(DWORD type, drActImpBase* act) PURE_METHOD;
    virtual void SetSubAction(DWORD act_type, void* data, DWORD data_size) PURE_METHOD;
    virtual DWORD GetSubActionType() const PURE_METHOD;
    virtual void* GetSubActionData() PURE_METHOD;

    virtual DR_RESULT Run(DWORD act_type, void* param) PURE_METHOD;
    virtual DR_RESULT Update() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIViewFrustum : public drInterface
{
public:
    virtual void Update(const drMatrix44* mat_viewproj) PURE_METHOD;
    virtual drPlane* GetPlane(DWORD type) PURE_METHOD;
    virtual BOOL IsPointInFrustum(const drVector3* v) PURE_METHOD;
    virtual BOOL IsSphereInFrustum(const drSphere* s) PURE_METHOD;
    virtual BOOL IsSphereInFrustum(const drSphere* s, DWORD* last_check_plane) PURE_METHOD;
    virtual BOOL IsBoxInFrustum(const drBox* b, const drMatrix44* b_mat, DWORD* last_check_plane) PURE_METHOD;
    virtual float GetDistanceFromNearPlane(const drVector3* v) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drISceneMgr : public drInterface
{
public:
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual DR_RESULT BeginRender() PURE_METHOD;
    virtual DR_RESULT EndRender() PURE_METHOD;
    virtual DR_RESULT RenderTransparentPrimitive() PURE_METHOD;
    virtual DR_RESULT AddTransparentPrimitive(drIPrimitive *obj) PURE_METHOD;
    virtual DR_RESULT SortTransparentPrimitive() PURE_METHOD;
    virtual void SetTranspPrimitiveProc(drTranspPrimitiveProc proc, void* param) PURE_METHOD;
    virtual DR_RESULT CullPrimitive(drIPrimitive* obj) PURE_METHOD;
    virtual drIViewFrustum* GetViewFrustum() PURE_METHOD;
    virtual DWORD GetMaxSortNum() const PURE_METHOD;
    virtual void GetCullPrimitiveInfo(drCullPriInfo* info) PURE_METHOD;
    virtual drSceneFrameInfo* GetSceneFrameInfo() PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIAnimKeySetPRS : public drInterface
{
public:
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT GetValue(drMatrix44* mat, float frame) PURE_METHOD;
    virtual DR_RESULT AddKeyPosition(DWORD id, const drKeyVector3* data, DWORD num) PURE_METHOD;
    virtual DR_RESULT AddKeyRotation(DWORD id, const drKeyQuaternion* data, DWORD num) PURE_METHOD;
    virtual DR_RESULT AddKeyScale(DWORD id, const drKeyVector3* data, DWORD num);
    virtual DR_RESULT DelKeyPosition(DWORD id, DWORD num) PURE_METHOD;// if num == 0xffffffff(-1) then delete all sequence
    virtual DR_RESULT DelKeyRotation(DWORD id, DWORD num) PURE_METHOD;
    virtual DR_RESULT DelKeyScale(DWORD id, DWORD num) PURE_METHOD;
    virtual DWORD GetFrameNum() const PURE_METHOD;
    virtual DWORD GetKeyPositionNum() const PURE_METHOD;
    virtual DWORD GetKeyRotationNum() const PURE_METHOD;
    virtual DWORD GetKeyScaleNum() const PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIAnimKeySetFloat : public drInterface
{
public:
    virtual DR_RESULT Allocate(DWORD key_capacity) PURE_METHOD;
    virtual DR_RESULT Clear() PURE_METHOD;
    virtual DR_RESULT Clone(drIAnimKeySetFloat** obj) PURE_METHOD;
    virtual DR_RESULT SetKeyData(DWORD key, float data, DWORD slerp_type, DWORD mask) PURE_METHOD;
    virtual DR_RESULT GetKeyData(DWORD key, float* data, DWORD* slerp_type) PURE_METHOD;
    virtual DR_RESULT InsertKey(DWORD key, float data, DWORD slerp_type) PURE_METHOD;
    virtual DR_RESULT RemoveKey(DWORD key) PURE_METHOD;
    virtual DR_RESULT GetValue(float* data, float key) PURE_METHOD;
    virtual DR_RESULT SetKeySequence(const drKeyFloat* seq, DWORD num) PURE_METHOD;
    virtual drKeyFloat* GetKeySequence() PURE_METHOD;
    virtual DWORD GetKeyNum() PURE_METHOD;
    virtual DWORD GetKeyCapacity() PURE_METHOD;
    virtual DWORD GetBeginKey() PURE_METHOD;
    virtual DWORD GetEndKey() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drINode : public drInterface
{
public:
    // base method
    virtual void SetID(DWORD id) PURE_METHOD;
    virtual void SetLinkID(DWORD id) PURE_METHOD;
    virtual void SetParentLinkID(DWORD id) PURE_METHOD;
    virtual void SetLocalMatrix(const drMatrix44* mat) PURE_METHOD;
    virtual void SetDescriptor(const char* str64) PURE_METHOD;
    virtual DR_RESULT SetParent(drINode* parent) PURE_METHOD;
    virtual DWORD GetType() const PURE_METHOD;
    virtual DWORD GetID() const PURE_METHOD;
    virtual drMatrix44* GetLocalMatrix() PURE_METHOD;
    virtual drMatrix44* GetWorldMatrix() PURE_METHOD;
    virtual char* GetDescriptor() PURE_METHOD;
    virtual drINode* GetParent() const PURE_METHOD;
    virtual DWORD GetLinkID() const PURE_METHOD;
    virtual DWORD GetParentLinkID() const PURE_METHOD;
    virtual drIByteSet* GetStateSet() PURE_METHOD;
    virtual DR_RESULT GetLinkMatrix(drMatrix44* mat, DWORD link_id) PURE_METHOD;
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drINodePrimitive : public drINode
{
public:
    // primitive method
    virtual void SetMeshAgent(drIMeshAgent* agent) PURE_METHOD;
    virtual void SetMtlTexAgent(DWORD subset, drIMtlTexAgent* agent) PURE_METHOD;
    virtual void SetAnimCtrlAgent(drIAnimCtrlAgent* agent) PURE_METHOD;
    virtual void SetRenderCtrl(drIRenderCtrlAgent* obj) PURE_METHOD;
    virtual void SetHelperObject(drIHelperObject* obj) PURE_METHOD;
    virtual void SetMaterial(const drMaterial* mtl) PURE_METHOD;
    virtual void SetOpacity(float opacity) PURE_METHOD;
    //virtual DR_RESULT SetVertexBlendCtrl(drINodeBoneCtrl* ctrl) PURE_METHOD;

    virtual drIResourceMgr* GetResourceMgr() PURE_METHOD;
    virtual drIMtlTexAgent* GetMtlTexAgent(DWORD id) PURE_METHOD;
    virtual drIMeshAgent* GetMeshAgent() PURE_METHOD;
    virtual drIAnimCtrlAgent* GetAnimCtrlAgent() PURE_METHOD;
    virtual drIRenderCtrlAgent* GetRenderCtrlAgent() PURE_METHOD;
    virtual drIHelperObject* GetHelperObject() PURE_METHOD;
    //virtual drINodeBoneCtrl* GetVertexBlendCtrl() PURE_METHOD;
    virtual DR_RESULT AllocateMtlTexAgentSeq(DWORD num) PURE_METHOD;
    virtual DWORD GetMtlTexAgentSeqSize() const PURE_METHOD;
    virtual DR_RESULT GetSubsetNum(DWORD* subset_num) PURE_METHOD;

    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Load(drIGeomObjInfo* info, const char* tex_path, const drResFile* res) PURE_METHOD;
    virtual DR_RESULT LoadMesh(drMeshInfo* info) PURE_METHOD;
    virtual DR_RESULT LoadMtlTex(DWORD mtl_id, drMtlTexInfo* info, const char* tex_path) PURE_METHOD;
    virtual DR_RESULT LoadAnimData(drIAnimDataInfo* info, const char* tex_path, const drResFile* res) PURE_METHOD;
    virtual DR_RESULT LoadRenderCtrl(const drRenderCtrlCreateInfo* rcci) PURE_METHOD;
    virtual DR_RESULT Copy(drINodePrimitive* src_obj) PURE_METHOD;

    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
    virtual DR_RESULT RenderSubset(DWORD subset) PURE_METHOD;
    virtual DR_RESULT RenderHelperObject() PURE_METHOD;

    virtual DR_RESULT HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drINodeBoneCtrl : public drINode
{
public:
    virtual DR_RESULT Load(drIAnimDataBone* data) PURE_METHOD;
    virtual DR_RESULT PlayPose(const drPlayPoseInfo* info) PURE_METHOD;
    virtual void SetAnimCtrlObj(drIAnimCtrlObjBone* ctrl_obj) PURE_METHOD;
    virtual drIAnimCtrlObjBone* GetAnimCtrlObj() PURE_METHOD;
    virtual drIPoseCtrl* GetPoseCtrl() PURE_METHOD;
    virtual drPlayPoseInfo* GetPlayPoseInfo() PURE_METHOD;


};

class DR_DECLSPEC_NOVTABLE drINodeDummy : public drINode
{
public:
    virtual DR_RESULT Load(drIHelperDummyObjInfo* data) PURE_METHOD;
    virtual void SetAnimCtrlObj(drIAnimCtrlObjMat* ctrl_obj) PURE_METHOD;
    virtual drIAnimCtrlObjMat* GetAnimCtrlObj() PURE_METHOD;
    virtual DR_RESULT CreateAssistantObject(const drVector3* size, DWORD color) PURE_METHOD;
    virtual drINodePrimitive* GetAssistantObject() PURE_METHOD;


};
class DR_DECLSPEC_NOVTABLE drINodeHelper : public drINode
{
public:

};

enum
{
	MAX_IGNORE_NODES	= 32
};

struct IgnoreStruct
{
	drITreeNode* nodes[MAX_IGNORE_NODES];
};

class DR_DECLSPEC_NOVTABLE drINodeObject : public drInterface
{
public:
    virtual DR_RESULT Update() PURE_METHOD;
    virtual DR_RESULT Render() PURE_METHOD;
	virtual DR_RESULT IgnoreNodesRender( const IgnoreStruct* is ) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT CullPrimitive() PURE_METHOD;
    virtual void SetName(const char* name) PURE_METHOD;
    virtual void SetMatrix(const drMatrix44* mat) PURE_METHOD;
    virtual char* GetName() PURE_METHOD;
    virtual drMatrix44* GetMatrix() PURE_METHOD;
    virtual drIByteSet* GetStateSet() PURE_METHOD;
    virtual drITreeNode* GetTreeNodeRoot() PURE_METHOD;
    virtual DR_RESULT QueryTreeNode(drModelNodeQueryInfo* info) PURE_METHOD;
    virtual DR_RESULT InsertTreeNode(drITreeNode* parent_node, drITreeNode* prev_node, drITreeNode* node) PURE_METHOD;
    virtual DR_RESULT RemoveTreeNode(drITreeNode* node) PURE_METHOD;
    virtual DR_RESULT Load(const char* file, DWORD flag, drITreeNode* parent_node) PURE_METHOD;

};


class DR_DECLSPEC_NOVTABLE drITreeNode : public drInterface
{
public:
    virtual DR_RESULT EnumTree(drTreeNodeEnumProc proc, void* param, DWORD enum_type) PURE_METHOD;
    virtual DR_RESULT InsertChild(drITreeNode* prev_node, drITreeNode* node) PURE_METHOD;
    virtual DR_RESULT RemoveChild(drITreeNode* node) PURE_METHOD;
    virtual drITreeNode* FindNode(drITreeNode* node) PURE_METHOD;
    virtual drITreeNode* FindNode(void* data) PURE_METHOD;
    virtual void SetParent(drITreeNode* node) PURE_METHOD;
    virtual void SetChild(drITreeNode* node) PURE_METHOD;
    virtual void SetSibling(drITreeNode* node) PURE_METHOD;
    virtual void SetData(void* data) PURE_METHOD;
    virtual drITreeNode* GetParent() PURE_METHOD;
    virtual drITreeNode* GetChild() PURE_METHOD;
    virtual drITreeNode* GetChild(DWORD id) PURE_METHOD;
    virtual drITreeNode* GetSibling() PURE_METHOD;
    virtual void* GetData() PURE_METHOD;
    virtual DWORD GetNodeNum() const PURE_METHOD;
    virtual DWORD GetChildNum() const PURE_METHOD;
    virtual DWORD GetDepthLevel() const PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIRenderStateAtomSet : public drInterface
{
public:
    virtual DR_RESULT Allocate(DWORD size) PURE_METHOD;
    virtual DR_RESULT Clear() PURE_METHOD;
    virtual DR_RESULT Clone(drIRenderStateAtomSet** obj) PURE_METHOD;
    virtual DR_RESULT Load(const drRenderStateAtom* rsa_seq, DWORD rsa_num) PURE_METHOD;
    virtual DR_RESULT FindState(DWORD* id, DWORD state) PURE_METHOD;
    virtual DR_RESULT ResetStateValue(DWORD state, DWORD value, DWORD* old_value) PURE_METHOD;
	virtual DR_RESULT AddStateToSet(DWORD state, DWORD value) PURE_METHOD; //添加 RenderState 如果渲染状态表满了，则返回失败，最多8个 
    virtual DR_RESULT SetStateValue(DWORD id, DWORD state, DWORD value) PURE_METHOD;
    virtual DR_RESULT SetStateValue(DWORD id, drRenderStateAtom* buf, DWORD num) PURE_METHOD;
    virtual DR_RESULT BeginRenderState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num) PURE_METHOD;
    virtual DR_RESULT BeginTextureStageState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage) PURE_METHOD;
    virtual DR_RESULT BeginSamplerState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage) PURE_METHOD;
    virtual DR_RESULT EndRenderState(drIDeviceObject* dev_obj, DWORD  start_id, DWORD num) PURE_METHOD;
    virtual DR_RESULT EndTextureStageState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage) PURE_METHOD;
    virtual DR_RESULT EndSamplerState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage) PURE_METHOD;
    virtual DWORD GetStateNum() const PURE_METHOD;
    virtual drRenderStateAtom* GetStateSeq() PURE_METHOD;
    virtual DR_RESULT GetStateAtom(drRenderStateAtom** rsa, DWORD id) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drITimer : public drInterface
{
public:
    virtual DR_RESULT OnTimer() PURE_METHOD;
    virtual DR_RESULT SetTimer(DWORD id, drTimerProc proc, DWORD interval, DWORD hit_type, DWORD hit_add_cnt) PURE_METHOD;
    virtual DR_RESULT SetTimerInterval(DWORD id, DWORD interval) PURE_METHOD;
    virtual DWORD GetLastInvokeTime(DWORD id) PURE_METHOD;
    virtual DR_RESULT Pause(DWORD id, DWORD flag) PURE_METHOD; // id == DR_INVALID_INDEX : all
    virtual DR_RESULT ResetTimer(DWORD id) PURE_METHOD; // id == DR_INVALID_INDEX : all
    virtual DR_RESULT ClearTimer(DWORD id) PURE_METHOD; // id == DR_INVALID_INDEX : all
    virtual DR_RESULT ReallocTimerSeq(DWORD size) PURE_METHOD;
    virtual DWORD GetTimerTickCount() PURE_METHOD;
    virtual DWORD GetTickCount() PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drITimerThread : public drInterface
{
public:
    virtual DR_RESULT AllocateTimerSeq(DWORD size) PURE_METHOD;
    virtual DR_RESULT SetTimer(DWORD id, drTimerProc proc, DWORD interval) PURE_METHOD;
    virtual DR_RESULT SetTimerInterval(DWORD id, DWORD interval) PURE_METHOD;
    virtual DR_RESULT Pause(DWORD id, DWORD flag) PURE_METHOD; // id == DR_INVALID_INDEX : all
    virtual DR_RESULT ClearTimer(DWORD id, DWORD delay) PURE_METHOD; // id == DR_INVALID_INDEX : all
};

class DR_DECLSPEC_NOVTABLE drITimerPeriod : public drInterface
{
public:
    virtual DR_RESULT SetEvent(UINT delay, UINT resolution, LPTIMECALLBACK proc, DWORD_PTR param, UINT event) PURE_METHOD;
    virtual DR_RESULT KillEvent() PURE_METHOD;
    virtual UINT GetTimerID() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIFile : public drInterface
{
public:
    virtual DR_RESULT CreateFile(const char* file,DWORD access_flag, DWORD share_mode, LPSECURITY_ATTRIBUTES secu_attr, DWORD creation_flag, DWORD attributes_flag = FILE_FLAG_SEQUENTIAL_SCAN) PURE_METHOD;
    virtual DR_RESULT CreateDirectory(const char* path, LPSECURITY_ATTRIBUTES attr) PURE_METHOD;
    virtual DR_RESULT LoadFileBuffer(const char* file, drIBuffer* buf) PURE_METHOD;
    virtual DR_RESULT SaveFileBuffer(const char* file, drIBuffer* buf) PURE_METHOD;
    virtual DR_RESULT Close() PURE_METHOD;
    virtual DR_RESULT Read(void* buf, DWORD in_size, DWORD* out_size) PURE_METHOD;
    virtual DR_RESULT Write(const void* buf, DWORD in_size, DWORD* out_size) PURE_METHOD;

    virtual HANDLE GetHandle() const PURE_METHOD;
    virtual const char* GetFileName() PURE_METHOD;
    virtual DR_RESULT GetCreationTime(SYSTEMTIME* st) PURE_METHOD;
    virtual DR_RESULT CheckExisting(const char* path, DWORD check_directory) PURE_METHOD;

    // Seek Description
    // flag[in]: FILE_BEGIN / FILE_CURRENT / FILE_END
    virtual DR_RESULT Seek(long offset, DWORD flag) PURE_METHOD;
    virtual DWORD GetSize() PURE_METHOD;
    virtual DR_RESULT Flush() PURE_METHOD;
    virtual DR_RESULT SetEnd() PURE_METHOD;

    virtual DR_RESULT MoveData(DWORD src_pos, DWORD dst_pos, DWORD size) PURE_METHOD;
    virtual DR_RESULT ReplaceData(DWORD pos, const void* buf, DWORD size) PURE_METHOD;
    virtual DR_RESULT InsertData(DWORD pos, const void* buf, DWORD size) PURE_METHOD;
    virtual DR_RESULT RemoveData(DWORD pos, DWORD size) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIFileDialog : public drInterface
{
public:
    // int flag = OFN_PATHMUSTEXIST | OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_ALLOWMULTISELECT | OFN_HIDEREADONLY
    virtual DR_RESULT GetOpenFileName(HWND hwnd, char* buf, int num, const char* dir, const char* title = 0,
                               const char* filter = "all files(*.*)\0*.*\0\0", int flag = OFN_PATHMUSTEXIST | OFN_EXPLORER) PURE_METHOD;

    // flag = OFN_FILEMUSTEXIST | OFN_ALLOWMULTISELECT | OFN_HIDEREADONLY
    virtual DR_RESULT GetSaveFileName(HWND hwnd, char* buf, int num, const char* dir, const char* title = 0,
                               const char* filter = "all files(*.*)\0*.*\0\0",const char* ext = 0, int flag = OFN_PATHMUSTEXIST | OFN_EXPLORER) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIDDSFile : public drInterface
{
public:
    virtual void SetDevice(IDirect3DDeviceX* dev) PURE_METHOD;
    virtual DR_RESULT Clear() PURE_METHOD;
    virtual DR_RESULT LoadOriginTexture(const char* file, DWORD mip_level, D3DFORMAT format, DWORD colorkey) PURE_METHOD;
    virtual DR_RESULT Convert(const char* file, D3DFORMAT src_fmt, D3DFORMAT dds_fmt, DWORD mip_level, DWORD src_colorkey) PURE_METHOD;
    virtual DR_RESULT Save(const char* file) PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drIDirectoryBrowser : public drInterface
{
public:
    virtual void SetBrowseProc(drDirectoryBrowserProc proc, void* param) PURE_METHOD;
    virtual DR_RESULT Browse(const char *file, DWORD flag) PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIConsole : public drInterface
{
public:
    virtual DR_RESULT Alloc() PURE_METHOD;
    virtual DR_RESULT Create(DWORD desired_access = GENERIC_READ|GENERIC_WRITE, DWORD share_mode = 0, const SECURITY_ATTRIBUTES* security_attr = 0) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Write(const char* str, ...) PURE_METHOD;
    virtual DR_RESULT SetBufferSize(DWORD row, DWORD column) PURE_METHOD;
    virtual HANDLE GetHandle() const PURE_METHOD;
    virtual BOOL SetActive() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIThreadPool : public drInterface
{
public:
    virtual DR_RESULT Create(DWORD thread_seq_size, DWORD task_seq_size, DWORD suspend_flag) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT RegisterTask(drThreadProc proc, void* param) PURE_METHOD;
    virtual DR_RESULT RemoveTask(drThreadProc proc, void* param) PURE_METHOD;
    virtual DR_RESULT FindTask(drThreadProc proc, void* param) PURE_METHOD;
    virtual DR_RESULT SuspendThread() PURE_METHOD;
    virtual DR_RESULT ResumeThread() PURE_METHOD;
    virtual DR_RESULT SetPriority(int priority) PURE_METHOD;
    virtual DR_RESULT SetPoolEvent(BOOL lock_flag) PURE_METHOD;
    virtual int GetPriority() const PURE_METHOD;
    virtual DWORD GetCurrentWaitingTaskNum() const PURE_METHOD;
    virtual DWORD GetCurrentRunningTaskNum() const PURE_METHOD;
    virtual DWORD GetCurrentIdleThreadNum() const PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIVertexBuffer : public drInterface
{
public:
    virtual DR_RESULT Create(UINT length, DWORD usage, DWORD fvf, D3DPOOL pool, DWORD stride, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Lock(UINT offset, UINT size, D3DLOCK_TYPE **out_data, DWORD flag) PURE_METHOD;
    virtual DR_RESULT Unlock() PURE_METHOD;
    virtual DR_RESULT LoadData(const void* data_seq, DWORD data_size, UINT offset, DWORD lock_flag) PURE_METHOD;
    virtual DR_RESULT LoadDataDynamic(const void* data_seq, DWORD data_size) PURE_METHOD;
    virtual DR_RESULT BindDevice(DWORD stream_id, UINT offset_byte) PURE_METHOD;
    virtual DR_RESULT SetDeviceFVF() PURE_METHOD;
    virtual drVertexBufferInfo* GetBufferInfo() PURE_METHOD;
    virtual IDirect3DVertexBufferX* GetStreamBuffer() PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIIndexBuffer : public drInterface
{
public:
    virtual DR_RESULT Create(UINT length, DWORD usage, D3DFORMAT format, D3DPOOL pool, HANDLE* handle) PURE_METHOD;
    virtual DR_RESULT Destroy() PURE_METHOD;
    virtual DR_RESULT Lock(UINT offset, UINT size, D3DLOCK_TYPE **out_data, DWORD flag) PURE_METHOD;
    virtual DR_RESULT Unlock() PURE_METHOD;
    virtual DR_RESULT LoadData(const void* data_seq, DWORD data_size, UINT offset, DWORD lock_flag) PURE_METHOD;
    virtual DR_RESULT LoadDataDynamic(const void* data_seq, DWORD data_size) PURE_METHOD;
    virtual DR_RESULT BindDevice() PURE_METHOD;
    virtual drIndexBufferInfo* GetBufferInfo() PURE_METHOD;
    virtual IDirect3DIndexBufferX* GetStreamBuffer() PURE_METHOD;
};
class DR_DECLSPEC_NOVTABLE drITextFileLoader : public drInterface
{
public:
	virtual DR_RESULT Load(const char* file) PURE_METHOD;
	virtual DR_RESULT Close() PURE_METHOD;
    virtual DR_RESULT Eof() const PURE_METHOD;
	virtual DR_RESULT SeekWord(const char* str,const char* termi=0) PURE_METHOD;
	virtual int SkipSpace() PURE_METHOD;
	virtual int SkipLine(int num=1) PURE_METHOD;
	virtual int SkipWord(int num=1) PURE_METHOD;
	virtual char* GetWord(char* buf,int be_remove=1) PURE_METHOD;
	virtual char* GetLine(char* buf,int len=256) PURE_METHOD;	
	virtual int GetWordSeq(char* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(short* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(int* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(long* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(float* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(double* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(char** buf,int num) PURE_METHOD;
	virtual int GetWordSeq(unsigned int* buf,int num) PURE_METHOD;
	virtual int GetWordSeq(unsigned long* buf,int num) PURE_METHOD;
    virtual int GetStringChunk(char* buf,int len,const char* termi) PURE_METHOD;
    virtual int GetIntWithStrHex() PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drISystemInfo : public drInterface
{
public:
    virtual DR_RESULT CheckDirectXVersion() PURE_METHOD;
    virtual DWORD GetDirectXVersion() PURE_METHOD;
    virtual DR_RESULT GetDirectXVersion(drDxVerInfo* o_info) PURE_METHOD;

};

class DR_DECLSPEC_NOVTABLE drIRenderCtrlVS : public drInterface
{
public:
    virtual DWORD GetType() PURE_METHOD;
    virtual DR_RESULT Clone(drIRenderCtrlVS** obj) PURE_METHOD;
    virtual DR_RESULT Initialize(drIRenderCtrlAgent* agent) PURE_METHOD;
    virtual DR_RESULT BeginSet(drIRenderCtrlAgent* agent) PURE_METHOD;
    virtual DR_RESULT EndSet(drIRenderCtrlAgent* agent) PURE_METHOD;
    virtual DR_RESULT BeginSetSubset(DWORD subset, drIRenderCtrlAgent* agent) PURE_METHOD;
    virtual DR_RESULT EndSetSubset(DWORD subset, drIRenderCtrlAgent* agent) PURE_METHOD;
	virtual void setPixelShader( const std::string& filename )
	{
	}
};

class DR_DECLSPEC_NOVTABLE drIBuffer : public drInterface
{
public:
    virtual DR_RESULT Alloc(DWORD size) PURE_METHOD;
    virtual DR_RESULT Realloc(DWORD size) PURE_METHOD;
    virtual DR_RESULT Free() PURE_METHOD;
    virtual DR_RESULT SetSizeArbitrary(DWORD size) PURE_METHOD;
    virtual BYTE* GetData() PURE_METHOD;
    virtual DWORD GetSize() PURE_METHOD;
};

class DR_DECLSPEC_NOVTABLE drIMeshInfoEx : public drInterface
{
public:
    virtual DR_RESULT Clear() PURE_METHOD;
    virtual DR_RESULT Clone(drIMeshInfoEx** info) PURE_METHOD;
    virtual DR_RESULT SetFVF(DWORD fvf) PURE_METHOD;
    virtual DR_RESULT SetPrimitiveType(D3DPRIMITIVETYPE pt_type) PURE_METHOD;
    virtual DR_RESULT SetVertexElement(const D3DVERTEXELEMENTX* data_seq) PURE_METHOD;
    virtual DR_RESULT SetBoneInfluenceFactor(DWORD factor) PURE_METHOD;
    virtual DR_RESULT SetRenderStateAtom(drIRenderStateAtomSet* rsa) PURE_METHOD;
    virtual DR_RESULT SetVertexSequence(DWORD stream_id, const drVector3* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetNormalSequence(DWORD stream_id, const drVector3* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetColorSequence(DWORD stream_id, const drColorValue4f* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetTexcoordSequence(DWORD stream_id, const drVector2* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetIndexSequence(DWORD stream_id, const DWORD* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetSubsetSequence(DWORD stream_id, const drSubsetInfo* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetVertexBlendSequence(const drBlendInfo* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT SetBoneIndexSequence(const DWORD* data_seq, DWORD data_num) PURE_METHOD;
    virtual DR_RESULT GetDataType(DWORD* type) PURE_METHOD;
    virtual DR_RESULT GetFVF(DWORD* fvf) PURE_METHOD;
    virtual DR_RESULT GetPrimitiveType(D3DPRIMITIVETYPE* type) PURE_METHOD;
    virtual DR_RESULT GetBoneInfluenceFactor(DWORD* factor) PURE_METHOD;
    virtual DR_RESULT GetVertexElement(D3DVERTEXELEMENTX** desc) PURE_METHOD;
    virtual DR_RESULT GetRenderStateAtom(drIRenderStateAtomSet** rsa) PURE_METHOD;
    virtual DR_RESULT GetVertexSequence(drVector3** data_seq, DWORD* data_num, DWORD stream_id) PURE_METHOD;
    virtual DR_RESULT GetNormalSequence(drVector3** data_seq, DWORD* data_num, DWORD stream_id) PURE_METHOD;
    virtual DR_RESULT GetColorSequence(drColorValue4f** data_seq, DWORD* data_num, DWORD stream_id) PURE_METHOD;
    virtual DR_RESULT GetTexCoordSequence(drVector2** data_seq, DWORD* data_num, DWORD stream_id) PURE_METHOD;
    virtual DR_RESULT GetIndexSequence(DWORD** data_seq, DWORD* data_num, DWORD stream_id) PURE_METHOD;
    virtual DR_RESULT GetSubsetSequence(drSubsetInfo** data_seq, DWORD* data_num, DWORD stream_id) PURE_METHOD;
    virtual DR_RESULT GetVertexBlendSequence(drBlendInfo** data_seq, DWORD* data_num) PURE_METHOD;
    virtual DR_RESULT GetBoneIndexSequence(DWORD** data_seq, DWORD* data_num) PURE_METHOD;
    virtual DR_RESULT LoadFile(drIFileStream* fs) PURE_METHOD;
    virtual DR_RESULT SaveFile(drIFileStream* fs) PURE_METHOD;
    virtual DR_RESULT DumpData(const char* file) PURE_METHOD;


};
class DR_DECLSPEC_NOVTABLE drICoordinateSys : public drInterface
{
public:
    virtual DR_RESULT SetActiveCoordSys(DWORD id) PURE_METHOD;
    virtual DR_RESULT SetCoordSysMatrix(DWORD id, const drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT GetCoordSysMatrix(DWORD id, drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT GetCurCoordSysMatrix(drMatrix44* mat) PURE_METHOD;
    virtual DR_RESULT GetActiveCoordSys(DWORD* id) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIHeap : public drInterface
{
public:
    virtual DR_RESULT Reserve(DWORD size) PURE_METHOD;
    virtual DR_RESULT Clear() PURE_METHOD;
    virtual DR_RESULT Push(const void* t) PURE_METHOD;
    virtual DR_RESULT Push(const void* buf, DWORD size) PURE_METHOD;
    virtual DR_RESULT Pop() PURE_METHOD;
    virtual DR_RESULT Top(void** t) PURE_METHOD;
    virtual DR_RESULT Find(DWORD* id, const void* t) PURE_METHOD;
    virtual DR_RESULT Update(DWORD id) PURE_METHOD;
    virtual DR_RESULT Remove(DWORD id) PURE_METHOD;
    virtual void SetCompareProc(drHeapCompProc proc) PURE_METHOD; 
    virtual void SetFilterProc(drHeapFilterProc proc) PURE_METHOD; 
    virtual drHeapCompProc GetCompareProc() PURE_METHOD; 
    virtual drHeapFilterProc GetFilterProc() PURE_METHOD; 
    virtual DWORD GetHeapNum() PURE_METHOD;
    virtual DWORD GetHeapCapacity() PURE_METHOD;
    virtual void* GetBuffer() PURE_METHOD;
    virtual DR_RESULT Clone(drIHeap** out_heap) PURE_METHOD;

};
class DR_DECLSPEC_NOVTABLE drIFileStream : public drInterface
{
public:
    virtual DR_RESULT Open(const char* file, const drFileStreamOpenInfo* info) PURE_METHOD;
    virtual DR_RESULT Close() PURE_METHOD;
    virtual DR_RESULT Read(void* buf, DWORD in_size, DWORD* out_size) PURE_METHOD;
    virtual DR_RESULT Write(const void* buf, DWORD in_size, DWORD* out_size) PURE_METHOD;
    virtual DR_RESULT Seek(DWORD* pos, long offset, DWORD flag) PURE_METHOD;
    virtual DR_RESULT GetSize(DWORD* size) PURE_METHOD;
    virtual DR_RESULT Flush() PURE_METHOD;
    virtual DR_RESULT SetEnd() PURE_METHOD;
};

DR_END