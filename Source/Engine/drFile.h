//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

DR_BEGIN

class drFile : public drIFile
{
    DR_STD_DECLARATION();

    static DWORD __dummy;

private:
    HANDLE _handle;
    char _file[DR_MAX_PATH];

private:
    DR_RESULT _CheckDirectory(const char* path);
public:
    drFile() : _handle(INVALID_HANDLE_VALUE) { _file[0] = '\0'; }
    ~drFile() { Close(); }

    // Create Description
    // access_flag[in]: GENERIC_READ / GENERIC_WRITE
    // share_model[in]: 0 / FILE_SHARE_DELETE / FILE_SHARE_READ / FILE_SHARE_WRITE
    // creation_flag[in]: CREATE_NEW / CREATE_ADRAYS / OPEN_EXISTING / OPEN_ADRAYS / TRUNCATE_EXISTING
    DR_RESULT CreateFile(const char* file,DWORD access_flag, DWORD share_mode, LPSECURITY_ATTRIBUTES secu_attr, DWORD creation_flag, DWORD attributes_flag = FILE_FLAG_SEQUENTIAL_SCAN);
    DR_RESULT CreateDirectory(const char* path, LPSECURITY_ATTRIBUTES attr);
    DR_RESULT LoadFileBuffer(const char* file, drIBuffer* buf);
    DR_RESULT SaveFileBuffer(const char* file, drIBuffer* buf);
    DR_RESULT Close();
    DR_RESULT Read(void* buf, DWORD in_size, DWORD* out_size);
    DR_RESULT Write(const void* buf, DWORD in_size, DWORD* out_size);

    HANDLE GetHandle() const { return _handle; }
    const char* GetFileName() { return _file; }
    DR_RESULT GetCreationTime(SYSTEMTIME* st);
    DR_RESULT CheckExisting(const char* path, DWORD check_directory);

    // Seek Description
    // flag[in]: FILE_BEGIN / FILE_CURRENT / FILE_END
    DR_RESULT Seek(long offset, DWORD flag);
    DWORD GetSize() { return GetFileSize(_handle, 0); }
    DR_RESULT Flush() { return FlushFileBuffers(_handle); }
    DR_RESULT SetEnd() { return SetEndOfFile(_handle); }

    DR_RESULT MoveData(DWORD src_pos, DWORD dst_pos, DWORD size);
    DR_RESULT ReplaceData(DWORD pos, const void* buf, DWORD size);
    DR_RESULT InsertData(DWORD pos, const void* buf, DWORD size);
    DR_RESULT RemoveData(DWORD pos, DWORD size);

};

class drFileDialog : public drIFileDialog
{
    DR_STD_DECLARATION();

public:
    // int flag = OFN_PATHMUSTEXIST | OFN_EXPLORER | OFN_FILEMUSTEXIST | OFN_ALLOWMULTISELECT | OFN_HIDEREADONLY
    DR_RESULT GetOpenFileName(HWND hwnd, char* buf, int num, const char* dir, const char* title = 0,
                               const char* filter = "all files(*.*)\0*.*\0\0", int flag = OFN_PATHMUSTEXIST | OFN_EXPLORER);

    // flag = OFN_FILEMUSTEXIST | OFN_ALLOWMULTISELECT | OFN_HIDEREADONLY
    DR_RESULT GetSaveFileName(HWND hwnd, char* buf, int num, const char* dir, const char* title = 0,
                               const char* filter = "all files(*.*)\0*.*\0\0",const char* ext = 0, int flag = OFN_PATHMUSTEXIST | OFN_EXPLORER);

};


DR_END
