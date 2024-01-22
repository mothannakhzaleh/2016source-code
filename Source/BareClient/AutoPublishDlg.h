#pragma once

#include "resource.h"
#include "afxwin.h"


// CAutoPublishDlg dialog

class CAutoPublishDlg : public CDialog
{
	DECLARE_DYNAMIC(CAutoPublishDlg)

public:
	CAutoPublishDlg(CWnd* pParent = NULL);   // standard constructor
	virtual ~CAutoPublishDlg();

// Dialog Data
	enum { IDD = IDD_DIALOG_AUTO_PUBLISH_MGR };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	virtual BOOL OnInitDialog();

	void OnRefresh();

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnBnClickedButtonAdd();
	afx_msg void OnBnClickedButtonDel();
	CListCtrl m_lstAutoPublishInfo;
	CComboBox m_cbxChannel;
	CComboBox m_cbxPlayerName;
	CComboBox m_cbxIntervalTime;
	CComboBox m_cbxRepeatTimes;
	CDateTimeCtrl m_dtcTime;
	afx_msg void OnBnClickedButtonGetNowTime();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnEnChangeEdit1();
	CString m_Text;
	afx_msg void OnNMClickListInfo(NMHDR *pNMHDR, LRESULT *pResult);
};
