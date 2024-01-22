//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drFrontAPI.h"
#include "drExpObj.h"
#include "drObjectPool.h"
#include "drInterfaceExt.h"

DR_BEGIN

//#define DR_USE_DX9_STREAMOFFSET

#define DR_INVALID_STREAM_ID        0xffff
#define DR_INVALID_STREAMENTRY_ID   0xffff

enum
{
    STREAMENTITY_STATE_INVALID =    0,
    STREAMENTITY_STATE_INIT =       1,
    STREAMENTITY_STATE_BIND =       2,
};

class drStreamEntity
{
public:
    DWORD state;
    DWORD size;
    DWORD offset; // vertices offset from begin in vb
    DWORD stride;
    DWORD stream_id;
    void* data;


public:
    drStreamEntity()
        : size(0), offset(0), stride(0), data(0),
        stream_id(DR_INVALID_INDEX), state(STREAMENTITY_STATE_INVALID)
    {
    }
    ~drStreamEntity()
    {
    }
    void Reset()
    {
        size = 0;
        offset = 0;
        stride = 0;
        data = 0;
        stream_id = DR_INVALID_INDEX;
        state = STREAMENTITY_STATE_INVALID;
    }
};

class drStreamObject
{
protected:
public:

    DWORD _total_size;
    DWORD _free_size;
    DWORD _locked_size;
    DWORD _unused_size;
    DWORD _lock_addr;

public:
    drStreamObject()
        :_total_size(0), _free_size(0), _locked_size(0), _unused_size(0), _lock_addr(0)
    {
    }

    DWORD GetLockAddr() { return _lock_addr; }
    DWORD GetTotalSize() { return _total_size; }
    DWORD GetLockedSize() { return _locked_size; }
    DWORD GetUnusedSize() { return _unused_size; }
    DWORD GetFreeSize() { return _free_size; }
    DWORD GetReservedSize() { return (GetTotalSize() - GetUnusedSize() - GetLockAddr()); }

    DR_RESULT ApplyRoom(DWORD* out_off_addr, DWORD size, DWORD stride);
    DR_RESULT ReserveRoom(DWORD size, DWORD stride);
    DR_RESULT BindData(DWORD* out_off_addr, DWORD size, DWORD stride);
    DR_RESULT UnbindData(DWORD size, DWORD stride);
    DR_RESULT Init(DWORD buffer_size);
    DR_RESULT Reset() { return Init(_total_size); }


};

class drStreamObjVB : public drStreamObject
{
public:
    DWORD _fvf;
    drIDeviceObject* _dev_obj;
    IDirect3DVertexBufferX* _buf;

public:
    drStreamObjVB(drIDeviceObject* dev_obj);
    ~drStreamObjVB();

    DR_RESULT BindData(DWORD* out_off_addr, void* data, DWORD size, DWORD stride);
    DR_RESULT Create(DWORD size, DWORD fvf);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

};

class drStreamObjIB : public drStreamObject
{
public:
    DWORD _format;
    drIDeviceObject* _dev_obj;
    IDirect3DIndexBufferX* _buf;

public:
    drStreamObjIB(drIDeviceObject* dev_obj);
    ~drStreamObjIB();

    DR_RESULT BindData(DWORD* out_off_addr, void* data, DWORD size, DWORD stride);
    DR_RESULT Create(DWORD size, DWORD format);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

};

// static stream object manager
class drStaticStreamMgr : public drIStaticStreamMgr
{
DR_STD_DECLARATION()

    enum { MAX_STREAM_SEQ_SIZE = 32 };

private:
    drIDeviceObject* _dev_obj;

    drStreamEntity* _entity_vb_seq;
    drStreamEntity* _entity_ib_seq;

    drStreamObjVB* _stream_vb_seq[MAX_STREAM_SEQ_SIZE];
    drStreamObjIB* _stream_ib_seq[MAX_STREAM_SEQ_SIZE];
    DWORD _index_entry_offset;
    DWORD _vertex_entry_offset; // dx9 可以直接在SetStreamSource中做偏移设置

    DWORD _entity_vb_num;
    DWORD _entity_vb_seq_size;
    DWORD _entity_ib_num;
    DWORD _entity_ib_seq_size;
    DWORD _next_entity_vb_id;
    DWORD _next_entity_ib_id;

    DWORD _stream_vb_num;
    DWORD _stream_ib_num;

public:
    drStaticStreamMgr(drIDeviceObject* dev_obj);
    ~drStaticStreamMgr();

