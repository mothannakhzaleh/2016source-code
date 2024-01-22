#include "StdAfx.h"
#include "Heightmap.h"
#include "Color.h"
#include "LEMap.h"
#include "drgraphicsutil.h"

#define M_180_PI	57.2957795130823208768
const DWORD HeightmapVertex::FVF = D3DFVF_XYZ | D3DFVF_DIFFUSE | D3DFVF_TEX2;

CHeightmap::CHeightmap()
{
//	m_HeightData.m_pData = NULL;
//	m_HeightData.m_Size = 0;
	m_SizeX = m_SizeY = 0;

//	m_pLightColor = NULL;
	m_pVertex = NULL;

	m_pMovemap = NULL;

	m_ViewRotY = 0.0f;
	m_ViewPos = D3DXVECTOR3(1000, 20, 3150);
	m_bViewerChange = true;
	m_pMap = NULL;
}

CHeightmap::~CHeightmap()
{
	Release();
}

void CHeightmap::Release(void)
{
	UnLoadHeightmap();
	if(m_pMovemap != NULL)
	{
		delete [] m_pMovemap;
		m_pMovemap = NULL;
	}
// 	if(m_pLightColor)
// 	{
// 		delete [] m_pLightColor;
// 		m_pLightColor = NULL;
// 	}
	if(m_pVertex)
	{
		delete [] m_pVertex;
		m_pVertex = NULL;
	}
}

//----------------------------------------------------
// 加载高度图
//----------------------------------------------------
bool CHeightmap::LoadHeightmap(LEMap* pMap)
{
	m_pMap = pMap;
// 	if(szFilename == NULL || szFilename[0]==0 || !iSize)
// 		return false;

	Release();
	m_SizeX = m_pMap->GetWidth();
	m_SizeY = m_pMap->GetHeight();
//	LoadHeightmap("Picture\\garner4096.raw", 4096);
	
	// light map
// 	m_pLightColor = new DWORD[m_Size*m_Size];
// 	if(m_pLightColor == NULL)
// 		return false;
// 	D3DXVECTOR3 directionToLight(0.0f, -10.0f, 0.0f);
// 	ComputeDiffuse(&directionToLight);
	m_pMovemap = new Move_Vertex[MOVE_MAP_SIZE*MOVE_MAP_SIZE];
	if(m_pMovemap == NULL)
		return false;
	
	return true;
}

//----------------------------------------------------
// 加载高度图
//----------------------------------------------------
bool CHeightmap::LoadHeightmap(char* szFilename, int iSize)
{
// 	if(szFilename == NULL || szFilename[0]==0 || !iSize)
// 		return false;
// 
// 	FILE* pFile = NULL;
// 	if( fopen_s(&pFile, szFilename, "rb")!=0 )
// 	{
// 		WriteLog(INFO_ERROR, "Can't Load Heightmap[%s]", szFilename);
// 		return false;
// 	}
// 	m_HeightData.m_pData = new unsigned char[iSize*iSize];
// 	if(m_HeightData.m_pData==NULL)	
// 		return false;
// 	fread(m_HeightData.m_pData, iSize*iSize, 1, pFile);
// 	fclose(pFile);
// 	m_HeightData.m_Size = iSize;

	return true;
}

