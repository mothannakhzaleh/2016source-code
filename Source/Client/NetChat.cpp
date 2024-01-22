#include "stdafx.h"
#include "NetChat.h"
#include "UITeam.h"
#include "UIChat.h"
#include "GameApp.h"
#include "UIForm.h"
#include "uicozeform.h"
#include "Character.h"
#include "teaminviteformmgr.h"
#include "frndinviteformmgr.h"
#include "talksessionformmgr.h"
#include "uiboatform.h"

#include "UIChaInfo.h"

void stNetTeamChaPart::Convert(const stNetChangeChaPart& stPart)
{
  sTypeID = stPart.sTypeID;
  sHairID = stPart.sHairID;
  for(int i = 0; i < enumEQUIP_NUM; i++)
  {
	SLink[i].sID	   = stPart.SLink[i].sID;
	SLink[i].sNum	   = stPart.SLink[i].sNum;
	SLink[i].chForgeLv = stPart.SLink[i].chForgeLv;
  }
}

void NetSay2You(stNetSay2You& say2you) //私聊
{
  //g_stUICoze.OnPrivateSay( say2you.m_src, say2you.m_dst, say2you.m_content );
  CCozeForm::GetInstance()->OnPrivateMsg(say2you.m_src, say2you.m_dst, say2you.m_content);
}

void NetSay2Team(unsigned long chaid, const char* word) //队聊
{
  //g_stUICoze.OnTeamSay(chaid,word);
  CCozeForm::GetInstance()->OnTeamMsg(chaid, word);
}

void NetSay2Gud(const char* src, const char* word)
{
  //g_stUICoze.OnGuildSay(src,word);
  CCozeForm::GetInstance()->OnGuildMsg(src, word);
}

void NetSay2All(stNetSay2All& say2all) //世界
{
  //g_stUICoze.OnWorldSay( say2all.m_src, say2all.m_content );
  CCozeForm::GetInstance()->OnWorldMsg(say2all.m_src, say2all.m_content);
}
extern void NetSay2Trade(stNetSay2All& say2all) //交易频道
{
  //g_stUICoze.OnTradeSay( say2all.m_src, say2all.m_content );
  CCozeForm::GetInstance()->OnTradeMsg(say2all.m_src, say2all.m_content);
}
extern void NetGM1Say(stNetSay2All& say2all) //GM喊话
{
  //g_stUICoze.OnGmSay( say2all.m_src, say2all.m_content );
  CCozeForm::GetInstance()->OnPublishMsg(say2all.m_src, say2all.m_content);
}

//add by sunny.sun20080804
extern void NetGM1Say1(stNetScrollSay& say2all) //GM喊话
{
  CCozeForm::GetInstance()->OnPublishMsg1(say2all.m_content, say2all.setnum);
}
//End
void NetSynTeam(stNetTeamState* pSTeamState)
{
  CTeamMgr* pTeamMgr = g_stUIChat.GetTeamMgr();
  CTeam*	pTeam	 = pTeamMgr->Find(enumTeamGroup);
  if(pTeam)
  {
	CMember* pMember = pTeam->Find(pSTeamState->ulID);
	if(pMember)
	{
	  CMemberData* pData = pMember->GetData();
	  if(pData)
	  {
		pData->SetHP(pSTeamState->lHP);
		pData->SetSP(pSTeamState->lSP);
		pData->SetLV(pSTeamState->lLV);
		pData->SetMaxHP(pSTeamState->lMaxHP);
		pData->SetMaxSP(pSTeamState->lMaxSP);
		pData->SetFace(pSTeamState->SFace);
		pData->SetWork(pSTeamState->byWork);
	  }
	  pMember->Refresh();
	}
  }
}

