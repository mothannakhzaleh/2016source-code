#pragma once
#include "afxcmn.h"
#include "afxwin.h"


// CSystemPage dialog

class CSystemPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CSystemPage)

public:
	CSystemPage();
	virtual ~CSystemPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_SYSTEM };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
	virtual BOOL OnInitDialog();

public:
	void OnPlayerSwitch(CPlayer *pLastPlayer,CPlayer *pNowPlayer);		//切换玩家,可能会有一个参数为NULL

private:
	LRESULT OnRefreshMessage(WPARAM wParam,LPARAM lParam);
	void RefreshMessage();
	void RefreshAllMessages();

private:
	DWORD m_dwLastRefreshTick;

public:
	afx_msg void OnTimer(UINT nIDEvent);
	CRichEditCtrl m_RichEditInformation;
	afx_msg void OnBnClickedButtonClear();
	afx_msg void OnBnClickedButtonCopy();
	CButton m_ScrollLock;
	afx_msg void OnBnClickedCheckSystemFilter();
	afx_msg void OnBnClickedCheckDebugFilter();
	CButton m_SystemFilterCheck;
	CButton m_DebugFilterCheck;
};
