#include "StdAfx.h"
#include "UIPKDialog.h"
#include "NetProtocol.h"
#include "UIFormMgr.h"
#include "UILabel.h"
#include "UIForm.h"
#include "PacketCmd.h"
#include "UIListView.h"
#include "UIList.h"
#include "UIItem.h"
#include "GameApp.h"

//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
bool CPkDialog::Init()
{
  CFormMgr& mgr = CFormMgr::s_Mgr;

  { // pk 开始前的对话框
	frmTeamPkStart = mgr.Find("frmTeamPK");
	if(!frmTeamPkStart)
	{
	  LG("gui", RES_STRING(CL_LANGUAGE_MATCH_744));
	  return false;
	}
	frmTeamPkStart->evtEntrustMouseEvent = _MainMousePkStartEvent;
	frmTeamPkStart->SetIsEscClose(false);

	char szBuf[32];
	for(int i(0); i < TEAM_NUM; i++)
	{
	  _snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "lstTeam%d", i);
	  lvStartTeams[i] = dynamic_cast<CListView*>(frmTeamPkStart->Find(szBuf));
	  if(!lvStartTeams[i])
		return Error(RES_STRING(CL_LANGUAGE_MATCH_616),
					 frmTeamPkStart->GetName(),
					 szBuf);

	  CItemRow* pRow(0);
	  CItem*	pItem(0);
	  lvStartTeams[i]->GetList()->GetItems()->Clear();
	  for(int j(0); j < MEM_NUM; j++)
	  {
		pRow = lvStartTeams[i]->GetList()->GetItems()->NewItem();
		for(int k(0); k < S_ITEM_NUM; k++)
		{
		  pItem = new CItem();
		  pItem->SetColor(COLOR_BLACK);
		  pRow->SetIndex(k, pItem);
		}
	  }
	}
  }

  {
	// pk 结束后的对话框
	//frmTeamPkEnd = mgr.Find("frmfrmTeamPkStart");
	//if ( !frmTeamPkEnd)
	//{
	//	LG("gui", "npc.clu中没有定义界面frmfrmTeamPk");
	//	return false;
	//}
	//frmTeamPkEnd->evtEntrustMouseEvent = _MainMousePkEndEvent;

	//char szBuf[32];
	//for (int i(0); i<TEAM_NUM; i++)
	//{
	//	_snprintf_s( szBuf, _countof( szBuf ), _TRUNCATE, "lvEndTeam%d", i);
	//	lvEndTeams[i] = dynamic_cast<CListView*>(frmTeamPkEnd->Find(szBuf));
	//	if (!lvEndTeams[i])
	//		return Error("npc.clu界面<%s>上找不到控件<%s>",
	//					 frmTeamPkEnd->GetName(),
	//					 szBuf);
	//}
  }

  return true;
}

//-----------------------------------------------------------------------------
void CPkDialog::SetStartDialogContent(const stNetTeamFightAsk& sNetTeamFightAsk)
{
  ClearStartDialog();

  int iLeftNum	= static_cast<int>(sNetTeamFightAsk.chSideNum1);
  int iRightNum = static_cast<int>(sNetTeamFightAsk.chSideNum2);

  char szBuf[128];
  for(int i(0); i < iLeftNum; i++)
  {
	lvStartTeams[TEAM_LEFT]->GetList()->GetItems()->GetItem(i)->GetIndex(0)->SetString(sNetTeamFightAsk.Info[i].szName);
	lvStartTeams[TEAM_LEFT]->GetList()->GetItems()->GetItem(i)->GetIndex(1)->SetString(sNetTeamFightAsk.Info[i].szJob);
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", static_cast<int>(sNetTeamFightAsk.Info[i].chLv));
	lvStartTeams[TEAM_LEFT]->GetList()->GetItems()->GetItem(i)->GetIndex(2)->SetString(szBuf);
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", static_cast<int>(sNetTeamFightAsk.Info[i].usVictoryNum));
	lvStartTeams[TEAM_LEFT]->GetList()->GetItems()->GetItem(i)->GetIndex(3)->SetString(szBuf);
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", static_cast<int>(sNetTeamFightAsk.Info[i].usFightNum));
	lvStartTeams[TEAM_LEFT]->GetList()->GetItems()->GetItem(i)->GetIndex(4)->SetString(szBuf);
  }

  iRightNum = static_cast<int>(sNetTeamFightAsk.chSideNum2);
  iLeftNum	= static_cast<int>(sNetTeamFightAsk.chSideNum1);
  for(int i(0); i < iRightNum; i++)
  {
	lvStartTeams[TEAM_RIGHT]->GetList()->GetItems()->GetItem(i)->GetIndex(0)->SetString(sNetTeamFightAsk.Info[i + iLeftNum].szName);
	lvStartTeams[TEAM_RIGHT]->GetList()->GetItems()->GetItem(i)->GetIndex(1)->SetString(sNetTeamFightAsk.Info[i + iLeftNum].szJob);
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", static_cast<int>(sNetTeamFightAsk.Info[i + iLeftNum].chLv));
	lvStartTeams[TEAM_RIGHT]->GetList()->GetItems()->GetItem(i)->GetIndex(2)->SetString(szBuf);
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", static_cast<int>(sNetTeamFightAsk.Info[i + iLeftNum].usVictoryNum));
	lvStartTeams[TEAM_RIGHT]->GetList()->GetItems()->GetItem(i)->GetIndex(3)->SetString(szBuf);
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d", static_cast<int>(sNetTeamFightAsk.Info[i + iLeftNum].usFightNum));
	lvStartTeams[TEAM_RIGHT]->GetList()->GetItems()->GetItem(i)->GetIndex(4)->SetString(szBuf);
  }
}

