#include "stdafx.h"

#include "Scene.h"
#include "GameApp.h"
#include "GameConfig.h"
#ifdef __EDITOR__
#include "MPEditor.h"
#endif
#include "SceneObjSet.h"

#include "Character.h"
#include "SceneObj.h"
#include "SceneItem.h"
#include "EffectObj.h"
#include "AreaRecord.h"
#include "LEFont.h"
#include "SmallMap.h"
#include "GlobalVar.h"
#include "MapSet.h"
#include "UIRender.h"
#include "RenderStateMgr.h"
#include "uiheadsay.h"
#include "cameractrl.h"
#include "findpath.h"
#include "event.h"

#define OPEN_AMBIENT_ENV

//CBigMap bigmap;
//#define USE_FOG
extern CFindPath g_cFindPath;

struct MainChaLgtInfo
{
  int		flag;
  DWORD		amb;
  drVector3 dif;
};

static MainChaLgtInfo g_mcl;

DR_RESULT __SceneTranspObjRenderProc(MPIPrimitive* obj, void* param)
{
  RenderStateMgr* rsm = g_pGameApp->GetRenderStateMgr();
  rsm->BeginSceneObject();

  SceneTranspObjStateDesc* desc = (SceneTranspObjStateDesc*)param;

  DWORD		old_lgt = 0;
  DWORD		old_amb = 0;
  BOOL		old_light_enable[3];
  D3DLIGHTX old_light[3];

  g_Render.GetRenderState(D3DRS_LIGHTING, &old_lgt);
  if(old_lgt != desc->rs_lgt)
  {
	g_Render.SetRenderState(D3DRS_LIGHTING, desc->rs_lgt);
  }

  g_Render.GetRenderState(D3DRS_AMBIENT, &old_amb);
  if(old_amb != desc->rs_amb)
  {
	g_Render.SetRenderState(D3DRS_AMBIENT, desc->rs_amb);
  }

  for(DWORD i = 0; i < 3; i++)
  {
	g_Render.GetLightEnable(i, &old_light_enable[i]);
	g_Render.GetLight(i, &old_light[i]);

	if(old_light_enable[i] != desc->light_enable[i])
	{
	  g_Render.LightEnable(i, desc->light_enable[i]);
	  if(desc->light_enable[i])
	  {
		g_Render.SetLight(i, &desc->light[i]);
	  }
	}
  }

  obj->Render();

  if(old_lgt != desc->rs_lgt)
  {
	g_Render.SetRenderState(D3DRS_LIGHTING, old_lgt);
  }

  if(old_amb != desc->rs_amb)
  {
	g_Render.SetRenderState(D3DRS_AMBIENT, old_amb);
  }

  for(DWORD i = 0; i < 3; i++)
  {
	if(old_light_enable[i] != desc->light_enable[i])
	{
	  g_Render.LightEnable(i, old_light_enable[i]);
	  g_Render.SetLight(i, &old_light[i]);
	}
  }

  rsm->EndSceneObject();

  return 0L;
}

void CGameScene::_Render()
{
  MPIDeviceObject* dev_obj = g_Render.GetInterfaceMgr()->dev_obj;
  RenderStateMgr*  rsm	   = g_pGameApp->GetRenderStateMgr();

  rsm->BeginScene();

#ifdef __EDITOR__
  if(g_Config.m_bEditor)
  {
	if(_vMousePos.x > 0)
	{
	  if(g_Editor.IsEnable()) g_Render.AddLine(_vMousePos, D3DXVECTOR3(_vMousePos.x, _vMousePos.y, _vMousePos.z + 4.0f), 0xFFFF0000);
	}

	// 当前角色如果是巡逻怪, 则把巡逻路线绘制出来

	for(int i = 0; i < GetChaCnt(); i++)
	{
	  CCharacter* pCha = GetCha(i);
	  if(pCha->IsValid())
	  {
		if(pCha->getPatrolX() > 0)
		{
		  D3DXVECTOR3 vec1 = D3DXVECTOR3((float)(pCha->getPatrolX()) / 100.0f, (float)(pCha->getPatrolY()) / 100.0f, 2.0f);
		  D3DXVECTOR3 vec2 = D3DXVECTOR3((float)(pCha->GetCurX()) / 100.0f, (float)(pCha->GetCurY()) / 100.0f, 2.0f);
		  g_Render.AddLine(vec1, vec2, 0xFFFFFFFF);
		  g_Render.AddLine(vec1, vec2 + D3DXVECTOR3(0.1f, 0.2f, 0.0f), 0xFFFF0000);
		}
	  }
	}
  }
#endif

#ifdef __FPS_DEBUG__
  LETimer tTerrain;
  tTerrain.Begin();
#endif

  // self begin
  static float fLightDir = 0.0f;
  fLightDir += 0.02f;
  if(fLightDir > D3DX_PI * 2.0f) fLightDir = 0.0f;

  float fX = 1.0f * tan(fLightDir);
  if(fX <= 0.0f) fX = 0.00001f;
  float fY = 1.0f / fX;

  // g_Render.SetDirectLightDir(1, 1, -1.0f);

//////
//MPIDeviceObject* dev_obj = g_Render.GetInterfaceMgr()->dev_obj;
#ifdef TESTDEMO
  SetupVertexFog(dev_obj, 50, 60, D3DCOLOR_XRGB(g_Config.m_iFogR, g_Config.m_iFogG, g_Config.m_iFogB), D3DFOG_EXP2, 1, g_Config.m_fExp2);
#endif

  //g_Render.SetBackgroundColor(D3DCOLOR_XRGB(64, 64, 64));
  list<int>::iterator it;
  for(it = _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].begin();
	  it != _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].end(); it++)
  {
	int		   nArrayID = (*it);
	CSceneObj* pObj		= &_pSceneObjArray[nArrayID];
	if(pObj->IsValid() && pObj->IsHide() == FALSE)
	{
	  pObj->UpdateLight();
	}
  }

  if(m_bShowTerrain)
  {
	if(_pTerrain)
	{
#ifdef __FPS_DEBUG__
	  //LETimer tMap;
	  //tMap.Begin();
#endif
	  //_pTerrain->DynamicLoading(GetTickCount());
	  //
#ifdef __FPS_DEBUG__
	  //g_pGameApp->m_dwLoadingObjTime = tMap.End();
#endif
	  _pTerrain->EnableNormalLight(0);
	  _pTerrain->Render();
	}
  }

  for(it = _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].begin();
	  it != _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].end(); it++)
  {
	int		   nArrayID = (*it);
	CSceneObj* pObj		= &_pSceneObjArray[nArrayID];
	if(pObj->IsValid() && pObj->IsHide() == FALSE)
	{
	  pObj->ClearLight();
	}
  }
  ///////

  g_Render.EnableZBuffer(TRUE);

  //g_Render.BeginState(0);
  int i;

