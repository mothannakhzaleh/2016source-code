#pragma once

#include "UIForm.h"
#include "UIedit.h"
#include "UIlabel.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CRumSellMgr : public CUIInterface
{
  CForm*	frmRumSell;
  CEdit*	editCount;
  CLabelEx* labelPrice;
  CLabelEx* labelTotal;
  CLabelEx* labelTax;

  LONG BidCount;

  public:
  LONG BidPrice;

  public:
  CRumSellMgr();
  virtual ~CRumSellMgr() {}

  void ShowRumSellForm(CGuiData* pSender);

  private:
  virtual bool Init();
  virtual void FrameMove(DWORD dwTime);

  static void evtSell(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI
