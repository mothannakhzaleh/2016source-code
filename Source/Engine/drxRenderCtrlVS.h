#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drDirectX.h"
#include "drITypes.h"
#include "drInterface.h"

DR_BEGIN

// define base const register
//; c0      = { 1.0f, 0.0f, 0.0f, 1020.01f };
//; c1-c4   = projection matrix
//; c5      = light direction
//; c6      = ambient color
//; c7      = diffuse * light.diffuse
//; c8-c11  = oT0 uv matrix
//; c12-c15 = oT1 uv matrix
//; c21     = world-view matrix palette

enum
{
    VS_CONST_REG_BASE =         0,
    VS_CONST_REG_VIEWPROJ =     1,
    VS_CONST_REG_LIGHT_DIR =    5,
    VS_CONST_REG_LIGHT_AMB =    6,
    VS_CONST_REG_LIGHT_DIF =    7,
    VS_CONST_REG_TS0_UVMAT =    8,
    VS_CONST_REG_TS1_UVMAT =    12,
    VS_CONST_REG_TS2_UVMAT =    16,
    VS_CONST_REG_MAT_PALETTE =  21,
};

DR_RESULT drInitUserRenderCtrlVSProc(drIResourceMgr* mgr);

class drxRenderCtrlVSVertexBlend_dx8 : public drIRenderCtrlVS
{
    typedef drxRenderCtrlVSVertexBlend_dx8 this_type;

    DR_STD_DECLARATION();

private:
    D3DLIGHTX _lgt;
    drColorValue4f _rs_amb;
    DWORD _rs_lgt;
    DWORD _rs_fog;
    BOOL _lgt_enable;

public:
	drxRenderCtrlVSVertexBlend_dx8();
    DWORD GetType() { return RENDERCTRL_VS_VERTEXBLEND; }
    DR_RESULT Clone(drIRenderCtrlVS** obj);
    DR_RESULT Initialize(drIRenderCtrlAgent* agent);
    DR_RESULT BeginSet(drIRenderCtrlAgent* agent);
    DR_RESULT EndSet(drIRenderCtrlAgent* agent);
    DR_RESULT BeginSetSubset(DWORD subset, drIRenderCtrlAgent* agent);
    DR_RESULT EndSetSubset(DWORD subset, drIRenderCtrlAgent* agent);


private:
	std::string mPixelShaderName;
	bool mPixelShaderReload;
	DWORD mPixelShader;
public:
	void setPixelShader( const std::string& filename )
	{
		mPixelShaderName = filename;
		mPixelShaderReload = true;
	}

};

#if(defined DR_USE_DX9)

class drxRenderCtrlVSVertexBlend : public drIRenderCtrlVS
{
    typedef drxRenderCtrlVSVertexBlend this_type;

    DR_STD_DECLARATION();

private:
    D3DLIGHTX _lgt;
    drColorValue4f _rs_amb;
    ID3DXConstantTable* _const_tab;
    DWORD _rs_lgt;
    DWORD _rs_fog;
    BOOL _lgt_enable;

public:
    DWORD GetType() { return RENDERCTRL_VS_VERTEXBLEND; }
    DR_RESULT Clone(drIRenderCtrlVS** obj);
    DR_RESULT Initialize(drIRenderCtrlAgent* agent);
    DR_RESULT BeginSet(drIRenderCtrlAgent* agent);
    DR_RESULT EndSet(drIRenderCtrlAgent* agent);
    DR_RESULT BeginSetSubset(DWORD subset, drIRenderCtrlAgent* agent);
    DR_RESULT EndSetSubset(DWORD subset, drIRenderCtrlAgent* agent);
};

#endif

DR_END