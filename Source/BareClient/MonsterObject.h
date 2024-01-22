#pragma once
#include "roleobject.h"

class CRoleObject;

class CMonsterObject :
	public CRoleObject
{
public:
	CMonsterObject(void);
	virtual ~CMonsterObject(void);

	void SetMonsterIndex(WORD index);
	WORD GetMonsterIndex();

private:
	WORD m_nMonsterIndex;
};
