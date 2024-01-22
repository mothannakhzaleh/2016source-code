#include "StdAfx.h"
#include "uistartform.h"
#include "uiform.h"
#include "uitextbutton.h"
#include "uiformmgr.h"
#include "uiprogressbar.h"
#include "uilabel.h"
#include "netchat.h"
#include "packetcmd.h"
#include "gameapp.h"
#include "uigrid.h"
#include "character.h"
#include "uiheadsay.h"
#include "uimenu.h"
#include "uilist.h"
#include "uigrid.h"
#include "UIGlobalVar.h"
#include "UIMisLogForm.h"
#include "UICozeForm.h"
#include "NetGuild.h"
#include "uiguildmgr.h"
#include "worldscene.h"
#include "uititle.h"
#include "uiboxform.h"
#include "shipfactory.h"
#include "uiboatform.h"
#include "arearecord.h"
#include "isskilluse.h"
#include "ui3dcompent.h"
#include "smallmap.h"
#include "mapset.h"
#include "uiequipform.h"
#include "uiTradeForm.h"
#include "uiFindTeamForm.h"
#include "uistoreform.h"
#include "uidoublepwdform.h"
#include "uiitemcommand.h"
#include "uiminimapform.h"
#include "uibankform.h"
#include "uiboothform.h"
#include "uitradeform.h"
#include "UIChat.h"
#include "UITeam.h"
#include "NPCHelper.h" //add by alfred.shi 20080710
#include "uiCombo.h"   //	挂机
#include "procirculate.h"
#include "packetcmd.h"

// Add by lark.li 20080811 begin
#include "UITeam.h"
// End

using namespace GUI;

static CForm* frmSelectOriginRelive = NULL;

//---------------------------------------------------------------------------
// class CStartMgr
//---------------------------------------------------------------------------
CMenu*		  CStartMgr::mainMouseRight = NULL;
CTextButton*  CStartMgr::btnQQ			= NULL;
CCharacter2D* CStartMgr::pMainCha		= NULL;
CCombo*		  CStartMgr::cboexp			= 0;
CForm*		  CStartMgr::frmDaoJu		= NULL;
CGoodsGrid*	  CStartMgr::grdDaoJu		= NULL;

static char szBuf[32] = {0};

int numExpItem(0), sTime(0), nPosition(-1), itemNumInBag(0);

