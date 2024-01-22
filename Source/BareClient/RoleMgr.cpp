#include "StdAfx.h"
#include "RoleList.h"
#include "PlayerObject.h"
#include "NPCObject.h"
#include "MonsterObject.h"
#include "MonsterType.h"
#include "SelfObject.h"
#include ".\rolemgr.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CRoleMgr::CRoleMgr(CPlayer *player)
{
	m_pPlayer=player;
	m_pSelfObject=NULL;
}

CRoleMgr::~CRoleMgr(void)
{
	ResetAll();
}

CRoleObject* CRoleMgr::AddRoleObject(CRoleObject* role)
{
	if (!role)
	{
		return NULL;
	}
	switch(role->GetType())
	{
	case CRoleObject::ePlayer:
		{
			CPlayerObject *playerObject=static_cast<CPlayerObject*>(role);
			if (playerObject==NULL)
			{
				//CSystemInfo::Add(0,"错误：发现不相符的角色类型！");
				m_pPlayer->GetPlayerMessages().AddMsg("Error: Incompatible character types found!");
				return NULL;
			}
			if (FindInPlayerList(playerObject->GetWorldID()) || (m_pSelfObject && m_pSelfObject->GetWorldID()==playerObject->GetWorldID()) )
			{
				//CSystemInfo::Add(0,"错误：发现重复的角色出现！WorldID=%d,Name=%s",playerObject->GetWorldID(),playerObject->GetName());
				m_pPlayer->GetPlayerMessages().AddMsg("错误:发现重复的角色出现！WorldID=%d,Name=%s",playerObject->GetWorldID(),playerObject->GetName());
				return NULL;
			}
			//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"发现玩家：【%s】(%.2f,%.2f) WorldID=%u",playerObject->GetName(),playerObject->GetPositionFloatX(),playerObject->GetPositionFloatY(),playerObject->GetWorldID());
			m_pPlayer->GetPlayerMessages().AddMsg("发现玩家:【%s】(%.2f,%.2f) WorldID=%u",playerObject->GetName(),playerObject->GetPositionFloatX(),playerObject->GetPositionFloatY(),playerObject->GetWorldID());
			m_PlayerRolesList.AddTail(playerObject);
			break;
		}
	case CRoleObject::eNPC:
		{
			CNPCObject *npcObject=static_cast<CNPCObject*>(role);
			if (npcObject==NULL)
			{
				//CSystemInfo::Add(0,"错误：发现不相符的角色类型！");
				m_pPlayer->GetPlayerMessages().AddMsg("错误:发现不相符的角色类型！");
				return NULL;
			}
			if (FindInNPCList(npcObject->GetWorldID()))
			{
				//CSystemInfo::Add(0,"错误：发现重复的NPC出现！WorldID=%d,Name=%s",npcObject->GetWorldID(),npcObject->GetName());
				m_pPlayer->GetPlayerMessages().AddMsg("错误:发现重复的NPC出现！WorldID=%d,Name=%s",npcObject->GetWorldID(),npcObject->GetName());
				return NULL;
			}
			//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"发现NPC：%s(%.2f,%.2f) WorldID=%u",npcObject->GetName(),npcObject->GetPositionFloatX(),npcObject->GetPositionFloatY(),npcObject->GetWorldID());
			m_pPlayer->GetPlayerMessages().AddMsg("发现NPC:%s(%.2f,%.2f) WorldID=%u",npcObject->GetName(),npcObject->GetPositionFloatX(),npcObject->GetPositionFloatY(),npcObject->GetWorldID());
			m_NPCRolesList.AddTail(npcObject);
			break;
		}
	case CRoleObject::eMonster:
		{
			CMonsterObject *monsterObject=static_cast<CMonsterObject*>(role);
			if (monsterObject==NULL)
			{
				//CSystemInfo::Add(0,"错误：发现不相符的角色类型！");
				m_pPlayer->GetPlayerMessages().AddMsg("错误:发现不相符的角色类型！");
				return NULL;
			}
			if (FindInMonsterList(monsterObject->GetWorldID()))
			{
				//CSystemInfo::Add(0,"错误：发现重复的怪物出现！WorldID=%d,Name=%s",monsterObject->GetWorldID(),monsterObject->GetName());
				m_pPlayer->GetPlayerMessages().AddMsg("错误:发现重复的怪物出现！WorldID=%d,Name=%s",monsterObject->GetWorldID(),monsterObject->GetName());
				return NULL;
			}
			AddMonsterObject(monsterObject);
			//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"怪物出现：%s<%d>(%.2f,%.2f) WorldID=%u",monsterObject->GetName(),monsterObject->GetMonsterIndex(),monsterObject->GetPositionFloatX(),monsterObject->GetPositionFloatY(),monsterObject->GetWorldID());
			m_pPlayer->GetPlayerMessages().AddMsg("怪物出现:%s<%d>(%.2f,%.2f) WorldID=%u",monsterObject->GetName(),monsterObject->GetMonsterIndex(),monsterObject->GetPositionFloatX(),monsterObject->GetPositionFloatY(),monsterObject->GetWorldID());
			//m_MonsterRolesList.AddTail(monsterObject);
			break;
		}
	default:
		//CSystemInfo::Add(0,"错误：发现一个未知类型的角色！");
		m_pPlayer->GetPlayerMessages().AddMsg("错误:发现一个未知类型的角色！");
	}
	return role;
}

