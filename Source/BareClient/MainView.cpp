// MainView.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "MainView.h"
#include "SystemInfo.h"
#include "PlayerMgr.h"
#include "LoginPage.h"
#include "ItemView.h"
#include "MainFrm.h"
#include ".\mainview.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CMainView

IMPLEMENT_DYNCREATE(CMainView, CFormView)

CMainView::CMainView()
	: CFormView(CMainView::IDD)
{
}

CMainView::~CMainView()
{
}

void CMainView::DoDataExchange(CDataExchange* pDX)
{
	CFormView::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_RICHEDIT23, m_RichEditInformation);
	DDX_Control(pDX, IDC_TAB1, m_TabSystemInfo);
	DDX_Control(pDX, IDC_CHECK_LOCK, m_ButtonLock);
	DDX_Control(pDX, IDC_COMBO_MODE, m_ComboMode);
	DDX_Control(pDX, IDC_CHECK_SET_THE_SAME, m_btnSettheSame);
}

BEGIN_MESSAGE_MAP(CMainView, CFormView)
	ON_WM_TIMER()
	ON_MESSAGE(THREAD_MSG_REFRESH_INFO, OnThreadRefreshInfo)
	ON_NOTIFY(TCN_SELCHANGE, IDC_TAB1, OnTcnSelchangeTab1)
	ON_BN_CLICKED(IDC_BUTTON_CLEAR, OnBnClickedButtonClear)
	ON_BN_CLICKED(IDC_RADIO1, OnBnClickedRadio1)
	ON_BN_CLICKED(IDC_RADIO2, OnBnClickedRadio2)
	ON_BN_CLICKED(IDC_RADIO3, OnBnClickedRadio3)
	ON_BN_CLICKED(IDC_RADIO4, OnBnClickedRadio4)
	ON_BN_CLICKED(IDC_CHECK_SET_THE_SAME, OnBnClickedCheckSetTheSame)
	ON_BN_CLICKED(IDC_CHECK_LOCK, OnBnClickedCheckLock)
	ON_BN_CLICKED(IDC_RADIO5, OnBnClickedRadio5)
	ON_BN_CLICKED(IDC_RADIO6, OnBnClickedRadio6)
END_MESSAGE_MAP()


// CMainView diagnostics

#ifdef _DEBUG
void CMainView::AssertValid() const
{
	CFormView::AssertValid();
}

void CMainView::Dump(CDumpContext& dc) const
{
	CFormView::Dump(dc);
}
#endif //_DEBUG


// CMainView message handlers

bool CMainView::InitView()
{
	m_SheetControl.AddPage(&m_SystemPage);
	m_SheetControl.AddPage(&m_TalkPage);
	m_SheetControl.AddPage(&m_MapPage);
	m_SheetControl.AddPage(&m_ScriptPage);
	m_SheetControl.AddPage(&m_SetupPage);
	

	CRect rcSheet;
	GetDlgItem( IDC_STATIC_SHEET_RECT )->GetWindowRect( &rcSheet );
	ScreenToClient( &rcSheet );

	m_SheetControl.EnableStackedTabs(false);
	m_SheetControl.Create(this,WS_CHILD|WS_VISIBLE);
	m_SheetControl.SetWindowPos(NULL,rcSheet.left-5,rcSheet.top-5,0,0,SWP_NOZORDER|SWP_NOSIZE|SWP_NOACTIVATE);
	CTabCtrl* pTabCtrl=m_SheetControl.GetTabControl();
	pTabCtrl->MoveWindow(5,5,rcSheet.Width()+5,rcSheet.Height()+10);

	m_SheetControl.SetActivePage(4);
	m_SheetControl.SetActivePage(3);
	m_SheetControl.SetActivePage(2);
	m_SheetControl.SetActivePage(1);
	m_SheetControl.SetActivePage(0);

	//m_nSelectedMainRole=CB_ERR;
	//m_nSelectedMainRoleIndex=0;



	m_RichEditInformation.SetBackgroundColor(FALSE, RGB(0,0, 0));
	m_TabSystemInfo.InsertItem(0,"Current player");
	m_TabSystemInfo.InsertItem(1,"Selected player");
	m_TabSystemInfo.InsertItem(2,"The checked players");
	m_TabSystemInfo.InsertItem(3,"All players");
	m_eTabSelect=CURRENT_PLAYER;
	m_ComboMode.SetCurSel(4);
	//SetTimer(1,3000,NULL);
	return true;
}

