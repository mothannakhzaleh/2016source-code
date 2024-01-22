#include "StdAfx.h"
#include "GroundObject.h"
#include "PacketObject.h"
#include "ItemDataMgr.h"
#include "EquipObject.h"
#include "CommonHeader.h"
#include ".\selfobject.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CSelfObject::CSelfObject(void)
{
	SetType(CRoleObject::eSelf);
	ZeroMemory(&m_SelfAttr,sizeof(m_SelfAttr));
	m_nMaxAvailableNum=0;
	SetEquipSize(enumEQUIP_NUM);
}

CSelfObject::~CSelfObject(void)
{
	POSITION pos;
	while (pos=m_GroundItemMap.GetStartPosition())
	{
		DWORD index;
		CGroundObject *pGroundItem;
		m_GroundItemMap.GetNextAssoc(pos,index,pGroundItem);
		m_GroundItemMap.RemoveKey(index);
		delete pGroundItem;
	}
	int i;
	for (i=0;i<m_PacketItemArray.GetCount();i++)
	{
		CPacketObject* pPacketItem=reinterpret_cast<CPacketObject*>(m_PacketItemArray.GetAt(i));
		if (pPacketItem)
		{
			delete pPacketItem;
		}
	}
	m_PacketItemArray.RemoveAll();
	for (i=0;i<m_EquipItemArray.GetCount();i++)
	{
		CEquipObject* pEquipItem=reinterpret_cast<CEquipObject*>(m_EquipItemArray.GetAt(i));
		if (pEquipItem)
		{
			delete pEquipItem;
		}
	}
	m_EquipItemArray.RemoveAll();
}

void CSelfObject::SetAttribute(WORD id,__int64 var)
{
	if (id>ATTR_MAX_NUM)
	{//Attribute value is abnormal
		ASSERT(false);
		return;
	}
	m_SelfAttr[id]=var;
}

void CSelfObject::AddGroundItem(CGroundObject *pGroundItem)
{
	m_GroundItemMap.SetAt(pGroundItem->GetWorldID(),pGroundItem);
}








__int64 CSelfObject::GetAttribute(WORD id)
{
	if (id>ATTR_MAX_NUM)
	{//Attribute value is abnormal
		ASSERT(false);
		return 0;
	}
	return m_SelfAttr[id];
}

long CSelfObject::GetMoney()
{
	return (long)m_SelfAttr[ATTR_GD];
}

long CSelfObject::GetLevel()
{
	return (long)m_SelfAttr[ATTR_LV];
}

long CSelfObject::GetHP()
{
	return (long)m_SelfAttr[ATTR_HP];
}

long CSelfObject::GetMaxHP()
{
	return (long)m_SelfAttr[ATTR_MXHP];
}

long CSelfObject::GetSP()
{
	return (long)m_SelfAttr[ATTR_SP];
}

long CSelfObject::GetMaxSP()
{
	return (long)m_SelfAttr[ATTR_MXSP];
}

__int64 CSelfObject::GetLevelEXP()
{
	return m_SelfAttr[ATTR_CEXP]-m_SelfAttr[ATTR_CLEXP];
}

__int64 CSelfObject::GetLevelMaxEXP()
{
	return m_SelfAttr[ATTR_NLEXP]-m_SelfAttr[ATTR_CLEXP];
}

long CSelfObject::GetSTR()
{
	return (long)m_SelfAttr[ATTR_STR];
}

long CSelfObject::GetDEX()
{
	return (long)m_SelfAttr[ATTR_DEX];
}

long CSelfObject::GetAGI()
{
	return (long)m_SelfAttr[ATTR_AGI];
}

long CSelfObject::GetVIT()
{
	return (long)m_SelfAttr[ATTR_CON];
}

long CSelfObject::GetSTA()
{
	return (long)m_SelfAttr[ATTR_STA];
}

long CSelfObject::GetLUK()
{
	return (long)m_SelfAttr[ATTR_LUK];
}

long CSelfObject::GetAttributePoint()
{
	return (long)m_SelfAttr[ATTR_AP];
}

long CSelfObject::GetSkillPoint()
{
	return (long)m_SelfAttr[ATTR_TP];
}

void CSelfObject::SetMaxAvailableAttribNum(WORD num)
{
	if (m_nMaxAvailableNum<num)
	{
		m_nMaxAvailableNum=num;
	}
}

WORD CSelfObject::GetMaxAvailableAttribNum()
{
	return m_nMaxAvailableNum;
}

void CSelfObject::SetMapName(CString strName)
{
	m_strMapName=strName;
}

CString CSelfObject::GetMapName()
{
	return m_strMapName;
}

void CSelfObject::DeleteGroundItem(DWORD worldID)
{
	CGroundObject *pGroundItem=NULL;
	if (m_GroundItemMap.Lookup(worldID,pGroundItem))
	{
		m_GroundItemMap.RemoveKey(worldID);
		SAFE_DELETE(pGroundItem);
	}
}