CSelfObject* CRoleMgr::AddSelfObject(CSelfObject* self)
{
	if (!self)
	{
		return NULL;
	}
	if (self->GetType()!=CRoleObject::eSelf)
	{
		ASSERT(false);
		return NULL;
	}
	if (m_pSelfObject!=NULL)
	{//主角已存在，重复添加
		ASSERT(false);
		SAFE_DELETE(m_pSelfObject);
	}
	m_pSelfObject=self;
	return m_pSelfObject;
}

bool CRoleMgr::DeleteObject(DWORD worldID)
{
	POSITION pos=m_PlayerRolesList.GetHeadPosition();
	while (pos)
	{
		CPlayerObject* playerObject=m_PlayerRolesList.GetAt(pos);
		if (playerObject->GetWorldID()==worldID)
		{
			//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"玩家【%s】从视野中消失",playerObject->GetName());
			m_pPlayer->GetPlayerMessages().AddMsg("玩家【%s】从视野中消失",playerObject->GetName());
			m_PlayerRolesList.RemoveAt(pos);
			delete playerObject;
			return true;
		}
		m_PlayerRolesList.GetNext(pos);
	}
	pos=m_NPCRolesList.GetHeadPosition();
	while (pos)
	{
		CNPCObject* npcObject=m_NPCRolesList.GetAt(pos);
		if (npcObject->GetWorldID()==worldID)
		{
			//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"NPC【%s】从视野中消失",npcObject->GetName());
			m_pPlayer->GetPlayerMessages().AddMsg("NPC【%s】从视野中消失",npcObject->GetName());
			m_NPCRolesList.RemoveAt(pos);
			delete npcObject;
			return true;
		}
		m_NPCRolesList.GetNext(pos);
	}
	if (DeleteMonsterObject(worldID))
	{
		return true;
	}
	//pos=m_MonsterRolesList.GetHeadPosition();
	//while (pos)
	//{
	//	CMonsterObject* monsterObject=m_MonsterRolesList.GetAt(pos);
	//	if (monsterObject->GetWorldID()==worldID)
	//	{
	//		CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"怪物【%s】从视野中消失",monsterObject->GetName());
	//		m_MonsterRolesList.RemoveAt(pos);
	//		delete monsterObject;
	//		return true;
	//	}
	//	m_MonsterRolesList.GetNext(pos);
	//}
	if (m_pSelfObject && m_pSelfObject->GetWorldID()==worldID)
	{
		//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"自己在游戏里消失",m_pSelfObject->GetName());
		m_pPlayer->GetPlayerMessages().AddMsg("自己在游戏里消失",m_pSelfObject->GetName());
		SAFE_DELETE(m_pSelfObject);
		return true;
	}
	//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"未知的东西在游戏里消失");
	m_pPlayer->GetPlayerMessages().AddMsg("未知的东西在游戏里消失");
	return false;
}

void CRoleMgr::ResetAll()
{
	POSITION pos;
	while (pos=m_PlayerRolesList.GetHeadPosition())
	{
		CPlayerObject* playerObject=m_PlayerRolesList.GetAt(pos);
		m_PlayerRolesList.RemoveAt(pos);
		delete playerObject;
	}
	while (pos=m_NPCRolesList.GetHeadPosition())
	{
		CNPCObject* npcObject=m_NPCRolesList.GetAt(pos);
		m_NPCRolesList.RemoveAt(pos);
		delete npcObject;
	}
	while (pos=m_MonsterTypesMap.GetStartPosition())
	{
		DWORD charID;
		CMonsterType *pMonsterType;
		m_MonsterTypesMap.GetNextAssoc(pos,charID,pMonsterType);
		m_MonsterTypesMap.RemoveKey(charID);
		delete pMonsterType;
	}
	//while (pos=m_MonsterRolesList.GetHeadPosition())
	//{
	//	CMonsterObject* monsterObject=m_MonsterRolesList.GetAt(pos);
	//	m_MonsterRolesList.RemoveAt(pos);
	//	delete monsterObject;
	//}
	SAFE_DELETE(m_pSelfObject);
}

