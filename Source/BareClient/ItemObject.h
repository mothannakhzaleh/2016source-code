#pragma once

class CItemObject
{
public:
	CItemObject(void);
	virtual ~CItemObject(void);

	void SetItemID(DWORD itemID);		//Set the item ID, the same item ID should be the same
	void SetTotalNum(WORD nTotalNum);


	DWORD GetItemID();					//Obtain the item ID, the ID of the same item should be the same, it can be used to look up the table and find out the detailed information of the item
	CString GetName();					//get item name
	WORD GetTotalNum();					//Get the number of items in the current grid
	CString GetTypeName();				//Get item type name (sword, greatsword, bow...)
	CString GetClassName();				//Get the name of the item category (weapon, armor, usable, props...)
	CString GetEquipPlace();			//Get the position where the item can be equipped (non-equipment returns an empty character)

private:
	DWORD m_dwItemID;
	WORD m_nTotalNum;
};
