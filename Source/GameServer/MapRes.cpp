//=============================================================================
// FileName: MapRes.cpp
// Creater: ZhangXuedong
// Date: 2005.09.05
// Comment: Map Resource
//=============================================================================
#include "stdafx.h"   //add by sunny 20080312

#include "MapRes.h"
#include "Script.h"
#include "Parser.h"
#include "SubMap.h"

CMapID g_MapID;
const char g_cchLogMapEntry = 1;
#define MAX_COPYMAP 30
_DBC_USING

const char* GetResPath(const char *pszRes);

CMapRes::CMapRes()
:m_pCLeftMap(0),m_pCTopMap(0),m_pCRightMap(0),m_pCBelowMap(0)
,m_pCMonsterSpawn(0)
,m_pCMapSwitchEntitySpawn(0),m_pNpcSpawn(0)
,m_csEyeshotCellWidth(800),m_csEyeshotCellHeight(800)
,m_csStateCellWidth(200),m_csStateCellHeight(200)
,m_csBlockUnitWidth(50),m_csBlockUnitHeight(50)
,m_byMapID(0),m_bCanStall(true),m_bCanGuild(true)
{T_B
	m_bValid = false;
	m_chState = enumMAP_STATE_CLOSE;

	m_sMapCpyNum = 0;
	m_pCMapCopy = 0;

	m_timeMgr.Begin(5 * 1000);
	m_timeRun.Begin(100);

	//m_pfEntryFile = 0;
	m_strEntryFile = "";

	//Init begin
	memset(m_szObstacleFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szSectionFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szMonsterSpawnFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szNpcSpawnFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szMapSwitchFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szMonsterCofFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szCtrlFile, 0, _MAX_PATH + _MAX_FNAME);
	memset(m_szEntryFile, 0, _MAX_PATH + _MAX_FNAME);


	memset(m_szEntryMapName, 0, sizeof(m_szEntryMapName));
	m_strMapName = "";
	// end
T_E}

CMapRes::~CMapRes()
{T_B
	if (m_pCMonsterSpawn)
	{
		delete m_pCMonsterSpawn;
		m_pCMonsterSpawn = 0;
	}
	if (m_pCMapSwitchEntitySpawn)
	{
		delete m_pCMapSwitchEntitySpawn;
		m_pCMapSwitchEntitySpawn = 0;
	}
	SAFE_DELETE( m_pNpcSpawn );

	if (m_pCMapCopy)
	{
		delete [] m_pCMapCopy;
		m_pCMapCopy = 0;
	}

	//if (m_pfEntryFile)
	//{
	//	fclose(m_pfEntryFile);
	//	m_pfEntryFile = 0;
	//}
T_E}