//----------------------------------------------------
// 保存高度图
//----------------------------------------------------
bool CHeightmap::SaveHeightmap(char* szFilename)
{
// 	if(szFilename == NULL || szFilename[0]==0)
// 		return false;
// 
// 	if(m_HeightData.m_pData == NULL)
// 		return false;
// 
// 	FILE* pFile = NULL;
// 	if( fopen_s(&pFile, szFilename, "wb")!=0 )
// 		return false;
// 
// 	char* pExt = strrchr(szFilename, '.');
// 	if( pExt && _stricmp(pExt, ".BLE")==0 )
// 	{
// 		//存成BLE格式
// 		BITMAPFILEHEADER	bmf;
// 		BITMAPINFOHEADER	bmi;
// 		int					headsize = sizeof(bmf) + sizeof(bmi);
// 		int					pitch = m_Size * 3;
// 		bmf.bfType = 'MB';
// 		bmf.bfSize = headsize + pitch * m_Size;
// 		bmf.bfReserved1 = bmf.bfReserved2 = 0;
// 		bmf.bfOffBits = headsize;
// 		bmi.biSize = sizeof( bmi );
// 		bmi.biWidth = m_Size;
// 		bmi.biHeight = m_Size;
// 		bmi.biPlanes = 1;
// 		bmi.biBitCount = 24;
// 		bmi.biCompression = BI_RGB;
// 		bmi.biSizeImage = pitch * m_Size;
// 		bmi.biXPelsPerMeter = 72;
// 		bmi.biYPelsPerMeter = 72;
// 		bmi.biClrUsed = 0;
// 		bmi.biClrImportant = 0;
// 		fwrite(&bmf, sizeof(bmf), 1, pFile);
// 		fwrite(&bmi, sizeof(bmi), 1, pFile);
// 		LPBYTE pBits  = new BYTE[ bmi.biSizeImage ];
// 		int trg = 0;
// 		int src = 0;
// 		for(int y=0; y<m_Size; y++)
// 		{
// 			for(int x=0; x<m_Size; x++)
// 			{
// 				pBits[trg] = pBits[trg+1] = pBits[trg+2] = m_HeightData.m_pData[src++];
// 				trg += 3;
// 			}
// 		}
// 		fwrite(pBits, m_Size * 3 * m_Size, 1, pFile);
// 		fclose(pFile);
// 		delete [] pBits;
// 		return true;
// 	}
// 
// 	fwrite(m_HeightData.m_pData, m_HeightData.m_Size*m_HeightData.m_Size, 1, pFile);
// 	fclose(pFile);
	return true;
}

//----------------------------------------------------
// 保存光影图
//----------------------------------------------------
bool CHeightmap::SaveLightmap(char* szFilename)
{
// 	if(szFilename == NULL || szFilename[0]==0)
// 		return false;
// 
// 	if(m_pLightColor == NULL)
// 		return false;
// 
// 	FILE* pFile = NULL;
// 	if( fopen_s(&pFile, szFilename, "wb")!=0 )
// 		return false;
// 
// 	//存成BLE格式
// 	BITMAPFILEHEADER	bmf;
// 	BITMAPINFOHEADER	bmi;
// 	int					headsize = sizeof(bmf) + sizeof(bmi);
// 	int					pitch = m_Size * 3;
// 	bmf.bfType = 'MB';
// 	bmf.bfSize = headsize + pitch * m_Size;
// 	bmf.bfReserved1 = bmf.bfReserved2 = 0;
// 	bmf.bfOffBits = headsize;
// 	bmi.biSize = sizeof( bmi );
// 	bmi.biWidth = m_Size;
// 	bmi.biHeight = m_Size;
// 	bmi.biPlanes = 1;
// 	bmi.biBitCount = 24;
// 	bmi.biCompression = BI_RGB;
// 	bmi.biSizeImage = pitch * m_Size;
// 	bmi.biXPelsPerMeter = 72;
// 	bmi.biYPelsPerMeter = 72;
// 	bmi.biClrUsed = 0;
// 	bmi.biClrImportant = 0;
// 	fwrite(&bmf, sizeof(bmf), 1, pFile);
// 	fwrite(&bmi, sizeof(bmi), 1, pFile);
// 	LPBYTE pBits  = new BYTE[ bmi.biSizeImage ];
// 	int trg = 0;
// 	int src = 0;
// 	for(int y=0; y<m_Size; y++)
// 	{
// 		for(int x=0; x<m_Size; x++)
// 		{
// 			DWORD color = m_pLightColor[src];
// 			pBits[trg]   =  GetB(color) * GetA(color) / 255;
// 			pBits[trg+1] =  GetG(color) * GetA(color) / 255;
// 			pBits[trg+2] =  GetR(color) * GetA(color) / 255;
// 			trg += 3;
// 			src ++;
// 		}
// 	}
// 	fwrite(pBits, m_Size * 3 * m_Size, 1, pFile);
// 	fclose(pFile);
// 	delete [] pBits;
	return true;
}

