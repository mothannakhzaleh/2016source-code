#include "StdAfx.h"
#include "uiitem.h"
#include "uitextparse.h"

using namespace GUI;
//---------------------------------------------------------------------------
// class CItem
//---------------------------------------------------------------------------
void CItem::Render(int x, int y)
{
  CGuiFont::s_Font.Render((char*)_str.c_str(), x, y, _dwColor);
}

//---------------------------------------------------------------------------
// class CItemBar
//---------------------------------------------------------------------------
CGuiPic* CItemBar::_pBar = new CGuiPic(NULL, 2);

CItemBar::CItemBar() :
	CItem(), _fScale(0.3f)
{
}

//安全释放内存 by Waiting 2009-06-18
void CItemBar::Clear()
{
  SAFE_DELETE(_pBar);
}

void CItemBar::LoadImage(const char* file, int w, int h, int tx, int ty)
{
  _pBar->LoadAllImage(file, w, h, tx, ty);
}

void CItemBar::Render(int x, int y)
{
  _pBar->SetScaleW(1, _fScale);
  _pBar->RenderAll(x, y);

  CGuiFont::s_Font.Render((char*)_str.c_str(), x, y, _dwColor);
}

// class CColorItem impletement
CColorItem::CColorItem()
{
}

void CColorItem::SetString(const char* str)
{
  _str = str;
  ParseScript(_str.c_str(), 0, 0xFF000000);
  _str = "";

  ITEM_TEXT_ARRAY::iterator pos;
  for(pos = m_TextArray.begin(); pos != m_TextArray.end(); pos++)
  {
	_str += (*pos).strData;
  }

  CGuiFont::s_Font.GetSize(_str.c_str(), _nWidth, _nHeight);
}

void CColorItem::Render(int x, int y)
{
  USHORT sWidth = CGuiFont::s_Font.GetHeight("a") / 2;

  ITEM_TEXT_ARRAY::iterator pos;
  for(pos = m_TextArray.begin(); pos != m_TextArray.end(); pos++)
  {
	int v	 = (*pos).sxPos;
	int xPos = (*pos).sxPos * sWidth + x;
	CGuiFont::s_Font.Render((*pos).strData.c_str(), xPos, y, (*pos).dwColor);
  }
}

void CColorItem::ParseScript(const char szScript[], USHORT sStartCom, DWORD dwDefColor)
{
  m_TextArray.clear();
  if(szScript == NULL) return;

  USHORT sCom	 = sStartCom;
  USHORT sxPos	 = sCom;
  DWORD	 dwColor = dwDefColor;
  char	 szData[3];
  memset(szData, 0, 3);
  const char* pszTemp	 = szScript;
  string	  strDesp	 = "";
  string	  strCaption = "";
  while(pszTemp[0])
  {
	szData[0] = 0;
	szData[1] = 0;

	if(pszTemp[0] == '<')
	{
	  if(strDesp.size() > 0)
	  {
		// 添加文字显示数据到列表中
		ITEM_TEXT_DATA Data;
		Data.dwColor = dwColor;
		Data.sxPos	 = sxPos;
		Data.strData = strDesp;
		m_TextArray.push_back(Data);
		strDesp = "";
		sxPos	= sCom;
	  }

	  pszTemp++;
	  if(pszTemp[0] == 'p')
	  {
		dwColor = 0xFFFF00FF; // 紫色
		if(pszTemp[1] == '>')
		{
		  pszTemp++;
		  continue;
		}
	  } else if(pszTemp[0] == 'j')
	  {
		dwColor = 0xFFFE0000;
		if(pszTemp[1] == '>')
		{
		  pszTemp += 2;
		  continue;
		}
	  } else if(pszTemp[0] == 'r')
	  {
		dwColor = 0xFFFF0000;
		if(pszTemp[1] == '>')
		{
		  pszTemp++;
		  continue;
		}
	  } else if(pszTemp[0] == 'y')
	  {
		dwColor = 0xFFFFFF00;
		if(pszTemp[1] == '>')
		{
		  pszTemp++;
		  continue;
		}
	  } else if(pszTemp[0] == 'b')
	  {
		dwColor = 0xFF0000FF;
		if(pszTemp[1] == '>')
		{
		  pszTemp++;
		  continue;
		}
	  } else if(pszTemp[0] == 'g')
	  {
		dwColor = 0xFF00C800;
		if(pszTemp[1] == '>')
		{
		  pszTemp++;
		  continue;
		}
	  } else
	  {
		// 未知类型报错！
		continue;
	  }

	  // 使用新的字符记录
	  pszTemp++;
	} else if(pszTemp[0] == '>')
	{
	  // 添加文字显示数据到列表中
	  ITEM_TEXT_DATA Data;
	  Data.dwColor = dwColor;
	  Data.sxPos   = sxPos;
	  Data.strData = strDesp;
	  m_TextArray.push_back(Data);
	  strDesp = "";
	  sxPos	  = sCom;

	  dwColor = dwDefColor;
	  pszTemp++;
	  continue;
	}

	// 判断是否一个GBK
	BOOL bFlag1 = 0x81 <= (BYTE)pszTemp[0] && (BYTE)pszTemp[0] <= 0xFE;
	BOOL bFlag2 = (0x40 <= (BYTE)pszTemp[1] && (BYTE)pszTemp[1] <= 0x7E) || (0x7E <= (BYTE)pszTemp[1] && (BYTE)pszTemp[1] <= 0xFE);
	if(bFlag1 && bFlag2)
	{
	  szData[0] = pszTemp[0];
	  szData[1] = pszTemp[1];
	  strDesp += szData;

	  // 移动列和指向下一个字符
	  sCom += 2;
	  pszTemp += 2;
	} else
	{
	  szData[0] = pszTemp[0];
	  strDesp += szData;

	  // 移动列和指向下一个字符
	  sCom++;
	  pszTemp++;
	}
  }
}

