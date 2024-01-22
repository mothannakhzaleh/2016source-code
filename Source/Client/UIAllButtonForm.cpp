#include "StdAfx.h"
#include "UIAllButtonForm.h"

#include "gameapp.h"
#include "scene.h"
#include "gameapp.h"
#include "uilist.h"
#include "uiequipform.h"
#include "uifastcommand.h"
#include "uigoodsgrid.h"
#include "uiitemcommand.h"
#include "procirculate.h"
#include "packetcmd.h"
#include "UICombo.h"
#include "uiforgeform.h"
#include "UIMakeEquipForm.h"
#include "UISpiritForm.h"
#include "uistartform.h"
#include "UIItemReForm.h"
#include "UIHelpInfoForm.h"

using namespace GUI;

CCombo* AllButtonMgr::cboCion1 = 0;
CCombo* AllButtonMgr::cboCion2 = 0;
CCombo* AllButtonMgr::cboCion3 = 0;

int coin1(1), coin2(1), coin3(1);

bool AllButtonMgr::Init()
{
  frmAllBtn						  = _FindForm("frmAllBtn");
  frmAllBtn->evtEntrustMouseEvent = _evtAllButtonMouseEvent;

  frmElfCoin   = _FindForm("frmElfCoin");
  bool isClose = frmElfCoin->GetIsShow();
  if(!isClose)
  {
	g_FormHelpInfo.ShowHelpInfo(false, "frmElfCoin");
  }

  FORM_CONTROL_LOADING_CHECK(cboCion1, frmElfCoin, CCombo, "dialog.clu", "cboCion1");
  cboCion1					= dynamic_cast<CCombo*>(frmElfCoin->Find("cboCion1"));
  cboCion1->evtSelectChange = evtCloseCompany;

  FORM_CONTROL_LOADING_CHECK(cboCion2, frmElfCoin, CCombo, "dialog.clu", "cboCion2");
  cboCion2					= dynamic_cast<CCombo*>(frmElfCoin->Find("cboCion2"));
  cboCion2->evtSelectChange = evtCloseCompany;

  FORM_CONTROL_LOADING_CHECK(cboCion3, frmElfCoin, CCombo, "dialog.clu", "cboCion3");
  cboCion3					= dynamic_cast<CCombo*>(frmElfCoin->Find("cboCion3"));
  cboCion3->evtSelectChange = evtCloseCompany;

  btnTxt01 = dynamic_cast<CTextButton*>(frmElfCoin->Find("btnTxt01"));
  if(!btnTxt01) return false;
  btnTxt01->evtMouseClick = evtbtnClickDown;

  btnTxt02 = dynamic_cast<CTextButton*>(frmElfCoin->Find("btnTxt02"));
  if(!btnTxt02) return false;
  btnTxt02->evtMouseClick = evtbtnClickDown;

  btnTxt03 = dynamic_cast<CTextButton*>(frmElfCoin->Find("btnTxt03"));
  if(!btnTxt03) return false;
  btnTxt03->evtMouseClick = evtbtnClickDown;

  btnHelp				 = dynamic_cast<CTextButton*>(frmElfCoin->Find("btnHelp"));
  btnHelp->evtMouseClick = evtbtnClickDown;

  // 装备精炼Lv5、酷装熔合Lv5、装备打磨Lv5、宝石合成Lv5、
  // 属性转移lv4、随身交易Lv4、酷装强化Lv5、
  // 离线挂机Lv1、精灵硬币提炼Lv1、装备属性重置lv4、精灵结婚lv1、背后灵产出lv1
  char buffer[20];

  for(int i = 0; i < Max_Button, i != 7; i++)
  {
	_snprintf_s(buffer, _countof(buffer), _TRUNCATE, "btnTxt%02d", i + 1);
	btnCommand[i] = dynamic_cast<CTextButton*>(frmAllBtn->Find(buffer));
	if(!btnCommand[i])
	  return false;

	//btnCommand[i]->evtMouseClick = _evtAllButtonMouseEvent;
  }

  int Condition[12] = {5, 5, 5, 5, 4, 4, 5, 1, 1, 4, 1, 1};
  memcpy(this->btnCommandCondition, Condition, sizeof(Condition));

  return true;
}

