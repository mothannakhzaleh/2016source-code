#pragma once
#include "util.h"
#include "TableData.h"

#define NPC_MAXSIZE_NAME 128 // npc名称长度

class NPCData : public CRawDataInfo
{
  public:
  char	szName[NPC_MAXSIZE_NAME];	 // 地图中显示npc名称
  char	szArea[NPC_MAXSIZE_NAME];	 // 位置或者等级
  DWORD dwxPos0, dwyPos0;			 // npc位置信息
  char	szMapName[NPC_MAXSIZE_NAME]; // npc所在地图名称
};

class NPCHelper : public CRawDataSet
{
  public:
  static NPCHelper* I() { return _Instance; }

  NPCHelper(int nIDStart, int nIDCnt, int nCol = 128) :
	  CRawDataSet(nIDStart, nIDCnt, nCol)
  {
	_Instance = this;
	_Init();
  }

  protected:
  static NPCHelper* _Instance; // 相当于单键, 把自己记住

  virtual CRawDataInfo* _CreateRawDataArray(int nCnt)
  {
	return new NPCData[nCnt];
  }

  virtual void _DeleteRawDataArray()
  {
	delete[](NPCData*) _RawDataArray;
  }

  virtual int _GetRawDataInfoSize()
  {
	return sizeof(NPCData);
  }

  virtual void* _CreateNewRawData(CRawDataInfo* pInfo)
  {
	return NULL;
  }

  virtual void _DeleteRawData(CRawDataInfo* pInfo)
  {
	////SAFE_DELETE(pInfo->pData);
  }

  virtual BOOL _ReadRawDataInfo(CRawDataInfo* pRawDataInfo, vector<string>& ParamList);
};

inline NPCData* GetNPCDataInfo(int nTypeID)
{
  return (NPCData*)NPCHelper::I()->GetRawDataInfo(nTypeID);
}