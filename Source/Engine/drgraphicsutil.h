//
#pragma once

#include "drHeader.h"
#include "drExpObj.h"
#include "drFrontAPI.h"
#include "drITypes.h"

class CGraphicsFileData;


#ifdef USE_LIGHTENGINE
#include "GlobalInc.h"
#endif

DR_BEGIN


//
#define DR_RGB555_R(rgb) (BYTE)( ( rgb & 0x7c00) >> 7 )
#define DR_RGB555_G(rgb) (BYTE)( ( rgb & 0x3e0) >> 2 )
#define DR_RGB555_B(rgb) (BYTE)( ( rgb & 0x1f) << 3 )

#define DR_RGB565_R(rgb) (BYTE)( ( rgb & 0xf800) >> 8 )
#define DR_RGB565_G(rgb) (BYTE)( ( rgb & 0x7e0) >> 3 )
#define DR_RGB565_B(rgb) (BYTE)( ( rgb & 0x1f) << 3 )

#define DR_RGB555TODWORD(rgb) (DWORD)( DR_RGB555_R(rgb) | (DR_RGB555_G(rgb)<<8) | (DR_RGB555_B(rgb)<<16) )
#define DR_RGB565TODWORD(rgb) (DWORD)( DR_RGB565_R(rgb) | (DR_RGB565_G(rgb)<<8) | (DR_RGB565_B(rgb)<<16) )


#define DR_RGBDWORDTO555(color) (WORD)( ((color&0xf8)<<7) | ((color & 0xf800)>>6) | ((color & 0xf80000)>>19) )
#define DR_RGBDWORDTO565(color) (WORD)( ((color&0xf8)<<8) | ((color & 0xfC00)>>5) | ((color & 0xf80000)>>19) )

inline WORD drGetRGB555WithDWORD(DWORD color) { return DR_RGBDWORDTO555(color); }
inline WORD drGetRGB565WithDWORD(DWORD color) { return DR_RGBDWORDTO565(color); }



struct drTexDataInfo
{
    void* data;
    DWORD size;
    DWORD pitch;
    DWORD width;
    DWORD height;
};

struct drMeshDataInfo
{
    void* vb_data;
    void* ib_data;

    DWORD vb_size;
    DWORD vb_stride;

    DWORD ib_size;
    DWORD ib_stride;
};

inline void drMeshDataInfo_Construct(drMeshDataInfo* obj)
{
    obj->vb_data = 0;
    obj->ib_data = 0;
    obj->vb_size = 0;
    obj->vb_stride = 0;
    obj->ib_size = 0;
    obj->ib_stride = 0;
}
inline void drMeshDataInfo_Destruct(drMeshDataInfo* obj)
{
    DR_IF_DELETE_A(obj->vb_data);
    DR_IF_DELETE_A(obj->ib_data);
}

/////////////////
#ifndef USE_LIGHTENGINE
DR_FRONT_API void drMessageBox( const char* fmt, ... );
#else
#ifndef USE_LG_MSGBOX
#define USE_LG_MSGBOX
inline void __cdecl LGX(const char* format, ...)
{
    char buf[512];
    buf[0] = 'm';
    buf[1] = 's';
    buf[2] = 'g';
    buf[3] = 0;
    
    va_list args;
    va_start( args, format );
    _vsntprintf( &buf[3], 512, format, args );
    va_end( args );

    LG("default", buf);
}

#define drMessageBox LGX
#endif

#endif

DR_FRONT_API float drGetFPS();

DR_FRONT_API void drConvertTgaDataToColorValue(drColorValue4b* dst_data,const CGraphicsFileData* tga, DWORD colorkey_type, drColorValue4b* colorkey );
DR_FRONT_API int drLoadColorValue( drColorValue4b** buf, int* width, int* height, const char* file );
DR_FRONT_API void drFreeColorValue( drColorValue4b* buf );
//int drLoadTexture( IDirect3DTextureX** tex, IDirect3DDeviceX* dev, const char* file, DWORD level, DWORD usage, D3DFORMAT fmt, D3DPOOL pool );

DR_FRONT_API DR_RESULT drLoadTexture( IDirect3DTextureX** tex, IDirect3DDeviceX* dev, const char* file, DWORD usage, D3DFORMAT fmt, D3DPOOL pool );
DR_FRONT_API DR_RESULT drLoadTexDataInfo(drTexDataInfo* info, const char* file, DWORD format, DWORD colorkey_type, drColorValue4b* colorkey, int use_power_size);
DR_FRONT_API DR_RESULT drLoadMeshDataInfo( drMeshDataInfo* info, const drMeshInfo* mi );
DR_FRONT_API DWORD drGetTexFlexibleSize( DWORD size );

DR_FRONT_API void drScreenToWorld( drVector3* org, drVector3* ray, int x, int y, int width, int height, const drMatrix44* mat_proj, const drMatrix44* mat_view );
DR_FRONT_API void drWorldToScreen( int* x, int* y, float* z, const drVector3* vec, int width, int height, const drMatrix44* mat_proj, const drMatrix44* mat_view );

DR_FRONT_API void drGetBoxVertLineList( drVector3* vert_seq, const drBox* box );
DR_FRONT_API void drGetBoxTriangleList( drVector3* vert_seq, DWORD* index_seq, const drBox* box );
DR_FRONT_API void drGetBoxTriangleList(drVector3* vert36_seq, drVector3* normal36_seq, const drVector3* size);
DR_FRONT_API void drBuildVertexNormalWithTriangleList(drVector3* normal_seq, const drVector3* vert_seq, const DWORD* index_seq, DWORD vert_num, DWORD index_num);

DR_FRONT_API void drGetCubeMapViewMatrix(drMatrix44* mat, DWORD face);

DR_FRONT_API DR_RESULT drHitTestBox( drPickInfo* info, const drVector3* org, const drVector3* ray, const drBox* box, const drMatrix44* mat );

DR_FRONT_API DR_RESULT drSetRenderState( drRenderStateValue* rs_seq, DWORD rs_num, DWORD state, DWORD value );
DR_FRONT_API DR_RESULT drClearRenderState( drRenderStateValue* rs_seq, DWORD rs_num, DWORD state );


DR_FRONT_API DR_RESULT drExtractMeshData(drMeshInfo* info, void* vb_data, void* ib_data, DWORD vert_num, DWORD index_num, D3DFORMAT vb_fvf, D3DFORMAT ib_fvf);
DR_FRONT_API DWORD drGetSurfaceSize(UINT width, UINT height, D3DFORMAT format);
DR_FRONT_API DR_RESULT drGetDirectXVersion(char* o_buf, DWORD version);
//
DR_END
