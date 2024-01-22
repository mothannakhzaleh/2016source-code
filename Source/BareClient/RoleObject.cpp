#include "StdAfx.h"
#include "CommonHeader.h"
#include "PlayerObject.h"
#include "NPCObject.h"
#include "MonsterObject.h"
#include "SelfObject.h"
#include ".\roleobject.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CRoleObject::CRoleObject(void)
{
}

CRoleObject::~CRoleObject(void)
{
}

CRoleObject* CRoleObject::CreateObject(dbc::RPacket& pk)
{
	DWORD charID=pk.ReadLong();
	DWORD worldID=pk.ReadLong();
	DWORD commID=pk.ReadLong();
	CString commName=pk.ReadString();
	BYTE gmLv=pk.ReadChar();
	DWORD charHandle=pk.ReadLong();
	EChaCtrlType type=(EChaCtrlType)pk.ReadChar();
	CString showName=pk.ReadString();
	CString mottoName=pk.ReadString();
	WORD iconID=pk.ReadShort();
	DWORD dwGuildID=pk.ReadLong();
	CString strGuildName=pk.ReadString();
	CString strGuildMottoName=pk.ReadString();
	pk.ReadString();	//商店名字
	eState state=(eState)pk.ReadShort();
	DWORD posX=pk.ReadLong();
	DWORD posY=pk.ReadLong();
	DWORD radius=pk.ReadLong();
	WORD angle=pk.ReadShort();
	pk.ReadLong(); //队长ID

	CRoleObject *pRetOjbect=NULL;
	switch(type)
	{
	case enumCHACTRL_NONE:					// 未定义的
		{
			ASSERT(false);
			break;
		}
	case enumCHACTRL_PLAYER:				// 玩家
		{
			CPlayerObject *playerObject=new CPlayerObject;
			playerObject->SetCharID(charID);
			playerObject->SetWorldID(worldID);
			playerObject->SetCommID(commID);
			playerObject->SetHandle(charHandle);
			playerObject->SetName(commName);
			playerObject->SetMottoName(mottoName);
			playerObject->SetShipName(showName);
			playerObject->SetIconID(iconID);
			playerObject->SetGMLv(gmLv);
			playerObject->SetPosition(posX,posY);
			playerObject->SetRadiusBulk(radius);
			playerObject->SetAngle(angle);
			playerObject->SetState(state);
			playerObject->SetGuildID(dwGuildID);
			playerObject->SetGuildName(strGuildName);
			playerObject->SetGuildMottoName(strGuildMottoName);
			pRetOjbect=playerObject;
			break;
		}
	case enumCHACTRL_NPC:					// 普通NPC
	case enumCHACTRL_NPC_EVENT:				// 事件NPC
		{
			CNPCObject *playerObject=new CNPCObject;
			playerObject->SetCharID(charID);
			playerObject->SetWorldID(worldID);
			playerObject->SetCommID(commID);
			playerObject->SetHandle(charHandle);
			playerObject->SetName(showName);
			//playerObject->SetMottoName(mottoName);//
			//playerObject->SetShipName(shipName);//
			//playerObject->SetIconID(iconID);//
			//playerObject->SetGMLv(gmLv);//
			playerObject->SetPosition(posX,posY);
			playerObject->SetRadiusBulk(radius);
			playerObject->SetAngle(angle);
			playerObject->SetState(state);
			pRetOjbect=playerObject;
			break;
		}
	case enumCHACTRL_MONS:					// 普通怪物
	case enumCHACTRL_MONS_TREE:				// 树怪物
	case enumCHACTRL_MONS_MINE:				// 矿石怪物
	case enumCHACTRL_MONS_FISH:				// 鱼怪物
	case enumCHACTRL_MONS_DBOAT:			// 沉船怪物
		{
			CMonsterObject *playerObject=new CMonsterObject;
			playerObject->SetCharID(charID);
			playerObject->SetWorldID(worldID);
			playerObject->SetCommID(commID);
			playerObject->SetHandle(charHandle);
			playerObject->SetName(showName);
			//playerObject->SetMottoName(mottoName);//
			//playerObject->SetShipName(shipName);//
			//playerObject->SetIconID(iconID);//
			//playerObject->SetGMLv(gmLv);//
			playerObject->SetPosition(posX,posY);
			playerObject->SetRadiusBulk(radius);
			playerObject->SetAngle(angle);
			playerObject->SetState(state);
			pRetOjbect=playerObject;
			break;
		}
	default:
		{//未定义的
			ASSERT(false);
		}
	}
	CRoleObject::CreateEvent(pRetOjbect,pk);
	return pRetOjbect;
}

CSelfObject* CRoleObject::CreateSelfObject(dbc::RPacket& pk)
{
	DWORD charID=pk.ReadLong();
	DWORD worldID=pk.ReadLong();
	DWORD commID=pk.ReadLong();
	CString commName=pk.ReadString();
	BYTE gmLv=pk.ReadChar();
	DWORD charHandle=pk.ReadLong();
	EChaCtrlType type=(EChaCtrlType)pk.ReadChar();
	CString showName=pk.ReadString();
	CString mottoName=pk.ReadString();
	WORD iconID=pk.ReadShort();
	DWORD dwGuildID=pk.ReadLong();
	CString strGuildName=pk.ReadString();
	CString strGuildMottoName=pk.ReadString();
	pk.ReadString();								//商店名字
	eState state=(eState)pk.ReadShort();
	DWORD posX=pk.ReadLong();
	DWORD posY=pk.ReadLong();
	DWORD radius=pk.ReadLong();
	WORD angle=pk.ReadShort();
	pk.ReadLong();									// 队长ID
	char side=pk.ReadChar();						// 表示pk时的红蓝方

	if (type!=enumCHACTRL_PLAYER)
	{//角色类型不相符
		ASSERT(false);
		return NULL;
	}
	CSelfObject *selfObject=new CSelfObject;
	selfObject->SetCharID(charID);
	selfObject->SetWorldID(worldID);
	selfObject->SetCommID(commID);
	selfObject->SetHandle(charHandle);
	selfObject->SetName(commName);
	selfObject->SetMottoName(mottoName);
	selfObject->SetShipName(showName);
	selfObject->SetIconID(iconID);
	selfObject->SetGMLv(gmLv);
	selfObject->SetPosition(posX,posY);
	selfObject->SetRadiusBulk(radius);
	selfObject->SetAngle(angle);
	selfObject->SetState(state);
	selfObject->SetGuildID(dwGuildID);
	selfObject->SetGuildName(strGuildName);
	selfObject->SetGuildMottoName(strGuildMottoName);
	selfObject->SetPKSide(side);

	CRoleObject::CreateEvent(selfObject,pk);

	return selfObject;
}

void CRoleObject::CreateEvent(CRoleObject *pRoleOjbect, dbc::RPacket& pk)
{
	if (!pRoleOjbect)
	{
		ASSERT(false);
		return;
	}
	pRoleOjbect->m_dwEventEntityID=pk.ReadLong();
	pRoleOjbect->m_eEventEntityType=(EChaCtrlType)pk.ReadChar();
	pRoleOjbect->m_dwEventID=pk.ReadShort();
	pRoleOjbect->m_strEventName=pk.ReadString();
}


//------------------------------------------------------------------------
//	设置参数
//------------------------------------------------------------------------

void CRoleObject::SetCharID(DWORD id)
{
	m_dwCharID=id;
}

void CRoleObject::SetWorldID(DWORD id)
{
	m_dwWorldID=id;
}

void CRoleObject::SetCommID(DWORD id)
{
	m_dwCommID=id;
}

void CRoleObject::SetHandle(DWORD handle)
{
	m_dwHandle=handle;
}

void CRoleObject::SetName(CString name)
{
	m_strName=name;
}

void CRoleObject::SetType(eObjectType type)
{
	m_eObjectType=type;
}

void CRoleObject::SetPosition(DWORD x, DWORD y)
{
	m_dwPosX=x;
	m_dwPosY=y;
}

void CRoleObject::SetRadiusBulk(DWORD radius)
{
	m_dwRadiusBulk=radius;
}

void CRoleObject::SetAngle(WORD angle)
{
	m_nAngle=angle;
}

void CRoleObject::SetState(eState state)
{
	m_eState=state;
}

//------------------------------------------------------------------------
//	读取参数
//------------------------------------------------------------------------

DWORD CRoleObject::GetCharID()
{
	return m_dwCharID;
}

DWORD CRoleObject::GetWorldID()
{
	return m_dwWorldID;
}

DWORD CRoleObject::GetCommID()
{
	return m_dwCommID;
}

CString CRoleObject::GetName()
{
	return m_strName;
}

DWORD CRoleObject::GetHandle()
{
	return m_dwHandle;
}

CRoleObject::eObjectType CRoleObject::GetType()
{
	return m_eObjectType;
}

DWORD CRoleObject::GetPositionX()
{
	return m_dwPosX;
}

DWORD CRoleObject::GetPositionY()
{
	return m_dwPosY;
}

float CRoleObject::GetPositionFloatX()
{
	return ((float)m_dwPosX)/100;
}

float CRoleObject::GetPositionFloatY()
{
	return ((float)m_dwPosY)/100;
}

DWORD CRoleObject::GetRadiusBulk()
{
	return m_dwRadiusBulk;
}

WORD CRoleObject::GetAngle()
{
	return m_nAngle;
}

CRoleObject::eState CRoleObject::GetState()
{
	return m_eState;
}

DWORD CRoleObject::GetDistanceTo(DWORD x,DWORD y)
{
	return (DWORD)abs((long)(((INT64)(m_dwPosX)-x)^2-((INT64)(m_dwPosY)-y)^2));
}

float CRoleObject::GetDistanceInFloatTo(DWORD x,DWORD y)
{
	DWORD dis=GetDistanceTo(x,y);
	return ((float)dis)/100;
}
