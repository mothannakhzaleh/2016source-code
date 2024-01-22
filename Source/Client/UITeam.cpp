#include "stdafx.h"
#include "UITeam.h"
#include "UIChat.h"
#include "GuildMemberData.h"
#include "GuildMembersMgr.h"
#include "UIGuildMgr.h"
#include "NetChat.h"
#include "TalkSessionFormMgr.h"
#include "StringLib.h"

using namespace GUI;

CMemberData::CMemberData() :
	_nHp(0), _nSp(0), _nLv(0), _nMaxHp(0), _nMaxSp(0), _bOnline(false),
	_pFace(NULL), _byWork(0), _dwIndex(0)
{
}

CMemberData::~CMemberData()
{
  SAFE_DELETE(_pFace);
}

void CMemberData::SetFace(const stNetTeamChaPart& pFace)
{
  if(!_pFace) _pFace = new stNetTeamChaPart;
  memcpy(_pFace, &pFace, sizeof(stNetTeamChaPart));
}

//---------------------------------------------------------------------------
// CMember
//---------------------------------------------------------------------------

eShowStyle CMember::_nShowStyle = enumShowQQName;

// Modify by lark.li 20080802 begin
//CMember::CMember( CTeam* pTeam, unsigned long id, const char* strName , const char* strMotto, DWORD icon_id)
//: _nID(id), _pData(NULL), _pTeam(pTeam), _strName(strName), _strMotto(strMotto), _pPointer(0), _nIcon_id(icon_id), _strShowName(""), _bFlash(false)
CMember::CMember(CTeam* pTeam, unsigned long id, const char* strName, const char* strMotto, DWORD icon_id, const char* szGroupName) :
	_nID(id), _pData(NULL), _pTeam(pTeam), _strName(strName), _strMotto(strMotto), _pPointer(0), _nIcon_id(icon_id), _strShowName(""), _bFlash(false), _strGroupName(szGroupName), _bIsOnline(false)
// End
{
  if(pTeam->GetStyle() == enumTeamGroup)
  {
	_pData = new CMemberData;
  }
}

CMember::~CMember()
{
  g_stUIChat.TeamSend(enumSTM_DEL_MEMBER, this, _pTeam->GetStyle());

  //if( _pData )
  //{
  //    delete _pData;
  //}
  SAFE_DELETE(_pData); // UI当机处理
}

void CMember::Refresh()
{
  g_stUIChat.TeamSend(enumSTM_NODE_DATA_CHANGE, this, _pTeam->GetStyle());
}

void CMember::SetName(const char* str)
{
  _strName = str;
  g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, this, _pTeam->GetStyle());
}

void CMember::SetMotto(const char* str)
{
  _strMotto = str;
  g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, this, _pTeam->GetStyle());
}

void CMember::SetShowStyle(eShowStyle style)
{
  _nShowStyle = style;
}

void CMember::ModifyAttr(string motto, string job, DWORD dwLv, DWORD nIcon_ID, string guildName)
{
  _strMotto		= motto;
  _strJob		= job;
  _dwLv			= dwLv;
  _nIcon_id		= nIcon_ID;
  _strGuildName = guildName;
  g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, this, _pTeam->GetStyle());
}

void CMember::SetJobName(const char* str)
{
  _strJob = str;
  g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, this, _pTeam->GetStyle());
}

void CMember::SetIconID(DWORD iconId)
{
  _nIcon_id = iconId;
  g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, this, _pTeam->GetStyle());
}

void CMember::SetOnline(bool isOnline)
{
  _bIsOnline = isOnline;
  g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, this, _pTeam->GetStyle());
}

const char* CMember::GetShowName()
{
  _strShowName	  = GetName();
  string strMotto = GetMotto();
  if(!strMotto.empty())
  {
	_strShowName += "(" + strMotto + ")";
  }
  _strShowName = StringLimit(_strShowName, 14);
  return _strShowName.c_str();
}

// Add by rock.wang 2009.05.07 begin
const char* CMember::GetJobNameByID()
{
  return g_GetJobName(short(atoi(_strJob.c_str())));
}
// End

