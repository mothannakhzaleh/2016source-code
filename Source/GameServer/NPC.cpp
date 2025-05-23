// npc.cpp Created by knight-gongjian 2004.11.19.
//---------------------------------------------------------

#include "NPC.h"
#include "SubMap.h"
#include "GameApp.h"
#include "GameAppNet.h"
#include <NpcRecord.h>
#include <CharacterRecord.h>
#include <assert.h>
#include "Script.h"
#include "lua_gamectrl.h"
//---------------------------------------------------------

// #define ROLE_DEBUG_INFO

namespace mission
{
	CTalkNpc* g_pTalkNpc = NULL;

	//-----------------------------------------------------
	// class CNpc implemented

	CNpc::CNpc()
	: CCharacter()
	{T_B
		SetType();
	T_E}

	CNpc::~CNpc()
	{T_B

	T_E}

	void CNpc::Clear()
	{T_B
		m_sScriptID = INVALID_SCRIPT_NPCHANDLE;
		m_bHasMission = FALSE;
		m_sNpcID = 0;
		m_byShowType = 0;
		memset( m_szMsgProc, 0, ROLE_MAXSIZE_MSGPROC );
#ifdef HAS_NPC_NAME
		memset( m_szName, 0, 128 );
#endif
	T_E}

	BOOL CNpc::Load( const CNpcRecord& recNpc, const CChaRecord& recChar )
	{T_B
		return FALSE;
	T_E}

	BOOL CNpc::IsMapNpc( const char szMap[], USHORT sID )
	{
		return FALSE;
	}

	HRESULT CNpc::MsgProc( CCharacter& character, RPACKET& pk )
	{T_B
		return EN_OK;
	T_E}

	BOOL CNpc::MissionProc( CCharacter& character, BYTE& byState )
	{T_B
		byState = 0;
		return TRUE;
	T_E}

	BOOL CNpc::AddNpcTrigger( WORD wID, mission::TRIGGER_EVENT e, WORD wParam1, WORD wParam2, WORD wParam3, WORD wParam4 )
	{
		return TRUE;
	}

	BOOL CNpc::EventProc( TRIGGER_EVENT e, WPARAM wParam, LPARAM lParam )
	{
		return TRUE;
	}

	//-----------------------------------------------------
	// class CTalkNpc implemented

	CTalkNpc::CTalkNpc()
	: CNpc()
	{T_B
		SetType();
		Clear();
	T_E}

	CTalkNpc::~CTalkNpc()
	{T_B

	T_E}

	void CTalkNpc::Initially() {
	CCharacter::Initially();
	memset(m_Trigger, 0, sizeof(m_Trigger));
	m_byNumTrigger = 0;
	m_sTime		   = 0;
	m_bSummoned	   = FALSE;
	}

	void CTalkNpc::Finally() {
	CCharacter::Finally();
	memset(m_Trigger, 0, sizeof(m_Trigger));
	m_byNumTrigger = 0;
	m_sTime		   = 0;
	m_bSummoned	   = FALSE;
	}


	void CTalkNpc::Clear()
	{T_B
		m_sTime = 0;
		m_bSummoned = FALSE;	
		memset(m_Trigger, 0, sizeof(m_Trigger));
	T_E}

	BOOL CTalkNpc::InitScript( const char szFunc[], const char szName[] )
	{T_B
		if( szFunc[0] == '0' ) return TRUE;

		// 初始化NPC脚本全局变量信息
		lua_getglobal( g_pLuaState, "ResetNpcInfo" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "ResetNpcInfo" );
			return FALSE;
		}

		lua_pushlightuserdata( g_pLuaState, this );
		lua_pushstring( g_pLuaState, szName );		