//-----------------------------------------------------------------------------
void CPkDialog::SetEndDialogContent()
{
}

//-----------------------------------------------------------------------------
void CPkDialog::ClearStartDialog()
{
  for(int i(0); i < TEAM_NUM; i++)
  {
	for(int j(0); j < MEM_NUM; j++)
	  for(int k(0); k < S_ITEM_NUM; k++)
		lvStartTeams[i]->GetList()->GetItems()->GetItem(j)->GetIndex(k)->SetString("");
  }
}

//-----------------------------------------------------------------------------
string CPkDialog::ShowStartDialogDebug(const stNetTeamFightAsk& sNetTeamFightAsk)
{
  int iLeftNum	= static_cast<int>(sNetTeamFightAsk.chSideNum1);
  int iRightNum = static_cast<int>(sNetTeamFightAsk.chSideNum2);

  string sShow;
  char	 szBuf[1024];
  for(int i(0); i < iLeftNum; i++)
  {
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%d\t%s\t%s\n", sNetTeamFightAsk.Info[i].chLv, sNetTeamFightAsk.Info[i].szJob, sNetTeamFightAsk.Info[i].szName);
	sShow += szBuf;
  }

  for(int i(0); i < iRightNum; i++)
  {
	_snprintf_s(szBuf, _countof(szBuf), _TRUNCATE, "%s\t%s\t%d\n", sNetTeamFightAsk.Info[i + iLeftNum].szName, sNetTeamFightAsk.Info[i + iLeftNum].szJob, sNetTeamFightAsk.Info[i + iLeftNum].chLv);
	sShow += szBuf;
  }

  return sShow;
}

//-----------------------------------------------------------------------------
void CPkDialog::ClearEndDialog()
{
  for(int i(0); i < TEAM_NUM; i++)
  {
	for(int j(0); j < MEM_NUM; j++)
	  for(int k(0); k < E_ITEM_NUM; k++)
		lvEndTeams[i]->GetList()->GetItems()->GetItem(j)->GetIndex(k)->SetString("");
  }
}

//-----------------------------------------------------------------------------
void CPkDialog::ShowStartDialog(bool bShow)
{
  frmTeamPkStart->SetIsShow(bShow);
}

//-----------------------------------------------------------------------------
void CPkDialog::ShowEndDialog(bool bShow)
{
  frmTeamPkEnd->SetIsShow(bShow);
}

//-----------------------------------------------------------------------------
void CPkDialog::_MainMousePkStartEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();
  //	if ( stricmp ("frmTeamPk", pSender->GetForm()->GetName() ) == 0 )
  if(_stricmp("frmTeamPk", pSender->GetForm()->GetName()) == 0)
  {
	CS_TeamFightAnswer(name == "btnYes");

	g_stUIPKDialog.frmTeamPkStart->Close();
  }
}

//-----------------------------------------------------------------------------
void CPkDialog::_MainMousePkEndEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  string name = pSender->GetName();
  //	if ( stricmp ("frmTeamPk", pSender->GetForm()->GetName() ) == 0 )
  if(_stricmp("frmTeamPk", pSender->GetForm()->GetName()) == 0)
  {
	g_stUIPKDialog.frmTeamPkEnd->Close();
  }
}
