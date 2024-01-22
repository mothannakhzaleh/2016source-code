#include "Stdafx.h"
#include "LETile.h"
#include "LEMap.h"
#include "drgraphicsutil.h"
#include "assert.h" 
#include <sys/types.h>
#include <sys/stat.h>
#include "LEMapDef.h"
#include <MyMemory.h>
#include <CPerformance.h>
#include "Terrain.h"

#pragma warning(disable:4311) //type cast warning

#define MAX_DEL_SECTION				200
#define MAX_SECTION_BUFFER          16

#ifdef _SKYBOX_
typedef void (CALLBACK* FUNC_SRC2RGB)(int x, int y, int width, BYTE& r, BYTE& g, BYTE& b, BYTE* pSrcData);
static void CALLBACK TileHeight2RGB(int x, int y, int width, BYTE& r, BYTE& g, BYTE& b, BYTE* pSrcData)
{
	LETile NewTile;
	NewTile.Init();
	SNewFileTile* pMap = (SNewFileTile*)pSrcData;
	SNewFileTile tile = pMap[y*width+x];
	TileInfo_5To8(tile.dwTileInfo, tile.btTileInfo, (BYTE*)(&NewTile.TexLayer[0]));
	NewTile.dwColor = DR_RGB565TODWORD(tile.sColor);
	NewTile.dwColor|=0xff000000;
	NewTile.fHeight = (float)(tile.cHeight * 10) / 100.0f;
	r = g = b = BYTE(tile.cHeight + 128);
}

bool SaveBLE(char* szFilename, int width, int height, BYTE* pSrcData, FUNC_SRC2RGB pFunc_Src2RGB)
{
	if( szFilename == NULL || szFilename[0]==0 )
		return false;

	FILE* pFile = NULL;
	if( fopen_s(&pFile, szFilename, "wb") != 0)
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

	if( pFunc_Src2RGB )
	{
		for(int y=0; y<height; y++)
		{
			for(int x=0; x<width; x++)
			{
				pFunc_Src2RGB(x, y, width, pBits[trg+2], pBits[trg+1], pBits[trg], pSrcData);
				trg += 3;
			}
		}
	}
	else
	{
		memcpy( pBits, pSrcData, bmi.biSizeImage);
	}

	fwrite(pBits, bmi.biSizeImage, 1, pFile);
	fclose(pFile);
	delete [] pBits;
	return true;
}

