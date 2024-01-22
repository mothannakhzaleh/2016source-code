#include "StdAfx.h"
#include "LERender.h"
#include "LEMath.h"
#include "LETextureSet.h"
#include "drIFunc.h"
#include "ShaderLoad.h"
#include "drD3DSettings.h"
#include "drPredefinition.h"
#include "d3dutil.h"
#include "LEGameApp.h"
#include <ErrorReport.h>

#ifdef _SKYBOX_
#include "TextureManager.h"
#endif

#ifdef __VIM3D__
#include "vim_helper.h"			// VIM
using namespace Vision3D;		// VIM
#endif
#include <MyMemory.h>

LIGHTENGINE_API DWORD g_dwCurFrameTick = 0;
LIGHTENGINE_API float g_fFrameRate = 0.0f;
static DWORD g_dwLastFrameMoveTick = 0;
void LERender::SetCurFrameTick(DWORD dwTick)
{
	if( g_dwCurFrameTick)
	{
		// Mdr: float modifier in order to decrease playback speed
		// We assume here that original animations had a playback speed of 30 fps.
		g_fFrameRate			= ((float)(dwTick - g_dwCurFrameTick) / 33.3333333f); // ;
		g_dwLastFrameMoveTick = g_dwCurFrameTick;
	}
	g_dwCurFrameTick = dwTick;
}

LERender::LERender()
:_hWnd(0),
 _pD3D(NULL),
 _pD3DDevice(NULL),
 _p2DSprite(NULL),
 _dwBackgroundColor(0),
 _bClearTarget(true), 
 _bClearZBuffer(true),
 _bClearStencil(false),
 _bRealFPS(TRUE),
 _dwFPS(0),
 _dwLastTick(0),
 _dwFrameCnt(0),
 _bEnableCaptureAVI(FALSE),
 _bCaptureScreen(FALSE)
{
	_nCurViewType = -1;
    SetWorldViewFOV(D3DX_PI /4.0f * 0.90f);
	_dwBackgroundColor = D3DCOLOR_XRGB(128, 128, 128);
	_fNearClip = 1.0f;

#ifdef _SKYBOX_
	m_pTextureManager = NULL;
	_fFarClip  = 3000.0f;
#else
	_fFarClip  = 1000.0f;
#endif

    _d3dCPAdjustInfo.multi_sample_type = D3DMULTISAMPLE_NONE;

	ZeroMemory(&_Light, sizeof(_Light));	
}

LERender::~LERender()
{
	SAFE_DELETE(_pFont);
}

void LERender::End()
{
#ifdef __VIM3D__
	if(g_vimHelper.Is3D())
		g_vimHelper._destroy();		// VIM
#endif

	SAFE_RELEASE(_p2DSprite);

	SAFE_DELETE(_pFont);

#ifdef _SKYBOX_
	if( m_pTextureManager )
	{
		delete m_pTextureManager;
		m_pTextureManager = NULL;
		g_pTextureManager = NULL;
	}
#endif

    ResMgr.ReleaseTotalRes();


//  LG("end", "begin release mesh lib\n");

    drReleaseMeshLibSystem();

//  LG("end", "end release mesh lib\n");

	//SAFE_RELEASE(_pD3DDevice);
	//SAFE_RELEASE(_pD3D);
}

