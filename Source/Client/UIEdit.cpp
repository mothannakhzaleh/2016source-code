#include "Stdafx.h"
#include "UIEdit.h"
#include "uiimeinput.h"
#include "uitextparse.h"
#include "uitextbutton.h"
#include "InputBox.h"

using namespace GUI;

LETexRect CEdit::_CursorImage;

DWORD CEdit::_dwLastUpdateTick = 0;
bool  CEdit::_bCursorIsShow	   = false;
int	  CEdit::_nCursorX		   = 0;
int	  CEdit::_nCursorY		   = 0;

CEdit::CEdit(CForm& frmOwn) :
	CCompent(frmOwn), _bIsPassWord(false), _bIsMulti(false), _bIsDigit(false), _bIsWrap(false), _nOffset(0), _nMaxNum(64), _nMaxNumVisible(64), _nFontHeight(24), _nMaxLineNum(0), _nCursorCol(0), _nCursorFirstCol(0), _nCursorSecondCol(0), _nCursorRow(0), _bParseText(false), _color(COLOR_BLACK), evtKeyDown(NULL), evtKeyChar(NULL), _nLeftMargin(0), _nTopMargin(2), evtEnter(NULL), evtChange(NULL), _pEnterButton(NULL), _nCursorColor(COLOR_BLACK)
{
  _IsFocus = true;
  _pImage  = new CGuiPic(this);
}

CEdit::CEdit(const CEdit& rhs) :
	CCompent(rhs), _pImage(new CGuiPic(*rhs._pImage))
{
  _Copy(rhs);
}

CEdit& CEdit::operator=(const CEdit& rhs)
{
  CCompent::operator=(rhs);

  *_pImage = *rhs._pImage;

  _Copy(rhs);
  return *this;
}

CEdit::~CEdit(void)
{
  //delete _pImage;
  SAFE_DELETE(_pImage); // UI当机处理
}

void CEdit::_Copy(const CEdit& rhs)
{
  evtEnter	 = rhs.evtEnter;
  evtKeyDown = rhs.evtKeyDown;
  evtKeyChar = rhs.evtKeyChar;
  evtChange	 = rhs.evtChange;

  _color	   = rhs._color;
  _nLeftMargin = rhs._nLeftMargin;
  _nTopMargin  = rhs._nTopMargin;
  _bParseText  = rhs._bParseText;

  _str			  = rhs._str;
  _strVisible	  = rhs._strVisible;
  _nMaxNum		  = rhs._nMaxNum;
  _nMaxNumVisible = rhs._nMaxNumVisible;
  _bIsPassWord	  = rhs._bIsPassWord;
  _bIsMulti		  = rhs._bIsMulti;
  _bIsDigit		  = rhs._bIsDigit;
  _bIsWrap		  = rhs._bIsWrap;
  _nOffset		  = rhs._nOffset;

  _nFontHeight		= rhs._nFontHeight;
  _nMaxLineNum		= rhs._nMaxLineNum;
  _nCursorRow		= rhs._nCursorRow;
  _nCursorCol		= rhs._nCursorCol;
  _nCursorFirstCol	= rhs._nCursorFirstCol;
  _nCursorSecondCol = rhs._nCursorSecondCol;

  _pEnterButton = rhs._pEnterButton;
}

bool CEdit::OnKeyDown(int key)
{
  if(!IsNormal()) return false;

  if(evtKeyDown) evtKeyDown(this, key);

  return false;

  const char* s = _str.c_str();
  switch(key)
  {
  case VK_LEFT:
  {
	//begin:处理表情
	if(_nCursorCol >= 3)
	{
	  if(!(s[_nCursorCol - 1] & 0x80))
	  {
		if(isdigit(s[_nCursorCol - 1]) && _nCursorCol >= 3)
		{
		  if(isdigit(s[_nCursorCol - 2]) && (s[_nCursorCol - 3] == '#'))
		  {
			_nCursorCol -= 3;
			break;
		  }
		}
	  }
	}
	//end:处理表情

	--_nCursorCol;
	if(_str[_nCursorCol] & 0x80) --_nCursorCol;
	if(_nCursorCol <= 0)
	{
	  _nCursorCol = 0;
	  if((int)_str.length() >= _nMaxNumVisible) //移动所有字符
	  {
		_strVisible = GetSelfString(_str, _nMaxNumVisible, true);
	  }
	}
	break;
  }
  case VK_RIGHT:
	if(_str.length() == 0) return false;
	break;
  case VK_UP:
	if(!GetIsMulti()) return false;

	break;
  case VK_DOWN:
	if(!GetIsMulti()) return false;

	break;
  case VK_HOME:
  {
	RefreshCursor();
  }
  break;
  case VK_END:
  {
	RefreshCursor();
	break;
  }
  case VK_PRIOR: // pageup
	if(!GetIsMulti()) return false;

	break;
  case VK_NEXT: // pagedown
	if(!GetIsMulti()) return false;

	break;
  case VK_DELETE:
	_Delete();
	break;
  default:
	return false;
  }

  _GetCursorPos(_nCursorCol);
  return true;
}

