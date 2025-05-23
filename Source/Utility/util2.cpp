#include "util2.h"
#include <time.h>
#include <list>
#include "Iphlpapi.h"
#include "MyMemory.h"

#pragma comment(lib, "Iphlpapi.lib")

#ifdef _DEBUG
#ifdef _GAMECORE
	#include "new.h"
    #define new DEBUG_NEW
#endif
#endif
// Cross Platform Util Functions ttt

BOOL g_bFirstLog		= TRUE;
HANDLE __hStdOut		= NULL;
FILE *g_fpLog			= NULL;
BOOL  g_bBinaryTable	= FALSE;



// BOOL g_bRNLog = TRUE;

// char g_szLog[512];
	
void Log(LPCSTR szFormat , ...)
{
	return;
}

// BOOL g_bFirstLog2 = TRUE;
// FILE *g_fpLog2 = NULL;

void Error(LPCSTR szFormat , ...)
{
	return;
}

// DWORD g_dwStartTime[32], g_dwEndTime[32], g_dwCurRecord = 0;

// void StartTimeRecord()
// {
// 	if (g_dwCurRecord < 32)
// 	{
// 		g_dwStartTime[g_dwCurRecord] = timeGetTime();
// 		g_dwCurRecord ++;
// 	}
// }

// DWORD EndTimeRecord()
// {
// 	if (g_dwCurRecord > 0)
// 	{
// 		g_dwCurRecord --;
// 		g_dwEndTime[g_dwCurRecord] = timeGetTime();
// 		DWORD dwElapsedTime = g_dwEndTime[g_dwCurRecord] - g_dwStartTime[g_dwCurRecord];
// 		
// 		return dwElapsedTime;
// 	}
// 
// 	return 0;
// }

// void CreateConsole(int width, int height)
// {
// 	AllocConsole();
//     SetConsoleTitle("Debug Window");
//     __hStdOut = GetStdHandle(STD_OUTPUT_HANDLE); // ->standard output HANDLE
//     COORD co = {width , height};
//     SetConsoleScreenBufferSize(__hStdOut, co); // set buf size
// }


void Util_TrimString(std::string &str)
{
	char *psz = (char*)(str.c_str());
	size_t nSize = str.size();
	char *pNew = new char[nSize + 1];
	int n = 0;
	for(int i = 0 ; i < (int)nSize ; i++)
	{
		char c = psz[i];
		if(c!=' ' && c!= '\t')
		{
			pNew[n] = c;
			n++;
		}
	}
	pNew[n] = '\0';
	str = pNew;
	delete[] pNew;
}


// 修正英文 MAKEBIN 空格丢失问题  modify by Philip.Wu  2006-07-31
void Util_TrimTabString(std::string &str)
{
	char *psz = (char*)(str.c_str());
	size_t nSize = str.size();
	char *pNew = new char[nSize + 1];
	int n = 0;
	for(int i = 0 ; i < (int)nSize ; i++)
	{
		char c = psz[i];
		//if(c!=' ' && c!= '\t')	
		if(c!= '\t')
		{
			pNew[n] = c;
			n++;
		}
	}
	pNew[n] = '\0';
	str = pNew;
	delete[] pNew;
}


long Util_GetFileSize(FILE *fp)
{
    if(fp==NULL) return -1;
    DWORD dwOldLoc = ftell(fp);
    fseek(fp , 0 , SEEK_END);
    DWORD dwSize = ftell(fp);
    fseek(fp , dwOldLoc , SEEK_SET);
    return dwSize;
}

long Util_GetFileSizeByName(char *pszFileName)
{
    //FILE *fp = fopen(pszFileName , "rb");
	FILE *fp = NULL;
	if(fopen_s(&fp, pszFileName , "rb") != 0)
		return -1;

	if(fp == NULL)
		return -1;

    long lSize =  Util_GetFileSize(fp);
    fclose(fp);
    return lSize;
}

unsigned long Util_GetSysTick()
{
#ifdef WIN32
    return GetTickCount();
#endif

#ifdef LINUX
    timeval tv;
    gettimeofday(&tv , NULL);
    return (tv.tv_sec * 1000 + tv.tv_usec/1000);
#endif
}


void Util_Sleep(int ms)
{
#ifdef WIN32
    Sleep(ms);
#endif

#ifdef LINUX
    usleep(ms * 1000);
#endif
}

