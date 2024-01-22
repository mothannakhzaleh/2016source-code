#include "StdAfx.h"
#include "uicheckboxitem.h"
#include "UIFont.h"

CCheckBoxItem::CCheckBoxItem(void)
{
}

CCheckBoxItem::~CCheckBoxItem(void)
{
}

void CCheckBoxItem::Render(int x, int y)
{
  _pImage->Render(x, y);
  static int nOffY = (16 - CGuiFont::s_Font.GetHeight(RES_STRING(CL_LANGUAGE_MATCH_489))) / 2;
  CGuiFont::s_Font.Render(m_strCaption.c_str(), x + 20, y + nOffY, m_dwColor);
}
