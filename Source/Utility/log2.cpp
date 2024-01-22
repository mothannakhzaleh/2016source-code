
#include "log2.h"
#include "util2.h"
#include <errno.h>
#include <assert.h>
#include "MyMemory.h" //跟踪内存分配 Add by Waiting 2009-06-18
#include "CPerformance.h" //跟踪效率 Add by Waiting 2009-06-18
#include <stdexcept>

CLog2::CLog2() : _fp(NULL), _fpLock(), _strName(""), _strExt("")
{
    _bEnable = true;
	_nType = 0;
	SetMaxSize(100 * 1024 * 1024);
}
CLog2::CLog2(char const* szName, char const* szExt /* = "log" */)
: _fp(NULL), _fpLock(), _strName(szName), _strExt(szExt)
{
    _bEnable = true;
	_nType = 0;
	SetMaxSize(100 * 1024 * 1024);
    if (!_Open()) throw std::runtime_error("Open file failed\n");
}
CLog2::~CLog2()
{
    Close();
	_nType = 0;
}
bool CLog2::Open(char const* szName, char const* szExt)
{
    if (_fp != NULL) return false;

    _strName = szName;
    _strExt = szExt;
    return _Open();
}
void CLog2::SetMaxSize( DWORD dwSize )
{
	_dwMaxSize = dwSize;
}
bool CLog2::_Open()
{
    if (_fp != NULL) 
		return false;
	if( !CLog2Mgr::pstrLogDir ) //Add by Waiting 2009-06-18
		return false;
	std::string str = *CLog2Mgr::pstrLogDir;
	str += '/';
	str += _strName;
	if (_strExt.length() > 0)
	{
		str += ".";
		str += _strExt;
	}

    _fpLock.Lock();

	do 
    {
        if (_fp != NULL)
            break;

        try
        {
            if (CLog2Mgr::bEraseMode)
            {
                _fp = fopen(str.c_str(), "wt");
  				//_fp = _fsopen(str.c_str(), "wt", _SH_DENYNO);
            }
            else
            {
                _fp = fopen(str.c_str(), "at+");
				//_fp = _fsopen(str.c_str(), "at+", _SH_DENYNO);

                if (_fp == NULL)
                {
					printf("bool CLog2::_Open() == NULL\n");
                    _fp = fopen(str.c_str(), "wt");
  					//_fp = _fsopen(str.c_str(), "wt", _SH_DENYNO);
              }
            }
        }
        catch (...)
        {
			printf("bool CLog2::_Open() 2\n");
			break;
        }
    }
    while (0);
    _fpLock.Unlock();

    return (_fp == NULL) ? false : true;
}

//bool CLog2::_OpenX()
//{
//	if (_fp != NULL && _nType != 0) return false;
//
//	std::string str = *CLog2Mgr::pstrLogDir;
//	str += '/';
//	str += _strName;
//	if (_strExt.length() > 0)
//	{
//		str += ".";
//		str += _strExt;
//	}    
//
//	_fpLock.Lock();
//	do 
//	{
//		if (_fp != NULL)
//		{
//			Close();
//		}
//
//		try
//		{
//			_fp = fopen(str.c_str(), "rt+");
//			//_fp = _fsopen(str.c_str(), "rt+", _SH_DENYNO);
//
//			if (_fp == NULL)
//			{
//				_fp = fopen(str.c_str(), "wt");
//				//_fp = _fsopen(str.c_str(), "wt", _SH_DENYNO);
//			}
//			_nType = 1;
//		}
//		catch (...)
//		{
//			printf("bool CLog2::_OpenX()\n");
//		}
//	}
//	while (0);
//	_fpLock.Unlock();
//
//	return (_fp == NULL) ? false : true;
//}

void CLog2::Close()
{
    if (_fp != NULL)
    {
        _fpLock.Lock();
        try
        {
            fclose(_fp);
            _fp = NULL;
			_nType = 0;
        }
        catch (...)
        {
			printf("void CLog2::Close()\n");
        }
        _fpLock.Unlock();
    }
}

void CLog2::LogString(char const* szString)
{
	Log("%s", szString);
}

