#include "StdAfx.h"
#include "uinpctradeform.h"
#include "uiequipform.h"
#include "uigoodsgrid.h"
#include "uiitemcommand.h"
#include "uipage.h"
#include "packetcmd.h"
#include "gameapp.h"
#include "scene.h"
#include "character.h"
#include "uiboxform.h"
#include "uiedit.h"
#include "uiboatform.h"
#include "StringLib.h"

using namespace GUI;

//---------------------------------------------------------------------------
// class CNpcTradeMgr
//---------------------------------------------------------------------------
bool CNpcTradeMgr::Init()
{
  _dwNpcID = 0;
  _IsShow  = false;

  // NPC交易表单
  frmNPCtrade = _FindForm("frmNPCtrade"); // 道具表单
  if(!frmNPCtrade) return false;

  CPage* pgeNPCtrade = (CPage*)frmNPCtrade->Find("pgeNPCtrade");
  if(!pgeNPCtrade) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmNPCtrade->GetName(), "pgeNPCtrade");

  // 交易的武器栏
  grdNPCtradeWeapon = dynamic_cast<CGoodsGrid*>(frmNPCtrade->Find("grdNPCtradeWeapon"));
  if(!grdNPCtradeWeapon) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmNPCtrade->GetName(), "grdNPCtradeWeapon");
  grdNPCtradeWeapon->evtBeforeAccept = _evtDragToGoodsEvent;

  // 交易的装备栏
  grdNPCtradeEquip = dynamic_cast<CGoodsGrid*>(frmNPCtrade->Find("grdNPCtradeEquip"));
  if(!grdNPCtradeEquip) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmNPCtrade->GetName(), "grdNPCtradeEquip");
  grdNPCtradeEquip->evtBeforeAccept = _evtDragToGoodsEvent;

  // 交易的药品栏
  grdNPCtradeOther = dynamic_cast<CGoodsGrid*>(frmNPCtrade->Find("grdNPCtradeOther"));
  if(!grdNPCtradeOther) return Error(RES_STRING(CL_LANGUAGE_MATCH_45), frmNPCtrade->GetName(), "grdNPCtradeOther");
  grdNPCtradeOther->evtBeforeAccept = _evtDragToGoodsEvent;
  return true;
}

void CNpcTradeMgr::End()
{
}