bool Util_IsFileExist(char *pszName)
{
    //if(access(pszName , 0)== -1) return false;
	if(_access_s(pszName , 0) != 0) return false;
    return true;
}

bool Util_MakeDir(const char* lpPath)
{
     std::string pathname = lpPath;
     if(lpPath[pathname.size() - 1]!='/')    pathname+="/";

     std::string::size_type end = (int)pathname.rfind('/');

     //int pt = (int)pathname.find('/');
	 std::string::size_type pt = (int)pathname.find('/');

     if (pathname[pt-1] == ':')         pt = pathname.find('/', pt+1);

     std::string path;

     while(pt!=-1 && pt<=end)
     {
         path = pathname.substr(0 , pt + 1);
         //if(access(path.c_str() , 0) == -1) 
		 if(_access_s(path.c_str() , 0) != 0) 
         {
#ifdef WIN32
             //mkdir(path.c_str());
			 _mkdir(path.c_str());
#endif

#ifdef LINUX
             
          int mode = S_IRWXU | S_IRWXG;
          mkdir(path.c_str() , mode);
#endif
         }
         pt = pathname.find('/' , pt+1);
     }
     return true;
}

int  Util_ResolveTextLine1(const char *pszText , std::string strList[] ,
						  int nMax, int nSep)
{
    if(pszText==NULL) 
    {
        return 0;
    }
    int  nResult   = 0;
    char *pszDest  = (char*)pszText;
    char *pszFound = NULL;
    do
    {
        pszFound = strchr(pszDest , nSep);
        if(pszFound!=NULL)
        {
            //int p = pszFound - pszDest;
			intptr_t p = pszFound - pszDest;

            pszDest[p] = '\0'; // trick , we need save result string
            strList[nResult] = pszDest;
            pszDest[p] = nSep; // we should not change source string
            pszDest = pszFound + 1;
            int nSkip = Util_StringSkip(&pszDest , nSep);
            if(pszDest[0]=='\0')
            {
                nResult++;
                break;
            }
        }
        else
        {
            strList[nResult] = pszDest;
        }
        nResult++;
        if(nResult>=nMax) 
        {
            break;
        }
    
    }while(pszFound);
    
    return nResult;
}

int  Util_ResolveTextLine(const char *pszText , std::string strList[] ,
                          int nMax, int nSep, int nSep2)
	{
	if (pszText == NULL || strlen(pszText) == 0) return 0;

	// 如果没用分割符，或源串只有1个字符
	if ((nSep == 0 && nSep2 == 0) || (strlen(pszText) == 1))
		{
		strList[0] = pszText;
		return 1;
		}

	int nResult = 0;
	if ((nSep != 0) && (nSep2 != 0) && (nSep != nSep2))
		{
		// 同时支持两个，空格和制表符
		std::string lstrList[80];
		int n1 = 0;
		int n2 = 0;

		// 看字符串中是否有两种间隔符
		char* pszFound1 = NULL;
		char* pszFound2 = NULL;
        pszFound1 = (char*)strchr(pszText, nSep);
		pszFound2 = (char*)strchr(pszText, nSep2);

		if ((pszFound1 == NULL) || (pszFound2 == NULL))
			{
			// 只有一种分隔符或都没有
			if (pszFound1 != NULL)
				nResult = Util_ResolveTextLine1(pszText, strList, nMax, nSep);
			else if (pszFound2 != NULL)
				nResult = Util_ResolveTextLine1(pszText, strList, nMax, nSep2);
			else
				{
				// 两种分隔符都没有
				strList[0] = pszText;
				return 1;
				}
			}
		else
			{
			// 两种分隔符都有
			std::string newString;

			// 先去掉第一个
			n1 = Util_ResolveTextLine1(pszText, lstrList, nMax, nSep);

			// 将剩余的重新连接起来
			for (int i = 0; i < n1; ++ i)
				{
				newString += lstrList[i] + char(nSep2);
				}

			// 再去除第二个
			char const* p = newString.c_str();
			n2 = Util_ResolveTextLine1(newString.c_str(), strList, nMax, nSep2);
			nResult = n2;
			}
		}
	else
		{
		// 只有一个，nSep和nSep2可能相同
		int sep = 0;
		if (nSep != 0) sep = nSep;
		else sep = nSep2;

		nResult = Util_ResolveTextLine1(pszText, strList, nMax, sep);
		}
	
	return nResult;
	}