//---------------------------------------------------------------------------
// CTeam
//---------------------------------------------------------------------------
CTeam::CTeam(eTeamStyle nStyle, const char* szName) :
	_eStyle(nStyle), _pPointer(0), _strName(szName), _nCount(0)
{
  g_stUIChat.TeamSend(enumSTM_ADD_GROUP, this, nStyle);
}

CTeam::~CTeam()
{
  Clear();
}

CMember* CTeam::Find(unsigned long nID)
{
  for(members::iterator it = _member.begin(); it != _member.end(); it++)
  {
	if((*it)->GetID() == nID)
	{
	  return *it;
	}
  }
  return NULL;
}

// Modify by lark.li 20080802 begin
//CMember* CTeam::Add( unsigned long nID, const char* szName,const char* szMotto, DWORD icon_id)
CMember* CTeam::Add(unsigned long nID, const char* szName, const char* szMotto, DWORD icon_id, const char* szGroupName, bool onLine)
// End
{
  if(nID > 0)
  {
	_nCount++;
	CMember* tmp;
	string	 strMotto;
	if(szMotto == NULL)
	  strMotto = RES_STRING(CL_LANGUAGE_MATCH_778);
	else
	  strMotto = szMotto;

	// Modify by lark.li 20080802 begin
	//tmp= new CMember( this, nID, szName, strMotto.c_str(),icon_id);
	bool newFrndFG = true;

	tmp = new CMember(this, nID, szName, strMotto.c_str(), icon_id, szGroupName);
	tmp->SetOnline(onLine);
	// End

	CMember* pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamFrnd)->Find(nID);
	if(pMember)
	{
	  // Add by lark.li 20080804 begin
	  newFrndFG = false;
	  // End
	  pMember->SetMotto(strMotto.c_str());
	}
	pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamMaster)->Find(nID);
	if(pMember)
	{
	  pMember->SetMotto(strMotto.c_str());
	}
	pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamPrentice)->Find(nID);
	if(pMember)
	{
	  pMember->SetMotto(strMotto.c_str());
	}
	pMember = g_stUIChat.GetTeamMgr()->Find(enumTeamGroup)->Find(nID);
	if(pMember)
	{
	  pMember->SetMotto(strMotto.c_str());
	}

	CGuildMemberData* pGuildMember = CGuildMembersMgr::FindGuildMemberByID(nID);
	if(pGuildMember)
	{
	  pGuildMember->SetMottoName(szMotto);
	  CTextGraph* pItem = static_cast<CTextGraph*>(pGuildMember->GetPointer());
	  if(pItem)
	  {
		string str = pGuildMember->GetName();
		if(strlen(szMotto) > 0)
		{
		  str += "(" + string(szMotto) + ")";
		}
		pItem->SetHint(str.c_str());
		str = StringLimit(str, 14);
		pItem->SetString(str.c_str());
	  }
	  CUIGuildMgr::RefreshList();
	}
	CTalkSessionFormMgr::RefreshSessionMember(nID, strMotto.c_str());
	_member.push_back(tmp);

	// Add by lark.li 20080804 begin
	if(newFrndFG)
	  AddGroupName(tmp->GetGroupName());
	// End

	g_stUIChat.TeamSend(enumSTM_ADD_MEMBER, tmp, this->GetStyle());
	return tmp;
  }
  return NULL;
}

bool CTeam::Del(unsigned long nID)
{
  for(members::iterator it = _member.begin(); it != _member.end(); it++)
  {
	if((*it)->GetID() == nID)
	{
	  _nCount--;
	  //delete *it;
	  SAFE_DELETE(*it); // UI当机处理
	  _member.erase(it);

	  g_stUIChat.TeamSend(enumSTM_AFTER_DEL_MEMBER, NULL, GetStyle());
	  return true;
	}
  }
  return false;
}

void CTeam::Clear()
{
  _nCount = 0;
  for(members::iterator it = _member.begin(); it != _member.end(); it++)
  {
	//  delete *it;
	SAFE_DELETE(*it); // UI当机处理
  }

  _member.clear();

  // Add by lark.li 20080804 begin
  ClearGroupName();
  // End

  g_stUIChat.TeamSend(enumSTM_DEL_GROUP, this, _eStyle);
}

CMember* CTeam::GetMember(unsigned long nIndex)
{
  if(nIndex >= _nCount)
  {
	return NULL;
  }

  unsigned int n = 0;
  for(members::iterator it = _member.begin(); it != _member.end(); it++)
  {
	if(n == nIndex)
	  return *it;

	n++;
  }
  return NULL;
}