bool LEMap::SaveHeightBLE(char* szFilename, int width, int height)
{
	if( szFilename == NULL || szFilename[0]==0 )
		return false;

	FILE* pFile = NULL;
	if( fopen_s(&pFile, szFilename, "wb") != 0)
		return false;

	PSTR pExt = strrchr(szFilename, '.');
	if( pExt && _stricmp(pExt, ".BLE")==0 )
	{
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
		ZeroMemory(pBits, bmi.biSizeImage * sizeof(BYTE));
		int trg = 0;

		// 读取全部Section数据
		for(int sy=0; sy<_nSectionCntY; sy++)
		{
			for(int sx=0; sx<_nSectionCntX; sx++)
			{
				DWORD dwDataOffset = _ReadSectionDataOffset(sx, sy);
				if( dwDataOffset==0 )
					continue;

				DWORD dwPos = dwDataOffset - m_dwMapPos;

				for(int y=0; y<_nSectionHeight; y++)
				{
					for(int x=0; x<_nSectionWidth; x++)
					{
						LETile LETile;
						LETile.Init();

						SNewFileTile tile = *(SNewFileTile*)(m_pMapData+dwPos);
						trg = (height-(sy*_nSectionHeight+y)-1) * _nSectionCntX * _nSectionWidth + (sx*_nSectionWidth+x);
						trg*=3;
						pBits[trg+2] = tile.btBlock[0]; //min(255,tile.sRegion * 3); //128 + tile.cHeight; //DR_RGB565_B(tile.sColor);
						pBits[trg+1] = tile.btBlock[1]; //min(255,tile.sRegion * 3); //128 + tile.cHeight; //DR_RGB565_G(tile.sColor);
						pBits[trg+0] = tile.btBlock[2]; //min(255,tile.sRegion * 3); //128 + tile.cHeight; //DR_RGB565_R(tile.sColor);
						dwPos += sizeof(SNewFileTile);
					}
				}
			}
		}

		fwrite(pBits, bmi.biSizeImage, 1, pFile);
		delete [] pBits;
	}
	else if( pExt && _stricmp(pExt, ".RAW")==0 )
	{
// 		LPBYTE pBits  = new BYTE[ width * height ];
// 		ZeroMemory(pBits, width * height * sizeof(BYTE));
// 		int trg = 0;
// 
// 		// 读取全部Section数据
// 		for(int sy=0; sy<_nSectionCntY; sy++)
// 		{
// 			for(int sx=0; sx<_nSectionCntX; sx++)
// 			{
// 				DWORD dwDataOffset = _ReadSectionDataOffset(sx, sy);
// 				if( dwDataOffset==0 )
// 					continue;
// 
// 				DWORD dwPos = dwDataOffset - m_dwMapPos;
// 
// 				for(int y=0; y<_nSectionHeight; y++)
// 				{
// 					for(int x=0; x<_nSectionWidth; x++)
// 					{
// 						LETile LETile;
// 						LETile.Init();
// 
// 						SNewFileTile tile = *(SNewFileTile*)(m_pMapData+dwPos);
// 						trg = (height-(sy*_nSectionHeight+y)-1) * _nSectionCntX * _nSectionWidth + (sx*_nSectionWidth+x);
// 						pBits[trg] = 128 + tile.cHeight;
// 						dwPos += sizeof(SNewFileTile);
// 					}
// 				}
// 			}
// 		}
// 		fwrite(pBits, width * height * sizeof(BYTE), 1, pFile);
// 		delete [] pBits;

		LPBYTE pBits  = new BYTE[ _nSectionCntX * _nSectionCntY ];
		ZeroMemory(pBits, _nSectionCntX * _nSectionCntY * sizeof(BYTE));
		int trg = 0;

		// 读取全部Section数据
		for(int sy=0; sy<_nSectionCntY; sy++)
		{
			for(int sx=0; sx<_nSectionCntX; sx++)
			{
				DWORD dwDataOffset = _ReadSectionDataOffset(sx, sy);
				if( dwDataOffset==0 )
					continue;

				DWORD dwPos = dwDataOffset - m_dwMapPos;

				int Total = 0;
				for(int y=0; y<_nSectionHeight; y++)
				{
					for(int x=0; x<_nSectionWidth; x++)
					{
						SNewFileTile tile = *(SNewFileTile*)(m_pMapData+dwPos);
						Total += tile.cHeight;
						dwPos += sizeof(SNewFileTile);
					}
				}
				trg = (_nSectionCntY-sy-1) * _nSectionCntX + sx;
				pBits[trg] = 128 + Total / (_nSectionHeight*_nSectionWidth);
			}
		}
		fwrite(pBits, _nSectionCntX * _nSectionCntY * sizeof(BYTE), 1, pFile);
		delete [] pBits;
	}
	fclose(pFile);
	return true;
}
#endif