    DR_RESULT Destroy();
    DR_RESULT CreateStreamEntitySeq(DWORD entity_vb_num, DWORD entity_ib_num);
    DR_RESULT CreateVertexBufferStream(DWORD stream_id, DWORD stream_size);
    DR_RESULT CreateIndexBufferStream(DWORD stream_id, DWORD stream_size);

    DR_RESULT RegisterVertexBuffer(DR_HANDLE* out_handle, void* data, DWORD size, DWORD stride);
    DR_RESULT RegisterIndexBuffer(DR_HANDLE* out_handle, void* data, DWORD size, DWORD stride);
    DR_RESULT UnregisterVertexBuffer(DR_HANDLE handle);
    DR_RESULT UnregisterIndexBuffer(DR_HANDLE handle);
    DR_RESULT BindVertexBuffer(DR_HANDLE handle, UINT channel);
    DR_RESULT BindIndexBuffer(DR_HANDLE handle);
    DWORD GetVertexEntityOffset() { return _vertex_entry_offset; }
    DWORD GetIndexEntityOffset() { return _index_entry_offset; }
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();
    DR_RESULT GetDebugInfo(drStaticStreamMgrDebugInfo* info);
};

// dynamic stream object
class drDynamicStream
{
protected:
    DWORD _total_size;
    DWORD _free_size;
    DWORD _free_addr;
    DWORD _base_index;

    DWORD _fvf;

public:
    drDynamicStream();
    ~drDynamicStream();

    DWORD GetFreeAddr() const { return _free_addr; }
    DWORD GetTotalSize() const { return _total_size; }
    DWORD GetFreeSize() const { return _free_size; }
    DWORD GetValidSize() const { return (_total_size - _free_addr); }
    DWORD GetBaseIndex() const { return _base_index; }

    DR_RESULT GetEntryOffset(DWORD* offset, DWORD size, DWORD stride);
    DR_RESULT ResetFreeSize(DWORD size, DWORD offset);

    //virtual DR_RESULT Create(IDirect3DDeviceX* dev, DWORD buf_size, D3DFORMAT fmt) = 0;
    //virtual DR_RESULT Bind(IDirect3DDeviceX* dev, DWORD channel, const void* data, DWORD size, DWORD stride) = 0;
};

class drDynamicStreamVB : public drDynamicStream
{
private:
    drIDeviceObject* _dev_obj;
    IDirect3DVertexBufferX* _buf;

public:
    drDynamicStreamVB(drIDeviceObject* dev_obj);
    ~drDynamicStreamVB();

    DR_RESULT Create(DWORD buf_size, D3DFORMAT fmt);
    DR_RESULT Bind(DWORD channel, const void* data, DWORD size, DWORD stride);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();
};

class drDynamicStreamIB : public drDynamicStream
{
private:
    drIDeviceObject* _dev_obj;
    IDirect3DIndexBufferX* _buf;

public:
    drDynamicStreamIB(drIDeviceObject* dev_obj);
    ~drDynamicStreamIB();

    DR_RESULT Create(DWORD buf_size, D3DFORMAT fmt);
    DR_RESULT Bind(DWORD vert_index, const void* data, DWORD size, DWORD stride);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

};

class drDynamicStreamMgr : public drIDynamicStreamMgr
{
DR_STD_DECLARATION()

private:
    drIDeviceObject* _dev_obj;
    drDynamicStreamVB _vb;
    drDynamicStreamIB _ib;

private:
    DWORD _GetVerticesSize(D3DPRIMITIVETYPE pt_type, DWORD count, DWORD stride);
    DWORD _GetIndicesSize(D3DPRIMITIVETYPE pt_type, DWORD count, DWORD stride);
public:
    drDynamicStreamMgr(drIDeviceObject* dev_obj)
        : _dev_obj(dev_obj), _vb(dev_obj), _ib(dev_obj)
    {}

    DR_RESULT Create(DWORD vb_size, DWORD ib_size);
    DR_RESULT DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT count, const void* vert_data, UINT vert_stride, D3DFORMAT fvf);
    DR_RESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, UINT min_vert_index, UINT num_vert_indices, UINT count,
        const void* index_data, D3DFORMAT index_format, const void* vertex_data, UINT vert_stride, D3DFORMAT fvf);

    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    DR_RESULT BindDataVB(DWORD channel, const void* data, DWORD size, UINT stride);
    DR_RESULT BindDataIB(const void* data, DWORD size, DWORD stride);
    DR_RESULT DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT start_vert, UINT count);
    DR_RESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT num_vert, UINT start_index, UINT count);
};

