#pragma once
#include "commandobject.h"

class CCommandUnEquip :
	public CCommandObject
{
public:
	CCommandUnEquip(CPlayer *pPlayer);
	~CCommandUnEquip(void);

	virtual CString GetCommandName();
	virtual bool Execute();

	static void Create(CPlayer *pPlayer,int nIndex,bool bAfterAll=false);

private:
	int m_nIndex;
};
