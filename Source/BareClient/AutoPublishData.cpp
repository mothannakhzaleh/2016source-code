#include "StdAfx.h"
#include "LoginData.h"
#include "PlayerMgr.h"
#include "CommandChat.h"
#include ".\autopublishdata.h"


const static CString strStateInfos[]=
{
	"Executing",
	"Does not exist",
	"Role change",
	"Server change",
	"Timeout interrupt",
	"Finish",
};


CAutoPublishData::CAutoPublishData(CPlayer *pPlayer, CTime ctStartTime, int nIntervalTime, int nRepeatCount, CString strText)
{
	m_pPlayer=pPlayer;
	m_strPlayerName=pPlayer->GetMainRole().GetName();
	m_strServerName=pPlayer->GetLoginData()->GetServiceName();
	m_ctStartTime=ctStartTime;
	m_nIntervalTime=nIntervalTime;
	m_nRepeatCount=nRepeatCount;
	m_strText=strText;
	m_nExecuteCount=0;
	m_eState=eRunning;
}

CAutoPublishData::~CAutoPublishData(void)
{
}

CPlayer *CAutoPublishData::GetPlayer()
{
	return m_pPlayer;
}

CString CAutoPublishData::GetPlayerName()
{
	return m_strPlayerName;
}

CString CAutoPublishData::GetServerName()
{
	return m_strServerName;
}

CTime CAutoPublishData::GetStartTime()
{
	return m_ctStartTime;
}

int CAutoPublishData::GetIntervalTime()
{
	return m_nIntervalTime;
}

int CAutoPublishData::GetRepeatCount()
{
	return m_nRepeatCount;
}

int CAutoPublishData::GetExecuteCount()
{
	return m_nExecuteCount;
}

CString CAutoPublishData::GetText()
{
	return m_strText;
}

bool CAutoPublishData::SetStateInfo(eState state)
{
	if (m_eState!=eRunning) return false;
	m_eState=state;
	return true;
}

CString CAutoPublishData::GetStateInfo()
{
	return strStateInfos[m_eState];
}

void CAutoPublishData::Execute()
{
	if (!CPlayerMgr::FindPlayer(m_pPlayer))
	{
		SetStateInfo(CAutoPublishData::eInexist);
	}
	if (m_strPlayerName!=m_pPlayer->GetMainRole().GetName())
	{
		SetStateInfo(CAutoPublishData::ePlayerChanged);
	}
	if (m_strServerName!=m_pPlayer->GetLoginData()->GetServiceName())
	{
		SetStateInfo(CAutoPublishData::eServerChanged);
	}
	if (m_eState!=eRunning) return;

	CTimeSpan span=CTime::GetCurrentTime()-m_ctStartTime;
	LONGLONG spanTime=span.GetTotalSeconds();						//当前逝去的时间秒数
	if (spanTime<60) return;
	LONGLONG runTime=60+m_nExecuteCount*(m_nIntervalTime*60);		//执行时间的范围=[预约1分钟+当前执行次数(从0起算)*间隔分钟数 , +30秒]
	if (spanTime>=runTime && spanTime<=runTime+30)					//在执行范围时间内,需要执行的
	{
		CCommandChat::Create(m_pPlayer,CCommandChat::ePublish,m_strText);
		m_nExecuteCount++;
		if (m_nRepeatCount==m_nExecuteCount)
		{
			SetStateInfo(eComplete);
		}
	}
	else if (spanTime>runTime+30)
	{
		SetStateInfo(eInterrupt);
	}
}


