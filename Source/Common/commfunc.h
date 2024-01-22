//=============================================================================
// FileName: CommFunc.h
// Creater: ZhangXuedong
// Date: 2005.01.06
// Comment:
//	2005.4.28	Arcol	add the text filter manager class: CTextFilter
//=============================================================================

#ifndef COMMFUNC_H
#define COMMFUNC_H

#include "CompCommand.h"
#include "SkillRecord.h"
#include "CharacterRecord.h"
#include "ItemRecord.h"
#include "ItemAttrType.h"
#include "JobType.h"
#include "NetRetCode.h"

#include "i18n.h"
#include "StringPoolL.h"

class CommonRes
{
  public:
  static const char* GetJobName(int index);
  static const char* GetCityName(int index);
};

extern bool KitbagStringConv(short sKbCapacity, std::string& strData);

//=============================================================================
/*---------------------------------------------------------------
* 用途:用于检测创建的角色外观数据是否合法
* nPart - 对应外观ID,nValue - 外观的值
* 返回值：外观数据是否合法。
*/
extern bool g_IsValidLook(int nType, int nPart, long nValue);

/*---------------------------------------------------------------
* ulAreaMask 区域类型
* 返回值：true 海洋。false 陆地
*/
inline bool g_IsSea(unsigned short usAreaMask)
{
  return !(usAreaMask & enumAREA_TYPE_LAND);
}

inline bool g_IsLand(unsigned short usAreaMask)
{
  return (usAreaMask & enumAREA_TYPE_LAND) || (usAreaMask & enumAREA_TYPE_BRIDGE);
}

// 根据传入的左右手道具ID
// 返回可以使用的默认技能,返回-1,没有技能
extern int g_GetItemSkill(int nLeftItemID, int nRightItemID);

extern BOOL IsDist(int x1, int y1, int x2, int y2, DWORD dwDist);

// 是否正确的技能目标
extern int g_IsRightSkillTar(int nTChaCtrlType, bool bTIsDie, bool bTChaBeSkilled, int nTChaArea,
							 int nSChaCtrlType, int nSSkillObjType, int nSSkillObjHabitat, int nSSkillEffType,
							 bool bIsTeammate, bool bIsFriend, bool bIsSelf);

/*---------------------------------------------------------------
* 参数:左手，右手，身体的道具ID。技能编号。
* 返回值:1-可使用,0-不可使用,-1-技能不存在
*/
extern int	g_IsUseSkill(stNetChangeChaPart* pSEquip, int nSkillID);
extern bool g_IsRealItemID(int nItemID);

inline int g_IsUseSkill(stNetChangeChaPart* pSEquip, CSkillRecord* p)
{
  if(!p) return -1;

  return g_IsUseSkill(pSEquip, p->nID);
}

inline int g_IsUseSeaLiveSkill(long lFitNo, CSkillRecord* p)
{
  if(!p) return -1;

  for(int i = 0; i < defSKILL_ITEM_NEED_NUM; i++)
  {
	if(p->sItemNeed[0][i][0] == cchSkillRecordKeyValue)
	  break;

	if(p->sItemNeed[0][i][0] == enumSKILL_ITEM_NEED_ID)
	{
	  if(p->sItemNeed[0][i][1] == lFitNo)
		return 1;
	}
  }

  return 0;
}

inline bool g_IsPlyCtrlCha(int nChaCtrlType)
{
  if(nChaCtrlType == enumCHACTRL_PLAYER || nChaCtrlType == enumCHACTRL_PLAYER_PET)
	return true;
  return false;
}

inline bool g_IsMonsCtrlCha(int nChaCtrlType)
{
  if(nChaCtrlType == enumCHACTRL_MONS || nChaCtrlType == enumCHACTRL_MONS_TREE || nChaCtrlType == enumCHACTRL_MONS_MINE || nChaCtrlType == enumCHACTRL_MONS_FISH || nChaCtrlType == enumCHACTRL_MONS_DBOAT || nChaCtrlType == enumCHACTRL_MONS_REPAIRABLE)
	return true;
  return false;
}