//---------------------------------------------------------------------------
// class CItemRow
//---------------------------------------------------------------------------
CItemObj CItemRow::_NullObj;

CItemRow::CItemRow(unsigned int max) :
	_nMax(max)
{
  _pTag = NULL;
  _Init();
}

CItemRow::CItemRow(const CItemRow& rhs)
{
  _nMax = rhs._nMax;

  _Copy(rhs);
}

CItemRow& CItemRow::operator=(const CItemRow& rhs)
{
  _Clear();

  _nMax = rhs._nMax;

  _Copy(rhs);
  return *this;
}

void CItemRow::_Copy(const CItemRow& rhs)
{
  _pTag	 = rhs._pTag;
  _items = new CItemObj*[_nMax];
  for(unsigned int i = 0; i < _nMax; i++)
  {
	if(rhs._items[i] != _GetNullItem())
	  _items[i] = rhs._items[i]->Clone();
	else
	  _items[i] = _GetNullItem();
  }
}

void CItemRow::_Clear()
{
  for(unsigned int i = 0; i < _nMax; i++)
  {
	if(_items[i] != _GetNullItem())
	{
	  //delete _items[i];
	  SAFE_DELETE(_items[i]); // UI当机处理
	}
  }

  //delete [] _items;
  SAFE_DELETE_ARRAY(_items); // UI当机处理
  _pTag = NULL;
}

void CItemRow::_Init()
{
  _items = new CItemObj*[_nMax];
  for(unsigned int i = 0; i < _nMax; i++)
	_items[i] = _GetNullItem();
}

CItemRow::~CItemRow()
{
  _Clear();
}

void CItemRow::SetColor(DWORD c)
{
  for(unsigned int i = 0; i < _nMax; i++)
	_items[i]->SetColor(c);
}
//---------------------------------------------------------------------------
// class CItemEx
//---------------------------------------------------------------------------
void CItemEx::ProcessString(int length) // 参数：角色名称的长度
{
  _strLine[0] = _str.substr(0, length); //第一行显示角色的名称

  if(_str.size() - length <= 32) //实际文字不足32个字符,则2行显示
  {
	_strLine[1] = _str.substr(length, _str.size() - length);
	_nLineNum	= 2;
  } else //实际文字长于32个字符,则3行显示,最多3行
  {
	int i;
	i = length;
	while((int)_strLine[1].size() < 32) //第2行
	{
	  if(_str[i] & 0x80) //汉字
	  {
		_strLine[1] += _str.substr(i, 2);
		i += 2;
	  } else //其他字符
	  {
		//Modify by sunny.sun20080901
		//begin
		if((_str.at(length + 30) == '#') && (_str.at(length + 31) != '#'))
		{
		  if((int)_strLine[1].size() < 30)
		  {
			_strLine[1] += _str.substr(i, 1);
			i += 1;
		  } else
		  {
			_strLine[1] += "  ";
			break;
		  }
		} else if(_str.at(length + 31) == '#')
		{
		  if((int)_strLine[1].size() < 31)
		  {
			_strLine[1] += _str.substr(i, 1);
			i += 1;
		  } else
		  {
			_strLine[1] += " ";
			break;
		  }
		} else //End
		{
		  _strLine[1] += _str.substr(i, 1);
		  i += 1;
		}
	  }
	}

	while((int)_strLine[1].size() >= 32 && (int)_strLine[2].size() < 32 && i < (int)_str.size()) //第3行
	{
	  if(_str[i] & 0x80)
	  {
		_strLine[2] += _str.substr(i, 2);
		i += 2;
	  } else
	  {
		_strLine[2] += _str.substr(i, 1);
		i += 1;
	  }
	}

	_nLineNum = 3;
  }

  string maxStr = _strLine[0];
  if((int)_strLine[0].size() < (int)_strLine[1].size())
	maxStr = _strLine[1];

  CGuiFont::s_Font.GetSize((char*)maxStr.c_str(), _nMaxWidth, _nHeight);
}

