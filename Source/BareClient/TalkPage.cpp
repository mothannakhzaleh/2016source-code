// TalkPage.cpp : implementation file
//

#include "stdafx.h"
#include "BKop.h"
#include "TalkPage.h"
#include "ChannelControl.h"
#include "ControlCommand.h"
#include "TotalTalkSessionPage.h"
#include "NormalTalkSessionPage.h"
#include "PrivateTalkSessionPage.h"
#include "AutoPublishDlg.h"



// CTalkPage dialog

IMPLEMENT_DYNAMIC(CTalkPage, CPropertyPage)
CTalkPage::CTalkPage()
	: CPropertyPage(CTalkPage::IDD)
{
	m_pChannelPage[CChannelChatMgr::CHANNEL_ALL]=new CTotalTalkSessionPage(CChannelChatMgr::CHANNEL_ALL);
	m_pChannelPage[CChannelChatMgr::CHANNEL_SIGHT]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_SIGHT);
	m_pChannelPage[CChannelChatMgr::CHANNEL_PRIVATE]=new CPrivateTalkSessionPage();
	m_pChannelPage[CChannelChatMgr::CHANNEL_SYSTEM]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_SYSTEM);
	m_pChannelPage[CChannelChatMgr::CHANNEL_PUBLISH]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_PUBLISH);
	m_pChannelPage[CChannelChatMgr::CHANNEL_WORLD]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_WORLD);
	m_pChannelPage[CChannelChatMgr::CHANNEL_TRADE]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_TRADE);
	m_pChannelPage[CChannelChatMgr::CHANNEL_TEAM]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_TEAM);
	m_pChannelPage[CChannelChatMgr::CHANNEL_GUILD]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_GUILD);
	m_pChannelPage[CChannelChatMgr::CHANNEL_SESSION]=new CNormalTalkSessionPage(CChannelChatMgr::CHANNEL_SESSION);
}

CTalkPage::~CTalkPage()
{
	for (int e=CChannelChatMgr::CHANNEL_ALL;e<CChannelChatMgr::CHANNEL_MAX_LIMIT;e++)
	{
		SAFE_DELETE(m_pChannelPage[e]);
	}
	for (int i=0;m_pReleaseArray[i];i++)
	{
		SAFE_DELETE(m_pReleaseArray[i]);
	}
}

void CTalkPage::DoDataExchange(CDataExchange* pDX)
{
	CPropertyPage::DoDataExchange(pDX);
	DDX_Control(pDX, IDC_COMBO_CHANNEL, m_CombChannelSel);
	DDX_Control(pDX, IDC_COMBO_TEXT, m_CombText);
	DDX_Control(pDX, IDC_COMBO_TARGET, m_CombTarget);
	DDX_Control(pDX, IDC_COMBO_COMMAND, m_CombCommand);
	DDX_Control(pDX, IDC_BUTTON_NAME_LIST, m_BtnNameList);
	DDX_Control(pDX, IDC_BUTTON_SEND, m_BtnSend);
}


BEGIN_MESSAGE_MAP(CTalkPage, CPropertyPage)
	ON_MESSAGE(GAME_THREAD_FRESH_CHAT, OnRefreshChannel)
	ON_BN_CLICKED(IDC_BUTTON_SEND, OnBnClickedButtonSend)
	ON_CBN_SELCHANGE(IDC_COMBO_CHANNEL, OnCbnSelchangeComboChannel)
	ON_CBN_SELCHANGE(IDC_COMBO_COMMAND, OnCbnSelchangeComboCommand)
	ON_CBN_SELENDOK(IDC_COMBO_TEXT, OnCbnSelendokComboText)
	ON_WM_CHAR()
	ON_WM_KEYDOWN()
	ON_BN_CLICKED(IDC_BUTTON_AUTO_PUBLISH_MGR, OnBnClickedButtonAutoPublishMgr)
END_MESSAGE_MAP()


// CTalkPage message handlers

