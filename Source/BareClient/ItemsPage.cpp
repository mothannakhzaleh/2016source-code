// ItemsPage.cpp : implementation file
//

#include "stdafx.h"
#include "Winuser.h"
#include "windows.h"
#include "BKop.h"
#include "CommonHeader.h"
#include "PlayerMgr.h"
#include "RoleMgr.h"
#include "SelfObject.h"
#include "PacketObject.h"
#include "EquipObject.h"
#include "ItemsPage.h"
#include "ItemDataMgr.h"
#include "CommandDropItem.h"
#include "CommandUseItem.h"
#include "CommandUnEquip.h"
#include ".\itemspage.h"


#define nItemIndexToEquipIndexMax 10
const static int nItemIndexToEquipIndex[nItemIndexToEquipIndexMax]=
{
	enumEQUIP_HEAD,
	enumEQUIP_BODY,
	enumEQUIP_GLOVE,
	enumEQUIP_SHOES,
	enumEQUIP_NECK,
	enumEQUIP_RHAND,
	enumEQUIP_LHAND,
	enumEQUIP_HAND1,
	enumEQUIP_HAND2
};


#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CItemsPage dialog

IMPLEMENT_DYNAMIC(CItemsPage, CPropertyPage)
CItemsPage::CItemsPage()
	: CPropertyPage(CItemsPage::IDD)
{
	EnableActiveAccessibility();
}

CItemsPage::~CItemsPage()
{
	m_pItemMenu->Detach();
	delete m_pItemMenu;
	m_pEquipMenu->Detach();
	delete m_pEquipMenu;
}

void CItemsPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST_EQUIP, m_EquipList);
	DDX_Control(pDX, IDC_LIST_ITEMS, m_ItemsList);
}


BEGIN_MESSAGE_MAP(CItemsPage, CPropertyPage)
	ON_NOTIFY(NM_RCLICK, IDC_LIST_ITEMS, OnNMRclickListItems)
	ON_COMMAND(ID_M_DROP, OnDropItem)
	ON_COMMAND(ID_M_EQUIP, OnEquip)
	ON_COMMAND(ID_M_USE, OnUse)
	ON_COMMAND(ID_M_UNEQUIP, OnUnEquip)
	ON_NOTIFY(NM_RCLICK, IDC_LIST_EQUIP, OnNMRclickListEquip)
END_MESSAGE_MAP()


// CItemsPage message handlers

BOOL CItemsPage::OnInitDialog()
{
	UpdateData(FALSE);
	BOOL ret=m_MainMenu.LoadMenu(IDR_MENU_PACKAGE);
	ASSERT(ret);
	m_pItemMenu=new CMenu;
	m_pItemMenu->Attach(m_MainMenu.GetSubMenu(0)->GetSafeHmenu());
	m_pEquipMenu=new CMenu;
	m_pEquipMenu->Attach(m_MainMenu.GetSubMenu(1)->GetSafeHmenu());
	m_EquipList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	m_EquipList.InsertColumn(0,"Location",LVCFMT_LEFT,60);
	m_EquipList.InsertColumn(1,"equipment",LVCFMT_LEFT,100);
	m_EquipList.InsertColumn(2,"ItemID",LVCFMT_LEFT,60);
	m_ItemsList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	m_ItemsList.InsertColumn(0,"P",LVCFMT_LEFT,20);
	m_ItemsList.InsertColumn(1,"props",LVCFMT_LEFT,90);
	m_ItemsList.InsertColumn(2,"Number",LVCFMT_LEFT,40);
	m_ItemsList.InsertColumn(3,"type",LVCFMT_LEFT,70);
	m_ItemsList.InsertColumn(4,"ItemID",LVCFMT_LEFT,60);
	return TRUE;
}

void CItemsPage::ResetPage()
{
	m_EquipList.DeleteAllItems();
	m_ItemsList.DeleteAllItems();
	m_EquipList.InsertItem(0,"helmet");
	m_EquipList.InsertItem(1,"armor");
	m_EquipList.InsertItem(2,"Gloves");
	m_EquipList.InsertItem(3,"shoe");
	m_EquipList.InsertItem(4,"necklace");
	m_EquipList.InsertItem(5,"right hand(sword)");
	m_EquipList.InsertItem(6,"left hand(shield)");
	m_EquipList.InsertItem(7,"Accessories(left)");
	m_EquipList.InsertItem(8,"Accessories(right)");
	CString str;
	for (int i=0;i<defMAX_KBITEM_NUM_PER_TYPE;i++)
	{
		str.Format("%d",i);
		m_ItemsList.InsertItem(i,str);
		m_ItemsList.SetItemData(i,NULL);
	}
}

