#pragma once

#include "LoginPage.h"
#include "RolePage.h"
#include "SurroundPage.h"
#include "NPCPage.h"
#include "ItemsPage.h"


// CItemView form view

class CItemView : public CFormView
{
	DECLARE_DYNCREATE(CItemView)

protected:
	CItemView();           // protected constructor used by dynamic creation
	virtual ~CItemView();

public:
	enum { IDD = IDD_VIEW_ITEM };
#ifdef _DEBUG
	virtual void AssertValid() const;
	virtual void Dump(CDumpContext& dc) const;
#endif

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()

public:
	bool InitView();
	int GetSelectMainRoleIndex();
	CComboBox* GetComboSelectMainRole();


public:
	afx_msg void OnCbnSelchangeComboSelectPlayer();

private:
	//------------------------------------------------------------------------
	//	Game thread callback event
	//------------------------------------------------------------------------
	LRESULT OnResetAllPage(WPARAM wParam,LPARAM lParam);
	LRESULT OnRefreshAllPage(WPARAM wParam,LPARAM lParam);
	LRESULT OnRefreshRolePageOfMapPosition(WPARAM wParam,LPARAM lParam);
	LRESULT OnRefreshPage(WPARAM wParam,LPARAM lParam);
	LRESULT OnRefreshRole(WPARAM wParam,LPARAM lParam);
	LRESULT OnRefreshRolePosition(WPARAM wParam,LPARAM lParam);
	LRESULT OnRefreshGroundItem(WPARAM wParam,LPARAM lParam);


public:
	CLoginPage m_LoginPage;
	CRolePage m_RolePage;
	CSurroundPage m_SurroundPage;
	CNPCPage m_NPCPage;
	CItemsPage m_ItemsPage;
	CPropertySheet m_SheetControl;

private:
	CComboBox m_ComboSelectMainRole;
	int m_nSelectedMainRole;
	int m_nSelectedMainRoleIndex;
	CPlayer *m_pLastSelPlayer;
};


