#ifndef _TEXTURE_
#define _TEXTURE_

#include "StdHeader.h"
#include <string>

enum MemoryMode
{
	MM_AUTO = 0,			//自动管理
	MM_KEEPINMEMORY = 1,	//常驻内存
};

class ASE_DLL CTexture
{
public:
	CTexture();
	virtual ~CTexture();

	bool	LoadTexture(const char *szFilename, int mipLevel = 1);
	bool    LoadTextureDesc(const char *szFilename, int mipLevel = 1);
	bool	LoadAMFTexture(const char *szFilename, DWORD index = 0, int mipLevel = 1);
	bool	LoadAMFTextureDesc(const char *szFilename, DWORD index =0, int mipLevel = 1);
	int		AddRef(void);
	int		Release(void);
	void	Destroy(void);
	//---------------------------------------------------
	// Auto Access
	bool	AutoLoad(void);
	int		AutoRemove(void);
	//---------------------------------------------------
	// 2006_11_02(create keep in memory texture)
	// 字体纹理使用,动画序列帧使用
	bool	CreateTexture(int width, int height, D3DFORMAT colorFmt, D3DPOOL mem = D3DPOOL_MANAGED);
	bool	CreateMipTexture(int width, int height, D3DFORMAT colorFmt, D3DPOOL mem = D3DPOOL_MANAGED);
	//---------------------------------------------------
	IDirect3DTextureX*	GetTexture() const		{ return m_pTexture;	}
	DWORD				GetLastUseTime() const	{ return m_LastUseTime; }
	void				SetLastUseTime(DWORD tm){ m_LastUseTime = tm;	}
	MemoryMode			GetMemMode(void) const	{ return m_MemoryMode;  }
	void				SetMemMode(MemoryMode mode) { m_MemoryMode = mode; }
	int					GetWidth() const			{ return m_Width; }
	int					GetHeight()	const	{ return m_Height; }
	bool				IsRelease()	const	{ return m_IsAutoRelease;}
	std::string			GetName(void) const	{ return m_Name; }
	DWORD				GetIndex(void) const{ return (m_FileFlag & 0x00ffffff); }
//	int					GetMipMapLevel(void) const{ return m_MipmapLevel;		}
	
protected:
	bool				ReLoadAMFTexture(const char *szFilename, DWORD index, int mipLevel = 1);
	
protected:
	int			m_Ref;
	int			m_Width;
	int			m_Height;
	DWORD		m_LastUseTime;
	D3DPOOL		m_MemoryPool;

	int			m_MipmapLevel;
	DWORD		m_FileFlag;		// 自定义文件标记,带有图片索引号
	std::string m_Name;
	bool		m_IsAutoRelease;
	MemoryMode	m_MemoryMode;
	IDirect3DTextureX* m_pTexture;
};

#endif // _TEXTURE_