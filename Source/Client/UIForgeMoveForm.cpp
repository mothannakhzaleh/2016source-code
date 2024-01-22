#include "stdafx.h"
#include "uiforgemoveform.h"

#include "gameapp.h"
#include "scene.h"
#include "uiequipform.h"
#include "uifastcommand.h"
#include "uigoodsgrid.h"
#include "uiitemcommand.h"
#include "uiboxform.h"
#include "PacketCmd.h"
#include "uihelpinfoform.h"

using namespace GUI;

int							 CForgeMoveMgr::FORGE_MOVE_ID = 12;
COneCommand*				 CForgeMoveMgr::cmdRequirement[3];
int							 CForgeMoveMgr::RequirementGridIDs[3];
int							 CForgeMoveMgr::RequirementCounts[3] = {0, 0, 0};
CForgeMoveMgr::ItemputStruct CForgeMoveMgr::Itemput;
CTextButton*				 CForgeMoveMgr::btnYes;

bool CForgeMoveMgr::Init()
{
  frmforgeMove = _FindForm("frmforgeMove");
  if(!frmforgeMove)
	return false;

  frmforgeMove->evtShow	 = evtForgeMoveFormShow;
  frmforgeMove->evtClose = evtForgeMoveFormClose;

  memset(cmdRequirement, 0x0, sizeof(cmdRequirement));
  cmdRequirement[0] = static_cast<COneCommand*>(frmforgeMove->Find("cmdElf0"));
  cmdRequirement[1] = static_cast<COneCommand*>(frmforgeMove->Find("cmdStore1"));
  cmdRequirement[2] = static_cast<COneCommand*>(frmforgeMove->Find("cmdEquip2"));
  for(int i = 0; i < REQUIRED_ITEM_COUNT; i++)
  {
	if(cmdRequirement[i])
	{
	  cmdRequirement[i]->evtBeforeAccept = evtRequirementEvent;
	  cmdRequirement[i]->SetActivePic(NULL);
	}
  }

  btnYes = static_cast<CTextButton*>(frmforgeMove->Find("btnYes"));
  if(!btnYes)
	return false;
  btnYes->evtMouseClick = evtForgeMove;

  CTextButton* btnHelp = static_cast<CTextButton*>(frmforgeMove->Find("btnHelp"));
  if(!btnHelp)
	return false;
  btnHelp->evtMouseClick = evtShowHelpInfo;

  return true;
}

void CForgeMoveMgr::Clear()
{
  for(int Index = 0; Index < REQUIRED_ITEM_COUNT; ++Index)
	PopItem(Index);
}

void CForgeMoveMgr::PushItem(int Index, CItemCommand& Item)
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdRequirement[Index]->GetCommand());
  if(pItemCommand)
	PopItem(Index);

  RequirementGridIDs[Index] = g_stUIEquip.GetGoodsGrid()->GetDragIndex();
  Item.SetIsValid(false);

  CItemCommand* pNewItemCommand = new CItemCommand(Item);
  pNewItemCommand->SetTotalNum(RequirementCounts[Index]);
  pNewItemCommand->SetIsValid(true);
  cmdRequirement[Index]->AddCommand(pNewItemCommand);
}

void CForgeMoveMgr::PopItem(int Index)
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdRequirement[Index]->GetCommand());
  if(pItemCommand)
	cmdRequirement[Index]->DelCommand();

  CCommandObj* pCommandObj = g_stUIEquip.GetGoodsGrid()->GetItem(RequirementGridIDs[Index]);
  if(pCommandObj)
	pCommandObj->SetIsValid(true);

  RequirementGridIDs[Index] = -1;
  RequirementCounts[Index]	= 0;
}

void CForgeMoveMgr::ForgeMoveResponse(bool Success)
{
  Clear();
  frmforgeMove->Close();

  if(!Success)
  {
	char buf[256] = {0};
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_984));
	g_pGameApp->MsgBox(buf);
  }
}

void CForgeMoveMgr::evtForgeMoveFormShow(CGuiData* pSender)
{
  g_stForgeMoveForm.Clear();
}

void CForgeMoveMgr::evtForgeMoveFormClose(CForm* pForm, bool& IsClose)
{
  g_stForgeMoveForm.Clear();
  g_FormHelpInfo.ShowHelpInfo(false, "");
  IsClose = false;
}