BOOL LERender::Init(HWND hWnd, int nScrWidth, int nScrHeight, int nColorBit, BOOL bFullScreen)
{
#ifdef __VIM3D__
	/*
	This function checks, whether "ViMD3DLib.dll" an the VisuMotion Display Configurator
	are available. Use ViM_Helper::Is3() to get result. 
	*/
	g_vimHelper._init();	//VIM
#endif

	_hWnd = hWnd;

    g_bBinaryTable = TRUE;
    ::GetClientRect(::GetDesktopWindow(), &_rcDeskTop);


    drD3DCreateParam d3dcp;
    memset(&d3dcp, 0, sizeof(d3dcp));
    d3dcp.hwnd = hWnd;
    d3dcp.adapter = D3DADAPTER_DEFAULT;
    d3dcp.behavior_flag = D3DCREATE_HARDWARE_VERTEXPROCESSING;
    d3dcp.dev_type = D3DDEVTYPE_HAL;

    IDirect3DX* d3d = Direct3DCreateX(D3D_SDK_VERSION);
    D3DDISPLAYMODE d3ddm;
    d3d->GetAdapterDisplayMode(D3DADAPTER_DEFAULT, &d3ddm);
    d3d->GetDeviceCaps(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, &_d3dCaps);
 
    d3dcp.present_param.hDeviceWindow = hWnd;
    d3dcp.present_param.Windowed = !bFullScreen;
    d3dcp.present_param.SwapEffect = D3DSWAPEFFECT_DISCARD;//bFullScreen ? D3DSWAPEFFECT_DISCARD : D3DSWAPEFFECT_COPY_VSYNC ;
	// 在全屏下同样设置垂直同步，因此将后缓冲数量改为2
	d3dcp.present_param.BackBufferCount = 2;
    //d3dcp.present_param.BackBufferCount = 1;
    d3dcp.present_param.BackBufferFormat = d3ddm.Format;//D3DFMT_UNKNOWN;
    d3dcp.present_param.BackBufferWidth = nScrWidth;
    d3dcp.present_param.BackBufferHeight = nScrHeight;
	d3dcp.present_param.EnableAutoDepthStencil = 1;

	//if( FAILED( d3d->CheckDeviceFormat( D3DADAPTER_DEFAULT,
	//	D3DDEVTYPE_HAL,
	//	d3ddm.Format,
	//	D3DUSAGE_DEPTHSTENCIL,
	//	D3DRTYPE_SURFACE,
	//	D3DFMT_D24S8 ) ) )
	//{
	//	d3dcp.present_param.AutoDepthStencilFormat = D3DFMT_D16;
	//}
	//else
	//{
	//	d3dcp.present_param.AutoDepthStencilFormat = D3DFMT_D24S8;
	//}

	d3dcp.present_param.AutoDepthStencilFormat = D3DFMT_D16;

	//  在全屏下同样设置垂直同步
	d3dcp.present_param.FullScreen_PresentationInterval = D3DPRESENT_INTERVAL_DEFAULT;
    // d3dcp.present_param.FullScreen_PresentationInterval = bFullScreen ? D3DPRESENT_INTERVAL_IMMEDIATE : D3DPRESENT_INTERVAL_DEFAULT;
    // 现在只是测试vs的版本，以后d3d的创建参数需要在外部获得
    if(_d3dCaps.VertexShaderVersion < D3DVS_VERSION(1,0))
    {
        d3dcp.behavior_flag = D3DCREATE_SOFTWARE_VERTEXPROCESSING;
		_bRealFPS = TRUE; //软件VertexShader肯定慢的，全速吧！ 
		d3dcp.present_param.SwapEffect = bFullScreen ? D3DSWAPEFFECT_DISCARD : D3DSWAPEFFECT_COPY_VSYNC ;
		d3dcp.present_param.BackBufferCount = 1; //老机器内存用少点
   }

    if(bFullScreen)
    {
        //d3dcp.present_param.FullScreen_RefreshRateInHz = 85;
		
    }

    d3dcp.behavior_flag |= D3DCREATE_MULTITHREADED;
    d3d->Release();


	// Init Mesh Lib
    DR_RESULT ret;
	drISystem* sys;
    drISysGraphics* sys_graphics;
    if(DR_FAILED(ret = drInitMeshLibSystem(&sys, &sys_graphics, &d3dcp, &_d3dCPAdjustInfo)))
    {
        char err_str[260];

        switch(ret)
        {
        case INIT_ERR_CREATE_D3D:
            _tcsncpy_s(err_str, "Create DirectX error", _TRUNCATE );
            break;
        case INIT_ERR_CREATE_DEVICE:
            //LG("init","msg请选择较低的桌面分辨率进行游戏");
            //修复客户端因显卡内存不足，创建失败，RES_STRING 导致 ValidateLocale 报错的问题
            //Engine中不可使用CResourceBundleManage,因为这个只在主程序中初始化，没有在DLL中初始化，
            //如果DLL中也想使用，应该从主程序中传入指针 
            //LG("init",RES_STRING(CL_LERENDER_CPP_00001)); 
															
            _tcsncpy_s(err_str, "Create DirectX Device error", _TRUNCATE);
            break;
        case INIT_ERR_DX_VERSION:
            _tcsncpy_s(err_str, "Invalid Installed Directx Version", _TRUNCATE);
            break;
        default:
            _tcsncpy_s(err_str, "Unknown Internal Error", _TRUNCATE );

        }
        ErrorLog(err_str);
        return FALSE;
    }


    drIDeviceObject* dev_obj = sys_graphics->GetDeviceObject();
    _pD3D = dev_obj->GetDirect3D();
    _pD3DDevice = dev_obj->GetDevice();
    _IMgr.sys = sys;
    _IMgr.sys_graphics = sys_graphics;
    _IMgr.dev_obj = sys_graphics->GetDeviceObject();
    _IMgr.res_mgr = sys_graphics->GetResourceMgr();
    _IMgr.tp_loadres = _IMgr.res_mgr->GetThreadPoolMgr()->GetThreadPool(THREAD_POOL_LOADRES);

    LoadShader0(sys_graphics);
    LoadShader1(sys_graphics);

    ToggleFullScreen();

    ResMgr.m_pSys = sys;
	ResMgr.m_pSysGraphics = sys_graphics;
	ResMgr.LoadTotalVShader(sys_graphics);

	D3DXCreateSprite(_pD3DDevice, &_p2DSprite);
	D3DUtil_InitLight( _Light, D3DLIGHT_DIRECTIONAL, -1.0f, -1.0f, -1.0f );
    SetDirectLIghtAmbient(0.0f, 0.0f, 0.0f, 0.0f);
	SetLight(0, &_Light);
	LightEnable(0, TRUE);

	if(!_LoadStateFromFile())
	{
		return FALSE;
	}

    D3DXVECTOR3	up = D3DXVECTOR3( 0.0f, 0.0f, 1.0f );
    D3DXVECTOR3	eye = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );
    D3DXVECTOR3	target = D3DXVECTOR3( 0.0f, 0.0f, 0.0f );
	D3DXMatrixLookAtLH( &_mat3DUIView, &eye, &target, &up );	  

    _fAspect = (float)_nWorldViewWidth / ((float)(_nWorldViewHeight));
    D3DXMatrixPerspectiveFovLH(&_mat3DUIProj, D3DX_PI * 0.12f, _fAspect, _fNearClip, _fFarClip);
    SetRenderState( D3DRS_ZENABLE  , TRUE );
	SetRenderState( D3DRS_AMBIENT, 0xffffffff );
	SetRenderState(D3DRS_CULLMODE , D3DCULL_NONE);

    if(InitLETextureSetFormat() == 0)
        return FALSE;

#ifdef __VIM3D__
	if(g_vimHelper.Is3D())	
	{
		int i = 0;
	}

		//Init VIM data
	char szValue[128];
	ZeroMemory( szValue, 128 );

	char Result[256] = "";
	GetModuleFileNameA( NULL, Result, 256 );

	int index;
	for( index = ( int ) ( strlen( Result ) - 1 ); index > 0; index -- )
	{
		if( Result[index - 1] == '\\' || Result[index - 1] == '/' )
			break;
	}
	Result[index] = 0;

	size_t Length = strlen( Result ) + strlen( "VIMConfig.ini" ) + 1;
	strcat_s( Result, Length, "VIMConfig.ini" );
	GetPrivateProfileString("Info", "TranslationValue", "0.12", szValue, sizeof(szValue), Result );
	m_fCamTranslation = atof( szValue );

	GetPrivateProfileString( "Info", "FixPointValue", "150.0", szValue, sizeof(szValue), Result );
	m_fCamFixPoint = atof( szValue ); 
#endif//__VIM3D__

	_pFont =  new CLEFont;
#ifdef USE_RENDER
	if( !_pFont->CreateFont(this, "System") )
		LG("ERROR","msgCreateSystemFont");
#else
	_pFont->CreateFont(GetDevice(), "System");