void NetPCTeam(stNetPCTeam& pcteam)
{
  CTeamMgr* pTeamMgr = g_stUIChat.GetTeamMgr();

  pTeamMgr->SetTeamLeaderID(pcteam.cha_dbid[0]);
  LG("teamleader", "TeamID: %u\n", pcteam.cha_dbid[0]);

  if(g_stUIBoat.GetHuman())
  {
	int nID = g_stUIBoat.GetHuman()->getHumanID();
	for(int i = 0; i < pcteam.count; i++)
	{
	  if(pcteam.cha_dbid[i] == nID)
		pcteam.cha_dbid[i] = 0;
	}
  }

  switch(pcteam.kind)
  {
  case TEAM_MSG_KICK:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_218), pcteam.cha_name[pcteam.count - 1]);
  case TEAM_MSG_LEAVE:
	if(pcteam.count <= 2 || pcteam.cha_dbid[pcteam.count - 1] == 0)
	  pcteam.kind = TEAM_MSG_GROUP_BREAK;
	break;
  case TEAM_MSG_ADD:
	if(pcteam.count <= 2 || pcteam.cha_dbid[pcteam.count - 1] == 0)
	  pcteam.kind = TEAM_MSG_GROUP_ADD;
	break;
  }
  //LG("Team", "Kind:[%u], LeaderID:%u\n\n", pcteam.kind, pcteam.cha_dbid[0] );

  switch(pcteam.kind)
  {
  case TEAM_MSG_GROUP_ADD: // 成立队伍
  {
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_219), pcteam.cha_name[0]);

	CTeam* pTeam = pTeamMgr->Add(enumTeamGroup);
	if(pTeam)
	{
	  for(int i = 0; i < pcteam.count; i++)
	  {
		pTeam->Add(pcteam.cha_dbid[i], pcteam.cha_name[i], pcteam.motto[i], pcteam.cha_icon[i], "", true);
	  }
	}
  }
  break;
  case TEAM_MSG_GROUP_BREAK: // 解散队伍
  {
	pTeamMgr->Del(enumTeamGroup);
	pTeamMgr->SetTeamLeaderID(0);
  }
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_220));
	break;
  case TEAM_MSG_ADD: // 子类型:增加新队员
  {
	CTeam* pTeam = pTeamMgr->Find(enumTeamGroup);
	if(pTeam)
	{
	  pTeam->Add(pcteam.cha_dbid[pcteam.count - 1], pcteam.cha_name[pcteam.count - 1], pcteam.motto[pcteam.count - 1], pcteam.cha_icon[pcteam.count - 1], "", true);
	}
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_221), pcteam.cha_name[pcteam.count - 1]);
  }
  break;
  //case TEAM_MSG_OFFLINE:      // 子类型:队员下线
  case TEAM_MSG_LEAVE: // 子类型:队员离开
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_222), pcteam.cha_name[pcteam.count - 1]);
  case TEAM_MSG_KICK:
  {
	CTeam* pTeam = pTeamMgr->Find(enumTeamGroup);
	if(pTeam)
	{
	  pTeam->Del(pcteam.cha_dbid[pcteam.count - 1]);
	}
  }
  break;
  default: LG("protocol", "msgNetPCTeam unknown kind:%d", pcteam.kind);
  }
}

void NetTeamInvite(const char* inviter_name, unsigned long inviter_chaid, unsigned short icon)
{
  //	LG("test_group",RES_STRING(CL_LANGUAGE_MATCH_223),inviter_name,inviter_chaid);
  g_stTeamInviteFormMgr.AddInviteForm(inviter_chaid, inviter_name);
}

void NetTeamCancel(unsigned long inviter_chaid, char reason)
{
  //	LG("test_group",RES_STRING(CL_LANGUAGE_MATCH_224),inviter_chaid,reason );
  switch(reason)
  {
  case MSG_TEAM_CANCLE_BUSY:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_225));
	break;
  case MSG_TEAM_CANCLE_TIMEOUT:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_226));
	break;
  case MSG_TEAM_CANCLE_OFFLINE:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_227));
	break;
  case MSG_TEAM_CANCLE_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_228));
	break;
  case MSG_TEAM_CANCLE_CANCEL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_229));
	break;
  }
  g_stTeamInviteFormMgr.RemoveInviteForm(inviter_chaid);
}

void NetFrndInvite(const char* inviter_name, unsigned long inviter_chaid, unsigned short icon)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_230),inviter_name,inviter_chaid);
  g_stFrndInviteFormMgr.AddInviteForm(inviter_chaid, inviter_name);
}

