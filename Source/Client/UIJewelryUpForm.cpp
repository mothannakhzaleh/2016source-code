#include "stdafx.h"
#include "uijewelryupform.h"

#include "gameapp.h"
#include "scene.h"
#include "uiequipform.h"
#include "uifastcommand.h"
#include "uigoodsgrid.h"
#include "uiitemcommand.h"
#include "uilabel.h"
#include "uiboxform.h"
#include "stoneset.h"
#include "character.h"
#include "packetcmd.h"
#include "uihelpinfoform.h"

using namespace GUI;

CForm*		 CJewelryUpMgr::frmJewelryUp;
COneCommand* CJewelryUpMgr::cmdJewelry;
int			 CJewelryUpMgr::JewelryGridID;
short		 CJewelryUpMgr::JewelryUpSelection = -1;

bool CJewelryUpMgr::Init()
{
  frmJewelryUp = _FindForm("frmJewelryUp");
  if(!frmJewelryUp)
	return false;

  frmJewelryUp->evtShow	 = evtJewelryUpFormShow;
  frmJewelryUp->evtClose = evtJewelryUpFormClose;

  cmdJewelry				  = static_cast<COneCommand*>(frmJewelryUp->Find("cmdElf0"));
  cmdJewelry->evtBeforeAccept = evtSetJewelryEvent;
  cmdJewelry->SetActivePic(NULL);

  char CtrlName[32] = {0};
  for(int i = 0; i < NUM_SLOT; ++i)
  {
	_snprintf_s(CtrlName, _countof(CtrlName), _TRUNCATE, "txtJewelryUp%d", i + 1);
	txtJewelryUp[i] = dynamic_cast<CLabelEx*>(frmJewelryUp->Find(CtrlName));
	if(!txtJewelryUp[i])
	{
	  LG("gui", "frmFindTeam:%s not found.", txtJewelryUp);

	  return false;
	}

	_snprintf_s(CtrlName, _countof(CtrlName), _TRUNCATE, "BtnJewelryUp%d", i + 1);
	BtnJewelryUp[i] = dynamic_cast<CTextButton*>(frmJewelryUp->Find(CtrlName));
	if(!BtnJewelryUp[i])
	{
	  LG("gui", "frmFindTeam:%s not found.", BtnJewelryUp);

	  return false;
	}

	BtnJewelryUp[i]->evtMouseClick = evtJewelryUpCommit;
  }

  labGold = dynamic_cast<CLabelEx*>(frmJewelryUp->Find("labGold"));

  JewelryGridID = -1;

  return true;
}

void CJewelryUpMgr::ShowConfirmDialog(long OldJeyID, long OldJeyLev, long NewJeyID, long NewJeyLev)
{
  char szBuf[256] = {0};

  CItemRecord* pNewStoneInfo = GetItemRecordInfo(NewJeyID);
  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_990),
			  NewJeyLev, pNewStoneInfo->szName);
  g_stUIBox.ShowSelectBox(evtConfirmEvent, szBuf, true);
}

void CJewelryUpMgr::Clear()
{
  PopItem();
}

void CJewelryUpMgr::PushItem(CItemCommand& Item)
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdJewelry->GetCommand());
  if(pItemCommand)
	PopItem();

  JewelryGridID = g_stUIEquip.GetGoodsGrid()->GetDragIndex();
  Item.SetIsValid(false);

  CItemCommand* pNewItemCommand = new CItemCommand(Item);
  pNewItemCommand->SetIsValid(true);
  cmdJewelry->AddCommand(pNewItemCommand);

  SItemForge& ItemForgeInfo = pNewItemCommand->GetForgeInfo();

  char szBuf[64];

  int TotalMoney = 0;

  for(int i = 0; i < ItemForgeInfo.nStoneNum && i < ItemForgeInfo.nHoleNum; ++i)
  {
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_656),
				std::to_string(ItemForgeInfo.nStoneLevel[i]).c_str(),
				ItemForgeInfo.pStoneInfo[i]->szDataName);
	txtJewelryUp[i]->SetCaption(szBuf);

	TotalMoney += ItemForgeInfo.nStoneLevel[i] * COST_PER_LEVEL;
  }

  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", TotalMoney);
  labGold->SetCaption(szBuf);
}