#endif
	_pFont->BindingRes( &ResMgr );
	return TRUE;
}
//-----------------------------------------------------------------------------
BOOL LERender::InitResource()
{
#ifdef _SKYBOX_
	m_pTextureManager = new CTextureManager;
	if(m_pTextureManager==NULL)
	{
		WriteLog(INFO_ERROR, "Can't Create Texture Manager.");
		return false;
	}
	g_pTextureManager = m_pTextureManager;
#endif

#ifdef USE_RENDER
	if(!ResMgr.InitRes(this,(D3DXMATRIX*)_IMgr.dev_obj->GetMatView(),(D3DXMATRIX*)_IMgr.dev_obj->GetMatViewProj()))
#else
	if(!ResMgr.InitRes(_pD3DDevice,&GetWorldViewMatrix(),&GetViewProjMatrix()))
#endif
	{
		LG("error","msg初始化ResMgr失败,退出!");
		return FALSE;
	}
	return TRUE;
}

BOOL LERender::InitRes2()
{
	if(!ResMgr.InitRes2())
	{
		LG("error","msg初始化ResMgr 2失败,退出!");
		return FALSE;
	}
	return TRUE;
}

BOOL LERender::InitRes3()
{
	if(!ResMgr.InitRes3())
	{
		LG("error","msg初始化ResMgr 3失败,退出!");
		return FALSE;
	}
	return TRUE;
}

//-----------------------------------------------------------------------------


int LERender::ToggleFullScreen(int width, int height, D3DFORMAT depth_fmt, bool be_windowed)
{
	drIResourceMgr* res_mgr = _IMgr.res_mgr;
	drIDeviceObject* dev_obj = _IMgr.dev_obj;
    IDirect3DX* dev = dev_obj->GetDirect3D();

	HWND hwnd = _hWnd;

	RECT wnd_rc = { 0, 0, width, height };
	DWORD style;

	if(be_windowed)
	{
		if(wnd_rc.right == _rcDeskTop.right && wnd_rc.bottom == _rcDeskTop.bottom)
		{
			style = WS_POPUP;
		}
		else
		{
			style = WS_CAPTION|WS_SYSMENU|WS_MINIMIZEBOX|WS_VISIBLE;
			::AdjustWindowRectEx(&wnd_rc, style, 0, 0);
		}
	}
    else
	{
        style = WS_POPUP;
	}

	drWndInfo wnd_info;
	wnd_info.hwnd = hwnd;
	wnd_info.left = 0;
	wnd_info.top = 0;
	wnd_info.width =  wnd_rc.right - wnd_rc.left;
	wnd_info.height = wnd_rc.bottom - wnd_rc.top;
	wnd_info.windowed_style = style;

    drD3DCreateParam d3dcp = *dev_obj->GetD3DCreateParam();
    d3dcp.present_param.Windowed = be_windowed;
    //d3dcp.present_param.BackBufferFormat = back_fmt;
    d3dcp.present_param.BackBufferWidth = width;
    d3dcp.present_param.BackBufferHeight = height;
    d3dcp.present_param.AutoDepthStencilFormat = depth_fmt;


    if(DR_FAILED(drAdjustD3DCreateParam(dev, &d3dcp, &_d3dCPAdjustInfo)))
    {
		LG("error", "msgToggleFullScreen error");
        return 0;
    }

    if(ToggleFullScreen(&d3dcp.present_param, &wnd_info) == 0)
	{
		LG("error", "msgToggleFullScreen error");
		return 0;
	}

    return 1;

}
int LERender::ToggleFullScreen(D3DPRESENT_PARAMETERS* d3dpp, drWndInfo* wnd_info)
{
#ifdef __VIM3D__
	/*
	This will be called if the the resolution or the fullscreen mode is changing.
	We have to destroy 
	*/
	if(g_vimHelper.Is3D())			// VIM
		g_vimHelper._destroy();		// VIM
#endif//__VIM3D__

    SAFE_RELEASE(_p2DSprite);
    if(DR_FAILED(_IMgr.sys_graphics->ToggleFullScreen(d3dpp, wnd_info)))
        return 0;

    D3DXCreateSprite(_pD3DDevice, &_p2DSprite);
    return ToggleFullScreen();
}
int LERender::ToggleFullScreen()
{
    drD3DCreateParam* d3dcp = _IMgr.dev_obj->GetD3DCreateParam();
    _bFullScreen    = !d3dcp->present_param.Windowed;
	
    RECT rc;
    GetClientRect(d3dcp->present_param.hDeviceWindow, &rc);
    _nScrWidth  = rc.right  - rc.left;
    _nScrHeight = rc.bottom - rc.top;

    SetWorldView(0, 0, _nScrWidth, _nScrHeight);

    SetViewport(0, 0, d3dcp->present_param.BackBufferWidth, d3dcp->present_param.BackBufferHeight);

    //LightEnable(0, TRUE);
    //UpdateLight();

    if(InitLETextureSetFormat() == 0)
        return 0;

#ifdef __VIM3D__
	if(g_vimHelper.Is3D())		//VIM
		g_vimHelper._create();	//VIM
#endif//__VIM3D__

    return 1;
}

int LERender::InitLETextureSetFormat()
{
    // begin init texture format which was used in LETextureSet.cpp
    {
        D3DFORMAT alpha_fmt = D3DFMT_A8R8G8B8;

__check_it:
        DR_RESULT ret = _IMgr.dev_obj->CheckCurrentDeviceFormat(BBFI_TEXTURE, alpha_fmt);
        if(DR_FAILED(ret))
        {
            if(ret == ERR_INVALID_PARAM)
            {
                return 0;
            }
            else
            {
                if(alpha_fmt == D3DFMT_A4R4G4B4)
                {
                    return 0;
                }

                alpha_fmt = D3DFMT_A4R4G4B4;
                goto __check_it;
            }
        }

        _TexSetFmt[0] = D3DFMT_R5G6B5;
        _TexSetFmt[1] = alpha_fmt;
    }
    // end

    return 1;
}

void LERender::SetViewport(int nStartX, int nStartY, int nWidth, int nHeight)
{
    _view.X	     = nStartX;
	_view.Y	     = nStartY;
	_view.Width  = nWidth;
	_view.Height = nHeight;
	_view.MinZ	 = 0.0f;
	_view.MaxZ	 = 1.0f;
    HRESULT hr = _pD3DDevice->SetViewport(&_view);
	if (FAILED(hr))
	{
		LG("render", "Error when SetViewport(), [%d].\n", hr);
	}
    // LG("render", "Set View Port [x = %d, y = %d , w = %d, h = %d\n", nStartX, nStartY, nWidth, nHeight);
}

