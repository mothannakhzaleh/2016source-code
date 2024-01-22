#include "Stdafx.h"
#include "Character.h"
#include "Point.h"
#include "LEShadeMap.h"
#include "leparticlectrl.h"
#include "Scene.h"
#include "SceneItem.h"
#include "CharacterAction.h"
#include "actor.h"
#include "STStateObj.h"
//add by ALLEN 2007-10-16
#include "state_reading.h"

#include "EffectObj.h"
#include "SkillRecord.h"
#include "worldscene.h"
#include "ItemRecord.h"
#include "EffectObj.h"
#include "terrainattrib.h"
#include "GameApp.h"
#include "MusicSet.h"
#include "STAttack.h"
#include "UIHeadSay.h"
#include "UICommand.h"
#include "CommFunc.h"
#include "effdelay.h"
#include "SkillStateRecord.h"
#include "uistartform.h"
#include "netprotocol.h"
#include "uiboatform.h"
#include "steadyframe.h"
#include "event.h"
#include "chastate.h"
#include "shipset.h"
#include "SceneHeight.h"
#include "stpose.h"
#include "UIBoothForm.h"
#include "stmove.h"
#include "UIEquipForm.h"
#include "UIItemCommand.h"
#include "UIMiniMapForm.h"
#include "caLua.h"

extern CGameApp* g_pGameApp;
extern bool		 g_IsShowShop;

CSkillRecord* CCharacter::_pDefaultSkillInfo = NULL;
CSkillRecord* CCharacter::_pReadySkillInfo	 = NULL;
bool		  CCharacter::_IsShowShadow		 = true;

// 特殊表现
enum eSpecial
{
  enumAlphaIn	= 1,  // 淡入
  enumAlphaOut	= 2,  // 淡出
  enumDrop		= 3,  // 下沉
  enumFastRaise = 4,  // 快速上升
  enumFastDrop	= 5,  // 快速下沉
  enumHelixPos	= 6,  // 公转
  enumHelixYaw	= 7,  // 自转
  enumHelixOut	= 8,  // 向外变大螺旋
  enumHelixIn	= 9,  // 向内缩小螺旋
  enumDisappear = 10, // 立即消失
  enumCyclone	= 11, // 飓风
};

#ifdef _LOG_NAME_
bool CCharacter::IsShowLogName = false;
#endif

inline int GetWeaponBackDummy(int nWeaponType, bool isLeftHand)
{
  int nBackDummy = -1;
  if(isLeftHand)
  {
	switch(nWeaponType)
	{
	case 2:
	case 5:
	case 9:
	case 10:
	  nBackDummy = 21;
	  break;
	case 1:
	case 3:
	case 11:
	  nBackDummy = 22;
	  break;
	case 4:
	case 7:
	case 8:
	  nBackDummy = 23;
	  break;
	}
  } else
  {
	switch(nWeaponType)
	{
	case 1:
	case 2:
	case 5:
	case 9:
	case 10:
	  nBackDummy = 21;
	  break;
	case 3:
	case 11:
	case 18:
	case 19:
	  nBackDummy = 22;
	  break;
	case 4:
	case 7:
	case 8:
	  nBackDummy = 23;
	  break;
	}
  }
  return nBackDummy;
}

// Add by rock.wang 2009.04.28 通过能量值从脚本中获取项链称号
// Begin
inline void SetPreNameByEnergy(int nItem, short* itemEnergy, char szName[16], DWORD& dwColor, int len = 0, short sex = 0)
{
  if(!nItem)
  {
	szName[0] = '\0';
	return;
  }
  typedef struct RetPreName
  {
	char* pColor;
	char* preName;
  } RetPreName;
  RetPreName* pRet = (RetPreName*)CLU_CallScriptFunction("GetPreviouName", "char*,char*", "ushort,ushort,ushort", itemEnergy[0], itemEnergy[1], sex); //最后参数0为正常性别,1为特殊性别
  if(pRet)
  {
	strncpy_s(szName, len, pRet->preName, _TRUNCATE);

	string color = pRet->pColor;
	string _r, _g, _b;

	size_t dotFirst = color.find(",");
	size_t dotLast	= color.find(",", dotFirst + 1);

	_r = color.substr(0, dotFirst);
	_g = color.substr(dotFirst + 1, dotLast - dotFirst - 1);
	_b = color.substr(dotLast + 1, color.length() - dotLast);

	if(_r.length() <= 0 || _g.length() <= 0 || _b.length() <= 0)
	{
	  dwColor	= D3DCOLOR_ARGB(255, 255, 255, 255);
	  szName[0] = '0';
	  return;
	} else
	{
	  dwColor = D3DCOLOR_ARGB(255, atoi(_r.c_str()), atoi(_g.c_str()), atoi(_b.c_str()));
	  return;
	}
  }
}
// End

