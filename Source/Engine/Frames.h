#ifndef _FRAMES_
#define _FRAMES_

#include "StdHeader.h"
#include <vector>
#include "Texture.h"

enum AMFType
{
	AMF_ANIMATION,	// animation
	AMF_PICTURE,	// picture group
};

struct FrameDesc
{
	int			m_Width;
	int			m_Height;
	unsigned	m_FrameCount;
	unsigned	m_Delay;
	unsigned	m_CenterX;
	unsigned	m_CenterY;
};

class ASE_DLL CFrames
{
public:
	CFrames();
	~CFrames();

	int			AddRef(void);
	int			Release(void);
	void		Destroy(void);

	bool		LoadFrame(const char* szFile);
	bool		LoadFrameDesc(const char* szFile);
	bool		LoadFrameFromTGA(const char* szFile);
	bool		LoadFrameFromTexture(CTexture* pTexture);

	int			AutoRemove(void);
	bool		AutoLoad(void);

	CTexture*	GetTexture(DWORD index);
	bool		DeleteTexture(DWORD index);

	void		GetFrameDesc(FrameDesc *pD)	const	{ *pD = m_FrameInfo;		}
	int			GetFrameCount()	const				{ return m_FrameInfo.m_FrameCount;	}
	int			GetWidth() const					{ return m_FrameInfo.m_Width;		}
	int			GetHeight()	const					{ return m_FrameInfo.m_Height;		}
	DWORD		GetDelay() const					{ return m_FrameInfo.m_Delay;		}
	void		SetDelay(DWORD delay)				{ m_FrameInfo.m_Delay = delay;		}
	int			GetSize() const						{ return (int)m_TextureVec.size();		}
	DWORD		GetLastAccess()	const				{ return m_dwLastAccess;	}
	void		SetLastAccess(DWORD dwTime)			{ m_dwLastAccess = dwTime;	}
	MemoryMode	GetMemMode(void) const				{ return m_MemoryMode;		}
	void		SetMemMode(MemoryMode mode)			{ m_MemoryMode = mode;		}
	bool		IsRelease() const					{ return m_IsAutoRelease;	}
	std::string	GetName() const						{ return m_Name;			}
	AMFType		GetType() const						{ return m_eType;			}

private:
	bool		ReLoadAMF(const char *szFileName);

private:
	std::vector<CTexture*>	m_TextureVec;
	int			m_Ref;
	FrameDesc	m_FrameInfo;
	AMFType		m_eType;

	DWORD		m_dwLastAccess;
	bool		m_IsAutoRelease;
	D3DPOOL		m_MemoryPool;
	MemoryMode	m_MemoryMode;
	std::string m_Name;
};

#endif // _FRAMES_