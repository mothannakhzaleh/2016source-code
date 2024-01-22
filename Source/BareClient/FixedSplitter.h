#pragma once


// CFixedSplitter frame with splitter

class CFixedSplitter : public CSplitterWnd
{
	DECLARE_DYNCREATE(CFixedSplitter)
public:
	CFixedSplitter();
	virtual ~CFixedSplitter();

protected:

	DECLARE_MESSAGE_MAP()
public:
	afx_msg void OnLButtonDown(UINT nFlags, CPoint point);
	afx_msg void OnMouseMove(UINT nFlags, CPoint point);
	afx_msg BOOL OnSetCursor(CWnd* pWnd, UINT nHitTest, UINT message);
};


