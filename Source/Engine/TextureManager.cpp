#include "Stdafx.h"
#include <stdio.h>
#include <string>
#include "TextureManager.h"
#include "Log.h"

LIGHTENGINE_API CTextureManager* g_pTextureManager = NULL;	// 有效期: Application(Init-Destory)

CTextureManager::CTextureManager()
{
	m_CurHandle = BASEHANDLE;
	m_UpdateTime = 0;
}

CTextureManager::~CTextureManager()
{
	DestroyAll();
}

//---------------------------------------------------
// 加载共享纹理
//---------------------------------------------------
TextureHandle CTextureManager::LoadTexture(const char *szFilename, MemoryMode mode /* = MM_AUTO */, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0)
	{
		return INVALID_HANDLE;
	}

	TextureHandle hTex = QueryHandle(szFilename);
	if(hTex == INVALID_HANDLE)
	{
		CTexture * pTexture = new CTexture;
		if(!pTexture->LoadTexture(szFilename, mipLevel))
		{
			delete (pTexture);
			return INVALID_HANDLE;
		}
		pTexture->SetMemMode(mode);
		hTex = CreateHandle();
		m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	}
	return hTex;
}

//---------------------------------------------------
// 加载共享纹理(从AMF文件)
//---------------------------------------------------
TextureHandle CTextureManager::LoadAMFTexture(const char *szFilename, DWORD index /* = 0 */, 
											  MemoryMode mode /* = MM_AUTO */, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0)
	{
		return INVALID_HANDLE;
	}

	TextureHandle hTex = QueryHandle(szFilename, index);
	if(hTex == INVALID_HANDLE)
	{
		CTexture * pTexture = new CTexture;
		if(!pTexture->LoadAMFTexture(szFilename, index, mipLevel))
		{
			delete (pTexture);
			return INVALID_HANDLE;
		}
		pTexture->SetMemMode(mode);
		hTex = CreateHandle();
		m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	}
	return hTex;
}

//---------------------------------------------------
// 加载共享纹理描述
//---------------------------------------------------
TextureHandle CTextureManager::LoadTextureDesc(const char *szFilename, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0)
	{
		return INVALID_HANDLE;
	}

	TextureHandle hTex = QueryHandle(szFilename);
	if(hTex == INVALID_HANDLE)
	{
		CTexture * pTexture = new CTexture;
		if(!pTexture->LoadTextureDesc(szFilename, mipLevel))
		{
			delete (pTexture);
			return INVALID_HANDLE;
		}
		hTex = CreateHandle();
		m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	}
	return hTex;
}

//---------------------------------------------------
// 加载共享纹理描述(AMF)
//---------------------------------------------------
TextureHandle CTextureManager::LoadAMFTextureDesc(const char *szFilename, DWORD index /* = 0 */, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0)
	{
		return INVALID_HANDLE;
	}

	TextureHandle hTex = QueryHandle(szFilename, index);
	if(hTex == INVALID_HANDLE)
	{
		CTexture * pTexture = new CTexture;
		if(!pTexture->LoadAMFTextureDesc(szFilename, index, mipLevel))
		{
			delete (pTexture);
			return INVALID_HANDLE;
		}
		hTex = CreateHandle();
		m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	}
	return hTex;
}

//---------------------------------------------------
// 加载指定句柄的非共享纹理
//---------------------------------------------------
bool CTextureManager::LoadTexture(TextureHandle hTex, const char *szFilename, 
								  MemoryMode mode /* = MM_AUTO */, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0 || hTex>BASEHANDLE)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	if(m_TextureMap.find(hTex) != m_TextureMap.end())
	{
		WriteLog(INFO_WARNING, "Texture Handle has been used![%s]", szFilename);
		return false;
	}
	CTexture * pTexture = new CTexture;
	if(!pTexture->LoadTexture(szFilename, mipLevel))
	{
		delete (pTexture);
		return false;
	}
	pTexture->SetMemMode(mode);
	m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	return true;
}

