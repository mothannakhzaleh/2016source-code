#pragma once

#include "LightEngineAPI.h"
#include "LEModelEff.h"
#include "LEfont.h"
#include "LEInterface.h"

#include <vector>
using namespace std;
#include "drIFunc.h"

#define USE_MANAGED_RES

#define MAX_INFO_TYPE 5

#define LPTEXTURE			LPDIRECT3DTEXTURE8
#define LPDEVICE 			LPDIRECT3DDEVICE8
#define VECTOR3				D3DXVECTOR3
#define VECTOR2				D3DXVECTOR2
#define LPSPRITE			LPD3DXSPRITE
#define RENDER_STATE		D3DRENDERSTATETYPE
#define TEXTURE_STAGE_STATE D3DTEXTURESTAGESTATETYPE

enum INFO_TYPE
{
// 输入信息类型定义
	 INFO_DEBUG  = 0,  // 调试专用
	 INFO_PERF      ,  // 显示Performance专用
	 INFO_CMD       ,  // 显示Console文字专用
	 INFO_FPS       ,  // FPS专用
	 INFO_GAME         // 游戏专用
};


struct LELine
{
	VECTOR3		v1;
	VECTOR3		v2;
	DWORD		dwColor;
};

struct LECullInfo              
{
    D3DXVECTOR3 vecFrustum[8];    // 平截头的8个顶点
    D3DXPLANE planeFrustum[6];    // 平截头的6个面
};  

//class  CLEFont;
//class CD3DFont;
struct LETexRect;

class CTextureManager;
class LIGHTENGINE_API LERender
{

public:
    
	// Initialize Routines
    LERender();
	~LERender();
    
    BOOL                Init(HWND hWnd, int nScrWidth, int nScrHeight, int nColorBit, BOOL bFullScreen);
    void                End();
	BOOL				InitResource();
	BOOL				InitRes2();
	BOOL				InitRes3();

    // Render Routines
    BOOL				BeginRender(bool clear=true);
    void				EndRender(bool present=true);
	void				RenderDebugInfo();
    void				SetBackgroundColor(DWORD dwColor);
    void				EnableClearTarget(BOOL bEnable = TRUE)      { _bClearTarget  = bEnable; } 
    void				EnableClearZBuffer(BOOL bEnable = TRUE)     { _bClearZBuffer = bEnable; }
    void				EnableClearStencil(BOOL bEnable = TRUE)     { _bClearStencil = bEnable; }
	LPDEVICE			GetDevice()                                 { return _pD3DDevice;	    }
	IDirect3DX*			GetD3DObj()									{ return _pD3D;				}
	void				SetTexture(int nStage, IDirect3DTextureX* pTexture);
	void				EnableAlpha(BOOL bEnable);
	void				EnableZBuffer(BOOL bEnable);
	void				SetRenderState(RENDER_STATE renState, int nValue);
	void				GetRenderState(RENDER_STATE renState, DWORD* nValue);

	void				SetTextureStageState(int nStage,TEXTURE_STAGE_STATE, int nValue);
	LPSPRITE			Get2DDevice()								{ return _p2DSprite;		}
	void				ResetWorldTransform();
    void                RenderAllLines();

    void                SetTextureForced(DWORD stage, IDirect3DTextureX* tex);
	void				SetRenderStateForced(RENDER_STATE renState, int nValue);
	void				SetTextureStageStateForced(int nStage,TEXTURE_STAGE_STATE, int nValue);
    void                SetLight(DWORD id, D3DLIGHTX* light);
    void                GetLight(DWORD id, D3DLIGHTX* light);
    void                LightEnable(DWORD id, DWORD flag);
    void                GetLightEnable(DWORD id, BOOL* flag);

    DWORD               GetRegisteredDevMemSize();
    void                SetD3DCreateParamAdjustInfo(MPD3DCreateParamAdjustInfo* info);

