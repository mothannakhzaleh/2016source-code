//------------------------------------------------------------------------
//	2005.4.27	Arcol	create this file
//------------------------------------------------------------------------

#include "stdafx.h"
#include "UIPage.h"
#include "netguild.h"
#include "UIFormMgr.h"
#include "UITextButton.h"
#include "GuildMemberData.h"
#include "GuildMembersMgr.h"
#include "RecruitMemberData.h"
#include "RecruitMembersMgr.h"
#include "UIBoxForm.h"
#include "UIListView.h"
#include "UILabel.h"
#include "UIEdit.h"
#include "GameApp.h"
#include "Character.h"
#include "uiguildmgr.h"
#include "commfunc.h"
#include "procirculate.h"
#include "packetcmd.h"
#include <conformity.h>

CForm*	  CUIGuildMgr::m_pGuildMgrForm		  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildName		  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildMottoName	  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildType		  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildMaster	  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildMemberCount = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildExperience  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildMoney		  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildState		  = NULL;
CLabelEx* CUIGuildMgr::m_plabGuildRemainTime  = NULL;
//CLabelEx*	CUIGuildMgr::m_plabGuildRank=NULL;
CListView*	 CUIGuildMgr::m_plstGuildMember	   = NULL;
CListView*	 CUIGuildMgr::m_plstRecruitMember  = NULL;
CPage*		 CUIGuildMgr::m_ppgeClass		   = NULL;
CTextButton* CUIGuildMgr::m_pbtnGuildMottoEdit = NULL;
CTextButton* CUIGuildMgr::m_pbtnGuildDismiss   = NULL;
CTextButton* CUIGuildMgr::m_pbtnMemberRecruit  = NULL;
CTextButton* CUIGuildMgr::m_pbtnMemberRefuse   = NULL;
CTextButton* CUIGuildMgr::m_pbtnMemberKick	   = NULL;

CForm*		 CUIGuildMgr::m_pGuildMottoNameEditForm = NULL;
CEdit*		 CUIGuildMgr::m_pedtGuildMottoName		= NULL;
CTextButton* CUIGuildMgr::m_pbtnGuildMottoFormOK	= NULL;
CTextButton* CUIGuildMgr::btnyqrh					= NULL;
CEdit*		 CUIGuildMgr::edtyqname					= NULL;

CUIGuildMgr::CUIGuildMgr(void)
{
}

CUIGuildMgr::~CUIGuildMgr(void)
{
}

