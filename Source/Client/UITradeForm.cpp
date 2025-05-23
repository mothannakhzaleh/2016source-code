#include "StdAfx.h"
#include "uitradeform.h"
#include "gameapp.h"
#include "scene.h"
#include "character.h"
#include "uiformmgr.h"
#include "uilabel.h"
#include "packetcmd.h"
#include "uiequipform.h"
#include "uiboxform.h"
#include "uigoodsgrid.h"
#include "uiequipform.h"
#include "uicheckbox.h"
#include "uicommand.h"
#include "uiitemcommand.h"
#include "uiboatform.h"
#include "rolecommon.h"
#include "ShipFactory.h"
#include "rolecommon.h"
#include "StringLib.h"
using namespace GUI;

//---------------------------------------------------------------------------
// class CTradeMgr
//---------------------------------------------------------------------------
bool CTradeMgr::Init()
{
  m_bTradeType	= 0;
  m_dwAcceptID	= 0; // 交易接受方
  m_dwRequestID = 0; // 交易申请方
  m_dwMainID	= 0;

  frmRequest = NULL;
  grdRequest = NULL;

  CFormMgr& mgr = CFormMgr::s_Mgr;

  //角色交易界面和控件
  frmPlayertrade = mgr.Find("frmPlayertrade");
  if(!frmPlayertrade)
  {
	LG("gui", RES_STRING(CL_LANGUAGE_MATCH_456));
	return false;
  }
  frmPlayertrade->evtEntrustMouseEvent = _MainMousePlayerTradeEvent;

  // 道具以及装备栏
  grdSale = dynamic_cast<CGoodsGrid*>(frmPlayertrade->Find("grdSale"));
  if(!grdSale) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "grdSale");
  GetPlayertradeSaleGrid()->evtBeforeAccept = _evtDragToGoodsEvent;
  GetPlayertradeSaleGrid()->evtRMouseEvent	= _evtSelfRMouseGridEvent;

  grdBuy = dynamic_cast<CGoodsGrid*>(frmPlayertrade->Find("grdBuy"));
  if(!grdBuy) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "grdBuy");
  GetPlayertradeBuyGrid()->evtBeforeAccept = _evtDragToGoodsEvent;
  GetPlayertradeBuyGrid()->evtRMouseEvent  = _evtOtherRMouseGridEvent;

  //角色交易的金额
  labOtherGold = dynamic_cast<CLabelEx*>(frmPlayertrade->Find("labOtherGold"));
  if(!labOtherGold) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "labOtherGold");

  labSelfGold = dynamic_cast<CLabelEx*>(frmPlayertrade->Find("labSelfGold"));
  if(!labSelfGold) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "labSelfGold");

  chkYes = (CCheckBox*)frmPlayertrade->Find("chkYes");
  if(!chkYes) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "chkYes");

  chkTrade = (CCheckBox*)frmPlayertrade->Find("chkTrade");
  if(!chkTrade) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "chkTrade");

  btnYes = (CTextButton*)frmPlayertrade->Find("btnYes");
  if(!btnYes) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "btnYes");

  btnTrade = (CTextButton*)frmPlayertrade->Find("btnTrade");
  if(!btnTrade) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "btnTrade");

  btnGold = (CTextButton*)frmPlayertrade->Find("btnGold");
  if(!btnGold) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmPlayertrade->GetName(), "btnGold");
  return true;
}

void CTradeMgr::End()
{
}

void CTradeMgr::FrameMove(DWORD dwTime)
{
  if(IsTrading())
  {
	CWorldScene* pWorldScene = dynamic_cast<CWorldScene*>(g_pGameApp->GetCurScene());
	if(pWorldScene && pWorldScene->GetShipMgr())
	{
	  pWorldScene->GetShipMgr()->CloseForm();
	}
  }
}

void CTradeMgr::ShowCharTradeRequest(BYTE byType, DWORD dwRequestID)
{
  CGameScene* pScene = CGameApp::GetCurScene();
  if(!pScene) return;

  CCharacter* pCha = pScene->SearchByID(dwRequestID); //申请方
  if(!pCha)
  {
	if(!pCha) return;
  }

  char szBuf[80] = {0};
  if(byType == mission::TRADE_CHAR)
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_779), pCha->getHumanName());
  else
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_780), pCha->getHumanName());

  // add by Philip.Wu  2006-06-11  防止因弹出过多的选择框导致当机
  //                               修改为一旦有交易邀请，就关闭之前的确定框
  g_stUIBox.CloseAllBox();

  stSelectBox* pBox = g_stUIBox.ShowSelectBox(_evtSelectYesNoEvent, szBuf);
  pBox->dwTag		= dwRequestID;
  pBox->dwParam		= byType;
  static int PosY	= 100;
  PosY += 10;
  if(PosY > 150) PosY = 100;
  pBox->frmDialog->SetPos(10, PosY);
  pBox->frmDialog->Refresh();
}

