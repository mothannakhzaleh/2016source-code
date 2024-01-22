// LE Console 一个仿Quake的控制台类
// 作为引擎提供的内部调试指令输入和信息反馈使用


#pragma once

typedef const char* (*CMD_FN)(const char *pszCmd);

class LIGHTENGINE_API LEConsole
{

public:
    
    LEConsole();
    
    BOOL			OnCharEvent(char cChar, DWORD dwParam);
    BOOL			OnKeyDownEvent( int nKeyCode );
	
    void			Exec(const char *pszCmd);
    void			Show(BOOL bShow);
    BOOL			IsVisible();
    void			FrameMove();
    void			AddText(const char *pszText);
	void			AddHelp(const char *pszText);
    void			Clear();
	void			SetCmdFN(CMD_FN fn);
    int             GetHeight()           { return _nHeight;   }
	std::list<std::string>*	GetTextList() { return &_TextList; }
	const char*		GetInputText(); 

protected:

    void                    _AddText(const char* pszText, bool bCmd);
    
    char                    _szInput[128];
	char					_szInputTmp[128];
    
	std::list<std::string>            _CmdList;
	std::list<std::string>::iterator  _itCmd;
	std::list<std::string>            _TextList;

	std::list<std::string>            _HelpList;
    
    int                     _nInputCnt;
	BOOL					_bVisible;
    int                     _nWidth;
    int                     _nHeight;
    int                     _nMaxLine;
    DWORD                   _dwCursorTick;
    BOOL                    _bShowCursor;

	CMD_FN					_pfnCmd;
};

inline BOOL LEConsole::IsVisible()
{
    return _bVisible;
}

inline void LEConsole::AddText(const char *pszText)
{
    _AddText(pszText, false);
}

inline void LEConsole::AddHelp(const char *pszText)
{
	_HelpList.push_back(pszText);
}

inline void LEConsole::SetCmdFN(CMD_FN fn)
{
	_pfnCmd = fn;
}

inline const char*	LEConsole::GetInputText()
{ 
	return _szInputTmp;
} 

