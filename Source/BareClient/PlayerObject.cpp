#include "StdAfx.h"
#include ".\playerobject.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CPlayerObject::CPlayerObject(void)
{
	SetType(CRoleObject::ePlayer);
}

CPlayerObject::~CPlayerObject(void)
{
}

//------------------------------------------------------------------------
//	设置属性
//------------------------------------------------------------------------

void CPlayerObject::SetShipName(CString name)
{
	m_strShipName=name;
}

void CPlayerObject::SetMottoName(CString strMotto)
{
	m_strMottoName=strMotto;
}

void CPlayerObject::SetJobName(CString jobName)
{
	m_strJobName=jobName;
}

void CPlayerObject::SetIconID(DWORD iconID)
{
	m_dwIconID=iconID;
}

void CPlayerObject::SetLevel(DWORD level)
{
	m_dwLevel=level;
}

void CPlayerObject::SetGMLv(DWORD lv)
{
	m_dwGMLv=lv;
}

void CPlayerObject::SetGuildID(DWORD dwGuildID)
{
	m_dwGuildID=dwGuildID;
}

void CPlayerObject::SetGuildName(CString strName)
{
	m_strGuildName=strName;
}

void CPlayerObject::SetGuildMottoName(CString strMottoName)
{
	m_strGuildMottoName=strMottoName;
}

void CPlayerObject::SetPKSide(BYTE bSide)
{
	m_bSide=bSide;
}

//------------------------------------------------------------------------
//	读取属性
//------------------------------------------------------------------------

CString CPlayerObject::GetShipName()
{
	return m_strShipName;
}

CString CPlayerObject::GetMottoName()
{
	return m_strMottoName;
}

CString CPlayerObject::GetJobName()
{
	return m_strJobName;
}

DWORD CPlayerObject::GetIconID()
{
	return m_dwIconID;
}

DWORD CPlayerObject::Getlevel()
{
	return m_dwLevel;
}

DWORD CPlayerObject::GetGMLv()
{
	return m_dwGMLv;
}

DWORD CPlayerObject::GetGuildID()
{
	return m_dwGuildID;
}

CString CPlayerObject::GetGuildName()
{
	return m_strGuildName;
}

CString CPlayerObject::GetGuildMottoName()
{
	return m_strGuildMottoName;
}

BYTE CPlayerObject::GetPKSide()
{
	return m_bSide;
}
