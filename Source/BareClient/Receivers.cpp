#include "StdAfx.h"
#include "BKop.h"
#include "GameThread.h"
#include "LoginData.h"
#include "MainFrm.h"
#include "ItemView.h"
#include "MainView.h"
#include "RoleObject.h"
#include "PlayerObject.h"
#include "NPCObject.h"
#include "MonsterObject.h"
#include "SelfObject.h"
#include "MonsterObject.h"
#include "NetIF.h"
#include "ServerHeader.h"
#include "GroundObject.h"
#include ".\receivers.h"


#ifdef _DEBUG
#define new DEBUG_NEW
#endif


extern short g_sKeyData;

CReceiver::CReceiver(CNetIF *pNet,CPlayer *player)
{
	m_pNet=pNet;
	m_pPlayer=player;
}

CReceiver::~CReceiver(void)
{
}

void CReceiver::OnMessageHandle(dbc::RPacket& recvbuf)
{
	if (!static_cast<bool>(recvbuf))
	{
		//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"An invalid network packet was received");
		m_pPlayer->GetPlayerMessages().AddDebugMsg("An invalid network packet was received");
		return;
	}
	WORD nCmdType = recvbuf.ReadCmd();
	DWORD dwBufLen = recvbuf.GetDataLen();
	//CString str;
	//str.Format("Packet received - keyword: %d data length:%d",nCmdType,dwBufLen);
	//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"Packet Received - Keyword: %d Data Length: %d",nCmdType,dwBufLen);
	m_pPlayer->GetPlayerMessages().AddDebugMsg("Packet Received - Keyword: %d Data Length: %d",nCmdType,dwBufLen);
	switch(nCmdType)
	{
		case CMD_MC_RSA_HANDSHAKE_1:
			{
				SC_RSAHandshake1(recvbuf);
				break;
			}
		case CMD_MC_RSA_HANDSHAKE_2:
			{
				SC_RSAHandshake2(recvbuf);
				break;
			}
		case CMD_MC_LOGIN: //Get a list of selectable characters after logging in to the character server
			{
				OnLogin(recvbuf); //All resolved
				break;
			}
		case CMD_MC_CREATE_PASSWORD2:
			{
				OnCreateSecondaryPassword(recvbuf);
				break;
			}
		case CMD_MC_NEWCHA: //Creating a Role
			{
				OnCreateCharacter(recvbuf);	//All resolved
				break;
			}
		case CMD_MC_DELCHA:					//delete role
			{
				OnDeleteCharacter(recvbuf);	//All resolved
				break;
			}
		case CMD_MC_ENTERMAP:				//Character landing map
			{
				OnEnterMap(recvbuf);
				break;
			}
		case CMD_MC_BGNPLAY:
			{
				OnError(recvbuf);
				break;
			}
		case CMD_MC_ENDPLAY:
			{
				break;
			}
		case CMD_MC_NOTIACTION:				//Character behavior (move, attack...)
			{
				OnAction(recvbuf);
				break;
			}
		case CMD_MC_CHABEGINSEE:			//Characters (players, NPCs, monsters) appear in view
			{
				SomethingAppear(recvbuf);
				break;
			}
		case CMD_MC_CHAENDSEE:				//Characters (players, NPCs, monsters) disappear from view
			{
				SomethingDisappear(recvbuf);//All resolved
				break;
			}
		case CMD_MC_ITEMBEGINSEE:			//item appears
			{
				ItemAppear(recvbuf);
				break;
			}
		case CMD_MC_ITEMENDSEE:				//item disappears
			{
				ItemDisappear(recvbuf);
				break;
			}
		case CMD_MC_SYNATTR:				//Synchronization of character attributes
			{
				SynAttribute(recvbuf);
				break;
			}
		case CMD_MC_SYSINFO:				//system channel
			{
				Chat_SystemChannel(recvbuf);
				break;
			}
		case CMD_PC_SAY2YOU:				//private chat
			{
				Chat_PrivateChannel(recvbuf);	//All resolved
				break;
			}
		case CMD_PC_SAY2TEM:				//team chat
			{
				//Chat_TeamChannel(recvbuf);
				break;
			}
		case CMD_PC_SAY2ALL:				//world
			{
				Chat_WorldChannel(recvbuf);		//All resolved
				break;
			}
		case CMD_PC_SAY2TRADE:				//trade
			{
				Chat_TradeChannel(recvbuf);		//All resolved
				break;
			}
		case CMD_PC_GM1SAY:					//announcement
			{
				Chat_PublishChannel(recvbuf);	//All resolved
				break;
			}
		case CMD_MC_SAY:					//vision
			{
				Chat_SightChannel(recvbuf);		//All resolved
				break;
			}
		case CMD_MC_QUERY_CHA:				//Query the returned content of player information through GM commands
			{
				OnGetCharacterInfo(recvbuf);
				break;
			}
		default:
			{
				//CSystemInfo::AddDetailDebugInfo(m_pPlayer->GetIndex(),"Data not interpreted - unknown packet format, discarded");
				m_pPlayer->GetPlayerMessages().AddDebugMsg("Data not interpreted - unknown packet format, discarded");
			}
	}
}

