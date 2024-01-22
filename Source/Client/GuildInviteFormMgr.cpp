#include "StdAfx.h"
#include "UIGlobalVar.h"
#include "uiformmgr.h"
#include "uilabel.h"
#include "uicloneform.h"
#include "procirculate.h"
#include "packetcmd.h"
#include ".\GuildInviteFormMgr.h"

static CCloneForm						 dupe;
CGuildInviteFormMgr						 g_GuilInviteFormMgr;
vector<CGuildInviteFormMgr::PS_FormNode> CGuildInviteFormMgr::m_FormLink;

CGuildInviteFormMgr::CGuildInviteFormMgr(void)
{
}

CGuildInviteFormMgr::~CGuildInviteFormMgr(void)
{
}

bool CGuildInviteFormMgr::AddInviteForm(DWORD id, string inviterName)
{
  if(GetInviteForm(id)) return false;
  PS_FormNode	node			= new S_FormNode;
  static CForm* frmAcceptManage = CFormMgr::s_Mgr.Find("frmAcceptManage");
  if(!frmAcceptManage)
  {
	//delete node;
	SAFE_DELETE(node); // UI当机处理
	return false;
  }
  node->id			= id;
  node->inviterName = inviterName;
  dupe.SetSample(frmAcceptManage);
  node->pForm = dupe.Clone();
  char str[256];
  _snprintf_s(str, _countof(str), _TRUNCATE, "frmAcceptManage_Arcol_%d", id);
  node->pForm->SetName(str);
  m_FormLink.push_back(node);
  //node->pForm->SetPos(200,200);
  CLabelEx* labManageName = dynamic_cast<CLabelEx*>(node->pForm->Find("labManageName"));
  if(labManageName)
  {
	_snprintf_s(str, _countof(str), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_62), inviterName.data());
	//labManageName->SetIsCenter(true);
	labManageName->SetCaption(str);
  }
  CLabelEx* labManage = dynamic_cast<CLabelEx*>(node->pForm->Find("labManage"));
  if(labManage)
  {
	//labFrnd->SetIsCenter(true);
	labManage->SetCaption(RES_STRING(CL_LANGUAGE_MATCH_1036));
  }
  node->pForm->evtEntrustMouseEvent = _MainMousePlayerGuildEvent;
  node->pForm->nTag					= id;
  static int PosY					= 100;
  PosY += 10;
  if(PosY > 150) PosY = 100;
  node->pForm->SetPos(10, PosY);
  node->pForm->Refresh();
  node->pForm->Show();
  return true;
}

bool CGuildInviteFormMgr::RemoveInviteForm(DWORD id)
{
  PS_FormNode					node = NULL;
  vector<PS_FormNode>::iterator Iter;
  for(Iter = m_FormLink.begin(); Iter != m_FormLink.end(); Iter++)
	if((*Iter)->id == id)
	{
	  node = *Iter;
	  break;
	}
  if(!node) return false;
  node->pForm->Close();
  node->pForm->nTag = 0;
  dupe.Release(node->pForm);
  m_FormLink.erase(Iter);
  //delete node;
  SAFE_DELETE(node); // UI当机处理
  return true;
}

CGuildInviteFormMgr::PS_FormNode CGuildInviteFormMgr::GetInviteForm(DWORD id)
{
  vector<PS_FormNode>::iterator Iter;
  for(Iter = m_FormLink.begin(); Iter != m_FormLink.end(); Iter++)
	if((*Iter)->id == id)
	  return *Iter;
  return NULL;
}

void CGuildInviteFormMgr::_MainMousePlayerGuildEvent(CCompent* pSender, int nMsgType, int x, int y, DWORD dwKey)
{
  CProCirculateCS* proCir = (CProCirculateCS*)g_NetIF->GetProCir();
  string		   name	  = pSender->GetName();
  if(name == "btnNo" || name == "btnClose")
  {
	proCir->RefuseGuildInviteConfirm((DWORD)pSender->GetForm()->nTag);
  } else if(name == "btnYes")
  {
	proCir->AcceptGuildInviteConfirm((DWORD)pSender->GetForm()->nTag);
  }
  g_stGuildInviteFormMgr.RemoveInviteForm(pSender->GetForm()->nTag);
}