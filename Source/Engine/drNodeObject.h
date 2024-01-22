//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drMath.h"
#include "drExpObj.h"
#include "drITypes.h"
#include "drMisc.h"
#include "drInterfaceExt.h"

//////////////
//
DR_BEGIN

class drNodeBase
{
protected:
    // base
    DWORD _type;
    DWORD _id;
    char _descriptor[64];
    drMatrix44 _mat_local;
    drMatrix44 _mat_world;
    drByteSet _state_set;

    // link state
    drINode* _parent;
    DWORD _link_parent_id;
    DWORD _link_id;

protected:
    //DR_RESULT _UpdateMatrix();
    BOOL _CheckVisibleState() { return _state_set.GetValue(STATE_VISIBLE); }
public:
    drNodeBase();
    //~drNodeBase();
};

class drNodePrimitive : public drNodeBase, public drINodePrimitive
{
    DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drIMeshAgent* _mesh_agent;
    drIMtlTexAgent** _mtltex_agent_seq;
    drIAnimCtrlAgent* _anim_agent;
    drIRenderCtrlAgent* _render_agent;
    drIHelperObject* _helper_object;
    //drINodeBoneCtrl* _vertex_blend_ctrl;
    drIAnimCtrlObjBone* _ref_ctrl_obj_bone;

    DWORD _mtltex_agent_seqsize;

private:
    DR_RESULT _DestroyMtlTexAgent();
    DR_RESULT _UpdateBoundingObject(drIAnimCtrlObjBone* ctrl_obj);
    DR_RESULT _UpdateTransparentState();

public:
    drNodePrimitive(drIResourceMgr* res_mgr);
    virtual ~drNodePrimitive();

    // base method
    void SetID(DWORD id) { _id = id; }
    void SetLinkID(DWORD id) { _link_id = id; }
    void SetParentLinkID(DWORD id) { _link_parent_id = id; }
    DR_RESULT SetParent(drINode* parent);
    void SetLocalMatrix(const drMatrix44* mat) { _mat_local = *mat; }
    void SetDescriptor(const char* str64) { _tcsncpy_s(_descriptor, str64, _TRUNCATE ); }
    DWORD GetType() const { return _type; }
    DWORD GetID() const { return _id; }
    drMatrix44* GetLocalMatrix() { return &_mat_local; }
    drMatrix44* GetWorldMatrix() { return &_mat_world; }
    char* GetDescriptor() { return _descriptor; }
    drINode* GetParent() const { return _parent; }
    DWORD GetLinkID() const { return _link_id; }
    DWORD GetParentLinkID() const { return _link_parent_id; }
    drIByteSet* GetStateSet() { return &_state_set; }
    DR_RESULT GetLinkMatrix(drMatrix44* mat, DWORD link_id);
    
    // primitive method
    void SetMeshAgent(drIMeshAgent* agent) { _mesh_agent = agent; }
    void SetMtlTexAgent(DWORD subset, drIMtlTexAgent* agent) { _mtltex_agent_seq[subset] = agent; }
    void SetAnimCtrlAgent(drIAnimCtrlAgent* agent) { _anim_agent = agent; }
    void SetRenderCtrl(drIRenderCtrlAgent* obj) { _render_agent = obj; }
    void SetHelperObject(drIHelperObject* obj) { _helper_object = obj; }
    void SetMaterial(const drMaterial* mtl);
    void SetOpacity(float opacity);
    //DR_RESULT SetVertexBlendCtrl(drINodeBoneCtrl* ctrl);

    drIResourceMgr* GetResourceMgr() { return _res_mgr; }
    drIMtlTexAgent* GetMtlTexAgent(DWORD id) { return _mtltex_agent_seq[id]; }
    drIMeshAgent* GetMeshAgent() { return _mesh_agent; }
    drIAnimCtrlAgent* GetAnimCtrlAgent() { return _anim_agent; }
    drIRenderCtrlAgent* GetRenderCtrlAgent() { return _render_agent; }
    drIHelperObject* GetHelperObject() { return _helper_object; }
    //drINodeBoneCtrl* GetVertexBlendCtrl() { return _vertex_blend_ctrl; }
    DR_RESULT AllocateMtlTexAgentSeq(DWORD num);
    DWORD GetMtlTexAgentSeqSize() const { return _mtltex_agent_seqsize; }
    DR_RESULT GetSubsetNum(DWORD* subset_num);


