#include "stdafx.h"
#include "uirumsaleform.h"
#include "uirumdealform.h"
#include "gameapp.h"
#include "character.h"
#include "UIedit.h"
#include "UITextButton.h"

using namespace GUI;

CRumSaleMgr::CRumSaleMgr() :
	frmRumSale(NULL),
	labelCount(NULL),
	labelPrice(NULL),
	labelTotal(NULL),
	labelTax(NULL)
{}

bool CRumSaleMgr::Init()
{
#ifndef SHUI_JING
  return true;
#endif

  frmRumSale = _FindForm("frmRumSale");
  if(!frmRumSale)
	return false;

  CTextButton* btnDeal03 = static_cast<CTextButton*>(frmRumSale->Find("btnDeal11"));
  assert(btnDeal03);
  btnDeal03->evtMouseClick = evtSale;

  labelCount = dynamic_cast<CLabelEx*>(frmRumSale->Find("edtNumber2"));
  assert(labelCount);

  labelPrice = dynamic_cast<CLabelEx*>(frmRumSale->Find("labTitle13"));
  assert(labelPrice);

  labelTotal = dynamic_cast<CLabelEx*>(frmRumSale->Find("labTitle14"));
  assert(labelTotal);

  labelTax = dynamic_cast<CLabelEx*>(frmRumSale->Find("labTitle15"));
  assert(labelTax);

  return true;
}

void CRumSaleMgr::ShowRumSaleForm(bool bShow)
{
  if(bShow)
  {
	labelCount->SetCaption(g_stRumDealForm.editSellCount->GetCaption());
	labelPrice->SetCaption(g_stRumDealForm.editSellPrice->GetCaption());
	labelTotal->SetCaption(g_stRumDealForm.labSellTotal->GetCaption());
	labelTax->SetCaption(g_stRumDealForm.labSellTax->GetCaption());

	frmRumSale->ShowModal();
  } else
	frmRumSale->Close();
}

void CRumSaleMgr::evtSale(CGuiData* pSender, int x, int y, DWORD key)
{
  if(g_stRumDealForm.SellBidCount > g_stRumDealForm.CrystalCoins)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_998));
	return;
  }

  LONG64 GameGoldCoins = CGameScene::GetMainCha()->getGameAttr()->get(ATTR_GD);
  if(CRumDealMgr::GetIndex(false) > (g_stRumDealForm.GoldCoins + GameGoldCoins))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1020));
	return;
  }

  if(g_stRumDealForm.SellBidPrice * g_stRumDealForm.SellBidCount + g_stRumDealForm.GoldCoins > 2000000000)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1037));
	return;
  }

  g_stRumDealForm.DealPrice = g_stRumDealForm.SellBidPrice;

  CS_RequestSaleAsk(g_stRumDealForm.SellBidPrice, g_stRumDealForm.SellBidCount, 0);

  g_stRumSaleForm.ShowRumSaleForm(false);
}
