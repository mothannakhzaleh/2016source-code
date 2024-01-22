#include "GameServerApp.h"
#include <iostream>
#include <time.h>
#include "GameCommon.h"
#include "SubMap.h"
#include "GameApp.h"
#include "TryUtil.h"
#include "GameDB.h"
#include "SystemDialog.h"

_DBC_USING
//不要修改下面的行,谢谢合作!
uLong NetBuffer[] =
	{400, 300, 200, 100, 50, 40, 30, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
	 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
	 1, 1, 1, 1, 1, 1, 1, 1, 30, 0};
bool	g_logautobak	=true;
//End

extern BOOL	g_bGameEnd; // GameServer 退出全局标志


// 连接 GateServer 任务类
long ConnectGateServer::Process()
{T_B
    DWORD	dwTick, dwCurTick;
    DWORD	dwInterval = 5000;
    DWORD	dwConnectTick = 0;

    dwTick = dwCurTick = GetTickCount();
    dwTick -= dwConnectTick; // 保证线程运行后立即执行连接GateServer的操作

    while (!GetExitFlag())
	{
        dwCurTick = GetTickCount();

        static DWORD dwLastRunTick = 0;
        if(dwCurTick - dwLastRunTick < dwInterval) 
		{
            Sleep(10);
            continue;
		}

        dwLastRunTick = dwCurTick;

        // 对未连接的 GateServer 进行连接
        if (dwCurTick - dwTick >= dwConnectTick)
		{
            dwTick = dwCurTick;
            
			for (int i = 0; i < m_gmsvr->m_gtnum; i++)
			{
				if (!m_gmsvr->m_gtarray[i].IsValid())
				{
                    m_gmsvr->ConnectGate(&m_gmsvr->m_gtarray[i]);
				}
			}
		}
	}

    return 0;
T_E}

//监听TradeServer线程
long ToTradeServer::Process()
{T_B
	if(m_gmsvr->m_IfServer.GetPort() == 0)
	{
		//LG("Store_data", "没有配置TradeServer!\n");
		LG("Store_data", "not configure TradeServer!\n");
		return 0;
	}

	m_gmsvr->m_IfServer.InValid();
	LG("Store_data", "Connect TradeServer(%s, %d)...\n", m_gmsvr->m_IfServer.GetIP().c_str(), m_gmsvr->m_IfServer.GetPort());
	g_gmsvr->ConnectInfo(&m_gmsvr->m_IfServer);

	DWORD	dwCurTick;
	DWORD	dwInterval = m_dwTimeOut;

	dwCurTick = GetTickCount();

	//登录TradeServer
	while(!GetExitFlag())
	{
		dwCurTick = GetTickCount();

		static DWORD dwLastRunTick = 0;
		if(dwCurTick - dwLastRunTick < dwInterval) 
		{
			Sleep(10);
			continue;
		}

		try
		{
			if(!m_gmsvr->m_IfServer.IsValid() && m_gmsvr->m_IfServer.IsConnect())
			{
				LG("Store_data", "Login TradeServer...\n");
				m_gmsvr->m_IfServer.Login();
			}
		}
		catch(...)
		{
			LG("Store_data", "Process Error!\n");
		}

		dwLastRunTick = dwCurTick;
	}

	LG("Store_data", "ToTradeServer Process Out!\n");

	return 0;
T_E}

void TradeServer::Login()
{T_B
	pNetMessage pNm = new NetMessage();
	char szPwd[33];
	cChar *szPassword = (cChar *)GetPassword();

	// Add by lark.li 20090311 begin
	if(!szPassword)
		return;
	// End

	if(strlen(szPassword) > 32)
	{
		LG("Store_data", "Login password too long!\n");
		return;
	}
	//strcpy(szPwd, szPassword);
	strncpy_s( szPwd, sizeof(szPwd), szPassword, _TRUNCATE );
	BuildNetMessage(pNm, INFO_LOGIN, 0, 0, 0, (unsigned char*)szPwd, long(strlen(szPwd) + 1));
	g_gmsvr->GetTradeServer()->SendData(pNm);
	FreeNetMessage(pNm);
T_E}

