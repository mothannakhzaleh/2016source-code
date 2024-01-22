//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drFrontAPI.h"
#include "drShaderTypes.h"
#include "drInterfaceExt.h"

DR_BEGIN

// ===============================================
// directX8 shader manager
#if(defined DR_USE_DX8)

struct drShaderInfo8
{
    BYTE* data;
    BYTE* decl;
    DWORD size;
    DWORD handle;
};

class drShaderMgr8 : public drIShaderMgr
{
    typedef drShaderInfo8 drShaderInfo;

DR_STD_DECLARATION()

private:
    drIDeviceObject* _dev_obj;
    drShaderInfo* _vs_seq;
    DWORD _vs_size;
    DWORD _vs_num;

    drIShaderDeclMgr* _decl_mgr;

public:
    drShaderMgr8(drIDeviceObject* dev_obj);
    ~drShaderMgr8();


    DR_RESULT Init(DWORD vs_buf_size, DWORD ps_buf_size);
    DR_RESULT RegisterVertexShader(DWORD type, DWORD* code, DWORD size, DWORD usage, DWORD* decl, DWORD decl_size);
    DR_RESULT RegisterVertexShader(DWORD type, const char* file, DWORD usage, DWORD* decl, DWORD decl_size, DWORD binary_flag);
    DR_RESULT UnregisterVertexShader(DWORD type);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    DR_RESULT QueryVertexShader(DWORD* ret_obj, DWORD type);
    drIShaderDeclMgr* GetShaderDeclMgr() { return _decl_mgr; }
    
};

typedef drShaderMgr8 drShaderMgr;

#endif

// ===============================================
// directX9 shader manager
#if(defined DR_USE_DX9)

class drShaderMgr9 : public drIShaderMgr
{
DR_STD_DECLARATION()

private:
    drIDeviceObject* _dev_obj;
    drVertexShaderInfo* _vs_seq;
    drVertDeclInfo9* _decl_seq;
    DWORD _vs_size;
    DWORD _vs_num;
    DWORD _decl_size;
    DWORD _decl_num;

    drIShaderDeclMgr* _decl_mgr;

public:
    drShaderMgr9(drIDeviceObject* dev_obj);
    ~drShaderMgr9();


    DR_RESULT Init(DWORD vs_buf_size, DWORD decl_buf_size, DWORD ps_buf_size);
    DR_RESULT RegisterVertexShader(DWORD type, BYTE* data, DWORD size);
    DR_RESULT RegisterVertexShader(DWORD type, const char* file, DWORD binary_flag);
    DR_RESULT RegisterVertexDeclaration(DWORD type, D3DVERTEXELEMENT9* data);
    DR_RESULT LoseDevice();
    DR_RESULT ResetDevice();

    DR_RESULT QueryVertexShader(IDirect3DVertexShaderX** ret_obj, DWORD type);
    DR_RESULT QueryVertexDeclaration(IDirect3DVertexDeclarationX** ret_obj, DWORD type);

    drVertexShaderInfo* GetVertexShaderInfo(DWORD type) { return &_vs_seq[type]; }
    
    drIShaderDeclMgr* GetShaderDeclMgr() { return _decl_mgr; }
};

typedef drShaderMgr9 drShaderMgr;

#endif

DR_END
