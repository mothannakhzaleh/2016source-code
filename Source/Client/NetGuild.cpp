#include "stdafx.h"
#include "netguild.h"
#include "UIGlobalVar.h"
#include "GuildMemberData.h"
#include "GuildMembersMgr.h"
#include "RecruitMemberData.h"
#include "RecruitMembersMgr.h"
#include "GuildListMgr.h"
#include "guildlistdata.h"
#include "GuildData.h"
#include "UIGuildApply.h"
#include "uiguildlist.h"
#include "UIGuildMgr.h"
#include "UIGraph.h"
#include "UIChat.h"
#include "UITreeView.h"
#include "ChatIconSet.h"
#include "CompCommand.h"
#include "GameApp.h"
#include "Character.h"
#include "StringLib.h"
#include "uiboatform.h"
#include "UIGuildChallengeForm.h"
#include "GuildInviteFormMgr.h"

void NetMC_GUILD_GETNAME(char guildtype)
{
  if(guildtype == 0)
  {
	CUIGuildApply::ShowForm(CGuildData::navy);
  } else
  {
	CUIGuildApply::ShowForm(CGuildData::pirate);
  }
}
void NetMC_LISTGUILD_BEGIN(uChar gldtype)
{
  CGuildListMgr::ResetAll();
  CGuildListMgr::SetType((gldtype == 0) ? CGuildData::navy : CGuildData::pirate);
}

void NetMC_LISTGUILD_END()
{
  CUIGuildList::ResetOrder();
  CGuildListMgr::SortGuildsByName();
  CUIGuildList::ShowGuildList();
}

void NetMC_LISTGUILD(uLong id, cChar* name, cChar* motto, cChar* leadername, uShort memtotal, LLong exp)
{
  CGuildListMgr::AddGuild(new CGuildListData(id, name, motto, leadername, memtotal, exp));
}

void NetMC_GUILD_TRYFORCFM(cChar* oldgldname)
{
  CUIGuildList::OnMsgReplaceApply(oldgldname);
}

void NetMC_LISTTRYPLAYER_BEGIN(uLong gldid, cChar* gldname, cChar* motto, char type, char stat, cChar* ldrname, uShort memnum, uShort maxmem, LLong money, LLong exp, uLong remain)
{
  CRecruitMembersMgr::ResetAll();
  CGuildData::sGuildData data;
  data.guild_id			  = gldid;
  data.guild_name		  = gldname;
  data.guild_motto_name	  = motto;
  data.guild_master_name  = ldrname;
  data.guild_member_count = memnum;
  data.guild_member_max	  = maxmem;
  data.guild_money		  = money;
  data.guild_experience	  = exp;
  data.guild_remain_time  = remain;
  data.guild_type		  = (type == 0) ? CGuildData::navy : CGuildData::pirate;
  data.guild_state		  = CGuildData::eState(stat);
  CGuildData::LoadData(data);
}

void NetMC_LISTTRYPLAYER_END()
{
  CUIGuildMgr::ShowForm();
}

void NetMC_LISTTRYPLAYER(uLong chaid, cChar* chaname, cChar* job, uShort degree)
{
  CRecruitMemberData* pMemberData = new CRecruitMemberData;
  pMemberData->SetID(chaid);
  pMemberData->SetName(chaname);
  pMemberData->SetJob(job);
  pMemberData->SetLevel(degree);
  CRecruitMembersMgr::AddRecruitMember(pMemberData);
}

void NetPC_GUILD_ONLINE(uLong chaid)
{
  CGuildMemberData* pMemberData = CGuildMembersMgr::FindGuildMemberByID(chaid);
  if(!pMemberData) return;
  pMemberData->SetOnline(true);
  CTextGraph* pItem = static_cast<CTextGraph*>(pMemberData->GetPointer());
  if(pItem)
  {
	CChatIconInfo* pIconInfo = GetChatIconInfo(pMemberData->GetIcon());
	if(pIconInfo)
	{
	  CGuiPic* pPic	   = pItem->GetImage();
	  string   strPath = "texture/ui/HEAD/";
	  pPic->LoadImage((strPath + pIconInfo->szSmall).c_str(), SMALL_ICON_SIZE, SMALL_ICON_SIZE, 0, pIconInfo->nSmallX, pIconInfo->nSmallY);
	  pItem->SetColor(0xfffc2f20);
	  pPic->SetFrame(0);
	  g_stUIChat.GetTeamView()->Refresh();
	}
  }
}

void NetPC_GUILD_OFFLINE(uLong chaid)
{
  CGuildMemberData* pMemberData = CGuildMembersMgr::FindGuildMemberByID(chaid);
  if(!pMemberData) return;
  pMemberData->SetOnline(false);
  CTextGraph* pItem = static_cast<CTextGraph*>(pMemberData->GetPointer());
  if(pItem)
  {
	CChatIconInfo* pIconInfo = GetChatIconInfo(pMemberData->GetIcon());
	if(pIconInfo)
	{
	  CGuiPic* pPic	   = pItem->GetImage();
	  string   strPath = "texture/ui/HEAD/";
	  pPic->LoadImage((strPath + pIconInfo->szSmallOff).c_str(), SMALL_ICON_SIZE, SMALL_ICON_SIZE, 0, pIconInfo->nSmallX, pIconInfo->nSmallY);
	  pItem->SetColor(0xff000000);
	  pPic->SetFrame(0);
	  g_stUIChat.GetTeamView()->Refresh();
	}
  }
}

