#include "StdAfx.h"
#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "GameApp.h"
#include "Character.h"
#include "SceneObj.h"
#include "SceneItem.h"
#include "EffectObj.h"
#include "Scene.h"
#include "GameConfig.h"
#include "LEFont.h"
#include "SceneObjSet.h"
#include "UIRender.h"
#include "Scene.h"
#include "LuaInterface.h"
#include "PacketCmd.h"
#include "MapSet.h"
#include "CharacterRecord.h"
#include "uiTextButton.h"
#include "UIEditor.h"
#include "SteadyFrame.h"
#include "LERender.h"

extern CGameApp* g_pGameApp;

enum ePanelNum
{
  eCha_Panel = 0,
  eObj_Panel = 1,
  eEff_Panel = 4,
};

#ifdef __EDITOR__
void MPEditor::Init(int nMapID)
{
  m_nBrushNo				 = 1;
  m_bModifyHeight			 = FALSE;
  m_bEditWater				 = FALSE;
  m_nBrushHeight			 = 60;
  m_bEnableTextureAlphaBlend = TRUE;
  m_bShowHeightmap			 = FALSE;
  _pSelSceneObj				 = NULL;
  _pSelEff					 = NULL;
  m_nCurShowPanel			 = 0;
  //
  m_bSmooth = false;

  _AttribIndex = 0;
  _IslandIndex = TILE_ISLAND_MAX_VALUE + 1; // 置个非法值
  _is_erase	   = false;

  /*
    CMapInfo *pMapInfo = GetMapInfo(nMapID);
    if(pMapInfo)
    {
        char szTip[64]; sprintf_s(szTip, "开始编辑地图[%s]", pMapInfo->szName);

		LEMapFileHeader maphdr;
		if (_getMapHeader(pMapInfo->szName, maphdr))
			{
			if (createAttribFile(pMapInfo->szName, maphdr.nWidth, maphdr.nHeight))
				openAttribFile(pMapInfo->szName); // 会自动关闭文件
			Tip(szTip);
			}
		else
			LG("error", "msgread header of %s.map failed", pMapInfo->szName);
    }
    else
    {
        LG("error", "msg没有找到地图列表信息 MapID = %d\n", nMapID);
    }
    */

  _dwColor = 0xffff0000;
  // begin by lsh
  // call 13
  _dwColor = D3DCOLOR_XRGB(89, 168, 158);
  // end

  m_nSelTexNo = 0;
  m_nSelectX  = -1;
  m_nSelectY  = -1;

  m_oldnX = 0;
  m_oldnY = 0;

  m_nSelTypeID	  = 0;
  m_bIsBrushColor = false;

  m_bLockObj = FALSE;

  bPitchWatch = FALSE;

  Enable(FALSE);
}

LETerrain* MPEditor::GetCurTerrain()
{
  CGameScene* pScene = g_pGameApp->GetCurScene();
  if(!pScene) return NULL;

  LETerrain* pCurTerrain = pScene->GetTerrain();
  return pCurTerrain;
}

CGameScene* MPEditor::GetCurScene()
{
  return g_pGameApp->GetCurScene();
}

void MPEditor::Enable(BOOL bEnable)
{
  if(bEnable && g_Config.m_bEditor == FALSE) return;

  _bEnable = bEnable;

  TipI(_bEnable, RES_STRING(CL_LANGUAGE_MATCH_198), RES_STRING(CL_LANGUAGE_MATCH_199));

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;

  if(!bEnable)
  {
	if(_pSelSceneObj && _pSelSceneObj->IsValid())
	{
	  //_pSelSceneObj->ShowBoundingObject(0);
	  _pSelSceneObj->ShowHelperObject(0);
	  _pSelSceneObj = NULL;
	  m_bLockObj	= FALSE;
	}
	GetCurScene()->ShowChairObj(0);
  }

  pCurTerrain->ShowCenterPoint(bEnable);
}

void MPEditor::PlaceTerrainByBrush()
{
  if(m_nSelTexNo == 1)
  {
	SetTerrainInvalid(m_nBrushNo);
	// PlaceTerrain(m_nBrushNo, m_nSelectX, m_nSelectY, 0);
  } else
  {
	PlaceTerrain(m_nBrushNo, m_nSelectX, m_nSelectY, m_nSelTexNo);
  }
}

void MPEditor::SetTerrainColor(int nType, BOOL bReturn, BOOL bRollBack)
{
  if(m_nSelectX == -1 || m_nSelectY == -1) return;

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;
  //pCurTerrain->m_bEdit = TRUE;

  DWORD			dwColor;
  int			nX, nY, BrushNo;
  ActionStruct* action;
  if(bReturn)
  {
	dwColor = 0xffffffff;
	action	= _Action.back();
	nX		= int(action->_fxpos);
	nY		= int(action->_fypos);
	BrushNo = action->_brushno;
  } else if(bRollBack)
  {
	action	= _Action.back();
	dwColor = action->_dwcolor;
	nX		= int(action->_fxpos);
	nY		= int(action->_fypos);
	BrushNo = action->_brushno;
  } else
  {
	dwColor			 = _dwColor;
	action			 = new ActionStruct;
	nX				 = m_nSelectX;
	nY				 = m_nSelectY;
	BrushNo			 = m_nBrushNo;
	action->_eType	 = enumSetTerrainColor;
	action->_nType	 = nType;
	action->_dwcolor = dwColor;
	action->_fxpos	 = float(nX);
	action->_fypos	 = float(nY);
	action->_brushno = BrushNo;
	AddAction(action);
  }

  LETile* pCurTile = NULL;
  float	  fSize	   = 2.0f;
  int	  sx	   = nX - (int)(fSize / 2.0f);
  int	  sy	   = nY - (int)(fSize / 2.0f);

  if(BrushNo == 1)
  {
	pCurTerrain->GetGroupTile(nX, nY, 3)->dwColor = dwColor;
	return;
  } else if(BrushNo == 2)
  {
	for(int i = 0; i < 4; i++)
	{
	  LETile* pCurTile	= pCurTerrain->GetGroupTile(nX, nY, i);
	  pCurTile->dwColor = dwColor;
	}
	return;
  } else
  {
	fSize = 5.0f;
	sx	  = nX - 1;
	sy	  = nY - 1;
  }

  VECTOR3 vec1((float)(nX + 1.0f), (float)(nY + 1.0f), 0.0f);

  for(int y = 0; y < 5.0f; y++)
  {
	for(int x = 0; x < 5.0f; x++)
	{
	  int	  nCurX	   = sx + x;
	  int	  nCurY	   = sy + y;
	  LETile* pCurTile = pCurTerrain->GetTile(nCurX, nCurY);
	  if(!pCurTile) continue;

	  VECTOR3 vec2((float)nCurX, (float)nCurY, 0.0f);
	  float	  fDis = ::DistanceFrom(vec1, vec2);

	  if(fDis >= 2.0f) continue;

	  pCurTile->dwColor = dwColor;
	}
  }
}

void MPEditor::SetTerrainColor2(int nType, BOOL bReturn, BOOL bRollBack)
{
  if(m_nSelectX == -1 || m_nSelectY == -1) return;

  LETerrain* pTerrain = GetCurTerrain();
  if(!pTerrain) return;
  //pTerrain->m_bEdit = TRUE;

  D3DXCOLOR		dwColor;
  float			fRange, fx, fy;
  int			BrushNo;
  ActionStruct* action;

  if(bReturn)
  {
	action	= _Action.back();
	dwColor = 0xffffffff;
	fx		= action->_fxpos;
	fy		= action->_fypos;
	BrushNo = action->_brushno;
  } else if(bRollBack)
  {
	action	= _Action.back();
	dwColor = action->_dwcolor;
	fx		= action->_fxpos;
	fy		= action->_fypos;
	BrushNo = action->_brushno;
  } else
  {
	dwColor			 = _dwColor;
	action			 = new ActionStruct;
	fx				 = GetCurScene()->GetMouseMapX();
	fy				 = GetCurScene()->GetMouseMapY();
	BrushNo			 = m_nBrushNo;
	action->_eType	 = enumSetTerrainColor2;
	action->_nType	 = nType;
	action->_dwcolor = dwColor;
	action->_fxpos	 = fx;
	action->_fypos	 = fy;
	action->_brushno = BrushNo;
	AddAction(action);
  }

  if(BrushNo == 1)
  {
	fRange = 1;
  } else if(BrushNo == 2)
  {
	fRange = 5;
  } else
	fRange = 15;

  int	y	 = 0;
  int	x	 = 0;
  float _fx	 = fx - fRange + 1;
  float _fy	 = fy - fRange + 1;
  float _ftx = fx + fRange + 1;
  float _fty = fy + fRange + 1;

  LETile*	pTile = NULL;
  D3DXCOLOR tcolor;
  for(int y = (int)_fy; y < (int)_fty; y++)
  {
	for(int x = (int)_fx; x < (int)_ftx; x++)
	{
	  if(y < 0 || x < 0)
		continue;

	  pTile = pTerrain->GetTile(x, y);
	  if(!pTile)
		continue;
	  float		fd		   = D3DXVec2Length(&(D3DXVECTOR2(float(x), float(y)) - D3DXVECTOR2(fx, fy)));
	  D3DXCOLOR dwOrgColor = (D3DXCOLOR)pTile->dwColor;

	  float flerp = fd / (fRange);
	  if(flerp > 1) flerp = 1;

	  D3DXColorLerp(&tcolor, &dwColor, &dwOrgColor, flerp);
	  if(bReturn)
	  {
		pTile->dwColor = dwColor;
	  } else
	  {
		pTile->dwColor = tcolor;
	  }
	}
  }
}

void MPEditor::PlaceTerrain(int nType, int nX, int nY, int nTexNo)
{
  if(nTexNo == 0) return;

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;
  //pCurTerrain->m_bEdit = TRUE;

  nX = m_nSelectX;
  nY = m_nSelectY;

  if(nX < 0 || nY < 0) return;

  if(nType == 1)
  {
	// 1号刷, 四个角
	int nAlphaNo[4] = {1, 2, 4, 8};
	for(int i = 0; i < 4; i++)
	{
	  LETile* pTile = pCurTerrain->GetTile(nX + LETile::Offset[i][0], nY + LETile::Offset[i][1]);
	  if(pTile) pTile->AddTexLayer(nTexNo, nAlphaNo[i]);
	}
	return;
  } else if(nType == 2)
  {
	// 2号刷，画4个Tile
	for(int i = 0; i < 2; ++i)
	  for(int j = 0; j < 2; ++j)
	  {
		int x = nX + (j - 1);
		int y = nY + (i - 1);

		LETile* pTile = pCurTerrain->GetTile(x, y);
		if(!pTile) return;

		pTile->AddTexLayer(nTexNo, 15);

		if(m_bEnableTextureAlphaBlend == FALSE) continue; // 不产生过渡

		pTile = pCurTerrain->GetTile(x - 1, y - 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 1);

		pTile = pCurTerrain->GetTile(x, y - 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 3);

		pTile = pCurTerrain->GetTile(x + 1, y - 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 2);

		pTile = pCurTerrain->GetTile(x - 1, y);
		if(pTile) pTile->AddTexLayer(nTexNo, 5);

		pTile = pCurTerrain->GetTile(x + 1, y);
		if(pTile) pTile->AddTexLayer(nTexNo, 10);

		pTile = pCurTerrain->GetTile(x - 1, y + 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 4);

		pTile = pCurTerrain->GetTile(x, y + 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 12);

		pTile = pCurTerrain->GetTile(x + 1, y + 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 8);
	  }
  } else if(nType == 3)
  {
	// 3号刷，画16个Tile
	for(int i = 0; i < 4; ++i)
	  for(int j = 0; j < 4; ++j)
	  {
		int x = nX + (j - 2);
		int y = nY + (i - 2);

		LETile* pTile = pCurTerrain->GetTile(x, y);
		if(!pTile) return;

		pTile->AddTexLayer(nTexNo, 15);

		if(m_bEnableTextureAlphaBlend == FALSE) continue; // 不产生过渡

		pTile = pCurTerrain->GetTile(x - 1, y - 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 1);

		pTile = pCurTerrain->GetTile(x, y - 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 3);

		pTile = pCurTerrain->GetTile(x + 1, y - 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 2);

		pTile = pCurTerrain->GetTile(x - 1, y);
		if(pTile) pTile->AddTexLayer(nTexNo, 5);

		pTile = pCurTerrain->GetTile(x + 1, y);
		if(pTile) pTile->AddTexLayer(nTexNo, 10);

		pTile = pCurTerrain->GetTile(x - 1, y + 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 4);

		pTile = pCurTerrain->GetTile(x, y + 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 12);

		pTile = pCurTerrain->GetTile(x + 1, y + 1);
		if(pTile) pTile->AddTexLayer(nTexNo, 8);
	  }
  }
}

