#include "LightEngineAPI.h"
#include "Stdafx.h"
#include "LEGameApp.h"
#include "d3dutil.h"
#include "dxutil.h"
#include "LECamera.h"
#include "LETextureSet.h"
#include "LETerrainSet.h"
#include "LEConsole.h"

#include "drGuidObj.h"
#include "drInterface.h"
#include "drIFunc.h"
#include "LECharacter.h"
#include <CPerformance.h>

#include "LEResourceSet.h"
#ifdef __VIM3D__
#include "Vim_helper.h"
#endif
#include <MyMemory.h>


DR_USING

LETexSet*		LETexSet::_Instance		= NULL;
LETerrainSet*	LETerrainSet::_Instance = NULL;
LEResourceSet*  LEResourceSet::m_pInstance = NULL;

LEGameApp::LEGameApp()
:_dwRenderUseTime(0),
 _dwFrameMoveUseTime(0),
 _bCheckInputWnd(TRUE)
{
	_pDI			 = NULL;
	_pDIKeyboard	 = NULL;
	_pDIMouse		 = NULL;

	_pConsole = new LEConsole;
	//_pMainCam = new LECamera;

	_nMousePosX      = 0;
	_nMousePosY      = 0;

	memset(_btButtonState, 0, 3);
	memset(_btLastButtonState, 0, 3);

	memset ( mASCKeysState, KEY_FREE, sizeof ( mASCKeysState ) );
	memset ( mKeyState, KEY_FREE, sizeof ( mKeyState ) );


	_bLastDBClick = false;
	_bCanDB = false;
	_nDBTime = 0;

	_bEnSpScreen = FALSE;
	_bEnSpAvi	 = FALSE;
	_bEnSpSmMap  = FALSE;
    _bFullScreen = FALSE;

	_bActive= false;
}

LEGameApp::~LEGameApp()
{
}


BOOL LEGameApp::Init(HINSTANCE hInst,const char *pszClassName, int nScrWidth, int nScrHeight, int nColorBit, BOOL bFullScreen)
{
	_hInst			= hInst;

	DWORD dwWindowStyle = WS_CAPTION|WS_SYSMENU|WS_MINIMIZEBOX; 
	
    if(bFullScreen==2 ||bFullScreen==1) // 伪全屏
    {
        dwWindowStyle = WS_VISIBLE|WS_POPUP|WS_CLIPCHILDREN;
    }

    RECT rc; SetRect( &rc, 0, 0, nScrWidth, nScrHeight);
	AdjustWindowRect( &rc, dwWindowStyle, FALSE );
    
    int nFrameSize   = GetSystemMetrics(SM_CYSIZEFRAME);
	int nCaptionSize = GetSystemMetrics(SM_CXSIZE);

    int nWindowWidth = rc.right - rc.left;
    int nWindowHeight = rc.bottom - rc.top; // nScrHeight + nFrameSize + nCaptionSize;
	_hWnd = CreateWindow(pszClassName, "LightEngine Application", dwWindowStyle, 
	CW_USEDEFAULT, CW_USEDEFAULT, nWindowWidth, nWindowHeight, NULL, NULL, hInst, NULL);

	if(!_hWnd)
	{
		return FALSE;
	}

    GetClientRect(_hWnd, &rc);
    _nWindowWidth  = rc.right  - rc.left;
    _nWindowHeight = rc.bottom - rc.top;
    _bFullScreen   = bFullScreen;
    
    CLogMgr::Instance()->SetMessageWnd(_hWnd);

	int dev_width;
    int dev_height;

    if(bFullScreen)
    {
        dev_width = nScrWidth;
        dev_height = nScrHeight;
    }
    else
    {
        dev_width = _nWindowWidth;
        dev_height = _nWindowHeight;
    }

   	if(!g_Render.Init(_hWnd, dev_width, dev_height, nColorBit, bFullScreen))
    {
        return FALSE;
    }

	LETexSet *pTextureSet = new LETexSet(0, 2048);
	
	_nLogoTexID = GetTextureID("texture/logo.BLE");

    pTextureSet->EnableRequest(FALSE);

	_InitInput();

	//FontModule::FontSystem::getSingleton().init();

    if( _Init() == 0 ) 
        return 0;

	ShowWindow(_hWnd, SW_SHOW);
	UpdateWindow(_hWnd);

    return 1;
}

