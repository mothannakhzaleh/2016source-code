#include "Stdafx.h"
#include "GameApp.h"
#include "GameAppNet.h"
#include "SubMap.h"
#include "MapEntry.h"
#include "CharTrade.h"
#include "GameDB.h"
#include "Guild.h"
extern std::string g_strLogName;

//	2008-8-20	yangyinyu	add	begin!

//	进出地图(上下线)。
void	lgtool_printCharacter(	const	char*	sType,	CCharacter *pCCha	)
{
	//
	static	char	sText[2048];
	static	char	sTextEx[2048];

	//_snprintf(	sText,	2048,	"%s%s;%d;%d;%d;%d;%d;%d;%d;%d;",
	//	sType,							//	标题。
	//	pCCha->GetName(),				//	人物名字。
	//	pCCha->GetID(),					//	人物ID。
	//	pCCha->GetLevel(),				//	人物等级。
	//	pCCha->getAttr(	ATTR_STR	),	//	人物的力量属性。
	//	pCCha->getAttr(	ATTR_DEX	),	//	人物的敏捷属性。
	//	pCCha->getAttr(	ATTR_AGI	),	//	
	//	pCCha->getAttr(	ATTR_CON	),	//	
	//	pCCha->getAttr(	ATTR_STA	),	//	
	//	pCCha->getAttr( ATTR_AP	)		//	显示剩余属性点。
	//	);
	_snprintf_s(	sText,sizeof(sText),_TRUNCATE,	"%s%s;%d;%d;%d;%d;%d;%d;%d;%d;",
		sType,							//	标题。
		pCCha->GetName(),				//	人物名字。
		pCCha->GetID(),					//	人物ID。
		pCCha->GetLevel(),				//	人物等级。
		(long)pCCha->getAttr(	ATTR_STR	),	//	人物的力量属性。
		(long)pCCha->getAttr(	ATTR_DEX	),	//	人物的敏捷属性。
		(long)pCCha->getAttr(	ATTR_AGI	),	//	
		(long)pCCha->getAttr(	ATTR_CON	),	//	
		(long)pCCha->getAttr(	ATTR_STA	),	//	
		(long)pCCha->getAttr( ATTR_AP	)		//	显示剩余属性点。
		);

	//	打印背包道具。
	USHORT sNum =	pCCha->GetKitbag()->GetUseGridNum();

	for(	int	i	=	0;	i	<	sNum;	i	++	)
	{
		SItemGrid*	pGrid	=	pCCha->GetKitbag()->GetGridContByNum(	i	);
		if(	pGrid	)
		{
			CItemRecord*	pItem	=	GetItemRecordInfo(	pGrid->sID );
			if(	pItem	)
			{
				//_snprintf(	sTextEx,	2048,	"%s(%d),",	pItem->szName,	pGrid->sNum	);
				_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%s(%d),",	pItem->szName,	pGrid->sNum	);
				//strncat(	sText,	sTextEx,	2048	);
				strncat_s( sText,sizeof(sText), sTextEx,_TRUNCATE);
			};
		};
	};
	//strncat(	sText,	";",	2048	);
	strncat_s( sText,sizeof(sText), ";",_TRUNCATE);

	//	打印银行道具。
	if(	pCCha->GetPlayer()	)
	{
		CKitbag*	bank	=	pCCha->GetPlayer()->GetBank();

		if(	bank	)
		{
			for(	int	i	=	0;	i	<	bank->GetUseGridNum();	i	++	)
			{
				SItemGrid*	pGrid	=	bank->GetGridContByNum(	i	);
				if(	pGrid	)
				{
					CItemRecord*	pItem	=	GetItemRecordInfo(	pGrid->sID );
					if(	pItem	)
					{
						if(	pGrid->dwDBID )
							//_snprintf(	sTextEx,	2048,	"%s-%d-%d,",	pItem->szName,	pGrid->sNum,	pGrid->dwDBID	);
							_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,"%s-%d-%d,",	pItem->szName,	pGrid->sNum,	(long)pGrid->dwDBID	);
						else
							//_snprintf(	sTextEx,	2048,	"%s-%d,",	pItem->szName,	pGrid->sNum	);
							_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%s-%d,",	pItem->szName,	pGrid->sNum	);
						//strncat(	sText,	sTextEx,	2048	);
						strncat_s( sText,sizeof(sText), sTextEx,_TRUNCATE);
					};
				};
			};
		};
	};

	//	结束时打印换行。
	//strncat(	sText,	"\n",	2048	);
	strncat_s( sText,sizeof(sText), "\n",_TRUNCATE);

	//
	LG(	"query_cha",	sText	);
};

//	打印船只的道具( 进出海，建造，销毁 )。
void	lgtool_printBoat(	const	char*	sType,	CCharacter*	pCCha	)
{
	//	取该人物当前的船只。
	CCharacter*	pBoat	=	pCCha->GetBoat();

	if(	!pBoat	)
	{
		return;
	};

	//	打印基本信息。
	static	char	sText[2048];
	static	char	sTextEx[2048];

	//_snprintf(	sText,	2048,	"%s%s;%s;%d;",
	//	sType,				//	标题。
	//	pCCha->GetName(),	//	人物名字。
	//	pBoat->GetName(),	//	船名字。
	//	pBoat->GetLevel()	//	船等级。
	//	);
	_snprintf_s(	sText,sizeof(sText),_TRUNCATE,	"%s%s;%s;%d;",
		sType,				//	标题。
		pCCha->GetName(),	//	人物名字。
		pBoat->GetName(),	//	船名字。
		pBoat->GetLevel()	//	船等级。
		);

	//	打印所有道具。
	USHORT sNum =	pBoat->GetKitbag()->GetUseGridNum();

	for(	int	i	=	0;	i	<	sNum;	i	++	)
	{
		SItemGrid*	pGrid	=	pBoat->GetKitbag()->GetGridContByNum(	i	);
		if(	pGrid	)
		{
			CItemRecord*	pItem	=	GetItemRecordInfo(	pGrid->sID );
			if(	pItem	)
			{
				//_snprintf(	sTextEx,	2048,	"%s(%d),",	
				//	pItem->szName,		//	道具名字。
				//	pGrid->sNum			//	道具数量。
				//	);
				_snprintf_s(	sTextEx,sizeof(sTextEx),_TRUNCATE,	"%s(%d),",	
					pItem->szName,		//	道具名字。
					pGrid->sNum			//	道具数量。
					);

				//strncat(	sText,	sTextEx,	2048	);
				strncat_s( sText,sizeof(sText), sTextEx,_TRUNCATE);
			};
		};
	};

	//strncat(	sText,	"\n",	2048	);
	strncat_s( sText,sizeof(sText), "\n",_TRUNCATE);

	//	写LOG。
	LG(	"query_boat",	sText	);

};
//	2008-8-20	yangyinyu	add	end!


// 计时退出切换
//#define CHAEXIT_ONTIME

//  获取网络消息的唯一入口
void CGameApp::ProcessNetMsg(int nMsgType, GateServer* pGate, RPACKET pkt)
{T_B
    switch (nMsgType)
    {
    case NETMSG_GATE_CONNECTED: // 连接上Gate
        {
	    LG("Connect", "Exec OnGateConnected()\n");
        OnGateConnected(pGate, pkt);
        break;}

    case NETMSG_GATE_DISCONNECT: // 与Gate断开连接
        {
			LG("Connect", "Exec OnGateDisconnect()\n");
        OnGateDisconnect(pGate, pkt);
        break;}

    case NETMSG_PACKET: // 收到消息包
        {
        ProcessPacket(pGate, pkt);
        break;}

    }
T_E}

void CGameApp::ProcessInfoMsg(pNetMessage msg, short sType, TradeServer *pInfo)
{T_B
    switch(sType)
    {
    case TradeServer::CMD_FM_CONNECTED:
        OnInfoConnected(pInfo);
        break;

    case TradeServer::CMD_FM_DISCONNECTED:
        OnInfoDisconnected(pInfo);
        break;

    case TradeServer::CMD_FM_MSG:
        ProcessMsg(msg, pInfo);
        break;

    default:
        break;
    }
T_E}

void CGameApp::OnInfoConnected(TradeServer *pInfo)
{T_B
	//登录TradeServer
	pInfo->Login();
T_E}

void CGameApp::OnInfoDisconnected(TradeServer *pInfo)
{T_B
	// 商城系统关闭
	g_StoreSystem.InValid();
	pInfo->InValid();
T_E}

