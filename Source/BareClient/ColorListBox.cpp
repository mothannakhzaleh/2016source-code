// ColorListBox.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "ColorListBox.h"
#include "PrivateRivalMgr.h"


// CColorListBox

IMPLEMENT_DYNAMIC(CColorListBox, CListBox)
CColorListBox::CColorListBox()
{
}

CColorListBox::~CColorListBox()
{
}


BEGIN_MESSAGE_MAP(CColorListBox, CListBox)
END_MESSAGE_MAP()



// CColorListBox message handlers


void CColorListBox::DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct)
{
	// TODO:  Add your code to draw the specified item

	if ( lpDrawItemStruct->CtlType != ODT_LISTBOX ) return;
	CPrivateRivalMgr::sRivalData* pCurRival=(CPrivateRivalMgr::sRivalData*)lpDrawItemStruct->itemData;
	if (!pCurRival || pCurRival->strName.IsEmpty()) return;
	CString strItemText;
	strItemText.Format("%s(%d/%d)",pCurRival->strName,pCurRival->dwInCounts,pCurRival->dwOutCounts);
	

	CDC dc;

	dc.Attach(lpDrawItemStruct->hDC);
	COLORREF crOldTextColor = dc.GetTextColor();
	COLORREF crOldBkColor = dc.GetBkColor();

	// If this item is selected, set the background color 
	// and the text color to appropriate values. Also, erase
	// rect by filling it with the background color.
	if ((lpDrawItemStruct->itemAction | ODA_SELECT) &&
		(lpDrawItemStruct->itemState & ODS_SELECTED))
	{
		dc.SetTextColor(::GetSysColor(COLOR_HIGHLIGHTTEXT));
		dc.SetBkColor(::GetSysColor(COLOR_HIGHLIGHT));
		dc.FillSolidRect(&lpDrawItemStruct->rcItem, 
			::GetSysColor(COLOR_HIGHLIGHT));
	}
	else
	{
		dc.SetTextColor(CPrivateRivalMgr::GetShowColor(pCurRival));
		dc.FillSolidRect(&lpDrawItemStruct->rcItem, crOldBkColor);
	}

	// If this item has the focus, draw a red frame around the
	// item's rect.
	if ((lpDrawItemStruct->itemAction | ODA_FOCUS) &&
		(lpDrawItemStruct->itemState & ODS_FOCUS))
	{
		CBrush br(RGB(255, 0, 0));
		dc.FrameRect(&lpDrawItemStruct->rcItem, &br);
	}

	// Draw the text.
	dc.DrawText(strItemText, &lpDrawItemStruct->rcItem, DT_LEFT|DT_SINGLELINE|DT_VCENTER);

	// Reset the background color and the text color back to their
	// original values.
	dc.SetTextColor(crOldTextColor);
	dc.SetBkColor(crOldBkColor);

	dc.Detach();
}