void NetFrndCancel(unsigned long inviter_chaid, char reason)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_231),inviter_chaid,reason );
  switch(reason)
  {
  case MSG_FRND_CANCLE_BUSY:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_232));
	break;
  case MSG_FRND_CANCLE_TIMEOUT:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_226));
	break;
  case MSG_FRND_CANCLE_OFFLINE:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_227));
	break;
  case MSG_FRND_CANCLE_INVITER_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_233));
	break;
  case MSG_FRND_CANCLE_SELF_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_234));
	break;
  case MSG_FRND_CANCLE_CANCEL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_235));
	break;
  }
  g_stFrndInviteFormMgr.RemoveInviteForm(inviter_chaid);
  //g_stUIChat.ReceiveMsg(enumSCM_FRND_CANCEL,0,inviter_chaid,reason);
}

void NetFrndOnline(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_236),cha_id);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(cha_id);
  if(pMember)
  {
	pMember->SetOnline(true);
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_237), pMember->GetName());
  }
  //g_stUIChat.ReceiveMsg(enumSCM_FRND_ONLINE,0,cha_id);
}

void NetFrndOffline(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_238),cha_id);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(cha_id);
  if(pMember)
  {
	pMember->SetOnline(false);
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_239), pMember->GetName());
  }
  //g_stUIChat.ReceiveMsg(enumSCM_FRND_OFFLINE,0,cha_id);
}

void NetFrndDel(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_240),cha_id);
  g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Del(cha_id);
  //g_stUIChat.ReceiveMsg(enumSCM_FRND_DEL,0,cha_id);
}

void NetFrndAdd(unsigned long cha_id, const char* cha_name, const char* motto, unsigned short icon_id, const char* grp)
{ //grp-所属好友分组
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_241),cha_name,cha_id);
  // Modify by lark.li 20080813 begin
  //g_stUIChat.GetTeamMgr()->Find( enumTeamFrnd )->Add(cha_id,cha_name,motto,icon_id);
  g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Add(cha_id, cha_name, motto, icon_id, grp, true);
  // End
  //g_stUIChat.ReceiveMsg( enumSCM_FRND_ADD,(void*)cha_name,cha_id,icon_id,(void*)motto);
}

// Modify by lark.li 20080804 begin
//void NetFrndStart(stNetFrndStart &self,stNetFrndStart arrCha[],unsigned short arrnum)
void NetFrndStart(stNetFrndStart& self, stNetFrndStart arrCha[], unsigned short arrnum, string groupNames[], unsigned short groupNum)
// End
{
  g_stUIChat._dwSelfIcon	   = self.sIconID;
  g_stUIChat._strSelfMottoName = self.szMotto;
  g_stUIChat._dwSelfID		   = self.lChaid;

  // Add by lark.li 20080804 begin
  for(int i = 0; i < groupNum; i++)
  {
	g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->AddGroupName(groupNames[i].c_str());
  }
  // End

  for(int i = 0; i < arrnum; i++)
  {
	//		LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_242),i,arrCha[i].szChaname,arrCha[i].lChaid);

	// Modify by lark.li 20080802 begin
	//CMember *pMember=g_stUIChat.GetTeamMgr()->Find( enumTeamFrnd )->Add(arrCha[i].lChaid,arrCha[i].szChaname,arrCha[i].szMotto,arrCha[i].sIconID);
	CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Add(arrCha[i].lChaid, arrCha[i].szChaname, arrCha[i].szMotto, arrCha[i].sIconID, arrCha[i].szGroup);
	// End

	pMember->SetOnline(arrCha[i].cStatus != 0);
  }
  g_stUIChat._UpdateSelfInfo();
}

// Add by lark.li 200805 begin
void NetFrndDelGroup(const char* delgroup)
{
  g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->DelGroupName(delgroup);
}

void NetFrndAddGroup(const char* addgroup)
{
  g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->AddGroupName(addgroup);
}

void NetFrndMoveGroup(unsigned long cha_id, const char* oldgroup, const char* newgroup)
{
  g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->MoveGroup(cha_id, oldgroup, newgroup);
}

void NetFrndChangeGroup(const char* oldgroup, const char* newgroup)
{
  g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->ChangeGroupName(oldgroup, newgroup);
}
// End

