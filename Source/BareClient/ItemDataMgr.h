#pragma once

class CItemInfo;

class CItemDataMgr
{
public:
	CItemDataMgr(void);
	~CItemDataMgr(void);

	static bool LoadItemsInfo();
	static void FreeItemsInfo();


	static CString GetItemName(DWORD index);		//Get item name by item ID
	static int GetItemType(DWORD index);			//Get the index number of the item type by item ID (1=sword, 2=greatsword, 3=bow...)
	static CString GetItemClassName(DWORD index);	//Obtain the item category name through the item ID (weapon, armor, use item, props...)
	static CString GetItemTypeName(DWORD index);	//Get item type name by item ID (sword, greatsword, bow...)
	static CString GetItemEquipPlace(DWORD index);	//Obtain the equipable position of the item through the item ID (non-equipment returns an empty character)
	static bool CanBeEquip(DWORD index);			//Know whether the item can be equipped by the item ID (regardless of the actual occupation and level)
	static bool CanBeUse(DWORD index);			//Know whether the item can be used by the item ID (regardless of the conditions of use)


private:
	static CMap<DWORD,DWORD,CItemInfo*,CItemInfo*> m_Items;
};
