#include "StdAfx.h"
#include "SelfObject.h"
#include "LoginData.h"
#include ".\channelchatmgr.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CString CChannelChatMgr::m_strChannelName[CHANNEL_MAX_LIMIT]=
{
	"All",
	"Vision",
	"Private chat",
	"System",
	"Announcement",
	"World",
	"Trade",
	"Team",
	"Guild",
	"Session"
};

COLORREF CChannelChatMgr::m_dwChannelColor[CHANNEL_MAX_LIMIT]=
{
	RGB(255,255,255),	//全部,待转换
	RGB(187,236,233),	//视野
	RGB(255,222,86),	//私聊
	RGB(255,128,255),	//系统
	RGB(255,192,128),	//公告
	RGB(255,255,255),	//世界
	RGB(128,192,255),	//交易
	RGB(51,255,0),		//队伍
	RGB(255,255,0),		//公会
	RGB(100,128,255)	//会话
};


CChannelChatMgr::CChannelChatMgr(CPlayer *pPlayer)
{
	for (int i=0;i<CHANNEL_MAX_LIMIT;i++)
	{
		m_ChannelPosition[i]=NULL;
		m_dwChannelTotalInfoCount[i]=0;
		m_pFile[i]=NULL;
	}
	m_pPlayer=pPlayer;
}

CChannelChatMgr::~CChannelChatMgr(void)
{
	for (int i=0;i<CHANNEL_MAX_LIMIT;i++)
	{
		ClearInfo((eChannel)i);
		SAFE_DELETE(m_pFile[(eChannel)i]);
	}
}

CString CChannelChatMgr::GetChannelName(CChannelChatMgr::eChannel channel)
{
	ASSERT(channel>=0 && channel<CHANNEL_MAX_LIMIT);
	return m_strChannelName[channel];
}

COLORREF CChannelChatMgr::GetChannelColor(eChannel channel)
{
	ASSERT(channel>=0 && channel<CHANNEL_MAX_LIMIT);
	return m_dwChannelColor[channel];
}

void CChannelChatMgr::AddInfo(eChannel channel,CString strName,CString strInfo)
{
	sChatInfo *pChatInfo=new sChatInfo;
	pChatInfo->nChannel=channel;
	pChatInfo->strName=strName;

	m_dwChannelTotalInfoCount[channel]++;
	pChatInfo->strText.Format("(%d)[%s]%s",m_dwChannelTotalInfoCount[channel],GetChannelName(channel),strInfo);
	pChatInfo->strText=CTime::GetCurrentTime().Format("<%H:%M:%S>")+pChatInfo->strText;

	m_ChannelInfoList[channel].AddTail(pChatInfo);
	if (m_ChannelInfoList[channel].GetCount()>CHAT_CHANNEL_INFORMATION_MAXNUM)
	{
		POSITION pos=m_ChannelInfoList[channel].GetHeadPosition();
		SAFE_DELETE(m_ChannelInfoList[channel].GetHead());
		m_ChannelInfoList[channel].RemoveHead();
		if (pos==m_ChannelPosition[channel])
		{
			m_ChannelPosition[channel]=m_ChannelInfoList[channel].GetHeadPosition();
		}
	}
	if (channel!=CHANNEL_ALL)
	{
		//添加到"全部"频道
		sChatInfo *pChatInfo=new sChatInfo;
		pChatInfo->nChannel=channel;
		pChatInfo->strName=strName;

		m_dwChannelTotalInfoCount[CHANNEL_ALL]++;
		pChatInfo->strText.Format("(%d)[%s]%s",m_dwChannelTotalInfoCount[CHANNEL_ALL],GetChannelName(channel),strInfo);
		pChatInfo->strText=CTime::GetCurrentTime().Format("<%H:%M:%S>")+pChatInfo->strText;

		m_ChannelInfoList[CHANNEL_ALL].AddTail(pChatInfo);
		if (m_ChannelInfoList[CHANNEL_ALL].GetCount()>CHAT_CHANNEL_INFORMATION_MAXNUM)
		{
			POSITION pos=m_ChannelInfoList[CHANNEL_ALL].GetHeadPosition();
			SAFE_DELETE(m_ChannelInfoList[CHANNEL_ALL].GetHead());
			m_ChannelInfoList[CHANNEL_ALL].RemoveHead();
			if (pos==m_ChannelPosition[CHANNEL_ALL])
			{
				m_ChannelPosition[CHANNEL_ALL]=m_ChannelInfoList[CHANNEL_ALL].GetHeadPosition();
			}
		}
	}
	//---保存到日志文件
	if (channel==CHANNEL_PRIVATE)
	{
		CPrivateRivalMgr::sRivalData* pRival=m_pPlayer->GetChatMgr().GetPrivateRivalMgr().FindRival(strName);
		if (pRival->pFile)
		{
			CString strText;
			strText.Format("(%d)[%s]%s",m_dwChannelTotalInfoCount[channel],GetChannelName(channel),strInfo);
			strText=CTime::GetCurrentTime().Format("<%y-%m-%d %H:%M:%S>")+strText;
			pRival->pFile->WriteString(strText+"\n");
			//pRival->pFile->WriteString(pChatInfo->strText+"\n");
		}
	}
	else if (channel!=CHANNEL_ALL)
	{
		if (!m_pFile[channel])
		{
			CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
			if (!pSelf)
			{
				return;
			}
			CString strSelfName=pSelf->GetName();
			CString strPathName="Chat\\";
			CreateDirectory(strPathName,NULL);
            strPathName+=m_pPlayer->GetLoginData()->GetServiceName();
            strPathName+="\\";
            CreateDirectory(strPathName,NULL);
			strPathName+=strSelfName+"\\";
			CreateDirectory(strPathName,NULL);
			strPathName+=CChannelChatMgr::GetChannelName(channel)+"\\";
			CreateDirectory(strPathName,NULL);
			strPathName+=m_pPlayer->GetLoginData()->GetServiceName();
			strPathName+=CTime::GetCurrentTime().Format(" %Y-%m-%d %H点%M分.txt");
			m_pFile[channel]=new CStdioFile();
			if (!m_pFile[channel]->Open(strPathName,CFile::modeCreate|CFile::modeNoTruncate|CFile::shareDenyWrite|CFile::modeWrite|CFile::typeText))
			{
				SAFE_DELETE(m_pFile[channel]);
				return;
			}
			m_pFile[channel]->SeekToEnd();
		}
		CString strText;
		strText.Format("(%d)[%s]%s",m_dwChannelTotalInfoCount[channel],GetChannelName(channel),strInfo);
		strText=CTime::GetCurrentTime().Format("<%y-%m-%d %H:%M:%S>")+strText;
		m_pFile[channel]->WriteString(strText+"\n");

		//m_pFile[channel]->WriteString(pChatInfo->strText+"\n");
	}
}

