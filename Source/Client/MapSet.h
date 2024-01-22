#pragma once

#include "TableData.h"

class CMapInfo : public CRawDataInfo
{
  public:
  CMapInfo()
  {
	//strcpy(szName, RES_STRING(CL_LANGUAGE_MATCH_194));
	strncpy_s(szName, sizeof(szName), RES_STRING(CL_LANGUAGE_MATCH_194), _TRUNCATE);
	fLightDir[0] = 1.0;
	fLightDir[1] = 1.0;
	fLightDir[2] = -1.0;

	btLightColor[0] = btLightColor[1] = btLightColor[2] = 255;
	IsShowSwitch										= true;
  }

  char	szName[16];
  int	nInitX;
  int	nInitY;
  float fLightDir[3];
  BYTE	btLightColor[3];
  bool	IsShowSwitch; // 是否要显示切换地图
};

class CMapSet : public CRawDataSet
{
  public:
  static CMapSet* I() { return _Instance; }

  CMapSet(int nIDStart, int nIDCnt) :
	  CRawDataSet(nIDStart, nIDCnt)
  {
	_Instance = this;
	_Init();
  }

  protected:
  static CMapSet* _Instance; // 相当于单键, 把自己记住

  virtual CRawDataInfo* _CreateRawDataArray(int nCnt)
  {
	return new CMapInfo[nCnt];
  }

  virtual void _DeleteRawDataArray()
  {
	delete[](CMapInfo*) _RawDataArray;
  }

  virtual int _GetRawDataInfoSize()
  {
	return sizeof(CMapInfo);
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

	CMapInfo* pInfo = (CMapInfo*)pRawDataInfo;

	// Modify by lark.li 20080701 begin
	//strncpy(pInfo->szName, ParamList[0].c_str(), sizeof(pInfo->szName));
	//strncpy(pInfo->szName, ConvertResString(ParamList[0].c_str()), sizeof(pInfo->szName));
	strncpy_s(pInfo->szName, sizeof(pInfo->szName), ConvertResString(ParamList[0].c_str()), _TRUNCATE);
	// End

	pInfo->IsShowSwitch = Str2Int(ParamList[1]) == 0 ? false : true;

	string strList[3];
	int	   n = Util_ResolveTextLine(ParamList[2].c_str(), strList, 2, ',');
	if(n == 2)
	{
	  pInfo->nInitX = Str2Int(strList[0]);
	  pInfo->nInitY = Str2Int(strList[1]);
	}

	//      LG("map", "Read Map List [%d][%s]\n", pInfo->nID, pInfo->szDataName);

	return TRUE;
  }
};

inline CMapInfo* GetMapInfo(int nMapID)
{
  return (CMapInfo*)CMapSet::I()->GetRawDataInfo(nMapID);
}

inline CMapInfo* GetMapInfo(const char* pszMapName)
{
  return (CMapInfo*)CMapSet::I()->GetRawDataInfo(pszMapName);
}
