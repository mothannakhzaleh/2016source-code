#pragma once

#include "UIGlobalVar.h"
#include "PacketCmd.h"

#define MAX_DEAL_COUNT 5

namespace GUI
{
class CRumDealMgr : public CUIInterface
{
  friend class CRumBuyMgr;
  friend class CRumSellMgr;
  friend class CRumGetMgr;
  friend class CRumSaleMgr;
  friend class CRumPurMgr;

  CForm* frmRumDeal;

  CLabelEx* labSellIndex;

  CLabelEx*	   labMySellCount;
  CLabelEx*	   labMySellPrice;
  CTextButton* btnSellCancel;

  CEdit*	   editSellCount;
  CEdit*	   editSellPrice;
  CLabelEx*	   labSellTotal;
  CLabelEx*	   labSellTax;
  CTextButton* btnSellConmmit;

  CLabelEx* labBuyIndex;

  CLabelEx*	   labMyBuyCount;
  CLabelEx*	   labMyBuyPrice;
  CTextButton* btnBuyCancel;

  CEdit*	   editBuyCount;
  CEdit*	   editBuyPrice;
  CLabelEx*	   labBuyTotal;
  CLabelEx*	   labBuyTax;
  CTextButton* btnBuyConmmit;

  CLabelEx*	   labCrystal;
  CLabelEx*	   labGold;
  CTextButton* btnRefresh;
  CTextButton* btnGetMoney;

  LONG64 GoldCoins;
  LONG64 CrystalCoins;
  LONG64 SellBidCount;
  LONG64 SellBidPrice;
  LONG	 BuyBidCount;
  LONG	 BuyBidPrice;

  short TotalSellSize;
  short TotalBuySize;
  short CancelType;

  public:
  CLabelEx*	   labSellCount[MAX_DEAL_COUNT];
  CLabelEx*	   labSellPrice[MAX_DEAL_COUNT];
  CTextButton* btnSell[MAX_DEAL_COUNT];

  CLabelEx*	   labBuyCount[MAX_DEAL_COUNT];
  CLabelEx*	   labBuyPrice[MAX_DEAL_COUNT];
  CTextButton* btnBuy[MAX_DEAL_COUNT];

  LONG64 DealPrice;

  public:
  CRumDealMgr();
  virtual ~CRumDealMgr() {}

  bool IsOpen();

  void RumDealOpenCheck();
  void AddSellInfo(uChar SellListSize, LONG64* SellPrices, LONG64* SellCounts);
  void AddBuyInfo(uChar BuyListSize, LONG64* BuyPrices, LONG64* BuyCounts);
  void AddMyDealInfo(uChar MyDealSize, LONG64* MyDealPrices, LONG64* MyDealCounts, short* MyDealTypes, LONG64* MyDealTotalPrices);
  void AddMyDealInfo(LONG64 InCrystalCoins, LONG64 InGoldCoins);
  void ShowRumDealForm(bool bShow = true);
  void SetTradeIndex(short buySize, short sellSize);

  static int GetIndex(bool BuyTrade);

  private:
  virtual bool Init();
  virtual void FrameMove(DWORD dwTime);

  static void evtShowBuyForm(CGuiData* pSender, int x, int y, DWORD key);
  static void evtShowSellForm(CGuiData* pSender, int x, int y, DWORD key);
  static void evtShowMsgBox(CGuiData* pSender, int x, int y, DWORD key);
  static void evtShowGetForm(CGuiData* pSender, int x, int y, DWORD key);
  static void evtRefreshForm(CGuiData* pSender, int x, int y, DWORD key);
  static void evtConfirmEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);
  static void evtDealFormClose(CForm* pForm, bool& IsClose);
  static void evtSell(CGuiData* pSender, int x, int y, DWORD key);
  static void evtBuy(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI
