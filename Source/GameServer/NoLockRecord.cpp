
#include "NoLockRecord.h"
//---------------------------------------------------------------------------
// class CNoLockRecord
//---------------------------------------------------------------------------
CNoLockRecord::CNoLockRecord()
{
	dwItemID = 0;
}
//---------------------------------------------------------------------------
// class CNoLockRecordSet
//---------------------------------------------------------------------------
CNoLockRecordSet *CNoLockRecordSet::_Instance=NULL;

BOOL CNoLockRecordSet::_ReadRawDataInfo(CRawDataInfo *pRawDataInfo, vector<string> &ParamList)
{   
	if(ParamList.size()==0) return FALSE;

	CNoLockRecord *pInfo = (CNoLockRecord*)pRawDataInfo;
	// ±àºÅ
	pInfo->lID = pInfo->nID;
	pInfo->dwItemID = Str2Int(pInfo->szDataName);
	return TRUE;
}
