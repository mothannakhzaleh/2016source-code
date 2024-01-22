#ifndef _TEXTUREMANAGER_
#define _TEXTUREMANAGER_

#include <map>
#include "Texture.h"
#include "LERender.h"

typedef DWORD TextureHandle;

#define	BASEHANDLE	5000
#define UPDATETIME	3000
#define MAXEXIST	5000
#define INVALID_HANDLE 0x00

//---------------------------------------------------
// 指定的句柄范围是1~5000,非指定的为5000+
// 指定的为非共享纹理,非指定的为共享纹理
// 会有同文件名的多个纹理,释放只提供句柄操作不提供文件名操作
// QueryHandle为共享纹理,返回值5000+
//---------------------------------------------------

class ASE_DLL CTextureManager
{
public:
	CTextureManager();
	~CTextureManager();

	TextureHandle	LoadTexture(const char *szFilename, MemoryMode mode = MM_AUTO, int mipLevel = 1);
	TextureHandle	LoadAMFTexture(const char *szFilename, DWORD index = 0, MemoryMode mode = MM_AUTO, int mipLevel = 1);
	TextureHandle	LoadTextureDesc(const char *szFilename, int mipLevel = 1);
	TextureHandle	LoadAMFTextureDesc(const char *szFilename, DWORD index = 0, int mipLevel = 1);
	TextureHandle	InsertTexture(CTexture *pTexture, MemoryMode mode = MM_AUTO);
	TextureHandle	LoadTextureFromMem(int width, int height, const DWORD *pData);

	bool	LoadTexture(TextureHandle hTex, const char *szFilename, MemoryMode mode = MM_AUTO, int mipLevel = 1);
	bool	LoadAMFTexture(TextureHandle hTex, const char *szFilename, DWORD index = 0, MemoryMode mode = MM_AUTO, int mipLevel = 1);
	bool	LoadTextureDesc(TextureHandle hTex, const char *szFilename, int mipLevel = 1);
	bool	LoadAMFTextureDesc(TextureHandle hTex, const char *szFilename, DWORD index = 0, int mipLevel = 1);
	bool	BatchLoad(const char *szIniFile);	

	void	ReleaseTexture(TextureHandle texHandle);
	void	DestroyTexture(TextureHandle texHandle);
	void	DestroyAll(void);

	CTexture* GetTexture(TextureHandle texHandle);
	void	Update(void);

	bool	LockTexture(TextureHandle texHandle, D3DLOCKED_RECT *pLockedRect, RECT *pRc = NULL);
	void	UnLockTexture(TextureHandle texHandle);
	// D3DPOOL_DEFAULT的资源在丢失设备时要重新加载
private:
	TextureHandle CreateHandle(void);
	TextureHandle QueryHandle(const char *szFilename, DWORD index = 0);
private:
	std::map<TextureHandle, CTexture*>	m_TextureMap;
	DWORD			m_CurHandle;
	DWORD			m_UpdateTime;
};

extern LIGHTENGINE_API CTextureManager* g_pTextureManager;

// Texture Macro
#ifndef SET_TEXTURE_UNTYPE
#define SET_TEXTURE_UNTYPE(stage, handle)  \
	pTexture = g_pTextureManager->GetTexture(handle);	\
	if(!pTexture) return;	\
	if(pTexture->AutoLoad())	\
{	\
	g_Render.GetDevice()->SetTexture((stage), pTexture->GetTexture());	\
}
#endif // SET_TEXTURE_UNTYPE

#ifndef SET_TEXTURE_TYPE
#ifndef SET_TEXTURE_UNTYPE
#error (SET_TEXTURE_UNTYPE) macro undefine!
#endif
#define SET_TEXTURE_TYPE(stage, handle) CTexture* SET_TEXTURE_UNTYPE(stage, handle)
#endif // SET_TEXTURE_TYPE

#endif // _TEXTUREMANAGER_