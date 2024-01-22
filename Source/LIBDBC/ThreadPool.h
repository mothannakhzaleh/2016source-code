//================================================================
// It must be permitted by Dabo.Zhang that this program is used for
// any purpose in any situation.
// Copyright (C) Dabo.Zhang 2000-2003
// All rights reserved by ZhangDabo.
// This program is written(created) by Zhang.Dabo in 2000.3
// This program is modified recently by Zhang.Dabo in 2003.7
//=================================================================
#ifndef THREADPOOL_H
#define THREADPOOL_H

#ifndef USING_TAO				//使用Win32基本Platform SDK
#include <winsock2.h>			//确保调用新的WinSock2.2版本
#include <windows.h>
#else
#include "TAOSpecial.h"
#endif

#include "DBCCommon.h"
#include "excp.h"
#include "PreAlloc.h"

_DBC_BEGIN
#pragma pack(push)
#pragma pack(4)

#ifdef USING_IOCP
// Delete by lark.li 20081103

#else	//NOT_USE_IOCP************************************************************************
/*
	下面是不能使用IOCP平台的线程池实现
*/
class Task;
class TaskQue;
class Thread;
class ThrdQue;
class TaskWait;

#define	NOTWAITSTATE	(0x3FFFFFFF)

/**
 * @file ThreadPool.H
 * @class ThreadPool 
 * @author ZhangDabo
 * @brief 线程池对象,使用CreatePool进行池的创建，不直接调用构造函数
 * @bug 
 */
class ThreadPool										//线程池对象
{
	friend class Thread;
public:
	/**
	* @brif 创建一个线程池
	* @param[in]  idle  空闲的线程数
	* @param[in]  max  最大的线程数
	* @param[in]  taskmaxnum  最大任务数
	* @param[in]  nPriority  线程优先级
	*
	* @return ThreadPool 创建新的线程
	*
	* #exception EXCP 线程池初始化线程对象申请内存失败
	*/
	static ThreadPool* CreatePool(long idle=0,long max=0x10,long taskmaxnum=0x100 ,int nPriority=THREAD_PRIORITY_NORMAL);

	/**
	* @brif 删除一个线程池
	*/ 
	void DestroyPool();

	/**
	* @brif 追加一个任务
	* @param[in]  task  追加的任务
	*/
	void AddTask(Task *task);

	/**
	* @brif 追加一个任务
	* @param[in]  task  等待的任务
	*/
	long WaitForTask(Task *task);

	/**
	* @brif 得到线程池任务数
	*/
	long GetTaskCount();

	/**
	* @brif
	*/
	long getCurr()			{return m_curr;}			//性能监测要求。
	long getCurrFree()		{return m_currfree;}		//性能监测要求。

	InterLockedLong			m_taskexitflag;
private:
	ThreadPool(long idle,long max,long taskmaxnum,int nPriority);
	virtual ~ThreadPool();
	void ThreadExcute(Thread *);
	inline Task	* PoolProcess(Thread *l_myself);

private:
	InterLockedLong			m_exitflag;
	const int				m_nPriority;
	const long				m_max,m_idle;
	volatile long			m_curr,m_currfree;

	TaskQue	*	volatile	m_taskQue;
	ThrdQue	*	volatile	m_thrdQue;
};

/**
 * @file ThreadPool.H
 * @class Task 
 * @author ZhangDabo
 * @brief 任务抽象类，由线程池使用
 * @bug 
 */
class Task{												//任务抽象类
	friend class ThreadPool;
	friend class TaskQue;
public:
	/**
	* @brif 构造函数
	*/
	Task():__canwait(false),__ThisThread(0),__TaskQue(0),__nexttask(0),__taskwait(0)
	{
		__mtxtaskwait.Create(false);
		if(!__mtxtaskwait)
		{
			//THROW_EXCP(excpSync,"任务对象建立操作系统同步对象错误");
		  throw excpSync("Create sync mutex failed!");
		}
	};
	/**
	* @brif 取得退出标志
	*/
	bool				GetExitFlag();
protected:

	/**
	* @brif 析造函数
	*/
	virtual				~Task(){}
	
	/**
	* @brif 释放资源
	*/
	virtual	Task	*	Lastly(){Free();return 0;}
	
	/**
	* @brif 取到线程句柄
	*
	* @return HANDLE 线程句柄
	*/
	HANDLE				GetHandle();					//获取处理线程的句柄
	
	/**
	* @brif 获取处理线程的标志ID
	*
	* @return DWORD 线程的标志ID
	*/
	DWORD				GetThreadID();					//获取处理线程的标志ID
private:
	virtual	void		Free(){delete this;}
	virtual	long		Process()=0;
	inline	Task	*	TaskExec(Thread *ThisThread);
	long				WaitMe();

	Thread				*	volatile	__ThisThread;
	TaskQue				*	volatile	__TaskQue;

	bool					volatile	__canwait;
	Mutex								__mtxtaskwait;
	TaskWait			*	volatile	__taskwait;
	static PreAllocHeapPtr<TaskWait>	__freetaskwait;

	Task				*	volatile	__nexttask;
};

/**
 * @file ThreadPool.H
 * @class PreAllocTask 
 * @author ZhangDabo
 * @brief 内存预分配的任务类
 * @bug 
 */
class PreAllocTask:public PreAllocStru,public Task{
public:
	/**
	* @brif 析造函数
	* @param[in]  size  预分配的大小
	*/
	PreAllocTask(uLong size):PreAllocStru(size){};

	/**
	* @brif 释放资源
	*/
	virtual void Free(){PreAllocStru::Free();}
};
#endif	//USING_IOCP
#pragma pack(pop)
_DBC_END
#endif