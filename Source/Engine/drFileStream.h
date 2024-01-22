//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

DR_BEGIN

class drFileStream : public drIFileStream
{
    DR_STD_DECLARATION()

private:
    drIFile* _adapter_file;
    drFileStreamOpenInfo _fsoi;

private:

public:
    drFileStream();
    ~drFileStream();

    DR_RESULT Open(const char* file, const drFileStreamOpenInfo* info);
    DR_RESULT Close();
    DR_RESULT Read(void* buf, DWORD in_size, DWORD* out_size);
    DR_RESULT Write(const void* buf, DWORD in_size, DWORD* out_size);
    DR_RESULT Seek(DWORD* pos, long offset, DWORD flag);
    DR_RESULT GetSize(DWORD* size);
    DR_RESULT Flush();
    DR_RESULT SetEnd();

};

DR_END