bool CMapRes::Init()
{T_B
	SetGuildWar(false);

	if( !g_MapID.GetID( m_strMapName.c_str(), m_byMapID ) )
	{
		//LG("initmap", "配置地图《%s》，ID信息错误!", m_strMapName.c_str() );
		LG("initmap", "configure map(%s),ID info error\n", m_strMapName.c_str() );
		char szData[128];
		//sprintf( szData, "SubMap::LoadNpc:获取地图《%s》ID失败!", m_strMapName.c_str() );
		//sprintf( szData, RES_STRING(GM_MAPRES_CPP_00001), m_strMapName.c_str() );
		_snprintf_s(szData,sizeof(szData),_TRUNCATE, RES_STRING(GM_MAPRES_CPP_00001), m_strMapName.c_str() );

		//MessageBox( NULL, szData, "错误", IDOK );
		MessageBox( NULL, szData, RES_STRING(GM_MAPRES_CPP_00002), IDOK );
		return false;
	}
	else
	{
		//LG("initmap", "设置地图《%s》，ID = %d!", m_strMapName.c_str(), m_byMapID );
		LG("initmap", "set map (%s),ID = %d!\n", m_strMapName.c_str(), m_byMapID );
	}
	g_MapID.SetMap( m_byMapID, this );	

	// 装载障碍物信息，地图按位存储转换为按字节存储，提高访问速度
	if (m_CBlock.Load(GetResPath(m_szObstacleFile)) == 0)
	{
		//LG("init", "物件障碍文件[%s]读入错误, 继续!\n", m_szObstacleFile);
		LG("init", " Loa object obstacle file[%s] error,continue!\n", m_szObstacleFile);
		return false;
	}

	// 地图宽度和高度为什么是障碍物宽高的一半呢？
	int	nMapWidth = m_CBlock.getWidth() / 2, nMapHeight = m_CBlock.getHeight() / 2;
	m_SRange.ltop.x = 0;
	m_SRange.ltop.y = 0;
	m_SRange.rbtm.x = nMapWidth * 100;
	m_SRange.rbtm.y = nMapHeight * 100; // 是单位CM转换为M吗？

	//检查各地图范围的合法性
	if((m_SRange.width() % m_csEyeshotCellWidth) || (m_SRange.height() % m_csEyeshotCellHeight))
	{
		//LG("init", "地图[%s]的长度或宽度不是管理单元宽度的倍数\n", m_strMapName);
		LG("init", "the map[%s]'s length or width isn't the multiple of manage cell\n", m_strMapName);
		return false;
	}

	// 地图区域装载，根据位置取得区域属性
	// 第0位 1，陆地。0，是海洋
    // 第1位 1，非战斗区。0，战斗区
    // 第2位 1，PK区域
	// 第3位 1，桥。
	// 第4位 1，禁怪区
    // 第5位 1
    // 第6位 1，邀请PK

	if (m_CTerrain.Init((_TCHAR*)GetResPath(m_szSectionFile)) == 0)
	{
		//LG("init", "地图区域文件[%s]读入错误!", m_szSectionFile);
		LG("init", "Load the map section file [%s]error !", m_szSectionFile);
		//return false;
	}

	// 状态单元
	m_sStateCellCol = (nMapWidth * 100 + m_csStateCellWidth - 1) / m_csStateCellWidth;
	m_sStateCellLin = (nMapHeight * 100 + m_csStateCellHeight - 1) / m_csStateCellHeight;

	// 视野单元
	m_sEyeshotCellCol = (nMapWidth * 100 + m_csEyeshotCellWidth - 1) / m_csEyeshotCellWidth;
	m_sEyeshotCellLin = (nMapHeight * 100 + m_csEyeshotCellHeight - 1) / m_csEyeshotCellHeight;

	// 装载地图怪物文件
	m_pCMonsterSpawn = new CChaSpawn();
	if (!m_pCMonsterSpawn->Init(m_szMonsterSpawnFile, 200))
	{
		//THROW_EXCP( excpMem, "装载地图怪物文件错误!" );
		throw excpMem(RES_STRING(GM_MAPRES_CPP_00003) );
	}

	// 装载地图跳转点文件
	m_pCMapSwitchEntitySpawn = new CMapSwitchEntitySpawn();
	if (!m_pCMapSwitchEntitySpawn->Init(m_szMapSwitchFile, 100))
	{
		throw excpMem(RES_STRING(GM_MAPRES_CPP_00004) );
	}

	// 装载地图怪物NPC
	m_pNpcSpawn = new CNpcSpawn();
	if (!m_pNpcSpawn->Init(m_szNpcSpawnFile, 200))
	{
		throw excpMem( RES_STRING(GM_MAPRES_CPP_00005) );
	}

	if (!InitCtrl())
		throw excpMem(RES_STRING(GM_MAPRES_CPP_00006) );

	//LG("init", "地图 %s 资源初始化成功\n", m_strMapName.c_str());
	LG("init", "map %s init resource succeed\n", m_strMapName.c_str());

	m_chCopyStartCdtType = enumMAPCOPY_START_CDT_UNKN;
	m_bValid = true;
	Open();
	return true;
T_E}

bool CMapRes::SetCopyNum(dbc::Short sCpyNum)
{
	if (m_pCMapCopy || sCpyNum < 1 || sCpyNum > defMAX_MAP_COPY_NUM)
	{
		//LG("副本数目错误", "msg设定的副本数目 %d 超过最大值 %d!\n", sCpyNum, defMAX_MAP_COPY_NUM);
		//LG("copy number error", RES_STRING(GM_GAMEAPP_CPP_00008), sCpyNum, defMAX_MAP_COPY_NUM);
		char szData[128];
		CFormatParameter param(2);
		param.setLong( 0, sCpyNum );
		param.setLong( 1, defMAX_MAP_COPY_NUM );
		RES_FORMAT_STRING( GM_GAMEAPP_CPP_00008, param, szData );
		LG("copy number error", szData );
		return false;
	}
	m_sMapCpyNum = sCpyNum;
	return true;
}

SubMap* CMapRes::GetCopy(dbc::Short sCpyNO)
{
	if (sCpyNO < 0) return m_pCMapCopy;
	if (sCpyNO >= m_sMapCpyNum) return 0;
	return m_pCMapCopy + sCpyNO;
}

BOOL CMapRes::SummonNpc( USHORT sAreaID, const char szNpc[], USHORT sTime )
{T_B
	return m_pNpcSpawn->SummonNpc( szNpc, sAreaID, sTime );
T_E}