const struct tm* Util_GetCurTime()
{
    static tm *g_tm;
    time_t l;  time(&l);
    //g_tm = localtime(&l);
	_localtime64_s(g_tm, &l);
    return g_tm;
/*
tm_sec
Seconds after minute (0 – 59)

tm_min
Minutes after hour (0 – 59)

tm_hour
Hours after midnight (0 – 23)

tm_mday
Day of month (1 – 31)

tm_mon
Month (0 – 11; January = 0)

tm_year
Year (current year minus 1900)

tm_wday
Day of week (0 – 6; Sunday = 0)

tm_yday
Day of year (0 – 365; January 1 = 0)

tm_isdst
Positive value if daylight saving time is in effect; 0 if daylight saving time is not in effect; negative value if status of daylight saving time is unknown. The C run-time library assumes the United States’s rules for implementing the calculation of Daylight Saving Time (DST). 
*/

}


const char* Util_CurTime2String(int nFlag)
{
    static char g_szTime[96];
    time_t l;  time(&l);
    //struct tm *t = localtime(&l);
	tm *t = NULL;
	_localtime64_s(t, &l);

    switch(nFlag)
    {
        case 0:
            {
                //strcpy(g_szTime, asctime(t));
				asctime_s(g_szTime, sizeof(g_szTime), t);
                break;
            }
        case 1:
            {
                //sprintf(g_szTime, "%04d-%02d-%02d_%02d-%02d-%02d", t->tm_year + 1900, t->tm_mon + 1, t->tm_mday, t->tm_hour, t->tm_min, t->tm_sec);
				_snprintf_s(g_szTime, sizeof(g_szTime), _TRUNCATE, "%04d-%02d-%02d_%02d-%02d-%02d", t->tm_year + 1900, t->tm_mon + 1, t->tm_mday, t->tm_hour, t->tm_min, t->tm_sec);
                break;
            }
        case 2:
            {
                //sprintf(g_szTime, "%02d-%02d-%02d", t->tm_hour, t->tm_min, t->tm_sec);
				_snprintf_s(g_szTime, sizeof(g_szTime), _TRUNCATE, "%02d-%02d-%02d", t->tm_hour, t->tm_min, t->tm_sec);
                break;
            }
        case 3:
            {
                //sprintf(g_szTime, "%d", t->tm_wday);
				_snprintf_s(g_szTime, sizeof(g_szTime), _TRUNCATE, "%d", t->tm_wday);
                break;
            }
        default:
            {
                //strcpy(g_szTime, "");
				strncpy_s(g_szTime, sizeof(g_szTime), "", _TRUNCATE);
                break;
            }
    }
    return g_szTime;
}

std::string GetMacString()
{
	std::string strRet="";
	IP_ADAPTER_INFO CheckBuf;
	ULONG outLen=0;
	if (GetAdaptersInfo(&CheckBuf,&outLen)!=ERROR_SUCCESS)
	{
		PIP_ADAPTER_INFO pAdpterInfo=( IP_ADAPTER_INFO* )HeapAlloc( GetProcessHeap(), HEAP_ZERO_MEMORY, outLen );
		if (GetAdaptersInfo(pAdpterInfo,&outLen)==ERROR_SUCCESS)
		{
			char lpBuf[8];
			for (int i=0; i<MAX_ADAPTER_ADDRESS_LENGTH; i++)
			{
				//sprintf(lpBuf,"%.2X",pAdpterInfo->Address[i]);
				//TODO
				_snprintf_s(lpBuf, sizeof(lpBuf), "%.2X",pAdpterInfo->Address[i], _TRUNCATE);

				strRet+=lpBuf;
				if (i+1<MAX_ADAPTER_ADDRESS_LENGTH)
				{
					strRet+="-";
				}
			}
		}
		HeapFree(GetProcessHeap(), 0, pAdpterInfo );
	}
	return strRet;
}