long TradeServer::PeekMsg(unsigned long ms)
{T_B
    //至少处理10条消息
    if(ms < 10)
        ms = 10;

    while(ms-- > 0)
    {
        if(!m_MsgQueue.IsEmpty())
        {
            pNetMessage msg = m_MsgQueue.Pop();
            g_gmsvr->ProcessData(msg, CMD_FM_MSG);
        }
        else
            break;
    }
	return 0;
T_E}

void TradeServer::OnConnect(bool result)
{
	if(result)
	{
		LG("Store_data", "TradeServer Connected!\n");
		g_gmsvr->ProcessData(NULL, CMD_FM_CONNECTED);
	}
	else
	{
		LG("Store_data", "TradeServer Connect Failed!\n");

		try
		{
			//g_gmsvr->DisconnectInfo(this);
		}
		catch(...)
		{
			LG("Store_data", "OnConnect Error!\n");
		}
		
	}
}

void TradeServer::OnDisconnect()
{
    InValid();
	LG("Store_data", "TradeServer Disconnected!\n");

	try
	{
		//g_gmsvr->DisconnectInfo(this);
	}
	catch(...)
	{
		LG("Store_data", "OnDisconnect Error!\n");
	}
	
    g_gmsvr->ProcessData(NULL, CMD_FM_DISCONNECTED);
}

// Add by lark.li 20090112 begin
#include <LogStream.h>
#include <inifile.h>

long UpdateDBCall::Process()
{
	if(!m_pCPlayer)
	{
		LG("UpdateDBCall", "%d,error (player == null)\n", ::GetCurrentThreadId());
		return 0;
	}

	if(!m_pCPlayer->IsValid())
	{
		LG("UpdateDBCall", "%d,error (player is invalid)\n", ::GetCurrentThreadId());
		return 0;
	}

	MONITOR_VALUE(::GetCurrentThreadId())

	//game_db.SavePlayerEx(m_pCPlayer, enumSAVE_TYPE_TIMER);
	CGameDB* pDB = CGameDBPool::Instance()->GetGameDB();
	if(pDB)
	{
		pDB->SavePlayerEx(m_pCPlayer, enumSAVE_TYPE_TIMER);
	}
	else
		LG("UpdateDBCall", "%d,error\n", ::GetCurrentThreadId());

	return 0;
}

long GoOutServerCall::Process()
{
	g_pGameApp->GoOutGame(m_pCPlayer, m_bOffLine);
	return 0;
}

long EnterServerCall::Process()
{
	CPlayer *l_player = 0;
	l_player = g_pGameApp->CreateGamePlayer(pszPassword, l_dbid, l_worldid, l_map, chLogin == 0 ? 0 : 1);			
	if (!l_player)
	{
		WPACKET pkret = GETWPACKET();
		WRITE_CMD(pkret, CMD_MC_ENTERMAP);
		WRITE_SHORT(pkret, ERR_MC_ENTER_ERROR);
		WRITE_LONG(pkret, l_dbid);
		WRITE_LONGLONG(pkret, l_gtaddr);
		WRITE_SHORT(pkret, 1);
		pGate->SendData(pkret);
		//LG("enter_map", "建立新玩家（ID = %u）时，分配内存失败 \n", l_dbid);
		LG("error", "when create new palyer(ID = %u),assign memory failed \n", l_dbid);
		return 0;
	}

	l_player->SetActLoginID(l_actid);
	l_player->SetGarnerWiner(swiner);
	l_player->GetLifeSkillinfo() = "";
	l_player->SetInLifeSkill(false);

	if (!chLogin) // 上线（而不是切换地图）
		l_player->MisLogin();			

	//////////////////////////////////////////////////////////////////////////
	// 添加gate server对应的维护信息
	ADDPLAYER(l_player, pGate, l_gtaddr);
	l_player->OnLogin();
	//////////////////////////////////////////////////////////////////////////

	CCharacter *pCCha = l_player->GetMainCha();
	if (pCCha->Cmd_EnterMap(l_map, lMapCpyNO, l_x, l_y, chLogin))
	{
		l_player->MisEnterMap();

		if (chLogin == 0) // 角色上线
		{
			g_pGameApp->NoticePlayerLogin(l_player);
		}
	}

	//LG("enter_map", "结束进入地图  [%s]================\n\n", pCCha->GetLogName());
	LG("enter_map", "end up entry map  [%s]================\n\n", pCCha->GetLogName());

	//	2008-8-20	yangyinyu	add	begin!
	//lgtool_printCharacter(	RES_STRING(GM_CHARACTER_CPP_00147),	pCCha	);
	//	2008-8-20	yangyinyu	add	end!

	//change by zcj 
	//game_db.SavePlayer(l_player, enumSAVE_TYPE_SWITCH);
	// 因为这个是为了防止复制而加入的，速度提升，只用保存出生地即可
	game_db.OnlySavePosWhenBeSaved(l_player);
	return 0;
}

