


#include "thread.h"
#include "log.h"
#include <process.h>
//#include "infotype.h"


extern void InitCom();
extern void UninitCom();

uint __stdcall ThreadFunc(void* param)
{
__BEGIN_TRY
    InitCom();
    Thread* __thread = (Thread*)param;
    uint __ret = __thread->Run();
    UninitCom();
    _endthreadex(__ret);
    return __ret;
__END_TRY
    return -1;
}


Thread::Thread()
{
}


Thread::~Thread()
{
}


bool Thread::Begin(int flag)
{
    m_thread = (HANDLE)_beginthreadex(NULL, 0, ThreadFunc, this, flag, &m_threadid);
    return NULL != m_thread;
}


bool Thread::Resume()
{
    return -1 != ResumeThread((HANDLE)m_thread);
}


bool Thread::Suspend()
{
    return -1 != SuspendThread((HANDLE)m_thread);
}


bool Thread::Terminate()
{
    return TRUE == TerminateThread((HANDLE)m_thread, 0);
}


int Thread::Wait(int time)
{
    return (int)WaitForSingleObject((HANDLE)m_thread, time);
}


bool Thread::SetPriority(int priority)
{
    return TRUE == SetThreadPriority((HANDLE)m_thread, priority);
}


int Thread::GetPriority()
{
    return GetThreadPriority((HANDLE)m_thread);
}