void MPEditor::SetTerrainInvalid(int nType)
{
  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;
  //pCurTerrain->m_bEdit = TRUE;

  int nX = m_nSelectX;
  int nY = m_nSelectY;

  if(nX < 0 || nY < 0) return;

  if(nType == 1)
  {
	LETile* pTile = pCurTerrain->GetTile(nX, nY);
	if(pTile) pTile->AddTexLayer(0, 15);
	return;
  } else if(nType == 2)
  {
	// 2号刷，画4个Tile
	for(int i = 0; i < 2; ++i)
	  for(int j = 0; j < 2; ++j)
	  {
		LETile* pTile = pCurTerrain->GetTile(nX + (j - 1), nY + (i - 1));
		if(pTile == NULL) return;

		pTile->AddTexLayer(0, 15);
	  }
  } else if(nType == 3)
  {
	// 3号刷，画16个Tile
	for(int i = 0; i < 4; ++i)
	  for(int j = 0; j < 4; ++j)
	  {
		LETile* pTile = pCurTerrain->GetTile(nX + (j - 2), nY + (i - 2));
		if(pTile == NULL) return;

		pTile->AddTexLayer(0, 15);
	  }
  }
}

void MPEditor::ModifyHeight(float fStep, float fResetHeight, BOOL bReturn, BOOL bRollBack)
{
  if(m_nSelectX == -1 || m_nSelectY == -1) return;

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;
  //pCurTerrain->m_bEdit = TRUE;

  int			nX, nY, BrushNo;
  vector<float> fHeights;
  ActionStruct* action;
  if(bReturn || bRollBack)
  {
	action	 = _Action.back();
	fHeights = action->_fHeights;
	nX		 = int(action->_fxpos);
	nY		 = int(action->_fypos);
	BrushNo	 = action->_brushno;
  } else
  {
	action				  = new ActionStruct;
	nX					  = m_nSelectX;
	nY					  = m_nSelectY;
	BrushNo				  = m_nBrushNo;
	action->_eType		  = enumModifyHeight;
	action->_fxpos		  = float(nX);
	action->_fypos		  = float(nY);
	action->_brushno	  = BrushNo;
	action->_fStep		  = fStep;
	action->_fResetHeight = fResetHeight;
  }

  if(bRollBack)
	reverse(fHeights.begin(), fHeights.end());

  LETile* pCurTile = NULL;

  float fSize = 2.0f;
  int	sx	  = nX - (int)(fSize / 2.0f);
  int	sy	  = nY - (int)(fSize / 2.0f);

  if(BrushNo == 1)
  {
	if(bReturn || bRollBack)
	{
	  pCurTerrain->GetGroupTile(nX - 1, nY - 1, 3)->setHeight(fHeights.back());
	  fHeights.pop_back();
	} else
	{
	  fHeights.push_back(pCurTerrain->GetGroupTile(nX - 1, nY - 1, 3)->getHeight());
	  if(fResetHeight > -10.0f)
	  {
		pCurTerrain->GetGroupTile(nX - 1, nY - 1, 3)->setHeight(fResetHeight);
	  } else
	  {
		float fEffectRatio = CalculateCircleRate(1.0f);
		pCurTerrain->GetGroupTile(nX - 1, nY - 1, 3)->AddHeight(fEffectRatio * fStep * 0.01f);
	  }
	  action->_fHeights = fHeights;
	  AddAction(action);
	}
	return;
  } else if(BrushNo == 2)
  {
	for(int i = 0; i < 4; i++)
	{
	  LETile* pCurTile = pCurTerrain->GetGroupTile(nX, nY, i);
	  if(bReturn || bRollBack)
	  {
		pCurTile->setHeight(fHeights.back());
		fHeights.pop_back();
	  } else
	  {
		fHeights.push_back(pCurTile->getHeight());
		if(pCurTile->fHeight < 8.0f)
		{
		  if(fResetHeight > -10.0f)
		  {
			pCurTile->setHeight(fResetHeight);
		  } else
		  {
			float fEffectRatio = CalculateCircleRate(1.0f);
			pCurTile->AddHeight(fEffectRatio * fStep * 0.01f);
		  }
		}
	  }
	}
	if(!bReturn && !bRollBack)
	{
	  reverse(fHeights.begin(), fHeights.end());
	  action->_fHeights = fHeights;
	  AddAction(action);
	}
	return;
  } else if(BrushNo == 3)
  {
	fSize = 5.0f;
	nX -= 1;
	nY -= 1;

	sx = nX - 1;
	sy = nY - 1;
  } else
  {
	fSize = 5.0f;
	sx	  = nX - 1;
	sy	  = nY - 1;
  }

  VECTOR3 vec1((float)(nX + 1.0f), (float)(nY + 1.0f), 0.0f);

  for(int y = 0; y < 5.0f; y++)
  {
	for(int x = 0; x < 5.0f; x++)
	{
	  int	  nCurX	   = sx + x;
	  int	  nCurY	   = sy + y;
	  LETile* pCurTile = pCurTerrain->GetTile(nCurX, nCurY);
	  if(!pCurTile) continue;

	  VECTOR3 vec2((float)nCurX, (float)nCurY, 0.0f);
	  float	  fDis = ::DistanceFrom(vec1, vec2);

	  if(fDis >= 2.0f) continue;

	  if(bReturn || bRollBack)
	  {
		pCurTile->setHeight(fHeights.back());
		fHeights.pop_back();
	  } else
	  {
		fHeights.push_back(pCurTile->getHeight());
		if(pCurTile->fHeight < 8.0f)
		{
		  if(fResetHeight > -10.0f)
		  {
			pCurTile->setHeight(fResetHeight);
		  } else
		  {
			float fEffectRatio = CalculateCircleRate((3.5f - fDis) / 4.0f);
			pCurTile->AddHeight(fEffectRatio * fStep * 0.02f);
		  }
		}
	  }
	}
  }
  if(!bReturn && !bRollBack)
  {
	reverse(fHeights.begin(), fHeights.end());
	action->_fHeights = fHeights;
	AddAction(action);
  }
}

void MPEditor::_RenderSelTile(int nX, int nY)
{
  struct MPSelectTileVertex
  {
	D3DXVECTOR3 p;
	DWORD		dwColor;
  };

  MPSelectTileVertex v[4];

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;
  //pCurTerrain->m_bEdit = TRUE;

  for(int i = 0; i < 4; i++)
  {
	int x = nX + LETile::Offset[i][0];
	int y = nY + LETile::Offset[i][1];

	v[i].dwColor = D3DCOLOR_ARGB(125, 80, 255, 80);

	LETile* pTile = pCurTerrain->GetTile(x, y);
	if(pTile->IsDefault())
	{
	  v[i].p = VECTOR3((float)x, (float)y, SEA_LEVEL + 0.01f);
	} else
	{
	  v[i].p = VECTOR3((float)x, (float)y, pTile->fHeight + 0.01f);
	}
  }

  g_Render.GetDevice()->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, &v, sizeof(MPSelectTileVertex));
}

