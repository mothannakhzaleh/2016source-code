#pragma once
#include "afxcmn.h"


// CNPCPage dialog

class CNPCPage : public CPropertyPage
{
	DECLARE_DYNAMIC(CNPCPage)

public:
	CNPCPage();
	virtual ~CNPCPage();

// Dialog Data
	enum { IDD = IDD_DIALOG_NPC };

public:
	void ResetPage();
	void RefreshPage();
	void RefreshAllDistance();

	void AddNPCObject(CNPCObject *pNPCObject);
	void RemoveNPCObject(CNPCObject *pNPCObject);

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()

	virtual BOOL OnInitDialog();



private:
	CListCtrl m_NPCList;
};