void CGameApp::ProcessMsg(pNetMessage msg, TradeServer *pInfo)
{T_B
	if(msg)
	{
		switch(msg->msgHead.msgID)
		{
		case INFO_LOGIN:		// 登录TradeServer
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					LG("Store_data", "TradeServer Login Success!\n");

					pInfo->SetValid();
					//g_StoreSystem.SetValid();

					//向TradeServer索取商城列表和公告列表
					g_StoreSystem.GetItemList();
					g_StoreSystem.GetAfficheList();
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					LG("Store_data", "TradeServer Login Failed!\n");
					pInfo->InValid();
				}
				else
				{
					//LG("Store_data", "登录TradeServer报文数据错误!\n");
					LG("Store_data", "enter TradeServer message data error!\n");
				}
			}
			break;

		case INFO_REQUEST_ACCOUNT:	// 获取帐户信息
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]获取帐户信息成功!\n", lOrderID);
					LG("Store_data", "[%I64i]succeed to obtain account information!\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptRoleInfo(lOrderID, ChaInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]获取帐户信息失败!\n", lOrderID);
					LG("Store_data", "[%I64i]obtain account information failed!\n", lOrderID);

					g_StoreSystem.CancelRoleInfo(lOrderID);
				}
				else
				{
					//LG("Store_data", "帐户信息报文数据错误!\n");
					LG("Store_data", "account information message data error");
				}
			}
			break;

		case INFO_REQUEST_STORE:	// 获取商城信息
			{
				//LG("Store_data", "取得商城列表!\n");
				LG("Store_data", "get store list!\n");
				if(msg->msgHead.subID == INFO_SUCCESS)		// 商城信息反馈
				{
					//商品个数
					short lComNum = LOWORD(msg->msgHead.msgExtend);
					//分类个数
					short lClassNum = HIWORD(msg->msgHead.msgExtend);
					//设置分类列表
					g_StoreSystem.SetItemClass((ClassInfo *)(msg->msgBody), lClassNum);
					//设置商品列表
					g_StoreSystem.SetItemList((StoreStruct *)((char *)msg->msgBody + lClassNum * sizeof(ClassInfo)), lComNum);

					g_StoreSystem.SetValid();
				}
				else if(msg->msgHead.subID == INFO_FAILED) // 商城信息更新
				{
					//商品个数
					short lComNum = LOWORD(msg->msgHead.msgExtend);
					//分类个数
					short lClassNum = HIWORD(msg->msgHead.msgExtend);
					//设置分类列表
					g_StoreSystem.SetItemClass((ClassInfo *)(msg->msgBody), lClassNum);
					//设置商品列表
					g_StoreSystem.SetItemList((StoreStruct *)((char *)msg->msgBody + lClassNum * sizeof(ClassInfo)), lComNum);
				}
				else
				{
					//LG("Store_data", "商城列表报文数据错误!\n");
					LG("Store_data", "store list message data error!\n");
				}
			}
			break;

		case INFO_REQUEST_AFFICHE:		// 获取公告信息
			{
				//LG("Store_data", "取得公告信息!\n");
				LG("Store_data", "get offiche information!\n");
				if(msg->msgHead.subID == INFO_SUCCESS) // 公告信息反馈
				{
					//公告个数
					long lAfficheNum = msg->msgHead.msgExtend;
					//设置公告列表
					g_StoreSystem.SetAfficheList((AfficheInfo *)msg->msgBody, lAfficheNum);
				}
				else if(msg->msgHead.subID == INFO_FAILED) // 公告信息更新
				{
					//公告个数
					long lAfficheNum = msg->msgHead.msgExtend;
					//设置公告列表
					g_StoreSystem.SetAfficheList((AfficheInfo *)msg->msgBody, lAfficheNum);
				}
				else
				{
					//LG("Store_data", "公告信息报文数据错误!\n");
					LG("Store_data", "offiche information message data error!\n");
				}
			}
			break;

			// Add by lark.li 20090218 begin
		case INFO_STORE_BUY_RETURN:
			{
				if(msg->msgHead.subID == INFO_SUCCESS) // 购买成功
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]购买道具退款成功!\n", lOrderID);
					LG("Store_data", "[%I64i]succeed to buy return item!\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptReturn(lOrderID, ChaInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED) // 购买失败
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]购买道具退款失败!\n", lOrderID);
					LG("Store_data", "[%I64i]buy item return failed!\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptReturn(lOrderID, ChaInfo);
				}
				else
				{
					//LG("Store_data", "道具购买退款确认信息报文数据错误!\n");
					LG("Store_data", "confirm information that buy item return message data error!\n");
				}
			}
			break;
			// End

		case INFO_STORE_BUY:		// 购买道具
			{
				if(msg->msgHead.subID == INFO_SUCCESS) // 购买成功
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]购买道具成功!\n", lOrderID);
					LG("Store_data", "[%I64i]succeed to buy item!\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.Accept(lOrderID, ChaInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED) // 购买失败
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]购买道具失败!\n", lOrderID);
					LG("Store_data", "[%I64i]buy item failed!\n", lOrderID);

					g_StoreSystem.Cancel(lOrderID);
				}
				else
				{
					//LG("Store_data", "道具购买确认信息报文数据错误!\n");
					LG("Store_data", "confirm information that buy item message data error!\n");
				}
			}
			break;

		case INFO_REGISTER_VIP:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]购买VIP成功!\n", lOrderID);
					LG("Store_data", "[%I64i] buy VIP succeed !\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));

					g_StoreSystem.AcceptVIP(lOrderID, ChaInfo, msg->msgHead.msgExtend);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]购买VIP失败!\n", lOrderID);
					LG("Store_data", "[%I64i] buy VIP failed !\n", lOrderID);

					g_StoreSystem.CancelVIP(lOrderID);
				}
				else
				{
					//LG("Store_data", "购买VIP确认信息报文数据错误!\n");
					LG("Store_data", "buy VIP confirm information message data error !\n");
				}
			}
			break;

		case INFO_EXCHANGE_MONEY:		// 兑换代币
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]兑换代币成功!\n", lOrderID);
					LG("Store_data", "[%I64i]change token succeed !\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptChange(lOrderID, ChaInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]兑换代币失败!\n", lOrderID);
					LG("Store_data", "[%I64i]change token failed!\n", lOrderID);

					g_StoreSystem.CancelChange(lOrderID);
				}
				else
				{
					//LG("Store_data", "兑换代币确认信息报文数据错误!\n");
					LG("Store_data", "change token confirm information message data error !\n");
				}
			}
			break;

		case INFO_REQUEST_HISTORY:		// 查询交易记录
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]查询交易记录成功!\n", lOrderID);
					LG("Store_data", "[%I64i]succeed to query trade note!\n", lOrderID);

					HistoryInfo *pRecord = (HistoryInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptRecord(lOrderID, pRecord);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]查询交易记录失败!\n", lOrderID);
					LG("Store_data", "[%I64i]query trade note failed!\n", lOrderID);

					g_StoreSystem.CancelRecord(lOrderID);
				}
				else
				{
					//LG("Store_data", "交易记录查询应答信息报文数据错误!\n");
					LG("Store_data", "trade note query resoibsuib nessage data error!\n");
				}
			}
			break;

		case INFO_SND_GM_MAIL:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]发送GM邮件成功!\n", lOrderID);
					LG("Store_data", "[%I64i]send GM mail success!\n", lOrderID);

					long lMailID = msg->msgHead.msgExtend;
					g_StoreSystem.AcceptGMSend(lOrderID, lMailID);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]发送GM邮件失败!\n", lOrderID);
					LG("Store_data", "[%I64i]send GM mail failed!\n", lOrderID);

					g_StoreSystem.CancelGMSend(lOrderID);
				}
				else
				{
					//LG("Store_data", "发送GM邮件报文数据错误!\n");
					LG("Store_data", "send GM mail message data error!\n");
				}
			}
			break;

		case INFO_RCV_GM_MAIL:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]接收GM邮件成功!\n", lOrderID);
					LG("Store_data", "[%I64i]receive GM mail success!\n", lOrderID);

					MailInfo *pMi = (MailInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptGMRecv(lOrderID, pMi);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					//LG("Store_data", "[%I64i]接收GM邮件失败!\n", lOrderID);
					LG("Store_data", "[%I64i]reciveGMmail failed!\n", lOrderID);

					g_StoreSystem.CancelGMRecv(lOrderID);
				}
				else
				{
					//LG("Store_data", "接收GM邮件报文数据错误!\n");
					LG("Store_data", "receive GM mail message data error!\n");
				}
			}
			break;

		case INFO_EXCEPTION_SERVICE:	//拒绝服务
			{
				//LG("Store_data", "TradeServer拒绝服务!\n");
				LG("Store_data", "TradeServer refuse serve!\n");
				g_StoreSystem.InValid();
				pInfo->InValid();
			}
			break;
//以下2016注释 水晶功能完善不能启用
#ifdef SHUI_JING
		case INFO_REQUEST_ACTINFO:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]succeed to obtain account information!\n", lOrderID);

					RoleInfo *ChaInfo = (RoleInfo *)((char *)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptActInfo(lOrderID, ChaInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]obtain account information failed!\n", lOrderID);

					g_StoreSystem.CancelActInfo(lOrderID);
				}
				else
				{
					LG("Store_data", "account information message data error");
				}
			}
			break;
		case INFO_CRYSTAL_OP_ADD:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]succeed to obtain account information!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptCrystalAdd(lOrderID,cryInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]obtain account information failed!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.CancelCrystalAdd(lOrderID,cryInfo);
				}
				else
				{
					LG("Store_data", "AddCrystal information message data error");
				}			
			}
			break;
		case INFO_CRYSTAL_OP_DEL:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]succeed to obtain account information!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptCrystalDel(lOrderID,cryInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]obtain account information failed!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.CancelCrystalDel(lOrderID,cryInfo);
				}
				else
				{
					LG("Store_data", "DelCrystal information message data error");
				}			
			}
			break;

		case INFO_CRYSTAL_OP_ADD_RETURN:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]succeed to obtain account information!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptCrystalAddReturn(lOrderID,cryInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]obtain account information failed!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.CancelCrystalAddReturn(lOrderID,cryInfo);
				}
				else
				{
					LG("Store_data", "Addcrystal return  information message data error");
				}			
			}
			break;
		case INFO_CRYSTAL_OP_DEL_RETURN:
			{
				if(msg->msgHead.subID == INFO_SUCCESS)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]succeed to obtain account information!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.AcceptCrystalDelReturn(lOrderID,cryInfo);
				}
				else if(msg->msgHead.subID == INFO_FAILED)
				{
					long long lOrderID = *(long long *)msg->msgBody;
					LG("Store_data", "[%I64i]obtain account information failed!\n", lOrderID);
					CrystalInfo* cryInfo = (CrystalInfo*)((char*)msg->msgBody + sizeof(long long));
					g_StoreSystem.CancelCrystalDelReturn(lOrderID,cryInfo);
				}
				else
				{
					LG("Store_data", "Delcrystal return information message data error");
				}			
			}
			break;
#endif
		default:
			{
				//LG("Store_data", "取得的消息类型不明!\n");
				LG("Store_data", "get unknown information type!\n");
			}
			break;

		}

		FreeNetMessage(msg);
	}
T_E}

// 与Gate连接上的处理函数
void CGameApp::OnGateConnected(GateServer* pGate, RPACKET pkt)
{T_B
	// 在GateServer注册本GameServer
	WPACKET	wpk = GETWPACKET();
    WRITE_CMD(wpk, CMD_MT_LOGIN);
	WRITE_STRING(wpk, GETGMSVRNAME());
	WRITE_STRING(wpk, g_pGameApp->m_strMapNameList.c_str());

	LG("Connect", "[%s]\n", g_pGameApp->m_strMapNameList.c_str());

    pGate->SendData(wpk);
T_E}

// 与Gate断开连接的处理函数
void CGameApp::OnGateDisconnect(GateServer* pGate, RPACKET pkt)
{T_B
    bool ret = VALIDRPACKET(pkt);
    if (!ret) return; // 无效的packet

    GatePlayer* tmp = (GatePlayer *)MakePointer(READ_LONGLONG(pkt));    

    while (tmp != NULL)
    {
		if (((CPlayer *)tmp)->IsValid())
		{
			GoOutGame((CPlayer *)tmp, true);
			tmp->OnLogoff();
		}

		tmp = tmp->Next;
	}

	pGate->Invalid();
T_E}

