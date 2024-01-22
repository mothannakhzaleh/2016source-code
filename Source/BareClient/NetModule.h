#pragma once

#include "CommRPC.h"
#include "GameCommon.h"
#include "Sender.h"
#include "Receivers.h"
#include "NetIF.h"
#include "afxmt.h"


_DBC_USING

class CNetModule : public TcpClientApp, public RPCMGR
{
public:
	CNetModule(ThreadPool* pool);
	virtual ~CNetModule(void);

	DataSocket* Connect(CString hostname,WORD port);
	void Disconnect(CNetIF *pNet);

	void SendPacketMessage(CNetIF *pNet,WPacket& pk);


private:
	//Only for internal calls, pay attention to whether the synchronization lock is locked repeatedly
	//CNetIF* GetMember(DataSocket *pSock);
	//Return value: true-allow connection, false-not allow connection
	virtual bool OnConnect(DataSocket *datasock);
	//Reason value: 0-the local program exits normally, -1-Socket error, -3-the network is closed by the other party, -5-the packet length exceeds the limit.
	virtual void OnDisconnect(DataSocket *datasock,int reason);
	//receive data, dispatch
	virtual void OnProcessData(dbc::DataSocket *datasock,dbc::RPacket& recvbuf);
	//Encrypt data before sending
	virtual void OnEncrypt(dbc::DataSocket *datasock,char *ciphertext,const char *text,unsigned long &len);
	//Decrypt data before receiving it
	virtual void OnDecrypt(dbc::DataSocket *datasock,char *ciphertext,unsigned long &len);


private:
	ThreadPool* m_pThreadPool;
};
