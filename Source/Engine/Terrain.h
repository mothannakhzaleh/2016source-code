#ifndef _TERRAIN_
#define _TERRAIN_

#include "StdHeader.h"
#define TERRAINVERTEX	20000

class LEMap;
class CTerrain
{
public:
	CTerrain();
	~CTerrain();

	bool	LoadTerrain(LEMap* pMap);
	void	Update(void);
	void	Render(void);

private:
	bool    RenderTile(int x, int y);
	void    DrawLevel_1(int x, int y);
	void    DrawLevel_2(int x, int y);
	void    DrawLevel_3(int x, int y);
	void    DrawLevel_4(int x, int y);
	void    DrawLevel_5(int x, int y);
	void    DrawLevel_6(int x, int y);
	void    DrawLevel_7(int x, int y);

	void	SmoothEdge(void);

	bool	SaveLodmap(char* szFilename, int width, int height);

private:
	LEMap*			m_pMap;
	unsigned char	m_LODmap[256][256];
	unsigned char	GetLODLevel(int z, int x);
	float			TU(int index);
	float			TV(int index);
	// ÌùÍ¼
//	DWORD			m_hBlend[2];
	HeightmapVertex m_BlendVertex[TERRAINVERTEX];
	DWORD			m_BlendIndex;

	HeightmapVertex m_Vertex[TERRAINVERTEX];
	DWORD			m_VertexIndex;

	int				m_numTriangles;

	void			GenerateGroup(int nX, int nY, HeightmapVertex* pV, const float* uv, int nVertexCnt);
	BOOL			_AddRenderGroup(BYTE btLayer, int nTexNo, HeightmapVertex* pV, int nTriangleCnt);
	void			RenderGroup();
	inline HeightmapVertex	CreateVertex(int nMapX, int nMapY, int nMoveX, int nMoveY, float u, float v);
};

#endif // _TERRAIN_