#include "StdAfx.h"
#include ".\commandmgr.h"

CCommandMgr::CCommandMgr(CPlayer *player)
{
	m_pPlayer=player;
}

CCommandMgr::~CCommandMgr(void)
{
	Clear();
}

void CCommandMgr::Clear()
{
	CCommandObject* cmd=NULL;
	while ((cmd=GetCurCommand())!=NULL)
	{
		m_CmdList.RemoveHead();
		delete cmd;
	}
}

void CCommandMgr::PushToHead(CCommandObject* cmd)
{
	POSITION pos=m_CmdList.AddHead(cmd);
	cmd->SetCommandPosition(pos);
}

void CCommandMgr::PushToTail(CCommandObject* cmd)
{
	POSITION pos=m_CmdList.AddTail(cmd);
	cmd->SetCommandPosition(pos);
}

void CCommandMgr::RemoveCommand(CCommandObject* cmd)
{
	POSITION pos=cmd->GetCommandPosition();
	if (!pos)
	{
		return;
	}
	m_CmdList.RemoveAt(pos);
	delete cmd;
}

void CCommandMgr::RemoveCurCommand()
{
	CCommandObject* cmd=GetCurCommand();
	if (cmd)
	{
		m_CmdList.RemoveHead();
		delete cmd;
	}
}

CCommandObject* CCommandMgr::GetCurCommand()
{
	if (m_CmdList.IsEmpty())
	{
		return NULL;
	}
	return m_CmdList.GetHead();
}

int CCommandMgr::GetTotalCommand()
{
	return (int)m_CmdList.GetCount();
}

CString CCommandMgr::GetCurCommandName()
{
	CCommandObject* cmd=GetCurCommand();
	if (!cmd)
	{
		return "ø’";
	}
	return cmd->GetCommandName();
}

CString CCommandMgr::DumpCommandList()
{
	CString str;
	int nCount=GetTotalCommand();
	CCommandObject* cmd=NULL;
	str.Format("√¸¡Ó(%dÃı) : ",nCount);
	if (nCount==0)
	{
		str+="ø’";
		return str;
	}
	POSITION pos=m_CmdList.GetHeadPosition();
	for (int i=0;i<nCount;i++)
	{
		cmd=m_CmdList.GetNext(pos);
		if (i+1==nCount)
		{
			str+=cmd->GetCommandName()+" | ";
		}
		else
		{
			str+=cmd->GetCommandName()+" <- ";
		}
	}
	return str;
}

void CCommandMgr::ExecuteCommand()
{
	CCommandObject* cmd=GetCurCommand();
	if (!cmd)
	{
		return;
	}
	CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),DumpCommandList());
	if (cmd->Execute())
	{
		RemoveCommand(cmd);
	}
}



