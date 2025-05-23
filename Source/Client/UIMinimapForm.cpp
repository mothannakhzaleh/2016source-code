#include "StdAfx.h"
#include "uiminimapform.h"
#include "uiForm.h"
#include "uicompent.h"
#include "uilabel.h"
#include "gameapp.h"
#include "SmallMap.h"
#include "uiformmgr.h"
#include "uimemo.h"
#include "ui3dcompent.h"
#include "scene.h"
#include "uiEdit.h"
#include "uiCombo.h"
#include "worldscene.h"
#include "PacketCmd.h"
#include "character.h"
#include "EffectObj.h"
#include "MapSet.h"
#include "UIStoreForm.h"
#include "UIDoublePwdForm.h"
#include "UIMisLogForm.h" //add by alfred.shi 20080722
#include "UIstartform.h"  //add by alfred.shi 20080711
#include "uirumdealform.h"

#include "AreaRecord.h" //add by sunny.sun 20080903
#include "MonsterSet.h"

#include <shellapi.h>

using namespace GUI;

#define CHECK_FAILED(Status) ((Status) != 0)

//---------------------------------------------------------------------------
// class CTradeMgr
//---------------------------------------------------------------------------

CForm*	CMiniMapMgr::frmRadar = 0;
CEdit*	CMiniMapMgr::edtX	  = 0;
CEdit*	CMiniMapMgr::edtY	  = 0;
CCombo* CMiniMapMgr::cboAddr  = 0;

//---------------------------------------------------------------------------
bool CMiniMapMgr::Init()
{
  //初始化小地图
  frmMinimap = _FindForm("frmMinimap");
  if(!frmMinimap) return false;
  frmMinimap->evtEntrustMouseEvent = _MiniFormMouseEvent;

  MinimatRect = dynamic_cast<CCompent*>(frmMinimap->Find("imgMinimapRect"));
  if(!MinimatRect) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMinimap->GetName(), "imgMinimapRect");

  char szName[32] = {0};
  for(int i = 0; i < MAP_POS_MAX; i++)
  {
	_snprintf_s(szName, _countof(szName), _TRUNCATE, "labMapPos%d", i);

	labMapPosRand[i] = dynamic_cast<CLabelEx*>(frmMinimap->Find(szName)); //地图坐标
	if(!labMapPosRand[i]) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMinimap->GetName(), szName);
  }
  //labMapPos = dynamic_cast<CLabelEx*>(frmMinimap->Find( "labMapPos" )); //地图坐标
  //if( !labMapPos ) return Error("msgui.clu界面<%s>上找不到控件<%s>", frmMinimap->GetName(), "labMapPos");
  labMapPos = labMapPosRand[0];

  labMapName = dynamic_cast<CLabelEx*>(frmMinimap->Find("labMapName")); //地图名称
  if(!labMapName) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMinimap->GetName(), "labMapName");

  // 大地图
  frmBigmap = _FindForm("frmBigmap");
  if(!frmBigmap) return false;
  frmBigmap->Refresh();
  frmBigmap->evtShow = _evtShowbigmap;
  frmBigmap->evtHide = _evtHidebigmap;

  d3dBigmap = dynamic_cast<C3DCompent*>(frmBigmap->Find("d3dCompent"));
  if(!d3dBigmap) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmBigmap->GetName(), "d3dCompent");
  d3dBigmap->SetRenderEvent(_RenderBigmapEvent);

  //雷达
  frmRadar = _FindForm("frmSearch");
  if(!frmRadar) return false;
  frmRadar->evtEntrustMouseEvent = _RadarFormEvent;
  frmRadar->evtBeforeShow		 = _RadarFormBeforeShowEvent;

  chkID = (CCheckBox*)frmRadar->Find("chkID");
  chkID->SetIsChecked(true);

  edtX = dynamic_cast<CEdit*>(frmRadar->Find("edtLeft"));
  if(!edtX) return Error(RES_STRING(CL_LANGUAGE_MATCH_719), frmRadar->GetName(), "edtLeft");
  edtX->SetIsDigit(true);
  edtX->evtEnter = _evtRadarEnter;

  edtY = dynamic_cast<CEdit*>(frmRadar->Find("edtRight"));
  if(!edtY) return Error(RES_STRING(CL_LANGUAGE_MATCH_719), frmRadar->GetName(), "edtRight");
  edtY->SetIsDigit(true);
  edtY->evtEnter = _evtRadarEnter;

  cboAddr = dynamic_cast<CCombo*>(frmRadar->Find("cboMap"));
  if(!cboAddr) return Error(RES_STRING(CL_LANGUAGE_MATCH_719), frmRadar->GetName(), "cboMap");

  //add by alfred.shi 20080903 begin
  btnPosSearch = dynamic_cast<CTextButton*>(frmMinimap->Find("btnPosSearch"));
  if(!btnPosSearch) return false;
  btnPosSearch->evtMouseClick = _evtShowNPCList;

  btnQueen = dynamic_cast<CTextButton*>(frmMinimap->Find("btnQueen"));
  if(!btnPosSearch) return false;
  btnQueen->evtMouseClick = _evtShowQueen;

  btnQQ = dynamic_cast<CTextButton*>(frmMinimap->Find("btnQQ"));
  if(!btnQQ) return false;
  btnQQ->evtMouseClick = _evtShowQQ;

  btnSeach = dynamic_cast<CTextButton*>(frmMinimap->Find("btnSeach"));
  if(btnSeach)
	btnSeach->evtMouseClick = _evtSearchQueen;
  //	End
  return true;
}

