#include "stdafx.h"
#include "uirumbuyform.h"
#include "uirumdealform.h"
#include "uitextbutton.h"
#include "PacketCmd.h"
#include "gameapp.h"
#include "character.h"
#include "scene.h"

using namespace GUI;

CRumBuyMgr::CRumBuyMgr() :
	frmRumBuy(NULL),
	editCount(NULL),
	labelPrice(NULL),
	labelTotal(NULL),
	labelTax(NULL),
	BidPrice(0),
	BidCount(0)
{}

bool CRumBuyMgr::Init()
{
#ifndef SHUI_JING
  return true;
#endif

  frmRumBuy = _FindForm("frmRumBuy");
  if(!frmRumBuy)
	return false;

  CTextButton* btnDeal01 = static_cast<CTextButton*>(frmRumBuy->Find("btnDeal01"));
  assert(btnDeal01);
  btnDeal01->evtMouseClick = evtBuy;

  editCount = dynamic_cast<CEdit*>(frmRumBuy->Find("edtNumber"));
  assert(editCount);
  editCount->SetIsDigit(true);

  labelPrice = dynamic_cast<CLabelEx*>(frmRumBuy->Find("labTitle03"));
  assert(labelPrice);

  labelTotal = dynamic_cast<CLabelEx*>(frmRumBuy->Find("labTitle04"));
  assert(labelTotal);

  labelTax = dynamic_cast<CLabelEx*>(frmRumBuy->Find("labTitle05"));
  assert(labelTax);

  return true;
}

void CRumBuyMgr::ShowRumBuyForm(CGuiData* pSender)
{
  if(pSender)
  {
	int index = 0;
	for(; index < MAX_DEAL_COUNT; ++index)
	{
	  if(pSender == g_stRumDealForm.btnSell[index])
		break;
	}
	if(index == MAX_DEAL_COUNT)
	  return;

	editCount->SetCaption(g_stRumDealForm.labSellCount[index]->GetCaption());
	labelPrice->SetCaption(g_stRumDealForm.labSellPrice[index]->GetCaption());

	BidCount = _atoi64(editCount->GetCaption());
	BidPrice = _atoi64(labelPrice->GetCaption());

	char szText[32] = {0};
	_i64toa_s(BidPrice * BidCount, szText, sizeof(szText), 10);
	labelTotal->SetCaption(szText);

	_i64toa_s(CRumDealMgr::GetIndex(true), szText, sizeof(szText), 10);
	labelTax->SetCaption(szText);

	frmRumBuy->ShowModal();
  } else
	frmRumBuy->Close();
}

void CRumBuyMgr::FrameMove(DWORD dwTime)
{
  if(!labelTax)
	return;

  const char* Count	   = editCount->GetCaption();
  LONG64	  CurCount = _atoi64(Count);

  if(BidCount != CurCount)
  {
	BidCount = CurCount;

	char szText[32] = {0};
	_i64toa_s(BidPrice * BidCount, szText, sizeof(szText), 10);
	labelTotal->SetCaption(szText);

	_i64toa_s(CRumDealMgr::GetIndex(true), szText, sizeof(szText), 10);
	labelTax->SetCaption(szText);
  }
}

void CRumBuyMgr::evtBuy(CGuiData* pSender, int x, int y, DWORD key)
{
  if(strcmp(g_stRumBuyForm.editCount->GetCaption(), "") == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1042));
	return;
  }

  LONG64 GoldCoins = CGameScene::GetMainCha()->getGameAttr()->get(ATTR_GD);
  if((CRumDealMgr::GetIndex(true) + g_stRumBuyForm.BidPrice * g_stRumBuyForm.BidCount) > (g_stRumDealForm.GoldCoins + GoldCoins))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_997));
	return;
  }

  g_stRumDealForm.DealPrice = g_stRumBuyForm.BidPrice;

  CS_RequestBuyAsk(g_stRumBuyForm.BidPrice, g_stRumBuyForm.BidCount, 1);
  g_stRumBuyForm.ShowRumBuyForm(false);
}
