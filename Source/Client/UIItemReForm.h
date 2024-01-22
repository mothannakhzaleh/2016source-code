#pragma once

#include "UIForm.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CItemReMgr : public CUIInterface
{
  enum
  {
	REQUIRED_ITEM_COUNT = 3
  };

  CForm* frmItemRe;

  static int		  ITEM_RESET_ID;
  static COneCommand* cmdRequirement[REQUIRED_ITEM_COUNT];
  static int		  RequirementGridIDs[REQUIRED_ITEM_COUNT];
  static CTextButton* btnAccept;

  public:
  CItemReMgr() :
	  frmItemRe(NULL) {}
  virtual ~CItemReMgr() {}

  void ShowItemRe(bool bShow = true);

  void ItemResetResponse(bool Success);

  private:
  virtual bool Init();

  void Clear();

  void PushItem(int Index, CItemCommand& Item);
  void PopItem(int Index);

  static void evtItemReFormClose(CForm* pForm, bool& IsClose);
  static void evtRequirementEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept);
  static void evtItemReset(CGuiData* pSender, int x, int y, DWORD key);
  static void evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key);
};
} // namespace GUI