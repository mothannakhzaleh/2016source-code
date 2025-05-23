//=============================================================================
// FileName: CommFunc.cpp
// Creater: Jerry Li
// Date: 2005.02.23
// Comment:
//	2005.4.28	Arcol	add the text filter manager class: CTextFilter
//=============================================================================

#include "CommFunc.h"
#include "GameCommon.h"
#include "MyMemory.h"

const char* CommonRes::GetJobName(int index)
{
  switch(index)
  {
  case 0:
	return RES_STRING(CO_COMMFUNC_CPP_00001);
  case 1:
	return RES_STRING(CO_COMMFUNC_CPP_00002);
  case 2:
	return RES_STRING(CO_COMMFUNC_CPP_00003);
  case 3:
	return RES_STRING(CO_COMMFUNC_CPP_00004);
  case 4:
	return RES_STRING(CO_COMMFUNC_CPP_00005);
  case 5:
	return RES_STRING(CO_COMMFUNC_CPP_00006);
  case 6:
	return RES_STRING(CO_COMMFUNC_CPP_00007);
  case 7:
	return RES_STRING(CO_COMMFUNC_CPP_00008);
  case 8:
	return RES_STRING(CO_COMMFUNC_CPP_00009);
  case 9:
	return RES_STRING(CO_COMMFUNC_CPP_00010);
  case 10:
	return RES_STRING(CO_COMMFUNC_CPP_00011);
  case 11:
	return RES_STRING(CO_COMMFUNC_CPP_00012);
  case 12:
	return RES_STRING(CO_COMMFUNC_CPP_00013);
  case 13:
	return RES_STRING(CO_COMMFUNC_CPP_00014);
  case 14:
	return RES_STRING(CO_COMMFUNC_CPP_00015);
  case 15:
	return RES_STRING(CO_COMMFUNC_CPP_00016);
  case 16:
	return RES_STRING(CO_COMMFUNC_CPP_00017);
  case 17:
	return RES_STRING(CO_COMMFUNC_CPP_00018);
  case 18:
	return RES_STRING(CO_COMMFUNC_CPP_00019);
  default:
	return RES_STRING(CO_COMMFUNC_CPP_00001);
  }
}

//const char	*g_szJobName[MAX_JOB_TYPE] =
//{\
//RES_STRING(CO_COMMFUNC_CPP_00001),\
//RES_STRING(CO_COMMFUNC_CPP_00002),\
//RES_STRING(CO_COMMFUNC_CPP_00003),\
//RES_STRING(CO_COMMFUNC_CPP_00004),\
//RES_STRING(CO_COMMFUNC_CPP_00005),\
//RES_STRING(CO_COMMFUNC_CPP_00006),\
//RES_STRING(CO_COMMFUNC_CPP_00007),\
//RES_STRING(CO_COMMFUNC_CPP_00008),\
//RES_STRING(CO_COMMFUNC_CPP_00009),\
//RES_STRING(CO_COMMFUNC_CPP_00010),\
//RES_STRING(CO_COMMFUNC_CPP_00011),\
//RES_STRING(CO_COMMFUNC_CPP_00012),\
//RES_STRING(CO_COMMFUNC_CPP_00013),\
//RES_STRING(CO_COMMFUNC_CPP_00014),\
//RES_STRING(CO_COMMFUNC_CPP_00015),\
//RES_STRING(CO_COMMFUNC_CPP_00016),\
//RES_STRING(CO_COMMFUNC_CPP_00017),\
//RES_STRING(CO_COMMFUNC_CPP_00018),\
//RES_STRING(CO_COMMFUNC_CPP_00019),\
//};

const char* CommonRes::GetCityName(int index)
{
  switch(index)
  {
  case 0:
	return RES_STRING(CO_COMMFUNC_CPP_00020);
  case 1:
	return RES_STRING(CO_COMMFUNC_CPP_00021);
  case 2:
	return RES_STRING(CO_COMMFUNC_CPP_00022);
  case 3:
	return RES_STRING(CO_COMMFUNC_CPP_00023);
  default:
	return RES_STRING(CO_COMMFUNC_CPP_00020);
  }
}

//const char	*g_szCityName[defMAX_CITY_NUM] =
//{\
//RES_STRING(CO_COMMFUNC_CPP_00020),\
//RES_STRING(CO_COMMFUNC_CPP_00021),\
//RES_STRING(CO_COMMFUNC_CPP_00022),\
//RES_STRING(CO_COMMFUNC_CPP_00023),\
//};