inline void SetPreName(int nItem, char szName[20], DWORD& dwColor, int len = 0)
{
  DWORD COLOR_SKYBLUE = D3DCOLOR_ARGB(255, 168, 168, 255);

  switch(nItem)
  {
	//case 3936:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_7) );   dwColor = D3DCOLOR_ARGB(255,192,192,192); return;
	//case 3937:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_8) );   dwColor = D3DCOLOR_ARGB(255,000,255,012); return;
	//case 3938:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_9) );   dwColor = D3DCOLOR_ARGB(255,217,255,119); return;
	//case 3939:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_10) );  dwColor = D3DCOLOR_ARGB(255,070,182,240); return;
	//case 3940:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_11) );  dwColor = D3DCOLOR_ARGB(255,255,207,000); return;
	//case 3941:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_12) );  dwColor = D3DCOLOR_ARGB(255,255,000,000); return;
	//case 3942:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_13) );  dwColor = D3DCOLOR_ARGB(255,241,014,240); return;
	////Modify by sunny.sun 20080516(许立国要求该的新的Iteminfo)
	////Begin
	//case 5816:  strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00001) );		dwColor = D3DCOLOR_ARGB(255,192,192,192); return;
	//case 5817:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00002) );   dwColor = D3DCOLOR_ARGB(255,000,255,012); return;
	//case 5818:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00003) );		dwColor = D3DCOLOR_ARGB(255,217,255,119); return;
	//case 5819:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00004) );   dwColor = D3DCOLOR_ARGB(255,070,182,240); return;
	//case 5820:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00005) );   dwColor = D3DCOLOR_ARGB(255,255,207,000); return;
	//case 5821:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00006) );   dwColor = D3DCOLOR_ARGB(255,255,000,000); return;
	//case 5822:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00007) );   dwColor = D3DCOLOR_ARGB(255,241,014,240); return;
	//case 5823:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00008) );   dwColor = D3DCOLOR_ARGB(255,241,014,240); return;
	//case 5824:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_00009) ); dwColor = D3DCOLOR_ARGB(255,255,000,000); return;
	////Add by sunny.sun20080820 and swapChinese characters to English word by alfred.shi 20081030
	//case 6226:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000010) );dwColor = D3DCOLOR_ARGB(255,255,000,000); return;
	////End

	//case 5331:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_922) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,192,192,192); return;
	//case 5332:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_923) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,135,135,135); return;
	//case 5333:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_924) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,255,255,255); return;
	//case 5334:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_925) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,070,182,240); return;
	//case 5335:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_926) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,000,255,012); return;
	//case 5336:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_927) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,217,255,119); return;
	//case 5337:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_928) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,255,207,000); return;
	//case 5338:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_929) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,255,127,000); return;
	//case 5339:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_930) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,255,000,000); return;
	//case 5340:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_931) ); dwColor = COLOR_SKYBLUE; return;//D3DCOLOR_ARGB(255,241,014,240); return;
	////Add by sunny.sun 20080904
	//case 6388:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000011) );   dwColor = D3DCOLOR_ARGB(255,000,255,012); return;
	//case 6386:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000012));   dwColor = D3DCOLOR_ARGB(255,217,255,119); return;
	//case 6389:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000013) );  dwColor = D3DCOLOR_ARGB(255,070,182,240); return;
	//case 6387:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000014) );  dwColor = D3DCOLOR_ARGB(255,255,207,000); return;
	//case 6390:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000015) );  dwColor = D3DCOLOR_ARGB(255,255,000,000); return;
	//case 6391:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000016) );  dwColor = D3DCOLOR_ARGB(255,241,014,240); return;

	//case 6434:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000012) );		 dwColor = D3DCOLOR_ARGB(255,217,255,119); return;
	//case 6428:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000013) );	 dwColor = D3DCOLOR_ARGB(255,255,207,000); return;
	//case 6429:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000017) );	 dwColor = D3DCOLOR_ARGB(255,000,255,012); return;
	//case 6430:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000018) );	 dwColor = D3DCOLOR_ARGB(255,070,182,240); return;
	//case 6431:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000019) );	 dwColor = D3DCOLOR_ARGB(255,255,000,000); return;
	//case 6432:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000020) );  dwColor = D3DCOLOR_ARGB(255,241,014,240); return;

	////	Add by alfred.shi 20081118	begin
	//case 6480:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000021) );   dwColor = D3DCOLOR_ARGB(255,82,225,232); return;
	//case 6484:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000022));   dwColor = D3DCOLOR_ARGB(255,82,225,232); return;
	//case 6488:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000023) );  dwColor = D3DCOLOR_ARGB(255,82,225,232); return;
	//case 6492:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000024) );  dwColor = D3DCOLOR_ARGB(255,82,225,232); return;
	//case 6481:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000025) );  dwColor = D3DCOLOR_ARGB(255,38, 217, 226); return;
	//case 6485:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000026) );  dwColor = D3DCOLOR_ARGB(255,38, 217, 226); return;
	//case 6489:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000027) );  dwColor = D3DCOLOR_ARGB(255,38, 217, 226); return;
	//case 6493:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000028) );	 dwColor = D3DCOLOR_ARGB(255,38, 217, 226); return;
	//case 6482:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000029) );	 dwColor = D3DCOLOR_ARGB(255,24, 173, 180); return;
	//case 6486:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000030) );	 dwColor = D3DCOLOR_ARGB(255,24, 173, 180); return;
	//case 6490:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000031) );	 dwColor = D3DCOLOR_ARGB(255,24, 173, 180); return;
	//case 6494:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000032) );	 dwColor = D3DCOLOR_ARGB(255,24, 173, 180); return;
	//case 6483:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000033) );  dwColor = D3DCOLOR_ARGB(255,0, 102, 255); return;
	//case 6487:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000034) );   dwColor = D3DCOLOR_ARGB(255,0, 102, 255); return;
	//case 6491:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000035));   dwColor = D3DCOLOR_ARGB(255,0, 102, 255); return;
	//case 6495:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000036) );  dwColor = D3DCOLOR_ARGB(255,0, 102, 255); return;
	//case 6496:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000037) );  dwColor = D3DCOLOR_ARGB(255,255,0,0); return;
	//case 6497:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000038) );  dwColor = D3DCOLOR_ARGB(255,245,31,235); return;
	//case 6498:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000039) );  dwColor = D3DCOLOR_ARGB(255,77,77,77); return;
	//case 6568:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000040) );	 dwColor = D3DCOLOR_ARGB(255,103,204,255); return;
	//case 6569:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000041) );	 dwColor = D3DCOLOR_ARGB(255,255,0,255); return;
	//case 6570:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000042) );	 dwColor = D3DCOLOR_ARGB(255,23,55,93); return;
	//case 6571:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000043) );	 dwColor = D3DCOLOR_ARGB(255,103,204,255); return;
	//case 6572:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000044) );	 dwColor = D3DCOLOR_ARGB(255,255,0,255); return;
	//case 6573:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000045) );  dwColor = D3DCOLOR_ARGB(255,23,55,93); return;
	//case 6574:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000046) );  dwColor = D3DCOLOR_ARGB(255,103,204,255); return;
	//case 6575:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000047) );   dwColor = D3DCOLOR_ARGB(255,23,55,93); return;
	//case 6576:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000048));   dwColor = D3DCOLOR_ARGB(255,103,204,255); return;
	//case 6577:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000049) );  dwColor = D3DCOLOR_ARGB(255,103,204,255); return;
	//case 6578:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000050) );  dwColor = D3DCOLOR_ARGB(255,255,0,255); return;
	//case 6579:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000051) );  dwColor = D3DCOLOR_ARGB(255,23,55,93); return;
	//case 6611:	strcpy( szName, RES_STRING(CL_CHARACTER_CPP_000052) );  dwColor = D3DCOLOR_ARGB(255,255,0,0); return;
	//	End.

	//// TOM版本
	//case 822:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_14) );  dwColor = D3DCOLOR_ARGB(255,255,000,000); return;	// 荣誉勋章
	//case 823:	strcpy( szName, RES_STRING(CL_LANGUAGE_MATCH_15) );  dwColor = D3DCOLOR_ARGB(255,241,014,240); return;	// 财富勋章

  case 3936:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_7), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 192, 192, 192);
	return;
  case 3937:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_8), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 000, 255, 012);
	return;
  case 3938:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_9), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 217, 255, 119);
	return;
  case 3939:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_10), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 070, 182, 240);
	return;
  case 3940:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_11), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 3941:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_12), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return;
  case 3942:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_13), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 241, 014, 240);
	return;
	//Modify by sunny.sun 20080516(许立国要求该的新的Iteminfo)
	//Begin
  case 5816:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00001), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 192, 192, 192);
	return;
  case 5817:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00002), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 000, 255, 012);
	return;
  case 5818:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00003), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 217, 255, 119);
	return;
  case 5819:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00004), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 070, 182, 240);
	return;
  case 5820:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00005), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 5821:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00006), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return;
  case 5822:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00007), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 241, 014, 240);
	return;
  case 5823:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00008), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 241, 014, 240);
	return;
  case 5824:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_00009), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return;
	//Add by sunny.sun20080820 and swapChinese characters to English word by alfred.shi 20081030
  case 6226:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000010), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return;
	//End

  case 5331:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_922), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,192,192,192); return;
  case 5332:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_923), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,135,135,135); return;
  case 5333:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_924), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,255,255,255); return;
  case 5334:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_925), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,070,182,240); return;
  case 5335:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_926), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,000,255,012); return;
  case 5336:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_927), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,217,255,119); return;
  case 5337:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_928), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,255,207,000); return;
  case 5338:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_929), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,255,127,000); return;
  case 5339:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_930), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,255,000,000); return;
  case 5340:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_931), _TRUNCATE);
	dwColor = COLOR_SKYBLUE;
	return; //D3DCOLOR_ARGB(255,241,014,240); return;
			//Add by sunny.sun 20080904
  case 6388:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000011), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 000, 255, 012);
	return;
  case 6386:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000012), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 217, 255, 119);
	return;
  case 6389:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000013), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 070, 182, 240);
	return;
  case 6387:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000014), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 6390:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000015), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return;
  case 6391:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000016), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 241, 014, 240);
	return;

  case 6434:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000012), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 217, 255, 119);
	return;
  case 6428:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000013), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 6429:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000017), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 000, 255, 012);
	return;
  case 6430:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000018), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 070, 182, 240);
	return;
  case 6431:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000019), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return;
  case 6432:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000020), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 241, 014, 240);
	return;

	//	Add by alfred.shi 20081118	begin
  case 6480:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000021), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 82, 225, 232);
	return;
  case 6484:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000022), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 82, 225, 232);
	return;
  case 6488:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000023), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 82, 225, 232);
	return;
  case 6492:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000024), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 82, 225, 232);
	return;
  case 6481:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000025), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 38, 217, 226);
	return;
  case 6485:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000026), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 38, 217, 226);
	return;
  case 6489:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000027), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 38, 217, 226);
	return;
  case 6493:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000028), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 38, 217, 226);
	return;
  case 6482:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000029), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 24, 173, 180);
	return;
  case 6486:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000030), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 24, 173, 180);
	return;
  case 6490:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000031), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 24, 173, 180);
	return;
  case 6494:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000032), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 24, 173, 180);
	return;
  case 6483:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000033), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 102, 255);
	return;
  case 6487:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000034), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 102, 255);
	return;
  case 6491:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000035), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 102, 255);
	return;
  case 6495:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000036), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 102, 255);
	return;
  case 6496:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000037), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 0, 0);
	return;
  case 6497:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000038), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 245, 31, 235);
	return;
  case 6498:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000039), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 77, 77, 77);
	return;
	//	End.

  case 6568:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000040), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 103, 204, 255);
	return;
  case 6569:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000041), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 0, 255);
	return;
  case 6570:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000042), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 23, 55, 93);
	return;
  case 6571:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000043), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 103, 204, 255);
	return;
  case 6572:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000044), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 0, 255);
	return;
  case 6573:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000045), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 23, 55, 93);
	return;
  case 6574:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000046), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 103, 204, 255);
	return;
  case 6575:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000047), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 23, 55, 93);
	return;
  case 6576:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000048), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 103, 204, 255);
	return;
  case 6577:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000049), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 103, 204, 255);
	return;
  case 6578:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000050), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 0, 255);
	return;
  case 6579:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000051), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 23, 55, 93);
	return;
  case 6611:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000052), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 0, 0);
	return;
  case 6713:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000057), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 51, 51, 255);
	return;
  case 6714:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000058), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 153, 51);
	return;
  case 6715:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000060), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 225, 220, 200);
	return;
  case 6716:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000059), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 204, 0);
	return;
	// TOM版本
  case 822:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_14), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 000, 000);
	return; // 荣誉勋章
  case 823:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_15), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 241, 014, 240);
	return; // 财富勋章
  case 6949:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1021), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 6950:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1021), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 6951:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1021), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 6952:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1021), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 207, 000);
	return;
  case 6953:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1022), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6954:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1023), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6955:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1024), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6956:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1025), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6957:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1026), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6958:
	strncpy_s(szName, len, RES_STRING(CL_LANGUAGE_MATCH_1027), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 51, 204);
	return;
  default: szName[0] = '\0';
  }
}

//	rain add 以下项链要求判断性别，所以增加如下函数和上面不同
inline void SetPreNameSex(int nItem, char szName[16], DWORD& dwColor, int len = 0)
{
  DWORD COLOR_SKYBLUE = D3DCOLOR_ARGB(255, 168, 168, 255);
  switch(nItem)
  {
  case 6707:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000053), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6717:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000054), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 51, 204);
	return;
  case 6708:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000055), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 0, 153, 255);
	return;
  case 6718:
	strncpy_s(szName, len, RES_STRING(CL_CHARACTER_CPP_000056), _TRUNCATE);
	dwColor = D3DCOLOR_ARGB(255, 255, 51, 204);
	return;
  default: szName[0] = '\0';
  }
}

static void __keyframe_proc(DWORD type, DWORD pose_id, DWORD key_id, DWORD key_frame, void* param)
{
  CCharacter* pCha = ((CCharacter*)param);
  switch(type)
  {
  case KEYFRAME_TYPE_BEGIN:
  {
	pCha->GetActor()->ActionBegin(pCha->GetCurPoseType());

	if(pCha->GetCurPoseType() > 6 && pCha->GetCurPoseType() < 15)
	{
	  CEffectObj* pEffect;
	  CSceneItem* item = pCha->GetLinkItem(LINK_ID_RIGHTHAND);
	  if(item && item->GetItemDrapID() > 0)
	  {
		pEffect = pCha->GetScene()->GetFirstInvalidEffObj();
		if(pEffect)
		{
		  if(pEffect->Create(item->GetItemDrapID()))
		  {
			pEffect->setFollowObj((CSceneNode*)item, NODE_ITEM);
			pEffect->Emission(-1, &pCha->GetPos(), NULL);
			pEffect->SetValid(TRUE);
		  }
		}
	  }
	  item = pCha->GetLinkItem(LINK_ID_LEFTHAND);
	  if(item && item->GetItemDrapID() > 0)
	  {
		pEffect = pCha->GetScene()->GetFirstInvalidEffObj();
		if(pEffect)
		{
		  if(pEffect->Create(item->GetItemDrapID()))
		  {
			pEffect->setFollowObj((CSceneNode*)item, NODE_ITEM);

			pEffect->Emission(-1, &pCha->GetPos(), NULL);
			pEffect->SetValid(TRUE);
		  }
		}
	  }
	}
	break;
  }
  case KEYFRAME_TYPE_KEY:
	pCha->ActionKeyFrame(key_id);
	break;
  case KEYFRAME_TYPE_END:
	pCha->GetActor()->ActionEnd(pCha->GetCurPoseType());
	break;
  }
}