CGroundObject* CSelfObject::FindGroundItem(DWORD worldID)
{
	CGroundObject *pGroundItem=NULL;
	if (m_GroundItemMap.Lookup(worldID,pGroundItem))
	{
		return pGroundItem;
	}
	return NULL;
}

CMap<DWORD,DWORD,CGroundObject*,CGroundObject*>* CSelfObject::GetGroundItemMap()
{
	return &m_GroundItemMap;
}




void CSelfObject::SetPacketSize(int size)
{
	m_PacketItemArray.SetSize(size);
}

void CSelfObject::SetPacketItem(short index,CPacketObject *pPacketItem)
{
	m_PacketItemArray.SetAt(index,pPacketItem);
}

CPacketObject* CSelfObject::FindPacketItem(int index)
{
	if (index<0 || index>m_PacketItemArray.GetUpperBound())
	{
		return NULL;
	}
	return reinterpret_cast<CPacketObject*>(m_PacketItemArray.GetAt(index));
}

void CSelfObject::DeletePacketItem(short index)
{
	CPacketObject *pPacketItem=FindPacketItem(index);
	if (!pPacketItem)
	{
		return;
	}
	//m_PacketItemArray.RemoveAt(index);
	m_PacketItemArray[index]=NULL;
	delete pPacketItem;
}

void CSelfObject::DeleteEquipItem(short index)
{
	CEquipObject *pEquipItem=FindEquipItem(index);
	if (!pEquipItem)
	{
		return;
	}
	m_EquipItemArray.RemoveAt(index);
	delete pEquipItem;
}

void CSelfObject::LoadPacketItems(dbc::RPacket& pk)
{
	if (pk.ReadChar()==enumSYN_KITBAG_INIT) //Propbar Sync Type - Propbar Initialization
	{
		m_PacketItemArray.RemoveAll();
		SetPacketSize(pk.ReadShort());
	}
	short nIndexID;
	while ((nIndexID=(short)pk.ReadShort())>=0)
	{
		DWORD nItemID=pk.ReadShort();
		if (nItemID<=0)
		{
			DeletePacketItem(nIndexID);
			continue;
		}
		CPacketObject *pPacketItem=FindPacketItem(nIndexID);
		if (!pPacketItem)
		{
			pPacketItem=new CPacketObject();
		}
		pPacketItem->SetItemID(nItemID);

		// Add by lark.li 20080821
		int dwDBID		=	pk.ReadLong();
		// End

		pPacketItem->SetTotalNum(pk.ReadShort());
		WORD nowValue=pk.ReadShort();
		WORD maxValue=pk.ReadShort();
		pPacketItem->SetEndurance(nowValue,maxValue);
		nowValue=pk.ReadShort();
		maxValue=pk.ReadShort();
		pPacketItem->SetEnergy(nowValue,maxValue);
		pPacketItem->SetProficiencyLv((int)pk.ReadChar());

		pk.ReadChar(); //Is this item valid --

		if (CItemDataMgr::GetItemType(nItemID)==enumItemTypeBoat)
		{
			pk.ReadLong();	//Ship's WorldID
		}

		pk.ReadLong();		//Refining parameters --
		pk.ReadLong();		//2006-5-11

		//if (pPacketItem->GetProficiencyLv()>0)
		//{
		//	for (int i=0;i<defITEM_FORGE_ATTR_NUM;i++)
		//	{
		//		pk.ReadShort();	//Refined attribute number
		//		pk.ReadShort();	//Refined attribute value
		//	}
		//}

		if (pk.ReadChar()) // instance attribute exists
		{
			for (int i=0;i<defITEM_INSTANCE_ATTR_NUM;i++)
			{
				pk.ReadShort();	//Additional (including refined) attribute numbers for equipment
				pk.ReadShort();	//Additional (including refining) attribute values of equipment
			}
		}
		pPacketItem->SetIndex(nIndexID);
		SetPacketItem(nIndexID,pPacketItem);
	}
}

int CSelfObject::GetPacketSize()
{
	return (int)m_PacketItemArray.GetSize();
}

