// SurroundPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "RoleMgr.h"
#include "PlayerObject.h"
#include "SelfObject.h"
#include "MonsterObject.h"
#include "GroundObject.h"
#include "MonsterType.h"
#include "PlayerMgr.h"
#include "SurroundPage.h"
#include ".\surroundpage.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CSurroundPage dialog

IMPLEMENT_DYNAMIC(CSurroundPage, CPropertyPage)
CSurroundPage::CSurroundPage()
	: CPropertyPage(CSurroundPage::IDD)
{
}

CSurroundPage::~CSurroundPage()
{
	m_pItemsMenu->Detach();
	delete m_pItemsMenu;
}

void CSurroundPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST_PLAYERS, m_PlayersList);
	DDX_Control(pDX, IDC_LIST_MONSTER, m_MonstersList);
	DDX_Control(pDX, IDC_LIST_ITEMS, m_ItemsList);
}


BEGIN_MESSAGE_MAP(CSurroundPage, CPropertyPage)
	ON_NOTIFY(NM_RCLICK, IDC_LIST_ITEMS, OnNMRclickListItems)
	ON_COMMAND(ID_M_PICKUP, OnPickup)
END_MESSAGE_MAP()


// CSurroundPage message handlers

BOOL CSurroundPage::OnInitDialog()
{
	UpdateData(FALSE);
	BOOL ret=m_MainMenu.LoadMenu(IDR_MENU_PACKAGE);
	ASSERT(ret);
	m_pItemsMenu=new CMenu;
	m_pItemsMenu->Attach(m_MainMenu.GetSubMenu(2)->GetSafeHmenu());
	m_PlayersList.InsertColumn(0,"ID",LVCFMT_LEFT,35);
	m_PlayersList.InsertColumn(1,"玩家",LVCFMT_LEFT,105);
	m_PlayersList.InsertColumn(2,"距离",LVCFMT_RIGHT,40);
	m_PlayersList.InsertColumn(3,"坐标",LVCFMT_LEFT,120);
	m_PlayersList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	m_MonstersList.InsertColumn(0,"怪物",LVCFMT_LEFT,100);
	m_MonstersList.InsertColumn(1,"距离",LVCFMT_RIGHT,40);
	m_MonstersList.InsertColumn(2,"坐标",LVCFMT_LEFT,120);
	m_MonstersList.InsertColumn(3,"CharID",LVCFMT_LEFT,50);
	m_MonstersList.InsertColumn(4,"WorldID",LVCFMT_LEFT,80);
	m_MonstersList.InsertColumn(5,"CommID",LVCFMT_LEFT,80);
	m_MonstersList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	m_ItemsList.InsertColumn(0,"道具",LVCFMT_LEFT,100);
	m_ItemsList.InsertColumn(1,"个数",LVCFMT_LEFT,40);
	m_ItemsList.InsertColumn(2,"来源",LVCFMT_LEFT,60);
	m_ItemsList.InsertColumn(3,"距离",LVCFMT_RIGHT,40);
	m_ItemsList.InsertColumn(4,"坐标",LVCFMT_LEFT,120);
	m_ItemsList.InsertColumn(5,"ItemID",LVCFMT_LEFT,50);
	m_ItemsList.InsertColumn(6,"WorldID",LVCFMT_LEFT,80);
	m_ItemsList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	return TRUE;
}

void CSurroundPage::ResetPage()
{
	m_PlayersList.DeleteAllItems();
	m_MonstersList.DeleteAllItems();
	m_ItemsList.DeleteAllItems();
}

