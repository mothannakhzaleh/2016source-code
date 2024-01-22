//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drITypes.h"
#include "drITypes2.h"
#include "drInterfaceExt.h"

//////////////
//
DR_BEGIN


DR_RESULT drRenderStateAtomBeginSetRS(drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num);
DR_RESULT drRenderStateAtomEndSetRS(drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num);
DR_RESULT drRenderStateAtomBeginSetTSS(DWORD stage, drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num);
DR_RESULT drRenderStateAtomEndSetTSS(DWORD stage, drIDeviceObject* dev_obj, drRenderStateAtom* rsa_seq, DWORD num);

template<DWORD seq_size>
struct drRenderStateAtomSeq
{
    enum 
    {
        SEQUENCE_SIZE = seq_size
    };

    drRenderStateAtom rsa_seq[SEQUENCE_SIZE];
};

template<DWORD seq_size>
inline void drRenderStateAtomSeq_Construct(drRenderStateAtomSeq<seq_size>* obj)
{
    typedef drRenderStateAtomSeq<seq_size> type_value;

    drRenderStateAtom* p;
    for(DWORD i = 0; i < type_value::SEQUENCE_SIZE; i++)
    {
        p = &obj[i];
        p->state = DR_INVALID_INDEX;
        p->value0 = DR_INVALID_INDEX;
        p->value1 = DR_INVALID_INDEX;
    }
}
template<DWORD seq_size>
inline void drSetRenderStateAtomSeq(drRenderStateAtomSeq<seq_size>* obj, DWORD id, DWORD state, DWORD value)
{
    drRenderStateAtom* p = &obj->rsa_seq[id];
    p->state = state;
    p->value0 = value;
    p->value1 = value;
}

class drRenderStateAtomSet : public drIRenderStateAtomSet
{
    DR_STD_DECLARATION()

private:
    drRenderStateAtom* _rsa_seq;
    DWORD _rsa_num;

public:
    drRenderStateAtomSet();
    ~drRenderStateAtomSet();

    DR_RESULT Allocate(DWORD size);
    DR_RESULT Clear();
    DR_RESULT Clone(drIRenderStateAtomSet** obj);
    DR_RESULT Load(const drRenderStateAtom* rsa_seq, DWORD rsa_num);
    DR_RESULT FindState(DWORD* id, DWORD state);
    DR_RESULT ResetStateValue(DWORD state, DWORD value, DWORD* old_value);
	DR_RESULT AddStateToSet(DWORD state, DWORD value); //添加 RenderState 如果渲染状态表满了，则返回失败，最多8个 
    DR_INLINE DR_RESULT SetValue(DWORD id, DWORD value);
    DR_INLINE DR_RESULT SetStateValue(DWORD id, DWORD state, DWORD value);
    DR_INLINE DR_RESULT SetStateValue(DWORD id, drRenderStateAtom* buf, DWORD num);
    DR_INLINE DR_RESULT BeginRenderState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num);
    DR_INLINE DR_RESULT BeginTextureStageState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage);
    DR_INLINE DR_RESULT BeginSamplerState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage);
    DR_INLINE DR_RESULT EndRenderState(drIDeviceObject* dev_obj, DWORD  start_id, DWORD num);
    DR_INLINE DR_RESULT EndTextureStageState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage);
    DR_INLINE DR_RESULT EndSamplerState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage);

    DWORD GetStateNum() const { return _rsa_num; }
    DR_RESULT GetStateAtom(drRenderStateAtom** rsa, DWORD id);
    drRenderStateAtom* GetStateSeq() { return _rsa_seq; }
};
DR_INLINE DR_RESULT drRenderStateAtomSet::SetValue(DWORD id, DWORD value)
{
    if(id >= _rsa_num)
        return DR_RET_FAILED;

    _rsa_seq[id].value0 = value;
    _rsa_seq[id].value1 = value;

    return DR_RET_OK;
}

