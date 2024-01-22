#pragma once

#include "UIForm.h"
#include "UIedit.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CRumGetMgr : public CUIInterface
{
  CForm* frmRumGet;
  CEdit* editMoeny2Get;

  public:
  CRumGetMgr() :
	  frmRumGet(NULL), editMoeny2Get(NULL) {}
  virtual ~CRumGetMgr() {}

  void ShowRumGetForm(bool bShow = true);

  private:
  virtual bool Init();

  static void evtGetFlatMoney(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI
