#include "StdAfx.h"
#include "uiwebbrowser.h"
#include "uigraph.h"
#include "gameapp.h"

using namespace GUI;

vector<CWebBrowser*> CWebBrowser::WindowsHandleV;

CWebBrowser::CWebBrowser(CForm& frmOwn) :
	CCompent(frmOwn), m_bInit(false), m_UrlHtml(NULL)
{
  //_IsFocus = true;
  //EmbedBrowserObject();

  CWebBrowser::WindowsHandleV.push_back(this);
}

CWebBrowser::~CWebBrowser(void)
{
  if(m_bInit)
	UnEmbedBrowserObject();
}

HRESULT CWebBrowser::EmbedBrowserObject()
{
  WNDCLASSEX wcex;
  wcex.cbSize		 = sizeof(WNDCLASSEX);
  wcex.style		 = CS_HREDRAW | CS_VREDRAW;
  wcex.lpfnWndProc	 = DefWindowProc;
  wcex.cbClsExtra	 = 0;
  wcex.cbWndExtra	 = 0;
  wcex.hInstance	 = g_pGameApp->GetAppInstance();
  wcex.hIcon		 = NULL;
  wcex.hCursor		 = NULL;
  wcex.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);
  wcex.lpszMenuName	 = NULL;
  wcex.lpszClassName = TEXT("WebBrowser");
  wcex.hIconSm		 = NULL;
  RegisterClassEx(&wcex);

  RECT rect;
  GetWindowRect(g_pGameApp->GetHWND(), &rect);
  m_hWndWeb = CreateWindow(TEXT("WebBrowser"), TEXT(""),
						   WS_POPUP /* |WS_VISIBLE*/,
						   rect.left + this->GetX(), rect.top + this->GetY(), this->GetWidth(), this->GetHeight(),
						   g_pGameApp->GetHWND(), NULL, g_pGameApp->GetAppInstance(), NULL);
  _ASSERT(m_hWndWeb);

  CWebStorage	  Storage;
  CWebClientSite* pClientSite = new CWebClientSite(m_hWndWeb);
  IWebBrowser2*	  lpWebBrowser2;

  if(OleCreate(CLSID_WebBrowser, IID_IOleObject, OLERENDER_DRAW, 0, (IOleClientSite*)pClientSite, &Storage, (void**)&m_lpOleObject) == S_OK)
  {
	m_lpOleObject->SetHostNames(L"Kop", 0);

	if(OleSetContainedObject((IUnknown*)m_lpOleObject, TRUE) == S_OK)
	{
	  if(m_lpOleObject->DoVerb(OLEIVERB_SHOW, NULL, (IOleClientSite*)pClientSite, -1, m_hWndWeb, &rect) == S_OK)
	  {
		if(!m_lpOleObject->QueryInterface(IID_IWebBrowser2, (void**)&lpWebBrowser2))
		{
		  lpWebBrowser2->put_Left(0);
		  lpWebBrowser2->put_Top(0);
		  lpWebBrowser2->put_Width(10);
		  lpWebBrowser2->put_Height(10);

		  lpWebBrowser2->Release();

		  // Success
		  return 0;
		}
	  }
	}

	if(pClientSite)
	{
	  delete pClientSite;
	}
	UnEmbedBrowserObject();
	return -3;
  }

  return -2;
}

VOID CWebBrowser::UnEmbedBrowserObject()
{
  _ASSERT(m_lpOleObject);

  m_lpOleObject->Close(OLECLOSE_NOSAVE);
  m_lpOleObject->Release();
}