// 处理网络消息包
void CGameApp::ProcessPacket(GateServer* pGate, RPACKET pkt)
{T_B
	CPlayer *l_player = 0;
    uShort cmd = READ_CMD(pkt);

	// 测试性能用代码，发布不要 
	MONITOR_VALUE(MESSAGE_NAME(cmd))

	//DWORD dwLastTick = GetTickCount();

	//GameServerLG(g_strLogName.c_str(), "CGameApp::ProcessPacket (cmd = %d) Begin...\n", cmd);
	
	//LG("Thread", "ProcessPacket %d\n", ::GetCurrentThreadId());

	switch (cmd)
	{
	case CMD_TM_LOGIN_ACK:
		{
			short	sErrCode;
			if (sErrCode = READ_SHORT(pkt))
			{
				/*LG("GameLogin", "登录 GateServer: %s:%d失败[%s], 注册地图[%s]\n",
					pGate->GetIP().c_str(), pGate->GetPort(), g_GameGateConnError(sErrCode),
                    g_pGameApp->m_strMapNameList.c_str());*/
				LG("GameLogin", "enter GateServer: %s:%d failed [%s], register map[%s]\n",
					pGate->GetIP().c_str(), pGate->GetPort(), g_GameGateConnError(sErrCode),
                    g_pGameApp->m_strMapNameList.c_str());
				DISCONNECT(pGate->GetDataSock());
			}
			else
			{
				pGate->GetName() = READ_STRING(pkt);
				if (!strcmp(pGate->GetName().c_str(), ""))
				{
					/*LG("GameLogin", "登录 GateServer: [%s:%d]成功 但没有拿到其名字，所以切断重新连接\n",
						pGate->GetName().c_str(), pGate->GetIP().c_str(), pGate->GetPort(),
						g_pGameApp->m_strMapNameList.c_str());*/
					LG("GameLogin", "entry GateServer: [%s:%d]success but do not get his name，so disconnection and entry again\n",
						pGate->GetName().c_str(), pGate->GetIP().c_str(), pGate->GetPort(),
						g_pGameApp->m_strMapNameList.c_str());

					DISCONNECT(pGate->GetDataSock());
				}
				else
				{
					/*LG("GameLogin", "登录 GateServer: %s [%s:%d]成功 [MapName:%s]\n",
						pGate->GetName().c_str(), pGate->GetIP().c_str(), pGate->GetPort(),
						g_pGameApp->m_strMapNameList.c_str());*/
					LG("GameLogin", "entry GateServer: %s [%s:%d]success [MapName:%s]\n",
						pGate->GetName().c_str(), pGate->GetIP().c_str(), pGate->GetPort(),
						g_pGameApp->m_strMapNameList.c_str());
				}
			}

			break;
		}
	case CMD_TM_ENTERMAP:
		{
			uLong   l_actid = READ_LONG(pkt);
			const char* pszPassword = READ_STRING(pkt);
			if(pszPassword == NULL)
				break;
			uLong	l_dbid = READ_LONG(pkt);
			uLong	l_worldid = READ_LONG(pkt);
			cChar *	l_map	= READ_STRING(pkt);
			if(l_map == NULL)
				break;
			Long	lMapCpyNO = READ_LONG(pkt);
			uLong	l_x		= READ_LONG(pkt);
			uLong	l_y		= READ_LONG(pkt);
			char	chLogin = READ_CHAR(pkt); // 角色上线(0)
			short	swiner  = READ_SHORT_R(pkt);
			//uLong	l_gtaddr = READ_LONG_R(pkt);
			unsigned long long l_gtaddr = pkt.ReverseReadLongLong();

			LG("enter_map", "start entry map cha_id = %d enter--------------------------\n", l_dbid);
			//EnterServerCall * pCall	= g_gmsvr->m_EnterProc.Get();
			//if(pCall)
			//{
			//	pCall->pGate = pGate;
			//	pCall->l_actid = l_actid;
			//	pCall->pszPassword = pszPassword;
			//	pCall->l_dbid = l_dbid;
			//	pCall->l_worldid = l_worldid;
			//	pCall->l_map = l_map;
			//	pCall->lMapCpyNO = lMapCpyNO;
			//	pCall->l_x=l_x ;
			//	pCall->l_y = l_y;
			//	pCall->chLogin = chLogin;
			//	pCall->swiner = swiner;
			//	pCall->l_gtaddr = l_gtaddr;
			//	g_gmsvr->GetProcessor()->AddTask(pCall);
			//}

			l_player = CreateGamePlayer(pszPassword, l_dbid, l_worldid, l_map, chLogin == 0 ? 0 : 1);			
            if (!l_player)
            {
				WPACKET pkret = GETWPACKET();
				WRITE_CMD(pkret, CMD_MC_ENTERMAP);
				WRITE_SHORT(pkret, ERR_MC_ENTER_ERROR);
				WRITE_LONG(pkret, l_dbid);
				WRITE_LONGLONG(pkret, l_gtaddr);
				WRITE_SHORT(pkret, 1);
				pGate->SendData(pkret);
				LG("error", "when create new palyer(ID = %u),assign memory failed \n", l_dbid);
                return ;
            }
			
            l_player->SetActLoginID(l_actid);
			l_player->SetGarnerWiner(swiner);
			l_player->GetLifeSkillinfo() = "";
			l_player->SetInLifeSkill(false);

			if (!chLogin) // 上线（而不是切换地图）
				l_player->MisLogin();			

            //////////////////////////////////////////////////////////////////////////
            // 添加gate server对应的维护信息
            ADDPLAYER(l_player, pGate, l_gtaddr);
            l_player->OnLogin();
            //////////////////////////////////////////////////////////////////////////
            
            CCharacter *pCCha = l_player->GetMainCha();
			if (pCCha->Cmd_EnterMap(l_map, lMapCpyNO, l_x, l_y, chLogin))
			{
				l_player->MisEnterMap();

				if (chLogin == 0) // 角色上线
				{
					NoticePlayerLogin(l_player);
				}
			}

			LG("enter_map", "end up entry map  [%s]================\n\n", pCCha->GetLogName());
			game_db.OnlySavePosWhenBeSaved(l_player);
			break;
		}
	case CMD_TM_GOOUTMAP:
		{
			//LG("XXX", ",0\n");

			l_player = (CPlayer *)MakePointer(pkt.ReverseReadLongLong());
			unsigned long long l_gateaddr = pkt.ReverseReadLongLong();

			if (!l_player)
			{
				LG("error", "CMD_TM_GOOUTMAP\n");
				break;
			}

			try
			{
				if (l_player->GetGateAddr() != l_gateaddr)
				{
					//LG("error", "数据库ID: %u, 地址不匹配，本地:%x, gate:%x,cmd=%d, 有效性(%d).\n", l_player->GetDBChaId(), l_player->GetGateAddr(), l_gateaddr,cmd, l_player->IsValidFlag());
					LG("error", "DB ID: %u, address not matching,local :%x, gate:%x,cmd=%d, validity(%d).\n", l_player->GetDBChaId(), l_player->GetGateAddr(), l_gateaddr,cmd, l_player->IsValidFlag());
					break;
				}
			}
			catch (...)
			{
				//LG("error", "===========================从Gate来的玩家地址错误%p,cmd =%d\n", l_player, cmd);
				LG("error", "===========================from Gate plyaer's address error %p,cmd =%d\n", l_player, cmd);
				break;
			}
			if (!l_player->IsValid())
			{
				//LG("enter_map", "该玩家已经无效\n");
				LG("error", "this palyer already invalid\n");
				break;
			}
			if (l_player->GetMainCha()->GetPlayer() != l_player)
			{
				//LG("error", "两个player不匹配（角色名：%s，Gate地址[本地%p, 客人%p]），cmd=%u\n", l_player->GetMainCha()->GetLogName(), l_player->GetMainCha()->GetPlayer(), l_player, cmd);
				LG("error", "two player not matching(character name:%s,Gate address [local %p, guest %p]),cmd=%u\n", l_player->GetMainCha()->GetLogName(), l_player->GetMainCha()->GetPlayer(), l_player, cmd);
			}

			
			//LG("enter_map", "开始离开地图--------\n");
			LG("enter_map", "start leave map--------\n");
			char	chOffLine = READ_CHAR(pkt); // 角色下线(0)
			
			//LG("enter_map", "清除Player [%s]\n", l_player->GetMainCha()->GetLogName());
			LG("enter_map", "Delete Player [%s]\n", l_player->GetMainCha()->GetLogName());

			//	2008-8-20	yangyinyu	add	begin!
			//lgtool_printCharacter(	RES_STRING(GM_CHARACTER_CPP_00148),	l_player->GetMainCha()	);
			//	2008-8-20	yangyinyu	add	end!

#ifdef OUT_MUL_THREAD
			//GoOutServerCall * pCall	= g_gmsvr->m_GoOutProc.Get();
			//if(pCall)
			//{
			//	pCall->Init(l_player, !chOffLine);
			//	g_gmsvr->GetProcessor()->AddTask(pCall);
			//}
#else
			GoOutGame(l_player, !chOffLine);
#endif
			//LG("enter_map", "结束离开地图========\n\n");
			LG("enter_map", "end and leave the map========\n\n");

			// Add by lark.li 20090112 begin
			//extern ToMMS* g_ToMMS;
			//g_ToMMS->LeaveMap(l_player->GetActLoginID(), l_player->GetID());
			// End

			//LG("OutMap", "%s离开地图\n", szLogName);

			break;
		}
	case CMD_PM_SAY2ALL:
		{
			uLong ulChaID = pkt.ReadLong();
			cChar *szContent = pkt.ReadString();
			long lChatMoney = pkt.ReadLong();

			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(ulChaID);
			if(pPlayer)
			{
				CCharacter *pCha = pPlayer->GetMainCha();
				if(!pCha->HasMoney(lChatMoney))
				{
					//pCha->SystemNotice("您的金钱不够,不能在世界频道聊天!");
					pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00007));

					WPacket l_wpk = GETWPACKET();
					WRITE_CMD(l_wpk, CMD_MP_SAY2ALL);
					WRITE_CHAR(l_wpk, 0);
					pCha->ReflectINFof(pCha, l_wpk);

					break;
				}
				pCha->setAttr(ATTR_GD, (pCha->getAttr(ATTR_GD) - lChatMoney));
				pCha->SynAttr(enumATTRSYN_TASK);
				//pCha->SystemNotice("您在世界频道说了一句话,消耗了%ld个金币!", lChatMoney);
				pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00006), lChatMoney);

				WPacket l_wpk = GETWPACKET();
				WRITE_CMD(l_wpk, CMD_MP_SAY2ALL);
				WRITE_CHAR(l_wpk, 1);
				WRITE_STRING(l_wpk, pCha->GetName());
				WRITE_STRING(l_wpk, szContent);
				pCha->ReflectINFof(pCha, l_wpk);
			}
		}
		break;
	case CMD_PM_SAY2TRADE:
		{
			uLong ulChaID = pkt.ReadLong();
			cChar *szContent = pkt.ReadString();
			long lChatMoney = pkt.ReadLong();

			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(ulChaID);
			if(pPlayer)
			{
				CCharacter *pCha = pPlayer->GetMainCha();
				if(!pCha->HasMoney(lChatMoney))
				{
					//pCha->SystemNotice("您的金钱不够,不能在交易频道聊天!");
					pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00005));

					WPacket l_wpk = GETWPACKET();
					WRITE_CMD(l_wpk, CMD_MP_SAY2TRADE);
					WRITE_CHAR(l_wpk, 0);
					pCha->ReflectINFof(pCha, l_wpk);

					break;
				}
				pCha->setAttr(ATTR_GD, (pCha->getAttr(ATTR_GD) - lChatMoney));
				pCha->SynAttr(enumATTRSYN_TASK);
				//pCha->SystemNotice("您在交易频道说了一句话,消耗了%ld个金币!", lChatMoney);
				pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00004), lChatMoney);

				WPacket l_wpk = GETWPACKET();
				WRITE_CMD(l_wpk, CMD_MP_SAY2TRADE);
				WRITE_CHAR(l_wpk, 1);
				WRITE_STRING(l_wpk, pCha->GetName());
				WRITE_STRING(l_wpk, szContent);
				pCha->ReflectINFof(pCha, l_wpk);
			}
		}
		break;
	case CMD_PM_TEAM: // GroupServer通知组队信息变化
		{
			ProcessTeamMsg(pGate, pkt);
			break;
		}
	case CMD_PM_GUILDINFO:	// GroupServer通知公会信息变化
		{
			ProcessGuildMsg(pGate, pkt);
			break;
		}
	case CMD_PM_GUILD_CHALLMONEY:
		{
			ProcessGuildChallMoney( pGate, pkt );
		}
		break;
	case CMD_PM_GUILD_CHALL_PRIZEMONEY:
		{
			//ProcessGuildChallPrizeMoney( pGate, pkt );

			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MM_GUILD_CHALL_PRIZEMONEY);
			WRITE_LONG(WtPk, 0);
			WRITE_LONG(WtPk, READ_LONG(pkt));
			WRITE_LONG(WtPk, READ_LONG(pkt));
			WRITE_SHORT(WtPk, 0);
			WRITE_LONG(WtPk, 0);
			WRITE_LONG(WtPk, 0);
			pGate->SendData(WtPk);
		}
		break;
	case CMD_PM_GUILD_INVITE:
		{
			uLong chaid = pkt.ReadLong();
			uLong l_inviter_chaid = pkt.ReadLong();
			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(chaid);
			CPlayer *pinviter = g_pGameApp->GetPlayerByDBID(l_inviter_chaid);
			if( pPlayer && pinviter )
			{
				CCharacter* pCha = pPlayer->GetMainCha();
				CCharacter*	pinCha = pinviter->GetMainCha();
				if( pCha && pinCha )
				{
					uLong guildid = pinCha->GetGuildID();
					char l_gldtype	=game_db.GetGuildTypeByID( pinCha,guildid);
					pCha->SetGuildType( l_gldtype );
					pCha->GetPlayer()->m_GuildState.SetBit(emGuildReplaceOldTry);
					pCha->GetPlayer()->m_lTempGuildID = guildid;
					strncpy_s( pCha->GetPlayer()->m_szTempGuildName, sizeof(pCha->GetPlayer()->m_szTempGuildName),pinCha->GetPlayer()->m_szGuildName, _TRUNCATE );
					if( guildid > 0 && guildid < 199 )
					{
						Guild::cmd_GuildCancelTryFor( pCha );
						//Guild::cmd_GuildTryFor( pCha,guildid );
						Guild::cmd_GuildTryForComfirm( pCha, 1);
						Guild::cmd_GuildApprove( pinCha, chaid );
					}
				}
			}
			break;
		}
	case CMD_TM_MAPENTRY:
		{
			ProcessDynMapEntry(pGate, pkt);
			break;
		}
	case CMD_TM_MAP_ADMIN:
		{
			ProcessMapAdmin(pGate, pkt);
			break;
		}
	case CMD_TM_MAPENTRY_NOMAP:
		{
			break;
		}
	case CMD_PM_GARNER2_UPDATE:
		{
			ProcessGarner2Update(pkt);
			break;
		}
	default:
		if (cmd/500 ==CMD_MM_BASE/500)
		{
			ProcessInterGameMsg(cmd, pGate, pkt);
		}else
		{
			l_player = (CPlayer *)MakePointer(pkt.ReverseReadLongLong());
			if (cmd/500 ==CMD_PM_BASE/500 && !l_player)
			{
				ProcessGroupBroadcast(cmd, pGate, pkt);
			}else
			{
				if (!l_player)
					break;
				try
				{
					unsigned long long	l_gateaddr = READ_LONGLONG_R(pkt);
					if (l_player->GetGateAddr() != l_gateaddr)
					{
						/*LG("error", "数据库ID:%u, 地址不匹配，本地:%u, gate:%u,cmd=%d, 有效性(%d)\n", l_player->GetDBChaId(), l_player->GetGateAddr(),
							l_gateaddr,cmd, l_player->IsValidFlag() );*/
						LG("error", "DB ID:%u, address not matching,local :%u, gate:%u,cmd=%d, validity (%d)\n", l_player->GetDBChaId(), l_player->GetGateAddr(),
							l_gateaddr,cmd, l_player->IsValidFlag() );
						break;
					}
				}
				catch (...)
				{
					//LG("error", "===========================从Gate来的玩家地址错误%p,cmd =%d\n", l_player, cmd);
					LG("error", "===========================Player address error that come from Gate %p,cmd =%d\n", l_player, cmd);
					break;
				}
				if (!l_player->IsValid())
					break;
				if (l_player->GetMainCha()->GetPlayer() != l_player)
				{
					//LG("error", "两个player不匹配（角色名：%s，Gate地址[本地%p, 客人%p]），cmd=%u\n", l_player->GetMainCha()->GetLogName(), l_player->GetMainCha()->GetPlayer(), l_player, cmd);
					LG("error", "two player not matching(character name:%s,Gate address [local %p, guest %p]),cmd=%u\n", l_player->GetMainCha()->GetLogName(), l_player->GetMainCha()->GetPlayer(), l_player, cmd);
				}

				CCharacter	*pCCha = l_player->GetCtrlCha();
				if (!pCCha)
					break;
				if (g_pGameApp->IsValidEntity(pCCha->GetID(), pCCha->GetHandle()))
				{
					g_pNoticeChar = pCCha;
					
					g_ulCurID = pCCha->GetID();
					g_lCurHandle = pCCha->GetHandle();

					pCCha->ProcessPacket(cmd, pkt);
					
					g_ulCurID = defINVALID_CHA_ID;
					g_lCurHandle = defINVALID_CHA_HANDLE;

					g_pNoticeChar = NULL;
				}
				else
				{
					//LG("error", "收到CMD_CM_BASE的消息[%d]时, 发现角色pCCha为空\n", cmd);
					LG("error", "when receive CMD_CM_BASE message[%d], find character pCCha is null\n", cmd);
				}
				break;
			}
		}
	}

	//DWORD dwTick = GetTickCount() - dwLastTick;
	//if(dwTick > 10)
	//	LG("TickCount", ",%d,%ld\n", cmd, dwTick);

	//GameServerLG(g_strLogName.c_str(), "CGameApp::ProcessPacket (cmd = %d) End!\n", cmd);