void CReceiver::OnCreateSecondaryPassword(dbc::RPacket& pk)
{
	switch(const auto error_code = pk.ReadShort())
	{
	case ERR_SUCCESS:
				m_pPlayer->m_is_new_account = false;
				m_pPlayer->SetLoginState(CPlayer::eCREATE_PASSWORD2_END);
				m_pPlayer->GetPlayerMessages().AddSystemMsg("Successfully created secondary password!");
				break;
	default:
				m_pPlayer->SetLoginState(CPlayer::eCREATE_PASSWORD2_ERROR);
				m_pPlayer->GetPlayerMessages().AddSystemMsg("Error(%d) while creating secondary password.", error_code);
				break;
	}
}

void CReceiver::OnCreateCharacter(dbc::RPacket& pk)
{
	WORD nErr=pk.ReadShort();
	if (nErr==0)
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"Successfully created game character!");
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Successfully created game character!");
		m_pPlayer->SetLoginState(CPlayer::eCREATE_CHAR_END);
		m_pPlayer->SetRoleCount(m_pPlayer->GetRoleCount()+1);
	}
	else
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"Failed to create game character!");
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Failed to create game character!");
		m_pPlayer->SetLoginState(CPlayer::eCREATE_CHAR_ERROR);
	}
}

void CReceiver::OnDeleteCharacter(dbc::RPacket& pk)
{
	WORD nErr=pk.ReadShort();
	if (nErr==0)
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"Successfully deleted game character!");
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Successfully deleted game character");
		m_pPlayer->SetLoginState(CPlayer::eDELETE_CHAR_END);
		m_pPlayer->SetRoleCount(m_pPlayer->GetRoleCount()-1);
	}
	else
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"Failed to delete game character!");
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Failed to delete game character!");
		m_pPlayer->SetLoginState(CPlayer::eDELETE_CHAR_ERROR);
	}
}

void CReceiver::OnLogin(dbc::RPacket& pk)
{
	DWORD nError=pk.ReadShort();
	if (nError==0)
	{//Landed successfully
		WORD keyBufLen=0;
		const char *keyBuf=pk.ReadSequence(keyBufLen);

		char roleCount=pk.ReadChar();
		WORD retLen=0;
		for (int i=0;i<roleCount;i++)
		{
			if (!pk.ReadChar())
			{
				i--;
				roleCount--;
				continue;
			}
			m_pPlayer->GetRoleFormList(i).SetName(pk.ReadString());
			m_pPlayer->GetRoleFormList(i).SetJobName(pk.ReadString());
			m_pPlayer->GetRoleFormList(i).SetLevel(pk.ReadShort());
			const LOOK *sLook=reinterpret_cast<const LOOK *>(pk.ReadSequence(retLen));
			if (retLen!=sizeof(LOOK))
			{
				i--;
				roleCount--;
			}
			else
			{
				m_pPlayer->GetRoleFormList(i).SetLook(sLook);
			}
		}
        char chPassword  =pk.ReadChar();
		m_pPlayer->m_is_new_account = static_cast<bool>(!chPassword);

		m_pPlayer->SetRoleCount(roleCount);
		if (m_pPlayer->GetRoleCount()>0)
		{
			//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"Successfully obtained the role list (%d people in total)",m_pPlayer->GetRoleCount());
			m_pPlayer->GetPlayerMessages().AddSystemMsg("Successfully obtained the role list (%d people in total)",m_pPlayer->GetRoleCount());
			//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝");
			m_pPlayer->GetPlayerMessages().AddDebugMsg("＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝");
			for (int i=0;i<m_pPlayer->GetRoleCount();i++)
			{
				//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"\t%d号角色－ 名字：%-16s\t职业：%s\t等级：%d",i,
				//	m_pPlayer->GetRoleFormList(i).GetName(),m_pPlayer->GetRoleFormList(i).GetJobName(),m_pPlayer->GetRoleFormList(i).Getlevel());
				m_pPlayer->GetPlayerMessages().AddDebugMsg("    Character %d - Name: %-16s Occupation: %s Level: %d",i,
					m_pPlayer->GetRoleFormList(i).GetName(),m_pPlayer->GetRoleFormList(i).GetJobName(),m_pPlayer->GetRoleFormList(i).Getlevel());
			}
			//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝");
			m_pPlayer->GetPlayerMessages().AddDebugMsg("＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝＝");
		}
		else
		{
			//CSystemInfo::AddSystemInfo(m_pPlayer->GetIndex(),"No game character found, please create a character first");
			m_pPlayer->GetPlayerMessages().AddSystemMsg("No game character found, please create a character first");
		}

		//设置密匙
		//int sKeyLen=0;
		//char sKey[1024];
		//KCHAPc chap(m_pPlayer->GetLoginData()->GetAccountName(),m_pPlayer->GetLoginData()->GetPassword());
		//chap.GetSessionClrKey((void*)keyBuf,keyBufLen,sKey,sizeof(sKey),sKeyLen);
		//sKey[sKeyLen]=0;
		//m_pNet->GetConnectKey().SetKey(sKey,pk.ReadLong());
  //      DWORD flag = pk.ReadLong();
		//char buf[20];
		//CString strInfo;
		//strInfo.Format("获得密匙[Coder=%d Len=%d]：",m_pNet->GetConnectKey().GetEncoder(),m_pNet->GetConnectKey().GetKeyLength());
		//for (int i=0;i<m_pNet->GetConnectKey().GetKeyLength();i++)
		//{
		//	sprintf(buf,"0x%02hX ",sKey[i]);
		//	strInfo+=buf;
		//}
		//CSystemInfo::AddDetailDebugInfo(m_pPlayer->GetIndex(),strInfo);
		//m_pPlayer->GetPlayerMessages().AddSystemMsg(strInfo);
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"登陆帐号服务器成功！");
		m_pPlayer->GetPlayerMessages().AddMsg("Log in to the account server successfully!");
		m_pPlayer->SetLoginState(CPlayer::eLOGON_ACCOUNT);
	}
	else
	{//登陆失败
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"登陆失败！－错误号:%d 原因:%s",nError,g_GetServerError(nError));
		m_pPlayer->GetPlayerMessages().AddMsg("Login failed! - Error number: %d Reason: %s",nError,g_GetServerError(nError));
		m_pPlayer->SetLoginState(CPlayer::eERROR_ACCOUNT);
	}
}