inline bool g_IsNPCCtrlCha(int nChaCtrlType)
{
  if(nChaCtrlType == enumCHACTRL_NPC || nChaCtrlType == enumCHACTRL_NPC_EVENT)
	return true;
  return false;
}

inline bool g_IsChaEnemyCtrlSide(int nSCtrlType, int nTCtrlType)
{
  if(g_IsPlyCtrlCha(nSCtrlType) & g_IsPlyCtrlCha(nTCtrlType))
	return false;
  if(g_IsMonsCtrlCha(nSCtrlType) & g_IsMonsCtrlCha(nTCtrlType))
	return false;
  return true;
}

inline bool g_IsFileExist(const char* szFileName)
{
  FILE* fp = NULL;
  //if (NULL == (fp = fopen(szFileName,"rb")))
  if(fopen_s(&fp, szFileName, "rb") != 0)
	return false;

  if(fp == NULL)
	return false;

  if(fp) fclose(fp);
  return true;
}

extern char*	   LookData2String(const stNetChangeChaPart* pLook, char* szLookBuf, int nLen, bool bNewLook = true);
extern const char* LookData2StringEx(const stNetChangeChaPart* pLook, StringPoolL& lookString, int index, bool bNewLook = true);

extern bool		   Strin2LookData(stNetChangeChaPart* pLook, std::string& strData);
extern char*	   ShortcutData2String(const stNetShortCut* pShortcut, char* szShortcutBuf, int nLen);
extern const char* ShortcutData2StringEx(const stNetShortCut* pShortcut, StringPoolL& lookString, int index);

extern bool String2ShortcutData(stNetShortCut* pShortcut, std::string& strData);

inline long g_ConvItemAttrTypeToCha(long lItemAttrType)
{
  if(lItemAttrType >= ITEMATTR_COE_STR && lItemAttrType <= ITEMATTR_COE_PDEF)
	return lItemAttrType + (ATTR_ITEMC_STR - ITEMATTR_COE_STR);
  else if(lItemAttrType >= ITEMATTR_VAL_STR && lItemAttrType <= ITEMATTR_VAL_PDEF)
	return lItemAttrType + (ATTR_ITEMV_STR - ITEMATTR_VAL_STR);
  else
	return 0;
}

// 对应区域类型的参数个数
inline short g_GetRangeParamNum(char RangeType)
{
  short sParamNum = 0;
  switch(RangeType)
  {
  case enumRANGE_TYPE_STICK:
	sParamNum = 2;
	break;
  case enumRANGE_TYPE_FAN:
	sParamNum = 2;
	break;
  case enumRANGE_TYPE_SQUARE:
	sParamNum = 1;
	break;
  case enumRANGE_TYPE_CIRCLE:
	sParamNum = 1;
	break;
  }

  return sParamNum + 1;
}

//=============================================================================
// chChaType 角色类型
// chChaTerrType 角色活动空间的类型
// bIsBlock 是否障碍
// ulAreaMask 区域类型
// 返回值：true 可在该单元上移动。false 不可移动
//=============================================================================
inline bool g_IsMoveAble(char chChaCtrlType, char chChaTerrType, unsigned short usAreaMask)
{
  bool bRet1 = false;
  if(chChaTerrType == defCHA_TERRITORY_DISCRETIONAL)
	bRet1 = true;
  else if(chChaTerrType == defCHA_TERRITORY_LAND)
  {
	if(usAreaMask & enumAREA_TYPE_LAND || usAreaMask & enumAREA_TYPE_BRIDGE)
	  bRet1 = true;
  } else if(chChaTerrType == defCHA_TERRITORY_SEA)
  {
	if(!(usAreaMask & enumAREA_TYPE_LAND))
	  bRet1 = true;
  }

  bool bRet2 = true;
  if(usAreaMask & enumAREA_TYPE_NOT_FIGHT) // 非战斗区域
  {
	if(g_IsMonsCtrlCha(chChaCtrlType))
	  bRet2 = false;
  }

  return bRet1 && bRet2;
}

inline const char* g_GetJobName(short sJobID)
{
  if(sJobID < 0 || sJobID >= MAX_JOB_TYPE)
	//return g_szJobName[0];
	CommonRes::GetJobName(0);

  //return g_szJobName[sJobID];
  return CommonRes::GetJobName(sJobID);
}

