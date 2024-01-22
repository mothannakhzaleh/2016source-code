//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drSyncObj.h"
#include "drInterfaceExt.h"
#include <process.h>
#include <queue>
using namespace std;
//////////////
//
DR_BEGIN


enum drThreadTaskStateType
{
    THREADTASKSTATE_INVALID =   0,
    THREADTASKSTATE_WAITING =   1,
    THREADTASKSTATE_RUNNING =   2,
};

struct drThreadTaskInfo
{
    drThreadProc proc;
    void* param;
};

struct drThreadInfo
{
    uintptr_t handle;
    unsigned int id;
    DWORD state;
};

class drThreadPool : public drIThreadPool
{
    DR_STD_DECLARATION();

    typedef deque<drThreadTaskInfo> drQueueTaskInfo;
    typedef drQueueTaskInfo::iterator drQueueTaskInfo_It;

private:
    drQueueTaskInfo _queue_task;
    drThreadTaskInfo* _task_seq;
    drThreadInfo* _thread_seq;
    DWORD _thread_seq_size;
    DWORD _thread_num;
    int _priority;
    
    DWORD _task_seq_size;
    DWORD _exit_flag;
    HANDLE _event_signal;
    CRITICAL_SECTION _cs_lock;
    drEvent _event_pool;

static unsigned int __stdcall __thread_proc(void* param);

private:
    unsigned int _ThreadProc();
    inline void _Lock() { ::EnterCriticalSection(&_cs_lock); }
    inline void _Unlock() { ::LeaveCriticalSection(&_cs_lock); }
    inline BOOL _SetEvent() { return ::SetEvent(_event_signal); }
    inline BOOL _ResetEvent() { return ::ResetEvent(_event_signal); }
    DR_RESULT _FindTask(drQueueTaskInfo_It* it, drThreadProc proc, void* param);
public:
    drThreadPool();
    ~drThreadPool();
 
    DR_RESULT Create(DWORD thread_seq_size, DWORD task_seq_size, DWORD suspend_flag);
    DR_RESULT Destroy();
    DR_RESULT RegisterTask(drThreadProc proc, void* param);
    DR_RESULT RemoveTask(drThreadProc proc, void* param);
    DR_RESULT FindTask(drThreadProc proc, void* param);
    DR_RESULT SuspendThread();
    DR_RESULT ResumeThread();
    DR_RESULT SetPriority(int priority);
    DR_RESULT SetPoolEvent(BOOL lock_flag);
    int GetPriority() const { return _priority; }
    DWORD GetCurrentWaitingTaskNum() const { return (DWORD)_queue_task.size(); }
    DWORD GetCurrentRunningTaskNum() const;
    DWORD GetCurrentIdleThreadNum() const;
    DWORD GetThreadId(DWORD id) { return _thread_seq[id].id; }

};

DR_END
