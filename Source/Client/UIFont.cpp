#include "StdAfx.h"
#include "uifont.h"
#include "gameapp.h"

using namespace GUI;
//---------------------------------------------------------------------------
// class CGuiFont
//---------------------------------------------------------------------------
CGuiFont CGuiFont::s_Font;

int CGuiFont::CreateFont(char* font, int size800, int size1024, DWORD dwStyle)
{
  stFont ft;
  ft.strFont  = font;
  ft.size800  = size800;
  ft.size1024 = size1024;
  ft.dwStyle  = dwStyle;

  _stfonts.push_back(ft);
  return (int)_stfonts.size() - 1;
}

void CGuiFont::FrameRender(const char* str, int x, int y)
{
  static int w, h, offx;

  GetSize(str, w, h);
  offx = GetRender().GetScreenWidth() - x - w - 10;
  if(offx < 0)
  {
	x += offx;
  }
  GetRender().FillFrame(x - 5, y - 3, x + w + 10, y + h + 5, 0x90000000);
  CGuiFont::s_Font.Render(str, x - 1, y - 1, 0xffffffff);
}

void CGuiFont::TipRender(const char* str, int x, int y)
{
  static int w, h;

  GetSize(str, w, h);
  x -= w / 2;
  GetRender().FillFrame(x - 2, y - 1, x + w + 2, y + h + 1, 0x90000000);
  CGuiFont::s_Font.Render(str, x - 1, y - 1, 0xffffffff);
}

//---------------------------------------------------------------------------
// class CGuiFont
//---------------------------------------------------------------------------
CTextHint::CTextHint()
{
  _nHintW = 0;
  _nHintH = 0;
  memset(_nRelatedHintW, 0, sizeof(_nRelatedHintW));
  memset(_nRelatedHintH, 0, sizeof(_nRelatedHintH));
  _nStartX	= 0;
  _nStartY	= 0;
  _IsCenter = true;

  _eStyle	   = enumFontSize;
  _nFixWidth   = 0;
  _dwBkgColor  = 0x90000000;
  _IsShowFrame = true;

  _IsHeadShadow = true;
}

//安全释放内存 by Waiting 2009-06-18
CTextHint::~CTextHint()
{
  for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
  {
	stHint* pH = *it;
	SAFE_DELETE(pH);
  }
  _hint.clear();
}

void CTextHint::PopFront()
{
  if(_hint.size())
  {
	hints::iterator it = _hint.begin();
	stHint*			pH = *it;
	SAFE_DELETE(pH);
	_hint.erase(it);
  }
}

void CTextHint::Render()
{
  if(_hint.empty())
	return;

  static RECT rt;
  rt.left	= _nStartX - 5;
  rt.top	= _nStartY - 7;
  rt.right	= _nStartX + _nHintW + 5;
  rt.bottom = _nStartY + _nHintH + 2;
  GetRender().FillFrame(rt.left, rt.top, rt.right, rt.bottom, _dwBkgColor);

  int yy = _nStartY;

  hints::iterator it = _hint.begin();
  if(_IsHeadShadow)
  {
	DWORD color = (*it)->color;
	color		= (0xff000000 & color) | ~color;
	CGuiFont::s_Font.BRender((*it)->font, (*it)->hint.c_str(), _nStartX + (*it)->offx, yy, (*it)->color, color);
	yy += (*it)->height;
	++it;
  }
  for(; it != _hint.end(); ++it)
  {
	CGuiFont::s_Font.Render((*it)->font, (*it)->hint.c_str(), _nStartX + (*it)->offx, yy, (*it)->color);
	yy += (*it)->height;
  }

  if(_IsShowFrame)
  {
	extern BOOL RenderHintFrame(const RECT* rc, DWORD color);
	RenderHintFrame(&rt, D3DCOLOR_ARGB(255, 123, 218, 229));
	rt.left--;
	rt.top--;
	rt.right++;
	rt.bottom++;
	RenderHintFrame(&rt, COLOR_BLACK);
  }

  if(_hint_related[0].empty())
	return;

  int nStartX = _nStartX + _nHintW + 12;

  for(INT i = 0; i < enumEQUIP_NUM; ++i)
  {
	if(_hint_related[i].empty())
	  break;

	static RECT rt;
	rt.left	  = nStartX - 5;
	rt.top	  = _nStartY - 7;
	rt.right  = nStartX + _nRelatedHintW[i] + 5;
	rt.bottom = _nStartY + _nRelatedHintH[i] + 2;

	GetRender().FillFrame(rt.left, rt.top, rt.right, rt.bottom, _dwBkgColor);

	int yy = _nStartY;

	hints::iterator it = _hint_related[i].begin();

	if(_IsHeadShadow)
	{
	  DWORD color = (*it)->color;
	  color		  = (0xff000000 & color) | ~color;
	  CGuiFont::s_Font.BRender((*it)->font, (*it)->hint.c_str(), nStartX + (*it)->offx, yy, (*it)->color, color);
	  yy += (*it)->height;
	  ++it;
	}

	for(; it != _hint_related[i].end(); ++it)
	{
	  CGuiFont::s_Font.Render((*it)->font, (*it)->hint.c_str(), nStartX + (*it)->offx, yy, (*it)->color);
	  yy += (*it)->height;
	}

	if(_IsShowFrame)
	{
	  extern BOOL RenderHintFrame(const RECT* rc, DWORD color);
	  RenderHintFrame(&rt, D3DCOLOR_ARGB(255, 123, 218, 229));
	  rt.left--;
	  rt.top--;
	  rt.right++;
	  rt.bottom++;
	  RenderHintFrame(&rt, COLOR_BLACK);
	}

	nStartX += (_nRelatedHintW[i] + 12);
  }
}

