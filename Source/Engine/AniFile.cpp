#include "Stdafx.h"
#include "StdHeader.h"
#include "AniFile.h"
#include "Frames.h"

CAniFile::CAniFile()
{
	m_Delay = 100;
}

CAniFile::~CAniFile()
{
}

//---------------------------------------------------
//				base information
// 1, 基于文件大小考虑, AMF文件中的图像不支持多层Mipmap
//---------------------------------------------------

//---------------------------------------------------
// 保存到AMF文件(编辑器使用)
//---------------------------------------------------
bool CAniFile::SaveAMF(const char *szFileName, CFrames *pFrame) const
{
	if(pFrame==NULL || szFileName==NULL)
	{
		return false;
	}
	FILE* fp = NULL;
	if( fopen_s(&fp, szFileName, "wb")!=0 )
	{
		return false;
	}
	AMFHeader header;
	memset(&header, 0, sizeof(AMFHeader));
	header.m_Signature = 'HFMA';
	header.m_Width = pFrame->GetWidth();
	header.m_Height = pFrame->GetHeight();
	header.m_FrameCount = pFrame->GetFrameCount();
	header.m_Delay = (WORD)m_Delay;
	header.m_Type = pFrame->GetType();;
	header.m_Version = 1000;
	fwrite(&header, sizeof(AMFHeader), 1, fp);
	fseek(fp, sizeof(AMFIndex)*header.m_FrameCount, SEEK_CUR);
	AMFIndex picIndex;
	picIndex.m_PictureIndex = ftell(fp);
	for(int i=0; i<header.m_FrameCount; i++)
	{
		CTexture* pCTexture = pFrame->GetTexture(i);
		if(pCTexture == NULL)	return false;
		DWORD Width = pCTexture->GetWidth();
		DWORD Height = pCTexture->GetHeight();
		picIndex.m_PictureWidth = Width;
		picIndex.m_PictureHeight = Height;
		
		IDirect3DTextureX* pTexture = pCTexture->GetTexture();
		if(pTexture == NULL)	return false;
		D3DLOCKED_RECT d3dlr;
		pTexture->LockRect(0, &d3dlr, 0, 0);
		DWORD dstSize = 0;
		// 两倍空间
		BYTE* pData = new BYTE[Width * Height * sizeof(DWORD)*2];
		if(pData==NULL)
			return false;
		CompressData(d3dlr.pBits, pData, Width * Height * sizeof(DWORD), dstSize);
		pTexture->UnlockRect(0);
		picIndex.m_PictureSize = dstSize;
		fseek(fp, sizeof(AMFIndex)*i+sizeof(AMFHeader), SEEK_SET);
		fwrite(&picIndex, sizeof(AMFIndex), 1, fp);

		fseek(fp, picIndex.m_PictureIndex, SEEK_SET);
		fwrite(pData, dstSize, 1, fp);
		picIndex.m_PictureIndex = ftell(fp);
		delete [] pData;
		pData = NULL;
	}

	fclose(fp);

	return true;
}

//---------------------------------------------------
// 读取文件头
//---------------------------------------------------
bool CAniFile::ReadHeader(const char *szFileName, AMFHeader *head) const
{
	if(szFileName==NULL || head==NULL)
	{
		return false;
	}
	FILE* fp = NULL;
	if( fopen_s(&fp, szFileName, "rb")!=0 )
	{
		return false;
	}

	fread(head, sizeof(AMFHeader), 1, fp);
	if(head->m_Signature!='HFMA')
	{
		MessageBox(NULL, "Invalid AMF File!", NULL, MB_OK);
		return false;
	}
	fclose(fp);
	return true;
}

//---------------------------------------------------
// 读取文件头
//---------------------------------------------------
bool CAniFile::ReadHeader(FILE *pFile, AMFHeader *head) const
{
	if(pFile==NULL || head==NULL)
	{
		return false;
	}
	fseek(pFile, 0, SEEK_SET);
	fread(head, sizeof(AMFHeader), 1, pFile);
	if(head->m_Signature!='HFMA')
	{
		MessageBox(NULL, "Invalid AMF File!", NULL, MB_OK);
		return false;
	}
	return true;
}