// lockable stream
class drLockableStream
{
protected:
    DWORD _size;
    DWORD _usage;
    DWORD _fvf;
    BYTE* _data;
    UINT _lock_offset;
    UINT _lock_size;
    DWORD _lock_flag;
    DWORD _lock_cnt;

public:
    drLockableStream()
        : _size(0), _usage(0), _fvf(0), _data(0)
        , _lock_offset(0), _lock_size(0), _lock_flag(0), _lock_cnt(0)
    {}
    inline void Reset()
    {
        _size = 0;
        _usage = 0;
        _fvf = 0;
        _data = 0;
        _lock_offset = 0;
        _lock_size = 0;
        _lock_flag = 0;
        _lock_cnt = 0;
    }
};

class drLockableStreamVB : public drLockableStream, public drILockableStreamVB
{
    DR_STD_DECLARATION()

private:
    IDirect3DVertexBufferX* _buf;
    drIDeviceObject* _dev_obj;

public:
    drLockableStreamVB(drIDeviceObject* dev_obj)
        :_dev_obj(dev_obj), _buf(0)
    {}

    ~drLockableStreamVB()
    {
        LoseDevice();
    }

    DR_RESULT Create(void* data, DWORD size, DWORD usage, DWORD fvf);
    DR_RESULT Destroy();
    DR_RESULT Lock(UINT offset, UINT size, void** data, DWORD flag);
    DR_RESULT Unlock();
    DR_RESULT Bind(UINT channel, UINT offset_byte, UINT stride);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();
};

class drLockableStreamIB : public drLockableStream, public drILockableStreamIB
{
    DR_STD_DECLARATION()

private:
    IDirect3DIndexBufferX* _buf;
    drIDeviceObject* _dev_obj;

public:
    drLockableStreamIB(drIDeviceObject* dev_obj)
        :_dev_obj(dev_obj), _buf(0)
    {}

    ~drLockableStreamIB()
    {
        LoseDevice();
    }

    DR_RESULT Create(void* data, DWORD size, DWORD usage, DWORD fvf);
    DR_RESULT Destroy();
    DR_RESULT Lock(UINT offset, UINT size, void** data, DWORD flag);
    DR_RESULT Unlock();
    DR_RESULT Bind(UINT base_vert_index);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();
};

// drLockableStreamMgr
class drLockableStreamMgr : public drILockableStreamMgr
{
    DR_STD_DECLARATION()

    typedef drObjectPoolVoidPtr1024 drPoolStreamVB;
    typedef drObjectPoolVoidPtr1024 drPoolStreamIB;
    typedef void* drPoolEntity;

private:
    drIResourceMgr* _res_mgr;
    drPoolStreamVB _pool_vb;
    drPoolStreamIB _pool_ib;

public:
    drLockableStreamMgr(drIResourceMgr* res_mgr);
    virtual ~drLockableStreamMgr();

    drILockableStreamVB* GetStreamVB(DR_HANDLE handle);
    drILockableStreamIB* GetStreamIB(DR_HANDLE handle);

    DR_RESULT RegisterVertexBuffer(DR_HANDLE* handle, void* data, DWORD size, DWORD usage, DWORD fvf);
    DR_RESULT RegisterIndexBuffer(DR_HANDLE* handle, void* data, DWORD size, DWORD usage, DWORD fvf);
    DR_RESULT UnregisterVertexBuffer(DR_HANDLE handle);
    DR_RESULT UnregisterIndexBuffer(DR_HANDLE handle);
    DR_RESULT BindVertexBuffer(DR_HANDLE handle, UINT channel, UINT offset_byte, UINT stride);
    DR_RESULT BindIndexBuffer(DR_HANDLE handle, UINT base_vert_index);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();
};


class drSurfaceStream : public drISurfaceStream
{
    DR_STD_DECLARATION()

private:
    DWORD _type;
    DWORD _width;
    DWORD _height;
    DWORD _format;
    union
    {
        DWORD _lockable;
        DWORD _discard;
    };

    D3DMULTISAMPLE_TYPE _multi_sample;
    DWORD _multi_sample_quality;
    IDirect3DSurfaceX* _surface;
    drISurfaceStreamMgr* _ss_mgr;
    drIDeviceObject* _dev_obj;
    DWORD _reg_id;
    //BYTE* _data;
    //UINT _lock_offset;
    //UINT _lock_size;
    //DWORD _lock_flag;
    //DWORD _lock_cnt;

public:
    drSurfaceStream(drISurfaceStreamMgr* ss_mgr);
    ~drSurfaceStream();

