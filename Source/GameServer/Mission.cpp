// Mission.cpp Created by knight-gongjian 2004.12.13.
//---------------------------------------------------------



#include "Mission.h"
#include "Character.h"
#include "Script.h"
#include "RoleCommon.h"
#include "GameAppNet.h"
#include "Player.h"
#include "lua_gamectrl.h"

#include "stdafx.h"   //add by alfred.shi 20080312
//---------------------------------------------------------
namespace mission
{

	//#define ROLE_DEBUG_INFO

	CCharMission::CCharMission()
	{T_B
	T_E}

	CCharMission::~CCharMission()
	{T_B

	T_E}

	void CCharMission::Initially()
	{T_B
		m_byNumTrigger = 0;
		m_byNumMission = 0;
		memset( m_Trigger, 0, sizeof(TRIGGER_DATA)*ROLE_MAXNUM_CHARTRIGGER );
		memset( m_Mission, 0, sizeof(MISSION_INFO)*ROLE_MAXNUM_MISSION );
		m_RoleRecord.Clear();

		memset( m_MissionState, 0, sizeof(MISSION_STATE)*ROLE_MAXNUM_INSIDE_NPCCOUNT );
		m_byStateIndex = 0;
		m_byNumState = 0;
		m_byNumGotoMap = 0;

		memset( m_MissionCount, 0, sizeof(RAND_MISSION_COUNT)*ROLE_MAXNUM_MISSIONCOUNT );
		m_byNumMisCount = 0;

		// 默认角色为在线状态
		m_byOnline = 1;
	T_E}

	void CCharMission::Finally()
	{T_B
		// 角色退出地图时，已经调用了MisClear
		/*
		m_byNumTrigger = 0;
		m_byNumMission = 0;
		memset( m_Trigger, 0, sizeof(TRIGGER_DATA)*ROLE_MAXNUM_CHARTRIGGER );
		memset( m_Mission, 0, sizeof(MISSION_INFO)*ROLE_MAXNUM_MISSION );
		m_RoleRecord.Clear();

		memset( m_MissionState, 0, sizeof(MISSION_STATE)*ROLE_MAXNUM_INSIDE_NPCCOUNT );
		m_byStateIndex = 0;
		m_byNumState = 0;
		m_byNumGotoMap = 0;

		memset( m_MissionCount, 0, sizeof(RAND_MISSION_COUNT)*ROLE_MAXNUM_MISSIONCOUNT );
		m_byNumMisCount = 0;

		// 默认角色为在线状态
		m_byOnline = 1;
		*/
	T_E}

