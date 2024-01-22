
#include "StdAfx.h"
#include "UIChaInfo.h"
#include "UITeam.h"
#include "uiformmgr.h"
#include "uitreeview.h"
#include "uiitem.h"
#include "uiprogressbar.h"
#include "uilabel.h"
#include "uitextbutton.h"
#include "uigraph.h"
#include "smallmap.h"
#include "ui3dcompent.h"
#include "GameApp.h"
#include "netcommand.h"
#include "teaminviteformmgr.h"
#include "frndinviteformmgr.h"
#include "Character.h"
#include "uilist.h"
#include "PacketCmd.h"
#include "UICheckBox.h"
#include "UIEdit.h"
#include "UIForm.h"
#include "NetChat.h"
#include "UIMenu.h"
#include "chaticonset.h"
#include "talksessionformmgr.h"
#include "GameConfig.h"
#include <fstream>
#include "uiboxform.h"
#include "UITemplete.h"
#include "worldscene.h"
#include "GuildMemberData.h"
#include "GuildMembersMgr.h"
#include "UIStartForm.h"
#include "GuildData.h"
#include "autoattack.h"
#include "UICozeForm.h"
#include "UITeam.h"
#include <time.h>
#include <shlobj.h>
#include "UIChat.h"

using namespace GUI;
CForm* CChaQeryInfo::m_pFrmSInfo  = NULL;
CForm* CChaQeryInfo::m_pFrmQInfo  = NULL;
CForm* CChaQeryInfo::m_pFrmQRInfo = NULL;

//---------------------------------------------------------------------------
// class CChaQeryInfo
//---------------------------------------------------------------------------

CChaQeryInfo::CChaQeryInfo()
{
}