	void				SetCurFrameTick(DWORD dwTick);
    
	// View Routines
	void		reset_Camera_Project_VIEW_WORLD(  D3DXMATRIX* mat, const float fov_y, const float aspect, const float zn, const float zf );
	void		reset_Camera_Project_VIEW_UI(  D3DXMATRIX* mat, const float fov_y, const float aspect, const float zn, const float zf );



    void        SetCurrentView(int nType, BOOL bReset = FALSE);
	void        SetViewport(int nX, int nY, int nW, int nH);
    void        LookAt(VECTOR3 vecPos, VECTOR3 vecLookAt,DWORD dwViewType = VIEW_WORLD);
    void        SetWorldViewFOV(float fFov);
	float       GetWorldViewFOV()           { return _fWorldViewFOV;	 }
 
	float       GetWorldViewAspect()             { return _fAspect;	 }
	void        SetWorldViewAspect(float Aspect = 0) 
	{ 
		if(Aspect == 0) 
			_fAspect = ( (float)_view.Width) / ( (float)_view.Height );
		else
			_fAspect = Aspect;
	}



    int         GetScrWidth()               { return _nScrWidth;         }
    int         GetScrHeight()              { return _nScrHeight;        }
    
    void        SetWorldView(int nX, int nY, int nW = 0, int nH = 0);
    int         GetWorldViewX()             { return  _nWorldViewStartX; }
    int         GetWorldViewY()             { return  _nWorldViewStartY; }
    int         GetWorldViewWidth()         { return  _nWorldViewWidth;  }
    int         GetWorldViewHeight()        { return  _nWorldViewHeight; }
    D3DXMATRIX& GetWorldProjMatrix()        { return  _matProjWorld;     }
    D3DXMATRIX& GetWorldViewMatrix()        { return  _matViewWorld;     }
	D3DXMATRIX&	GetViewProjMatrix()			{ return  _matViewProj;		 }
	D3DXMATRIX& GetUIViewMatrix()			{ return  _matUIView;		 }
    D3DXMATRIX& GetUIProjMatrix()			{ return  _matUIProj;		 }
    void		SetClip(float fNearClip, float fFarClip);
	void		SetDirectLightDir(float x, float y, float z);
	void		SetDirectLightColor(float r, float g, float b, float a);
    void        SetDirectLIghtAmbient(float r, float g, float b, float a);

	// View Range & Ray Trace
    void		GetScreenPos(int &nOutX, int &nOutY, VECTOR3 &vWorldPos);
	void		GetRay(int nScrPosX, int nScrPosY, VECTOR3 &vRayStart, VECTOR3 &vRayEnd);
    void        GetPickRayVector(int nScrPosX, int nScrPosY, VECTOR3* pPickRayOrig, VECTOR3* pPickRayDir);
    BOOL        WorldToScreen(float fX, float fY, float fZ, int *pnX = NULL, int *pnY = NULL);
    BOOL        IsLineInWorldView(float fX1, float fY1, float fX2, float fY2);
    BOOL        IsRectIntersectWorldView(int *pnPosX, int *pnPosY);
    bool        IsInWorldView(int nPosX, int nPosY);
    bool        IsInWorldViewCorner(int nCorner, int nPosX, int nPosY, int nRange);
	///D3DXMATRIX  GetWorldViewMatrix() { return _matViewWorld;	}

    void SetTransformView(const D3DXMATRIX* mat);
    void SetTransformProj(const D3DXMATRIX* mat);
    void SetTransformWorld(const D3DXMATRIX* mat);
#if ( defined DR_USE_DX9 )
    void SetFVF( DWORD fvf );
    void SetVertexShader( IDirect3DVertexShaderX* shader );
    void SetVertexDeclaration( IDirect3DVertexDeclarationX* decl );
    void SetVertexShaderConstantF( UINT reg_id, const float* data, UINT v_num );
#elif ( defined DR_USE_DX8 )
    void SetVertexShader( IDirect3DVertexShaderX shader );
    void SetVertexShaderConstant( UINT reg_id, const void* data, UINT v_num );
#endif