//---------------------------------------------------
// 加载指定句柄的非共享纹理(AMF文件)
//---------------------------------------------------
bool CTextureManager::LoadAMFTexture(TextureHandle hTex, const char *szFilename, DWORD index /* = 0 */, 
									 MemoryMode mode /* = MM_AUTO */, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0 || hTex>BASEHANDLE)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	if(m_TextureMap.find(hTex) != m_TextureMap.end())
	{
		CTexture *pTex = GetTexture(hTex);
		if(pTex)
		{
			if(pTex->GetIndex() == index)
			{
				WriteLog(INFO_WARNING, "Texture Handle has been used![%s]", szFilename);
				return false;
			}
			else
			{
				pTex->Release();
				if(pTex->LoadAMFTexture(szFilename, index, mipLevel))
				{
					pTex->SetMemMode(mode);
					return true;
				}
			}
		}
		return false;
	}
	CTexture * pTexture = new CTexture;
	if(!pTexture->LoadAMFTexture(szFilename, index, mipLevel))
	{
		delete (pTexture);
		return false;
	}
	pTexture->SetMemMode(mode);
	m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	return true;
}

//---------------------------------------------------
// 加载非共享纹理的描述
//---------------------------------------------------
bool CTextureManager::LoadTextureDesc(TextureHandle hTex, const char *szFilename, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0 || hTex>BASEHANDLE)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	if(m_TextureMap.find(hTex) != m_TextureMap.end())
	{
		WriteLog(INFO_WARNING, "Texture Handle has been used![%s]", szFilename);
		return false;
	}
	CTexture * pTexture = new CTexture;
	if(!pTexture->LoadTextureDesc(szFilename, mipLevel))
	{
		delete (pTexture);
		return false;
	}
	m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	return true;
}

//---------------------------------------------------
// 加载非共享纹理的描述(AMF)
//---------------------------------------------------
bool CTextureManager::LoadAMFTextureDesc(TextureHandle hTex, const char *szFilename, 
										 DWORD index /* = 0 */, int mipLevel /* = 1 */)
{
	if(szFilename == NULL || szFilename[0] == 0 || hTex>BASEHANDLE)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	if(m_TextureMap.find(hTex) != m_TextureMap.end())
	{
		WriteLog(INFO_WARNING, "Texture Handle has been used![%s]", szFilename);
		return false;
	}
	CTexture * pTexture = new CTexture;
	if(!pTexture->LoadAMFTextureDesc(szFilename, index, mipLevel))
	{
		delete (pTexture);
		return false;
	}
	m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	return true;
}