void CSelfObject::LoadEquipItems(dbc::RPacket& pk)
{
	BYTE chSynType=pk.ReadChar();	//Whether to synchronize appearance --

	pk.ReadShort();	// Type ID
	if( pk.ReadChar() == 1 ) // appearance of the ship
	{
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadShort();
	}
	else
	{
		pk.ReadShort();	// hair ID
		for (int i = 0; i < enumEQUIP_NUM; i++)
		{
			CEquipObject* pEquipItem=FindEquipItem(i);
			if (!pEquipItem)
			{
				pEquipItem=new CEquipObject;
			}
			pEquipItem->SetItemID(pk.ReadShort());

			// Add by lark.li 20080821 begin
			int dwDBID	=	pk.ReadLong();
			// End

			//  [11/17/2005]
			if (pEquipItem->GetItemID()==0)
			{
				SetEquipItem(i,pEquipItem);
				continue;
			}
			if (chSynType ==  enumSYN_LOOK_CHANGE)
			{
				pEquipItem->SetNowEndurance(pk.ReadShort());
				pEquipItem->SetNowEnergy(pk.ReadShort());
				pk.ReadChar();	//Does the appearance change work?
				SetEquipItem(i,pEquipItem);
				continue;
			}
			else
			{
				pEquipItem->SetTotalNum(pk.ReadShort());
				WORD nowValue=pk.ReadShort();
				WORD maxValue=pk.ReadShort();
				pEquipItem->SetEndurance(nowValue,maxValue);
				nowValue=pk.ReadShort();
				maxValue=pk.ReadShort();
				pEquipItem->SetEnergy(nowValue,maxValue);
				pEquipItem->SetProficiencyLv((int)pk.ReadChar());
				pk.ReadChar(); //Is this item valid --
			}
			//  [11/17/2005] --

			if (pk.ReadChar()==0)
			{
				if (!FindEquipItem(i))
				{
					delete pEquipItem;
				}
				else
				{
					DeleteEquipItem(i);
				}
				continue;
			}

			pk.ReadLong();		//Refining parameters
			pk.ReadLong();		//2006-5-11

			//if (pEquipItem->GetProficiencyLv()>0)
			//{
			//	for (int j = 0; j < defITEM_FORGE_ATTR_NUM; j++)
			//	{
			//		pk.ReadShort();	//Refined attribute number
			//		pk.ReadShort();	//Refined attribute value
			//	}
			//}


			if (pk.ReadChar()) // instance attribute exists
			{
				for (int j = 0; j < defITEM_INSTANCE_ATTR_NUM; j++)
				{
					pk.ReadShort();	//装备附加(含精练)的属性编号
					pk.ReadShort();	//装备附加(含精练)的属性值
				}
			}
			SetEquipItem(i,pEquipItem);
		}
	}
}

void CSelfObject::LoadAppendEquipItmes(dbc::RPacket& pk)
{
	for (char i = 0; i < defESPE_KBGRID_NUM; i++)
	{
		WORD wLookID=pk.ReadShort();
		if (wLookID != 0)
		{
			bool bValid=(pk.ReadChar() != 0)?true:false;
		}
	}
}

CEquipObject* CSelfObject::FindEquipItem(int index)
{
	if (index<0 || index>m_EquipItemArray.GetUpperBound())
	{
		return NULL;
	}
	return reinterpret_cast<CEquipObject*>(m_EquipItemArray.GetAt(index));
}

void CSelfObject::SetEquipSize(int size)
{
	m_EquipItemArray.SetSize(size);
}

void CSelfObject::SetEquipItem(short index,CEquipObject *pEquipItem)
{
	m_EquipItemArray.SetAt(index,pEquipItem);
}


CEquipObject* CSelfObject::GetEquip(int nIndex)
{
	if (nIndex<0 || nIndex>m_EquipItemArray.GetUpperBound())
	{
		return NULL;
	}
	CEquipObject *pEquipObject=reinterpret_cast<CEquipObject*>(m_EquipItemArray.GetAt(nIndex));
	if (pEquipObject->GetItemID()==0)
	{
		return NULL;
	}
	return pEquipObject;
}

CEquipObject* CSelfObject::GetHeadEquip()	//头盔	0
{
	return GetEquip(enumEQUIP_HEAD);
}

CEquipObject* CSelfObject::GetBodyEquip()	//盔甲	2
{
	return GetEquip(enumEQUIP_BODY);
}

CEquipObject* CSelfObject::GetGloveEquip()	//手套	3
{
	return GetEquip(enumEQUIP_GLOVE);
}

CEquipObject* CSelfObject::GetShoesEquip()	//鞋子	4
{
	return GetEquip(enumEQUIP_SHOES);
}

CEquipObject* CSelfObject::GetNeckEquip()	//项链	5
{
	return GetEquip(enumEQUIP_NECK);
}

CEquipObject* CSelfObject::GetShieldEquip()	//左手(盾)	6
{
	return GetEquip(enumEQUIP_LHAND);
}

CEquipObject* CSelfObject::GetLAccessoryEquip()	//饰物(左)	7
{
	return GetEquip(enumEQUIP_HAND1);
}

CEquipObject* CSelfObject::GetRAccessoryEquip()	//饰物(右)	8
{
	return GetEquip(enumEQUIP_HAND2);
}

CEquipObject* CSelfObject::GetSwordEquip()	//右手(剑)	9
{
	return GetEquip(enumEQUIP_RHAND);
}
