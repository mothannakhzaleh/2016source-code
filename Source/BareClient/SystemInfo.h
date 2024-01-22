#pragma once

#include "afxmt.h"
//class CList;

class CSystemInfo
{
	enum eInfoLevel
	{//输出信息的级别模式
		eLeast=0,			//最小级别
		eNormal=1,			//普通级别
		eSystem=2,			//系统级别
		eDebug=3,			//调试级别
		eDetailDebug=4		//详细的调试级别
	};
	enum eColor
	{
		eLeastColor=RGB(255,255,255),
		eNormalColor=RGB(197,197,197),
		eSystemColor=RGB(255,255,128),
		eDebugColor=RGB(255,255,127),
		eDetailDebugColor=RGB(192,192,255)
	};
public:
	CSystemInfo(void);
	~CSystemInfo(void);
	static void InitArraySize(DWORD dwSize);

	//最小级别
	static void Add(int nPlayerIndex,CString str,...);
	//普通级别
	static void AddInfo(int nPlayerIndex,CString str,...);
	//系统级别
	static void AddSystemInfo(int nPlayerIndex,CString str,...);
	//调试级别
	static void AddDebugInfo(int nPlayerIndex,CString str,...);
	//详细的调试级别
	static void AddDetailDebugInfo(int nPlayerIndex,CString str,...);

	static void Open();
    static void Close();
	static void ResetAllPosition();
	static void ResetPosition(int index);
	static void DeleteInfo(int nPlayerIndex);
	static void DeleteAllInfos();
	static DWORD GetNextInfoOrder(int nPlayerIndex);
	static CString GetNowLine(int nPlayerIndex);
	static COLORREF GetNowLineColor(int nPlayerIndex);
	static eInfoLevel GetNowLineLevel(int nPlayerIndex);
	static bool MoveNext(int nPlayerIndex);

	//static CString GetNowLine();
	//static COLORREF GetNowLineColor();
	//static bool MoveNext();

private:
	struct sInfo
	{
		DWORD nIndex;
		DWORD dwMsgCounts;
		eInfoLevel eLevel;
		COLORREF dwColor;
		CString strInfo;
	};
	static DWORD m_TotalMsg;
	typedef CList<sInfo,sInfo&> LInfo;
	static CArray<LInfo,LInfo&> m_InfoArray;
	static CArray<int,int&> m_IndexArray;
	static CArray<POSITION,POSITION&> m_dwArrayPos;
	static LInfo m_Infos;
	static CCriticalSection m_CriticalSection;
	static bool volatile m_bClose;
};