void CNpcTradeMgr::ShowTradePage(const NET_TRADEINFO& TradeInfo, BYTE byCmd, DWORD dwNpcID)
{
  _dwNpcID = dwNpcID;

  if(frmNPCtrade) //打开界面前，删除所有的道具，防具和其他
  {
	grdNPCtradeWeapon->Clear();
	grdNPCtradeEquip->Clear();
	grdNPCtradeOther->Clear();
  }
  CItemRecord* pItem;

  int j;
  for(j = 0; j < TradeInfo.TradePage[0].byCount; j++)
  {
	pItem = GetItemRecordInfo(TradeInfo.TradePage[0].sItemID[j]);
	if(!pItem)
	{
	  LG("error", "msgCNpcTradeMgr::ShowTradePage item index[%d] out of range", TradeInfo.TradePage[0].sItemID[j]);
	  continue;
	}

	//CItemCommand* pObj = new CItemCommand( pItem );
	CItemCommand* pObj = new CItemCommand(pItem, false); //modified guojiangang 20090108

	_NpcItemRefresh(pObj);
	if(!grdNPCtradeWeapon->SetItem(j, pObj))
	{
	  //delete pObj;
	  SAFE_DELETE(pObj); // UI当机处理
	  LG("error", "msgShowTradePage grdNPCtradeWeapon out of range\n");
	}
  }
  grdNPCtradeWeapon->GetScroll()->Reset();

  for(j = 0; j < TradeInfo.TradePage[1].byCount; j++)
  {
	pItem = GetItemRecordInfo(TradeInfo.TradePage[1].sItemID[j]);
	if(!pItem)
	{
	  LG("error", "msgCNpcTradeMgr::ShowTradePage item index[%d] out of range", TradeInfo.TradePage[1].sItemID[j]);
	  continue;
	}

	//CItemCommand* pObj = new CItemCommand( pItem );
	CItemCommand* pObj = new CItemCommand(pItem, false); //modified guojiangang 20090108
	_NpcItemRefresh(pObj);
	if(!grdNPCtradeEquip->SetItem(j, pObj))
	{
	  //delete pObj;
	  SAFE_DELETE(pObj); // UI当机处理
	  LG("error", "msgShowTradePage grdNPCtradeEquip out of range\n");
	}
  }
  grdNPCtradeEquip->GetScroll()->Reset();

  for(j = 0; j < TradeInfo.TradePage[2].byCount; j++)
  {
	pItem = GetItemRecordInfo(TradeInfo.TradePage[2].sItemID[j]);
	if(!pItem)
	{
	  LG("error", "msgCNpcTradeMgr::ShowTradePage item index[%d] out of range", TradeInfo.TradePage[2].sItemID[j]);
	  continue;
	}

	//CItemCommand* pObj = new CItemCommand( pItem );
	CItemCommand* pObj = new CItemCommand(pItem, false); //modified guojiangang 20090108
	_NpcItemRefresh(pObj);
	if(!grdNPCtradeOther->SetItem(j, pObj))
	{
	  //delete pObj;
	  SAFE_DELETE(pObj); // UI当机处理
	  LG("error", "msgShowTradePage grdNPCtradeEquip out of range\n");
	}
  }
  grdNPCtradeOther->GetScroll()->Reset();

  int nIndex = 0;
  if(TradeInfo.TradePage[0].byCount > 0)
  {
	nIndex = 0;
  } else if(TradeInfo.TradePage[1].byCount > 0)
  {
	nIndex = 1;
  } else
  {
	nIndex = 2;
  }
  CPage* pgeNPCtrade = dynamic_cast<CPage*>(frmNPCtrade->Find("pgeNPCtrade"));
  if(pgeNPCtrade) pgeNPCtrade->SetIndex(nIndex);

  if(frmNPCtrade)
  {
	frmNPCtrade->SetPos(100, 100);
	frmNPCtrade->Refresh();
	frmNPCtrade->Show();
  }

  if(g_stUIEquip.GetItemForm())
  {
	g_stUIEquip.GetItemForm()->SetPos(frmNPCtrade->GetX2(), frmNPCtrade->GetY());
	g_stUIEquip.GetItemForm()->Refresh();
	g_stUIEquip.GetItemForm()->Show();
  }

  _IsShow = true;
}

void CNpcTradeMgr::SaleToNpc(BYTE byIndex, BYTE byCount, USHORT sItemID, DWORD dwMoney)
{
}

void CNpcTradeMgr::BuyFromNpc(BYTE byIndex, BYTE byCount, USHORT sItemID, DWORD dwMoney)
{
}

