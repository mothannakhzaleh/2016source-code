#pragma once

#include <d3dx8.h>
#include "LERender.h"

#define DRAW_TERRAIN_USE_DYNAMIC_BUFFER

#define SEA_LEVEL 0.0f

struct LETileVertex
{
	D3DXVECTOR3	p;
	// D3DXVECTOR3 n;
	DWORD		dwColor;
	float		tu1, tv1;
	float		tu2, tv2;
};

struct LESeaTileVertex
{
	D3DXVECTOR3	p;
	DWORD		dwColor;
	float		tu, tv;
};

struct LESkyDoomVertex
{
	D3DXVECTOR3 p;
	float       tu,tv;
};

struct LELineVertex
{
	D3DXVECTOR3	p;
	DWORD		dwColor;
};

struct LETileTex  // 单一贴图层  
{
	BYTE	btTexNo;	 // 贴图编号
	BYTE	btAlphaNo;	 // Alpha图编号
	LETileTex()
		:btTexNo(0), btAlphaNo(0)	{}
	
	BYTE SetAlphaNo(BYTE btAlphaNo_, BOOL bReset = FALSE)
	{
		if(bReset) 
		{
			btAlphaNo = btAlphaNo_;
		}
		else
		{
			btAlphaNo = btAlphaNo | btAlphaNo_;
		}
		return btAlphaNo;
	}
};

inline float _getObjHeight(BYTE btValue, int no)
{
    BYTE btLevel = btValue & 63;
    float f = (float)btLevel;
    f*=5.0f; // 每个级别代表5厘米
    if(btValue & 64) // 负数
    {
        return f / 100.0f * -1.0f;
    }
    return f / 100.0f;
}


inline BYTE _setObjHeight(BYTE btOldValue, float fHeight, int no)
{
     if(fHeight>3.1f)  fHeight = 3.1f;
	 if(fHeight<-3.1f) fHeight = -3.1f;
	 if(fHeight < 0.0f) 
     {
         fHeight*=-1.0f;
         btOldValue|=64;
     }
     else
     {
         btOldValue&=191;
     }
     BYTE btLevel = (BYTE)(fHeight / 0.05f);
     btOldValue&=192; // 清除6位高度
     btOldValue|=btLevel;
     return btOldValue;
}


struct LIGHTENGINE_API LETile
{
	static	int		Offset[4][2];

    LETileTex		TexLayer[4]; // 最多4层重叠
	DWORD			dwColor;	 // 左上角第一个顶点的颜色
    short           sRegion;     // 区域属性
    BYTE            btIsland;    // 岛屿属性
    BYTE            btBlock[4];  // 4个分格的障碍记录
    
	float			fHeight;     // 左上角第一个顶点的高度
	
    //lemon add@2004.10.18
	DWORD			dwTColor;	 // 临时顶点的颜色
    DWORD           dwXColor;    // 混合后的颜色

public:
    
    void Init()
	{
		fHeight     = 0.0f;
        dwColor     = 0xffffffff;
        dwTColor    = 0;

		for(int i = 0; i < 4; i++)
		{
			TexLayer[i].btTexNo = TexLayer[i].btAlphaNo = 0;
		    btBlock[i] = 0;
        }
		sRegion  = 0; // 默认为海水, 区域属性 = 0
        btIsland = 0;
    }

	BOOL	IsDefault()
	{
		if(TexLayer[1].btTexNo==255) return TRUE;
		return FALSE;
	}
	
	void	ResetTexLayer(BYTE btTexNo)
	{
		TexLayer[0].btTexNo   = btTexNo;
		TexLayer[0].btAlphaNo = 15;
		TexLayer[1].btTexNo   = 0;
	}
	
	void	AddHeight(float fAddHeight)
	{
		if(IsDefault()) return;
		fHeight+=fAddHeight;
	}

	void	setHeight(float fSetHeight)
	{
		if(IsDefault()) return;
		fHeight = fSetHeight;
	}

    float getHeight() { return fHeight; }

    BYTE    IsBlock(BYTE no)
    {
        if(btBlock[no] & 128) return 1;
        return 0;
    }

    void setBlock(BYTE no, BOOL bSet)
    {
        if(bSet)
        {
            btBlock[no]|=128;
        }
        else
        {
            btBlock[no]&=127;
        }
    }
    
    float   getObjHeight(BYTE no)
    {
        return _getObjHeight(btBlock[no], no);
    }

