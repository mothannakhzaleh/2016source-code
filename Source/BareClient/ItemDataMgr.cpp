#include "StdAfx.h"
#include "afxdao.h"
#include "ItemInfo.h"
#include ".\itemdatamgr.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif


CMap<DWORD,DWORD,CItemInfo*,CItemInfo*> CItemDataMgr::m_Items;

CItemDataMgr::CItemDataMgr(void)
{
}

CItemDataMgr::~CItemDataMgr(void)
{
}

bool CItemDataMgr::LoadItemsInfo()
{
	static int nVerify=0;
	CDaoDatabase dbItems;
	CDaoRecordset rdItems(&dbItems);
	try
	{
		dbItems.Open("BKopData.mdb",FALSE,TRUE,g_strDBPassword);
		rdItems.Open(dbOpenSnapshot,"SELECT * FROM iteminfo, itemtype WHERE iteminfo.type=itemtype.type number;",dbReadOnly);
		while (!rdItems.IsEOF())
		{ 
			COleVariant varIndex=rdItems.GetFieldValue("serial number");
			if (varIndex.vt!=VT_I4)
			{
				rdItems.MoveNext();
				continue;
			}
			COleVariant varName=rdItems.GetFieldValue("name");
			if (varName.vt!=VT_BSTR)
			{
				rdItems.MoveNext();
				continue;
			}
			COleVariant varType=rdItems.GetFieldValue("type");
			if (varType.vt!=VT_I4)
			{
				rdItems.MoveNext();
				continue;
			}
			COleVariant varClassName=rdItems.GetFieldValue("category");
			if (varClassName.vt!=VT_BSTR)
			{
				rdItems.MoveNext();
				continue;
			}
			COleVariant varTypeName=rdItems.GetFieldValue("type name");
			if (varTypeName.vt!=VT_BSTR)
			{
				rdItems.MoveNext();
				continue;
			}
			COleVariant varEquipPlace=rdItems.GetFieldValue("Equipment part");	//may return a null pointer
			COleVariant varUseType=rdItems.GetFieldValue("Features");
			if (varUseType.vt!=VT_I2)
			{
				rdItems.MoveNext();
				continue;
			}
			//COleVariant varEquipPlace=rdItems.GetFieldValue("Props can be equipped with position");
			//if (varName.vt!=VT_BSTR)
			//{
			//	rdItems.MoveNext();
			//	continue;
			//}
			CItemInfo *pItemInfo=new CItemInfo();
			pItemInfo->SetName((char*)varName.bstrVal);
			pItemInfo->SetType((int)varType.lVal);
			pItemInfo->SetClassName((char*)varClassName.bstrVal);
			pItemInfo->SetTypeName((char*)varTypeName.bstrVal);
			pItemInfo->SetEquipPlace((char*)varEquipPlace.bstrVal);
			if (varUseType.iVal==2)
			{
				pItemInfo->SetCanBeUse(false);
				pItemInfo->SetCanBeEquip(true);
			}
			else if (varUseType.iVal==1)
			{
				pItemInfo->SetCanBeUse(true);
				pItemInfo->SetCanBeEquip(false);
			}
			else
			{
				pItemInfo->SetCanBeUse(false);
				pItemInfo->SetCanBeEquip(false);
			}
			//CString strEquipPlace=(char*)varEquipPlace.bstrVal);
			//if (strEquipPlace=="-1")
			//{
			//	pItemInfo->SetCanBeEquip(false);
			//}
			//else
			//{
			//	pItemInfo->SetCanBeEquip(true);
			//}
			m_Items.SetAt((DWORD)varIndex.lVal,pItemInfo);
			rdItems.MoveNext();
			nVerify++;
			if (nVerify!=m_Items.GetCount())
			{
				MessageBox(NULL,"Duplicate value found in item data "," error",MB_OK);
			}
		}
	}
	catch(CDaoException *e)
	{
		e->ReportError();
		if (rdItems.IsOpen())
		{
			rdItems.Close();
		}
		if (dbItems.IsOpen())
		{
			dbItems.Close();
		}
		return false;
	}
	dbItems.Close();
	return true;
}

void CItemDataMgr::FreeItemsInfo()
{
	POSITION pos;
	while (pos=m_Items.GetStartPosition())
	{
		DWORD index;
		CItemInfo *pItemInfo;
		m_Items.GetNextAssoc(pos,index,pItemInfo);
		m_Items.RemoveKey(index);
		delete pItemInfo;
	}
}

CString CItemDataMgr::GetItemName(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->GetName();
	}
	CString strRet;
	strRet.Format("Unknown item: %u",index);
	return strRet;
}

int CItemDataMgr::GetItemType(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->GetType();
	}
	return 0;
}

CString CItemDataMgr::GetItemClassName(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->GetClassName();
	}
	CString strRet;
	strRet.Format("Unknown class: %u",index);
	return strRet;
}

CString CItemDataMgr::GetItemTypeName(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->GetTypeName();
	}
	CString strRet;
	strRet.Format("Unknown type: %u",index);
	return strRet;
}

CString CItemDataMgr::GetItemEquipPlace(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->GetEquipPlace();
	}
	return "";
}

bool CItemDataMgr::CanBeEquip(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->CanBeEquip();
	}
	return false;
}

bool CItemDataMgr::CanBeUse(DWORD index)
{
	CItemInfo *pItemInfo=NULL;
	if (m_Items.Lookup(index,pItemInfo))
	{
		return pItemInfo->CanBeUse();
	}
	return false;
}

