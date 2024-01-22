#pragma once

class CCommandObject
{
public:
	CCommandObject(CPlayer* pPlayer);
	virtual ~CCommandObject(void);

	virtual CString GetCommandName()=0;
	virtual bool Execute()=0;				//Return true: means that the execution is complete, and the command can be cleared false: means that the execution needs to continue

	void SetCommandPosition(POSITION pos);
	POSITION GetCommandPosition();

protected:
	CPlayer* m_pPlayer;

private:
	POSITION m_CmdPosition;
};
