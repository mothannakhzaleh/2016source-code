#include "stdafx.h"
#include "LESkyBox.h"

const int CLESkyBox::NUMFACES = 6;

CLESkyBox::CLESkyBox()
{
	for (int q=0; q < NUMFACES; q++) {
		m_Texture[q] = NULL;
	}
	m_fSize = 1.0f;
}

CLESkyBox::~CLESkyBox()
{
	InvalidateDeviceObjects();
}

HRESULT CLESkyBox::RestoreDeviceObjects(LPDIRECT3DDEVICE8 pDev, 
										const char *szTopTextureFilename,
										const char *szBottomTextureFilename,
										const char *szFrontTextureFilename,
										const char *szBackTextureFilename,
										const char *szLeftTextureFilename,
										const char *szRightTextureFilename)
{
	HRESULT hr;
	m_pd3dDevice = pDev;

	// create textures

	if (FAILED(hr = D3DXCreateTextureFromFileEx(m_pd3dDevice, 
		szTopTextureFilename, D3DX_DEFAULT, D3DX_DEFAULT, 1, 0, D3DFMT_UNKNOWN,
		D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT, 0, NULL, NULL, &m_Texture[Top]))) {
			return(hr);
	}

	if (FAILED(hr = D3DXCreateTextureFromFileEx(m_pd3dDevice, 
		szBottomTextureFilename, D3DX_DEFAULT, D3DX_DEFAULT, 1, 0, D3DFMT_UNKNOWN,
		D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT, 0, NULL, NULL, &m_Texture[Bottom]))) {
			return(hr);
	}

	if (FAILED(hr = D3DXCreateTextureFromFileEx(m_pd3dDevice, 
		szLeftTextureFilename, D3DX_DEFAULT, D3DX_DEFAULT, 1, 0, D3DFMT_UNKNOWN,
		D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT, 0, NULL, NULL, &m_Texture[Left]))) {
			return(hr);
	}

	if (FAILED(hr = D3DXCreateTextureFromFileEx(m_pd3dDevice, 
		szRightTextureFilename, D3DX_DEFAULT, D3DX_DEFAULT, 1, 0, D3DFMT_UNKNOWN,
		D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT, 0, NULL, NULL, &m_Texture[Right]))) {
			return(hr);
	}

	if (FAILED(hr = D3DXCreateTextureFromFileEx(m_pd3dDevice, 
		szFrontTextureFilename, D3DX_DEFAULT, D3DX_DEFAULT, 1, 0, D3DFMT_UNKNOWN,
		D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT, 0, NULL, NULL, &m_Texture[Front]))) {
			return(hr);
	}

	if (FAILED(hr = D3DXCreateTextureFromFileEx(m_pd3dDevice, 
		szBackTextureFilename, D3DX_DEFAULT, D3DX_DEFAULT, 1, 0, D3DFMT_UNKNOWN,
		D3DPOOL_MANAGED, D3DX_DEFAULT, D3DX_DEFAULT, 0, NULL, NULL, &m_Texture[Back]))) {
			return(hr);
	}

	return S_OK;
}

void CLESkyBox::InvalidateDeviceObjects()
{
	for (int q=0; q < NUMFACES; q++) {
		SAFE_RELEASE(m_Texture[q]);
	}
}

void CLESkyBox::DeleteDeviceObjects()
{
}

