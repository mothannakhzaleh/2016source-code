//
#include "drStreamObj.h"
#include "drDeviceObject.h"
#include "drErrorCode.h"
#include "drStdInc.h"

DR_BEGIN


DR_RESULT drStreamObject::Init(DWORD buffer_size)
{
    _total_size = buffer_size;
    _locked_size = 0;
    _unused_size = _total_size;
    _free_size = _total_size;
    _lock_addr = 0;

    return DR_RET_OK;
}


DR_RESULT drStreamObject::ReserveRoom(DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD a = size + stride;

    if(GetUnusedSize() < a)
        goto __ret;

    _unused_size -= a;
    _free_size -= a;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drStreamObject::BindData(DWORD* out_off_addr, DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;
    
    DWORD o = (GetLockAddr() / stride) * stride;

    if(o < GetLockAddr())
    {
        o += stride;
    }

    //assert(o / 4 * 4 == o);
    if((o + size) >= GetTotalSize())
        goto __ret;


    _lock_addr = o + size;
    _locked_size += size;

    *out_off_addr = o;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drStreamObject::UnbindData(DWORD size, DWORD stride)
{
    _free_size += (size + stride);
    return DR_RET_OK;
}

DR_RESULT drStreamObject::ApplyRoom(DWORD* out_off_addr, DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(GetUnusedSize() < size)
        goto __ret;


    DWORD o = (GetLockAddr() / stride) * stride;

    if(o < GetLockAddr())
    {
        o += stride;
    }

    //assert(o / 4 * 4 == o);

    if((o + size) >= GetTotalSize())
        goto __ret;

    *out_off_addr = o;

    _lock_addr = o + size;
    _unused_size = _total_size - _lock_addr;

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drStreamObjVB
drStreamObjVB::drStreamObjVB(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _buf(0), _fvf(0)
{
}

drStreamObjVB::~drStreamObjVB()
{
    LoseDevice();
}

DR_RESULT drStreamObjVB::Create(DWORD size, DWORD fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(drStreamObject::Init(size)))
        goto __ret;

    _fvf = fvf;

    if(DR_FAILED(ResetDevice()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStreamObjVB::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev_obj->ReleaseVertexBuffer(_buf)))
        goto __ret;

    _buf = 0;

    if(DR_FAILED(drStreamObject::Init(_total_size)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drStreamObjVB::ResetDevice()
{
    DWORD usage = D3DUSAGE_DYNAMIC | D3DUSAGE_WRITEONLY;

    return _dev_obj->CreateVertexBuffer(_total_size, usage, _fvf, D3DPOOL_DEFAULT, &_buf, DR_NULL);
}

DR_RESULT drStreamObjVB::BindData(DWORD* out_off_addr, void* data, DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(drStreamObject::BindData(out_off_addr, size, stride)))
        goto __ret;

    D3DLOCK_TYPE* lock_buf;
    DWORD lock_flag = (*out_off_addr) == 0 ? D3DLOCK_DISCARD : D3DLOCK_NOOVERWRITE;

    if(FAILED(_buf->Lock(*out_off_addr, size, (D3DLOCK_TYPE**)&lock_buf, lock_flag)))
        goto __ret;

    memcpy(lock_buf, data, size);

    _buf->Unlock();

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drStreamObjIB
drStreamObjIB::drStreamObjIB(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _buf(0), _format(D3DFMT_INDEX16)
{
}

drStreamObjIB::~drStreamObjIB()
{
    LoseDevice();
}

DR_RESULT drStreamObjIB::Create(DWORD size, DWORD format)
{
    DR_RESULT ret = DR_RET_FAILED;
    
    if(DR_FAILED(drStreamObject::Init(size)))
        goto __ret;

    _format = format;

    if(DR_FAILED(ResetDevice()))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drStreamObjIB::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev_obj->ReleaseIndexBuffer(_buf)))
        goto __ret;

    _buf = 0;

    if(DR_FAILED(drStreamObject::Init(_total_size)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drStreamObjIB::ResetDevice()
{
    DWORD usage = D3DUSAGE_DYNAMIC | D3DUSAGE_WRITEONLY;

    return _dev_obj->CreateIndexBuffer(_total_size, usage, (D3DFORMAT)_format, D3DPOOL_DEFAULT, &_buf, DR_NULL);
}

DR_RESULT drStreamObjIB::BindData(DWORD* out_off_addr, void* data, DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(drStreamObject::BindData(out_off_addr, size, stride)))
        goto __ret;

    D3DLOCK_TYPE* lock_buf;
    DWORD lock_flag = (*out_off_addr) == 0 ? D3DLOCK_DISCARD : D3DLOCK_NOOVERWRITE;

    if(FAILED(_buf->Lock(*out_off_addr, size, (D3DLOCK_TYPE**)&lock_buf, lock_flag)))
        goto __ret;

    memcpy(lock_buf, data, size);

    _buf->Unlock();

    ret = DR_RET_OK;
__ret:
    return ret;

}
// drStaticStreamMgr
// Static Stream Manager
DR_STD_ILELEMENTATION(drStaticStreamMgr)

drStaticStreamMgr::drStaticStreamMgr(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj)
{
    _index_entry_offset = 0;
    _vertex_entry_offset = 0;

    memset(_stream_vb_seq, 0, sizeof(_stream_vb_seq));
    memset(_stream_ib_seq, 0, sizeof(_stream_ib_seq));
    
    _entity_vb_seq = 0;
    _entity_ib_seq = 0;

    _entity_vb_num = 0;
    _entity_vb_seq_size = 0;
    _entity_ib_num = 0;
    _entity_ib_seq_size = 0;
    _next_entity_vb_id = 0;
    _next_entity_ib_id = 0;

    _stream_vb_num = 0;
    _stream_ib_num = 0;
}
drStaticStreamMgr::~drStaticStreamMgr()
{
    Destroy();
}

DR_RESULT drStaticStreamMgr::Destroy()
{
    for(DWORD i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        DR_SAFE_DELETE(_stream_vb_seq[i]);
        DR_SAFE_DELETE(_stream_ib_seq[i]);
    }

    DR_SAFE_DELETE_A(_entity_vb_seq);
    DR_SAFE_DELETE_A(_entity_ib_seq);

    _entity_vb_num = 0;
    _entity_vb_seq_size = 0;
    _entity_ib_num = 0;
    _entity_ib_seq_size = 0;
    _next_entity_vb_id = 0;
    _next_entity_ib_id = 0;

    _stream_vb_num = 0;
    _stream_ib_num = 0;

    return DR_RET_OK;
}

DR_RESULT drStaticStreamMgr::CreateStreamEntitySeq(DWORD entity_vb_size, DWORD entity_ib_size)
{
    _entity_vb_seq = DR_NEW(drStreamEntity[entity_vb_size]);
    _entity_vb_num = 0;
    _entity_vb_seq_size = entity_vb_size;

    _entity_ib_seq = DR_NEW(drStreamEntity[entity_ib_size]);
    _entity_ib_num = 0;
    _entity_ib_seq_size = entity_ib_size;

    _next_entity_vb_id = 0;
    _next_entity_ib_id = 0;

    return DR_RET_OK;
}

DR_RESULT drStaticStreamMgr::CreateVertexBufferStream(DWORD stream_id, DWORD stream_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_stream_vb_seq[stream_id])
        goto __ret;

    drStreamObjVB* s = DR_NEW(drStreamObjVB(_dev_obj));

    if(DR_FAILED(s->Create(stream_size, 0)))
    {
        DR_DELETE(s);
        goto __ret;
    }

    _stream_vb_seq[stream_id] = s;
    _stream_vb_num += 1;

    s = 0;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drStaticStreamMgr::CreateIndexBufferStream(DWORD stream_id, DWORD stream_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_stream_ib_seq[stream_id])
        goto __ret;

    drStreamObjIB* s = DR_NEW(drStreamObjIB(_dev_obj));

    if(DR_FAILED(s->Create(stream_size, (DWORD)D3DFMT_INDEX16)))
    {
        DR_DELETE(s);
        goto __ret;
    }

    _stream_ib_seq[stream_id] = s;
    _stream_ib_num += 1;

    s = 0;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::RegisterVertexBuffer(DR_HANDLE* out_handle, void* data, DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_entity_vb_num >= _entity_vb_seq_size)
        goto __ret;

    DWORD i;
    DWORD stream_id = 0;
    drStreamObject* s;

    for(i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        if((s = _stream_vb_seq[i]) == 0)
            continue;

        if(DR_SUCCEEDED(s->ReserveRoom(size, stride)))
        {
            stream_id = i;
            break;
        }
    }


    if(i == MAX_STREAM_SEQ_SIZE)
    {
        DWORD room_cost = 0;
        stream_id = DR_INVALID_INDEX;

        for(i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
        {
            if((s = _stream_vb_seq[i]) == 0)
                continue;

            DWORD free_size = s->GetFreeSize();
            if((free_size > (size + stride)) && free_size > room_cost)
            {
                room_cost = free_size;
                stream_id = i;
            }
        }
        
        if(stream_id == DR_INVALID_INDEX)
        {
            // here need throw an exception
            goto __ret;
        }

        // reset stream
        s = _stream_vb_seq[stream_id];
        s->Reset();

        // reset entity
        drStreamEntity* e = 0;
        for(i = 0; i < _entity_vb_seq_size; i++)
        {
            e = &_entity_vb_seq[i];

            if((e->stream_id == stream_id) && (e->state != STREAMENTITY_STATE_INVALID))
            {
                if(DR_FAILED(s->ReserveRoom(e->size, e->stride)))
                    goto __ret;

                e->state = STREAMENTITY_STATE_INIT;
            }
        }

        if(DR_FAILED(s->ReserveRoom(size, stride)))
        {
            // this is impossible...@@
            goto __ret;
        }
    }

    DWORD this_id = _next_entity_vb_id;
    drStreamEntity* e = &_entity_vb_seq[this_id];
    
    e->stream_id = stream_id;
    e->data = data;
    e->size = size;
    e->stride = stride;
    e->state = STREAMENTITY_STATE_INIT;
        
    _entity_vb_num += 1;

    i = this_id + 1;
    if(i == _entity_vb_seq_size)
        i = 0;

    for(; i < _entity_vb_seq_size; i++)
    {
        if(_entity_vb_seq[i].state == STREAMENTITY_STATE_INVALID)
        {
            _next_entity_vb_id = i;
            break;
        }
    }

    *out_handle = this_id;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drStaticStreamMgr::RegisterIndexBuffer(DR_HANDLE* out_handle, void* data, DWORD size, DWORD stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_entity_ib_num >= _entity_ib_seq_size)
        goto __ret;

    DWORD i;
    DWORD stream_id = 0;
    drStreamObject* s;

    for(i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        if((s = _stream_ib_seq[i]) == 0)
            continue;

        if(DR_SUCCEEDED(s->ReserveRoom(size, stride)))
        {
            stream_id = i;
            break;
        }
    }

    if(i == MAX_STREAM_SEQ_SIZE)
    {
        DWORD room_cost = 0;
        stream_id = DR_INVALID_INDEX;

        for(i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
        {
            if((s = _stream_ib_seq[i]) == 0)
                continue;

            DWORD free_size = s->GetFreeSize();
            if((free_size > (size + stride)) && free_size > room_cost)
            {
                room_cost = free_size;
                stream_id = i;
            }
        }
        
        if(stream_id == DR_INVALID_INDEX)
        {
            // here need throw an exception
            goto __ret;
        }

        // reset stream
        s = _stream_ib_seq[stream_id];
        s->Reset();

        // reset entity
        drStreamEntity* e = 0;
        for(i = 0; i < _entity_ib_seq_size; i++)
        {
            e = &_entity_ib_seq[i];

            if((e->stream_id == stream_id) && (e->state != STREAMENTITY_STATE_INVALID))
            {
                if(DR_FAILED(s->ReserveRoom(e->size, e->stride)))
                    goto __ret;

                e->state = STREAMENTITY_STATE_INIT;
            }
        }

        if(DR_FAILED(s->ReserveRoom(size, stride)))
        {
            // this is impossible...@@
            goto __ret;
        }
    }

    DWORD this_id = _next_entity_ib_id;
    drStreamEntity* e = &_entity_ib_seq[this_id];
    
    e->stream_id = stream_id;
    e->data = data;
    e->size = size;
    e->stride = stride;
    e->state = STREAMENTITY_STATE_INIT;
        
    _entity_ib_num += 1;

    i = this_id + 1;
    if(i == _entity_ib_seq_size)
        i = 0;

    for(; i < _entity_ib_seq_size; i++)
    {
        if(_entity_ib_seq[i].state == STREAMENTITY_STATE_INVALID)
        {
            _next_entity_ib_id = i;
            break;
        }
    }

    *out_handle = this_id;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::UnregisterVertexBuffer(DR_HANDLE handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(handle >= _entity_vb_seq_size)
        goto __ret;

    drStreamEntity* e= &_entity_vb_seq[handle];
    drStreamObject* s = _stream_vb_seq[e->stream_id];

    if(DR_FAILED(s->UnbindData(e->size, e->stride)))
        goto __ret;

    e->Reset();

    _entity_vb_num -= 1;

    if(_next_entity_vb_id > handle)
        _next_entity_vb_id = handle;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::UnregisterIndexBuffer(DR_HANDLE handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(handle >= _entity_ib_seq_size)
        goto __ret;

    drStreamEntity* e= &_entity_ib_seq[handle];
    drStreamObject* s = _stream_ib_seq[e->stream_id];

    if(DR_FAILED(s->UnbindData(e->size, e->stride)))
        goto __ret;

    e->Reset();

    _entity_ib_num -= 1;

    if(_next_entity_ib_id > handle)
        _next_entity_ib_id = handle;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::BindVertexBuffer(DR_HANDLE handle, UINT channel)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(handle >= _entity_vb_seq_size)
        goto __ret;

    drStreamEntity* e= &_entity_vb_seq[handle];
    drStreamObjVB* s = _stream_vb_seq[e->stream_id];

    if(e->state == STREAMENTITY_STATE_INVALID)
        goto __ret;

    if(e->state == STREAMENTITY_STATE_INIT)
    {
        if(DR_FAILED(s->BindData(&e->offset, e->data, e->size, e->stride)))
            goto __ret;

        e->state = STREAMENTITY_STATE_BIND;
    }


#if(defined DR_USE_DX8)
    _dev_obj->SetStreamSource(channel, s->_buf, e->offset, e->stride);
#endif

#if(defined DR_USE_DX9)

#if(defined DR_USE_DX9_STREAMOFFSET)
    // To find out if the device supports stream offsets, 
    // see the D3DDEVCAPS2_STREAMOFFSET constant in D3DDEVCAPS2.
    _dev_obj->SetStreamSource(channel, s->_buf, e->offset, e->stride);
#else
    _dev_obj->SetStreamSource(channel, s->_buf, 0, e->stride);
#endif

#endif

    _vertex_entry_offset = e->offset / e->stride;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::BindIndexBuffer(DR_HANDLE handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(handle >= _entity_ib_seq_size)
        goto __ret;

    drStreamEntity* e= &_entity_ib_seq[handle];
    drStreamObjIB* s = _stream_ib_seq[e->stream_id];

    if(e->state == STREAMENTITY_STATE_INVALID)
        goto __ret;

    if(e->state == STREAMENTITY_STATE_INIT)
    {
        if(DR_FAILED(s->BindData(&e->offset, e->data, e->size, e->stride)))
            goto __ret;

        e->state = STREAMENTITY_STATE_BIND;
    }

	//if(IsBadReadPtr(s->_buf,e->size))
	//	goto __ret;

    _dev_obj->SetIndices(s->_buf, _vertex_entry_offset);

    _index_entry_offset = e->offset / e->stride;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        if(_stream_vb_seq[i])
        {
            if(DR_FAILED(_stream_vb_seq[i]->LoseDevice()))
                goto __ret;
        }
        if(_stream_ib_seq[i])
        {
            if(DR_FAILED(_stream_ib_seq[i]->LoseDevice()))
                goto __ret;
        }
    }

    for(DWORD i = 0; i < _entity_vb_seq_size; i++)
    {
        if(_entity_vb_seq[i].state == STREAMENTITY_STATE_BIND)
        {
            _entity_vb_seq[i].state = STREAMENTITY_STATE_INIT;
        }
    }


    for(DWORD i = 0; i < _entity_ib_seq_size; i++)
    {
        if(_entity_ib_seq[i].state == STREAMENTITY_STATE_BIND)
        {
            _entity_ib_seq[i].state = STREAMENTITY_STATE_INIT;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drStaticStreamMgr::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        if(_stream_vb_seq[i])
        {
            if(DR_FAILED(_stream_vb_seq[i]->ResetDevice()))
                goto __ret;
        }
        if(_stream_ib_seq[i])
        {
            if(DR_FAILED(_stream_ib_seq[i]->ResetDevice()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drStaticStreamMgr::GetDebugInfo(drStaticStreamMgrDebugInfo* info)
{
    DWORD size = 0;
    drStreamObject* s;

    memset(info, 0, sizeof(drStaticStreamMgrDebugInfo));

    for(DWORD i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        if((s = _stream_vb_seq[i]) != 0)
        {
            info->vbs_size += s->GetTotalSize();
            info->vbs_free_size += s->GetFreeSize();
            info->vbs_used_size += s->GetTotalSize() - s->GetFreeSize();
            info->vbs_unused_size += s->GetUnusedSize();
            info->vbs_locked_size += s->GetLockedSize();
        }
    }

    for(DWORD i = 0; i < MAX_STREAM_SEQ_SIZE; i++)
    {
        if((s = _stream_ib_seq[i]) != 0)
        {
            info->ibs_size += s->GetTotalSize();
            info->ibs_free_size += s->GetFreeSize();
            info->ibs_used_size += s->GetTotalSize() - s->GetFreeSize();
            info->ibs_unused_size += s->GetUnusedSize();
            info->ibs_locked_size += s->GetLockedSize();
        }
    }

    return DR_RET_OK;
}

// drDynamicStream
drDynamicStream::drDynamicStream()
: _total_size(0), _free_size(0), _free_addr(0), _base_index(0), _fvf(0)
{
}
drDynamicStream::~drDynamicStream()
{
}

DR_RESULT drDynamicStream::GetEntryOffset(DWORD* offset, DWORD size, DWORD stride)
{
    DWORD v_size = GetValidSize();

    if(v_size < size)
        return DR_RET_FAILED;

    DWORD o = (GetFreeAddr() / stride) * stride;

    if(o < GetFreeAddr())
    {
        o += stride;
    }

    //assert(o / 4 * 4 == o);

    if((o + size) >= GetTotalSize())
        return DR_RET_FAILED;

    *offset = o;

    return DR_RET_OK;

}

DR_RESULT drDynamicStream::ResetFreeSize(DWORD size, DWORD offset)
{
    _free_size -= size;
    _free_addr = offset + size;

    if(_free_size <= 0)
    {
        _free_size = _total_size;
        _free_addr = 0;
    }

    return DR_RET_OK;
}
// drDynamicStreamVB
drDynamicStreamVB::drDynamicStreamVB(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _buf(0)
{
}

drDynamicStreamVB::~drDynamicStreamVB()
{
    LoseDevice();
}

DR_RESULT drDynamicStreamVB::Create(DWORD buf_size, D3DFORMAT fmt)
{
    _total_size = buf_size;
    _free_size = _total_size;
    _free_addr = 0;
    _fvf = fmt;

    return ResetDevice();
}
DR_RESULT drDynamicStreamVB::LoseDevice()
{
    if(_buf)
    {
        _dev_obj->ReleaseVertexBuffer(_buf);
    }
    return DR_RET_OK;
}
DR_RESULT drDynamicStreamVB::ResetDevice()
{
    DWORD usage = D3DUSAGE_DYNAMIC | D3DUSAGE_WRITEONLY;
    return _dev_obj->CreateVertexBuffer(_total_size, usage, _fvf, D3DPOOL_DEFAULT, &_buf, DR_NULL);
}

DR_RESULT drDynamicStreamVB::Bind(DWORD channel, const void* data, DWORD size, DWORD stride)
{
    DWORD offset = 0;
    DWORD lock_flag = D3DLOCK_NOOVERWRITE;
    D3DLOCK_TYPE* lock_buf = 0;
    
    if(DR_FAILED(GetEntryOffset(&offset, size, stride)))
    {
        _free_addr = 0;
        _free_size = _total_size;

        if(DR_FAILED(GetEntryOffset(&offset, size, stride)))
        {
            return DR_RET_FAILED;
        }

        lock_flag = D3DLOCK_DISCARD;
    }

    lock_flag = (offset == 0) ? D3DLOCK_DISCARD : D3DLOCK_NOOVERWRITE;

    if(FAILED(_buf->Lock(offset, lock_flag == D3DLOCK_DISCARD ? 0 : size, (D3DLOCK_TYPE**)&lock_buf, lock_flag)))
        return DR_RET_FAILED;

    memcpy(lock_buf, data, size);

    _buf->Unlock();

#if(defined DR_USE_DX9_STREAMOFFSET)
    // To find out if the device supports stream offsets, 
    // see the D3DDEVCAPS2_STREAMOFFSET constant in D3DDEVCAPS2.
    _dev_obj->SetStreamSource(channel, _buf, offset, stride);
#else
    _dev_obj->SetStreamSource(channel, _buf, 0, stride);
#endif

    _base_index = offset / stride;

    ResetFreeSize(size, offset);

    return DR_RET_OK;

}

// drDynamicStreamIB
drDynamicStreamIB::drDynamicStreamIB(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _buf(0)
{
}

drDynamicStreamIB::~drDynamicStreamIB()
{
    LoseDevice();
}

DR_RESULT drDynamicStreamIB::Create(DWORD buf_size, D3DFORMAT fmt)
{
    _total_size = buf_size;
    _free_size = _total_size;
    _free_addr = 0;
    _fvf = fmt;

    return ResetDevice();

}
DR_RESULT drDynamicStreamIB::LoseDevice()
{
    if(_buf)
    {
        _dev_obj->ReleaseIndexBuffer(_buf);
    }
    return DR_RET_OK;
}
DR_RESULT drDynamicStreamIB::ResetDevice()
{
    DWORD usage = D3DUSAGE_DYNAMIC | D3DUSAGE_WRITEONLY;
    return _dev_obj->CreateIndexBuffer(_total_size, usage, (D3DFORMAT)_fvf, D3DPOOL_DEFAULT, &_buf, DR_NULL);
}

DR_RESULT drDynamicStreamIB::Bind(DWORD vert_index, const void* data, DWORD size, DWORD stride)
{
    DWORD offset = 0;
    DWORD lock_flag = D3DLOCK_NOOVERWRITE;
    D3DLOCK_TYPE* lock_buf = 0;
    
    if(DR_FAILED(GetEntryOffset(&offset, size, stride)))
    {
        _free_addr = 0;
        _free_size = _total_size;

        if(DR_FAILED(GetEntryOffset(&offset, size, stride)))
        {
            return DR_RET_FAILED;
        }

        lock_flag = D3DLOCK_DISCARD;
    }

    if(FAILED(_buf->Lock(offset, size, (D3DLOCK_TYPE**)&lock_buf, lock_flag)))
        return DR_RET_FAILED;

    memcpy(lock_buf, data, size);

    _buf->Unlock();

    _dev_obj->SetIndices(_buf, vert_index);

    _base_index = offset / stride;

    ResetFreeSize(size, offset);

    return DR_RET_OK;

}

// drDynamicStreamMgr
DR_STD_ILELEMENTATION(drDynamicStreamMgr)

DWORD drDynamicStreamMgr::_GetVerticesSize(D3DPRIMITIVETYPE pt_type, DWORD count, DWORD stride)
{
    DWORD size = 0;

    switch(pt_type)
    {
    case D3DPT_POINTLIST:
        size = stride * count;
        break;
    case D3DPT_LINESTRIP:
        size = stride * (count + 1);
        break;
    case D3DPT_LINELIST:
        size = stride * count * 2;
        break;
    case D3DPT_TRIANGLESTRIP:
        size = stride * (count + 2);
        break;
    case D3DPT_TRIANGLELIST:
        size = stride * count * 3;
        break;
    default:
        ;
    }

    return size;
}

DWORD drDynamicStreamMgr::_GetIndicesSize(D3DPRIMITIVETYPE pt_type, DWORD count, DWORD stride)
{
    DWORD size = 0;

    switch(pt_type)
    {
    case D3DPT_POINTLIST:
        size = stride * count;
        break;
    case D3DPT_LINESTRIP:
        size = stride * (count + 1);
        break;
    case D3DPT_LINELIST:
        size = stride * count * 2;
        break;
    case D3DPT_TRIANGLESTRIP:
        size = stride * (count + 2);
        break;
    case D3DPT_TRIANGLELIST:
        size = stride * count * 3;
        break;
    default:
        ;
    }

    return size;
}

DR_RESULT drDynamicStreamMgr::Create(DWORD vb_size, DWORD ib_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_vb.Create(vb_size, (D3DFORMAT)0)))
        goto __ret;

    if(DR_FAILED(_ib.Create(ib_size, D3DFMT_INDEX16)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drDynamicStreamMgr::DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT count, const void* vert_data, UINT vert_stride, D3DFORMAT fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD vert_size = _GetVerticesSize(pt_type, count, vert_stride);

    if(DR_FAILED(_vb.Bind(0, vert_data, vert_size, vert_stride)))
        goto __ret;

    if(FAILED(_dev_obj->SetFVF(fvf)))
        goto __ret;

    if(FAILED(_dev_obj->DrawPrimitive(pt_type, _vb.GetBaseIndex(), count)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT drDynamicStreamMgr::DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, UINT min_vert_index, UINT num_vert_indices, UINT count,
        const void* index_data, D3DFORMAT index_format, const void* vertex_data, UINT vert_stride, D3DFORMAT fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD index_stride = index_format == D3DFMT_INDEX16 ? sizeof(WORD) : sizeof(DWORD);
    DWORD vert_size = _GetVerticesSize(pt_type, count, vert_stride);
    DWORD index_size = _GetIndicesSize(pt_type, count, index_stride);

    if(DR_FAILED(_vb.Bind(0, vertex_data, vert_size, vert_stride)))
        goto __ret;

    if(DR_FAILED(_ib.Bind(_vb.GetBaseIndex(), index_data, index_size , index_stride)))
        goto __ret;

    if(FAILED(_dev_obj->SetFVF(fvf)))
        goto __ret;

    if(FAILED(_dev_obj->DrawIndexedPrimitive(pt_type, 0, min_vert_index, num_vert_indices, _ib.GetBaseIndex(), count)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    return ret;

}

DR_RESULT drDynamicStreamMgr::BindDataVB(DWORD channel, const void* data, DWORD size, UINT stride)
{
    return _vb.Bind(channel, data, size, stride);
}
DR_RESULT drDynamicStreamMgr::BindDataIB(const void* data, DWORD size, DWORD stride)
{
    return _ib.Bind(_vb.GetBaseIndex(), data, size, stride);
}
DR_RESULT drDynamicStreamMgr::DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT start_vert, UINT count)
{
    return _dev_obj->DrawPrimitive(pt_type, _vb.GetBaseIndex() + start_vert, count);
}
DR_RESULT drDynamicStreamMgr::DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT num_vert, UINT start_index, UINT count)
{
    return _dev_obj->DrawIndexedPrimitive(pt_type, base_vert_index, min_index, num_vert, _ib.GetBaseIndex() + start_index, count);
}

DR_RESULT drDynamicStreamMgr::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_vb.LoseDevice()))
        goto __ret;

    if(DR_FAILED(_ib.LoseDevice()))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    return ret;


}
DR_RESULT drDynamicStreamMgr::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_vb.ResetDevice()))
        goto __ret;

    if(DR_FAILED(_ib.ResetDevice()))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    return ret;
}

// drLockableStreamVB
DR_STD_ILELEMENTATION(drLockableStreamVB)

DR_RESULT drLockableStreamVB::Create(void* data, DWORD size, DWORD usage, DWORD fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev_obj->CreateVertexBuffer(size, usage, fvf, D3DPOOL_DEFAULT, &_buf, NULL)))
        goto __ret;

    D3DLOCK_TYPE* p;

    if(DR_FAILED(_buf->Lock(0, 0, &p, 0)))
        goto __ret;

    memcpy(p, data, size);

    if(DR_FAILED(_buf->Unlock()))
        goto __ret;

    _size = size;
    _usage = usage;
    _fvf = fvf;
    _data = (BYTE*)data;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drLockableStreamVB::Destroy()
{
    Reset();
    LoseDevice();

    return DR_RET_OK;
}

DR_RESULT drLockableStreamVB::Lock(UINT offset, UINT size, void** data, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 || _lock_cnt > 0 || (offset + size) >= _size)
        goto __ret;

    _lock_offset = offset;
    _lock_size = size;
    _lock_flag = flag;
    *data = &_data[_lock_offset];
    _lock_cnt += 1;

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drLockableStreamVB::Unlock()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 || _lock_cnt == 0)
        goto __ret;

    D3DLOCK_TYPE* p;
    void* d;
    DWORD s;

    if(DR_FAILED(_buf->Lock(_lock_offset, _lock_size, &p, _lock_flag)))
        goto __ret;

    if(_lock_offset == 0 && _lock_size == 0)
    {
        d = _data;
        s = _size;
    }
    else
    {
        d = &_data[_lock_offset];
        s = _lock_size;
    }

    memcpy(p, d, s);

    _buf->Unlock();

    _lock_cnt -= 1;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drLockableStreamVB::Bind(UINT channel, UINT offset_byte, UINT stride)
{
    return _dev_obj->SetStreamSource(channel, _buf, offset_byte, stride);
}

DR_RESULT drLockableStreamVB::LoseDevice()
{
    _dev_obj->ReleaseVertexBuffer(_buf);
    _buf = 0;
    return DR_RET_OK;
}
DR_RESULT drLockableStreamVB::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 && _size != 0)
    {
        if(DR_FAILED(_dev_obj->CreateVertexBuffer(_size, _usage, _fvf, D3DPOOL_DEFAULT, &_buf, NULL)))
            goto __ret;

        void* p;

        if(DR_FAILED(Lock(0, 0, &p, 0)))
            goto __ret;

        if(DR_FAILED(Unlock()))
            goto __ret;
    }

    ret = DR_RET_OK;

__ret:
    return ret;

}


// drLockableStreamIB
DR_STD_ILELEMENTATION(drLockableStreamIB)

DR_RESULT drLockableStreamIB::Create(void* data, DWORD size, DWORD usage, DWORD fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev_obj->CreateIndexBuffer(size, usage, (D3DFORMAT)fvf, D3DPOOL_DEFAULT, &_buf, NULL)))
        goto __ret;

    D3DLOCK_TYPE* p;

    if(DR_FAILED(_buf->Lock(0, 0, &p, 0)))
        goto __ret;

    memcpy(p, data, size);

    if(DR_FAILED(_buf->Unlock()))
        goto __ret;

    _size = size;
    _usage = usage;
    _fvf = fvf;
    _data = (BYTE*)data;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drLockableStreamIB::Destroy()
{
    Reset();
    LoseDevice();

    return DR_RET_OK;
}

DR_RESULT drLockableStreamIB::Lock(UINT offset, UINT size, void** data, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 || _lock_cnt > 0 || (offset + size) >= _size)
        goto __ret;

    _lock_offset = offset;
    _lock_size = size;
    _lock_flag = flag;
    *data = &_data[_lock_offset];
    _lock_cnt += 1;

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drLockableStreamIB::Unlock()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 || _lock_cnt == 0)
        goto __ret;

    D3DLOCK_TYPE* p;
    void* d;
    DWORD s;

    if(DR_FAILED(_buf->Lock(_lock_offset, _lock_size, &p, _lock_flag)))
        goto __ret;

    if(_lock_offset == 0 && _lock_size == 0)
    {
        d = _data;
        s = _size;
    }
    else
    {
        d = &_data[_lock_offset];
        s = _lock_size;
    }

    memcpy(p, d, s);

    _buf->Unlock();

    _lock_cnt -= 1;

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drLockableStreamIB::Bind(UINT base_vert_index)
{
    return _dev_obj->SetIndices(_buf, base_vert_index);
}

DR_RESULT drLockableStreamIB::LoseDevice()
{
    _dev_obj->ReleaseIndexBuffer(_buf);
    _buf = 0;

    return DR_RET_OK;
}
DR_RESULT drLockableStreamIB::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 && _size != 0)
    {
        if(DR_FAILED(_dev_obj->CreateIndexBuffer(_size, _usage, (D3DFORMAT)_fvf, D3DPOOL_DEFAULT, &_buf, NULL)))
            goto __ret;

        void* p;

        if(DR_FAILED(Lock(0, 0, &p, D3DLOCK_DISCARD)))
            goto __ret;

        if(DR_FAILED(Unlock()))
            goto __ret;
    }

    ret = DR_RET_OK;

__ret:
    return ret;

}

// drLockableStreamMgr
DR_STD_ILELEMENTATION(drLockableStreamMgr)

drLockableStreamMgr::drLockableStreamMgr(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr)
{
}
drLockableStreamMgr::~drLockableStreamMgr()
{
    LoseDevice();
}

DR_RESULT drLockableStreamMgr::RegisterVertexBuffer(DR_HANDLE* handle, void* data, DWORD size, DWORD usage, DWORD fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    drLockableStreamVB* s = DR_NEW(drLockableStreamVB(_res_mgr->GetDeviceObject()));

    if(DR_FAILED(s->Create(data, size, usage, fvf)))
        goto __ret;

    DWORD ret_id;

    if(DR_FAILED(_pool_vb.Register(&ret_id, s)))
        goto __ret;

    s =  0;

    *handle = ret_id;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE(s);
    return ret;
}
DR_RESULT drLockableStreamMgr::RegisterIndexBuffer(DR_HANDLE* handle, void* data, DWORD size, DWORD usage, DWORD fvf)
{
    DR_RESULT ret = DR_RET_FAILED;

    drLockableStreamIB* s = DR_NEW(drLockableStreamIB(_res_mgr->GetDeviceObject()));

    if(DR_FAILED(s->Create(data, size, usage, fvf)))
        goto __ret;

    DWORD ret_id;

    if(DR_FAILED(_pool_ib.Register(&ret_id, s)))
        goto __ret;

    s =  0;

    *handle = ret_id;

    ret = DR_RET_OK;
__ret:
    DR_IF_DELETE(s);
    return ret;
}

DR_RESULT drLockableStreamMgr::UnregisterVertexBuffer(DR_HANDLE handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drLockableStreamVB* s;

    if(DR_FAILED(ret = _pool_vb.Unregister((drPoolEntity*)&s, handle)))
        goto __ret;

    if(ret == DR_RET_OK_1)
    {
        DR_DELETE(s);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drLockableStreamMgr::UnregisterIndexBuffer(DR_HANDLE handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drLockableStreamIB* s;

    if(DR_FAILED(ret = _pool_ib.Unregister((drPoolEntity*)&s, handle)))
        goto __ret;

    if(ret == DR_RET_OK_1)
    {
        DR_DELETE(s);
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drLockableStreamMgr::BindVertexBuffer(DR_HANDLE handle, UINT channel, UINT offset_byte, UINT stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    drLockableStreamVB* s;

     if(DR_FAILED(_pool_vb.GetObj((drPoolEntity*)&s, handle)))
        goto __ret;

    if(DR_FAILED(s->Bind(channel, offset_byte, stride)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drLockableStreamMgr::BindIndexBuffer(DR_HANDLE handle, UINT base_vert_index)
{
    DR_RESULT ret = DR_RET_FAILED;

    drLockableStreamIB* s;

    if(DR_FAILED(_pool_ib.GetObj((drPoolEntity*)&s, handle)))
        goto __ret;

    if(DR_FAILED(s->Bind(base_vert_index)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drLockableStreamMgr::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD obj_num;
    drLockableStreamVB* obj_vb;
    drLockableStreamIB* obj_ib;

    // vertex buffer stream
    obj_num = _pool_vb.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_vb.GetObj((drPoolEntity*)&obj_vb, i)))
        {
            obj_num -= 1;
            if(DR_FAILED(obj_vb->LoseDevice()))
                goto __ret;
        }
    }

    // index buffer stream
    obj_num = _pool_ib.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_ib.GetObj((drPoolEntity*)&obj_ib, i)))
        {
            obj_num -= 1;
            if(DR_FAILED(obj_ib->LoseDevice()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drLockableStreamMgr::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD obj_num;
    drLockableStreamVB* obj_vb;
    drLockableStreamIB* obj_ib;

    // vertex buffer stream
    obj_num = _pool_vb.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_vb.GetObj((drPoolEntity*)&obj_vb, i)))
        {
            obj_num -= 1;
            if(DR_FAILED(obj_vb->ResetDevice()))
                goto __ret;
        }
    }

    // index buffer stream
    obj_num = _pool_ib.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_ib.GetObj((drPoolEntity*)&obj_ib, i)))
        {
            obj_num -= 1;
            if(DR_FAILED(obj_ib->ResetDevice()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}

drILockableStreamVB* drLockableStreamMgr::GetStreamVB(DR_HANDLE handle)
{
    drLockableStreamVB* s = 0;

    if(DR_FAILED(_pool_vb.GetObj((drPoolEntity*)&s, handle)))
        goto __ret;
__ret:
    return (drILockableStreamVB*)s;
}
drILockableStreamIB* drLockableStreamMgr::GetStreamIB(DR_HANDLE handle)
{
    drLockableStreamIB* s = 0;

    if(DR_FAILED(_pool_ib.GetObj((drPoolEntity*)&s, handle)))
        goto __ret;
__ret:
    return (drILockableStreamIB*)s;
}

// drSurfaceStream
//DR_STD_ILELEMENTATION(drSurfaceStream)
DR_STD_GETINTERFACE(drSurfaceStream)

DR_RESULT drSurfaceStream::Release()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_ss_mgr->UnregisterSurface(_reg_id)))
        goto __ret;

    DR_DELETE(this);

    ret = DR_RET_OK;
__ret:
    return ret;
}

drSurfaceStream::drSurfaceStream(drISurfaceStreamMgr* ss_mgr)
: _ss_mgr(ss_mgr)
{
    _type = SURFACESTREAM_INVALID;
    _width = 0;
    _height = 0;
    _format = D3DFMT_UNKNOWN;
    _multi_sample = D3DMULTISAMPLE_NONE;
    _multi_sample_quality = 0;
    _surface = 0;
}

drSurfaceStream::~drSurfaceStream()
{
    LoseDevice();
}

DR_RESULT drSurfaceStream::CreateRenderTarget(UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _ss_mgr->GetResourceMgr()->GetDeviceObject();

    if(FAILED(dev_obj->CreateRenderTarget(&_surface, width, height, format, multi_sample, multi_sample_quality, lockable, NULL)))
        goto __ret;

    _type = SURFACESTREAM_RENDERTARGET;
    _width = width;
    _height = height;
    _format = format;
    _lockable = lockable;
    _multi_sample = multi_sample;
    _multi_sample_quality = multi_sample_quality;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drSurfaceStream::CreateDepthStencilSurface(UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _ss_mgr->GetResourceMgr()->GetDeviceObject();

    if(FAILED(dev_obj->CreateDepthStencilSurface(&_surface, width, height, format, multi_sample, multi_sample_quality, discard, handle)))
        goto __ret;

    _type = SURFACESTREAM_DEPTHSTENCIL;
    _width = width;
    _height = height;
    _format = format;
    _discard = discard;
    _multi_sample = multi_sample;
    _multi_sample_quality = multi_sample_quality;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drSurfaceStream::LoseDevice()
{
    DR_SAFE_RELEASE(_surface);
    return DR_RET_OK;
}
DR_RESULT drSurfaceStream::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    drIDeviceObject* dev_obj = _ss_mgr->GetResourceMgr()->GetDeviceObject();

    if(_type == SURFACESTREAM_RENDERTARGET)
    {
        ret = dev_obj->CreateRenderTarget(&_surface, _width, _height, (D3DFORMAT)_format, _multi_sample, _multi_sample_quality, _lockable, NULL);
    }
    else if(_type == SURFACESTREAM_DEPTHSTENCIL)
    {
        ret = dev_obj->CreateDepthStencilSurface(&_surface, _width, _height, (D3DFORMAT)_format, _multi_sample, _multi_sample_quality, _discard, NULL);
    }

    return ret;
}

// drSurfaceStreamMgr
DR_STD_ILELEMENTATION(drSurfaceStreamMgr)

drSurfaceStreamMgr::drSurfaceStreamMgr(drIResourceMgr* res_mgr)
: _res_mgr(res_mgr)
{
}

drSurfaceStreamMgr::~drSurfaceStreamMgr()
{
    LoseDevice();
}

DR_RESULT drSurfaceStreamMgr::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD obj_num;
    drISurfaceStream* obj_surface;

    // surface stream
    obj_num = _pool_surface.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_surface.GetObj((void**)&obj_surface, i)))
        {
            obj_num -= 1;
            if(DR_FAILED(obj_surface->LoseDevice()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drSurfaceStreamMgr::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD obj_num;
    drISurfaceStream* obj_surface;

    // surface stream
    obj_num = _pool_surface.GetObjNum();

    for(DWORD i = 0; obj_num > 0; i++)
    {
        if(DR_SUCCEEDED(_pool_surface.GetObj((void**)&obj_surface, i)))
        {
            obj_num -= 1;
            if(DR_FAILED(obj_surface->ResetDevice()))
                goto __ret;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drSurfaceStreamMgr::CreateRenderTarget(DR_HANDLE* ret_handle, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drISurfaceStream* s = DR_NEW(drSurfaceStream(this));

    if(DR_FAILED(s->CreateRenderTarget(width, height, format, multi_sample, multi_sample_quality, lockable, handle)))
        goto __ret;

    if(DR_FAILED(_pool_surface.Register(ret_handle, s)))
        goto __ret;

    s->SetRegisterID(*ret_handle);
    s = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_RELEASE(s);
    return ret;

}
DR_RESULT drSurfaceStreamMgr::CreateDepthStencilSurface(DR_HANDLE* ret_handle, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drISurfaceStream* s = DR_NEW(drSurfaceStream(this));

    if(DR_FAILED(s->CreateDepthStencilSurface(width, height, format, multi_sample, multi_sample_quality, discard, handle)))
        goto __ret;

    if(DR_FAILED(_pool_surface.Register(ret_handle, s)))
        goto __ret;

    s->SetRegisterID(*ret_handle);
    s = 0;

    ret = DR_RET_OK;
__ret:
    DR_IF_RELEASE(s);
    return ret;

}
DR_RESULT drSurfaceStreamMgr::UnregisterSurface(DR_HANDLE handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    drISurfaceStream* ss;

    if(DR_FAILED(_pool_surface.Unregister((void**)&ss, handle)))
        goto __ret;

    if(ss)
    {
        ss->SetRegisterID(DR_INVALID_INDEX);
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}

drISurfaceStream* drSurfaceStreamMgr::GetSurfaceStream(DR_HANDLE handle)
{
    drISurfaceStream* ret = 0;

    if(DR_FAILED(_pool_surface.GetObj((void**)&ret, handle)))
        goto __ret;

__ret:
    return ret;
}

//drVertexBuffer
//DR_STD_ILELEMENTATION(drVertexBuffer)
DR_STD_GETINTERFACE(drVertexBuffer);

DR_RESULT drVertexBuffer::Release()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(Destroy()))
        goto __ret;

    drDeviceObject* devobj = reinterpret_cast<drDeviceObject*>(_dev_obj);
    devobj->_ReleaseStreamBuffer(this);

    DR_DELETE(this);

    ret = DR_RET_OK;
__ret:
    return ret;
}

drVertexBuffer::drVertexBuffer(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _buf(0), _next(0), _prev(0)
{
    _dlock_pos = 0;
    memset(&_buf_info, 0, sizeof(_buf_info));
}
drVertexBuffer::~drVertexBuffer()
{
}

DR_RESULT drVertexBuffer::Create(UINT length, DWORD usage, DWORD fvf, D3DPOOL pool, DWORD stride, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev_obj->CreateVertexBuffer(length, usage, fvf, pool, &_buf, handle)))
        goto __ret;
    
    _buf_info.fvf = fvf;
    _buf_info.size = length;
    _buf_info.usage = usage;
    _buf_info.stride = stride;
    _buf_info.pool = pool;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drVertexBuffer::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0)
        goto __addre_ret_ok;

    if(DR_FAILED(_dev_obj->ReleaseVertexBuffer(_buf)))
        goto __ret;

    _buf = 0;
    memset(&_buf_info, 0, sizeof(_buf_info));

__addre_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drVertexBuffer::LoadData(const void* data_seq, DWORD data_size, UINT offset, DWORD lock_flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0)
        goto __ret;

    if(data_seq == 0 || data_size == 0)
        goto __ret;

    if((offset + data_size) > _buf_info.size)
        goto __ret;

    D3DLOCK_TYPE* p_buf = 0;

    if(DR_FAILED(_buf->Lock(offset, (data_size == _buf_info.size) ? 0 : data_size, &p_buf, lock_flag)))
        goto __ret;

    memcpy(p_buf, data_seq, data_size);

    _buf->Unlock();

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drVertexBuffer::LoadDataDynamic(const void* data_seq, DWORD data_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 || ((_buf_info.usage & D3DUSAGE_DYNAMIC) == 0))
        goto __ret;

    if(data_seq == 0 || data_size == 0)
        goto __ret;

    if(data_size > _buf_info.size)
        goto __ret;

    DWORD lock_size;
    DWORD lock_flag;
    D3DLOCK_TYPE* p_buf = 0;

    if((_dlock_pos + data_size) > _buf_info.size)
    {
        lock_flag = D3DLOCK_DISCARD;
        _dlock_pos = 0;
        lock_size = 0;
    }
    else
    {
         lock_flag = D3DLOCK_NOOVERWRITE;
         lock_size = data_size;
    }

    if(DR_FAILED(_buf->Lock(_dlock_pos, lock_size, &p_buf, lock_flag)))
        goto __ret;

    memcpy(p_buf, data_seq, data_size);

    _buf->Unlock();

    _dlock_pos += data_size;

    ret = DR_RET_OK;
__ret:
    return ret;
}

//drIndexBuffer
//DR_STD_ILELEMENTATION(drIndexBuffer)
DR_STD_GETINTERFACE(drIndexBuffer);

DR_RESULT drIndexBuffer::Release()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(Destroy()))
        goto __ret;

    drDeviceObject* devobj = reinterpret_cast<drDeviceObject*>(_dev_obj);
    devobj->_ReleaseStreamBuffer(this);

    DR_DELETE(this);

    ret = DR_RET_OK;
__ret:
    return ret;
}

drIndexBuffer::drIndexBuffer(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _buf(0), _next(0), _prev(0)
{
    _dlock_pos = 0;
    memset(&_buf_info, 0, sizeof(_buf_info));
}
drIndexBuffer::~drIndexBuffer()
{
}

DR_RESULT drIndexBuffer::Create(UINT length, DWORD usage, D3DFORMAT format, D3DPOOL pool, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev_obj->CreateIndexBuffer(length, usage, format, pool, &_buf, handle)))
        goto __ret;
    
    _buf_info.size = length;
    _buf_info.pool = pool;
    _buf_info.usage = usage;
    _buf_info.format = format;
    _buf_info.stride = format == D3DFMT_INDEX16 ? sizeof(WORD) : sizeof(DWORD);

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drIndexBuffer::Destroy()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0)
        goto __addre_ret_ok;

    if(DR_FAILED(_dev_obj->ReleaseIndexBuffer(_buf)))
        goto __ret;

    _buf = 0;
    memset(&_buf_info, 0, sizeof(_buf_info));

__addre_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drIndexBuffer::LoadData(const void* data_seq, DWORD data_size, UINT offset, DWORD lock_flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0)
        goto __ret;

    if(data_seq == 0 || data_size == 0)
        goto __ret;

    if((offset + data_size) > _buf_info.size)
        goto __ret;

    D3DLOCK_TYPE* p_buf = 0;

    if(DR_FAILED(_buf->Lock(offset, (data_size == _buf_info.size) ? 0 : data_size, &p_buf, lock_flag)))
        goto __ret;

    memcpy(p_buf, data_seq, data_size);

    _buf->Unlock();

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drIndexBuffer::LoadDataDynamic(const void* data_seq, DWORD data_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_buf == 0 || ((_buf_info.usage & D3DUSAGE_DYNAMIC) == 0))
        goto __ret;

    if(data_seq == 0 || data_size == 0)
        goto __ret;

    if(data_size > _buf_info.size)
        goto __ret;

    DWORD lock_size;
    DWORD lock_flag;
    D3DLOCK_TYPE* p_buf = 0;

    if((_dlock_pos + data_size) > _buf_info.size)
    {
        lock_flag = D3DLOCK_DISCARD;
        _dlock_pos = 0;
        lock_size = 0;
    }
    else
    {
         lock_flag = D3DLOCK_NOOVERWRITE;
         lock_size = data_size;
    }

    if(DR_FAILED(_buf->Lock(_dlock_pos, lock_size, &p_buf, lock_flag)))
        goto __ret;

    memcpy(p_buf, data_seq, data_size);

    _buf->Unlock();

    _dlock_pos += data_size;

    ret = DR_RET_OK;
__ret:
    return ret;
}


DR_END
