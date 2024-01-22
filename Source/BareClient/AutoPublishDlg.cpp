// AutoPublishDlg.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "PlayerMgr.h"
#include "LoginData.h"
#include "AutoPublishMgr.h"
#include "AutoPublishData.h"
#include "AutoPublishDlg.h"
#include ".\autopublishdlg.h"


// CAutoPublishDlg dialog

IMPLEMENT_DYNAMIC(CAutoPublishDlg, CDialog)
CAutoPublishDlg::CAutoPublishDlg(CWnd* pParent /*=NULL*/)
	: CDialog(CAutoPublishDlg::IDD, pParent)
	, m_Text(_T(""))
{
}

CAutoPublishDlg::~CAutoPublishDlg()
{
}

void CAutoPublishDlg::DoDataExchange(CDataExchange* pDX)
{
	CDialog::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_LIST_INFO, m_lstAutoPublishInfo);
	DDX_Control(pDX, IDC_COMBO2, m_cbxChannel);
	DDX_Control(pDX, IDC_COMBO1, m_cbxPlayerName);
	DDX_Control(pDX, IDC_COMBO3, m_cbxIntervalTime);
	DDX_Control(pDX, IDC_COMBO4, m_cbxRepeatTimes);
	DDX_Control(pDX, IDC_DATETIMEPICKER1, m_dtcTime);
	DDX_Text(pDX, IDC_EDIT_TEXT, m_Text);
	DDV_MaxChars(pDX, m_Text, 400);
}


BEGIN_MESSAGE_MAP(CAutoPublishDlg, CDialog)
	ON_BN_CLICKED(IDC_BUTTON_ADD, OnBnClickedButtonAdd)
	ON_BN_CLICKED(IDC_BUTTON_DEL, OnBnClickedButtonDel)
//	ON_WM_TIMER()
	ON_BN_CLICKED(IDC_BUTTON_GET_NOW_TIME, OnBnClickedButtonGetNowTime)
	ON_WM_TIMER()
	ON_EN_CHANGE(IDC_EDIT1, OnEnChangeEdit1)
	ON_NOTIFY(NM_CLICK, IDC_LIST_INFO, OnNMClickListInfo)
END_MESSAGE_MAP()


// CAutoPublishDlg message handlers

BOOL CAutoPublishDlg::OnInitDialog()
{
	UpdateData(FALSE);
	
	CTime time=CTime::GetCurrentTime();
	m_dtcTime.SetFormat("M month d day H:mm");
	m_dtcTime.SetRange(&time, &(time+CTimeSpan(3,0,0,0)));

	m_lstAutoPublishInfo.SetExtendedStyle(LVS_EX_GRIDLINES|LVS_EX_FULLROWSELECT|LVS_EX_ONECLICKACTIVATE|LVS_EX_FLATSB);
	m_lstAutoPublishInfo.InsertColumn(0,"Publisher",LVCFMT_CENTER,80);
	m_lstAutoPublishInfo.InsertColumn(1,"the server",LVCFMT_CENTER,80);
	m_lstAutoPublishInfo.InsertColumn(2,"SEnd channel",LVCFMT_CENTER,70);
	m_lstAutoPublishInfo.InsertColumn(3,"Start time",LVCFMT_CENTER,110);
	m_lstAutoPublishInfo.InsertColumn(4,"Interval minutes",LVCFMT_CENTER,65);
	m_lstAutoPublishInfo.InsertColumn(5,"Number of reptitions",LVCFMT_CENTER,65);
	m_lstAutoPublishInfo.InsertColumn(6,"Number of times published",LVCFMT_CENTER,65);
	m_lstAutoPublishInfo.InsertColumn(7,"Current status",LVCFMT_CENTER,70);
	m_lstAutoPublishInfo.InsertColumn(8,"Publish content",LVCFMT_LEFT,500);

	m_cbxChannel.AddString("Announcement");
	m_cbxChannel.SetCurSel(0);

	for (int i=3;i<=360;i+=3)
	{
		CString str;
		str.Format("%d",i);
		m_cbxIntervalTime.InsertString(-1,str);
	}
	m_cbxIntervalTime.SetCurSel(0);

	for (int i=1;i<=30;i++)
	{
		CString str;
		str.Format("%d",i);
		m_cbxRepeatTimes.InsertString(-1,str);
	}
	m_cbxRepeatTimes.SetCurSel(0);


	CPlayer *pPlayer=CPlayerMgr::GetFirstPlayer();
	while (pPlayer)
	{
		CString strName=pPlayer->GetMainRole().GetName();
		if (!strName.IsEmpty())
		{
			int nIndex=m_cbxPlayerName.InsertString(-1,strName);
			m_cbxPlayerName.SetItemDataPtr(nIndex,pPlayer);
		}
		pPlayer=CPlayerMgr::GetNextPlayer();
	}
	if (m_cbxPlayerName.GetCount()<=0)
	{
		MessageBox("Warning: No available characters found! Please log in to the game server first!","Automatic Send Manager");
		OnCancel();
		return FALSE;
	}
	m_cbxPlayerName.SetCurSel(0);
	OnRefresh();
	SetTimer(1,800,NULL);
	return TRUE;
}

void CAutoPublishDlg::OnBnClickedButtonGetNowTime()
{
	// TODO: Add your control notification handler code here
	m_dtcTime.SetTime(&CTime::GetCurrentTime());
}