// 根据地图控制脚本初始化一些控制信息
bool CMapRes::InitCtrl(void)
{T_B
	if (g_IsFileExist(GetResPath(m_szCtrlFile)))
		//lua_dofile(g_pLuaState, GetResPath(m_szCtrlFile));
		CParser::dofile(g_pLuaState, GetResPath(m_szCtrlFile));
	m_szEntryMapName[0] = '\0';
	m_SEntryPos.x = -1;
	m_SEntryPos.y = -1;

	// 初始状态
	m_chEntryState = enumMAPENTRY_STATE_CLOSE;
	
	m_tEntryFirstTm = 0;
	m_tEntryTmDis = 0;
	m_tEntryOutTmDis = 0;
	m_tMapClsTmDis = 0;

	m_sMapCpyNum = 1;
	SetCanSavePos();
	SetCanPK(false);
	SetCanTeam();
	SetRepatriateDie(true);
	SetType();
	SetCopyStartType();

	// 既然不需要看返回值，直接写到脚本里调用不是更好？？这样需要和Lua交互三此
	g_CParser.DoString("init_entry", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
	g_CParser.DoString("config", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
#ifdef NEW_MAPCOPY
	//Add buy sunny.sun 20090812
	CMapCopyRecord *pMapCopy = NULL;
	for( int i = 0; i< MAX_COPYMAP; i++ )
	{
		pMapCopy = GetMapCopyRecordInfo( i );
		if( pMapCopy && !strcmp( pMapCopy->szMapName, m_strMapName.c_str() ))
		{
			//pMapCopy->nMapID
			m_sMapCpyNum = pMapCopy->m_nCopyNum;
			m_chCopyStartType = pMapCopy->m_cStartType;
			break;
		}
	}
#endif
	// 初始化副本
	m_pCMapCopy = new SubMap[m_sMapCpyNum];
	if (!m_pCMapCopy)
		throw excpMem(RES_STRING(GM_MAPRES_CPP_00007));
	for (Short i = 0; i < m_sMapCpyNum; i++)
	{
		if (!m_pCMapCopy[i].Init(this, i))
			return false;
	}

	// 只在启动时读入入口脚本到内存中

	errno_t err = 0;
	if ((err = _access_s(GetResPath(m_szEntryFile), 0 )) == 0 )
	{
		try
		{
			fstream entryFile;
			entryFile.open(GetResPath(m_szEntryFile));

			char szLine[255];
			char* pszPos;

			while(!entryFile.eof())
			{
				entryFile.getline(szLine, 255);

				if ((pszPos = strstr(szLine, "--")) != NULL)
					*pszPos = '\0';

				if (!strcmp(szLine, ""))
					continue;

				m_strEntryFile += szLine;
				m_strEntryFile += " ";
			}

			entryFile.close();
		}
		catch(...)
		{
			LG("entry_error", "file error!\r\n");
			return false;
		}
	}

	return true;
T_E}

// 创建入口，向目标地图发送入口的创建脚本文件.
bool CMapRes::CreateEntry(void)
{T_B
	if(m_strEntryFile.length() <= 50)
	{
		LG("entry_error", "m_strEntryFile <= 50 error!\r\n");
		return false;
	}

	// 只做一次处理提高速度
	if(m_SEntryPos.x == -1 && m_SEntryPos.y == -1)
	{
		string	strScript = "get_map_entry_pos_";
		strScript += GetName();
		if (g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NUMBER, 2, DOSTRING_PARAM_END))
		{
			m_SEntryPos.x = g_CParser.GetReturnNumber(0) * 100;
			m_SEntryPos.y = g_CParser.GetReturnNumber(1) * 100;
		}
	}

	if (g_cchLogMapEntry)
	{
		//LG("地图入口流程", "\n");
		//LG("地图入口流程", "请求创建入口：位置 %s --> %s[%u, %u]\n", GetName(), m_szEntryMapName, m_SEntryPos.x, m_SEntryPos.y);
		LG("map_entrance_flow", "ask for found entrance : position %s --> %s[%u, %u]\n", GetName(), m_szEntryMapName, m_SEntryPos.x, m_SEntryPos.y);
	}
	WPACKET	wpk	=GETWPACKET();
	WRITE_CMD(wpk, CMD_MT_MAPENTRY);
	WRITE_STRING(wpk, m_szEntryMapName);
	WRITE_STRING(wpk, GetName());
	WRITE_CHAR(wpk, enumMAPENTRY_CREATE);
	WRITE_LONG(wpk, m_SEntryPos.x);
	WRITE_LONG(wpk, m_SEntryPos.y);
	WRITE_SHORT(wpk, GetCopyNum());
	WRITE_SHORT(wpk, GetCopyPlyNum());

	WRITE_STRING(wpk, m_strEntryFile.c_str());
	WRITE_SHORT(wpk, 1);	//固定为1行记录

	BEGINGETGATE();
	GateServer	*pGateServer;
	while (pGateServer = GETNEXTGATE())
	{
		pGateServer->SendData(wpk);
		break;
	}

	return true;
T_E}

// 释放入口，向目标地图发送入口关闭命令
bool CMapRes::DestroyEntry(void)
{T_B
	if (g_cchLogMapEntry)
		//LG("地图入口流程", "请求关闭入口：位置 %s --> %s\n", GetName(), m_szEntryMapName);
		LG("map_entrance_flow", "ask for close entrance:position %s --> %s\n", GetName(), m_szEntryMapName);
	WPACKET	wpk	=GETWPACKET();
	WRITE_CMD(wpk, CMD_MT_MAPENTRY);
	WRITE_STRING(wpk, m_szEntryMapName);
	WRITE_STRING(wpk, GetName());
	WRITE_CHAR(wpk, enumMAPENTRY_DESTROY);

	BEGINGETGATE();
	GateServer	*pGateServer;
	while (pGateServer = GETNEXTGATE())
	{
		pGateServer->SendData(wpk);
		break;
	}

	return true;
T_E}

// 告诉入口调整当前玩家数目
bool CMapRes::SubEntryPlayer(dbc::Short sCopyNO)
{T_B
	if (!strcmp(m_szEntryMapName, ""))
		return true;

	WPACKET	wpk	=GETWPACKET();
	WRITE_CMD(wpk, CMD_MT_MAPENTRY);
	WRITE_STRING(wpk, m_szEntryMapName);
	WRITE_STRING(wpk, GetName());
	WRITE_CHAR(wpk, enumMAPENTRY_SUBPLAYER);
	WRITE_SHORT(wpk, sCopyNO);
	WRITE_SHORT(wpk, 1);

	BEGINGETGATE();
	GateServer	*pGateServer;
	while (pGateServer = GETNEXTGATE())
	{
		pGateServer->SendData(wpk);
		break;
	}

	return true;
T_E}

// 请求入口关闭副本
bool CMapRes::SubEntryCopy(dbc::Short sCopyNO)
{T_B
	if (!strcmp(m_szEntryMapName, ""))
		return true;

	if (g_cchLogMapEntry)
		//LG("地图入口流程", "请求关闭地图副本（%s：%d）\n", GetName(), sCopyNO);
		LG("map_entrance_flow", "ask for close copy map(%s:%d)\n", GetName(), sCopyNO);
	WPACKET	wpk	=GETWPACKET();
	WRITE_CMD(wpk, CMD_MT_MAPENTRY);
	WRITE_STRING(wpk, m_szEntryMapName);
	WRITE_STRING(wpk, GetName());
	WRITE_CHAR(wpk, enumMAPENTRY_SUBCOPY);
	WRITE_SHORT(wpk, sCopyNO);

	BEGINGETGATE();
	GateServer	*pGateServer;
	while (pGateServer = GETNEXTGATE())
	{
		pGateServer->SendData(wpk);
		break;
	}

	return true;
T_E}

bool CMapRes::SetEntryMapName(const char *szMapName)
{T_B
	if (!szMapName) return false;
	//strncpy(m_szEntryMapName, szMapName, MAX_MAPNAME_LENGTH - 1);
		strncpy_s( m_szEntryMapName, sizeof(m_szEntryMapName), szMapName, _TRUNCATE );
	m_szEntryMapName[MAX_MAPNAME_LENGTH - 1] = '\0';

	return true;
T_E}

bool CMapRes::Open(void)
{T_B
	if (m_chState == enumMAP_STATE_OPEN)
	{
		LG("map_entrance_flow", "1bool CMapRes::Open(void):%s\n", GetName());
		return true;
	}

	LG("map_entrance_flow", "2bool CMapRes::Open(void):%s\n", GetName());
	m_chState = enumMAP_STATE_OPEN;

	return true;
T_E}

// 地图关闭函数
bool CMapRes::Close(void)
{T_B
	if (m_chState == enumMAP_STATE_CLOSE)
	{
		if (g_cchLogMapEntry)
			//LG("地图入口流程", "已经关闭地图：%s\n", GetName());
			LG("map_entrance_flow", "already close the map:%s\n", GetName());
		return true;
	}

	// 确认关闭入口
	CloseEntry();

	// 如果入口是关闭或者成功关闭
	if (m_chEntryState == enumMAPENTRY_STATE_CLOSE || m_chEntryState == enumMAPENTRY_STATE_CLOSE_SUC)
	{
		m_chState = enumMAP_STATE_CLOSE;
		m_chEntryState = enumMAPENTRY_STATE_CLOSE;
		
		CopyClose();

		if (g_cchLogMapEntry)
			//LG("地图入口流程", "成功关闭地图：%s\n", GetName());
			LG("map_entrance_flow", "close map succeed :%s\n", GetName());
		return true;
	}
	else
	{
		LG("map_entrance_flow", "bool CMapRes::Close(void)%s\n", GetName());	
	}

	if (m_chState != enumMAP_STATE_CLOSE && m_chEntryState == enumMAPENTRY_STATE_ASK_CLOSE)
	{
		m_chState = enumMAP_STATE_ASK_CLOSE;
		if (g_cchLogMapEntry)
			//LG("地图入口流程", "请求关闭地图：%s\n", GetName());
			LG("map_entrance_flow", "ask for close map:%s\n", GetName());
	}

	return false;
T_E}

// 控制入口的生命形态
void CMapRes::Run(DWORD dwCurTime)
{T_B
	// 100毫秒执行一次
	if (!m_timeRun.IsOK(dwCurTime))
		return;

	for (Short i = 0; i < m_sMapCpyNum; i++)
		m_pCMapCopy[i].Run(dwCurTime);


	// 5秒钟执行一次
	if (!m_timeMgr.IsOK(dwCurTime))
		return;

	string	strScript = "map_run_";
	strScript += GetName();
	g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);

	// 有动态入口
	if (!HasDynEntry())
		return;

	time_t	tNowTime = time(NULL);
	if (tNowTime < m_tEntryFirstTm)
		return;

		
	//time_t	tDist = tNowTime - m_tEntryFirstTm;
	//if (m_tEntryTmDis != 0)
	//	tDist = tDist % m_tEntryTmDis;

	//switch(m_chEntryState)
	//{
	//case enumMAPENTRY_STATE_ASK_CLOSE:	// 请求关闭
	//	// Donothing
	//	break;
	//case enumMAPENTRY_STATE_OPEN:		// 开启
	//	
	//	if(m_tMapClsTmDis != 0 && tDist >= m_tMapClsTmDis) // 关闭地图
	//	{
	//		Close();
	//	}
	//	else if(m_tEntryOutTmDis != 0 && tDist >= m_tEntryOutTmDis) // 关闭入口
	//	{
	//		CloseEntry();
	//	}
	//	else
	//	{
	//		//Donothing
	//	}

	//	break;
	//case enumMAPENTRY_STATE_ASK_OPEN:	// 请求开启，如果没有响应需要继续请求
	//case enumMAPENTRY_STATE_CLOSE:		// 关闭（从未开放过）
	//case enumMAPENTRY_STATE_CLOSE_SUC:	// 关闭（已经开放过）
	//	
	//	if(m_tEntryOutTmDis == 0 || tDist < m_tEntryOutTmDis)
	//	{
	//		string	strScript = "can_open_entry_";
	//		strScript += GetName();
	//		if (g_CParser.StringIsFunction(strScript.c_str()))
	//		{
	//			g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
	//			if (g_CParser.GetReturnNumber(0) == 1)
	//			{
	//				OpenEntry();
	//			}
	//		}
	//		else // 如果没有定义函数，缺省打开 Bug#17
	//		{
	//			OpenEntry();
	//		}
	//	}

	//	break;
	//}

	bool bOpenEntry = false, bCloseEntry = false, bClose = false;
	time_t	tDist = tNowTime - m_tEntryFirstTm;

	if (m_tEntryTmDis != 0)
		tDist = tDist % m_tEntryTmDis;

	if (m_tEntryOutTmDis == 0) // 永不消失
		bOpenEntry = true;
	else
	{
		if (tDist < m_tEntryOutTmDis) // 开启
			bOpenEntry = true;
	}

	if (tDist >= m_tEntryOutTmDis) // 消失
	{
		bCloseEntry = true;
		if (m_tEntryOutTmDis == 0) // 永不消失
			bCloseEntry = false;
	}
	if (tDist >= m_tMapClsTmDis) // 关闭地图
	{
		bClose = true;

		if (m_tMapClsTmDis == 0) // 永不关闭
			bClose = false;
	}

	if (bOpenEntry)
	{
		string	strScript = "can_open_entry_";
		strScript += GetName();
		if (g_CParser.StringIsFunction(strScript.c_str()))
		{
			g_CParser.DoString(strScript.c_str(), enumSCRIPT_RETURN_NUMBER, 1, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, this, DOSTRING_PARAM_END);
			if (g_CParser.GetReturnNumber(0) == 0)
				bOpenEntry = false;
		}
	}

	if (bOpenEntry)
	{
		LG("map_entrance_flow", "Run OpenEntry (%s: m_tEntryOutTmDis = %I64i tDist = %I64i)\n", GetName(), m_tEntryOutTmDis, tDist);
		OpenEntry();
	}
	
	if (bCloseEntry)
	{
		LG("map_entrance_flow", "Run CloseEntry (%s: m_tEntryOutTmDis = %I64i tDist = %I64i)\n", GetName(), m_tEntryOutTmDis, tDist);
		CloseEntry();
	}
	
	if (bClose)
	{
		LG("map_entrance_flow", "Run Close (%s: m_tMapClsTmDis = %I64i tDist = %I64i)\n", GetName(), m_tMapClsTmDis, tDist);
		Close();
	}

	time_t	tBeepT = m_tMapClsTmDis - tDist;
	if (m_chState == enumMAP_STATE_OPEN && tBeepT > 0 && tBeepT < 50)
	{
		Char szInfo[128];
		//sprintf(szInfo, "本地图服务时间已到，将在%d秒后关闭", tBeepT);
		//sprintf(szInfo, RES_STRING(GM_MAPRES_CPP_00008), tBeepT);
		_snprintf_s(szInfo,sizeof(szInfo),_TRUNCATE, RES_STRING(GM_MAPRES_CPP_00008), (long)tBeepT);

		CopyNotice(szInfo);
	}

T_E}