void CTextHint::ReadyForHint(int x, int y)
{
  if(_hint.empty())
	return;

  // 计算开始显示位置，以及背景框等
  _nStartX = x + 40;
  _nStartY = y;
  _nHintW  = 0;
  _nHintH  = 0;

  static int w, h;

  for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
  {
	CGuiFont::s_Font.GetSize((*it)->font, (*it)->hint.c_str(), w, h);
	if(_nHintW < w) _nHintW = w;
	(*it)->width = w;
	(*it)->height += h;
	_nHintH += (*it)->height;
  }

  if(_eStyle == enumFixWidth)
	_nHintW = _nFixWidth;

  for(int i = 0; i < enumEQUIP_NUM; ++i)
  {
	if(_hint_related[i].empty())
	  break;

	_nRelatedHintW[i] = 0;
	_nRelatedHintH[i] = 0;

	for(hints::iterator it = _hint_related[i].begin(); it != _hint_related[i].end(); ++it)
	{
	  CGuiFont::s_Font.GetSize((*it)->font, (*it)->hint.c_str(), w, h);
	  if(_nRelatedHintW[i] < w)
		_nRelatedHintW[i] = w;
	  (*it)->width = w;
	  (*it)->height += h;
	  _nRelatedHintH[i] += (*it)->height;
	}

	if(_eStyle == enumFixWidth)
	  _nRelatedHintW[i] = _nFixWidth;
  }

  if(_hint.size() > 1 && _IsCenter)
  {
	for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
	  (*it)->offx = (_nHintW - (*it)->width) / 2;
  }

  if(_IsCenter)
  {
	for(int i = 0; i < enumEQUIP_NUM; ++i)
	{
	  if(_hint_related[i].empty())
		break;

	  for(hints::iterator it = _hint_related[i].begin(); it != _hint_related[i].end(); ++it)
		(*it)->offx = (_nRelatedHintW[i] - (*it)->width) / 2;
	}
  }

  // 检查hint是否越界（右，下）
  int off = GetRender().GetScreenWidth() - _nStartX - _nHintW - 10;
  for(INT i = 0; i < enumEQUIP_NUM; ++i)
  {
	if(_hint_related[i].empty())
	  break;

	off -= (_nRelatedHintW[i] + 12);
  }
  if(off < 0)
	_nStartX += off;

  off = GetRender().GetScreenHeight() - _nStartY - _nHintH - 10;
  for(int i = 0; i < enumEQUIP_NUM; ++i)
  {
	if(_hint_related[i].empty())
	  break;

	int tempoff = GetRender().GetScreenHeight() - _nStartY - _nRelatedHintH[i] - 10;
	off			= min(off, tempoff);
  }

  if(off < 0)
	_nStartY += off;
}

