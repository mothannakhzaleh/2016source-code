#pragma once

#include "TableData.h"
#include "LERender.h"

#pragma warning(disable: 4275)

class LIGHTENGINE_API LETexInfo : public CRawDataInfo
{
public:
	
	LETexInfo()
	{
		bAlpha   = 0;
        btMipmap = 5;
        bExist   = TRUE;
		pData	 = NULL;
	}

public:	

	BYTE    bAlpha;
    BYTE    btMipmap;
	short	sWidth;
	short	sHeight;
	void*	pData;
};

#pragma pack(push,__Data_Align)
#pragma pack(1)

struct STGAHeader
{
	unsigned char    id_len;
	unsigned char    cm_type;
	unsigned char    type;
	unsigned short   cm_start;
	unsigned short   cm_len;
	unsigned char    cm_bits;
	unsigned short   xorg;
	unsigned short   yorg;
	unsigned short   width;
	unsigned short   height;
	unsigned char    bpp;
	unsigned char    flags;
};

#pragma pack(pop,__Data_Align)


class LIGHTENGINE_API LETexSet : public CRawDataSet
{

public:
	
	static LETexSet* I() { return _Instance; }

    LETexSet(int nIDStart, int nIDCnt)
	:CRawDataSet(nIDStart, nIDCnt)
	{
	    _Init();
        _Instance = this;
        _nTextureLevel = D3DX_DEFAULT;
		CRawDataSet::SetReleaseInterval(8000);
	}

    
	inline void* GetRawData(int nID, BOOL bRequest = FALSE)
	{
		LETexInfo* pInfo = (LETexInfo*)GetRawDataInfo(nID);
		if(pInfo == NULL) return NULL;

		pInfo->dwLastUseTick = GetTickCount();
		if(!pInfo->pData)
		{
		  if(bRequest && _bEnableRequest)
		  {
			//          LG2("debug", "Push Request RawData!\n");
			_RequestList.push_back(nID);
			return NULL;
		  }

		  pInfo->pData = _CreateNewRawData(pInfo);
		  pInfo->dwLoadCnt++;
		  if(pInfo->pData == NULL)
		  {
			LG2("error", "Load Raw Data [%s] Failed! (ID = %d)\n", pInfo->szDataName, nID);
		  } else
		  {
			_nLoadedRawDataCnt++;
		  }
		}
		return pInfo->pData;
	}

	inline void* GetRawData(const char* pszDataName, int* pnID)
	{
		int nID = GetRawDataID(pszDataName);
		if(pnID) *pnID = nID;
		if(nID == -1)
		{
		  return NULL;
		}
		return GetRawData(nID);
	}

	
	inline void DynamicRelease(BOOL bClearAll = false)
	{
		if(bClearAll)
		{
		  if(_nLoadedRawDataCnt > 0) //°²È«ÊÍ·ÅÄÚ´æ by Waiting 2009-06-18
		  {
			for(int i = 0; i < _nIDCnt; i++)
			{
			  LETexInfo* pInfo = (LETexInfo*)GetRawDataInfo(_nIDStart + i);
			  if(pInfo == NULL || pInfo->pData == NULL) continue; //°²È«ÊÍ·ÅÄÚ´æ by Waiting 2009-06-18
			  _DeleteRawData(pInfo);
			  pInfo->pData = NULL;
			  _nLoadedRawDataCnt--;
			  if(_nLoadedRawDataCnt < 0)
			  {
				LG2("error", "LoadedRawDataCnt = %d , < 0 ?\n", _nLoadedRawDataCnt);
			  }
			}
		  }
		  return;
		}

		if(_IsFull() == FALSE) return;

		DWORD dwCurTick = GetTickCount();

		if(_nLoadedRawDataCnt > 0) //°²È«ÊÍ·ÅÄÚ´æ by Waiting 2009-06-18
		{
		  for(int i = 0; i < _nIDCnt; i++)
		  {
			LETexInfo* pInfo =(LETexInfo*) GetRawDataInfo(_nIDStart + i);
			if(pInfo == NULL || pInfo->pData == NULL) continue; //°²È«ÊÍ·ÅÄÚ´æ by Waiting 2009-06-18

			if((dwCurTick - pInfo->dwLastUseTick) > _dwReleaseInterval)
			{
			  _DeleteRawData(pInfo);
			  pInfo->pData = NULL;
			  _nLoadedRawDataCnt--;
			  if(_nLoadedRawDataCnt < 0)
			  {
				LG2("error", "LoadedRawDataCnt = %d , < 0 ?\n", _nLoadedRawDataCnt);
			  }
			  // LG2("debug", "Dynamic Release Raw Data [%s]\n", pInfo->szDataName);
			}
		  }
		}
	}

