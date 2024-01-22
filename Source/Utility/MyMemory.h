//=============================================================================
// FileName: MyMemory.h
// Creater: Waiting
// Date: 2009.06.18
//=============================================================================
#ifndef __MY_MEMORY_H
#define __MY_MEMORY_H

#include <windows.h>
#include <tchar.h>
#include "MyAlloc.h"

#ifdef __cplusplus
#ifdef __MEM_DEBUG__
/*--------------------------------------------------------------------------------------------------------------
  重载全局 new, 可能仍然有些地方没有调用到这里, 如果该些对象是你关注的,想法子引用这个头文件,并跟踪确认是否调用
--------------------------------------------------------------------------------------------------------------*/
inline void * __cdecl operator new(size_t size, const char *file, int line) 
{
	void *ptr = (void *)malloc(size); 
	AddTrack(ptr, size, file, line); 
	return(ptr); 
}; 
inline void __cdecl operator delete(void* p, LPCSTR /* lpszFileName */, int /* nLine */)
{
	RemoveTrack(p); 
	free(p);
}; 

inline void __cdecl operator delete[](void* p, LPCSTR /* lpszFileName */, int /* nLine */)
{
	RemoveTrack(p); 
	free(p);
}; 

inline void __cdecl operator delete(void* p)
{
	::operator delete(p,__FILE__,__LINE__);
}

inline void __cdecl operator delete[](void* p)
{
	::operator delete(p,__FILE__,__LINE__);
}

#define DEBUG_NEW new(__FILE__, __LINE__) 
//----------------------------------------
#else//!__MEM_DEBUG__ -> Release Ver.
#define DEBUG_NEW new
#endif//Release
//----------------------------------------
#define new		DEBUG_NEW 
#endif  /* __cplusplus */

/*--------------------------------------------------------------------------------------------------------------
            初始化内存调试
--------------------------------------------------------------------------------------------------------------*/
extern void InitMemoryCheck();
/*--------------------------------------------------------------------------------------------------------------
            结束内存调试,并开始检测未释放的内存
            个别进程、DLL需要分别调用
--------------------------------------------------------------------------------------------------------------*/
extern void EndMemoryCheck();
/*--------------------------------------------------------------------------------------------------------------
            格式化输出数字, 使用千分号, 用于打印内存量
--------------------------------------------------------------------------------------------------------------*/
extern void FormatDollorString(char* szBuf, size_t dwBufSize, size_t dwDollor);

#endif//__MY_MEMORY_H