T_E}

// 处理公会投标退钱
void CGameApp::ProcessGuildChallMoney( GateServer *pGate, RPACKET pkt )
{T_B
	DWORD dwChaDBID = READ_LONG(pkt);
	DWORD dwMoney  = READ_LONG(pkt);
	const char* pszGuild1 = READ_STRING(pkt);

	if(pszGuild1 == NULL)
		return;

	const char* pszGuild2 = READ_STRING(pkt);

	if(pszGuild2 == NULL)
		return;

	//	2007-8-4	yangyinyu	change	begin!	//	任意时间收到这个消息，将导致退钱，而且
	CPlayer* pPlayer = GetPlayerByDBID(dwChaDBID);
	if( pPlayer )
	{
		CCharacter* pCha = pPlayer->GetMainCha();
		//pCha->AddMoney( "系统", dwMoney );
		if(pCha)
		{
			pCha->AddMoney( RES_STRING(GM_GAMEAPPNET_CPP_00017), dwMoney );
			/*pCha->SystemNotice( "您投标的与公会《%s》战被公会《%s》取代了，您的投标金(%u)已经退还给您！\n", pszGuild1, pszGuild2, dwMoney );
			LG( "挑战公会结果", "《%s》投标的与公会《%s》战被公会《%s》取代了，您的投标金(%u)已经退还给您！\n", pCha->GetGuildName(), pszGuild1, pszGuild2, dwMoney );*/
			//pCha->SystemNotice( RES_STRING(GM_GAMEAPPNET_CPP_00009), pszGuild1, pszGuild2, dwMoney );
			char szData[128];
			CFormatParameter param(3);
			param.setString( 0, pszGuild1 );
			param.setString( 1, pszGuild2 );
			param.setDouble( 2, dwMoney );
			RES_FORMAT_STRING( GM_GAMEAPPNET_CPP_00009, param, szData );
			pCha->SystemNotice( szData );
			LG( "challenge consortia result", "《%s》bidder and consortia《%s》battle was consortia《%s》replace,your consortia gold (%u)had back to you!\n", pCha->GetGuildName(), pszGuild1, pszGuild2, dwMoney );
		}
	}
	else
	{
		//LG( "挑战公会结果", "未发现公会会长信息指针，无法退钱DBID[%u],钱数[%u].\n", dwChaDBID, dwMoney );
		LG( "challenge consortia result", "not find deacon information finger,cannot back gold DBID[%u],how much money[%u].\n", dwChaDBID, dwMoney );
	}
T_E}

void CGameApp::ProcessGuildChallPrizeMoney( GateServer *pGate, RPACKET pkt )
{T_B
	DWORD dwChaDBID = READ_LONG(pkt);
	DWORD dwMoney  = READ_LONG(pkt);
	CPlayer* pPlayer = GetPlayerByDBID(dwChaDBID);
	if( pPlayer )
	{
		CCharacter* pCha = pPlayer->GetMainCha();
		// pCha->AddMoney( "系统", dwMoney );
		pCha->AddMoney( RES_STRING(GM_CHARACTER_CPP_00012), dwMoney );
		/*pCha->SystemNotice( "恭喜您领导的公会《%s》取得了公会战的胜利！获得奖励金（%u）！", pCha->GetGuildName(), dwMoney );
		LG( "挑战公会结果", "恭喜您领导的公会《%s》取得了公会战的胜利！获得奖励金（%u）！", pCha->GetGuildName(), dwMoney );*/
		//pCha->SystemNotice( RES_STRING(GM_GAMEAPPNET_CPP_00010), pCha->GetGuildName(), dwMoney );
		char szData[128];
		CFormatParameter param(2);
		param.setString( 0, pCha->GetGuildName() );
		param.setDouble( 1, dwMoney );
		RES_FORMAT_STRING( GM_GAMEAPPNET_CPP_00010, param, szData );
		pCha->SystemNotice( szData );
		LG( "challenge consortia result", "congratulate you have leading the consortia《%s》get win in consortia battle!gain bounty(%u)!", pCha->GetGuildName(), dwMoney );
	}
	else
	{
		//LG( "挑战公会结果", "未发现公会会长信息指针，无法奖励DBID[%u],钱数[%u]", dwChaDBID, dwMoney );
		LG( "challenge consortia result", "cannot find deacon information finger,cannot hortation DBID[%u],how much money[%u]", dwChaDBID, dwMoney );
	}
T_E}

