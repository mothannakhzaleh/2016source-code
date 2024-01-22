#include "stdafx.h"
#include "Config.h"
#include <fstream>
#include "Util.h"

char	szConfigFileN[defCONFIG_FILE_NAME_LEN] = "GameServer.cfg";
CGameConfig g_Config;

CGameConfig::CGameConfig()
{
	SetDefault();
}

void CGameConfig::SetDefault()
{
	m_nGateCnt = 0;
    m_nMapCnt  = 0;
	m_lSocketAlive = 1;
	memset(m_btMapOK, 0, MAX_MAP);
	strncpy_s( m_szDBIP, sizeof(m_szDBIP), "", _TRUNCATE );
	strncpy_s( m_szDBUsr, sizeof(m_szDBUsr), "", _TRUNCATE );
	strncpy_s( m_szDBPass, sizeof(m_szDBPass), "", _TRUNCATE );

	// Add by lark.li 20080321 begin
	memset(m_szTradeLogDBIP, 0, sizeof(m_szTradeLogDBIP));
	memset(m_szTradeLogDBName, 0, sizeof(m_szTradeLogDBName));
	memset(m_szTradeLogDBUsr, 0, sizeof(m_szTradeLogDBUsr));
	memset(m_szTradeLogDBPass, 0, sizeof(m_szTradeLogDBPass));
	// End

	memset( m_szEqument, 0, MAX_MAPNAME_LENGTH );
	m_nMaxPly = 3000;
	m_nMaxCha = 15000;
	m_nMaxItem = 10000;
	m_nMaxTNpc = 300;
	m_nMaxShip = 1000; // 最大船只数 //本机调试GS，占用较少内存，从cfg读入max_ship数据(如果读不到，默认值为以前的1000) -Waiting Add 2009-03-23
	m_nMaxRes = 1000;  // 最大资源数 //本机调试GS，占用较少内存，从cfg读入max_ship数据(如果读不到，默认值为以前的1000) -Waiting Add 2009-03-23

	m_lItemShowTime = 300 * 1000;
	m_lItemProtTime = 30  * 1000;
	m_lSayInterval  =  3  * 1000;

	m_chMapMask = 1;
	m_lDBSave = 20 * 60 * 1000;

	//strcpy(m_szResDir, "");
	strncpy_s( m_szResDir, sizeof(m_szResDir), "", _TRUNCATE );
	//strcpy(m_szLogDir, "log\\");
	strncpy_s( m_szLogDir, sizeof(m_szLogDir), "log\\", _TRUNCATE );

	//strcpy(m_szTradeIP, "");
	strncpy_s( m_szTradeIP, sizeof(m_szTradeIP), "", _TRUNCATE );
	m_nTradePort = 0;
	//strcpy(m_szTradePwd, "");
	strncpy_s( m_szTradePwd, sizeof(m_szTradePwd), "", _TRUNCATE );
	m_nSection = 0;

	m_bLogAI		= FALSE;	// 是否打开AI的log
	m_bLogCha		= FALSE;	// 是否打开角色的log
	m_bLogCal		= FALSE;	// 是否打开数值计算的log
	m_bLogMission	= FALSE;	// 是否打开Mission的log

	m_bLogDB        = FALSE;

	m_bTradeLogIsConfig = FALSE;	// Add by lark.li 20080324
}

