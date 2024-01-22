#pragma once
#include "UIGlobalVar.h"
#include "Scene.h"
#include "UICursor.h"
#include "scenelight.h"
#include "LEFont.h"
#include "mousedown.h"
#include "uiguidata.h"
#include "NetProtocol.h"

class xShipMgr;
class xShipMgrCShipBuilder;
class CEvent;

class CWorldScene : public CGameScene
{
  protected:
  virtual bool _Init();
  virtual bool _Clear();
  virtual void _Render();
  virtual void _FrameMove(DWORD dwTimeParam);

  virtual bool _HandleSuperKey();
  virtual void _KeyDownEvent(int key);
  virtual bool _MouseButtonDown(int nButton);
  virtual bool _MouseButtonUp(int nButton);
  virtual bool _MouseMove(int nOffsetX, int nOffsetY);
  virtual bool _MouseButtonDB(int nButton);

  public:
  virtual void SetMainCha(int nChaID);
  virtual void SetScreen(int w, int h, bool IsFull);
  static void  SetAttackChaColor(BYTE r, BYTE g, BYTE b);

  virtual void		  LoadingCall(); // 在装载loading后,刷新
  static CWorldScene& GetCurrScene();

  public:
  CWorldScene(stSceneInitParam& param);
  ~CWorldScene();

  AnimCtrlLight* GetAnimLight(DWORD id) { return (id >= _dwAnimLightNum) ? 0 : &_pAnimLightSeq[id]; }
  int			 SwitchShipBuilder();

  xShipMgr* GetShipMgr() { return _pShipMgr; }

  CCharacter* HitSelectCharacter(int nScrX, int nScrY, int nSelect = 0); // nSelect为选择范围,参看CCharacter.h-eSelectCha

  CMouseDown& GetMouseDown() { return _cMouseDown; }

  int  PickItem();
  void ClearSelectUI();

  protected:
  BOOL _LoadAnimLight(const char* file);
  void _SceneCursor();
  BOOL _InitUI();
  BOOL _InitSelectUI();
  bool _IsBlock(CCharacter* pCha, int x, int y);

  static void _SelChaFrmMouseEvent(CCompent* pSender, int nMsgType,
								   int x, int y, DWORD dwKey);

  static void _evtCreateDoublePwdEvent(CCompent* pSender, int nMsgType,
									   int x, int y, DWORD dwKey); // 询问是否要创建二次密码

  static void _evtWelcomeNoticeEvent(CCompent* pSender, int nMsgType,
									 int x, int y, DWORD dwKey); // 欢迎界面 事件处理

  static void _evtCreateOKNoticeEvent(CCompent* pSender, int nMsgType,
									  int x, int y, DWORD dwKey); // 首次创建角色成功提示界面 事件处理

  static void _evtChaNameAlterMouseEvent(CCompent* pSender, int nMsgType,
										 int x, int y, DWORD dwKey); // 首次创建角色成功提示界面 事件处理

  static void _evtCharListLDBDown(CGuiData* pSender, int x, int y, DWORD key); // 角色选择

  //~ 逻辑函数: ============================================================

  public:
  //向服务器发送开始游戏消息
  void SendBeginPlayToServer();
  //删除当前选中的角色
  void DelCurrentSelCha();
  //显示现有角色
  bool SelectCharacters(NetChaBehave* chabehave, int num);
  //新增角色
  bool CreateCha();
  // 设置角色名字到UI
  void SetCharNameToUI(CCharacter* pChar, int nChaIndex);

  //向服务器发送删除角色消息
  void SendDelChaToServer(const char szPassword2[]);

  // 更新按钮状态
  void UpdateButton();

  // 获得角色个数
  int GetChaCount();

  void ShowWelcomeNotice(bool bShow = true);

  private:
  xShipMgr*		 _pShipMgr;
  AnimCtrlLight* _pAnimLightSeq;
  DWORD			 _dwAnimLightNum;
  CLEFont		 _cFont;

  private:
  static BYTE _bAttackRed, _bAttackGreen, _bAttackBlue;

  int		  _nOldMainChaInArea;
  CMouseDown  _cMouseDown;
  bool		  _IsShowSideLife;
  static bool _IsShowPing;
  static bool _IsAutoPick;
  static bool _IsShowCameraInfo;

  public:
  //UI
  CForm*	   frmSelectCha{};
  CForm*	   frmRace{};
  CForm*	   frmmod{};
  CList*	   frmCharList{};
  CTextButton* btnDel{};
  CTextButton* btnYes{};
  CTextButton* btnCreate{};
  CTextButton* btnExit{};
  CTextButton* btnAlter{};

  CTextButton* btnrace1{};
  CTextButton* btnrace2{};
  CTextButton* btnrace3{};

  CForm* frmCheck{};

  CTextButton* btnModYes{};
  CEdit*	   edtModName{};
  CTextButton* btnModleft{};
  CTextButton* btnModright{};

  CTextButton* btnback{};
  CTextButton* btnleft{};
  CTextButton* btnright{};

  //逻辑
  int m_nCurChaIndex;

  //
  bool m_isInit;

  bool m_isCreateCha;

  CForm* frmWelcomeNotice{}; // 定义欢迎界面  该界面仅在当前帐号内无角色时出现
  CForm* frmCreateOKNotice{}; // 定义首次创建角色成功提示界面  该界面仅在该帐号走完第一个角色的创建流程后显示
  CForm* frmChaNameAlter{};	  // 定义改名界面  该界面仅对台湾版本有效，请做好备份工作

  public:
  // 扔道具是否显示提示
  static bool		 _IsThrowItemHint;
  CCharacter*		 m_strChar[4];
  stNetChangeChaPart m_part;
};
