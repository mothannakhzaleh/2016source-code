#include "stdafx.h"
#include "uihelpinfoform.h"
#include "helpinfoset.h"
#include "npchelper.h"
#include "worldscene.h"
#include "gameapp.h"
#include "mapset.h"
#include "character.h"
#include "uiboxform.h"
#include "effectobj.h"

using namespace GUI;

bool CHelpInfoMgr::Init()
{
  m_pFormMain = _FindForm("frmHelpchat");
  if(!m_pFormMain)
	return false;

  m_pMemoContent = dynamic_cast<CMemoEx*>(m_pFormMain->Find("memCtrl"));
  if(!m_pMemoContent)
	return false;
  m_pMemoContent->evtClickItem = _ItemClickEvent;
  m_pMemoContent->Refresh();

  return true;
}

void CHelpInfoMgr::ShowHelpInfo(bool show, const char* HelpTitle)
{
  if(show)
  {
	NET_MISPAGE page;
	memset(&page, 0x0, sizeof(page));
	const char* HelpInfo = GetHelpInfo(HelpTitle);
	if(HelpInfo)
	  strncpy_s(page.szDesp, ROLE_MAXNUM_DESPSIZE - 1, GetHelpInfo(HelpTitle), _TRUNCATE);

	m_pMemoContent->Init();
	m_pMemoContent->SetMisPage(page);
	m_pMemoContent->SetIsShow(true);

	m_pFormMain->Show();
  } else
	m_pFormMain->Hide();
}

bool CHelpInfoMgr::IsShown()
{
  return m_pFormMain->GetIsShow();
}

void CHelpInfoMgr::_ItemClickEvent(string strItem)
{
  const char* pStr = strItem.c_str();
  const char* p	   = pStr;
  const char* q;
  char*		  map;
  char*		  x;
  char*		  y;

  bool bmap = false;
  bool bx	= false;
  bool by	= false;

  int index = 0;
  int num	= 0;
  q			= p;
  //	while(( (*p) != '(') && index < strItem.length() )
  while(((*p) != '(') && index < (int)strItem.length())
  {
	num++;
	p++;
	index++;
  }
  if((*p) == '(')
  {
	map = new char[num + 1];
	memcpy(map, q, sizeof(char) * num);
	map[num] = '\0';
	p++;
	index++;
	bmap = true;
  }

  num = 0;
  q	  = p;
  //	while(( (*p) != ',') && index < strItem.length() )
  while(((*p) != ',') && index < (int)strItem.length())
  {
	num++;
	p++;
	index++;
  }
  if((*p) == ',')
  {
	x = new char[num + 1];
	memcpy(x, q, sizeof(char) * num);
	x[num] = '\0';
	p++;
	index++;
	bx = true;
  }

  num = 0;
  q	  = p;
  //while(( (*p) != ')')  && index < strItem.length() )
  while(((*p) != ')') && index < (int)strItem.length())
  {
	num++;
	p++;
	index++;
  }
  if((*p) == ')')
  {
	y = new char[num + 1];
	memcpy(y, q, sizeof(char) * num);
	y[num] = '\0';
	p++;
	index++;
	by = true;
  }

  if(bmap && bx && by && index == strItem.length())
  {
	//check npc is valid or not
	const char* targetmap = NULL;
	if(strcmp((const char*)map, (const char*)RES_STRING(CL_LANGUAGE_MATCH_56)) == 0)
	{
	  targetmap = new char[9];
	  targetmap = RES_STRING(CL_LANGUAGE_MATCH_56);
	} else if(strcmp((const char*)map, (const char*)RES_STRING(CL_LANGUAGE_MATCH_57)) == 0)
	{
	  targetmap = new char[9];
	  targetmap = RES_STRING(CL_LANGUAGE_MATCH_57);
	} else if(strcmp((const char*)map, (const char*)RES_STRING(CL_LANGUAGE_MATCH_58)) == 0)
	{
	  targetmap = new char[9];
	  targetmap = RES_STRING(CL_LANGUAGE_MATCH_58);
	} else if(strcmp((const char*)map, (const char*)RES_STRING(CL_UIMISLOGFORM_CPP_00001)) == 0)
	{
	  targetmap = new char[9];
	  targetmap = RES_STRING(CL_UIMISLOGFORM_CPP_00001);
	} else
	{
	  int nTotalIndex = NPCHelper::I()->GetLastID() + 1;
	  for(int i = 0; i < nTotalIndex; ++i)
	  {
		NPCData* pData = GetNPCDataInfo(i);
		if(p)
		{
		  const char* npc = pData->szName;

		  if(strcmp(npc, map) == 0)
		  {
			if(strcmp(pData->szName, "jialebi") == 0)
			{
			  targetmap = RES_STRING(CL_UIMISLOGFORM_CPP_00002);
			} else
			  targetmap = pData->szMapName;
			break;
		  }
		}
	  }
	}

	CWorldScene* pScene = dynamic_cast<CWorldScene*>(CGameApp::GetCurScene());
	if(!pScene) return;
	const char* curmap = pScene->GetCurMapInfo()->szName;

	if(pScene->GetMainCha()->IsBoat())
	{
	  g_stUIBox.ShowMsgBox(NULL, RES_STRING(CL_UIMISLOGFORM_CPP_00003));
	  return;
	}

	if(targetmap && strcmp((const char*)targetmap, curmap) != 0)
	{
	  g_stUIBox.ShowMsgBox(NULL, RES_STRING(CL_UIMISLOGFORM_CPP_00004));
	  return;
	}

	int cx = (int)pScene->GetMainCha()->GetPos().x;
	int cy = (int)pScene->GetMainCha()->GetPos().y;

	//check x,y is valid or not
	int tx = atoi(x);
	int ty = atoi(y);
	if(tx < 0 || tx > 4096)
	  return;

	if(ty < 0 || ty > 4096)
	  return;

	//if(!g_cFindPathEx.HaveTarget())
	//{
	g_cFindPathEx.Reset();
	g_cFindPathEx.ClearDestDirection();
	g_cFindPathEx.SetDestDirection(cx, cy, tx, ty);
	g_cFindPathEx.SetTarget(cx, cy, tx, ty);
	//}
	D3DXVECTOR3 target((float)tx, (float)ty, 0);
	CNavigationBar::g_cNaviBar.SetTarget((char*)"", target);
	CNavigationBar::g_cNaviBar.Show(true);
  }
}