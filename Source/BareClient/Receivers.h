#pragma once

class CNetIF;
class CGroundObject;
enum CChannelChatMgr::eChannel;

class CReceiver
{
	friend CNetIF;
public:
	CReceiver(CNetIF *pNet,CPlayer *player);
	~CReceiver(void);

private:
	void OnMessageHandle(dbc::RPacket& recvbuf);

	void ResetAllView();														//initialize all information after entering the map
	void RefreshAllView();														//refresh all information after entering the map
	void RefreshMapPosition();													//character coordinate update
	void RefreshRoleAttribute();												//character attribute update
	void RefreshRolePacket();													//character package update
	void RefreshRoleList(CRoleObject* pRoleObject,bool bAppear);				//character attribute update 
	void RefreshRolePosition(CRoleObject* pRoleObject);							//character position update
	void RefreshGroundItemList(CGroundObject* pGroundItem,bool bAppear);		//ground item update
	void RefreshChat(CChannelChatMgr::eChannel channel);						//chat content update

	void OnCreateSecondaryPassword(dbc::RPacket& pk);
	void OnCreateCharacter(dbc::RPacket& pk);
	void OnDeleteCharacter(dbc::RPacket& pk);
	void OnLogin(dbc::RPacket& pk);
	void OnError(dbc::RPacket& pk);
	void OnEnterMap(dbc::RPacket& pk);
	void OnAction(dbc::RPacket& pk);
	void SomethingAppear(dbc::RPacket& pk);
	void SomethingDisappear(dbc::RPacket& pk);
	void ItemAppear(dbc::RPacket& pk);
	void ItemDisappear(dbc::RPacket& pk);
	void SynAttribute(dbc::RPacket& pk);

	void Chat_PrivateChannel(dbc::RPacket& pk);
	void Chat_WorldChannel(dbc::RPacket& pk);
	void Chat_TradeChannel(dbc::RPacket& pk);
	void Chat_TeamChannel(dbc::RPacket& pk);
	void Chat_PublishChannel(dbc::RPacket& pk);
	void Chat_SightChannel(dbc::RPacket& pk);
	void Chat_GuildChannel(dbc::RPacket& pk);
	void Chat_SystemChannel(dbc::RPacket& pk);

	void OnGetCharacterInfo(dbc::RPacket& pk);

	void SC_RSAHandshake1(dbc::RPacket& pk);
	void SC_RSAHandshake2(dbc::RPacket& pk);


private:
	CNetIF *m_pNet;
	CPlayer *m_pPlayer;

};