void CItemEx::SetHasHeadText(DWORD headLen, DWORD headColor)
{
  _HeadLen	 = headLen;
  _HeadColor = headColor;
}

DWORD CItemEx::GetHeadLength()
{
  return _HeadLen;
}

DWORD CItemEx::GetHeadColor()
{
  return _HeadColor;
}

void CItemEx::Render(int x, int y)
{
  int sy = 0;
  if(m_Allign == eAlignCenter)
  {
	sy = (_nHeight - CGuiFont::s_Font.GetHeight(RES_STRING(CL_LANGUAGE_MATCH_623))) / 2;
  } else if(m_Allign == eAlignBottom)
  {
	sy = _nHeight - CGuiFont::s_Font.GetHeight(RES_STRING(CL_LANGUAGE_MATCH_623));
  }
  if(_bParseText)
  {
	if(!_bMultiLine)
	{
	  if(GetHeadLength() && GetHeadLength() <= _str.length())
	  {
		string strHead = _str.substr(0, GetHeadLength());
		string strTail = _str.substr(GetHeadLength(), _str.length() - GetHeadLength());
		g_TextParse.Render((char*)strHead.c_str(), x, y, GetHeadColor(), m_Allign, _nHeight);
		g_TextParse.Render((char*)strTail.c_str(), x + CGuiFont::s_Font.GetWidth(strHead.c_str()), y, _dwColor, m_Allign, _nHeight);
	  } else
	  {
		g_TextParse.Render((char*)_str.c_str(), x, y, _dwColor, m_Allign, _nHeight);
	  }
	} else
	{
	  g_TextParse.Render((char*)_strLine[0].c_str(), x, y, _dwColor, m_Allign, _nHeight);
	  g_TextParse.Render((char*)_strLine[1].c_str(), x, y + _nHeight, _dwColor, m_Allign, _nHeight);
	  g_TextParse.Render((char*)_strLine[2].c_str(), x, y + 2 * _nHeight, _dwColor, m_Allign, _nHeight);
	}
  } else
  {
	if(!_bMultiLine)
	{
	  CGuiFont::s_Font.Render((char*)_str.c_str(), x, y + sy, _dwColor);
	} else
	{
	  CGuiFont::s_Font.Render((char*)_strLine[0].c_str(), x, y + sy, _dwColor);
	  CGuiFont::s_Font.Render((char*)_strLine[1].c_str(), x, y + _nHeight + sy, _dwColor);
	  CGuiFont::s_Font.Render((char*)_strLine[2].c_str(), x, y + 2 * _nHeight + sy, _dwColor);
	}
  }
}

void CItemEx::RenderEx(int x, int y, int height, float scale)
{
  if(_bParseText)
  {
	y = y + 5;
	if(!_bMultiLine)
	{
	  g_TextParse.RenderEx((char*)_str.c_str(), x, y, _dwColor, scale);
	  int p = (int)(_str.find(":"));
	  if(p != -1)
		CGuiFont::s_Font.RenderScale((char*)_str.substr(0, p).c_str(), x, y, 0xFFFFFFFF, scale);

	} else
	{
	  g_TextParse.RenderEx((char*)_strLine[0].c_str(), x, y, 0xFFFFFFFF, scale);
	  g_TextParse.RenderEx((char*)_strLine[1].c_str(), x, y + height, _dwColor, scale);
	  g_TextParse.RenderEx((char*)_strLine[2].c_str(), x, y + 2 * height, _dwColor, scale);
	}
  } else
  {
	y = y + 3;
	if(!_bMultiLine)
	{
	  CGuiFont::s_Font.RenderScale((char*)_str.c_str(), x, y, _dwColor, scale);
	  int p = (int)(_str.find(":"));
	  if(p != -1)
	  {
		CGuiFont::s_Font.RenderScale((char*)_str.substr(0, p).c_str(), x, y, 0xFFFFFFFF, scale);
	  }
	} else
	{
	  CGuiFont::s_Font.RenderScale((char*)_strLine[0].c_str(), x, y, 0xFFFFFFFF, scale);
	  CGuiFont::s_Font.RenderScale((char*)_strLine[1].c_str(), x, y + height + 3, _dwColor, scale);
	  CGuiFont::s_Font.RenderScale((char*)_strLine[2].c_str(), x, y + 2 * height + 6, _dwColor, scale);
	}
  }
}