void CMainView::OnRefreshEdit()
{
	if (true) return;
	if (m_ButtonLock.GetCheck()) return;
	CLoginPage *pPage=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetLoginPage();
	if (!pPage) return;
	CListCtrl *pList=&pPage->m_LoginList;
	if (!pList) return;
	int nTotal=pList->GetItemCount();
	int index;
	DWORD nowOrder,newOrder;
	do
	{
		index=-1;
		nowOrder=0;
		if (m_eTabSelect==CURRENT_PLAYER)	//current player
		{
			//int nSel=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetItemView()->m_ComboSelectMainRole.GetCurSel();
			//if (nSel==CB_ERR) return;
			//index=(int)reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetItemView()->m_ComboSelectMainRole.GetItemData(nSel);
			index=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
			if (index==0) return;
			if (CSystemInfo::GetNextInfoOrder(index)==0) break;
		}
		else
		{
			for (int i=0;i<=nTotal;i++)	//i starts from 1, 0 is a system message
			{
				newOrder=0;
				if ( i==0 )
				{
					newOrder=CSystemInfo::GetNextInfoOrder(0);
					if ( newOrder > nowOrder )
					{
						nowOrder=newOrder;
						index=0;
					}
					continue;
				}
				if (m_eTabSelect==ALL_PLAYER)	//all players
				{
					CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i-1));
					newOrder=CSystemInfo::GetNextInfoOrder(player->GetIndex());
					if ( newOrder > nowOrder )
					{
						nowOrder=newOrder;
						index=player->GetIndex();
					}
				}
				else if (m_eTabSelect==CHECKED_PLAYER)	//Checked players
				{
					if (pList->GetCheck(i-1))
					{
						CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i-1));
						newOrder=CSystemInfo::GetNextInfoOrder(player->GetIndex());
						if ( newOrder > nowOrder )
						{
							nowOrder=newOrder;
							index=player->GetIndex();
						}
					}
				}
				else if (m_eTabSelect==SELECTED_PLAYER)	//selected player
				{
					if (pList->GetItemState(i-1,LVIS_SELECTED)==LVIS_SELECTED)
					{
						CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i-1));
						newOrder=CSystemInfo::GetNextInfoOrder(player->GetIndex());
						if ( newOrder > nowOrder )
						{
							nowOrder=newOrder;
							index=player->GetIndex();
						}
					}
				}
			}
		}
		if (index>=0)
		{
			if (m_RichEditInformation.GetLineCount()>SYSTEM_INFORMATION_MAXNUM)
			{
				m_RichEditInformation.LockWindowUpdate();
				m_RichEditInformation.SetSel(0,m_RichEditInformation.LineLength(0)+1);
				m_RichEditInformation.ReplaceSel(NULL);
				m_RichEditInformation.UnlockWindowUpdate();
			}
			CSystemInfo::MoveNext(index);
			CHARFORMAT cf;
			cf.dwMask = CFM_COLOR;
			cf.crTextColor = CSystemInfo::GetNowLineColor(index);
			cf.dwEffects=0;
			m_RichEditInformation.SetSel(-1,-1);
			int nSel=m_ComboMode.GetCurSel();
			if (nSel==CB_ERR || nSel<CSystemInfo::GetNowLineLevel(index))
			{
				continue;
			}
			m_RichEditInformation.SetWordCharFormat(cf);
			m_RichEditInformation.ReplaceSel(CSystemInfo::GetNowLine(index)+"\n");
		}
	} while(index!=-1);
	int nLineScroll=m_RichEditInformation.GetLineCount()-m_RichEditInformation.GetFirstVisibleLine()-EDIT_MAX_VISIBLE_LINE;
	if (nLineScroll>0) m_RichEditInformation.LineScroll(nLineScroll,0);
	MSG msg;
	while (PeekMessage(&msg,this->m_hWnd,WM_TIMER,WM_TIMER,PM_REMOVE));
}

