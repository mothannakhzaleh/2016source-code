#include "StdAfx.h"
#include "MonsterObject.h"
#include ".\monstertype.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CMonsterType::CMonsterType(void)
{
}

CMonsterType::~CMonsterType(void)
{
	POSITION pos=m_MonsterRolesList.GetHeadPosition();
	while (pos)
	{
		CMonsterObject* pMonsterObject=m_MonsterRolesList.GetNext(pos);
		delete pMonsterObject;
	}
	m_MonsterRolesList.RemoveAll();
	m_MonsterFreeIndex.RemoveAll();
}

CMonsterObject *CMonsterType::FindMonster(DWORD worldID)
{
	POSITION pos=m_MonsterRolesList.GetHeadPosition();
	for (int i=0;i< m_MonsterRolesList.GetCount();i++)
	{
		CMonsterObject* pMonsterObject=m_MonsterRolesList.GetNext(pos);
		if (pMonsterObject->GetWorldID()==worldID)
		{
			return pMonsterObject;
		}
	}
	return NULL;
}

WORD CMonsterType::GetFreeIndex()
{
	if (m_MonsterRolesList.GetCount()==0)
	{
		m_MonsterFreeIndex.RemoveAll();
		return 1;
	}
	else
	{
		if (m_MonsterFreeIndex.GetCount()==0)
		{
			return (WORD)m_MonsterRolesList.GetCount()+1;
		}
		bool bVar;
		for (WORD i=0;true;i++)
		{
			if (m_MonsterFreeIndex.Lookup(i,bVar))
			{
				m_MonsterFreeIndex.RemoveKey(i);
				return i;
			}
		}
	}
	return 0;
}

CMonsterObject* CMonsterType::AddMonsterObject(CMonsterObject* monsterObject)
{
	monsterObject->SetMonsterIndex(GetFreeIndex());
	m_MonsterRolesList.AddTail(monsterObject);
	return NULL;
}

bool CMonsterType::DeleteObject(DWORD worldID)
{
	POSITION pos=m_MonsterRolesList.GetHeadPosition();
	for (int i=0;i< m_MonsterRolesList.GetCount();i++)
	{
		CMonsterObject* pMonsterObject=m_MonsterRolesList.GetAt(pos);
		if (pMonsterObject->GetWorldID()==worldID)
		{
			//
			m_MonsterFreeIndex.SetAt(pMonsterObject->GetMonsterIndex(),true);
			m_MonsterRolesList.RemoveAt(pos);
			delete pMonsterObject;
			return true;
		}
		m_MonsterRolesList.GetNext(pos);
	}
	return false;
}

DWORD CMonsterType::GetObjectCount()
{
	return (DWORD)m_MonsterRolesList.GetCount();
}

CList<CMonsterObject*,CMonsterObject*> *CMonsterType::GetMonsterRolesList()
{
	return &m_MonsterRolesList;
}