const long g_PartIdRange[PLAY_NUM][enumEQUIP_NUM + 1][2] =
	{
		/*开始编号*/ /*结束编号*/
					 //卡西斯
		/*头*/ 0,
		0,
		/*HEAD 脸形*/ 0,
		0,
		/*BODY 身体*/ 0,
		0,
		/*GLOVE手套*/ 0,
		0,
		/*SHOES鞋子*/ 0,
		0,
		/*NECK 脖子*/ 0,
		0,
		/*LHAND左手*/ 0,
		0,
		/*HAND1手饰*/ 0,
		0,
		/*HAND2手饰*/ 0,
		0,
		/*RHAND右手*/ 0,
		0,
		/*FACE 头发*/ 0,
		0,

		//蓝祺
		/*头*/ 0,
		0,
		/*HEAD 脸形*/ 0,
		0,
		/*BODY 身体*/ 0,
		0,
		/*GLOVE手套*/ 0,
		0,
		/*SHOES鞋子*/ 0,
		0,
		/*NECK 脖子*/ 0,
		0,
		/*LHAND左手*/ 0,
		0,
		/*HAND1手饰*/ 0,
		0,
		/*HAND2手饰*/ 0,
		0,
		/*RHAND右手*/ 0,
		0,
		/*FACE 头发*/ 0,
		0,

		//菲利尔
		/*头*/ 0,
		0,
		/*HEAD 脸形*/ 0,
		0,
		/*BODY 身体*/ 0,
		0,
		/*GLOVE手套*/ 0,
		0,
		/*SHOES鞋子*/ 0,
		0,
		/*NECK 脖子*/ 0,
		0,
		/*LHAND左手*/ 0,
		0,
		/*HAND1手饰*/ 0,
		0,
		/*HAND2手饰*/ 0,
		0,
		/*RHAND右手*/ 0,
		0,
		/*FACE 头发*/ 0,
		0,

		//艾米
		/*头*/ 0,
		0,
		/*HEAD 脸形*/ 0,
		0,
		/*BODY 身体*/ 0,
		0,
		/*GLOVE手套*/ 0,
		0,
		/*SHOES鞋子*/ 0,
		0,
		/*NECK 脖子*/ 0,
		0,
		/*LHAND左手*/ 0,
		0,
		/*HAND1手饰*/ 0,
		0,
		/*HAND2手饰*/ 0,
		0,
		/*RHAND右手*/ 0,
		0,
		/*FACE 头发*/ 0,
		0,
};

bool g_IsValidLook(int nType, int nPart, long nValue)
{
  if((nType >= 1 && nType <= PLAY_NUM) && (nPart >= 0 && nPart < enumEQUIP_NUM + 1))
  {
	/*return	(nValue >= g_PartIdRange[nType-1][nPart][0]) && 
				(nValue <= g_PartIdRange[nType-1][nPart][1]);*/
	return true;
  }
  return false;
}

BOOL IsDist(int x1, int y1, int x2, int y2, DWORD dwDist)
{
  DWORD dwxDist = (x1 - x2) * (x1 - x2);
  DWORD dwyDist = (y1 - y2) * (y1 - y2);
  dwDist *= dwDist;
  return (dwxDist + dwyDist < dwDist * 10000);
}

const char* g_GetAreaName(int nValue)
{
  switch(nValue)
  {
  case 1: return RES_STRING(CO_COMMFUNC_CPP_00024);	 //"陆地/海洋";
  case 2: return RES_STRING(CO_COMMFUNC_CPP_00025);	 //"非战斗区";
  case 3: return RES_STRING(CO_COMMFUNC_CPP_00026);	 //"非PK区";
  case 4: return RES_STRING(CO_COMMFUNC_CPP_00027);	 //"桥";
  case 5: return RES_STRING(CO_COMMFUNC_CPP_00028);	 //"禁怪区";
  case 6: return RES_STRING(CO_COMMFUNC_CPP_00029);	 //"矿区";
  default: return RES_STRING(CO_COMMFUNC_CPP_00030); //"未知";
  }
}

inline bool g_IsRealItemID(int nItemID)
{
  if(nItemID > 0 && nItemID != enumEQUIP_BOTH_HAND && nItemID != enumEQUIP_TOTEM)
	return true;
  return false;
}

static inline int GetItemType(int nItemID)
{
  if(g_IsRealItemID(nItemID))
  {
	CItemRecord* pItem = GetItemRecordInfo(nItemID);
	if(pItem)
	{
	  return pItem->sType;
	}

	return -1;
  }

  return nItemID;
}

int g_GetItemSkill(int nLeftItemID, int nRightItemID)
{
  int nRightType = GetItemType(nRightItemID);
  int nLeftType	 = GetItemType(nLeftItemID);

  const int nLRSkill[][3] = {
	  // 双手
	  0, 0, 25,
	  1, 1, 38,
	  11, 1, 28,
	  9999, 2, 29,
	  9999, 6, 33};

  // 右手
  const int nRSkill[][3] = {
	  -1, 1, 28,
	  -1, 4, 31,
	  -1, 5, 32,
	  -1, 7, 34,
	  -1, 8, 35,
	  -1, 9, 36,
	  -1, 10, 37,
	  -1, 18, 200,
	  -1, 19, 201};

  // 左手
  const int nLSkill[][3] = {
	  11, -1, 25,
	  3, -1, 30};

  const int nLRCount = sizeof(nLRSkill) / sizeof(nLRSkill[0]);
  for(int i = 0; i < nLRCount; i++)
  {
	if(nRightType == nLRSkill[i][1] && nLeftType == nLRSkill[i][0])
	{
	  return nLRSkill[i][2];
	}
  }

  const int nRCount = sizeof(nRSkill) / sizeof(nRSkill[0]);
  for(int i = 0; i < nRCount; i++)
  {
	if(nRightType == nRSkill[i][1])
	{
	  return nRSkill[i][2];
	}
  }

  const int nLCount = sizeof(nLSkill) / sizeof(nLSkill[0]);
  for(int i = 0; i < nLCount; i++)
  {
	if(nLeftType == nLSkill[i][0])
	{
	  return nLSkill[i][2];
	}
  }
  return -1;
}

