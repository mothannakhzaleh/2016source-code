//

#include "drDirectoryBrowser.h" 

DR_BEGIN

// drDirectoryBrowser
DR_STD_ILELEMENTATION(drDirectoryBrowser)

drDirectoryBrowser::drDirectoryBrowser()
: _proc(0), _param(0)
{
}

DR_RESULT drDirectoryBrowser::_Go(const char* file, DWORD flag)
{
    DR_RESULT ret = DR_RET_OK;

    WIN32_FIND_DATA wfd;

    HANDLE handle = ::FindFirstFile(file, &wfd);

    if(handle == INVALID_HANDLE_VALUE)
        goto __ret;

    char file_path[260];
    char file_spec[64];

    strncpy_s(file_path, file, _TRUNCATE);
    char* p = strrchr(file_path, '\\');
    if(p == 0)
        goto __ret;

    strncpy_s(file_spec, &p[1], _TRUNCATE);
    p[1] = '\0';

    do
    {
        if(wfd.cFileName[0] == '.')
        {
            if((wfd.cFileName[1] == '\0')
                || (wfd.cFileName[1] == '.' && wfd.cFileName[2] == '\0'))
            {
                continue;
            }
        }

        if((!(wfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)) && (flag & DIR_BROWSE_FILE))
        {
            if(DR_FAILED((*_proc)(file_path, &wfd, _param)))
            {
                ret = DR_RET_OK_1;
                goto __ret;
            }
        }
        else if((wfd.dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) && (flag & DIR_BROWSE_DIRECTORY))
        {
            if(DR_FAILED((*_proc)(file_path, &wfd, _param)))
            {
                ret = DR_RET_OK_1;
                goto __ret;
            }

            char sub_file[260];
            _snprintf_s(sub_file, 260 ,_TRUNCATE,"%s%s\\%s", file_path, wfd.cFileName, file_spec);

            if((ret = _Go(sub_file, flag)) == DR_RET_OK_1)
                goto __ret;
        }

    } while(::FindNextFile(handle, &wfd));


__ret:
    ::FindClose(handle);

    return ret;
}

DR_RESULT drDirectoryBrowser::Browse(const char *file, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_proc == 0)
        goto __ret;

    //char* p = strrchr(file, '\\');
    //if((p == 0) || (p[1] == '\0'))
    //    goto __ret;

    ret = _Go(file, flag);

__ret:
    return ret;
}

DR_END