BOOL LERender::IsLineInWorldView(float fX1, float fY1, float fX2, float fY2)
{
    float v1[2] = { fX1, fY1 };
    float v2[2] = { fX2, fY2 };
    float v0[2];
    float x1 = (float)_nWorldViewStartX;
    float y1 = (float)_nWorldViewStartY;
    float x2 = (float)(_nWorldViewStartX + _nWorldViewWidth);
    float y2 = (float)(_nWorldViewStartY + _nWorldViewHeight);
    for(int i = 0; i < 4; i++)
    {
        float v3[2], v4[2];
        switch(i)
        {
            case 0:
            {   
                v3[0] = x1; v3[1] = y1;
                v4[0] = x2; v4[1] = y1;
                break;
            }
            case 1:
            {   
                v3[0] = x2; v3[1] = y1;
                v4[0] = x2; v4[1] = y2;
                break;
            }
            case 2:
            {
                v3[0] = x1; v3[1] = y2;
                v4[0] = x2; v4[1] = y2;
                break;
            }
            case 3:
            {
                v3[0] = x1; v3[1] = y1;
                v4[0] = x1; v4[1] = y2;
                break;
            }
        }
        if(Get2DLineIntersection(v1, v2, v3, v4, v0, FALSE)) return TRUE;
    }
    return FALSE;
}

BOOL LERender::IsRectIntersectWorldView(int *pnPosX, int *pnPosY)
{
    int x1, y1, x2, y2;
    for(int i = 0; i < 4; i++)
    {
        switch(i)
        {
            case 0: { x1 = *(pnPosX + 0); y1 = *(pnPosY + 0); x2 = *(pnPosX + 1); y2 = *(pnPosY + 1); break; }
            case 1: { x1 = *(pnPosX + 1); y1 = *(pnPosY + 1); x2 = *(pnPosX + 2); y2 = *(pnPosY + 2); break; }
            case 2: { x1 = *(pnPosX + 2); y1 = *(pnPosY + 2); x2 = *(pnPosX + 3); y2 = *(pnPosY + 3); break; }
            case 3: { x1 = *(pnPosX + 3); y1 = *(pnPosY + 3); x2 = *(pnPosX + 0); y2 = *(pnPosY + 0); break; }
        }
        if(IsLineInWorldView((float)x1, (float)y1, (float)x2, (float)y2))
        {
            return TRUE;
        }
    }
    return FALSE;
}

#ifdef __VIM3D__
////////////////////////////////////////////////////////////////
// VIM Start

using namespace Vision3D;

void LERender::reset_Camera_Project_VIEW_WORLD(  D3DXMATRIX* mat, const float fov_y, const float aspect, const float zn, const float zf )
{
	int viewIndex = 0;
	Vision3D::g_vimHelper.GetViewIndex ( viewIndex );

	float near3d = g_fCamNear * g_fCamTarget;
	float far3d = g_fCamFar * g_fCamTarget;
	
	float maxPixDisp = 6;

	//float trans = 0.20f;
	//float fixpoint = 150.5f;

	//ViMD3Dutil_MatrixPerspectiveFovLH(mat,fov_y,aspect,
	//		1.0, zf,																		// ViM
	//		trans,fixpoint,viewIndex, g_dwNumViews);					// ViM
	ViMD3Dutil_MatrixPerspectiveFovLH(mat,fov_y,aspect,
			1.0, zf,																		// ViM
			m_fCamTranslation, m_fCamFixPoint, viewIndex, g_dwNumViews);					// ViM
}

void LERender::reset_Camera_Project_VIEW_UI(  D3DXMATRIX* mat, const float fov_y, const float aspect, const float zn, const float zf )
{
	int viewIndex = 0;
	Vision3D::g_vimHelper.GetViewIndex ( viewIndex );

	const float trans = 3.0f;						//Needs to be adjusted
	const float fixpoint = zn + (zf - zn)* 0.333f;	//Needs to be adjusted

	ViMD3Dutil_MatrixPerspectiveFovLH(mat,fov_y,aspect,
			zn, zf,																		// ViM
			trans,fixpoint,viewIndex, g_dwNumViews);					// ViM
}
#endif//__VIM3D__

void LERender::SetCurrentView(int nType, BOOL bReset)
{
	if(nType==_nCurViewType && !bReset) return;


	
    switch(nType)
	{
	    case VIEW_WORLD:
        {
			D3DXMatrixIdentity(&_matProjWorld);

#ifdef __VIM3D__
			if(g_vimHelper.Is3D())
			{
				SetViewport(_nWorldViewStartX, _nWorldViewStartY, _nWorldViewWidth, _nWorldViewHeight);
				this->reset_Camera_Project_VIEW_WORLD(&_matProjWorld,_fWorldViewFOV, _fAspect, _fNearClip, _fFarClip);
			}
			else
#endif//__VIM3D__
				D3DXMatrixPerspectiveFovLH(&_matProjWorld, _fWorldViewFOV, _fAspect, _fNearClip, _fFarClip);
			

#if(defined USE_MANAGED_RES)
            SetTransformProj(&_matProjWorld);
#else
			_pD3DDevice->SetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&_matProjWorld );
#endif
            _matViewProj = _matViewWorld * _matProjWorld;
			break;
        }
	 case VIEW_UI:
        {
            D3DXMatrixIdentity(&_matUIView);
			D3DXMatrixIdentity(&_matUIProj);

#ifdef __VIM3D__
			if(g_vimHelper.Is3D())
				this->reset_Camera_Project_VIEW_UI(&_matUIProj,0.1f, _fAspect, 10, 100);
			else
#endif//__VIM3D__
				D3DXMatrixPerspectiveFovLH(&_matUIProj, 0.1f, _fAspect, 10, 100);


#if(defined USE_MANAGED_RES)
            SetTransformProj(&_matUIProj);
#else
            _pD3DDevice->SetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&_matUIProj );
#endif

	        D3DXVECTOR3	upVector = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );	
	        D3DXVECTOR3	vecCam(0, 0, -50);
	        D3DXVECTOR3	vecLookAt(0, 0, 0);
	        D3DXMatrixLookAtLH( &_matUIView, &vecCam, &vecLookAt, &upVector );
