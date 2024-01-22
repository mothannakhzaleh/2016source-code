// LoginPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "ItemView.h"
#include "LoginPage.h"
#include "LoginData.h"
#include "MainFrm.h"
#include "MainView.h"
#include "TeleTable.h"
#include "DeleteConfirmDlg.h"
#include "ServerMgr.h"
#include "LoginPage.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


IMPLEMENT_DYNAMIC(CLoginPage, CPropertyPage)
CLoginPage::CLoginPage()
	: CPropertyPage(CLoginPage::IDD)
{
	nMaxPlayerCount=0;
	nMinPlayerCount=0;
	ZeroMemory(m_bUsedIndexFlag,sizeof(m_bUsedIndexFlag));
}

CLoginPage::~CLoginPage()
{
}

void CLoginPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST_ACCOUNT, m_LoginList);
	DDX_Control(pDX, IDC_EDIT_ACCOUNT, m_EditAccountName);
	DDX_Control(pDX, IDC_EDIT_PASSWORD, m_EditPassword);
	DDX_Control(pDX, IDC_BUTTON_DELETE, m_BtnDelete);
	DDX_Control(pDX, IDC_COMBO_ROLE, m_ComboRoleSelect);
	DDX_Control(pDX, IDC_CHECK_DONT_RECONNECT, m_btnNoReconnect);
	DDX_Control(pDX, IDC_CHECK_AUTO_CREATE_DEL, m_btnAutoCreateDel);
	DDX_Control(pDX, IDC_COMBO_SERVER, m_ComboService);
}


BEGIN_MESSAGE_MAP(CLoginPage, CPropertyPage)
	ON_BN_CLICKED(IDC_BUTTON_ADD, OnBnClickedButtonAdd)
	ON_NOTIFY(LVN_ITEMCHANGED, IDC_LIST_ACCOUNT, OnLvnItemchangedListAccount)
	ON_BN_CLICKED(IDC_BUTTON_DELETE, OnBnClickedButtonDelete)
	ON_BN_CLICKED(IDC_BUTTON_SAVE, OnBnClickedButtonSave)
	ON_BN_CLICKED(IDC_BUTTON_LOAD, OnBnClickedButtonLoad)
	ON_BN_CLICKED(IDC_BUTTON_LOGIN, OnBnClickedButtonLogin)
	ON_MESSAGE(THREAD_MSG_REFRESH_STATE, OnThreadRefreshState)
	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_BUTTON6, OnBnClickedButton6)
	ON_BN_CLICKED(IDC_BUTTON_LOAD_MOVE_TABLE, OnBnClickedButtonLoadMoveTable)
END_MESSAGE_MAP()


// CLoginPage message handlers

BOOL CLoginPage::OnInitDialog()
{
	UpdateData(FALSE);
	m_LoginList.InsertColumn(0,"ID",LVCFMT_LEFT,40);
	m_LoginList.InsertColumn(1,"Account number",LVCFMT_LEFT,65);
	m_LoginList.InsertColumn(2,"Login status",LVCFMT_LEFT,150);
	m_LoginList.InsertColumn(3,"Server address",LVCFMT_LEFT,100);
	m_LoginList.InsertColumn(4,"Online users",LVCFMT_LEFT,80);
	m_LoginList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_TRACKSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB|LVS_EX_CHECKBOXES|m_LoginList.GetExtendedStyle());
	m_ComboRoleSelect.AddString("The first role");
	m_ComboRoleSelect.AddString("The second role");
	m_ComboRoleSelect.AddString("The third role");
	m_ComboRoleSelect.SetCurSel(0);
	for (int i=0;true;i++)
	{
		CString strServerName=CServerMgr::GetServerName(i);
		CString strServerIP=CServerMgr::GetServerIP(i);
		if (strServerName.IsEmpty() || strServerIP.IsEmpty()) break;
		m_ComboService.InsertString(i,strServerName);
	}
	m_ComboService.SetCurSel(0);
	m_pComboSelectMainRole=((CMainFrame*)theApp.m_pMainWnd)->GetItemView()->GetComboSelectMainRole();
	SetTimer(1,5000,NULL);
	return TRUE;
}

void CLoginPage::OnTimer(UINT nIDEvent)
{
	// TODO: Add your message handler code here and/or call default
	if (nIDEvent==1)
	{
		int nAccountCount=m_LoginList.GetItemCount();
		int nLoginAccountCount=0;
		int nTotalPlayerCount=0;
		bool nAllAccountLoginFlag=true;
		for (int i=0;i<nAccountCount;i++)
		{
			CPlayer *player=reinterpret_cast<CPlayer*>(m_LoginList.GetItemData(i));
			if (player)
			{
				if (player->GetLoginState()==CPlayer::eLOGON_GAME)
				{
					nLoginAccountCount++;
				}
				m_LoginList.SetItemText(i,2,player->GetLoginStateInfo());
				CString strPlayerCount;
				DWORD n=player->GetTotalPlayerCount();
				if (n>0)
				{
					strPlayerCount.Format("%d",n);
				}
				else
				{
					strPlayerCount="Unknown";
					nAllAccountLoginFlag=false;
				}
				m_LoginList.SetItemText(i,4,strPlayerCount);
				nTotalPlayerCount+=n;
			}
		}
		if (nMaxPlayerCount<nTotalPlayerCount) nMaxPlayerCount=nTotalPlayerCount;
		if ((nMinPlayerCount>nTotalPlayerCount || nMinPlayerCount==0) && nAllAccountLoginFlag) nMinPlayerCount=nTotalPlayerCount;
		CString strTitle;
		strTitle.Format("BKop - account statistics (logged in/total): %d/%d total player statistics (current/minimum/maximum): %d/%d/%d",nLoginAccountCount,nAccountCount,nTotalPlayerCount,nMinPlayerCount,nMaxPlayerCount);
		theApp.GetMainWnd()->SetWindowText(strTitle);
		MSG msg;
		while (PeekMessage(&msg,this->m_hWnd,WM_TIMER,WM_TIMER,PM_REMOVE));
	}
	CPropertyPage::OnTimer(nIDEvent);
}

int CLoginPage::AllocateIndex()
{
	nMaxPlayerCount=0;
	nMinPlayerCount=0;
	for (int i=1;i<=ACCOUNT_MAXNUM;i++)
	{
		if (!m_bUsedIndexFlag[i])
		{
			m_bUsedIndexFlag[i]=true;
			return i;
		}
	}
	ASSERT(false);
	MessageBox("Program error! The number of clients has reached the upper limit of the program, please restart the program");
	return -1;
}

void CLoginPage::ReleaseIndex(int index)
{
	nMaxPlayerCount=0;
	nMinPlayerCount=0;
	if (index<=0 ||index>ACCOUNT_MAXNUM)
	{
		ASSERT(false);
	}
	if (m_bUsedIndexFlag[index]==false)
	{
		ASSERT(false);
	}
	CSystemInfo::DeleteInfo(index);
	m_bUsedIndexFlag[index]=false;
}

DWORD CLoginPage::GetCurSelectCount()
{
	return m_LoginList.GetSelectedCount();
}

DWORD CLoginPage::GetCurCheckCount()
{
	DWORD n=0;
	for (int i=0;i<m_LoginList.GetItemCount();i++)
	{
		if (m_LoginList.GetCheck(i))
		{
			n++;
		}
	}
	return n;
}

void CLoginPage::OnBnClickedButtonAdd()
{
	// TODO: Add your control notification handler code here
	CString strServiceName,strAccountName,strPassword;
	m_ComboService.GetWindowText(strServiceName);
	m_EditAccountName.GetWindowText(strAccountName);
	m_EditPassword.GetWindowText(strPassword);
	if (strServiceName.IsEmpty() || strAccountName.IsEmpty() || strPassword.IsEmpty())
	{
		MessageBox("Please enter correct login information");
		return;
	}
	int index=AllocateIndex();
	char buf[30];
	sprintf_s(buf,"%d",index);
	int n=m_LoginList.InsertItem(m_LoginList.GetItemCount(),buf);
	if (n!=CB_ERR)
	{
		int nRole=m_ComboRoleSelect.GetCurSel();
		if (nRole==CB_ERR) nRole=0;
		CPlayer *player=CPlayerMgr::AddPlayer(strServiceName,strAccountName,strPassword,nRole);
		m_LoginList.SetItem(n,1,LVIF_TEXT,strAccountName,0,0,0,NULL);
		m_LoginList.SetItem(n,2,LVIF_TEXT|LVIF_STATE,"Idle",0,0,0,NULL);
		m_LoginList.SetItem(n,3,LVIF_TEXT|LVIF_STATE,strServiceName,0,0,0,NULL);
		m_LoginList.SetCheck(n);
		m_LoginList.SetItemData(n,(DWORD_PTR)player);
		player->SetIndex(index);
		int nRetIndex=m_pComboSelectMainRole->InsertString(m_pComboSelectMainRole->GetCount(),CString(buf)+"."+strAccountName);
		m_pComboSelectMainRole->SetItemData(nRetIndex,index);
		if (m_pComboSelectMainRole->GetCurSel()==CB_ERR)
		{
			m_pComboSelectMainRole->SetCurSel(0);
			((CMainFrame*)theApp.m_pMainWnd)->GetItemView()->OnCbnSelchangeComboSelectPlayer();
		}
		GetDlgItem(IDC_BUTTON_DELETE)->EnableWindow();
	}
	m_EditAccountName.SetWindowText(NULL);
	m_EditPassword.SetWindowText(NULL);
	m_EditAccountName.SetFocus();
}

void CLoginPage::OnLvnItemchangedListAccount(NMHDR *pNMHDR, LRESULT *pResult)
{
	LPNMLISTVIEW pNMLV = reinterpret_cast<LPNMLISTVIEW>(pNMHDR);
	// TODO: Add your control notification handler code here
	if (pNMLV->iItem!=CB_ERR)
	{
		m_BtnDelete.EnableWindow();
	}
	else
	{
		m_BtnDelete.EnableWindow(false);
	}
	*pResult = 0;
}

void CLoginPage::OnBnClickedButtonDelete()
{
	// TODO: Add your control notification handler code here
	if (CPlayerMgr::GetTotalPlayers()==0)
	{
		GetDlgItem(IDC_BUTTON_DELETE)->EnableWindow(FALSE);
		return;
	}
	CDeleteConfirmDlg *pDlg=new CDeleteConfirmDlg();
	int n=(int)pDlg->DoModal();
	delete pDlg;
	if (n==CDeleteConfirmDlg::eDelete_All)
	{
		CPlayerMgr::DeleteAllPlayers();
		m_pComboSelectMainRole->ResetContent();
		m_LoginList.DeleteAllItems();
		ZeroMemory(m_bUsedIndexFlag,sizeof(m_bUsedIndexFlag));
		CSystemInfo::DeleteAllInfos();
	}
	else if (n==CDeleteConfirmDlg::eDelete_Check)
	{
		int *index=new int[m_LoginList.GetItemCount()];
		int indexArraySize=0;
		int i=0;
		for (;i<m_LoginList.GetItemCount();i++)
		{
			if (m_LoginList.GetCheck(i))
			{
				CPlayer *player=reinterpret_cast<CPlayer*>(m_LoginList.GetItemData(i));
				for (int j=0;j<m_pComboSelectMainRole->GetCount();j++)
				{
					if (player->GetIndex()==m_pComboSelectMainRole->GetItemData(j))
					{
						m_pComboSelectMainRole->DeleteString(j);
						break;
					}
				}
				index[indexArraySize++]=player->GetIndex();
			}
		}
		CPlayerMgr::DeletePlayers(index,indexArraySize);
		for (i=0;i<indexArraySize;i++)
		{
			ReleaseIndex(index[i]);
		}
		for (i=0;i<m_LoginList.GetItemCount();i++)
		{
			if (m_LoginList.GetCheck(i))
			{
				m_LoginList.DeleteItem(i);
				i=-1;
			}
		}
		delete[] index;
	}
	else if (n==CDeleteConfirmDlg::eDelete_Select)
	{
		int *index=new int[m_LoginList.GetItemCount()];
		int indexArraySize=0;
		int i=0;
		for (;i<m_LoginList.GetItemCount();i++)
		{
			if (m_LoginList.GetItemState(i,LVIS_SELECTED)==LVIS_SELECTED)
			{
				CPlayer *player=reinterpret_cast<CPlayer*>(m_LoginList.GetItemData(i));
				for (int j=0;j<m_pComboSelectMainRole->GetCount();j++)
				{
					if (player->GetIndex()==m_pComboSelectMainRole->GetItemData(j))
					{
						m_pComboSelectMainRole->DeleteString(j);
						break;
					}
				}
				index[indexArraySize++]=player->GetIndex();
			}
		}
		CPlayerMgr::DeletePlayers(index,indexArraySize);
		for (i=0;i<indexArraySize;i++)
		{
			ReleaseIndex(index[i]);
		}
		for (i=0;i<m_LoginList.GetItemCount();i++)
		{
			if (m_LoginList.GetItemState(i,LVIS_SELECTED)==LVIS_SELECTED)
			{
				m_LoginList.DeleteItem(i);
				i=-1;
			}
		}
		delete[] index;
	}
	else if (n==CDeleteConfirmDlg::eDelete_Current)
	{
		int nSel=m_pComboSelectMainRole->GetCurSel();
		if (nSel!=CB_ERR)
		{
			int index=(int)m_pComboSelectMainRole->GetItemData(nSel);
			for (int i=0;i<m_LoginList.GetItemCount();i++)
			{
				CPlayer *player=reinterpret_cast<CPlayer*>(m_LoginList.GetItemData(i));
				if (player->GetIndex()==index)
				{
					m_pComboSelectMainRole->DeleteString(nSel);
					CPlayerMgr::RemovePlayer(player->GetIndex());
					ReleaseIndex(index);
					m_LoginList.DeleteItem(i);
					break;
				}
			}
		}
	}
	if (CPlayerMgr::GetTotalPlayers()==0)
	{
		GetDlgItem(IDC_BUTTON_DELETE)->EnableWindow(FALSE);
		((CMainFrame*)theApp.GetMainWnd())->GetMainView()->OnAllPlayerDeleted();
		((CMainFrame*)theApp.GetMainWnd())->GetItemView()->OnCbnSelchangeComboSelectPlayer();
		m_pComboSelectMainRole->RedrawWindow();
	}
	else if (m_pComboSelectMainRole->GetCurSel()==CB_ERR)
	{
		m_pComboSelectMainRole->SetCurSel(0);
		((CMainFrame*)theApp.m_pMainWnd)->GetItemView()->OnCbnSelchangeComboSelectPlayer();
	}
}