inline short g_GetJobID(const char* szJobName)
{
  for(short i = 0; i < MAX_JOB_TYPE; i++)
  {
	//if (!strcmp(g_szJobName[i], szJobName))
	if(!strcmp(CommonRes::GetJobName(i), szJobName))
	  return i;
  }

  return 0;
}

inline const char* g_GetCityName(short sCityID)
{
  if(sCityID < 0 || sCityID >= defMAX_CITY_NUM)
	return "";

  //return g_szCityName[sCityID];
  return CommonRes::GetCityName(sCityID);
}

inline short g_GetCityID(const char* szCityName)
{
  for(short i = 0; i < defMAX_CITY_NUM; i++)
  {
	//if (!strcmp(g_szCityName[i], szCityName))
	if(!strcmp(CommonRes::GetCityName(i), szCityName))
	  return i;
  }

  return -1;
}

inline bool g_IsSeatPose(int pose)
{
  return 16 == pose;
}

// 引发表现返回真
inline bool g_IsValidFightState(int nState)
{
  return nState < enumFSTATE_TARGET_NO;
}

inline bool g_ExistStateIsDie(char chState)
{
  if(chState >= enumEXISTS_WITHERING)
	return true;

  return false;
}

inline const char* g_GetItemAttrExplain(int v)
{
  switch(v)
  {
  case ITEMATTR_COE_STR: return RES_STRING(CO_COMMFUNC_H_00001);   // "力量加成";
  case ITEMATTR_COE_AGI: return RES_STRING(CO_COMMFUNC_H_00002);   // "敏捷加成";
  case ITEMATTR_COE_DEX: return RES_STRING(CO_COMMFUNC_H_00003);   // "专注加成";
  case ITEMATTR_COE_CON: return RES_STRING(CO_COMMFUNC_H_00004);   // "体质加成";
  case ITEMATTR_COE_STA: return RES_STRING(CO_COMMFUNC_H_00005);   // "精神加成";
  case ITEMATTR_COE_LUK: return RES_STRING(CO_COMMFUNC_H_00006);   // "幸运加成";
  case ITEMATTR_COE_ASPD: return RES_STRING(CO_COMMFUNC_H_00007);  // "攻击频率加成";
  case ITEMATTR_COE_ADIS: return RES_STRING(CO_COMMFUNC_H_00008);  // "攻击距离加成";
  case ITEMATTR_COE_MNATK: return RES_STRING(CO_COMMFUNC_H_00009); // "最小攻击力加成";
  case ITEMATTR_COE_MXATK: return RES_STRING(CO_COMMFUNC_H_00010); // "最大攻击力加成";
  case ITEMATTR_COE_DEF: return RES_STRING(CO_COMMFUNC_H_00011);   // "防御加成";
  case ITEMATTR_COE_MXHP: return RES_STRING(CO_COMMFUNC_H_00012);  // "最大HP加成";
  case ITEMATTR_COE_MXSP: return RES_STRING(CO_COMMFUNC_H_00013);  // "最大SP加成";
  case ITEMATTR_COE_FLEE: return RES_STRING(CO_COMMFUNC_H_00014);  // "闪避率加成";
  case ITEMATTR_COE_HIT: return RES_STRING(CO_COMMFUNC_H_00015);   // "命中率加成";
  case ITEMATTR_COE_CRT: return RES_STRING(CO_COMMFUNC_H_00016);   // "爆击率加成";
  case ITEMATTR_COE_MF: return RES_STRING(CO_COMMFUNC_H_00017);	   // "寻宝率加成";
  case ITEMATTR_COE_HREC: return RES_STRING(CO_COMMFUNC_H_00018);  // "HP恢复速度加成";
  case ITEMATTR_COE_SREC: return RES_STRING(CO_COMMFUNC_H_00019);  // "SP恢复速度加成";
  case ITEMATTR_COE_MSPD: return RES_STRING(CO_COMMFUNC_H_00020);  // "移动速度加成";
  case ITEMATTR_COE_COL: return RES_STRING(CO_COMMFUNC_H_00021);   // "资源采集速度加成";

  case ITEMATTR_VAL_STR: return RES_STRING(CO_COMMFUNC_H_00001);   // "力量加成";
  case ITEMATTR_VAL_AGI: return RES_STRING(CO_COMMFUNC_H_00002);   // "敏捷加成";
  case ITEMATTR_VAL_DEX: return RES_STRING(CO_COMMFUNC_H_00003);   // "专注加成";
  case ITEMATTR_VAL_CON: return RES_STRING(CO_COMMFUNC_H_00004);   // "体质加成";
  case ITEMATTR_VAL_STA: return RES_STRING(CO_COMMFUNC_H_00005);   // "精神加成";
  case ITEMATTR_VAL_LUK: return RES_STRING(CO_COMMFUNC_H_00006);   // "幸运加成";
  case ITEMATTR_VAL_ASPD: return RES_STRING(CO_COMMFUNC_H_00007);  // "攻击频率加成";
  case ITEMATTR_VAL_ADIS: return RES_STRING(CO_COMMFUNC_H_00008);  // "攻击距离加成";
  case ITEMATTR_VAL_MNATK: return RES_STRING(CO_COMMFUNC_H_00009); // "最小攻击力加成";
  case ITEMATTR_VAL_MXATK: return RES_STRING(CO_COMMFUNC_H_00010); // "最大攻击力加成";
  case ITEMATTR_VAL_DEF: return RES_STRING(CO_COMMFUNC_H_00011);   // "防御加成";
  case ITEMATTR_VAL_MXHP: return RES_STRING(CO_COMMFUNC_H_00012);  // "最大HP加成";
  case ITEMATTR_VAL_MXSP: return RES_STRING(CO_COMMFUNC_H_00013);  // "最大SP加成";
  case ITEMATTR_VAL_FLEE: return RES_STRING(CO_COMMFUNC_H_00014);  // "闪避率加成";
  case ITEMATTR_VAL_HIT: return RES_STRING(CO_COMMFUNC_H_00015);   // "命中率加成";
  case ITEMATTR_VAL_CRT: return RES_STRING(CO_COMMFUNC_H_00016);   // "爆击率加成";
  case ITEMATTR_VAL_MF: return RES_STRING(CO_COMMFUNC_H_00017);	   // "寻宝率加成";
  case ITEMATTR_VAL_HREC: return RES_STRING(CO_COMMFUNC_H_00018);  // "HP恢复速度加成";
  case ITEMATTR_VAL_SREC: return RES_STRING(CO_COMMFUNC_H_00019);  // "SP恢复速度加成";
  case ITEMATTR_VAL_MSPD: return RES_STRING(CO_COMMFUNC_H_00020);  // "移动速度加成";
  case ITEMATTR_VAL_COL: return RES_STRING(CO_COMMFUNC_H_00021);   // "资源采集速度加成";

  case ITEMATTR_VAL_PDEF: return RES_STRING(CO_COMMFUNC_H_00022);  // "物理抵抗加成";
  case ITEMATTR_MAXURE: return RES_STRING(CO_COMMFUNC_H_00023);	   // "最大耐久度";
  case ITEMATTR_MAXENERGY: return RES_STRING(CO_COMMFUNC_H_00024); // "最大能量";
  default: return RES_STRING(CO_COMMFUNC_H_00025);				   // "未知道具属性";
  }
}

