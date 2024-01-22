
#include "StdAfx.h"
#include "Character.h"
#include "Scene.h"
#include "GameApp.h"
#include "actor.h"
#include "NetProtocol.h"
#include "PacketCmd.h"
#include "GameAppMsg.h"
#include "CharacterRecord.h"
#include "DrawPointList.h"
#include "Algo.h"
#include "NetChat.h"
#include "NetGuild.h"
#include "CommFunc.h"
#include "ShipSet.h"
#include "GameConfig.h"
#include "GameWG.h"
#include "UIEquipForm.h"
#include "UIDoublePwdForm.h"
#include "uisystemform.h"
#include "uiStoreForm.h"
#include "uiBourseForm.h"
#include "uipksilverform.h"
#include "uicomposeform.h"
#include "UIBreakForm.h"
#include "UIFoundForm.h"
#include "UICookingForm.h"
#include "UISpiritForm.h"
#include "UIFindTeamForm.h"
#include "UINpcTradeForm.h"
#include "UIChat.h"
#include "UIMailForm.h"
#include "UIMiniMapForm.h"
#include "UINumAnswer.h"
#include "UIChurchChallenge.h"
#include "UIStartForm.h"
#include "UIAllButtonForm.h"
#include "uijewelryupform.h"
#include "uirumdealform.h"
#include "CPerformance.h"
#include "WorldScene.h"

#ifdef _XTRAP_
#include "Xtrap_C_Interface.h"
#endif

//#include "util2.h"

_DBC_USING

//--------------------------------------------------
// 网络协议处理规范
// 处理函数命名
//      PacketCmd_DoSomething(LPPacket pk)
//
// 操作对象命名
//      角色 CCharacter *pCha
//      主角 CCharacter* pMainCha
//      物件 CSceneItem* pItem
//      场景 CGameScene* pScene
//      APP  CGameApp*   g_pGameApp
//--------------------------------------------------
static unsigned long g_ulWorldID = 0;

#ifdef _KOSDEMO_
DWORD PetWorldID = 0;
#endif

BOOL SC_RSAHandshake1(LPRPACKET pk) {
  T_B
  // Signal to client that we are connected, but no handshake yet.
  g_NetIF->m_connect.CHAPSTR();
  CGameApp::Waiting(true, "Securing connection...");
  uShort  len;
  const char* pemKey = pk.ReadString(&len);
  std::vector<uint8_t> input(pemKey, pemKey + sizeof(uint8_t) * len);
  g_NetIF->m_srvPublicKey = Botan::X509::load_key(input);


  WPacket wpk = g_NetIF->GetWPacket();
  std::string PEM_encoded = Botan::X509::PEM_encode(*g_NetIF->m_clientPrivateKey); // No copy
  wpk.WriteCmd(CMD_CM_RSA_HANDSHAKE_1);
  wpk.WriteString(PEM_encoded.c_str());
  g_NetIF->SendPacketMessage(wpk);
  return TRUE;
  T_E
}

BOOL SC_RSAHandshake2(LPRPACKET pk)
{
  T_B
  uShort  len_aes;
  const char*					encrypted_aes_key = pk.ReadSequence(len_aes);
  uShort						len_iv;
  const char*					encrypted_iv = pk.ReadSequence(len_iv);
  uShort						test_len;
  const char*					encrypted_test = pk.ReadSequence(test_len);
  Botan::AutoSeeded_RNG	  rng;
  Botan::PK_Decryptor_EME dec(*g_NetIF->m_clientPrivateKey, rng, "OAEP(SHA-256)");
  Botan::secure_vector<uint8_t> decrypted_aes = dec.decrypt((uint8_t*)encrypted_aes_key, len_aes);
  Botan::secure_vector<uint8_t> decrypted_iv  = dec.decrypt((uint8_t*)encrypted_iv, len_iv);

  // Store AES + last nonce used 
  // Always regenerate IV and send it as plaintext along encrypted text.
  memcpy(g_NetIF->m_AESKey, decrypted_aes.data(), decrypted_aes.size());
  memcpy(g_NetIF->m_IV, decrypted_iv.data(), decrypted_iv.size());

  g_NetIF->m_connect.HandshakeDone();
  return TRUE;
  T_E
}

BOOL SC_Login(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();

  if(l_errno) //失败
  {
	cChar* l_errtext = pk.ReadString();
	NetLoginFailure(l_errno);
  } else //成功
  {
	//Add by sunny.sun 20090205
	const char* sessionKey = pk.ReadString();
	g_stUIChat._PictureCChat.setServerKey(const_cast<char*>(sessionKey)); //add guojiangang 20090211

	g_stUIChat._PictureCChat.setUserName(g_NetIF->m_accounts); //add guojiangang 20090211

	char		 l_chanum = pk.ReadChar();
	NetChaBehave l_netcha[10];
	uShort		 l_looklen;
	for(int i = 0; i < l_chanum; i++)
	{
	  if(!pk.ReadChar())
	  {
		i--;
		l_chanum--;
		continue;
	  }
	  l_netcha[i].sCharName = pk.ReadString();
	  l_netcha[i].sJob		= pk.ReadString();
	  l_netcha[i].iDegree	= pk.ReadShort();
	  l_netcha[i].sLook		= reinterpret_cast<const LOOK*>(pk.ReadSequence(l_looklen));
	  /*if(l_looklen !=sizeof(LOOK))
			{
				i--;l_chanum--;
			}*/
	}

	char chPassword = pk.ReadChar();

	NetLoginSuccess(chPassword, l_chanum, l_netcha);

	// 保存加密信息
	g_NetIF->_comm_enc = pk.ReadLong();
	DWORD dwFlag	   = pk.ReadLong(); //0x3214

	g_NetIF->_enc = true;

	// 启动外挂检测线程  add by Philip.Wu  2006-07-10
	extern CGameWG g_oGameWG;
	g_oGameWG.SafeTerminateThread();
	g_oGameWG.BeginThread();
  }

  return TRUE;
  T_E
}

//--------------------
// 协议S->C : 选择角色
//--------------------
BOOL SC_EnterMap(LPRPACKET pk)
{
  T_B
	  //	g_LogName.Init();

	  CWorldScene* pWorldScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(pWorldScene)
	pWorldScene->ClearSelectUI();

  g_listguild_begin = false;

  stNetSwitchMap SMapInfo;
  memset(&SMapInfo, 0, sizeof(SMapInfo));
  SMapInfo.sEnterRet = pk.ReadShort();
  if(SMapInfo.sEnterRet != ERR_SUCCESS)
  {
	NetSwitchMap(SMapInfo);
	return FALSE;
  }

  bool bAutoLock								= pk.ReadChar() ? true : false; // 自动锁状态
  bool bKitbagLock								= pk.ReadChar() ? true : false; // 是否已锁背包
  g_stUISystem.m_sysProp.m_gameOption.bLockMode = bAutoLock;
  g_stUIEquip.SetIsLock(bKitbagLock);

  SMapInfo.chEnterType = pk.ReadChar(); // 进入地图类型，参见CompCommand.h EEnterMapType
  SMapInfo.bIsNewCha   = pk.ReadChar() == 1 ? true : false;
  SMapInfo.szMapName   = (char*)pk.ReadString();
  SMapInfo.bCanTeam	   = pk.ReadChar() != 0 ? true : false;
  NetSwitchMap(SMapInfo);
  //	LG(RES_STRING(CL_LANGUAGE_MATCH_295), "%s\n", SMapInfo.szMapName);

  stNetActorCreate SCreateInfo;
  ReadChaBasePacket(pk, SCreateInfo);
  SCreateInfo.chSeeType = enumENTITY_SEEN_NEW;
  SCreateInfo.chMainCha = 1;
  SCreateInfo.CreateCha();
  g_pGameApp->GetMainCam()->m_bSelectMode = false;

  g_ulWorldID = SCreateInfo.ulWorldID;

  // 	char* szLogName = g_LogName.GetLogName( SCreateInfo.ulWorldID );

  stNetSkillBag SCurSkill;
  ReadChaSkillBagPacket(pk, SCurSkill);
  NetSynSkillBag(SCreateInfo.ulWorldID, &SCurSkill);

  stNetSkillState SCurSState;
  ReadChaSkillStatePacket(pk, SCurSState);
  NetSynSkillState(SCreateInfo.ulWorldID, &SCurSState);

  stNetChaAttr SChaAttr;
  ReadChaAttrPacket(pk, SChaAttr);
  NetSynAttr(SCreateInfo.ulWorldID, SChaAttr.chType, SChaAttr.sNum, SChaAttr.SEff);

#ifdef _XTRAP_
  LPCSTR lpUserID;
  LPCSTR lpServerName;
  LPCSTR lpCharacterName;
  LPCSTR lpCharacterClass;
  DWORD	 dwCharacterLevel;
  SOCKET Socket;

  lpUserID		  = g_NetIF->m_accounts;
  lpServerName	  = g_NetIF->m_connect.GetHostName();
  lpCharacterName = SCreateInfo.szName;
  Socket		  = g_NetIF->m_connect.GetSocket();
  for(int i = 0; i < ATTR_CLIENT_MAX; i++)
  {
	if(SChaAttr.SEff[i].lAttrID == ATTR_LV)
	{
	  dwCharacterLevel = DWORD(SChaAttr.SEff[i].lVal);
	}
	if(SChaAttr.SEff[i].lAttrID == ATTR_JOB)
	{
	  lpCharacterClass = g_GetJobName(short(SChaAttr.SEff[i].lVal));
	  break;
	}
  }
  XTrap_C_SetUserInfoEx(lpUserID, lpServerName, lpCharacterName, lpCharacterClass, dwCharacterLevel, Socket);
#endif

  // 背包
  stNetKitbag SKitbag;
  ReadChaKitbagPacket(pk, SKitbag);
  SKitbag.chBagType = 0;
  NetChangeKitbag(SCreateInfo.ulWorldID, SKitbag);

#if 0
	stNetKitbag SKitbagTemp;
	ReadChaKitbagPacket(pk, SKitbagTemp);
	SKitbagTemp.chBagType = 2;
	NetChangeKitbag(SCreateInfo.ulWorldID, SKitbagTemp);
#endif

  stNetShortCut SShortcut;
  ReadChaShortcutPacket(pk, SShortcut);
  NetShortCut(SCreateInfo.ulWorldID, SShortcut);

  // 船只信息
  char chBoatNum = pk.ReadChar();
  for(char i = 0; i < chBoatNum; i++)
  {
	ReadChaBasePacket(pk, SCreateInfo);
	SCreateInfo.chSeeType = enumENTITY_SEEN_NEW;
	SCreateInfo.chMainCha = 2;
	SCreateInfo.CreateCha();

	// 		szLogName = g_LogName.GetLogName( SCreateInfo.ulWorldID );

	ReadChaAttrPacket(pk, SChaAttr);
	NetSynAttr(SCreateInfo.ulWorldID, SChaAttr.chType, SChaAttr.sNum, SChaAttr.SEff);

	ReadChaKitbagPacket(pk, SKitbag);
	NetChangeKitbag(SCreateInfo.ulWorldID, SKitbag);

	ReadChaSkillStatePacket(pk, SCurSState);
	NetSynSkillState(SCreateInfo.ulWorldID, &SCurSState);
  }

  stNetChangeCha SChangeCha;
  SChangeCha.ulMainChaID = pk.ReadLong();
  NetActorChangeCha(SCreateInfo.ulWorldID, SChangeCha);

  // 临时背包（暂时注释）!!!不要放在entermap里
#if 0
	stNetKitbag SKitbagTemp;
	ReadChaKitbagPacket(pk, SKitbagTemp);
	SKitbagTemp.chBagType = 2;
	NetChangeKitbag(SCreateInfo.ulWorldID, SKitbagTemp);
#endif

  return TRUE;
  T_E
}

BOOL SC_BeginPlay(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();
  NetBeginPlay(l_errno);
  return TRUE;
  T_E
}

BOOL SC_EndPlay(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();

  //char    chPassword  =pk.ReadChar();
  //g_Config.m_IsDoublePwd = chPassword ? true : false;

  char		   l_chanum = pk.ReadChar();
  NetChaBehave l_netcha[10];
  uShort	   l_looklen;
  for(int i = 0; i < l_chanum; i++)
  {
	if(!pk.ReadChar())
	{
	  i--;
	  l_chanum--;
	  continue;
	}
	l_netcha[i].sCharName = pk.ReadString();
	l_netcha[i].sJob	  = pk.ReadString();
	l_netcha[i].iDegree	  = pk.ReadShort();
	l_netcha[i].sLook	  = reinterpret_cast<const LOOK*>(pk.ReadSequence(l_looklen));
	if(l_looklen != sizeof(LOOK))
	{
	  i--;
	  l_chanum--;
	}
  }
  NetEndPlay(l_chanum, l_netcha);

  return TRUE;
  T_E
}

BOOL SC_NewCha(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();
  NetNewCha(l_errno);

  return TRUE;
  T_E
}

BOOL SC_DelCha(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();
  if(l_errno == ERR_PT_HASCRYSTALTRADE)
  {
	CGameApp::Waiting(false);
	g_stUIDoublePwd.CloseAllForm();
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1030));
  } else
	NetDelCha(l_errno);
  return TRUE;
  T_E
}

BOOL SC_CreatePassword2(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();
  NetCreatePassword2(l_errno);
  return TRUE;
  T_E
}

BOOL SC_UpdatePassword2(LPRPACKET pk)
{
  T_B
	  uShort l_errno = pk.ReadShort();
  NetUpdatePassword2(l_errno);
  return TRUE;
  T_E
}

BOOL PC_Ping(LPRPACKET pk)
{
  T_B
	  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_PING);
  g_NetIF->SendPacketMessage(l_wpk);
  return TRUE;
  T_E
}

BOOL SC_Ping(LPRPACKET pk)
{
  T_B
	  //dbc::uLong lID = pk.ReadLong();

	  //g_NetIF->m_curdelay = GetTickCount() - g_NetIF->dwLatencyTime[lID];

	  // xuedong 2004.09.01
	  MutexArmor l(g_NetIF->m_mutmov);

  WPacket wpk = g_NetIF->GetWPacket();
  wpk.WriteCmd(CMD_CM_PING);
  wpk.WriteLong(pk.ReadLong());
  wpk.WriteLong(pk.ReadLong());
  wpk.WriteLong(pk.ReadLong());
  wpk.WriteLong(pk.ReadLong());
  wpk.WriteLong(pk.ReadLong());
  g_NetIF->SendPacketMessage(wpk);
  //g_NetIF->m_ulDelayTime[g_NetIF->m_ulCurStatistic] = g_NetIF->m_curdelay;
  //g_NetIF->m_ulCurStatistic ++;
  //if (g_NetIF->m_ulCurStatistic >= 4)
  //	g_NetIF->m_ulCurStatistic = 0;

  l.unlock();
  // end

  if(g_NetIF->m_curdelay > g_NetIF->m_maxdelay) g_NetIF->m_maxdelay = g_NetIF->m_curdelay;

  if(g_NetIF->m_curdelay < g_NetIF->m_mindelay) g_NetIF->m_mindelay = g_NetIF->m_curdelay;

  return TRUE;
  T_E
}

BOOL SC_CheckPing(LPRPACKET pk)
{
  T_B
	  WPacket wpk = g_NetIF->GetWPacket();
  wpk.WriteCmd(CMD_CM_CHECK_PING);
  g_NetIF->SendPacketMessage(wpk);

  return TRUE;
  T_E
}

BOOL SC_Say(LPRPACKET pk)
{
  T_B
	  uShort l_len;
  stNetSay	 l_netsay;
  l_netsay.m_srcid	 = pk.ReadLong();
  l_netsay.m_content = pk.ReadSequence(l_len);
  NetSay(l_netsay);

  return TRUE;
  T_E
}

//--------------------
// 协议S->C : 系统信息提示
//--------------------
BOOL SC_SysInfo(LPRPACKET pk)
{
  T_B
  uShort	   l_retlen;
  stNetSysInfo l_sysinfo;
  l_sysinfo.m_sysinfo = pk.ReadSequence(l_retlen);
  NetSysInfo(l_sysinfo);
  return TRUE;
  T_E
}

BOOL SC_PopupNotice(LPRPACKET pk)
{
  T_B
	  uShort l_retlen;
  cChar*	 szNotice = pk.ReadSequence(l_retlen);
  g_pGameApp->MsgBox(szNotice);
  return TRUE;
  T_E
}

BOOL SC_BickerNotice(LPRPACKET pk)
{
  T_B char szData[1024];
  //strncpy( szData, pk.ReadString(), 1024 - 1 );
  strncpy_s(szData, 1024 - 1, pk.ReadString(), _TRUNCATE);
  NetBickerInfo(szData);
  return TRUE;
  T_E
}

//------------------------------------
// 协议S->C : 其它角色(包含怪物等)出现
//------------------------------------
BOOL SC_ChaBeginSee(LPRPACKET pk)
{
  T_B
	  stNetActorCreate SCreateInfo;
  char				   chSeeType = pk.ReadChar();

  TInit
	  //TBegin
	  ReadChaBasePacket(pk, SCreateInfo);
  //TEnd
  SCreateInfo.chSeeType = chSeeType;
  SCreateInfo.chMainCha = 0;
  //IP("CreateCha %s\n", SCreateInfo.szName?SCreateInfo.szName:"");
  TBegin
	  CCharacter* pCha = SCreateInfo.CreateCha();
  if(!pCha) return FALSE;
  TEnd
	  // 	char* szLogName = g_LogName.GetLogName( SCreateInfo.ulWorldID );

	  stNetNPCShow SNpcShow;
  // NPC任务状态信息
  SNpcShow.byNpcType  = pk.ReadChar();
  SNpcShow.byNpcState = pk.ReadChar();
  SNpcShow.SetNpcShow(pCha);

  TBegin
	  // 行动数据
	  switch(pk.ReadShort())
  {
  case enumPoseLean:
  {
	stNetLeanInfo SLean;
	SLean.chState = pk.ReadChar();
	SLean.lPose	  = pk.ReadLong();
	SLean.lAngle  = pk.ReadLong();
	SLean.lPosX	  = pk.ReadLong();
	SLean.lPosY	  = pk.ReadLong();
	SLean.lHeight = pk.ReadLong();
	NetActorLean(SCreateInfo.ulWorldID, SLean);
	TEnd break;
  }
  case enumPoseSeat:
  {
	stNetFace SNetFace;
	SNetFace.sAngle = pk.ReadShort();
	SNetFace.sPose	= pk.ReadShort();
	NetFace(SCreateInfo.ulWorldID, SNetFace, enumACTION_SKILL_POSE);
	TEnd break;
  }
  default:
  {
	break;
  }
  }

  stNetChaAttr SChaAttr;
  ReadChaAttrPacket(pk, SChaAttr);
  NetSynAttr(SCreateInfo.ulWorldID, SChaAttr.chType, SChaAttr.sNum, SChaAttr.SEff);

  stNetSkillState SCurSState;
  ReadChaSkillStatePacket(pk, SCurSState);
  NetSynSkillState(SCreateInfo.ulWorldID, &SCurSState);

  return TRUE;
  T_E
}

//------------------------------------
// 协议S->C : 其它角色(包含怪物等)消失
//------------------------------------
BOOL SC_ChaEndSee(LPRPACKET pk)
{
  T_B
  char	chSeeType = pk.ReadChar(); // 参见 CompCommand.h的EEntitySeenType
  uLong l_id	  = pk.ReadLong();
  NetActorDestroy(l_id, chSeeType);

  // log
  //	LG(g_LogName.GetLogName( l_id ), "+++++++++++++Destroy\n");
  //
  return TRUE;
  T_E
}

