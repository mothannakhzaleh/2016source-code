#pragma once

#include "drHeader.h"
#include "drInterfaceExt.h"
#include "drExpObj.h"
#include "drClassDecl.h"
#include "drPoseCtrl.h"
#include "drITypes.h"

DR_BEGIN


class drAnimCtrl
{
protected:
    drIResourceMgr* _res_mgr;
    DR_DWORD _reg_id;
    DR_DWORD _ctrl_type;
    drResFileAnimData _res_file;
    drPoseCtrl _pose_ctrl;

public:
protected:
    drAnimCtrl(drIResourceMgr* res_mgr) 
        : _res_mgr(res_mgr), _ctrl_type(ANIM_CTRL_TYPE_INVALID), _reg_id(DR_INVALID_INDEX)
    {}
    ~drAnimCtrl() {}

    DR_DWORD _GetCtrlType() const { return _ctrl_type; }

    void _SetResFile( const drResFileAnimData* info ) { _res_file = *info; }
    drResFileAnimData* _GetResFileInfo() { return &_res_file; }

    DR_VOID _SetRegisterID( DR_DWORD id ) { _reg_id = id; }
    DR_DWORD _GetRegisterID() const { return _reg_id; }
    drIPoseCtrl* _GetPoseCtrl() { return (drIPoseCtrl*)&_pose_ctrl; }

};


class drAnimCtrlBone :  public drIAnimCtrlBone, public drAnimCtrl
{
    struct drRTBD
    {
        DWORD flag;
        drMatrix44* data;
    };

private:

    drAnimDataBone _data;
    drMatrix44* _bone_rtmat_seq;
    drMatrix44* _bone_rtmat_blend_seq;
    //这里用drIndexMatrix44而不是drMatrix44是从接口角度考虑
    //外部需要SetDummyRTM()来得到运行时刻的dummy信息，这个信息
    //需要包含dummy的index
    drIndexMatrix44* _dummy_rtmat_seq;
    drRTBD* _rtbuf_seq;
    drMatrix44* _rtmat_ptr;


DR_STD_DECLARATION()

private:
    DR_RESULT _BuildRunTimeBoneMatrix(drMatrix44* out_buf, float frame, DWORD start_frame, DWORD end_frame);
    DR_RESULT _UpdateFrameDataBone(drMatrix44** o_mat_ptr, drMatrix44* mat_buf, float frame, DWORD start_frame, DWORD end_frame, BOOL loop_flag);
    DR_RESULT _UpdateFrameDataBoneDummy();
    DR_RESULT _BlendBoneData(drMatrix44* dst_mat_ptr, drMatrix44* src_mat_ptr0, drMatrix44* src_mat_ptr1, float t);

public:
    drAnimCtrlBone(drIResourceMgr* res_mgr);
    ~drAnimCtrlBone();

    // == base method
    virtual DR_DWORD GetCtrlType() const 
    { return drAnimCtrl::_GetCtrlType(); }
    virtual void SetResFile( const drResFileAnimData* info ) 
    { drAnimCtrl::_SetResFile( info ); }
    virtual drResFileAnimData* GetResFileInfo() 
    { return drAnimCtrl::_GetResFileInfo(); }
    virtual DR_VOID SetRegisterID( DR_DWORD id ) 
    { drAnimCtrl::_SetRegisterID( id ); }
    virtual DR_DWORD GetRegisterID() const 
    { return drAnimCtrl::_GetRegisterID(); }
    virtual drIPoseCtrl* GetPoseCtrl() 
    { return drAnimCtrl::_GetPoseCtrl(); }
    // end

    DR_RESULT LoadData( const void* data );
    DR_RESULT Destroy();

    DR_RESULT SetFrame(float frame, DWORD start_frame, DWORD end_frame);

    drMatrix44* GetBoneRTMSeq() { return _rtmat_ptr; }
    drIndexMatrix44* GetDummyRTMSeq() { return _dummy_rtmat_seq; }
    drMatrix44* GetDummyRTM( DWORD id );
    DWORD GetDummyNum() { return _data._dummy_num; }
    DWORD GetBoneNum()  { return _data._bone_num; }

    virtual DR_RESULT UpdatePose(drPlayPoseInfo* info);
    virtual DR_RESULT UpdateAnimData(const drPlayPoseInfo* info);
    virtual DR_RESULT UpdatePoseKeyFrameProc(drPlayPoseInfo* info);
    
    DR_RESULT CreateRunTimeDataBuffer();
    DR_RESULT EnableRunTimeFrameBuffer(DWORD frame, DWORD flag);

    DR_RESULT ExtractAnimData(drIAnimDataBone* out_data);
    DR_RESULT DumpRunTimeBoneData(const char* file);
    DR_RESULT DumpInitInvMat(const char* file);

};

class drAnimCtrlMatrix : public drIAnimCtrlMatrix, public drAnimDataMatrix, public drAnimCtrl
{

DR_STD_DECLARATION()

private:
    //drAnimDataMatrix _data;

#ifdef USE_ANIMKEY_PRS
    drAnimKeySetPRS _data;
    typedef drAnimKeySetPRS drAnimKeyType;
#else
#endif

    drMatrix44 _rtmat_seq[ 1 ];

public:
    drAnimCtrlMatrix(drIResourceMgr* res_mgr);
    ~drAnimCtrlMatrix();

    // == base method
    virtual DR_DWORD GetCtrlType() const 
    { return drAnimCtrl::_GetCtrlType(); }
    virtual void SetResFile( const drResFileAnimData* info ) 
    { drAnimCtrl::_SetResFile( info ); }
    virtual drResFileAnimData* GetResFileInfo() 
    { return drAnimCtrl::_GetResFileInfo(); }
    virtual DR_VOID SetRegisterID( DR_DWORD id ) 
    { drAnimCtrl::_SetRegisterID( id ); }
    virtual DR_DWORD GetRegisterID() const 
    { return drAnimCtrl::_GetRegisterID(); }
    virtual drIPoseCtrl* GetPoseCtrl() 
    { return drAnimCtrl::_GetPoseCtrl(); }
    // end


    virtual DR_RESULT LoadData( const void* data );


    virtual DR_RESULT SetFrame( float frame );
    virtual DR_RESULT SetFrame( DWORD frame );

    virtual DR_RESULT UpdatePose(drPlayPoseInfo* info);
    virtual DR_RESULT UpdateAnimData(const drPlayPoseInfo* info);

    DR_RESULT GetRTM(drMatrix44* mat);
    DR_RESULT ExtractAnimData(drIAnimDataMatrix* out_data);
};


class drAnimCtrlTexUV : public drAnimCtrl, public drIAnimCtrlTexUV, public drAnimDataTexUV
{

DR_STD_DECLARATION()

private:
    drIAnimKeySetPRS* _keyset_prs;

    drMatrix44 _rtmat_seq[ 1 ];

public:
    drAnimCtrlTexUV(drIResourceMgr* res_mgr);
    ~drAnimCtrlTexUV();

    // == base method
    virtual DR_DWORD GetCtrlType() const 
    { return drAnimCtrl::_GetCtrlType(); }
    virtual void SetResFile( const drResFileAnimData* info ) 
    { drAnimCtrl::_SetResFile( info ); }
    virtual drResFileAnimData* GetResFileInfo() 
    { return drAnimCtrl::_GetResFileInfo(); }
    virtual DR_VOID SetRegisterID( DR_DWORD id ) 
    { drAnimCtrl::_SetRegisterID( id ); }
    virtual DR_DWORD GetRegisterID() const 
    { return drAnimCtrl::_GetRegisterID(); }
    virtual drIPoseCtrl* GetPoseCtrl() 
    { return drAnimCtrl::_GetPoseCtrl(); }
    // end

    DR_RESULT LoadData( const void* data );
    DR_RESULT LoadData(const drMatrix44* mat_seq, DWORD mat_num);

    virtual DR_RESULT SetFrame( float frame );
    virtual DR_RESULT SetFrame( DWORD frame );

    virtual DR_RESULT UpdatePose(drPlayPoseInfo* info);
    virtual DR_RESULT UpdateAnimData(const drPlayPoseInfo* info);
    virtual void SetAnimKeySetPRS(drIAnimKeySetPRS* keyset);

    DR_RESULT GetRunTimeMatrix(drMatrix44* mat);
    DR_RESULT ExtractAnimData(drIAnimDataTexUV* out_data);
};

class drAnimCtrlTexImg : public drAnimCtrl, public drIAnimCtrlTexImg
{

DR_STD_DECLARATION()
private:
    drAnimDataTexImg _data;
    drITex** _tex_seq;
    DWORD _tex_num;
    DWORD _rttex;

public:
    drAnimCtrlTexImg(drIResourceMgr* res_mgr);
    ~drAnimCtrlTexImg();