#ifdef __FPS_DEBUG__
  if(_pTerrain)
  {
	_pTerrain->m_dwSeaRenderTime = tTerrain.End();
  }
#endif

  //////
  // begin bench mark

#if(defined OPEN_AMBIENT_ENV)
  g_Render.SetRenderState(D3DRS_LIGHTING, TRUE);
  g_Render.SetRenderState(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);
  g_Render.LightEnable(0, 1);
  DWORD amb;
  DWORD rs_amb;
  g_Render.GetRenderState(D3DRS_AMBIENT, &rs_amb);

  amb = D3DCOLOR_XRGB((BYTE)(m_dwEnvColor.r * 255), (BYTE)(m_dwEnvColor.g * 255), (BYTE)(m_dwEnvColor.b * 255));
  g_Render.SetRenderState(D3DRS_AMBIENT, amb);
#else
  // g_Render.SetDirectLightColor( 1.0f, 1.0f, 1.0, 1.0f);
  ////////
  D3DMATERIAL8 material;
  D3DUtil_InitMaterialI(material, 1.0f, 1.0f, 1.0f, 1.0f);
  material.Ambient = m_dwEnvColor;
#endif

#ifdef __FPS_DEBUG__
  LETimer tObj;
  tObj.Begin();
#endif
  dev_obj->BeginBenchMark();

  UpdateSceneAnimLight();

#ifdef __FPS_DEBUG__
  m_dwValidSceneObjCnt	= 0;
  m_dwRenderSceneObjCnt = 0;
  m_dwCullingTime		= 0;
#endif
  if(_bShowSceneObj)
  {
#ifdef __FPS_DEBUG__
	LETimer t;
	t.Begin();
#endif

	MPVector3 org(0.0f, 0.0f, 0.0f);
	MPVector3 ray(0.0f, 0.0f, 0.0f);
	GetMainChaPickRay(&org, &ray);

	drISceneMgr*			 sm	   = g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr();
	SceneTranspObjStateDesc* stosd = 0;

	_dwTranspObjStateID = 0;

	rsm->BeginSceneObject();

	DWORD	  env_color = 0;
	D3DLIGHTX env_light;
	memset(&env_light, 0, sizeof(env_light));
	env_light.Type = D3DLIGHT_DIRECTIONAL;

	g_Render.GetRenderState(D3DRS_AMBIENT, &env_color);

	int nArea = -1;

	//drIViewFrustum* vf = g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr()->GetViewFrustum();
	//vf->Update(dev_obj->GetMatViewProj());
	//drMatrix44 mat_view;
	//drMatrix44 mat_proj;
	//drMatrix44 mm;
	//dev_obj->GetDevice()->GetTransform(D3DTS_VIEW, &mat_view);
	//dev_obj->GetDevice()->GetTransform(D3DTS_PROJECTION, &mat_proj);
	//drMatrix44Multiply(&mm, &mat_view, &mat_proj);

	//drMatrix44 mx = *dev_obj->GetMatViewProj();

#ifdef _KOSDEMO_

//		for( sceneobjs::iterator it=_vecHideObject.begin(); it!=_vecHideObject.end(); ++it )
//		{}

// 		CSceneObj* htObj = HitTestSceneObj( 512, 384 );
// 		if ( htObj )
// 		{
// 			D3DXVECTOR3	ChaPos = GetMainCha()->GetPos();
// 			D3DXVECTOR3	EyePos = g_pGameApp->GetMainCam()->m_EyePos;
// 			D3DXVECTOR3 ObjPos = htObj->getPos();
// 			int e2cDis = GetDistance( __int64( EyePos.x ), __int64( EyePos.y ), __int64( ChaPos.x ), __int64( ChaPos.y ) );
// 			int	e2oDis = GetDistance( __int64( EyePos.x ), __int64( EyePos.y ), __int64( ObjPos.x ), __int64( ObjPos.y ) );
//
// 			if ( e2cDis > e2oDis )
// 			{
// 				htObj->SetHide( TRUE );
// 				_vecHideObject.push_back( htObj );
// 			}
// 		}
// 		else
// 		{
// 			_vecTemp.clear();
// 			while ( !_vecHideObject.empty() )
// 			{
// 				CSceneObj* obj = _vecHideObject.back();
// 				obj->SetHide( FALSE );
// 				CSceneObj* ttObj = HitTestSceneObj( 512, 384 );
// 				if ( obj == ttObj )
// 				{
// 					obj->SetHide( TRUE );
// 					_vecTemp.push_back( _vecHideObject.back() );
// 				}
// 				_vecHideObject.pop_back();
// 			}
// 			_vecHideObject.clear();
// 			_vecHideObject = _vecTemp;
// 		}
#endif

	list<int>::iterator it	   = _SceneObjIdx[0].begin();
	list<int>::iterator it_end = _SceneObjIdx[0].end();
	for(; it != it_end; ++it)
	{
	  int		 nArrayID = (*it);
	  CSceneObj* pObj	  = &_pSceneObjArray[nArrayID];
	  if(pObj->IsValid() && pObj->IsHide() == FALSE)
	  {
		pObj->GetObject()->CullPrimitive();
		if(pObj->GetObject()->GetCullingPrimitiveNum() == pObj->GetObject()->GetPrimitiveNum())
		  continue;

		CSceneObjInfo* info = GetSceneObjInfo(pObj->getTypeID());

		BOOL light_enable = info->bEnableEnvLight | info->bEnablePointLight | info->bShadeFlag;
		g_Render.SetRenderState(D3DRS_LIGHTING, light_enable);
		g_Render.LightEnable(0, info->bEnableEnvLight);

		// set region lighting color
		if(_pTerrain)
		{
		  int a = _pTerrain->GetTile((int)(pObj->getPos().x), (int)(pObj->getPos().y))->getIsland();
		  if(a != nArea)
		  {
			nArea = a;

			CAreaInfo* pArea = GetAreaInfo(nArea);
			if(pArea)
			{
			  env_color				= pArea->dwEnvColor;
			  env_light.Direction.x = pArea->fLightDir[0];
			  env_light.Direction.y = pArea->fLightDir[1];
			  env_light.Direction.z = pArea->fLightDir[2];
			  D3DXVec3Normalize((D3DXVECTOR3*)&env_light.Direction, (D3DXVECTOR3*)&env_light.Direction);

			  MPDwordByte4 db_color;
			  db_color.d		  = pArea->dwLightColor;
			  env_light.Diffuse.r = (float)(db_color.b[2] / 255.0f);
			  env_light.Diffuse.g = (float)(db_color.b[1] / 255.0f);
			  env_light.Diffuse.b = (float)(db_color.b[0] / 255.0f);

			  g_Render.SetRenderState(D3DRS_AMBIENT, env_color);
			  g_Render.SetLight(0, &env_light);
			}
		  }
		}

#if(defined OPEN_AMBIENT_ENV)
		if(info->bShadeFlag)
		{
		  MPDwordByte4 db4_obj;
		  MPDwordByte4 db4_env;
		  MPDwordByte4 db4_mix;

		  db4_obj.d = pObj->GetObjTileColor();
		  db4_env.d = env_color;

		  if(info->nSizeFlag == 0)
		  {
			db4_env.d = 0xffffffff;
		  }

		  db4_mix.b[0] = (BYTE)(db4_obj.b[0] * db4_env.b[0] / 255);
		  db4_mix.b[1] = (BYTE)(db4_obj.b[1] * db4_env.b[1] / 255);
		  db4_mix.b[2] = (BYTE)(db4_obj.b[2] * db4_env.b[2] / 255);
		  db4_mix.b[3] = (BYTE)(db4_obj.b[3] * db4_env.b[3] / 255);

		  g_Render.SetRenderState(D3DRS_AMBIENT, db4_mix.d);
		}
#endif

		if(light_enable)
		{
		  BeginUpdateSceneObjLight(pObj, info->bEnablePointLight);
		}

#if(!defined OPEN_AMBIENT_ENV)
		pObj->SetMaterial(&material);
#endif

		pObj->UpdateObjFadeInFadeOut(&org, &ray);

		int transp_flag = pObj->GetTransparentFlag();
		//transp_flag = 0;

		if(transp_flag)
		{
		  stosd = &_TranspObjStateSeq[_dwTranspObjStateID++];

		  g_Render.GetRenderState(D3DRS_LIGHTING, &stosd->rs_lgt);
		  g_Render.GetRenderState(D3DRS_AMBIENT, &stosd->rs_amb);
		  for(DWORD i = 0; i < 3; i++)
		  {
			g_Render.GetLightEnable(i, &stosd->light_enable[i]);
			if(stosd->light_enable[i])
			{
			  g_Render.GetLight(i, &stosd->light[i]);
			}
		  }

		  sm->SetTranspPrimitiveProc(__SceneTranspObjRenderProc, (void*)stosd);
		}

		try
		{
		  pObj->Render();
		} catch(...)
		{
		  LG("error", "pObj->Render()\n");
		}

		if(transp_flag)
		{
		  sm->SetTranspPrimitiveProc(0, 0);
		}

		if(light_enable)
		{
		  EndUpdateSceneObjLight(pObj);
		}

		if(info->bShadeFlag)
		{
		  g_Render.SetRenderState(D3DRS_AMBIENT, env_color);
		}
#ifdef __FPS_DEBUG__
		m_dwValidSceneObjCnt++;
#endif
	  }
	}

	rsm->EndSceneObject();

#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwRenderScneObjTime = t.End();
#endif

	if(_nShowChair)
	{
	  // 非普通物件的渲染(虚拟物件)
	  for(int k = SCENEOBJ_TYPE_POSE; k <= SCENEOBJ_TYPE_ENVSOUND; k++)
	  {
		for(it = _SceneObjIdx[k].begin(); it != _SceneObjIdx[k].end(); it++)
		{
		  int		 nArrayID = (*it);
		  CSceneObj* pObj	  = &_pSceneObjArray[nArrayID];
		  if(pObj->IsValid() && pObj->IsHide() == FALSE)
		  {
			pObj->Render();
#ifdef __FPS_DEBUG__
			m_dwValidSceneObjCnt++;
#endif
		  }
		}
	  }
	}
  }