BOOL SC_ItemCreate(LPRPACKET pk)
{
  T_B
	  stNetItemCreate SCreateInfo;
  memset(&SCreateInfo, 0, sizeof(SCreateInfo));
  SCreateInfo.lWorldID	 = pk.ReadLong(); // world ID
  SCreateInfo.lHandle	 = pk.ReadLong();
  SCreateInfo.lID		 = pk.ReadLong();  // ID
  SCreateInfo.SPos.x	 = pk.ReadLong();  // 当前x位置
  SCreateInfo.SPos.y	 = pk.ReadLong();  // 当前y位置
  SCreateInfo.sAngle	 = pk.ReadShort(); // 方向
  SCreateInfo.sNum		 = pk.ReadShort(); // 方向
  SCreateInfo.chAppeType = pk.ReadChar();  // 出现原因（参见CompCommand.h EItemAppearType）
  SCreateInfo.lFromID	 = pk.ReadLong();  // 抛出源的ID

  ReadEntEventPacket(pk, SCreateInfo.SEvent);

  CSceneItem* CItem = NetCreateItem(SCreateInfo);
  if(!CItem)
	return FALSE;

  // log
  //	LG("SC_Item", "CreateType = %d, WorldID:%u, ItemID = %d, Pos = [%d,%d], SrcID = %u, \n", SCreateInfo.chAppeType, SCreateInfo.lWorldID, SCreateInfo.lID, SCreateInfo.SPos.x, SCreateInfo.SPos.y, SCreateInfo.lFromID);
  //
  return TRUE;
  T_E
}

BOOL SC_ItemDestroy(LPRPACKET pk)
{
  T_B unsigned long lID = pk.ReadLong(); //ID

  NetItemDisappear(lID);
  //	LG("SC_Item", "Item Destroy[%u]\n", lID);
  return TRUE;
  T_E
}

BOOL SC_AStateBeginSee(LPRPACKET pk)
{
  T_B
	  stNetAreaState SynAState;

  char chValidNum	   = 0;
  SynAState.sAreaX	   = pk.ReadShort();
  SynAState.sAreaY	   = pk.ReadShort();
  SynAState.chStateNum = pk.ReadChar();
  for(char j = 0; j < SynAState.chStateNum; j++)
  {
	SynAState.State[chValidNum].chID = pk.ReadChar();
	if(SynAState.State[chValidNum].chID == 0)
	  continue;
	SynAState.State[chValidNum].chLv	   = pk.ReadChar();
	SynAState.State[chValidNum].lWorldID   = pk.ReadLong();
	SynAState.State[chValidNum].uchFightID = pk.ReadChar();
	chValidNum++;
  }
  SynAState.chStateNum = chValidNum;

  NetAreaStateBeginSee(&SynAState);

  // log
  // 	char* szLogName = g_LogName.GetMainLogName();
  //
  // 	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_296), SynAState.sAreaX, SynAState.sAreaY, SynAState.chStateNum);
  // 	for (char j = 0; j < SynAState.chStateNum; j++)
  // 		LG(szLogName, "\t%d\t%d\n", SynAState.State[j].chID, SynAState.State[j].chLv);
  // 	LG(szLogName, "\n");
  //

  return TRUE;
  T_E
}

BOOL SC_AStateEndSee(LPRPACKET pk)
{
  T_B
	  stNetAreaState SynAState;

  SynAState.sAreaX = pk.ReadShort();
  SynAState.sAreaY = pk.ReadShort();

  NetAreaStateEndSee(&SynAState);

  // log
  //	LG(g_LogName.GetMainLogName(), RES_STRING(CL_LANGUAGE_MATCH_296), SynAState.sAreaX, SynAState.sAreaY, 0);
  //

  return TRUE;
  T_E
}

// 协议S->C : 添加道具角色
BOOL SC_AddItemCha(LPRPACKET pk)
{
  T_B long		   lMainChaID = pk.ReadLong();
  stNetActorCreate SCreateInfo;
  ReadChaBasePacket(pk, SCreateInfo);
  SCreateInfo.chSeeType = enumENTITY_SEEN_NEW;
  SCreateInfo.chMainCha = 2;
  SCreateInfo.CreateCha();

  // 	char *szLogName = g_LogName.GetLogName( SCreateInfo.ulWorldID );

  stNetChaAttr SChaAttr;
  ReadChaAttrPacket(pk, SChaAttr);
  NetSynAttr(SCreateInfo.ulWorldID, SChaAttr.chType, SChaAttr.sNum, SChaAttr.SEff);

  stNetKitbag SKitbag;
  ReadChaKitbagPacket(pk, SKitbag);
  SKitbag.chBagType = 0;
  NetChangeKitbag(SCreateInfo.ulWorldID, SKitbag);

  stNetSkillState SCurSState;
  ReadChaSkillStatePacket(pk, SCurSState);
  NetSynSkillState(SCreateInfo.ulWorldID, &SCurSState);

  return TRUE;
  T_E
}

// 协议S->C : 删除道具角色
BOOL SC_DelItemCha(LPRPACKET pk)
{
  T_B long lMainChaID = pk.ReadLong();

  char	chSeeType = enumENTITY_SEEN_NEW;
  uLong l_id	  = pk.ReadLong();
  NetActorDestroy(l_id, chSeeType);

  return TRUE;
  T_E
}

// 怪物表情
BOOL SC_Cha_Emotion(LPRPACKET pk)
{
  T_B
	  uLong l_id	 = pk.ReadLong();
  uShort	sEmotion = pk.ReadShort();

  NetChaEmotion(l_id, sEmotion);
  //	LG( g_LogName.GetLogName( l_id ), RES_STRING(CL_LANGUAGE_MATCH_297), sEmotion );
  return TRUE;
  T_E
}

// 协议S->C : 角色行动通告
BOOL SC_CharacterAction(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  //	char* szLogName = g_LogName.GetLogName( l_id );

  // try
  {
	long lPacketId = 0;
#ifdef defPROTOCOL_HAVE_PACKETID
	lPacketId = pk.ReadLong();
#endif
	//		LG(szLogName, "$$$PacketID:\t%u\n", lPacketId);

	switch(pk.ReadChar())
	{
	case enumACTION_MOVE:
	{
	  stNetNotiMove SMoveInfo;
	  SMoveInfo.sState = pk.ReadShort();
	  if(SMoveInfo.sState != enumMSTATE_ON)
		SMoveInfo.sStopState = pk.ReadShort();
	  Point* STurnPos;
	  uShort ulTurnNum;
	  STurnPos			  = (Point*)pk.ReadSequence(ulTurnNum);
	  SMoveInfo.nPointNum = ulTurnNum / sizeof(Point);
	  memcpy(SMoveInfo.SPos, STurnPos, ulTurnNum);

	  // log
	  //				long lDistX, lDistY, lDist = 0;
	  //				LG(szLogName, "===Recieve(Move):\tTick:[%u]\n", GetTickCount());
	  //				LG(szLogName, "Point:\t%3d\n", SMoveInfo.nPointNum);
	  // 				bool isMainCha = g_LogName.IsMainCha( l_id );
	  // 				for (int i = 0; i < SMoveInfo.nPointNum; i++)
	  // 				{
	  // #ifdef _STATE_DEBUG
	  // 					if( isMainCha )
	  // 					{
	  // 						g_pGameApp->GetDrawPoints()->Add( SMoveInfo.SPos[i].x, SMoveInfo.SPos[i].y, 0xffff0000, 0.5f );
	  // 						if (SMoveInfo.sState && i==SMoveInfo.nPointNum-1)
	  // 						{
	  // 							g_pGameApp->GetDrawPoints()->Add( SMoveInfo.SPos[i].x, SMoveInfo.SPos[i].y, 0xff000000, 0.3f );
	  // 						}
	  // 					}
	  // #endif
	  //
	  // 					if (i > 0)
	  // 					{
	  // 						lDistX = SMoveInfo.SPos[i].x - SMoveInfo.SPos[i - 1].x;
	  // 						lDistY = SMoveInfo.SPos[i].y - SMoveInfo.SPos[i - 1].y;
	  // 						lDist = (long)sqrt((double)lDistX * lDistX + lDistY * lDistY);
	  // 					}
	  //					LG(szLogName, "\t%d, %d\t%d\n", SMoveInfo.SPos[i].x, SMoveInfo.SPos[i].y, lDist);
	  // 				}
	  // 				if (SMoveInfo.sState)
	  // 					LG(szLogName, "@@@End Move\tState:0x%x\n", SMoveInfo.sState);



	  // 				if (SMoveInfo.sState & enumMSTATE_CANCEL)
	  // 				{
	  // 					long	lDist;
	  // 					CCharacter	*pCMainCha = CGameScene::GetMainCha();
	  // 					if( pCMainCha )
	  // 					{
	  // 						lDist = (pCMainCha->GetCurX() - SMoveInfo.SPos[SMoveInfo.nPointNum - 1].x) * (pCMainCha->GetCurX() - SMoveInfo.SPos[SMoveInfo.nPointNum - 1].x)
	  // 							+ (pCMainCha->GetCurY() - SMoveInfo.SPos[SMoveInfo.nPointNum - 1].y) * (pCMainCha->GetCurY() - SMoveInfo.SPos[SMoveInfo.nPointNum - 1].y);
	  // 						LG(szLogName, "++++++++++++++Distance: %d\n", (long)sqrt(double(lDist)));
	  // 					}
	  // 				}
	  // 				LG(szLogName, "\n");
	  //

	  NetActorMove(l_id, SMoveInfo);
	}
	break;
	case enumACTION_SKILL_SRC:
	{
	  stNetNotiSkillRepresent SSkillInfo;
	  SSkillInfo.chCrt		= 0;
	  SSkillInfo.sStopState = enumEXISTS_WAITING;

	  SSkillInfo.byFightID = pk.ReadChar();
	  SSkillInfo.sAngle	   = pk.ReadShort();
	  SSkillInfo.sState	   = pk.ReadShort();
	  if(SSkillInfo.sState != enumFSTATE_ON)
		SSkillInfo.sStopState = pk.ReadShort();
	  SSkillInfo.lSkillID	 = pk.ReadLong();
	  SSkillInfo.lSkillSpeed = pk.ReadLong();
	  char chTarType		 = pk.ReadChar();
	  if(chTarType == 1)
	  {
		SSkillInfo.lTargetID	  = pk.ReadLong();
		SSkillInfo.STargetPoint.x = pk.ReadLong();
		SSkillInfo.STargetPoint.y = pk.ReadLong();
	  } else if(chTarType == 2)
	  {
		SSkillInfo.lTargetID	  = 0;
		SSkillInfo.STargetPoint.x = pk.ReadLong();
		SSkillInfo.STargetPoint.y = pk.ReadLong();
	  }
	  SSkillInfo.sExecTime = pk.ReadShort();

	  // 同步属性
	  short lResNum = pk.ReadShort();
	  if(lResNum > 0)
	  {
		SSkillInfo.SEffect.Resize(lResNum);
		for(long i = 0; i < lResNum; i++)
		{
		  SSkillInfo.SEffect[i].lAttrID = pk.ReadChar();
		  //SSkillInfo.SEffect[i].lVal = pk.ReadLong();
		  if(SSkillInfo.SEffect[i].lAttrID == ATTR_CEXP || SSkillInfo.SEffect[i].lAttrID == ATTR_NLEXP || SSkillInfo.SEffect[i].lAttrID == ATTR_CLEXP)
			SSkillInfo.SEffect[i].lVal = pk.ReadLongLong();
		  else
			SSkillInfo.SEffect[i].lVal = (long)pk.ReadLong();
		}
	  }

	  // 同步技能状态
	  short chSStateNum = pk.ReadChar();
	  if(chSStateNum > 0)
	  {
		SSkillInfo.SState.Resize(chSStateNum);
		for(short chNum = 0; chNum < chSStateNum; chNum++)
		{
		  SSkillInfo.SState[chNum].chID = pk.ReadChar();
		  SSkillInfo.SState[chNum].chLv = pk.ReadChar();
		}
	  }

	  // log
	  // 				LG(szLogName, "===Recieve(Skill Represent):\tTick:[%u]\n", GetTickCount());
	  // 				LG(szLogName, "Angle:\t%d\tFightID:%d\n", SSkillInfo.sAngle, SSkillInfo.byFightID );
	  // 				LG(szLogName, "SkillID:\t%u\tSkillSpeed:%d\n", SSkillInfo.lSkillID, SSkillInfo.lSkillSpeed);
	  // 					LG(szLogName, "TargetInfo(ID, PosX, PosY):\t%d\n", SSkillInfo.lTargetID, SSkillInfo.STargetPoint.x, SSkillInfo.STargetPoint.y);
	  // 				LG(szLogName, "Effect:[ID, Value]\n");
	  // 				for (DWORD i = 0; i < SSkillInfo.SEffect.GetCount(); i++)
	  // 					LG(szLogName, "\t%d,\t%i64\n", SSkillInfo.SEffect[i].lAttrID, SSkillInfo.SEffect[i].lVal);
	  // 				if (SSkillInfo.SState.GetCount() > 0)
	  // 					LG(szLogName, "Skill State:[ID, LV]\n");
	  // 				for (DWORD chNum = 0; chNum < SSkillInfo.SState.GetCount(); chNum++)
	  // 					LG(szLogName, "\t%d, %d\n", SSkillInfo.SState[chNum].chID, SSkillInfo.SState[chNum].chLv);
	  // 				if (SSkillInfo.sState)
	  // 					LG(szLogName, "@@@End Skill\tState:0x%x\n", SSkillInfo.sState);
	  // 				LG(szLogName, "\n");
	  //

	  NetActorSkillRep(l_id, SSkillInfo);
	}
	break;
	case enumACTION_SKILL_TAR:
	{
	  stNetNotiSkillEffect SSkillInfo;

	  SSkillInfo.byFightID	   = pk.ReadChar();
	  SSkillInfo.sState		   = pk.ReadShort();
	  SSkillInfo.bDoubleAttack = pk.ReadChar() ? true : false;
	  SSkillInfo.bMiss		   = pk.ReadChar() ? true : false;
	  if(SSkillInfo.bBeatBack = pk.ReadChar() ? true : false)
	  {
		SSkillInfo.SPos.x = pk.ReadLong();
		SSkillInfo.SPos.y = pk.ReadLong();
	  }
	  SSkillInfo.lSrcID		  = pk.ReadLong();
	  SSkillInfo.SSrcPos.x	  = pk.ReadLong();
	  SSkillInfo.SSrcPos.y	  = pk.ReadLong();
	  SSkillInfo.lSkillID	  = pk.ReadLong();
	  SSkillInfo.SSkillTPos.x = pk.ReadLong();
	  SSkillInfo.SSkillTPos.y = pk.ReadLong();
	  SSkillInfo.sExecTime	  = pk.ReadShort();

	  // 同步属性
	  pk.ReadChar();
	  short lResNum = pk.ReadShort();
	  if(lResNum > 0)
	  {
		SSkillInfo.SEffect.Resize(lResNum);
		for(long i = 0; i < lResNum; i++)
		{
		  SSkillInfo.SEffect[i].lAttrID = pk.ReadChar();
		  //SSkillInfo.SEffect[i].lVal = pk.ReadLong();
		  if(SSkillInfo.SEffect[i].lAttrID == ATTR_CEXP || SSkillInfo.SEffect[i].lAttrID == ATTR_NLEXP || SSkillInfo.SEffect[i].lAttrID == ATTR_CLEXP)
			SSkillInfo.SEffect[i].lVal = pk.ReadLongLong();
		  else
			SSkillInfo.SEffect[i].lVal = (long)pk.ReadLong();

#ifdef _DEBUG
//						IP("ID = %d val = %s\r\n", SSkillInfo.SEffect[i].lAttrID,SSkillInfo.SEffect[i].lVal);
#endif
		}
	  }

	  short chSStateNum = 0;
	  // 同步技能状态
	  if(pk.ReadChar() == 1)
	  {
		chSStateNum = pk.ReadChar();
		if(chSStateNum > 0)
		{
		  SSkillInfo.SState.Resize(chSStateNum);
		  for(short chNum = 0; chNum < chSStateNum; chNum++)
		  {
			SSkillInfo.SState[chNum].chID = pk.ReadChar();
			SSkillInfo.SState[chNum].chLv = pk.ReadChar();
		  }
		}
	  }

	  short lSrcResNum	   = 0;
	  short chSrcSStateNum = 0;
	  if(pk.ReadChar())
	  {
		// 技能源状态
		SSkillInfo.sSrcState = pk.ReadShort();
		// 同步技能源属性
		pk.ReadChar();
		lSrcResNum = pk.ReadShort();
		if(lSrcResNum > 0)
		{
		  SSkillInfo.SSrcEffect.Resize(lSrcResNum);
		  for(long i = 0; i < lSrcResNum; i++)
		  {
			SSkillInfo.SSrcEffect[i].lAttrID = pk.ReadChar();
			//SSkillInfo.SSrcEffect[i].lVal = pk.ReadLong();
			if(SSkillInfo.SSrcEffect[i].lAttrID == ATTR_CEXP || SSkillInfo.SSrcEffect[i].lAttrID == ATTR_NLEXP || SSkillInfo.SSrcEffect[i].lAttrID == ATTR_CLEXP)
			  SSkillInfo.SSrcEffect[i].lVal = pk.ReadLongLong();
			else
			  SSkillInfo.SSrcEffect[i].lVal = (long)pk.ReadLong();
		  }
		}

		if(pk.ReadChar() == 1)
		{
		  // 同步技能源技能状态
		  chSrcSStateNum = pk.ReadChar();
		  if(chSrcSStateNum > 0)
		  {
			SSkillInfo.SSrcState.Resize(chSrcSStateNum);
			for(short chNum = 0; chNum < chSrcSStateNum; chNum++)
			{
			  SSkillInfo.SSrcState[chNum].chID = pk.ReadChar();
			  SSkillInfo.SSrcState[chNum].chLv = pk.ReadChar();
			}
		  }
		}
	  }

	  // log
	  // 				LG(szLogName, "===Recieve(Skill Effect):\tTick:[%u]\n", GetTickCount());
	  // 				LG(szLogName, "SourceChaID:\t%u\tFightID:%d\n", SSkillInfo.lSrcID, SSkillInfo.byFightID);
	  // 				LG(szLogName, "SkillID:\t%u\n", SSkillInfo.lSkillID);
	  // 				LG(szLogName, "State: 0x%x, Double: %d, Miss: %d, Pos[%d, %d], ExecTime: %d, ResNum: %d\n", SSkillInfo.sState, SSkillInfo.bDoubleAttack, SSkillInfo.bMiss, SSkillInfo.SSrcPos.x, SSkillInfo.SSrcPos.y, SSkillInfo.sExecTime, SSkillInfo.SEffect.GetCount() );
	  // 				if (SSkillInfo.bBeatBack)
	  // 					LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_298), SSkillInfo.SPos.x, SSkillInfo.SPos.y);
	  // 				LG(szLogName, "Effect:[ID, Value]\n");
	  // 				for (long i = 0; i < lResNum; i++)
	  // 					LG(szLogName, "\t%d,\t%i64\n", SSkillInfo.SEffect[i].lAttrID, SSkillInfo.SEffect[i].lVal);
	  // 				if (chSStateNum > 0)
	  // 					LG(szLogName, "Skill State:[ID, LV]\n");
	  // 				for (short chNum = 0; chNum < chSStateNum; chNum++)
	  // 					LG(szLogName, "\t%d, %d\n", SSkillInfo.SState[chNum].chID, SSkillInfo.SState[chNum].chLv);
	  //
	  // 				LG(szLogName, "Src Effect:[ID, Value], State: 0x%x\n", SSkillInfo.sSrcState );
	  // 				for (long i = 0; i < lSrcResNum; i++)
	  // 					LG(szLogName, "\t%d,\t%d\n", SSkillInfo.SSrcEffect[i].lAttrID, SSkillInfo.SSrcEffect[i].lVal);
	  // 				if (chSrcSStateNum > 0)
	  // 					LG(szLogName, "Src Skill State:[ID, LV]\n");
	  // 				for (short chNum = 0; chNum < chSrcSStateNum; chNum++)
	  // 					LG(szLogName, "\t%d, %d\n", SSkillInfo.SSrcState[chNum].chID, SSkillInfo.SSrcState[chNum].chLv);
	  // 				if (SSkillInfo.sState & enumFSTATE_DIE)
	  // 					LG(szLogName, "@@@Die\n");
	  // 				LG(szLogName, "\n");
	  //

	  NetActorSkillEff(l_id, SSkillInfo);
	}
	break;
	case enumACTION_LEAN: // 倚靠
	{
	  stNetLeanInfo SLean;
	  SLean.chState = pk.ReadChar();
	  if(!SLean.chState)
	  {
		SLean.lPose	  = pk.ReadLong();
		SLean.lAngle  = pk.ReadLong();
		SLean.lPosX	  = pk.ReadLong();
		SLean.lPosY	  = pk.ReadLong();
		SLean.lHeight = pk.ReadLong();
	  }

	  // log
	  // 				LG(szLogName, "===Recieve(Lean):\tTick:[%u]\n", GetTickCount());
	  // 				if (SLean.chState)
	  // 					LG(szLogName, "@@@End Lean\tState:%d\n", SLean.chState);
	  // 				LG(szLogName, "\n");
	  //

	  NetActorLean(l_id, SLean);
	}
	break;
	case enumACTION_ITEM_FAILED:
	{
	  stNetSysInfo l_sysinfo;
	  short		   sFailedID = pk.ReadShort();
	  l_sysinfo.m_sysinfo	 = g_GetUseItemFailedInfo(sFailedID);
	  NetSysInfo(l_sysinfo);
	}
	break;
	case enumACTION_LOOK: // 更新角色外观
	{
	  stNetLookInfo SLookInfo;
	  ReadChaLookPacket(pk, SLookInfo);
	  CCharacter* pCha = CGameApp::GetCurScene()->SearchByID(l_id);

	  if(!g_stUIMap.IsPKSilver() || pCha->GetMainType() == enumMainPlayer)
	  {
		NetChangeChaPart(l_id, SLookInfo);
	  }
	}
	break;
	case enumACTION_LOOK_ENERGY: // 更新角色外观的能量
	{
	  stLookEnergy SLookEnergy;
	  ReadChaLookEnergyPacket(pk, SLookEnergy);
	  NetChangeChaLookEnergy(l_id, SLookEnergy);
	}
	break;
	case enumACTION_KITBAG: // 更新角色道具栏
	{
	  stNetKitbag SKitbag;
	  ReadChaKitbagPacket(pk, SKitbag);
	  SKitbag.chBagType = 0;
	  NetChangeKitbag(l_id, SKitbag);
	}
	break;
	case enumACTION_ITEM_INFO:
	{
	}
	break;
	case enumACTION_SHORTCUT: // 更新快捷栏
	{
	  stNetShortCut SShortcut;
	  ReadChaShortcutPacket(pk, SShortcut);
	  NetShortCut(l_id, SShortcut);
	}
	break;
	case enumACTION_TEMP:
	{
	  stTempChangeChaPart STempChaPart;
	  STempChaPart.dwItemID = pk.ReadLong();
	  STempChaPart.dwPartID = pk.ReadLong();
	  NetTempChangeChaPart(l_id, STempChaPart);
	}
	break;
	case enumACTION_CHANGE_CHA:
	{
	  stNetChangeCha SChangeCha;
	  SChangeCha.ulMainChaID = pk.ReadLong();

	  NetActorChangeCha(l_id, SChangeCha);
	}
	break;
	case enumACTION_FACE:
	{
	  stNetFace SNetFace;
	  SNetFace.sAngle = pk.ReadShort();
	  SNetFace.sPose  = pk.ReadShort();
	  NetFace(l_id, SNetFace, enumACTION_FACE);

	  // log
	  // 				LG(szLogName, "===Recieve(Face):\tTick:[%u]\n", GetTickCount());
	  // 				LG(szLogName, "Angle[%d]\tPose[%d]\n", SNetFace.sAngle, SNetFace.sPose);
	  // 				LG(szLogName, "\n");
	  //
	}
	break;
	case enumACTION_SKILL_POSE:
	{
	  stNetFace SNetFace;
	  SNetFace.sAngle = pk.ReadShort();
	  SNetFace.sPose  = pk.ReadShort();
	  NetFace(l_id, SNetFace, enumACTION_SKILL_POSE);

	  // log
	  // 				LG(szLogName, "===Recieve(Skill Pos):\tTick:[%u]\n", GetTickCount());
	  // 				LG(szLogName, "Angle[%d]\tPose[%d]\n", SNetFace.sAngle, SNetFace.sPose);
	  // 				LG(szLogName, "\n");
	  //
	}
	break;
	case enumACTION_PK_CTRL:
	{
	  stNetPKCtrl SNetPKCtrl;
	  ReadChaPKPacket(pk, SNetPKCtrl);

	  SNetPKCtrl.Exec(l_id);
	}
	break;
	case enumACTION_BANK: // 打开银行
	{
	  stNetKitbag SKitbag;
	  ReadChaKitbagPacket(pk, SKitbag);
	  SKitbag.chBagType = 1;
	  NetChangeKitbag(l_id, SKitbag);
	}
	break;

	case enumACTION_KITBAGTMP: // 打开临时背包
	{
	  stNetKitbag STempKitbag;
	  ReadChaKitbagPacket(pk, STempKitbag);
	  STempKitbag.chBagType = 2;
	  NetChangeKitbag(l_id, STempKitbag);
	}
	default:
	  break;
	}
  }
  //catch (...)
  //{
  //	MessageBox(0, "!!!!!!!!!!!!!!!!!!!!exception: Notice Action", "error", 0);
  //}

  return TRUE;
  T_E
}