// ========================
CCharacter::CCharacter() :
	_bEnableAI(FALSE),
	_isArrive(true),
	_nTurnCnt(0),
	_pszFootMusic(NULL),
	_pszWhoopMusic(NULL),
	_fMaxOpacity(1.0f),
	_pNpcStateItem(NULL),
	_eChaModalType(enumMODAL_MAIN_CHA),
	_eChaCtrlType(enumCHACTRL_PLAYER),
	_IsForUI(false),
	_pDefaultChaInfo(NULL),
	_bShowSecondName(TRUE),
	_sPhotoID(0),
	_nNpcType(0),
	_eMainType(enumMainNone),
	_nLeaderID(0),
	_chGMLv(0),
	_pEvent(NULL),
	_pShipInfo(NULL),
	_dwHumanID(0),
	_fMapHeight(0.0f),
	_nGuildID(0),
	_dwGuildColor(COLOR_BLACK),
	_sReliveTime(60), // 默认为1分钟
	_nPatrolX(0),
	_nPatrolY(0),
	_pBoatFog(NULL),
	_pShopItem(NULL),
	_lSideID(0),
	_pSideShade(0),
	_nServerX(0),
	_nServerY(0),
	_nDanger(0),
	mParentNode(NULL),
	mParentBoneID(0)
{
  memset(_szName, 0, sizeof(_szName));
  memset(_szHumanName, 0, sizeof(_szHumanName));
  memset(&_vPos, 0, sizeof(_vPos));
  memset(_szGuildName, 0, sizeof(_szGuildName));
  memset(_szGuildMotto, 0, sizeof(_szGuildMotto));
  memset(_szPreName, 0, sizeof(_szPreName));
  memset(_szShopName, 0, sizeof(_szShopName));
  memset(_ItemFace, 0, sizeof(_ItemFace));
  memset(_pItemFaceEff, 0, sizeof(_pItemFaceEff));

  strncpy_s(_szName, sizeof(_szName), "Player", _TRUNCATE);
  strncpy_s(_szSecondName, sizeof(_szSecondName), "", _TRUNCATE);

  _bUpdate = false;

  // #ifdef _LOG_NAME_
  // 	strncpy_s( _szLogName,sizeof(_szLogName), "LogName" ,_TRUNCATE);
  // #endif

  _pActor = new CActor(this);

  _Attr.set(ATTR_MXHP, 20);
  _Attr.set(ATTR_HP, 20);
  _Attr.set(ATTR_MSPD, 400);

  _pHeadSay = new CHeadSay(this);

  memset(_pHandItem, 0, sizeof(_pHandItem));

  memset(&_stChaPart, 0, sizeof(_stChaPart));

  _pChaState = new CChaStateMgr(this);
  _ChaState.AllTrue();

  _pSceneHeight = new CSceneHeight(this);
  _fMoveSpeed	= 1.0f;

#ifdef _KOSDEMO_
  nPetHideCount			  = 0;
  nMainChaChangeItemCount = 0;
  curEff				  = NULL;
#endif
}

CCharacter::~CCharacter()
{
  //delete _pActor;
  //delete _pChaState;
  //delete _pSceneHeight;

  SAFE_DELETE(_pActor);		  // UI当机处理
  SAFE_DELETE(_pChaState);	  // UI当机处理
  SAFE_DELETE(_pSceneHeight); // UI当机处理
  SAFE_DELETE(_pHeadSay);
}

int CCharacter::LoadCha(const LoadChaInfo* info)
{
  if(_Create(info->cha_id, 0) == 0)
	return FALSE;

  if(info->bone[0] != 0)
  {
	if(FAILED(LoadBone(info->bone)))
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_16));
	  return FALSE;
	}
  }

  for(DWORD i = 0; i < 5; i++)
  {
	if(info->part[i][0] == 0)
	  continue;

	if(FAILED(LoadPart(i, info->part[i])))
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_16));
	  return FALSE;
	}
  }

  for(DWORD i = 0; i < 4; i++)
  {
	if(strlen(info->prop[i]) == 0)
	  continue;

	CSceneItem* p = this->GetScene()->AddSceneItem(info->prop[i]);

	if(p == NULL)
	{
	  LG("error", "msgLoad Ship Power System error!\n");
	  return FALSE;
	}
	p->PlayDefaultAnimation();

	drSceneItemLinkInfo ili;
	ili.data		   = 99;
	ili.id			   = 0;
	ili.obj			   = p;
	ili.link_item_id   = 0;
	ili.link_parent_id = i;

	this->SetSubObjItemLink(2, &ili);
  }

  return TRUE;
}

BOOL CCharacter::_Create(int nCharTypeID, int nType)
{
  return TRUE;
}

bool CCharacter::LoadBoat(stNetChangeChaPart& stPart)
{
  memcpy(&_stChaPart, &stPart, sizeof(_stChaPart));
  DWORD dwBuf[8] = {0};
  if(_pShipInfo = ConvertPartTo8DWORD(stPart, dwBuf))
  {
	//if(_pShipInfo->sNumHeader||_pShipInfo->sNumEngine||_pShipInfo->sNumCannon||_pShipInfo->sNumEquipment)
	//	_bUpdate = true;
	if(stPart.sBoatID > 10)
	  _bUpdate = true;
	else
	  _bUpdate = false;

	return LoadShip(stPart.sPosID, dwBuf) ? true : false;
  }

  return false;
}

void CCharacter::_UpdateValid(BOOL bValid)
{
  if(bValid == FALSE)
  {
	setSideID(0);
	if(GetDrunkState()) CCharacterModel::SetDrunkState(FALSE);
	_pChaState->ChaDestroy();

	DieTime();
	if(_pEvent)
	{
	  _pEvent->SetIsValid(false);
	  _pEvent = NULL;
	}
	_DetachAllItem();
	for(int i = 0; i < enumEQUIP_NUM; i++)
	{
	  if(_pHandItem[i])
	  {
		_pHandItem[i]->SetValid(FALSE);
		_pHandItem[i] = NULL;
	  }
	}

	for(int i = 0; i < ITEM_FACE_MAX; i++)
	{
	  if(_pItemFaceEff[i])
	  {
		_pItemFaceEff[i]->SetValid(FALSE);
		_pItemFaceEff[i] = NULL;
	  }
	}
	memset(_ItemFace, 0, sizeof(_ItemFace));

	GetScene()->HandleSceneMsg(SCENEMSG_CHA_DESTROY, getID());
  } else
  {
	SetPoseKeyFrameProc(__keyframe_proc, (void*)this);
  }
}

void CCharacter::FrameMove(DWORD dwTimeParam)
{
  CSceneNode::FrameMove(dwTimeParam);

  if(!_isArrive)
  {
	if(_IsMoveTimeType)
	{
	  static float		 dis;
	  static D3DXVECTOR2 vTmp;

	  dis = (float)(CGameApp::GetCurTick() - _dwStartTime) * _fMoveSpeed;
	  if(dis > _fMoveLen)
	  {
		setPos((int)_vMoveEnd.x, (int)_vMoveEnd.y);

		_isArrive = true;
	  } else
	  {
		vTmp = _vMoveStart + _vMoveDir * dis;
		setPos((int)vTmp.x, (int)vTmp.y);
	  }
	} else if(GetChaState()->IsTrue(enumChaStateMove))
	{
	  // 重新计算新的ProgressRate(决定当前的位置和高度)------------------------------------------------------------------------------
	  if(_nTurnCnt > 1)
		_fStepProgressRate = _fStepProgressRate + _fStep * CWaitMoveState::GetMoveRate() / (float)_nTurnCnt;
	  else
		_fStepProgressRate = _fStepProgressRate + _fStep * CWaitMoveState::GetMoveRate();

	  if( g_Render.IsRealFPS() )
	  _fStepProgressRate = min(_fStepProgressRate, 1.0f);
	  _CalPos(_fStepProgressRate);

	  // 			if( IsMainCha() )
	  // 			{
	  //  				IP("Move: Prgrs(%f) Step(%f) Rate(%f) Turn(%d) Last(%d,%d) Cur(%d,%d) Diff=%d\n",
	  //  					_fStepProgressRate, _fStep, CWaitMoveState::GetMoveRate(), _nTurnCnt, _nLastPosX, _nLastPosY,
	  // 					GetCurX(), GetCurY(),
	  //  					GetDistance( GetCurX(), GetCurY(), GetServerX(), GetServerY() )
	  //  					);
	  // 			}

	  if(_fStepProgressRate >= 1.0f)
	  {
		_isArrive = true;
	  } else if(_isStopMove)
	  {
		_isArrive = true;
	  }
	}
  } else
  {
	// 每300ms刷新一次高度
	if(_pSceneHeight->FrameMove(dwTimeParam))
	{
	  _UpdateHeight();

	  if(_pNpcStateItem)
	  {
		//_pNpcStateItem->setHeightOff( (int)(GetDefaultChaInfo()->fHeight * 100.0f) );
		_pNpcStateItem->setHeightOff((int)(GetDefaultChaInfo()->fHeight * (GetIsFly() ? 130.0f : 100.0f)));
	  }
	}
  }

  if(_nTurnCnt)
  {
	// 更新方向
	_nYaw += _nAngleStep;
	SetYaw(Angle2Radian((float)_nYaw));
	UpdateYawPitchRoll();
	_nTurnCnt--;
  }

  _pActor->FrameMove(dwTimeParam);

  if(_Special.IsAny())
  {
	static long	 x, y;
	static float f = 0.0f;

	if(_Special.IsTrue(enumDrop))
	{
	  _nHeightOff--;
	  _fMapHeight = 0.0f;
	}
	if(_Special.IsTrue(enumFastRaise))
	{
	  _nHeightOff += 25;
	  _fMapHeight = 0.0f;
	}
	if(_Special.IsTrue(enumFastDrop))
	{
	  _nHeightOff -= 25;
	  if(_nHeightOff < 0)
	  {
		_nHeightOff = 0;
		_Special.SetFalse(enumFastDrop);
	  }
	  _fMapHeight = 0.0f;
	}
	if(_Special.IsTrue(enumAlphaOut))
	{
	  f = GetOpacity() - 0.03f;
	  if(f < 0.0f)
	  {
		f = 0.0f;
		_Special.SetFalse(enumAlphaOut);

		if(IsMainCha())
		  _Special.SetTrue(enumAlphaIn);
	  }
	  SetOpacity(f);
	}
	if(_Special.IsTrue(enumAlphaIn))
	{
	  // 淡入完成时，所有特效都取消
	  f = GetOpacity() + 0.03f;
	  if(f > _fMaxOpacity)
	  {
		f = _fMaxOpacity;
		_Special.SetFalse(enumAlphaIn);
	  }
	  SetOpacity(f);
	}
	if(_Special.IsTrue(enumHelixOut))
	{
	  _nHelixAngle += 13;
	  _nHelixRadii += 20;
	  ::eddy(_nHelixCenterX, _nHelixCenterY, _nHelixAngle, _nHelixRadii, x, y);
	  _nCurX = x;
	  _nCurY = y;
	}
	if(_Special.IsTrue(enumHelixIn))
	{
	  _nHelixAngle += 13;
	  _nHelixRadii -= 20;
	  if(_nHelixRadii > 0)
	  {
		::eddy(_nHelixCenterX, _nHelixCenterY, _nHelixAngle, _nHelixRadii, x, y);
		_nCurX = x;
		_nCurY = y;
	  } else
	  {
		_nCurX = _nHelixCenterX;
		_nCurY = _nHelixCenterY;
		_Special.SetFalse(enumHelixIn);
	  }
	}
	if(_Special.IsTrue(enumHelixYaw))
	{
	  setYaw((getYaw() + 18) % 360);
	}
	if(_Special.IsTrue(enumHelixPos))
	{
	  _nHelixAngle += 13;
	  ::eddy(_nHelixCenterX, _nHelixCenterY, _nHelixAngle, 200, x, y);
	  _nCurX = x;
	  _nCurY = y;
	}
	if(_Special.IsTrue(enumCyclone))
	{
	  _nHelixAngle += 13;
	  ::eddy(_nHelixCenterX, _nHelixCenterY, _nHelixAngle, _nHelixRadii, x, y);
	  _nCurX = x;
	  _nCurY = y;

	  if(_nHeightOff <= 500)
		_nHeightOff += 25;
	}
	_UpdateHeight();
  }

  _computeLinkedMatrix();

  // by lsh
  // 注意，这里的FrameMove必需放在最后调用，否则会有位置误差
  CCharacterModel::FrameMove();
  return;
}

