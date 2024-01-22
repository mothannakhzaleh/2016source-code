#include "StdAfx.h"
#include "LEConsole.h"
#include "LERender.h"


LEConsole::LEConsole()
:_pfnCmd(NULL), _dwCursorTick( 0 ), _bVisible(FALSE)
{
    strncpy_s(_szInput, "", _TRUNCATE);
	strncpy_s(_szInputTmp, "", _TRUNCATE);
    _nHeight  = 140;
    _nWidth   = 450;
    _nMaxLine = (_nHeight - 18) / 16;
    
    for(int i = 0; i < _nMaxLine ; i++)
    {
        _TextList.push_back("");
    }
    
    AddText("Begin of LightEngine Engine");

    _itCmd = _CmdList.begin();
    
    for(int y = 0; y < 13; y++)
    {
        g_Render.Print(INFO_CMD, _nWidth + 2,  y * 12, "|");
    }
    g_Render.Print(INFO_CMD, 0, _nHeight + 4,      "____________________________________________________________________________");
    // g_Render.Print(INFO_CMD, 3, _nHeight - 2, "]");
    // g_Render.Print(INFO_CMD, _nWidth - 98, _nHeight + 14, "LightEngine Engine Console");
}

BOOL LEConsole::OnKeyDownEvent(int nKeyCode)
{
    if(!IsVisible()) return FALSE;
    
    switch(nKeyCode)
    {
        case VK_UP:
        {
            if(_CmdList.size()==0) break;
            _itCmd--;
            strncpy_s(_szInput, (*_itCmd).c_str(), _TRUNCATE );
            if(_itCmd==_CmdList.begin())
            {
                _itCmd = _CmdList.end();
            }
            if(_bShowCursor)	_snprintf_s(_szInputTmp,128, _TRUNCATE ,"]%s_", _szInput);
			else				_snprintf_s(_szInputTmp, 128, _TRUNCATE ,"]%s", _szInput);
			break;
		}
    }
    return TRUE;
}


BOOL LEConsole::OnCharEvent(TCHAR iChar, DWORD dwParam)
{
// #if defined(DEBUG) | defined(_DEBUG)
//     if(iChar=='`')
//     {
//         Show(!IsVisible());
//         return TRUE;
//     }
// #endif
    if(!IsVisible()) return FALSE;
    
    int nLen = (int)(strlen(_szInput));
    if(iChar=='\r')
    {
		if(nLen==0) return TRUE;
        
        string str = ">"; str+=_szInput; 
        _AddText(str.c_str(), false);
        
		if(_pfnCmd)
		{
			_AddText(_pfnCmd(_szInput), false);
		}
        
		if(strcmp(_szInput, "programmer")==0)
		{
			_AddText("                LightEngine Stars                       ",  false);
			_AddText("                                                        ",  false);
			_AddText("ModelSystem & ResourceManage & Lighting ....... JackLi",    false);
			_AddText("EffectSystem & Camera & Font .................. LemonWang", false);
			_AddText("TerrainSystem & SceneEditor ................... RyanWang",  false);
			_AddText("                                                        ",  false);
			_AddText("Project Leader ................................ RyanWang",  false);
		}
		
		_AddText(_szInput, true);
        
        strncpy_s(_szInput, "", _TRUNCATE);
    }
    else if(iChar=='\t')
    {
    }
    else if(iChar==0x08)
    {
		if(nLen==0) return TRUE;
        
        BYTE cFirst = _szInput[nLen - 1];
		if ( cFirst >> 7 ) 
        {
			_szInput[nLen - 2] = '\0';
			_szInput[nLen - 1] = '\0';
		}
		else 
        {
			_szInput[nLen - 1] = '\0';
		}
    }
    else if(nLen < 48)
    {
        _szInput[nLen]     = iChar;
        _szInput[nLen + 1] = '\0';
    }
	
	if(_bShowCursor)	_snprintf_s(_szInputTmp, 128,_TRUNCATE,"]%s_", _szInput);
	else				_snprintf_s(_szInputTmp, 128,_TRUNCATE,"]%s", _szInput);
	
	return TRUE;
}

void LEConsole::_AddText(const char *pszText, bool bCmd)
{
    if(strlen(pszText)==0) return;
    list<string> *pList = &_TextList;
    if(bCmd)
    {
        pList = &_CmdList;
    }
    int nSize = (int)pList->size();
    if(nSize > _nMaxLine)
    {
        pList->pop_front();
    }
    pList->push_back(pszText);
    
    if(bCmd) 
    {
        _itCmd = pList->end();
        return;
    }
}

void LEConsole::Show(BOOL bShow)
{
    _bVisible = bShow; 
}

void LEConsole::FrameMove() // π‚±Í…¡∂Ø
{
    DWORD dwTick = GetTickCount();
    if(_dwCursorTick==0) _dwCursorTick = dwTick;
    if((dwTick - _dwCursorTick) < 500) return;
    
    _dwCursorTick = dwTick;

    _bShowCursor = !_bShowCursor;

	if(_bShowCursor)	_snprintf_s(_szInputTmp, 128, _TRUNCATE,"]%s_", _szInput);
	else				_snprintf_s(_szInputTmp, 128, _TRUNCATE,"]%s", _szInput);
}

void LEConsole::Clear()
{
    _TextList.clear();
    for(int i = 0; i < _nMaxLine ; i++)
    {
        _TextList.push_back("");
    }
}