// 协议S->C : 角色请求的行动失败
BOOL SC_FailedAction(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  char chType, chReason;
  chType   = pk.ReadChar();
  chReason = pk.ReadChar();
  NetFailedAction(chReason);
  return TRUE;
  T_E
}

// 同步角色属性
BOOL SC_SynAttribute(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();
  // 	char* szLogName = g_LogName.GetLogName( l_id );

  stNetChaAttr SChaAttr;
  ReadChaAttrPacket(pk, SChaAttr);

  //char val[32];
  //char buff[245];
  //_snprintf_s( buff, _countof( buff ), _TRUNCATE,  "NetSynAttr %s\r\n", _i64toa(SChaAttr.SEff[0].lVal , val, 10));
  //OutputDebugStr(buff);

  NetSynAttr(l_id, SChaAttr.chType, SChaAttr.sNum, SChaAttr.SEff);

  return TRUE;
  T_E
}

// 同步技能栏
BOOL SC_SynSkillBag(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();
  // 	char* szLogName = g_LogName.GetLogName( l_id );

  stNetSkillBag SCurSkill;
  if(ReadChaSkillBagPacket(pk, SCurSkill))
	NetSynSkillBag(l_id, &SCurSkill);

  return TRUE;
  T_E
}

// 同步技能栏
BOOL SC_SynDefaultSkill(LPRPACKET pk)
{
  T_B
	  uLong			l_id = pk.ReadLong();
  stNetDefaultSkill SDefaultSkill;
  SDefaultSkill.sSkillID = pk.ReadShort();
  SDefaultSkill.Exec();
  return TRUE;
  T_E
}

BOOL SC_SynSkillState(LPRPACKET pk)
{
  T_B
  uLong l_id = pk.ReadLong();
  // 	char* szLogName = g_LogName.GetLogName( l_id );

  stNetSkillState SCurSState;
  ReadChaSkillStatePacket(pk, SCurSState);

  NetSynSkillState(l_id, &SCurSState);

  return TRUE;
  T_E
}

BOOL SC_SynTeam(LPRPACKET pk)
{
  T_B
	  stNetTeamState STeamState;

  STeamState.ulID	= pk.ReadLong();
  STeamState.lHP	= pk.ReadLong();
  STeamState.lMaxHP = pk.ReadLong();
  STeamState.lSP	= pk.ReadLong();
  STeamState.lMaxSP = pk.ReadLong();
  STeamState.lLV	= pk.ReadLong();

  // LG( "Team", "Refresh, ID[%u], HP[%d], MaxHP[%d], SP[%d], MaxSP[%d], LV[%d]\n", STeamState.ulID, STeamState.lHP, STeamState.lMaxHP, STeamState.lSP, STeamState.lMaxSP, STeamState.lLV );

  stNetLookInfo SLookInfo;
  ReadChaLookPacket(pk, SLookInfo);
  stNetChangeChaPart& SFace = SLookInfo.SLook;
  STeamState.SFace.sTypeID	= SFace.sTypeID;
  STeamState.SFace.sHairID	= SFace.sHairID;
  for(int i = 0; i < enumEQUIP_NUM; i++)
  {
	STeamState.SFace.SLink[i].sID		= SFace.SLink[i].sID;
	STeamState.SFace.SLink[i].sNum		= SFace.SLink[i].sNum;
	STeamState.SFace.SLink[i].chForgeLv = SFace.SLink[i].chForgeLv;
  }

  NetSynTeam(&STeamState);

  return true;
  T_E
}

BOOL SC_SynTLeaderID(LPRPACKET pk)
{
  T_B long lID		 = pk.ReadLong();
  long	   lLeaderID = pk.ReadLong();

  NetChaTLeaderID(lID, lLeaderID);

  // log
  //	LG(g_LogName.GetLogName( lID ), RES_STRING(CL_LANGUAGE_MATCH_300), lLeaderID, lID);
  //

  return TRUE;
  T_E
}

BOOL SC_HelpInfo(LPRPACKET packet)
{
  T_B
	  NET_HELPINFO Info;
  memset(&Info, 0, sizeof(NET_HELPINFO));

  Info.byType = packet.ReadChar();
  if(Info.byType == mission::MIS_HELP_DESP || Info.byType == mission::MIS_HELP_IMAGE ||
	 Info.byType == mission::MIS_HELP_BICKER)
  {
	const char* pszDesp = packet.ReadString();
	//strncpy( Info.szDesp, pszDesp, ROLE_MAXNUM_DESPSIZE - 1 );
	strncpy_s(Info.szDesp, ROLE_MAXNUM_DESPSIZE - 1, pszDesp, _TRUNCATE);
  } else if(Info.byType == mission::MIS_HELP_SOUND)
  {
	Info.sID = packet.ReadShort();
  } else
  {
	return FALSE;
  }

  NetShowHelp(Info);
  return TRUE;
  T_E
}

// NPC 对话信息处理
BOOL SC_TalkInfo(LPRPACKET packet)
{
  T_B
	  DWORD	  dwNpcID = packet.ReadLong();
  BYTE		  byCmd	  = packet.ReadChar();
  USHORT	  sLen	  = 0;
  const char* pszDesp = packet.ReadString();
  if(pszDesp == NULL) return FALSE;
  NetShowTalk(pszDesp, byCmd, dwNpcID);
  return TRUE;
  T_E
}

BOOL SC_FuncInfo(LPRPACKET packet)
{
  T_B
	  NET_FUNCPAGE FuncPage;
  memset(&FuncPage, 0, sizeof(NET_FUNCPAGE));

  DWORD dwNpcID = packet.ReadLong();
  BYTE	byPage	= packet.ReadChar();
  //strncpy( FuncPage.szTalk, packet.ReadString(), ROLE_MAXNUM_DESPSIZE - 1 );
  strncpy_s(FuncPage.szTalk, ROLE_MAXNUM_DESPSIZE - 1, packet.ReadString(), _TRUNCATE);
  BYTE byCount = packet.ReadChar();

  if(byCount > ROLE_MAXNUM_FUNCITEM) byCount = ROLE_MAXNUM_FUNCITEM;
  for(int i = 0; i < byCount; i++)
  {
	const char* pszFunc = packet.ReadString();
	//strncpy( FuncPage.FuncItem[i].szFunc, pszFunc, ROLE_MAXNUM_FUNCITEMSIZE - 1 );
	strncpy_s(FuncPage.FuncItem[i].szFunc, ROLE_MAXNUM_FUNCITEMSIZE - 1, pszFunc, _TRUNCATE);
  }

  BYTE byMisCount = packet.ReadChar();
  if(byMisCount > ROLE_MAXNUM_CAPACITY) { byMisCount = ROLE_MAXNUM_CAPACITY; }

  for(int i = 0; i < byMisCount; i++)
  {
	const char* pszMis = packet.ReadString();
	//strncpy( FuncPage.MisItem[i].szMis, pszMis, ROLE_MAXNUM_FUNCITEMSIZE - 1 );
	strncpy_s(FuncPage.MisItem[i].szMis, ROLE_MAXNUM_FUNCITEMSIZE - 1, pszMis, _TRUNCATE);
	FuncPage.MisItem[i].byState = packet.ReadChar();
  }

  NetShowFunction(byPage, byCount, byMisCount, FuncPage, dwNpcID);
  return TRUE;
  T_E
}

BOOL SC_CloseTalk(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  NetCloseTalk(dwNpcID);
  return TRUE;
  T_E
}

BOOL SC_TradeData(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  BYTE		byPage	= packet.ReadChar();
  BYTE		byIndex = packet.ReadChar();
  USHORT	sItemID = packet.ReadShort();
  USHORT	sCount	= packet.ReadShort();
  DWORD		dwPrice = packet.ReadLong();

  NetUpdateTradeData(dwNpcID, byPage, byIndex, sItemID, sCount, dwPrice);
  return TRUE;
  T_E
}

BOOL SC_TradeAllData(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  BYTE		byType	= packet.ReadChar();
  DWORD		dwParam = packet.ReadLong();
  BYTE		byCount = packet.ReadChar();

  NET_TRADEINFO Info;
  for(BYTE i = 0; i < byCount; i++)
  {
	BYTE byItemType = packet.ReadChar();
	switch(byItemType)
	{
	case mission::TI_WEAPON:
	case mission::TI_DEFENCE:
	case mission::TI_OTHER:
	case mission::TI_SYNTHESIS:
	{
	  Info.TradePage[byItemType].byCount = packet.ReadChar();
	  if(Info.TradePage[byItemType].byCount > ROLE_MAXNUM_TRADEITEM)
		Info.TradePage[byItemType].byCount = ROLE_MAXNUM_TRADEITEM;

	  for(BYTE n = 0; n < Info.TradePage[byItemType].byCount; n++)
	  {
		Info.TradePage[byItemType].sItemID[n] = packet.ReadShort();
		if(byType == mission::TRADE_GOODS)
		{
		  Info.TradePage[byItemType].sCount[n]	= packet.ReadShort();
		  Info.TradePage[byItemType].dwPrice[n] = packet.ReadLong();
		  Info.TradePage[byItemType].byLevel[n] = packet.ReadChar();
		}
	  }
	}
	break;
	default:
	  break;
	}
  }
  NetUpdateTradeAllData(Info, byType, dwNpcID, dwParam);
  return TRUE;
  T_E
}

BOOL SC_TradeInfo(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  BYTE		byType	= packet.ReadChar();
  DWORD		dwParam = packet.ReadLong();
  BYTE		byCount = packet.ReadChar();

  NET_TRADEINFO Info;
  for(BYTE i = 0; i < byCount; i++)
  {
	BYTE byItemType = packet.ReadChar();
	switch(byItemType)
	{
	case mission::TI_WEAPON:
	case mission::TI_DEFENCE:
	case mission::TI_OTHER:
	case mission::TI_SYNTHESIS:
	{
	  Info.TradePage[byItemType].byCount = packet.ReadChar();
	  if(Info.TradePage[byItemType].byCount > ROLE_MAXNUM_TRADEITEM)
		Info.TradePage[byItemType].byCount = ROLE_MAXNUM_TRADEITEM;

	  for(BYTE n = 0; n < Info.TradePage[byItemType].byCount; n++)
	  {
		Info.TradePage[byItemType].sItemID[n] = packet.ReadShort();
		if(byType == mission::TRADE_GOODS)
		{
		  Info.TradePage[byItemType].sCount[n]	= packet.ReadShort();
		  Info.TradePage[byItemType].dwPrice[n] = packet.ReadLong();
		  Info.TradePage[byItemType].byLevel[n] = packet.ReadChar();
		}
	  }
	}
	break;
	default:
	  break;
	}
  }
  NetShowTrade(Info, byType, dwNpcID, dwParam);
  return TRUE;
  T_E
}

BOOL SC_TradeUpdate(LPRPACKET packet)
{
  T_B
	  //黑市交易更新,只有在打开黑市交易界面情况下才更新

	  DWORD dwNpcID = packet.ReadLong();
  BYTE		byType	= packet.ReadChar();
  DWORD		dwParam = packet.ReadLong();
  BYTE		byCount = packet.ReadChar();

  NET_TRADEINFO Info;
  for(BYTE i = 0; i < byCount; i++)
  {
	BYTE byItemType = packet.ReadChar();
	switch(byItemType)
	{
	case mission::TI_WEAPON:
	case mission::TI_DEFENCE:
	case mission::TI_OTHER:
	case mission::TI_SYNTHESIS:
	{
	  Info.TradePage[byItemType].byCount = packet.ReadChar();
	  if(Info.TradePage[byItemType].byCount > ROLE_MAXNUM_TRADEITEM)
		Info.TradePage[byItemType].byCount = ROLE_MAXNUM_TRADEITEM;

	  for(BYTE n = 0; n < Info.TradePage[byItemType].byCount; n++)
	  {
		Info.TradePage[byItemType].sItemID[n] = packet.ReadShort();
		if(byType == mission::TRADE_GOODS)
		{
		  Info.TradePage[byItemType].sCount[n]	= packet.ReadShort();
		  Info.TradePage[byItemType].dwPrice[n] = packet.ReadLong();
		  Info.TradePage[byItemType].byLevel[n] = packet.ReadChar();
		}
	  }
	}
	break;
	default:
	  break;
	}
  }

  if(g_stUINpcTrade.GetIsShow())
  {
	NetShowTrade(Info, byType, dwNpcID, dwParam);
  }

  return TRUE;
  T_E
}

BOOL SC_TradeResult(LPRPACKET packet)
{
  T_B
	  BYTE byType  = packet.ReadChar();
  BYTE	   byIndex = packet.ReadChar();
  BYTE	   byCount = packet.ReadChar();
  USHORT   sItemID = packet.ReadShort();
  DWORD	   dwMoney = packet.ReadLong();
  LG("trade", RES_STRING(CL_LANGUAGE_MATCH_301), byType, byIndex, byCount, sItemID, dwMoney);
  NetTradeResult(byType, byIndex, byCount, sItemID, dwMoney);
  LG("trade", RES_STRING(CL_LANGUAGE_MATCH_302));
  return TRUE;
  T_E
}

