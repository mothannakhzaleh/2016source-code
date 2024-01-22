#pragma once


// CMapPage dialog

class CMapPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CMapPage)

public:
	CMapPage();
	virtual ~CMapPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_MAP };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
};
