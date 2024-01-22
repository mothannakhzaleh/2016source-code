// PrivateTalkSessionPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "MainFrm.h"
#include "MainView.h"
#include "PlayerMgr.h"
#include "TalkPage.h"
#include "PrivateTalkSessionPage.h"
#include ".\privatetalksessionpage.h"


// CPrivateTalkSessionPage dialog

IMPLEMENT_DYNAMIC(CPrivateTalkSessionPage, CPropertyPage)
CPrivateTalkSessionPage::CPrivateTalkSessionPage()
	: CPropertyPage(CPrivateTalkSessionPage::IDD), CTalkSessionBase(CChannelChatMgr::CHANNEL_PRIVATE)
{
	//m_dwTotalInCounts=0;
	//m_dwTotalOutCounts=0;
}

CPrivateTalkSessionPage::~CPrivateTalkSessionPage()
{
	if (m_pPlayerMenu)
	{
		m_pPlayerMenu->Detach();
		SAFE_DELETE(m_pPlayerMenu);
	}
}

void CPrivateTalkSessionPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_RICHEDIT_TALK, m_RichEditInformation);
	DDX_Control(pDX, IDC_LIST_PLAYER, m_PlayerList);
	DDX_Control(pDX, IDC_RICHEDIT_TOTAL_TALK, m_RichEditTotalInformation);
}


BEGIN_MESSAGE_MAP(CPrivateTalkSessionPage, CPropertyPage)
	ON_LBN_SELCHANGE(IDC_LIST_PLAYER, OnLbnSelchangeListPlayer)
	ON_BN_CLICKED(IDC_BUTTON_CLEAR, OnBnClickedButtonClear)
	ON_COMMAND(ID_MENU_PRIVATE_CLEAR, OnMenuPrivateClear)
	ON_WM_DRAWITEM()
	ON_WM_TIMER()
END_MESSAGE_MAP()


// CPrivateTalkSessionPage message handlers
LPVOID CPrivateTalkSessionPage::GetThisPage()
{
	return this;
}

BOOL CPrivateTalkSessionPage::OnInitDialog()
{
	UpdateData(FALSE);
	BOOL ret=m_MainMenu.LoadMenu(IDR_MENU_TALK);
	ASSERT(ret);
	m_pPlayerMenu=new CMenu;
	m_pPlayerMenu->Attach(m_MainMenu.GetSubMenu(0)->GetSafeHmenu());
	m_RichEditInformation.SetBackgroundColor(FALSE, RGB(0,0,0));
	m_RichEditTotalInformation.SetBackgroundColor(FALSE, RGB(0,0,0));
	m_RichEditInformation.SetTargetDevice(NULL,0);
	m_PlayerList.SetHorizontalExtent(170);


	SetTimer(1,300,NULL);
	return TRUE;
}

bool CPrivateTalkSessionPage::RefreshList()
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return false;
	}
	CPrivateRivalMgr *pPrivateRivalMgr=&pPlayer->GetChatMgr().GetPrivateRivalMgr();
	CString strCurSelName=NULL;
	int nSel=m_PlayerList.GetCurSel();
	if (nSel!=CB_ERR)
	{
		CPrivateRivalMgr::sRivalData* pRival=reinterpret_cast<CPrivateRivalMgr::sRivalData*>(m_PlayerList.GetItemDataPtr(nSel));
		if (pPrivateRivalMgr->hasRival(pRival))
		{
			strCurSelName=pRival->strName;
		}
	}
	m_PlayerList.ResetContent();
	int i=0;
	nSel=-1;
	CString strInfo;
	if (pPrivateRivalMgr->MoveToBegin())
	{
		do
		{
			CPrivateRivalMgr::sRivalData* pCurRival=pPrivateRivalMgr->GetCurRival();
			if (pCurRival->strName==strCurSelName)
			{
				nSel=i;
			}
			strInfo.Format("%s(%d/%d)",pCurRival->strName,pCurRival->dwInCounts,pCurRival->dwOutCounts);
			m_PlayerList.InsertString(i,strInfo);
			m_PlayerList.SetItemDataPtr(i,pCurRival);
			i++;
		} while(pPrivateRivalMgr->MoveToNext());
	}
	strInfo.Format("Total number of items received: %d",pPrivateRivalMgr->GetTotalInCounts());
	GetDlgItem(IDC_STATIC_IN)->SetWindowText(strInfo);
	strInfo.Format("Total number of items sent: %d",pPrivateRivalMgr->GetTotalOutCounts());
	GetDlgItem(IDC_STATIC_OUT)->SetWindowText(strInfo);
	if (nSel==-1)
	{
		m_PlayerList.SetCurSel(0);
		return false;
	}
	else
	{
		m_PlayerList.SetCurSel(nSel);
		return true;
	}
}