void CReceiver::OnError(dbc::RPacket& pk)
{
	int nError=pk.ReadShort();
	//CSystemInfo::Add(m_pPlayer->GetIndex(),"登陆失败！－错误号:%d 原因:%s",nError,g_GetServerError(nError));
	m_pPlayer->GetPlayerMessages().AddMsg("Login failed! - Error number: %d Reason: %s",nError,g_GetServerError(nError));
	m_pPlayer->SetLoginState(CPlayer::eERROR);
}

void CReceiver::ResetAllView()
{
	m_pPlayer->GetRoleMgr().ResetAll();
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_RESET_ALL,0,NULL);
	}
}

void CReceiver::RefreshAllView()
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_ALL,0,NULL);
	}
}

void CReceiver::RefreshMapPosition()
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_MAP_POSITION,0,NULL);
	}
}

void CReceiver::RefreshRoleAttribute()
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_PAGE,1,NULL);
	}
}

void CReceiver::RefreshRolePacket()
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_PAGE,4,NULL);
	}
}

void CReceiver::RefreshRoleList(CRoleObject* pRoleObject,bool bAppear)
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_ROLE,bAppear,(LPARAM)pRoleObject);
	}
}

void CReceiver::RefreshRolePosition(CRoleObject* pRoleObject)
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_ROLE_POSITION,0,(LPARAM)pRoleObject);
	}
}

void CReceiver::RefreshGroundItemList(CGroundObject* pGroundItem,bool bAppear)
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->m_hWnd,GAME_THREAD_FRESH_GROUND_ITEM,bAppear,(LPARAM)pGroundItem);
	}
}

void CReceiver::RefreshChat(CChannelChatMgr::eChannel channel)
{
	int nCurSel=((CMainFrame*)AfxGetApp()->GetMainWnd())->GetItemView()->GetSelectMainRoleIndex();
	if (nCurSel==m_pPlayer->GetIndex() && m_pPlayer->GetRoleMgr().GetSelfObject())
	{
		SendMessage(((CMainFrame*)AfxGetApp()->GetMainWnd())->GetMainView()->GetTalkPage().m_hWnd,GAME_THREAD_FRESH_CHAT,(WPARAM)channel,NULL);
	}
}

