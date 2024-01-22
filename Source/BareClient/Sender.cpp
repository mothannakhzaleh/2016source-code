#include "StdAfx.h"
#include "LoginData.h"
#include "NetModule.h"
#include "NetIF.h"
#include "SelfObject.h"
#include ".\sender.h"

#ifdef _DEBUG
#define new DEBUG_NEW
#endif

CSender::CSender(CNetIF *pNet,CPlayer *player)
{
	m_pNet=pNet;
	m_pPlayer=player;
	m_dwMoveCount=0;
}

CSender::~CSender(void)
{
}

void CSender::LoginAccountService(CLoginData *pdata)
{
	CString strPassword=pdata->GetPassword();

	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_LOGIN);

	WritePacketSequenceEncrypted(pk, m_pNet->m_AESKey, (uint8_t*)strPassword.GetString(), strPassword.GetLength());
	pk.WriteString("locale");
	pk.WriteString(pdata->GetPassport());
	pk.WriteString(pdata->GetAccountName());
	pk.WriteString("Unknown");
	pk.WriteShort(g_nClientVersion);
	m_pNet->SendPacketMessage(pk);
}

void CSender::LoginGameService()
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_BGNPLAY);
	pk.WriteString(m_pPlayer->GetMainRole().GetName());
	m_pNet->SendPacketMessage(pk);
}

void CSender::CreateCharacter()
{
	CString city;
	static volatile int i=0;
	dbc::WPacket pk	=g_pNet->GetWPacket();
	CString strName="FakeClient"+m_pPlayer->GetLoginData()->GetAccountName().Right(4);
	strName.Format("%d%d",rand(),rand());
	CRoleList *pRole=&m_pPlayer->GetRoleFormList(m_pPlayer->GetRoleCount());
	pRole->SetName(strName);
	pk.WriteCmd(CMD_CM_NEWCHA);
	pk.WriteString(strName);
	
	if constexpr (false)
	{
	  i = (i + 1) % 3;
	  if(i == 0)
	  {
		city = RES_STRING(CL_LANGUAGE_MATCH_39);
	  } else if(i == 1)
	  {
		city = RES_STRING(CL_LANGUAGE_MATCH_40);
	  } else
	  {
		city = RES_STRING(CL_LANGUAGE_MATCH_41);
	  }
	}
	else
	{ // ARGENT CITY
	  city = RES_STRING(CL_LANGUAGE_MATCH_39);
	}


	//CSystemInfo::Add(m_pPlayer->GetIndex(),"自动创建游戏角色...名字:%s",strName);
	m_pPlayer->GetPlayerMessages().AddSystemMsg("Automatically create a game character... Name: %s Birthplace: %s",strName,city);
	pk.WriteString(city);
	LOOK look;
	ZeroMemory(&look,sizeof(look));
	look.sTypeID=3;
	look.sHairID=2124;
	look.SLink[enumEQUIP_FACE]=2554;
	pk.WriteSequence(reinterpret_cast<char*>(&look),sizeof(LOOK));
	pRole->SetLook(&look);
	m_pNet->SendPacketMessage(pk);
}

void CSender::DeleteCharacter(CString strName)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_DELCHA);
	pk.WriteString(strName);
	m_pNet->SendPacketMessage(pk);
}

void CSender::EndAction()
{
	WPacket pk=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_ENDACTION);	//结束行动
	m_pNet->SendPacketMessage(pk);
}

void CSender::MoveTo(DWORD x,DWORD y)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	EndAction();
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_BEGINACTION);
	pk.WriteLong(pSelf->GetWorldID());
#ifdef defPROTOCOL_HAVE_PACKETID
	pk.WriteLong(m_dwMoveCount++);
#endif
	pk.WriteChar((byte)enumACTION_MOVE);
	POINT point[2];
	point[0].x=pSelf->GetPositionX();
	point[0].y=pSelf->GetPositionY();
	point[1].x=x;
	point[1].y=y;
	pk.WriteSequence((dbc::cChar*)point,sizeof(POINT)*2);
	m_pNet->SendPacketMessage(pk);
	//CSystemInfo::AddInfo(m_pPlayer->GetIndex(),"自己从(%.0f,%.0f)向目的坐标(%.0f,%.0f)移动",((float)point[0].x)/100,((float)point[0].y)/100,((float)x)/100,((float)y)/100);
	m_pPlayer->GetPlayerMessages().AddSystemMsg("自己从(%.0f,%.0f)向目的坐标(%.0f,%.0f)移动",((float)point[0].x)/100,((float)point[0].y)/100,((float)x)/100,((float)y)/100);
}

void CSender::AddAttribute(WORD attrID)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_SYNATTR);
	pk.WriteChar(1);
	pk.WriteShort(attrID);
	pk.WriteLong(1);
	m_pNet->SendPacketMessage(pk);
}

