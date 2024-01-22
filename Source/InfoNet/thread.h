
/* * * * * * * * * * * * * * * * * * * *

    线程封装
    Jampe
    2006/3/27

 * * * * * * * * * * * * * * * * * * * */


#if !defined __THREAD_H__
#define __THREAD_H__

#include "datatype.h"



#define THREAD_INIT        0
#define THREAD_RESTING     1
#define THREAD_WORKING     2
#define THREAD_STOPPED     3


class Thread
{
public:
    Thread();
    virtual ~Thread();

    virtual bool Begin(int flag = 0);  //  开始线程
    virtual bool Resume();  //  恢复线程
    virtual bool Suspend(); //  挂起线程
    virtual bool Terminate();   //  强制终止线程
    virtual bool SetPriority(int priority);     //  设置优先级
    virtual int GetPriority();  //  获取优先级
    virtual int Wait(int time = INFINITE);  //  等待时间
    virtual uint Run() = 0;

public:
    HANDLE          m_thread;
    uint            m_threadid;
    void*           m_param;
    int             m_ui_idx;

};


#endif