bool CStartMgr::Init()
{
  _IsNewer	 = false;
  _IsCanTeam = true;

  // 玩家自己角色的HP，SP，EXP,名字,头像
  {
	frmDetail = _FindForm("frmDetail");
	if(frmDetail)
	{
	  frmDetail->Refresh();
	  proMainHP = dynamic_cast<CProgressBar*>(frmDetail->Find("proMainHP1"));
	  if(!proMainHP) return Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "proMainHP1");
	  proMainHP->SetPosition(0.0f);

	  proMainSP = dynamic_cast<CProgressBar*>(frmDetail->Find("proMainSP"));
	  if(!proMainSP) return Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "proMainSP");
	  proMainSP->SetPosition(0.0f);

	  proMainExp = dynamic_cast<CProgressBar*>(frmDetail->Find("proMainEXP"));
	  if(!proMainExp)
	  {
		Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "proMainEXP");
	  } else
	  {
		proMainExp->SetPosition(0.0f);
	  }

	  labMainName = dynamic_cast<CLabel*>(frmDetail->Find("labMainID"));
	  if(!labMainName) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "labMainID");

	  labMainLevel = dynamic_cast<CLabel*>(frmDetail->Find("labMainLv"));
	  if(!labMainLevel) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "labMainLv");

	  imgLeader = dynamic_cast<CImage*>(frmDetail->Find("imgLeader"));
	  if(!imgLeader) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "imgLeader");

	  C3DCompent* d3dSelfDown = dynamic_cast<C3DCompent*>(frmDetail->Find("d3dSelfDown"));
	  if(!d3dSelfDown) return Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "d3dSelfDown");
	  //d3dSelfDown->SetRenderEvent( _MainChaRenderEvent );
	  d3dSelfDown->evtMouseDown = _evtSelfMouseDown;
	  d3dSelfDown->SetMouseAction(enumMA_Skill);

	  C3DCompent* p3D = dynamic_cast<C3DCompent*>(frmDetail->Find("d3dSelf"));
	  if(!p3D) return Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmDetail->GetName(), "d3dSelf");

	  p3D->SetRenderEvent(_MainChaRenderEvent);
	  //p3D->evtMouseDown = _evtSelfMouseDown;
	  //p3D->SetMouseAction( enumMA_Skill );

	  RECT rt;
	  rt.left	= p3D->GetX();
	  rt.right	= p3D->GetX2();
	  rt.top	= p3D->GetY();
	  rt.bottom = p3D->GetY2();

	  pMainCha = new CCharacter2D;
	  pMainCha->Create(rt);
	}

	// 点自己头像的右键菜单
	mnuSelf = CMenu::FindMenu("selfMouseRight");
	if(!mnuSelf) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMain800->GetName(), "selfMouseRight");
	mnuSelf->evtListMouseDown = _OnSelfMenu;
  }

  // frmMain800表单
  {
	frmMain800						 = _FindForm("frmMain800");
	frmMain800->evtEntrustMouseEvent = _evtTaskMouseEvent;

	tlCity	= dynamic_cast<CTitle*>(frmMain800->Find("tlCity"));
	tlField = dynamic_cast<CTitle*>(frmMain800->Find("tlField"));

	//grdHeart = dynamic_cast<CGrid*>(frmMain800->Find("grdHeart"));
	//if( !grdHeart )	return Error( "msgui.clu界面<%s>上找不到控件<%s>", frmMain800->GetName(), "grdHeart" );
	//grdHeart->evtSelectChange = _evtChaHeartChange;

	//grdAction = dynamic_cast<CGrid*>(frmMain800->Find("grdAction"));
	//if( !grdAction ) return Error( "msgui.clu界面<%s>上找不到控件<%s>", frmMain800->GetName(), "grdAction" );
	//grdAction->evtSelectChange = _evtChaActionChange;
  }

  // 角色属性
  //proMainHP1 =  dynamic_cast<CProgressBar *> ( frmMain800->Find("proMainHP1") );
  //if( !proMainHP1 ) return Error( "msgui.clu界面<%s>上找不到控件<%s>", frmMain800->GetName(), "proMainHP1" );
  //proMainHP1->SetPosition(10.0f );
  //
  //proMainHP2 =  dynamic_cast<CProgressBar *> ( frmMain800->Find("proMainHP2") );
  //if( !proMainHP2 ) return Error( "msgui.clu界面<%s>上找不到控件<%s>", frmMain800->GetName(), "proMainHP2" );
  //proMainHP2->SetPosition(10.0f );

  //proMainHP3 =  dynamic_cast<CProgressBar *> ( frmMain800->Find("proMainHP3") );
  //if( !proMainHP3 ) return Error( "msgui.clu界面<%s>上找不到控件<%s>", frmMain800->GetName(), "proMainHP3" );
  //proMainHP3->SetPosition(10.0f );

  //proMainSP =  dynamic_cast<CProgressBar *> ( frmMain800->Find("proMainSP") );
  //if( !proMainSP ) return Error( "msgui.clu界面<%s>上找不到控件<%s>", frmMain800->GetName(), "proMainSP" );
  //  	proMainSP->SetPosition (10.0f );

  //_pShowExp = dynamic_cast<CLabel*>(frmMain800->Find( "labMainEXP" ) );
  //_pShowLevel = dynamic_cast<CLabel*>(frmMain800->Find( "labMainLV" ) );

  //frmMainFun表单
  {
	frmMainFun = _FindForm("frmMainFun");
	if(!frmMainFun) return false;

	frmMainFun->evtEntrustMouseEvent = _evtStartFormMouseEvent;

	// QQ
	/*FORM_CONTROL_LOADING_CHECK(btnQQ,frmMainFun,CTextButton,"msgui.clu","btnQQ");
		btnQQ->GetImage()->LoadImage("texture/ui/main800.tga",32,32,4,136,201);*/

	// 升级帮助，会闪烁
	btnLevelUpHelp = dynamic_cast<CTextButton*>(frmMainFun->Find("btnLevelUpHelp"));
	//FORM_CONTROL_LOADING_CHECK(btnLevelUpHelp, frmMainFun, CTextButton, "msgui.clu", "btnLevelUpHelp");
	if(btnLevelUpHelp) btnLevelUpHelp->SetFlashCycle();

	//	Add by alfred.shi 20080904	begin
	btnLevelUpadd = dynamic_cast<CTextButton*>(frmMainFun->Find("btnLevelUpadd"));
	if(btnLevelUpadd) btnLevelUpadd->SetFlashCycle();
	btnLevelUpadd->SetIsShow(false);
	//	End.

	//	挂机
	btnafk = dynamic_cast<CTextButton*>(frmMainFun->Find("btnafk"));
	if(btnafk)
	{
	  //btnafk->SetFlashCycle();
	}

	btnafk->SetIsShow(false); //	是否显示根据服务器发送时间来判断。

	frmElfAfk = _FindForm("frmElfAfk");
	if(!frmElfAfk) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmElfAfk", "frmElfAfk");
	if(frmElfAfk)
	{
	  frmElfAfk->Refresh();
	  labelfexp = dynamic_cast<CLabel*>(frmElfAfk->Find("labelfexp"));
	  if(!labelfexp) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfAfk->GetName(), "labelfexp");
	}
	btnelfafkYes					= dynamic_cast<CTextButton*>(frmElfAfk->Find("btnelfafkYes"));
	frmElfAfk->evtEntrustMouseEvent = _evtFormMouseClick;

	FORM_CONTROL_LOADING_CHECK(cboexp, frmElfAfk, CCombo, "player.clu", "cboexp");
	cboexp->evtSelectChange = EventSendTimeChange;
	cboexp->GetList()->GetItems()->Select(0);
	cboexp = dynamic_cast<CCombo*>(frmElfAfk->Find("cboexp"));
	if(!cboexp) return Error(RES_STRING(CL_LANGUAGE_MATCH_719), frmElfAfk->GetName(), "cboexp");

	cmdexpItem[0] = dynamic_cast<COneCommand*>(frmElfAfk->Find("cmdexpItem"));
	if(!cmdexpItem[0]) return Error(RES_STRING(CL_LANGUAGE_MATCH_719), frmElfAfk->GetName(), "cmdexpItem");
	cmdexpItem[0]->SetCaption("0");
	cmdexpItem[0]->evtBeforeAccept = _evtDragExpItem;

	frmElfAfk->evtClose = _evtCloseExpFrm;

	frmElfchat						 = _FindForm("frmElfchat");
	frmElfchat->evtEntrustMouseEvent = _evtFormMouseClick;
	if(!frmElfchat) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmElfchat", "frmElfchat");

	ElfTxt02 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt02"));
	if(!ElfTxt02) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxt02");
	ElfTxt02->SetCaption("0");

	ElfTxt04 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt04"));
	if(!ElfTxt04) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxt04");
	ElfTxt04->SetCaption("0");

	ElfTxt06 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt06"));
	if(!ElfTxt06) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxt06");
	ElfTxt06->SetCaption("0");

	ElfTxt08 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt08"));
	if(!ElfTxt08) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxElfTxt08t02");
	ElfTxt08->SetCaption("0");

	ElfTxt10 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt10"));
	if(!ElfTxt10) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxt10");
	ElfTxt10->SetCaption("0");

	ElfTxt12 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt12"));
	if(!ElfTxt12) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxt12");
	ElfTxt12->SetCaption("0");

	ElfTxt14 = dynamic_cast<CLabel*>(frmElfchat->Find("ElfTxt14"));
	if(!ElfTxt14) Error(RES_STRING(CL_LANGUAGE_MATCH_473), frmElfchat->GetName(), "ElfTxt14");
	ElfTxt14->SetCaption("0");
	//	end
  }

  // 右键菜单
  mainMouseRight = CMenu::FindMenu("mainMouseRight");
  if(!mainMouseRight)
  {
	return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMain800->GetName(), "mainMouseRight");
  }
  mainMouseRight->evtListMouseDown = _evtPopMenu;

  // 主角复活表单
  frmMainChaRelive = _FindForm("frmRelive");
  if(!frmMainChaRelive) return false;
  frmMainChaRelive->evtEntrustMouseEvent = _evtReliveFormMouseEvent;

  //船只航行时的界面
  frmShipSail = _FindForm("frmShipsail"); //属性表单
  if(!frmShipSail) return false;

  labCanonShow	= (CLabelEx*)frmShipSail->Find("labCanonShow1");
  labSailorShow = (CLabelEx*)frmShipSail->Find("labSailorShow1");
  labLevelShow	= (CLabelEx*)frmShipSail->Find("labLvship");
  labExpShow	= (CLabelEx*)frmShipSail->Find("labExpship");

  proSailor = (CProgressBar*)frmShipSail->Find("proSailor"); //耐久滚动条
  proCanon	= (CProgressBar*)frmShipSail->Find("proCanon");	 //补给滚动条
  frmShipSail->SetIsShow(false);

  //	Modify by alfred.shi 20080828
  CTextButton* btn1 = (CTextButton*)frmShipSail->Find("btnShip");
  if(!btn1) return false;
  btn1->evtMouseClick = _evtShowBoatAttr;

  // 自动跟随
  frmFollow = _FindForm("frmFollow");
  if(!frmFollow) return false;

  labFollow = dynamic_cast<CLabel*>(frmFollow->Find("labFollow"));
  if(!labFollow) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmFollow->GetName(), "labFollow");

  // 宠物界面
  frmMainPet = _FindForm("frmMainPet");
  if(!frmMainPet) return false;

  frmMainPet->Hide();

  labPetLv = dynamic_cast<CLabel*>(frmMainPet->Find("labPetLv"));
  if(!labPetLv) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMainPet->GetName(), "labPetLv");

  imgPetHead = dynamic_cast<CImage*>(frmMainPet->Find("imgPetHead"));
  if(!imgPetHead) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMainPet->GetName(), "imgPetHead");

  proPetHP = dynamic_cast<CProgressBar*>(frmMainPet->Find("proPetHP"));
  if(!proPetHP) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMainPet->GetName(), "proPetHP");

  proPetSP = dynamic_cast<CProgressBar*>(frmMainPet->Find("proPetSP"));
  if(!proPetSP) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmMainPet->GetName(), "proPetSP");

  //
  // 新手帮助界面
  //
  frmHelpSystem = CFormMgr::s_Mgr.Find("frmHelpSystem");
  if(!frmHelpSystem) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmHelpSystem", "frmHelpSystem");

  lstHelpList = dynamic_cast<CList*>(frmHelpSystem->Find("lstHelpList"));
  if(!lstHelpList) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmHelpSystem->GetName(), "lstHelpList");
  lstHelpList->evtSelectChange = _evtHelpListChange;

  CTextButton* btn = (CTextButton*)frmHelpSystem->Find("btnShip1"); //	Modify by alfred.shi 20080822 按钮名称+1
  if(!btn) return false;
  //btn->evtMouseClick = _evtShowBoatAttr;
  frmHelpSystem->evtEntrustMouseEvent = _evtStartFormMouseEvent;

  char szName[64] = {0};
  for(int i = 0; i < HELP_PICTURE_COUNT; ++i)
  {
	_snprintf_s(szName, _countof(szName), _TRUNCATE, "imgHelpShow%d_1", i + 1);
	imgHelpShow1[i] = dynamic_cast<CImage*>(frmHelpSystem->Find(szName));
	if(!imgHelpShow1[i]) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmHelpSystem->GetName(), szName);

	_snprintf_s(szName, _countof(szName), _TRUNCATE, "imgHelpShow%d_2", i + 1);
	imgHelpShow2[i] = dynamic_cast<CImage*>(frmHelpSystem->Find(szName));
	if(!imgHelpShow2[i]) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmHelpSystem->GetName(), szName);

	_snprintf_s(szName, _countof(szName), _TRUNCATE, "imgHelpShow%d_3", i + 1);
	imgHelpShow3[i] = dynamic_cast<CImage*>(frmHelpSystem->Find(szName));
	if(!imgHelpShow3[i]) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmHelpSystem->GetName(), szName);

	_snprintf_s(szName, _countof(szName), _TRUNCATE, "imgHelpShow%d_4", i + 1);
	imgHelpShow4[i] = dynamic_cast<CImage*>(frmHelpSystem->Find(szName));
	if(!imgHelpShow4[i]) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmHelpSystem->GetName(), szName);

	if(i > 0)
	{
	  imgHelpShow1[i]->SetIsShow(false);
	  imgHelpShow2[i]->SetIsShow(false);
	  imgHelpShow3[i]->SetIsShow(false);
	  imgHelpShow4[i]->SetIsShow(false);
	} else
	{
	  imgHelpShow1[i]->SetIsShow(true);
	  imgHelpShow2[i]->SetIsShow(true);
	  imgHelpShow3[i]->SetIsShow(true);
	  imgHelpShow4[i]->SetIsShow(true);
	}
  }

  //
  // 背包按钮界面
  //
  frmBag = CFormMgr::s_Mgr.Find("frmBag");
  if(!frmBag) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmBag", "frmBag");
  frmBag->evtEntrustMouseEvent = _evtStartFormMouseEvent;

  //
  // 社交按钮面板
  //
  frmSociliaty = CFormMgr::s_Mgr.Find("frmSociliaty");
  if(!frmSociliaty) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmSociliaty", "frmSociliaty");
  frmSociliaty->evtEntrustMouseEvent = _evtStartFormMouseEvent;

  //
  //女神面板 add by alfred.shi 20080723
  //

  frmQueen = CFormMgr::s_Mgr.Find("frmQueen");
  if(!frmQueen) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmQueen", "frmQueen");
  //frmQueen = dynamic_cast<CForm*>(frmQueen->Find("frmQueen"));

  //
  // NPC指引面板 add by alfred.shi 20080710 begin
  //
  strMapName = "";

  frmNpcShow = CFormMgr::s_Mgr.Find("frmNpcShow");
  if(!frmNpcShow) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), "frmNpcShow", "frmNpcShow");

  lstNpcList = dynamic_cast<CList*>(frmNpcShow->Find("lstNpcList"));
  assert(lstNpcList != NULL);
  lstMonsterList = dynamic_cast<CList*>(frmNpcShow->Find("lstMonsterList"));
  assert(lstMonsterList != NULL);

  chkID = (CCheckBox*)frmNpcShow->Find("chkID");
  chkID->SetIsChecked(true);
  //lstBOSSList = dynamic_cast<CList*>(frmNpcShow->Find("lstBOSSList"));
  //assert(lstBOSSList != NULL);

  lstNpcList->evtSelectChange	  = _evtNPCListChange;
  lstMonsterList->evtSelectChange = _evtNPCListChange;
  //lstBOSSList->evtSelectChange =  _evtNPCListChange;

  lstCurrList = lstNpcList;

  listPage = dynamic_cast<CPage*>(frmNpcShow->Find("pgeSkill"));
  assert(listPage != NULL);
  listPage->evtSelectPage = _evtPageIndexChange;
  return true;
}
void CStartMgr::ShowNPCHelper(const char* mapName, bool isShow)
{
  //if(strMapName == mapName)
  //{
  //	frmNpcShow->SetIsShow(isShow);
  //	return;
  //}

  string strCurMap = g_pGameApp->GetCurScene()->GetTerrainName();

  if(strCurMap == "garner")
	strCurMap = RES_STRING(CL_LANGUAGE_MATCH_56);
  else if(strCurMap == "magicsea")
	strCurMap = RES_STRING(CL_LANGUAGE_MATCH_57);
  else if(strCurMap == "darkblue")
	strCurMap = RES_STRING(CL_LANGUAGE_MATCH_58);
  else if(strCurMap == "winterland")
	strCurMap = RES_STRING(CL_UIMISLOGFORM_CPP_00001);
  else if(strCurMap == "jialebi")
	strCurMap = RES_STRING(CL_UIMISLOGFORM_CPP_00002);

  strMapName = strCurMap.c_str();
  //if(isShow)
  {
	CListItems* items = lstCurrList->GetItems();
	items->Clear();
	lstCurrList->Refresh();

	int nTotalIndex = NPCHelper::I()->GetLastID() + 1;
	for(int i = 0; i < nTotalIndex; ++i)
	{
	  NPCData* p = GetNPCDataInfo(i);
	  if(p && strcmp(p->szMapName, strMapName /*mapName*/) == 0)
	  {
		char		buff[1024];
		std::string strName(p->szName);
		while(strName.length() < 18)
		{
		  strName += " ";
		}
		std::string strAreaName = std::string("<") + std::string(p->szArea) + std::string(">");
		while(strAreaName.length() < 16)
		{
		  strAreaName += " ";
		}
		_snprintf_s(buff, _countof(buff), _TRUNCATE, "%s%s<%d,%d>", strName.c_str(), strAreaName.c_str(), p->dwxPos0, p->dwyPos0);
		lstCurrList->Add(buff);
		lstCurrList->Refresh();
	  }
	}
  }

  frmNpcShow->SetIsShow(isShow);
}
//end