    HRESULT SetStreamSource(UINT stream_num, IDirect3DVertexBufferX* stream_data, UINT offset_byte, UINT stride);
    HRESULT SetIndices(IDirect3DIndexBufferX* index_data, UINT base_vert_index);
    HRESULT DrawPrimitive( D3DPRIMITIVETYPE pt_type, UINT start_vertex, UINT count );
    HRESULT DrawIndexedPrimitive( D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT vert_num, UINT start_index, UINT count );

    // Text Info Print
    void        Print(int nInfoType, int x, int y, const char *szFormat, ...);
	void		EnablePrint(int nInfoType, BOOL bEnable);
	void		ClearPrint(int nInfoType);
    void        IgnoreModelTexture(BOOL bIgnore);

    // FPS
	BOOL        IsRealFPS()                 { return _bRealFPS;         }
    DWORD       GetFPS()                    { return _dwFPS;            }

    // Render States
    void        EnableMipmap(BOOL bEnable);

	// Render Basic Geometry
    void        RenderLine(float x1, float y1, float z1, float x2, float y2, float z2, DWORD dwColor = 0xffffffff);
	void		RenderLine(VECTOR3& v0, VECTOR3& v1, DWORD dwColor = 0xffffffff);
	void		RenderTextureRect(int nX, int nY, LETexRect *pRect);
	
	// Render Basic Geometry
    // void        RenderLine(float x1, float y1, float z1, float x2, float y2, float z2, DWORD dwColor = 0xffffffff);
	// void		RenderLine(D3DXVECTOR3& v0, D3DXVECTOR3& v1, DWORD dwColor = 0xffffffff);
	//not change matrix
    //void        RenderLine2(float x1, float y1, float z1, float x2, float y2, float z2, DWORD dwColor = 0xffffffff);
	//void		RenderLine2(D3DXVECTOR3& v0, D3DXVECTOR3& v1, DWORD dwColor = 0xffffffff);
	//void		RenderWireFrameBox(D3DXVECTOR3& vCenter, D3DXVECTOR3& vRadius, DWORD dwColor = 0xffffffff,BOOL UseStack_ = FALSE);
	//void		RenderWireFrameBox(D3DXVECTOR3* v, DWORD dwColor = 0xffffffff);
    
	BOOL		IsFullScreen()		            { return _bFullScreen;          }
	void        EnableCaptureAVI(BOOL bEnable)  { _bEnableCaptureAVI = bEnable; }
    BOOL        IsEnableCaptureAVI()            { return _bEnableCaptureAVI;    }
    void        CaptureScreen()                 { _bCaptureScreen = TRUE;       }  
    void	    CaptureScreen(char* szFilename);

    int ToggleFullScreen();
    int ToggleFullScreen(D3DPRESENT_PARAMETERS* d3dpp, drWndInfo* wnd_info);
    int ToggleFullScreen( int width, int height, D3DFORMAT depth_fmt, bool be_windowed);
    int InitLETextureSetFormat();
    D3DFORMAT GetTexSetFormat(DWORD type) { return _TexSetFmt[type]; }

    void GetInvViewMatrix( D3DXMATRIX* mat )
    {
        GetDevice()->GetTransform( D3DTS_VIEW, mat );
        D3DXMatrixInverse( mat, NULL, mat );
    }
	CLEFont*		GetDeviceFont()		{ return _pFont;}
    void            UpdateLight();
public:    
    
    enum VIEW_TYPE
	{
		VIEW_SCREEN = 0, // 以整个屏幕做为View
		VIEW_WORLD     , // 以WorldView的区域作为View
		VIEW_UI ,         // 界面通常需要的平面渲染View
        VIEW_3DUI ,      // 3D界面
	};