//----------------------------------------------------
// 释放高度图
//----------------------------------------------------
bool CHeightmap::UnLoadHeightmap()
{
//  if(m_HeightData.m_pData!=NULL)
//  {
//  	delete [] m_HeightData.m_pData;
//  	m_HeightData.m_pData = NULL;
//  	m_HeightData.m_Size = 0;
//  }
	return true;
}

void CHeightmap::UpdateFrustum(D3DXVECTOR3* pEyePos, D3DXVECTOR3* pViewDir)
{
	static D3DXVECTOR3 s_vDir(0.0f,0.0f,0.0f);
	if( (*pEyePos)!=m_ViewPos || (*pViewDir)!=s_vDir )
	{
		D3DXVECTOR3 pane(pViewDir->x, pViewDir->y, 0.0f);
		D3DXVECTOR3 zxis(0.0f, 1.0f, 0.0f);
		float panelen = D3DXVec3Length(&pane);
		float zxislen = D3DXVec3Length(&zxis);
		float dotValue = D3DXVec3Dot(&pane, &zxis)/panelen/zxislen;

		float angle = acos(dotValue)*(float)M_180_PI;
		if( pViewDir->x<0.0f )
			angle = 360.0f-angle;

		SetViewPosition(*pEyePos);
		SetViewRotateY(angle);
		UpdateHeightmap();
		s_vDir = (*pViewDir);
	}
}

//----------------------------------------------------
// 更新高度图
//----------------------------------------------------
void CHeightmap::UpdateHeightmap(void)
{
	m_Frustum.m_ViewerRotate = m_ViewRotY;
	
	m_Frustum.UpdateFrustum();
	//---------------------------------------
	// 该节太消耗资源(远处显示有点小问题)
	//---------------------------------------
//	/*
	for(int i=0; i<MOVE_MAP_SIZE*MOVE_MAP_SIZE; i++)
	{
		m_pMovemap[i].xpos = -1;
		m_pMovemap[i].zpos = -1;
	}
//	*/

	int offsetx = int(m_ViewPos.x * WORLD_TO_MOVE);
	if(m_ViewPos.x<0.0f)	offsetx -= 1;

	int offsetz = int(m_ViewPos.y * WORLD_TO_MOVE);
	if(m_ViewPos.y<0.0f)	offsetz -= 1;

	int min = m_Frustum.m_minZ;
	int max = m_Frustum.m_maxZ;
	
	for(int z=(m_Frustum.m_pos[min].y); z<=(m_Frustum.m_pos[max].y); z++)
	{
		int zpos = ((z-MOVE_MAP_SIZE/2+offsetz)*MOVE_MAP_SCALE)%m_SizeY;
		if(zpos<=0)		zpos = -zpos;
		else			zpos = m_SizeY-zpos;

		if(z>=MOVE_MAP_SIZE)
			break;
		int xpos = (((m_Frustum.m_LeftArray[z])-MOVE_MAP_SIZE/2+offsetx)*MOVE_MAP_SCALE)%m_SizeX;
		if(xpos<0)	xpos = m_SizeX+xpos;

		for(int x=(m_Frustum.m_LeftArray[z]); x<=(m_Frustum.m_RightArray[z]); x++)
		{
			m_pMovemap[z*MOVE_MAP_SIZE+x].xpos = xpos;
			m_pMovemap[z*MOVE_MAP_SIZE+x].zpos = zpos;	

			xpos += MOVE_TO_WORLD;
			if(xpos>m_SizeX-MOVE_TO_WORLD)
			{
				xpos = 0;
			}
		}
	}
	
	m_ViewOffsetZ = offsetz*MOVE_TO_WORLD;
	m_ViewOffsetX = offsetx*MOVE_TO_WORLD;
}