int g_IsUseSkill(stNetChangeChaPart* pSEquip, int nSkillID)
{
  CSkillRecord* p = GetSkillRecordInfo(nSkillID);
  if(!p)
  {
	return -1;
  }

  int nLHandID = pSEquip->SLink[enumEQUIP_LHAND].sID;
  int nRHandID = pSEquip->SLink[enumEQUIP_RHAND].sID;
  int nBodyID  = pSEquip->SLink[enumEQUIP_BODY].sID;
  if(!pSEquip->SLink[enumEQUIP_LHAND].IsValid())
	nLHandID = 0;
  if(!pSEquip->SLink[enumEQUIP_RHAND].IsValid())
	nRHandID = 0;
  if(!pSEquip->SLink[enumEQUIP_BODY].IsValid())
	nBodyID = 0;

  short sLHandType = 0, sRHandType = 0, sBodyType = 0;

  CItemRecord* pItem = GetItemRecordInfo(nLHandID);
  if(pItem) sLHandType = pItem->sType;

  pItem = GetItemRecordInfo(nRHandID);
  if(pItem) sRHandType = pItem->sType;

  pItem = GetItemRecordInfo(nBodyID);
  if(pItem) sBodyType = pItem->sType;

  bool IsLeft  = false;
  bool IsRight = false;
  bool IsBody  = false;
  bool IsConch = false;

  // 左手
  for(int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
  {
	if(p->sItemNeed[0][i][0] == cchSkillRecordKeyValue)
	  break;

	if(p->sItemNeed[0][i][0] == enumSKILL_ITEM_NEED_TYPE)
	{
	  if(p->sItemNeed[0][i][1] == -1 || p->sItemNeed[0][i][1] == sLHandType)
	  {
		IsLeft = true;
		break;
	  }
	} else if(p->sItemNeed[0][i][0] == enumSKILL_ITEM_NEED_ID)
	{
	  if(p->sItemNeed[0][i][1] == nLHandID)
	  {
		IsLeft = true;
		break;
	  }
	}
  }
  if(!IsLeft)
	return 0;

  // 右手
  for(int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
  {
	if(p->sItemNeed[1][i][0] == cchSkillRecordKeyValue)
	  break;

	if(p->sItemNeed[1][i][0] == enumSKILL_ITEM_NEED_TYPE)
	{
	  if(p->sItemNeed[1][i][1] == -1 || p->sItemNeed[1][i][1] == sRHandType)
	  {
		IsRight = true;
		break;
	  }
	} else if(p->sItemNeed[1][i][0] == enumSKILL_ITEM_NEED_ID)
	{
	  if(p->sItemNeed[1][i][1] == nRHandID)
	  {
		IsRight = true;
		break;
	  }
	}
  }
  if(!IsRight)
	return 0;

  // 身体
  for(int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
  {
	if(p->sItemNeed[2][i][0] == cchSkillRecordKeyValue)
	  break;

	if(p->sItemNeed[2][i][0] == enumSKILL_ITEM_NEED_TYPE)
	{
	  if(p->sItemNeed[2][i][1] == -1 || p->sItemNeed[2][i][1] == sBodyType)
	  {
		IsBody = true;
		break;
	  }
	} else if(p->sItemNeed[2][i][0] == enumSKILL_ITEM_NEED_ID)
	{
	  if(p->sItemNeed[2][i][1] == nBodyID)
	  {
		IsBody = true;
		break;
	  }
	}
  }
  if(!IsBody)
	return 0;

  // 贝壳道具
  for(int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
  {
	if(p->sConchNeed[i][0] == cchSkillRecordKeyValue)
	  break;

	if(p->sConchNeed[i][0] == -1) // 不需要贝壳
	{
	  IsConch = true;
	  break;
	}
	if(!pSEquip->SLink[p->sConchNeed[i][0]].IsValid())
	  continue;
	pItem = GetItemRecordInfo(pSEquip->SLink[p->sConchNeed[i][0]].sID);
	if(pItem)
	{
	  if(p->sConchNeed[i][1] == enumSKILL_ITEM_NEED_TYPE)
	  {
		if(pItem->sType == p->sConchNeed[i][2])
		{
		  IsConch = true;
		  break;
		}
	  } else if(p->sConchNeed[i][1] == enumSKILL_ITEM_NEED_ID)
	  {
		if(pItem->lID == p->sConchNeed[i][2])
		{
		  IsConch = true;
		  break;
		}
	  }
	}
  }
  if(!IsConch)
	return 0;

  return 1;
}

//=============================================================================
// 是否正确的技能目标
// nTChaCtrlType 目标的控制类型（EChaCtrlType），
// bTIsDie 目标是否死亡，
// bTChaBeSkilled 目标是否能被使用技能，
// nTChaArea 目标的区域（EAreaMask），
// nSSkillObjType 源技能的目标类型（ESkillObjType），
// nSSkillObjHabitat 源技能的区域类型（ESkillTarHabitatType），
// nSSkillEffType 源技能的效果类型（ESkillEffType），
// bIsTeammate 源和目标是否队友关系。
// bIsTeammate 源和目标是否友方关系。
// bIsSelf 源和目标是否相同
//=============================================================================
int g_IsRightSkillTar(int nTChaCtrlType, bool bTIsDie, bool bTChaBeSkilled, int nTChaArea,
					  int nSChaCtrlType, int nSSkillObjType, int nSSkillObjHabitat, int nSSkillEffType,
					  bool bIsTeammate, bool bIsFriend, bool bIsSelf)
{
  bool bTIsPlayer = g_IsPlyCtrlCha(nTChaCtrlType);

  if(g_IsNPCCtrlCha(nTChaCtrlType)) // NPC
	return enumESKILL_FAILD_NPC;
  if(!bTChaBeSkilled) // 不能被使用技能
	return enumESKILL_FAILD_NOT_SKILLED;

  if(nTChaArea & enumAREA_TYPE_NOT_FIGHT) // 安全区
  {
	if(nSSkillEffType != enumSKILL_EFF_HELPFUL)
	  return enumESKILL_FAILD_SAFETY_BELT;
  }
  if(nTChaArea & enumSKILL_TAR_LAND || nTChaArea & enumAREA_TYPE_BRIDGE) // 陆地
  {
	if(nSSkillObjHabitat == enumSKILL_TAR_SEA)
	  return enumESKILL_FAILD_NOT_LAND;
  } else if(!(nTChaArea & enumSKILL_TAR_LAND)) // 海洋
  {
	if(nSSkillObjHabitat == enumSKILL_TAR_LAND)
	  return enumESKILL_FAILD_NOT_SEA;
  }

  if(!bIsSelf) // 自身
  {
	if(nSSkillObjType == enumSKILL_TYPE_SELF)
	  return enumESKILL_FAILD_ONLY_SELF;
	else if(nSSkillObjType == enumSKILL_TYPE_EXCEPT_SELF) // 除了自己以外的所有角色和怪物
	{
	  return enumESKILL_SUCCESS;
	}
  } else
  {
	if(nSSkillObjType == enumSKILL_TYPE_EXCEPT_SELF)
	  return enumESKILL_FAILD_SELF;
  }

  if(bTIsDie) // 尸体
  {
	if(!bTIsPlayer)
	  return enumESKILL_FAILD_ONLY_DIEPLY;
	if(nSSkillObjType != enumSKILL_TYPE_PLAYER_DIE)
	  return enumESKILL_FAILD_ONLY_DIEPLY;
  }

  if(nTChaCtrlType == enumCHACTRL_MONS_TREE) // 树
  {
	if(nSSkillObjType != enumSKILL_TYPE_TREE)
	  return enumESKILL_FAILD_ESP_MONS;
  } else if(nTChaCtrlType == enumCHACTRL_MONS_MINE) // 矿
  {
	if(nSSkillObjType != enumSKILL_TYPE_MINE)
	  return enumESKILL_FAILD_ESP_MONS;
  } else if(nTChaCtrlType == enumCHACTRL_MONS_FISH) // 鱼
  {
	if(nSSkillObjType != enumSKILL_TYPE_FISH)
	  return enumESKILL_FAILD_ESP_MONS;
  } else if(nTChaCtrlType == enumCHACTRL_MONS_DBOAT) // 沉船
  {
	if(nSSkillObjType != enumSKILL_TYPE_SALVAGE)
	  return enumESKILL_FAILD_ESP_MONS;
  }

  if(nSSkillObjType == enumSKILL_TYPE_REPAIR)
  {
	if(nTChaCtrlType != enumCHACTRL_MONS_REPAIRABLE)
	  return enumESKILL_FAILD_ESP_MONS;
  }
  if(nSSkillObjType == enumSKILL_TYPE_TREE)
  {
	if(nTChaCtrlType != enumCHACTRL_MONS_TREE)
	  return enumESKILL_FAILD_ESP_MONS;
  } else if(nSSkillObjType == enumSKILL_TYPE_MINE)
  {
	if(nTChaCtrlType != enumCHACTRL_MONS_MINE)
	  return enumESKILL_FAILD_ESP_MONS;
  } else if(nSSkillObjType == enumSKILL_TYPE_FISH)
  {
	if(nTChaCtrlType != enumCHACTRL_MONS_FISH)
	  return enumESKILL_FAILD_ESP_MONS;
  } else if(nSSkillObjType == enumSKILL_TYPE_SALVAGE)
  {
	if(nTChaCtrlType != enumCHACTRL_MONS_DBOAT)
	  return enumESKILL_FAILD_ESP_MONS;
  }

  if(nSSkillObjType == enumSKILL_TYPE_ENEMY)
  {
	if(bIsFriend)
	  return enumESKILL_FAILD_FRIEND;
  } else if(nSSkillObjType == enumSKILL_TYPE_TEAM)
  {
	if(!bIsTeammate)
	  return enumESKILL_FAILD_NOT_FRIEND;
  } else if(nSSkillObjType == enumSKILL_TYPE_ALL)
  {
	if(nSSkillEffType == enumSKILL_EFF_HELPFUL) // 有益技能，只对友方有效
	{
	  if(!bIsFriend)
		return enumESKILL_FAILD_NOT_FRIEND;
	} else
	{
	  if(bIsFriend)
		return enumESKILL_FAILD_FRIEND;
	}
  }

  return enumESKILL_SUCCESS;
}

//------------------------------------------------------------------------
//	CTextFilter 类定义
//------------------------------------------------------------------------

BYTE			   CTextFilter::m_NowSign[eTableMax][8];
vector<string>	   CTextFilter::m_FilterTable[eTableMax];
static CTextFilter bin;

CTextFilter::CTextFilter()
{
  //setlocale(LC_CTYPE,"chs");
  ZeroMemory(m_NowSign, sizeof(m_NowSign));
}

CTextFilter::~CTextFilter()
{
}

bool CTextFilter::Add(const eFilterTable eTable, const char* szFilterText)
{
  if(!szFilterText) return false;
  if(strlen(szFilterText) <= 0) return false;
  m_FilterTable[eTable].push_back(szFilterText); //释放内存 Modify by Waiting 2009-06-18
  for(int i = 0; i < (int)strlen(szFilterText); i++)
  {
	BYTE j = szFilterText[i] / 32;
	int	 n = (i + j) % 8;
	m_NowSign[eTable][n] += j + i;
  }
  return true;
}

bool CTextFilter::IsLegalText(const eFilterTable eTable, const string strText)
{
  vector<string>::iterator iter;
  for(iter = m_FilterTable[eTable].begin(); iter != m_FilterTable[eTable].end(); iter++)
  {
	if(!bCheckLegalText(strText, &(*iter)))
	{
	  return false;
	}
  }
  return true;
}

bool CTextFilter::Filter(const eFilterTable eTable, string& strText)
{
  bool					   ret = false;
  vector<string>::iterator iter;
  for(iter = m_FilterTable[eTable].begin(); iter != m_FilterTable[eTable].end(); iter++)
  {
	if(ReplaceText(strText, &(*iter)))
	{
	  ret = true;
	}
  }
  return ret;
}

bool CTextFilter::ReplaceText(string& strText, const string* pstrFilterText)
{
  bool ret = false;
  //_W64 nPos=strText.find(*pstrFilterText);
  string::size_type nPos = strText.find(*pstrFilterText);

  static const basic_string<char>::size_type errPos = -1;
  while(nPos != errPos)
  {
	if(_ismbslead((unsigned char*)pstrFilterText->c_str(), (unsigned char*)pstrFilterText->c_str()) ==
	   _ismbslead((unsigned char*)strText.c_str(), (unsigned char*)&strText[nPos]))
	{
	  strText.replace(nPos, pstrFilterText->length(), pstrFilterText->length(), '*');
	  ret = true;
	} else
	{
	  nPos++;
	}
	nPos = strText.find(*pstrFilterText, nPos + pstrFilterText->length());
  }
  return ret;
}

bool CTextFilter::bCheckLegalText(const string& strText, const string* pstrIllegalText)
{
  //_W64 nPos=strText.find(*pstrIllegalText);
  string::size_type							 nPos	= strText.find(*pstrIllegalText);
  static const basic_string<char>::size_type errPos = -1;
  while(nPos != errPos)
  {
	if(_ismbslead((unsigned char*)pstrIllegalText->c_str(), (unsigned char*)pstrIllegalText->c_str()) ==
	   _ismbslead((unsigned char*)strText.c_str(), (unsigned char*)&strText[nPos]))
	{
	  return false;
	} else
	{
	  nPos++;
	}
	nPos = strText.find(*pstrIllegalText, nPos + pstrIllegalText->length());
  }
  return true;
}

bool CTextFilter::LoadFile(const char* szFileName, const eFilterTable eTable)
{
  if(!szFileName) return false;
  ifstream filterTxt(szFileName, ios::in);
  if(!filterTxt.is_open()) return false;
  char buf[500] = {0};
  filterTxt.getline(buf, 500);
  while(!filterTxt.fail())
  {
	//char *pText=new char[strlen(buf)+2];
	char* pText = new char[strlen(buf) + 1];
	//strcpy(pText,buf);
	strncpy_s(pText, strlen(buf) + 1, buf, _TRUNCATE);

	//strcpy(pText,ConvertResString(buf));
	m_FilterTable[eTable].push_back(pText);
	filterTxt.getline(buf, 500);
  }
  filterTxt.close();
  return true;
}

BYTE* CTextFilter::GetNowSign(const eFilterTable eTable)
{
  return m_NowSign[eTable];
}

// 外观数据转换为字符串
char* LookData2String(const stNetChangeChaPart* pLook, char* szLookBuf, int nLen, bool bNewLook)
{
  if(!pLook || !szLookBuf) return NULL;
  if(bNewLook && !g_IsValidLook(pLook->sTypeID, enumEQUIP_NUM, pLook->sHairID))
	return NULL;

  __int64 lnCheckSum = 0;
  char	  szData[512];
  int	  nBufLen = 0, nDataLen;
  szLookBuf[0]	  = '\0';

  /*	2008-8-7	yangyinyu	change	begin!
	sprintf(szData, "%d#", defLOOK_CUR_VER);
	*/
  //strcpy(szData, "112#");
  strncpy_s(szData, sizeof(szData), "112#", _TRUNCATE);
  //	2008-8-7	yangyinyu	change	end!
  nDataLen = (int)strlen(szData);
  if(nBufLen + nDataLen >= nLen) return NULL;
  //strcat(szLookBuf, szData);
  strncat_s(szLookBuf, nLen, szData, _TRUNCATE);
  nBufLen += nDataLen;

  //sprintf(szData, "%d,%d", pLook->sTypeID, pLook->sHairID);
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d,%d", pLook->sTypeID, pLook->sHairID);
  nDataLen = (int)strlen(szData);
  if(nBufLen + nDataLen >= nLen) return NULL;
  //strcat(szLookBuf, szData);
  strncat_s(szLookBuf, nLen, szData, _TRUNCATE);
  nBufLen += nDataLen;
  lnCheckSum += (pLook->sTypeID + pLook->sHairID);

  SItemGrid* pGridCont;
  for(int i = 0; i < enumEQUIP_NUM; i++)
  {
	pGridCont = (SItemGrid*)pLook->SLink + i;
	if(bNewLook && !g_IsValidLook(pLook->sTypeID, i, pGridCont->sID)) return NULL; // 数据不合法

	/*	2008-8-7	yangyinyu	change	begin!
		sprintf(szData, ";%d,%d,%d,%d,%d,%d,%d",
			pGridCont->sID, pGridCont->sNum,
			pGridCont->sEndure[0], pGridCont->sEndure[1], pGridCont->sEnergy[0], pGridCont->sEnergy[1], pGridCont->chForgeLv);
			*/
	//sprintf(szData, ";%d,%d,%d,%d,%d,%d,%d,%d",
	_snprintf_s(szData, sizeof(szData), _TRUNCATE, ";%d,%d,%d,%d,%d,%d,%d,%d",
				pGridCont->dwDBID, pGridCont->sID, pGridCont->sNum,
				pGridCont->sEndure[0], pGridCont->sEndure[1], pGridCont->sEnergy[0], pGridCont->sEnergy[1], pGridCont->chForgeLv);
	//	2008-8-7	yangyinyu	change	end!
	nDataLen = (int)strlen(szData);
	if(nBufLen + nDataLen >= nLen) return NULL;
	//strcat(szLookBuf, szData);
	strncat_s(szLookBuf, nLen, szData, _TRUNCATE);
	nBufLen += nDataLen;

	/*	2008-8-7	yangyinyu	change	begin!
		lnCheckSum += (pGridCont->sID + pGridCont->sNum + pGridCont->sEndure[0] + pGridCont->sEndure[1] + pGridCont->sEnergy[0] + pGridCont->sEnergy[1] + pGridCont->chForgeLv);
		*/
	lnCheckSum += (pGridCont->dwDBID + pGridCont->sID + pGridCont->sNum + pGridCont->sEndure[0] + pGridCont->sEndure[1] + pGridCont->sEnergy[0] + pGridCont->sEnergy[1] + pGridCont->chForgeLv);
	//	2008-8-7	yangyinyu	change	end!
	for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
	{
	  //sprintf(szData, ",%d", pGridCont->GetDBParam(m));
	  _snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d", pGridCont->GetDBParam(m));
	  nDataLen = (int)strlen(szData);
	  if(nBufLen + nDataLen >= nLen) return NULL;
	  //strcat(szLookBuf, szData);
	  strncat_s(szLookBuf, nLen, szData, _TRUNCATE);
	  nBufLen += nDataLen;
	  lnCheckSum += pGridCont->GetDBParam(m);
	}
	if(pGridCont->IsInstAttrValid())
	{
	  nDataLen = 2;
	  if(nBufLen + nDataLen >= nLen) return NULL;
	  //strcat(szLookBuf, ",1");
	  strncat_s(szLookBuf, nLen, ",1", _TRUNCATE);
	  nBufLen += nDataLen;

	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		//sprintf(szData, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);
		_snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);
		nDataLen = (int)strlen(szData);
		if(nBufLen + nDataLen >= nLen) return NULL;
		//strcat(szLookBuf, szData);
		strncat_s(szLookBuf, nLen, szData, _TRUNCATE);
		nBufLen += nDataLen;
		lnCheckSum += pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1];
	  }
	} else
	{
	  nDataLen = 2;
	  if(nBufLen + nDataLen >= nLen) return NULL;
	  //strcat(szLookBuf, ",0");
	  strncat_s(szLookBuf, nLen, ",0", _TRUNCATE);
	  nBufLen += nDataLen;
	}
  }
  //sprintf(szData, ";%d", lnCheckSum);
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, ";%lld", lnCheckSum);
  nDataLen = (int)strlen(szData);
  if(nBufLen + nDataLen >= nLen) return NULL;
  //strcat(szLookBuf, szData);
  strncat_s(szLookBuf, nLen, szData, _TRUNCATE);
  nBufLen += nDataLen;

  return szLookBuf;
}