// Add by lark.li 20080808 begin
void NetFrndRefreshInfo(unsigned long cha_id, stPersonInfo* pInfo, const char* motto, unsigned short icon, unsigned short degree, const char* job, const char* guildname)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_243),cha_id,motto,icon,degree,job);
  if(g_stUIChat._dwSelfID == cha_id) // 是自己
  {
	g_stUIChat.ResetSelfInfo(pInfo);
  } else
  {
	CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(cha_id);
	if(pMember)
	{
	  pMember->ModifyAttr(motto, job, degree, icon, guildname);
	  g_ChaQeryInfo.SetSearchFrmData(pInfo, pMember); // 是别人
	}
  }
}
// End

//void NetFrndRefreshInfo(unsigned long cha_id,const char * motto,unsigned short icon,unsigned short degree,const char * job,const char *guildname)
//{
//	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_243),cha_id,motto,icon,degree,job);
//	CMember *pMember=g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(cha_id);
//	if (pMember)
//	{
//		pMember->ModifyAttr(motto, job, degree, icon, guildname);
//
//		// todo
//
//		/*if (g_stUIChat._frmDetails->GetIsShow() && g_stUIChat._frmDetails->nTag==(int)pMember->GetID())
//		{
//			g_stUIChat._UpdateFrndInfo(pMember);
//		}*/
//	}
//}

void NetChangePersonInfo(const char* motto, unsigned short icon, bool refuse_sess)
{
  g_stUIChat._strSelfMottoName = motto;
  g_stUIChat._dwSelfIcon	   = icon;
  g_stUIChat._bForbid		   = refuse_sess;
  CGameScene::GetMainCha()->setSecondName(motto);
  CGameScene::GetMainCha()->RefreshUI();
  g_stUIChat._UpdateSelfInfo();
}

// Add by lark.li 20080808 begin
void NetQueryPersonInfo(stQueryResoultPersonInfo* pInfo, int num)
{
  // 清空数据
  g_ChaQeryInfo.ClearQueryRFrmData();

  for(int i = 0; i < num; i++)
  {
	g_ChaQeryInfo.SetQueryRFrmData(pInfo, num);
  }
  g_ChaQeryInfo.SetShowQRChaInfo(true);
}
// End

void NetSessCreate(const char* chaname) //创建会话失败
{
  CTalkSessionForm* pSession;
  for(int i = 0; true; i++)
  {
	pSession = CTalkSessionFormMgr::GetSessionFormByName(chaname, i);
	if(!pSession) return;
	if(!pSession->IsActiveSession())
	{
	  pSession->ClearBuffer();
	}
  }
}

void NetSessCreate(unsigned long newsessid, stNetSessCreate cha[], short chanum)
{
  stNetSessCreate** pArrName = new stNetSessCreate*[chanum - 1];
  if(cha[0].lChaID == g_stUIChat._dwSelfID)
  {
	for(int i = 0; i < chanum - 1; i++)
	{
	  pArrName[i] = &cha[i + 1];
	}
	CTalkSessionFormMgr::CreateSessionForm(newsessid, pArrName, chanum - 1);
  } else
  {
	int i = 0;
	int j = 0;
	for(; j < chanum; j++)
	{
	  if(cha[j].lChaID == g_stUIChat._dwSelfID) continue;
	  pArrName[i] = &cha[j];
	  i++;
	}
	CTalkSessionFormMgr::CreateHiddenSessionForm(newsessid, pArrName, chanum - 1);
  }
  SAFE_DELETE_ARRAY(pArrName);

  //stNetSessCreate **pArrName=new stNetSessCreate *[chanum-1];
  //int i=0;
  //int j=0;
  //for (;i<chanum;i++)
  //{
  //	if (cha[i].lChaID==g_stUIChat._dwSelfID) continue;
  //	pArrName[j]=&cha[i];
  //	j++;
  //}
  //CTalkSessionFormMgr::CreateSessionForm(newsessid,pArrName,chanum-1);
  //SAFE_DELETE_ARRAY(pArrName);
}

void NetSessAdd(unsigned long sessid, stNetSessCreate* cha)
{
  CTalkSessionFormMgr::AddToSession(sessid, cha);
}

