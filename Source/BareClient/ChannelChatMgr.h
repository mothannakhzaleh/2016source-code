#pragma once

class CChannelChatMgr
{
public:
	enum eChannel
	{
		CHANNEL_ALL=0,				//全部
		CHANNEL_SIGHT=1,			//视野
		CHANNEL_PRIVATE=2,			//私聊
		CHANNEL_SYSTEM=3,			//系统
		CHANNEL_PUBLISH=4,			//公告
		CHANNEL_WORLD=5,			//世界
		CHANNEL_TRADE=6,			//交易
		CHANNEL_TEAM=7,				//队伍
		CHANNEL_GUILD=8,			//公会
		CHANNEL_SESSION=9,			//会议
		CHANNEL_MAX_LIMIT=10		//频道上限
	};

	struct sChatInfo
	{
		eChannel nChannel;
		CString strName;
		CString strText;
	};

public:
	CChannelChatMgr(CPlayer *pPlayer);
	~CChannelChatMgr(void);

	static CString GetChannelName(eChannel channel);
	void AddInfo(eChannel channel,CString strName,CString strInfo);
	void ClearInfo(eChannel channel);
	void ClearPrivateInfo(CString strName);		//清除与某人私聊的信息

	CString GetCurName(eChannel channel);
	CString GetCurText(eChannel channel);
	COLORREF GetCurColor(eChannel channel);

	bool MoveToNext(eChannel channel);
	bool MoveToBegin(eChannel channel);



private:
	static COLORREF GetChannelColor(eChannel channel);


private:
	static CString m_strChannelName[CHANNEL_MAX_LIMIT];
	static COLORREF m_dwChannelColor[CHANNEL_MAX_LIMIT];
	CList<sChatInfo*,sChatInfo*> m_ChannelInfoList[CHANNEL_MAX_LIMIT];
	POSITION m_ChannelPosition[CHANNEL_MAX_LIMIT];
	DWORD m_dwChannelTotalInfoCount[CHANNEL_MAX_LIMIT];
	CStdioFile *m_pFile[CHANNEL_MAX_LIMIT];
	CPlayer *m_pPlayer;
};
