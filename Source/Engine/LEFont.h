#pragma once

#include <algorithm>

inline bool	GetIntersectRect(RECT* pdest, RECT* psrc,RECT* pclip)
{
	int x1 = 0, x2 = 0, y1 = 0, y2 = 0;
	// 图形在裁剪区外，不显示
	if( psrc->left >= pclip->right || psrc->right <= pclip->left\
		||psrc->top >= pclip->bottom || psrc->bottom <= pclip->top)
	{
		return false;
	}
	// 进行裁剪
	if( psrc->left < pclip->left )
	{
		x1 = psrc->left - pclip->left;
	}
	if( psrc->right > pclip->right )
	{
		x2 = pclip->right - psrc->right;
	}
	if( psrc->top < pclip->top )
	{
		y1 = psrc->top - pclip->top;
	}
	if( psrc->bottom > pclip->bottom )
	{
		y2 = pclip->bottom - psrc->bottom;
	}
	pdest->left  = psrc->left - x1;
	pdest->right = psrc->right + x2;
	pdest->top   = psrc->top - y1;
 	pdest->bottom = psrc->bottom + y2;
	return true;
}
namespace ui
{
#define UI_STATE_NOCLIP		0
#define UI_STATE_CLIP		1

	class LIGHTENGINE_API UIClip
	{
	public:
		static UIClip* Instance() 
		{ 
			if( m_pClip ) return m_pClip;
			m_pClip = new UIClip;
			return m_pClip;
		}

		void	SetClipRect( int x, int y, int w, int h ) 
		{ 
			m_rectClip.left = x;
			m_rectClip.top  = y;
			m_rectClip.right = x + w;
			m_rectClip.bottom = y + h;
			m_byState = UI_STATE_CLIP;
		}

		void	Reset() { m_byState = UI_STATE_NOCLIP; }

		BYTE	GetClipState() { return m_byState; }
		RECT&	GetClipRect() { return m_rectClip; }

		static UIClip* GetCliper()		{ return m_pClip;}

		bool	GetIntersectRect(RECT* pdest, RECT* psrc, BYTE* byFill = NULL)
		{
			int x1 = 0, x2 = 0, y1 = 0, y2 = 0;
			RECT* prc = &GetClipRect();
			// 图形在裁剪区外，不显示
			if( psrc->left >= prc->right || psrc->right <= prc->left\
				||psrc->top >= prc->bottom || psrc->bottom <= prc->top)
			{
				return false;
			}
			if(byFill)
			{
				if( psrc->left >= prc->left && psrc->right <= prc->right\
					&&psrc->top >= prc->top && psrc->bottom <= prc->bottom)
				{
					*byFill = 1;
					return true;
				}
			}
			// 进行裁剪

			if( psrc->left < prc->left )
			{
				x1 = psrc->left - prc->left;
			}
			if( psrc->right > prc->right )
			{
				x2 = prc->right - psrc->right;
			}
			if( psrc->top < prc->top )
			{
				y1 = psrc->top - prc->top;
			}
			if( psrc->bottom > prc->bottom )
			{
				y2 = prc->bottom - psrc->bottom;
			}
			pdest->left  = psrc->left - x1;
			pdest->right = psrc->right + x2;
			pdest->top   = psrc->top - y1;
			pdest->bottom = psrc->bottom + y2;
			return true;
		}

	protected:
		UIClip();
		~UIClip();

	private:
		BYTE	m_byState;
		RECT	m_rectClip;
		static UIClip*	m_pClip;
	};
}


/*
	bool CreateFont( LPDIRECT3DDEVICE8 pd3dDevice, char* szFontName, int nSize = 16, int nLevel = 3 );
	\param1		3D设备
	\param2		字体名称
	\param3		字体大小（可以使用16或24点阵）
	\param4		纹理大小等级（可以为1 -- 5.分别为1=64 2=128 3=256 4=512 5=1024。
				NOTE: 
				1.如果使用小于256的纹理里时，在使用郑码输入法时有时一次输入的文字数会大于缓冲数目，
				所以我设默认纹理大小为256.对于绝大多数显卡来说创建一个256的纹理应该不是问题吧？:)
				2.尽量使用16点阵大小的字体,如果要使用大字体可以改变缩放值
				3.不同的纹理大小一次可以渲染的文字数量也是不一样的，64大小的纹理可以一次渲染的文字数量是16个，
				128大小的是64个，256的是256个,512大小是1024,1024大小是4096,纹理越小，速度越快。以上所说的
				都是16点阵大小的字体，如果是24点阵的还要少一些）


	bool DrawText( char* szText, int x, int y, D3DCOLOR color = 0xFFFFFFFF,float fScale = 1.0f );
	\param1		要渲染的文字
				（NOTE:所渲染的文字的个数不能大于缓冲数目）
	\param2		屏幕上的X坐标
	\param3		屏幕上的Y坐标
	\param4		文字的颜色
	\param5		可以对文字大小进行缩放
	return		成功返回true;
 */