void CLog2::Log(char const* szFormat, ...)
{
    _Open();

	if(_fp == NULL)
		return;

    bool bMsgBox = false;
    if ((strlen(szFormat) > 3) && (strncmp(szFormat, "msg", 3) == 0))
    {
        bMsgBox = true;
    }

    char szBuf[LOGBUF_SIZE] = {0};
    va_list list;
    va_start(list, szFormat);
    if (bMsgBox)
    {
        //vsprintf(szBuf, szFormat + 3, list);
		_vsnprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, szFormat + 3, list);
    }
    else
    {
        //vsprintf(szBuf, szFormat, list);
		_vsnprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, szFormat, list);
    }
    va_end(list);

    char buf[LOGBUF_SIZE] = {0};
    SYSTEMTIME st;
    char tim[100] = {0};
    GetLocalTime(&st);
    //sprintf(tim, "%02d-%02d %02d:%02d:%02d", st.wMonth, st.wDay, st.wHour,
	_snprintf_s(tim, sizeof(tim), _TRUNCATE, "%02d-%02d %02d:%02d:%02d", st.wMonth, st.wDay, st.wHour,
            st.wMinute, st.wSecond);

    if (bMsgBox)
    {
        //sprintf(buf, "[%s][MSG]%s", tim, szBuf);
		_snprintf_s(buf, sizeof(buf), _TRUNCATE, "[%s][MSG]%s", tim, szBuf);
    }
    else
    {
        //sprintf(buf, "[%s]%s", tim, szBuf);
		_snprintf_s(buf, sizeof(buf), _TRUNCATE, "[%s]%s", tim, szBuf);
    }

    // Log
    _fpLock.Lock();
    try
    {
        fprintf(_fp, "%s", buf);
        fflush(_fp);
    }
    catch (...)
    {
		printf("void CLog2::Log(char const* szFormat, ...)\n");
    }
    _fpLock.Unlock();

    // MsgBox
#ifdef WIN32
    if (bMsgBox && CLog2Mgr::IsEnableMsgBox())
    {
        MessageBox(CLog2Mgr::GetWnd(), szBuf, "LOG", 0);
    }
#endif
}

//void CLog2::Log3(char const* szFormat, ...)
//{
//	_OpenX();
//
//	bool bMsgBox = false;
//	if ((strlen(szFormat) > 3) && (strncmp(szFormat, "msg", 3) == 0))
//	{
//		bMsgBox = true;
//	}
//
//	char szBuf[LOGBUF_SIZE] = {0};
//	va_list list;
//	va_start(list, szFormat);
//	if (bMsgBox)
//	{
//		//vsprintf(szBuf, szFormat + 3, list);
//		_vsnprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, szFormat + 3, list);
//	}
//	else
//	{
//		//vsprintf(szBuf, szFormat, list);
//		_vsnprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, szFormat, list);
//	}
//	va_end(list);
//
//	char buf[LOGBUF_SIZE] = {0};
//	SYSTEMTIME st;
//	char tim[100] = {0};
//	GetLocalTime(&st);
//	//sprintf(tim, "%02d-%02d %02d:%02d:%02d", st.wMonth, st.wDay, st.wHour,
//	_snprintf_s(tim, sizeof(tim), _TRUNCATE, "%02d-%02d %02d:%02d:%02d", st.wMonth, st.wDay, st.wHour,
//		st.wMinute, st.wSecond);
//
//	if (bMsgBox)
//	{
//		//sprintf(buf, "[%s][MSG]%s", tim, szBuf);
//		_snprintf_s(buf, sizeof(buf), _TRUNCATE, "[%s][MSG]%s", tim, szBuf);
//	}
//	else
//	{
//		//sprintf(buf, "[%s]%s", tim, szBuf);
//		_snprintf_s(buf, sizeof(buf), _TRUNCATE, "[%s]%s", tim, szBuf);
//	}
//
//	// Log
//	_fpLock.Lock();
//	try
//	{
//		if( ftell(_fp) >= _dwMaxSize )
//		{
//			fseek(_fp, 0, SEEK_SET);
//		}
//
//		fprintf(_fp, "%s", buf);
//		fflush(_fp);
//	}
//	catch (...)
//	{
//		printf("void CLog2::Log3(char const* szFormat, ...)\n");
//	}
//	_fpLock.Unlock();
//
//	// MsgBox
//#ifdef WIN32
//	if (bMsgBox && CLog2Mgr::IsEnableMsgBox())
//	{
//		MessageBox(CLog2Mgr::GetWnd(), szBuf, "LOG", 0);
//	}
//#endif
//}