extern void NetSessLeave(unsigned long sessid, unsigned long chaid)
{
  CTalkSessionForm* pSession = CTalkSessionFormMgr::GetSessionFormByID(sessid);
  if(g_stUIChat._dwSelfID != chaid)
  {
	if(!pSession)
	{
	  //char szBuf[2048] = { 0 };
	  //sprintf( szBuf, "NetSessLeave(sessid:%d, chaid:%d, selfid:%d) error, pSession==NULL SessionCount=%d\n", sessid, chaid, g_stUIChat._dwSelfID, CTalkSessionFormMgr::GetSessionCount() );
	  //MessageBox(g_pGameApp->GetHWND(), "error", szBuf, MB_OK);
	  //CTalkSessionFormMgr::PrintTraceInfo();
	  return;
	}
	if(pSession->GetTotalMembers() == 1 && pSession->GetStyle() == enumTalkSessionHidden)
	{
	  CTalkSessionFormMgr::CloseSessionForm(sessid);
	} else
	{
	  CTalkSessionFormMgr::LeaveSession(sessid, chaid);
	}
  } else
  {
  }
}

extern void NetSessSay(unsigned long sessid, unsigned long chaid, const char* word)
{
  CTalkSessionForm* pSession = CTalkSessionFormMgr::GetSessionFormByID(sessid);
  //CMember *pMember=g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(chaid);
  //if (pMember)
  //{
  //	if (pSession && pSession->GetTotalMembers()==1 && pSession->GetStyle()!=enumTalkSessionNormal)
  //	pMember->SetIsFlash(true);
  //}
  //pMember=g_stUIChat.GetTeamMgr()->Find(enumTeamGroup)->Find(chaid);
  //if (pMember)
  //{
  //	if (pSession && pSession->GetTotalMembers()==1 && pSession->GetStyle()!=enumTalkSessionNormal)
  //		pMember->SetIsFlash(true);
  //}
  //pMember=g_stUIChat.GetTeamMgr()->Find(enumTeamRoad)->Find(chaid);
  //if (pMember)
  //{
  //	if (pSession && pSession->GetTotalMembers()==1 && pSession->GetStyle()!=enumTalkSessionNormal)
  //		pMember->SetIsFlash(true);
  //}
  if(pSession && pSession->GetStyle() != enumTalkSessionNormal)
  {
	pSession->SetIsFlash(true);
  }

  string str = word;
  CTextFilter::Filter(CTextFilter::DIALOG_TABLE, str);
  CTalkSessionFormMgr::SessionReceiveMsg(sessid, chaid, str.c_str());
}

//
//  师傅相关
//
void NetMasterOnline(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_236),cha_id);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Find(cha_id);
  if(pMember)
  {
	pMember->SetOnline(true);
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_884), pMember->GetName());
  }
}

void NetMasterOffline(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_238),cha_id);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Find(cha_id);
  if(pMember)
  {
	pMember->SetOnline(false);
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_885), pMember->GetName());
  }
}

void NetMasterDel(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_240),cha_id);
  g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Del(cha_id);
}

void NetMasterAdd(unsigned long cha_id, const char* cha_name, const char* motto, unsigned short icon_id, const char* grp)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_241),cha_name,cha_id);
  // g_stUIChat.GetTeamMgr()->Find( enumTeamMaster )->Add(cha_id,cha_name,motto,icon_id);
  g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Add(cha_id, cha_name, motto, icon_id, grp, true); // modify by ning.yan 解决拜师（收徒）时客户端没有及时显示在线信息  2008-11-14
}

void NetMasterStart(stNetFrndStart& self, stNetFrndStart arrCha[], unsigned short arrnum)
{
  g_stUIChat._dwSelfIcon	   = self.sIconID;
  g_stUIChat._strSelfMottoName = self.szMotto;
  g_stUIChat._dwSelfID		   = self.lChaid;
  for(int i = 0; i < arrnum; i++)
  {
	//		LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_242),i,arrCha[i].szChaname,arrCha[i].lChaid);
	CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Add(arrCha[i].lChaid, arrCha[i].szChaname, arrCha[i].szMotto, arrCha[i].sIconID);
	pMember->SetOnline(arrCha[i].cStatus != 0);
  }
  g_stUIChat._UpdateSelfInfo();
}

