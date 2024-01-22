#ifndef _GATESERVER_H_
#define _GATESERVER_H_

#include <i18n.h> //Add by lark.li 20080130

#include <iostream>
#include <map>
#include <time.h>
#include <dstring.h>
#include <datasocket.h>
#include <threadpool.h>
#include <commrpc.h>
#include <point.h>
#include <inifile.h>
#include <gamecommon.h>
#include <prealloc.h>
#include <ntservice.h>
#include <LogStream.h>
#include <algo.h>
#include <PacketEncryption.h>
#include <stdlib.h>
#include <unordered_map>

#include <util.h>



using namespace std;
using namespace dbc;

// ��ʱ�˳����ƺ��л�
//#define CHAEXIT_ONTIME
enum PlayStatus
{

};


struct AntiDDoSInfo
{
  volatile bool	  m_bIsBlacklisted{false};
  volatile uShort m_checkSpan{1};
  volatile uShort m_checkWaring{5};
  volatile uShort m_checkError{7};
  volatile uLong  m_cmdNum{0};
  volatile uLong  m_Warning{0};
  volatile uLong  m_lastConnectionTick{0};
};


// ���� Client ���Ӳ��֣�������������������
struct Player;
class ToClient : public TcpServerApp, public RPCMGR
{
  friend class TransmitCall;

  public:
  ToClient(char const* fname, ThreadPool* proc, ThreadPool* comm);
  ~ToClient();