// 打开入口
bool CMapRes::OpenEntry(void)
{T_B
	//// 关闭了再开，或者请求状态中再请求
	//if (m_chEntryState == enumMAPENTRY_STATE_CLOSE_SUC || m_chEntryState == enumMAPENTRY_STATE_CLOSE 
	//	|| m_chEntryState== enumMAPENTRY_STATE_ASK_OPEN)
	//{
	//	if (!CreateEntry())
	//		return false;
	//}

	//m_chEntryState = enumMAPENTRY_STATE_ASK_OPEN;

	//return true;

	// 如果是入口打开状态
	if (m_chEntryState == enumMAPENTRY_STATE_OPEN)
	{
		LG("map_entrance_flow", "OpenEntry enumMAPENTRY_STATE_OPEN (%s)\n", GetName());
		return true;
	}

	// 如果是入口成功关闭状态 ？？？
	if (m_chEntryState == enumMAPENTRY_STATE_CLOSE_SUC)
	{
		LG("map_entrance_flow", "OpenEntry enumMAPENTRY_STATE_CLOSE_SUC (%s)\n", GetName());
		return true;
	}

	// 如果是入口请求关闭状态
	if (m_chEntryState == enumMAPENTRY_STATE_ASK_CLOSE)
	{
		LG("map_entrance_flow", "OpenEntry enumMAPENTRY_STATE_ASK_CLOSE (%s)\n", GetName());
		return false;
	}

	// 如果是关闭状态或者是请求打开状态
	if (m_chEntryState == enumMAPENTRY_STATE_CLOSE || m_chEntryState == enumMAPENTRY_STATE_ASK_OPEN)
	{
		if (!CreateEntry())
		{
			LG("map_entrance_flow", "OpenEntry CreateEntry false (%s)\n", GetName());
			return false;
		}
		else
		{
			LG("map_entrance_flow", "OpenEntry CreateEntry true (%s)\n", GetName());
		}
	}

	// 请求打开入口
	m_chEntryState = enumMAPENTRY_STATE_ASK_OPEN;

	return true;
T_E}

