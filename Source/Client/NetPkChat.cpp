#include "StdAfx.h"
#include "NetChat.h"

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
#include "CommFunc.h"
#include "ShipSet.h"
#include "uistartform.h"
#include "UIChat.h"

_DBC_USING

//----------------------------
// 协议C->S : 发送全体聊天消息
//----------------------------
void CS_GMSay(const char* pszContent)
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_GMSAY); //命令
  pk.WriteString(pszContent);

  g_NetIF->SendPacketMessage(pk);
}

void CS_GM1Say(const char* pszContent)
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_GM1SAY); //命令
  pk.WriteString(pszContent);

  g_NetIF->SendPacketMessage(pk);
}

//add by sunny.sun20080804
void CS_GM1Say1(const char* pszContent)
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_GM1SAY1); //命令
  pk.WriteString(pszContent);

  g_NetIF->SendPacketMessage(pk);
}
//End
void CS_Say2Trade(const char* pszContent)
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_SAY2TRADE); //命令
  pk.WriteString(pszContent);

  g_NetIF->SendPacketMessage(pk);
}
void CS_Say2All(const char* pszContent)
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_SAY2ALL); //命令
  pk.WriteString(pszContent);

  g_NetIF->SendPacketMessage(pk);
}
void CP_RefuseToMe(bool refusetome) //设置拒绝私聊标志
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_REFUSETOME);
  pk.WriteChar(refusetome ? 1 : 0);

  g_NetIF->SendPacketMessage(pk);
}
void CS_Say2You(const char* you, const char* pszContent)
{
  WPacket pk = g_NetIF->GetWPacket();
  pk.WriteCmd(CMD_CP_SAY2YOU); //命令
  pk.WriteString(you);
  pk.WriteString(pszContent);

  g_NetIF->SendPacketMessage(pk);
}
void CS_Say2Team(const char* pszContent)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_SAY2TEM);
  l_wpk.WriteString(pszContent);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Say2Guild(const char* pszContent)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_SAY2GUD);
  l_wpk.WriteString(pszContent);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Team_Invite(const char* chaname)
{
  if(!g_stUIStart.IsCanTeamAndInfo()) return;

  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_TEAM_INVITE);
  l_wpk.WriteString(chaname);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Team_Refuse(unsigned long chaid)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_TEAM_REFUSE);
  l_wpk.WriteLong(chaid);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Team_Confirm(unsigned long chaid)
{
  if(!g_stUIStart.IsCanTeamAndInfo()) return;

  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_TEAM_ACCEPT);
  l_wpk.WriteLong(chaid);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Team_Kick(DWORD dwKickedID)
{
  if(!g_stUIStart.IsCanTeamAndInfo()) return;

  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_TEAM_KICK);
  l_wpk.WriteLong(dwKickedID);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Team_Leave()
{
  if(!g_stUIStart.IsCanTeamAndInfo()) return;

  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_TEAM_LEAVE);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CS_Frnd_Invite(const char* chaname)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_INVITE);
  l_wpk.WriteString(chaname);
  g_NetIF->SendPacketMessage(l_wpk);
}
void CS_Frnd_Refuse(unsigned long chaid)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_REFUSE);
  l_wpk.WriteLong(chaid);
  g_NetIF->SendPacketMessage(l_wpk);
}
void CS_Frnd_Confirm(unsigned long chaid)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_ACCEPT);
  l_wpk.WriteLong(chaid);
  g_NetIF->SendPacketMessage(l_wpk);
}
void CS_Frnd_Delete(unsigned long chaid)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_DELETE);
  l_wpk.WriteLong(chaid);
  g_NetIF->SendPacketMessage(l_wpk);
}

// Add by lark.li 20080804 begin
void CP_Frnd_Del_Group(const char* groupname)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_DEL_GROUP);
  l_wpk.WriteString(groupname);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CP_Frnd_Add_Group(const char* groupname)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_ADD_GROUP);
  l_wpk.WriteString(groupname);
  g_NetIF->SendPacketMessage(l_wpk);
}