bool CChaQeryInfo::Init()
{
  CFormMgr::s_Mgr.AddHotKeyEvent(CTalkSessionFormMgr::OnHotKeyShow);

  CFormMgr& mgr = CFormMgr::s_Mgr;

  // 初始化控件
  char szBuf[80] = {0};

  // 初始化界面
  m_pFrmSInfo = mgr.Find("frmOtherInfo");
  if(!m_pFrmSInfo)
  {
	//::Error(g_oLangRec.GetString(412));
	assert(0);
	return false;
  }
  m_pFrmSInfo->SetIsShow(true);

  m_pFrmQInfo = mgr.Find("frmsousuo");
  if(!m_pFrmQInfo)
  {
	//::Error(g_oLangRec.GetString(412));
	assert(0);
	return false;
  }
  m_pFrmQInfo->SetIsShow(false);

  m_pFrmQRInfo = mgr.Find("frmchaxun");
  if(!m_pFrmQRInfo)
  {
	//::Error(g_oLangRec.GetString(412));
	assert(0);
	return false;
  }
  m_pFrmQRInfo->SetIsShow(false);

  // form  search
  m_pEdtTradeGold = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("edtTradeGold"));
  m_pEdtTradeGold->SetCaption("");
  m_pLabName = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("labName"));
  m_pLabName->SetCaption("");
  m_pChaguild = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaguild"));
  m_pChaguild->SetCaption("");
  m_pChaLv = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaLv"));
  m_pChaLv->SetCaption("");
  m_pChaJob = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chazhiye"));
  m_pChaJob->SetCaption("");
  m_pReputation = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chashengwang"));
  m_pReputation->SetCaption("");
  m_pChaNickName = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chachenghao"));
  m_pChaNickName->SetCaption("");
  m_pSupport = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaxianhua"));
  m_pSupport->SetCaption("");
  m_pOppose = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chajidan"));
  m_pOppose->SetCaption("");
  m_pAttention = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaguanzhu"));
  m_pAttention->SetCaption("");
  m_pChaSex = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaxingbie"));
  m_pChaSex->SetCaption("");
  m_pChaAge = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chanianling"));
  m_pChaAge->SetCaption("");
  m_pChaName = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaxingming"));
  m_pChaName->SetCaption("");
  m_pAnimalZodiac = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chashengxiao"));
  m_pAnimalZodiac->SetCaption("");
  m_pBloodType = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaxuexing"));
  m_pBloodType->SetCaption("");
  m_pBirthMonth = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chashengriyue"));
  m_pBirthMonth->SetCaption("");
  m_pBirthDay = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chashengriri"));
  m_pBirthDay->SetCaption("");
  m_pState = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chashengfen"));
  m_pState->SetCaption("");
  m_pCity = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaquyu"));
  m_pCity->SetCaption("");
  m_pConstellation = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaxingzuo"));
  m_pConstellation->SetCaption("");
  m_pJob = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chajob"));
  m_pJob->SetCaption("");
  m_pIdiograph = dynamic_cast<CLabel*>(m_pFrmSInfo->Find("chaqianming"));
  m_pIdiograph->SetCaption("");
  m_pAddFlowerBt = dynamic_cast<CTextButton*>(m_pFrmSInfo->Find("btnFlower"));
  m_pAddFlowerBt->SetCaption("");
  m_pAddFlowerBt->evtMouseClick = _evSFrm;
  m_pAddEggBt					= dynamic_cast<CTextButton*>(m_pFrmSInfo->Find("btnEgg"));
  m_pAddEggBt->SetCaption("");
  m_pAddEggBt->evtMouseClick = _evSFrm;
  m_pChangePhoto			 = dynamic_cast<CTextButton*>(m_pFrmSInfo->Find("btntouxiang"));
  m_pChangePhoto->SetCaption("");
  m_pChangePhoto->evtMouseClick = _evSFrm;
  m_pChaPhoto					= dynamic_cast<CImage*>(m_pFrmSInfo->Find("imgMhead"));

  m_pBtYes					= dynamic_cast<CTextButton*>(m_pFrmSInfo->Find("btnYes"));
  m_pBtYes->evtMouseClick	= _evSFrm;
  m_pPicBox1				= dynamic_cast<CTextButton*>(m_pFrmSInfo->Find("btnxiangce01"));
  m_pPicBox1->evtMouseClick = _evSFrm;
  m_pPicBox2				= dynamic_cast<CTextButton*>(m_pFrmSInfo->Find("btnxiangce02"));
  m_pPicBox2->evtMouseClick = _evSFrm;

  // form query
  m_pQchaName			 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaname"));
  m_pQHasPic			 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaphoto"));
  m_pQSex				 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaxingbie"));
  m_pQminAge			 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaage1"));
  m_pQmaxAge			 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaage2"));
  m_pQAnimalZodiac		 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chashengxiao"));
  m_pQBirthmonth0		 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chashengri1"));
  m_pQBirthmonth1		 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chashengri2"));
  m_pQBirthday0			 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chashengri3"));
  m_pQBirthday1			 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chashengri4"));
  m_pQstate				 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chashengfen"));
  m_pQcity				 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaquyu"));
  m_pQConstellation		 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chaxingzuo"));
  m_pQjob				 = dynamic_cast<CEdit*>(m_pFrmQInfo->Find("chazhiye"));
  m_pQYes				 = dynamic_cast<CTextButton*>(m_pFrmQInfo->Find("btnYes"));
  m_pQYes->evtMouseClick = _evQFrm;

  // form query info

  m_pQRList = dynamic_cast<CList*>(m_pFrmQRInfo->Find("lstforQueryInfo"));

  return true;
}

void CChaQeryInfo::End()
{
}

void CChaQeryInfo::ClearInfo()
{
}

void CChaQeryInfo::RefreshInfoData(CMember* pCurMember)
{
}

void CChaQeryInfo::RefreshInfo()
{
}
void CChaQeryInfo::SetShowChaInfo(bool _b)
{
  m_pFrmSInfo->SetIsShow(_b);
}

void CChaQeryInfo::SetShowQChaInfo(bool _b)
{
  m_pFrmQInfo->SetIsShow(_b);
}

