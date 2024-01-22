#ifndef _HEIGHTMAP_
#define _HEIGHTMAP_

#include "Frustum.h"
#include "StdHeader.h"

#define HEIGHT_MAP_SCALE	1
#define WORLD_TO_HEIGHT		1	// 1/10
#define WORLD_TO_MOVE		0.25f	// 1/10/4
#define HEIGHT_TO_MOVE		0.25f	// 1/4
#define MOVE_TO_WORLD		4		// 1/4

class LEMap;
struct SNewFileTile;
class LIGHTENGINE_API CHeightmap
{
public:
	CHeightmap();
	~CHeightmap();
	void	Release(void);

	bool	LoadHeightmap(LEMap* pMap);
	bool	LoadHeightmap(char* szFilename, int iSize);
	bool	SaveHeightmap(char* szFilename);
	bool	SaveLightmap(char* szFilename);
	bool	UnLoadHeightmap(void);
	void	UpdateHeightmap(void);

	void	Render(void);

	float   GetHeight(D3DXVECTOR3 *checked);
	float   GetHeight(float Worldxpos, float Worldzpos);
	int		GetHeightIndex(int movemapX, int movemapZ);
	int		GetHeightIndexOffset(int index, char offsetZ, char offsetX);

	POINT	ConvertToHeightmap(D3DXVECTOR3 *pos);
	POINT   ConvertToMovemap(D3DXVECTOR3 pos);
	D3DXVECTOR3  ConvertToWorld(int movemapXPos, int movemapZPos);

	void	UpdateFrustum(D3DXVECTOR3* pEyePos, D3DXVECTOR3* pViewDir);
	bool    IsInFrustum(D3DXVECTOR3 *checked);
	bool    IsInFrustum(float x, float z);
	bool    IsInFrustum(Boundary_3D *pBoundary);

	char	GetHeight(int nWorldX, int nWorldY);
	char	operator[](int index) const;
	DWORD   GetColor(int nWorldX, int nWorldY);
	DWORD   GetColorByIndex(int index) { return GetColor(index/m_SizeX, index%m_SizeX); }
	void	SetViewPosition(D3DXVECTOR3 viewpos);
	void	SetViewRotateY(float angle);
	float	GetYPosition(void);

	void	SetViewDistance(int distance);

private:
	void	ComputeDiffuse(D3DXVECTOR3* directionToLight);
	bool	FillVertexBuffer(void);

private:
public:
	LEMap*			m_pMap;
	SNewFileTile*	GetTile(int nWorldX, int nWorldY);
	// 高度数据
//	Height_Data		m_HeightData;
	int				m_SizeX;
	int				m_SizeY;
	
	// 移动图剔除
	Move_Vertex*	m_pMovemap;
	CFrustum		m_Frustum;

	// 光照
//	DWORD*			m_pLightColor;
	HeightmapVertex* m_pVertex;

	// 观察者
	D3DXVECTOR3     m_ViewPos;
	int             m_ViewOffsetX;
	int             m_ViewOffsetZ;
	float           m_ViewRotX;
	float           m_ViewRotY;
	bool			m_bViewerChange;
};

#endif // _HEIGHTMAP_