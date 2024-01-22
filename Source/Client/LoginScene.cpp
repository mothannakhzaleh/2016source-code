#include "stdafx.h"
#include "LoginScene.h"

#include "GameApp.h"
#include "Character.h"
#include "SceneObj.h"
#include "UiFormMgr.h"
#include "UiTextButton.h"
#include "CharacterAction.h"
#include "SceneItem.h"
#include "ItemRecord.h"
#include "PacketCmd.h"
#include "GameConfig.h"

#include "Character.h"
#include "caLua.h"
#include "lualib.h"
#include "lauxlib.h"
#include "UIRender.h"
#include "UIEdit.h"
#include "UILabel.h"
#include "uiformmgr.h"
#include "uitextbutton.h"
#include "uilabel.h"
#include "uiprogressbar.h"
#include "uiscroll.h"
#include "uilist.h"
#include "uicombo.h"
#include "uiimage.h"
#include "UICheckBox.h"
#include "uiimeinput.h"
#include "uigrid.h"
#include "uilistview.h"
#include "uipage.h"
#include "uitreeview.h"
#include "uiimage.h"
#include "UILabel.h"
#include "RenderStateMgr.h"
#include "cameractrl.h"
#include "UIListView.h"

#include "UIMemo.h"
#include "caLua.h"

#include "Connection.h"
#include "ServerSet.h"
#include "GameAppMsg.h"

#include "UI3DCompent.h"
#include "UIForm.h"
#include "UITemplete.h"
#include "commfunc.h"
#include "uiboxform.h"
#include "bill.h"

#include <shellapi.h>

#pragma comment(lib, "shell32.lib")

#include "xmlwriter.h"

CForm* CLoginScene::frmRegion	= NULL;
CForm* CLoginScene::frmAccount	= NULL;
CForm* CLoginScene::frmKeyboard = NULL; // add by Philip.Wu  软键盘界面  2006-06-05

CCheckBox* CLoginScene::chkID = NULL;

CList* CLoginScene::lstRegion[NUM_REGIN_LIST];

CEdit*	   CLoginScene::edtID		= NULL;
CEdit*	   CLoginScene::edtPassword = NULL;
CEdit*	   CLoginScene::edtFocus	= NULL; // add by Philip.Wu  光标激活的编辑框  2006-06-06
CCheckBox* CLoginScene::chkShift	= NULL; // add by Philip.Wu  软键盘上的 Shift  2006-06-09

static CLoginScene* g_login_scene = 0;

static void _GoBack(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  CLoginScene* pLogin = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(pLogin)
  {
	  pLogin->ShowRegionList();
  }
}

#define MAX_SERVER_NUM 8

CLoginScene::CLoginScene(stSceneInitParam& param) :
	CGameScene(param),
	_eState(enumInit),
	m_bPasswordError(false),
	m_sPassport("nobill"),
	m_sUsername(""),
	m_sPassword("")
{
  for(int index = 0; index < NUM_REGIN_LIST; index++)
	lstRegion[index] = NULL;

  //	LG( "scene memory", "CLoginScene Create\n" );
  _loadtex_flag	 = 9;
  _loadmesh_flag = 9;

  m_iCurSelRegionIndex	   = 1;
  m_iCurSelServerIndex	   = 0;
}

bool CLoginScene::_Init()
{
  g_login_scene = this;

  _IsUseSound = false;

  _eState = enumInit;

  { // save loading res mt flag
	drIByteSet* res_bs = g_Render.GetInterfaceMgr()->res_mgr->GetByteSet();
	_loadtex_flag	   = res_bs->GetValue(OPT_RESMGR_LOADTEXTURE_MT);
	_loadmesh_flag	   = res_bs->GetValue(OPT_RESMGR_LOADMESH_MT);
	res_bs->SetValue(OPT_RESMGR_LOADTEXTURE_MT, 0);
	res_bs->SetValue(OPT_RESMGR_LOADMESH_MT, 0);
  }

  CGameScene::_Init();

  SetFocus(g_pGameApp->GetHWND());

  SetFocus(g_pGameApp->GetHWND());

  m_sUsername = "player";
  m_sPassword = "";

  if(!_InitUI())
  {
	LG("login_ini", RES_STRING(CL_LANGUAGE_MATCH_168));

	return false;
  }

  CFormMgr::s_Mgr.SetEnabled(TRUE);
  _pMainCha = NULL;

  // 删除自动更新程序的复本
  char szUpdateFileName[] = "_Update.exe";
  SetFileAttributes(szUpdateFileName, FILE_ATTRIBUTE_NORMAL);
  DeleteFile(szUpdateFileName);

  PlayWhalePose();


  return true;
}