void CChannelChatMgr::ClearInfo(eChannel channel)
{
	POSITION pos=m_ChannelInfoList[channel].GetHeadPosition();
	while (pos)
	{
		sChatInfo *pChatInfo=m_ChannelInfoList[channel].GetNext(pos);
		SAFE_DELETE(pChatInfo);
	}
	m_ChannelInfoList[channel].RemoveAll();
	m_ChannelPosition[channel]=NULL;
}

void CChannelChatMgr::ClearPrivateInfo(CString strName)
{
	POSITION pos=m_ChannelInfoList[CHANNEL_PRIVATE].GetHeadPosition();
	while (pos)
	{
		POSITION pos2=pos;
		sChatInfo *pChatInfo=m_ChannelInfoList[CHANNEL_PRIVATE].GetNext(pos2);
		if (pChatInfo->strName==strName)
		{
			m_ChannelInfoList[CHANNEL_PRIVATE].RemoveAt(pos);
			SAFE_DELETE(pChatInfo);
		}
		pos=pos2;
	}
	m_ChannelPosition[CHANNEL_PRIVATE]=NULL;
}

CString CChannelChatMgr::GetCurName(eChannel channel)
{
	if (!m_ChannelPosition[channel])
	{
		return NULL;
	}
	return m_ChannelInfoList[channel].GetAt(m_ChannelPosition[channel])->strName;
}

CString CChannelChatMgr::GetCurText(eChannel channel)
{
	if (!m_ChannelPosition[channel])
	{
		return NULL;
	}
	return m_ChannelInfoList[channel].GetAt(m_ChannelPosition[channel])->strText;
}

COLORREF CChannelChatMgr::GetCurColor(eChannel channel)
{
	if (!m_ChannelPosition[channel])
	{
		return GetChannelColor(channel);
	}
	eChannel curChannel=m_ChannelInfoList[channel].GetAt(m_ChannelPosition[channel])->nChannel;
	return GetChannelColor(curChannel);
}

bool CChannelChatMgr::MoveToNext(eChannel channel)
{
	if (!m_ChannelPosition[channel])
	{
		m_ChannelPosition[channel]=m_ChannelInfoList[channel].GetHeadPosition();
		if (m_ChannelPosition[channel])
		{
			return true;
		}
	}
	else
	{
		POSITION pos=m_ChannelPosition[channel];
		m_ChannelInfoList[channel].GetNext(pos);
		if (pos)
		{
			m_ChannelPosition[channel]=pos;
			return true;
		}
	}
	return false;
}

bool CChannelChatMgr::MoveToBegin(eChannel channel)
{
	m_ChannelPosition[channel]=m_ChannelInfoList[channel].GetHeadPosition();
	return (m_ChannelPosition[channel])?true:false;
}
