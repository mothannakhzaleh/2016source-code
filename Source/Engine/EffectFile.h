// DXEffectFile.h: interface for the CLEEffectFile class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_DXEFFECTFILE_H__F7B73B81_55EE_11BD_AC67_0008C720ECD1__INCLUDED_)
#define AFX_DXEFFECTFILE_H__F7B73B81_55EE_11BD_AC67_0008C720ECD1__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000
class   LERender;

#include "D3dx8effect.h"
#include "i_effect.h"

class CLEEffectFile  
{
public:
#ifdef USE_RENDER
	CLEEffectFile(LERender*	 pDev);
#else
	CLEEffectFile(LPDIRECT3DDEVICE8 pDev);
#endif
	CLEEffectFile();
	virtual ~CLEEffectFile();

#ifdef USE_RENDER
	void InitDev(LERender* pDev);
#else
	void InitDev(LPDIRECT3DDEVICE8 pDev);
#endif

#ifdef USE_RENDER
	LERender*	CLEEffectFile::GetDev();
#else
	LPDIRECT3DDEVICE8	CLEEffectFile::GetDev();
#endif
	BOOL OnResetDevice();
	BOOL OnLostDevice();

	//BOOL LoadEffectFromResource(TCHAR* pszsrc);
	BOOL LoadEffectFromFile(LPCSTR pszfile);

	BOOL SetTechnique(int iIdx);

	//BOOL CreateVertexShader();
	//BOOL SetVertexShader();

	BOOL SetTexture(LPCSTR TextureValue,LPDIRECT3DTEXTURE8 pTexture);
	BOOL SetDword(LPCSTR DwName, DWORD dwvalue);

	BOOL Begin(DWORD  dwIsSave = 0);
	BOOL Pass(UINT ipass);
	BOOL End();

	int	 GetTechCount()						{ return _iTechNum;}
	int  GetPassCount()						{ return m_passes;}
	void free();

public:
#ifdef USE_RENDER
	LERender*			 m_pDev;
#else
	LPDIRECT3DDEVICE8    m_pDev;
#endif

	LPD3DXEFFECT         m_pEffect;
	UINT                 m_passes;

protected:
	int									_iTechNum;
	std::vector<D3DXTECHNIQUE_DESC>		_vecTechniques;

	DWORD								_dwVShader;
};
inline BOOL CLEEffectFile::SetTechnique(int iIdx)
{
	//if(iIdx >= _iTechNum)
	//	return false;
    if(FAILED(m_pEffect->SetTechnique(_vecTechniques[iIdx].Index)))
		return FALSE;
	return  TRUE;
}

//inline  BOOL CLEEffectFile::CreateVertexShader()
//{
//	LPD3DXBUFFER pCode;   //!ָ���
//	DWORD dwEffVerDecl[] =
//    {
//        D3DVSD_STREAM( 0 ),
//        D3DVSD_REG( D3DVSDE_POSITION , D3DVSDT_FLOAT3 ), // Position of first mesh
//		D3DVSD_REG( D3DVSDE_BLENDINDICES,D3DVSDT_FLOAT1),
//        D3DVSD_REG( D3DVSDE_DIFFUSE, D3DVSDT_D3DCOLOR ), // diffuse
//        D3DVSD_REG( D3DVSDE_TEXCOORD0, D3DVSDT_FLOAT2 ), // Tex coords
//        D3DVSD_END()
//    };
//
//	if(FAILED(D3DXAssembleShaderFromFile( "shader\\eff.vsh", NULL, 0, &pCode, NULL ) ) )
//	{
//		return FALSE;
//	}
//    if( FAILED(m_pDev->CreateVertexShader( dwEffVerDecl, 
//                                          (DWORD*)pCode->GetBufferPointer(),
//                                          &_dwVShader , FALSE ) ) )
//    {
//         return FALSE;
//    }
//
//    pCode->Release();
//	return TRUE;
//}

//inline BOOL CLEEffectFile::SetVertexShader()
//{
//	m_pDev->SetVertexShader(_dwVShader);
//	return  TRUE;
//}
inline BOOL CLEEffectFile::SetTexture(LPCSTR TextureValue, LPDIRECT3DTEXTURE8 pTexture)
{
    if(FAILED(m_pEffect->SetTexture(TextureValue,pTexture)))
		return FALSE;
	return TRUE;
}
inline BOOL CLEEffectFile::SetDword(LPCSTR DwName, DWORD dwvalue)
{
    if(FAILED(m_pEffect->SetDword(DwName,dwvalue)))
		return FALSE;
	return TRUE;
}

inline BOOL CLEEffectFile::Begin(DWORD dwIsSave)
{
    if(FAILED(m_pEffect->Begin(&m_passes,dwIsSave)))
		return FALSE;
	return TRUE;
}

inline BOOL CLEEffectFile::Pass(UINT ipass = 0)
{
    if(FAILED(m_pEffect->Pass(ipass)))
		return FALSE;
	return TRUE;
}
inline BOOL CLEEffectFile::End()
{
	//m_pEffect->Pass(1);

    if(FAILED(m_pEffect->End()))
		return FALSE;

	return TRUE;
}

#endif // !defined(AFX_DXEFFECTFILE_H__F7B73B81_55EE_11BD_AC67_0008C720ECD1__INCLUDED_)