void MPEditor::SystemReport(DWORD dwTimeParam)
{
  if(!g_pGameApp->IsEnableSuperKey()) return;

  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  g_Render.EnableClearTarget(TRUE);

#ifdef __FPS_DEBUG__
  LETerrain* pCurTerrain = GetCurTerrain();

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
  static DWORD g_dwLastReportTick = 0;
  DWORD		   dwTerrainTime	  = 0;
  DWORD		   dwSeaTime		  = 0;
  if(pCurTerrain)
  {
	dwTerrainTime = pCurTerrain->m_dwTerrainRenderTime;
	dwSeaTime	  = pCurTerrain->m_dwSeaRenderTime;
  }
  if(dwTimeParam - g_dwLastReportTick > 500)
  {
	char szInfo[255];
	_snprintf_s(szInfo, _countof(szInfo), _TRUNCATE, "A:%2d F:%2d S:%2d O:%2d C:%2d U:%2d T:%2d E:%2d M:%2d CH:%2d",
				g_pGameApp->GetRenderUseTime(),
				g_pGameApp->GetFrameMoveUseTime(),
				g_pGameApp->m_dwRenderSceneTime,
				g_pGameApp->m_dwRenderScneObjTime,
				g_pGameApp->m_dwRenderChaTime,
				g_pGameApp->m_dwRenderUITime,
				dwTerrainTime, dwSeaTime,
				g_pGameApp->m_dwRenderMMap,
				CGameApp::GetCurScene()->m_dwValidChaCnt);

	//if(g_pGameApp->m_dwRenderUITime > 0)
	g_Render.Print(INFO_PERF, 10, 5, "%s", szInfo);

	MPStaticStreamMgrDebugInfo ssmdi;
	MPIStaticStreamMgr*		   ssm = g_Render.GetInterfaceMgr()->res_mgr->GetStaticStreamMgr();
	ssm->GetDebugInfo(&ssmdi);
	_snprintf_s(szInfo, _countof(szInfo), _TRUNCATE, "VB total:%d, used:%d, free:%d, locked:%d\nIB total:%d, used:%d, free:%d, locked:%d",
				ssmdi.vbs_size, ssmdi.vbs_used_size, ssmdi.vbs_free_size, ssmdi.vbs_locked_size,
				ssmdi.ibs_size, ssmdi.ibs_used_size, ssmdi.ibs_free_size, ssmdi.ibs_locked_size);

	g_Render.Print(INFO_PERF, 200, 200, "%s", szInfo);

	GPL("perf", 10, 4, RES_STRING(CL_LANGUAGE_MATCH_200), g_Render.GetFPS(), CGameApp::GetFrameFPS(),
		g_pGameApp->GetRenderUseTime(),
		g_pGameApp->GetFrameMoveUseTime(),
		g_NetIF->m_curdelay,
		g_NetIF->m_maxdelay,
		g_NetIF->m_mindelay);

	GPL("perf", 10, 22, RES_STRING(CL_LANGUAGE_MATCH_201),
		pScene->m_dwValidChaCnt,
		pScene->m_dwChaPolyCnt,
		pScene->m_dwChaRenderTime,
		pScene->m_dwValidEffCnt);

	GPL("perf", 10, 40, RES_STRING(CL_LANGUAGE_MATCH_202), pScene->m_dwValidSceneObjCnt,
		pScene->m_dwRenderSceneObjCnt,
		pScene->m_dwSceneObjPolyCnt,
		pScene->m_dwSceneObjRenderTime,
		pScene->m_dwCullingTime);

	if(pCurTerrain)
	{
	  GPL("perf", 10, 58, RES_STRING(CL_LANGUAGE_MATCH_203), pCurTerrain->m_dwTerrainRenderTime,
		  pCurTerrain->m_dwSeaRenderTime,
		  pCurTerrain->m_dwTerrainRenderTime + pCurTerrain->m_dwSeaRenderTime,
		  g_pGameApp->m_dwRenderUITime, g_pGameApp->m_dwRenderSceneTime);

	  GPL("perf", 10, 76, RES_STRING(CL_LANGUAGE_MATCH_204), pCurTerrain->m_dwActiveSectionCnt, pCurTerrain->m_dwLoadingTime[0], pCurTerrain->m_dwLoadingTime[1], pCurTerrain->m_dwLoadingTime[2], pCurTerrain->m_dwMaxLoadingTime);
	}

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

	g_dwLastReportTick = dwTimeParam;
  }

  // by lsh
  char buf[1024];
  _snprintf_s(buf, _countof(buf), _TRUNCATE,
			  "FPS:%3d-%3d, R:%3d F:%3d, S:%3d, SO:%3d, SC:%3d, SE:%3d, MM:%3d, SX:%3d, ST:%3d, SS:%3d, SU:%3d L:%3d, P:%3d, M:%3d\n",
			  g_Render.GetFPS(),
			  CGameApp::GetFrameFPS(),
			  g_pGameApp->GetRenderUseTime(),
			  g_pGameApp->GetFrameMoveUseTime(),
			  g_pGameApp->m_dwRenderSceneTime,
			  g_pGameApp->m_dwRenderScneObjTime,
			  g_pGameApp->m_dwRenderChaTime,
			  g_pGameApp->m_dwRenderEffectTime,
			  g_pGameApp->m_dwRenderMMap,
			  g_pGameApp->m_dwTranspObjTime,
			  dwTerrainTime,
			  dwSeaTime,
			  g_pGameApp->m_dwRenderUITime,
			  g_pGameApp->m_dwLoadingObjTime,
			  g_pGameApp->m_dwPathFinding,
			  g_nTemp);

  fwrite(buf, strlen(buf), 1, _fp);

  //LG("fps", "FPS:%3d, R:%3d F:%3d, S:%3d, SO:%3d, SC:%3d, SE:%3d, SX:%3d, ST:%3d, SS:%3d, SU:%3d L:%3d, M:%3d\n",
  //    g_Render.GetFPS(),
  //    g_pGameApp->GetRenderUseTime(),
  //    g_pGameApp->GetFrameMoveUseTime(),
  //    g_pGameApp->m_dwRenderSceneTime,
  //    g_pGameApp->m_dwRenderScneObjTime,
  //    g_pGameApp->m_dwRenderChaTime,
  //    g_pGameApp->m_dwRenderEffectTime,
  //    g_pGameApp->m_dwTranspObjTime,
  //    dwTerrainTime,
  //    dwSeaTime,
  //    g_pGameApp->m_dwRenderUITime,
  //    g_pGameApp->m_dwLoadingObjTime,
  //    g_nTemp
  //    );
  // end
#endif //__FPS_DEBUG__
}

using namespace std;

void MPEditor::FrameMove(DWORD dwTimeParam)
{
  SystemReport(dwTimeParam);
  HandleKeyContinue();

  // 对怪物进行统计

  if(g_Config.m_bEditor)
  {
	//g_Render.EnablePrint(INFO_DEBUG, TRUE);
	short sMonsterStatus[1000]; // 1000怪的数量
	memset(sMonsterStatus, 0, 1000 * 2);

	CGameScene* pScene = GetCurScene();
	if(pScene)
	{
	  char szRelive[12];
	  for(int i = 0; i < pScene->GetChaCnt(); i++)
	  {
		CCharacter* pCha = pScene->GetCha(i);
		if(pCha->IsValid())
		{
		  sMonsterStatus[pCha->getTypeID()]++;
		  _snprintf_s(szRelive, _countof(szRelive), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_205), pCha->getReliveTime());
		  pCha->setSecondName(szRelive);
		}
	  }
	  int x		 = 600;
	  int y		 = 300;
	  int nTotal = 0;
	  for(int i = 0; i < 1000; i++)
	  {
		if(sMonsterStatus[i] > 0)
		{
		  CChaRecord* pInfo = GetChaRecordInfo(i);
		  g_Render.Print(INFO_DEBUG, x, y, "[%d] %s %d", i, pInfo->szDataName, sMonsterStatus[i]);
		  y = y + 20;
		  nTotal += sMonsterStatus[i];
		}
	  }
	  g_Render.Print(INFO_DEBUG, x, y, RES_STRING(CL_LANGUAGE_MATCH_206), nTotal);
	}
  }

  if(!_bEnable) return;

  int nStartX = g_Render.GetScrWidth() - 280;
  int nStartY = g_Render.GetScrHeight() - 100;

  CGameScene* pCurScene = GetCurScene();
  if(!pCurScene) return;

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;

  pCurTerrain->UpdateRender(TRUE);

  // g_Render.Print(INFO_DEBUG, nStartX, nStartY,       "Center = %.1f, %.1f", pCurTerrain->GetShowCenterX(), pCurTerrain->GetShowCenterY());
  // g_Render.Print(INFO_DEBUG, nStartX, nStartY + 20,  "Brush Height = %d", m_nBrushHeight);

  if(m_nSelTypeID)
  {
	int nX = (int)(pCurScene->GetMouseMapX() * 100.0f);
	int nY = (int)(pCurScene->GetMouseMapY() * 100.0f);
	switch(m_nCurShowPanel)
	{
	case 0:
	{
	  CCharacter* pSelCha = pCurScene->GetCha(m_nSelID);
	  pSelCha->setPos(nX, nY);
	  g_Render.Print(INFO_DEBUG, 200, nStartY, "Sel Angle = %d\n", FixAngle(pSelCha->getYaw()));
	  break;
	}
	case 1:
	case 2:
	case 3:
	{
	  CSceneObj* pSelObj = pCurScene->GetSceneObj(m_nSelID);
	  pSelObj->setPos(nX / 10 * 10, nY / 10 * 10);
	  break;
	}
	case 4:
	{
	  CEffectObj* pEff = pCurScene->GetEffect(m_nSelID);
	  pEff->setPos(nX, nY);
	  break;
	}
	}
  }

  SelectSceneObj();
  SelectEffectObj();
}

void MPEditor::Render()
{
  if(m_bShowHeightmap) _RenderHeightmap();

  if(!_bEnable) return;

  CGameScene* pCurScene = GetCurScene();
  if(!pCurScene) return;

  float fX = pCurScene->GetMouseMapX();
  float fY = pCurScene->GetMouseMapY();

  float const fTileSize = 1.0f;			 // 长宽一样
  float const fTileMod	= fTileSize / 2; // 半长
  int		  tx		= int(fX);
  int		  ty		= int(fY);

  if((m_bModifyHeight && m_nBrushNo == 1) || (!m_bModifyHeight && m_nBrushNo == 2) || m_nBrushNo == 3) // 2号刷和3号刷是需要修正坐标的
  {
	if(fX - tx > fTileMod)
	  tx += 1;
	if(fY - ty > fTileMod)
	  ty += 1;
  }

  int nX = tx;
  int nY = ty;

  m_nSelectX = nX;
  m_nSelectY = nY;

  // 如果处在下面条件的编辑状态，不需要渲染刷子
  if(m_nSelTypeID) return;

  g_Render.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_DIFFUSE);
  g_Render.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_CURRENT);
  g_Render.SetTextureStageState(0, D3DTSS_COLOROP, D3DTOP_SELECTARG1);
  g_Render.SetTexture(1, 0);
  g_Render.SetTexture(0, 0);
  g_Render.SetRenderState(D3DRS_COLORVERTEX, TRUE);
  g_Render.SetVertexShader(D3DFVF_XYZ | D3DFVF_DIFFUSE);
  g_Render.EnableZBuffer(FALSE);
  g_Render.EnableAlpha(TRUE);
  g_Render.SetRenderState(D3DRS_CULLMODE, D3DCULL_CCW); // 单面渲染
  g_Render.SetRenderState(D3DRS_LIGHTING, FALSE);
  g_Render.SetRenderState(D3DRS_FILLMODE, D3DFILL_SOLID);
  g_Render.SetRenderState(D3DRS_SRCBLEND, D3DBLEND_SRCALPHA);	  // blend the colors based on the
  g_Render.SetRenderState(D3DRS_DESTBLEND, D3DBLEND_INVSRCALPHA); // alpha value

  D3DXMATRIX mat_identity;
  D3DXMatrixIdentity(&mat_identity);

  g_Render.SetTransformWorld(&mat_identity);

  if(_AttribIndex == 0 && (_IslandIndex == 0 || (_IslandIndex == TILE_ISLAND_MAX_VALUE + 1)))
  {
	if(m_nBrushNo == 1)
	{
	  // 画1个Tile
	  _RenderSelTile(nX, nY);
	} else if(m_nBrushNo == 2)
	{
	  // 画4个Tile
	  for(int i = 0; i < 2; ++i)
		for(int j = 0; j < 2; ++j)
		  _RenderSelTile(nX + (j - 1), nY + (i - 1));
	} else if(m_nBrushNo == 3)
	{
	  // 画16个Tile
	  for(int i = 0; i < 4; ++i)
		for(int j = 0; j < 4; ++j)
		  _RenderSelTile(nX + (j - 2), nY + (i - 2));
	}
  } else
  {
	LETerrain* pCurTerrain = GetCurTerrain();
	if(!pCurTerrain) return;

	int _nStarPosX = 0;
	int _nStarPosY = 0;
	int _nEndPosX  = 0;
	int _nEndPosY  = 0;

	int nCenterX = nX;
	int nCenterY = nY;

	static D3DXVECTOR3 vecCenterPos;
	if(!g_pGameApp->IsCameraFollow())
	{
	  int nScrFocus = g_Render.GetScrHeight() / 2;

	  CGameScene* pScene = CGameApp::GetCurScene();
	  if(pScene->GetTerrain())
	  {
		//if(g_pGameApp->GetCurScene()->GetPickPos(g_Render.GetScrWidth() / 2, nScrFocus, vecCenterPos))
		if(pScene->GetTerrain()->GetPickPosEditor(g_Render.GetScrWidth() / 2, nScrFocus, vecCenterPos))
		{
		  nCenterX = (int)vecCenterPos.x;
		  nCenterY = (int)vecCenterPos.y;
		}
	  }
	}

	if((nCenterX - 30) >= 0)
	{
	  _nStarPosX = nCenterX - 30;
	} else
	{
	  _nStarPosX = 0;
	}

	if((nCenterX + 30) < (pCurTerrain->GetWidth() - 1))
	{
	  _nEndPosX = nCenterX + 50;
	} else
	{
	  _nEndPosX = pCurTerrain->GetWidth() - 2;
	}
	///Y
	if((nCenterY - 30) >= 0)
	{
	  _nStarPosY = nCenterY - 30;
	} else
	{
	  _nStarPosY = 0;
	}
	if((nCenterY + 30) < (pCurTerrain->GetHeight() - 1))
	{
	  _nEndPosY = nCenterY + 30;
	} else
	{
	  _nEndPosX = pCurTerrain->GetHeight() - 2;
	}

	// add by claude for rendering tile attrib
	byte btIslandIndex = byte(_IslandIndex);
	for(int i = _nStarPosY; i <= _nEndPosY; ++i)
	{
	  for(int j = _nStarPosX; j <= _nEndPosX; ++j)
	  {
		LETile* pTile = pCurTerrain->GetTile(j, i);
		// render Tile Attrib
		if(_AttribIndex != 0)
		{
		  // if (hasTileAttrib(j, i, _getTileAttribMask(_AttribIndex)))
		  if(pTile->IsRegion(_AttribIndex))
			_renderTileAttrib(j, i, _AttribIndex);
		}

		// render Tile Island
		if(_IslandIndex > 0 && _IslandIndex <= TILE_ISLAND_MAX_VALUE)
		{
		  // byte idx = 0;
		  byte idx = pTile->getIsland();
		  if(idx)
		  {
			if(idx == btIslandIndex)
			  _renderTileIsland(j, i, btIslandIndex);
		  }
		}
	  }
	}

	// 渲染刷子
	if(m_nBrushNo == 1)
	{
	  if(m_bModifyHeight)
	  {
		// 拉高，要画4个Tile
		for(int i = 0; i < 2; ++i)
		  for(int j = 0; j < 2; ++j)
			_RenderSelTile(nX + (j - 1), nY + (i - 1));
	  } else
		_RenderSelTile(nX, nY);
	} else if(m_nBrushNo == 2)
	{
	  if(m_bModifyHeight)
	  {
		// 拉高，要画9个Tile
		for(int i = 0; i < 3; ++i)
		  for(int j = 0; j < 3; ++j)
			_RenderSelTile(nX + (j - 1), nY + (i - 1));
	  } else
	  {
		for(int i = 0; i < 2; ++i)
		  for(int j = 0; j < 2; ++j)
			_RenderSelTile(nX + (j - 1), nY + (i - 1));
	  }
	} else if(m_nBrushNo == 3)
	{
	  if(m_bModifyHeight)
	  {
		// 拉高，要画16个Tile
		for(int i = 0; i < 4; ++i)
		  for(int j = 0; j < 4; ++j)
			_RenderSelTile(nX + (j - 2), nY + (i - 2));
	  } else
	  {
		for(int i = 0; i < 4; ++i)
		  for(int j = 0; j < 4; ++j)
			_RenderSelTile(nX + (j - 2), nY + (i - 2));
	  }
	}
  }
}