void CSurroundPage::RefreshPage()
{
	CRoleMgr* pRoleMgr=&CPlayerMgr::GetMainPlayer()->GetRoleMgr();
	CSelfObject* pSelf=pRoleMgr->GetSelfObject();
	CList<CPlayerObject*,CPlayerObject*>* pPlayerList=pRoleMgr->GetPlayerList();
	CMap<DWORD,DWORD,CMonsterType*,CMonsterType*>* pMonsterMap=pRoleMgr->GetMonsterMap();
	CMap<DWORD,DWORD,CGroundObject*,CGroundObject*>* pGroundItemMap=pSelf->GetGroundItemMap();
	CString str;
	int i;
	POSITION pos=pPlayerList->GetHeadPosition();
	for (i=0;i<pPlayerList->GetCount();i++)
	{
		CPlayerObject* pPlayerObject=pPlayerList->GetNext(pos);
		str.Format("%u",pPlayerObject->GetWorldID());
		m_PlayersList.InsertItem(i,str);
		m_PlayersList.SetItemData(i,(DWORD_PTR)pPlayerObject);
		m_PlayersList.SetItem(i,1,LVIF_TEXT,pPlayerObject->GetName(),0,0,0,NULL);
		if (pSelf)
		{
			str.Format("%.1f",pPlayerObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
			m_PlayersList.SetItem(i,2,LVIF_TEXT,str,0,0,0,NULL);
		}
		str.Format("%.2f , %.2f",pPlayerObject->GetPositionFloatX(),pPlayerObject->GetPositionFloatY());
		m_PlayersList.SetItem(i,3,LVIF_TEXT,str,0,0,0,NULL);
	}
	
	DWORD charID;
	CMonsterType* pMonsterType;
	pos=pMonsterMap->GetStartPosition();
	for (i=0;i<pMonsterMap->GetCount();i++)
	{
		pMonsterMap->GetNextAssoc(pos,charID,pMonsterType);
		CList<CMonsterObject*,CMonsterObject*>* pMonsterList=pMonsterType->GetMonsterRolesList();
		POSITION monsterPos=pMonsterList->GetHeadPosition();
		for (int j=0;j<pMonsterList->GetCount();j++)
		{
			CMonsterObject* pMonsterObject=pMonsterList->GetNext(monsterPos);
			str.Format("%s<%d>",pMonsterObject->GetName(),pMonsterObject->GetMonsterIndex());
			m_MonstersList.InsertItem(j,str);
			m_MonstersList.SetItemData(j,(DWORD_PTR)pMonsterObject);
			if (pSelf)
			{
				str.Format("%.1f",pMonsterObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
				m_MonstersList.SetItem(j,1,LVIF_TEXT,str,0,0,0,NULL);
			}
			str.Format("%.2f , %.2f",pMonsterObject->GetPositionFloatX(),pMonsterObject->GetPositionFloatY());
			m_MonstersList.SetItem(j,2,LVIF_TEXT,str,0,0,0,NULL);
			str.Format("%u",pMonsterObject->GetCharID());
			m_MonstersList.SetItem(j,3,LVIF_TEXT,str,0,0,0,NULL);
			str.Format("%u",pMonsterObject->GetWorldID());
			m_MonstersList.SetItem(j,4,LVIF_TEXT,str,0,0,0,NULL);
			str.Format("%u",pMonsterObject->GetCommID());
			m_MonstersList.SetItem(j,5,LVIF_TEXT,str,0,0,0,NULL);
		}
	}

	DWORD itemID;
	CGroundObject* pGroundItem;
	pos=pGroundItemMap->GetStartPosition();
	for (i=0;i<pGroundItemMap->GetCount();i++)
	{
		pGroundItemMap->GetNextAssoc(pos,itemID,pGroundItem);
		m_ItemsList.InsertItem(i,pGroundItem->GetName());
		m_ItemsList.SetItemData(i,(DWORD_PTR)pGroundItem);
		str.Format("%d",pGroundItem->GetTotalNum());
		m_ItemsList.SetItemText(i,1,str);
		m_ItemsList.SetItemText(i,2,pGroundItem->GetAppearCauseString());
		if (pSelf)
		{
			str.Format("%.1f",pGroundItem->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
			m_ItemsList.SetItemText(i,3,str);
		}
		str.Format("%.2f , %.2f",pGroundItem->GetPositionFloatX(),pGroundItem->GetPositionFloatY());
		m_ItemsList.SetItemText(i,4,str);
		str.Format("%u",pGroundItem->GetItemID());
		m_ItemsList.SetItemText(i,5,str);
		str.Format("%u",pGroundItem->GetWorldID());
		m_ItemsList.SetItemText(i,6,str);
	}
}

void CSurroundPage::RefreshPlayerPosition(CPlayerObject *pPlayerObject)
{
	CString str;
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	for (int i=0;i<m_PlayersList.GetItemCount();i++)
	{
		if (m_PlayersList.GetItemData(i)==(DWORD_PTR)pPlayerObject)
		{
			if (pSelf)
			{
				str.Format("%.1f",pPlayerObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
				m_PlayersList.SetItemText(i,2,str);
			}
			str.Format("%.2f , %.2f",pPlayerObject->GetPositionFloatX(),pPlayerObject->GetPositionFloatY());
			m_PlayersList.SetItemText(i,3,str);
			return;
		}
	}
}

void CSurroundPage::RefreshMonsterPosition(CMonsterObject *pMonsterObject)
{
	CString str;
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	for (int i=0;i<m_MonstersList.GetItemCount();i++)
	{
		if (m_MonstersList.GetItemData(i)==(DWORD_PTR)pMonsterObject)
		{
			if (pSelf)
			{
				str.Format("%.1f",pMonsterObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
				m_MonstersList.SetItemText(i,1,str);
			}
			str.Format("%.2f , %.2f",pMonsterObject->GetPositionFloatX(),pMonsterObject->GetPositionFloatY());
			m_MonstersList.SetItemText(i,2,str);
			return;
		}
	}
}

void CSurroundPage::RefreshAllDistance()
{
	int i;
	CString str;
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	for (i=0;i<m_PlayersList.GetItemCount();i++)
	{
		CPlayerObject* pPlayerObject=reinterpret_cast<CPlayerObject*>(m_PlayersList.GetItemData(i));
		str.Format("%.1f",pPlayerObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_PlayersList.SetItemText(i,2,str);
	}
	for (i=0;i<m_MonstersList.GetItemCount();i++)
	{
		CMonsterObject* pMonsterObject=reinterpret_cast<CMonsterObject*>(m_MonstersList.GetItemData(i));
		str.Format("%.1f",pMonsterObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_MonstersList.SetItemText(i,1,str);
	}
	for (i=0;i<m_ItemsList.GetItemCount();i++)
	{
		CGroundObject* pGroundItem=reinterpret_cast<CGroundObject*>(m_ItemsList.GetItemData(i));
		str.Format("%.1f",pGroundItem->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_ItemsList.SetItemText(i,2,str);
	}
}

void CSurroundPage::AddPlayerObject(CPlayerObject *pPlayerObject)
{
	int n=m_PlayersList.GetItemCount();
	if (n==CB_ERR)
	{
		return;
	}
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	CString str;
	str.Format("%d",pPlayerObject->GetWorldID());
	m_PlayersList.InsertItem(n,str);
	m_PlayersList.SetItemData(n,(DWORD_PTR)pPlayerObject);
	m_PlayersList.SetItem(n,1,LVIF_TEXT,pPlayerObject->GetName(),0,0,0,NULL);
	if (pSelf)
	{
		str.Format("%.1f",pPlayerObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_PlayersList.SetItem(n,2,LVIF_TEXT,str,0,0,0,NULL);
	}
	str.Format("%.2f , %.2f",pPlayerObject->GetPositionFloatX(),pPlayerObject->GetPositionFloatY());
	m_PlayersList.SetItem(n,3,LVIF_TEXT,str,0,0,0,NULL);
}

void CSurroundPage::RemovePlayerObject(CPlayerObject *pPlayerObject)
{
	for (int i=0;i<m_PlayersList.GetItemCount();i++)
	{
		if (m_PlayersList.GetItemData(i)==(DWORD_PTR)pPlayerObject)
		{
			m_PlayersList.DeleteItem(i);
			return;
		}
	}
}

void CSurroundPage::AddMonsterObject(CMonsterObject *pMonsterObject)
{
	int n=m_MonstersList.GetItemCount();
	if (n==CB_ERR)
	{
		return;
	}
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	CString str;
	str.Format("%s<%d>",pMonsterObject->GetName(),pMonsterObject->GetMonsterIndex());
	m_MonstersList.InsertItem(n,str);
	m_MonstersList.SetItemData(n,(DWORD_PTR)pMonsterObject);
	if (pSelf)
	{
		str.Format("%.1f",pMonsterObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_MonstersList.SetItem(n,1,LVIF_TEXT,str,0,0,0,NULL);
	}
	str.Format("%.2f , %.2f",pMonsterObject->GetPositionFloatX(),pMonsterObject->GetPositionFloatY());
	m_MonstersList.SetItem(n,2,LVIF_TEXT,str,0,0,0,NULL);
	str.Format("%u",pMonsterObject->GetCharID());
	m_MonstersList.SetItem(n,3,LVIF_TEXT,str,0,0,0,NULL);
	str.Format("%u",pMonsterObject->GetWorldID());
	m_MonstersList.SetItem(n,4,LVIF_TEXT,str,0,0,0,NULL);
	str.Format("%u",pMonsterObject->GetCommID());
	m_MonstersList.SetItem(n,5,LVIF_TEXT,str,0,0,0,NULL);
}

void CSurroundPage::RemoveMonsterObject(CMonsterObject *pMonsterObject)
{
	for (int i=0;i<m_MonstersList.GetItemCount();i++)
	{
		if (m_MonstersList.GetItemData(i)==(DWORD_PTR)pMonsterObject)
		{
			m_MonstersList.DeleteItem(i);
			return;
		}
	}
}

void CSurroundPage::AddItemObject(CGroundObject *pGroundItem)
{
	int n=m_ItemsList.GetItemCount();
	if (n==CB_ERR)
	{
		return;
	}
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	CString str;
	m_ItemsList.InsertItem(n,pGroundItem->GetName());
	m_ItemsList.SetItemData(n,(DWORD_PTR)pGroundItem);
	str.Format("%d",pGroundItem->GetTotalNum());
	m_ItemsList.SetItemText(n,1,str);
	m_ItemsList.SetItemText(n,2,pGroundItem->GetAppearCauseString());
	if (pSelf)
	{
		str.Format("%.1f",pGroundItem->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_ItemsList.SetItemText(n,3,str);
	}
	str.Format("%.2f , %.2f",pGroundItem->GetPositionFloatX(),pGroundItem->GetPositionFloatY());
	m_ItemsList.SetItemText(n,4,str);
	str.Format("%u",pGroundItem->GetItemID());
	m_ItemsList.SetItemText(n,5,str);
	str.Format("%u",pGroundItem->GetWorldID());
	m_ItemsList.SetItemText(n,6,str);
}

void CSurroundPage::RemoveItemObject(CGroundObject *pGroundItem)
{
	for (int i=0;i<m_ItemsList.GetItemCount();i++)
	{
		if (m_ItemsList.GetItemData(i)==(DWORD_PTR)pGroundItem)
		{
			m_ItemsList.DeleteItem(i);
			return;
		}
	}
}
void CSurroundPage::OnNMRclickListItems(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO: Add your control notification handler code here
	NMITEMACTIVATE *pItem=(NMITEMACTIVATE*)pNMHDR;
	int nItem=pItem->iItem;
	if (nItem==CB_ERR)
	{
		return;
	}
	CPoint point=pItem->ptAction;
	CGroundObject* pGroundItem=reinterpret_cast<CGroundObject*>(m_ItemsList.GetItemData(nItem));
	if (!pGroundItem)
	{
		return;
	}
	m_ItemsList.ClientToScreen(&point);
	MENUINFO menuInfo;
	menuInfo.cbSize=sizeof(menuInfo);
	menuInfo.fMask=MIM_MENUDATA;
	menuInfo.dwMenuData=(ULONG_PTR)pGroundItem;
	m_pItemsMenu->SetMenuInfo(&menuInfo);
	m_pItemsMenu->TrackPopupMenuEx(TPM_LEFTALIGN|TPM_TOPALIGN,point.x,point.y,this,NULL);
	*pResult = 0;
}

void CSurroundPage::OnPickup()
{
	// TODO: Add your command handler code here
}
