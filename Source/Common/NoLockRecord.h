//======================================================================================================================
// FileName: HairRecord.h
// Creater: Jerry li
// Date: 2005.08.29
// Comment: CHairRecordSet class
//======================================================================================================================

#ifndef NOLOCKRECORD_H
#define NOLOCKRECORD_H

#include <tchar.h>
#include <util.h>
#include "TableData.h"

class CNoLockRecord : public CRawDataInfo
{
  public:
  CNoLockRecord();
  DWORD dwItemID; //不可锁的道具ID
};

class CNoLockRecordSet : public CRawDataSet
{
  public:
  static CNoLockRecordSet* I() { return _Instance; }

  CNoLockRecordSet(int nIDStart, int nIDCnt, int nCol = 128) :
	  CRawDataSet(nIDStart, nIDCnt, nCol)
  {
	_Instance = this;
	_Init();
  }

  protected:
  static CNoLockRecordSet* _Instance; // 相当于单键, 把自己记住

  virtual CRawDataInfo* _CreateRawDataArray(int nCnt)
  {
	return new CNoLockRecord[nCnt];
  }

  virtual void _DeleteRawDataArray()
  {
	delete[](CNoLockRecord*) _RawDataArray;
  }

  virtual int _GetRawDataInfoSize()
  {
	return sizeof(CNoLockRecord);
  }

  virtual void* _CreateNewRawData(CRawDataInfo* pInfo)
  {
	return NULL;
  }

  virtual void _DeleteRawData(CRawDataInfo* pInfo)
  {
	////SAFE_DELETE(pInfo->pData);
  }
  //virtual void  _AfterLoad();

  virtual BOOL _ReadRawDataInfo(CRawDataInfo* pRawDataInfo, vector<string>& ParamList);
  //virtual void _ProcessRawDataInfo(CRawDataInfo *pInfo);
};

inline CNoLockRecord* GetNoLockRecordInfo(int nTypeID)
{
  return (CNoLockRecord*)CNoLockRecordSet::I()->GetRawDataInfo(nTypeID);
}

#endif //NOLOCKRECORD_H