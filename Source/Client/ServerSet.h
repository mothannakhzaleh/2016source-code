#pragma once
#include "TableData.h"
#include "UIChat.h"

#define MAX_GROUP_GATE	 5
#define MAX_REGION_GROUP 20
#define MAX_REGION		 60

#include <vector>
#include <map>
using namespace std;

typedef vector<string>		ReginList;
typedef map<int, ReginList> ReginListMap;

extern string g_serverset;

// 代表一组服务器
class CServerGroupInfo : public CRawDataInfo
{
  public:
  CServerGroupInfo()
  {
	cValidGateCnt = 0;
  }

  char szGateIP[MAX_GROUP_GATE][16]; // 每组最多5个Gate
  char szRegion[16];				 // 所属的区名
  char cValidGateCnt;
  char szComment[MAX_PATH];
  char szState[16];
};

class CServerSet : public CRawDataSet
{
  public:
  static CServerSet* I() { return _Instance; }

  CServerSet(int nIDStart, int nIDCnt) :
	  CRawDataSet(nIDStart, nIDCnt)
  {
	_Instance = this;
	_Init();

	memset(m_nCurGroupList, 0, sizeof(m_nCurGroupList));
	memset(m_nCurGroupCnt, 0, sizeof(m_nCurGroupCnt));

	ifstream in;
	in.open(g_serverset.c_str());

	for(int i = 0; i < MAX_REGION; i++)
	  m_nCurGroupCnt[i] = 0;

	string strList[2];
	string strLine;
	char   szRegion[256] = {0};
	if(in.is_open())
	{
	  while(!in.eof())
	  {
		in.getline(szRegion, sizeof(szRegion));
		if(strlen(szRegion) == 0) break;

		Util_ResolveTextLine(szRegion, strList, 2, ',');

		int					   ReginIndex = atoi(strList[0].c_str());
		ReginListMap::iterator iter		  = m_ReginListMap.find(ReginIndex);
		if(iter == m_ReginListMap.end())
		{
		  ReginList reginList;
		  reginList.push_back(strList[1]);
		  m_ReginList.push_back(strList[1]);
		  m_ReginListMap.insert(ReginListMap::value_type(ReginIndex, reginList));
		} else
		{
		  ReginList&		  reginList = iter->second;
		  ReginList::iterator ReginIter = reginList.begin();
		  while(ReginIter != reginList.end())
		  {
			if(strList[1] == *ReginIter)
			  break;

			ReginIter++;
		  }

		  if(ReginIter == reginList.end())
		  {
			reginList.push_back(strList[1]);
			m_ReginList.push_back(strList[1]);
		  }
		}

		//if(m_nRegionCnt>=MAX_REGION) break;
	  }
	  in.close();
	}
  }

  public:
  int m_nCurGroupList[MAX_REGION][MAX_REGION_GROUP]; // 放置当前选中的区里面的所有Group
  int m_nCurGroupCnt[MAX_REGION];

  ReginList	   m_ReginList;
  ReginListMap m_ReginListMap;

  protected:
  static CServerSet* _Instance; // 相当于单键, 把自己记住

  virtual CRawDataInfo* _CreateRawDataArray(int nCnt)
  {
	return new CServerGroupInfo[nCnt];
  }

  virtual void _DeleteRawDataArray()
  {
	delete[](CServerGroupInfo*) _RawDataArray;
  }

  virtual int _GetRawDataInfoSize()
  {
	return sizeof(CServerGroupInfo);
  }

  virtual void* _CreateNewRawData(CRawDataInfo* pInfo)
  {
	return NULL;
  }

  virtual void _DeleteRawData(CRawDataInfo* pInfo)
  {
	//SAFE_DELETE(pInfo->pData);
  }

  virtual BOOL _ReadRawDataInfo(CRawDataInfo* pRawDataInfo, vector<string>& ParamList)
  {
	CServerGroupInfo* pInfo = (CServerGroupInfo*)pRawDataInfo;

	//strcpy(pInfo->szRegion, ParamList[0].c_str());
	strncpy_s(pInfo->szRegion, sizeof(pInfo->szRegion), ParamList[0].c_str(), _TRUNCATE);
	for(int i = 0; i < MAX_GROUP_GATE; i++) // 读入5个可能的gate ip
	{
	  //strcpy(pInfo->szGateIP[i], ParamList[i + 1].c_str());
	  strncpy_s(pInfo->szGateIP[i], sizeof(pInfo->szGateIP[i]), ParamList[i + 1].c_str(), _TRUNCATE);
	  if(strcmp(pInfo->szGateIP[i], "0") == 0)
	  {
		break;
	  }
	  pInfo->cValidGateCnt++;
	}

	/*strcpy( pInfo->szComment, ParamList[6].c_str() );
		strcpy( pInfo->szState, ParamList[7].c_str() );*/
	strncpy_s(pInfo->szComment, MAX_PATH, ParamList[6].c_str(), _TRUNCATE);
	strncpy_s(pInfo->szState, 16, ParamList[7].c_str(), _TRUNCATE);

	return TRUE;
  }