#if(defined OPEN_AMBIENT_ENV)
  g_Render.SetRenderState(D3DRS_AMBIENT, rs_amb);
#endif
  /////////

#ifdef __FPS_DEBUG__
  m_dwSceneObjPolyCnt = dev_obj->GetMarkPolygonNum();
#endif
  drCullPriInfo cull_info;
  g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr()->GetCullPrimitiveInfo(&cull_info);

  dev_obj->EndBenchMark();

  DWORD nRenderPolygonNum = dev_obj->GetMarkPolygonNum();
#ifdef __FPS_DEBUG__
  m_dwSceneObjRenderTime = tObj.End();
#endif
  dev_obj->BeginBenchMark();

#ifdef __FPS_DEBUG__
  LETimer tCha;
  tCha.Begin();
  m_dwValidChaCnt = 0;
#endif

  //lemon add@2004.12.14 防止流光人物在特效影响下改变透明度
  g_Render.SetRenderState(D3DRS_TEXTUREFACTOR, 0xffffffff);

  {
	rsm->BeginCharacter();

	int			nArea = -1;
	D3DXVECTOR3 v(0, 0, 0);
	//if( GetMainCha() ) v = GetMainCha()->GetPos();
	DWORD	  env_color;
	DWORD	  env_color_old;
	D3DLIGHTX env_light;
	D3DLIGHTX env_light_old;
	memset(&env_light, 0, sizeof(env_light));
	env_light.Type = D3DLIGHT_DIRECTIONAL;
	g_Render.GetLight(0, &env_light_old);

	env_color = g_Config.m_dwLgtBkColor;
	g_Render.GetRenderState(D3DRS_AMBIENT, &env_color_old);
	g_Render.SetRenderState(D3DRS_AMBIENT, env_color);

#ifdef __FPS_DEBUG__
	LETimer t;
	t.Begin();
#endif
	BOOL		 cha_lgt	= 1;
	CChaRecord*	 cha_record = NULL;
	LETile*		 tile		= NULL;
	D3DXCOLOR	 c;
	float		 fLgt;
	MPDwordByte4 db_color;
	CAreaInfo*	 pArea = NULL;
	CCharacter*	 pCha  = NULL;
	extern bool	 g_IsShowShop;
	if(g_IsShowShop)
	{
	  for(i = 0; i < _nChaCnt; i++)
	  {
		pCha = &_pChaArray[i];
		if(!pCha->IsValid())
		  continue;

		if(pCha->GetIsForUI())
		  continue;

		if(pCha->IsHide())
		  continue;

		cha_record = pCha->GetDefaultChaInfo();
		cha_lgt	   = cha_record->bLight;
		if(pCha->GetEmiColorFlag())
		{
		  cha_lgt = 0;
		}

		g_Render.SetRenderState(D3DRS_LIGHTING, cha_lgt);
		if(cha_lgt)
		{
		  v		= pCha->GetPos();
		  tile	= _pTerrain->GetTile((int)v.x, (int)v.y);
		  nArea = tile->getIsland();

		  pArea = GetAreaInfo(nArea);
		  if(pArea)
		  {
			env_light.Direction.x = pArea->fLightDir[0];
			env_light.Direction.y = pArea->fLightDir[1];
			env_light.Direction.z = pArea->fLightDir[2];
			D3DXVec3Normalize((D3DXVECTOR3*)&env_light.Direction, (D3DXVECTOR3*)&env_light.Direction);

			db_color.d			= pArea->dwLightColor;
			env_light.Diffuse.r = (float)(db_color.b[2] / 255.0f);
			env_light.Diffuse.g = (float)(db_color.b[1] / 255.0f);
			env_light.Diffuse.b = (float)(db_color.b[0] / 255.0f);

			static int x = 1;
			if(x)
			{
			  c	   = tile->dwColor;
			  fLgt = g_Config.m_fLgtFactor;

			  env_light.Diffuse.r = (1 - fLgt) * env_light.Diffuse.r + fLgt * c.r;
			  env_light.Diffuse.g = (1 - fLgt) * env_light.Diffuse.g + fLgt * c.g;
			  env_light.Diffuse.b = (1 - fLgt) * env_light.Diffuse.b + fLgt * c.b;
			}
			g_Render.SetLight(0, &env_light);
		  }
		}
		pCha->UpdateTileColor();
		pCha->Render();
#ifdef __FPS_DEBUG__
		m_dwValidChaCnt++;
#endif
	  }
	} else
	{
	  int		  nMainTeamID = 0;
	  CCharacter* pMain		  = CGameScene::GetMainCha();
	  if(pMain) nMainTeamID = pMain->GetTeamLeaderID();
	  for(i = 0; i < _nChaCnt; i++)
	  {
		pCha = &_pChaArray[i];
		if(!pCha->IsValid())
		  continue;

		if(pCha->GetIsForUI())
		  continue;

		if(pCha->IsHide())
		  continue;

		if(pCha->IsPlayer())
		{
		  // 如果是玩家,仅显示队友或主角
		  if(!((nMainTeamID > 0 && nMainTeamID == pCha->GetTeamLeaderID()) || (pCha == pMain)))
		  {
			continue;
		  }
		}

		cha_record = pCha->GetDefaultChaInfo();
		cha_lgt	   = cha_record->bLight;
		if(pCha->GetEmiColorFlag())
		{
		  cha_lgt = 0;
		}

		g_Render.SetRenderState(D3DRS_LIGHTING, cha_lgt);
		if(cha_lgt)
		{
		  v		= pCha->GetPos();
		  tile	= _pTerrain->GetTile((int)v.x, (int)v.y);
		  nArea = tile->getIsland();

		  pArea = GetAreaInfo(nArea);
		  if(pArea)
		  {
			env_light.Direction.x = pArea->fLightDir[0];
			env_light.Direction.y = pArea->fLightDir[1];
			env_light.Direction.z = pArea->fLightDir[2];
			D3DXVec3Normalize((D3DXVECTOR3*)&env_light.Direction, (D3DXVECTOR3*)&env_light.Direction);

			db_color.d			= pArea->dwLightColor;
			env_light.Diffuse.r = (float)(db_color.b[2] / 255.0f);
			env_light.Diffuse.g = (float)(db_color.b[1] / 255.0f);
			env_light.Diffuse.b = (float)(db_color.b[0] / 255.0f);

			static int x = 1;
			if(x)
			{
			  c	   = tile->dwColor;
			  fLgt = g_Config.m_fLgtFactor;

			  env_light.Diffuse.r = (1 - fLgt) * env_light.Diffuse.r + fLgt * c.r;
			  env_light.Diffuse.g = (1 - fLgt) * env_light.Diffuse.g + fLgt * c.g;
			  env_light.Diffuse.b = (1 - fLgt) * env_light.Diffuse.b + fLgt * c.b;
			}
			g_Render.SetLight(0, &env_light);
		  }
		}
		pCha->UpdateTileColor();
		pCha->Render();
#ifdef __FPS_DEBUG__
		m_dwValidChaCnt++;
#endif
	  }
	}

	//// render Main Character
	// CCharacter* pMain = CGameScene::GetMainCha();
	//if(pMain)
	//{
	//    if(0 && g_mcl.flag == 0)
	//    {
	//        FILE* fp = fopen(".\\scripts\\test.txt", "rt");
	//        if(fp)
	//        {
	//            int amb[3], dif[3];
	//            fscanf_s(fp, "%d %d %d", &amb[0], &amb[1], &amb[2]);
	//            fscanf_s(fp, "%d %d %d", &dif[0], &dif[1], &dif[2]);

	//            g_mcl.amb = D3DCOLOR_XRGB(amb[0], amb[1], amb[2]);

	//            g_mcl.dif.x = dif[0] / 255.0f;
	//            g_mcl.dif.y = dif[1] / 255.0f;
	//            g_mcl.dif.z = dif[2] / 255.0f;

	//            g_mcl.flag = 1;

	//            fclose(fp);
	//        }
	//    }

	//    DWORD rs_amb = 0xffc0c0c0;

	//    D3DLIGHTX lgt;
	//    memset(&lgt, 0, sizeof(lgt));
	//    lgt.Type = D3DLIGHT_DIRECTIONAL;
	//    lgt.Diffuse.r = lgt.Diffuse.g = lgt.Diffuse.b = lgt.Diffuse.a = 1.0f;
	//    lgt.Direction = g_pGameApp->GetMainCam()->m_vViewDir;
	//    D3DXVec3Normalize((D3DXVECTOR3*)&lgt.Direction, (D3DXVECTOR3*)&lgt.Direction);

	//    if(g_mcl.flag == 1)
	//    {
	//        rs_amb = g_mcl.amb;

	//        lgt.Diffuse.r = g_mcl.dif.x;
	//        lgt.Diffuse.g = g_mcl.dif.y;
	//        lgt.Diffuse.b = g_mcl.dif.z;
	//        lgt.Diffuse.a = 1.0f;
	//    }

	//    g_Render.SetRenderState(D3DRS_AMBIENT, rs_amb);
	//    //lgt.Direction = D3DXVECTOR3(0.0f, 1.0f, 0.0f);
	//    g_Render.SetLight(0, &lgt);
	//    g_Render.SetRenderState(D3DRS_LIGHTING, TRUE);
	//    g_Render.LightEnable(0, TRUE);

	//    pMain->UpdateTileColor();
	//    pMain->Render();
#ifdef __FPS_DEBUG__
	//    m_dwValidChaCnt++;
#endif
	//}

#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwRenderChaTime = t.End();
#endif

	g_Render.SetLight(0, &env_light_old);
	g_Render.SetRenderState(D3DRS_AMBIENT, env_color_old);

	rsm->EndCharacter();
  }

  g_Render.SetRenderState(D3DRS_LIGHTING, 0);
  g_Render.SetRenderState(D3DRS_TEXTUREFACTOR, 0xffffffff);
  g_Render.SetRenderStateForced(D3DRS_TEXTUREFACTOR, 0xffffffff);

  if(_bShowSceneItem)
  {
	for(i = 0; i < _nSceneItemCnt; i++)
	{
	  CSceneItem* pObj = &_pSceneItemArray[i];
	  if(pObj->IsValid() && pObj->IsHide() == FALSE)
	  {
		//pObj->SetMaterial(&material);
		pObj->Render();
	  }
	}
  }

  dev_obj->EndBenchMark();