// 处理公会信息
void CGameApp::ProcessGuildMsg(GateServer *pGate, RPACKET pkt)
{T_B
	DWORD dwChaDBID  = READ_LONG(pkt);
	CPlayer* pPlayer = GetPlayerByDBID(dwChaDBID);
	if( pPlayer )
	{
		CCharacter* pCha = pPlayer->GetCtrlCha();
		BYTE byType = READ_CHAR(pkt);
		DWORD dwGuildID = READ_LONG(pkt);
		DWORD dwLeaderID = READ_LONG(pkt);
		const char* pszGuildName = READ_STRING(pkt);
		const char* pszGuildMotto = READ_STRING(pkt);
		pCha->SetGuildType( byType );

		if(pszGuildName == NULL)
			pCha->SetGuildName( "" );
		else
			pCha->SetGuildName( pszGuildName );

		if(pszGuildMotto == NULL)
			pCha->SetGuildMotto( pszGuildMotto );
		else
			pCha->SetGuildMotto( "" );

		pCha->SyncGuildInfo();
	}
T_E}

// 处理组队有关消息
void CGameApp::ProcessTeamMsg(GateServer *pGate, RPACKET pkt)
{T_B
	//LG("team", "开始处理组队消息\n");

	char cTeamMsgType = READ_CHAR(pkt);
	
	switch(cTeamMsgType)
	{
		case TEAM_MSG_ADD:     {	/*LG("team", "收到组队 [新加队员] 消息\n");*/ break; }
		case TEAM_MSG_LEAVE:   {	/*LG("team", "收到组队 [队员离队] 消息\n");*/ break; }
		case TEAM_MSG_UPDATE:  {	/*LG("team", "收到组队 [队员刷新] 消息\n");*/ break; }
		default:
			//LG("team", "收到无效的Team消息 [%d]\n", cTeamMsgType);
			return;
	}
	
	char cMemberCnt = READ_CHAR(pkt);

	if(cMemberCnt > MAX_TEAM_MEMBER)
	{
		LG("team", "team count [%d] error\n", cMemberCnt);
		return;
	}
	//LG("team", "当前队员总数量[%d]\n", cMemberCnt); // 如果收到数量 < 2则表示GroupServer的队伍信息出问题了.

	uplayer Team[MAX_TEAM_MEMBER];
	CPlayer *PlayerList[MAX_TEAM_MEMBER];
	bool	CanSeenO[MAX_TEAM_MEMBER][2];
	bool	CanSeenN[MAX_TEAM_MEMBER][2];
			
	// 读取包信息并查找出所有的Player
	for(char i = 0; i < cMemberCnt; i++)
	{
		const char *pszGateName = READ_STRING(pkt);
		
		if(pszGateName == NULL)
			return;

		unsigned long long dwGateAddr = READ_LONGLONG(pkt);
		DWORD dwChaDBID  = READ_LONG(pkt);
		Team[i].Init(pszGateName, dwGateAddr, dwChaDBID);
		if (!Team[i].pGate)
		{
			LG("team", "GameServer can't find matched Gate:%s, addr = 0x%X, chaid = %d.\n", pszGateName, dwGateAddr, dwChaDBID);
			//LG("team", "\tGameServer all Gate:\n");
			BEGINGETGATE();
			GateServer	*pGateServer;
			while (pGateServer = GETNEXTGATE())
			{
				LG("team", "\t%s\n", pGateServer->GetName().c_str());
			}
		}
			
		PlayerList[i] = GetPlayerByDBID(dwChaDBID);
		
		//LG("team", "队员: %s, %d %d 来自Gate [%s]\n", PlayerList[i]!=NULL ? PlayerList[i]->GetCtrlCha()->GetLogName():"(此人不在本Server!)", dwChaDBID, dwGateAddr, pszGateName);
	}

	//RefreshTeamEyeshot(PlayerList, cMemberCnt, cTeamMsgType);
	CheckSeeWithTeamChange(CanSeenO, PlayerList, cMemberCnt);
	//if(PlayerList[0]==NULL)
	//{
	//	LG("team", "队长不在本game server上了\n");
	//}

	int nLeftMember = cMemberCnt;
	if(cTeamMsgType == TEAM_MSG_LEAVE) // 队员离队或下线
	{
		nLeftMember-=1;
		CPlayer *pLeave = PlayerList[cMemberCnt - 1];
		if(pLeave)
		{
			pLeave->LeaveTeam();
		}
	}
	// 彼此之间添加队友, 如果cMember此时为1, 则等价于解除了队伍
	for(int i = 0; i < nLeftMember; i++)
	{
		if(PlayerList[i]==NULL) continue;
			
		PlayerList[i]->ClearTeamMember();
		for(int j = 0; j < nLeftMember; j++)
		{
			if(i==j) continue;
			PlayerList[i]->AddTeamMember(&Team[j]);
		}
		if (nLeftMember != 1)
		{
			PlayerList[i]->setTeamLeaderID(Team[0].m_dwDBChaId);
			PlayerList[i]->NoticeTeamLeaderID();
		}
	}

	CheckSeeWithTeamChange(CanSeenN, PlayerList, cMemberCnt);
	RefreshTeamEyeshot(CanSeenO, CanSeenN, PlayerList, cMemberCnt, cTeamMsgType);

	//add by jilinlee 2007/07/11

	for(char i = 0; i < cMemberCnt; i++)
	{
        if(i < 5)
        {
            if(PlayerList[i])
            {
		        CCharacter* pCtrlCha = PlayerList[i] ->GetCtrlCha();
		        if(pCtrlCha)
		        {
			        SubMap* pSubMap = pCtrlCha ->GetSubMap();
				        if(pSubMap && pSubMap ->GetMapRes())
				        {
					        if(!(pSubMap ->GetMapRes() ->CanTeam()))
					        {
								// pCtrlCha ->SystemNotice("此地图不能组队，您被踢出此地图！");
								pCtrlCha ->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00011));

								LG("team", "MoveCity()\n");
								//Modify by lark.li 20090114 begin
								//pCtrlCha ->MoveCity("garner");
								// 打回到出生地 
								pCtrlCha ->MoveCity("");
								// End
					        }
				        }
		        }
            }
        }
	}

	//if(nLeftMember==1) LG("team", "nLeftMember==1, 队伍解散!\n");
	
	//LG("team", "结束处理组队消息\n\n");
T_E}

// 确定玩家间是否可见
void CGameApp::CheckSeeWithTeamChange(bool CanSeen[][2], CPlayer **pCPlayerList, char chMemberCnt)
{T_B
	if (chMemberCnt <= 1)
		return;

	CPlayer	*pCProcPly = pCPlayerList[chMemberCnt - 1];
	if (!pCProcPly)
		return;

	CPlayer	*pCCurPly;
	CCharacter	*pCProcCha = pCProcPly->GetCtrlCha(), *pCCurCha;
	for (char i = 0; i < chMemberCnt - 1; i++)
	{
		pCCurPly = pCPlayerList[i];
		if (!pCCurPly)
			continue;
		pCCurCha = pCCurPly->GetCtrlCha();
		if (pCProcCha->IsInEyeshot(pCCurCha))
		{
			pCProcCha->CanSeen(pCCurCha) ? CanSeen[i][0] = true : CanSeen[i][0] = false;
			pCCurCha->CanSeen(pCProcCha) ? CanSeen[i][1] = true : CanSeen[i][1] = false;
		}
	}
T_E}

// 根据当前是否可见与之前的进行比较来刷新视野
void CGameApp::RefreshTeamEyeshot(bool CanSeenOld[][2], bool CanSeenNew[][2], CPlayer **pCPlayerList, char chMemberCnt, char chRefType)
{T_B
	if (chMemberCnt <= 1)
		return;

	CPlayer	*pCProcPly = pCPlayerList[chMemberCnt - 1];
	if (!pCProcPly)
		return;

	CPlayer	*pCCurPly;
	CCharacter	*pCProcCha = pCProcPly->GetCtrlCha(), *pCCurCha;
	for (char i = 0; i < chMemberCnt - 1; i++)
	{
		pCCurPly = pCPlayerList[i];
		if (!pCCurPly)
			continue;
		pCCurCha = pCCurPly->GetCtrlCha();
		if (pCProcCha->IsInEyeshot(pCCurCha))
		{
			if (chRefType == TEAM_MSG_ADD)
			{
				if (!CanSeenOld[i][0] && CanSeenNew[i][0])
					pCCurCha->BeginSee(pCProcCha);
				if (!CanSeenOld[i][1] && CanSeenNew[i][1])
					pCProcCha->BeginSee(pCCurCha);
			}
			else if (chRefType == TEAM_MSG_LEAVE)
			{
				if (CanSeenOld[i][0] && !CanSeenNew[i][0])
					pCCurCha->EndSee(pCProcCha);
				if (CanSeenOld[i][1] && !CanSeenNew[i][1])
					pCProcCha->EndSee(pCCurCha);
			}
		}
	}
T_E}

// 根据当前是否可见来刷新视野
void CGameApp::RefreshTeamEyeshot(CPlayer **pCPlayerList, char chMemberCnt, char chRefType)
{T_B
	if (chMemberCnt <= 1)
		return;

	CPlayer	*pCProcPly = pCPlayerList[chMemberCnt - 1];
	if (!pCProcPly)
		return;

	CPlayer	*pCCurPly;
	CCharacter	*pCProcCha = pCProcPly->GetCtrlCha(), *pCCurCha;
	bool	bCurChaHide;
	bool	bProcChaHide = pCProcCha->IsHide();
	for (char i = 0; i < chMemberCnt - 1; i++)
	{
		pCCurPly = pCPlayerList[i];
		if (!pCCurPly)
			continue;
		pCCurCha = pCCurPly->GetCtrlCha();
		bCurChaHide = pCCurCha->IsHide();
		if (bProcChaHide || bCurChaHide) // 存在隐身
		{
			if (pCProcCha->IsInEyeshot(pCCurCha))
			{
				if (chRefType == TEAM_MSG_ADD)
				{
					if (bProcChaHide)
						pCCurCha->BeginSee(pCProcCha);
					if (bCurChaHide)
						pCProcCha->BeginSee(pCCurCha);
				}
				else if (chRefType == TEAM_MSG_LEAVE)
				{
					if (bProcChaHide)
						pCCurCha->EndSee(pCProcCha);
					if (bCurChaHide)
						pCProcCha->EndSee(pCCurCha);
				}
			}
		}
	}
T_E}

BOOL CGameApp::AddVolunteer(CCharacter *pCha)
{T_B
	if(pCha->IsVolunteer())
		return false;
	pCha->SetVolunteer(true);

	SVolunteer volNode;
	volNode.lJob = (long)pCha->getAttr(ATTR_JOB);
	volNode.lLevel = pCha->GetLevel();
	volNode.ulID = pCha->GetID();
	//strcpy(volNode.szMapName, pCha->GetSubMap()->GetName());
	strncpy_s( volNode.szMapName, sizeof(volNode.szMapName), pCha->GetSubMap()->GetName(), _TRUNCATE );
	//strcpy(volNode.szName, pCha->GetName());
	strncpy_s( volNode.szName, sizeof(volNode.szName), pCha->GetName(), _TRUNCATE );

	m_vecVolunteerList.push_back(volNode);
	
	return true;
T_E}

