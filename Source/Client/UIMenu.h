//----------------------------------------------------------------------
// 名称:菜单
// 作者:lh 2005-03-25
// 最后修改日期:
//----------------------------------------------------------------------
#pragma once
#include "uiguidata.h"
#include "Tools.h"

namespace GUI
{

class CMenu;

// 菜单条
class CMenuItem : public CItemObj
{
  public:
  CMenuItem(const char* str, DWORD v);
  ITEM_CLONE(CMenuItem)

  void SetIsCheck(bool v) { _IsCheck = v; }
  bool GetIsCheck() { return _IsCheck; }

  void SetIsEnabled(bool v) { _IsEnabled = v; }
  bool GetIsEnabled() { return _IsEnabled; }

  void SetIsHide(bool v) { _IsHide = v; }
  bool GetIsHide() { return _IsHide; }

  DWORD GetIndex() { return _dwIndex; }

  virtual void Render(int x, int y);
  virtual int  GetWidth() { return _nWidth; }
  virtual int  GetHeight() { return _nHeight; }

  DWORD GetTag() { return _nTag; }
  void	SetTag(DWORD v) { _nTag = v; }

  virtual const char* GetString() { return _strText.c_str(); }

  protected:
  string _strText;

  bool _IsCheck;
  bool _IsEnabled;
  bool _IsHide;

  int _nWidth;
  int _nHeight;

  DWORD _dwIndex;
  DWORD _nTag;
};

// 菜单类
class CMenu : public CGuiData
{
  public:
  enum eShowStyle // 菜单消失方式
  {
	enumMouseFollow, // 离开时消失
	enumMouseClick,	 // 点击时消失
  };

  CMenu(CForm* pForm);
  CMenu(const CMenu& rhs);
  CMenu& operator=(const CMenu& rhs);
  virtual ~CMenu();
  GUI_CLONE(CMenu)

  virtual void Render();
  virtual bool MouseRun(int x, int y, DWORD key);
  virtual void Refresh();
  virtual void SetParent(CGuiData* p);
  virtual void SetIsShow(bool v);

  static CMenu* FindMenu(const char* name);
  static int	CloseAll();

  void SetAllEnabled(bool isEnabled);
  bool IsAllDisabled();

  CMenuItem* FindMenuItem(const char* name);
  CMenuItem* GetMenuItem(unsigned int n);

  int GetCount() { return (int)_menus.size(); }

  void SetRowSpace(int v)
  {
	if(v >= 0) _nRowSpace = v;
  }
  void SetMargin(int left, int top, int right, int bottom);

  CMenuItem* AddMenu(const char* szText);
  bool		 DelMenu(CMenuItem* pMenu);

  void SetStyle(eShowStyle n) { _eStyle = n; }

  CGuiPic*	 GetSelectImage() { return _pSelect; }
  CFramePic* GetBkgImage() { return _pImage; }
  CMenuItem* GetSelectMenu() { return _pSelectMenu; }

  public:						  // 事件
  GuiEvent		evtSelectChange;  // 选择发生了变化
  GuiMouseEvent evtListMouseDown; // 鼠标在文字区按下

  protected:
  CFramePic* _pImage;  // 背景
  CGuiPic*	 _pSelect; // 选择条

  typedef vector<CMenuItem*> menus;
  menus						 _menus; // 所有菜单项

  int _nRowSpace; // 行距

  int		 _nLeftMargin; // 与周围边框的距离
  int		 _nTopMargin;
  int		 _nRightMargin;
  int		 _nBottomMargin;
  eShowStyle _eStyle;

  private:
  void _Copy(const CMenu& rhs);
  void _MenusClear();

  private:
  CMenuItem* _pSelectMenu; // 当前选择的菜单条

  int _nStartX, _nStartX2;
  int _nStartY, _nStartY2;

  // 用于内存管理
  typedef vector<CMenu*> allmenus;
  static allmenus		 _allmenus;
};

// 内联函数
inline void CMenu::SetMargin(int left, int top, int right, int bottom)
{
  _nLeftMargin	 = left;
  _nTopMargin	 = top;
  _nRightMargin	 = right;
  _nBottomMargin = bottom;
}

inline CMenuItem* CMenu::GetMenuItem(unsigned int n)
{
  if(n >= _menus.size()) return NULL;
  return _menus[n];
}

inline CMenuItem* CMenu::FindMenuItem(const char* name)
{
  for(menus::iterator it = _menus.begin(); it != _menus.end(); it++)
	if(strcmp((*it)->GetString(), name) == 0)
	  return (*it);

  return NULL;
}

inline void CMenu::SetIsShow(bool v)
{
  if(v && _pParent)
  {
	_bShow = true;
  } else
  {
	_bShow = false;
	SetParent(NULL);
  }
}

} // namespace GUI
