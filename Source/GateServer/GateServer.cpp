#include <iostream>
#include <signal.h>
#include <timer.h>
#include "gateserver.h"

using namespace std;


uLong NetBuffer[] =
		{400, 300, 200, 100, 50, 40, 30, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10,
		 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
		 1, 1, 1, 1, 1, 1, 1, 1, 30, 0};

bool	  g_logautobak = true;
LogStream g_gateerr("ErrServer");
LogStream g_gatelog("GateServer");
LogStream g_chkattack("AttackMonitor");
LogStream g_gateconnect("Connect");
//LogStream g_gatepacket("PacketProc");

InterLockedLong g_exit = 0;
InterLockedLong g_ref  = 0;


//NOTE(Ogge): To prevent nullptr referencing of g_gtsvr by ToClient && ToGameServer && ToGroupServer
std::condition_variable global_gate_ready_cv;
std::mutex				global_gate_ready_mutex;
bool					is_global_gate_ready{false};

TimerMgr g_timermgr;
//=========Timer==============
extern "C"
{
  WINBASEAPI HWND APIENTRY GetConsoleWindow(VOID);
}
class DisableCloseButton : public Timer
{
  public:
  DisableCloseButton(uLong interval) :
	  Timer(interval), m_hMenu(0)
  {
	HWND hWnd = ::GetConsoleWindow();
	m_hMenu	  = GetSystemMenu(hWnd, FALSE);
  }

  private:
  ~DisableCloseButton()
  {
  }
  void Process()
  {
	RefArmor l(g_ref);
	if(!g_exit && m_hMenu)
	{
	  EnableMenuItem(m_hMenu, SC_CLOSE, MF_BYCOMMAND | MF_GRAYED);
	}
  }
  HMENU m_hMenu;
};
class DelayLogout : public Timer, public RunBiDirectChain<Player>
{
  public:
  DelayLogout(uLong interval) :
	  Timer(interval) {}
  void AddPlayer(Player* ply)
  {
	ply->_BeginRun(this);
  }
  void DelPlayer(Player* ply)
  {
	ply->_EndRun();
  }

  private:
  void Process()
  {
	Player*					 l_ply = 0;
	RunChainGetArmor<Player> l_lock(*this);
	while(l_ply = GetNextItem())
	{
	}
	l_lock.unlock();
  }
};

void __cdecl ctrlc_dispatch(int sig)
{
  if(sig == SIGINT)
  {
	g_exit = 1;
	signal(SIGINT, ctrlc_dispatch);
  }
}

//---------------------------------------------------------------------------
// class GateServer
//---------------------------------------------------------------------------
GateServer::GateServer(char const* fname) :
	player_heap(1, 2000), m_tch(1, 100), gm_conn(NULL), gp_conn(NULL), cli_conn(NULL), m_clcomm(NULL), m_gpcomm(NULL), m_gmcomm(NULL), m_clproc(NULL)
{
  TcpCommApp::WSAStartup();
  srand((unsigned int)time(NULL)); // 初始化随机数种子

  m_tch.Init();
  player_heap.Init();

  m_clproc = ThreadPool::CreatePool(24, 32, 4096);
  m_clcomm = ThreadPool::CreatePool(6, 12, 4096, THREAD_PRIORITY_ABOVE_NORMAL);
  m_gpproc = ThreadPool::CreatePool(4, 8, 1024, THREAD_PRIORITY_ABOVE_NORMAL);
  m_gpcomm = ThreadPool::CreatePool(12, 24, 2048, THREAD_PRIORITY_ABOVE_NORMAL);
  m_gmcomm = ThreadPool::CreatePool(4, 4, 2048, THREAD_PRIORITY_ABOVE_NORMAL);

  //m_mmsproc = ThreadPool::CreatePool(4, 8, 1024, THREAD_PRIORITY_ABOVE_NORMAL);
  //m_mmscomm = ThreadPool::CreatePool(12, 24, 2048, THREAD_PRIORITY_ABOVE_NORMAL);

  try
  {
	gm_conn	 = new ToGameServer(fname, 0, m_gmcomm);
	gp_conn	 = new ToGroupServer(fname, m_gpproc, m_gpcomm);
	cli_conn = new ToClient(fname, m_clproc, m_clcomm);

	//m_ToMMS = new ToMMS(fname, m_mmsproc, m_mmscomm);
	//m_mmsproc->AddTask(new ConnectMMS(m_ToMMS));

	m_gpproc->AddTask(new ConnectGroupServer(gp_conn));
	m_clproc->AddTask(&g_timermgr);
	g_timermgr.AddTimer(new DisableCloseButton(200));
	signal(SIGINT, ctrlc_dispatch);
  } catch(...)
  {
	if(gp_conn)
	{
	  delete gp_conn;
	  gp_conn = 0;
	}
	if(gm_conn)
	{
	  delete gm_conn;
	  gm_conn = NULL;
	}
	if(cli_conn)
	{
	  delete cli_conn;
	  cli_conn = NULL;
	}

	//if(m_ToMMS)
	//{
	//	delete m_ToMMS;
	//	m_ToMMS = NULL;
	//}

	m_gmcomm->DestroyPool();
	m_gpcomm->DestroyPool();
	m_clcomm->DestroyPool();
	m_clproc->DestroyPool();

	//m_mmsproc->DestroyPool();
	//m_mmscomm->DestroyPool();

	TcpCommApp::WSACleanup();
	throw;
  }
}

