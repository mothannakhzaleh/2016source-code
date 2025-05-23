

#include <winsock2.h>
#include "InfoNet.h"
#include "thread.h"
#include "lock.h"
#include "log.h"
#include <memory.h>
#include <sys/timeb.h>
#include <deque>

using std::deque;

#define INFO_INIT           0
#define INFO_RESTING        1
#define INFO_WORKING        2
#define INFO_STOPPED        3


#define MAX_NET_SIZE        1048576     //  封包大于这个数则无效


template <class T>
class _AnyQueue
{
public:
    _AnyQueue()
    {
    }
    virtual ~_AnyQueue()
    {
    }
    virtual T Pop()
    {
        m_lock.lock();
        T ty = (T)m_queue.front();
        m_queue.pop_front();
        m_lock.unlock();
        return ty;
    }
    virtual T Top()
    {
        m_lock.lock();
        T ty = (T)m_queue.front();
        m_lock.unlock();
        return ty;
    }
    virtual void Push(T val)
    {
        m_lock.lock();
        m_queue.push_back(val);
        m_lock.unlock();
    }
    virtual int Size()
    {
        return (int)m_queue.size();
    }
    virtual void Clear()
    {
        deque<T>::iterator it;

        m_lock.lock();
        for(it = m_queue.begin(); it != m_queue.end(); it++)
        {
            SAFE_DELETE(*it);
        }
        m_queue.clear();
        m_lock.unlock();
    }

protected:
    deque<T>    m_queue;
    Lock        m_lock;
};


class InfoThread : public Thread
{
public:
    InfoThread();
    virtual ~InfoThread();
    virtual unsigned Run();
public:
    void*     m_param;
};


//  客户端信息
typedef struct _InfoClient_
{
    SOCKET              sock;
    InfoThread          thread;
    char                buff[8192];
    void*               tmpbuf;
    long                tmpsize;
}InfoClient, *pInfoClient;


typedef _AnyQueue<pNetMessage>  NetSndList;


//  获取消息头
int GetMessageHead(pNetMessageHead mh, unsigned char* msg, int size)
{
__BEGIN_TRY
    if(size < sizeof(NetMessageHead))
    {
        return PNM_FAILED;
    }

    //  读取消息头
    memcpy(mh, msg, sizeof(NetMessageHead));

    //  验证协议报头
    if((0x4A != mh->msgChk[0]) || (0x4D != mh->msgChk[1]) || (0x50 != mh->msgChk[2]) || (0x53 != mh->msgChk[3]))
    {
        return PNM_UNKNOWN;
    }
    return PNM_SUCCESS;
__END_TRY
    return PNM_EXCEPTION;
}


