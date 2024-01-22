#include "StdAfx.h"
#include "Terrain.h"
#include "Heightmap.h"
#include "LERender.h"
#include "TextureManager.h"
#include "LETile.h"
#include "LEMapDef.h"
#include "drgraphicsutil.h"
#include "LETextureSet.h"
#include "LETerrainSet.h"
#include "LEMap.h"
#include "d3dutil.h"

LIGHTENGINE_API CHeightmap g_Hmap;
LIGHTENGINE_API bool g_bLineMode = false;
LIGHTENGINE_API int g_nNoDrawLevel = 0;
#define WORLD_SCALE 1.0f

drColorValue4b	s_Ambient; //环境光
extern float AlphaNo2UV[16][2];
#define MAX_RENDER_TRIANGLE	 12000
#define MAX_RENDER_GROUP 80
struct SVertexGroup
{
	int   nTriangleCnt;
	BYTE  btTextureID;
	HeightmapVertex pV[MAX_RENDER_TRIANGLE*3];
	SVertexGroup(): btTextureID(0), nTriangleCnt(0){}
};
static SVertexGroup VertexGroup[4][MAX_RENDER_GROUP];

HeightmapVertex::HeightmapVertex(float fx, float fy, float fz, DWORD dwcolor, float fu, float fv)
{
	x = fx; y = fy; z = fz;
	color = dwcolor;
	u1 = fu;
	v1 = fv;
	u2 = u1;
	v2 = v1;
}

void HeightmapVertex::SetupVertex(int nMapX, int nMapY, int nMoveX, int nMoveY, int ofsX, int ofsY)
{
	SNewFileTile* pFileTile = g_Hmap.GetTile(nMapX+ofsX, nMapY+ofsY);
	x = (nMoveX+ofsX)*WORLD_SCALE;
	y = (nMoveY+ofsY)*WORLD_SCALE;

	if( pFileTile && pFileTile->btTileInfo ) //如果第一层没地表，不用设定贴图纹理坐标
	{
		drColorValue4b vert_amb, c;
		c.color = pFileTile ? (DR_RGB565TODWORD(pFileTile->sColor)|0xff000000) : 0;
		vert_amb.a = (s_Ambient.a * c.a) >>8;
		vert_amb.r = (s_Ambient.r * c.r) >>8;
		vert_amb.g = (s_Ambient.g * c.g) >>8;
		vert_amb.b = (s_Ambient.b * c.b) >>8;
		color = vert_amb.color;
		z = pFileTile ? (pFileTile->cHeight * 0.1f) : -12.7f;

		u1 = ((nMapX & 0x03) + ofsX) * .25f;
		v1 = ((nMapY & 0x03) + ofsY) * .25f;
	}
	else
	{
		color = 0;
		z = -12.7f;
		u1 = v1 = 0.0f;
	}
}

CTerrain::CTerrain()
{
	m_pMap = NULL;
	m_numTriangles = 0;
}

CTerrain::~CTerrain()
{
	if(g_pTextureManager == NULL)	return;
	
// 	for(int i=0; i<2; i++)
// 	{
// 		g_pTextureManager->ReleaseTexture(m_hBlend[i]);
// 	}
}

bool CTerrain::LoadTerrain(LEMap* pMap)
{
	m_pMap = pMap;
	// height map
	g_Hmap.LoadHeightmap(pMap);
//	g_Hmap.LoadHeightmap("Picture\\Hightmap256.raw", 256);
//	g_Hmap.LoadHeightmap("Picture\\garner4096.raw", 4096);
	// LOD
	FILE* fp = NULL;
	if( fopen_s(&fp, "Picture\\lodmap.lod", "rb")!=0 )
	{
		return false;
	}
	for(int z=MOVE_MAP_SIZE-1; z>=0; z--)
	{
		for(int x=0; x<MOVE_MAP_SIZE; x++)
		{
			fread(&m_LODmap[z][x], sizeof(unsigned char), 1, fp);
		}
	}
	fclose(fp);

	// Texture
// 	m_hBlend[0] = g_pTextureManager->LoadTexture("Picture\\Tile_1.tga", MM_KEEPINMEMORY, 0);
// 	m_hBlend[1] = g_pTextureManager->LoadTexture("Picture\\Tile_2.tga", MM_KEEPINMEMORY, 0);

	return true;
}

bool CTerrain::SaveLodmap(char* szFilename, int width, int height)
{
	if(szFilename == NULL || szFilename[0]==0)
		return false;

	FILE* pFile = NULL;
	if( fopen_s(&pFile, szFilename, "wb")!=0 )
		return false;

	//存成BLE格式
	BITMAPFILEHEADER	bmf;
	BITMAPINFOHEADER	bmi;
	int					headsize = sizeof(bmf) + sizeof(bmi);
	int					pitch = width * 3;
	bmf.bfType = 'MB';
	bmf.bfSize = headsize + pitch * height;
	bmf.bfReserved1 = bmf.bfReserved2 = 0;
	bmf.bfOffBits = headsize;
	bmi.biSize = sizeof( bmi );
	bmi.biWidth = width;
	bmi.biHeight = height;
	bmi.biPlanes = 1;
	bmi.biBitCount = 24;
	bmi.biCompression = BI_RGB;
	bmi.biSizeImage = pitch * height;
	bmi.biXPelsPerMeter = 72;
	bmi.biYPelsPerMeter = 72;
	bmi.biClrUsed = 0;
	bmi.biClrImportant = 0;
	fwrite(&bmf, sizeof(bmf), 1, pFile);
	fwrite(&bmi, sizeof(bmi), 1, pFile);
	LPBYTE pBits  = new BYTE[ bmi.biSizeImage ];
	int trg = 0;
	int src = 0;
	
	for(int y=0; y<height; y++)
	{
		for(int x=0; x<width; x++)
		{
			switch(m_LODmap[y][x])
			{      //Blue             //Green            //Red
			case 0: pBits[trg] = 0;   pBits[trg+1] = 0;   pBits[trg+2] = 0;   break; //黑
			case 1: pBits[trg] = 0;   pBits[trg+1] = 0;   pBits[trg+2] = 255; break; //红
			case 2: pBits[trg] = 0;   pBits[trg+1] = 165; pBits[trg+2] = 255; break; //橙
			case 3: pBits[trg] = 0;   pBits[trg+1] = 255; pBits[trg+2] = 255; break; //黄
			case 4: pBits[trg] = 0;   pBits[trg+1] = 255; pBits[trg+2] = 0;   break; //绿
			case 5: pBits[trg] = 255; pBits[trg+1] = 127; pBits[trg+2] = 0;   break; //蓝
			case 6: pBits[trg] = 255; pBits[trg+1] = 0;   pBits[trg+2] = 0;   break; //靛
			case 7: pBits[trg] = 255; pBits[trg+1] = 0;   pBits[trg+2] = 139; break; //紫
			default:pBits[trg] = 255; pBits[trg+1] = 255; pBits[trg+2] = 255; break; //白
			}
			trg += 3;
		}
	}
	fwrite(pBits, bmi.biSizeImage, 1, pFile);
	fclose(pFile);
	delete [] pBits;
	return true;
}

