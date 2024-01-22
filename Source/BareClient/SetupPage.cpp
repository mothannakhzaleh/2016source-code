// SetupPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "SetupPage.h"


// CSetupPage dialog

IMPLEMENT_DYNAMIC(CSetupPage, CPropertyPage)
CSetupPage::CSetupPage()
	: CPropertyPage(CSetupPage::IDD)
{
}

CSetupPage::~CSetupPage()
{
}

void CSetupPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CSetupPage, CPropertyPage)
END_MESSAGE_MAP()


// CSetupPage message handlers