#if(defined USE_MANAGED_RES)
            SetTransformView(&_matUIView);
#else
	        _pD3DDevice->SetTransform( D3DTS_VIEW, &_matUIView );
#endif
			break;
        }
        case VIEW_SCREEN:
            break;
        case VIEW_3DUI:
#if(defined USE_MANAGED_RES)
            SetTransformProj(&_mat3DUIProj);
            SetTransformView(&_mat3DUIView);
#else
            _pD3DDevice->SetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&_mat3DUIProj );
            _pD3DDevice->SetTransform( D3DTS_VIEW, &_mat3DUIView ); 
#endif
            _matViewProj = _mat3DUIView * _mat3DUIProj;
            break;
        default:
        {
            break;
        }
    }
}

/*
void LERender::SetCurrentView(int nType, BOOL bReset)
{
	if(nType==_nCurViewType && !bReset) return;

    //_nCurViewType = nType;

	switch(nType)
	{
	    case VIEW_WORLD:
        {
            D3DXMatrixIdentity(&_matProjWorld);
            // SetViewport(_nWorldViewStartX, _nWorldViewStartY, _nWorldViewWidth, _nWorldViewHeight);
            //float fAspect = (float)_nWorldViewWidth / ((float)(_nWorldViewHeight));
	        D3DXMatrixPerspectiveFovLH(&_matProjWorld, _fWorldViewFOV, _fAspect, _fNearClip, _fFarClip);

#if(defined USE_MANAGED_RES)
            SetTransformProj(&_matProjWorld);
#else
            _pD3DDevice->SetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&_matProjWorld);
#endif
            _matViewProj = _matViewWorld * _matProjWorld;
			break;
        }
        case VIEW_UI:
        {
            D3DXMatrixIdentity(&_matUIView);
			D3DXMatrixIdentity(&_matUIProj);

			//SetViewport(0, 0, _nScrWidth, _nScrHeight);
            //FLOAT fAspect = (float)_nScrWidth / (float)_nScrHeight;
            D3DXMatrixPerspectiveFovLH(&_matUIProj, 0.1f, _fAspect, 10, 100);

#if(defined USE_MANAGED_RES)
            SetTransformProj(&_matUIProj);
#else
            _pD3DDevice->SetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&_matUIProj );
#endif

	        D3DXVECTOR3	upVector = D3DXVECTOR3( 0.0f, 1.0f, 0.0f );	
	        D3DXVECTOR3	vecCam(0, 0, -50);
	        D3DXVECTOR3	vecLookAt(0, 0, 0);
	        D3DXMatrixLookAtLH( &_matUIView, &vecCam, &vecLookAt, &upVector );
#if(defined USE_MANAGED_RES)
            SetTransformView(&_matUIView);
#else
	        _pD3DDevice->SetTransform( D3DTS_VIEW, &_matUIView );
#endif
			break;
        }
        case VIEW_SCREEN:
            break;
        case VIEW_3DUI:
#if(defined USE_MANAGED_RES)
            SetTransformProj(&_mat3DUIProj);
            SetTransformView(&_mat3DUIView);
#else
            _pD3DDevice->SetTransform( D3DTS_PROJECTION, (D3DMATRIX*)&_mat3DUIProj );
            _pD3DDevice->SetTransform( D3DTS_VIEW, &_mat3DUIView ); 
#endif
            _matViewProj = _mat3DUIView * _mat3DUIProj;
            break;
        default:
        {
            //SetViewport(0, 0, _nScrWidth, _nScrHeight);
            break;
        }
    }
}
*/
////////////////////////////////////////////////////////////////
// VIM END


//transform 3d world position into screen space
void LERender::GetScreenPos(int &nOutX, int &nOutY, D3DXVECTOR3 &vWorldPos)
{
	D3DXVECTOR4 vOut;
	D3DXVec3Transform(&vOut, &vWorldPos, &_matViewProj);
	nOutX = _nWorldViewStartX + int((float)_nWorldViewWidth * (vOut.x / vOut.w*0.5f+0.5f));
	nOutY = _nWorldViewStartY + int(((float)(_nWorldViewHeight))*(0.5f - vOut.y / vOut.w * 0.5f));
}


void LERender::GetRay(int nScreenX, int nScreenY, D3DXVECTOR3 &vRayStart, D3DXVECTOR3 &vRayEnd)
{
	D3DXMATRIX matInverse;

	D3DXMatrixInverse(&matInverse, NULL, &_matViewProj);

	D3DXVECTOR4 vOut;
	D3DXVECTOR3 v;
	v.x = float(nScreenX - _nWorldViewStartX) / (float)_nWorldViewWidth - 0.5f;
	v.x+= v.x;
	v.y = 0.5f - float(nScreenY - _nWorldViewStartY)/((float)(_nWorldViewHeight));
	v.y+= v.y;
	v.z = 0.0f;
	D3DXVec3Transform(&vOut, &v, &matInverse);
	vRayStart = D3DXVECTOR3(vOut.x/vOut.w, vOut.y/vOut.w, vOut.z/vOut.w);
	v.z = 1.0f;
	D3DXVec3Transform(&vOut,&v, &matInverse);
	vRayEnd = D3DXVECTOR3(vOut.x/vOut.w, vOut.y/vOut.w, vOut.z/vOut.w);
}

void LERender::GetPickRayVector(int nScrPosX, int nScrPosY, D3DXVECTOR3* pPickRayOrig, D3DXVECTOR3* pPickRayDir)
{	
	GetRay(nScrPosX, nScrPosY, *pPickRayOrig, *pPickRayDir);
	(*pPickRayDir) = (*pPickRayDir) - (*pPickRayOrig);
	D3DXVec3Normalize(pPickRayDir, pPickRayDir);
}