	void	AddLine(VECTOR3& v1, VECTOR3& v2, DWORD dwColor = 0xFFFFFFFF);
    drInterfaceMgr* GetInterfaceMgr() { return &_IMgr; }

	void	InitRender(IDirect3DX* pd3d,LPDIRECT3DDEVICE8	pDev)
	{
		_pD3D = pd3d;
		_pD3DDevice = pDev;
		_pD3D->GetDeviceCaps(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, &_d3dCaps);
	}
public:
	void	BeginState(int iIdx);
	void	EndState();

	D3DCAPS8&	GetOrgCap(){return _d3dCaps;}
public: 
	
    void        UpdateCullInfo() ;
	LECullInfo*  GetCullInfo()
    {
    	return	&_CullInfo ;
    }

protected:

	void	_AddText(const char *pszText, DWORD dwColor = 0xFFFFFFFF);
    bool	_LoadStateFromFile();
    
protected:
    
    // Direct 3D
    IDirect3DX*             _pD3D;
#ifdef _SKYBOX_
	CTextureManager*		m_pTextureManager;
#endif
    HWND                    _hWnd;
	//CD3DFont*				_pFont; // 内部保留一个Font对象做一些输出操作D3DXMATRIXA16			_matWorld;
	//{lemon modify@2004.9.3
	CLEFont*				_pFont;
	//@}
	LPDIRECT3DDEVICE8		_pD3DDevice;
    D3DVIEWPORT8            _view;
    int                     _nScrWidth;         // 屏幕宽度
    int                     _nScrHeight;        // 屏幕高度
    int                     _nColorBit;
    BOOL                    _bFullScreen;
    D3DXMATRIXA16		    _matProjWorld;
	D3DXMATRIXA16			_matViewWorld;		// 当前世界View	Matrix
	D3DXMATRIXA16			_matUIView;			// 当前界面用View Matrix
	D3DXMATRIXA16			_matUIProj;			// 当前界面用Proj Matrix
	D3DXMATRIXA16			_matViewProj;		// = Proj * View, 为了提高GetRay的速度而临时存放		
    D3DXMATRIXA16           _mat3DUIView;
    D3DXMATRIXA16           _mat3DUIProj;
	
	int                     _nWorldViewStartX;  // 屏幕上显示游戏世界的起点位置
    int                     _nWorldViewStartY;  
    int                     _nWorldViewWidth;   // 屏幕上显示游戏世界的尺寸
    int                     _nWorldViewHeight;
    DWORD                   _dwBackgroundColor; // 屏幕背景清除颜色
    DWORD                   _dwClearFlag;
    BOOL                    _bClearTarget;
    BOOL                    _bClearStencil;
    BOOL                    _bClearZBuffer;
	float                   _fWorldViewFOV;
	 float					_fAspect;
	int						_nCurViewType;      // 避免SetCurrentView中重复设置
	float					_fNearClip;
	float					_fFarClip;
	

	LPSPRITE				_p2DSprite;
    LECullInfo              _CullInfo;
    RECT                    _rcDeskTop;

    
	D3DLIGHT8				_Light;
	
	BOOL						_PrintInfoMask[MAX_INFO_TYPE];
	std::map<int, std::string>	_InfoIdx[MAX_INFO_TYPE];
    char						_szInfo[512];

	// FPS
	BOOL							_bRealFPS; //实际能运行多快，就跑多快，适用机器较慢的，例如845集成显卡
	DWORD							_dwFPS;
    DWORD							_dwFrameCnt;
    DWORD							_dwLastTick;

	vector<LELine*>					_LineList;

	//CLEEffectFile					_CEffectFile;
    BOOL                            _bEnableCaptureAVI;
    BOOL                            _bCaptureScreen;
    D3DCAPS8                        _d3dCaps;
    drInterfaceMgr               _IMgr;
    drD3DCreateParamAdjustInfo      _d3dCPAdjustInfo;
    D3DFORMAT                       _TexSetFmt[2];


#ifdef __VIM3D__
	//VIM 
	FLOAT                           m_fCamTranslation;
	FLOAT                           m_fCamFixPoint;
#endif
};

