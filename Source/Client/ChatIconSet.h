#pragma once

#include "TableData.h"

class CChatIconInfo : public CRawDataInfo
{
  public:
  CChatIconInfo()
  {
	memset(szSmall, 0, sizeof(szSmall));
	memset(szSmallOff, 0, sizeof(szSmallOff));
	memset(szBig, 0, sizeof(szBig));
	memset(szHint, 0, sizeof(szHint));
  }

  char szSmall[16];
  int  nSmallX;
  int  nSmallY;

  char szSmallOff[16]; // 离线时的图标
  int  nSmallOffX;
  int  nSmallOffY;

  char szBig[16];
  int  nBigX;
  int  nBigY;

  char szHint[32];
};

class CChatIconSet : public CRawDataSet
{
  public:
  static CChatIconSet* I() { return _Instance; }

  CChatIconSet(int nIDStart, int nIDCnt) :
	  CRawDataSet(nIDStart, nIDCnt)
  {
	_Instance = this;
	_Init();
  }

  protected:
  static CChatIconSet* _Instance; // 相当于单键, 把自己记住

  virtual CRawDataInfo* _CreateRawDataArray(int nCnt)
  {
	return new CChatIconInfo[nCnt];
  }

  virtual void _DeleteRawDataArray()
  {
	delete[](CChatIconInfo*) _RawDataArray;
  }

  virtual int _GetRawDataInfoSize()
  {
	return sizeof(CChatIconInfo);
  }

  virtual void* _CreateNewRawData(CRawDataInfo* pInfo)
  {
	return NULL;
  }

  virtual void _DeleteRawData(CRawDataInfo* pInfo)
  {
	////SAFE_DELETE(pInfo->pData);
  }

  virtual BOOL _ReadRawDataInfo(CRawDataInfo* pRawDataInfo, vector<string>& ParamList)
  {
	// if(ParamList.size()==0) return FALSE;

	CChatIconInfo* pInfo = (CChatIconInfo*)pRawDataInfo;

	//strncpy(pInfo->szSmall, pInfo->szDataName, sizeof(pInfo->szSmall));
	strncpy_s(pInfo->szSmall, sizeof(pInfo->szSmall), pInfo->szDataName, _TRUNCATE);

	int m		   = 0;
	pInfo->nSmallX = Str2Int(ParamList[m++]);
	pInfo->nSmallY = Str2Int(ParamList[m++]);

	// Modify by lark.li 20080701 begin
	//strncpy(pInfo->szSmallOff, ParamList[m++].c_str(), sizeof(pInfo->szSmallOff));
	//strncpy(pInfo->szSmallOff, ConvertResString(ParamList[m++].c_str()), sizeof(pInfo->szSmallOff));
	strncpy_s(pInfo->szSmallOff, sizeof(pInfo->szSmallOff), ConvertResString(ParamList[m++].c_str()), _TRUNCATE);
	// End

	pInfo->nSmallOffX = Str2Int(ParamList[m++]);
	pInfo->nSmallOffY = Str2Int(ParamList[m++]);

	// Modify by lark.li 20080701 begin
	//strncpy(pInfo->szBig, ParamList[m++].c_str(), sizeof(pInfo->szBig));
	//strncpy(pInfo->szBig, ConvertResString(ParamList[m++].c_str()), sizeof(pInfo->szBig));
	strncpy_s(pInfo->szBig, sizeof(pInfo->szBig), ConvertResString(ParamList[m++].c_str()), _TRUNCATE);
	// End

	pInfo->nBigX = Str2Int(ParamList[m++]);
	pInfo->nBigY = Str2Int(ParamList[m++]);

	// Modify by lark.li 20080701 begin
	//strncpy(pInfo->szHint, ParamList[m++].c_str(), sizeof(pInfo->szHint));
	//strncpy(pInfo->szHint, ConvertResString(ParamList[m++].c_str()), sizeof(pInfo->szHint));
	strncpy_s(pInfo->szHint, sizeof(pInfo->szHint), ConvertResString(ParamList[m++].c_str()), _TRUNCATE);
	// End

	return TRUE;
  }
};

inline CChatIconInfo* GetChatIconInfo(int nIconID)
{
  return (CChatIconInfo*)CChatIconSet::I()->GetRawDataInfo(nIconID);
}
