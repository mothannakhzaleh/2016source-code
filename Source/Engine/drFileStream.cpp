//
#include "drFileStream.h"
#include "drGuidObj.h"

DR_BEGIN

//drFileStream
DR_STD_ILELEMENTATION(drFileStream)

drFileStream::drFileStream()
{
    _adapter_file = 0;
}

drFileStream::~drFileStream()
{
    Close();
}

DR_RESULT drFileStream::Open(const char* file, const drFileStreamOpenInfo* info)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(Close()))
        goto __ret;

    if(info->adapter_type == FS_ADAPTER_FILE)
    {
        if(DR_FAILED(drGUIDCreateObject((lxvoid**)&_adapter_file, DR_GUID_FILE)))
            goto __ret;

        if(DR_FAILED(_adapter_file->CreateFile(file, info->access_flag, NULL, 0, info->create_flag, info->attributes_flag)))
            goto __ret;
    }


    _fsoi = *info;

    ret = DR_RET_OK;

__ret:
    if(DR_FAILED(ret))
    {
        Close();
    }
    return ret;
}

DR_RESULT drFileStream::Close()
{
    DR_SAFE_RELEASE(_adapter_file);
    memset(&_fsoi, 0, sizeof(_fsoi));

    return DR_RET_OK;
}

DR_RESULT drFileStream::Read(void* buf, DWORD in_size, DWORD* out_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_fsoi.adapter_type == FS_ADAPTER_FILE)
    {
        if(_adapter_file == 0)
            goto __ret;

        if(DR_FAILED(_adapter_file->Read(buf, in_size, out_size)))
            goto __ret;
    }
    else if(_fsoi.adapter_type == FS_ADAPTER_PACKET)
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drFileStream::Write(const void* buf, DWORD in_size, DWORD* out_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_fsoi.adapter_type == FS_ADAPTER_FILE)
    {
        if(_adapter_file == 0)
            goto __ret;

        if(DR_FAILED(_adapter_file->Write(buf, in_size, out_size)))
            goto __ret;
    }
    else if(_fsoi.adapter_type == FS_ADAPTER_PACKET)
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drFileStream::Seek(DWORD* pos, long offset, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_fsoi.adapter_type == FS_ADAPTER_FILE)
    {
        if(_adapter_file == 0)
            goto __ret;

        if(pos)
        {
            *pos = _adapter_file->Seek(offset, flag);
        }
    }
    else if(_fsoi.adapter_type == FS_ADAPTER_PACKET)
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drFileStream::GetSize(DWORD* size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_fsoi.adapter_type == FS_ADAPTER_FILE)
    {
        if(_adapter_file == 0)
            goto __ret;

        if(size)
        {
            *size = _adapter_file->GetSize();
        }
    }
    else if(_fsoi.adapter_type == FS_ADAPTER_PACKET)
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drFileStream::Flush()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_fsoi.adapter_type == FS_ADAPTER_FILE)
    {
        if(_adapter_file == 0)
            goto __ret;

        if(DR_FAILED(_adapter_file->Flush()))
            goto __ret;
    }
    else if(_fsoi.adapter_type == FS_ADAPTER_PACKET)
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drFileStream::SetEnd()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_fsoi.adapter_type == FS_ADAPTER_FILE)
    {
        if(_adapter_file == 0)
            goto __ret;

        if(DR_FAILED(_adapter_file->SetEnd()))
            goto __ret;
    }
    else if(_fsoi.adapter_type == FS_ADAPTER_PACKET)
    {
        goto __ret;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_END