//----------------------------------------------------
// 显示地形
//----------------------------------------------------
void CHeightmap::Render(void)
{
}

//----------------------------------------------------
// 观察者Y轴坐标
//----------------------------------------------------
float CHeightmap::GetYPosition(void)
{
	return GetHeight(m_ViewPos.x, m_ViewPos.z);
}

//----------------------------------------------------
// 观察者位置
//----------------------------------------------------
void CHeightmap::SetViewPosition(D3DXVECTOR3 viewpos)
{
	m_ViewPos = viewpos;
	m_bViewerChange = true;
}

//----------------------------------------------------
// 观察者Y轴的旋转角度
//----------------------------------------------------
void CHeightmap::SetViewRotateY(float angle)
{
	if(abs(angle-m_ViewRotY)>=1.0f)
	{
		m_ViewRotY = angle;
		m_bViewerChange = true;
	}
}

//----------------------------------------------------
// 填充顶点
//----------------------------------------------------
bool CHeightmap::FillVertexBuffer(void)
{
	return true;
}

//----------------------------------------------------
// 由移动位置取得高度索引
//----------------------------------------------------
int CHeightmap::GetHeightIndex(int movemapX, int movemapZ)
{
	int movemapindex = movemapZ*MOVE_MAP_SIZE+movemapX;
	if(m_pMovemap[movemapindex].zpos>=0 && m_pMovemap[movemapindex].xpos>=0)
	{
		return m_pMovemap[movemapindex].zpos*m_SizeX + m_pMovemap[movemapindex].xpos;
	}
	else
	{
		return -1;
	}
}

//----------------------------------------------------
// 由索引偏移取得高度索引
//----------------------------------------------------
int CHeightmap::GetHeightIndexOffset(int index, char offsetZ, char offsetX)
{
	int retIndex = index + offsetZ*m_SizeX + offsetX;
	int num;
	if(retIndex>=0 && retIndex<m_SizeX*m_SizeY)
	{
		return retIndex;
	}
	if(retIndex-offsetX>=0 && retIndex-offsetZ<m_SizeX*m_SizeY)
	{
		if(retIndex<0)	return retIndex+m_SizeX*m_SizeY;
		else			return retIndex-m_SizeX*m_SizeY;
	}
	else
	{
		if(retIndex-offsetX<0)	num = index+(m_SizeY+offsetZ)*m_SizeX;
		else					num = index+(m_SizeY-offsetZ)*m_SizeX;
	}
	if(num+offsetX>=0 && num+offsetX<m_SizeX*m_SizeY)
	{
		return num+offsetX;
	}
	else if(num+offsetX<0) return num+offsetX+m_SizeX*m_SizeY;
	else				   return num+offsetX-m_SizeX*m_SizeY;

}

//----------------------------------------------------
// 获取精确高度(三次线性插值)
//----------------------------------------------------
float CHeightmap::GetHeight(D3DXVECTOR3 *checked)
{
	POINT point = ConvertToHeightmap(checked);
	//小数部分
	float Xpos,Zpos;
	if(checked->x<0)
	{
		Xpos = 1+checked->x*WORLD_TO_HEIGHT-int(checked->x*WORLD_TO_HEIGHT);
	}
	else
	{
		Xpos = checked->x*WORLD_TO_HEIGHT-int(checked->x*WORLD_TO_HEIGHT);
	}
	if(checked->z<=0)
	{
		Zpos = -(checked->z*WORLD_TO_HEIGHT-int(checked->z*WORLD_TO_HEIGHT));
	}
	else 
	{
		Zpos = 1-checked->z*WORLD_TO_HEIGHT+int(checked->z*WORLD_TO_HEIGHT);
	}

	int addx = point.x + 1;
	int addy = point.y + 1;
	if(addx==m_SizeX)	addx = 0;
	if(addy==m_SizeY)	addy = 0;
/*
*/
	float h11 = float(GetHeight(point.x, point.y)); 
	float h12 = float(GetHeight(point.x, addy));	 
	float h21 = float(GetHeight(addx, point.y));    
	float h22 = float(GetHeight(addx, addy));       
	//三次线性插值
	float ha = h11 + Xpos * (h21 - h11);
	float hb = h12 + Xpos * (h22 - h12);	
	float ypos = ha + Zpos * (hb - ha);

	//float haa = h11 + Zpos * (h12-h11);
	//float hbb = h21 + Zpos * (h22-h21);
	//float yposs = haa + Xpos * (hbb-haa);

	return ypos;
}