int PeekNetMessage(pNetMessage* nm, unsigned char** buf, long& bufsize, void** tmpbuf, long& tmpsize)
{
__BEGIN_TRY
    if((0 == buf) || (0 == (*buf)) || (0 == tmpbuf))
    {
        return PNM_EXCEPTION;
    }

    int     bdSize;

    if(tmpsize)  //  拆包处理
    {
        (*nm) = ((pNetMessage)(*tmpbuf));
        if(tmpsize < (int)sizeof(NetMessageHead))        //  消息头被截断
        {
            memcpy((((unsigned char*)(*tmpbuf)) + tmpsize), (*buf), ((int)sizeof(NetMessageHead) - tmpsize));   //  读取未读取的消息头
            (*buf) += (sizeof(NetMessageHead) - tmpsize);     //  指针后移
            bufsize -= (sizeof(NetMessageHead) - tmpsize);    //  长度减去移动长度
            bdSize = ((*nm)->msgHead.msgSize > (*nm)->msgHead.msgEncSize) ? ((*nm)->msgHead.msgSize) : ((*nm)->msgHead.msgEncSize);   //  计算缓存长度
            if(bdSize)
            {
                if(bdSize > MAX_NET_SIZE)    //  大于1m则认为是错误的封包
                {
                    return PNM_EXCEPTION;
                }
                (*nm)->msgBody = new unsigned char[bdSize];    //  分配空间
                memset((*nm)->msgBody, 0, bdSize);
                memcpy((*nm)->msgBody, (*buf), (*nm)->msgHead.msgEncSize);    //  读取消息体
                (*buf) += (*nm)->msgHead.msgEncSize;   //  指针后移
                bufsize -= (*nm)->msgHead.msgEncSize;  //  长度减去移动长度
            }
        }
        else        //  消息体被截断
        {
            unsigned char* tmpPtr = (unsigned char*)(*nm)->msgBody;
            int bodySize = tmpsize - sizeof(NetMessageHead);
            tmpPtr += bodySize;   //  指针跳过已读取部分
            if(((*nm)->msgHead.msgEncSize - bodySize) > bufsize)    //  消息体如果又被截断
            {
                memcpy(tmpPtr, (*buf), bufsize);
                tmpsize += bufsize;
                return PNM_FAILED;
            }
            memcpy(tmpPtr, (*buf), ((*nm)->msgHead.msgEncSize - bodySize));
            //
            //  这里编写解密代码
            //
            (*buf) += (*nm)->msgHead.msgEncSize - bodySize;
            bufsize -= (*nm)->msgHead.msgEncSize - bodySize;
        }
        (*tmpbuf) = 0;
        tmpsize = 0;
        return PNM_SUCCESS;
    }

    int ret;

    for(;;) //  数据包解析
    {
        if(bufsize <= 0)
        {
            return PNM_FAILED;
        }

        (*nm) = new NetMessage;
        (*nm)->msgBody = 0;
        ret = GetMessageHead(&(*nm)->msgHead, (*buf), bufsize);

        if(PNM_UNKNOWN == ret)
        {
            FreeNetMessage((*nm));
            return PNM_UNKNOWN;
        }

        if(PNM_FAILED == ret)   //  消息头被截断
        {
            (*tmpbuf) = (*nm);
            tmpsize = bufsize;
            memcpy((*tmpbuf), (*buf), bufsize);
            return PNM_FAILED;
        }

        (*buf) += sizeof(NetMessageHead);
        bufsize -= sizeof(NetMessageHead);

        bdSize = ((*nm)->msgHead.msgSize > (*nm)->msgHead.msgEncSize) ? ((*nm)->msgHead.msgSize) : ((*nm)->msgHead.msgEncSize);   //  计算缓存长度

        if(bdSize)
        {
            if(bdSize > MAX_NET_SIZE)    //  大于1m则认为是错误的封包
            {
                return PNM_EXCEPTION;
            }
            (*nm)->msgBody = new unsigned char[bdSize];
            memset((*nm)->msgBody, 0, bdSize);
            if(bdSize > bufsize)    //  粘包处理
            {
                memcpy((*nm)->msgBody, (*buf), bufsize);
                (*tmpbuf) = (*nm);
                tmpsize = bufsize + sizeof(NetMessageHead);
                return PNM_FAILED;
            }
            memcpy((*nm)->msgBody, (*buf), (*nm)->msgHead.msgEncSize);
            //
            //  这里编写解密代码
            //
            (*buf) += (*nm)->msgHead.msgEncSize;   //  指针后移
            bufsize -= (*nm)->msgHead.msgEncSize;  //  长度减去移动长度
        }
        else
        {
            (*nm)->msgBody = 0;    //  消息置空
        }
        return PNM_SUCCESS;
    }
    return PNM_EXCEPTION;
__END_TRY
    return PNM_EXCEPTION;
}


//  释放消息
void FreeNetMessage(pNetMessage msg)
{
__BEGIN_TRY
    if(msg)
    {
        if(msg->msgBody)
        {
            SAFE_DELETE_ARRAY(msg->msgBody);
        }
        SAFE_DELETE(msg);
    }
__END_TRY
}


int g_count = 0;
//  生成消息
bool BuildNetMessage(pNetMessage nm, long msgID, long subID, long extend, long section, unsigned char* body, long size)
{
__BEGIN_TRY
    if(!nm)
    {
        return false;
    }

    //  消息标识码
    nm->msgHead.msgChk[0] = 0x4A;
    nm->msgHead.msgChk[1] = 0x4D;
    nm->msgHead.msgChk[2] = 0x50;
    nm->msgHead.msgChk[3] = 0x53;

    nm->msgHead.msgID = msgID;
    nm->msgHead.subID = subID;
    nm->msgHead.msgExtend = extend;
    nm->msgHead.msgSection = section;
    nm->msgHead.msgSize = size;
    nm->msgHead.msgEncSize = nm->msgHead.msgSize;

    if(size)
    {
        //
        //  这里编写加密代码
        //
        nm->msgBody = new unsigned char[size];
        memset(nm->msgBody, 0, size);
        memcpy(nm->msgBody, body, size);
    }
    else
    {
        nm->msgBody = 0;
    }

    ++g_count;
    g_count %= 1000;
    _timeb tb;
    //_ftime(&tb);
    _ftime_s(&tb);

    nm->msgHead.msgOrder = tb.time;
    nm->msgHead.msgOrder *= 1000;
    nm->msgHead.msgOrder += tb.millitm;
    nm->msgHead.msgOrder *= 1000;
    nm->msgHead.msgOrder += g_count;

    return true;
__END_TRY
    return false;
}