void CLoginScene::PlayWhalePose()
{
}

bool CLoginScene::_Clear()
{
  CGameScene::_Clear();

  //    g_Render.SetRenderState(D3DRS_FOGENABLE, 0);
  { // reset loading res mt flag
	if(_loadtex_flag != 9 && _loadmesh_flag != 9)
	{
	  drIByteSet* res_bs = g_Render.GetInterfaceMgr()->res_mgr->GetByteSet();
	  res_bs->SetValue(OPT_RESMGR_LOADTEXTURE_MT, _loadtex_flag);
	  res_bs->SetValue(OPT_RESMGR_LOADMESH_MT, _loadmesh_flag);
	}
  }

  g_Render.SetClip(1.F, 1000.0f);

  return 1;
}

void CLoginScene::ShowLoginForm()
{
  chkID->SetIsChecked(m_bSaveAccount);
  edtID->SetCaption(m_sSaveAccount.c_str());
  edtPassword->SetCaption("");
  frmAccount->Show();

  if(m_sSaveAccount == "")
  {
	edtID->SetActive(edtID);
  } else
  {
	edtPassword->SetActive(edtPassword);
  }
}

void CLoginScene::_FrameMove(DWORD dwTimeParam)
{
  //CGameScene::_FrameMove(dwTimeParam);
  int x = g_pGameApp->GetMouseX();
  int y = g_pGameApp->GetMouseY();
  GetRender().ScreenConvert(x, y);

  if (frmRegion->GetIsShow())
	{
		for( int index = 0; index < NUM_REGIN_LIST; index ++ )
		{
			if( !lstRegion[index]->InRect(x, y) )
				lstRegion[index]->GetItems()->GetSelect()->SetNoSelect();
		}
	}

  if(_eState == enumConnect)
  {
	switch(g_NetIF->GetConnStat())
	{
	case Connection::CNST_CONNECTING:
	  return;
	case Connection::CNST_INVALID:
	case Connection::CNST_FAILURE:
	{
	  // 返回到选择服务器场景
	  _eState = enumInit;
	  CGameApp::Waiting(false);

	  ShowKeyboard(false);
	  frmRegion->SetIsShow(false);
	  frmAccount->SetIsShow(false);
	  g_stUIBox.ShowMsgBox(_GoBack, RES_STRING(CL_LANGUAGE_MATCH_169));
	}
	  return;
	case Connection::CNST_HANDSHAKE:
	  g_pGameApp->Waiting(true, "Logging in...");

	  //连接成功,发送登陆消息
	  _Login();
	  return;
	case Connection::CNST_TIMEOUT:
	  _eState = enumInit;
	  g_pGameApp->SendMessage(APP_NET_DISCONNECT, 1000);
	  return;
	}
	return;
  }
}

void CLoginScene::_Render()
{
  static bool	 IsLoad = false;
  static CGuiPic LoginPic;
  if(!IsLoad)
  {
	LoginPic.LoadImage("texture/ui/new_login.jpg", 1024, 768, 0, 0, 0, 1.F, 1.F);
	IsLoad = true;
  }
  LoginPic.SetScale(0, GetRender().GetScreenWidth(), GetRender().GetScreenHeight());
  LoginPic.Render(0, 0);

}

void CLoginScene::LoadingCall()
{
  g_pGameApp->PlayMusic(1);
}
 
//-----------------
// 界面相关Routines
//-----------------
void CLoginScene::CallbackUIEvent_LoginScene(CCompent* pSender, int state, int x, int y, DWORD key)
{
  string	   strName = (const char*)pSender->GetName();
  CLoginScene* pScene  = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pScene)
	return;

  if(_stricmp("frmServer", pSender->GetForm()->GetName()) == 0)
  {
	if(strName == "btnYes")
	{
	  pSender->GetForm()->Hide();
	  pScene->LoginFlow(); //选定了服务器
	} else if(strName == "btnNo")
	{
	  g_pGameApp->SetIsRun(false);
	  return;
	}
  }
  else if(_stricmp("frmAccount", pSender->GetForm()->GetName()) == 0)
  {
	if(strName == "btnYes")
	{
	  pScene->LoginFlow();
	} else if(strName == "btnNo")
	{
	  if(g_NetIF->IsConnected())
	  {
		CS_Disconnect(DS_DISCONN);
	  }
	  pSender->GetForm()->Hide();
	  return;
	}
  }
}