void LERender::LookAt(D3DXVECTOR3 vecPos, D3DXVECTOR3 vecLookAt,DWORD dwViewType)
{
    D3DXMATRIX* mat = NULL;

	switch( dwViewType)
	{
    case VIEW_WORLD:
        mat = &_matViewWorld;
        break;
    case VIEW_3DUI:
        mat = &_mat3DUIView;
        break;
    default:
        return;
    }

    D3DXVECTOR3	upVector = D3DXVECTOR3( 0.0f, 0.0f, 1.0f );
	D3DXMatrixLookAtLH( mat, &vecPos, &vecLookAt, &upVector );	

#if(defined USE_MANAGED_RES)
    SetTransformView(mat);
#else
    _pD3DDevice->SetTransform( D3DTS_VIEW, mat );
#endif

#ifdef __VIM3D__
	/////////////////////////////////
	//ViM
	if(dwViewType == VIEW_WORLD)
	{
		D3DXVECTOR3 vec = vecPos - vecLookAt;

		Vision3D::g_fCamTarget = sqrtf(vec.x*vec.x + vec.y*vec.y + vec.z*vec.z);
	}
	/////////////////////////////////
#endif//__VIM3D__

	//D3DXMATRIX matProj;
    //D3DXMatrixPerspectiveFovLH( &_matProjWorld, D3DX_PI/4, 1.0f, 1.0f, 1000.0f );
    //_pD3DDevice->SetTransform( D3DTS_PROJECTION, &_matProjWorld );

	// _matViewProj = _matViewWorld * _matProjWorld;
}

BOOL LERender::BeginRender(bool clear)//vim
{

	HRESULT hr;
    if(FAILED(hr = _IMgr.sys_graphics->TestCooperativeLevel()))
    {
        return 0;
    }
    if(hr == DR_RET_OK_1)
    {
        LightEnable(0, TRUE);
        UpdateLight();
    }

#if 0
	HRESULT hr;
    if( FAILED( hr = _pD3DDevice->TestCooperativeLevel() ) ) // 如果运行中切换分辨率和颜色...
    {
        // If the device was lost, do not render until we get it back
        if (D3DERR_DEVICELOST == hr) return FALSE;
		
        if (D3DERR_DEVICENOTRESET == hr)
        {
			return FALSE;
			// if (FAILED(_pD3DDevice->Reset(&g_pDevice->m_d3dpp))) return false;
		}
    }
#endif
    
    _dwClearFlag = 0;
    if(_bClearTarget)	_dwClearFlag|=D3DCLEAR_TARGET;
    if(_bClearZBuffer)  _dwClearFlag|=D3DCLEAR_ZBUFFER;
    if(_bClearStencil)  _dwClearFlag|=D3DCLEAR_STENCIL;
    
    
    if(clear)//vim
	{
		if(FAILED( _pD3DDevice->Clear( 0L, NULL, _dwClearFlag, _dwBackgroundColor, 1.0f, 0L ) ) )
		{
			LG("error", "D3D Device Clear Failed!\n");
			return false;
		}
	}
    
	if ( FAILED( _pD3DDevice->BeginScene() ) ) 
    {
		return false;
	}
	
	return true;
}

void LERender::EndRender(bool present)//vim
{
	if(FAILED(_pD3DDevice->EndScene())) 
    {
        LG("error", "D3D End Scene Fail!\n");
        return;
    }

	if(present)
	{
		DWORD dwTick = GetTickCount();
		
		if((dwTick - _dwLastTick) >= 100)
		{
			_dwFPS      = _dwFrameCnt*10;
			_dwFrameCnt = 0;
			_dwLastTick = dwTick;

			Print(INFO_FPS, 5, 80, "FPS : %d", _dwFPS);
		}
		
	


		_dwFrameCnt++;

		static int g_nAviCnt = 0;
		static int g_nCapCnt = 0;

		if(_bCaptureScreen) // 单次截屏
		{
			static int g_nScreenCap = 0;
			Util_MakeDir("screenshot/");

			char pszName[MAX_PATH];
			__time64_t t;
			_time64(&t);
			tm ltime;
			_gmtime64_s( &ltime, &t );
			sprintf_s(pszName, _countof(pszName), "screenshot/%04d-%02d-%02d/",ltime.tm_year+1900,ltime.tm_mon+1,ltime.tm_mday);
			Util_MakeDir(pszName);

			char fileName[MAX_PATH];
			sprintf_s(fileName,_countof(fileName) ,"%scap%05d.bmp",pszName, g_nScreenCap);
			g_Render.CaptureScreen(fileName);
			g_nScreenCap++;
			_bCaptureScreen = FALSE;
		}

		if(_bEnableCaptureAVI) // 连续截屏
		{
			char szFileName[64];
			Util_MakeDir("screenshot/");
			_snprintf_s(szFileName,64,_TRUNCATE,"screenshot/avi%06d.bmp",g_nAviCnt);
			CaptureScreen(szFileName);
			g_nAviCnt++;
		}

		if(_bFullScreen || 1)
		{
			_pD3DDevice->Present(NULL, NULL, NULL, NULL );
		}
		else
		{
			RECT rc;
			rc.left = 0;
			rc.top = 0;
			rc.right = this->_nScrWidth;
			rc.bottom = this->_nScrHeight;
			_pD3DDevice->Present(&rc, NULL, NULL, NULL );
		}
	}
}


void LERender::RenderAllLines()
{
	for(vector<LELine*>::iterator it = _LineList.begin(); it!=_LineList.end(); it++)
	{
		LELine *pLine = (*it);
		RenderLine(pLine->v1.x, pLine->v1.y, pLine->v1.z, pLine->v2.x, pLine->v2.y, pLine->v2.z, pLine->dwColor);
		delete pLine;
	}
	_LineList.clear();
}


void LERender::RenderDebugInfo()
{
    for(int i = 0; i < MAX_INFO_TYPE; i++)
    {
        if(!_PrintInfoMask[i]) continue;
        for(map<int, string>::iterator it = _InfoIdx[i].begin(); it!=_InfoIdx[i].end(); it++)
        {
            int  nIdx = (*it).first;
            string &str = (*it).second;
            int nPosY = nIdx / 2000;
            int nPosX = nIdx % 2000;
			_pFont->DrawText((TCHAR*)str.c_str(),nPosX, nPosY, 0xffffffff);
    	}
	}
}