#ifdef __FPS_DEBUG__
  m_dwChaRenderTime = tCha.End();
  m_dwChaPolyCnt	= dev_obj->GetMarkPolygonNum();
#endif

  ////////
  g_Render.SetRenderState(D3DRS_LIGHTING, FALSE);

  g_Render.EnableZBuffer(TRUE);

  //渲染绑定效果的盒子
  //g_CEffBox.Render();
#ifdef __FPS_DEBUG__
  LETimer mpt;
#endif
  {
#ifdef __FPS_DEBUG__
	mpt.Begin();
#endif
	//g_Render.SetRenderState( D3DRS_LIGHTING, TRUE );

	try
	{
	  RenderEffectMap();
	} catch(...)
	{
	  LG("error", "RenderEffectMap\n");
	}

	//lemon add@2005.2.17
	if(_pcPugMgr)
	  _pcPugMgr->Render();

	ResMgr.RestoreEffect();
#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwRenderEffectTime = mpt.End();
#endif
  }
  g_Render.SetRenderState(D3DRS_TEXTUREFACTOR, 0xffffffff);
  g_Render.SetRenderStateForced(D3DRS_TEXTUREFACTOR, 0xffffffff);
  if(_pTerrain)
  {
	_pTerrain->RenderSea();
  }

  {
#ifdef __FPS_DEBUG__
	mpt.Begin();
#endif
	g_Render.SetTextureStageState(0, D3DTSS_ALPHAOP, D3DTOP_MODULATE);
	g_Render.SetTextureStageState(0, D3DTSS_COLORARG1, D3DTA_TEXTURE);
	g_Render.SetTextureStageState(0, D3DTSS_COLORARG2, D3DTA_DIFFUSE);

	rsm->BeginTranspObject();
	drUpdateSceneTransparentObject();
	rsm->EndTranspObject();
#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwTranspObjTime = mpt.End();
#endif
  }

  {
#ifdef __FPS_DEBUG__
	mpt.Begin();
#endif
	ResMgr.Render();

	//try
	{
	  RenderEffect();
	}
	//catch(...)
	{
	  //LG("error", "RenderEffect\n");
	}

	ResMgr.RestoreEffect();
#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwRenderEffectTime += mpt.End();
#endif
  }
  dev_obj->SetRenderState(D3DRS_FOGENABLE, FALSE);

  _RenderUpSeaShade();

  rsm->EndScene();

  {
#ifdef __FPS_DEBUG__
	mpt.Begin();
#endif
	if(_IsShowPath && _pTerrain)
	{
	  g_cFindPath.RenderPath(_pTerrain);
	}
#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwPathFinding = mpt.End();
#endif
  }

  CNavigationBar::g_cNaviBar.Render();
  //if(!bigmap.IsLoad())
  //	bigmap.Create();
  //bigmap.Render();
}