void MPEditor::HandleKeyDown()
{
  if(!_bEnable) return;

  if(g_pGameApp->IsKeyDown(DIK_F2))
  {
	LETerrain* pCurTerrain = GetCurTerrain();
	if(pCurTerrain)
	{
	  pCurTerrain->SetSectionTileData((int)pCurTerrain->GetShowCenterX(), (int)pCurTerrain->GetShowCenterY(), m_nSelTexNo);
	}
  } else if(g_pGameApp->IsKeyDown(DIK_DELETE))
  {
	if(_pSelEff)
	{
	  _pSelEff->SetValid(FALSE);
	  AddAction((void*)_pSelEff, enumDelSceneEffect);
	} else if(_GetSelectCha())
	{
	  _GetSelectCha()->SetValid(FALSE);
	  AddAction((void*)_GetSelectCha(), enumDelCharacter);
	} else if(_pSelSceneObj)
	{
	  _pSelSceneObj->SetValid(FALSE);
	  AddAction((void*)_pSelSceneObj, enumDelSceneObj);
	}
  } else if(g_pGameApp->IsKeyDown(DIK_H))
  {
	HideSelectSceneObj();
  } else if(g_pGameApp->IsKeyDown(DIK_U))
  {
	Tip(RES_STRING(CL_LANGUAGE_MATCH_207));
	UnhideAllSceneObj();
  } else if(g_pGameApp->IsKeyDown(DIK_F5))
  {
	m_bShowHeightmap = 1 - m_bShowHeightmap;
	TipI(m_bShowHeightmap, RES_STRING(CL_LANGUAGE_MATCH_208), RES_STRING(CL_LANGUAGE_MATCH_209));
  } else if(g_pGameApp->IsKeyDown(DIK_G))
  {
	m_bLockObj = 1 - m_bLockObj;
	TipI(m_bLockObj, RES_STRING(CL_LANGUAGE_MATCH_210), RES_STRING(CL_LANGUAGE_MATCH_211));
  } else if(g_pGameApp->IsKeyDown(DIK_Q))
  {
	Tip(RES_STRING(CL_LANGUAGE_MATCH_212));
	GenerateLandAttr();
  } else if(g_pGameApp->IsKeyDown(DIK_F9))
  {
	Tip(RES_STRING(CL_LANGUAGE_MATCH_213));
	_UpdateObjHeightmap(_pSelSceneObj);
  } else if(g_pGameApp->IsKeyDown(DIK_F11))
  {
	bPitchWatch = !bPitchWatch;
	Tip("Change Watch Mode");
  } else if(g_pGameApp->IsKeyDown(DIK_Z) && g_pGameApp->IsCtrlPress())
  {
	//辙消一次操作
	ReturnAction();
  } else if(g_pGameApp->IsKeyDown(DIK_Y) && g_pGameApp->IsCtrlPress())
  {
	//返回一次辙消
	RollBackReturnAction();
  }
}

void MPEditor::HandleKeyContinue()
{
  CSceneObj*  pSelObj	= _pSelSceneObj;
  CEffectObj* pSelEff	= _pSelEff;
  UINT		  offsetInc = 10;

  if(pSelObj) pSelEff = NULL;

  if(!g_pGameApp->IsCtrlPress())
  {
	if(g_pGameApp->IsKeyContinue(DIK_A))
	{
	  if(pSelObj)
	  {
		pSelObj->setHeightOff(pSelObj->getHeightOff() + 1);
	  }
	  if(pSelEff)
	  {
		pSelEff->setHeightOff(pSelEff->getHeightOff() + 1);
	  }
	} else if(g_pGameApp->IsKeyContinue(DIK_Z))
	{
	  if(pSelObj)
	  {
		pSelObj->setHeightOff(pSelObj->getHeightOff() - 1);
	  }
	  if(pSelEff)
	  {
		pSelEff->setHeightOff(pSelEff->getHeightOff() - 1);
	  }
	}
  }

  if(g_pGameApp->IsKeyContinue(DIK_EQUALS)) // '+'
  {
	if(pSelObj)
	{
	  pSelObj->setYaw(pSelObj->getYaw() + 5);
	}
	if(pSelEff) pSelEff->setYaw(pSelEff->getYaw() + 5);
  } else if(g_pGameApp->IsKeyContinue(DIK_MINUS)) // '-'
  {
	if(pSelObj)
	{
	  pSelObj->setYaw(pSelObj->getYaw() - 5);
	}
	if(pSelEff) pSelEff->setYaw(pSelEff->getYaw() - 5);
  } else if(g_pGameApp->IsKeyContinue(DIK_BACKSLASH))
  {
	if(pSelObj)
	{
	  pSelObj->setYaw(0);
	}
  } else if(g_pGameApp->IsKeyContinue(DIK_0))
  {
	if(pSelObj)
	{
	  int nNow = pSelObj->getYaw();
	  int nNew = nNow / 45 * 45;
	  pSelObj->setYaw(nNew);
	}
  }

  if(g_pGameApp->IsShiftPress())
  {
	offsetInc = 2;
  }

  if(g_pGameApp->IsKeyContinue(DIK_J))
  {
	if(pSelObj)
	{
	  pSelObj->setPos(pSelObj->GetCurX() - offsetInc, pSelObj->GetCurY());
	  AddAction((void*)pSelObj, enumObjectMove, offsetInc, 0);
	}
	if(pSelEff)
	{
	  pSelEff->setPos(pSelEff->GetCurX() - offsetInc, pSelEff->GetCurY());
	  AddAction((void*)pSelObj, enumEffectMove, offsetInc, 0);
	}
  }
  if(g_pGameApp->IsKeyContinue(DIK_L))
  {
	if(pSelObj)
	{
	  pSelObj->setPos(pSelObj->GetCurX() + offsetInc, pSelObj->GetCurY());
	  AddAction((void*)pSelObj, enumObjectMove, -offsetInc, 0);
	}
	if(pSelEff)
	{
	  pSelEff->setPos(pSelEff->GetCurX() + offsetInc, pSelEff->GetCurY());
	  AddAction((void*)pSelObj, enumEffectMove, -offsetInc, 0);
	}
  }
  if(g_pGameApp->IsKeyContinue(DIK_I))
  {
	if(pSelObj)
	{
	  pSelObj->setPos(pSelObj->GetCurX(), pSelObj->GetCurY() - offsetInc);
	  AddAction((void*)pSelObj, enumObjectMove, 0, offsetInc);
	}
	if(pSelEff)
	{
	  pSelEff->setPos(pSelEff->GetCurX(), pSelEff->GetCurY() - offsetInc);
	  AddAction((void*)pSelObj, enumEffectMove, 0, offsetInc);
	}
  } else if(g_pGameApp->IsKeyContinue(DIK_K))
  {
	if(pSelObj)
	{
	  pSelObj->setPos(pSelObj->GetCurX(), pSelObj->GetCurY() + offsetInc);
	  AddAction((void*)pSelObj, enumObjectMove, 0, -offsetInc);
	}
	if(pSelEff)
	{
	  pSelEff->setPos(pSelEff->GetCurX(), pSelEff->GetCurY() + offsetInc);
	  AddAction((void*)pSelObj, enumEffectMove, 0, -offsetInc);
	}
  } else if(g_pGameApp->IsKeyContinue(DIK_N))
  {
	m_nBrushHeight += 1;
  } else if(g_pGameApp->IsKeyContinue(DIK_M))
  {
	m_nBrushHeight -= 1;
  }
}

