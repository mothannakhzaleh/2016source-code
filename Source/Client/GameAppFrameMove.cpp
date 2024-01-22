#include "Stdafx.h"
#include "GameApp.h"

#include "Character.h"
#include "SceneObj.h"
#include "SceneItem.h"
#include "EffectObj.h"
#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "Scene.h"
#include "Track.h"
#include "PacketCmd.h"
#include "lua_platform.h"

#include "SmallMap.h"
#include "GlobalVar.h"
#include "UIGlobalVar.h"
#include "GameConfig.h"

#ifdef __SOUND__
#ifndef USE_DSOUND
#include "AudioThread.h"
extern CAudioThread g_AudioThread;
#endif
#endif
#ifdef TESTDEMO
#include "TestDemo.h"
#endif

#include "state_reading.h"

void CGameApp::_FrameMove(DWORD dwTimeParam, bool camMove) //Vim
{
  if(camMove)
  {
	/*
		If camMove is set, we only force the computation of all matrices and
		skipping the rest.
		The rest causes problems, when calling _FrameMove inside the renderloop for
		multiple views.
		*/
	CCameraCtrl* pCam = GetMainCam();
	pCam->SetViewTransform();
	return;
  }

  // Modified by CLP
  CCameraCtrl*	 pCam	 = GetMainCam();
  Ninja::Camera* pCamera = GetNinjaCamera();

  LETerrain*  pTerr = GetCurScene()->GetTerrain();
  CCharacter* pCha	= _pCurScene->GetMainCha();

  if(m_AddSceneObjList.size() > 0)
  {
	SAddSceneObj* pAdd = m_AddSceneObjList.front();
	m_AddSceneObjList.pop_front();
	CGameScene* pScene = g_pGameApp->GetCurScene();
	CSceneObj*	pObj   = pScene->AddSceneObj(pAdd->nTypeID);
	if(pObj)
	{
	  pObj->setHeightOff(pAdd->nHeightOff);
	  pObj->setPos(pAdd->nPosX, pAdd->nPosY);
	  pObj->setYaw(pAdd->nAngle);
	  //			LG("frameload", RES_STRING(CL_LANGUAGE_MATCH_64), pAdd->nTypeID, pAdd->nPosX, pAdd->nPosY);
	}
	delete pAdd;
  }

  // 老摄像机部分
  if(_bCameraFollow)
  {
	if(pCha)
	{
	  D3DXVECTOR3 vecCha = pCha->GetPos() + D3DXVECTOR3(0, 0, 1.f);

	  if(!pCam->m_bSelectMode)
	  {
		pCam->AddPoint(vecCha.x, vecCha.y, vecCha.z);
		pCam->Update();
		pCam->SetFollowObj(pCam->m_vCurPos);
	  }

	  pCam->FrameMove(dwTimeParam);
	  g_Render.SetWorldViewFOV(Angle2Radian(pCam->m_ffov));
	}
  }
  if(_bCameraFollow)
  {
	D3DXVECTOR3 vecCha = pCam->m_RefPos;
	D3DXVec3Add(&vecCha, &vecCha, &(-pCam->m_vDir * pCam->_fdistshow));
	if(pTerr) pTerr->SetShowCenter(vecCha.x, vecCha.y);
  }
  //!要在这里设置好VIEW MATRIX。
  pCam->SetViewTransform();

  ResMgr.FrameMove(dwTimeParam);

  //  1s 执行一次
  static DWORD tick = 0;
  if(GetCurTick() - tick > 1000)
  {
	tick = GetCurTick();
	CS_SendPing();
  }

  CUIInterface::All_FrameMove(dwTimeParam);

  _pCurScene->_FrameMove(dwTimeParam);

#ifdef TESTDEMO
  g_pTestDemo->FrameMove();
#endif

#ifdef __SOUND__
  // 音乐线程（解决卡机）
#ifndef USE_DSOUND
  g_AudioThread.FrameMove();
#endif

  // 切换背景音乐
#ifndef USE_DSOUND
  switch(_eSwitchMusic)
  {
  case enumOldMusic:
	_nCurMusicSize--;
	if(_nCurMusicSize <= 1)
	{
	  AudioSDL::get_instance()->stop(::g_dwCurMusicID);
	  if(_szBkgMusic[0] == '\0')
	  {
		_eSwitchMusic = enumNoMusic;
	  } else
	  {
		DWORD OldMusicID = g_dwCurMusicID;
		g_dwCurMusicID	 = AudioSDL::get_instance()->get_resID(_szBkgMusic, TYPE_MP3);

		// 音乐线程（解决卡机）
		g_AudioThread.play(g_dwCurMusicID, true);
		_eSwitchMusic = enumNewMusic;
	  }
	} else
	  AudioSDL::get_instance()->volume(g_dwCurMusicID, _nCurMusicSize);
	break;

  case enumNewMusic:
	_nCurMusicSize++;
	if(_nCurMusicSize >= _nMusicSize)
	{
	  _eSwitchMusic = enumMusicPlay;
	} else
	{
	  //::bkg_snd_vol( _nCurMusicSize );
	  AudioSDL::get_instance()->volume(g_dwCurMusicID, _nCurMusicSize);
	}
	break;
  }
#else
  switch(_eSwitchMusic)
  {
  case enumOldMusic:
	_nCurMusicSize--;
	if(_nCurMusicSize <= 1)
	{
	  if(_szBkgMusic[0] == '\0')
	  {
		mMP3->Close();
		_eSwitchMusic = enumNoMusic;
	  } else
	  {
		PlayMusic(_szBkgMusic);
		_eSwitchMusic = enumNewMusic;
	  }
	} else
	  mMP3->SetVolume(_nCurMusicSize, _nCurMusicSize);
	break;

  case enumNewMusic:
	if(_nCurMusicSize >= _nMusicSize)
	  _eSwitchMusic = enumMusicPlay;
	else
	{
	  _nCurMusicSize++;
	  mMP3->SetVolume(_nCurMusicSize, _nCurMusicSize);
	}
	break;
  }
#endif
#endif //__SOUND__
#ifdef _LUA_GAME
  lua_platform_framemove();
#endif

  HandleKeyContinue();

#ifdef __EDITOR__
  if(g_Config.m_bEditor)
  {
	g_Editor.FrameMove(dwTimeParam);

	if(_pCurScene->GetTerrain())
	{
	  g_Render.Print(INFO_DEBUG, 290, 120, "showcenter = %f,%f", _pCurScene->GetTerrain()->GetShowCenterX(), _pCurScene->GetTerrain()->GetShowCenterY());
	}

	if(pCha)
	{
	  g_Render.Print(INFO_DEBUG, 290, 410, "cha pos = %f,%f,%f", pCha->GetPos().x * 100, pCha->GetPos().y * 100, pCha->GetPos().z * 100);
	  g_Render.Print(INFO_DEBUG, 290, 430, "cha angle = %d", (int)(int(((float)pCha->getYaw() * 0.01745329f /*+ D3DX_PI*/) * 57.29577f) % 360));
	}
  }
#endif
  // 	else
  // 	{
  // 		SystemReport(dwTimeParam);
  // 	}

  _stCursorMgr.FrameMove(dwTimeParam);

  if(CGameScene::_bShowMinimap && CGameScene::_pSmallMap)
  {
	CGameScene::_pSmallMap->FrameMove(dwTimeParam);
  }

  LETexSet::I()->DynamicRelease();
}

bool CGameApp::_MouseInScene = false;
void CGameApp::_PreMouseRun(DWORD dwMouseKey)
{
  if(!GetConsole()->IsVisible())
  {
	extern HWND g_InputEdit;
	if(GetFocus() != g_InputEdit)
	{
	  ::SetFocus(g_InputEdit);
	}
  } else
  {
	::SetFocus(GetHWND());
  }

  CFormMgr::s_Mgr.FrameMove(GetMouseX(), GetMouseY(), dwMouseKey, GetCurTick());

  switch(CFormMgr::GetMouseAction())
  {
  case enumMA_None:
	_MouseInScene = true;
	break;
  case enumMA_Gui:
  case enumMA_Skill:
	_MouseInScene = false;
	break;
  case enumMA_Drill:
	_MouseInScene = CCozeForm::GetInstance()->IsMouseOnList(GetMouseX(), GetMouseY());
	break;
  }
}
