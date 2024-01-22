//
#pragma once

#include "drHeader.h"
#include "drStdInc.h"
#include "drErrorCode.h"

//////////////
//
DR_BEGIN

class drEvent
{
public:
    HANDLE _handle;
    BOOL _state;

public:
    drEvent()
        :_handle(0), _state(0)
    {}

    ~drEvent()
    {
        Destroy();
    }

    DR_RESULT Create(LPSECURITY_ATTRIBUTES attributes, BOOL manual_flag, BOOL init_state, LPCTSTR name)
    {
        _handle = ::CreateEvent(attributes, manual_flag, init_state, name);
        if(_handle == NULL)
            return DR_RET_FAILED;

        _state = init_state;
        return DR_RET_OK;
    }

    DR_RESULT Destroy()
    {
        if(_handle)
        {
            if(::CloseHandle(_handle) == 0)
                return DR_RET_FAILED;
            _handle = 0;
            _state = 0;
        }
        return DR_RET_OK;
    }

    BOOL SetEvent() { _state = TRUE; return ::SetEvent(_handle); }
    BOOL ResetEvent() { _state = FALSE; return ::ResetEvent(_handle); }
    BOOL GetState() const { return _state; }
};

class drSemaphore
{
public:
    HANDLE _handle;
    LONG _max_count;

public:
    drSemaphore()
        :_handle(0), _max_count(0)
    {}
    ~drSemaphore()
    {
        Destroy();
    }

    DR_RESULT Create(LPSECURITY_ATTRIBUTES attributes, LONG init_count, LONG max_count, LPCTSTR name)
    {
        _handle = ::CreateSemaphore(attributes, init_count, max_count, name);
        if(_handle == NULL)
            return DR_RET_FAILED;

        _max_count = max_count;
        return DR_RET_OK;
    }

    DR_RESULT Destroy()
    {
        if(_handle)
        {
            if(::CloseHandle(_handle) == 0)
                return DR_RET_FAILED;

            _handle = 0;
            _max_count = 0;
        }
        return DR_RET_OK;
    }
    BOOL ReleaseSemaphore(LONG release_count, LPLONG prev_count)
    {
        return ::ReleaseSemaphore(_handle, release_count, prev_count);
    }

    BOOL ReduceSemaphore(LONG count)
    {
        if(count > _max_count)
            return FALSE;

        while(count > 0)
        {
            ::WaitForSingleObject(_handle, 0);
            count--;
        }
        return TRUE;
    }

};

class drCriticalSection
{
public:
    CRITICAL_SECTION _handle;
    DWORD _state;

public:
    drCriticalSection()
        :_state(DR_INVALID_INDEX)
    {}
    ~drCriticalSection()
    {
        Destroy();
    }

    DR_RESULT Create()
    {
        ::InitializeCriticalSection(&_handle);
        _state = 0;
        return DR_RET_OK;
    }
    DR_RESULT Destroy()
    {
        if(_state != DR_INVALID_INDEX)
        {
            ::DeleteCriticalSection(&_handle);
            _state = DR_INVALID_INDEX;
        }
        return DR_RET_OK;
    }

    void Lock()
    {
        ::EnterCriticalSection(&_handle);
        _state = 1;
    }
    void Unlock()
    {
        ::LeaveCriticalSection(&_handle);
        _state = 0;
    }

    DWORD GetState() const { return _state; }
};


DR_END