inline const char* g_GetServerError(int error_code) // 解析错误码
{
  switch(error_code)
  {
  case ERR_AP_INVALIDUSER: return RES_STRING(CO_COMMFUNC_H_00026);	// "无效账号";
  case ERR_AP_INVALIDPWD: return RES_STRING(CO_COMMFUNC_H_00027);	// "密码错误";
  case ERR_AP_ACTIVEUSER: return RES_STRING(CO_COMMFUNC_H_00028);	// "激活用户失败";
  case ERR_AP_DISABLELOGIN: return RES_STRING(CO_COMMFUNC_H_00029); // "目前您的角色正处于下线存盘过程中，请稍后再尝试登录。";
  case ERR_AP_TOO_MANY_ATTEMPTS: return RES_STRING(CO_COMMFUNC_H_00110);
  case ERR_AP_LOGGED: return RES_STRING(CO_COMMFUNC_H_00030);		// "此帐号已处于登录状态";
  case ERR_AP_BANUSER:
	return RES_STRING(CO_COMMFUNC_H_00031); // "帐号已封停";
  // Add by lark.li 20080825 begin
  case ERR_AP_PBANUSER:
	return RES_STRING(CO_COMMFUNC_H_00108); // "已经使用了密保卡";
  // End
  case ERR_AP_GPSLOGGED: return RES_STRING(CO_COMMFUNC_H_00032);   // "此GroupServer已登录";
  case ERR_AP_GPSAUTHFAIL: return RES_STRING(CO_COMMFUNC_H_00033); // "此GroupServer认证失败";
  case ERR_AP_SAVING: return RES_STRING(CO_COMMFUNC_H_00034);	   // "正在保存你的角色，请15秒后重试...";
  case ERR_AP_LOGINTWICE: return RES_STRING(CO_COMMFUNC_H_00035);  // "你的账号在远处再次登录";
  case ERR_AP_ONLINE: return RES_STRING(CO_COMMFUNC_H_00036);	   // "你的账号已在线";
  case ERR_AP_DISCONN: return RES_STRING(CO_COMMFUNC_H_00037);	   // "GroupServer已断开";
  case ERR_AP_UNKNOWNCMD: return RES_STRING(CO_COMMFUNC_H_00038);  // "未知协议，不处理";
  case ERR_AP_TLSWRONG: return RES_STRING(CO_COMMFUNC_H_00039);	   // "本地存储错误";
  case ERR_AP_NOBILL: return RES_STRING(CO_COMMFUNC_H_00040);	   // "此账号已过期，请充值！";

  case ERR_PT_LOGFAIL: return RES_STRING(CO_COMMFUNC_H_00041);		// "GateServer向GroupServer的登录失败";
  case ERR_PT_SAMEGATENAME: return RES_STRING(CO_COMMFUNC_H_00042); // "GateServer与已登录GateServer重名";

  case ERR_PT_INVALIDDAT: return RES_STRING(CO_COMMFUNC_H_00043);	// "无效的数据格式";
  case ERR_PT_INERR: return RES_STRING(CO_COMMFUNC_H_00044);		// "服务器之间的操作完整性错误";
  case ERR_PT_NETEXCP: return RES_STRING(CO_COMMFUNC_H_00045);		// "帐号服务器故障";	// GroupServer发现的到AccuntServer的网络故障
  case ERR_PT_DBEXCP: return RES_STRING(CO_COMMFUNC_H_00046);		// "数据库服务器故障";	// GroupServer发现的到Database的故障
  case ERR_PT_INVALIDCHA: return RES_STRING(CO_COMMFUNC_H_00047);	// "当前帐号不拥有请求(选择/删除)的角色";
  case ERR_PT_TOMAXCHA: return RES_STRING(CO_COMMFUNC_H_00048);		// "已经达到最多能创建的角色数了";
  case ERR_PT_SAMECHANAME: return RES_STRING(CO_COMMFUNC_H_00049);	// "重复的角色名";
  case ERR_PT_INVALIDBIRTH: return RES_STRING(CO_COMMFUNC_H_00050); // "非法的出生地";
  case ERR_PT_TOOBIGCHANM: return RES_STRING(CO_COMMFUNC_H_00051);	// "角色名太长";
  case ERR_PT_ISGLDLEADER: return RES_STRING(CO_COMMFUNC_H_00052);	// "公会不可一日无长，请先解散公会再删除角色";
  case ERR_PT_ERRCHANAME: return RES_STRING(CO_COMMFUNC_H_00053);	// "非法的角色名称";
  case ERR_PT_SERVERBUSY: return RES_STRING(CO_COMMFUNC_H_00054);	// "系统忙，请稍后再试";
  case ERR_PT_TOOBIGPW2: return RES_STRING(CO_COMMFUNC_H_00055);	// "二次密码长度非法";
  case ERR_PT_INVALID_PW2: return RES_STRING(CO_COMMFUNC_H_00056);	// "未创建角色保护二次密码";
  case ERR_PT_BADBOY:
	return RES_STRING(CO_COMMFUNC_H_00057); // "孩子，你很BT，已经自动对你作出了通报批评，要引以为戒，不可再犯！";

  // Add by lark.li 20080825 begin
  case ERR_PT_BANUSER: return RES_STRING(CO_COMMFUNC_H_00031); // "帐号已封停";
  case ERR_PT_PBANUSER:
	return RES_STRING(CO_COMMFUNC_H_00108); // "已经使用了密保卡";
											// End

  case ERR_MC_NETEXCP: return RES_STRING(CO_COMMFUNC_H_00058);	   // "GateServer发现的网络异常";
  case ERR_MC_NOTSELCHA: return RES_STRING(CO_COMMFUNC_H_00059);   // "当前未处于选择角色状态";
  case ERR_MC_NOTPLAY: return RES_STRING(CO_COMMFUNC_H_00060);	   // "当前不处于玩游戏状态，不能发送ENDPLAY命令";
  case ERR_MC_NOTARRIVE: return RES_STRING(CO_COMMFUNC_H_00061);   // "目标地图不可到达";
  case ERR_MC_TOOMANYPLY: return RES_STRING(CO_COMMFUNC_H_00062);  // "本服务器组人数已满, 请选择其它组进行游戏!";
  case ERR_MC_NOTLOGIN: return RES_STRING(CO_COMMFUNC_H_00063);	   // "你尚未登陆";
  case ERR_MC_VER_ERROR: return RES_STRING(CO_COMMFUNC_H_00064);   // "客户端的版本号错误,服务器拒绝登录！";
  case ERR_MC_ENTER_ERROR: return RES_STRING(CO_COMMFUNC_H_00065); // "进入地图失败！";
  case ERR_MC_ENTER_POS:
	return RES_STRING(CO_COMMFUNC_H_00066); // "地图位置非法，您将被送回出生城市，请重新登陆！";

  // Add by lark.li 20080825 begin
  case ERR_MC_BANUSER: return RES_STRING(CO_COMMFUNC_H_00031); // "帐号已封停";
  case ERR_MC_PBANUSER:
	return RES_STRING(CO_COMMFUNC_H_00108); // "已经使用了密保卡";
											// End

  case ERR_TM_OVERNAME: return RES_STRING(CO_COMMFUNC_H_00067); // "GameServer名重复";
  case ERR_TM_OVERMAP: return RES_STRING(CO_COMMFUNC_H_00068);	// "GameServer上地图名重复";
  case ERR_TM_MAPERR: return RES_STRING(CO_COMMFUNC_H_00069);	// "GameServer地图配置语法错误";

  case ERR_SUCCESS: return RES_STRING(CO_COMMFUNC_H_00070); // "Jack太BT了，正确也来问我什么错误！";
  default:
  {
	int l_error_code = error_code;
	l_error_code /= 500;
	l_error_code *= 500;
	static char l_buffer[500];
	char		l_convt[20];

	_itoa_s(error_code, l_convt, sizeof(l_convt), 10);

	switch(l_error_code)
	{
	case ERR_MC_BASE:
	{
	  //return strcat(strcpy(l_buffer,itoa(error_code,l_convt,10)),RES_STRING(CO_COMMFUNC_H_00071)); //"(GameServer/GateServer->Client返回的错误码空间1－500)");
	  strncpy_s(l_buffer, sizeof(l_buffer), l_convt, _TRUNCATE);
	  strncat_s(l_buffer, sizeof(l_buffer), RES_STRING(CO_COMMFUNC_H_00071), _TRUNCATE);
	}
	case ERR_PT_BASE:
	{
	  //return strcat(strcpy(l_buffer,itoa(error_code,l_convt,10)),RES_STRING(CO_COMMFUNC_H_00072)); //"(GroupServer->GateServer返回的错误码空间501－1000)");
	  strncpy_s(l_buffer, sizeof(l_buffer), l_convt, _TRUNCATE);
	  strncat_s(l_buffer, sizeof(l_buffer), RES_STRING(CO_COMMFUNC_H_00072), _TRUNCATE);
	}
	case ERR_AP_BASE:
	{
	  //return strcat(strcpy(l_buffer,itoa(error_code,l_convt,10)),RES_STRING(CO_COMMFUNC_H_00073)); //"(AccountServer->GroupServer返回的错误码空间1001－1500)");
	  strncpy_s(l_buffer, sizeof(l_buffer), l_convt, _TRUNCATE);
	  strncat_s(l_buffer, sizeof(l_buffer), RES_STRING(CO_COMMFUNC_H_00073), _TRUNCATE);
	}
	case ERR_MT_BASE:
	{
	  //return strcat(strcpy(l_buffer,itoa(error_code,l_convt,10)),RES_STRING(CO_COMMFUNC_H_00074)); //"(GameServer->GateServer返回的错误码空间1501－2000)");
	  strncpy_s(l_buffer, sizeof(l_buffer), l_convt, _TRUNCATE);
	  strncat_s(l_buffer, sizeof(l_buffer), RES_STRING(CO_COMMFUNC_H_00074), _TRUNCATE);
	}
	default:
	{
	  //return strcat(strcpy(l_buffer,itoa(error_code,l_convt,10)),RES_STRING(CO_COMMFUNC_H_00075)); //"(Jack太BT了，弄个错误连我都不认识。)");
	  strncpy_s(l_buffer, sizeof(l_buffer), l_convt, _TRUNCATE);
	  strncat_s(l_buffer, sizeof(l_buffer), RES_STRING(CO_COMMFUNC_H_00075), _TRUNCATE);
	}
	}
	return l_buffer;
  }
  }
}