// 网络通信应用类
GameServerApp::GameServerApp(ThreadPool *proc,ThreadPool *comm)
    :TcpClientApp(this,proc,comm), RPCMGR(this), /*m_count(0), */PKQueue(false), m_UpdateProc(1,100), m_GoOutProc(1,100), m_EnterProc(1,100)
{T_B
	//LG("init", "开始构造ServerApp\n");	
	LG("init", "start init ServerApp\n");	

	m_UpdateProc.Init();
	m_GoOutProc.Init();
	m_EnterProc.Init();

	// 初始化随机数种子
	srand( (unsigned)time( NULL ) );

    // 得到此 GameServer 的网络名称
    m_strGameName = g_Config.m_szName;

    // 初始化 GateServer 数组
    m_gtnum = min(MAX_GATE, g_Config.m_nGateCnt);
    for (int i = 0; i < m_gtnum; ++ i)
	{
        m_gtarray[i].GetIP() = g_Config.m_szGateIP[i];
        m_gtarray[i].GetPort() = g_Config.m_nGatePort[i];
        m_gtarray[i].m_playerlist = NULL;

		m_gtarray[i].Invalid(); // 初始化为无效状态
	}

    //初始化TradeServer
    m_IfServer.SetTradeServer(g_Config.m_szTradeIP, g_Config.m_nTradePort, g_Config.m_szTradePwd, g_Config.m_nSection);

    // 初始化 连接断开锁， 防止对一个 Socket 执行两次 Disconnect
    m_mutdisconn.Create(false);
    
 	m_lastNetCheckTick = GetCurrentTick();
	m_netNum = 0;
	m_lastProcCheckTick = GetCurrentTick();
	m_procNum = 0;

	// 网络设置
    SetPKParse(0,2,32*1024,400);
    BeginWork(g_Config.m_lSocketAlive);

	//LG("init", "ServerApp构造结束\n");
	LG("init", "ServerApp init over\n");
T_E}

GameServerApp::~GameServerApp()
{T_B
	if(m_IfServer.IsConnect())
	{
		DisconnectInfo(&m_IfServer);
		LG("Store_data", "Disconnect TradeServer!\n");
	}

	ShutDown(2*1000);
T_E}

//返回值:true-允许连接,false-不允许连接
bool GameServerApp::OnConnect(DataSocket *datasock)
{T_B
    datasock->SetRecvBuf(64*1024); 
    datasock->SetSendBuf(64*1024);

    LG("Connect", "GateServer Connected! IP = [%s] port = %d\n",  datasock->GetPeerIP() , datasock->GetPeerPort());
   return true;
T_E}

