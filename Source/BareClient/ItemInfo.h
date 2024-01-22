#pragma once

class CItemInfo
{
public:
	CItemInfo(void);
	~CItemInfo(void);

	void SetName(CString strName);
	void SetType(int nType);
	void SetClassName(CString strClassName);	//Set the category name (such as: weapons, armor, consumables, props...)
	void SetTypeName(CString strTypeName);		//Set the type name (eg: 1=sword, 2=greatsword, 3=bow...)
	void SetEquipPlace(CString strEquipPlace);	//Set the corresponding part of the equipment (the default is an empty character for non-equipment)
	void SetCanBeEquip(bool bEquip);
	void SetCanBeUse(bool bUse);

	CString GetName();
	int GetType();
	CString GetClassName();						//Get the category name (such as: weapons, armor, use items, props...)
	CString GetTypeName();						//Get type name (eg: 1=sword, 2=greatsword, 3=bow...)
	CString GetEquipPlace();					//Get the corresponding part of the equipment (return a null character for non-equipment)
	bool CanBeEquip();
	bool CanBeUse();

private:
	CString m_strName;
	CString m_strClassName;
	CString m_strTypeName;
	CString m_strEquipPlace;
	int m_nType;
	bool m_bCanBeEquip;
	bool m_bCanBeUse;
};
