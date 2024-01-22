#pragma once


// CSetupPage dialog

class CSetupPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CSetupPage)

public:
	CSetupPage();
	virtual ~CSetupPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_SETUP };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
};
