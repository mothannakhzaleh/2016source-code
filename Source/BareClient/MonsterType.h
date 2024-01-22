#pragma once

class CMonsterObject;

class CMonsterType
{
public:
	CMonsterType(void);
	virtual ~CMonsterType(void);

	CMonsterObject* AddMonsterObject(CMonsterObject* monsterObject);
	bool DeleteObject(DWORD worldID);

	CMonsterObject *FindMonster(DWORD worldID);
	DWORD GetObjectCount();
	CList<CMonsterObject*,CMonsterObject*> *GetMonsterRolesList();
	

private:
	WORD GetFreeIndex();


	CList<CMonsterObject*,CMonsterObject*> m_MonsterRolesList;
	CMap<WORD,WORD,bool,bool> m_MonsterFreeIndex;
};
