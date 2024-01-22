
#include "gateserver.h"
dbc::cuShort g_version = 103;

long ConnectGroupServer::Process()
{
  extern std::mutex				 global_gate_ready_mutex;
  extern std::condition_variable global_gate_ready_cv;
  extern bool					 is_global_gate_ready;
  std::unique_lock<std::mutex>	 lk(global_gate_ready_mutex);
  global_gate_ready_cv.wait(lk, []
							{ return is_global_gate_ready; });
  lk.unlock();

  T_B
	  _tgps->m_calltotal++;

  DataSocket* datasock{};
  while(!GetExitFlag() && !_tgps->m_atexit)
  {
	// Skip (Re)establish a connection to GroupServer if there is one already
	if(_tgps->_connected)
	{
	  Sleep(1000);
	  continue;
	}

	// Try to establish a connect
	LogLine l_line(g_gateconnect);
	l_line << newln << RES_STRING(GS_TOGROUPSERVER_CPP_00001) << endln;
	datasock = _tgps->Connect(_tgps->_gs.ip.c_str(), _tgps->_gs.port);
	if(!datasock)
	{
	  LogLine l_line(g_gateconnect);
	  l_line << newln << RES_STRING(GS_TOGROUPSERVER_CPP_00002) << endln;
	  Sleep(5000);
	  continue;
	}

	// Connection established with GroupServer - perform a handshake?
	//SECURITY: version key is seemingly the only thing that keeps a hostile gateserver to succeed the full handshake
	WPacket pk = _tgps->GetWPacket();
	pk.WriteCmd(CMD_TP_LOGIN);
	pk.WriteShort(g_version);
	pk.WriteString(_tgps->_myself.c_str());

	RPacket retpk = _tgps->SyncCall(datasock, pk);
	int		err	  = retpk.ReadShort();
	if(!retpk.HasData() || err == ERR_PT_LOGFAIL)
	{
	  LogLine l_line(g_gateconnect);
	  l_line << newln << RES_STRING(GS_TOGROUPSERVER_CPP_00003) << endln;
	  datasock = nullptr;
	  Sleep(5000);
	  _tgps->Disconnect(datasock);
	  return 0;
	}

	l_line << newln << RES_STRING(GS_TOGROUPSERVER_CPP_00004) << endln;
	_tgps->_gs.datasock = datasock;
	_tgps->_connected	= true;

	datasock = nullptr;
  }

  T_FINAL

  return 0;
}
Task* ConnectGroupServer::Lastly()
{
  --(_tgps->m_calltotal);
  return Task::Lastly();
}

ToGroupServer::ToGroupServer(char const* fname, ThreadPool* proc, ThreadPool* comm)
	:
	TcpClientApp(this, proc, comm),
	RPCMGR(this)
{
  IniFile	  inf(fname);
  IniSection& is = inf["GroupServer"];
  _myself		 = inf["Main"]["Name"];
  _gs.ip		 = is["IP"];
  _gs.port		 = atoi(is["Port"]);

  // 启动 PING 线程

  SetPKParse(0, 2, 64 * 1024, 400);
  BeginWork(atoi(is["EnablePing"]));

  //++m_calltotal;
  //proc->AddTask(new ConnectGroupServer(this));
}

ToGroupServer::~ToGroupServer()
{
  m_atexit = 1;
  while(m_calltotal)
  {
	Sleep(1);
  }
  ShutDown(12 * 1000);
}

void ToGroupServer::TaskDispatcher(Task* task)
{
  extern std::mutex				 global_gate_ready_mutex;
  extern std::condition_variable global_gate_ready_cv;
  extern bool					 is_global_gate_ready;
  std::unique_lock<std::mutex>	 lk(global_gate_ready_mutex);
  global_gate_ready_cv.wait(lk, []
							{ return is_global_gate_ready; });

  lk.unlock();

  TcpClientApp::TaskDispatcher(task);
}

bool ToGroupServer::OnConnect(DataSocket* datasock) //返回值:true-允许连接,false-不允许连接
{
  datasock->SetRecvBuf(64 * 1024);
  datasock->SetSendBuf(64 * 1024);
  LogLine l_line(g_gateconnect);
  //l_line<<newln<<"连接上GroupServer: "<<datasock->GetPeerIP()<<",Socket数目:"<<GetSockTotal()+1;
  l_line << newln << "connect GroupServer: " << datasock->GetPeerIP() << ",Socket num:" << GetSockTotal() + 1;
  return true;
}