void CChaQeryInfo::SetShowQRChaInfo(bool _b)
{
  m_pFrmQRInfo->SetIsShow(_b);
}
void CChaQeryInfo::_evSFrm(CGuiData* pSender, int x, int y, DWORD key)
{
  if(pSender == (CGuiData*)g_ChaQeryInfo.m_pBtYes) // 详细信息   --确定
  {
  } else if(pSender == (CGuiData*)g_ChaQeryInfo.m_pAddFlowerBt) //  --- 增加鲜花
  {
  } else if(pSender == (CGuiData*)g_ChaQeryInfo.m_pAddEggBt) // -----增加臭鸡蛋
  {
  } else if(pSender == (CGuiData*)g_ChaQeryInfo.m_pChangePhoto) // ----更改头像
  {
  } else if(pSender == (CGuiData*)g_ChaQeryInfo.m_pPicBox1)
  {
	//CFormMgr& mgr = CFormMgr::s_Mgr;
	//CForm* frmPhoto = mgr.Find("frmPhoto");
	//if( !frmPhoto )
	//{
	//	assert(0);
	//	return ;
	//}
	//g_stUIChat.setURLPicture(g_stUIChat._PictureCChat.getVisitorCharacterID());
	//frmPhoto->evtMouseDragBegin = CChat::_PhotoFrmDragBegin;
	//frmPhoto->evtMouseDragEnd = CChat::_PhotoFrmDragEnd;
	//frmPhoto->evtShow = CChat::_webPhotoFrmShow;
	//frmPhoto->evtHide = CChat::_webPhotoFrmHide;
	//frmPhoto->ShowModal();
  }
}
void CChaQeryInfo::_evQFrm(CGuiData* pSender, int x, int y, DWORD key)
{
  if(pSender == (CGuiData*)g_ChaQeryInfo.m_pQYes) // 查询面版的确定
  {
	g_ChaQeryInfo.UpdateInfo();
	CP_Query_PersonInfo(&g_ChaQeryInfo.m_QeryInfo);
	g_ChaQeryInfo.m_pFrmQInfo->Close();
  }
}
bool CChaQeryInfo::SetSearchFrmData(stPersonInfo* _info, CMember* _m)
{
  if(!_info) return false;
  if(m_pFrmSInfo)
  {
	char buff[64] = "";

	m_pEdtTradeGold->SetCaption(_m->GetMotto());
	m_pLabName->SetCaption(_m->GetName());
	m_pChaguild->SetCaption(_m->GetGuildName());
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", _m->GetLevel());
	m_pChaLv->SetCaption(buff);
	m_pChaJob->SetCaption(_m->GetJobNameByID()); //modify by rock.wang 2009.05.07
	// 声望不知道是什么
	m_pReputation->SetCaption("");
	//

	// Modify by rock.wang 2009.05.12 Start
	//m_pChaNickName->SetCaption(_m->GetJobName());
	m_pChaNickName->SetCaption("");
	// End

	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", _info->iSupport);
	m_pSupport->SetCaption(buff);
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", _info->iOppose);
	m_pOppose->SetCaption(buff);

	// 关注
	srand((unsigned int)time(NULL));
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", rand() % 1000);
	m_pAttention->SetCaption(buff);

	m_pChaSex->SetCaption(_info->szSex);
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", _info->sAge);
	m_pChaAge->SetCaption(buff);
	m_pChaName->SetCaption(_info->szName);
	m_pAnimalZodiac->SetCaption(_info->szAnimalZodiac);
	m_pBloodType->SetCaption(_info->szBloodType);

	//Modify by sunny.sun 20080825
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", (_info->iBirthday >> 5));
	m_pBirthMonth->SetCaption(buff);
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%d", (_info->iBirthday - (_info->iBirthday >> 5 << 5)));
	m_pBirthDay->SetCaption(buff);

	m_pState->SetCaption(_info->szState);
	m_pCity->SetCaption(_info->szCity);
	m_pConstellation->SetCaption(_info->szConstellation);
	m_pJob->SetCaption(_info->szCareer);
	m_pIdiograph->SetCaption(_info->szMotto);

	/*if(_info->bShowMotto)
			m_pStopChat->SetCaption("有");
		else 
			m_pStopChat->SetCaption("没");*/

	CChatIconInfo* pIconInfo = GetChatIconInfo(g_stUIChat._dwSelfIcon);
	if(pIconInfo)
	{
	  CGuiPic* pPic	   = m_pChaPhoto->GetImage();
	  string   strPath = "texture/ui/HEAD/";
	  if(strcmp(_info->szSex, RES_STRING(CL_UICHAINFO_CPP_00001)) == 0)
		pPic->LoadImage((strPath + "1.bmp").c_str(), 100, 100, 0, pIconInfo->nBigX, pIconInfo->nBigY);
	  else
		pPic->LoadImage((strPath + "2.bmp").c_str(), 100, 100, 0, pIconInfo->nBigX, pIconInfo->nBigY);
	}
  }
  return true;
}

stPersonInfo* CChaQeryInfo::GetSearchFrmData()
{
  return &m_ShowInfo;
}

bool CChaQeryInfo::SetQueryFrmData(stQueryPersonInfo* _info)
{
  return true;
}

stQueryPersonInfo* CChaQeryInfo::GetQueryFrmData()
{
  return &m_QeryInfo;
}