void CGameScene::RenderEffect()
{
  //if(ResMgr.GetCanFrame() != 1)
  //{
  //	//float *ft = ResMgr.GetDailTime();
  //	//*ft = 0;
  //	return;
  //}
  for(int i = 0; i < _nEffCnt; i++)
  {
	if(_pEffectArray[i].IsValid())
	{
	  _pEffectArray[i].Render();
	}
  }
}

void CGameScene::RenderEffectMap()
{
  for(int n = 0; n < _nShadeCnt; ++n)
  {
	if(_pShadeArray[n].IsValid())
	{
	  if(!_pShadeArray[n].IsUpSea())
		_pShadeArray[n].Render();
	  else
		_vecTempShade.push_back(n);
	}
  }
}

void CGameScene::_RenderUpSeaShade()
{
  for(int n = 0; n < _vecTempShade.size(); ++n)
  {
	_pShadeArray[*_vecTempShade[n]].Render();
  }
  _vecTempShade.clear();
}

void CGameScene::RenderSMallMap()
{
  MPIDeviceObject* dev_obj = g_Render.GetInterfaceMgr()->dev_obj;
  RenderStateMgr*  rsm	   = g_pGameApp->GetRenderStateMgr();

  rsm->BeginScene();

  // self begin
  static float fLightDir = 0.0f;
  fLightDir += 0.02f;
  if(fLightDir > D3DX_PI * 2.0f) fLightDir = 0.0f;

  float fX = 1.0f * tan(fLightDir);
  if(fX <= 0.0f) fX = 0.00001f;
  float fY = 1.0f / fX;

  list<int>::iterator it;
  for(it = _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].begin();
	  it != _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].end(); it++)
  {
	int		   nArrayID = (*it);
	CSceneObj* pObj		= &_pSceneObjArray[nArrayID];
	if(pObj->IsValid() && pObj->IsHide() == FALSE)
	{
	  pObj->UpdateLight();
	}
  }

  if(_pTerrain)
  {
	_pTerrain->DynamicLoading(GetTickCount());
	//_pTerrain->EnableNormalLight(0);

	_pTerrain->Render();
  }

  for(it = _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].begin();
	  it != _SceneObjIdx[SCENEOBJ_TYPE_POINTLIGHT].end(); it++)
  {
	int		   nArrayID = (*it);
	CSceneObj* pObj		= &_pSceneObjArray[nArrayID];

	if(pObj->IsValid() && pObj->IsHide() == FALSE)
	{
	  pObj->ClearLight();
	}
  }

  g_Render.EnableZBuffer(TRUE);

