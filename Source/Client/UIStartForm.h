#pragma once
#include "UIGlobalVar.h"
#include "ChaState.h" //add by alfred.shi 20080709
#include "uipage.h"	  //add by alfred.shi 20080709

class CCharacter2D;
struct stNetChangeChaPart;
namespace GUI
{

class CTitle;
class CImage;
class CItemCommand;
class CCombo;
class CForgeMgr;

struct stNumBox;

// 开始菜单
class CStartMgr : public CUIInterface
{
  static const int NO_USE = -1;
  static const int xxoo	  = 2;

  public:
  void MainChaDied();

  void RefreshMainLifeNum(long num, long max);
  void RefreshMainExperience(LONG64 num, LONG64 curlev, LONG64 nextlev);
  void RefreshMainSP(long num, long max);
  void RefreshMainName(const char* szName);
  void RefreshLeftTimeName(int szTime);
  void RefreshLeftExpName(short sSelectTime, string BaseExp, string AddExp, string TotalExp, string UpLevel, string addPercent, short sNum, string amplitude, short coin);
  void RefreshMainFace(stNetChangeChaPart& stPart);

  void RefreshPet(CItemCommand* pItem);

  void SetIsLeader(bool v);
  bool GetIsLeader();

  void RefreshLv(long l);
  void PopMenu(CCharacter* pCha);

  void CloseForm();
  void CheckMouseDown(int x, int y);
  void ShowBigText(const char* str);

  void ShowQueryReliveForm(int nType, const char* str); // 显示是否原地复活框

  void ShowShipSailForm(bool isShow = true);
  void UpdateShipSailForm();

  void SetIsNewer(bool v) { _IsNewer = v; }

  void SysLabel(const char* pszFormat, ...);
  void SysHide();

  void AskTeamFight(const char* str);

  bool IsCanTeam() { return _IsCanTeam; }
  void SetIsCanTeam(bool v) { _IsCanTeam = v; }
  bool IsCanTeamAndInfo();

  void ShowHelpSystem(bool bShow = true, int nIndex = -1);
  void ShowLevelUpHelpButton(bool bShow = true);
  void ShowLevelUpaddButton(bool bShow = true); //	Add by alfred.shi

  void		  ShowAfkButton(bool bShow = true);		  //	挂机
  static void EventSendTimeChange(CGuiData* pSender); //	挂机经验选择事件
  void		  ShowExpForm(bool bShow = true);		  //	挂机

  void ShowInfoCenterButton(bool bShow = true);

  void ShowBagButtonForm(bool bShow = true);
  void ShowSociliatyButtonForm(bool bShow = true);

  static CTextButton* GetShowQQButton();

  // NPC指引 add by alfred.shi 20080709
  void		  ShowNPCHelper(const char* mapName, bool isShow /*= true*/);
  const char* GetCurrMapName() { return strMapName; }
  //女神按钮界面 add by alfred.shi 20080724;
  //CForm*			frmQueen;
  void		 ShowQueenButtonForm(bool isShow = true);
  CList*	 GetNpcList() { return lstNpcList; }
  CCheckBox* chkID;
  //end

  virtual void ClearCommand(bool bRetry = false);
  CGoodsGrid*  GetRequestGrid() { return grdDaoJu; }

  protected:
  virtual bool Init();
  virtual void End();
  virtual void FrameMove(DWORD dwTime);
  virtual void SwitchMap();
  virtual void PushItem(int iIndex, CItemCommand& rItem, bool bRetry = false);
  virtual void PopItem(int iIndex, bool bRetry = false);

  private:
  static void _evtStartFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void _evtFormMouseClick(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey); //	挂机

  static void _evtReliveFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void _evtTaskMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  // 队伍单挑的对话框回调
  static void _evtAskTeamFightMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void _evtChaActionChange(CGuiData* pSender); //改变角色的动画
  static void _evtChaHeartChange(CGuiData* pSender);  //改变角色的心情

  static void _evtPopMenu(CGuiData* pSender, int x, int y, DWORD key);

  static void _evtSelfMouseDown(CGuiData* pSender, int x, int y, DWORD key); // 给自己加血事件

  static void _evtOriginReliveFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void _evtShowBoatAttr(CGuiData* pSender, int x, int y, DWORD key); // 显示船只属性

  static void _NewFrmMainMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void _HelpFrmMainMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  static void _CloseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  //static const int HELP_PICTURE_COUNT = 68;	// 新手帮助主题个数
  static const int HELP_PICTURE_COUNT = 84; // 新手帮助主题个数 Modify by sunny.sun 20080828
  static const int HELP_LV1_BEGIN	  = 28; // Level1的图片下标

  private:
  CForm* frmMain800;

