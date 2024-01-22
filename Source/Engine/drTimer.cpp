//
#include "drTimer.h"

DR_BEGIN


//////////////
// drTimer
DR_STD_ILELEMENTATION(drTimer)

LONGLONG drTimer::__tick_freq = 0;

drTimer::drTimer()
{
    _timer_tickcount = 0;
    _timer_seq_size = TIMER_DEFAULT_SIZE;
    _timer_seq = DR_NEW(drTimerInfo[_timer_seq_size]);
    memset(_timer_seq, 0, sizeof(drTimerInfo) * _timer_seq_size);

    if(__tick_freq == 0)
    {
        LARGE_INTEGER timefreq;
        QueryPerformanceFrequency(&timefreq);
        __tick_freq = timefreq.QuadPart;
    }

}
drTimer::~drTimer()
{
    DR_DELETE_A(_timer_seq);
}

DR_RESULT drTimer::ReallocTimerSeq(DWORD size)
{
    drTimerInfo* new_seq = DR_NEW(drTimerInfo[size]);
    memcpy(new_seq, _timer_seq, sizeof(drTimerInfo) * (size > _timer_seq_size ? _timer_seq_size : size));
    DR_DELETE_A(_timer_seq);
    _timer_seq = new_seq;
    _timer_seq_size = size;

    return DR_RET_OK;
}
DR_RESULT drTimer::SetTimerInterval(DWORD id, DWORD interval)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(id >= _timer_seq_size)
        goto __ret;

    drTimerInfo* info = &_timer_seq[id];

    if(info->proc == 0)
        goto __ret;

    info->interval = interval;

    ret = DR_RET_OK;
__ret:
    return ret;

}
DR_RESULT drTimer::SetTimer(DWORD id, drTimerProc proc, DWORD interval, DWORD hit_type, DWORD hit_add_cnt)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(proc == 0 || id >= _timer_seq_size)
        goto __ret;

    drTimerInfo* info = &_timer_seq[id];

    if(info->proc)
        goto __ret;

    info->proc = proc;
    info->interval = interval;
    info->hit_type = hit_type;
    info->hit_add_cnt= hit_add_cnt;
    info->pause = 0;

    info->last_time = _QueryTick();

    ret = DR_RET_OK;
__ret:
    return ret;

}

