// NPCPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "NPCObject.h"
#include "SelfObject.h"
#include "NPCPage.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CNPCPage dialog

IMPLEMENT_DYNAMIC(CNPCPage, CPropertyPage)
CNPCPage::CNPCPage()
	: CPropertyPage(CNPCPage::IDD)
{
}

CNPCPage::~CNPCPage()
{
}

void CNPCPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST_NPC, m_NPCList);
}


BEGIN_MESSAGE_MAP(CNPCPage, CPropertyPage)
END_MESSAGE_MAP()


// CNPCPage message handlers


BOOL CNPCPage::OnInitDialog()
{
	UpdateData(FALSE);
	m_NPCList.InsertColumn(0,"¹ÖÎï",LVCFMT_LEFT,120);
	m_NPCList.InsertColumn(1,"¾àÀë",LVCFMT_RIGHT,40);
	m_NPCList.InsertColumn(2,"×ø±ê",LVCFMT_LEFT,120);
	m_NPCList.InsertColumn(3,"CharID",LVCFMT_LEFT,50);
	m_NPCList.InsertColumn(4,"WorldID",LVCFMT_LEFT,80);
	m_NPCList.InsertColumn(5,"CommID",LVCFMT_LEFT,80);
	m_NPCList.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	return TRUE;
}

void CNPCPage::ResetPage()
{
	m_NPCList.DeleteAllItems();
}

void CNPCPage::RefreshPage()
{
	CRoleMgr* pRoleMgr=&CPlayerMgr::GetMainPlayer()->GetRoleMgr();
	CSelfObject* pSelf=pRoleMgr->GetSelfObject();
	CList<CNPCObject*,CNPCObject*>* pNPCList=pRoleMgr->GetNPCList();
	CString str;
	POSITION pos=pNPCList->GetHeadPosition();
	for (int i=0;i<pNPCList->GetCount();i++)
	{
		CNPCObject* pNPCObject=pNPCList->GetNext(pos);
		m_NPCList.InsertItem(i,pNPCObject->GetName());
		m_NPCList.SetItemData(i,(DWORD_PTR)pNPCObject);
		if (pSelf)
		{
			str.Format("%.1f",pNPCObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
			m_NPCList.SetItemText(i,1,str);
		}
		str.Format("%.2f , %.2f",pNPCObject->GetPositionFloatX(),pNPCObject->GetPositionFloatY());
		m_NPCList.SetItemText(i,2,str);
		str.Format("%u",pNPCObject->GetCharID());
		m_NPCList.SetItemText(i,3,str);
		str.Format("%u",pNPCObject->GetWorldID());
		m_NPCList.SetItemText(i,4,str);
		str.Format("%u",pNPCObject->GetCommID());
		m_NPCList.SetItemText(i,5,str);
	}
}

void CNPCPage::RefreshAllDistance()
{
	int i;
	CString str;
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	for (i=0;i<m_NPCList.GetItemCount();i++)
	{
		CNPCObject* pNPCObject=reinterpret_cast<CNPCObject*>(m_NPCList.GetItemData(i));
		str.Format("%.1f",pNPCObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_NPCList.SetItemText(i,1,str);
	}
}

void CNPCPage::AddNPCObject(CNPCObject *pNPCObject)
{
	int n=m_NPCList.GetItemCount();
	if (n==CB_ERR)
	{
		return;
	}
	CSelfObject* pSelf=CPlayerMgr::GetMainPlayer()->GetRoleMgr().GetSelfObject();
	CString str;
	m_NPCList.InsertItem(n,pNPCObject->GetName());
	m_NPCList.SetItemData(n,(DWORD_PTR)pNPCObject);
	if (pSelf)
	{
		str.Format("%.1f",pNPCObject->GetDistanceInFloatTo(pSelf->GetPositionX(),pSelf->GetPositionY()));
		m_NPCList.SetItemText(n,1,str);
	}
	str.Format("%.2f , %.2f",pNPCObject->GetPositionFloatX(),pNPCObject->GetPositionFloatY());
	m_NPCList.SetItemText(n,2,str);
	str.Format("%u",pNPCObject->GetCharID());
	m_NPCList.SetItemText(n,3,str);
	str.Format("%u",pNPCObject->GetWorldID());
	m_NPCList.SetItemText(n,4,str);
	str.Format("%u",pNPCObject->GetCommID());
	m_NPCList.SetItemText(n,5,str);
}

void CNPCPage::RemoveNPCObject(CNPCObject *pNPCObject)
{
	for (int i=0;i<m_NPCList.GetItemCount();i++)
	{
		if (m_NPCList.GetItemData(i)==(DWORD_PTR)pNPCObject)
		{
			m_NPCList.DeleteItem(i);
			return;
		}
	}
}

