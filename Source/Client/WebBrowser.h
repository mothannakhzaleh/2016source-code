// WebBrowser.h: interface for the CWebBrowser class.

#ifndef __WEB_BROWSER_H__
#define __WEB_BROWSER_H__

#pragma once

#include <crtdbg.h>

//#define _WIN32_WINNT	0x0500

#include <comdef.h>
#include <exdisp.h>

#include <mshtml.h>	  // Defines of stuff like IHTMLDocument2. This is an include file with Visual C 6 and above
#include <mshtmhst.h> // Defines of stuff like IDocHostUIHandler. This is an include file with Visual C 6 and above
#include <exdisp.h>	  // Defines of stuff like IWebBrowser2. This is an include file with Visual C 6 and above

#define NOTIMPLEMENTED \
  _ASSERT(0);          \
  return E_NOTIMPL

class CWebStorage : public IStorage
{
  public:
  // IUnknown methods.
  virtual HRESULT STDMETHODCALLTYPE QueryInterface(
	  /* [in] */ REFIID								 riid,
	  /* [iid_is][out] */ void __RPC_FAR* __RPC_FAR* ppvObject);
  virtual ULONG STDMETHODCALLTYPE AddRef();
  virtual ULONG STDMETHODCALLTYPE Release();

  // IStorage methods.
  virtual HRESULT STDMETHODCALLTYPE CreateStream(
	  /* [string][in] */ const OLECHAR* pwcsName,
	  /* [in] */ DWORD					grfMode,
	  /* [in] */ DWORD					reserved1,
	  /* [in] */ DWORD					reserved2,
	  /* [out] */ IStream**				ppstm);
  virtual /* [local] */ HRESULT STDMETHODCALLTYPE OpenStream(
	  /* [string][in] */ const OLECHAR* pwcsName,
	  /* [unique][in] */ void*			reserved1,
	  /* [in] */ DWORD					grfMode,
	  /* [in] */ DWORD					reserved2,
	  /* [out] */ IStream**				ppstm);
  virtual HRESULT STDMETHODCALLTYPE CreateStorage(
	  /* [string][in] */ const OLECHAR* pwcsName,
	  /* [in] */ DWORD					grfMode,
	  /* [in] */ DWORD					reserved1,
	  /* [in] */ DWORD					reserved2,
	  /* [out] */ IStorage**			ppstg);
  virtual HRESULT STDMETHODCALLTYPE OpenStorage(
	  /* [string][unique][in] */ const OLECHAR* pwcsName,
	  /* [unique][in] */ IStorage*				pstgPriority,
	  /* [in] */ DWORD							grfMode,
	  /* [unique][in] */ SNB					snbExclude,
	  /* [in] */ DWORD							reserved,
	  /* [out] */ IStorage**					ppstg);
  virtual HRESULT STDMETHODCALLTYPE CopyTo(
	  /* [in] */ DWORD						 ciidExclude,
	  /* [size_is][unique][in] */ const IID* rgiidExclude,
	  /* [unique][in] */ SNB				 snbExclude,
	  /* [unique][in] */ IStorage*			 pstgDest);
  virtual HRESULT STDMETHODCALLTYPE MoveElementTo(
	  /* [string][in] */ const OLECHAR* pwcsName,
	  /* [unique][in] */ IStorage*		pstgDest,
	  /* [string][in] */ const OLECHAR* pwcsNewName,
	  /* [in] */ DWORD					grfFlags);
  virtual HRESULT STDMETHODCALLTYPE Commit(
	  /* [in] */ DWORD grfCommitFlags);
  virtual HRESULT STDMETHODCALLTYPE				  Revert();
  virtual /* [local] */ HRESULT STDMETHODCALLTYPE EnumElements(
	  /* [in] */ DWORD					reserved1,
	  /* [size_is][unique][in] */ void* reserved2,
	  /* [in] */ DWORD					reserved3,
	  /* [out] */ IEnumSTATSTG**		ppenum);
  virtual HRESULT STDMETHODCALLTYPE DestroyElement(
	  /* [string][in] */ const OLECHAR* pwcsName);
  virtual HRESULT STDMETHODCALLTYPE RenameElement(
	  /* [string][in] */ const OLECHAR* pwcsOldName,
	  /* [string][in] */ const OLECHAR* pwcsNewName);
  virtual HRESULT STDMETHODCALLTYPE SetElementTimes(
	  /* [string][unique][in] */ const OLECHAR* pwcsName,
	  /* [unique][in] */ const FILETIME*		pctime,
	  /* [unique][in] */ const FILETIME*		patime,
	  /* [unique][in] */ const FILETIME*		pmtime);
  virtual HRESULT STDMETHODCALLTYPE SetClass(
	  /* [in] */ REFCLSID clsid);
  virtual HRESULT STDMETHODCALLTYPE SetStateBits(
	  /* [in] */ DWORD grfStateBits,
	  /* [in] */ DWORD grfMask);
  virtual HRESULT STDMETHODCALLTYPE Stat(
	  /* [out] */ STATSTG* pstatstg,
	  /* [in] */ DWORD	   grfStatFlag);
};