void LERender::Print(int nInfoType, int x, int y, const char *szFormat, ...)
{           
    va_list list;
	va_start(list, szFormat);           
	_vsnprintf_s(_szInfo, _TRUNCATE ,szFormat, list);
	va_end( list );

    int nIdx = y * 2000 + x; // 不会重复的屏幕坐标
    _InfoIdx[nInfoType][nIdx] = _szInfo;
}

// Render States Routines
void LERender::EnableMipmap(BOOL bEnable)
{
    if(bEnable)
    {
        SetTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_LINEAR );
    }
    else // 关闭mipmap
    {
        SetTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_NONE ); 
    }
}

void LERender::RenderTextureRect(int nX, int nY, LETexRect *pRect)
{
	VECTOR2 vecDest((float)nX, (float)nY);
	VECTOR2 vecScale(pRect->fScaleX, pRect->fScaleY);
	LPTEXTURE pTexture = GetTextureByID(pRect->nTextureNo);
	if(!pTexture) return;
	
	RECT *pTexRect = NULL;
	RECT TexRect = { pRect->nTexSX, pRect->nTexSY, pRect->nTexSX + pRect->nTexW, pRect->nTexSY + pRect->nTexH };
	if(pRect->nTexW!=0) pTexRect = &TexRect;
	// _p2DSprite->Draw(NULL, NULL, NULL , NULL, 0, &vecDest, pRect->dwColor);
	_p2DSprite->Draw(pTexture, pTexRect, &vecScale, NULL, 0, &vecDest, pRect->dwColor);

}

void LERender::RenderLine(float x1, float y1, float z1, float x2, float y2, float z2, DWORD dwColor)
{
    D3DXMATRIXA16 mat;
	D3DXMatrixIdentity(&mat);
	
	D3DXMatrixTranslation(&mat, 0.0f, 0.0f, 0.0f);
#if(defined USE_MANAGED_RES)
    SetTransformWorld(&mat);
#else
	_pD3DDevice->SetTransform(D3DTS_WORLD, &mat);
#endif

	struct TLE_VERTEX
    {
	    D3DVECTOR pos;
	    DWORD diffuse;
    };

    TLE_VERTEX pVertices[2];

	// line 1
	pVertices[0].pos = D3DXVECTOR3(x1 , y1 , z1);
	pVertices[1].pos = D3DXVECTOR3(x2 , y2 , z2);
	pVertices[0].diffuse = dwColor;
	pVertices[1].diffuse = dwColor;

	SetRenderState( D3DRS_LIGHTING, FALSE );
	SetTexture(0, 0);
	SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE);
	_pD3DDevice->DrawPrimitiveUP(D3DPT_LINELIST, 1 , pVertices , sizeof(TLE_VERTEX));
	SetRenderState( D3DRS_LIGHTING, TRUE );
	//SetRenderState( D3DRS_ZENABLE,  TRUE );
}

void LERender::AddLine(D3DXVECTOR3 &v1, D3DXVECTOR3& v2,DWORD dwColor)
{
	LELine *pLine = new LELine;
	pLine->v1		= v1;
	pLine->v2		= v2;
	pLine->dwColor	= dwColor;

	_LineList.push_back(pLine);
}

void LERender::_AddText(const char *pszText, DWORD dwColor)
{

}

LIGHTENGINE_API LERender g_Render;
LIGHTENGINE_API int g_nTemp = 0; 

/************************************************************************/
/* state*/
/************************************************************************/
bool	LERender::_LoadStateFromFile()
{
	return true;
}
void	LERender::BeginState(int iIdx)
{
}
void	LERender::EndState()
{
}

