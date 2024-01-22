//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"
#include "drInterfaceExt.h"

//////////////
//
DR_BEGIN


struct drTimerInfo 
{
    drTimerProc proc;
    DWORD interval;
    DWORD last_time;
    DWORD pause;
    DWORD hit_type;
    DWORD hit_add_cnt;
};

class drTimer : public drITimer
{
    DR_STD_DECLARATION()

    enum { TIMER_DEFAULT_SIZE = 4 };

    static LONGLONG __tick_freq;

private:
    drTimerInfo* _timer_seq;
    DWORD _timer_seq_size;
    DWORD _timer_tickcount;

private:
    inline LONGLONG _QueryCounter()
    {
        LARGE_INTEGER t;
        QueryPerformanceCounter(&t);
        return t.QuadPart;
    }
    inline DWORD _QueryTick()
    {
        return (DWORD)(_QueryCounter() * 1000 / __tick_freq);
    }

public:
    drTimer();
    ~drTimer();
    DR_RESULT OnTimer();
    DR_RESULT SetTimer(DWORD id, drTimerProc proc, DWORD interval, DWORD hit_type, DWORD hit_add_cnt);
    DR_RESULT SetTimerInterval(DWORD id, DWORD interval);
    DWORD GetLastInvokeTime(DWORD id) { return _timer_seq[id].last_time; }
    DR_RESULT Pause(DWORD id, DWORD flag); // id == DR_INVALID_INDEX : all
    DR_RESULT ResetTimer(DWORD id); // id == DR_INVALID_INDEX : all
    DR_RESULT ClearTimer(DWORD id); // id == DR_INVALID_INDEX : all
    DR_RESULT ReallocTimerSeq(DWORD size);
    DWORD GetTimerTickCount() { return _timer_tickcount; }
    DWORD GetTickCount();

    
};

struct drTimerThreadInfo
{
    enum
    {
        STATE_INVALID = 0,
        STATE_RUN = 1,
        STATE_EXIT = 2,
    };

    DWORD last_time;
    DWORD interval; // milliseconds
    drTimerProc proc;
    DWORD pause;
    HANDLE thread_handle;
    DWORD thread_id;
    DWORD thread_state;

    static DWORD WINAPI __thread_proc(void* param);
    DR_RESULT Init(drTimerProc p, DWORD i);
    DR_RESULT Term(DWORD delay);
};

class drTimerThread : public drITimerThread
{
    DR_STD_DECLARATION();

public:
    static LONGLONG  __tick_freq;
    static inline void _QueryFreq()
    {
        if(__tick_freq == 0)
        {
            LARGE_INTEGER freq;
            QueryPerformanceFrequency(&freq);
            __tick_freq = freq.QuadPart;
        }
    }
    
private:
    drTimerThreadInfo** _timer_seq;
    DWORD _timer_seq_size;

private:

public:
    drTimerThread();
    ~drTimerThread();

    DR_RESULT AllocateTimerSeq(DWORD size);
    DR_RESULT SetTimer(DWORD id, drTimerProc proc, DWORD interval);
    DR_RESULT SetTimerInterval(DWORD id, DWORD interval);
    DR_RESULT Pause(DWORD id, DWORD flag); // id == DR_INVALID_INDEX : all
    DR_RESULT ClearTimer(DWORD id, DWORD delay); // id == DR_INVALID_INDEX : all
};

__declspec(selectany) LONGLONG drTimerThread::__tick_freq = 0;

class drTimerPeriod : public drITimerPeriod
{
    DR_STD_DECLARATION();

private:
	static int _period_ref;
	static TIMECAPS _time_caps;

public:
    static void	BeginPeriod()
    {
		if(_period_ref == 0)
        {
			timeGetDevCaps(&_time_caps, sizeof(_time_caps));
            timeBeginPeriod(_time_caps.wPeriodMax);
		}
        _period_ref++;
    }
	static void EndPeriod()
	{
		if(_period_ref > 0)
        {
			if(--_period_ref == 0)
            {
				timeEndPeriod(_time_caps.wPeriodMax);
			}
		}
	}
    static int GetPeriodRef() { return _period_ref; }

private:
    UINT _timer_id;

public:
    drTimerPeriod()
        :_timer_id(0)
    {
        BeginPeriod();
    }
    ~drTimerPeriod()
    {
        KillEvent();
        EndPeriod();
    }

    DR_RESULT SetEvent(UINT delay, UINT resolution, LPTIMECALLBACK proc, DWORD_PTR param, UINT event)
    {
        _timer_id = ::timeSetEvent(delay, resolution, proc, param, event);
        return (_timer_id != NULL) ? DR_RET_OK : DR_RET_FAILED;
    }
    DR_RESULT KillEvent()
    {
        ::timeKillEvent(_timer_id);
        _timer_id = 0;
        return DR_RET_OK;
    }
    UINT GetTimerID() { return _timer_id; }
};

__declspec(selectany) int drTimerPeriod::_period_ref = 0;
__declspec(selectany) TIMECAPS drTimerPeriod::_time_caps;

DR_END