HRESULT CWebBrowser::DisplayHTMLPage(LPCTSTR pcsWebPage)
{
  IWebBrowser2* lpWebBrowser2;
  HRESULT		hr = m_lpOleObject->QueryInterface(IID_IWebBrowser2, (VOID**)&lpWebBrowser2);
  if(FAILED(hr))
	return E_FAIL;

  RECT rect;
  GetWindowRect(g_pGameApp->GetHWND(), &rect);

  lpWebBrowser2->put_Left(rect.left + this->GetX());
  lpWebBrowser2->put_Top(rect.top + this->GetY());
  lpWebBrowser2->put_Width(this->GetWidth());
  lpWebBrowser2->put_Height(this->GetHeight());

  VARIANT URL;
  VariantInit(&URL);
  URL.vt = VT_BSTR;

#ifndef UNICODE
  DWORD	 Size	= MultiByteToWideChar(CP_ACP, 0, pcsWebPage, -1, NULL, 0);
  WCHAR* Buffer = (WCHAR*)GlobalAlloc(GMEM_FIXED, sizeof(WCHAR) * Size);
  if(!Buffer)
	goto Error;

  MultiByteToWideChar(CP_ACP, 0, pcsWebPage, -1, Buffer, Size);
  URL.bstrVal = SysAllocString(Buffer);
  GlobalFree(Buffer);
#else
  URL.bstrVal = SysAllocString(pcsWebPage);
#endif

  if(!URL.bstrVal)
	goto Error;

  lpWebBrowser2->Navigate2(&URL, 0, 0, 0, 0);

  VariantClear(&URL);

  lpWebBrowser2->Release();

  return S_OK;

Error:
  lpWebBrowser2->Release();

  return E_FAIL;
}

void CWebBrowser::Render()
{
  CCompent::Render();

  //if(!this->GetIsShow())
  //	return;

  //if( GetActive()==this )
  //{
  //	//ShowFocus();
  //}
  //GetRender().SetClipRect( GetX(),GetY(), GetWidth(), GetHeight() );
}

void CWebBrowser::Refresh()
{
  CCompent::Refresh();

  //if( GetActive()==this )
  //{
  //	OnActive();
  //}
}

void CWebBrowser::OnActive()
{
  CCompent::OnActive();

  //Show();
}

void CWebBrowser::OnLost()
{
  CCompent::OnLost();

  //Hide();
}

void CWebBrowser::DragBegin()
{
  Hide();
  //::SendMessage(g_pGameApp->GetHWND(), WM_ACTIVATE, TRUE, TRUE);
  //::UpdateWindow(g_pGameApp->GetHWND());
}

void CWebBrowser::DragEnd()
{
  CWebBrowser::WindowMove();
  if(m_bInit)
	::ShowWindow(this->m_hWndWeb, SW_SHOW);

  //  Show();
  //::SendMessage(this->m_hWndWeb, WM_ACTIVATE, TRUE, TRUE);
}

void CWebBrowser::FrameMove(DWORD dwTime)
{
}

void CWebBrowser::Show()
{
  if(!m_bInit)
  {
	EmbedBrowserObject();

	m_bInit = true;
  }

  ::ShowWindow(this->m_hWndWeb, SW_SHOW);
  RECT rect;
  GetWindowRect(g_pGameApp->GetHWND(), &rect);
  ::SetWindowPos(this->m_hWndWeb, NULL, rect.left + this->GetX(), rect.top + this->GetY(), this->GetWidth(), this->GetHeight(), SWP_NOSIZE | SWP_NOZORDER);

  DisplayHTMLPage(m_UrlHtml); //modified guojiangang 20090206
}

void CWebBrowser::Hide()
{
  if(m_bInit)
  {
	::ShowWindow(this->m_hWndWeb, SW_HIDE);
  }
}

void CWebBrowser::FrmActive()
{
  this->Show();
}

void CWebBrowser::FrmLost()
{
  this->Hide();
}

void CWebBrowser::WindowMove()
{
  RECT rect;
  GetWindowRect(g_pGameApp->GetHWND(), &rect);
  for(vector<CWebBrowser*>::iterator it = CWebBrowser::WindowsHandleV.begin(); it != CWebBrowser::WindowsHandleV.end(); it++)
  {
	SetWindowPos((*it)->m_hWndWeb, NULL, rect.left + (*it)->GetX(), rect.top + (*it)->GetY(), (*it)->GetWidth(), (*it)->GetHeight(), SWP_NOSIZE | SWP_NOZORDER);
  }
}