const char* LookData2StringEx(const stNetChangeChaPart* pLook, StringPoolL& lookString, int index, bool bNewLook)
{
  if(!pLook) return NULL;
  if(bNewLook && !g_IsValidLook(pLook->sTypeID, enumEQUIP_NUM, pLook->sHairID))
	return NULL;

  __int64 lnCheckSum = 0;
  char	  szData[512];

  lookString[index] = "112#";

  _snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d,%d", pLook->sTypeID, pLook->sHairID);
  lookString[index] += szData;

  lnCheckSum += (pLook->sTypeID + pLook->sHairID);

  SItemGrid* pGridCont;
  for(int i = 0; i < enumEQUIP_NUM; i++)
  {
	pGridCont = (SItemGrid*)pLook->SLink + i;
	if(bNewLook && !g_IsValidLook(pLook->sTypeID, i, pGridCont->sID)) return NULL; // 数据不合法

	_snprintf_s(szData, sizeof(szData), _TRUNCATE, ";%d,%d,%d,%d,%d,%d,%d,%d",
				pGridCont->dwDBID, pGridCont->sID, pGridCont->sNum,
				pGridCont->sEndure[0], pGridCont->sEndure[1], pGridCont->sEnergy[0], pGridCont->sEnergy[1], pGridCont->chForgeLv);

	lookString[index] += szData;

	lnCheckSum += (pGridCont->dwDBID + pGridCont->sID + pGridCont->sNum + pGridCont->sEndure[0] + pGridCont->sEndure[1] + pGridCont->sEnergy[0] + pGridCont->sEnergy[1] + pGridCont->chForgeLv);

	for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
	{
	  _snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d", pGridCont->GetDBParam(m));

	  lookString[index] += szData;

	  lnCheckSum += pGridCont->GetDBParam(m);
	}
	if(pGridCont->IsInstAttrValid())
	{
	  lookString[index] += ",1";

	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		_snprintf_s(szData, sizeof(szData), _TRUNCATE, ",%d,%d", pGridCont->sInstAttr[k][0], pGridCont->sInstAttr[k][1]);

		lookString[index] += szData;

		lnCheckSum += pGridCont->sInstAttr[k][0] + pGridCont->sInstAttr[k][1];
	  }
	} else
	{
	  lookString[index] += ",0";
	}
  }
  _snprintf_s(szData, sizeof(szData), _TRUNCATE, ";%lld", lnCheckSum);
  lookString[index] += szData;

  return (const char*)lookString[index];
}

