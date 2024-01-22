// ItemView.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "MainFrm.h"
#include "MainView.h"
#include "ItemView.h"
#include "GameThread.h"
#include "RoleObject.h"
#include "SelfObject.h"
#include "PlayerObject.h"
#include "NPCObject.h"
#include "MonsterObject.h"
#include ".\itemview.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CItemView

IMPLEMENT_DYNCREATE(CItemView, CFormView)

CItemView::CItemView()
	: CFormView(CItemView::IDD)
{
}

CItemView::~CItemView()
{
}

void CItemView::DoDataExchange(CDataExchange* pDX)
{
	CFormView::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_COMBO_SELECT_MAIN_PLAYER, m_ComboSelectMainRole);
}

BEGIN_MESSAGE_MAP(CItemView, CFormView)
	ON_CBN_SELCHANGE(IDC_COMBO_SELECT_MAIN_PLAYER, OnCbnSelchangeComboSelectPlayer)
	ON_MESSAGE(GAME_THREAD_RESET_ALL, OnResetAllPage)
	ON_MESSAGE(GAME_THREAD_FRESH_ALL, OnRefreshAllPage)
	ON_MESSAGE(GAME_THREAD_FRESH_MAP_POSITION, OnRefreshRolePageOfMapPosition)
	ON_MESSAGE(GAME_THREAD_FRESH_PAGE, OnRefreshPage)
	ON_MESSAGE(GAME_THREAD_FRESH_ROLE, OnRefreshRole)
	ON_MESSAGE(GAME_THREAD_FRESH_ROLE_POSITION, OnRefreshRolePosition)
	ON_MESSAGE(GAME_THREAD_FRESH_GROUND_ITEM, OnRefreshGroundItem)
END_MESSAGE_MAP()


// CItemView diagnostics

#ifdef _DEBUG
void CItemView::AssertValid() const
{
	CFormView::AssertValid();
}

void CItemView::Dump(CDumpContext& dc) const
{
	CFormView::Dump(dc);
}
#endif //_DEBUG


// CItemView message handlers

bool CItemView::InitView()
{
	m_SheetControl.AddPage(&m_LoginPage);
	m_SheetControl.AddPage(&m_RolePage);
	m_SheetControl.AddPage(&m_SurroundPage);
	m_SheetControl.AddPage(&m_NPCPage);
	m_SheetControl.AddPage(&m_ItemsPage);

	CRect rcSheet;
	GetDlgItem( IDC_STATIC_SHEET_RECT )->GetWindowRect( &rcSheet );
	ScreenToClient( &rcSheet );

	m_SheetControl.EnableStackedTabs(false);
	m_SheetControl.Create(this,WS_CHILD|WS_VISIBLE);
	m_SheetControl.SetWindowPos(NULL,rcSheet.left-5,rcSheet.top-5,0,0,SWP_NOZORDER|SWP_NOSIZE|SWP_NOACTIVATE);
	CTabCtrl* pTabCtrl=m_SheetControl.GetTabControl();
	pTabCtrl->MoveWindow(5,5,rcSheet.Width()+5,rcSheet.Height()+10);
	m_SheetControl.SetActivePage(4);
	m_SheetControl.SetActivePage(3);
	m_SheetControl.SetActivePage(2);
	m_SheetControl.SetActivePage(1);
	m_SheetControl.SetActivePage(0);

	m_nSelectedMainRole=CB_ERR;
	m_nSelectedMainRoleIndex=0;
	m_pLastSelPlayer=NULL;
	return true;
}

int CItemView::GetSelectMainRoleIndex()
{
	return m_nSelectedMainRoleIndex;
	//int nSel=m_ComboSelectMainRole.GetCurSel();
	//if (nSel==CB_ERR)
	//{
	//	return 0;
	//}
	//return (int)m_ComboSelectMainRole.GetItemData(nSel);
}

CComboBox* CItemView::GetComboSelectMainRole()
{
	return &m_ComboSelectMainRole;
}

void CItemView::OnCbnSelchangeComboSelectPlayer()
{
	// TODO: Add your control notification handler code here
	m_nSelectedMainRole=m_ComboSelectMainRole.GetCurSel();
	if (m_nSelectedMainRole!=CB_ERR)
	{
		//CPlayer *player=CPlayerMgr::GetMainPlayer();
		m_nSelectedMainRoleIndex=(int)m_ComboSelectMainRole.GetItemData(m_nSelectedMainRole);
		if (CPlayerMgr::SetMainPlayer(m_nSelectedMainRoleIndex))
		{
			//if (player==NULL || player!=CPlayerMgr::GetMainPlayer())
			CPlayer *pNowPlayer=CPlayerMgr::GetMainPlayer();
			if (m_pLastSelPlayer!=pNowPlayer)
			{
				((CMainFrame*)theApp.GetMainWnd())->GetMainView()->OnPlayerSwitch(m_pLastSelPlayer,pNowPlayer);
				if (pNowPlayer && pNowPlayer->GetPlayerGameThread())
				{
					while (!PostThreadMessage(pNowPlayer->GetPlayerGameThread()->GetThreadID(),MAIN_PLAYER_SELECT_CHANGE,0,NULL))
					{
						Sleep(50);
					}
				}
			}
			m_pLastSelPlayer=pNowPlayer;
		}
	}
	else
	{
		((CMainFrame*)theApp.GetMainWnd())->GetMainView()->OnPlayerSwitch(m_pLastSelPlayer,NULL);
		m_nSelectedMainRoleIndex=0;
		m_pLastSelPlayer=NULL;
	}
}