bool CChaQeryInfo::SetQueryRFrmData(stQueryResoultPersonInfo* _info, int num)
{
  // form query resoult info

  if(!_info) return false;
  if(m_pFrmQRInfo)
  {
	ClearQueryRFrmData();
	for(int i = 0; i < num; i++)
	{
	  char resoult[256] = "";
	  if((*_info).nMinAge == -1) continue;
	  _snprintf_s(resoult, _countof(resoult), _TRUNCATE, "%s  %d  %s  %s  %s ", (*_info).sChaName,
				  (*_info).nMinAge, (*_info).cSex, (*_info).szState, (*_info).nCity);
	  m_pQRList->Add(resoult);
	}
  }
  return true;
}
void CChaQeryInfo::ClearQueryRFrmData()
{
  m_pQRList->Clear();
}

stQueryResoultPersonInfo* CChaQeryInfo::GetQueryRFrmData()
{
  return &m_ResoultInfo;
}

void CChaQeryInfo::UpdateInfo()
{
  // show person info
  if(m_pFrmSInfo)
  {
	char			  birthmonth[20] = "";
	char			  birthday[20]	 = "";
	_W64 unsigned int len			 = 0;
	memset(&m_ShowInfo, 0, sizeof(stPersonInfo));
	len = sizeof(m_ShowInfo.szMotto) > strlen(m_pIdiograph->GetCaption()) ? strlen(m_pIdiograph->GetCaption()) : sizeof(m_ShowInfo.szMotto);
	memcpy(m_ShowInfo.szMotto, m_pIdiograph->GetCaption(), len);

	//m_ShowInfo.bShowMotto = m_pStopChat->GetIsChecked();

	len = sizeof(m_ShowInfo.szSex) > strlen(m_pChaSex->GetCaption()) ? strlen(m_pChaSex->GetCaption()) : sizeof(m_ShowInfo.szSex);
	memcpy(m_ShowInfo.szSex, m_pChaSex->GetCaption(), len);

	m_ShowInfo.sAge = atoi(m_pChaAge->GetCaption());

	len = sizeof(m_ShowInfo.szName) > strlen(m_pChaName->GetCaption()) ? strlen(m_pChaName->GetCaption()) : sizeof(m_ShowInfo.szName);
	memcpy(m_ShowInfo.szName, m_pChaName->GetCaption(), len);

	len = sizeof(m_ShowInfo.szAnimalZodiac) > strlen(m_pAnimalZodiac->GetCaption()) ? strlen(m_pAnimalZodiac->GetCaption()) : sizeof(m_ShowInfo.szAnimalZodiac);
	memcpy(m_ShowInfo.szAnimalZodiac, m_pAnimalZodiac->GetCaption(), len);

	len = sizeof(m_ShowInfo.szBloodType) > strlen(m_pBloodType->GetCaption()) ? strlen(m_pBloodType->GetCaption()) : sizeof(m_ShowInfo.szBloodType);
	memcpy(m_ShowInfo.szBloodType, m_pBloodType->GetCaption(), len);

	len = sizeof(birthmonth) > strlen(m_pBirthMonth->GetCaption()) ? strlen(m_pBirthMonth->GetCaption()) : sizeof(birthmonth);
	memcpy(birthmonth, m_pBirthMonth->GetCaption(), len);

	len = sizeof(birthday) > strlen(m_pBirthDay->GetCaption()) ? strlen(m_pBirthDay->GetCaption()) : sizeof(birthday);
	memcpy(birthday, m_pBirthDay->GetCaption(), len);

	//m_ShowInfo.iBirthday = atoi(birthmonth)<<16 |atoi(birthday);
	m_ShowInfo.iBirthday = (atoi(birthmonth) << 5) + atoi(birthday); //Modify by sunny.sun20080825

	len = sizeof(m_ShowInfo.szState) > strlen(m_pState->GetCaption()) ? strlen(m_pState->GetCaption()) : sizeof(m_ShowInfo.szState);
	memcpy(m_ShowInfo.szState, m_pState->GetCaption(), len);

	len = sizeof(m_ShowInfo.szCity) > strlen(m_pCity->GetCaption()) ? strlen(m_pCity->GetCaption()) : sizeof(m_ShowInfo.szCity);
	memcpy(m_ShowInfo.szCity, m_pCity->GetCaption(), len);

	len = sizeof(m_ShowInfo.szConstellation) > strlen(m_pConstellation->GetCaption()) ? strlen(m_pConstellation->GetCaption()) : sizeof(m_ShowInfo.szConstellation);
	memcpy(m_ShowInfo.szConstellation, m_pConstellation->GetCaption(), len);

	len = sizeof(m_ShowInfo.szCareer) > strlen(m_pJob->GetCaption()) ? strlen(m_pJob->GetCaption()) : sizeof(m_ShowInfo.szCareer);
	memcpy(m_ShowInfo.szCareer, m_pJob->GetCaption(), len);

	memset(m_ShowInfo.pAvatar, 0, sizeof(m_ShowInfo.pAvatar));
  }

  // form query info
  if(m_pFrmQInfo)
  {
	char			  birthmonth[20] = "";
	char			  birthday[20]	 = "";
	_W64 unsigned int len			 = 0;
	memset(&m_QeryInfo, 0, sizeof(stQueryPersonInfo));
	len = sizeof(m_QeryInfo.sChaName) > strlen(m_pQchaName->GetCaption()) ? strlen(m_pQchaName->GetCaption()) : sizeof(m_QeryInfo.sChaName);
	memcpy(m_QeryInfo.sChaName, m_pQchaName->GetCaption(), len);

	// 要把字符放到stringset.txt中去
	if(strcmp(m_pQHasPic->GetCaption(), RES_STRING(CL_UICHAINFO_CPP_00002)) == 0)
	  m_QeryInfo.bHavePic = true;
	else
	  m_QeryInfo.bHavePic = false;

	//m_pFrmQInfo.bHavePic = (strcmp(m_pQHasPic->GetCaption(),"有")==0)？true:false;

	len = sizeof(m_QeryInfo.cSex) > strlen(m_pQSex->GetCaption()) ? strlen(m_pQSex->GetCaption()) : sizeof(m_QeryInfo.cSex);
	memcpy(m_QeryInfo.cSex, m_pQSex->GetCaption(), len);

	m_QeryInfo.nMinAge[0] = atoi(m_pQminAge->GetCaption());
	m_QeryInfo.nMinAge[1] = atoi(m_pQmaxAge->GetCaption());

	len = sizeof(m_QeryInfo.szAnimalZodiac) > strlen(m_pQAnimalZodiac->GetCaption()) ? strlen(m_pQAnimalZodiac->GetCaption()) : sizeof(m_QeryInfo.szAnimalZodiac);
	memcpy(m_QeryInfo.szAnimalZodiac, m_pQAnimalZodiac->GetCaption(), len);

	//m_QeryInfo.iBirthday[0] = (atoi(m_pQBirthmonth0->GetCaption())<<16)|(atoi(m_pQBirthday0->GetCaption()));
	//m_QeryInfo.iBirthday[1] = (atoi(m_pQBirthmonth1->GetCaption())<<16)|(atoi(m_pQBirthday1->GetCaption()));
	//Modify by sunny.sun 20080825
	m_QeryInfo.iBirthday[0] = (atoi(m_pQBirthmonth0->GetCaption()) << 5) + (atoi(m_pQBirthday0->GetCaption()));
	m_QeryInfo.iBirthday[1] = (atoi(m_pQBirthmonth1->GetCaption()) << 5) + (atoi(m_pQBirthday1->GetCaption()));

	len = sizeof(m_QeryInfo.szState) > strlen(m_pQstate->GetCaption()) ? strlen(m_pQstate->GetCaption()) : sizeof(m_QeryInfo.szState);
	memcpy(m_QeryInfo.szState, m_pQstate->GetCaption(), len);

	len = sizeof(m_QeryInfo.szCity) > strlen(m_pQcity->GetCaption()) ? strlen(m_pQcity->GetCaption()) : sizeof(m_QeryInfo.szCity);
	memcpy(m_QeryInfo.szCity, m_pQcity->GetCaption(), len);

	len = sizeof(m_QeryInfo.szConstellation) > strlen(m_pQConstellation->GetCaption()) ? strlen(m_pQConstellation->GetCaption()) : sizeof(m_QeryInfo.szConstellation);
	memcpy(m_QeryInfo.szConstellation, m_pQConstellation->GetCaption(), len);

	len = sizeof(m_QeryInfo.szCareer) > strlen(m_pQjob->GetCaption()) ? strlen(m_pQjob->GetCaption()) : sizeof(m_QeryInfo.szCareer);
	memcpy(m_QeryInfo.szCareer, m_pQjob->GetCaption(), len);

	m_QeryInfo.nPageItemNum = 10;
	m_QeryInfo.nCurPage		= 1;
  }
}

void CChaQeryInfo::FrameMove(DWORD dwTime)
{
  //UpdateInfo();

  //	CP_Change_PersonInfo();
}
