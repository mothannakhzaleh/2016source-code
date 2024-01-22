#include "GlobalInc.h"

typedef struct 
{
	D3DXVECTOR3 position; // ×ø±ê
	D3DCOLOR    color;    // ÑÕÉ«
	FLOAT       tu, tv;   // ÌùÍ¼×ø±ê
} VERTEX_XYZ_DIFFUSE_TEX1;

#define D3DFVF_XYZ_DIFFUSE_TEX1 (D3DFVF_XYZ|D3DFVF_DIFFUSE|D3DFVF_TEX1)

class LIGHTENGINE_API CLESkyBox
{
public:

	static const int NUMFACES;

	CLESkyBox();
	~CLESkyBox();

	HRESULT RestoreDeviceObjects(
		LPDIRECT3DDEVICE8 pDev, 
		const char *szTopTextureFilename,
		const char *szBottomTextureFilename,
		const char *szFrontTextureFilename,
		const char *szBackTextureFilename,
		const char *szLeftTextureFilename,
		const char *szRightTextureFilename);

	void InvalidateDeviceObjects();
	void DeleteDeviceObjects();

	enum BoxFace {
		Top = 0,
		Bottom,
		Left,
		Right,
		Front,
		Back
	};

	LPDIRECT3DTEXTURE8 GetTexture(BoxFace face) { return(m_Texture[face]); }

	void Render(D3DXMATRIX &matView);

	float GetSize(void) const { return(m_fSize); }
	void SetSize(const float data) { m_fSize = data; }

private:
	float m_fSize;
	LPDIRECT3DDEVICE8 m_pd3dDevice;
	LPDIRECT3DTEXTURE8 m_Texture[6];
};