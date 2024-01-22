#pragma once
#include "afxwin.h"


// CLoginPage dialog

class CLoginPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CLoginPage)

public:
	CLoginPage();
	virtual ~CLoginPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_LOGIN };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()

public:
	// The generated message map function
	afx_msg void OnTimer(UINT nIDEvent);
	virtual BOOL OnInitDialog();
	DWORD GetCurSelectCount();
	DWORD GetCurCheckCount();
	bool GetIsReconnect();
	bool GetIsAutoCreateDel();

public:
	afx_msg void OnBnClickedButtonAdd();
	afx_msg void OnLvnItemchangedListAccount(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnBnClickedButtonDelete();
	afx_msg void OnBnClickedButtonSave();
	afx_msg void OnBnClickedButtonLoad();
	afx_msg void OnBnClickedButtonLogin();
	afx_msg LRESULT OnThreadRefreshState( WPARAM wParam, LPARAM lParam);

public:
	CListCtrl m_LoginList;
	CEdit m_EditAccountName;
	CEdit m_EditPassword;
	CButton m_BtnDelete;
	CComboBox m_ComboService;
	CComboBox m_ComboRoleSelect;
	CComboBox* m_pComboSelectMainRole;
	bool m_bUsedIndexFlag[ACCOUNT_MAXNUM+1];
	int nMaxPlayerCount;
	int nMinPlayerCount;

private:
	int AllocateIndex();
	void ReleaseIndex(int index);
public:
	afx_msg void OnBnClickedButton6();
	CButton m_btnNoReconnect;
	CButton m_btnAutoCreateDel;
	afx_msg void OnBnClickedButtonLoadMoveTable();
};
