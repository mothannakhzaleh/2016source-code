//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drDirectX.h"


#include "drFrontAPI.h"

DR_BEGIN



#define D3DFVF_XYZ_DIF			( D3DFVF_XYZ | D3DFVF_DIFFUSE )
#define D3DFVF_XYZ_NORMAL_TEX1		( D3DFVF_XYZ | D3DFVF_NORMAL | D3DFVF_TEX1 )
#define D3DFVF_XYZ_DIF_TEX1		( D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX1 )
#define D3DFVF_XYZRHW_DIF_TEX1        ( D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX1 )



struct DR_FRONT_API D3DFVF_XyzNormalTex1
{
    float x, y, z;
    float nx, ny, nz;
    float tu, tv;
};

struct DR_FRONT_API D3DFVF_XyzDif
{
	float x, y, z;
	DWORD dif;
};


struct DR_FRONT_API D3DFVF_XyzDifTex1
{
	float x, y, z;
	DWORD dif;
	float tu, tv;
};

struct DR_FRONT_API D3DFVF_XyzwDifTex1
{
	float x, y, z, w;
	DWORD dif;
	float tu, tv;
};



//DR_FRONT_API inline drColorValue4f drMakeColorValue4f( float r, float g, float b, float a ) {
//    drColorValue4f c = { r, g, b, a };
//    return c;
//}
//
//DR_FRONT_API inline drColorValue4b drMakeColorValue4b( BYTE r, BYTE g, BYTE b, BYTE a ) {
//    drColorValue4b c = { r, g, b, a };
//    return c;
//}

struct DR_FRONT_API drTexParam
{
	DWORD usage;
	D3DFORMAT fmt;
	D3DPOOL pool;
};

struct DR_FRONT_API drVerParam
{
    DWORD usage;
    D3DFORMAT ind_fmt;
    D3DPOOL pool;
};

// class declaration
class drSprite;
class drD3DSprite;

DR_END
