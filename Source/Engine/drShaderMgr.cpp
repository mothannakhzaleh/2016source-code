#include "drShaderMgr.h"
#include "drInterface.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drResourceMgr.h"
#include "drShaderDeclMgr.h"

DR_BEGIN


//
#if (defined DR_USE_DX8)

DR_STD_ILELEMENTATION(drShaderMgr8)

drShaderMgr8::drShaderMgr8(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _vs_seq(0), _vs_size(0), _vs_num(0), _decl_mgr(0)
{
}

drShaderMgr8::~drShaderMgr8()
{
    for(DWORD i = 0; _vs_num > 0; i++)
    {
        if(_vs_seq[i].handle)
        {
            UnregisterVertexShader(i);
            //DR_DELETE_A(_vs_seq[i].data);
            //_vs_num -= 1;
        }
    }

    DR_IF_DELETE_A(_vs_seq);

    DR_IF_RELEASE(_decl_mgr);
}

DR_RESULT drShaderMgr8::Init(DWORD vs_buf_size, DWORD ps_buf_size)
{
    _vs_num = 0;
    _vs_size = vs_buf_size;
    _vs_seq = DR_NEW(drShaderInfo[_vs_size]); 
    memset(_vs_seq, 0, sizeof(drShaderInfo) * _vs_size);


    _decl_mgr = DR_NEW(drShaderDeclMgr(this));

    return DR_RET_OK;
}

DR_RESULT drShaderMgr8::RegisterVertexShader(DWORD type, DWORD* code, DWORD size, DWORD usage, DWORD* decl, DWORD decl_size)
{
    DR_RESULT ret = DR_RET_FAILED;

    DWORD handle;
    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    if(type < 0 || type >= _vs_size)
        goto __ret;

    if(_vs_seq[type].handle)
        goto __ret;

    if(FAILED(dev->CreateVertexShader(decl, code, &handle, usage)))
        goto __ret;


    drShaderInfo8* i = &_vs_seq[type];
    i->handle = handle;
    i->size = size;
    i->data = DR_NEW(BYTE[i->size]);
    i->decl = DR_NEW(BYTE[decl_size]);
    memcpy(i->data, code, size);
    memcpy(i->decl, decl, decl_size);

    // increase num counter
    _vs_num += 1;

    ret = DR_RET_OK;

__ret:

    return ret;
}
DR_RESULT drShaderMgr8::RegisterVertexShader(DWORD type, const char* file, DWORD usage, DWORD* decl, DWORD decl_size, DWORD binary_flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    long size = 0;
    BYTE* data = 0;
    DWORD* code = 0;
    ID3DXBuffer* buf_code = 0;
    ID3DXBuffer* buf_error = 0;

    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == NULL)
        goto __ret;

	fseek(fp, 0, SEEK_END);
	
	size = ftell(fp);
    data = DR_NEW(BYTE[size]);

	fseek(fp, 0, SEEK_SET);

    fread(data, size, 1, fp);

    fclose(fp);
   

    if(binary_flag)
    {
        code = (DWORD*)data;
    }
    else
    {
        if(FAILED(D3DXAssembleShader(data, size, 0, NULL, &buf_code, &buf_error)))
            goto __ret;

        code = (DWORD*)buf_code->GetBufferPointer();
        size = buf_code->GetBufferSize();
    }

    ret = RegisterVertexShader(type, code, size, usage, decl, decl_size);

    
__ret:
    DR_SAFE_DELETE_A(data);
    DR_SAFE_RELEASE(buf_code);
    DR_SAFE_RELEASE(buf_error);

    return ret;
}
DR_RESULT drShaderMgr8::UnregisterVertexShader(DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;
    
    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    if(type < 0 || type >= _vs_size)
        goto __ret;

    drShaderInfo* s = &_vs_seq[type];

    if(s == 0)
        goto __ret;

    dev->DeleteVertexShader(s->handle);

    s->handle = 0;
    s->size = 0;
    DR_SAFE_DELETE_A(s->data);
    DR_SAFE_DELETE_A(s->decl);

    _vs_num -= 1;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drShaderMgr8::QueryVertexShader(DWORD* ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(type < 0 || type >= _vs_size)
        goto __ret;

    if(_vs_seq[type].handle == 0)
        goto __ret;

    *ret_obj = _vs_seq[type].handle;

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drShaderMgr8::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    drShaderInfo* s;

    for(DWORD i = 0; i < _vs_size; i++)
    {
        s = &_vs_seq[i];

        if(s->handle)
        {
            if(FAILED(dev->DeleteVertexShader(s->handle)))
                goto __ret;

            s->handle = 0;
        }
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drShaderMgr8::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    drShaderInfo* s;

    for(DWORD i = 0; i < _vs_size; i++)
    {
        s = &_vs_seq[i];

        if(s->handle == 0 && s->data)
        {
            if(FAILED(dev->CreateVertexShader((DWORD*)s->decl, (DWORD*)s->data, &s->handle, 0)))
                goto __ret;
        }
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}
#endif

// =================================
#if(defined DR_USE_DX9)

DR_STD_ILELEMENTATION(drShaderMgr9)

drShaderMgr9::drShaderMgr9(drIDeviceObject* dev_obj)
: _dev_obj(dev_obj), _vs_seq(0), _vs_size(0), _vs_num(0),
  _decl_seq(0), _decl_size(0), _decl_num(0), _decl_mgr(0)
{
}

drShaderMgr9::~drShaderMgr9()
{
    for(DWORD i = 0; _vs_num > 0; i++)
    {
        if(_vs_seq[i].handle)
        {
            DR_DELETE_A(_vs_seq[i].data);
            DR_RELEASE(_vs_seq[i].handle);
            _vs_num -= 1;
        }
    }

    for(DWORD i = 0; _decl_num > 0; i++)
    {
        if(_decl_seq[i].handle)
        {
            DR_DELETE_A(_decl_seq[i].data);
            DR_RELEASE(_decl_seq[i].handle);
            _decl_num -= 1;
        }
    }

    DR_IF_RELEASE(_decl_mgr);
}

DR_RESULT drShaderMgr9::Init(DWORD vs_buf_size, DWORD decl_buf_size, DWORD ps_buf_size)
{
    _vs_num = 0;
    _vs_size = vs_buf_size;
    _vs_seq = DR_NEW(drVertexShaderInfo[_vs_size]); 
    memset(_vs_seq, 0, sizeof(drVertexShaderInfo) * _vs_size);

    _decl_num = 0;
    _decl_size = decl_buf_size;
    _decl_seq = DR_NEW(drVertDeclInfo9[_decl_size]);
    memset(_decl_seq, 0, sizeof(drVertDeclInfo9) * _decl_size);

    _decl_mgr = DR_NEW(drShaderDeclMgr(this));

    return DR_RET_OK;
}

DR_RESULT drShaderMgr9::RegisterVertexShader(DWORD type, BYTE* data, DWORD size)
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    IDirect3DVertexShaderX* handle;

    if(type < 0 || type >= _vs_size)
        goto __ret;

    if(_vs_seq[type].handle)
        goto __ret;


    if(FAILED(dev->CreateVertexShader((DWORD*)data, &handle)))
        goto __ret;


    drVertexShaderInfo* i = &_vs_seq[type];
    i->handle = handle;
    i->size = size;
    i->data = DR_NEW(BYTE[size]);
    memcpy(i->data, data, size);

    // increase num counter
    _vs_num += 1;

    ret = DR_RET_OK;

__ret:

    return ret;

}
DR_RESULT drShaderMgr9::RegisterVertexShader(DWORD type, const char* file, DWORD file_flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    long size = 0;
    BYTE* data = 0;
    BYTE* code = 0;

    ID3DXBuffer* buf_code = 0;
    ID3DXBuffer* buf_error = 0;

    FILE* fp;
	fopen_s( &fp, file, "rb");
    if(fp == NULL)
        goto __ret;

	fseek(fp, 0, SEEK_END);
	
	size = ftell(fp);
    data = DR_NEW(BYTE[size]);

	fseek(fp, 0, SEEK_SET);

    fread(data, size, 1, fp);

    fclose(fp);
   
    if(file_flag == VS_FILE_OBJECT)
    {
        code = data;
    }
    else
    {

#if(defined DR_SHADER_DEBUG_VS)
        DWORD compile_flag = 0;
        compile_flag |= D3DXSHADER_DEBUG;
        //compile_flag |= D3DXSHADER_FORCE_VS_SOFTWARE_NOOPT;

        if(file_flag == VS_FILE_ASM)
        {
            if(FAILED(D3DXAssembleShaderFromFile(
                file,
                NULL, 
                NULL, 
                compile_flag, 
                &buf_code, 
                &buf_error)))
            {
                goto __ret;
            }
        }
        else if(file_flag == VS_FILE_HLSL)
        {

            if(FAILED(D3DXCompileShaderFromFile(
                file,
                NULL,
                NULL,
                "main",
                "vs_1_1",
                compile_flag,
                &buf_code,
                &buf_error,
                NULL)))
            {
                goto __ret;
            }

        }

#else
        if(file_flag == VS_FILE_ASM)
        {
            if(FAILED(D3DXAssembleShader((LPCSTR)data, size, NULL, NULL, 0, &buf_code, &buf_error)))
                goto __ret;
        }
        else if(file_flag == VS_FILE_HLSL)
        {
            DWORD compile_flag = 0;

            if(FAILED(D3DXCompileShader(
                (LPCSTR)data, 
                size, 
                NULL, 
                NULL, 
                "main",
                "vs_1_1",
                compile_flag,
                &buf_code,
                &buf_error,
                NULL)))
            {
                goto __ret;
            }
        }
#endif

        code = (BYTE*)buf_code->GetBufferPointer();
        size = buf_code->GetBufferSize();

    }

    if(DR_FAILED(RegisterVertexShader(type, code, size)))
        goto __ret;

    ret = DR_RET_OK;

__ret:
    DR_SAFE_DELETE_A(data);
    DR_SAFE_RELEASE(buf_code);
    DR_SAFE_RELEASE(buf_error);
    return ret;

}
DR_RESULT drShaderMgr9::RegisterVertexDeclaration(DWORD type, D3DVERTEXELEMENT9* data)
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DVertexDeclarationX* handle;
    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    if(type < 0 || type >= _decl_size)
        goto __ret;

    if(_decl_seq[type].handle)
        goto __ret;

    if(FAILED(dev->CreateVertexDeclaration(data, &handle)))
        goto __ret;

    _decl_seq[type].handle = handle;

    int i = 0;
    D3DVERTEXELEMENT9* p = data;
    while(p->Stream != 0xff)
    {
        i++;
        p++;
    }
    i++;
    _decl_seq[type].data = DR_NEW(D3DVERTEXELEMENT9[i]);
    memcpy(_decl_seq[type].data, data, sizeof(D3DVERTEXELEMENT9) * i);

    _decl_num += 1;

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drShaderMgr9::LoseDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    drVertexShaderInfo* s;

    for(DWORD i = 0; i < _vs_size; i++)
    {
        s = &_vs_seq[i];

        DR_SAFE_RELEASE(s->handle);
    }

    ret = DR_RET_OK;

//__ret:
    return ret;
}
DR_RESULT drShaderMgr9::ResetDevice()
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DDeviceX* dev = _dev_obj->GetDevice();

    drVertexShaderInfo* s;

    for(DWORD i = 0; i < _vs_size; i++)
    {
        s = &_vs_seq[i];

        if(s->handle == 0 && s->data)
        {
            if(FAILED(dev->CreateVertexShader((DWORD*)s->data, &s->handle)))
                goto __ret;
        }
    }

    ret = DR_RET_OK;

__ret:
    return ret;
}

DR_RESULT drShaderMgr9::QueryVertexShader(IDirect3DVertexShaderX** ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(type < 0 || type >= _vs_size)
        goto __ret;

    if(_vs_seq[type].handle == 0)
        goto __ret;

    *ret_obj = _vs_seq[type].handle;

    ret = DR_RET_OK;

__ret:
    return ret;

}
DR_RESULT drShaderMgr9::QueryVertexDeclaration(IDirect3DVertexDeclarationX** ret_obj, DWORD type)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(type < 0 || type >= _decl_size)
        goto __ret;

    if(_decl_seq[type].handle == 0)
        goto __ret;

    *ret_obj = _decl_seq[type].handle;

    ret = DR_RET_OK;

__ret:
    return ret;

}

#endif


DR_END