void CCharacter::Render()
{
  if(!_pScene->IsPointVisible((float)_nCurX / 100.0f, (float)_nCurY / 100.0f)) return;

  g_Render.EnableZBuffer(TRUE);

  CSceneNode::Render();

  CCharacterModel::Render();
}

void CCharacter::RefreshLevel(int nMainLevel)
{
  if(IsMonster())
  {
	//int nDifLevel = getGameAttr()->get(ATTR_LV) - nMainLevel;
	int nDifLevel = (int)getGameAttr()->get(ATTR_LV) - nMainLevel;
	if(nDifLevel >= 7)
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 241, 14, 240));
	} else if(nDifLevel >= 5)
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 255, 0, 0));
	} else if(nDifLevel >= 3)
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 255, 207, 0));
	} else if(nDifLevel >= -2)
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 255, 255, 255));
	} else if(nDifLevel >= -4)
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 217, 255, 119));
	} else if(nDifLevel >= -6)
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 0, 255, 12));
	} else
	{
	  _pHeadSay->SetNameColor(D3DCOLOR_ARGB(255, 192, 192, 192));
	}
  } else
  {
	_pHeadSay->SetNameColor(COLOR_WHITE);
  }
}

void CCharacter::RefreshUI(int nParam)
{
  //_pHeadSay->SetLifeNum( _Attr.get(ATTR_HP), _Attr.get(ATTR_MXHP) );
  _pHeadSay->SetLifeNum((int)_Attr.get(ATTR_HP), (int)_Attr.get(ATTR_MXHP));

  if(g_stUIBoat.GetHuman() == this)
  {
	/*g_stUIStart.RefreshMainLifeNum( _Attr.get(ATTR_HP), _Attr.get(ATTR_MXHP)) ;
		g_stUIStart.RefreshMainSP(_Attr.get(ATTR_SP), _Attr.get(ATTR_MXSP) );*/
	g_stUIStart.RefreshMainLifeNum((long)_Attr.get(ATTR_HP), (long)_Attr.get(ATTR_MXHP));
	g_stUIStart.RefreshMainSP((long)_Attr.get(ATTR_SP), (long)_Attr.get(ATTR_MXSP));

	g_stUIStart.RefreshMainExperience(_Attr.get(ATTR_CEXP), _Attr.get(ATTR_CLEXP), _Attr.get(ATTR_NLEXP));
	//g_stUIStart.RefreshLv( _Attr.get(ATTR_LV) );
	g_stUIStart.RefreshLv((long)_Attr.get(ATTR_LV));
  }
}

BOOL CCharacter::WieldItem(const drSceneItemLinkInfo* info)
{
  if(FAILED(LECharacter::SetItemLink(info)))
	return FALSE;

  CSceneItem* item = (CSceneItem*)info->obj;
  item->setAttachedCharacterID(getID());

  return TRUE;
}

void CCharacter::DestroyLinkItem()
{
  for(DWORD i = 0; i < GetLinkItemNum(); i++)
  {
	CSceneItem* obj = (CSceneItem*)GetLinkItem(i);
	obj->SetValid(0);
  }
}

int CCharacter::_GetTargetAngle(int nTargetX, int nTargetY, BOOL bBack)
{
  D3DXVECTOR2 dPosition = D3DXVECTOR2((float)nTargetX, (float)nTargetY) - D3DXVECTOR2((float)_nCurX, (float)_nCurY);
  if(bBack) dPosition *= -1;

  int nAngle = (int)(180.0f - Radian2Angle(atan2f(dPosition.x, dPosition.y)));

  return FixAngle(nAngle);
}

void CCharacter::setPos(int nX, int nY)
{
#ifdef _STATE_DEBUG
  if(IsMainCha())
  {
	static DWORD tick = 0;
	int			 dis  = GetDistance(nX, nY, _nCurX, _nCurY);
	if(dis > 300.0f)
	  LG("main_cha_pos", "\t\tpos:%d, %d, target:%d, %d, dis:%d, Tick:%d, FPS: %d\n", _nCurX, _nCurY, nX, nY, dis, GetTickCount() - tick, g_Render.GetFPS());
	else
	  LG("main_cha_pos", "pos:%d, %d, target:%d, %d, dis:%d, Tick:%d, FPS: %d\n", _nCurX, _nCurY, nX, nY, dis, GetTickCount() - tick, g_Render.GetFPS());
	tick = GetTickCount();
  }
#endif

  if(_Special.IsAny())
  {
	_nHelixCenterX = nX;
	_nHelixCenterY = nY;
  }

  _nCurX = nX;
  _nCurY = nY;

  if(_pNpcStateItem)
  {
	_pNpcStateItem->setPos(nX, nY);
  }

  _UpdateHeight();
}

int CCharacter::FaceTo(int nAngle)
{
  if(!_pDefaultChaInfo->IsFace())
	return getYaw();

  _nYaw = FixAngle(_nYaw);

  nAngle = FixAngle(nAngle);

  if(IsBoat())
  {
	_nAngleStep = (int)(300.0f / (float)g_Render.GetFPS());
  } else
  {
	_nAngleStep = (int)(600.0f / (float)g_Render.GetFPS());
	if(_nAngleStep <= 0) _nAngleStep = 1;
  }

  if(!_isArrive && IsMainCha() && !IsBoat())
  {
	_nAngleStep = (int)((float)_nAngleStep * 0.75f);
	if(_nAngleStep <= 0) _nAngleStep = 1;
  }

  int nDis = GetAngleDistance(_nYaw, nAngle);

  _nTurnCnt = (abs)(nDis) / _nAngleStep;

  int nLeft = nDis % _nAngleStep;

  //  	if( IsMainCha() )
  //  	{
  //  		IP("FaceTo: Dis=%d, _nAngleStep=%d _nTurnCnt=%d, nLeft=%d\n", nDis, _nAngleStep, _nTurnCnt, nLeft);
  //  	}

  if(nDis < 0)
  {
	_nAngleStep *= -1;
  }

  if(nLeft != 0)
  {
	_nYaw += nLeft;
	SetYaw(Angle2Radian((float)_nYaw));
	UpdateYawPitchRoll();
  }
  return nAngle;
}

bool CCharacter::ItemEffect(int nEffectID, int nItemDummy, int nAngle)
{
  if(nEffectID == 0 || nItemDummy == -1) return false;

  CSceneItem* item = GetAttackItem();
  if(!item) return false;

  CEffectObj* pEffect = GetScene()->GetFirstInvalidEffObj();
  if(!pEffect) return false;

  if(!pEffect->Create(nEffectID))
	return false;

  static MPMatrix44 mat;
  if(item->GetObjDummyRunTimeMatrix(&mat, nItemDummy) >= 0)
  {
	pEffect->setFollowObj((CSceneNode*)item, NODE_ITEM, nItemDummy);
	if(nAngle != 999) pEffect->SetEffectDir(nAngle);
	pEffect->Emission(-1, (D3DXVECTOR3*)&mat._41, NULL);
  } else
  {
	pEffect->setFollowObj((CSceneNode*)item, NODE_ITEM);
	if(nAngle != 999) pEffect->SetEffectDir(nAngle);
	pEffect->Emission(-1, &GetPos(), NULL);
  }

  pEffect->SetValid(TRUE);
  return true;
}

CEffectObj* CCharacter::SelfEffect(int nEffectID, int nDummy, bool isLoop, int nSize, int nAngle)
{
  if(nEffectID <= 0) return NULL;

  // added by Philip.Wu  2008-01-25 乱斗白银城里不播放这些特效
  if(g_stUIMap.IsPKSilver() && this->IsPlayer() && this->GetMainType() != enumMainPlayer)
  {
	if(574 <= nEffectID && nEffectID <= 577) return 0;
  }
  CEffectObj* pEffect = GetScene()->GetFirstInvalidEffObj();
  if(!pEffect) return NULL;

  if(!pEffect->Create(nEffectID))
	return NULL;

  if(isLoop)
	pEffect->setLoop(isLoop);

  if(nSize > 0 && pEffect->GetBaseSize() > 0.0f) // 如果小于零,不支持缩放
  {
	SkillCtrl ctrl;
	ctrl.fSize = (float)nSize / 100.0f / pEffect->GetBaseSize();
	pEffect->SetSkillCtrl(&ctrl);
  }
  static MPMatrix44 mat;

  if(IsBoat())
  {
	//xShipInfo* pInfo = ::GetShipInfo( GetPart().sBoatID );
	if(!_bUpdate)
	{
	  if(nDummy >= 0 && GetObjDummyRunTimeMatrix(&mat, nDummy, 0) >= 0)
	  {
		if(nAngle != 999) pEffect->SetEffectDir(nAngle);
		pEffect->setFollowObj((CSceneNode*)this, NODE_CHA, nDummy);
		pEffect->Emission(-1, (D3DXVECTOR3*)&mat._41, NULL);
	  } else
	  {
		if(nAngle != 999) pEffect->SetEffectDir(nAngle);
		pEffect->setFollowObj((CSceneNode*)this, NODE_CHA);
		pEffect->Emission(-1, &GetPos(), NULL);
	  }
	} else
	  goto __ret;
  } else
  {
  __ret:
	if(nDummy >= 0 && GetObjDummyRunTimeMatrix(&mat, nDummy) >= 0)
	{
	  if(nAngle != 999)
		pEffect->SetEffectDir(nAngle);
	  pEffect->setFollowObj((CSceneNode*)this, NODE_CHA, nDummy);
	  pEffect->Emission(-1, (D3DXVECTOR3*)&mat._41, NULL);
	} else
	{
	  if(nAngle != 999)
		pEffect->SetEffectDir(nAngle);
	  pEffect->setFollowObj((CSceneNode*)this, NODE_CHA);
	  pEffect->Emission(-1, &GetPos(), NULL);
	}
  }

  pEffect->SetValid(TRUE);
  return pEffect;
}