void AllButtonMgr::_evtAllButtonMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();
  if(name == "btnTxt01")
  {
	// 装备精炼
	CForm* f = _FindForm("frmNPCforge");
	g_stUIForge.ShowForge(!f->GetIsShow(), false);
	CloseAllFormButThis("frmNPCforge");
  }
  if(name == "btnTxt02")
  {
	// 装备打磨
	CForm* f = _FindForm("frmNPCforge");
	g_stUIForge.ShowForge(!f->GetIsShow(), true);
	CloseAllFormButThis("frmNPCforge");
  }
  if(name == "btnTxt03")
  {
	// 酷装熔合
	CForm* f = _FindForm("frmMakeEquip");
	//NetShowFusion();
	g_stUIMakeEquip.SetType(CMakeEquipMgr::EQUIP_FUSION_TYPE);
	g_stUIMakeEquip.ShowMakeEquipForm(!f->GetIsShow());
	CloseAllFormButThis("frmMakeEquip");
  }
  if(name == "btnTxt04")
  {
	// 酷装强化
	CForm* f = _FindForm("frmMakeEquip");
	//NetShowUpgrade();
	g_stUIMakeEquip.SetType(CMakeEquipMgr::EQUIP_UPGRADE_TYPE);
	g_stUIMakeEquip.ShowMakeEquipForm(!f->GetIsShow());
	CloseAllFormButThis("frmMakeEquip");
  }
  if(name == "btnTxt05")
  {
	// 宝石合成
	CForm* f = _FindForm("frmMakeEquip");
	//NetShowUnite();
	g_stUIMakeEquip.SetType(CMakeEquipMgr::MAKE_EQUIP_TYPE);
	g_stUIMakeEquip.ShowMakeEquipForm(!f->GetIsShow());
	CloseAllFormButThis("frmMakeEquip");
  }
  if(name == "btnTxt06")
  {
	// 属性转移
	CForm* f = _FindForm("frmforgeMove");
	CloseAllFormButThis("frmforgeMove");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
  }
  //if(name == "btnTxt07")
  //{
  //	// 离线挂机
  //	CForm* f = CFormMgr::s_Mgr.Find( "frmElfAfk" );
  //	if (f)
  //	{
  //		f->SetIsShow(!f->GetIsShow());
  //	}
  //}
  if(name == "btnTxt08")
  {
	// 精灵硬币提炼
	CForm* f = _FindForm("frmElfCoin");
	CloseAllFormButThis("frmElfCoin");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
  }
  if(name == "btnTxt09")
  {
	//	移动交易
	CProCirculateCS* proCir = (CProCirculateCS*)g_NetIF->GetProCir();
	proCir->TradeWithYourSelf(1, 0);
	CForm* f = CFormMgr::s_Mgr.Find("frmNPCtrade");
	CloseAllFormButThis("frmNPCtrade");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
  }
  if(name == "btnTxt10")
  {
	// 装备属性重置
	CForm* f = _FindForm("frmItemRe");
	g_stItemReForm.ShowItemRe(!f->GetIsShow());
	CloseAllFormButThis("frmItemRe");
  }
  if(name == "btnTxt11")
  {
	// 精灵结婚
	CForm* f = _FindForm("frmSpiritMarry");
	g_stUISpirit.ShowMarryForm(!f->GetIsShow());
	CloseAllFormButThis("frmSpiritMarry");
  }
  if(name == "btnTxt12")
  {
	//	背后灵
	CForm* f = _FindForm("frmBakGhost");
	CloseAllFormButThis("frmBakGhost");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
  }
}

void AllButtonMgr::evtCloseCompany(CGuiData* pSender)
{
  string name  = pSender->GetName();
  string notDo = "";
  string CanDo = "";
  char*	 DoDo  = NULL;
  if(name == "cboCion1")
  {
	notDo = cboCion1->GetText();
	CanDo = notDo.substr(0, 2);
	DoDo  = (char*)CanDo.c_str();
	coin1 = atoi(DoDo);
  } else if(name == "cboCion2")
  {
	notDo = cboCion2->GetText();
	CanDo = notDo.substr(0, 2);
	DoDo  = (char*)CanDo.c_str();
	coin2 = atoi(DoDo);
  } else if(name == "cboCion3")
  {
	notDo = cboCion3->GetText();
	CanDo = notDo.substr(0, 2);
	DoDo  = (char*)CanDo.c_str();
	coin3 = atoi(DoDo);
  }
}

void AllButtonMgr::evtbtnClickDown(CGuiData* pSender, int x, int y, DWORD key)
{
  string		   name	  = pSender->GetName();
  CProCirculateCS* proCir = (CProCirculateCS*)g_NetIF->GetProCir();
  if(name == "btnTxt01")
  {
	proCir->SendCoinInfo(1, coin1);
  } else if(name == "btnTxt02")
  {
	proCir->SendCoinInfo(2, coin2);
  } else if(name == "btnTxt03")
  {
	proCir->SendCoinInfo(3, coin3);
  } else if(name == "btnHelp")
	g_FormHelpInfo.ShowHelpInfo(!g_FormHelpInfo.IsShown(), "frmElfCoin");
}

