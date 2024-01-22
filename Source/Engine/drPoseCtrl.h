//
#pragma once


#include "drHeader.h"
#include "drStdInc.h"
#include "drITypes.h"
#include "drInterfaceExt.h"


DR_BEGIN

// 这个版本的PlayPose和CallBack对PLAY_LOOP标志下的关键帧做过测试（减速，正常，加速）
///////////////////////////

class drPoseCtrl : public drIPoseCtrl
{

private:
    drPoseInfo* _pose_seq;
    DWORD _pose_num;
    DWORD _frame_num;

DR_STD_DECLARATION()

private:
    DR_RESULT _Update(DWORD pose, DWORD play_type, float velocity, float* io_frame, float* o_ret_frame);
public:
    drPoseCtrl() : _pose_seq(0), _pose_num(0), _frame_num(0xffffffff){}
    ~drPoseCtrl() { DR_SAFE_DELETE_A(_pose_seq); }

    DR_RESULT Load(const char* file);
    DR_RESULT Save(const char* file) const;
    DR_RESULT Load(FILE* fp);
    DR_RESULT Save(FILE* fp) const;

    DR_RESULT Copy(const drPoseCtrl* src);
    DR_RESULT Clone(drIPoseCtrl** obj);

    DWORD GetDataSize() const;

    DR_RESULT InsertPose(DWORD id, const drPoseInfo* pi, int num); 
    DR_RESULT ReplacePose(DWORD id, const drPoseInfo* pi);
    DR_RESULT RemovePose(DWORD id);
    DR_RESULT RemoveAll();
    DR_RESULT GetPoseInfoBuffer(drPoseInfo** buf);

    void SetFrameNum(int frame) { _frame_num = frame; }
    DWORD GetPoseNum() const { return _pose_num; }
    drPoseInfo* GetPoseInfo(DWORD id) { return (id >= _pose_num) ? 0 : &_pose_seq[id]; }

    DWORD GetPoseFrameNum(DWORD id) const { return (id >= _pose_num) ? 0 : (_pose_seq[id].end - _pose_seq[id].start + 1); }
    int IsPosePlaying(const drPlayPoseInfo* info) const;

    DR_RESULT PlayPose(drPlayPoseInfo* info);
    DR_RESULT CallBack(const drPlayPoseInfo* info);
};

///////////////////////////

DR_RESULT drPlayPoseSmooth(drPlayPoseInfo* dst, const drPlayPoseInfo* src, drIPoseCtrl* ctrl);

DR_END