#if(defined OPEN_AMBIENT_ENV)
  g_Render.SetRenderState(D3DRS_LIGHTING, TRUE);
  g_Render.SetRenderState(D3DRS_SHADEMODE, D3DSHADE_GOURAUD);
  g_Render.LightEnable(0, 1);
  DWORD amb;
  DWORD rs_amb;
  g_Render.GetRenderState(D3DRS_AMBIENT, &rs_amb);

  amb = D3DCOLOR_XRGB((BYTE)(m_dwEnvColor.r * 255), (BYTE)(m_dwEnvColor.g * 255), (BYTE)(m_dwEnvColor.b * 255));
  g_Render.SetRenderState(D3DRS_AMBIENT, amb);
#else
  ////////
  D3DMATERIAL8 material;
  D3DUtil_InitMaterialI(material, 1.0f, 1.0f, 1.0f, 1.0f);
  material.Ambient = m_dwEnvColor;
#endif

#ifdef __FPS_DEBUG__
  LETimer tObj;
  tObj.Begin();
#endif

  dev_obj->BeginBenchMark();

  UpdateSceneAnimLight();

#ifdef __FPS_DEBUG__
  m_dwValidSceneObjCnt	= 0;
  m_dwRenderSceneObjCnt = 0;
  m_dwCullingTime		= 0;