bool CUIGuildMgr::Init()
{
  FORM_LOADING_CHECK(m_pGuildMgrForm, "manage.clu", "frmManage");
  m_pGuildMgrForm->evtBeforeShow = OnBeforeShow;

  FORM_CONTROL_LOADING_CHECK(m_plabGuildName, m_pGuildMgrForm, CLabelEx, "manage.clu", "labName");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildMottoName, m_pGuildMgrForm, CLabelEx, "manage.clu", "labMaxim");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildType, m_pGuildMgrForm, CLabelEx, "manage.clu", "labState");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildMaster, m_pGuildMgrForm, CLabelEx, "manage.clu", "labPeople");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildMemberCount, m_pGuildMgrForm, CLabelEx, "manage.clu", "labNum");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildExperience, m_pGuildMgrForm, CLabelEx, "manage.clu", "labExp");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildMoney, m_pGuildMgrForm, CLabelEx, "manage.clu", "labMen");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildState, m_pGuildMgrForm, CLabelEx, "manage.clu", "labReason");
  FORM_CONTROL_LOADING_CHECK(m_plabGuildRemainTime, m_pGuildMgrForm, CLabelEx, "manage.clu", "labRemain");
  FORM_CONTROL_LOADING_CHECK(m_pbtnGuildMottoEdit, m_pGuildMgrForm, CTextButton, "manage.clu", "btnMaxim");
  FORM_CONTROL_LOADING_CHECK(m_pbtnGuildDismiss, m_pGuildMgrForm, CTextButton, "manage.clu", "btnSan");
  FORM_CONTROL_LOADING_CHECK(m_pbtnMemberRecruit, m_pGuildMgrForm, CTextButton, "manage.clu", "btnYes");
  FORM_CONTROL_LOADING_CHECK(m_pbtnMemberRefuse, m_pGuildMgrForm, CTextButton, "manage.clu", "btnNo");
  FORM_CONTROL_LOADING_CHECK(m_pbtnMemberKick, m_pGuildMgrForm, CTextButton, "manage.clu", "btnkick");
  FORM_CONTROL_LOADING_CHECK(m_plstGuildMember, m_pGuildMgrForm, CListView, "manage.clu", "lstNum");
  FORM_CONTROL_LOADING_CHECK(m_plstRecruitMember, m_pGuildMgrForm, CListView, "manage.clu", "lstAsk");
  FORM_CONTROL_LOADING_CHECK(m_ppgeClass, m_pGuildMgrForm, CPage, "manage.clu", "pgePublic");

  m_pbtnGuildMottoEdit->evtMouseClick = _OnClickEditMottoName;
  m_pbtnGuildDismiss->evtMouseClick	  = _OnClickDismiss;
  m_pbtnMemberRecruit->evtMouseClick  = _OnClickRecruit;
  m_pbtnMemberRefuse->evtMouseClick	  = _OnClickRefuse;
  m_pbtnMemberKick->evtMouseClick	  = _OnClickKick;
  m_ppgeClass->evtSelectPage		  = _OnClickSelectPage;
  m_pbtnMemberKick->SetIsEnabled(true);
  m_pbtnMemberRecruit->SetIsEnabled(false);
  m_pbtnMemberRefuse->SetIsEnabled(false);
  m_plabGuildName->SetIsCenter(true);
  m_plabGuildMottoName->SetIsCenter(true);
  m_plabGuildType->SetIsCenter(true);
  m_plabGuildMaster->SetIsCenter(true);
  m_plabGuildMemberCount->SetIsCenter(true);
  m_plabGuildExperience->SetIsCenter(true);
  m_plabGuildMoney->SetIsCenter(true);
  m_plabGuildState->SetIsCenter(true);

  FORM_LOADING_CHECK(m_pGuildMottoNameEditForm, "manage.clu", "frmEditMaxim");
  FORM_CONTROL_LOADING_CHECK(m_pedtGuildMottoName, m_pGuildMottoNameEditForm, CEdit, "manage.clu", "edtMaxim");
  FORM_CONTROL_LOADING_CHECK(m_pbtnGuildMottoFormOK, m_pGuildMottoNameEditForm, CTextButton, "manage.clu", "btnYes");
  m_pbtnGuildMottoFormOK->evtMouseClick = _OnClickMottoFormOK;
  //#ifdef GUILD
  //	Rain.
  FORM_CONTROL_LOADING_CHECK(btnyqrh, m_pGuildMgrForm, CTextButton, "manage.clu", "btnyqrh");
  FORM_CONTROL_LOADING_CHECK(edtyqname, m_pGuildMgrForm, CEdit, "manage.clu", "edtyqname");
  btnyqrh->SetIsEnabled(true);
  btnyqrh->evtMouseClick = SendInviteName;
  //#endif
  //	End.
  //FORM_CONTROL_LOADING_CHECK(m_pGuildRank,m_pGuildMgrForm,CLabelEx,"manage.clu","labTurn");
  //FORM_CONTROL_LOADING_CHECK(m_pGuildList,m_pGuildMgrForm,CListView,"manage.clu","lstAsk");
  //m_pGuildList->GetList()->evtSelectChange=OnSelectChange;
  return true;
}

void CUIGuildMgr::ShowForm()
{
  RefreshForm();
  m_pGuildMgrForm->nTag = 1; // nTag==0时用于快捷键不显示
  m_pGuildMgrForm->Show();
}