void CAutoPublishDlg::OnBnClickedButtonAdd()
{
	// TODO: Add your control notification handler code here
	UpdateData();
	int nSel=m_cbxPlayerName.GetCurSel();
	CPlayer *pPlayer=reinterpret_cast<CPlayer*>(m_cbxPlayerName.GetItemDataPtr(nSel));
	if (!CPlayerMgr::FindPlayer(pPlayer))
	{
		MessageBox("Error: The role does not exist or has been deleted, adding an automatic message failed!","Automatic Send Manager");
		return;
	}
	CTime ct;
	CString temp;
	int nIntervalTime,nRepeatCount;
	m_dtcTime.GetTime(ct);
	m_cbxIntervalTime.GetWindowText(temp);
	nIntervalTime=atoi(temp);
	m_cbxRepeatTimes.GetWindowText(temp);
	nRepeatCount=atoi(temp);
	if (nIntervalTime<=2 || nIntervalTime>360 || nRepeatCount<=0 || nRepeatCount>=30 || m_Text.IsEmpty())
	{
		MessageBox("Error: Incorrect parameter, failed to add automatic message!","Auto Send Manager");
		return;
	}
	g_AutoPublishMgr.Add(pPlayer,ct,nIntervalTime,nRepeatCount,m_Text);
	m_Text.Empty();
	UpdateData(FALSE);
	OnRefresh();
}

void CAutoPublishDlg::OnBnClickedButtonDel()
{
	// TODO: Add your control notification handler code here
	POSITION pos=m_lstAutoPublishInfo.GetFirstSelectedItemPosition();
	if (pos==NULL) return;
	int nIndex=m_lstAutoPublishInfo.GetNextSelectedItem(pos);
	CAutoPublishData *pData=(CAutoPublishData*)m_lstAutoPublishInfo.GetItemData(nIndex);
	g_AutoPublishMgr.Remove(pData);
	OnRefresh();
}

void CAutoPublishDlg::OnTimer(UINT nIDEvent)
{
	// TODO: Add your message handler code here and/or call default
	if (nIDEvent==1)
	{
		g_AutoPublishMgr.Run();
		OnRefresh();
	}
	CDialog::OnTimer(nIDEvent);
}

void CAutoPublishDlg::OnRefresh()
{
	int nIndex=CB_ERR;
	POSITION pos=m_lstAutoPublishInfo.GetFirstSelectedItemPosition();
	if (pos!=NULL)
	{
		nIndex=m_lstAutoPublishInfo.GetNextSelectedItem(pos);
	}
	m_lstAutoPublishInfo.DeleteAllItems();
	CAutoPublishData *pData;
	for (int i=0;pData=g_AutoPublishMgr.GetAutoPublishData(i);i++)
	{
		CPlayer *pPlayer=pData->GetPlayer();
		CString strName=pData->GetPlayerName();
		CString strServerName=pData->GetServerName();
		CString strTime=pData->GetStartTime().Format("%m month %d day %H:%M:%S");
		CString strInterval;strInterval.Format("%d",pData->GetIntervalTime());
		CString strRepeatCount;strRepeatCount.Format("%d",pData->GetRepeatCount());
		CString strExecuteCount;strExecuteCount.Format("%d",pData->GetExecuteCount());
		if (!CPlayerMgr::FindPlayer(pPlayer))
		{
			pData->SetStateInfo(CAutoPublishData::eInexist);
		}
		if (strName!=pPlayer->GetMainRole().GetName())
		{
			pData->SetStateInfo(CAutoPublishData::ePlayerChanged);
		}
		if (strServerName!=pPlayer->GetLoginData()->GetServiceName())
		{
			pData->SetStateInfo(CAutoPublishData::eServerChanged);
		}
		m_lstAutoPublishInfo.InsertItem(i,strName);
		m_lstAutoPublishInfo.SetItem(i,1,LVIF_TEXT,strServerName,0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,2,LVIF_TEXT,"announcement",0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,3,LVIF_TEXT,strTime,0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,4,LVIF_TEXT,strInterval,0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,5,LVIF_TEXT,strRepeatCount,0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,6,LVIF_TEXT,strExecuteCount,0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,7,LVIF_TEXT,pData->GetStateInfo(),0,0,0,NULL);
		m_lstAutoPublishInfo.SetItem(i,8,LVIF_TEXT,pData->GetText(),0,0,0,NULL);
		m_lstAutoPublishInfo.SetItemData(i,(DWORD_PTR)pData);
	}
	if (nIndex!=CB_ERR)
	{
		GetDlgItem(IDC_BUTTON_DEL)->EnableWindow(true);
		m_lstAutoPublishInfo.SetItemState(nIndex, LVIS_SELECTED, LVIS_SELECTED);
	}
	else
	{
		GetDlgItem(IDC_BUTTON_DEL)->EnableWindow(false);
	}
}

void CAutoPublishDlg::OnEnChangeEdit1()
{
	// TODO:  If this is a RICHEDIT control, the control will not
	// send this notification unless you override the CDialog::OnInitDialog()
	// function and call CRichEditCtrl().SetEventMask()
	// with the ENM_CHANGE flag ORed into the mask.

	// TODO:  Add your control notification handler code here
	UpdateData();
	if (m_Text.IsEmpty())
	{
		GetDlgItem(IDC_BUTTON_ADD)->EnableWindow(false);
	}
	else
	{
		GetDlgItem(IDC_BUTTON_ADD)->EnableWindow(true);
	}
}

void CAutoPublishDlg::OnNMClickListInfo(NMHDR *pNMHDR, LRESULT *pResult)
{
	// TODO: Add your control notification handler code here
	OnRefresh();
	*pResult = 0;
}