BOOL CTalkPage::OnInitDialog()
{
	UpdateData(FALSE);

	int i=0;
	//for (i=0;i<CChannelChatMgr::CHANNEL_MAX_LIMIT;i++)
	//{
	//	m_SheetControl.AddPage(&m_ChannelPage[i]);
	//	m_ChannelPage[i].SetChannel((CChannelChatMgr::eChannel)i);
	//}

	for (i=0;i<CChannelChatMgr::CHANNEL_MAX_LIMIT;i++)
	{
		CPropertyPage* pPage=reinterpret_cast<CPropertyPage*>(m_pChannelPage[i]->GetThisPage());
		m_SheetControl.AddPage(pPage);
	}

	CRect rcSheet;
	GetDlgItem( IDC_STATIC_SHEET_RECT )->GetWindowRect( &rcSheet );
	ScreenToClient( &rcSheet );

	m_SheetControl.EnableStackedTabs(false);
	m_SheetControl.Create(this,WS_CHILD|WS_VISIBLE);
	m_SheetControl.SetWindowPos(NULL,rcSheet.left-5,rcSheet.top-5,0,0,SWP_NOZORDER|SWP_NOSIZE|SWP_NOACTIVATE);
	CTabCtrl* pTabCtrl=m_SheetControl.GetTabControl();
	for (i=0;i<CChannelChatMgr::CHANNEL_MAX_LIMIT;i++)
	{
		CPropertyPage* pPage=reinterpret_cast<CPropertyPage*>(m_pChannelPage[CChannelChatMgr::CHANNEL_MAX_LIMIT-i-1]->GetThisPage());
		m_SheetControl.SetActivePage(pPage);
		TCITEM tcItem;
		tcItem.mask=TCIF_TEXT;
		tcItem.pszText=(LPSTR)(LPCSTR)m_pChannelPage[i]->GetChannelName();
		pTabCtrl->SetItem(i,&tcItem);
	}

	//for (i=0;i<CChannelChatMgr::CHANNEL_MAX_LIMIT;i++)
	//{
	//	m_SheetControl.SetActivePage(&m_ChannelPage[CChannelChatMgr::CHANNEL_MAX_LIMIT-i-1]);
	//	TCITEM tcItem;
	//	tcItem.mask=TCIF_TEXT;
	//	tcItem.pszText=(LPSTR)(LPCSTR)CChannelChatMgr::GetChannelName((CChannelChatMgr::eChannel)i);
	//	pTabCtrl->SetItem(i,&tcItem);
	//}




	m_pReleaseArray[0]=new CChannelControl(this,"All");
	m_pReleaseArray[1]=new CChannelControl(this,"World");
	m_pReleaseArray[2]=new CChannelControl(this,"Trade");
	m_pReleaseArray[3]=new CChannelControl(this,"Team");
	m_pReleaseArray[4]=new CChannelControl(this,"Guild");
	m_pReleaseArray[5]=new CChannelControl(this,"Private Chat");
	m_pReleaseArray[6]=new CChannelControl(this,"GM announcement");
	m_pReleaseArray[7]=new CChannelControl(this,"QQ session");
	m_pReleaseArray[8]=new CChannelControl(this,"Control Command");
	m_pReleaseArray[9]=NULL;
	m_CombChannelSel.SetItemDataPtr(0,(LPVOID)m_pReleaseArray[0]);
	m_CombChannelSel.SetItemDataPtr(1,(LPVOID)m_pReleaseArray[1]);
	m_CombChannelSel.SetItemDataPtr(2,(LPVOID)m_pReleaseArray[2]);
	m_CombChannelSel.SetItemDataPtr(3,(LPVOID)m_pReleaseArray[3]);
	m_CombChannelSel.SetItemDataPtr(4,(LPVOID)m_pReleaseArray[4]);
	m_CombChannelSel.SetItemDataPtr(5,(LPVOID)m_pReleaseArray[5]);
	m_CombChannelSel.SetItemDataPtr(6,(LPVOID)m_pReleaseArray[6]);
	m_CombChannelSel.SetItemDataPtr(7,(LPVOID)m_pReleaseArray[7]);
	m_CombChannelSel.SetItemDataPtr(8,(LPVOID)m_pReleaseArray[8]);
	m_CombChannelSel.SetCurSel(0);


	for (i=0;i<CControlCommand::GetCommandLineCounts();i++)
	{
		if (CControlCommand::IsAvailable(i))
		{
			int nIndex=m_CombCommand.InsertString(i,CControlCommand::GetCommandShowName(i));
			m_CombCommand.SetItemData(nIndex,i);
		}
	}
	m_CombCommand.SetCurSel(0);
	

	return TRUE;
}

void CTalkPage::RefreshCurChannel()
{
	RefreshChannel(GetCurChannel());
}

void CTalkPage::RefreshChannel(CChannelChatMgr::eChannel channel)
{
	if (channel<0 || GetCurChannel()>=CChannelChatMgr::CHANNEL_MAX_LIMIT)
	{
		return;
	}
	m_pChannelPage[GetCurChannel()]->RefreshTotalChannel();
	if (channel==GetCurChannel())
	{
		m_pChannelPage[channel]->RefreshSelfChannel();
	}
}

void CTalkPage::RenewChannel(CChannelChatMgr::eChannel channel)
{
	if (channel!=GetCurChannel() || channel<0 || GetCurChannel()>=CChannelChatMgr::CHANNEL_MAX_LIMIT)
	{
		return;
	}
	m_pChannelPage[channel]->Renew();
}

void CTalkPage::ClearChannel(CChannelChatMgr::eChannel channel)
{
	if (channel!=GetCurChannel() || channel<0 || GetCurChannel()>=CChannelChatMgr::CHANNEL_MAX_LIMIT)
	{
		return;
	}
	m_pChannelPage[channel]->Clear();
}

