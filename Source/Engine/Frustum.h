#ifndef _FRUSTUM_
#define _FRUSTUM_

#include <Windows.h>

#define MOVE_MAP_SIZE	256
#define MOVE_MAP_SCALE	4	// 移动图映射到高度图

enum ViewPoint
{
	VP_LEFT_BACK,
	VP_RIGHT_BACK,
	VP_RIGHT_FRONT,
	VP_FOCUS_FRONT,
	VP_LEFT_FRONT,

	VP_MAX_NUM,
};

class CFrustum
{
public:
	CFrustum();
	~CFrustum();

	void   InitFrustum(int halfFOV, int distance);
	void   UpdateFrustum();
	bool   IsInFrustum(int X, int Z);

	ViewPoint       m_minZ;
	ViewPoint		m_maxZ;
	unsigned char   m_LeftArray[MOVE_MAP_SIZE];   
	unsigned char   m_RightArray[MOVE_MAP_SIZE];  
	float           m_ViewerRotate;
	POINT           m_pos[VP_MAX_NUM]; 

private:
	void   LinearArray(int startx, int startz, int endx, int endz,
					   unsigned char *pArray, bool bLeft); 

	int    m_HalfFOV;
	int    m_ViewDistance;

};

#endif // _FRUSTUM_