void CTerrain::SmoothEdge(void)
{
// 	for(int z=0; z<256; z++)
// 	{
// 		g_Hmap[z*256+255] = (g_Hmap[z*256+254]+
// 			g_Hmap[z*256+0])/2;
// 	}
// 	for(int x=0; x<256; x++)
// 	{
// 		g_Hmap[255*256+x] = (g_Hmap[254*256+x]+
// 			g_Hmap[0*256+x])/2;
// 	}
// 	g_Hmap.SaveHeightmap("Picture\\Hightmap256.raw");
}

void CTerrain::Update()
{
}

LIGHTENGINE_API int g_nPosX = 0;
LIGHTENGINE_API int g_nPosY = 0;
LIGHTENGINE_API int g_nPosZ = 0;
LIGHTENGINE_API DWORD g_dwRenderTerrainTime = 0;
LIGHTENGINE_API DWORD g_dwRenderTerrainCnt = 0;
void CTerrain::Render()
{
	LETimer t; t.Begin();
	if(g_Render.GetDevice())
	{
		D3DXMATRIXA16 matWorld;
		D3DXMatrixTranslation(&matWorld, (float)(g_Hmap.m_ViewOffsetX), (float)(g_Hmap.m_ViewOffsetZ), 0 );
 		D3DXMATRIXA16 matRotate;
 		D3DXMatrixRotationX(&matRotate, g_nTemp * 0.1f * D3DX_PI);
		D3DXMATRIXA16 matTrans;
 		D3DXMatrixTranslation(&matTrans, 0.0f, 0.0f, g_nPosZ * 0.1f);
 		matWorld = matRotate * matWorld * matTrans;
 		g_Render.GetDevice()->SetTransform(D3DTS_WORLD, &matWorld);

		// Enable fog blending.
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGENABLE, TRUE);
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGCOLOR, 0x00a4a4a4); // Set the fog color.
		//g_Render.GetDevice()->SetRenderState(D3DRS_FOGVERTEXMODE, D3DFOG_LINEAR); // Set fog parameters.
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGSTART, 30.0f);
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGEND,   3000.0f);
		g_Render.GetDevice()->SetRenderState(D3DRS_RANGEFOGENABLE, FALSE);

		g_Render.GetDevice()->SetRenderState(D3DRS_FOGVERTEXMODE, D3DFOG_EXP2);
		g_Render.GetDevice()->SetRenderState(D3DRS_ZWRITEENABLE, TRUE);


		static float fog_density = 0.01f;
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGDENSITY, *(DWORD*)&fog_density);



