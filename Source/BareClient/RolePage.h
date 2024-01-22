#pragma once
#include "afxwin.h"
#include "afxcmn.h"


// CRolePage dialog

class CRolePage : public CPropertyPage
{
	DECLARE_DYNAMIC(CRolePage)

public:
	CRolePage();
	virtual ~CRolePage();

// Dialog Data
	enum { IDD = IDD_DIALOG_ROLE };


public:
	void ResetPage();
	void RefreshPage();
	void RefreshMapPosition();

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV support

	DECLARE_MESSAGE_MAP()
	virtual BOOL OnInitDialog();

	afx_msg void OnBnClickedButtonAddStr();
	afx_msg void OnBnClickedButtonAddDex();
	afx_msg void OnBnClickedButtonAddAgi();
	afx_msg void OnBnClickedButtonAddVit();
	afx_msg void OnBnClickedButtonAddSta();
	afx_msg void OnBnClickedButtonAddLuk();
	void AddAttribute(WORD attrID);


public:
	CStatic m_strName;
	CStatic m_strLevel;
	CStatic m_strHP;
	CStatic m_strSP;
	CProgressCtrl m_prgHP;
	CProgressCtrl m_prgSP;
	CStatic m_strEXP;
	CProgressCtrl m_prgEXP;
	CStatic m_strEXPPercent;
	CStatic m_strSTR;
	CStatic m_strDEX;
	CStatic m_strAGI;
	CStatic m_strVIT;
	CStatic m_strSTA;
	CStatic m_strLUK;
	CStatic m_strAttributePoint;
	CStatic m_strSkillPoint;
	CListCtrl m_StateList;
	CStatic m_strMoney;
	CStatic m_strMapName;
	CStatic m_strMapPosition;
};