//---------------------------------------------------
// 从INI文件批加载非共享纹理
//---------------------------------------------------
bool CTextureManager::BatchLoad(const char *szIniFile)
{
	if(szIniFile == NULL || szIniFile[0] == 0)
	{
		return false;
	}
	FILE* fp = NULL;
	if( fopen_s(&fp, szIniFile, "r")!=0 )
	{
		WriteLog(INFO_ERROR, "Can't open file[%s]!", szIniFile);
		return false;
	}

	int		nHandle, nInMem, nDesc, nIndex, nMipmap;
	char	*TOKEN = " \t\n\r";
	char*	nexttoken;
	char	*temp, szTemp[256];
	char    *szFilename;
	std::string strFileName;

	while(!feof(fp))
	{
		fgets(szTemp, 256, fp);
		if(szTemp[0] != '#')
		{
			szTemp[0]	= 0;
			continue;
		}
		temp = szTemp;
		++temp;
		nHandle	= atoi(strtok_s(temp, TOKEN, &nexttoken));
		nInMem = atoi(strtok_s(0, TOKEN, &nexttoken));
		nDesc = atoi(strtok_s(0, TOKEN, &nexttoken));
		nIndex = atoi(strtok_s(0, TOKEN, &nexttoken));
		nMipmap = atoi(strtok_s(0, TOKEN, &nexttoken));
		szFilename	= strtok_s(0, TOKEN, &nexttoken);
		_strlwr_s(szFilename, strlen(szFilename)+1);
		strFileName = szFilename;

		bool bAMF = false;
		std::string::size_type pos;
		pos = strFileName.find('.');
		if(pos == std::string::npos)
		{
			return false;
		}
		else
		{
			std::string strext = strFileName.substr(pos, strFileName.length()-pos);
			if(strext == ".amf")
			{
				bAMF = true;
			}
		}

		if(nInMem)
		{
			if(bAMF)
			{
				LoadAMFTexture(nHandle, szFilename, nIndex, MM_KEEPINMEMORY, nMipmap);
			}
			else
			{
				LoadTexture(nHandle, szFilename, MM_KEEPINMEMORY, nMipmap);
			}
		}
		else
		{
			if(bAMF)
			{
				if(nDesc)	LoadAMFTextureDesc(nHandle, szFilename, nIndex, nMipmap);
				else		LoadAMFTexture(nHandle, szFilename, nIndex, MM_AUTO, nMipmap);
			}
			else
			{
				if(nDesc)	LoadTextureDesc(nHandle, szFilename, nMipmap);
				else		LoadTexture(nHandle, szFilename, MM_AUTO, nMipmap);
			}
		}
	}
	fclose(fp);

	return true;
}

//---------------------------------------------------
// 插入共享纹理(未加载后的纹理也可以,最好使用MM_KEEPINMEMORY)
//---------------------------------------------------
TextureHandle CTextureManager::InsertTexture(CTexture *pTexture, MemoryMode mode)
{
	if(pTexture == NULL)
	{
		return INVALID_HANDLE;
	}
	pTexture->SetMemMode(mode);
	TextureHandle hTex = CreateHandle();
	m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pTexture));
	return hTex;
}

//---------------------------------------------------
// 由内存生成纹理(支持mipmap, 必须为A8R8G8B8的数据, 长宽必须为2次方)
//---------------------------------------------------
TextureHandle CTextureManager::LoadTextureFromMem(int width, int height, const DWORD *pData)
{
	if(pData == NULL)	return INVALID_HANDLE;

	CTexture * pCTexture = new CTexture;
	if(!pCTexture->CreateMipTexture(width, height, D3DFMT_A8R8G8B8))
	{
		delete (pCTexture);
		return INVALID_HANDLE;
	}
		
	IDirect3DTextureX *pTexture = pCTexture->GetTexture();
	D3DLOCKED_RECT lrDst;
	pTexture->LockRect(0, &lrDst, 0, 0);
	DWORD* pDst = (DWORD*)(lrDst.pBits);
	for(int i=0; i<height; i++)
	{
		for(int j=0; j<width; j++)
		{
			pDst[i*(lrDst.Pitch/4)+j] = pData[i*width+j];
		}
	}
	pTexture->UnlockRect(0);
	D3DXFilterTexture(pTexture, 0, 0, D3DX_DEFAULT);

	DWORD hTex = CreateHandle();
	m_TextureMap.insert(std::map<TextureHandle, CTexture*>::value_type(hTex, pCTexture));
	return hTex;
}

//---------------------------------------------------
// 获取纹理
//---------------------------------------------------
CTexture* CTextureManager::GetTexture(TextureHandle texHandle)
{
	if(texHandle==INVALID_HANDLE)
		return NULL;
	std::map<TextureHandle, CTexture*>::iterator itor = m_TextureMap.find(texHandle);
	if(itor != m_TextureMap.end())
	{
		(*itor).second->SetLastUseTime(::timeGetTime());
		return (*itor).second;
	}
	return NULL;
}