// 关闭入口
bool CMapRes::CloseEntry(void)
{T_B
	//// 只有在开启状态才能关闭入口
	//if (m_chEntryState == enumMAPENTRY_STATE_OPEN)
	//{
	//	// 向GateServer发送关闭入口消息
	//	if (!DestroyEntry())
	//		return false;
	//}

	//// 状态修改为请求关闭状态
	//m_chEntryState = enumMAPENTRY_STATE_ASK_CLOSE;

	//return true;
	// 如果是入口请求打开状态
	if (m_chEntryState == enumMAPENTRY_STATE_ASK_OPEN)
	{
		LG("map_entrance_flow", "CloseEntry enumMAPENTRY_STATE_ASK_OPEN (%s)\n", GetName());
		return false;
	}

	// 如果是入口关闭状态
	if (m_chEntryState == enumMAPENTRY_STATE_CLOSE || m_chEntryState == enumMAPENTRY_STATE_CLOSE_SUC)
	{
		LG("map_entrance_flow", "CloseEntry enumMAPENTRY_STATE_CLOSE || enumMAPENTRY_STATE_CLOSE_SUC (%s)\n", GetName());
		return true;
	}

	// 如果是入口打开状态或者是请求关闭状态
	if (m_chEntryState == enumMAPENTRY_STATE_OPEN || m_chEntryState == enumMAPENTRY_STATE_ASK_CLOSE)
	{
		if (!DestroyEntry())
		{
			LG("map_entrance_flow", "CloseEntry DestroyEntry false (%s)\n", GetName());
			return false;
		}
		else
		{
			LG("map_entrance_flow", "CloseEntry DestroyEntry true (%s)\n", GetName());
		}
	}

	m_chEntryState = enumMAPENTRY_STATE_ASK_CLOSE;

	return true;
T_E}

