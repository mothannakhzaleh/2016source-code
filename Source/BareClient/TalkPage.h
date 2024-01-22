#pragma once

#include "ChannelChatMgr.h"
//#include "TalkSessionPage.h"
#include "TalkSessionBase.h"
#include "afxwin.h"

class CPlayerMessage;
class CChannelControl;

// CTalkPage dialog

class CTalkPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CTalkPage)

public:
	CTalkPage();
	virtual ~CTalkPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_TALK };

	LRESULT OnRefreshChannel(WPARAM wParam,LPARAM lParam);
	void OnPlayerSwitch(CPlayer *pLastPlayer,CPlayer *pNowPlayer);


protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
	virtual BOOL OnInitDialog();

private:
	CChannelChatMgr::eChannel GetCurChannel();
	void RefreshCurChannel();										//刷新当前频道内容(往后刷新)
	void RefreshChannel(CChannelChatMgr::eChannel channel);			//刷新频道内容(往后刷新,只对当前显示频道有效)
	void RenewChannel(CChannelChatMgr::eChannel channel);			//重刷新频道内容(所有内容重新刷新,只对当前显示频道有效)
	void ClearChannel(CChannelChatMgr::eChannel channel);			//清楚频道内容(对任何频道均有效)


private:
	//CTalkSessionPage m_ChannelPage[CChannelChatMgr::CHANNEL_MAX_LIMIT];
	CTalkSessionBase *m_pChannelPage[CChannelChatMgr::CHANNEL_MAX_LIMIT];
	CChannelControl *m_pReleaseArray[20];

public:
	CPropertySheet m_SheetControl;
	CComboBox m_CombChannelSel;
	afx_msg void OnBnClickedButtonSend();
	CComboBox m_CombText;
	afx_msg void OnCbnSelchangeComboChannel();
	afx_msg void OnChar(UINT nChar,UINT nRepCnt,UINT nFlags); 
	BOOL PreTranslateMessage ( LPMSG  lpMsg );


	CComboBox m_CombTarget;
	CComboBox m_CombCommand;
	CButton m_BtnNameList;
	afx_msg void OnCbnSelchangeComboCommand();
	CButton m_BtnSend;
	afx_msg void OnCbnSelendokComboText();
	afx_msg void OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags);
	afx_msg void OnBnClickedButtonAutoPublishMgr();
};