//----------------------------------------------------
// 获取精确高度
//----------------------------------------------------
float CHeightmap::GetHeight(float Worldxpos, float Worldzpos)
{
	D3DXVECTOR3 temp = D3DXVECTOR3(Worldxpos, 0, Worldzpos);
	float ypos = GetHeight(&temp);
	return ypos;
}

//----------------------------------------------------
// 世界坐标转换到高度图(循环地形)
//----------------------------------------------------
POINT CHeightmap::ConvertToHeightmap(D3DXVECTOR3 *pos)
{
	POINT point;
	if(pos->x<0)
	{
		point.x = (m_SizeX-1) + int(pos->x*WORLD_TO_HEIGHT)%m_SizeX;
	}
	else
	{
		point.x = int(pos->x*WORLD_TO_HEIGHT)%m_SizeX;
	}
	if(pos->z<=0)
	{
		point.y = -(int(pos->z*WORLD_TO_HEIGHT)%m_SizeY);
	}
	else 
	{
		point.y = (m_SizeY-1) - int(pos->z*WORLD_TO_HEIGHT)%m_SizeY;
	}

	return point;
}

//----------------------------------------------------
// 世界坐标转换到移动图
//----------------------------------------------------
POINT CHeightmap::ConvertToMovemap(D3DXVECTOR3 pos)
{
	POINT point;
	if(pos.x < m_ViewOffsetX)
	{
		point.x = int((pos.x-m_ViewOffsetX)*WORLD_TO_MOVE)+MOVE_MAP_SIZE/2-1;
	}
	else
	{
		point.x = int((pos.x-m_ViewOffsetX)*WORLD_TO_MOVE)+MOVE_MAP_SIZE/2;
	}
	if(pos.z < m_ViewOffsetZ)
	{
		point.y = int((pos.z-m_ViewOffsetZ)*WORLD_TO_MOVE)+MOVE_MAP_SIZE/2-1;
	}
	else
	{
		point.y = int((pos.z-m_ViewOffsetZ)*WORLD_TO_MOVE)+MOVE_MAP_SIZE/2;
	}
/*
	if(point.x<0 || point.x>=MOVE_MAP_SIZE || point.y<0 || point.y>=MOVE_MAP_SIZE)
	{   
		POINT pt;
		pt.x = 0;
		pt.y = 0;
		return pt;
	}
*/
	return point;
}

//----------------------------------------------------
// 移动图转换到世界坐标(y轴是高度图的高度)
//----------------------------------------------------
D3DXVECTOR3 CHeightmap::ConvertToWorld(int movemapXPos, int movemapZPos)
{
	D3DXVECTOR3 position;
	position.x = float(m_ViewOffsetX + (movemapXPos-MOVE_MAP_SIZE/2)*HEIGHT_MAP_SCALE*MOVE_MAP_SCALE);
	position.z = float(m_ViewOffsetZ + (movemapZPos-MOVE_MAP_SIZE/2)*HEIGHT_MAP_SCALE*MOVE_MAP_SCALE);

	POINT point;
	point.x = m_pMovemap[movemapZPos*MOVE_MAP_SIZE+movemapXPos].xpos;
	point.y = m_pMovemap[movemapZPos*MOVE_MAP_SIZE+movemapXPos].zpos;

	position.y = GetHeight(point.x, point.y);

	return position;
}

