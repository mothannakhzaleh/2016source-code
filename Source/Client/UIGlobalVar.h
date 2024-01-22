#pragma once

#define FORM_LOADING_CHECK(a, b, c)                   \
  a = CFormMgr::s_Mgr.Find(c);                        \
  if(!a)                                              \
  {                                                   \
	::Error(RES_STRING(CL_LANGUAGE_MATCH_577), b, c); \
	return false;                                     \
  }
#define FORM_CONTROL_LOADING_CHECK(a, b, c, d, e)                   \
  a = dynamic_cast<c*>(b->Find(e));                                 \
  if(!a)                                                            \
  {                                                                 \
	::Error(RES_STRING(CL_LANGUAGE_MATCH_578), d, b->GetName(), e); \
	return false;                                                   \
  }

// 热键开关FLAG，SetEnableHotKey调用
#define HOTKEY_STORE (1 << 0) // 商城
#define HOTKEY_BANK	 (1 << 1) // 银行
#define HOTKEY_BOOTH (1 << 2) // 摆摊
#define HOTKEY_TRADE (1 << 3) // 交易

class CCharacter;
class CSceneObj;
class CEffectObj;
class CGameScene;
class CSkillRecord;
struct D3DXVECTOR3;

namespace GUI
{
class CGuiData;
class CCompent;
class CEdit;
class CListView;
class CGrid;
class CTextButton;
class CList;
class CFixList;
class CDragTitle;
class CTreeView;
class CImage;
class CCheckBox;
class CCheckGroup;
class CFrameImage;
class CLabel;
class CMemo;
class CProgressBar;
class CGuiPic;
class CLabelEx;
class CItemEx;
class CFlashImage;
class CGoodsGrid;
class COneCommand;
class CScroll;
class C3DCompent;
class CCommandObj;
class CForm;
class CMember;
class CTeam;
class CTeamMgr;
class CTreeGridNode;
class CSkillList;
class CItemCommand;
class CSkillCommand;
class CMemoEx;
class CFastCommand;
class CMenu;
class CCombo;

class CTextParse;

class CChat;
class CEditor;
class CBoxMgr;
class CTradeMgr;
class CEquipMgr;
class CMiniMapMgr;
class CSystemMgr;
class CMissionMgr;
class CMisLogForm;
class CForgeMgr;
class CNpcTradeMgr;
class CNpcTalkMgr;
class CStartMgr;
class CStateMgr;
//class CCozeMgr;
class CCozeForm;
class CBoatMgr;
class CBourseMgr;
class CUIGuildList;
class CUIGuildMgr;
class CUIGuildApply;
class CBankMgr;
class CBoothMgr;
class CHaircutMgr;
class CPkDialog;
class CMakeEquipMgr;
class CGuildChallengeMgr;
class CDoublePwdMgr;
class CStoreMgr;
class CSpiritMgr;
class CPurifyMgr;
class CBlackTradeMgr;
class CPKSilverMgr;
class CFindTeamMgr;
class CComposeMgr;
class CBreakMgr;
class CFoundMgr;
class CCookingMgr;
class CMailMgr;
class CNumAnswerMgr;
class CChurchChallengeMgr;
class AllButtonMgr;
class CBakGhostMgr;
class CItemReMgr;
class CForgeMoveMgr;
class CJewelryUpMgr;
class CRumDealMgr;
class CRumBuyMgr;
class CRumSellMgr;
class CRumPurMgr;
class CRumSaleMgr;
class CRumGetMgr;
class CHelpInfoMgr;

extern CTextParse g_TextParse;

class CUIInterface // 用户界面信息
{
  public:
  CUIInterface();
  virtual ~CUIInterface() {}

  static bool All_Init();
  static void All_End();
  static void All_FrameMove(DWORD dwTime);
  static void All_LoadingCall();
  static void All_SwitchMap();

  static void MainChaMove();

  protected:
  virtual void LoadingCall() {}
  virtual bool Init() { return true; }
  virtual void End() {}
  virtual void FrameMove(DWORD dwTime) {}
  virtual void CloseForm() {}
  virtual void SwitchMap() {}

  static void _evtDragToGoodsEvent(CGuiData* pSender, CCommandObj* pItem, int nGridID, bool& isAccept); // 拖动到道具栏

  protected:
  bool			Error(const char* strInfo, const char* strFormName, const char* strCompentName);
  static CForm* _FindForm(const char* frmName);

  private:
  static bool _evtESCKey(char& key);

  typedef vector<CUIInterface*> allmgr;
  static allmgr					all;
  static bool					_IsAllInit;
};
} // namespace GUI

#ifdef __EDITOR__
extern CEditor g_stUIEditor;
#endif
extern CChat	   g_stUIChat;
extern CBoxMgr	   g_stUIBox;
extern CTradeMgr   g_stUITrade;
extern CEquipMgr   g_stUIEquip;
extern CMiniMapMgr g_stUIMap;
extern CSystemMgr  g_stUISystem;
extern CMissionMgr g_stUIMission;
extern CMisLogForm g_stUIMisLog;
extern CForgeMgr   g_stUIForge;
extern CNpcTradeMgr g_stUINpcTrade;
extern CNpcTalkMgr	g_stUINpcTalk;
extern CStartMgr	g_stUIStart;
extern CStateMgr	g_stUIState;
//extern CCozeMgr			g_stUICoze;
extern CBoatMgr			   g_stUIBoat;
extern CBourseMgr		   g_stUIBourse;
extern CUIGuildList		   g_stUIGuildList;
extern CUIGuildMgr		   g_stUIGuildMgr;
extern CUIGuildApply	   g_stUIGuildApply;
extern CBankMgr			   g_stUIBank;
extern CBoothMgr		   g_stUIBooth;
extern CHaircutMgr		   g_stUIHaircut;
extern CPkDialog		   g_stUIPKDialog;
extern CMakeEquipMgr	   g_stUIMakeEquip;
extern CGuildChallengeMgr  g_stGuildChallenge;
extern CDoublePwdMgr	   g_stUIDoublePwd;
extern CStoreMgr		   g_stUIStore;
extern CSpiritMgr		   g_stUISpirit;
extern CPurifyMgr		   g_stUIPurify;
extern CBlackTradeMgr	   g_stUIBlackTrade;
extern CPKSilverMgr		   g_stUIPKSilver;
extern CFindTeamMgr		   g_stUIFindTeam;
extern CComposeMgr		   g_stUICompose;
extern CBreakMgr		   g_stUIBreak;
extern CFoundMgr		   g_stUIFound;
extern CCookingMgr		   g_stUICooking;
extern CMailMgr			   g_stUIMail;
extern CNumAnswerMgr	   g_stUINumAnswer;
extern CChurchChallengeMgr g_stChurchChallenge;
extern AllButtonMgr		   g_stAllButton;
extern CBakGhostMgr		   g_stBakGhostForm;
extern CItemReMgr		   g_stItemReForm;
extern CForgeMoveMgr	   g_stForgeMoveForm;
extern CJewelryUpMgr	   g_stJewelryUpForm;
extern CRumDealMgr		   g_stRumDealForm;
extern CRumBuyMgr		   g_stRumBuyForm;
extern CRumSellMgr		   g_stRumSellForm;
extern CRumPurMgr		   g_stRumPurForm;
extern CRumSaleMgr		   g_stRumSaleForm;
extern CRumGetMgr		   g_stRumGetForm;
extern CHelpInfoMgr		   g_FormHelpInfo;

//extern CChannelSwitchForm g_stUIChannelSwitch;