void CTradeMgr::_evtSelectYesNoEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  pSender->GetForm()->Close();
  string name = pSender->GetName();
  if(name != "btnYes") return;

  stSelectBox* pBox = (stSelectBox*)pSender->GetForm()->GetPointer();
  CS_AcceptTrade((BYTE)pBox->dwParam, pBox->dwTag);
}

void CTradeMgr::_MainMousePlayerTradeEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();
  if(name == "btnNo" || name == "btnClose") //如果是退出按钮,则关闭该表单
  {
	if(g_stUITrade.m_dwMainID == g_stUITrade.m_dwAcceptID)
	  ::CS_CancelTrade(g_stUITrade.m_bTradeType, g_stUITrade.m_dwRequestID);
	else
	  ::CS_CancelTrade(g_stUITrade.m_bTradeType, g_stUITrade.m_dwAcceptID);
	g_stUITrade.btnTrade->SetIsEnabled(false);
	g_stUITrade.btnYes->SetIsEnabled(false);
	g_stUITrade.btnGold->SetIsEnabled(false);
	return;
  } else if(name == "btnYes")
  {
	if(g_stUITrade.m_dwMainID == g_stUITrade.m_dwAcceptID)
	  ::CS_ValidateTradeData(g_stUITrade.m_bTradeType, g_stUITrade.m_dwRequestID);
	else
	  ::CS_ValidateTradeData(g_stUITrade.m_bTradeType, g_stUITrade.m_dwAcceptID);

	g_stUITrade.btnYes->SetIsEnabled(false);
	g_stUITrade.btnGold->SetIsEnabled(false);
	if(g_stUITrade.chkYes->GetIsChecked())
	  g_stUITrade.btnTrade->SetIsEnabled(true);
	return;
  } else if(name == "btnTrade")
  {
	if(g_stUITrade.m_dwMainID == g_stUITrade.m_dwAcceptID)
	  ::CS_ValidateTrade(g_stUITrade.m_bTradeType, g_stUITrade.m_dwRequestID);
	else
	  ::CS_ValidateTrade(g_stUITrade.m_bTradeType, g_stUITrade.m_dwAcceptID);
	g_stUITrade.btnTrade->SetIsEnabled(false);
	return;
  } else if(name == "btnGold")
  {
	//g_stUIBox.ShowNumberBox( _evtGoldFormEvent, g_stUIBoat.GetHuman()->getGameAttr()->get(ATTR_GD), RES_STRING(CL_LANGUAGE_MATCH_781), false );
	g_stUIBox.ShowNumberBox(_evtGoldFormEvent, (int)g_stUIBoat.GetHuman()->getGameAttr()->get(ATTR_GD), RES_STRING(CL_LANGUAGE_MATCH_781), false);
  }
}

void CTradeMgr::_evtGoldFormEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  stNumBox* pBox = (stNumBox*)pSender->GetForm()->GetPointer();
  if(!pBox) return;

  DWORD dwCharID = 0;
  if(g_stUITrade.m_dwMainID == g_stUITrade.m_dwRequestID)
	dwCharID = g_stUITrade.m_dwAcceptID;
  else
	dwCharID = g_stUITrade.m_dwRequestID;

  CS_AddMoney(g_stUITrade.m_bTradeType, dwCharID, mission::TRADE_DRAGMONEY_TRADE, pBox->GetNumber());
}

