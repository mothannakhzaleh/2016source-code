//
#include "drDeviceObject.h"
#include "drSystem.h"
#include "drSysGraphics.h"
#include "drPathInfo.h"
#include "drErrorCode.h"
#include "drD3D.h"
#include "drGraphicsUtil.h"
#include "drPrimitive.h"
#include "drResourceMgr.h"
#include "stdafx.h"
#include <CPerformance.h>
#include "ErrorReport.h"

//#include <FontSystem.h>
#ifdef __MEM_DEBUG__
extern long g_nDontCare;
#endif
extern string GetDxError(HRESULT hr);
DR_BEGIN

DR_STD_ILELEMENTATION(drDeviceObject)

inline DWORD FTODW(float v)
{
    return *(DWORD*)&v;
}

DR_RESULT drDeviceObject::InitStateCache()
{
    int i, j;

	// render state
	for(i = 0; i < DR_MAX_RENDERSTATE_NUM; ++i)
    {
		_rs_value[i] = DR_INVALID_RS_VALUE;
	}

	// texture stage
	for(j = 0; j < DR_MAX_TEXTURESTAGE_NUM; ++j)
    {
		for(i = 0; i < DR_MAX_TEXTURESTAGESTATE_NUM; ++i)
        {
			_tss_value[j][i] = DR_INVALID_TSS_VALUE;
		}

        _tex_seq[j] = NULL;
		_dev->SetTexture(j, NULL);
	}

    // sample stage
#if(defined DR_USE_DX9)
    for(j = 0; j < DR_MAX_SAMPLESTAGE_NUM; j++)
    {
        for(i = 0; i < DR_MAX_SAMPLESTATE_NUM; i++)
        {
            _ss_value[j][i] = DR_INVALID_SS_VALUE;
        }
    }
#endif

	SetRenderState(D3DRS_ZENABLE, D3DZB_FALSE);
	SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
	SetRenderState(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);
#if(defined DR_USE_DX8)
    SetRenderState(D3DRS_LINEPATTERN, 0);
#endif
	SetRenderState(D3DRS_ZWRITEENABLE, TRUE);
	SetRenderState(D3DRS_ALPHATESTENABLE, FALSE);
	SetRenderState(D3DRS_LASTPIXEL, TRUE);
	SetRenderState(D3DRS_SRCBLEND, D3DBLEND_ONE);
	SetRenderState(D3DRS_DESTBLEND, D3DBLEND_ZERO);
	SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW);
	SetRenderState(D3DRS_ZFUNC, D3DCMP_LESSEQUAL);
	SetRenderState(D3DRS_ALPHAREF, 0x00000000);
	SetRenderState(D3DRS_ALPHAFUNC, D3DCMP_ALWAYS);
    SetRenderState(D3DRS_DITHERENABLE, FALSE);      
	SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
    SetRenderState(D3DRS_FOGENABLE, FALSE);
	SetRenderState(D3DRS_SPECULARENABLE, FALSE);
	SetRenderState(D3DRS_FOGCOLOR, 0);
	SetRenderState(D3DRS_FOGTABLEMODE, D3DFOG_NONE);
	SetRenderState(D3DRS_FOGSTART, 0);
	SetRenderState(D3DRS_FOGEND, 0);
	SetRenderState(D3DRS_FOGDENSITY, FTODW(1.0f));
#if(defined DR_USE_DX8)
	SetRenderState(D3DRS_EDGEANTIALIAS, FALSE);
	SetRenderState(D3DRS_ZBIAS, 0);
#endif
	SetRenderState(D3DRS_RANGEFOGENABLE, FALSE);

	SetRenderState(D3DRS_STENCILENABLE, FALSE);
	SetRenderState(D3DRS_STENCILFAIL, D3DSTENCILOP_KEEP);
	SetRenderState(D3DRS_STENCILZFAIL, D3DSTENCILOP_KEEP);
	SetRenderState(D3DRS_STENCILPASS, D3DSTENCILOP_KEEP);
	SetRenderState(D3DRS_STENCILFUNC, D3DCMP_ALWAYS);
	SetRenderState(D3DRS_STENCILREF, 0);
	SetRenderState(D3DRS_STENCILMASK, 0xffffffff);
	SetRenderState(D3DRS_STENCILWRITEMASK, 0xffffffff);
	SetRenderState(D3DRS_TEXTUREFACTOR, 0xffffffff);

	SetRenderState(D3DRS_WRAP0, 0);
	SetRenderState(D3DRS_WRAP1, 0);
	SetRenderState(D3DRS_WRAP2, 0);
	SetRenderState(D3DRS_WRAP3, 0);
	SetRenderState(D3DRS_WRAP4, 0);
	SetRenderState(D3DRS_WRAP5, 0);
	SetRenderState(D3DRS_WRAP6, 0);
	SetRenderState(D3DRS_WRAP7, 0);    
	SetRenderState(D3DRS_CLIPPING, TRUE);
    SetRenderState(D3DRS_LIGHTING, TRUE);
	SetRenderState(D3DRS_AMBIENT, 0x00000000);
	SetRenderState(D3DRS_FOGVERTEXMODE, D3DFOG_NONE);
	SetRenderState(D3DRS_COLORVERTEX, TRUE);
	SetRenderState(D3DRS_LOCALVIEWER, TRUE);
	SetRenderState(D3DRS_NORMALIZENORMALS, FALSE);
	SetRenderState(D3DRS_DIFFUSEMATERIALSOURCE, D3DMCS_COLOR1);
	SetRenderState(D3DRS_SPECULARMATERIALSOURCE, D3DMCS_COLOR2);
	SetRenderState(D3DRS_AMBIENTMATERIALSOURCE, D3DMCS_COLOR2);
	SetRenderState(D3DRS_EMISSIVEMATERIALSOURCE, D3DMCS_MATERIAL);
	SetRenderState(D3DRS_VERTEXBLEND, D3DVBF_DISABLE);
	SetRenderState(D3DRS_CLIPPLANEENABLE, 0);

#if(defined DR_USE_DX8)
	SetRenderState(D3DRS_SOFTWAREVERTEXPROCESSING, FALSE);