//add by alfred.shi 20080723 begin
void CStartMgr::ShowQueenButtonForm(bool bShow)
{
  g_stUIStart.frmQueen->SetIsShow(true);
  /*if(frmQueen)
	{*/
  /*frmQueen->SetPos(frmMainFun->GetX2() - frmQueen->GetWidth(), frmMainFun->GetY() - frmQueen->GetHeight());
		frmQueen->Refresh();*/

  //frmQueen->SetIsShow(bShow);
  /*}*/
}
//end
void CStartMgr::ShowShipSailForm(bool isShow /* = true  */)
{
  UpdateShipSailForm();
  frmShipSail->SetIsShow(isShow);
}
void CStartMgr::UpdateShipSailForm()
{
  CCharacter* pMain = CGameScene::GetMainCha();
  if(!pMain || !pMain->IsBoat())
	return;

  SGameAttr* pAttr = pMain->getGameAttr();

  char buf[128];

  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%d/%d", (int)pAttr->get(ATTR_HP), (int)pAttr->get(ATTR_MXHP));
  labSailorShow->SetCaption(buf);
  proSailor->SetRange((float)0, (float)(pAttr->get(ATTR_MXHP)));
  proSailor->SetPosition((float)(pAttr->get(ATTR_HP)));

  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%d/%d", (int)pAttr->get(ATTR_SP), (int)pAttr->get(ATTR_MXSP));
  labCanonShow->SetCaption(buf);
  proCanon->SetRange((float)0, (float)(pAttr->get(ATTR_MXSP)));
  proCanon->SetPosition((float)(pAttr->get(ATTR_SP)));

  //	labLevelShow->SetCaption(itoa(pAttr->get(ATTR_LV), buf, 10));
  _itoa_s((int)pAttr->get(ATTR_LV), buf, sizeof(buf), 10);
  labLevelShow->SetCaption(buf);
  //labExpShow->SetCaption(_i64toa(pAttr->get(ATTR_CEXP), buf, 10));
  _i64toa_s(pAttr->get(ATTR_CEXP), buf, sizeof(buf), 10);
  labExpShow->SetCaption(buf);
}

void CStartMgr::End()
{
  //delete pMainCha;
  //pMainCha = NULL;
  SAFE_DELETE(pMainCha); // UI当机处理
}

void CStartMgr::ShowQueryReliveForm(int nType, const char* str)
{
  stSelectBox* pOriginRelive  = g_stUIBox.ShowSelectBox(_evtOriginReliveFormMouseEvent, str, false);
  frmSelectOriginRelive		  = pOriginRelive->frmDialog;
  frmSelectOriginRelive->nTag = nType;
}

//end

//add by alfred.shi 20080710 begin
void CStartMgr::_evtPageIndexChange(CGuiData* pSender)
{
  NPCHelper* pNPCHelper = NPCHelper::I();
  SAFE_DELETE(pNPCHelper);
  pNPCHelper = new NPCHelper(0, 1000);

  int index = g_stUIStart.listPage->GetIndex();
  if(index == 0) //npc
  {
	pNPCHelper->LoadRawDataInfo("scripts/table/NPCList", FALSE);
	g_stUIStart.lstCurrList = g_stUIStart.lstNpcList;
  } else if(index == 1)
  {
	pNPCHelper->LoadRawDataInfo("scripts/table/MonsterList", FALSE);
	g_stUIStart.lstCurrList = g_stUIStart.lstMonsterList;
  }
  /*else if(index == 2)
	{
		pNPCHelper->LoadRawDataInfo("scripts/table/BossList", FALSE);
		g_stUIStart.lstCurrList = g_stUIStart.lstBOSSList;
	}*/
  g_stUIStart.ShowNPCHelper(g_stUIStart.GetCurrMapName(), true);
}
void CStartMgr::_evtNPCListChange(CGuiData* pSender)
{
  CListItems* pItems = g_stUIStart.lstCurrList->GetItems();
  int		  nIndex = pItems->GetIndex(g_stUIStart.lstCurrList->GetSelectItem());

  CItemRow* itemrow = g_stUIStart.lstCurrList->GetSelectItem();
  CItemObj* itemobj = itemrow->GetBegin();

  std::string itemstring(itemobj->GetString());

  int pos  = (int)itemstring.find(">") + 1;
  int pos1 = (int)itemstring.find("<", pos);
  int pos2 = (int)itemstring.find(",", pos);
  int pos3 = (int)itemstring.find(">", pos);

  if(pos1 >= 0 && pos2 > pos1 && pos3 > pos2 && pos3 <= (int)itemstring.length())
  {
	string xStr = itemstring.substr(pos1 + 1, pos2 - pos1 - 1);
	string yStr = itemstring.substr(pos2 + 1, pos3 - pos2 - 1);

	g_stUIMap.ShowRadar(xStr.c_str(), yStr.c_str());
  }
  g_stUIStart.ShowNPCHelper(g_stUIStart.GetCurrMapName(), false);
}

//end

void CStartMgr::_evtOriginReliveFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  frmSelectOriginRelive = NULL;
  if(pSender->GetForm()->nTag == enumEPLAYER_RELIVE_ORIGIN)
  {
	if(nMsgType == CForm::mrYes)
	{
	  CS_DieReturn(enumEPLAYER_RELIVE_ORIGIN);
	  g_stUIStart.frmMainChaRelive->SetIsShow(false);
	} else
	{
	  CS_DieReturn(enumEPLAYER_RELIVE_NORIGIN);
	}
  } else
  {
	if(nMsgType == CForm::mrYes)
	{
	  CS_DieReturn(enumEPLAYER_RELIVE_MAP);
	  g_stUIStart.frmMainChaRelive->SetIsShow(false);
	} else
	{
	  CS_DieReturn(enumEPLAYER_RELIVE_NOMAP);
	}
  }
}

void CStartMgr::_evtReliveFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  //if( name=="btnReCity" )
  {
	CS_DieReturn(enumEPLAYER_RELIVE_CITY);
	pSender->GetForm()->SetIsShow(false);
	if(frmSelectOriginRelive)
	{
	  frmSelectOriginRelive->SetIsShow(false);
	  frmSelectOriginRelive = NULL;
	}
  }
}

