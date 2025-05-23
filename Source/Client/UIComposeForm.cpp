
#include "stdafx.h"
#include "UIComposeForm.h"
#include "uiformmgr.h"
#include "UIGoodsGrid.h"
#include "uiEquipForm.h"
#include "uiItemCommand.h"
#include "uinpctalkform.h"
#include "uiprogressbar.h"
#include "NetProtocol.h"
#include "packetCmd.h"
#include "GameApp.h"
#include "uiedit.h"
#include <stdlib.h>

namespace GUI
{
char* g_prompt[] = {"Thankyou",
					"Abysmal",
					"Terrible",
					"Bad",
					"Poor",
					"Mediocre",
					"Fair",
					"Good",
					"Great",
					"Superb",
					"Perfect"};

CComposeMgr::CComposeMgr()
{
}

CComposeMgr::~CComposeMgr()
{
}

void CComposeMgr::ShowComposeForm(bool bShow /* = true*/)
{
  if(frmCompose->GetIsShow())
  {
	return;
  }
  if(bShow)
  {
	bLock = false;
	bRnd  = false;
	ClearCommand();
	lTimes = 1;
	edtNumInput->SetCaption("1");
	btnForgeYes->SetIsEnabled(false);
	btnForgeNo->SetIsEnabled(false);
	frmCompose->Show();
  } else
  {
	if(!bLock)
	{
	  frmCompose->Hide();
	}
  }
}

void CComposeMgr::CheckResult(short sRet, const char* txt)
{
  bRnd	= false;
  bLock = false;
  labInput->SetCaption(g_prompt[atoi(txt) - 1]);

  CItemCommand* pItemCommand = NULL;
  ClearCommand(true);
  if(sRet > 0)
  {
	pItemCommand = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(sRet));
	if(pItemCommand)
	{
	  PushItem(6, *pItemCommand, true);
	}
  }
  /*if(g_stUIEquip.GetGoodsGrid()->GetItem(iComposePos[1]))
		{
			for(int i = 0; i < (COMPOSE_COUNT - 1); i++)
			{
				if(NO_USE != iComposePos[i])
				{
					pItemCommand = dynamic_cast<CItemCommand*>(g_stUIEquip.GetGoodsGrid()->GetItem(iComposePos[i]));
					if(pItemCommand)
					{
						if(3 == i)
						{
							int iItem = (dynamic_cast<CItemCommand*>(g_stUICompose.cmdCompose[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_STR);
							if(pItemCommand->GetItemInfo()->lID == iItem)
							{
								PushItem(i, *pItemCommand, true);
							}
						}
						else if(4 == i)
						{
							int iItem = (dynamic_cast<CItemCommand*>(g_stUICompose.cmdCompose[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_CON);
							if(pItemCommand->GetItemInfo()->lID == iItem)
							{
								PushItem(i, *pItemCommand, true);
							}
						}
						else if(5 == i)
						{
							int iItem = (dynamic_cast<CItemCommand*>(g_stUICompose.cmdCompose[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_DEX);
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
						iComposePos[i] = NO_USE;
					}
				}
			}
		}*/
  --lTimes;
  if((sRet > 0) && (lTimes > 0))
  {
	char buff[16] = {0};
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "%li", lTimes);
	edtNumInput->SetCaption(buff);
	//CS_LifeSkill(0, g_stUINpcTalk.GetNpcId());
	CS_Compose(g_stUINpcTalk.GetNpcId(), g_stUICompose.iComposePos, (COMPOSE_COUNT - 1), true);
  } else
  {
	btnForgeYes->SetIsEnabled(true);
	btnForgeNo->SetIsEnabled(true);
	lTimes = 1;
	edtNumInput->SetCaption("1");
  }
}

void CComposeMgr::StartTime(short time)
{
  if(!time)
  {
	bLock = false;
	btnForgeYes->SetIsEnabled(true);
	btnForgeNo->SetIsEnabled(true);
	return;
  }
  sTime = time * 1000;
  bRnd	= true;
  proCompose->SetRange(0.0f, (float)sTime);
  proCompose->Start(sTime);
}

int CComposeMgr::GetComIndex(COneCommand* oneCommand)
{
  for(int i = 0; i < COMPOSE_COUNT; i++)
  {
	if(cmdCompose[i] == oneCommand)
	  return i;
  }
  return -1;
}

