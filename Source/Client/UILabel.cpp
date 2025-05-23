#include "StdAfx.h"
#include "uilabel.h"
#include "UIFont.h"
using namespace GUI;
//---------------------------------------------------------------------------
// class CLabelEx
//---------------------------------------------------------------------------
CLabel::CLabel(CForm& frmOwn) :
	CCompent(frmOwn), _color(COLOR_BLACK)
{
}

CLabel::CLabel(const CLabel& rhs) :
	CCompent(rhs), _color(rhs._color), _caption(rhs._caption)
{
}

CLabel::~CLabel(void)
{
}

void CLabel::Render()
{
  CGuiFont::s_Font.Render((char*)_caption.c_str(), GetX(), GetY(), _color);
}

//---------------------------------------------------------------------------
// class CLabelEx
//---------------------------------------------------------------------------
CLabelEx::CLabelEx(CForm& frmOwn) :
	CLabel(frmOwn), _IsShadow(true), _clShadow(COLOR_BLACK), _nFontIndex(0), _IsCenter(false), _IsFlash(false)
{
}

CLabelEx::CLabelEx(const CLabelEx& rhs) :
	CLabel(rhs)
{
  _Copy(rhs);
}

void CLabelEx::_Copy(const CLabelEx& rhs)
{
  _IsShadow	  = rhs._IsShadow;
  _clShadow	  = rhs._clShadow;
  _IsCenter	  = rhs._IsCenter;
  _nFontIndex = rhs._nFontIndex;
  _IsFlash	  = rhs._IsFlash;
}

void CLabelEx::Render()
{
  DWORD dwOldShadow = _clShadow; // 保存默认阴影颜色
  DWORD dwOldColor	= _color;	 // 保存下默认的颜色

  if(_IsFlash) // 文字闪烁
  {
	DWORD dwColorID = (GetTickCount() & 1023) >> 8;
	DWORD dwColor	= 0;
	switch(dwColorID)
	{
	case 0:
	  dwColor = 0xFFFF0000;
	  break;
	case 1:
	  dwColor = 0xFF800000;
	  break;
	case 2:
	  dwColor = 0xFF0000FF;
	  break;
	case 3:
	  dwColor = 0xFF000080;
	  break;
	}

	_color = dwColor;
	//_clShadow = dwColor;
  }

  if(_IsShadow)
  {
	if(!_IsCenter)
	{
	  //if(_caption == "白银城")
	  //	CGuiFont::s_Font.BRender( _nFontIndex, "", GetX(), GetY(), _color, _clShadow );
	  //else
	  CGuiFont::s_Font.BRender(_nFontIndex, (const char*)_caption.c_str(), GetX(), GetY(), _color, _clShadow);
	} else
	{
	  int posX = (GetWidth() - CGuiFont::s_Font.GetWidth(_caption.c_str())) / 2;
	  CGuiFont::s_Font.BRender(_nFontIndex, (const char*)_caption.c_str(), GetX() + posX, GetY(), _color, _clShadow);
	}
  } else
  {
	if(!_IsCenter)
	{
	  CGuiFont::s_Font.Render(_nFontIndex, (char*)_caption.c_str(), GetX(), GetY(), _color);
	} else
	{
	  int posX = (GetWidth() - CGuiFont::s_Font.GetWidth(_caption.c_str())) / 2;
	  CGuiFont::s_Font.Render(_nFontIndex, (char*)_caption.c_str(), GetX() + posX, GetY(), _color);
	}
  }

  _clShadow = dwOldShadow; // 还原成原来的阴影颜色
  _color	= dwOldColor;  // 还原成原来的颜色
}
