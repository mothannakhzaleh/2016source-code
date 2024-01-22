// MapPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "MapPage.h"


// CMapPage dialog

IMPLEMENT_DYNAMIC(CMapPage, CPropertyPage)
CMapPage::CMapPage()
	: CPropertyPage(CMapPage::IDD)
{
}

CMapPage::~CMapPage()
{
}

void CMapPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
}


BEGIN_MESSAGE_MAP(CMapPage, CPropertyPage)
END_MESSAGE_MAP()


// CMapPage message handlers