void CMiniMapMgr::End()
{
}
//add by alfred.shi 20080711 begin
void CMiniMapMgr::_evtShowNPCList(CGuiData* pSender, int x, int y, DWORD key)
{
  CForm* f = CFormMgr::s_Mgr.Find("frmNpcShow");
  bool	 b = !f->GetIsShow();
  g_stUIStart.ShowNPCHelper(g_stUIStart.GetCurrMapName(), b);
}

void CMiniMapMgr::_evtShowQueen(CGuiData* pSender, int x, int y, DWORD key)
{
  g_stUIStart.ShowQueenButtonForm(true);
}

void CMiniMapMgr::_evtShowQQ(CGuiData* pSender, int x, int y, DWORD key)
{
  CForm* f = CFormMgr::s_Mgr.Find("frmQQ");
  if(f)
  {
	f->SetIsShow(!f->GetIsShow());
  }
  return;
}

void CMiniMapMgr::_evtSearchQueen(CGuiData* pSender, int x, int y, DWORD key)
{
  //CForm* f = CFormMgr::s_Mgr.Find( "frmjieguo2" );
  //f->SetIsShow( !f->GetIsShow() );
  g_stRumDealForm.RumDealOpenCheck();
  return;
}
//end

void CMiniMapMgr::_evtShowbigmap(CGuiData* pSender)
{
  CWorldScene* pWorldScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(!pWorldScene) return;

  g_pGameApp->Waiting();
  CS_MapMask();

  CCharacter* pMain = CGameScene::GetMainCha();
  if(pMain)
  {
	pMain->GetActor()->Stop();
  }

  // 协议发送回来时，再显示
  //if( CGameApp::GetCurScene() && CGameApp::GetCurScene()->GetLargerMap() )
  //{
  //	CGameApp::GetCurScene()->GetLargerMap()->Show( true );
  //}

  CMouseDown* pMouse = &pWorldScene->GetMouseDown();
  pMouse->SetIsEnabled(false);
}

void CMiniMapMgr::_evtHidebigmap(CGuiData* pSender)
{
  CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(!pScene) return;

  CMouseDown* pMouse = &pScene->GetMouseDown();
  pMouse->SetIsEnabled(true);

  if(CGameApp::GetCurScene() && CGameApp::GetCurScene()->GetLargerMap())
  {
	CGameApp::GetCurScene()->GetLargerMap()->Show(false);
  }
}

void CMiniMapMgr::_RenderBigmapEvent(C3DCompent* pSender, int x, int y)
{
  if(CGameApp::GetCurScene() && CGameApp::GetCurScene()->GetLargerMap())
  {
	CGameApp::GetCurScene()->GetLargerMap()->Render();
  }

  if(g_stUIMap.GetBigmapForm() && g_stUIMap.GetBigmapRect())
  {
	g_stUIMap._RenderBigMapHint();
  }
}

void CMiniMapMgr::_evtRadarEnter(CGuiData* pSender)
{
  ShowRadar();
}

void CMiniMapMgr::RefreshChaPos(int x, int y)
{
#ifdef _KOSDEMO_
  labMapPos->SetCaption("");
#else
  static CTimeWork time(1000);
  if(time.IsTimeOut(CGameApp::GetCurTick()))
  {
	int n = rand() % 9;
	labMapPos->SetIsShow(false);

	labMapPos = labMapPosRand[n];
	labMapPos->SetIsShow(true);
  }

  static char buf[32] = {0};
  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%d,%d", x / 100, y / 100);
  labMapPos->SetCaption(buf);
#endif
}

