#pragma once
#include "commandobject.h"

class CCommandPrivateChat :
	public CCommandObject
{
public:
	CCommandPrivateChat(CPlayer *pPlayer);
	~CCommandPrivateChat(void);

	virtual CString GetCommandName();
	virtual bool Execute();

	static void Create(CPlayer *pPlayer,CString strTargetName,CString strText,bool bAfterAll=false);

private:
	CString m_strTargetName;
	CString m_strText;
};
