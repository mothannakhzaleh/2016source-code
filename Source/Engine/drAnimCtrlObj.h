//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

//////////////
//
DR_BEGIN

//

class drAnimCtrlObjMat : public drIAnimCtrlObjMat
{
    enum { THIS_TYPE = ANIM_CTRL_TYPE_MAT };

    DR_STD_DECLARATION();

private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlMatrix* _anim_ctrl;
    drPlayPoseInfo _ppi;
    drAnimCtrlObjTypeInfo _type_info;

    drMatrix44 _rtm;

public:
    drAnimCtrlObjMat(drIResourceMgr* res_mgr);
    ~drAnimCtrlObjMat();

    DR_RESULT Clone(drIAnimCtrlObjMat** ret_obj);
    drIAnimCtrlMatrix* AttachAnimCtrl(drIAnimCtrlMatrix* ctrl);
    drIAnimCtrlMatrix* DetachAnimCtrl();
    drIAnimCtrl* GetAnimCtrl() { return _anim_ctrl; }
    drPlayPoseInfo* GetPlayPoseInfo() { return &_ppi; }
    DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT PlayPose(const drPlayPoseInfo* info);
    BOOL IsPlaying() { return !(_anim_ctrl == NULL || _ppi.type == PLAY_INVALID); }

    DR_RESULT UpdateAnimCtrl();
    DR_RESULT UpdateObject();

    DR_RESULT GetRTM(drMatrix44* mat);
};

class drAnimCtrlObjBone : public drIAnimCtrlObjBone
{
    enum { THIS_TYPE = ANIM_CTRL_TYPE_BONE };

    DR_STD_DECLARATION();

private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlBone* _anim_ctrl;
    drPlayPoseInfo _ppi;
    drAnimCtrlObjTypeInfo _type_info;

    drIndexMatrix44* _dummy_rtm_seq;
    DWORD _dummy_rtm_num;
    drMatrix44* _bone_rtm_seq;
    DWORD _bone_rtm_num;

public:
    drAnimCtrlObjBone(drIResourceMgr* res_mgr);
    ~drAnimCtrlObjBone();

    // base method
    DR_RESULT Clone(drIAnimCtrlObjBone** ret_obj);
    drIAnimCtrlBone* AttachAnimCtrl(drIAnimCtrlBone* ctrl);
    drIAnimCtrlBone* DetachAnimCtrl();
    drIAnimCtrl* GetAnimCtrl() { return _anim_ctrl; }
    drPlayPoseInfo* GetPlayPoseInfo() { return &_ppi; }
    void SetPlayPoseInfo(const drPlayPoseInfo* ppi) { _ppi = *ppi; }
    DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT PlayPose(const drPlayPoseInfo* info);
    BOOL IsPlaying() { return !(_anim_ctrl == NULL || _ppi.type == PLAY_INVALID); }

    DR_RESULT UpdateAnimCtrl();
    DR_RESULT UpdateObject(drIAnimCtrlObjBone* ctrl_obj, drIMesh* mesh_obj);
    DR_RESULT UpdateHelperObject(drIHelperObject* helper_obj);

    drMatrix44* GetBoneRTMSeq()
	{
		return _bone_rtm_seq;
	}
    drMatrix44* GetDummyRTM(DWORD id);
    drIndexMatrix44* GetDummyRTMSeq() { return _dummy_rtm_seq; }
    DWORD GetBoneRTTMNum() { return _bone_rtm_num; }
    DWORD GetDummyRTMNum() { return _dummy_rtm_num; }
};


class drAnimCtrlObjTexUV : public drIAnimCtrlObjTexUV
{
    enum { THIS_TYPE = ANIM_CTRL_TYPE_TEXUV };

    DR_STD_DECLARATION();

private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlTexUV* _anim_ctrl;
    drPlayPoseInfo _ppi;
    drAnimCtrlObjTypeInfo _type_info;

    drMatrix44 _rtm;

public:
    drAnimCtrlObjTexUV(drIResourceMgr* res_mgr);
    ~drAnimCtrlObjTexUV();

    DR_RESULT Clone(drIAnimCtrlObjTexUV** ret_obj);
    drIAnimCtrlTexUV* AttachAnimCtrl(drIAnimCtrlTexUV* ctrl);
    drIAnimCtrlTexUV* DetachAnimCtrl();
    drIAnimCtrl* GetAnimCtrl() { return _anim_ctrl; }
    drPlayPoseInfo* GetPlayPoseInfo() { return &_ppi; }
    DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT PlayPose(const drPlayPoseInfo* info);
    BOOL IsPlaying() { return !(_anim_ctrl == NULL || _ppi.type == PLAY_INVALID); }

