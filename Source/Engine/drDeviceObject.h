//
#pragma once

#include "drHeader.h"
#include "drDirectX.h"
#include "drD3DSettings.h"
#include "drStreamObj.h"
#include "drMath.h"
#include "drClassDecl.h"
#include "drInterfaceExt.h"
#include "drPreDefinition.h"

DR_BEGIN

class drVertexBuffer;
class drIndexBuffer;

class drDeviceObject : public drIDeviceObject
{
    friend class drVertexBuffer;
    friend class drIndexBuffer;

private:
    drSysGraphics* _sys_graphics;

    DWORD _rs_value[ DR_MAX_RENDERSTATE_NUM ];
    DWORD _tss_value[ DR_MAX_TEXTURESTAGE_NUM ][ DR_MAX_TEXTURESTAGESTATE_NUM ];
    DWORD _ss_value[ DR_MAX_SAMPLESTAGE_NUM ][ DR_MAX_SAMPLESTATE_NUM ];
    IDirect3DBaseTextureX* _tex_seq[ DR_MAX_TEXTURESTAGE_NUM ];


#if ( defined DR_USE_DX9 )
    DWORD _fvf_value;
    IDirect3DVertexShaderX* _shader_value;
    IDirect3DVertexDeclarationX* _decl_value;
#elif ( defined DR_USE_DX8 )
    IDirect3DVertexShaderX _shader_value;
#endif

    IDirect3DVertexBufferX* _vb_value[DR_MAX_STREAM_NUM];
    IDirect3DIndexBufferX* _ib_value;

    BOOL _light_enable[DR_MAX_LIGHT_NUM];
    D3DLIGHTX _light_seq[DR_MAX_LIGHT_NUM];

    IDirect3DX* _d3d;
    IDirect3DDeviceX* _dev;
    drD3DCreateParam _d3d_create_param;
    D3DDISPLAYMODE _display_mode;
    D3DCAPSX _dev_caps;
    D3DVIEWPORTX _viewport;
    drBackBufferFormatsInfo _bbf_caps;


    RECT _rc_window;
    RECT _rc_client;

    drVertexBuffer* _svb_head;
    drIndexBuffer* _sib_head;

    //DWORD _
    drMatrix44 _mat_view;
    drMatrix44 _mat_proj;
    drMatrix44 _mat_viewproj;
    drMatrix44 _mat_world;

    drWatchDevVideoMemInfo _watch_vm_info;

    // begin mark
    DWORD _mark_vertex_num;
    DWORD _mark_polygon_num;
    // end mark

DR_STD_DECLARATION()

private:
    void _ReleaseStreamBuffer(drVertexBuffer* buf);
    void _ReleaseStreamBuffer(drIndexBuffer* buf);
    void _ClearStreamBuffer();

public:
    drDeviceObject( drSysGraphics* sys_graphics );
    ~drDeviceObject();

    DR_RESULT CreateDirect3D();
    DR_RESULT CreateDevice(drD3DCreateParam* param);
    DR_RESULT ResetDevice(D3DPRESENT_PARAMETERS* d3dpp);
    DR_RESULT ResetDeviceStateCache();
    DR_RESULT ResetDeviceTransformMatrix();

    DR_RESULT SetDirect3D(IDirect3DX* d3d);
    DR_RESULT SetDevice(IDirect3DDeviceX* dev);
    IDirect3DX* GetDirect3D() { return _d3d; }
    IDirect3DDeviceX* GetDevice() { return _dev; }
    drD3DCreateParam* GetD3DCreateParam() { return &_d3d_create_param; }
    D3DDISPLAYMODE* GetAdapterDisplayMode() { return &_display_mode; }
    D3DCAPSX* GetDeviceCaps() { return &_dev_caps; }
    drBackBufferFormatsInfo* GetBackBufferFormatsCaps() { return &_bbf_caps; }

