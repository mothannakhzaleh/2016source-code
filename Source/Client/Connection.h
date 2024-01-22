#ifndef CONNECTION_H
#define CONNECTION_H

#include "ThreadPool.h"
#include "DataSocket.h"

class NetIF;
#pragma pack(push)
#pragma pack(4)
class Connection : public dbc::Task
{
  public:
  enum
  {
	CNST_INVALID	= 0,
	CNST_CONNECTING = 1,
	CNST_FAILURE	= 2,
	CNST_CONNECTED	= 3,
	CNST_HANDSHAKE = 4,
	CNST_TIMEOUT	= 5
  };
  Connection(NetIF* netif) :
	  m_netif(netif), m_status(CNST_INVALID), m_datasock(0) {}
  void Clear()
  {
	m_status   = CNST_INVALID;
	m_datasock = 0;
  }
  bool		   Connect(dbc::cChar* hostname, dbc::uShort port, dbc::uLong timeout = 0); //∫¡√Î
  void		   Disconnect(int reason);
  void		   OnDisconnect();
  bool		   IsConnected() { return m_status == CNST_CONNECTED || m_status == CNST_HANDSHAKE; }
  int		   GetConnStat();
  void		   CHAPSTR();
  void		   HandshakeDone();
  const char*  GetHostName() { return m_hostname; }
  const SOCKET GetSocket() { return m_sock; }

  dbc::DataSocket* GetDatasock() { return m_datasock; }

  long	Process();
  Task* Lastly() { return 0; }

  private:
  dbc::Mutex		   m_mtx;
  NetIF* const		   m_netif;
  dbc::InterLockedLong m_status;
  dbc::DataSocket* volatile m_datasock;

  dbc::uLong  m_timeout;
  dbc::uLong  m_tick;
  SOCKET	  m_sock;
  char		  m_hostname[129];
  dbc::uShort m_port;
};
#pragma pack(pop)

#endif //CONNECTION_H
