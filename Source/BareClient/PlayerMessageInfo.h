#pragma once

class CPlayerMessageInfo
{
public:
	enum eMessageType
	{//Type of output information
		eNormal=0,			//normal level
		eSystem=1,			//system level
		eDebug=2,			//debug level
	};

	CPlayerMessageInfo(eMessageType eMsgType,CString str);
	~CPlayerMessageInfo(void);
	void SetMessageType(eMessageType eMsgType);
	void SetMessage(CString strMsg);
	void SetMessageColor(COLORREF color);

	eMessageType GetMessageType();
	CString GetMessage();
	COLORREF GetMessageColor();

private:
	const static COLORREF sColorTable[3];
	eMessageType m_eMessageType;
	CString m_strMessage;
	COLORREF m_dwColor;
};