void CLESkyBox::Render(D3DXMATRIX &matView)
{
	float f;
	VERTEX_XYZ_DIFFUSE_TEX1 vert[4];

 	D3DXMATRIX matOld;
 	m_pd3dDevice->GetTransform(D3DTS_VIEW, &matOld);

	D3DXMATRIX mat = matView;
//	mat._41 = mat._42 = mat._43 = 0.0f;
 	m_pd3dDevice->SetTransform(D3DTS_VIEW, &mat);

	D3DSURFACE_DESC desc;
	m_Texture[Front]->GetLevelDesc(0, &desc);

	f = 1.0f / (float)(desc.Width);

	vert[0].tu = 0.0f + f; vert[0].tv = 0.0f + f;
	vert[1].tu = 0.0f + f; vert[1].tv = 1.0f - f;
	vert[2].tu = 1.0f - f; vert[2].tv = 0.0f + f;
	vert[3].tu = 1.0f - f; vert[3].tv = 1.0f - f;

//	DWORD dwOldVS;
//	m_pd3dDevice->GetVertexShader(&dwOldVS);

	m_pd3dDevice->SetVertexShader(D3DFVF_XYZ_DIFFUSE_TEX1);
	f = m_fSize * 10000.0f;

	float y = f * 0.9f;

	DWORD	oldState;
	m_pd3dDevice->GetTextureStageState(0, D3DTSS_COLOROP, &oldState);
	m_pd3dDevice->SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE );
	m_pd3dDevice->SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1 );
	m_pd3dDevice->SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR );
	m_pd3dDevice->SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR );

	// left (negative x)
	vert[0].position = D3DXVECTOR3(-f, -f,  f + y);
	vert[1].position = D3DXVECTOR3(-f, -f, -f + y);
	vert[2].position = D3DXVECTOR3(-f,  f,  f + y);
	vert[3].position = D3DXVECTOR3(-f,  f, -f + y);

	m_pd3dDevice->SetTexture(0, m_Texture[Left]);
	m_pd3dDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, (LPVOID) vert, sizeof(VERTEX_XYZ_DIFFUSE_TEX1));


	// right (positive x)
	vert[0].position = D3DXVECTOR3( f,  f,  f + y);
	vert[1].position = D3DXVECTOR3( f,  f, -f + y);
	vert[2].position = D3DXVECTOR3( f, -f,  f + y);
	vert[3].position = D3DXVECTOR3( f, -f, -f + y);

	m_pd3dDevice->SetTexture(0, m_Texture[Right]);
	m_pd3dDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, (LPVOID) vert, sizeof(VERTEX_XYZ_DIFFUSE_TEX1));


	// back (negative y)
	vert[0].position = D3DXVECTOR3( f, -f,  f + y);
	vert[1].position = D3DXVECTOR3( f, -f, -f + y);
	vert[2].position = D3DXVECTOR3(-f, -f,  f + y);
	vert[3].position = D3DXVECTOR3(-f, -f, -f + y);

	m_pd3dDevice->SetTexture(0, m_Texture[Back]);
	m_pd3dDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, (LPVOID) vert, sizeof(VERTEX_XYZ_DIFFUSE_TEX1));


	// front (positive y)
	vert[0].position = D3DXVECTOR3(-f,  f,  f + y);
	vert[1].position = D3DXVECTOR3(-f,  f, -f + y);
	vert[2].position = D3DXVECTOR3( f,  f,  f + y);
	vert[3].position = D3DXVECTOR3( f,  f, -f + y);

	m_pd3dDevice->SetTexture(0, m_Texture[Front]);
	m_pd3dDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, (LPVOID) vert, sizeof(VERTEX_XYZ_DIFFUSE_TEX1));

	// bottom (negative z)
	vert[0].position = D3DXVECTOR3(-f,  f, -f + y);
	vert[1].position = D3DXVECTOR3(-f, -f, -f + y);
	vert[2].position = D3DXVECTOR3( f,  f, -f + y);
	vert[3].position = D3DXVECTOR3( f, -f, -f + y);

	m_pd3dDevice->SetTexture(0, m_Texture[Bottom]);
	m_pd3dDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, (LPVOID) vert, sizeof(VERTEX_XYZ_DIFFUSE_TEX1));

	// Top (positive z)
	vert[0].position = D3DXVECTOR3(-f,  f,  f + y);
	vert[1].position = D3DXVECTOR3(-f, -f,  f + y);
	vert[2].position = D3DXVECTOR3( f,  f,  f + y);
	vert[3].position = D3DXVECTOR3( f, -f,  f + y);

	m_pd3dDevice->SetTexture(0, m_Texture[Top]);
	m_pd3dDevice->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, (LPVOID) vert, sizeof(VERTEX_XYZ_DIFFUSE_TEX1));
	m_pd3dDevice->SetTextureStageState(0, D3DTSS_COLOROP, oldState );
	m_pd3dDevice->SetTransform(D3DTS_VIEW, &matOld);
}