void CTradeMgr::ShowCharTrade(BYTE byType, DWORD dwAcceptID, DWORD dwRequestID)
{
  if(!frmPlayertrade) return; //交易界面

  CGameScene* pScene = g_pGameApp->GetCurScene();
  if(!pScene) return;

  m_bTradeType	= byType;
  m_dwRequestID = dwRequestID;
  m_dwAcceptID	= dwAcceptID;
  CCharacter* pRequestCha(NULL);
  CCharacter* pAcceptCha(NULL);

  if(mission::TRADE_CHAR == byType) //玩家人物之间的交易
  {
	frmRequest = g_stUIEquip.GetItemForm();
	grdRequest = g_stUIEquip.GetGoodsGrid(); //道具栏的Grid控件

	pRequestCha = pScene->SearchByHumanID(dwRequestID);
	pAcceptCha	= pScene->SearchByHumanID(dwAcceptID);
  } else if(mission::TRADE_BOAT == byType) //玩家船只之间的交易,这时两人都是船,所有用ID搜索
  {
	CCharacter* pMain = CGameScene::GetMainCha();
	if(!pMain) return;

	if(!pMain->IsBoat()) return;

	pRequestCha = pScene->SearchByID(dwRequestID);
	pAcceptCha	= pScene->SearchByID(dwAcceptID);

	CCharacter* pMainShip = NULL;
	if(pRequestCha->GetMainType())
	  pMainShip = pRequestCha;
	else
	  pMainShip = pAcceptCha;

	xShipFactory* pkShip = ((CWorldScene*)g_pGameApp->GetCurScene())->GetShipMgr()->_factory;
	pkShip->SetState(xShipFactory::STATE_TRADE_FREEDOM);
	CBoat* pBoat = g_stUIBoat.FindBoat(pMainShip->getAttachID());
	if(!pBoat)
	{
	  return;
	}
	// 判断船只属性页面是否打开,如果打开,关闭它
	CForm* pBoatRoom = pBoat->GetForm();
	if(!pBoatRoom) return;
	CForm* pForm = dynamic_cast<CForm*>(pBoatRoom->GetParent());
	if(pkShip && pkShip->sbf.wnd->GetIsShow() && pForm == pkShip->sbf.wnd)
	{
	  pkShip->sbf.wnd->SetIsShow(false);
	}

	pkShip->SetBoatID(pMainShip->getAttachID());

	DWORD dwBuf[8];
	if(!CCharacter::ConvertPartTo8DWORD(pMainShip->GetPart(), dwBuf))
	  return;
	pkShip->UpdateBoatFreedomTrade(pMainShip->getName(), dwBuf, sizeof(dwBuf));

	grdRequest = pBoat->GetGoodsGrid();
	frmRequest = pkShip->sbf.wnd;
	// frmRequest = pBoat->GetForm();
  } //end of if

  if(!frmRequest) return;
  if(!pRequestCha || !pAcceptCha) return;

  if(pRequestCha->GetMainType())
	m_dwMainID = dwRequestID;
  else
	m_dwMainID = dwAcceptID;

  //设置表单的位置并显示,以及交易表单控件初始化
  frmRequest->SetParent(NULL);
  frmRequest->SetPos(0, 100);
  frmRequest->Refresh();
  frmRequest->Show();

  frmPlayertrade->SetPos(frmRequest->GetWidth(), 100);
  frmPlayertrade->Refresh();
  frmPlayertrade->Show();

  if(grdBuy) grdBuy->Clear();
  if(grdSale) grdSale->Clear();
  if(labOtherGold) labOtherGold->SetCaption("0");
  if(labSelfGold) labSelfGold->SetCaption("0");

  chkYes->SetIsChecked(false);
  chkTrade->SetIsChecked(false);

  btnYes->SetIsEnabled(true);
  btnGold->SetIsEnabled(m_bTradeType == mission::TRADE_CHAR);
  btnTrade->SetIsEnabled(false);

  string strPlayTradeLabName(""); //labPlayertradeName控件Caption
  strPlayTradeLabName = pRequestCha->getHumanName();
  strPlayTradeLabName += "/";
  strPlayTradeLabName += pAcceptCha->getHumanName();

  // 刚开始看见对方输入的金额以物品，只有对方确定以后才能看见
  labOtherGold->SetIsShow(false);
  GetPlayertradeBuyGrid()->SetIsShow(false);

  CLabelEx* labPlayertradeName = dynamic_cast<CLabelEx*>(frmPlayertrade->Find("labPlayertradeName"));
  if(labPlayertradeName)
  {
	labPlayertradeName->SetCaption(strPlayTradeLabName.c_str());
  }
}

void CTradeMgr::DragTradeToItem(DWORD dwCharID, BYTE byIndex, BYTE byItemIndex)
{
  CGoodsGrid* tradeGrd = NULL;
  if(g_stUITrade.m_dwMainID == dwCharID)
  {
	tradeGrd = g_stUITrade.GetPlayertradeSaleGrid();

	CCommandObj* pObj = grdRequest->GetItem(byItemIndex);
	if(pObj) pObj->SetIsValid(true);
  } else
  {
	tradeGrd = g_stUITrade.GetPlayertradeBuyGrid();
  }

  if(tradeGrd) tradeGrd->DelItem(byIndex);
}

