#pragma once
#include "itemobject.h"

class CEquipObject :
	public CItemObject
{
public:
	CEquipObject(void);
	~CEquipObject(void);

	void SetEndurance(WORD nowValue,WORD maxValue);
	void SetEnergy(WORD nowValue,WORD maxValue);
	void SetNowEndurance(WORD nowValue);
	void SetNowEnergy(WORD nowValue);
	void SetProficiencyLv(int nProficiencyLv);
	int GetProficiencyLv();

private:
	WORD m_nEndurance;
	WORD m_nEnduranceMax;
	WORD m_nEnergy;
	WORD m_nEnergyMax;
	int m_nProficiencyLv;

};
