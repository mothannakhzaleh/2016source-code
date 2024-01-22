#include "stdafx.h"
#include "GameApp.h"
#include "Character.h"
#include "SubMap.h"
#include "NPC.h"
#include "Item.h"
#include "Script.h"
#include "CommFunc.h"
#include "Player.h"
#include "ItemAttr.h"
#include "JobInitEquip.h"
#include "GameAppNet.h"
#include "SkillStateRecord.h"
#include "lua_gamectrl.h"
#include "chartrade.h"

#pragma warning(disable: 4355)


void CCharacter::DoCommand(cChar *cszCommand, uLong ulLen)
{T_B
	// Add by lark.li 20090311 begin
	if(!cszCommand)
		return;
	// End

	Char	szComHead[256], szComParam[2048];
	std::string	strList[10];
	std::string strPrint = cszCommand;

	Char	*szCom = (Char *)cszCommand;
	size_t	tStart = strspn(cszCommand, " ");
	if (tStart >= strlen(cszCommand))
		return;
	szCom += tStart;
	Char	*szParam = strstr(szCom, " ");
	if (szParam)
	{
		*szParam = '\0';
		//strncpy(szComHead, szCom, 256 - 1);
		strncpy_s( szComHead, sizeof(szComHead), szCom, _TRUNCATE );
		if (szParam[1] != '\0')
			//strncpy(szComParam, szParam + 1, 256 - 1);
			strncpy_s( szComParam, sizeof(szComParam), szParam + 1, _TRUNCATE );
		else
			szComParam[0] = '\0';
	}
	else
	{
		//strncpy(szComHead, szCom, 256 - 1);
		strncpy_s( szComHead, sizeof(szComHead), szCom, _TRUNCATE );
		szComParam[0] = '\0';
	}

	
	// 检查执行GM指令
	if(DoGMCommand(szComHead, szComParam))
		//LG("DoCommand", "[执行成功]%s:%s\n", GetLogName(), strPrint.c_str());
		LG("DoCommand", "[operator succeed]%s:%s\n", GetLogName(), strPrint.c_str());
	else
		//LG("DoCommand", "[执行失败]%s:%s\n", GetLogName(), strPrint.c_str());
		LG("DoCommand", "[operator succeed]%s:%s\n", GetLogName(), strPrint.c_str());
	
T_E}