void CMiniMapMgr::RefreshMapName(const char* name)
{
#ifdef _KOSDEMO_
  if(labMapName) labMapName->SetCaption("");
#else
  if(labMapName) labMapName->SetCaption(name);
#endif
}

void CMiniMapMgr::_MiniFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();

  if(name == "btnOpen")
  {
	//打开或关闭大地图
	if(!g_stUIMap.frmBigmap->GetIsShow())
	  g_stUIMap.frmBigmap->Show();
	else
	  g_stUIMap.frmBigmap->Hide();
  } else if(name == "btnSearch")
  {
	frmRadar->SetIsShow(!frmRadar->GetIsShow());
  } else if(name == "btnOpenTempBag")
  {
	// 打开临时背包
	CUIInterface::MainChaMove();
	g_stUIStore.ShowTempKitbag();
  } else if(name == "btnOpenStore")
  {
	// 打开商城输入二次密码
	g_stUIStore.OpenStoreAsk();
	g_cFindPathEx.Reset();
	CNavigationBar::g_cNaviBar.Show(false);
	g_cFindPath.SetShortPathFinding(128, 38);
  } else if(name == "btnteam")
  {
	CS_VolunteerOpen(10);
  }

  //if( name=="btnClose" || name == "btnNo" )
  //{
  //	CGameApp::GetCurScene()->ShowMinimap( false ) ;
  //	pSender->GetForm()->Close();
  //	return;

  //}
  //float fCurPos = CGameApp::GetCurScene()->GetSmallMap()->GetDist();
  //if (name =="btnSmall")
  //{
  //	fCurPos +=5.0f;
  //	if (fCurPos >=40.0f ) fCurPos = 40.0f ;
  //	CGameApp::GetCurScene()->GetSmallMap()->SetDist( fCurPos );
  //}
  //else if (name == "btnBig" )
  //{
  //	fCurPos -= 5.0f;
  //	if ( fCurPos <= 20.0f ) fCurPos = 20.0f ;
  //	CGameApp::GetCurScene()->GetSmallMap()->SetDist( fCurPos );
  //}
  //else if (name == "btnHelp" )
  //{
  //	CForm* frmHelp = CFormMgr::s_Mgr.Find( "frmHelp" );
  //	if( frmHelp )
  //	{
  //		CMemo* memCtrl = dynamic_cast<CMemo*>(frmHelp->Find( "memCtrl" ));
  //		if( memCtrl )
  //		{
  //			memCtrl->Init();
  //			memCtrl->SetCaption( "《那个啥Online》操作指南_行    走：单击左键，按住不放可持续行走_战    斗：在城外对怪物单击左键可战斗_NPC对话：左键点击城里NPC可进行对话_视角转换：按住右键可水平旋转。滑动滚轮可推_    进拉远，双击右键回到默认的视角_组    队：对其他玩家点右键，选择邀请组队，_    组队后，只有队长才能邀请其他玩家加入_聊    天：Alt+F或点界面右下方按钮可打开_     聊天界面点击玩家头像，会出现对话框_交    易：对其他玩家点击右键，选择邀请交易_     获对方同意后，弹出玩家间交易界面" );
  //			memCtrl->ProcessCaption();
  //		}
  //		frmHelp->Refresh();
  //		frmHelp->Show();
  //	}
  //}
  return;
}

void CMiniMapMgr::_RadarFormEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();

  if(name == "btnYes")
  {
	ShowRadar();
  }
}

void CMiniMapMgr::_RadarFormBeforeShowEvent(CForm* pForm, bool& IsShow)
{
  if(!CGameApp::GetCurScene())
	return;

  IsShow = true;

  //得到玩家目前所在的地图名字
  CMapInfo* pMapInfo = GetMapInfo(CGameApp::GetCurScene()->GetInitParam()->strMapFile.c_str());
  if(!pMapInfo)
	cboAddr->GetList()->GetItems()->Select(0);
  else
  {
	int		  maxItemNum = cboAddr->GetList()->GetItems()->GetCount();
	CItemRow* pItemRow(0);
	int		  i(0);
	for(; i < maxItemNum; i++)
	{
	  /*CItemRow* */ pItemRow = cboAddr->GetList()->GetItems()->GetItem(i);
	  if(pItemRow)
	  {
		if(strcmp(pMapInfo->szName, pItemRow->GetBegin()->GetString()) == 0)
		  break;
	  }
	}
	if(i < maxItemNum)
	{
	  cboAddr->GetList()->GetItems()->Select(i);
	} else
	{
	  cboAddr->GetList()->GetItems()->Select(0);
	}
  }

  edtX->SetCaption("");
  edtY->SetCaption("");
  edtX->SetActive(edtX);

  if(frmRadar->GetIsShow())
  {
	frmRadar->Close();
  }
  if(CNavigationBar::g_cNaviBar.IsShow())
  {
	CNavigationBar::g_cNaviBar.Show(false);
  }
}