void CLoginScene::_evtRegionFrm(CCompent* pSender, int state, int x, int y, DWORD key)
{
  CLoginScene* pkScene = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pkScene) return;

  string strName = (const char*)pSender->GetName();
  if(strName == "btnNo")
  {
	//关闭服务器列表表单,显示通告表单
	pSender->GetForm()->SetIsShow(false);

	g_pGameApp->SetIsRun(false);
	return;
  }
}

void CLoginScene::_evtLoginFrm(CCompent* pSender, int state, int x, int y, DWORD key)
{
  CLoginScene* pkScene = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pkScene) return;

  string strName = (const char*)pSender->GetName();
  if(strName == "btnYes")
  {
	if(frmKeyboard->GetIsShow())
	{
	  frmKeyboard->SetIsShow(false);
	}

	pkScene->LoginFlow();
  } else if(strName == "btnNo")
  {
	if(frmKeyboard->GetIsShow())
	{
	  frmKeyboard->SetIsShow(false);
	}

	if(g_NetIF->IsConnected())
	{
	  CS_Disconnect(DS_DISCONN);
	}
	pSender->GetForm()->SetIsShow(false);
	pkScene->ShowRegionList();

	return;
  } else if(strName == "btnKeyboard")
  {
	bool bShow = frmKeyboard->GetIsShow();

	ShowKeyboard(!bShow);
  }
}


void CLoginScene::_evtRegionLDBDown(CGuiData* pSender, int x, int y, DWORD key)
{
  CLoginScene* pkScene = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pkScene) return;

  CList* pkRegionList = dynamic_cast<CList*>(pSender);
  if(!pkRegionList) return;

  for(int index = 0; index < NUM_REGIN_LIST; index++)
  {
	if(pkRegionList == lstRegion[index])
	{
	  const char* ReginText		 = pkRegionList->GetItems()->GetSelect()->GetItem()->GetBegin()->GetString();
	  int		  ReginIndex	 = GetReginIndex(ReginText);
	  int		  ServerGroupCnt = GetCurServerGroupCnt(ReginIndex);
	  if(!ServerGroupCnt)
		break;

	  pkScene->SetCurSelRegionIndex(ReginIndex);

	  string ServerNames[MAX_SERVER_NUM]   = {"", "", "", "", "", "", "", ""},
			 ServerComment[MAX_SERVER_NUM] = {"", "", "", "", "", "", "", ""},
			 ServerState[MAX_SERVER_NUM]   = {"", "", "", "", "", "", "", ""};
	  for(int m = 0; m < ServerGroupCnt; m++)
	  {
		ServerNames[m]	 = GetCurServerGroupName(ReginIndex, m);
		ServerComment[m] = GetGroupComment(ReginIndex, m);
		ServerState[m]	 = GetGroupState(ReginIndex, m);
	  }
	  break;
	}
  }

  if(key & Mouse_LDown)
  {
	pSender->GetForm()->SetIsShow(false);
	pkScene->ShowLoginForm();
  }
}

void CLoginScene::_evtEnter(CGuiData* pSender) // added by billy
{
  CLoginScene* pScene = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pScene) return;
  pScene->LoginFlow();
}

void CLoginScene::InitRegionList()
{
  for(int index = 0; index < NUM_REGIN_LIST; index++)
	lstRegion[index]->GetItems()->Clear();

  ReginListMap& ListMap = GetReginListMap();

  for(int Index = 1; Index <= NUM_REGIN_LIST; Index++)
  {
	ReginListMap::iterator iter = ListMap.find(Index);
	if(iter != ListMap.end())
	{
	  ReginList& reginList = iter->second;
	  for(ReginList::iterator ReginIter = reginList.begin(); ReginIter != reginList.end(); ReginIter++)
		lstRegion[Index - 1]->Add((*ReginIter).c_str());
	}
  }

  //选择默认的第一个选项
  SetCurSelRegionIndex(0);
  CListItems* items = lstRegion[0]->GetItems();
  if(!items) return;
  items->Select(GetCurSelRegionIndex());
}

