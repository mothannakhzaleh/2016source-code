#pragma once

class CRoleObject;
class CPlayerObject;
class CNPCObject;
class CMonsterObject;
class CMonsterType;
class CSelfObject;

class CRoleMgr
{
public:
	CRoleMgr(CPlayer *player);
	~CRoleMgr(void);

	CRoleObject* AddRoleObject(CRoleObject* role);
	CSelfObject* AddSelfObject(CSelfObject* self);
	bool DeleteObject(DWORD worldID);
	void ResetAll();

	CPlayerObject *FindInPlayerList(DWORD worldID);
	CNPCObject *FindInNPCList(DWORD worldID);
	CMonsterObject *FindInMonsterList(DWORD worldID);
	CRoleObject *FindRoleObject(DWORD worldID);

	CSelfObject *GetSelfObject();
	CList<CPlayerObject*,CPlayerObject*>* GetPlayerList();
	CList<CNPCObject*,CNPCObject*>* GetNPCList();
	CMap<DWORD,DWORD,CMonsterType*,CMonsterType*>* GetMonsterMap();

private:
	void AddMonsterObject(CMonsterObject* monster);
	bool DeleteMonsterObject(DWORD worldID);

private:
	CList<CPlayerObject*,CPlayerObject*> m_PlayerRolesList;
	CList<CNPCObject*,CNPCObject*> m_NPCRolesList;
	//CList<CMonsterObject*,CMonsterObject*> m_MonsterRolesList;
	CMap<DWORD,DWORD,CMonsterType*,CMonsterType*> m_MonsterTypesMap;
	CSelfObject *m_pSelfObject;
	CPlayer *m_pPlayer;
};