	BOOL CCharMission::MisInit( char* pszBuf )
	{T_B

		if(pszBuf == NULL)
			return TRUE;

		int nEdition(-1), nData1(0), nData2(0), nData3(0), nData4(0), nData5(0), nData6(0), 
			nData7(0), nData8(0), nData9(0), nData10(0), nData11(0);
		char* pTemp = pszBuf;
		//sscanf( pTemp, "%d,", &nEdition );
		sscanf_s( pTemp, "%d,", &nEdition );
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:Init: Misinfo edition code = %d\n", nEdition );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;

		if( nEdition != ROLE_MIS_MISINFO_EDITION )
		{
#ifdef ROLE_DEBUG_INFO
			printf( "\nCCharMission:Init: Convert to new misinfo edition! editon code = %d\n", nEdition );
#endif
			return ConvertMissionInfo( pTemp, nEdition );
		}

		//sscanf( pTemp, "%d,", &nData1 );
		sscanf_s( pTemp, "%d,", &nData1 );
		m_byNumMission = (BYTE)nData1;
#ifdef ROLE_DEBUG_INFO
		printf( "CCharMission:Init: m_byNumMission = %d\n", m_byNumMission );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;
		if( m_byNumMission > ROLE_MAXNUM_MISSION )
			return FALSE;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			//sscanf( pTemp, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,", &nData1, &nData2, &nData3, &nData4, 
			//	&nData5, &nData6, &nData7, &nData8, &nData9, &nData10, &nData11 );
			sscanf_s( pTemp, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,", &nData1, &nData2, &nData3, &nData4, 
				&nData5, &nData6, &nData7, &nData8, &nData9, &nData10, &nData11 );

			m_Mission[i].wRoleID = (WORD)nData1;
			m_Mission[i].byState = (BYTE)nData2;
			m_Mission[i].byMisType = (BYTE)nData3;
			m_Mission[i].byType = (BYTE)nData4;
			m_Mission[i].byLevel = (BYTE)nData5;
			m_Mission[i].wItem = (WORD)nData6;
			m_Mission[i].wParam1 = (WORD)nData7;
			m_Mission[i].wParam2 = (WORD)nData8;
			m_Mission[i].dwExp = (DWORD)nData9;
			m_Mission[i].dwMoney = (DWORD)nData10;
			m_Mission[i].byNumData = (BYTE)nData11;
#ifdef ROLE_DEBUG_INFO
			printf( "\nRole:ID[%d],State[%d], MisType[%d], Type[%d], Level[%d], Item[%d], Param[%d], Param[%d], Exp[%d], Money[%d], NumData[%d]",
				m_Mission[i].wRoleID, m_Mission[i].byState, m_Mission[i].byMisType, m_Mission[i].byType, m_Mission[i].byLevel, m_Mission[i].wItem, 
				m_Mission[i].wParam1, m_Mission[i].wParam2, m_Mission[i].dwExp, m_Mission[i].dwMoney,	m_Mission[i].byNumData );
#endif

			// 查找任务标记开始信息头
			for( int n = 0; n < 11; n++  )
			{
				pTemp = strstr( pTemp, "," );
				if( pTemp == NULL ) return TRUE;
				pTemp++;
			}

			// 随机任务数据信息
			for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
			{
				//sscanf( pTemp, "%d,%d,%d,%d,%d,%d,", &nData1, &nData2, &nData3, &nData4, &nData5, &nData6 );
				sscanf_s( pTemp, "%d,%d,%d,%d,%d,%d,", &nData1, &nData2, &nData3, &nData4, &nData5, &nData6 );
				m_Mission[i].RandData[j].wParam1 = (WORD)nData1;
				m_Mission[i].RandData[j].wParam2 = (WORD)nData2;
				m_Mission[i].RandData[j].wParam3 = (WORD)nData3;
				m_Mission[i].RandData[j].wParam4 = (WORD)nData4;
				m_Mission[i].RandData[j].wParam5 = (WORD)nData5;
				m_Mission[i].RandData[j].wParam6 = (WORD)nData6;

#ifdef ROLE_DEBUG_INFO
				printf( "\n[RandData%d] %d %d %d %d %d %d", j,
					m_Mission[i].RandData[j].wParam1, 
					m_Mission[i].RandData[j].wParam2,
					m_Mission[i].RandData[j].wParam3,
					m_Mission[i].RandData[j].wParam4,
					m_Mission[i].RandData[j].wParam5,
					m_Mission[i].RandData[j].wParam6 );
#endif

				// 查找下一个记录头
				for( int n = 0; n < 6; n++  )
				{
					pTemp = strstr( pTemp, "," );
					if( pTemp == NULL ) return TRUE;
					pTemp++;
				}
			}

#ifdef ROLE_DEBUG_INFO
			printf( "\n" );
#endif

			// 任务标记信息
			for( int j = 0; j < ROLE_MAXNUM_FLAGSIZE; j++ )
			{
				//sscanf( pTemp, "%d,", &nData1 );
				sscanf_s( pTemp, "%d,", &nData1 );

				m_Mission[i].RoleInfo.szFlag[j] = (BYTE)nData1;
#ifdef ROLE_DEBUG_INFO
				printf( "%d ", m_Mission[i].RoleInfo.szFlag[j] );
#endif
				pTemp = strstr( pTemp, "," );
				if( pTemp == NULL )
					return TRUE;
				pTemp++;
			}
		}

//#ifdef ROLE_DEBUG_INFO
//		printf( "\nRecord start!\n" );
//#endif
//		for( int i = 0; i < ROLE_MAXNUM_RECORDSIZE; i++ )
//		{
//			sscanf( pTemp, "%d ", &nData1 );
//			m_RoleRecord.szID[i] = (BYTE)nData1;
//#ifdef ROLE_DEBUG_INFO
//			printf( "%d ", m_RoleRecord.szID[i] );
//#endif
//			pTemp = strstr( pTemp, " " );
//			if( pTemp == NULL ) 
//				return TRUE;
//			pTemp++;
//		}
#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		return TRUE;
	T_E}

	BOOL CCharMission::MisGetData( char* pszBuf, DWORD dwSize )
	{T_B
		if(!pszBuf)
			return FALSE;

		_snprintf_s( pszBuf,dwSize,_TRUNCATE, "%d,", ROLE_MIS_MISINFO_EDITION );

		_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf),_TRUNCATE, "%d,", m_byNumMission );
		for( int i = 0; i < m_byNumMission; i++ )
		{
			_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,", 
				m_Mission[i].wRoleID,
				m_Mission[i].byState,
				m_Mission[i].byMisType, 
				m_Mission[i].byType,
				m_Mission[i].byLevel,
				m_Mission[i].wItem,
				m_Mission[i].wParam1,
				m_Mission[i].wParam2,
				m_Mission[i].dwExp,
				m_Mission[i].dwMoney,
				m_Mission[i].byNumData
				);

			// 随机任务数据信息
			for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
			{
				_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,%d,%d,%d,%d,%d,", 
					m_Mission[i].RandData[j].wParam1, 
					m_Mission[i].RandData[j].wParam2,
					m_Mission[i].RandData[j].wParam3,
					m_Mission[i].RandData[j].wParam4,
					m_Mission[i].RandData[j].wParam5,
					m_Mission[i].RandData[j].wParam6 );
			}
			for( int j = 0; j < ROLE_MAXNUM_FLAGSIZE; j++ )
			{
				_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,", m_Mission[i].RoleInfo.szFlag[j] );
			}
		}

		if( strlen( pszBuf ) >= dwSize )
			return FALSE;

		pszBuf[strlen(pszBuf) + 1] = 0;

		return TRUE;
	T_E}

	BOOL CCharMission::MisGetDataEx( StringPoolL& pool, int index)
	{T_B
		pool[index].Printf("%d,%d,", ROLE_MIS_MISINFO_EDITION, m_byNumMission);

		for( int i = 0; i < m_byNumMission; i++ )
		{
			pool[index].Printf("%s%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,", (const char*)pool[index],
				m_Mission[i].wRoleID,
				m_Mission[i].byState,
				m_Mission[i].byMisType, 
				m_Mission[i].byType,
				m_Mission[i].byLevel,
				m_Mission[i].wItem,
				m_Mission[i].wParam1,
				m_Mission[i].wParam2,
				m_Mission[i].dwExp,
				m_Mission[i].dwMoney,
				m_Mission[i].byNumData
				);

			// 随机任务数据信息
			for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
			{
				pool[index].Printf("%s%d,%d,%d,%d,%d,%d,", (const char*)pool[index],
					m_Mission[i].RandData[j].wParam1, 
					m_Mission[i].RandData[j].wParam2,
					m_Mission[i].RandData[j].wParam3,
					m_Mission[i].RandData[j].wParam4,
					m_Mission[i].RandData[j].wParam5,
					m_Mission[i].RandData[j].wParam6 );
			}
			for( int j = 0; j < ROLE_MAXNUM_FLAGSIZE; j++ )
			{
				pool[index].Printf("%s%d,", (const char*)pool[index],m_Mission[i].RoleInfo.szFlag[j] );
			}
		}

		return TRUE;
	T_E}

	BOOL CCharMission::MisInitRecord( char* pszBuf )
	{T_B
		int nEdition(-1), nData1(0);
		char* pTemp = pszBuf;
		//sscanf( pTemp, "%d,", &nEdition );
		sscanf_s( pTemp, "%d,", &nEdition );

#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:MisInitRecord: Misinfo record edition code = %d\n", nEdition );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;

		if( nEdition != ROLE_MIS_RECORD_EDITION )
		{
#ifdef ROLE_DEBUG_INFO
			printf( "\nCCharMission:Init: Convert to new misinfo record edition! editon code = %d\n", nEdition );
#endif
			return ConvertMissionRecord( pTemp, nEdition );
		}

#ifdef ROLE_DEBUG_INFO
		printf( "\nRecord start!\n" );
#endif
		for( int i = 0; i < ROLE_MAXNUM_RECORDSIZE; i++ )
		{
			//sscanf( pTemp, "%d,", &nData1 );
			sscanf_s( pTemp, "%d,", &nData1 );

			m_RoleRecord.szID[i] = (BYTE)nData1;
#ifdef ROLE_DEBUG_INFO
			printf( "%d ", m_RoleRecord.szID[i] );
#endif
			pTemp = strstr( pTemp, "," );
			if( pTemp == NULL ) 
				return TRUE;
			pTemp++;
		}
#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		return TRUE;
	T_E}

	BOOL CCharMission::MisGetRecord( char* pszBuf, DWORD dwSize )
	{T_B
		//sprintf( pszBuf, "%d,", ROLE_MIS_RECORD_EDITION );
		_snprintf_s( pszBuf,dwSize,_TRUNCATE, "%d,", ROLE_MIS_RECORD_EDITION );
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:MisGetRecord: MisInfo record edition code = %d", ROLE_MIS_RECORD_EDITION );
#endif

#ifdef ROLE_DEBUG_INFO
		printf( "\nRecord start!\n" );
#endif
		for( int i = 0; i < ROLE_MAXNUM_RECORDSIZE; i++ )
		{
			//sprintf( pszBuf + strlen( pszBuf ), "%d,", m_RoleRecord.szID[i] );
			_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,", m_RoleRecord.szID[i] );
#ifdef ROLE_DEBUG_INFO
			printf( "%d ", m_RoleRecord.szID[i] );
#endif
		}
#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		if( strlen( pszBuf ) >= dwSize )
			return FALSE;

		pszBuf[strlen(pszBuf) + 1] = 0;

		return TRUE;
	T_E}

	BOOL CCharMission::MisGetRecordEx( StringPoolL& pool, int index)
	{T_B
		pool[index].Printf("%d,", ROLE_MIS_RECORD_EDITION );

		for( int i = 0; i < ROLE_MAXNUM_RECORDSIZE; i++ )
		{
			pool[index].Printf("%s%d,", (const char*)pool[index], m_RoleRecord.szID[i] );
		}

		return TRUE;
	T_E}

	BOOL CCharMission::MisInitTrigger( char* pszBuf )
	{T_B
		int nEdition(-1), nData1(0), nData2(0) , nData3(0), nData4(0), nData5(0), 
			nData6(0), nData7(0), nData8(0), nData9(0);

		char* pTemp = pszBuf;
		//sscanf( pszBuf, "%d,", &nEdition );
		sscanf_s( pszBuf, "%d,", &nEdition );

#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:InitTrigger: Trigger edition code = %d\n", nEdition );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;

		if( nEdition != ROLE_MIS_TRIGGER_EDITION )
		{
#ifdef ROLE_DEBUG_INFO
			printf( "\nCCharMission:InitTrigger: Convert to new trigger edition! editon code = %d\n", nEdition );
#endif
			return ConvertTriggerInfo( pTemp, nEdition );
		}

		//sscanf( pTemp, "%d,", &nData1 );
		sscanf_s( pTemp, "%d,", &nData1 );

		m_byNumTrigger = (BYTE)nData1;
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:InitTrigger: m_byNumTrigger = %d", m_byNumTrigger );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;

		if( m_byNumTrigger > ROLE_MAXNUM_CHARTRIGGER )
			return FALSE;
		for( int i = 0; i < m_byNumTrigger; i++ )
		{			
			//sscanf( pTemp, "%d,%d,%d,%d,%d,%d,%d,%d,%d,", &nData1, &nData2, &nData3, &nData4, 
			//	&nData5, &nData6, &nData7, &nData8, &nData9 );
			sscanf_s( pTemp, "%d,%d,%d,%d,%d,%d,%d,%d,%d,", &nData1, &nData2, &nData3, &nData4, 
				&nData5, &nData6, &nData7, &nData8, &nData9 );

			m_Trigger[i].wTriggerID = (WORD)nData1;
			m_Trigger[i].wMissionID = (WORD)nData2;
			m_Trigger[i].byType = (BYTE)nData3; 
			m_Trigger[i].wParam1 = (WORD)nData4;
			m_Trigger[i].wParam2 = (WORD)nData5;
			m_Trigger[i].wParam3 = (WORD)nData6;
			m_Trigger[i].wParam4 = (WORD)nData7;
			m_Trigger[i].wParam5 = (WORD)nData8;
			m_Trigger[i].wParam6 = (WORD)nData9;

#ifdef ROLE_DEBUG_INFO
			printf( "\nTriggerID[%d], MisID[%d], Type[%d], p1[%d], p2[%d], p3[%d], p4[%d], p5[%d], p6[%d]", 
				m_Trigger[i].wTriggerID, m_Trigger[i].wMissionID, m_Trigger[i].byType, 
				m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4,
				m_Trigger[i].wParam5, m_Trigger[i].wParam6 );
#endif

			for( int n = 0; n < 9; n++ )
			{
				pTemp = strstr( pTemp, "," );
				if( pTemp == NULL ) 
					return TRUE;
				pTemp++;
			}
		}
#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		m_byNumGotoMap = 0;
		for( int t = 0; t < m_byNumTrigger; t++ )
		{
			if( m_Trigger[t].byType == mission::TE_GOTO_MAP )
			{
				m_byNumGotoMap++;
			}
		}
		return TRUE;		
	T_E}

	BOOL CCharMission::MisGetTrigger( char* pszBuf, DWORD dwSize )
	{T_B
		// Add by lark.li 20090311 begin
		if(!pszBuf)
			return FALSE;
		// End

		//sprintf( pszBuf, "%d,", ROLE_MIS_TRIGGER_EDITION );
		_snprintf_s( pszBuf,dwSize,_TRUNCATE, "%d,", ROLE_MIS_TRIGGER_EDITION );
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:GetTrigger: Trigger edition code = %d", ROLE_MIS_TRIGGER_EDITION );
#endif

		//sprintf( pszBuf + strlen( pszBuf ), "%d,", m_byNumTrigger );
		_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,", m_byNumTrigger );
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:GetTrigger: m_byNumTrigger = %d", m_byNumTrigger );
#endif
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			//sprintf( pszBuf + strlen( pszBuf ), "%d,%d,%d,%d,%d,%d,%d,%d,%d,", m_Trigger[i].wTriggerID, 
			//	m_Trigger[i].wMissionID, m_Trigger[i].byType, m_Trigger[i].wParam1, m_Trigger[i].wParam2, 
			//	m_Trigger[i].wParam3, m_Trigger[i].wParam4, m_Trigger[i].wParam5, m_Trigger[i].wParam6 );
			_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,%d,%d,%d,%d,%d,%d,%d,%d,", m_Trigger[i].wTriggerID, 
				m_Trigger[i].wMissionID, m_Trigger[i].byType, m_Trigger[i].wParam1, m_Trigger[i].wParam2, 
				m_Trigger[i].wParam3, m_Trigger[i].wParam4, m_Trigger[i].wParam5, m_Trigger[i].wParam6 );

#ifdef ROLE_DEBUG_INFO
			printf( "\nTriggerID[%d], MisID[%d], Type[%d], p1[%d], p2[%d], p3[%d], p4[%d], p5[%d], p6[%d]", 
				m_Trigger[i].wTriggerID, m_Trigger[i].wMissionID, m_Trigger[i].byType, 
				m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4,
				m_Trigger[i].wParam5, m_Trigger[i].wParam6 );
#endif
		}
#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		if( strlen( pszBuf ) >= dwSize )
			return FALSE;

		pszBuf[strlen(pszBuf) + 1] = 0;
		return TRUE;
		
	T_E}

	BOOL CCharMission::MisGetTriggerEx( StringPoolL& pool, int index)
	{T_B
		pool[index].Printf("%d,%d,", ROLE_MIS_TRIGGER_EDITION , m_byNumTrigger);

		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			pool[index].Printf("%s%d,%d,%d,%d,%d,%d,%d,%d,%d,", (const char*)pool[index], m_Trigger[i].wTriggerID, 
				m_Trigger[i].wMissionID, m_Trigger[i].byType, m_Trigger[i].wParam1, m_Trigger[i].wParam2, 
				m_Trigger[i].wParam3, m_Trigger[i].wParam4, m_Trigger[i].wParam5, m_Trigger[i].wParam6 );

		}
		return TRUE;
		
	T_E}

	BOOL CCharMission::MisInitMissionCount( char* pszBuf )
	{T_B
		// 角色离线不需读出该信息
		//if( m_byOnline == 0 )
		//	return TRUE;

		int nData1(0), nData2(0), nData3(0), nEdition(-1);
		char* pTemp = pszBuf;
		//sscanf( pszBuf, "%d,", &nEdition );
		sscanf_s( pszBuf, "%d,", &nEdition );

#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:InitMissionCount: MisCount edition code = %d\n", nEdition );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;

		if( nEdition != ROLE_MIS_MISCOUNT_EDITION )
		{
#ifdef ROLE_DEBUG_INFO
			printf( "\nCCharMission:InitMissionCount: Convert to new miscount edition! editon code = %d\n", nEdition );
#endif
			return ConvertMisCountInfo( pTemp, nEdition );
		}

		//sscanf( pTemp, "%d,", &nData1 );
		sscanf_s( pTemp, "%d,", &nData1 );

		m_byNumMisCount = (BYTE)nData1;
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:InitMissionCount: m_byNumMisCount = %d", m_byNumMisCount );
#endif
		pTemp = strstr( pTemp, "," );
		if( pTemp == NULL ) return TRUE;
		pTemp++;

		if( m_byNumMisCount > ROLE_MAXNUM_MISSIONCOUNT )
			return FALSE;

		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			//sscanf( pTemp, "%d,%d,%d,", &nData1, &nData2, &nData3 );
			sscanf_s( pTemp, "%d,%d,%d,", &nData1, &nData2, &nData3 );

			m_MissionCount[i].wRoleID = (WORD)nData1;
			m_MissionCount[i].wCount  = (WORD)nData2;
			m_MissionCount[i].wNum  = (WORD)nData3;

#ifdef ROLE_DEBUG_INFO
			printf( "\nCCharMission:InitMissionCount: wRoleID[%d], wCount[%d], wNum[%d]", m_MissionCount[i].wRoleID, 
				m_MissionCount[i].wCount, m_MissionCount[i].wNum );
#endif
			for( int n = 0; n < 3; n++ )
			{
				pTemp = strstr( pTemp, "," );
				if( pTemp == NULL ) return TRUE;
				pTemp++;
			}
		}