CEffectObj* CCharacter::SkyEffect(int nEffectID, int nBeginDummy, int nItemDummy, int nSpeed, D3DXVECTOR3* pTarget, int nTargetChaID, CSkillRecord* pSkill)
{
  if(nEffectID <= 0) return NULL;

  CEffectObj* pEffect = GetScene()->GetFirstInvalidEffObj();
  if(!pEffect) return NULL;

  if(!pEffect->Create(nEffectID))
	return NULL;

  static D3DXVECTOR3 pos;
  static MPMatrix44	 mat;
  if(nBeginDummy >= 0 && GetObjDummyRunTimeMatrix(&mat, nBeginDummy) >= 0)
  {
	pos = *(D3DXVECTOR3*)&mat._41;
  } else if(nItemDummy >= 0)
  {
	CSceneItem* item = GetAttackItem();
	if(item && item->GetObjDummyRunTimeMatrix(&mat, nItemDummy) >= 0)
	{
	  pos = *(D3DXVECTOR3*)&mat._41;
	} else
	{
	  pos = GetPos();
	}
  } else
  {
	pos = GetPos();
  }

  if(pSkill)
  {
	switch(pSkill->GetShape())
	{
	case enumRANGE_TYPE_NONE:
	case enumRANGE_TYPE_SQUARE: // 柱形（长度，宽度）
	case enumRANGE_TYPE_CIRCLE: // 圆形（半径）
	  break;
	case enumRANGE_TYPE_FAN: // 扇形（半径，角度）
	{
	  pEffect->SetFanAngle(pSkill->GetParam()[1]);
	  pEffect->SetMagicDist((float)pSkill->GetParam()[0] / 100.0f);
	}
	case enumRANGE_TYPE_STICK: // 柱形（长度，宽度）
	{
	  // 取方向，为解决特效从手上道具飞出时，鼠标却点在道具与主角之间时，特效飞的方向不对
	  int x, y;
	  GetDistancePos(GetCurX(), GetCurY(), int(pTarget->x * 100.0f), int(pTarget->y * 100.0f), 500, x, y);
	  pTarget->x = (float)x / 100;
	  pTarget->y = (float)y / 100;
	}
	break;
	};
  }

  pEffect->setOwerID(getID());
  pEffect->SetVel((float)nSpeed);
  pEffect->Emission(nTargetChaID, &pos, pTarget);
  pEffect->SetValid(TRUE);
  return pEffect;
}

bool CCharacter::ChangeReadySkill(int nSkillID)
{
  CSkillRecord* p = GetSkillRecordInfo(nSkillID);
  if(!p)
  {
	// 没技能
	//g_pGameApp->AddTipText( RES_STRING(CL_LANGUAGE_MATCH_17), p->szName );
	return false;
  }

  if(_pReadySkillInfo && _pReadySkillInfo->sID == nSkillID) return true;

  if(!p->GetIsValid())
  {
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_18), p->szName);
	return false;
  }

  g_pGameApp->AddTipText(RES_STRING(CL_LANGUAGE_MATCH_19), p->szName);
  _SetReadySkill(p);
  return true;
}

void CCharacter::_UpdateHeight()
{
  _vPos.x = (float)_nCurX / 100.0f;
  _vPos.y = (float)_nCurY / 100.0f;

  if(_nPoseHeightOff == ERROR_POSE_HEIGHT)
  {
	switch(_pDefaultChaInfo->chTerritory)
	{
	case 1:
	  _fMapHeight = (float)_pDefaultChaInfo->sSeaHeight / 100.0f;
	  break;
	default:
	  _fMapHeight = _pScene->GetGridHeight(_vPos.x, _vPos.y);
	}

	_vPos.z = _fMapHeight + (float)(_nHeightOff) / 100.0f;
  } else
  {
	_vPos.z = (float)(_nPoseHeightOff) / 100.0f;
  }

  SetPos((float*)&_vPos); // 子类对设置高度的实现, _vPos.x与_vPos.y都不变
  if(GetDrunkState())
  {
	UpdateChaMatrix();
  }
}
//void	CCharacter::SetHieght(float fhei)
//{
//	if( _nPoseHeightOff==ERROR_POSE_HEIGHT )
//	{
//		switch( _pDefaultChaInfo->chTerritory )
//		{
//		case 1:
//			//_fMapHeight = (float)_pDefaultChaInfo->sSeaHeight / 100.0f;
//			_fMapHeight = fhei +_pScene->GetGridHeight(_vPos.x, _vPos.y);
//			break;
//		default:
//			_fMapHeight = _pScene->GetGridHeight(_vPos.x, _vPos.y);
//		}
//
//		_vPos.z = _fMapHeight + (float)( _nHeightOff ) / 100.0f;
//	}
//	else
//	{
//		_vPos.z = (float)( _nPoseHeightOff ) / 100.0f;
//	}
//
//	SetPos((float*)&_vPos); // 子类对设置高度的实现, _vPos.x与_vPos.y都不变
//	if( GetDrunkState() )
//	{
//		UpdateChaMatrix();
//	}
//}

void CCharacter::OperatorEffect(char oper, int x, int y)
{
  //switch( oper )
  //{
  //case 3:// 上岸
  //	if( IsBoat() )
  //	{
  //		D3DXVECTOR3 pos;
  //		pos.x = (float)x / 100.0f;
  //		pos.y = (float)y / 100.0f;
  //		pos.z = _pScene->GetGridHeight( pos.x, pos.y );

  //		CEffectObj* pEffect = SkyEffect( 1021, 2, -1, 2500, &pos );
  //           if( pEffect )
  //           {
  //               pEffect->GetEffDelay()->SetPosEffect( 157, pos );
  //           }
  //	}
  //	break;
  //case 1:// 下海
  //	if( IsPlayer() )
  //	{
  //		D3DXVECTOR3 pos;
  //		pos.x = (float)x / 100.0f;
  //		pos.y = (float)y / 100.0f;
  //		pos.z = _pScene->GetGridHeight( pos.x, pos.y );

  //		CEffectObj* pEffect = SkyEffect( 1021, 2, -1, 2500, &pos );
  //           if( pEffect )
  //           {
  //               pEffect->GetEffDelay()->SetPosEffect( 158, pos );
  //           }
  //	}
  //	break;
  //}
}

void CCharacter::setName(const char* pszName)
{
  //strncpy( _szName, pszName, sizeof(_szName) );
  strncpy_s(_szName, sizeof(_szName), pszName, _TRUNCATE);
  _pHeadSay->SetName(_szName);
}

void CCharacter::UpdateTileColor()
{
  BYTE r = 255;
  BYTE g = 255;
  BYTE b = 255;

  LETerrain* t = _pScene->GetTerrain();
  if(t)
  {
	D3DXVECTOR3 v	 = this->GetPos();
	LETile*		tile = t->GetTile((int)v.x, (int)v.y);
	if(tile)
	{
	  D3DXCOLOR c = tile->dwXColor;

	  //if(c.r < 0.4f)
	  //    c.r = 0.4f;
	  //if(c.g < 0.4f)
	  //    c.g = 0.4f;
	  //if(c.b < 0.4f)
	  //    c.b = 0.4f;

	  r = (BYTE)((float)r * ((1.0f + c.r) / 2));
	  g = (BYTE)((float)g * ((1.0f + c.g) / 2));
	  b = (BYTE)((float)b * ((1.0f + c.b) / 2));

	  //const BYTE lmt = 160;
	  //if(r < lmt)
	  //    r = lmt;
	  //if(g  < lmt)
	  //    g = lmt;
	  //if(b < lmt)
	  //    b = lmt;
	}
  }

  if(GetEmiColorFlag() == 0)
  {
	CCharacterModel::SetAmbColor(r, g, b);
  }
}

void CCharacter::PlayAni(char* pAni, int nMax)
{
  _Special.AllFalse();
  _nHeightOff = 0;

  _nHelixCenterX = _nCurX;
  _nHelixCenterY = _nCurY;
  for(int i = 0; i < nMax; i++)
  {
	if(pAni[i] == 0) break;

	switch(pAni[i])
	{
	case enumAlphaIn:
	  _Special.SetTrue(pAni[i]);
	  SetOpacity(0.0f);
	  break;
	case enumHelixOut:
	  _Special.SetTrue(pAni[i]);
	  _nHelixRadii = 0;
	  _nHelixAngle = getYaw();
	  break;
	case enumHelixIn:
	  _Special.SetTrue(pAni[i]);
	  _nHelixRadii = 400;
	  _nHelixAngle = getYaw();
	  break;
	case enumHelixPos:
	  _Special.SetTrue(pAni[i]);
	  _nHelixRadii = 200;
	  _nHelixAngle = getYaw();
	  break;
	case enumFastDrop:
	  _Special.SetTrue(pAni[i]);
	  // _nHeightOff = 200;
	  break;
	case enumDisappear:
	  _Special.SetTrue(pAni[i]);
	  SetHide(TRUE);
	  break;
	case enumCyclone:
	  if(_pDefaultChaInfo->IsCyclone())
	  {
		_Special.SetTrue(pAni[i]);
		_nHelixAngle = getYaw();
		_nHelixRadii = 200;
		_nHeightOff	 = 0;
	  }
	  break;
	default:
	  _Special.SetTrue(pAni[i]);
	}
  }
}

void CCharacter::InitState()
{
  GetActor()->InitState();

  _isArrive = true;

  _Special.AllFalse();

  SetOpacity(_fMaxOpacity);

  _nHeightOff	  = 0;
  _fMapHeight	  = 0.0f;
  _nPoseHeightOff = ERROR_POSE_HEIGHT;
  _InFight		  = false;

  SetHide(FALSE);

  _dwStartTime = 0;

  _ChaState.AllTrue();
  _hits.clear();

  _pHeadSay->Reset();

  _pSceneHeight->Reset();

  _szShopName[0] = 0;
  _PK.AllFalse();
  setSideID(0);
}

void CCharacter::setSideID(long v)
{
  _lSideID = v;

  if(_pSideShade)
  {
	_pSideShade->SetValid(FALSE);
	_pSideShade = NULL;
  }

  if(_lSideID != 0 && IsPlayer())
  {
	// 		LG( getLogName(), "Add SideID:%d\n", _lSideID );
	_pSideShade = _pScene->GetFirstInvalidShadeObj();
	if(_pSideShade)
	{
	  // 			LG( getLogName(), "Add SideID:%d Successed\n", _lSideID );
	  _pSideShade->Create(IsBoat() ? 7 : 2);
	  _pSideShade->setColor(_lSideID == 1 ? 0xff00ff00 : 0xffff0000);
	  _pSideShade->setChaID(getID());
	  _pSideShade->setUpSea(true);
	  _pSideShade->Emission(0, &GetPos(), NULL);
	  _pSideShade->SetValid(TRUE);
	}
  }
}

void CCharacter::ActionKeyFrame(DWORD key_id)
{
  if(_pDefaultChaInfo)
  {
	if(_pDefaultChaInfo->sEffectActionID[0] == key_id)
	{
	  SelfEffect(_pDefaultChaInfo->sEffectActionID[1], _pDefaultChaInfo->sEffectActionID[2]);
	}
  }

  switch(GetCurPoseType())
  {
  case POSE_RUN:
  case POSE_RUN2:
	if(_pszFootMusic && key_id == 0)
	{
	  CGameScene::PlayEnvSound(_pszFootMusic, GetCurX(), GetCurY());
	}
	break;
  case POSE_WAITING:
  case POSE_WAITING2:
	if(_pszWhoopMusic)
	{
	  CGameScene::PlayEnvSound(_pszWhoopMusic, GetCurX(), GetCurY());
	}
	break;
  }

  GetActor()->ActionKeyFrame(GetCurPoseType(), key_id);

  if(_IsShowShadow && _eChaCtrlType == enumCHACTRL_PLAYER && !IsBoat() && GetScene()->GetTileTexAttr((int)GetPos().x, (int)GetPos().y) == 1)
  {
	GetScene()->GetPugMgr()->NewPug(&GetPos(), (float)getYaw() * 0.01745329f + D3DX_PI);
  }
}