void CStartMgr::_evtStartFormMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();

  if(name == "btnState") // 显示属性界面e
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmState");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
	return;
  }
  //else if( name=="btnItem" )	// 显示道具界面
  //{
  //	CForm* f = CFormMgr::s_Mgr.Find( "frmItem" );
  //	if( f )
  //	{
  //		f->SetIsShow( !f->GetIsShow() );
  //	}
  //	return;
  //}
  else if(name == "btnSkill") // 显示技能界面
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmSkill");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
	return;
  } else if(name == "btnMission") // 显示任务界面
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmMission");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
	return;
  }
  //else if( name=="btnGuild" )	    // 显示工会界面
  //{
  //	CForm* f = CFormMgr::s_Mgr.Find( "frmManage" );
  //	if( f )
  //	{
  //		f->SetIsShow( !f->GetIsShow() );
  //	}
  //	return;
  //}
  else if(name == "btnHelp")
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmStartHelp");
	if(f)
	{
	  f->evtEntrustMouseEvent = _HelpFrmMainMouseEvent;
	  f->SetIsShow(!f->GetIsShow());
	}
	return;
  }
  //else if( name=="btnShip" )	// 显示帮助界面	Modify by alfred.shi 20080822
  //{
  //       CForm* f = CFormMgr::s_Mgr.Find("frmStartHelp");
  //	if( f )
  //	{
  //		f->evtEntrustMouseEvent = _HelpFrmMainMouseEvent;
  //		f->SetIsShow( !f->GetIsShow() );
  //	}

  //       return;
  //}

  // 显示帮助界面		Add by alfred.shi 20080822	beign
  else if(name == "btnShip1")
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmStartHelp");
	if(f)
	{
	  f->evtEntrustMouseEvent = _HelpFrmMainMouseEvent;
	  f->SetIsShow(!f->GetIsShow());
	}

	return;
  }
  //	End

  //if( name=="btnOpenHelp" )
  //{
  //	CForm * frm = CFormMgr::s_Mgr.Find("frmVHelp");
  //	if( frm )
  //	{
  //		frm->evtEntrustMouseEvent = _NewFrmMainMouseEvent;
  //		frm->nTag = 0;
  //		frm->ShowModal();
  //	}
  //	return;
  //}

  //	Add by alfred.shi 20080822	begin
  if(name == "btnShip2")
  {
	CForm* frm = CFormMgr::s_Mgr.Find("frmVHelp");
	if(frm)
	{
	  frm->evtEntrustMouseEvent = _NewFrmMainMouseEvent;
	  frm->nTag					= 0;
	  frm->ShowModal();
	}
	return;
  }
  //	End

  else if(name == "btnSystem") // 显示功能界面
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmSystem");
	if(f) f->SetIsShow(!f->GetIsShow());
	return;
  }
  /*else if( name=="btnQQ" )	
	{
		CForm* f = CFormMgr::s_Mgr.Find( "frmQQ" );
		if( f ) 
		{
			f->SetIsShow( !f->GetIsShow() );
		}
		return;
	}*/
  else if(name == "btnLevelUpHelp") // 玩家角色升级帮助
  {
	SGameAttr* pAttr = CGameScene::GetMainCha()->getGameAttr();

	//	int nLevel = pAttr->get(ATTR_LV);
	LONG64 nLevel = pAttr->get(ATTR_LV);
	//g_stUIStart.ShowHelpSystem(true, nLevel + HELP_LV1_BEGIN - 1);
	g_stUIStart.ShowHelpSystem(true, (int)nLevel + (int)HELP_LV1_BEGIN - 1);

	g_stUIStart.ShowLevelUpHelpButton(false);
  }

  //	Add by alfred.shi 20080905	begin
  else if(name == "btnLevelUpadd")
  {
	SGameAttr* pAttr = CGameScene::GetMainCha()->getGameAttr();
	//	int nLevel = pAttr->get(ATTR_LV);
	LONG64 nLevel = pAttr->get(ATTR_LV);
	if(nLevel < 10) //	低于10级只显示属性界面
	{
	  CForm* f = CFormMgr::s_Mgr.Find("frmState");
	  if(f)
	  {
		f->SetIsShow(!f->GetIsShow());
	  }
	} else //	显示属性和技能界面
	{
	  CForm* f1 = CFormMgr::s_Mgr.Find("frmState");
	  if(f1)
	  {
		f1->SetIsShow(!f1->GetIsShow());
	  }
	  CForm* f2 = CFormMgr::s_Mgr.Find("frmSkill");
	  if(f2)
	  {
		f2->SetIsShow(!f2->GetIsShow());
	  }
	}
	g_stUIStart.ShowLevelUpaddButton(false);
  }
  //	挂机
  else if(name == "btnafk")
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmElfAfk");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
	/*numExpItem= 0;
		itemNumInBag = 0;
		nPosition = -1,*/
	cboexp->GetList()->GetItems()->Select(0);
	g_stUIStart.ShowAfkButton(false);
  }

  else if(name == "btnInfoCenter") // 介绍新手的一些玩法的界面
  {
	bool bShow = g_stUIStart.frmHelpSystem->GetIsShow();
	g_stUIStart.ShowHelpSystem(!bShow);
  } else if(name == "btnOpenBag") // 打开背包按钮界面
  {
	g_stUIStart.ShowBagButtonForm(!g_stUIStart.frmBag->GetIsShow());
	g_stUIStart.ShowSociliatyButtonForm(false);

	//g_stUIStart.frmBag->SetIsShow(! g_stUIStart.frmBag->GetIsShow());
	//g_stUIStart.frmSociliaty->SetIsShow(false);
  } else if(name == "btnOpenSociliaty") // 打开社交按钮界面
  {
	g_stUIStart.ShowSociliatyButtonForm(!g_stUIStart.frmSociliaty->GetIsShow());
	g_stUIStart.ShowBagButtonForm(false);

	//g_stUIStart.frmSociliaty->SetIsShow(! g_stUIStart.frmSociliaty->GetIsShow());
	//g_stUIStart.frmBag->SetIsShow(false);
  }
  //else if( name == "btnOpenItem")	// 显示道具界面
  //{
  //	CForm* f = CFormMgr::s_Mgr.Find( "frmItem" );
  //	if( f )
  //	{
  //		f->SetIsShow( !f->GetIsShow() );
  //	}
  //	return;
  //}
  else if(name == "btnOpenTempBag") // 打开临时背包
  {
	g_stUIStore.ShowTempKitbag();
  } else if(name == "btnOpenStore") // 打开商城
  {
	// 商城未开启,打开网页
	//g_stUIStore.ShowStoreWebPage();

	// 打开商城输入二次密码（暂时不上内置商城）
	g_stUIDoublePwd.SetType(CDoublePwdMgr::STORE_OPEN_ASK);
	g_stUIDoublePwd.ShowDoublePwdForm();
  } else if(name == "btnOpenGuild") // 显示公会
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmManage");
	if(f)
	{
	  bool a = f->GetIsShow();
	  f->SetIsShow(!a);
	  //	Add by alfred.shi 20080905	begin
	  CCharacter* pMainCha = CGameScene::GetMainCha();
	  if(pMainCha->getGuildID() <= 0)
	  {
		g_pGameApp->MsgBox(RES_STRING(CL_UISTARTFORM_CPP_00002));
	  }
	  //	End.
	}
	return;
  } else if(name == "btnOpenTeam") // 志愿者
  {
	CCharacter* pMainCha = CGameScene::GetMainCha();

	if(pMainCha)
	{
	  // 角色 8 级以下禁止组队	Modify by alfred.shi 20080902	begin
	  if(g_stUIFindTeam.IsShowFom())
		g_stUIFindTeam.ShowFindTeamForm(false);
	  else if(pMainCha && !pMainCha->IsBoat() && pMainCha->getGameAttr()->get(ATTR_LV) >= 8)
	  {
		CS_VolunteerOpen((short)CFindTeamMgr::FINDTEAM_PAGE_SIZE);
	  } //	End
	  else
	  {
		if(pMainCha->IsBoat())
		{
		  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_888));
		} else
		{
		  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_866));
		  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_866)); //	Add by alfred.shi 20080905
		}
	  }
	}
  }

  return;
}

void CStartMgr::_evtSelfMouseDown(CGuiData* pSender, int x, int y, DWORD key)
{
  CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
  if(!pScene) return;

  CCharacter* pMain = CGameScene::GetMainCha();
  if(!pMain) return;

  if(key & Mouse_LDown)
  {
	CSkillRecord* pSkill = pMain->GetReadySkillInfo();
	if(pSkill && g_SkillUse.IsUse(pSkill, pMain, pMain))
	{
	  pScene->GetMouseDown().ActAttackCha(pMain, pSkill, pMain);
	}
  } else if((key & Mouse_RDown) && (pMain->GetTeamLeaderID() != 0))
  {
	pSender->GetForm()->PopMenu(g_stUIStart.mnuSelf, x, y);
  }
}