	inline void Release()
	{
		if(_nLoadedRawDataCnt > 0) //��ȫ�ͷ��ڴ� by Waiting 2009-06-18
		{
		  for(int i = 0; i < _nIDCnt; i++)
		  {
			LETexInfo* pInfo = (LETexInfo*) GetRawDataInfo(_nIDStart + i);
			if(NULL == pInfo || NULL == pInfo->pData) //��ȫ�ͷ��ڴ� by Waiting 2009-06-18
			  continue;

			_DeleteRawData(pInfo);
			pInfo->pData = NULL;
			_nLoadedRawDataCnt--;
			if(_nLoadedRawDataCnt < 0)
			{
			  LG2("error", "LoadedRawDataCnt = %d , < 0 ?\n", _nLoadedRawDataCnt);
			}
		  }
		}
		//��ȫ�ͷ��ڴ� by Waiting 2009-06-18
		if(_RawDataArray)
		{
		  _DeleteRawDataArray();
		  _RawDataArray = NULL;
		}
		_nUnusedIndex = 0;
	}

	BOOL IsAlphaTGA(char* pFileBuf)
	{
		STGAHeader header;
		memcpy(&header, pFileBuf, sizeof(STGAHeader));
		return (header.bpp == 32);
	}

	BOOL IsAlphaTexture(int nID)
	{
		LETexInfo* pInfo = (LETexInfo*)GetRawDataInfo(nID);
		if(pInfo && pInfo->bAlpha== 1)
		{
			return TRUE;
		}
		return FALSE;
	}

	void    ReloadAllTexture()
    {
		if( _nLoadedRawDataCnt<=0 ) 
			return;

		for(int i = 0; i < _nIDCnt; i++)
		{
			LETexInfo* pInfo = (LETexInfo*)GetRawDataInfo(_nIDStart + i);
			if(pInfo && pInfo->pData) 
			{
				_DeleteRawData(pInfo);
				pInfo->pData = NULL;
				_nLoadedRawDataCnt--;
				if(_nLoadedRawDataCnt < 0)
				{
					LG("error", "LoadedRawDataCnt = %d , < 0 ?\n", _nLoadedRawDataCnt);
				}
				GetRawData(pInfo->nID);
			}
		}
    }
    
    void    SetTextureLevel(int nLevel, BOOL bUpdateAll = FALSE)
    {
        if(_nTextureLevel!=nLevel)
        {
            _nTextureLevel = nLevel;
            ReloadAllTexture();
        }
    }

    int     GetTextureLevel()  { return _nTextureLevel; }

protected:

	static LETexSet* _Instance; // Ïàµ±ÓÚµ¥¼ü, °Ñ×Ô¼º¼Ç×¡
    
    virtual CRawDataInfo* _CreateRawDataArray(int nIDCnt)
	{
		return new LETexInfo[nIDCnt];
	}
	
	virtual void _DeleteRawDataArray()
	{
		delete[] (LETexInfo*)_RawDataArray;
	}
	
	virtual int _GetRawDataInfoSize()
	{
		return sizeof(LETexInfo);
	}

	virtual BOOL _IsFull()
	{
		// Èç¹ûÏÔ´æÕ¼ÓÃ³¬¹ý8M,Ôò¿ªÊ¼½øÐÐ½çÃæÌùÍ¼ºÍµØ±íÌùÍ¼µÄ¶¯Ì¬ÊÍ·Å
		DWORD dwMem = g_Render.GetRegisteredDevMemSize();
//		static DWORD s_dwOld = 0;
//		if( s_dwOld!=dwMem )
//		{
//			s_dwOld = dwMem;
//			LG("vmem", "vmem = %d k\n", dwMem / 1024);
//		}
		if(dwMem >= 64 * 1024 * 1024)
		{
			return TRUE;
		}
		return FALSE;
	}

