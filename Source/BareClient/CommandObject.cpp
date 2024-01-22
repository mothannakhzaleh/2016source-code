#include "StdAfx.h"
#include ".\commandobject.h"

CCommandObject::CCommandObject(CPlayer* pPlayer)
{
	m_pPlayer=pPlayer;
	m_CmdPosition=NULL;
}

CCommandObject::~CCommandObject(void)
{
}

void CCommandObject::SetCommandPosition(POSITION pos)
{
	m_CmdPosition=pos;
}

POSITION CCommandObject::GetCommandPosition()
{
	return m_CmdPosition;
}
