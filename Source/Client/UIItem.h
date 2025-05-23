//----------------------------------------------------------------------
// 名称:静态文字
// 作者:lh 2004-07-19
// 最后修改日期:2004-10-09
//----------------------------------------------------------------------
#pragma once
#include "uiguidata.h"
#include "UIFont.h"

namespace GUI
{
// 固定列数的ItemObj
class CItemRow
{
  public:
  CItemRow(unsigned int max);
  CItemRow(const CItemRow& rhs);
  CItemRow& operator=(const CItemRow& rhs);
  ~CItemRow();

  void		SetBegin(CItemObj* p) { SetIndex(0, p); }
  CItemObj* GetBegin() { return _items[0]; }

  void		SetIndex(unsigned int v, CItemObj* p);
  CItemObj* GetIndex(unsigned int v) { return _items[v]; }

  unsigned int GetMax() const { return _nMax; }
  void		   SetPointer(void* p) { _pTag = p; }
  void*		   GetPointer() { return _pTag; }

  void SetColor(DWORD c);

  private:
  void		_Copy(const CItemRow& rhs);
  void		_Clear();
  void		_Init();
  CItemObj* _GetNullItem() { return &_NullObj; }

  private:
  static CItemObj _NullObj;

  CItemObj**   _items;
  unsigned int _nMax;
  void*		   _pTag;
};

// 文字
class CItem : public CItemObj
{
  public:
  CItem() :
	  _dwColor(COLOR_RED), _nWidth(0), _nHeight(0) {}
  CItem(const char* str, DWORD c = COLOR_WHITE) :
	  _str(str), _dwColor(c) { CGuiFont::s_Font.GetSize(str, _nWidth, _nHeight); }
  CItem(const CItem& rhs) :
	  _str(rhs._str), _dwColor(rhs._dwColor), _nWidth(rhs._nWidth), _nHeight(rhs._nHeight) {}
  CItem& operator=(const CItem& rhs)
  {
	_str	 = rhs._str;
	_dwColor = rhs._dwColor;
	return *this;
  }
  ITEM_CLONE(CItem)

  virtual void Render(int x, int y);
  virtual int  GetWidth() { return _nWidth; }
  virtual int  GetHeight() { return _nHeight; }
  virtual void SetHeight(int n) { _nHeight = n; }
  virtual void SetWidth(int v) { _nWidth = v; }

  virtual void SetString(const char* str)
  {
	_str = str;
	CGuiFont::s_Font.GetSize(str, _nWidth, _nHeight);
  }
  virtual const char* GetString() { return _str.c_str(); }

  void	SetColor(DWORD c) { _dwColor = c; }
  DWORD GetColor() { return _dwColor; }

  protected:
  string _str;

  DWORD _dwColor;
  int	_nWidth;
  int	_nHeight;
};

class CColorItem : public CItem
{
  public:
  CColorItem();

  virtual void		  Render(int x, int y);
  virtual void		  SetString(const char* str);
  virtual const char* GetString() { return _str.c_str(); }

  private:
  struct ITEM_TEXT_DATA
  {
	ITEM_TEXT_DATA()
	{
	  sxPos	  = 0;
	  dwColor = 0xFF000000;
	  strData = "";
	}
	USHORT sxPos;
	DWORD  dwColor;
	string strData;
  };

  // 分段显示不通颜色的文字信息
  typedef vector<ITEM_TEXT_DATA> ITEM_TEXT_ARRAY;
  ITEM_TEXT_ARRAY				 m_TextArray;

  void ParseScript(const char szScript[], USHORT sStartCom, DWORD dwDefColor);
};

// 带进度条的文字
class CItemBar : public CItem
{
  public:
  CItemBar();

  virtual void Render(int x, int y);
  static void  Clear(); //安全释放内存 by Waiting 2009-06-18

  void SetScale(float f)
  {
	if(f >= 0.0f && f <= 1.0f) _fScale = f;
  }
  static void LoadImage(const char* file, int w, int h, int tx = 0, int ty = 0);

  protected:
  static CGuiPic* _pBar;
  float			  _fScale;
};

// 可换行文字
class CItemEx : public CItemObj
{
  public:
  CItemEx() :
	  _dwColor(COLOR_WHITE), _bParseText(false), _nWidth(0), _nHeight(0), _bMultiLine(false), _nLineNum(1), m_Allign(eAlignTop), _HeadLen(0), _HeadColor(0) {}
  CItemEx(const char* str, DWORD c) :
	  _str(str), _dwColor(c), _bParseText(false), _bMultiLine(false), _nLineNum(1), m_Allign(eAlignTop), _HeadLen(0), _HeadColor(0) { CGuiFont::s_Font.GetSize(str, _nWidth, _nHeight); }
  CItemEx(const CItemEx& rhs) :
	  _str(rhs._str), _dwColor(rhs._dwColor), _nWidth(rhs._nWidth), _nHeight(rhs._nHeight), _bParseText(rhs._bParseText), _bMultiLine(rhs._bMultiLine), _nLineNum(rhs._nLineNum), m_Allign(rhs.m_Allign) {}
  CItemEx& operator=(const CItemEx& rhs)
  {
	_str	 = rhs._str;
	_dwColor = rhs._dwColor;
	m_Allign = rhs.m_Allign;
	return *this;
  }
  ~CItemEx() {}
  ITEM_CLONE(CItemEx)

  virtual void Render(int x, int y);
  void		   RenderEx(int x, int y, int height, float scale);
  virtual void SetHeight(int n) { _nHeight = n; }

  public:
  int GetWidth();
  int GetHeight() { return _nHeight; }

  void SetString(const char* str)
  {
	_str = str;
	CGuiFont::s_Font.GetSize(str, _nWidth, _nHeight);
  }
  const char* GetString() { return _str.c_str(); }

  void	SetColor(DWORD c) { _dwColor = c; }
  DWORD GetColor() { return _dwColor; }

  void SetIsParseText(bool v) { _bParseText = v; }
  bool GetIsParseText() { return _bParseText; }

  void	SetHasHeadText(DWORD headLen, DWORD headColor);
  DWORD GetHeadLength();
  DWORD GetHeadColor();

  void SetIsMultiLine(bool v) { _bMultiLine = v; }
  bool GetIsMultiLine() { return _bMultiLine; }

  int GetLineNum() { return _nLineNum; }

  void		  SetAlignment(ALLIGN allign) { m_Allign = allign; }
  void		  SetItemName(const char* name) { _strItemName = name; }
  const char* GetItemName() { return _strItemName.c_str(); }

  void ProcessString(int length); // 参数：角色名称的长度

  protected:
  string _str;
  string _strItemName;
  bool	 _bParseText; // 是否需要解析图元
  bool	 _bMultiLine; //是否多行显示
  string _strLine[3]; //最多3行
  DWORD	 _HeadLen;
  DWORD	 _HeadColor;

  DWORD	 _dwColor;
  int	 _nWidth;
  int	 _nHeight;
  int	 _nLineNum;	 //显示在头像上的行数
  int	 _nMaxWidth; //多行中最大的宽度
  ALLIGN m_Allign;
};

// 内联函数
inline void CItemRow::SetIndex(unsigned int v, CItemObj* p)
{
  if(_items[v] != _GetNullItem() && _items[v] != p)
  {
	//delete _items[v];
	SAFE_DELETE(_items[v]); // UI当机处理
  }
  _items[v] = p;
}

inline int CItemEx::GetWidth()
{
  if(!_bMultiLine)
	return _nWidth;
  else
	return _nMaxWidth;
}

} // namespace GUI