bool CGameConfig::Load(char *pszFileName)
{
	LG("init", "Load Game Config File(Text Mode) [%s]\n", pszFileName);
	
	ifstream in(pszFileName);
	if(in.is_open()==0)
	{
		LG("init", "msgLoad Game Config File(Text Mode) [%s] error! \n", pszFileName);
		return false;
	}
	string strPair[2];
	string strComment;
	string strLine;
	char szLine[255];
	while(!in.eof())
	{
		in.getline(szLine, 255);
		strLine = szLine;
		int p = (int)(strLine.find("//"));
		if(p!=-1)
		{
			string strLeft = strLine.substr(0, p);
			strComment = strLine.substr(p + 2, strLine.size() - p - 2);
			strLine = strLeft;
		}
		else
		{
			strComment = "";
		}
		Util_TrimString(strLine);
		if(strLine.size()==0) continue;
		if(strLine[0]=='[') 
		{
			Log("\n%s\n", strLine.c_str());
			continue;
		}
		
		int n = Util_ResolveTextLine(strLine.c_str(), strPair, 2, '=');
		if(n < 2) continue;
        string strKey   = strPair[0];
		string strValue = strPair[1];
		//Add by sunny.sun 20090121
		char strTempkey[255] = "";
		strncpy_s( strTempkey, sizeof(strTempkey), strKey.c_str(), _TRUNCATE );
		_strlwr_s( strTempkey, sizeof( strTempkey ));
		strKey = strTempkey;
		if(strKey=="gate")
		{
			string strList[2];
            int nCnt = Util_ResolveTextLine(strValue.c_str(), strList, 2, ',');
		    if(nCnt==2)
            {
                //strcpy(m_szGateIP[m_nGateCnt], strList[0].c_str());
				strncpy_s( m_szGateIP[m_nGateCnt], sizeof(m_szGateIP[m_nGateCnt]), strList[0].c_str(), _TRUNCATE );
                m_nGatePort[m_nGateCnt] = Str2Int(strList[1]);
				if (m_nGateCnt < MAX_GATE)
					m_nGateCnt++;
            }
        }
        else if(strKey=="trade") // 解析TradeServer IP和port
        {
            string strList[4];
            int nCnt = Util_ResolveTextLine(strValue.c_str(), strList, 4, ',');
            if(nCnt==4)
            {
                //strcpy(m_szTradeIP, strList[0].c_str());
				strncpy_s( m_szTradeIP, sizeof(m_szTradeIP), strList[0].c_str(), _TRUNCATE );
                m_nTradePort = Str2Int(strList[1]);
				//strcpy(m_szTradePwd, strList[2].c_str());
				strncpy_s( m_szTradePwd, sizeof(m_szTradePwd), strList[2].c_str(), _TRUNCATE );
				m_nSection = Str2Int(strList[3].c_str());
            }
        }
		else if(strKey=="map") 
		{
		    //strcpy(m_szMapList[m_nMapCnt], strValue.c_str());
			strncpy_s( m_szMapList[m_nMapCnt], sizeof(m_szMapList[m_nMapCnt]), strValue.c_str(), _TRUNCATE );
            m_nMapCnt++;
        }
		else if(strKey=="equment" )
		{
			//strncpy( m_szEqument, strValue.c_str(), MAX_MAPNAME_LENGTH - 1 );
			strncpy_s( m_szEqument, sizeof(m_szEqument), strValue.c_str(), _TRUNCATE );
		}
		else if(strKey=="name")
		{
            //strcpy(m_szName, strValue.c_str());
			strncpy_s( m_szName, sizeof(m_szName), strValue.c_str(), _TRUNCATE );
		}
		else if (strKey == "baseid")
		{
			size_t stPos = 0;
			if ((stPos = strValue.find("0x")) != -1 || (stPos = strValue.find("0X")) != -1) // 十六进制值
				//sscanf(strValue.c_str(), "%x", &m_ulBaseID);
				sscanf_s(strValue.c_str(), "%x", &m_ulBaseID);

			else // 十进制值
				//sscanf(strValue.c_str(), "%d", &m_ulBaseID);
				sscanf_s(strValue.c_str(), "%d", &m_ulBaseID);

		}
		else if(strKey=="max_ply")
		{
			m_nMaxPly = Str2Int(strValue);
		}
		else if(strKey=="max_cha")
		{
			m_nMaxCha = Str2Int(strValue);
		}
		else if(strKey=="max_item")
		{
			m_nMaxItem = Str2Int(strValue);
		}
		else if(strKey=="max_tnpc")
		{
			m_nMaxTNpc = Str2Int(strValue);
		}
		else if(strKey=="db_ip")
		{
			//strcpy(m_szDBIP, strValue.c_str());
			strncpy_s( m_szDBIP, sizeof(m_szDBIP), strValue.c_str(), _TRUNCATE );
		}
		else if(strKey=="max_ship") // 最大船只数 //本机调试GS，占用较少内存，从cfg读入max_ship数据(如果读不到，默认值为以前的1000) -Waiting Add 2009-03-23
		{
			m_nMaxShip = Str2Int(strValue);
		}
		else if(strKey=="max_res") // 最大资源数 //本机调试GS，占用较少内存，从cfg读入max_ship数据(如果读不到，默认值为以前的1000) -Waiting Add 2009-03-23
		{
			m_nMaxRes = Str2Int(strValue);
		}
		else if(strKey=="db_usr")
		{
			//strcpy(m_szDBUsr, strValue.c_str());
			strncpy_s( m_szDBUsr, sizeof(m_szDBUsr), strValue.c_str(), _TRUNCATE );

		}
		else if(strKey=="db_pass")
		{
			//strcpy(m_szDBPass, strValue.c_str());
			strncpy_s( m_szDBPass, sizeof(m_szDBPass), strValue.c_str(), _TRUNCATE );

		}
		else if(strKey=="log_cha")
		{
			m_bLogCha = Str2Int(strValue);
		}
		else if(strKey=="log_ai")
		{
			m_bLogAI = Str2Int(strValue);
		}
		else if(strKey=="log_cal")
		{
			m_bLogCal = Str2Int(strValue);
		}
		else if(strKey=="log_mission")
		{
			m_bLogMission = Str2Int(strValue);
		}
		else if (strKey=="keep_alive")
		{
			m_lSocketAlive = Str2Int(strValue);
		}	
		else if(strKey=="item_show_time")
		{
			m_lItemShowTime = Str2Int(strValue);
		}
		else if(strKey=="item_prot_time")
		{
			m_lItemProtTime = Str2Int(strValue);
		}
		else if(strKey=="say_interval")
		{
			m_lSayInterval = Str2Int(strValue) * 1000;
		}
		else if(strKey=="res_dir")
		{
			//strcpy(m_szResDir, strValue.c_str());
			strncpy_s( m_szResDir, sizeof(m_szResDir), strValue.c_str(), _TRUNCATE );
		}
		else if(strKey=="log_dir")
		{
			//strcpy(m_szLogDir, strValue.c_str());
			strncpy_s( m_szLogDir, sizeof(m_szLogDir), strValue.c_str(), _TRUNCATE );
			LG_SetDir(m_szLogDir);
		}
		else if(strKey=="db_mapmask")
		{
			m_chMapMask = Str2Int(strValue);
		}
		else if(strKey=="save_db")
		{
			m_lDBSave = Str2Int(strValue) * 60 * 1000;
		}
		else if(strKey=="log_db")
		{
			m_bLogDB = Str2Int(strValue);
		} // Add by lark.li 20080324 begin
		else if(strKey=="tradelog_db_ip")
		{
			//strcpy(m_szTradeLogDBIP, strValue.c_str());
			strncpy_s( m_szTradeLogDBIP, sizeof(m_szTradeLogDBIP), strValue.c_str(), _TRUNCATE );
		}
		else if(strKey=="tradelog_db_name")
		{
			//strcpy(m_szTradeLogDBName, strValue.c_str());
			strncpy_s( m_szTradeLogDBName, sizeof(m_szTradeLogDBName), strValue.c_str(), _TRUNCATE );
		}
		else if(strKey=="tradelog_db_usr")
		{
			//strcpy(m_szTradeLogDBUsr, strValue.c_str());
			strncpy_s( m_szTradeLogDBUsr, sizeof(m_szTradeLogDBUsr), strValue.c_str(), _TRUNCATE );
		}
		else if(strKey=="tradelog_db_pass")
		{
			//strcpy(m_szTradeLogDBPass, strValue.c_str());
			strncpy_s( m_szTradeLogDBPass, sizeof(m_szTradeLogDBPass), strValue.c_str(), _TRUNCATE );
		} // End
		else if(strKey=="resetflag")
		{
			m_ResetFlag = Str2Int(strValue);
		}// End
	}
	in.close();

	// Add by lark.li 20080324 begin
	if( strlen(g_Config.m_szTradeLogDBIP) > 0 && strlen(g_Config.m_szTradeLogDBName) > 0 && strlen(g_Config.m_szTradeLogDBUsr) > 0 && strlen(g_Config.m_szTradeLogDBPass) > 0 )
		m_bTradeLogIsConfig = TRUE;
	// End

	return true;
}

