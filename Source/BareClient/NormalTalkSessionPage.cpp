// NormalTalkSessionPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "NormalTalkSessionPage.h"

#include "MainFrm.h"
#include "TalkPage.h"
#include "MainView.h"

// CNormalTalkSessionPage dialog

IMPLEMENT_DYNAMIC(CNormalTalkSessionPage, CPropertyPage)
CNormalTalkSessionPage::CNormalTalkSessionPage(CChannelChatMgr::eChannel channel)
	: CPropertyPage(CNormalTalkSessionPage::IDD), CTalkSessionBase(channel)
{
}

CNormalTalkSessionPage::~CNormalTalkSessionPage()
{
}

void CNormalTalkSessionPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_RICHEDIT_TALK, m_RichEditInformation);
	DDX_Control(pDX, IDC_RICHEDIT_TOTAL_TALK, m_RichEditTotalInformation);
}


BEGIN_MESSAGE_MAP(CNormalTalkSessionPage, CPropertyPage)
END_MESSAGE_MAP()


// CNormalTalkSessionPage message handlers
LPVOID CNormalTalkSessionPage::GetThisPage()
{
	return this;
}

BOOL CNormalTalkSessionPage::OnInitDialog()
{
	UpdateData(FALSE);
	m_RichEditInformation.SetBackgroundColor(FALSE, RGB(0,0,0));
	m_RichEditTotalInformation.SetBackgroundColor(FALSE, RGB(0,0,0));
	return TRUE;
}


void CNormalTalkSessionPage::RefreshSelfChannel()
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

void CNormalTalkSessionPage::RefreshTotalChannel()
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CChannelChatMgr *pChannelMgr=&pPlayer->GetChatMgr().GetChannelChatMgr();
	m_RichEditTotalInformation.SetSel(-1,-1);
	while (pChannelMgr->MoveToNext(CChannelChatMgr::CHANNEL_ALL))
	{
		if (m_RichEditTotalInformation.GetLineCount()>CHAT_CHANNEL_LIST_MAXNUM)
		{
			int nCharCount=0;
			for (int i=0;i<20;i++)
			{
				nCharCount+=m_RichEditTotalInformation.LineLength(i)+1;
			}
			m_RichEditTotalInformation.SetSel(0,nCharCount);
			m_RichEditTotalInformation.ReplaceSel(NULL);
			m_RichEditTotalInformation.SetSel(-1,-1);
		}
		CHARFORMAT cf;
		cf.dwMask = CFM_COLOR;
		cf.crTextColor = pChannelMgr->GetCurColor(CChannelChatMgr::CHANNEL_ALL);
		cf.dwEffects=0;
		m_RichEditTotalInformation.SetWordCharFormat(cf);
		m_RichEditTotalInformation.ReplaceSel(pChannelMgr->GetCurText(CChannelChatMgr::CHANNEL_ALL)+"\n");
	}
}

void CNormalTalkSessionPage::Renew()
{
	m_RichEditInformation.SetWindowText(NULL);
	m_RichEditTotalInformation.SetWindowText(NULL);
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

	m_RichEditTotalInformation.SetSel(0,-1);
	if (pChannelMgr->MoveToBegin(CChannelChatMgr::CHANNEL_ALL))
	{
		m_RichEditTotalInformation.LockWindowUpdate();
		do{
			if (m_RichEditTotalInformation.GetLineCount()>CHAT_CHANNEL_LIST_MAXNUM)
			{
				int nCharCount=0;
				for (int i=0;i<20;i++)
				{
					nCharCount+=m_RichEditTotalInformation.LineLength(i)+1;
				}
				m_RichEditTotalInformation.SetSel(0,nCharCount);
				m_RichEditTotalInformation.ReplaceSel(NULL);
				m_RichEditTotalInformation.SetSel(-1,-1);
			}
			CHARFORMAT cf;
			cf.dwMask = CFM_COLOR;
			cf.crTextColor = pChannelMgr->GetCurColor(CChannelChatMgr::CHANNEL_ALL);
			cf.dwEffects=0;
			m_RichEditTotalInformation.SetWordCharFormat(cf);
			m_RichEditTotalInformation.ReplaceSel(pChannelMgr->GetCurText(CChannelChatMgr::CHANNEL_ALL)+"\n");
		}while (pChannelMgr->MoveToNext(CChannelChatMgr::CHANNEL_ALL));
		m_RichEditTotalInformation.UnlockWindowUpdate();
	}
}

void CNormalTalkSessionPage::Clear()
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

BOOL CNormalTalkSessionPage::OnSetActive( )
{
	//CTalkPage *pTalkPage=&((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetTalkPage();
	//CRect rcSheet;
	//pTalkPage->GetDlgItem( IDC_STATIC_SHEET_RECT )->GetWindowRect( &rcSheet );
	//pTalkPage->m_SheetControl.SetWindowPos(NULL, 0, 0, rcSheet.Width(), rcSheet.Height()-50, SWP_NOZORDER|SWP_NOMOVE|SWP_NOACTIVATE);

	Renew();
	CPropertyPage::OnSetActive();
	CTalkPage *pTalkPage=&((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetTalkPage();
	PostMessage(WM_SETFOCUS,(WPARAM)pTalkPage->m_CombText.m_hWnd);
	//pTalkPage->m_CombText.ShowCaret();
	return TRUE;
}

