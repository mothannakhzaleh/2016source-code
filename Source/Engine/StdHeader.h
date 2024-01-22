#ifndef _STDHEADER_
#define _STDHEADER_

#define S_RELEASE(X)			if((X) != NULL) { (X)->Release(); (X) = NULL; } 
#define S_DELETE(X)				if((X) != NULL) { delete (X); (X) = NULL; } 
#define S_DELETE_ARRAY(X)		if((X) != NULL) { delete[] (X); (X) = NULL; } 
#define S_FREE(X)				if((X) != NULL) { free(X); (X)=NULL; } 

#include <Windows.h>
#include <log.h>

struct Height_Data
{
	unsigned char* m_pData;
	int m_Size;
};

struct Move_Vertex
{
	int xpos; 
	int zpos; 
};

struct HeightmapVertex
{
	HeightmapVertex(){}
	HeightmapVertex(float fx, float fy, float fz, DWORD dwcolor, float fu, float fv);
	void SetupVertex(int nMapX, int nMapY, int nMoveX, int nMoveY, int ofsX, int ofsY);
	float x, y, z;
	DWORD color;
	float u1, v1, u2, v2;

	static const DWORD FVF;
};

struct Boundary_3D
{
	Boundary_3D()
	{
		minx = miny = minz = 9999;
		maxx = maxy = maxz = -9999;
	} 
	float minx, maxx;
	float miny, maxy;
	float minz, maxz;
};

#define WriteLog LG
#define INFO_ERROR "error"
#define INFO_WARNING "warning"

#ifdef LIGHTENGINE_USE_DLL
	#ifdef LIGHTENGINE_EXPORTS
		#define ASE_DLL __declspec(dllexport)
	#else
		#define ASE_DLL __declspec(dllimport)
	#endif
#else
	#define ASE_DLL
#endif

// inline macro
#ifndef ASINLINE
#ifdef _MSC_VER
#if(_MSC_VER >= 1200)
#define ASINLINE __forceinline
#else
#define ASINLINE __inline
#endif
#else
#ifdef __cplusplus
#define ASINLINE inline
#else
#define ASINLINE
#endif
#endif
#endif

#define M_180_PI	57.2957795130823208768

#endif // _STDHEADER_