void CSender::TeleCommand(CString strCommand)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_SAY);
	pk.WriteSequence(strCommand, strCommand.GetLength()+1);
	m_pNet->SendPacketMessage(pk);
}

void CSender::PickupItem(DWORD worldID,DWORD handle)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_BEGINACTION);
	pk.WriteLong(pSelf->GetWorldID());
#ifdef defPROTOCOL_HAVE_PACKETID
	pk.WriteLong(m_dwMoveCount++);
#endif
	pk.WriteChar((byte)enumACTION_ITEM_PICK);
	pk.WriteLong(worldID);
	pk.WriteLong(handle);
	m_pNet->SendPacketMessage(pk);
}

void CSender::DropItem(int nIndex,WORD nNum)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_BEGINACTION);
	pk.WriteLong(pSelf->GetWorldID());
#ifdef defPROTOCOL_HAVE_PACKETID
	pk.WriteLong(m_dwMoveCount++);
#endif
	pk.WriteChar((byte)enumACTION_ITEM_THROW);
	pk.WriteShort(nIndex);
	pk.WriteShort(nNum);
	pk.WriteLong(pSelf->GetPositionX());
	pk.WriteLong(pSelf->GetPositionY());
	m_pNet->SendPacketMessage(pk);
}

void CSender::UseItem(int nIndex)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_BEGINACTION);
	pk.WriteLong(pSelf->GetWorldID());
#ifdef defPROTOCOL_HAVE_PACKETID
	pk.WriteLong(m_dwMoveCount++);
#endif
	pk.WriteChar((byte)enumACTION_ITEM_USE);
	pk.WriteShort(nIndex);
	m_pNet->SendPacketMessage(pk);
}

void CSender::UnEquip(int nIndex)
{
	CSelfObject *pSelf=m_pPlayer->GetRoleMgr().GetSelfObject();
	if (!pSelf) return;
	for (int i=0;i<pSelf->GetPacketSize();i++)
	{
		if (!pSelf->FindPacketItem(i))
		{
			dbc::WPacket pk	=g_pNet->GetWPacket();
			pk.WriteCmd(CMD_CM_BEGINACTION);
			pk.WriteLong(pSelf->GetWorldID());
#ifdef defPROTOCOL_HAVE_PACKETID
			pk.WriteLong(m_dwMoveCount++);
#endif
			pk.WriteChar((byte)enumACTION_ITEM_UNFIX);
			pk.WriteChar(nIndex);
			pk.WriteShort(i);
			m_pNet->SendPacketMessage(pk);
			break;
		}
	}
}

void CSender::Chat_Channel_Sight(CString strText)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_SAY);
	pk.WriteSequence(strText, strText.GetLength()+1);
	m_pNet->SendPacketMessage(pk);
}

void CSender::Chat_Channel_World(CString strText)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CP_SAY2ALL);
	pk.WriteString(strText);
	m_pNet->SendPacketMessage(pk);
}

void CSender::Chat_Channel_Trade(CString strText)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CP_SAY2TRADE);
	pk.WriteString(strText);
	m_pNet->SendPacketMessage(pk);
}

void CSender::Chat_Channel_Team(CString strText)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CP_SAY2TEM);
	pk.WriteString(strText);
	m_pNet->SendPacketMessage(pk);
}

void CSender::Chat_Channel_Publish(CString strText)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CP_GM1SAY);
	pk.WriteString(strText);
	m_pNet->SendPacketMessage(pk);
}

void CSender::Chat_Channel_Private(CString strTargetName,CString strText)
{
	dbc::WPacket pk	=g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CP_SAY2YOU);
	pk.WriteString(strTargetName);
	pk.WriteString(strText);
	m_pNet->SendPacketMessage(pk);
}

void CSender::SendClientRSAPrivateKey()
{
	dbc::WPacket wpk		 = g_pNet->GetWPacket();
	std::string	 PEM_encoded = Botan::X509::PEM_encode(*m_pNet->m_clientPrivateKey); // No copy
	wpk.WriteCmd(CMD_CM_RSA_HANDSHAKE_1);
	wpk.WriteString(PEM_encoded.c_str());
	m_pNet->SendPacketMessage(wpk);
}

void CSender::CreateSecondaryPassword()
{
	char szMD5[33];
	md5string("123456", szMD5);

	WPacket pk = g_pNet->GetWPacket();
	pk.WriteCmd(CMD_CM_CREATE_PASSWORD2); //结束行动
	WritePacketSequenceEncrypted(pk, m_pNet->m_AESKey, (uint8_t*)szMD5, strlen(szMD5) + 1);
	m_pNet->SendPacketMessage(pk);
}
