#include "StdAfx.h"
#include "uitextbutton.h"
#include "GameApp.h"
#include "eventsoundset.h"
#include "UIFont.h"
using namespace GUI;

CTextButton* CTextButton::m_pCurButton = NULL; // 当前激活的Button

CTextButton::CTextButton(CForm& frmOwn) :
	CCompent(frmOwn), _isDown(false), _textColor(0xffff0000), _eFormModal(CForm::mrNone), evtMouseClick(NULL), evtMouseDownContinue(NULL), _dwFlashCycle(0), _dwLastClick(0), evtMouseRClick(NULL), evtMouseDBClick(NULL)
{
  _pImage = new CGuiPic(this, csEnd);
}

CTextButton::CTextButton(const CTextButton& rhs) :
	CCompent(rhs), _pImage(new CGuiPic(*rhs._pImage)), _strCaption(rhs._strCaption), _textColor(rhs._textColor), _isDown(rhs._isDown), _eFormModal(rhs._eFormModal), evtMouseClick(rhs.evtMouseClick), evtMouseDownContinue(rhs.evtMouseDownContinue), _dwFlashCycle(0), _dwLastClick(0), evtMouseRClick(NULL), evtMouseDBClick(NULL)
{
  _pImage->SetParent(this);
}

CTextButton& CTextButton::operator=(const CTextButton& rhs)
{
  CCompent::operator=(rhs);

  evtMouseClick		   = rhs.evtMouseClick;
  evtMouseDownContinue = rhs.evtMouseDownContinue;

  _strCaption = rhs._strCaption;
  _textColor  = rhs._textColor;

  *_pImage	  = *(rhs._pImage);
  _isDown	  = rhs._isDown;
  _eFormModal = rhs._eFormModal;

  _pImage->SetParent(this);
  return *this;
}

CTextButton::~CTextButton(void)
{
  //delete _pImage;
  SAFE_DELETE(_pImage); // UI当机处理
}

void CTextButton::SetAlpha(BYTE alpha)
{
  _pImage->SetAlpha(alpha);
}

void CTextButton::Render()
{
  // modify by Philip.Wu  2006-08-09  支持按钮闪烁
  if(_dwFlashCycle > 0 && GetIsEnabled() && (g_pGameApp->GetCurTick() % _dwFlashCycle < _dwFlashCycle / 2))
	_pImage->Render(GetX(), GetY(), BYTE(128));
  else
	_pImage->Render(GetX(), GetY());
  // modify end

  //_pImage->Render( GetX(), GetY() );

  if(!_strCaption.empty()) CGuiFont::s_Font.Render(_strCaption.c_str(), GetX(), GetY(), _textColor);
}

bool CTextButton::MouseRun(int x, int y, DWORD key)
{
  if(!IsNormal()) return false;

  if(IsNoDrag(x, y, key))
  {
	if(key & Mouse_LUp)
	{
	  if(_isDown)
	  {
		_isDown = false;
		_SetState(csNormal);

		if(evtMouseDBClick && GetTickCount() - _dwLastClick < 500) // 两次点击时间少于 500 毫秒，则认定为双击
		{
		  _dwLastClick = 0; // 双击后重置
		  DoClick(Mouse_LDB);
		} else
		{
		  _dwLastClick = GetTickCount(); // 记录下当前点击时间，用于判断下一次点击间隔
		  DoClick();
		}

		return true;
	  }
	  _isDown = false;
	}

	if(key & Mouse_LDown)
	{
	  _isDown = true;
	  _SetState(csDown);
	  return true;
	}

	if(key & Mouse_RUp)
	{
	  DoClick(Mouse_RUp);
	  return true;
	}

	//if( key & Mouse_LDB)	// 貌似不起作用
	//{
	//	DoClick(Mouse_LDB);
	//	return true;
	//}

	_SetState(_isDown ? csDown : csHover);
	return true;
  } else
  {
	_SetState(csNormal);
  }

  return _IsMouseIn;
}

void CTextButton::DoClick(eMouseState state)
{
  g_pGameApp->PlaySound(26);

  // modify by Philip.Wu  2007/01/23  扩展按钮功能，支持右键和双击
  switch(state)
  {
  case Mouse_LUp:
  {
	if(evtMouseClick)
	  evtMouseClick(this, GetX(), GetY(), Mouse_LUp);
	else if(_frmOwn->evtEntrustMouseEvent)
	  _frmOwn->evtEntrustMouseEvent(this, _eFormModal, GetX(), GetY(), Mouse_LUp);
  }
  break;

  case Mouse_RUp:
  {
	if(evtMouseRClick) evtMouseRClick(this, GetX(), GetY(), Mouse_RUp);
  }
  break;

  case Mouse_LDB:
  {
	if(evtMouseDBClick) evtMouseDBClick(this, GetX(), GetY(), Mouse_LDB);
  }
  break;
  }

  if(!_isChild && GetForm())
  {
	GetForm()->SetModalResult(_eFormModal);
	if(_eFormModal != CForm::mrNone)
	{
	  GetForm()->Close();
	  return;
	}
  }
}

void CTextButton::Refresh()
{
  CCompent::Refresh();

  _pImage->Refresh();
}

void CTextButton::_SetState(eButtonState v)
{
  if(_pImage->GetFrame() == v) return;

  switch(v)
  {
  case csNormal:
	break;
  case csHover:
	_ClearOldState();
	break;
  case csDown:
	_ClearOldState();
	break;
  case csDisable:
	break;
  }

  _pImage->SetFrame(v);
}

void CTextButton::_ClearOldState()
{
  if(m_pCurButton && m_pCurButton->GetIsEnabled())
  {
	if(m_pCurButton != this)
	{
	  m_pCurButton->_isDown = false;
	  m_pCurButton->_SetState(csNormal);
	  m_pCurButton = this;
	}
  } else
  {
	m_pCurButton = this;
  }
}

void CTextButton::SetIsEnabled(bool v)
{
  _bEnabled = v;
  _SetState(_bEnabled ? csNormal : csDisable);
}

void CTextButton::FrameMove(DWORD dwTime)
{
  if(!GetIsEnabled()) return;

  if(evtMouseDownContinue && CGameApp::IsMouseContinue(0) && _IsMouseIn)
  {
	evtMouseDownContinue(this);
  }
}