// 此函数待续（副本关闭操作要等到入口的相关操作成功返回后才能执行）
bool CMapRes::CopyClose(dbc::Short sCopyNO)
{T_B
	if (sCopyNO >= GetCopyNum())
		return false;

	if (g_cchLogMapEntry)
		//LG("地图入口流程", "关闭地图副本（%s：%d）\n", GetName(), sCopyNO);
		LG("map_entrance_flow", "close map copy (%s:%d)\n", GetName(), sCopyNO);
	if (sCopyNO < 0)
	{
		for (Short i = 0; i < m_sMapCpyNum; i++)
		{
			m_pCMapCopy[i].Close();
		}
	}
	else
	{
		m_pCMapCopy[sCopyNO].Close();
	}

	return true;
T_E}

bool CMapRes::CopyNotice(const char *szString, dbc::Short sCopyNO)
{T_B
	if (sCopyNO >= GetCopyNum())
		return false;

	if (sCopyNO < 0)
		for (Short i = 0; i < m_sMapCpyNum; i++)
			m_pCMapCopy[i].Notice(szString);
	else
		m_pCMapCopy[sCopyNO].Notice(szString);

	return true;
T_E}

// 关闭副本
bool CMapRes::ReleaseCopy(dbc::Short sCopyNO)
{T_B
	return SubEntryCopy(sCopyNO);
T_E}

