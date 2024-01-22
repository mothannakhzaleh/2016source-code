#include "StdAfx.h"
#include "BKop.h"
#include "TalkPage.h"
#include "CommandChat.h"
#include "CommandPrivateChat.h"
#include "ControlCommand.h"
#include "PlayerMgr.h"
#include ".\channelcontrol.h"

CChannelControl::CChannelControl(CTalkPage *pTalkPage,CString strChannelName)
{
	m_pTalkPage=pTalkPage;
	m_strChannelName=strChannelName;
	m_pTalkPage->m_CombChannelSel.AddString(strChannelName);
}

CChannelControl::~CChannelControl(void)
{
}

void CChannelControl::OnChange()
{
	if (m_strChannelName=="Private Chat")
	{
		m_pTalkPage->m_CombTarget.EnableWindow(true);
		m_pTalkPage->m_CombCommand.EnableWindow(false);
		m_pTalkPage->m_BtnNameList.EnableWindow(true);
		m_pTalkPage->m_CombText.SetWindowText(NULL);
		m_pTalkPage->m_BtnSend.SetWindowText("&Send");
		m_pTalkPage->m_CombTarget.SetFocus();
	}
	else if (m_strChannelName=="Control Command")
	{
		m_pTalkPage->m_CombTarget.EnableWindow(true);
		m_pTalkPage->m_CombCommand.EnableWindow(true);
		m_pTalkPage->m_BtnNameList.EnableWindow(true);
		m_pTalkPage->m_CombCommand.SetCurSel(0);
		m_pTalkPage->OnCbnSelchangeComboCommand();
		m_pTalkPage->m_BtnSend.SetWindowText("&OK");
	}
	else
	{
		m_pTalkPage->m_CombTarget.EnableWindow(false);
		m_pTalkPage->m_CombCommand.EnableWindow(false);
		m_pTalkPage->m_BtnNameList.EnableWindow(false);
		m_pTalkPage->m_BtnSend.SetWindowText("&Send");
		m_pTalkPage->m_CombText.SetWindowText(NULL);
		m_pTalkPage->m_CombText.SetFocus();
	}
}

void CChannelControl::OnSend(CString strText)
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	if (m_strChannelName=="All")
	{
		if (strText.IsEmpty()) return;
		CCommandChat::Create(pPlayer,CCommandChat::eSight,strText);
	}
	else if (m_strChannelName=="World")
	{
		if (strText.IsEmpty()) return;
		CCommandChat::Create(pPlayer,CCommandChat::eWorld,strText);
	}
	else if (m_strChannelName=="Trade")
	{
		if (strText.IsEmpty()) return;
		CCommandChat::Create(pPlayer,CCommandChat::eTrade,strText);
	}
	else if (m_strChannelName=="Team")	//暂时无效
	{
	}
	else if (m_strChannelName=="Guild")	//暂时无效
	{
	}
	else if (m_strChannelName=="GM announcement")
	{
		if (strText.IsEmpty()) return;
		CString strInfo="You will make the following announcement to all players:\n\n";
		strInfo+=strText+"\n\n";
		strInfo+="Please confirm whether to continue?";
		int ret=m_pTalkPage->MessageBox(strInfo,"warn",MB_OKCANCEL|MB_ICONQUESTION);
		if (ret!=IDOK) return;
		CCommandChat::Create(pPlayer,CCommandChat::ePublish,strText);
	}
	else if (m_strChannelName=="Private Chat")
	{
		CString strTarget;
		m_pTalkPage->m_CombTarget.GetWindowText(strTarget);
		if (strTarget.IsEmpty())
		{
			m_pTalkPage->MessageBox("Operation failed: Please select the name of the target object first","Warning");
			return;
		}
		CCommandPrivateChat::Create(pPlayer,strTarget,strText);
	}
	else if (m_strChannelName=="QQ session")
	{
	}
	else if (m_strChannelName=="Control Command")
	{
		int nIndex=(int)m_pTalkPage->m_CombCommand.GetItemData(m_pTalkPage->m_CombCommand.GetCurSel());
		CString strName;
		m_pTalkPage->m_CombTarget.GetWindowText(strName);
		CString strNewText=CControlCommand::AssembleCommand(nIndex,strName,strText);
		if (strNewText.IsEmpty()) return;
		if (strNewText.Left(2)=="@@")	//This command is sent through the private chat channel, and the private chat object is a single character: '@'
		{
			int nSub=strNewText.GetLength()-3;
			if (nSub<=0)
			{
				return;
			}
			strNewText=strNewText.Right(nSub);
			CCommandPrivateChat::Create(pPlayer,"@",strNewText);
		}
		else
		{
			CCommandChat::Create(pPlayer,CCommandChat::eSight,strNewText);
		}
	}
}