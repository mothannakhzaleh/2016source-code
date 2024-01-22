#pragma once
#include "commandobject.h"

class CCommandChat :
	public CCommandObject
{
public:
	enum eChannel
	{
		eSight,
		eWorld,
		eTrade,
		eTeam,
		ePublish,
		eGuild
	};

	CCommandChat(CPlayer *pPlayer);
	~CCommandChat(void);

	virtual CString GetCommandName();
	virtual bool Execute();

	static void Create(CPlayer *pPlayer,eChannel eChannel,CString strText,bool bAfterAll=false);

private:
	eChannel m_eChannel;
	CString m_strText;
};
