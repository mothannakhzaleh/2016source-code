#pragma once
#include "commandobject.h"

class CCommandUseItem :
	public CCommandObject
{
public:
	CCommandUseItem(CPlayer *pPlayer);
	~CCommandUseItem(void);

	virtual CString GetCommandName();
	virtual bool Execute();

	static void Create(CPlayer *pPlayer,int nIndex,bool bAfterAll=false);

private:
	int m_nIndex;
};