inline const char* g_GetUseItemFailedInfo(short sErrorID)
{
  switch(sErrorID)
  {
  case enumITEMOPT_SUCCESS:
	return RES_STRING(CO_COMMFUNC_H_00076); // "道具操作成功";
	break;
  case enumITEMOPT_ERROR_NONE:
	return RES_STRING(CO_COMMFUNC_H_00077); // "道具不存在";
	break;
  case enumITEMOPT_ERROR_KBFULL:
	return RES_STRING(CO_COMMFUNC_H_00078); // "道具栏已满";
	break;
  case enumITEMOPT_ERROR_UNUSE:
	return RES_STRING(CO_COMMFUNC_H_00079); // "道具使用失败";
	break;
  case enumITEMOPT_ERROR_UNPICKUP:
	return RES_STRING(CO_COMMFUNC_H_00080); // "道具不能拾取";
	break;
  case enumITEMOPT_ERROR_UNTHROW:
	return RES_STRING(CO_COMMFUNC_H_00081); // "道具不能丢弃";
	break;
  case enumITEMOPT_ERROR_UNDEL:
	return RES_STRING(CO_COMMFUNC_H_00082); // "道具不能销毁";
	break;
  case enumITEMOPT_ERROR_KBLOCK:
	return RES_STRING(CO_COMMFUNC_H_00083); // "道具栏处于锁定状态";
	break;
  case enumITEMOPT_ERROR_DISTANCE:
	return RES_STRING(CO_COMMFUNC_H_00084); // "距离太远";
	break;
  case enumITEMOPT_ERROR_EQUIPLV:
	return RES_STRING(CO_COMMFUNC_H_00085); // "装备等级不满足";
	break;
  case enumITEMOPT_ERROR_EQUIPJOB:
	return RES_STRING(CO_COMMFUNC_H_00086); // "装备职业不满足";
	break;
  case enumITEMOPT_ERROR_STATE:
	return RES_STRING(CO_COMMFUNC_H_00087); // "该状态下不能操作道具";
	break;
  case enumITEMOPT_ERROR_PROTECT:
	return RES_STRING(CO_COMMFUNC_H_00088); // "道具被保护";
	break;
  case enumITEMOPT_ERROR_AREA:
	return RES_STRING(CO_COMMFUNC_H_00089); // "不同的区域类型";
	break;
  case enumITEMOPT_ERROR_BODY:
	return RES_STRING(CO_COMMFUNC_H_00090); // "体型不匹配";
	break;
  case enumITEMOPT_ERROR_TYPE:
	return RES_STRING(CO_COMMFUNC_H_00091); // "此道具无法存放";
	break;
  case enumITEMOPT_ERROR_INVALID:
	return RES_STRING(CO_COMMFUNC_H_00092); // "无效的道具";
	break;
  case enumITEMOPT_ERROR_KBRANGE:
	return RES_STRING(CO_COMMFUNC_H_00093); // "超出道具栏范围";
	break;
	// add by ning.yan 2008-11-11 begin
  case enumITEMOPT_ERROR_ITEMLOCK:
	return RES_STRING(CO_COMMFUNC_H_00109); // "道具处于锁定状态"
	break;
	//end
  default:
	return RES_STRING(CO_COMMFUNC_H_00094); // "未知的道具操作失败码";
	break;
  }
}

