#include <math.h>
#include "Frustum.h"
// add
//#include "Common.h"

CFrustum::CFrustum()
{
	m_HalfFOV = 45;
	m_ViewerRotate = 0;
	// 50×îºÃ.
	// 45-80
	m_ViewDistance = 45;

	for(int i=0; i<VP_MAX_NUM; i++)
	{
		m_pos[i].x = 0;
		m_pos[i].y = 0;
	}
	m_minZ = VP_LEFT_BACK;
	m_maxZ = VP_LEFT_BACK;

	for(int i=0; i<MOVE_MAP_SIZE; i++)
	{
		m_LeftArray[i] = 0;
		m_RightArray[i] = 0;
	}
}

CFrustum::~CFrustum()
{
}

void CFrustum::InitFrustum(int halfFOV, int distance)
{
	m_HalfFOV = halfFOV;
	m_ViewDistance = distance;
	if(m_ViewDistance>125)
	{
		m_ViewDistance = 125;
	}
}

void CFrustum::UpdateFrustum()
{
	// ~~~~~~~~~~~~~~~~~~
	/*
	m_ViewerRotate = 0.0f;
	m_HalfFOV = 40;
	m_ViewDistance = 50;
	*/
	// ~~~~~~~~~~~~~~~~~~
	
	m_pos[VP_LEFT_BACK].x	= MOVE_MAP_SIZE/2+int(MOVE_MAP_SCALE*sinf((m_ViewerRotate+150.0f)*0.01745329f));
	m_pos[VP_LEFT_BACK].y	= MOVE_MAP_SIZE/2+int(MOVE_MAP_SCALE*cosf((m_ViewerRotate+150.0f)*0.01745329f));

	m_pos[VP_RIGHT_BACK].x	= MOVE_MAP_SIZE/2+int(MOVE_MAP_SCALE*sinf((m_ViewerRotate-150.0f)*0.01745329f));
	m_pos[VP_RIGHT_BACK].y	= MOVE_MAP_SIZE/2+int(MOVE_MAP_SCALE*cosf((m_ViewerRotate-150.0f)*0.01745329f));

	m_pos[VP_RIGHT_FRONT].x = MOVE_MAP_SIZE/2+int(m_ViewDistance*sinf((m_ViewerRotate-m_HalfFOV)*0.01745329f));
	m_pos[VP_RIGHT_FRONT].y = MOVE_MAP_SIZE/2+int(m_ViewDistance*cosf((m_ViewerRotate-m_HalfFOV)*0.01745329f));

	m_pos[VP_FOCUS_FRONT].x = MOVE_MAP_SIZE/2+int(m_ViewDistance*sinf(m_ViewerRotate*0.01745329f));
	m_pos[VP_FOCUS_FRONT].y = MOVE_MAP_SIZE/2+int(m_ViewDistance*cosf(m_ViewerRotate*0.01745329f));

	m_pos[VP_LEFT_FRONT].x	= MOVE_MAP_SIZE/2+int(m_ViewDistance*sinf((m_ViewerRotate+m_HalfFOV)*0.01745329f));
	m_pos[VP_LEFT_FRONT].y	= MOVE_MAP_SIZE/2+int(m_ViewDistance*cosf((m_ViewerRotate+m_HalfFOV)*0.01745329f));
	
	/*
	// ×ø±êÖá
	g_pGraphics->Line(0, 0, 100, 0, 0xffff0000);
	g_pGraphics->Line(0, 0, 0, 100, 0xffff0000);
	g_pGraphics->Line(50, 50, 0, 0, 0xffff0000);
	DrawSingleLine(435, 215, 0xffff0000, false, "x");
	DrawSingleLine(382, 166, 0xffff0000, false, "z");
	DrawSingleLine(324, 114, 0xffff0000, false, "y");
	// angle
	DrawSingleLine(400, 0, 0xffff0000, false, "angle=%0.2f, halfFOV=%d, Distance=%d", 
		m_ViewerRotate, m_HalfFOV, m_ViewDistance);
	*/
	//

	m_minZ = VP_LEFT_BACK;
	m_maxZ = VP_LEFT_BACK;
	for(int i=VP_RIGHT_BACK; i<VP_MAX_NUM; i++)
	{
		if(m_pos[i].y < m_pos[m_minZ].y) 
		{
			m_minZ = (ViewPoint)i; 
		}
		if(m_pos[i].y > m_pos[m_maxZ].y) 
		{
			m_maxZ = (ViewPoint)i;
		}
	}

	int num = 0;
	int cur = m_minZ;
	int next;
	// left array
	do
	{
		next = cur + 1;
		if(next==VP_MAX_NUM)	next = 0;
		LinearArray(m_pos[cur].x, m_pos[cur].y, m_pos[next].x, m_pos[next].y, m_LeftArray, true);
	//	g_pGraphics->Line(m_pos[cur].x, m_pos[cur].y, m_pos[next].x, m_pos[next].y, 0xffff0000);
		cur++;
		if(cur==VP_MAX_NUM)	cur = 0;
		num++;
	}while(cur!=m_maxZ && num<VP_MAX_NUM);

	// right array
	num = 0;
	cur = m_maxZ;
	do
	{
		next = cur + 1;
		if(next==VP_MAX_NUM)	next = 0;
		LinearArray(m_pos[cur].x, m_pos[cur].y, m_pos[next].x, m_pos[next].y, m_RightArray, false);
	//	g_pGraphics->Line(m_pos[cur].x, m_pos[cur].y, m_pos[next].x, m_pos[next].y, 0xffff0000);
		cur++;
		if(cur==VP_MAX_NUM)	cur = 0;
		num++;
	}while(cur!=m_minZ && num<VP_MAX_NUM);
}

void CFrustum::LinearArray(int startx, int startz, int endx, int endz,
						   unsigned char *pArray, bool bLeft) 
{
	if(startz==endz)
	{
		if(bLeft)
			pArray[startz] = (startx<=endx)?startx:endx;
		else
			pArray[startz] = (startx>=endx)?startx:endx;

		return;
	}
	
	if(startz>endz)
	{
		int temp;
		temp = startz;
		startz = endz;
		endz = temp;

		temp = startx;
		startx = endx;
		endx = temp;
	}

	float deltax = float(endx-startx)/(endz-startz);
	int j=0;
	for(int i=startz; i<=endz; i++)
	{
		pArray[i] = unsigned char(startx + deltax * j);
	//	g_pGraphics->Point(pArray[i], i, 0xffff0000);
		j++;
	}
}

bool CFrustum::IsInFrustum(int X, int Z)
{
	if(Z>m_pos[m_maxZ].y || Z<m_pos[m_minZ].y)
		return false;

	if(Z>=MOVE_MAP_SIZE)
		return false;

	if(X>m_RightArray[Z] || X<m_LeftArray[Z])
		return false;

	return true;
}



