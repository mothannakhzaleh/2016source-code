// ScriptPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "ScriptPage.h"


// CScriptPage dialog

IMPLEMENT_DYNAMIC(CScriptPage, CPropertyPage)
CScriptPage::CScriptPage()
	: CPropertyPage(CScriptPage::IDD)
{
}

CScriptPage::~CScriptPage()
{
}

void CScriptPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CScriptPage, CPropertyPage)
END_MESSAGE_MAP()


// CScriptPage message handlers
