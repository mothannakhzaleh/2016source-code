
#ifndef _GAMEAPPNET_H_
#define _GAMEAPPNET_H_

// 通用数据

#include "stdafx.h" //add by alfred.shi 20080313

#include "NetRetCode.h"
#include "PreAlloc.h"
#include "point.h"
#include "gtplayer.h"

#define NETMSG_INVALID_MSG      0
#define NETMSG_GATE_CONNECTED   100
#define NETMSG_GATE_DISCONNECT  101
#define NETMSG_PACKET           200

#define EXCEPTION()	LG("EXCEPTION", "Exception：File %s，Line %d。\n", __FILE__, __LINE__)

inline const char* g_GameGateConnError( int error_code )
{
    switch( error_code )
    {
    /*case ERR_TM_OVERNAME:	return "GameServer名重复";
    case ERR_TM_OVERMAP:	return "GameServer上地图名重复";
    case ERR_TM_MAPERR:		return "GameServer地图配置语法错误";
    default:                return "未知错误";*/
	case ERR_TM_OVERNAME:	return RES_STRING(GM_GAMEAPPNET_H_00001);
    case ERR_TM_OVERMAP:	return RES_STRING(GM_GAMEAPPNET_H_00002);
    case ERR_TM_MAPERR:		return RES_STRING(GM_GAMEAPPNET_H_00003);
    default:                return RES_STRING(GM_GAMEAPPNET_H_00004);
    }
}



// 不同网络底层数据结构和类型抽象
#include "GameServerApp.h"

#define GETGMSVRNAME() g_gmsvr->GetName()
#define ADDPLAYER(ply, pGate, gtaddr) g_gmsvr->AddPlayer(ply, pGate, gtaddr)
#define DELPLAYER(ply) g_gmsvr->DelPlayer(ply)
#define KICKPLAYER(ply, time) g_gmsvr->KickPlayer(ply, time)
#define PEEKPACKET(ms) g_gmsvr->PeekPacket(ms)
#define DISCONNECT(sk) g_gmsvr->Disconnect(sk)
#define ISVALIDGATE(i) g_gmsvr->IsValidGate(i)
#define BEGINGETPLAYER(pGate) g_gmsvr->BeginGetplayer(pGate)
#define GETNEXTPLAYER(pGate) g_gmsvr->GetNextPlayer(pGate)
#define GETPLAYERCOUNT(pGate) pGate->GetPlayerCount()

#define SENDTOWORLD(pkt) g_gmsvr->SendToWorld(pkt)
#define SENDTOGROUP(pkt) g_gmsvr->SendToGroup(pkt);
#define SENDTOCLIENT(pkt, l) g_gmsvr->SendToClient(pkt, l)
#define SENDTOCLIENT2(pkt, n, a) g_gmsvr->SendToClient(pkt, n, a)
#define SENDTOSINGLE(pkt, l) g_gmsvr->SendToClient(l, pkt)
#define SENDTOGAME(pkt, p) g_gmsvr->SendToGame(pkt, p)

#define WPACKET WPacket
#define RPACKET RPacket
#define VALIDRPACKET(pkt) (true)

#define GETWPACKET() g_gmsvr->GetWPacket()
#define RETRPACKET(pkt)
#define WRITE_CMD(pkt, cmd) pkt.WriteCmd(cmd)
#define WRITE_CHAR(pkt, c) pkt.WriteChar(c)
#define WRITE_SHORT(pkt, s) pkt.WriteShort(s)
#define WRITE_LONG(pkt, l) pkt.WriteLong(l)
#define WRITE_LONGLONG(pkt, l) pkt.WriteLongLong(l)
#define WRITE_SEQ(pkt, seq, len) pkt.WriteSequence(seq, len)
#define WRITE_STRING(pkt, str) pkt.WriteString(str)
#define READ_CMD(pkt) pkt.ReadCmd()
#define READ_CHAR(pkt) pkt.ReadChar()
#define READ_SHORT(pkt) pkt.ReadShort()
#define READ_LONG(pkt) pkt.ReadLong()
#define READ_LONGLONG(pkt) pkt.ReadLongLong()
#define READ_SEQ(pkt, len) pkt.ReadSequence(len)
#define READ_STRING(pkt) pkt.ReadString()

#define READ_LONG_R(pkt) pkt.ReverseReadLong()
#define READ_SHORT_R(pkt) pkt.ReverseReadShort()
#define READ_LONGLONG_R(pkt) pkt.ReverseReadLongLong();

#define BEGINGETGATE() g_gmsvr->BeginGetGate()
#define GETNEXTGATE() g_gmsvr->GetNextGate()


#endif // _GAMEAPPNET_H_
