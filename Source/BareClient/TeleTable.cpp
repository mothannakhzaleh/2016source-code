#include "StdAfx.h"
#include ".\teletable.h"



#ifdef _DEBUG
#define new DEBUG_NEW
#endif


int CTeleTable::m_nMaxCount=0;
CCriticalSection CTeleTable::m_Critical_Access;
CString CTeleTable::m_TeleTable[AUTO_TELE_TABLE_MAXNUM];


CTeleTable::CTeleTable(void)
{
}

CTeleTable::~CTeleTable(void)
{
}

void CTeleTable::AddTargetText(CString text)
{
	CSingleLock locker(&m_Critical_Access);
	locker.Lock();
	m_TeleTable[m_nMaxCount]="&move "+text;
	m_nMaxCount++;
}

CString CTeleTable::GetRandomTeleCommand()
{
	if (m_nMaxCount==0)
	{
		return "";
	}
	int n=rand()%m_nMaxCount;
	CSingleLock locker(&m_Critical_Access);
	locker.Lock();
	return m_TeleTable[n];
}
