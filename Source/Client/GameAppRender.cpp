#include "Stdafx.h"
#include "GameApp.h"
#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "Scene.h"
#include "FindPath.h"
#include "UIFormMgr.h"
#include "GlobalVar.h"
#include "DrawPointList.h"
#include "SmallMap.h"
#include "Character.h"
#include "UICursor.h"
#include "Track.h"
#include "cameractrl.h"
#include "SceneObj.h"
#include "CPerformance.h"
#include "UIFont.h"
#include "CaLua.h"
#ifdef _SKYBOX_
#include "MPSkyBox.h"
#include "WorldScene.h"
#endif

#ifdef TESTDEMO
#include "TestDemo.h"
#endif
Ctemp tmap;

struct _RHFFVF
{
  drVector4 pos;
  DWORD		dif;
};

#ifdef __FPS_DEBUG__
DWORD m_dwCFormMgr__s_Mgr_Render	 = 0;
DWORD m_dw_stCursorMgr				 = 0;
DWORD m_dw_pCurScene				 = 0;
DWORD m_dwCFormMgr__s_Mgr_RenderHint = 0;
DWORD m_dwCCursor__I__Render		 = 0;
DWORD m_dw_pNotify					 = 0;
DWORD m_dw_pNotify1					 = 0;
#endif

BOOL RenderHintFrame(const RECT* rc, DWORD color)
{
  //color = 0xffff0000;

  DWORD	  rs_lgt;
  DWORD	  rs_vc;
  _RHFFVF vert[5];
  vert[0].pos = drVector4((float)rc->left, (float)rc->top, 0, 1.0f);
  vert[1].pos = drVector4((float)rc->right, (float)rc->top, 0, 1.0f);
  vert[2].pos = drVector4((float)rc->right, (float)rc->bottom, 0, 1.0f);
  vert[3].pos = drVector4((float)rc->left, (float)rc->bottom, 0, 1.0f);
  vert[4].pos = vert[0].pos;
  vert[0].dif = vert[1].dif = vert[2].dif = vert[3].dif = vert[4].dif = color;
  MPIResourceMgr*	   res_mgr										  = g_Render.GetInterfaceMgr()->res_mgr;
  MPIDeviceObject*	   dev_obj										  = g_Render.GetInterfaceMgr()->dev_obj;
  drIDynamicStreamMgr* dns_mgr										  = res_mgr->GetDynamicStreamMgr();
  dev_obj->GetRenderState(D3DRS_LIGHTING, &rs_lgt);
  dev_obj->GetRenderState(D3DRS_COLORVERTEX, &rs_vc);
  dev_obj->SetRenderStateForced(D3DRS_LIGHTING, 0);
  dev_obj->SetRenderStateForced(D3DRS_COLORVERTEX, 1);

  drMaterial mtl;
  memset(&mtl, 0, sizeof(mtl));
  mtl.amb.a = mtl.amb.r = mtl.amb.g = mtl.amb.b = 1.0f;
  dev_obj->SetMaterial(&mtl);

  dev_obj->SetTexture(0, NULL);

  if(DR_FAILED(dns_mgr->DrawPrimitive(D3DPT_LINESTRIP, 4, vert, sizeof(_RHFFVF), (D3DFORMAT)(D3DFVF_XYZRHW | D3DFVF_DIFFUSE))))
  {
	dev_obj->SetRenderState(D3DRS_LIGHTING, rs_lgt);
	dev_obj->SetRenderState(D3DRS_COLORVERTEX, rs_vc);
	return 0;
  }

  dev_obj->SetRenderState(D3DRS_LIGHTING, rs_lgt);
  dev_obj->SetRenderState(D3DRS_COLORVERTEX, rs_vc);
  return 1;
};

#ifdef _SKYBOX_
extern MINDPOWER_API int   g_nPosZ;
extern MINDPOWER_API DWORD g_dwRenderTerrainTime;
extern MINDPOWER_API DWORD g_dwRenderTerrainCnt;
#endif

