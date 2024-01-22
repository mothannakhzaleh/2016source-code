//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drFrontAPI.h"
#include "drShaderTypes.h"
#include "drInterfaceExt.h"

DR_BEGIN

// ===============================================
enum
{
    SHADER_DECL_SET_NUM =       16,
    SHADER_DECL_NUM =           32,
};


class drShaderDeclInfo
{
public:
    DWORD shader_id;
    DWORD light_type;
    DWORD anim_type;
    char file[ DR_MAX_NAME ];

public:
    drShaderDeclInfo()
        :shader_id( DR_INVALID_INDEX ), 
        light_type( DR_INVALID_INDEX ), 
        anim_type( DR_INVALID_INDEX )
    {}
};


class drShaderDeclSet
{
public:
    DWORD decl_id;
    DWORD decl_num;
    drShaderDeclInfo* decl_seq;

public:
   drShaderDeclSet( DWORD decl_type, DWORD decl_size )
    {
        decl_id = decl_type;
        decl_num = decl_size;
        decl_seq = DR_NEW( drShaderDeclInfo[ decl_num ] );
    }
    ~drShaderDeclSet()
    {
        DR_SAFE_DELETE_A( decl_seq );
    }
};


class drShaderDeclMgr : public drIShaderDeclMgr
{
DR_STD_DECLARATION()

private:
    drIShaderMgr* _shader_mgr;
    drShaderDeclSet* _decl_set[ SHADER_DECL_NUM ];

public:
    drShaderDeclMgr( drIShaderMgr* shader_mgr );
    virtual ~drShaderDeclMgr();

    DR_RESULT CreateShaderDeclSet( DWORD decl_type, DWORD buf_size );
    DR_RESULT SetShaderDeclInfo( drShaderDeclCreateInfo* info );
    DR_RESULT QueryShaderHandle( DWORD* shader_handle, const drShaderDeclQueryInfo* info );
};

DR_END