BOOL LEMap::Load(const char *pszMapName, BOOL bEdit)
{
	if(_fp!=NULL) 
	{
		fclose(_fp); _fp = NULL;
	}
	
	FILE *fp = NULL;
	if(bEdit)
	{
		_chmod(pszMapName, _S_IWRITE );

        fopen_s( &fp, pszMapName, "r+b");
	}
	else
	{
		fopen_s( &fp, pszMapName, "rb");
	}
	if(fp==NULL) 
	{
		LG("map", "msgLoad Map [%s] Error!\n", pszMapName);
		return FALSE;
	}
	
	LEMapFileHeader header;

	DWORD dwReadSize = 0;
	
	fread(&header, sizeof(LEMapFileHeader), 1, fp);
	dwReadSize += sizeof(LEMapFileHeader);

    if(header.nMapFlag==LE_MAP_FLAG+1)
    {
	    fclose(fp);
		LG("map", "msg该地图文件[%s]版本过期, 请使用MapTool打开它来升级版本!", pszMapName);
		return FALSE;
	}
    
#ifdef NEW_VERSION
    if(header.nMapFlag!=LE_MAP_FLAG + 3) 
#else
    if(header.nMapFlag!=LE_MAP_FLAG + 2)
#endif
	{
		fclose(fp);
		//LG("map", "msg[%s]不是有效的 LightEngine Map File!\n", pszMapName);
		return FALSE;
	}

	_nWidth			= header.nWidth;
	_nHeight		= header.nHeight;
	_nSectionWidth  = header.nSectionWidth;
	_nSectionHeight = header.nSectionHeight;

	_nSectionCntX   = _nWidth  / _nSectionWidth;
	_nSectionCntY   = _nHeight / _nSectionHeight;
	_nSectionCnt    = _nSectionCntX * _nSectionCntY;

	_bEdit = bEdit;

	_fp = fp;

    // 读取全部索引
    _pOffsetIdx = new DWORD[_nSectionCnt];
    fread(_pOffsetIdx, _nSectionCnt * 4, 1, _fp);
	dwReadSize += _nSectionCnt * 4;

	if( !_bEdit )
	{
		m_dwMapPos = ftell( _fp );

		fseek( _fp, 0, SEEK_END );
		DWORD dwPos = ftell( _fp );

		DWORD dwMapDataSize = dwPos - dwReadSize;

		if( dwMapDataSize > m_dwMapDataSize )
		{
			SAFE_DELETE_ARRAY(m_pMapData);
			m_pMapData = new BYTE[dwMapDataSize];
			m_dwMapDataSize = dwMapDataSize;
		}
		fseek( _fp, dwReadSize, SEEK_SET );
		fread( m_pMapData, dwMapDataSize, 1, _fp );
 		fclose(_fp); 
 		_fp = NULL;
	}

#ifdef _SKYBOX_
	if( m_pTerrain )
		delete m_pTerrain;
	m_pTerrain = new CTerrain;
	if( m_pTerrain )
		m_pTerrain->LoadTerrain(this);

// 	SNewFileTile* pTile = (SNewFileTile*)m_pMapData;
// 	for(int y=0; y<_nSectionCntY; y++)
// 	{
// 		for(int x=0; x<_nSectionCntX; x++)
// 		{
// 			if( pTile->sColor!=0xffffffff || pTile->cHeight!=35 )
// 			{
// 				IP("(%3d,%3d) L(%08x) T(%08x) C(%08x) H(%d), R(%d), I(%u), B[%u,%u,%u,%u]\n", x,y,
// 					pTile->dwTileInfo, pTile->btTileInfo, pTile->sColor, pTile->cHeight, 
// 					pTile->sRegion, pTile->btIsland, 
// 					pTile->btBlock[0], pTile->btBlock[1], pTile->btBlock[2], pTile->btBlock[3]);
// 			}
// 			pTile ++;
// 		}
// 	}
//
//	//把高度图存成BLE
//	char szBmp[MAX_PATH];
//	strcpy_s(szBmp, _countof(szBmp), pszMapName);
//	PSTR pExt = strrchr(szBmp, '.');
//	if( pExt )
//		strcpy_s(pExt+1, _countof(szBmp)-(pExt+1-szBmp), "RAW");
//	SaveBLE(szBmp, _nSectionCntX, _nSectionCntY, m_pMapData, TileHeight2RGB);
//	SaveHeightBLE(szBmp, _nSectionCntX*_nSectionWidth, _nSectionCntY*_nSectionHeight);
#endif

    ClearSectionArray();

	m_pBlock->Load(this);

	return TRUE;
}

int LEMap::GetValidSectionCnt()
{
    int nValidCnt = 0;
    for(int i = 0; i < _nSectionCnt; i++)
    {
        DWORD dwDataOff = *(_pOffsetIdx + i);
        if(dwDataOff) nValidCnt++;
    }
    return nValidCnt;
}

void LEMap::SetSectionTileData(int nX, int nY, BYTE btTexNo)
{
	if(btTexNo==0 || !_bEdit) return;
	
	LEActiveMapSection *pSection = GetActiveSection(nX / _nSectionWidth, nY / _nSectionHeight);
	if(!pSection) return;

	SAFE_DELETE(pSection->pTileData);
	pSection->pTileData = new LETile[_nSectionWidth * _nSectionHeight];
	for(int y = 0; y < _nSectionHeight; y++)
	{
		for(int x = 0; x < _nSectionWidth; x++)
		{
			LETile *pTile = pSection->pTileData + y * _nSectionWidth + x;
			pTile->Init();
			pTile->TexLayer[0].btTexNo   = btTexNo;
			pTile->TexLayer[0].btAlphaNo = 15;
 			pTile->fHeight = 0.6f + (float)(rand()%30) / 100.0f;
			pTile->dwColor = 0xffffffff;
            pTile->sRegion = 1; // 产生陆地属性
		}
	}
	// pSection->dwDataOffset = 0;

	_SaveSection(pSection);
}