//reason值:0-本地程序正常退出；-3-网络被对方关闭；-1-Socket错误;-5-包长度超过限制.
void GameServerApp::OnDisconnect(DataSocket *datasock,int reason)
{T_B
    LG("Connect", "GateServer Disconnect! IP = [%s] port = %d, reason = [%s]\n",  datasock->GetPeerIP() , datasock->GetPeerPort(), GetDisconnectErrText(reason).c_str());

    GateServer* gt = (GateServer *)datasock->GetPointer();
    if (gt == NULL) return;

    if (!gt->IsValid()) return;
    m_mutdisconn.lock();
    do {
        // dual-check
        if (!gt->IsValid()) break;

		GatePlayer* tmp = gt->m_playerlist;
		GatePlayer* tmpNext;

		while (tmp != NULL)
		{
			tmpNext = tmp->Next;

			if (((CPlayer *)tmp)->IsValid())
			{
				g_pGameApp->GoOutGame((CPlayer *)tmp, true);
			}

			tmp = tmpNext;
		}

		gt->Invalid();

  //      // 通知逻辑层与该Gate的连接断开
  //      WPacket pkt = GetWPacket();
  //      pkt.WriteCmd(CMD_MM_GATE_RELEASE);
		//pkt.WriteLong(MakeULong(gt->m_playerlist));
  //      AddPK(datasock, RPacket(pkt));

        // 清理GateServer
        //gt->Invalid(); // 放到外层操作（CGameApp::OnGateDisconnect处）

    } while (false);
    m_mutdisconn.unlock();

T_E}

void GameServerApp::OnProcessData(DataSocket *datasock,RPacket &pk)
{T_B
	
	dbc::uLong total = this->GetPkTotal();

	uLong	l_tick		=GetCurrentTick();
	if(l_tick - m_lastNetCheckTick < 1000 * 10)
	{
		m_netNum ++;
	}
	else
	{
		static char buffer[64];
		dbc::uShort cmd = pk.ReadCmd();

		_snprintf_s(buffer, _countof(buffer), _TRUNCATE, "net avg=%d num=%d\n", m_netNum / 10, total);
		SendNetMsg(buffer);
		
		m_netNum = 0;
		m_lastNetCheckTick = l_tick;
	}
	
	// 
	extern CGameApp *g_pGameApp;
	g_pGameApp->m_dwRunStep = total;

	//dbc::uShort cmd = pk.ReadCmd();
	//if(cmd == CMD_TM_ENTERMAP || cmd == CMD_TM_GOOUTMAP)
	//{
	//	ProcessData(datasock, pk);
	//}
	//else 
	{
		AddPK(datasock, pk);
	}
T_E}

void GameServerApp::ProcessData(DataSocket* datasock, RPacket& pk)
{T_B
	uLong	l_tick		=GetCurrentTick();
	if(l_tick - m_lastProcCheckTick < 1000 * 10)
	{
		m_procNum ++;
	}
	else
	{
		static char buffer[64];
		dbc::uShort cmd = pk.ReadCmd();

		_snprintf_s(buffer, _countof(buffer), _TRUNCATE, "proc avg=%d \n", m_procNum / 10);
		SendNetProcMsg(buffer);
		
		m_procNum = 0;
		m_lastProcCheckTick = l_tick;
	}

	//static char buffer[64];
	//dbc::uShort cmdDo = pk.ReadCmd();
	//DWORD id = ::GetCurrentThreadId();

	//_snprintf_s(buffer, _countof(buffer), _TRUNCATE, "Id=%d cmd=%d\n", id, cmdDo);
	//SendNetProcMsg(buffer);

	if (datasock == NULL) 
	{
		LG("Connect", "ProcessData datasock == NULL\n");
		return;
	}

    GateServer* gt = (GateServer *)datasock->GetPointer();
    if (gt == NULL) 
	{
		LG("Connect", "ProcessData gt == NULL\n");
		//uShort cmd = pk.ReadCmd();
		return;
	}

    int msg_id;
    uShort cmd = pk.ReadCmd();
    switch (cmd)
        {
        case CMD_MM_GATE_CONNECT:
		    LG("Connect", "ProcessData Gate_Connect\n");
            msg_id = NETMSG_GATE_CONNECTED;
            break;

        case CMD_MM_GATE_RELEASE:
			LG("Connect", "ProcessData Gate_Release\n");
            msg_id = NETMSG_GATE_DISCONNECT;
            break;

        default:
            msg_id = NETMSG_PACKET;
            break;
        }

    g_pGameApp->ProcessNetMsg(msg_id, gt, pk);
T_E}

void GameServerApp::ProcessData(pNetMessage msg, short sType)
{T_B
    switch (sType)
    {
    case TradeServer::CMD_FM_CONNECTED:
        break;

    case TradeServer::CMD_FM_DISCONNECTED:
        break;

    case TradeServer::CMD_FM_MSG:
        break;

    default:
        break;
    }

    g_pGameApp->ProcessInfoMsg(msg, sType, GetTradeServer());
T_E}