_byte* GetInfoKey()
{
    return (_byte*)"s#8Jx@D";
}


_byte* GetPassword()
{
    return (_byte*)"moliyo#TradeServer@bird&man";
}


InfoThread::InfoThread()
{
}


InfoThread::~InfoThread()
{
}


unsigned InfoThread::Run()
{
    InfoNetBase* inb = (InfoNetBase*)m_param;
    pInfoClient cli = (pInfoClient)inb->m_client;
    NetSndList* sndLst = (NetSndList*)inb->m_list;
    pNetMessage pNM = 0;
    int ret = 0;
    fd_set fdread;
    timeval tv = {0, 0};        //  立即返回(不阻塞select)，用闲置系统资源进行发送队列重发
    clock_t sndTime = 0;
    clock_t chkTime = clock();

    for(;;)
    {
__BEGIN_TRY
        inb->m_state = INFO_RESTING;
        if(!inb->IsConnect())
        {
            inb->Connect();
            Sleep(10000);   //  避免重连占用太多cpu资源。10秒重连一次
            continue;
        }

        //  Select轮询开始
        FD_ZERO(&fdread);
        FD_SET(cli->sock, &fdread);

        ret = select(0, &fdread, 0, 0, &tv);
        //ret = select(0, &fdread, 0, 0, 0);    //  阻塞select

        if(SOCKET_ERROR == ret)
        {
            LG("InfoNet", "select model error..." __LN);
            Sleep(1);
            continue;
        }

        inb->m_state = INFO_WORKING;

        if(ret > 0)
        {
            if(FD_ISSET(cli->sock, &fdread))
            {
                if(!inb->PostInfoRecv())
                {
                    LG("InfoNet", "Recv Failt..." __LN);
                    inb->Disconnect();
                    Sleep(1);
                    continue;
                }
            }
        }
        //  Select轮询结束

        //  检测服务器是否存活(是否异常断线检测)
        if((clock() - chkTime) > 300000)    //  5分钟检测一次
        {
            chkTime = clock();
            LG("InfoNet", "Ping: Timestamp: %li..." __LN, time(0));
            if(!inb->PostInfoSend(INFO_CHECK_LIVE, 0, 0, 0, 0, 0))
            {
                LG("InfoNet", "Ping: Lost Connection..." __LN);
                inb->Disconnect();
                Sleep(1);
                continue;
            }
        }

        //  开始重发
        sndTime = clock();
        for(;;)
        {
            if(!sndLst->Size())
            {
                Sleep(1);
                break;
            }
            pNM = sndLst->Top();
            if(!inb->PostInfoSend(pNM, false))
            {
                LG("InfoNet", "Resend Failt..." __LN);
                inb->Disconnect();
                Sleep(1);
                break;
            }
            else
            {
                sndLst->Pop();
                inb->OnResend(pNM);
                FreeNetMessage(pNM);
            }
            if((clock() - sndTime) > 50)    //  重发占用50毫秒以上时，释放资源
            {
                Sleep(1);
                break;
            }
        }
__END_TRY
    }

    return 0;
}



//  客户端接口
InfoNetBase::InfoNetBase()
:   m_state(INFO_INIT), m_client(0), m_list(0)
{
}


InfoNetBase::~InfoNetBase()
{
}


