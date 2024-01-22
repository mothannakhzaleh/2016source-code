#pragma once

#include "TalkSessionBase.h"
#include "afxwin.h"
#include "afxcmn.h"
#include "ColorListBox.h"

// CPrivateTalkSessionPage dialog

class CPrivateTalkSessionPage : public CPropertyPage , public CTalkSessionBase
{
	DECLARE_DYNAMIC(CPrivateTalkSessionPage)
public:
	CPrivateTalkSessionPage();
	virtual ~CPrivateTalkSessionPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_PRIVATE_TALK_SESSION };

	void Renew();			//refresh all
	void Clear();			//clear the channel
	LPVOID GetThisPage();	//get instance address

	void RefreshSelfChannel();	//refresh your own channel later
	void RefreshTotalChannel();	//refresh all channels later

	afx_msg void OnLbnSelchangeListPlayer();
	afx_msg void OnBnClickedButtonClear();
	afx_msg void OnMenuPrivateClear();

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
	virtual BOOL OnInitDialog();
	virtual BOOL OnSetActive();
	bool RefreshList();
	//void OnAddRival(sRivalData* pRival);
	//void RefreshTotalCounts();

public:

	CListBox m_PlayerList;

private:
	CRichEditCtrl m_RichEditInformation;
	CMenu m_MainMenu;
	CMenu *m_pPlayerMenu;

public:
	virtual BOOL PreTranslateMessage(MSG* pMsg);
	CRichEditCtrl m_RichEditTotalInformation;
	afx_msg void OnDrawItem(int nIDCtl, LPDRAWITEMSTRUCT lpDrawItemStruct);
	afx_msg void OnTimer(UINT nIDEvent);
};