// 登录 GateServer
void GameServerApp::ConnectGate(GateServer* pGate)
{T_B
    if (pGate->IsValid()) 
	{
		LG("Connect", "connect to  GateServer failed\n"); 
		return;
	}

    DataSocket* datasock = Connect(pGate->GetIP().c_str(), pGate->GetPort());
    if (datasock == NULL)
    {
		//LG("Connect", "连接 GateServer 失败, ip = %s, port = %d.\n", pGate->GetIP().c_str(), pGate->GetPort() ); 
		LG("Connect", "connect to  GateServer failed, ip = %s, port = %d.\n", pGate->GetIP().c_str(), pGate->GetPort() ); 
		pGate->Invalid(); // 再强制为无效
	}
    else 
	{
		LG("Connect", "connect to  GateServer, ip = %s, port = %d.1\n", pGate->GetIP().c_str(), pGate->GetPort() ); 
        pGate->SetDataSock(datasock);
        datasock->SetPointer(pGate);
		// 通知应用层，连上一个 GateServer
		WPacket wpkt = GetWPacket();
		wpkt.WriteCmd(CMD_MM_GATE_CONNECT);
		wpkt.WriteChar(0);
		AddPK(datasock, RPacket(wpkt));
	}
T_E}

// 登录 TradeServer
bool GameServerApp::ConnectInfo(TradeServer *pInfo)
{T_B
	//pInfo->StopInfoService();
    pInfo->RunInfoService(pInfo->GetIP().c_str(), pInfo->GetPort());
	return true;
T_E}

void GameServerApp::DisconnectInfo(TradeServer *pInfo)
{T_B
    pInfo->StopInfoService();
T_E}

bool GameServerApp::IsValidGate(int i)
{T_B
    if (i < 0 || i > m_gtnum) throw std::logic_error("gate index out of range!");

    return m_gtarray[i].IsValid();
T_E}

GateServer* GameServerApp::FindGate(char const* gt_name)
{T_B
    for (int i = 0; i < m_gtnum; ++ i)
    {
        if (m_gtarray[i].IsValid())
        {
            if (m_gtarray[i].GetName().compare(gt_name) == 0)
                return &m_gtarray[i];
        }
    }

    return NULL;
T_E}


// Player 相关
bool GameServerApp::AddPlayer(GatePlayer* gtplayer, GateServer* gt, unsigned long long gtaddr)
{T_B
    if (gt == NULL || gtplayer == NULL) return false;
    if (!gt->IsValid()) return false;
	if (gtplayer->Next || gtplayer->Prev)
	{
		//LG("玩家链表错误", "向链表插入玩家（dbid %u）时，发现其连接指针非空\n", gtplayer->GetDBChaId());
		LG("character list error ", "when insert character（dbid %u）to character ,find it connect pointer is not empty!\n", gtplayer->GetDBChaId());
		return false;
	}

    // 赋予 GatePlayer 某些字段值
    gtplayer->SetGate(gt);
    gtplayer->SetGateAddr(gtaddr);

    // 将 gtplayer 插入到头部
    gtplayer->Prev = NULL;
    gtplayer->Next = gt->m_playerlist;

    if (gtplayer->Next != NULL)
        gtplayer->Next->Prev = gtplayer;

    // 更新头部
    gt->m_playerlist = gtplayer;

	gt->AddPlayerCount();    
    return true;
T_E}

