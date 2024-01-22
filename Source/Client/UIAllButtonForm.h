#pragma once

#include "UIForm.h"
#include "UIGlobalVar.h"
#include "UITextButton.h"
#include "UICompent.h"
namespace GUI
{
class CItemCommand;
class CCombo;

class AllButtonMgr : public CUIInterface
{
  public:
  static void  _evtAllButtonMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);
  virtual bool Init();
  static void  evtCloseCompany(CGuiData* pSender);
  static void  evtbtnClickDown(CGuiData* pSender, int x, int y, DWORD key);

  void		  ShowAllForm(bool bShow);
  void		  GetLeaveTime(int iTime);
  void		  CloseAllForm(bool bClose);
  static void CloseAllFormButThis(string FormName);

  private:
  static int JudgeGost();

  private:
  CForm* frmAllBtn;
  CForm* frmElfCoin;
  //CTextButton*	btnTxt03;	//	这个按钮和下面的不一样。
  CTextButton*	 btnTxt01;
  CTextButton*	 btnTxt02;
  CTextButton*	 btnTxt03;
  static CCombo* cboCion1;
  static CCombo* cboCion2;
  static CCombo* cboCion3;

  CTextButton* btnHelp;

  // 装备精炼Lv5、酷装熔合Lv5、装备打磨Lv5、宝石合成Lv5、
  // 属性转移lv4、随身交易Lv4、酷装强化Lv5、
  // 离线挂机Lv1、精灵硬币提炼Lv1、装备属性重置lv4、精灵结婚lv1、背后灵产出lv1

  static const int Max_Button = 12;
  CTextButton*	   btnCommand[Max_Button];
  int			   btnCommandCondition[Max_Button];
};
} // namespace GUI