//---------------------------------------------------
// 读取数据块索引
//---------------------------------------------------
bool CAniFile::ReadIndex(const char *szFileName, const DWORD &index, AMFIndex *amfindex) const
{
	if(szFileName==NULL || amfindex==NULL)
	{
		return false;
	}
	FILE* fp = NULL;
	if( fopen_s(&fp, szFileName, "rb")!=0 )
	{
		return false;
	}
	AMFHeader header;
	fread(&header, sizeof(AMFHeader), 1, fp);
	if(header.m_Signature!='HFMA')
	{
		MessageBox(NULL, "Invalid AMF File!", NULL, MB_OK);
		return false;
	}

	if(header.m_FrameCount==0)	
		return false;
	if(index>=header.m_FrameCount)	
		return false;

	fseek(fp, sizeof(AMFIndex) * index + sizeof(AMFHeader), SEEK_SET);
	fread(amfindex, sizeof(AMFIndex), 1, fp);

	fclose(fp);
	return true;
}

//---------------------------------------------------
// 读取数据块索引
//---------------------------------------------------
bool CAniFile::ReadIndex(FILE *pFile, const DWORD &index, AMFIndex *amfindex) const
{
	if(pFile==NULL || amfindex==NULL)
	{
		return false;
	}
	
	AMFHeader header;
	fseek(pFile, 0, SEEK_SET);
	fread(&header, sizeof(AMFHeader), 1, pFile);
	if(header.m_Signature!='HFMA')
	{
		MessageBox(NULL, "Invalid AMF File!", NULL, MB_OK);
		return false;
	}

	if(header.m_FrameCount==0)	
		return false;
	if(index>=header.m_FrameCount)	
		return false;

	fseek(pFile, sizeof(AMFIndex) * index + sizeof(AMFHeader), SEEK_SET);
	fread(amfindex, sizeof(AMFIndex), 1, pFile);

	return true;
}

//---------------------------------------------------
// 读取数据块
//---------------------------------------------------
bool CAniFile::ReadData(const char *szFileName, const DWORD &index, void *pData) const
{
	if(szFileName==NULL || pData==NULL)
	{
		return false;
	}
	FILE* fp = NULL;
	if( fopen_s(&fp, szFileName, "rb")!=0 )
	{
		return false;
	}
	AMFHeader header;
	fread(&header, sizeof(AMFHeader), 1, fp);
	if(header.m_Signature!='HFMA')
	{
		MessageBox(NULL, "Invalid AMF File!", NULL, MB_OK);
		return false;
	}

	if(header.m_FrameCount==0)	
		return false;
	if(index>=header.m_FrameCount)	
		return false;

	fseek(fp, sizeof(AMFIndex) * index + sizeof(AMFHeader), SEEK_SET);
	AMFIndex amfindex;
	fread(&amfindex, sizeof(AMFIndex), 1, fp);
	fseek(fp, amfindex.m_PictureIndex, SEEK_SET);
	BYTE* pTempData = new BYTE[amfindex.m_PictureSize];
	if(pTempData==NULL)	
		return false;

	fread(pTempData, amfindex.m_PictureSize, 1, fp);
	DWORD dstSize = 0;
	DeCompressData(pTempData, pData, amfindex.m_PictureSize, dstSize);
	delete [] pTempData;
	pTempData = NULL;

	fclose(fp);
	return true;
}

//---------------------------------------------------
// 读取数据块
//---------------------------------------------------
bool CAniFile::ReadData(FILE *pFile, const DWORD &index, void *pData) const
{
	if(pFile==NULL || pData==NULL)
	{
		return false;
	}

	AMFHeader header;
	fseek(pFile, 0, SEEK_SET);
	fread(&header, sizeof(AMFHeader), 1, pFile);
	if(header.m_Signature!='HFMA')
	{
		MessageBox(NULL, "Invalid AMF File!", NULL, MB_OK);
		return false;
	}

	if(header.m_FrameCount==0)	
		return false;
	if(index>=header.m_FrameCount)	
		return false;

	fseek(pFile, sizeof(AMFIndex) * index + sizeof(AMFHeader), SEEK_SET);
	AMFIndex amfindex;
	fread(&amfindex, sizeof(AMFIndex), 1, pFile);
	fseek(pFile, amfindex.m_PictureIndex, SEEK_SET);
	BYTE* pTempData = new BYTE[amfindex.m_PictureSize];
	if(pTempData==NULL)	
		return false;

	fread(pTempData, amfindex.m_PictureSize, 1, pFile);
	DWORD dstSize = 0;
	DeCompressData(pTempData, pData, amfindex.m_PictureSize, dstSize);
	delete [] pTempData;
	pTempData = NULL;

	return true;
}