#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		return TRUE;		
	T_E}

	BOOL CCharMission::MisGetMissionCount( char* pszBuf, DWORD dwSize )
	{T_B
		// 角色离线不需存储该信息
		//if( m_byOnline == 0 )
		//	return TRUE;

		// Add by lark.li 20090311 begin
		if(!pszBuf)
			return FALSE;
		// End

		//sprintf( pszBuf, "%d,", ROLE_MIS_MISCOUNT_EDITION );
		_snprintf_s( pszBuf,dwSize,_TRUNCATE, "%d,", ROLE_MIS_MISCOUNT_EDITION );
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:GetMissionCount: MisCount edition code = %d", ROLE_MIS_TRIGGER_EDITION );
#endif

		//sprintf( pszBuf + strlen( pszBuf ), "%d,", m_byNumMisCount );
		_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,", m_byNumMisCount );
#ifdef ROLE_DEBUG_INFO
		printf( "\nCCharMission:GetMissionCount: m_byNumMisCount = %d", m_byNumMisCount );
#endif
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			//sprintf( pszBuf + strlen( pszBuf ), "%d,%d,%d,", m_MissionCount[i].wRoleID, m_MissionCount[i].wCount, 
			//	m_MissionCount[i].wNum );
			_snprintf_s( pszBuf + strlen( pszBuf ),dwSize - strlen( pszBuf ),_TRUNCATE, "%d,%d,%d,", m_MissionCount[i].wRoleID, m_MissionCount[i].wCount, 
				m_MissionCount[i].wNum );

#ifdef ROLE_DEBUG_INFO
			printf( "\nCCharMission:GetMissionCount: wRoleID[%d], wCount[%d], wNum[%d]", m_MissionCount[i].wRoleID, 
				m_MissionCount[i].wCount, m_MissionCount[i].wNum );
#endif
		}
#ifdef ROLE_DEBUG_INFO
		printf( "\n" );