    DR_RESULT Destroy();
    DR_RESULT Load(drIGeomObjInfo* info, const char* tex_path, const drResFile* res);
    DR_RESULT LoadMesh(drMeshInfo* info);
    DR_RESULT LoadMtlTex(DWORD mtl_id, drMtlTexInfo* info, const char* tex_path);
    DR_RESULT LoadAnimData(drIAnimDataInfo* info, const char* tex_path, const drResFile* res);
    DR_RESULT LoadRenderCtrl(const drRenderCtrlCreateInfo* rcci);
    DR_RESULT Copy(drINodePrimitive* src_obj);

    DR_RESULT Update();
    DR_RESULT Render();
    DR_RESULT RenderSubset(DWORD subset);
    DR_RESULT RenderHelperObject();


    DR_RESULT HitTest(drPickInfo* info, const drVector3* org, const drVector3* ray);

};

class drNodeBoneCtrl : public drNodeBase, public drINodeBoneCtrl
{
    DR_STD_DECLARATION()
private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlObjBone* _ctrl_obj;

public:
    drNodeBoneCtrl(drIResourceMgr* res_mgr);
    ~drNodeBoneCtrl();

    // base method
    void SetID(DWORD id) { _id = id; }
    void SetLinkID(DWORD id) { _link_id = id; }
    void SetParentLinkID(DWORD id) { _link_parent_id = id; }
    DR_RESULT SetParent(drINode* parent) { _parent = parent; return DR_RET_OK; }
    void SetLocalMatrix(const drMatrix44* mat) { _mat_local = *mat; }
    void SetDescriptor(const char* str64) { _tcsncpy_s(_descriptor, str64, _TRUNCATE); }
    void SetAnimCtrlObj(drIAnimCtrlObjBone* ctrl_obj) { _ctrl_obj = ctrl_obj; }
    DWORD GetType() const { return _type; }
    DWORD GetID() const { return _id; }
    drMatrix44* GetLocalMatrix() { return &_mat_local; }
    drMatrix44* GetWorldMatrix() { return &_mat_world; }
    char* GetDescriptor() { return _descriptor; }
    drINode* GetParent() const { return _parent; }
    DWORD GetLinkID() const { return _link_id; }
    DWORD GetParentLinkID() const { return _link_parent_id; }
    drIByteSet* GetStateSet() { return &_state_set; }
    drIAnimCtrlObjBone* GetAnimCtrlObj() { return _ctrl_obj; }
    DR_RESULT GetLinkMatrix(drMatrix44* mat, DWORD link_id);
    DR_RESULT Update();
    DR_RESULT Render() { return DR_RET_OK; }

    DR_RESULT Load(drIAnimDataBone* data);
    
    DR_RESULT PlayPose(const drPlayPoseInfo* info);
    drIPoseCtrl* GetPoseCtrl();
    drPlayPoseInfo* GetPlayPoseInfo();

};

class drNodeDummy : public drNodeBase, public drINodeDummy
{
    DR_STD_DECLARATION()
private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlObjMat* _ctrl_obj;
    drINodePrimitive* _ass_obj;

public:
    drNodeDummy(drIResourceMgr* res_mgr);
    ~drNodeDummy();

    // base method
    void SetID(DWORD id) { _id = id; }
    void SetLinkID(DWORD id) { _link_id = id; }
    void SetParentLinkID(DWORD id) { _link_parent_id = id; }
    DR_RESULT SetParent(drINode* parent) { _parent = parent; return DR_RET_OK; }
    void SetLocalMatrix(const drMatrix44* mat) { _mat_local = *mat; }
    void SetDescriptor(const char* str64) { _tcsncpy_s(_descriptor, str64, _TRUNCATE ); }
    void SetAnimCtrlObj(drIAnimCtrlObjMat* ctrl_obj) { _ctrl_obj = ctrl_obj; }
    DWORD GetType() const { return _type; }
    DWORD GetID() const { return _id; }
    drMatrix44* GetLocalMatrix() { return &_mat_local; }
    drMatrix44* GetWorldMatrix() { return &_mat_world; }
    char* GetDescriptor() { return _descriptor; }
    drINode* GetParent() const { return _parent; }
    DWORD GetLinkID() const { return _link_id; }
    DWORD GetParentLinkID() const { return _link_parent_id; }
    drIByteSet* GetStateSet() { return &_state_set; }
    DR_RESULT GetLinkMatrix(drMatrix44* mat, DWORD link_id);
    drIAnimCtrlObjMat* GetAnimCtrlObj() { return _ctrl_obj; }

    DR_RESULT Update();
    DR_RESULT Render();

