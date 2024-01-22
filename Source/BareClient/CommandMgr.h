#pragma once

#include "CommandObject.h"

class CCommandMgr
{
public:
	CCommandMgr(CPlayer *player);
	~CCommandMgr(void);

	void Clear();
	void PushToHead(CCommandObject* cmd);
	void PushToTail(CCommandObject* cmd);
	void RemoveCommand(CCommandObject* cmd);
	void RemoveCurCommand();
	CCommandObject* GetCurCommand();
	int GetTotalCommand();
	CString GetCurCommandName();
	CString DumpCommandList();
	void ExecuteCommand();

private:
	CList<CCommandObject*,CCommandObject*> m_CmdList;
	CPlayer *m_pPlayer;
};