//------------------------------------------------------------------------
//	Game thread callback event
//------------------------------------------------------------------------
LRESULT CItemView::OnResetAllPage(WPARAM wParam,LPARAM lParam)
{
	m_RolePage.ResetPage();
	m_SurroundPage.ResetPage();
	m_NPCPage.ResetPage();
	m_ItemsPage.ResetPage();
	return 0;
}

LRESULT CItemView::OnRefreshAllPage(WPARAM wParam,LPARAM lParam)
{
	m_RolePage.RefreshPage();
	m_SurroundPage.RefreshPage();
	m_NPCPage.RefreshPage();
	m_ItemsPage.RefreshPage();
	return 0;
}

LRESULT CItemView::OnRefreshRolePageOfMapPosition(WPARAM wParam,LPARAM lParam)
{
	m_RolePage.RefreshMapPosition();
	m_SurroundPage.RefreshAllDistance();
	m_NPCPage.RefreshAllDistance();
	return 0;
}

LRESULT CItemView::OnRefreshPage(WPARAM wParam,LPARAM lParam)
{
	if (wParam==0)
	{
	}
	else if (wParam==1)
	{
		m_RolePage.ResetPage();
		m_RolePage.RefreshPage();
	}
	else if (wParam==2)
	{
		m_SurroundPage.ResetPage();
		m_SurroundPage.RefreshPage();
	}
	else if (wParam==3)
	{
		m_NPCPage.ResetPage();
		m_NPCPage.RefreshPage();
	}
	else if (wParam==4)
	{
		m_ItemsPage.ResetPage();
		m_ItemsPage.RefreshPage();
	}
	else
	{
	}
	return 0;
}

LRESULT CItemView::OnRefreshRole(WPARAM wParam,LPARAM lParam)
{
	CRoleObject *pRoleObject=reinterpret_cast<CRoleObject*>(lParam);
	CRoleObject::eObjectType objectType=pRoleObject->GetType();
	if (objectType==CRoleObject::eSelf)
	{
		if (wParam==0)
		{
			m_RolePage.ResetPage();
		}
		else
		{
			m_RolePage.RefreshPage();
		}
	}
	else if (objectType==CRoleObject::ePlayer)
	{
		if (wParam==0)
		{
			m_SurroundPage.RemovePlayerObject(reinterpret_cast<CPlayerObject*>(pRoleObject));
		}
		else
		{
			m_SurroundPage.AddPlayerObject(reinterpret_cast<CPlayerObject*>(pRoleObject));
		}
	}
	else if (objectType==CRoleObject::eMonster)
	{
		if (wParam==0)
		{
			m_SurroundPage.RemoveMonsterObject(reinterpret_cast<CMonsterObject*>(pRoleObject));
		}
		else
		{
			m_SurroundPage.AddMonsterObject(reinterpret_cast<CMonsterObject*>(pRoleObject));
		}
	}
	else if (objectType==CRoleObject::eNPC)
	{
		if (wParam==0)
		{
			m_NPCPage.RemoveNPCObject(reinterpret_cast<CNPCObject*>(pRoleObject));
		}
		else
		{
			m_NPCPage.AddNPCObject(reinterpret_cast<CNPCObject*>(pRoleObject));
		}
	}
	return 0;
}

LRESULT CItemView::OnRefreshRolePosition(WPARAM wParam,LPARAM lParam)
{
	CRoleObject *pRoleObject=reinterpret_cast<CRoleObject*>(lParam);
	CRoleObject::eObjectType objectType=pRoleObject->GetType();
	if (objectType==CRoleObject::ePlayer)
	{
		m_SurroundPage.RefreshPlayerPosition(reinterpret_cast<CPlayerObject*>(pRoleObject));
	}
	else if (objectType==CRoleObject::eMonster)
	{
		m_SurroundPage.RefreshMonsterPosition(reinterpret_cast<CMonsterObject*>(pRoleObject));
	}
	else if (objectType==CRoleObject::eNPC)
	{
		//Assuming NPCs don't move
	}
	return 0;
}

LRESULT CItemView::OnRefreshGroundItem(WPARAM wParam,LPARAM lParam)
{
	CGroundObject *pGroundItem=reinterpret_cast<CGroundObject*>(lParam);
	if (wParam==0)
	{
		m_SurroundPage.RemoveItemObject(pGroundItem);
	}
	else
	{
		m_SurroundPage.AddItemObject(pGroundItem);
	}
	return 0;
}