BOOL LEGameApp::LoadResource()
{
	if (!g_Render.InitResource())
	{
		return FALSE;
	}
	return TRUE;
}

BOOL LEGameApp::LoadRes2()
{
	if (!g_Render.InitRes2())
	{
		return FALSE;
	}

	return TRUE;
}

BOOL LEGameApp::LoadRes3()
{
	if (!g_Render.InitRes3())
	{
		return FALSE;
	}
	return TRUE;
}

static DWORD _time;
void LEGameApp::FrameMove(DWORD dwTimeParam)
{
#ifdef __FPS_DEBUG__
    LETimer tUseTime; tUseTime.Begin();
#endif
    _ReadKeyboardInput();
	
	g_Render.UpdateCullInfo() ; 
	
	if(_pConsole->IsVisible())
	{
		g_Render.EnablePrint(INFO_CMD, TRUE);
		_pConsole->FrameMove();
		UpdateConsoleText(FALSE);
	}
	else
	{
		g_Render.EnablePrint(INFO_CMD, FALSE);
	}

     drISceneMgr* sm = g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr();
     sm->Update();

    _FrameMove(_time = dwTimeParam);
#ifdef __FPS_DEBUG__
    _dwFrameMoveUseTime = tUseTime.End();
#endif
}

#ifdef __VIM3D__
using namespace Vision3D;
#endif

void LEGameApp::Render()
{
#ifdef __FPS_DEBUG__
	LETimer tRenderUse;
	tRenderUse.Begin();
#endif

	drISceneMgr* sm = g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr();
     
      // g_Render.LookAt(_pMainCam->m_EyePos, _pMainCam->m_RefPos);

	//  g_Render.SetCurrentView(LERender::VIEW_WORLD);
#ifdef __VIM3D__
	if( g_vimHelper.Is3D())
	{
	
		LPDIRECT3DDEVICE8 g_pd3dDevice = g_Render.GetDevice();

		LPDIRECT3DSURFACE8 pOrigRenderTarget = 0;									// ViM
		LPDIRECT3DSURFACE8 pDepthStencilTarget = 0;									// ViM
		if (FAILED( g_pd3dDevice->GetRenderTarget(&pOrigRenderTarget)))				// ViM
		return;																	// ViM

		if (FAILED( g_pd3dDevice->GetDepthStencilSurface(&pDepthStencilTarget)))	// ViM
		return;																	// ViM

		for (DWORD view=0;view<g_dwNumViews;view++)				// ViM
		{														// ViM
			g_vimHelper.SetViewIndex(view);
			
			_FrameMove(_time,true);								// VIM


			if (FAILED(g_pd3dDevice->SetRenderTarget(g_pRenderTargets[view],pDepthStencilTarget)))	// ViM
			return;							// ViM

			if(!g_Render.BeginRender(true)) return;
		
		
			// _RenderAxis();
	 
			sm->BeginRender();
			sm->Render();

			_Render(); // 子类应用程序调用
			
			sm->EndRender();

			g_Render.EndRender(false);

		}	// ViM

		if (FAILED( g_pd3dDevice->SetRenderTarget(pOrigRenderTarget,pDepthStencilTarget)))		// ViM
		return;																				// ViM
		pOrigRenderTarget->Release();															// ViM
		pDepthStencilTarget->Release();															// ViM

		g_Render.BeginRender(false);

		if (FAILED( ViMD3D_RasterTextures(g_vimd3d,												// ViM
					0,0,g_descWidth,g_descHeight, 
			g_dwNumViews, g_pRenderTextures)))													// ViM
		return;																				// ViM

	}
	else
#endif
	{
		///////////////////////////////////////////////////////////

		if(!g_Render.BeginRender(true)) return;
	
			// _RenderAxis();
 
		sm->BeginRender();
		sm->Render();

		_Render(); // 子类应用程序调用
		
		sm->EndRender();

		///////////////////////////////////////////////////////////
	}

	//g_Render.EnableZBuffer(FALSE);
	//
 //   g_Render.SetCurrentView(LERender::VIEW_WORLD);

#ifdef __FPS_DEBUG__
    g_Render.RenderDebugInfo(); //INFO_FPS
#endif

    if(_pConsole->IsVisible())
	{
		LETexInfo *pTexInfo = GetTextureInfo(_nLogoTexID);
		if(pTexInfo)
		{
			LETexRect TexRect;
			TexRect.nTexW      = 128;
			TexRect.nTexH      = 64;
			TexRect.fScaleX    = (float)g_Render.GetScrWidth() / 128.0f / 1.76f;
			TexRect.fScaleY    = 2.4f;
			TexRect.dwColor    = 0x2FFFFFFF;
			TexRect.nTextureNo = _nLogoTexID;
			g_Render.RenderTextureRect(0, 0, &TexRect);
		}
	}

	// Draw font
	// FontModule::FontSystem::getSingleton().update(0.01f);

	g_Render.EndRender(true);
#ifdef __FPS_DEBUG__
    _dwRenderUseTime = tRenderUse.End();
#endif
}