int CMiniMapMgr::CheckCoordinateEdit(const char* input)
{
  if(!(*input))
	return -1;

  while(*input)
  {
	if(0x30 <= (*input) && (*input) <= 0x39) //判断是数字
	{
	  input++;
	} else
	{
	  return -1;
	}
  }
  return 0;
}

void CMiniMapMgr::ClearRadar()
{
  edtX->SetCaption("");
  edtY->SetCaption("");
  cboAddr->GetList()->GetItems()->Select(0);
}

//add by alfred.shi 20080710
void CMiniMapMgr::ShowRadar(const char* szX, const char* szY)
{
  if(CHECK_FAILED(CheckCoordinateEdit(szX)))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_720));
	edtX->SetCaption("");
	edtX->SetActive(edtX);
	return;
  }
  if(CHECK_FAILED(CheckCoordinateEdit(szY)))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_720));
	edtY->SetCaption("");
	edtY->SetActive(edtY);
	return;
  }

  // 坐标;
  int		  x = atoi(szX), y = atoi(szY);
  D3DXVECTOR3 target((float)x, (float)y, 0);
  // 地点
  const char* _strName = g_pGameApp->GetCurScene()->GetTerrainName();
  if(strcmp(_strName, "garner") == 0)
	_strName = RES_STRING(CL_LANGUAGE_MATCH_56);
  else if(strcmp(_strName, "magicsea") == 0)
	_strName = RES_STRING(CL_LANGUAGE_MATCH_57);
  else if(strcmp(_strName, "darkblue") == 0)
	_strName = RES_STRING(CL_LANGUAGE_MATCH_58);
  else if(strcmp(_strName, "winterland") == 0)
	_strName = RES_STRING(CL_UIMISLOGFORM_CPP_00001);
  else if(strcmp(_strName, "jialebi") == 0)
	_strName = RES_STRING(CL_UIMISLOGFORM_CPP_00002);

  CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(!pScene) return;
  const char* curMap = pScene->GetCurMapInfo()->szName;

  if((strcmp(curMap, _strName) == 0) && (!pScene->GetMainCha()->IsBoat()))
  {
	if(g_stUIStart.chkID->GetIsChecked())
	{
	  g_cFindPathEx.Reset();
	  g_cFindPathEx.ClearDestDirection();
	  g_cFindPathEx.SetDestDirection((int)pScene->GetMainCha()->GetPos().x, (int)pScene->GetMainCha()->GetPos().y, x, y);
	  g_cFindPathEx.SetTarget((int)pScene->GetMainCha()->GetPos().x, (int)pScene->GetMainCha()->GetPos().y, x, y);
	}
  } else
  {
	if(pScene->GetMainCha()->IsBoat())
	{
	  g_stUIBox.ShowMsgBox(NULL, RES_STRING(CL_UIMISLOGFORM_CPP_00003));
	} else
	{
	  g_stUIBox.ShowMsgBox(NULL, RES_STRING(CL_UIMISLOGFORM_CPP_00004));
	}
  }
  CNavigationBar::g_cNaviBar.SetTarget((char*)_strName, target);
  CNavigationBar::g_cNaviBar.Show(true);
}