BOOL MPEditor::MouseButtonDown(int nButton)
{
  if(!IsEnable()) return FALSE;

  CGameScene* pCurScene = GetCurScene();
  if(!pCurScene) return FALSE;

  if(nButton == 0)
  {
	if(m_nSelTexNo)
	{
	  PlaceTerrainByBrush();
	} else if(m_bSmooth == true)
	{
	  SmoothArea((int)pCurScene->GetMouseMapX(), (int)pCurScene->GetMouseMapY(), m_nBrushNo, m_nBrushNo, SMOOTH_RANGER);
	} else if(g_pGameApp->IsShiftPress())
	{
	  SetTerrainBlock(TRUE);
	} else
	{
	  _SetAttrib();
	}
  } else // 右键按下
  {
	if(g_pGameApp->IsShiftPress())
	{
	  SetTerrainBlock(FALSE);
	} else if(m_nSelTypeID == 0)
	{
	  CCharacter* pCha = g_pGameApp->GetCurScene()->SelectCharacter();
	  if(pCha) g_pGameApp->GetCurScene()->SetMainCha(pCha->getID());
	}
  }

  // 原UP事件
  if(nButton == 0)
  {
	//if(IsEnable()==FALSE) return FALSE;

	//CGameScene *pCurScene = GetCurScene();
	//if(!pCurScene) return FALSE;

	if(m_nSelTypeID)
	{
	  int		  nX	 = (int)(pCurScene->GetMouseMapX() * 100.0f);
	  int		  nY	 = (int)(pCurScene->GetMouseMapY() * 100.0f);
	  CGameScene* pScene = pCurScene;
	  switch(m_nCurShowPanel)
	  {
	  case 0:
	  {
		{
		  CCharacter* pCha = pCurScene->AddCharacter(m_nSelTypeID);
		  if(pCha)
		  {
			pCha->setPos(nX, nY);
			pCha->setYaw(pCurScene->GetCha(m_nSelID)->getYaw());
			if(pCha->GetDefaultChaInfo()->sDormancy > 0)
			  pCha->PlayPose(pCha->GetDefaultChaInfo()->sDormancy);
			if(pCha->IsNPC())
			{
			  pCha->EnableAI(FALSE);
			} else
			{
			  pCha->EnableAI(TRUE);
			}
			pCha->ResetAITick();

			AddAction((void*)pCha, enumAddCharacter);

			// 测试NPC状态道具
			//DWORD state = ROLE_MIS_DELIVERY;
			//switch( rand() % 3 )
			//{
			//case 0: state=ROLE_MIS_PENDING; break;
			//case 1: state=ROLE_MIS_DELIVERY; break;
			//case 2: state=ROLE_MIS_ACCEPT; break;
			//}
			//pCha->setNpcState( state );
		  }
		}
		return TRUE;
		break;
	  }
	  case 1:
	  case 2:
	  case 3:
	  {
		if(g_pGameApp->IsShiftPress())
		{
		  CSceneObj* pObj		= pScene->GetSceneObj(m_nSelID);
		  drVector3	 vModelSize = pObj->GetObjectSize();
		  int		 yaw		= (pCurScene->GetSceneObj(m_nSelID)->getYaw()) % 90;
		  int		 tempX		= nX - m_oldnX;
		  int		 tempY		= nY - m_oldnY;
		  float		 nValue;
		  if(yaw <= 45)
		  {
			nValue = vModelSize.y;
		  } else
		  {
			nValue = vModelSize.x;
		  }

		  if(tempY > 0 && tempY > ABS(tempX))
		  {
			for(int i = 0; i <= nY - m_oldnY; i += nValue * 200)
			{
			  CSceneObj* pObj2 = pCurScene->AddSceneObj(m_nSelTypeID);
			  pObj2->setHeightOff(pCurScene->GetSceneObj(m_nSelID)->getHeightOff());
			  pObj2->setPos(m_oldnX / 10 * 10, m_oldnY / 10 * 10 + i);
			  pObj2->setYaw(pCurScene->GetSceneObj(m_nSelID)->getYaw());
			}
		  }
		  if(tempY < 0 && -tempY > ABS(tempX))
		  {
			for(int i = 0; i <= m_oldnY - nY; i += nValue * 200)
			{
			  CSceneObj* pObj2 = pCurScene->AddSceneObj(m_nSelTypeID);
			  pObj2->setHeightOff(pCurScene->GetSceneObj(m_nSelID)->getHeightOff());
			  pObj2->setPos(m_oldnX / 10 * 10, m_oldnY / 10 * 10 - i);
			  pObj2->setYaw(pCurScene->GetSceneObj(m_nSelID)->getYaw());
			}
		  }
		  if(tempX > 0 && tempX > ABS(tempY))
		  {
			for(int i = 0; i <= nX - m_oldnX; i += nValue * 200)
			{
			  CSceneObj* pObj2 = pCurScene->AddSceneObj(m_nSelTypeID);
			  pObj2->setHeightOff(pCurScene->GetSceneObj(m_nSelID)->getHeightOff());
			  pObj2->setPos(m_oldnX / 10 * 10 + i, m_oldnY / 10 * 10);
			  pObj2->setYaw(pCurScene->GetSceneObj(m_nSelID)->getYaw());
			}
		  }

		  if(tempX < 0 && -tempX > ABS(tempY))
		  {
			for(int i = 0; i <= m_oldnX - nX; i += nValue * 200)
			{
			  CSceneObj* pObj2 = pCurScene->AddSceneObj(m_nSelTypeID);
			  pObj2->setHeightOff(pCurScene->GetSceneObj(m_nSelID)->getHeightOff());
			  pObj2->setPos(m_oldnX / 10 * 10 - i, m_oldnY / 10 * 10);
			  pObj2->setYaw(pCurScene->GetSceneObj(m_nSelID)->getYaw());
			}
		  }
		} else
		{
		  CSceneObj* pObj = pCurScene->AddSceneObj(m_nSelTypeID);
		  if(pObj)
		  {
			pObj->setHeightOff(pCurScene->GetSceneObj(m_nSelID)->getHeightOff());
			pObj->setPos(nX / 10 * 10, nY / 10 * 10);
			pObj->setYaw(pCurScene->GetSceneObj(m_nSelID)->getYaw());
			AddAction((void*)pObj, enumAddSceneObj);
		  }
		}
		m_oldnX = nX;
		m_oldnY = nY;
		return TRUE;
		break;
	  }
	  case 4:
	  {
		CEffectObj* pEff = pCurScene->AddSceneEffect(m_nSelTypeID);
		if(pEff)
		{
		  pEff->setHeightOff(pCurScene->GetEffect(m_nSelID)->getHeightOff());
		  pEff->setPos(nX, nY);
		  pEff->setYaw(pCurScene->GetEffect(m_nSelID)->getYaw());
		  AddAction((void*)pEff, enumAddSceneEffect);
		}
		return TRUE;
		break;
	  }
	  }
	}
	if(m_bIsBrushColor)
	{
	  //SetTerrainColor(m_nBrushNo);
	  if(m_bShowLightBrush)
		SetTerrainColor2(m_nBrushNo);
	}
	return FALSE;
  } else if(nButton == 1)
  {
  }
  return FALSE;
}

CCharacter* MPEditor::_GetSelectCha()
{
  CGameScene* s = g_pGameApp->GetCurScene();
  return s->GetSelectCha();
}
int HitTestForInfluence(LESceneObject* obj, int* flag, D3DXVECTOR3* t_pos, const D3DXVECTOR3* nPos)
{
  MPPickInfo  p;
  D3DXVECTOR3 org(*nPos);
  D3DXVECTOR3 ray(0.0f, 0.0f, -1.0f);

  *flag = 0;

  if(SUCCEEDED(obj->HitTestHelperMesh(&p, (MPVector3*)&org, (MPVector3*)&ray, "block")))
  {
	*flag  = 2;
	*t_pos = *(D3DXVECTOR3*)&p.pos;
  }

  if(SUCCEEDED(obj->HitTestHelperMesh(&p, (MPVector3*)&org, (MPVector3*)&ray, "terrain")))
  {
	if(*flag == 0 || t_pos->z < p.pos.z)
	{
	  *flag	 = 1;
	  *t_pos = *(D3DXVECTOR3*)&p.pos;
	}
  }

  return 1;
}

