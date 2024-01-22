#include "StdAfx.h"
#include ".\kopmap.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CKopMap::CKopMap(void)
{
}

CKopMap::~CKopMap(void)
{
}

void CKopMap::SetName(CString name)
{
	m_strName=name;
}

CString CKopMap::GetName()
{
	return m_strName;
}

void CKopMap::SetMainRolePosX(long x)
{
	m_lMainRolePosX=x;
}

void CKopMap::SetMainRolePosY(long y)
{
	m_lMainRolePosY=y;
}

long CKopMap::GetMainRolePosX()
{
	return m_lMainRolePosX;
}

long CKopMap::GetMainRolePosY()
{
	return m_lMainRolePosY;
}

float CKopMap::GetMainRolePosXMeter()
{
	return ((float)m_lMainRolePosX)/100;
}

float CKopMap::GetMainRolePosYMeter()
{
	return ((float)m_lMainRolePosY)/100;
}

void CKopMap::SetAngle(int angle)
{
	m_nAngle=angle;
}

int CKopMap::GetAngle()
{
	return m_nAngle;
}
