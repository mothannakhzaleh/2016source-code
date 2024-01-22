//
#include "drD3DSettings.h"

DR_BEGIN

DR_RESULT drInitDefaultD3DCreateParam( drD3DCreateParam* param, HWND hwnd )
{
    IDirect3DX* d3d = Direct3DCreateX( D3D_SDK_VERSION );

    if( d3d == NULL )
        return DR_RET_FAILED;

    param->adapter = D3DADAPTER_DEFAULT;
    param->dev_type = D3DDEVTYPE_HAL;
    param->hwnd = hwnd;
    param->behavior_flag = D3DCREATE_HARDWARE_VERTEXPROCESSING;

    D3DDISPLAYMODE mode;
    d3d->GetAdapterDisplayMode( D3DADAPTER_DEFAULT, &mode );

    memset( &param->present_param, 0, sizeof( param->present_param ) );
    param->present_param.AutoDepthStencilFormat = D3DFMT_D24S8;
    param->present_param.BackBufferCount = 1;
    param->present_param.BackBufferFormat = mode.Format;
    param->present_param.BackBufferHeight = mode.Height;
    param->present_param.BackBufferWidth = mode.Width;
    param->present_param.EnableAutoDepthStencil = 1;
    param->present_param.hDeviceWindow = hwnd;
    param->present_param.SwapEffect = D3DSWAPEFFECT_DISCARD;
    param->present_param.Windowed = 1;

#if ( defined DR_USE_DX8 )
    param->present_param.FullScreen_PresentationInterval = D3DPRESENT_INTERVAL_DEFAULT;
#elif ( defined DR_USE_DX9 )
    param->present_param.PresentationInterval = D3DPRESENT_INTERVAL_DEFAULT;
#endif



    DR_SAFE_RELEASE( d3d );
    
    return DR_RET_OK;
}

DR_RESULT drLoadD3DSettings( drD3DCreateParam* param, const char* file )
{
    memset( param, 0, sizeof(drD3DCreateParam) );

    char buf[DR_MAX_NAME];

    GetPrivateProfileString( "D3DADAPTER", "adapter", "", buf, DR_MAX_NAME, file );
    param->adapter = atoi( buf );

    GetPrivateProfileString( "D3DDEVTYPE", "devtype", "", buf, DR_MAX_NAME, file );
    param->dev_type = (D3DDEVTYPE)atoi( buf );

    GetPrivateProfileString( "BEHAVIOR", "behavior", "", buf, DR_MAX_NAME, file );
    param->behavior_flag = atoi( buf );

    // present_param
    GetPrivateProfileString( "PRESENT_PARAM", "windowed", "", buf, DR_MAX_NAME, file );
    param->present_param.Windowed = atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "backbuffer_count", "", buf, DR_MAX_NAME, file );
    param->present_param.BackBufferCount = atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "backbuffer_format", "", buf, DR_MAX_NAME, file );
    param->present_param.BackBufferFormat = (D3DFORMAT)atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "backbuffer_height", "", buf, DR_MAX_NAME, file );
    param->present_param.BackBufferHeight = atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "backbuffer_width", "", buf, DR_MAX_NAME, file );
    param->present_param.BackBufferWidth = atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "enable_depthstencil", "", buf, DR_MAX_NAME, file );
    param->present_param.EnableAutoDepthStencil = atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "depthstencil_format", "", buf, DR_MAX_NAME, file );
    param->present_param.AutoDepthStencilFormat = (D3DFORMAT)atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "multisample_type", "",  buf, DR_MAX_NAME, file );
    param->present_param.MultiSampleType = (D3DMULTISAMPLE_TYPE)atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "refresh_rate", "", buf, DR_MAX_NAME, file );
    param->present_param.FullScreen_RefreshRateInHz = atoi( buf );

    GetPrivateProfileString( "PRESENT_PARAM", "present_interval", "", buf, DR_MAX_NAME, file );
#if ( defined DR_USE_DX8 )
    param->present_param.FullScreen_PresentationInterval = atoi( buf );
#elif ( defined DR_USE_DX9 )
    param->present_param.PresentationInterval = atoi( buf );
#endif



    return DR_RET_OK;
}

DR_RESULT drSaveD3DSettings( const char* file, const drD3DCreateParam* param )
{
    char buf[DR_MAX_NAME];

	_itoa_s( param->adapter, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "D3DADAPTER", "adapter", buf, file );
	_itoa_s( param->dev_type, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "D3DDEVTYPE", "devtype", buf, file );
	_itoa_s( param->behavior_flag, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "BEHAVIOR", "behavior", buf, file );
    // present_param
	_itoa_s( param->present_param.Windowed, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "windowed", buf, file );
	_itoa_s( param->present_param.BackBufferCount, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "backbuffer_count", buf, file );
	_itoa_s( param->present_param.BackBufferFormat, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "backbuffer_format", buf, file );
	_itoa_s( param->present_param.BackBufferHeight, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "backbuffer_height", buf, file );
	_itoa_s( param->present_param.BackBufferWidth, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "backbuffer_width", buf, file );
	_itoa_s( param->present_param.EnableAutoDepthStencil, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "enable_depthstencil", buf, file );
	_itoa_s( param->present_param.AutoDepthStencilFormat, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "depthstencil_format", buf, file );
	_itoa_s( param->present_param.MultiSampleType, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "multisample_type", buf, file );
	_itoa_s( param->present_param.FullScreen_RefreshRateInHz, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "refresh_rate", buf, file );

#if ( defined DR_USE_DX8 )
	_itoa_s( param->present_param.FullScreen_PresentationInterval, buf, DR_MAX_NAME, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "present_interval", buf, file );
#elif ( defined DR_USE_DX9 )
	_itoa_s( param->present_param.PresentationInterval, buf, 10 );
    WritePrivateProfileString( "PRESENT_PARAM", "present_interval", buf, file );
#endif

    return DR_RET_OK;
}


DR_END