BOOL CGameApp::DelVolunteer(CCharacter *pCha)
{T_B
	if(!pCha->IsVolunteer())
		return false;
	pCha->SetVolunteer(false);

	vector<SVolunteer>::iterator it;
	for(it = m_vecVolunteerList.begin(); it != m_vecVolunteerList.end(); it++)
	{
		if(!strcmp((*it).szName, pCha->GetName()))
		{
			m_vecVolunteerList.erase(it);
			return true;
		}
	}

	return false;
T_E}

int CGameApp::GetVolNum()
{T_B
	return (int)m_vecVolunteerList.size();
T_E}

SVolunteer* CGameApp::GetVolInfo(int nIndex)
{T_B
	if(nIndex < 0 || nIndex >= (int)m_vecVolunteerList.size())
		return NULL;
	
	return &m_vecVolunteerList[nIndex];
T_E}

SVolunteer* CGameApp::FindVolunteer(const char *szName)
{T_B
	vector<SVolunteer>::iterator it;
	for(it = m_vecVolunteerList.begin(); it != m_vecVolunteerList.end(); it++)
	{
		if(!strcmp((*it).szName, szName))
		{
			return (SVolunteer *)&(*it);
		}
	}
	return NULL;
T_E}

void CGameApp::ProcessInterGameMsg(unsigned short usCmd, GateServer *pGate, RPACKET pkt)
{T_B
	long	lSrcID = READ_LONG(pkt);
	short	sNum = READ_SHORT_R(pkt);
	unsigned long long	lGatePlayerAddr = pkt.ReverseReadLongLong();
	long	    lGatePlayerID = READ_LONG_R(pkt);

	switch (usCmd)
	{
	case CMD_MM_GUILD_MOTTO:
		{
			uLong	l_gldid		=lSrcID;
			cChar* pszMotto = READ_STRING( pkt );
			{//来自于FindPlayerChaByID

				if(pszMotto == NULL)
					pszMotto = "";

				BEGINGETGATE();
				CPlayer	*pCPlayer;
				CCharacter	*pCha = 0;
				GateServer	*pGateServer;
				while (pGateServer = GETNEXTGATE())
				{
					if (!BEGINGETPLAYER(pGateServer))
						continue;
					int nCount = 0;
					while (pCPlayer = (CPlayer *)GETNEXTPLAYER(pGateServer))
					{
						if (++nCount > GETPLAYERCOUNT(pGateServer))
						{
							//LG("玩家链表错误", "玩家数目:%u, %s\n", GETPLAYERCOUNT(pGateServer), "ProcessInterGameMsg::CMD_MM_GUILD_DISBAND");
							LG("player list error", "player number:%u, %s\n", GETPLAYERCOUNT(pGateServer), "ProcessInterGameMsg::CMD_MM_GUILD_DISBAND");
							break;
						}
						pCha = pCPlayer->GetMainCha();
						if (!pCha)
							continue;
						if (pCha->GetGuildID() == l_gldid) // 找到角色
						{							
							pCha->SetGuildMotto(pszMotto);
							pCha->SyncGuildInfo();
							//pCha->SystemNotice("公会座右铭已修改！");
							pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00012));
						}
					}
				}
			}
		}
		break;
	case CMD_MM_GUILD_DISBAND:
		{
			uLong	l_gldid		=lSrcID;
			{//来自于FindPlayerChaByID
				BEGINGETGATE();
				CPlayer	*pCPlayer;
				CCharacter	*pCha = 0;
				GateServer	*pGateServer;
				while (pGateServer = GETNEXTGATE())
				{
					if (!BEGINGETPLAYER(pGateServer))
						continue;
					int nCount = 0;
					while (pCPlayer = (CPlayer *)GETNEXTPLAYER(pGateServer))
					{
						if (++nCount > GETPLAYERCOUNT(pGateServer))
						{
							//LG("玩家链表错误", "玩家数目:%u, %s\n", GETPLAYERCOUNT(pGateServer), "ProcessInterGameMsg::CMD_MM_GUILD_DISBAND");
							LG("player list error", "player number:%u, %s\n", GETPLAYERCOUNT(pGateServer), "ProcessInterGameMsg::CMD_MM_GUILD_DISBAND");
							break;
						}
						pCha = pCPlayer->GetMainCha();
						if (!pCha)
							continue;
						if (pCha->GetGuildID() == l_gldid) // 找到角色
						{
							pCha->m_CChaAttr.ResetChangeFlag();

							pCha->SetGuildID( 0 );
							pCha->SetGuildState( 0 );
							pCha->SynAttr(enumATTRSYN_TRADE);
							
							pCha->SetGuildName("");
							pCha->SetGuildMotto("");
							pCha->SyncGuildInfo();
							//pCha->SystemNotice("公会已经被会长解散");
							pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00013));
						}
					}
				}
			}
		}
		break;
	case CMD_MM_GUILD_KICK:
		{
			uLong	l_chaid		=lSrcID;
			CCharacter	*pCha	=FindMainPlayerChaByID(l_chaid);
			if(pCha)
			{
				pCha->SetGuildName("");
				cChar * l_gldname =READ_STRING(pkt);
				if(l_gldname == NULL)
					l_gldname = "";

				pCha->SetGuildID( 0 );			//设置公会ID
				pCha->SetGuildType( 0 );		//设置公会Type
				pCha->SetGuildState( 0 );				
				pCha->SetGuildName( "" );
				pCha->SetGuildMotto( "" );
               // pCha->SystemNotice("你已经被开除出公会[%s].",l_gldname);
				 pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00014),l_gldname);
				pCha->SyncGuildInfo();
			}
		}
		break;
	case CMD_MM_GUILD_APPROVE:
		{
			uLong	l_chaid		=lSrcID;
			CCharacter	*pCha	=FindMainPlayerChaByID(l_chaid);
			if(pCha)
			{
				pCha->SetGuildID( READ_LONG(pkt) );				//设置公会ID
				pCha->SetGuildType( READ_CHAR(pkt) );
				pCha->SetGuildState( 0 );	//设置公会Type
				cChar * l_gldname =READ_STRING(pkt);

				if(l_gldname == NULL)
					l_gldname = "";

				pCha->SetGuildName(l_gldname);
				cChar * l_gldmotto = READ_STRING(pkt);

				if(l_gldmotto == NULL)
					l_gldmotto = "";

				pCha->SetGuildMotto( l_gldmotto );

              //  pCha->SystemNotice("你已经被批准加入公会[%s].",l_gldname);
				  pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00015),l_gldname);
				pCha->SyncGuildInfo();
			}
		}
		break;
	case CMD_MM_GUILD_REJECT:
		{
			uLong l_chaid		=lSrcID;
			CCharacter	*pCha	=FindMainPlayerChaByID(l_chaid);
			if(pCha)
			{
				pCha->SetGuildID( 0 );
				pCha->SetGuildState( 0 );
				pCha->SetGuildName("");				

                //pCha->SystemNotice("你对公会[%s]的加入申请被拒绝.",READ_STRING(pkt));
				const char	*cszMsg = READ_STRING(pkt);
				if(cszMsg != NULL)
					pCha->SystemNotice(RES_STRING(GM_GAMEAPPNET_CPP_00016),cszMsg);
			}
		}
		break;
	case	CMD_MM_QUERY_CHAPING:
		{
			const char	*cszChaName = READ_STRING(pkt);
			
			if(cszChaName == NULL)
				break;

			CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
			if (!pCCha)
				break;

			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_PING);
			WRITE_LONG(WtPk, GetTickCount());
			WRITE_LONGLONG(WtPk, MakeULong(pGate));
			WRITE_LONG(WtPk, lSrcID);
			WRITE_LONG(WtPk, lGatePlayerID);
			WRITE_LONGLONG(WtPk, lGatePlayerAddr);
			WRITE_SHORT(WtPk, 1);
			pCCha->ReflectINFof(pCCha,WtPk);

			break;
		}
	case	CMD_MM_QUERY_CHA:
		{
			const char	*cszChaName = READ_STRING(pkt);

			if(cszChaName == NULL)
				break;

			CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
			if (!pCCha || !pCCha->GetSubMap())
				break;

			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_QUERY_CHA);
			WRITE_LONG(WtPk, lSrcID);
			WRITE_STRING(WtPk, pCCha->GetName());
			WRITE_STRING(WtPk, pCCha->GetSubMap()->GetName());
			WRITE_LONG(WtPk, pCCha->GetPos().x);
			WRITE_LONG(WtPk, pCCha->GetPos().y);
			WRITE_LONG(WtPk, pCCha->GetID());
			WRITE_LONG(WtPk, lGatePlayerID);
			WRITE_LONGLONG(WtPk, lGatePlayerAddr);
			WRITE_SHORT(WtPk, 1);
			pGate->SendData(WtPk);

			break;
		}
	case	CMD_MM_QUERY_CHAITEM:
		{
			const char	*cszChaName = READ_STRING(pkt);

			if(cszChaName == NULL)
				break;

			CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
			if (!pCCha)
				break;
			pCCha->GetKitbag()->SetChangeFlag();

			WPACKET WtPk	=GETWPACKET();
			WRITE_CMD(WtPk, CMD_MC_QUERY_CHA);
			WRITE_LONG(WtPk, lSrcID);
			pCCha->WriteKitbag(pCCha->GetKitbag(), WtPk, enumSYN_KITBAG_INIT);
			WRITE_LONG(WtPk, lGatePlayerID);
			WRITE_LONGLONG(WtPk, lGatePlayerAddr);
			WRITE_SHORT(WtPk, 1);
			pGate->SendData(WtPk);

			break;
		}
	case	CMD_MM_CALL_CHA:
		{
			const char	*cszChaName = READ_STRING(pkt);
			
			if(cszChaName == NULL)
				break;

			CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
			if (!pCCha || !pCCha->GetSubMap())
				break;
			bool	bTarIsBoat = READ_CHAR(pkt) ? true : false;
			if (bTarIsBoat != pCCha->IsBoat()) // 不同区域类型
				break;
			const char	*cszMapName = READ_STRING(pkt);

			if(cszMapName == NULL)
				break;

			long	lPosX = READ_LONG(pkt);
			long	lPosY = READ_LONG(pkt);
			long	lCopyNO = READ_LONG(pkt);
			pCCha->SwitchMap(pCCha->GetSubMap(), cszMapName, lPosX, lPosY, true, enumSWITCHMAP_CARRY, lCopyNO);

			break;
		}
	case	CMD_MM_GOTO_CHA:
		{
			const char	*cszChaName = READ_STRING(pkt);

			if(cszChaName == NULL)
				break;

			CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
			if (!pCCha || !pCCha->GetSubMap())
				break;
			switch (READ_CHAR(pkt))
			{
			case	1: // 请求查找目标角色
				{
					const char	*cszSrcName = READ_STRING(pkt);

					if(cszSrcName == NULL)
						break;

					WPACKET WtPk	=GETWPACKET();
					WRITE_CMD(WtPk, CMD_MM_GOTO_CHA);
					WRITE_LONG(WtPk, lSrcID);
					WRITE_STRING(WtPk, cszSrcName);
					WRITE_CHAR(WtPk, 2);
					if (pCCha->IsBoat())
						WRITE_CHAR(WtPk, 1);
					else
						WRITE_CHAR(WtPk, 0);
					WRITE_STRING(WtPk, pCCha->GetSubMap()->GetName());
					WRITE_LONG(WtPk, pCCha->GetPos().x);
					WRITE_LONG(WtPk, pCCha->GetPos().y);
					WRITE_LONG(WtPk, pCCha->GetSubMap()->GetCopyNO());
					WRITE_LONG(WtPk, lGatePlayerID);
					WRITE_LONGLONG(WtPk, lGatePlayerAddr);
					WRITE_SHORT(WtPk, 1);
					pGate->SendData(WtPk);

					break;
				}
			case	2: // 找到了目标角色，原角色进行跳转
				{
					bool	bTarIsBoat = READ_CHAR(pkt) ? true : false;
					if (bTarIsBoat != pCCha->IsBoat()) // 不同区域类型
						break;
					const char	*cszMapName = READ_STRING(pkt);

					if(cszMapName == NULL)
						break;

					long	lPosX = READ_LONG(pkt);
					long	lPosY = READ_LONG(pkt);
					long	lCopyNO = READ_LONG(pkt);
					pCCha->SwitchMap(pCCha->GetSubMap(), cszMapName, lPosX, lPosY, true, enumSWITCHMAP_CARRY, lCopyNO);

					break;
				}
			}

			break;
		}
	case	CMD_MM_KICK_CHA:
		{
			const char	*cszChaName = READ_STRING(pkt);

			if(cszChaName == NULL)
				break;

			long	lTime = READ_LONG(pkt);
			CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
			if (!pCCha || !pCCha->GetSubMap())
				break;

			KICKPLAYER(pCCha->GetPlayer(), lTime);
			g_pGameApp->GoOutGame(pCCha->GetPlayer(), true);

			break;
		}
	case	CMD_MM_NOTICE:
		{
			LocalNotice(READ_STRING(pkt));

			break;
		}
	case	CMD_MM_CHA_NOTICE:
		{
			const char	*cszNotiCont = READ_STRING(pkt);

			if(cszNotiCont == NULL)
				break;

			const char	*cszChaName = READ_STRING(pkt);

			if(cszChaName == NULL)
				break;

			if (!strcmp(cszChaName, ""))
				LocalNotice(cszNotiCont);
			else
			{
				CCharacter	*pCCha = FindPlayerChaByName(cszChaName);
				if (!pCCha)
					break;

				WPACKET wpk	= GETWPACKET();
				WRITE_CMD(wpk, CMD_MC_SYSINFO);
				WRITE_STRING(wpk, cszNotiCont);
				pCCha->ReflectINFof(pCCha, wpk);
			}

			break;
		}
	case	CMD_MM_DO_STRING:
		{
			lua_dostring(g_pLuaState, READ_STRING(pkt));
			break;
		}
	case	CMD_MM_LOGIN:
		{
			g_pGameApp->AfterPlayerLogin(READ_STRING(pkt));

			break;
		}
	case	CMD_MM_GUILD_CHALL_PRIZEMONEY:
		{
			DWORD dwChaDBID = READ_LONG(pkt);
			DWORD dwMoney  = READ_LONG(pkt);
			CPlayer* pPlayer = GetPlayerByDBID(dwChaDBID);
			if( pPlayer )
			{
				CCharacter* pCha = pPlayer->GetMainCha();
				/*pCha->AddMoney( "系统", dwMoney );
				pCha->SystemNotice( "恭喜您领导的公会《%s》取得了公会战的胜利！获得奖励金（%u）！", pCha->GetGuildName(), dwMoney );
				LG( "挑战公会结果", "恭喜您领导的公会《%s》ID（%u）取得了公会战的胜利！获得奖励金（%u）！\n", pCha->GetGuildName(), 
					pCha->GetGuildID(), dwMoney );*/
				pCha->AddMoney( RES_STRING(GM_GAMEAPPNET_CPP_00017), dwMoney );
				pCha->SystemNotice( RES_STRING(GM_GAMEAPPNET_CPP_00010), pCha->GetGuildName(), dwMoney );
				LG( "challenge consortia result", "congratulate you leading consortia《%s》ID(%u)get win in consortia battle!gain bounty(%u)!\n", pCha->GetGuildName(), 
					pCha->GetGuildID(), dwMoney );
			}
			//else
			//{
			//	LG( "挑战公会结果", "未发现公会会长信息指针，无法奖励DBID[%u],钱数[%u]\n", dwChaDBID, dwMoney );
			//}

			break;
		}
	case	CMD_MM_ADDCREDIT:
		{
			DWORD dwChaDBID = READ_LONG(pkt);
			long lCredit = READ_LONG(pkt);
			CPlayer* pPlayer = GetPlayerByDBID(dwChaDBID);
			if(pPlayer)
			{
				CCharacter* pCha = pPlayer->GetMainCha();
				pCha->SetCredit((long)pCha->GetCredit() + lCredit);
				pCha->SynAttr(enumATTRSYN_TASK);
			}
			break;
		}
	case	CMD_MM_STORE_BUY:
		{
			DWORD dwChaDBID = READ_LONG(pkt);
			long lComID = READ_LONG(pkt);
			//long lMoBean = READ_LONG(pkt);
			long lRplMoney = READ_LONG(pkt);
			CPlayer* pPlayer = GetPlayerByDBID(dwChaDBID);
			if(pPlayer)
			{
				CCharacter* pCha = pPlayer->GetMainCha();
				g_StoreSystem.Accept(pCha, lComID);
				//pCha->GetPlayer()->SetMoBean(lMoBean);
				pCha->GetPlayer()->SetRplMoney(lRplMoney);
			}
			break;
		}
	case CMD_MM_ADDMONEY:
		{
			DWORD dwChaID = READ_LONG(pkt);
			DWORD dwMoney = READ_LONG(pkt);

			CCharacter *pCha = NULL;
			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(dwChaID);
			if(pPlayer)
			{
				pCha = pPlayer->GetMainCha();
			}
			if(pCha)
			{
				//pCha->AddMoney("系统", dwMoney);
				pCha->AddMoney(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00023), dwMoney);
			}

			break;
		}
	case CMD_MM_AUCTION:
		//add by ALLEN 2007-10-19
		{
			
			DWORD dwChaID = READ_LONG(pkt);
			
			CCharacter *pCha = NULL;
			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(dwChaID);
			if(pPlayer)
			{
				pCha = pPlayer->GetMainCha();
			}
			if(pCha)
			{
				g_CParser.DoString("AuctionEnd", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCha, DOSTRING_PARAM_END);
			}

			break;
		}