int MPEditor::_GetSceneObjBlockInfo(LESceneObject* obj, int* x, int* y, int* width, int* height, BYTE** block_seq, float** height_seq)
{
  MPIHelperObject* helper_obj = obj->GetHelperObject();

  if(helper_obj == 0)
	return 0;

  if(helper_obj->GetHelperMesh() == 0)
	return 0;

  MPIBoundingBox* box = helper_obj->GetBoundingBox();
  if(box == 0)
	return 0;

  //MPMatrix44* m = box->GetMatrixParent();
  MPMatrix44* m = obj->GetMatrix();

  MPMatrix44		 mat;
  MPBoundingBoxInfo* box_info = box->GetDataInfo(0);
  LEMatrix44Multiply(&mat, &box_info->mat, m);

  int xo, yo, wo, ho;

  MPVector3 u = box_info->box.c - box_info->box.r;
  MPVector3 v = box_info->box.r * 2;
  MPVector2 p[4];

  p[0].x = u.x;
  p[0].y = u.y;
  p[1].x = u.x + v.x;
  p[1].y = u.y;
  p[2].x = u.x;
  p[2].y = u.y + v.y;
  p[3].x = u.x + v.x;
  p[3].y = u.y + v.y;

  for(DWORD i = 0; i < 4; i++)
  {
	MPVector2 t = p[i];
	p[i].x		= t.x * mat._11 + t.y * mat._21 + mat._41;
	p[i].y		= t.x * mat._12 + t.y * mat._22 + mat._42;
  }

  float min_x = p[0].x;
  float min_y = p[0].y;
  float max_x = min_x;
  float max_y = min_y;

  for(DWORD i = 1; i < 4; i++)
  {
	if(min_x > p[i].x)
	  min_x = p[i].x;
	else if(max_x < p[i].x)
	  max_x = p[i].x;

	if(min_y > p[i].y)
	  min_y = p[i].y;
	else if(max_y < p[i].y)
	  max_y = p[i].y;
  }

  xo = (int)min_x;
  yo = (int)min_y;
  wo = (int)(max_x - min_x);
  ho = (int)(max_y - min_y);

  wo += 1;
  ho += 1;

  DWORD seq_num = wo * ho * 2 * 2;

  if(_dwAttrNum < seq_num)
  {
	_dwAttrNum = seq_num;

	SAFE_DELETE_ARRAY(_AttrBlockSeq);
	SAFE_DELETE_ARRAY(_AttrHeightSeq);
	SAFE_DELETE_ARRAY(_AttrBlockSeq2);
	SAFE_DELETE_ARRAY(_AttrHeightSeq2);

	_AttrBlockSeq	= new BYTE[_dwAttrNum];
	_AttrHeightSeq	= new float[_dwAttrNum];
	_AttrBlockSeq2	= new BYTE[(wo + 1) * (ho + 1) * 2 * 2];
	_AttrHeightSeq2 = new float[(wo + 1) * (ho + 1) * 2 * 2];
  }

  memset(_AttrBlockSeq, 0, sizeof(BYTE) * _dwAttrNum);
  memset(_AttrHeightSeq, 0, sizeof(float) * _dwAttrNum);
  memset(_AttrBlockSeq2, 0, sizeof(BYTE) * ((wo + 1) * (ho + 1) * 2 * 2));
  memset(_AttrHeightSeq2, 0, sizeof(float) * ((wo + 1) * (ho + 1) * 2 * 2));

  int		  id;
  int		  flag;
  D3DXVECTOR3 t_pos(0.0f, 0.0f, 0.0f);
  D3DXVECTOR3 pos(0.0f, 0.0f, 100.0f);
  D3DXVECTOR3 obj_pos = *(D3DXVECTOR3*)&obj->GetMatrix()->_41;

  int hs = ho * 2;
  int ws = wo * 2;

  int hb = (ho + 1) * 2;
  int wb = (wo + 1) * 2;

  //#define HIT_TEST_CENTER_ONLY

#if(!defined HIT_TEST_CENTER_ONLY)

  // side point
  for(int i = 0; i < hb; i++)
  {
	for(int j = 0; j < wb; j++)
	{
	  id = i * wb + j;

	  pos.x = xo + j * 0.5f;
	  pos.y = yo + i * 0.5f;
	  t_pos = D3DXVECTOR3(0.0f, 0.0f, 0.0f);
	  HitTestForInfluence(obj, &flag, &t_pos, &pos);

	  _AttrBlockSeq2[id] = (BYTE)flag;
	  if(flag)
	  {
		_AttrHeightSeq2[id] = t_pos.z;
	  }
	}
  }

#endif
  // center

#if(!defined HIT_TEST_CENTER_ONLY)
  BYTE	b;
  float h;
  int	a00, a01, a10, a11;
#endif
  for(int i = 0; i < hs; i++)
  {
	for(int j = 0; j < ws; j++)
	{
	  id = i * ws + j;

	  pos.x = xo + j * 0.5f + 0.25f;
	  pos.y = yo + i * 0.5f + 0.25f;
	  t_pos = D3DXVECTOR3(0.0f, 0.0f, 0.0f);
	  HitTestForInfluence(obj, &flag, &t_pos, &pos);

#if(defined HIT_TEST_CENTER_ONLY)
	  _AttrBlockSeq[id] = (BYTE)flag;
	  if(flag)
	  {
		_AttrHeightSeq[id] = t_pos.z;
	  }
#else
	  a00 = i * wb + j;
	  a01 = a00 + 1;
	  a10 = (i + 1) * wb + j;
	  a11 = a10 + 1;

	  b = 0;
	  h = 0.0f;
	  //h = (t_pos.z + _AttrHeightSeq2[a00] + _AttrHeightSeq2[a01] + _AttrHeightSeq2[a10] + _AttrHeightSeq2[a11]) / 5;

	  //h = t_pos.z;
	  //if(h < _AttrHeightSeq2[a00])
	  //    h = _AttrHeightSeq2[a00];
	  //if(h < _AttrHeightSeq2[a01])
	  //    h = _AttrHeightSeq2[a01];
	  //if(h < _AttrHeightSeq2[a10])
	  //    h = _AttrHeightSeq2[a10];
	  //if(h < _AttrHeightSeq2[a11])
	  //    h = _AttrHeightSeq2[a11];
	  //

	  //if( (BYTE)flag == 2
	  //    || _AttrBlockSeq2[a00] == 2
	  //    || _AttrBlockSeq2[a01] == 2
	  //    || _AttrBlockSeq2[a10] == 2
	  //    || _AttrBlockSeq2[a11] == 2)
	  //{
	  //    b = 2;
	  //}
	  //else if( (BYTE)flag == 1
	  //    || _AttrBlockSeq2[a00] == 1
	  //    || _AttrBlockSeq2[a01] == 1
	  //    || _AttrBlockSeq2[a10] == 1
	  //    || _AttrBlockSeq2[a11] == 1)
	  //{
	  //    b = 1;
	  //}

	  BYTE b_seq[5] =
		  {
			  flag,
			  _AttrBlockSeq2[a00],
			  _AttrBlockSeq2[a01],
			  _AttrBlockSeq2[a10],
			  _AttrBlockSeq2[a11],
		  };

	  float h_seq[5] =
		  {
			  t_pos.z,
			  _AttrHeightSeq2[a00],
			  _AttrHeightSeq2[a01],
			  _AttrHeightSeq2[a10],
			  _AttrHeightSeq2[a11],
		  };

	  for(DWORD k = 0; k < 5; k++)
	  {
		if(b_seq[k] == 2)
		{
		  if(b == 0 || h < h_seq[k])
		  {
			b = 2;
			h = h_seq[k];
		  }
		}
	  }

	  if(b == 0)
	  {
		for(DWORD k = 0; k < 5; k++)
		{
		  if(b_seq[k] == 1)
		  {
			if(b == 0 || h < h_seq[k])
			{
			  b = 1;
			  h = h_seq[k];
			}
		  }
		}
	  }

	  if(b)
	  {
		_AttrBlockSeq[id]  = b;
		_AttrHeightSeq[id] = h;
		//_AttrHeightSeq[id] = t_pos.z;
	  }
#endif
	}
  }

  *x		  = xo;
  *y		  = yo;
  *width	  = ws;
  *height	  = hs;
  *block_seq  = _AttrBlockSeq;
  *height_seq = _AttrHeightSeq;

  return 1;
}

BOOL MPEditor::MouseButtonUp(int nButton)
{
  return FALSE;
}

void MPEditor::MouseMove(int nOffsetX, int nOffsetY)
{
  if(!_bEnable) return;

  CGameScene* pCurScene = GetCurScene();
  if(!pCurScene) return;

  LETerrain* pTerrain = GetCurTerrain();
  if(!pTerrain) return;

  if(g_pGameApp->IsMouseButtonPress(0))
  {
	//pTerrain->m_bEdit = TRUE;
	if(g_pGameApp->IsCtrlPress())
	{
	  if(m_bIsBrushColor)
	  {
		// 吸颜色
		LETile* pTile = pCurScene->GetTerrain()->GetTile(m_nSelectX, m_nSelectY);
		// pTile->dwColor;
		extern CEditor g_stUIEditor;
		g_stUIEditor.btnColor->GetImage()->SetColor(pTile->dwColor);
		SetColor(pTile->dwColor);
		return;
	  }
	}

	_SetAttrib();

	if(m_bModifyHeight && !g_pGameApp->IsShiftPress())
	{
	  float fStep = 2.2f;
	  if(g_pGameApp->IsCtrlPress())
	  {
		fStep = -2.2f;
	  }
	  if(g_pGameApp->IsKeyContinue(DIK_B))
	  {
		ModifyHeight(fStep, ((float)m_nBrushHeight) / 100.0f);
	  } else
	  {
		ModifyHeight(fStep);
	  }
	}

	if(m_bSmooth == true)
	{
	  SmoothArea((int)pCurScene->GetMouseMapX(), (int)pCurScene->GetMouseMapY(), m_nBrushNo, m_nBrushNo, SMOOTH_RANGER);
	}
	if(m_nSelTexNo)
	{
	  PlaceTerrainByBrush();
	} else if(m_bIsBrushColor)
	{
	  if(m_bShowLightBrush)
		SetTerrainColor2(m_nBrushNo);
	  else
		SetTerrainColor(m_nBrushNo);
	}
  }
}

void MPEditor::MouseScroll(int nScroll)
{
  if(!_bEnable) return;

  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  int nOffset = nScroll / 120;
  nOffset	  = nOffset * 15;

  switch(m_nCurShowPanel)
  {
  case 0:
  {
	if(m_nSelTypeID)
	{
	  CCharacter* pCha = pScene->GetCha(m_nSelID);
	  if(pCha) pCha->setYaw(pCha->getYaw() + nOffset);
	}
	break;
  }
  case 1:
  case 2:
  case 3:
  {
	if(m_nSelTypeID)
	{
	  CSceneObj* pObj = pScene->GetSceneObj(m_nSelID);
	  if(pObj) pObj->setYaw(pObj->getYaw() + nOffset);
	}
	break;
  }
  case 4:
  {
	if(m_nSelTypeID)
	{
	  CEffectObj* pEff = pScene->GetEffect(m_nSelID);
	  if(pEff) pEff->setYaw(pEff->getYaw() + nOffset);
	}
	break;
  }
  }
}

void MPEditor::SelectSceneObj()
{
  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  if(m_bLockObj && _pSelSceneObj) return;

  if(_pSelSceneObj) _pSelSceneObj->ShowBoundingObject(0);
  _pSelSceneObj = pScene->HitTestSceneObj(g_pGameApp->GetMouseX(), g_pGameApp->GetMouseY());
  if(_pSelSceneObj)
  {
	_pSelSceneObj->ShowBoundingObject(1);
  }
}

CEffectObj* MPEditor::SelectEffectObj()
{
  if(!GetCurScene()) return NULL;

  if(m_bLockObj && _pSelEff) return _pSelEff;

  _pSelEff = GetCurScene()->HitTestEffectObj(g_pGameApp->GetMouseX(), g_pGameApp->GetMouseY());
  return _pSelEff;
}

void MPEditor::HideSelectSceneObj()
{
  if(_pSelSceneObj)
  {
	CSceneObjInfo* pInfo = GetSceneObjInfo(_pSelSceneObj->getTypeID());
	char		   szTip[64];
	_snprintf_s(szTip, _countof(szTip), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_214), pInfo->szName);
	_pSelSceneObj->SetHide(TRUE);
	Tip(szTip);
  }
}

void MPEditor::UnhideAllSceneObj()
{
  CGameScene* pScene = GetCurScene();
  if(!pScene) return;
  pScene->UnhideAllSceneObj();
}

void MPEditor::_RenderHeightmap()
{
  if(!GetCurScene()) return;

  CPathBox.Show(TRUE);
  CPathBox.setWriteFrame(TRUE);
  CPathBox.ShowLine(TRUE);
  CPathBox.ShowBox(TRUE);
  CPathBox.setColor(0xff00ffff);
  CPathBox.setScale(1, 1, 1);

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;

  //渲染高度盒子
  int		  iRadius = 10;
  D3DXVECTOR3 vpos;
  vpos.x = int(pCurTerrain->GetShowCenterX()) - iRadius + 0.25f;
  vpos.y = int(pCurTerrain->GetShowCenterY()) - iRadius + 0.25f;
  if(vpos.x < 0) vpos.x = 0.25f;
  if(vpos.y < 0) vpos.y = 0.25f;

  vpos.z = 0;

  for(int ib = 0; ib < iRadius * 2 * 2; ib++)
  {
	for(int ip = 0; ip < iRadius * 2 * 2; ip++)
	{
	  float objHeight = pCurTerrain->GetGridHeight((int)(vpos.x / 0.5f), (int)(vpos.y / 0.5f));

	  CPathBox.setWriteFrame(FALSE);
	  CPathBox.ShowLine(TRUE);
	  CPathBox.ShowBox(FALSE);

	  vpos.z = 0;
	  float height;
	  // if(objHeight > 0 && objHeight > height)
	  {
		height = objHeight;
		CPathBox.setColor(0xff0000ff);
		CPathBox.ShowBox(TRUE);
	  }

	  if(pCurTerrain->IsGridBlock((int)(vpos.x / 0.5f), (int)(vpos.y / 0.5f)))
	  {
		CPathBox.setColor(0xffff0000);
		CPathBox.ShowBox(TRUE);
	  }

	  vpos.z = height - 0.4f;

	  CPathBox.setPos(vpos);
	  CPathBox.Render();
	  CPathBox.setColor(0xff00ff00);

	  vpos.x += 0.5f;
	}
	vpos.x = int(pCurTerrain->GetShowCenterX()) - iRadius + 0.25f;
	if(vpos.x < 0) vpos.x = 0.25f;
	vpos.y += 0.5f;
  }
}