#endif

	SetRenderState(D3DRS_POINTSIZE , FTODW(1.0f));
	SetRenderState(D3DRS_POINTSIZE_MIN , FTODW(1.0f));
	SetRenderState(D3DRS_POINTSPRITEENABLE , FALSE);
	SetRenderState(D3DRS_POINTSCALEENABLE , FALSE);
	SetRenderState(D3DRS_POINTSCALE_A , FTODW(1.0f));
	SetRenderState(D3DRS_POINTSCALE_B , FTODW(0.0f));
	SetRenderState(D3DRS_POINTSCALE_C , FTODW(0.0f));
	SetRenderState(D3DRS_MULTISAMPLEANTIALIAS , FALSE); // default value is TRUE
	SetRenderState(D3DRS_MULTISAMPLEMASK, 0xffffffff);

#if(defined DR_USE_DX9)
    SetRenderState(D3DRS_PATCHEDGESTYLE,D3DPATCHEDGE_DISCRETE);
    SetRenderState(D3DRS_DEBUGMONITORTOKEN, D3DDMT_ENABLE);
    SetRenderState(D3DRS_POINTSIZE_MAX, FTODW(64.0f));
#endif
	SetRenderState(D3DRS_INDEXEDVERTEXBLENDENABLE, FALSE);
	SetRenderState(D3DRS_COLORWRITEENABLE, 0x0000000F);
	SetRenderState(D3DRS_TWEENFACTOR, 0);
	SetRenderState(D3DRS_BLENDOP, D3DBLENDOP_ADD);

#if(defined DR_USE_DX9)
    SetRenderState(D3DRS_POSITIONDEGREE, D3DDEGREE_CUBIC);
    SetRenderState(D3DRS_NORMALDEGREE, D3DDEGREE_LINEAR);
    SetRenderState(D3DRS_SCISSORTESTENABLE, FALSE);
    SetRenderState(D3DRS_SLOPESCALEDEPTHBIAS, FALSE);
    SetRenderState(D3DRS_ANTIALIASEDLINEENABLE, FALSE);
    SetRenderState(D3DRS_MINTESSELLATIONLEVEL, FTODW(1.0f));
    SetRenderState(D3DRS_MAXTESSELLATIONLEVEL, FTODW(1.0f));
    SetRenderState(D3DRS_ADAPTIVETESS_X, FTODW(0.0f));
    SetRenderState(D3DRS_ADAPTIVETESS_Y, FTODW(1.0f));
    SetRenderState(D3DRS_ADAPTIVETESS_Z, FTODW(0.0f));
    SetRenderState(D3DRS_ADAPTIVETESS_W, FTODW(0.0f));
    SetRenderState(D3DRS_ENABLEADAPTIVETESSELLATION, FALSE);
    SetRenderState(D3DRS_TWOSIDEDSTENCILMODE, FALSE);
    SetRenderState(D3DRS_CCW_STENCILFAIL, D3DSTENCILOP_KEEP);
    SetRenderState(D3DRS_CCW_STENCILZFAIL, D3DSTENCILOP_KEEP);
    SetRenderState(D3DRS_CCW_STENCILPASS, D3DSTENCILOP_KEEP);
    SetRenderState(D3DRS_CCW_STENCILFUNC, D3DCLE_ADRAYS);
    SetRenderState(D3DRS_COLORWRITEENABLE1, 0x0000000f);
    SetRenderState(D3DRS_COLORWRITEENABLE2, 0x0000000f);
    SetRenderState(D3DRS_COLORWRITEENABLE3, 0x0000000f);
    SetRenderState(D3DRS_BLENDFACTOR, 0xffffffff);
    SetRenderState(D3DRS_SRGBWRITEENABLE, 0);
    SetRenderState(D3DRS_DEPTHBIAS, 0);
    SetRenderState(D3DRS_WRAP8, 0);
    SetRenderState(D3DRS_WRAP9, 0);
    SetRenderState(D3DRS_WRAP10, 0);
    SetRenderState(D3DRS_WRAP11, 0);
    SetRenderState(D3DRS_WRAP12, 0);
    SetRenderState(D3DRS_WRAP13, 0);
    SetRenderState(D3DRS_WRAP14, 0);
    SetRenderState(D3DRS_WRAP15, 0);
    SetRenderState(D3DRS_SEPARATEALPHABLENDENABLE, FALSE);
    SetRenderState(D3DRS_SRCBLENDALPHA, D3DBLEND_ONE);
    SetRenderState(D3DRS_DESTBLENDALPHA, D3DBLEND_ZERO);
    SetRenderState(D3DRS_BLENDOPALPHA, D3DBLENDOP_ADD);
#endif

	for(i = 0; i < DR_MAX_TEXTURESTAGE_NUM; ++i)
    {
		if(i == 0)
        {
			SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
			SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
			SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
			SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
			SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
			SetTextureStageState(0, D3DTSS_ALPHAARG2, D3DTA_DIFFUSE);
		}
        else
        {
			SetTextureStageState(i, D3DTSS_COLOROP, D3DTOP_DISABLE	);
			SetTextureStageState(i, D3DTSS_COLORARG1, D3DTA_TEXTURE);
			SetTextureStageState(i, D3DTSS_COLORARG2, D3DTA_CURRENT);
			SetTextureStageState(i, D3DTSS_ALPHAOP, D3DTOP_DISABLE);
			SetTextureStageState(i, D3DTSS_ALPHAARG1, D3DTA_TEXTURE);
			SetTextureStageState(i, D3DTSS_ALPHAARG2, D3DTA_CURRENT);
		}

#if(defined DR_USE_DX8)
		SetTextureStageState(i, D3DTSS_ADDRESSU,	D3DTADDRESS_WRAP	);
		SetTextureStageState(i, D3DTSS_ADDRESSV,	D3DTADDRESS_WRAP	);
		SetTextureStageState(i, D3DTSS_MAXANISOTROPY, 1);
		SetTextureStageState(i, D3DTSS_MINFILTER, D3DTEXF_POINT);
		SetTextureStageState(i, D3DTSS_MAGFILTER, D3DTEXF_POINT);
		SetTextureStageState(i, D3DTSS_MIPFILTER,	D3DTEXF_NONE);
#endif

        SetTextureStageState(i, D3DTSS_TEXCOORDINDEX, i);
    }

