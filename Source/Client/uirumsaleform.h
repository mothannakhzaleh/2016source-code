#pragma once

#include "UIForm.h"
#include "UIlabel.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CRumSaleMgr : public CUIInterface
{
  CForm*	frmRumSale;
  CLabelEx* labelCount;
  CLabelEx* labelPrice;
  CLabelEx* labelTotal;
  CLabelEx* labelTax;

  public:
  CRumSaleMgr();
  virtual ~CRumSaleMgr() {}

  void ShowRumSaleForm(bool bShow = true);

  private:
  virtual bool Init();

  static void evtSale(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI
