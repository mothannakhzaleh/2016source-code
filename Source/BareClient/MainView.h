#pragma once
#include "afxcmn.h"
#include "afxwin.h"

#include "SystemPage.h"
#include "TalkPage.h"
#include "MapPage.h"
#include "ScriptPage.h"
#include "SetupPage.h"

// CMainView form view

class CMainView : public CFormView
{
	DECLARE_DYNCREATE(CMainView)

protected:
	CMainView();           // protected constructor used by dynamic creation
	virtual ~CMainView();

public:
	enum { IDD = IDD_MAINVIEW };
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()

public:
	bool InitView();
	void OnPlayerSwitch(CPlayer *pLastPlayer,CPlayer *pNowPlayer);		//To switch players, there may be a parameter that is NULL



	void OnAllPlayerDeleted();
	void OnRefreshEdit();
	void OnRefreshEditOnce();
	afx_msg void OnBnClickedButtonClear();
	afx_msg void OnBnClickedRadio1();
	afx_msg void OnBnClickedRadio2();
	afx_msg void OnBnClickedRadio3();
	afx_msg void OnBnClickedRadio4();
	afx_msg void OnTimer(UINT nIDEvent);
	afx_msg void OnTcnSelchangeTab1(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg LRESULT OnThreadRefreshInfo( WPARAM wParam, LPARAM lParam);

public:
	enum eTabSelect{CURRENT_PLAYER=0,SELECTED_PLAYER=1,CHECKED_PLAYER=2,ALL_PLAYER=3};
	CButton m_ButtonLock;
	CComboBox m_ComboMode;
	CTabCtrl m_TabSystemInfo;
	CRichEditCtrl m_RichEditInformation;

private:
	eTabSelect m_eTabSelect;


public:
	afx_msg void OnBnClickedCheckSetTheSame();
	CButton m_btnSettheSame;
	afx_msg void OnBnClickedCheckLock();
	afx_msg void OnBnClickedRadio5();
	afx_msg void OnBnClickedRadio6();







//new version
public:
	CSystemPage& GetSystemPage();
	CTalkPage& GetTalkPage();
	CMapPage& GetMapPage();
	CScriptPage& GetScriptPage();
	CSetupPage& GetSetupPage();

private:
	CPropertySheet m_SheetControl;
	CSystemPage m_SystemPage;
	CTalkPage m_TalkPage;
	CMapPage m_MapPage;
	CScriptPage m_ScriptPage;
	CSetupPage m_SetupPage;

};