bool InfoNetBase::RunInfoService(const char* ip, short port)
{
    LG("InfoNet", "Begin Run Info Service..." __LN);
    if((INFO_RESTING == m_state) || (INFO_WORKING == m_state))
    {
        LG("InfoNet", "Already Has Ran Info Service..." __LN);
        return true;
    }
    if(!m_list)
    {
        LG("InfoNet", "Create Send Queue..." __LN);
        m_list = new NetSndList;
    }
    if(!m_client)
    {
        LG("InfoNet", "Create Connect Object..." __LN);
        m_client = new InfoClient;
        pInfoClient __cli = (pInfoClient)m_client;
        memset(__cli->buff, 0, 8192);
        __cli->tmpbuf = 0;
        __cli->tmpsize = 0;
        __cli->sock = INVALID_SOCKET;
    }
    //strncpy(m_ip, ip, 260);
	::strncpy_s(m_ip, sizeof(m_ip), ip, _TRUNCATE);
    m_port = port;
    ((pInfoClient)m_client)->thread.m_param = this;
    ((pInfoClient)m_client)->thread.Begin();
    LG("InfoNet", "End Run Info Service..." __LN);
    return true;
}


bool InfoNetBase::StopInfoService()
{
    LG("InfoNet", "Begin Stop Info Service..." __LN);
    if((INFO_INIT == m_state) || (INFO_STOPPED == m_state))
    {
        LG("InfoNet", "Already Stopped Info Service..." __LN);
        return true;
    }
    m_state = INFO_STOPPED;
    if(!m_client)
    {
        LG("InfoNet", "Missing Connect Object..." __LN);
        return false;
    }
    pInfoClient __cli = (pInfoClient)m_client;
    //for(;;)
    //{
    //    if(INFO_WORKING == m_state)
    //    {
    //        Sleep(1);
    //        continue;
    //    }
        __cli->thread.Terminate();
        ((NetSndList*)m_list)->Clear();
        SAFE_DELETE(m_client);
        SAFE_DELETE(m_list);
    //    break;
    //}
    LG("InfoNet", "End Stopped Info Service..." __LN);
    return true;

}


bool InfoNetBase::PostInfoSend(long msgID, long subID, long extend, long section, unsigned char* body, long size, bool resnd /* = false */)
{
__BEGIN_TRY
    pNetMessage pNM = new NetMessage;   //  新消息
    BuildNetMessage(pNM, msgID, subID, extend, section, body, size);
    bool ret = PostInfoSend(pNM, resnd);
    FreeNetMessage(pNM);
    return ret;
__END_TRY
    return false;
}


bool InfoNetBase::PostInfoSend(pNetMessage msg, bool resnd/* = true*/)
{
    LG("InfoNet", "Begin Send..." __LN);
    pInfoClient __cli = (pInfoClient)m_client;
__BEGIN_TRY
    if(!msg)
    {
        return false;
    }
    int size = sizeof(NetMessageHead) + msg->msgHead.msgEncSize;
    char* buf = new char[size];
    char* tmp = buf;

    memset(buf, 0, size);
    memcpy(buf, &msg->msgHead, sizeof(NetMessageHead));
    if(msg->msgHead.msgEncSize)
    {
        tmp += sizeof(NetMessageHead);
        memcpy(tmp, msg->msgBody, msg->msgHead.msgEncSize);
    }

    bool ret = true;

    if(SOCKET_ERROR == send(__cli->sock, buf, size, 0))
    {
        LG("InfoNet", "Send Failed, Socket: %li, ErrorID: %li" __LN, __cli->sock, WSAGetLastError());
        Disconnect();
        if(resnd)
        {
            LG("InfoNet", "Ready For Resend..." __LN);
            pNetMessage newNM = new NetMessage;     //  新建一份copy放入发送队列，等待重发
            memcpy(&newNM->msgHead, &msg->msgHead, sizeof(NetMessageHead));
            if(msg->msgHead.msgEncSize)
            {
                newNM->msgBody = new unsigned char[msg->msgHead.msgEncSize];
                memcpy(newNM->msgBody, msg->msgBody, msg->msgHead.msgEncSize);
            }
            else
            {
                msg->msgBody = 0;
            }
            ((NetSndList*)m_list)->Push(newNM);
        }
        ret = false;
    }
    SAFE_DELETE_ARRAY(buf);
    LG("InfoNet", "End Send..." __LN);
    return ret;
__END_TRY
    return false;
}


bool InfoNetBase::IsConnect()
{
    if(!m_client)
    {
        return false;
    }
    return INVALID_SOCKET != ((pInfoClient)m_client)->sock;
}