		//int nStatus = lua_pcall( g_pLuaState, 2, 0, lua_gettop(g_pLuaState) -3 );
		int nStatus = CParser::docall(g_pLuaState, 2, 0);
		if( nStatus )
		{
			//LG( "NpcInit", "npc[%s]的脚本初始化处理函数[ResetNpcInfo]调用失败!", szName );
			LG( "NpcInit", "npc[%s]'s script init dispose function[ResetNpcInfo]transfer failed!", szName );
			//printf( "npc[%s]的脚本初始化处理函数[ResetNpcInfo]调用失败!\n", szName );
			printf( RES_STRING(GM_NPC_CPP_00001), szName );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return FALSE;
		}
		lua_settop(g_pLuaState, 0);

		// 调用NPC初始化全局变量信息入口函数
		lua_getglobal( g_pLuaState, szFunc );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", szFunc );
			return FALSE;
		}
		
		//nStatus = lua_pcall(g_pLuaState, 0, 0, lua_gettop(g_pLuaState) - 1);
		nStatus = CParser::docall(g_pLuaState, 0, 0);
		if( nStatus )
		{
			//LG( "NpcInit", "npc[%s]的脚本数据处理函数[%s]调用失败!", szName, szFunc );
			LG( "NpcInit", "npc[%s]'s script data dispose function[%s]transfer failed!", szName, szFunc );
			//printf( "npc[%s]的脚本数据处理函数[%s]调用失败!\n", szName, szFunc );
			//printf( RES_STRING(GM_NPC_CPP_00002), szName, szFunc );
			char szData[128];
			CFormatParameter param(2);
			param.setString( 0, szName );
			param.setString( 1, szFunc );
			RES_FORMAT_STRING( GM_NPC_CPP_00002, param, szData );
			printf( szData );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return FALSE;
		}
		lua_settop(g_pLuaState, 0);

		// 获取NPC的对话信息和交易信息
		lua_getglobal( g_pLuaState, "GetNpcInfo" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "GetNpcInfo" );
			return FALSE;
		}

		lua_pushlightuserdata( g_pLuaState, this );
		lua_pushstring( g_pLuaState, szName );

		//nStatus = lua_pcall(g_pLuaState, 2, 0, lua_gettop(g_pLuaState) - 3);
		nStatus = CParser::docall(g_pLuaState, 2, 0);
		if( nStatus )
		{
			//LG( "NpcInit", "npc[%s]的脚本初始化处理函数[GetNpcInfo]调用失败!", szName );
			LG( "NpcInit", "npc[%s]'s script init dispose function[GetNpcInfo]transfer failed!", szName );
			//printf( "npc[%s]的脚本初始化处理函数[GetNpcInfo]调用失败!\n", szName );
			printf(RES_STRING(GM_NPC_CPP_00003), szName );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return FALSE;
		}
		lua_settop(g_pLuaState, 0);

#ifdef HAS_NPC_NAME
		//strcpy( m_szName, szName );
		strncpy_s( m_szName, sizeof(m_szName), szName, _TRUNCATE );
#else
		strncpy_s( m_name, sizeof(m_name), szName, _TRUNCATE );
