#pragma once


// CScriptPage dialog

class CScriptPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CScriptPage)

public:
	CScriptPage();
	virtual ~CScriptPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_SCRIPT };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
};