BOOL SC_CharTradeInfo(LPRPACKET packet)
{
  T_B
	  USHORT usCmd = packet.ReadShort();
  switch(usCmd)
  {
  case CMD_MC_CHARTRADE_REQUEST:
  {
	BYTE  byType	  = packet.ReadChar();
	DWORD dwRequestID = packet.ReadLong();
	NetShowCharTradeRequest(byType, dwRequestID);
  }
  break;
  case CMD_MC_CHARTRADE_CANCEL:
  {
	DWORD dwCharID = packet.ReadLong();
	NetCancelCharTrade(dwCharID);
  }
  break;
  case CMD_MC_CHARTRADE_MONEY:
  {
	DWORD dwCharID = packet.ReadLong();
	DWORD dwMoney  = packet.ReadLong();
	NetTradeShowMoney(dwCharID, dwMoney);
  }
  break;
  case CMD_MC_CHARTRADE_ITEM:
  {
	DWORD dwRequestID = packet.ReadLong();
	BYTE  byOpType	  = packet.ReadChar();
	if(byOpType == mission::TRADE_DRAGTO_ITEM)
	{
	  BYTE byItemIndex = packet.ReadChar();
	  BYTE byIndex	   = packet.ReadChar();
	  BYTE byCount	   = packet.ReadChar();

	  // 物品实例属性
	  NET_CHARTRADE_ITEMDATA Data;
	  memset(&Data, 0, sizeof(NET_CHARTRADE_ITEMDATA));

	  NetTradeAddItem(dwRequestID, byOpType, 0, byIndex, byCount, byItemIndex, Data);
	} else if(byOpType == mission::TRADE_DRAGTO_TRADE)
	{
	  USHORT sItemID	 = packet.ReadShort();
	  BYTE	 byItemIndex = packet.ReadChar();
	  BYTE	 byIndex	 = packet.ReadChar();
	  BYTE	 byCount	 = packet.ReadChar();
	  USHORT sType		 = packet.ReadShort();

	  if(sType == enumItemTypeBoat)
	  {
		NET_CHARTRADE_BOATDATA Data;
		memset(&Data, 0, sizeof(NET_CHARTRADE_BOATDATA));

		if(packet.ReadChar() == 0)
		{
		  // 信息错误
		} else
		{
		  //strncpy( Data.szName, packet.ReadString(), BOAT_MAXSIZE_BOATNAME - 1 );
		  strncpy_s(Data.szName, BOAT_MAXSIZE_BOATNAME - 1, packet.ReadString(), _TRUNCATE);
		  Data.sBoatID		= packet.ReadShort();
		  Data.sLevel		= packet.ReadShort();
		  Data.dwExp		= packet.ReadLong();
		  Data.dwHp			= packet.ReadLong();
		  Data.dwMaxHp		= packet.ReadLong();
		  Data.dwSp			= packet.ReadLong();
		  Data.dwMaxSp		= packet.ReadLong();
		  Data.dwMinAttack	= packet.ReadLong();
		  Data.dwMaxAttack	= packet.ReadLong();
		  Data.dwDef		= packet.ReadLong();
		  Data.dwSpeed		= packet.ReadLong();
		  Data.dwShootSpeed = packet.ReadLong();
		  Data.byHasItem	= packet.ReadChar();
		  Data.byCapacity	= packet.ReadChar();
		  Data.dwPrice		= packet.ReadLong();
		  NetTradeAddBoat(dwRequestID, byOpType, sItemID, byIndex, byCount, byItemIndex, Data);
		}
	  } else
	  {
		// 物品实例属性
		NET_CHARTRADE_ITEMDATA Data;
		memset(&Data, 0, sizeof(NET_CHARTRADE_ITEMDATA));

		Data.sEndure[0]					   = packet.ReadShort();
		Data.sEndure[1]					   = packet.ReadShort();
		Data.sEnergy[0]					   = packet.ReadShort();
		Data.sEnergy[1]					   = packet.ReadShort();
		Data.byForgeLv					   = packet.ReadChar();
		Data.bValid						   = packet.ReadChar() != 0 ? true : false;
		Data.lDBParam[enumITEMDBP_FORGE]   = packet.ReadLong();
		Data.lDBParam[enumITEMDBP_INST_ID] = packet.ReadLong();

		Data.byHasAttr = packet.ReadChar();
		if(Data.byHasAttr)
		{
		  for(int i = 0; i < defITEM_INSTANCE_ATTR_NUM; i++)
		  {
			Data.sInstAttr[i][0] = packet.ReadShort();
			Data.sInstAttr[i][1] = packet.ReadShort();
		  }
		}

		NetTradeAddItem(dwRequestID, byOpType, sItemID, byIndex, byCount, byItemIndex, Data);
	  }
	} else
	{
	  MessageBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_303), RES_STRING(CL_LANGUAGE_MATCH_25), MB_OK);
	  return FALSE;
	}
  }
  break;
  case CMD_MC_CHARTRADE_PAGE:
  {
	BYTE  byType	  = packet.ReadChar();
	DWORD dwAcceptID  = packet.ReadLong();
	DWORD dwRequestID = packet.ReadLong();
	NetShowCharTradeInfo(byType, dwAcceptID, dwRequestID);
  }
  break;
  case CMD_MC_CHARTRADE_VALIDATEDATA:
  {
	DWORD dwCharID = packet.ReadLong();
	NetValidateTradeData(dwCharID);
  }
  break;
  case CMD_MC_CHARTRADE_VALIDATE:
  {
	DWORD dwCharID = packet.ReadLong();
	NetValidateTrade(dwCharID);
  }
  break;
  case CMD_MC_CHARTRADE_RESULT:
  {
	BYTE byResult = packet.ReadChar();
	if(byResult == mission::TRADE_SUCCESS)
	{
	  NetTradeSuccess();
	} else
	{
	  NetTradeFailed();
	}
  }
  break;
  default:
	return FALSE;
	break;
  }
  return TRUE;
  T_E
}

BOOL SC_MissionInfo(LPRPACKET packet)
{
  T_B
	  DWORD		  dwNpcID = packet.ReadLong();
  NET_MISSIONLIST list;
  memset(&list, 0, sizeof(NET_MISSIONLIST));

  list.byListType  = packet.ReadChar();
  list.byPrev	   = packet.ReadChar();
  list.byNext	   = packet.ReadChar();
  list.byPrevCmd   = packet.ReadChar();
  list.byNextCmd   = packet.ReadChar();
  list.byItemCount = packet.ReadChar();

  if(list.byItemCount > ROLE_MAXNUM_FUNCITEM) list.byItemCount = ROLE_MAXNUM_FUNCITEM;
  for(int i = 0; i < list.byItemCount; i++)
  {
	USHORT		sLen	= 0;
	const char* pszFunc = packet.ReadString();
	//strncpy( list.FuncPage.FuncItem[i].szFunc, pszFunc, 32 );
	strncpy_s(list.FuncPage.FuncItem[i].szFunc, 32, pszFunc, _TRUNCATE);
  }

  NetShowMissionList(dwNpcID, list);
  return TRUE;
  T_E
}

BOOL SC_MisPage(LPRPACKET packet)
{
  T_B
	  BYTE	  byCmd	  = packet.ReadChar();
  DWORD		  dwNpcID = packet.ReadLong();
  NET_MISPAGE page;
  memset(&page, 0, sizeof(NET_MISPAGE));

  // 任务名称
  const char* pszName = packet.ReadString();
  //	strncpy( page.szName, pszName, ROLE_MAXSIZE_MISNAME - 1 );
  strncpy_s(page.szName, ROLE_MAXSIZE_MISNAME - 1, pszName, _TRUNCATE);

  switch(byCmd)
  {
  case ROLE_MIS_BTNACCEPT:
  case ROLE_MIS_BTNDELIVERY:
  case ROLE_MIS_BTNPENDING:
  {
	// 任务需求信息
	page.byNeedNum = packet.ReadChar();
	for(int i = 0; i < page.byNeedNum; i++)
	{
	  page.MisNeed[i].byType = packet.ReadChar();
	  if(page.MisNeed[i].byType == mission::MIS_NEED_ITEM || page.MisNeed[i].byType == mission::MIS_NEED_KILL)
	  {
		page.MisNeed[i].wParam1 = packet.ReadShort();
		page.MisNeed[i].wParam2 = packet.ReadShort();
		page.MisNeed[i].wParam3 = packet.ReadChar();
	  } else if(page.MisNeed[i].byType == mission::MIS_NEED_DESP)
	  {
		const char* pszTemp = packet.ReadString();
		//strncpy( page.MisNeed[i].szNeed, pszTemp, ROLE_MAXNUM_NEEDDESPSIZE - 1 );
		strncpy_s(page.MisNeed[i].szNeed, ROLE_MAXNUM_NEEDDESPSIZE - 1, pszTemp, _TRUNCATE);
	  } else
	  {
		// 未知的数据类型
		LG("mission_error", RES_STRING(CL_LANGUAGE_MATCH_304));
		return FALSE;
	  }
	}

	// 任务奖励信息
	page.byPrizeSelType = packet.ReadChar();
	page.byPrizeNum		= packet.ReadChar();
	for(int i = 0; i < page.byPrizeNum; i++)
	{
	  page.MisPrize[i].byType  = packet.ReadChar();
	  page.MisPrize[i].wParam1 = packet.ReadShort();
	  page.MisPrize[i].wParam2 = packet.ReadShort();
	}

	// 任务描述信息
	const char* pszDesp = packet.ReadString();
	//strncpy( page.szDesp, pszDesp, ROLE_MAXNUM_DESPSIZE - 1 );
	strncpy_s(page.szDesp, ROLE_MAXNUM_DESPSIZE - 1, pszDesp, _TRUNCATE);
  }
  break;
  default:
	return FALSE;
  }

  NetShowMisPage(dwNpcID, byCmd, page);
  return TRUE;
  T_E
}

BOOL SC_MisLog(LPRPACKET packet)
{
  T_B
  NET_MISLOG_LIST LogList;
  memset(&LogList, 0, sizeof(NET_MISLOG_LIST));

  LogList.byNumLog = packet.ReadChar();
  for(int i = 0; i < LogList.byNumLog; i++)
  {
	LogList.MisLog[i].wMisID  = packet.ReadShort();
	LogList.MisLog[i].byState = packet.ReadChar();
  }

  NetMisLogList(LogList);
  return TRUE;
  T_E
}

BOOL SC_MisLogInfo(LPRPACKET packet)
{
  T_B
	  NET_MISPAGE page;
  memset(&page, 0, sizeof(NET_MISPAGE));

  // 任务基本信息
  WORD		  wMisID  = packet.ReadShort();
  const char* pszName = packet.ReadString();
  //strncpy( page.szName, pszName, ROLE_MAXSIZE_MISNAME - 1 );
  strncpy_s(page.szName, ROLE_MAXSIZE_MISNAME - 1, pszName, _TRUNCATE);

  // 任务需求信息
  page.byNeedNum = packet.ReadChar();
  for(int i = 0; i < page.byNeedNum; i++)
  {
	page.MisNeed[i].byType = packet.ReadChar();
	if(page.MisNeed[i].byType == mission::MIS_NEED_ITEM || page.MisNeed[i].byType == mission::MIS_NEED_KILL)
	{
	  page.MisNeed[i].wParam1 = packet.ReadShort();
	  page.MisNeed[i].wParam2 = packet.ReadShort();
	  page.MisNeed[i].wParam3 = packet.ReadChar();
	} else if(page.MisNeed[i].byType == mission::MIS_NEED_DESP)
	{
	  const char* pszTemp = packet.ReadString();
	  //strncpy( page.MisNeed[i].szNeed, pszTemp, ROLE_MAXNUM_NEEDDESPSIZE - 1 );
	  strncpy_s(page.MisNeed[i].szNeed, ROLE_MAXNUM_NEEDDESPSIZE - 1, pszTemp, _TRUNCATE);
	} else
	{
	  // 未知的数据类型
	  LG("mission_error", RES_STRING(CL_LANGUAGE_MATCH_304));
	  return FALSE;
	}
  }

  // 任务奖励信息
  page.byPrizeSelType = packet.ReadChar();
  page.byPrizeNum	  = packet.ReadChar();
  for(int i = 0; i < page.byPrizeNum; i++)
  {
	page.MisPrize[i].byType	 = packet.ReadChar();
	page.MisPrize[i].wParam1 = packet.ReadShort();
	page.MisPrize[i].wParam2 = packet.ReadShort();
  }

  // 任务描述信息
  const char* pszDesp = packet.ReadString();
  //strncpy( page.szDesp, pszDesp, ROLE_MAXNUM_DESPSIZE - 1 );
  strncpy_s(page.szDesp, ROLE_MAXNUM_DESPSIZE - 1, pszDesp, _TRUNCATE);

  NetShowMisLog(wMisID, page);
  return TRUE;
  T_E
}

BOOL SC_MisLogClear(LPRPACKET packet)
{
  T_B
	  WORD wMisID = packet.ReadShort();

  NetMisLogClear(wMisID);
  return TRUE;
  T_E
}

BOOL SC_MisLogAdd(LPRPACKET packet)
{
  T_B
	  WORD wMisID  = packet.ReadShort();
  BYTE	   byState = packet.ReadChar();

  NetMisLogAdd(wMisID, byState);
  return TRUE;
  T_E
}

BOOL SC_MisLogState(LPRPACKET packet)
{
  T_B
	  WORD wID	   = packet.ReadShort();
  BYTE	   byState = packet.ReadChar();

  NetMisLogState(wID, byState);
  return TRUE;
  T_E
}

BOOL SC_TriggerAction(LPRPACKET packet)
{
  T_B
	  stNetNpcMission info;
  info.byType = packet.ReadChar();
  info.sID	  = packet.ReadShort(); // 被摧毁物件类型ID
  info.sNum	  = packet.ReadShort(); // 需要摧毁物件总数量
  info.sCount = packet.ReadShort(); // 已完成计数
  NetTriggerAction(info);
  return TRUE;
  T_E
}

BOOL SC_NpcStateChange(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  BYTE		byState = packet.ReadChar();
  NetNpcStateChange(dwNpcID, byState);
  return TRUE;
  T_E
}

BOOL SC_EntityStateChange(LPRPACKET packet)
{
  T_B
	  DWORD dwEntityID = packet.ReadLong();
  BYTE		byState	   = packet.ReadChar();
  NetEntityStateChange(dwEntityID, byState);
  return TRUE;
  T_E
}

BOOL SC_Forge(LPRPACKET packet)
{
  T_B NetShowForge();
  return TRUE;
  T_E
}

BOOL SC_Unite(LPRPACKET packet)
{
  T_B NetShowUnite();
  return TRUE;
  T_E
}

BOOL SC_Milling(LPRPACKET packet)
{
  T_B NetShowMilling();
  return TRUE;
  T_E
}

BOOL SC_Fusion(LPRPACKET packet)
{
  T_B NetShowFusion();
  return TRUE;
  T_E
}

BOOL SC_Upgrade(LPRPACKET packet)
{
  T_B NetShowUpgrade();
  return TRUE;
  T_E
}

BOOL SC_EidolonMetempsychosis(LPRPACKET packet)
{
  T_B
  //NetShowEidolonMetempsychosis();
  NetShowEidolonFusion();
  return TRUE;
  T_E
}

BOOL SC_Eidolon_Fusion(LPRPACKET packet)
{
  T_B NetShowEidolonFusion();
  return TRUE;
  T_E
}

BOOL SC_Purify(LPRPACKET packet)
{
  T_B NetShowPurify();
  return TRUE;
  T_E
}

BOOL SC_Fix(LPRPACKET packet)
{
  T_B NetShowRepairOven();
  return TRUE;
  T_E
}

BOOL SC_GMSend(LPRPACKET packet)
{
  T_B
	  g_stUIMail.ShowQuestionForm();
  return TRUE;
  T_E
}

BOOL SC_GMRecv(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  CS_GMRecv(dwNpcID);
  return TRUE;
  T_E
}

BOOL SC_GetStone(LPRPACKET packet)
{
  T_B NetShowGetStone();
  return TRUE;
  T_E
}

BOOL SC_Energy(LPRPACKET packet)
{
  T_B NetShowEnergy();
  return TRUE;
  T_E
}

BOOL SC_Tiger(LPRPACKET packet)
{
  T_B NetShowTiger();
  return TRUE;
  T_E
}

