#include "StdAfx.h"
#include "CommonHeader.h"
#include ".\groundobject.h"

CGroundObject::CGroundObject(dbc::RPacket& pk)
{
	SetWorldID(pk.ReadLong());
	SetHandle(pk.ReadLong());
	SetItemID(pk.ReadLong());
	DWORD x=pk.ReadLong();
	DWORD y=pk.ReadLong();
	SetPosition(x,y);
	SetAngle(pk.ReadShort());
	SetTotalNum(pk.ReadShort());
	m_dwEventEntityID=pk.ReadLong();
	m_eEventEntityType=(EChaCtrlType)pk.ReadChar();
	m_dwEventID=pk.ReadShort();
	m_strEventName=pk.ReadString();
	SetAppearCause((EItemAppearType)pk.ReadChar());
	SetOwnerWorldID(pk.ReadLong());
}

CGroundObject::~CGroundObject(void)
{
}

void CGroundObject::SetWorldID(DWORD worldID)
{
	m_dwWorldID=worldID;
}

void CGroundObject::SetHandle(DWORD handle)
{
	m_dwHandle=handle;
}

void CGroundObject::SetPosition(DWORD x, DWORD y)
{
	m_dwPosX=x;
	m_dwPosY=y;
}

void CGroundObject::SetAngle(WORD angle)
{
	m_nAngle=angle;
}

void CGroundObject::SetAppearCause(EItemAppearType eCause)
{
	m_eAppearCause=eCause;
}

void CGroundObject::SetOwnerWorldID(DWORD worldID)
{
	m_dwOwnerWorldID=worldID;
}





DWORD CGroundObject::GetHandle()
{
	return m_dwHandle;
}

DWORD CGroundObject::GetWorldID()
{
	return m_dwWorldID;
}

DWORD CGroundObject::GetPositionX()
{
	return m_dwPosX;
}

DWORD CGroundObject::GetPositionY()
{
	return m_dwPosY;
}

float CGroundObject::GetPositionFloatX()
{
	return ((float)m_dwPosX)/100;
}

float CGroundObject::GetPositionFloatY()
{
	return ((float)m_dwPosY)/100;
}

DWORD CGroundObject::GetDistanceTo(DWORD x,DWORD y)
{
	return (DWORD)abs((long)(((INT64)(m_dwPosX)-x)^2-((INT64)(m_dwPosY)-y)^2));
}

float CGroundObject::GetDistanceInFloatTo(DWORD x,DWORD y)
{
	DWORD dis=GetDistanceTo(x,y);
	return ((float)dis)/100;
}

WORD CGroundObject::GetAngle()
{
	return m_nAngle;
}

EItemAppearType CGroundObject::GetAppearCause()
{
	return m_eAppearCause;
}

CString CGroundObject::GetAppearCauseString()
{
	CString strRet;
	switch (m_eAppearCause)
	{
	case enumITEM_APPE_MONS:
		{
			strRet="monster drop";
			break;
		}
	case enumITEM_APPE_THROW:
		{
			strRet="player drop";
			break;
		}
	case enumITEM_APPE_NATURAL:
		{
			strRet="naturally appear";
			break;
		}
	default:
		{
			strRet="unknown cause";
		}
	}
	return strRet;
}

DWORD CGroundObject::GetOwnerWorldID()
{
	return m_dwOwnerWorldID;
}