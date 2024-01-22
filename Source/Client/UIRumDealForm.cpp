#include "stdafx.h"
#include "uirumdealform.h"
#include "uilistview.h"

#include "uidoublepwdform.h"
#include "uiboxform.h"

#include "uirumbuyform.h"
#include "uirumsellform.h"
#include "uirumpurform.h"
#include "uirumsaleform.h"
#include "uirumgetform.h"
#include "uiequipform.h"
#include "gameapp.h"
#include "character.h"

using namespace GUI;

CRumDealMgr::CRumDealMgr() :
	CUIInterface(),
	frmRumDeal(NULL),
	labSellIndex(NULL),
	labMySellCount(NULL),
	labMySellPrice(NULL),
	btnSellCancel(NULL),
	editSellCount(NULL),
	editSellPrice(NULL),
	labSellTotal(NULL),
	labSellTax(NULL),
	btnSellConmmit(NULL),
	labBuyIndex(NULL),
	labMyBuyCount(NULL),
	labMyBuyPrice(NULL),
	btnBuyCancel(NULL),
	editBuyCount(NULL),
	editBuyPrice(NULL),
	labBuyTotal(NULL),
	labBuyTax(NULL),
	btnBuyConmmit(NULL),
	labCrystal(NULL),
	labGold(NULL),
	btnRefresh(NULL),
	btnGetMoney(NULL),
	GoldCoins(0),
	CrystalCoins(0),
	SellBidCount(0),
	SellBidPrice(0),
	BuyBidCount(0),
	BuyBidPrice(0),
	DealPrice(0),
	TotalSellSize(0),
	TotalBuySize(0),
	CancelType(-1)
{
  for(int i = 0; i < MAX_DEAL_COUNT; ++i)
  {
	labSellCount[i] = NULL;
	labSellPrice[i] = NULL;
	btnSell[i]		= NULL;

	labBuyCount[i] = NULL;
	labBuyPrice[i] = NULL;
	btnBuy[i]	   = NULL;
  }
}