#endif
		if( strlen( pszBuf ) >= dwSize )
			return FALSE;

		pszBuf[strlen(pszBuf) + 1] = 0;
		return TRUE;		
	T_E}

	BOOL CCharMission::MisGetMissionCountEx( StringPoolL& pool, int index)
	{T_B
		pool[index].Printf( "%d,%d,", ROLE_MIS_MISCOUNT_EDITION, m_byNumMisCount );

		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			pool[index].Printf("%s%d,%d,%d,", (const char*)pool[index], m_MissionCount[i].wRoleID, m_MissionCount[i].wCount, 
				m_MissionCount[i].wNum );

		}
		return TRUE;		
	T_E}

	BOOL CCharMission::ConvertMissionRecord( const char* pszBuf, int nEdition )
	{T_B
		m_RoleRecord.Clear();
		return TRUE;
	T_E}

	BOOL CCharMission::ConvertMissionInfo( const char* pszBuf, int nEdition )
	{T_B
		m_byNumMission = 0;
		memset( m_Mission, 0, sizeof(MISSION_INFO)*ROLE_MAXNUM_MISSION );
		return TRUE;
	T_E}

	BOOL CCharMission::ConvertTriggerInfo( const char* pszBuf, int nEdition )
	{T_B
		m_byNumTrigger = 0;
		memset( m_Trigger, 0, sizeof(TRIGGER_DATA)*ROLE_MAXNUM_CHARTRIGGER );
		return TRUE;
	T_E}

	BOOL CCharMission::ConvertMisCountInfo( const char* pszBuf, int nEdition )
	{T_B
		m_byNumMisCount = 0;
		memset( m_MissionCount, 0, sizeof(RAND_MISSION_COUNT)*ROLE_MAXNUM_MISSIONCOUNT );
		return TRUE;
	T_E}

	void CCharMission::MisClear()
	{T_B
		m_byNumTrigger = 0;
		memset( m_Trigger, 0, sizeof(TRIGGER_DATA)*ROLE_MAXNUM_CHARTRIGGER );

		// 清除所有任务并且同步到客户段
		MISSION_INFO Info[ROLE_MAXNUM_MISSION];
		memset( Info, 0, sizeof(MISSION_INFO)*ROLE_MAXNUM_MISSION);
		memcpy( Info, m_Mission, sizeof(MISSION_INFO)*m_byNumMission ); 
		BYTE byNumMission = m_byNumMission;
		for( int n = 0; n < byNumMission; n++ )
		{
			MisCancelRole( Info[n].wRoleID );
		}

		// m_byNumMission = 0;
		// memset( m_Mission, 0, sizeof(MISSION_INFO)*ROLE_MAXNUM_MISSION );
		m_RoleRecord.Clear();

		memset( m_MissionState, 0, sizeof(MISSION_STATE)*ROLE_MAXNUM_INSIDE_NPCCOUNT );
		m_byStateIndex = 0;
		m_byNumState = 0;
		m_byNumGotoMap = 0;

		memset( m_MissionCount, 0, sizeof(RAND_MISSION_COUNT)*ROLE_MAXNUM_MISSIONCOUNT );
		m_byNumMisCount = 0;

		// 默认角色为在线状态
		m_byOnline = 1;
	T_E}

	void CCharMission::KillWare( USHORT sWareID )
	{T_B
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_KILL )
			{
				// 特定的被摧毁物件类型ID
				if( sWareID == m_Trigger[i].wParam1 )
				{
					// lua脚本处理触发器信息
					lua_getglobal( g_pLuaState, "TriggerProc" );
					if( !lua_isfunction( g_pLuaState, -1 ) )
					{
						lua_pop( g_pLuaState, 1 );
						LG( "lua_invalidfunc", "TriggerProc" );
						return;
					}

					lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
					lua_pushnumber( g_pLuaState, m_Trigger[i].wTriggerID );
					lua_pushnumber( g_pLuaState, m_Trigger[i].wParam1 ); // 怪物ID
					lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 ); // 需要摧毁怪物数量
					lua_pushnumber( g_pLuaState, m_Trigger[i].wParam3 ); // 摧毁物件标记记录起始点
					lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 );

					//int nStatus = lua_pcall( g_pLuaState, 6, 1, 0 );
					int nStatus = CParser::docall(g_pLuaState, 6, 0);
					if( nStatus )
					{
						m_pRoleChar->SystemNotice( "CCharMission::KillWare:任务处理函数[TriggerProc]调用失败！" );
						lua_callalert( g_pLuaState, nStatus );
						lua_settop(g_pLuaState, 0);
						return;
					}

					DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
					lua_settop(g_pLuaState, 0);
					if( dwResult == LUA_TRUE )
					{
						// 增加摧毁物件计数
						m_Trigger[i].wParam4++;
						WPACKET packet = GETWPACKET();
						WRITE_CMD(packet, CMD_MC_TRIGGER_ACTION );
						WRITE_CHAR(packet, m_Trigger[i].byType );
						WRITE_SHORT(packet, m_Trigger[i].wParam1 );
						WRITE_SHORT(packet, m_Trigger[i].wParam2 );
						WRITE_SHORT(packet, m_Trigger[i].wParam4 );
						m_pRoleChar->ReflectINFof( m_pRoleChar, packet );

						// 判断清除触发器信息
						if( m_Trigger[i].wParam4 >= m_Trigger[i].wParam2 )
						{
#ifdef ROLE_DEBUG_INFO
							printf( "KillWare Complete!, ID=%d, p1=%d, p2=%d, p3=%d, p4=%d\n", m_Trigger[i].wTriggerID, 
								m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
							ClearTrigger( i );
						}
					}
					else
					{
						//m_pRoleChar->SystemNotice( "CCharMission::KillWare:任务处理函数[TriggerProc]调用返回失败！" );
						m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00001) );
					}

					return;
				}
			}
		}
	T_E}

	BOOL CCharMission::MisGetItemCount( WORD wRoleID, USHORT sItemID, USHORT& sCount )
	{
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].wMissionID == wRoleID && m_Trigger[i].byType == TE_GET_ITEM )
			{
				// 特定的被摧毁物件类型ID
				if( sItemID == m_Trigger[i].wParam1 )
				{
					sCount = m_Trigger[i].wParam4;
					return TRUE;
				}
			}
		}
		return FALSE;
	}

	void CCharMission::MisRefreshItemCount( USHORT sItemID )
	{
		USHORT sCount = 0;
		USHORT sNum = m_pRoleChar->GetKitbag()->GetUseGridNum();
		SItemGrid *pGridCont;
		for( int i = 0; i < sNum; i++ )
		{
			pGridCont = m_pRoleChar->GetKitbag()->GetGridContByNum( i );
			if( pGridCont )
			{
				if( sItemID == pGridCont->sID )
				{
					sCount += (USHORT)pGridCont->sNum;
				}
			}
		}

		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_GET_ITEM )
			{
				// 特定的被摧毁物件类型ID
				if( sItemID == m_Trigger[i].wParam1 )
				{
					if( sCount >= m_Trigger[i].wParam2 )
					{
						m_Trigger[i].wParam4 = m_Trigger[i].wParam2;
					}
					else
					{
						m_Trigger[i].wParam4 = sCount;
					}

					return;
				}
			}
		}
	}

	void CCharMission::GetItem( USHORT sItemID, USHORT sCount )
	{T_B
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_GET_ITEM )
			{
				// 特定的被摧毁物件类型ID
				if( sItemID == m_Trigger[i].wParam1 )
				{
					// 触发器计数已满
					if( m_Trigger[i].wParam4 >= m_Trigger[i].wParam2 )
					{
						continue;
					}

					for( int n = 0; n < sCount; n++ )
					{
						// lua脚本处理触发器信息
						lua_getglobal( g_pLuaState, "TriggerProc" );
						if( !lua_isfunction( g_pLuaState, -1 ) )
						{
							lua_pop( g_pLuaState, 1 );
							LG( "lua_invalidfunc", "TriggerProc" );
							return;
						}

						lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
						lua_pushnumber( g_pLuaState, m_Trigger[i].wTriggerID );
						lua_pushnumber( g_pLuaState, m_Trigger[i].wParam1 ); // 物件ID
						lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 ); // 物件需求数量
						lua_pushnumber( g_pLuaState, m_Trigger[i].wParam3 ); // 获得物件标记记录起始点
						lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 );

						//int nStatus = lua_pcall( g_pLuaState, 6, 1, 0 );
						int nStatus = CParser::docall(g_pLuaState, 6, 0);
						if( nStatus )
						{
							//m_pRoleChar->SystemNotice( "CCharMission::GetItem:任务处理函数[TriggerProc]调用失败！" );
							m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00002) );
							lua_callalert( g_pLuaState, nStatus );
							lua_settop(g_pLuaState, 0);
							return;
						}

						DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
						lua_settop(g_pLuaState, 0);
						if( dwResult == LUA_TRUE )
						{
							if( ++m_Trigger[i].wParam4 >= m_Trigger[i].wParam2 )
							{
								// 余下的物品计数留给其他获取物品触发器计数
								sCount -= n;
								break;
							}
						}
						else
						{
							//m_pRoleChar->SystemNotice( "CCharMission::GetItem:任务处理函数[TriggerProc]调用返回失败！" );
							m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00004) );
						}
					}

					WPACKET packet = GETWPACKET();
					WRITE_CMD(packet, CMD_MC_TRIGGER_ACTION );
					WRITE_CHAR(packet, m_Trigger[i].byType );
					WRITE_SHORT(packet, m_Trigger[i].wParam1 );
					WRITE_SHORT(packet, m_Trigger[i].wParam2 );
					WRITE_SHORT(packet, m_Trigger[i].wParam4 );
					m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
					
					// 判断清除触发器信息
					if( m_Trigger[i].wParam4 >= m_Trigger[i].wParam2 )
					{
#ifdef ROLE_DEBUG_INFO
						printf( "GetItem Complete!, ID=%d, p1=%d, p2=%d, p3=%d, p4=%d\n", m_Trigger[i].wTriggerID, 
							m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
						// 获取任务物品计数触发器不自动清除，等待任务结束清除
						// ClearTrigger( i-- );
					}
					return;
				}
			}
		}
	T_E}

	void CCharMission::TimeOut( USHORT sTime )
	{T_B

		//m_pRoleChar->SystemNotice( "Time Out!" );

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

				lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wTriggerID );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wParam1 );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 );

				//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
				int nStatus = CParser::docall(g_pLuaState, 4, 0);
				if( nStatus )
				{
					//m_pRoleChar->SystemNotice( "CCharMission::TimeOut:任务处理函数[TriggerProc]调用失败！" );
					m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00003) );
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
								printf( "TimeOut Complete!, ID=%d, p1=%d, p2=%d, p3=%d, p4=%d\n", m_Trigger[i].wTriggerID, 
									m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
								// 清除触发器
								ClearTrigger( i-- );
							}
						}
						break;
					default:
						{
							//LG( "trigger_error", "未知的时间触发器时间间隔类型！" );
							LG( "trigger_error", "unknown time trigger time slot type！" );
							//m_pRoleChar->SystemNotice( "未知的时间触发器时间间隔类型！TID = %d, Type = %d", m_Trigger[i].wTriggerID, m_Trigger[i].wParam1 );
							//m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00005), m_Trigger[i].wTriggerID, m_Trigger[i].wParam1 );
							char szData[128];
							CFormatParameter param(2);
							param.setLong( 0, m_Trigger[i].wTriggerID );
							param.setLong( 1, m_Trigger[i].wParam1 );
							RES_FORMAT_STRING( GM_MISSION_CPP_00005, param, szData );
							m_pRoleChar->SystemNotice( szData );
							ClearTrigger( i-- );
						}
						break;
					}
				}
				else
				{
					//m_pRoleChar->SystemNotice( "CCharMission::TimeOut:任务处理函数[TriggerProc]调用返回失败！" );
					m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00004) );
				}
			}
		}
	T_E}

	void CCharMission::GotoMap( BYTE byMapID, WORD wxPos, WORD wyPos )
	{T_B
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_GOTO_MAP )
			{
				// 不在同一地图
				if( byMapID != m_Trigger[i].wParam1 )
				{
					// 已经出了目标区域
					m_Trigger[i].wParam6 = 0;
					continue;
				}
				// 不在区域内
				if( wxPos > m_Trigger[i].wParam2 && wyPos > m_Trigger[i].wParam3 && 
					wxPos < m_Trigger[i].wParam2 + m_Trigger[i].wParam4 && 
					wyPos < m_Trigger[i].wParam3 + m_Trigger[i].wParam4 )
				{
					// 已经进入了目标区域
					if( m_Trigger[i].wParam6 )
						continue;					

					// lua脚本处理触发器信息
					lua_getglobal( g_pLuaState, "TriggerProc" );
					if( !lua_isfunction( g_pLuaState, -1 ) )
					{
						lua_pop( g_pLuaState, 1 );
						LG( "lua_invalidfunc", "TriggerProc" );
						return;
					}

					lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
					lua_pushnumber( g_pLuaState, m_Trigger[i].wTriggerID );
					lua_pushnumber( g_pLuaState, 0 );
					lua_pushnumber( g_pLuaState, 0 );

					//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
					int nStatus = CParser::docall(g_pLuaState, 4, 0);
					if( nStatus )
					{
						//m_pRoleChar->SystemNotice( "CCharMission::GotoMap:任务处理函数[TriggerProc]调用失败！" );
						m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00006) );
						lua_callalert( g_pLuaState, nStatus );
						lua_settop(g_pLuaState, 0);
						continue;
					}

					DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
					lua_settop(g_pLuaState, 0);
					if( dwResult == LUA_TRUE )
					{
#ifdef ROLE_DEBUG_INFO
						printf( "GotoMap Complete!, ID=%d, p1=%d, p2=%d, p3=%d, p4=%d\n", m_Trigger[i].wTriggerID, 
							m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
						WPACKET packet = GETWPACKET();
						WRITE_CMD(packet, CMD_MC_TRIGGER_ACTION );
						WRITE_CHAR(packet, m_Trigger[i].byType );
						WRITE_SHORT(packet, m_Trigger[i].wParam1 );
						WRITE_SHORT(packet, m_Trigger[i].wParam2 );
						WRITE_SHORT(packet, m_Trigger[i].wParam3 );
						m_pRoleChar->ReflectINFof( m_pRoleChar, packet );

						if( m_Trigger[i].wParam5 )
						{
							ClearTrigger( i-- );
						}
					}
					else
					{
						//m_pRoleChar->SystemNotice( "CCharMission::GotoMap:任务处理函数[TriggerProc]调用返回失败！" );
						m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00007) );
					}

					// 设置已经到达该区域标记
					m_Trigger[i].wParam6 = 1;
				}
				else
				{
					// 已经出了目标区域
					m_Trigger[i].wParam6 = 0;
				}
			}
		}
	T_E}

	void CCharMission::LevelUp( USHORT sLevel )
	{T_B
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_LEVEL_UP )
			{
				if( m_Trigger[i].wParam2 == 1 && sLevel < m_Trigger[i].wParam1 )
					continue;

				// lua脚本处理触发器信息
				lua_getglobal( g_pLuaState, "TriggerProc" );
				if( !lua_isfunction( g_pLuaState, -1 ) )
				{
					lua_pop( g_pLuaState, 1 );
					LG( "lua_invalidfunc", "TriggerProc" );
					return;
				}

				lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wTriggerID );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wParam1 );
				lua_pushnumber( g_pLuaState, m_Trigger[i].wParam2 );

				//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
				int nStatus = CParser::docall(g_pLuaState, 4, 0);
				if( nStatus )
				{
					//m_pRoleChar->SystemNotice( "CCharMission::LevelUp:任务处理函数[TriggerProc]调用失败！" );
					m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00008) );
					lua_callalert( g_pLuaState, nStatus );
					lua_settop(g_pLuaState, 0);
					continue;
				}

				DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
				lua_settop(g_pLuaState, 0);
				if( dwResult == LUA_TRUE )
				{
#ifdef ROLE_DEBUG_INFO
					printf( "LevelUp Complete!, ID=%d, p1=%d, p2=%d, p3=%d, p4=%d\n", m_Trigger[i].wTriggerID, 
						m_Trigger[i].wParam1, m_Trigger[i].wParam2, m_Trigger[i].wParam3, m_Trigger[i].wParam4 );
#endif
					WPACKET packet = GETWPACKET();
					WRITE_CMD(packet, CMD_MC_TRIGGER_ACTION );
					WRITE_CHAR(packet, m_Trigger[i].byType );
					WRITE_SHORT(packet, m_Trigger[i].wParam1 );
					WRITE_SHORT(packet, m_Trigger[i].wParam2 );
					WRITE_SHORT(packet, 0 );
					m_pRoleChar->ReflectINFof( m_pRoleChar, packet );

					// 动作后主动关闭触发器
					if( m_Trigger[i].wParam2 )
					{
						ClearTrigger( i-- );
					}
				}
				else
				{
					//m_pRoleChar->SystemNotice( "CCharMission::LevelUp:任务处理函数[TriggerProc]调用返回失败！" );
					m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00009) );
				}
			}
		}
	T_E}

	void CCharMission::CharBorn()
	{T_B
		// lua脚本处理触发器信息
		lua_getglobal( g_pLuaState, "TriggerProc" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "TriggerProc" );
			return;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
		lua_pushnumber( g_pLuaState, 88888 );
		lua_pushnumber( g_pLuaState, 0 );
		lua_pushnumber( g_pLuaState, 0 );

		//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
		int nStatus = CParser::docall(g_pLuaState, 4, 0);
		if( nStatus )
		{
			//m_pRoleChar->SystemNotice( "CCharMission::CharBorn:任务处理函数[TriggerProc]调用失败！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00010) );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return;
		}

		DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
		lua_settop(g_pLuaState, 0);
		if( dwResult == LUA_TRUE )
		{
			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_TRIGGER_ACTION );
			WRITE_CHAR(packet, TE_MAP_INIT );
			WRITE_SHORT(packet, 0 );
			WRITE_SHORT(packet, 0 );
			WRITE_SHORT(packet, 0 );
			m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
		}
		else
		{
			//m_pRoleChar->SystemNotice( "CCharMission::CharBorn:任务处理函数[TriggerProc]调用返回失败！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00011) );
		}
	T_E}

	void CCharMission::EquipItem( USHORT sItemID, USHORT sTriID )
	{T_B
		// lua脚本处理触发器信息
		lua_getglobal( g_pLuaState, "TriggerProc" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "TriggerProc" );
			return;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
		lua_pushnumber( g_pLuaState, sTriID );
		lua_pushnumber( g_pLuaState, 0 );
		lua_pushnumber( g_pLuaState, sItemID );

		//int nStatus = lua_pcall( g_pLuaState, 4, 1, 0 );
		int nStatus = CParser::docall(g_pLuaState, 4, 0);
		if( nStatus )
		{
			//m_pRoleChar->SystemNotice( "CCharMission::EquipItem:任务处理函数[TriggerProc]调用失败！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00012) );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return;
		}

		DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
		lua_settop(g_pLuaState, 0);
		if( dwResult == LUA_TRUE )
		{
			WPACKET packet = GETWPACKET();
			WRITE_CMD(packet, CMD_MC_TRIGGER_ACTION );
			WRITE_CHAR(packet, TE_EQUIP_ITEM );
			WRITE_SHORT(packet, 0 );
			WRITE_SHORT(packet, sItemID );
			WRITE_SHORT(packet, 0 );
			m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
		}
		else
		{
			//m_pRoleChar->SystemNotice( "CCharMission::EquipItem:任务处理函数[TriggerProc]调用返回失败！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00013) );
		}
	T_E}

	// 触发器事件处理
	BOOL CCharMission::MisEventProc( TRIGGER_EVENT e, WPARAM wParam, LPARAM lParam )
	{
		switch( e )
		{
		case TE_MAP_INIT:
			{
				CharBorn();
			}
			break;
		case TE_NPC:
			break;
		case TE_KILL:
			{
				KillWare( (USHORT)wParam );
			}
			break;
		case TE_GAME_TIME:
			{
				TimeOut( (USHORT)wParam );
			}
			break;
		case TE_CHAT:
			break; 
		case TE_GET_ITEM:
			{
				GetItem( (USHORT)wParam, (USHORT)lParam );
			}
			break;
		case TE_EQUIP_ITEM:
			{
				EquipItem( (USHORT)wParam, (USHORT)lParam );
			}
			break;
		case TE_GOTO_MAP:
			{
				if( m_byNumGotoMap > 0 ) 
				{
					GotoMap( (BYTE)wParam, WORD(lParam>>16), WORD(lParam&0xffff) );
				}
			}
			break;
		case TE_LEVEL_UP:
			{
				LevelUp( USHORT(wParam) );
			}
			break;
		default:
			break;
		}

		DeleteTrigger();
		return TRUE;
	}

	BOOL CCharMission::MisNeedItem( USHORT sItemID )
	{
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byType == TE_GET_ITEM && sItemID == m_Trigger[i].wParam1)
			{
				// 判断是否任务物品数量已经足够
				return !(m_Trigger[i].wParam4 >= m_Trigger[i].wParam2);
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisAddMissionState( DWORD dwNpcID, BYTE byID, BYTE byState )
	{
		BOOL bAdd = TRUE;
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			m_byStateIndex = m_byNumState; 
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					m_byStateIndex = i;
					bAdd = FALSE;
					break;
				}
			}
		}
		else
		{
			bAdd = FALSE;
		}
		
		if( m_byStateIndex >= ROLE_MAXNUM_INSIDE_NPCCOUNT )
			return FALSE;
		if( m_MissionState[m_byStateIndex].byMisNum + 1 >= ROLE_MAXNUM_MISSIONSTATE ) 
			return FALSE;

		//if( byState & ROLE_MIS_ACCEPT )
		//{

		//}
		//else if( byState & ROLE_MIS_DELIVERY )
		//{

		//}
		//else if( byState & ROLE_MIS_PENDING )
		//{

		//}
		//else
		//{
		//	m_pRoleChar->SystemNotice( "未知的任务状态类型：npcid = 0x%X, state = %d", dwNpcID, byState );
		//	return FALSE;
		//}

		if( bAdd ) m_byNumState++;
		m_MissionState[m_byStateIndex].dwNpcID = dwNpcID;
		m_MissionState[m_byStateIndex].StateInfo[m_MissionState[m_byStateIndex].byMisNum].byID = byID;
		m_MissionState[m_byStateIndex].StateInfo[m_MissionState[m_byStateIndex].byMisNum].byState = byState;
		m_MissionState[m_byStateIndex].byMisNum++;
		m_MissionState[m_byStateIndex].byNpcState |= byState;
		return TRUE;
	}

	BOOL CCharMission::MisGetMissionState( DWORD dwNpcID, BYTE& byState )
	{
		int nIndex = -1;
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					nIndex = i;
					break;
				}
			}
		}
		else
		{
			nIndex = m_byStateIndex;
		}

		if( nIndex == -1 )
		{
			//m_pRoleChar->SystemNotice( "GetMissionState:未发现角色对应的NPC任务状态信息！该npc是否携带任务？" );
			return FALSE;
		}

		byState = m_MissionState[nIndex].byNpcState;
		return TRUE;
	}

	BOOL CCharMission::MisGetNumMission( DWORD dwNpcID, BYTE& byNum )
	{
		int nIndex = -1;
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					nIndex = i;
					break;
				}
			}
		}
		else
		{
			nIndex = m_byStateIndex;
		}

		if( nIndex == -1 )
		{
			//m_pRoleChar->SystemNotice( "GetNumMission:未知的NPC信息！" );
			return FALSE;
		}
		
		byNum = m_MissionState[nIndex].byMisNum;
		return TRUE;
	}

	BOOL CCharMission::MisGetMissionInfo( DWORD dwNpcID, BYTE byIndex, BYTE& byID, BYTE& byState )
	{		
		int nIndex = -1;
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					nIndex = i;
					break;
				}
			}
		}
		else
		{
			nIndex = m_byStateIndex;
		}

		if( nIndex == -1 )
		{
			//m_pRoleChar->SystemNotice( "GetMissionInfo:未知的NPC信息！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00014) );
			return FALSE;
		}

		if( byIndex >= m_MissionState[nIndex].byMisNum )
		{
			//m_pRoleChar->SystemNotice( "GetMissionInfo:错误的查询NPC携带任务记录索引类型信息！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00015) );
			return FALSE;
		}

		byID	= m_MissionState[nIndex].StateInfo[byIndex].byID;
		byState = m_MissionState[nIndex].StateInfo[byIndex].byState;
		return TRUE;
	}

	BOOL CCharMission::MisGetCharMission( DWORD dwNpcID, BYTE byID, BYTE& byState )
	{
		int nIndex = -1;
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					nIndex = i;
					break;
				}
			}
		}
		else
		{
			nIndex = m_byStateIndex;
		}

		if( nIndex == -1 )
		{
			//m_pRoleChar->SystemNotice( "GetMissionInfo:未知的NPC信息！dwNpcID = %d", dwNpcID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00016), dwNpcID );
			return FALSE;
		}

		int nID = -1;
		for( int i = 0; i < m_MissionState[nIndex].byMisNum; i++ )
		{
			if( m_MissionState[nIndex].StateInfo[i].byID == byID )
			{
				nID = i;
				break;
			}
		}
		byState = m_MissionState[nIndex].StateInfo[nID].byState;
		return TRUE;
	}

	BOOL CCharMission::MisGetNextMission( DWORD dwNpcID, BYTE& byIndex, BYTE& byID, BYTE& byState )
	{
		int nIndex = -1;
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					nIndex = i;
					break;
				}
			}
		}
		else
		{
			nIndex = m_byStateIndex;
		}

		if( nIndex == -1 )
		{			
			return FALSE;
		}
		
		BYTE byNumAcp = 0;
		BYTE byAccept[ROLE_MAXNUM_MISSIONSTATE];
		for( int n = 0; n < m_MissionState[nIndex].byMisNum; n++ )
		{
			if( m_MissionState[nIndex].StateInfo[n].byState == ROLE_MIS_DELIVERY )
			{
				byIndex = n;
				byID	= m_MissionState[nIndex].StateInfo[n].byID;
				byState = m_MissionState[nIndex].StateInfo[n].byState;
				return TRUE;
			}
			else if( m_MissionState[nIndex].StateInfo[n].byState == ROLE_MIS_ACCEPT )
			{
				byAccept[byNumAcp++] = n;
			}
		}

		if( byNumAcp > 0 )
		{
			byIndex = byAccept[0];
			byID	= m_MissionState[nIndex].StateInfo[byIndex].byID;
			byState = m_MissionState[nIndex].StateInfo[byIndex].byState;
			return TRUE;
		}

		return FALSE;
	}

	BOOL CCharMission::MisClearMissionState( DWORD dwNpcID )
	{
		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			for( int i = 0; i < m_byNumState; i++ )
			{
				if( m_MissionState[i].dwNpcID == dwNpcID )
				{
					m_byStateIndex = i;
					break;
				}
			}
		}

		if( m_MissionState[m_byStateIndex].dwNpcID != dwNpcID )
		{
			//m_pRoleChar->SystemNotice( "ClearMissionState:未知的NPC索引信息！" );
			return FALSE;
		}

		MISSION_STATE Info[ROLE_MAXNUM_INSIDE_NPCCOUNT];
		memset( Info, 0, sizeof(MISSION_STATE)*m_byNumState );
		memcpy( Info, m_MissionState, sizeof(MISSION_STATE)*m_byNumState );
		memset( m_MissionState, 0, sizeof(MISSION_STATE)*m_byNumState );
		memcpy( m_MissionState, Info, sizeof(MISSION_STATE)*m_byStateIndex );
		memcpy( m_MissionState + m_byStateIndex, Info + m_byStateIndex + 1, sizeof(MISSION_STATE)*( m_byNumState - m_byStateIndex - 1 ) );
		m_byNumState--;
		return TRUE;
	}

	void CCharMission::MisSetMissionPage( DWORD dwNpcID, BYTE byPrev, BYTE byNext, BYTE byState )
	{
		m_dwTalkNpcID = dwNpcID;
		m_byPrev = byPrev;
		m_byNext = byNext;
		m_byState = byState;
	}

	BOOL CCharMission::MisGetMissionPage( DWORD dwNpcID, BYTE& byPrev, BYTE& byNext, BYTE& byState )
	{
		if( dwNpcID != m_dwTalkNpcID )
			return FALSE;
		byPrev = m_byPrev;
		byNext = m_byNext;
		byState = m_byState;
		return TRUE;
	}

	void CCharMission::MisSetTempData( DWORD dwNpcID, WORD wID, BYTE byState, BYTE byMisType )
	{
		m_dwTalkNpcID = dwNpcID;
		m_wIndex  = wID;
		m_byState = byState;
		m_byMisType = byMisType;
	}

	BOOL CCharMission::MisGetTempData( DWORD dwNpcID, WORD& wID, BYTE& byState, BYTE& byMisType )
	{
		if( dwNpcID != m_dwTalkNpcID )
			return FALSE;
		byState = m_byState;
		wID		= m_wIndex;
		byMisType = m_byMisType;
		return TRUE;
	}

	BOOL CCharMission::MisAddTrigger( const TRIGGER_DATA& Data )
	{
		if( m_byNumTrigger >= ROLE_MAXNUM_CHARTRIGGER )
			return FALSE;
		
		m_Trigger[m_byNumTrigger].wTriggerID = Data.wTriggerID;
		m_Trigger[m_byNumTrigger].wMissionID = Data.wMissionID;
		m_Trigger[m_byNumTrigger].byType  = Data.byType;
		m_Trigger[m_byNumTrigger].wParam1 = Data.wParam1;
		m_Trigger[m_byNumTrigger].wParam2 = Data.wParam2;
		m_Trigger[m_byNumTrigger].wParam3 = Data.wParam3;
		m_Trigger[m_byNumTrigger].wParam4 = Data.wParam4;
		m_Trigger[m_byNumTrigger].wParam5 = Data.wParam5;
		m_Trigger[m_byNumTrigger].wParam6 = Data.wParam6;
		m_byNumTrigger++;

#ifdef ROLE_DEBUG_INFO
		printf( "AddTrigger, num=%d, wID=%d, wMisID=%d, e=%d, p1=%d, p2=%d, p3=%d, p4=%d, p5=%d, p6=%d\n", m_byNumTrigger,
			Data.wTriggerID, Data.wMissionID, Data.byType, Data.wParam1, Data.wParam2, Data.wParam3, Data.wParam4,
			Data.wParam5, Data.wParam6 );
#endif

		if( Data.byType == TE_GET_ITEM )
		{
			m_pRoleChar->RefreshNeedItem( Data.wParam1 );
		}
		else if( Data.byType == TE_GOTO_MAP )
		{
			m_byNumGotoMap++;
		}

		return TRUE;
	}

	BOOL CCharMission::MisClearTrigger( WORD wTriggerID )
	{
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].wTriggerID == wTriggerID )
			{
				ClearTrigger( i );
				return TRUE;
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisDelTrigger( WORD wTriggerID )
	{
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].wTriggerID == wTriggerID )
			{
				m_Trigger[i].byIsDel = TRIGGER_DELED;
				return TRUE;
			}
		}
		return FALSE;
	}

	void CCharMission::DeleteTrigger()
	{
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].byIsDel == TRIGGER_DELED )
			{
				ClearTrigger( (DWORD)i );				
			}
		}
	}

	void CCharMission::ClearTrigger( DWORD dwIndex )
	{
		if( dwIndex >= m_byNumTrigger )
			return;

		// 清除该条触发器信息记录
		if( m_Trigger[dwIndex].byType == TE_GOTO_MAP ) 
			m_byNumGotoMap--;

		memset( m_Trigger + dwIndex, 0, sizeof(TRIGGER_DATA) );
		TRIGGER_DATA Trigger[ROLE_MAXNUM_CHARTRIGGER];
		memcpy( Trigger, m_Trigger, sizeof(TRIGGER_DATA)*m_byNumTrigger );
		memset( m_Trigger + dwIndex, 0, sizeof(TRIGGER_DATA)*(m_byNumTrigger - dwIndex) );
		memcpy( m_Trigger + dwIndex, Trigger + dwIndex + 1, sizeof(TRIGGER_DATA)*( m_byNumTrigger - dwIndex - 1 ) );
		m_byNumTrigger--;
	}

	void CCharMission::MisGetMisLog()
	{
		WPACKET packet = GETWPACKET();
		WRITE_CMD(packet, CMD_MC_MISLOG );
		WRITE_CHAR(packet, m_byNumMission );
		for( BYTE i = 0; i < m_byNumMission; i++ )
		{
			WRITE_SHORT(packet, m_Mission[i].wRoleID );	
			WRITE_CHAR(packet, m_Mission[i].byState );
		}

		m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
	}

	void CCharMission::MisGetMisLogInfo( WORD wMisID )
	{T_B
		int nIndex = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wMisID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			//m_pRoleChar->SystemNotice( "MisGetMisLogInfo:错误的查询任务日志索引。ID = %d", wMisID );
			return;
		}

		// lua脚本处理触发器信息
		lua_getglobal( g_pLuaState, "MissionLog" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "TriggerProc" );
			return;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
		lua_pushnumber( g_pLuaState, m_Mission[nIndex].wParam1 );

		//int nStatus = lua_pcall( g_pLuaState, 2, 0, 0 );
		int nStatus = CParser::docall(g_pLuaState, 2, 1);
		if( nStatus )
		{
			//m_pRoleChar->SystemNotice( "CCharMission::MisGetMisLogInfo:任务日志处理函数[MissionLog]调用失败！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00017) );
			lua_callalert( g_pLuaState, nStatus );
		}
		lua_settop(g_pLuaState, 0);
	T_E}

	void CCharMission::MisLogClear( WORD wMisID )
	{
		WPACKET packet = GETWPACKET();
		WRITE_CMD(packet, CMD_MC_MISLOG_CLEAR );	
		WRITE_SHORT(packet, wMisID );

		m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
	}

	void CCharMission::MisLogAdd( WORD wMisID, BYTE byState )
	{
		WPACKET packet = GETWPACKET();
		WRITE_CMD(packet, CMD_MC_MISLOG_ADD );
		WRITE_SHORT(packet, wMisID );
		WRITE_CHAR(packet, byState );

		m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
	}

	void CCharMission::ClearRoleTrigger( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumTrigger; i++ )
		{
			if( m_Trigger[i].wMissionID == wRoleID )
			{
				ClearTrigger( i-- );
			}
		}
	}

	BOOL CCharMission::MisAddRole( WORD wRoleID, WORD wScriptID )
	{
		if( m_byNumMission >= ROLE_MAXNUM_FLAG )
			return FALSE;

		m_Mission[m_byNumMission].wRoleID = wRoleID;
		m_Mission[m_byNumMission].byState = ROLE_MIS_PENDING_FLAG;
		m_Mission[m_byNumMission].byMisType = MIS_TYPE_NOMAL;
		m_Mission[m_byNumMission].wParam1 = wScriptID;
		
		// 同步任务日志信息到客户端
		MisLogAdd( wRoleID, ROLE_MIS_PENDING_FLAG );

		m_byNumMission++;

		return TRUE;
	}

	BOOL CCharMission::MisHasRole( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID ) 
			{
				return m_Mission[i].byState != ROLE_MIS_FAILURE_FALG;
			}
		}

		return FALSE;
	}

	BOOL CCharMission::MisGetMisScript( WORD wRoleID, WORD& wScriptID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				wScriptID = m_Mission[i].wParam1;
				return TRUE;
			}
		}

		return FALSE;
	}

	BOOL CCharMission::MisSetMissionComplete( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				m_Mission[i].byState = ROLE_MIS_COMPLETE_FLAG;

				WPACKET packet = GETWPACKET();
				WRITE_CMD(packet, CMD_MC_MISLOG_CHANGE );
				WRITE_SHORT(packet, m_Mission[i].wRoleID );	
				WRITE_CHAR(packet, m_Mission[i].byState );	

				m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
				return TRUE;
			}
		}

		return FALSE;
	}

	BOOL CCharMission::MisSetMissionPending( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				m_Mission[i].byState = ROLE_MIS_PENDING_FLAG;

				WPACKET packet = GETWPACKET();
				WRITE_CMD(packet, CMD_MC_MISLOG_CHANGE );
				WRITE_SHORT(packet, m_Mission[i].wRoleID );	
				WRITE_CHAR(packet, m_Mission[i].byState );	
				m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
				return TRUE;
			}
		}

		return FALSE;
	}

	BOOL CCharMission::MisSetMissionFailure( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				m_Mission[i].byState = ROLE_MIS_FAILURE_FALG;

				WPACKET packet = GETWPACKET();
				WRITE_CMD(packet, CMD_MC_MISLOG_CHANGE );
				WRITE_CHAR(packet, i );
				WRITE_SHORT(packet, m_Mission[i].wRoleID );	
				WRITE_CHAR(packet, m_Mission[i].byState );	
				m_pRoleChar->ReflectINFof( m_pRoleChar, packet );
				return TRUE;
			}
		}

		return FALSE;
	}

	BOOL CCharMission::MisHasMissionFailure( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				return m_Mission[i].byState == ROLE_MIS_FAILURE_FALG;
			}
		}

		return FALSE;
	}

	BOOL CCharMission::CancelRole( WORD wRoleID, WORD wScriptID )
	{
		// lua脚本处理触发器信息
		lua_getglobal( g_pLuaState, "CancelMission" );
		if( !lua_isfunction( g_pLuaState, -1 ) )
		{
			lua_pop( g_pLuaState, 1 );
			LG( "lua_invalidfunc", "CancelMission" );
			return FALSE;
		}

		lua_pushlightuserdata( g_pLuaState, (void*)m_pRoleChar );
		lua_pushnumber( g_pLuaState, wRoleID );
		lua_pushnumber( g_pLuaState, wScriptID );

		//int nStatus = lua_pcall( g_pLuaState, 3, 1, 0 );
		int nStatus = CParser::docall(g_pLuaState, 3, 0);
		if( nStatus )
		{
			//m_pRoleChar->SystemNotice( "CCharMission::CancelRole:取消任务处理函数[CancelMission]调用失败！" );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00018) );
			lua_callalert( g_pLuaState, nStatus );
			lua_settop(g_pLuaState, 0);
			return FALSE;
		}

		DWORD dwResult = (DWORD)lua_tonumber( g_pLuaState, -1 );
		lua_settop(g_pLuaState, 0);
		return dwResult;
	}

	BOOL CCharMission::MisCancelRole( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				// 清除护送的npc分配内存
				if( m_Mission[i].byType == MIS_RAND_CONVOY )
				{
					for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
					{
						if( m_Mission[i].RandData[j].pData && m_Mission[i].RandData[j].wParam1 > 0 )
						{
							((CCharacter*)m_Mission[i].RandData[j].pData)->Free();
							m_Mission[i].RandData[j].pData = NULL;
						}
					}
				}

				// 执行取消任务脚本信息
				if( CancelRole( wRoleID, m_Mission[i].wParam1 ) == FALSE )
				{
					//m_pRoleChar->SystemNotice( "取消任务失败！ID[%d], SID[%d]", wRoleID, m_Mission[i].wParam1 );
					//m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00019), wRoleID, m_Mission[i].wParam1 );
					char szData[128];
					CFormatParameter param(2);
					param.setLong( 0, wRoleID );
					param.setLong( 1, m_Mission[i].wParam1 );
					RES_FORMAT_STRING( GM_MISSION_CPP_00019, param, szData );
					m_pRoleChar->SystemNotice( szData );
					return FALSE;
				}

				return TRUE;
			}
		}

		//m_pRoleChar->SystemNotice( "MisCancelRole:未发现指定的任务ID[%d]", wRoleID );
		m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00020), wRoleID );
		return FALSE;
	}

	BOOL CCharMission::MisClearRole( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				// 清除护送的npc分配内存
				if( m_Mission[i].byType == MIS_RAND_CONVOY )
				{
					for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
					{
						if( m_Mission[i].RandData[j].pData && m_Mission[i].RandData[j].wParam1 > 0 )
						{
							((CCharacter*)m_Mission[i].RandData[j].pData)->Free();
							m_Mission[i].RandData[j].pData = NULL;
						}
					}
				}

				// 清除该条记录信息
				MISSION_INFO Info[ROLE_MAXNUM_MISSION];
				memset( Info, 0, sizeof(MISSION_INFO)*ROLE_MAXNUM_MISSION);
				memcpy( Info, m_Mission, sizeof(MISSION_INFO)*m_byNumMission ); 
				memset( m_Mission + i, 0, sizeof(MISSION_INFO)*( m_byNumMission - i) );
				memcpy( m_Mission + i, Info + i + 1, sizeof(MISSION_INFO)*( m_byNumMission - i - 1 ) );
				m_byNumMission--;

				// 清除该任务触发器
				ClearRoleTrigger( wRoleID );

				// 同步任务日志信息到客户端
				MisLogClear( wRoleID );
				return TRUE;
			}
		}

		//m_pRoleChar->SystemNotice( "MisClearRole:未发现指定的任务ID[%d]", wRoleID );
		m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00021), wRoleID );
		return FALSE;
	}

	BOOL CCharMission::MisSetFlag( WORD wRoleID, WORD wFlag )
	{
		if( m_byNumMission + 1 >= ROLE_MAXNUM_FLAG )
			return FALSE;

		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				return m_Mission[i].RoleInfo.SetFlag( wFlag, TRUE );
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisClearFlag( WORD wRoleID, WORD wFlag )
	{
		if( m_byNumMission + 1 >= ROLE_MAXNUM_FLAG )
			return FALSE;

		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				return m_Mission[i].RoleInfo.SetFlag( wFlag, FALSE );
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisIsSet( WORD wRoleID, WORD wFlag )
	{
		if( m_byNumMission + 1 >= ROLE_MAXNUM_FLAG )
			return FALSE;

		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				return m_Mission[i].RoleInfo.IsSet( wFlag );	
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisIsValid( WORD wFlag )
	{
		return m_Mission[0].RoleInfo.IsValid( wFlag );	
	}

	BOOL CCharMission::MisSetRecord( WORD wRec )
	{
		return m_RoleRecord.SetID( wRec, TRUE );
	}

	BOOL CCharMission::MisClearRecord( WORD wRec )
	{
		return m_RoleRecord.SetID( wRec, FALSE );
	}

	BOOL CCharMission::MisIsRecord( WORD wRec )
	{
		return m_RoleRecord.IsSet( wRec );
	}

	BOOL CCharMission::MisIsValidRecord( WORD wRec )
	{
		return m_RoleRecord.IsValid( wRec );
	}

	
	BOOL CCharMission::MisAddFollowNpc( WORD wRoleID, BYTE byIndex, WORD wNpcCharID, CCharacter* pNpc, BYTE byAiType )
	{
		if( byIndex >= ROLE_MAXNUM_RAND_DATA )
		{
			//m_pRoleChar->SystemNotice( "MisIsFollowNpc:召唤NPC数据索引错误！byInex = %d", byIndex );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00022), byIndex );
			return FALSE;
		}

		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 )
		{
			//m_pRoleChar->SystemNotice( "MisAddFollowNpc:未发现任务ID=%d", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00023), wRoleID );
			return FALSE;
		}
		
		m_Mission[index].RandData[byIndex].pData   = pNpc;
		m_Mission[index].RandData[byIndex].wParam1 = wNpcCharID;
		m_Mission[index].RandData[byIndex].wParam2 = byAiType;
		return TRUE;
	}

	BOOL CCharMission::MisClearAllFollowNpc( WORD wRoleID )
	{
		int index = -1;
		int i = 0;
		for( i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 )
		{
			//m_pRoleChar->SystemNotice( "MisClearFollowNpc:未发现任务ID=%d", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00024), wRoleID );
			return FALSE;
		}

		if( m_Mission[index].byType == MIS_RAND_CONVOY )
		{
			for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
			{
				if( m_Mission[i].RandData[j].pData && m_Mission[i].RandData[j].wParam1 > 0 )
				{
					((CCharacter*)m_Mission[i].RandData[j].pData)->Free();
					m_Mission[i].RandData[j].pData = NULL;
				}
			}
		}

		return FALSE;
	}

	BOOL CCharMission::MisClearFollowNpc( WORD wRoleID, BYTE byIndex )
	{
		if( byIndex >= ROLE_MAXNUM_RAND_DATA )
		{
			//m_pRoleChar->SystemNotice( "MisClearFollowNpc:召唤NPC数据索引错误！byInex = %d", byIndex );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00025), byIndex );
			return FALSE;
		}

		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 )
		{
			//m_pRoleChar->SystemNotice( "MisClearFollowNpc:未发现任务ID=%d", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00024), wRoleID );
			return FALSE;
		}

		if( m_Mission[index].RandData[byIndex].wParam1 > 0 && m_Mission[index].RandData[byIndex].pData )
		{
			((CCharacter*)m_Mission[index].RandData[byIndex].pData)->Free();
			m_Mission[index].RandData[byIndex].pData = NULL;
			m_Mission[index].RandData[byIndex].wParam1 = 0;
			return TRUE;
		}
		return FALSE;
	}

	BOOL CCharMission::MisHasFollowNpc( WORD wRoleID, BYTE byIndex )
	{
		if( byIndex >= ROLE_MAXNUM_RAND_DATA )
		{
			//m_pRoleChar->SystemNotice( "MisHasFollowNpc:召唤NPC数据索引错误！byInex = %d", byIndex );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00026), byIndex );
			return FALSE;
		}

		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 )
		{
			//m_pRoleChar->SystemNotice( "MisHasFollowNpc:未发现任务ID=%d", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00027), wRoleID );
			return FALSE;
		}

		if( m_Mission[index].RandData[byIndex].wParam1 > 0 && m_Mission[index].RandData[byIndex].pData )
			return TRUE;
		
		return FALSE;
	}

	BOOL CCharMission::MisIsFollowNpc( WORD wRoleID, BYTE byIndex, WORD wNpcCharID )
	{
		if( byIndex >= ROLE_MAXNUM_RAND_DATA )
		{
			//m_pRoleChar->SystemNotice( "MisIsFollowNpc:召唤NPC数据索引错误！byInex = %d", byIndex );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00022), byIndex );
			return FALSE;
		}

		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 )
		{
			//m_pRoleChar->SystemNotice( "MisIsFollowNpc:未发现任务ID=%d", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00028), wRoleID );
			return FALSE;
		}

		return m_Mission[index].RandData[byIndex].wParam1 == wNpcCharID;
	}

	BOOL CCharMission::MisLowDistFollowNpc( WORD wRoleID, BYTE byIndex )
	{
		return FALSE;
	}

	BOOL CCharMission::MisAddRandMission( WORD wRoleID, WORD wScriptID, BYTE byType, BYTE byLevel, DWORD dwExp, DWORD dwMoney, USHORT sPrizeData, USHORT sPrizeType, BYTE byNumData )
	{
		if( m_byNumMission >= ROLE_MAXNUM_RANDMISSION )
			return FALSE;
		
		m_Mission[m_byNumMission].wRoleID = wRoleID;
		m_Mission[m_byNumMission].wParam1 = wScriptID;
		m_Mission[m_byNumMission].byState = ROLE_MIS_PENDING_FLAG;
		m_Mission[m_byNumMission].byMisType = MIS_TYPE_RAND;
		m_Mission[m_byNumMission].byType = byType;
		m_Mission[m_byNumMission].byLevel = byLevel;
		m_Mission[m_byNumMission].dwExp = dwExp;
		m_Mission[m_byNumMission].dwMoney = dwMoney;
		m_Mission[m_byNumMission].wItem = sPrizeData;
		m_Mission[m_byNumMission].wParam2 = sPrizeType;
		m_Mission[m_byNumMission].byNumData = byNumData;
		m_byNumMission++;

		// 同步日志到客户端
		MisLogAdd( wRoleID, ROLE_MIS_PENDING_FLAG );

		return TRUE;
	}
	
	BOOL CCharMission::MisHasRandMission( WORD wRoleID )
	{
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID && m_Mission[i].byMisType == MIS_TYPE_RAND )
				return TRUE;
		}

		return FALSE;
	}

	BOOL CCharMission::MisSetRandMissionData( WORD wRoleID, BYTE byIndex, const mission::MISSION_DATA& RandData )
	{
		if( byIndex >= ROLE_MAXNUM_RAND_DATA )
			return FALSE;
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 ) 
		{
			//m_pRoleChar->SystemNotice( "SetRandMissionData:未发现随机任务ID=%d", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00029), wRoleID );
			return FALSE;
		}
		
		memcpy( m_Mission[index].RandData + byIndex, &RandData, sizeof(MISSION_DATA) );
		return TRUE;
	}

	BOOL CCharMission::MisGetRandMission( WORD wRoleID, BYTE& byType, BYTE& byLevel, DWORD& dwExp, DWORD& dwMoney, USHORT& sPrizeData, USHORT& sPrizeType, BYTE& byNumData )
	{
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "GetRandMission:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00030), wRoleID );
			return FALSE;
		}

		wRoleID = m_Mission[index].wRoleID;
		byType = m_Mission[index].byType; // 获取低7位的任务类型信息
		byLevel = m_Mission[index].byLevel;
		dwExp = m_Mission[index].dwExp;
		dwMoney = m_Mission[index].dwMoney;
		sPrizeData = m_Mission[index].wItem;
		sPrizeType = m_Mission[index].wParam2;
		byNumData = m_Mission[index].byNumData;
		return TRUE;
	}

	BOOL CCharMission::MisGetRandMissionData( WORD wRoleID, BYTE byIndex, mission::MISSION_DATA& RandData )
	{
		if( byIndex >= ROLE_MAXNUM_RAND_DATA )
			return FALSE;
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "GetRandMissionData:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00031), wRoleID );
			return FALSE;
		}

		memcpy( &RandData, m_Mission[index].RandData + byIndex, sizeof(MISSION_DATA) );
		return TRUE;
	}

	BOOL CCharMission::MisHasSendNpcItemFlag( WORD wRoleID, WORD wNpcID )
	{
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}
			
		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "SetRandMissionNpcItemFlag:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00032), wRoleID );
			return FALSE;
		}

		for( int i = 0; i < m_Mission[index].byNumData; i++ )
		{
			if( m_Mission[index].RandData[i].wParam1 == wNpcID && m_Mission[index].RandData[i].wParam4 == 1 )
			{				
				return TRUE; // m_pRoleChar->HasItem( m_Mission[index].RandData[i].wParam2, 1 );
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisNoSendNpcItemFlag( WORD wRoleID, WORD wNpcID )
	{
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}
			
		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "SetRandMissionNpcItemFlag:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00032), wRoleID );
			return FALSE;
		}

		for( int i = 0; i < m_Mission[index].byNumData; i++ )
		{
			if( m_Mission[index].RandData[i].wParam1 == wNpcID && m_Mission[index].RandData[i].wParam4 != 1 )
			{				
				return m_pRoleChar->HasItem( m_Mission[index].RandData[i].wParam2, 1 );
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisTakeAllRandNpcItem( WORD wRoleID )
	{
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}
		
		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "GetRandMissionNpcItem:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00033), wRoleID );
			return FALSE;
		}

		for( int i = 0; i < m_Mission[index].byNumData; i++ )
		{
			if( m_Mission[index].RandData[i].wParam4 != 1 )
			{
				m_pRoleChar->GetPlyMainCha()->TakeItem( m_Mission[index].RandData[i].wParam2, 1, "系统" );
				m_Mission[index].RandData[i].wParam4 = 1; // 表明物品已被取走				
			}
		}
		return TRUE;
	}

	BOOL CCharMission::MisTakeRandMissionNpcItem( WORD wRoleID, WORD wNpcID, USHORT& sItemID )
	{
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}
			
		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "GetRandMissionNpcItem:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00033), wRoleID );
			return FALSE;
		}

		for( int i = 0; i < m_Mission[index].byNumData; i++ )
		{
			if( m_Mission[index].RandData[i].wParam1 == wNpcID )
			{
				sItemID = m_Mission[index].RandData[i].wParam2;
				m_Mission[index].RandData[i].wParam4 = 1; // 表明物品已被取走
				return TRUE;
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisHasRandMissionNpc( WORD wRoleID, WORD wNpcID, WORD wAreaID )
	{
		int index = -1;
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].wRoleID == wRoleID )
			{
				index = i;
				break;
			}
		}

		if( index == -1 || m_Mission[index].byMisType != MIS_TYPE_RAND ) 
		{
			//m_pRoleChar->SystemNotice( "HasRandMissionNpc:未发现随机任务ID=%d，或者任务不是随机数据类型！", wRoleID );
			m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00034), wRoleID );
			return FALSE;
		}

		for( int i = 0; i < m_Mission[index].byNumData; i++ )
		{
			if( m_Mission[index].RandData[i].wParam1 == wNpcID &&
				m_Mission[index].RandData[i].wParam3 == wAreaID )
			{
				return TRUE;
			}
		}
		return FALSE;
	}

	BOOL CCharMission::MisAddRandMissionNum( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			if( m_byNumMisCount >= ROLE_MAXNUM_MISSIONCOUNT )
			{
				//LG( "randmission", "CCharMission::CompleteRandMission:随机任务计数记录已满，不能再添加新的随机任务完成次数记录！" );
				LG( "randmission", "CCharMission::CompleteRandMission:random task take count of note has full，cannot add new random task note of compelete number！" );
				return FALSE;
			}
			m_MissionCount[m_byNumMisCount].wRoleID = wRoleID;
			m_MissionCount[m_byNumMisCount].wCount  = 1;
			m_byNumMisCount++;
			return TRUE;
		}

		m_MissionCount[nIndex].wCount = 0;
		m_MissionCount[nIndex].wNum++;
		return TRUE;
	}

	BOOL CCharMission::MisCompleteRandMission( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			if( m_byNumMisCount >= ROLE_MAXNUM_MISSIONCOUNT )
			{
				//LG( "randmission", "CCharMission::CompleteRandMission:随机任务计数记录已满，不能再添加新的随机任务完成次数记录！" );
				LG( "randmission", "CCharMission::CompleteRandMission:random task take count of note has full，cannot add new random task compelete note ！" );
				return FALSE;
			}
			m_MissionCount[m_byNumMisCount].wRoleID = wRoleID;
			m_MissionCount[m_byNumMisCount].wCount  = 1;
			m_MissionCount[nIndex].wNum = 0;
			m_byNumMisCount++;
			return TRUE;
		}

		m_MissionCount[nIndex].wCount++;
		return TRUE;
	}

	BOOL CCharMission::MisFailureRandMission( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			return TRUE;
		}

		m_MissionCount[nIndex].wCount = 0;
		m_MissionCount[nIndex].wNum = 0;
		return TRUE;
	}

	BOOL CCharMission::MisResetRandMission( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			return TRUE;
		}

		m_MissionCount[nIndex].wCount = 0;
		return TRUE;
	}

	BOOL CCharMission::MisResetRandMissionNum( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			return TRUE;
		}

		m_MissionCount[nIndex].wCount = 0;
		m_MissionCount[nIndex].wNum = 0;
		return TRUE;
	}

	WORD CCharMission::MisGetRandMissionCount( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			return 0;
		}

		return m_MissionCount[nIndex].wCount;
	}

	WORD CCharMission::MisGetRandMissionNum( WORD wRoleID )
	{
		int nIndex = -1;
		for( int i = 0; i < m_byNumMisCount; i++ )
		{
			if( m_MissionCount[i].wRoleID == wRoleID )
			{
				nIndex = i;
				break;
			}
		}

		if( nIndex == -1 )
		{
			return 0;
		}

		return m_MissionCount[nIndex].wNum;
	}

	void CCharMission::MisLogout()
	{
		m_byOnline = 0;
		//TL(CHA_OUT, m_pRoleChar->GetName(), "", "角色离线");
		TL(CHA_OUT, m_pRoleChar->GetName(), "", RES_STRING(GM_MISSION_CPP_00035));
	}

	void CCharMission::MisLogin()
	{
		m_byOnline = 1;
		//TL(CHA_ENTER, m_pRoleChar->GetName(), "", "角色上线");
		TL(CHA_ENTER, m_pRoleChar->GetName(), "", RES_STRING(GM_MISSION_CPP_00036));
	}

	void CCharMission::MisEnterMap() 
	{
		if(m_pRoleChar)
		{
			CCharacter* pMain = m_pRoleChar->GetPlyCtrlCha();

			if(pMain)
			{
				//const char* pszMap = (pMain->GetSubMap()) ? pMain->GetSubMap()->GetName() : "未知";
				const char* pszMap = (pMain->GetSubMap()) ? pMain->GetSubMap()->GetName() : RES_STRING(GM_MISSION_CPP_00037);
				char szData[128];
				//sprintf( szData, "进地图《%s》坐标：x = %d, y = %d.", pszMap, pMain->GetPos().x, pMain->GetPos().y );
				//sprintf( szData, RES_STRING(GM_MISSION_CPP_00038), pszMap, pMain->GetPos().x, pMain->GetPos().y );
				//_snprintf_s( szData,sizeof(szData),_TRUNCATE,RES_STRING(GM_MISSION_CPP_00038), pszMap, pMain->GetPos().x, pMain->GetPos().y );
				CFormatParameter param(3);
				param.setString( 0, pszMap );
				param.setLong( 1, pMain->GetPos().x );
				param.setLong( 2, pMain->GetPos().y );
				RES_FORMAT_STRING( GM_MISSION_CPP_00038, param, szData );
				TL(CHA_ENTER, m_pRoleChar->GetName(), "", szData );

				// 进入地图时召唤出跟随npc
				for( int i = 0; i < m_byNumMission; i++ )
				{
					if( m_Mission[i].byType == MIS_RAND_CONVOY )
					{
						for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
						{
							if( m_Mission[i].RandData[j].wParam1 > 0 )
							{
								if( !m_pRoleChar->ConvoyNpc( m_Mission[i].wRoleID, j, m_Mission[i].RandData[0].wParam1, 
									(BYTE)m_Mission[i].RandData[0].wParam2 ) )
								{
									//m_pRoleChar->SystemNotice( "召唤你的任务护送NPC失败，请通知开发人员，谢谢！	MID(%d),NID(%d)", 
									//m_pRoleChar->SystemNotice( RES_STRING(GM_MISSION_CPP_00039), 
									//	m_Mission[i].wRoleID, m_Mission[i].RandData[0].wParam1 );					
									char szData[128];
									CFormatParameter param(2);
									param.setLong( 0, m_Mission[i].wRoleID );
									param.setLong( 1, m_Mission[i].RandData[0].wParam1 );
									RES_FORMAT_STRING( GM_MISSION_CPP_00039, param, szData );
									m_pRoleChar->SystemNotice( szData );
								}
							}
						}
					}
				}
				MisGetMisLog();
			}
		}
		else
		{

		}
	}
	
	void CCharMission::MisGooutMap() 
	{
		CCharacter* pMain = m_pRoleChar->GetPlyCtrlCha();
		const char* pszMap = (pMain->GetSubMap()) ? pMain->GetSubMap()->GetName() : RES_STRING(GM_MISSION_CPP_00037);
		char szData[128];
		CFormatParameter param(3);
		param.setString( 0, pszMap );
		param.setLong( 1, pMain->GetPos().x );
		param.setLong( 2, pMain->GetPos().y );
		RES_FORMAT_STRING( GM_MISSION_CPP_00040, param, szData );
		TL(CHA_OUT, m_pRoleChar->GetName(), "", szData );

		// 出地图时清空跟随npc
		for( int i = 0; i < m_byNumMission; i++ )
		{
			if( m_Mission[i].byType == MIS_RAND_CONVOY )
			{
				for( int j = 0; j < ROLE_MAXNUM_RAND_DATA; j++ )
				{
					if( m_Mission[i].RandData[j].pData && m_Mission[i].RandData[j].wParam1 > 0 )
					{
						((CCharacter*)m_Mission[i].RandData[j].pData)->Free();
						m_Mission[i].RandData[j].pData = NULL;
					}
				}
			}
		}
	}
}