  CForm* frmMainFun;
  //CTextButton*	btnStart;
  static CTextButton* btnQQ;

  //玩家自己的血条，sp， exp和名字
  CForm*		frmDetail;
  CProgressBar* proMainHP;
  CProgressBar* proMainSP;
  CProgressBar* proMainExp;
  CLabel*		labMainName;
  CLabel*		labMainLevel;
  CImage*		imgLeader;

  //   CProgressBar*	proMainHP1;		//角色的生命值
  //CProgressBar*	proMainHP2;		//角色的生命值
  //CProgressBar*	proMainHP3;		//角色的生命值
  //CProgressBar*	proMainSP;		//角色的生命值

  // 玩家经验，等级
  //CLabel*			_pShowExp;
  //CLabel*			_pShowLevel;

  CForm* frmMainChaRelive; // 主角复活表单

  // 表情,动作
  CGrid* grdAction;
  CGrid* grdHeart;

  // 显示大标题
  CTitle* tlCity;
  CTitle* tlField;

  // 场景中的右键菜单
  static CMenu* mainMouseRight;

  //船只航行时的界面
  CForm*		frmShipSail;
  CLabelEx*		labCanonShow;
  CLabelEx*		labSailorShow;
  CLabelEx*		labLevelShow;
  CLabelEx*		labExpShow;
  CProgressBar* proSailor; //耐久滚动条
  CProgressBar* proCanon;  //补给滚动条

  bool _IsNewer; // 是否为新手

  // 显示自动跟随提示
  CForm*  frmFollow;
  CLabel* labFollow;

  CMenu* mnuSelf;

  bool _IsCanTeam; // 是否能够使用组队离队等与队伍相关的操作

  // 宠物界面
  CForm*		frmMainPet;
  CImage*		imgPetHead;
  CLabel*		labPetLv;
  CProgressBar* proPetHP;
  CProgressBar* proPetSP;

  // 新手帮助界面
  CForm*	   frmHelpSystem;  // 帮助界面
  CTextButton* btnLevelUpHelp; // 升级帮助按钮
  CTextButton* btnLevelUpadd;  // 升级属性
  CList*	   lstHelpList;	   // 帮助列表

  //	挂机
  stNumBox*			 m_NumBox;
  CTextButton*		 btnafk; //	挂机按钮
  CForm*			 frmElfAfk;
  CLabel*			 labelfexp; //	显示挂机时间
  CTextButton*		 btnelfafkYes;
  COneCommand*		 cmdexpItem[xxoo]; //	拖放经验加成道具
  int				 iPutPos[xxoo];
  CForm*			 frmElfchat;
  CTextButton*		 btnClose;
  CLabel*			 ElfTxt02;
  CLabel*			 ElfTxt04;
  CLabel*			 ElfTxt06;
  CLabel*			 ElfTxt08;
  CLabel*			 ElfTxt10;
  CLabel*			 ElfTxt12;
  CLabel*			 ElfTxt14;
  static CCombo*	 cboexp;
  static CForm*		 frmDaoJu; //交易左边的道具表单(或船舱)
  static CGoodsGrid* grdDaoJu;
  //	end

  CImage* imgHelpShow1[HELP_PICTURE_COUNT]; // 图片
  CImage* imgHelpShow2[HELP_PICTURE_COUNT]; // 图片
  CImage* imgHelpShow3[HELP_PICTURE_COUNT]; // 图片
  CImage* imgHelpShow4[HELP_PICTURE_COUNT]; // 图片

  // 背包按钮界面
  CForm* frmBag;

  // 社交按钮界面
  CForm* frmSociliaty;
  //女神按钮界面 add by alfred.shi 20080724
  CForm* frmQueen;

  // NPC指引界面 add by alfred.shi 20080709
  CForm* frmNpcShow;
  CPage* listPage;
  CList* lstNpcList;
  CList* lstMonsterList;
  //CList*			lstBOSSList;
  CList*	  lstCurrList;
  const char* strMapName;

  private:
  // 对应的主角外观
  static CCharacter2D* pMainCha;
  static void		   _MainChaRenderEvent(C3DCompent* pSender, int x, int y);
  static void		   _OnSelfMenu(CGuiData* pSender, int x, int y, DWORD key);

  static void _evtHelpListChange(CGuiData* pSender);
  static void _evtNPCListChange(CGuiData* pSender);	  // add by alfred.shi 20080709
  static void _evtPageIndexChange(CGuiData* pSender); // add by alfred.shi 20080709
  static void _evtDragExpItem(CGuiData* pSender, CCommandObj* pItem, bool& isAccept);
  static void _evtCloseExpFrm(CForm* pForm, bool& IsClose);

  static void _evtOOXXEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);
};

} // namespace GUI