//CMinimap* minimap = NULL;
// Game SDK 框架函数, 需用户填充
void CGameApp::_Render()
{
	ResMgr.RestoreEffect();

	if(IsEnableSpSmMap())
	{
	  _CreateSmMap(_pCurScene->GetTerrain());
	}

	if(btest)
	{
	  CreateCharImg();
	  return;
	}

  // Scene的绘制------------------------------------------------------------
#ifdef __FPS_DEBUG__
  LETimer tScene;
  tScene.Begin();
#endif
#ifdef _SKYBOX_
  if(_pCurScene->IsShowSky())
  {
	/*float Start = 10000.0f, End = 20000.0f;
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGENABLE, TRUE);
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGCOLOR, 0x00a4a4a4);
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGVERTEXMODE, D3DFOG_LINEAR);
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGSTART, *(DWORD*)(&Start));
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGEND, *(DWORD*)(&End));
		g_Render.GetDevice()->SetRenderState(D3DRS_FOGENABLE, FALSE);*/

	g_Render.SetClip(1.0f, 30000.0f);
	MPMatrix44 mat;
	D3DXMatrixIdentity(&mat);
	// 以主角为中心构建天空盒
	D3DXMatrixTranslation(&mat, _pCurScene->GetMainCha()->GetPos().x, _pCurScene->GetMainCha()->GetPos().y, 0);
	g_Render.SetTransformWorld(&mat);

	g_Render.GetDevice()->SetRenderState(D3DRS_ZENABLE, FALSE);
	g_Render.GetDevice()->SetRenderState(D3DRS_ALPHABLENDENABLE, FALSE);
	GetSkyBox()->Render(g_Render.GetWorldViewMatrix());
	g_Render.GetDevice()->SetRenderState(D3DRS_ZENABLE, TRUE);
	g_Render.GetDevice()->SetRenderState(D3DRS_ALPHABLENDENABLE, TRUE);
  }
#endif

  _pCurScene->_Render();
#ifdef __FPS_DEBUG__
  m_dwRenderSceneTime = tScene.End();
#endif

#ifdef TESTDEMO
	g_pTestDemo->Render();
#endif
	// 外围工具的渲染(与Scene相关, 需要在界面之前)-------------------------------------------
	_pDrawPoints->Reader();
#ifdef __EDITOR__
	g_Editor.Render();
	g_Render.RenderAllLines();
#endif
	// 界面控件的渲染-----------------------------------------------------------------------
#ifdef __FPS_DEBUG__
	LETimer tUI;
	tUI.Begin();
	LETimer tUITemp;
	tUITemp.Begin();
#endif

	_stCursorMgr.Render();
#ifdef __FPS_DEBUG__
	m_dw_stCursorMgr = tUITemp.End();
	tUITemp.Begin();
#endif
	_pCurScene->_RenderUI();
#ifdef __FPS_DEBUG__
	m_dw_pCurScene = tUITemp.End();
#endif

	// 小地图渲染----------------------------------------------------------------------------
	CCharacter* pMainCha = _pCurScene->GetMainCha();
#ifdef __FPS_DEBUG__
	LETimer mpt;
	mpt.Begin();
#endif
	if(CGameScene::_bShowMinimap && CGameScene::_pSmallMap)
	{
	  if(pMainCha)
	  {
		CGameScene::_pSmallMap->MoveTo(GetMainCam()->m_RefPos, -GetMainCam()->m_vDir,
									   GetMainCam()->m_fAngle, GetMainCam()->m_fxy / 7, pMainCha->getYaw());
		CGameScene::_pSmallMap->Render();
	  }
	}
#ifdef __FPS_DEBUG__
	m_dwRenderMMap = mpt.End();
	tUITemp.Begin();
#endif
	CFormMgr::s_Mgr.Render();
#ifdef __FPS_DEBUG__
	m_dwCFormMgr__s_Mgr_Render = tUITemp.End();
	tUITemp.Begin();
#endif
	CFormMgr::s_Mgr.RenderHint(GetMouseX(), GetMouseY());
#ifdef __FPS_DEBUG__
	m_dwCFormMgr__s_Mgr_RenderHint = tUITemp.End();
	tUITemp.Begin();
#endif
	CCursor::I()->Render();
#ifdef __FPS_DEBUG__
	m_dwCCursor__I__Render = tUITemp.End();
	tUITemp.Begin();
#endif

	if(_dwNotifyTime > GetCurTick())
	{
	  _pNotify->Render();
	} else if(_dwNotifyTime) //当公告不再需要时，清掉 Add by waiting 2009-06-10
	{
	  _pNotify->PopFront();
	  _dwNotifyTime = 0;
	}
#ifdef __FPS_DEBUG__
	m_dw_pNotify = tUITemp.End();
	tUITemp.Begin();
#endif

	if(_dwNotifyTime1 > GetCurTick())
	{
	  _pNotify1->Render();	  //Add by sunny.sun20080804
	} else if(_dwNotifyTime1) //当公告不再需要时，清掉 Add by waiting 2009-06-10
	{
	  _pNotify1->PopFront();
	  _dwNotifyTime1 = 0;
	}
#ifdef __FPS_DEBUG__
	m_dw_pNotify1 = tUITemp.End();
	tUITemp.Begin();
#endif
#ifdef __FPS_DEBUG__
	m_dwRenderUITime = tUI.End();
#endif

	ResMgr.RestoreEffect();

#ifdef __FPS_DEBUG__
	LETimer mt;
	mt.Begin();
#endif
	if(CGameScene::_pBigMap)
	  CGameScene::_pBigMap->Render();

	// 屏幕提示的渲染-----------------------------------------------------------------------
	if(_IsRenderTipText) _RenderTipText();

	if(_stMidFont.dwBeginTime > GetCurTick())
	{
	  _stMidFont.btAlpha = (BYTE)(255.0f * (float)(_stMidFont.dwBeginTime - GetCurTick()) / (float)SHOW_TEXT_TIME);

	  DWORD dwAlpha = _stMidFont.btAlpha << 24;
	  DWORD dwColor = dwAlpha | 0x00f01000;

	  SIZE size;
	  _MidFont.GetTextSize(_stMidFont.szText, &size);
	  _MidFont.DrawText(_stMidFont.szText, (GetWindowWidth() - size.cx) / 2, (GetWindowHeight() - size.cy) / 3, dwColor);
	}

	//捕获屏幕, 需要在最后-------------------------------------------------------------
	if(IsEnableSpAvi())
	  _CreateAviScreen();

#ifdef __FPS_DEBUG__
  int		y  = 80;
  const int dy = 18;
#ifdef __MEM_DEBUG__
  y += dy;
  g_Render.Print(INFO_FPS, 5, y, "==Mem==");
  char szBuf_UseMem[64];
  FormatDollorString(szBuf_UseMem, 64, GetCurUseMemory());
  y += dy;
  g_Render.Print(INFO_FPS, 15, y, "Game:%s", szBuf_UseMem);

  FormatDollorString(szBuf_UseMem, 64, ResMgr.GetCurUseMemory());
  y += dy;
  g_Render.Print(INFO_FPS, 15, y, "Eng:%s", szBuf_UseMem);

  FormatDollorString(szBuf_UseMem, 64, g_Render.GetRegisteredDevMemSize());
  y += dy;
  g_Render.Print(INFO_FPS, 15, y, "Dev:%s", szBuf_UseMem);

  //	FormatDollorString(szBuf_UseMem, 64, CLU_GetCurUseMemory());
  //	y+=dy; g_Render.Print(INFO_FPS, 15, y, "Lua:%s", szBuf_UseMem);

  FormatDollorString(szBuf_UseMem, 64, GetCurUseMemory() + ResMgr.GetCurUseMemory() + g_Render.GetRegisteredDevMemSize() /*+ CLU_GetCurUseMemory()*/);
  y += dy;
  g_Render.Print(INFO_FPS, 15, y, "Total:%s", szBuf_UseMem);
#endif //__MEM_DEBUG__

#if defined(_SKYBOX_) && defined(_DEBUG)
  y += dy;
  g_Render.Print(INFO_FPS, 5, y, "Terrain(%u)", g_dwRenderTerrainCnt == 0 ? 0 : g_dwRenderTerrainTime / g_dwRenderTerrainCnt);
  y += dy;
  g_Render.Print(INFO_FPS, 5, y, "z=(%d)", g_nPosZ);
#endif

  if(!IsEnableSuperKey())
	return;

  //	y+=dy; g_Render.Print(INFO_FPS, 5, y, "AppLoop(%u%%)",DWORD(CPerformance::GetTPS(PR_APP_LOOP)*100.0f));
  y += dy;
  g_Render.Print(INFO_FPS, 5, y, "FrmMove(%u%%), %2d/%2d ", DWORD(CPerformance::GetTPS(PR_FRAME_MOVE) * 100.0f), GetFrameMoveUseTime(), GetRenderUseTime());
  y += dy;
  g_Render.Print(INFO_FPS, 5, y, "Render(%u%%)", DWORD(CPerformance::GetTPS(PR_RENDER) * 100.0f));
  y += dy;
  g_Render.Print(INFO_FPS, 5, y, "Net(%u%%)", DWORD(CPerformance::GetTPS(PR_NET) * 100.0f));

  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  g_Render.EnableClearTarget(TRUE);

  LETerrain* pCurTerrain = pScene->GetTerrain();

  // 输出项目列表

  // Performance :

  // FPS
  // 系统总多边形数量  FrameMove时间  渲染时间
  // 场景物件总数  多边形数量  渲染时间
  // 角色总数      多边形数量  渲染时间

  // 特效总数      渲染时间
  // 系统占用内存  占用显存

  // GameLogic :

  // 主角名字 坐标  方向
  // 模型信息 装备
  if(pCurTerrain)
  {
	DWORD dwTerrainTime = pCurTerrain->m_dwTerrainRenderTime;
	DWORD dwSeaTime		= pCurTerrain->m_dwSeaRenderTime;
	char  szInfo[255];
	_snprintf_s(szInfo, _countof(szInfo), _TRUNCATE, "O:%2d Trans:%2d Eff:%2d C:%2d U:%2d T:%2d E:%2d CH:%2d Path:%2d S:%2d",
				m_dwRenderScneObjTime,
				m_dwTranspObjTime,
				m_dwRenderEffectTime,
				m_dwRenderChaTime,
				m_dwRenderUITime,
				dwTerrainTime, dwSeaTime,
				CGameApp::GetCurScene()->m_dwValidChaCnt,
				m_dwPathFinding,
				m_dwRenderSceneTime);
	y += dy;
	g_Render.Print(INFO_FPS, 5, y, "%s", szInfo);

	_snprintf_s(szInfo, _countof(szInfo), _TRUNCATE, "U=FM:%2d CM:%2d CS:%2d Hint:%2d Cur:%2d N:%2d N1:%2d M:%2d",
				m_dwCFormMgr__s_Mgr_Render,
				m_dw_stCursorMgr,
				m_dw_pCurScene,
				m_dwCFormMgr__s_Mgr_RenderHint,
				m_dwCCursor__I__Render,
				m_dw_pNotify,
				m_dw_pNotify1,
				m_dwRenderMMap);
	y += dy;
	g_Render.Print(INFO_FPS, 5, y, "%s", szInfo);

	// 		MPStaticStreamMgrDebugInfo ssmdi;
	// 		MPIStaticStreamMgr* ssm = g_Render.GetInterfaceMgr()->res_mgr->GetStaticStreamMgr();
	// 		ssm->GetDebugInfo(&ssmdi);
	// 		_snprintf_s( szInfo, _countof( szInfo ), _TRUNCATE,  "VB total:%d, used:%d, free:%d, locked:%d\nIB total:%d, used:%d, free:%d, locked:%d",
	// 			ssmdi.vbs_size, ssmdi.vbs_used_size, ssmdi.vbs_free_size, ssmdi.vbs_locked_size,
	// 			ssmdi.ibs_size, ssmdi.ibs_used_size, ssmdi.ibs_free_size, ssmdi.ibs_locked_size);
	// 		y+=dy; g_Render.Print(INFO_FPS, 5, y, "%s", szInfo);

#if 0
		{
			char buf[256];
			lwWatchDevVideoMemInfo* info = g_Render.GetInterfaceMgr()->dev_obj->GetWatchVideoMemInfo();
			_snprintf_s( buf, _countof( buf ), _TRUNCATE,  "total: %d, tex: %d, vbib: %d\n",
				info->alloc_tex_size + info->alloc_vb_size + info->alloc_ib_size,
				info->alloc_tex_size,
				info->alloc_vb_size + info->alloc_ib_size
				);
			LG("vdmem", buf);
		}
#endif
  }
#endif // __FPS_DEBUG__
}