BOOL SC_CreateBoat(LPRPACKET packet)
{
  T_B
	  DWORD		 dwBoatID = packet.ReadLong();
  xShipBuildInfo Info;
  memset(&Info, 0, sizeof(xShipBuildInfo));

  char szBoat[BOAT_MAXSIZE_NAME] = {0}; // 船名自定义
  /*strncpy( szBoat, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy( Info.szName, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy( Info.szDesp, packet.ReadString(), BOAT_MAXSIZE_DESP - 1 );
	strncpy( Info.szBerth, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );*/
  strncpy_s(szBoat, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szName, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szDesp, BOAT_MAXSIZE_DESP - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szBerth, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  Info.byIsUpdate = packet.ReadChar();
  Info.sPosID	  = packet.ReadShort();
  Info.dwBody	  = packet.ReadLong();
  strncpy_s(Info.szBody, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  if(Info.byIsUpdate)
  {
	Info.byHeader = packet.ReadChar();
	Info.dwHeader = packet.ReadLong();
	//strncpy( Info.szHeader, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy_s(Info.szHeader, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

	Info.byEngine = packet.ReadChar();
	Info.dwEngine = packet.ReadLong();
	//strncpy( Info.szEngine, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy_s(Info.szEngine, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
	for(int i = 0; i < BOAT_MAXNUM_MOTOR; i++)
	{
	  Info.dwMotor[i] = packet.ReadLong();
	}
  }
  Info.byCannon = packet.ReadChar();
  //strncpy( Info.szCannon, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szCannon, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  Info.byEquipment = packet.ReadChar();
  //strncpy( Info.szEquipment, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szEquipment, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  Info.dwMoney		= packet.ReadLong();
  Info.dwMinAttack	= packet.ReadLong();
  Info.dwMaxAttack	= packet.ReadLong();
  Info.dwCurEndure	= packet.ReadLong();
  Info.dwMaxEndure	= packet.ReadLong();
  Info.dwSpeed		= packet.ReadLong();
  Info.dwDistance	= packet.ReadLong();
  Info.dwDefence	= packet.ReadLong();
  Info.dwCurSupply	= packet.ReadLong();
  Info.dwMaxSupply	= packet.ReadLong();
  Info.dwConsume	= packet.ReadLong();
  Info.dwAttackTime = packet.ReadLong();
  Info.sCapacity	= packet.ReadShort();

  NetCreateBoat(Info);
  return TRUE;
  T_E
}

BOOL SC_UpdateBoat(LPRPACKET packet)
{
  T_B
	  DWORD		 dwBoatID = packet.ReadLong();
  xShipBuildInfo Info;
  memset(&Info, 0, sizeof(xShipBuildInfo));

  char szBoat[BOAT_MAXSIZE_NAME] = {0}; // 船名自定义
  /*strncpy( szBoat, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy( Info.szName, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy( Info.szDesp, packet.ReadString(), BOAT_MAXSIZE_DESP - 1 );
	strncpy( Info.szBerth, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );*/
  strncpy_s(szBoat, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szName, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szDesp, BOAT_MAXSIZE_DESP - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szBerth, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  Info.byIsUpdate = packet.ReadChar();
  Info.sPosID	  = packet.ReadShort();
  Info.dwBody	  = packet.ReadLong();
  //strncpy( Info.szBody, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szBody, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  if(Info.byIsUpdate)
  {
	Info.byHeader = packet.ReadChar();
	Info.dwHeader = packet.ReadLong();
	//strncpy( Info.szHeader, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy_s(Info.szHeader, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

	Info.byEngine = packet.ReadChar();
	Info.dwEngine = packet.ReadLong();
	//strncpy( Info.szEngine, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy_s(Info.szEngine, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
	for(int i = 0; i < BOAT_MAXNUM_MOTOR; i++)
	{
	  Info.dwMotor[i] = packet.ReadLong();
	}
  }
  Info.byCannon = packet.ReadChar();
  //strncpy( Info.szCannon, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szCannon, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  Info.byEquipment = packet.ReadChar();
  //strncpy( Info.szEquipment, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szEquipment, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  Info.dwMoney		= packet.ReadLong();
  Info.dwMinAttack	= packet.ReadLong();
  Info.dwMaxAttack	= packet.ReadLong();
  Info.dwCurEndure	= packet.ReadLong();
  Info.dwMaxEndure	= packet.ReadLong();
  Info.dwSpeed		= packet.ReadLong();
  Info.dwDistance	= packet.ReadLong();
  Info.dwDefence	= packet.ReadLong();
  Info.dwCurSupply	= packet.ReadLong();
  Info.dwMaxSupply	= packet.ReadLong();
  Info.dwConsume	= packet.ReadLong();
  Info.dwAttackTime = packet.ReadLong();
  Info.sCapacity	= packet.ReadShort();

  NetUpdateBoat(Info);
  return TRUE;
  T_E
}

BOOL SC_BoatInfo(LPRPACKET packet)
{
  T_B
	  DWORD		 dwBoatID = packet.ReadLong();
  xShipBuildInfo Info;
  memset(&Info, 0, sizeof(xShipBuildInfo));

  char szBoat[BOAT_MAXSIZE_NAME] = {0}; // 船名自定义
  /*strncpy( szBoat, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy( Info.szName, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy( Info.szDesp, packet.ReadString(), BOAT_MAXSIZE_DESP - 1 );
	strncpy( Info.szBerth, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );*/
  strncpy_s(szBoat, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szName, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szDesp, BOAT_MAXSIZE_DESP - 1, packet.ReadString(), _TRUNCATE);
  strncpy_s(Info.szBerth, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
  Info.byIsUpdate = packet.ReadChar();
  Info.sPosID	  = packet.ReadShort();
  Info.dwBody	  = packet.ReadLong();
  //strncpy( Info.szBody, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szBody, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  if(Info.byIsUpdate)
  {
	Info.byHeader = packet.ReadChar();
	Info.dwHeader = packet.ReadLong();
	//strncpy( Info.szHeader, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy_s(Info.szHeader, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

	Info.byEngine = packet.ReadChar();
	Info.dwEngine = packet.ReadLong();
	//strncpy( Info.szEngine, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
	strncpy_s(Info.szEngine, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);
	for(int i = 0; i < BOAT_MAXNUM_MOTOR; i++)
	{
	  Info.dwMotor[i] = packet.ReadLong();
	}
  }
  Info.byCannon = packet.ReadChar();
  //strncpy( Info.szCannon, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szCannon, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  Info.byEquipment = packet.ReadChar();
  //strncpy( Info.szEquipment, packet.ReadString(), BOAT_MAXSIZE_NAME - 1 );
  strncpy_s(Info.szEquipment, BOAT_MAXSIZE_NAME - 1, packet.ReadString(), _TRUNCATE);

  Info.dwMoney		= packet.ReadLong();
  Info.dwMinAttack	= packet.ReadLong();
  Info.dwMaxAttack	= packet.ReadLong();
  Info.dwCurEndure	= packet.ReadLong();
  Info.dwMaxEndure	= packet.ReadLong();
  Info.dwSpeed		= packet.ReadLong();
  Info.dwDistance	= packet.ReadLong();
  Info.dwDefence	= packet.ReadLong();
  Info.dwCurSupply	= packet.ReadLong();
  Info.dwMaxSupply	= packet.ReadLong();
  Info.dwConsume	= packet.ReadLong();
  Info.dwAttackTime = packet.ReadLong();
  Info.sCapacity	= packet.ReadShort();

  NetBoatInfo(dwBoatID, szBoat, Info);
  return TRUE;
  T_E
}

BOOL SC_UpdateBoatPart(LPRPACKET packet)
{
  T_B return TRUE;
  T_E
}

BOOL SC_BoatList(LPRPACKET packet)
{
  T_B
	  DWORD		  dwNpcID	= packet.ReadLong();
  BYTE			  byType	= packet.ReadChar();
  BYTE			  byNumBoat = packet.ReadChar();
  BOAT_BERTH_DATA Data;
  memset(&Data, 0, sizeof(BOAT_BERTH_DATA));
  for(BYTE i = 0; i < byNumBoat; i++)
  {
	//strncpy( Data.szName[i], packet.ReadString(), BOAT_MAXSIZE_BOATNAME + BOAT_MAXSIZE_DESP - 1 );
	strncpy_s(Data.szName[i], BOAT_MAXSIZE_BOATNAME + BOAT_MAXSIZE_DESP - 1, packet.ReadString(), _TRUNCATE);
  }

  NetShowBoatList(dwNpcID, byNumBoat, Data, byType);
  return TRUE;
  T_E
}

//BOOL	SC_BoatBagList( LPRPACKET packet )
//{
//	BYTE byNumBoat = packet.ReadChar();
//	BOAT_BERTH_DATA Data;
//	memset( &Data, 0, sizeof(BOAT_BERTH_DATA) );
//	for( BYTE i = 0; i < byNumBoat; i++ )
//	{
//		strncpy( Data.szName[i], packet.ReadString(), BOAT_MAXSIZE_BOATNAME - 1 );
//	}
//
//	NetShowBoatBagList( byNumBoat, Data );
//	return TRUE;
//}

BOOL SC_StallInfo(LPRPACKET packet)
{
  T_B
	  DWORD	  dwCharID = packet.ReadLong();
  BYTE		  byNum	   = packet.ReadChar();
  const char* pszName  = packet.ReadString();
  if(!pszName) return FALSE;

  NetStallInfo(dwCharID, byNum, pszName);

  for(BYTE i = 0; i < byNum; ++i)
  {
	BYTE   byGrid  = packet.ReadChar();
	USHORT sItemID = packet.ReadShort();
	BYTE   byCount = packet.ReadChar();
	DWORD  dwMoney = packet.ReadLong();
	USHORT sType   = packet.ReadShort();

	if(sType == enumItemTypeBoat)
	{
	  NET_CHARTRADE_BOATDATA Data;
	  memset(&Data, 0, sizeof(NET_CHARTRADE_BOATDATA));

	  if(packet.ReadChar() == 0)
	  {
		// 信息错误
	  } else
	  {
		//strncpy( Data.szName, packet.ReadString(), BOAT_MAXSIZE_BOATNAME - 1 );
		strncpy_s(Data.szName, BOAT_MAXSIZE_BOATNAME - 1, packet.ReadString(), _TRUNCATE);
		Data.sBoatID	  = packet.ReadShort();
		Data.sLevel		  = packet.ReadShort();
		Data.dwExp		  = packet.ReadLong();
		Data.dwHp		  = packet.ReadLong();
		Data.dwMaxHp	  = packet.ReadLong();
		Data.dwSp		  = packet.ReadLong();
		Data.dwMaxSp	  = packet.ReadLong();
		Data.dwMinAttack  = packet.ReadLong();
		Data.dwMaxAttack  = packet.ReadLong();
		Data.dwDef		  = packet.ReadLong();
		Data.dwSpeed	  = packet.ReadLong();
		Data.dwShootSpeed = packet.ReadLong();
		Data.byHasItem	  = packet.ReadChar();
		Data.byCapacity	  = packet.ReadChar();
		Data.dwPrice	  = packet.ReadLong();
		NetStallAddBoat(byGrid, sItemID, byCount, dwMoney, Data);
	  }
	} else
	{
	  // 物品实例属性
	  NET_CHARTRADE_ITEMDATA Data;
	  memset(&Data, 0, sizeof(NET_CHARTRADE_ITEMDATA));

	  Data.sEndure[0]					 = packet.ReadShort();
	  Data.sEndure[1]					 = packet.ReadShort();
	  Data.sEnergy[0]					 = packet.ReadShort();
	  Data.sEnergy[1]					 = packet.ReadShort();
	  Data.byForgeLv					 = packet.ReadChar();
	  Data.bValid						 = packet.ReadChar() != 0 ? true : false;
	  Data.lDBParam[enumITEMDBP_FORGE]	 = packet.ReadLong();
	  Data.lDBParam[enumITEMDBP_INST_ID] = packet.ReadLong();

	  Data.byHasAttr = packet.ReadChar();
	  if(Data.byHasAttr)
	  {
		for(int i = 0; i < defITEM_INSTANCE_ATTR_NUM; i++)
		{
		  Data.sInstAttr[i][0] = packet.ReadShort();
		  Data.sInstAttr[i][1] = packet.ReadShort();
		}
	  }
	  NetStallAddItem(byGrid, sItemID, byCount, dwMoney, Data);
	}
  }
  return TRUE;
  T_E
}

BOOL SC_StallUpdateInfo(LPRPACKET packet)
{
  T_B return TRUE;
  T_E
}

BOOL SC_StallDelGoods(LPRPACKET packet)
{
  T_B
	  DWORD dwCharID = packet.ReadLong();
  BYTE		byGrid	 = packet.ReadChar();
  BYTE		byCount	 = packet.ReadChar();
  NetStallDelGoods(dwCharID, byGrid, byCount);
  return TRUE;
  T_E
}

BOOL SC_StallClose(LPRPACKET packet)
{
  T_B
	  DWORD dwCharID = packet.ReadLong();
  NetStallClose(dwCharID);
  return TRUE;
  T_E
}

BOOL SC_StallSuccess(LPRPACKET packet)
{
  T_B
	  DWORD dwCharID = packet.ReadLong();
  NetStallSuccess(dwCharID);
  return TRUE;
  T_E
}

BOOL SC_SynStallName(LPRPACKET packet)
{
  T_B
	  DWORD	  dwCharID	  = packet.ReadLong();
  const char* szStallName = packet.ReadString();
  NetStallName(dwCharID, szStallName);
  return TRUE;
  T_E
}

BOOL SC_StartExit(LPRPACKET packet)
{
  T_B
	  DWORD dwExitTime = packet.ReadLong();
  NetStartExit(dwExitTime);
  return TRUE;
  T_E
}

BOOL SC_CancelExit(LPRPACKET packet)
{
  T_B NetCancelExit();
  return TRUE;
  T_E
}

BOOL SC_UpdateHairRes(LPRPACKET packet)
{
  T_B
	  stNetUpdateHairRes rv;
  rv.ulWorldID = packet.ReadLong();
  rv.nScriptID = packet.ReadShort();
  rv.szReason  = packet.ReadString();
  rv.Exec();
  return TRUE;
  T_E
}

BOOL SC_OpenHairCut(LPRPACKET packet)
{
  T_B
	  stNetOpenHair hair;
  hair.Exec();
  return TRUE;
  T_E
}

BOOL SC_TeamFightAsk(LPRPACKET packet)
{
  T_B
	  // 	char szLogName[128] = {0};
	  // 	strncpy_s(szLogName,sizeof(szLogName), RES_STRING(CL_LANGUAGE_MATCH_305),_TRUNCATE);

	  stNetTeamFightAsk SFightAsk;
  SFightAsk.chSideNum2 = packet.ReverseReadChar();
  SFightAsk.chSideNum1 = packet.ReverseReadChar();
  // 	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_306), SFightAsk.chSideNum1, SFightAsk.chSideNum2);
  for(char i = 0; i < SFightAsk.chSideNum1 + SFightAsk.chSideNum2; i++)
  {
	SFightAsk.Info[i].szName	   = packet.ReadString();
	SFightAsk.Info[i].chLv		   = packet.ReadChar();
	SFightAsk.Info[i].szJob		   = packet.ReadString();
	SFightAsk.Info[i].usFightNum   = packet.ReadShort();
	SFightAsk.Info[i].usVictoryNum = packet.ReadShort();
	// 		LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_307), SFightAsk.Info[i].szName, SFightAsk.Info[i].chLv, SFightAsk.Info[i].szJob);
  }
  // 	LG(szLogName, "\n");
  SFightAsk.Exec();
  return TRUE;
  T_E
}

BOOL SC_BeginItemRepair(LPRPACKET packet)
{
  T_B NetBeginRepairItem();
  return TRUE;
  T_E
}

BOOL SC_ItemRepairAsk(LPRPACKET packet)
{
  T_B
	  stNetItemRepairAsk SRepairAsk;
  SRepairAsk.cszItemName  = packet.ReadString();
  SRepairAsk.lRepairMoney = packet.ReadLong();
  SRepairAsk.Exec();

  return TRUE;
  T_E
}

BOOL SC_ItemForgeAsk(LPRPACKET packet)
{
  T_B
	  stSCNetItemForgeAsk SForgeAsk;
  SForgeAsk.chType = packet.ReadChar();
  SForgeAsk.lMoney = packet.ReadLong();
  SForgeAsk.Exec();

  return TRUE;
  T_E
}

BOOL SC_ItemForgeAnswer(LPRPACKET packet)
{
  T_B
	  stNetItemForgeAnswer SForgeAnswer;
  SForgeAnswer.lChaID	= packet.ReadLong();
  SForgeAnswer.chType	= packet.ReadChar();
  SForgeAnswer.chResult = packet.ReadChar();
  SForgeAnswer.Exec();

  return TRUE;
  T_E
}

BOOL SC_JewelryUpAnswer(LPRPACKET packet)
{
  uChar result = packet.ReadChar();
  if(result == '1')
  {
	long OldJeyID  = packet.ReadLong();
	long OldJeyLev = packet.ReadLong();
	long NewJeyID  = packet.ReadLong();
	long NewJeyLev = packet.ReadLong();

	g_stJewelryUpForm.ShowConfirmDialog(OldJeyID, OldJeyLev, NewJeyID, NewJeyLev);
  } else
  {
	char buf[246] = {0};
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_991));
	g_pGameApp->MsgBox(buf);
  }

  return TRUE;
}

BOOL SC_ItemUseSuc(LPRPACKET packet)
{
  T_B unsigned int nChaID  = packet.ReadLong();
  short			   sItemID = packet.ReadShort();
  NetItemUseSuccess(nChaID, sItemID);

  return TRUE;
  T_E
}

BOOL SC_KitbagCapacity(LPRPACKET packet)
{
  T_B unsigned int nChaID = packet.ReadLong();
  short			   sKbCap = packet.ReadShort();
  NetKitbagCapacity(nChaID, sKbCap);

  return TRUE;
  T_E
}

BOOL SC_EspeItem(LPRPACKET packet)
{
  T_B
	  stNetEspeItem SEspItem;
  unsigned int		nChaID = packet.ReadLong();
  SEspItem.chNum		   = packet.ReadChar();
  for(char i = 0; i < 4; i++)
  {
	SEspItem.SContent[i].sPos	 = packet.ReadShort();
	SEspItem.SContent[i].sEndure = packet.ReadShort();
	SEspItem.SContent[i].sEnergy = packet.ReadShort();
  }

  NetEspeItem(nChaID, SEspItem);
  return TRUE;
  T_E
}

BOOL SC_MapCrash(LPRPACKET packet)
{
  T_B const char* pszDesp = packet.ReadString();
  if(pszDesp == NULL)
	return FALSE;

  NetShowMapCrash(pszDesp);
  return TRUE;
  T_E
}

BOOL SC_Message(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  NetShowMessage(pk.ReadLong());
  return TRUE;
  T_E
}

BOOL SC_QueryCha(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  stNetSysInfo SShowInfo;
  char		   szInfo[512] = "";
  const char*  pChaName	   = pk.ReadString();
  const char*  pMapName	   = pk.ReadString();
  long		   lPosX	   = pk.ReadLong();
  long		   lPosY	   = pk.ReadLong();
  long		   lChaID	   = pk.ReadLong();
  _snprintf_s(szInfo, _countof(szInfo), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_308), pChaName, lChaID, pMapName, lPosX, lPosY);
  SShowInfo.m_sysinfo = szInfo;
  NetSysInfo(SShowInfo);

  return TRUE;
  T_E
}

BOOL SC_QueryChaItem(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  return TRUE;
  T_E
}

BOOL SC_QueryChaPing(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  stNetSysInfo SShowInfo;
  char		   szInfo[512] = "";
  const char*  pChaName	   = pk.ReadString();
  const char*  pMapName	   = pk.ReadString();
  long		   lPing	   = pk.ReadLong();
  _snprintf_s(szInfo, _countof(szInfo), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_309), pMapName, lPing);
  SShowInfo.m_sysinfo = szInfo;
  NetSysInfo(SShowInfo);

  return TRUE;
  T_E
}

BOOL SC_QueryRelive(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();

  stNetQueryRelive SQueryRelive;
  SQueryRelive.szSrcChaName = pk.ReadString();
  SQueryRelive.chType		= pk.ReadChar();
  NetQueryRelive(l_id, SQueryRelive);

  return TRUE;
  T_E
}

BOOL SC_PreMoveTime(LPRPACKET pk)
{
  T_B
	  uLong ulPreMoveTime = pk.ReadLong();
  NetPreMoveTime(ulPreMoveTime);

  return TRUE;
  T_E
}

BOOL SC_MapMask(LPRPACKET pk)
{
  T_B
	  uLong l_id	 = pk.ReadLong();
  uShort	usLen	 = 0;
  BYTE*		pMapMask = 0;
  if(pk.ReadChar())
	pMapMask = (BYTE*)pk.ReadSequence(usLen);

  //char	*szMask = new char[usLen + 1];
  //memcpy(szMask, pMapMask, usLen);
  //szMask[usLen] = '\0';
  //LG("大地图", "%s\n", szMask);

  NetMapMask(l_id, pMapMask, usLen);

  return TRUE;
  T_E
}

BOOL SC_SynEventInfo(LPRPACKET pk)
{
  T_B
	  stNetEvent SNetEvent;
  ReadEntEventPacket(pk, SNetEvent);

  SNetEvent.ChangeEvent();
  return TRUE;
  T_E
}

BOOL SC_SynSideInfo(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();
  //	char* szLogName = g_LogName.GetLogName( l_id );
  stNetChaSideInfo SNetSideInfo;
  ReadChaSidePacket(pk, SNetSideInfo);
  NetChaSideInfo(l_id, SNetSideInfo);
  return TRUE;
  T_E
}

BOOL SC_SynAppendLook(LPRPACKET pk)
{
  T_B
	  uLong l_id = pk.ReadLong();
  //	char* szLogName = g_LogName.GetLogName( l_id );
  stNetAppendLook SNetAppendLook;
  ReadChaAppendLookPacket(pk, SNetAppendLook);
  SNetAppendLook.Exec(l_id);

  return TRUE;
  T_E
}

BOOL SC_KitbagCheckAnswer(LPRPACKET packet)
{
  T_B bool bLock = packet.ReadChar() ? true : false;
  NetKitbagCheckAnswer(bLock);

  return TRUE;
  T_E
}

BOOL SC_ExchangeAnswer(LPRPACKET packet)
{
  T_B char ReturnCase = packet.ReadChar(); // 商城是否开启
  if(ReturnCase == 1)
  {
	if(!g_stRumDealForm.IsOpen() && !g_stUIDoublePwd.GetIsShowDoublePwdForm())
	  return FALSE;

	g_stUIDoublePwd.CloseAllForm();

	//买单
	uChar	BuyListSize = packet.ReadChar();
	LONG64* BuyPrices	= new LONG64[BuyListSize];
	LONG64* BuyCounts	= new LONG64[BuyListSize];
	for(uChar i = 0; i < BuyListSize; ++i)
	{
	  BuyPrices[i] = packet.ReadLongLong();
	  BuyCounts[i] = packet.ReadLongLong();
	}

	g_stRumDealForm.AddBuyInfo(BuyListSize, BuyPrices, BuyCounts);

	delete[] BuyPrices;
	delete[] BuyCounts;

	//卖单
	uChar	SellListSize = packet.ReadChar();
	LONG64* SellPrices	 = new LONG64[SellListSize];
	LONG64* SellCounts	 = new LONG64[SellListSize];
	for(uChar i = 0; i < SellListSize; ++i)
	{
	  SellPrices[i] = packet.ReadLongLong();
	  SellCounts[i] = packet.ReadLongLong();
	}

	g_stRumDealForm.AddSellInfo(SellListSize, SellPrices, SellCounts);

	delete[] SellPrices;
	delete[] SellCounts;

	//玩家挂单
	uChar	MyDealSize		  = packet.ReadChar();
	LONG64* MyDealPrices	  = new LONG64[MyDealSize];
	LONG64* MyDealCounts	  = new LONG64[MyDealSize];
	short*	MyDealTyes		  = new short[MyDealSize];
	LONG64* MyDealTotalPrices = new LONG64[MyDealSize];
	for(uChar i = 0; i < MyDealSize; ++i)
	{
	  MyDealPrices[i]	   = packet.ReadLongLong();
	  MyDealCounts[i]	   = packet.ReadLongLong();
	  MyDealTyes[i]		   = packet.ReadShort();
	  MyDealTotalPrices[i] = packet.ReadLongLong();
	}

	g_stRumDealForm.AddMyDealInfo(MyDealSize, MyDealPrices, MyDealCounts, MyDealTyes, MyDealTotalPrices);

	delete[] MyDealPrices;
	delete[] MyDealCounts;
	delete[] MyDealTyes;
	delete[] MyDealTotalPrices;

	LONG64 Gold = packet.ReadLongLong();
	LONG64 Coin = packet.ReadLongLong();

	g_stRumDealForm.AddMyDealInfo(Coin, Gold);

	short TotalBuySize	= packet.ReadShort();
	short TotalSellSize = packet.ReadShort();

	g_stRumDealForm.SetTradeIndex(TotalBuySize, TotalSellSize);

	g_stRumDealForm.ShowRumDealForm();

	return TRUE;
  } else if(ReturnCase == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_802));
	return FALSE;
  } else if(ReturnCase == 2)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1015));
	return FALSE;
  } else
	return FALSE;
  T_E
}