// Add by lark.li 20080804 begin
const char* CTeam::GetGroupName(int index)
{
  //if(index <0 || index >= (_groups.size())
  if(index < 0 || index >= (int)_groups.size())
  {
	return NULL;
  }

  return _groups[index].first.c_str();
}

void CTeam::AddGroupName(const char* szGroupName)
{
  if(strcmp(szGroupName, "") == 0)
  {
	//::MessageBox(NULL,"AddGroupName","NULL",0);

	return;
  }

  bool exsitFG = false;

  for(vector<pair<string, int>>::iterator it = _groups.begin(); it != _groups.end(); it++)
  {
	if(strcmp(it->first.c_str(), szGroupName) == 0)
	{
	  it->second++;
	  exsitFG = true;
	  break;
	}
  }

  if(!exsitFG)
  {
	_groups.push_back(make_pair(szGroupName, 1));

	g_stUIChat.TeamSend(enumSTM_ADD_FRIEND_GROUP, (void*)szGroupName, 0);
  }
}

void CTeam::DelGroupName(const char* szGroupName)
{
  for(vector<pair<string, int>>::iterator it = _groups.begin(); it != _groups.end(); it++)
  {
	if(strcmp(it->first.c_str(), szGroupName) == 0)
	{
	  g_stUIChat.DelFrndGroup(szGroupName);

	  //it->second --;

	  //if(it->second ==0)
	  {
		_groups.erase(it);
		g_stUIChat.TeamSend(enumSTM_DEL_FRIEND_GROUP, (void*)szGroupName, 0);
	  }

	  break;
	}
  }
}

void CTeam::ChangeGroupName(const char* szOldGroupName, const char* szNewGroupName)
{
  for(members::iterator it = _member.begin(); it != _member.end(); it++)
  {
	if(strcmp((*it)->GetGroupName(), szOldGroupName) == 0)
	{
	  (*it)->SetGroupName(szNewGroupName);
	}
  }

  for(vector<pair<string, int>>::iterator it = _groups.begin(); it != _groups.end(); it++)
  {
	if(strcmp(it->first.c_str(), szOldGroupName) == 0)
	{
	  it->first = szNewGroupName;
	  g_stUIChat.ChangeFrndGroup(szOldGroupName, szNewGroupName);

	  break;
	}
  }
}

void CTeam::MoveGroup(unsigned long nID, const char* szOldGroupName, const char* szNewGroupName)
{
  CMember* pMember	= NULL;
  bool	   isOnline = false;

  for(members::iterator it = _member.begin(); it != _member.end(); it++)
  {
	if((*it)->GetID() == nID)
	{
	  pMember  = new CMember(this, (*it)->GetID(), (*it)->GetName(), (*it)->GetMotto(), (*it)->GetIconID(), (*it)->GetGroupName());
	  isOnline = (*it)->IsOnline();

	  _nCount--;
	  //delete *it;
	  SAFE_DELETE(*it); // UI当机处理
	  _member.erase(it);

	  g_stUIChat.TeamSend(enumSTM_AFTER_DEL_MEMBER, NULL, GetStyle());

	  break;
	}
  }

  if(pMember)
  {
	this->Add(pMember->GetID(), pMember->GetName(), pMember->GetMotto(), pMember->GetIconID(), szNewGroupName, isOnline);
  }
}

void CTeam::ClearGroupName()
{
  for(vector<pair<string, int>>::iterator it = _groups.begin(); it != _groups.end(); it++)
  {
	g_stUIChat.DelFrndGroup(it->first.c_str());
  }

  _groups.clear();
}

// End

//---------------------------------------------------------------------------
// CTeamMgr
//---------------------------------------------------------------------------
DWORD CTeamMgr::_dwTeamLeaderID = 0;