    // == base method
    virtual DR_DWORD GetCtrlType() const 
    { return drAnimCtrl::_GetCtrlType(); }
    virtual void SetResFile( const drResFileAnimData* info ) 
    { drAnimCtrl::_SetResFile( info ); }
    virtual drResFileAnimData* GetResFileInfo() 
    { return drAnimCtrl::_GetResFileInfo(); }
    virtual DR_VOID SetRegisterID( DR_DWORD id ) 
    { drAnimCtrl::_SetRegisterID( id ); }
    virtual DR_DWORD GetRegisterID() const 
    { return drAnimCtrl::_GetRegisterID(); }
    virtual drIPoseCtrl* GetPoseCtrl() 
    { return drAnimCtrl::_GetPoseCtrl(); }
    // end

    DR_RESULT Destroy();

    virtual DR_RESULT LoadData(const void* data);
    virtual DR_RESULT UpdatePose(drPlayPoseInfo* info);
    virtual DR_RESULT UpdateAnimData(const drPlayPoseInfo* info);

    DR_RESULT ExtractAnimData(drIAnimDataTexImg* out_data);
    DR_RESULT GetRunTimeTex(drITex** tex);

};

class drAnimCtrlMtlOpacity : public drAnimCtrl, public drIAnimCtrlMtlOpacity
{

    DR_STD_DECLARATION();

private:
    drIAnimDataMtlOpacity* _data;
    float _rt_opacity;

public:
    drAnimCtrlMtlOpacity(drIResourceMgr* res_mgr);
    ~drAnimCtrlMtlOpacity();

    // == base method
    virtual DR_DWORD GetCtrlType() const 
    { return drAnimCtrl::_GetCtrlType(); }
    virtual void SetResFile( const drResFileAnimData* info ) 
    { drAnimCtrl::_SetResFile( info ); }
    virtual drResFileAnimData* GetResFileInfo() 
    { return drAnimCtrl::_GetResFileInfo(); }
    virtual DR_VOID SetRegisterID( DR_DWORD id ) 
    { drAnimCtrl::_SetRegisterID( id ); }
    virtual DR_DWORD GetRegisterID() const 
    { return drAnimCtrl::_GetRegisterID(); }
    virtual drIPoseCtrl* GetPoseCtrl() 
    { return drAnimCtrl::_GetPoseCtrl(); }
    // end

    DR_RESULT Destroy();

    DR_RESULT LoadData(const void* data);
    DR_RESULT UpdatePose(drPlayPoseInfo* info);
    DR_RESULT UpdateAnimData(const drPlayPoseInfo* info);

    DR_RESULT ExtractAnimData(drIAnimDataMtlOpacity* out_data);
    DR_RESULT GetRunTimeOpacity(float* opacity);

};

DR_RESULT drLoadAnimCtrlFromGenericFile( drAnimCtrl* ctrl, DWORD ctrl_type, const char* file );
DR_RESULT drLoadAnimCtrlFromGeometryFile( drAnimCtrl* ctrl, DWORD ctrl_type, const char* file );
DR_RESULT drLoadAnimCtrlFromModelFile( drAnimCtrl* ctrl, DWORD ctrl_type, const char* file, DWORD obj_id );

struct drLight
{
    DWORD type;
    drVector3 pos;
    drVector3 dir;
    drColorValue4f amb;
    drColorValue4f dif;
    drColorValue4f spe;
    float range;
    float attenuation0;
    float attenuation1;
    float attenuation2;    
};

struct drIndexDataLight
{
    DWORD id;
    drLight data;
};

class drAnimDataLight
{
public:
    drIndexDataLight* _data_seq;
    DWORD _data_num;

public:
    drAnimDataLight()
        :_data_seq(0), _data_num(0)
    {}
    virtual ~drAnimDataLight()
    { 
        DR_SAFE_DELETE_A(_data_seq); 
    }

    DR_RESULT Load(const char* file);
};

class drAnimCtrlLight : /*public drAnimCtrl, public drIAnimCtrlLight,*/ public drAnimDataLight
{
DR_STD_DECLARATION()

private:
    drLight _light;
    drPoseCtrl _pose_ctrl;

public:
    drAnimCtrlLight();
    ~drAnimCtrlLight();

    virtual drIPoseCtrl* GetPoseCtrl() 
    { return (drIPoseCtrl*)&_pose_ctrl; }

    DR_RESULT LoadData( const void* data );

    virtual DR_RESULT SetFrame( DWORD frame );

    virtual DR_RESULT UpdatePose(drPlayPoseInfo* info);
    virtual DR_RESULT UpdateAnimData(float frame);
    virtual DR_RESULT UpdateObject(drIAnimCtrlObj* ctrl_obj, drIPrimitive* obj);

};

DR_END