void CJewelryUpMgr::PopItem()
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdJewelry->GetCommand());
  if(pItemCommand)
	cmdJewelry->DelCommand();

  CCommandObj* pCommandObj = g_stUIEquip.GetGoodsGrid()->GetItem(JewelryGridID);
  if(pCommandObj)
	pCommandObj->SetIsValid(true);

  for(int i = 0; i < NUM_SLOT; ++i)
	txtJewelryUp[i]->SetCaption("");

  labGold->SetCaption("0");

  JewelryGridID		 = -1;
  JewelryUpSelection = -1;
}

void CJewelryUpMgr::evtJewelryUpFormShow(CGuiData* pSender)
{
  g_stJewelryUpForm.Clear();
}

void CJewelryUpMgr::evtJewelryUpFormClose(CForm* pForm, bool& IsClose)
{
  g_stJewelryUpForm.Clear();
  IsClose = false;
}

void CJewelryUpMgr::evtSetJewelryEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  isAccept = false;

  CGameScene* pScene = g_pGameApp->GetCurScene();
  if(!pScene)
	return;

  CCharacter* pCha = pScene->GetMainCha();
  if(!pCha)
	return;

  CGoodsGrid* pGood = static_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;

  COneCommand* pCmd = static_cast<COneCommand*>(pSender);
  if(!pCmd)
	return;

  CItemCommand* pItemCommand = static_cast<CItemCommand*>(pItem);
  if(!pItemCommand)
	return;

  char buf[256] = {0};
  if(pCmd->nTag != 999)
  {
	CItemRecord* pItemRecord = pItemCommand->GetItemInfo();
	if(pCmd == cmdJewelry)
	{
	  if(pItemRecord->sType == 1 || pItemRecord->sType == 2 || pItemRecord->sType == 3 ||
		 pItemRecord->sType == 4 || pItemRecord->sType == 7 || pItemRecord->sType == 9 ||
		 pItemRecord->sType == 22 || pItemRecord->sType == 23 || pItemRecord->sType == 24 || pItemRecord->sType == 27)
		g_stJewelryUpForm.PushItem(*pItemCommand);
	  else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_989));
		g_pGameApp->MsgBox(buf);
	  }
	}
  }
}

void CJewelryUpMgr::evtJewelryUpCommit(CGuiData* pSender, int x, int y, DWORD key)
{
  char buf[256] = {0};

  if(!cmdJewelry->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_1012));
	g_pGameApp->MsgBox(buf);
	return;
  }

  CGameScene* pScene = g_pGameApp->GetCurScene();
  if(!pScene)
	return;

  CCharacter* pCha = pScene->GetMainCha();
  if(!pCha)
	return;

  LONG64 OwnedMoney = pCha->getGameAttr()->get(ATTR_GD);

  SItemForge& ItemForgeInfo = static_cast<CItemCommand*>(
								  cmdJewelry->GetCommand())
								  ->GetForgeInfo();
  int TotalMoney = 0;
  for(int i = 0; i < ItemForgeInfo.nStoneNum && i < ItemForgeInfo.nHoleNum; ++i)
	TotalMoney += ItemForgeInfo.nStoneLevel[i] * COST_PER_LEVEL;

  if(OwnedMoney < TotalMoney)
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_459));
	g_pGameApp->MsgBox(buf);
	return;
  }

  for(short index = 0; index < NUM_SLOT; ++index)
  {
	if(pSender == g_stJewelryUpForm.BtnJewelryUp[index])
	{
	  if(index >= ItemForgeInfo.nStoneNum || index >= ItemForgeInfo.nHoleNum)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_1013));
		g_pGameApp->MsgBox(buf);
		return;
	  }

	  if(!(ItemForgeInfo.pStoneInfo[index]->nItemID >= 860 &&
		   ItemForgeInfo.pStoneInfo[index]->nItemID <= 863) ||
		 ItemForgeInfo.pStoneInfo[index]->nItemID == 1012)
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_1014));
		g_pGameApp->MsgBox(buf);
		return;
	  }

	  JewelryUpSelection = index + 1;
	  CS_JewelryUpAsk(0, JewelryGridID, index + 1);
	  break;
	}
  }
}

void CJewelryUpMgr::evtConfirmEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType == CForm::mrYes)
	CS_JewelryUpAsk(1, JewelryGridID, JewelryUpSelection);

  g_stJewelryUpForm.Clear();
  frmJewelryUp->Close();
}

void CJewelryUpMgr::evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key)
{
  g_FormHelpInfo.ShowHelpInfo(!g_FormHelpInfo.IsShown(), "");
}