void ProcessDirectory(const char *pszDir, std::list<std::string>* pFileList, int nOperateFlag)
{
#ifdef WIN32    
    _finddata_t filestruct;
    int p  = 0;
    int fn = 0;
    char szSearch[255];
    if(strlen(pszDir)==0)
    {
        //strcpy(szSearch , "*.*");
		strncpy_s(szSearch , sizeof(szSearch), "*.*", _TRUNCATE);
    }
    else
    {
        //strcpy(szSearch , pszDir);
		strncpy_s(szSearch ,sizeof(szSearch), pszDir, _TRUNCATE);
        //strcat(szSearch , "/*.*");
		strncat_s(szSearch , sizeof(szSearch), "/*.*", _TRUNCATE);
    }

    //int hnd = _findfirst(szSearch , &filestruct);
	intptr_t hnd = _findfirst(szSearch , &filestruct);
    if(hnd==-1) 
    {
        return;
    }
    do
    { 	
	    char szFullName[255];
	    if(strlen(pszDir) > 0)
        {
            //sprintf(szFullName , "%s/%s" , pszDir , filestruct.name);
			_snprintf_s(szFullName , sizeof(szFullName), _TRUNCATE, "%s/%s" , pszDir , filestruct.name);
        }
        else
        {
            //strcpy(szFullName , filestruct.name);
			strncpy_s(szFullName ,sizeof(szFullName), filestruct.name, _TRUNCATE);
        }
	  	
        if(!(filestruct.attrib & _A_SUBDIR)) 
	    {
            switch(nOperateFlag)
            {
                case DIRECTORY_OP_QUERY:
                {
                    if(pFileList) pFileList->push_back(szFullName);
                    break;
                }
                case DIRECTORY_OP_DELETE:
                {
                    remove(szFullName); 
                    break;
                }
            }
	    }
	    else // Directory
	    {
		    if(strcmp(filestruct.name , "..")!=0 && strcmp(filestruct.name , ".")!=0)
		    {
			    ProcessDirectory(szFullName, pFileList, nOperateFlag);
            }
	    }
    }while(!_findnext(hnd , &filestruct)); 
#endif

#ifdef LINUX
    int nLen = strlen(pszDir);
    DIR *dir;
    if(nLen==0)
    {
        dir = opendir(".");
    }
    else
    {
        dir = opendir(pszDir);
    }
    if(dir!=NULL)
    {
	    int n;
  	    direct *dd;
  	    while(dd = readdir(dir))
        {
			if(strcmp(dd->d_name, ".")!=0 && strcmp(dd->d_name, "..")!=0)
			{
			    char szFullName[255];
                strcpy(szFullName , pszDir);
                if(pszDir[nLen - 1]!='/' && (nLen > 0))
				{
  					strcat(szFullName, "/");
				}
                strcat(szFullName , dd->d_name);
                struct stat stat_p;
                stat(szFullName , &stat_p);
				if(S_ISDIR(stat_p.st_mode)) // is directory
				{
          	        ProcessDirectory(szFullName, pFileList, nOperateFlag);
                }
                else if(S_ISREG(stat_p.st_mode)) // is file
                {
			        switch(nOperateFlag)
                    {
                        case DIRECTORY_OP_QUERY:
                        {
                            if(pFileList) pFileList->push_back(szFullName);
                            break;
                        }
                        case DIRECTORY_OP_DELETE:
                        {
                            remove(szFullName); 
                            break;
                        }
                    }
                }
            } // end !("."|"..")
        } // end white                     	
    } // dir is exist 
    else
    {
        // Log("ERR : Directory [%s] is not exist\n" ,  pszDir);
    }
#endif
}


//---------------------------------------------------------------
// <example>
//
// string str; Util_RelaceString("abcdefg%naf%", "%", "\%", str);
//
//---------------------------------------------------------------
//int Util_RelaceString(const char *pszSrc, const char *s1, const char *s2, std::string &str)
std::string::size_type Util_RelaceString(const char *pszSrc, const char *s1, const char *s2, std::string &str)
{
    //int nReplace = 0;
	std::string::size_type nReplace = 0;
    std::string s(pszSrc);
    //int nLen1 = strlen(s1);
	std::string::size_type nLen1 = strlen(s1);
    //int nLen2 = strlen(s2);
	std::string::size_type nLen2 = strlen(s2);
    //int nBegin = 0;
	std::string::size_type nBegin = 0;
    while(1)
    {
        //int p = s.find(s1, nBegin);
		std::string::size_type p = s.find(s1, nBegin);
        if(p==-1) break;
        s.replace(p, nLen1, s2, nLen2); 
        nReplace++;
        nBegin = p + nLen2;
    }
    str = s;
    return nReplace;
}



