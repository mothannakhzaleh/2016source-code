#include "StdAfx.h"
#include "threadpool.h"
#include "GameThread.h"
#include ".\netmodule.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

uLong NetBuffer[]={100,10,0};
bool g_logautobak=false;

CNetModule::CNetModule(ThreadPool* pool) : TcpClientApp(this,0,pool), RPCMGR(this)
{
	TcpClientApp::WSAStartup();
	TcpClientApp::SetPKParse(0,2,64*1024,100);
	TcpClientApp::BeginWork(60000);
	m_pThreadPool=pool;
}

CNetModule::~CNetModule(void)
{
	TcpClientApp::ShutDown(12000);
	m_pThreadPool->DestroyPool();
	TcpClientApp::WSACleanup();
}

DataSocket* CNetModule::Connect(CString hostname,WORD port)
{
	return TcpClientApp::Connect(hostname,port);
}

void CNetModule::Disconnect(CNetIF *pNet)
{
	TcpClientApp::Disconnect(pNet->m_DataSock,0,0);
}

void CNetModule::SendPacketMessage(CNetIF *pNet,WPacket& pk)
{
	TcpClientApp::SendData(pNet->m_DataSock,pk);
}

bool CNetModule::OnConnect(DataSocket *datasock)
{
	datasock->SetRecvBuf(64*1024);
	datasock->SetSendBuf(64*1024);
	return true;
}

void CNetModule::OnDisconnect(DataSocket *datasock,int reason)
{
	((CNetIF*)datasock->GetPointer())->OnDisconnect(reason);
}

void CNetModule::OnEncrypt(dbc::DataSocket *datasock,char *ciphertext,const char *text,unsigned long &len)
{
	TcpCommApp::OnEncrypt(datasock,ciphertext,text,len);
	((CNetIF*)datasock->GetPointer())->OnEncrypt(ciphertext,len);
}

void CNetModule::OnDecrypt(dbc::DataSocket *datasock,char *ciphertext,unsigned long &len)
{
	TcpCommApp::OnDecrypt(datasock, ciphertext, len);
	CNetIF *pNet=((CNetIF*)datasock->GetPointer());		//Receive data for the first time after connection, pNet may be empty
	if (pNet)
	{
		pNet->OnDecrypt(ciphertext,len);
	}
}

void CNetModule::OnProcessData(dbc::DataSocket *datasock,dbc::RPacket& recvbuf)
{
	CNetIF *pNet=((CNetIF*)datasock->GetPointer());		//Receive data for the first time after connection, pNet may be empty
	if (pNet)
	{
		pNet->m_pPlayer->GetPlayerGameThread()->AddPK(datasock,recvbuf);
	}
}