void CUIGuildMgr::_OnClickEditMottoName(CGuiData* pSender, int x, int y, DWORD key)
{
  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  if(pSelfData && pSelfData->IsManager())
  {
	m_pedtGuildMottoName->SetCaption(CGuildData::GetGuildMottoName().c_str());
	m_pGuildMottoNameEditForm->ShowModal();
  } else
  {
	CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_594), true);
  }
}

void CUIGuildMgr::_OnClickDismiss(CGuiData* pSender, int x, int y, DWORD key)
{
  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  if(pSelfData && pSelfData->IsManager())
  {
	CBoxMgr::ShowPasswordBox(_OnPassDismiss, RES_STRING(CL_LANGUAGE_MATCH_595));
  } else
  {
	CBoxMgr::ShowSelectBox(_OnClickLeave, RES_STRING(CL_LANGUAGE_MATCH_596), true);
  }
}

void CUIGuildMgr::_OnClickRecruit(CGuiData* pSender, int x, int y, DWORD key)
{
  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  if(pSelfData && pSelfData->IsManager())
  {
	CItemRow* pRow = m_plstRecruitMember->GetList()->GetSelectItem();
	if(!pRow)
	{
	  CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_597), true);
	  return;
	}
	CRecruitMemberData* pMemberData = static_cast<CRecruitMemberData*>(pRow->GetPointer());
	CM_GUILD_APPROVE(pMemberData->GetID());
	m_plstRecruitMember->GetList()->Del(pRow);
	CRecruitMembersMgr::DelRecruitMember(pMemberData);
  } else
  {
	CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_598), true);
  }
}

void CUIGuildMgr::_OnClickRefuse(CGuiData* pSender, int x, int y, DWORD key)
{
  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  if(pSelfData && pSelfData->IsManager())
  {
	CItemRow* pRow = m_plstRecruitMember->GetList()->GetSelectItem();
	if(!pRow)
	{
	  CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_597), true);
	  return;
	}
	CRecruitMemberData* pMemberData = static_cast<CRecruitMemberData*>(pRow->GetPointer());
	CM_GUILD_REJECT(pMemberData->GetID());
	m_plstRecruitMember->GetList()->Del(pRow);
	CRecruitMembersMgr::DelRecruitMember(pMemberData);
  } else
  {
	CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_599), true);
  }
}

void CUIGuildMgr::_OnClickKick(CGuiData* pSender, int x, int y, DWORD key)
{
  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  if(pSelfData && pSelfData->IsManager())
  {
	CItemRow* pRow = m_plstGuildMember->GetList()->GetSelectItem();
	if(!pRow)
	{
	  CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_600), true);
	  return;
	}
	CGuildMemberData* pMemberData = static_cast<CGuildMemberData*>(pRow->GetPointer());
	string			  str		  = RES_STRING(CL_LANGUAGE_MATCH_601) + pMemberData->GetName() + RES_STRING(CL_LANGUAGE_MATCH_602);
	CBoxMgr::ShowSelectBox(_OnPassKick, str.c_str(), true);
  } else
  {
	CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_603), true);
  }
}

void CUIGuildMgr::_OnClickMottoFormOK(CGuiData* pSender, int x, int y, DWORD key)
{
  const string name = m_pedtGuildMottoName->GetCaption();
  if(!CTextFilter::IsLegalText(CTextFilter::NAME_TABLE, name) ||
	 !common::conformity::guild::motto::is_valid(name.c_str(), name.length()))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_51));
	return;
  }
  CM_GUILD_MOTTO(name.c_str());
  m_pGuildMottoNameEditForm->Hide();
}

void CUIGuildMgr::RefreshForm()
{
  RefreshAttribute();
  RefreshList();
}