#ifdef SHUI_JING
	case CMD_MM_NOTICETOCHA:
		{
			long dwChaID = lSrcID;
			int type = READ_SHORT(pkt);
			DWORD Price = READ_LONG(pkt);
			DWORD Num = READ_LONG(pkt);
			DWORD tMoney = READ_LONG(pkt);
			CCharacter* pCha = NULL;
			CPlayer *pPlayer = g_pGameApp->GetPlayerByDBID(dwChaID);
			if( type == 1 )
			{
				if( pPlayer )
				{
					pCha = pPlayer->GetMainCha();
					if( pCha )
					{
						DWORD flatmoney = 0;
						//if( game_db.GetdwFlatMoney( pCha->GetName(), flatmoney ) )
						//{
						flatmoney = pCha->GetFlatMoney();
						pCha->SetFlatMoney( flatmoney + Price * Num );
						pCha->Cmd_TradeInfoAsr( type, true, Num, Price );
						pCha->Cmd_CrystalBuyAndSaleList();
					}
					//else
					//	game_db.SetdwFlatMoney( dwChaID, Price * Num );
				}
			}
			else if( type == 0 )
			{
				if( pPlayer )
				{
					pCha = pPlayer->GetMainCha();
					if( pCha )
					{
						pPlayer->SetRplMoney( tMoney );
						pCha->Cmd_TradeInfoAsr( type, true, Num, Price );
						pCha->Cmd_CrystalBuyAndSaleList();
					}
				}
			}
		break;
		}
#endif
	case CMD_MM_EXCHEXTERNVALUE:
		{
			const char* szScriptName = READ_STRING( pkt );
			long	m_lValue = READ_LONG( pkt );
			g_CParser.DoString( szScriptName,  enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_NUMBER, 1, m_lValue, DOSTRING_PARAM_END);
			break;
		}
	}
T_E}
void CGameApp::ProcessGroupBroadcast(unsigned short usCmd, GateServer *pGate, RPACKET pkt)
{T_B


T_E}
void CGameApp::ProcessGarner2Update(RPACKET pkt)//CMD_PM_GARNER2_UPDATE
{T_B
	long chaid[6];
	CPlayer * pplay;
//	CCharacter * pcha;
	chaid[0] = READ_LONG_R(pkt);
	chaid[1] = READ_LONG(pkt);
	chaid[2] = READ_LONG(pkt);
	chaid[3] = READ_LONG(pkt);
	chaid[4] = READ_LONG(pkt);
	chaid[5] = READ_LONG(pkt);
	if(0 != chaid[0])
	{
		pplay = FindPlayerByDBChaID(chaid[0]);
		if(pplay)
		{
			pplay->SetGarnerWiner(0);
		}
	}

	for(int i = 1;i<6 && chaid[i];i++)
	{
		pplay = FindPlayerByDBChaID(chaid[0]);
		if(pplay)
		{
			pplay->SetGarnerWiner(i);
		}
	}
T_E}

void CGameApp::ProcessMapAdmin(GateServer *pGate, RPACKET pkt)
{T_B
	
	LG("map_entrance_flow", "ProcessMapAdmin\n");

	if(pGate == NULL)
		return;

	cChar	*szMap = READ_STRING(pkt);

	if(szMap == NULL)
		return;

	CMapRes	*pCMapRes = FindMapByName(szMap);
	if (!pCMapRes)
	{
		return;
	}
	
	uShort id = READ_SHORT_R(pkt);
	unsigned long long addr = READ_LONGLONG_R(pkt);
	uLong dbID = READ_LONG_R(pkt);

	switch (READ_CHAR(pkt))
	{
	case enumMAPADMIN_OPEN_MAP:
		{
			pCMapRes->OpenMap();
		}
		break;
	case enumMAPADMIN_CLOSE_MAP:
		{
			pCMapRes->CloseMap();
		}
		break;
	case enumMAPADMIN_OPEN_MAP_ENTRY:
		{
			pCMapRes->OpenMapEntry();
		}
		break;
	case enumMAPADMIN_CLOSE_MAP_ENTRY:
		{
			pCMapRes->CloseMapEntry();
		}
		break;
	case enumMAPADMIN_CHECK_MAP:
		{
			string str;
			pCMapRes->CheckMapState(str);

			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MC_SYSINFO);
			WRITE_STRING(wpk, str.c_str());

			WRITE_LONG(wpk, dbID);
			WRITE_LONGLONG(wpk, addr);
			WRITE_SHORT(wpk, 1);

			pGate->SendData(wpk);
		}
		break;
	}