//===================================================================
//!定义字体的fvf
#define D3DFVF_FONT (D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX1)
#define D3DFVF_3DFONT (D3DFVF_XYZB1 | D3DFVF_DIFFUSE | D3DFVF_TEX1)


#define LEFONT_BOLD        0x0001
#define LEFONT_ITALIC      0x0002
#define LEFONT_UNLINE      0x0004

#define  RECTNUM	60
#define  DRAWONCE	
class   LERender;

class LIGHTENGINE_API CLEFont
{
public:
	CLEFont();
	~CLEFont();
	struct FONT_VER
	{
		D3DXVECTOR4 m_vPos;
		//float		m_fIdx;
		DWORD m_color;
		D3DXVECTOR2 m_fUV;
		void SetValue(D3DXVECTOR4 &_vPos,DWORD _color,D3DXVECTOR2 &_fUV)
		{
			m_vPos = _vPos;
			m_color = _color;
			m_fUV = _fUV;
		}
	};

	struct LEFontRect
	{
		void	Reset()
		{
			pstr = "";
			bUsed = false;
			fscale = 0;
		}
		bool operator == (LEFontRect& sRect)
		{
			if(pstr != sRect.pstr)
				return false;
			if(dwColor != sRect.dwColor)
				return false;
			if(rcPos.left != sRect.rcPos.left || rcPos.top != sRect.rcPos.top)
				return false;

			return true;
		}
		bool IsEqual(char* pszText, int x,int y, DWORD color,float tfscale)
		{
			if(pstr != pszText || fscale != tfscale)
				return false;
			else if( rcPos.left  != x || rcPos.top != y )
			{
#ifdef DRAWONCE
				FONT_VER* pVer;
				int w =  x - rcPos.left;
				int h = y - rcPos.top;
				WORD n;
				if(iHslNum > 0)
				{
					int lh = iHslNum * 3;
					for ( n = 0; n < lh; ++n)
					{
						pVer = &_vecHsl[n];
						pVer->m_vPos.x += w;
						pVer->m_vPos.y += h;
						pVer->m_color = color;
					}
				}
				if(iAshNum > 0)
				{
					int la = iAshNum * 3;
					for ( n = 0; n < la; ++n)
					{
						pVer = &_vecAsh[n];
						pVer->m_vPos.x += w;
						pVer->m_vPos.y += h;
						pVer->m_color = color;
					}
				}
#else
				int w =  rcPos.left - x;
				int h = rcPos.top - y;
				WORD n;
				if(iHslNum > 0)
				{
					int lh = iHslNum * 4;
					for ( n = 0; n < lh; ++n)
					{
						_vecHsl[n].x -= w;
						_vecHsl[n].y += h;
					}
				}
				if(iAshNum > 0)
				{
					int la = iAshNum * 4;
					for ( n = 0; n < la; ++n)
					{
						_vecAsh[n].x -= w;
						_vecAsh[n].y += h;
					}
				}
#endif
				rcPos.left = x ;
				rcPos.top = y;
			}if(dwColor != color)
			{
				dwColor = color;
#ifdef DRAWONCE
				WORD n;
				if(iHslNum > 0)
				{
					int lh = iHslNum * 3;
					for ( n = 0; n < lh; ++n)
						_vecHsl[n].m_color = color;
				}
				if(iAshNum > 0)
				{
					int la = iAshNum * 3;
					for ( n = 0; n < la; ++n)
						_vecAsh[n].m_color = color;
				}
#endif
			}
			return true;
		}
		s_string	pstr;
		RECT rcPos;
		DWORD dwColor;
		float	fscale;
#ifdef DRAWONCE
		std::vector<FONT_VER>	_vecHsl;
		std::vector<FONT_VER>	_vecAsh;
#else
		std::vector<D3DXVECTOR4>	_vecHsl;
		std::vector<D3DXVECTOR4>	_vecAsh;
#endif

		int iAshNum;
		int iHslNum;
		bool bUsed;
	};
#ifdef		USE_RENDER
	bool CreateFont( LERender* pd3dDevice, char* szFontName, int nSize = 16, int nLevel = 3 ,DWORD dwFlag = 0);
#else
	bool CreateFont( LPDIRECT3DDEVICE8 pd3dDevice, char* szFontName, int nSize = 16, int nLevel = 3 ,DWORD dwFlag = 0);
#endif
	void BindingRes(CLEResManger* pResMagr);

	void Begin();
	void Draw(char* szText, int x, int y, D3DXCOLOR color);
	void End();

	void BeginClip();
	void DrawTextClipOnce(char* szText, int nLen, LPRECT psrc, LPRECT pclip,D3DXCOLOR color);
	void EndClip();

