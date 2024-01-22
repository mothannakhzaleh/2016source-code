#pragma once


// CColorListBox

class CColorListBox : public CListBox
{
	DECLARE_DYNAMIC(CColorListBox)

public:
	CColorListBox();
	virtual ~CColorListBox();

protected:
	DECLARE_MESSAGE_MAP()
public:
	virtual void DrawItem(LPDRAWITEMSTRUCT lpDrawItemStruct);
};