//--------------------------------------------------------------------------------
// GM 指令区, 还缺少帐号权限判断
//--------------------------------------------------------------------------------
BOOL CCharacter::DoGMCommand(const char *pszCmd, const char *pszParam)
{T_B
	CPlayer *pPlayer = GetPlayer(); 
	if(!pPlayer) return FALSE;
	
	const uChar uchGMLv = pPlayer->GetGMLev();
	std::string	strList[10];
	string strCmd = pszCmd;

	if(!PrivilegeCheck::Instance()->HasPrivilege(uchGMLv,strCmd.c_str(), this->m_pCPlayer->GetActName()))
	{
		SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00001));
		return false;
	}


	if (strCmd=="move") // 地图跳转，格式:move x,y,地图名
	{
		int n = Util_ResolveTextLine(pszParam, strList, 10, ',');
		Point l_aim;
		l_aim.x = Str2Int(strList[0]) * 100;
		l_aim.y = Str2Int(strList[1]) * 100;
		const char	*szMapName = 0;
		short	sMapCpyNO = 0;
		if (n == 3)
			szMapName = strList[2].c_str();
		else
			szMapName = GetSubMap()->GetName();
		if (n == 4)
			sMapCpyNO = Str2Int(strList[1]);

		SwitchMap(GetSubMap(), szMapName, l_aim.x, l_aim.y, true, enumSWITCHMAP_CARRY, sMapCpyNO);
		return TRUE;
	}
	else if(strCmd=="notice") // 系统通告
	{
		g_pGameApp->WorldNotice(pszParam);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if(strCmd=="hide") // 隐身
	{
		AddSkillState(m_uchFightID, GetID(), GetHandle(), enumSKILL_TYPE_SELF, enumSKILL_TAR_LORS, enumSKILL_EFF_HELPFUL, SSTATE_HIDE, 1, -1, enumSSTATE_ADD);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if(strCmd=="unhide") // 显形
	{
		DelSkillState(SSTATE_HIDE);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if(strCmd=="goto") // 将自己传到某角色身边
	{
		int n = Util_ResolveTextLine(pszParam, strList, 10, ',');
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_GOTO_CHA);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, strList[0].c_str());
		WRITE_CHAR(WtPk, 1);
		WRITE_STRING(WtPk, GetName());
		ReflectINFof(this, WtPk);//通告
		//LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}

	//if(uchGMLv <= 1)
	//{
	//	//SystemNotice("权限不够!");
	//	SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00001));
	//	return FALSE;
	//}

	//-----------------------
	// 1级以上GM都可以执行的指令
	//-----------------------
	
	if (strCmd=="kick") // 将玩家踢下线
	{
		int n = Util_ResolveTextLine(pszParam, strList, 10, ',');
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_KICK_CHA);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, strList[0].c_str());
		if (n == 2)
			WRITE_LONG(WtPk, Str2Int(strList[1]));
		else
			WRITE_LONG(WtPk, 0);
		ReflectINFof(this, WtPk); // 通告

        LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}

	//if(uchGMLv != 99)
	//{
	//	//SystemNotice("权限不够!");
	//	SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00001));
	//	return FALSE;
	//}

    LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);

	cChar	*szComHead = pszCmd;
	cChar	*szComParam = pszParam;
	//-----------------------
	// 99级GM都可以执行的指令
	//-----------------------
	if (!strcmp(szComHead, "reload")) // 重新读表
	{
		cChar *pszAll = "alltable";
		cChar *pszChaInfo = "characterinfo";
		cChar *pszSkillInfo = "skillinfo";
		cChar *pszItemInfo = "iteminfo";
		cChar *pszMonRef = "monsterrefresh";
		if (!strcmp(szComParam, pszAll))
			g_pGameApp->LoadAllTable();
		if (!strcmp(szComParam, pszChaInfo))
			g_pGameApp->LoadCharacterInfo();
		else if (!strcmp(szComParam, pszSkillInfo))
			g_pGameApp->LoadSkillInfo();
		else if (!strcmp(szComParam, pszItemInfo))
			g_pGameApp->LoadItemInfo();
		else if (!strcmp(szComParam, pszMonRef))
			m_submap->LoadMonsterInfo();
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
    else if(!strcmp(szComHead, "relive")) // 原地复活
	{	
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if(!strcmp(szComHead, "qcha")) // 查询角色信息(所在地图,坐标,唯一ID)
	{
		int n = Util_ResolveTextLine(pszParam, strList, 10, ',');
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_QUERY_CHA);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, strList[0].c_str());
		ReflectINFof(this, WtPk);//通告
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if(!strcmp(szComHead, "qitem")) // 查询角色道具
	{
		int n = Util_ResolveTextLine(pszParam, strList, 10, ',');
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_QUERY_CHAITEM);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, strList[0].c_str());
		ReflectINFof(this, WtPk);//通告
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
    if(!strcmp(szComHead, "call")) // 将单一角色传到身边
	{
		int n = Util_ResolveTextLine(pszParam, strList, 10, ',');
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_CALL_CHA);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, strList[0].c_str());
		if (IsBoat())
			WRITE_CHAR(WtPk, 1);
		else
			WRITE_CHAR(WtPk, 0);
		WRITE_STRING(WtPk, GetSubMap()->GetName());
		WRITE_LONG(WtPk, GetPos().x);
		WRITE_LONG(WtPk, GetPos().y);
		WRITE_LONG(WtPk, GetSubMap()->GetCopyNO());
		ReflectINFof(this, WtPk);//通告
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "gamesvrstop")) // 结束游戏服务器进程
	{
		g_pGameApp->m_CTimerReset.Begin(1000);
		g_pGameApp->m_ulLeftSec = atol(szComParam);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "updateall") ) // 脚本lua更新
	{
		LoadScript();
		if ( g_pGameApp->ReloadNpcInfo( *this ) )
		{
			//SystemNotice( "NPC对话和任务lua脚本更新成功!" );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00002) );
		}
		else
		{
			return FALSE;
		}
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "harmlog=1") ) // 伤害累计计算Log开关
	{
		g_bLogHarmRec = TRUE;
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "harmlog=0") ) // 伤害累计计算Log开关
	{
		g_bLogHarmRec = FALSE;
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "misreload") ) // 任务脚本更新
	{
		LoadScript();
		if( g_pGameApp->ReloadNpcInfo( *this ) )
		{
			//SystemNotice( "NPC对话和任务lua脚本更新成功!" );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00002) );
		}
		else
		{
			return FALSE;
		}
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "reload_ai") )
	{
		ReloadAISdk();
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "setrecord" ) ) // 设置角色任务历史标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');		
		USHORT sID   = Str2Int(strList[0]);
		if( GetPlayer()->MisSetRecord( sID ) )
		{
			//SystemNotice( "设置任务历史标记成功!ID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00003), sID );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "设置任务历史标记失败!ID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00003), sID );
			return FALSE;
		}
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp(szComHead, "clearrecord" ) ) // 设置角色任务历史标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');		
		USHORT sID   = Str2Int(strList[0]);
		if( GetPlayer()->MisClearRecord( sID ) )
		{
			//SystemNotice( "清除任务历史标记成功!ID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00004), sID );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "清除任务历史标记失败!ID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00005), sID );
			return FALSE;
		}
		return TRUE;
	}
	else if( !strcmp(szComHead, "setflag" ) ) // 设置任务标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');		
		USHORT sID   = Str2Int(strList[0]);
		USHORT sFlag = Str2Int(strList[1]);
		if( GetPlayer()->MisSetFlag( sID, sFlag ) )
		{
			//SystemNotice( "设置任务标记成功!ID[%d], FLAG[%d]", sID, sFlag );
			//SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00006), sID, sFlag );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, sID );
			param.setLong( 1, sFlag );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00006, param, szData );
			SystemNotice( szData );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "设置任务标记失败!ID[%d], FLAG[%d]", sID, sFlag );
			//SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00007), sID, sFlag );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, sID );
			param.setLong( 1, sFlag );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00007, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
		return TRUE;
	}
	else if( !strcmp(szComHead, "clearfalg" ) ) // 清除任务标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');		
		USHORT sID   = Str2Int(strList[0]);
		USHORT sFlag = Str2Int(strList[1]);
		if( GetPlayer()->MisClearFlag( sID, sFlag ) )
		{
			//SystemNotice( "清除任务标记成功!ID[%d], FLAG[%d]", sID, sFlag );
			//SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00008), sID, sFlag );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, sID );
			param.setLong( 1, sFlag );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00008, param, szData );
			SystemNotice( szData );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "清除任务标记失败!ID[%d], FLAG[%d]", sID, sFlag );
			//SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00009), sID, sFlag );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, sID );
			param.setLong( 1, sFlag );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00009, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
		return TRUE;
	}
	else if( !strcmp(szComHead, "addmission" ) ) // 设置任务标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');		
		USHORT sMID   = Str2Int(strList[0]);
		USHORT sSID   = Str2Int(strList[1]);
		if( GetPlayer()->MisAddRole( sMID, sSID ) )
		{
			//SystemNotice( "添加任务成功!MID[%d], SID[%d]", sMID, sSID );
			//SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00010), sMID, sSID );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, sMID );
			param.setLong( 1, sSID );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00010, param, szData );
			SystemNotice( szData );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "添加任务失败!MID[%d], SID[%d]", sMID, sSID );
			//SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00011), sMID, sSID );
			char szData[128];
			CFormatParameter param(2);
			param.setLong( 0, sMID );
			param.setLong( 1, sSID );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00011, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
		return TRUE;
	}
	else if( !strcmp(szComHead, "clearmission" ) ) // 清除任务标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		USHORT sID   = Str2Int(strList[0]);
		if( GetPlayer()->MisCancelRole( sID ) )
		{
			//SystemNotice( "清除任务成功!MID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00012), sID );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "清除任务失败!MID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00013), sID );
			return FALSE;
		}
		return TRUE;
	}
	else if( !strcmp(szComHead, "delmission" ) ) // 清除任务标记
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		USHORT sID   = Str2Int(strList[0]);
		if( GetPlayer()->MisClearRole( sID ) )
		{
			//SystemNotice( "删除任务成功!MID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00014), sID );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "删除任务失败!MID[%d]", sID );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00015), sID );
			return FALSE;
		}
		return TRUE;
	}
	else if( !strcmp(szComHead, "missdk" ) )	 // 任务脚本更新
	{
		ReloadLuaSdk();
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp( szComHead, "misclear") ) // 清除角色任务标签信息和触发器信息
	{
		GetPlayer()->MisClear();
		//SystemNotice( "清除角色任务标签信息和触发器信息成功!" );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00016) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "isblock")) // 是否处于障碍区
	{
		if (m_submap->IsBlock(GetPos().x / m_submap->GetBlockCellWidth(), GetPos().y / m_submap->GetBlockCellHeight()))
			//SystemNotice("障碍");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00017));
		else
			//SystemNotice("非障碍");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00018));
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "pet")) // 召唤宠物
	{
		Long	lChaInfoID = Str2Int(strList[0]);
		Point	Pos = GetPos();
		Pos.move(rand() % 360, 3 * 100);
		CCharacter *pCha = m_submap->ChaSpawn(lChaInfoID, enumCHACTRL_PLAYER_PET, rand()%360, &Pos);
		if (pCha)
		{
			pCha->m_HostCha = this;
			pCha->SetPlayer(GetPlayer());
			pCha->m_AIType = 5;
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		else
		{
			//SystemNotice( "召唤宠物失败" );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00019) );
			return FALSE;
		}
		return TRUE;
	}
	else if (!strcmp(szComHead, "summon")) // 召唤怪物
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n >= 1)
		{
			Long	lChaInfoID = Str2Int(strList[0]);
			Point	Pos = GetPos();
			Pos.move(rand() % 360, 3 * 100);
			CCharacter *pCha = m_submap->ChaSpawn(lChaInfoID, enumCHACTRL_NONE, rand()%360, &Pos);
			if (pCha)
			{
				if(n>=2)
				{
					DWORD dwLifeTime = Str2Int(strList[1]);
					pCha->ResetLifeTime(dwLifeTime);	
				}
				if( n==3 )
				{
					int nAIType = Str2Int(strList[2]);
					pCha->m_AIType  = (BYTE)nAIType; // 设置怪物的AI类型
				}
			}
			else
			{
				//SystemNotice( "创建怪物失败!" );
				SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00020) );
				return FALSE;
			}
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		return FALSE;
	}
	else if (!strcmp(szComHead, "summonex")) // 召唤怪物扩展指令，格式:角色编号，个数，是否激活视野，ＡＩ类型
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n >= 1)
		{
			Long	lChaInfoID = Str2Int(strList[0]);
			Point	Pos;
			long	lChaNum = 1;
			if (n > 1)
				lChaNum = Str2Int(strList[1]);
			bool	bActEyeshot = false;
			if( n > 2 )
				bActEyeshot = Str2Int(strList[2]) ? true : false;
			int nAIType = 0;
			if( n > 3 )
				nAIType = Str2Int(strList[3]);
			CCharacter *pCha;
			for (long i = 0; i < lChaNum; i++)
			{
				Pos = GetPos();
				Pos.move(rand() % 360, rand() % 20 * 100);
				pCha = m_submap->ChaSpawn(lChaInfoID, enumCHACTRL_NONE, rand()%360, &Pos, bActEyeshot);
				if (pCha)
				{
					if( n > 3 )
						pCha->m_AIType = (BYTE)nAIType; // 设置怪物的AI类型
				}
				else
				{
					//SystemNotice( "创建角色失败!" );
					SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00021 ));
				}
			}
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		return FALSE;
	}
	else if (!strcmp(szComHead, "kill")) // 杀死召唤怪物，指令格式:怪物名称，范围（米，默认值8米），个数（默认为范围内的所有怪物）
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n >= 1)
		{
			const char	*szMonsName = strList[0].c_str();
			long	lRange = 8 * 100;
			long	lNum = 0;
			if (n >= 2)
				lRange = Str2Int(strList[1]) * 100;
			if (n >= 3)
				lNum = Str2Int(strList[2]);

			long	lBParam[defSKILL_RANGE_BASEP_NUM] = {GetPos().x, GetPos().y, 0};
			long	lEParam[defSKILL_RANGE_EXTEP_NUM] = {enumRANGE_TYPE_CIRCLE, lRange};
			CCharacter	*pCCha = 0, *pCFreeCha = 0;
			long	lFindNum = 0, lKillNum = 0;
			GetSubMap()->BeginSearchInRange(lBParam, lEParam);
			while (pCCha = GetSubMap()->GetNextCharacterInRange())
			{
				if (pCFreeCha)
					pCFreeCha->Free();
				pCFreeCha = 0;

				lFindNum++;
				if (pCCha->IsPlayerCha())
					continue;
				if (!strcmp(pCCha->GetName(), szMonsName))
				{
					if (lNum == 0 || lKillNum <= lNum)
					{
						pCFreeCha = pCCha;
						lKillNum++;
					}
				}
			}
			if (pCFreeCha)
				pCFreeCha->Free();

			//SystemNotice( "删除怪物数目:%u.!", lKillNum );
			SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00022), lKillNum );
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		return FALSE;
	}


	//-----------------------------------
	// 超级调试指令, 与GM指令要严格区分开
	//-----------------------------------
	if( !strcmp( szComHead, "addmoney" ) )
	{
		//AddMoney( "系统", atol(szComParam) );
		AddMoney( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00023), atol(szComParam) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp( szComHead, "addexp" ) )
	{
		AddExpAndNotic( _atoi64(szComParam) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp( szComHead, "addlifeexp" ) )
	{
		AddAttr( ATTR_CLIFEEXP, atol(szComParam) );
		//SystemNotice( "系统给了你%ld生活经验!", atol(szComParam) );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00024), atol(szComParam) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp( szComHead, "addsailexp" ) )
	{
		AddAttr( ATTR_CSAILEXP, atol(szComParam) );
		//SystemNotice( "系统给了你%ld转生经验!", atol(szComParam) );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00025), atol(szComParam) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp( szComHead, "addcess" ) )
	{
		AdjustTradeItemCess( 60000, (USHORT)atol(szComParam) );
		//SystemNotice( "添加%ld贸易税点!", atol(szComParam) );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00026), atol(szComParam) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if( !strcmp( szComHead, "setcesslevel" ) )
	{
		SetTradeItemLevel( (BYTE)atol(szComParam) );
		//SystemNotice( "设置贸易等级%ld!", atol(szComParam) );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00027), atol(szComParam) );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "make")) // 召唤道具，格式:道具编号，个数[，实例化类型][，方向（1，道具栏.其他为地面）]
	{
		LG("GMmakeLog", "begin make\n");
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if(n >= 2)
		{
			short	sID = Str2Int(strList[0]);
			short	sNum = Str2Int(strList[1]);
			short	sTo = 1; // 放入道具栏
			char	chSpawnType = enumITEM_INST_MONS;
			if (sNum < 0 || sNum > 100)
				sNum = 10;
			if (n == 3)
				chSpawnType = Str2Int(strList[2]);
			if (n == 4)
				sTo = Str2Int(strList[3]);

			LG("GMmakeLog", "cha_name = %s,sID = %d,sNum = %d,sTo = %d,chSpawnType = %c\n",
				m_name,sID,sNum,sTo,chSpawnType);

			if (sTo == 1)
			{
				if (AddItem( sID, sNum, this->GetName(), chSpawnType ))
				{
					LG("GMmakeLog", "add to kitbag successful!\n");
					return TRUE;
				}
			}
			else
			{
				SItemGrid GridContent(sID, sNum);
				ItemInstance(chSpawnType, &GridContent);
				Long	lPosX, lPosY;
				CCharacter	*pCCtrlCha = GetPlyCtrlCha();
				pCCtrlCha->GetTrowItemPos(&lPosX, &lPosY);
				if (pCCtrlCha->GetSubMap()->ItemSpawn(&GridContent, lPosX, lPosY, enumITEM_APPE_THROW, pCCtrlCha->GetID()))
				{
					LG("GMmakeLog", "add to ground successful!\n");
					return TRUE;
				}
			}
			LG("GMmakeLog", "make failed!\n");
			return FALSE;
		}
		LG("GMmakeLog", "make failed! because the param is less than 2!\n");
		return FALSE;
	}
	else if (!strcmp(szComHead, "attr")) // 角色属性，格式:属性编号，属性值.
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n < 2)
			return FALSE;
		CCharacter	*pCCha = this;

		long	lAttrID = Str2Int(strList[0]);


		//long	lAttrVal = Str2Int(strList[1]);
		LONG64 lAttrVal = _atoi64(strList[1].c_str());

		if (n == 3)
			pCCha = g_pGameApp->FindChaByID(Str2Int(strList[2]));
		if (!pCCha)
		{
			//SystemNotice("没有搜索到目标或目标不是角色类对象!");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00028));
			return FALSE;
		}
		pCCha->m_CChaAttr.ResetChangeFlag();
		pCCha->SetBoatAttrChangeFlag(false);
		pCCha->setAttr(lAttrID, lAttrVal);
		if (pCCha->IsPlayerOwnCha())
		{
			if (pCCha->IsBoat())
				g_CParser.DoString("ShipAttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCCha, DOSTRING_PARAM_END);
			else
				g_CParser.DoString("AttrRecheck", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCCha, DOSTRING_PARAM_END);
		}
		else
		{
			g_CParser.DoString("ALLExAttrSet", enumSCRIPT_RETURN_NONE, 0, enumSCRIPT_PARAM_LIGHTUSERDATA, 1, pCCha, DOSTRING_PARAM_END);
		}
		if (pCCha->GetPlayer())
		{
			pCCha->GetPlayer()->RefreshBoatAttr();
			pCCha->SyncBoatAttr(enumATTRSYN_TASK);
		}
		pCCha->SynAttr(enumATTRSYN_TASK);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "itemattr")) // 角色道具属性，格式:位置类型（1，装备栏.2，道具栏），位置编号，属性编号，属性值.
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 4)
			return FALSE;

		Char	chPosType = Str2Int(strList[0]);
		Long	lPosID = Str2Int(strList[1]);
		SItemGrid	*pSItem = GetItem2(chPosType, lPosID);
		if (!pSItem)
			return FALSE;
		Long	lAttrID = Str2Int(strList[2]);
		Short	sAttr = Str2Int(strList[3]);
		pSItem->SetAttr(lAttrID, sAttr);
		pSItem->SetInstAttr(lAttrID, sAttr);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "light")) // 角色大地图灯光范围，格式:范围（米）.
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 1)
			return FALSE;

		long	lLight = Str2Int(strList[0]);
		if (lLight < 0)
			return FALSE;
		GetPlayer()->SetMMaskLightSize(lLight);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "seeattr")) // 查看角色属性，格式:WorldID，属性编号.
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 2)
			return FALSE;

		uLong	ulWorldID = Str2Int(strList[0]);
		short	sAttrID = Str2Int(strList[1]);
		CCharacter	*pCCha = g_pGameApp->FindChaByID(ulWorldID);
		if (!pCCha)
		{
			//SystemNotice("没有搜索到目标或目标不是角色类对象!");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00028));
			return FALSE;
		}
		//SystemNotice("目标[%s]的属性为%d的值是%d!", pCCha->m_CLog.GetLogName(), sAttrID, pCCha->getAttr(sAttrID));
		//SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00029), pCCha->m_CLog.GetLogName(), sAttrID, pCCha->getAttr(sAttrID));
		char szData[128] = "";
		CFormatParameter param(3);
		param.setString( 0, pCCha->m_CLog.GetLogName() );
		param.setLong( 1, sAttrID );
		param.setInt64( 2, pCCha->getAttr( sAttrID ));
		RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00029, param, szData );
		SystemNotice( szData );
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "forge")) // 道具精炼，格式:精炼等级增加值，道具栏位置
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		char	chAddLv = Str2Int(strList[0]);
		short	sGridID = 0;
		if (n == 2)
			sGridID = Str2Int(strList[1]);

		SItemGrid *pItemCont = GetKitbag()->GetGridContByID(sGridID);
		if (pItemCont)
		{
			CItemRecord	*pCItemRec = GetItemRecordInfo(pItemCont->sID);
			if (pCItemRec && pCItemRec->chForgeLv > 0)
			{
				GetKitbag()->SetChangeFlag(false);
				pItemCont->AddForgeLv(chAddLv);
				ItemForge(pItemCont, chAddLv);
				SynKitbagNew(enumSYN_KITBAG_FORGES);
				LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
				return TRUE;
			}
		}
		return FALSE;
	}
	else if (!strcmp(szComHead, "skill")) // 增加技能，格式:编号，等级
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		short	sID = Str2Int(strList[0]);
		char	chLv = Str2Int(strList[1]);
		bool	bLimit = true;
		if (n == 3 && Str2Int(strList[2]) == 0)
			bLimit = false;

		if (!GetPlayer()->GetMainCha()->LearnSkill(sID, chLv, true, false, bLimit))
		{
			//SystemNotice("学习技能失败（请检查学习等级，职业限制，前置技能限制等）:编号 %d，等级 %d.!", sID, chLv);
			//SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00030), sID, chLv);
			char szData[128] = "";
			CFormatParameter param(3);
			param.setLong( 0, sID );
			param.setString( 1, chLv );
			RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00030, param, szData );
			SystemNotice( szData );
			return FALSE;
		}
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "delitem"))
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n == 6)
		{
			long	lItemID = Str2Int(strList[0]);
			long	lItemNum = Str2Int(strList[1]);
			char	chFromType = Str2Int(strList[2]);
			short	sFromID = Str2Int(strList[3]);
			char	chToType = Str2Int(strList[4]);
			char	chForcible = Str2Int(strList[5]);
			if (Cmd_RemoveItem(lItemID, lItemNum, chFromType, sFromID, chToType, 0, true, chForcible) != enumITEMOPT_SUCCESS)
			{
				//SystemNotice("删除道具失败!");
				SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00031));
				return FALSE;
			}
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
		return FALSE;
	}
	else if (!strcmp(szComHead, "lua")) // 本GameServer执行脚本
	{
		lua_dostring(g_pLuaState, szComParam);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "lua_all")) // 本组GameServer执行脚本
	{
		WPACKET WtPk	=GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_DO_STRING);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, szComParam);
		ReflectINFof(this, WtPk);//通告
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "setping"))
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 1)
		{
			//SystemNotice("参数错误");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00032));
			return FALSE;
		}
		Long	lPing = Str2Int(strList[0]);
		m_lSetPing = lPing;
		SendPreMoveTime();
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "getping"))
	{
		//SystemNotice("当前ping:%d", m_SMoveInit.usPing);
		SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00033), m_SMoveInit.usPing);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "senddata"))
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 2)
		{
			//SystemNotice("参数错误");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00032));
			return FALSE;
		}

		m_timerNetSendFreq.SetInterval((DWORD)Str2Int(strList[0]));
		m_ulNetSendLen = (uLong)Str2Int(strList[1]);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "setpinginfo"))
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 2)
		{
			//SystemNotice("参数错误");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00032));
			return FALSE;
		}

		m_timerPing.SetInterval((DWORD)Str2Int(strList[0]));
		m_ulPingDataLen = (uLong)Str2Int(strList[1]);
		LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
		return TRUE;
	}
	else if (!strcmp(szComHead, "addkb")) // 增加背包容量，格式:容量的增量[,WorldID]
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		short	sAddCap = Str2Int(strList[0]);
		CCharacter	*pCCha = this;
		if (n == 2)
			pCCha = g_pGameApp->FindChaByID(Str2Int(strList[1]));
		if (!pCCha)
		{
			//SystemNotice("增加背包容量失败（找不到该角色）.!");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00034));
			return FALSE;
		}

		if (!pCCha->AddKitbagCapacity(sAddCap))
		{
			//SystemNotice("增加 %s 的背包容量失败（容量非法）.!", pCCha->GetName());
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00035), pCCha->GetName());
			return FALSE;
		}
		else
		{
			//pCCha->SystemNotice("增加背包容量成功，当前容量 %d.!", pCCha->GetKitbag()->GetCapacity());
			pCCha->SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00036), pCCha->GetKitbag()->GetCapacity());
			if (pCCha != this)
				//SystemNotice("增加 %s 的背包容量成功，当前容量 %d.!", pCCha->GetName(), pCCha->GetKitbag()->GetCapacity());
				//SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00037), pCCha->GetName(), pCCha->GetKitbag()->GetCapacity());
			{
				char szData[128];
				CFormatParameter param(2);
				param.setString( 0, pCCha->GetName() );
				param.setLong( 1, pCCha->GetKitbag()->GetCapacity() );
				RES_FORMAT_STRING( GM_CHARACTERSUPERCMD_CPP_00037, param, szData );
				SystemNotice( szData );
			}
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
		}
	}
	else if (!strcmp(szComHead, "itemvalid")) // 设置背包道具有效性
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		if (n != 2)
		{
			//SystemNotice("格式错误!");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00038));
			return FALSE;
		}
		short	sPosID = Str2Int(strList[0]);
		bool	bValid = Str2Int(strList[1]) != 0 ? true : false;

		if (!SetKitbagItemValid(sPosID, bValid))
		{
			//SystemNotice("设置背包道具有效性失败!");
			SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00039));
			return FALSE;
		}
		else
			LG("ServerRunLog", "ChaID: %i, ChaName: %s, CMD: %s, Param: %s\n", GetPlayer()->GetID(), GetName(), pszCmd, pszParam);
			return TRUE;
	}
	else if (!strcmp(szComHead, "playsave")) // 保存当前GameServer上的玩家到log文件
	{
		g_pGameApp->LogPlayer();
	}
	else if(!strcmp(szComHead, "OpenMapEntry"))
	{
		if(szComParam == NULL)
			return FALSE;

		if(strlen(szComParam) < 2)
			return FALSE;

		CMapRes	*pCMapRes = g_pGameApp->FindMapByName(szComParam, true);

		if(pCMapRes)
			pCMapRes->OpenMapEntry();
		else
		{
			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MT_MAP_ADMIN);
			WRITE_STRING(wpk, szComParam);
			WRITE_CHAR(wpk, enumMAPADMIN_OPEN_MAP_ENTRY);
			
			ReflectINFof(this, wpk);
		}
	}
	else if(!strcmp(szComHead, "CloseMapEntry"))
	{
		if(szComParam == NULL)
			return FALSE;

		if(strlen(szComParam) < 2)
			return FALSE;

		CMapRes	*pCMapRes = g_pGameApp->FindMapByName(szComParam, true);

		if(pCMapRes)
			pCMapRes->CloseMapEntry();
		else
		{
			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MT_MAP_ADMIN);
			WRITE_STRING(wpk, szComParam);
			WRITE_CHAR(wpk, enumMAPADMIN_CLOSE_MAP_ENTRY);
			
			ReflectINFof(this, wpk);
		}
	}
	else if(!strcmp(szComHead, "OpenMap"))
	{
		if(szComParam == NULL)
			return FALSE;

		if(strlen(szComParam) < 2)
			return FALSE;

		CMapRes	*pCMapRes = g_pGameApp->FindMapByName(szComParam, true);

		if(pCMapRes)
			pCMapRes->OpenMap();
		else
		{
			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MT_MAP_ADMIN);
			WRITE_STRING(wpk, szComParam);
			WRITE_CHAR(wpk, enumMAPADMIN_OPEN_MAP);
			
			ReflectINFof(this, wpk);
		}
	}
	else if(!strcmp(szComHead, "CloseMap"))
	{
		if(szComParam == NULL)
			return FALSE;

		if(strlen(szComParam) < 2)
			return FALSE;

		CMapRes	*pCMapRes = g_pGameApp->FindMapByName(szComParam, true);

		if(pCMapRes)
			pCMapRes->CloseMap();
		else
		{
			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MT_MAP_ADMIN);
			WRITE_STRING(wpk, szComParam);
			WRITE_CHAR(wpk, enumMAPADMIN_CLOSE_MAP);
			
			ReflectINFof(this, wpk);
		}
	}
	else if(!strcmp(szComHead, "CheckMapState"))
	{
		if(szComParam == NULL)
			return FALSE;

		if(strlen(szComParam) < 2)
			return FALSE;

		CMapRes	*pCMapRes = g_pGameApp->FindMapByName(szComParam, true);

		// 如果是请求的是当前GameServer的地图则直接操作
		if(pCMapRes)
		{
			string str;
			pCMapRes->CheckMapState(str);
			this->SystemNotice(str.c_str());
		}
		else
		{
			// 如果不是则由GateServer进行消息转发，不用遍历全部GateServer
			WPACKET	wpk	=GETWPACKET();
			WRITE_CMD(wpk, CMD_MT_MAP_ADMIN);
			WRITE_STRING(wpk, szComParam);
			WRITE_CHAR(wpk, enumMAPADMIN_CHECK_MAP);

			ReflectINFof(this, wpk);
		}
	}
	else if (!strcmp(szComHead, "closecrystal"))
	{
		g_StoreSystem.SetCrystalTradeOpen(false);
		LG("CrystalOpen","ChaID: %i, ChaName: %s, CMD: closecrystal \n", GetPlayer()->GetID(), GetName() );
		return true;
	}
	else if (!strcmp(szComHead, "opencrystal"))
	{
		g_StoreSystem.SetCrystalTradeOpen(true);
		LG("CrystalOpen","ChaID: %i, ChaName: %s, CMD: closecrystal \n", GetPlayer()->GetID(), GetName() );
		return true;	
	}
