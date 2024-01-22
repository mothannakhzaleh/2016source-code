#pragma once
#include "commandobject.h"

class CCommandPickup :
	public CCommandObject
{
public:
	CCommandPickup(CPlayer *pPlayer);
	~CCommandPickup(void);

	virtual CString GetCommandName();
	virtual bool Execute();

	static void Create(CPlayer *pPlayer,DWORD dwWorldID,bool bAfterAll=false);

private:
	DWORD m_dwWorldID;
};