void MPEditor::SetCha(bool press, int num)
{
  m_nCurShowPanel = eCha_Panel;

  m_nSelTexNo = 0;

  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  CCharacter* pCha;
  if(m_nSelTypeID)
  {
	pCha = pScene->GetCha(m_nSelID);
	if(pCha) pCha->SetValid(FALSE);
  }

  if(press)
  {
	int nTypeID = num;

	m_nSelTypeID = nTypeID; // Str2Int(strNum);

	pCha = pScene->AddCharacter(m_nSelTypeID);
	if(pCha)
	{
	  pCha->EnableAI(FALSE);
	  m_nSelID = pCha->getID();
	  pCha->setYaw(145);
	}
  } else
  {
	m_nSelTypeID = 0;
  }
}

void MPEditor::SetObj(bool press, int num)
{
  m_nCurShowPanel = eObj_Panel;

  m_nSelTexNo = 0;

  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  CSceneObj* pObj;
  if(m_nSelTypeID)
  {
	pObj = pScene->GetSceneObj(m_nSelID);
	if(pObj) pObj->SetValid(FALSE);
  }

  if(press)
  {
	m_nSelTypeID = num;

	pObj = pScene->AddSceneObj(m_nSelTypeID);
	if(pObj)
	{
	  m_nSelID = pObj->getID();
	  pObj->setHeightOff(0);
	  // pObj->setYaw(145);
	}
	if(m_nSelTypeID >= 230 && pScene->IsShowChairObj() == 0)
	{
	  pScene->ShowChairObj(1);
	  TipI(pScene->IsShowChairObj(), RES_STRING(CL_LANGUAGE_MATCH_215), RES_STRING(CL_LANGUAGE_MATCH_216));
	}
  } else
  {
	m_nSelTypeID = 0;
  }
}

void MPEditor::SetEff(bool press, int num)
{
  m_nCurShowPanel = eEff_Panel;

  m_nSelTexNo = 0;

  CGameScene* pScene = GetCurScene();
  if(!pScene) return;

  CEffectObj* pEff;
  if(m_nSelTypeID)
  {
	pEff = pScene->GetEffect(m_nSelID);
	if(pEff) pEff->SetValid(FALSE);
  }

  if(press)
  {
	m_nSelTypeID = num;

	pEff = pScene->AddSceneEffect(m_nSelTypeID);
	if(!pEff)
	{
	  LG("error", RES_STRING(CL_LANGUAGE_MATCH_217));
	  return;
	}
	m_nSelID = pEff->getID();
  } else
  {
	m_nSelTypeID = 0;
  }
}

void MPEditor::SetWireFrame(bool v)
{
  if(GetCurTerrain())
  {
	GetCurTerrain()->EnableWireFrame(v);
  }
}

void MPEditor::SetTerr(bool press, int num)
{
  m_nSelTexNo = press ? num : 0;
}
void MPEditor::SmoothArea(int nPosX, int nPosY, int nLengthX, int nLengthY, float fSize)
{
  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;

  if(CreateSmoothArea(nPosX, nPosY, nLengthX, nLengthY) == 0)
  {
	return;
  } else
  {
	LETile* pLETile = NULL;
	float	fHeigth = 0;
	fSize			= sin(fSize);
	for(int i = m_nStarPosY; i <= m_nEndPosY; i++)
	{
	  for(int j = m_nStarPosX; j <= m_nEndPosX; j++)
	  {
		pLETile = pCurTerrain->GetTile(j, i);
		if(pLETile->IsDefault() == FALSE)
		{
		  fHeigth = pLETile->getHeight();
		  if(fHeigth > m_fAverageHight)
		  {
			if((fHeigth - fSize) > m_fAverageHight)
			{
			  //fHeigth -= fSize;
			  pLETile->AddHeight(-fSize);
			} else
			{
			  //fHeigth = m_fAverageHight;
			  pLETile->setHeight(m_fAverageHight);
			}

		  } else if(fHeigth < m_fAverageHight)
		  {
			if((fHeigth + fSize) < m_fAverageHight)
			{
			  //fHeigth += fSize;
			  pLETile->AddHeight(fSize);
			} else
			{
			  //fHeigth = m_fAverageHight;
			  pLETile->setHeight(fHeigth);
			}
		  }
		  //pLETile->SetHeight(fHeigth);
		}
	  }
	}
  }
  return;
}

long MPEditor::CreateSmoothArea(int nPosX, int nPosY, int nLengthX, int nLengthY)
{
  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return 0;

  if((nPosX - nLengthX) >= 0)
  {
	m_nStarPosX = nPosX - nLengthX;
  } else
  {
	m_nStarPosX = 0;
  }
  if((nPosX + nLengthX) < pCurTerrain->GetWidth())
  {
	m_nEndPosX = nPosX + nLengthX;

  } else
  {
	m_nEndPosX = pCurTerrain->GetWidth();
  }
  ///Y
  if((nPosY - nLengthY) >= 0)
  {
	m_nStarPosY = nPosY - nLengthY;
  } else
  {
	m_nStarPosY = 0;
  }
  if((nPosY + nLengthY) < pCurTerrain->GetHeight())
  {
	m_nEndPosY = nPosY + nLengthY;

  } else
  {
	m_nEndPosX = pCurTerrain->GetHeight();
  }
  int	  i			= 0;
  int	  j			= 0;
  float	  fMaxHigth = 0;
  float	  fMinHigth = 0;
  LETile* pLETile	= NULL;
  bool	  fFlag		= false;
  i					= m_nStarPosY;
  while((i <= m_nEndPosY) && (fFlag == false))
  {
	j = m_nStarPosX;
	while((j <= m_nEndPosX) && (fFlag == false))
	{
	  pLETile = pCurTerrain->GetTile(j, i);
	  if(pLETile->IsDefault() == FALSE)
	  {
		fMaxHigth = pLETile->getHeight();
		fMinHigth = pLETile->getHeight();
		fFlag	  = true;
	  }
	  j++;
	}
	i++;
  }
  if(fFlag == false)
  {
	return 0;
  }
  for(i = m_nStarPosY; i <= m_nEndPosY; i++)
  {
	for(j = m_nStarPosX; j <= m_nEndPosX; j++)
	{
	  pLETile = pCurTerrain->GetTile(j, i);
	  if(pLETile->IsDefault() == FALSE)
	  {
		if(fMaxHigth < pLETile->getHeight())
		{
		  fMaxHigth = pLETile->getHeight();
		}
		if(fMinHigth > pLETile->getHeight())
		{
		  fMinHigth = pLETile->getHeight();
		}
	  }
	}
  }
  m_fAverageHight = (fMaxHigth + fMinHigth) / 2;

  return 1;
}
void MPEditor::SelectProperty(int nPropertyNumber)
{
  if(nPropertyNumber < 0 || nPropertyNumber > TILE_ATTRIB_MAX_BITS)
	return;

  _AttribIndex = byte(nPropertyNumber);
}
void MPEditor::CancelProperty(void)
{
  _AttribIndex = 0;

  return;
}

byte MPEditor::_getTileAttribMask(byte attrib_btn_index)
{
  //switch (attrib_btn_index)
  //	// attrib_btn_index是Editor上区域属性按钮的索引，从1到16
  //	{
  //	case 1:
  //		return enumAREA_TYPE_SEA; // 第一个按钮是海洋属性
  //	default:
  //		return 0;
  //	}
  return 0;
}

void MPEditor::selectIsland(int nIslandIndex)
{
  if(nIslandIndex < TILE_ISLAND_MIN_VALUE || nIslandIndex > TILE_ISLAND_MAX_VALUE)
	return;

  _IslandIndex = byte(nIslandIndex);
}

void MPEditor::cancelIsland()
{
  _IslandIndex = TILE_ISLAND_MAX_VALUE + 1;
}

void MPEditor::_renderTileAttrib(int nX, int nY, int nAttribIndex)
{
  struct MPPropertyTileVertex
  {
	//D3DXVECTOR3 p;
	VECTOR3 p;
	DWORD	dwColor;
  };

  MPPropertyTileVertex v[4];

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;

  for(int i = 0; i < 4; i++)
  {
	int x = nX + LETile::Offset[i][0];
	int y = nY + LETile::Offset[i][1];
	int k = 140;
	switch(nAttribIndex)
	{
	case 1: // 陆地属性
	  v[i].dwColor = D3DCOLOR_ARGB(k, 100, 255, 25);
	  break;
	case 2:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 0, 255, 255);
	  break;
	case 3:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 255, 0, 0);
	  break;
	case 4:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 255, 255, 0);
	  break;
	case 5:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 255, 0, 255);
	  break;
	case 6:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 199, 178, 153);
	  break;
	case 7:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 161, 134, 190);
	  break;
	case 8:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 236, 100, 140);
	  break;
	case 9:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 246, 150, 121);
	  break;
	case 10:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 154, 154, 154);
	  break;
	case 11:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 0, 54, 99);
	  break;
	case 12:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 0, 88, 88);
	  break;
	case 13:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 242, 101, 34);
	  break;
	case 14:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 109, 207, 246);
	  break;
	case 15:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 159, 27, 246);
	  break;
	case 16:
	  v[i].dwColor = D3DCOLOR_ARGB(k, 9, 207, 246);
	  break;
	}
	LETile* pTile = pCurTerrain->GetTile(x, y);
	if(pTile->IsDefault())
	{
	  v[i].p = VECTOR3((float)x, (float)y, SEA_LEVEL + 0.01f);
	} else
	{
	  v[i].p = VECTOR3((float)x, (float)y, pTile->fHeight + 0.01f);
	}
  }

  g_Render.GetDevice()->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, &v,
										sizeof(MPPropertyTileVertex));
}

void MPEditor::_renderTileIsland(int nX, int nY, int nIslandIndex)
{
  return;

  struct MPPropertyTileVertex
  {
	//D3DXVECTOR3 p;
	VECTOR3 p;
	DWORD	dwColor;
  };

  MPPropertyTileVertex v[4];

  LETerrain* pCurTerrain = GetCurTerrain();
  if(!pCurTerrain) return;

  for(int i = 0; i < 4; i++)
  {
	int x = nX + LETile::Offset[i][0];
	int y = nY + LETile::Offset[i][1];
	int k = 180;

	v[i].dwColor = D3DCOLOR_ARGB(k, 255, 255, 255);

	LETile* pTile = pCurTerrain->GetTile(x, y);
	if(pTile->IsDefault())
	{
	  v[i].p = VECTOR3((float)x, (float)y, SEA_LEVEL + 0.01f);
	} else
	{
	  v[i].p = VECTOR3((float)x, (float)y, pTile->fHeight + 0.01f);
	}
  }

  g_Render.GetDevice()->DrawPrimitiveUP(D3DPT_TRIANGLESTRIP, 2, &v,
										sizeof(MPPropertyTileVertex));
}

void MPEditor::SetChaPose(int nPress, int nPoseID)
{
  CGameScene* pCurScene = GetCurScene();
  if(!pCurScene) return;

  CCharacter* pMainCha = pCurScene->GetMainCha();
  if(pMainCha)
  {
	pMainCha->PlayPose(nPoseID, PLAY_LOOP);
  }
}

