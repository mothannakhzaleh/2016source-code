#pragma once
#include "afxcmn.h"


class CGroundObject;

// CSurroundPage dialog

class CSurroundPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CSurroundPage)

public:
	CSurroundPage();
	virtual ~CSurroundPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_SURROUND };


public:
	void ResetPage();
	void RefreshPage();
	void RefreshPlayerPosition(CPlayerObject *pPlayerObject);
	void RefreshMonsterPosition(CMonsterObject *pMonsterObject);
	void RefreshAllDistance();

	void AddPlayerObject(CPlayerObject *pPlayerObject);
	void RemovePlayerObject(CPlayerObject *pPlayerObject);
	void AddMonsterObject(CMonsterObject *pMonsterObject);
	void RemoveMonsterObject(CMonsterObject *pMonsterObject);
	void AddItemObject(CGroundObject *pGroundItem);
	void RemoveItemObject(CGroundObject *pGroundItem);


protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
	virtual BOOL OnInitDialog();

private:
	CListCtrl m_PlayersList;
	CListCtrl m_MonstersList;
	CListCtrl m_ItemsList;
	CMenu m_MainMenu;
	CMenu *m_pItemsMenu;
public:
	afx_msg void OnNMRclickListItems(NMHDR *pNMHDR, LRESULT *pResult);
	afx_msg void OnPickup();
};