void CP_Frnd_Move_Group(unsigned long chaid, const char* oldgroup, const char* newgroup)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_MOVE_GROUP);
  l_wpk.WriteLong(chaid);
  l_wpk.WriteString(oldgroup);
  l_wpk.WriteString(newgroup);
  g_NetIF->SendPacketMessage(l_wpk);
}
// End

void CP_Frnd_Change_Group(const char* oldgroup, const char* newgroup)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_CHANGE_GROUP);
  l_wpk.WriteString(oldgroup);
  l_wpk.WriteString(newgroup);
  g_NetIF->SendPacketMessage(l_wpk);
}
void CP_Frnd_Refresh_Info(unsigned long chaid)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_FRND_REFRESH_INFO);
  l_wpk.WriteLong(chaid);
  g_NetIF->SendPacketMessage(l_wpk);
}

// Add by lark.li 20080808 begin
void CP_Query_PersonInfo(stQueryPersonInfo* pInfo)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_QUERY_PERSONINFO);

  l_wpk.WriteString(pInfo->sChaName);		 // 名字
  l_wpk.WriteChar(pInfo->bHavePic);			 // 是否显示头像
  l_wpk.WriteString(pInfo->cSex);			 // 性别	  1是男 0是女的
  l_wpk.WriteLong(pInfo->nMinAge[0]);		 // 年龄查询的m_nMinAge[1]最大和m_nMinAge[0]最小值
  l_wpk.WriteLong(pInfo->nMinAge[1]);		 //
  l_wpk.WriteString(pInfo->szAnimalZodiac);	 // 生肖
  l_wpk.WriteLong(pInfo->iBirthday[0]);		 // 查询出生年的m_nBirth[1]最大和m_nBirth[0]最小值
  l_wpk.WriteLong(pInfo->iBirthday[1]);		 //
  l_wpk.WriteString(pInfo->szState);		 // 省份
  l_wpk.WriteString(pInfo->szCity);			 // 城市
  l_wpk.WriteString(pInfo->szConstellation); // 星座
  l_wpk.WriteString(pInfo->szCareer);		 // 工作
  l_wpk.WriteLong(pInfo->nPageItemNum);		 // 每一页显示的个数
  l_wpk.WriteLong(pInfo->nCurPage);			 // 当前页数

  g_NetIF->SendPacketMessage(l_wpk);
}
// End

//void  CP_Change_PersonInfo(const stQueryPersonInfo *pinfo,unsigned short icon,bool refuse_sess)
//{
//	// Modify by lark.li 20080807 begin
//	//WPacket l_wpk	=g_NetIF->GetWPacket();
//	//l_wpk.WriteCmd(CMD_CP_CHANGE_PERSONINFO);
//	//l_wpk.WriteString(motto);
//	//l_wpk.WriteShort(icon);
//	//l_wpk.WriteChar(refuse_sess?1:0);
//
//	//g_NetIF->SendPacketMessage(l_wpk);
//
//	/*stPersonInfo info;
//	strncpy(info.szMotto, pinfo, sizeof(info.szMotto));
//	info.bShowMotto = true;
//	strncpy(info.szSex, "性别", sizeof(info.szMotto));
//	info.sAge = 30;
//	strncpy(info.szName, "名字", sizeof(info.szMotto));
//	strncpy(info.szAnimalZodiac, "属相", sizeof(info.szMotto));
//	strncpy(info.szBloodType, "血型", sizeof(info.szMotto));
//	info.iBirthday = 8<<4 + 8;
//	strncpy(info.szState, "州（省）", sizeof(info.szMotto));
//	strncpy(info.szCity, "城市（区）", sizeof(info.szMotto));
//	strncpy(info.szConstellation, "星座", sizeof(info.szMotto));
//	strncpy(info.szCareer, "职业", sizeof(info.szMotto));
//	info.iSize = 0;*/
//
//	//FILE* file = fopen("c:\\lark.jpg","rb");
//	//if(file)
//	//{
//	//	size_t len = fread(info.pAvatar, 1, 8*1024, file);
//	//
//	//	if(feof( file ))
//	//	{
//	//		info.iSize = len;
//	//	}
//
//	//	fclose(file);
//	//}
//
//	/*info.bPprevent = false;
//	info.iSupport = 100;
//	info.iOppose = 200;*/
//
//	CP_Change_PersonInfo(pinfo);
//
//	// TODO
//	stQueryPersonInfo query;
//	query.nPageItemNum = 1;
//	query.nCurPage = 1;
//	strncpy(query.sChaName, "名字", sizeof(query.sChaName));		// 名字
//
//	CP_Query_PersonInfo(&query);
//	// End
//}

