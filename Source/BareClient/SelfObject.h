#pragma once

#include "CommonHeader.h"
#include "playerobject.h"

class CGroundObject;
class CPacketObject;
class CEquipObject;


class CSelfObject :
	public CPlayerObject
{
public:
	CSelfObject(void);
	virtual ~CSelfObject(void);

	void SetMaxAvailableAttribNum(WORD num);
	void SetAttribute(WORD id,__int64 var);
	void SetMapName(CString strName);

	void AddGroundItem(CGroundObject *pGroundItem);
	CGroundObject* FindGroundItem(DWORD worldID);
	void DeleteGroundItem(DWORD worldID);


	void LoadPacketItems(dbc::RPacket& pk);
	CPacketObject* FindPacketItem(int index);
	int GetPacketSize();


	
	void LoadEquipItems(dbc::RPacket& pk);
	void LoadAppendEquipItmes(dbc::RPacket& pk);
	CEquipObject* FindEquipItem(int index);
	

	WORD GetMaxAvailableAttribNum();
	__int64 GetAttribute(WORD id);
	CString GetMapName();
	long GetMoney();
	long GetLevel();
	long GetHP();
	long GetMaxHP();
	long GetSP();
	long GetMaxSP();
	__int64 GetLevelEXP();
	__int64 GetLevelMaxEXP();
	long GetSTR();
	long GetDEX();
	long GetAGI();
	long GetVIT();
	long GetSTA();
	long GetLUK();
	long GetAttributePoint();
	long GetSkillPoint();
	CMap<DWORD,DWORD,CGroundObject*,CGroundObject*>* GetGroundItemMap();


	CEquipObject* GetEquip(int nIndex);
	CEquipObject* GetHeadEquip();	//头盔	0
	//CEquipObject* GetFaceEquip();	//面部装备-没有	1
	CEquipObject* GetBodyEquip();	//盔甲	2
	CEquipObject* GetGloveEquip();	//手套	3
	CEquipObject* GetShoesEquip();	//鞋子	4
	CEquipObject* GetNeckEquip();	//项链	5
	CEquipObject* GetShieldEquip();	//左手(盾)	6
	CEquipObject* GetLAccessoryEquip();	//饰物(左)	7
	CEquipObject* GetRAccessoryEquip();	//饰物(右)	8
	CEquipObject* GetSwordEquip();	//右手(剑)	9


private:
	void SetPacketSize(int size);
	void SetPacketItem(short index,CPacketObject *pPacketItem);
	void DeletePacketItem(short index);

	void SetEquipSize(int size);
	void SetEquipItem(short index,CEquipObject *pEquipItem);
	void DeleteEquipItem(short index);


private:
	__int64 m_SelfAttr[ATTR_MAX_NUM+1];
	WORD m_nMaxAvailableNum;
	CString m_strMapName;
	CMap<DWORD,DWORD,CGroundObject*,CGroundObject*> m_GroundItemMap;
	CPtrArray m_PacketItemArray;
	CPtrArray m_EquipItemArray;
};
