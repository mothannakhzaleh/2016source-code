
#include "stdafx.h"
#include "UICookingForm.h"
#include "uiformmgr.h"
#include "UIGoodsGrid.h"
#include "uiEquipForm.h"
#include "uiItemCommand.h"
#include "uinpctalkform.h"
#include "uiprogressbar.h"
#include "NetProtocol.h"
#include "packetCmd.h"
#include "GameApp.h"

namespace GUI
{
CCookingMgr::CCookingMgr()
{
}

CCookingMgr::~CCookingMgr()
{
}

void CCookingMgr::ShowCookingForm(bool bShow /* = true*/)
{
  if(frmCooking->GetIsShow())
  {
	return;
  }
  if(bShow)
  {
	bLock = false;
	ClearCommand();
	btnForgeYes->SetIsEnabled(false);
	btnForgeNo->SetIsEnabled(false);
	frmCooking->Show();
  } else
  {
	if(!bLock)
	{
	  frmCooking->Hide();
	}
  }
}

void CCookingMgr::CheckResult(short sRet)
{
  CItemRecord*	pCItemRec	 = NULL;
  CItemCommand* pItemCommand = NULL;
  ClearCommand(true);
  if(sRet >= 0)
  {
	pItemCommand = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(sRet));
	if(pItemCommand)
	{
	  PushItem(6, *pItemCommand, true);
	}
  }
  /*if(g_stUIEquip.GetGoodsGrid()->GetItem(iCookingPos[1]))
		{
			for(int i = 0; i < (COOKING_COUNT - 1); i++)
			{
				if(NO_USE != iCookingPos[i])
				{
					pItemCommand = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(iCookingPos[i]));
					if(pItemCommand)
					{
						if(3 == i)
						{
							int iItem = (dynamic_cast<CItemCommand*>(g_stUICooking.cmdCooking[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_STR);
							if(pItemCommand->GetItemInfo()->lID == iItem)
							{
								PushItem(i, *pItemCommand, true);
							}
						}
						else if(4 == i)
						{
							int iItem = (dynamic_cast<CItemCommand*>(g_stUICooking.cmdCooking[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_CON);
							if(pItemCommand->GetItemInfo()->lID == iItem)
							{
								PushItem(i, *pItemCommand, true);
							}
						}
						else if(5 == i)
						{
							int iItem = (dynamic_cast<CItemCommand*>(g_stUICooking.cmdCooking[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_DEX);
							if(pItemCommand->GetItemInfo()->lID == iItem)
							{
								PushItem(i, *pItemCommand, true);
							}
						}
						else
						{
							PushItem(i, *pItemCommand, true);
						}
					}
					else
					{
						iCookingPos[i] = NO_USE;
					}
				}
			}
		}*/
  btnForgeYes->SetIsEnabled(true);
  btnForgeNo->SetIsEnabled(true);
}

void CCookingMgr::StartTime(short time)
{
  if(!time)
  {
	bLock = false;
	btnForgeYes->SetIsEnabled(true);
	btnForgeNo->SetIsEnabled(true);
	return;
  }
  sTime = time * 1000;
  proCooking->SetRange(0.0f, (float)sTime);
  dwStartTime = g_pGameApp->GetCurTick();
  proCooking->Start(sTime);
}

int CCookingMgr::GetComIndex(COneCommand* oneCommand)
{
  for(int i = 0; i < COOKING_COUNT; i++)
  {
	if(cmdCooking[i] == oneCommand)
	  return i;
  }
  return -1;
}

void CCookingMgr::DragToEquipGrid(int index)
{
  PopItem(index);
}