// Add by lark.li 20080807 begin
void CP_Change_PersonInfo(stPersonInfo* pInfo, const char* pOldMotto /*座右铭*/)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_CHANGE_PERSONINFO);

  l_wpk.WriteString(pInfo->szMotto);				 // 签名
  l_wpk.WriteChar(pInfo->bShowMotto);				 // 显示签名开关
  l_wpk.WriteString(pInfo->szSex);					 // 性别
  l_wpk.WriteLong(pInfo->sAge);						 // 年龄
  l_wpk.WriteString(pInfo->szName);					 // 名字
  l_wpk.WriteString(pInfo->szAnimalZodiac);			 // 属相
  l_wpk.WriteString(pInfo->szBloodType);			 // 血型
  l_wpk.WriteLong(pInfo->iBirthday);				 // 生日
  l_wpk.WriteString(pInfo->szState);				 // 州（省）
  l_wpk.WriteString(pInfo->szCity);					 // 城市（区）
  l_wpk.WriteString(pInfo->szConstellation);		 // 星座
  l_wpk.WriteString(pInfo->szCareer);				 // 职业
  l_wpk.WriteLong(pInfo->iSize);					 // 头像大小
  l_wpk.WriteSequence(pInfo->pAvatar, pInfo->iSize); // 头像
  l_wpk.WriteChar(pInfo->bPprevent);				 // 是否阻止消息
  l_wpk.WriteLong(pInfo->iSupport);					 // 鲜花数
  l_wpk.WriteLong(pInfo->iOppose);					 // 臭鸡蛋数

  l_wpk.WriteString(pOldMotto); // 座右铭

  g_NetIF->SendPacketMessage(l_wpk);
}
// End

void CS_Sess_Create(const char* chaname[], unsigned char chanum)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_SESS_CREATE);
  l_wpk.WriteChar(chanum);
  for(char i = 0; i < chanum; i++)
  {
	l_wpk.WriteString(chaname[i]);
  }

  g_NetIF->SendPacketMessage(l_wpk);
}
void CS_Sess_Add(unsigned long sessid, const char* chaname)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_SESS_ADD);
  l_wpk.WriteLong(sessid);
  l_wpk.WriteString(chaname);

  g_NetIF->SendPacketMessage(l_wpk);
}
void CS_Sess_Leave(unsigned long sessid)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_SESS_LEAVE);
  l_wpk.WriteLong(sessid);

  g_NetIF->SendPacketMessage(l_wpk);
}
void CS_Sess_Say(unsigned long sessid, const char* word)
{
  WPacket l_wpk = g_NetIF->GetWPacket();
  l_wpk.WriteCmd(CMD_CP_SESS_SAY);
  l_wpk.WriteLong(sessid);
  l_wpk.WriteString(word);

  g_NetIF->SendPacketMessage(l_wpk);
}
//--------------------
// 协议S->C : 私聊
//--------------------
BOOL PC_Say2You(LPRPACKET pk)
{
  stNetSay2You l_say;
  l_say.m_src	  = pk.ReadString();
  l_say.m_dst	  = pk.ReadString();
  l_say.m_content = pk.ReadString();
  NetSay2You(l_say);
  return TRUE;
}
BOOL PC_Say2Team(LPRPACKET pk)
{
  unsigned long l_chaid = pk.ReadLong();
  const char*	l_word	= pk.ReadString();
  NetSay2Team(l_chaid, l_word);
  return TRUE;
}

BOOL PC_Say2Gud(LPRPACKET pk)
{
  const char* l_src	 = pk.ReadString();
  const char* l_word = pk.ReadString();
  NetSay2Gud(l_src, l_word);
  return TRUE;
}

