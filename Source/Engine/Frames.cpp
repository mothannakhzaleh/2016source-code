#include "Stdafx.h"
#include "Frames.h"
#include "Log.h"
#include "AniFile.h"

//---------------------------------------------------
//				CFrames扩展描述
// 1,D3DPOOL_DEFAULT的资源在丢失设备时要重新加载
// 2,加载AMF中的指定图片
// 3,支持纹理组图片尺寸不一样
// 4,在texturemanager中提供frames句柄和索引读取CTexture
// 5,自动释放后内存占用高.....
//---------------------------------------------------

CFrames::CFrames()
{
	m_Ref		= 0;
	m_Name		= "";

	memset(&m_FrameInfo, 0, sizeof(FrameDesc));
	m_eType = AMF_ANIMATION;

	m_dwLastAccess = 0;
	m_MemoryPool   = D3DPOOL_MANAGED;
	m_MemoryMode   = MM_AUTO;
	m_IsAutoRelease= false;
}

CFrames::~CFrames()
{
	Destroy();
}

int CFrames::AddRef(void)
{
	return ++m_Ref;
}

int CFrames::Release(void)
{
	--m_Ref;
	if(m_Ref <= 0)
	{
		Destroy();
	}
	return m_Ref;
}

void CFrames::Destroy(void)
{
	std::vector<CTexture*>::iterator itor = m_TextureVec.begin();
	while(itor != m_TextureVec.end())
	{
		delete (*itor);
		itor++;
	}
	m_TextureVec.clear();

	if(!m_Name.empty())
	{
		m_Name.clear();
	}
	m_eType = AMF_ANIMATION;
	memset(&m_FrameInfo, 0, sizeof(FrameDesc));
	m_IsAutoRelease = false;
}

//---------------------------------------------------
// 从AMF文件中加载纹理组
//---------------------------------------------------
bool CFrames::LoadFrame(const char* szFile)
{
	if(szFile == NULL || szFile[0] == 0)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	if(m_TextureVec.size())
	{
		Destroy();
	}

	if(!ReLoadAMF(szFile))
	{
		return false;
	}

	m_Name = szFile;
	m_Ref = 1;
	m_MemoryMode = MM_AUTO;
	m_MemoryPool = D3DPOOL_MANAGED;
	m_dwLastAccess = ::timeGetTime();

	return true;
}

//---------------------------------------------------
// 从AMF文件中重新加载
//---------------------------------------------------
bool CFrames::ReLoadAMF(const char *szFileName)
{
	if(szFileName == NULL || szFileName[0] == 0)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	CAniFile anifile;
	FILE *fp = NULL;
	if( fopen_s(&fp, szFileName, "rb")!=0 )
	{
		return false;
	}
	AMFHeader header;
	if(!anifile.ReadHeader(fp, &header))
	{
		return false;
	}
	m_FrameInfo.m_Width			= header.m_Width;
	m_FrameInfo.m_Height		= header.m_Height;
	m_FrameInfo.m_Delay			= header.m_Delay;
	m_FrameInfo.m_FrameCount	= header.m_FrameCount;
	m_FrameInfo.m_CenterX		= 0;
	m_FrameInfo.m_CenterY		= 0;
	m_eType	= (AMFType)header.m_Type;
	for(unsigned i=0; i<m_FrameInfo.m_FrameCount; i++)
	{
		CTexture *pCTexture = new CTexture;
		if(pCTexture == NULL)	return false;
		AMFIndex picIndex;
		if(!anifile.ReadIndex(fp, i, &picIndex))
		{
			delete pCTexture;
			return false;
		}
		pCTexture->CreateTexture(picIndex.m_PictureWidth, picIndex.m_PictureHeight, D3DFMT_A8R8G8B8);
		IDirect3DTextureX* pTexture = pCTexture->GetTexture();
		if(pTexture==NULL)	return false;
		D3DLOCKED_RECT lrDst;
		pTexture->LockRect(0, &lrDst, 0, 0);
		if(!anifile.ReadData(fp, i, (void*)lrDst.pBits))
		{
			pTexture->UnlockRect(0);
			return false;
		}
		pTexture->UnlockRect(0);
		m_TextureVec.push_back(pCTexture);
	}
	fclose(fp);
	return true;
}

//---------------------------------------------------
// 从AMF文件中加载纹理组描述
//---------------------------------------------------
bool CFrames::LoadFrameDesc(const char* szFile)
{
	if(szFile == NULL || szFile[0] == 0)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	Destroy();

	CAniFile anifile;
	AMFHeader fileHeader;
	if(!anifile.ReadHeader(szFile, &fileHeader))
	{
		return false;
	}

	m_Name = szFile;
	m_Ref = 1;
	m_MemoryPool = D3DPOOL_MANAGED;
	m_dwLastAccess = ::timeGetTime();

	m_FrameInfo.m_Width			= fileHeader.m_Width;
	m_FrameInfo.m_Height		= fileHeader.m_Height;
	m_FrameInfo.m_Delay			= fileHeader.m_Delay;
	m_FrameInfo.m_FrameCount	= fileHeader.m_FrameCount;
	m_FrameInfo.m_CenterX		= 0;
	m_FrameInfo.m_CenterY		= 0;
	m_eType	= (AMFType)fileHeader.m_Type;
	// MM_AUTO模式
	m_IsAutoRelease = true;
	return true;
}

