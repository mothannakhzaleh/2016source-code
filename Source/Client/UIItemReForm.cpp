#include "stdafx.h"
#include "uiitemreform.h"

#include "gameapp.h"
#include "scene.h"
#include "uiequipform.h"
#include "uifastcommand.h"
#include "uigoodsgrid.h"
#include "uiitemcommand.h"
#include "PacketCmd.h"
#include "uihelpinfoform.h"

using namespace GUI;

int			 CItemReMgr::ITEM_RESET_ID = 13;
COneCommand* CItemReMgr::cmdRequirement[3];
int			 CItemReMgr::RequirementGridIDs[3];
CTextButton* CItemReMgr::btnAccept;

bool CItemReMgr::Init()
{
  frmItemRe = _FindForm("frmItemRe");
  if(!frmItemRe)
	return false;

  frmItemRe->evtClose = evtItemReFormClose;

  memset(cmdRequirement, 0x0, sizeof(cmdRequirement));
  cmdRequirement[0] = static_cast<COneCommand*>(frmItemRe->Find("cmdElf0"));
  cmdRequirement[1] = static_cast<COneCommand*>(frmItemRe->Find("cmdStore1"));
  cmdRequirement[2] = static_cast<COneCommand*>(frmItemRe->Find("cmdEquip2"));
  for(int i = 0; i < REQUIRED_ITEM_COUNT; i++)
  {
	if(cmdRequirement[i])
	{
	  cmdRequirement[i]->evtBeforeAccept = evtRequirementEvent;
	  cmdRequirement[i]->SetActivePic(NULL);
	}
  }

  btnAccept = static_cast<CTextButton*>(frmItemRe->Find("btnYes"));
  if(!btnAccept)
	return false;
  btnAccept->evtMouseClick = evtItemReset;

  CTextButton* btnHelp = static_cast<CTextButton*>(frmItemRe->Find("btnHelp"));
  if(!btnHelp)
	return false;
  btnHelp->evtMouseClick = evtShowHelpInfo;

  return true;
}

void CItemReMgr::ShowItemRe(bool bShow)
{
  Clear();

  if(bShow)
	frmItemRe->Show();
  else
	frmItemRe->Close();
}

void CItemReMgr::Clear()
{
  for(int Index = 0; Index < REQUIRED_ITEM_COUNT; ++Index)
	PopItem(Index);
}

void CItemReMgr::PushItem(int Index, CItemCommand& Item)
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

void CItemReMgr::PopItem(int Index)
{
  CItemCommand* pItemCommand = static_cast<CItemCommand*>(cmdRequirement[Index]->GetCommand());
  if(pItemCommand)
	cmdRequirement[Index]->DelCommand();

  CCommandObj* pCommandObj = g_stUIEquip.GetGoodsGrid()->GetItem(RequirementGridIDs[Index]);
  if(pCommandObj)
	pCommandObj->SetIsValid(true);

  RequirementGridIDs[Index] = -1;
}

void CItemReMgr::ItemResetResponse(bool Success)
{
  Clear();
  frmItemRe->Close();

  if(!Success)
  {
	char buf[256] = {0};
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_988));
	g_pGameApp->MsgBox(buf);
  }
}

void CItemReMgr::evtItemReFormClose(CForm* pForm, bool& IsClose)
{
  g_stItemReForm.Clear();
  g_FormHelpInfo.ShowHelpInfo(false, "");
  IsClose = false;
}

void CItemReMgr::evtRequirementEvent(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
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
		g_stItemReForm.PushItem(0, *pItemCommand);
	  else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_985));
		g_pGameApp->MsgBox(buf);
	  }
	} else if(pCmd == cmdRequirement[1])
	{
	  if(pItemRecord->sType == 27 || pItemRecord->sType <= 24)
		g_stItemReForm.PushItem(1, *pItemCommand);
	  else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_986));
		g_pGameApp->MsgBox(buf);
	  }
	} else if(pCmd == cmdRequirement[2])
	{
	  if(pItemRecord->sType == 80)
		g_stItemReForm.PushItem(2, *pItemCommand);
	  else
	  {
		_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_987));
		g_pGameApp->MsgBox(buf);
	  }
	}
  }
}

void CItemReMgr::evtItemReset(CGuiData* pSender, int x, int y, DWORD key)
{
  char buf[256] = {0};

  if(!cmdRequirement[0]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_985));
	g_pGameApp->MsgBox(buf);
	return;
  }

  if(!cmdRequirement[1]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_986));
	g_pGameApp->MsgBox(buf);
	return;
  }

  if(!cmdRequirement[2]->GetCommand())
  {
	_snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_987));
	g_pGameApp->MsgBox(buf);
	return;
  }

  CS_ItemForgeAsk(true, ITEM_RESET_ID, RequirementGridIDs, REQUIRED_ITEM_COUNT);
}

void CItemReMgr::evtShowHelpInfo(CGuiData* pSender, int x, int y, DWORD key)
{
  g_FormHelpInfo.ShowHelpInfo(!g_FormHelpInfo.IsShown(), "itemre");
}