//----------------------------------------------------
// 可视检测(世界坐标)
//----------------------------------------------------
bool CHeightmap::IsInFrustum(D3DXVECTOR3 *checked)
{
	POINT point = ConvertToMovemap(*checked);
	return m_Frustum.IsInFrustum(point.x, point.y);
}

//----------------------------------------------------
// 可视检测(世界坐标)
//----------------------------------------------------
bool CHeightmap::IsInFrustum(float x, float z)
{
	POINT point = ConvertToMovemap(D3DXVECTOR3(x, 255, z));
	return m_Frustum.IsInFrustum(point.x, point.y);
}

//----------------------------------------------------
// 可视检测(包围体)
//----------------------------------------------------
bool CHeightmap::IsInFrustum(Boundary_3D *pBoundary)
{
	if(IsInFrustum(pBoundary->minx, pBoundary->minz))	return true;
	if(IsInFrustum(pBoundary->maxx, pBoundary->minz))	return true;
	if(IsInFrustum(pBoundary->maxx, pBoundary->maxz))	return true;
	if(IsInFrustum(pBoundary->minx, pBoundary->maxz))	return true;

	return false;
}

//----------------------------------------------------
// 计算地形光照阴影和纹理混合alpha(顶点DIFFUSE)
//----------------------------------------------------
void CHeightmap::ComputeDiffuse(D3DXVECTOR3* directionToLight)
{
	/*
	___________________________________________________
	1. (C-A)与(B-A)的叉乘得出面法线向量.
	2. 法线向量与光照方向的点乘得出夹角的大小(即光照分量)
	3. 两个向量都标准化之后, 点乘的值小于等于1.0f
	___________________________________________________

	A------->C
	|
	|
	|
	B

	*//*
	if(m_pLightColor == NULL)
		return;
	int index;
	float heightA, heightB, heightC;
	for(int i=0; i<m_Size; i++)
	{
		for(int j=0; j<m_Size; j++)
		{
			index = i*m_Size+j;
			heightA = (float)m_HeightData.m_pData[index];
			if(i+1>=m_Size)	{	index = j;	}
			else			{	index = (i+1)*m_Size+j;	}
			heightB = (float)m_HeightData.m_pData[index];
			if(j+1>=m_Size)	{	index = i*m_Size;	}
			else			{	index = i*m_Size+(j+1);	}
			heightC = (float)m_HeightData.m_pData[index];
			
			D3DXVECTOR3 u((float)HEIGHT_MAP_SCALE, heightC - heightA, 0.0f);
			D3DXVECTOR3 v(0.0f, heightB - heightA, (float)(HEIGHT_MAP_SCALE));
			D3DXVECTOR3 n;
			D3DXVec3Cross(&n, &u, &v);
			D3DXVec3Normalize(&n, &n);
			D3DXVec3Normalize(directionToLight, directionToLight);
			float cosine = D3DXVec3Dot(&n, directionToLight);

			if(cosine < 0.0f)
				cosine = 0.0f;

			m_pLightColor[i*m_Size+j] = MakeARGB(0x00, (BYTE)(cosine*0xff), (BYTE)(cosine*0xff), (BYTE)(cosine*0xff));
		}
	}
	
	// 纹理混合Alpha分量
	//___________________________________________________
	// 64*64
	//___________________________________________________
//#define TEX_SIZE	64
  #define TEX_SIZE	4096
	int nBlockSize = 4; //m_Size/TEX_SIZE;
	
	unsigned char* texindex = new unsigned char[TEX_SIZE*TEX_SIZE];
//	FILE *fp = fopen("Picture\\texture_index.BLE", "rb");
	FILE *fp = NULL;
	if( fopen_s(&fp, "Picture\\garner_color.BLE", "rb")!=0 )
	{
		delete [] texindex;
		return;
	}
	int hr = fseek(fp, 1078, SEEK_SET);
	if( hr!=0 )
	{
		delete [] texindex;
		return;
	}
	for(int z=TEX_SIZE-1; z>=0; z--)
	{
		for(int x=0; x<TEX_SIZE; x++)
		{
			fread(&texindex[z*TEX_SIZE+x], sizeof(unsigned char), 1, fp);	
		}
	}
	fclose(fp); 
	BYTE alpha_1 = 0;
	BYTE alpha_2 = 0;
	BYTE alpha_3 = 0;
	BYTE alpha_4 = 0;
	for(int z=0; z<TEX_SIZE; z++)
	{
		for(int x=0; x<TEX_SIZE; x++)
		{
			int addx = x + 1;
			int addz = z + 1;
			if(addx==TEX_SIZE) addx = 0;
			if(addz==TEX_SIZE) addz = 0;
			alpha_1 = 0x00;
			alpha_2 = 0x00;
			alpha_3 = 0x00;
			alpha_4 = 0x00;

			if(texindex[z*TEX_SIZE+x] < TEX_SIZE)		alpha_1 = 0xFF;	
			if(texindex[z*TEX_SIZE+addx] < TEX_SIZE)	alpha_2 = 0xFF;
			if(texindex[addz*TEX_SIZE+x] < TEX_SIZE)	alpha_3 = 0xFF;
			if(texindex[addz*TEX_SIZE+addx] < TEX_SIZE)	alpha_4 = 0xFF;

			float delta1 = (alpha_2-alpha_1)/(float)nBlockSize;
			float delta2 = (alpha_4-alpha_3)/(float)nBlockSize;
			for(int i=0; i<nBlockSize; i++)
			{
				float colorAlpha1 = alpha_1+delta1*i;
				float colorAlpha2 = alpha_3+delta2*i;
				float colorDelta = (colorAlpha2-colorAlpha1)/(float)nBlockSize;
				for(int j=0; j<nBlockSize; j++)
				{
					BYTE coloralpha = BYTE(colorAlpha1+colorDelta*j);

					for(int n=1; n<=m_Size/TEX_SIZE; n++)
					{
						for(int m=1; m<=m_Size/TEX_SIZE; m++)
						{
							int ndx = (z*nBlockSize+j)*n*m_Size+(x*nBlockSize+i)*m;
							if( ndx <0 || ndx >=m_Size*m_Size )
								break;
							m_pLightColor[ndx] |= coloralpha<<24;
						}
					}

// 					int ndx = (z*nBlockSize+j)*m_Size+x*nBlockSize+i;
// 					if( ndx <0 || ndx >=m_Size*m_Size )
// 						break;
// 					m_pLightColor[ndx] |= coloralpha<<24;
				}
			}
		}
	}
	delete [] texindex;
*/	
	//___________________________________________________
	// 256*256
	//___________________________________________________
	/*
	unsigned char texindex[256][256];
	FILE *fp = fopen("Picture\\tex_index256.BLE", "rb");
	if(fp==NULL)
	{
		return;
	}
	fseek(fp, 1078, SEEK_SET);
	for(int z=255; z>-1; z--)
	{
		for(int x=0; x<256; x++)
		{
			fread(&texindex[z][x], sizeof(unsigned char), 1, fp);	
		}
	}
	fclose(fp); 
	for(int z=0; z<256; z++)
	{
		for(int x=0; x<256; x++)
		{
			BYTE alpha = 0x00;
			if(texindex[z][x] < 64)			alpha = 0xFF;	
		
			m_pLightColor[z*m_Size+x] = m_pLightColor[z*m_Size+x] | alpha<<24;
		}
	}
	*/
}