//		g_Render.SetRenderState(D3DRS_CLIPPING, TRUE);
//		g_Render.SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
		g_Render.SetRenderState(D3DRS_SRCBLEND,  D3DBLEND_SRCALPHA);	 // blend the colors based on the
		g_Render.SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA);	 // alpha value
		g_Render.SetRenderState(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);
		g_Render.SetRenderState(D3DRS_DITHERENABLE, FALSE);
		g_Render.SetRenderState(D3DRS_COLORVERTEX, TRUE);
		g_Render.EnableZBuffer(TRUE);
		g_Render.SetRenderState( D3DRS_LIGHTING, m_pMap->_bEnableNormalLight );

		D3DMATERIAL8 material;
		D3DUtil_InitMaterial( material, 1.0f, 1.0f, 1.0f, 1.0f);
		material.Ambient.r = 0.80f;
		material.Ambient.g = 0.80f;
		material.Ambient.b = 0.80f;
		material.Ambient.a = 1.0f;
		g_Render.GetDevice()->SetMaterial(&material);

		g_Render.SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW); // 单面渲染

		//地表
		g_Render.SetTextureStageState(0, D3DTSS_COLOROP,   D3DTOP_MODULATE);  
		g_Render.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE); 
		g_Render.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);

		g_Render.SetTextureStageState(0, D3DTSS_ALPHAOP,   D3DTOP_SELECTARG1);
		g_Render.SetTextureStageState(0, D3DTSS_ALPHAARG1, D3DTA_TEXTURE); 

		g_Render.SetTextureStageState(0, D3DTSS_ADDRESSU, D3DTADDRESS_WRAP);
		g_Render.SetTextureStageState(0, D3DTSS_ADDRESSV, D3DTADDRESS_WRAP);
		g_Render.SetTextureStageState(0, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);		
		g_Render.SetTextureStageState(0, D3DTSS_MINFILTER, D3DTEXF_LINEAR);
		g_Render.SetTextureStageState(0, D3DTSS_MIPFILTER, D3DTEXF_LINEAR);

		//柔边用的Alpha图
		g_Render.SetTextureStageState(1, D3DTSS_COLOROP,   D3DTOP_DISABLE);  
		g_Render.SetTextureStageState(1, D3DTSS_COLORARG1, D3DTA_CURRENT);  
		g_Render.SetTextureStageState(1, D3DTSS_COLORARG2, D3DTA_TEXTURE);  

		g_Render.SetTextureStageState(1, D3DTSS_ALPHAOP, D3DTOP_DISABLE);  
		g_Render.SetTextureStageState(1, D3DTSS_ALPHAARG1, D3DTA_CURRENT);
		g_Render.SetTextureStageState(1, D3DTSS_ALPHAARG2, D3DTA_TEXTURE);

		g_Render.SetTextureStageState(1, D3DTSS_ADDRESSU, D3DTADDRESS_MIRROR);
		g_Render.SetTextureStageState(1, D3DTSS_ADDRESSV, D3DTADDRESS_MIRROR);
		g_Render.SetTextureStageState(1, D3DTSS_MAGFILTER, D3DTEXF_LINEAR);		
		g_Render.SetTextureStageState(1, D3DTSS_MINFILTER, D3DTEXF_LINEAR);
		g_Render.SetTextureStageState(1, D3DTSS_MIPFILTER, D3DTEXF_LINEAR);

		//只用2层贴图Stage
		g_Render.SetTextureStageState(2, D3DTSS_COLOROP, D3DTOP_DISABLE);  
		g_Render.SetTextureStageState(2, D3DTSS_ALPHAOP, D3DTOP_DISABLE);  

		g_Render.GetDevice()->SetRenderState(D3DRS_FOGENABLE, TRUE);
		g_Render.GetDevice()->GetRenderState(D3DRS_AMBIENT, &s_Ambient.color);

		g_Render.GetDevice()->SetFVF(HeightmapVertex::FVF);
		if(g_bLineMode)
		{
			g_Render.GetDevice()->SetRenderState(D3DRS_FILLMODE, D3DFILL_WIREFRAME);
			g_Render.GetDevice()->SetRenderState(D3DRS_CULLMODE, D3DCULL_NONE);
		}

		int min = g_Hmap.m_Frustum.m_minZ;
		int max = g_Hmap.m_Frustum.m_maxZ;
		m_numTriangles = 0;
		int numArea = 0;
		if(g_Hmap.m_bViewerChange)
		{
			m_BlendIndex = 0;
			m_VertexIndex = 0;
		}

		for(int layer=0; layer<4; layer++)
		{
			for(int i=0; i<MAX_RENDER_GROUP; i++)
			{
				VertexGroup[layer][i].btTextureID = 0;
				VertexGroup[layer][i].nTriangleCnt = 0;
			}
		}

		//---------------------------------------------------
		// 地形Render
		// (优化前: 资源消耗7.9ms-8.3ms)
		// (优化后: 资源消耗3.6ms-4.7ms)
		//---------------------------------------------------
		for(int z=(g_Hmap.m_Frustum.m_pos[min].y); z<=(g_Hmap.m_Frustum.m_pos[max].y); z++)
		{
			if( z>=MOVE_MAP_SIZE )
				break;
			for(int x=(g_Hmap.m_Frustum.m_LeftArray[z]); x<=(g_Hmap.m_Frustum.m_RightArray[z]); x++)
			{
				if(RenderTile(x, z))
					numArea++;
			}
		}
		RenderGroup();
		if(m_BlendIndex>TERRAINVERTEX)
		{
			WriteLog(INFO_ERROR, "Terrain Vertex Error!");
		}
		g_Render.GetDevice()->DrawPrimitiveUP(D3DPT_TRIANGLELIST, m_BlendIndex/3, m_BlendVertex, sizeof(HeightmapVertex));

		if(g_bLineMode)
			g_Render.GetDevice()->SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGENABLE, FALSE);

		g_Render.GetDevice()->SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_MODULATE);
		g_Render.GetDevice()->SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
		g_Render.GetDevice()->SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);
		g_Render.GetDevice()->SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
		g_Render.GetDevice()->SetTextureStageState(1, D3DTSS_COLOROP, D3DTOP_DISABLE);
		g_Render.GetDevice()->SetTextureStageState(1, D3DTSS_ALPHAOP, D3DTOP_DISABLE);
		g_Render.GetDevice()->SetTexture(1, NULL);
		g_Render.EnableAlpha(TRUE);

	//	DrawSingleLine(0, 100, 0xffffffff, false, "number of triangles: %d, AREA: %d", m_numTriangles, numArea);
	//	DrawSingleLine(0, 100, 0xffffffff, false, "m_Index: %d", m_BlendIndex);
	}
	g_dwRenderTerrainTime += t.End();
	g_dwRenderTerrainCnt ++;
}

bool CTerrain::RenderTile(int x, int z)
{ 
	unsigned char level = GetLODLevel(z,x);
	if(level==0) 
	{
		return false;
	}
	
	if(level == 7)
	{
		if( g_nNoDrawLevel!=level )
			DrawLevel_7(x, z);	
	}
 	else if(level == 6)
	{
		if( g_nNoDrawLevel!=level )
	 		DrawLevel_6(x, z);	
 	}
 	else if(level == 5)
 	{
 		if( g_nNoDrawLevel!=level )
 			DrawLevel_5(x, z);	
 	}
 	else if(level == 4)
 	{
 		if( g_nNoDrawLevel!=level )
 			DrawLevel_4(x, z);
 	}
 	else if(level == 3)
 	{
 		if( g_nNoDrawLevel!=level )
 			DrawLevel_3(x, z);
	}
 	else if(level == 2)
 	{
 		if( g_nNoDrawLevel!=level )
			DrawLevel_2(x, z);
 	}
	else if(level == 1)		
	{
		if( g_nNoDrawLevel!=level )
			DrawLevel_1(x, z);
	}
	// LOD5 & LOD7 渲染格子最多
	if(level == 4 || level == 6)
		return true;
	else
		return false;
		
}

float CTerrain::TU(int index)
{
	return ((index%g_Hmap.m_SizeX)%4) * 0.25f;
}

float CTerrain::TV(int index)
{
	return ((g_Hmap.m_SizeY - (index/g_Hmap.m_SizeX) - 1)%4) * 0.25f;
}

inline HeightmapVertex CTerrain::CreateVertex(int nMapX, int nMapY, int x, int y, float u, float v)
{
	drColorValue4b vert_amb, c;
	SNewFileTile* pFileTile = g_Hmap.GetTile(nMapX, nMapY);
	c.color = pFileTile ? (DR_RGB565TODWORD(pFileTile->sColor)|0xff000000) : 0;
	vert_amb.a = (s_Ambient.a * c.a) / 255;
	vert_amb.r = (s_Ambient.r * c.r) / 255;
	vert_amb.g = (s_Ambient.g * c.g) / 255;
	vert_amb.b = (s_Ambient.b * c.b) / 255;

	HeightmapVertex hmv;
	hmv.color = vert_amb.color;
	hmv.z = pFileTile ? (pFileTile->cHeight * 0.1f) : -12.7f;
	hmv.x = x*WORLD_SCALE;
	hmv.y = y*WORLD_SCALE;
	hmv.u1 = u;
	hmv.v1 = v;
	return hmv;
}

