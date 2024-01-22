//
#pragma once

#include "drHeader.h"
#include "drITypes.h"
#include "drInterfaceExt.h"

DR_BEGIN

class drPathInfo : public drIPathInfo
{
public:
    char _path_buf[ PATH_TYPE_NUM ][ DR_MAX_PATH ];

DR_STD_DECLARATION()

public:
    drPathInfo();

    char* SetPath( DWORD type, const char* path );
    char* GetPath( DWORD type );

};

class drOptionMgr : public drIOptionMgr
{
DR_STD_DECLARATION()
private:
    BYTE _ignore_model_tex_flag;
    BYTE _byte_flag_seq[MAX_OPTION_BYTE_FLAG];

public:
    drOptionMgr();
    ~drOptionMgr();
    void SetIgnoreModelTexFlag(BYTE flag) { _ignore_model_tex_flag = flag; }
    BYTE GetIgnoreModelTexFlag() const { return _ignore_model_tex_flag; }
    void SetByteFlag(DWORD type, BYTE value) { _byte_flag_seq[type] = value; }
    BYTE GetByteFlag(DWORD type) const { return _byte_flag_seq[type]; }
};


DR_END
