// SystemPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "SystemPage.h"
#include "PlayerMessage.h"
#include ".\systempage.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CSystemPage dialog

IMPLEMENT_DYNAMIC(CSystemPage, CPropertyPage)
CSystemPage::CSystemPage()
	: CPropertyPage(CSystemPage::IDD)
{
}

CSystemPage::~CSystemPage()
{
}

void CSystemPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_RICHEDIT_SYSTEM, m_RichEditInformation);
	DDX_Control(pDX, IDC_CHECK_LOCK, m_ScrollLock);
	DDX_Control(pDX, IDC_CHECK_SYSTEM_FILTER, m_SystemFilterCheck);
	DDX_Control(pDX, IDC_CHECK_DEBUG_FILTER, m_DebugFilterCheck);
}


BEGIN_MESSAGE_MAP(CSystemPage, CPropertyPage)
	ON_MESSAGE(THREAD_MSG_ADD_SYSTEM_MESSAGE, OnRefreshMessage)
	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_BUTTON_CLEAR, OnBnClickedButtonClear)
	ON_BN_CLICKED(IDC_BUTTON_COPY, OnBnClickedButtonCopy)
	ON_BN_CLICKED(IDC_CHECK_SYSTEM_FILTER, OnBnClickedCheckSystemFilter)
	ON_BN_CLICKED(IDC_CHECK_DEBUG_FILTER, OnBnClickedCheckDebugFilter)
END_MESSAGE_MAP()


// CSystemPage message handlers

BOOL CSystemPage::OnInitDialog()
{
	UpdateData(FALSE);
	ASSERT(MESSAGE_VISIBLE_MAXNUM>100);
	m_dwLastRefreshTick=0;
	m_RichEditInformation.SetBackgroundColor(FALSE, RGB(0,0,0));
	m_SystemFilterCheck.EnableWindow(FALSE);
	m_DebugFilterCheck.EnableWindow(FALSE);
	SetTimer(1,500,NULL);

	//CHARFORMAT cf;
	//cf.cbSize=sizeof(CHARFORMAT);
	//cf.dwMask = CFM_COLOR|CFM_BOLD|CFM_UNDERLINE|CFM_SIZE;
	//
	//PARAFORMAT pf;
	//pf.cbSize=sizeof(PARAFORMAT);
	//pf.dwMask = PFM_ALIGNMENT;
	//pf.wAlignment = PFA_CENTER;
	//m_RichEditInformation.SetParaFormat(pf);

	//cf.dwEffects=0;
	//cf.yHeight=0;
	//cf.crTextColor = RGB(0,0,0);
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("Bkop - Pseudo client for Pirate King test & GM Tools program: Mo Junbin (Arcol) @2005\n");

	//cf.dwEffects=CFM_BOLD;
	//cf.yHeight=450;
	//cf.crTextColor = RGB(192,192,255);
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("Pseudo Client for Pirate King Test & GM Tools\n");

	//cf.dwEffects=CFM_BOLD;
	//cf.yHeight=300;
	//cf.crTextColor = RGB(255,192,255);
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("Pirate King online - http://www.hdwonline.com\n");

	//cf.yHeight=250;
	//cf.crTextColor = RGB(255,255,192);
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("developer: ");

	//cf.dwEffects=CFM_BOLD|CFE_UNDERLINE;
	//cf.crTextColor = RGB(255,255,127);
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("Shanghai Moliyou Digital Entertainment Co., Ltd.");

	//cf.dwEffects=CFM_BOLD;
	//cf.crTextColor = RGB(255,127,127);
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel(" - Moliyo\n");

	//cf.crTextColor = RGB(192,128,128);
	//cf.dwEffects=CFM_BOLD;
	//cf.yHeight=220;
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("Copyright 2004-2006 All Right Reserved all rights reserved\n");


	//cf.crTextColor = RGB(192,128,128);
	//cf.dwEffects=CFM_BOLD;
	//cf.yHeight=180;
	//m_RichEditInformation.SetWordCharFormat(cf);

	//CString strVer;
	//strVer.Format("BKop version v2.0413.1 corresponds to server version v%.2f\n\n\n\n", g_nClientVersion / 100.0f);
	//m_RichEditInformation.ReplaceSel(strVer);

	//pf.wAlignment = PFA_LEFT;
	//m_RichEditInformation.SetParaFormat(pf);

	//cf.crTextColor = RGB(192,192,192);
	//cf.dwEffects=CFM_BOLD;
	//cf.yHeight=200;
	//m_RichEditInformation.SetWordCharFormat(cf);
	//m_RichEditInformation.ReplaceSel("Agreement of Use:\n");
	//m_RichEditInformation.ReplaceSel("1. This program is only used by internal employees of the company, please do not spread it to the outside world.\n");
	//m_RichEditInformation.ReplaceSel("2. If you find any loopholes in the program, please report them in time, and do not use the loopholes to damage the normal operation of the game server.\n");
	//m_RichEditInformation.ReplaceSel("3. Please abide by the relevant regulations of the company when using this program.\n");
	//m_RichEditInformation.ReplaceSel("4. If you obtain this program from other channels, please contact the developer. If you cannot comply with the above agreement, please terminate the program.\n");
	//m_RichEditInformation.SetTargetDevice(m_RichEditInformation.GetDC()->GetSafeHdc(),0);

	return TRUE;
}