void CReceiver::OnEnterMap(dbc::RPacket& pk)
{
	WORD nError = pk.ReadShort();
	if (nError != ERR_SUCCESS)
	{
		//CSystemInfo::AddSystemInfo(m_pPlayer->GetIndex(),"登陆失败：%s",g_GetServerError(nError));
		m_pPlayer->GetPlayerMessages().AddMsg("Login failed! - Error number: %d Reason: %s",nError,g_GetServerError(nError));
		m_pPlayer->SetLoginState(CPlayer::eERROR);
		return;
	}

	// read lock status
	bool bAutoLock   = pk.ReadChar() ? true : false;	// auto lock status
	bool bKitbagLock = pk.ReadChar() ? true : false;	// Is the backpack locked

	BYTE type=pk.ReadChar();	//Whether to play switching scenes across maps
	pk.ReadChar();				//Novice or not (show novice help)
	ResetAllView();
	CString mapName=pk.ReadString();
	//m_pPlayer->GetMap().SetName();
	pk.ReadChar();				//Is it possible to form a team
	CSelfObject* pSelfObject=static_cast<CSelfObject*>(CRoleObject::CreateSelfObject(pk));
	if (!m_pPlayer->GetRoleMgr().AddSelfObject(pSelfObject))
	{
		//CSystemInfo::AddSystemInfo(m_pPlayer->GetIndex(),"严重错误！－登陆游戏服务器后获得不正确的主角信息");
		m_pPlayer->GetPlayerMessages().AddMsg("Serious error! - After logging in to the game server, you get incorrect protagonist information");
		SAFE_DELETE(pSelfObject);
	}
	pSelfObject->SetMapName(mapName);
	//CRoleList *pRole=&m_pPlayer->GetMainRole();
	//pRole->SetCharID(pSelfObject->GetCharID());
	//pRole->SetWorldID(pSelfObject->GetWorldID());
	//pRole->SetCommID(pSelfObject->GetCommID());
	//pRole->SetName(pSelfObject->GetName());
	//pRole->SetGMLv(pSelfObject->GetGMLv());
	//pRole->SetCharHandle(pSelfObject->GetHandle());
	//pRole->SetCharType(enumCHACTRL_PLAYER);
	//pRole->SetShipName(pSelfObject->GetShipName());
	//pRole->SetMottoName(pSelfObject->GetMottoName());
	//pRole->SetIconID(pSelfObject->GetIconID());
	//pRole->SetRadius(pSelfObject->GetRadiusBulk());
	//pRole->SetState(pSelfObject->GetState());
	//pRole->GetMap().SetMainRolePosX(pSelfObject->GetPositionX());
	//pRole->GetMap().SetMainRolePosY(pSelfObject->GetPositionY());
	//m_pPlayer->GetMap().SetMainRolePosX(pSelfObject->GetPositionX());
	//m_pPlayer->GetMap().SetMainRolePosY(pSelfObject->GetPositionY());
	//m_pPlayer->GetMap().SetAngle(pSelfObject->GetAngle());


	//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"世界ID：0x%X(%d)",pSelfObject->GetWorldID(),pSelfObject->GetWorldID());
	m_pPlayer->GetPlayerMessages().AddDebugMsg("world network IDID：0x%X(%d)",pSelfObject->GetWorldID(),pSelfObject->GetWorldID());
	//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"角色ID：0x%X(%d)",pSelfObject->GetCharID(),pSelfObject->GetCharID());
	m_pPlayer->GetPlayerMessages().AddDebugMsg("character ID：0x%X(%d)",pSelfObject->GetCharID(),pSelfObject->GetCharID());
	//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"网络ID：0x%X(%d)",pSelfObject->GetCommID(),pSelfObject->GetCommID());
	m_pPlayer->GetPlayerMessages().AddDebugMsg("network ID：0x%X(%d)",pSelfObject->GetCommID(),pSelfObject->GetCommID());
	//CSystemInfo::AddDebugInfo(m_pPlayer->GetIndex(),"网络句柄：0x%X(%d)",pSelfObject->GetHandle(),pSelfObject->GetHandle());
	m_pPlayer->GetPlayerMessages().AddDebugMsg("network handle：0x%X(%d)",pSelfObject->GetHandle(),pSelfObject->GetHandle());

	//CSystemInfo::Add(m_pPlayer->GetIndex(),"登陆角色名字：%s",pSelfObject->GetName());
	m_pPlayer->GetPlayerMessages().AddDebugMsg("Login role name：%s",pSelfObject->GetName());
	if (pSelfObject->GetMottoName()=="")
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"登陆角色座右铭（空）");
		m_pPlayer->GetPlayerMessages().AddDebugMsg("Login character motto (empty)");
	}
	else
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"登陆角色座右铭：%s",pSelfObject->GetMottoName());
		m_pPlayer->GetPlayerMessages().AddMsg("Login character motto：%s",pSelfObject->GetMottoName());
	}
	if (pSelfObject->GetGMLv())
	{
		//CSystemInfo::Add(m_pPlayer->GetIndex(),"注意：此帐号具有GM权限，权限等级为%d级",pSelfObject->GetGMLv());
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Note: This account has GM authority, the authority level is %d level",pSelfObject->GetGMLv());
	}
	//CSystemInfo::Add(m_pPlayer->GetIndex(),"当前位置：【地图名－%s】（%.2f，%.2f）  角度（%d）",m_pPlayer->GetMap().GetName(),m_pPlayer->GetMap().GetMainRolePosXMeter(),m_pPlayer->GetMap().GetMainRolePosYMeter(),m_pPlayer->GetMap().GetAngle());
	//CSystemInfo::Add(m_pPlayer->GetIndex(),"当前位置：【地图名－%s】（%.2f，%.2f）  角度（%d）",pSelfObject->GetMapName(),pSelfObject->GetPositionFloatX(),pSelfObject->GetPositionFloatY(),pSelfObject->GetAngle());
	m_pPlayer->GetPlayerMessages().AddSystemMsg("Current location: [Map Name - %s] (%.2f, %.2f) Angle (%d)",pSelfObject->GetMapName(),pSelfObject->GetPositionFloatX(),pSelfObject->GetPositionFloatY(),pSelfObject->GetAngle());


	//------------------------------------------------------------------------
	//	Ships and Gear Related Content - Getting Started
	//------------------------------------------------------------------------
	pSelfObject->LoadEquipItems(pk);
	//pk.ReadShort();	//ID
	//if( pk.ReadChar() == 1 ) // appearance of the ship
	//{
	//	pk.ReadShort();
	//	pk.ReadShort();
	//	pk.ReadShort();
	//	pk.ReadShort();
	//	pk.ReadShort();
	//	pk.ReadShort();
	//	pk.ReadShort();
	//}
	//else
	//{
	//	pk.ReadShort();
	//	for (int i = 0; i < enumEQUIP_NUM; i++)
	//	{
	//		pk.ReadShort();
	//		pk.ReadShort();
	//		pk.ReadShort();
	//		pk.ReadShort();
	//		pk.ReadShort();
	//		pk.ReadShort();
	//		char chForgeLv=pk.ReadChar();
	//		if (pk.ReadChar()==0)
	//			continue;
	//		if (chForgeLv>0)
	//		{
	//			for (int j = 0; j < defITEM_FORGE_ATTR_NUM; j++)
	//			{
	//				pk.ReadShort();
	//				pk.ReadShort();
	//			}
	//		}
	//		if (pk.ReadChar()) // instance attribute exists
	//		{
	//			for (int j = 0; j < defITEM_INSTANCE_ATTR_NUM; j++)
	//			{
	//				pk.ReadShort();
	//				pk.ReadShort();
	//			}
	//		}
	//	}
	//}
	//------------------------------------------------------------------------
	//	Ship and Equipment Related Content - End
	//------------------------------------------------------------------------

	//------------------------------------------------------------------------
	//	PK related content - start
	//------------------------------------------------------------------------
	pk.ReadChar();
	//------------------------------------------------------------------------
	//	PK related content - end
	//------------------------------------------------------------------------

	//------------------------------------------------------------------------
	//	Additional Appearance Related Content - Getting Started
	//------------------------------------------------------------------------
	pSelfObject->LoadAppendEquipItmes(pk);
	//------------------------------------------------------------------------
	//	Additional Appearance Related Content - End
	//------------------------------------------------------------------------


	//------------------------------------------------------------------------
	//	Get skill table content - start
	//------------------------------------------------------------------------
	pk.ReadShort();
	pk.ReadChar();
	short sSkillNum=pk.ReadShort();
	for (short i = 0; i < sSkillNum; i++)
	{
		pk.ReadShort();
		pk.ReadChar();
		pk.ReadChar();
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadShort();
		pk.ReadLong();
		if (pk.ReadShort() != enumRANGE_TYPE_NONE)
			for (short j = 1; j < defSKILL_RANGE_PARAM_NUM; j++)
				pk.ReadShort();
	}
	//------------------------------------------------------------------------
	//	Get Skill Table Contents - End
	//------------------------------------------------------------------------



	//------------------------------------------------------------------------
	//	Get skill status content - start
	//------------------------------------------------------------------------
	short sNum = pk.ReadChar();
	if ( sNum>0 )
	{
		for (int nNum = 0; nNum < sNum; nNum++)
		{
			pk.ReadChar();
			pk.ReadChar();
		}
	}
	//------------------------------------------------------------------------
	//	Get skill status content - end
	//------------------------------------------------------------------------



	//------------------------------------------------------------------------
	//	Get Character Properties - Start
	//------------------------------------------------------------------------
	char t = pk.ReadChar();	//type
	WORD nNum=pk.ReadShort();
	pSelfObject->SetMaxAvailableAttribNum(nNum);
	for (WORD i = 0; i < nNum; i++)
	{
		WORD id=pk.ReadChar();
		
		if(id==ATTR_CEXP||id==ATTR_NLEXP ||id==ATTR_CLEXP)
			pSelfObject->SetAttribute(id,pk.ReadLongLong());
		else
			pSelfObject->SetAttribute(id,(long)pk.ReadLong());
	}
	//------------------------------------------------------------------------
	//	Get Character Properties - End
	//------------------------------------------------------------------------



	//------------------------------------------------------------------------
	//	Get Items Package - Getting Started
	//------------------------------------------------------------------------
	pSelfObject->LoadPacketItems(pk);
	//------------------------------------------------------------------------
	//	Get item package - end
	//------------------------------------------------------------------------


	//CSystemInfo::Add(m_pPlayer->GetIndex(),"Log in to the game server successfully!");
	m_pPlayer->GetPlayerMessages().AddMsg("Log in to the game server successfully!");
	m_pPlayer->SetLoginState(CPlayer::eLOGON_GAME);
	RefreshAllView();
}