	virtual void* _CreateNewRawData(CRawDataInfo *pInfo)
	{
#define USE_MANAGED_TEXTURE

#ifdef USE_MANAGED_TEXTURE

        LETexInfo *pTexInfo = (LETexInfo*)pInfo;
        drITex* tex;
        drIResourceMgr* res_mgr = g_Render.GetInterfaceMgr()->res_mgr;
        res_mgr->CreateTex(&tex);

        drTexInfo tex_info;
        drTexInfo_Construct(&tex_info);
        _tcsncpy_s(tex_info.file_name, pTexInfo->szDataName, _TRUNCATE );
//³ö½ç, ¶àÁË1 -Waiting Fix 2009-03-13
//      _tcslwr_s(tex_info.file_name, sizeof( tex_info.file_name) + 1 );
		_tcslwr_s(tex_info.file_name, sizeof( tex_info.file_name) );
        tex_info.pool = D3DPOOL_MANAGED;
        tex_info.usage = 0;
        tex_info.level = D3DX_DEFAULT;
        tex_info.type = TEX_TYPE_FILE;


        D3DFORMAT tex_fmt[2];
        tex_fmt[0] = g_Render.GetTexSetFormat(0);
        tex_fmt[1] = g_Render.GetTexSetFormat(1);

        // Õë¶ÔddsÎÄ¼þ¸ñÊ½²»ÐèÒªÉèÖÃ£¬Ö»ÅÐ¶Ïtga¸ñÊ½
        /*
        BYTE* pbtBuf = LoadRawFileData(pTexInfo);
        if(pbtBuf)
        {
            tex_info.format = tex_fmt[IsAlphaTGA((char*)pbtBuf)];
            delete[] pbtBuf;
        }
        else
        {
            tex_info.format = tex_fmt[0];
        }
        */
        size_t l = _tcslen(tex_info.file_name);
        if(tex_info.file_name[l - 1] == 'a'
            && tex_info.file_name[l - 2] == 'g'
            && tex_info.file_name[l - 3] == 't')
        {
            tex_info.format = tex_fmt[1];
        }
        else
        {
            tex_info.format = tex_fmt[0];
        }

#if 1
        if(_tcsstr(tex_info.file_name, "ui"))
        {
            tex_info.level = D3DX_DEFAULT;

            size_t str_len = _tcslen(tex_info.file_name);

            if(_tcsicmp(&tex_info.file_name[str_len - 3], "bmp") == 0)
            {
                tex_info.colorkey_type = COLORKEY_TYPE_COLOR;
                tex_info.colorkey.color = 0xffff00ff;
                tex_info.format = tex_fmt[1];
            }
        }
#endif

        tex->LoadTexInfo(&tex_info, NULL);
        tex->LoadVideoMemory();

		tex->GetTexInfo(&tex_info);

        //return tex->GetTex();
		pTexInfo->sWidth  = (short)tex_info.width;
		pTexInfo->sHeight = (short)tex_info.height; 
//		LG("tex_release", "Load Texture [%s] size = %d %d, id = %d\n",  pTexInfo->szDataName, pTexInfo->sWidth, pTexInfo->sHeight, pInfo->nID);
        return tex;


#else
        LETexInfo *pTexInfo = (LETexInfo*)pInfo;

        char pszSrcName[64] = "";
        
        BOOL bReplaceDataName = FALSE;
        if(_nTextureLevel > 0)
        {
            strncpy_s(pszSrcName, pTexInfo->szDataName, _TRUNCATE);
            char *pszLevelTex = "tex___1";
            memcpy(pTexInfo->szDataName, pszLevelTex, 7);
            
            if(!Util_IsFileExist(pTexInfo->szDataName))
            {
               strncpy_s(pTexInfo->szDataName, pszSrcName, _TRUNCATE);
            }
            else
            {
                bReplaceDataName = TRUE;
            }
        }
        
        
        BOOL bDDS = FALSE;
		DWORD  dwBufSize;
		
		// get 'dds' texture file name
		CRawDataInfo ddsInfo;
		int len = (int)(strlen(pInfo->szDataName));
		strncpy_s(ddsInfo.szDataName, pInfo->szDataName, _TRUNCATE);
		ddsInfo.szDataName[len - 3] = 'd';
		ddsInfo.szDataName[len - 2] = 'd';
		ddsInfo.szDataName[len - 1] = 's';

		// try 'dds' texture at 1st time 
		LPBYTE pbtBuf = NULL;
		
		/*
		if(pTexInfo->nMipmap != 0xff && g_pDevice->m_bEnableDXT)	// UI texture don't use 'dds'
		//if (0)
		{
			pbtBuf = LoadRawFileData(&ddsInfo);
		}
		*/

		if (!pbtBuf) 
		{
			// try 'tga' texture at 2nd time 
			pbtBuf = LoadRawFileData(pTexInfo);
			if (!pbtBuf)
			{
		        if(bReplaceDataName)
                {
                    strncpy_s(pTexInfo->szDataName, pszSrcName, _TRUNCATE);
                }
        		return NULL;
			}
			else
			{
				dwBufSize = pTexInfo->dwDataSize;
			}
		}
		else
		{
			dwBufSize = ddsInfo.dwDataSize;

			/*DDSURFACEDESC2 ddsc2;
			memcpy(&ddsc2, pbtBuf + 4, sizeof(DDSURFACEDESC2));
			if (ddsc2.dwAlphaBitDepth > 0)
			{
				pTexInfo->bAlpha = 1;
			}
			else
			{
				pTexInfo->bAlpha = 0;
			}*/
			bDDS = TRUE;
		}
		
        if(bReplaceDataName)
        {
           strncpy_s(pTexInfo->szDataName, pszSrcName, _TRUNCATE );
        }
        		
		if (!bDDS)
		{
			if(IsAlphaTGA((char*)pbtBuf))
			{
				pTexInfo->bAlpha = 1;
			}
			else
			{
				pTexInfo->bAlpha = 0;
			}
		}

        DWORD   dwUsage  = 0;
        D3DPOOL Manage   = D3DPOOL_MANAGED;
        DWORD   dwFilter = D3DX_FILTER_NONE;
		DWORD   dwMipFilter = D3DX_FILTER_NONE;
		BYTE btMipMapLv = 1;
        if(pTexInfo->btMipmap != 0xff)
        {
            dwFilter    = D3DX_FILTER_LINEAR;
			dwMipFilter = D3DX_DEFAULT;
			btMipMapLv  = pTexInfo->btMipmap;
        }
    
        btMipMapLv  = D3DX_DEFAULT;
        
		// DWORD  dwBufSize = pInfo->dwDataSize;
		
		IDirect3DTextureX* pTexture = NULL;
	

		D3DFORMAT fmt = D3DFMT_R5G6B5;
		if(pTexInfo->bAlpha) fmt = D3DFMT_A4R4G4B4;

		if( FAILED( D3DXCreateTextureFromFileInMemoryEx(g_Render.GetDevice(),
			pbtBuf,
			dwBufSize,
			D3DX_DEFAULT,				// default width
			D3DX_DEFAULT,				// default height
		    btMipMapLv,					// mipmap level
			dwUsage,					// usage
			// D3DFMT_DXT3,
			fmt,			       		// Texture Format
			Manage, 	        		// Pool
			dwFilter,       			// texture filter
			dwMipFilter,				// MipMap filter
			0x00000000,					// Alpha 
			NULL,						// info
			NULL,						// palette
			&pTexture) ))				// texture
		{	
			// texture
			LG("error", "Create Texture From Data[%s] Failed!\n", pInfo->szDataName);
			pTexture = NULL;
		}
		else
		{
			LG("debug", "Load Texture Data [%s]\n", pInfo->szDataName);
			//D3DSURFACE_DESC desc;
			//pTexture->GetLevelDesc(0, &desc);
			//pTexInfo->nWidth  = desc.Width;
			//pTexInfo->nHeight = desc.Height;
		}
		delete[] pbtBuf;

		return pTexture;
#endif
	}