void NetPC_GUILD_START_BEGIN(uLong guildid, cChar* guildname, uLong leaderid)
{
  CGuildMembersMgr::ResetAll();
  g_stUIChat.GetGuildNode()->Clear();
  CGuildData::SetGuildID(guildid);
  if(guildid)
  {
	CGuildData::SetGuildMasterID(leaderid);
	//CGuildData::SetGuildMasterName(guildname);
	CGuildData::SetGuildName(guildname);
  } else
  {
	CGuildData::SetGuildMasterID(NULL);
	//CGuildData::SetGuildMasterName("");
	CGuildData::SetGuildName("");
  }
}

void NetPC_GUILD_START_END()
{
  if(CGuildData::GetGuildID())
  {
  }
  g_stUIChat.GetTeamView()->Refresh();
}

void NetPC_GUILD_START(bool online, uLong chaid, cChar* chaname, cChar* motto, cChar* job, uShort degree, uShort icon, uShort permission)
{
  CGuildMemberData* pMemberData = new CGuildMemberData;
  pMemberData->SetOnline(online);
  pMemberData->SetID(chaid);
  pMemberData->SetName(chaname);
  pMemberData->SetJob(job);
  pMemberData->SetLevel(degree);
  pMemberData->SetMottoName(motto);
  pMemberData->SetIcon(icon);
  pMemberData->SetManager(permission & emGldPermMgr);
  CGuildMembersMgr::AddGuildMember(pMemberData);
  if(g_pGameApp->GetCurScene()->GetMainCha()->getHumanID() == chaid) return;
  CTextGraph* pItem = new CTextGraph(2);
  pMemberData->SetPointer(pItem);
  string str = chaname;
  if(strlen(motto) > 0)
  {
	str += "(" + string(motto) + ")";
  }
  pItem->SetHint(str.c_str());
  str = StringLimit(str, 14);
  pItem->SetString(str.c_str());
  pItem->SetPointer(pMemberData);
  CChatIconInfo* pIconInfo = GetChatIconInfo(icon);
  if(pIconInfo)
  {
	CGuiPic* pPic	 = pItem->GetImage();
	string	 strPath = "texture/ui/HEAD/";
	if(online)
	{
	  pPic->LoadImage((strPath + pIconInfo->szSmall).c_str(), SMALL_ICON_SIZE, SMALL_ICON_SIZE, 0, pIconInfo->nSmallX, pIconInfo->nSmallY);
	  pItem->SetColor(0xfffc2f20);
	} else
	{
	  pPic->LoadImage((strPath + pIconInfo->szSmallOff).c_str(), SMALL_ICON_SIZE, SMALL_ICON_SIZE, 0, pIconInfo->nSmallX, pIconInfo->nSmallY);
	  pItem->SetColor(0xff000000);
	}
	pPic->SetFrame(0);
  }
  g_stUIChat.GetGuildNode()->AddItem(pItem);
}

void NetPC_GUILD_ADD(bool online, uLong chaid, cChar* chaname, cChar* motto, cChar* job, uShort degree, uShort icon, uShort permission)
{
  if(CGuildMembersMgr::FindGuildMemberByID(chaid)) return;
  CGuildMemberData* pMemberData = new CGuildMemberData;
  pMemberData->SetOnline(online);
  pMemberData->SetID(chaid);
  pMemberData->SetName(chaname);
  pMemberData->SetJob(job);
  pMemberData->SetLevel(degree);
  pMemberData->SetMottoName(motto);
  pMemberData->SetIcon(icon);
  pMemberData->SetManager(permission & emGldPermMgr);
  CGuildMembersMgr::AddGuildMember(pMemberData);
  if(g_pGameApp->GetCurScene()->GetMainCha()->getHumanID() == chaid) return;
  CTextGraph* pItem = new CTextGraph(2);
  pMemberData->SetPointer(pItem);
  string str = chaname;
  if(strlen(motto) > 0)
  {
	str += "(" + string(motto) + ")";
  }
  pItem->SetHint(str.c_str());
  str = StringLimit(str, 14);
  pItem->SetString(str.c_str());
  pItem->SetPointer(pMemberData);
  CChatIconInfo* pIconInfo = GetChatIconInfo(icon);
  if(pIconInfo)
  {
	CGuiPic* pPic	 = pItem->GetImage();
	string	 strPath = "texture/ui/HEAD/";
	if(online)
	{
	  pPic->LoadImage((strPath + pIconInfo->szSmall).c_str(), SMALL_ICON_SIZE, SMALL_ICON_SIZE, 0, pIconInfo->nSmallX, pIconInfo->nSmallY);
	  pItem->SetColor(0xfffc2f20);
	} else
	{
	  pPic->LoadImage((strPath + pIconInfo->szSmallOff).c_str(), SMALL_ICON_SIZE, SMALL_ICON_SIZE, 0, pIconInfo->nSmallX, pIconInfo->nSmallY);
	  pItem->SetColor(0xff000000);
	}
	pPic->SetFrame(0);
  }
  g_stUIChat.GetGuildNode()->AddItem(pItem);
  g_stUIChat.GetTeamView()->Refresh();
  CGuildData::SetMemberCount(CGuildData::GetMemberCount() + 1);
  CUIGuildMgr::RefreshForm();
}