void LEMap::_WriteSectionDataOffset(int nSectionX, int nSectionY, DWORD dwDataOffset)
{
	DWORD dwLoc = (nSectionY * _nSectionCntX + nSectionX);
    *(_pOffsetIdx + dwLoc) = dwDataOffset;
    fseek(_fp, sizeof(LEMapFileHeader) + 4 * dwLoc, SEEK_SET);
	fwrite(&dwDataOffset, 4, 1, _fp);
}

DWORD LEMap::_ReadSectionDataOffset(int nSectionX, int nSectionY)
{
	DWORD dwLoc = (nSectionY * _nSectionCntX + nSectionX);
    return *(_pOffsetIdx + dwLoc);
//     
//  fseek(_fp, sizeof(LEMapFileHeader) + 4 * dwLoc, SEEK_SET);
// 	DWORD dwDataOffset; fread(&dwDataOffset, 4, 1, _fp);
// 	return dwDataOffset;
}

//-----------------
// 保存地图区块数据
//-----------------
void LEMap::_SaveSection(LEActiveMapSection *pSection)
{
	if(!_bEdit || _fp==NULL) return;
	
	// 首先应该寻找废弃的TileData数据段
	if(pSection->dwDataOffset)
	{
		fseek(_fp, pSection->dwDataOffset, SEEK_SET);
	}
	else
	{
		fseek(_fp, 0, SEEK_END);
		pSection->dwDataOffset = ftell(_fp);
	}
#ifdef NEW_VERSION
	SNewFileTile tile;
#else
	SFileTile tile;
#endif
	for(int y = 0; y < _nSectionHeight; y++)
	{
		for(int x = 0; x < _nSectionWidth; x++)
		{
			LETile *pTile = pSection->pTileData + _nSectionWidth * y + x;
#ifdef NEW_VERSION
			TileInfo_8To5((BYTE*)(&pTile->TexLayer[0]), tile.dwTileInfo, tile.btTileInfo);
			tile.cHeight = (char)(pTile->fHeight * 100 / 10);
			tile.sColor  = DR_RGBDWORDTO565(pTile->dwColor);
#else
            memcpy(&tile.t[0], &pTile->TexLayer[0], 8);
            tile.sHeight  = (short)(pTile->fHeight * 100);
            tile.dwColor  = pTile->dwColor;
#endif
            tile.sRegion  = pTile->sRegion;
            tile.btIsland = pTile->btIsland;
            memcpy(&(tile.btBlock[0]), &(pTile->btBlock[0]), 4);
            fwrite(&tile, sizeof(tile), 1, _fp);
		}
	}
	_WriteSectionDataOffset(pSection->nX, pSection->nY, pSection->dwDataOffset);
}

//-----------------
// 读取地图区块数据
//-----------------
void LEMap::_LoadSectionData(LEActiveMapSection *pSection)
{
	int nSectionX = pSection->nX;
	int nSectionY = pSection->nY;

	pSection->dwDataOffset = _ReadSectionDataOffset(nSectionX, nSectionY);
    
    if(pSection->dwDataOffset==0) return;

	DWORD dwPos = 0;
	if( _bEdit )
	{
		assert(_fp);
		fseek(_fp, pSection->dwDataOffset, SEEK_SET);
	}
	else
	{
		dwPos = pSection->dwDataOffset - m_dwMapPos;
	}
	
	pSection->pTileData = new LETile[_nSectionWidth * _nSectionHeight];

#ifdef NEW_VERSION
	SNewFileTile tile;
#else
	SFileTile tile;
#endif

	//IP("_LoadSectionData(%d,%d) Offset=%u\n", pSection->nX, pSection->nY,pSection->dwDataOffset);
	for(int y = 0; y < _nSectionHeight; y++)
	{
		for(int x = 0; x < _nSectionWidth; x++)
		{
			LETile *pTile = pSection->pTileData + _nSectionWidth * y + x;
			pTile->Init();
			if( _bEdit )
			{
				assert(_fp);
				fread(&tile, sizeof(tile), 1, _fp);
			}
			else
			{
				memcpy( &tile, m_pMapData + dwPos, sizeof(tile) );
				dwPos += sizeof(tile);	
			}
#ifdef NEW_VERSION            
			TileInfo_5To8(tile.dwTileInfo, tile.btTileInfo, (BYTE*)(&pTile->TexLayer[0]));
            pTile->dwColor = DR_RGB565TODWORD(tile.sColor);
			pTile->dwColor|=0xff000000;
            pTile->fHeight  = (float)(tile.cHeight * 10) / 100.0f;
#else 			
			pTile->dwColor = tile.dwColor;
			memcpy(&pTile->TexLayer[0], &(tile.t[0]), 8);
            pTile->fHeight  = (float)(tile.sHeight) / 100.0f;
#endif            
			pTile->btIsland = tile.btIsland;
            pTile->sRegion  = tile.sRegion;
            memcpy(&pTile->btBlock[0], &tile.btBlock[0], 4); 
        }
	}
}


