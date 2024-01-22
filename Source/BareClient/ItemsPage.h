#pragma once
#include "afxcmn.h"


// CItemsPage dialog

class CItemsPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CItemsPage)

public:
	CItemsPage();
	virtual ~CItemsPage();


	void ResetPage();
	void RefreshPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_ITEMS };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()


	virtual BOOL OnInitDialog();


public:
	CListCtrl m_EquipList;
	CListCtrl m_ItemsList;
	CMenu m_MainMenu;
	CMenu* m_pItemMenu;
	CMenu* m_pEquipMenu;
	afx_msg void OnNMRclickListItems(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnDropItem();
	afx_msg void OnEquip();
	afx_msg void OnUse();
	afx_msg void OnUnEquip();
	afx_msg void OnNMRclickListEquip(NMHDR *pNMHDR, LRESULT *pResult);
};