LRESULT CSystemPage::OnRefreshMessage(WPARAM wParam,LPARAM lParam)
{
	CPlayer *pPlayer=reinterpret_cast<CPlayer*>(wParam);
	CPlayerMessageInfo *pPlayerMessage=reinterpret_cast<CPlayerMessageInfo*>(lParam);
	if (!CPlayerMgr::FindPlayer(pPlayer))
	{
		SAFE_DELETE(pPlayerMessage);
		return NULL;
	}
	pPlayer->GetPlayerMessages().AddToMessageArray(pPlayerMessage);
	if (pPlayer==CPlayerMgr::GetMainPlayer())
	{
		RefreshMessage();
	}
	return NULL;
}

void CSystemPage::OnTimer(UINT nIDEvent)
{
	// TODO: Add your message handler code here and/or call default
	if (nIDEvent==1)
	{
		if (m_dwLastRefreshTick+500>GetTickCount())
		{
			RefreshMessage();
		}
		MSG msg;
		while (PeekMessage(&msg,this->m_hWnd,WM_TIMER,WM_TIMER,PM_REMOVE));
	}
	CPropertyPage::OnTimer(nIDEvent);
}

void CSystemPage::RefreshMessage()
{
	if (m_ScrollLock.GetCheck()==BST_CHECKED)
	{
		return;
	}
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CPlayerMessage *pPlayerMessage=&pPlayer->GetPlayerMessages();
	int nCount=pPlayerMessage->GetNewMessageCount();
	if (nCount<=0)
	{
		return;
	}
	DWORD remainTick=(nCount>4)?50:200/nCount;
	if (nCount+20>50)
	{
		nCount=50;
	}
	if (GetTickCount()>m_dwLastRefreshTick+remainTick)
	{
		m_RichEditInformation.SetSel(-1,-1);
		while(pPlayerMessage->MoveToNextAvailable())
		{
			if (m_RichEditInformation.GetLineCount()>MESSAGE_VISIBLE_MAXNUM)
			{
				int nCharCount=0;
				for (int i=0;i<nCount+20;i++)
				{
					nCharCount+=m_RichEditInformation.LineLength(i)+1;
				}
				//m_RichEditInformation.LockWindowUpdate();
				m_RichEditInformation.SetSel(0,nCharCount);
				m_RichEditInformation.ReplaceSel(NULL);
				m_RichEditInformation.SetSel(-1,-1);
				//m_RichEditInformation.UnlockWindowUpdate();
			}
			CHARFORMAT cf;
			cf.cbSize=sizeof(CHARFORMAT);
			cf.dwMask = CFM_COLOR;
			cf.crTextColor = pPlayerMessage->GetCurMsgColor();
			cf.dwEffects=0;
			m_RichEditInformation.SetWordCharFormat(cf);
			m_RichEditInformation.ReplaceSel(pPlayerMessage->GetCurMsg()+"\n");
		}
		m_dwLastRefreshTick=GetTickCount();
	}
}