void CStartMgr::MainChaDied()
{
  if(frmMainChaRelive)
  {
	int nLeft = (g_pGameApp->GetWindowHeight() - frmMainChaRelive->GetWidth()) / 2;
	int nTop  = (g_pGameApp->GetWindowHeight() - frmMainChaRelive->GetHeight()) / 2;
	nTop -= 80;
	frmMainChaRelive->SetPos(nLeft, nTop);
	frmMainChaRelive->Refresh();

	static CLabel* pInfo  = dynamic_cast<CLabel*>(frmMainChaRelive->Find("labReCity"));
	CCharacter*	   pCha	  = CGameScene::GetMainCha();
	bool		   IsShow = true;
	if(pInfo && pCha)
	{
	  if(pCha->IsBoat())
	  {
		pInfo->SetCaption(RES_STRING(CL_LANGUAGE_MATCH_761));
	  } else
	  {
		pInfo->SetCaption(RES_STRING(CL_LANGUAGE_MATCH_762));

		if(CGameScene* pScene = CGameApp::GetCurScene())
		{
		  if(CMapInfo* pInfo = pScene->GetCurMapInfo())
		  {
			if(pInfo)
			{
			  // Modify by lark.li 20080719 begin
			  //if( stricmp( pInfo->szDataName, "teampk" )==0 )
			  /*if( stricmp( pInfo->szDataName, "teampk" )==0 || stricmp( pInfo->szDataName,"starena1") == 0 
								|| stricmp( pInfo->szDataName,"starena2") == 0 || stricmp( pInfo->szDataName,"starena3") == 0)*/
			  if(_stricmp(pInfo->szDataName, "teampk") == 0 || _stricmp(pInfo->szDataName, "starena1") == 0 || _stricmp(pInfo->szDataName, "starena2") == 0 || _stricmp(pInfo->szDataName, "starena3") == 0 || _stricmp(pInfo->szDataName, "starena13") == 0 || _stricmp(pInfo->szDataName, "starena14") == 0 || _stricmp(pInfo->szDataName, "starena15") == 0 || _stricmp(pInfo->szDataName, "starena23") == 0 || _stricmp(pInfo->szDataName, "starena24") == 0 || _stricmp(pInfo->szDataName, "starena25") == 0 || _stricmp(pInfo->szDataName, "starena33") == 0 || _stricmp(pInfo->szDataName, "starena34") == 0 || _stricmp(pInfo->szDataName, "starena35") == 0)
				IsShow = false;
			  // End
			}
		  }
		}
	  }
	}

	// add by Philip.Wu  角色死亡后执行一次移动，用于关闭窗体
	CUIInterface::MainChaMove();

	// add by Philip.Wu  2006-07-05  角色死亡后关闭交易界面
	// BUG规避：TEST-32  由交易后触发的替死娃娃功能bug
	g_stUITrade.CloseAllForm();

	//Add by sunny.sun 20090211 角色死亡后关闭商城交易界面及其物品购买界面
	g_stUIStore.ShowStoreForm(false);
	g_stUIBox.CloseAllBox();

	// add by Philip.Wu  2006-07-12  角色死亡后关闭出海界面
	CWorldScene* pWorldScene = dynamic_cast<CWorldScene*>(g_pGameApp->GetCurScene());
	if(pWorldScene && pWorldScene->GetShipMgr())
	{
	  pWorldScene->GetShipMgr()->CloseForm();
	}

	if(IsShow) frmMainChaRelive->Show();
  }
}

void CStartMgr::CheckMouseDown(int x, int y)
{
  //if( frmMainFun->GetIsShow() )
  //{
  //	if( !frmMainFun->InRect(x,y) )
  //	{
  //		//frmMainFun->SetIsShow(false);
  //	}
  //}

  //if ( grdAction->GetIsShow() )
  //{
  //	if ( !grdAction->InRect(x,y) )
  //		grdAction->SetIsShow(false);
  //}

  //if ( grdHeart->GetIsShow() )
  //{
  //	if ( !grdHeart->InRect(x,y) )
  //		grdHeart->SetIsShow(false);
  //}

  //if ( g_stUICoze.GetFaceGrid()->GetIsShow() )
  //{
  //	if ( !g_stUICoze.GetFaceGrid()->InRect(x,y) )
  //		g_stUICoze.GetFaceGrid()->SetIsShow(false);
  //}
}

void CStartMgr::_evtTaskMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();

  if(name == "btnStart")
  {
	CForm* f = CFormMgr::s_Mgr.Find("frmMainFun");
	if(f)
	{
	  f->SetIsShow(!f->GetIsShow());
	}
	return;
  }
  //else if( name=="btnAction" )
  //{
  //	g_stUIStart.grdHeart->SetIsShow( false );
  //	g_stUICoze.GetFaceGrid()->SetIsShow( false );
  //	g_stUIStart.grdAction->SetIsShow(!g_stUIStart.grdAction->GetIsShow() );
  //	return;
  //}
  //else if( name=="btnBrow" )
  //{
  //	g_stUIStart.grdAction->SetIsShow( false );
  //	g_stUICoze.GetFaceGrid()->SetIsShow( false );
  //	g_stUIStart.grdHeart->SetIsShow( !g_stUIStart.grdHeart->GetIsShow() );
  //	return;
  //}
  //else if( name=="btnChatFace" )
  //{
  //	g_stUIStart.grdAction->SetIsShow( false );
  //	g_stUIStart.grdHeart->SetIsShow( false );
  //	g_stUICoze.GetFaceGrid()->SetIsShow( !g_stUICoze.GetFaceGrid()->GetIsShow() );
  //	return;
  //}

  // 快捷键的点击
  if(pSender->nTag > 10)
  {
	CCharacter* c = CGameScene::GetMainCha();
	if(!c) return;

	c->ChangeReadySkill(pSender->nTag);
  }
  return;
}

void CStartMgr::_evtChaActionChange(CGuiData* pSender)
{
  CCharacter* pCha = g_pGameApp->GetCurScene()->GetMainCha();
  if(!pCha) return;

  pSender->SetIsShow(false);

  CGrid* p = dynamic_cast<CGrid*>(pSender);
  if(!p) return;
  CGraph* r		 = p->GetSelect();
  int	  nIndex = p->GetSelectIndex();
  if(r)
  {
	pCha->GetActor()->PlayPose(r->nTag, true, true);
  }
}

void CStartMgr::_evtChaHeartChange(CGuiData* pSender)
{
  CCharacter* pCha = CGameScene::GetMainCha();
  if(!pCha) return;
  pSender->SetIsShow(false);

  CGrid* p = dynamic_cast<CGrid*>(pSender);
  if(!p) return;
  CGraph* r		 = p->GetSelect();
  int	  nIndex = p->GetSelectIndex();
  if(r)
  {
	pCha->GetHeadSay()->SetFaceID(nIndex);
	char szFaceID[10] = {0};
	_snprintf_s(szFaceID, _countof(szFaceID), _TRUNCATE, "***%d", nIndex);
	CS_Say(szFaceID);
  }
}

void CStartMgr::RefreshMainLifeNum(long num, long max)
{
  ////HP的变化
  //char szHP[32] = { 0 };
  //if ( num < 0 )	num = 0;
  //sprintf_s( szHP,"%d/%d", num, max);
  //szHP[sizeof(szHP)-1] = '\0';

  //float f = (float) num /(float) max;
  //CProgressBar* pBar = NULL;
  //if( f < 0.334 )
  //{
  //	pBar = proMainHP3;
  //	proMainHP2->SetIsShow(false);
  //	proMainHP1->SetIsShow(false);
  //}
  //else if( f > 0.666 )
  //{
  //	pBar = proMainHP1;
  //	proMainHP2->SetIsShow(false);
  //	proMainHP3->SetIsShow(false);
  //}
  //else
  //{
  //	pBar = proMainHP2;
  //	proMainHP1->SetIsShow(false);
  //	proMainHP3->SetIsShow(false);
  //}

  //pBar->SetIsShow(true);
  //pBar->SetPosition( 10.0f * f ) ;

  if(proMainHP)
  {
	proMainHP->SetRange(0.0f, (float)max);
	proMainHP->SetPosition((float)num);
  }
}

void CStartMgr::RefreshMainExperience(LONG64 num, LONG64 curlev, LONG64 nextlev)
{
  //	LG("exp", RES_STRING(CL_LANGUAGE_MATCH_763), num, curlev, nextlev, 100.0f * (float)(num - curlev) / (float)(nextlev - curlev));

  //// EXP的变化
  //long max = nextlev - curlev;
  //num = num - curlev;
  //if ( num < 0 ) num = 0;

  //if (max!=0)
  //	_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE  , "%4.2f%%" , num*100.0f/max );
  //else
  //	_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE  , "0.00%");
  //szBuf[sizeof(szBuf)-1] = '\0';

  //_pShowExp->SetCaption( szBuf );
  if(proMainExp)
  {
	proMainExp->SetRange(0, 1);
	proMainExp->SetPosition((float)(num - curlev) / (float)(nextlev - curlev));
  }
}

void CStartMgr::RefreshMainName(const char* szName)
{
#ifdef _KOSDEMO_
  if(labMainName)
  {
	labMainName->SetCaption("");
  }
#else
  if(labMainName)
  {
	labMainName->SetCaption(szName);
  }
#endif
}

void CStartMgr::RefreshLv(long l)
{
#ifdef _KOSDEMO_
  if(labMainLevel)
  {
	labMainLevel->SetCaption("");
  }
#else
  if(labMainLevel)
  {
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", l);
	labMainLevel->SetCaption(szBuf);
  }
#endif
}

void CStartMgr::RefreshMainSP(long num, long max)
{
  //SP的变化
  if(proMainSP)
  {
	proMainSP->SetRange(0.0f, (float)max);
	proMainSP->SetPosition((float)num);
  }
}