//---------------------------------------------------
// 释放纹理
//---------------------------------------------------
void CTextureManager::ReleaseTexture(TextureHandle texHandle)
{
	if(texHandle==INVALID_HANDLE)
		return;
	std::map<TextureHandle, CTexture*>::iterator itor = m_TextureMap.find(texHandle);
	if(itor != m_TextureMap.end())
	{
		if((*itor).second->Release()<=0)
		{
			delete ((*itor).second);
			m_TextureMap.erase(itor);
			return;
		}
	}
}

//---------------------------------------------------
// 删除纹理
//---------------------------------------------------
void CTextureManager::DestroyTexture(TextureHandle texHandle)
{
	if(texHandle==INVALID_HANDLE)
		return;
	std::map<TextureHandle, CTexture*>::iterator itor = m_TextureMap.find(texHandle);
	if(itor != m_TextureMap.end())
	{
		delete ((*itor).second);
		m_TextureMap.erase(itor);
		return;
	}
}

//---------------------------------------------------
// 删除所有纹理
//---------------------------------------------------
void CTextureManager::DestroyAll(void)
{
	std::map<TextureHandle, CTexture*>::iterator itor = m_TextureMap.begin();
	while(itor!=m_TextureMap.end())
	{
		// 调用析构函数Destroy释放m_pTexture
		delete ((*itor).second);
		itor++;
	}
	m_TextureMap.clear();
}

//---------------------------------------------------
// 自动管理纹理
//---------------------------------------------------
void CTextureManager::Update(void)
{
	DWORD tm = ::timeGetTime();
	if(tm - m_UpdateTime>UPDATETIME)
	{
		std::map<TextureHandle, CTexture*>::iterator itor = m_TextureMap.begin();
		while(itor != m_TextureMap.end())
		{
			if((tm-(*itor).second->GetLastUseTime())>MAXEXIST 
				&& !((*itor).second->IsRelease())
				&& (*itor).second->GetMemMode()==MM_AUTO)
			{
				(*itor).second->AutoRemove();
			}
			itor++;
		}
		m_UpdateTime = tm;
	}
}

//---------------------------------------------------
// 查询共享句柄(5000+)
// 5000以下不参与共享
//---------------------------------------------------
TextureHandle CTextureManager::QueryHandle(const char *szFilename, DWORD index /* = 0 */)
{
	std::map<TextureHandle, CTexture*>::iterator itor = m_TextureMap.begin();
	while(itor!=m_TextureMap.end())
	{
		if((*itor).second->GetName() == szFilename && (*itor).first>BASEHANDLE &&
		   (*itor).second->GetIndex() == index)
		{
			(*itor).second->AddRef();
			return (*itor).first;
		}
		itor++;
	}
	return INVALID_HANDLE;
}

//---------------------------------------------------
// 创建唯一的共享句柄(5000+)
//---------------------------------------------------
TextureHandle CTextureManager::CreateHandle(void)
{
	m_CurHandle++;
	while(m_TextureMap.end() != m_TextureMap.find(m_CurHandle))
	{
		m_CurHandle++;
	}
	if(m_CurHandle==INVALID_HANDLE)
	{
		m_CurHandle = BASEHANDLE;
	}
	return m_CurHandle;
}

//---------------------------------------------------
// 锁定
//---------------------------------------------------
bool CTextureManager::LockTexture(TextureHandle texHandle, D3DLOCKED_RECT *pLockedRect, RECT *pRc)
{
	CTexture *pTex = GetTexture(texHandle);
	if(!pTex)
		return false;
	if(pTex->AutoLoad())
	{
		return SUCCEEDED(pTex->GetTexture()->LockRect(0, pLockedRect, pRc, 0));
	}
	return false;
}

//---------------------------------------------------
// 解锁
//---------------------------------------------------
void CTextureManager::UnLockTexture(TextureHandle texHandle)
{
	CTexture *pTex = GetTexture(texHandle);
	if(!pTex)
		return;
	if(pTex->AutoLoad())
	{
		pTex->GetTexture()->UnlockRect(0);
	}
}

// end of this file 2006.10.27 artsylee