void CMainView::OnRefreshEditOnce()
{
	if (m_ButtonLock.GetCheck()) return;
	CLoginPage *pPage=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetLoginPage();
	if (!pPage) return;
	CListCtrl *pList=&pPage->m_LoginList;
	if (!pList) return;
	int nTotal=pList->GetItemCount();
	int index;
	DWORD nowOrder,newOrder;
	m_RichEditInformation.LockWindowUpdate();
	do
	{
		index=-1;
		nowOrder=0;
		if (m_eTabSelect==CURRENT_PLAYER)	//current player
		{
			//int nSel=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetItemView()->m_ComboSelectMainRole.GetCurSel();
			//if (nSel==CB_ERR) return;
			//index=(int)reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetItemView()->m_ComboSelectMainRole.GetItemData(nSel);
			index=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
			if (index==0) return;
			if (CSystemInfo::GetNextInfoOrder(index)==0) break;
		}
		else
		{
			for (int i=0;i<=nTotal;i++)	//i starts from 1, 0 is a system message
			{
				newOrder=0;
				if ( i==0 )
				{
					newOrder=CSystemInfo::GetNextInfoOrder(0);
					if ( newOrder > nowOrder )
					{
						nowOrder=newOrder;
						index=0;
					}
					continue;
				}
				if (m_eTabSelect==ALL_PLAYER)	//all players
				{
					CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i-1));
					newOrder=CSystemInfo::GetNextInfoOrder(player->GetIndex());
					if ( newOrder > nowOrder )
					{
						nowOrder=newOrder;
						index=player->GetIndex();
					}
				}
				else if (m_eTabSelect==CHECKED_PLAYER)	//Checked players
				{
					if (pList->GetCheck(i-1))
					{
						CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i-1));
						newOrder=CSystemInfo::GetNextInfoOrder(player->GetIndex());
						if ( newOrder > nowOrder )
						{
							nowOrder=newOrder;
							index=player->GetIndex();
						}
					}
				}
				else if (m_eTabSelect==SELECTED_PLAYER)	//selected player
				{
					if (pList->GetItemState(i-1,LVIS_SELECTED)==LVIS_SELECTED)
					{
						CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i-1));
						newOrder=CSystemInfo::GetNextInfoOrder(player->GetIndex());
						if ( newOrder > nowOrder )
						{
							nowOrder=newOrder;
							index=player->GetIndex();
						}
					}
				}
			}
		}
		if (index>=0)
		{
			CSystemInfo::MoveNext(index);
			CHARFORMAT cf;
			cf.dwMask = CFM_COLOR;
			cf.crTextColor = CSystemInfo::GetNowLineColor(index);
			cf.dwEffects=0;
			m_RichEditInformation.SetSel(-1,-1);
			int nSel=m_ComboMode.GetCurSel();
			if (nSel==CB_ERR || nSel<CSystemInfo::GetNowLineLevel(index))
			{
				continue;
			}
			m_RichEditInformation.SetWordCharFormat(cf);
			m_RichEditInformation.ReplaceSel(CSystemInfo::GetNowLine(index)+"\n");
		}
	} while(index!=-1);
	if (m_RichEditInformation.GetLineCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		int nCut=0;
		for (int i=0;i<m_RichEditInformation.GetLineCount()-SYSTEM_INFORMATION_MAXNUM;i++)
		{
			nCut+=m_RichEditInformation.LineLength(i)+1;
		}
		m_RichEditInformation.SetSel(0,nCut);
		m_RichEditInformation.ReplaceSel(NULL);
	}
	int nLineScroll=m_RichEditInformation.GetLineCount()-m_RichEditInformation.GetFirstVisibleLine()-EDIT_MAX_VISIBLE_LINE;
	if (nLineScroll>0) m_RichEditInformation.LineScroll(nLineScroll,0);
	m_RichEditInformation.UnlockWindowUpdate();
	MSG msg;
	while (PeekMessage(&msg,this->m_hWnd,WM_TIMER,WM_TIMER,PM_REMOVE));
}