//----------------------------------------------------
// 设置可视距离
//----------------------------------------------------
void CHeightmap::SetViewDistance(int distance)
{
	m_Frustum.InitFrustum(45, distance);
}

char CHeightmap::GetHeight(int nWorldX, int nWorldY)
{
	int sx = nWorldX / m_pMap->_nSectionWidth;
	int InverseY = (m_SizeY - nWorldY - 1);
	int sy = InverseY / m_pMap->_nSectionHeight;
	if( sx >=m_pMap->_nSectionCntX || sy>=m_pMap->_nSectionCntY )
		return -127;

	DWORD dwDataOffset = m_pMap->_ReadSectionDataOffset(sx, sy);
	if( dwDataOffset==0 )
		return -127;

	DWORD dwPos = dwDataOffset - m_pMap->m_dwMapPos;
	int x = nWorldX % m_pMap->_nSectionWidth;
	int y = InverseY % m_pMap->_nSectionHeight;
	SNewFileTile* pTile = (SNewFileTile*)(m_pMap->m_pMapData+dwPos);
	return pTile[y*m_pMap->_nSectionWidth+x].cHeight;
//	return (int)m_HeightData.m_pData[nWorldY*m_SizeX+nWorldX] - 128;	
}

SNewFileTile*	CHeightmap::GetTile(int nWorldX, int nWorldY)
{
	int sx = nWorldX / m_pMap->_nSectionWidth;
	int sy = nWorldY / m_pMap->_nSectionHeight;
	if( sx >=m_pMap->_nSectionCntX || sy>=m_pMap->_nSectionCntY )
		return NULL;

	DWORD dwDataOffset = m_pMap->_ReadSectionDataOffset(sx, sy);
	if( dwDataOffset==0 )
		return NULL;

	DWORD dwPos = dwDataOffset - m_pMap->m_dwMapPos;
	int x = nWorldX % m_pMap->_nSectionWidth;
	int y = nWorldY % m_pMap->_nSectionHeight;
	SNewFileTile* pTile = (SNewFileTile*)(m_pMap->m_pMapData+dwPos);
	return &pTile[y*m_pMap->_nSectionWidth+x];
}

