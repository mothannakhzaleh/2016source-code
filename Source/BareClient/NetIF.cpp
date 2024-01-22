#include "StdAfx.h"
#include "NetModule.h"
#include "GameThread.h"
#include ".\netif.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif


CNetIF::CNetIF(CPlayer *player) : m_Sender(this,player),m_Receiver(this,player)
{
	m_DataSock=NULL;
	m_pPlayer=player;

	Botan::AutoSeeded_RNG rng;
	m_clientPrivateKey = nullptr;
	m_clientPrivateKey = new Botan::RSA_PrivateKey(rng, 3072);
	memset(m_AESKey, 0, sizeof(m_AESKey));
	memset(m_IV, 0, sizeof(m_IV));
}

CNetIF::~CNetIF(void)
{
	if(m_clientPrivateKey)
	{
	  delete m_clientPrivateKey;
	  m_clientPrivateKey = nullptr;
	}
}

void CNetIF::SetFreeSocket()
{
	m_DataSock=NULL;
}

bool CNetIF::Connect(CString hostname,WORD port)
{
	if (m_DataSock)
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"Waiting for Socket resources required for connection to be released...");
		m_pPlayer->GetPlayerMessages().AddMsg("Waiting for Socket resources required for connection to be released...");
		g_pNet->Disconnect(this);
		return false;
	}
	//CSystemInfo::Add(m_pPlayer->GetIndex(),"Connecting to group server...");
	m_pPlayer->GetPlayerMessages().AddMsg("Connecting to group server...");
	m_pPlayer->SetLoginState(CPlayer::eLOGIN_GROUP);
	m_DataSock=g_pNet->Connect(hostname,port);
	if (m_DataSock)
	{
		m_DataSock->SetPointer(this);
		return true;
	}
	//CSystemInfo::Add(m_pPlayer->GetIndex(),"Connection to group server failed!");
	m_pPlayer->GetPlayerMessages().AddMsg("Connection to group server failed!");
	m_pPlayer->SetLoginState(CPlayer::eERROR_GROUP);
	return false;
}

//Return: true means the connection has been disconnected, and set the disconnected state
//Return: false means the connection is being disconnected, and set the status of disconnecting
bool CNetIF::Disconnect()
{
	if (m_DataSock)
	{
		m_pPlayer->SetLoginState(CPlayer::eDISCONNECTING);
		g_pNet->Disconnect(this);
		return false;
	}
	else
	{
		m_pPlayer->SetLoginState(CPlayer::eDISCONNECTED);
		return true;
	}
}

//call back
void CNetIF::OnDisconnect(int reason)
{
	while (!PostThreadMessage(m_pPlayer->GetPlayerGameThread()->GetThreadID(),NETIF_DISCONNECT,reason,NULL))
	{
		Sleep(50);
	}
}

CSender& CNetIF::GetSender()
{
	return m_Sender;
}

bool CNetIF::SendPacketMessage(dbc::WPacket& pk)
{
	if (!m_DataSock)
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"Failed to send data: the connection has been disconnected!");
		m_pPlayer->GetPlayerMessages().AddMsg("Failed to send data: the connection has been disconnected!");
		return false;
	}
	//CSystemInfo::AddDetailDebugInfo(m_pPlayer->GetIndex(),"Ready to send data...£¨m_DataSock=0x%X£©",m_DataSock);
	g_pNet->SendPacketMessage(this,pk);
	//CSystemInfo::AddDetailDebugInfo(m_pPlayer->GetIndex(),"Data has been sent...£¨m_DataSock=0x%X£©",m_DataSock);
	return true;
}

//call back
void CNetIF::OnEncrypt(char *codeText,DWORD len)
{
}

//call back
void CNetIF::OnDecrypt(char *codeText,DWORD len)
{
}

void CNetIF::ReceiveData(dbc::RPacket& recvbuf)
{
	m_Receiver.OnMessageHandle(recvbuf);
}