	virtual void  _DeleteRawData(CRawDataInfo *pInfo)
	{
		LETexInfo *pTexInfo = (LETexInfo*)pInfo;
//      LG("tex_release", "Release Texture Data [%s], size = %d %d\n", pTexInfo->szDataName, pTexInfo->sWidth, pTexInfo->sHeight);
        // __asm
        // {
        //    int 3;
        // }
#if(defined USE_MANAGED_TEXTURE)
        drITex* pTex = (drITex*)pTexInfo->pData;
#else
		IDirect3DTextureX* pTex = (IDirect3DTextureX*)(pInfo->pData);
#endif
		SAFE_RELEASE(pTex);
	}
	
	virtual BOOL _ReadRawDataInfo(CRawDataInfo *pRawDataInfo, vector<string> &ParamList)
	{
        if(ParamList.size()==0) return FALSE;
		
        string strParam;
		for(vector<string>::iterator it = ParamList.begin(); it!=ParamList.end(); it++)
		{
			strParam+=(*it);
		}
		
		LETexInfo *pTexInfo = (LETexInfo*)pRawDataInfo;
        return TRUE;
    }

protected:

    int     _nTextureLevel;
};

//--------------
// ¿ì½ÝÈ«¾Öº¯Êý:
//--------------

inline drITex* GetTexByID(int nID, BOOL bRequest = FALSE)
{
    drITex* tex = (drITex*)LETexSet::I()->GetRawData(nID, bRequest);
    return tex;
}