void CCharacter::SetDefaultChaInfo(CChaRecord* pInfo)
{
  _pDefaultChaInfo = pInfo;

  _pszFootMusic = NULL;
  if(_pDefaultChaInfo->sFootfall != -1)
  {
	CMusicInfo* pMusicInfo = GetMusicInfo(_pDefaultChaInfo->sFootfall);
	if(pMusicInfo)
	{
	  _pszFootMusic = pMusicInfo->szDataName;
	}
  }

  _pszWhoopMusic = NULL;
  if(_pDefaultChaInfo->sWhoop != -1)
  {
	CMusicInfo* pMusicInfo = GetMusicInfo(_pDefaultChaInfo->sWhoop);
	if(pMusicInfo)
	{
	  _pszWhoopMusic = pMusicInfo->szDataName;
	}
  }

  _fMaxOpacity = (float)_pDefaultChaInfo->chDiaphaneity / 100.0f;
}

bool CCharacter::PlayPose(DWORD pose, DWORD type, int time, int fps, bool isBlend)
{
  //fps = CGameApp::GetFrameFPS();
  //	LG( getLogName(), "Pose:%d, type:%d, time:%d\n", pose, type, time, fps );

  bool rv = GetCurPoseType() == pose;

#if 1
  // 飞行用（测试代码）
  if(GetIsFly())
  {
	if(pose == POSE_WAITING || pose == POSE_WAITING2) pose = POSE_FLY_WAITING; // 站立 -> 飞行
	if(pose == POSE_RUN || pose == POSE_RUN2) pose = POSE_FLY_RUN;			   // 走动 -> 飘走
	if(pose == POSE_SHOW) pose = POSE_FLY_SHOW;								   // 摆酷 -> 空中摆酷
	if(pose == POSE_SEAT) pose = POSE_FLY_SEAT;								   // 坐下 -> 空中悬空坐
  }
#endif

  if((GetCurPoseType() == POSE_RUN2) || (GetCurPoseType() == POSE_RUN) || GetCurPoseType() == POSE_FLY_RUN)
  {
	if((pose != POSE_RUN2) && (pose != POSE_RUN) && (pose != POSE_FLY_RUN))
	{
	  GetScene()->HandleSceneMsg(SCENEMSG_CHA_ENDMOVE, getTypeID(), getID());
	}
  } else
  {
	if((pose == POSE_RUN2) || (pose == POSE_RUN) || (pose == POSE_FLY_RUN))
	{
	  GetScene()->HandleSceneMsg(SCENEMSG_CHA_BEGINMOVE, getTypeID(), getID());
	}
  }

  if(isBlend)
  {
	CCharacterModel::PlayPose(pose, type, time, fps, 1);
  } else
  {
	if(enumMODAL_MAIN_CHA == _eChaModalType && pose > POSE_WAITING && pose < POSE_ATTACK)
	{
	  CCharacterModel::PlayPose(pose, type, time, fps, 1);
	} else
	{
	  CCharacterModel::PlayPose(pose, type, time, fps, 0);
	}
  }

  if(rv) return false;

  switch(pose)
  {
  case POSE_WAITING2:
	CGameScene::PlayEnvSound(_pDefaultChaInfo->sWhoop, GetCurX(), GetCurY());
	break;
  case POSE_DIE:
	CGameScene::PlayEnvSound(_pDefaultChaInfo->sDirge, GetCurX(), GetCurY());
	break;
  }
  return true;
}

void CCharacter::_FightSwitch(bool isFight)
{
  _IsFightPose = isFight;
  if(isFight)
  {
	DetachItem(21);
	DetachItem(22);
	DetachItem(23);

	int dummy = -1;
	if(_pHandItem[enumEQUIP_LHAND])
	{
	  AttachItem(enumEQUIP_LHAND, _pHandItem[enumEQUIP_LHAND], -1);

	  dummy = GetWeaponBackDummy(_pHandItem[enumEQUIP_LHAND]->GetItemInfo()->sType, true);
	  if(dummy > 0)
	  {
		_pHandItem[enumEQUIP_LHAND]->setAlpla();
	  }
	}

	if(_pHandItem[enumEQUIP_RHAND])
	{
	  AttachItem(enumEQUIP_RHAND, _pHandItem[enumEQUIP_RHAND], -1);

	  dummy = GetWeaponBackDummy(_pHandItem[enumEQUIP_RHAND]->GetItemInfo()->sType, false);
	  if(dummy > 0)
	  {
		_pHandItem[enumEQUIP_RHAND]->setAlpla();
	  }
	}
  } else
  {
	int dummy = -1;
	if(_pHandItem[enumEQUIP_LHAND])
	{
	  dummy = GetWeaponBackDummy(_pHandItem[enumEQUIP_LHAND]->GetItemInfo()->sType, true);
	  if(dummy > 0)
	  {
		DetachItem(enumEQUIP_LHAND);

		AttachItem(dummy, _pHandItem[enumEQUIP_LHAND], -1, 3);
		_pHandItem[enumEQUIP_LHAND]->setAlpla();
	  } else
	  {
		AttachItem(enumEQUIP_LHAND, _pHandItem[enumEQUIP_LHAND], -1);
	  }
	}
	if(_pHandItem[enumEQUIP_RHAND])
	{
	  dummy = GetWeaponBackDummy(_pHandItem[enumEQUIP_RHAND]->GetItemInfo()->sType, false);
	  if(dummy > 0)
	  {
		DetachItem(enumEQUIP_RHAND);

		AttachItem(dummy, _pHandItem[enumEQUIP_RHAND], -1, 3);
		_pHandItem[enumEQUIP_RHAND]->setAlpla();
	  } else
	  {
		AttachItem(enumEQUIP_RHAND, _pHandItem[enumEQUIP_RHAND], -1);
	  }
	}
  }
}

void CCharacter::UpdataFace(stNetChangeChaPart& stPart)
{
  int nCharID = getTypeID();
  int itemID  = stPart.SLink[enumEQUIP_NECK].sID;
  //short *itemEnergy = stPart.SLink[enumEQUIP_NECK].sEnergy;
  /*if( IsPlayer() && !IsBoat() )
	{
		if ( itemID == 6947 )
		{
			SetPreNameByEnergy( itemID, itemEnergy, _szPreName, _szPreColor, sizeof(_szPreName) );
		}
		else
		{
			SetPreName( itemID, _szPreName, _szPreColor,sizeof(_szPreName) );
		}	
	}
	else
	{
		_szPreName[0] = '\0';
	}*/
  // rain add begin
  if(!IsBoat() && (nCharID == 1 || nCharID == 2) && (itemID == 6707 || itemID == 6708))
  {
	SetPreNameSex(itemID, _szPreName, _szPreColor, sizeof(_szPreName));
	//		SetPreNameByEnergy( itemID, itemEnergy, _szPreName, _szPreColor, sizeof(_szPreName), 1 );
  } else if(!IsBoat() && (nCharID == 3 || nCharID == 4) && (itemID == 6707 || itemID == 6708))
  {
	SetPreNameSex(itemID + 10, _szPreName, _szPreColor, sizeof(_szPreName));
	//		SetPreNameByEnergy( itemID+10, itemEnergy, _szPreName, _szPreColor, sizeof(_szPreName), 1 );
  }
  //	end
  memcpy(&_stChaPart, &stPart, sizeof(_stChaPart));

  _DetachAllItem();
  int nHairID = stPart.SLink[enumEQUIP_HEAD].sID != 0 ? stPart.SLink[enumEQUIP_HEAD].sID : stPart.sHairID;
  if(!UpdataItem(nHairID, 0) && nHairID != stPart.sHairID)
  {
	UpdataItem(stPart.sHairID, 0);
  }

  for(int i = 1; i < enumEQUIP_NUM; i++)
  {
	UpdataItem(stPart.SLink[i].sID, i);
  }

  //int nCharID = getTypeID();
  if(nCharID >= 1 || nCharID <= 4)
  {
	if(_pHandItem[enumEQUIP_RHAND])
	  _pHandItem[enumEQUIP_RHAND]->SetForgeEffect(stPart.SLink[enumEQUIP_RHAND].lDBParam[0], nCharID);

	if(_pHandItem[enumEQUIP_LHAND])
	  _pHandItem[enumEQUIP_LHAND]->SetForgeEffect(stPart.SLink[enumEQUIP_LHAND].lDBParam[0], nCharID);
  }
  //
  //    // 拳套特殊处理，左手自动装入另一只拳套
  //    if( _pHandItem[enumEQUIP_RHAND] && _pHandItem[enumEQUIP_RHAND]->GetItemInfo()->sType==6 )
  //    {
  //		int id = _pHandItem[enumEQUIP_RHAND]->GetItemInfo()->lID;
  //		const int mitten[][2] = {
  //			61, 200,
  //			62, 201,
  //			63, 202,
  //			64, 203,
  //			65, 204,
  //			66, 205,
  //			67, 206,
  //			68, 207,
  //			69, 208,
  //			70, 209,
  //			71, 210,
  //			72, 211
  //		};
  //		int row = sizeof(mitten)/sizeof(mitten[0][0])/2;
  //		for( int i=0; i<row; i++ )
  //		{
  //			if( mitten[i][0]==id )
  //			{
  //				UpdataItem(mitten[i][1], enumEQUIP_LHAND);
  //				break;
  //			}
  //		}

  // 拳套直接装在手上
  //_FightSwitch( true );
  // }

  //if( _pHandItem[enumEQUIP_LHAND] && _pHandItem[enumEQUIP_LHAND]->GetItemInfo()->sType==29 )
  //{
  // 冲击贝直接装在手上
  //_FightSwitch( true );
  //}

  //int nForgeLv = 0;
  //// 盔甲精炼
  //for( int i=0; i<enumEQUIP_PART_NUM; i++ )
  //{
  //    Unlit( i );
  //    if( stPart.SLink[i].sID>0 )
  //    {
  //        nForgeLv = GetItemForgeLv( stPart.SLink[i].chForgeLv );
  //        if( nForgeLv>=0 )
  //        {
  //            Lit( i, nForgeLv );
  //        }
  //    }
  //}
  //
  //// 道具精炼
  //if( stPart.SLink[enumEQUIP_RHAND].sID>0 && (stPart.SLink[enumEQUIP_RHAND].chForgeLv)>=0 )
  //{
  //}
  //else
  //{
  //}

  //if( stPart.SLink[enumEQUIP_LHAND].sID>0 && (stPart.SLink[enumEQUIP_LHAND].chForgeLv)>=0 )
  //{
  //}
  //else
  //{
  //}

  // 最后才确定武器摆放方式
  RefreshItem(true);
}