void CItemsPage::RefreshPage()
{
	CRoleMgr* pRoleMgr=&CPlayerMgr::GetMainPlayer()->GetRoleMgr();
	CSelfObject* pSelf=pRoleMgr->GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	CString str;
	CEquipObject* pEquipItem=NULL;
	pEquipItem=pSelf->GetHeadEquip();	// 0 helmet
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(0,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(0,2,str);
	}
	pEquipItem=pSelf->GetBodyEquip();	// 1 armor
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(1,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(1,2,str);
	}
	pEquipItem=pSelf->GetGloveEquip();	// 2 Gloves
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(2,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(2,2,str);
	}
	pEquipItem=pSelf->GetShoesEquip();	// 3 shoe
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(3,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(3,2,str);
	}
	pEquipItem=pSelf->GetNeckEquip();	// 4 necklace
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(4,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(4,2,str);
	}
	pEquipItem=pSelf->GetSwordEquip();	// 5 right hand (sword)
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(5,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(5,2,str);
	}
	pEquipItem=pSelf->GetShieldEquip();	// 6 left hand (shield)
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(6,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(6,2,str);
	}
	pEquipItem=pSelf->GetLAccessoryEquip();	// 7 accessories (left)
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(7,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(7,2,str);
	}
	pEquipItem=pSelf->GetRAccessoryEquip();	// 8 Accessories (right)
	if (pEquipItem && pEquipItem->GetItemID()>0 && pEquipItem->GetTotalNum()>0)
	{
		m_EquipList.SetItemText(8,1,pEquipItem->GetName());
		str.Format("%d",pEquipItem->GetItemID());
		m_EquipList.SetItemText(8,2,str);
	}
	for (int i=0;i<defMAX_KBITEM_NUM_PER_TYPE;i++)
	{
		CPacketObject* pPacketItem=pSelf->FindPacketItem(i);
		if (!pPacketItem)
		{
			continue;
		}
		m_ItemsList.SetItemData(i,(DWORD_PTR)pPacketItem);
		m_ItemsList.SetItemText(i,1,pPacketItem->GetName());
		str.Format("%d",pPacketItem->GetTotalNum());
		m_ItemsList.SetItemText(i,2,str);
		m_ItemsList.SetItemText(i,3,pPacketItem->GetTypeName());
		str.Format("%u",pPacketItem->GetItemID());
		m_ItemsList.SetItemText(i,4,str);
	}
}

void CItemsPage::OnNMRclickListEquip(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO: Add your control notification handler code here
	NMITEMACTIVATE *pItem=(NMITEMACTIVATE*)pNMHDR;
	int nItem=pItem->iItem;
	if (nItem==CB_ERR)
	{
		return;
	}
	if (nItem<0|| nItem>=nItemIndexToEquipIndexMax)
	{
		return;
	}
	CRoleMgr* pRoleMgr=&CPlayerMgr::GetMainPlayer()->GetRoleMgr();
	CSelfObject* pSelf=pRoleMgr->GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	if (!pSelf->GetEquip(nItemIndexToEquipIndex[nItem]))
	{
		return;
	}
	CPoint point=pItem->ptAction;
	m_EquipList.ClientToScreen(&point);
	MENUINFO menuInfo;
	menuInfo.cbSize=sizeof(menuInfo);
	menuInfo.fMask=MIM_MENUDATA;
	menuInfo.dwMenuData=(ULONG_PTR)nItemIndexToEquipIndex[nItem];
	m_pEquipMenu->SetMenuInfo(&menuInfo);
	m_pEquipMenu->TrackPopupMenuEx(TPM_LEFTALIGN|TPM_TOPALIGN,point.x,point.y,this,NULL);
	*pResult = 0;
}