class CWebClientSite :
	public IOleClientSite,
	public IOleInPlaceFrame,
	public IOleInPlaceSite
{
  //-------------------------------------------------------------------------
  // We don't want those functions to access global variables, because then
  //	we couldn't use more than one browser object. (ie, we couldn't have
  //	multiple windows, each with its own embedded browser object to display
  //	a different web page). So here is where I added my extra HWND that the
  //  IOleInPlaceFrame function GetWindow() needs to access.
  //-------------------------------------------------------------------------
  HWND m_hWnd;

  public:
  CWebClientSite(HWND hWnd) { m_hWnd = hWnd; }

  // IUnknown methods.
  virtual HRESULT STDMETHODCALLTYPE QueryInterface(
	  /* [in] */ REFIID								 riid,
	  /* [iid_is][out] */ void __RPC_FAR* __RPC_FAR* ppvObject);
  virtual ULONG STDMETHODCALLTYPE AddRef();
  virtual ULONG STDMETHODCALLTYPE Release();

  // IOleClientSite methods.
  virtual HRESULT STDMETHODCALLTYPE SaveObject();
  virtual HRESULT STDMETHODCALLTYPE GetMoniker(
	  /* [in] */ DWORD		 dwAssign,
	  /* [in] */ DWORD		 dwWhichMoniker,
	  /* [out] */ IMoniker** ppmk);
  virtual HRESULT STDMETHODCALLTYPE GetContainer(
	  /* [out] */ IOleContainer** ppContainer);
  virtual HRESULT STDMETHODCALLTYPE ShowObject();
  virtual HRESULT STDMETHODCALLTYPE OnShowWindow(
	  /* [in] */ BOOL fShow);
  virtual HRESULT STDMETHODCALLTYPE RequestNewObjectLayout();

  // IOleWindow methods.
  virtual /* [input_sync] */ HRESULT STDMETHODCALLTYPE GetWindow(
	  /* [out] */ HWND* phwnd);
  virtual HRESULT STDMETHODCALLTYPE ContextSensitiveHelp(
	  /* [in] */ BOOL fEnterMode);

  // IOleInPlaceUIWindow methods.
  virtual /* [input_sync] */ HRESULT STDMETHODCALLTYPE GetBorder(
	  /* [out] */ LPRECT lprectBorder);
  virtual /* [input_sync] */ HRESULT STDMETHODCALLTYPE RequestBorderSpace(
	  /* [unique][in] */ LPCBORDERWIDTHS pborderwidths);
  virtual /* [input_sync] */ HRESULT STDMETHODCALLTYPE SetBorderSpace(
	  /* [unique][in] */ LPCBORDERWIDTHS pborderwidths);
  virtual HRESULT STDMETHODCALLTYPE SetActiveObject(
	  /* [unique][in] */ IOleInPlaceActiveObject* pActiveObject,
	  /* [unique][string][in] */ LPCOLESTR		  pszObjName);

  // IOleInPlaceFrame
  virtual HRESULT STDMETHODCALLTYPE InsertMenus(
	  /* [in] */ HMENU					   hmenuShared,
	  /* [out][in] */ LPOLEMENUGROUPWIDTHS lpMenuWidths);
  virtual /* [input_sync] */ HRESULT STDMETHODCALLTYPE SetMenu(
	  /* [in] */ HMENU	  hmenuShared,
	  /* [in] */ HOLEMENU holemenu,
	  /* [in] */ HWND	  hwndActiveObject);
  virtual HRESULT STDMETHODCALLTYPE RemoveMenus(
	  /* [in] */ HMENU hmenuShared);
  virtual /* [input_sync] */ HRESULT STDMETHODCALLTYPE SetStatusText(
	  /* [unique][in] */ LPCOLESTR pszStatusText);
  virtual HRESULT STDMETHODCALLTYPE EnableModeless(
	  /* [in] */ BOOL fEnable);
  virtual HRESULT STDMETHODCALLTYPE TranslateAccelerator(
	  /* [in] */ LPMSG lpmsg,
	  /* [in] */ WORD  wID);

  // IOleInPlaceSite methods.
  virtual HRESULT STDMETHODCALLTYPE CanInPlaceActivate();
  virtual HRESULT STDMETHODCALLTYPE OnInPlaceActivate();
  virtual HRESULT STDMETHODCALLTYPE OnUIActivate();
  virtual HRESULT STDMETHODCALLTYPE GetWindowContext(
	  /* [out] */ IOleInPlaceFrame**		ppFrame,
	  /* [out] */ IOleInPlaceUIWindow**		ppDoc,
	  /* [out] */ LPRECT					lprcPosRect,
	  /* [out] */ LPRECT					lprcClipRect,
	  /* [out][in] */ LPOLEINPLACEFRAMEINFO lpFrameInfo);
  virtual HRESULT STDMETHODCALLTYPE Scroll(
	  /* [in] */ SIZE scrollExtant);
  virtual HRESULT STDMETHODCALLTYPE OnUIDeactivate(
	  /* [in] */ BOOL fUndoable);
  virtual HRESULT STDMETHODCALLTYPE OnInPlaceDeactivate();
  virtual HRESULT STDMETHODCALLTYPE DiscardUndoState();
  virtual HRESULT STDMETHODCALLTYPE DeactivateAndUndo();
  virtual HRESULT STDMETHODCALLTYPE OnPosRectChange(
	  /* [in] */ LPCRECT lprcPosRect);
};

//class CWebBrowser
//{
//	IOleObject*	m_lpOleObject;
//
//public:
//	CWebBrowser();
//	~CWebBrowser();
//
//	HRESULT	EmbedBrowserObject( HWND hWnd );
//	VOID	UnEmbedBrowserObject();
//	HRESULT	DisplayHTMLPage( LPCTSTR pcsWebPage );
//};

#endif