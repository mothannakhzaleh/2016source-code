#include "StdAfx.h"
#include ".\packetobject.h"

CPacketObject::CPacketObject(void)
{
	m_nIndex=0;
}

CPacketObject::~CPacketObject(void)
{
}

void CPacketObject::SetIndex(int nIndex)
{
	m_nIndex=nIndex;
}

int CPacketObject::GetIndex()
{
	return m_nIndex;
}

void CPacketObject::SetEndurance(WORD nowValue,WORD maxValue)
{
	m_nEndurance=nowValue;
	m_nEnduranceMax=maxValue;
}

void CPacketObject::SetEnergy(WORD nowValue,WORD maxValue)
{
	m_nEnergy=nowValue;
	m_nEnergyMax=maxValue;
}

void CPacketObject::SetProficiencyLv(int nProficiencyLv)
{
	m_nProficiencyLv=nProficiencyLv;
}



int CPacketObject::GetProficiencyLv()
{
	return m_nProficiencyLv;
}
