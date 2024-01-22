#include "StdAfx.h"
#include "UICommand.h"
#include "uifastcommand.h"
#include "GameApp.h"
#include "Scene.h"

using namespace GUI;

//---------------------------------------------------------------------------
// class CCommandObj
//--------------------------------------------------------------------------
CCommandObj* CCommandObj::_pCommand = NULL;
CTextHint	 CCommandObj::_hints;

CCommandObj::~CCommandObj()
{
  if(_nFast > 0) CFastCommand::DelCommand(this);
}

bool CCommandObj::Exec()
{
  if(!CGameApp::GetCurScene() || !CGameScene::GetMainCha()) return false;

  _pCommand = NULL;
  if(IsAllowUse())
  {
	if(IsAtOnce())
	{
	  return _Exec();
	} else
	{
	  if(ReadyUse())
	  {
		_pCommand = this;
		return true;
	  }
	}
  }

  Error();
  return false;
}

bool CCommandObj::_Exec()
{
  bool isUse = true;
  if(GetParent())
  {
	UseComandEvent pEvent = GetParent()->GetUseCommantEvent();
	if(pEvent)
	{
	  pEvent(this, isUse);
	}
  }
  if(isUse)
  {
	return UseCommand();
  } else
  {
	return false;
  }
}

bool CCommandObj::UserExec()
{
  if(_pCommand)
  {
	bool rv	  = _pCommand->_Exec();
	_pCommand = NULL;
	return rv;
  }

  return false;
}

bool CCommandObj::UseCommand()
{
  //  LG( "CCommandObj", "msgTest CCommandObj" );
  return true;
}

void CCommandObj::SetIsFast(bool v)
{
  if(v)
  {
	_nFast++;
  } else
  {
	_nFast--;
  }
}

void CCommandObj::ReadyForHint(int x, int y, CCompent* pCompent)
{
  _hints.Clear();

  SetHintIsCenter(false);
  AddHint(x, y);

  if(GetIsFast() && pCompent)
  {
	CFastCommand* pFast = dynamic_cast<CFastCommand*>(pCompent);
	if(pFast)
	{
	  AddHintHeight();

	  int n = pFast->nTag % 12;

	  char buf[16] = {0};
	  _snprintf_s(buf, _countof(buf), _TRUNCATE, RES_STRING(CL_LANGUAGE_MATCH_492), n + 1);
	  PushHint(buf);
	}
  }

  _hints.ReadyForHint(x, y);
}

void CCommandObj::RenderHint(int x, int y)
{
  _hints.Render();
}