bool InfoNetBase::Connect()
{
    LG("InfoNet", "Begin Connect Trade Server, IP: %s, Port: %i..." __LN, m_ip, m_port);
__BEGIN_TRY
    pInfoClient __cli = (pInfoClient)m_client;

    __cli->tmpbuf = 0;
    __cli->tmpsize = 0;

    __cli->sock = socket(AF_INET, SOCK_STREAM, 0);

    SOCKADDR_IN addr;
    addr.sin_family         = AF_INET;
    addr.sin_addr.s_addr    = inet_addr(m_ip);
    addr.sin_port           = htons(m_port);

    if (INADDR_NONE == addr.sin_addr.s_addr)
    {
        LPHOSTENT lphost;
        lphost = gethostbyname(m_ip);

        if (lphost != NULL)
        {
            addr.sin_addr.s_addr = ((LPIN_ADDR)lphost->h_addr)->s_addr;
        }
    }

    bool ret = (0 == connect(__cli->sock, (struct sockaddr *)&addr, sizeof(addr)));

    LG("InfoNet", "Call Back 'OnConnect' With '%s'..." __LN, (true == ret) ? "True" : "False");
    OnConnect(ret);
    if(!ret)
    {
        LG("InfoNet", "Connect Trade Server Failt..." __LN);
        Disconnect();
    }
    //else
    //{
    //    u_long __noblock = 1;
    //    ioctlsocket(__cli->sock, FIONBIO, &__noblock);
    //}
    LG("InfoNet", "End Connect Trade Server..." __LN);
    return ret;
__END_TRY
    return false;
}


bool InfoNetBase::Disconnect()
{
    LG("InfoNet", "Begin Disconnect Trade Server..." __LN);
__BEGIN_TRY
    if(!IsConnect())
    {
        return true;
    }
    pInfoClient __cli = (pInfoClient)m_client;
    bool ret = (0 == closesocket(__cli->sock));
    __cli->sock = INVALID_SOCKET;
    LG("InfoNet", "Call Back 'OnDisconnect'..." __LN);
    OnDisconnect();
    LG("InfoNet", "End Disconnect Trade Server..." __LN);
    return ret;
__END_TRY
    return false;
}


bool InfoNetBase::PostInfoRecv()
{
    LG("InfoNet", "Begin Receive..." __LN);
    pInfoClient __cli = (pInfoClient)m_client;
__BEGIN_TRY
    memset(__cli->buff, 0, 8192);
    int rsbytes = recv(__cli->sock, __cli->buff, 8192, 0);

    if(rsbytes <= 0)
    {
        if(WSAEWOULDBLOCK == WSAGetLastError())
        {
            Sleep(1);
            return true;
        }
        LG("InfoNet", "Recv Failed, Socket: %li, ErrorID: %li" __LN, __cli->sock, WSAGetLastError());
        Disconnect();
        return false;
    }

    unsigned char* bufPtr = (unsigned char*)__cli->buff;
    long bufSize = rsbytes;
    pNetMessage nm = 0;
    int ret = 0;

    for(;;)
    {
        ret = PeekNetMessage(&nm, &bufPtr, bufSize, &__cli->tmpbuf, __cli->tmpsize);

        if(PNM_SUCCESS == ret)             //  成功
        {
            OnNetMessage(nm);
        }
        else if(PNM_FAILED == ret)         //  被拆包
        {
            break;
        }
        else if(PNM_UNKNOWN == ret)        //  解析消息头失败
        {
            LG("InfoNet", "Bad Packet Head..." __LN);
            if(__cli->tmpbuf)
            {
                SAFE_DELETE(__cli->tmpbuf);
                __cli->tmpsize = 0;
            }
            break;
        }
        else if(PNM_EXCEPTION ==ret)      //  异常（多数情况是因空指针引起）
        {
            LG("InfoNet", "Bad Packet..." __LN);
            if(__cli->tmpbuf)
            {
                SAFE_DELETE(__cli->tmpbuf);
                __cli->tmpsize = 0;
            }
            break;
        }
        else    //  未知情况
        {
            LG("InfoNet", "Unknown Packet..." __LN);
            if(__cli->tmpbuf)
            {
                SAFE_DELETE(__cli->tmpbuf);
                __cli->tmpsize = 0;
            }
            break;
        }
    }
    LG("InfoNet", "End Receive..." __LN);
    return true;
__END_TRY
    return false;
}


