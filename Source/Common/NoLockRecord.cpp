
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
CNoLockRecordSet* CNoLockRecordSet::_Instance = NULL;
BOOL			  CNoLockRecordSet::_ReadRawDataInfo(CRawDataInfo* pRawDataInfo, vector<string>& ParamList)
{
  if(ParamList.size() == 0) return FALSE;

  CNoLockRecord* pInfo = (CNoLockRecord*)pRawDataInfo;
  // ±àºÅ
  pInfo->dwItemID = pInfo->nID;
  return TRUE;
}
