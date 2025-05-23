// NpcRecord.cpp Created by knight-gongjian 2004.11.24.
//---------------------------------------------------------

#include "NpcRecord.h"

//---------------------------------------------------------

BOOL CNpcRecordSet::_ReadRawDataInfo(CRawDataInfo* pRawDataInfo, vector<string>& ParamList)
{
  if(ParamList.size() == 0) return FALSE;

  CNpcRecord* pInfo = (CNpcRecord*)pRawDataInfo;

  int	 m = 0, n = 0;
  string strList[8];
  string strLine;

  // npc显示名称
  //_tcsncpy(pInfo->szName, pInfo->szDataName, NPC_MAXSIZE_NAME);
  _tcsncpy_s(pInfo->szName, sizeof(pInfo->szName), pInfo->szDataName, _TRUNCATE);
  //pInfo->szName[NPC_MAXSIZE_NAME - 1] = _TEXT('\0');

  // npc类型信息
  pInfo->sNpcType = Str2Int(ParamList[m++]);

  // npc角色信息
  pInfo->sCharID = Str2Int(ParamList[m++]);

  // 客户端显示颜色类型
  pInfo->byShowType = (BYTE)Str2Int(ParamList[m++]);

  // npc位置信息
  Util_ResolveTextLine(ParamList[m++].c_str(), strList, 8, ',');
  pInfo->dwxPos0 = Str2Int(strList[0]);
  pInfo->dwyPos0 = Str2Int(strList[1]);

  Util_ResolveTextLine(ParamList[m++].c_str(), strList, 8, ',');
  pInfo->dwxPos1 = Str2Int(strList[0]);
  pInfo->dwyPos1 = Str2Int(strList[1]);

  pInfo->sDir	 = Str2Int(ParamList[m++]);
  pInfo->sParam1 = Str2Int(ParamList[m++]);
  pInfo->sParam2 = Str2Int(ParamList[m++]);

  // npc文件名称
  //_tcsncpy(pInfo->szNpc, ParamList[m++].c_str(), NPC_MAXSIZE_NAME);
  _tcsncpy_s(pInfo->szNpc, sizeof(pInfo->szNpc), ParamList[m++].c_str(), _TRUNCATE);
  //pInfo->szNpc[NPC_MAXSIZE_NAME - 1] = _TEXT('\0');

  // npc对话处理
  //_tcsncpy(pInfo->szMsgProc, ParamList[m++].c_str(), NPC_MAXSIZE_MSGPROC);
  _tcsncpy_s(pInfo->szMsgProc, sizeof(pInfo->szMsgProc), ParamList[m++].c_str(), _TRUNCATE);
  //pInfo->szMsgProc[NPC_MAXSIZE_MSGPROC - 1] = _TEXT('\0');

  // npc对话处理
  //_tcsncpy(pInfo->szMisProc, ParamList[m++].c_str(), NPC_MAXSIZE_MSGPROC);
  _tcsncpy_s(pInfo->szMisProc, sizeof(pInfo->szMisProc), ParamList[m++].c_str(), _TRUNCATE);
  //pInfo->szMisProc[NPC_MAXSIZE_MSGPROC - 1] = _TEXT('\0');

  return TRUE;
}