void CMiniMapMgr::ShowRadar()
{
  const char* szX = edtX->GetCaption();
  const char* szY = edtY->GetCaption();
  if(CHECK_FAILED(CheckCoordinateEdit(szX)))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_720));
	edtX->SetCaption("");
	edtX->SetActive(edtX);
	return;
  }
  if(CHECK_FAILED(CheckCoordinateEdit(szY)))
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_720));
	edtY->SetCaption("");
	edtY->SetActive(edtY);
	return;
  }

  edtX->SetActive(edtX); // 焦点应在X输入框，而不是先在Y输入框 add by rock.wang 090629
  // 坐标;
  int		  x = atoi(szX), y = atoi(szY);
  D3DXVECTOR3 target((float)x, (float)y, 0);
  // 地点
  const char* szAddress = cboAddr->GetText();

  CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(!pScene) return;
  const char* curMap = pScene->GetCurMapInfo()->szName;
  if((strcmp(curMap, szAddress) == 0) && (!pScene->GetMainCha()->IsBoat()))
  {
	if(g_stUIMap.chkID->GetIsChecked())
	{
	  g_cFindPathEx.Reset();
	  g_cFindPathEx.ClearDestDirection();
	  g_cFindPathEx.SetDestDirection((int)pScene->GetMainCha()->GetPos().x, (int)pScene->GetMainCha()->GetPos().y, x, y);
	  g_cFindPathEx.SetTarget((int)pScene->GetMainCha()->GetPos().x, (int)pScene->GetMainCha()->GetPos().y, x, y);
	}
  } else
  {
	if((pScene->GetMainCha()->IsBoat()))
	{
	  g_stUIBox.ShowMsgBox(NULL, RES_STRING(CL_UIMISLOGFORM_CPP_00003));
	} else
	{
	  g_stUIBox.ShowMsgBox(NULL, RES_STRING(CL_UIMISLOGFORM_CPP_00004));
	}
  }
  CNavigationBar::g_cNaviBar.SetTarget((char*)szAddress, target);
  CNavigationBar::g_cNaviBar.Show(true);
  frmRadar->Hide();
}

void CMiniMapMgr::SwitchMap()
{
  frmBigmap->Close();
}

bool CMiniMapMgr::IsShowBigmap()
{
  return frmBigmap->GetIsShow();
}

void CMiniMapMgr::CloseRadar()
{
  if(frmRadar && frmRadar->GetIsShow())
  {
	this->ClearRadar();
	frmRadar->Close();
  }

  if(CNavigationBar::g_cNaviBar.IsShow())
  {
	CNavigationBar::g_cNaviBar.Show(false);
  }
}

bool CMiniMapMgr::IsPKSilver()
{
  if(0 == strcmp(GetMapName(), RES_STRING(CL_LANGUAGE_MATCH_900))) // 乱斗白银城 //"白银城"))
	return true;

  CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(!pScene)
	return false;

  if(0 == strcmp(pScene->GetCurMapInfo()->szName, RES_STRING(CL_LANGUAGE_MATCH_900))) // 乱斗白银城 //"白银城"))
	return true;

  return false;
}