inline void LERender::SetTransformView(const D3DXMATRIX* mat)
{
    _IMgr.dev_obj->SetTransformView((drMatrix44*)mat);
}
inline void LERender::SetTransformProj(const D3DXMATRIX* mat)
{
    _IMgr.dev_obj->SetTransformProj((drMatrix44*)mat);
}
inline void LERender::SetTransformWorld(const D3DXMATRIX* mat)
{
    _IMgr.dev_obj->SetTransformWorld((drMatrix44*)mat);
}

#if ( defined DR_USE_DX9 )
inline void LERender::SetFVF( DWORD fvf )
{
    _IMgr.dev_obj->SetFVF(fvf);
}
inline void LERender::SetVertexShader( IDirect3DVertexShaderX* shader )
{
    _IMgr.dev_obj->SetVertexShader(shader);
}
inline void LERender::SetVertexDeclaration( IDirect3DVertexDeclarationX* decl )
{
    _IMgr.dev_obj->SetVertexDeclaration(decl);
}
inline void LERender::SetVertexShaderConstantF( UINT reg_id, const float* data, UINT v_num )
{
    _IMgr.dev_obj->SetVertexShaderConstantF(reg_id, data, v_num);
}
#elif ( defined DR_USE_DX8 )
inline void LERender::SetVertexShader( IDirect3DVertexShaderX shader )
{
    _IMgr.dev_obj->SetVertexShader(shader);
}
inline void LERender::SetVertexShaderConstant( UINT reg_id, const void* data, UINT v_num )
{
    _IMgr.dev_obj->SetVertexShaderConstantF(reg_id, data, v_num);
}
#endif

inline HRESULT LERender::SetStreamSource(UINT stream_num, IDirect3DVertexBufferX* stream_data, UINT offset_byte, UINT stride)
{
    return _IMgr.dev_obj->SetStreamSource(stream_num, stream_data, offset_byte, stride);
}
inline HRESULT LERender::SetIndices(IDirect3DIndexBufferX* index_data, UINT base_vert_index)
{
	if( !index_data )
		return E_FAIL;

    return _IMgr.dev_obj->SetIndices(index_data, base_vert_index);
}
inline HRESULT LERender::DrawPrimitive( D3DPRIMITIVETYPE pt_type, UINT start_vertex, UINT count )
{
    return _IMgr.dev_obj->DrawPrimitive(pt_type, start_vertex, count);
}
inline HRESULT LERender::DrawIndexedPrimitive( D3DPRIMITIVETYPE pt_type, INT base_vert_index, UINT min_index, UINT vert_num, UINT start_index, UINT count )
{
    return _IMgr.dev_obj->DrawIndexedPrimitive(pt_type, base_vert_index, min_index, vert_num, start_index, count);
}

inline void LERender::SetBackgroundColor(DWORD dwColor)
{
    _dwBackgroundColor = dwColor;
}

inline void LERender::SetTexture(int nStageNo, LPTEXTURE pTexture)
{
#if(defined USE_MANAGED_RES)
    _IMgr.dev_obj->SetTexture(nStageNo, pTexture);
#else
	_pD3DDevice->SetTexture(nStageNo, pTexture);
#endif
}

inline void LERender::SetTextureStageState(int nStage, TEXTURE_STAGE_STATE nState, int nValue)
{
#if(defined USE_MANAGED_RES)
    _IMgr.dev_obj->SetTextureStageState(nStage, nState, nValue);
#else
	_pD3DDevice->SetTextureStageState(nStage, nState, nValue);
#endif
}