bool CRumDealMgr::Init()
{
#ifndef SHUI_JING
  return true;
#endif

  frmRumDeal = _FindForm("frmRumDeal");
  if(!frmRumDeal)
	return false;

  frmRumDeal->evtClose = evtDealFormClose;

  char szText[MAX_PATH] = {0};

  for(int i = 0; i < MAX_DEAL_COUNT; ++i)
  {
	_snprintf_s(szText, _countof(szText), _TRUNCATE, "labcount_%d", i);
	labSellCount[i] = dynamic_cast<CLabelEx*>(frmRumDeal->Find(szText));
	assert(labSellCount[i]);

	_snprintf_s(szText, _countof(szText), _TRUNCATE, "labprice_%d", i);
	labSellPrice[i] = dynamic_cast<CLabelEx*>(frmRumDeal->Find(szText));
	assert(labSellPrice[i]);

	_snprintf_s(szText, _countof(szText), _TRUNCATE, "btnbuy_%d", i);
	btnSell[i] = dynamic_cast<CTextButton*>(frmRumDeal->Find(szText));
	assert(btnSell[i]);
	btnSell[i]->evtMouseClick = evtShowBuyForm;

	_snprintf_s(szText, _countof(szText), _TRUNCATE, "labncount_%d", i);
	labBuyCount[i] = dynamic_cast<CLabelEx*>(frmRumDeal->Find(szText));
	assert(labBuyCount[i]);

	_snprintf_s(szText, _countof(szText), _TRUNCATE, "labnprice_%d", i);
	labBuyPrice[i] = dynamic_cast<CLabelEx*>(frmRumDeal->Find(szText));
	assert(labBuyPrice[i]);

	_snprintf_s(szText, _countof(szText), _TRUNCATE, "btnsell_%d", i);
	btnBuy[i] = dynamic_cast<CTextButton*>(frmRumDeal->Find(szText));
	assert(btnBuy[i]);
	btnBuy[i]->evtMouseClick = evtShowSellForm;
  }

  labSellIndex = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labcommission2"));
  assert(labSellIndex);

  labMySellCount = dynamic_cast<CLabelEx*>(frmRumDeal->Find("mysend1"));
  assert(labMySellCount);
  labMySellPrice = dynamic_cast<CLabelEx*>(frmRumDeal->Find("mysend2"));
  assert(labMySellPrice);
  btnSellCancel = dynamic_cast<CTextButton*>(frmRumDeal->Find("btncancle01"));
  assert(btnSellCancel);
  btnSellCancel->evtMouseClick = evtShowMsgBox;

  editSellCount = dynamic_cast<CEdit*>(frmRumDeal->Find("labcrstal01"));
  assert(editSellCount);
  editSellCount->SetIsDigit(true);
  editSellCount->SetCaption("");
  editSellPrice = dynamic_cast<CEdit*>(frmRumDeal->Find("labcrstal02"));
  assert(editSellPrice);
  editSellPrice->SetIsDigit(true);
  editSellPrice->SetCaption("");
  labSellTotal = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labcrstal03"));
  assert(labSellTotal);
  labSellTotal->SetCaption("");
  labSellTax = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labcrstal04"));
  assert(labSellTax);
  labSellTax->SetCaption("");
  btnSellConmmit = dynamic_cast<CTextButton*>(frmRumDeal->Find("btnguadan01"));
  assert(btnSellConmmit);
  btnSellConmmit->evtMouseClick = evtSell;

  labBuyIndex = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labcommission4"));
  assert(labBuyIndex);

  labMyBuyCount = dynamic_cast<CLabelEx*>(frmRumDeal->Find("myask1"));
  assert(labMyBuyCount);
  labMyBuyPrice = dynamic_cast<CLabelEx*>(frmRumDeal->Find("myask2"));
  assert(labMyBuyPrice);
  btnBuyCancel = dynamic_cast<CTextButton*>(frmRumDeal->Find("btncancle02"));
  assert(btnBuyCancel);
  btnBuyCancel->evtMouseClick = evtShowMsgBox;

  editBuyCount = dynamic_cast<CEdit*>(frmRumDeal->Find("labcrstal11"));
  assert(editBuyCount);
  editBuyCount->SetIsDigit(true);
  editBuyCount->SetCaption("");
  editBuyPrice = dynamic_cast<CEdit*>(frmRumDeal->Find("labcrstal12"));
  assert(editBuyPrice);
  editBuyPrice->SetIsDigit(true);
  editBuyPrice->SetCaption("");
  labBuyTotal = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labcrstal13"));
  assert(labBuyTotal);
  labBuyTotal->SetCaption("");
  labBuyTax = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labcrstal14"));
  assert(labBuyTax);
  labBuyTax->SetCaption("");
  btnBuyConmmit = dynamic_cast<CTextButton*>(frmRumDeal->Find("btnguadan02"));
  assert(btnBuyConmmit);
  btnBuyConmmit->evtMouseClick = evtBuy;

  labCrystal = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labGold02"));
  assert(labCrystal);
  labGold = dynamic_cast<CLabelEx*>(frmRumDeal->Find("labGold03"));
  assert(labGold);
  btnRefresh = static_cast<CTextButton*>(frmRumDeal->Find("btnDealF5"));
  assert(btnRefresh);
  btnRefresh->evtMouseClick = evtRefreshForm;
  btnGetMoney				= static_cast<CTextButton*>(frmRumDeal->Find("btnDeal04"));
  assert(btnGetMoney);
  btnGetMoney->evtMouseClick = evtShowGetForm;

  return true;
}

void CRumDealMgr::FrameMove(DWORD dwTime)
{
  if(!labBuyTax)
	return;

  const char* SellCount	   = editSellCount->GetCaption();
  LONG64	  CurSellCount = _atoi64(SellCount);

  const char* SellPrice	   = editSellPrice->GetCaption();
  LONG64	  CurSellPrice = _atoi64(SellPrice);

  if(SellBidCount != CurSellCount || SellBidPrice != CurSellPrice)
  {
	SellBidPrice = CurSellPrice;
	SellBidCount = CurSellCount;

	char szText[32] = {0};
	_i64toa_s(SellBidPrice * SellBidCount, szText, sizeof(szText), 10);
	labSellTotal->SetCaption(szText);

	_itoa_s(GetIndex(false), szText, sizeof(szText), 10);
	labSellTax->SetCaption(szText);
  }

  const char* BuyCount	  = editBuyCount->GetCaption();
  LONG64	  CurBuyCount = _atoi64(BuyCount);

  const char* BuyPrice	  = editBuyPrice->GetCaption();
  LONG64	  CurBuyPrice = _atoi64(BuyPrice);

  if(BuyBidCount != CurBuyCount || BuyBidPrice != CurBuyPrice)
  {
	BuyBidPrice = CurBuyPrice;
	BuyBidCount = CurBuyCount;

	char szText[32] = {0};
	_i64toa_s(BuyBidPrice * BuyBidCount, szText, sizeof(szText), 10);
	labBuyTotal->SetCaption(szText);

	_itoa_s(GetIndex(true), szText, sizeof(szText), 10);
	labBuyTax->SetCaption(szText);
  }
}

bool GUI::CRumDealMgr::IsOpen()
{
  assert(frmRumDeal);
  return frmRumDeal->GetIsShow();
}