    DR_RESULT CreateVertexBuffer(UINT length, DWORD usage, DWORD fvf, D3DPOOL pool, IDirect3DVertexBufferX** vb, HANDLE* handle);
    DR_RESULT CreateIndexBuffer(UINT length, DWORD usage, D3DFORMAT fmt, D3DPOOL pool, IDirect3DIndexBufferX** ib, HANDLE* handle);
    DR_RESULT CreateTexture(IDirect3DTextureX** out_tex, const drTexDataInfo* info, DWORD level, DWORD usage, DWORD format, D3DPOOL pool);
    DR_RESULT CreateTexture(IDirect3DTextureX** out_tex, UINT width, UINT height, UINT level, DWORD usage, D3DFORMAT format, D3DPOOL pool);
    DR_RESULT CreateTextureFromFileInMemory(IDirect3DTextureX** out_tex, void* data, UINT data_size, UINT width, UINT height, UINT mip_level, DWORD usage, D3DFORMAT format, D3DPOOL pool, DWORD filter, DWORD mip_filter, D3DCOLOR colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette);
    DR_RESULT CreateVertexBuffer(drIVertexBuffer** out_obj);
    DR_RESULT CreateIndexBuffer(drIIndexBuffer** out_obj);
    DR_RESULT CreateRenderTarget(IDirect3DSurfaceX** o_surface, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle);
    DR_RESULT CreateDepthStencilSurface(IDirect3DSurfaceX** o_surface, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle);
    DR_RESULT CreateCubeTexture(IDirect3DCubeTextureX** o_tex, UINT edge_length, UINT levels, DWORD usage, D3DFORMAT format, D3DPOOL pool, HANDLE* handle);
    DR_RESULT CreateOffscreenPlainSurface(IDirect3DSurfaceX** surface, UINT width, UINT height, D3DFORMAT format, DWORD pool, HANDLE* handle);

    DR_RESULT ReleaseTex( IDirect3DTextureX* tex );
    DR_RESULT ReleaseVertexBuffer(IDirect3DVertexBufferX* vb);
    DR_RESULT ReleaseIndexBuffer(IDirect3DIndexBufferX* ib);    

#if ( defined DR_USE_DX9 )
    DR_RESULT SetFVF( DWORD fvf );
    DR_RESULT SetVertexShader( IDirect3DVertexShaderX* shader );
    DR_RESULT SetVertexShaderForced( IDirect3DVertexShaderX* shader );
    DR_RESULT SetVertexDeclaration( IDirect3DVertexDeclarationX* decl );
    DR_RESULT SetVertexDeclarationForced( IDirect3DVertexDeclarationX* decl );
    DR_RESULT SetVertexShaderConstantF( UINT reg_id, const float* data, UINT v_num );
#elif ( defined DR_USE_DX8 )
    DR_RESULT SetVertexShader( IDirect3DVertexShaderX shader );
    DR_RESULT SetVertexShaderConstant( UINT reg_id, const void* data, UINT v_num );
#endif

    DR_RESULT SetStreamSource(UINT stream_num, IDirect3DVertexBufferX* stream_data, UINT offset_byte, UINT stride);
    DR_RESULT SetIndices(IDirect3DIndexBufferX* index_data, UINT base_vert_index);
    DR_RESULT DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT start_vertex, UINT count );
    DR_RESULT DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT vert_num, UINT start_index, UINT count );
    DR_RESULT DrawPrimitiveUP(D3DPRIMITIVETYPE pt_type, UINT count, const void* data, UINT stride);
    DR_RESULT DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE pt_type, UINT min_vert_index, UINT vert_num, UINT count, const void *index_data, D3DFORMAT index_data_fmt, const void* vert_data, UINT vert_stride);

    DR_RESULT SetTransform( D3DTRANSFORMSTATETYPE state, const drMatrix44* mat );
    DR_RESULT SetTransformView( const drMatrix44* mat );
    DR_RESULT SetTransformProj( const drMatrix44* mat );
    DR_RESULT SetTransformWorld( const drMatrix44* mat );