#endif
  if(_bShowSceneObj)
  {
#ifdef __FPS_DEBUG__
	LETimer t;
	t.Begin();
#endif
	MPVector3 org(0.0f, 0.0f, 0.0f);
	MPVector3 ray(0.0f, 0.0f, 0.0f);
	GetMainChaPickRay(&org, &ray);

	drISceneMgr*			 sm	   = g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr();
	SceneTranspObjStateDesc* stosd = 0;

	_dwTranspObjStateID = 0;

	rsm->BeginSceneObject();

	DWORD	  env_color = 0;
	D3DLIGHTX env_light;
	memset(&env_light, 0, sizeof(env_light));
	env_light.Type = D3DLIGHT_DIRECTIONAL;

	g_Render.GetRenderState(D3DRS_AMBIENT, &env_color);

	int nArea = -1;

	list<int>::iterator it	   = _SceneObjIdx[0].begin();
	list<int>::iterator it_end = _SceneObjIdx[0].end();
	for(; it != it_end; ++it)
	{
	  int		 nArrayID = (*it);
	  CSceneObj* pObj	  = &_pSceneObjArray[nArrayID];
	  if(pObj->IsValid() && pObj->IsHide() == FALSE)
	  {
		//pObj->SetCullingFlag(0);
		if(!pObj->_isRBO())
		{
		  pObj->GetObject()->CullPrimitive();
		  if(pObj->GetObject()->GetCullingPrimitiveNum() == pObj->GetObject()->GetPrimitiveNum())
			continue;
		} else
		{
		  int a = 0;
		  a		= 10;
		}

		CSceneObjInfo* info = GetSceneObjInfo(pObj->getTypeID());

		BOOL light_enable = info->bEnableEnvLight | info->bEnablePointLight | info->bShadeFlag;
		g_Render.SetRenderState(D3DRS_LIGHTING, light_enable);
		g_Render.LightEnable(0, info->bEnableEnvLight);
		// set region lighting color
		int a = _pTerrain->GetTile((int)(pObj->getPos().x), (int)(pObj->getPos().y))->getIsland();
		if(a != nArea)
		{
		  nArea = a;

		  CAreaInfo* pArea = GetAreaInfo(nArea);
		  if(pArea)
		  {
			env_color			  = pArea->dwEnvColor;
			env_light.Direction.x = pArea->fLightDir[0];
			env_light.Direction.y = pArea->fLightDir[1];
			env_light.Direction.z = pArea->fLightDir[2];
			D3DXVec3Normalize((D3DXVECTOR3*)&env_light.Direction, (D3DXVECTOR3*)&env_light.Direction);

			MPDwordByte4 db_color;
			db_color.d			= pArea->dwLightColor;
			env_light.Diffuse.r = (float)(db_color.b[2] / 255.0f);
			env_light.Diffuse.g = (float)(db_color.b[1] / 255.0f);
			env_light.Diffuse.b = (float)(db_color.b[0] / 255.0f);

			g_Render.SetRenderState(D3DRS_AMBIENT, env_color);
			g_Render.SetLight(0, &env_light);
		  }
		}

#if(defined OPEN_AMBIENT_ENV)
		if(info->bShadeFlag)
		{
		  MPDwordByte4 db4_obj;
		  MPDwordByte4 db4_env;
		  MPDwordByte4 db4_mix;

		  db4_obj.d = pObj->GetObjTileColor();
		  db4_env.d = env_color;

		  // begin by Jack
		  // 以下代码是因为根据美术需要，模型沙草的明亮度需要调高
		  // 我们目前的设计方案明亮度的调整根据区域属性来决定
		  // 而无法单独对物件级别来指定数值
		  // 针对以上问题，目前需要调整的物件只有沙草一种，暂时
		  // 以临时代码做判断，如果以后此类物件增多，需要在sceneobj.txt
		  // 中额外再添加一项
		  if(info->nID == 232)
		  {
			db4_env.d = 0xffffffff;
		  }

		  db4_mix.b[0] = (BYTE)(db4_obj.b[0] * db4_env.b[0] / 255);
		  db4_mix.b[1] = (BYTE)(db4_obj.b[1] * db4_env.b[1] / 255);
		  db4_mix.b[2] = (BYTE)(db4_obj.b[2] * db4_env.b[2] / 255);
		  db4_mix.b[3] = (BYTE)(db4_obj.b[3] * db4_env.b[3] / 255);

		  g_Render.SetRenderState(D3DRS_AMBIENT, db4_mix.d);
		}
#endif

		if(light_enable)
		{
		  BeginUpdateSceneObjLight(pObj, info->bEnablePointLight);
		}

#if(!defined OPEN_AMBIENT_ENV)
		pObj->SetMaterial(&material);
#endif

		pObj->UpdateObjFadeInFadeOut(&org, &ray);

		int transp_flag = pObj->GetTransparentFlag();
		//transp_flag = 0;

		if(transp_flag)
		{
		  stosd = &_TranspObjStateSeq[_dwTranspObjStateID++];

		  g_Render.GetRenderState(D3DRS_LIGHTING, &stosd->rs_lgt);
		  g_Render.GetRenderState(D3DRS_AMBIENT, &stosd->rs_amb);
		  for(DWORD i = 0; i < 3; i++)
		  {
			g_Render.GetLightEnable(i, &stosd->light_enable[i]);
			if(stosd->light_enable[i])
			{
			  g_Render.GetLight(i, &stosd->light[i]);
			}
		  }

		  sm->SetTranspPrimitiveProc(__SceneTranspObjRenderProc, (void*)stosd);
		}

		pObj->Render();

		if(transp_flag)
		{
		  sm->SetTranspPrimitiveProc(0, 0);
		}

		if(light_enable)
		{
		  EndUpdateSceneObjLight(pObj);
		}

		if(info->bShadeFlag)
		{
		  g_Render.SetRenderState(D3DRS_AMBIENT, env_color);
		}
#ifdef __FPS_DEBUG__
		m_dwValidSceneObjCnt++;
#endif
	  } else if(pObj->_isRBO())
	  {
		int a = 0;
		a	  = 10;
	  }
	}

	rsm->EndSceneObject();
#ifdef __FPS_DEBUG__
	g_pGameApp->m_dwRenderScneObjTime = t.End();
#endif
  }

#if(defined OPEN_AMBIENT_ENV)
  g_Render.SetRenderState(D3DRS_AMBIENT, rs_amb);
#endif
  /////////

  drCullPriInfo cull_info;
  g_Render.GetInterfaceMgr()->sys_graphics->GetSceneMgr()->GetCullPrimitiveInfo(&cull_info);

  dev_obj->EndBenchMark();

  ////////
  g_Render.SetRenderState(D3DRS_LIGHTING, FALSE);

  g_Render.EnableZBuffer(TRUE);

  if(_pTerrain)
  {
	_pTerrain->RenderSea();
  }

  rsm->BeginTranspObject();
  drUpdateSceneTransparentObject();
  rsm->EndTranspObject();

  rsm->EndScene();
}

void CGameScene::_RenderUI()
{
  //extern bool g_IsShowShop;
  //if( !g_IsShowShop )
  //	return;
  //try
  //{
  int i;
  GetRender().SetIsConvert(false);

  CCharacter* pCha = _pChaArray;
  for(i = 0; i < _nChaCnt; i++)
  {
	if(pCha->IsValid() && !pCha->IsHide() && !pCha->GetIsForUI())
	{
	  if(pCha->GetHeadSay())
		pCha->GetHeadSay()->Render(pCha->GetPos());
	}
	pCha++;
  }

  if(_IsShowItemName)
  {
	CSceneItem* pItem = _pSceneItemArray;
	for(i = 0; i < _nSceneItemCnt; i++)
	{
	  if(pItem->IsValid() && !pItem->IsHide())
	  {
		pItem->RenderUI();
	  }
	  pItem++;
	}
  } else if(_pMouseInItem)
  {
	if(_pMouseInItem->IsValid())
	{
	  _pMouseInItem->RenderUI();
	} else
	{
	  _pMouseInItem = NULL;
	}
  }

  _pEventMgr->Render();

  GetRender().SetIsConvert(true);
  //}
  //catch(...)
  //{
  //	printf( "dangji" );
  //}
}