BOOL SC_RequestBuyAsk(LPRPACKET packet)
{
  T_B char Result = packet.ReadChar();
  if(Result == '0')
  {
	char Reason = packet.ReadChar();
	if(Reason == '1')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_999));
	else if(Reason == '2')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1000));
	else if(Reason == '3')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1001));
	else if(Reason == '4' || Reason == '5')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1002));
	else if(Reason == '6')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1043));
  } else if(Result == '1')
  {
	Result = packet.ReadChar();
	if(Result == '1')
	{
	  LONG64 CrystalCount = packet.ReadLongLong();
	  LONG64 CrystalPrice = packet.ReadLongLong();
	  LONG64 TotalCost	  = CrystalPrice * CrystalCount;
	  if(g_stRumDealForm.IsOpen())
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1003), (int)CrystalCount, (int)TotalCost);
	} else if(Result == '0')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1004));
  }

  return TRUE;
  T_E
}

BOOL SC_RequestSaleAsk(LPRPACKET packet)
{
  T_B char Result = packet.ReadChar();
  if(Result == '0')
  {
	char Reason = packet.ReadChar();
	if(Reason == '1')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_999));
	else if(Reason == '2')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1000));
	else if(Reason == '3')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1001));
	else if(Reason == '4' || Reason == '5')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1002));
	else if(Reason == '6')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1043));
  } else if(Result == '1')
  {
	Result = packet.ReadChar();
	if(Result == '1')
	{
	  LONG64 CrystalCount = packet.ReadLongLong();
	  LONG64 CrystalPrice = packet.ReadLongLong();
	  LONG64 TotalEarning = CrystalPrice * CrystalCount;
	  if(g_stRumDealForm.IsOpen())
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1005), (int)CrystalCount, (int)TotalEarning);
	} else if(Result == '0')
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1006));
  }

  return TRUE;

  T_E
}

BOOL SC_RequestCancelAsk(LPRPACKET packet)
{
  T_B char Result = packet.ReadChar();
  if(Result == '1')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1007));
  else if(Result == '0')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1008));
  else if(Result == '2')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1011));

  return TRUE;
  T_E
}

BOOL SC_GetFlatMoneyAsk(LPRPACKET packet)
{
  T_B char Result = packet.ReadChar();
  if(Result == '1')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1009));
  else if(Result == '0')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1010));
  else if(Result == '2')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1011));

  return TRUE;
  T_E
}

BOOL SC_RequestRefreshAsr(LPRPACKET packet)
{
  T_B char Result = packet.ReadChar();
  if(Result == '1')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1029));
  else if(Result == '2')
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1011));

  return TRUE;
  T_E
}

BOOL SC_RequesttCrystalState(LPRPACKET packet)
{
  T_B

	  char Result = packet.ReadChar();
  if(Result == 0) // buy
  {
	short State0 = packet.ReadShort();
	if(State0 == 2 || State0 == 3)
	{
	  LONG64 Num   = packet.ReadLongLong();
	  LONG64 Price = packet.ReadLongLong();
	  if(State0 == 2)
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1016), (int)Num, (int)Num, 0, (int)(Num * Price));
	  else
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1017), (int)(Num * Price));
	} else if(State0 == 1)
	{
	  char flag = packet.ReadChar();
	  if(flag == 'T')
	  {
		LONG64 Num	 = packet.ReadLongLong();
		LONG64 Price = packet.ReadLongLong();
		LONG64 Total = packet.ReadLongLong();
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1016), (int)Total, (int)Num, (int)(Total - Num), int(Num * Price));
	  }
	}

	WPacket pk = g_NetIF->GetWPacket();
	pk.WriteCmd(CMD_CM_CHA_CONFIRM_CRYSTALTRADE);
	pk.WriteShort(0);
	pk.WriteShort(State0);
	g_NetIF->SendPacketMessage(pk);
  } else if(Result == 1) //卖
  {
	short State1 = packet.ReadShort();
	if(State1 == 2 || State1 == 3)
	{
	  LONG64 Num   = packet.ReadLongLong();
	  LONG64 Price = packet.ReadLongLong();
	  if(State1 == 2)
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1018), (int)Num, (int)Num, 0, (int)(Num * Price));
	  else
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1019), (int)Num);
	} else if(State1 == 1)
	{
	  char flag = packet.ReadChar();
	  if(flag == 'T')
	  {
		LONG64 Num	 = packet.ReadLongLong();
		LONG64 Price = packet.ReadLongLong();
		LONG64 Total = packet.ReadLongLong();
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1018), (int)Total, (int)(Total - Num), (int)Num, (int)((Total - Num) * Price));
	  }
	}

	WPacket pk = g_NetIF->GetWPacket();
	pk.WriteCmd(CMD_CM_CHA_CONFIRM_CRYSTALTRADE);
	pk.WriteShort(1);
	pk.WriteShort(State1);
	g_NetIF->SendPacketMessage(pk);
  } else if(Result == 2)
  {
	short State0 = packet.ReadShort();
	short State1 = packet.ReadShort();

	if(State0 == 3 || State0 == 2)
	{
	  LONG64 buyNum	  = packet.ReadLongLong();
	  LONG64 buyPrice = packet.ReadLongLong();
	  if(State0 == 2)
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1016), (int)buyNum, (int)buyNum, 0, (int)(buyNum * buyPrice));
	  else
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1017), (int)(buyNum * buyPrice));
	} else if(State0 == 1)
	{
	  char flag = packet.ReadChar();
	  if(flag == 'T')
	  {
		LONG64 buyNum	= packet.ReadLongLong();
		LONG64 buyPrice = packet.ReadLongLong();
		LONG64 buyTotal = packet.ReadLongLong();
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1016), (int)buyTotal, (int)buyNum, (int)(buyTotal - buyNum), (int)(buyNum * buyPrice));
	  }
	}

	if(State1 == 2 || State1 == 3)
	{
	  LONG64 sellNum   = packet.ReadLongLong();
	  LONG64 sellPrice = packet.ReadLongLong();
	  if(State1 == 2)
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1018), (int)sellNum, (int)sellNum, 0, (int)(sellNum * sellPrice));
	  else
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1019), (int)(sellNum));
	} else if(State1 == 1)
	{
	  char flag = packet.ReadChar();
	  if(flag == 'T')
	  {
		LONG64 sellNum	 = packet.ReadLongLong();
		LONG64 sellPrice = packet.ReadLongLong();
		LONG64 sellTotal = packet.ReadLongLong();
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1018), (int)(sellTotal), (int)(sellTotal - sellNum), (int)(sellNum), (int)((sellTotal - sellNum) * sellPrice));
	  }
	}

	WPacket pk = g_NetIF->GetWPacket();
	pk.WriteCmd(CMD_CM_CHA_CONFIRM_CRYSTALTRADE);
	pk.WriteShort(0);
	pk.WriteShort(State0);
	g_NetIF->SendPacketMessage(pk);

	pk = g_NetIF->GetWPacket();
	pk.WriteCmd(CMD_CM_CHA_CONFIRM_CRYSTALTRADE);
	pk.WriteShort(1);
	pk.WriteShort(State1);
	g_NetIF->SendPacketMessage(pk);
  }

  return TRUE;
  T_E
}

BOOL SC_StoreOpenAnswer(LPRPACKET packet)
{
  T_B bool bValid = packet.ReadChar() ? true : false; // 商城是否开启
  if(bValid)
  {
	g_stUIStore.ClearStoreTreeNode();
	g_stUIStore.ClearStoreItemList();
	//g_stUIStore.SetStoreBuyButtonEnable(true);

	long lVip	   = packet.ReadLong(); // VIP
	long lMoBean   = packet.ReadLong(); // 摩豆
	long lRplMoney = packet.ReadLong(); // 代币（水晶）
	g_stUIStore.SetStoreMoney(lMoBean, lRplMoney);
	g_stUIStore.SetStoreVip(lVip);

	long lAfficheNum = packet.ReadLong(); // 公告数量
	int	 i;
	for(i = 0; i < lAfficheNum; i++)
	{
	  long	 lAfficheID = packet.ReadLong(); // 公告ID
	  uShort len;
	  cChar* szTitle = packet.ReadSequence(len); // 公告标题
	  cChar* szComID = packet.ReadSequence(len); // 对应商品ID,用逗号隔开

	  // 添加公告
	}
	long lFirstClass = 0;
	long lClsNum	 = packet.ReadLong(); // 分类数量
	for(i = 0; i < lClsNum; i++)
	{
	  short	 lClsID = packet.ReadShort(); // 分类ID
	  uShort len;
	  cChar* szClsName = packet.ReadSequence(len); // 分类名
	  short	 lParentID = packet.ReadShort();	   // 父类ID

	  // 添加商城树结点
	  g_stUIStore.AddStoreTreeNode(lParentID, lClsID, szClsName);

	  // 提交第一个分类
	  if(i == 0)
	  {
		lFirstClass = lClsID;
	  }
	}

	g_stUIStore.AddStoreUserTreeNode(); // 添加个人管理
	g_stUIStore.ShowStoreForm(true);

	if(lFirstClass > 0)
	{
	  ::CS_StoreListAsk(lFirstClass, 1, (short)CStoreMgr::GetPageSize());
	}
  } else
  {
	// 商城未开启,打开网页
	g_stUIStore.ShowStoreWebPage();
  }

  g_stUIStore.DarkScene(false);
  g_stUIStore.ShowStoreLoad(false);

  return TRUE;
  T_E
}

BOOL SC_StoreListAnswer(LPRPACKET packet)
{
  T_B
	  g_stUIStore.ClearStoreItemList();

  short sPageNum = packet.ReadShort(); // 页数
  short sPageCur = packet.ReadShort(); // 当前页
  short sComNum	 = packet.ReadShort(); // 商品数

  long i;
  for(i = 0; i < sComNum; i++)
  {
	long   lComID = packet.ReadLong(); // 商品ID
	uShort len;
	cChar* szComName  = packet.ReadSequence(len);		  // 商品名称
	long   lPrice	  = packet.ReadLong();				  // 商品价格
	cChar* szRemark	  = packet.ReadSequence(len);		  // 商品备注
	bool   isHot	  = packet.ReadChar() ? true : false; // 是否是热卖商品
	long   nTime	  = packet.ReadLong();
	long   lComNumber = packet.ReadLong(); // 商品剩余个数。-1不限制
	long   lComExpire = packet.ReadLong(); // 商品到期时间

	// 添加到商城
	g_stUIStore.AddStoreItemInfo(i, lComID, szComName, lPrice, szRemark, isHot, nTime, lComNumber, lComExpire);

	short sItemClsNum = packet.ReadShort(); // 道具种类数量
	int	  j;
	for(j = 0; j < sItemClsNum; j++)
	{
	  short sItemID	 = packet.ReadShort(); // 道具ID
	  short sItemNum = packet.ReadShort(); // 道具数量
	  short sFlute	 = packet.ReadShort(); // 凹槽数量
	  short pItemAttrID[5];
	  short pItemAttrVal[5];
	  int	k;
	  for(k = 0; k < 5; k++)
	  {
		pItemAttrID[k]	= packet.ReadShort(); // 属性ID
		pItemAttrVal[k] = packet.ReadShort(); // 属性值
	  }

	  // 商品细节内容
	  g_stUIStore.AddStoreItemDetail(i, j, sItemID, sItemNum, sFlute, pItemAttrID, pItemAttrVal);
	}
  }

  // 设置页数
  g_stUIStore.SetStoreItemPage(sPageCur, sPageNum);

  return TRUE;
  T_E
}

BOOL SC_StoreBuyAnswer(LPRPACKET packet)
{
  T_B bool bSucc	 = packet.ReadChar() ? true : false; // 购买是否成功
  long	   lMoBean	 = 0;
  long	   lRplMoney = 0;

  // 通知玩家购买成功
  // ...
  if(bSucc)
  {
	//lMoBean = packet.ReadLong();
	lRplMoney = packet.ReadLong();

	g_stUIStore.SetStoreMoney(-1, lRplMoney);
  } else
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_907)); // 购买道具失败!
  }

  g_stUIStore.SetStoreBuyButtonEnable(true);
  return TRUE;
  T_E
}

BOOL SC_StoreChangeAnswer(LPRPACKET packet)
{
  T_B bool bSucc = packet.ReadChar() ? true : false; // 兑换代币是否成功
  if(bSucc)
  {
	long lMoBean   = packet.ReadLong(); // 当前摩豆数量
	long lRplMoney = packet.ReadLong(); // 当前代币数量

	g_stUIStore.SetStoreMoney(lMoBean, lRplMoney);
  } else
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_908)); // 代币兑换失败!
  }
  return TRUE;
  T_E
}

BOOL SC_StoreHistory(LPRPACKET packet)
{
  T_B long lNum = packet.ReadLong(); // 获取的交易记录数量
  int	   i;
  for(i = 0; i < lNum; i++)
  {
	uShort len;
	cChar* szTime = packet.ReadSequence(len); // 交易时间
	long   lComID = packet.ReadLong();		  // 商品ID
	cChar* szName = packet.ReadSequence(len); // 商品名称
	long   lMoney = packet.ReadLong();		  // 交易金额
  }
  return TRUE;
  T_E
}

BOOL SC_ActInfo(LPRPACKET packet)
{
  T_B bool bSucc = packet.ReadChar() ? true : false; // 帐号信息查询是否成功
  if(bSucc)
  {
	long lMoBean   = packet.ReadLong(); // 摩豆数量
	long lRplMoney = packet.ReadLong(); // 代币数量
  }
  return TRUE;
  T_E
}

BOOL SC_StoreVIP(LPRPACKET packet)
{
  T_B bool bSucc = packet.ReadChar() ? true : false;
  if(bSucc)
  {
	short sVipID	= packet.ReadShort();
	short sMonth	= packet.ReadShort();
	long  lShuijing = packet.ReadLong();
	long  lModou	= packet.ReadLong();

	g_stUIStore.SetStoreVip(sVipID);
	g_stUIStore.SetStoreMoney(lModou, lShuijing);
  }
  return TRUE;
  T_E
}

BOOL SC_BlackMarketExchangeData(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  g_stUIBlackTrade.SetNpcID(dwNpcID);

  stBlackTrade SBlackTrade;
  short		   sCount = packet.ReadShort();
  for(short sIndex = 0; sIndex < sCount; ++sIndex)
  {
	memset(&SBlackTrade, 0, sizeof(stBlackTrade));

	SBlackTrade.sIndex	 = sIndex;
	SBlackTrade.sSrcID	 = packet.ReadShort(); // 需求物品ID
	SBlackTrade.sSrcNum	 = packet.ReadShort(); // 需求物品数量
	SBlackTrade.sTarID	 = packet.ReadShort(); // 目标物品ID
	SBlackTrade.sTarNum	 = packet.ReadShort(); // 目标物品数量
	SBlackTrade.sTimeNum = packet.ReadShort(); // time值

	g_stUIBlackTrade.SetItem(&SBlackTrade);
  }

  g_stUIBlackTrade.ShowBlackTradeForm(true);

  return TRUE;
  T_E
}

BOOL SC_ExchangeData(LPRPACKET packet)
{
  T_B
	  DWORD dwNpcID = packet.ReadLong();
  g_stUIBlackTrade.SetNpcID(dwNpcID);

  stBlackTrade SBlackTrade;

  short sCount = packet.ReadShort();
  for(short sIndex = 0; sIndex < sCount; ++sIndex)
  {
	memset(&SBlackTrade, 0, sizeof(stBlackTrade));

	SBlackTrade.sIndex	 = sIndex;
	SBlackTrade.sSrcID	 = packet.ReadShort(); // 需求物品ID
	SBlackTrade.sSrcNum	 = packet.ReadShort(); // 需求物品数量
	SBlackTrade.sTarID	 = packet.ReadShort(); // 目标物品ID
	SBlackTrade.sTarNum	 = packet.ReadShort(); // 目标物品数量
	SBlackTrade.sTimeNum = 0;

	g_stUIBlackTrade.SetItem(&SBlackTrade);
  }

  g_stUIBlackTrade.ShowBlackTradeForm(true);

  return TRUE;
  T_E
}

BOOL SC_BlackMarketExchangeUpdate(LPRPACKET packet)
{
  T_B
	  //黑市兑换更新,只有在打开黑市兑换窗口情况下才更新!!!切记

	  DWORD	   dwNpcID = packet.ReadLong();
  stBlackTrade SBlackTrade;

  // 将原先的黑市兑换数据清空
  g_stUIBlackTrade.ClearItemData();

  short sCount = packet.ReadShort();
  for(short sIndex = 0; sIndex < sCount; ++sIndex)
  {
	memset(&SBlackTrade, 0, sizeof(stBlackTrade));

	SBlackTrade.sIndex	 = sIndex;
	SBlackTrade.sSrcID	 = packet.ReadShort(); // 需求物品ID
	SBlackTrade.sSrcNum	 = packet.ReadShort(); // 需求物品数量
	SBlackTrade.sTarID	 = packet.ReadShort(); // 目标物品ID
	SBlackTrade.sTarNum	 = packet.ReadShort(); // 目标物品数量
	SBlackTrade.sTimeNum = packet.ReadShort(); // time值

	if(g_stUIBlackTrade.GetIsShow() && g_stUIBlackTrade.GetNpcID() == dwNpcID)
	{
	  g_stUIBlackTrade.SetItem(&SBlackTrade);
	}
  }

  if(g_stUIBlackTrade.GetIsShow() && g_stUIBlackTrade.GetNpcID() == dwNpcID)
  {
	g_stUIBlackTrade.ShowBlackTradeForm(true);
  }

  return TRUE;
  T_E
}

BOOL SC_BlackMarketExchangeAsr(LPRPACKET packet)
{
  T_B bool bSucc = (packet.ReadChar() == 1) ? true : false;
  if(bSucc)
  {
	stBlackTrade SBlackTrade;
	memset(&SBlackTrade, 0, sizeof(stBlackTrade));

	SBlackTrade.sSrcID	= packet.ReadShort();
	SBlackTrade.sSrcNum = packet.ReadShort();
	SBlackTrade.sTarID	= packet.ReadShort();
	SBlackTrade.sTarNum = packet.ReadShort();

	g_stUIBlackTrade.ExchangeAnswerProc(bSucc, &SBlackTrade);
  }

  return TRUE;
  T_E
}

BOOL SC_TigerItemID(LPRPACKET packet)
{
  T_B short sNum	   = packet.ReadShort(); // 次数
  short		sItemID[3] = {0};

  for(int i = 0; i < 3; i++)
  {
	sItemID[i] = packet.ReadShort();
  }

  g_stUISpirit.UpdateErnieNumber(sNum, sItemID[0], sItemID[1], sItemID[2]);

  if(sNum == 3)
  {
	// 最后一次
	g_stUISpirit.ShowErnieHighLight();
  }

  return TRUE;
  T_E
}