//////////////////////////////////////////////////////////////////////////
//
//  CLog2Mgr class
//
//
CLog2Mgr* CLog2Mgr::_pSelf = NULL;
bool CLog2Mgr::_bEnable;
bool CLog2Mgr::_bEnableMsgBox;
std::string* CLog2Mgr::pstrLogDir = NULL;
bool CLog2Mgr::bEraseMode = false;
#ifdef WIN32
HWND CLog2Mgr::_hWnd;
#endif

CLog2Mgr::CLog2Mgr() : _MapLock(), _LogMap()
{
    _setmaxstdio(2048);

    _bEnable = true;
    _bEnableMsgBox = true;
    pstrLogDir = new std::string("log");

#ifdef WIN32
    _hWnd = NULL;
#endif

    SetDirectory(pstrLogDir->c_str());
    _LogMgr.Open("LGMgr");
}

/*-----------------------------------------
   释放内存 Add by Waiting 2009-06-18
-----------------------------------------*/
CLog2Mgr::~CLog2Mgr()
{
	CloseAll();
}

CLog2Mgr* CLog2Mgr::Inst()
{
    static bool bInit = false;

    if (!bInit)
    {
        static CThrdLock Lock;
        Lock.Lock();
        if (!bInit)
        {
            try
            {
                CLog2Mgr::_pSelf = new CLog2Mgr();
                bInit = true;
            }
            catch (std::bad_alloc&)
            {
#ifdef WIN32
                IP("Failed to new CLog2Mgr\n");
#endif
				printf("Failed to new CLog2Mgr\n");
            }
            catch (std::runtime_error& le)
            {
#ifdef WIN32
                IP(le.what());
#endif
				printf(le.what());
                delete CLog2Mgr::_pSelf;
                CLog2Mgr::_pSelf = NULL;
            }
            catch (...)
            {
#ifdef WIN32
                IP("Unknown exception raised from CLog2Mgr::Inst()\n");
#endif
				printf("Unknown exception raised from CLog2Mgr::Inst()\n");
                delete CLog2Mgr::_pSelf;
                CLog2Mgr::_pSelf = NULL;
            }
        }
        Lock.Unlock();
    }
	assert(_pSelf);
    return CLog2Mgr::_pSelf;
}

/*-----------------------------------------
   释放内存 Add by Waiting 2009-06-18
-----------------------------------------*/
void CLog2Mgr::Exit()
{
	SAFE_DELETE(_pSelf);
	SAFE_DELETE(pstrLogDir);
}

// 本函数功能包括检查字符串中GBK双字节汉字字符的完整性、网络包中字符串的完整性等。
// name为只允许有大小写字母数字和汉字（去除全角空格）才返回true;
void MakeFileNameValid(char *name)
{
	if( NULL==name || !name[0] )
		return;
	unsigned char *l_name =reinterpret_cast<unsigned char *>(name);
	size_t len = strlen(name);
	bool l_ishan =false;
	unsigned short i;
	for(i=0;i<len;i++)
	{
		if(!l_name[i])
		{
			break;
		}
		else if(l_ishan) //汉字尾
		{
			if(l_name[i-1] ==0xA1 && l_name[i] ==0xA1)	//过滤全角空格
			{
				l_name[i-1] = l_name[i] = '_';
			}
			else if(l_name[i] >0x3F && l_name[i] <0xFF && l_name[i] !=0x7F)
			{
			}
			else
			{
				l_name[i-1] = l_name[i] = '_';
			}
			l_ishan = false; //下一个不是汉字尾了
		}
		else if(l_name[i]>0x80 && l_name[i] <0xFF) //汉字头
		{
			l_ishan	=true; //下一个接汉字尾
		}
		else if( (l_name[i] >='A' && l_name[i] <='Z') ||
			     (l_name[i] >='a' && l_name[i] <='z') ||
			     (l_name[i] >='0' && l_name[i] <='9') ||
				 (l_name[i] == '@') || 
				 (l_name[i] == '.') )
		{
			//允许
		}
		else
		{
			l_name[i] = '_';
		}
	}
	//最后一个字节是汉字的头，但是没有尾，把头换成'_'
	if( l_ishan && i )
	{
		l_name[i-1] = '_';
	}
}