///////////////////////////////////////////////
bool SurfaceToBLE( LPDIRECT3DSURFACE8 pSurface, const char * strName, int nFlag)
{
	D3DSURFACE_DESC		Desc;
	int					nPitch;
	D3DLOCKED_RECT		Rect;
	bool				bSaveDirect = true;
	bool				bSaveBmp	= true;

	if(nFlag==0)
	{
		bSaveBmp = true;
		bSaveDirect = false;
	}
	else
	{
		bSaveBmp = false;
		bSaveDirect = true;
	}

	if( !pSurface )
		return false;
	pSurface->GetDesc( &Desc );

	nPitch = ( Desc.Width * 3 + 3 ) &  ~0x3;
	if( pSurface->LockRect( &Rect, NULL, D3DLOCK_READONLY ) != D3D_OK )
		return false;

	int	nSPitch, nDPitch, nW, nH;

	LPBYTE pbtTmp  = new BYTE[ Desc.Width * Desc.Height * 4 ];//g_pbtBmp;

	switch( Desc.Format )
	{
		case D3DFMT_R8G8B8:
			break;
		case D3DFMT_X8R8G8B8:
			nSPitch = -( ( int )( Rect.Pitch + Desc.Width * 4 ) );
			nDPitch = nPitch - Desc.Width * 3;
			Rect.pBits = ( ( BYTE * )Rect.pBits ) + ( Desc.Height - 1 ) * Rect.Pitch;
			pbtTmp += sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER );
			_asm{
				mov esi, Rect.pBits;
				mov edi, pbtTmp;
				mov ecx, Desc.Width;
				mov edx, Desc.Height;
				mov ebx, ecx;
				cld;
				jmp P32_2;
P32_1:			add esi, nSPitch;
				add edi, nDPitch;
				mov ecx, ebx;
P32_2:			/*lodsd;
				mov [ edi ], ax;
				shr eax, 16;
				add edi, 3;
				mov [ edi - 1 ], al;*/
				movsd;
				dec edi;
				loop P32_2;
				dec edx;
				jnz P32_1;
			}
			pbtTmp -= sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER );
			break;
		case D3DFMT_R5G6B5:
		case D3DFMT_X1R5G5B5:
			if( bSaveDirect )
			{
				DWORD dwSaveStart = GetTickCount();
				FILE * fp;
				size_t Length = strlen( strName ) + strlen( ".t16" ) + 1;
				strcat_s( ( char * )strName, Length, ".t16" );
				fopen_s( &fp, strName, "wb" );
				fwrite( &Desc.Format, sizeof( Desc.Format ), 1, fp );
				fwrite( &Desc.Width, sizeof( Desc.Width ), 1, fp );
				fwrite( &Desc.Height, sizeof( Desc.Height ), 1, fp );
				for( int i = Desc.Height - 1 ; i >= 0; i-- )
				{
					fwrite( ( BYTE * )Rect.pBits+ i * Rect.Pitch, 1, Desc.Width * 2, fp );
				}
				fclose( fp );
				pSurface->UnlockRect();
//				LG("" "Save File Time = %d\n", GetTickCount() - dwSaveStart);
				return true;
			}
			else if( bSaveBmp ){
				nSPitch = -( ( int )( Rect.Pitch + Desc.Width * 2 ) );
				nDPitch = nPitch - Desc.Width * 3;
				Rect.pBits = ( ( BYTE * )Rect.pBits ) + ( Desc.Height - 1 ) * Rect.Pitch;
				pbtTmp += sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER );
				nW = Desc.Width / 2;
				nH = Desc.Height;
				/*_asm{
					mov ecx, nW;
					mov esi, Rect.pBits;
					mov edi, g_pbtBmp;
					xor eax, eax;
					cld;
P16TO24_1:			lodsw;
					mov ebx, eax;
					shl eax, 8;
					mov edx, ebx;
					shl ebx, 5;
					and eax, 0xff0000;
					shl edx, 3;
					and ebx, 0xff00;
					and edx, 0xff;
					or eax, ebx;
					or eax, edx;
					stosd;
					dec edi;
					loop P16TO24_1;
					add esi, nSPitch;
					add edi, nDPitch;
					dec nH;
					mov ecx, nW;
					jnz P16TO24_1;
				}*/
				__int64			nRMask = 0x0000f8000000f800;		//R5G6B5 mask
				__int64			nGMask = 0x000007e0000007e0;
				__int64			nBMask = 0x0000001f0000001f;
				_asm{
					movq mm5, nRMask;
					movq mm6, nGMask;
					movq mm7, nBMask;
					mov ecx, nW;
					mov esi, Rect.pBits;
					mov edi, pbtTmp;
					xor eax, eax;
					cld;
P16TO24_2:			movd mm0, [ esi + 2 ];
					add esi, 4;
					movd mm1, [ esi - 4 ];
					psllq mm0, 32;
					por mm0, mm1;
					movq mm1, mm0;
					pand mm0, mm5;
					movq mm2, mm1;
					psllq mm0, 8;
					pand mm1, mm6;
					psllq mm1, 5;
					pand mm2, mm7;
					por mm0, mm1;
					psllq mm2, 3;
					por mm0, mm2;
					movd [ edi ], mm0;
					psrlq mm0, 32;
					movd [ edi + 3 ], mm0;
					add edi, 6;
					loop P16TO24_2;
					add esi, nSPitch;
					add edi, nDPitch;
					dec nH;
					mov ecx, nW;
					jnz P16TO24_2;
					emms;
				}
				pbtTmp -= sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER );
			}
			else {
				nPitch = Desc.Width * 2;
				nSPitch = -( ( int )( Rect.Pitch + Desc.Width * 2 ) );
				nDPitch = nPitch - Desc.Width * 2;
				Rect.pBits = ( ( BYTE * )Rect.pBits ) + ( Desc.Height - 1 ) * Rect.Pitch;
				pbtTmp += sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER );
				_asm{
					mov ecx, nPitch;
					mov esi, Rect.pBits;
					shr ecx, 2;
					mov edi, pbtTmp;
					mov ebx, ecx;
					mov edx, Desc.Height;
					cld;
P16_1:				rep movsd;
					add esi, nSPitch;
					add edi, nDPitch;
					dec edx;
					mov ecx, ebx;
					jnz P16_1;
				}
				pbtTmp -= sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER );
			}
			break;
	}

	pSurface->UnlockRect();


		DWORD dwSaveStart = GetTickCount();
		
		FILE				* fp;
		BITMAPFILEHEADER	& bithead = ( BITMAPFILEHEADER & )*pbtTmp;
		BITMAPINFOHEADER	& bitinfo = ( BITMAPINFOHEADER & )( pbtTmp[ sizeof( BITMAPFILEHEADER )] );
		int					headsize;

		fopen_s( &fp, strName, "wb" );
		if( fp == NULL )
		{
			return false;
		}
		headsize = sizeof( bithead ) + sizeof( bitinfo );
		bithead.bfType = 'MB';
		bithead.bfSize = headsize + nPitch * Desc.Height;
		bithead.bfReserved1 = bithead.bfReserved2 = 0;
		bithead.bfOffBits = headsize;
		bitinfo.biSize = sizeof( bitinfo );
		bitinfo.biWidth = Desc.Width;
		bitinfo.biHeight = Desc.Height;
		bitinfo.biPlanes = 1;
		bitinfo.biBitCount = 24;
		bitinfo.biCompression = BI_RGB;
		bitinfo.biSizeImage = 0;
		bitinfo.biXPelsPerMeter = 72;
		bitinfo.biYPelsPerMeter = 72;
		bitinfo.biClrUsed = 0;
		bitinfo.biClrImportant = 0;

		fwrite( pbtTmp, 1, nPitch * Desc.Height + 
			sizeof( BITMAPFILEHEADER ) + sizeof( BITMAPINFOHEADER ), fp );
		fclose( fp );

		delete []pbtTmp;
	return true;
}

void	LERender::CaptureScreen(char*	strFilename)
{
	D3DSURFACE_DESC		sDesc;
	LPDIRECT3DSURFACE8	pBackBuffer;
    _pD3DDevice->GetBackBuffer( 0, D3DBACKBUFFER_TYPE_MONO, &pBackBuffer );
    pBackBuffer->GetDesc( &sDesc );
	
	//DWORD dd = GetTickCount();
	
	POINT p; p.x = 0; p.y = 0;

	LPDIRECT3DSURFACE8 pCapSurface;
	_pD3DDevice->CreateImageSurface(sDesc.Width,sDesc.Height,sDesc.Format,&pCapSurface);

	_pD3DDevice->CopyRects(pBackBuffer, NULL, 0, pCapSurface, &p);

	SurfaceToBLE( pCapSurface,strFilename, 0);

    pBackBuffer->Release();
	pCapSurface->Release();

}

void LERender::IgnoreModelTexture(BOOL bIgnore)
{
     drHelperSetForceIgnoreTexFlag(bIgnore);
}