LRESULT CMainView::OnThreadRefreshInfo( WPARAM wParam, LPARAM lParam)
{
	if (m_ButtonLock.GetCheck()) return FALSE;
	int index=(int)wParam;
	if (m_eTabSelect==CURRENT_PLAYER)
	{
		if (!CPlayerMgr::GetMainPlayer() || CPlayerMgr::GetMainPlayer()->GetIndex()!=index)
		{
			return FALSE;
		}
	}
	else if ( m_eTabSelect==CHECKED_PLAYER )
	{
		CLoginPage *pPage=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetLoginPage();
		if (!pPage) return FALSE;
		CListCtrl *pList=&pPage->m_LoginList;
		if (!pList) return FALSE;
		for (int i=0;i<pList->GetItemCount();i++)
		{
			CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i));
			if (player->GetIndex()==index)
			{
				if (pList->GetCheck(i))
				{
					break;
				}
				else
				{
					return FALSE;
				}
			}
		}
	}
	else if ( m_eTabSelect==SELECTED_PLAYER )
	{
		CLoginPage *pPage=reinterpret_cast<CMainFrame*>(theApp.GetMainWnd())->GetLoginPage();
		if (!pPage) return FALSE;
		CListCtrl *pList=&pPage->m_LoginList;
		if (!pList) return FALSE;
		for (int i=0;i<pList->GetItemCount();i++)
		{
			CPlayer* player=reinterpret_cast<CPlayer*>(pList->GetItemData(i));
			if (player->GetIndex()==index)
			{
				if (pList->GetItemState(i,LVIS_SELECTED)==LVIS_SELECTED)
				{
					break;
				}
				else
				{
					return FALSE;
				}
			}
		}
	}
	if (CSystemInfo::GetNextInfoOrder(index)==0) return FALSE;
	if (m_RichEditInformation.GetLineCount()>SYSTEM_INFORMATION_MAXNUM)
	{
		m_RichEditInformation.LockWindowUpdate();
		m_RichEditInformation.SetSel(0,m_RichEditInformation.LineLength(0)+1);
		m_RichEditInformation.ReplaceSel(NULL);
		m_RichEditInformation.UnlockWindowUpdate();
	}
	CSystemInfo::MoveNext(index);
	CHARFORMAT cf;
	cf.dwMask = CFM_COLOR;
	cf.crTextColor = CSystemInfo::GetNowLineColor(index);
	cf.dwEffects=0;
	m_RichEditInformation.SetSel(-1,-1);
	int nSel=m_ComboMode.GetCurSel();
	if (nSel==CB_ERR || nSel<CSystemInfo::GetNowLineLevel(index))
	{
		return FALSE;
	}
	m_RichEditInformation.SetWordCharFormat(cf);
	m_RichEditInformation.ReplaceSel(CSystemInfo::GetNowLine(index)+"\n");
	return TRUE;
}

void CMainView::OnTimer(UINT nIDEvent)
{
	// TODO: Add your message handler code here and/or call default
	if (nIDEvent==1)
	{
		OnRefreshEdit();
	}
	CFormView::OnTimer(nIDEvent);
}