void CTerrain::GenerateGroup(int nX, int nY, HeightmapVertex* pV, const float* uv, int nVertexCnt)
{
	SNewFileTile* pFileTile = g_Hmap.GetTile(nX, nY);
	if( pFileTile )
	{
		LETile mpTile;
		mpTile.Init();
		TileInfo_5To8(pFileTile->dwTileInfo, pFileTile->btTileInfo, (BYTE*)(&mpTile.TexLayer[0]));

		for(int layer = 0; layer < 4; layer++)
		{
			LETileTex *pLayer = &(mpTile.TexLayer[layer]);

			if(pLayer->btTexNo==0) break;
			if(pLayer->btAlphaNo==0) continue;

			if( layer )
			{
				float fU1 = AlphaNo2UV[pLayer->btAlphaNo][0];
				float fV1 = AlphaNo2UV[pLayer->btAlphaNo][1];
				for(int i=0, n=0; i<nVertexCnt; i++)
				{
					pV[i].u2 = fU1 + uv[n++];
					pV[i].v2 = fV1 + uv[n++];
				}
			}
			_AddRenderGroup(layer, pLayer->btTexNo, pV, nVertexCnt/3);
		}
	}
}

BOOL CTerrain::_AddRenderGroup(BYTE btLayer, int nTexNo, HeightmapVertex* pV, int nTriangleCnt)
{
	if(nTexNo>=MAX_RENDER_GROUP) 
	{
		LG("error", "msgAddRenderGroup地图贴图索引数超过最大值%d", MAX_RENDER_GROUP);
		return FALSE;
	}
	SVertexGroup *pGroup = &VertexGroup[btLayer][nTexNo];
	if( pGroup->nTriangleCnt>=MAX_RENDER_TRIANGLE )
		return FALSE;

	pGroup->btTextureID = nTexNo;
	memcpy(&pGroup->pV[pGroup->nTriangleCnt*3], pV, sizeof(HeightmapVertex)*nTriangleCnt*3);
	pGroup->nTriangleCnt += nTriangleCnt;
	return TRUE;
}

void CTerrain::RenderGroup()
{
	for(int layer=0; layer<4; layer++)
	{
		if( layer==0 )
		{
			g_Render.SetTexture(1, NULL);
			g_Render.SetTextureStageState(1, D3DTSS_COLOROP,   D3DTOP_DISABLE);
			g_Render.SetTextureStageState(1, D3DTSS_ALPHAOP,   D3DTOP_DISABLE);
			g_Render.EnableAlpha(FALSE);
		}
		else if( layer==1 )
		{
			g_Render.SetTexture(1, GetTextureByID(GetTerrainAlphaTextureID_I()));
			g_Render.SetTextureStageState(1, D3DTSS_COLOROP,   D3DTOP_BLENDDIFFUSEALPHA);
			g_Render.SetTextureStageState(1, D3DTSS_ALPHAOP,   D3DTOP_MODULATE);
			g_Render.EnableAlpha(TRUE);
		}

		for(int j=0; j<MAX_RENDER_GROUP; j++)
		{
			SVertexGroup* pGroup = &VertexGroup[layer][j];
			if( pGroup->btTextureID )
			{
				g_Render.SetTexture(0, GetTextureByID(GetTerrainTextureID(pGroup->btTextureID)));
				g_Render.GetDevice()->DrawPrimitiveUP(D3DPT_TRIANGLELIST, pGroup->nTriangleCnt, pGroup->pV, sizeof(HeightmapVertex));
			}
		}
	}
	g_Render.EnableAlpha(TRUE);
}

#define DefinePos(m,n) \
		index = g_Hmap.GetHeightIndexOffset(index0, -(m), n); \
		nX = index%g_Hmap.m_SizeX; \
		nY = g_Hmap.m_SizeY-(index/g_Hmap.m_SizeX)-1; \
		vX = n+rx; \
		vY = m+rz;

#define DefineVertex(i, tu, tv) pV[i].SetupVertex(nX, nY, vX, vY, tu, tv);