inline void LERender::SetRenderState(RENDER_STATE renState, int nValue)
{
#if(defined USE_MANAGED_RES)
    _IMgr.dev_obj->SetRenderState(renState, nValue);
#else
	_pD3DDevice->SetRenderState(renState, nValue);
#endif
}
inline void LERender::SetTextureForced(DWORD stage, IDirect3DTextureX* tex)
{
    _IMgr.dev_obj->SetTextureForced(stage, tex);
}
inline void LERender::SetRenderStateForced(RENDER_STATE renState, int nValue)
{
    _IMgr.dev_obj->SetRenderStateForced(renState, nValue);
}
inline void LERender::SetTextureStageStateForced(int nStage, TEXTURE_STAGE_STATE nState, int nValue)
{
    _IMgr.dev_obj->SetTextureStageStateForced(nStage, nState, nValue);
}
inline void LERender::SetLight(DWORD id, D3DLIGHTX* light)
{
    _IMgr.dev_obj->SetLight(id, light);
}
inline void LERender::GetLight(DWORD id, D3DLIGHTX* light)
{
    _IMgr.dev_obj->GetLight(id, light);
}
inline void LERender:: GetLightEnable(DWORD id, BOOL* flag)
{
    _IMgr.dev_obj->GetLightEnable(id, flag);
}

inline void LERender::LightEnable(DWORD id, DWORD flag)
{
    _IMgr.dev_obj->LightEnable(id, flag);
}

inline void LERender::EnableAlpha(BOOL bEnable)
{
#if(defined USE_MANAGED_RES)
    _IMgr.dev_obj->SetRenderState(D3DRS_ALPHABLENDENABLE, bEnable);
#else
	_pD3DDevice->SetRenderState(D3DRS_ALPHABLENDENABLE, bEnable);
#endif
}

inline void LERender::EnableZBuffer(BOOL bEnable)
{
#if(defined USE_MANAGED_RES)
    _IMgr.dev_obj->SetRenderState(D3DRS_ZENABLE, bEnable);
    _IMgr.dev_obj->SetRenderState(D3DRS_ZWRITEENABLE, bEnable);
#else
	_pD3DDevice->SetRenderState(D3DRS_ZENABLE,      bEnable);
	_pD3DDevice->SetRenderState(D3DRS_ZWRITEENABLE, bEnable);
#endif
}

inline void LERender::SetWorldView(int nX, int nY, int nW, int nH)
{
    _nWorldViewStartX = nX;
    _nWorldViewStartY = nY;
    if(nW > 0) _nWorldViewWidth  = nW;
    if(nH > 0) _nWorldViewHeight = nH;
}

inline void LERender::SetWorldViewFOV(float fFov)
{
    _fWorldViewFOV = fFov;
}

inline bool LERender::IsInWorldView(int nPosX, int nPosY)
{
    if(nPosX >= _nWorldViewStartX && nPosX < (_nWorldViewStartX + _nWorldViewWidth) &&
       nPosY >= _nWorldViewStartY && nPosY < (_nWorldViewStartY + _nWorldViewHeight))
    {
        return true;
    }
    return false;
}


/*
inline bool SGRender::WorldToScreen(float fX, float fY, float fZ, int *pnX, int *pnY)
{
    D3DXVECTOR4 vOriginal;
    vOriginal.x = fX;
    vOriginal.y = fY;
    vOriginal.z = fZ;
    vOriginal.w = 1.f;
 
    //vOriginal *= _matViewWorld;
    //vOriginal *= _matProjWorld;
    
    D3DXVECTOR4 vTemp;
    D3DXVec4Transform( &vTemp, &vOriginal, &_matViewWorld );
	D3DXVec4Transform( &vOriginal, &vTemp, &_matProjWorld );	
	
    if ((vOriginal.w > 0.000001f || vOriginal.w < -0.000001f))
    {
        vOriginal.w = 1.f / vOriginal.w;
        vOriginal.x *= vOriginal.w;
        vOriginal.y *= vOriginal.w;
        vOriginal.z *= vOriginal.w;
    }
 
    int nPosX = (int)(( vOriginal.x + 1) *  (float)_nWorldViewWidth  / 2.0f);
    int nPosY = (int)((-vOriginal.y + 1) *  (float)_nWorldViewHeight / 2.0f);
    
    if(pnX) *pnX = nPosX;
    if(pnY) *pnY = nPosY;
 
    if( (nPosX >= 0 && nPosY < _nWorldViewWidth) && 
        (nPosY >= 0 && nPosY < _nWorldViewHeight))
    {
        return true;  
    }
    return false;    
}*/