BOOL CLoginScene::_InitUI()
{
  /*游戏区域选择表单*/
  {
	frmRegion = CFormMgr::s_Mgr.Find("frmRegion");
	if(!frmRegion) return false;
	frmRegion->evtEntrustMouseEvent = _evtRegionFrm;

	const char* strRegin[] = 
		{
			"lstRegion0",
			"lstRegion1",
			"lstRegion2",
			"lstRegion3",
			"lstRegion4",
			"lstRegion5"
		};

		for( int index = 0; index < NUM_REGIN_LIST; index ++ )
		{
			lstRegion[index] = dynamic_cast<CList *> (frmRegion->Find( strRegin[index] ));
			if( lstRegion[index] )
				lstRegion[index]->evtListMouseDown = _evtRegionLDBDown;
		}

	//读取游戏区域列表
	InitRegionList();
	frmRegion->SetIsShow(true);
  }

  frmAccount = CFormMgr::s_Mgr.Find("frmAccount");
  if(!frmAccount) return false;

  frmAccount->evtEntrustMouseEvent = _evtLoginFrm;

  chkID			 = (CCheckBox*)frmAccount->Find("chkID");
  m_bSaveAccount = false;
  if(!chkID) return false;
  //检测上次时候选中了账号
  char	   szChkID[128] = {0};
  string   strChkID;
  ifstream inCheck("user\\checkid.txt");
  if(inCheck.is_open())
  {
	while(!inCheck.eof())
	{
	  inCheck.getline(szChkID, 128);
	  strChkID		 = szChkID;
	  int nCheck	 = Str2Int(strChkID);
	  m_bSaveAccount = (nCheck == 1) ? true : false;
	  chkID->SetIsChecked(m_bSaveAccount);
	}
  } else
  {
	m_bSaveAccount = true;
	chkID->SetIsChecked(m_bSaveAccount);
  }

  edtID = dynamic_cast<CEdit*>(frmAccount->Find("edtID"));

  if(!edtID) return false;
  m_sSaveAccount = "";
  //读入数据, 在上次chkID按下时候 ，把帐号写入到了username.txt文件， 现在读入该帐号
  char	   szName[128] = {0};
  ifstream in("user\\username.txt");

  _bAutoInputAct = FALSE;
  if(in.is_open())
  {
	while(!in.eof())
	{
	  in.getline(szName, 128);
	}
	_bAutoInputAct = TRUE;
  }
  m_sSaveAccount = string(szName);
  edtID->SetCaption(m_sSaveAccount.c_str());

  if(edtID)
  {
	edtID->evtEnter = _evtEnter;
	edtID->SetIsWrap(true);
  }

  edtPassword = dynamic_cast<CEdit*>(frmAccount->Find("edtPassword"));
  if(edtPassword)
  {
	edtPassword->SetCaption("");
	edtPassword->SetIsPassWord(true);
	edtPassword->SetIsWrap(true);
	edtPassword->evtEnter = _evtEnter;
  }

  // 添加软键盘界面
  frmKeyboard = CFormMgr::s_Mgr.Find("frmKeyboard");
  if(!frmKeyboard) return false;

  chkShift = (CCheckBox*)frmKeyboard->Find("chkShift");
  if(!chkShift) return false;

  // 设置软键盘界面鼠标点击事件处理
  frmKeyboard->evtEntrustMouseEvent = _evtKeyboardFromMouseEvent;

  if(edtID)
	edtID->evtActive = _evtAccountFocus;

  if(edtPassword)
	edtPassword->evtActive = _evtAccountFocus;

  return TRUE;
}

bool CLoginScene::IsValidCheckChaName(const char* name)
{
  if(!common::conformity::character::name::is_valid(name, strlen(name)))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_51));
	return false;
  }
  return true;

  const char* s	  = name;
  int		  len = (int)strlen(s);
  bool		  bOk = true;

  for(int i = 0; i < len; i++)
  {
	if(s[i] & 0x80)
	{
	  if(!(s[i] == -93)) //用于处理是否是双字节的字母
	  {
		i++;
	  } else
	  {
		bOk = false;
		i++;
		break;
	  }
	} else
	{
	  if(!(isdigit(s[i]) || isalpha(s[i])))
	  {
		bOk = false;
		break;
	  }
	}
  }

  if(!bOk)
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_52));

  return bOk;
}