// 右键菜单消息处理
void CStartMgr::_evtPopMenu(CGuiData* pSender, int x, int y, DWORD key)
{
  mainMouseRight->SetIsShow(false);
  CMenuItem* pItem = mainMouseRight->GetSelectMenu();
  if(!pItem) return;
  string str = pItem->GetString();
  if(str == RES_STRING(CL_LANGUAGE_MATCH_764)) // 邀请交易
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(pCha && pMain && pCha != pMain && pCha->IsEnabled() && pMain->IsEnabled() && ((!pCha->IsBoat() && !pMain->IsBoat()) || (pCha->IsBoat() && pMain->IsBoat())))
	{
	  if(pMain->IsBoat() || pMain->getGameAttr()->get(ATTR_LV) >= 6)
	  {
		CS_RequestTrade(mission::TRADE_CHAR, mainMouseRight->nTag);
	  } else
	  {
		// 角色等级6级以下禁止发起邀请交易
		g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_864));
	  }
	} else
	{
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_765)); // 交易时必须双方都是玩家，或都是船
	}
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_482)) // 添加好友
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(!pCha || !pMain) return;

	if(pMain->IsBoat() || pMain->getGameAttr()->get(ATTR_LV) >= 7)
	{
	  CS_Frnd_Invite(pCha->getHumanName());
	} else
	{
	  // 角色等级7级以下禁止发起添加好友
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_865));
	}
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_484)) // 邀请组队
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(!pCha || !pMain) return;

	if((pMain->IsBoat() || pMain->getGameAttr()->get(ATTR_LV) >= 8) &&
	   (pCha->IsBoat() || pCha->getGameAttr()->get(ATTR_LV) >= 8))
	{
	  CS_Team_Invite(pCha->getHumanName());
	} else
	{
	  // 角色等级8级以下禁止发起组队邀请
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_866));
	}

	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_483)) // 离开队伍
  {
	CS_Team_Leave();
	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_481)) // 密语对方
  {
	CCharacter* pCha = (CCharacter*)mainMouseRight->GetPointer();
	if(pCha)
	{
	  CCozeForm::GetInstance()->OnPrivateNameSet(pCha->getHumanName());
	}
	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_766)) // 船舱交易
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(pCha && pMain && pCha->IsBoat() && pMain->IsBoat())
	{
	  CS_RequestTrade(mission::TRADE_BOAT, mainMouseRight->nTag);
	} else
	{
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_767));
	}
	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_768)) // 查看摊位
  {
	CCharacter* pCha = (CCharacter*)mainMouseRight->GetPointer();
	if(pCha && !pCha->IsMainCha())
	{
	  CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
	  if(pScene)
	  {
		pScene->GetMouseDown().ActShop(CGameScene::GetMainCha(), pCha);
	  }
	}
	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_769)) // 队伍单挑
  {
	CCharacter* pCha = (CCharacter*)mainMouseRight->GetPointer();
	if(pCha) CS_TeamFightAsk(pCha->getAttachID(), pCha->lTag, enumFIGHT_TEAM);
	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_770)) // 玩家单挑
  {
	CCharacter* pCha = (CCharacter*)mainMouseRight->GetPointer();
	if(pCha) CS_TeamFightAsk(pCha->getAttachID(), pCha->lTag, enumFIGHT_MONOMER);
	return;
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_855)) // 申请拜师
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(pCha && pMain && !pCha->IsBoat() && !pMain->IsBoat())
	{
	  const char* szName = pCha->getHumanName();
	  CS_MasterInvite(pCha->getHumanName(), mainMouseRight->nTag);
	} else
	{
	  // 拜师或收徒时必须双方都是玩家
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_888));
	}
  } else if(str == RES_STRING(CL_LANGUAGE_MATCH_859)) // 申请收徒
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(pCha && pMain && !pCha->IsBoat() && !pMain->IsBoat())
	{
	  const char* szName = pCha->getHumanName();
	  CS_PrenticeInvite(pCha->getHumanName(), mainMouseRight->nTag);
	} else
	{
	  // 拜师或收徒时必须双方都是玩家
	  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_888));
	}
  }
  // Add by lark.li 20080811
  else if(str == RES_STRING(CL_UISTARTFORM_CPP_00001)) // 详细信息
  {
	CCharacter* pCha  = (CCharacter*)mainMouseRight->GetPointer();
	CCharacter* pMain = CGameScene::GetMainCha();
	if(pCha && pMain && !pCha->IsBoat() && !pMain->IsBoat())
	{
	  CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(pCha->getID());
	  if(!pMember) pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamGroup)->Find(pCha->getID());
	  if(!pMember) pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamGuild)->Find(pCha->getID());
	  if(!pMember) pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Find(pCha->getID());
	  if(!pMember) pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Find(pCha->getID());
	  CP_Frnd_Refresh_Info(pMember->GetID());
	}
  }
  // End

  g_stUIStart.frmMain800->Refresh();
}

void CStartMgr::AskTeamFight(const char* str)
{
  g_stUIBox.ShowSelectBox(_evtAskTeamFightMouseEvent, str, false);
}

void CStartMgr::_evtAskTeamFightMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  CS_TeamFightAnswer(nMsgType == CForm::mrYes);
}

// 弹出右键菜单
void CStartMgr::PopMenu(CCharacter* pCha)
{
  //g_pGameApp->GetCurScene()->GetTerrainName();

  if(!g_stUIStart.IsCanTeam())
	return;

  if(g_stUIBank.GetBankGoodsGrid()->GetForm()->GetIsShow()) // 西门文档修改，开着银行不允许打开右键菜单
	return;

  if(g_stUIBooth.GetBoothItemsGrid()->GetForm()->GetIsShow()) // 西门文档修改，摆摊不允许打开右键菜单
	return;

  if(g_stUITrade.IsTrading()) // 西门文档修改，交易时不允许打开右键菜单
	return;

  if(mainMouseRight && pCha && pCha->IsValid() && !pCha->IsHide() && pCha->IsPlayer())
  {
	mainMouseRight->nTag = pCha->getAttachID();
	mainMouseRight->SetPointer(pCha);

	CCharacter* pMain = CGameScene::GetMainCha();
	if(!pMain) return;

	if(!pMain->IsValid() || pMain->IsHide()) return;

	if(pCha->GetIsPet()) return; // 宠物不允许点出右键菜单

	int nMainGuildID = pMain->getGuildID();
	int nChaGuildID	 = pCha->getGuildID();
	if(nMainGuildID > 0 && nChaGuildID > 0)
	{
	  if(g_stUIMap.IsGuildWar() && ((nMainGuildID <= 100 && nChaGuildID > 100) || (nMainGuildID > 100 && nChaGuildID <= 100))) return; // 不同阵营
	}

	mainMouseRight->SetAllEnabled(false);
	int			nCount	= mainMouseRight->GetCount();
	CMenuItem*	pItem	= NULL;
	const char* MapName = g_pGameApp->GetCurScene()->GetTerrainName(); // 取得人物当前所在地图 Add by ning.yan 20080715
	//Add by sunny.sun20080820
	//Begin
	//	if( stricmp( MapName,"starena1") == 0 || stricmp( MapName,"starena2") == 0 || stricmp( MapName,"starena3") == 0 )
	if(_stricmp(MapName, "starena1") == 0 || _stricmp(MapName, "starena2") == 0 || _stricmp(MapName, "starena3") == 0)
	  return;
	for(int i = 0; i < nCount; i++)
	{
	  pItem = mainMouseRight->GetMenuItem(i);
	  //	if( stricmp( pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_764) )==0 )
	  if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_764)) == 0)
	  {
		if(pMain != pCha && pMain->IsEnabled() && pCha->IsEnabled() && ((pMain->IsBoat() && pCha->IsBoat()) || (!pMain->IsBoat() && !pCha->IsBoat())))

		{
		  pItem->SetIsEnabled(true);
		} else
		{
		  pItem->SetIsEnabled(false);
		}
	  }
	  //	else if( stricmp( pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_482) )==0 )
	  else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_482)) == 0)
	  {
		pItem->SetIsEnabled(pMain != pCha);
	  }
	  //	else if( stricmp( pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_484) )==0 )
	  else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_484)) == 0)
	  { // 竞技场中取消组队功能 Add by ning.yan  20080715 Begin
		//if( stricmp( MapName,"starena1") == 0 || stricmp( MapName,"starena2") == 0 || stricmp( MapName,"starena3") == 0 )
		//	pItem->SetIsEnabled( false );
		//// End
		//else
		pItem->SetIsEnabled(g_stUIStart.IsCanTeam() && pMain != pCha && (pMain->GetTeamLeaderID() == 0 || (pMain->IsTeamLeader() && pCha->GetTeamLeaderID() != pMain->GetTeamLeaderID())));
	  }
	  //	else if( stricmp( pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_483) )==0 )
	  else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_483)) == 0)
	  { // 竞技场中取消离开队伍功能  Add by ning.yan  20080715 Begin
		//if( stricmp( MapName,"starena1") == 0 || stricmp( MapName,"starena2") == 0 || stricmp( MapName,"starena3") == 0 )
		//	pItem->SetIsEnabled( false );
		//// End
		//else
		pItem->SetIsEnabled(g_stUIStart.IsCanTeam() && pMain->GetTeamLeaderID() != 0 && pCha->GetTeamLeaderID() == pMain->GetTeamLeaderID());
	  }
	  //	else if( stricmp( pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_481) )==0 )
	  else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_481)) == 0)
	  {
		pItem->SetIsEnabled(pMain != pCha);
	  } else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_766)) == 0)
	  {
		pItem->SetIsEnabled(pMain != pCha && pMain->IsBoat() && pMain->IsEnabled() && pCha->IsBoat() && pCha->IsEnabled());
	  } else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_768)) == 0)
	  {
		pItem->SetIsEnabled(pMain != pCha && pMain->IsEnabled() && !pMain->IsShop() && pCha->IsEnabled() && pCha->IsShop());
	  } else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_769)) == 0)
	  {
		pItem->SetIsEnabled(g_stUIStart.IsCanTeam() && pMain != pCha && pMain->IsEnabled() && pMain->IsTeamLeader() && !pMain->IsShop() && pCha->IsEnabled() && pCha->IsTeamLeader() && !pCha->IsShop());
	  } else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_770)) == 0)
	  {
		pItem->SetIsEnabled(g_stUIStart.IsCanTeam() && pMain != pCha && pCha->IsPlayer());
	  } else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_855)) == 0) // 请求拜师
	  {
		pItem->SetIsEnabled(pMain != pCha && pCha->IsPlayer() && pMain->getGameAttr() && pMain->getGameAttr()->get(ATTR_LV) <= 40);
		//&& pCha->getGameAttr()  && pCha->getGameAttr()->get(ATTR_LV) > 40 );
	  } else if(_stricmp(pItem->GetString(), RES_STRING(CL_LANGUAGE_MATCH_859)) == 0) // 请求收徒
	  {
		pItem->SetIsEnabled(pMain != pCha && pCha->IsPlayer() && pMain->getGameAttr() && pMain->getGameAttr()->get(ATTR_LV) > 40);
		//&& pCha->getGameAttr()  && pCha->getGameAttr()->get(ATTR_LV) <= 40 );
	  }
	}

	if(mainMouseRight->IsAllDisabled())
	{
	  mainMouseRight->SetIsShow(false);
	  return;
	}

	int x = 0, y = 0;
	g_Render.WorldToScreen(pCha->GetPos().x, pCha->GetPos().y, pCha->GetPos().z, &x, &y);

	if(CForm::GetActive() && CForm::GetActive()->IsNormal())
	  CForm::GetActive()->PopMenu(mainMouseRight, x, y);
	else
	  frmMain800->PopMenu(mainMouseRight, x, y);
  }
}

