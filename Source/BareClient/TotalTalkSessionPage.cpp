// TotalTalkSessionPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "TotalTalkSessionPage.h"

// CTotalTalkSessionPage dialog

IMPLEMENT_DYNAMIC(CTotalTalkSessionPage, CPropertyPage)
CTotalTalkSessionPage::CTotalTalkSessionPage(CChannelChatMgr::eChannel channel)
	: CPropertyPage(CTotalTalkSessionPage::IDD), CTalkSessionBase(channel)
{
}

CTotalTalkSessionPage::~CTotalTalkSessionPage()
{
}

void CTotalTalkSessionPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_RICHEDIT_TALK, m_RichEditInformation);
}


BEGIN_MESSAGE_MAP(CTotalTalkSessionPage, CPropertyPage)
END_MESSAGE_MAP()


// CTotalTalkSessionPage message handlers
LPVOID CTotalTalkSessionPage::GetThisPage()
{
	return this;
}

BOOL CTotalTalkSessionPage::OnInitDialog()
{
	UpdateData(FALSE);
	m_RichEditInformation.SetBackgroundColor(FALSE, RGB(0,0,0));
	return TRUE;
}


void CTotalTalkSessionPage::RefreshTotalChannel()
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CChannelChatMgr *pChannelMgr=&pPlayer->GetChatMgr().GetChannelChatMgr();
	m_RichEditInformation.SetSel(-1,-1);
	while (pChannelMgr->MoveToNext(m_eChannel))
	{
		if (m_RichEditInformation.GetLineCount()>CHAT_CHANNEL_LIST_MAXNUM)
		{
			int nCharCount=0;
			for (int i=0;i<20;i++)
			{
				nCharCount+=m_RichEditInformation.LineLength(i)+1;
			}
			m_RichEditInformation.SetSel(0,nCharCount);
			m_RichEditInformation.ReplaceSel(NULL);
			m_RichEditInformation.SetSel(-1,-1);
		}
		CHARFORMAT cf;
		cf.dwMask = CFM_COLOR;
		cf.crTextColor = pChannelMgr->GetCurColor(m_eChannel);
		cf.dwEffects=0;
		m_RichEditInformation.SetWordCharFormat(cf);
		m_RichEditInformation.ReplaceSel(pChannelMgr->GetCurText(m_eChannel)+"\n");
	}
}

void CTotalTalkSessionPage::Renew()
{
	m_RichEditInformation.SetWindowText(NULL);
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CChannelChatMgr *pChannelMgr=&pPlayer->GetChatMgr().GetChannelChatMgr();
	m_RichEditInformation.SetSel(0,-1);
	if (pChannelMgr->MoveToBegin(m_eChannel))
	{
		m_RichEditInformation.LockWindowUpdate();
		do{
			if (m_RichEditInformation.GetLineCount()>CHAT_CHANNEL_LIST_MAXNUM)
			{
				int nCharCount=0;
				for (int i=0;i<20;i++)
				{
					nCharCount+=m_RichEditInformation.LineLength(i)+1;
				}
				m_RichEditInformation.SetSel(0,nCharCount);
				m_RichEditInformation.ReplaceSel(NULL);
				m_RichEditInformation.SetSel(-1,-1);
			}
			CHARFORMAT cf;
			cf.dwMask = CFM_COLOR;
			cf.crTextColor = pChannelMgr->GetCurColor(m_eChannel);
			cf.dwEffects=0;
			m_RichEditInformation.SetWordCharFormat(cf);
			m_RichEditInformation.ReplaceSel(pChannelMgr->GetCurText(m_eChannel)+"\n");
		}while (pChannelMgr->MoveToNext(m_eChannel));
		m_RichEditInformation.UnlockWindowUpdate();
	}
}

void CTotalTalkSessionPage::Clear()
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CChannelChatMgr *pChannelMgr=&pPlayer->GetChatMgr().GetChannelChatMgr();
	pChannelMgr->ClearInfo(m_eChannel);
	m_RichEditInformation.SetWindowText(NULL);
}

BOOL CTotalTalkSessionPage::OnSetActive()
{
	Renew();
	CPropertyPage::OnSetActive();
	return TRUE;
}

void CTotalTalkSessionPage::RefreshSelfChannel()
{
}