void ToGroupServer::OnDisconnect(DataSocket* datasock, int reason) //reason值:0-本地程序正常退出；-3-网络被对方关闭；-1-Socket错误;-5-包长度超过限制。
{																   // 激活 ConnnectGroupServer 线程
  LogLine l_line(g_gateconnect);
  l_line << newln << "disconnection with GroupServer,Socket num: " << GetSockTotal() << ",reason =" << GetDisconnectErrText(reason).c_str() << ", reconnecting..." << endln;

  // Add by lark.li 20081210 begin
  Player*				   l_ply = 0;
  RunChainGetArmor<Player> l(g_gtsvr->m_plylst);
  for(l_ply = g_gtsvr->m_plylst.GetNextItem(); l_ply; l_ply = g_gtsvr->m_plylst.GetNextItem())
  {
	if(l_ply)
	{
	  if(l_ply->m_status != 2)
		g_gtsvr->cli_conn->Disconnect(l_ply->m_datasock, 100, -29);
	}
  }
  // End

  if(!g_appexit) { _connected = false; }
}

WPacket ToGroupServer::OnServeCall(DataSocket* datasock, RPacket& in_para)
{
  uShort  l_cmd = in_para.ReadCmd();
  WPacket retpk = GetWPacket();

  switch(l_cmd)
  {
  case 0:
  default:
	break;
  }

  return retpk;
}

