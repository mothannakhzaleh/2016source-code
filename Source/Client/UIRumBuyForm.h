#pragma once

#include "UIform.h"
#include "UIedit.h"
#include "UIlabel.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CRumBuyMgr : public CUIInterface
{
  CForm*	frmRumBuy;
  CEdit*	editCount;
  CLabelEx* labelPrice;
  CLabelEx* labelTotal;
  CLabelEx* labelTax;

  LONG BidCount;

  public:
  LONG BidPrice;

  public:
  CRumBuyMgr();
  virtual ~CRumBuyMgr() {}

  void ShowRumBuyForm(CGuiData* pSender);

  private:
  virtual bool Init();
  virtual void FrameMove(DWORD dwTime);

  static void evtBuy(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI
