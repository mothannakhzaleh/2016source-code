#pragma once

#include "Scene.h"
#include "uiguidata.h"
#include "NetProtocol.h"

#define MAX_SEL_CHA		 4

//TODO: Use conformity header
#define MAX_USERNAME_LEN 64
#define MAX_PASSWORD_LEN 64

namespace GUI
{
class CForm;
class C3DCompent;
class CGuiData;
class CLabelEx;
class CEdit;
class CTextButton;
class CList;
class CMemo;
class CCheckBox;
class CListView;
class CImage;
} // namespace GUI

class CCharacter;

#define NUM_REGIN_LIST 2

class CLoginScene : public CGameScene
{
  public:
  CLoginScene(stSceneInitParam& param);

  ~CLoginScene() = default;

  void		  LoginFlow();
  static bool IsValidCheckChaName(const char* name);

  void Error(int error_no, const char* error_info);
  void ShowRegionList();
  void PlayWhalePose();

  void SetCurSelRegionIndex(int iIndex) { m_iCurSelRegionIndex = iIndex; }
  int  GetCurSelRegionIndex() { return m_iCurSelRegionIndex; }
  void SetCurSelServerIndex(int iIndex) { m_iCurSelServerIndex = iIndex; }
  int  GetCurSelServerIndex() { return m_iCurSelServerIndex; }
  void ShowLoginForm();

  bool IsPasswordError() { return m_bPasswordError; }
  void SetPasswordError(bool bFlag) { m_bPasswordError = bFlag; }
  void InitRegionList();


  private:
  void SaveUserName(CCheckBox& chkID, CEdit& edtID);

  static void ShowKeyboard(bool bShow);

  protected:
  virtual bool _Init();
  virtual void _FrameMove(DWORD dwTimeParam);
  virtual void _Render();
  virtual void LoadingCall();

  BOOL _InitUI();

  bool _Clear();
  BOOL _bAutoInputAct;

  void _Login();
  bool _CheckAccount();
  bool _Bill();
  void _Connect();

  private:
  static CForm* frmRegion;
  static CForm* frmAccount; // User Account Credentials Input UI 
  static CForm* frmKeyboard; // add by Philip.Wu  软键盘界面  2006-06-05

  static CList* lstRegion[NUM_REGIN_LIST];

  static CEdit*		edtID;
  static CEdit*		edtPassword;
  static CCheckBox* chkID;
  static CEdit*		edtFocus; // add by Philip.Wu  光标激活的编辑框  2006-06-07
  static CCheckBox* chkShift; // add by Philip.Wu  软键盘上的 Shift  2006-06-09

  int	 m_iCurSelRegionIndex;
  int	 m_iCurSelServerIndex;
  bool	 m_bSaveAccount;
  string m_sSaveAccount;
  string m_sPassport;
  string m_sUsername;
  string m_sPassword;

  const char* m_szSelServIp;

  private:
  static void _evtEnter(CGuiData* pSender);
  static void _evtRegionLDBDown(CGuiData* pSender, int x, int y, DWORD key);

  static void _evtRegionFrm(CCompent* pSender, int state, int x, int y, DWORD key);
  static void _evtLoginFrm(CCompent* pSender, int state, int x, int y, DWORD key);
  static void _evtVerErrorFrm(CCompent* pSender, int state, int x, int y, DWORD key);

  static void CallbackUIEvent_LoginScene(CCompent* pSender, int state, int x, int y, DWORD key);

  // add by Philip.Wu  2006-06-05
  // 软键盘界面的鼠标事件
  static void _evtKeyboardFromMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey);

  // 编辑框激活事件（保存下激活的编辑框）
  static void _evtAccountFocus(CGuiData* pSender);

  enum eLoginState
  {
	enumInit,
	enumConnect,
	enumAccount,
	enumLogin,
	enumSelect,
	enumPlay
  };

  eLoginState _eState;
  BYTE		  _loadtex_flag;
  BYTE		  _loadmesh_flag;

  bool m_bPasswordError; //判断密码是否错误

  static const int IMAGE_INDEX = 0;
  static const int TEXT_INDEX  = 1;
};