#ifdef XTRAP_S
	else if(!strcmp(szComHead, "loadmap"))
	{
		this->MapFileChange();
		return true;
	}
#endif
	return false;
T_E}

// 查询服务器状态
void CCharacter::DoCommand_CheckStatus(cChar *pszCommand, uLong ulLen)
{T_B
	Char szComHead[256], szComParam[256];
	std::string	strList[10];
	
	CPlayer *pPlayer = GetPlayer(); 
	if(!pPlayer) 
		return ;

	uChar uchGMLv = pPlayer->GetGMLev();

	int n = Util_ResolveTextLine(pszCommand, strList, 10, ' ');
	//strncpy(szComHead, strlwr((char *)strList[0].c_str()), 256 - 1);
	strncpy_s(szComHead, sizeof(szComHead), (char *)strList[0].c_str(), _TRUNCATE );
	_strlwr_s( szComHead, sizeof(szComHead));
	//strncpy(szComParam, strList[1].c_str(), 256 - 1);
	strncpy_s( szComParam, sizeof(szComParam), strList[1].c_str(), _TRUNCATE );

	string strCmd   = szComHead;
	string strParam = szComParam;

	if(!PrivilegeCheck::Instance()->HasPrivilege(uchGMLv,strCmd.c_str()))
	{
		SystemNotice(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00001));
		return ;
	}

	if(strCmd=="game_status")	 // 返回gameserver的状态
	{
		char szInfo[255];
		//sprintf(szInfo, "fps:%d tick:%d player:%d mgr:%d\n", g_pGameApp->m_dwFPS, 
		//	                     g_pGameApp->m_dwRunCnt, g_pGameApp->m_dwPlayerCnt,
		//						 g_pGameApp->m_dwActiveMgrUnit);
		_snprintf_s(szInfo,sizeof(szInfo),_TRUNCATE, "fps:%d tick:%d player:%d mgr:%d\n", g_pGameApp->m_dwFPS, 
			g_pGameApp->m_dwRunCnt, g_pGameApp->m_dwPlayerCnt,
			g_pGameApp->m_dwActiveMgrUnit);

		SystemNotice(szInfo);
	}
	else if (strCmd=="ping_game") // 查询角色到GameServer逻辑层的ping值
	{
		int n = Util_ResolveTextLine(szComParam, strList, 10, ',');
		WPACKET WtPk  = GETWPACKET();
		WRITE_CMD(WtPk, CMD_MM_QUERY_CHAPING);
		WRITE_LONG(WtPk, GetID());
		WRITE_STRING(WtPk, strList[0].c_str());
		ReflectINFof(this, WtPk);//通告
	}