BOOL SC_VolunteerList(LPRPACKET packet)
{
  T_B short sPageNum = packet.ReadShort(); //总页数
  short		sPage	 = packet.ReadShort(); //当前页数
  short		sRetNum	 = packet.ReadShort(); //志愿者数量

  g_stUIFindTeam.SetFindTeamPage(sPage, sPageNum);
  g_stUIFindTeam.RemoveTeamInfo();

  for(int i = 0; i < sRetNum; i++)
  {
	const char* szName	  = packet.ReadString();
	long		level	  = packet.ReadLong();
	long		job		  = packet.ReadLong();
	const char* szMapName = packet.ReadString();

	g_stUIFindTeam.AddFindTeamInfo(i, szName, level, job, szMapName);
  }

  return TRUE;
  T_E
}

BOOL SC_VolunteerState(LPRPACKET packet)
{
  T_B bool bState = (packet.ReadChar() == 0) ? false : true;
  g_stUIFindTeam.SetOwnFindTeamState(bState);
  CS_VolunteerOpen(10); //Add by sunny.sun 20081107 for 简单更新志愿者列表
  return TRUE;
  T_E
}

BOOL SC_VolunteerOpen(LPRPACKET packet)
{
  T_B bool bState	= (packet.ReadChar() == 0) ? false : true;
  short	   sPageNum = packet.ReadShort(); //总页数
  short	   sRetNum	= packet.ReadShort(); //志愿者数量

  g_stUIFindTeam.SetOwnFindTeamState(bState);
  g_stUIFindTeam.SetFindTeamPage(1, sPageNum <= 0 ? 1 : sPageNum);
  g_stUIFindTeam.RemoveTeamInfo();

  for(int i = 0; i < sRetNum; i++)
  {
	const char* szName	  = packet.ReadString();
	long		level	  = packet.ReadLong();
	long		job		  = packet.ReadLong();
	const char* szMapName = packet.ReadString();

	g_stUIFindTeam.AddFindTeamInfo(i, szName, level, job, szMapName);
  }

  g_stUIFindTeam.ShowFindTeamForm();

  return TRUE;
  T_E
}

BOOL SC_VolunteerAsk(LPRPACKET packet)
{
  T_B const char* szName = packet.ReadString();
  g_stUIFindTeam.FindTeamAsk(szName);

  return TRUE;
  T_E
}

BOOL SC_SyncKitbagTemp(LPRPACKET packet)
{
  /*stNetActorCreate SCreateInfo;
	ReadChaBasePacket(packet, SCreateInfo);
	SCreateInfo.chSeeType = enumENTITY_SEEN_NEW;
	SCreateInfo.chMainCha = 1;
	SCreateInfo.CreateCha();*/
  //g_ulWorldID = SCreateInfo.ulWorldID;

  stNetKitbag SKitbagTemp;
  ReadChaKitbagPacket(packet, SKitbagTemp);
  SKitbagTemp.chBagType = 2;
  NetChangeKitbag(g_ulWorldID, SKitbagTemp);

  //CWorldScene* pWorldScene = dynamic_cast<CWorldScene*>(g_pGameApp->GetCurScene());
  //if(pWorldScene)

  return TRUE;
}

BOOL SC_SyncTigerString(LPRPACKET packet)
{
  const char* szString = packet.ReadString();
  g_stUISpirit.UpdateErnieString(szString);

  return TRUE;
}

// Add by lark.li 20080707 begin
BOOL SC_CaptainAsk(LPRPACKET packet)
{
  DWORD dwTeamID = packet.ReadLong();
  g_stUIChat.CaptainConfirm(dwTeamID);
  return TRUE;
}
// End

#ifdef _XTRAP_
// Add by Rock.wang 20090729 begin
BOOL SC_XtrapStepOne(LPRPACKET packet)
{
  WPacket	  wpk  = g_NetIF->GetWPacket();
  const char* szIn = packet.ReadString();
  char		  szOut[2048];
  memset(szOut, 0, sizeof(szOut));
  wpk.WriteCmd(XTRAP_CMD_STEP_TWO);
  XTrap_CS_Step2(szIn, szOut,
				 XTRAP_PROTECT_PE | XTRAP_PROTECT_TEXT | XTRAP_PROTECT_RDATA | XTRAP_PROTECT_EDATA | XTRAP_PROTECT_RSRC | XTRAP_PROTECT_RELOC | XTRAP_PROTECT_EXCEPT_VIRUS);
  wpk.WriteString(szOut);
  g_NetIF->SendPacketMessage(wpk);
  return TRUE;
}
// End
#endif

BOOL SC_MasterAsk(LPRPACKET packet)
{
  const char* szName   = packet.ReadString(); // 名字
  DWORD		  dwCharID = packet.ReadLong();
  g_stUIChat.MasterAsk(szName, dwCharID);
  return TRUE;
}

BOOL SC_PrenticeAsk(LPRPACKET packet)
{
  const char* szName   = packet.ReadString(); // 名字
  DWORD		  dwCharID = packet.ReadLong();
  g_stUIChat.PrenticeAsk(szName, dwCharID);
  return TRUE;
}

BOOL PC_MasterRefresh(LPRPACKET packet)
{
  unsigned char l_type = packet.ReadChar();
  switch(l_type)
  {
  case MSG_MASTER_REFRESH_ONLINE:
  {
	uLong ulChaID = packet.ReadLong();
	NetMasterOnline(ulChaID);
  }
  break;
  case MSG_MASTER_REFRESH_OFFLINE:
  {
	uLong ulChaID = packet.ReadLong();
	NetMasterOffline(ulChaID);
  }
  break;
  case MSG_MASTER_REFRESH_DEL:
  {
	uLong ulChaID = packet.ReadLong();
	NetMasterDel(ulChaID);
  }
  break;
  case MSG_MASTER_REFRESH_ADD:
  {
	cChar* l_grp	 = packet.ReadString();
	uLong  l_chaid	 = packet.ReadLong();
	cChar* l_chaname = packet.ReadString();
	cChar* l_motto	 = packet.ReadString();
	uShort l_icon	 = packet.ReadShort();
	NetMasterAdd(l_chaid, l_chaname, l_motto, l_icon, l_grp);
  }
  break;
  case MSG_MASTER_REFRESH_START:
  {
	stNetFrndStart l_self;
	l_self.lChaid	 = packet.ReadLong();
	l_self.szChaname = packet.ReadString();
	l_self.szMotto	 = packet.ReadString();
	l_self.sIconID	 = packet.ReadShort();
	stNetFrndStart l_nfs[100];
	uShort		   l_nfnum = 0, l_grpnum = packet.ReadShort();
	for(uShort l_grpi = 0; l_grpi < l_grpnum; l_grpi++)
	{
	  cChar* l_grp	   = packet.ReadString();
	  uShort l_grpmnum = packet.ReadShort();
	  for(uShort l_grpmi = 0; l_grpmi < l_grpmnum; l_grpmi++)
	  {
		l_nfs[l_nfnum].szGroup	 = l_grp;
		l_nfs[l_nfnum].lChaid	 = packet.ReadLong();
		l_nfs[l_nfnum].szChaname = packet.ReadString();
		l_nfs[l_nfnum].szMotto	 = packet.ReadString();
		l_nfs[l_nfnum].sIconID	 = packet.ReadShort();
		l_nfs[l_nfnum].cStatus	 = packet.ReadChar();
		l_nfnum++;

		// Add by lark.li 20090331 begin for 北美Bug
		if(l_nfnum >= 100)
		  break;
		// End
	  }

	  // Add by lark.li 20090331 begin for 北美Bug
	  if(l_nfnum >= 100)
		break;
	  // End
	}
	NetMasterStart(l_self, l_nfs, l_nfnum);
  }
  break;

  case MSG_PRENTICE_REFRESH_ONLINE:
  {
	uLong ulChaID = packet.ReadLong();
	NetPrenticeOnline(ulChaID);
  }
  break;
  case MSG_PRENTICE_REFRESH_OFFLINE:
  {
	uLong ulChaID = packet.ReadLong();
	NetPrenticeOffline(ulChaID);
  }
  break;
  case MSG_PRENTICE_REFRESH_DEL:
  {
	uLong ulChaID = packet.ReadLong();
	NetPrenticeDel(ulChaID);
  }
  break;
  case MSG_PRENTICE_REFRESH_ADD:
  {
	cChar* l_grp	 = packet.ReadString();
	uLong  l_chaid	 = packet.ReadLong();
	cChar* l_chaname = packet.ReadString();
	cChar* l_motto	 = packet.ReadString();
	uShort l_icon	 = packet.ReadShort();
	NetPrenticeAdd(l_chaid, l_chaname, l_motto, l_icon, l_grp);
  }
  break;
  case MSG_PRENTICE_REFRESH_START:
  {
	stNetFrndStart l_self;
	l_self.lChaid	 = packet.ReadLong();
	l_self.szChaname = packet.ReadString();
	l_self.szMotto	 = packet.ReadString();
	l_self.sIconID	 = packet.ReadShort();
	stNetFrndStart l_nfs[100];
	uShort		   l_nfnum = 0, l_grpnum = packet.ReadShort();
	for(uShort l_grpi = 0; l_grpi < l_grpnum; l_grpi++)
	{
	  cChar* l_grp	   = packet.ReadString();
	  uShort l_grpmnum = packet.ReadShort();
	  for(uShort l_grpmi = 0; l_grpmi < l_grpmnum; l_grpmi++)
	  {
		uShort index		   = l_grpmi % (sizeof(l_nfs) / sizeof(l_nfs[0]));
		l_nfs[index].szGroup   = l_grp;
		l_nfs[index].lChaid	   = packet.ReadLong();
		l_nfs[index].szChaname = packet.ReadString();
		l_nfs[index].szMotto   = packet.ReadString();
		l_nfs[index].sIconID   = packet.ReadShort();
		l_nfs[index].cStatus   = packet.ReadChar();
		l_nfnum++;

		// Add by lark.li 20090331 begin for 北美Bug
		if(l_nfnum >= 100)
		  break;
		// End
	  }

	  // Add by lark.li 20090331 begin for 北美Bug
	  if(l_nfnum >= 100)
		break;
	  // End
	}

	NetPrenticeStart(l_self, l_nfs, std::min<unsigned short>(l_nfnum, std::size(l_nfs)));
  }
  break;
  }
  return TRUE;
}

BOOL PC_MasterCancel(LPRPACKET packet)
{
  unsigned char reason	= packet.ReadChar();
  uLong			ulChaID = packet.ReadLong();
  NetMasterCancel(packet.ReadLong(), reason);
  return TRUE;
}

BOOL PC_MasterRefreshInfo(LPRPACKET packet)
{
  unsigned long	 l_chaid = packet.ReadLong();
  const char*	 l_motto = packet.ReadString();
  unsigned short l_icon	 = packet.ReadShort();
  unsigned short l_degr	 = packet.ReadShort();
  const char*	 l_job	 = packet.ReadString();
  const char*	 l_guild = packet.ReadString();
  NetMasterRefreshInfo(l_chaid, l_motto, l_icon, l_degr, l_job, l_guild);
  return TRUE;
}

BOOL PC_PrenticeRefreshInfo(LPRPACKET packet)
{
  unsigned long	 l_chaid = packet.ReadLong();
  const char*	 l_motto = packet.ReadString();
  unsigned short l_icon	 = packet.ReadShort();
  unsigned short l_degr	 = packet.ReadShort();
  const char*	 l_job	 = packet.ReadString();
  const char*	 l_guild = packet.ReadString();
  NetPrenticeRefreshInfo(l_chaid, l_motto, l_icon, l_degr, l_job, l_guild);
  return TRUE;
}

BOOL SC_ChaPlayEffect(LPRPACKET packet)
{
  unsigned int uiWorldID = packet.ReadLong();
  int		   nEffectID = packet.ReadLong();

  NetChaPlayEffect(uiWorldID, nEffectID);

  return TRUE;
}

BOOL SC_Say2Camp(LPRPACKET packet)
{
  cChar* szName	   = packet.ReadString();
  cChar* szContent = packet.ReadString();

  //g_pGameApp->SysInfo("[阵营]%s:%s", szName, szContent);
  NetSideInfo(szName, szContent);

  return TRUE;
}

BOOL SC_GMMail(LPRPACKET packet)
{
  cChar* szTitle   = packet.ReadString();
  cChar* szContent = packet.ReadString();
  long	 lTime	   = packet.ReadLong();

  g_stUIMail.ShowAnswerForm(szTitle, szContent);

  return TRUE;
}

BOOL SC_CheatCheck(LPRPACKET packet)
{
  short count = packet.ReadShort(); // 图片数量
  for(int i = 0; i < count; i++)
  {
	char* picture = NULL;
	short size	  = packet.ReadShort(); // 图片大小
	picture		  = new char[size];
	for(int j = 0; j < size; j++)
	{
	  picture[j] = packet.ReadChar();
	}

	g_stUINumAnswer.SetBmp(i, (BYTE*)picture, size);

	delete[] picture;
  }

  g_stUINumAnswer.Refresh();
  g_stUINumAnswer.ShowForm();

  return TRUE;
}

BOOL SC_ListAuction(LPRPACKET pk)
{
  short				sNum = pk.ReverseReadShort(); // 竞拍数量
  stChurchChallenge stInfo;

  for(int i = 0; i < sNum; i++)
  {
	short  sItemID	 = pk.ReadShort();	// id
	cChar* szName	 = pk.ReadString(); // name
	cChar* szChaName = pk.ReadString(); // 挑战者
	short  sCount	 = pk.ReadShort();	// 数量
	long   baseprice = pk.ReadLong();	// 底价
	long   minbid	 = pk.ReadLong();	// 最低出价
	long   curprice	 = pk.ReadLong();	// 当前竞拍价

	stInfo.sChurchID  = sItemID;
	stInfo.sCount	  = sCount;
	stInfo.nBasePrice = baseprice;
	stInfo.nMinbid	  = minbid;
	stInfo.nCurPrice  = curprice;
	/*strncpy(stInfo.szChaName, szChaName, sizeof(stInfo.szChaName) - 1);
		strncpy(stInfo.szName, szName, sizeof(stInfo.szName) - 1);*/
	strncpy_s(stInfo.szChaName, sizeof(stInfo.szChaName) - 1, szChaName, _TRUNCATE);
	strncpy_s(stInfo.szName, sizeof(stInfo.szName) - 1, szName, _TRUNCATE);
  }

  NetChurchChallenge(&stInfo);

  return TRUE;
}

// 处理数据报=======================================================================
void ReadChaBasePacket(LPRPACKET pk, stNetActorCreate& SCreateInfo)
{
  T_B
	  SCreateInfo = {};
  // 基本数据
  SCreateInfo.ulChaID	= pk.ReadLong();
  SCreateInfo.ulWorldID = pk.ReadLong();

#ifdef _KOSDEMO_
  if(SCreateInfo.ulChaID == 931)
  {
	PetWorldID = SCreateInfo.ulWorldID;
  }
#endif

  SCreateInfo.ulCommID		 = pk.ReadLong();
  SCreateInfo.szCommName	 = pk.ReadString();
  SCreateInfo.chGMLv		 = pk.ReadChar();
  SCreateInfo.lHandle		 = pk.ReadLong();
  SCreateInfo.chCtrlType	 = pk.ReadChar(); // 角色类型（参考CompCommand.h EChaCtrlType）
  SCreateInfo.szName		 = (char*)pk.ReadString();
  SCreateInfo.strMottoName	 = pk.ReadString(); // 读出座右铭
  SCreateInfo.sIcon			 = pk.ReadShort();	// 角色聊天头像
  SCreateInfo.lGuildID		 = pk.ReadLong();
  SCreateInfo.strGuildName	 = pk.ReadString(); // 工会名
  SCreateInfo.strGuildMotto	 = pk.ReadString(); // 工会座右铭
  SCreateInfo.strStallName	 = pk.ReadString(); // 工会座右铭
  SCreateInfo.sState		 = pk.ReadShort();
  SCreateInfo.SArea.centre.x = pk.ReadLong();
  SCreateInfo.SArea.centre.y = pk.ReadLong();
  SCreateInfo.SArea.radius	 = pk.ReadLong();
  SCreateInfo.sAngle		 = pk.ReadShort();
  SCreateInfo.ulTLeaderID	 = pk.ReadLong(); // 队长ID

  //	char* szLogName = NULL; //g_LogName.SetLogName( SCreateInfo.ulWorldID, SCreateInfo.szName );
  ReadChaSidePacket(pk, SCreateInfo.SSideInfo);
  ReadEntEventPacket(pk, SCreateInfo.SEvent);
  ReadChaLookPacket(pk, SCreateInfo.SLookInfo);
  ReadChaPKPacket(pk, SCreateInfo.SPKCtrl);
  ReadChaAppendLookPacket(pk, SCreateInfo.SAppendLook);

  // 	LG(szLogName, "+++++++++++++Create(State: %u\tPos: [%d, %d]\n", SCreateInfo.sState, SCreateInfo.SArea.centre.x, SCreateInfo.SArea.centre.y);
  // 	LG(szLogName, "CtrlType:%d, TeamdID:%u\n", SCreateInfo.chCtrlType, SCreateInfo.ulTLeaderID );

  T_E
}

BOOL ReadChaSkillBagPacket(LPRPACKET pk, stNetSkillBag& SCurSkill)
{
  T_B
					memset(&SCurSkill, 0, sizeof(SCurSkill));
  stNetDefaultSkill SDefaultSkill;
  SDefaultSkill.sSkillID = pk.ReadShort();
  SDefaultSkill.Exec();

  SCurSkill.chType = pk.ReadChar();
  short sSkillNum  = pk.ReadShort();
  if(sSkillNum <= 0)
	return TRUE;

  SCurSkill.SBag.Resize(sSkillNum);
  SSkillGridEx* pSBag = SCurSkill.SBag.GetValue();
  short			i	  = 0;
  for(; i < sSkillNum; i++)
  {
	pSBag[i].sID		 = pk.ReadShort();
	pSBag[i].chState	 = pk.ReadChar();
	pSBag[i].chLv		 = pk.ReadChar();
	pSBag[i].sUseSP		 = pk.ReadShort();
	pSBag[i].sUseEndure	 = pk.ReadShort();
	pSBag[i].sUseEnergy	 = pk.ReadShort();
	pSBag[i].lResumeTime = pk.ReadLong();
	pSBag[i].sRange[0]	 = pk.ReadShort();
	if(pSBag[i].sRange[0] != enumRANGE_TYPE_NONE)
	  for(short j = 1; j < defSKILL_RANGE_PARAM_NUM; j++)
		pSBag[i].sRange[j] = pk.ReadShort();
  }

  // log
  // 	LG(szLogName, "Syn Skill Bag, Type:%d,\tTick:[%u]\n", SCurSkill.chType, GetTickCount());
  // 	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_310));
  // 	char	szRange[256];
  // 	for (i = 0; i < sSkillNum; i++)
  // 	{
  // 		_snprintf_s(szRange,_countof( szRange ), _TRUNCATE, "%d", pSBag[i].sRange[0]);
  // 		if (pSBag[i].sRange[0] != enumRANGE_TYPE_NONE)
  // 			for (short j = 1; j < defSKILL_RANGE_PARAM_NUM; j++)
  // 				_snprintf_s(szRange + strlen(szRange), 256- strlen(szRange),_TRUNCATE, ",%d", pSBag[i].sRange[j]);
  // 		LG(szLogName, "\t%4d\t%4d\t%4d\t%6d\t%6d\t%6d\t%18d\t%s\n", pSBag[i].sID, pSBag[i].chState, pSBag[i].chLv, pSBag[i].sUseSP, pSBag[i].sUseEndure, pSBag[i].sUseEnergy, pSBag[i].lResumeTime, szRange);
  // 	}
  // 	LG(szLogName, "\n");
  //

  return TRUE;
  T_E
}

