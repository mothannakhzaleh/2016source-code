// FixedSplitter.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "FixedSplitter.h"
#include ".\fixedsplitter.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

// CFixedSplitter

IMPLEMENT_DYNCREATE(CFixedSplitter, CSplitterWnd)

CFixedSplitter::CFixedSplitter()
{
}

CFixedSplitter::~CFixedSplitter()
{
}

BEGIN_MESSAGE_MAP(CFixedSplitter, CSplitterWnd)
	ON_WM_LBUTTONDOWN()
	ON_WM_MOUSEMOVE()
	ON_WM_SETCURSOR()
END_MESSAGE_MAP()


// CFixedSplitter message handlers

void CFixedSplitter::OnLButtonDown(UINT nFlags, CPoint point)
{
	// TODO: Add your message handler code here and/or call default

	CWnd::OnLButtonDown(nFlags, point);
}

void CFixedSplitter::OnMouseMove(UINT nFlags, CPoint point)
{
	// TODO: Add your message handler code here and/or call default

	CWnd::OnMouseMove(nFlags, point);
}

BOOL CFixedSplitter::OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message)
{
	// TODO: Add your message handler code here and/or call default

	return CWnd::OnSetCursor(pWnd, nHitTest, message);
}
