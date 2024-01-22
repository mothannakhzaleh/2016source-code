#pragma once

#include "CommRPC.h"
#include "GameCommon.h"
#include "Sender.h"
#include "Receivers.h"
#include <PacketEncryption.h>


class CNetIF
{
	friend CNetModule;
	friend CSender;
    friend CReceiver;
public:
	CNetIF(CPlayer *player);
	~CNetIF(void);

public:
	bool Connect(CString hostname,WORD port);
	bool Disconnect();
	void SetFreeSocket();

	CSender& GetSender();
	void ReceiveData(dbc::RPacket& recvbuf);

private:
	bool SendPacketMessage(dbc::WPacket& pk);

	//Reason value: 0-the local program exits normally, -1-Socket error, -3-the network is closed by the other party, -5-the packet length exceeds the limit.
	void OnDisconnect(int reason);
	//receive data, dispatch
	void OnProcessData(dbc::RPacket& recvbuf);
	//Encrypt data before sending
	void OnEncrypt(char *codeText,DWORD len);
	//Decrypt data before receiving it
	void OnDecrypt(char *codeText,DWORD len);

private:
	CSender m_Sender;
	CReceiver m_Receiver;
	dbc::DataSocket *volatile m_DataSock;
	CPlayer *m_pPlayer;

	Botan::RSA_PrivateKey* m_clientPrivateKey;
	Botan::RSA_PrivateKey* m_serverPrivateKey;
	Botan::Public_Key*	   m_srvPublicKey;
	dbc::AES_KEY		   m_AESKey;
	dbc::AES_IV			   m_IV;


};