// 检查入口状态
void CMapRes::CheckEntryState(dbc::Char chState)
{T_B

	LG("map_entrance_flow", "void CMapRes::CheckEntryState(dbc::Char chState):%s %d %d\n", GetName(), chState, m_chEntryState);

	// 如果参数是入口打开状态
	if (chState == enumMAPENTRY_STATE_OPEN)
	{
		// 如果当前入口是请求打开状态
		if (m_chEntryState == enumMAPENTRY_STATE_ASK_OPEN)
		{
			m_chEntryState = chState;

			// 入口开启时开启地图
			Open();
		}
		else // 不可能出现的情况
		{
			LG("map_entrance_flow", "void CMapRes::CheckEntryState(dbc::Char chState)1\n");
		}

		// 如果是地图立即开启则开启立即地图
		for (Short i = 0; i < m_sMapCpyNum; i++)
		{
			if (GetCopyStartType() == enumMAPCOPY_START_NOW)
				m_pCMapCopy[i].Open();
		}
	} // 如果参数是入口关闭成功状态
	else if (chState == enumMAPENTRY_STATE_CLOSE_SUC)
	{
		// 如果当前入口是请求关闭状态
		if (m_chEntryState == enumMAPENTRY_STATE_ASK_CLOSE)
		{
			m_chEntryState = chState;
			//Close();
		}
		else // 不可能出现的情况
		{
			LG("map_entrance_flow", "void CMapRes::CheckEntryState(dbc::Char chState)2\n");
		}

		// 地图关闭？？？
		if (m_chState == enumMAP_STATE_ASK_CLOSE)
		{
			LG("map_entrance_flow", "void CMapRes::CheckEntryState(dbc::Char chState)3\n");
			Close();
		}
	}
	else
	{
		LG("map_entrance_flow", "void CMapRes::CheckEntryState(dbc::Char chState)4\n");
	}
T_E}

// 取现一个正在运行的副本
SubMap* CMapRes::GetNextUsedCopy(void)
{T_B
	if (!m_pCMapCopy)
		return NULL;

	Short	sCopyNum = GetCopyNum();

	if (m_sUsedCopySearch >= sCopyNum)
		return NULL;

	for (Short i = m_sUsedCopySearch; i < sCopyNum; i++)
	{
		m_sUsedCopySearch = i + 1;
		if (m_pCMapCopy[i].IsRun())
			return m_pCMapCopy + i;
	}

	return NULL;
T_E}

mission::CNpc* CMapRes::FindNpc( const char szName[] )
{T_B
	if( szName )
	{
		return m_pNpcSpawn->FindNpc( szName );
	}
	return NULL;
T_E}

