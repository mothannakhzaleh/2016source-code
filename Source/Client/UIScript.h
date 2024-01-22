//----------------------------------------------------------------------
// 名称:UI脚本类
// 作者:lh 2004-10-26
// 用途:辅助类,用于支持其它对象能够用于外部脚本
//   注:目前不能在程序中动态删除
// 最后修改日期:
//----------------------------------------------------------------------
#ifndef __UI_SCRIPT_H
#define __UI_SCRIPT_H
#include "uiguidata.h"

namespace GUI
{

template<class T>
class UIScript
{
  public:
  T* GetObj(unsigned int nIndex)
  {
	if(nIndex >= list.size()) return NULL;
	return list[nIndex];
  }
  int AddObj(T* p)
  {
	list.push_back(p);
	return (int)(list.size() - 1);
  }
  void ReleaseAll();

  private:
  typedef vector<T*> vt;
  vt				 list;
};

//安全释放内存 by Waiting 2009-06-18
template<class T>
void UIScript<T>::ReleaseAll()
{
  //需要反向迭代，因为需要从数组最下层对象开始析构
  for(vt::reverse_iterator rit = list.rbegin(); rit != list.rend(); rit++)
  {
	T* pObj = *rit;

	//修正退出时Crash by Waiting 2009-06-29
	CNoteGraph* n = dynamic_cast<CNoteGraph*>(pObj);
	if(n)
	{
	  delete n;
	  continue;
	}

	CTextGraph* t = dynamic_cast<CTextGraph*>(pObj);
	if(t)
	{
	  delete t;
	  continue;
	}

	CHintGraph* h = dynamic_cast<CHintGraph*>(pObj);
	if(h)
	{
	  delete h;
	  continue;
	}

	CGraph* g = dynamic_cast<CGraph*>(pObj);
	if(g)
	{
	  delete g;
	  continue;
	}

	delete pObj;
  }
  list.clear();
}
} //end of namespace GUI

#endif //__UI_SCRIPT_H