void CNpcTradeMgr::_NpcItemRefresh(CItemCommand* pItem)
{
  static SItemGrid data;
  memset(&data, 0, sizeof(data));
  data.SetValid(true);

  CItemRecord* pInfo = pItem->GetItemInfo();
  if(pInfo->sType >= 1 && pInfo->sType <= 10) // 武器
  {
	// 耐久度
	data.sEndure[0] = pInfo->sEndure[0];
	data.sEndure[1] = pInfo->sEndure[0];

	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_MNATK;
	data.sInstAttr[i][1] = pInfo->sMnAtkValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_MXATK;
	data.sInstAttr[i][1] = pInfo->sMxAtkValu[0];

	switch(pInfo->sType)
	{
	case 1: // 单手剑
	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_COE_ASPD;
	  data.sInstAttr[i][1] = pInfo->sASpdCoef;

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_HIT;
	  data.sInstAttr[i][1] = pInfo->sHitValu[0];
	  break;
	case 2: // 巨剑
	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_DEF;
	  data.sInstAttr[i][1] = pInfo->sDefValu[0];

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_MXHP;
	  data.sInstAttr[i][1] = pInfo->sMxHpValu[0];
	  break;
	case 3: // 弓
	case 4: // 火枪
	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_COE_ASPD;
	  data.sInstAttr[i][1] = pInfo->sASpdCoef;

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_HIT;
	  data.sInstAttr[i][1] = pInfo->sHitValu[0];
	  break;
	case 7: // 匕首
	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_COE_MXSP;
	  data.sInstAttr[i][1] = pInfo->sMxSpCoef;

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_STA;
	  data.sInstAttr[i][1] = pInfo->sStaValu[0];

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_COE_MSPD;
	  data.sInstAttr[i][1] = pInfo->sMSpdCoef;
	  break;
	case 9: // 法杖
	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_STA;
	  data.sInstAttr[i][1] = pInfo->sStaValu[0];

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_COE_MXSP;
	  data.sInstAttr[i][1] = pInfo->sMxSpCoef;

	  i++;
	  data.sInstAttr[i][0] = ITEMATTR_VAL_MXHP;
	  data.sInstAttr[i][1] = pInfo->sMxHpValu[0];
	  break;
	}

	pItem->SetData(data);
  } else if(pInfo->sType == 22 || pInfo->sType == 11 || pInfo->sType == 27)
  {
	// 防御力
	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_DEF;
	data.sInstAttr[i][1] = pInfo->sDefValu[0];

	// 耐久度
	data.sEndure[0] = pInfo->sEndure[0];
	data.sEndure[1] = pInfo->sEndure[0];

	// 物理抵抗
	i++;
	//data.sInstAttr[i][0] = ITEMATTR_VAL_PDEF;
	data.sInstAttr[i][1] = pInfo->sPDef[0];

	pItem->SetData(data);
  } else if(pInfo->sType == 25) // 项链
  {
	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_MXHP;
	data.sInstAttr[i][1] = pInfo->sMxHpValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_MXSP;
	data.sInstAttr[i][1] = pInfo->sMxSpValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_HREC;
	data.sInstAttr[i][1] = pInfo->sHRecValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_SREC;
	data.sInstAttr[i][1] = pInfo->sSRecValu[0];

	i++;
	//		data.sInstAttr[i][0] = ITEMATTR_VAL_PDEF;
	data.sInstAttr[i][1] = pInfo->sPDef[0];

	pItem->SetData(data);
  } else if(pInfo->sType == 26) // 戒指
  {
	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_MXATK;
	data.sInstAttr[i][1] = pInfo->sMxAtkValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_DEF;
	data.sInstAttr[i][1] = pInfo->sDefValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_FLEE;
	data.sInstAttr[i][1] = pInfo->sFleeValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_HIT;
	data.sInstAttr[i][1] = pInfo->sHitValu[0];

	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_CRT;
	data.sInstAttr[i][1] = pInfo->sCrtValu[0];

	pItem->SetData(data);
  } else if(pInfo->sType == 23) //手套
  {
	// 防御力
	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_DEF;
	data.sInstAttr[i][1] = pInfo->sDefValu[0];

	// 耐久度
	data.sEndure[0] = pInfo->sEndure[0];
	data.sEndure[1] = pInfo->sEndure[0];

	// 命中率
	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_HIT;
	data.sInstAttr[i][1] = pInfo->sHitValu[0];

	pItem->SetData(data);
  } else if(pInfo->sType == 24) // 鞋子
  {
	// 防御力
	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_DEF;
	data.sInstAttr[i][1] = pInfo->sDefValu[0];

	// 耐久度
	data.sEndure[0] = pInfo->sEndure[0];
	data.sEndure[1] = pInfo->sEndure[0];

	// 闪避率
	i++;
	data.sInstAttr[i][0] = ITEMATTR_VAL_FLEE;
	data.sInstAttr[i][1] = pInfo->sFleeValu[0];

	pItem->SetData(data);
  } else if(pInfo->sType == 20) // 帽子
  {
	// 防御力
	int i				 = 0;
	data.sInstAttr[i][0] = ITEMATTR_VAL_DEF;
	data.sInstAttr[i][1] = pInfo->sDefValu[0];

	// 耐久度
	data.sEndure[0] = pInfo->sEndure[0];
	data.sEndure[1] = pInfo->sEndure[0];

	pItem->SetData(data);
  } else if(pInfo->sType == 29) // 贝壳
  {
	//data.sEnergy[0] = pInfo->sEnergy[0];
	//data.sEnergy[1] = pInfo->sEnergy[1];

	pItem->SetData(data);
  }
}

