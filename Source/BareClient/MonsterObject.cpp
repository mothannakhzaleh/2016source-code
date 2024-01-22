#include "StdAfx.h"
#include ".\monsterobject.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CMonsterObject::CMonsterObject(void)
{
	SetType(CRoleObject::eMonster);
}

CMonsterObject::~CMonsterObject(void)
{
}

void CMonsterObject::SetMonsterIndex(WORD index)
{
	m_nMonsterIndex=index;
}

WORD CMonsterObject::GetMonsterIndex()
{
	return m_nMonsterIndex;
}
