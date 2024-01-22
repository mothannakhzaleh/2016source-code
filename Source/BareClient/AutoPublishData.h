#pragma once

class CAutoPublishData
{
public:
	enum eState
	{
		eRunning=0,			//执行中
		eInexist=1,			//不存在
		ePlayerChanged=2,	//角色改变
		eServerChanged=3,	//服务器改变
		eInterrupt=4,		//超时中断
		eComplete=5			//完成
	};
	CAutoPublishData(CPlayer *pPlayer, CTime ctStartTime, int nIntervalTime, int nRepeatCount, CString strText);
	~CAutoPublishData(void);

	CPlayer *GetPlayer();
	CString GetPlayerName();
	CString GetServerName();
	CTime GetStartTime();
	int GetIntervalTime();
	int GetRepeatCount();
	int GetExecuteCount();
	CString GetText();

	bool SetStateInfo(eState state);
	CString GetStateInfo();

	void Execute();

private:
	CPlayer *m_pPlayer;
	CString m_strPlayerName;
	CString m_strServerName;
	CTime m_ctStartTime;
	int m_nIntervalTime;
	int m_nRepeatCount;
	int m_nExecuteCount;
	CString m_strText;
	eState m_eState;
};