void CRumDealMgr::RumDealOpenCheck()
{
  g_stUIDoublePwd.SetType(CDoublePwdMgr::SHOW_EXCHANGEFORM);
  g_stUIDoublePwd.ShowDoublePwdForm();
}

void CRumDealMgr::AddSellInfo(uChar SellListSize, LONG64* SellPrices, LONG64* SellCounts)
{
  char szText[32] = {0};

  for(int i = 0; i < SellListSize && i < MAX_DEAL_COUNT; i++)
  {
	_i64toa_s(SellCounts[i], szText, sizeof(szText), 10);
	labSellCount[i]->SetCaption(szText);

	_i64toa_s(SellPrices[i], szText, sizeof(szText), 10);
	labSellPrice[i]->SetCaption(szText);

	btnSell[i]->SetIsShow(true);
  }

  for(int i = SellListSize; i < MAX_DEAL_COUNT; i++)
  {
	labSellCount[i]->SetCaption("");
	labSellPrice[i]->SetCaption("");
	btnSell[i]->SetIsShow(false);
  }
}

void CRumDealMgr::AddBuyInfo(uChar BuyListSize, LONG64* BuyPrices, LONG64* BuyCounts)
{
  char szText[32] = {0};

  for(int i = 0; i < BuyListSize && i < MAX_DEAL_COUNT; i++)
  {
	_i64toa_s(BuyCounts[i], szText, sizeof(szText), 10);
	labBuyCount[i]->SetCaption(szText);

	_i64toa_s(BuyPrices[i], szText, sizeof(szText), 10);
	labBuyPrice[i]->SetCaption(szText);

	btnBuy[i]->SetIsShow(true);
  }

  for(int i = BuyListSize; i < MAX_DEAL_COUNT; i++)
  {
	labBuyCount[i]->SetCaption("");
	labBuyPrice[i]->SetCaption("");
	btnBuy[i]->SetIsShow(false);
  }
}

void CRumDealMgr::AddMyDealInfo(uChar MyDealSize, LONG64* MyDealPrices, LONG64* MyDealCounts, short* MyDealTypes, LONG64* MyDealTotalPrices)
{
  labMyBuyCount->SetCaption("");
  labMyBuyPrice->SetCaption("");
  btnBuyCancel->SetIsShow(false);

  labMySellCount->SetCaption("");
  labMySellPrice->SetCaption("");
  btnSellCancel->SetIsShow(false);

  char szText[32] = {0};

  for(int i = 0; i < MyDealSize; i++)
  {
	if(MyDealTypes[i] == 0)
	{
	  _i64toa_s(MyDealCounts[i], szText, sizeof(szText), 10);
	  labMyBuyCount->SetCaption(szText);

	  _i64toa_s(MyDealPrices[i], szText, sizeof(szText), 10);
	  labMyBuyPrice->SetCaption(szText);

	  btnBuyCancel->SetIsShow(true);

	  BuyBidPrice = MyDealPrices[i];
	} else
	{
	  _i64toa_s(MyDealCounts[i], szText, sizeof(szText), 10);
	  labMySellCount->SetCaption(szText);

	  _i64toa_s(MyDealPrices[i], szText, sizeof(szText), 10);
	  labMySellPrice->SetCaption(szText);

	  btnSellCancel->SetIsShow(true);

	  SellBidPrice = MyDealPrices[i];
	}
  }
}

void CRumDealMgr::AddMyDealInfo(LONG64 InCrystalCoins, LONG64 InGoldCoins)
{
  CrystalCoins = InCrystalCoins;
  GoldCoins	   = InGoldCoins;

  char szText[32] = {0};

  _i64toa_s(CrystalCoins, szText, sizeof(szText), 10);
  labCrystal->SetCaption(szText);

  _i64toa_s(GoldCoins, szText, sizeof(szText), 10);
  labGold->SetCaption(szText);
}

void CRumDealMgr::ShowRumDealForm(bool bShow)
{
  CFormMgr::s_Mgr.SetEnableHotKey(1, !bShow);

  CForm* frmEquip = g_stUIEquip.GetItemForm();
  if(bShow)
  {
	frmRumDeal->ShowModal();
	int xpos = GetRender().GetScreenWidth() - frmEquip->GetWidth() - 10;
	int ypos = GetRender().GetScreenHeight() - frmEquip->GetHeight() - 40;
	frmEquip->SetPos(xpos, ypos);
	frmEquip->Refresh();
  } else
  {
	frmRumDeal->Close();
	g_stRumBuyForm.ShowRumBuyForm(NULL);
	g_stRumSellForm.ShowRumSellForm(NULL);
	g_stRumGetForm.ShowRumGetForm(false);
  }

  frmEquip->SetIsShow(frmRumDeal->GetIsShow());
}