void CPrivateTalkSessionPage::RefreshSelfChannel()
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	if (!RefreshList())
	{
		Renew();
		return;
	}
	int nSel=m_PlayerList.GetCurSel();
	if (nSel==CB_ERR)
	{
		return;
	}
	CPrivateRivalMgr::sRivalData* pRival=reinterpret_cast<CPrivateRivalMgr::sRivalData*>(m_PlayerList.GetItemDataPtr(nSel));
	CChannelChatMgr *pChannelMgr=&pPlayer->GetChatMgr().GetChannelChatMgr();
	m_RichEditInformation.SetSel(-1,-1);
	while (pChannelMgr->MoveToNext(m_eChannel))
	{
		if (pChannelMgr->GetCurName(m_eChannel)==pRival->strName)
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
}

void CPrivateTalkSessionPage::Renew()
{
	m_RichEditInformation.SetWindowText(NULL);
	RefreshList();
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CChannelChatMgr *pChannelMgr=&pPlayer->GetChatMgr().GetChannelChatMgr();
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

	int nSel=m_PlayerList.GetCurSel();
	if (nSel==CB_ERR)
	{
		return;
	}
	CPrivateRivalMgr::sRivalData* pRival=reinterpret_cast<CPrivateRivalMgr::sRivalData*>(m_PlayerList.GetItemDataPtr(nSel));
	m_RichEditInformation.SetSel(0,-1);
	if (pChannelMgr->MoveToBegin(m_eChannel))
	{
		m_RichEditInformation.LockWindowUpdate();
		do{
			if (pChannelMgr->GetCurName(m_eChannel)==pRival->strName)
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
		}while (pChannelMgr->MoveToNext(m_eChannel));
		m_RichEditInformation.UnlockWindowUpdate();
	}
}

void CPrivateTalkSessionPage::Clear()
{
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	pPlayer->GetChatMgr().GetChannelChatMgr().ClearInfo(m_eChannel);
	pPlayer->GetChatMgr().GetPrivateRivalMgr().Clear();
	m_RichEditInformation.SetWindowText(NULL);
	m_PlayerList.SetCurSel(LB_ERR);
	RefreshList();
}

BOOL CPrivateTalkSessionPage::OnSetActive( )
{
	Renew();
	return CPropertyPage::OnSetActive();
}