#include "resource.h"

void CEdit::RefreshCursor()
{
  _nCursorCol = g_InputBox.RefreshCursor();
  _GetCursorPos(_nCursorCol);
}

void CEdit::RefreshText()
{
  _str		  = g_InputBox.RefreshText();
  _strVisible = _str;
}

void CEdit::ClearText()
{
  g_InputBox.ClearText();
}

bool CEdit::OnChar(char c)
{
  if(!IsNormal()) return false;

  if(evtKeyChar && !evtKeyChar(this, c)) return true;

  switch(c)
  {
  case 0: return true;
  case '\r': // 回车
	if(_pEnterButton)
	{
	  _pEnterButton->DoClick();
	  return false;
	}

	if(!GetIsMulti())
	{
#ifdef _KOSDEMO_
	  this->SetNullFocus(); //回车后将焦点失去
#endif
	  if(evtEnter && !_str.empty()) evtEnter(this); // 单行Edit,执行默认方法
	} else
	{
	  _nCursorCol = 0;
	  _nCursorRow++;
	}
	break;
  case '\t':
	break;
  case 3: // copy
	if(!GetIsPassWord())
	  _Copy();
	break;
  case 22: // paste
	_Paste();
	break;
  case 24: // cut
	if(!GetIsPassWord())
	  _Cut();
	break;
  case 27: // ESC
	break;

  case '\b': // 退格
  default:
	if(GetIsMulti())
	{
	}
  }
  _GetCursorPos(_nCursorCol);

  if(GetIsDigit() && !_isdigit(c))
  {
	return true;
  }

  if(evtChange) evtChange(this);
  return false;
}

bool CEdit::_IsCursorInHZ(long l, char* s)
{
  return false;
}

void CEdit::_Copy()
{
  RefreshCursor();
}

void CEdit::_Paste()
{
}

void CEdit::_Cut()
{
}

void CEdit::_Delete() //删除当前字符
{
}

void CEdit::_UpdataLines()
{
  if(GetIsMulti())
  {
  }
}

void CEdit::CorrectCursor()
{
  if(_bIsWrap)
  {
	int cursorPos = CGuiFont::s_Font.GetWidth("S") * _nCursorCol;
	if(_nOffset + GetWidth() - 5 < cursorPos)
	{
	  _nOffset = cursorPos - GetWidth() + 5;
	} else if(_nOffset > cursorPos)
	{
	  _nOffset = cursorPos;
	} else if(_nOffset > 0 && _nOffset + GetWidth() - 5 > CGuiFont::s_Font.GetWidth("S") * (int)(_str.length()))
	{
	  _nOffset = CGuiFont::s_Font.GetWidth("S") * (int)(_str.length()) - GetWidth() + 5;
	  if(_nOffset < 0) _nOffset = 0;
	}
  } else
  {
	_nOffset = 0;
  }
}

void CEdit::Render()
{
  if(GetActive() == this)
  {
	CorrectCursor();
	ShowFocus();
  }
  GetRender().SetClipRect(GetX(), GetY(), GetWidth(), GetHeight());

  if(!GetIsPassWord())
  {
	if(_bParseText)
	{
	  if((int)_str.size() > _nMaxNumVisible)
	  {
		g_TextParse.Render(_strVisible, GetX() - _nOffset, GetY(), _color);
	  } else
	  {
		g_TextParse.Render(_str, GetX() - _nOffset, GetY(), _color);
	  }
	} else
	{
	  if((int)_str.size() > _nMaxNumVisible)
	  {
		CGuiFont::s_Font.Render((char*)_strVisible.c_str(), GetX() - _nOffset, GetY(), _color);
	  } else
	  {
		CGuiFont::s_Font.Render((char*)_str.c_str(), GetX() - _nOffset, GetY(), _color);
	  }
	}
  } else
  {
	// 计算字符个数，并显示相同个数的*号  added by billy
	char* cPassWord = new char[_nMaxNum + 1];
	memset(cPassWord, 0, _nMaxNum + 1);
	int length = (int)strlen((char*)_str.c_str());

	for(int i = 0; i < length; i++)
	  cPassWord[i] = '*';

	CGuiFont::s_Font.Render((char*)cPassWord, GetX() - _nOffset, GetY(), _color);
	//	_pImage->Render( GetX(), GetY() );

	//delete [] cPassWord;
	SAFE_DELETE_ARRAY(cPassWord); // UI当机处理
  }

  GetRender().Reset();
}