bool CLoginScene::_CheckAccount()
{
  // 本地检查用户名和密码
  if(strlen(edtID->GetCaption()) == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_174));
	return false;
  }
  if(!IsValidCheckChaName(edtID->GetCaption()))
	return false;

  if(strlen(edtPassword->GetCaption()) <= 4)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_175));
	return false;
  }

  // 保存用户名
  SaveUserName(*chkID, *edtID);

  m_sUsername = edtID->GetCaption();
  m_sPassword = edtPassword->GetCaption();

  return true;
}

bool CLoginScene::_Bill()
{
  m_sPassport = "nobill";
  return true;
}

void CLoginScene::_Connect()
{
  CGameApp::Waiting(true, "Connecting...");

  //PlayWhalePose();	//鲸鱼动画改为初始化时就播放(Michael Chen 2005-06-03)

  _eState = enumConnect;

  const char* pszSelectGateIP(0);
  //如果没有得到随机选择Gate的Ip
  if(!pszSelectGateIP) pszSelectGateIP = SelectGroupIP(m_iCurSelRegionIndex, m_iCurSelServerIndex);

  if(!pszSelectGateIP)
  {
	LG("connect", RES_STRING(CL_LANGUAGE_MATCH_180), m_iCurSelRegionIndex, m_iCurSelServerIndex);
  } else
  {
	CS_Connect(pszSelectGateIP, 1973, g_Config.m_nConnectTimeOut);
  }
  //#endif
}

void CLoginScene::LoginFlow()
{
  if(!_CheckAccount())
	return;

  if(!_Bill())
	return;

  _Connect();
}

void CLoginScene::_Login()
{
  _eState = enumAccount;

  if(!m_sUsername.empty()  && !m_sPassword.empty())
  {
	CS_Login(m_sUsername.c_str(), m_sPassword.c_str(), m_sPassport.c_str());

  }
}

void CLoginScene::SaveUserName(CCheckBox& chkID, CEdit& edtID)
{
  //创建新文件夹
  if(!CreateDirectory("user", NULL))
  {
  }

  m_bSaveAccount = chkID.GetIsChecked();
  m_sSaveAccount = string(edtID.GetCaption());

  //写文件
  FILE* fchk;
  fopen_s(&fchk, "user\\checkid.txt", "wb");
  if(fchk)
  {
	fwrite(m_bSaveAccount ? "1" : "0", strlen("1"), 1, fchk);
	fclose(fchk);
  }

  FILE* fp;
  fopen_s(&fp, "user\\username.txt", "wb");
  if(fp)
  {
	if(m_bSaveAccount)
	  fwrite(m_sSaveAccount.c_str(), m_sSaveAccount.size(), 1, fp);
	else
	  fwrite("", 0, 1, fp);

	fclose(fp);
  }
}

void CLoginScene::_evtVerErrorFrm(CCompent* pSender, int nMsgType, int x, int y, DWORD key)
{
  g_pGameApp->SetIsRun(false);

  if(nMsgType != CForm::mrYes)
  {
	// 弹开一个网页
	if(strlen(g_Config.m_szVerErrorHTTP) == 0)
	  return;

	::ShellExecute(NULL, "open",
				   g_Config.m_szVerErrorHTTP,
				   NULL, NULL, SW_SHOW);
	return;
  }

  // 自动更新
  extern bool g_IsAutoUpdate;
  g_IsAutoUpdate = true;
}

void CLoginScene::Error(int error_no, const char* error_info)
{
  CGameApp::Waiting(false);
  LG("error", "%s Error, Code:%d, Info: %s", error_info, error_no, g_GetServerError(error_no));

  if(ERR_MC_VER_ERROR == error_no)
  {
	CBoxMgr::ShowSelectBox(_evtVerErrorFrm, RES_STRING(CL_LANGUAGE_MATCH_181), true);
	return;
  }

  g_pGameApp->MsgBox("%s", g_GetServerError(error_no));
}

