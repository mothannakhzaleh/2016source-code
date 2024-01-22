
#include "StdAfx.h"
#include "GlobalInc.h"

#include "EffectFile.h"
#include "LERender.h"

CLEEffectFile::CLEEffectFile()
{
	m_pEffect = NULL;
	m_pDev = NULL;
	_vecTechniques.clear();
	_iTechNum = 0;
	_dwVShader = 0;
}
#ifdef USE_RENDER
CLEEffectFile::CLEEffectFile(LERender*	 pDev)
#else
CLEEffectFile::CLEEffectFile(LPDIRECT3DDEVICE8 pDev)
#endif
{
    m_pDev = pDev;
    m_pEffect   = NULL;
	_vecTechniques.clear();
	_iTechNum = 0;
	_dwVShader = 0;

}
CLEEffectFile::~CLEEffectFile()
{
	free();
}
#ifdef USE_RENDER
void CLEEffectFile::InitDev(LERender* pDev)
#else
void CLEEffectFile::InitDev(LPDIRECT3DDEVICE8 pDev)
#endif
{
    m_pDev = pDev;
}

#ifdef __MEM_DEBUG__
extern long g_nDontCare;
#endif
BOOL CLEEffectFile::LoadEffectFromFile( LPCSTR pszfile)
{
	HRESULT hr;
#ifdef __MEM_DEBUG__
	InterlockedIncrement(&g_nDontCare);
#endif
#ifdef USE_RENDER
	if(FAILED( hr = D3DXCreateEffectFromFile(m_pDev->GetDevice(),pszfile,&m_pEffect,NULL)))
#else
	if(FAILED( hr = D3DXCreateEffectFromFile(m_pDev,pszfile,&m_pEffect,NULL)))
#endif
	{
#ifdef __MEM_DEBUG__
		InterlockedDecrement(&g_nDontCare);
#endif
		return FALSE;
	}
#ifdef __MEM_DEBUG__
	InterlockedDecrement(&g_nDontCare);
#endif

	D3DXTECHNIQUE_DESC   technique;

	char t_psz[4];
	strncpy_s(t_psz, "t0", _TRUNCATE);
	while(SUCCEEDED(m_pEffect->FindNextValidTechnique(t_psz, &technique)))
	{
		_vecTechniques.push_back(technique);
		_iTechNum++;

		_snprintf_s(t_psz,4,_TRUNCATE,"t%d",_iTechNum);
	}
	return TRUE;
}

void CLEEffectFile::free()
{
	SAFE_RELEASE(m_pEffect);
	_vecTechniques.clear();
	_iTechNum = 0;
	_dwVShader = 0;
}

BOOL CLEEffectFile::OnLostDevice()
{
    if(m_pEffect)
	{
		if(FAILED(m_pEffect->OnLostDevice()))
			return FALSE;
	}
	return TRUE;
}

BOOL CLEEffectFile::OnResetDevice()
{
    if(m_pEffect)
	{
		if(FAILED(m_pEffect->OnResetDevice()))
			return FALSE;
	}
	return TRUE;
}
#ifdef USE_RENDER
LERender*	CLEEffectFile::GetDev()
#else
LPDIRECT3DDEVICE8	CLEEffectFile::GetDev()
#endif
{
	return m_pDev;
}

