#pragma once

class CTalkPage;

class CChannelControl
{
public:
	CChannelControl(CTalkPage *pTalkPage,CString strChannelName);
	virtual ~CChannelControl(void);

	void OnChange();
	void OnSend(CString strText);

private:
	CTalkPage *m_pTalkPage;
	CString m_strChannelName;
};