xShipInfo* CCharacter::ConvertPartTo8DWORD(stNetChangeChaPart& stPart, DWORD* dwBuf)
{
  xShipInfo* pInfo = ::GetShipInfo(stPart.sBoatID);
  if(!pInfo)
  {
	LG("boat_error", RES_STRING(CL_LANGUAGE_MATCH_20), stPart.sBoatID);
	return NULL;
  }

  // 船只是否可以更新组件
  xShipPartInfo* pData = GetShipPartInfo(pInfo->sBody);
  if(pData == NULL)
  {
	LG("boat_error", RES_STRING(CL_LANGUAGE_MATCH_21), pInfo->sBody);
	return NULL;
  }

  dwBuf[0] = pData->dwModel;
  if(pInfo->byIsUpdate)
  {
	pData = GetShipPartInfo(stPart.sHeader);
	if(pData == NULL)
	{
	  LG("boat_error", RES_STRING(CL_LANGUAGE_MATCH_22), stPart.sHeader);
	  return NULL;
	}
	dwBuf[1] = pData->dwModel;

	pData = GetShipPartInfo(stPart.sEngine);
	if(pData == NULL)
	{
	  LG("boat_error", RES_STRING(CL_LANGUAGE_MATCH_23), stPart.sEngine);
	  return NULL;
	}
	dwBuf[2] = pData->dwModel;

	dwBuf[3] = 0;
	for(int i = 0; i < BOAT_MAXNUM_MOTOR; i++)
	{
	  xShipPartInfo* pMotorData = GetShipPartInfo(pData->sMotor[i]);
	  if(pMotorData)
	  {
		dwBuf[i + 4] = pMotorData->dwModel;
	  } else
	  {
		dwBuf[i + 4] = 0;
	  }
	}
  }
  return pInfo;
}

bool CCharacter::UpdataItem(int nItem, DWORD nLink)
{
  if(enumMODAL_MAIN_CHA != _eChaModalType) return false;

  switch(nLink)
  {
  case 0:
  case 1:
  case 2:
  case 3:
  case 4:
	if(nItem == 0) nItem = _pDefaultChaInfo->sSkinInfo[nLink];

	if(CCharacterModel::ChangePart(nLink, nItem) == 0)
	{
	  // 			LG( getLogName(), "msgChangePart Error, Item[%d], Link[%d]\n\n", nItem, nLink );
	  return false;
	}
	return true;
  case enumEQUIP_LHAND:
  case enumEQUIP_RHAND:
	if(nItem > 0 && nItem != enumEQUIP_BOTH_HAND)
	{
	  if(!_pHandItem[nLink] || _pHandItem[nLink]->GetItemInfo()->lID != nItem)
	  {
		if(_pHandItem[nLink])
		{
		  _pHandItem[nLink]->SetValid(FALSE);
		  _pHandItem[nLink] = NULL;
		}

		CSceneItem* item = _pScene->AddSceneItem(nItem, getTypeID());
		if(item)
		{
		  _pHandItem[nLink] = item;
		} else
		{
		  // 					LG( getLogName(), "msgChangePart AddSceneItem Error, Item[%d], Link[%d]\n\n", nItem, nLink );
		  return false;
		}
	  }
	} else
	{
	  if(_pHandItem[nLink])
	  {
		DetachItem(_pHandItem[nLink]);

		_pHandItem[nLink]->SetValid(FALSE);
		_pHandItem[nLink] = NULL;
	  }
	}
	return false;
  case enumEQUIP_NECK:
  case enumEQUIP_HAND1:
  case enumEQUIP_HAND2:
	return true;
  }
  return false;
}

void CCharacter::setNpcState(DWORD dwState)
{
  if(_pNpcStateItem)
  {
	_pNpcStateItem->SetValid(FALSE);
	_pNpcStateItem = NULL;
  }

  if(_chGMLv)
  {
	if(_chGMLv >= 21 && _chGMLv <= 30)
	{
	  _pNpcStateItem = _pScene->AddSceneItem("hd.lgo");
	} else
	{
	  _pNpcStateItem = _pScene->AddSceneItem("gm.lgo");
	}
  } else if(ROLE_MIS_DELIVERY & dwState)
  {
	_pNpcStateItem = _pScene->AddSceneItem("sighyellow.lgo");
  } else if(ROLE_MIS_ACCEPT & dwState)
  {
	_pNpcStateItem = _pScene->AddSceneItem("sighgreen.lgo");
  } else if(ROLE_MIS_PENDING & dwState)
  {
	_pNpcStateItem = _pScene->AddSceneItem("sighgray.lgo");
  }

  if(_pNpcStateItem)
  {
	_pNpcStateItem->setIsSystem(true);
	_pNpcStateItem->setHeightOff((int)(GetDefaultChaInfo()->fHeight * 100.0f));
	_pNpcStateItem->setPos(GetCurX(), GetCurY());
	_pNpcStateItem->PlayDefaultAnimation();
	_pNpcStateItem->setYaw(0);
  }
}

void CCharacter::DieTime()
{
  int		  size = (int)GetEffectNum();
  int		  id;
  CEffectObj* pEff;
  for(int n = 0; n < size; n++)
  {
	id = GetEffectID(n);
	if(id < 0)
	  continue;
	pEff = GetScene()->GetEffect(id);
	if(pEff && pEff->IsValid())
	{
	  pEff->SetValid(FALSE);
	}
  }
  RemoveEffect();

  if(GetDrunkState()) CCharacterModel::SetDrunkState(FALSE);

  if(_pBoatFog)
  {
	_pBoatFog->SetValid(FALSE);
	_pBoatFog = NULL;
  }
  if(_pShopItem)
  {
	_pShopItem->SetValid(FALSE);
	_pShopItem = NULL;
  }
  if(_pNpcStateItem)
  {
	_pNpcStateItem->SetValid(FALSE);
	_pNpcStateItem = NULL;
  }

  for(int i = 0; i < ITEM_FACE_MAX; i++)
	SetItemFace(i, 0);
  // setSideID( 0 );
}

void CCharacter::SynchroSkillState(stSkillState* pState, int nCount)
{
  static CBoolSet set;
  set = _pChaState->Synchro(pState, nCount);

  if(set.IsTrue(enumChaStateNoShop) != _ChaState.IsTrue(enumChaStateNoShop))
  {
	if(_pShopItem)
	{
	  _pShopItem->SetValid(FALSE);
	  _pShopItem = NULL;
	}

	if(set.IsFalse(enumChaStateNoShop))
	{
	  if(g_IsShowShop)
	  {
		switch(CChaStateMgr::GetLastShopLevel())
		{
		case 1:
		  // PlayPose( POSE_WAITING, PLAY_LOOP_SMOOTH );
		  _pShopItem = _pScene->AddSceneItem("baitan1.lgo");
		  break;
		default:
		  // PlayPose( POSE_SEAT, PLAY_LOOP_SMOOTH );
		  _pShopItem = _pScene->AddSceneItem("baitan2.lgo");
		  break;
		}
		if(_pShopItem)
		{
		  _pShopItem->setIsSystem(true);
		  _pShopItem->setYaw(getYaw());
		  _pShopItem->setPos(GetCurX(), GetCurY());
		}
	  }
	} else
	{
	  g_stUIBooth.CloseBoothByOther(getAttachID());
	}
  }

  if(set.IsTrue(enumChaStateNoHide) != _ChaState.IsTrue(enumChaStateNoHide))
  {
	if(set.IsTrue(enumChaStateNoHide))
	  SetOpacity(_fMaxOpacity);
	else
	  SetOpacity(_fMaxOpacity / 2.0f);
  }

  if(set.IsTrue(enumChaStateNoAni) != _ChaState.IsTrue(enumChaStateNoAni))
  {
	if(set.IsTrue(enumChaStateNoAni))
	{
	  if(IsMainCha())
	  {
		g_pGameApp->EnableCameraFollow(TRUE);
	  }

	  StopAni();
	} else
	{
	  if(IsMainCha())
	  {
		g_pGameApp->EnableCameraFollow(FALSE);
	  }

	  PlayAni(CChaStateMgr::GetLastActInfo()->nActBehave, CChaStateMgr::GetLastActInfo()->GetActNum());
	}
  }

  //if( set.IsTrue(enumChaStateMove) != _ChaState.IsTrue(enumChaStateMove) )
  //{
  //	if( set.IsTrue( enumChaStateMove ) ) PlayPoseContinue();
  //	else PlayPosePause();
  //}

  if(set.IsTrue(enumChaStateNoDizzy) != _ChaState.IsTrue(enumChaStateNoDizzy))
  {
	if(_pDefaultChaInfo->IsCyclone())
	{
	  if(set.IsTrue(enumChaStateNoDizzy))
	  {
		CCharacterModel::SetDrunkState(FALSE);

		//CDizzyState* pState = dynamic_cast<CDizzyState*>(GetActor()->GetCurState());
		//if( pState ) pState->Stop();
	  } else
	  {
		CCharacterModel::SetDrunkState(TRUE);
		//GetActor()->OverAllState();
		//CDizzyState* pState = new CDizzyState(GetActor());
		//GetActor()->SwitchState( pState );

		//set.SetFalse( enumChaStateMove );
		//set.SetFalse( enumChaStateAttack );
		//set.SetFalse( enumChaStateUseSkill );
	  }
	}
  }

  _ChaState = set;
}

void CCharacter::RefreshShopShop()
{
  if(_pShopItem)
  {
	_pShopItem->SetValid(FALSE);
	_pShopItem = NULL;
  }

  if(g_IsShowShop && _ChaState.IsFalse(enumChaStateNoShop))
  {
	switch(CChaStateMgr::GetLastShopLevel())
	{
	case 1:
	  // PlayPose( POSE_WAITING, PLAY_LOOP_SMOOTH );
	  _pShopItem = _pScene->AddSceneItem("baitan1.lgo");
	  break;
	default:
	  // PlayPose( POSE_SEAT, PLAY_LOOP_SMOOTH );
	  _pShopItem = _pScene->AddSceneItem("baitan2.lgo");
	  break;
	}
	if(_pShopItem)
	{
	  _pShopItem->setIsSystem(true);
	  _pShopItem->setYaw(getYaw());
	  _pShopItem->setPos(GetCurX(), GetCurY());
	}
  }
}

bool CCharacter::GetRunTimeMatrix(MPMatrix44* mat, DWORD dummy_id)
{
  return GetObjDummyRunTimeMatrix(mat, dummy_id) == 0;
}

void CCharacter::LoadingCall()
{
  RefreshItem(true);
}

void CCharacter::RefreshItem(bool isFirst)
{
  if(isFirst)
  {
	CheckIsFightArea();

	_FightSwitch(_InFight);

	PlayPose(GetPose(GetCurPoseType()), PLAY_LOOP_SMOOTH);
  } else
  {
	if(_InFight != _IsFightPose)
	{
	  _FightSwitch(_InFight);
	}
  }
}

void CCharacter::SwitchFightPose()
{
  if(!_IsFightPose)
  {
	_FightSwitch(true);
  }
}

