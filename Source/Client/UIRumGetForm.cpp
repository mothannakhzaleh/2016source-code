#include "stdafx.h"
#include "uirumdealform.h"
#include "uirumgetform.h"
#include "uitextbutton.h"
#include "PacketCmd.h"
#include "gameapp.h"

using namespace GUI;

bool CRumGetMgr::Init()
{
#ifndef SHUI_JING
  return true;
#endif

  frmRumGet = _FindForm("frmRumGet");
  if(!frmRumGet)
	return false;

  editMoeny2Get = dynamic_cast<CEdit*>(frmRumGet->Find("edtID"));
  if(!editMoeny2Get)
	return false;
  editMoeny2Get->SetIsDigit(true);

  CTextButton* btnDeal01 = static_cast<CTextButton*>(frmRumGet->Find("btnDeal01"));
  if(!btnDeal01)
	return false;
  btnDeal01->evtMouseClick = evtGetFlatMoney;

  return true;
}

void CRumGetMgr::ShowRumGetForm(bool bShow)
{
  if(bShow)
  {
	editMoeny2Get->SetCaption("");
	frmRumGet->ShowModal();
  } else
	frmRumGet->Close();
}

void CRumGetMgr::evtGetFlatMoney(CGuiData* pSender, int x, int y, DWORD key)
{
  const char* FlatMoney = g_stRumGetForm.editMoeny2Get->GetCaption();
  LONG64	  Money		= _atoi64(FlatMoney);

  if(Money > g_stRumDealForm.GoldCoins)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_997));
	return;
  } else if(Money == 0)
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_1040));
	return;
  }

  CS_RequestGetFlatMoney(Money);
  g_stRumGetForm.ShowRumGetForm(false);
}