void CItemsPage::OnNMRclickListItems(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO: Add your control notification handler code here
	NMITEMACTIVATE *pItem=(NMITEMACTIVATE*)pNMHDR;
	int nItem=pItem->iItem;
	if (nItem==CB_ERR)
	{
		return;
	}
	CPoint point=pItem->ptAction;
	CPacketObject* pPacketItem=reinterpret_cast<CPacketObject*>(m_ItemsList.GetItemData(nItem));
	if (!pPacketItem)
	{
		return;
	}
	m_ItemsList.ClientToScreen(&point);
	MENUINFO menuInfo;
	menuInfo.cbSize=sizeof(menuInfo);
	menuInfo.fMask=MIM_MENUDATA;
	menuInfo.dwMenuData=(ULONG_PTR)pPacketItem;
	m_pItemMenu->SetMenuInfo(&menuInfo);
	if (CItemDataMgr::CanBeEquip(pPacketItem->GetItemID()))
	{
		m_pItemMenu->EnableMenuItem(ID_M_EQUIP,MF_ENABLED);
		m_pItemMenu->EnableMenuItem(ID_M_USE,MF_GRAYED);
	}
	else if (CItemDataMgr::CanBeUse(pPacketItem->GetItemID()))
	{
		m_pItemMenu->EnableMenuItem(ID_M_EQUIP,MF_GRAYED);
		m_pItemMenu->EnableMenuItem(ID_M_USE,MF_ENABLED);
	}
	else
	{
		m_pItemMenu->EnableMenuItem(ID_M_EQUIP,MF_GRAYED);
		m_pItemMenu->EnableMenuItem(ID_M_USE,MF_GRAYED);
	}
	m_pItemMenu->TrackPopupMenuEx(TPM_LEFTALIGN|TPM_TOPALIGN,point.x,point.y,this,NULL);
	*pResult = 0;
}

void CItemsPage::OnDropItem()
{
	// TODO: Add your command handler code here
	MENUINFO MenuInfo;
	MenuInfo.cbSize=sizeof(MenuInfo);
	MenuInfo.dwMenuData=0;
	MenuInfo.fMask=MIM_MENUDATA;
	m_pItemMenu->GetMenuInfo(&MenuInfo);
	CPacketObject* pPacketItem=reinterpret_cast<CPacketObject*>(MenuInfo.dwMenuData);
	if (pPacketItem==NULL)
	{
		return;
	}
	CCommandDropItem::Create(CPlayerMgr::GetMainPlayer(),pPacketItem->GetIndex(),pPacketItem->GetTotalNum());
}

void CItemsPage::OnEquip()
{
	// TODO: Add your command handler code here
	MENUINFO MenuInfo;
	MenuInfo.cbSize=sizeof(MenuInfo);
	MenuInfo.dwMenuData=0;
	MenuInfo.fMask=MIM_MENUDATA;
	m_pItemMenu->GetMenuInfo(&MenuInfo);
	CPacketObject* pPacketItem=reinterpret_cast<CPacketObject*>(MenuInfo.dwMenuData);
	if (pPacketItem==NULL)
	{
		return;
	}
	CCommandUseItem::Create(CPlayerMgr::GetMainPlayer(),pPacketItem->GetIndex());
}

void CItemsPage::OnUse()
{
	// TODO: Add your command handler code here
	MENUINFO MenuInfo;
	MenuInfo.cbSize=sizeof(MenuInfo);
	MenuInfo.dwMenuData=0;
	MenuInfo.fMask=MIM_MENUDATA;
	m_pItemMenu->GetMenuInfo(&MenuInfo);
	CPacketObject* pPacketItem=reinterpret_cast<CPacketObject*>(MenuInfo.dwMenuData);
	if (pPacketItem==NULL)
	{
		return;
	}
	CCommandUseItem::Create(CPlayerMgr::GetMainPlayer(),pPacketItem->GetIndex());
}

void CItemsPage::OnUnEquip()
{
	// TODO: Add your command handler code here
	MENUINFO MenuInfo;
	MenuInfo.cbSize=sizeof(MenuInfo);
	MenuInfo.dwMenuData=0;
	MenuInfo.fMask=MIM_MENUDATA;
	m_pEquipMenu->GetMenuInfo(&MenuInfo);
	CCommandUnEquip::Create(CPlayerMgr::GetMainPlayer(),(int)MenuInfo.dwMenuData);
}