BOOL PC_Say2All(LPRPACKET pk)
{
  stNetSay2All l_say;
  l_say.m_src	  = pk.ReadString();
  l_say.m_content = pk.ReadString();
  NetSay2All(l_say);
  return TRUE;
}
BOOL PC_GM1SAY(LPRPACKET pk)
{
  stNetSay2All l_say;
  l_say.m_src	  = pk.ReadString();
  l_say.m_content = pk.ReadString();
  NetGM1Say(l_say);
  return TRUE;
}
//Add by sunny.sun20080804
BOOL PC_GM1SAY1(LPRPACKET pk)
{
  stNetScrollSay l_say;
  l_say.m_content = pk.ReadString();
  l_say.setnum	  = pk.ReadLong();
  NetGM1Say1(l_say);
  return TRUE;
}
//End
BOOL PC_SAY2TRADE(LPRPACKET pk)
{
  stNetSay2All l_say;
  l_say.m_src	  = pk.ReadString();
  l_say.m_content = pk.ReadString();
  NetSay2Trade(l_say);
  return TRUE;
}
BOOL PC_SESS_CREATE(LPRPACKET pk)
{
  uLong l_newsessid = pk.ReadLong();
  if(!l_newsessid)
  {
	NetSessCreate(pk.ReadString());
  } else
  {
	uShort l_chanum = pk.ReverseReadShort();
	if(!l_chanum && l_chanum > 100) return FALSE;

	stNetSessCreate l_nsc[100];
	for(uShort i = 0; i < l_chanum; i++)
	{
	  l_nsc[i].lChaID	 = pk.ReadLong();
	  l_nsc[i].szChaName = pk.ReadString();
	  l_nsc[i].szMotto	 = pk.ReadString();
	  l_nsc[i].sIconID	 = pk.ReadShort();
	}
	NetSessCreate(l_newsessid, l_nsc, l_chanum);
  }
  return TRUE;
}
BOOL PC_SESS_ADD(LPRPACKET pk)
{
  stNetSessCreate l_nsc;
  uLong			  l_sessid = pk.ReadLong();
  l_nsc.lChaID			   = pk.ReadLong();
  l_nsc.szChaName		   = pk.ReadString();
  l_nsc.szMotto			   = pk.ReadString();
  l_nsc.sIconID			   = pk.ReadShort();
  NetSessAdd(l_sessid, &l_nsc);
  return TRUE;
}
BOOL PC_SESS_LEAVE(LPRPACKET pk)
{
  uLong l_sessid = pk.ReadLong();
  uLong l_chaid	 = pk.ReadLong();
  NetSessLeave(l_sessid, l_chaid);
  return TRUE;
}
BOOL PC_SESS_SAY(LPRPACKET pk)
{
  uLong	 l_sessid = pk.ReadLong();
  uLong	 l_chaid  = pk.ReadLong();
  cChar* l_word	  = pk.ReadString();
  NetSessSay(l_sessid, l_chaid, l_word);
  return TRUE;
}
BOOL PC_TEAM_INVITE(LPRPACKET pk)
{
  const char* l_inviter_name  = pk.ReadString();
  uLong		  l_inviter_chaid = pk.ReadLong();
  uShort	  l_inviter_icon  = pk.ReadShort();
  NetTeamInvite(l_inviter_name, l_inviter_chaid, l_inviter_icon);
  return TRUE;
}
BOOL PC_TEAM_CANCEL(LPRPACKET pk)
{
  unsigned char reason = pk.ReadChar();
  NetTeamCancel(pk.ReadLong(), reason);
  return TRUE;
}
//组队成员变化信息刷新
BOOL PC_TEAM_REFRESH(LPRPACKET pk)
{
  stNetPCTeam l_pcteam;
  l_pcteam.kind	 = pk.ReadChar();
  l_pcteam.count = pk.ReadChar();

  // LG("Team", "Kind:[%u], Count[%u]\n", l_pcteam.kind, l_pcteam.count );

  // 最大10个
  l_pcteam.count = std::min<decltype(l_pcteam.count)>(l_pcteam.count, 10);
  for(unsigned char i = 0; i < l_pcteam.count; i++)
  {
	l_pcteam.cha_dbid[i] = pk.ReadLong();
	/*strcpy( l_pcteam.cha_name[i], pk.ReadString() );
		strcpy( l_pcteam.motto[i], pk.ReadString() );*/
	strncpy_s(l_pcteam.cha_name[i], sizeof(l_pcteam.cha_name), pk.ReadString(), _TRUNCATE);
	strncpy_s(l_pcteam.motto[i], sizeof(l_pcteam.motto[i]), pk.ReadString(), _TRUNCATE);
	l_pcteam.cha_icon[i] = pk.ReadShort();

	// LG("Team", "    DB_ID:[%u], Name[%s]\n", l_pcteam.cha_dbid[i], l_pcteam.cha_name[i] );
  }

  NetPCTeam(l_pcteam);
  return TRUE;
}
BOOL PC_FRND_INVITE(LPRPACKET pk)
{
  const char* l_inviter_name  = pk.ReadString();
  uLong		  l_inviter_chaid = pk.ReadLong();
  uShort	  l_inviter_icon  = pk.ReadShort();
  NetFrndInvite(l_inviter_name, l_inviter_chaid, l_inviter_icon);
  return TRUE;
}
BOOL PC_FRND_CANCEL(LPRPACKET pk)
{
  unsigned char reason = pk.ReadChar();
  NetFrndCancel(pk.ReadLong(), reason);
  return TRUE;
}
BOOL PC_FRND_REFRESH(LPRPACKET pk)
{
  unsigned char l_type = pk.ReadChar();
  switch(l_type)
  {
  case MSG_FRND_REFRESH_ONLINE:
  {
	NetFrndOnline(pk.ReadLong());
  }
  break;
  case MSG_FRND_REFRESH_OFFLINE:
  {
	NetFrndOffline(pk.ReadLong());
  }
  break;
  case MSG_FRND_REFRESH_DEL:
  {
	NetFrndDel(pk.ReadLong());
  }
  break;
  case MSG_FRND_REFRESH_ADD:
  {
	cChar* l_grp	 = pk.ReadString();
	uLong  l_chaid	 = pk.ReadLong();
	cChar* l_chaname = pk.ReadString();
	cChar* l_motto	 = pk.ReadString();
	uShort l_icon	 = pk.ReadShort();
	NetFrndAdd(l_chaid, l_chaname, l_motto, l_icon, l_grp);
  }
  break;
  case MSG_FRND_REFRESH_START:
  {
	stNetFrndStart l_self;
	l_self.lChaid	 = pk.ReadLong();
	l_self.szChaname = pk.ReadString();
	l_self.szMotto	 = pk.ReadString();
	l_self.sIconID	 = pk.ReadShort();

	// Modify by lark.li 20080806 begin
	//stNetFrndStart l_nfs[100];
	stNetFrndStart l_nfs[200];
	// End

	// Add by lark.li 20080804 begin
	uShort l_grpnamenum = pk.ReadShort();
	if(l_grpnamenum > 10)
	  l_grpnamenum = 10;

	string groupNames[10];

	for(uShort l_grpi = 0; l_grpi < l_grpnamenum; l_grpi++)
	{
	  groupNames[l_grpi] = pk.ReadString();
	}
	// End

	uShort l_nfnum = 0, l_grpnum = pk.ReadShort();
	for(uShort l_grpi = 0; l_grpi < l_grpnum; l_grpi++)
	{
	  cChar* l_grp	   = pk.ReadString();
	  uShort l_grpmnum = pk.ReadShort();
	  for(uShort l_grpmi = 0; l_grpmi < l_grpmnum; l_grpmi++)
	  {
		l_nfs[l_nfnum].szGroup	 = l_grp;
		l_nfs[l_nfnum].lChaid	 = pk.ReadLong();
		l_nfs[l_nfnum].szChaname = pk.ReadString();
		l_nfs[l_nfnum].szMotto	 = pk.ReadString();
		l_nfs[l_nfnum].sIconID	 = pk.ReadShort();
		l_nfs[l_nfnum].cStatus	 = pk.ReadChar();
		l_nfnum++;

		// Add by lark.li 20080806 begin
		if(l_nfnum >= 200)
		  break;
		// End
	  }

	  // Add by lark.li 20080806 begin
	  if(l_nfnum >= 200)
		break;
	  // End
	}

	// Modify by lark.li 20080804 begin
	//NetFrndStart(l_self,l_nfs,l_nfnum);
	NetFrndStart(l_self, l_nfs, l_nfnum, groupNames, l_grpnamenum);
	// End
  }
  break;
  }
  return TRUE;
}