void CLoginPage::OnBnClickedButtonSave()
{
	// TODO: Add your control notification handler code here
	int n=CPlayerMgr::GetTotalPlayers();
	if (n<=0)
	{
		MessageBox("Operation failed: there is no account in the current list, please add an account first! ", "mistake");
		return;
	}
	CFileDialog fileDlg(FALSE,"ACC","*.ACC",OFN_FILEMUSTEXIST|OFN_NOCHANGEDIR|OFN_HIDEREADONLY|OFN_OVERWRITEPROMPT,"BKop Account Files (*.ACC)|*.ACC|All Files (*.*)|*.*||",this);
	if( fileDlg.DoModal()!=IDOK )
	{
		return;
	}
	CStdioFile file;
	if (!file.Open(fileDlg.GetPathName(),CFile::modeCreate|CFile::typeText|CFile::modeWrite))
	{
		return;
	}
	CString strServiceName,strAccountName,strPassword,strSelectRoleNum;
	CPlayer *player=CPlayerMgr::GetFirstPlayer();
	while(player)
	{
		strServiceName=player->GetLoginData()->GetServiceName();
		strAccountName=player->GetLoginData()->GetAccountName();
		strPassword=player->GetLoginData()->GetPassword();
		strSelectRoleNum.Format("%d",player->GetMainRoleIndex());
		file.WriteString(strServiceName+"\n");
		file.WriteString(strAccountName+"\n");
		file.WriteString(strPassword+"\n");
		file.WriteString(strSelectRoleNum+"\n");
		player=CPlayerMgr::GetNextPlayer();
	}
	file.Close();
}