CChannelChatMgr::eChannel CTalkPage::GetCurChannel()
{
	int n=m_SheetControl.GetTabControl()->GetCurSel();
	if (n<0)
	{
		ASSERT(false);
		return CChannelChatMgr::CHANNEL_ALL;
	}
	else
	{
		if (n>=CChannelChatMgr::CHANNEL_MAX_LIMIT)
		{
			n=CChannelChatMgr::CHANNEL_MAX_LIMIT-1;
		}
		return (CChannelChatMgr::eChannel)n;
	}
}

LRESULT CTalkPage::OnRefreshChannel(WPARAM wParam,LPARAM lParam)
{
	CChannelChatMgr::eChannel channel=(CChannelChatMgr::eChannel)(wParam);
	RefreshChannel(channel);
	return NULL;
}

void CTalkPage::OnPlayerSwitch(CPlayer *pLastPlayer,CPlayer *pNowPlayer)
{
	m_pChannelPage[GetCurChannel()]->Renew();
}

void CTalkPage::OnBnClickedButtonSend()
{
	// TODO: Add your control notification handler code here
	CString strText;
	m_CombText.GetWindowText(strText);
	if (strText.GetLength()>300)
	{
		CString strWarning;
		strWarning.Format("操作失败:输入内容超过300字符,请分开发送(目前共有%d个字符)",strText.GetLength());
		MessageBox(strWarning,"警告");
		m_CombText.SetFocus();
		return;
	}
	if (m_CombText.IsWindowEnabled() && !strText.IsEmpty())
	{
		CString strBuf;
		int nCount=m_CombText.GetCount();
		for (int i=0;i<nCount;i++)
		{
			m_CombText.GetLBText(i,strBuf);
			if (strBuf==strText)
			{
				m_CombText.DeleteString(i);
				break;
			}
		}
		//m_CombText.AddString(strText);
		m_CombText.InsertString(0,strText);
		if (nCount>=20)
		{
			m_CombText.DeleteString(nCount);
		}
		m_CombText.SetWindowText("");
	}
	if (m_CombText.IsWindowEnabled())
	{
		m_CombText.SetFocus();
	}
	int nSel=m_CombChannelSel.GetCurSel();
	CChannelControl *pChannelControl=reinterpret_cast<CChannelControl*>(m_CombChannelSel.GetItemDataPtr(nSel));
	pChannelControl->OnSend(strText);
}

void CTalkPage::OnCbnSelchangeComboChannel()
{
	// TODO: Add your control notification handler code here
	m_CombText.EnableWindow(TRUE);
	int nSel=m_CombChannelSel.GetCurSel();
	CChannelControl *pChannelControl=reinterpret_cast<CChannelControl*>(m_CombChannelSel.GetItemDataPtr(nSel));
	pChannelControl->OnChange();
}

void CTalkPage::OnCbnSelchangeComboCommand()
{
	// TODO: Add your control notification handler code here
	m_CombText.EnableWindow(TRUE);
	int nIndex=(int)m_CombCommand.GetItemData(m_CombCommand.GetCurSel());
	if (CControlCommand::HasTarget(nIndex))
	{
		m_CombTarget.EnableWindow(true);
	}
	else
	{
		m_CombTarget.EnableWindow(false);
	}
	m_CombText.SetWindowText(CControlCommand::GetHelpInfo(nIndex));
	if (CControlCommand::GetParamCounts(nIndex)==0)
	{
		m_CombText.EnableWindow(FALSE);
	}
	else
	{
		m_CombText.SetEditSel(0,-1);
		m_CombText.SetFocus();
	}
}

void CTalkPage::OnCbnSelendokComboText()
{
	// TODO: Add your control notification handler code here
}


void CTalkPage::OnChar(UINT nChar,UINT nRepCnt,UINT nFlags)
{
}

void CTalkPage::OnKeyDown(UINT nChar, UINT nRepCnt, UINT nFlags)
{
	// TODO: Add your message handler code here and/or call default

	CPropertyPage::OnKeyDown(nChar, nRepCnt, nFlags);
}

BOOL CTalkPage::PreTranslateMessage ( LPMSG  lpMsg )
{
	if (lpMsg->message==WM_KEYDOWN && lpMsg->wParam == VK_RETURN)
	{
		COMBOBOXINFO comboInfo;
		comboInfo.cbSize=sizeof(COMBOBOXINFO);
		m_CombText.GetComboBoxInfo(&comboInfo);
		if (comboInfo.hwndItem==lpMsg->hwnd)
		{
			OnBnClickedButtonSend();
			return TRUE;
		}
	}
	return CPropertyPage::PreTranslateMessage(lpMsg);
}

void CTalkPage::OnBnClickedButtonAutoPublishMgr()
{
	// TODO: Add your control notification handler code here
	CAutoPublishDlg pDlg;
	pDlg.DoModal();
}


