#include "StdAfx.h"
#include ".\playermessageinfo.h"


const COLORREF CPlayerMessageInfo::sColorTable[3]=
{
	RGB(255,255,255),
	RGB(255,255,128),
	RGB(197,197,255)
};


CPlayerMessageInfo::CPlayerMessageInfo(eMessageType eMsgType,CString str)
{
	m_strMessage=str;
	m_eMessageType=eMsgType;
	m_dwColor=0;
}

CPlayerMessageInfo::~CPlayerMessageInfo(void)
{
}

void CPlayerMessageInfo::SetMessageType(eMessageType eMsgType)
{
	m_eMessageType=eMsgType;
}

void CPlayerMessageInfo::SetMessage(CString strMsg)
{
	m_strMessage=strMsg;
}

void CPlayerMessageInfo::SetMessageColor(COLORREF color)
{
	m_dwColor=color;
}

CPlayerMessageInfo::eMessageType CPlayerMessageInfo::GetMessageType()
{
	return m_eMessageType;
}

CString CPlayerMessageInfo::GetMessage()
{
	return m_strMessage;
}

COLORREF CPlayerMessageInfo::GetMessageColor()
{
	if (m_dwColor>0)
	{
		return m_dwColor;
	}
	return sColorTable[m_eMessageType];
}


