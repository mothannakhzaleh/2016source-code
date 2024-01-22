//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drMath.h"
#include "drClassDecl.h"
#include "drITypes.h"
#include "drITypes2.h"
#include "drInterfaceExt.h"

DR_BEGIN

class drAnimKeySetPRS2 : public drIAnimKeySetPRS
{
    DR_STD_DECLARATION()
private:
    drKeyVector3* _pos_seq;
    drKeyQuaternion* _rot_seq;
    drKeyVector3* _sca_seq;
    DWORD _pos_num;
    DWORD _rot_num;
    DWORD _sca_num;
    DWORD _frame_num;

private:
    void _ResetFrameNum();

public:
    drAnimKeySetPRS2()
        : _pos_seq(0), _rot_seq(0), _sca_seq(0), _pos_num(0), _rot_num(0), _sca_num(0), _frame_num(0)
    {}

    ~drAnimKeySetPRS2()
    {
        DR_IF_DELETE_A(_pos_seq);
        DR_IF_DELETE_A(_rot_seq);
        DR_IF_DELETE_A(_sca_seq);
    }


    DR_RESULT Destroy();
    DR_RESULT GetValue(drMatrix44* mat, float frame);
    DR_RESULT AddKeyPosition(DWORD id, const drKeyVector3* data, DWORD num);
    DR_RESULT AddKeyRotation(DWORD id, const drKeyQuaternion* data, DWORD num);
    DR_RESULT AddKeyScale(DWORD id, const drKeyVector3* data, DWORD num);
    DR_RESULT DelKeyPosition(DWORD id, DWORD num);// if num == 0xffffffff(-1) then delete sequence
    DR_RESULT DelKeyRotation(DWORD id, DWORD num);
    DR_RESULT DelKeyScale(DWORD id, DWORD num);
    DWORD GetFrameNum() const { return _frame_num; }
    DWORD GetKeyPositionNum() const { return _pos_num; }
    DWORD GetKeyRotationNum() const { return _rot_num; }
    DWORD GetKeyScaleNum() const { return _sca_num; }
};

class drAnimKeySetFloat : public drIAnimKeySetFloat
{
    typedef drKeyFloat KEY_TYPE;

    DR_STD_DECLARATION();

private:
    drKeyFloat* _data_seq;
    DWORD _data_num;
    DWORD _data_capacity;

public:
    drAnimKeySetFloat();
    ~drAnimKeySetFloat();

    DR_RESULT Allocate(DWORD key_capacity);
    DR_RESULT Clear();
    DR_RESULT Clone(drIAnimKeySetFloat** obj);
    DR_RESULT SetKeyData(DWORD key, float data, DWORD slerp_type, DWORD mask);
    DR_RESULT GetKeyData(DWORD key, float* data, DWORD* slerp_type);
    DR_RESULT InsertKey(DWORD key, float data, DWORD slerp_type);
    DR_RESULT RemoveKey(DWORD key);
    DR_RESULT GetValue(float* data, float key);
    DR_RESULT SetKeySequence(const drKeyFloat* seq, DWORD num);
    drKeyFloat* GetKeySequence() { return _data_seq; }
    DWORD GetKeyNum() { return _data_num; }
    DWORD GetKeyCapacity() { return _data_capacity; }
    DWORD GetBeginKey() { return _data_num > 0 ? _data_seq[0].key : 0; }
    DWORD GetEndKey() { return _data_num > 0 ? _data_seq[_data_num - 1].key : 0; }
};

DR_END