void CLoginScene::ShowRegionList()
{
  CS_Disconnect(DS_DISCONN);

  if(frmKeyboard) // add by Philip.Wu  2006-06-05
	ShowKeyboard(false);

  if(frmAccount)
	frmAccount->SetIsShow(false);

  InitRegionList();
	if (frmRegion)
		frmRegion->SetIsShow(true);
}

// add by Philip.Wu  2006-06-05
// 软键盘的鼠标点击按钮事件
void CLoginScene::_evtKeyboardFromMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(!edtFocus) return;

  CLoginScene* pLoginScene = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pLoginScene) return;

  string strText = edtFocus->GetCaption();
  string strName = pSender->GetName();
  if(strName.size() <= 0) return;

  // 按键消息的处理
  if(strName == "btnClose" || strName == "btnYes") // 关闭软键盘
  {
	if(frmKeyboard->GetIsShow())
	{
	  ShowKeyboard(false);
	}
  } else if(strName == "btnDel") // 删除最后一个字符
  {
	if(strText.size() > 0)
	{
	  strText.resize(strText.size() - 1);
	  edtFocus->SetCaption(strText.c_str());
	}
  } else if(strName == "chkShift") // 大小转换
  {
  } else if(strName == "btnOther101") // 第一排特别字符键
  {
	strText += '~';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther102")
  {
	strText += '!';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther103")
  {
	strText += '@';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther104")
  {
	strText += '#';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther105")
  {
	strText += '$';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther106")
  {
	strText += '%';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther107")
  {
	strText += '^';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther108")
  {
	strText += '&';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther109")
  {
	strText += '*';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther110")
  {
	strText += '(';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther111")
  {
	strText += ')';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther112")
  {
	strText += '_';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther113")
  {
	strText += '+';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther114")
  {
	strText += '|';
	edtFocus->SetCaption(strText.c_str());
  }

  else if(strName == "btnOther201") // 第二排特别字符键
  {
	strText += '`';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther202")
  {
	strText += '-';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther203")
  {
	strText += '=';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther204")
  {
	strText += '\\';
	edtFocus->SetCaption(strText.c_str());
  }

  else if(strName == "btnOther301") // 第三排特别字符键
  {
	strText += '{';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther302")
  {
	strText += '}';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther303")
  {
	strText += '[';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther304")
  {
	strText += ']';
	edtFocus->SetCaption(strText.c_str());
  }

  else if(strName == "btnOther401") // 第四排特别字符键
  {
	strText += ':';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther402")
  {
	strText += '\"';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther403")
  {
	strText += ';';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther404")
  {
	strText += '\'';
	edtFocus->SetCaption(strText.c_str());
  }

  else if(strName == "btnOther501") // 第五排特别字符键
  {
	strText += '<';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther502")
  {
	strText += '>';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther503")
  {
	strText += '?';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther504")
  {
	strText += ',';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther505")
  {
	strText += '.';
	edtFocus->SetCaption(strText.c_str());
  } else if(strName == "btnOther506")
  {
	strText += '/';
	edtFocus->SetCaption(strText.c_str());
  }

  else // 功能键全部排除后，剩下的是输入字符键按下
  {
	char cAdd = strName.at(strName.size() - 1);

	// 判断是否是数字或字母（暂时偷懒方式处理）
	if(('0' <= cAdd && cAdd <= '9'))
	{
	  strText += cAdd;
	  edtFocus->SetCaption(strText.c_str());
	} else if('A' <= cAdd && cAdd <= 'Z')
	{
	  if(chkShift->GetIsChecked())
	  {
		// 大写
		strText += cAdd;
	  } else
	  {
		// 小写
		strText += cAdd + 32;
	  }
	  edtFocus->SetCaption(strText.c_str());
	}
  }
}

// add by Philip.Wu  2006-06-07
// 编辑框激活事件（保存下激活的编辑框）
void CLoginScene::_evtAccountFocus(CGuiData* pSender)
{
  CEdit* edtTemp = dynamic_cast<CEdit*>(pSender);

  if(edtTemp)
  {
	edtFocus = edtTemp;
  }
}

void CLoginScene::ShowKeyboard(bool bShow)
{
  frmKeyboard->SetIsShow(bShow);
}
