#include "stdafx.h"
#include "uibakghostform.h"

#include "gameapp.h"
#include "scene.h"
#include "uiequipform.h"
#include "uifastcommand.h"
#include "uigoodsgrid.h"
#include "uiitemcommand.h"
#include "PacketCmd.h"
#include "uihelpinfoform.h"

using namespace GUI;

int			 CBakGhostMgr::HATCH_SPIRITE_ID = 11;
COneCommand* CBakGhostMgr::cmdRequirement[2];
int			 CBakGhostMgr::RequirementGridIDs[2];
CTextButton* CBakGhostMgr::btnHatch;

bool CBakGhostMgr::Init()
{
  frmBakGhost = _FindForm("frmBakGhost");
  if(!frmBakGhost)
	return false;

  frmBakGhost->evtShow	= evtBakGhostFormShow;
  frmBakGhost->evtClose = evtBakGhostFormClose;

  memset(cmdRequirement, 0x0, sizeof(cmdRequirement));
  cmdRequirement[0] = static_cast<COneCommand*>(frmBakGhost->Find("cmdBakGhost0"));
  cmdRequirement[1] = static_cast<COneCommand*>(frmBakGhost->Find("cmdBakGhost1"));
  for(int i = 0; i < 2; i++)
  {
	if(cmdRequirement[i])
	{
	  cmdRequirement[i]->evtBeforeAccept = evtRequirementEvent;
	  cmdRequirement[i]->SetActivePic(NULL);
	}
  }

  btnHatch = static_cast<CTextButton*>(frmBakGhost->Find("btnComplete"));
  if(!btnHatch)
	return false;
  btnHatch->evtMouseClick = evtCreateSpirite;

  CTextButton* btnHelp = static_cast<CTextButton*>(frmBakGhost->Find("btnHelp"));
  if(!btnHelp)
	return false;
  btnHelp->evtMouseClick = evtShowHelpInfo;

  return true;
}

void CBakGhostMgr::Clear()
{
  for(int Index = 0; Index < REQUIRED_ITEM_COUNT; ++Index)
	PopItem(Index);
}

void CBakGhostMgr::PushItem(int Index, CItemCommand& Item)
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdRequirement[Index]->GetCommand());
  if(pItemCommand)
	PopItem(Index);

  RequirementGridIDs[Index] = g_stUIEquip.GetGoodsGrid()->GetDragIndex();
  Item.SetIsValid(false);

  CItemCommand* pNewItemCommand = new CItemCommand(Item);
  pNewItemCommand->SetIsValid(true);
  cmdRequirement[Index]->AddCommand(pNewItemCommand);
}

void CBakGhostMgr::PopItem(int Index)
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdRequirement[Index]->GetCommand());
  if(pItemCommand)
	cmdRequirement[Index]->DelCommand();

  CCommandObj* pCommandObj = g_stUIEquip.GetGoodsGrid()->GetItem(RequirementGridIDs[Index]);
  if(pCommandObj)
	pCommandObj->SetIsValid(true);

  RequirementGridIDs[Index] = -1;
}

void CBakGhostMgr::CreateSpiriteResponse(bool Success)
{
  if(Success)
  {
	Clear();
	frmBakGhost->Close();
  } else
  {
	char buf[256] = {0};
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_979));
	g_pGameApp->MsgBox(buf);
  }
}

void CBakGhostMgr::evtBakGhostFormShow(CGuiData* pSender)
{
  g_stBakGhostForm.Clear();
}

void CBakGhostMgr::evtBakGhostFormClose(CForm* pForm, bool& IsClose)
{
  g_stBakGhostForm.Clear();
  g_FormHelpInfo.ShowHelpInfo(false, "");
  IsClose = false;
}

void CBakGhostMgr::evtRequirementEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
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
	if(pCmd == cmdRequirement[0])
	{
	  if(pItemRecord->sType == 59)
		g_stBakGhostForm.PushItem(0, *pItemCommand);
	  else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_977));
		g_pGameApp->MsgBox(buf);
	  }
	} else if(pCmd == cmdRequirement[1])
	{
	  if(pItemRecord->sType == 78)
		g_stBakGhostForm.PushItem(1, *pItemCommand);
	  else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_978));
		g_pGameApp->MsgBox(buf);
	  }
	}
  }
}

void CBakGhostMgr::evtCreateSpirite(CGuiData* pSender, int x, int y, DWORD key)
{
  char buf[256] = {0};

  if(!cmdRequirement[0]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_977));
	g_pGameApp->MsgBox(buf);
	return;
  }

  if(!cmdRequirement[1]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_978));
	g_pGameApp->MsgBox(buf);
	return;
  }

  CS_ItemForgeAsk(true, HATCH_SPIRITE_ID, RequirementGridIDs, 2);
}

void CBakGhostMgr::evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key)
{
  g_FormHelpInfo.ShowHelpInfo(!g_FormHelpInfo.IsShown(), "bakghost");
}