  virtual void _ProcessRawDataInfo(CRawDataInfo* pRawDataInfo)
  {
	CServerGroupInfo* pInfo = (CServerGroupInfo*)pRawDataInfo;

	for(size_t i = 0; i < m_ReginList.size(); i++)
	{
	  if(m_ReginList[i] == pInfo->szRegion) // 区名符合
	  {
		m_nCurGroupList[i][m_nCurGroupCnt[i]] = pInfo->nID;
		m_nCurGroupCnt[i]++;
		break;
	  }
	}
  }
};

// 通过组编号, 取得组的GateIP信息
inline CServerGroupInfo* GetServerGroupInfo(int nGroupID)
{
  return (CServerGroupInfo*)CServerSet::I()->GetRawDataInfo(nGroupID);
}

// 通过组名字, 取得组的GateIP信息
inline CServerGroupInfo* GetServerGroupInfo(const char* pszGroupName)
{
  return (CServerGroupInfo*)CServerSet::I()->GetRawDataInfo(pszGroupName);
}

inline ReginListMap& GetReginListMap()
{
  return CServerSet::I()->m_ReginListMap;
}

inline int GetCurServerGroupCnt(int nRegionNo)
{
  return CServerSet::I()->m_nCurGroupCnt[nRegionNo];
}

inline const char* GetCurServerGroupName(int nRegionNo, int nGroupNo)
{
  if(nGroupNo >= GetCurServerGroupCnt(nRegionNo)) return 0;

  int nNo = CServerSet::I()->m_nCurGroupList[nRegionNo][nGroupNo];
  return GetServerGroupInfo(nNo)->szDataName;
}

// 增加游戏区域信息 Michael Chen 2005-06-01
inline int GetRegionCnt()
{
  return (int)CServerSet::I()->m_ReginList.size();
}

inline const char* GetCurRegionName(int nRegionNo)
{
  if(nRegionNo < 0 && nRegionNo > GetRegionCnt())
	return 0;

  return CServerSet::I()->m_ReginList[nRegionNo].c_str();
}

inline int GetReginIndex(const char* ReginText)
{
  ReginList& reginList = CServerSet::I()->m_ReginList;
  for(int index = 0; index < (int)reginList.size(); index++)
  {
	if(reginList[index] == ReginText)
	  return index;
  }

  return -1;
}

// 通过组编号, 选中一个GateIP
inline const char* SelectGroupIP(int nRegionNo, int nGroupNo)
{
  //	LG("connect", "Select Region %d Group %d\n", nRegionNo, nGroupNo);
  if(nGroupNo >= GetCurServerGroupCnt(nRegionNo))
  {
	LG("connect", RES_STRING(CL_LANGUAGE_MATCH_387), GetCurServerGroupCnt(nRegionNo), nGroupNo);
	return 0;
  }

  int nNo = CServerSet::I()->m_nCurGroupList[nRegionNo][nGroupNo];
  g_stUIChat._PictureCChat.setServerID(nNo); //add by guojiangang 20090211
  CServerGroupInfo* pGroup = GetServerGroupInfo(nNo);
  if(!pGroup)
  {
	LG("connect", "Group Not Found!\n");
	return NULL;
  }

  if(pGroup->cValidGateCnt == 0)
  {
	LG("connect", RES_STRING(CL_LANGUAGE_MATCH_388));
	return NULL;
  }

  srand(GetTickCount());

  int nGateNo = rand() % (int)(pGroup->cValidGateCnt);

  //	LG("connect", RES_STRING(CL_LANGUAGE_MATCH_389), pGroup->szDataName, nGateNo, pGroup->szGateIP[nGateNo], pGroup->cValidGateCnt);

  return pGroup->szGateIP[nGateNo];
}

inline const char* GetGroupComment(int nRegionNo, int nGroupNo)
{
  if(nGroupNo >= GetCurServerGroupCnt(nRegionNo))
	return "";

  int				nNo	   = CServerSet::I()->m_nCurGroupList[nRegionNo][nGroupNo];
  CServerGroupInfo* pGroup = GetServerGroupInfo(nNo);
  if(!pGroup)
	return "";

  return pGroup->szComment;
}

inline const char* GetGroupState(int nRegionNo, int nGroupNo)
{
  if(nGroupNo >= GetCurServerGroupCnt(nRegionNo))
	return "";

  int				nNo	   = CServerSet::I()->m_nCurGroupList[nRegionNo][nGroupNo];
  CServerGroupInfo* pGroup = GetServerGroupInfo(nNo);
  if(!pGroup)
	return "";

  return pGroup->szState;
}

/*

// 通过组名字, 选中一个GateIP
inline const char *SelectGroupIP(const char *pszGroupName)
{
    LG("connect", "Select Group [%s]\n", pszGroupName);
	CServerGroupInfo *pGroup = GetServerGroupInfo(pszGroupName);
	if(!pGroup) 
	{
		LG("connect", "Group Not Found!\n");
		return NULL;
	}

	if(pGroup->cValidGateCnt==0) 
	{
		LG("connect", "msg该服务器组有效GateIP数量为0, 无法选择Gate!\n");
		return NULL;
	}
	
	srand(GetTickCount());
	
	int nNo = rand()%(int)(pGroup->cValidGateCnt); 

	LG("connect", "随机选中该服务器组Gate[%d], ip = %s\n", nNo, pGroup->szGateIP[nNo]);
		
	return pGroup->szGateIP[nNo];
}*/