void CComposeMgr::DragToEquipGrid(int index)
{
  PopItem(index);
}

bool CComposeMgr::Init()
{
  CFormMgr& mgr = CFormMgr::s_Mgr;

  frmCompose = mgr.Find("frmCompose");
  if(!frmCompose)
  {
	LG("gui", "frmCompose not found.\n");
	return false;
  }

  labInput = dynamic_cast<CLabelEx*>(frmCompose->Find("labCharOutput"));
  if(!labInput)
  {
	LG("gui", "frmCompose::labCharOutput not found.\n");
	return false;
  }

  edtNumInput = dynamic_cast<CEdit*>(frmCompose->Find("edtNumInput"));
  if(!edtNumInput)
  {
	LG("gui", "frmCompose::edtNumInput not found.\n");
	return false;
  }
  edtNumInput->SetCaption("1");

  proCompose = dynamic_cast<CProgressBar*>(frmCompose->Find("proCompose"));
  if(!proCompose)
  {
	LG("gui", "frmCompose::proCompose not found.\n");
	return false;
  }
  proCompose->evtTimeArrive = _ProTimeArriveEvt;

  btnForgeYes = dynamic_cast<CTextButton*>(frmCompose->Find("btnForgeYes"));
  if(!btnForgeYes)
  {
	LG("gui", "frmCompose::btnForgeYes not found.\n");
	return false;
  }
  btnForgeYes->SetIsEnabled(false);

  btnForgeNo = dynamic_cast<CTextButton*>(frmCompose->Find("btnForgeNo"));
  if(!btnForgeNo)
  {
	LG("gui", "frmCompose::btnForgeNo not found.\n");
	return false;
  }
  btnForgeNo->SetIsEnabled(false);

  char buff[32] = {0};
  for(int i = 0; i < COMPOSE_COUNT; i++)
  {
	_snprintf_s(buff, _countof(buff), _TRUNCATE, "cmdItemBase%i", (i + 1));
	cmdCompose[i] = dynamic_cast<COneCommand*>(frmCompose->Find(buff));
	if(!cmdCompose[i])
	{
	  LG("gui", "frmCompose::%s not found.\n", buff);
	  return false;
	}
	iComposePos[i] = NO_USE;
  }

  cmdCompose[0]->evtBeforeAccept = _evtDragItemBase1;
  cmdCompose[1]->evtBeforeAccept = _evtDragItemBase2;
  cmdCompose[2]->evtBeforeAccept = _evtDragItemBase3;
  cmdCompose[3]->evtBeforeAccept = _evtDragItemBase4;
  cmdCompose[4]->evtBeforeAccept = _evtDragItemBase5;
  cmdCompose[5]->evtBeforeAccept = _evtDragItemBase6;

  frmCompose->evtClose			   = _evtCloseCompose;
  frmCompose->evtEntrustMouseEvent = _evtbtnForgeYes;

  srand(g_pGameApp->GetCurTick());

  sTime = 1;
  bLock = false;
  bRnd	= false;
  return true;
}

void CComposeMgr::CloseForm()
{
}

void CComposeMgr::ClearCommand(bool bRetry /* = false*/)
{
  if(bLock)
  {
	return;
  }
  for(int i = 0; i < COMPOSE_COUNT; i++)
  {
	PopItem(i, bRetry);
  }
  if(proCompose->IsRuning())
  {
	proCompose->Start(0);
  }
  proCompose->SetPosition(0.0f);
}

void CComposeMgr::PopItem(int iIndex, bool bRetry /* = false*/)
{
  //  是否锁定
  if(bLock)
  {
	return;
  }
  // 删除Cmd中的Item，该Item会在PushItem()中由new生成
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(cmdCompose[iIndex]->GetCommand());
  if(!pItemCommand)
	return;

  cmdCompose[iIndex]->DelCommand(); // 该函数将删除delete Item

  // 将Item相应的物品栏恢复成可用
  CCommandObj* pItem = g_stUIEquip.GetGoodsGrid()->GetItem(iComposePos[iIndex]);
  if(pItem && (6 != iIndex))
  {
	pItem->SetIsValid(true);
  }

  // 记录Item在物品栏中的位置
  if(!bRetry)
  {
	iComposePos[iIndex] = NO_USE;
  }
}