void CStartMgr::CloseForm()
{
  //if( frmMainFun->GetIsShow() )
  //	frmMainFun->Close();

  //grdAction->SetIsShow(false);
  //grdHeart->SetIsShow(false);
  //g_stUICoze.GetFaceGrid()->SetIsShow( false );
}

CTextButton* CStartMgr::GetShowQQButton()
{
  return btnQQ;
}

void CStartMgr::ShowBigText(const char* str)
{
  int		  nType = 0;
  CCharacter* pMain = CGameScene::GetMainCha();
  if(pMain && CGameApp::GetCurScene() && CGameApp::GetCurScene()->GetTerrain())
  {
	int		   nArea = CGameApp::GetCurScene()->GetTerrain()->GetTile(pMain->GetCurX() / 100, pMain->GetCurY() / 100)->getIsland();
	CAreaInfo* pArea = GetAreaInfo(nArea);
	if(pArea)
	{
	  nType = pArea->chType;
	}
  }

  if(nType)
  {
	if(tlCity) tlCity->SetIsShow(false);

	if(tlField)
	{
	  tlField->SetCaption(str);
	  tlField->SetIsShow(true);
	}
  } else
  {
	if(tlField) tlField->SetIsShow(false);

	if(tlCity)
	{
	  tlCity->SetCaption(str);
	  tlCity->SetIsShow(true);
	}
  }
}

void CStartMgr::FrameMove(DWORD dwTime)
{
  static CTimeWork time(100);
  if(time.IsTimeOut(dwTime))
  {
	if(frmShipSail->GetIsShow())
	{
	  UpdateShipSailForm();
	}
  }

  // 刷新宠物头像
  static CTimeWork pet_time(300);
  if(pet_time.IsTimeOut(dwTime))
  {
	CItemCommand* pItem = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(1));
	if(pItem && pItem->GetItemInfo()->sType == enumItemTypePet && pItem->GetData().IsValid() && CGameScene::GetMainCha())
	{
	  SItemGrid& Data = pItem->GetData();
	  proPetHP->SetRange(0, float(Data.sEndure[1] / 50));
	  proPetHP->SetPosition(float(Data.sEndure[0] / 50));

	  //proPetSP->SetRange( 0, Data.sEnergy[1] );
	  //proPetSP->SetPosition( Data.sEnergy[0] );

	  static bool IsFlash;
	  IsFlash = !IsFlash;
	  /*if( IsFlash && Data.sEnergy[1]==Data.sEnergy[0] )
			{
				proPetSP->GetImage()->SetColor( 0xff00ff00 );
			}
			else
			{
				proPetSP->GetImage()->SetColor( 0xFFFFFFFF );
			}*/

	  if(!frmMainPet->GetIsShow())
		frmMainPet->Show();
	} else if(frmMainPet->GetIsShow())
	{
	  frmMainPet->Hide();
	}
  }
}

void CStartMgr::_evtShowBoatAttr(CGuiData* pSender, int x, int y, DWORD key) // 显示船只属性
{
  xShipFactory* pkShip = ((CWorldScene*)g_pGameApp->GetCurScene())->GetShipMgr()->_factory;
  if(pkShip && pkShip->sbf.wnd->GetIsShow())
  {
	pkShip->sbf.wnd->SetIsShow(false);
  } else
  {
	CS_GetBoatInfo();
  }
}

void CStartMgr::SwitchMap()
{
  frmMainChaRelive->Close();
  CMenu::CloseAll();

  if(!(dynamic_cast<CWorldScene*>(CGameApp::GetCurScene()))) return;

  if(!_IsNewer) return;

  CForm* frm = CFormMgr::s_Mgr.Find("frmVHelp");
  if(frm)
  {
	frm->evtEntrustMouseEvent = _NewFrmMainMouseEvent;
	frm->nTag				  = 1;
	frm->ShowModal();
  }
}

//~ 回调函数 =================================================================
void CStartMgr::_NewFrmMainMouseEvent(CCompent* pSender, int nMsgType,
									  int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();
  if(name == "btnNo" || name == "btnClose")
  {
	if(pSender->GetForm()->nTag == 1)
	  CBoxMgr::ShowMsgBox(_CloseEvent, RES_STRING(CL_LANGUAGE_MATCH_771));
	else
	  pSender->GetForm()->Close();
  }
}

void CStartMgr::_HelpFrmMainMouseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();
  if(name == "btnOpenHelp")
  {
	CForm* frm = CFormMgr::s_Mgr.Find("frmVHelp");
	if(frm)
	{
	  frm->evtEntrustMouseEvent = _NewFrmMainMouseEvent;
	  frm->nTag					= 0;
	  frm->ShowModal();
	}
	return;
  }
}

void CStartMgr::_CloseEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  CForm* frm = CFormMgr::s_Mgr.Find("frmVHelp");
  if(frm)
  {
	frm->Close();
  }
}

void CStartMgr::SysLabel(const char* pszFormat, ...)
{
  /*char szBuf[2048] = { 0 };*/

  va_list list;
  va_start(list, pszFormat);
  //vsprintf(szBuf, pszFormat, list);
  _vsnprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, pszFormat, list);
  va_end(list);

  labFollow->SetCaption(szBuf);
  frmFollow->Show();
}

void CStartMgr::SysHide()
{
  if(frmFollow->GetIsShow())
	frmFollow->Hide();
}

void CStartMgr::_MainChaRenderEvent(C3DCompent* pSender, int x, int y)
{
  pMainCha->Render();
}

void CStartMgr::RefreshMainFace(stNetChangeChaPart& stPart)
{
  if(pMainCha)
  {
	static stNetTeamChaPart stTeamPart;
	stTeamPart.Convert(stPart);
	pMainCha->UpdataFace(stTeamPart);
  }
}

void CStartMgr::_OnSelfMenu(CGuiData* pSender, int x, int y, DWORD key)
{
  CMenu* pMenu = dynamic_cast<CMenu*>(pSender);
  if(!pMenu) return;

  pMenu->SetIsShow(false);

  CMenuItem* pItem = pMenu->GetSelectMenu();
  if(!pItem) return;

  string str = pItem->GetString();
  //Modify by sunny.sun20080820
  //Begin
  const char* MapName = g_pGameApp->GetCurScene()->GetTerrainName(); // 取得人物当前所在地图
  //	if( stricmp( MapName,"starena1") == 0 || stricmp( MapName,"starena2") == 0 || stricmp( MapName,"starena3") == 0 )
  if(_stricmp(MapName, "starena1") == 0 || _stricmp(MapName, "starena2") == 0 || _stricmp(MapName, "starena3") == 0)
  {
	pItem->SetIsEnabled(false);
  } else
  {
	pItem->SetIsEnabled(true);
	if(str == RES_STRING(CL_LANGUAGE_MATCH_483))
	{
	  CS_Team_Leave();
	}
  }
  //End
}

void CStartMgr::SetIsLeader(bool v)
{
  imgLeader->SetIsShow(v);
}

bool CStartMgr::GetIsLeader()
{
  return imgLeader->GetIsShow();
}

bool CStartMgr::IsCanTeamAndInfo()
{
  if(!_IsCanTeam) g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_772));
  return _IsCanTeam;
}

void CStartMgr::RefreshPet(CItemCommand* pItem)
{
  static CItemRecord* pInfo = NULL;
  pInfo						= pItem->GetItemInfo();

  static SItemHint s_item;
  memset(&s_item, 0, sizeof(SItemHint));
  s_item.Convert(pItem->GetData(), pInfo);

  // 更新宠物等级,头像
  ///*int nLevel = s_item.sInstAttr[ITEMATTR_VAL_STR]
  //			+ s_item.sInstAttr[ITEMATTR_VAL_AGI]
  //			+ s_item.sInstAttr[ITEMATTR_VAL_DEX]
  //			+ s_item.sInstAttr[ITEMATTR_VAL_CON]
  //			+ s_item.sInstAttr[ITEMATTR_VAL_STA];

  //_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE , "%d", nLevel );
  //labPetLv->SetCaption( szBuf );

  //static CGuiPic* Pic = imgPetHead->GetImage();
  //Pic->LoadImage( pInfo->GetIconFile(),
  //	imgPetHead->GetWidth(), imgPetHead->GetHeight(),
  //	0,
  //	4, 4 );*/
}