//	0 ─23─7 ─29─ 2
//  │＼│／│＼│／│
//	20─4 ─22─10─28
//  │／│＼│／│＼│
//	5 ─21─6 ─27─11
//  │＼│／│＼│／│
//  24─8 ─26─12─31
//  │／│＼│／│＼│
//  1 ─25─9 ─30─ 3
//----------------------------------------------------
// LOD1(2格与1格的过渡层)
//----------------------------------------------------
void CTerrain::DrawLevel_1(int x, int z)
{
	HeightmapVertex pV[6];
	int rx = (x-128)*4;
	int rz = (z-128)*4 - 1;
	int index0  = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+1);
	int index2 = g_Hmap.GetHeightIndex(x+1, z);
	int index3 = g_Hmap.GetHeightIndex(x+1, z+1);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
		return;

	int index, nX, nY, vX, vY;
	for(int m=0; m<4; m++)
	{
		for(int n=0; n<4; n++)
		{
			BOOL bLod1to2 = FALSE; //LOD1 过渡到 LOD2
			if( n==0 && GetLODLevel(z, x-1)>1 )
			{
				bLod1to2 = TRUE;
				//	0 
				//  │＼
				//	│  4 
				//  │／  
				//	5 
				if( (m%2)==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 0,0); //0 
					DefineVertex(1, 1,1); //4 
					DefineVertex(2, 0,2); //5 
					const float uv[6] = {									
						0.01f,  0.01f,								
						0.24f,  0.125f,                 
						0.01f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}

				switch(m)
				{
				case 0:
					if( GetLODLevel(z-1, x)<=1 )
					{
						//	0 ─23
						//    ＼│
						//	    4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //0 
						DefineVertex(1, 1,0); //23 
						DefineVertex(2, 1,1); //4 
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 1:
					{
						//	    4
						//    ／│
						//	5 ─21
						DefinePos(m, n);
						DefineVertex(0, 1,0); //4 
						DefineVertex(1, 1,1); //21 
						DefineVertex(2, 0,1); //5 
						const float uv[6] = {
							0.24f,  0.01f,
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					{
						//	5 ─21
						//    ＼│
						//      8 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //5 
						DefineVertex(1, 1,0); //21 
						DefineVertex(2, 1,1); //8 
						const float uv[6] = {
							0.01f,  0.01f,
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 3:
					if( GetLODLevel(z+1, x)<=1 )
					{
						//      8 
						//    ／│
						//  1 ─25
						DefinePos(m, n);
						DefineVertex(0, 1,0); //8 
						DefineVertex(1, 1,1); //25 
						DefineVertex(2, 0,1); //1 
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( m==0 && GetLODLevel(z-1, x)>1 )
			{
				bLod1to2 = TRUE;
				//	0 ───7
				//    ＼  ／
				//	    4 
				if( (n%2)==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 1,1); //4 
					DefineVertex(1, 0,0); //0 
					DefineVertex(2, 2,0); //7 
					const float uv[6] = { 
						0.125f, 0.24f,
						0.01f,  0.01f,
						0.24f,  0.01f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}

				switch(n)
				{
				case 0:
					if( GetLODLevel(z, x-1)<=1 )
					{
						//	0  
						//  │＼ 
						//	20─4 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //0 
						DefineVertex(1, 1,1); //4 
						DefineVertex(2, 0,1); //20
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 1:
					{
						//	    7
						//    ／│
						//	4 ─22
						DefinePos(m, n);
						DefineVertex(0, 0,1); //4 
						DefineVertex(1, 1,0); //7
						DefineVertex(2, 1,1); //22 
						const float uv[6] = {
							0.01f,  0.24f,
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					{
						//	7
						//  │＼
						//	22─10
						DefinePos(m, n);
						DefineVertex(0, 0,0); //7
						DefineVertex(1, 1,1); //10 
						DefineVertex(2, 0,1); //22 
						const float uv[6] = {
							0.01f,  0.01f,
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 3:
					if( GetLODLevel(z, x+1)<=1 )
					{
						//      2 
						//    ／│
						//  10─28
						DefinePos(m, n);
						DefineVertex(0, 1,0); //2 
						DefineVertex(1, 1,1); //28 
						DefineVertex(2, 0,1); //10
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( m==3 && GetLODLevel(z+1, x)>1 )
			{
				bLod1to2 = TRUE;
				//      8 
				//    ／  ＼
				//  1 ───9 
				if( (n%2)==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 1,0); //8 
					DefineVertex(1, 2,1); //9 
					DefineVertex(2, 0,1); //1 
					const float uv[6] = { 
						0.125f, 0.01f, 
						0.24f,  0.24f,
						0.01f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}
				switch(n)
				{
				case 0:
					if( GetLODLevel(z, x-1)<=1 )
					{
						//  24─8
						//  │／
						//  1 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //24 
						DefineVertex(1, 1,0); //8 
						DefineVertex(2, 0,1); //1
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 1:
					{
						//  8 ─26
						//    ＼│
						//      9 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //8 
						DefineVertex(1, 1,0); //26
						DefineVertex(2, 1,1); //9
						const float uv[6] = {
							0.01f,  0.01f,
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					{
						//  26─12
						//  │／
						//  9 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //26
						DefineVertex(1, 1,0); //12 
						DefineVertex(2, 0,1); //9 
						const float uv[6] = {
							0.01f,  0.01f,
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 3:
					if( GetLODLevel(z, x+1)<=1 )
					{
						//  12─31
						//    ＼│
						//      3
						DefinePos(m, n);
						DefineVertex(0, 0,0); //12 
						DefineVertex(1, 1,0); //31 
						DefineVertex(2, 1,1); //3
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( n==3 && GetLODLevel(z, x+1)>1 )
			{
				bLod1to2 = TRUE;
				//        2
				//      ／│
				//    10  │
				//      ＼│
				 //       11
				if( (m%2)==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 0,1); //10
					DefineVertex(1, 1,0); //2
					DefineVertex(2, 1,2); //11 
					const float uv[6] = {									  
						0.01f,  0.125f,							     
						0.24f,  0.01f,				      
						0.24f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}
				switch(m)
				{
				case 0:
					if( GetLODLevel(z-1, x)<=1 )
					{
						//	29─ 2
						//  │／
						//	10
						DefinePos(m, n);
						DefineVertex(0, 0,0); //29
						DefineVertex(1, 1,0); //2 
						DefineVertex(2, 0,1); //10 
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 1:
					{
						//	10
						//  │＼
						//	27─11
						DefinePos(m, n);
						DefineVertex(0, 0,0); //10
						DefineVertex(1, 1,1); //11 
						DefineVertex(2, 0,1); //27
						const float uv[6] = {
							0.01f,  0.01f,
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					{
						//	27─11
						//  │／
						//  12
						DefinePos(m, n);
						DefineVertex(0, 0,0); //27
						DefineVertex(1, 1,0); //11 
						DefineVertex(2, 0,1); //12
						const float uv[6] = {
							0.01f,  0.01f,
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 3:
					if( GetLODLevel(z+1, x)<=1 )
					{
						//12
						//│＼
						//30─ 3
						DefinePos(m, n);
						DefineVertex(0, 0,0); //12 
						DefineVertex(1, 1,1); //3
						DefineVertex(2, 0,1); //30
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( !bLod1to2 )
			{
				DefinePos(m, n);
				DefineVertex(0, 0,0);
				DefineVertex(1, 1,0);
				DefineVertex(2, 0,1);
				pV[3] = pV[2];
				pV[4] = pV[1];
				DefineVertex(5, 1,1);

				const float uv[12] = { 
					0.01f,  0.01f,
					0.24f,  0.01f,
					0.01f,  0.24f,
					0.01f,  0.24f,
					0.24f,  0.01f,
					0.24f,  0.24f 
				};
				GenerateGroup(nX, nY, pV, uv, 6);
			}
		}
	}

	m_numTriangles += 24;
}

//	0 ───7 ─── 2
//  │＼  ／│＼  ／│
//	│  4   │  10  │
//  │／  ＼│／  ＼│
//	5 ───6 ───11
//  │＼  ／│＼  ／│
//  │  8   │  12  │
//  │／  ＼│／  ＼│
//  1 ───9 ─── 3
//----------------------------------------------------
// LOD2
//----------------------------------------------------
void CTerrain::DrawLevel_2(int x, int z)
{
	HeightmapVertex pV[6];
	int rx = (x-128)*4;
	int rz = (z-128)*4 - 1;
	int index0  = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+1);
	int index2 = g_Hmap.GetHeightIndex(x+1, z);
	int index3 = g_Hmap.GetHeightIndex(x+1, z+1);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
		return;

	int index, nX, nY, vX, vY;
	for(int m=0; m<4; m+=2)
	{
		for(int n=0; n<4; n+=2)
		{
			//	0 
			//  │＼
			//	│  4 
			//  │／  
			//	5 
			DefinePos(m, n);
			DefineVertex(0, 0,0); //0 
			DefineVertex(1, 1,1); //4 
			DefineVertex(2, 0,2); //5 
			const float uv[6] = { 0.01f,  0.01f,                  
							0.24f,  0.125f,                 
							0.01f,  0.24f };
			GenerateGroup(nX, nY, pV, uv, 3);
		}
	}

	for(int m=0; m<4; m+=2)
	{
		for(int n=0; n<4; n+=2)
		{
			//	0 ───7
			//    ＼  ／
			//	    4 
			DefinePos(m, n);
			DefineVertex(0, 1,1); //4 
			DefineVertex(1, 0,0); //0 
			DefineVertex(2, 2,0); //7 
			const float uv[6] = { 0.125f, 0.24f,
							0.01f,  0.01f,
							0.24f,  0.01f };
			GenerateGroup(nX, nY, pV, uv, 3);
		}
	}

	for(int m=0; m<4; m+=2)
	{
		for(int n=0; n<4; n+=2)
		{
			//      4 
			//    ／  ＼
			//  5 ───6 
			DefinePos(m+1, n);
			DefineVertex(0, 1,0); //4 
			DefineVertex(1, 2,1); //6 
			DefineVertex(2, 0,1); //5 
			const float uv[6] = { 0.125f, 0.01f, 
							0.24f,  0.24f,
							0.01f,  0.24f };
			GenerateGroup(nX, nY, pV, uv, 3);
		}
	}

	for(int m=0; m<4; m+=2)
	{
		for(int n=0; n<4; n+=2)
		{
			//        7
			//      ／│
			//    4   │
			//      ＼│
			//        6
			DefinePos(m, n+1);
			DefineVertex(0, 0,1); //4 
			DefineVertex(1, 1,0); //7 
			DefineVertex(2, 1,2); //6 
			const float uv[6] = { 0.01f,  0.125f,				      
							0.24f,  0.01f,				      
							0.24f,  0.24f };
			GenerateGroup(nX, nY, pV, uv, 3);
		}
	}
	
	m_numTriangles += 16;
}

//	0 ───8 ─── 2
//  │＼┊  │  ┊／│
//	│┄＼┄│┄／┄│
//  │  ┆＼│／┊  │
//	5 ───4 ───7
//  │  ┊／│＼┊  │
//  │┄／┄│┄＼┄│
//  │／┊  │  ┊＼│
//  1 ───6 ─── 3
//----------------------------------------------------
// LOD3(单纹理时两种渲染方式, 现在多层纹理)
// 帖图尺寸(4*4)
//----------------------------------------------------
void CTerrain::DrawLevel_3(int x, int z)
{
	HeightmapVertex pV[6];
	m_numTriangles += 8;
//	if(!g_Hmap.m_bViewerChange)	return;
	
	int rx = (x-128)*4;
	int rz = (z-128)*4 - 1;
	int index0 = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+1);
	int index2 = g_Hmap.GetHeightIndex(x+1, z);
	int index3 = g_Hmap.GetHeightIndex(x+1, z+1);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
		return;

	int index, nX, nY, vX, vY;
	for(int m=0; m<4; m+=2)
	{
		for(int n=0; n<4; n+=2)
		{
			DefinePos(m,n);
			DefineVertex(0, 0,0);
			DefineVertex(1, 2,0);
			DefineVertex(2, 0,2);
			pV[3] = pV[2];
			pV[4] = pV[1];
			DefineVertex(5, 2,2);

			const float uv[12] = { 
				0.01f,  0.01f,
				0.24f,  0.01f,
				0.01f,  0.24f,
				0.01f,  0.24f,
				0.24f,  0.01f,
				0.24f,  0.24f 
			};
			GenerateGroup(nX, nY, pV, uv, 6);
		}
	}
}

//	0 ───8 ─── 2
//  │＼    │    ／│
//	│  ＼  │  ／  │
//  │    ＼│／    │
//	5 ───4 ───7
//  │    ／│＼    │
//  │  ／  │  ＼  │
//  │／    │    ＼│
//  1 ───6 ─── 3
//----------------------------------------------------
// LOD4(4格和2格的过渡层)
// 帖图尺寸(2*2)
//----------------------------------------------------
void CTerrain::DrawLevel_4(int x, int z)
{
	HeightmapVertex pV[6];
	int rx = (x-128)*4;
	int rz = (z-128)*4 - 1;
	int index0 = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+1);
	int index2 = g_Hmap.GetHeightIndex(x+1, z);
	int index3 = g_Hmap.GetHeightIndex(x+1, z+1);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
	{
		return;
	}

	int index, nX, nY, vX, vY;
	for(int m=0; m<4; m+=2)
	{
		for(int n=0; n<4; n+=2)
		{
			BOOL bLod3to5 = FALSE; //LOD3 过渡到 LOD5
			if( n==0 && GetLODLevel(z, x-1)>4 )
			{
				bLod3to5 = TRUE;
				//	0 
				//  │＼
				//	│  4 
				//  │／  
				//	1 
				if( m==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 0,0); //0 
					DefineVertex(1, 2,2); //4 
					DefineVertex(2, 0,4); //1 
					const float uv[6] = {									
						0.01f,  0.01f,								
						0.24f,  0.125f,                 
						0.01f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}

				switch(m)
				{
				case 0:
					if( GetLODLevel(z-1, x)<=4 )
					{
						//	0 ─8
						//    ＼│
						//	    4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //0 
						DefineVertex(1, 2,0); //8
						DefineVertex(2, 2,2); //4 
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					if( GetLODLevel(z+1, x)<=4 )
					{
						//      4 
						//    ／│
						//  1 ─6
						DefinePos(m, n);
						DefineVertex(0, 2,0); //4 
						DefineVertex(1, 2,2); //6
						DefineVertex(2, 0,2); //1 
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( m==0 && GetLODLevel(z-1, x)>4 )
			{
				bLod3to5 = TRUE;
				//	0 ───2
				//    ＼  ／
				//	    4 
				if( n==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 2,2); //4 
					DefineVertex(1, 0,0); //0 
					DefineVertex(2, 4,0); //2 
					const float uv[6] = { 
						0.125f, 0.24f,
						0.01f,  0.01f,
						0.24f,  0.01f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}

				switch(n)
				{
				case 0:
					if( GetLODLevel(z, x-1)<=4 )
					{
						//	0  
						//  │＼ 
						//  5 ─4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //0 
						DefineVertex(1, 2,2); //4 
						DefineVertex(2, 0,2); //5
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					if( GetLODLevel(z, x+1)<=4 )
					{
						//      2 
						//    ／│
						//  4 ─7
						DefinePos(m, n);
						DefineVertex(0, 2,0); //2 
						DefineVertex(1, 2,2); //7
						DefineVertex(2, 0,2); //4
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( m==2 && GetLODLevel(z+1, x)>4 )
			{
				bLod3to5 = TRUE;
				//      4 
				//    ／  ＼
				//  1 ───3 
				if( n==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 2,0); //4 
					DefineVertex(1, 4,2); //3 
					DefineVertex(2, 0,2); //1 
					const float uv[6] = { 
						0.125f, 0.01f, 
						0.24f,  0.24f,
						0.01f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}
				switch(n)
				{
				case 0:
					if( GetLODLevel(z, x-1)<=4 )
					{
						//  5 ─4
						//  │／
						//  1 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //5
						DefineVertex(1, 2,0); //4 
						DefineVertex(2, 0,2); //1
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					if( GetLODLevel(z, x+1)<=4 )
					{
						//  4 ─7
						//    ＼│
						//      3
						DefinePos(m, n);
						DefineVertex(0, 0,0); //4 
						DefineVertex(1, 2,0); //7 
						DefineVertex(2, 2,2); //3
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( n==2 && GetLODLevel(z, x+1)>4 )
			{
				bLod3to5 = TRUE;
				//        2
				//      ／│
				//    4   │
				//      ＼│
				//        3
				if( m==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 0,2); //4
					DefineVertex(1, 2,0); //2
					DefineVertex(2, 2,4); //3 
					const float uv[6] = {									  
						0.01f,  0.125f,							     
						0.24f,  0.01f,				      
						0.24f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}
				switch(m)
				{
				case 0:
					if( GetLODLevel(z-1, x)<=4 )
					{
						//	8 ─ 2
						//  │／
						//	4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //8
						DefineVertex(1, 2,0); //2 
						DefineVertex(2, 0,2); //4
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 2:
					if( GetLODLevel(z+1, x)<=4 )
					{
						//4
						//│＼
						//6 ─ 3
						DefinePos(m, n);
						DefineVertex(0, 0,0); //4 
						DefineVertex(1, 2,2); //3
						DefineVertex(2, 0,2); //6
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( !bLod3to5 )
			{
				DefinePos(m, n);
				DefineVertex(0, 0,0);
				DefineVertex(1, 2,0);
				DefineVertex(2, 0,2);
				pV[3] = pV[2];
				pV[4] = pV[1];
				DefineVertex(5, 2,2);

				const float uv[12] = { 
					0.01f,  0.01f,
					0.24f,  0.01f,
					0.01f,  0.24f,
					0.01f,  0.24f,
					0.24f,  0.01f,
					0.24f,  0.24f 
				};
				GenerateGroup(nX, nY, pV, uv, 6);
			}
		}
	}
}

//	0 ─────── 2
//  │              │
//	│              │
//  │              │
//	│              │
//  │              │
//  │              │
//  │              │
//  1 ─────── 3
//----------------------------------------------------
// LV5(单层纹理两种渲染方式, 现在是多层纹理)
// LOD1-LOD5为1*1格子
// 帖图尺寸(2*2)
//----------------------------------------------------
void CTerrain::DrawLevel_5(int x, int z)
{
	HeightmapVertex pV[6];
	m_numTriangles += 2;
// 	if(!g_Hmap.m_bViewerChange)
// 	{
// 		return;
// 	}
	int rx = (x-128)*4;
	int rz = (z-128)*4  - 1;
	int index0 = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+1);
	int index2 = g_Hmap.GetHeightIndex(x+1, z);
	int index3 = g_Hmap.GetHeightIndex(x+1, z+1);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
		return;

	int index, nX, nY, vX, vY;
	DefinePos(0,0);
	DefineVertex(0, 0,0);
	DefineVertex(1, 4,0);
	DefineVertex(2, 0,4);
	pV[3] = pV[2];
	pV[4] = pV[1];
	DefineVertex(5, 4,4);
	const float uv[12] = { 
		0.01f,  0.01f,
		0.24f,  0.01f,
		0.01f,  0.24f,
		0.01f,  0.24f,
		0.24f,  0.01f,
		0.24f,  0.24f 
	};
	GenerateGroup(nX, nY, pV, uv, 6);
}

//	0 ───8 ─── 2
//  │＼    │    ／│
//	│  ＼  │  ／  │
//  │    ＼│／    │
//	5 ───4 ───7
//  │    ／│＼    │
//  │  ／  │  ＼  │
//  │／    │    ＼│
//  1 ───6 ─── 3
//----------------------------------------------------
// LOD6(8格和4格的过渡层)
// 2*2的格子(LV6 & LV7不显示过度纹理)
//----------------------------------------------------
void CTerrain::DrawLevel_6(int x, int z)
{
	HeightmapVertex pV[6];

	int rx = (x-128)*4;
	int rz = (z-128)*4 - 1;
	int index0 = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+2);
	int index2 = g_Hmap.GetHeightIndex(x+2, z);
	int index3 = g_Hmap.GetHeightIndex(x+2, z+2);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
	{
		return;
	}
	int index, nX, nY, vX, vY;
	for(int m=0; m<8; m+=4)
	{
		for(int n=0; n<8; n+=4)
		{
			BOOL bLod5to7 = FALSE; //LOD1 过渡到 LOD2
			if( n==0 && GetLODLevel(z, x-2)>6 )
			{
				bLod5to7 = TRUE;
				//	0 
				//  │＼
				//	│  4 
				//  │／  
				//	1 
				if( m==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 0,0); //0 
					DefineVertex(1, 4,4); //4 
					DefineVertex(2, 0,8); //1 
					const float uv[6] = {									
						0.01f,  0.01f,								
						0.24f,  0.125f,                 
						0.01f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}

				switch(m)
				{
				case 0:
					if( GetLODLevel(z-2, x)<=6 )
					{
						//	0 ─8
						//    ＼│
						//	    4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //0 
						DefineVertex(1, 4,0); //8
						DefineVertex(2, 4,4); //4 
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 4:
					if( GetLODLevel(z+2, x)<=6 )
					{
						//      4 
						//    ／│
						//  1 ─6
						DefinePos(m, n);
						DefineVertex(0, 4,0); //4 
						DefineVertex(1, 4,4); //6
						DefineVertex(2, 0,4); //1 
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( m==0 && GetLODLevel(z-2, x)>6 )
			{
				bLod5to7 = TRUE;
				//	0 ───2
				//    ＼  ／
				//	    4 
				if( n==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 4,4); //4 
					DefineVertex(1, 0,0); //0 
					DefineVertex(2, 8,0); //2 
					const float uv[6] = { 
						0.125f, 0.24f,
						0.01f,  0.01f,
						0.24f,  0.01f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}

				switch(n)
				{
				case 0:
					if( GetLODLevel(z, x-2)<=6 )
					{
						//	0  
						//  │＼ 
						//  5 ─4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //0 
						DefineVertex(1, 4,4); //4 
						DefineVertex(2, 0,4); //5
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 4:
					if( GetLODLevel(z, x+2)<=6 )
					{
						//      2 
						//    ／│
						//  4 ─7
						DefinePos(m, n);
						DefineVertex(0, 4,0); //2 
						DefineVertex(1, 4,4); //7
						DefineVertex(2, 0,4); //4
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( m==2 && GetLODLevel(z+2, x)>6 )
			{
				bLod5to7 = TRUE;
				//      4 
				//    ／  ＼
				//  1 ───3 
				if( n==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 4,0); //4 
					DefineVertex(1, 8,4); //3 
					DefineVertex(2, 0,4); //1 
					const float uv[6] = { 
						0.125f, 0.01f, 
						0.24f,  0.24f,
						0.01f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}
				switch(n)
				{
				case 0:
					if( GetLODLevel(z, x-2)<=6 )
					{
						//  5 ─4
						//  │／
						//  1 
						DefinePos(m, n);
						DefineVertex(0, 0,0); //5
						DefineVertex(1, 4,0); //4 
						DefineVertex(2, 0,4); //1
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 4:
					if( GetLODLevel(z, x+2)<=6 )
					{
						//  4 ─7
						//    ＼│
						//      3
						DefinePos(m, n);
						DefineVertex(0, 0,0); //4 
						DefineVertex(1, 4,0); //7 
						DefineVertex(2, 4,4); //3
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.24f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( n==2 && GetLODLevel(z, x+2)>6 )
			{
				bLod5to7 = TRUE;
				//        2
				//      ／│
				//    4   │
				//      ＼│
				//        3
				if( m==0 )
				{
					DefinePos(m, n);
					DefineVertex(0, 0,4); //4
					DefineVertex(1, 4,0); //2
					DefineVertex(2, 4,8); //3 
					const float uv[6] = {									  
						0.01f,  0.125f,							     
						0.24f,  0.01f,				      
						0.24f,  0.24f 
					};
					GenerateGroup(nX, nY, pV, uv, 3);
				}
				switch(m)
				{
				case 0:
					if( GetLODLevel(z-2, x)<=6 )
					{
						//	8 ─ 2
						//  │／
						//	4
						DefinePos(m, n);
						DefineVertex(0, 0,0); //8
						DefineVertex(1, 4,0); //2 
						DefineVertex(2, 0,4); //4
						const float uv[6] = {									
							0.01f,  0.01f,								
							0.24f,  0.01f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				case 4:
					if( GetLODLevel(z+2, x)<=6 )
					{
						//4
						//│＼
						//6 ─ 3
						DefinePos(m, n);
						DefineVertex(0, 0,0); //4 
						DefineVertex(1, 4,4); //3
						DefineVertex(2, 0,4); //6
						const float uv[6] = {									
							0.24f,  0.01f,								
							0.24f,  0.24f,                 
							0.01f,  0.24f 
						};
						GenerateGroup(nX, nY, pV, uv, 3);
					}
					break;
				}
			}

			if( !bLod5to7 )
			{
				DefinePos(m, n);
				DefineVertex(0, 0,0);
				DefineVertex(1, 4,0);
				DefineVertex(2, 0,4);
				pV[3] = pV[2];
				pV[4] = pV[1];
				DefineVertex(5, 4,4);

				const float uv[12] = { 
					0.01f,  0.01f,
					0.24f,  0.01f,
					0.01f,  0.24f,
					0.01f,  0.24f,
					0.24f,  0.01f,
					0.24f,  0.24f 
				};
				GenerateGroup(nX, nY, pV, uv, 6);
			}
		}
	}
}

//----------------------------------------------------
// LOD7使用批处理方式
// 2*2的格子
//----------------------------------------------------
void CTerrain::DrawLevel_7(int x, int z)
{
// 	if(!g_Hmap.m_bViewerChange)
// 	{
// 		return;
// 	}
	HeightmapVertex pV[6];
	int rx = (x-128)*4;
	int rz = (z-128)*4 - 1;

	int index0 = g_Hmap.GetHeightIndex(x, z);
	int index1 = g_Hmap.GetHeightIndex(x, z+2);
	int index2 = g_Hmap.GetHeightIndex(x+2, z);
	int index3 = g_Hmap.GetHeightIndex(x+2, z+2);
	if(index0==-1 || index1==-1 || index2==-1 || index3==-1)
	{
		return;
	}
	int index, nX, nY, vX, vY;
	DefinePos(0,0);
	DefineVertex(0, 0,0);
	DefineVertex(1, 8,0);
	DefineVertex(2, 0,8);
	pV[3] = pV[2];
	pV[4] = pV[1];
	DefineVertex(5, 8,8);
	const float uv[12] = { 
		0.01f,  0.01f,
		0.24f,  0.01f,
		0.01f,  0.24f,
		0.01f,  0.24f,
		0.24f,  0.01f,
		0.24f,  0.24f 
	};
	GenerateGroup(nX, nY, pV, uv, 6);
}

unsigned char	CTerrain::GetLODLevel(int z, int x)
{
	x = (x + 128*1) / 2;
	z = (z + 128*1) / 2;
	return m_LODmap[z][x];
}