LEActiveMapSection *LEMap::LoadSectionData(int nSectionX, int nSectionY)
{
    LEActiveMapSection *pSection = new LEActiveMapSection;
	pSection->Init();
	pSection->nX = nSectionX;
	pSection->nY = nSectionY;
	
    _LoadSectionData(pSection);
    _ActiveSectionArray[nSectionY][nSectionX] = pSection;
    _ActiveSectionList.push_back(pSection);
    return pSection;
}

void LEMap::ClearSectionData(int nSectionX, int nSectionY)
{
    // 清除文件里的记录
    _WriteSectionDataOffset(nSectionX, nSectionY, 0);
    
    // 清除内存里的记录
    LEActiveMapSection *pSection = GetActiveSection(nSectionX, nSectionY);
	if(pSection) // 此Section还未读入内存
    {
        _ActiveSectionList.remove(pSection);
        _ActiveSectionArray[nSectionY][nSectionX] = NULL;
        SAFE_DELETE(pSection);
    }
}

void LEMap::FullLoading()
{
    if(_fp==NULL) return;

    // 读取全部Section数据
    for(int i = 0; i < _nSectionCnt; i++)
    {
        int nSectionX = i % _nSectionCntX;
        int nSectionY = i / _nSectionCntX;
        if(*(_pOffsetIdx + i)!=0)
        {
            LEActiveMapSection *pSection = LoadSectionData(nSectionX, nSectionY);
            _pfnProc(0, pSection->nX, pSection->nY, (DWORD)(pSection), this);
        }
    }
}