// Add by lark.li 20080805 begin
BOOL PC_FRND_DEL_GROUP(LPRPACKET pk)
{
  const char* l_grp = pk.ReadString();
  NetFrndDelGroup(l_grp);
  return TRUE;
}

BOOL PC_FRND_ADD_GROUP(LPRPACKET pk)
{
  const char* l_grp = pk.ReadString();
  NetFrndAddGroup(l_grp);
  return TRUE;
}

BOOL PC_FRND_MOVE_GROUP(LPRPACKET pk)
{
  unsigned long l_changed_chaid = pk.ReadLong();
  const char*	l_grp1			= pk.ReadString();
  const char*	l_grp2			= pk.ReadString();
  NetFrndMoveGroup(l_changed_chaid, l_grp1, l_grp2);
  return TRUE;
}
// End

BOOL PC_FRND_CHANGE_GROUP(LPRPACKET pk)
{
  // Modify by lark.li 20080805 begin
  //unsigned long l_changed_chaid	=pk.ReadLong();
  //const char	* l_grp				=pk.ReadString();
  //NetFrndChangeGroup(l_changed_chaid,l_grp);
  const char* l_grp1 = pk.ReadString();
  const char* l_grp2 = pk.ReadString();
  NetFrndChangeGroup(l_grp1, l_grp2);
  // End

  return TRUE;
}
BOOL PC_FRND_REFRESH_INFO(LPRPACKET pk)
{
  stPersonInfo info;
  const char*  act_name = pk.ReadString(); //Add by sunny.sun 好友的帐户名

  //add guojiangang 20090211
  if(strcmp(const_cast<char*>(act_name), g_stUIChat._PictureCChat.getUserName()))
  {
	g_stUIChat._PictureCChat.setVisitorName(const_cast<char*>(act_name));
  }
  //end

  unsigned long	 l_chaid = pk.ReadLong();
  const char*	 l_motto = pk.ReadString();
  unsigned short l_icon	 = pk.ReadShort();
  unsigned short l_degr	 = pk.ReadShort();
  if(l_degr == 0)
	l_degr = 1;
  const char* l_job	  = pk.ReadString();
  const char* l_guild = pk.ReadString();
  //bool _bFind = pk.ReadChar();
  bool _bFind = (pk.ReadChar() == 1 ? true : false);
  if(_bFind)
  {
	// Add by lark.li 20080808 begin
	uShort l_len;
	//strncpy(info.szMotto, pk.ReadString(&l_len), sizeof(info.szMotto));
	////info.bShowMotto = pk.ReadChar();
	//info.bShowMotto = (bool)pk.ReadChar();
	//strncpy(info.szSex, pk.ReadString(&l_len), sizeof(info.szSex));
	//info.sAge = (short)pk.ReadLong();
	//strncpy(info.szName, pk.ReadString(&l_len), sizeof(info.szName));
	//strncpy(info.szAnimalZodiac, pk.ReadString(&l_len), sizeof(info.szAnimalZodiac));
	//strncpy(info.szBloodType, pk.ReadString(&l_len), sizeof(info.szBloodType));
	//info.iBirthday = pk.ReadLong();
	//strncpy(info.szState, pk.ReadString(&l_len), sizeof(info.szState));
	//strncpy(info.szCity, pk.ReadString(&l_len), sizeof(info.szCity));
	//strncpy(info.szConstellation, pk.ReadString(&l_len), sizeof(info.szConstellation));
	//strncpy(info.szCareer, pk.ReadString(&l_len), sizeof(info.szCareer));

	strncpy_s(info.szMotto, sizeof(info.szMotto), pk.ReadString(&l_len), _TRUNCATE);
	//info.bShowMotto = pk.ReadChar();
	info.bShowMotto = (pk.ReadChar() == 1 ? true : false);
	strncpy_s(info.szSex, sizeof(info.szSex), pk.ReadString(&l_len), _TRUNCATE);
	info.sAge = (short)pk.ReadLong();
	strncpy_s(info.szName, sizeof(info.szName), pk.ReadString(&l_len), _TRUNCATE);
	strncpy_s(info.szAnimalZodiac, sizeof(info.szAnimalZodiac), pk.ReadString(&l_len), _TRUNCATE);
	strncpy_s(info.szBloodType, sizeof(info.szBloodType), pk.ReadString(&l_len), _TRUNCATE);
	info.iBirthday = pk.ReadLong();
	strncpy_s(info.szState, sizeof(info.szState), pk.ReadString(&l_len), _TRUNCATE);
	strncpy_s(info.szCity, sizeof(info.szCity), pk.ReadString(&l_len), _TRUNCATE);
	strncpy_s(info.szConstellation, sizeof(info.szConstellation), pk.ReadString(&l_len), _TRUNCATE);
	strncpy_s(info.szCareer, sizeof(info.szCareer), pk.ReadString(&l_len), _TRUNCATE);
	info.iSize = pk.ReadLong();

	if(info.iSize > 0 && info.iSize < 8 * 1024)
	{
	  memcpy(info.pAvatar, pk.ReadSequence(l_len), info.iSize);
	}

	//info.bPprevent = pk.ReadChar();
	info.bPprevent = (pk.ReadChar() == 1 ? true : false);
	info.iSupport  = pk.ReadLong();
	info.iOppose   = pk.ReadLong();
	// End

  } else
  {
  }

  // Modify by lark.li 20080808 begin
  //NetFrndRefreshInfo(l_chaid,l_motto,l_icon,l_degr,l_job,l_guild);
  NetFrndRefreshInfo(l_chaid, &info, l_motto, l_icon, l_degr, l_job, l_guild);
  // End

  return TRUE;
}
// 更改自己消息
BOOL PC_CHANGE_PERSONINFO(LPRPACKET pk)
{
  const char*	 l_motto	   = pk.ReadString();
  unsigned short l_icon		   = pk.ReadShort();
  bool			 l_refuse_sess = pk.ReadChar() ? true : false;
  NetChangePersonInfo(l_motto, l_icon, l_refuse_sess);
  return TRUE;
}