inline BOOL LERender::WorldToScreen(float fX, float fY, float fZ, int *pnX, int *pnY)
{
	D3DXVECTOR3	vTemp, vPosTrans, vecPos;
	vecPos.x = fX;
	vecPos.y = fY;
	vecPos.z = fZ;
	D3DXVec3TransformCoord( &vTemp, &vecPos, &_matViewWorld );
	D3DXVec3TransformCoord( &vPosTrans, &vTemp, &_matProjWorld );	
	if ( vPosTrans.z >= 0.0f && vPosTrans.z < 1.0f )
	{		
		int nPosX = ( INT ) ((   vPosTrans.x + 1 ) * (float)( _nWorldViewWidth )  / 2.0f + 0.5f); 
		int nPosY = ( INT ) (( - vPosTrans.y + 1 ) * (float)( _nWorldViewHeight)  / 2.0f + 0.5f); 
		
        if(pnX) *pnX = nPosX - _nWorldViewStartX;
        if(pnY) *pnY = nPosY - _nWorldViewStartY;
        
        if( nPosX >= 0 && nPosX < _nWorldViewWidth && nPosY >= 0 && nPosY < _nWorldViewHeight)
        {
            return TRUE;
        }
	}
    return FALSE;
}


inline void LERender::SetClip(float fNearClip, float fFarClip)
{
	_fNearClip = fNearClip;
	_fFarClip  = fFarClip;
}

inline void LERender::EnablePrint(int nInfoType, BOOL bEnable)
{
	_PrintInfoMask[nInfoType] = bEnable;
}

inline void LERender::ClearPrint(int nInfoType)
{
	if(nInfoType==-1)
	{
		for(int i = 0; i < MAX_INFO_TYPE; i++) _InfoIdx[i].clear();
	}
	else
	{
		_InfoIdx[nInfoType].clear();
	}
}

inline void LERender::ResetWorldTransform()
{
	D3DXMATRIXA16 mat; D3DXMatrixIdentity(&mat);
	D3DXMatrixTranslation(&mat, 0.0f, 0.0f, 0.0f);
#if(defined USE_MANAGED_RES)
    SetTransformWorld(&mat);
#else
	_pD3DDevice->SetTransform(D3DTS_WORLD, &mat);
#endif
}

inline void LERender::UpdateLight()
{
    _pD3DDevice->SetLight(0, &_Light);
}

inline void LERender::SetDirectLightDir(float x, float y, float z)
{
    D3DXVec3Normalize( (D3DXVECTOR3*)&_Light.Direction, &D3DXVECTOR3(x, y, z) );
    _Light.Position.x   = x;
    _Light.Position.y   = y;
    _Light.Position.z   = z;
	_pD3DDevice->SetLight(0, &_Light);
}