char CHeightmap::operator[](int index) const
{
	int nWorldX = index % m_SizeX;
	int nWorldY = index / m_SizeX;
	int InverseY = (m_SizeY - nWorldY - 1);
	int sx = nWorldX / m_pMap->_nSectionWidth;
	int sy = InverseY / m_pMap->_nSectionHeight;
	if( sx >=m_pMap->_nSectionCntX || sy>=m_pMap->_nSectionCntY )
		return -127;

	DWORD dwDataOffset = m_pMap->_ReadSectionDataOffset(sx, sy);
	if( dwDataOffset==0 )
		return -127;

	DWORD dwPos = dwDataOffset - m_pMap->m_dwMapPos;
	int x = nWorldX % m_pMap->_nSectionWidth;
	int y = InverseY % m_pMap->_nSectionHeight;
	SNewFileTile* pTile = (SNewFileTile*)(m_pMap->m_pMapData+dwPos);
	return pTile[y*m_pMap->_nSectionWidth+x].cHeight;
//	return (int)m_HeightData.m_pData[index] - 128;
}

DWORD   CHeightmap::GetColor(int nWorldX, int nWorldY)
{
	int InverseY = (m_SizeY - nWorldY - 1);
	int sx = nWorldX / m_pMap->_nSectionWidth;
	int sy = InverseY / m_pMap->_nSectionHeight;
	if( sx >=m_pMap->_nSectionCntX || sy>=m_pMap->_nSectionCntY )
		return 0;

	DWORD dwDataOffset = m_pMap->_ReadSectionDataOffset(sx, sy);
	if( dwDataOffset==0 )
		return 0;

	DWORD dwPos = dwDataOffset - m_pMap->m_dwMapPos;
	int x = nWorldX % m_pMap->_nSectionWidth;
	int y = InverseY % m_pMap->_nSectionHeight;
	SNewFileTile* pTile = (SNewFileTile*)(m_pMap->m_pMapData+dwPos);
	return DR_RGB565TODWORD(pTile[y*m_pMap->_nSectionWidth+x].sColor);
}