// Add by lark.li 20090331 begin
void CMapRes::CheckMapState(string& str)
{T_B

	str.append(GetName());
	str.append(" ");
	str.append(m_szEntryMapName);
	str.append(" MapState=");
	
	switch(m_chState)
	{
	case enumMAP_STATE_OPEN:			// 打开
		str.append("Open");
		break;
	case enumMAP_STATE_CLOSE:		// 关闭
		str.append("Close");
		break;
	case enumMAP_STATE_ASK_CLOSE:	// 请求关闭
		str.append("AskClose");
		break;
	}

	str.append(" EntryState=");
	switch(m_chEntryState)
	{
	case enumMAPENTRY_STATE_ASK_OPEN:	// 请求开启
		str.append("AskOpen");
		break;
	case enumMAPENTRY_STATE_OPEN:		// 开启
		str.append("Open");
		break;
	case enumMAPENTRY_STATE_CLOSE:		// 关闭（从未开放过）
		str.append("Close");
		break;
	case enumMAPENTRY_STATE_ASK_CLOSE:	// 请求关闭
		str.append("AskClose");
		break;
	case enumMAPENTRY_STATE_CLOSE_SUC:	// 关闭（已经开放过）
		str.append("CloseSuccess");
		break;
	}

T_E}
// End

void CMapRes::OpenMap()
{T_B
	this->Open();
T_E}

void CMapRes::CloseMap()
{T_B
	this->Close();
T_E}

void CMapRes::OpenMapEntry()
{T_B
	// 设定为请求状态
	m_chEntryState = enumMAPENTRY_STATE_ASK_OPEN;

	this->CreateEntry();	
T_E}

void CMapRes::CloseMapEntry()
{T_B
	// 设定为请求状态
	m_chEntryState = enumMAPENTRY_STATE_ASK_CLOSE;

	this->DestroyEntry();
T_E}

//=============================================================================
CAreaData::CAreaData()
{T_B
	m_sUnitCountX = 0;
	m_sUnitCountY = 0;
	m_sUnitWidth = 100;
	m_sUnitHeight = 100;
	m_nID = -1;
T_E}

CAreaData::~CAreaData()
{
	Free();
}

Long CAreaData::Init(_TCHAR *chFile)
{T_B
	if ((m_nID = s_openAttribFile(chFile)) == -1)
		return 0;

	unsigned int nWidth, nHeight;
	s_getAttribFileInfo(m_nID, nWidth, nHeight);

	m_sUnitCountX = (Short)nWidth;
	m_sUnitCountY = (Short)nHeight;

	return 1;
T_E}

void CAreaData::Free()
{
}

bool CAreaData::GetUnitSize(Short *psWidth, Short *psHeight)
{T_B
	*psWidth = m_sUnitWidth;
	*psHeight = m_sUnitHeight;

	return true;
T_E}

bool CAreaData::GetUnitAttr(Short sUnitX, Short sUnitY, uShort &usAttribute)
{T_B
	if (m_nID == -1)
		return false;
	//if (!IsValidPos(sUnitX, sUnitY))
	//	return false;
	return s_getTileAttrib(m_nID, sUnitX, sUnitY, usAttribute);
T_E}

bool CAreaData::GetUnitIsland(Short sUnitX, Short sUnitY, uChar &uchIsland)
{T_B
	if (m_nID == -1)
		return false;
	//if (!IsValidPos(sUnitX, sUnitY))
	//	return false;
	return s_getTileIsland(m_nID, sUnitX, sUnitY, uchIsland);
T_E}

//=============================================================================
CMapID::CMapID()
{T_B
	Clear();
T_E}

CMapID::~CMapID()
{
	
}

void CMapID::Clear()
{
	memset( m_MapInfo, 0, MAX_MAP );
	m_byNumMap = 0;
}

BOOL CMapID::AddInfo( const char szMap[], BYTE byID )
{T_B
	if( m_byNumMap >= MAX_MAP )
		return FALSE;
	//strncpy( m_MapInfo[m_byNumMap].szMap, szMap, MAX_MAPNAME_LENGTH - 1 );
		strncpy_s( m_MapInfo[m_byNumMap].szMap, sizeof(m_MapInfo[m_byNumMap].szMap), szMap, _TRUNCATE );
	m_MapInfo[m_byNumMap].byID = byID;
	m_byNumMap++;
	return TRUE;
T_E}

BOOL CMapID::GetID( const char szMap[], BYTE& byID )
{T_B
	for( BYTE b = 0; b < m_byNumMap; b++ )
	{
		if( strcmp( m_MapInfo[b].szMap, szMap ) == 0 )
		{
			byID = m_MapInfo[b].byID;
			return TRUE;
		}
	}
	return FALSE;
T_E}

CMapRes* CMapID::GetMap( BYTE byID )
{T_B
	for( BYTE b = 0; b < m_byNumMap; b++ )
	{
		if( byID == m_MapInfo[b].byID )
		{
			return m_MapInfo[b].pMap;
		}
	}
	return NULL;
T_E}

BOOL CMapID::SetMap( BYTE byID, CMapRes* pMap )
{T_B
	for( BYTE b = 0; b < m_byNumMap; b++ )
	{
		if( byID == m_MapInfo[b].byID )
		{
			m_MapInfo[b].pMap = pMap;
			return TRUE;
		}
	}
	return FALSE;
T_E}