inline void LERender::SetDirectLightColor(float r, float g, float b, float a)
{
    _Light.Diffuse.r   = r;
    _Light.Diffuse.g   = g;
    _Light.Diffuse.b   = b;
    _Light.Diffuse.a   = a;
	_pD3DDevice->SetLight(0, &_Light);
}
inline void LERender::SetDirectLIghtAmbient(float r, float g, float b, float a)
{
    _Light.Ambient.r   = r;
    _Light.Ambient.g   = g;
    _Light.Ambient.b   = b;
    _Light.Ambient.a   = a;
	_pD3DDevice->SetLight(0, &_Light);
}
inline void LERender::UpdateCullInfo( ) 
{
	D3DXMATRIX mat;

    D3DXMatrixMultiply( &mat,& _matViewWorld,& _matProjWorld );
    D3DXMatrixInverse( &mat, NULL, &mat );

    _CullInfo.vecFrustum[0] = D3DXVECTOR3(-1.0f, -1.0f,  0.0f); // xyz
    _CullInfo.vecFrustum[1] = D3DXVECTOR3( 1.0f, -1.0f,  0.0f); // Xyz
    _CullInfo.vecFrustum[2] = D3DXVECTOR3(-1.0f,  1.0f,  0.0f); // xYz
    _CullInfo.vecFrustum[3] = D3DXVECTOR3( 1.0f,  1.0f,  0.0f); // XYz
    _CullInfo.vecFrustum[4] = D3DXVECTOR3(-1.0f, -1.0f,  1.0f); // xyZ
    _CullInfo.vecFrustum[5] = D3DXVECTOR3( 1.0f, -1.0f,  1.0f); // XyZ
    _CullInfo.vecFrustum[6] = D3DXVECTOR3(-1.0f,  1.0f,  1.0f); // xYZ
    _CullInfo.vecFrustum[7] = D3DXVECTOR3( 1.0f,  1.0f,  1.0f); // XYZ

    for( INT i = 0; i < 8; i++ )
	{
        D3DXVec3TransformCoord( &_CullInfo.vecFrustum[i], &_CullInfo.vecFrustum[i], &mat );
	}

    D3DXPlaneFromPoints( &_CullInfo.planeFrustum[0], &_CullInfo.vecFrustum[0], 
        &_CullInfo.vecFrustum[1], &_CullInfo.vecFrustum[2] ); // Near
    D3DXPlaneFromPoints( &_CullInfo.planeFrustum[1], &_CullInfo.vecFrustum[6], 
        &_CullInfo.vecFrustum[7], &_CullInfo.vecFrustum[5] ); // Far
    D3DXPlaneFromPoints( &_CullInfo.planeFrustum[2], &_CullInfo.vecFrustum[2], 
        &_CullInfo.vecFrustum[6], &_CullInfo.vecFrustum[4] ); // Left
    D3DXPlaneFromPoints( &_CullInfo.planeFrustum[3], &_CullInfo.vecFrustum[7], 
        &_CullInfo.vecFrustum[3], &_CullInfo.vecFrustum[5] ); // Right
    D3DXPlaneFromPoints( &_CullInfo.planeFrustum[4], &_CullInfo.vecFrustum[2], 
        &_CullInfo.vecFrustum[3], &_CullInfo.vecFrustum[6] ); // Top
    D3DXPlaneFromPoints( &_CullInfo.planeFrustum[5], &_CullInfo.vecFrustum[1], 
        &_CullInfo.vecFrustum[0], &_CullInfo.vecFrustum[4] ); // Bottom
}
inline	void LERender::GetRenderState(RENDER_STATE renState, DWORD* nValue)
{
	_IMgr.dev_obj->GetRenderState(renState, nValue);
}

inline DWORD LERender::GetRegisteredDevMemSize()
{
    drWatchDevVideoMemInfo* info = _IMgr.dev_obj->GetWatchVideoMemInfo();
    return (info->alloc_ib_size + info->alloc_vb_size + info->alloc_tex_size);
}

inline void LERender::SetD3DCreateParamAdjustInfo(MPD3DCreateParamAdjustInfo* info)
{
    _d3dCPAdjustInfo = *info;
}

extern LIGHTENGINE_API LERender g_Render;
extern LIGHTENGINE_API int g_nTemp;
extern LIGHTENGINE_API DWORD g_dwCurFrameTick;
extern LIGHTENGINE_API float g_fFrameRate;