bool CCookingMgr::Init()
{
  CFormMgr& mgr = CFormMgr::s_Mgr;

  frmCooking = mgr.Find("frmCooking");
  if(!frmCooking)
  {
	LG("gui", "frmCooking not found.\n");
	return false;
  }

  proCooking = dynamic_cast<CProgressBar*>(frmCooking->Find("proCooking"));
  if(!proCooking)
  {
	LG("gui", "frmCooking::proCooking not found.\n");
	return false;
  }
  proCooking->evtTimeArrive = _ProTimeArriveEvt;

  btnForgeYes = dynamic_cast<CTextButton*>(frmCooking->Find("btnForgeYes"));
  if(!btnForgeYes)
  {
	LG("gui", "frmCooking::btnForgeYes not found.\n");
	return false;
  }
  btnForgeYes->SetIsEnabled(false);

  btnForgeNo = dynamic_cast<CTextButton*>(frmCooking->Find("btnForgeNo"));
  if(!btnForgeNo)
  {
	LG("gui", "frmCooking::btnForgeNo not found.\n");
	return false;
  }
  btnForgeNo->SetIsEnabled(false);

  char buff[32] = {0};
  for(int i = 0; i < COOKING_COUNT; i++)
  {
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "cmdItemBase%i", (i + 1));
	cmdCooking[i] = dynamic_cast<COneCommand*>(frmCooking->Find(buff));
	if(!cmdCooking[i])
	{
	  LG("gui", "frmCooking::%s not found.\n", buff);
	  return false;
	}
	iCookingPos[i] = NO_USE;
  }

  cmdCooking[0]->evtBeforeAccept = _evtDragItemBase1;
  cmdCooking[1]->evtBeforeAccept = _evtDragItemBase2;
  cmdCooking[2]->evtBeforeAccept = _evtDragItemBase3;
  cmdCooking[3]->evtBeforeAccept = _evtDragItemBase4;
  cmdCooking[4]->evtBeforeAccept = _evtDragItemBase5;
  cmdCooking[5]->evtBeforeAccept = _evtDragItemBase6;

  frmCooking->evtClose			   = _evtCloseCooking;
  frmCooking->evtEntrustMouseEvent = _evtbtnForgeYes;
  dwStartTime					   = 0;
  bLock							   = false;
  return true;
}

void CCookingMgr::CloseForm()
{
}

void CCookingMgr::ClearCommand(bool bRetry /* = false*/)
{
  if(bLock)
  {
	return;
  }
  for(int i = 0; i < COOKING_COUNT; i++)
  {
	PopItem(i, bRetry);
  }
  if(proCooking->IsRuning())
  {
	proCooking->Start(0);
  }
  proCooking->SetPosition(0.0f);
}

void CCookingMgr::PopItem(int iIndex, bool bRetry /* = false*/)
{
  //  是否锁定
  if(bLock)
  {
	return;
  }
  // 删除Cmd中的Item，该Item会在PushItem()中由new生成
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(cmdCooking[iIndex]->GetCommand());
  if(!pItemCommand)
	return;

  cmdCooking[iIndex]->DelCommand(); // 该函数将删除delete Item

  // 将Item相应的物品栏恢复成可用
  CCommandObj* pItem = g_stUIEquip.GetGoodsGrid()->GetItem(iCookingPos[iIndex]);
  if(pItem && (6 != iIndex))
  {
	pItem->SetIsValid(true);
  }

  // 记录Item在物品栏中的位置
  if(!bRetry)
  {
	iCookingPos[iIndex] = NO_USE;
  }
}

void CCookingMgr::PushItem(int iIndex, CItemCommand& rItem, bool bRetry /* = false*/)
{
  if(iIndex < 0 || iIndex >= COOKING_COUNT)
	return;

  //  是否锁定
  if(bLock)
  {
	return;
  }
  // 判断道具是否可以拖
  if(!rItem.GetIsValid())
  {
	return;
  }

  // 查看原来的Cmd中是否已经有Item了，如果有则移出
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(cmdCooking[iIndex]->GetCommand());
  if(pItemCommand)
  {
	PopItem(iIndex);
  }

  // 记录Item在物品栏中的位置
  if(!bRetry)
  {
	iCookingPos[iIndex] = g_stUIEquip.GetGoodsGrid()->GetDragIndex();
  }

  if(6 != iIndex)
  {
	// 将Item相应的物品栏灰调
	rItem.SetIsValid(false);
  }

  // 将创建的Item放入Cmd中，这里用new将会在PopItem()中删除
  CItemCommand* pItemCmd = new CItemCommand(rItem);
  pItemCmd->SetIsValid(true);
  cmdCooking[iIndex]->AddCommand(pItemCmd);

  SetCookingUI();
}