// 字符串转换为外观数据
bool Strin2LookData(stNetChangeChaPart* pLook, std::string& strData)
{
  if(!pLook)
	return false;

  __int64	  lnCheckSum = 0;
  const short csStrNum	 = enumEQUIP_NUM + 1 + 10;
  std::string strList[csStrNum];
  /*	2008-7-8	yangyinyu	change	begin!
	const short csSubNum = 8 + defITEM_INSTANCE_ATTR_NUM_VER110 * 2 + 1;
	*/
  const short csSubNum = 9 + defITEM_INSTANCE_ATTR_NUM_VER110 * 2 + 1;
  //	2008-7-8	yangyinyu	change	end!
  std::string strSubList[csSubNum];
  std::string strVer[2];
  bool		  bIsOldVer = Util_ResolveTextLine(strData.c_str(), strVer, 2, '#') == 1 ? true : false;

  /*	2008-7-8	yangyinyu	add	begin!
	if (bIsOldVer)
		Util_ResolveTextLine(strData.c_str(), strList, csStrNum, ';');
	else
		Util_ResolveTextLine(strVer[1].c_str(), strList, csStrNum, ';');
		*/
  int iVer = 0;

  if(bIsOldVer)
	Util_ResolveTextLine(strData.c_str(), strList, csStrNum, ';');
  else
  {
	Util_ResolveTextLine(strVer[1].c_str(), strList, csStrNum, ';');
	iVer = atoi(strVer[0].c_str());
  };
  //	2008-7-8	yangyinyu	add	end!

  Util_ResolveTextLine(strList[0].c_str(), strSubList, 3, ',');
  pLook->sTypeID = Str2Int(strSubList[0]);
  pLook->sHairID = Str2Int(strSubList[1]);
  lnCheckSum += pLook->sTypeID + pLook->sHairID;
  SItemGrid* pItem = 0;
  short		 sTCount;
  int		 i = 0;
  for(i = 0; i < enumEQUIP_NUM; i++)
  {
	sTCount = 0;
	pItem	= pLook->SLink + i;
	Util_ResolveTextLine(strList[i + 1].c_str(), strSubList, csSubNum, ',');

	//	2008-7-8	yangyinyu	add	begin!
	if(iVer == 112)
	{
	  pItem->dwDBID = Str2Int(strSubList[sTCount++]);
	};
	//	2008-7-8	yangyinyu	add	end!

	pItem->sID		  = Str2Int(strSubList[sTCount++]);
	pItem->sNum		  = Str2Int(strSubList[sTCount++]);
	pItem->sEndure[0] = Str2Int(strSubList[sTCount++]);
	pItem->sEndure[1] = Str2Int(strSubList[sTCount++]);
	pItem->sEnergy[0] = Str2Int(strSubList[sTCount++]);
	pItem->sEnergy[1] = Str2Int(strSubList[sTCount++]);
	pItem->chForgeLv  = Str2Int(strSubList[sTCount++]);

	/*	2008-7-8	yangyinyu	add	begin!
		lnCheckSum += pItem->sID + pItem->sNum + pItem->sEndure[0] + pItem->sEndure[1] + pItem->sEnergy[0] + pItem->sEnergy[1] + pItem->chForgeLv;
		*/
	if(iVer == 112)
	{
	  lnCheckSum += pItem->dwDBID + pItem->sID + pItem->sNum + pItem->sEndure[0] + pItem->sEndure[1] + pItem->sEnergy[0] + pItem->sEnergy[1] + pItem->chForgeLv;
	} else
	{
	  lnCheckSum += pItem->sID + pItem->sNum + pItem->sEndure[0] + pItem->sEndure[1] + pItem->sEnergy[0] + pItem->sEnergy[1] + pItem->chForgeLv;
	}
	//	2008-7-8	yangyinyu	add	end!

	for(int m = 0; m < enumITEMDBP_MAXNUM; m++)
	{
	  pItem->SetDBParam(m, Str2Int(strSubList[sTCount++]));
	  lnCheckSum += pItem->GetDBParam(m);
	}
	if(!bIsOldVer && iVer >= defLOOK_CUR_VER) // 有属性数据是否存在的标示
	{
	  if(Str2Int(strSubList[sTCount++]) > 0) // 存在实例属性
	  {
		for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
		{
		  pItem->sInstAttr[k][0] = Str2Int(strSubList[sTCount + k * 2]);
		  pItem->sInstAttr[k][1] = Str2Int(strSubList[sTCount + k * 2 + 1]);
		  lnCheckSum += (pItem->sInstAttr[k][0] + pItem->sInstAttr[k][1]);
		}
	  } else
		pItem->SetInstAttrInvalid();
	} else
	{
	  for(int k = 0; k < defITEM_INSTANCE_ATTR_NUM; k++)
	  {
		pItem->sInstAttr[k][0] = Str2Int(strSubList[sTCount + k * 2]);
		pItem->sInstAttr[k][1] = Str2Int(strSubList[sTCount + k * 2 + 1]);
		lnCheckSum += (pItem->sInstAttr[k][0] + pItem->sInstAttr[k][1]);
	  }
	}
  }

  if(!bIsOldVer)
  {
	char szCheckSum[64];
	//sprintf(szCheckSum, "%d", lnCheckSum);
	_snprintf_s(szCheckSum, sizeof(szCheckSum), _TRUNCATE, "%lld", lnCheckSum);
	if(strncmp(szCheckSum, strList[i + 1].c_str(), 64))
	  return false;
  } else
	pLook->sVer = defLOOK_CUR_VER;

  return true;
}

