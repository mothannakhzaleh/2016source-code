//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"

DR_BEGIN

struct drFVFStruct_XyzNormal
{
    drVector3 pos;
    drVector3 normal;
};

struct drFVFStruct_XyzwDiffuseTex1
{
    drVector4 pos;
    DWORD dif;
    drVector2 texcoord0;
};

struct drFVFStruct_XyzwDiffuseTex2
{
    drVector4 pos;
    DWORD dif;
    drVector2 texcoord0;
    drVector2 texcoord1;
};

struct drFVFStruct_XyzDiffuse
{
    drVector3 pos;
    DWORD dif;
};

struct drFVFStruct_XyzNormalTex1
{
    drVector3 pos;
    drVector3 normal;
    drVector2 texcoord0;
};

struct drFVFStruct_XyzNormalTex2
{
    drVector3 pos;
    drVector3 normal;
    drVector2 texcoord0;
	drVector2 texcoord1;
};

struct drFVFStruct_XyzDiffuseTex1
{
    drVector3 pos;
	DWORD dif;
    drVector2 texcoord0;
};
struct drFVFStruct_XyzNormalDiffuseTex1
{
    drVector3 pos;
    drVector3 normal;
    DWORD dif;
    drVector2 texcoord0;
};
struct drFVFStruct_XyzNormalDiffuseTex2
{
    drVector3 pos;
    drVector3 normal;
    DWORD dif;
    drVector2 texcoord0;
	drVector2 texcoord1;
};
struct drFVFStruct_XyzUbyte4NormalTex1
{
    drVector3 pos;
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
};
struct drFVFStruct_XyzUbyte4NormalTex2
{
    drVector3 pos;
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
	drVector2 texcoord1;
};
struct drFVFStruct_Xyzb2Ubyte4NormalTex1
{
    drVector3 pos;
	float weight;
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
};
struct drFVFStruct_Xyzb2Ubyte4NormalTex2
{
    drVector3 pos;
	float weight;
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
    drVector2 texcoord1;
};
struct drFVFStruct_Xyzb3Ubyte4NormalTex1
{
    drVector3 pos;
	float weight[2];
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
};
struct drFVFStruct_Xyzb3Ubyte4NormalTex2
{
    drVector3 pos;
	float weight[2];
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
    drVector2 texcoord1;
};
struct drFVFStruct_Xyzb4Ubyte4NormalTex1
{
    drVector3 pos;
	float weight[3];
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
};
struct drFVFStruct_Xyzb4Ubyte4NormalTex2
{
    drVector3 pos;
	float weight[3];
	DWORD index;
    drVector3 normal;
    drVector2 texcoord0;
    drVector2 texcoord1;
};

struct drFVFStruct_Xyzb1DiffuseTex1
{
    drVector3 pos;
    float weight;
    DWORD dif;
    drVector2 texcoord0;
};

struct drFVFStruct_Xyzb1DiffuseTex2
{
    drVector3 pos;
    float weight;
    DWORD dif;
    drVector2 texcoord0;
    drVector2 texcoord1;
};

struct drFVFStruct_XyzDiffuseTex2
{
    drVector3 pos;
    DWORD dif;
    drVector2 texcoord0;
    drVector2 texcoord1;
};

#define FVF_XYZNORMAL (D3DFVF_XYZ|D3DFVF_NORMAL)
#define FVF_XYZRHWDIFFUSETEX1 (D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX1)
#define FVF_XYZRHWDIFFUSETEX2 (D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX2)
#define FVF_XYZDIFFUSETEX2 (D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX2)
#define FVF_XYZDIFFUSE ( D3DFVF_XYZ | D3DFVF_DIFFUSE )
#define FVF_XYZDIFFUSETEX1 ( D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX1 )
#define FVF_XYZNORMALTEX1 (D3DFVF_XYZ | D3DFVF_NORMAL | D3DFVF_TEX1 )
#define FVF_XYZNORMALTEX2 (D3DFVF_XYZ | D3DFVF_NORMAL | D3DFVF_TEX2 )
#define FVF_XYZNORMALDIFFUSETEX1 ( D3DFVF_XYZ | D3DFVF_NORMAL | D3DFVF_DIFFUSE | D3DFVF_TEX1 )
#define FVF_XYZNORMALDIFFUSETEX2 ( D3DFVF_XYZ | D3DFVF_NORMAL | D3DFVF_DIFFUSE | D3DFVF_TEX2 )
#define FVF_XYZB1DIFFUSETEX1 (D3DFVF_XYZB1 | D3DFVF_DIFFUSE | D3DFVF_TEX1)
#define FVF_XYZB1DIFFUSETEX2 (D3DFVF_XYZB1 | D3DFVF_DIFFUSE | D3DFVF_TEX2)
#define FVF_XYZUBYTE4NORMALTEX1 (D3DFVF_XYZ | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX1 )
#define FVF_XYZB2UBYTE4NORMALTEX1 (D3DFVF_XYZB2 | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX1 )
#define FVF_XYZB3UBYTE4NORMALTEX1 (D3DFVF_XYZB3 | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX1 )
#define FVF_XYZB4UBYTE4NORMALTEX1 (D3DFVF_XYZB4 | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX1 )
#define FVF_XYZUBYTE4NORMALTEX2 (D3DFVF_XYZ | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX2 )
#define FVF_XYZB2UBYTE4NORMALTEX2 (D3DFVF_XYZB2 | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX2 )
#define FVF_XYZB3UBYTE4NORMALTEX2 (D3DFVF_XYZB3 | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX2 )
#define FVF_XYZB4UBYTE4NORMALTEX2 (D3DFVF_XYZB4 | D3DFVF_LASTBETA_UBYTE4 | D3DFVF_NORMAL | D3DFVF_TEX2 )


DR_END