void CCookingMgr::SetCookingUI()
{
  btnForgeYes->SetIsEnabled(true);
  btnForgeNo->SetIsEnabled(true);
}

void CCookingMgr::_evtbtnForgeYes(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string szName = pSender->GetName();
  if(szName == "btnForgeYes")
  {
	g_stUICooking.btnForgeYes->SetIsEnabled(false);
	//CS_LifeSkill(3, g_stUINpcTalk.GetNpcId());
	CS_Cooking(g_stUINpcTalk.GetNpcId(), g_stUICooking.iCookingPos, (COOKING_COUNT - 1), 0, true);
	g_stUICooking.bLock = true;
  } else if(szName == "btnForgeNo")
  {
	if(g_stUICooking.proCooking->IsRuning())
	{
	  g_stUICooking.proCooking->Start(0);
	  g_stUICooking.dwEndTime = g_pGameApp->GetCurTick();
	  DWORD Percent			  = g_stUICooking.dwEndTime - g_stUICooking.dwStartTime;
	  Percent				  = (DWORD)((float)((float)Percent / (float)g_stUICooking.sTime) * 100);
	  CS_Cooking(g_stUINpcTalk.GetNpcId(), g_stUICooking.iCookingPos, (COOKING_COUNT - 1), (short)Percent);
	  g_stUICooking.bLock = false;
	}
  }
}

void CCookingMgr::_evtCloseCooking(CForm* pForm, bool& IsClose)
{
  if(g_stUICooking.bLock)
  {
	IsClose = true;
	return;
  }
  g_stUICooking.ClearCommand();
  CS_UnlockCharacter();
}

void CCookingMgr::_ProTimeArriveEvt(CGuiData* pSender)
{
  g_stUICooking.proCooking->SetPosition((float)g_stUICooking.sTime);
  CS_Cooking(g_stUINpcTalk.GetNpcId(), g_stUICooking.iCookingPos, (COOKING_COUNT - 1), 100);
  g_stUICooking.bLock = false;
}

void CCookingMgr::_evtDragItemBase1(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  if(!g_stUICooking.cmdCooking[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  //	Modify by alfred.shi begin
  if((pItemCommand->GetItemInfo()->lID != 6529 && pItemCommand->GetItemInfo()->lID != 6530 && pItemCommand->GetItemInfo()->lID != 6531))
	if(/*pItemCommand->GetItemInfo()->sType != 41 && */ (pItemCommand->GetItemInfo()->lID != 6529 && pItemCommand->GetItemInfo()->lID != 6530 && pItemCommand->GetItemInfo()->lID != 6531))
	{
	  return;
	}
  //	End

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICooking.PushItem(0, *pItemCommand);
}

void CCookingMgr::_evtDragItemBase2(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  if(pItemCommand->GetItemInfo()->lID != 2302)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICooking.PushItem(1, *pItemCommand);
}

void CCookingMgr::_evtDragItemBase3(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  if(!g_stUICooking.cmdCooking[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  if(pItemCommand->GetItemInfo()->lID != 1067)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICooking.PushItem(2, *pItemCommand);
}

void CCookingMgr::_evtDragItemBase4(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  //  材料1
  if(!g_stUICooking.cmdCooking[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  int iItem = (dynamic_cast<CItemCommand*>(g_stUICooking.cmdCooking[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_STR);
  if(pItemCommand->GetItemInfo()->lID != iItem)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICooking.PushItem(3, *pItemCommand);
}

void CCookingMgr::_evtDragItemBase5(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  //  材料2
  if(!g_stUICooking.cmdCooking[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  int iItem = (dynamic_cast<CItemCommand*>(g_stUICooking.cmdCooking[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_CON);
  if(pItemCommand->GetItemInfo()->lID != iItem)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICooking.PushItem(4, *pItemCommand);
}

void CCookingMgr::_evtDragItemBase6(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  //  材料3
  if(!g_stUICooking.cmdCooking[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  /* int iItem = (dynamic_cast<CItemCommand*>(g_stUICooking.cmdCooking[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_DEX);
        if(pItemCommand->GetItemInfo()->lID != iItem)
        {
            return;
        }*/

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICooking.PushItem(5, *pItemCommand);
}
}; // namespace GUI
