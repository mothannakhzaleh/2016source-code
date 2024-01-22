#include "ZRBlock.h"
#include <MyMemory.h>
#include <CPerformance.h>
ZRBlock::ZRBlock()
{
	memset(m_BlockSectionArray, 0, MAX_BLOCK_SECTION*MAX_BLOCK_SECTION*4);
	m_pDefaultBlock = new ZRBlockData;
	m = NULL;
}

ZRBlock::~ZRBlock()
{
	m = NULL;
	SAFE_DELETE(m_pDefaultBlock);
}

void ZRBlock::GetBlockByRange(int CenterX, int CenterY, int range)
{
    assert(m);
	
	m_nGridShowWidth  = range * 2;
	m_nGridShowHeight = range * 2;

	m->_fShowCenterX = CenterX;
	m->_fShowCenterY = CenterY;

#ifdef __FPS_DEBUG__
    LETimer t;
    t.Begin();
#endif
    int nCurSectionX = (int)(m->_fShowCenterX - (float)range / 2.0f)  / m->_nSectionWidth;
	int nCurSectionY = (int)(m->_fShowCenterY - (float)range / 2.0f)  / m->_nSectionHeight;

    int nEndSectionX = (int)(m->_fShowCenterX + (float)range / 2.0f)  / m->_nSectionWidth;
	int nEndSectionY = (int)(m->_fShowCenterY + (float)range / 2.0f)  / m->_nSectionHeight;

	int nShowSectionCntX = nEndSectionX - nCurSectionX;
	int nShowSectionCntY = nEndSectionY - nCurSectionY;
	
	if(range  % m->_nSectionWidth!=0)   nShowSectionCntX++;
	if(range  % m->_nSectionHeight!=0)  nShowSectionCntY++;
	
    for(int y = 0; y < nShowSectionCntY; y++)
	{
		int nSectionY = nCurSectionY + y;

		if(nSectionY < 0 || nSectionY >= m->_nSectionCntY) continue;
		for(int x = 0; x < nShowSectionCntX; x++)
		{
			int nSectionX = nCurSectionX + x;

			if(nSectionX < 0 || nSectionX >= m->_nSectionCntX) continue;
		
			ZRBlockSection* pBlock = GetBlockSection(nSectionX, nSectionY);
			if(!pBlock)
			{
				pBlock = LoadBlockData(nSectionX, nSectionY);
           	}
		}
	}
}


ZRBlockSection* ZRBlock::GetBlockSection(int nSectionX, int nSectionY)
{
	return m_BlockSectionArray[nSectionX][nSectionY];
}

ZRBlockSection *ZRBlock::LoadBlockData(int nSectionX, int nSectionY)
{
    ZRBlockSection *pBlock = new ZRBlockSection;
	pBlock->nX = nSectionX;
	pBlock->nY = nSectionY;
	
    _LoadBlockData(pBlock);
    m_BlockSectionArray[nSectionX][nSectionY] = pBlock;

    return pBlock;
}


void ZRBlock::_LoadBlockData(ZRBlockSection *pBlock)
{
	assert(pBlock);
	assert(m);
	int nSectionX = pBlock->nX;
	int nSectionY = pBlock->nY;

	pBlock->dwDataOffset = m->_ReadSectionDataOffset(nSectionX, nSectionY);
    
    if(pBlock->dwDataOffset==0) return;

	DWORD dwPos = 0;
	if( m->_bEdit )
	{
		fseek(m->_fp, pBlock->dwDataOffset, SEEK_SET);
	}
	else
	{
		dwPos = pBlock->dwDataOffset - m->m_dwMapPos;
	}
	
	pBlock->pBlockData = new ZRBlockData[m->_nSectionWidth * m->_nSectionHeight];

#ifdef NEW_VERSION
	SNewFileTile tile;
#else
	SFileTile tile;
#endif
	
	//IP("_LoadBlockData(%d,%d) Offset=%u\n", pBlock->nX, pBlock->nY,pBlock->dwDataOffset);
	for(int y = 0; y < m->_nSectionHeight; y++)
	{
		for(int x = 0; x < m->_nSectionWidth; x++)
		{
			ZRBlockData *pB = pBlock->pBlockData + m->_nSectionWidth * y + x;
			if( m->_bEdit )
			{
				fread(&tile, sizeof(tile), 1, m->_fp);
			}
			else
			{
				memcpy( &tile, m->m_pMapData + dwPos, sizeof(tile) );
				dwPos += sizeof(tile);
			}
			pB->sRegion  = tile.sRegion;
            memcpy(&pB->btBlock[0], &tile.btBlock[0], 4); 
        }
	}
}


ZRBlockData*	ZRBlock::GetBlock(int nX, int nY)
{
	assert(m);
	if(nX >= m->_nWidth || nY >= m->_nHeight || nX < 0 || nY < 0) 
	{
		return m_pDefaultBlock;
	}

	int nSectionX = nX / m->_nSectionWidth;
	int nSectionY = nY / m->_nSectionHeight;

	ZRBlockSection *pBlock = GetBlockSection(nSectionX, nSectionY);
	 
	if(pBlock && pBlock->pBlockData)
	{
		int nOffX = nX % m->_nSectionWidth;
		int nOffY = nY % m->_nSectionHeight;
		return pBlock->pBlockData + nOffY * m->_nSectionWidth + nOffX;
	}

	return m_pDefaultBlock;	
}

void ZRBlock::SetGrid(int GridX, int GridY)
{
	m_nLastGridStartX = GridX;
	m_nLastGridStartY = GridY;
}

void ZRBlock::ClearSectionArray()
{
	memset(&m_BlockSectionArray, 0, MAX_BLOCK_SECTION * MAX_BLOCK_SECTION * 4);
}