//
#include "stdafx.h"

#include "drFile.h"
#include <MyMemory.h>

DR_BEGIN

//drFile
DWORD drFile::__dummy = 0;

DR_STD_ILELEMENTATION(drFile)

DR_RESULT drFile::_CheckDirectory(const char* path)
{
    DWORD a = GetFileAttributes(path);

    if(a == INVALID_FILE_ATTRIBUTES)
        return DR_RET_FAILED;

    return (a & FILE_ATTRIBUTE_DIRECTORY) ? DR_RET_OK : DR_RET_FAILED;
}

DR_RESULT drFile::CreateDirectory(const char* path, LPSECURITY_ATTRIBUTES attr)
{
    char buf[_MAX_PATH];
    char* ptr = buf;

    _tcsncpy_s(buf, path, _TRUNCATE);

    do
    {
        ptr = _tcschr(ptr, '\\');

        if(ptr != NULL)
            *ptr = '\0';

        if(DR_FAILED(_CheckDirectory(buf)))
        {
            if(::CreateDirectory(buf, attr) == 0)
                return DR_RET_FAILED;
        }

        if(ptr == NULL)
            break;

        *ptr = '\\';
        ptr += 1;

    } while(1);

    return DR_RET_OK;
}
//
DR_RESULT drFile::CreateFile(const char* file, DWORD access_flag, DWORD share_mode, LPSECURITY_ATTRIBUTES secu_attr, DWORD creation_flag, DWORD attributes_flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    char* ptr;
    char path[_MAX_PATH];
    _tcsncpy_s(path, file, _TRUNCATE);
    
    if(access_flag == GENERIC_WRITE)
    {
        if((ptr = _tcsrchr(path, '\\')))
        {
            *ptr = '\0';

            if(DR_FAILED(_CheckDirectory(path)))
            {
                if(DR_FAILED(CreateDirectory(path, 0)))
                    goto __ret;
            }
        }
    }

    _handle = ::CreateFile(file, access_flag, share_mode, secu_attr, creation_flag, attributes_flag, 0);

    if(_handle == INVALID_HANDLE_VALUE)
        goto __ret;

    _tcsncpy_s(_file, file, _TRUNCATE);


    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drFile::LoadFileBuffer(const char* file, drIBuffer* buf)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD in_size;
    DWORD out_size;
    DWORD access_flag;
    DWORD creation_flag;
    DWORD attributes_flag;

    access_flag = GENERIC_READ;
    creation_flag = OPEN_EXISTING;
    attributes_flag = FILE_FLAG_SEQUENTIAL_SCAN;

    if(file == 0 || buf == 0)
        goto __ret;

    if(DR_FAILED(CreateFile(file, access_flag, FILE_SHARE_READ, 0, creation_flag, attributes_flag)))
        goto __ret;

    in_size = GetSize();

    buf->Free();
    buf->Alloc(in_size);

    if(DR_FAILED(Read(buf->GetData(), in_size, &out_size)))
        goto __ret;
    if(in_size != out_size)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drFile::SaveFileBuffer(const char* file, drIBuffer* buf)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD in_size;
    DWORD out_size;
    DWORD access_flag;
    DWORD creation_flag;
    DWORD attributes_flag;

    access_flag = GENERIC_WRITE;
    creation_flag = CREATE_ALWAYS;
    attributes_flag = FILE_FLAG_SEQUENTIAL_SCAN;

    if(file == 0 || buf == 0)
        goto __ret;

    if(buf->GetSize() == 0)
        goto __ret;

    if(DR_FAILED(CreateFile(file, access_flag, FILE_SHARE_READ, 0, creation_flag, attributes_flag)))
        goto __ret;

    in_size = buf->GetSize();

    if(DR_FAILED(Write(buf->GetData(), in_size, &out_size)))
        goto __ret;
    if(in_size != out_size)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drFile::Close()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_handle == INVALID_HANDLE_VALUE)
        goto __addr_ret_ok;

    if(CloseHandle(_handle) == 0)
        goto __ret;

    _handle = INVALID_HANDLE_VALUE;

