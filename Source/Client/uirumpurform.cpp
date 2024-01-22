#include "stdafx.h"
#include "uirumpurform.h"
#include "uirumdealform.h"
#include "gameapp.h"
#include "character.h"
#include "UIedit.h"
#include "UITextButton.h"


using namespace GUI;

CRumPurMgr::CRumPurMgr() :
	frmRumPur(NULL),
	labelCount(NULL),
	labelPrice(NULL),
	labelTotal(NULL),
	labelTax(NULL)
{}

bool CRumPurMgr::Init()
{
#ifndef SHUI_JING
  return true;
#endif

  frmRumPur = _FindForm("frmRumpur");
  if(!frmRumPur)
	return false;

  CTextButton* btnDeal03 = static_cast<CTextButton*>(frmRumPur->Find("btnDeal13"));
  assert(btnDeal03);
  btnDeal03->evtMouseClick = evtPur;

  labelCount = dynamic_cast<CLabelEx*>(frmRumPur->Find("edtNumber3"));
  assert(labelCount);

  labelPrice = dynamic_cast<CLabelEx*>(frmRumPur->Find("labTitle16"));
  assert(labelPrice);

  labelTotal = dynamic_cast<CLabelEx*>(frmRumPur->Find("labTitle17"));
  assert(labelTotal);

  labelTax = dynamic_cast<CLabelEx*>(frmRumPur->Find("labTitle18"));
  assert(labelTax);

  return true;
}

void CRumPurMgr::ShowRumPurForm(bool bShow)
{
  if(bShow)
  {
	labelCount->SetCaption(g_stRumDealForm.editBuyCount->GetCaption());
	labelPrice->SetCaption(g_stRumDealForm.editBuyPrice->GetCaption());
	labelTotal->SetCaption(g_stRumDealForm.labBuyTotal->GetCaption());
	labelTax->SetCaption(g_stRumDealForm.labBuyTax->GetCaption());

	frmRumPur->ShowModal();
  } else
	frmRumPur->Close();
}

void CRumPurMgr::evtPur(CGuiData* pSender, int x, int y, DWORD key)
{
  LONG64 GameGoldCoins = CGameScene::GetMainCha()->getGameAttr()->get(ATTR_GD);
  if((CRumDealMgr::GetIndex(true) + g_stRumDealForm.BuyBidPrice * g_stRumDealForm.BuyBidCount) >
	 (g_stRumDealForm.GoldCoins + GameGoldCoins))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_997));
	return;
  }

  g_stRumDealForm.DealPrice = g_stRumDealForm.BuyBidPrice;

  CS_RequestBuyAsk(g_stRumDealForm.BuyBidPrice, g_stRumDealForm.BuyBidCount, 0);

  g_stRumPurForm.ShowRumPurForm(false);
}