DR_RESULT drTimer::ClearTimer(DWORD id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(id == DR_INVALID_INDEX)
    {
        memset(_timer_seq, 0, sizeof(drTimerInfo) * _timer_seq_size);
        _timer_seq_size = 0;
    }
    else
    {
        if(id >= _timer_seq_size)
            goto __ret;

        drTimerInfo* info = &_timer_seq[id];

        if(info->proc == 0)
            goto __ret;

        info->proc = 0;
        info->interval = 0;
        info->last_time = 0;
        info->pause = 0;
        info->hit_type = 0;
        info->hit_add_cnt = 0;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drTimer::ResetTimer(DWORD id)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(id == DR_INVALID_INDEX)
    {
        for(DWORD i = 0; i < _timer_seq_size; i++)
        {
            if(_timer_seq[i].proc)
            {
                _timer_seq[i].last_time = _QueryTick();
            }
        }
    }
    else
    {
        if(id >= _timer_seq_size)
            goto __ret;

        drTimerInfo* info = &_timer_seq[id];

        if(info->proc == 0)
            goto __ret;

        info->last_time = _QueryTick();
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drTimer::OnTimer()
{
    _timer_tickcount = _QueryTick();

    drTimerInfo* info;

    for(DWORD i = 0; i < _timer_seq_size; i++) 
    {
        info = &_timer_seq[i];
        
        if(info->proc == 0 || info->pause == 1)
            continue;

        DWORD t = _timer_tickcount - info->last_time;

        if(t >= info->interval) 
        {
            (*info->proc)(_timer_tickcount);

            if(info->hit_type == TIMER_HIT_FILTER)
            {
                info->last_time = _timer_tickcount;
            }
            else
            {
                info->last_time += info->interval;


                for(DWORD i = 0; (_timer_tickcount - info->last_time >= info->interval) && (i < info->hit_add_cnt); i++)
                {
                    (*info->proc)(_timer_tickcount);
                    info->last_time += info->interval;
                }
            }
        }
    }

    return DR_RET_OK;
}

DR_RESULT drTimer::Pause(DWORD id, DWORD flag)
{
    DR_RESULT ret = DR_RET_FAILED;

    if(id == DR_INVALID_INDEX)
    {
        for(DWORD i = 0; i < _timer_seq_size; i++)
        {
            if(_timer_seq[id].proc)
            {
                _timer_seq[id].pause = flag;
            }
        }
    }
    else
    {
        if(id >= _timer_seq_size)
            goto __ret;

        if(_timer_seq[id].proc == 0)
            goto __ret;

        _timer_seq[id].pause = flag;
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

DWORD drTimer::GetTickCount()
{
    return _QueryTick();
}

// drTimerThread
DWORD WINAPI drTimerThreadInfo::__thread_proc(void* param)
{
    drTimerThreadInfo* info = (drTimerThreadInfo*)param;

    while(info->thread_state == drTimerThreadInfo::STATE_RUN)
    {
        if(info->pause)
            goto __sleep_continue;

        LARGE_INTEGER t;
        QueryPerformanceCounter(&t);

        DWORD cur_t = (DWORD)(t.QuadPart * 1000 / drTimerThread::__tick_freq);

        if((cur_t - info->last_time) >= info->interval)
        {
            info->last_time = cur_t;
            (*info->proc)(cur_t);
        }

__sleep_continue:
        ::Sleep(1);
    }

    info->thread_state = drTimerThreadInfo::STATE_INVALID;

    return 0;
}

DR_RESULT drTimerThreadInfo::Init(drTimerProc p, DWORD i)
{
    DR_RESULT ret = DR_RET_FAILED;

    thread_handle = ::CreateThread(NULL, 0, __thread_proc, (void*)this, 0, &thread_id);
    if(thread_handle == 0)
        goto __ret;

    proc = p;
    interval = i;
    pause = 0;
    last_time = 0;
    thread_state = STATE_RUN;
    
    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drTimerThreadInfo::Term(DWORD delay)
{
    thread_state = STATE_EXIT;

    const DWORD __term_lmt = 10;

    DWORD term_cntt = 0;
    while(thread_state != STATE_INVALID)
    {
        ::Sleep(delay);

        if(++term_cntt == __term_lmt)
        {
            ::TerminateThread(thread_handle, 0xffffffff);
        }
    }

    thread_handle = 0;
    thread_id = 0;
    thread_state = STATE_INVALID;

    return DR_RET_OK;
}

// drTimerThread
DR_STD_ILELEMENTATION(drTimerThread)

drTimerThread::drTimerThread()
: _timer_seq(0), _timer_seq_size(0)
{}

drTimerThread::~drTimerThread()
{
    ClearTimer(DR_INVALID_INDEX, 1);
}

DR_RESULT drTimerThread::AllocateTimerSeq(DWORD size)
{
    _QueryFreq();

    drTimerThreadInfo** new_seq = DR_NEW(drTimerThreadInfo*[size]);
    memset(new_seq, 0, sizeof(drTimerThreadInfo*) * size);
    memcpy(new_seq, _timer_seq, sizeof(drTimerThreadInfo*) * (size > _timer_seq_size ? _timer_seq_size : size));
    DR_DELETE_A(_timer_seq);
    _timer_seq = new_seq;
    _timer_seq_size = size;

    return DR_RET_OK;
}

DR_RESULT drTimerThread::SetTimer(DWORD id, drTimerProc proc, DWORD interval)
{
    DR_RESULT ret = DR_RET_FAILED;

    if((id >= _timer_seq_size) || _timer_seq[id])
        goto __ret;

    drTimerThreadInfo* tti = DR_NEW(drTimerThreadInfo);

    if(DR_FAILED(tti->Init(proc, interval)))
        goto __ret;

    _timer_seq[id] = tti;

    ret = DR_RET_OK;
__ret:
    return ret;
}

DR_RESULT drTimerThread::SetTimerInterval(DWORD id, DWORD interval)
{
    DR_RESULT ret = DR_RET_FAILED;

    if((id >= _timer_seq_size) || (_timer_seq[id] == 0))
        goto __ret;

    _timer_seq[id]->interval = interval;

    ret = DR_RET_OK;
__ret:
    return ret;
}
DR_RESULT drTimerThread::Pause(DWORD id, DWORD flag)
{
    for(DWORD i = 0; i < _timer_seq_size; i++)
    {
        if(_timer_seq[i] == 0)
            continue;

        if(id == DR_INVALID_INDEX || id == i)
        {
            _timer_seq[i]->pause = flag;
        }
    }

    return DR_RET_OK;
}

DR_RESULT drTimerThread::ClearTimer(DWORD id, DWORD delay)
{
    DR_RESULT ret = DR_RET_FAILED;

    for(DWORD i = 0; i < _timer_seq_size; i++)
    {
        if(_timer_seq[i] == 0)
            continue;

        if(id == DR_INVALID_INDEX || id == i)
        {
            if(DR_FAILED(_timer_seq[i]->Term(delay)))
                goto __ret;

            DR_DELETE(_timer_seq[i]);
            _timer_seq[i] = 0;
        }
    }

    ret = DR_RET_OK;
__ret:
    return ret;
}

// drTimerPeriod
DR_STD_ILELEMENTATION(drTimerPeriod)

DR_END