// 快捷栏数据转换为字符串
char* ShortcutData2String(const stNetShortCut* pShortcut, char* szShortcutBuf, int nLen)
{
  if(!pShortcut || !szShortcutBuf) return NULL;

  char szData[512];
  int  nBufLen	   = 0, nDataLen;
  szShortcutBuf[0] = '\0';

  for(int i = 0; i < SHORT_CUT_NUM; i++)
  {
	//sprintf(szData, "%d,%d;", pShortcut->chType[i], pShortcut->byGridID[i]);
	_snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d,%d;", pShortcut->chType[i], pShortcut->byGridID[i]);
	nDataLen = (int)strlen(szData);
	if(nBufLen + nDataLen >= nLen) return NULL;
	//strcat(szShortcutBuf, szData);
	strncat_s(szShortcutBuf, nLen, szData, _TRUNCATE);
	nBufLen += nDataLen;
  }

  return szShortcutBuf;
}

const char* ShortcutData2StringEx(const stNetShortCut* pShortcut, StringPoolL& lookString, int index)
{
  if(!pShortcut) return NULL;

  char szData[512];

  for(int i = 0; i < SHORT_CUT_NUM; i++)
  {
	//sprintf(szData, "%d,%d;", pShortcut->chType[i], pShortcut->byGridID[i]);
	_snprintf_s(szData, sizeof(szData), _TRUNCATE, "%d,%d;", pShortcut->chType[i], pShortcut->byGridID[i]);
	lookString[index] += szData;
  }

  return (const char*)lookString[index];
}

// 字符串转换为快捷栏数据
bool String2ShortcutData(stNetShortCut* pShortcut, std::string& strData)
{
  if(!pShortcut)
	return false;

  std::string strList[SHORT_CUT_NUM + 1];
  const short csSubNum = 2;
  std::string strSubList[csSubNum];
  Util_ResolveTextLine(strData.c_str(), strList, SHORT_CUT_NUM + 1, ';');
  for(int i = 0; i < SHORT_CUT_NUM; i++)
  {
	Util_ResolveTextLine(strList[i].c_str(), strSubList, csSubNum, ',');
	pShortcut->chType[i]   = Str2Int(strSubList[0]);
	pShortcut->byGridID[i] = Str2Int(strSubList[1]);
  }

  return true;
}

bool KitbagStringConv(short sKbCapacity, std::string& strData)
{
  int nInsertPos = 0;
  if(strData == "")
	return true;
  if((int)strlen(strData.c_str()) < nInsertPos)
	return true;
  char szCap[10];
  //sprintf(szCap, "%d@", sKbCapacity);
  _snprintf_s(szCap, sizeof(szCap), _TRUNCATE, "%d@", sKbCapacity);
  strData.insert(nInsertPos, szCap);
  return true;
}