void CNpcTradeMgr::LocalBuyFromNpc(CGoodsGrid* pNpcGrid, CGoodsGrid* pSelfGrid, int nGridID, CCommandObj* pItem)
{
  int nIndex = 2;
  if(pNpcGrid == g_stUINpcTrade.GetNPCtradeWeaponGrid())
	nIndex = 0;
  else if(pNpcGrid == g_stUINpcTrade.GetNPCtradeEquipGrid())
	nIndex = 1;

  CItemCommand* pBuy = dynamic_cast<CItemCommand*>(pItem);
  if(!pBuy) return;

  int nBuyGrid	= nGridID;
  int nBuyCount = 1;
  if(pBuy && pBuy->GetItemInfo()->GetIsPile())
  {
	CItemRecord*  pRecord = pBuy->GetItemInfo();
	CItemCommand* pInfo	  = 0;
	int			  count	  = pSelfGrid->GetMaxNum();
	for(int i = 0; i < count; i++)
	{
	  pInfo = dynamic_cast<CItemCommand*>(pSelfGrid->GetItem(i));
	  if(pInfo && pInfo->GetItemInfo() == pRecord)
	  {
		nBuyGrid = i;
		break;
	  }
	}
  }

  int nMax = -1;
  if(pBuy->GetPrice() > 0 && CGameScene::GetMainCha())
  {
	//nMax = CGameScene::GetMainCha()->getGameAttr()->get(ATTR_GD) /  pBuy->GetPrice();
	nMax = (int)CGameScene::GetMainCha()->getGameAttr()->get(ATTR_GD) / pBuy->GetPrice();
	if(nMax > pBuy->GetItemInfo()->nPileMax)
	  nMax = pBuy->GetItemInfo()->nPileMax;

	if(nMax == 0)
	{
	  g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_459));
	  return;
	}
  }
  char buf[256] = {0};
  _snprintf_s(buf, _countof(buf), _TRUNCATE, "%s[%s$]?", pBuy->GetName(), StringSplitNum(pBuy->GetPrice()));
  if(pBuy->GetIsPile() && (_sBuy.pBox = g_stUIBox.ShowTradeBox(_BuyTradeEvent, (float)pBuy->GetPrice(), nMax, buf)))
  {
	_sBuy.dwNpcID	 = _dwNpcID;
	_sBuy.nBuyGrid	 = nBuyGrid;
	_sBuy.nDragIndex = pNpcGrid->GetDragIndex();
	_sBuy.nIndex	 = nIndex;
	return;
  } else
  {
	/*char buf[256] = { 0 };*/
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_742), pBuy->GetName(), StringSplitNum(pBuy->GetPrice()));
	if(g_stUIBox.ShowSelectBox(_BuyEquipYesNoTradeEvent, buf, true))
	{
	  _sBuy.dwNpcID	   = _dwNpcID;
	  _sBuy.nBuyGrid   = nBuyGrid;
	  _sBuy.nDragIndex = pNpcGrid->GetDragIndex();
	  _sBuy.nIndex	   = nIndex;
	}
	return;
  }

  CS_Buy(_dwNpcID, nIndex, (BYTE)pNpcGrid->GetDragIndex(), nBuyGrid, nBuyCount);
}