void LEGameApp::UpdateConsoleText(BOOL bClear)
{
	list<string> *pTextList = _pConsole->GetTextList(); 
    int y = 4; // g_Render.GetScrHeight() - _pConsole->GetHeight() - 40;
    for(list<string>::iterator it = pTextList->begin(); it!=pTextList->end(); it++,y+=16)
    {
        string &str = (*it);
        if(str.size() > 0 || bClear)
        {
            g_Render.Print(INFO_CMD, 2, y, "%s", str.c_str());
        }
    }
	g_Render.Print(INFO_CMD, 4, _pConsole->GetHeight() - 10, "%s", _pConsole->GetInputText());
}

void LEGameApp::_RenderUI()
{
	
}

void LEGameApp::_RenderAxis()
{
	struct AXIS_VERTEX
	{
		D3DVECTOR pos;
		DWORD diffuse;
	};

	D3DXMATRIX mat;
	D3DXMatrixIdentity(&mat);

#if(defined USE_MANAGED_RES)
    g_Render.SetTransformWorld(&mat);
#else
	g_Render.GetDevice()->SetTransform( D3DTS_WORLD , &mat);
#endif


	AXIS_VERTEX pVertices[6];

	// z 
	pVertices[0].pos = D3DXVECTOR3(0.0f , 0.0f , 0.0f);
	pVertices[1].pos = D3DXVECTOR3(0.0f , 0.0f , 50.0f);
	pVertices[0].diffuse = 0xffffffff;
	pVertices[1].diffuse = 0xffffffff;

	// x 
	pVertices[2].pos = D3DXVECTOR3(0.0f ,   0.0f , 0.0f);
	pVertices[3].pos = D3DXVECTOR3(100.0f , 0.0f , 0.0f);
	pVertices[2].diffuse = 0xffff0000;
	pVertices[3].diffuse = 0xffff0000;

	// y 
	pVertices[4].pos = D3DXVECTOR3(0.0f , 0.0f ,   0.0f);
	pVertices[5].pos = D3DXVECTOR3(0.0f , 100.0f , 0.0f);
	pVertices[4].diffuse = 0xFF00ffff;
	pVertices[5].diffuse = 0xFF00ffff;
	
	g_Render.SetRenderState( D3DRS_LIGHTING , FALSE );
	g_Render.SetTexture(0, 0);
	g_Render.SetVertexShader(D3DFVF_XYZ|D3DFVF_DIFFUSE);
	g_Render.GetDevice()->DrawPrimitiveUP(D3DPT_LINELIST, 3, &pVertices , sizeof(AXIS_VERTEX));
	// _pD3DDevice->SetRenderState( D3DRS_LIGHTING, TRUE );
}