CTeamMgr::CTeamMgr()
{
  _pFrndTeam	 = new CTeam(enumTeamFrnd, RES_STRING(CL_LANGUAGE_MATCH_466));
  _pGroupTeam	 = new CTeam(enumTeamGroup, RES_STRING(CL_LANGUAGE_MATCH_299));
  _pRoadTeam	 = new CTeam(enumTeamRoad, RES_STRING(CL_LANGUAGE_MATCH_469));
  _pMasterTeam	 = new CTeam(enumTeamMaster, RES_STRING(CL_LANGUAGE_MATCH_850));
  _pPrenticeTeam = new CTeam(enumTeamPrentice, RES_STRING(CL_LANGUAGE_MATCH_851));
}

CTeamMgr::~CTeamMgr()
{
  SAFE_DELETE(_pFrndTeam);
  SAFE_DELETE(_pGroupTeam);
  SAFE_DELETE(_pRoadTeam);
  SAFE_DELETE(_pMasterTeam);
  SAFE_DELETE(_pPrenticeTeam);
}

CTeam* CTeamMgr::Add(eTeamStyle eTeam, const char* szName)
{
  switch(eTeam)
  {
  case enumTeamFrnd:
  {
	_pFrndTeam->Clear();
	return _pFrndTeam;
  }
  case enumTeamGroup:
  {
	_pGroupTeam->Clear();
	return _pGroupTeam;
  }
  case enumTeamRoad:
  {
	_pRoadTeam->Clear();
	return _pRoadTeam;
  }
  case enumTeamMaster:
  {
	_pMasterTeam->Clear();
	return _pMasterTeam;
  }
  case enumTeamPrentice:
  {
	_pPrenticeTeam->Clear();
	return _pPrenticeTeam;
  }
  }
  return NULL;
}

bool CTeamMgr::Del(eTeamStyle eTeam, const char* szName)
{
  switch(eTeam)
  {
  case enumTeamFrnd:
  {
	_pFrndTeam->Clear();
	return true;
  }
  case enumTeamGroup:
  {
	_dwTeamLeaderID = 0;

	_pGroupTeam->Clear();
	return true;
  }
  case enumTeamRoad:
  {
	_pRoadTeam->Clear();
	return true;
  }
  case enumTeamMaster:
  {
	_pMasterTeam->Clear();
	return true;
  }
  case enumTeamPrentice:
  {
	_pPrenticeTeam->Clear();
	return true;
  }
  }
  return false;
}

CTeam* CTeamMgr::Find(eTeamStyle eTeam, const char* szName)
{
  switch(eTeam)
  {
  case enumTeamFrnd:
  {
	return _pFrndTeam;
  }
  case enumTeamGroup:
  {
	return _pGroupTeam;
  }
  case enumTeamRoad:
  {
	return _pRoadTeam;
  }
  case enumTeamMaster:
  {
	return _pMasterTeam;
  }
  case enumTeamPrentice:
  {
	return _pPrenticeTeam;
  }
  }
  return NULL;
}

void CTeamMgr::ChangeStyle(eShowStyle style)
{
  CMember::SetShowStyle(style);
  for(DWORD i = 0; i < _pFrndTeam->GetCount(); i++)
  {
	DWORD j = _pFrndTeam->GetCount();
	g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, _pFrndTeam->GetMember(i), enumTeamFrnd);
  }
  for(DWORD i = 0; i < _pGroupTeam->GetCount(); i++)
  {
	g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, _pGroupTeam->GetMember(i), enumTeamGroup);
  }
  for(DWORD i = 0; i < _pRoadTeam->GetCount(); i++)
  {
	g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, _pRoadTeam->GetMember(i), enumTeamRoad);
  }
  for(DWORD i = 0; i < _pMasterTeam->GetCount(); i++)
  {
	g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, _pMasterTeam->GetMember(i), enumTeamMaster);
  }
  for(DWORD i = 0; i < _pPrenticeTeam->GetCount(); i++)
  {
	g_stUIChat.TeamSend(enumSTM_NODE_CHANGE, _pPrenticeTeam->GetMember(i), enumTeamPrentice);
  }
}

void CTeamMgr::SceneSwitch()
{
  _pRoadTeam->Clear();
  g_stUIChat._curSelectMember = NULL;
}

void CTeamMgr::ResetAll()
{
  _pRoadTeam->Clear();
  _pGroupTeam->Clear();
  _pFrndTeam->Clear();
  _pMasterTeam->Clear();
  _pPrenticeTeam->Clear();

  g_stUIChat._curSelectMember = NULL;
  g_stUIChat._bForbid		  = false;
}
