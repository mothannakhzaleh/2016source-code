//----------------------------------------------------------------------
// 名称:RichEdit
// 作者:lh 2005-07-11
//----------------------------------------------------------------------
#pragma once
#include "uicompent.h"
#include "uieditdata.h"

namespace GUI
{

class CEditKey;
class CRichEdit : public CCompent
{
  public:
  CRichEdit(CForm& frmOwn);
  CRichEdit(const CRichEdit& rhs);
  CRichEdit& operator=(const CRichEdit& rhs);
  virtual ~CRichEdit(void);
  GUI_CLONE(CRichEdit)

  virtual void Init();
  virtual void Refresh();
  virtual void Render();
  virtual void OnActive();
  virtual void OnLost();

  bool OnKeyDown(int key);
  bool OnChar(char c);

  private:
  void _SetSelf();
  void _Copy(const CRichEdit& rhs);

  private:
  char _szEnter[16]; // 用于计算输入的buf
  int  _nEnterPos;

  CEditArticle _cArticle;
  bool		   _IsReadyOnly; // 是否只读
  CEditKey*	   _pEditKey;
};

} // namespace GUI
