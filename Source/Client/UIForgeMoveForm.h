#pragma once

#include "UIForm.h"
#include "UIGlobalVar.h"

namespace GUI
{
class CForgeMoveMgr : public CUIInterface
{
  enum
  {
	REQUIRED_ITEM_COUNT = 3
  };

  struct ItemputStruct
  {
	COneCommand*  OneCommand;
	CItemCommand* ItemCommand;
  };

  CForm* frmforgeMove;

  static int		   FORGE_MOVE_ID;
  static COneCommand*  cmdRequirement[REQUIRED_ITEM_COUNT];
  static int		   RequirementGridIDs[REQUIRED_ITEM_COUNT];
  static int		   RequirementCounts[REQUIRED_ITEM_COUNT];
  static ItemputStruct Itemput;

  static CTextButton* btnYes;

  public:
  CForgeMoveMgr() :
	  frmforgeMove(NULL) {}
  virtual ~CForgeMoveMgr() {}

  void ForgeMoveResponse(bool Success);

  private:
  virtual bool Init();

  void Clear();
  void PushItem(int Index, CItemCommand& Item);
  void PopItem(int Index);

  static void evtForgeMoveFormShow(CGuiData* pSender);
  static void evtForgeMoveFormClose(CForm* pForm, bool& IsClose);
  static void evtRequirementEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept);
  static void evtForgeMove(CGuiData* pSender, int x, int y, DWORD key);
  static void evtThrowDialogEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void PutRequirementEvent(ItemputStruct* pItemput, int ItemCount);
  static void evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key);
};

} // namespace GUI