GateServer::~GateServer()
{
  g_exit = 1;
  while(g_ref)
  {
	Sleep(1);
  }
  delete cli_conn;
  delete gp_conn;
  delete gm_conn;

  //delete m_ToMMS;
  //m_mmsproc->DestroyPool();
  //m_mmscomm->DestroyPool();

  m_gmcomm->DestroyPool();
  m_gpcomm->DestroyPool();
  m_clcomm->DestroyPool();
  m_clproc->DestroyPool();
  TcpCommApp::WSACleanup();
}

void GateServer::RunLoop()
{
  BandwidthStat l_band;
  LLong			recvpkps_max = 0, recvbandps_max = 0, sendpkps_max = 0, sendbandps_max = 0;

  dstring l_str;
  l_str.SetSize(256);
  while(!g_exit)
  {
	std::cout << RES_STRING(GS_GATESERVER_CPP_00001);
	std::cin.getline(l_str.GetBuffer(), 256);

	if(l_str == "exit" || g_exit)
	{
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00002) << std::endl;
	  break;
	} else if(l_str == "help" || l_str == "?")
	{
	  std::cout << "exit" << std::endl;
	  std::cout << "getinfo" << std::endl;
	  std::cout << "clmax" << std::endl;
	  std::cout << "getmaxcon" << std::endl;
	  std::cout << "setmaxcon" << std::endl;
	  std::cout << "reconnect" << std::endl;
	  std::cout << "calltotal" << std::endl;
	  std::cout << "getcheck" << std::endl;
	  std::cout << "setcheckspan" << std::endl;
	  std::cout << "setcheckwaring" << std::endl;
	  std::cout << "setcheckerror" << std::endl;
	  std::cout << " " << std::endl;
	  std::cout << "help" << std::endl;

	} else if(l_str == "getinfo")
	{
	  std::cout << "getinfo..." << std::endl;

	  l_band = cli_conn->GetBandwidthStat();
	  std::cout << "getinfo: GetBandwidthStat..." << std::endl;

	  std::cout << RES_STRING(GS_GATESERVER_CPP_00003) << cli_conn->GetSockTotal() << std::endl;
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00004) << l_band.m_sendpktps << "}{pkt:" << l_band.m_sendpkts << "}{KB/s:" << l_band.m_sendbyteps / 1024 << "}{KB:" << l_band.m_sendbytes / 1024 << "}" << std::endl;
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00005) << l_band.m_recvpktps << "}{pkt:" << l_band.m_recvpkts << "}{KB/s:" << l_band.m_recvbyteps / 1024 << "}{KB:" << l_band.m_recvbytes / 1024 << "}" << std::endl;

	  if(l_band.m_sendpktps > sendpkps_max) sendpkps_max = l_band.m_sendpktps;
	  if(l_band.m_sendbyteps / 1024 > sendbandps_max) sendbandps_max = l_band.m_sendbyteps / 1024;
	  if(l_band.m_recvpktps > recvpkps_max) recvpkps_max = l_band.m_recvpktps;
	  if(l_band.m_recvbyteps / 1024 > recvbandps_max) recvbandps_max = l_band.m_recvbyteps / 1024;
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00006) << sendpkps_max << "}{KB/s:" << sendbandps_max << "}" << std::endl;
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00007) << recvpkps_max << "}{KB/s:" << recvbandps_max << "}" << std::endl;
	} else if(l_str == "clmax")
	{
	  recvpkps_max = recvbandps_max = sendpkps_max = sendbandps_max = 0;
#ifdef NET_CAL
	} else if(l_str == "getcheck")
	{
	  std::cout << "Span = " << g_gtsvr->cli_conn->GetCheckSpan() << "Waring = " << g_gtsvr->cli_conn->GetCheckWaring() << "Error = " << g_gtsvr->cli_conn->GetCheckError() << std::endl;
	} else if(!strncmp(l_str.c_str(), "setcheckspan", 12))
	{
	  uShort l_span = atoi(l_str.c_str() + 12);
	  g_gtsvr->cli_conn->SetCheckSpan(l_span);
	} else if(!strncmp(l_str.c_str(), "setcheckwaring", 14))
	{
	  uShort l_span = atoi(l_str.c_str() + 14);
	  g_gtsvr->cli_conn->SetCheckWaring(l_span);
	} else if(!strncmp(l_str.c_str(), "setcheckerror", 13))
	{
	  uShort l_span = atoi(l_str.c_str() + 13);
	  g_gtsvr->cli_conn->SetCheckError(l_span);
#endif
	} else if(l_str == "getmaxcon")
	{
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00008) << g_gtsvr->cli_conn->GetMaxCon() << std::endl;
	} else if(!strncmp(l_str.c_str(), "setmaxcon", 9))
	{
	  uShort l_maxcon = atoi(l_str.c_str() + 9);
	  if(l_maxcon > 1500)
	  {
		std::cout << RES_STRING(GS_GATESERVER_CPP_00009) << std::endl;
		l_maxcon = 1500;
	  } else
	  {
		std::cout << RES_STRING(GS_GATESERVER_CPP_00010) << l_maxcon << std::endl;
	  }
	  g_gtsvr->cli_conn->SetMaxCon(l_maxcon);
	} /*else	if(l_str	=="logbak")
		{
			LogStream::Backup();
		}*/
	else if(l_str == "getqueparm")
	{
	  std::cout << "ToClient Process Queue:" << m_clproc->GetTaskCount() << "\tToClint Comm Queue:" << m_clcomm->GetTaskCount() << std::endl;
	  std::cout << "ToGroup Comm Queue:" << m_gpcomm->GetTaskCount() << "\tToGame Comm Queue:" << m_gmcomm->GetTaskCount() << std::endl;
	} else if(l_str == "reconnect")
	{
	  if(g_gtsvr->gp_conn)
	  {
		g_gtsvr->gp_conn->Disconnect(g_gtsvr->gp_conn->get_datasock(), -9);
		std::cout << "reconnect success!" << std::endl;
	  } else
	  {
		std::cout << "reconnect failed! null pointer!" << std::endl;
	  }
	} else if(l_str == "calltotal")
	{
	  std::cout << "clinet::calltotal:[" << g_gtsvr->cli_conn->GetCallTotal() << "]" << std::endl;
	  std::cout << "group::calltotal:[" << g_gtsvr->gp_conn->GetCallTotal() << "]" << std::endl;
	} else
	{
	  std::cout << RES_STRING(GS_GATESERVER_CPP_00012) << std::endl;
	}
  }
}

//---------------------------------------------------------------------------
// class Player
//---------------------------------------------------------------------------
bool Player::InitReference(DataSocket* datasock)
{
  MutexArmor lock(g_gtsvr->_mtxother); //组织重复进入
  if(datasock && !datasock->GetPointer())
  {
	datasock->SetPointer(this);
	m_datasock = datasock;
	lock.unlock();
	return true;
  } else
  {
	if(datasock)
	{
	  try
	  {
		//printf( "InitReference warning: %s重复进入连接信息！", datasock->GetPeerIP() );
		printf(RES_STRING(GS_GATESERVER_CPP_00013), datasock->GetPeerIP());
		Player* l_ply = (Player*)datasock->GetPointer();
		if(l_ply)
		{
		  l_ply->m_datasock = NULL;
		  datasock->SetPointer(NULL);
		}
	  } catch(...)
	  {
		//printf( "InitReference warning: %s重复进入连接信息！exception", datasock->GetPeerIP() );
		printf(RES_STRING(GS_GATESERVER_CPP_00014), datasock->GetPeerIP());
	  }
	}
	lock.unlock();
	return false;
  }
  lock.unlock();
  return false;
}

void Player::Initially()
{
  m_worldid = m_actid = m_dbid = gm_addr = gp_addr = m_status = 0;
  m_password[0]															 = 0;
  m_datasock															 = NULL;
  game																	 = NULL;

  enc			 = false;
  m_pingtime	 = 0;
  m_lestoptick	 = GetTickCount();
  m_estop		 = false;
  m_sGarnerWiner = 0;

  // RSA-AES BOTAN
  m_clientPrivateKey = nullptr;
  m_clientPublicKey	 = nullptr;
  Botan::AutoSeeded_RNG rng;
  Botan::SymmetricKey aes_key(rng, AES_KEY_LENGTH); // Clears on destruction.
  Botan::InitializationVector iv(rng, aes_key.length());
  memcpy(m_AESKey, aes_key.bits_of().data(), aes_key.bits_of().size());
  memcpy(m_IV, iv.bits_of().data(), iv.bits_of().size());
}

void Player::Finally()
{
  m_worldid = m_actid = m_dbid = gm_addr = gp_addr = m_status = 0;
  game														  = NULL;
  enc = false;
  if(m_datasock != NULL)
  {
	m_datasock->SetPointer(NULL);
	m_datasock = NULL;
  }
  if(m_clientPrivateKey)
  {
	delete m_clientPrivateKey;
	m_clientPrivateKey = nullptr;
  }
  if (m_clientPublicKey)
  {
	delete m_clientPublicKey;
	m_clientPublicKey = nullptr;
  }
  memset(m_AESKey, 0, sizeof(m_AESKey));
  memset(m_IV, 0, sizeof(m_IV));
}

// Add by lark.li 20081119 begin
bool Player::BeginRun()
{
  return RunBiDirectItem<Player>::_BeginRun(&(g_gtsvr->m_plylst)) ? true : false;
}
bool Player::EndRun()
{
  return RunBiDirectItem<Player>::_EndRun() ? true : false;
}
// End

//---------------------------------------------------------------------------
// class GateServerApp
//---------------------------------------------------------------------------
GateServerApp* g_app = NULL;

GateServerApp::GateServerApp()
{
  g_app = this;
}

void GateServerApp::ServiceStart()
{
  // 启动服务器
  try
  {
	const char* file_cfg = "GateServer.cfg";
	g_gtsvr				 = new GateServer(file_cfg);

	std::unique_lock<std::mutex> lk(global_gate_ready_mutex);
	is_global_gate_ready = true;
	lk.unlock();
	global_gate_ready_cv.notify_all();
  } catch(std::exception const& e)
  {
	cout << e.what() << endl;
	Sleep(10 * 1000);
	exit(-1);
  } catch(...)
  {
	//cout << "GateServer 初始化期间发生未知错误，请通知开发者!" << endl;
	cout << RES_STRING(GS_GATESERVER_CPP_00016) << endl;
	Sleep(10 * 1000);
	exit(-2);
  }

  // 服务器启动成功，进入主循环
  //cout << "GateServer 启动成功!" << endl;
  cout << RES_STRING(GS_GATESERVER_CPP_00017) << endl;
}
void GateServerApp::ServiceStop()
{
  // 服务器退出
  delete g_gtsvr;
  g_app = NULL;

  //cout << "GateServer 成功退出!" << endl;
  cout << RES_STRING(GS_GATESERVER_CPP_00018) << endl;
  Sleep(2000);
}

// 全局 GateServer 对象
GateServer* g_gtsvr;
bool volatile g_appexit = false;
