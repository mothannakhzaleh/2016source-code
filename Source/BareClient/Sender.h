#pragma once


class CNetIF;
class CLoginData;


class CSender
{
public:
	CSender(CNetIF *pNet,CPlayer *player);
	~CSender(void);

	//登陆帐号服务器
	void LoginAccountService(CLoginData *pdata);
	//登陆游戏服务器
	void LoginGameService();
	//创建角色
	void CreateCharacter();
	//删除角色
	void DeleteCharacter(CString strName);
	//结束动作
	void EndAction();
	//角色移动
	void MoveTo(DWORD x,DWORD y);
	//增加属性点
	void AddAttribute(WORD attrID);
	//角色瞬移
	void TeleCommand(CString strCommand);
	//拾取道具
	void PickupItem(DWORD worldID,DWORD handle);
	//丢弃道具
	void DropItem(int nIndex,WORD nNum);
	//使用(装备)物品
	void UseItem(int nIndex);
	//卸下装备
	void UnEquip(int nIndex);

	//聊天操作 - 视野频道
	void Chat_Channel_Sight(CString strText);
	//聊天操作 - 世界频道
	void Chat_Channel_World(CString strText);
	//聊天操作 - 交易频道
	void Chat_Channel_Trade(CString strText);
	//聊天操作 - 队伍频道
	void Chat_Channel_Team(CString strText);
	//聊天操作 - 公会频道
	//void Chat_Channel_Guild(CString strText);
	//聊天操作 - 公告频道
	void Chat_Channel_Publish(CString strText);
	//聊天操作 - 私聊频道
	void Chat_Channel_Private(CString strTargetName,CString strText);


	void SendClientRSAPrivateKey();
	void CreateSecondaryPassword();

private:
	CNetIF *m_pNet;
	CPlayer *m_pPlayer;
	DWORD m_dwMoveCount;
};