void CCharacter::ForceMove(int nTargetX, int nTargetY)
{
  if(_nCurX == nTargetX && _nCurY == nTargetY)
  {
	_isArrive = true;
	return;
  }

  _nTargetX = nTargetX;
  _nTargetY = nTargetY;

  _IsMoveTimeType = !IsMainCha();
  if(_IsMoveTimeType)
  {
	_fMoveSpeed = (float)getMoveSpeed() / 950.0f;
	_fMoveLen	= (int)GetDistance(_nCurX, _nCurY, nTargetX, nTargetY) + 1.0f;
	if(_fMoveLen > 0.0f)
	{
	  _dwStartTime = CGameApp::GetCurTick();

	  _vMoveStart.x = (float)_nCurX;
	  _vMoveStart.y = (float)_nCurY;
	  _vMoveEnd.x	= (float)nTargetX;
	  _vMoveEnd.y	= (float)nTargetY;
	  _vMoveDir		= _vMoveEnd - _vMoveStart;
	  D3DXVec2Normalize(&_vMoveDir, &_vMoveDir);
	  _isArrive	  = false;
	  _isStopMove = false;
	} else
	{
	  _isArrive = true;
	}
  } else
  {
	float fDistance = (float)GetDistance(_nCurX, _nCurY, nTargetX, nTargetY);
	if(g_Render.IsRealFPS())
	{
	  const auto fps = std::max<DWORD>(10, g_Render.GetFPS());
	  _fStep	= 1.0f / (fDistance / (float)getMoveSpeed() * (float)(fps + 2));
	} else
	{
	  if(CGameApp::GetFrameFPS() == 30)
		_fStep = 1.0f / (fDistance / (float)getMoveSpeed() * (float)(CGameApp::GetFrameFPS() + 2));
	  else
		_fStep = 1.0f / (fDistance / (float)getMoveSpeed() * (float)(CGameApp::GetFrameFPS() + 2));
	}
	//  	IP("_nCur(%d,%d) ->(%d,%d), Dxy(%d,%d) fDistance=%f _fStep=%f\n",
	//  		_nCurX, _nCurY, nTargetX, nTargetY, nTargetX-_nCurX, nTargetY-_nCurY,fDistance,_fStep);

	if(_fStep > 1.0)
	{
	  _isArrive = true;
	  return;
	}

	_nLastPosX = _nCurX;
	_nLastPosY = _nCurY;

	_fStepProgressRate = 0.0;
	_isArrive		   = false;

	_isStopMove = false;
  }
}

void CCharacter::ResetReadySkill()
{
  CCommandObj::Cancel();
  _SetReadySkill(NULL);
}

void CCharacter::SetHide(BOOL bHide)
{
  if(_bHide == bHide) return;

  _bHide = bHide;
  RefreshShadow();

  int i;
  for(i = 0; i < enumEQUIP_NUM; i++)
	if(_pHandItem[i])
	  _pHandItem[i]->SetHide(bHide);

  if(_pNpcStateItem) _pNpcStateItem->SetHide(bHide);

  if(_pShopItem) _pShopItem->SetHide(bHide);

  if(_pSideShade) _pSideShade->SetHide(bHide);

  for(i = 0; i < GetEffectNum(); i++)
  {
	GetScene()->GetEffect(GetEffectID(i))->SetHide(bHide);
  }
  for(i = 0; i < GetShadeNum(); i++)
  {
	GetScene()->GetShadeObj(GetShadeID(i))->SetHide(bHide);
  }
  if(_pBoatFog)
  {
	_pBoatFog->SetHide(bHide);
  }

  for(/*int */ i = 0; i < ITEM_FACE_MAX; i++)
  {
	if(_pItemFaceEff[i])
	{
	  _pItemFaceEff[i]->SetHide(bHide);
	}
  }
}

void CCharacter::RefreshFog()
{
  if(!_pDefaultChaInfo->HaveEffectFog()) return;

  if(_bHide) return;

  static float hp[] = {0.2f, 0.5f, 0.8f};

  int nIDX = 0;
  if(_pBoatFog)
  {
	nIDX = _pBoatFog->getIdxID();
  }

  int	nEffectID = 0;
  float fHPRate	  = (float)getGameAttr()->get(ATTR_HP) / (float)getGameAttr()->get(ATTR_MXHP);
  if(fHPRate < hp[0])
  {
	nEffectID = _pDefaultChaInfo->GetEffectFog(0);
  } else if(fHPRate < hp[1])
  {
	nEffectID = _pDefaultChaInfo->GetEffectFog(1);
  } else if(fHPRate < hp[2])
  {
	nEffectID = _pDefaultChaInfo->GetEffectFog(2);
  }

  if(nEffectID != nIDX)
  {
	if(_pBoatFog)
	{
	  _pBoatFog->SetValid(FALSE);
	}
	_pBoatFog = SelfEffect(nEffectID, 4, true);
  }
}

void CCharacter::SetItemFace(unsigned int nIndex, int nItem)
{
  if(nIndex >= ITEM_FACE_MAX) return;

  if(nItem == _ItemFace[nIndex]) return;

  _ItemFace[nIndex] = nItem;

  if(_pItemFaceEff[nIndex])
  {
	_pItemFaceEff[nIndex]->SetValid(FALSE);
	_pItemFaceEff[nIndex] = NULL;
  }

  CItemRecord* pInfo = GetItemRecordInfo(nItem);
  if(!pInfo || pInfo->sItemEffect[0] == 0) return;

  switch(nIndex)
  {
  case 0: // 第一栏放置翅膀
	if(pInfo->sType != enumItemTypeWing)
	{
	  return;
	} else
	{
	  DWORD pose = GetCurPoseType();
	  if(GetIsFly() && (pose == POSE_WAITING || pose == POSE_WAITING2))
		PlayPose(POSE_FLY_WAITING); // 站立 -> 飞行

	  CCharacter* pCha = this;
	  if(g_stUIMap.IsPKSilver() && pCha->IsPlayer() && pCha->GetMainType() != enumMainPlayer)
		return;

	  if(pInfo->sNeedLv > this->_Attr.get(ATTR_LV))
		return;

	  if(pInfo->chBody[0] != -1)
	  {
		bool bFlag = false;
		for(int i = 0; i < defITEM_BODY; i++)
		{
		  if(pInfo->chBody[i] != -1 && pInfo->chBody[i] == GetDefaultChaInfo()->lID)
		  {
			bFlag = true;
			break;
		  }
		}
		if(!bFlag) return;
	  }
	}
	break;
  case 1:
	if(pInfo->sType != enumItemTypePet)
	{
	  return; // 第二栏放宠物精灵
	} else
	{
	  CCharacter* pCha = this;
	  if(g_stUIMap.IsPKSilver() && pCha->IsPlayer() && pCha->GetMainType() != enumMainPlayer)
		return;

	  if(pInfo->sNeedLv > this->_Attr.get(ATTR_LV))
		return;

	  if(pInfo->chBody[0] != -1)
	  {
		bool bFlag = false;
		for(int i = 0; i < defITEM_BODY; i++)
		{
		  if(pInfo->chBody[i] != -1 && pInfo->chBody[i] == GetDefaultChaInfo()->lID)
		  {
			bFlag = true;
			break;
		  }
		}
		if(!bFlag) return;
	  }
	}
	break;

  case 3:
	if(pInfo->sType != 77)
	  return;
	break;

  default: return;
  }

  CEffectObj* pEffect = _pScene->GetFirstInvalidEffObj();
  if(!pEffect) return;

  if(!pEffect->Create(pInfo->sItemEffect[0]))
	return;

  pEffect->setLoop(true);
  pEffect->setFollowObj((CSceneNode*)this, NODE_CHA, pInfo->sItemEffect[1]);
  pEffect->Emission(-1, NULL, NULL);
  pEffect->SetValid(TRUE);

  _pItemFaceEff[nIndex] = pEffect;
}

bool CCharacter::GetIsPet()
{
  long nID = GetDefaultChaInfo()->lID;

  switch(nID)
  {
  case 929: // 圣诞小老人
  case 930: // 剃光毛的火鸡
  case 931: // 麋鹿宝宝
  case 932: // 雪人宝宝
	return true;
  }
  return false;
}

#ifdef _KOSDEMO_
void CCharacter::KosDemoControl()
{
  if(GetIsPet())
  {
	if(nPetHideCount <= 0)
	{
	  return;
	}
	if(nPetHideCount == 1)
	{
	  SetHide(TRUE);
	}
	nPetHideCount--;
	return;
  }
  if(IsMainCha())
  {
	if(nMainChaChangeItemCount <= 0)
	{
	  return;
	}
	if(nMainChaChangeItemCount == 1)
	{
	  //do something about change item
	  UpdataItem(465, 3);
	  if(!curEff)
	  {
		curEff = SelfEffect(951, -1, true, -1, 999);
		curEff->SetScale(0.6f, 0.6f, 0.6f);
	  }
	  curEff->SetHide(false);
	}
	if(nMainChaChangeItemCount == 40)
	{
	  PlayPose(20);
	}
	nMainChaChangeItemCount--;
	return;
  }
  return;
}
#endif

bool CCharacter::GetIsFly()
{
  int nID = GetItemFace(0);
  return (128 <= nID && nID <= 140 && nID != 135) ? true : false;

  //CItemRecord* pItem = GetItemRecordInfo(GetItemFace(0));
  //return (pItem && pItem->sType == 44 && _Attr.get(ATTR_SAILLV) > 0) ? true : false;
}

void CCharacter::_computeLinkedMatrix()
{
  if(mParentNode)
  {
	MPMatrix44 mat;
	mParentNode->GetRunTimeMatrix(&mat, mParentBoneID);

	// extract translation information from parent bone.
	D3DXVECTOR3 pos;
	pos.x = mat._41;
	pos.y = mat._42;
	pos.z = mat._43;

	// extract scaling information from parent bone.
	D3DXVECTOR3 scale;
	scale.x = sqrt(mat._11 * mat._11 + mat._21 * mat._21 + mat._31 * mat._31);
	scale.y = sqrt(mat._12 * mat._12 + mat._22 * mat._22 + mat._32 * mat._32);
	scale.z = sqrt(mat._13 * mat._13 + mat._23 * mat._23 + mat._33 * mat._33);

	// extract rotation information from parent bone.
	float rotZ = D3DX_PI - atan2(mat._21, mat._11);
	float rotY = -asin(-mat._31 / scale.x); //
	float rotX = -atan2(mat._32 / scale.y, mat._33 / scale.z);

	float yaw	= Radian2Angle(rotZ);
	float pitch = Radian2Angle(rotY);
	float roll	= Radian2Angle(rotX);

	//SetPos((float*)(&pos));
	setPos(int(pos.x * 100.f), int(pos.y * 100.f));
	SetScale(scale);
	setYaw(int(yaw));
	setPitch(int(pitch));
	setRoll(int(roll));
  }
}

//add by ALLEN 2007-10-16
bool CCharacter::IsReadingBook()
{
  CReadingState* pState = dynamic_cast<CReadingState*>(GetActor()->GetCurState());
  return (0 != pState);
}