// Add by lark.li 20080808 begin
BOOL PC_QUERY_PERSONINFO(LPRPACKET pk)
{
  //l_wpk.WriteShort(num);
  //
  //for(int i=0;i<num;i++)
  //{
  //	l_wpk.WriteString(result[i].sChaName);
  //	l_wpk.WriteShort(result[i].nMinAge);
  //	l_wpk.WriteString(result[i].cSex);
  //	l_wpk.WriteString(result[i].szState);
  //	l_wpk.WriteString(result[i].nCity);
  //}
  int num		= pk.ReadShort();
  int totalPage = pk.ReadLong();
  int totalNum	= pk.ReadLong();

  num = min(num, 10);
  stQueryResoultPersonInfo info[10];

  for(int i = 0; i < num; i++)
  {
	/*strncpy(info[i].sChaName, pk.ReadString(), sizeof(info[i].sChaName));
		info[i].nMinAge = pk.ReadShort();
		strncpy(info[i].cSex, pk.ReadString(), sizeof(info[i].cSex));
		strncpy(info[i].szState, pk.ReadString(), sizeof(info[i].szState));
		strncpy(info[i].nCity, pk.ReadString(), sizeof(info[i].nCity));*/
	strncpy_s(info[i].sChaName, sizeof(info[i].sChaName), pk.ReadString(), _TRUNCATE);
	info[i].nMinAge = pk.ReadShort();
	strncpy_s(info[i].cSex, sizeof(info[i].cSex), pk.ReadString(), _TRUNCATE);
	strncpy_s(info[i].szState, sizeof(info[i].szState), pk.ReadString(), _TRUNCATE);
	strncpy_s(info[i].nCity, sizeof(info[i].nCity), pk.ReadString(), _TRUNCATE);
  }

  NetQueryPersonInfo(info, num);
  return TRUE;
}
// End