void NetPC_GUILD_DEL(uLong chaid)
{
  CGuildMemberData* pMemberData = CGuildMembersMgr::FindGuildMemberByID(chaid);
  g_stUIChat.GetGuildNode()->DelItem((CItemObj*)pMemberData->GetPointer());
  CGuildMembersMgr::DelGuildMemberByID(chaid);
  g_stUIChat.GetTeamView()->Refresh();
  CGuildData::SetMemberCount(CGuildData::GetMemberCount() - 1);
  CUIGuildMgr::RefreshForm();
}

void NetPC_GUILD_STOP()
{
  CGuildListMgr::ResetAll();
  CGuildMembersMgr::ResetAll();
  g_stUIChat.GetGuildNode()->Clear();
  CUIGuildMgr::RemoveForm();
  CGuildData::Reset();
}

void NetMC_GUILD_MOTTO(cChar* motto)
{
  //此回调函数已经无效(被取消)-Arcol 2005.10.9
  CGuildData::SetGuildMottoName(motto);
  CUIGuildMgr::RefreshAttribute();
}

void NetMC_GUILD_INFO(DWORD dwCharID, DWORD dwGuildID, const char szGuildName[], const char szGuildMotto[])
{
  //	const char* pszLogName = g_LogName.GetLogName( dwCharID );
  //	LG( pszLogName, "Guild Info:%u, Name:%s, Motto:%s\n", dwGuildID, szGuildName, szGuildMotto  );

  if(!CGameApp::GetCurScene())
  {
	LG("error", RES_STRING(CL_LANGUAGE_MATCH_244));
	return;
  }

  if(!CGameScene::GetMainCha())
  {
	LG("error", RES_STRING(CL_LANGUAGE_MATCH_245));
	return;
  }

  CCharacter* pCha = CGameScene::GetMainCha();
  if(pCha->getHumanID() == dwCharID)
  {
	CGuildData::SetGuildMottoName(szGuildMotto);
	CUIGuildMgr::RefreshAttribute();

	//		LG( pszLogName, "Guild - Main Cha:%u, %s\n", pCha->getAttachID(), pCha->getLogName() );

	CCharacter* pAll[defMaxBoat + 1] = {0};
	for(int i = 0; i < defMaxBoat; i++)
	  pAll[i] = g_stUIBoat.GetBoat(i)->GetCha();

	pAll[defMaxBoat] = g_stUIBoat.GetHuman();
	for(int i = 0; i < defMaxBoat + 1; i++)
	{
	  if(pAll[i])
	  {
		//				LG( pszLogName, "Guild:%u, %s\n", pAll[i]->getAttachID(), pAll[i]->getLogName() );
		pAll[i]->setGuildID(dwGuildID);
		pAll[i]->setGuildName(szGuildName);
		pAll[i]->setGuildMotto(szGuildMotto);
	  }
	}
  } else
  {
	pCha = CGameApp::GetCurScene()->SearchByHumanID(dwCharID);

	if(!pCha)
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_246), dwCharID);
	  return;
	}

	pCha->setGuildID(dwGuildID);
	pCha->setGuildName(szGuildName);
	pCha->setGuildMotto(szGuildMotto);
  }
}

void NetMC_GUILD_CHALLINFO(const NET_GUILD_CHALLINFO& Info)
{
  g_stGuildChallenge.SetContent(Info);
  g_stGuildChallenge.Show(true);
}

void NetGuildInvite(const char* inviter_name, unsigned long inviter_chaid, unsigned short icon)
{
  CCharacter* mCha = CGameScene::GetMainCha();
  if(mCha->getGuildID() <= 0)
  {
	g_stGuildInviteFormMgr.AddInviteForm(inviter_chaid, inviter_name);
  }
}

void NetGuildCancel(unsigned long inviter_chaid, char reason)
{
  switch(reason)
  {
  case MSG_GUILD_CANCLE_BUSY:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_1031));
	break;
  case MSG_GUILD_CANCLE_TIMEOUT:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_1032));
	break;
  case MSG_GUILD_CANCLE_OFFLINE:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_1033));
	break;
  case MSG_GUILD_CANCLE_SELF_ISFULL:
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_1034));
	break;
  case MSG_GUILD_CANCLE_CANCEL:
	//g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_1035));
	break;
  }
  g_stGuildInviteFormMgr.RemoveInviteForm(inviter_chaid);
}