    DR_RESULT UpdateAnimCtrl();
    DR_RESULT UpdateObject();

    DR_RESULT GetRTM(drMatrix44* mat);
};

class drAnimCtrlObjTexImg : public drIAnimCtrlObjTexImg
{
    enum { THIS_TYPE = ANIM_CTRL_TYPE_TEXIMG };

    DR_STD_DECLARATION();

private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlTexImg* _anim_ctrl;
    drPlayPoseInfo _ppi;
    drAnimCtrlObjTypeInfo _type_info;

    drITex* _rt_tex;

public:
    drAnimCtrlObjTexImg(drIResourceMgr* res_mgr);
    ~drAnimCtrlObjTexImg();

    DR_RESULT Clone(drIAnimCtrlObjTexImg** ret_obj);
    drIAnimCtrlTexImg* AttachAnimCtrl(drIAnimCtrlTexImg* ctrl);
    drIAnimCtrlTexImg* DetachAnimCtrl();
    drIAnimCtrl* GetAnimCtrl() { return _anim_ctrl; }
    drPlayPoseInfo* GetPlayPoseInfo() { return &_ppi; }
    DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT PlayPose(const drPlayPoseInfo* info);
    BOOL IsPlaying() { return !(_anim_ctrl == NULL || _ppi.type == PLAY_INVALID); }

    DR_RESULT UpdateAnimCtrl();
    DR_RESULT UpdateObject();

    DR_RESULT GetRunTimeTex(drITex** tex);
};

class drAnimCtrlObjMtlOpacity : public drIAnimCtrlObjMtlOpacity
{
    enum { THIS_TYPE = ANIM_CTRL_TYPE_MTLOPACITY };

    DR_STD_DECLARATION();

private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlMtlOpacity* _anim_ctrl;
    drPlayPoseInfo _ppi;
    drAnimCtrlObjTypeInfo _type_info;

    float _rt_opacity;

public:
    drAnimCtrlObjMtlOpacity(drIResourceMgr* res_mgr);
    ~drAnimCtrlObjMtlOpacity();

    DR_RESULT Clone(drIAnimCtrlObjMtlOpacity** ret_obj);
    drIAnimCtrlMtlOpacity* AttachAnimCtrl(drIAnimCtrlMtlOpacity* ctrl);
    drIAnimCtrlMtlOpacity* DetachAnimCtrl();
    drIAnimCtrl* GetAnimCtrl() { return _anim_ctrl; }
    drPlayPoseInfo* GetPlayPoseInfo() { return &_ppi; }
    DR_RESULT SetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT GetTypeInfo(drAnimCtrlObjTypeInfo* info);
    DR_RESULT PlayPose(const drPlayPoseInfo* info);
    BOOL IsPlaying() { return !(_anim_ctrl == NULL || _ppi.type == PLAY_INVALID); }

    DR_RESULT UpdateAnimCtrl();
    DR_RESULT UpdateObject();

    DR_RESULT GetRunTimeOpacity(float* opacity);
};

// drAnimCtrlAgent
class drAnimCtrlAgent : public drIAnimCtrlAgent
{
    DR_STD_DECLARATION()


private:
    drIResourceMgr* _res_mgr;
    drIAnimCtrlObj** _obj_seq;
    DWORD _obj_num;

private:
public:
    drAnimCtrlAgent(drIResourceMgr* res_mgr);
    ~drAnimCtrlAgent();

    DR_RESULT AddAnimCtrlObj(drIAnimCtrlObj* obj);
    drIAnimCtrlObj* RemoveAnimCtrlObj(drAnimCtrlObjTypeInfo* info);
    drIAnimCtrlObj* GetAnimCtrlObj(drAnimCtrlObjTypeInfo* info);
    drIAnimCtrlObj* GetAnimCtrlObj(DWORD id) { return _obj_seq[id]; }
    DWORD GetAnimCtrlObjNum() { return _obj_num; }

    DR_RESULT Update();

    DR_RESULT Clone(drIAnimCtrlAgent** ret_obj);
    DR_RESULT ExtractAnimData(drIAnimDataInfo* data_info);
};

DR_END