void CForgeMoveMgr::evtRequirementEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
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
	CCommandObj* pCommandObj = pGood->GetItem(pGood->GetDragIndex());
	if(pCommandObj->GetTotalNum() > 1)
	{
	  stNumBox* pNumBox = g_stUIBox.ShowNumberBox(evtThrowDialogEvent, pCommandObj->GetTotalNum());
	  if(pNumBox)
	  {
		Itemput.ItemCommand = pItemCommand;
		Itemput.OneCommand	= pCmd;
		pNumBox->pointer	= &Itemput;
		return;
	  }
	}

	CItemRecord* pItemRecord = pItemCommand->GetItemInfo();
	if(pCmd == cmdRequirement[0])
	{
	  if(pItemRecord->sType < 5 || pItemRecord->sType == 7 || pItemRecord->sType == 9 ||
		 pItemRecord->sType == 11 || pItemRecord->sType == 20 || pItemRecord->sType == 27 ||
		 (pItemRecord->sType > 21 && pItemRecord->sType < 25))
	  {
		RequirementCounts[0] = 1;
		g_stForgeMoveForm.PushItem(0, *pItemCommand);
	  } else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_981));
		g_pGameApp->MsgBox(buf);
	  }
	} else if(pCmd == cmdRequirement[1])
	{
	  if(pItemRecord->lID == 6835)
	  {
		RequirementCounts[1] = 1;
		g_stForgeMoveForm.PushItem(1, *pItemCommand);
	  } else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_982));
		g_pGameApp->MsgBox(buf);
	  }
	} else if(pCmd == cmdRequirement[2])
	{
	  if(pItemRecord->sType < 5 || pItemRecord->sType == 7 || pItemRecord->sType == 9 ||
		 pItemRecord->sType == 11 || pItemRecord->sType == 20 || pItemRecord->sType == 27 ||
		 (pItemRecord->sType > 21 && pItemRecord->sType < 25))
	  {
		RequirementCounts[2] = 1;
		g_stForgeMoveForm.PushItem(2, *pItemCommand);
	  } else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_983));
		g_pGameApp->MsgBox(buf);
	  }
	}
  }
}

void CForgeMoveMgr::evtForgeMove(CGuiData* pSender, int x, int y, DWORD key)
{
  char buf[_MAX_PATH] = {0};

  if(!cmdRequirement[0]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_981));
	g_pGameApp->MsgBox(buf);
	return;
  }

  /*	if( !cmdRequirement[1]->GetCommand() )
	{
		_snprintf_s( buf, _countof( buf ), _TRUNCATE, RES_STRING( CL_LANGUAGE_MATCH_982 ) );
		g_pGameApp->MsgBox( buf );
		return;
	}*/

  if(!cmdRequirement[2]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_983));
	g_pGameApp->MsgBox(buf);
	return;
  }

  stNetItemForgeAsk kNetItemForgeAsk;

  kNetItemForgeAsk.chType = FORGE_MOVE_ID;

  for(int i = 0; i < REQUIRED_ITEM_COUNT; ++i)
  {
	kNetItemForgeAsk.SGroup[i].sCellNum		 = RequirementCounts[i] ? 1 : 0; // Ê¼ÖÕÊÇ1
	kNetItemForgeAsk.SGroup[i].pCell		 = new SForgeCell::SCell;
	kNetItemForgeAsk.SGroup[i].pCell->sNum	 = RequirementCounts[i];
	kNetItemForgeAsk.SGroup[i].pCell->sPosID = RequirementGridIDs[i];
  }
  CS_ItemForgeAsk(true, &kNetItemForgeAsk);
}

void CForgeMoveMgr::evtThrowDialogEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  if(nMsgType != CForm::mrYes)
	return;

  stNumBox* pNumBox = (stNumBox*)pSender->GetForm()->GetPointer();
  if(!pNumBox)
	return;

  ItemputStruct* pItemput = (ItemputStruct*)pNumBox->pointer;
  if(!pItemput)
	return;

  PutRequirementEvent(pItemput, pNumBox->GetNumber());
}

void CForgeMoveMgr::PutRequirementEvent(ItemputStruct* pItemput, int ItemCount)
{
  char		   buf[256]	   = {0};
  CItemRecord* pItemRecord = pItemput->ItemCommand->GetItemInfo();

  if(pItemput->OneCommand == cmdRequirement[0])
  {
	if(pItemRecord->sType < 5 || pItemRecord->sType == 7 || pItemRecord->sType == 9 ||
	   pItemRecord->sType == 11 || pItemRecord->sType == 20 || pItemRecord->sType == 27 ||
	   (pItemRecord->sType > 21 && pItemRecord->sType < 25))
	{
	  RequirementCounts[0] = ItemCount;
	  g_stForgeMoveForm.PushItem(0, *pItemput->ItemCommand);
	} else
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_981));
	  g_pGameApp->MsgBox(buf);
	}
  } else if(pItemput->OneCommand == cmdRequirement[1])
  {
	if(pItemRecord->lID == 6835)
	{
	  RequirementCounts[1] = ItemCount;
	  g_stForgeMoveForm.PushItem(1, *pItemput->ItemCommand);
	} else
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_982));
	  g_pGameApp->MsgBox(buf);
	}
  } else if(pItemput->OneCommand == cmdRequirement[2])
  {
	if(pItemRecord->sType < 5 || pItemRecord->sType == 7 || pItemRecord->sType == 9 ||
	   pItemRecord->sType == 11 || pItemRecord->sType == 20 || pItemRecord->sType == 27 ||
	   (pItemRecord->sType > 21 && pItemRecord->sType < 25))
	{
	  RequirementCounts[2] = ItemCount;
	  g_stForgeMoveForm.PushItem(2, *pItemput->ItemCommand);
	} else
	{
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_983));
	  g_pGameApp->MsgBox(buf);
	}
  }
}

void CForgeMoveMgr::evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key)
{
  g_FormHelpInfo.ShowHelpInfo(!g_FormHelpInfo.IsShown(), "frmforgeMove");
}