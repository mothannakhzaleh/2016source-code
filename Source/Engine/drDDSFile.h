//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drDirectX.h"
#include "drInterfaceExt.h"

#include "drDDS.h"


DR_BEGIN

class drDDSFile : public drIDDSFile
{
    DR_STD_DECLARATION()

private:
    IDirect3DDeviceX* _dev;
    IDirect3DBaseTextureX* _dds_tex;
    IDirect3DBaseTextureX* _origin_tex;
    DWORD _cubemap_flag;
    DWORD _volume_depth;
    DWORD _tex_width;
    DWORD _tex_height;
    DWORD _mip_level;

private:
    DR_RESULT Compress(D3DFORMAT new_fmt);

    inline BOOL IsVolumeMap() const { return _volume_depth > 0; }
    inline BOOL IsCubeMap() const { return _cubemap_flag; }
	HRESULT BltAllLevels(D3DCUBEMAP_FACES FaceType, IDirect3DBaseTextureX* ptexSrc, IDirect3DBaseTextureX* ptexDest);
    HRESULT SaveDDSHeader(IDirect3DBaseTextureX* tex, FILE* fp);
	HRESULT SaveAllMipSurfaces(IDirect3DBaseTextureX* ptex, D3DCUBEMAP_FACES FaceType, FILE* fp);
	HRESULT SaveAllVolumeSurfaces(IDirect3DVolumeTextureX* pvoltex, FILE* fp);

public:
    drDDSFile();
    ~drDDSFile();

    void SetDevice(IDirect3DDeviceX* dev) { _dev = dev; }
    DR_RESULT Clear();
    //DR_RESULT Load(BYTE* data);
    //DR_RESULT Load(const char* file);
    DR_RESULT LoadOriginTexture(const char* file, DWORD mip_level, D3DFORMAT format, DWORD colorkey);
    DR_RESULT Convert(const char* file, D3DFORMAT src_fmt, D3DFORMAT dds_fmt, DWORD mip_level, DWORD src_colorkey);
    DR_RESULT Save(const char* file);
    

    //IDirect3DBaseTextureX* DetachOriginTexture();
    //IDirect3DBaseTextureX* DetachDDSTexture();

};

DR_END
