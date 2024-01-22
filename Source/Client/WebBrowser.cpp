#include "stdafx.h"
#include "WebBrowser.h"

HRESULT STDMETHODCALLTYPE CWebStorage::QueryInterface(REFIID riid, void __RPC_FAR* __RPC_FAR* ppvObject)
{
  NOTIMPLEMENTED;
}

ULONG STDMETHODCALLTYPE CWebStorage::AddRef()
{
  return 1;
}

ULONG STDMETHODCALLTYPE CWebStorage::Release()
{
  return 0;
}

HRESULT STDMETHODCALLTYPE CWebStorage::CreateStream(const OLECHAR* pwcsName, DWORD grfMode, DWORD reserved1, DWORD reserved2, IStream** ppstm) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::OpenStream(const OLECHAR* pwcsName, void* reserved1, DWORD grfMode, DWORD reserved2, IStream** ppstm) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::CreateStorage(const OLECHAR* pwcsName, DWORD grfMode, DWORD reserved1, DWORD reserved2, IStorage** ppstg) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::OpenStorage(const OLECHAR* pwcsName, IStorage* pstgPriority, DWORD grfMode, SNB snbExclude, DWORD reserved, IStorage** ppstg) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::CopyTo(DWORD ciidExclude, const IID* rgiidExclude, SNB snbExclude, IStorage* pstgDest) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::MoveElementTo(const OLECHAR* pwcsName, IStorage* pstgDest, const OLECHAR* pwcsNewName, DWORD grfFlags) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::Commit(DWORD grfCommitFlags) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::Revert() { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::EnumElements(DWORD reserved1, void* reserved2, DWORD reserved3, IEnumSTATSTG** ppenum) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::DestroyElement(const OLECHAR* pwcsName) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::RenameElement(const OLECHAR* pwcsOldName, const OLECHAR* pwcsNewName) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::SetElementTimes(const OLECHAR* pwcsName, const FILETIME* pctime, const FILETIME* patime, const FILETIME* pmtime) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::SetClass(REFCLSID clsid) { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebStorage::SetStateBits(DWORD grfStateBits, DWORD grfMask) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebStorage::Stat(STATSTG* pstatstg, DWORD grfStatFlag) { NOTIMPLEMENTED; }

HRESULT STDMETHODCALLTYPE CWebClientSite::QueryInterface(REFIID riid, void __RPC_FAR* __RPC_FAR* ppvObject)
{
  if(IsEqualGUID(riid, IID_IUnknown)) // Query the interface of IUnknown.
	*ppvObject = (void*)(this);
  else if(IsEqualGUID(riid, IID_IOleClientSite)) // Query the interface of IOleClientSite.
	*ppvObject = (void*)dynamic_cast<IOleClientSite*>(this);
  else if(IsEqualGUID(riid, IID_IOleInPlaceSite)) // Query the interface of IOleInPlaceSite.
	*ppvObject = (void*)dynamic_cast<IOleInPlaceSite*>(this);
  else
  {
	// For other types of objects the browser wants, just report that we don't have
	//	any such objects.
	// NOTE: If you want to add additional functionality to your browser hosting,
	//	you may need to provide some more objects here. You'll have to investigate
	//	what the browser is asking for (ie, what REFIID it is passing).
	*ppvObject = NULL;

	return E_NOINTERFACE;
  }

  return S_OK;
}

ULONG STDMETHODCALLTYPE CWebClientSite::AddRef()
{
  return 1;
}

ULONG STDMETHODCALLTYPE CWebClientSite::Release()
{
  return 0;
}

// IOleClientSite methods.
HRESULT STDMETHODCALLTYPE CWebClientSite::SaveObject() { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::GetMoniker(DWORD dwAssign, DWORD dwWhichMoniker, IMoniker** ppmk) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::GetContainer(IOleContainer** ppContainer)
{
  *ppContainer = NULL;
  return E_NOINTERFACE;
}
HRESULT STDMETHODCALLTYPE CWebClientSite::ShowObject() { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::OnShowWindow(BOOL fShow) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::RequestNewObjectLayout() { NOTIMPLEMENTED; }

// IOleWindow methods.
HRESULT STDMETHODCALLTYPE CWebClientSite::GetWindow(HWND* phwnd)
{
  *phwnd = m_hWnd;

  return S_OK;
}

HRESULT STDMETHODCALLTYPE CWebClientSite::ContextSensitiveHelp(BOOL fEnterMode) { NOTIMPLEMENTED; }

// IOleInPlaceUIWindow methods.
HRESULT STDMETHODCALLTYPE CWebClientSite::GetBorder(LPRECT lprectBorder) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::RequestBorderSpace(LPCBORDERWIDTHS pborderwidths) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::SetBorderSpace(LPCBORDERWIDTHS pborderwidths) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::SetActiveObject(IOleInPlaceActiveObject* pActiveObject, LPCOLESTR pszObjName) { return S_OK; }

// IOleInPlaceFrame methods.
HRESULT STDMETHODCALLTYPE CWebClientSite::InsertMenus(HMENU hmenuShared, LPOLEMENUGROUPWIDTHS lpMenuWidths) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::SetMenu(HMENU hmenuShared, HOLEMENU holemenu, HWND hwndActiveObject) { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::RemoveMenus(HMENU hmenuShared) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::SetStatusText(LPCOLESTR pszStatusText) { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::EnableModeless(BOOL fEnable) { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::TranslateAccelerator(LPMSG lpmsg, WORD wID) { NOTIMPLEMENTED; }

// IOleInPlaceSite methods.
HRESULT STDMETHODCALLTYPE CWebClientSite::CanInPlaceActivate() { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::OnInPlaceActivate() { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::OnUIActivate() { return S_OK; }

HRESULT STDMETHODCALLTYPE CWebClientSite::GetWindowContext(IOleInPlaceFrame** ppFrame, IOleInPlaceUIWindow** ppDoc, LPRECT lprcPosRect, LPRECT lprcClipRect, LPOLEINPLACEFRAMEINFO lpFrameInfo)
{
  *ppFrame = (LPOLEINPLACEFRAME)this; // Maybe incorrect.
  // We have no OLEINPLACEUIWINDOW.
  *ppDoc = NULL;
  // Fill in some other info for the browser.
  lpFrameInfo->fMDIApp		 = FALSE;
  lpFrameInfo->hwndFrame	 = m_hWnd; // Maybe incorrect.
  lpFrameInfo->haccel		 = NULL;
  lpFrameInfo->cAccelEntries = 0;

  // Give the browser the dimensions of where it can draw. We give it our entire window to fill.
  GetClientRect(lpFrameInfo->hwndFrame, lprcPosRect);
  GetClientRect(lpFrameInfo->hwndFrame, lprcClipRect);

  return S_OK;
}

HRESULT STDMETHODCALLTYPE CWebClientSite::Scroll(SIZE scrollExtant) { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::OnUIDeactivate(BOOL fUndoable) { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::OnInPlaceDeactivate() { return S_OK; }
HRESULT STDMETHODCALLTYPE CWebClientSite::DiscardUndoState() { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::DeactivateAndUndo() { NOTIMPLEMENTED; }
HRESULT STDMETHODCALLTYPE CWebClientSite::OnPosRectChange(LPCRECT lprcPosRect) { return S_OK; }

//CWebBrowser::CWebBrowser() :
//	m_lpOleObject( NULL )
//{
//}
//
//CWebBrowser::~CWebBrowser() {}
//
//HRESULT CWebBrowser::EmbedBrowserObject( HWND hWnd )
//{
//	IWebBrowser2  *pWebBrowser2;
//	RECT    rect;
//	CWebStorage   Storage;
//	CWebClientSite  *pClientSite = new CWebClientSite(hWnd);
//
//	// Get a pointer to the browser object and lock it down (so it doesn't "disappear" while we're using
//	// it in this program). We do this by calling the OS function OleCreate().
//	//
//	// NOTE: We need this pointer to interact with and control the browser. With normal WIN32 controls such as a
//	// Static, Edit, Combobox, etc, you obtain an HWND and send messages to it with SendMessage(). Not so with
//	// the browser object. You need to get a pointer to its base class (as returned by OleCreate()).
//	//
//	// For example, the browser object happens to have a SetHostNames() function we want to call. So, after we
//	// retrieve the pointer to the browser object (in a local we'll name 'm_lpOleObject'), then we can call that
//	// function, and pass it args, as so:
//	//
//	// m_lpOleObject->SetHostNames(SomeString, SomeString);
//
//	if (!OleCreate(CLSID_WebBrowser, IID_IOleObject, OLERENDER_DRAW, 0, (IOleClientSite *)pClientSite, &Storage, (void**)&m_lpOleObject))
//	{
//		//////////////////////////////////////////////////////////////////////////
//		//
//		// Not implemented for multiple browsing...
//		//
//		// Ok, we now have the pointer to the browser object in 'browserObject'. Let's save this in the
//		// memory block we allocated above, and then save the pointer to that whole thing in our window's
//		// USERDATA field. That way, if we need multiple windows each hosting its own browser object, we can
//		// call EmbedBrowserObject() for each one, and easily associate the appropriate browser object with
//		// its matching window and its own objects containing per-window data.
//		//IOleObject **ppObj = &m_lpOleObject;
//		//SetWindowLong(hWnd, GWL_USERDATA, (LONG)ppObj);
//		//////////////////////////////////////////////////////////////////////////
//
//		// We can now call the browser object's SetHostNames function. SetHostNames lets the browser object know our
//		// application's name and the name of the document in which we're embedding the browser. (Since we have no
//		// document name, we'll pass a 0 for the latter). When the browser object is opened for editing, it displays
//		// these names in its titlebar.
//		//
//		// We are passing 2 args to SetHostNames. Oh yeah, the L is because we need UNICODE strings.
//		// And BTW, the host and document names can be anything you want.
//
//		m_lpOleObject->SetHostNames(L"My Host Name", 0);
//
//		GetClientRect(hWnd, &rect);
//
//		// Let browser object know that it is embedded in an OLE container.
//		if (!OleSetContainedObject((IUnknown *)m_lpOleObject, TRUE))
//		{
//			// Set the display area of our browser control the same as our window's size
//			// and actually put the browser object into our window.
//			if (!m_lpOleObject->DoVerb(OLEIVERB_SHOW, NULL, (IOleClientSite *)pClientSite, -1, hWnd, &rect))
//			{
//				// We want to get the base address (ie, a pointer) to the IWebBrowser2 object embedded within the browser
//				// object, so we can call some of the functions in the former's table. For example, one IWebBrowser2 function
//				// we intend to call below will be Navigate2(). So we call the browser object's QueryInterface to get our
//				// pointer to the IWebBrowser2 object.
//				if (!m_lpOleObject->QueryInterface(IID_IWebBrowser2, (void**)&pWebBrowser2))
//				{
//					// Let's call several functions in the IWebBrowser2 object to position the browser display area
//					// in our window. The functions we call are put_Left(), put_Top(), put_Width(), and put_Height().
//					pWebBrowser2->put_Left(0);
//					pWebBrowser2->put_Top(0);
//					pWebBrowser2->put_Width(rect.right);
//					pWebBrowser2->put_Height(rect.bottom);
//
//					// We no longer need the IWebBrowser2 object (ie, we don't plan to call any more functions in it
//					// right now, so we can release our hold on it). Note that we'll still maintain our hold on the
//					// browser object until we're done with that object.
//					pWebBrowser2->Release();
//
//					// Success
//					return 0;
//				}
//				// Something went wrong!
//				// QueryInterface failed
//			}
//			// DoVerb Failed
//		}
//		// OleSetContainedObject failed
//
//		if (pClientSite)
//		{
//			delete pClientSite;
//		}
//		UnEmbedBrowserObject();
//		return -3;
//	}
//
//	return -2;
//}
//
//VOID CWebBrowser::UnEmbedBrowserObject()
//{
//	_ASSERT( m_lpOleObject );
//
//	// Unembed the browser object, and release its resources.
//	m_lpOleObject->Close( OLECLOSE_NOSAVE );
//	m_lpOleObject->Release();
//}
//
//HRESULT CWebBrowser::DisplayHTMLPage( LPCTSTR pcsWebPage )
//{
//	IWebBrowser2* lpWebBrowser2;
//	HRESULT hr = m_lpOleObject->QueryInterface( IID_IWebBrowser2, ( VOID** ) &lpWebBrowser2 );
//	if( FAILED( hr ) )
//		return E_FAIL;
//
//	VARIANT URL;
//	VariantInit( &URL );
//	URL.vt = VT_BSTR;
//
//#ifndef UNICODE
//	DWORD Size = MultiByteToWideChar( CP_ACP, 0, pcsWebPage, -1, NULL, 0 );
//	WCHAR* Buffer = ( WCHAR* ) GlobalAlloc( GMEM_FIXED, sizeof( WCHAR ) * Size );
//	if( !Buffer )
//		goto Error;
//
//	MultiByteToWideChar( CP_ACP, 0, pcsWebPage, -1, Buffer, Size );
//	URL.bstrVal = SysAllocString( Buffer );
//	GlobalFree( Buffer );
//#else
//	URL.bstrVal = SysAllocString( pcsWebPage );
//#endif
//
//	if ( !URL.bstrVal )
//		goto Error;
//
//	lpWebBrowser2->Navigate2( &URL, 0, 0, 0, 0 );
//
//	VariantClear( &URL );
//
//	lpWebBrowser2->Release();
//
//	return S_OK;
//
//Error:
//	lpWebBrowser2->Release();
//
//	return E_FAIL;
//}