void LEMap::DynamicLoading(DWORD dwTimeParam)
{
	int nCenterSectionX = _fShowCenterX / _nSectionWidth;
	int nCenterSectionY = _fShowCenterY / _nSectionHeight;

	if( nCenterSectionX == _nLastSectionX && nCenterSectionY == _nLastSectionY )
	{
		return;
	}
	else
	{
	   _nLastSectionX = nCenterSectionX;
	   _nLastSectionY = nCenterSectionY;
	}
#ifdef __FPS_DEBUG__
	LETimer t;
    t.Begin();
#endif	
    int nCurSectionX = (int)(_fShowCenterX - (float)_nShowWidth  / 2.0f)  / _nSectionWidth;
	int nCurSectionY = (int)(_fShowCenterY - (float)_nShowHeight / 2.0f)  / _nSectionHeight;

    int nEndSectionX = (int)(_fShowCenterX + (float)_nShowWidth  / 2.0f)  / _nSectionWidth;
	int nEndSectionY = (int)(_fShowCenterY + (float)_nShowHeight / 2.0f)  / _nSectionHeight;

	int nShowSectionCntX = nEndSectionX - nCurSectionX;
	int nShowSectionCntY = nEndSectionY - nCurSectionY;
	
	if(_nShowWidth  % _nSectionWidth!=0)   nShowSectionCntX++;
	if(_nShowHeight % _nSectionHeight!=0)  nShowSectionCntY++;
	
	list<LEActiveMapSection*> _NewList;

    for(int y = 0; y < nShowSectionCntY; y++)
	{
		int nSectionY = nCurSectionY + y;

		if(nSectionY < 0 || nSectionY >= _nSectionCntY) continue;
		for(int x = 0; x < nShowSectionCntX; x++)
		{
			int nSectionX = nCurSectionX + x;

			if(nSectionX < 0 || nSectionX >= _nSectionCntX) continue;
		
			LEActiveMapSection *pSection = GetActiveSection(nSectionX, nSectionY);
			if(!pSection)
			{
				pSection = LoadSectionData(nSectionX, nSectionY);
                _NewList.push_back(pSection);
           	}
			pSection->dwActiveTime = dwTimeParam;
		}
	}

    if((int)(_ActiveSectionList.size()) >= _nSectionBufferSize)
	{
        static LEActiveMapSection *DelSectionList[MAX_DEL_SECTION];
		int n = 0;
        BOOL bDelFail = FALSE;
		for(list<LEActiveMapSection*>::iterator it = _ActiveSectionList.begin(); it!=_ActiveSectionList.end(); it++)
		{
			LEActiveMapSection *pCur = (*it);
			if(pCur->dwActiveTime!=dwTimeParam)
			{
				DelSectionList[n] = pCur;
				n++;
                if(n >= MAX_DEL_SECTION)
                {
                    bDelFail = TRUE;
                    break;
                }
			}
		}
        if(bDelFail) LG("map", "释放Section数据时, 超过最大Buffer, n = %d\n", n);
	
		for(int i = 0; i < n; i++) // 清除不需要的Section Tile Data
		{
		    UpdateRender(TRUE);
        	_ActiveSectionList.remove(DelSectionList[i]);
			if(DelSectionList[i]->dwDataOffset!=0)
			{
				_SaveSection(DelSectionList[i]);
			}
		    if(_pfnProc)	_pfnProc(1, DelSectionList[i]->nX, DelSectionList[i]->nY, (DWORD)(DelSectionList[i]),this);
			_ActiveSectionArray[DelSectionList[i]->nY][DelSectionList[i]->nX] = NULL;
        	SAFE_DELETE(DelSectionList[i]->pTileData);
			SAFE_DELETE(DelSectionList[i]);
		}
	}

    
    // 统一执行MapNotice
    for(list<LEActiveMapSection*>::iterator it = _NewList.begin(); it!=_NewList.end(); it++)
	{
        LEActiveMapSection *pNewSection = (*it); 
        if(_pfnProc) _pfnProc(0, pNewSection->nX, pNewSection->nY, (DWORD)(pNewSection),this);
	    UpdateRender(TRUE);
    }

    _NewList.clear();
    
    // g_Render.Print(INFO_DEBUG, 10, 30, "Active Map Section = %d\n", _ActiveSectionList.size());

    
    
#ifdef __FPS_DEBUG__
	m_dwActiveSectionCnt = (DWORD)(_ActiveSectionList.size());
    DWORD dwLoadingTime = t.End();
    if(dwLoadingTime > m_dwMaxLoadingTime)
    {
        m_dwMaxLoadingTime = dwLoadingTime;
    }
    
    if(dwLoadingTime)
    {
        m_dwLoadingTime[_dwLoadingCnt] = dwLoadingTime;
        _dwLoadingCnt++;
        if(_dwLoadingCnt>=3) _dwLoadingCnt = 0;
    }
#endif

	m_pBlock->GetBlockByRange(_fShowCenterX,_fShowCenterY,m_iRange);
}

void LEMap::ClearAllSection(BOOL bSaveFlag)
{
    for(list<LEActiveMapSection*>::iterator it = _ActiveSectionList.begin(); it!=_ActiveSectionList.end(); it++)
	{
		LEActiveMapSection *pSection = (*it);
		if(pSection->dwDataOffset)
		{
			if(bSaveFlag) _SaveSection((*it));
		}
	    if(bSaveFlag)
        {
            if(_pfnProc) _pfnProc(1, pSection->nX, pSection->nY, (DWORD)(pSection),this);
        }
        _ActiveSectionArray[pSection->nY][pSection->nX] = NULL;
    	SAFE_DELETE(pSection->pTileData);
		SAFE_DELETE(pSection);
	}
    
    ClearSectionArray();
   _ActiveSectionList.clear();

   SAFE_DELETE_ARRAY( m_pMapData );
}

void LEMap::ClearSectionArray()
{
	memset(&_ActiveSectionArray, 0, 512 * 512 * 4);
}