void MPEditor::ChangePart(bool press, int num)
{
  CGameScene* s = g_pGameApp->GetCurScene();
  if(!s) return;

  CCharacter* cha = s->GetMainCha();
  if(!cha) return;

  if(cha->IsBoat()) return;

  if(num < 0 || num >= 5) return;

  static DWORD part[5] = {0};
  //part[num] = cha->GetPartID(num);
  part[num]++;
  switch(num)
  {
  case 0:
	if(!(part[num] >= 193 && part[num] <= 252))
	  part[num] = 193;
	break;
  case 1:
	if(!(part[num] >= 255 && part[num] <= 258))
	  part[num] = 255;
	break;
  case 2:
	if(!(part[num] >= 289 && part[num] <= 392))
	  part[num] = 289;
	break;
  case 3:
	if(!(part[num] >= 465 && part[num] <= 568))
	  part[num] = 465;
	break;
  case 4:
	if(!(part[num] >= 641 && part[num] <= 744))
	  part[num] = 641;
	break;
  }
  cha->ChangePart(num, part[num]);
}

void MPEditor::_SetAttrib()
{
  LETerrain* pTerrain = GetCurTerrain();
  if(!pTerrain) return;
  //pTerrain->m_bEdit = TRUE;

  if(_AttribIndex != 0)
  {
	BOOL bSet = 1 - _is_erase;
	switch(m_nBrushNo)
	{
	case 1:
	{
	  pTerrain->GetTile(m_nSelectX, m_nSelectY)->setRegion(_AttribIndex, bSet);
	  break;
	}
	case 2:
	{
	  for(int i = 0; i < 2; ++i)
	  {
		for(int j = 0; j < 2; ++j)
		{
		  pTerrain->GetTile(m_nSelectX + (j - 1), m_nSelectY + (i - 1))->setRegion(_AttribIndex, bSet);
		}
	  }
	  break;
	}
	case 3:
	{
	  for(int i = 0; i < 4; ++i)
		for(int j = 0; j < 4; ++j)
		{
		  pTerrain->GetTile(m_nSelectX + (j - 2), m_nSelectY + (i - 2))->setRegion(_AttribIndex, bSet);
		}
	  break;
	}
	}
  } else if(_IslandIndex <= TILE_ISLAND_MAX_VALUE)
  {
	switch(m_nBrushNo)
	{
	case 1:
	  pTerrain->GetTile(m_nSelectX, m_nSelectY)->setIsland(_IslandIndex);
	  break;
	case 2:
	  for(int i = 0; i < 2; ++i)
		for(int j = 0; j < 2; ++j)
		  pTerrain->GetTile(m_nSelectX + (j - 1), m_nSelectY + (i - 1))->setIsland(_IslandIndex);
	  break;
	case 3:
	  for(int i = 0; i < 4; ++i)
		for(int j = 0; j < 4; ++j)
		  pTerrain->GetTile(m_nSelectX + (j - 2), m_nSelectY + (i - 2))->setIsland(_IslandIndex);
	  break;
	}
  }
}

void MPEditor::GenerateLandAttr()
{
  LETerrain* pTerrain = GetCurTerrain();
  if(!pTerrain) return;

  float fShowCenterX = pTerrain->GetShowCenterX();
  float fShowCenterY = pTerrain->GetShowCenterY();

  int nShowWidth  = pTerrain->GetShowWidth();
  int nShowHeight = pTerrain->GetShowHeight();

  int nTileStartX = (int)(fShowCenterX - (float)(nShowWidth) / 2.0f);
  int nTileStartY = (int)(fShowCenterY - (float)(nShowHeight) / 2.0f);

  for(short y = 0; y < nShowHeight; y++)
  {
	for(short x = 0; x < nShowWidth; x++)
	{
	  short sX = nTileStartX + x;
	  short sY = nTileStartY + y;

	  LETile* pTile = pTerrain->GetTile(sX, sY);

	  if(!pTile) continue;

	  float h1 = pTile->fHeight;
	  float h2 = pTerrain->GetGroupTile(sX, sY, 1)->fHeight;
	  float h3 = pTerrain->GetGroupTile(sX, sY, 2)->fHeight;
	  float h4 = pTerrain->GetGroupTile(sX, sY, 3)->fHeight;

	  if(h1 > -0.3f || h2 > -0.3f || h3 > -0.3f || h4 > -0.3f)
	  {
		pTile->setRegion(1, 1);
	  } else
	  {
		pTile->setRegion(1, 0);
	  }
	}
  }
}

void MPEditor::SetTerrainBlock(BOOL bSet)
{
  CGameScene* pCurScene = GetCurScene();
  if(!pCurScene) return;

  LETerrain* pTerrain = GetCurTerrain();
  if(!pTerrain) return;
  //pTerrain->m_bEdit = TRUE;

  int nX = (int)(pCurScene->GetMouseMapX() * 100.0f) / 50;
  int nY = (int)(pCurScene->GetMouseMapY() * 100.0f) / 50;

  LETile* pTile = pTerrain->GetTile(nX / 2, nY / 2);
  if(pTile->IsDefault() == FALSE)
  {
	int offx = nX % 2;
	int offy = nY % 2;
	int no	 = offy * 2 + offx;
	pTile->setBlock(no, bSet);
  }
}

void MPEditor::_UpdateObjHeightmap(CSceneObj* pObj)
{
  if(pObj == 0)
	return;

  LETerrain* pTerrain = GetCurTerrain();
  if(!pTerrain) return;
  //pTerrain->m_bEdit = TRUE;

  LETimer t;
  t.Begin();

  int	 sx, sy, width, height;
  BYTE*	 block_seq;
  float* height_seq;

  int r = _GetSceneObjBlockInfo(pObj, &sx, &sy, &width, &height, &block_seq, &height_seq);
  if(r == 0)
	return;

  FILE* fp;
  fopen_s(&fp, "height.txt", "wt");

  for(int y = 0; y < height; y++)
  {
	for(int x = 0; x < width; x++)
	{
	  fprintf(fp, "%5.2f ", block_seq[y * width + x] == 0 ? 0.0f : height_seq[y * width + x]);
	}
	fprintf(fp, "\n\n");
  }

  fclose(fp);

  float fOldHeight[4], fNewHeight[4];
  BYTE	btOldBlock[4], btNewBlock[4];

  for(int y = 0; y < height / 2; y++)
  {
	for(int x = 0; x < width / 2; x++)
	{
	  int	  tx	= sx + x;
	  int	  ty	= sy + y;
	  LETile* pTile = pTerrain->GetTile(tx, ty);

	  fOldHeight[0] = pTile->getObjHeight(0);
	  fOldHeight[1] = pTile->getObjHeight(1);
	  fOldHeight[2] = pTile->getObjHeight(2);
	  fOldHeight[3] = pTile->getObjHeight(3);

	  btOldBlock[0] = pTile->IsBlock(0);
	  btOldBlock[1] = pTile->IsBlock(1);
	  btOldBlock[2] = pTile->IsBlock(2);
	  btOldBlock[3] = pTile->IsBlock(3);

	  int mx		= x * 2;
	  int my		= y * 2;
	  fNewHeight[0] = height_seq[mx + my * width];
	  fNewHeight[1] = height_seq[(mx + 1) + my * width];
	  fNewHeight[2] = height_seq[mx + (my + 1) * width];
	  fNewHeight[3] = height_seq[(mx + 1) + (my + 1) * width];

	  btNewBlock[0] = block_seq[mx + my * width];
	  btNewBlock[1] = block_seq[(mx + 1) + my * width];
	  btNewBlock[2] = block_seq[mx + (my + 1) * width];
	  btNewBlock[3] = block_seq[(mx + 1) + (my + 1) * width];

	  for(int i = 0; i < 4; i++)
	  {
		if(btNewBlock[i] == 0)
		  continue;

		if(fNewHeight[i] >= fOldHeight[i])
		{
		  pTile->setBlock(i, btNewBlock[i] - 1);
		  pTile->setObjHeight(i, fNewHeight[i]);
		}
	  }
	}
  }

  DWORD dwUseTime = t.End();
  LG("hmap", "time = %d\n", dwUseTime);
}

void MPEditor::AddAction(void* ptr, eActType acttype, int xoff, int yoff)
{
  ActionStruct* action = new ActionStruct;
  action->_eType	   = acttype;
  action->_ptr		   = ptr;
  action->_nType	   = 0;
  action->_xoffset	   = xoff;
  action->_yoffset	   = yoff;
  action->_fxpos	   = 0.0f;
  action->_fypos	   = 0.0f;
  AddAction(action);
}

void MPEditor::AddAction(ActionStruct* action)
{
  if(action)
  {
	_Action.push_back(action);
  }
}

void MPEditor::RemoveAction()
{
  if(!_Action.empty())
  {
	ActionStruct* action = _Action.back();
	if(!action->_fHeights.empty())
	{
	  action->_fHeights.clear();
	}
	_Action.pop_back();
	if(action)
	  delete action;
  }
}

void MPEditor::RollBackReturnAction()
{
  if(!_ActionRollBack.empty())
  {
	_Action.push_back(_ActionRollBack.back());
	_ActionRollBack.pop_back();
	ReturnAction(TRUE);
  }
}

void MPEditor::ReturnAction(BOOL bRollBack)
{
  int sz = _Action.size();
  if(!_Action.size())
	return;
  ActionStruct* action = _Action.back();
  switch(action->_eType)
  {
  case enumAddCharacter:
  {
	((CCharacter*)action->_ptr)->SetValid(bRollBack);
	break;
  }
  case enumAddSceneObj:
  {
	((CSceneObj*)action->_ptr)->SetValid(bRollBack);
	break;
  }
  case enumAddSceneEffect:
  {
	((CEffectObj*)action->_ptr)->SetValid(bRollBack);
	break;
  }
  case enumDelCharacter:
  {
	((CCharacter*)action->_ptr)->SetValid(!bRollBack);
	break;
  }
  case enumDelSceneObj:
  {
	((CSceneObj*)action->_ptr)->SetValid(!bRollBack);
	break;
  }
  case enumDelSceneEffect:
  {
	((CEffectObj*)action->_ptr)->SetValid(!bRollBack);
	break;
  }
  case enumObjectMove:
  {
	CSceneObj* obj = (CSceneObj*)action->_ptr;
	if(bRollBack)
	  obj->setPos(obj->GetCurX() - action->_xoffset, obj->GetCurY() - action->_yoffset);
	else
	  obj->setPos(obj->GetCurX() + action->_xoffset, obj->GetCurY() + action->_yoffset);
	break;
  }
  case enumEffectMove:
  {
	CEffectObj* obj = (CEffectObj*)action->_ptr;
	if(bRollBack)
	  obj->setPos(obj->GetCurX() - action->_xoffset, obj->GetCurY() - action->_yoffset);
	else
	  obj->setPos(obj->GetCurX() + action->_xoffset, obj->GetCurY() + action->_yoffset);
	break;
  }
  case enumSetTerrainColor:
  {
	SetTerrainColor(action->_nType, !bRollBack, bRollBack);
	break;
  }
  case enumSetTerrainColor2:
  {
	SetTerrainColor2(action->_nType, !bRollBack, bRollBack);
	break;
  }
  case enumModifyHeight:
  {
	if(!bRollBack)
	{
	  ModifyHeight(action->_fStep, action->_fResetHeight, TRUE);
	} else
	{
	  ModifyHeight(action->_fStep, action->_fResetHeight, FALSE, TRUE);
	}
	break;
  }
  }
  if(!bRollBack)
  {
	_ActionRollBack.push_back(action);
	_Action.pop_back();
  }
  //	RemoveAction();
}

#endif //of __EDITOR__