void CPrivateTalkSessionPage::OnLbnSelchangeListPlayer()
{
	// TODO: Add your control notification handler code here
	Renew();
	int nSel=m_PlayerList.GetCurSel();
	if (nSel==LB_ERR)
	{
		return;
	}
	CPrivateRivalMgr::sRivalData* pRival=reinterpret_cast<CPrivateRivalMgr::sRivalData*>(m_PlayerList.GetItemDataPtr(nSel));
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetTalkPage().m_CombTarget.SetWindowText(pRival->strName);
	((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->GetTalkPage().m_CombText.SetFocus();
	CPrivateRivalMgr::EnableFlashColor(pRival,false);
}

void CPrivateTalkSessionPage::OnBnClickedButtonClear()
{
	// TODO: Add your control notification handler code here
	Clear();
}

void CPrivateTalkSessionPage::OnMenuPrivateClear()
{
	// TODO: Add your command handler code here
	int nSel=m_PlayerList.GetCurSel();
	if (nSel==LB_ERR)
	{
		return;
	}
	CPlayer *pPlayer=CPlayerMgr::GetMainPlayer();
	if (!pPlayer)
	{
		return;
	}
	CPrivateRivalMgr::sRivalData* pRival=reinterpret_cast<CPrivateRivalMgr::sRivalData*>(m_PlayerList.GetItemDataPtr(nSel));
	pPlayer->GetChatMgr().GetChannelChatMgr().ClearPrivateInfo(pRival->strName);
	pPlayer->GetChatMgr().GetPrivateRivalMgr().Remove(pRival);
	m_RichEditInformation.SetWindowText(NULL);
	m_PlayerList.SetCurSel(-1);
	OnLbnSelchangeListPlayer();
}

BOOL CPrivateTalkSessionPage::PreTranslateMessage(MSG* pMsg)
{
	// TODO: Add your specialized code here and/or call the base class
	if (pMsg->message==WM_RBUTTONDOWN)
	{
		if (pMsg->hwnd==m_PlayerList.m_hWnd)
		{
			BOOL bOutSide;
			CPoint point(pMsg->lParam);
			int nItem=m_PlayerList.ItemFromPoint(point,bOutSide);
			if (!bOutSide)
			{
				m_PlayerList.SetCurSel(nItem);
				m_PlayerList.ClientToScreen(&point);
				m_pPlayerMenu->TrackPopupMenuEx(TPM_LEFTALIGN|TPM_TOPALIGN,point.x,point.y,this,NULL);
			}
			return true;
		}
	}
	return __super::PreTranslateMessage(pMsg);
}

void CPrivateTalkSessionPage::RefreshTotalChannel()
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

void CPrivateTalkSessionPage::OnDrawItem(int nIDCtl, LPDRAWITEMSTRUCT lpDrawItemStruct)
{
	// TODO: Add your message handler code here and/or call default

	if ( nIDCtl==IDC_LIST_PLAYER && lpDrawItemStruct->CtlType==ODT_LISTBOX )
	{
		CPrivateRivalMgr::sRivalData* pCurRival=(CPrivateRivalMgr::sRivalData*)lpDrawItemStruct->itemData;
		if (!pCurRival || pCurRival->strName.IsEmpty()) return;
		CString strItemText;
		m_PlayerList.GetText(0,strItemText);
		strItemText.Format("%s(%d/%d)",pCurRival->strName,pCurRival->dwInCounts,pCurRival->dwOutCounts);

		CDC dc;
		dc.Attach(lpDrawItemStruct->hDC);
		COLORREF crOldTextColor = dc.GetTextColor();
		COLORREF crOldBkColor = dc.GetBkColor();

		// If this item is selected, set the background color 
		// and the text color to appropriate values. Also, erase
		// rect by filling it with the background color.
		if ((lpDrawItemStruct->itemAction | ODA_SELECT) &&
			(lpDrawItemStruct->itemState & ODS_SELECTED))
		{
			dc.SetTextColor(::GetSysColor(COLOR_HIGHLIGHTTEXT));
			dc.SetBkColor(::GetSysColor(COLOR_HIGHLIGHT));
			dc.FillSolidRect(&lpDrawItemStruct->rcItem, 
				::GetSysColor(COLOR_HIGHLIGHT));
		}
		else
		{
			dc.SetTextColor(CPrivateRivalMgr::GetShowColor(pCurRival));
			dc.FillSolidRect(&lpDrawItemStruct->rcItem, crOldBkColor);
		}

		// If this item has the focus, draw a red frame around the
		// item's rect.
		if ((lpDrawItemStruct->itemAction | ODA_FOCUS) &&
			(lpDrawItemStruct->itemState & ODS_FOCUS))
		{
			CBrush br(RGB(255, 0, 0));
			dc.FrameRect(&lpDrawItemStruct->rcItem, &br);
		}

		// Draw the text.
		dc.DrawText(strItemText, &lpDrawItemStruct->rcItem, DT_LEFT|DT_SINGLELINE|DT_VCENTER);

		// Reset the background color and the text color back to their
		// original values.
		dc.SetTextColor(crOldTextColor);
		dc.SetBkColor(crOldBkColor);

		dc.Detach();
	}
	else
	{
		__super::OnDrawItem(nIDCtl, lpDrawItemStruct);
	}
}

void CPrivateTalkSessionPage::OnTimer(UINT nIDEvent)
{
	// TODO: Add your message handler code here and/or call default
	if (nIDEvent==1)
	{
		int nSel=m_PlayerList.GetCurSel();
		if (nSel!=LB_ERR)
		{
			CPrivateRivalMgr::sRivalData* pRival=reinterpret_cast<CPrivateRivalMgr::sRivalData*>(m_PlayerList.GetItemDataPtr(nSel));
			CPrivateRivalMgr::EnableFlashColor(pRival,false);
		}
		m_PlayerList.RedrawWindow();
	}
	__super::OnTimer(nIDEvent);
}
