#pragma once
#include "itemobject.h"

class CPacketObject :
	public CItemObject
{
public:
	CPacketObject(void);
	virtual ~CPacketObject(void);

	void SetIndex(int nIndex);
	int GetIndex();
	void SetEndurance(WORD nowValue,WORD maxValue);
	void SetEnergy(WORD nowValue,WORD maxValue);
	void SetProficiencyLv(int nProficiencyLv);
	int GetProficiencyLv();

private:
	int m_nIndex;
	WORD m_nEndurance;
	WORD m_nEnduranceMax;
	WORD m_nEnergy;
	WORD m_nEnergyMax;
	int m_nProficiencyLv;
};