#if 1
    const drMatrix44* GetMatProj() { return &_mat_proj; }
    const drMatrix44* GetMatView() { return &_mat_view; }
    const drMatrix44* GetMatViewProj() { return &_mat_viewproj; }
#else
    const drMatrix44* GetMatProj() { 
        static drMatrix44 mat;
        _dev->GetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&mat );
        return &mat;
    }
    const drMatrix44* GetMatView() { 
        static drMatrix44 mat;
        _dev->GetTransform( D3DTS_VIEW, (D3DMATRIX*)&mat );
        return &mat;
    }
    const drMatrix44* GetMatViewProj() {
        static drMatrix44 mat_view;
        static drMatrix44 mat_proj;
        static drMatrix44 mat_viewproj;
        _dev->GetTransform( D3DTS_VIEW, (D3DMATRIX*)&mat_view );
        _dev->GetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&mat_proj );
        drMatrix44Multiply( &mat_viewproj, &mat_view, &mat_proj );
        return &mat_viewproj;
    }
#endif


    DR_RESULT SetViewPort(const D3DVIEWPORTX* vp);
    DR_RESULT SetMaterial( drMaterial* mtl ) { return _dev->SetMaterial( (D3DMATERIALX*)mtl ); }

    DR_RESULT SetTexture(DWORD stage, IDirect3DBaseTextureX* tex);
    DR_RESULT SetRenderState(D3DRENDERSTATETYPE state, DWORD value);
    DR_RESULT SetTextureStageState(DWORD stage, D3DTEXTURESTAGESTATETYPE type, DWORD value);
    DR_RESULT SetTextureForced(DWORD stage, IDirect3DTextureX* tex);
    DR_RESULT SetRenderStateForced(D3DRENDERSTATETYPE state, DWORD value);
    DR_RESULT SetTextureStageStateForced(DWORD stage, D3DTEXTURESTAGESTATETYPE type, DWORD value);
#if(defined DR_USE_DX9)
    DR_RESULT SetSamplerState( DWORD sampler, D3DSAMPLERSTATETYPE type, DWORD value );
    DR_RESULT SetSamplerStateForced( DWORD sampler, D3DSAMPLERSTATETYPE type, DWORD value );
#endif

    DR_RESULT GetViewPort(D3DVIEWPORTX* vp);
    DR_RESULT GetRenderState(DWORD state, DWORD* value);
    DR_RESULT GetTextureStageState(DWORD stage, DWORD state, DWORD* value);
#if(defined DR_USE_DX9)
    DR_RESULT GetSamplerState(DWORD sampler, D3DSAMPLERSTATETYPE state, DWORD* value);
#endif
    DR_RESULT GetTexture(DWORD stage, IDirect3DBaseTextureX** tex);

    DR_RESULT SetLight(DWORD id, const D3DLIGHTX* light);
    DR_RESULT GetLight(DWORD id, D3DLIGHTX* light);
    DR_RESULT LightEnable(DWORD id, BOOL flag);
    DR_RESULT LightEnableForced(DWORD id, BOOL flag);
    DR_RESULT GetLightEnable(DWORD id, BOOL* flag);

    DR_RESULT InitStateCache();
    DR_RESULT InitCapsInfo();

    DR_RESULT UpdateWindowRect();
    DR_RESULT GetWindowRect(RECT* rc_wnd, RECT* rc_client);
    // begin mark
    void BeginBenchMark();
    void EndBenchMark();
    DWORD GetMarkVertexNum() const { return _mark_vertex_num; }
    DWORD GetMarkPolygonNum() const { return _mark_polygon_num; }
    drWatchDevVideoMemInfo* GetWatchVideoMemInfo() { return &_watch_vm_info; }
    // end mark

    DR_RESULT CheckCurrentDeviceFormat(DWORD type, D3DFORMAT check_fmt);

    DR_RESULT ScreenToWorld(drVector3* org, drVector3* ray, int x, int y);
    DR_RESULT WorldToScreen(int* x, int* y, float* z, const drVector3* v);

    DR_RESULT DumpRenderState(const char* file);
};


DR_END