    void setObjHeight(BYTE no, float fHeight)
    {
        btBlock[no] = _setObjHeight(btBlock[no], fHeight, no);
    }
     
    void    setRegion(int nRegionNo, BOOL bSet)
    {
        if(IsDefault()) return;
        short s = 1;
        s<<=(nRegionNo - 1);
        if(bSet)              sRegion|=s;
        else if(sRegion & s)  sRegion^=s;
    }

    void    setIsland(BOOL bSet)
    {
        btIsland = bSet;
    }

    BYTE    getIsland()
    {
        return btIsland;
    }
    
    BOOL    IsRegion(int nRegionNo)
    {
        short s = 1;
        s<<=(nRegionNo - 1);
        return sRegion & s; 
    }

    short  getRegionValue() { return sRegion; }

	static void	RenderSea(int nX, int nY, int nTileSize);

	void	AddTexLayer(BYTE btTexNo, BYTE btAlphaNo);
	
    void	SetTerrainUV(int nStage, float fU, float fV, float fUVSize);
	
    void	SetTerrainUV_Inter(int nStage, float fU, float fV, float fUVSize);
	
    void	SetBumpUV(int nStage, float fU, float fV, float fUVSize);
	void	RenderTerrain(int nX, int nY, LETile *TileList[]);
	void	RenderBump(int nX, int nY, int nTileSize);

	void	setTempColor(DWORD dwcolor)		{dwTColor = dwcolor;}

	bool	IsVisibale(int sx, int sy,float* hei);
public:

	static	LETileVertex		_TVertex[4];
	static  LESeaTileVertex		_SVertex[4];
};

inline void LETile::SetTerrainUV_Inter(int nStageNo, float fU, float fV, float fUVSize)
{
	float fOff = 0.01f;
    if(nStageNo==0)
	{	
		_TVertex[0].tu1 = fU + fOff;
		_TVertex[0].tv1 = fV + fOff;
		
        _TVertex[1].tu1 = fU + fUVSize - fOff;
		_TVertex[1].tv1 = fV + fOff;
		
        _TVertex[2].tu1 = fU + fOff;
		_TVertex[2].tv1 = fV + fUVSize - fOff;
		_TVertex[3].tu1 = fU + fUVSize - fOff;
		_TVertex[3].tv1 = fV + fUVSize - fOff;
	}
}

inline void LETile::SetTerrainUV(int nStageNo, float fU, float fV, float fUVSize)
{
	if(nStageNo==0)
	{	
		_TVertex[0].tu1 = fU;
		_TVertex[0].tv1 = fV;
		_TVertex[1].tu1 = fU + fUVSize;
		_TVertex[1].tv1 = fV;
		_TVertex[2].tu1 = fU;
		_TVertex[2].tv1 = fV + fUVSize;
		_TVertex[3].tu1 = fU + fUVSize;
		_TVertex[3].tv1 = fV + fUVSize;
	}
	else if(nStageNo==1)
	{
		_TVertex[0].tu2 = fU;
		_TVertex[0].tv2 = fV;
		_TVertex[1].tu2 = fU + fUVSize;
		_TVertex[1].tv2 = fV;
		_TVertex[2].tu2 = fU;
		_TVertex[2].tv2 = fV + fUVSize;
		_TVertex[3].tu2 = fU + fUVSize;
		_TVertex[3].tv2 = fV + fUVSize;
	}
}


inline bool LETile::IsVisibale(int sx, int sy,float* hei)
{
	D3DXVECTOR3		vTemp, vTrans;
	int inx, iny;

	for(int i = 0; i < 4; ++i)
	{
		vTrans = D3DXVECTOR3( (float)(sx + Offset[i][0]), (float)(sy + Offset[i][1]),hei[i] );
		D3DXVec3TransformCoord( &vTemp, &vTrans, &g_Render.GetViewProjMatrix() );
		if ( vTemp.z >= 0.0f && vTemp.z < 1.0f ) 
		{		
			inx = ( INT ) ( ( vTemp.x + 1) * g_Render.GetScrWidth() / 2.0f +0.5f);
			iny = ( INT ) ( ( - vTemp.y + 1) * g_Render.GetScrHeight() / 2.0f +0.5f);

			if(inx>0 && inx< g_Render.GetScrWidth() && 
				iny>0 && iny<g_Render.GetScrHeight())
			{
				return true;
			}
		}
	}
	return false;
}


