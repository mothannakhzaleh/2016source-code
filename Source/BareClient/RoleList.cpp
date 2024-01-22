#include "StdAfx.h"
#include "RoleObject.h"
#include ".\rolelist.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CRoleList::CRoleList(void)
{
	m_psLook=NULL;
}

CRoleList::~CRoleList(void)
{
	SAFE_DELETE(m_psLook);
}

void CRoleList::SetName(CString name)
{
	m_strName=name;
}

void CRoleList::SetShipName(CString shipName)
{
	m_strShipName=shipName;
}

CString CRoleList::GetShipName()
{
	return m_strShipName;
}

void CRoleList::SetJobName(CString jobName)
{
	m_strJobName=jobName;
}

void CRoleList::SetLevel(DWORD level)
{
	m_dwLevel=level;
}

void CRoleList::SetLook(const LOOK *sLook)
{
	SAFE_DELETE(m_psLook);
	m_psLook=new LOOK;
	memcpy(m_psLook,sLook,sizeof(LOOK));
}

CString CRoleList::GetName()
{
	return m_strName;
}

CString CRoleList::GetJobName()
{
	return m_strJobName;
}

DWORD CRoleList::Getlevel()
{
	return m_dwLevel;
}

void CRoleList::SetCharID(DWORD id)
{
	m_dwCharID=id;
}

DWORD CRoleList::GetCharID()
{
	return m_dwCharID;
}

void CRoleList::SetWorldID(DWORD id)
{
	m_dwWorldID=id;
}

void CRoleList::SetCommID(DWORD id)
{
	m_dwCommID=id;
}

DWORD CRoleList::GetWorldID()
{
	return m_dwWorldID;
}

DWORD CRoleList::GetCommID()
{
	return m_dwCommID;
}

void CRoleList::SetGMLv(DWORD lv)
{
	m_dwGMLv=lv;
}

DWORD CRoleList::GetGMLv()
{
	return m_dwGMLv;
}

void CRoleList::SetCharHandle(DWORD handle)
{
	m_dwCharHandle=handle;
}

DWORD CRoleList::GetCharHandle()
{
	return m_dwCharHandle;
}

void CRoleList::SetCharType(EChaCtrlType type)
{
	m_eType=type;
}

EChaCtrlType CRoleList::GetCharType()
{
	return m_eType;
}

void CRoleList::SetMottoName(CString strMotto)
{
	m_strMottoName=strMotto;
}

CString CRoleList::GetMottoName()
{
	return m_strMottoName;
}

void CRoleList::SetIconID(DWORD icon)
{
	m_dwIconID=icon;
}

DWORD CRoleList::GetIconID()
{
	return m_dwIconID;
}

//void CRoleList::SetState(CRoleObject::eState state)
//{
//	m_eState=state;
//}

//CRoleObject::eState CRoleList::GetState()
//{
//	return m_eState;
//}

void CRoleList::SetRadius(long radius)
{
	m_lRadius=radius;
}

long CRoleList::GetRadius()
{
	return m_lRadius;
}