  void	  post_mapcrash_msg(Player* ply);
  dstring GetDisconnectErrText(int reason);
  void	  SetMaxCon(uShort maxcon) { m_maxcon = maxcon; }
  uShort  GetMaxCon() { return m_maxcon; }
  void	  CM_LOGIN(DataSocket* datasock, RPacket& recvbuf);
  WPacket CM_LOGOUT(DataSocket* datasock, RPacket& recvbuf);
  WPacket CM_DISCONN(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_BGNPLAY(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_ENDPLAY(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_NEWCHA(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_DELCHA(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_CREATE_PASSWORD2(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_UPDATE_PASSWORD2(DataSocket* datasock, RPacket& recvbuf);
  void	  CM_RSA_HANDSHAKE1(DataSocket* datasock, RPacket& recvbuf);
  uShort  GetVersion() { return m_version; }
  int	  GetCallTotal() { return m_calltotal; }
 // int	  BackDoor(const char* l_str);

  /*
  uShort GetCheckSpan()
  {
	return m_checkSpan;
  }
  uShort GetCheckWaring() { return m_checkWaring; }
  uShort GetCheckError() { return m_checkError; }

  */
  void SetCheckSpan(uShort checkSpan);
  void SetCheckWaring(uShort checkWaring);
  void SetCheckError(uShort checkError);

  bool VerifyDDoS(DataSocket* datasock);


  private:
  virtual void	  TaskDispatcher(Task* task) final;
  virtual bool	  OnConnect(DataSocket* datasock); // ����ֵ:true-��������,false-����������
  virtual void	  OnConnected(DataSocket* datasock);
  virtual void	  OnDisconnect(DataSocket* datasock, int reason);
  virtual void	  OnProcessData(DataSocket* datasock, RPacket& recvbuf);
  virtual WPacket OnServeCall(DataSocket* datasock, RPacket& in_para);
  virtual bool	  OnSendBlock(DataSocket* datasock) { return false; }

  // communication encryption
  virtual void OnEncrypt(DataSocket* datasock, char* ciphertext, const char* text, uLong& len);
  virtual void OnDecrypt(DataSocket* datasock, char* ciphertext, uLong& len);

  void ReRouteToGameServer(dbc::DataSocket* datasock, dbc::RPacket& recvbuf);
  void ReRouteToGroupServer(dbc::DataSocket* datasock, dbc::RPacket& recvbuf);

  InterLockedLong m_atexit, m_calltotal;
  volatile uShort m_maxcon;
  uShort		  m_version;
  int			  _comm_enc; // �����㷨����
  bool            m_antiddos = true;
  // Server has only 1 private+public key pair.
  Botan::RSA_PrivateKey* m_serverPrivateKey;

  uShort m_connectionMinInterval;

  std::mutex									 m_mtx;
  std::unordered_map<std::string, AntiDDoSInfo>  m_mapConnectionInfo; 


  //volatile uShort	m_checkIPNum;	// ����ظ�IP����
  //volatile uShort	m_checkIPSpan;	// ����ظ�IP���
};

// ���� GameServer ���Ӳ��֣�����������������������������
class ToGameServer;

#define MAX_MAP 100
#define MAX_GAM 100
struct GameServer : public PreAllocStru
{
  friend class PreAllocHeap<GameServer>;

  private:
  GameServer(uLong Size) :
	  PreAllocStru(Size),
	  m_datasock(NULL), next(NULL) {}
  ~GameServer()
  {
	if(m_datasock != NULL)
	{
	  m_datasock->SetPointer(NULL);
	  m_datasock = NULL;
	}
  }
  GameServer(GameServer const&) :
	  PreAllocStru(1) {}
  GameServer& operator=(GameServer const&) {}
  void		  Initially();
  void		  Finally();

  public:
  void EnterMap(Player* ply, uLong actid, uLong dbid, uLong worldid, cChar* map, Long lMapCpyNO, uLong x, uLong y, char entertype, short swiner); //��ɫchaid���뱾�������ĵ�ͼmap�е�λ��(x,y) winerָ����ɫ�Ƿ����Ҷ�֮����

  // Add by lark.li 20080921 begin
  void DeleteGameServer(int reason); //�����쳣�ر�GameServer
									 // End

  public:
  InterLockedLong m_plynum;
  string		  gamename;
  string		  ip;
  uShort		  port;
  DataSocket*	  m_datasock;
  GameServer*	  next;
  string		  maplist[MAX_MAP];
  uShort		  mapcnt;
};

class ToGameServer : public TcpServerApp, public RPCMGR
{
  friend class ToGroupServer;

  public:
  ToGameServer(char const* fname, ThreadPool* proc, ThreadPool* comm);
  ~ToGameServer();

  GameServer* find(cChar* mapname);

  void SendAllGameServer(WPacket& in_para);

  private:
  virtual void	  TaskDispatcher(Task* task) final;
  virtual bool	  OnConnect(DataSocket* datasock); //����ֵ:true-��������,false-����������
  virtual void	  OnDisconnect(DataSocket* datasock, int reason);
  virtual WPacket OnServeCall(DataSocket* datasock, RPacket& in_para);
  virtual void	  OnProcessData(DataSocket* datasock, RPacket& recvbuf);

  PreAllocHeap<GameServer> _game_heap;										 // GameServer ���������
  void					   MT_LOGIN(DataSocket* datasock, RPacket& recvbuf); // GameServer ��¼ GateServer

  GameServer*			   _game_list; // �洢 GameServer �������������
  short					   _game_num;
  void					   _add_game(GameServer* game);
  bool					   _exist_game(char const* game);
  void					   _del_game(GameServer* game);
  map<string, GameServer*> _map_game; // �ӵ�ͼ����Ӧ GameServer ��������
  Mutex					   _mut_game;
};

// ���� GroupServer ���Ӳ��֣�������������������
class ToGroupServer;
class ConnectGroupServer : public Task
{
  public:
  ConnectGroupServer(ToGroupServer* tgts)
  {
	_tgps	 = tgts;
	_timeout = 3000;
  }

  private:
  virtual long	Process();
  virtual Task* Lastly();

  ToGroupServer* _tgps;
  DWORD			 _timeout;
};

struct GroupServer
{
  GroupServer() = default;
  string	   ip;
  uShort	   port{};
  DataSocket*  datasock{};
  GroupServer* next{};
};

class ToGroupServer : public TcpClientApp, public RPCMGR
{
  friend class ConnectGroupServer;
  friend void ToGameServer::MT_LOGIN(DataSocket* datasock, RPacket& rpk);

  public:
  ToGroupServer(char const* fname, ThreadPool* proc, ThreadPool* comm);
  ~ToGroupServer();

  DataSocket* get_datasock() const { return _gs.datasock; }
  RPacket	  get_playerlist();

  int GetCallTotal() { return m_calltotal; }

  bool IsReady() const {return _connected; }

  private:
  void			  TaskDispatcher(Task* task) final;
  virtual bool	  OnConnect(DataSocket* datasock); // ����ֵ:true-��������,false-����������
  virtual void	  OnDisconnect(DataSocket* datasock, int reason);
  virtual void	  OnProcessData(DataSocket* datasock, RPacket& recvbuf);
  virtual WPacket OnServeCall(DataSocket* datasock, RPacket& in_para);

  InterLockedLong m_atexit{}, m_calltotal{};

  string	  _myself; // GateServer�Լ�������
  GroupServer _gs;
  bool volatile _connected{};
};

// GateServer �������֣�����������������������������������������
struct Player : public PreAllocStru, public RunBiDirectItem<Player>
{
  friend class PreAllocHeap<Player>;
  friend class DelayLogout;

  public:
  bool InitReference(DataSocket* datasock);
  void Free() { PreAllocStru::Free(); }

  // Add by lark.li 20081119 begin
  bool BeginRun();
  bool EndRun();
  // End

  char m_password[ROLE_MAXSIZE_PASSWORD2 + 1];

  Botan::RSA_PrivateKey* m_clientPrivateKey;
  Botan::Public_Key*	 m_clientPublicKey{};
  char					 m_nonce[12];
  AES_KEY				 m_AESKey;
  AES_IV				 m_IV;

  uLong volatile m_actid;
  uLong volatile m_loginID;
  uLong volatile m_dbid;	// ��ǰ��ɫ�����ݿ�ID
  uLong volatile m_worldid; // ��ǰ��ɫ���ڴ�ΨһID
  uLong volatile m_pingtime;
  InterLockedLongLong gm_addr;			// GameServer �� Player �����ָ��
  InterLockedLongLong gp_addr;			// GroupServer �� Player �����ָ��
  DataSocket* volatile m_datasock;	// �� Player �� GateServer <-> Client ����
  GameServer* volatile game;		// �� Player ��ǰ���ڵ� GameServer ��������
  volatile bool enc;				// �Ƿ����ͨ������

  // �Ƿ����
  uLong volatile m_lestoptick;
  bool volatile m_estop;
  short volatile m_sGarnerWiner;

  struct
  {
	Mutex		  m_mtxstat; //0:����m_status;
	volatile char m_status;	 //0:��Ч;1.ѡ��ɫ�ڼ�;2.����Ϸ��.
	volatile uLong m_cmdNum;   // ��¼һ����������ĸ�������������״��
	volatile uLong m_lashTick; // ��һ�μ�¼ʱ��

	volatile uLong m_waringNum; // ��¼һ����������ĸ�������������״��
  };

  private:
  Player(uLong Size) :
	  PreAllocStru(Size),
	  m_datasock(NULL), game(NULL), gm_addr(0), gp_addr(0), m_dbid(0), m_worldid(0), m_status(0), m_sGarnerWiner(0)
  {
	m_mtxstat.Create(false);
  }
  ~Player()
  {
	if(m_datasock != NULL)
	{
	  m_datasock->SetPointer(NULL);
	  m_datasock = NULL;
	}
  }
  Player(Player const&) :
	  PreAllocStru(1) {}
  Player& operator=(Player const&) {}
  void	  Initially();
  void	  Finally();
};
class TransmitCall : public PreAllocTask
{
  public:
  TransmitCall(uLong size) :
	  PreAllocTask(size){};
  void Init(DataSocket* datasock, RPacket& recvbuf)
  {
	m_datasock = datasock;
	m_recvbuf  = recvbuf;
  }
  long Process();
  Task* Lastly()
  {
	m_recvbuf = 0;
	return PreAllocTask::Lastly();
  }

  DataSocket* m_datasock;
  RPacket	  m_recvbuf;
};
class GateServer
{
  public:
  GateServer(char const* fname);
  ~GateServer();

  void RunLoop(); // ��ѭ��

  ThreadPool *m_clproc, *m_clcomm, *m_gpcomm, *m_gpproc, *m_gmcomm;

  //ThreadPool* m_mmsproc, * m_mmscomm;	//ͬMMS�������
  //ToMMS* m_ToMMS;	//ͬMMS�����Ӷ��������������ƣ�

  ToGroupServer* gp_conn;  // ͬGroupServer�����Ӷ��������������ƣ�
  ToGameServer*	 gm_conn;  // ͬGameServer�����Ӷ��󣨱�����
  ToClient*		 cli_conn; // ͬClient�����Ӷ��󣨱�����
  Mutex			 _mtxother;

  PreAllocHeap<Player> player_heap; // ��Ҷ����

  // Add by lark.li 20081119 begin
  RunBiDirectChain<Player> m_plylst; // �������
  // End

  PreAllocHeap<TransmitCall> m_tch;
};
extern GateServer* g_gtsvr;
extern bool volatile g_appexit;

class GateServerApp : public NTService
{
  public:
  GateServerApp();

  void			 ServiceStart();
  void			 ServiceStop();
  virtual cChar* SetSvcName() const { return "GateServer"; }
  virtual cChar* SetDispName() const { return "[Kop Online]Gate Server"; } //��ʾ��ȱʡ���ڷ�����
  virtual bool	 CanPaused() const { return true; };					   //ȱʡ֧����ͣ�ͼ�������
};

extern LogStream g_gateerr;
extern LogStream g_gatelog;
extern LogStream g_chkattack;
extern LogStream g_gateconnect;
//extern LogStream g_gatepacket;
extern GateServerApp* g_app;

#endif // _GATESERVER_H_