//---------------------------------------------------
// RLE压缩算法(可能dstSize大于srcSize)
//---------------------------------------------------
void CAniFile::CompressData(const void *pSrc, void *pDst, const DWORD &srcSize, DWORD &dstSize) const
{
	if((pSrc == NULL) || (pDst == NULL) || srcSize <= 0)
	{
		return;
	}

	int totalCompress = 0;
	int repCount = 1;
	DWORD	blockHead = 0;

	DWORD *pComData = (DWORD *)pDst;
	DWORD *pRawData = (DWORD *)pSrc;

	int len = srcSize >> 2;
	dstSize = 0;

	while(totalCompress < len)
	{
		if(!(*(pRawData+repCount-1) & 0xff000000) && !(*(pRawData+repCount) & 0xff000000))
		{	// 通道为0x00
			while(!(*(pRawData+repCount-1) & 0xff000000) && !(*(pRawData+repCount) & 0xff000000) 
				&& ((totalCompress+repCount)<len))
			{
				++repCount;
			}

			blockHead = 0x11000000 | repCount;
			*pComData++ = blockHead;

			dstSize += 1;

		}
		else if(*pRawData == *(pRawData+repCount))
		{	// 颜色相同
			while(*pRawData == *(pRawData+repCount) 
				&& ((totalCompress+repCount)<len))
			{
				++repCount;
			}
			blockHead = 0x10000000 | repCount;
			*pComData++ = blockHead;
			*pComData++ = *pRawData;

			dstSize += 2;
		}
		else 
		{
			// 颜色不同
			while(*(pRawData+repCount-1) != *(pRawData+repCount) 
				&& ((totalCompress+repCount)<len)) 
			{
				if(!(*(pRawData+repCount-1) & 0xff000000) && !(*(pRawData+repCount)&0xff000000))
				{
					break;
				}
				++repCount;
			}
			
			blockHead = 0x00000000 | repCount;
			*pComData++ = blockHead;
			memcpy(pComData, pRawData, sizeof(DWORD)*repCount);
			pComData += repCount;

			dstSize += repCount+1;
		}
		pRawData += repCount;
		totalCompress += repCount;
		repCount = 1;
	}

	dstSize *= 4;
}

//---------------------------------------------------
// RLE解压缩算法
//---------------------------------------------------
bool CAniFile::DeCompressData(const void *pSrc, void *pDst, const DWORD &srcSize, DWORD &dstSize) const
{
	if((pSrc == NULL) || (pDst == NULL) || srcSize <= 0)
	{
		return false;
	}
	DWORD totalSize = srcSize >> 2;
	DWORD *pDSrc = (DWORD *)pSrc;
	DWORD *pDstData = (DWORD *)pDst;

	dstSize = 0;
	DWORD deCompress = 0;
	DWORD nowSize = 0;
	//-----------------
	// C++版本
	//-----------------
	/*
	while(nowSize < totalSize)
	{
		DWORD blockData = 0;		
		blockData = *pDSrc++;
		if(!(blockData & 0xff000000))
		{
			int len = blockData & 0x00ffffff;
			memcpy(pDstData, pDSrc, sizeof(DWORD)*len);
			pDstData += len;
			pDSrc += len;
			nowSize += len+1;
				
			dstSize += len;
		}
		else
		{
			int len = blockData & 0x00ffffff;
			DWORD CompData = 0;
			if(!(blockData & 0x0f000000))
			{
				CompData = *pDSrc++;
				nowSize += 1;
			}
			for(int i=0; i<len; i++)
			{
				*pDstData++ = CompData;
			}
			nowSize += 1;
				
			dstSize += len;
		}	
	}
	dstSize *= 4;
	*/
	//-----------------
	// asm版本
	//-----------------
	__asm
	{
			mov  esi, pDSrc
			mov  edi, pDstData
loop_start: 
			lodsd						; 将block读取到eax中
			mov  ebx, eax
			and  ebx, 0x00ffffff		; ebx 存放数据的长度信息
			and  eax, 0xff000000
			jnz  compress			
			; 原始数据
			mov  ecx, ebx

			cld
			rep  movsd

			mov  edx, ebx				; 获取length + 1
			inc  edx    
			jmp  new_block

compress: 
			mov  ecx, ebx				; 压缩数据
			mov  edx, 0x01

			and	 eax, 0x0f000000
			jnz  loadzero
			lodsd
			inc	 edx
			jmp  notloadzero
loadzero:
			mov	 eax, 0
notloadzero:
			cld
			rep  stosd
			
new_block: 
			add	 deCompress, ebx		; 计算总的长度信息
			add  nowSize, edx			; 计算当前已经解压的长度

			mov  eax, nowSize
			cmp  eax, totalSize
			jnz  loop_start
	};  
	dstSize = 4 * deCompress;
	
	return true;
}