void CRumDealMgr::evtShowBuyForm(CGuiData* pSender, int x, int y, DWORD key)
{
  g_stRumBuyForm.ShowRumBuyForm(pSender);
}

void CRumDealMgr::evtShowSellForm(CGuiData* pSender, int x, int y, DWORD key)
{
  g_stRumSellForm.ShowRumSellForm(pSender);
}

void CRumDealMgr::evtShowMsgBox(CGuiData* pSender, int x, int y, DWORD key)
{
  if(pSender == g_stRumDealForm.btnBuyCancel)
	g_stRumDealForm.CancelType = 0;
  else
	g_stRumDealForm.CancelType = 1;

  g_stUIBox.ShowSelectBox(evtConfirmEvent, RES_STRING(CL_LANGUAGE_MATCH_996), true);
}

void CRumDealMgr::evtShowGetForm(CGuiData* pSender, int x, int y, DWORD key)
{
  g_stRumGetForm.ShowRumGetForm();
}

void CRumDealMgr::evtConfirmEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType == CForm::mrYes)
	CS_RequestCancelAsk(g_stRumDealForm.CancelType);
}

void CRumDealMgr::evtDealFormClose(CForm* pForm, bool& IsClose)
{
  g_stRumBuyForm.ShowRumBuyForm(NULL);
  g_stRumSellForm.ShowRumSellForm(NULL);
  g_stRumGetForm.ShowRumGetForm(false);
  g_stRumSaleForm.ShowRumSaleForm(false);
  g_stRumPurForm.ShowRumPurForm(false);

  CForm* frmEquip = g_stUIEquip.GetItemForm();
  frmEquip->SetIsShow(false);

  CFormMgr::s_Mgr.SetEnableHotKey(1, true);

  IsClose = false;
}

void CRumDealMgr::evtRefreshForm(CGuiData* pSender, int x, int y, DWORD key)
{
  CS_RequestRefresh();
}

void CRumDealMgr::evtSell(CGuiData* pSender, int x, int y, DWORD key)
{
  if(strcmp(g_stRumDealForm.editSellCount->GetCaption(), "") == 0 ||
	 strcmp(g_stRumDealForm.editSellPrice->GetCaption(), "") == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_993));
	return;
  } else if(strcmp(g_stRumDealForm.editSellCount->GetCaption(), "0") == 0 ||
			strcmp(g_stRumDealForm.editSellPrice->GetCaption(), "0") == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1044));
	return;
  }

  g_stRumSaleForm.ShowRumSaleForm();
}

void CRumDealMgr::evtBuy(CGuiData* pSender, int x, int y, DWORD key)
{
  if(strcmp(g_stRumDealForm.editBuyCount->GetCaption(), "") == 0 ||
	 strcmp(g_stRumDealForm.editBuyPrice->GetCaption(), "") == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_993));
	return;
  } else if(strcmp(g_stRumDealForm.editBuyCount->GetCaption(), "0") == 0 ||
			strcmp(g_stRumDealForm.editBuyPrice->GetCaption(), "0") == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1044));
	return;
  }

  g_stRumPurForm.ShowRumPurForm();
}

void CRumDealMgr::SetTradeIndex(short buySize, short sellSize)
{
  TotalBuySize	= buySize;
  TotalSellSize = sellSize;

  char szText[32] = {0};

  _itoa_s(GetIndex(true), szText, sizeof(szText), 10);
  labBuyIndex->SetCaption(szText);
  if(BuyBidCount != 0)
	labBuyTax->SetCaption(szText);
  else
	labBuyTax->SetCaption("");

  _itoa_s(GetIndex(false), szText, sizeof(szText), 10);
  labSellIndex->SetCaption(szText);
  labSellTax->SetCaption(szText);
  if(SellBidCount != 0)
	labSellTax->SetCaption(szText);
  else
	labSellTax->SetCaption("");
}

int CRumDealMgr::GetIndex(bool BuyTrade)
{
  short DealSize = BuyTrade ? g_stRumDealForm.TotalBuySize : g_stRumDealForm.TotalSellSize;

  if(DealSize <= 50)
	return 10500;
  else if(DealSize <= 100)
	return 14000;
  else if(DealSize <= 150)
	return 20500;
  else if(DealSize <= 200)
	return 30000;
  else if(DealSize <= 250)
	return 42500;
  else if(DealSize < 300)
	return 58000;
  else if(DealSize < 350)
	return 76500;
  else
	return 98000;
}