void ReadChaSkillStatePacket(LPRPACKET pk, stNetSkillState& SCurSState)
{
  T_B
	  memset(&SCurSState, 0, sizeof(SCurSState));
  SCurSState.chType = 0;
  short sNum		= pk.ReadChar();
  if(sNum > 0)
  {
	SCurSState.SState.Resize(sNum);
	for(int nNum = 0; nNum < sNum; nNum++)
	{
	  SCurSState.SState[nNum].chID = pk.ReadChar();
	  SCurSState.SState[nNum].chLv = pk.ReadChar();
	}
  }

  // log
  // 	LG(szLogName, "Syn Skill State: Num[%d]\tTick[%u]\n", sNum, GetTickCount());
  // 	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_311));
  // 	for (char i = 0; i < sNum; i++)
  // 		LG(szLogName, "\t%8d\t%4d\n", SCurSState.SState[i].chID, SCurSState.SState[i].chLv);
  // 	LG(szLogName, "\n");
  //
  T_E
}

void ReadChaAttrPacket(LPRPACKET pk, stNetChaAttr& SChaAttr)
{
  T_B
	  memset(&SChaAttr, 0, sizeof(SChaAttr));
  SChaAttr.chType = pk.ReadChar();
  SChaAttr.sNum	  = pk.ReadShort();
  for(short i = 0; i < SChaAttr.sNum; i++)
  {
	SChaAttr.SEff[i].lAttrID = pk.ReadChar();
	if(SChaAttr.SEff[i].lAttrID == ATTR_CEXP || SChaAttr.SEff[i].lAttrID == ATTR_NLEXP || SChaAttr.SEff[i].lAttrID == ATTR_CLEXP)
	  SChaAttr.SEff[i].lVal = pk.ReadLongLong();
	else
	  SChaAttr.SEff[i].lVal = (long)pk.ReadLong();
  }

  // log
  //	LG(szLogName, "Syn Character Attr: Count=%d\t, Type:%d\tTick:[%u]\n", SChaAttr.sNum, SChaAttr.chType, GetTickCount());
  //	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_312));
  // 	for (short i = 0; i < SChaAttr.sNum; i++)
  // 	{
  // 		LG(szLogName, "\t%d\t%i64\n", SChaAttr.SEff[i].lAttrID, SChaAttr.SEff[i].lVal);
  // 	}
  // 	LG(szLogName, "\n");
  //
  T_E
}

void ReadChaLookPacket(LPRPACKET pk, stNetLookInfo& SLookInfo)
{
  T_B
	  memset(&SLookInfo, 0, sizeof(SLookInfo));
  SLookInfo.chSynType		   = pk.ReadChar();
  stNetChangeChaPart& SChaPart = SLookInfo.SLook;
  SChaPart.sTypeID			   = pk.ReadShort();
  if(pk.ReadChar() == 1) // 船的外观
  {
	SChaPart.sPosID		= pk.ReadShort();
	SChaPart.sBoatID	= pk.ReadShort();
	SChaPart.sHeader	= pk.ReadShort();
	SChaPart.sBody		= pk.ReadShort();
	SChaPart.sEngine	= pk.ReadShort();
	SChaPart.sCannon	= pk.ReadShort();
	SChaPart.sEquipment = pk.ReadShort();

	// log
	// 		LG(szLogName, "===Recieve(Look):\tTick:[%u]\n", GetTickCount());
	// 		LG(szLogName, "TypeID:%d, PoseID:%d\n", SChaPart.sTypeID, SChaPart.sPosID);
	// 		LG(szLogName, "\tPart: Boat:%u, Header:%u, Body:%u, Engine:%u, Cannon:%u, Equipment:%u\n", SChaPart.sBoatID, SChaPart.sHeader, SChaPart.sBody, SChaPart.sEngine, SChaPart.sCannon, SChaPart.sEquipment );
	// 		LG(szLogName, "\n");
	//
  } else
  {
	SChaPart.sHairID = pk.ReadShort();
	SItemGrid* pItem;
	for(int i = 0; i < enumEQUIP_NUM; i++)
	{
	  pItem		 = SChaPart.SLink + i;
	  pItem->sID = pk.ReadShort();
	  //Add by sunny.sun 20081014 （贝壳装备外观属性修改）
	  //Begin
	  if(SLookInfo.chSynType == enumSYN_LOOK_CHANGE)
	  {
		if(pItem->sID == 0)
		{
		  memset(pItem, 0, sizeof(SItemGrid));
		  continue;
		}
	  }
	  //End
	  pItem->dwDBID = pk.ReadLong();
	  if(pItem->sID == 0)
	  {
		memset(pItem, 0, sizeof(SItemGrid));
		continue;
	  }
	  if(SLookInfo.chSynType == enumSYN_LOOK_CHANGE)
	  {
		pItem->sEndure[0] = pk.ReadShort();
		pItem->sEnergy[0] = pk.ReadShort();
		pItem->SetValid(pk.ReadChar() != 0 ? true : false);
		continue;
	  } else
	  {
		pItem->sNum		  = pk.ReadShort();
		pItem->sEndure[0] = pk.ReadShort();
		pItem->sEndure[1] = pk.ReadShort();
		pItem->sEnergy[0] = pk.ReadShort();
		pItem->sEnergy[1] = pk.ReadShort();
		pItem->chForgeLv = pk.ReadChar();
		pItem->SetValid(pk.ReadChar() != 0 ? true : false);
	  }

	  if(pk.ReadChar() == 0)
		continue;

	  pItem->SetDBParam(enumITEMDBP_FORGE, pk.ReadLong());
	  pItem->SetDBParam(enumITEMDBP_INST_ID, pk.ReadLong());
	  if(pk.ReadChar()) // 存在实例属性
	  {
		for(int j = 0; j < defITEM_INSTANCE_ATTR_NUM; j++)
		{
		  pItem->sInstAttr[j][0] = pk.ReadShort();
		  pItem->sInstAttr[j][1] = pk.ReadShort();
		}
	  }
	}

	// log
	// 		LG(szLogName, "===Recieve(Look)\tTick:[%u]\n", GetTickCount());
	// 		LG(szLogName, "TypeID:%d, HairID:%d\n", SChaPart.sTypeID, SChaPart.sHairID);
	// 		for (int i = 0; i < enumEQUIP_NUM; i++)
	// 			LG(szLogName, "\tLink: %d\n", SChaPart.SLink[i].sID);
	// 		LG(szLogName, "\n");
	//
  }
  T_E
}

void ReadChaLookEnergyPacket(LPRPACKET pk, stLookEnergy& SLookEnergy)
{
  T_B
	  memset(&SLookEnergy, 0, sizeof(SLookEnergy));
  for(int i = 0; i < enumEQUIP_NUM; i++)
  {
	SLookEnergy.sEnergy[i] = pk.ReadShort();
  }
  T_E
}

void ReadChaPKPacket(LPRPACKET pk, stNetPKCtrl& SNetPKCtrl)
{
  T_B char chPKCtrl		 = pk.ReadChar();
  SNetPKCtrl.bInGymkhana = chPKCtrl & 0x02 ? true : false;
  SNetPKCtrl.bInPK		 = chPKCtrl & 0x01 ? true : false;

  // log
  // 	LG(szLogName, "===Recieve(PKCtrl)\tTick:[%u]\n", GetTickCount());
  // 	LG(szLogName, "\tInGymkhana: %d, InPK: %d\n", SNetPKCtrl.bInGymkhana, SNetPKCtrl.bInPK);
  // 	LG(szLogName, "\n");
  //
  T_E
}

void ReadChaSidePacket(LPRPACKET pk, stNetChaSideInfo& SNetSideInfo)
{
  T_B
	  SNetSideInfo.chSideID = pk.ReadChar();

  // log
  // 	LG(szLogName, "===Recieve(SideInfo)\tTick:[%u]\n", GetTickCount());
  // 	LG(szLogName, "\tSideID: %d\n", SNetSideInfo.chSideID);
  // 	LG(szLogName, "\n");
  //
  T_E
}

void ReadChaAppendLookPacket(LPRPACKET pk, stNetAppendLook& SNetAppendLook)
{
  T_B for(char i = 0; i < defESPE_KBGRID_NUM; i++)
  {
	SNetAppendLook.sLookID[i] = pk.ReadShort();
	if(SNetAppendLook.sLookID[i] != 0)
	  SNetAppendLook.bValid[i] = pk.ReadChar() != 0 ? true : false;
  }

  // log
  // 	if( szLogName )
  // 	LG(szLogName, "===Recieve(Append Look)\tTick:[%u]\n", GetTickCount());
  // 	LG(szLogName, "\tAppend Look:%d(%d), %d(%d), %d(%d), %d(%d)\n",
  // 		SNetAppendLook.sLookID[0], SNetAppendLook.bValid[0],
  // 		SNetAppendLook.sLookID[1], SNetAppendLook.bValid[1],
  // 		SNetAppendLook.sLookID[2], SNetAppendLook.bValid[2],
  // 		SNetAppendLook.sLookID[3], SNetAppendLook.bValid[3]);
  // 	LG(szLogName, "\n");
  //
  T_E
}

void ReadEntEventPacket(LPRPACKET pk, stNetEvent& SNetEvent)
{
  T_B
	  SNetEvent.lEntityID = pk.ReadLong();
  SNetEvent.chEntityType  = pk.ReadChar();
  SNetEvent.usEventID	  = pk.ReadShort();
  SNetEvent.cszEventName  = pk.ReadString();

  // log
  // 	if (szLogName)
  // 	{
  // 		LG(szLogName, "===Recieve(Event)\tTick:[%u]\n", GetTickCount());
  // 		LG(szLogName, "\tEntityID: %u, EventID: %u, EventName: %s\n", SNetEvent.lEntityID, SNetEvent.usEventID, SNetEvent.cszEventName);
  // 		LG(szLogName, "\n");
  // 	}
  //
  T_E
}

void ReadChaKitbagPacket(LPRPACKET pk, stNetKitbag& SKitbag)
{
  T_B
	  memset(&SKitbag, 0, sizeof(SKitbag));
  SKitbag.chType = pk.ReadChar(); // （参考CompCommand.h的ESynKitbagType）
  int nGridNum	 = 0;
  if(SKitbag.chType == enumSYN_KITBAG_INIT) // 道具栏容量
  {
	SKitbag.nKeybagNum = pk.ReadShort();
  }
  // 	LG(szLogName, "===Recieve(Update Kitbag):\tGridNum:%d\tType:%d\tTick:[%u]\n", SKitbag.nKeybagNum, SKitbag.chType, GetTickCount());
  stNetKitbag::stGrid* Grid = SKitbag.Grid;
  SItemGrid*		   pItem;
  CItemRecord*		   pItemRec;
  while(1)
  {
	short sGridID = pk.ReadShort();
	if(sGridID < 0) break;

	Grid[nGridNum].sGridID = sGridID;

	pItem	   = &Grid[nGridNum].SGridContent;
	pItem->sID = pk.ReadShort();
	// 		LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_313), Grid[nGridNum].sGridID, pItem->sID);
	if(pItem->sID > 0) // 存在道具
	{
	  pItem->dwDBID		= pk.ReadLong();
	  pItem->sNum		= pk.ReadShort();
	  pItem->sEndure[0] = pk.ReadShort();
	  pItem->sEndure[1] = pk.ReadShort();
	  pItem->sEnergy[0]	=	pk.ReadShort();
	  pItem->sEnergy[1]	=	pk.ReadShort();
	  // 			LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_314), pItem->sNum, pItem->sEndure[0], pItem->sEndure[1], pItem->sEnergy[0], pItem->sEnergy[1]);
	  pItem->chForgeLv = pk.ReadChar();
	  pItem->SetValid(pk.ReadChar() != 0 ? true : false);

	  pItemRec = GetItemRecordInfo(pItem->sID);
	  if(pItemRec == NULL)
	  {
		char szBuf[256] = {0};
		_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_315), pItem->sID);
		MessageBox(0, szBuf, "Error", 0);
#ifdef __SOUND__
		/*#ifdef USE_DSOUND
				if( g_dwCurMusicID )
				{
					AudioSDL::get_instance()->stop( g_dwCurMusicID );
					g_dwCurMusicID = 0;
					Sleep( 60 );
				}
#endif*/

#ifdef USE_DSOUND
		g_pGameApp->mMP3->Close();
		Sleep(60);
#endif
#endif
		exit(0);
	  }

	  if(pItemRec->sType == enumItemTypeBoat) // 船道具，写入船的WorldID，用于客户端将道具与船角色挂钩
	  {
		pItem->SetDBParam(enumITEMDBP_INST_ID, pk.ReadLong());
	  }

	  pItem->SetDBParam(enumITEMDBP_FORGE, pk.ReadLong());
	  if(pItemRec->sType == enumItemTypeBoat)
	  {
		pk.ReadLong();
	  } else
	  {
		pItem->SetDBParam(enumITEMDBP_INST_ID, pk.ReadLong());
	  }

	  // 			LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_316), pItem->GetDBParam(enumITEMDBP_FORGE));
	  if(pk.ReadChar()) // 存在实例属性
	  {
		for(int j = 0; j < defITEM_INSTANCE_ATTR_NUM; j++)
		{
		  pItem->sInstAttr[j][0] = pk.ReadShort();
		  pItem->sInstAttr[j][1] = pk.ReadShort();
		  // 					LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_317), pItem->sInstAttr[j][0], pItem->sInstAttr[j][1]);
		}
	  }
	}
	nGridNum++;
	if(nGridNum > defMAX_KBITEM_NUM_PER_TYPE) // 不该出现的情况
	{
	  // 			LG(RES_STRING(CL_LANGUAGE_MATCH_318), RES_STRING(CL_LANGUAGE_MATCH_319), nGridNum, defMAX_KBITEM_NUM_PER_TYPE);
	  break;
	}
  }
  SKitbag.nGridNum = nGridNum;
  // 	LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_320), SKitbag.nGridNum);
  T_E
}

void ReadChaShortcutPacket(LPRPACKET pk, stNetShortCut& SShortcut)
{
  T_B
	  memset(&SShortcut, 0, sizeof(SShortcut));
  // 	LG(szLogName, "===Recieve(Update Shortcut):\tTick:[%u]\n", GetTickCount());
  for(int i = 0; i < SHORT_CUT_NUM; i++)
  {
	SShortcut.chType[i]	  = pk.ReadChar();
	SShortcut.byGridID[i] = pk.ReadShort();
	// 		LG(szLogName, RES_STRING(CL_LANGUAGE_MATCH_321), SShortcut.chType[i], SShortcut.byGridID[i]);
  }
  T_E
}

BOOL PC_PKSilver(LPRPACKET packet)
{
  T_B
	  std::string szName;
  long			  sLevel;
  std::string	  szProfession;
  long			  lPkval;
  for(int i = 0; i < MAX_PKSILVER_PLAYER; i++)
  {
	szName		 = packet.ReadString();
	sLevel		 = packet.ReadLong();
	szProfession = packet.ReadString();
	lPkval		 = packet.ReadLong();
	g_stUIPKSilver.AddFormAttribute(i, szName, sLevel, szProfession, lPkval);
  }

  g_stUIPKSilver.ShowPKSilverForm();
  return TRUE;
  T_E
}

BOOL SC_LeaveTimeShow(LPRPACKET packet)
{
  T_B
	  //long distime = packet.ReadLong();
	  //if (distime>=1)
	  //{
	  //	g_stUIStart.ShowAfkButton(true);
	  //	g_stUIStart.RefreshLeftTimeName(distime);
	  //}
	  //g_stAllButton.GetLeaveTime(distime);
	  return TRUE;
  T_E
}

BOOL SC_LeaveExpShow(LPRPACKET packet)
{
  T_B short sSelectTime = packet.ReadShort();
  string	baseExp		= packet.ReadString();
  string	addExp		= packet.ReadString();
  string	allExp		= packet.ReadString();
  string	addLev		= packet.ReadString();
  string	addPercent	= packet.ReadString();
  short		sNum		= packet.ReadShort();
  string	amplitude	= packet.ReadString();
  short		coin		= packet.ReadShort();
  g_stUIStart.ShowExpForm(true);
  g_stUIStart.RefreshLeftExpName(sSelectTime, baseExp, addExp, allExp, addLev, addPercent, sNum, amplitude, coin);
  return TRUE;
  T_E
}

BOOL SC_LifeSkillShow(LPRPACKET packet)
{
  T_B long lType = packet.ReadLong();
  switch(lType)
  {
  case 0: //  合成
  {
	g_stUICompose.ShowComposeForm();
  }
  break;
  case 1: //  分解
  {
	g_stUIBreak.ShowBreakForm();
  }
  break;
  case 2: //  锻造
  {
	g_stUIFound.ShowFoundForm();
  }
  break;
  case 3: //  烹饪
  {
	g_stUICooking.ShowCookingForm();
  }
  break;
  }
  return TRUE;
  T_E
}

BOOL SC_LifeSkill(LPRPACKET packet)
{
  T_B long	  lType = packet.ReadLong();
  short		  ret	= packet.ReadShort();
  std::string txt	= packet.ReadString();

  switch(lType)
  {
  case 0: //  合成
  {
	g_stUICompose.CheckResult(ret, txt.c_str());
  }
  break;
  case 1: //  分解
  {
	g_stUIBreak.CheckResult(ret, txt.c_str());
  }
  break;
  case 2: //  锻造
  {
	std::string strVer[3];
	Util_ResolveTextLine(txt.c_str(), strVer, 3, ',');
	g_stUIFound.CheckResult(ret, strVer[0].c_str(), strVer[1].c_str(), strVer[2].c_str());
  }
  break;
  case 3: //  烹饪
  {
	g_stUICooking.CheckResult(ret);
  }
  break;
  }

  return TRUE;
  T_E
}

BOOL SC_LifeSkillAsr(LPRPACKET packet)
{
  T_B long	  lType = packet.ReadLong();
  short		  tim	= packet.ReadShort();
  std::string txt	= packet.ReadString();

  switch(lType)
  {
  case 0: //  合成
  {
	g_stUICompose.StartTime(tim);
  }
  break;
  case 1: //  分解
  {
	g_stUIBreak.StartTime(tim, txt.c_str());
  }
  break;
  case 2: //  锻造
  {
	g_stUIFound.StartTime(tim);
  }
  break;
  case 3: //  烹饪
  {
	g_stUICooking.StartTime(tim);
  }
  break;
  }
  return TRUE;
  T_E
}

//	2008-7-30	yangyinyu	add
bool g_yyy_add_lock_item_wait_return_state = false;

//	道具锁定的回应消息。
BOOL SC_DropLockAsr(LPRPACKET pk)
{
  T_B
	  //
	  dbc::Char success = pk.ReadChar();

  //
  if(g_yyy_add_lock_item_wait_return_state)
  {
	//	关闭道具对话框。
	if(success)
	{
	  // modify by ning.yan 2008-11-13 begin
	  //g_stUIEquip.CloseAllForm();
	  //g_pGameApp->MsgBox("锁定道具成功！");
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_962));
	  //end
	} else
	{
	  //g_pGameApp->MsgBox("该类道具不可加锁！");// modify by ning.yan 2008-11-13
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_963));
	}
  }

  //
  g_yyy_add_lock_item_wait_return_state = false;

  //	设置等待光标。
  CCursor::I()->SetCursor(CCursor::stNormal);

  //
  return TRUE;
  T_E
};

// add by ning.yan 道具解锁的回应消息 2008-11-12 begin
BOOL SC_UnlockItemAsr(LPRPACKET pk)
{
  T_B

	  dbc::Char success = pk.ReadChar();

  if(g_yyy_add_lock_item_wait_return_state)
  {
	//	关闭道具对话框。
	if(success == 0)
	{
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_964));
	} else if(success == 1)
	{
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_965));
	} else if(success == 2)
	{
	  // 二次密码错误
	}
	// 		else
	// 		{
	// 			char* szLogName = g_LogName.GetMainLogName();
	// 			LG(szLogName, "unlock item answer (file: PacketCmd_SC.cpp, function: SC_UnlockItemAsr ) error! return value: %d.\n", success);
	// 		}
  }

  g_yyy_add_lock_item_wait_return_state = false;

  //	设置等待光标。
  CCursor::I()->SetCursor(CCursor::stNormal);

  return TRUE;
  T_E
}
// end

//==================================================================================