void CReceiver::OnAction(dbc::RPacket& pk)
{
	DWORD worldID=pk.ReadLong();
#ifdef defPROTOCOL_HAVE_PACKETID
	DWORD dwPacketId = pk.ReadLong();
#endif
	switch(pk.ReadChar())
	{
	case enumACTION_MOVE:	//character movement
		{
			WORD moveState=pk.ReadShort();
			WORD stopState=0;
			switch(moveState)
			{
			case enumMSTATE_ON:				// moving
				{
					break;
				}
			case enumMSTATE_ARRIVE:			// Stop at target point
			case enumMSTATE_BLOCK:			// Stop at an obstacle
			case enumMSTATE_CANCEL:			// Asked to stop
			case enumMSTATE_INRANGE:		// Has reasched the required range and stopped
			case enumMSTATE_NOTARGET:		// Target does not exist and stop
			case enumMSTATE_CANTMOVE:		// Can not move
				{
					stopState=pk.ReadShort();			// stop state enumEXISTS_WAITING or enumEXISTS_SLEEPING
					break;
				}
			}
			Point *psTurnPos;
			WORD walkPointsCount=0;
			psTurnPos=(Point*)pk.ReadSequence(walkPointsCount);
			walkPointsCount/=sizeof(Point);
			DWORD lastPosX=psTurnPos[walkPointsCount-1].x;
			DWORD lastPosY=psTurnPos[walkPointsCount-1].y;
			CRoleObject *object=m_pPlayer->GetRoleMgr().FindRoleObject(worldID);
			if (object==NULL)
			{
				//CSystemInfo::AddSystemInfo(m_pPlayer->GetIndex(),"发现错误：未知的角色移动！WorldID=%d,移动路点数=%d,目的坐标(%.0f,%.0f)",worldID,walkPointsCount,float(lastPosX)/100,float(lastPosY)/100);
				m_pPlayer->GetPlayerMessages().AddMsg("Error found: Unknown character move! WorldID=%d, moving waypoints=%d, destination coordinates (%.0f,%.0f)",worldID,walkPointsCount,float(lastPosX)/100,float(lastPosY)/100);
				break;
			}
			if (object->GetType()==CRoleObject::eSelf)
			{
				if (object==m_pPlayer->GetRoleMgr().GetSelfObject())
				{
					//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"自己从(%.2f,%.2f)往目标(%.0f,%.0f)移动，移动距离:%.1f",
					//	object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
					m_pPlayer->GetPlayerMessages().AddSystemMsg("Move yourself from (%.2f,%.2f) to the target (%.0f,%.0f), moving distance: %.1f",
						object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
					object->SetPosition(lastPosX,lastPosY);
					RefreshMapPosition();
				}
				else
				{
					//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"发现错误：自己在移动，但没有找到\"自己\"的对象（自己已经消失）");
					m_pPlayer->GetPlayerMessages().AddMsg("Error found: I am moving, but I did not find the object of \"I\" (I have disappeared)");
				}
				break;
			}
			else if (object->GetType()==CRoleObject::ePlayer)
			{
				//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"玩家：【%s】从(%.0f,%.0f)往目标(%.0f,%.0f)移动，移动距离:%.1f",object->GetName(),
				//	object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				m_pPlayer->GetPlayerMessages().AddSystemMsg("Player: [%s] moved from (%.0f,%.0f) to the target (%.0f,%.0f), moving distance: %.1f",object->GetName(),
					object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				if (moveState!=enumMSTATE_ON)
				{
					RefreshRolePosition(object);
				}
			}
			else if (object->GetType()==CRoleObject::eNPC)
			{
				//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"NPC【%s】从(%.0f,%.0f)往目标(%.0f,%.0f)移动，移动距离:%.1f",object->GetName(),
				//	object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				m_pPlayer->GetPlayerMessages().AddSystemMsg("NPC【%s】moves from (%.0f,%.0f) to target (%.0f,%.0f), moving distance: %.1f",object->GetName(),
						object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				if (moveState!=enumMSTATE_ON)
				{
					RefreshRolePosition(object);
				}
			}
			else if (object->GetType()==CRoleObject::eMonster)
			{
				//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"怪物【%s<%d>】从(%.0f,%.0f)往目标(%.0f,%.0f)移动，移动距离:%.1f",object->GetName(),((CMonsterObject*)object)->GetMonsterIndex(),
				//	object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				m_pPlayer->GetPlayerMessages().AddSystemMsg("The monster [%s<%d>] moves from (%.0f,%.0f) to the target (%.0f,%.0f), moving distance: %.1f",object->GetName(),((CMonsterObject*)object)->GetMonsterIndex(),
					object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				if (moveState!=enumMSTATE_ON)
				{
					RefreshRolePosition(object);
				}
			}
			else
			{
				//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"未知类型物体移动：从(%.0f,%.0f)往目标(%.0f,%.0f)移动，移动距离:%.1f",object->GetName(),
				//	object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
				m_pPlayer->GetPlayerMessages().AddSystemMsg("Unknown type of object movement: moving from (%.0f,%.0f) to the target (%.0f,%.0f), moving distance: %.1f",object->GetName(),
					object->GetPositionFloatX(),object->GetPositionFloatY(),float(lastPosX)/100,float(lastPosY)/100,object->GetDistanceInFloatTo(lastPosX,lastPosY));
			}
			object->SetPosition(lastPosX,lastPosY);
			break;
		}
	case enumACTION_KITBAG:		// Update character inventory
		{
			m_pPlayer->GetRoleMgr().GetSelfObject()->LoadPacketItems(pk);
			RefreshRolePacket();
			break;
		}
	case enumACTION_LOOK:		// Updated character appearance (ships and equipment)
		{
			m_pPlayer->GetRoleMgr().GetSelfObject()->LoadEquipItems(pk);
			break;
		}
		//------------------------------------------------------------------------
		//	not fully parsed
		//------------------------------------------------------------------------
	}
}

void CReceiver::SomethingAppear(dbc::RPacket& pk)
{
	pk.ReadChar();
	CRoleObject* roleObject=CRoleObject::CreateObject(pk);
	if (!m_pPlayer->GetRoleMgr().AddRoleObject(roleObject))
	{
		SAFE_DELETE(roleObject);
	}
	//------------------------------------------------------------------------
	//	not fully parsed
	//------------------------------------------------------------------------
	RefreshRoleList(roleObject,true);
}

void CReceiver::SomethingDisappear(dbc::RPacket& pk)
{
	pk.ReadChar();
	DWORD dwWorldID=pk.ReadLong();
	CRoleObject* roleObject=m_pPlayer->GetRoleMgr().FindRoleObject(dwWorldID);
	if (!roleObject)
	{
		CSystemInfo::AddSystemInfo(m_pPlayer->GetIndex(),"mistake! A non-existent character disappears");
		m_pPlayer->GetPlayerMessages().AddMsg("mistake! A non-existent character disappears");
		return;
	}
	RefreshRoleList(roleObject,false);
	m_pPlayer->GetRoleMgr().DeleteObject(dwWorldID);
}

void CReceiver::ItemAppear(dbc::RPacket& pk)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	CGroundObject *pGroundItem=new CGroundObject(pk);
	//pGroundItem->SetWorldID(pk.ReadLong());
	//pGroundItem->SetHandle(pk.ReadLong());
	//pGroundItem->SetItemID(pk.ReadLong());
	//DWORD x=pk.ReadLong();
	//DWORD y=pk.ReadLong();
	//pGroundItem->SetPosition(x,y);
	//pGroundItem->SetAngle(pk.ReadShort());
	//pGroundItem->SetTotalNum(pk.ReadShort());
	//pk.ReadShort();	//事件编号
	//pGroundItem->SetAppearCause((EItemAppearType)pk.ReadChar());
	//pGroundItem->SetOwnerWorldID(pk.ReadLong());
	pSelf->AddGroundItem(pGroundItem);
	RefreshGroundItemList(pGroundItem,true);
}