#endif
		return TRUE;
	T_E}

	BOOL CTalkNpc::Load( const CNpcRecord& recNpc, const CChaRecord& recChar )
	{T_B
		Clear();
		// 设置npc为未激活状态
		SetEyeshotAbility( false );	

		// 初始化npc脚本信息
		InitScript( recNpc.szMsgProc, recNpc.szName );
		
		// npc配置表编号
		m_sNpcID = recNpc.nID;

		// 
		//strncpy( m_name, recNpc.szName, 32 - 1 );
		strncpy_s( m_name, sizeof(m_name), recNpc.szName, _TRUNCATE );
		//strncpy( m_szMsgProc, recNpc.szMsgProc, ROLE_MAXSIZE_MSGPROC - 1 );
		strncpy_s( m_szMsgProc, sizeof(m_szMsgProc), recNpc.szMsgProc, _TRUNCATE );

		m_ID = g_pGameApp->m_Ident.GetID();
		Char szLogName[defLOG_NAME_LEN] = "";
		//sprintf(szLogName, "Cha-%s+%u", GetName(), GetID());
		_snprintf_s(szLogName,sizeof(szLogName),_TRUNCATE, "Cha-%s+%u", GetName(), GetID());

		m_CLog.SetLogName(szLogName);

		m_pCChaRecord = (CChaRecord*)&recChar;
		m_cat = (short)m_pCChaRecord->lID;
		m_byShowType = recNpc.byShowType;
		SetAngle( recNpc.sDir );

		m_CChaAttr.Init( recNpc.sCharID );
		setAttr(ATTR_CHATYPE, enumCHACTRL_NPC);
		
		return TRUE;
	T_E}

	BOOL CTalkNpc::Load( const char szNpcScript[] )
	{T_B		
		return TRUE;
	T_E}

	BOOL CTalkNpc::IsMapNpc( const char szMap[], USHORT sID )
	{T_B
		assert( GetSubMap() != NULL );
		return strcmp( szMap, GetSubMap()->GetName() ) == 0 && m_sNpcID == sID;
	T_E}

	HRESULT CTalkNpc::MsgProc( CCharacter& character, RPACKET& packet )
	{T_B
		//if( m_sScriptID == INVALID_SCRIPT_NPCHANDLE )
		//	return EN_OK;
		
		// 判断是否在交易状态
		if( character.GetTradeData() )
		{
			//character.SystemNotice( "你正在和其他角色交易，不可以和npc对话!" );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00004) );
			return EN_FAILER;
		}

		if( character.GetBoat() )
		{
			//character.SystemNotice( "你正在造船，不可以和npc对话!" );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00005));
			return EN_FAILER;
		}

		if( character.GetStallData() )
		{
			//character.SystemNotice( "你正在摆摊，不可以和npc对话!" );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00006) );
			return EN_FAILER;
		}

		if( !GetActControl(enumACTCONTROL_TALKTO_NPC) )
		{
			//character.SystemNotice( "现在不可以和npc对话!" );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00007) );
			return EN_FAILER;
		}

		// 判断是否在交易状态
		if( character.GetKitbag()->IsLock() || !character.GetActControl(enumACTCONTROL_ITEM_OPT) )
		{
			//character.SystemNotice( "你的背包已被锁定，不可以和npc对话!" );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00008) );
			return EN_FAILER;
		}

		// 检测角色是否在npc20米范围内
		//if( !IsDist( GetShape().centre.x, GetShape().centre.y, character.GetShape().centre.x, 
		//	character.GetShape().centre.y, 20 ) )
		//{
		//	return EN_FAILER;
		//}

		// 调用NPC脚本对话处理函数
		lua_getglobal( g_pLuaState, "NpcProc" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "NpcProc" );
			return FALSE;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)&character );
		lua_pushlightuserdata( g_pLuaState, (void*)this );
		lua_pushlightuserdata( g_pLuaState, (void*)&packet );
		lua_pushnumber( g_pLuaState, m_sScriptID );

		//int nStatus = lua_pcall( g_pLuaState, 4, 0, 0 );
		int nStatus = CParser::docall(g_pLuaState, 4, 1);
		if( nStatus )
		{
			//character.SystemNotice( "npc[%s]的脚本消息处理函数[NpcProc]调用失败!", m_name );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00009), m_name );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return EN_FAILER;
		}
		lua_settop(g_pLuaState, 0);

		return EN_OK;
	T_E}

	BOOL CTalkNpc::MissionProc( CCharacter& character, BYTE& byState )
	{T_B
		if( !m_bHasMission )
			return TRUE;

		lua_getglobal( g_pLuaState, "NpcState" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "NpcState\n" );
			return FALSE;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)&character );
		lua_pushnumber( g_pLuaState, GetID() );
		lua_pushnumber( g_pLuaState, m_sScriptID );

		//int nStatus = lua_pcall( g_pLuaState, 3, 1, 0 );
		int nStatus = CParser::docall(g_pLuaState, 3, 0);
		if( nStatus )
		{
			//character.SystemNotice( "npc[%s]的脚本任务处理函数[NpcState]调用失败!", m_name );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00010), m_name );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return FALSE;
		}

		DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
		lua_settop(g_pLuaState, 0);
		if( dwResult != LUA_TRUE )
		{
			//character.SystemNotice( "npc[%s]的任务状态处理函数[NpcState]返回失败!", m_name );
			character.SystemNotice( RES_STRING(GM_NPC_CPP_00011), m_name );
			return FALSE;
		}

		return character.GetMissionState( m_ID, byState );
	T_E}

	BOOL CTalkNpc::AddNpcTrigger( WORD wID, mission::TRIGGER_EVENT e, WORD wParam1, WORD wParam2, WORD wParam3, WORD wParam4 )
	{T_B
		if( m_byNumTrigger >= ROLE_MAXNUM_NPCTRIGGER )
			return FALSE;

		m_Trigger[m_byNumTrigger].wTID = wID;
		m_Trigger[m_byNumTrigger].byType = e;
		m_Trigger[m_byNumTrigger].wParam1 = wParam1;
		m_Trigger[m_byNumTrigger].wParam2 = wParam2;
		m_Trigger[m_byNumTrigger].wParam3 = wParam3;
		m_Trigger[m_byNumTrigger].wParam4 = wParam4;
		m_byNumTrigger++;

		return TRUE;
	T_E}

	void CTalkNpc::ClearTrigger( WORD wIndex )
	{T_B
		if( wIndex >= m_byNumTrigger )
			return;
	
		NPC_TRIGGER_DATA Info[ROLE_MAXNUM_NPCTRIGGER];
		memset( Info, 0, sizeof(NPC_TRIGGER_DATA)*ROLE_MAXNUM_NPCTRIGGER );
		memcpy( Info, m_Trigger, sizeof(NPC_TRIGGER_DATA)*m_byNumTrigger );
		memcpy( m_Trigger, Info + wIndex, sizeof(NPC_TRIGGER_DATA)*wIndex );
		memcpy( m_Trigger + wIndex, Info + wIndex + 1, sizeof(NPC_TRIGGER_DATA)*(m_byNumTrigger - wIndex - 1) );
		m_byNumTrigger--;
	T_E}

	BOOL CTalkNpc::EventProc( TRIGGER_EVENT e, WPARAM wParam, LPARAM lParam )
	{
		switch( e )
		{
		case TE_GAME_TIME:
			{
				TimeOut( (USHORT)wParam );
			}
			break;
		case TE_MAP_INIT:
		case TE_NPC:
		case TE_KILL:
		case TE_CHAT:
		case TE_GET_ITEM:
		case TE_EQUIP_ITEM:
		case TE_GOTO_MAP:
		case TE_LEVEL_UP:
		default:
			break;
		}
		return TRUE;
	}

	void CTalkNpc::TimeOut( USHORT sTime )
	{T_B
		if( m_bSummoned )
		{
			if( m_sTime > 1 )
			{
				m_sTime--;
			}
			else
			{
				m_sTime = 0;
				m_bSummoned = FALSE;
				Hide();
			}
		}

		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_GAME_TIME )
			{
				// 判断是否到达时间间隔触发
				if( ++m_Trigger[i].wParam4 < m_Trigger[i].wParam2 )
					continue;

				// lua脚本处理触发器信息
				lua_getglobal( g_pLuaState, "TriggerProc" );
				if( !lua_isfunction( g_pLuaState, -1 ) )
				{
					lua_pop( g_pLuaState, 1 );
					LG( "lua_invalidfunc", "TriggerProc" );
					return;
				}

				lua_pushlightuserdata( g_pLuaState, this );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wTID );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wParam1 );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 );

				//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
				int nStatus = CParser::docall(g_pLuaState, 4, 0);
				if( nStatus )
				{
#ifdef ROLE_DEBUG_INFO
					//printf( "CTalkNpc::TimeOut:任务处理函数[TriggerProc]调用失败!" );
					printf( RES_STRING(GM_NPC_CPP_00012) );
#endif
					//LG( "trigger_error", "CTalkNpc::TimeOut:任务处理函数[TriggerProc]调用失败!" );
					LG( "trigger_error", "CTalkNpc::TimeOut:task dispose fuction[TriggerProc]transfer failed!" );
					lua_callalert( g_pLuaState, nStatus );
					lua_settop(g_pLuaState, 0);
					continue;
				}

				DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
				lua_settop(g_pLuaState, 0);
				if( dwResult == LUA_TRUE )
				{
					// 判断清除触发器信息
					switch( m_Trigger[i].wParam1 )
					{
					case TT_CYCLETIME:
						{
							// 清除触发计数
							m_Trigger[i].wParam4 = 0;
						}
						break;
					case TT_MULTITIME:
						{
							if( m_Trigger[i].wParam3 > 0 )
							{
								m_Trigger[i].wParam3--;
								
								// 清除触发计数
								m_Trigger[i].wParam4 = 0;
							}
							else
							{
#ifdef ROLE_DEBUG_INFO
								printf( "CTalkNpc::TimeOut: clear trigger, ID = %d, Num = %d, param1 = %d, param2 = %d, param3 = %d, param4 = %d\n", 
									m_Trigger[i].wTID, m_byNumTrigger, m_Trigger[i].wParam1, m_Trigger[i].wParam1,
									m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
								// 清除触发器
								ClearTrigger( i-- );
							}
						}
						break;
					default:
						{
							//LG( "trigger_error", "未知的时间触发器时间间隔类型!" );
							LG( "trigger_error", "unknown time trigger distance taye!" );
							//printf( "CTalkNpc::未知的时间触发器时间间隔类型!Trigger ID = %d", m_Trigger[i].wTID );
							printf( RES_STRING(GM_NPC_CPP_00013), m_Trigger[i].wTID );
							ClearTrigger( i-- );
						}
						break;
					}

#ifdef ROLE_DEBUG_INFO
					printf( "CTalkNpc::TimeOut: clear trigger, ID = %d, Num = %d, param1 = %d, param2 = %d, param3 = %d, param4 = %d\n", 
						m_Trigger[i].wTID, m_byNumTrigger, m_Trigger[i].wParam1, m_Trigger[i].wParam1,
						m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
				}
			}
		}
	T_E}

	void CTalkNpc::Summoned( USHORT sTime )
	{T_B
		m_sTime = sTime;
		
		// 判断是否还没有被召唤出来
		if( m_bSummoned == FALSE )
		{
			m_bSummoned = TRUE;
			Show();
		}
	T_E}

	////-----------------------------------------------------
	//// class CTradeNpc implemented

	//CTradeNpc::CTradeNpc()
	//: CTalkNpc()
	//{T_B
	//	SetType();
	//T_E}

	//CTradeNpc::~CTradeNpc()
	//{T_B

	//T_E}

	//BOOL CTradeNpc::Sale( CCharacter& character, RPACKET& packet )
	//{T_B
	//	return TRUE;
	//T_E}

	//BOOL CTradeNpc::Buy( CCharacter& character, RPACKET& packet )
	//{T_B
	//	return TRUE;
	//T_E}

	////-----------------------------------------------------
	//// class CTradeNpc implemented

	//CRoleNpc::CRoleNpc()
	//: CTalkNpc()
	//{T_B
	//	SetType();
	//T_E}

	//CRoleNpc::~CRoleNpc()
	//{T_B

	//T_E}
	
}

