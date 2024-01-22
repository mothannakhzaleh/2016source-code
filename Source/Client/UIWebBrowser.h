#pragma once
#include "uicompent.h"
#include "uigraph.h"
#include "WebBrowser.h"

#include <vector>

using namespace std;

namespace GUI
{

class CWebBrowser : public CCompent
{
  public:
  CWebBrowser(CForm& frmOwn);
  virtual ~CWebBrowser(void);
  GUI_CLONE(CWebBrowser)

  virtual void Render();
  virtual void Refresh();
  virtual void OnActive();
  virtual void OnLost();
  virtual void FrameMove(DWORD dwTime);

  void Show();
  void Hide();
  void setUrlHtml(const LPCTSTR UrlHtml) { m_UrlHtml = UrlHtml; } //add guojiangang 20090209
  void closeUrlHtml() { m_UrlHtml = NULL; }						  //add guojiangang 20090209

  static void WindowMove();

  void FrmActive();
  void FrmLost();

  void DragBegin();
  void DragEnd();

  protected:
  HRESULT EmbedBrowserObject();
  VOID	  UnEmbedBrowserObject();
  HRESULT DisplayHTMLPage(LPCTSTR pcsWebPage);

  private:
  IOleObject* m_lpOleObject;
  HWND		  m_hWndWeb;
  bool		  m_bInit;
  LPCTSTR	  m_UrlHtml; //add guojiangang 20090206

  static vector<CWebBrowser*> WindowsHandleV;
};

} // namespace GUI