    DR_RESULT CreateRenderTarget(UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle);
    DR_RESULT CreateDepthStencilSurface(UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle);

    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    void SetRegisterID(DWORD id) { _reg_id = id; }
    DWORD GetRegisterID() const { return _reg_id; }
    IDirect3DSurfaceX* GetSurface() { return _surface; }
};

class drSurfaceStreamMgr : public drISurfaceStreamMgr
{
    DR_STD_DECLARATION()

    typedef drObjectPoolVoidPtr1024 drPoolSurface;
private:
    drIResourceMgr* _res_mgr;
    drPoolSurface _pool_surface;

public:
    drSurfaceStreamMgr(drIResourceMgr* res_mgr);
    ~drSurfaceStreamMgr();

    // for dx8, multi_sample_quality and handle are null
    DR_RESULT CreateRenderTarget(DR_HANDLE* ret_handle, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle);
    DR_RESULT CreateDepthStencilSurface(DR_HANDLE* ret_handle, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle);
    DR_RESULT UnregisterSurface(DR_HANDLE handle);

    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    drIResourceMgr* GetResourceMgr() { return _res_mgr; }
    drISurfaceStream* GetSurfaceStream(DR_HANDLE handle);
};



// individual resource
class drVertexBuffer : public drIVertexBuffer
{
    DR_STD_DECLARATION();
    friend class drDeviceObject;

private:
    drIDeviceObject* _dev_obj;
    IDirect3DVertexBufferX* _buf;
    drVertexBufferInfo _buf_info;
    DWORD _dlock_pos;
    drVertexBuffer* _next;
    drVertexBuffer* _prev;

private:
    inline void _RemoveThisFromList()
    {
        if(_next) { _next->_prev = _prev; }
        if(_prev) { _prev->_next = _next; }
    }

public:
    drVertexBuffer(drIDeviceObject* dev_obj);
    ~drVertexBuffer();

    DR_RESULT Create(UINT length, DWORD usage, DWORD fvf, D3DPOOL pool, DWORD stride, HANDLE* handle);
    DR_RESULT Destroy();
    DR_RESULT Lock(UINT offset, UINT size, D3DLOCK_TYPE **out_data, DWORD flag) { return _buf->Lock(offset, size, out_data, flag); }
    DR_RESULT Unlock() { return _buf->Unlock(); }
    DR_RESULT LoadData(const void* data_seq, DWORD data_size, UINT offset, DWORD lock_flag);
    DR_RESULT LoadDataDynamic(const void* data_seq, DWORD data_size);
    DR_RESULT BindDevice(DWORD stream_id, UINT offset_byte) { return _dev_obj->SetStreamSource(stream_id, _buf, offset_byte, _buf_info.stride); }
    DR_RESULT SetDeviceFVF() { return _dev_obj->SetFVF(_buf_info.fvf); }
    drVertexBufferInfo* GetBufferInfo() { return &_buf_info; }
    IDirect3DVertexBufferX* GetStreamBuffer() { return _buf; }
};

class drIndexBuffer : public drIIndexBuffer
{
    DR_STD_DECLARATION();
    friend class drDeviceObject;

private:
    drIDeviceObject* _dev_obj;
    IDirect3DIndexBufferX* _buf;
    drIndexBufferInfo _buf_info;
    DWORD _dlock_pos;
    drIndexBuffer* _next;
    drIndexBuffer* _prev;

private:
    inline void _RemoveThisFromList()
    {
        if(_next) { _next->_prev = _prev; }
        if(_prev) { _prev->_next = _next; }
    }

public:
    drIndexBuffer(drIDeviceObject* dev_obj);
    ~drIndexBuffer();

    DR_RESULT Create(UINT length, DWORD usage, D3DFORMAT format, D3DPOOL pool, HANDLE* handle);
    DR_RESULT Destroy();
    DR_RESULT Lock(UINT offset, UINT size, D3DLOCK_TYPE **out_data, DWORD flag) { return _buf->Lock(offset, size, out_data, flag); }
    DR_RESULT Unlock() { return _buf->Unlock(); }
    DR_RESULT LoadData(const void* data_seq, DWORD data_size, UINT offset, DWORD lock_flag);
    DR_RESULT LoadDataDynamic(const void* data_seq, DWORD data_size);
    DR_RESULT BindDevice() { return _dev_obj->SetIndices(_buf, 0); }
    drIndexBufferInfo* GetBufferInfo() { return &_buf_info; }
    IDirect3DIndexBufferX* GetStreamBuffer() { return _buf; }
};


DR_END