BOOL LEGameApp::_InitInput()
{
	if ( FAILED(DirectInput8Create(_hInst,	DIRECTINPUT_VERSION,
										    IID_IDirectInput8,
										    (VOID**)&_pDI,
										    NULL)))
	{
		LG("init", "Create DirectInput 8 Error!\n");
		return FALSE;
	}

	 _KeyboardLayout = GetKeyboardLayout(0);	

	if(FAILED(_pDI->CreateDevice(GUID_SysKeyboard, &_pDIKeyboard, NULL)))
	{
		if(_pDI) SAFE_RELEASE(_pDI);
		LG("init", "Create Keyboard Device Error\n");
		return FALSE;
	}

	DIPROPDWORD		dipdw; 
	
	// Create buffer to hold keyboard data
	ZeroMemory(&dipdw,sizeof(DIPROPDWORD));
	dipdw.diph.dwSize		= sizeof(DIPROPDWORD); 
	dipdw.diph.dwHeaderSize = sizeof(DIPROPHEADER); 
	dipdw.diph.dwObj		= 0; 
	dipdw.diph.dwHow		= DIPH_DEVICE; 
	dipdw.dwData			= KEYBOARD_BUFFERSIZE;	// Buffer Size
	
	HRESULT hr;
	// Set the format of the keyboard
	if (FAILED(hr = _pDIKeyboard->SetDataFormat(&c_dfDIKeyboard)))
		return FALSE; //DisplayErrorMsg(hr, MSGERR_APPMUSTEXIT);

	// Set the co-operative level to exclusive access
	if (FAILED(hr = _pDIKeyboard->SetCooperativeLevel(_hWnd, DISCL_NONEXCLUSIVE|DISCL_FOREGROUND)))
		return FALSE; //DisplayErrorMsg(hr, MSGERR_APPMUSTEXIT);

	// Set the size of the buffer
	if (FAILED(hr = _pDIKeyboard->SetProperty( DIPROP_BUFFERSIZE, &dipdw.diph))) 
		return FALSE; // DisplayErrorMsg(hr, MSGERR_APPMUSTEXIT);
	
	
	
	// Acquire the keyboard device
	_pDIKeyboard->Acquire();

    if ( FAILED( hr = _pDI->CreateDevice( GUID_SysMouse, &_pDIMouse, NULL ) ) )return FALSE;

    if ( FAILED( hr = _pDIMouse->SetDataFormat( &c_dfDIMouse2 ) ) ) return FALSE;

    _pDIMouse->SetCooperativeLevel( _hWnd, DISCL_NONEXCLUSIVE|DISCL_BACKGROUND );

    _pDIMouse->Acquire();

	_nDBClickTime = ::GetDoubleClickTime();
	_nLastClickTime = timeGetTime();

	return TRUE;
}

void	LEGameApp::SetInputActive(bool bActive)
{
	memset ( mASCKeysState, KEY_FREE, sizeof ( mASCKeysState ) );
	memset ( mKeyState, KEY_FREE, sizeof ( mKeyState ) );

	if(!bActive)
	{
		_pDIKeyboard->Unacquire();
		_pDIMouse->Unacquire();
	}else
	{
		_pDIKeyboard->Acquire();
		_pDIMouse->Acquire();
	}
	_bActive = bActive;
}
BOOL LEGameApp::LoadTerrainSet(const char* file, BOOL bBinary)
{
	LETerrainSet *pTerrainSet = new LETerrainSet(0, 100);
	//pTerrainSet->LoadRawDataInfo("scripts/table/TerrainInfo", FALSE);
    return pTerrainSet->LoadRawDataInfo(file, bBinary);
}
BOOL LEGameApp::UnloadTerrainSet()
{
    LETerrainSet *pTerrainSet = LETerrainSet::I();
    //SAFE_DELETE(pTerrainSet);
    return TRUE;
}
//-----------------------------------------------------------------------------
BOOL LEGameApp::LoadResourceSet(const char* file, int iMaxIndex, BOOL bBinary)
{
//为了安全释放内存，这个资源载入改到DLL中（也许某些情况不希望这样，到时候仍需要调整） 
//#if RESOURCE_SCRIPT == 2 || RESOURCE_SCRIPT == 3
	LEResourceSet *pResourceSet = new LEResourceSet(0, iMaxIndex);
	return pResourceSet->LoadRawDataInfo(file, bBinary);
//#endif
	return TRUE;
}
//-----------------------------------------------------------------------------
BOOL LEGameApp::UnloadResourceSet()
{
    //安全释放内存 
	LEResourceSet* pResourceSet = LEResourceSet::GetInstancePtr();
	if( pResourceSet )
	{
		pResourceSet->Release();
		delete pResourceSet;
		LEResourceSet::m_pInstance = NULL;
	}
	return TRUE;
}
//-----------------------------------------------------------------------------