CLog2* CLog2Mgr::Add(char const* szName, char const* szExt /* = "log" */)
{
    CLog2* pLog = NULL;
    _MapLock.Lock();
    try
    {
		char szFileName[MAX_PATH];
		strncpy_s(szFileName, MAX_PATH, szName,_TRUNCATE);
		MakeFileNameValid(szFileName);

        std::map<std::string, CLog2*>::iterator it = _LogMap.find(szFileName);
        if (it != _LogMap.end())
        {
            pLog = (*it).second;
        }
        else
        {
            try
            {
                pLog = new CLog2(szFileName, szExt);
            }
            catch (std::bad_alloc&)
            {
				printf("Failed to new CLog2([])\n");
                _LogMgr.Log("Failed to new CLog2([%s.%s])\n", szFileName, szExt);
            }
            catch (std::runtime_error& le)
            {
				printf("Failed to new CLog2([])2\n");
                _LogMgr.Log(le.what());
                delete pLog;
                pLog = NULL;
            }
            catch (...)
            {
				printf("Failed to new CLog2([])3\n");
                _LogMgr.Log("Unknown exception raised from new [%s.%s]\n", szFileName, szExt);
                delete pLog;
                pLog = NULL;
            }

            if (pLog != NULL)
            {
                _LogMap[szFileName] = pLog;
                _LogMgr.Log("Add LG [%s]\n", szFileName);
            }
        }
    }
    catch (...)
    {
		printf("Failed to new CLog2([])4\n");
    }
    _MapLock.Unlock();

    return pLog;
}
bool CLog2Mgr::Remove(char const* szName)
{
    _LogMgr.Log("Remove LG [%s]\n", szName);

    bool ret;
    _MapLock.Lock();
    try
    {
        std::map<std::string, CLog2*>::iterator it = _LogMap.find(szName);
        if (it != _LogMap.end())
        {
            CLog2* pLog = (*it).second;
            _LogMap.erase(it);
            delete pLog;
            ret = true;
        }
        else
        {
            ret = false;
        }
    }
    catch (...)
    {
		printf("Unknown excepton raised from CLog2Mgr::Remove([])\n");
        _LogMgr.Log("Unknown excepton raised from CLog2Mgr::Remove([%s])\n", szName);
        ret = false;
    }
    _MapLock.Unlock();

    return ret;
}
void CLog2Mgr::CloseAll()
{
    _LogMgr.Log("Close All LG\n");

    CLog2* pLog = NULL;
    _MapLock.Lock();
    try
    {
        DWORD dwBegin = ::GetTickCount();
        DWORD dwClose = 0;

        std::map<std::string, CLog2*>::iterator it = _LogMap.begin();
        while (it != _LogMap.end())
        {
            pLog = (*it).second;

            DWORD dwBegin = ::GetTickCount();
            pLog->Close();
			SAFE_DELETE(pLog); //释放内存 Add by Waiting 2009-06-18
            DWORD dwEnd = ::GetTickCount();
            dwClose += dwEnd - dwBegin;

            ++ it;
        }
		_LogMap.clear(); //释放内存 Add by Waiting 2009-06-18

        DWORD dwEnd = ::GetTickCount();
        _LogMgr.Log("CloseAll consume %ds\n", (dwEnd - dwBegin) / 1000);
        _LogMgr.Log("Close consume %ds\n", dwClose / 1000);
    }
    catch (...)
    {
		printf("Unknown excepton raised from CLog2Mgr::CloseAll()\n");
        _LogMgr.Log("Unknown excepton raised from CLog2Mgr::CloseAll()\n");
    }
    _MapLock.Unlock();
}
void CLog2Mgr::SetDirectory(char const* szDir)
{
    *pstrLogDir = szDir;
    Util_MakeDir(szDir);
}
void CLog2Mgr::GetDirectory(std::string& strDir)
{
    strDir = *pstrLogDir;
}
void CLog2Mgr::Log(char const* szFormat, ...)
{
    char szBuf[LOGBUF_SIZE] = {0};
    
    va_list list;
    va_start(list, szFormat);
    //vsprintf(szBuf, szFormat, list);
	_vsnprintf_s(szBuf, sizeof(szBuf), _TRUNCATE, szFormat, list);
    va_end(list);

    _LogMgr.Log(szBuf);
}


//////////////////////////////////////////////////////////////////////////
//
//  CThrdLock class
//
//

#if 0
#else

CThrdLock::CThrdLock()
{
#ifdef WIN32
    InitializeCriticalSection(&_cs);
#endif
}
CThrdLock::~CThrdLock()
{
#ifdef WIN32
    DeleteCriticalSection(&_cs);
#endif
}
void CThrdLock::Lock()
{
#ifdef WIN32
    EnterCriticalSection(&_cs);
#endif
}
void CThrdLock::Unlock()
{
#ifdef WIN32
    LeaveCriticalSection(&_cs);
#endif
}

#endif