DR_INLINE DR_RESULT drRenderStateAtomSet::SetStateValue(DWORD id, DWORD state, DWORD value)
{
    if(id >= _rsa_num)
        return DR_RET_FAILED;

    _rsa_seq[id].state = state;
    _rsa_seq[id].value0 = value;
    _rsa_seq[id].value1 = value;

    return DR_RET_OK;
}
DR_INLINE DR_RESULT drRenderStateAtomSet::SetStateValue(DWORD id, drRenderStateAtom* buf, DWORD num)
{
    if(id + num > _rsa_num)
        return DR_RET_FAILED;

    memcpy(&_rsa_seq[id], buf, sizeof(drRenderStateAtom) * num);

    return DR_RET_OK;
}
DR_INLINE DR_RESULT drRenderStateAtomSet::BeginRenderState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num)
{
    DWORD n = (num == DR_INVALID_INDEX) ? (_rsa_num - start_id) : num;
    return drRenderStateAtomBeginSetRS(dev_obj, &_rsa_seq[start_id], n);
}
DR_INLINE DR_RESULT drRenderStateAtomSet::BeginTextureStageState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage)
{
    DWORD n = (num == DR_INVALID_INDEX) ? (_rsa_num - start_id) : num;
    return drRenderStateAtomBeginSetTSS(stage, dev_obj, &_rsa_seq[start_id], n);
}
DR_INLINE DR_RESULT drRenderStateAtomSet::BeginSamplerState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage)
{
    DWORD n = (num == DR_INVALID_INDEX) ? (_rsa_num - start_id) : num;
    //return drRenderStateAtomBeginSetSS(stage, dev_obj, &_rsa_seq[start_id], n);
    return -1L;
}
DR_INLINE DR_RESULT drRenderStateAtomSet::EndRenderState(drIDeviceObject* dev_obj, DWORD  start_id, DWORD num)
{
    DWORD n = (num == DR_INVALID_INDEX) ? (_rsa_num - start_id) : num;
    return drRenderStateAtomEndSetRS(dev_obj, &_rsa_seq[start_id], n);
}
DR_INLINE DR_RESULT drRenderStateAtomSet::EndTextureStageState(drIDeviceObject* dev_obj, DWORD  start_id, DWORD num, DWORD stage)
{
    DWORD n = (num == DR_INVALID_INDEX) ? (_rsa_num - start_id) : num;
    return drRenderStateAtomEndSetTSS(stage, dev_obj, &_rsa_seq[start_id], n);
}
DR_INLINE DR_RESULT drRenderStateAtomSet::EndSamplerState(drIDeviceObject* dev_obj, DWORD start_id, DWORD num, DWORD stage)
{
    DWORD n = (num == DR_INVALID_INDEX) ? (_rsa_num - start_id) : num;
    //return drRenderStateAtomEndSetSS(stage, dev_obj, &_rsa_seq[start_id], n);
    return -1L;
}


class drBuffer : public drIBuffer
{
    DR_STD_DECLARATION();

private:
    BYTE* _data;
    DWORD _size;

public:
    drBuffer();
    ~drBuffer();

    DR_RESULT Alloc(DWORD size);
    DR_RESULT Realloc(DWORD size);
    DR_RESULT Free();
    DR_RESULT SetSizeArbitrary(DWORD size);

    BYTE* GetData() { return _data; }
    DWORD GetSize() { return _size; }
};

class drByteSet : public drIByteSet
{
    DR_STD_DECLARATION();

private:
    BYTE* _buf;
    DWORD _size;

public:
    drByteSet()
        :_buf(0), _size(0)
    {}
    ~drByteSet()
    { Free(); }

    DR_RESULT Alloc(DWORD size)
    {
        _buf = DR_NEW(BYTE[size]);
        memset(_buf, 0, sizeof(BYTE) * size);
        _size = size;
        return _buf ? DR_RET_OK : DR_RET_FAILED;
    }
    DR_RESULT Free()
    {
        DR_SAFE_DELETE_A(_buf);
        _size = 0;
        return DR_RET_OK;
    }

    DR_RESULT SetValueSeq(DWORD start, BYTE* buf, DWORD num);
    void SetValue(DWORD type, BYTE value) { _buf[type] = value; }
    BYTE GetValue(DWORD type) { return _buf[type]; }
};

DR_RESULT drIAnimCtrlObj_PlayPose(drIAnimCtrlObj* ctrl_obj, const drPlayPoseInfo* info);
drIPoseCtrl* drIAnimCtrlObj_GetPoseCtrl(drIAnimCtrlObj* ctrl_obj);
drPlayPoseInfo* drIAnimCtrlObj_GetPlayPoseInfo(drIAnimCtrlObj* ctrl_obj);
DWORD drGetBlendWeightNum(DWORD fvf);
DR_RESULT LoadFileInMemory(drIBuffer* buf, const char* file, const char* load_flag);
DR_RESULT LoadFileInMemory(BYTE** data_seq, DWORD* data_size, const char* file, const char* load_flag);
int drHexStrToInt(const char* str);

DR_END