void LEGameApp::_ReadKeyboardInput()
{
	// set the single key strokes to 0 each time, so it just records changes between frames
	ZeroMemory(_btButtonState, sizeof(_btButtonState));			// 0 is no action
	_dwMouseKey = 0;

	if(!_bActive)
		return;

	if(!_CanInput())
		return;

	// Don't read the keyboard if the devices are invalid
	if (!_pDIKeyboard || !_pDI)
	{
		LG("error", "Keyboard interface is NULL!\n");
		return;
	}

	HRESULT hr = S_OK;

//getdata:

	// GetDeviceData version
	static DIDEVICEOBJECTDATA keyDataBuffer[ KEYBOARD_BUFFERSIZE ];
	DWORD dwItems = KEYBOARD_BUFFERSIZE;

	// Read the buffered data
	hr = _pDIKeyboard->GetDeviceData (
		sizeof ( DIDEVICEOBJECTDATA ), keyDataBuffer, &dwItems, 0 );
	if ( FAILED ( hr ) )
	{
		// Keyboard may have been lost, reacquire it
		_pDIKeyboard->Acquire();
		return;
	}
	
	// Proces the data if there is any
	if ( dwItems )
	{
		// Process the buffered data
		for ( DWORD i = 0; i < dwItems; ++i )
		{
			// Map scan-code to ASCII code
			UINT codeScan = keyDataBuffer[ i ].dwOfs;
			UINT codeASCII = MapVirtualKeyEx( codeScan, 1, _KeyboardLayout );

			if ( keyDataBuffer[ i ].dwData & 0x80 )
			{
				// The key was pressed
				switch ( mKeyState[ codeScan ] )
				{
				case KEY_POP :
				case KEY_FREE :
					mKeyState[ codeScan ] = mASCKeysState[ codeASCII ] = KEY_PUSH;
					HandleKeyDown ( codeScan );
					break;
				}
			}
			else
			{
				// The key was released
				switch ( mKeyState[ codeScan ] )
				{
				case KEY_HOLD :
				case KEY_PUSH :
					mKeyState[ codeScan ] = mASCKeysState[ codeASCII ] = KEY_POP;
					break;
				}
			}
		}
	}
	else
	{
		// There isn't any buffered data, so keys state were not changed.
		for ( DWORD i = 0; i < 256; ++i )
		{
			switch ( mKeyState[ i ] )
			{
			case KEY_PUSH :
				mKeyState[ i ] = mASCKeysState[ i ] = KEY_HOLD;
				break;
			case KEY_POP :
				mKeyState[ i ] = mASCKeysState[ i ] = KEY_FREE;
				break;
			}
		}
	}

/*
	// GetDeviceState version
	memcpy ( _lastKeyState, _curKeyState, sizeof ( _lastKeyState ) );

	// Get the immediate state of the keyboard
	hr = _pDIKeyboard->GetDeviceState ( sizeof ( _curKeyState ), _curKeyState );
	if ( FAILED ( hr ) )
	{
		// Keyboard may have been lost, reacquire it
		_pDIKeyboard->Acquire();
		return;
	}

	for ( size_t i = 0; i < 256; ++i )
	{
		if ( _curKeyState[ i ] & 0x80 && _lastKeyState[ i ] & 0x80 )
		{
			// The key has been hold yet.
			mKeyState[ i ] = keyHold;
			continue;
		} else if ( _curKeyState[ i ] & 0x80 ) {
			// The key was just pressed.
			mKeyState[ i ] = keyDown;
			continue;
		} else if ( _lastKeyState[ i ] & 0x80 ) {
			// The key was just released.
			mKeyState[ i ] = keyUp;
			continue;
		} else {
			// The key has been released yet.
			mKeyState[ i ] = keyReleased;
		}
	}
*/

	DIMOUSESTATE2 dims2;      
    
    // Get the input's device state, and put the state in dims
    ZeroMemory( &dims2, sizeof(dims2) );
     hr = _pDIMouse->GetDeviceState( sizeof(DIMOUSESTATE2), &dims2 );
    if( FAILED(hr) )
	{
        _pDIMouse->Acquire();
		return;
    }
    
	int nOffsetX = dims2.lX;
	int nOffsetY = dims2.lY;	
	int nScroll  = dims2.lZ; // 中键滚动

	_btButtonState[0] = dims2.rgbButtons[0] & 0x80;
	_btButtonState[1] = dims2.rgbButtons[1] & 0x80;
	_btButtonState[2] = dims2.rgbButtons[2] & 0x80;

	if(nOffsetX || nOffsetY) // 鼠标有移动 
	{
		//MouseMove(nOffsetX, nOffsetY);
		_bCanDB = false;

		_dwMouseKey |= M_Move;
	}

	if(nScroll) 
	{
		MouseScroll(nScroll);
	}
	UINT	time = timeGetTime();

	for(int i = 0; i < 3; i++)
	{
		if(_btButtonState[i] && !_btLastButtonState[i]) 
		{
				//MouseButtonDown(i);
				_dwMouseKey |= M_Down;
				if(i == 0)
					_dwMouseKey |= M_LDown;
				else if(i == 1)
					_dwMouseKey |= M_RDown;
				else
					_dwMouseKey |= M_MDown;


				if((time - _nLastClickTime <_nDBClickTime))
				{
					if(!nOffsetX && !nOffsetY && _bCanDB)
					{
						if(_bLastDBClick)
						{
							if(time - _nDBTime > _nDBClickTime)
								_bLastDBClick =false;
						}
						if(!_bLastDBClick)
						{
							//MouseButtonDB(i);
							_bLastDBClick = true;
							_nDBTime = time;

							if(i == 0)
								_dwMouseKey |= M_LDB;
							else if(i == 1)
								_dwMouseKey |= M_RDB;
							else
								_dwMouseKey |= M_MDB;

						}
					}
				}else
				{
					_bLastDBClick = false;
				}
				_nLastClickTime = time;
				_bCanDB = true;
		}
	
		if(!_btButtonState[i] && _btLastButtonState[i]) 
		{
			//MouseButtonUp(i);
			if(i == 0)
				_dwMouseKey |= M_LUp;
			else if(i == 1)
				_dwMouseKey |= M_RUp;
			else
				_dwMouseKey |= M_MUp;

		}
		if(_btButtonState[i] && _btLastButtonState[i]) 
		{
			MouseContinue(i);
		}

		_btLastButtonState[i] = _btButtonState[i];
	}

	_PreMouseRun( _dwMouseKey );

	if(_dwMouseKey & M_Move)
	{
		MouseMove(nOffsetX, nOffsetY);
	}

	if(_dwMouseKey & M_Down)
	{
		if(_dwMouseKey & M_LDown)
			MouseButtonDown(0);
		if(_dwMouseKey & M_RDown)
			MouseButtonDown(1);
		if(_dwMouseKey & M_MDown)
			MouseButtonDown(2);
	}

	if(_dwMouseKey & M_LDB)
		MouseButtonDB(0);
	if(_dwMouseKey & M_RDB)
		MouseButtonDB(1);
	if(_dwMouseKey & M_MDB)
		MouseButtonDB(2);

	if(_dwMouseKey & M_LUp)
		MouseButtonUp(0);
	if(_dwMouseKey & M_RUp)
		MouseButtonUp(1);
	if(_dwMouseKey & M_MUp)
		MouseButtonUp(2);
}