    DR_RESULT Load(drIHelperDummyObjInfo* data);
    DR_RESULT CreateAssistantObject(const drVector3* size, DWORD color);
    drINodePrimitive* GetAssistantObject() { return _ass_obj; }

};

class drNodeHelper : public drNodeBase, public drINodeHelper
{
DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;

    drIHelperDummy* _obj_dummy;
    drIHelperBox* _obj_box;
    drIHelperMesh* _obj_mesh;

public:
    drNodeHelper(drIResourceMgr* mgr);
    ~drNodeHelper();

    // base method
    void SetID(DWORD id) { _id = id; }
    void SetLinkID(DWORD id) { _link_id = id; }
    void SetParentLinkID(DWORD id) { _link_parent_id = id; }
    DR_RESULT SetParent(drINode* parent) { _parent = parent; return DR_RET_OK; }
    void SetLocalMatrix(const drMatrix44* mat) { _mat_local = *mat; }
    void SetDescriptor(const char* str64) { _tcsncpy_s(_descriptor, str64, _TRUNCATE); }
    DWORD GetType() const { return _type; }
    DWORD GetID() const { return _id; }
    drMatrix44* GetLocalMatrix() { return &_mat_local; }
    drMatrix44* GetWorldMatrix() { return &_mat_world; }
    char* GetDescriptor() { return _descriptor; }
    drINode* GetParent() const { return _parent; }
    DWORD GetLinkID() const { return _link_id; }
    DWORD GetParentLinkID() const { return _link_parent_id; }
    drIByteSet* GetStateSet() { return &_state_set; }
    DR_RESULT GetLinkMatrix(drMatrix44* mat, DWORD link_id);
    DR_RESULT Update();
    DR_RESULT Render();

    // helper object method
    DR_RESULT LoadHelperInfo(const drHelperInfo* info, int create_instance_flag);
    DR_RESULT Copy(const drINodeHelper* src);
    DR_RESULT Destroy();


    drIHelperDummy* GetHelperDummy() { return _obj_dummy; }
    drIHelperBox* GetHelperBox() { return _obj_box; }
    drIHelperMesh* GetHelperMesh() { return _obj_mesh; }

};


class drNodeObject : public drINodeObject
{
    DR_STD_DECLARATION()

private:
    drIResourceMgr* _res_mgr;
    drITreeNode* _obj_root;

    char _name[DR_MAX_NAME];

public:
    drNodeObject(drIResourceMgr* res_mgr);
    virtual ~drNodeObject();


    DR_RESULT Update();
    DR_RESULT Render();
	DR_RESULT IgnoreNodesRender( const IgnoreStruct* is );
    DR_RESULT Destroy();
    DR_RESULT CullPrimitive();
    void SetName(const char* name) { _tcsncpy_s(_name, name, _TRUNCATE); }
    void SetMatrix(const drMatrix44* mat);
    char* GetName() { return _name; }
    drMatrix44* GetMatrix();
    drIByteSet* GetStateSet();
    drITreeNode* GetTreeNodeRoot() { return _obj_root; }
    DR_RESULT QueryTreeNode(drModelNodeQueryInfo* info);
    DR_RESULT InsertTreeNode(drITreeNode* parent_node, drITreeNode* prev_node, drITreeNode* node);
    DR_RESULT RemoveTreeNode(drITreeNode* node);
    DR_RESULT Load(const char* file, DWORD flag, drITreeNode* parent_node);

};

// assistant method
DR_RESULT drDestroyNodeObject(drITreeNode* node);

// if there is not available animation ctrl then the return value is DR_RET_OK_1
DR_RESULT drNodePrimitive_PlayPose(drINodePrimitive* obj, const drPlayPoseInfo* info, DWORD ctrl_type, DWORD subset, DWORD stage);
DR_RESULT drNodePrimitive_PlayPoseAll(drINodePrimitive* obj, const drPlayPoseInfo* info);
DR_RESULT drNodeBoneCtrl_PlayPose(drINodeBoneCtrl* obj, const drPlayPoseInfo* info);
DR_RESULT drNodeDummy_PlayPose(drINodeDummy* obj, const drPlayPoseInfo* info);
DR_RESULT drNodeObject_PlayDefaultPose(drINodeObject* obj);
DR_RESULT drNode_ShowBoundingObject(drINode* obj, DWORD flag);
DR_RESULT drNodeObject_ShowBoundingObject(drINodeObject* obj, DWORD flag);
DR_RESULT drNodeObject_DumpObjectTree(drINodeObject* obj, const char* file);
DR_RESULT drNodeObject_GetPrimitiveCullingNum(drINodeObject* obj, DWORD* num);

DR_END