void CNpcTradeMgr::LocalSaleToNpc(CGoodsGrid* pNpcGrid, CGoodsGrid* pSelfGrid, int nGridID, CCommandObj* pItem)
{
  CItemCommand* pSaleItem = dynamic_cast<CItemCommand*>(pItem);
  if(!pSaleItem) return;

  int nPrice = (int)((float)pSaleItem->GetPrice() / 2.0f);

  if(pSaleItem->GetIsPile() && pSaleItem->GetTotalNum() > 1)
  {
	char buf[256] = {0};
	_snprintf_s(buf, _countof(buf), _TRUNCATE, "%s[%s$]", pSaleItem->GetItemInfo()->szName, StringSplitNum(nPrice));
	if(_sSale.pBox = g_stUIBox.ShowTradeBox(_SaleTradeEvent, (float)nPrice, pItem->GetTotalNum(), buf))
	{
	  _sSale.dwNpcID = _dwNpcID;
	  _sSale.nIndex	 = pSelfGrid->GetDragIndex();
	  return;
	}
  } else
  {
	static SItemHint item;
	memset(&item, 0, sizeof(SItemHint));
	SItemGrid& ItemGrid = pSaleItem->GetData();

	CItemRecord* pInfo = GetItemRecordInfo(ItemGrid.sID);
	if(CItemRecord::IsVaildFusionID(pInfo) && ItemGrid.GetFusionItemID() > 0)
	{
	  CItemRecord* pEquipItem = GetItemRecordInfo(ItemGrid.GetFusionItemID());
	  if(pEquipItem)
		item.Convert(ItemGrid, pEquipItem);
	} else
	  item.Convert(ItemGrid, pInfo);

	bool OldItem = false;
	if(item.sEndure[0] != item.sEndure[1] || item.sEnergy[0] != item.sEnergy[1])
	  OldItem = true;
	if(OldItem)
	  nPrice = (int)((float)pSaleItem->GetPrice() / 8.0f);

	char buf[256] = {0};
	if(pSaleItem->GetItemInfo()->sType == 43)
	{
	  CBoat* pBoat = g_stUIBoat.FindBoat(pSaleItem->GetData().GetDBParam(enumITEMDBP_INST_ID));
	  if(pBoat)
	  {
		if(OldItem)
		  nPrice = (int)pBoat->GetCha()->getGameAttr()->get(ATTR_BOAT_PRICE) / 2;
		else
		  nPrice = (int)pBoat->GetCha()->getGameAttr()->get(ATTR_BOAT_PRICE) / 8;
	  }
	}

	if(OldItem)
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_992), pSaleItem->GetName(), StringSplitNum(nPrice));
	else
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_743), pSaleItem->GetName(), StringSplitNum(nPrice));
	if(g_stUIBox.ShowSelectBox(_SaleEquipYesNoTradeEvent, buf, true))
	{
	  _sSale.dwNpcID = _dwNpcID;
	  _sSale.nIndex	 = pSelfGrid->GetDragIndex();
	}
	return;
  }

  CS_Sale(_dwNpcID, (BYTE)pSelfGrid->GetDragIndex(), pItem->GetTotalNum());
}

void CNpcTradeMgr::_BuyTradeEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  stBuy& buy = g_stUINpcTrade._sBuy;
  CS_Buy(buy.dwNpcID, buy.nIndex, buy.nDragIndex, buy.nBuyGrid, buy.pBox->GetTradeNum());
}

void CNpcTradeMgr::_BuyEquipYesNoTradeEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  stBuy& buy = g_stUINpcTrade._sBuy;
  CS_Buy(buy.dwNpcID, buy.nIndex, buy.nDragIndex, buy.nBuyGrid, 1);
}

void CNpcTradeMgr::_SaleTradeEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  stSale& sale = g_stUINpcTrade._sSale;
  CS_Sale(sale.dwNpcID, sale.nIndex, sale.pBox->GetTradeNum());
}

void CNpcTradeMgr::_SaleEquipYesNoTradeEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes) return;

  stSale& sale = g_stUINpcTrade._sSale;
  CS_Sale(sale.dwNpcID, sale.nIndex, 1);
}

void CNpcTradeMgr::CloseForm()
{
  if(!_IsShow) return;

  _IsShow = false;

  if(g_stUIEquip.GetItemForm()->GetIsShow())
  {
	g_stUIEquip.GetItemForm()->Close();
  }

  if(frmNPCtrade->GetIsShow())
  {
	frmNPCtrade->Close();
  }
}