//Add by sunny.sun 20080912为区分GM公告和道具说明显示
//Begin
void CTextHint::ReadyForHintGM(int x, int y)
{
  if(_hint.empty()) return;

  // 计算开始显示位置，以及背景框等
  _nStartX = x + 40;
  _nStartY = y;
  _nHintW  = 0;
  _nHintH  = 0;
  static int w, h;

  for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
  {
	CGuiFont::s_Font.GetSize((*it)->font, (*it)->hint.c_str(), w, h);
	if(_nHintW < w) _nHintW = w;
	(*it)->width = w;
	(*it)->height += h;
	_nHintH += (*it)->height;
  }

  if(_eStyle == enumFixWidth)
  {
	if(GetRender().GetScreenWidth() == 800)
	  _nHintW = _nFixWidth - 50;
	else if(GetRender().GetScreenWidth() == 1024)
	  _nHintW = _nFixWidth + 170;
	else
	  _nHintW = _nFixWidth + 420;
  }

  if(_hint.size() > 1 && _IsCenter)
  {
	for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
	{
	  (*it)->offx = (_nHintW - (*it)->width) / 2;
	}
  }

  // 检查hint是否越界（右，下）
  int off = GetRender().GetScreenWidth() - _nStartX - _nHintW - 10;
  if(off < 0)
  {
	_nStartX += off;
  }

  off = GetRender().GetScreenHeight() - _nStartY - _nHintH - 10;
  if(off < 0)
  {
	_nStartY += off;
  }
}
//End

void CTextHint::Clear()
{
  hints::iterator it = _hint.begin();
  for(; it != _hint.end(); ++it)
  {
	//delete *it;
	SAFE_DELETE(*it); // UI当机处理
  }
  _hint.clear();

  for(int i = 0; i < enumEQUIP_NUM; ++i)
  {
	it = _hint_related[i].begin();
	for(; it != _hint_related[i].end(); ++it)
	{
	  //delete *it;
	  SAFE_DELETE(*it); // UI当机处理
	}
	_hint_related[i].clear();
  }
}

void CTextHint::PushHint(const char* str, DWORD color, int height, int font, int index)
{
  if(str && strlen(str) > 0)
  {
	if(index == -1)
	  _hint.push_back(new stHint(str, color, height, font));
	else
	  _hint_related[index].push_back(new stHint(str, color, height, font));
  }
}

void CTextHint::AddHintHeight(int height, int index)
{
  if(!_hint.empty())
  {
	if(index == -1)
	  _hint.back()->height += height;
	else
	  _hint_related[index].back()->height += height;
  }
}

#include <fstream>
int CTextHint::WriteText(const char* file)
{
  ofstream out(file, ios::app);

  int			  nLines = 0;
  hints::iterator it	 = _hint.begin();
  stHint*		  pHint	 = NULL;
  for(; it != _hint.end(); ++it)
  {
	nLines++;
	out << (*it)->hint << endl;
  }
  if(nLines > 0) out << "\n======================================\n"
					 << endl;
  return nLines;
}

//-----------------------------------------------------------------------------
//	class CTextScrollHint
//Add by sunny.sun20080804
//-----------------------------------------------------------------------------

CTextScrollHint::CTextScrollHint()
{
  _nHintW	   = 0;
  _nHintH	   = 0;
  _nStartX	   = 0;
  _nStartY	   = 0;
  _IsCenter	   = true;
  index		   = 0;
  dwInitTime   = 0;
  SetScrollNum = 1;
  m			   = 0;
  _eStyle	   = enumFontSize;
  _nFixWidth   = 0;
  _dwBkgColor  = 0x90000000;
  _IsShowFrame = true;

  _IsHeadShadow = true;
}

//安全释放内存 by Waiting 2009-06-18
CTextScrollHint::~CTextScrollHint()
{
  for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
  {
	stHint* pH = *it;
	SAFE_DELETE(pH);
  }
  _hint.clear();
}

void CTextScrollHint::PopFront()
{
  if(_hint.size())
  {
	hints::iterator it = _hint.begin();
	stHint*			pH = *it;
	SAFE_DELETE(pH);
	_hint.erase(it);
  }
}