void CMainView::OnTcnSelchangeTab1(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO: Add your control notification handler code here
	*pResult = 0;
	eTabSelect sel=(eTabSelect)m_TabSystemInfo.GetCurSel();
	if (m_eTabSelect==sel)
	{
		return;
	}
	else
	{
		if (sel==ALL_PLAYER)
		{
			if (CPlayerMgr::GetTotalPlayers()>ACCOUNT_MAXNUM)
			{
				MessageBox("Operation failed: Exceeded the maximum number of users, cannot view multi-person information");
				m_eTabSelect=CURRENT_PLAYER;
				m_TabSystemInfo.SetCurSel(0);
				return;
			}
		}
		else if (sel==SELECTED_PLAYER)
		{
			if (CPlayerMgr::GetTotalPlayers()>ACCOUNT_MAXNUM)
			{
				MessageBox("Operation failed: Exceeded the maximum number of users, cannot view multi-person information");
				m_eTabSelect=CURRENT_PLAYER;
				m_TabSystemInfo.SetCurSel(0);
				return;
			}
		}
		else if (sel==CHECKED_PLAYER)
		{
			if (CPlayerMgr::GetTotalPlayers()>ACCOUNT_MAXNUM)
			{
				MessageBox("Operation failed: Exceeded the maximum number of users, cannot view multi-person information");
				m_eTabSelect=CURRENT_PLAYER;
				m_TabSystemInfo.SetCurSel(0);
				return;
			}
		}
		m_eTabSelect=sel;
		OnBnClickedButtonClear();
		CSystemInfo::ResetAllPosition();
		OnRefreshEditOnce();
	}
}

void CMainView::OnPlayerSwitch(CPlayer *pLastPlayer,CPlayer *pNowPlayer)
{
	m_SystemPage.OnPlayerSwitch(pLastPlayer,pNowPlayer);
	m_TalkPage.OnPlayerSwitch(pLastPlayer,pNowPlayer);
	
	
	
	CPlayer *player=CPlayerMgr::GetMainPlayer();
	if (player==NULL) return;
	CSystemInfo::ResetPosition(player->GetIndex());
	if (player->GetOption().IsDropTest_AccountServer())
	{
		CheckRadioButton(IDC_RADIO1,IDC_RADIO6,IDC_RADIO1);
	}
	else if (player->GetOption().IsDropTest_GameServer())
	{
		CheckRadioButton(IDC_RADIO1,IDC_RADIO6,IDC_RADIO2);
	}
	else if (player->GetOption().IsAutoMove())
	{
		CheckRadioButton(IDC_RADIO1,IDC_RADIO6,IDC_RADIO3);
	}
	else if (player->GetOption().IsAutoTele())
	{
		CheckRadioButton(IDC_RADIO1,IDC_RADIO6,IDC_RADIO5);
	}
	else if (player->GetOption().IsDropTest_GateServer())
	{
		CheckRadioButton(IDC_RADIO1,IDC_RADIO6,IDC_RADIO6);
	}
	else
	{
		CheckRadioButton(IDC_RADIO1,IDC_RADIO5,IDC_RADIO4);
	}
	GetDlgItem(IDC_RADIO1)->EnableWindow();
	GetDlgItem(IDC_RADIO2)->EnableWindow();
	GetDlgItem(IDC_RADIO3)->EnableWindow();
	GetDlgItem(IDC_RADIO4)->EnableWindow();
	GetDlgItem(IDC_RADIO5)->EnableWindow();
	GetDlgItem(IDC_RADIO6)->EnableWindow();
	m_btnSettheSame.EnableWindow();
	m_btnSettheSame.SetCheck(BST_UNCHECKED);
	OnRefreshEditOnce();
}

void CMainView::OnAllPlayerDeleted()
{
	GetDlgItem(IDC_RADIO1)->EnableWindow(false);
	GetDlgItem(IDC_RADIO2)->EnableWindow(false);
	GetDlgItem(IDC_RADIO3)->EnableWindow(false);
	GetDlgItem(IDC_RADIO4)->EnableWindow(false);
	GetDlgItem(IDC_RADIO5)->EnableWindow(false);
	GetDlgItem(IDC_RADIO6)->EnableWindow(false);
	m_btnSettheSame.EnableWindow(false);
}