void CUIGuildMgr::RefreshAttribute()
{
  char buf[50];
  m_plabGuildName->SetCaption(CGuildData::GetGuildName().c_str());
  m_plabGuildMaster->SetCaption(CGuildData::GetGuildMasterName().c_str());
  m_plabGuildMottoName->SetCaption(CGuildData::GetGuildMottoName().c_str());
  m_plabGuildType->SetCaption((CGuildData::GetGuildType() == CGuildData::navy) ? RES_STRING(CL_LANGUAGE_MATCH_604) : RES_STRING(CL_LANGUAGE_MATCH_605));
  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%d/%d", CGuildData::GetMemberCount(), CGuildData::GetMaxMembers());
  m_plabGuildMemberCount->SetCaption(buf);
  _i64toa_s(CGuildData::GetExperence(), buf, sizeof(buf), 10);
  m_plabGuildExperience->SetCaption(buf);
  _i64toa_s(CGuildData::GetMoney(), buf, sizeof(buf), 10);
  m_plabGuildMoney->SetCaption(buf);
  CGuildData::eState state = CGuildData::GetGuildState();
  string			 strState;
  if(state == CGuildData::normal)
  {
	strState = RES_STRING(CL_LANGUAGE_MATCH_606);
	m_plabGuildState->SetCaption(strState.c_str());
	m_plabGuildRemainTime->SetCaption("");
  } else
  {
	strState = RES_STRING(CL_LANGUAGE_MATCH_607);
	if(state & CGuildData::money)
	{
	  strState += RES_STRING(CL_LANGUAGE_MATCH_608);
	}
	if(state & CGuildData::repute)
	{
	  strState += RES_STRING(CL_LANGUAGE_MATCH_609);
	}
	if(state & CGuildData::member)
	{
	  strState += RES_STRING(CL_LANGUAGE_MATCH_610);
	}
	m_plabGuildState->SetCaption(strState.c_str());
	__int64 remain = CGuildData::GetRemainTime();
	if(remain > 1440)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_611), remain / 1440);
	} else if(remain > 60)
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_612), remain / 60);
	} else
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_613), remain);
	}
	m_plabGuildRemainTime->SetCaption(buf);
  }

  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  //	Modify by alfred
  if(pSelfData && pSelfData->IsManager())
  {
	m_pbtnGuildDismiss->GetImage()->LoadImage("texture/ui2009/guild4.tga", 43, 22, 0, 92, 150);
	m_pbtnGuildDismiss->GetImage()->LoadImage("texture/ui2009/guild4.tga", 43, 22, 1, 92, 194);
  } else
  {
	m_pbtnGuildDismiss->GetImage()->LoadImage("texture/ui2009/guild4.tga", 43, 22, 0, 135, 62);
	m_pbtnGuildDismiss->GetImage()->LoadImage("texture/ui2009/guild4.tga", 43, 22, 1, 135, 106);
  }
  m_pGuildMgrForm->Refresh();
}

void CUIGuildMgr::RefreshList()
{
  char buf[50];
  m_plstGuildMember->GetList()->GetItems()->Clear();
  for(DWORD i = 0; i < CGuildMembersMgr::GetTotalGuildMembers(); i++)
  {
	CGuildMemberData* pMemberData = CGuildMembersMgr::FindGuildMemberByIndex(i);
	if(!pMemberData) continue;
	CItemRow* pRow			  = m_plstGuildMember->GetList()->NewItem();
	CItem*	  pMemberNameItem = new CItem(pMemberData->GetName().c_str(), COLOR_BLACK);
	CItem*	  pMemberJobItem  = new CItem(pMemberData->GetJob().c_str(), COLOR_BLACK);
	//CItem*	pMemberLevelItem=new CItem(_i64toa(pMemberData->GetLevel(),buf,10),COLOR_BLACK);
	_i64toa_s(pMemberData->GetLevel(), buf, sizeof(buf), 10);
	CItem* pMemberLevelItem = new CItem(buf, COLOR_BLACK);
	pRow->SetIndex(0, pMemberNameItem);
	pRow->SetIndex(1, pMemberJobItem);
	pRow->SetIndex(2, pMemberLevelItem);
	pRow->SetPointer(pMemberData);
  }

  m_plstRecruitMember->GetList()->GetItems()->Clear();
  for(DWORD i = 0; i < CRecruitMembersMgr::GetTotalRecruitMembers(); i++)
  {
	CRecruitMemberData* pMemberData = CRecruitMembersMgr::FindRecruitMemberByIndex(i);
	if(!pMemberData) continue;
	CItemRow* pRow			  = m_plstRecruitMember->GetList()->NewItem();
	CItem*	  pMemberNameItem = new CItem(pMemberData->GetName().c_str(), COLOR_BLACK);
	CItem*	  pMemberJobItem  = new CItem(pMemberData->GetJob().c_str(), COLOR_BLACK);
	//CItem*	pMemberLevelItem=new CItem(_i64toa(pMemberData->GetLevel(),buf,10),COLOR_BLACK);
	_i64toa_s(pMemberData->GetLevel(), buf, sizeof(buf), 10);
	CItem* pMemberLevelItem = new CItem(buf, COLOR_BLACK);
	pRow->SetIndex(0, pMemberNameItem);
	pRow->SetIndex(1, pMemberJobItem);
	pRow->SetIndex(2, pMemberLevelItem);
	pRow->SetPointer(pMemberData);
  }
  m_pGuildMgrForm->Refresh();
}