void CTradeMgr::DragItemToTrade(DWORD dwCharID, USHORT sItemID, BYTE byIndex, BYTE byCount, BYTE byItemIndex, SItemGrid* pGrid, const NET_CHARTRADE_BOATDATA* const pBoat)
{
  //LG( "Trade", "DragItemToTrade( CharID:%u, ItemID:%d, Index:%d, Count:%d, ItemIndex:%d ) - MainID:%d\n", dwCharID, sItemID, byIndex, byCount, byItemIndex, g_stUITrade.m_dwMainID );

  CGoodsGrid* tradeGrd;
  if(m_dwMainID == dwCharID)
  {
	tradeGrd = g_stUITrade.GetPlayertradeSaleGrid();

	//道具栏中该道具变灰
	CCommandObj* pSelf = grdRequest->GetItem(byItemIndex);
	if(pSelf)
	{
	  pSelf->SetIsValid(false);
	}
  } else
  {
	tradeGrd = g_stUITrade.GetPlayertradeBuyGrid();
  }

  CItemRecord* pItem = GetItemRecordInfo(sItemID);
  if(!pItem)
  {
	//LG( "protocol", "GetItemRecordInfo return NULL" );
	return;
  }

  CCommandObj* pObj = tradeGrd->GetItem(byIndex);
  if(pObj)
  {
	//LG( "Trade", "msgTrade Error\n" );
  } else
  {
	CItemCommand* pItemCommand = new CItemCommand(pItem);
	if(pGrid) pItemCommand->SetData(*pGrid);
	pItemCommand->SetBoatHint(pBoat);
	if(!tradeGrd->SetItem(byIndex, pItemCommand))
	{
	  //LG( "protocol", "SetItem return false" );
	  return;
	}
  }
}

void CTradeMgr::ShowCharTradeMoney(DWORD dwCharID, DWORD dwMoney)
{
  if(!frmPlayertrade) return;
  if(!labOtherGold) return;
  if(!labSelfGold) return;

  char szBuf[32] = {0};
  int  nCurMoney = dwMoney;
  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%s", StringSplitNum(nCurMoney));
  if(dwCharID == m_dwMainID)
  {
	labSelfGold->SetCaption(szBuf);
  } else
  {
	labOtherGold->SetCaption(szBuf);
  }
}

void CTradeMgr::_evtLocalSaleEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  stNumBox* pBox = (stNumBox*)pSender->GetForm()->GetPointer();
  if(!pBox) return;

  stSale* p = (stSale*)pBox->pointer;
  CS_AddItem(g_stUITrade.m_bTradeType, p->dwSaleID, mission::TRADE_DRAGTO_TRADE, p->nGridID, p->nDragID, pBox->GetNumber());
}

void CTradeMgr::LocalSaleItem(CGoodsGrid* pSaleGrid, CGoodsGrid* pSelfGrid, int nGridID, CCommandObj* pItem)
{
  if(!pItem->GetIsValid()) return;

  if(CItemCommand* pBoat = dynamic_cast<CItemCommand*>(pItem))
  {
	if(pBoat && pBoat->GetItemInfo()->sType == 43)
	{
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_782));
	}
  }

  if(pItem->GetIsPile() && pItem->GetTotalNum() > 1)
  {
	stNumBox* pBox = g_stUIBox.ShowNumberBox(_evtLocalSaleEvent, pItem->GetTotalNum());
	if(pBox)
	{
	  pBox->pointer	  = (void*)&_sSale;
	  _sSale.dwSaleID = g_stUITrade.m_dwMainID == m_dwAcceptID ? m_dwRequestID : m_dwAcceptID;
	  _sSale.nGridID  = nGridID;
	  _sSale.nDragID  = pSelfGrid->GetDragIndex();
	  return;
	}
  }

  if(m_dwMainID == m_dwAcceptID)
	CS_AddItem(g_stUITrade.m_bTradeType, m_dwRequestID, mission::TRADE_DRAGTO_TRADE, nGridID, pSelfGrid->GetDragIndex(), pItem->GetTotalNum());
  else
	CS_AddItem(g_stUITrade.m_bTradeType, m_dwAcceptID, mission::TRADE_DRAGTO_TRADE, nGridID, pSelfGrid->GetDragIndex(), pItem->GetTotalNum());
}

void CTradeMgr::LocalCancelItem(CGoodsGrid* pSaleGrid, CGoodsGrid* pSelfGrid, int nGridID, CCommandObj* pItem)
{
  if(!pItem->GetIsValid()) return;

  if(m_dwMainID == m_dwAcceptID)
	CS_AddItem(g_stUITrade.m_bTradeType, m_dwRequestID, mission::TRADE_DRAGTO_ITEM, pSaleGrid->GetDragIndex(), nGridID, 0);
  else
	CS_AddItem(g_stUITrade.m_bTradeType, m_dwAcceptID, mission::TRADE_DRAGTO_ITEM, pSaleGrid->GetDragIndex(), nGridID, 0);
}

