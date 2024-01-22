#pragma once

#include "PlayerMessageInfo.h"

class CPlayerMessage
{
public:
	CPlayerMessage(CPlayer *pPlayer);
	~CPlayerMessage(void);
	int GetMessageCount();
	int GetNewMessageCount();
	CString GetCurMsg();
	COLORREF GetCurMsgColor();
	CPlayerMessageInfo::eMessageType GetCurMsgType();
	bool GetSystemMessageFilter();
	bool GetDebugMessageFilter();
	bool GetFilterBeforeAdd();
	static bool GetOnlyAddMainPlayerMessage();

	void ClearAll();
	bool MoveToNext();						//Index movement without parameter filter check, return: true means there is a message, false means there is no message
	bool MoveToBegin();						//Index movement without parameter filter check, return: true means there is a message, false means there is no message
	bool MoveToNextAvailable();				//Index movement with parameter filter check, return: true means there is a message, false means there is no message and the pointer will move to the end
	bool MoveToFirstAvailable();			//Index movement with parameter filter check, return: true means there is a message, false means there is no message and the pointer will move to the end
	void SetSystemMessageFilter(bool bFilter);
	void SetDebugMessageFilter(bool bFilter);
	void SetFilterBeforeAdd(bool bYes);		//Determine whether to filter messages before adding information
	static void SetOnlyAddMainPlayerMessage(bool bYes);		//Only add information for the current user

	bool AddMsg(CString str,...);			//Add general information, may fail (return false)
	bool AddSystemMsg(CString str,...);		//Add system messages, affected by m_bFilterBeforeAdd and m_bSystemFilter, may fail (return false)
	bool AddDebugMsg(CString str,...);		//Add debug messages, affected by m_bFilterBeforeAdd and m_bDebugFilter, may fail (return false)
	bool AddCustomMsg(CPlayerMessageInfo::eMessageType type,COLORREF color,CString str,...);	//Add custom message, affected by input parameter type and internal parameters m_bFilterBeforeAdd, m_bSystemFilter and m_bDebugFilter, may fail (return false)
	void AddToMessageArray(CPlayerMessageInfo* msg);		//add the message to the array

private:
	inline void IndexBoundCorrect(int &index);	//Fix out-of-range index values so that their values wrap around (circular arrays)

private:
	static bool volatile m_bOnlyAddMainPlayerMessage;
	CPlayer *m_pPlayer;
	CPtrArray m_MsgObject;
	int m_nMsgStartIndex;		//Points to the beginning of the array, which may or may not be valid (invalid when m_nMsgStartIndex==m_nMsgEndIndex)
	int m_nMsgCurrentIndex;		//Point to the current index value, the range is between m_nMsgStartIndex and m_nMsgEndIndex, when m_nMsgCurrentIndex==m_nMsgEndIndex, this value is invalid
	int m_nMsgEndIndex;			//Always point to a new array index with no value
	bool m_bSystemFilter;
	bool m_bDebugFilter;
	bool m_bFilterBeforeAdd;
	DWORD m_dwTotalMessageCounts;
};