void CTextScrollHint::Render()
{
  if(_hint.empty()) return;
  try
  {
	int			scrollneedspace = 0;
	static RECT rt;
	int			yy = _nStartY;
	//Modify by sunny.sun20080820
	if(GetRender().GetScreenWidth() == 1024)
	{
	  rt.left		  = _nStartX - 5;
	  rt.top		  = _nStartY - 7;
	  rt.right		  = _nStartX + _nHintW + 160;
	  rt.bottom		  = _nStartY + _nHintH + 2;
	  scrollneedspace = SCROLLNEEDSPACE + 39;
	} else
	{
	  rt.left		  = _nStartX - 5;
	  rt.top		  = _nStartY - 7;
	  rt.right		  = _nStartX + _nHintW - 55;
	  rt.bottom		  = _nStartY + _nHintH + 2;
	  scrollneedspace = SCROLLNEEDSPACE + 3;
	}

	if(RenderScrollNum < SetScrollNum)
	{
	  hints::iterator it = _hint.begin();
	  GetRender().FillFrame(rt.left, rt.top, rt.right, rt.bottom, _dwBkgColor);
	  SpaceLength = "";

	  if(dwInitTime == 0)
	  {
		dwInitTime	= g_dwCurFrameTick;
		SpaceLength = "";
		for(int n = 0; n < scrollneedspace; n++)
		  SpaceLength = SpaceLength + " ";
		CopyHints	= SpaceLength + (*it)->hint;
		(*it)->hint = SpaceLength;
		m			= 0;
	  }

	  index = (g_dwCurFrameTick - dwInitTime) / 125;
	  if(index > m)
	  {
		m++;
		dwInitTime += (index - m) * 125; //避免突然卡画面时公告一下子飞掉
		(*it)->hint = CopyHints;

		if(m >= CopyHints.length())

		{
		  m			  = 0;
		  (*it)->hint = "";
		  RenderScrollNum++;
		} else if(m > (int)(CopyHints.length() - scrollneedspace - 1))
		{
		  char c = (*it)->hint.at(m);
		  if((byte)c >= (byte)0x80)
		  {
			if(m >= (int)CopyHints.length()) m = 0;
			(*it)->hint = (*it)->hint.erase(0, m);
			m += 1;
		  } else
			(*it)->hint = (*it)->hint.substr(m, CopyHints.length() - m);
		} else
		{
		  char c = (*it)->hint.at(m);
		  char d = (*it)->hint.at(m + scrollneedspace - 1);
		  if((byte)c >= (byte)0x80 || (byte)d >= (byte)0x80)
		  {
			(*it)->hint = (*it)->hint.substr(m, scrollneedspace - 1);
			m += 1;
		  } else
			(*it)->hint = (*it)->hint.substr(m, scrollneedspace - 1);
		}
	  }

	  CGuiFont::s_Font.Render((*it)->font, (*it)->hint.c_str(), _nStartX + (*it)->offx, yy, (*it)->color);

	  //End
	  if(_IsShowFrame)
	  {
		extern BOOL RenderHintFrame(const RECT* rc, DWORD color);
		RenderHintFrame(&rt, D3DCOLOR_ARGB(255, 123, 218, 229));
		rt.left--;
		rt.top--;
		rt.right++;
		rt.bottom++;
		RenderHintFrame(&rt, COLOR_BLACK);
	  }
	}
  } catch(...)
  {
	try
	{
	  for(vector<stHint*>::iterator it = _hint.begin(); it != _hint.end(); it++)
	  {
		stHint* st = *it;
		LG("sunny.txt", "hint error !%s\n", st->hint.c_str());
	  }
	  _hint.clear();
	} catch(...)
	{
	}
  }
}
void CTextScrollHint::ReadyForHint(int x, int y, int SetNum)
{
  if(_hint.empty()) return;

  // 计算开始显示位置，以及背景框等
  _nStartX = x + 40;
  _nStartY = y;
  _nHintW  = 0;
  _nHintH  = 0;
  static int w, h;

  for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
  {
	CGuiFont::s_Font.GetSize((*it)->font, (*it)->hint.c_str(), w, h);
	if(_nHintW < w) _nHintW = w;
	(*it)->width = w;
	(*it)->height += h;
	_nHintH += (*it)->height;
  }

  if(_eStyle == enumFixWidth)
  {
	_nHintW = _nFixWidth;
  }

  if(_hint.size() > 1 && _IsCenter)
  {
	for(hints::iterator it = _hint.begin(); it != _hint.end(); ++it)
	{
	  (*it)->offx = (_nHintW - (*it)->width) / 2;
	}
  }

  // 检查hint是否越界（右，下）
  int off = GetRender().GetScreenWidth() - _nStartX - _nHintW - 10;
  if(off < 0)
  {
	_nStartX += off;
  }

  off = GetRender().GetScreenHeight() - _nStartY - _nHintH - 10;
  if(off < 0)
  {
	_nStartY += off;
  }
  dwInitTime	  = 0;
  RenderScrollNum = 0;
  SetScrollNum	  = SetNum;
  CopyHints.clear();
}

void CTextScrollHint::Clear()
{
  hints::iterator it = _hint.begin();
  for(; it != _hint.end(); ++it)
  {
	//delete *it;
	SAFE_DELETE(*it); // UI当机处理
  }
  _hint.clear();
}
