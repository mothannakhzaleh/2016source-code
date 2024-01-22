#include "StdAfx.h"
#include "ItemDataMgr.h"
#include ".\itemobject.h"

CItemObject::CItemObject(void)
{
}

CItemObject::~CItemObject(void)
{
}

void CItemObject::SetItemID(DWORD itemID)
{
	m_dwItemID=itemID;
}

void CItemObject::SetTotalNum(WORD nTotalNum)
{
	m_nTotalNum=nTotalNum;
}







DWORD CItemObject::GetItemID()
{
	return m_dwItemID;
}

CString CItemObject::GetName()
{
	return CItemDataMgr::GetItemName(m_dwItemID);
}

WORD CItemObject::GetTotalNum()
{
	return m_nTotalNum;
}

CString CItemObject::GetClassName()
{
	return CItemDataMgr::GetItemClassName(m_dwItemID);
}

CString CItemObject::GetTypeName()
{
	return CItemDataMgr::GetItemTypeName(m_dwItemID);
}

CString CItemObject::GetEquipPlace()
{
	return CItemDataMgr::GetItemEquipPlace(m_dwItemID);
}