CPlayerObject* CRoleMgr::FindInPlayerList(DWORD worldID)
{
	POSITION pos=m_PlayerRolesList.GetHeadPosition();
	for (int i=0;i< m_PlayerRolesList.GetCount();i++)
	{
		CPlayerObject* retObject=m_PlayerRolesList.GetNext(pos);
		if (retObject->GetWorldID()==worldID)
		{
			return retObject;
		}
	}
	return NULL;
}

CNPCObject* CRoleMgr::FindInNPCList(DWORD worldID)
{
	POSITION pos=m_NPCRolesList.GetHeadPosition();
	for (int i=0;i< m_NPCRolesList.GetCount();i++)
	{
		CNPCObject* retObject=m_NPCRolesList.GetNext(pos);
		if (retObject->GetWorldID()==worldID)
		{
			return retObject;
		}
	}
	return NULL;
}

CMonsterObject* CRoleMgr::FindInMonsterList(DWORD worldID)
{
	POSITION pos=m_MonsterTypesMap.GetStartPosition();
	DWORD charID;
	CMonsterType *pMonsterType;
	while (pos)
	{
		m_MonsterTypesMap.GetNextAssoc(pos,charID,pMonsterType);
		CMonsterObject* pMonsterObject=pMonsterType->FindMonster(worldID);
		if (pMonsterObject)
		{
			return pMonsterObject;
		}
	}
	return NULL;
	//POSITION pos=m_MonsterRolesList.GetHeadPosition();
	//for (int i=0;i< m_MonsterRolesList.GetCount();i++)
	//{
	//	CMonsterObject* retObject=m_MonsterRolesList.GetNext(pos);
	//	if (retObject->GetWorldID()==worldID)
	//	{
	//		return retObject;
	//	}
	//}
	//return NULL;
}

CRoleObject* CRoleMgr::FindRoleObject(DWORD worldID)
{
	CRoleObject* role=NULL;
	role=FindInPlayerList(worldID);
	if (role)
	{
		return role;
	}
	role=FindInNPCList(worldID);
	if (role)
	{
		return role;
	}
	role=FindInMonsterList(worldID);
	if (role)
	{
		return role;
	}
	if (m_pSelfObject && m_pSelfObject->GetWorldID()==worldID)
	{
		return m_pSelfObject;
	}
	return NULL;
}

CSelfObject* CRoleMgr::GetSelfObject()
{
	return m_pSelfObject;
}

void CRoleMgr::AddMonsterObject(CMonsterObject* monster)
{
	CMonsterType *pMonsterType=NULL;
	if (m_MonsterTypesMap.Lookup(monster->GetCharID(),pMonsterType))
	{
		pMonsterType->AddMonsterObject(monster);
	}
	else
	{
		pMonsterType=new CMonsterType;
		m_MonsterTypesMap.SetAt(monster->GetCharID(),pMonsterType);
		pMonsterType->AddMonsterObject(monster);
	}
}

bool CRoleMgr::DeleteMonsterObject(DWORD worldID)
{
	POSITION pos=m_MonsterTypesMap.GetStartPosition();
	DWORD charID;
	CMonsterType *pMonsterType;
	CMonsterObject *pMonsterObject;
	while (pos)
	{
		m_MonsterTypesMap.GetNextAssoc(pos,charID,pMonsterType);
		pMonsterObject=pMonsterType->FindMonster(worldID);
		if (pMonsterObject)
		{
			//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"怪物【%s<%d>】从视野中消失",pMonsterObject->GetName(),pMonsterObject->GetMonsterIndex());
			m_pPlayer->GetPlayerMessages().AddMsg("怪物【%s<%d>】从视野中消失",pMonsterObject->GetName(),pMonsterObject->GetMonsterIndex());
			if (pMonsterType->DeleteObject(worldID))
			{
				if (pMonsterType->GetObjectCount()==0)
				{
					m_MonsterTypesMap.RemoveKey(charID);
					delete pMonsterType;
				}
				return true;
			}
		}
	}
	return false;
}

CList<CPlayerObject*,CPlayerObject*>* CRoleMgr::GetPlayerList()
{
	return &m_PlayerRolesList;
}

CList<CNPCObject*,CNPCObject*>* CRoleMgr::GetNPCList()
{
	return &m_NPCRolesList;
}

CMap<DWORD,DWORD,CMonsterType*,CMonsterType*>* CRoleMgr::GetMonsterMap()
{
	return &m_MonsterTypesMap;
}