void CSystemPage::RefreshAllMessages()
{
	m_RichEditInformation.SetWindowText(NULL);
	PARAFORMAT pf;
	pf.cbSize=sizeof(PARAFORMAT);
	pf.dwMask = PFM_ALIGNMENT;
	pf.wAlignment = PFA_LEFT;
	m_RichEditInformation.SetParaFormat(pf);

	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CPlayerMessage *pPlayerMessage=&pPlayer->GetPlayerMessages();
	if (pPlayerMessage->GetNewMessageCount()<0)
	{
		return;
	}
	if (pPlayerMessage->MoveToFirstAvailable())
	{
		m_RichEditInformation.LockWindowUpdate();
		do {
			if (m_RichEditInformation.GetLineCount()>MESSAGE_VISIBLE_MAXNUM)
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
			cf.cbSize=sizeof(CHARFORMAT);
			cf.dwMask = CFM_COLOR;
			cf.crTextColor = pPlayerMessage->GetCurMsgColor();
			cf.dwEffects=0;
			m_RichEditInformation.SetWordCharFormat(cf);
			m_RichEditInformation.ReplaceSel(pPlayerMessage->GetCurMsg()+"\n");
		} while(pPlayerMessage->MoveToNextAvailable());
		m_RichEditInformation.UnlockWindowUpdate();
		m_dwLastRefreshTick=GetTickCount();
	}
}

void CSystemPage::OnBnClickedButtonClear()
{
	// TODO: Add your control notification handler code here
	m_RichEditInformation.SetWindowText(NULL);
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	pPlayer->GetPlayerMessages().ClearAll();
}

void CSystemPage::OnBnClickedButtonCopy()
{
	// TODO: Add your control notification handler code here
	m_RichEditInformation.SetSel(0,-1);
	m_RichEditInformation.Copy();
	m_RichEditInformation.SetSel(-1,-1);
}
void CSystemPage::OnBnClickedCheckSystemFilter()
{
	// TODO: Add your control notification handler code here
	CPlayerMgr::GetMainPlayer()->GetPlayerMessages().SetSystemMessageFilter((m_SystemFilterCheck.GetCheck()==BST_CHECKED)?true:false);
	RefreshAllMessages();
}

void CSystemPage::OnBnClickedCheckDebugFilter()
{
	// TODO: Add your control notification handler code here
	CPlayerMgr::GetMainPlayer()->GetPlayerMessages().SetDebugMessageFilter((m_DebugFilterCheck.GetCheck()==BST_CHECKED)?true:false);
	RefreshAllMessages();
}

void CSystemPage::OnPlayerSwitch(CPlayer *pLastPlayer,CPlayer *pNowPlayer)
{
	if (pNowPlayer)
	{
		m_DebugFilterCheck.EnableWindow();
		m_SystemFilterCheck.EnableWindow();
		pNowPlayer->GetPlayerMessages().GetDebugMessageFilter()?m_DebugFilterCheck.SetCheck(BST_CHECKED):m_DebugFilterCheck.SetCheck(BST_UNCHECKED);
		pNowPlayer->GetPlayerMessages().GetSystemMessageFilter()?m_SystemFilterCheck.SetCheck(BST_CHECKED):m_SystemFilterCheck.SetCheck(BST_UNCHECKED);
		RefreshAllMessages();
	}
	else
	{
		m_DebugFilterCheck.EnableWindow(FALSE);
		m_SystemFilterCheck.EnableWindow(FALSE);
		m_DebugFilterCheck.SetCheck(BST_UNCHECKED);
		m_SystemFilterCheck.SetCheck(BST_UNCHECKED);
	}
}