void CEdit::Init()
{
  // Modify by lark.li 20090219 begin
  //_nCursorHeight = CGuiFont::s_Font.GetHeight( "好" ) - 2;
  _nCursorHeight = CGuiFont::s_Font.GetHeight(RES_STRING(CL_MAIN_CPP_00001)) - 2;
  // End

  if(_pEnterButton && _pEnterButton->GetForm() != GetForm())
  {
	_pEnterButton = dynamic_cast<CTextButton*>(GetForm()->Find(_pEnterButton->GetName()));
  }
}

void CEdit::Refresh()
{
  CCompent::Refresh();
  _pImage->Refresh();

  if(GetActive() == this)
  {
	_GetCursorPos(_nCursorCol);
	OnActive();
  }
}

void CEdit::_GetCursorPos(int nCurPos)
{
  int cx = 0;
  if(GetIsMulti())
  {
	_nCursorY = GetY() + _nCursorRow * _nFontHeight;
  } else
  {
	_nCursorY = GetY() + _nTopMargin;
	cx		  = CGuiFont::s_Font.GetWidth(_str.substr(0, nCurPos).c_str());
	cx -= _nOffset;
  }
  _nCursorX = (int)GetRender().DrawConvertX2((float)cx) + GetX(); //added by billy

  //光标正在移动时总是显示 -Waiting Add 2009-05-27
  static int s_nLastCursorX = 0;
  static int s_nLastCursorY = 0;
  if(s_nLastCursorX != _nCursorX || s_nLastCursorY != _nCursorY)
  {
	_dwLastUpdateTick = g_dwCurFrameTick;
	_bCursorIsShow	  = true;
	s_nLastCursorX	  = _nCursorX;
	s_nLastCursorY	  = _nCursorY;
  }

  CImeInput::s_Ime.SetShowPos(_nCursorX, _nCursorY + _nFontHeight);
}

//void CEdit::SetFocusEdit( CEdit* v )
//{
//    if( _pFocusEdit==v ) return;
//
//    if( v )
//    {
//        if( !v->GetForm()->GetIsShow() || !v->IsNormal() ) return;
//
//        v->_GetCursorPos(v->_nCursorCol);
//    }
//
//	_pFocusEdit=v;
//}

void CEdit::SetCaption(const char* str)
{
  if(GetActive() == this)
  {
	//	if(strlen(str) <= this->GetMaxNum()) // Add by lark.li 20080820
	if((int)strlen(str) <= this->GetMaxNum())
	{
	  g_InputBox.SetText(str);
	  g_InputBox.SetCursorTail();
	  RefreshText();
	  RefreshCursor();
	}
  } else
  {
	_str		= str;
	_nCursorCol = (int)_str.length();
  }
  if(evtChange) evtChange(this);
}

void CEdit::OnLost()
{
  RefreshCursor();
}

void CEdit::OnActive()
{
  CCompent::OnActive();

  g_InputBox.SetIsDigit(_bIsDigit);

  ::SetWindowPos(g_InputBox.GetEditWindow(), 0, GetX(), GetY(), 10000, 50, SWP_NOOWNERZORDER | SWP_NOREDRAW | SWP_HIDEWINDOW);

  //SetFocusEdit( this );
  g_InputBox.SetMaxNum(_nMaxNum);
  g_InputBox.SetText(_str.c_str());

  if(!GetIsMulti() && _nCursorCol >= 0 && _nCursorCol <= (int)(strlen(_str.c_str())))
  {
	g_InputBox.SetSel(_nCursorCol, _nCursorCol);
  }

  //::SendMessage( g_InputEdit, EM_SETLIMITTEXT, 10000, 0 );

  //g_InputBox.SetCursorTail();
}

void CEdit::SetAlpha(BYTE alpha)
{
  _pImage->SetAlpha(alpha);
  _color = (_color & 0x00ffffff) & (alpha << 24);
}

void CEdit::SetTextColor(DWORD color)
{
  _color = color;
}

void CEdit::ReplaceSel(const char* str, BOOL bCanUndo)
{
  if(GetActive() == this)
  {
	g_InputBox.ReplaceSel(str);
  }
}
