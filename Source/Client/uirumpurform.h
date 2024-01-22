#pragma once

#include "UIForm.h"
#include "UIlabel.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CRumPurMgr : public CUIInterface
{
  CForm*	frmRumPur;
  CLabelEx* labelCount;
  CLabelEx* labelPrice;
  CLabelEx* labelTotal;
  CLabelEx* labelTax;

  public:
  CRumPurMgr();
  virtual ~CRumPurMgr() {}

  void ShowRumPurForm(bool bShow = true);

  private:
  virtual bool Init();

  static void evtPur(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI
