#pragma once


// CDeleteConfirmDlg dialog

class CDeleteConfirmDlg : public CDialog
{
	DECLARE_DYNAMIC(CDeleteConfirmDlg)

public:
	enum eResult{eCancel,eDelete_All,eDelete_Current,eDelete_Select,eDelete_Check};

	CDeleteConfirmDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CDeleteConfirmDlg();

// Dialog Data
	enum { IDD = IDD_DIALOG_DELETE };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButton7();
	BOOL OnInitDialog();
	afx_msg void OnBnClickedButtonTotalCount();
	afx_msg void OnBnClickedButtonSelectedCount();
	afx_msg void OnBnClickedButtonCheckCount();
	afx_msg void OnBnClickedButtonNowCount();
};