inline IDirect3DTextureX* GetTextureByID(int nID, BOOL bRequest = FALSE) // Í¨¹ýIDÈ¡µÃTexture±íÃæ
{
#ifdef USE_MANAGED_TEXTURE
    drITex* tex = (drITex*)LETexSet::I()->GetRawData(nID, bRequest);
    return tex ? tex->GetTex() : 0;
#else
    return (IDirect3DTextureX*)LETexSet::I()->GetRawData(nID, bRequest);
#endif
}

inline SIZE GetTextureSizeByID(int nID)
{
    SIZE sz = { 0, 0};
#ifdef USE_MANAGED_TEXTURE
    drITex* tex = (drITex*)LETexSet::I()->GetRawData(nID, 0);
    if(tex)
    {
        drTexInfo info;
        tex->GetTexInfo(&info);
        sz.cx = info.width;
        sz.cy = info.height;
    }
#endif

    return sz;
}

inline int GetTextureID(const char *pszDataName)  // Í¨¹ýÃû×ÖÈ¡µÃTexture ID, Èç¹ûÊÇ¶¯Ì¬ID·½Ê½ÓÖÃ»ÓÐ²éÕÒµ½ID, ¾Í»á×Ô¶¯·ÖÅäÒ»¸ö, ·µ»Ø-1±íÊ¾Ê§°Ü
{
    if(LETexSet::I()!=NULL)
	{
		return LETexSet::I()->GetRawDataID(pszDataName);
	}
	return 0;
}

inline LETexInfo* GetTextureInfo(int nID) // Í¨¹ýIDÈ¡µÃTextureÃèÊöÐÅÏ¢
{
	if(LETexSet::I()!=NULL)
	{
		return (LETexInfo*)LETexSet::I()->GetRawDataInfo(nID);
	}
	return NULL;
}

inline BOOL IsAlphaTexture(int nID)
{
	LETexInfo *pInfo = GetTextureInfo(nID);
	if(!pInfo) return FALSE;
	return pInfo->bAlpha==1;
}

inline BOOL IsTextureExist(const char *pszDataName)
{
    if(LETexSet::I()->IsEnablePack()==FALSE) // ·Ç´ò°ü·½Ê½ÏÂ
    {
        if(Util_IsFileExist((char*)pszDataName))
        {
            return TRUE;
        }
        return FALSE;
    }
    else
    {
        LETexInfo *pInfo = (LETexInfo*)LETexSet::I()->GetRawDataInfo(pszDataName);
        if(pInfo)
        {
            return TRUE;
        }
        return FALSE;
    }
    return FALSE;
}

#pragma warning(default: 4275)