	bool DrawText( char* szText, int x, int y, D3DXCOLOR color = 0xFFFFFFFF,float fScale = 1.0f ,DWORD* dwTime = NULL);
	bool DrawText( int iNumber, int x, int y, D3DXCOLOR color = 0xFFFFFFFF,float fScale = 1.0f );
	
	bool DrawTextShadow( char* szText, int x1, int y1, int x2, int y2,
		D3DXCOLOR color1,D3DXCOLOR color2);


	bool Draw3DText(char* szText,D3DXVECTOR3& vPos, D3DXCOLOR color = 0xFFFFFFFF,float fScale = 0.3f );

	SIZE* GetTextSize(char* szText, SIZE* pSize,float fScale = 1.0f);
	int	  GetHzLength(float fscale = 1.0f);
	int   GetAscLength(float fscale = 1.0f);

	void ReleaseFont();

	void UseSoft(bool bUseSoft){_bUseSoft = bUseSoft;}
	bool IsUseSoft()		   {return _bUseSoft;}
#ifdef USE_RENDER
	drITex*				GetTexture(){return _pTex;}
#else
	LPDIRECT3DTEXTURE8	GetTexture(){return _pTexFast;}
#endif

	void SetRenderIdx(int iIdx)	{ _iRenderIdx = iIdx; }

private:
	bool  TextToTexture( char c1, char c2, float & tX, float & tY );

	void FillTextToTex( char* szText );

	bool FindTextFromTex( char c1, char c2, float & tX1, float & tY1 , float & tX2, float & tY2);

	bool DrawTextClip( char* szText, int nLen,LPRECT psrc, LPRECT pclip,D3DXCOLOR color = 0xFFFFFFFF);

	int FindRect( char* szText, int x,int y, DWORD color,float tfscale)
	{
		if(_vecValidID.size() == RECTNUM)
			return -1;
		for (INT n = 0; n < RECTNUM; ++n)
		{
			if(_vecFontRect[n].bUsed)
				if(_vecFontRect[n].IsEqual(szText,x,y,color,tfscale))
					return n;
		}
		return -1;
	}
	int GetNextInValidRect(LEFontRect** pRect)
	{
		if(_vecValidID.empty())
		{
			ResetRect();
		}
		int rcdx = *_vecValidID.front();

		_vecValidID.pop_front();

		*pRect = &_vecFontRect[rcdx];
		(*pRect)->bUsed = true;
		return rcdx;
	}
	void ResetRect()
	{
		_vecValidID.setsize(RECTNUM);
		for ( INT n = 0; n < RECTNUM; ++n)
		{
			_vecFontRect[n].Reset();
			*_vecValidID[n] = n;
		}
	}
	void RenderOptimize(int iIdx);
	void RenderDrawOptimize(int iIdx);

private:
	HDC			_hDc;			
	HBITMAP		_hBmp;
	HFONT		_hFont;
	HGDIOBJ		_hBmpOld;
	HFONT		_hFontOld;

	UINT		_Max;
	int			_RowNum;
	DWORD *		_pBits;

	int			_TextSize;
	int			_TextureSize;

	bool		_bWidthEqual;

	std::vector<WORD> _vecBuf;	

#ifdef		USE_RENDER
	LERender*				_pDev;
#else
	LPDIRECT3DDEVICE8		_pDev;
#endif


#ifndef USE_RENDER
	LPDIRECT3DVERTEXBUFFER8 _pVB;	

	LPDIRECT3DTEXTURE8		_pTex;
#else
	drIMesh*				_pVB;
	drITex*					_pTex;


#endif

	int						_iRenderIdx;
	CLEEffectFile*			_pCEffectFile;
	bool					_bUseSoft;
	DWORD*					_pdwVS;

	D3DXMATRIX*				_pmatBBoard;
	D3DXMATRIX*				_pmatViewProj;
	D3DXMATRIX*				_pmat2DViewProj;
	int*					_iBufWidth;
	int*					_iBufHeight;

#ifndef USE_RENDER
	LPDIRECT3DTEXTURE8		_pTexFast;
#else
	drITex*					_pTexFast;
#endif

	std::vector<WORD>		_vecBufFast;
	std::map<WORD, D3DXVECTOR4>	_mapUV;
	int			_RowNumFast;		
	UINT		_MaFast;
	int			_TextureSizeFast;

#ifndef USE_RENDER
	LPDIRECT3DTEXTURE8		_lpCurTex;
#else
	drITex*					_lpCurTex;
#endif

	float					_fyu;

///////优化渲染///////////////////////////////////////////////////////////////////
	S_FVector<WORD>			_vecValidID;
	std::vector<LEFontRect>	_vecFontRect;
//////////////////////////////////////////////////////////////////////////
	FONT_VER*				_vecVer;
	FONT_VER*				_vecAsh;

};