void CComposeMgr::PushItem(int iIndex, CItemCommand& rItem, bool bRetry /* = false*/)
{
  if(iIndex < 0 || iIndex >= COMPOSE_COUNT)
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
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(cmdCompose[iIndex]->GetCommand());
  if(pItemCommand)
  {
	PopItem(iIndex);
  }

  // 记录Item在物品栏中的位置
  if(!bRetry)
  {
	iComposePos[iIndex] = g_stUIEquip.GetGoodsGrid()->GetDragIndex();
  }
  if(6 != iIndex)
  {
	// 将Item相应的物品栏灰调
	rItem.SetIsValid(false);
  }

  // 将创建的Item放入Cmd中，这里用new将会在PopItem()中删除
  CItemCommand* pItemCmd = new CItemCommand(rItem);
  pItemCmd->SetIsValid(true);
  cmdCompose[iIndex]->AddCommand(pItemCmd);

  SetComposeUI();
}

void CComposeMgr::SetComposeUI()
{
  //      CItemCommand* pItem1 = dynamic_cast<CItemCommand*>(cmdCompose[0]->GetCommand());
  //CItemCommand* pItem2 = dynamic_cast<CItemCommand*>(cmdCompose[1]->GetCommand());
  //      CItemCommand* pItem3 = dynamic_cast<CItemCommand*>(cmdCompose[2]->GetCommand());
  //      CItemCommand* pItem4 = dynamic_cast<CItemCommand*>(cmdCompose[3]->GetCommand());
  //      CItemCommand* pItem5 = dynamic_cast<CItemCommand*>(cmdCompose[4]->GetCommand());
  //      CItemCommand* pItem6 = dynamic_cast<CItemCommand*>(cmdCompose[5]->GetCommand());

  //if ((NULL == pItem1) || (NULL == pItem2) || (NULL == pItem3) || (NULL == pItem4) || (NULL == pItem5) || (NULL == pItem6))
  //{
  //	btnForgeYes->SetIsEnabled(false);
  //	return;
  //}

  btnForgeYes->SetIsEnabled(true);
  btnForgeNo->SetIsEnabled(true);
}

void CComposeMgr::FrameMove(DWORD dwTime)
{
  if(bRnd)
  {
	static char buff[16] = {0};
	if(frmCompose && frmCompose->GetIsShow())
	{
	  DWORD dwCurrTickCount = g_pGameApp->GetCurTick();

	  if(dwCurrTickCount - m_dwLastTickCount > ERNIE_SPEED)
	  {
		m_dwLastTickCount = dwCurrTickCount;

		int rnd = 0;
		rnd		= rand() % 11;
		labInput->SetCaption(g_prompt[rnd]);
	  }
	}
  }
}

void CComposeMgr::_evtbtnForgeYes(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string szName = pSender->GetName();
  if(szName == "btnForgeYes")
  {
	g_stUICompose.lTimes = atol(g_stUICompose.edtNumInput->GetCaption());
	if(g_stUICompose.lTimes <= 0)
	{
	  g_stUICompose.lTimes = 1;
	}
	g_stUICompose.btnForgeYes->SetIsEnabled(false);
	//CS_LifeSkill(0, g_stUINpcTalk.GetNpcId());
	CS_Compose(g_stUINpcTalk.GetNpcId(), g_stUICompose.iComposePos, (COMPOSE_COUNT - 1), true);
	g_stUICompose.bLock = true;
  } else if(szName == "btnForgeNo")
  {
	if(g_stUICompose.proCompose->IsRuning())
	{
	  g_stUICompose.proCompose->Start(0);
	  CS_Compose(g_stUINpcTalk.GetNpcId(), g_stUICompose.iComposePos, (COMPOSE_COUNT - 1));
	  g_stUICompose.bLock = false;
	}
  } else if(szName == "btnLeftPage")
  {
	if(g_stUICompose.lTimes > 1)
	{
	  char buff[16] = {0};
	  --g_stUICompose.lTimes;
	  //	   g_stUICompose.edtNumInput->SetCaption(itoa(g_stUICompose.lTimes, buff, 10));
	  _itoa_s(g_stUICompose.lTimes, buff, sizeof(buff), 10);
	  g_stUICompose.edtNumInput->SetCaption(buff);
	}
  } else if(szName == "btnRightPage")
  {
	char buff[16] = {0};
	++g_stUICompose.lTimes;
	//	 g_stUICompose.edtNumInput->SetCaption(itoa(g_stUICompose.lTimes, buff, 10));
	_itoa_s(g_stUICompose.lTimes, buff, sizeof(buff), 10);
	g_stUICompose.edtNumInput->SetCaption(buff);
  }
}