void CUIGuildMgr::_OnClickSelectPage(CGuiData* pSender)
{
  int n = m_ppgeClass->GetIndex();
  if(n == 0) //成员列表
  {
	m_pbtnMemberKick->SetIsEnabled(true);
	m_pbtnMemberRecruit->SetIsEnabled(false);
	m_pbtnMemberRefuse->SetIsEnabled(false);
  } else if(n == 1) //申请人列表
  {
	m_pbtnMemberRecruit->SetIsEnabled(true);
	m_pbtnMemberRefuse->SetIsEnabled(true);
	m_pbtnMemberKick->SetIsEnabled(false);
  }
}

void CUIGuildMgr::RemoveForm()
{
  m_pGuildMgrForm->Close();
}

void CUIGuildMgr::_OnPassDismiss(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;
  stPasswordBox* pBox = (stPasswordBox*)pSender->GetForm()->GetPointer();
  if(!pBox) return;
  string str = pBox->edtPassword->GetCaption();
  if(str.length() > 0)
  {
	CM_GUILD_DISBAND(str.c_str());
  }
}

void CUIGuildMgr::_OnClickLeave(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType == CForm::mrYes)
  {
	CM_GUILD_LEAVE();
  }
}

void CUIGuildMgr::_OnPassKick(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;
  CItemRow* pRow = m_plstGuildMember->GetList()->GetSelectItem();
  if(!pRow)
  {
	CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_614), true);
	return;
  }
  CGuildMemberData* pMemberData = static_cast<CGuildMemberData*>(pRow->GetPointer());
  CM_GUILD_KICK(pMemberData->GetID());
}

void CUIGuildMgr::OnBeforeShow(CForm* pForm, bool& IsShow)
{
  if(!pForm->nTag)
  {
	CM_GUILD_LISTTRYPLAYER();
	IsShow = false;
  }
  pForm->nTag = 0;
}

void CUIGuildMgr::SendInviteName(CGuiData* pSender, int x, int y, DWORD key)
{
  CGuildMemberData* pSelfData = CGuildMembersMgr::GetSelfData();
  if(pSelfData && pSelfData->IsManager())
  {
	string name = edtyqname->GetCaption();
	if(!name.empty())
	{
	  if(common::conformity::character::name::is_valid(name.c_str(), (unsigned short)name.length()))
	  {
		CProCirculateCS* proCir = (CProCirculateCS*)g_NetIF->GetProCir();
		proCir->InviteInGuild(name.c_str());
	  } else
	  {
		g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_51));
	  }
	}
  } else
  {
	CBoxMgr::ShowMsgBox(NULL, RES_STRING(CL_LANGUAGE_MATCH_1038), true);
  }
}
