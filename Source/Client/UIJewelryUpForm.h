#pragma once

#include "UIForm.h"
#include "UIGlobalVar.h"

namespace GUI
{

class CJewelryUpMgr : public CUIInterface
{
  enum
  {
	NUM_SLOT	   = 3,
	COST_PER_LEVEL = 100000
  };

  static CForm*		  frmJewelryUp;
  static COneCommand* cmdJewelry;
  static int		  JewelryGridID;
  static short		  JewelryUpSelection;

  CLabelEx*	   txtJewelryUp[NUM_SLOT];
  CTextButton* BtnJewelryUp[NUM_SLOT];
  CLabelEx*	   labGold;

  public:
  CJewelryUpMgr() {}
  virtual ~CJewelryUpMgr() {}

  void ShowConfirmDialog(long OldJeyID, long OldJeyLev, long NewJeyID, long NewJeyLev);

  private:
  virtual bool Init();

  void Clear();
  void PushItem(CItemCommand& Item);
  void PopItem();

  static void evtJewelryUpFormShow(CGuiData* pSender);
  static void evtJewelryUpFormClose(CForm* pForm, bool& IsClose);
  static void evtSetJewelryEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept);
  static void evtJewelryUpCommit(CGuiData* pSender, int x, int y, DWORD key);
  static void evtConfirmEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);
  static void evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key);
};

} // namespace GUI