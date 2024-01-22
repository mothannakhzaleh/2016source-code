#include "StdAfx.h"
#include ".\equipobject.h"

CEquipObject::CEquipObject(void)
{
}

CEquipObject::~CEquipObject(void)
{
}

void CEquipObject::SetEndurance(WORD nowValue,WORD maxValue)
{
	m_nEndurance=nowValue;
	m_nEnduranceMax=maxValue;
}

void CEquipObject::SetEnergy(WORD nowValue,WORD maxValue)
{
	m_nEnergy=nowValue;
	m_nEnergyMax=maxValue;
}

void CEquipObject::SetNowEndurance(WORD nowValue)
{
	m_nEndurance=nowValue;
}

void CEquipObject::SetNowEnergy(WORD nowValue)
{
	m_nEnergy=nowValue;
}

void CEquipObject::SetProficiencyLv(int nProficiencyLv)
{
	m_nProficiencyLv=nProficiencyLv;
}



int CEquipObject::GetProficiencyLv()
{
	return m_nProficiencyLv;
}
