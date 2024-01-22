//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"


DR_BEGIN

class drDirectoryBrowser : public drIDirectoryBrowser
{ 
    DR_STD_DECLARATION()

private: 
    drDirectoryBrowserProc _proc;
    void* _param;

private:
    DR_RESULT _Go(const char* file, DWORD flag);

public: 
    drDirectoryBrowser(); 

    void SetBrowseProc(drDirectoryBrowserProc proc, void* param) { _proc = proc; _param = param; }
    DR_RESULT Browse(const char *file, DWORD flag);

}; 


DR_END