void CMainView::OnBnClickedButtonClear()
{
	// TODO: Add your control notification handler code here
	m_RichEditInformation.SetWindowText(NULL);
}

void CMainView::OnBnClickedRadio1()
{
	// TODO: Add your control notification handler code here
	CPlayer* player=CPlayerMgr::GetMainPlayer();
	if (player==NULL)
	{
		return;
	}
	player->GetOption().SetDropTest_AccountServer(true);
}

void CMainView::OnBnClickedRadio2()
{
	// TODO: Add your control notification handler code here
	CPlayer* player=CPlayerMgr::GetMainPlayer();
	if (player==NULL)
	{
		return;
	}
	player->GetOption().SetDropTest_GameServer(true);
}

void CMainView::OnBnClickedRadio3()
{
	// TODO: Add your control notification handler code here
	CPlayer* player=CPlayerMgr::GetMainPlayer();
	if (player==NULL)
	{
		return;
	}
	player->GetOption().SetAutoMove(true);
}
               
void CMainView::OnBnClickedRadio4()
{
	// TODO: Add your control notification handler code here
	CPlayer* player=CPlayerMgr::GetMainPlayer();
	if (player==NULL)
	{
		return;
	}
	player->GetOption().ResetAll();
}

void CMainView::OnBnClickedRadio5()
{
	// TODO: Add your control notification handler code here
	CPlayer* player=CPlayerMgr::GetMainPlayer();
	if (player==NULL)
	{
		return;
	}
	player->GetOption().SetAutoTele(true);
}

void CMainView::OnBnClickedRadio6()
{
	// TODO: Add your control notification handler code here
	CPlayer* player=CPlayerMgr::GetMainPlayer();
	if (player==NULL)
	{
		return;
	}
	player->GetOption().SetDropTest_GateServer(true);
}

void CMainView::OnBnClickedCheckSetTheSame()
{
	// TODO: Add your control notification handler code here
	int idc=GetCheckedRadioButton(IDC_RADIO1,IDC_RADIO6);
	if (m_btnSettheSame.GetCheck()!=BST_CHECKED) return;
	CPlayer *player=CPlayerMgr::GetFirstPlayer();
	while (player)
	{
		if (idc==IDC_RADIO1)
		{
			player->GetOption().SetDropTest_AccountServer(true);
		}
		else if (idc==IDC_RADIO2)
		{
			player->GetOption().SetDropTest_GameServer(true);
		}
		else if (idc==IDC_RADIO3)
		{
			player->GetOption().SetAutoMove(true);
		}
		else if (idc==IDC_RADIO4)
		{
			player->GetOption().ResetAll();
		}
		else if (idc==IDC_RADIO5)
		{
			player->GetOption().SetAutoTele(true);
		}
		else if (idc==IDC_RADIO6)
		{
			player->GetOption().SetDropTest_GateServer(true);
		}
		player=CPlayerMgr::GetNextPlayer();
	}
}

void CMainView::OnBnClickedCheckLock()
{
	// TODO: Add your control notification handler code here
	if (m_ButtonLock.GetCheck())
	{
		CSystemInfo::Close();
	}
	else
	{
		CSystemInfo::Open();
	}
}






CSystemPage& CMainView::GetSystemPage()
{
	return m_SystemPage;
}

CTalkPage& CMainView::GetTalkPage()
{
	return m_TalkPage;
}

CMapPage& CMainView::GetMapPage()
{
	return m_MapPage;
}

CScriptPage& CMainView::GetScriptPage()
{
	return m_ScriptPage;
}

CSetupPage& CMainView::GetSetupPage()
{
	return m_SetupPage;
}