bool GameServerApp::DelPlayer(GatePlayer* gtplayer)
{T_B
    if (gtplayer == NULL) return false;

    GateServer* gt = gtplayer->GetGate();
    if (gt == NULL || !gt->IsValid()) return false;

	if (gt->m_listcurplayer == gtplayer)
		gt->m_listcurplayer = gtplayer->Next;
    // 从链表中剔除
    if ((gtplayer->Prev == NULL) && (gtplayer->Next == NULL))
        {
        if (gtplayer == gt->m_playerlist)
            { // 只有一个，清空
				gt->m_playerlist = NULL;
            }
        else { // 非法的gtplayer
            return false;}
        }
    else if ((gtplayer->Prev == NULL) && (gtplayer->Next != NULL))
        { // 头部
			if (gtplayer != gt->m_playerlist) return false;

			gt->m_playerlist = gtplayer->Next;
			gt->m_playerlist->Prev = NULL;

        gtplayer->Next = NULL;
        }    
    else if ((gtplayer->Prev != NULL) && (gtplayer->Next == NULL))
        { // 尾部
        gtplayer->Prev->Next = NULL;

        gtplayer->Prev = NULL;
        }
    else { // 中间
        gtplayer->Prev->Next = gtplayer->Next;
        gtplayer->Next->Prev = gtplayer->Prev;

        gtplayer->Prev = NULL;
        gtplayer->Next = NULL;
        }

	gt->DecPlayerCount();
	return true;
T_E}

bool GameServerApp::KickPlayer(GatePlayer* gtplayer, long lTimeSec)
{T_B
    WPacket pkt = GetWPacket();
    pkt.WriteCmd(CMD_MT_KICKUSER);
	pkt.WriteLong(lTimeSec);
    return SendToClient(pkt, gtplayer);
T_E}

bool GameServerApp::KickPlayer2(GatePlayer *gtplayer)
{T_B
	WPacket pkt = GETWPACKET();
	pkt.WriteCmd(CMD_MT_KICKUSER);
	pkt.WriteLong(gtplayer->GetDBChaId());
	pkt.WriteLongLong(gtplayer->GetGateAddr());
	pkt.WriteShort(1);
	gtplayer->GetGate()->SendData(pkt);
	return true;
T_E}

bool GameServerApp::SendToGroup(WPacket& chginf)
{
    GateServer* pGate;

    // 准备为每一个连接的 Gate 产生通知包
    for (int i = 0; i < m_gtnum; ++ i)
        {
        pGate = &m_gtarray[i];

        if (pGate->IsValid())
        {
			chginf.WriteShort( 0 );
			pGate->SendData(chginf);
			return true;
        }
	}
    return true;
}

// 特定发包接口
bool GameServerApp::SendToWorld(WPacket& chginf)
{T_B
    WPacket		CChginf;
    Short		sCount;

    GatePlayer* pPlayer;
    GateServer* pGate;

    // 准备为每一个连接的 Gate 产生通知包
    for (int i = 0; i < m_gtnum; ++ i)
        {
        pGate = &m_gtarray[i];

        if (pGate->IsValid())
            {
            sCount = 0;
            CChginf = chginf.Duplicate();

			pPlayer = pGate->m_playerlist;
            while (pPlayer != NULL)
                {
                CChginf.WriteLong(pPlayer->GetDBChaId());
                CChginf.WriteLongLong(pPlayer->GetGateAddr());
                sCount++;

                pPlayer = pPlayer->Next;}

            if (sCount > 0)
                {
                CChginf.WriteShort(sCount);
                pGate->SendData(CChginf);}
            }
        }

    return true;
T_E}

bool GameServerApp::SendToClient(GatePlayer* player, WPacket& pkt)
{T_B
    if (player == NULL) return false;

    GateServer* pGate = player->GetGate();
    if (pGate != NULL)
    {
        pGate->SendData(pkt);
        return true;
    }
    else
    {
        return false;
    }
T_E}