void CReceiver::ItemDisappear(dbc::RPacket& pk)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	DWORD dwWorldId=pk.ReadLong();
	CGroundObject* pGroundItem=pSelf->FindGroundItem(dwWorldId);
	RefreshGroundItemList(pGroundItem,false);
	pSelf->DeleteGroundItem(dwWorldId);
}

void CReceiver::SynAttribute(dbc::RPacket& pk)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf)
	{
		return;
	}
	DWORD worldID=pk.ReadLong();
	if (pSelf->GetWorldID()!=worldID)
	{
		return;
	}
	pk.ReadChar();	//type
	WORD nNum=pk.ReadShort();
	pSelf->SetMaxAvailableAttribNum(nNum);
	for (WORD i = 0; i < nNum; i++)
	{
		WORD id=pk.ReadChar();
		long var=pk.ReadLong();
		pSelf->SetAttribute(id,var);
	}
	RefreshRoleAttribute();
}

void CReceiver::Chat_SystemChannel(dbc::RPacket& pk)
{
	WORD len;
	CString strInfo=pk.ReadSequence(len);
	m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_SYSTEM,NULL,strInfo);
	RefreshChat(CChannelChatMgr::CHANNEL_SYSTEM);
	m_pPlayer->SetTotalPlayerCount(strInfo);
}

