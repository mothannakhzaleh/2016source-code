#include "stdafx.h"
#include "uirumsellform.h"
#include "uirumdealform.h"
#include "uitextbutton.h"
#include "PacketCmd.h"
#include "gameapp.h"
#include "character.h"
#include "scene.h"

using namespace GUI;

CRumSellMgr::CRumSellMgr() :
	frmRumSell(NULL),
	editCount(NULL),
	labelPrice(NULL),
	labelTotal(NULL),
	labelTax(NULL),
	BidPrice(0),
	BidCount(0)
{}

bool CRumSellMgr::Init()
{
#ifndef SHUI_JING
  return true;
#endif

  frmRumSell = _FindForm("frmRumSell");
  if(!frmRumSell)
	return false;

  CTextButton* btnDeal03 = static_cast<CTextButton*>(frmRumSell->Find("btnDeal03"));
  assert(btnDeal03);
  btnDeal03->evtMouseClick = evtSell;

  editCount = dynamic_cast<CEdit*>(frmRumSell->Find("edtNumber1"));
  assert(editCount);
  editCount->SetIsDigit(true);

  labelPrice = dynamic_cast<CLabelEx*>(frmRumSell->Find("labTitle06"));
  assert(labelPrice);

  labelTotal = dynamic_cast<CLabelEx*>(frmRumSell->Find("labTitle07"));
  assert(labelTotal);

  labelTax = dynamic_cast<CLabelEx*>(frmRumSell->Find("labTitle08"));
  assert(labelTax);

  return true;
}

void CRumSellMgr::ShowRumSellForm(CGuiData* pSender)
{
  if(pSender)
  {
	int index = 0;
	for(; index < MAX_DEAL_COUNT; ++index)
	{
	  if(pSender == g_stRumDealForm.btnBuy[index])
		break;
	}
	if(index == MAX_DEAL_COUNT)
	  return;

	editCount->SetCaption(g_stRumDealForm.labBuyCount[index]->GetCaption());
	labelPrice->SetCaption(g_stRumDealForm.labBuyPrice[index]->GetCaption());

	BidCount = _atoi64(editCount->GetCaption());
	BidPrice = _atoi64(labelPrice->GetCaption());

	char szText[32] = {0};
	_i64toa_s(BidPrice * BidCount, szText, sizeof(szText), 10);
	labelTotal->SetCaption(szText);

	_i64toa_s(CRumDealMgr::GetIndex(false), szText, sizeof(szText), 10);
	labelTax->SetCaption(szText);

	frmRumSell->ShowModal();
  } else
	frmRumSell->Close();
}

void CRumSellMgr::FrameMove(DWORD dwTime)
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

	_i64toa_s(CRumDealMgr::GetIndex(false), szText, sizeof(szText), 10);
	labelTax->SetCaption(szText);
  }
}

void CRumSellMgr::evtSell(CGuiData* pSender, int x, int y, DWORD key)
{
  if(strcmp(g_stRumSellForm.editCount->GetCaption(), "") == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_994));
	return;
  }

  if(g_stRumSellForm.BidCount > g_stRumDealForm.CrystalCoins)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_998));
	return;
  }

  LONG64 GoldCoins = CGameScene::GetMainCha()->getGameAttr()->get(ATTR_GD);
  if(CRumDealMgr::GetIndex(false) > (g_stRumDealForm.GoldCoins + GoldCoins))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1020));
	return;
  }

  if(g_stRumSellForm.BidPrice * g_stRumSellForm.BidCount + g_stRumDealForm.GoldCoins > 2000000000)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1037));
	return;
  }

  g_stRumDealForm.DealPrice = g_stRumSellForm.BidPrice;

  CS_RequestSaleAsk(g_stRumSellForm.BidPrice, g_stRumSellForm.BidCount, 1);
  g_stRumSellForm.ShowRumSellForm(false);
}