void AllButtonMgr::ShowAllForm(bool bShow)
{
  /*int level= JudgeGost();

	for(int i=0;i<Max_Button;i++)
	{
		if(this->btnCommandCondition[i] <= level)
		{
			if(!btnCommand[i])
				btnCommand[i]->SetIsEnabled(false);
			else
				btnCommand[i]->SetIsEnabled(true);
		
		}
		else
		{
			btnCommand[i]->SetIsEnabled(false);
		}
	}*/
  for(int i = 0; i < Max_Button, i != 7; i++)
  {
	btnCommand[i]->SetIsEnabled(true);
  }

  frmAllBtn->SetIsShow(!frmAllBtn->GetIsShow());
}

int AllButtonMgr::JudgeGost()
{
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(1));

  // 精灵背包格子没有道具
  if(!pItemCommand)
	return -1;

  // 是精灵的情况下计算精灵等级
  CItemRecord* pItemRecord = pItemCommand->GetItemInfo();
  if(pItemRecord && pItemRecord->sType == 59)
  {
	SItemHint sItemHint;
	memset(&sItemHint, 0, sizeof(SItemHint));
	sItemHint.Convert(pItemCommand->GetData(), pItemRecord);

	return 1;
  }

  return -1;
}

void AllButtonMgr::GetLeaveTime(int iTime)
{
  g_stUIStart.RefreshLeftTimeName(iTime);
}

void AllButtonMgr::CloseAllFormButThis(string frmName)
{
  CForm* f1 = _FindForm("frmNPCforge");
  CForm* f2 = _FindForm("frmMakeEquip");
  CForm* f3 = _FindForm("frmforgeMove");
  //CForm* f4 = CFormMgr::s_Mgr.Find( "frmElfAfk" );
  CForm* f5 = _FindForm("frmElfCoin");
  CForm* f6 = CFormMgr::s_Mgr.Find("frmNPCtrade");
  CForm* f7 = _FindForm("frmItemRe");
  CForm* f8 = _FindForm("frmSpiritMarry");
  CForm* f9 = _FindForm("frmBakGhost");
  if(frmName == "frmNPCforge")
  {
	f2->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f6->SetIsShow(false);
	f7->SetIsShow(false);
	f8->SetIsShow(false);
	f9->SetIsShow(false);
  } else if(frmName == "frmMakeEquip")
  {
	f1->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f6->SetIsShow(false);
	f7->SetIsShow(false);
	f8->SetIsShow(false);
	f9->SetIsShow(false);
  } else if(frmName == "frmforgeMove")
  {
	f1->SetIsShow(false);
	f2->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f6->SetIsShow(false);
	f7->SetIsShow(false);
	f8->SetIsShow(false);
	f9->SetIsShow(false);
  }
  /*else if ( frmName == "frmElfAfk")
	{
		f1->SetIsShow(false);
		f2->SetIsShow(false);
		f3->SetIsShow(false);
		f5->SetIsShow(false);
		f6->SetIsShow(false);
		f7->SetIsShow(false);
		f8->SetIsShow(false);
		f9->SetIsShow(false);
	}*/
  else if(frmName == "frmElfCoin")
  {
	f1->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f2->SetIsShow(false);
	f6->SetIsShow(false);
	f7->SetIsShow(false);
	f8->SetIsShow(false);
	f9->SetIsShow(false);
  } else if(frmName == "frmNPCtrade")
  {
	f1->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f2->SetIsShow(false);
	f7->SetIsShow(false);
	f8->SetIsShow(false);
	f9->SetIsShow(false);
  } else if(frmName == "frmItemRe")
  {
	f1->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f6->SetIsShow(false);
	f2->SetIsShow(false);
	f8->SetIsShow(false);
	f9->SetIsShow(false);
  } else if(frmName == "frmSpiritMarry")
  {
	f1->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f6->SetIsShow(false);
	f7->SetIsShow(false);
	f2->SetIsShow(false);
	f9->SetIsShow(false);
  } else if(frmName == "frmBakGhost")
  {
	f1->SetIsShow(false);
	f3->SetIsShow(false);
	//f4->SetIsShow(false);
	f5->SetIsShow(false);
	f6->SetIsShow(false);
	f7->SetIsShow(false);
	f8->SetIsShow(false);
	f2->SetIsShow(false);
  }
}