void CComposeMgr::_evtCloseCompose(CForm* pForm, bool& IsClose)
{
  if(g_stUICompose.bLock)
  {
	IsClose = true;
	return;
  }
  g_stUICompose.ClearCommand();
  CS_UnlockCharacter();
}

void CComposeMgr::_ProTimeArriveEvt(CGuiData* pSender)
{
  g_stUICompose.proCompose->SetPosition((float)g_stUICompose.sTime);
  CS_Compose(g_stUINpcTalk.GetNpcId(), g_stUICompose.iComposePos, (COMPOSE_COUNT - 1));
  g_stUICompose.bLock = false;
}

void CComposeMgr::_evtEnterEvent(CGuiData* pSender)
{
  if(g_stUICompose.proCompose->IsRuning())
  {
	g_stUICompose.proCompose->Start(0);
	CS_Compose(g_stUINpcTalk.GetNpcId(), g_stUICompose.iComposePos, (COMPOSE_COUNT - 1));
	g_stUICompose.bLock = false;
  }
}

void CComposeMgr::_evtDragItemBase1(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  if(!g_stUICompose.cmdCompose[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  //	Modify by alfred.shi
  //if(pItemCommand->GetItemInfo()->sType != 59)
  if((pItemCommand->GetItemInfo()->lID != 6529 && pItemCommand->GetItemInfo()->lID != 6530 && pItemCommand->GetItemInfo()->lID != 6531))
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICompose.PushItem(0, *pItemCommand);
}

void CComposeMgr::_evtDragItemBase2(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  if(pItemCommand->GetItemInfo()->lID != 2300)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICompose.PushItem(1, *pItemCommand);
}

void CComposeMgr::_evtDragItemBase3(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  if(!g_stUICompose.cmdCompose[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  if(pItemCommand->GetItemInfo()->lID != 1068)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICompose.PushItem(2, *pItemCommand);
}

void CComposeMgr::_evtDragItemBase4(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  //  材料1
  if(!g_stUICompose.cmdCompose[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  int iItem = (dynamic_cast<CItemCommand*>(g_stUICompose.cmdCompose[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_STR);
  if(pItemCommand->GetItemInfo()->lID != iItem)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICompose.PushItem(3, *pItemCommand);
}

void CComposeMgr::_evtDragItemBase5(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  //  材料2
  if(!g_stUICompose.cmdCompose[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  int iItem = (dynamic_cast<CItemCommand*>(g_stUICompose.cmdCompose[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_CON);
  if(pItemCommand->GetItemInfo()->lID != iItem)
  {
	return;
  }

  CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
  if(pGood != g_stUIEquip.GetGoodsGrid())
	return;
  g_stUICompose.PushItem(4, *pItemCommand);
}

void CComposeMgr::_evtDragItemBase6(CGuiData* pSender, CCommandObj* pItem, bool& isAccept)
{
  //  材料3
  if(!g_stUICompose.cmdCompose[1]->GetCommand())
  {
	g_pGameApp->MsgBox(RES_STRING(CL_LANGUAGE_MATCH_896));
	return;
  }
  CItemCommand* pItemCommand = dynamic_cast<CItemCommand*>(pItem);
  if(!pItemCommand || !pItemCommand->GetIsValid())
	return;
  /* int iItem = (dynamic_cast<CItemCommand*>(g_stUICompose.cmdCompose[1]->GetCommand()))->GetData().GetInstAttr(ITEMATTR_VAL_DEX);
        if(pItemCommand->GetItemInfo()->lID != iItem)
        {
            return;
        }

        CGoodsGrid* pGood = dynamic_cast<CGoodsGrid*>(CDrag::GetParent());
        if( pGood != g_stUIEquip.GetGoodsGrid() )
            return;
        g_stUICompose.PushItem(5, *pItemCommand);*/
}

}; // namespace GUI