void CReceiver::Chat_PrivateChannel(dbc::RPacket& pk)
{
	CString strSrcName=pk.ReadString();
	CString strDesName=pk.ReadString();
	CString strInfo=pk.ReadString();
	CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (strSrcName.IsEmpty() && strDesName.IsEmpty() && strInfo.IsEmpty())
	{
		return;
	}
	if (pSelf && pSelf->GetName()==strSrcName)
	{
		strInfo="<To "+strDesName+">:"+strInfo;
		m_pPlayer->GetChatMgr().GetPrivateRivalMgr().OnRivalMessage(strDesName,true);
		m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_PRIVATE,strDesName,strInfo);
	}
	else
	{
		strInfo="<From "+strSrcName+">:"+strInfo;
		m_pPlayer->GetChatMgr().GetPrivateRivalMgr().OnRivalMessage(strSrcName,false);
		m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_PRIVATE,strSrcName,strInfo);
	}
	RefreshChat(CChannelChatMgr::CHANNEL_PRIVATE);
}

void CReceiver::Chat_WorldChannel(dbc::RPacket& pk)
{
	CString strSrcName=pk.ReadString();
	CString strInfo=pk.ReadString();
	strInfo=strSrcName+":"+strInfo;
	m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_WORLD,strSrcName,strInfo);
	RefreshChat(CChannelChatMgr::CHANNEL_WORLD);
}

void CReceiver::Chat_TradeChannel(dbc::RPacket& pk)
{
	CString strSrcName=pk.ReadString();
	CString strInfo=pk.ReadString();
	strInfo=strSrcName+":"+strInfo;
	m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_TRADE,strSrcName,strInfo);
	RefreshChat(CChannelChatMgr::CHANNEL_TRADE);
}