bool CMiniMapMgr::IsGuildWar()
{
  if(0 == strcmp(GetMapName(), RES_STRING(CL_LANGUAGE_MATCH_934)) || 0 == strcmp(GetMapName(), RES_STRING(CL_LANGUAGE_MATCH_934))) // "圣战" "小圣战"
	return true;

  return false;
}
//Add by sunny.sun 20080904
//Begin
void CMiniMapMgr::_RenderBigMapHint(void)
{
  //FontModule::Font* pfont = g_pGameApp->GetFont();
  //CLEFont				g_CFont
  if(/*!pfont ||*/ !CGameApp::GetCurScene() || !CGameApp::GetCurScene()->GetLargerMap()) return;

  POINT ptMouse; // 鼠标坐标（窗体坐标）
  GetCursorPos(&ptMouse);
  ScreenToClient(g_pGameApp->GetHWND(), &ptMouse);

  RECT rcBigMap; // 大地图矩形（窗体坐标）
  rcBigMap.left	  = GetBigmapForm()->GetLeft() + GetBigmapRect()->GetLeft();
  rcBigMap.top	  = GetBigmapForm()->GetTop() + GetBigmapRect()->GetTop();
  rcBigMap.right  = rcBigMap.left + GetBigmapRect()->GetWidth();
  rcBigMap.bottom = rcBigMap.top + GetBigmapRect()->GetHeight();

  POINT ptBigMapCenter; // 大地图中心坐标（窗体坐标）
  ptBigMapCenter.x = (rcBigMap.right - rcBigMap.left) >> 1;
  ptBigMapCenter.y = (rcBigMap.bottom - rcBigMap.top) >> 1;

  POINT ptCenter; // 大地图中心坐标（游戏坐标）
  ptCenter.x = CGameApp::GetCurScene()->GetLargerMap()->GetCenterX() / 100;
  ptCenter.y = CGameApp::GetCurScene()->GetLargerMap()->GetCenterY() / 100;

  static const float MAP_SCALE = 1.25f; // 大地图像素比例，一个推测的 magic number  :)

  // 绘制主城和补给站，昊爷要求
  /*if(0 == stricmp(CGameApp::GetCurScene()->GetTerrainName(), "garner") 
		||0 == stricmp(CGameApp::GetCurScene()->GetTerrainName(), "magicsea")
		||0 == stricmp(CGameApp::GetCurScene()->GetTerrainName(), "darkblue"))*/
  if(0 == _stricmp(CGameApp::GetCurScene()->GetTerrainName(), "garner") || 0 == _stricmp(CGameApp::GetCurScene()->GetTerrainName(), "magicsea") || 0 == _stricmp(CGameApp::GetCurScene()->GetTerrainName(), "darkblue"))
  {
	struct SApplyInfo
	{
	  int nAreaID; // 对应 AreaSet 表里的 ID
	  int x, y;
	};

	SApplyInfo stApply[8];

	//     static SApplyInfo stApply[] =
	//     {
	//{	1,	2218,	2759	},	//白银城
	//{	55,	1891,	2800	},	//废矿补给站
	//{	58,	1509,	3093	},	//古里咯利补给站
	//{	53,	1002,	2972	},	//赖安森林补给站
	//{	61,	1114,	2773	},	//瓦尔诺补给站
	//{	63,	526,	2440	},	//温拿补给站
	//{	8,	736,	1511	},	//雷霆堡
	//{	13,	855,	3568	},	//沙岚新城
	//{	57,	781,	3118	},	//沙泉补给站
	//{	62,	1204,	3204	},	//巴布补给站
	//{	20,	1319,	521		},	//冰狼堡下城
	//{	56,	794,	353		},	//冰都补给站
	//{	59,	1048,	648		},	//阿兰比斯补给站
	//{	60,	2137,	551		},	//骷髅营地补给站
	//{	54,	611,	2097	},	//卡尔加德补给站
	//     };

	//	if(0 == stricmp(CGameApp::GetCurScene()->GetTerrainName(), "garner"))
	if(0 == _stricmp(CGameApp::GetCurScene()->GetTerrainName(), "garner"))
	{
	  stApply[0].nAreaID = 1;
	  stApply[0].x		 = 2218;
	  stApply[0].y		 = 2759;

	  stApply[1].nAreaID = 55;
	  stApply[1].x		 = 1891;
	  stApply[1].y		 = 2800;

	  stApply[2].nAreaID = 58;
	  stApply[2].x		 = 1509;
	  stApply[2].y		 = 3093;

	  stApply[3].nAreaID = 53;
	  stApply[3].x		 = 1002;
	  stApply[3].y		 = 2972;

	  stApply[4].nAreaID = 61;
	  stApply[4].x		 = 1114;
	  stApply[4].y		 = 2773;

	  stApply[5].nAreaID = 63;
	  stApply[5].x		 = 526;
	  stApply[5].y		 = 2440;

	  stApply[6].nAreaID = 8;
	  stApply[6].x		 = 736;
	  stApply[6].y		 = 1511;

	  stApply[7].nAreaID = 54;
	  stApply[7].x		 = 611;
	  stApply[7].y		 = 2097;
	}
	//	if(0 == stricmp(CGameApp::GetCurScene()->GetTerrainName(), "magicsea"))
	if(0 == _stricmp(CGameApp::GetCurScene()->GetTerrainName(), "magicsea"))
	{
	  stApply[0].nAreaID = 57;
	  stApply[0].x		 = 781;
	  stApply[0].y		 = 3118;

	  stApply[1].nAreaID = 13;
	  stApply[1].x		 = 855;
	  stApply[1].y		 = 3568;

	  stApply[2].nAreaID = 62;
	  stApply[2].x		 = 1204;
	  stApply[2].y		 = 3204;

	  stApply[3].nAreaID = 0;
	  stApply[3].x		 = 0;
	  stApply[3].y		 = 0;

	  stApply[4].nAreaID = 0;
	  stApply[4].x		 = 0;
	  stApply[4].y		 = 0;

	  stApply[5].nAreaID = 0;
	  stApply[5].x		 = 0;
	  stApply[5].y		 = 0;

	  stApply[6].nAreaID = 0;
	  stApply[6].x		 = 0;
	  stApply[6].y		 = 0;

	  stApply[7].nAreaID = 0;
	  stApply[7].x		 = 0;
	  stApply[7].y		 = 0;
	}
	//	if(0 == stricmp(CGameApp::GetCurScene()->GetTerrainName(), "darkblue"))
	if(0 == _stricmp(CGameApp::GetCurScene()->GetTerrainName(), "darkblue"))
	{
	  stApply[0].nAreaID = 20;
	  stApply[0].x		 = 1319;
	  stApply[0].y		 = 521;

	  stApply[1].nAreaID = 56;
	  stApply[1].x		 = 794;
	  stApply[1].y		 = 353;

	  stApply[2].nAreaID = 59;
	  stApply[2].x		 = 1048;
	  stApply[2].y		 = 648;

	  stApply[3].nAreaID = 60;
	  stApply[3].x		 = 2137;
	  stApply[3].y		 = 551;

	  stApply[4].nAreaID = 0;
	  stApply[4].x		 = 0;
	  stApply[4].y		 = 0;

	  stApply[5].nAreaID = 0;
	  stApply[5].x		 = 0;
	  stApply[5].y		 = 0;

	  stApply[6].nAreaID = 0;
	  stApply[6].x		 = 0;
	  stApply[6].y		 = 0;

	  stApply[7].nAreaID = 0;
	  stApply[7].x		 = 0;
	  stApply[7].y		 = 0;
	}

	RECT rcBigMapArea; // 大地图区域（游戏坐标）
	rcBigMapArea.left	= ptCenter.x - ((int)((rcBigMap.right - rcBigMap.left) * MAP_SCALE) >> 1);
	rcBigMapArea.right	= ptCenter.x + ((int)((rcBigMap.right - rcBigMap.left) * MAP_SCALE) >> 1);
	rcBigMapArea.top	= ptCenter.y - ((int)((rcBigMap.bottom - rcBigMap.top) * MAP_SCALE) >> 1);
	rcBigMapArea.bottom = ptCenter.y + ((int)((rcBigMap.bottom - rcBigMap.top) * MAP_SCALE) >> 1);

	int nCount = sizeof(stApply) / sizeof(stApply[0]);
	for(int i = 0; i < nCount; ++i)
	{
	  if(rcBigMapArea.left < stApply[i].x && stApply[i].x < rcBigMapArea.right &&
		 rcBigMapArea.top < stApply[i].y && stApply[i].y < rcBigMapArea.bottom)
	  {
		CAreaInfo* pInfo = GetAreaInfo(stApply[i].nAreaID);
		if(!pInfo) continue;

		POINT ptRender; // 绘制 补给站的坐标（游戏坐标->屏幕坐标）
		ptRender.x = rcBigMap.left + (LONG)((stApply[i].x - rcBigMapArea.left) / MAP_SCALE);
		ptRender.y = rcBigMap.top + (LONG)((stApply[i].y - rcBigMapArea.top) / MAP_SCALE);

		//SIZE size;    // 计算绘制中心点偏移
		//pfont->GetTextSize(pInfo->szDataName, &size);
		//ptRender.x -= size.cx >> 1;
		//ptRender.y -= size.cy >> 1;

		g_pGameApp->GetFont()->DrawText(pInfo->szDataName, ptRender.x, ptRender.y);
	  }
	}
  }

  // 鼠标如果落在大地图矩形内，则绘制提示
  if(rcBigMap.left < ptMouse.x && ptMouse.x < rcBigMap.right &&
	 rcBigMap.top < ptMouse.y && ptMouse.y < rcBigMap.bottom)
  {
	POINT ptCurMouse; // 当前鼠标坐标（屏幕坐标->游戏坐标）
	ptCurMouse.x = ptCenter.x + (int)((ptMouse.x - ptBigMapCenter.x - rcBigMap.left) * MAP_SCALE);
	ptCurMouse.y = ptCenter.y + (int)((ptMouse.y - ptBigMapCenter.y - rcBigMap.top) * MAP_SCALE);

	if(ptCurMouse.x < 0 || ptCurMouse.x > defMAP_GARNER_WIDTH ||
	   ptCurMouse.y < 0 || ptCurMouse.y > defMAP_GARNER_WIDTH) return;

	// 寻找对应的列表
	CMonsterInfo* pInfo = 0;
	int			  nID	= 1;
	for(;;)
	{
	  pInfo = GetMonsterInfo(nID++);
	  if(!pInfo)
	  {
		break;
	  }

	  if(pInfo->ptStart.x < ptCurMouse.x && ptCurMouse.x < pInfo->ptEnd.x &&
		 pInfo->ptStart.y < ptCurMouse.y && ptCurMouse.y < pInfo->ptEnd.y &&
		 0 == strcmp(CGameApp::GetCurScene()->GetTerrainName(), pInfo->szArea))
	  {
		break;
	  }
	}

	if(pInfo)
	{
	  RECT rcMonster; // 刷怪范围（游戏坐标）
	  SetRect(&rcMonster, pInfo->ptStart.x, pInfo->ptStart.y,
			  pInfo->ptEnd.x, pInfo->ptEnd.y);

	  // 怪物试验（游戏坐标->屏幕坐标）
	  rcMonster.left   = rcBigMap.left + ptBigMapCenter.x + (int)((rcMonster.left - ptCenter.x) / MAP_SCALE);
	  rcMonster.top	   = rcBigMap.top + ptBigMapCenter.y + (int)((rcMonster.top - ptCenter.y) / MAP_SCALE);
	  rcMonster.right  = rcBigMap.left + ptBigMapCenter.x + (int)((rcMonster.right - ptCenter.x) / MAP_SCALE);
	  rcMonster.bottom = rcBigMap.top + ptBigMapCenter.y + (int)((rcMonster.bottom - ptCenter.y) / MAP_SCALE);

	  // 超出范围裁减
	  if(rcMonster.left < rcBigMap.left) rcMonster.left = rcBigMap.left;
	  if(rcMonster.top < rcBigMap.top) rcMonster.top = rcBigMap.top;
	  if(rcMonster.right > rcBigMap.right) rcMonster.right = rcBigMap.right;
	  if(rcMonster.bottom > rcBigMap.bottom) rcMonster.bottom = rcBigMap.bottom;

	  // 获得该区域怪物信息
	  CChaRecord* pMonsterInfo[MONSTER_LIST_MAX] = {0};
	  string	  strMonsterName[MONSTER_LIST_MAX];
	  int		  nMonCount	  = 0;
	  int		  nLevelSum	  = 0;
	  SIZE		  sizeNameMax = {0};
	  for(int i = 0; i < MONSTER_LIST_MAX; ++i)
	  {
		if(0 == pInfo->nMonsterList[i]) break;

		pMonsterInfo[i] = GetChaRecordInfo(pInfo->nMonsterList[i]);
		if(!pMonsterInfo[i]) continue;

		nLevelSum += pMonsterInfo[i]->lLv;
		nMonCount++;

		char szBuf[256] = {0};
		_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, " %d. %s   LV:%2d ", nMonCount, pMonsterInfo[i]->szName, pMonsterInfo[i]->lLv);
		strMonsterName[i] = szBuf;

		SIZE size;
		g_pGameApp->GetFont()->GetTextSize(szBuf, &size);
		if(size.cx > sizeNameMax.cx) sizeNameMax.cx = size.cx;
		if(size.cy > sizeNameMax.cy) sizeNameMax.cy = size.cy;
	  }

	  if(nMonCount > 0)
	  {
		//	int nLevelCha = g_pGameApp->GetCurScene()->GetMainCha()->getGameAttr()->get(ATTR_LV);
		int nLevelCha = (int)g_pGameApp->GetCurScene()->GetMainCha()->getGameAttr()->get(ATTR_LV);
		int nLevelAvg = nLevelSum / nMonCount; // 该区域怪的平均等级

		DWORD dwAreaColor = 0;
		if(nLevelAvg > nLevelCha + 15)
		  dwAreaColor = 0x00FF0000;
		else if(nLevelAvg > nLevelCha + 5)
		  dwAreaColor = 0x00FFFF00;
		else if(nLevelAvg > nLevelCha - 5)
		  dwAreaColor = 0x0000FF00;
		else if(nLevelAvg > nLevelCha - 15)
		  dwAreaColor = 0x0000CCFF;
		else
		  dwAreaColor = 0x00666666;

		BYTE byAlpha = 0x80;
		dwAreaColor &= 0x00FFFFFF;
		dwAreaColor |= (byAlpha << 24);

		GetRender().FillFrame(rcMonster.left, rcMonster.top, rcMonster.right, rcMonster.bottom, dwAreaColor);

		// 怪物列表
		RECT rcRender = rcBigMap;
		GetRender().FillFrame(rcBigMap.left, rcRender.top, rcRender.left + sizeNameMax.cx, rcRender.top + (sizeNameMax.cy * nMonCount));
		for(int i = 0; i < nMonCount; ++i)
		{
		  g_pGameApp->GetFont()->DrawText(const_cast<char*>(strMonsterName[i].c_str()), rcRender.left + 35, rcRender.top + 50);
		  rcRender.top += sizeNameMax.cy;
		}
	  }
	}

	//        // 绘制鼠标指向的坐标
	char szBuf[256] = {0};
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, " Point: %d, %d ", ptCurMouse.x, ptCurMouse.y);

	SIZE size;
	g_pGameApp->GetFont()->GetTextSize(szBuf, &size);

	GetRender().FillFrame(ptMouse.x + 32, ptMouse.y, ptMouse.x + 32 + size.cx, ptMouse.y + size.cy);
	g_pGameApp->GetFont()->DrawText(szBuf, ptMouse.x + 32, ptMouse.y);
  }
}
//End