void CTradeMgr::ValidateTradeData(DWORD dwCharID) //
{
  if(dwCharID == m_dwMainID)
  {
	btnYes->SetIsEnabled(false);
	btnGold->SetIsEnabled(false);
  } else
  {
	labOtherGold->SetIsShow(true);
	GetPlayertradeBuyGrid()->SetIsShow(true);

	chkYes->SetIsChecked(true);
	if(!btnYes->GetIsEnabled())
	  btnTrade->SetIsEnabled(true);
  }
}

void CTradeMgr::ValidateTrade(DWORD dwCharID)
{
  if(dwCharID == m_dwMainID)
  {
	btnYes->SetIsEnabled(false);
	btnGold->SetIsEnabled(false);
  } else
  {
	chkTrade->SetIsChecked(true);
  }
}

void CTradeMgr::ShowTradeSuccess()
{
  int nFree = g_stUIEquip.GetGoodsGrid()->GetMaxNum() - g_stUIEquip.GetGoodsGrid()->GetCurNum();
  if(nFree < g_stUITrade.grdBuy->GetCurNum())
  {
	g_pGameApp->ShowMidText(RES_STRING(CL_LANGUAGE_MATCH_783));
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_783));
  }

  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_784));
  Clear();
}

void CTradeMgr::ShowTradeFailed()
{
  g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_785));
  Clear();
}

void CTradeMgr::Clear()
{
  CCommandObj* pItem(NULL);
  for(int i = 0; i < grdRequest->GetMaxNum(); i++)
  {
	pItem = grdRequest->GetItem(i);
	if(pItem && !pItem->GetIsValid())
	{
	  pItem->SetIsValid(true);
	}
  }

  //关闭左边表单
  if(frmRequest) frmRequest->Close();

  //关闭右边表单
  if(frmPlayertrade) frmPlayertrade->Close();

  //其他
  frmRequest = NULL;
  grdRequest = NULL;

  m_bTradeType	= 0;
  m_dwAcceptID	= 0;
  m_dwRequestID = 0;

  if(CDrag::GetDrag())
  {
	CDrag::GetDrag()->Reset();
  }

  // 交易后关闭出海
  CWorldScene* pWorldScene = dynamic_cast<CWorldScene*>(g_pGameApp->GetCurScene());
  if(pWorldScene && pWorldScene->GetShipMgr())
  {
	pWorldScene->GetShipMgr()->CloseForm();
  }
}

void CTradeMgr::CancelCharTrade(DWORD dwCharID)
{
  if(dwCharID == m_dwMainID)
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_786));
  else
	g_pGameApp->SysInfo(RES_STRING(CL_LANGUAGE_MATCH_787));

  Clear();
}

bool CTradeMgr::IsTrading()
{
  if(frmPlayertrade) return frmPlayertrade->GetIsShow();
  return false;
}

void CTradeMgr::_evtSelfRMouseGridEvent(CGuiData* pSender, CCommandObj* pItem, int nGridID)
{
  return;
  if(!g_stUIBoat.GetHuman()) return;

  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || pItemCommand->GetItemInfo()->sType != 43) return;

  stNetItemInfo info;
  info.chType  = mission::VIEW_CHARTRADE_SELF;
  info.sGridID = nGridID;
  CS_BeginAction(g_stUIBoat.GetHuman(), enumACTION_ITEM_INFO, &info);
}

void CTradeMgr::_evtOtherRMouseGridEvent(CGuiData* pSender, CCommandObj* pItem, int nGridID)
{
  return;
  if(!g_stUIBoat.GetHuman()) return;

  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || pItemCommand->GetItemInfo()->sType != 43) return;

  stNetItemInfo info;
  info.chType  = mission::VIEW_CHARTRADE_OTHER;
  info.sGridID = nGridID;
  CS_BeginAction(g_stUIBoat.GetHuman(), enumACTION_ITEM_INFO, &info);
}

// add by Philip.Wu  2006-07-04  停止交易并关闭交易框
void CTradeMgr::CloseAllForm()
{
  // 先停止交易
  if(IsTrading())
  {
	::CS_CancelTrade(g_stUITrade.m_bTradeType, g_stUITrade.m_dwRequestID);
  }

  // 关闭窗体
  if(frmPlayertrade && frmPlayertrade->GetIsShow())
  {
	frmPlayertrade->SetIsShow(false);
  }

  if(frmRequest && frmRequest->GetIsShow())
  {
	frmRequest->SetIsShow(false);
  }
}
