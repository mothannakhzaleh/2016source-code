
#ifndef LOG2_H_
#define LOG2_H_

#define _CRT_SECURE_NO_WARNINGS

#include <string>
#include <map>

#ifdef WIN32
#ifndef	_WIN32_WINNT
#define _WIN32_WINNT 0x0501
#endif
#ifndef	_WIN32_WINDOWS
#define _WIN32_WINDOWS 0x501
#endif

#include <windows.h>
#endif

#if 0
extern "C"
{
WINBASEAPI
BOOL
WINAPI
InitializeCriticalSectionAndSpinCount(
    IN OUT LPCRITICAL_SECTION lpCriticalSection,
    IN DWORD dwSpinCount
    );

WINBASEAPI
BOOL
WINAPI
TryEnterCriticalSection(
    IN OUT LPCRITICAL_SECTION lpCriticalSection
    );
};

class CThrdLock
{
public:
	CThrdLock(unsigned long ulSpinCount =4000):m_ulSpinCount(ulSpinCount),m_create(false){Create(false);}
	~CThrdLock(){if(m_create){m_create =false;Lock();DeleteCriticalSection(&m_handle);}}

	bool	Create(bool bInitialOwner)
	{
		if(!m_create)
		{
			InitializeCriticalSectionAndSpinCount(&m_handle,0x80000000 +m_ulSpinCount);
			m_create	=true;
		}
		if(bInitialOwner)
		{
			Lock();
		}
		return m_create;
	}
	operator bool()const				{return m_create;}
	void	Lock()const					{if(m_create){EnterCriticalSection(&m_handle);}}
	BOOL	TryLock()const				{return m_create?TryEnterCriticalSection(&m_handle):0;}
	void	Unlock()const				{if(m_create){LeaveCriticalSection(&m_handle);}}
private:
	bool	m_create;
	unsigned long	m_ulSpinCount;
	mutable CRITICAL_SECTION	m_handle;
};

#else
class CThrdLock
{
public:
    CThrdLock();
    ~CThrdLock();

    void Lock();
    void Unlock();

private:
#ifdef WIN32
    CRITICAL_SECTION _cs;
#endif
};

#endif

#define LOGBUF_SIZE (8 * 1024)

class CLog2
{
public:
    CLog2();
    CLog2(char const* szName, char const* szExt = "log");
    ~CLog2();

    bool Open(char const* szName, char const* szExt = "log");
    void Close();
    bool ReOpen();

    void Enable(bool bEnable = true);
    bool IsEnable() const;
    void Log(char const* szFormat, ...);
	//void Log3(char const* szFormat, ...);
	void LogString(char const* szstring);

	void SetMaxSize( DWORD dwSize );

protected:
    void _Init();
    bool _Open();
	//bool _OpenX();

private:
    bool _bEnable;    

    std::string _strName;
    std::string _strExt;
	long		_dwMaxSize;
	int			_nType;

    FILE* _fp;
    CThrdLock _fpLock;
};
inline void CLog2::Enable(bool bEnable /* = true */)
{
    _bEnable = bEnable;
}
inline bool CLog2::IsEnable() const
{
    return _bEnable;
}
inline bool CLog2::ReOpen()
{
    Close();
    return _Open();
}

class CLog2Mgr
{
private:
    CLog2Mgr();
    virtual ~CLog2Mgr(); //�ͷ��ڴ� Add by Waiting 2009-06-18
    CLog2Mgr(CLog2Mgr const&) {}
    CLog2Mgr& operator=(CLog2Mgr const&) {}    

public:
    static CLog2Mgr* Inst();
	static void Exit(); //�ͷ��ڴ� Add by Waiting 2009-06-18

    static void Enable(bool bEnable = true);
    static bool IsEnable();
    static void EnableMsgBox(bool bEnable = true);
    static bool IsEnableMsgBox();
    static std::string* pstrLogDir;
    static bool bEraseMode;

#ifdef WIN32
    static void SetWnd(HWND hWnd);
    static HWND GetWnd();
#endif

    CLog2* Add(char const* szName, char const* szExt = "log");
    bool Remove(char const* szName);
    void CloseAll();

    void SetDirectory(char const* szDir);
    void GetDirectory(std::string& strDir);

    void Log(char const* szFormat, ...);
    bool LogMgrReopen();

#if 0
    CLogMgr();

    char    m_szDir[255];


    CLog*   Get(const char *pszName);
    void    ClearAll();

    void        Log(FILE *fp, const char *pszLog, bool bMsg, bool bConsole); 
    void        SetCallBack(LOG_PROC pfn);
    void        RunCallBack(const char *pszType, const char *pszContent);
#endif

private:
    static CLog2Mgr* _pSelf;
    static bool _bEnable;
    static bool _bEnableMsgBox;
#ifdef WIN32
    static HWND _hWnd;
#endif

    std::map<std::string, CLog2*> _LogMap;
    CThrdLock _MapLock;

    CLog2 _LogMgr;
};
inline void CLog2Mgr::Enable(bool bEnable /* = true */)
{
    _bEnable = bEnable;
}
inline bool CLog2Mgr::IsEnable()
{
    return _bEnable;
}
inline void CLog2Mgr::EnableMsgBox(bool bEnable /* = true */)
{
    _bEnableMsgBox = bEnable;
}
inline bool CLog2Mgr::IsEnableMsgBox() 
{
    return _bEnableMsgBox;
}
inline bool CLog2Mgr::LogMgrReopen()
{
    return _LogMgr.ReOpen();
}

#ifdef WIN32
inline void CLog2Mgr::SetWnd(HWND hWnd)
{
    _hWnd = hWnd;
}
inline HWND CLog2Mgr::GetWnd()
{
    return _hWnd;
}
#endif

#endif // LOG2_H_