// 将g_IsRightSkillTar(...)的返回值转换为字符串
inline const char* g_GetCheckSkillTarRetInfo(int nErrorID)
{
  switch(nErrorID)
  {
  case enumESKILL_SUCCESS:
	return RES_STRING(CO_COMMFUNC_H_00095); // "技能使用成功";
	break;
  case enumESKILL_FAILD_NPC:
	return RES_STRING(CO_COMMFUNC_H_00096); // "目标是NPC";
	break;
  case enumESKILL_FAILD_NOT_SKILLED:
	return RES_STRING(CO_COMMFUNC_H_00097); // "目标不能被攻击";
	break;
  case enumESKILL_FAILD_SAFETY_BELT:
	return RES_STRING(CO_COMMFUNC_H_00098); // "目标在安全区";
	break;
  case enumESKILL_FAILD_NOT_LAND:
	return RES_STRING(CO_COMMFUNC_H_00099); // "不是陆地技能";
	break;
  case enumESKILL_FAILD_NOT_SEA:
	return RES_STRING(CO_COMMFUNC_H_00100); // "不是海洋技能";
	break;
  case enumESKILL_FAILD_ONLY_SELF:
	return RES_STRING(CO_COMMFUNC_H_00101); // "技能只能用于自己";
	break;
  case enumESKILL_FAILD_ONLY_DIEPLY:
	return RES_STRING(CO_COMMFUNC_H_00102); // "技能只能用于玩家尸体";
	break;
  case enumESKILL_FAILD_FRIEND:
	return RES_STRING(CO_COMMFUNC_H_00103); // "技能不能用于友方";
	break;
  case enumESKILL_FAILD_NOT_FRIEND:
	return RES_STRING(CO_COMMFUNC_H_00104); // "技能只能用于友方";
	break;
  case enumESKILL_FAILD_NOT_PALYER:
	return RES_STRING(CO_COMMFUNC_H_00105); // "技能只能用于玩家";
	break;
  case enumESKILL_FAILD_NOT_MONS:
	return RES_STRING(CO_COMMFUNC_H_00106); // "技能只能用于怪物";
	break;
  default:
	return RES_STRING(CO_COMMFUNC_H_00107); // "未知的技能使用失败码";
	break;
  }
}

class CTextFilter
{
  public:
#define eTableMax 5
  enum eFilterTable
  {
	NAME_TABLE	 = 0,
	DIALOG_TABLE = 1,
	MAX_TABLE	 = eTableMax
  };
  /*
	* Warning : Do not use MAX_TABLE enum value, it just use for the maximum limit definition,
	*			If you want to expand this enum table value more than the default number eTableMax(5),
	*			please increase the eTableMax definition
	*/

  CTextFilter();
  ~CTextFilter();
  static bool  Add(const eFilterTable eTable, const char* szFilterText);
  static bool  IsLegalText(const eFilterTable eTable, const string strText);
  static bool  Filter(const eFilterTable eTable, string& strText);
  static bool  LoadFile(const char* szFileName, const eFilterTable eTable = NAME_TABLE);
  static BYTE* GetNowSign(const eFilterTable eTable);
  static void  Clear(); //清除内存 Add By Waiting 2009-06-17

  private:
  static bool ReplaceText(string& strText, const string* pstrFilterText);
  static bool bCheckLegalText(const string& strText, const string* pstrIllegalText);

  static vector<string> m_FilterTable[eTableMax];
  static BYTE			m_NowSign[eTableMax][8];
};

#endif // COMMFUNC_H