bool GameServerApp::SendToClient(WPacket& pkt, GatePlayer* playerlist)
{T_B
    if (playerlist == NULL) return false;

    // 找出有效滴 Gate
    uShort		usCount[MAX_GATE];
    WPacket		CChginf[MAX_GATE];
    GateServer* pValidGate[MAX_GATE];
    Short		sValidGateNum = 0;    
    for (int i = 0; i < m_gtnum; ++ i)
        {
        if (m_gtarray[i].IsValid())
            {
            pValidGate[sValidGateNum] = &m_gtarray[i];
            usCount[sValidGateNum] = 0;
            CChginf[sValidGateNum] = pkt.Duplicate();
            sValidGateNum++;
            }
        }

    // 遍历 playerlist ，组织发往各个 Gate 的包
    GatePlayer* tmp = playerlist;
    while (tmp != NULL)
    {
        if (tmp->GetGate() == NULL)
        {      
#ifdef defCOMMU_LOG
            LG("SendToClient", "WARNING! pGate = NULL, cha_id=%d, gt_addr=0x%x\n",
                tmp->GetDBChaId(), tmp->GetGateAddr());
#endif
        }
        else
        {
            for (int i = 0; i < sValidGateNum; ++ i)
            {
                if (tmp->GetGate() == pValidGate[i])
                {
                    usCount[i]++;
                    CChginf[i].WriteLong(tmp->GetDBChaId());
                    CChginf[i].WriteLongLong(tmp->GetGateAddr());
                    break;
                }
            }
        }

        tmp = tmp->GetNextPlayer();
    }

    //　添加最后一个 个数 数据，并发送出去
    for (int i = 0; i < sValidGateNum; i++)
        {
        if (usCount[i] > 0)
            {
            CChginf[i].WriteShort(usCount[i]);
            pValidGate[i]->SendData(CChginf[i]);
            }
        }

    return true;
T_E}

bool GameServerApp::SendToClient(WPacket& pkt, int array_cnt, uplayer* uplayer_array)
{T_B
    if (uplayer_array == NULL) return false;

#ifdef defCOMMU_LOG
    //LG("SendToClient", "\nSendToClient called to notify %d players\n", array_cnt);
#endif

    // 找出有效滴 Gate
    uShort		usCount[MAX_GATE];
    WPacket		CChginf[MAX_GATE];
    GateServer* pValidGate[MAX_GATE];
    Short		sValidGateNum = 0;    
    for (int i = 0; i < m_gtnum; ++ i)
    {
        if (m_gtarray[i].IsValid())
        {
            pValidGate[sValidGateNum] = &m_gtarray[i];
#ifdef defCOMMU_LOG
            //LG("SendToClient", "Valid Gate 0x%x\n", pValidGate[sValidGateNum]);
#endif
            usCount[sValidGateNum] = 0;
            CChginf[sValidGateNum] = pkt.Duplicate();
            sValidGateNum++;
        }
    }
#ifdef defCOMMU_LOG
    //LG("SendToClient", "Valid Gate num = %d\n", sValidGateNum);
#endif

    // 遍历 uplayer_array ，组织发往各个 Gate 的包
    int j;
    for (int i = 0; i < array_cnt; ++ i)
    {
#ifdef defCOMMU_LOG
        //LG("SendToClient", "cha_id = %d, pGate = 0x%x, gt_addr = 0x%x\n", uplayer_array[i].m_dwDBChaId, uplayer_array[i].pGate, uplayer_array[i].m_ulGateAddr);
#endif

        if (uplayer_array[i].pGate == NULL)
        {
#ifdef defCOMMU_LOG
            LG("SendToClient", "WARNING! pGate = NULL, cha_id=%d, gt_addr=0x%x\n",
                uplayer_array[i].m_dwDBChaId, uplayer_array[i].m_ulGateAddr);
#endif
            continue;
        }

        for (j = 0; j < sValidGateNum; ++ j)
        {
            if (uplayer_array[i].pGate == pValidGate[j])
            {
                usCount[j]++;
                CChginf[j].WriteLong(uplayer_array[i].m_dwDBChaId);
                CChginf[j].WriteLongLong(uplayer_array[i].m_ulGateAddr);
                break;
            }
        }
    }

    //　添加最后一个 个数 数据，并发送出去
    for (int i = 0; i < sValidGateNum; i++)
    {
#ifdef defCOMMU_LOG
        //LG("SendToClient", "send to Gate: %s for %d players\n", pValidGate[i]->GetIP().c_str(), usCount[i]);
#endif
        if (usCount[i] > 0)
        {            
            CChginf[i].WriteShort(usCount[i]);
            pValidGate[i]->SendData(CChginf[i]);
        }
    }

    return true;
T_E}

bool GameServerApp::SendToGame(WPacket& pkt, uplayer* uplyr)
{T_B
    return (uplyr->pGate->SendData(pkt) > 0) ? true : false;
T_E}



GameServerApp* g_gmsvr;