void CReceiver::Chat_PublishChannel(dbc::RPacket& pk)
{
	CString strSrcName=pk.ReadString();
	CString strInfo=pk.ReadString();
	strInfo=strSrcName+":"+strInfo;
	m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_PUBLISH,strSrcName,strInfo);
	RefreshChat(CChannelChatMgr::CHANNEL_PUBLISH);
}

void CReceiver::Chat_SightChannel(dbc::RPacket& pk)
{
	DWORD dwSrcID=pk.ReadLong();
	CString strInfo=pk.ReadString();
	CPlayerObject* pPlayerObject=m_pPlayer->GetRoleMgr().FindInPlayerList(dwSrcID);
	CNPCObject* pNPCObject=m_pPlayer->GetRoleMgr().FindInNPCList(dwSrcID);
	CMonsterObject* pMonsterObject=m_pPlayer->GetRoleMgr().FindInMonsterList(dwSrcID);
	if (pPlayerObject)
	{
		strInfo=pPlayerObject->GetName()+":"+strInfo;
		m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_SIGHT,pPlayerObject->GetName(),strInfo);
	}
	else if (pNPCObject)
	{
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Warning: Found NPC talking! WorldID=%d content=%s",dwSrcID,strInfo);
		strInfo=pNPCObject->GetName()+"(NPC):"+strInfo;
		m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_SIGHT,pNPCObject->GetName(),strInfo);
	}
	else if (pMonsterObject)
	{
		m_pPlayer->GetPlayerMessages().AddSystemMsg("Warning: Found a monster talking! WorldID=%d content=%s",dwSrcID,strInfo);
		strInfo=pMonsterObject->GetName()+"(怪物):"+strInfo;
		m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_SIGHT,pMonsterObject->GetName(),strInfo);
	}
	else
	{
		CSelfObject* pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
		if (!pSelf || pSelf->GetWorldID()!=dwSrcID)
		{
			m_pPlayer->GetPlayerMessages().AddSystemMsg("Warning: An unknown object is found speaking in the field of vision, discard it! WorldID=%d Content=%s",dwSrcID,strInfo);
			return;
		}
		strInfo=pSelf->GetName()+"(Own):"+strInfo;
		m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_SIGHT,pSelf->GetName(),strInfo);
	}
	RefreshChat(CChannelChatMgr::CHANNEL_SIGHT);
}

void CReceiver::OnGetCharacterInfo(dbc::RPacket& pk)
{
	DWORD dwSelfID=pk.ReadLong();
	CString strCharName=pk.ReadString();
	CString strMapName=pk.ReadString();
	DWORD dwPosX=pk.ReadLong();
	DWORD dwPosY=pk.ReadLong();
	DWORD dwCharID=pk.ReadLong();				//Repeat send
	CString strInfo;
	strInfo.Format("Query role [%s] succeeded! Character ID: %d Map: %s Coordinates (%.2f,%.2f)",strCharName,dwCharID,strMapName,((float)dwPosX)/100,((float)dwPosY)/100);
	m_pPlayer->GetChatMgr().GetChannelChatMgr().AddInfo(CChannelChatMgr::CHANNEL_SYSTEM,NULL,strInfo);
	RefreshChat(CChannelChatMgr::CHANNEL_SYSTEM);
}

void CReceiver::SC_RSAHandshake1(dbc::RPacket& pk)
{
	//CGameApp::Waiting(true, "Securing connection...");
	dbc::uShort				 len;
	const char*			 pemKey = pk.ReadString(&len);
	std::vector<uint8_t> input(pemKey, pemKey + sizeof(uint8_t) * len);
	m_pNet->m_srvPublicKey = Botan::X509::load_key(input);

	m_pPlayer->SetLoginState(CPlayer::eLOGIN_HANDSHAKE);
}

void CReceiver::SC_RSAHandshake2(dbc::RPacket& pk)
{
	dbc::uShort					  len_aes;
	const char*					  encrypted_aes_key = pk.ReadSequence(len_aes);
	dbc::uShort					  len_iv;
	const char*					  encrypted_iv = pk.ReadSequence(len_iv);
	dbc::uShort					  test_len;
	const char*					  encrypted_test = pk.ReadSequence(test_len);
	Botan::AutoSeeded_RNG		  rng;
	Botan::PK_Decryptor_EME		  dec(*m_pNet->m_clientPrivateKey, rng, "OAEP(SHA-256)");
	Botan::secure_vector<uint8_t> decrypted_aes = dec.decrypt((uint8_t*)encrypted_aes_key, len_aes);
	Botan::secure_vector<uint8_t> decrypted_iv	= dec.decrypt((uint8_t*)encrypted_iv, len_iv);

	// Store AES + last nonce used
	// Always regenerate IV and send it as plaintext along encrypted text.
	memcpy(m_pNet->m_AESKey, decrypted_aes.data(), decrypted_aes.size());
	memcpy(m_pNet->m_IV, decrypted_iv.data(), decrypted_iv.size());

	m_pPlayer->SetLoginState(CPlayer::eLOGON_GROUP);
}