__addr_ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}


DR_RESULT drFile::Read(void* buf, DWORD in_size, DWORD* out_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(out_size == 0)
        out_size = &__dummy;

    if(ReadFile(_handle, buf, in_size, out_size, 0) == 0)
        goto __ret;
    if(in_size != *out_size)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drFile::Write(const void* buf, DWORD in_size, DWORD* out_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(out_size == 0)
        out_size = &__dummy;

    if(WriteFile(_handle, buf, in_size, out_size, 0) == 0)
        goto __ret;
    if(in_size != *out_size)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drFile::Seek(long offset, DWORD flag) 
{
    DR_RESULT ret = DR_RET_FAILED;

    if(SetFilePointer(_handle, offset, 0, flag) == INVALID_SET_FILE_POINTER)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drFile::GetCreationTime(SYSTEMTIME* st)
{
    DR_RESULT ret = DR_RET_FAILED;

	FILETIME ft, lft;

	memset(&ft, 0, sizeof(FILETIME));

	if(GetFileTime(_handle, NULL, NULL, &ft) == 0)
        goto __ret;

    memset(&lft, 0, sizeof(lft));

    if(FileTimeToLocalFileTime(&ft, &lft) == 0)
        goto __ret;

	memset(st, 0, sizeof(SYSTEMTIME));

    if(FileTimeToSystemTime(&lft, st) == 0)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drFile::CheckExisting(const char* path, DWORD check_directory)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD attr = GetFileAttributes(path);
    if(attr == INVALID_FILE_ATTRIBUTES)
        goto __ret;

    if(check_directory && ((attr &FILE_ATTRIBUTE_DIRECTORY) == 0))
        goto __ret;
    
    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drFile::MoveData(DWORD src_pos, DWORD dst_pos, DWORD size)
{
    DR_RESULT ret = DR_RET_OK;

    if(src_pos == dst_pos)
        goto __addr_ret_ok;

    DWORD src_pos_end = src_pos + size;
    DWORD dst_pos_end = dst_pos + size;

    const DWORD max_move_chunk_size = 1024 * 1024; // 1M bytes every moving

    DWORD op_size;
    DWORD move_chunk_size;
    DWORD s;

    op_size = 0;
    move_chunk_size = max_move_chunk_size;


    BYTE* move_buf = new(BYTE[max_move_chunk_size]);

    int loop_flag = 1;

    if((dst_pos > src_pos && dst_pos < src_pos_end)
        || (dst_pos_end > src_pos && dst_pos_end < src_pos_end))
    {
        // overlapped region
        while(loop_flag)
        {
            if(src_pos + op_size + move_chunk_size > src_pos_end)
            {
                move_chunk_size = src_pos_end - src_pos - op_size;
                loop_flag = 0;
            }

            //s = move_chunk_size;

            // read src data
            Seek(src_pos_end - op_size - move_chunk_size, FILE_BEGIN);
            Read(move_buf, move_chunk_size, &s);
            assert(s == move_chunk_size);

            // write dst data
            Seek(dst_pos_end - op_size - move_chunk_size, FILE_BEGIN);
            Write(move_buf, move_chunk_size, &s);
            assert(s == move_chunk_size);
        }
    }
    else
    {
        do
        {
            if(src_pos + op_size + move_chunk_size > src_pos_end)
            {
                move_chunk_size = src_pos_end - src_pos - op_size;
                loop_flag = 0;
            }

            //s = move_chunk_size;

            // read src data
            Seek(src_pos + op_size, FILE_BEGIN);
            Read(move_buf, move_chunk_size, &s);
            assert(s == move_chunk_size);

            // write dst data
            Seek(dst_pos + op_size, FILE_BEGIN);
            Write(move_buf, move_chunk_size, &s);
            assert(s == move_chunk_size);
            

        } while(loop_flag);
    }

    delete [] move_buf;

__addr_ret_ok:
    ret = DR_RET_OK;

    return ret;
}

DR_RESULT drFile::ReplaceData(DWORD pos, const void* buf, DWORD size)
{
    Seek(pos, FILE_BEGIN);

    DWORD s;
    Write(buf, size, &s);

    return DR_RET_OK;
}

DR_RESULT drFile::InsertData(DWORD pos, const void* buf, DWORD size)
{
    DWORD cur_size = GetSize();

    if((pos > cur_size) || (size < 0))
        return DR_RET_FAILED;

    Seek(size, FILE_END);
    SetEnd();

    if(pos < cur_size)
    {
        DWORD move_size = cur_size - pos;

        MoveData(pos, cur_size + size - move_size, move_size); 
    }

    DWORD s;
    Seek(pos, FILE_BEGIN);
    Write(buf, size, &s);

    return DR_RET_OK;

}

DR_RESULT drFile::RemoveData(DWORD pos, DWORD size)
{
    DWORD cur_size = GetSize();

    if(pos >= cur_size)
        return DR_RET_FAILED;

    DWORD end_pos = pos + size;
    DWORD truncate_pos;

    if(end_pos > cur_size)
    {
        truncate_pos = pos;        
    }
    else
    {
        MoveData(end_pos, pos, cur_size - end_pos);        
        truncate_pos = cur_size - size;
    }

    Seek(truncate_pos, FILE_BEGIN);
    SetEnd();

    return DR_RET_OK;
}

// drFileDialog
DR_STD_ILELEMENTATION(drFileDialog)

DR_RESULT drFileDialog::GetOpenFileName(HWND hwnd, char* buf, int num, const char* dir, const char* title, const char* filter, int flag)
{
	OPENFILENAME	ofn;				// common dialog box structure
    memset(&ofn,0,sizeof(ofn));

	//char ret_buf[1024]={"\0"};
	// Initialize OPENFILENAME
	ZeroMemory(&ofn, sizeof(OPENFILENAME));
	ofn.lStructSize = sizeof(OPENFILENAME);
	ofn.hwndOwner = hwnd;
	ofn.lpstrFile = buf;
	ofn.nMaxFile = num;
	ofn.lpstrFilter = filter;
	ofn.lpstrTitle = title;
	ofn.lpstrInitialDir = dir;
	ofn.Flags = flag;
    ofn.nFilterIndex = 1;
	// Display the Open dialog box. 
    if(::GetOpenFileName(&ofn) != TRUE) 
		return DR_RET_FAILED;

    // MultiSelected style , break file and directory
    if( flag & OFN_FILEMUSTEXIST ) 
    {
        *(ofn.lpstrFile + ofn.nFileOffset - 1 ) = '\0';
    }

	//strcpy_s(buf,ofn.lpstrFile);
    return DR_RET_OK;
}

DR_RESULT drFileDialog::GetSaveFileName(HWND hwnd, char* buf, int num, const char* dir, const char* title, const char* filter, const char* ext, int flag)
{
    OPENFILENAME	ofn;				// common dialog box structure
    memset(&ofn,0,sizeof(OPENFILENAME));

    // Initialize OPENFILENAME
    ZeroMemory(&ofn, sizeof(OPENFILENAME));
    ofn.lStructSize = sizeof(OPENFILENAME);
    ofn.hwndOwner = hwnd;
    ofn.lpstrFile = buf;
    ofn.nMaxFile = num;
    ofn.lpstrFilter = filter;
    ofn.lpstrTitle = title;
    ofn.lpstrInitialDir = dir;
    ofn.lpstrDefExt = ext;
    ofn.Flags = flag;
    ofn.nFilterIndex = 1;
    // Display the Open dialog box. 
    
    return (::GetSaveFileName(&ofn) == TRUE) ? DR_RET_OK : DR_RET_FAILED;
}


DR_END
