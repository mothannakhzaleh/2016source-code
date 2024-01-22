#include "Stdafx.h"
#include "GameApp.h"
#include "Character.h"
#include "Scene.h"
#include "GameConfig.h"
#include "GameAppMsg.h"
#include "packetcmd.h"
#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "MapSet.h"
#include "NetProtocol.h"
#include "worldscene.h"
#include "LoginScene.h"
#include "UIChat.h"
#include "UITeam.h"
#include "uiboxform.h"
#include "cameractrl.h"
#include "uisystemform.h"

static void _Disconnect(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  CLoginScene* pLogin = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(pLogin)
  {
	pLogin->ShowRegionList();
  } else
  {
	g_pGameApp->LoadScriptScene(enumLoginScene);

	pLogin = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
	if(pLogin)
	{
	  pLogin->ShowRegionList();
	}
  }
}

static void _SwitchMapFailed(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  CLoginScene* pLogin = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  if(!pLogin)
  {
	g_pGameApp->LoadScriptScene(enumLoginScene);
	pLogin = dynamic_cast<CLoginScene*>(CGameApp::GetCurScene());
  }

  if(pLogin)
  {
	  pLogin->ShowRegionList();
  }
}

void CGameApp::_HandleMsg(DWORD dwTypeID, DWORD dwParam1, DWORD dwParam2)
{
  switch(dwTypeID)
  {
  case APP_NET_LOGINRET:
	break;

  case APP_NET_DISCONNECT:
  {
	Waiting(false);

	CGameScene* scene = CGameApp::GetCurScene();
	if(!scene) return;

	if(dwParam1 == 1000)
	{
	  char szBuf[128] = {0};
	  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_135), WSAGetLastError());
	  g_stUIBox.ShowMsgBox(_Disconnect, szBuf);
	  return;
	}
	// else if(dwParam1!=DS_DISCONN && dwParam1!=DS_SHUTDOWN )
	{
	  if(!dynamic_cast<CLoginScene*>(scene))
	  {
		if(!g_ChaExitOnTime.TimeArrived())
		{
		  //非登陆场景断开连接
		  char szBuf[256] = {0};
		  if(g_NetIF)
		  {
			//_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE , "您现在已与服务器断开连接,确定后将返回登录界面\n原因:%s[%d]", "您已在其他地方登陆！", dwParam1 );
			_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_138));
		  } else
		  {
			_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_139), dwParam1);
		  }
		  g_stUIBox.ShowMsgBox(_Disconnect, szBuf);

		  extern bool g_HaveGameMender;
		  if(g_HaveGameMender)
		  {
			g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_140));
		  }
		}
	  } else
	  { //登陆场景内断开连接
		//判断密码是否错误
		CLoginScene* pkLogin = dynamic_cast<CLoginScene*>(scene);
		if(pkLogin && pkLogin->IsPasswordError())
		{
		  pkLogin->ShowLoginForm();
		  return;
		}
	  }
	}
  }
  break;
  case APP_SWITCH_MAP_FAILED:
  {
	g_pGameApp->Waiting(false);

	char szBuf[256] = {0};
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%s[%d]", g_GetServerError(dwParam1), dwParam1);
	g_stUIBox.ShowMsgBox(_SwitchMapFailed, szBuf);
  }
  break;
  case APP_SWITCH_MAP:
  {
	CMapInfo*	 pInfo = GetMapInfo(dwParam1);
	CCameraCtrl* pCam  = g_pGameApp->GetMainCam();
	pCam->SetFollowObj(VECTOR3((float)pInfo->nInitX, (float)pInfo->nInitY, 0));
	// EnableCameraFollow(FALSE);
	break;
  }
  break;
  }
}