void LEGameApp::SetCaption(const char *pszCaption)
{
	if(_hWnd==0) return;
	SetWindowText(_hWnd, pszCaption);
}

bool LEGameApp::_CanInput()
{
	//修复当： 激活游戏窗口－点击其它窗口，再点下方任务条时，可能导致游戏中的角色乱走 
	//return true;
	//if(::GetFocus() != _hWnd)
    if(::GetForegroundWindow() != _hWnd)
		return false;

	if( GetCapture()==_hWnd )
		return true;

	POINT  p;
	RECT   rc;
	::GetCursorPos(&p);
	::GetWindowRect(_hWnd,&rc);
	if(!PtInRect(&rc,p))
	{
		return false;
	}
	return true;
}

void LEGameApp::End()
{
    _End();
  
    SAFE_DELETE(_pConsole);
	

	SAFE_RELEASE(_pDIKeyboard);
	SAFE_RELEASE(_pDIMouse);

	SAFE_RELEASE(_pDI);

    g_Render.End();

// 	LG("end", "exit game appliaction successful!\n");
}

void LEGameApp::LG_Config(const LGInfo& info)
{
    if(info.bCloseAll)
    {
        ::LG_CloseAll();
    }
    ::LG_SetEraseMode(info.bEraseMode);
    ::LG_SetDir(info.dir);
    ::LG_EnableAll(info.bEnableAll);
    ::LG_EnableMsgBox(info.bMsgBox);

    _lgInfo = info;
}