void CLoginPage::OnBnClickedButtonLoad()
{
	//// TODO: Add your control notification handler code here
	CFileDialog fileDlg(TRUE,"ACC","*.ACC",OFN_FILEMUSTEXIST|OFN_NOCHANGEDIR|OFN_HIDEREADONLY,"BKop Account Files (*.ACC)|*.ACC|All Files (*.*)|*.*||",this);
	if( fileDlg.DoModal()!=IDOK )
	{
		return;
	}
	CStdioFile file;
	if (!file.Open(fileDlg.GetPathName(),CFile::modeRead|CFile::typeText))
	{
		return;
	}
	CString strServiceName,strAccountName,strPassword,strSelectRoleNum;
	while (file.ReadString(strServiceName))
	{
		if (!file.ReadString(strAccountName)) break;
		if (!file.ReadString(strPassword)) break;
		if (!file.ReadString(strSelectRoleNum)) break;
		int nRole=atoi(strSelectRoleNum);
		if (nRole<0 || nRole>ROLE_LIST_MAXNUM) break;
		int index=AllocateIndex();
		char buf[30];
		sprintf_s(buf,"%d",index);
		int n=m_LoginList.InsertItem(m_LoginList.GetItemCount(),buf);
		if (n!=CB_ERR)
		{
			CPlayer *player=CPlayerMgr::AddPlayer(strServiceName,strAccountName,strPassword,nRole);
			m_LoginList.SetItem(n,1,LVIF_TEXT,strAccountName,0,0,0,NULL);
			m_LoginList.SetItem(n,2,LVIF_TEXT|LVIF_STATE,"Idle",0,0,0,NULL);
			m_LoginList.SetItem(n,3,LVIF_TEXT|LVIF_STATE,strServiceName,0,0,0,NULL);
			m_LoginList.SetCheck(n);
			m_LoginList.SetItemData(n,(DWORD_PTR)player);
			player->SetIndex(index);
			int nRetIndex=m_pComboSelectMainRole->InsertString(m_pComboSelectMainRole->GetCount(),CString(buf)+"."+strAccountName);
			m_pComboSelectMainRole->SetItemData(nRetIndex,index);
			GetDlgItem(IDC_BUTTON_DELETE)->EnableWindow();
		}
	}
	file.Close();
	if (m_pComboSelectMainRole->GetCurSel()==CB_ERR)
	{
		m_pComboSelectMainRole->SetCurSel(0);
		((CMainFrame*)theApp.m_pMainWnd)->GetItemView()->OnCbnSelchangeComboSelectPlayer();
	}
	m_EditAccountName.SetFocus();
}

void CLoginPage::OnBnClickedButtonLogin()
{
	//TODO: Add your control notification handler code here
	if (CPlayerMgr::GetTotalPlayers()>ACCOUNT_MAXNUM)
	{
		if (((CMainFrame*)theApp.m_pMainWnd)->GetMainView()->m_TabSystemInfo.GetCurSel()!=CMainView::CURRENT_PLAYER)
		{
			MessageBox("Operation failed: Exceeded the maximum number of users, please choose to browse the [current player] information page and then log in");
			return;
		}
	}
	for (int i=0;i<m_LoginList.GetItemCount();i++)
	{
		if (m_LoginList.GetCheck(i))
		{
			CPlayer *player=reinterpret_cast<CPlayer*>(m_LoginList.GetItemData(i));
			player->StartRun();
		}
	}
}

LRESULT CLoginPage::OnThreadRefreshState( WPARAM wParam, LPARAM lParam)
{
	CPlayer *player=reinterpret_cast<CPlayer*>(lParam);
	if (!player) return FALSE;
	for (int i=0;i<m_LoginList.GetItemCount();i++)
	{
		if (lParam==m_LoginList.GetItemData(i))
		{
			m_LoginList.SetItemText(i,2,player->GetLoginStateInfo());
			return TRUE;
		}
	}
	return FALSE;
}

bool CLoginPage::GetIsReconnect()
{
	if (m_btnNoReconnect.GetCheck()==BST_CHECKED)
	{
		return false;
	}
	return true;
}

bool CLoginPage::GetIsAutoCreateDel()
{
	if (m_btnAutoCreateDel.GetCheck()==BST_CHECKED)
	{
		return true;
	}
	return false;
}

void CLoginPage::OnBnClickedButton6()
{
	// TODO: Add your control notification handler code here
	MessageBox("Due to protocol changes, this function is blocked, please use the delete function instead of logout");
}

void CLoginPage::OnBnClickedButtonLoadMoveTable()
{
	// TODO: Add your control notification handler code here
	CFileDialog fileDlg(TRUE,"BTT","*.BTT",OFN_FILEMUSTEXIST|OFN_NOCHANGEDIR|OFN_HIDEREADONLY,"BKop Tele Table Files (*.BTT)|*.BTT|All Files (*.*)|*.*||",this);
	if( fileDlg.DoModal()!=IDOK )
	{
		return;
	}
	CStdioFile file;
	if (!file.Open(fileDlg.GetPathName(),CFile::modeRead|CFile::typeText))
	{
		return;
	}
	int i=0;
	CString strTeleText;
	while (file.ReadString(strTeleText) && ++i<AUTO_TELE_TABLE_MAXNUM)
	{
		CTeleTable::AddTargetText(strTeleText);
	}
	file.Close();
}