//--------------------------------------------------
// 读取TGA组图, 使用前应手动Destroy, 之后多次连续调用
// 扩展: 不限制TGA组的尺寸
//--------------------------------------------------
bool CFrames::LoadFrameFromTGA(const char* szFile)
{
	if(szFile == NULL || szFile[0] == 0)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	// Destroy();

	CTexture* pTexture = new CTexture;
	if(pTexture==NULL)
	{
		WriteLog(INFO_ERROR, "Memory allocate error!");
		return false;
	}

	if(!pTexture->LoadTexture(szFile))
	{
		return false;
	}
	pTexture->SetMemMode(MM_KEEPINMEMORY);
	if(m_FrameInfo.m_FrameCount==0)
	{
		m_FrameInfo.m_Width = pTexture->GetWidth();
		m_FrameInfo.m_Height = pTexture->GetHeight();
		m_FrameInfo.m_Delay = 100;
	}
	m_FrameInfo.m_FrameCount++;
	if(m_FrameInfo.m_Width!=pTexture->GetWidth())
	{
		m_eType = AMF_PICTURE;
		if(m_FrameInfo.m_Width<pTexture->GetWidth())
		{
			m_FrameInfo.m_Width = pTexture->GetWidth();
		}
	}
	if(m_FrameInfo.m_Height!=pTexture->GetHeight())
	{
		m_eType = AMF_PICTURE;
		if(m_FrameInfo.m_Height<pTexture->GetHeight())
		{
			m_FrameInfo.m_Height = pTexture->GetHeight();
		}
	}

	m_Ref = 1;
	// can't auto reload
	m_Name = "TGA Group";
	m_MemoryMode = MM_KEEPINMEMORY;
	m_MemoryPool = D3DPOOL_MANAGED;
	m_dwLastAccess = ::timeGetTime();
	m_TextureVec.push_back(pTexture);

	return true;
}

//--------------------------------------------------
// 由Texture添加, 使用前应手动Destroy, 之后多次连续调用
// Texture应new生成的,且不在TextureManager中的.
// Texture必须是MM_KEEPINMEMORY的
//--------------------------------------------------
bool CFrames::LoadFrameFromTexture(CTexture* pTexture)
{
	if(pTexture == NULL)
	{
		WriteLog(INFO_ERROR, "Invalidate parameter!");
		return false;
	}
	// 应确保该指针不在m_TextureVec中
	pTexture->SetMemMode(MM_KEEPINMEMORY);
	if(m_FrameInfo.m_FrameCount==0)
	{
		m_FrameInfo.m_Width = pTexture->GetWidth();
		m_FrameInfo.m_Height = pTexture->GetHeight();
		m_FrameInfo.m_Delay = 100;
	}
	m_FrameInfo.m_FrameCount++;
	if(m_FrameInfo.m_Width!=pTexture->GetWidth())
	{
		m_eType = AMF_PICTURE;
		if(m_FrameInfo.m_Width<pTexture->GetWidth())
		{
			m_FrameInfo.m_Width = pTexture->GetWidth();
		}
	}
	if(m_FrameInfo.m_Height!=pTexture->GetHeight())
	{
		m_eType = AMF_PICTURE;
		if(m_FrameInfo.m_Height<pTexture->GetHeight())
		{
			m_FrameInfo.m_Height = pTexture->GetHeight();
		}
	}

	m_Ref = 1;
	// can't auto reload
	// m_Name = "Texture Point Group";
	m_MemoryMode = MM_KEEPINMEMORY;
	m_MemoryPool = D3DPOOL_MANAGED;
	m_dwLastAccess = ::timeGetTime();
	m_TextureVec.push_back(pTexture);

	return true;
}

//---------------------------------------------------
// 自动释放
//---------------------------------------------------
int CFrames::AutoRemove(void)
{
	if(m_TextureVec.size())
	{
		std::vector<CTexture*>::iterator itor = m_TextureVec.begin();
		while(itor != m_TextureVec.end())
		{
			delete (*itor);
			itor++;
		}
		m_TextureVec.clear();
	}

	m_IsAutoRelease = true;
	return m_Ref;
}

//---------------------------------------------------
// 自动加载
//---------------------------------------------------
bool CFrames::AutoLoad(void)
{
	if(m_IsAutoRelease && !m_Name.empty())
	{
		if(!ReLoadAMF(m_Name.c_str()))
		{
			return false;
		}

		m_IsAutoRelease = false;
	}
	return true;
}

//---------------------------------------------------
// 获取指定索引的纹理
//---------------------------------------------------
CTexture* CFrames::GetTexture(DWORD index)
{
	AutoLoad();
	if(m_TextureVec.size())
	{
		DWORD frame = index % m_TextureVec.size();
		return m_TextureVec[frame];
	}
	return NULL;
}

//---------------------------------------------------
// 删除指定索引的纹理(提供给编辑器的接口)
// 必须重新加载LoadFromFrame到与之关联的CAnimation对象.
// 不要用在MM_AUTO模式的纹理组(数据会不同步)
//---------------------------------------------------
bool CFrames::DeleteTexture(DWORD index)
{
	if(m_TextureVec.size())
	{
		DWORD frame = index % m_TextureVec.size();
		std::vector<CTexture*>::iterator itor = m_TextureVec.begin()+index;
		while(itor != m_TextureVec.end())
		{
			delete (*itor);
			m_TextureVec.erase(itor);
			m_FrameInfo.m_FrameCount = m_FrameInfo.m_FrameCount-1;
			return true;
		}
	}
	return false;
}