T_E}

	
// NPC对玩家自己私人的说话， 别人无法看见的
void NPC_PrivateTalk(CCharacter *pCha, CCharacter *pNPC, const char *pszText)
{
	// Add by lark.li 20090311 begin
	if(!pszText)
		return;
	// End

	WPACKET wpk	= GETWPACKET();
	WRITE_CMD(wpk, CMD_MC_SAY);
	WRITE_LONG(wpk, pNPC->m_ID);
	WRITE_SEQ(wpk, pszText, uShort(strlen(pszText) + 1));
	pCha->ReflectINFof(pCha, wpk);
}		

// 玩家请求帮助查询
void CCharacter::HandleHelp(cChar *pszCommand, uLong ulLen)
{T_B
	if(!pszCommand)           return;
	
	if(ulLen==0 || strlen(pszCommand)==0) 
	{
		//SystemNotice( "你想打听什么?" );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00040) );
		return;
	}

	// 如果玩家距离npc太远, 也不考虑
	if(GetSubMap()==NULL) return;
	if(strcmp(GetSubMap()->GetName(), "garner")!=0) return;

	int x = this->GetPos().x / 100;
	int y = this->GetPos().y / 100;

	if(g_HelpNPCList.size()==0) return;

	CCharacter *pNPC1 = g_HelpNPCList.front();
	if(pNPC1==NULL)
	{
		//LG("error", "查询NPC为空\n");
		LG("error", "inquire NPC is empty\n");
		return;
	}

	if(! ( abs(x - 2222) < 4 && abs(y - 2888) < 4) )
	{
		//SystemNotice( "附近没有可以回答问题的人!" );
		SystemNotice( RES_STRING(GM_CHARACTERSUPERCMD_CPP_00041) );
		return;
	}
	
	std::string	strList[3];
	int n = Util_ResolveTextLine(pszCommand, strList, 3, ' ');
	
	const char *pszHelp = FindHelpInfo(strList[0].c_str());
	
	
	char szTip[128]; 
	//sprintf(szTip, "打听有关'%s':\n", strList[0].c_str()); 
	//sprintf(szTip, RES_STRING(GM_CHARACTERSUPERCMD_CPP_00042), strList[0].c_str()); 
	_snprintf_s(szTip,sizeof(szTip),_TRUNCATE, RES_STRING(GM_CHARACTERSUPERCMD_CPP_00042), strList[0].c_str()); 

	if(strList[0]=="time")	// 当前时间查询
	{
		//SystemNotice( szTip );
		//GetCurrentTime()
		//SystemNotice( "force is strong with this one!");
	}
	//else if(strList[0]=="ryan" || strList[0]=="新一代爆头专家")
	else if(strList[0]=="ryan" || strList[0]==RES_STRING(GM_CHARACTERSUPERCMD_CPP_00043))
	{
		SystemNotice( szTip );
		NPC_PrivateTalk(this, pNPC1, "force is strong with this one!");
		return;
	}
	
	if(pszHelp==NULL)
	{
		SystemNotice( szTip );
		//NPC_PrivateTalk(this, pNPC1, "真糟糕,看来我年纪大了,你问倒我了!");
		NPC_PrivateTalk(this, pNPC1, RES_STRING(GM_CHARACTERSUPERCMD_CPP_00044));
	}
	else
	{
		//if(strcmp(GetName(), "新一代爆头专家")==0) // 此角色打听信息不收钱,不影响游戏平衡
		if(strcmp(GetName(), RES_STRING(GM_CHARACTERSUPERCMD_CPP_00043))==0) // 此角色打听信息不收钱,不影响游戏平衡
		{
			SystemNotice( szTip );
			NPC_PrivateTalk(this, pNPC1, pszHelp);
		}
		//else if(TakeMoney("万事通", 100))
		else if(TakeMoney(RES_STRING(GM_CHARACTERSUPERCMD_CPP_00045), 100))
		{
			SystemNotice( szTip );
			NPC_PrivateTalk(this, pNPC1, pszHelp);
		}
		else
		{
			SystemNotice( szTip );
			//NPC_PrivateTalk(this, pNPC1, "对不起, Money Talk!" );
			NPC_PrivateTalk(this, pNPC1, RES_STRING(GM_CHARACTERSUPERCMD_CPP_00046) );
		}
	}
T_E}