void CStartMgr::ShowHelpSystem(bool bShow, int nIndex)
{
  int nCount = g_stUIStart.lstHelpList->GetItems()->GetCount();

  if(0 > nIndex || nCount <= nIndex)
  {
	// 越界
	frmHelpSystem->SetIsShow(bShow);
	return;
  }

  for(int i = 0; i < nCount; ++i)
  {
	imgHelpShow1[i]->SetIsShow(nIndex == i);
	imgHelpShow2[i]->SetIsShow(nIndex == i);
	imgHelpShow3[i]->SetIsShow(nIndex == i);
	imgHelpShow4[i]->SetIsShow(nIndex == i);
  }

  frmHelpSystem->SetIsShow(bShow);
}

void CStartMgr::ShowLevelUpHelpButton(bool bShow)
{
  if(btnLevelUpHelp)
  {
	btnLevelUpHelp->SetIsShow(bShow);
  }
}

//	Add by alfred.shi 20080905	begin
void CStartMgr::ShowLevelUpaddButton(bool bShow)
{
  btnLevelUpadd->SetIsShow(bShow);
}
//	End.

void CStartMgr::ShowAfkButton(bool bShow)
{
  btnafk->SetIsShow(bShow);
}
void CStartMgr::ShowInfoCenterButton(bool bShow)
{
  CTextButton* btnInfoCenter = dynamic_cast<CTextButton*>(frmMainFun->Find("btnInfoCenter"));
  if(btnInfoCenter)
  {
	btnInfoCenter->SetIsShow(bShow);
  }
}

void CStartMgr::_evtHelpListChange(CGuiData* pSender)
{
  //g_pGameApp->MsgBox("Index: %d\nName:  %s", nIndex, pSender->GetName());//g_stUIStart.lstHelpList->GetSelectItem()->
  CListItems* pItems = g_stUIStart.lstHelpList->GetItems();
  int		  nIndex = pItems->GetIndex(g_stUIStart.lstHelpList->GetSelectItem());

  //g_stUIStart.ShowLevelUpHelpButton(false);
  g_stUIStart.ShowHelpSystem(true, nIndex);
}

void CStartMgr::ShowBagButtonForm(bool bShow)
{
  if(frmBag)
  {
	frmBag->SetPos(frmMainFun->GetX2() - frmBag->GetWidth() - 109, frmMainFun->GetY() - frmBag->GetHeight() + 41);
	frmBag->Refresh();

	frmBag->SetIsShow(bShow);
  }
}

void CStartMgr::ShowSociliatyButtonForm(bool bShow)
{
  if(frmSociliaty)
  {
	frmSociliaty->SetPos(frmMainFun->GetX2() - frmSociliaty->GetWidth() - 67, frmMainFun->GetY() - frmSociliaty->GetHeight() + 39);
	frmSociliaty->Refresh();

	frmSociliaty->SetIsShow(bShow);
  }
}

//	挂机事件选择事件
void CStartMgr::EventSendTimeChange(CGuiData* pSender)
{
  string szAddress = cboexp->GetText();
  string tIme	   = szAddress.substr(0, 2);
  char*	 tiMe	   = (char*)tIme.c_str();
  sTime			   = atoi(tiMe);
}

void CStartMgr::_evtDragExpItem(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  int PushID = pItemCommand->GetItemInfo()->lID;
  if(PushID < 6804 || PushID > 6806)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUIStart.frmElfAfk->SetPointer(pItemCommand);
  if(pItem->GetIsPile() && pItem->GetTotalNum() > 0)
  {
	g_stUIStart.m_NumBox = g_stUIBox.ShowNumberBox(_evtOOXXEvent, pItemCommand->GetTotalNum(), "设定数量", true);
  }
  nPosition	   = pItem->GetIndex();
  itemNumInBag = pItemCommand->GetData().sNum;
}

void CStartMgr::ClearCommand(bool bRetry)
{
  /*if(bLock)
	{
		return;
	}*/
  PopItem(0, bRetry);
}

void CStartMgr::PopItem(int iIndex, bool bRetry)
{
  //  是否锁定
  /*if(bLock)
	{
		return;
	}*/
  // 删除Cmd中的Item，该Item会在PushItem()中由new生成
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(cmdexpItem[iIndex]->GetCommand());
  if(!pItemCommand)
	return;

  cmdexpItem[iIndex]->DelCommand(); // 该函数将删除delete Item

  // 将Item相应的物品栏恢复成可用
  CCommandObj* pItem = g_stUIEquip.GetGoodsGrid()->GetItem(iPutPos[iIndex]);
  if(pItem && (6 != iIndex))
  {
	pItem->SetIsValid(true);
  }

  // 记录Item在物品栏中的位置
  if(!bRetry)
  {
	iPutPos[iIndex] = NO_USE;
  }
}

void CStartMgr::PushItem(int iIndex, CItemCommand& rItem, bool bRetry /* = false*/)
{
  if(iIndex < 0 || iIndex >= 2)
	return;

  //  是否锁定
  //if(bLock)
  //{
  //	return;
  //}
  // 判断道具是否可以拖
  if(!rItem.GetIsValid())
  {
	return;
  }

  // 查看原来的Cmd中是否已经有Item了，如果有则移出
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(cmdexpItem[0]->GetCommand());
  if(pItemCommand)
  {
	PopItem(iIndex);
  }

  // 记录Item在物品栏中的位置
  if(!bRetry)
  {
	iPutPos[iIndex] = g_stUIEquip.GetGoodsGrid()->GetDragIndex();
  }

  if(6 != iIndex)
  {
	// 将Item相应的物品栏灰调
	rItem.SetIsValid(false);
  }

  // 将创建的Item放入Cmd中，这里用new将会在PopItem()中删除
  CItemCommand* pItemCmd = new CItemCommand(rItem);
  pItemCmd->SetIsValid(true);
  cmdexpItem[iIndex]->AddCommand(pItemCmd);
}

void CStartMgr::_evtCloseExpFrm(CForm* pForm, bool& IsClose)
{
  g_stUIStart.ClearCommand();
  CS_UnlockCharacter();
  CForm* f = CFormMgr::s_Mgr.Find("frmElfchat");
  if(f)
  {
	f->SetIsShow(false);
  }
}

void CStartMgr::_evtFormMouseClick(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();

  if(name == "btnelfafkYes")
  {
	CProCirculateCS* proCir = (CProCirculateCS*)g_NetIF->GetProCir();
	proCir->RequestLeaveExp('0', sTime, nPosition, numExpItem);
  } else if(name == "btnYes")
  {
	CProCirculateCS* proCir = (CProCirculateCS*)g_NetIF->GetProCir();
	proCir->RequestLeaveExp('1', sTime, nPosition, numExpItem);
	CForm* f = CFormMgr::s_Mgr.Find("frmElfAfk");
	if(f)
	{
	  f->SetIsShow(false);
	}
	nPosition  = -1;
	numExpItem = 0;
	//g_pGameApp->MsgBox( "恭喜您领取挂机经验成功了！" );
  }
  return;
}

void CStartMgr::RefreshLeftTimeName(int szTime)
{
  char str[50] = "";
  _snprintf_s(str, sizeof(str), _TRUNCATE, "剩余%d小时挂机时间", szTime);
  if(labelfexp)
  {
	labelfexp->SetCaption(str);
  }
}

void CStartMgr::RefreshLeftExpName(short sSelectTime, string BaseExp, string AddExp, string TotalExp, string UpLevel, string addPercent, short sNum, string amplitude, short coin)
{
  char sTemp[30] = "";
  if(ElfTxt02)
  {
	ElfTxt02->SetCaption(BaseExp.c_str());
  }
  if(ElfTxt04)
  {
	ElfTxt04->SetCaption(AddExp.c_str());
  }
  if(ElfTxt06)
  {
	ElfTxt06->SetCaption(TotalExp.c_str());
  }
  if(ElfTxt08)
  {
	_snprintf_s(sTemp, sizeof(sTemp), _TRUNCATE, "%s级%s%%经验", UpLevel.c_str(), addPercent.c_str());
	ElfTxt08->SetCaption(sTemp);
  }
  if(ElfTxt10)
  {
	_snprintf_s(sTemp, sizeof(sTemp), _TRUNCATE, "%d 个", coin);
	ElfTxt10->SetCaption(sTemp);
  }
  if(ElfTxt12)
  {
	_snprintf_s(sTemp, sizeof(sTemp), _TRUNCATE, "%d 个 %s倍增幅器", sNum, amplitude.c_str());
	ElfTxt12->SetCaption(sTemp);
  }
  if(ElfTxt14)
  {
	_snprintf_s(sTemp, sizeof(sTemp), _TRUNCATE, "%d 小时", sSelectTime);
	ElfTxt14->SetCaption(sTemp);
  }
}

void CStartMgr::_evtOOXXEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  int			num			 = g_stUIStart.m_NumBox->GetNumber();
  CItemCommand* pItemCommand = (CItemCommand*)g_stUIStart.frmElfAfk->GetPointer();
  if(num == 0)
  {
	pItemCommand->SetTotalNum(1);
  } else
  {
	pItemCommand->SetTotalNum(num);
  }

  g_stUIStart.PushItem(0, *pItemCommand);
  numExpItem = num;
  pItemCommand->SetTotalNum(itemNumInBag);
}

void CStartMgr::ShowExpForm(bool bShow /* = true */)
{
  CForm* f = CFormMgr::s_Mgr.Find("frmElfchat");
  if(f)
  {
	f->SetIsShow(bShow);
  }
}