#ifdef DR_USE_DX9
	for(i = 0; i < DR_MAX_SAMPLESTAGE_NUM; ++i)
    {
		SetSamplerState(i, D3DSALE_ADDRESSU, D3DTADDRESS_WRAP);
		SetSamplerState(i, D3DSALE_ADDRESSV, D3DTADDRESS_WRAP);
		SetSamplerState(i, D3DSALE_MAXANISOTROPY, 1);
		SetSamplerState(i, D3DSALE_MINFILTER, D3DTEXF_POINT);
		SetSamplerState(i, D3DSALE_MAGFILTER, D3DTEXF_POINT);
		SetSamplerState(i, D3DSALE_MIPFILTER, D3DTEXF_NONE);
	}
#endif // USE_DX9

    return DR_RET_OK;
}

DR_RESULT drDeviceObject::InitCapsInfo()
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_d3d == 0)
        goto __ret;

    _d3d->GetAdapterDisplayMode(D3DADAPTER_DEFAULT, &_display_mode);
    _dev->GetDeviceCaps(&_dev_caps);

    drBackBufferFormatsItemInfo* bbfii = &_bbf_caps.fmt_seq[0];

    // get adapater fmt
    bbfii->format = _display_mode.Format;
    bbfii->windowed = _d3d_create_param.present_param.Windowed;

    // back buffer formats
    // texture format
    {
        D3DFORMAT check_fmt[] =
        {
            D3DFMT_R8G8B8,           
                D3DFMT_A8R8G8B8,            
                D3DFMT_X8R8G8B8,            
                D3DFMT_R5G6B5,              
                D3DFMT_X1R5G5B5,            
                D3DFMT_A1R5G5B5,            
                D3DFMT_A4R4G4B4,            
                D3DFMT_A8,                  
                D3DFMT_A8R3G3B2,
                D3DFMT_X4R4G4B4,           
                D3DFMT_A2B10G10R10,

                D3DFMT_A8P8,             
                D3DFMT_P8,               

                D3DFMT_L8,        
                D3DFMT_A8L8,
                D3DFMT_A4L4,

                D3DFMT_V8U8,
                D3DFMT_L6V5U5,
                D3DFMT_X8L8V8U8,
                D3DFMT_Q8W8V8U8,           
                D3DFMT_V16U16,            
                D3DFMT_A2W10V10U10,

                D3DFMT_UYVY,
                D3DFMT_YUY2,             
                D3DFMT_DXT1,             
                D3DFMT_DXT2,             
                D3DFMT_DXT3,             
                D3DFMT_DXT4,             
                D3DFMT_DXT5,             
        };


        int fmt_num = DR_ARRAY_LENGTH(check_fmt);

        int j = 0;
        for(int i = 0; i < fmt_num; i++)
        {
            if(FAILED(_d3d->CheckDeviceFormat(
                _d3d_create_param.adapter,
                _d3d_create_param.dev_type,
                bbfii->format,
                0,
                D3DRTYPE_TEXTURE,
                check_fmt[i])))
            {
                continue;
            }

            bbfii->fmt_texture[j++] = check_fmt[i];
        }
    }

    { // depthstencil format
        D3DFORMAT check_fmt[] =
        {
            D3DFMT_D16,
            D3DFMT_D24X8,
            D3DFMT_D24S8
        };

        int fmt_num = DR_ARRAY_LENGTH(check_fmt);

        int j = 0;
        for(int i = 0; i < fmt_num; i++)
        {
            if(FAILED(_d3d->CheckDeviceFormat(
                _d3d_create_param.adapter,
                _d3d_create_param.dev_type,
                bbfii->format,
                D3DUSAGE_DEPTHSTENCIL,
                D3DRTYPE_SURFACE,
                check_fmt[i])))
            {
                continue;
            }

            if(FAILED(_d3d->CheckDepthStencilMatch(
                _d3d_create_param.adapter,
                _d3d_create_param.dev_type,
                bbfii->format,
                bbfii->format,
                check_fmt[i])))
            {
                continue;
            }

            bbfii->fmt_depthstencil[j++] = check_fmt[i];
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::ResetDeviceStateCache()
{
    DWORD i, j;
    DWORD v;

	// render state
	for(i = 0; i < DR_MAX_RENDERSTATE_NUM; ++i)
    {
        if((v = _rs_value[i]) == DR_INVALID_RS_VALUE)
            continue;
        SetRenderStateForced((D3DRENDERSTATETYPE)i, v);
	}

	// texture stage
	for(j = 0; j < DR_MAX_TEXTURESTAGE_NUM; ++j)
    {
		for(i = 0; i < DR_MAX_TEXTURESTAGESTATE_NUM; ++i)
        {
            if((v = _tss_value[j][i]) == DR_INVALID_TSS_VALUE)
                continue;
            SetTextureStageStateForced(j, (D3DTEXTURESTAGESTATETYPE)i, v);
		}
	}

    // sampler state
#if(defined DR_USE_DX9)
	for(j = 0; j < DR_MAX_SAMPLESTAGE_NUM; ++j)
    {
        for(i = 0; i < DR_MAX_SAMPLESTATE_NUM; i++)
        {
            if((v = _ss_value[j][i]) == DR_INVALID_SS_VALUE)
                continue;
            SetSamplerStateForced(j, (D3DSAMPLERSTATETYPE)i, v);
        }
    }
#endif

    return DR_RET_OK;
}

DR_RESULT drDeviceObject::ResetDeviceTransformMatrix()
{
    for(DWORD i = 0; i < DR_MAX_LIGHT_NUM; i++)
    {
        LightEnableForced(i, _light_enable[i]);
        if(_light_enable[i])
        {
            SetLight(i, &_light_seq[i]);
        }
    }

    SetTransformView(&_mat_view);
    SetTransformProj(&_mat_proj);
    SetTransformWorld(&_mat_world);

    return DR_RET_OK;
}

// drDeviceObject
drDeviceObject::drDeviceObject(drSysGraphics* sys_graphics)
: _sys_graphics(sys_graphics), _d3d(0), _dev(0), 
#if (defined DR_USE_DX9)
  _fvf_value(D3DFMT_UNKNOWN), _shader_value(0)
#elif (defined DR_USE_DX8)
  _shader_value(D3DFMT_UNKNOWN)
#endif
{

    _svb_head = 0;
    _sib_head = 0;

    memset(&_dev_caps, 0, sizeof(_dev_caps));
    memset(&_display_mode, 0, sizeof(_display_mode));
    memset(&_bbf_caps, 0, sizeof(_bbf_caps));
    
    // watch video memory
    memset(&_watch_vm_info, 0, sizeof(_watch_vm_info));

    memset(&_d3d_create_param, 0, sizeof(_d3d_create_param));
    memset(_vb_value, 0, sizeof(_vb_value));
    _ib_value = 0;

    memset(_light_enable, 0, sizeof(_light_enable));
    memset(_light_seq, 0, sizeof(_light_seq));

    memset(&_rc_window, 0, sizeof(_rc_window));
    memset(&_rc_client, 0, sizeof(_rc_client));

}
drDeviceObject::~drDeviceObject()
{
    _ClearStreamBuffer();

    DR_IF_RELEASE(_dev);
    DR_IF_RELEASE(_d3d);
}

DR_RESULT drDeviceObject::CreateDirect3D()
{
    DR_RESULT ret = DR_RET_FAILED;
    
    if((_d3d = Direct3DCreateX(D3D_SDK_VERSION)) == 0)
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drDeviceObject::CreateDevice(drD3DCreateParam* param)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(_d3d == 0)
        goto __ret;

    if(param->present_param.BackBufferFormat == D3DFMT_UNKNOWN)
    {
        D3DDISPLAYMODE d3ddm;
        _d3d->GetAdapterDisplayMode(D3DADAPTER_DEFAULT, &d3ddm);
        param->present_param.BackBufferFormat = d3ddm.Format;
    }

#if(defined DR_SHADER_DEBUG_VS || defined DR_SHADER_DEBUG_PS)
    if(param->dev_type != D3DDEVTYPE_REF)
    {
        param->behavior_flag &= ~D3DCREATE_HARDWARE_VERTEXPROCESSING;
        param->behavior_flag &= ~D3DCREATE_PUREDEVICE;                            
        param->behavior_flag |= D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    }
#endif

    IDirect3DDeviceX* dev;
    //Create a Direct3D device.
	HRESULT hr = S_OK;
    if(FAILED(hr = _d3d->CreateDevice(param->adapter, 
        param->dev_type, 
        param->hwnd, 
        param->behavior_flag, 
        &param->present_param,
        &dev)))
    {
//		IP("MultiSampleType(%d)\n", param->present_param.MultiSampleType);
//		IP("SwapEffect(%d)\n", param->present_param.SwapEffect);
//		IP("EnableAutoDepthStencil(%d) fmt(%d)\n", 
//			param->present_param.EnableAutoDepthStencil, 
//			param->present_param.AutoDepthStencilFormat);
//		IP("Flags(%08x)\n", param->present_param.Flags);
		ErrorLog("CreateDevice(%dx%d fmt%d cnt%d typ%d, flag%08x) failed=%s\n", 
			param->present_param.BackBufferWidth, 
			param->present_param.BackBufferHeight, 
			param->present_param.BackBufferFormat, 
			param->present_param.BackBufferCount,
			param->dev_type, param->behavior_flag, GetDxError(hr).c_str());
        goto __ret;
    }

    SetDevice(dev);

    _d3d_create_param = *param;

    UpdateWindowRect();

    // init viewport
    if(FAILED(_dev->GetViewport(&_viewport)))
        goto __ret;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::SetDirect3D(IDirect3DX* d3d)
{
    _d3d = d3d;
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::SetDevice(IDirect3DDeviceX* dev)
{ 
    _dev = dev;
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::ResetDevice(D3DPRESENT_PARAMETERS* d3dpp)
{
    DR_RESULT ret = DR_RET_FAILED;

	HRESULT hr = S_OK;

	while( ( hr = _dev->TestCooperativeLevel() ) == D3DERR_DEVICELOST )
	{
		// the device cannot be reset at this time
		Sleep( 100 );
	}

	//FontModule::FontSystem::getSingleton()._preD3DReset();

	hr = _dev->Reset( d3dpp );

	//FontModule::FontSystem::getSingleton()._postD3DReset();

	if(FAILED(hr))
	{
		goto __ret;
	}

	hr = _dev->GetViewport(&_viewport);

    if(FAILED(hr))
        goto __ret;

    _d3d_create_param.present_param = *d3dpp;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::CreateVertexBuffer(UINT length, DWORD usage, DWORD fvf, D3DPOOL pool, IDirect3DVertexBufferX** vb, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(FAILED(ret = _dev->CreateVertexBufferX(length, usage, fvf, pool, vb, handle)))
        goto __ret;

#if(defined WATCH_VM_FLAG)
    _watch_vm_info.alloc_vb_size += length;
    _watch_vm_info.alloc_vb_cnt += 1;
#endif

__ret:
    return ret;
}
DR_RESULT drDeviceObject::CreateIndexBuffer(UINT length, DWORD usage, D3DFORMAT fmt, D3DPOOL pool, IDirect3DIndexBufferX** ib, HANDLE* handle)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(FAILED(ret = _dev->CreateIndexBufferX(length, usage, fmt, pool, ib, handle)))
        goto __ret;

#if(defined WATCH_VM_FLAG)
    _watch_vm_info.alloc_ib_size += length;
    _watch_vm_info.alloc_ib_cnt += 1;
#endif

__ret:
    return ret;
}

DR_RESULT drDeviceObject::CreateTexture(IDirect3DTextureX** out_tex, const drTexDataInfo* info, DWORD level, DWORD usage, DWORD format, D3DPOOL pool)
{
    DR_RESULT ret = DR_RET_FAILED;
    
#ifdef CREATETEXTURE_SYSMEM_UPDATE_FLAG

    IDirect3DTextureX* t;
	D3DLOCKED_RECT lock_rc;
	IDirect3DSurfaceX* surface;
    IDirect3DTextureX* mem_tex;

    if(FAILED(_dev->CreateTextureX(info->width, info->height, level, usage, (D3DFORMAT)format, D3DPOOL_DEFAULT, &t, 0)))
        goto __ret;

    if(FAILED(_dev->CreateTextureX(info->width, info->height, level, 0, (D3DFORMAT)format, D3DPOOL_SYSTEMMEM, &mem_tex, 0)))
        goto __ret;


    if(FAILED(mem_tex->GetSurfaceLevel(0, &surface))) 
		goto __ret;

    if(FAILED(surface->LockRect(&lock_rc, 0, 0))) 
		goto __ret;
    

    memcpy(lock_rc.pBits, info->data, info->size);

    surface->UnlockRect();
    surface->Release();

    if(FAILED(_dev->UpdateTexture(mem_tex, t)))
        goto __ret;

    mem_tex->Release();

    *out_tex = t;

#else

    HRESULT ret;
    IDirect3DTextureX* t;
	D3DLOCKED_RECT lock_rc;
	IDirect3DSurfaceX* surface;

    if(FAILED(_dev->CreateTextureX(info->width, info->height, level, usage, (D3DFORMAT)format, pool, &t, 0)))
        goto __ret;


    if(FAILED(t->GetSurfaceLevel(0, &surface))) 
		goto __ret;

    if(FAILED(surface->LockRect(&lock_rc, 0, 0))) 
		goto __ret;
    

    memcpy(lock_rc.pBits, info->data, info->size);

    surface->UnlockRect();
    surface->Release();

    *out_tex = t;
#endif

#if(defined WATCH_VM_FLAG)
    _watch_vm_info.alloc_tex_size += info->size;
    _watch_vm_info.alloc_tex_cnt += 1;
#endif

    ret = DR_RET_OK;

__ret:
    return ret;
}
DR_RESULT drDeviceObject::CreateTexture(IDirect3DTextureX** out_tex, UINT width, UINT height, UINT level, DWORD usage, D3DFORMAT format, D3DPOOL pool)
{
#if(defined WATCH_VM_FLAG)
    DR_RESULT ret = DR_RET_FAILED;

    if(DR_FAILED(_dev->CreateTextureX(width, height, level, usage, format, pool, out_tex, NULL)))
        goto __ret;

    D3DSURFACE_DESC desc;
    if(DR_FAILED((*out_tex)->GetLevelDesc(0, &desc)))
        goto __ret;

    _watch_vm_info.alloc_tex_size += drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
//#if(defined DR_USE_DX8)
    //_watch_vm_info.alloc_tex_size += desc.Size;
//#endif
    _watch_vm_info.alloc_tex_cnt += 1;

    ret = DR_RET_OK;
__ret:
    return ret;
#else

    return _dev->CreateTextureX(width, height, level, usage, format, pool, out_tex, NULL);

#endif
}


DR_RESULT drDeviceObject::CreateTextureFromFileInMemory(IDirect3DTextureX** out_tex, void* data, UINT data_size, UINT width, UINT height, UINT mip_level, DWORD usage, D3DFORMAT format, D3DPOOL pool, DWORD filter, DWORD mip_filter, D3DCOLOR colorkey, D3DXIMAGE_INFO* src_info, PALETTEENTRY* palette)
{
    DR_RESULT ret = DR_RET_FAILED;

    IDirect3DTextureX* t = 0;
#ifdef __MEM_DEBUG__
	InterlockedIncrement(&::g_nDontCare);
#endif
	HRESULT hr = D3DXCreateTextureFromFileInMemoryEx(
		_dev, // device
		data, // data
		data_size, // data size
		width, // width
		height, // height
		mip_level, // mipmap level
		usage, // usage
		format, // format
		pool, // d3dpool
		filter, // filter
		mip_filter,
		colorkey, // colorkey
		src_info, // D3DXIMAGE_INFO
		palette, // PALETTEENTRY
		&t);
    if( FAILED(hr) ) // out
    {
// 		IP("D3DXCreateTextureFromFileInMemoryEx failed %d\n", hr);
// 		IP("data=%x, size=%u, %dx%d, mip=%d, usage=%d\n", data, data_size, width, height, mip_level, usage);
// 		IP("fmt=%d, pool=%d, fltr=%d, mf=%d key=%08x\n", format, pool, filter, mip_filter, colorkey);
// 		IP("info=%08x, pal=%08x\n", src_info, palette);

#ifdef __MEM_DEBUG__
		InterlockedDecrement(&::g_nDontCare);
#endif
        goto __ret;
    }
#ifdef __MEM_DEBUG__
	InterlockedDecrement(&::g_nDontCare);
#endif

    D3DSURFACE_DESC desc;
    if(DR_FAILED(t->GetLevelDesc(0, &desc)))
	{
		//IP("GetLevelDesc5 failed\n");
        goto __ret;
	}

    _watch_vm_info.alloc_tex_size += drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
    //_watch_vm_info.alloc_tex_size += desc.Size;
    _watch_vm_info.alloc_tex_cnt += 1;

    *out_tex = t;

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drDeviceObject::CreateVertexBuffer(drIVertexBuffer** out_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drVertexBuffer* obj = DR_NEW(drVertexBuffer(this));
    if(obj == 0)
        goto __ret;

    obj->_next = _svb_head;

    if(_svb_head)
    {
        _svb_head->_prev = obj;
    }
    _svb_head = obj;

    *out_obj = obj;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::CreateIndexBuffer(drIIndexBuffer** out_obj)
{
    DR_RESULT ret = DR_RET_FAILED;

    drIndexBuffer* obj = DR_NEW(drIndexBuffer(this));
    if(obj == 0)
        goto __ret;

    obj->_next = _sib_head;

    if(_sib_head)
    {
        _sib_head->_prev = obj;
    }
    _sib_head = obj;

    *out_obj = obj;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::CreateRenderTarget(IDirect3DSurfaceX** o_surface, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL lockable, HANDLE* handle)
{
    return _dev->CreateRenderTargetX(width, height, format, multi_sample, multi_sample_quality, lockable, o_surface, handle);
}

DR_RESULT drDeviceObject::CreateDepthStencilSurface(IDirect3DSurfaceX** o_surface, UINT width, UINT height, D3DFORMAT format, D3DMULTISAMPLE_TYPE multi_sample, DWORD multi_sample_quality, BOOL discard, HANDLE* handle)
{
    return _dev->CreateDepthStencilSurfaceX(width, height, format, multi_sample, multi_sample_quality, discard, o_surface, handle);
}
DR_RESULT drDeviceObject::CreateCubeTexture(IDirect3DCubeTextureX** o_tex, UINT edge_length, UINT levels, DWORD usage, D3DFORMAT format, D3DPOOL pool, HANDLE* handle)
{
    return _dev->CreateCubeTextureX(edge_length, levels, usage, format, pool, o_tex, handle);
}
DR_RESULT drDeviceObject::CreateOffscreenPlainSurface(IDirect3DSurfaceX** surface, UINT width, UINT height, D3DFORMAT format, DWORD pool, HANDLE* handle)
{
#if(defined DR_USE_DX8)
    return _dev->CreateImageSurface(width, height, format, surface);
#endif
#if(defined DR_USE_DX9)
    return _dev->CreateOffscreenPlainSurface(width, height, format, pool, surface, handle);
#endif
}

DR_RESULT drDeviceObject::ReleaseVertexBuffer(IDirect3DVertexBufferX* vb)
{
#if(defined WATCH_VM_FLAG)
    D3DVERTEXBUFFER_DESC desc;
    vb->GetDesc(&desc);
    _watch_vm_info.alloc_vb_size -= desc.Size;
#endif


    vb->Release();

    return DR_RET_OK;
}
void drDeviceObject::_ReleaseStreamBuffer(drVertexBuffer* buf)
{
    if(_svb_head == buf)
    {
        _svb_head = buf->_next;
    }

    buf->_RemoveThisFromList();
}
void drDeviceObject::_ReleaseStreamBuffer(drIndexBuffer* buf)
{
    if(_sib_head == buf)
    {
        _sib_head = buf->_next;
    }

    buf->_RemoveThisFromList();
}
void drDeviceObject::_ClearStreamBuffer()
{
#if(defined ON_DEVELOP)
    if(_svb_head || _sib_head)
    {
        drMessageBox("resource leak in stream buffer");
    }
#endif

    drVertexBuffer* svb;
    while(_svb_head)
    {
        svb = _svb_head;
        _svb_head = _svb_head->_next;
        svb->Release();
    }

    drIndexBuffer* sib;
    while(_sib_head)
    {
        sib = _sib_head;
        _sib_head = _sib_head->_next;
        sib->Release();
    }
}

DR_RESULT drDeviceObject::ReleaseIndexBuffer(IDirect3DIndexBufferX* ib)
{
#if(defined WATCH_VM_FLAG)
    D3DINDEXBUFFER_DESC desc;
    ib->GetDesc(&desc);
    _watch_vm_info.alloc_ib_size -= desc.Size;    
#endif

    ib->Release();

    return DR_RET_OK;
}

DR_RESULT drDeviceObject::ReleaseTex(IDirect3DTextureX* tex)
{
#if(defined WATCH_VM_FLAG)
    D3DSURFACE_DESC desc;
    tex->GetLevelDesc(0, &desc);
    _watch_vm_info.alloc_tex_size -= drGetSurfaceSize(desc.Width, desc.Height, desc.Format);
    //_watch_vm_info.alloc_tex_size -= desc.Size;
#endif

    tex->Release();
    return DR_RET_OK;
}


#if (defined DR_USE_DX9)

DR_RESULT drDeviceObject::SetFVF(DWORD fvf)
{
    if(_fvf_value != fvf)
    {
        _fvf_value = fvf;
        return _dev->SetFVF(fvf);
    }
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::SetVertexShader(IDirect3DVertexShaderX* shader)
{
    if(_shader_value != shader)
    {
        _shader_value = shader;
        return _dev->SetVertexShader(shader);
    }
    return DR_RET_OK;
}
DR_RESULT drDeviceObject::SetVertexShaderForced(IDirect3DVertexShaderX* shader)
{
    _shader_value = shader;
    return _dev->SetVertexShader(shader);
}

DR_RESULT drDeviceObject::SetVertexDeclaration(IDirect3DVertexDeclarationX* decl)
{
    if(_decl_value != decl)
    {
        _decl_value = decl;
        return _dev->SetVertexDeclaration(decl);
    }
    return DR_RET_OK;
}
DR_RESULT drDeviceObject::SetVertexDeclarationForced(IDirect3DVertexDeclarationX* decl)
{
    _decl_value = decl;
    return _dev->SetVertexDeclaration(decl);
}

DR_RESULT drDeviceObject::SetVertexShaderConstantF(UINT reg_id, const float* data, UINT v_num)
{
	if(!data)
		return DR_RET_FAILED;
    return _dev->SetVertexShaderConstantF(reg_id, data, v_num);
}

#elif (defined DR_USE_DX8)

DR_RESULT drDeviceObject::SetVertexShader(IDirect3DVertexShaderX shader)
{
    if(_shader_value != shader)
    {
        _shader_value = shader;
        return _dev->SetVertexShader(shader);
    }
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::SetVertexShaderConstant(UINT reg_id, const void* data, UINT v_num)
{
	if(!data)
		return DR_RET_FAILED;
    return _dev->SetVertexShaderConstant(reg_id, data, v_num);
}

#endif


DR_RESULT drDeviceObject::SetStreamSource(UINT stream_num, IDirect3DVertexBufferX* stream_data, UINT offset_byte, UINT stride)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(stream_num >= DR_MAX_STREAM_NUM)
        goto __ret;

    //这里不能只判断stream_data，还需要判断offset_byte,stride
    //if(_vb_value[stream_num] == stream_data)
    //    goto __addr_ok;
    
    if(FAILED(ret = _dev->SetStreamSourceX(stream_num, stream_data, offset_byte, stride)))
        goto __ret;

    //_vb_value[stream_num] = stream_data;

//__addr_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::SetIndices(IDirect3DIndexBufferX* index_data, UINT base_vert_index)
{
    DR_RESULT ret = DR_RET_FAILED;

    //这里不能只判断index_data，还需要判断base_vert_index
    //if(_ib_value == index_data)
    //    goto __addr_ok;
    
    if(FAILED(ret = _dev->SetIndicesX(index_data, base_vert_index)))
        goto __ret;

    //_ib_value = index_data;

//__addr_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::DrawPrimitive(D3DPRIMITIVETYPE pt_type, UINT start_vertex, UINT count)
{
    _mark_polygon_num += count;

    //return _dev->DrawPrimitiveX(pt_type, _vertex_entry_offset + start_vertex, count);
    return _dev->DrawPrimitiveX(pt_type, start_vertex, count);

}

DR_RESULT drDeviceObject::DrawIndexedPrimitive(D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT vert_num, UINT start_index, UINT count)
{
    _mark_polygon_num += count;

    if(DR_FAILED(_dev->DrawIndexedPrimitiveX(pt_type, base_vert_index, min_index, vert_num, start_index, count)))
    {
        return DR_RET_FAILED;
    }
    return DR_RET_OK;
}
DR_RESULT drDeviceObject::DrawPrimitiveUP(D3DPRIMITIVETYPE pt_type, UINT count, const void* data, UINT stride)
{
    _mark_polygon_num += count;

    return _dev->DrawPrimitiveUP(pt_type, count, data, stride);
}
DR_RESULT drDeviceObject::DrawIndexedPrimitiveUP(D3DPRIMITIVETYPE pt_type, UINT min_vert_index, UINT vert_num, UINT count, const void *index_data, D3DFORMAT index_data_fmt, const void* vert_data, UINT vert_stride)
{
    _mark_polygon_num += count;

    return _dev->DrawIndexedPrimitiveUP(pt_type, min_vert_index, vert_num, count, index_data, index_data_fmt, vert_data, vert_stride);
}

#ifdef __FPS_DEBUG__
extern void PrintRenderState(D3DRENDERSTATETYPE state, DWORD value);
#endif
DR_RESULT drDeviceObject::SetRenderState(D3DRENDERSTATETYPE state, DWORD value)
{
    DR_RESULT ret = DR_RET_OK;

// #ifdef __FPS_DEBUG__
// 	if( state==D3DRS_CULLMODE )
// 		value = D3DCULL_CCW;
// #endif


    DWORD* v = &_rs_value[state];
    if(*v != value)
    {
// #ifdef __FPS_DEBUG__
// 		if( state==D3DRS_CULLMODE )
//  			PrintRenderState(state, value);
// #endif
        *v = value;
        ret = _dev->SetRenderState(state, value);
    }

    return ret;
}
DR_RESULT drDeviceObject::SetTextureStageState(DWORD stage, D3DTEXTURESTAGESTATETYPE type, DWORD value)
{
    DR_RESULT ret = DR_RET_OK;

    DWORD* v = &_tss_value[stage][type];
    if(*v != value)
    {
        *v = value;
        ret = _dev->SetTextureStageState(stage, type, value);
    }

    return ret;
}

#ifdef DR_USE_DX9
DR_RESULT drDeviceObject::SetSamplerState(DWORD sampler, D3DSAMPLERSTATETYPE type, DWORD value)
{
    DR_RESULT ret = DR_RET_OK;

    DWORD* s = &_ss_value[sampler][type];
    if(*s != value)
    {
        *s = value;
        ret = _dev->SetSamplerState(sampler, type, value);
    }

    return ret;
}
#endif

DR_RESULT drDeviceObject::SetTexture(DWORD stage, IDirect3DBaseTextureX* tex)
{
    DR_RESULT ret = DR_RET_OK;

    IDirect3DBaseTextureX** t = &_tex_seq[stage];
    if(*t != tex)
    {
        *t = tex;
        ret = _dev->SetTexture(stage, tex);
    }

    return ret;
}


DR_RESULT drDeviceObject::SetRenderStateForced(D3DRENDERSTATETYPE state, DWORD value)
{
    _rs_value[state] = value;
    return _dev->SetRenderState(state, value);
}
DR_RESULT drDeviceObject::SetTextureStageStateForced(DWORD stage, D3DTEXTURESTAGESTATETYPE type, DWORD value)
{
    _tss_value[stage][type] = value;
    return _dev->SetTextureStageState(stage, type, value);
}

#ifdef DR_USE_DX9
DR_RESULT drDeviceObject::SetSamplerStateForced(DWORD sampler, D3DSAMPLERSTATETYPE type, DWORD value)
{
    _ss_value[sampler][type] = value;
    return _dev->SetSamplerState(sampler, type, value);
}
#endif

DR_RESULT drDeviceObject::SetTextureForced(DWORD stage, IDirect3DTextureX* tex)
{
    _tex_seq[stage] = tex;
    return _dev->SetTexture(stage, tex);
}

DR_RESULT drDeviceObject::GetRenderState(DWORD state, DWORD* value)
{
    *value = _rs_value[state];
    return DR_RET_OK;
}
DR_RESULT drDeviceObject::GetTextureStageState(DWORD stage, DWORD state, DWORD* value)
{
    *value = _tss_value[stage][state];
    return DR_RET_OK;
}
#if(defined DR_USE_DX9)
DR_RESULT drDeviceObject::GetSamplerState(DWORD sampler, D3DSAMPLERSTATETYPE state, DWORD* value)
{
    *value = _ss_value[sampler][state];
    return DR_RET_OK;
}
#endif
DR_RESULT drDeviceObject::GetTexture(DWORD stage, IDirect3DBaseTextureX** tex)
{
    *tex = _tex_seq[stage];
    return DR_RET_OK;
}
DR_RESULT drDeviceObject::SetLight(DWORD id, const D3DLIGHTX* light)
{
    _light_seq[id] = *light;
    return _dev->SetLight(id, light);
}
DR_RESULT drDeviceObject::GetLight(DWORD id, D3DLIGHTX* light)
{
    *light = _light_seq[id];
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::LightEnable(DWORD id, BOOL flag)
{
    if(flag == _light_enable[id])
        return DR_RET_OK;
    _light_enable[id] = flag;
    return _dev->LightEnable(id, flag);
}
DR_RESULT drDeviceObject::LightEnableForced(DWORD id, BOOL flag)
{
    _light_enable[id] = flag;
    return _dev->LightEnable(id, flag);
}
DR_RESULT drDeviceObject::GetLightEnable(DWORD id, BOOL* flag)
{
    *flag = _light_enable[id];
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::SetTransform(D3DTRANSFORMSTATETYPE state, const drMatrix44* mat)
{
    return _dev->SetTransform(state, (D3DMATRIX*)mat);
}

DR_RESULT drDeviceObject::SetTransformView(const drMatrix44* mat) 
{ 
    _mat_view = *mat; 
    drMatrix44Multiply(&_mat_viewproj, &_mat_view, &_mat_proj); 
    return _dev->SetTransform(D3DTS_VIEW, (D3DMATRIX*)&_mat_view); 
}
DR_RESULT drDeviceObject::SetTransformProj(const drMatrix44* mat) 
{ 
    _mat_proj = *mat; 
    drMatrix44Multiply(&_mat_viewproj, &_mat_view, &_mat_proj); 
    return _dev->SetTransform(D3DTS_PROJECTION, (D3DMATRIX*)&_mat_proj); 
}
DR_RESULT drDeviceObject::SetTransformWorld(const drMatrix44* mat) 
{ 
    _mat_world = *mat;
    return _dev->SetTransform(D3DTS_WORLD, (D3DMATRIX*)mat); 
}

DR_RESULT drDeviceObject::SetViewPort(const D3DVIEWPORTX* vp)
{
    _viewport = *vp;
    return _dev->SetViewport(vp);
}
DR_RESULT drDeviceObject::GetViewPort(D3DVIEWPORTX* vp)
{
    *vp = _viewport;
    return DR_RET_OK;
}

DR_RESULT drDeviceObject::UpdateWindowRect()
{
    ::GetWindowRect(_d3d_create_param.hwnd, &_rc_window);
    ::GetClientRect(_d3d_create_param.hwnd, &_rc_client);

    return DR_RET_OK;
}
DR_RESULT drDeviceObject::GetWindowRect(RECT* rc_wnd, RECT* rc_client)
{
    if(rc_wnd)
    {
        *rc_wnd = _rc_window;
    }
    if(rc_client)
    {
        *rc_client = _rc_client;
    }
    return DR_RET_OK;
}

//
void drDeviceObject::BeginBenchMark()
{
    _mark_vertex_num = 0;
    _mark_polygon_num = 0;
}
void drDeviceObject::EndBenchMark()
{
}

DR_RESULT drDeviceObject::CheckCurrentDeviceFormat(DWORD type, D3DFORMAT check_fmt)
{
    DR_RESULT ret = DR_RET_FAILED;

    drBackBufferFormatsItemInfo* bbfii = &_bbf_caps.fmt_seq[0];
    D3DFORMAT* fmt_buf;
    int fmt_num;

    switch(type)
    {
    case BBFI_TEXTURE:
        fmt_buf = &bbfii->fmt_texture[0];
        fmt_num = DR_ARRAY_LENGTH(bbfii->fmt_texture);
        break;
    case BBFI_VOLUMETEXTURE:
        fmt_buf = &bbfii->fmt_volumetexture[0];
        fmt_num = DR_ARRAY_LENGTH(bbfii->fmt_volumetexture);
        break;
    case BBFI_CUBETEXTURE:
        fmt_buf = &bbfii->fmt_cubetexture[0];
        fmt_num = DR_ARRAY_LENGTH(bbfii->fmt_cubetexture);
        break;
    case BBFI_DEPTHSTENCIL:
        fmt_buf = &bbfii->fmt_depthstencil[0];
        fmt_num = DR_ARRAY_LENGTH(bbfii->fmt_depthstencil);
        break;
    case BBFI_MULTISAMPLE:
        fmt_buf = &bbfii->fmt_multisample[0];
        fmt_num = DR_ARRAY_LENGTH(bbfii->fmt_multisample);
        break;
    default:
        ret = ERR_INVALID_PARAM;
        goto __ret;
    }

    for(int i = 0; i < fmt_num; i++)
    {
        if(fmt_buf[i] == check_fmt)
            goto __ret_ok;

        if(fmt_buf[i] == 0)
            goto __ret;
    }

__ret_ok:
    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drDeviceObject::ScreenToWorld(drVector3* org, drVector3* ray, int x, int y)
{
    drScreenToWorld(org, ray, x, y, _viewport.Width, _viewport.Height, &_mat_proj, &_mat_view);

    return DR_RET_OK;
}
DR_RESULT drDeviceObject::WorldToScreen(int* x, int* y, float* z, const drVector3* v)
{
    drWorldToScreen(x, y, z, v, _viewport.Width, _viewport.Height, &_mat_proj, &_mat_view);

    return DR_RET_OK;
}

DR_RESULT drDeviceObject::DumpRenderState(const char* file)
{
    DWORD i, j;
    FILE* fp;
	fopen_s( &fp, file, "wt");

    if(fp)
    {
        fprintf(fp, "render state:\n");

        for(i = 0; i < DR_MAX_RENDERSTATE_NUM; ++i)
        {
            fprintf(fp, "%d\t\t\t%d\n", i, _rs_value[i]);
        }

        fprintf(fp, "texture stage state:\n");
        // texture stage
        for(j = 0; j < DR_MAX_TEXTURESTAGE_NUM; ++j)
        {
            for(i = 0; i < DR_MAX_TEXTURESTAGESTATE_NUM; ++i)
            {
                fprintf(fp, "%d\t%d\t\t%d\n", j, i, _tss_value[j][i]);
            }
        }

        fclose(fp);
    }

    return DR_RET_OK;
}

///////////

DR_END