void ToGroupServer::OnProcessData(DataSocket* datasock, RPacket& recvbuf)
{
  uShort l_cmd = recvbuf.ReadCmd();
  //LG("ToGroupServer", "-->l_cmd = %d\n", l_cmd);
  try
  {
	switch(l_cmd)
	{
	case CMD_PM_TEAM:
	{
	  for(GameServer* l_game = g_gtsvr->gm_conn->_game_list; l_game; l_game = l_game->next)
	  {
		g_gtsvr->gm_conn->SendData(l_game->m_datasock, recvbuf);
	  }
	  break;
	}
	case CMD_AP_KICKUSER:
	case CMD_PT_KICKUSER:
	{
	  uShort  l_aimnum = recvbuf.ReverseReadShort();
	  Player* l_ply	   = (Player*)MakePointer(recvbuf.ReverseReadLongLong());
	  if(l_ply && l_ply->gp_addr == recvbuf.ReverseReadLongLong())
	  {
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"收到GroupServer的T人包并且T掉,l_ply->m_dbid ="<<l_ply->m_dbid<<endln;
		l_line << newln << "GroupServer kill person,l_ply->m_dbid =" << l_ply->m_dbid << endln;
		g_gtsvr->cli_conn->Disconnect(l_ply->m_datasock, 0, -21);
	  } else if(l_ply)
	  {
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"收到GroupServer的T人包但没T掉,l_ply->m_dbid ="<<l_ply->m_dbid<<endln;
		l_line << newln << "GroupServer kick person, but can't kick person,l_ply->m_dbid =" << l_ply->m_dbid << endln;
	  }
	  break;
	}
	case CMD_PT_DEL_ESTOPUSER:
	{
	  //printf( "CMD_PT_DEL_ESTOPUSER" );
	  uShort  l_aimnum = recvbuf.ReverseReadShort();
	  Player* l_ply	   = (Player*)MakePointer(recvbuf.ReverseReadLongLong());
	  if(l_ply && l_ply->gp_addr == recvbuf.ReverseReadLongLong())
	  {
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"收到GroupServer的解除禁言包，操作成功,l_ply->m_dbid ="<<l_ply->m_dbid<<endln;
		l_line << newln << "GroupServer del estop user,operator success,l_ply->m_dbid =" << l_ply->m_dbid << endln;
		l_ply->m_estop = false;
	  } else if(l_ply)
	  {
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"收到GroupServer的解除禁言包但没解掉,l_ply->m_dbid ="<<l_ply->m_dbid<<endln;
		l_line << newln << "GroupServer del estop user, but can't operator success,l_ply->m_dbid =" << l_ply->m_dbid << endln;
	  }
	}
	break;
	case CMD_PT_ESTOPUSER:
	{
	  //printf( "CMD_PT_ESTOPUSER" );
	  uShort  l_aimnum = recvbuf.ReverseReadShort();
	  Player* l_ply	   = (Player*)MakePointer(recvbuf.ReverseReadLongLong());
	  if(l_ply && l_ply->gp_addr == recvbuf.ReverseReadLongLong())
	  {
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"收到GroupServer的禁言包，操作成功,l_ply->m_dbid ="<<l_ply->m_dbid<<endln;
		l_line << newln << "GroupServer del estop user,operator success,l_ply->m_dbid =" << l_ply->m_dbid << endln;
		l_ply->m_estop = true;
	  } else if(l_ply)
	  {
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"收到GroupServer的禁言包但没禁掉,l_ply->m_dbid ="<<l_ply->m_dbid<<endln;
		l_line << newln << "GroupServer del estop user, but can't operator success,l_ply->m_dbid =" << l_ply->m_dbid << endln;
	  }
	}
	break;
	case CMD_MC_SYSINFO:
	  l_cmd = CMD_PC_BASE;
	default: //缺省转发
	{
	  if(l_cmd / 500 == CMD_PC_BASE / 500)
	  {
		RPacket l_rpk	 = recvbuf;
		uShort	l_aimnum = l_rpk.ReverseReadShort();
		recvbuf.DiscardLast(sizeof(uLong) * 1 * l_aimnum + sizeof(LLong) + sizeof(uShort));
		Player* l_ply = 0;
		for(uShort i = 0; i < l_aimnum; i++)
		{
		  l_ply = (Player*)MakePointer(l_rpk.ReverseReadLongLong());
		  if(l_ply->gp_addr == l_rpk.ReverseReadLongLong())
		  {
			g_gtsvr->cli_conn->SendData(l_ply->m_datasock, recvbuf);
		  } else
		  {
			l_ply = 0;
		  }
		}
		if(l_cmd == CMD_PC_CHANGE_PERSONINFO && l_ply)
		{
		  WPacket l_wpk = recvbuf;
		  l_wpk.WriteCmd(CMD_TM_CHANGE_PERSONINFO);
		  l_wpk.WriteLongLong(MakeULong(l_ply));
		  l_wpk.WriteLongLong(l_ply->gm_addr); //附加上在GameServer上的内存地址
		  g_gtsvr->gm_conn->SendData(l_ply->game->m_datasock, l_wpk);
		  break;
		}
		if(l_cmd == CMD_PC_PING && l_ply)
		{
		  l_ply->m_pingtime = GetTickCount();
		  break;
		}
	  } else if(l_cmd / 500 == CMD_PM_BASE / 500)
	  {
		RPacket l_rpk	 = recvbuf;
		uShort	l_aimnum = l_rpk.ReverseReadShort();
		recvbuf.DiscardLast(sizeof(uLong) * 1 * l_aimnum + sizeof(LLong) + sizeof(uShort));
		if(!l_aimnum)
		{
		  WPacket l_wpk = WPacket(recvbuf).Duplicate();
		  l_wpk.WriteLong(0);
		  for(GameServer* l_game = g_gtsvr->gm_conn->_game_list; l_game; l_game = l_game->next)
		  {
			g_gtsvr->gm_conn->SendData(l_game->m_datasock, l_wpk);
		  }
		} else
		{
		  WPacket l_wpk, l_wpk0 = WPacket(recvbuf).Duplicate();
		  for(uShort i = 0; i < l_aimnum; i++)
		  {
			Player* l_ply = (Player*)MakePointer(l_rpk.ReverseReadLongLong());
			if(l_ply->gp_addr == l_rpk.ReverseReadLongLong() && l_ply->game)
			{
			  l_wpk = l_wpk0;
			  l_wpk.WriteLongLong(MakeULong(l_ply));
			  l_wpk.WriteLongLong(l_ply->gm_addr);
			  g_gtsvr->gm_conn->SendData(l_ply->game->m_datasock, l_wpk);
			}
		  }
		}
	  }
	  break;
	}
	}
  } catch(...)
  {
	LG("ToGroupServerError", "l_cmd = %d\n", l_cmd);
  }
  //LG("ToGroupServer", "<--l_cmd = %d\n", l_cmd);
}

// 从 GroupServer 上得到所有用户列表
RPacket ToGroupServer::get_playerlist()
{
  WPacket pk = GetWPacket();
  pk.WriteCmd(CMD_TP_REQPLYLST);

  return SyncCall(_gs.datasock, pk);
}