T_E}

void CGameApp::ProcessDynMapEntry(GateServer *pGate, RPACKET pkt)
{T_B
	cChar	*szTarMapN = READ_STRING(pkt);

	if(szTarMapN == NULL)
		return;

	cChar	*szSrcMapN = READ_STRING(pkt);

	if(szSrcMapN == NULL)
		return;

	switch (READ_CHAR(pkt))
	{
	case	enumMAPENTRY_CREATE:
		{
			CMapRes	*pCMapRes;
			SubMap	*pCMap;
			pCMapRes = FindMapByName(szTarMapN);
			if (!pCMapRes)
			{
				break;
			}
			pCMap = pCMapRes->GetCopy();
			Long	lPosX = READ_LONG(pkt);
			Long	lPosY = READ_LONG(pkt);
			Short	sMapCopyNum = READ_SHORT(pkt);
			Short	sCopyPlyNum = READ_SHORT(pkt);
			CDynMapEntryCell	CEntryCell;
			CEntryCell.SetMapName(szTarMapN);
			CEntryCell.SetTMapName(szSrcMapN);
			CEntryCell.SetEntiPos(lPosX, lPosY);
			CDynMapEntryCell	*pCEntry = g_CDMapEntry.Add(&CEntryCell);
			if (pCEntry)
			{
				if (g_cchLogMapEntry)
					//LG("地图入口流程", "收到创建入口请求：位置 %s --> %s[%u, %u]，脚本行数 %d\n", szSrcMapN, szTarMapN, lPosX, lPosY, sLineNum);
					LG("map_entrance_flow", "receive request to create entry:position %s --> %s[%u, %u]\n", szSrcMapN, szTarMapN, lPosX, lPosY);
				pCEntry->SetCopyNum(sMapCopyNum);
				pCEntry->SetCopyPlyNum(sCopyPlyNum);
				string	strScript;
				cChar	*cszSctLine;
				Short	sLineNum = READ_SHORT_R(pkt);
				while (--sLineNum >= 0)
				{
					cszSctLine = READ_STRING(pkt);
					strScript += cszSctLine;
					strScript += " ";
				}
				lua_dostring(g_pLuaState, strScript.c_str());
				g_CParser.DoString("config_entry", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCEntry, DOSTRING_PARAM_END);

				if (pCEntry->GetEntiID() > 0)
				{
					SItemGrid	SItemCont;
					SItemCont.sID = (Short)pCEntry->GetEntiID();
					SItemCont.sNum = 1;
					SItemCont.SetDBParam(-1, 0);
					SItemCont.chForgeLv = 0;
					SItemCont.SetInstAttrInvalid();
					CItem *pCItem = pCMap->ItemSpawn(&SItemCont, lPosX, lPosY, enumITEM_APPE_NATURAL, 0, g_pCSystemCha->GetID(), g_pCSystemCha->GetHandle(), -1, -1,
						pCEntry->GetEvent());
					if (pCItem)
					{
						pCItem->SetOnTick(0);
						pCEntry->SetEnti(pCItem);
					}
					else
					{
						if (g_cchLogMapEntry)
							//LG("地图入口流程", "创建入口失败：位置 %s --> %s[%u, %u]，道具 %u 出生失败\n", szSrcMapN, szTarMapN, lPosX, lPosY, SItemCont.sID);
							LG("map_entrance_flow", "create entry failed:position %s --> %s[%u, %u],item %u create failed\n", szSrcMapN, szTarMapN, lPosX, lPosY, SItemCont.sID);
						g_CDMapEntry.Del(pCEntry);
						break;
					}
				}
				// 通知源方，创建成功
				WPACKET	wpk	=GETWPACKET();
				WRITE_CMD(wpk, CMD_MT_MAPENTRY);
				WRITE_STRING(wpk, szSrcMapN);
				WRITE_STRING(wpk, szTarMapN);
				WRITE_CHAR(wpk, enumMAPENTRY_RETURN);
				WRITE_CHAR(wpk, enumMAPENTRYO_CREATE_SUC);

				BEGINGETGATE();
				GateServer	*pGateServer = NULL;
				while (pGateServer = GETNEXTGATE())
				{
					pGateServer->SendData(wpk);
					break;
				}
				if (g_cchLogMapEntry)
					//LG("地图入口流程", "创建入口成功：位置 %s --> %s[%u, %u] \n", szSrcMapN, szTarMapN, lPosX, lPosY);
					LG("map_entrance_flow", "create entry success:position %s --> %s[%u, %u] \n", szSrcMapN, szTarMapN, lPosX, lPosY);

				g_CParser.DoString("after_create_entry", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCEntry, DOSTRING_PARAM_END);
			}
			else
			{
				if (g_cchLogMapEntry)
					//LG("地图入口流程", "创建入口成功：位置 %s --> %s[%u, %u] \n", szSrcMapN, szTarMapN, lPosX, lPosY);
					LG("map_entrance_flow", "create entry error:position %s --> %s[%u, %u] \n", szSrcMapN, szTarMapN, lPosX, lPosY);
			}
		}
		break;
	case	enumMAPENTRY_SUBPLAYER:
		{
			Short	sCopyNO = READ_SHORT(pkt);
			Short	sSubNum = READ_SHORT(pkt);

			CDynMapEntryCell	*pCEntry = g_CDMapEntry.GetEntry(szSrcMapN);
			if (pCEntry)
			{
				CMapEntryCopyCell	*pCCopyInfo = pCEntry->GetCopy(sCopyNO);
				if (pCCopyInfo)
					pCCopyInfo->AddCurPlyNum(-1 * sSubNum);
			}
		}
		break;
	case	enumMAPENTRY_SUBCOPY:
		{
			Short	sCopyNO = READ_SHORT(pkt);

			CDynMapEntryCell	*pCEntry = g_CDMapEntry.GetEntry(szSrcMapN);
			if (pCEntry)
			{
				pCEntry->ReleaseCopy(sCopyNO);
			}
			// 通知源方，副本关闭成功
			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MT_MAPENTRY);
			WRITE_STRING(wpk, szSrcMapN);
			WRITE_STRING(wpk, szTarMapN);
			WRITE_CHAR(wpk, enumMAPENTRY_RETURN);
			WRITE_CHAR(wpk, enumMAPENTRYO_COPY_CLOSE_SUC);
			WRITE_SHORT(wpk, sCopyNO);

			BEGINGETGATE();
			GateServer	*pGateServer = NULL;
			while (pGateServer = GETNEXTGATE())
			{
				pGateServer->SendData(wpk);
				break;
			}
		}
		break;
	case	enumMAPENTRY_DESTROY:
		{
			CDynMapEntryCell	*pCEntry = g_CDMapEntry.GetEntry(szSrcMapN);
			if (g_cchLogMapEntry)
				//LG("地图入口流程", "收到销毁入口请求：位置 %s --> %s\n", szSrcMapN, szTarMapN);
				LG("map_entrance_flow", "receive request to destroy entry:position %s --> %s\n", szSrcMapN, szTarMapN);
			if (pCEntry)
			{
				string	strScript = "after_destroy_entry_";
				strScript += szSrcMapN;
				g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCEntry, DOSTRING_PARAM_END);
				g_CDMapEntry.Del(pCEntry);

				// 通知源方，销毁成功
				WPACKET	wpk	=GETWPACKET();
				WRITE_CMD(wpk, CMD_MT_MAPENTRY);
				WRITE_STRING(wpk, szSrcMapN);
				WRITE_STRING(wpk, szTarMapN);
				WRITE_CHAR(wpk, enumMAPENTRY_RETURN);
				WRITE_CHAR(wpk, enumMAPENTRYO_DESTROY_SUC);

				BEGINGETGATE();
				GateServer	*pGateServer = NULL;
				while (pGateServer = GETNEXTGATE())
				{
					pGateServer->SendData(wpk);
					break;
				}
				if (g_cchLogMapEntry)
					//LG("地图入口流程", "销毁入口成功：位置 %s --> %s\n", szSrcMapN, szTarMapN);
					LG("map_entrance_flow", "destroy entry success:position %s --> %s\n", szSrcMapN, szTarMapN);
			}
			else
			{
				LG("map_entrance_flow", "destroy entry error:position %s --> %s\n", szSrcMapN, szTarMapN);
			}
		}
		break;
	case	enumMAPENTRY_COPYPARAM:
		{
			CMapRes	*pCMapRes;
			SubMap	*pCMap;
			pCMapRes = FindMapByName(szTarMapN);
			if (!pCMapRes)
				break;
			pCMap = pCMapRes->GetCopy(READ_SHORT(pkt));
			if (!pCMap)
				break;
			for (dbc::Char i = 0; i < defMAPCOPY_INFO_PARAM_NUM; i++)
				pCMap->SetInfoParam(i, READ_LONG(pkt));
		}
		break;
	case	enumMAPENTRY_COPYRUN:
		{
			CMapRes	*pCMapRes;
			SubMap	*pCMap;
			pCMapRes = FindMapByName(szTarMapN);
			if (!pCMapRes)
				break;
			pCMap = pCMapRes->GetCopy(READ_SHORT(pkt));
			if (!pCMap)
				break;

			Char	chType = READ_CHAR(pkt);
			Long	lVal = READ_LONG(pkt);
			pCMapRes->SetCopyStartCondition(chType, lVal);
		}
		break;
	case	enumMAPENTRY_RETURN:
		{
			CMapRes	*pCMap = FindMapByName(szTarMapN, true);
			if (!pCMap)
				break;
			switch (READ_CHAR(pkt))
			{
			case	enumMAPENTRYO_CREATE_SUC:
				{
					pCMap->CheckEntryState(enumMAPENTRY_STATE_OPEN);
					if (g_cchLogMapEntry)
						//LG("地图入口流程", "收到入口成功创建：位置 %s --> %s\n", szSrcMapN, szTarMapN);
						LG("map_entrance_flow", "receive entry create success :position %s --> %s\n", szSrcMapN, szTarMapN);
				}
				break;
			case	enumMAPENTRYO_DESTROY_SUC:
				{
					if (g_cchLogMapEntry)
						//LG("地图入口流程", "收到入口成功销毁：位置 %s --> %s\n", szSrcMapN, szTarMapN);
						LG("map_entrance_flow", "receive entry destroy success:position %s --> %s\n", szSrcMapN, szTarMapN);
					pCMap->CheckEntryState(enumMAPENTRY_STATE_CLOSE_SUC);
				}
				break;
			case	enumMAPENTRYO_COPY_CLOSE_SUC:
				{
					pCMap->CopyClose(READ_SHORT(pkt));
				}
				break;
			default:
				break;
			}
		}
		break;
	default:
		break;
	};
T_E}