void NetMasterCancel(unsigned long inviter_chaid, char reason)
{
  LG("test_frnd", RES_STRING(CL_LANGUAGE_MATCH_231), inviter_chaid, reason);
  switch(reason)
  {
  case MSG_FRND_CANCLE_BUSY:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_232));
	break;
  case MSG_FRND_CANCLE_TIMEOUT:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_226));
	break;
  case MSG_FRND_CANCLE_OFFLINE:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_227));
	break;
  case MSG_FRND_CANCLE_INVITER_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_233));
	break;
  case MSG_FRND_CANCLE_SELF_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_234));
	break;
  case MSG_FRND_CANCLE_CANCEL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_235));
	break;
  }
  g_stFrndInviteFormMgr.RemoveInviteForm(inviter_chaid);
}

void NetMasterRefreshInfo(unsigned long cha_id, const char* motto, unsigned short icon, unsigned short degree, const char* job, const char* guildname)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_243),cha_id,motto,icon,degree,job);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Find(cha_id);
  if(pMember)
  {
	pMember->ModifyAttr(motto, job, degree, icon, guildname);
	// TODO

	/*	if (g_stUIChat._frmDetails->GetIsShow() && g_stUIChat._frmDetails->nTag==(int)pMember->GetID())
		{
			g_stUIChat._UpdateFrndInfo(pMember);
		}*/
  }
}

//
//  学徒相关
//
void NetPrenticeOnline(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_236),cha_id);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Find(cha_id);
  if(pMember)
  {
	pMember->SetOnline(true);
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_886), pMember->GetName());
  }
}

void NetPrenticeOffline(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_238),cha_id);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Find(cha_id);
  if(pMember)
  {
	pMember->SetOnline(false);
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_887), pMember->GetName());
  }
}

void NetPrenticeDel(unsigned long cha_id)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_240),cha_id);
  g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Del(cha_id);
}

void NetPrenticeAdd(unsigned long cha_id, const char* cha_name, const char* motto, unsigned short icon_id, const char* grp)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_241),cha_name,cha_id);
  //g_stUIChat.GetTeamMgr()->Find( enumTeamPrentice )->Add(cha_id,cha_name,motto,icon_id);
  g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Add(cha_id, cha_name, motto, icon_id, grp, true); // modify by ning.yan  2008-11-14 解决收徒（拜师）客户端及时显示
}

void NetPrenticeStart(stNetFrndStart& self, stNetFrndStart arrCha[], unsigned short arrnum)
{
  g_stUIChat._dwSelfIcon	   = self.sIconID;
  g_stUIChat._strSelfMottoName = self.szMotto;
  g_stUIChat._dwSelfID		   = self.lChaid;
  for(int i = 0; i < arrnum; i++)
  {
	//		LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_242),i,arrCha[i].szChaname,arrCha[i].lChaid);
	CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Add(arrCha[i].lChaid, arrCha[i].szChaname, arrCha[i].szMotto, arrCha[i].sIconID);
	pMember->SetOnline(arrCha[i].cStatus != 0);
  }
  g_stUIChat._UpdateSelfInfo();
}

void NetPrenticeCancel(unsigned long inviter_chaid, char reason)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_231),inviter_chaid,reason );
  switch(reason)
  {
  case MSG_FRND_CANCLE_BUSY:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_232));
	break;
  case MSG_FRND_CANCLE_TIMEOUT:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_226));
	break;
  case MSG_FRND_CANCLE_OFFLINE:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_227));
	break;
  case MSG_FRND_CANCLE_INVITER_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_233));
	break;
  case MSG_FRND_CANCLE_SELF_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_234));
	break;
  case MSG_FRND_CANCLE_CANCEL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_235));
	break;
  }
  g_stFrndInviteFormMgr.RemoveInviteForm(inviter_chaid);
}

void NetPrenticeRefreshInfo(unsigned long cha_id, const char* motto, unsigned short icon, unsigned short degree, const char* job, const char* guildname)
{
  //	LG("test_frnd",RES_STRING(CL_LANGUAGE_MATCH_243),cha_id,motto,icon,degree,job);
  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Find(cha_id);
  if(pMember)
  {
	pMember->ModifyAttr(motto, job, degree, icon, guildname);
	// TODO

	/*if (g_stUIChat._frmDetails->GetIsShow() && g_stUIChat._frmDetails->nTag==(int)pMember->GetID())
		{
			g_stUIChat._UpdateFrndInfo(pMember);
		}*/
  }
}
