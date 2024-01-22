#pragma once
#include "commandobject.h"

class CCommandDropItem :
	public CCommandObject
{
public:
	CCommandDropItem(CPlayer *pPlayer);
	~CCommandDropItem(void);

	virtual CString GetCommandName();
	virtual bool Execute();

	static void Create(CPlayer *pPlayer,int nIndex,WORD nNum,bool bAfterAll=false);

private:
	int m_nIndex;
	WORD m_nNum;
};
