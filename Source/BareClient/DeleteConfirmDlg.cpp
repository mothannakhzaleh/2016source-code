// DeleteConfirmDlg.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "LoginPage.h"
#include "ItemView.h"
#include "MainFrm.h"
#include ".\deleteconfirmdlg.h"
#include "DeleteConfirmDlg.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CDeleteConfirmDlg dialog

IMPLEMENT_DYNAMIC(CDeleteConfirmDlg, CDialog)
CDeleteConfirmDlg::CDeleteConfirmDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CDeleteConfirmDlg::IDD, pParent)
{
}

CDeleteConfirmDlg::~CDeleteConfirmDlg()
{
}

void CDeleteConfirmDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CDeleteConfirmDlg, CDialog)
	ON_BN_CLICKED(IDC_BUTTON7, OnBnClickedButton7)
	ON_BN_CLICKED(IDC_BUTTON_TOTAL_COUNT, OnBnClickedButtonTotalCount)
	ON_BN_CLICKED(IDC_BUTTON_SELECTED_COUNT, OnBnClickedButtonSelectedCount)
	ON_BN_CLICKED(IDC_BUTTON_CHECK_COUNT, OnBnClickedButtonCheckCount)
	ON_BN_CLICKED(IDC_BUTTON_NOW_COUNT, OnBnClickedButtonNowCount)
END_MESSAGE_MAP()


// CDeleteConfirmDlg message handlers

BOOL CDeleteConfirmDlg::OnInitDialog()
{
	int n=0;
	CString str;
	CLoginPage *pPage=((CMainFrame*)theApp.m_pMainWnd)->GetLoginPage();
	n=pPage->m_LoginList.GetItemCount();
	str.Format("Total number of accounts: %d",n);
	GetDlgItem(IDC_STATIC_TOTAL_COUNT)->SetWindowText(str);
	((CMainFrame*)theApp.m_pMainWnd)->GetItemView()->GetComboSelectMainRole()->GetWindowText(str);
	GetDlgItem(IDC_STATIC_NOW_COUNT)->SetWindowText("Current Account:"+str);
	n=pPage->GetCurSelectCount();
	str.Format("Number of accounts: %d",n);
	GetDlgItem(IDC_STATIC_SELECTED_COUNT)->SetWindowText(str);
	if (n==0)
	{
		GetDlgItem(IDC_BUTTON_SELECTED_COUNT)->EnableWindow(FALSE);
	}
	n=pPage->GetCurCheckCount();
	str.Format("Number of accounts: %d",n);
	GetDlgItem(IDC_STATIC_CHECK_COUNT)->SetWindowText(str);
	if (n==0)
	{
		GetDlgItem(IDC_BUTTON_CHECK_COUNT)->EnableWindow(FALSE);
	}

	return CDialog::OnInitDialog();
}

void CDeleteConfirmDlg::OnBnClickedButton7()
{
	// TODO: Add your control notification handler code here
	EndDialog(eCancel);
}

void CDeleteConfirmDlg::OnBnClickedButtonTotalCount()
{
	// TODO: Add your control notification handler code here
	EndDialog(eDelete_All);
}

void CDeleteConfirmDlg::OnBnClickedButtonSelectedCount()
{
	// TODO: Add your control notification handler code here
	EndDialog(eDelete_Select);
}

void CDeleteConfirmDlg::OnBnClickedButtonCheckCount()
{
	// TODO: Add your control notification handler code here
	EndDialog(eDelete_Check);
}

void CDeleteConfirmDlg::OnBnClickedButtonNowCount()
{
	// TODO: Add your control notification handler code here
	EndDialog(eDelete_Current);
}
