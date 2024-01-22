#include "stdafx.h"
#include "Character.h"
#include "Player.h"
#include "GameDB.h"
#include "ChaAttrType.h"
#include "SubMap.h"
#include "Config.h"
#include "Guild.h"
#include "CommFunc.h"
#include "lua_gamectrl.h"
#include "atltime.h"
#include "StringPoolL.h"
#include "EnumSQLStatements.h"

char	szDBLog[256] = "DBData";

#define defKITBAG_DATA_STRING_LEN	8192
#define defSKILLBAG_DATA_STRING_LEN	1500
#define defSHORTCUT_DATA_STRING_LEN	1500
#define defSSTATE_DATE_STRING_LIN	1024

const int g_cnCol = 64;
string g_buf[g_cnCol];

//������Щȫ�ֱ���Ӧ�ö��趨��ʼֵ{0} -Waiting Add 2009-03-23
//char g_sql[1024 * 1024]={0};
char g_sql[1024 * 10]={0}; // �������ж����8K���趨9K�Ѿ��㹻
char g_kitbag[defKITBAG_DATA_STRING_LEN]={0};
char g_kitbagTmp[defKITBAG_DATA_STRING_LEN]={0};
char g_equip[defKITBAG_DATA_STRING_LEN]={0};
char g_look[defLOOK_DATA_STRING_LEN]={0};
char g_skillbag[defSKILLBAG_DATA_STRING_LEN]={0};
char g_shortcut[defSHORTCUT_DATA_STRING_LEN]={0};
char g_skillstate[defSSTATE_DATE_STRING_LIN]={0};

// Add by lark.li 20080723 begin
char g_extendAttr[ROLE_MAXSIZE_DBMISCOUNT]={0};
// End

// ����������Ϣ�洢
char g_szMisInfo[ROLE_MAXSIZE_DBMISSION]={0};
char g_szRecord[ROLE_MAXSIZE_DBRECORD]={0};
char g_szTrigger[ROLE_MAXSIZE_DBTRIGGER]={0};
char g_szMisCount[ROLE_MAXSIZE_DBMISCOUNT]={0};

bool CTableMaster::Init(void)
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   cha_id1, cha_id2, finish, relation\
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	short sExec =  exec_sql_direct(g_sql);
	// Constant query, no need to sql_safe.
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(master)��ʼ����������", "����", MB_OK);
		char buffer[255];
//		sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "master");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "master");
		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

unsigned long CTableMaster::GetMasterDBID(CPlayer *pPlayer)
{
	if(!pPlayer)
	{
		return 0;
	}
	CCharacter *pCha = pPlayer->GetMainCha();
	
	if (!pCha)
	{
		return 0;
	}

	int nIndex = 0;
	char param[] = "cha_id2";
	char filter[80]; //sprintf(filter, "cha_id1=%d", pPlayer->GetDBChaId());
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id1=%d", pPlayer->GetDBChaId());
	int r = _get_row(g_buf, g_cnCol, param, filter);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		return (unsigned long)(Str2Int(g_buf[nIndex++]));
	}
	else
	{
		return (unsigned long)0;
	}
}

bool CTableMaster::IsMasterRelation(int masterID, int prenticeID)
{
	char param[] = "count(*)";
	char filter[80]; 
	//sprintf(filter, "(cha_id1=%d) and (cha_id2=%d)", prenticeID, masterID);
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id1=%d) and (cha_id2=%d)", prenticeID, masterID);
	int r = _get_row(g_buf, g_cnCol, param, filter);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		if(Str2Int(g_buf[0]) > 0)
			return true;
	}
	
	return false;
}

bool CTableCha::Init(void)
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   cha_id, cha_name, motto, icon, version, pk_ctrl, mem_addr, act_id, guild_id, guild_stat, guild_permission, job, degree, exp, \
				   hp, sp, ap, tp, gd, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, map, main_map, map_x, map_y, radius, \
				   angle, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, birth, login_cha, live_tp, bank, \
				   delflag, operdate, skill_state, kitbag, kitbag_tmp, kb_locked, credit, store_item \
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	short sExec =  exec_sql_direct(g_sql);
	// Constant query, no need to safe_sql

	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(character)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "character");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "character");
		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

//-----------------------
// ��ɫ������Ϸʱ��ȡ���� 
//-----------------------
bool CTableCha::ReadAllData(CPlayer *pPlayer, DWORD cha_id)
{T_B
	if(!pPlayer)
	{
		//LG("enter_map", "�����ݿ����PlayerΪ��.\n");
		LG("enter_map", "Loading database error��Player is empty.\n");
		return false;
	}
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha || (pPlayer->GetDBChaId() != cha_id))
	{
		//LG("enter_map", "�����ݿ��������ɫ�����ڻ�ƥ��.\n");
		LG("enter_map", "Loading database error,the Main character is inexistence or not matching.\n");
		return false;
	}

	int nIndex = 0;
#ifdef SHUI_JING
	char param[] = "act_id, guild_stat, guild_id, hp, sp, exp, radius, angle, cha_name, motto, icon, version, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, main_map, map_x, map_y, birth, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, login_cha, kitbag, kitbag_tmp, map_mask, skill_state, bank, kb_locked, credit, store_item, extend, flatcoins";
#else
	//char param[] = "act_id, guild_stat, guild_id, hp, sp, exp, radius, angle, cha_name, motto, icon, version, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, main_map, map_x, map_y, birth, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, login_cha, kitbag, kitbag_tmp, map_mask, skill_state, bank, kb_locked, credit, store_item, extend";
#endif
	//char filter[80]; //sprintf(filter, "cha_id=%d", cha_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id=%d", cha_id);
	const char procedure[] = "{CALL dbo.ReadAllData(?)}";
	int r = _get_row_stored_procedure(g_buf, g_cnCol, procedure, "dbo", "ReadAllData", NULL, 1, &cha_id);
	int	r1 = get_affected_rows();
	//LG("enter_map", "�����ݿ�ɹ���_get_row.\n");
	LG("enter_map", "Loading database succeed��_get_row.\n");
	if (DBOK(r) && r1 > 0)
	{
		pPlayer->SetDBActId(Str2Int(g_buf[nIndex++]));
		pCha->SetGuildState( Str2Int(g_buf[nIndex++]) );
		pCha->SetGuildID( Str2Int(g_buf[nIndex++]) );
		pCha->SetGuildType( game_db.GetGuildTypeByID(pCha, pCha->GetGuildID()) );
		//pCha->setAttr(ATTR_GUILD_STATE, Str2Int(g_buf[nIndex++]), 1);
		//pCha->setAttr(ATTR_GUILD, Str2Int(g_buf[nIndex++]), 1);
		//pCha->setAttr(ATTR_GUILD_TYPE, game_db.GetGuildTypeByID(pCha, pCha->getAttr(ATTR_GUILD)), 1);

		pCha->setAttr(ATTR_HP, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_SP, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_CEXP, _atoi64(g_buf[nIndex++].c_str()), 1);

		pCha->SetRadius(Str2Int(g_buf[nIndex++]));
		pCha->SetAngle(Str2Int(g_buf[nIndex++]));
		pCha->SetName((char *)g_buf[nIndex++].c_str());
		Char szLogName[defLOG_NAME_LEN] = "";
		//sprintf(szLogName, "Cha-%s+%u", pCha->GetName(), pCha->GetID());
		_snprintf_s(szLogName,sizeof(szLogName),_TRUNCATE, "Cha-%s+%u", pCha->GetName(), pCha->GetID());
		pCha->m_CLog.SetLogName(szLogName);

		pCha->SetMotto(g_buf[nIndex++].c_str());
		pCha->SetIcon(Str2Int(g_buf[nIndex++]));

		long lVer = Str2Int(g_buf[nIndex++]);
		if (pCha->getAttr(ATTR_HP) < 0) // �½�ɫ
			lVer = defCHA_TABLE_NEW_VER;
		pCha->SetPKCtrl(Str2Int(g_buf[nIndex++]));

		//strcpy(pCha->m_CChaAttr.m_szName, pCha->GetName());
		strncpy_s( pCha->m_CChaAttr.m_szName, sizeof(pCha->m_CChaAttr.m_szName), pCha->GetName(), _TRUNCATE );
		
		pCha->setAttr(ATTR_LV, Str2Int(g_buf[nIndex++]), 1);
		
		// ���ݿ�
		//pCha->setAttr(ATTR_JOB, g_GetJobID(g_buf[nIndex++].c_str()), 1);
		pCha->setAttr(ATTR_JOB, Str2Int(g_buf[nIndex++]), 1);

		pCha->setAttr(ATTR_GD, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_AP, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_TP, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_BSTR, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_BDEX, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_BAGI, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_BCON, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_BSTA, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_BLUK, Str2Int(g_buf[nIndex++]), 1);

		pCha->setAttr(ATTR_SAILLV, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_CSAILEXP, _atoi64(g_buf[nIndex++].c_str()), 1);
		pCha->setAttr(ATTR_CLEFT_SAILEXP, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_LIFELV, Str2Int(g_buf[nIndex++]), 1);
		pCha->setAttr(ATTR_CLIFEEXP, _atoi64(g_buf[nIndex++].c_str()), 1);
		pCha->setAttr(ATTR_LIFETP, Str2Int(g_buf[nIndex++]), 1);

		pCha->SetBirthMap(g_buf[nIndex++].c_str());
		long lPosX = Str2Int(g_buf[nIndex++]);
		long lPosY = Str2Int(g_buf[nIndex++]);
		pCha->SetPos(lPosX, lPosY);
		pCha->SetBirthCity(g_buf[nIndex++].c_str());
		//LG("enter_map", "���ý�ɫ�������ݳɹ�.\n");

		try
		{
			int	nLookDataID = nIndex;
			if (!pCha->String2LookDate(g_buf[nIndex++]))
			{
				//LG("enter_map", "�������У��ʹ���.\n");
				LG("enter_map", "Appearance data check sum error.\n");
				//LG("У��ʹ���", "��ɫ��dbid %u��name %s��resid %u���ĸĹ�����У��ʹ���.\n", cha_id, pCha->GetLogName(), pCha->GetKitbagRecDBID());
				LG("Check sum error", "the character (dbid %u��name %s��resid %u)'s change appearance data check sum error.\n", cha_id, pCha->GetLogName(), pCha->GetKitbagRecDBID());
				return false;
			}
			pCha->SetCat(pCha->m_SChaPart.sTypeID);
			//LG("enter_map", "���ý�ɫ��۳ɹ�.\n");
		}
		catch (...)
		{
			//LG("enter_map", "Strin2LookData����!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
			LG("enter_map", "Strin2LookData error!!\n");
			//LG("enter_map", "����ַ��� %s\n", g_buf[nIndex - 1]);
			LG("enter_map", "Appearance String %s\n", g_buf[nIndex - 1]);
			throw;
		}

		int	nSkillBagDataID = nIndex;
		String2SkillBagData(&pCha->m_CSkillBag, g_buf[nIndex++]);
		//LG("enter_map", "���ý�ɫ�������ɹ�.\n");

		int	nSortcutDataID = nIndex;
		String2ShortcutData(&pCha->m_CShortcut, g_buf[nIndex++]);
		//LG("enter_map", "���ý�ɫ������ɹ�.\n");

		// ��ȡ������Ϣ
		pPlayer->MisClear();
		memset( g_szMisInfo, 0, ROLE_MAXSIZE_DBMISSION );
		//strncpy( g_szMisInfo, g_buf[nIndex++].c_str(), ROLE_MAXSIZE_DBMISSION - 1 );
		strncpy_s( g_szMisInfo, sizeof(g_szMisInfo), g_buf[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInit( g_szMisInfo ) )
		{
			//pCha->SystemNotice( "�ý�ɫ�����¼������Ϣ��ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00009) );

		}
		//LG("enter_map", "���ý�ɫ����1�ɹ�.\n");

		memset( g_szRecord, 0, ROLE_MAXSIZE_DBRECORD );
		//strncpy( g_szRecord, g_buf[nIndex++].c_str(), ROLE_MAXSIZE_DBRECORD - 1 );
		strncpy_s( g_szRecord, sizeof(g_szRecord), g_buf[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInitRecord( g_szRecord ) )
		{
			//pCha->SystemNotice( "�ý�ɫ������ʷ��¼������Ϣ��ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00010) );
		}
		//LG("enter_map", "���ý�ɫ����2�ɹ�.\n");

		memset( g_szTrigger, 0, ROLE_MAXSIZE_DBTRIGGER );
		//strncpy( g_szTrigger, g_buf[nIndex++].c_str(), ROLE_MAXSIZE_DBTRIGGER - 1 );
		strncpy_s( g_szTrigger, sizeof(g_szTrigger), g_buf[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInitTrigger( g_szTrigger ) )
		{
			//pCha->SystemNotice( "�ý�ɫ���񴥷������ݳ�ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00011) );
		}
		//LG("enter_map", "���ý�ɫ����3�ɹ�.\n");

		memset( g_szMisCount, 0, ROLE_MAXSIZE_DBMISCOUNT );
		//strncpy( g_szMisCount, g_buf[nIndex++].c_str(), ROLE_MAXSIZE_DBMISCOUNT - 1 );
		strncpy_s( g_szMisCount, sizeof(g_szMisCount), g_buf[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInitMissionCount( g_szMisCount ) )
		{
			//pCha->SystemNotice( "�ý�ɫ�������������ݳ�ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00012) );
		}
		//LG("enter_map", "���ý�ɫ����4�ɹ�.\n");

		string strList[2];
		Util_ResolveTextLine(g_buf[nIndex++].c_str(), strList, 2, ',');
		pPlayer->SetLoginCha(Str2Int(strList[0]), Str2Int(strList[1]));

		//if (lVer != defCHA_TABLE_NEW_VER) // ��Ҫ�汾ת��
		//	SaveTableVer(cha_id);

		pCha->SetKitbagRecDBID(Str2Int(g_buf[nIndex++]));
        
        pCha->SetKitbagTmpRecDBID(Str2Int(g_buf[nIndex++]));//��ȡ��ʱ��������ԴID
        
		pPlayer->SetMapMaskDBID(Str2Int(g_buf[nIndex++]));
		g_strChaState[0] = g_buf[nIndex++];
		pPlayer->Strin2BankDBIDData(g_buf[nIndex++]);

        //����������
        int iLocked = Str2Int(g_buf[nIndex++]);
        pCha->GetKitbag()->SetPwdLockState(iLocked);
        
		//����
		int nCredit = Str2Int(g_buf[nIndex++]);
		pCha->SetCredit(nCredit);

		pCha->SetStoreItemID(Str2Int(g_buf[nIndex++]));

		// Add by lark.li 20080723 begin
		Strin2ChaExtendAttr(pCha, g_buf[nIndex++]);
		// End
#ifdef SHUI_JING
		pCha->SetFlatMoney( atoi(g_buf[nIndex++].c_str()) );
#endif
		//LG("enter_map", "����ȫ�����ݳɹ�.\n");
		LG("enter_map", "Set the whole data succeed.\n");	
}
	else
	{
		//LG("enter_map", "�����ݿ����_get_row()����ֵ��%d.%u\n", r);
		LG("enter_map", "Loading database error,_get_row() return value:%d.%u\n", r, r1);
		return false;
	}

	return true;
T_E}

bool CTableCha::ReadAllDataEx(CPlayer *pPlayer, DWORD cha_id)
{T_B
	if(!pPlayer)
	{
		//LG("enter_map", "�����ݿ����PlayerΪ��.\n");
		LG("enter_map", "Loading database error��Player is empty.\n");
		return false;
	}
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha || (pPlayer->GetDBChaId() != cha_id))
	{
		//LG("enter_map", "�����ݿ��������ɫ�����ڻ�ƥ��.\n");
		LG("enter_map", "Loading database error,the Main character is inexistence or not matching.\n");
		return false;
	}

	int nIndex = 0;
#ifdef SHUI_JING
	char param[] = "act_id, guild_stat, guild_id, hp, sp, exp, radius, angle, cha_name, motto, icon, version, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, main_map, map_x, map_y, birth, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, login_cha, kitbag, kitbag_tmp, map_mask, skill_state, bank, kb_locked, credit, store_item, extend, flatcoins";
#else
	char param[] = "act_id, guild_stat, guild_id, hp, sp, exp, radius, angle, cha_name, motto, icon, version, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, main_map, map_x, map_y, birth, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, login_cha, kitbag, kitbag_tmp, map_mask, skill_state, bank, kb_locked, credit, store_item, extend";
#endif
	char filter[80]; //sprintf(filter, "cha_id=%d", cha_id);
	string stringBufs[64];

	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id=%d", cha_id);
	//int r = _get_row(stringBufs, 64, param, filter);
	int r  = _get_rowSafely(stringBufs, 64, param, GAME_CTABLECHA_READALLDATAEX, NULL, 1, &cha_id);
	int	r1 = get_affected_rows();

	//LG("enter_map", "�����ݿ�ɹ���_get_row.\n");
	LG("enter_map", "Loading database succeed��_get_row.\n");
	if (DBOK(r) && r1 > 0)
	{
		pPlayer->SetDBActId(Str2Int(stringBufs[nIndex++]));
		pCha->SetGuildState( Str2Int(stringBufs[nIndex++]) );
		pCha->SetGuildID( Str2Int(stringBufs[nIndex++]) );
		pCha->SetGuildType( game_db.GetGuildTypeByID(pCha, pCha->GetGuildID()) );
		//pCha->setAttr(ATTR_GUILD_STATE, Str2Int(g_buf[nIndex++]), 1);
		//pCha->setAttr(ATTR_GUILD, Str2Int(g_buf[nIndex++]), 1);
		//pCha->setAttr(ATTR_GUILD_TYPE, game_db.GetGuildTypeByID(pCha, pCha->getAttr(ATTR_GUILD)), 1);

		pCha->setAttr(ATTR_HP, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_SP, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_CEXP, _atoi64(stringBufs[nIndex++].c_str()), 1);

		pCha->SetRadius(Str2Int(stringBufs[nIndex++]));
		pCha->SetAngle(Str2Int(stringBufs[nIndex++]));
		pCha->SetName((char *)stringBufs[nIndex++].c_str());
		Char szLogName[defLOG_NAME_LEN] = "";
		//sprintf(szLogName, "Cha-%s+%u", pCha->GetName(), pCha->GetID());
		_snprintf_s(szLogName,sizeof(szLogName),_TRUNCATE, "Cha-%s+%u", pCha->GetName(), pCha->GetID());
		pCha->m_CLog.SetLogName(szLogName);

		pCha->SetMotto(stringBufs[nIndex++].c_str());
		pCha->SetIcon(Str2Int(stringBufs[nIndex++]));

		long lVer = Str2Int(stringBufs[nIndex++]);
		if (pCha->getAttr(ATTR_HP) < 0) // �½�ɫ
			lVer = defCHA_TABLE_NEW_VER;
		pCha->SetPKCtrl(Str2Int(stringBufs[nIndex++]));

		//strcpy(pCha->m_CChaAttr.m_szName, pCha->GetName());
		strncpy_s( pCha->m_CChaAttr.m_szName, sizeof(pCha->m_CChaAttr.m_szName), pCha->GetName(), _TRUNCATE );
		
		pCha->setAttr(ATTR_LV, Str2Int(stringBufs[nIndex++]), 1);
		
		// ���ݿ�
		//pCha->setAttr(ATTR_JOB, g_GetJobID(g_buf[nIndex++].c_str()), 1);
		pCha->setAttr(ATTR_JOB, Str2Int(stringBufs[nIndex++]), 1);

		pCha->setAttr(ATTR_GD, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_AP, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_TP, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_BSTR, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_BDEX, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_BAGI, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_BCON, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_BSTA, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_BLUK, Str2Int(stringBufs[nIndex++]), 1);

		pCha->setAttr(ATTR_SAILLV, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_CSAILEXP, _atoi64(stringBufs[nIndex++].c_str()), 1);
		pCha->setAttr(ATTR_CLEFT_SAILEXP, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_LIFELV, Str2Int(stringBufs[nIndex++]), 1);
		pCha->setAttr(ATTR_CLIFEEXP, _atoi64(stringBufs[nIndex++].c_str()), 1);
		pCha->setAttr(ATTR_LIFETP, Str2Int(stringBufs[nIndex++]), 1);

		pCha->SetBirthMap(stringBufs[nIndex++].c_str());
		long lPosX = Str2Int(stringBufs[nIndex++]);
		long lPosY = Str2Int(stringBufs[nIndex++]);
		pCha->SetPos(lPosX, lPosY);
		pCha->SetBirthCity(stringBufs[nIndex++].c_str());
		//LG("enter_map", "���ý�ɫ�������ݳɹ�.\n");

		try
		{
			int	nLookDataID = nIndex;
			if (!pCha->String2LookDate(stringBufs[nIndex++]))
			{
				//LG("enter_map", "�������У��ʹ���.\n");
				LG("enter_map", "Appearance data check sum error.\n");
				//LG("У��ʹ���", "��ɫ��dbid %u��name %s��resid %u���ĸĹ�����У��ʹ���.\n", cha_id, pCha->GetLogName(), pCha->GetKitbagRecDBID());
				LG("Check sum error", "the character (dbid %u��name %s��resid %u)'s change appearance data check sum error.\n", cha_id, pCha->GetLogName(), pCha->GetKitbagRecDBID());
				return false;
			}
			pCha->SetCat(pCha->m_SChaPart.sTypeID);
			//LG("enter_map", "���ý�ɫ��۳ɹ�.\n");
		}
		catch (...)
		{
			//LG("enter_map", "Strin2LookData����!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
			LG("enter_map", "Strin2LookData error!!\n");
			//LG("enter_map", "����ַ��� %s\n", stringBufs[nIndex - 1]);
			LG("enter_map", "Appearance String %s\n", stringBufs[nIndex - 1]);
			throw;
		}

		int	nSkillBagDataID = nIndex;
		String2SkillBagData(&pCha->m_CSkillBag, stringBufs[nIndex++]);
		//LG("enter_map", "���ý�ɫ�������ɹ�.\n");

		int	nSortcutDataID = nIndex;
		String2ShortcutData(&pCha->m_CShortcut, stringBufs[nIndex++]);
		//LG("enter_map", "���ý�ɫ������ɹ�.\n");

		// ��ȡ������Ϣ
		pPlayer->MisClear();

		char szMisInfo[ROLE_MAXSIZE_DBMISSION];
		memset( szMisInfo, 0, ROLE_MAXSIZE_DBMISSION );
		//strncpy( g_szMisInfo, stringBufs[nIndex++].c_str(), ROLE_MAXSIZE_DBMISSION - 1 );
		strncpy_s( szMisInfo, sizeof(szMisInfo), stringBufs[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInit( szMisInfo ) )
		{
			//pCha->SystemNotice( "�ý�ɫ�����¼������Ϣ��ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00009) );

		}
		//LG("enter_map", "���ý�ɫ����1�ɹ�.\n");

		char szRecord[ROLE_MAXSIZE_DBRECORD];
		memset( szRecord, 0, ROLE_MAXSIZE_DBRECORD );
		//strncpy( g_szRecord, stringBufs[nIndex++].c_str(), ROLE_MAXSIZE_DBRECORD - 1 );
		strncpy_s( szRecord, sizeof(szRecord), stringBufs[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInitRecord( szRecord ) )
		{
			//pCha->SystemNotice( "�ý�ɫ������ʷ��¼������Ϣ��ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00010) );
		}
		//LG("enter_map", "���ý�ɫ����2�ɹ�.\n");

		char szTrigger[ROLE_MAXSIZE_DBTRIGGER];
		memset( szTrigger, 0, ROLE_MAXSIZE_DBTRIGGER );
		//strncpy( g_szTrigger, stringBufs[nIndex++].c_str(), ROLE_MAXSIZE_DBTRIGGER - 1 );
		strncpy_s( szTrigger, sizeof(szTrigger), stringBufs[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInitTrigger( szTrigger ) )
		{
			//pCha->SystemNotice( "�ý�ɫ���񴥷������ݳ�ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00011) );
		}
		//LG("enter_map", "���ý�ɫ����3�ɹ�.\n");
		char szMisCount[ROLE_MAXSIZE_DBMISCOUNT];
		memset( szMisCount, 0, ROLE_MAXSIZE_DBMISCOUNT );
		//strncpy( g_szMisCount, stringBufs[nIndex++].c_str(), ROLE_MAXSIZE_DBMISCOUNT - 1 );
		strncpy_s( szMisCount, sizeof(szMisCount), stringBufs[nIndex++].c_str(), _TRUNCATE );
		if( !pPlayer->MisInitMissionCount( szMisCount ) )
		{
			//pCha->SystemNotice( "�ý�ɫ�������������ݳ�ʼ��ʧ��!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00012) );
		}
		//LG("enter_map", "���ý�ɫ����4�ɹ�.\n");

		string strList[2];
		Util_ResolveTextLine(stringBufs[nIndex++].c_str(), strList, 2, ',');
		pPlayer->SetLoginCha(Str2Int(strList[0]), Str2Int(strList[1]));

		//if (lVer != defCHA_TABLE_NEW_VER) // ��Ҫ�汾ת��
		//	SaveTableVer(cha_id);

		pCha->SetKitbagRecDBID(Str2Int(stringBufs[nIndex++]));
        
        pCha->SetKitbagTmpRecDBID(Str2Int(stringBufs[nIndex++]));//��ȡ��ʱ��������ԴID
        
		pPlayer->SetMapMaskDBID(Str2Int(stringBufs[nIndex++]));
		g_strChaState[0] = stringBufs[nIndex++];
		pPlayer->Strin2BankDBIDData(stringBufs[nIndex++]);

        //����������
        int iLocked = Str2Int(stringBufs[nIndex++]);
        pCha->GetKitbag()->SetPwdLockState(iLocked);
        
		//����
		int nCredit = Str2Int(stringBufs[nIndex++]);
		pCha->SetCredit(nCredit);

		pCha->SetStoreItemID(Str2Int(stringBufs[nIndex++]));

		// Add by lark.li 20080723 begin
		Strin2ChaExtendAttr(pCha, stringBufs[nIndex++]);
		// End
#ifdef SHUI_JING
		pCha->SetFlatMoney( atoi(stringBufs[nIndex++].c_str()) );
#endif
		//LG("enter_map", "����ȫ�����ݳɹ�.\n");
		LG("enter_map", "Set the whole data succeed.\n");	
}
	else
	{
		//LG("enter_map", "�����ݿ����_get_row()����ֵ��%d.%u\n", r);
		LG("enter_map", "Loading database error,_get_row() return value:%d.%u\n", r, r1);
		return false;
	}

	return true;
T_E}

void CTableCha::OnlySavePosWhenBeSaved(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return;
	CCharacter *pCha = pPlayer->GetMainCha();
	CCharacter *pCCtrlCha = pPlayer->GetCtrlCha();
	if (!pCha || !pCCtrlCha) return;

	// �����ǰ��ͼ��������ֱ���˳�
	if (pCCtrlCha->GetSubMap())
	{
		if(!pCCtrlCha->GetSubMap()->CanSavePos())
			return;
	}
	else
		return;

	DWORD cha_id = pPlayer->GetDBChaId();

	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
				   map='%s', main_map='%s', map_x=%d, map_y=%d, angle=%d \
				   where cha_id=%d", \
				   _get_table(), \
				   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetAngle(), \
				   cha_id);

	//short sExec =  exec_sql_direct(g_sql);
	//short sExec = safe_sql(GAME_CTABLECHA_ONLYSAVEPOSWHENBESAVED, 6,
	//					   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), &pCha->GetPos().x,
	//					   &pCha->GetPos().y, &pCha->GetAngle(), &cha_id);
	
	short sExec = stored_procedure("{CALL dbo.OnlySavePosWhenBeSaved(?,?,?,?,?,?)}", "dbo", "OnlySavePosWhenBeSaved",
								   6, pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), &pCha->GetPos().x,
								   &pCha->GetPos().y, &pCha->GetAngle(), &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б���λ�õ�SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save position SQL sentence error!\n", pCha->GetLogName());
		return ;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return ;
	}
}

//TODO: This function is not called anywhere - is it obselete? 
void CTableCha::OnlySavePosWhenBeSavedEx(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return;
	CCharacter *pCha = pPlayer->GetMainCha();
	CCharacter *pCCtrlCha = pPlayer->GetCtrlCha();
	if (!pCha || !pCCtrlCha) return;

	char sql[1024 * 1024];

	// �����ǰ��ͼ��������ֱ���˳�
	if (pCCtrlCha->GetSubMap())
	{
		if(!pCCtrlCha->GetSubMap()->CanSavePos())
			return;
	}
	else
		return;

	DWORD cha_id = pPlayer->GetDBChaId();

	_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set \
				   map='%s', main_map='%s', map_x=%d, map_y=%d, angle=%d \
				   where cha_id=%d", \
				   _get_table(), \
				   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetAngle(), \
				   cha_id);

	if (strlen(sql) >= SQL_MAXLEN)
	{
		FILE	*pf = NULL  ;
		if( fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0)
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return ;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		
		return ;
	}
	//short sExec =  exec_sql_direct(sql);
	short sExec = safe_sql(GAME_CTABLECHA_ONLYSAVEPOSWHENBESAVEDEX, 6,
						   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), &pCha->GetPos().x,
						   &pCha->GetPos().y, &pCha->GetAngle(), &cha_id);
	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б���λ�õ�SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save position SQL sentence error!\n", pCha->GetLogName());
		return ;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return ;
	}
}

//-----------------
// ��ʱ��ɫ��Ϣ����
//-----------------
bool CTableCha::SaveAllData(CPlayer *pPlayer, char chSaveType, cChar *szTarMapName, Long lTarX, Long lTarY)
{T_B
	MONITOR
	
	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	CCharacter *pCCtrlCha = pPlayer->GetCtrlCha();
	if (pPlayer->GetLoginChaType() == enumLOGIN_CHA_BOAT) // �Դ�����̬��½
	{
		CCharacter *pCLogCha = pPlayer->GetBoat(pPlayer->GetLoginChaID());
		if (pCLogCha != pCCtrlCha) // ��Ӧ�ó��ֵ����
		{
			pCCtrlCha->SetToMainCha();
			pCCtrlCha = pCha;
			if (pCLogCha)
				//LG("��½��ɫ���ƴ���", "��½��ɫ %s�����ƽ�ɫ %s������ɫ %s.\n", pCLogCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
				LG("logging character control error", "logging character %s,control character %s,Main character %s.\n", pCLogCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
			else
				//LG("��½��ɫ���ƴ���", "��½��ɫ %s�����ƽ�ɫ %s������ɫ %s.\n", "", pCCtrlCha->GetLogName(), pCha->GetLogName());
				LG("logging character control error", "logging character %s,control character %s,Main character %s.\n", "", pCCtrlCha->GetLogName(), pCha->GetLogName());
			return false;
		}
	}
	else
	{
		if (pCha != pCCtrlCha) // ��Ӧ�ó��ֵ����
		{
			pCCtrlCha = pCha;
			//LG("��½��ɫ���ƴ���", "��½��ɫ %s�����ƽ�ɫ %s������ɫ %s.\n", pCCtrlCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
			LG("logging character control error", "logging character %s,control character %s,Main character %s.\n", pCCtrlCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
			return false;
		}
	}

	if(pCha)
	{
		//LG("enter_map", "%s ��ʼ���ñ�������.\n", pCha->GetLogName());
		LG("enter_map", "%s start configure save data.\n", pCha->GetLogName());

		//pCha->m_CLog.Log("^^^^^^^^^^^^�㿪ʼ�����ɫ\n");
		pCha->m_CLog.Log("........... now you start save character\n");
		//pCha->m_CLog.Log("�ȼ� %d����ͼ %s������ [%d,%d]�������� %s.\n", pCha->m_CChaAttr.GetAttr(ATTR_LV), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetBirthCity());
		pCha->m_CLog.Log("grade %d,map %s,coordinate [%d,%d],birth city %s.\n", (int)pCha->m_CChaAttr.GetAttr(ATTR_LV), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetBirthCity());
	}


	DWORD hp    = (long)pCha->getAttr(ATTR_HP);
	DWORD sp    = (long)pCha->getAttr(ATTR_SP);
	LONG64 exp   = pCha->getAttr(ATTR_CEXP);

	//szTarMapName, Long lTarX, Long lTarY
	const char *map	= pCCtrlCha->GetBirthMap();
	const char *main_map = pCha->GetBirthMap();
	DWORD map_x = pCha->GetShape().centre.x;
	DWORD map_y = pCha->GetShape().centre.y;
	
	// ������л���ͼ�ȱ����ַ��˵
	if (chSaveType == enumSAVE_TYPE_SWITCH)
	{
		map = szTarMapName;
		main_map = szTarMapName;
		map_x = lTarX;
		map_y = lTarY;
	}

	DWORD radius= pCha->GetShape().radius;
	short angle = pCha->GetAngle();
	short degree= (short)pCha->getAttr(ATTR_LV);
	//���ݿ����
	//const char *job	= g_GetJobName((short)pCha->getAttr(ATTR_JOB));
	short job = (short)pCha->getAttr(ATTR_JOB);

	DWORD gd	= (long)pCha->getAttr(ATTR_GD);
	DWORD ap	= (long)pCha->getAttr(ATTR_AP);
	DWORD tp	= (long)pCha->getAttr(ATTR_TP);
	DWORD str	= (long)pCha->getAttr(ATTR_BSTR);
	DWORD dex	= (long)pCha->getAttr(ATTR_BDEX);
	DWORD agi	= (long)pCha->getAttr(ATTR_BAGI);
	DWORD con	= (long)pCha->getAttr(ATTR_BCON);
	DWORD sta	= (long)pCha->getAttr(ATTR_BSTA);
	DWORD luk	= (long)pCha->getAttr(ATTR_BLUK);

	DWORD sail_lv		= (long)pCha->getAttr(ATTR_SAILLV);
	DWORD sail_exp		= (long)pCha->getAttr(ATTR_CSAILEXP);
	DWORD sail_left_exp	= (long)pCha->getAttr(ATTR_CLEFT_SAILEXP);
	DWORD live_lv		= (long)pCha->getAttr(ATTR_LIFELV);
	DWORD live_exp		= (long)pCha->getAttr(ATTR_CLIFEEXP);
	DWORD live_tp		= (long)pCha->getAttr(ATTR_LIFETP);
    
    DWORD nLocked       = pCha->GetKitbag()->GetPwdLockState();

	DWORD dwCredit		= (long)pCha->GetCredit();
	DWORD dwStoreItemID = pCha->GetStoreItemID();

	char  pk_ctrl = pCha->IsInPK();

	{
		MONITOR_STEP(LookData2String)
		g_look[defLOOK_DATA_STRING_LEN - 1] = 0;
		if(!LookData2String(&pCha->m_SChaPart, g_look, defLOOK_DATA_STRING_LEN, false))
		{
			//LG("enter_map", "��ɫ%s\t�������ݣ���ۣ�ʱ����!\n", pCha->GetLogName());
			LG("enter_map", "character %s\tsave data (surface) error!\n", pCha->GetLogName());
			return false;
		}
		//LG("enter_map", "���ý�ɫ��۳ɹ�.\n");
	}

	{
		MONITOR_STEP(SkillBagData2String)
		g_skillbag[defSKILLBAG_DATA_STRING_LEN - 1] = 0;
		if (!SkillBagData2String(&pCha->m_CSkillBag, g_skillbag, defSKILLBAG_DATA_STRING_LEN))
		{
			//LG("enter_map", "��ɫ%s\t�������ݣ����ܣ�ʱ����!\n", pCha->GetLogName());
			LG("enter_map", "character %s\tsave data(skill) error!\n", pCha->GetLogName());
			return false;
		}
		//LG("enter_map", "���ý�ɫ�������ɹ�.\n");
	}

	{
		MONITOR_STEP(ShortcutData2String)
		g_shortcut[defSHORTCUT_DATA_STRING_LEN - 1] = 0;
		if (!ShortcutData2String(&pCha->m_CShortcut, g_shortcut, defSHORTCUT_DATA_STRING_LEN))
		{
			//LG("enter_map", "��ɫ%s\t�������ݣ��������ʱ����!\n", pCha->GetLogName());
			LG("enter_map", "character %s\tsave data(shortcut)error!\n", pCha->GetLogName());
			return false;
		}
		//LG("enter_map", "���ý�ɫ������ɹ�.\n");
	}

	{
		MONITOR_STEP(MisGetData)
		// �����ɫ�����¼��Ϣ
		//memset( g_szMisInfo, 0, ROLE_MAXSIZE_DBMISSION );
		if( !pPlayer->MisGetData( g_szMisInfo, ROLE_MAXSIZE_DBMISSION - 1 ) )
		{
			//pCha->SystemNotice( "�ý�ɫ����������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00015), pCha->GetID() );
			//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ��������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
			LG(szDBLog, "save character[ID: %d\tNAME: %s]data info,Get mission data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		}
		//LG("enter_map", "���ý�ɫ����1�ɹ�.\n");

		//memset( g_szRecord, 0, ROLE_MAXSIZE_DBRECORD );
		if( !pPlayer->MisGetRecord( g_szRecord, ROLE_MAXSIZE_DBRECORD - 1 ) )
		{
			//pCha->SystemNotice( "�ý�ɫ����������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00015), pCha->GetID() );
			//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ������ʷ��¼����ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
			LG(szDBLog, "save character[ID: %d\tNAME: %s]data info,Get mission history data error !ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		}
		//LG("enter_map", "���ý�ɫ����2�ɹ�.\n");

		//memset( g_szTrigger, 0, ROLE_MAXSIZE_DBTRIGGER );
		if( !pPlayer->MisGetTrigger( g_szTrigger, ROLE_MAXSIZE_DBTRIGGER - 1 ) )
		{
			//pCha->SystemNotice( "�ý�ɫ����������Ϣ���������ݶ�ȡ����!ID = %d", pCha->GetID() );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00016), pCha->GetID() );
			//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ���񴥷�������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
			LG(szDBLog, "save character[ID: %d\tNAME: %s]data info��Get mission trigger data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		}
		//LG("enter_map", "���ý�ɫ����3�ɹ�.\n");

		//memset( g_szMisCount, 0, ROLE_MAXSIZE_DBMISCOUNT );
		if( !pPlayer->MisGetMissionCount( g_szMisCount, ROLE_MAXSIZE_DBMISCOUNT - 1 ) )
		{
			//pCha->SystemNotice( "�ý�ɫ����������������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00017), pCha->GetID() );
			//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ��������������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
			LG(szDBLog, "save character[ID: %d\tNAME: %s]data info��Get randomicity mission take count of data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		}
		//LG("enter_map", "���ý�ɫ����4�ɹ�.\n");
	}

	const char	*szBirthName = pCha->GetBirthCity();

	char	szLoginCha[50];
	//sprintf(szLoginCha, "%u,%u", pPlayer->GetLoginChaType(), pPlayer->GetLoginChaID());
	_snprintf_s(szLoginCha,sizeof(szLoginCha),_TRUNCATE, "%u,%u", pPlayer->GetLoginChaType(), pPlayer->GetLoginChaID());

	{
		MONITOR_STEP(SStateData2String)

		if (chSaveType == enumSAVE_TYPE_OFFLINE) // ����
			g_skillstate[0] = '\0';
		else if (!SStateData2String(pCha, g_skillstate, defSSTATE_DATE_STRING_LIN))
		{
			//LG("enter_map", "��ɫ%s\t�������ݣ��������ʱ����!\n", pCha->GetLogName());
			LG("enter_map", "character %s\tsave data(shortcut)error!\n", pCha->GetLogName());
			return false;
		}

		// Add by lark.li 20080723 begin
		//memset(g_extendAttr, 0 , ROLE_MAXSIZE_DBMISCOUNT);
		if(!ChaExtendAttr2String(pCha, g_extendAttr, ROLE_MAXSIZE_DBMISCOUNT))
		{
			LG("enter_map", "character %s\tsave data (extend attr) error!\n", pCha->GetLogName());
			return false;
		}
		// End
	}

	char str_exp[32];
     //_i64toa( exp, str_exp, 10 ); // C4996
	_i64toa_s( exp, str_exp,sizeof(str_exp) ,10 ); // C4996

	bool bWithPos = false;

	if (chSaveType == enumSAVE_TYPE_SWITCH)
	{
		bWithPos = true;
	}
	else if (pCCtrlCha->GetSubMap())
		bWithPos = pCCtrlCha->GetSubMap()->CanSavePos();
	
	// Add by lark.li 20090311 begin
	/*
	memset(g_sql, 0 , sizeof(g_sql));
	// End
#ifdef SHUI_JING
	DWORD flatmoney = pCha->GetFlatMoney();
#endif
	if (bWithPos)
		//sprintf(g_sql, "update %s set \
		//			hp=%d, sp=%d, exp=%s, map='%s', main_map='%s', map_x=%d, map_y=%d, radius=%d, angle=%d, pk_ctrl=%d, degree=%d, job='%s', gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
		//			shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
		//			sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s' \
		//			where cha_id=%d", \
		//			_get_table(), \
		//			hp, sp, str_exp, map, main_map, map_x, map_y, radius, angle, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, g_skillstate, g_extendAttr, \
		//			cha_id);
#ifndef SHUI_JING
		_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
					   hp=%d, sp=%d, exp=%s, map='%s', main_map='%s', map_x=%d, map_y=%d, radius=%d, angle=%d, pk_ctrl=%d, degree=%d, job=%d, gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
					   shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
					   sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s' \
					   where cha_id=%d", \
					   _get_table(), \
					   hp, sp, str_exp, map, main_map, map_x, map_y, radius, angle, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, g_skillstate, g_extendAttr, \
					   cha_id);
#else
		_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
			   hp=%d, sp=%d, exp=%s, map='%s', main_map='%s', map_x=%d, map_y=%d, radius=%d, angle=%d, pk_ctrl=%d, degree=%d, job=%d, gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
			   shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
			   sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s', flatcoins = %d \
			   where cha_id=%d", \
			   _get_table(), \
			   hp, sp, str_exp, map, main_map, map_x, map_y, radius, angle, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, g_skillstate, g_extendAttr, flatmoney ,\
			   cha_id);

#endif
	else
		//sprintf(g_sql, "update %s set \
		//			hp=%d, sp=%d, exp=%s, radius=%d, pk_ctrl=%d, degree=%d, job='%s', gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
		//			shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
		//			sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s' \
		//			where cha_id=%d", \
		//			_get_table(), \
		//			hp, sp, str_exp, radius, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, g_skillstate, g_extendAttr, \
		//			cha_id);
		_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
					   hp=%d, sp=%d, exp=%s, radius=%d, pk_ctrl=%d, degree=%d, job=%d, gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
					   shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
					   sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s' \
					   where cha_id=%d", \
					   _get_table(), \
					   hp, sp, str_exp, radius, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, g_skillstate, g_extendAttr, \
					   cha_id);

	//LG("enter_map", "��֯SQL���ɹ�.\n");
	
	if(strlen(GAME_CTABLECHA_SAVEALLDATA_1) >= SQL_MAXLEN || strlen(GAME_CTABLECHA_SAVEALLDATA_2) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+") != 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	*/
	short sExec = -1;
	
	if(bWithPos) {
	sExec = stored_procedure("{CALL dbo.SaveAllData(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}",
								"dbo", "SaveAllData", 42, &hp, &sp, str_exp, map, main_map, &map_x, &map_y, &radius, &angle, &pk_ctrl,												   //10
								&degree, &job, &gd, &ap, &tp, &str, &dex, &agi, &con, &sta, &luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, //18
								szBirthName, szLoginCha, &sail_lv, &sail_exp, &sail_left_exp, &live_lv, &live_exp, &live_tp, &nLocked, &dwCredit, &dwStoreItemID, g_skillstate, g_extendAttr,
								&cha_id);
	} else
	{
	sExec = stored_procedure("{CALL dbo.SaveAllDataWithoutPos(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}",
							 "dbo", "SaveAllDataWithoutPos", 37, &hp, &sp, str_exp, &radius, &pk_ctrl,												   //10
							 &degree, &job, &gd, &ap, &tp, &str, &dex, &agi, &con, &sta, &luk, g_look, g_skillbag, g_shortcut, g_szMisInfo, g_szRecord, g_szTrigger, g_szMisCount, //18
							 szBirthName, szLoginCha, &sail_lv, &sail_exp, &sail_left_exp, &live_lv, &live_exp, &live_tp, &nLocked, &dwCredit, &dwStoreItemID, g_skillstate, g_extendAttr,
							 &cha_id);

	}
	
	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character %u!\n", cha_id);
		return false;
	}
	//LG("enter_map", "ִ�б���SQL���ɹ�.\n");

	//LG(szSaveCha, szLogMsg);

	// �Ȳ��Ϲ���20090413 lark.li
	//Add by sunny.sun 20090310 
	//if( chSaveType == enumSAVE_TYPE_OFFLINE )
	//	game_db.UpdateOutMapTime( pPlayer->GetDBChaId() );

	//pCha->m_CLog.Log("^^^^^^^^^^^^�㱣���ɫ���\n");
	pCha->m_CLog.Log("...............you finish save the character \n");
	//pCha->SystemNotice("��Ľ�ɫ�ɹ����浽���ݿ⣬�ȼ� %d����ͼ %s������ [%d,%d]�������� %s.\n", pCha->m_CChaAttr.GetAttr(ATTR_LV), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetBirthCity());
	//LG("enter_map", "��������ɫȫ�����ݳɹ�.\n", pCha->GetLogName());
	LG("enter_map", "save the main character whole data succeed!\n", pCha->GetLogName());

	return true;
T_E}

bool CTableCha::SaveAllDataEx(CPlayer *pPlayer, char chSaveType)
{T_B
	MONITOR

	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	CCharacter *pCCtrlCha = pPlayer->GetCtrlCha();
	if (pPlayer->GetLoginChaType() == enumLOGIN_CHA_BOAT) // �Դ�����̬��½
	{
		CCharacter *pCLogCha = pPlayer->GetBoat(pPlayer->GetLoginChaID());
		if (pCLogCha != pCCtrlCha) // ��Ӧ�ó��ֵ����
		{
			pCCtrlCha->SetToMainCha();
			pCCtrlCha = pCha;
			if (pCLogCha)
				//LG("��½��ɫ���ƴ���", "��½��ɫ %s�����ƽ�ɫ %s������ɫ %s.\n", pCLogCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
				LG("logging character control error", "logging character %s,control character %s,Main character %s.\n", pCLogCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
			else
				//LG("��½��ɫ���ƴ���", "��½��ɫ %s�����ƽ�ɫ %s������ɫ %s.\n", "", pCCtrlCha->GetLogName(), pCha->GetLogName());
				LG("logging character control error", "logging character %s,control character %s,Main character %s.\n", "", pCCtrlCha->GetLogName(), pCha->GetLogName());
			return false;
		}
	}
	else
	{
		if (pCha != pCCtrlCha) // ��Ӧ�ó��ֵ����
		{
			pCCtrlCha = pCha;
			//LG("��½��ɫ���ƴ���", "��½��ɫ %s�����ƽ�ɫ %s������ɫ %s.\n", pCCtrlCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
			LG("logging character control error", "logging character %s,control character %s,Main character %s.\n", pCCtrlCha->GetLogName(), pCCtrlCha->GetLogName(), pCha->GetLogName());
			return false;
		}
	}

	if(pCha)
	{
		//LG("enter_map", "%s ��ʼ���ñ�������.\n", pCha->GetLogName());
		LG("enter_map", "%s start configure save data.\n", pCha->GetLogName());

		//pCha->m_CLog.Log("^^^^^^^^^^^^�㿪ʼ�����ɫ\n");
		pCha->m_CLog.Log("........... now you start save character\n");
		//pCha->m_CLog.Log("�ȼ� %d����ͼ %s������ [%d,%d]�������� %s.\n", pCha->m_CChaAttr.GetAttr(ATTR_LV), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetBirthCity());
		pCha->m_CLog.Log("grade %d,map %s,coordinate [%d,%d],birth city %s.\n", (int)pCha->m_CChaAttr.GetAttr(ATTR_LV), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetBirthCity());
	}

	DWORD hp    = (long)pCha->getAttr(ATTR_HP);
	DWORD sp    = (long)pCha->getAttr(ATTR_SP);
	LONG64 exp   = pCha->getAttr(ATTR_CEXP);

	const char *map	= pCCtrlCha->GetBirthMap();
	const char *main_map = pCha->GetBirthMap();
	DWORD map_x = pCha->GetShape().centre.x;
	DWORD map_y = pCha->GetShape().centre.y;
	DWORD radius= pCha->GetShape().radius;
	short angle = pCha->GetAngle();
	short degree= (short)pCha->getAttr(ATTR_LV);
	// ���ݿ����
	//const char *job	= g_GetJobName((short)pCha->getAttr(ATTR_JOB));
	short job = (short)pCha->getAttr(ATTR_JOB);

	DWORD gd	= (long)pCha->getAttr(ATTR_GD);
	DWORD ap	= (long)pCha->getAttr(ATTR_AP);
	DWORD tp	= (long)pCha->getAttr(ATTR_TP);
	DWORD str	= (long)pCha->getAttr(ATTR_BSTR);
	DWORD dex	= (long)pCha->getAttr(ATTR_BDEX);
	DWORD agi	= (long)pCha->getAttr(ATTR_BAGI);
	DWORD con	= (long)pCha->getAttr(ATTR_BCON);
	DWORD sta	= (long)pCha->getAttr(ATTR_BSTA);
	DWORD luk	= (long)pCha->getAttr(ATTR_BLUK);

	DWORD sail_lv		= (long)pCha->getAttr(ATTR_SAILLV);
	DWORD sail_exp		= (long)pCha->getAttr(ATTR_CSAILEXP);
	DWORD sail_left_exp	= (long)pCha->getAttr(ATTR_CLEFT_SAILEXP);
	DWORD live_lv		= (long)pCha->getAttr(ATTR_LIFELV);
	DWORD live_exp		= (long)pCha->getAttr(ATTR_CLIFEEXP);
	DWORD live_tp		= (long)pCha->getAttr(ATTR_LIFETP);
    
    DWORD nLocked       = pCha->GetKitbag()->GetPwdLockState();

	DWORD dwCredit		= (long)pCha->GetCredit();
	DWORD dwStoreItemID = pCha->GetStoreItemID();

	char  pk_ctrl = pCha->IsInPK();

	//LG("enter_map", "���ý�ɫ�������ݳɹ�.\n");

	//char look[2048];
	StringPoolL stringPool;
	stringPool.ReserveBuf(StringPoolL::AllocateSpace1);
	stringPool.ReserveNum(StringPoolL::AllocateSpace2);
	//memset(look, 0, sizeof(look));
	stringPool[0] = "";

	//if(!LookData2String(&pCha->m_SChaPart, look, defLOOK_DATA_STRING_LEN, false))
	if(!LookData2StringEx(&pCha->m_SChaPart, stringPool, 0, false))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ���ۣ�ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data (surface) error!\n", pCha->GetLogName());
		return false;
	}
	//LG("enter_map", "���ý�ɫ��۳ɹ�.\n");

	//char skillbag[1500];
	//memset(skillbag, 0, sizeof(skillbag));
	stringPool[1] = "";
	//if (!SkillBagData2String(&pCha->m_CSkillBag, skillbag, defSKILLBAG_DATA_STRING_LEN))
	if (!SkillBagData2StringEx(&pCha->m_CSkillBag, stringPool, 1))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ����ܣ�ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data(skill) error!\n", pCha->GetLogName());
		return false;
	}
	//LG("enter_map", "���ý�ɫ�������ɹ�.\n");

	//char shortcut[1500];
	//memset(shortcut, 0, sizeof(shortcut));
	stringPool[2] = "";
	if (!ShortcutData2StringEx(&pCha->m_CShortcut, stringPool, 2))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ��������ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data(shortcut)error!\n", pCha->GetLogName());
		return false;
	}
	//LG("enter_map", "���ý�ɫ������ɹ�.\n");

	// �����ɫ�����¼��Ϣ
	//char szMisInfo[ROLE_MAXSIZE_DBMISSION];
	//memset( szMisInfo, 0, ROLE_MAXSIZE_DBMISSION );
	stringPool[3] = "";
	if( !pPlayer->MisGetDataEx( stringPool, 3 ) )
	{
		//pCha->SystemNotice( "�ý�ɫ����������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00015), pCha->GetID() );
		//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ��������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		LG(szDBLog, "save character[ID: %d\tNAME: %s]data info,Get mission data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
	}
	//LG("enter_map", "���ý�ɫ����1�ɹ�.\n");

	//char szRecord[ROLE_MAXSIZE_DBRECORD];
	//memset( szRecord, 0, ROLE_MAXSIZE_DBRECORD );
	stringPool[4] = "";
	if( !pPlayer->MisGetRecordEx( stringPool, 4 ) )
	{
		//pCha->SystemNotice( "�ý�ɫ����������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00015), pCha->GetID() );
		//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ������ʷ��¼����ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		LG(szDBLog, "save character[ID: %d\tNAME: %s]data info,Get mission history data error !ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
	}
	//LG("enter_map", "���ý�ɫ����2�ɹ�.\n");

	//char szTrigger[ROLE_MAXSIZE_DBTRIGGER];
	//memset( szTrigger, 0, ROLE_MAXSIZE_DBTRIGGER );
	stringPool[5] = "";
	if( !pPlayer->MisGetTriggerEx( stringPool, 5) )
	{
		//pCha->SystemNotice( "�ý�ɫ����������Ϣ���������ݶ�ȡ����!ID = %d", pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00016), pCha->GetID() );
		//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ���񴥷�������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		LG(szDBLog, "save character[ID: %d\tNAME: %s]data info��Get mission trigger data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
	}
	//LG("enter_map", "���ý�ɫ����3�ɹ�.\n");

	//char szMisCount[ROLE_MAXSIZE_DBMISCOUNT];
	//memset( szMisCount, 0, ROLE_MAXSIZE_DBMISCOUNT );
	stringPool[6] = "";
	if( !pPlayer->MisGetMissionCountEx( stringPool, 6) )
	{
		//pCha->SystemNotice( "�ý�ɫ����������������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00017), pCha->GetID() );
		//LG(szDBLog, "�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ��������������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		LG(szDBLog, "save character[ID: %d\tNAME: %s]data info��Get randomicity mission take count of data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
	}
	//LG("enter_map", "���ý�ɫ����4�ɹ�.\n");

	const char	*szBirthName = pCha->GetBirthCity();

	char	szLoginCha[50];
	//sprintf(szLoginCha, "%u,%u", pPlayer->GetLoginChaType(), pPlayer->GetLoginChaID());
	_snprintf_s(szLoginCha,sizeof(szLoginCha),_TRUNCATE, "%u,%u", pPlayer->GetLoginChaType(), pPlayer->GetLoginChaID());

	//char skillstate[defSSTATE_DATE_STRING_LIN];
	//memset(skillstate, 0, defSSTATE_DATE_STRING_LIN);
	stringPool[7] = "";
	if (chSaveType != enumSAVE_TYPE_OFFLINE) // ����
	{
		if (!SStateData2StringEx(pCha, stringPool, 7))
		{
			//LG("enter_map", "��ɫ%s\t�������ݣ��������ʱ����!\n", pCha->GetLogName());
			LG("enter_map", "character %s\tsave data(shortcut)error!\n", pCha->GetLogName());
			return false;
		}
	}
	// Add by lark.li 20080723 begin
	//char extendAttr[ROLE_MAXSIZE_DBMISCOUNT];
	//memset(extendAttr, 0 , ROLE_MAXSIZE_DBMISCOUNT);
	stringPool[8] = "";
	if(!ChaExtendAttr2StringEx(pCha, stringPool, 8))
	{
		LG("enter_map", "character %s\tsave data (extend attr) error!\n", pCha->GetLogName());
		return false;
	}
	// End

	bool bWithPos = false;
	if (pCCtrlCha->GetSubMap())
		bWithPos = pCCtrlCha->GetSubMap()->CanSavePos();

	//char sql[SQL_MAXLEN];

	short sExec{-1};
	if(bWithPos)
	{
		sExec = stored_procedure("{CALL dbo.SaveAllDataExWithPos(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}",
								 "dbo", "SaveAllDataEx", 42, &hp, &sp, exp, map, main_map, &map_x, &map_y, &radius, &angle, &pk_ctrl,
								 &degree, &job, &gd, &ap, &tp, &str, &dex, &agi, &con, &sta, &luk,
								 (const char*)stringPool[0], (const char*)stringPool[1], (const char*)stringPool[2], (const char*)stringPool[3], (const char*)stringPool[4], (const char*)stringPool[5], (const char*)stringPool[6],
								 szBirthName, szLoginCha, &sail_lv, &sail_exp, &sail_left_exp, &live_lv, &live_exp, &live_tp, &nLocked, &dwCredit, &dwStoreItemID, (const char*)stringPool[7], (const char*)stringPool[8],
								 &cha_id);
	} else
	{
		sExec = stored_procedure("{CALL dbo.SaveAllDataWithoutPos(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}",
								 "dbo", "SaveAllDataEx", 37, &hp, &sp, exp, &radius, &pk_ctrl,
								 &degree, &job, &gd, &ap, &tp, &str, &dex, &agi, &con, &sta, &luk,
								 (const char*)stringPool[0], (const char*)stringPool[1], (const char*)stringPool[2], (const char*)stringPool[3], (const char*)stringPool[4], (const char*)stringPool[5], (const char*)stringPool[6],
								 szBirthName, szLoginCha, &sail_lv, &sail_exp, &sail_left_exp, &live_lv, &live_exp, &live_tp, &nLocked, &dwCredit, &dwStoreItemID, (const char*)stringPool[7], (const char*)stringPool[8],
								 &cha_id);
	}
	//if (bWithPos)
	//	_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set \
	//				   hp=%d, sp=%d, exp=%s, map='%s', main_map='%s', map_x=%d, map_y=%d, radius=%d, angle=%d, pk_ctrl=%d, degree=%d, job=%d, gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
	//				   shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
	//				   sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s' \
	//				   where cha_id=%d", \
	//				   _get_table(), \
	//				   hp, sp, str_exp, map, main_map, map_x, map_y, radius, angle, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, (const char*)stringPool[0], (const char*)stringPool[1], (const char*)stringPool[2], \
	//				   (const char*)stringPool[3], (const char*)stringPool[4], (const char*)stringPool[5], (const char*)stringPool[6], szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, \
	//				   (const char*)stringPool[7], (const char*)stringPool[8], \
	//				   cha_id);

	//else
	//	_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set \
	//				   hp=%d, sp=%d, exp=%s, radius=%d, pk_ctrl=%d, degree=%d, job=%d, gd=%d, ap=%d, tp=%d, str=%d, dex=%d, agi=%d, con=%d, sta=%d, luk=%d, look='%s', skillbag='%s', \
	//				   shortcut='%s', mission='%s', misrecord='%s', mistrigger='%s', miscount='%s', birth='%s', login_cha='%s', \
	//				   sail_lv=%d, sail_exp=%d, sail_left_exp=%d, live_lv=%d, live_exp=%d, live_tp=%d, kb_locked=%d, credit=%d, store_item=%d, skill_state='%s', extend ='%s' \
	//				   where cha_id=%d", \
	//				   _get_table(), \
	//				   hp, sp, str_exp, radius, pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, (const char*)stringPool[0], (const char*)stringPool[1], (const char*)stringPool[2], \
	//				   (const char*)stringPool[3], (const char*)stringPool[4], (const char*)stringPool[5], (const char*)stringPool[6], szBirthName, szLoginCha, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp, live_tp, nLocked, dwCredit, dwStoreItemID, \
	//				   (const char*)stringPool[7], (const char*)stringPool[8], \
	//				   cha_id);

	// short sExec =  exec_sql_direct( sql );

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character %u!\n", cha_id);
		return false;
	}
	//LG("enter_map", "ִ�б���SQL���ɹ�.\n");

	// �Ȳ��Ϲ���20090413 lark.li
	//Add by sunny.sun 20090310 
	//if( chSaveType == enumSAVE_TYPE_OFFLINE )
	//	game_db.UpdateOutMapTime( pPlayer->GetDBChaId() );

	//pCha->m_CLog.Log("^^^^^^^^^^^^�㱣���ɫ���\n");
	pCha->m_CLog.Log("...............you finish save the character \n");
	//pCha->SystemNotice("��Ľ�ɫ�ɹ����浽���ݿ⣬�ȼ� %d����ͼ %s������ [%d,%d]�������� %s.\n", pCha->m_CChaAttr.GetAttr(ATTR_LV), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetBirthCity());
	//LG("enter_map", "��������ɫȫ�����ݳɹ�.\n", pCha->GetLogName());
	LG("enter_map", "save the main character whole data succeed!\n", pCha->GetLogName());

	return true;
T_E}

bool CTableCha::SavePos(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	CCharacter *pCCtrlCha = pPlayer->GetCtrlCha();
	if (!pCha || !pCCtrlCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//sprintf(g_sql, "update %s set \
	//			map='%s', main_map='%s', map_x=%d, map_y=%d, angle=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetAngle(), \
	//			cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   map='%s', main_map='%s', map_x=%d, map_y=%d, angle=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetAngle(), \
	//			   cha_id);

	short sExec = stored_procedure("{CALL dbo.SavePos(?,?,?,?,?,?)}", "dbo", "SavePos", 6,
		pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), &pCha->GetPos().x, &pCha->GetPos().y, &pCha->GetAngle(), &cha_id );



	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL  ;
	//	if( fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0)
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б���λ�õ�SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save position SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}

bool CTableCha::SavePosEx(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	CCharacter *pCCtrlCha = pPlayer->GetCtrlCha();
	if (!pCha || !pCCtrlCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//StringPoolL stringPool;
	//stringPool.ReserveBuf(StringPoolL::AllocateSpace1);
	//stringPool.ReserveNum(StringPoolL::AllocateSpace2);
	////memset(look, 0, sizeof(look));
	//stringPool[0] = "";
	////sprintf(g_sql, "update %s set \
	////			map='%s', main_map='%s', map_x=%d, map_y=%d, angle=%d \
	////			where cha_id=%d", \
	////			_get_table(), \
	////			pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetAngle(), \
	////			cha_id);
	//stringPool[0].Printf("update %s set \
	//			   map='%s', main_map='%s', map_x=%d, map_y=%d, angle=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), pCha->GetPos().x, pCha->GetPos().y, pCha->GetAngle(), \
	//			   cha_id);

	//if (stringPool[0].Len() >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL  ;
	//	if( fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0)
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", (const char*)stringPool[0]);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	
	//	return false;
	//}
	//short sExec =  exec_sql_direct((const char*)stringPool[0]);

	short sExec = stored_procedure("{CALL dbo.SavePosEx(?,?,?,?,?,?)}", "dbo", "SavePosEx", 6,
								   pCCtrlCha->GetBirthMap(), pCha->GetBirthMap(), &pCha->GetPos().x,&pCha->GetPos().y, &pCha->GetAngle(), &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б���λ�õ�SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save position SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}

bool CTableCha::SaveMoney(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//sprintf(g_sql, "update %s set \
	//			gd=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			(int)pCha->getAttr(ATTR_GD), \
	//			cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   gd=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   (int)pCha->getAttr(ATTR_GD), \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);
	auto const money = pCha->getAttr(ATTR_GD);
	short	   sExec = stored_procedure("{CALL dbo.SaveMoney(?, ?)}", "dbo", "SaveMoney", 2, &money, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б����Ǯ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save money SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}

bool CTableCha::SaveKBagDBIDEx(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//char sql[1024 * 1024];

	//sprintf(g_sql, "update %s set \
	//			kitbag=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			pCha->GetKitbagRecDBID(), \
	//			cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set \
	//			   kitbag=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   pCha->GetKitbagRecDBID(), \
	//			   cha_id);

	//if (strlen(sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return false;
	//}
	//short sExec =  exec_sql_direct(sql);

	auto const id = pCha->GetKitbagRecDBID();
	short sExec = stored_procedure("{CALL dbo.SaveKBagDBIDEx(?,?)}", "dbo", "SaveKBagDBIDEx", 2 ,&id, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б��汳��������SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character%s\tcarry out save kitbag indexical SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}


bool CTableCha::SaveKBagDBID(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   kitbag=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   pCha->GetKitbagRecDBID(), \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	//NOTE: SaveKBagDBIDEx and SaveKBagDBID is identical
	const long param1 = pCha->GetKitbagRecDBID();
	short sExec = stored_procedure("{CALL dbo.SaveKBagDBIDEx(?, ?)}", "dbo", "SaveKBagDBIDEx", 2,
		&param1, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б��汳��������SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character%s\tcarry out save kitbag indexical SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}


bool CTableCha::SaveKBagTmpDBID(CPlayer *pPlayer)
{
    if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//sprintf(g_sql, "update %s set \
	//			kitbag_tmp=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			pCha->GetKitbagTmpRecDBID(), \
	//			cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   kitbag_tmp=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   pCha->GetKitbagTmpRecDBID(), \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return false;
	//}

	//short sExec =  exec_sql_direct(g_sql);

	auto const id	 = pCha->GetKitbagTmpRecDBID();
	short sExec = stored_procedure("{CALL dbo.SaveKBagTmpDBID(?, ?)}", "dbo", "SaveKBagTmpDBID", 2, &id, &cha_id );

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б�����ʱ����������SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save temp kitbag indexical SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}


bool CTableCha::SaveKBagTmpDBIDEx(CPlayer *pPlayer)
{
    if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//char sql[1024 * 1024];

	//sprintf(g_sql, "update %s set \
	//			kitbag_tmp=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			pCha->GetKitbagTmpRecDBID(), \
	//			cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set \
	//			   kitbag_tmp=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   pCha->GetKitbagTmpRecDBID(), \
	//			   cha_id);

	//if (strlen(sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return false;
	//}
	//short sExec =  exec_sql_direct(sql);

	auto const id	 = pCha->GetKitbagTmpRecDBID();
	//NOTE: SaveKBagTmpDBID and SaveKBagTmpDBIDEx is identical
	short	   sExec = stored_procedure("{CALL dbo.SaveKBagTmpDBID(?, ?)}", "dbo", "SaveKBagTmpDBID", 2, &id, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б�����ʱ����������SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save temp kitbag indexical SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}


bool CTableCha::SaveKBState(CPlayer *pPlayer)
{
    if(!pPlayer || !pPlayer->IsValid()) return false;
	CCharacter *pCha = pPlayer->GetMainCha();
	if (!pCha) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

    int iLocked = pCha->GetKitbag()->GetPwdLockState();
	//sprintf(g_sql, "update %s set \
	//			kb_locked=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			iLocked, \
	//			cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   kb_locked=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   iLocked, \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if( fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+") != 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	short sExec = stored_procedure("{CALL dbo.SaveKBState(?, ?)}", "dbo", "SaveKBState", 2, &iLocked, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ�б��汳������״̬��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out save kitbag lock state SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}

BOOL CTableCha::SaveStoreItemID(DWORD cha_id, long lStoreItemID)
{
	if(cha_id == 0)
	{
		return false;
	}

	//sprintf(g_sql, "update %s set \
	//			   store_item=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   lStoreItemID, \
	//			   cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   store_item=%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   lStoreItemID, \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	short sExec = stored_procedure("{CALL dbo.SaveStoreItemID(?, ?) }", "dbo", "SaveStoreItemID", 2, &lStoreItemID, &cha_id);

	if (!DBOK(sExec))
	{
		LG("stored_procedure", "SaveStoreItemID FAILED, item_id=%ld, cha_id=%d", lStoreItemID, cha_id);
		return false;
	}
	if (DBNODATA(sExec))
	{
		LG("stored_procedure", "SaveStoreItemID NO DATA, item_id=%ld, cha_id=%d", lStoreItemID, cha_id);
		return false;
	}

	return true;
}

BOOL CTableCha::AddMoney(DWORD cha_id, long money)
{
	if(cha_id == 0)
	{
		return false;
	}

	//sprintf(g_sql, "update %s set \
	//			   gd=gd+%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   money, \
	//			   cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   gd=gd+%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   money, \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL;
	//	if( fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+") != 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	short sExec = stored_procedure("{CALL dbo.AddMoney(?, ?)}", "dbo", "AddMoney", 2, &money, &cha_id);

	if (!DBOK(sExec))
	{
		LG("stored_procedure", "AddMoney FAILED, money=%ld, cha_id=%d", money, cha_id);
		return false;
	}
	if (DBNODATA(sExec))
	{
		LG("stored_procedure", "AddMoney NO DATA, money=%ld, cha_id=%d", money, cha_id);
		return false;
	}

	return true;
}

BOOL CTableCha::AddCreditByDBID(DWORD cha_id, long lCredit)
{
	if(cha_id == 0)
	{
		return false;
	}

	//sprintf(g_sql, "update %s set \
	//			   credit=credit+%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   lCredit, \
	//			   cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   credit=credit+%d \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   lCredit, \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL  ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0)
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	short sExec = stored_procedure("{CALL dbo.AddCreditByDBID(?, ?)}", "dbo", "AddCreditByDBID", 2, &lCredit, &cha_id);
	if (!DBOK(sExec))
	{
		LG("stored_procedure", "AddCreditByDBID FAILED, credit=%ld, cha_id=%d", lCredit, cha_id);
		return false;
	}
	if (DBNODATA(sExec))
	{
		LG("stored_procedure", "AddCreditByDBID NO DATA, credit=%ld, cha_id=%d", lCredit, cha_id);
		return false;
	}

	return true;
}

BOOL CTableCha::IsChaOnline(DWORD cha_id, BOOL &bOnline)
{
	if(cha_id == 0)
	{
		return false;
	}

	BOOL ret = false;

	unsigned long long lMemAddr = 0;

//	char *sql_syntax = "select mem_addr from %s where cha_id=%d";
//	char sql[SQL_MAXLEN];
////	sprintf(sql, sql_syntax, _get_table(), cha_id);
//	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, sql_syntax, _get_table(), cha_id);
//
//	// ִ�в�ѯ����
//	SQLRETURN sqlret;
//	SQLHSTMT hstmt = SQL_NULL_HSTMT;
//	SQLSMALLINT col_num = 0;
//	bool found = true;
//
//	try
//	{
//		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
//		if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
//		{
//			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
//
//			throw 1;
//		}
//
//		sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
//		if (sqlret != SQL_SUCCESS)
//		{
//			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
//
//			if (sqlret != SQL_SUCCESS_WITH_INFO)
//				throw 2;
//		}
//
//		sqlret = SQLNumResultCols(hstmt, &col_num);
//		col_num = min(col_num, MAX_COL);
//		col_num = min(col_num, _max_col);
//
//		// Bind Column
//		for (int i = 0; i < col_num; ++ i)
//		{
//			SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
//		}
//
//		// Fetch each Row	int i; // ȡ��������
//		for (int f_row = 0; (sqlret = SQLFetch(hstmt)) == SQL_SUCCESS || sqlret == SQL_SUCCESS_WITH_INFO; ++ f_row)
//		{
//			if (sqlret != SQL_SUCCESS)
//			{
//				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
//			}
//
//			lMemAddr = atol((char const *)_buf[0]);
//		}
//		SQLFreeStmt(hstmt, SQL_UNBIND);
//		ret = true;
//	}catch(int&e)
//	{
//		//LG("Store_msg", "IsChaOnline ODBC �ӿڵ��ô���λ���룺%d\n",e);
//		LG("Store_msg", "IsChaOnline ODBC interface transfer error ,position ID��%d\n",e);
//	}catch (...)
//	{
//		LG("Store_msg", "Unknown Exception raised when IsChaOnline\n");
//	}
//
//	if (hstmt != SQL_NULL_HSTMT)
//	{
//		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
//		hstmt = SQL_NULL_HSTMT;
//	}

	std::string buf[1]; 
	int		affect_rows{0};
	ret = _get_row_stored_procedure(buf, std::size(buf), "{CALL dbo.IsChaOnline(?)}", "dbo", "IsChaOnline", &affect_rows, 1, &cha_id);
	if(affect_rows != 1)
	{
		//NOTE: Should most likely always return 1 row affected. Anything else indicate an error.
		LG("stored_procedure", "IsChaOnline (SEE SOURCE) affected rows:%d where cha_id=%ld", affect_rows, cha_id);
	}

	lMemAddr = std::stoll(buf[0]);
	if(lMemAddr > 0)
	{
		bOnline = true;
	}
	else
	{
		bOnline = false;
	}

	return ret;
}

bool CTableCha::SaveMMaskDBID(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	//sprintf(g_sql, "update %s set \
	//			map_mask=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			pPlayer->GetMapMaskDBID(), \
	//			cha_id);
	_snprintf_s(g_sql, sizeof(g_sql),_TRUNCATE,"update %s set \
				   map_mask=%d \
				   where cha_id=%d", \
				   _get_table(), \
				   pPlayer->GetMapMaskDBID(), \
				   cha_id);

	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if( fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	short sExec =  exec_sql_direct(g_sql);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "���%d\tִ�б�����ͼ������SQL���ʱ����!\n", pPlayer->GetDBChaId());
		LG("enter_map", "character %d\tcarry out save big map indexical SQL senternce error!\n", pPlayer->GetDBChaId());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}

bool CTableCha::SaveBankDBID(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	const short	csIDBufLen = 50;
	char	szIDBuf[csIDBufLen];
	if(!pPlayer->BankDBIDData2String(szIDBuf, csIDBufLen))
	{
		LG("util_db", "FAILED writing BankDBIDData2String, buffer too small. chaid=%ld", cha_id);
		return false;
	}

	//sprintf(g_sql, "update %s set \
	//			bank=%s \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			szIDBuf, \
	//			cha_id);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
	//			   bank=%s \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   szIDBuf, \
	//			   cha_id);

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");

	//	return false;
	//}
	//short sExec =  exec_sql_direct(g_sql);

	short sExec = stored_procedure("{CALL dbo.SaveBankDBID(?, ?)}", "dbo", "SaveBankDBID", 2, &szIDBuf, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "���%d\tִ�б�������������SQL���ʱ����!\n", pPlayer->GetDBChaId());
		LG("enter_map", "character %d\tcarry out save bank indexcial SQL sentence error!\n", pPlayer->GetDBChaId());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}


bool CTableCha::SaveBankDBIDEx(CPlayer *pPlayer)
{
	if(!pPlayer || !pPlayer->IsValid()) return false;
	DWORD cha_id = pPlayer->GetDBChaId();

	const short	csIDBufLen = 50;
	char	szIDBuf[csIDBufLen];
	if(!pPlayer->BankDBIDData2String(szIDBuf, csIDBufLen))
	{
		LG("util_db", "FAILED writing BankDBIDData2String, buffer too small. chaid=%ld", cha_id);
		return false;
	}

	//char sql[1024 * 1024];
	//sprintf(g_sql, "update %s set \
	//			bank=%s \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			szIDBuf, \
	//			cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set \
	//			   bank=%s \
	//			   where cha_id=%d", \
	//			   _get_table(), \
	//			   szIDBuf, \
	//			   cha_id);

	//if (strlen(sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");

	//	return false;
	//}
	//short sExec =  exec_sql_direct(sql);

	//NOTE: SaveBankDBID and SaveBankDBIDEx is identical 
	short sExec = stored_procedure("{CALL dbo.SaveBankDBID(?, ?)}", "dbo", "SaveBankDBID", 2,&szIDBuf, &cha_id);

	if (!DBOK(sExec))
	{
		//LG("enter_map", "���%d\tִ�б�������������SQL���ʱ����!\n", pPlayer->GetDBChaId());
		LG("enter_map", "character %d\tcarry out save bank indexcial SQL sentence error!\n", pPlayer->GetDBChaId());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", cha_id);
		LG("enter_map", "Database couldn't find the character%u!\n", cha_id);
		return false;
	}

	return true;
}


bool CTableCha::SaveTableVer(DWORD cha_id)
{
	//sprintf(g_sql, "update %s set \
	//			version=%d \
	//			where cha_id=%d", \
	//			_get_table(), \
	//			defCHA_TABLE_NEW_VER, \
	//			cha_id);
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
				   version=%d \
				   where cha_id=%d", \
				   _get_table(), \
				   defCHA_TABLE_NEW_VER, \
				   cha_id);

	short sExec =  exec_sql_direct(g_sql);

	return DBOK(sExec) && !DBNODATA(sExec);
}

BOOL CTableCha::SaveMissionData(CPlayer *pPlayer, DWORD cha_id)
{T_B
	if( !pPlayer ) return FALSE;
	CCharacter *pCha = pPlayer->GetMainCha();
	if( !pCha ) return FALSE;

	// �����ɫ�����¼��Ϣ
	memset( g_szMisInfo, 0, ROLE_MAXSIZE_DBMISSION );
	if( !pPlayer->MisGetData( g_szMisInfo, ROLE_MAXSIZE_DBMISSION - 1 ) )
	{
		//pCha->SystemNotice( "SaveMissionData:�ý�ɫ����������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
		//LG(szDBLog, "SaveMissionData:�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ��������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00018), pCha->GetID() );
		LG(szDBLog, "SaveMissionData:save character[ID: %d\tNAME: %s]data info,Get mission data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );

	}

	memset( g_szRecord, 0, ROLE_MAXSIZE_DBRECORD );
	if( !pPlayer->MisGetRecord( g_szRecord, ROLE_MAXSIZE_DBRECORD - 1 ) )
	{
		//pCha->SystemNotice( "SaveMissionData:�ý�ɫ����������Ϣ���ݶ�ȡ����!ID = %d", pCha->GetID() );
		//LG(szDBLog, "SaveMissionData:�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ������ʷ��¼����ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00018), pCha->GetID() );
		LG(szDBLog, "SaveMissionData:save character[ID: %d\tNAME: %s]data info,Get mission history data error !ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
	
	}

	memset( g_szTrigger, 0, ROLE_MAXSIZE_DBTRIGGER );
	if( !pPlayer->MisGetTrigger( g_szTrigger, ROLE_MAXSIZE_DBTRIGGER - 1 ) )
	{
		//pCha->SystemNotice( "SaveMissionData:�ý�ɫ����������Ϣ���������ݶ�ȡ����!ID = %d", pCha->GetID() );
		//LG(szDBLog, "SaveMissionData:�����ɫ[ID: %d\tNAME: %s]������Ϣ����ȡ���񴥷�������ʧ��!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00019), pCha->GetID() );
		LG(szDBLog, "SaveMissionData:save character[ID: %d\tNAME: %s]data info��Get mission trigger data error!ID = %d\n", cha_id, pCha->GetName(), pCha->GetID() );

	}

	//sprintf( g_sql, "update %s set mission='%s', misrecord='%s', mistrigger='%s' \
	//	where cha_id=%d", _get_table(), g_szMisInfo, g_szRecord, g_szTrigger, cha_id );
	//_snprintf_s( g_sql,sizeof(g_sql),_TRUNCATE, "update %s set mission='%s', misrecord='%s', mistrigger='%s' \
	//				where cha_id=%d", _get_table(), g_szMisInfo, g_szRecord, g_szTrigger, cha_id );

	//if (strlen(g_sql) >= SQL_MAXLEN)
	//{
	//	//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
	//	//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
	//	FILE	*pf = NULL ;
	//	if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
	//	{
	//		LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
	//		return FALSE;
	//	}
	//	if (pf)
	//	{
	//		fprintf(pf, "%s\n\n", g_sql);
	//		fclose(pf);
	//	}
	//	//LG("enter_map", "SQL��䳤��Խ��!\n");
	//	LG("enter_map", "SQL sentence length slop over\n");
	//	return FALSE;
	//}
	//short sExec = exec_sql_direct( g_sql );
	short sExec = stored_procedure("{CALL dbo.SaveMissionData(?, ?, ?, ?}", "dbo", "SaveMissionData",4, &g_szMisInfo, &g_szRecord, &g_szTrigger, &cha_id);

	if(!DBOK(sExec))
	{
		LG("stored_procedure", "FAILED SaveMissionData. cha_id=%ld", cha_id);
	}
	if(DBNODATA(sExec))
	{
		LG("stored_procedure", "NO DATA SaveMissionData. cha_id=%ld", cha_id);
	}

	return DBOK(sExec) && !DBNODATA(sExec);
T_E}

//Add by sunny.sun 20090310
BOOL CTableCha::UpdateEnterMapTime( DWORD cha_id )
{
	_snprintf_s( g_sql, sizeof(g_sql),_TRUNCATE,"update %s set entermaptime = getdate() where cha_id = %d", _get_table(), cha_id );

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		LG2("distime", "update player[id] = %d entermaptime error! \n",cha_id);
		return false;
	}
	return true;
}

BOOL CTableCha::UpdateOutMapTime(DWORD cha_id)
{
	_snprintf_s( g_sql, sizeof(g_sql),_TRUNCATE,"update %s set outmaptime = getdate() where cha_id = %d", _get_table(), cha_id );

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		LG2("error", "update player[id] = %d outmaptime error! \n",cha_id);
		return false;
	}
	return true;
}

BOOL CTableCha::ConvertCTime( string stime, CTime & ctime )
{
	if( stime != "" )
	{
		string timenum[4];
		int n1 = Util_ResolveTextLine( stime.c_str(), timenum, 3, ' ');
		string date = timenum[0];
		string tim = timenum[1];
		string datenum[3];
		int n2 = Util_ResolveTextLine( date.c_str(), datenum, 3,'-');
		int year = atoi(datenum[0].c_str());
		int month = atoi( datenum[1].c_str());
		int day = atoi( datenum[2].c_str());
		string timnum[3];
		int n3 = Util_ResolveTextLine( tim.c_str(), timnum, 3, ':');
		int hour = atoi(timnum[0].c_str());
		int minute = atoi( timnum[1].c_str());
		int secend = atoi( timnum[2].c_str());
		ctime = CTime( year, month, day, hour, minute, secend );
		return true;
	}
	return false;
}

BOOL CTableCha::CalculateDisTime( CCharacter * pCCha, int &distime)
{
	if( !pCCha->GetPlayer())
		return false;

	const int MAX_GETTIME = 24 * 60;
	const int MAX_DAYTIME = 8 * 60;

	int Span[3] = {0,0,0};//���죬���죬ǰ��
	int DisTemp = 0;//EXTEND10�洢����ʱ��
	LLong distemp = 0;//threedistime��ʱ�洢����ʱ��

	string ltime,ntime;

	CTime LeaveTime = 0, NowTime = 0;//����ʱ�䣬����ʱ��
	CTime Curtime = 0;

	string buf[3];
	char param[] = "entermaptime,outmaptime,threedistime";
	char entparam[] = "entermaptime";
	char filter[80];
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d ",pCCha->m_ID );
	//int r = _get_row(buf, 3, param, filter);
	int r  = _get_rowSafely(buf, 3, param, GAME_CTABLECHA_CALCULATEDISTIME_1, NULL, 1, &pCCha->m_ID);
	int	r1 = get_affected_rows();
	if ( DBOK(r) && r1 > 0)
	{
		bool Flag = false;//�Ƿ��������ʱ��
		if(buf[1] == "")
		{
			LeaveTime = CTime::GetCurrentTime();
		}
		else
		{
			ltime = buf[1];
			ConvertCTime( ltime,LeaveTime ) ;
		}
		CTimeSpan downSpan = 0;//ʱ���
		Curtime = CTime::GetCurrentTime();	
		downSpan = Curtime - LeaveTime;
		ntime = buf[0];
		ConvertCTime( ntime,NowTime ) ;
		distemp = (int)_atoi64(buf[2].c_str());

		DisTemp = (int)pCCha->getAttr( ATTR_EXTEND10 );

		//�õ��������ʱ��״̬ ���죬���죬ǰ��
		Span[0] = int(distemp & ((1 << 10) - 1)) ;
		Span[1] = int((distemp >> 9) & ((1 << 10) - 1));
		Span[2] = int((distemp >> 18) & ((1 << 10) - 1));

		if( downSpan.GetHours() < 1 && (downSpan.GetDays() == 0 ))
		{
			if( UpdateEnterMapTime( pCCha->m_ID ))
				LG2("distime","%s Linear time is not more than 1 hours!\n",pCCha->m_name );
			distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
			return false;
		}
		else
		{			
			bool index = false;
			//����Ѿ�������򷵻أ����ټ���
			if( (Span[0] + Span[1] + Span[2] + DisTemp) >=  MAX_GETTIME )
			{
				Flag = true;
				//�洢����ʱ��		
				if( ! UpdateEnterMapTime( pCCha->m_ID ) )
					return false;
			}
			else //δ��
			{
				if( (LeaveTime.GetDay() != NowTime.GetDay()) || downSpan.GetDays() > 0 )
				{
					DisTemp = DisTemp + Span[2] + Span[1] + Span[0];
					Span[2] = Span[1] = Span[0] = 0;
				}
				//�洢����ʱ��		
				if( ! UpdateEnterMapTime( pCCha->m_ID ) )
				{
					distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
					return false;
				}
				_snprintf_s( filter, sizeof(filter),_TRUNCATE,"cha_id = %d", pCCha->m_ID );
				//int r = _get_row(buf, 1, entparam, filter);
				int r  = _get_rowSafely(buf, 1, entparam, GAME_CTABLECHA_CALCULATEDISTIME_2, NULL, 1, &pCCha->m_ID);
				int	r1 = get_affected_rows();
				if ( DBOK(r) && r1 > 0)
				{
					ntime = buf[0];
					ConvertCTime( ntime,NowTime ) ;
					CTimeSpan SpanOneDay(1,0,0,0);
					CTimeSpan SpanTodDay(0,NowTime.GetHour(),NowTime.GetMinute(),NowTime.GetSecond());//�������
	
					CTime T[3];//������㣬ǰһ����㣬ǰ�������
					T[0] = NowTime - SpanTodDay;//�������
					T[1] = T[0] - SpanOneDay;//ǰһ�����
					T[2] = T[1] - SpanOneDay;//ǰ�������

					downSpan = NowTime - LeaveTime;//������ʱ���
					if( downSpan.GetDays() > 2 )//�Ѿ����3��
					{
						Flag = true;
					}
					else if ( downSpan.GetDays() > 1 ) // �Ѿ����2��
					{
						//����2��
						DisTemp = DisTemp + Span[2] + Span[1];
						Span[2] = Span[0];//�ϸ������ѱ��ǰ��
						Span[1] = Span[0] = 0;//��շ���ε�ʱ��
						// ����ǰ���ʱ��
						downSpan = T[1] - LeaveTime;
						if (Span[2] + downSpan.GetHours()*60 + downSpan.GetMinutes() > MAX_DAYTIME )
							Span[2] = MAX_DAYTIME;
						else
							Span[2] = Span[2] + downSpan.GetHours()*60 + downSpan.GetMinutes();

						// �����ʱ��
						Span[1] = MAX_DAYTIME; // ����ȫ������
						// �����ʱ��
						downSpan = NowTime - T[0];
						if (downSpan.GetHours()  > MAX_DAYTIME)
							Span[0] = MAX_DAYTIME;
						else
							Span[0] = Span[0] + downSpan.GetHours()*60 + downSpan.GetMinutes();
					}
					else if((NowTime.GetDay() == LeaveTime.GetDay()) && (downSpan.GetDays() == 0) )
					{
						downSpan = NowTime - LeaveTime;
						if (Span[0] + downSpan.GetHours()*60 + downSpan.GetMinutes() > MAX_DAYTIME)
							Span[0] = MAX_DAYTIME;
						else
							Span[0] = Span[0] + downSpan.GetHours()*60 + downSpan.GetMinutes();
					}
					else
					{
						DisTemp = DisTemp+Span[2];
						Span[2] = Span[1];
						Span[1] = Span[0];
						Span[0] = 0;

						downSpan =T[0] - LeaveTime ;
						if (Span[1] + downSpan.GetHours()*60 + downSpan.GetMinutes() > MAX_DAYTIME)
							Span[1] = MAX_DAYTIME;
						else
							Span[1] = Span[1] + downSpan.GetHours()*60 + downSpan.GetMinutes();

						downSpan = NowTime - T[0];
						if (Span[0] + downSpan.GetHours()*60 + downSpan.GetMinutes()> MAX_DAYTIME)
							Span[0] = MAX_DAYTIME;
						else
							Span[0] = Span[0] + downSpan.GetHours()*60 + downSpan.GetMinutes();
					}

					if( (DisTemp + Span[0] + Span[1] + Span[2]) >= MAX_GETTIME )
					{
						Flag = true;
					}
				}
				else
				{
					distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
					LG2( "distime"," can't find entermaptime where cha_id = %d\n",pCCha->m_ID );
					return false;
				}
			}
			if( Flag == true )		
			{
				Span[0] = MAX_DAYTIME;
				Span[1] = MAX_DAYTIME;
				Span[2] = MAX_DAYTIME;
				DisTemp = 0;
			}
			distemp = Span[0] + (Span[1] << 9) + (Span[2] << 18);	

			_snprintf_s( filter, sizeof(filter),_TRUNCATE,"update %s set threedistime = %lld where cha_id = %d", _get_table(),distemp, pCCha->m_ID  );
			short sExec =  exec_sql_direct(filter);
			if (!DBOK(sExec))
			{
				distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
				LG2("distime", "update %s set threedistime = %lld where cha_id = %d \n", _get_table(),distemp, pCCha->m_ID );
				return false;
			}
			pCCha->setAttr(ATTR_EXTEND10,DisTemp);
			distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
			return true;
		}		
	}
	return false;
}

BOOL CTableCha::GetDisTime( CCharacter * pCCha, int & distime )
{
	if( !pCCha )
		return false;
	char param[] = "threedistime";
	char filter[80];
	string buf[1];
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d ",pCCha->m_ID );
	//int r = _get_row(buf, 1, param, filter);
	int r  = _get_rowSafely(buf, 1, param, GAME_CTABLECHA_GETDISTIME, NULL, 1, &pCCha->m_ID);
	int	r1 = get_affected_rows();
	if ( DBOK(r) && r1 > 0)
	{
		LLong 	distemp = (int)_atoi64(buf[0].c_str());
		int Span[3] = {0,0,0};
		Span[0] = int(distemp & ((1 << 10) - 1)) ;
		Span[1] = int((distemp >> 9) & ((1 << 10) - 1));
		Span[2] = int((distemp >> 18) & ((1 << 10) - 1));
		
		int DisTemp = 0;
		DisTemp = (int)pCCha->getAttr( ATTR_EXTEND10 );
		distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
		return true;
	}
	return false;
}

BOOL CTableCha::UpdateDisTime( CCharacter *pCCha, int iSelTime )
{
	if( !pCCha )
		return false;
	char param[] = "threedistime";
	char filter[80];
	string buf[1];
	LLong distime = 0;
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d ",pCCha->m_ID );
	//int r = _get_row(buf, 1, param, filter);
	int r  = _get_rowSafely(buf, 1, param, GAME_CTABLECHA_UPDATEDISTIME_1, NULL, 1, &pCCha->m_ID);
	int	r1 = get_affected_rows();
	if ( DBOK(r) && r1 > 0)
	{
		LLong 	distemp = (int)_atoi64(buf[0].c_str());
		int Span[3] = {0,0,0};
		Span[0] = int(distemp & ((1 << 10) - 1)) ;
		Span[1] = int((distemp >> 9) & ((1 << 10) - 1));
		Span[2] = int((distemp >> 18) & ((1 << 10) - 1));
		
		int DisTemp = 0;
		DisTemp = (int)pCCha->getAttr( ATTR_EXTEND10 );
		distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
		if( distime < iSelTime )
		{
			LG("distime","distime is less than select time!\n");
			return false;
		}
		else
		{
			if( iSelTime*60 > Span[0] )
			{
				if( iSelTime * 60 > (DisTemp + Span[0] + Span[1] + Span[2]))
				{
					pCCha->SystemNotice("You have not enough time to get!");
					return false;
				}
				DisTemp =  DisTemp + Span[0] + Span[1] + Span[2] - iSelTime*60;
				Span[0] = Span[1] = Span[2] = 0;
				pCCha->setAttr(ATTR_EXTEND10,DisTemp);
				_snprintf_s( filter, sizeof(filter),_TRUNCATE,"update %s set threedistime = 0 where cha_id = %d", _get_table(),pCCha->m_ID  );
				short sExec =  exec_sql_direct(filter);
				if (!DBOK(sExec))
				{
					distime = (int)( DisTemp + Span[0] + Span[1] + Span[2] )/60;
					LG2("distime", "updatedistime %s set threedistime = 0 where cha_id = %d \n", _get_table(), pCCha->m_ID );
					return false;
				}
			}
			else
			{
				Span[0] -= (iSelTime*60);
				distemp = Span[0] + (Span[1] << 9) + (Span[2] << 18);	
				_snprintf_s( filter, sizeof(filter),_TRUNCATE,"update %s set threedistime = %lld where cha_id = %d", _get_table(),distemp, pCCha->m_ID  );
				short sExec =  exec_sql_direct(filter);
				if (!DBOK(sExec))
				{
					LG2("distime", "updatedistime %s set threedistime = %lld  where cha_id = %d \n", _get_table(),distemp, pCCha->m_ID );
					return false;
				}
			}
		}
		return true;
	}
	return false;
}

BOOL CTableCha::SetDisTime( CCharacter * pCCha, int iSelTime )
{
	char filter[80];
	_snprintf_s( filter, sizeof(filter),_TRUNCATE,"update %s set threedistime = 0 where cha_id = %d", _get_table(), pCCha->m_ID  );
	short sExec =  exec_sql_direct(filter);
	if (DBOK(sExec))
	{
		pCCha->setAttr(ATTR_EXTEND10,iSelTime * 60);
		return true;
	}
		LG("distime"," SetDisTime error!\n");
		return false;
}

//ȡˮ��ƽ̨����ʻ����
BOOL CTableCha::GetdwFlatMoney( const char* cha_name,  DWORD& FlatMoney )
{
	char param[] = "flatcoins";
	char filter[80];
	string buf[1];
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_name = '%s' ",cha_name );
	//int r = _get_row(buf, 1, param, filter);
	int r  = _get_rowSafely(buf, 1, param, GAME_CTABLECHA_GETDWFLATMONEY_1, NULL, 1, cha_name);
	int	r1 = get_affected_rows();
	if ( DBOK(r) && r1 > 0)
	{
		FlatMoney = atoi( buf[0].c_str());
		return true;
	}
	return false;
}

BOOL CTableCha::SetdwFlatMoney( DWORD cha_tid, DWORD FlatMoney )
{
	char param[] = "flatcoins";
	char filter[80];
	string buf[1];
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d",cha_tid );
	int r = _get_row(buf, 1, param, filter);
	int	r1 = get_affected_rows();
	if ( !DBOK(r) || r1 <= 0)
	{
		LG("Crystal_error","AcceptCrystalAdd TO DB ��flatcoins�� ChaID: [%d] Add flatcoins: (%ld) Failed!, Can't find flatcoins \n", cha_tid, FlatMoney);
		return false;
	}
	DWORD OldFlatMoney = atoi( buf[0].c_str());
	_snprintf_s( g_sql,sizeof(g_sql),_TRUNCATE, "update %s set flatcoins = flatcoins + %d where cha_id = %d ", _get_table(), FlatMoney, cha_tid );
	short sExec =  exec_sql_direct(g_sql);
	if (DBOK(sExec))
	{
		LG("Crystal_msg", "AcceptCrystalAdd TO DB��flatcoins�� ChaID: [%d], oldFlatMoney : (%lu) Add flatcoins: (%ld) Successed! \n",cha_tid, OldFlatMoney, FlatMoney );
		return true;
	}
	LG("Crystal_msg", "AcceptCrystalAdd TO DB ��flatcoins�� ChaID: [%d], oldFlatMoney : (%lu) Add flatcoins: (%ld) Failed! \n",cha_tid, OldFlatMoney, FlatMoney );
	return false;
}
//End

//personinfo ��ʼ��
bool CTablePersoninfo::Init( void )
{
	//sprintf(g_sql, "select cha_id from %s (nolock) where 1=2", _get_table());
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select cha_id from %s (nolock) where 1=2", _get_table());

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(AmphitheaterSetting)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "personinfo");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "personinfo");
		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

//��ȡbirthday
bool CTablePersoninfo::GetPersonBirthday( int chaid, int &birthday )
{
	string buf[1];
	char param[] = "birthday";
	char filter[80];
	
	//sprintf(filter, "cha_id = %d ",chaid);
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d ",chaid);

	int r = _get_row(buf, 1, param, filter);
	int	r1 = get_affected_rows();
	if ( DBOK(r) && r1 > 0)
	{
		if(strcmp(buf[0].c_str() ,"NULL") == 0)
			return false;
		else
			birthday = Str2Int(buf[0]);
		return true;
	}
	return false;
}

// End

bool CTableResource::Init(void)
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   id, cha_id, type_id, content \
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(resource)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "resource");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "resource");
		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

bool CTableResource::Create(long &lDBID, long lChaId, long lTypeId)
{
	//sprintf( g_sql, "insert %s (cha_id, type_id) \
	//				values(%d, %d) ",	_get_table(), 
	//				lChaId, lTypeId);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "insert %s (cha_id, type_id) \
					values(%d, %d) ",	_get_table(), 
			//		lChaId, lTypeId);
					/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}

		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	*/
	//short sExec = exec_sql_direct( g_sql );
	short sExec = stored_procedure("{CALL dbo.ResourceCreate(?,?)}", "dbo", "ResourceCreate", 2, &lChaId, &lTypeId);
	if( DBOK(sExec) )
	{
		string buf[1]; 
		char param[] = "@@identity";
		char filter[80]; 
		//sprintf(filter, "1=1");
		_snprintf_s(filter,sizeof(filter),_TRUNCATE, "1=1");
		bool ret = _get_row(buf, 1, param, filter);
		lDBID = atol( buf[0].c_str() );
		return true;
	}

	return false;
}

bool CTableResource::ReadKitbagData(CCharacter *pCha)
{
	//LG("Thread", "DB ReadKitbagData %d\n", ::GetCurrentThreadId());

	if (!pCha)
	{
		//LG("enter_map", "����Դ���ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load resource database error,character is inexistence\n");
		return false;
	}
	if (pCha->GetKitbagRecDBID() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCha->GetPlayer()->GetDBChaId(), enumRESDB_TYPE_KITBAG))
			return false;
		pCha->SetKitbagRecDBID(lDBID);
	}

	int nIndex = 0;
	//char param[] = "cha_id, type_id, content";
	//char filter[80]; //sprintf(filter, "id=%d", pCha->GetKitbagRecDBID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCha->GetKitbagRecDBID());
	//int r = _get_row3(g_buf, g_cnCol, param, filter);
	// Same as ReadKitbagTmpDataEx
	const DWORD param1 = pCha->GetKitbagRecDBID();
	int			r	   = _get_row_stored_procedure_whitespace(g_buf, g_cnCol, "{CALL dbo.ReadKitbagTmpDataEx(?)}", "dbo", "ReadKitbagTmpDataEx", NULL, 1, &param1);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		DWORD	dwChaId = Str2Int(g_buf[nIndex++]);
		char	chType = Str2Int(g_buf[nIndex++]);
		if (dwChaId != pCha->GetPlayer()->GetDBChaId() || chType != enumRESDB_TYPE_KITBAG)
		{
			//LG("enter_map", "����Դ���ݿ���󣬽�ɫ��ƥ��.\n");
			LG("enter_map", "Load resource database error��character is not matching.\n");
			return false;
		}
		if (!pCha->String2KitbagData(g_buf[nIndex++]))
		{
			//LG("enter_map", "��������У��ʹ���.\n");
			LG("enter_map", "kitbag data check sum error.\n");
			//LG("У��ʹ���", "��ɫ��%s���ı������ݣ�resource_id %u��У��ʹ���.\n", pCha->GetLogName(), pCha->GetKitbagRecDBID());
			LG("check sum error", "character(%s) kitbag data(resource_id %u) check sum error.\n", pCha->GetLogName(), pCha->GetKitbagRecDBID());
			return false;
		}
	}
	else
	{
		//LG("enter_map", "����Դ���ݿ����_get_row()����ֵ��%d.\n", r);
		LG("enter_map", "Load resource database error��_get_row()return value:%d.\n", r);
		return false;
	}
	//LG("enter_map", "���������ݳɹ�.\n");
	LG("enter_map", "Load kitbag data succeed.\n");
	return true;
}


bool CTableResource::ReadKitbagDataEx(CCharacter *pCha)
{
	//LG("Thread", "DB ReadKitbagData %d\n", ::GetCurrentThreadId());

	if (!pCha)
	{
		//LG("enter_map", "����Դ���ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load resource database error,character is inexistence\n");
		return false;
	}
	if (pCha->GetKitbagRecDBID() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCha->GetPlayer()->GetDBChaId(), enumRESDB_TYPE_KITBAG))
			return false;
		pCha->SetKitbagRecDBID(lDBID);
	}

	int nIndex = 0;
	//char param[] = "cha_id, type_id, content";
	string stringBufs[64];

	//char filter[80]; //sprintf(filter, "id=%d", pCha->GetKitbagRecDBID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCha->GetKitbagRecDBID());
	//int r = _get_row3(stringBufs, 64, param, filter);
	// Same as [ReadKitbagTmpDataEx]
	const DWORD param1 = pCha->GetKitbagRecDBID();
	int			r	   = _get_row_stored_procedure_whitespace(stringBufs, 64, "{CALL dbo.ReadKitbagTmpDataEx(?)}", "dbo", "ReadKitbagTmpDataEx", NULL, 1, &param1);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		DWORD	dwChaId = Str2Int(stringBufs[nIndex++]);
		char	chType = Str2Int(stringBufs[nIndex++]);
		if (dwChaId != pCha->GetPlayer()->GetDBChaId() || chType != enumRESDB_TYPE_KITBAG)
		{
			//LG("enter_map", "����Դ���ݿ���󣬽�ɫ��ƥ��.\n");
			LG("enter_map", "Load resource database error��character is not matching.\n");
			return false;
		}
		if (!pCha->String2KitbagData(stringBufs[nIndex++]))
		{
			//LG("enter_map", "��������У��ʹ���.\n");
			LG("enter_map", "kitbag data check sum error.\n");
			//LG("У��ʹ���", "��ɫ��%s���ı������ݣ�resource_id %u��У��ʹ���.\n", pCha->GetLogName(), pCha->GetKitbagRecDBID());
			LG("check sum error", "character(%s) kitbag data(resource_id %u) check sum error.\n", pCha->GetLogName(), pCha->GetKitbagRecDBID());
			return false;
		}
	}
	else
	{
		//LG("enter_map", "����Դ���ݿ����_get_row()����ֵ��%d.\n", r);
		LG("enter_map", "Load resource database error��_get_row()return value:%d.\n", r);
		return false;
	}
	//LG("enter_map", "���������ݳɹ�.\n");
	LG("enter_map", "Load kitbag data succeed.\n");
	return true;
}


bool CTableResource::SaveKitbagData(CCharacter *pCha)
{
	//LG("Thread", "DB SaveKitbagData %d\n", ::GetCurrentThreadId());

	if(!pCha || !pCha->IsValid()) return false;

	//LG("enter_map", "��ʼ���汳������!\n");
	//g_kitbag[0] = 0;
	memset(g_kitbag, 0, sizeof(g_kitbag));

	if (!KitbagData2String(pCha->GetKitbag(), g_kitbag, defKITBAG_DATA_STRING_LEN))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ�������ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data(kitbag) error!\n", pCha->GetLogName());
		return false;
	}
	//LG("enter_map", "ת���������ݳɹ�\n");

	//sprintf(g_sql, "update %s set \
	//			   content='%s' \
	//			   where id=%d", \
	//			   _get_table(), \
	//			   g_kitbag, \
	//			   pCha->GetKitbagRecDBID());
	memset(g_sql, 0, sizeof(g_sql));
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
				   content='%s' \
				   where id=%d", \
				   _get_table(), \
				   g_kitbag, \
				   pCha->GetKitbagRecDBID());

	//LG("enter_map", "��֯SQL���ɹ�\n");
	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}

		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}*/
	// SAME AS SaveKitbagTmpDataaEx
	const DWORD param1 = pCha->GetKitbagRecDBID();
	short		sExec  = stored_procedure("{CALL dbo.SaveKitbagTmpDataEx(?,?)}", "dbo", "SaveKitbagTmpDataEx", 2, g_kitbag, &param1);
	//short sExec =  exec_sql_direct(g_sql);
	//LG("enter_map", "ִ��SQL���ɹ�\n");
	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\t carry out SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ���ñ�����Դ%u!\n", pCha->GetKitbagRecDBID());
		LG("enter_map", "Database couldn't find the kitbag resource %u!\n", pCha->GetKitbagRecDBID());
		return false;
	}
	//LG("enter_map", "��ɱ�������.\n");
	LG("enter_map", "finish kitbag save.\n");

	return true;
}

bool CTableResource::SaveKitbagDataEx(CCharacter *pCha)
{
	//LG("Thread", "DB SaveKitbagData %d\n", ::GetCurrentThreadId());

	if(!pCha || !pCha->IsValid()) return false;

	//LG("enter_map", "��ʼ���汳������!\n");
	//g_kitbag[0] = 0;
	//char kitbag[defKITBAG_DATA_STRING_LEN];
	//memset(kitbag, 0, sizeof(kitbag));
	StringPoolL stringPool;
	stringPool.ReserveBuf(StringPoolL::AllocateSpace1);
	stringPool.ReserveNum(StringPoolL::AllocateSpace2);
	//memset(look, 0, sizeof(look));
	stringPool[0] = "";

	if (!KitbagData2StringEx(pCha->GetKitbag(), stringPool, 0))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ�������ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data(kitbag) error!\n", pCha->GetLogName());
		return false;
	}

	//::OutputDebugStr((const char*)stringPool[0]);

	//LG("enter_map", "ת���������ݳɹ�\n");

	//sprintf(g_sql, "update %s set \
	//			   content='%s' \
	//			   where id=%d", \
	//			   _get_table(), \
	//			   g_kitbag, \
	//			   pCha->GetKitbagRecDBID());

	//char sql[SQL_MAXLEN];
	//memset(sql, 0, sizeof(sql));

	//_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set \
				   content='%s' \
				   where id=%d", \
				   _get_table(), \
				   (const char*)stringPool[0], \
				   pCha->GetKitbagRecDBID());

	//short sExec =  exec_sql_direct(sql);
	// SAME AS SaveKitbagTmpDataaEx
	const DWORD param1 = pCha->GetKitbagRecDBID();
	short		sExec  = stored_procedure("{CALL dbo.SaveKitbagTmpDataEx(?,?)}", "dbo", "SaveKitbagTmpDataEx", 2, (const char*)stringPool[0], &param1);
	//LG("enter_map", "ִ��SQL���ɹ�\n");
	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\t carry out SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ���ñ�����Դ%u!\n", pCha->GetKitbagRecDBID());
		LG("enter_map", "Database couldn't find the kitbag resource %u!\n", pCha->GetKitbagRecDBID());
		return false;
	}
	//LG("enter_map", "��ɱ�������.\n");
	LG("enter_map", "finish kitbag save.\n");

	return true;
}

bool CTableResource::ReadKitbagTmpData(CCharacter *pCha)
{
    if (!pCha)
	{
		//LG("enter_map", "����Դ���ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load resource database error,character is inexistence.\n");
		return false;
	}
	if (pCha->GetKitbagTmpRecDBID() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCha->GetPlayer()->GetDBChaId(), enumRESDB_TYPE_KITBAGTMP))
			return false;
		pCha->SetKitbagTmpRecDBID(lDBID);
	}

	int nIndex = 0;
	//char param[] = "cha_id, type_id, content";
	//char filter[80]; //sprintf(filter, "id=%d", pCha->GetKitbagTmpRecDBID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCha->GetKitbagTmpRecDBID());
	//int r = _get_row3(g_buf, g_cnCol, param, filter);

	// SAME AS READKITBAGTMPDATAEX
	const DWORD param1 = pCha->GetKitbagTmpRecDBID();
	int r  = _get_row_stored_procedure_whitespace(g_buf, g_cnCol, "{CALL dbo.ReadKitbagTmpDataEx(?)}", "dbo", "ReadKitbagTmpDataEx", NULL, 1, &param1);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		DWORD	dwChaId = Str2Int(g_buf[nIndex++]);
		char	chType = Str2Int(g_buf[nIndex++]);
		if (dwChaId != pCha->GetPlayer()->GetDBChaId() || chType != enumRESDB_TYPE_KITBAGTMP)
		{
			//LG("enter_map", "����Դ���ݿ���󣬽�ɫ��ƥ��.\n");
			LG("enter_map", "Load resource database error,character is not matching.\n");
			return false;
		}
		if (!pCha->String2KitbagTmpData(g_buf[nIndex++]))
		{
			//LG("enter_map", "��ʱ��������У��ʹ���.\n");
			LG("enter_map", "Temp kitbag data check sum error.\n");
			//LG("У��ʹ���", "��ɫ��%s������ʱ�������ݣ�resource_id %u��У��ʹ���.\n", pCha->GetLogName(), pCha->GetKitbagTmpRecDBID());
			LG("check sum error", "character(%s) temp kitbag data(resource_id %u)check sum error.\n", pCha->GetLogName(), pCha->GetKitbagTmpRecDBID());
			return false;
		}
	}
	else
	{
		//LG("enter_map", "����Դ���ݿ����_get_row()����ֵ��%d.\n", r);
		LG("enter_map", "Load resource database error,_get_row() return value:%d.\n", r);
		return false;
	}
	//LG("enter_map", "����ʱ�������ݳɹ�.\n");
	LG("enter_map", "Load temp kitbag data succeed.\n");

	return true;
}


bool CTableResource::ReadKitbagTmpDataEx(CCharacter *pCha)
{
    if (!pCha)
	{
		//LG("enter_map", "����Դ���ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load resource database error,character is inexistence.\n");
		return false;
	}
	if (pCha->GetKitbagTmpRecDBID() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCha->GetPlayer()->GetDBChaId(), enumRESDB_TYPE_KITBAGTMP))
			return false;
		pCha->SetKitbagTmpRecDBID(lDBID);
	}

	int nIndex = 0;
	//char param[] = "cha_id, type_id, content";
	string stringBufs[64];

	//char filter[80]; //sprintf(filter, "id=%d", pCha->GetKitbagTmpRecDBID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCha->GetKitbagTmpRecDBID());
	const DWORD param1 = pCha->GetKitbagTmpRecDBID();

	//int r = _get_row3(stringBufs, 64, param, filter);
	int r  = _get_row_stored_procedure_whitespace(stringBufs, 64, "{CALL dbo.ReadKitbagTmpDataEx(?)}", "dbo", "ReadKitbagTmpDataEx", NULL, 1, &param1);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		DWORD	dwChaId = Str2Int(stringBufs[nIndex++]);
		char	chType = Str2Int(stringBufs[nIndex++]);
		if (dwChaId != pCha->GetPlayer()->GetDBChaId() || chType != enumRESDB_TYPE_KITBAGTMP)
		{
			//LG("enter_map", "����Դ���ݿ���󣬽�ɫ��ƥ��.\n");
			LG("enter_map", "Load resource database error,character is not matching.\n");
			return false;
		}
		if (!pCha->String2KitbagTmpData(stringBufs[nIndex++]))
		{
			//LG("enter_map", "��ʱ��������У��ʹ���.\n");
			LG("enter_map", "Temp kitbag data check sum error.\n");
			//LG("У��ʹ���", "��ɫ��%s������ʱ�������ݣ�resource_id %u��У��ʹ���.\n", pCha->GetLogName(), pCha->GetKitbagTmpRecDBID());
			LG("check sum error", "character(%s) temp kitbag data(resource_id %u)check sum error.\n", pCha->GetLogName(), pCha->GetKitbagTmpRecDBID());
			return false;
		}
	}
	else
	{
		//LG("enter_map", "����Դ���ݿ����_get_row()����ֵ��%d.\n", r);
		LG("enter_map", "Load resource database error,_get_row() return value:%d.\n", r);
		return false;
	}
	//LG("enter_map", "����ʱ�������ݳɹ�.\n");
	LG("enter_map", "Load temp kitbag data succeed.\n");

	return true;
}


bool CTableResource::ReadKitbagTmpData(long lRecDBID, string& strData)
{
	if(lRecDBID == 0)
	{
		return false;
	}

	BOOL ret = false;

	//char *sql_syntax = "select content from %s where id=%d";
	//char sql[SQL_MAXLEN];
	//sprintf(sql, sql_syntax, _get_table(), lRecDBID);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, sql_syntax, _get_table(), lRecDBID);

	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found = true;
	const char	sql[]	= "{CALL dbo.ReadKitbagTmpData(?)}";
	try
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

			throw 1;
		}

		// Time complexity to find in an unordered_map: O(1) (average).
		std::vector<SQLParamData>* cached_params = nullptr;
		auto					   cache		 = _cached_map.find(std::string("ReadKitbagTmpData"));
		if(cache == _cached_map.end())
		{
			// Procedure wasn't cached yet.
			cache_stored_procedure(1, "dbo", "ReadKitbagTmpData");
			cache = _cached_map.find(std::string("ReadKitbagTmpData"));

			if(cache != _cached_map.end())
			{
				cached_params = &(*cache).second;

			} else
			{
				LG2("util_db", "Could not find cached map for procedure: [%s]\n", "ReadKitbagTmpData");
				return false;
			}

		} else
		{
			cached_params = &(*cache).second;
		}
		//
		// Time to bind parameters.
		for(SQLUSMALLINT i = 0; i < 1; i++)
		{
			if(!cached_params)
			{
				break;
			}
			SQLSMALLINT sql_data_type = cached_params->at(i).sql_data_type;
			SQLUINTEGER column_length = cached_params->at(i).column_length;
			const char* param_pointer = (const char*)&lRecDBID;

			sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, sql_data_type, column_length, 0,
									  (SQLPOINTER)param_pointer, 0, 0);

			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}
		}

		sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
		if (sqlret != SQL_SUCCESS)
		{
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);

			if (sqlret != SQL_SUCCESS_WITH_INFO)
				throw 2;
		}

		sqlret = SQLNumResultCols(hstmt, &col_num);
		col_num = std::min<decltype(col_num)>(col_num, MAX_COL);
		col_num = std::min<decltype(col_num)>(col_num, _max_col);

		// Bind Column
		for (int i = 0; i < col_num; ++ i)
		{
			SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
		}

		// Fetch each Row	int i; // ȡ��������
		for (int f_row = 0; (sqlret = SQLFetch(hstmt)) == SQL_SUCCESS || sqlret == SQL_SUCCESS_WITH_INFO; ++ f_row)
		{
			if (sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			}

			strData = (char const *)_buf[0];
		}
		SQLFreeStmt(hstmt, SQL_UNBIND);
		ret = true;
	}catch(int&e)
	{
		//LG("Store_msg", "ReadKitbagTmpData ODBC �ӿڵ��ô���λ���룺%d\n",e);
		LG("Store_msg", "ReadKitbagTmpData ODBC interface transfer error,position ID:%d\n",e);
	}catch (...)
	{
		LG("Store_msg", "Unknown Exception raised when ReadKitbagTmpData\n");
	}

	if (hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return ret;
}

bool CTableResource::SaveKitbagTmpData(long lRecDBID, const string& strData)
{
	if(lRecDBID == 0)
	{
		return false;
	}
	
	memset(g_sql, 0, sizeof(g_sql));
	//sprintf(g_sql, "update %s set \
	//			   content='%s' \
	//			   where id=%d", \
	//			   _get_table(), \
	//			   strData.c_str(), \
	//			   lRecDBID);
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
				   content='%s' \
				   where id=%d", \
				   _get_table(), \
				   strData.c_str(), \
				   lRecDBID);
	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+") != 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}

		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("Store_msg", "SQL��䳤��Խ��!\n");
		LG("Store_msg", "SQL sentence length slop over\n");
		return false;
	}
	short sExec =  exec_sql_direct(g_sql);
	*/
	// Same as SaveKitbagTmpDataEx
	short		sExec  = stored_procedure("{CALL dbo.SaveKitbagTmpDataEx(?,?)}", "dbo", "SaveKitbagTmpDataEx", 2, strData.c_str(), &lRecDBID);
	if (!DBOK(sExec))
	{
		//LG("Store_msg", "ִ��SQL���ʱ����!\n");
		LG("Store_msg", "carry out SQL sentence error!\n");
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("Store_msg", "���ݿ�û�в�ѯ������ʱ������Դ%u!\n", lRecDBID);
		LG("Store_msg", "Database couldn't find the temp kitbag resource %u!\n", lRecDBID);
		return false;
	}
	//LG("Store_msg", "�����ʱ��������.\n");
	LG("Store_msg", "finish the temp kitbag save.\n");

	return true;
}

bool CTableResource::SaveKitbagTmpData(CCharacter *pCha)
{
    if(!pCha || !pCha->IsValid()) return false;

	//g_kitbagTmp[0] = 0;
	memset(g_kitbagTmp, 0, sizeof(g_kitbagTmp));
	if (!KitbagData2String(pCha->m_pCKitbagTmp, g_kitbagTmp, defKITBAG_DATA_STRING_LEN))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ���ʱ������ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data(temp kitbag)error!\n", pCha->GetLogName());
		return false;
	}

	//sprintf(g_sql, "update %s set \
	//			   content='%s' \
	//			   where id=%d", \
	//			   _get_table(), \
	//			   g_kitbagTmp, \
	//			   pCha->GetKitbagTmpRecDBID());
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
				   content='%s' \
				   where id=%d", \
				   _get_table(), \
				   g_kitbagTmp, \
				   pCha->GetKitbagTmpRecDBID());

	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+") != 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}

		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	short sExec =  exec_sql_direct(g_sql);
	*/
	//Same as SaveKitbagTmpDataEx
	const DWORD param1 = pCha->GetKitbagTmpRecDBID();
	short		sExec  = stored_procedure("{CALL dbo.SaveKitbagTmpDataEx(?,?)}", "dbo", "SaveKitbagTmpDataEx", 2, g_kitbagTmp, &param1);
	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ������ʱ������Դ%u!\n", pCha->GetKitbagTmpRecDBID());
		LG("enter_map", "Database couldn't find the temp kitbag resource%u!\n", pCha->GetKitbagTmpRecDBID());
		return false;
	}
	//LG("enter_map", "�����ʱ��������.\n");
	LG("enter_map", "finish save the temp kitbag.\n");

	return true;
}

bool CTableResource::SaveKitbagTmpDataEx(CCharacter *pCha)
{
    if(!pCha || !pCha->IsValid()) return false;

	//g_kitbagTmp[0] = 0;
	//char kitbagTmp[defKITBAG_DATA_STRING_LEN];
	//memset(kitbagTmp, 0, sizeof(kitbagTmp));
	StringPoolL stringPool;
	stringPool.ReserveBuf(StringPoolL::AllocateSpace1);
	stringPool.ReserveNum(StringPoolL::AllocateSpace2);
	//memset(look, 0, sizeof(look));
	stringPool[0] = "";
	if (!KitbagData2StringEx(pCha->m_pCKitbagTmp, stringPool, 0))
	{
		//LG("enter_map", "��ɫ%s\t�������ݣ���ʱ������ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tsave data(temp kitbag)error!\n", pCha->GetLogName());
		return false;
	}

	//sprintf(g_sql, "update %s set \
	//			   content='%s' \
	//			   where id=%d", \
	//			   _get_table(), \
	//			   g_kitbagTmp, \
	//			   pCha->GetKitbagTmpRecDBID());
	//char sql[SQL_MAXLEN];

	//_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set \
				   content='%s' \
				   where id=%d", \
				   _get_table(), \
				   (const char*)stringPool[0], \
				   pCha->GetKitbagTmpRecDBID());

	//short sExec =  exec_sql_direct(sql);
	const DWORD param1 = pCha->GetKitbagTmpRecDBID();
	short		sExec  = stored_procedure("{CALL dbo.SaveKitbagTmpDataEx(?,?)}", "dbo", "SaveKitbagTmpDataEx", 2, (const char*)stringPool[0], &param1);
	if (!DBOK(sExec))
	{
		//LG("enter_map", "��ɫ%s\tִ��SQL���ʱ����!\n", pCha->GetLogName());
		LG("enter_map", "character %s\tcarry out SQL sentence error!\n", pCha->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ������ʱ������Դ%u!\n", pCha->GetKitbagTmpRecDBID());
		LG("enter_map", "Database couldn't find the temp kitbag resource%u!\n", pCha->GetKitbagTmpRecDBID());
		return false;
	}
	//LG("enter_map", "�����ʱ��������.\n");
	LG("enter_map", "finish save the temp kitbag.\n");

	return true;
}

bool CTableResource::ReadBankData(CPlayer *pCPly, char chBankNO)
{
	if (!pCPly)
	{
		//LG("enter_map", "����Դ���ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load resource database error,character is inexistence.\n");
		return false;
	}
	if (pCPly->GetCurBankNum() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCPly->GetDBChaId(), enumRESDB_TYPE_BANK))
			return false;
		pCPly->AddBankDBID(lDBID);
	}

	char	chStart, chEnd;
	if (chBankNO < 0)
	{
		chStart = 0;
		chEnd = pCPly->GetCurBankNum() - 1;
	}
	else
	{
		if (chBankNO >= pCPly->GetCurBankNum())
			return false;
		chStart = chEnd = chBankNO;
	}

	int nIndex = 0;
	//char param[] = "cha_id, type_id, content";
	//char filter[80];
	int r;
	int	r1;
	for (char i = chStart; i <= chEnd; i++)
	{
		nIndex = 0;
		//sprintf(filter, "id=%d", pCPly->GetBankDBID(i));
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCPly->GetBankDBID(i));

		//r = _get_row3(g_buf, g_cnCol, param, filter);
		// Same as ReadBankDataEx
		const DWORD param1 = pCPly->GetBankDBID(i);
		r  = _get_row_stored_procedure_whitespace(g_buf, g_cnCol, "{CALL dbo.ReadBankDataEx(?)}", "dbo", "ReadBankDataEx", NULL, 1, &param1);
		r1 = get_affected_rows();
		if (DBOK(r) && r1 > 0)
		{
			DWORD	dwChaId = Str2Int(g_buf[nIndex++]);
			char	chType = Str2Int(g_buf[nIndex++]);
			if (dwChaId != pCPly->GetDBChaId() || chType != enumRESDB_TYPE_BANK)
			{
				//LG("enter_map", "����Դ���ݿ���󣬽�ɫ��ƥ��.\n");
				LG("enter_map", "Load resource database error,character is not matching.\n");
				return false;
			}
			if (!pCPly->String2BankData(i, g_buf[nIndex++]))
			{
				//LG("enter_map", "��������У��ʹ���.\n");
				LG("enter_map", "kitbag data check sum error.\n");
				//LG("У��ʹ���", "��ң�%u�����������ݣ�resource_id %u��У��ʹ���.\n", pCPly->GetDBChaId(), pCPly->GetBankDBID(i));
				LG("check sum error", "player (%u) bank data(resource_id %u)check sum error.\n", pCPly->GetDBChaId(), pCPly->GetBankDBID(i));
				return false;
			}
		}
		else
		{
			//LG("enter_map", "����Դ���ݿ����_get_row()����ֵ��%d.\n", r);
			LG("enter_map", "Load resource database error��_get_row() return value:%d.\n", r);
			return false;
		}
	}
	//LG("enter_map", "���������ݳɹ�.\n");
	LG("enter_map", "Load bank data succeed.\n");
	return true;
}


bool CTableResource::ReadBankDataEx(CPlayer *pCPly, char chBankNO)
{
	if (!pCPly)
	{
		//LG("enter_map", "����Դ���ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load resource database error,character is inexistence.\n");
		return false;
	}
	if (pCPly->GetCurBankNum() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCPly->GetDBChaId(), enumRESDB_TYPE_BANK))
			return false;
		pCPly->AddBankDBID(lDBID);
	}

	char	chStart, chEnd;
	if (chBankNO < 0)
	{
		chStart = 0;
		chEnd = pCPly->GetCurBankNum() - 1;
	}
	else
	{
		if (chBankNO >= pCPly->GetCurBankNum())
			return false;
		chStart = chEnd = chBankNO;
	}

	int nIndex = 0;
	//char param[] = "cha_id, type_id, content";
	//char filter[80];
	string stringBufs[64];

	int r;
	int	r1;
	for (char i = chStart; i <= chEnd; i++)
	{
		nIndex = 0;
		//sprintf(filter, "id=%d", pCPly->GetBankDBID(i));
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCPly->GetBankDBID(i));

		//r = _get_row3(stringBufs, 64, param, filter);
		const DWORD param1 = pCPly->GetBankDBID(i);
		r				   = _get_row_stored_procedure_whitespace(stringBufs, 64, "{CALL dbo.ReadBankDataEx(?)}", "dbo", "ReadBankDataEx", NULL, 1, &param1);
		r1 = get_affected_rows();
		if (DBOK(r) && r1 > 0)
		{
			DWORD	dwChaId = Str2Int(stringBufs[nIndex++]);
			char	chType = Str2Int(stringBufs[nIndex++]);
			if (dwChaId != pCPly->GetDBChaId() || chType != enumRESDB_TYPE_BANK)
			{
				//LG("enter_map", "����Դ���ݿ���󣬽�ɫ��ƥ��.\n");
				LG("enter_map", "Load resource database error,character is not matching.\n");
				return false;
			}
			if (!pCPly->String2BankData(i, stringBufs[nIndex++]))
			{
				//LG("enter_map", "��������У��ʹ���.\n");
				LG("enter_map", "kitbag data check sum error.\n");
				//LG("У��ʹ���", "��ң�%u�����������ݣ�resource_id %u��У��ʹ���.\n", pCPly->GetDBChaId(), pCPly->GetBankDBID(i));
				LG("check sum error", "player (%u) bank data(resource_id %u)check sum error.\n", pCPly->GetDBChaId(), pCPly->GetBankDBID(i));
				return false;
			}
		}
		else
		{
			//LG("enter_map", "����Դ���ݿ����_get_row()����ֵ��%d.\n", r);
			LG("enter_map", "Load resource database error��_get_row() return value:%d.\n", r);
			return false;
		}
	}
	//LG("enter_map", "���������ݳɹ�.\n");
	LG("enter_map", "Load bank data succeed.\n");
	return true;
}


bool CTableResource::SaveBankData(CPlayer *pCPly, char chBankNO)
{
	if(!pCPly || !pCPly->IsValid()) return false;
	if (pCPly->GetCurBankNum() == 0)
		return true;

	char	chStart, chEnd;
	if (chBankNO < 0)
	{
		chStart = 0;
		chEnd = pCPly->GetCurBankNum() - 1;
	}
	else
	{
		if (chBankNO >= pCPly->GetCurBankNum())
			return false;
		chStart = chEnd = chBankNO;
	}

	//LG("enter_map", "��ʼ������������!\n");

	for (char i = chStart; i <= chEnd; i++)
	{
		if (!pCPly->BankWillSave(i))
			continue;
		pCPly->SetBankSaveFlag(i, false);
		//g_kitbag[0] = 0;
		memset(g_kitbag, 0, sizeof(g_kitbag));
		if (!KitbagData2String(pCPly->GetBank(i), g_kitbag, defKITBAG_DATA_STRING_LEN))
		{
			//LG("enter_map", "��ɫ%u\t�������ݣ����У�ʱ����!\n", pCPly->GetBankDBID(i));
			LG("enter_map", "character%u\tsave data(bank) error!\n", pCPly->GetBankDBID(i));
			return false;
		}
		//LG("enter_map", "ת���������ݳɹ�\n");

		//sprintf(g_sql, "update %s set \
		//			content='%s' \
		//			where id=%d", \
		//			_get_table(), \
		//			g_kitbag, \
		//			pCPly->GetBankDBID(i));
		//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"update %s set \
					   content='%s' \
					   where id=%d", \
					   _get_table(), \
					   g_kitbag, \
					   pCPly->GetBankDBID(i));

		//LG("enter_map", "��֯SQL���ɹ�\n");
		/*
		if (strlen(g_sql) >= SQL_MAXLEN)
		{
			//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
			//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
			FILE	*pf = NULL;
			if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
			{
				LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
				return FALSE;
			}

			if (pf)
			{
				fprintf(pf, "%s\n\n", g_sql);
				fclose(pf);
			}
			//LG("enter_map", "SQL��䳤��Խ��!\n");
			LG("enter_map", "SQL sentence length slop over\n");
			return false;
		}*/
		//short sExec =  exec_sql_direct(g_sql);
		// Same as SaveBankDataEx
		const DWORD param1 = pCPly->GetBankDBID(i);
		short		sExec  = stored_procedure("{CALL dbo.SaveBankDataEx(?,?)}", "dbo", "SaveBankDataEx", 2, g_kitbag, &param1);
		//LG("enter_map", "ִ��SQL���ɹ�\n");
		if (!DBOK(sExec))
		{
			//LG("enter_map", "���%u\tִ��SQL���ʱ����!\n", pCPly->GetDBChaId());
			LG("enter_map", "player %u\tcarry out SQL sentence error!\n", pCPly->GetDBChaId());
			return false;
		}
		if (DBNODATA(sExec))
		{
			//LG("enter_map", "���ݿ�û�в�ѯ����������Դ%u!\n", pCPly->GetBankDBID(i));
			LG("enter_map", "Database couldn't find the bank resource%u!\n", pCPly->GetBankDBID(i));
			return false;
		}
	}
	//LG("enter_map", "���ȫ������[%d->%d]����.\n", chStart, chEnd);
	LG("enter_map", "finish the whole bank[%d->%d]save\n", chStart, chEnd);
	return true;
}

bool CTableResource::SaveBankDataEx(CPlayer *pCPly, char chBankNO)
{
	if(!pCPly || !pCPly->IsValid()) return false;
	if (pCPly->GetCurBankNum() == 0)
		return true;

	char	chStart, chEnd;
	if (chBankNO < 0)
	{
		chStart = 0;
		chEnd = pCPly->GetCurBankNum() - 1;
	}
	else
	{
		if (chBankNO >= pCPly->GetCurBankNum())
			return false;
		chStart = chEnd = chBankNO;
	}

	//LG("enter_map", "��ʼ������������!\n");
	//char kitbag[defKITBAG_DATA_STRING_LEN];
	//char sql[1024 * 1024];
	StringPoolL stringPool;
	stringPool.ReserveBuf(StringPoolL::AllocateSpace1);
	stringPool.ReserveNum(StringPoolL::AllocateSpace2);
	//memset(look, 0, sizeof(look));
	stringPool[0] = "";

	for (char i = chStart; i <= chEnd; i++)
	{
		if (!pCPly->BankWillSave(i))
			continue;
		pCPly->SetBankSaveFlag(i, false);
		//g_kitbag[0] = 0;

		//memset(kitbag, 0, sizeof(g_kitbag));
		if (!KitbagData2StringEx(pCPly->GetBank(i), stringPool, 0))
		{
			//LG("enter_map", "��ɫ%u\t�������ݣ����У�ʱ����!\n", pCPly->GetBankDBID(i));
			LG("enter_map", "character%u\tsave data(bank) error!\n", pCPly->GetBankDBID(i));
			return false;
		}
		//LG("enter_map", "ת���������ݳɹ�\n");

		//char sql[SQL_MAXLEN];

		//_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set \
													content='%s' \
													where id=%d", \
													_get_table(), \
													(const char*)stringPool[0], \
													pCPly->GetBankDBID(i));

		//short sExec =  exec_sql_direct(sql);
		const DWORD param1 = pCPly->GetBankDBID(i);
		short		sExec  = stored_procedure("{CALL dbo.SaveBankDataEx(?,?)}", "dbo", "SaveBankDataEx", 2, (const char*)stringPool[0], &param1);
		//LG("enter_map", "ִ��SQL���ɹ�\n");
		if (!DBOK(sExec))
		{
			//LG("enter_map", "���%u\tִ��SQL���ʱ����!\n", pCPly->GetDBChaId());
			LG("enter_map", "player %u\tcarry out SQL sentence error!\n", pCPly->GetDBChaId());
			return false;
		}
		if (DBNODATA(sExec))
		{
			//LG("enter_map", "���ݿ�û�в�ѯ����������Դ%u!\n", pCPly->GetBankDBID(i));
			LG("enter_map", "Database couldn't find the bank resource%u!\n", pCPly->GetBankDBID(i));
			return false;
		}
	}
	//LG("enter_map", "���ȫ������[%d->%d]����.\n", chStart, chEnd);
	LG("enter_map", "finish the whole bank[%d->%d]save\n", chStart, chEnd);
	return true;
}

bool CTableMapMask::Init(void)
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   id, cha_id, content1, content2, content3, content4, content5 \
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(map_mask)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "map_mask");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "map_mask");
		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

bool CTableMapMask::GetColNameByMapName(const char *szMapName, char *szColName, long lColNameLen)
{
	if (!szMapName || !szColName)
		return false;
	char	*szColBase = "content";
	if ((long)strlen(szColBase) + 1 >= lColNameLen)
		return false;

	char	chIndex = 0;
	if (!strcmp(szMapName, "garner"))
		chIndex = 1;
	else if (!strcmp(szMapName, "magicsea"))
		chIndex = 2;
	else if (!strcmp(szMapName, "darkblue"))
		chIndex = 3;
	else if (!strcmp(szMapName, "winterland"))	// Add by lark.li 20080812 
		chIndex = 4;
	//else if (!strcmp(szMapName, "eastgoaf"))
	//	chIndex = 4;
	//else if (!strcmp(szMapName, "lonetower"))
	//	chIndex = 5;
	else
		return false;

	//sprintf(szColName, "%s%d", szColBase, chIndex);
	_snprintf_s(szColName,sizeof(szColName),_TRUNCATE, "%s%d", szColBase, chIndex);
	return true;
}

bool CTableMapMask::Create(long &lDBID, long lChaId)
{
	//sprintf( g_sql, "insert %s (cha_id) \
	//				values(%d) ",	_get_table(), 
	//				lChaId);
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "insert %s (cha_id) \
					values(%d) ",	_get_table(), 
					lChaId);

	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+") != 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}

		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	short sExec = exec_sql_direct( g_sql );
	if( DBOK(sExec) )
	{
		string buf[1]; 
		char param[] = "@@identity";
		char filter[80]; 
		//sprintf(filter, "1=1");
		_snprintf_s(filter,sizeof(filter),_TRUNCATE, "1=1");

		bool ret = _get_row(buf, 1, param, filter);
		lDBID = atol( buf[0].c_str() );
		return true;
	}

	return false;
}

bool CTableMapMask::ReadData(CPlayer *pCPly)
{
	if(!pCPly || !pCPly->IsValid())
	{
		//LG("enter_map", "����ͼ�������ݿ���󣬽�ɫ������.\n");
		LG("enter_map", "Load map hideID database error,character is inexistence.\n");
		return false;
	}
	if (pCPly->GetMapMaskDBID() == 0)
	{
		long	lDBID;
		if (!Create(lDBID, pCPly->GetDBChaId()))
			return false;
		pCPly->SetMapMaskDBID(lDBID);
	}

	char szMaskColName[30];
	if (!GetColNameByMapName(pCPly->GetMaskMapName(), szMaskColName, 30))
	{
		//LG("enter_map", "ѡ���ͼ�������ݴ���.\n");
		LG("enter_map", "choice map hideID data error.\n");
		return false;
	}

	int nIndex = 0;
	char param[80];
	//sprintf(param, "cha_id, %s", szMaskColName);
	_snprintf_s(param,sizeof(param),_TRUNCATE, "cha_id, %s", szMaskColName);

	char filter[80]; //sprintf(filter, "id=%d", pCPly->GetMapMaskDBID());
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "id=%d", pCPly->GetMapMaskDBID());
	int r = _get_row3(g_buf, g_cnCol, param, filter);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		DWORD	dwChaId = Str2Int(g_buf[nIndex++]);
		if (dwChaId != pCPly->GetDBChaId())
		{
			//LG("enter_map", "����ͼ�������ݿ���󣬽�ɫ��ƥ��.\n");
			LG("enter_map", "Load map hideID database error,character is not matching.\n");
			return false;
		}
		pCPly->SetMapMaskBase64(g_buf[nIndex++].c_str());
		//if (strcmp(g_buf[nIndex-1].c_str(), "0"))
		//	LG("���ͼ����", "��ͼ %s������ %u.\n", pCPly->GetMaskMapName(), strlen(g_buf[nIndex-1].c_str()));
	}
	else
	{
		//LG("enter_map", "����ͼ�������ݿ����_get_row()����ֵ��%d.%u\n", r);
		LG("enter_map", "Load map hideID database error,_get_row() return value:%d.%u\n", r);
		return false;
	}
	//LG("enter_map", "�����ͼ���ݳɹ�.\n");
	LG("enter_map", "Load big map data succeed.\n");
	return true;
}

bool CTableMapMask::SaveData(CPlayer *pCPly, BOOL bDirect)
{
	if(!pCPly || !pCPly->IsValid()) return false;

	char szMaskColName[30];
	if (!GetColNameByMapName(pCPly->GetMaskMapName(), szMaskColName, 30))
	{
		//LG("enter_map", "ѡ���ͼ�������ݴ���.\n");
		LG("enter_map", "choice map hideID data error.\n");
		return false;
	}

	//LG("enter_map", "��ʼ������ͼ����!\n");
	LG("enter_map", "start save big map data!\n");
	//sprintf(g_sql, "update %s set \
	//			   %s='%s' \
	//			   where id=%d", \
	//			   _get_table(), \
	//			   szMaskColName, \
	//			   pCPly->GetMapMaskBase64(), \
	//			   pCPly->GetMapMaskDBID());
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set \
				   %s='%s' \
				   where id=%d", \
				   _get_table(), \
				   szMaskColName, \
				   pCPly->GetMapMaskBase64(), \
				   pCPly->GetMapMaskDBID());

	//LG("enter_map", "��֯���ͼ���ݳɹ�!\n");
	LG("enter_map", "organize big map data succeed!\n");

	if(!bDirect) 
	{
		AddSaveQuest(g_sql);
	}
	else		 
	{
		return _ExecSQL(g_sql);
	}
	return true;
}

// ִ�е���������ͼ��SQL���
BOOL CTableMapMask::_ExecSQL(const char *pszSQL)
{
	LETimer t;
	t.Begin();
	if (strlen(pszSQL) >= SQL_MAXLEN)
	{
		//FILE *pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");`
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}

		if (pf)
		{
			fprintf(pf, "%s\n\n", pszSQL);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return FALSE;
	}
	
	short sExec =  exec_sql_direct(pszSQL);
	// LG("enter_map", "ִ�д��ͼSQL�ɹ�!\n");
	if (!DBOK(sExec))
	{
		//LG("enter_map", "���ִ��SQL���ʱ����sql = [%s]\n", pszSQL);
		LG("enter_map", "player carry out SQL sentence error sql = [%s]\n", pszSQL);
		return FALSE;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ���õ�ͼ����sql = [%s]\n", pszSQL);
		LG("enter_map", "Database couldn't find the map hideID sql = [%s]\n", pszSQL);
		return FALSE;
	}
	//LG("enter_map", "��ɴ��ͼ�������.\n");
	//LG("�������ݺ�ʱ", "������ͼ��ʱ[%d], ����[%d]\n", t.End(), _SaveMapMaskList.size() - 1);
	LG("save_data_waste_time", "save big map waste time,%d,queue[%d]\n", t.End(), _SaveMapMaskList.size() - 1);
	return TRUE;
}

// ���еĴ��ͼ��������һ����ִ��
void CTableMapMask::SaveAll()
{
	for(list<string>::iterator it = _SaveMapMaskList.begin(); it!=_SaveMapMaskList.end(); it++)
	{
		string &strSQL = (*it);
		_ExecSQL(strSQL.c_str());
	}
	//LG("enter_map", "һ����ִ�����д��ͼ����SQL, �ܼ�[%d]��!\n", _SaveMapMaskList.size());
	LG("enter_map", "one-off carry out every big map save SQL,totalize[%d] piece!\n", _SaveMapMaskList.size());
	_SaveMapMaskList.clear();
}

// ��ʱִ�еĴ��ͼ��������
void CTableMapMask::HandleSaveList()
{
	//	yyy	add!
	//RECORDCALL( __FUNCTION__ );
	DWORD dwTick = GetTickCount();
	static DWORD g_dwLastSaveTick = 0;

	if( (dwTick - g_dwLastSaveTick) > 2000) // ÿ�����Ӽ��һ�δ��ͼ��������
	{
		g_dwLastSaveTick = dwTick;

		int nSize = (int)(_SaveMapMaskList.size());
		if(nSize==0) return;
		
		string &strSQL = _SaveMapMaskList.front();

		_ExecSQL(strSQL.c_str());

		_SaveMapMaskList.pop_front();

		// LG("�������ݺ�ʱ", "���ͼ�������[%d]\n", nSize - 1);
	}
}

bool CTableAct::Init(void)
{
	//sprintf(g_sql, "select \
	//			act_id, act_name, gm, cha_ids, last_ip, disc_reason, last_leave \
	//			from %s \
	//			(nolock) where 1=2", \
	//			_get_table());
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   act_id, act_name, gm, cha_ids, last_ip, disc_reason, last_leave \
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(account)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "account");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE,RES_STRING(GM_GAMEDB_CPP_00001), "account");

		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

bool CTableAct::ReadAllData(CPlayer *pPlayer, DWORD act_id)
{T_B
	if(!pPlayer) return false;

	string buf[2]; 
    //char param[] = "gm, act_name";
    //char filter[80];// sprintf(filter, "act_id=%d", act_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "act_id=%d", act_id);
    //int r = _get_row(buf, 2, param, filter);
	//int r  = _get_rowSafely(buf, 2, param, GAME_CTABLEACT_READALLDATA, NULL, 1, &act_id);
	int r  = _get_row_stored_procedure(buf, 2, "{CALL dbo.AccReadAllData(?)}", "dbo", "AccReadAllData", NULL, 1, &act_id);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
    {
        pPlayer->SetGMLev(Str2Int(buf[0]));
		pPlayer->SetActName(buf[1].c_str());
		return true;
    }

    return false;
T_E}

bool CTableBoat::Init(void)
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   boat_id, boat_berth, boat_name, boat_boatid, boat_header, boat_body, boat_engine, boat_cannon, boat_equipment, \
				   boat_bag, boat_diecount, boat_isdead, boat_ownerid, boat_createtime, boat_isdeleted, cur_endure, mx_endure, cur_supply, mx_supply, skill_state, \
				   map, map_x, map_y, angle, degree, exp \
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(boat)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "boat");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "boat");

		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

BOOL CTableBoat::Create( DWORD& dwBoatID, const BOAT_DATA& Data )
{T_B
	string	strKitbag = "";
	KitbagStringConv(Data.sCapacity, strKitbag);
	char szTime[128] = "";
	SYSTEMTIME SysTime;
	GetLocalTime( &SysTime );
	//sprintf( szTime, "%d-%d-%d %d:%d:%d", SysTime.wYear, SysTime.wMonth, SysTime.wDay, SysTime.wHour, SysTime.wMinute, SysTime.wSecond );
	_snprintf_s(szTime,sizeof(szTime),_TRUNCATE, "%d-%d-%d %d:%d:%d", SysTime.wYear, SysTime.wMonth, SysTime.wDay, SysTime.wHour, SysTime.wMinute, SysTime.wSecond );

	//sprintf( g_sql, "insert %s (boat_name, boat_berth, boat_boatid, boat_header, boat_body, \
	//				boat_engine, boat_cannon, boat_equipment, boat_bag, boat_diecount, \
	//				boat_isdead, boat_ownerid, boat_createtime, boat_isdeleted) \
	//				values( '%s', %d, %d, %d, %d, %d, %d, %d, '%s', %d, %d, %d, '%s', %d ) ",	_get_table(), 
	//				Data.szName, Data.sBerth, Data.sBoat, Data.sHeader, Data.sBody, 
	//				Data.sEngine, Data.sCannon, Data.sEquipment, strKitbag.c_str(), 0, 0, Data.dwOwnerID, szTime, 0 );
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "insert %s (boat_name, boat_berth, boat_boatid, boat_header, boat_body, \
					boat_engine, boat_cannon, boat_equipment, boat_bag, boat_diecount, \
					boat_isdead, boat_ownerid, boat_createtime, boat_isdeleted) \
					values( '%s', %d, %d, %d, %d, %d, %d, %d, '%s', %d, %d, %d, '%s', %d ) ",	_get_table(), 
//					Data.szName, Data.sBerth, Data.sBoat, Data.sHeader, Data.sBody, 
	//				Data.sEngine, Data.sCannon, Data.sEquipment, strKitbag.c_str(), 0, 0, Data.dwOwnerID, szTime, 0 );
	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return FALSE;
	}
	*/
	//short sExec = exec_sql_direct( g_sql );
	const DWORD param_zero = 0;
	short sExec = stored_procedure("{CALL dbo.CreateBoat(?,?,?,?,?,?,?,?,?,?,?,?,?,?)}", "dbo", "CreateBoat", 14,
								   Data.szName, &Data.sBerth, &Data.sBoat, &Data.sHeader, &Data.sBody, &Data.sEngine, &Data.sCannon, &Data.sEquipment,
								   strKitbag.c_str(), &param_zero, &param_zero, &Data.dwOwnerID, szTime, &param_zero);
	
	if( DBOK(sExec) )
	{
		string buf[1]; 
		char param[] = "@@identity";
		char filter[80]; 
		//sprintf(filter, "1=1");
		_snprintf_s(filter,sizeof(filter),_TRUNCATE, "1=1");

		bool ret = _get_row(buf, 1, param, filter);
		dwBoatID = atol( buf[0].c_str() );
		return TRUE;
	}

	return FALSE;
T_E}

BOOL CTableBoat::GetBoat( CCharacter& Boat )
{T_B
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	BOAT_DATA Data;
	memset( &Data, 0, sizeof(BOAT_DATA) );
	int nIndex = 0;
	//char param[] = "boat_name, boat_boatid, boat_berth, boat_header, boat_body, \
					boat_engine, boat_cannon, boat_equipment, boat_diecount, boat_isdead, \
					boat_ownerid, boat_isdeleted, \
					cur_endure, mx_endure, cur_supply, mx_supply, skill_state, \
					map, map_x, map_y, angle, degree, exp";
	//char filter[80]; 
	//sprintf(filter, "boat_id=%d", dwBoatID );
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "boat_id=%d", dwBoatID );

	//int r = _get_row3( g_buf, g_cnCol, param, filter );
	int r  = _get_row_stored_procedure_whitespace(g_buf, g_cnCol, "{CALL dbo.GetBoat(?)}", "dbo", "GetBoat", NULL, 1, &dwBoatID);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		// ��ֻ��������		
		//strncpy( Data.szName, g_buf[nIndex++].c_str(), BOAT_MAXSIZE_BOATNAME - 1 );
		strncpy_s( Data.szName, sizeof(Data.szName), g_buf[nIndex++].c_str(), _TRUNCATE );
		Data.sBoat = (USHORT)Str2Int(g_buf[nIndex++]);
		Data.sBerth = (USHORT)Str2Int(g_buf[nIndex++]);
		Data.sHeader = (USHORT)Str2Int(g_buf[nIndex++]);
		Data.sBody = (USHORT)Str2Int(g_buf[nIndex++]);
		Data.sEngine = (USHORT)Str2Int(g_buf[nIndex++]);
		Data.sCannon = (USHORT)Str2Int(g_buf[nIndex++]);
		Data.sEquipment = (USHORT)Str2Int(g_buf[nIndex++]);
		USHORT sDieCount = (USHORT)Str2Int(g_buf[nIndex++]);
		BYTE byIsDead = (BYTE)Str2Int(g_buf[nIndex++]);
		DWORD dwOwnerID = (DWORD)Str2Int(g_buf[nIndex++]);
		BYTE byIsDeleted = (BYTE)Str2Int(g_buf[nIndex++]);
		//if( dwOwnerID != Boat.GetPlayer()->GetDBChaId() )
		//{
		//	LG( "boat_error", "��ֻ��%s��ID[0x%X]ӵ����ID[0x%X]�뵱ǰ��ɫ��%s��ID[0x%X]����.", 
		//		Data.szName, dwBoatID, dwOwnerID, 
		//		Boat.GetName(), Boat.GetPlayer()->GetDBChaId() );
		//	Boat.SystemNotice( "��ȡ���Ĵ�ֻ��%s��������������ʧ�ܣ���֪ͨά����Ա���!лл!" );
		//	return FALSE;
		//}

		if( byIsDeleted == 1 )
		{
			/*LG( "boat_error", "��ֻ��%s��ID[0x%X]ӵ����ID[0x%X]�Ѿ�ɾ�����뵱ǰ��ɫ��%s������֤�����ݲ�����.", 
				Data.szName, dwBoatID, dwOwnerID, 
				Boat.GetName() );*/
			LG( "boat_error", "boat(%s)ID[0x%X]owner ID[0x%X]had delete,is not fall short of the currently character (%s) captain prove data.", 
				Data.szName, dwBoatID, dwOwnerID, 
				Boat.GetName() );
			//Boat.SystemNotice( "��ȡ���Ĵ�ֻ��%s�����ݵ�ǰ״̬ʧ�ܣ���֪ͨά����Ա���!лл!", Boat.GetName());
			Boat.SystemNotice( RES_STRING(GM_GAMEDB_CPP_00020), Boat.GetName());
			return FALSE;
		}

		Boat.SetName( Data.szName );
		Boat.setAttr( ATTR_BOAT_BERTH, Data.sBerth, 1 );
		Boat.setAttr( ATTR_BOAT_SHIP, Data.sBoat, 1 );
		Boat.setAttr( ATTR_BOAT_HEADER, Data.sHeader, 1 );
		Boat.setAttr( ATTR_BOAT_BODY, Data.sBody, 1 );
		Boat.setAttr( ATTR_BOAT_ENGINE, Data.sEngine, 1 );
		Boat.setAttr( ATTR_BOAT_CANNON, Data.sCannon, 1 );
		Boat.setAttr( ATTR_BOAT_PART, Data.sEquipment, 1 );
		Boat.setAttr( ATTR_BOAT_DIECOUNT, sDieCount, 1 );
		Boat.setAttr( ATTR_BOAT_ISDEAD, byIsDead, 1 );
		
		// ����
		Boat.setAttr(ATTR_HP, Str2Int(g_buf[nIndex++]), 1);
		Boat.setAttr(ATTR_BMXHP, Str2Int(g_buf[nIndex++]), 1);
		Boat.setAttr(ATTR_SP, Str2Int(g_buf[nIndex++]), 1);
		Boat.setAttr(ATTR_BMXSP, Str2Int(g_buf[nIndex++]), 1);
		g_strChaState[1] = g_buf[nIndex++];
		// λ��
		Boat.SetBirthMap(g_buf[nIndex++].c_str());
		long lPosX = Str2Int(g_buf[nIndex++]);
		long lPosY = Str2Int(g_buf[nIndex++]);
		Boat.SetPos(lPosX, lPosY);
		Boat.SetAngle(Str2Int(g_buf[nIndex++]));
		// �ȼ�
		Boat.setAttr(ATTR_LV, Str2Int(g_buf[nIndex++]), 1);
		Boat.setAttr(ATTR_CEXP, Str2Int(g_buf[nIndex++]), 1);

	}
	else
		return FALSE;

	if (!ReadCabin(Boat))
		return FALSE;

    //  �����������½�ص���,��Ϊ�Ƿ�
    SItemGrid	*pGridCont = NULL;
    CItemRecord *pItem = NULL;
    Short sPos = 0;
    int i = 0;
    Short sUsedNum = Boat.GetKitbag()->GetUseGridNum();
	while(i < sUsedNum)
	{
		pGridCont = Boat.GetKitbag()->GetGridContByNum(i);
        if(pGridCont)
        {
            pItem = GetItemRecordInfo( pGridCont->sID );
            if(pItem)
            {
                if(enumITEM_PICKTO_KITBAG == pItem->chPickTo)
                {
                    sPos = Boat.GetKitbag()->GetPosIDByNum(i);
                    LG("boat_excp", "Character %s Remove %s.\n", Boat.GetName(), pItem->szName);
                    Boat.GetKitbag()->Pop(pGridCont, sPos);
                    sUsedNum = Boat.GetKitbag()->GetUseGridNum();
                    i = 0;
                    continue;
                    //return FALSE;
                }
            }
        }
        i++;
	}

	return TRUE;
T_E}


BOOL CTableBoat::SaveBoatTempData( DWORD dwBoatID, DWORD dwOwnerID, BYTE byIsDeleted )
{
	//sprintf( g_sql, "update %s set boat_ownerid=%d, boat_isdeleted=%d\
	//				where boat_id=%d", _get_table(), dwOwnerID, byIsDeleted, dwBoatID );
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set boat_ownerid=%d, boat_isdeleted=%d\
					where boat_id=%d", _get_table(), dwOwnerID, byIsDeleted, dwBoatID );
    /*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return FALSE;
	}
	short sExec = exec_sql_direct( g_sql );
	*/
	short sExec = stored_procedure("{CALL dbo.SaveBoatTempData3params(?,?,?)}", "dbo", "SaveBoatTempData3params", 3,&dwOwnerID, &byIsDeleted, &dwBoatID);

	if(!DBOK(sExec))
	{
		LG("stored procedure", "Stored procedure failed, SaveBoatTempData3params, params: %d,%d,%d", dwOwnerID, byIsDeleted, dwBoatID);
	}

	return DBOK(sExec) && !DBNODATA(sExec);
}

BOOL CTableBoat::SaveBoatDelTag( DWORD dwBoatID, BYTE byIsDeleted )
{
	//sprintf( g_sql, "update %s set boat_isdeleted=%d\
	//				where boat_id=%d", _get_table(), byIsDeleted, dwBoatID );
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set boat_isdeleted=%d\
					where boat_id=%d", _get_table(), byIsDeleted, dwBoatID );
	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return FALSE;
	}
	short sExec = exec_sql_direct( g_sql );
	*/
	short sExec = stored_procedure("{CALL dbo.SaveBoatDelTag(?,?)}", "dbo", "SaveBoatDelTag", 2, &byIsDeleted, &dwBoatID);

	if(!DBOK(sExec))
	{
		LG("stored procedure", "Stored procedure failed, SaveBoatDelTag, params: %d,%d",byIsDeleted, dwBoatID);
	}
	return DBOK(sExec) && !DBNODATA(sExec);
}

BOOL CTableBoat::SaveBoatTempData( CCharacter& Boat, BYTE byIsDeleted )
{
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	USHORT sDieCount = (USHORT)Boat.getAttr( ATTR_BOAT_DIECOUNT );
	BYTE byIsDead = (BYTE)Boat.getAttr( ATTR_BOAT_ISDEAD );
	DWORD dwOwnerID = Boat.GetPlayer()->GetDBChaId();

	//sprintf( g_sql, "update %s set boat_diecount=%d, boat_isdead=%d , boat_ownerid=%d, boat_isdeleted=%d\
	//				where boat_id=%d", _get_table(), sDieCount, byIsDead, dwOwnerID, byIsDeleted, dwBoatID );
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set boat_diecount=%d, boat_isdead=%d , boat_ownerid=%d, boat_isdeleted=%d\
					where boat_id=%d", _get_table(), sDieCount, byIsDead, dwOwnerID, byIsDeleted, dwBoatID );
	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return FALSE;
	}
	
	short sExec = exec_sql_direct( g_sql );
	*/
	short sExec = stored_procedure("{CALL dbo.SaveBoatTempData(?,?,?,?,?)}", "dbo", "SaveBoatTempData", 5,
								   &sDieCount, &byIsDead, &dwOwnerID, &byIsDeleted, &dwBoatID);

	if(!DBOK(sExec))
	{
		LG("stored procedure", "Stored procedure failed, SaveBoatTempData, params: %d,%d,%d,%d,%d", sDieCount, byIsDead, dwOwnerID, byIsDeleted, dwBoatID);
	}
	
	return DBOK(sExec) && !DBNODATA(sExec);
}

BOOL CTableBoat::SaveBoat( CCharacter& Boat, char chSaveType )
{T_B
	//LG("enter_map", "�� %s (%s)��ʼ���ñ�������.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	USHORT sBerthID = (USHORT)Boat.getAttr( ATTR_BOAT_BERTH );
	if (chSaveType == enumSAVE_TYPE_OFFLINE) // ����
		g_skillstate[0] = '\0';
	else // �л���ͼ
	{
		if (!SStateData2String(&Boat, g_skillstate, defSSTATE_DATE_STRING_LIN))
		{
			//LG("enter_map", "�� %s (%s)��֯״̬���ݲ��ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
			LG("enter_map", "boat %s (%s)organize state data failed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
			return false;
		}
	}
	//g_kitbag[0] = '\0';
	memset(g_kitbag, 0, sizeof(g_kitbag));
	KitbagData2String( Boat.GetKitbag(), g_kitbag, defKITBAG_DATA_STRING_LEN );
	//LG("enter_map", "����״̬���ݳɹ�.\n");

	bool bWithPos = false;
	if (Boat.GetPlyCtrlCha()->GetSubMap())
		bWithPos = Boat.GetPlyCtrlCha()->GetSubMap()->CanSavePos();

	/*
	if (bWithPos)
		//sprintf( g_sql, "update %s set boat_berth=%d, boat_ownerid=%d, cur_endure=%d, mx_endure=%d, cur_supply=%d, mx_supply=%d, skill_state='%s', \
		//				map='%s', map_x=%d, map_y=%d, angle=%d, degree=%d, exp=%d, boat_bag='%s' \
		//				where boat_id=%d",
		//	_get_table(),
		//	sBerthID,
		//	( Boat.GetPlayer() ) ? Boat.GetPlayer()->GetDBChaId() : 0,
		//	(long)Boat.getAttr(ATTR_HP),
		//	(long)Boat.getAttr(ATTR_BMXHP),
		//	(long)Boat.getAttr(ATTR_SP),
		//	(long)Boat.getAttr(ATTR_BMXSP),
		//	g_skillstate,
		//	Boat.GetBirthMap(),
		//	Boat.GetPos().x,
		//	Boat.GetPos().y,
		//	Boat.GetAngle(),
		//	(long)Boat.getAttr(ATTR_LV),
		//	(long)Boat.getAttr(ATTR_CEXP),
		//	g_kitbag,
		//	dwBoatID );
		_snprintf_s( g_sql,sizeof(g_sql),_TRUNCATE, "update %s set boat_berth=%d, boat_ownerid=%d, cur_endure=%d, mx_endure=%d, cur_supply=%d, mx_supply=%d, skill_state='%s', \
						map='%s', map_x=%d, map_y=%d, angle=%d, degree=%d, exp=%d, boat_bag='%s' \
						where boat_id=%d",
						_get_table(),
						sBerthID,
						( Boat.GetPlayer() ) ? Boat.GetPlayer()->GetDBChaId() : 0,
						(long)Boat.getAttr(ATTR_HP),
						(long)Boat.getAttr(ATTR_BMXHP),
						(long)Boat.getAttr(ATTR_SP),
						(long)Boat.getAttr(ATTR_BMXSP),
						g_skillstate,
						Boat.GetBirthMap(),
						Boat.GetPos().x,
						Boat.GetPos().y,
						Boat.GetAngle(),
						(long)Boat.getAttr(ATTR_LV),
						(long)Boat.getAttr(ATTR_CEXP),
						g_kitbag,
						dwBoatID );

	else
		//sprintf( g_sql, "update %s set boat_berth=%d, boat_ownerid=%d, cur_endure=%d, mx_endure=%d, cur_supply=%d, mx_supply=%d, skill_state='%s', \
		//				degree=%d, exp=%d, boat_bag='%s' \
		//				where boat_id=%d",
		//	_get_table(),
		//	sBerthID,
		//	( Boat.GetPlayer() ) ? Boat.GetPlayer()->GetDBChaId() : 0,
		//	(long)Boat.getAttr(ATTR_HP),
		//	(long)Boat.getAttr(ATTR_BMXHP),
		//	(long)Boat.getAttr(ATTR_SP),
		//	(long)Boat.getAttr(ATTR_BMXSP),
		//	g_skillstate,
		//	(long)Boat.getAttr(ATTR_LV),
		//	(long)Boat.getAttr(ATTR_CEXP),
		//	g_kitbag,
		//	dwBoatID );
		_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set boat_berth=%d, boat_ownerid=%d, cur_endure=%d, mx_endure=%d, cur_supply=%d, mx_supply=%d, skill_state='%s', \
						degree=%d, exp=%d, boat_bag='%s' \
						where boat_id=%d",
						_get_table(),
						sBerthID,
						( Boat.GetPlayer() ) ? Boat.GetPlayer()->GetDBChaId() : 0,
						(long)Boat.getAttr(ATTR_HP),
						(long)Boat.getAttr(ATTR_BMXHP),
						(long)Boat.getAttr(ATTR_SP),
						(long)Boat.getAttr(ATTR_BMXSP),
						g_skillstate,
						(long)Boat.getAttr(ATTR_LV),
						(long)Boat.getAttr(ATTR_CEXP),
						g_kitbag,
						dwBoatID );

	//LG("enter_map", "��֯SQL���ɹ�.\n");

	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return FALSE;
	}

	*/

    short		sExec	= -99;
	const long	param0	= (Boat.GetPlayer()) ? Boat.GetPlayer()->GetDBChaId() : 0;
	const long	param1	= (long)Boat.getAttr(ATTR_HP);
	const long	param2	= (long)Boat.getAttr(ATTR_BMXHP);
	const long	param3	= (long)Boat.getAttr(ATTR_SP);
	const long	param4	= (long)Boat.getAttr(ATTR_BMXSP);
	const char* param5	= g_skillstate;
	const char* param6	= Boat.GetBirthMap();
	const long	param7	= Boat.GetPos().x;
	const long	param8	= Boat.GetPos().y;
	const long	param9	= Boat.GetAngle();
	const short	param10 = (short)Boat.getAttr(ATTR_LV);
	const long	param11 = (long)Boat.getAttr(ATTR_CEXP);
	const char* param12 = g_kitbag;


	// Same as SaveBoatEx
	if(bWithPos)
	{
		sExec = stored_procedure("{CALL dbo.SaveBoatExWithPos(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}", "dbo", "SaveBoatExWithPos", 15,
								 &sBerthID, &param0, &param1, &param2, &param3, &param4, param5, param6, &param7, &param8, &param9,
								 &param10, &param11, param12, &dwBoatID);
	} else
	{
		sExec = stored_procedure("{CALL dbo.SaveBoatEx(?,?,?,?,?,?,?,?,?,?,?)}", "dbo", "SaveBoatEx", 11,
								 &sBerthID, &param0, &param1, &param2, &param3, &param4, param5,
								 &param10, &param11, param12, &dwBoatID);
	}

	//sExec = exec_sql_direct( g_sql );
	//LG("enter_map", "ִ��SQL���ɹ�.\n");

	if (!DBOK(sExec))
	{
		//LG("enter_map", "�� %s (%s)����������ݲ��ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		LG("enter_map", "boat %s (%s)save basic data failed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", dwBoatID);
		LG("enter_map", "Database couldn't find the character%u!\n",dwBoatID);
		return false;
	}
	//LG("enter_map", "������������ݳɹ�.\n");

	//if (!SaveCabin(Boat, chSaveType))
	//	return false;

	//LG("enter_map", "�� %s (%s)ȫ�����ݱ���ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
	LG("enter_map", "boat %s (%s) the whole data save succeed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());

	return true;
T_E}

BOOL CTableBoat::SaveBoatEx( CCharacter& Boat, char chSaveType )
{T_B
	//LG("enter_map", "�� %s (%s)��ʼ���ñ�������.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	USHORT sBerthID = (USHORT)Boat.getAttr( ATTR_BOAT_BERTH );
	//char skillstate[defSSTATE_DATE_STRING_LIN];
	//memset(skillstate, 0, sizeof(skillstate));

	StringPoolL stringPool;
	stringPool.ReserveBuf(StringPoolL::AllocateSpace1);
	stringPool.ReserveNum(StringPoolL::AllocateSpace2);
	//memset(look, 0, sizeof(look));
	stringPool[0] = "";
	if (chSaveType != enumSAVE_TYPE_OFFLINE) // ����
	{
		if (!SStateData2StringEx(&Boat, stringPool, 0))
		{
			//LG("enter_map", "�� %s (%s)��֯״̬���ݲ��ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
			LG("enter_map", "boat %s (%s)organize state data failed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
			return false;
		}
	}
	//g_kitbag[0] = '\0';
	//char kitbag[defKITBAG_DATA_STRING_LEN];

	//memset(kitbag, 0, sizeof(g_kitbag));
	stringPool[1] = "";

	KitbagData2StringEx( Boat.GetKitbag(), stringPool, 1);
	//LG("enter_map", "����״̬���ݳɹ�.\n");

	//char sql[SQL_MAXLEN];


	bool bWithPos = false;
	if (Boat.GetPlyCtrlCha()->GetSubMap())
		bWithPos = Boat.GetPlyCtrlCha()->GetSubMap()->CanSavePos();
	/*
	if (bWithPos)
		_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set boat_berth=%d, boat_ownerid=%d, cur_endure=%d, mx_endure=%d, cur_supply=%d, mx_supply=%d, skill_state='%s', \
						map='%s', map_x=%d, map_y=%d, angle=%d, degree=%d, exp=%d, boat_bag='%s' \
						where boat_id=%d",
						_get_table(),
						sBerthID,
						( Boat.GetPlayer() ) ? Boat.GetPlayer()->GetDBChaId() : 0,
						(long)Boat.getAttr(ATTR_HP),
						(long)Boat.getAttr(ATTR_BMXHP),
						(long)Boat.getAttr(ATTR_SP),
						(long)Boat.getAttr(ATTR_BMXSP),
						(const char*)stringPool[0],
						Boat.GetBirthMap(),
						Boat.GetPos().x,
						Boat.GetPos().y,
						Boat.GetAngle(),
						(long)Boat.getAttr(ATTR_LV),
						(long)Boat.getAttr(ATTR_CEXP),
						(const char*)stringPool[1],
						dwBoatID );

	else
		_snprintf_s(sql, sizeof(sql), _TRUNCATE, "update %s set boat_berth=%d, boat_ownerid=%d, cur_endure=%d, mx_endure=%d, cur_supply=%d, mx_supply=%d, skill_state='%s', \
						degree=%d, exp=%d, boat_bag='%s' \
						where boat_id=%d",
						_get_table(),
						sBerthID,
						( Boat.GetPlayer() ) ? Boat.GetPlayer()->GetDBChaId() : 0,
						(long)Boat.getAttr(ATTR_HP),
						(long)Boat.getAttr(ATTR_BMXHP),
						(long)Boat.getAttr(ATTR_SP),
						(long)Boat.getAttr(ATTR_BMXSP),
						(const char*)stringPool[0],
						(long)Boat.getAttr(ATTR_LV),
						(long)Boat.getAttr(ATTR_CEXP),
						(const char*)stringPool[1],
						dwBoatID );
				*/
	//LG("enter_map", "��֯SQL���ɹ�.\n");
	short sExec = -99;
	const long	param0 = (Boat.GetPlayer()) ? Boat.GetPlayer()->GetDBChaId() : 0;
	const long param1 = (long)Boat.getAttr(ATTR_HP);
	const long param2 = (long)Boat.getAttr(ATTR_BMXHP);
	const long param3 = (long)Boat.getAttr(ATTR_SP);
	const long param4 = (long)Boat.getAttr(ATTR_BMXSP);
	const char* param5 = (const char*)stringPool[0];
	const char* param6 = Boat.GetBirthMap();
	const long param7	 = Boat.GetPos().x;
	const long param8	 = Boat.GetPos().y;
	const long param9	 = Boat.GetAngle();
	const short param10 = (short)Boat.getAttr(ATTR_LV);
	const long param11 = (long)Boat.getAttr(ATTR_CEXP);
	const char*	param12	  = (const char*)stringPool[1];


	if(bWithPos)
	{
		sExec = stored_procedure("{CALL dbo.SaveBoatExWithPos(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}", "dbo", "SaveBoatExWithPos", 15,
								 &sBerthID, &param0, &param1, &param2, &param3, &param4, param5, param6, &param7, &param8, &param9,
								 &param10, &param11, param12, &dwBoatID);
	} else
	{
		sExec = stored_procedure("{CALL dbo.SaveBoatEx(?,?,?,?,?,?,?,?,?,?,?)}", "dbo", "SaveBoatEx", 11,
								 &sBerthID, &param0, &param1, &param2, &param3, &param4, param5,
								 &param10, &param11, param12, &dwBoatID);

	}
	//short sExec = exec_sql_direct( sql );
	//LG("enter_map", "ִ��SQL���ɹ�.\n");

	if (!DBOK(sExec))
	{
		//LG("enter_map", "�� %s (%s)����������ݲ��ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		LG("enter_map", "boat %s (%s)save basic data failed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", dwBoatID);
		LG("enter_map", "Database couldn't find the character%u!\n",dwBoatID);
		return false;
	}
	//LG("enter_map", "������������ݳɹ�.\n");

	//if (!SaveCabin(Boat, chSaveType))
	//	return false;

	//LG("enter_map", "�� %s (%s)ȫ�����ݱ���ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
	LG("enter_map", "boat %s (%s) the whole data save succeed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());

	return true;
T_E}

bool CTableBoat::SaveAllData(CPlayer *pPlayer, char chSaveType)
{
	if (!pPlayer)
		return false;
	CCharacter	*pCBoat;
	for (BYTE i = 0; i < pPlayer->GetNumBoat(); i++)
	{
		pCBoat = pPlayer->GetBoat(i);
		if (!pCBoat)
			continue;
		if (!SaveBoat(*pCBoat, chSaveType))
			return false;
	}
	//LG("enter_map", "�������д����ݳɹ�.\n");
	LG("enter_map", "save the whole boat data succeed\n");

	return true;
}

bool CTableBoat::SaveAllDataEx(CPlayer *pPlayer, char chSaveType)
{
	if (!pPlayer)
		return false;
	CCharacter	*pCBoat;
	for (BYTE i = 0; i < pPlayer->GetNumBoat(); i++)
	{
		pCBoat = pPlayer->GetBoat(i);
		if (!pCBoat)
			continue;
		if (!SaveBoatEx(*pCBoat, chSaveType))
			return false;
	}
	//LG("enter_map", "�������д����ݳɹ�.\n");
	LG("enter_map", "save the whole boat data succeed\n");

	return true;
}

bool CTableBoat::SaveCabin(CCharacter& Boat, char chSaveType)
{
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	int kb_capacity = Boat.GetKitbag()->GetCapacity();
	//g_kitbag[0] = '\0';
	memset(g_kitbag, 0, sizeof(g_kitbag));
	KitbagData2String( Boat.GetKitbag(), g_kitbag, defKITBAG_DATA_STRING_LEN );

	//sprintf( g_sql, "update %s set boat_bag='%s' where boat_id=%d", _get_table(),
	//	g_kitbag,
	//	dwBoatID );
	//_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "update %s set boat_bag='%s' where boat_id=%d", _get_table(),
	//	g_kitbag,
	//	dwBoatID );


	/*
	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	*/

	//short sExec = exec_sql_direct( g_sql );
	short sExec = stored_procedure("{CALL dbo.SaveCabin(?,?)}", "dbo", "SaveCabin", 2, g_kitbag, &dwBoatID);
	if (!DBOK(sExec))
	{
		//LG("enter_map", "�� %s (%s)�Ĵ������ݱ��治�ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		LG("enter_map", "boat %s (%s) cabin data save failed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		return false;
	}
	if (DBNODATA(sExec))
	{
		//LG("enter_map", "���ݿ�û�в�ѯ�������%u!\n", dwBoatID);
		LG("enter_map", "Database couldn't find the character%u!\n", dwBoatID);
		return false;
	}
	//LG("enter_map", "�� %s (%s)�Ĵ������ݱ���ɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
	LG("enter_map", "boat %s (%s)cabin data save succeed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());

	return true;
}

bool CTableBoat::SaveAllCabin(CPlayer *pPlayer, char chSaveType)
{
	CCharacter	*pCBoat;
	for (BYTE i = 0; i < pPlayer->GetNumBoat(); i++)
	{
		pCBoat = pPlayer->GetBoat(i);
		if (!pCBoat)
			continue;
		if (!SaveCabin(*pCBoat, chSaveType))
			return false;
	}

	return true;
}

bool CTableBoat::ReadCabin(CCharacter& Boat) // ��ȡ����
{
	DWORD dwBoatID = (DWORD)Boat.getAttr( ATTR_BOAT_DBID );
	int nIndex = 0;
	//char param[] = "boat_bag";
	//char filter[80]; 
	//sprintf(filter, "boat_id=%d", dwBoatID );
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE,"boat_id=%d", dwBoatID );

	//int r = _get_row3( g_buf, g_cnCol, param, filter );
	int r  = _get_row_stored_procedure_whitespace(g_buf, g_cnCol, "{CALL dbo.ReadCabin(?)}", "dbo", "ReadCabin", NULL, 1, &dwBoatID);
	int	r1 = get_affected_rows();
	if (DBOK(r) && r1 > 0)
	{
		//LG("enter_map", "�� %u (%s, %s)�Ĵ������� %s.\n", dwBoatID, Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName(), g_buf[nIndex].c_str());
		if (!Boat.String2KitbagData(g_buf[nIndex++]))
		{
			//LG("enter_map", "��������У��ʹ���.\n");
			LG("enter_map", "cabin data check sum error.\n");
			//LG("У��ʹ���", "����%s���������ݣ�boat_id %u��У��ʹ���.\n", Boat.GetLogName(), Boat.getAttr( ATTR_BOAT_DBID ));
			LG("check sum error", "boat (%s) cabin data (boat_id %u)check sum error.\n", Boat.GetLogName(), Boat.getAttr( ATTR_BOAT_DBID ));
			return false;
		}

		//LG("enter_map", "�� %s (%s)�Ĵ����������óɹ�.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		LG("enter_map", "boat %s (%s) cabin data set succeed.\n", Boat.GetLogName(), Boat.GetPlyMainCha()->GetLogName());
		return true;
	}

	return false;
}

BOOL CGameDB::Init()
{T_B
	m_bInitOK = FALSE;


	printf("Connecting to database [%s : GameDB]\n", g_Config.m_szDBIP);
	

	string err_info;
	//if(!pswd.c_str() || pswd.length() == 0)
	//{
	//	LG("gamedb", "Database  Password Error!");
	//	return FALSE;
	//}
	bool r = _connect.connect(g_Config.m_szDBIP, "GameDB", g_Config.m_szDBUsr, g_Config.m_szDBPass, err_info);
    if(!r)
    {
		char msg[256];
		_snprintf_s(msg, _countof(msg), _TRUNCATE, "Database [GameDB] Connect Failed!, ERROR REPORT[%s]", err_info.c_str() );
		MessageBox(NULL, msg, "error" , MB_ICONERROR | MB_OK);
        return FALSE;
    }

	printf("Database Connected!\n");

    _tab_cha   = new CTableCha(&_connect);
	_tab_master = new CTableMaster(&_connect);
	_tab_res   = new CTableResource(&_connect);
	_tab_per_info = new CTablePersoninfo(&_connect);//Add by sunny.sun 20080822
#ifdef SHUI_JING
	_tab_csl_trade = new CTableCrystalTrade(&_connect);
#endif
	_tab_mmask = new CTableMapMask(&_connect);
	_tab_act   = new CTableAct(&_connect);
	_tab_gld   = new CTableGuild(&_connect);
	_tab_boat  = new CTableBoat(&_connect);
	_tab_log   = new CTableLog(&_connect);
	_tab_item	=	new	CTableItem(&_connect);

	// Modify by lark.li 20080521
	//if (!_tab_cha || !_tab_act || !_tab_gld || !_tab_boat || !_tab_master)
#ifdef SHUI_JING
	if (!_tab_cha || !_tab_act || !_tab_gld || !_tab_boat || !_tab_master 
	|| !_tab_log || !_tab_item ||!_tab_per_info|| !_tab_csl_trade )
#else
	if (!_tab_cha || !_tab_act || !_tab_gld || !_tab_boat || !_tab_master 
		|| !_tab_log || !_tab_item ||!_tab_per_info )
#endif
		return FALSE;

	//if (!_tab_cha->Init() || !_tab_act->Init() || !_tab_gld->Init() || !_tab_boat->Init() || !_tab_res->Init() || !_tab_mmask->Init() || !_tab_master->Init())
#ifdef SHUI_JING
	if (!_tab_cha->Init() || !_tab_act->Init() || !_tab_gld->Init() || !_tab_boat->Init() || !_tab_res->Init()
		|| !_tab_mmask->Init() || !_tab_master->Init() || )
#else
	if (!_tab_cha->Init() || !_tab_act->Init() || !_tab_gld->Init() || !_tab_boat->Init() || !_tab_res->Init() 
|| !_tab_mmask->Init() || !_tab_master->Init() || !_tab_per_info->Init())
#endif
		return FALSE;

	if(!_tab_log)
	{
		//LG("init", "gamelog���ݱ���ʼ��ʧ��\n");
		LG("init", "gamelog data list init failed\n");
	}
	
	m_bInitOK = TRUE;

	return TRUE;
T_E}

bool CGameDB::ReadPlayer(CPlayer *pPlayer, DWORD cha_id)
{
	m_Lock.Lock();
#ifdef UPDATE_MUL_THREAD
	pPlayer->DBLock();
#endif
	try
	{
		if (!_tab_cha->ReadAllData(pPlayer, cha_id))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		long	lKbDBID = pPlayer->GetMainCha()->GetKitbagRecDBID();
		long    lkbTmpDBID = pPlayer->GetMainCha()->GetKitbagTmpRecDBID();//��ʱ����ID
		long	lMMaskDBID = pPlayer->GetMapMaskDBID();
		long	lBankNum = pPlayer->GetCurBankNum();
		if (!_tab_res->ReadKitbagData(pPlayer->GetMainCha()))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		if (lKbDBID == 0)
		{
			if (!SavePlayerKBagDBID(pPlayer))
			{
#ifdef UPDATE_MUL_THREAD
				pPlayer->DBUnLock();
#endif
				m_Lock.Unlock();
				return false;
			}
		}

		if(!_tab_res->ReadKitbagTmpData(pPlayer->GetMainCha()))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		if(lkbTmpDBID == 0)
		{
			if(!SavePlayerKBagTmpDBID(pPlayer))
			{
#ifdef UPDATE_MUL_THREAD
				pPlayer->DBUnLock();
#endif
				m_Lock.Unlock();
				return false;
			}
		}

		pPlayer->GetMainCha()->LogAssets(enumLASSETS_INIT);

		if (!_tab_res->ReadBankData(pPlayer))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		if (lBankNum == 0)
		{
			if (!_tab_cha->SaveBankDBID(pPlayer))
			{
#ifdef UPDATE_MUL_THREAD
				pPlayer->DBUnLock();
#endif
				m_Lock.Unlock();
				return false;
			}
		}

		if (!_tab_act->ReadAllData(pPlayer, pPlayer->GetDBActId()))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		// �л���Ϣ
		if (pPlayer->m_lGuildID > 0)
		{
			_tab_gld->GetGuildInfo(pPlayer->GetMainCha(), pPlayer->m_lGuildID);
			//long	lType = _tab_gld->GetTypeByID(pPlayer->GetMainCha()->getAttr(ATTR_GUILD));
			//if (lType >= 0)
			//	pPlayer->GetMainCha()->setAttr(ATTR_GUILD_TYPE, lType, 1);
		}
		//LG("enter_map", "�����ȫ�����ݳɹ�.\n");
		LG("enter_map", "Load the character whole data succeed.\n");

		// ��¼���ļ�
		CKitbag		*pCKb;
		CCharacter	*pCMainC = pPlayer->GetMainCha();
		short	sItemNum = pCMainC->GetKitbag()->GetUseGridNum();
		//g_kitbag[0] = '\0';
		//memset(g_kitbag, 0, sizeof(g_kitbag));
		//sprintf(g_kitbag, "��Ǯ��%u ���ߣ�%d@", pCMainC->getAttr(ATTR_GD), sItemNum);
		//sprintf(g_kitbag, RES_STRING(GM_GAMEDB_CPP_00021), pCMainC->getAttr(ATTR_GD), sItemNum);
		//_snprintf_s(g_kitbag,sizeof(g_kitbag),_TRUNCATE,RES_STRING(GM_GAMEDB_CPP_00021), pCMainC->getAttr(ATTR_GD), sItemNum);
		CFormatParameter param(2);
		param.setInt64( 0, pCMainC->getAttr( ATTR_GD ));
		param.setDouble( 1, sItemNum );
		RES_FORMAT_STRING( GM_GAMEDB_CPP_00021, param, g_kitbag );

		SItemGrid *pGridCont;
		CItemRecord *pCItem;
		pCKb = pCMainC->GetKitbag();
		for (short i = 0; i < sItemNum; i++)
		{
			pGridCont = pCKb->GetGridContByNum(i);
			if (!pGridCont)
				continue;
			pCItem = GetItemRecordInfo(pGridCont->sID);
			if (!pCItem)
				continue;
			//sprintf(g_kitbag + strlen(g_kitbag), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
			_snprintf_s(g_kitbag + strlen(g_kitbag),sizeof(g_kitbag) - strlen(g_kitbag),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

		}
		TL(CHA_ENTER, pCMainC->GetName(), "", g_kitbag);

		short	sItemTmpNum = pCMainC->m_pCKitbagTmp->GetUseGridNum();
		//g_kitbagTmp[0] = '\0';
		//sprintf(g_kitbagTmp, "��ʱ������%d@", sItemTmpNum);
		//sprintf(g_kitbagTmp, RES_STRING(GM_GAMEDB_CPP_00022), sItemTmpNum);
		_snprintf_s(g_kitbagTmp,sizeof(g_kitbagTmp),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00022), sItemTmpNum);

		pCKb = pCMainC->m_pCKitbagTmp;
		for (short i = 0; i < sItemTmpNum; i++)
		{
			pGridCont = pCKb->GetGridContByNum(i);
			if (!pGridCont)
				continue;
			pCItem = GetItemRecordInfo(pGridCont->sID);
			if (!pCItem)
				continue;
			//sprintf(g_kitbagTmp + strlen(g_kitbagTmp), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
			_snprintf_s(g_kitbagTmp + strlen(g_kitbagTmp),sizeof(g_kitbagTmp) - strlen(g_kitbagTmp),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

		}
		TL(CHA_ENTER, pCMainC->GetName(), "", g_kitbagTmp);

		char	chStart = 0, chEnd = pPlayer->GetCurBankNum() - 1;
		for (char i = chStart; i <= chEnd; i++)
		{
			//sprintf(g_kitbag, "����ID(%d):", i + 1 );
			//sprintf(g_kitbag, RES_STRING(GM_GAMEDB_CPP_00023), i + 1 );
			_snprintf_s(g_kitbag,sizeof(g_kitbag),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00023), i + 1 );

			pCKb = pPlayer->GetBank(i);
			sItemNum = pCKb->GetUseGridNum();
			//sprintf(g_kitbag + strlen(g_kitbag), "[%d]%d@;", i + 1, sItemNum);
			_snprintf_s(g_kitbag + strlen(g_kitbag),sizeof(g_kitbag) -  strlen(g_kitbag),_TRUNCATE, "[%d]%d@;", i + 1, sItemNum);

			for (short i = 0; i < sItemNum; i++)
			{
				pGridCont = pCKb->GetGridContByNum(i);
				if (!pGridCont)
					continue;
				pCItem = GetItemRecordInfo(pGridCont->sID);
				if (!pCItem)
					continue;
				//sprintf(g_kitbag + strlen(g_kitbag), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
				_snprintf_s(g_kitbag + strlen(g_kitbag),sizeof(g_kitbag) - strlen(g_kitbag),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

			}
			TL(CHA_ENTER, pCMainC->GetName(), "", g_kitbag);
		}

		//g_equip[0] = '\0';
		//sprintf(g_equip, "װ����%d@", enumEQUIP_NUM);
		//sprintf(g_equip, RES_STRING(GM_GAMEDB_CPP_00024), enumEQUIP_NUM);
		_snprintf_s(g_equip,sizeof(g_equip),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00024), enumEQUIP_NUM);

		for (short i = 0; i < enumEQUIP_NUM; i++)
		{
			pGridCont = &pCMainC->m_SChaPart.SLink[i];
			if (!pGridCont)
				continue;
			pCItem = GetItemRecordInfo(pGridCont->sID);
			if (!pCItem)
				continue;
			//sprintf(g_equip + strlen(g_equip), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
			_snprintf_s(g_equip + strlen(g_equip),sizeof(g_equip) -  strlen(g_equip),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

		}
		TL(CHA_EQUIP, pCMainC->GetName(), "", g_equip);

	}
	catch(...)
	{

	}

#ifdef UPDATE_MUL_THREAD
	pPlayer->DBUnLock();
#endif
	m_Lock.Unlock();
	//
	return true;
}

bool CGameDB::ReadPlayerEx(CPlayer *pPlayer, DWORD cha_id)
{
	m_LockEx.Lock();
#ifdef UPDATE_MUL_THREAD
	pPlayer->DBLock();
#endif
	try
	{
		if (!_tab_cha->ReadAllDataEx(pPlayer, cha_id))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		long	lKbDBID = pPlayer->GetMainCha()->GetKitbagRecDBID();
		long    lkbTmpDBID = pPlayer->GetMainCha()->GetKitbagTmpRecDBID();//��ʱ����ID
		long	lMMaskDBID = pPlayer->GetMapMaskDBID();
		long	lBankNum = pPlayer->GetCurBankNum();
		if (!_tab_res->ReadKitbagData(pPlayer->GetMainCha()))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		if (lKbDBID == 0)
		{
			if (!SavePlayerKBagDBIDEx(pPlayer))
			{
#ifdef UPDATE_MUL_THREAD
				pPlayer->DBUnLock();
#endif
				m_LockEx.Unlock();
				return false;
			}
		}

		if(!_tab_res->ReadKitbagTmpDataEx(pPlayer->GetMainCha()))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		if(lkbTmpDBID == 0)
		{
			if(!SavePlayerKBagTmpDBIDEx(pPlayer))
			{
#ifdef UPDATE_MUL_THREAD
				pPlayer->DBUnLock();
#endif
				m_LockEx.Unlock();
				return false;
			}
		}

		pPlayer->GetMainCha()->LogAssets(enumLASSETS_INIT);

		if (!_tab_res->ReadBankDataEx(pPlayer))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		if (lBankNum == 0)
		{
			if (!_tab_cha->SaveBankDBIDEx(pPlayer))
			{
#ifdef UPDATE_MUL_THREAD
				pPlayer->DBUnLock();
#endif
				m_LockEx.Unlock();
				return false;
			}
		}

		if (!_tab_act->ReadAllData(pPlayer, pPlayer->GetDBActId()))
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		// �л���Ϣ
		if (pPlayer->m_lGuildID > 0)
		{
			_tab_gld->GetGuildInfo(pPlayer->GetMainCha(), pPlayer->m_lGuildID);
			//long	lType = _tab_gld->GetTypeByID(pPlayer->GetMainCha()->getAttr(ATTR_GUILD));
			//if (lType >= 0)
			//	pPlayer->GetMainCha()->setAttr(ATTR_GUILD_TYPE, lType, 1);
		}
		//LG("enter_map", "�����ȫ�����ݳɹ�.\n");
		LG("enter_map", "Load the character whole data succeed.\n");

		// ��¼���ļ�
		CKitbag		*pCKb;
		CCharacter	*pCMainC = pPlayer->GetMainCha();
		short	sItemNum = pCMainC->GetKitbag()->GetUseGridNum();
		//g_kitbag[0] = '\0';
		//memset(g_kitbag, 0, sizeof(g_kitbag));
		//sprintf(g_kitbag, "��Ǯ��%u ���ߣ�%d@", pCMainC->getAttr(ATTR_GD), sItemNum);
		//sprintf(g_kitbag, RES_STRING(GM_GAMEDB_CPP_00021), pCMainC->getAttr(ATTR_GD), sItemNum);
		//_snprintf_s(g_kitbag,sizeof(g_kitbag),_TRUNCATE,RES_STRING(GM_GAMEDB_CPP_00021), pCMainC->getAttr(ATTR_GD), sItemNum);
		CFormatParameter param(2);
		param.setInt64( 0, pCMainC->getAttr( ATTR_GD ));
		param.setDouble( 1, sItemNum );
		RES_FORMAT_STRING( GM_GAMEDB_CPP_00021, param, g_kitbag );

		SItemGrid *pGridCont;
		CItemRecord *pCItem;
		pCKb = pCMainC->GetKitbag();

		char kitbag[8192];

		for (short i = 0; i < sItemNum; i++)
		{
			pGridCont = pCKb->GetGridContByNum(i);
			if (!pGridCont)
				continue;
			pCItem = GetItemRecordInfo(pGridCont->sID);
			if (!pCItem)
				continue;
			//sprintf(g_kitbag + strlen(g_kitbag), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
			_snprintf_s(kitbag + strlen(kitbag),sizeof(kitbag) - strlen(kitbag),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

		}
		TL(CHA_ENTER, pCMainC->GetName(), "", kitbag);

		short	sItemTmpNum = pCMainC->m_pCKitbagTmp->GetUseGridNum();
		char kitbagTmp[8192];

		//g_kitbagTmp[0] = '\0';
		//sprintf(g_kitbagTmp, "��ʱ������%d@", sItemTmpNum);
		//sprintf(g_kitbagTmp, RES_STRING(GM_GAMEDB_CPP_00022), sItemTmpNum);
		_snprintf_s(kitbagTmp,sizeof(kitbagTmp),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00022), sItemTmpNum);

		pCKb = pCMainC->m_pCKitbagTmp;
		for (short i = 0; i < sItemTmpNum; i++)
		{
			pGridCont = pCKb->GetGridContByNum(i);
			if (!pGridCont)
				continue;
			pCItem = GetItemRecordInfo(pGridCont->sID);
			if (!pCItem)
				continue;
			//sprintf(g_kitbagTmp + strlen(g_kitbagTmp), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
			_snprintf_s(kitbagTmp + strlen(kitbagTmp),sizeof(kitbagTmp) - strlen(kitbagTmp),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

		}
		TL(CHA_ENTER, pCMainC->GetName(), "", kitbagTmp);

		char	chStart = 0, chEnd = pPlayer->GetCurBankNum() - 1;
		for (char i = chStart; i <= chEnd; i++)
		{
			//sprintf(g_kitbag, "����ID(%d):", i + 1 );
			//sprintf(g_kitbag, RES_STRING(GM_GAMEDB_CPP_00023), i + 1 );
			_snprintf_s(kitbag,sizeof(kitbag),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00023), i + 1 );

			pCKb = pPlayer->GetBank(i);
			sItemNum = pCKb->GetUseGridNum();
			//sprintf(g_kitbag + strlen(g_kitbag), "[%d]%d@;", i + 1, sItemNum);
			_snprintf_s(kitbag + strlen(kitbag),sizeof(kitbag) -  strlen(kitbag),_TRUNCATE, "[%d]%d@;", i + 1, sItemNum);

			for (short i = 0; i < sItemNum; i++)
			{
				pGridCont = pCKb->GetGridContByNum(i);
				if (!pGridCont)
					continue;
				pCItem = GetItemRecordInfo(pGridCont->sID);
				if (!pCItem)
					continue;
				//sprintf(g_kitbag + strlen(g_kitbag), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
				_snprintf_s(kitbag + strlen(kitbag),sizeof(kitbag) - strlen(kitbag),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

			}
			TL(CHA_ENTER, pCMainC->GetName(), "", kitbag);
		}

		//g_equip[0] = '\0';
		//sprintf(g_equip, "װ����%d@", enumEQUIP_NUM);
		//sprintf(g_equip, RES_STRING(GM_GAMEDB_CPP_00024), enumEQUIP_NUM);
		char equip[8192];

		_snprintf_s(equip,sizeof(equip),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00024), enumEQUIP_NUM);

		for (short i = 0; i < enumEQUIP_NUM; i++)
		{
			pGridCont = &pCMainC->m_SChaPart.SLink[i];
			if (!pGridCont)
				continue;
			pCItem = GetItemRecordInfo(pGridCont->sID);
			if (!pCItem)
				continue;
			//sprintf(g_equip + strlen(g_equip), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
			_snprintf_s(equip + strlen(equip),sizeof(equip) -  strlen(equip),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

		}
		TL(CHA_EQUIP, pCMainC->GetName(), "", equip);

	}
	catch(...)
	{

	}

#ifdef UPDATE_MUL_THREAD
	pPlayer->DBUnLock();
#endif
	m_LockEx.Unlock();
	//
	return true;
}

bool CGameDB::SavePlayer(CPlayer *pPlayer, char chSaveType, cChar *szTarMapName , Long lTarX, Long lTarY)
{
	//return true;

	m_Lock.Lock();
#ifdef UPDATE_MUL_THREAD
	pPlayer->DBLock();
#endif
	try
	{
		if (!pPlayer || !pPlayer->GetMainCha())
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		if (pPlayer->GetMainCha()->GetPlayer() != pPlayer)
		{
			//LG("�����ɫ�ش����", "�����Player��ַ %p[dbid %u]������ҵ����� %s���ý�ɫ��Player��ַ %p��\n",
			LG("save_character_error", "save Player address %p[dbid %u]��the character main player %s��the character 's Player address %p��\n",		
				pPlayer, pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName(), pPlayer->GetMainCha()->GetPlayer());
			//pPlayer->SystemNotice("��ҽ�ɫ��ƥ�䣬�������Ͽⲻ�ɹ�");
			pPlayer->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00025));

#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		bool	bSaveMainCha = false, bSaveBoat = false, bSaveKitBag = false, bSaveMMask = false, bSaveBank = false;
		bool    bSaveKitBagTmp = false;
		bool    bSaveKBState = false;
		BeginTran();
		try
		{
			DWORD	dwStartTick = GetTickCount();

			bSaveMainCha = _tab_cha->SaveAllData(pPlayer, chSaveType, szTarMapName , lTarX, lTarY); // ��������ɫ
			DWORD	dwSaveMainTick = GetTickCount();
			bSaveKitBag = _tab_res->SaveKitbagData(pPlayer->GetMainCha());
			//������ʱ����
			bSaveKitBagTmp = _tab_res->SaveKitbagTmpData(pPlayer->GetMainCha());
			//������������״̬
			//bSaveKBState = _tab_cha->SaveKBState(pPlayer);
			DWORD	dwSaveKbTick = GetTickCount();
			bSaveBank = _tab_res->SaveBankData(pPlayer);
			DWORD	dwSaveBankTick = GetTickCount();
			// Delete by lark.li 20080926 begin
			//if ((chSaveType != enumSAVE_TYPE_TIMER) && (g_Config.m_chMapMask > 0))
			//{
			//	if (pPlayer->IsMapMaskChange())
			//	{
			//		bSaveMMask = _tab_mmask->SaveData(pPlayer);
			//		pPlayer->ResetMapMaskChange();
			//	}
			//}
			//else
			//	bSaveMMask = true;
			//DWORD	dwSaveMMaskTick = GetTickCount();
			// End

			bSaveBoat = _tab_boat->SaveAllData(pPlayer, chSaveType); // ���洬
			DWORD	dwSaveBoatTick = GetTickCount();

			//LG("�������ݺ�ʱ", "�ܼ�%-8d������ɫ%-8d������ɫ����%-8d������%-8d�����ͼ%-8d����%-8d.[%d %s]\n",
			//LG("save data waste time", "totalize %-8d��main character %-8d��main character kitbag %-8d��bank %-8d��big map %-8d��boat %-8d.[%d %s]\n",
			//	dwSaveBoatTick - dwStartTick, dwSaveMainTick - dwStartTick, dwSaveKbTick - dwSaveMainTick, dwSaveBankTick - dwSaveKbTick, dwSaveMMaskTick - dwSaveBankTick, dwSaveBoatTick - dwSaveMMaskTick,
			//	pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName());
			LG("save_data_waste_time", "totalize,%d,main character %-8d,main character kitbag %-8d,bank %-8d,boat %-8d([%d %s])\n",
				dwSaveBoatTick - dwStartTick, dwSaveMainTick - dwStartTick, dwSaveKbTick - dwSaveMainTick, dwSaveBankTick - dwSaveKbTick,  dwSaveBoatTick - dwSaveBankTick,
				pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName());
		}
		catch (...)
		{
			//LG("enter_map", "�������ȫ�����ݵĹ����з����쳣.\n");
			LG("enter_map", "It's abnormity when saving the character's whole data.\n");
		}

		if (!bSaveMainCha || !bSaveBoat || !bSaveKitBag )
		{
			RollBack();
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}
		CommitTran();

		//LG("enter_map", "��������������ݳɹ�.\n");
		LG("enter_map", "save character whole data succeed.\n");
		// ��¼���ļ�
		if (chSaveType != enumSAVE_TYPE_TIMER)
		{
			CKitbag		*pCKb;
			CCharacter	*pCMainC = pPlayer->GetMainCha();
			short	sItemNum = pCMainC->GetKitbag()->GetUseGridNum();
			g_kitbag[0] = '\0';
			//sprintf(g_kitbag, "��Ǯ��%u ��������%d@", pCMainC->getAttr(ATTR_GD), sItemNum);
			//sprintf(g_kitbag, RES_STRING(GM_GAMEDB_CPP_00026), pCMainC->getAttr(ATTR_GD), sItemNum);
			//_snprintf_s(g_kitbag,sizeof(g_kitbag),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00026), pCMainC->getAttr(ATTR_GD), sItemNum);
			CFormatParameter param(2);
			param.setLong( 0, (int)pCMainC->getAttr( ATTR_GD ));
			param.setDouble( 1, sItemNum );
			RES_FORMAT_STRING( GM_GAMEDB_CPP_00026, param, g_kitbag );

			SItemGrid *pGridCont;
			CItemRecord *pCItem;
			pCKb = pCMainC->GetKitbag();
			for (short i = 0; i < sItemNum; i++)
			{
				pGridCont = pCKb->GetGridContByNum(i);
				if (!pGridCont)
					continue;
				pCItem = GetItemRecordInfo(pGridCont->sID);
				if (!pCItem)
					continue;
				//sprintf(g_kitbag + strlen(g_kitbag), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
				_snprintf_s(g_kitbag + strlen(g_kitbag),sizeof(g_kitbag )- strlen(g_kitbag),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

			}
			TL(CHA_OUT, pCMainC->GetName(), "", g_kitbag);

			short	sItemTmpNum = pCMainC->m_pCKitbagTmp->GetUseGridNum();
			g_kitbagTmp[0] = '\0';
			//sprintf(g_kitbagTmp, "��ʱ������%d@", sItemTmpNum);
			//sprintf(g_kitbagTmp, RES_STRING(GM_GAMEDB_CPP_00022), sItemTmpNum);
			_snprintf_s(g_kitbagTmp,sizeof(g_kitbagTmp),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00022), sItemTmpNum);

			pCKb = pCMainC->m_pCKitbagTmp;
			for (short i = 0; i < sItemTmpNum; i++)
			{
				pGridCont = pCKb->GetGridContByNum(i);
				if (!pGridCont)
					continue;
				pCItem = GetItemRecordInfo(pGridCont->sID);
				if (!pCItem)
					continue;
				//sprintf(g_kitbagTmp + strlen(g_kitbagTmp), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
				_snprintf_s(g_kitbagTmp + strlen(g_kitbagTmp),sizeof(g_kitbagTmp) - strlen(g_kitbagTmp),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

			}
			TL(CHA_OUT, pCMainC->GetName(), "", g_kitbagTmp);

			g_equip[0] = '\0';
			//sprintf(g_equip, "װ����%d@", enumEQUIP_NUM);
			//sprintf(g_equip, RES_STRING(GM_GAMEDB_CPP_00024), enumEQUIP_NUM);
			_snprintf_s(g_equip,sizeof(g_equip),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00024), enumEQUIP_NUM);

			for (short i = 0; i < enumEQUIP_NUM; i++)
			{
				pGridCont = &pCMainC->m_SChaPart.SLink[i];
				if (!pGridCont)
					continue;
				pCItem = GetItemRecordInfo(pGridCont->sID);
				if (!pCItem)
					continue;
				//sprintf(g_equip + strlen(g_equip), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
				_snprintf_s(g_equip + strlen(g_equip),sizeof(g_equip) - strlen(g_equip),_TRUNCATE,"%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

			}
			TL(CHA_EQUIP, pCMainC->GetName(), "", g_equip);

			char	chStart = 0, chEnd = pPlayer->GetCurBankNum() - 1;
			//sprintf(g_kitbag, "����ID(%d):", pPlayer->GetCurBankNum());
			//sprintf(g_kitbag, RES_STRING(GM_GAMEDB_CPP_00023), pPlayer->GetCurBankNum());
			_snprintf_s(g_kitbag,sizeof(g_kitbag),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00023), pPlayer->GetCurBankNum());

			for (char i = chStart; i <= chEnd; i++)
			{
				pCKb = pPlayer->GetBank(i);
				sItemNum = pCKb->GetUseGridNum();
				//sprintf(g_kitbag + strlen(g_kitbag), "[%d]%d@;", i + 1, sItemNum);
				_snprintf_s(g_kitbag + strlen(g_kitbag),sizeof(g_kitbag) - strlen(g_kitbag),_TRUNCATE, "[%d]%d@;", i + 1, sItemNum);

				for (short i = 0; i < sItemNum; i++)
				{
					pGridCont = pCKb->GetGridContByNum(i);
					if (!pGridCont)
						continue;
					pCItem = GetItemRecordInfo(pGridCont->sID);
					if (!pCItem)
						continue;
					//sprintf(g_kitbag + strlen(g_kitbag), "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);
					_snprintf_s(g_kitbag + strlen(g_kitbag),sizeof(g_kitbag) - strlen(g_kitbag),_TRUNCATE, "%s[%d],%d;", pCItem->szName, pGridCont->sID, pGridCont->sNum);

				}
			}
			TL(CHA_BANK, pCMainC->GetName(), "", g_kitbag);
		}
		//
	}
	catch(...)
	{

	}

#ifdef UPDATE_MUL_THREAD
	pPlayer->DBUnLock();
#endif
	m_Lock.Unlock();
	return true;
}

bool CGameDB::SavePlayerEx(CPlayer *pPlayer, char chSaveType)
{
	m_LockEx.Lock();
#ifdef UPDATE_MUL_THREAD
	pPlayer->DBLock();
#endif

	try
	{
		if (!pPlayer || !pPlayer->GetMainCha())
		{
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		if (pPlayer->GetMainCha()->GetPlayer() != pPlayer)
		{
			//LG("�����ɫ�ش����", "�����Player��ַ %p[dbid %u]������ҵ����� %s���ý�ɫ��Player��ַ %p��\n",
			LG("ave_character_error", "save Player address %p[dbid %u],the character main player %s,the character 's Player address %p\n",		
				pPlayer, pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName(), pPlayer->GetMainCha()->GetPlayer());
			//pPlayer->SystemNotice("��ҽ�ɫ��ƥ�䣬�������Ͽⲻ�ɹ�");
			pPlayer->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00025));

#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		if(!pPlayer->IsValid())
		{
			LG("ave_character_error", "save Player address %p[dbid %u],the character main player %s,the character 's Player address %p invalid\n",		
				pPlayer, pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName(), pPlayer->GetMainCha()->GetPlayer());
#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}

		bool	bSaveMainCha = false, bSaveBoat = false, bSaveKitBag = false, bSaveMMask = false, bSaveBank = false;
		bool    bSaveKitBagTmp = false;
		bool    bSaveKBState = false;
		BeginTran();
		try
		{
			DWORD	dwStartTick = GetTickCount();

			bSaveMainCha = _tab_cha->SaveAllDataEx(pPlayer, chSaveType); // ��������ɫ
			DWORD	dwSaveMainTick = GetTickCount();
			bSaveKitBag = _tab_res->SaveKitbagDataEx(pPlayer->GetMainCha());
			//������ʱ����
			bSaveKitBagTmp = _tab_res->SaveKitbagTmpDataEx(pPlayer->GetMainCha());
			//������������״̬
			//bSaveKBState = _tab_cha->SaveKBState(pPlayer);
			DWORD	dwSaveKbTick = GetTickCount();
			bSaveBank = _tab_res->SaveBankDataEx(pPlayer);
			DWORD	dwSaveBankTick = GetTickCount();
			// Delete by lark.li 20080926 begin
			//if ((chSaveType != enumSAVE_TYPE_TIMER) && (g_Config.m_chMapMask > 0))
			//{
			//	if (pPlayer->IsMapMaskChange())
			//	{
			//		bSaveMMask = _tab_mmask->SaveData(pPlayer);
			//		pPlayer->ResetMapMaskChange();
			//	}
			//}
			//else
			//	bSaveMMask = true;
			//DWORD	dwSaveMMaskTick = GetTickCount();
			// End

			bSaveBoat = _tab_boat->SaveAllDataEx(pPlayer, chSaveType); // ���洬
			DWORD	dwSaveBoatTick = GetTickCount();

			//LG("�������ݺ�ʱ", "�ܼ�%-8d������ɫ%-8d������ɫ����%-8d������%-8d�����ͼ%-8d����%-8d.[%d %s]\n",
			//LG("save data waste time", "totalize %-8d��main character %-8d��main character kitbag %-8d��bank %-8d��big map %-8d��boat %-8d.[%d %s]\n",
			//	dwSaveBoatTick - dwStartTick, dwSaveMainTick - dwStartTick, dwSaveKbTick - dwSaveMainTick, dwSaveBankTick - dwSaveKbTick, dwSaveMMaskTick - dwSaveBankTick, dwSaveBoatTick - dwSaveMMaskTick,
			//	pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName());
			LG("save_data_waste_time", "totalize,%d,main character %-8d,main character kitbag %-8d,bank %-8d,boat %-8d([%d %s])\n",
				dwSaveBoatTick - dwStartTick, dwSaveMainTick - dwStartTick, dwSaveKbTick - dwSaveMainTick, dwSaveBankTick - dwSaveKbTick,  dwSaveBoatTick - dwSaveBankTick,
				pPlayer->GetDBChaId(), pPlayer->GetMainCha()->GetLogName());
		}
		catch (...)
		{
			//LG("enter_map", "�������ȫ�����ݵĹ����з����쳣.\n");
			LG("enter_map", "It's abnormity when saving the character's whole data.\n");
		}

		if (!bSaveMainCha || !bSaveBoat || !bSaveKitBag )
		{
			RollBack();

#ifdef UPDATE_MUL_THREAD
			pPlayer->DBUnLock();
#endif
			m_LockEx.Unlock();
			return false;
		}
		CommitTran();

		//LG("enter_map", "��������������ݳɹ�.\n");
		LG("enter_map", "save character whole data succeed.\n");
	}
	catch(...)
	{

	}

#ifdef UPDATE_MUL_THREAD
	pPlayer->DBUnLock();
#endif
	m_LockEx.Unlock();
	return true;
}

bool CGameDB::SaveChaAssets(CCharacter *pCCha)
{
	m_Lock.Lock();

	// ��Ϊ�˲������ܰ������ݿ�ع������������ڼ䲻��throw�쳣
	try
	{
		//LG("enter_map", "��ʼ�����ɫ�ʲ�.\n");
		LG("enter_map", "Start save character assets.\n");
		if (!pCCha || !pCCha->GetPlayer())
		{
			m_Lock.Unlock();
			return false;
		}

#ifdef UPDATE_MUL_THREAD
		pCCha->GetPlayer()->DBLock();
#endif
		DWORD	dwStartTick = GetTickCount();
		if (!_tab_cha->SaveMoney(pCCha->GetPlayer()))
		{
#ifdef UPDATE_MUL_THREAD
			pCCha->GetPlayer()->DBUnLock();
#endif
			m_Lock.Unlock();
			return false;
		}

		if (!pCCha->IsBoat())
		{
			if (!_tab_res->SaveKitbagData(pCCha))
			{
#ifdef UPDATE_MUL_THREAD
				pCCha->GetPlayer()->DBUnLock();
#endif
				m_Lock.Unlock();
				return false;
			}
		}
		else
		{
			if (!_tab_boat->SaveCabin(*pCCha, enumSAVE_TYPE_TRADE))
			{
#ifdef UPDATE_MUL_THREAD
				pCCha->GetPlayer()->DBUnLock();
#endif
				m_Lock.Unlock();
				return false;
			}
		}

		//LG("enter_map", "�����ɫ %s(%s) �ʲ��ɹ�.\n", pCCha->GetLogName(), pCCha->GetPlyMainCha()->GetLogName());
		LG("enter_map", "Save character %s(%s)assets succeed.\n", pCCha->GetLogName(), pCCha->GetPlyMainCha()->GetLogName());
		//LG("�������ݺ�ʱ", "�ܼ�%-8d.[%d %s]\n", GetTickCount() - dwStartTick, pCCha->GetPlayer()->GetDBChaId(), pCCha->GetLogName());
		LG("save_data_waste_time", "totalled,%d,[%d %s]\n", GetTickCount() - dwStartTick, pCCha->GetPlayer()->GetDBChaId(), pCCha->GetLogName());
	}
	catch (...)
	{
		//LG("enter_map", "�����ɫ�ʲ�ʱ�������쳣!\n");
		LG("enter_map", "When save character assets occured abnormity\n");

#ifdef UPDATE_MUL_THREAD
		pCCha->GetPlayer()->DBUnLock();
#endif
		m_Lock.Unlock();
		return false;
	}

#ifdef UPDATE_MUL_THREAD
	pCCha->GetPlayer()->DBUnLock();
#endif
	m_Lock.Unlock();
	return true;
}


//===============CTableGuild Begin===========================================
bool CTableGuild::Init(void)
{
	//sprintf(g_sql, "select \
	//			guild_id, guild_name, motto, passwd, leader_id, type, stat, money, exp, member_total,\
	//			try_total, disband_date \
	//			from %s \
	//			(nolock) where 1=2", \
	//			_get_table());
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   guild_id, guild_name, motto, passwd, leader_id, type, stat, money, exp, member_total,\
				   try_total, disband_date \
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());

	if (strlen(g_sql) >= SQL_MAXLEN)
	{
		//FILE	*pf = fopen("log\\SQL��䳤��Խ��.txt", "a+");
		//FILE	*pf = fopen("log\\SQLsentence_length_slopover.txt", "a+");
		FILE	*pf = NULL ;
		if(fopen_s( &pf, "log\\SQLsentence_length_slopover.txt", "a+")!= 0 )
		{
			LG2("error", "Load Raw Data Info Bin File [log\\SQLsentence_length_slopover.txt] Failed!\n");
			return FALSE;
		}
		if (pf)
		{
			fprintf(pf, "%s\n\n", g_sql);
			fclose(pf);
		}
		//LG("enter_map", "SQL��䳤��Խ��!\n");
		LG("enter_map", "SQL sentence length slop over\n");
		return false;
	}
	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		//MessageBox(0, "���ݿ�(guild)��ʼ����������", "����", MB_OK);
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "guild");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "guild");

		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}

	return true;
}

long CTableGuild::Create(CCharacter* pCha, char guildtype, char *guildname, cChar *passwd)
{T_B
	long l_ret_guild_id	=0;
	string buf[1]; 
	//char sql[SQL_MAXLEN];

	while(true)
	{
		LG("consortia system","Create.\n");

		//��ȡ�չ����ID
		//char *param = "isnull(min(guild_id),0)";
		//char filter[80]; //sprintf(filter, "guild_id >0 and leader_id =0 and type =%d", guildtype);
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id >0 and leader_id =0 and type =%d", guildtype);
		//bool ret = _get_row(buf, 1, param, filter);
		bool ret = _get_row_stored_procedure(buf, 1, "{CALL dbo.Create1(?)}", "dbo", "Create1", NULL, 1, &guildtype);
		if (!ret)		//����SQL����
		{
			//pCha->SystemNotice("���ᴴ��û�гɹ�.");
			pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00027));
			//LG("����ϵͳ","�������ᷢ����SQL��������.");
			LG("consortia system","found consortia system occur SQL operator error.\n");
			return 0;
		}
		l_ret_guild_id	=atol(buf[0].c_str());
		if(!l_ret_guild_id)		//������Ŀ�Ѵ�ϵͳ����
		{
			//pCha->SystemNotice((dstring(guildtype ==0?"����":"����")<<"������Ŀ�Ѵ�ϵͳ����"));
			pCha->SystemNotice((dstring(guildtype ==0?RES_STRING(GM_GAMEDB_CPP_00028):RES_STRING(GM_GAMEDB_CPP_00029))<<RES_STRING(GM_GAMEDB_CPP_00030)));
			return 0;
		}
		//���¹���������������
		if(guildtype ==emGldTypeNavy)	//����
		{
			//sprintf(sql,	"update %s set leader_id =%d ,passwd ='%s',stat =0,money =0,exp =0,\
			//							member_total =1,try_total =0\
			//					where leader_id =0 and guild_id =%d",
			//	_get_table(), pCha->GetID(), passwd, l_ret_guild_id);
			//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update %s set leader_id =%d ,passwd ='%s',stat =0,money =0,exp =0,\
							member_total =1,try_total =0\
							where leader_id =0 and guild_id =%d",
			//				_get_table(), pCha->GetID(), passwd, l_ret_guild_id);

			const DWORD parameter1 = pCha->GetID();
			//SQLRETURN l_sqlret =exec_sql_direct(sql);
			SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Create2(?,?,?)}", "dbo", "Create2", 3, &parameter1, passwd, &l_ret_guild_id);
			if(!DBOK(l_sqlret))	//��ͨSQL����
			{
				//pCha->SystemNotice("���ᴴ��û�гɹ�.");
				pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00027));
				//LG("����ϵͳ","�������ᷢ����SQL��������.");
				LG("consortia system","found consortia system occur SQL operator error.\n");
				return 0;
			}
			if(get_affected_rows() !=1)
			{
				continue;
			}

			//param = "guild_name";
			//sprintf(filter, "guild_id  =%d", l_ret_guild_id);
			//_snprintf_s(filter,sizeof(filter),_TRUNCATE,"guild_id  =%d", l_ret_guild_id);

			//ret = _get_row(buf, 1, param, filter);
			ret = _get_row_stored_procedure(buf, 1, "{CALL dbo.Create3(?)}", "dbo", "Create3", NULL, 1, &l_ret_guild_id);
			//TODO
			//strcpy(guildname,buf[0].c_str());
			strncpy_s(guildname, 32, buf[0].c_str(), _TRUNCATE);
		}else if(guildtype ==emGldTypePirate)	//����
		{
			//sprintf(sql,	"update %s set leader_id =%d ,passwd ='%s', guild_name ='%s', stat =0,money =0,exp =0,\
			//							member_total =1,try_total =0\
			//					where leader_id =0 and guild_id =%d",
			//	_get_table(), pCha->GetID(), passwd, guildname, l_ret_guild_id);
			//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update %s set leader_id =%d ,passwd ='%s', guild_name ='%s', stat =0,money =0,exp =0,\
							member_total =1,try_total =0\
							where leader_id =0 and guild_id =%d",
			//				_get_table(), pCha->GetID(), passwd, guildname, l_ret_guild_id);

			const DWORD parameter1 = pCha->GetID();
			//SQLRETURN l_sqlret =exec_sql_direct(sql);
			SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Create4(?,?,?,?)}", "dbo", "Create4", 4, &parameter1, passwd, guildname, &l_ret_guild_id);
			if(!DBOK(l_sqlret))	//�������������ظ�
			{
				//pCha->SystemNotice("�������������ѱ�ʹ��");
				pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00031));
				return 0;
			}
			if(get_affected_rows() !=1)
			{
				continue;
			}
		}else
		{
			//pCha->SystemNotice("���ᴴ��û�гɹ�.");
			pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00027));
			//LG("����ϵͳ","�������Ͳ�������.");
			LG("consortia system","constortia system type parameter error\n");
			return 0;	//�������ʹ���
		}
		break;
	}
	//sprintf(sql,"update character set guild_id =%d,guild_stat =0,guild_permission =-1 \
	//			where cha_id =%d",l_ret_guild_id ,pCha->GetID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update character set guild_id =%d,guild_stat =0,guild_permission =-1 \
				where cha_id =%d",l_ret_guild_id ,pCha->GetID());
	const DWORD parameter1 = pCha->GetID();

	//exec_sql_direct(sql);
	bool sqlret= stored_procedure("{CALL dbo.Create5(?,?)}", "dbo", "Create5", 2, &l_ret_guild_id, &parameter1);
	if(!DBOK(sqlret))
	{
		LG("stored procedure", "error while creating a guild, parameters: %d, %s", l_ret_guild_id, parameter1);
	}
	WPACKET l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MP_GUILD_CREATE);
	WRITE_LONG(l_wpk,l_ret_guild_id);	//����ID
	WRITE_STRING(l_wpk,guildname);		//����Name
	WRITE_CHAR(l_wpk,guildtype);		//��������
	WRITE_STRING(l_wpk,g_GetJobName(uShort(pCha->getAttr(ATTR_JOB))));//ְҵ
	WRITE_SHORT(l_wpk,uShort(pCha->getAttr(ATTR_LV)));		//�ȼ�
	pCha->ReflectINFof(pCha,l_wpk);

    return l_ret_guild_id;	//���ᴴ���ɹ�,���ع���ID
T_E}
/*
����
select gld.guild_id, gld.guild_name, gld.motto, gld.leader_id, cha.cha_name leader_name, gld.type, gld.stat, gld.money, gld.exp, gld.member_total, gld.try_total, gld.disband_date, DATEDIFF(mi,gld.disband_date,GETDATE()) ��ɢ�����ۼƷ���, 7*24*60 -DATEDIFF(mi,gld.disband_date,GETDATE()) ��ɢ����ʣ�����
from guild As gld, character As cha
where (gld.type =0 and gld.leader_id =cha.cha_id)
union
select gld.guild_id, gld.guild_name, gld.motto, gld.leader_id, '[��]' leader_name, gld.type, gld.stat, gld.money, gld.exp, gld.member_total, gld.try_total, gld.disband_date, DATEDIFF(mi,gld.disband_date,GETDATE()) ��ɢ�����ۼƷ���, 7*24*60 -DATEDIFF(mi,gld.disband_date,GETDATE()) ��ɢ����ʣ�����
from guild As gld
where (gld.type =0 and gld.leader_id =0)
����
select gld.guild_id, gld.guild_name, gld.motto, gld.leader_id, cha.cha_name leader_name, gld.type, gld.stat, gld.money, gld.exp, gld.member_total, gld.try_total, gld.disband_date, DATEDIFF(mi,gld.disband_date,GETDATE()) ��ɢ�����ۼƷ���, 7*24*60 -DATEDIFF(mi,gld.disband_date,GETDATE()) ��ɢ����ʣ�����
from guild As gld, character As cha
where (gld.type =1 and gld.leader_id =cha.cha_id)
*/
bool CTableGuild::ListAll(CCharacter* pCha, char guildtype ,char disband_days)
{
	const char *sql_syntax =0;
	if(!pCha || disband_days<1)
	{
		return false;
	}else if(guildtype ==emGldTypeNavy)
	{
		// NO NEED TO STORE PROCEDURE, CONSTANT QUERY.
		sql_syntax =
			"	select gld.guild_id, gld.guild_name, gld.motto, gld.leader_id, cha.cha_name leader_name,gld.type,\
						gld.stat, gld.money, gld.exp, gld.member_total, gld.try_total,gld.disband_date,\
						case when gld.stat>0 then DATEDIFF(mi,gld.disband_date,GETDATE()) else 0 end disband_time1,\
						case when gld.stat>0 then %d*24*60 -DATEDIFF(mi,gld.disband_date,GETDATE()) else 0 end disband_time2\
					from guild As gld, character As cha\
					where (gld.type =0 and gld.leader_id =cha.cha_id)\
				union\
				select gld.guild_id, gld.guild_name, gld.motto, gld.leader_id, '[None]' leader_name,gld.type,\
						gld.stat, gld.money, gld.exp, gld.member_total, gld.try_total, gld.disband_date,\
						0 disband_time1,\
						0 disband_time2\
					from guild As gld\
					where (gld.type =0 and gld.leader_id =0)\
			";
	}else if(guildtype ==emGldTypePirate)
	{
		sql_syntax =
			"	select gld.guild_id, gld.guild_name, gld.motto, gld.leader_id, cha.cha_name leader_name,gld.type,\
						gld.stat, gld.money, gld.exp, gld.member_total, gld.try_total,gld.disband_date,\
						case when gld.stat>0 then DATEDIFF(mi,gld.disband_date,GETDATE()) else 0 end disband_time1,\
						case when gld.stat>0 then %d*24*60 -DATEDIFF(mi,gld.disband_date,GETDATE()) else 0 end disband_time2\
					from guild As gld, character As cha\
					where (gld.type =1 and gld.leader_id =cha.cha_id)\
			";
	}else
	{
		return false;
	}

	bool ret = false;
	char sql[SQL_MAXLEN];
	//sprintf(sql, sql_syntax, disband_days);
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, sql_syntax, disband_days);


	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found = true;

	try
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

			throw 1;
		}

		sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
		if (sqlret != SQL_SUCCESS)
		{
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);

			if (sqlret != SQL_SUCCESS_WITH_INFO)
				throw 2;
		}

		sqlret = SQLNumResultCols(hstmt, &col_num);
		col_num = std::min<decltype(col_num)>(col_num, MAX_COL);
		col_num = std::min<decltype(col_num)>(col_num, _max_col);

		// Bind Column
		for (int i = 0; i < col_num; ++ i)
		{
			SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
		}

		WPACKET	l_wpk,l_wpk0 =GETWPACKET();
		WRITE_CMD(l_wpk0, CMD_MC_LISTGUILD);
		WRITE_CHAR(l_wpk0,guildtype);					//�������0��������1������

		// Fetch each Row	int i; // ȡ��������
		int f_row = 1;
		for (f_row = 1; (sqlret = SQLFetch(hstmt)) == SQL_SUCCESS || sqlret == SQL_SUCCESS_WITH_INFO; ++ f_row)
		{
			if (sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			}
			if((f_row %20) ==1)
			{
				l_wpk	=l_wpk0;
			}
			WRITE_LONG(l_wpk,atol((char const *)_buf[0]));	//����ID
			WRITE_STRING(l_wpk,(char const *)_buf[1]);		//������
			WRITE_STRING(l_wpk,(char const *)_buf[2]);		//����������
			WRITE_STRING(l_wpk,(char const *)_buf[4]);		//�᳤��
			WRITE_SHORT(l_wpk,atoi((const char *)_buf[9]));	//��Ա��
			LLong l_exp =_atoi64((char const *)_buf[8]);
			WRITE_LONG(l_wpk,uLong(l_exp%0x100000000));//����ֵ��32λ
			WRITE_LONG(l_wpk,uLong(l_exp/0x100000000));//����ֵ��32λ

			if(!(f_row %20))
			{
				WRITE_CHAR(l_wpk,((f_row-1)%20)+1);	//���ΰ���������
				pCha->ReflectINFof(pCha,l_wpk);
			}
		}
		if((f_row%20) ==1)
		{
			l_wpk	=l_wpk0;
		}
		WRITE_LONG(l_wpk,(f_row -1)%20);	//���ΰ���������
		pCha->ReflectINFof(pCha,l_wpk);

		SQLFreeStmt(hstmt, SQL_UNBIND);
		ret = true;
	}catch(int&e)
	{
		//LG("����ϵͳ", "�����������ODBC �ӿڵ��ô���λ���룺%d\n",e);
		LG("consortia system", "found consortia process ODBC interfance transfer error,position ID:%d\n",e);
	}catch (...)
	{
		//LG("����ϵͳ", "Unknown Exception raised when list all guilds\n");
		LG("consortia system", "Unknown Exception raised when list all guilds\n");
	}

	if (hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return ret;
}
void CTableGuild::TryFor(CCharacter* pCha, uLong guildid)
{
	if( pCha->HasGuild() )
	{
		//pCha->SystemNotice( "���Ѿ��ǹ��ᡶ%s����Ա,�����ظ�������빫��!", pCha->GetGuildName() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00032), pCha->GetGuildName() );
		return;
	}
	else if( guildid == pCha->GetGuildID() )
	{
		//pCha->SystemNotice( "�����ظ�������빫�ᡶ%s��!", pCha->GetGuildName() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00033), pCha->GetGuildName() );
		return;
	}

	string buf[3];
	//char filter[80];
	//char	*	param	="guild_id";
	//sprintf(filter,"leader_id >0 and guild_id =%d",guildid);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE,"leader_id >0 and guild_id =%d",guildid);


	//int l_ret =_get_row(buf,3,param,filter);
	int l_ret = _get_row_stored_procedure(buf, 3, "{CALL dbo.TryFor1(?)}", "dbo", "TryFor1", NULL, 1, &guildid);
	if(!DBOK(l_ret))
	{
		//pCha->SystemNotice("������빫��ʧ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00034));
		//LG("����ϵͳ","�û�[%s]������빫��[ID=%d]ʱ��SQLִ��ʧ��.\n",pCha->GetName(),guildid);
		LG("consortia system","character[%s]apply join in consortia [ID=%d] carry out SQL failed.\n",pCha->GetName(),guildid);
		return;
	}else if(get_affected_rows() !=1)
	{
		//pCha->SystemNotice("�������Ĺ����޻᳤.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00035));
		return;
	}
	//param	="c.guild_id, c.guild_stat, g.guild_name";
	//string	l_tbl_name =_tbl_name;
	//_tbl_name	="character c,guild g";
	//sprintf(filter, "c.guild_id =g.guild_id and c.cha_id =%d and g.guild_id <>%d",pCha->GetID(), guildid);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "c.guild_id =g.guild_id and c.cha_id =%d and g.guild_id <>%d",pCha->GetID(), guildid);



	//l_ret = _get_row(buf, 3, param, filter);
	//_tbl_name	=l_tbl_name;
	const DWORD parameter1 = pCha->GetID();
	l_ret				   = _get_row_stored_procedure(buf, 3, "{CALL dbo.TryFor2(?,?)}", "dbo", "TryFor2", NULL, 2, &parameter1, &guildid);
	if(!DBOK(l_ret) || get_affected_rows() !=1)
	{
		//pCha->SystemNotice("������빫��ʧ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00034));
		//LG("����ϵͳ","�û�[%s]������빫��[ID=%d]ʱ��SQLִ��ʧ��.\n",pCha->GetName(),guildid);
		LG("consortia system","character[%s]apply join in consortia [ID=%d] carry out SQL failed.\n",pCha->GetName(),guildid);
		return;
	}

	// ��ѯ�����빫����Ϣ
	string bufnew[3];
	//param	="type, guild_name";
	//sprintf(filter, "guild_id =%d",guildid);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",guildid);

	int	 l_retrow =0;
	//l_ret = _get_row(bufnew, 3, param, filter, &l_retrow);
	l_ret = _get_row_stored_procedure(bufnew, 3, "{CALL dbo.TryFor3(?)}", "dbo", "TryFor3", &l_retrow, 1, &guildid);
	if(l_retrow ==1)
	{
	}else
	{
		//LG( "����ϵͳ", "TryFor����ɫ%s���빫��ID[0x%X]������!", pCha->GetName(), guildid );
		LG( "consortia system", "TryFor: character %s apply consortia ID[0x%X]is inexistence!", pCha->GetName(), guildid );
		//pCha->SystemNotice( "������Ĺ��᲻����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00036) );
		return;
	}

	// ��ʱ�����ѯ���Ĺ�������
	//strncpy( pCha->GetPlayer()->m_szTempGuildName, bufnew[1].c_str(), defGUILD_NAME_LEN - 1 );
	strncpy_s( pCha->GetPlayer()->m_szTempGuildName, sizeof(pCha->GetPlayer()->m_szTempGuildName), bufnew[1].c_str(), _TRUNCATE );

	if(atoi(buf[0].c_str()))
	{
		if(atoi(buf[1].c_str()) ==0)
		{
			//pCha->SystemNotice("�㵱ǰ�ǹ���[%s]����ʽ��Ա,������������Ĺ���.",buf[2].c_str());
			pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00037),buf[2].c_str());
			return;
		}
		else if(atoi(buf[1].c_str()) ==1 && pCha->GetPlayer()->m_GuildState.IsFalse(emGuildReplaceOldTry))
		{
			pCha->GetPlayer()->m_GuildState.SetBit(emGuildReplaceOldTry);
			pCha->GetPlayer()->m_lTempGuildID = guildid;
			WPACKET l_wpk =GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MC_GUILD_TRYFORCFM);
			WRITE_STRING(l_wpk,buf[2].c_str());
			pCha->ReflectINFof(pCha,l_wpk);
			return;
		}
	}else
	{
		TryForConfirm(pCha,guildid);
	}
}
void CTableGuild::TryForConfirm(CCharacter* pCha, uLong guildid)
{
	//char sql[SQL_MAXLEN];

	if( pCha->HasGuild() )
	{
		//pCha->SystemNotice( "���Ѿ��ǹ��ᡶ%s����Ա,�����ظ�������빫��!", pCha->GetGuildName() );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00038), pCha->GetGuildName() );
		return;
	}

	DWORD dwOldGuildID = pCha->GetGuildID();

		// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "���빫�����ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00039) );
		return;
	}

	//sprintf(sql,	"update character set guild_id =%d ,guild_stat =1,guild_permission =0\
	//					where cha_id =%d and\
	//							%d in (select guild_id from guild where leader_id >0 and guild_id =%d and try_total <%d and member_total <%d)",
	//		 guildid, pCha->GetID(), guildid, guildid,emMaxTryMemberNum,emMaxMemberNum);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update character set guild_id =%d ,guild_stat =1,guild_permission =0\
					where cha_id =%d and\
					%d in (select guild_id from guild where leader_id >0 and guild_id =%d and try_total <%d and member_total <%d)",
	//				guildid, pCha->GetID(), guildid, guildid,emMaxTryMemberNum,emMaxMemberNum);

	const DWORD parameter1 = pCha->GetID();
	const int parameter2 = emMaxTryMemberNum;
	const int	parameter3 = emMaxMemberNum;
	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.TryForConfirm1(?,?,?,?)}", "dbo", "TryForConfirm1", 4, &guildid, &parameter1, &parameter2, &parameter3);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "������빫�����ʧ�ܣ����ܸù��������������������Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00040) );
		return;
	}

	//sprintf(sql,	"update guild set try_total =try_total +1 where guild_id =%d",guildid);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set try_total =try_total +1 where guild_id =%d",guildid);
	l_sqlret = stored_procedure("{CALL dbo.TryForConfirm2(?)}", "dbo", "TryForConfirm2", 1, &guildid);
	//l_sqlret =exec_sql_direct(sql);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "������빫�����ʧ�ܣ����ܸù��������������������Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00040) );
		return;
	}

	// �ж��Ƿ��ǿͻ��˸������빫��
	if( dwOldGuildID && pCha->GetPlayer()->m_GuildState.IsTrue(emGuildReplaceOldTry) )
	{
		//sprintf(sql,"update guild set try_total =try_total -1 where guild_id =%d and try_total > 0"
		//	,dwOldGuildID);
		//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update guild set try_total =try_total -1 where guild_id =%d and try_total > 0"
		//	,dwOldGuildID);
		// Same as dbo.Reject 3
		//SQLRETURN l_sqlret = exec_sql_direct(sql);
		SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Reject3(?)}", "dbo", "Reject3", 1, &dwOldGuildID);
		if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
		{
			this->rollback();
			//pCha->SystemNotice( "�����˳�ԭ�й������ʧ�ܣ����Ժ�����!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00041) );
			return;
		}
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "������빫�����ʧ�ܣ����ܸù��������������������Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00040) );
		return;
	}

	// �����¹���������Ϣ
	pCha->SetGuildID( guildid );
	pCha->SetGuildState( emGldMembStatTry );

	pCha->SetGuildName( pCha->GetPlayer()->m_szTempGuildName );
	//pCha->SystemNotice( "��ϲ!��������빫�ᡶ%s���ɹ�,�����ĵȴ��������Ա������.", pCha->GetGuildName() );
	pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00042), pCha->GetGuildName() );
}
bool CTableGuild::GetGuildInfo(CCharacter* pCha, uLong guildid )
{
	string buf[3];
	//char filter[80];

	//char*param	="type, guild_name, motto";
	//sprintf(filter, "guild_id =%d",guildid);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",guildid);
	// Same as dbo.GetTypeByID
	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 3, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 3, "{CALL dbo.GetTypeByID(?)}", "dbo", "GetTypeByID", &l_retrow, 1, &guildid);
	if(l_retrow ==1)
	{
		pCha->SetGuildType( atoi(buf[0].c_str()) );
		pCha->SetGuildName( buf[1].c_str() );
		pCha->SetGuildMotto( buf[2].c_str() );
		return true;
	}else
	{
		return false;
	}
}
char CTableGuild::GetTypeByID(uLong guildid)
{
	string buf[3];
	//char filter[80];

	//char*param	="type, guild_name, motto";
	//sprintf(filter, "guild_id =%d",guildid);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",guildid);

	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 3, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 3, "{CALL dbo.GetTypeByID(?)}", "dbo", "GetTypeByID", &l_retrow, 1, &guildid);
	if(l_retrow ==1)
	{
		return atoi(buf[0].c_str());
	}else
	{
		return -1;
	}
}
bool CTableGuild::ListTryPlayer(CCharacter* pCha, char disband_days)
{
	bool ret = false;

	if(!pCha || !pCha->HasGuild())
	{
		return ret;
	}

	string buf[10];
	//char filter[80];

	//const char *sql_syntax =
	//		"g.guild_id, g.guild_name,g.motto, g.type, g.stat, c.cha_name, g.member_total,g.exp,g.money,\
				case when g.stat>0 then %d*24*60 -DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end disband_time1\
			";
	//char param[500];
	//sprintf(param , sql_syntax , disband_days);
	//_snprintf_s(param,sizeof(param),_TRUNCATE,sql_syntax , disband_days);

	//string	l_tbl_name =_tbl_name;
	//_tbl_name	="character c,guild g";
	//sprintf(filter, "g.leader_id =c.cha_id and g.guild_id =%d",pCha->GetGuildID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "g.leader_id =c.cha_id and g.guild_id =%d",pCha->GetGuildID());

	int	 l_retrow =0;
	const DWORD parameter1 = pCha->GetGuildID();
	//bool l_ret = _get_row(buf, 10, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 10, "{CALL dbo.ListTryPlayer1(?,?)}", "dbo", "ListTryPlayer1", &l_retrow, 2, &disband_days, &parameter1);
	//_tbl_name	=l_tbl_name;

	if(!l_ret || !l_retrow || this->get_affected_rows() !=1)
	{
		return ret;
	}
	WPACKET		l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk, CMD_MC_GUILD_LISTTRYPLAYER);
	WRITE_LONG(l_wpk,	atol(buf[0].c_str()));	//guild_id
	WRITE_STRING(l_wpk,		 buf[1].c_str());	//guild_name
	WRITE_STRING(l_wpk,		 buf[2].c_str());	//motto
	WRITE_CHAR(l_wpk,	atoi(buf[3].c_str()));	//type
	WRITE_CHAR(l_wpk,	atoi(buf[4].c_str()));	//stat
	WRITE_STRING(l_wpk,		 buf[5].c_str());	//cha_name
	WRITE_SHORT(l_wpk,	atoi(buf[6].c_str()));	//member_total
	WRITE_SHORT(l_wpk,	emMaxMemberNum);		//����Ա��
	LLong	l_money	=_atoi64(buf[7].c_str());
	WRITE_LONG(l_wpk,uLong(l_money%0x100000000));	//money��λ
	WRITE_LONG(l_wpk,uLong(l_money/0x100000000));	//moeny��λ
	LLong	l_exp	=_atoi64(buf[8].c_str());
	WRITE_LONG(l_wpk,uLong(l_exp%0x100000000));		//exp��λ
	WRITE_LONG(l_wpk,uLong(l_exp/0x100000000));		//exp��λ
	WRITE_LONG(l_wpk,	atol(buf[9].c_str()));		//����ʱ����

	//sql_syntax =
	//	"select c.cha_id,c.cha_name,c.job,c.degree from character c\
			where (c.guild_stat =1 and c.guild_id =%d and c.delflag =0)";
	//char sql[SQL_MAXLEN];
	//sprintf(sql, sql_syntax, pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, sql_syntax, pCha->GetGuildID());


	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found = true;
	const char	sql[]	= "{CALL dbo.ListTryPlayer2(?)}";
	try
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

			throw 1;
		}
		// Time complexity to find in an unordered_map: O(1) (average).
		std::vector<SQLParamData>* cached_params = nullptr;
		auto					   cache		 = _cached_map.find(std::string("ListTryPlayer2"));
		if(cache == _cached_map.end())
		{
			// Procedure wasn't cached yet.
			cache_stored_procedure(1, "dbo", "ListTryPlayer2");
			cache = _cached_map.find(std::string("ListTryPlayer2"));

			if(cache != _cached_map.end())
			{
				cached_params = &(*cache).second;

			} else
			{
				LG2("util_db", "Could not find cached map for procedure: [%s]\n", "ListTryPlayer2");
				return false;
			}
		} else
		{
			cached_params = &(*cache).second;
		}

		// Time to bind parameters.
		for(SQLUSMALLINT i = 0; i < 1; i++)
		{
			if(!cached_params)
			{
				break;
			}
			SQLSMALLINT sql_data_type = cached_params->at(i).sql_data_type;
			SQLUINTEGER column_length = cached_params->at(i).column_length;
			const char* param_pointer = (const char*)&parameter1;

			sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, sql_data_type, column_length, 0,
									  (SQLPOINTER)param_pointer, 0, 0);

			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}
		}

		sqlret = SQLExecDirect(hstmt, (SQLCHAR*)sql, SQL_NTS);

		if(sqlret != SQL_SUCCESS)
		{
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);

			if(sqlret != SQL_SUCCESS_WITH_INFO)
				throw 2;
		}

		sqlret	= SQLNumResultCols(hstmt, &col_num);
		col_num = std::min<decltype(col_num)>(col_num, MAX_COL);
		col_num = std::min<decltype(col_num)>(col_num, _max_col);

		// Bind Column
		for(int i = 0; i < col_num; ++i)
		{
			SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
		}

		// Fetch each Row	int i; //
		int f_row = 0;
		for(f_row = 0; (sqlret = SQLFetch(hstmt)) == SQL_SUCCESS || sqlret == SQL_SUCCESS_WITH_INFO; ++f_row)
		{
			if(sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			}

			WRITE_LONG(l_wpk, atol((char const*)_buf[0])); //ID
			WRITE_STRING(l_wpk, (char const*)_buf[1]);	   //

			//
			//WRITE_STRING(l_wpk,(char const *)_buf[2]);		//
			WRITE_STRING(l_wpk, g_GetJobName(atoi((const char*)_buf[2])));

			WRITE_SHORT(l_wpk, atoi((char const*)_buf[3])); //
		}
		WRITE_LONG(l_wpk, f_row); //
		pCha->ReflectINFof(pCha, l_wpk);

		SQLFreeStmt(hstmt, SQL_UNBIND);
		ret = true;

	}
	catch(int& e)
	{
		LG("consortia system", "consult apply consortia process memeberODBC interface transfer error,position ID:%d\n", e);
	}
	catch (...) {

		LG("consortia system", "Unknown Exception raised when list all guilds\n");
	}
	return ret;
}
bool CTableGuild::Approve(CCharacter* pCha, uLong chaid)
{
	if(!pCha || !pCha->HasGuild())
	{
		return false;
	}

	string buf[3];
	//char filter[80];

	//char*param	="c.cha_id";
	//string	l_tbl_name =_tbl_name;
	//_tbl_name	="character c";
	//sprintf(filter, "c.cha_id =%d and c.guild_id =%d and c.guild_permission & %d =%d",pCha->GetID(),pCha->GetGuildID(),emGldPermMgr,emGldPermMgr);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "c.cha_id =%d and c.guild_id =%d and c.guild_permission & %d =%d",pCha->GetID(),pCha->GetGuildID(),emGldPermMgr,emGldPermMgr);
	// Same as dbo.Kick1
	int retrow =0;
	//bool l_ret = _get_row(buf, 3, param, filter, &retrow);
	//_tbl_name	=l_tbl_name;
	const DWORD parameter1 = pCha->GetID();
	const DWORD parameter2 = pCha->GetGuildID();
	const int	parameter3 = emGldPermMgr;
	bool		l_ret	   = _get_row_stored_procedure(buf, 3, "{CALL dbo.Kick1(?,?,?,?)}", "dbo", "Kick1", &retrow, 4, &parameter1, &parameter2, &parameter3, &parameter3);
	if(!l_ret)
	{
		//pCha->SystemNotice("��׼�����������ʧ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00043));
		return false;
	}
	if(!retrow)
	{
		//pCha->SystemNotice("��û�й���Ĺ���Ȩ��");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00044));
		return false;
	}

	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "��׼�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00045) );
		return false;
	}

	//char sql[SQL_MAXLEN];
	//sprintf(sql,"update guild\
	//				set try_total =try_total -1,\
	//					member_total =member_total +1\
	//					where guild_id =%d and member_total <%d and try_total > 0"
	//				,pCha->GetGuildID(),emMaxMemberNum);

	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update guild\
				set try_total =try_total -1,\
				member_total =member_total +1\
				where guild_id =%d and member_total <%d and try_total > 0"
	//			,pCha->GetGuildID(),emMaxMemberNum);

	const int parameter4 = emMaxMemberNum;
	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Approve2(?,?)}", "dbo", "Approve2", 2, &parameter2, &parameter4);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "��׼�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00046) );
		return false;
	}

	//sprintf(sql,	"update character set guild_stat =0,guild_permission =0\
	//					where cha_id =%d and guild_id =%d and guild_stat =1 and delflag =0",
	//					chaid, pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update character set guild_stat =0,guild_permission =0\
					where cha_id =%d and guild_id =%d and guild_stat =1 and delflag =0",
	//				chaid, pCha->GetGuildID());


	//l_sqlret =exec_sql_direct(sql);
	l_sqlret = stored_procedure("{CALL dbo.Approve3(?,?)}", "dbo", "Approve3", 2, &chaid, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "��׼�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00046) );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "��׼�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00046) );
		return false;
	}

	WPACKET	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MM_GUILD_APPROVE);
	WRITE_LONG(l_wpk,chaid);
	WRITE_LONG(l_wpk,pCha->GetGuildID());
	WRITE_CHAR(l_wpk,pCha->GetGuildType());
	WRITE_STRING(l_wpk,pCha->GetValidGuildName());
	WRITE_STRING(l_wpk,pCha->GetValidGuildMotto());
	pCha->ReflectINFof(pCha,l_wpk);

	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MP_GUILD_APPROVE);
	WRITE_LONG(l_wpk,chaid);
	pCha->ReflectINFof(pCha,l_wpk);
	return true;
}
bool CTableGuild::Reject(CCharacter* pCha, uLong chaid)
{
	if(!pCha || !pCha->HasGuild())
	{
		return false;
	}

	string buf[3];
	//char filter[80];

	//char*param	="c.cha_id";
	//string	l_tbl_name =_tbl_name;
	//_tbl_name	="character c";
	//sprintf(filter, "c.cha_id =%d and c.guild_id =%d and c.guild_permission & %d =%d",pCha->GetID(),pCha->GetGuildID(),emGldPermMgr,emGldPermMgr);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "c.cha_id =%d and c.guild_id =%d and c.guild_permission & %d =%d",pCha->GetID(),pCha->GetGuildID(),emGldPermMgr,emGldPermMgr);
	// Same as dbo.Kick1

	int retrow =0;
	//bool l_ret = _get_row(buf, 3, param, filter, &retrow);
	const DWORD parameter1 = pCha->GetID();
	const DWORD parameter2 = pCha->GetGuildID();
	const int	parameter3 = emGldPermMgr;
	bool l_ret = _get_row_stored_procedure(buf, 3, "{CALL dbo.Kick1(?,?,?,?)}", "dbo", "Kick1", &retrow, 4, &parameter1, &parameter2, &parameter3, &parameter3);
	if(!l_ret)
	{
		//pCha->SystemNotice("�ܾ������������ʧ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00047));
		return false;
	}
	if(!retrow)
	{
		//pCha->SystemNotice("��û�й���Ĺ���Ȩ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00048));
		return false;
	}

	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "��׼�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00045) );
		return false;
	}

	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
	//					where cha_id =%d and guild_id =%d and guild_stat =1",
	//			chaid, pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
					where cha_id =%d and guild_id =%d and guild_stat =1",
	//				chaid, pCha->GetGuildID());


	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Reject2(?,?)}", "dbo", "Reject2", 2, &chaid, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "�����ɫ���빫������ʧ��!��ȷ�ϸý�ɫ�����Ƿ��ѱ�ȡ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00049) );
		return false;
	}

	//sprintf(sql,"update guild set try_total =try_total -1 where guild_id =%d and try_total > 0"
	//	,pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update guild set try_total =try_total -1 where guild_id =%d and try_total > 0"
	//	,pCha->GetGuildID());
	

	//l_sqlret = exec_sql_direct(sql);
	l_sqlret = stored_procedure("{CALL dbo.Reject3(?)}", "dbo", "Reject3",1, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "�����ɫ���빫������ʧ��!��ȷ�ϸý�ɫ�����Ƿ��ѱ�ȡ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00049) );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "�����ɫ���빫������ʧ��!��ȷ�ϸý�ɫ�����Ƿ��ѱ�ȡ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00049)
 );
		return false;
	}

	WPACKET	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MM_GUILD_REJECT);
	WRITE_LONG(l_wpk,chaid);
	WRITE_STRING(l_wpk,pCha->GetGuildName());
	pCha->ReflectINFof(pCha,l_wpk);
	return true;
}
bool CTableGuild::Kick(CCharacter* pCha, uLong chaid)
{
	if(!pCha || !pCha->HasGuild())
	{
		return false;
	}

	string buf[3];
	//char filter[80];

	//char*param	="c.cha_id";
	//string	l_tbl_name =_tbl_name;
	//_tbl_name	="character c";
	//sprintf(filter, "c.cha_id =%d and c.guild_id =%d and c.guild_permission & %d =%d",pCha->GetID(),pCha->GetGuildID(),emGldPermMgr,emGldPermMgr);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "c.cha_id =%d and c.guild_id =%d and c.guild_permission & %d =%d",pCha->GetID(),pCha->GetGuildID(),emGldPermMgr,emGldPermMgr);

	int retrow =0;
	//bool l_ret = _get_row(buf, 3, param, filter, &retrow);
	const DWORD parameter1 = pCha->GetID();
	const DWORD parameter2 = pCha->GetGuildID();
	const int parameter3  = emGldPermMgr;
	bool l_ret	 = _get_row_stored_procedure(buf, 3, "{CALL dbo.Kick1(?,?,?,?)}", "dbo", "Kick1", &retrow, 4, &parameter1, &parameter2, &parameter3, &parameter3);
	if(!l_ret)
	{
		//pCha->SystemNotice("���˲���ʧ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00050));
		return false;
	}
	if(!retrow)
	{
		//pCha->SystemNotice("��û�й���Ĺ���Ȩ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00048));
		return false;
	}

	if( chaid == pCha->GetID() )
	{
		//pCha->SystemNotice( "���ǻ᳤�������߳��Լ�!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00051) );
		return false;
	}

	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "��������Ա�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00052)
 );
		return false;
	}

	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
	//					where cha_id =%d and guild_id =%d and guild_stat =0 and\
	//							cha_id not in(select leader_id from guild where guild_id =%d)",
	//			chaid, pCha->GetGuildID(), pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
					where cha_id =%d and guild_id =%d and guild_stat =0 and\
					cha_id not in(select leader_id from guild where guild_id =%d)",
	//				chaid, pCha->GetGuildID(), pCha->GetGuildID());


	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Kick2(?,?)}", "dbo", "Kick2", 2, &chaid, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "�����ɫ�����Ա����ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00053) );
		return false;
	}

	//sprintf(sql,	"update guild set member_total =member_total -1 where guild_id =%d",pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set member_total =member_total -1 where guild_id =%d",pCha->GetGuildID());
	// Same as dbo.Leave2

	//l_sqlret = exec_sql_direct(sql);
	l_sqlret = stored_procedure("{CALL dbo.Leave2(?)}", "dbo", "Leave2", &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "�����ɫ�����Ա����ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00053) );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "�����ɫ�����Ա����ʧ�ܣ����Ժ�����!" );
        pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00053) );		
		return false;
	}

	WPACKET	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MM_GUILD_KICK);
	WRITE_LONG(l_wpk,chaid);
	WRITE_STRING(l_wpk,pCha->GetGuildName());
	pCha->ReflectINFof(pCha,l_wpk);

	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MP_GUILD_KICK);
	WRITE_LONG(l_wpk,chaid);
	pCha->ReflectINFof(pCha,l_wpk);

	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MC_GUILD_KICK);
	pCha->ReflectINFof(pCha,l_wpk);

	return true;
}
bool CTableGuild::Leave(CCharacter* pCha)
{
	if(!pCha || !pCha->HasGuild())
	{
		return false;
	}

	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "�뿪�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00054) );
		return false;
	}

	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
	//					where cha_id =%d and guild_id =%d and guild_stat =0 and\
	//							cha_id not in(select leader_id from guild where guild_id =%d)",
	//			pCha->GetID(), pCha->GetGuildID(), pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
					where cha_id =%d and guild_id =%d and guild_stat =0 and\
					cha_id not in(select leader_id from guild where guild_id =%d)",
	//				pCha->GetID(), pCha->GetGuildID(), pCha->GetGuildID());
	const DWORD parameter1 = pCha->GetID();
	const DWORD parameter2 = pCha->GetGuildID();

	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Leave1(?,?)}", "dbo", "Leave1", 2, &parameter1, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "�뿪��ǰ����ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00055) );
		return false;
	}

	//sprintf(sql,	"update guild set member_total =member_total -1 where guild_id =%d",pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set member_total =member_total -1 where guild_id =%d",pCha->GetGuildID());

	//l_sqlret = exec_sql_direct(sql);
	l_sqlret = stored_procedure("{CALL dbo.Leave2(?)}", "dbo", "Leave2", 1, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "�뿪��ǰ����ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00055) );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "�뿪��ǰ����ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00055) );
		return false;
	}

	pCha->SetGuildID( 0 );
	pCha->SetGuildType( 0 );
	pCha->SetGuildName( "" );
	pCha->SetGuildMotto( "" );
	pCha->SyncGuildInfo();
	//pCha->SystemNotice("�Ѿ��뿪����!");
	pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00056));

	WPacket l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MP_GUILD_LEAVE);
	pCha->ReflectINFof(pCha,l_wpk);

	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MC_GUILD_LEAVE);
	pCha->ReflectINFof(pCha,l_wpk);
	return true;
}
bool CTableGuild::Disband(CCharacter* pCha,cChar *passwd)
{ 
	if(!pCha || !pCha->HasGuild())
	{
		return false;
	}

	string buf[6];
	//char filter[80];
	//char*param	="challlevel";
	//sprintf(filter, "guild_id =%d", pCha->GetValidGuildID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d", pCha->GetValidGuildID());
	// Same as dbo.[HasGuildLevel]

	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 6, param, filter, &l_retrow);
	const DWORD parameter1 = pCha->GetValidGuildID();
	bool		l_ret	   = _get_row_stored_procedure(buf, 6, "{CALL dbo.HasGuildLevel(?)}", "dbo", "HasGuildLevel", &l_retrow, 1, &parameter1);
	if(l_retrow ==1)
	{
		if( atoi(buf[0].c_str()) > 0 )
		{
			//pCha->SystemNotice( "���ǹ�����ս����֮һ�����Խ�ɢ!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00057) );
			return false;
		}
		else
		{
			l_retrow = 0;
			//sprintf(filter, "challid =%d", pCha->GetValidGuildID());
			//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challid =%d", pCha->GetValidGuildID());
			// Same as Challenge4
			//bool l_ret = _get_row(buf, 6, param, filter, &l_retrow);
			bool l_ret = _get_row_stored_procedure(buf, 6, "{CALL dbo.Challenge4(?)}", "dbo", "Challenge4", &l_retrow, 1, &parameter1);
			if( !l_ret )
			{
				//pCha->SystemNotice( "��ȡ��Ĺ�����ս��Ϣʧ��!" );
				pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00058) );
				return false;
			}
			if( l_retrow >= 1 )
			{
				//pCha->SystemNotice( "������˹�����ս�����Խ�ɢ!" );
				pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00059) );
				return false;
			}
		}
	}
	else
	{
		//pCha->SystemNotice( "��ȡ��Ĺ�����ս������Ϣʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00060) );
		return false;
	}
	
	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "��ɢ�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00061) );
		return false;
	}

	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update guild set motto ='',passwd ='',leader_id =0,stat =0,money =0,exp =0,member_total =0,try_total =0\
	//					where guild_id =%d and passwd ='%s' and leader_id =%d",
	//					pCha->GetGuildID(), passwd, pCha->GetPlayer()->GetDBChaId());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set motto ='',passwd ='',leader_id =0,stat =0,money =0,exp =0,member_total =0,try_total =0\
					where guild_id =%d and passwd ='%s' and leader_id =%d",
	//				pCha->GetGuildID(), passwd, pCha->GetPlayer()->GetDBChaId());

	
	const DWORD parameter2 = pCha->GetGuildID();
	const DWORD parameter3 = pCha->GetPlayer()->GetDBChaId();
	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Disband3(?,?,?)}", "dbo", "Disband3", 3, &parameter2, passwd, &parameter3);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		pCha->SystemNotice( "�������벻�ԣ����ܽ�ɢ���ᣡ" );
		//pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00062) );
		return false;
	}

	//sprintf(sql,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
	//					where guild_id =%d",
	//			pCha->GetGuildID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
					where guild_id =%d",
	//				pCha->GetGuildID());

	//l_sqlret = exec_sql_direct(sql);
	l_sqlret = stored_procedure("{CALL dbo.Disband4(?)}", "dbo", "Disband4", 1, &parameter2);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "��ɢ�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00062) );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "��ɢ�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00062) );
		return false;
	}

	WPacket l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MP_GUILD_DISBAND);
	pCha->ReflectINFof(pCha,l_wpk);

	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MM_GUILD_DISBAND);
	WRITE_LONG(l_wpk,pCha->GetGuildID());
	pCha->ReflectINFof(pCha,l_wpk);

	return true;
}
bool CTableGuild::Motto(CCharacter* pCha,cChar *motto)
{
	if(!pCha || !pCha->HasGuild())
	{
		return false;
	}

	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update guild set motto ='%s'\
	//					where guild_id =%d and leader_id =%d",
	//			motto,pCha->GetGuildID(), pCha->GetID());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set motto ='%s'\
					where guild_id =%d and leader_id =%d",
	//				motto,pCha->GetGuildID(), pCha->GetID());

	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	const DWORD parameter1 = pCha->GetGuildID();
	const DWORD parameter2 = pCha->GetID();
	SQLRETURN	l_sqlret   = stored_procedure("{CALL dbo.Motto(?,?,?)}", "dbo", "Motto", 3, motto, &parameter1, &parameter2);
	if(!DBOK(l_sqlret))
	{
		//pCha->SystemNotice("�޸Ĺ�������������ʧ��.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00063));
		return false;	//��ͨSQL����
	}
	if(get_affected_rows() !=1)
	{
		//pCha->SystemNotice("ֻ�л᳤�����޸Ĺ���������.");
		pCha->SystemNotice(RES_STRING(GM_GAMEDB_CPP_00064));
		return false;
	}

	WPacket	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MM_GUILD_MOTTO);
	WRITE_LONG(l_wpk,pCha->GetGuildID());
	WRITE_STRING(l_wpk,motto);
	pCha->ReflectINFof(pCha,l_wpk);

	l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MP_GUILD_MOTTO);
	WRITE_STRING(l_wpk,motto);
	pCha->ReflectINFof(pCha,l_wpk);

	return true;
}

bool CTableGuild::CancelTryFor( CCharacter* pCha )
{
	//char sql[SQL_MAXLEN];
	
	if(!pCha)
	{
		return false;
	}
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
	//				where cha_id =%d ",pCha->GetID());

	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	const DWORD parameter = pCha->GetID();
	SQLRETURN	l_sqlret  = stored_procedure("{CALL dbo.CancelTryFor(?)}", "dbo", "CancelTryFor", 1, &parameter);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		return false;
	}
	return true;
}
bool CTableGuild::GetGuildName(long lGuildID, std::string& strGuildName)
{
	//char filter[80];

	//char*param	="guild_name";
	//sprintf(filter, "guild_id =%d",lGuildID);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",lGuildID);

	int	 l_retrow =0;
	bool l_ret	  = _get_row_stored_procedure(&strGuildName, 1, "{CALL dbo.GetGuildName(?)}", "dbo", "GetGuildName", &l_retrow, 1, &lGuildID);
	if(l_ret)
	{
		return l_ret;
	}
	LG("stored_procedure", "GetGuildName failed, parameter: %d", lGuildID);
	return l_ret;
}

bool CTableGuild::Leizhu( CCharacter* pCha, BYTE byLevel, DWORD dwMoney )
{
	if(!pCha || !pCha->HasGuild() || byLevel < 1 || byLevel > 3 )
	{
		return false;
	}

	if( dwMoney == 0 )
	{
		//pCha->SystemNotice( "����������Ͷ����������0��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00065) );
		return false;
	}

	string buf[6];
	//char filter[80];
	//char*param1	="guild_id, guild_name, challid, challmoney, leader_id, challstart";
	// Same as ListChallenge1
	const DWORD parameter = pCha->GetValidGuildID();
	if( parameter > 0 )
	{
		//sprintf(filter, "guild_id =%d", pCha->GetValidGuildID());
		
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d", pCha->GetValidGuildID());

		int	 l_retrow =0;
		//bool l_ret = _get_row(buf, 6, param1, filter, &l_retrow);
		bool l_ret = _get_row_stored_procedure(buf, 6, "{CALL dbo.ListChallenge1(?)}", "dbo", "ListChallenge1", &l_retrow, 1, &parameter);
		if(l_retrow ==1)
		{
			if( pCha->GetID() == atoi(buf[4].c_str()) )
			{
				// �ǹ���᳤��ѯ					
			}
			else
			{
				return false;
			}
		}
		else
		{
			//pCha->SystemNotice( "��ѯ���Ĺ�����Ϣʧ��!���Ժ�����!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00066) );
			return false;
		}

		//sprintf(filter, "challid =%d", pCha->GetValidGuildID());
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challid =%d", pCha->GetValidGuildID());
		// same as dbo.Challenge2

		//l_ret = _get_row(buf, 6, param1, filter, &l_retrow);
		l_ret = _get_row_stored_procedure(buf, 6, "{CALL dbo.Challenge2(?)}", "dbo", "Challenge2", &l_retrow, 1, &parameter);
		if(l_retrow >=1)
		{
			//pCha->SystemNotice( "��ÿ��ֻ����սһ�����ᣬ���Ѿ��ǹ��ᡶ%s������ս��^_^!", buf[1].c_str() );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00067), buf[1].c_str() );
			return false;
		}
	}
	else
	{
		return false;
	}

	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "��ս�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00068));
		return false;
	}

	//char sql[SQL_MAXLEN];
	char  szGuild[64];
	memset( szGuild, 0, 64 );
	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	//char*param	="guild_id, guild_name, challid, challmoney";
	//sprintf(filter, "challlevel =%d",byLevel);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challlevel =%d",byLevel);
	// Same as ListChallenge2 (ignoring last parameters at the end)
	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 4, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 4, "{CALL dbo.ListChallenge2(?)}", "dbo", "ListChallenge2", &l_retrow, 1, &byLevel);
	if(l_retrow ==1)
	{
		//pCha->SystemNotice( "���ᡶ%s���Ѿ���������%d������!", buf[1].c_str(), byLevel );
		//pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00069), buf[1].c_str(), byLevel );
		char szData[128];
		CFormatParameter param(2);
		param.setString( 0, buf[1].c_str() );
		param.setDouble( 1, byLevel );
		RES_FORMAT_STRING( GM_GAMEDB_CPP_00069, param, szData );
		pCha->SystemNotice( szData );
		return false;
	}
	else
	{
		//char*param1	="challlevel";
		//sprintf(filter, "guild_id =%d",pCha->GetValidGuildID());
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",pCha->GetValidGuildID());
		// same as dbo.Challenge4
		//bool l_ret = _get_row(buf, 4, param1, filter, &l_retrow);
		const DWORD parameter2 = pCha->GetValidGuildID();
		bool		l_ret	   = _get_row_stored_procedure(buf, 4, "{CALL dbo.Challenge4(?)}", "dbo", "Challenge4", &l_retrow, 1, &parameter2);
		if(l_retrow ==1)
		{
			if( atoi(buf[0].c_str()) > 0 )
			{
				//pCha->SystemNotice( "���Ĺ����Ѿ���������%d��������!", atoi(buf[0].c_str()) );
				pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00070), atoi(buf[0].c_str()) );
				return false;
			}
		}

		DWORD dwMoneyArray[3] = { 5000000, 3000000, 1000000 };
		if( dwMoney < dwMoneyArray[byLevel-1] || !pCha->HasMoney( dwMoney ) )
		{
			//pCha->SystemNotice( "����������%d�Ĺ���ƺ���Ҫ��%uG��!", byLevel, dwMoneyArray[byLevel-1] );
			//pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00071), byLevel, dwMoneyArray[byLevel-1] );
			char szData[128];
			CFormatParameter param(2);
			param.setDouble( 0, byLevel );
			param.setLong( 1, dwMoneyArray[byLevel-1] );
			RES_FORMAT_STRING( GM_GAMEDB_CPP_00071, param, szData );
			pCha->SystemNotice( szData );
			return false;
		}

		//sprintf(sql,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
		//	byLevel, pCha->GetValidGuildID() );
		//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
		//	byLevel, pCha->GetValidGuildID() );
		// Same as ChallWin2
		//SQLRETURN l_sqlret =exec_sql_direct(sql);
		SQLRETURN l_sqlret = stored_procedure("{CALL dbo.ChallWin2(?,?)}", "dbo", "ChallWin2", 2, &byLevel, &parameter2);
		if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
		{
			this->rollback();
			//LG( "��ս����", "��ս��������������ܣ�����ʧ�ܹ���ս�ù������ݲ���ʧ��!���᲻����!����ID = %d.����������%d", pCha->GetValidGuildID(), byLevel );
			LG( "challenge consortia", "challenge consortia over,leizhu failed:update lost consortia data operater failed! consortiaID = %d.consortia level:%d", pCha->GetValidGuildID(), byLevel );
			return false;
		}

		if( !commit_tran() )
		{
			this->rollback();
			//pCha->SystemNotice( "�������ݲ���ʧ�ܣ����Ժ�����!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00072) );
			return false;
		}
		//if( pCha->TakeMoney( "ϵͳ", dwMoney ) )
		if( pCha->TakeMoney( RES_STRING(GM_GAMEDB_CPP_00073), dwMoney ) )
		{
			//pCha->SystemNotice( "��ϲ��Ĺ��ᡶ%s�������������%d����ĳƺ�!", pCha->GetGuildName(), byLevel );			
			//pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00074), pCha->GetGuildName(), byLevel );			
			char szData[128];
			CFormatParameter param(2);
			param.setString( 0, pCha->GetGuildName() );
			param.setDouble( 1, byLevel );
			RES_FORMAT_STRING( GM_GAMEDB_CPP_00074, param, szData );
			pCha->SystemNotice( szData );

		}
		this->ListChallenge( pCha );		
	}
	return true;
}

bool CTableGuild::Challenge( CCharacter* pCha, BYTE byLevel, DWORD dwMoney )
{
	if(!pCha || !pCha->HasGuild() || byLevel < 1 || byLevel > 3 )
	{
		return false;
	}

	if( dwMoney == 0 )
	{
		//pCha->SystemNotice( "��ս����Ͷ����������0��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00075) );
		return false;
	}

	string buf[6];
	//char filter[80];
	//char*param1	="guild_id, guild_name, challid, challmoney, leader_id, challstart";
	// Same as ListChallenge1.
	if( pCha->GetValidGuildID() > 0 )
	{
		//sprintf(filter, "guild_id =%d", pCha->GetValidGuildID());
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d", pCha->GetValidGuildID());

		int	 l_retrow =0;
		//bool l_ret = _get_row(buf, 6, param1, filter, &l_retrow);
		const DWORD parameter = pCha->GetValidGuildID();
		bool		l_ret	  = _get_row_stored_procedure(buf, 6, "{CALL dbo.ListChallenge1(?)}", "dbo", "ListChallenge1", &l_retrow, 1, &parameter);
		if(l_retrow ==1)
		{
			if( pCha->GetID() == atoi(buf[4].c_str()) )
			{
				// �ǹ���᳤��ѯ					
			}
			else
			{
				return false;
			}
		}
		else
		{
			//pCha->SystemNotice( "��ѯ���Ĺ�����Ϣʧ��!���Ժ�����!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00066));
			return false;
		}

		//sprintf(filter, "challid =%d", pCha->GetValidGuildID());
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challid =%d", pCha->GetValidGuildID());

		//l_ret = _get_row(buf, 6, param1, filter, &l_retrow);
		l_ret = _get_row_stored_procedure(buf, 6, "{CALL dbo.Challenge2(?)}", "dbo", "Challenge2", &l_retrow, 1, &parameter);
		if(l_retrow >=1)
		{
			//pCha->SystemNotice( "��ÿ��ֻ����սһ�����ᣬ���Ѿ��ǹ��ᡶ%s������ս��^_^!", buf[1].c_str() );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00067), buf[1].c_str() );
			return false;
		}
	}
	else
	{
		return false;
	}

	// ��ʼ����
	if( !begin_tran() )
	{
		//pCha->SystemNotice( "��ս�������ݲ���ʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00068));
		return false;
	}

	//char sql[SQL_MAXLEN];
	char  szGuild[64];
	memset( szGuild, 0, 64 );
	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	//char*param	="guild_id, guild_name, challid, challmoney";
	//sprintf(filter, "challlevel =%d",byLevel);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challlevel =%d",byLevel);
	// Same as ListChallenge2, with less parameters but it's okay.

	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 4, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 4, "{CALL dbo.ListChallenge2(?)}", "dbo", "ListChallenge2", &l_retrow, 1, &byLevel);
	if(l_retrow ==1)
	{
		dwGuildID = atoi(buf[0].c_str());
		//strncpy( szGuild, buf[1].c_str(), 63 );
		strncpy_s( szGuild, sizeof(szGuild), buf[1].c_str(), _TRUNCATE );
		dwChallID = atoi(buf[2].c_str());
		dwChallMoney = atoi(buf[3].c_str());
	}else
	{
		DWORD dwMoneyArray[3] = { 5000000, 3000000, 1000000 };
		if( dwMoney < dwMoneyArray[byLevel-1] || !pCha->HasMoney( dwMoney ) )
		{
			//pCha->SystemNotice( "����������%d�Ĺ���ƺ���Ҫ��%uG��!", byLevel, dwMoneyArray[byLevel-1] );
			//pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00077), byLevel, dwMoneyArray[byLevel-1] );
			char szData[128];
			CFormatParameter param(2);
			param.setDouble( 0, byLevel );
			param.setLong( 1, dwMoneyArray[byLevel-1] );
			RES_FORMAT_STRING( GM_GAMEDB_CPP_00077, param, szData );
			pCha->SystemNotice( szData );
			return false;
		}

		//sprintf(sql,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
		//	byLevel, pCha->GetValidGuildID() );
		//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
		//	byLevel, pCha->GetValidGuildID() );
		// Same as dbo.ChallWin2

		//SQLRETURN l_sqlret =exec_sql_direct(sql);
		const DWORD parameter2 = pCha->GetValidGuildID();
		SQLRETURN	l_sqlret   = stored_procedure("{CALL dbo.ChallWin2(?,?)}", "dbo", "ChallWin2", 2, &byLevel, &parameter2);
		if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
		{
			this->rollback();
			//LG( "��ս����", "��ս��������������ܣ�����ʧ�ܹ���ս�ù������ݲ���ʧ��!���᲻����!����ID = %d.����������%d", pCha->GetValidGuildID(), byLevel );
			LG( "challenge consortia", "challenge consortia over,leizhu failed:update lost consortia data operater failed! consortiaID = %d.consortia level:%d", pCha->GetValidGuildID(), byLevel );
			return false;
		}

		if( !commit_tran() )
		{
			this->rollback();
			//pCha->SystemNotice( "�������ݲ���ʧ�ܣ����Ժ�����!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00072) );
			return false;
		}
		//if( pCha->TakeMoney( "ϵͳ", dwMoney ) )
		if( pCha->TakeMoney( RES_STRING(GM_GAMEDB_CPP_00073), dwMoney ) )
		{
			//pCha->SystemNotice( "��ϲ��Ĺ��ᡶ%s�������������%d����ĳƺ�!", pCha->GetGuildName(), byLevel );			
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00074), pCha->GetGuildName(), byLevel );			
			char szData[128];
			CFormatParameter param(2);
			param.setString( 0, pCha->GetGuildName());
			param.setDouble( 1, byLevel );
			RES_FORMAT_STRING( GM_GAMEDB_CPP_00074, param, szData );
		}
		this->ListChallenge( pCha );
		return true;
	}

	BYTE byLvData = 0;
	//char*param2	="challlevel";
	//sprintf(filter, "guild_id =%d", pCha->GetValidGuildID() );
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d", pCha->GetValidGuildID() );
	

	//l_ret = _get_row(buf, 4, param2, filter, &l_retrow);
	const DWORD parameter3 = pCha->GetValidGuildID();
	l_ret				   = _get_row_stored_procedure(buf, 4, "{CALL dbo.Challenge4(?)}", "dbo", "Challenge4", &l_retrow, 1, &parameter3);
	if(l_retrow ==1)
	{
		byLvData = (BYTE)atoi(buf[0].c_str());
	}else
	{
		//pCha->SystemNotice( "��ѯ��Ĺ���������Ϣʧ��!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00078) );
		return false;
	}

	if( dwGuildID == 0 )
	{
		//pCha->SystemNotice( "������������!GID = %d, LV = %d", dwGuildID, byLevel );
		//pCha->SystemNotice( RES_STRING(	), dwGuildID, byLevel );
		char szData[128];
		CFormatParameter param(2);
		param.setLong( 0, dwGuildID );
		param.setDouble( 1, byLevel );
		RES_FORMAT_STRING( GM_GAMEDB_CPP_00079, param, szData );
		pCha->SystemNotice( szData );
		return false;
	}

	if( byLvData != 0 && byLevel > byLvData )
	{
		//pCha->SystemNotice( "��������ս���������ǹ���͵Ĺ���!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00080) );
		return false;
	}

	if( pCha->GetPlayer()->GetDBChaId() == dwChallID )
	{
		//pCha->SystemNotice( "���Ѿ��ǹ���ս����ս����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00081) );
		return false;
	}
	else if( pCha->GetValidGuildID() == dwGuildID )
	{
		//pCha->SystemNotice( "��������ս�Լ��Ĺ���!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00082) );
		return false;
	}
	else if( dwMoney < dwChallMoney + 50000 )
	{
		//pCha->SystemNotice( "������ս����!��%u��", dwMoney );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00083), dwMoney );
		return false;
	}

	if( !pCha->HasMoney( dwMoney ) )
	{
		//pCha->SystemNotice( "��Ͷ��ʧ�ܣ�û���㹻�ý�Ǯ!��%u��", dwMoney );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00084), dwMoney );
		return false;
	}

	// �����µ���ս����	
	//sprintf(sql,	"update guild set challid =%d,challmoney =%d where guild_id =%d \
	//				and challmoney < %d and challstart = 0",
	//			pCha->GetGuildID(), dwMoney, dwGuildID, dwMoney );
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challid =%d,challmoney =%d where guild_id =%d \
	//				and challmoney < %d and challstart = 0",
	//				pCha->GetGuildID(), dwMoney, dwGuildID, dwMoney );


	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	const DWORD parameter4 = pCha->GetGuildID();
	SQLRETURN	l_sqlret   = stored_procedure("{CALL dbo.Challenge5(?,?,?,?)}", "dbo", "Challenge5", 4,
											  &parameter4, &dwMoney, &dwGuildID, &dwMoney);

	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//pCha->SystemNotice( "��ս�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00085) );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//pCha->SystemNotice( "��ս�������ʧ�ܣ����Ժ�����!" );
		pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00085) );
		return false;
	}

	// ��Ǯ
	//pCha->TakeMoney( "ϵͳ", dwMoney );
	pCha->TakeMoney(RES_STRING(GM_GAMEDB_CPP_00073), dwMoney );
	// ��֮ǰ����ս�����Ǯ����ȥ
	if( dwChallID > 0 && dwChallMoney > 0 )
	{
		WPacket	l_wpk	=GETWPACKET();
		WRITE_CMD(l_wpk,CMD_MP_GUILD_CHALLMONEY);
		WRITE_LONG(l_wpk, dwChallID);
		WRITE_LONG(l_wpk, dwChallMoney);
		WRITE_STRING( l_wpk, szGuild );
		WRITE_STRING( l_wpk, pCha->GetGuildName() );
		pCha->ReflectINFof(pCha,l_wpk);		
	}

	ListChallenge( pCha );
	return true;
}

void CTableGuild::ListChallenge( CCharacter* pCha )
{
	string buf1[6];
	string buf2[6];
	//char filter[80];

	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	DWORD dwLeaderID = 0;
	BYTE  byStart = 0;

	WPacket l_wpk	=GETWPACKET();
	WRITE_CMD(l_wpk,CMD_MC_GUILD_LISTCHALL);

	//char*param	="guild_id, guild_name, challid, challmoney, leader_id, challstart";
	if( pCha->GetValidGuildID() > 0 )
	{
		//sprintf(filter, "guild_id =%d", pCha->GetValidGuildID());
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d", pCha->GetValidGuildID());

		int	 l_retrow =0;
		//bool l_ret = _get_row(buf1, 6, param, filter, &l_retrow);
		const auto parameter = pCha->GetValidGuildID();
		_get_row_stored_procedure(buf1, 6, "{CALL dbo.ListChallenge1(?)}", "dbo", "ListChallenge1", &l_retrow, 1, &parameter);
		if(l_retrow ==1)
		{
			if( pCha->GetID() == atoi(buf1[4].c_str()) )
			{
				// �ǹ���᳤��ѯ
				WRITE_CHAR( l_wpk, 1 );
			}
			else
			{
				WRITE_CHAR( l_wpk, 0 );
			}
		}
		else
		{
			//pCha->SystemNotice( "��ѯ���Ĺ�����Ϣʧ��!���Ժ�����!" );
			pCha->SystemNotice( RES_STRING(GM_GAMEDB_CPP_00066) );
			return;
		}
	}
	else
	{
		WRITE_CHAR( l_wpk, 0 );
	}

	for( int i = 1; i <= 3; ++i )
	{
		//sprintf(filter, "challlevel =%d", i);
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challlevel =%d", i);

		int	 l_retrow =0;
		//bool l_ret = _get_row(buf1, 6, param, filter, &l_retrow);
		bool	   l_ret	 = _get_row_stored_procedure(buf1, 6, "{CALL dbo.ListChallenge2(?)}", "dbo", "ListChallenge2", &l_retrow, 1, &i);
		if(l_retrow ==1)
		{			
			dwGuildID = atoi(buf1[0].c_str());
			dwChallID = atoi(buf1[2].c_str());
			dwChallMoney = atoi(buf1[3].c_str());
			byStart = (BYTE)atoi(buf1[5].c_str());
			
			if( dwChallID != 0 )
			{
				//sprintf(filter, "guild_id =%d", dwChallID);
				//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d", dwChallID);

				//bool l_ret = _get_row(buf2, 6, param, filter, &l_retrow);
				bool l_ret = _get_row_stored_procedure(buf1, 6, "{CALL dbo.ListChallenge1(?)}", "dbo", "ListChallenge1", &l_retrow, 1, &dwChallID);
				if(l_retrow ==1)
				{
					WRITE_CHAR( l_wpk, i );
					WRITE_CHAR( l_wpk, byStart );
					WRITE_STRING( l_wpk, buf1[1].c_str() );
					WRITE_STRING( l_wpk, buf2[1].c_str() );
					WRITE_LONG( l_wpk, dwChallMoney );
				}
				else
				{
					WRITE_CHAR( l_wpk, 0 );
				}
			}
			else
			{
				WRITE_CHAR( l_wpk, i );
				WRITE_CHAR( l_wpk, byStart );
				WRITE_STRING( l_wpk, buf1[1].c_str() );
				WRITE_STRING( l_wpk, "" );
				WRITE_LONG( l_wpk, dwChallMoney );
			}
		}
		else
		{
			WRITE_CHAR( l_wpk, 0 );
		}
	}
	pCha->ReflectINFof(pCha,l_wpk);
}

bool CTableGuild::HasGuildLevel( CCharacter* pChar, BYTE byLevel )
{
	if( !pChar->HasGuild() )
	{
		return false;
	}

	string buf[1];
	//char filter[80];
	BYTE byData = 0;
	//char*param	="challlevel";
	//sprintf(filter, "guild_id =%d",pChar->GetValidGuildID());
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE,"guild_id =%d",pChar->GetValidGuildID());

	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 1, param, filter, &l_retrow);
	const auto parameter = pChar->GetValidGuildID();
	bool l_ret = _get_row_stored_procedure(buf, 1, "{CALL dbo.HasGuildLevel(?)}", "dbo", "HasGuildLevel", &l_retrow, 1, &parameter);
	if(l_retrow ==1)
	{
		byData = (BYTE)atoi(buf[0].c_str());
		return byLevel == byData;
	}
	LG("stored_procedure", "Failed to get row from stored procedure: HasGuildLevel, parameter: %d\n", parameter);
	return false;
}

bool CTableGuild::HasCall( BYTE byLevel )
{
	string buf[5];
	//char filter[80];

	char  szGuild[64];
	memset( szGuild, 0, 64 );
	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	//char*param	="guild_id, guild_name, challid, challmoney, challstart";
	//sprintf(filter, "challlevel =%d",byLevel);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challlevel =%d",byLevel);

	int	 l_retrow =0;
	BYTE byStart = 0;
	//bool l_ret = _get_row(buf, 5, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 5, "{CALL dbo.HasCall(?)}", "dbo", "HasCall", &l_retrow, 1, &byLevel);
	if(l_retrow ==1)
	{
		dwGuildID = atoi(buf[0].c_str());
		//strncpy( szGuild, buf[1].c_str(), 63 );
		strncpy_s( szGuild, sizeof(szGuild), buf[1].c_str(), _TRUNCATE );
		dwChallID = atoi(buf[2].c_str());
		dwChallMoney = atoi(buf[3].c_str());
		byStart = (BYTE)atoi(buf[4].c_str());
		return dwChallID != 0 && byStart == 1;
	}
	return false;
}

bool CTableGuild::StartChall( BYTE byLevel )
{
	//LG( "��ս����", "���������%d��ս����ʼ����...\n", byLevel ); 
	LG( "challenge consortia", "range level %d challenge start treat with....\n", byLevel ); 
	string buf[4];
	//char filter[80];

	char  szGuild[64];
	memset( szGuild, 0, 64 );
	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	//char*param	="guild_id, guild_name, challid, challmoney";
	//sprintf(filter, "challlevel =%d",byLevel);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challlevel =%d",byLevel);

	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 4, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 4, "{CALL dbo.StartChall1(?)}", "dbo", "StartChall1", &l_retrow,1, &byLevel);
	if(l_retrow ==1)
	{
		dwGuildID = atoi(buf[0].c_str());
		//strncpy( szGuild, buf[1].c_str(), 63 );
		strncpy_s( szGuild, sizeof(szGuild), buf[1].c_str(), _TRUNCATE );
		dwChallID = atoi(buf[2].c_str());
		dwChallMoney = atoi(buf[3].c_str());
	}else
	{
		return false;
	}

	if( dwGuildID == 0 )
	{
		return false;
	}

	// �����µ���ս����
	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update guild set challstart = 1 where guild_id =%d and challstart = 0",
	//			dwGuildID );
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challstart = 1 where guild_id =%d and challstart = 0",
	//	dwGuildID );

	//SQLRETURN l_sqlret =exec_sql_direct(sql);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.ChallStart2(?)}", "dbo", "ChallStart2", 1, &dwGuildID);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		//LG( "��ս����", "��ս�������ݲ���ʧ��!����ս�Ѿ���ʼ���߹��᲻����!" );
		LG( "challenge consortia", "challenge consortia data operator failed!consortia battle already start or inexistence!" );
		return false;
	}

	//LG( "��ս����", "������%d������ս�ɹ���ʼ!GUILD1 = %d, GUILD2 = %d, Money = %u.\n", byLevel, dwGuildID, dwChallID, dwChallMoney );
	LG( "challenge consortia", "range level %d challenge start succeed !GUILD1 = %d, GUILD2 = %d, Money = %u.\n", byLevel, dwGuildID, dwChallID, dwChallMoney );
	return true;
}

void CTableGuild::EndChall( DWORD dwGuild1, DWORD dwGuild2, BOOL bChall )
{
	//LG( "��ս����", "����������ս����ʼ��������GUILD1 = %d, GUILD2 = %d...\n", dwGuild1, dwGuild2 ); 
	LG( "challenge consortia", "arranger level consortia game start operator finish GUILD1 = %d, GUILD2 = %d...\n", dwGuild1, dwGuild2 ); 
	string buf[5];
	//char filter[80];

	char  szGuild[64];
	memset( szGuild, 0, 64 );
	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	BYTE  byLevel = 0;
	BYTE  byStart = 0;
	//char*param	="challstart, guild_name, challid, challmoney, challlevel";
	//sprintf(filter, "guild_id =%d",dwGuild1);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",dwGuild1);

	int	 l_retrow =0;
	//bool l_ret = _get_row(buf, 5, param, filter, &l_retrow);
	bool l_ret = _get_row_stored_procedure(buf, 5, "{CALL dbo.EndChall(?)}", "dbo", "EndChall", &l_retrow, 1, &dwGuild1);
	if(l_retrow ==1)
	{
		byStart = (BYTE)atoi(buf[0].c_str());
		//strncpy( szGuild, buf[1].c_str(), 63 );
		strncpy_s( szGuild, sizeof(szGuild), buf[1].c_str(), _TRUNCATE );
		dwChallID = atoi(buf[2].c_str());
		dwChallMoney = atoi(buf[3].c_str());
		byLevel = (BYTE)atoi(buf[4].c_str());
		if( dwChallID == dwGuild2 )
		{
			ChallMoney( byLevel, bChall, dwGuild1, dwGuild2, dwChallMoney );
			//LG( "��ս����", "������%d������ս����!GUILD1 = %d, GUILD2 = %d, Money = %u.\n", byLevel, dwGuild1, dwGuild2, dwChallMoney );
			LG( "challenge consortia", "range level %d consortia challenge over!GUILD1 = %d, GUILD2 = %d, Money = %u.\n", byLevel, dwGuild1, dwGuild2, dwChallMoney );	
			return;
		}
	}

	//sprintf(filter, "guild_id =%d",dwGuild2);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",dwGuild2);

	//l_ret = _get_row(buf, 5, param, filter, &l_retrow);
	l_ret = _get_row_stored_procedure(buf, 5, "{CALL dbo.EndChall(?)}", "dbo", "EndChall", &l_retrow, 1, &dwGuild2);
	if(l_retrow ==1)
	{
		byStart = (BYTE)atoi(buf[0].c_str());
		//strncpy( szGuild, buf[1].c_str(), 63 );
		strncpy_s( szGuild, sizeof(szGuild), buf[1].c_str(), _TRUNCATE );
		dwChallID = atoi(buf[2].c_str());
		dwChallMoney = atoi(buf[3].c_str());
		byLevel = (BYTE)atoi(buf[4].c_str());
		if( dwChallID == dwGuild1 )
		{
			ChallMoney( byLevel, !bChall, dwGuild2, dwGuild1, dwChallMoney );
			//LG( "��ս����", "������%d������ս����!GUILD1 = %d, GUILD2 = %d, Money = %u.\n", byLevel, dwGuild2, dwGuild1, dwChallMoney );
			LG( "challenge consortia", "range level %d consortia challenge over!GUILD1 = %d, GUILD2 = %d, Money = %u.\n", byLevel, dwGuild2, dwGuild1, dwChallMoney );
			return;
		}
	}

	//LG( "��ս����", "������ս�������ʧ��!GUILD1 = %d, GUILD2 = %d, ChallFlag = %d.\n", dwGuild1, dwGuild2, ( bChall ) ? 1 : 0 ); 
	LG( "challenge consortia", "consortia challenge result disposal failed!GUILD1 = %d, GUILD2 = %d, ChallFlag = %d.\n", dwGuild1, dwGuild2, ( bChall ) ? 1 : 0 ); 
}

bool CTableGuild::ChallWin( BOOL bUpdate, BYTE byLevel, DWORD dwWinGuildID, DWORD dwFailerGuildID )
{
	// ��ʼ����
	if( !begin_tran() )
	{
		//LG( "��ս����", "��ս������������¹������ݿ�ʼ����ʧ��!" );
		LG( "challenge consortia", "challenge consortia finish,update consortia data start affair failed!" );
		return false;
	}

	// �����µ���ս����
	//char sql[SQL_MAXLEN];
	SQLRETURN l_sqlret;
	if( !bUpdate )
	{
		//sprintf(sql,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = 0 where guild_id =%d",
		//	dwFailerGuildID );
		//l_sqlret =exec_sql_direct(sql);
		//if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
		//{
		//	this->rollback();
		//	LG( "��ս����", "��ս�������������ʤ������ʧ�ܹ���ս�ù������ݲ���ʧ��!���᲻����!����ID = %d.����������%d", dwFailerGuildID, byLevel );
		//	return false;
		//}
	}
	else
	{
		string buf[5];
		//char filter[80];

		BYTE  byLvData = 0;
		//char*param	="challlevel";
		//sprintf(filter, "guild_id =%d",dwWinGuildID);
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "guild_id =%d",dwWinGuildID);

		int	 l_retrow =0;
		//bool l_ret = _get_row(buf, 5, param, filter, &l_retrow);
		bool l_ret	  = _get_row_stored_procedure(buf, 5, "{CALL dbo.ChallWin1(?)}", "dbo", "ChallWin1", &l_retrow,
												  1, &dwWinGuildID);
		if(l_retrow ==1)
		{
			byLvData = (BYTE)atoi(buf[0].c_str());
		}
		else
		{
			//LG( "��ս����", "��ս��������������ܣ���ѯʧ�ܹ����������Ϣʧ��!GUILDID = %d, WINID = %d.\n", dwFailerGuildID, dwWinGuildID );
			LG( "challenge consortia", "finish challenge consortia,leizhu failed:inquire about failed consortia level info failed!GUILDID = %d, WINID = %d.\n", dwFailerGuildID, dwWinGuildID );
			return false;
		}

		if( byLvData > 0 )
		{
			// ��������
			if( byLvData < byLevel )
			{
				BYTE byTemp = byLevel;
				byLevel = byLvData;
				byLvData = byTemp;
			}

			//sprintf(sql,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
			//	byLvData, dwFailerGuildID );
			//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
			//	byLvData, dwFailerGuildID );

			//l_sqlret =exec_sql_direct(sql);
			l_sqlret = stored_procedure("{CALL dbo.ChallWin2(?,?)}", "dbo", "ChallWin2", 2, &byLvData, &dwFailerGuildID);

			if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
			{
				this->rollback();
				//LG( "��ս����", "��ս��������������ܣ�����ʧ�ܹ���ս�ù������ݲ���ʧ��!���᲻����!����ID = %d.����������%d.\n", dwFailerGuildID, byLevel );
				LG( "challenge consortia", "challenge consortia over,leizhu failed:update lost consortia data operater failed! consortiaID = %d.consortia level:%d.\n",dwFailerGuildID, byLevel );
				return false;
			}
		}
		else
		{
			//sprintf(sql,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = 0 where guild_id =%d",
			//	dwFailerGuildID );
			//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = 0 where guild_id =%d",
			//	dwFailerGuildID );

			//l_sqlret =exec_sql_direct(sql);
			l_sqlret = stored_procedure("{CALL dbo.ChallWin3(?)}", "dbo", "ChallWin3", 1, &dwFailerGuildID);

			if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
			{
				this->rollback();
				//LG( "��ս����", "��ս��������������ܣ�����ʧ�ܹ���ս�ù������ݲ���ʧ��!���᲻����!����ID = %d.����������%d.\n", dwFailerGuildID, byLevel );
				LG( "challenge consortia", "challenge consortia over,leizhu failed:update lost consortia data operater failed! consortiaID = %d.consortia level:%d.\n",dwFailerGuildID, byLevel );
				return false;
			}
		}
	}

	//sprintf(sql,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
	//			byLevel, dwWinGuildID  );
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,	"update guild set challid = 0, challstart = 0, challmoney = 0, challlevel = %d where guild_id =%d",
	//	byLevel, dwWinGuildID  );
	
	//l_sqlret =exec_sql_direct(sql);
	l_sqlret = stored_procedure("{CALL dbo.ChallWin2(?,?)}", "dbo", "ChallWin2", 2, &byLevel, &dwWinGuildID);
	if( !DBOK( l_sqlret ) || get_affected_rows() == 0 )
	{
		this->rollback();
		//LG( "��ս����", "��ս�������������Ӯ�ù���ս�ù������ݲ���ʧ��!���᲻����!����ID = %d.����������%d.\n", dwWinGuildID, byLevel );
		LG( "challenge consortia", "challenge consortia over,update winner consortia data operator failed!inexistence consortia!consortiaID = %d.consortia level:%d.\n", dwWinGuildID, byLevel );
		return false;
	}

	if( !commit_tran() )
	{
		this->rollback();
		//LG( "��ս����", "��ս���������ύʧ�ܣ��Ժ�����!.\n" );
		LG( "challenge consortia", "challenge consortia data referring failed,retry later on\n" );
		return false;
	}
	return true;
}

void CTableGuild::ChallMoney( BYTE byLevel, BOOL bChall, DWORD dwGuildID, DWORD dwChallID, DWORD dwMoney )
{
	if( bChall )
	{
		//LG( "��ս������", "��սʧ�ܣ�ʤ����ID = %d, �ܷ���ID = %d, ��Ǯ��%u, ������%d.\n", dwGuildID, dwChallID, dwMoney, byLevel  );
		LG( "challenge consortia result", "challenge failed: winner:ID = %d,loser:ID = %d, money = %u,level:%d.\n", dwGuildID, dwChallID, dwMoney, byLevel  );
		if( !ChallWin( FALSE, byLevel, dwGuildID, dwChallID ) )
		{
			return;
		}

		if( dwChallID != 0 )
		{
			dwMoney = DWORD(float(dwMoney*80)/100);
			WPacket	l_wpk	=GETWPACKET();
			WRITE_CMD(l_wpk,CMD_MP_GUILD_CHALL_PRIZEMONEY);
			WRITE_LONG(l_wpk, dwGuildID);
			WRITE_LONG(l_wpk, dwMoney);
			SENDTOGROUP(l_wpk);
		}
	}
	else
	{
		//LG( "��ս������", "��ս�ɹ���ʤ����ID = %d, �ܷ���ID = %d, ��Ǯ��%u, ������%d.\n", dwChallID, dwGuildID, dwMoney, byLevel  );
		LG( "challenge consortia result", "challenge succeed:winner:ID = %d,loser:ID = %d, money = %u,level:%d.\n", dwChallID, dwGuildID, dwMoney, byLevel  );
		if( !ChallWin( TRUE, byLevel, dwChallID, dwGuildID ) )
		{
			return;
		}

		dwMoney = DWORD(float(dwMoney*80)/100);
		WPacket	l_wpk	=GETWPACKET();
		WRITE_CMD(l_wpk,CMD_MP_GUILD_CHALL_PRIZEMONEY);
		WRITE_LONG(l_wpk, dwChallID);
		WRITE_LONG(l_wpk, dwMoney);
		SENDTOGROUP(l_wpk);
	}
}

bool CTableGuild::GetChallInfo( BYTE byLevel, DWORD& dwGuildID1, DWORD& dwGuildID2, DWORD& dwMoney )
{
	string buf[3];
	//char filter[80];

	DWORD dwGuildID = 0;
	DWORD dwChallID = 0;
	DWORD dwChallMoney = 0;
	//char*param	="guild_id, challid, challmoney";
	//sprintf(filter, "challlevel =%d",byLevel);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "challlevel =%d",byLevel);
	int	  l_retrow = 0;
	bool sExec = _get_row_stored_procedure(buf, 3, "{CALL dbo.GetChallInfo(?)}", "dbo", "GetChallInfo",
								   &l_retrow,1, &byLevel);
	if( l_retrow == 1 )
	{
		dwGuildID1 = atoi(buf[0].c_str());
		dwGuildID2 = atoi(buf[1].c_str());
		dwMoney = atoi(buf[2].c_str());

		return true;
	}
	LG("stored_procedure", "Failed to get row from stored procedure: GetChallInfo, parameter: %d\n", byLevel);
	return false;
}

//===============CTableGuild End===========================================

//	2008-7-28	yyy	add	function	begin!

//	��¼���ߵ����߱���
bool	CTableItem::LockItem(	SItemGrid*	sig,	int	iChaId	)
{
	//
	char param[80];
	//sprintf(param, "TOP 1 id");
	_snprintf_s(param,sizeof(param),_TRUNCATE, "TOP 1 id");


	//
	char filter[80]; 
	//sprintf(filter, "ORDER BY id DESC");
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "ORDER BY id DESC");


	//
	std::string buf[1];

	int			r1 = 0;
	int			r = _get_rowOderby(buf, 1, param, filter, &r1);
	DWORD		dwDropertyID;

	if (DBOK(r) && r1 > 0)
	{
		dwDropertyID = atol( buf[0].c_str() ) + 1;
	}
	else
	{
		dwDropertyID = 1;
	}

	//	DBID�������ʾ��δ������
	if(	sig	&&	!sig->dwDBID	)
	{
		//	���õ��ߵ����ݿ�ID�š�
		sig->dwDBID	=	dwDropertyID;

		//	ת����ߴ���
		string	s;
		long	lnCheckSum	=	0;
			
		if(	SItemGrid2String(	s,	lnCheckSum,	sig,	0	)	)
		{
			//	д���ݿ����
			//sprintf( g_sql, "insert into property (	id,	cha_id,	context,	sum,	time	) values (	%d,	%d, '%s', %d,	getdate())",
			//	dwDropertyID,
			//	iChaId, 
			//	s.c_str(),
			//	lnCheckSum
			//	);
			_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "insert into property (	id,	cha_id,	context,	sum,	time	) values (	%d,	%d, '%s', %d,	getdate())",
				dwDropertyID,
				iChaId, 
				s.c_str(),
				lnCheckSum
				);

				short sExec = exec_sql_direct( g_sql );
				return	DBOK(sExec);
		};
	};

	//
	return	false;
};

//	2008-7-28	yyy	add	function	end!

// add by ning.yan 2008-11-12 ���߽��� begin
bool CTableItem::UnlockItem( SItemGrid* sig, int iChaId )
{
	if(sig)
	{
		//sprintf( g_sql, "update property set id = 0 where id =%d and cha_id =%d",sig->dwDBID, iChaId );
		//sprintf( g_sql, "delete from property where id =%d and cha_id =%d",sig->dwDBID, iChaId );
		_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "delete from property where id =%d and cha_id =%d",sig->dwDBID, iChaId );

		short sExec = exec_sql_direct( g_sql );
		sig->dwDBID = 0; // 0��ʾ����û������
		return DBOK(sExec);
	}
	return false;
}
// end

#ifdef SHUI_JING
BOOL CTableCrystalTrade::Init()
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE, "select \
				   cha_id, cha_name,act_name, BusinessID, Totalnum,crystal_num, crystal_price, createtime, tradetype, ishang, tempcoins\
				   from %s \
				   (nolock) where 1=2", \
				   _get_table());


	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		char buffer[255];
		//sprintf(buffer, RES_STRING(GM_GAMEDB_CPP_00001), "CrystalTrade");
		_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, RES_STRING(GM_GAMEDB_CPP_00001), "CrystalTrade");
		MessageBox(0,buffer, RES_STRING(GM_GAMEDB_CPP_00002), MB_OK);
		return false;
	}
	return true;
}

//��ȡ�����ҵ��б�
BOOL CTableCrystalTrade::GetCrystalBuyAndSaleList( std::vector<std::vector<string>>& dataBuyTrade, std::vector<std::vector<string>>& dataSaleTrade )
{
	const int NLIST = 5;
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"select top %d crystal_price,crystal_num from %s where tradetype = %d and ishang = %d order by crystal_price desc,crystal_num desc", NLIST, _get_table(), CrystalTradeType::enumbuy, CrystalTradeType::enumhang);

	if(!getalldata(g_sql, dataBuyTrade))
		return false;

	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"select top %d crystal_price,crystal_num from %s where tradetype = %d and ishang = %d order by crystal_price asc,crystal_num desc", NLIST, _get_table(), CrystalTradeType::enumsale, CrystalTradeType::enumhang);

	if(!getalldata(g_sql, dataSaleTrade))
		return false;
	return true;
}
//��ҹҵ�
BOOL CTableCrystalTrade::GetChaBuyAndSale( CCharacter* pCCha, std::vector<std::vector<string>>& chaTradeData )
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"select crystal_price, crystal_num, tradetype, tempcoins from %s where cha_id = %d and ishang = %d", _get_table(), pCCha->m_ID, CrystalTradeType::enumhang );

	if(!getalldata(g_sql, chaTradeData))
		return false;
	return true;
}

BOOL CTableCrystalTrade::IsHasBuyorSale( DWORD cha_id, CrystalTradeType::TradeType type )
{
	string buf[1];
	char filter[80];
	
	int isHang = 0;
	char* param = "ishang";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, " cha_id = %d and tradetype = %d ", cha_id, type );
	
	int l_retrow = 0;
	bool l_ret = _get_row(buf, 1, param, filter, &l_retrow);

	if( l_ret&&l_retrow>0 )
	{
		isHang = atoi(buf[0].c_str());
		if( isHang == 1 )
			return true;
	}
	return false;
}

BOOL CTableCrystalTrade::HangBuyTrade( CCharacter* pCCha, DWORD iCslPrice, DWORD iCslNum )
{
	string buf[1];
	char filter[255];
	DWORD	dwNeedMoney = iCslPrice * iCslNum;
	DWORD	dwFlatMoney = pCCha->GetFlatMoney();
	LLong	lpGD = pCCha->getAttr( ATTR_GD );
	//�鿴�Ƿ���ڸý�ɫ��Ĺҵ�
	char*param	="BusinessID";
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d and tradetype = %d ",pCCha->m_ID, CrystalTradeType::enumbuy );

	int	 l_retrow =0;
	bool l_ret = _get_row(buf, 1, param, filter, &l_retrow);
	if( l_ret )
	{
		if( l_retrow == 0 )
		{
			//�����ھͲ���һ���µ���
			_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "Insert into %s ( cha_id, cha_name, act_name, Totalnum, crystal_num, crystal_price, createtime, tradetype, ishang, tempcoins) \
															values (%d, '%s','%s', %d, %d, %d, getdate(), %d, %d, %d)",\
															_get_table(), pCCha->m_ID, pCCha->m_name, pCCha->GetPlayer()->GetActName(), iCslNum, iCslNum, iCslPrice, CrystalTradeType::enumbuy, CrystalTradeType::enumhang, dwNeedMoney );
			short sExec =  exec_sql_direct(g_sql);
			if (!DBOK(sExec))
			{
				LG("Crystal_msg","INSERT ActName: [%s],ChaName: [%s] Hang Buy Trade Failed! Num: (%lu), Price: (%lu), Total: (%lu) \n",
					pCCha->GetPlayer()->GetActName(),pCCha->m_name, iCslNum, iCslPrice, iCslNum*iCslPrice );
				return false;
			}
		}
		else if( l_retrow == 1)
		{
			//���ھ͸���
			_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "update %s set crystal_price = %d, Totalnum = %d, crystal_num = %d , ishang = %d,  createtime = getdate(),tempcoins = %d where cha_id = %d and tradetype = %d ", _get_table(), iCslPrice,
				iCslNum, iCslNum, CrystalTradeType::enumhang, dwNeedMoney, pCCha->m_ID, CrystalTradeType::enumbuy );
			short sExec =  exec_sql_direct(g_sql);
			if (!DBOK(sExec))
			{
				LG("Crystal_msg","UPDATE ActName: [%s],ChaName: [%s] Hang Buy Trade Failed! Num: (%lu), Price: (%lu), Total: (%lu) \n",
					pCCha->GetPlayer()->GetActName(),pCCha->m_name, iCslNum, iCslPrice, iCslNum*iCslPrice );
				return false;
			}
		}
		else
			return false;		
		//��Ǯ
		if( dwNeedMoney > dwFlatMoney )
		{
			pCCha->SetFlatMoney( 0 );
			pCCha->TakeMoney( pCCha->GetName(), dwNeedMoney-dwFlatMoney  );
		}
		else
		{
			pCCha->SetFlatMoney( dwFlatMoney - dwNeedMoney );
		}
		LG("Crystal_msg","ActName: [%s],ChaName: [%s] Hang Buy Trade Success! Num: (%lu), Price: (%lu), Total: (%lu) \n",
			pCCha->GetPlayer()->GetActName(),pCCha->m_name, iCslNum, iCslPrice, iCslNum*iCslPrice );
		return true;
	}
	return false;
}

BOOL CTableCrystalTrade::HangSaleTrade( CCharacter* pCCha, DWORD iCslPrice, DWORD iCslNum )
{
	string buf[1];
	char filter[255];
	DWORD	dwNeedMoney = iCslPrice * iCslNum;
	DWORD	dwFlatMoney = pCCha->GetFlatMoney();
	DWORD	dwrplMoney = pCCha->GetPlayer()->GetRplMoney();
	//�鿴�Ƿ���ڸý�ɫ���Ĺҵ�
	char*param	="BusinessID";
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d and tradetype = %d ",pCCha->m_ID, CrystalTradeType::enumsale );

	int	 l_retrow =0;
	bool l_ret = _get_row(buf, 1, param, filter, &l_retrow);
	if( l_ret )
	{
		if( l_retrow == 0 )
		{
			//�����ھͲ���һ���µ�����
			_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "Insert into %s ( cha_id, cha_name, act_name, Totalnum, crystal_num, crystal_price, createtime, tradetype, ishang, tempcoins) \
															values (%d, '%s', '%s', %d, %d, %d, getdate(), %d, %d, %d)",\
															_get_table(), pCCha->m_ID, pCCha->m_name, pCCha->GetPlayer()->GetActName(), iCslNum, iCslNum, iCslPrice, CrystalTradeType::enumsale, CrystalTradeType::enumhang, dwNeedMoney );
			short sExec =  exec_sql_direct(g_sql);
			if (DBOK(sExec))
			{
				return true;
			}
		}
		else if( l_retrow == 1)
		{
			//���ھ͸���
			_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "update %s set crystal_price = %d, Totalnum = %d, crystal_num = %d , ishang = %d,  createtime = getdate(),tempcoins = %d where cha_id = %d and tradetype = %d", _get_table(), iCslPrice,
				iCslNum, iCslNum, CrystalTradeType::enumhang, dwNeedMoney, pCCha->m_ID, CrystalTradeType::enumsale );
			short sExec =  exec_sql_direct(g_sql);
			if (DBOK(sExec))
			{
				return true;
			}
		}
	}
	return false;
}

BOOL CTableCrystalTrade::CrystalTradeCancel( CCharacter* pCCha, int type, DWORD& iCslNum, DWORD& iCslPrice )
{
	string buf[3];
	char filter[255];
	DWORD dwHangMoney = 0;
	char* param = "tempcoins,crystal_num,crystal_price";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, " cha_id = %d and ishang = %d and tradetype = %d ",pCCha->m_ID, CrystalTradeType::enumhang, type );
	int	 l_retrow =0;
	bool l_ret = _get_row(buf, 3, param, filter, &l_retrow);
	if( l_ret && l_retrow > 0 )
	{
		dwHangMoney = atoi(buf[0].c_str());
		iCslNum = atoi(buf[1].c_str());
		iCslPrice = atoi(buf[2].c_str());

		_snprintf_s( g_sql, sizeof(g_sql), _TRUNCATE, " update %s set Totalnum = %d, ishang = %d where cha_id = %d and tradetype = %d ",_get_table(), 0, CrystalTradeType::enumstart, pCCha->m_ID, type );
		short sExec =  exec_sql_direct(g_sql);
		if (DBOK(sExec))
		{
			return true;
		}
	}
	return false;
}

BOOL CTableCrystalTrade::CheckCrystalExchangeMoney( CCharacter *pCCha, DWORD iCslPrice, DWORD iCslNum, CrystalTradeType::TradeType type )
{
	string buf[1];
	char filter[80];
	
	DWORD dwHangMoney = 0;
	DWORD dwflatMoney = 0;

	DWORD dwNeedMoney = iCslPrice * iCslNum;
	char*param	="tempcoins";
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id = %d and ishang = %d ",pCCha->m_ID, CrystalTradeType::enumhang );

	int	 l_retrow =0;
	bool l_ret = _get_row(buf, 1, param, filter, &l_retrow);
	if( l_retrow < 2  )
	{
		dwHangMoney = atoi(buf[0].c_str());
		DWORD dwflatMoney = pCCha->GetFlatMoney();

		if( type == CrystalTradeType::enumbuy )
		{
			//�Ƿ�����㹻������
			if(  dwflatMoney < dwNeedMoney )
			{
				LLong pGD = pCCha->getAttr(ATTR_GD);
				if( dwflatMoney + pGD <  dwNeedMoney )
				{	
					return false;
				}
			}
			//���㹻Ǯ�����Ƿ�ҵ���������(��ˮ���õ���Ǯ+ƽ̨�ϵ�Ǯ)
			if( dwHangMoney + dwflatMoney > MAX_TRADE_MONEY )
			{
				return false;
			}
			return true;
		}
		else if( type == CrystalTradeType::enumsale )
		{
			DWORD pRplMoney = pCCha->GetPlayer()->GetRplMoney();
			if( pRplMoney < iCslNum )
			{
				return false;
			}
			if( (dwHangMoney + dwNeedMoney + dwflatMoney) > MAX_TRADE_MONEY )
			{
				return false;
			}
			return true;
		}
		else
			return false;
	}
	return false;
}
//���ȼ۸���ͬ��������ͬ����û�� û���򰴼۸���ͬ���������
BOOL CTableCrystalTrade::CheckHasAccordForTrade( DWORD& chaid, string& act_tName, DWORD iCslPrice, DWORD iCslNum, DWORD& dcslNum, CrystalTradeType::TradeType type )
{
	string bufhas[2];
	char filter[255];

	char* paramhas = "top 1 cha_id, act_name";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, "crystal_price = %d and tradetype = %d and  ishang = %d and crystal_num = %d order by createtime desc", iCslPrice, type , CrystalTradeType::enumhang, iCslNum );
	int l_retrow = 0;
	bool l_ret = _get_row(bufhas, 2, paramhas, filter, &l_retrow);
	if( l_ret && (l_retrow > 0 ) )
	{
		chaid = atoi(bufhas[0].c_str());
		act_tName = bufhas[1].c_str();
		dcslNum = iCslNum;
		return true;
	}
	else
	{
		string buf[3];
		char* param = "top 1 cha_id, act_name,crystal_num";
		_snprintf_s( filter, sizeof(filter), _TRUNCATE, "crystal_price = %d and tradetype = %d and  ishang = %d order by crystal_num desc", iCslPrice, type , CrystalTradeType::enumhang );

		int l_retrow = 0;
		bool l_ret = _get_row(buf, 3, param, filter, &l_retrow);
		if( l_ret && (l_retrow > 0 ) )
		{
			chaid = atoi(buf[0].c_str());
			act_tName = buf[1].c_str();
			dcslNum = atoi(buf[2].c_str());
			return true;
		}	
	}
	return false;
}
//��������û��ȫ����������
BOOL CTableCrystalTrade::CheckHasMatchAccord( DWORD& chaid, string& act_tName, DWORD iCslPrice, DWORD iCslNum, CrystalTradeType::TradeType type )
{
	string bufhas[2];
	char filter[255];
	char* paramhas = "top 1 cha_id, act_name";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, "crystal_price = %d and tradetype = %d and ishang = %d and crystal_num >= %d order by crystal_num desc", iCslPrice, type, CrystalTradeType::enumhang, iCslNum );
	int l_retrow = 0;
	bool l_ret = _get_row(bufhas, 2, paramhas, filter, &l_retrow);
	if( l_ret && ( l_retrow > 0 ))
	{
		chaid = atoi(bufhas[0].c_str());
		act_tName = bufhas[1].c_str();
		return true;
	}
	return false;
}

BOOL CTableCrystalTrade::UpdateHangTrade( char* actname, DWORD cha_id, DWORD dtradeMoney, CrystalTradeType::TradeType type, CrystalTradeType::TradeState state )
{

	if( state == CrystalTradeType::enumhang )
	{
		_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "update %s set crystal_num = crystal_num - %d, tempcoins =tempcoins-%d*crystal_price  where act_name = '%s' and tradetype = %d and cha_id = %d",_get_table(), dtradeMoney, dtradeMoney, actname, type, cha_id );
		short sExec =  exec_sql_direct(g_sql);
		if (!DBOK(sExec))
		{
			LG("Crystal_msg","UpdateHangTrade ActName: [%s], Cha_id: [%d] TradeType: [%d], subtract Crystal_Num :(%lu) Failed !\n", actname, cha_id, type, dtradeMoney );

			return false;
		}
		LG("Crystal_msg","UpdateHangTrade ActName: [%s], Cha_id: [%d] TradeType: [%d], subtract Crystal_Num :(%lu) Successed !\n", actname, cha_id, type, dtradeMoney );
		return true;
	}
	else if( (state == CrystalTradeType::enumend) || (state == CrystalTradeType::enumstart) )
	{
		_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "update %s set ishang =  %d where act_name = '%s' and tradetype = %d and cha_id = %d",_get_table(), state, actname, type, cha_id );
		short sExec =  exec_sql_direct(g_sql);
		if (!DBOK(sExec))
		{
			LG("Crystal_msg","UpdateHangTrade ActName: [%s], Cha_id: [%d] TradeType: [%d], Changed TradeState to state( %d ) Failed !\n ", actname, cha_id, type, state );
			return false;
		}
		LG("Crystal_msg","UpdateHangTrade ActName: [%s], Cha_id: [%d] TradeType: [%d], Changed TradeState to state( %d ) Successed !\n ", actname,cha_id, type, state );
		return true;
	}
	else
	{
		LG("Crystal_error","UpdateHangTrade ActName: [%s],Cha_id: [%d] Error type!\n", actname, cha_id );
		return false;
	}
}

BOOL CTableCrystalTrade::UpdateHangTradeForFailed( char* actname,DWORD cha_id,  DWORD dtradeMoney, CrystalTradeType::TradeType type, CrystalTradeType::TradeState state )
{
	if( state == CrystalTradeType::enumhang )
	{
		_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "update %s set crystal_num = crystal_num + %d, tempcoins =tempcoins+%d*crystal_price  where act_name = '%s' and tradetype = %d and cha_id = %d",_get_table(), dtradeMoney, dtradeMoney, actname, type, cha_id );
		short sExec =  exec_sql_direct(g_sql);
		if (!DBOK(sExec))
		{
			LG("Crystal_msg","UpdateHangTradeForFailed ActName: [%s], Cha_id: [%d] TradeType: [%d], subtract Crystal_Num :(%lu) Failed !\n", actname, cha_id, type, dtradeMoney );
			return false;
		}
		LG("Crystal_msg","UpdateHangTradeForFailed ActName: [%s], Cha_id: [%d] TradeType: [%d], subtract Crystal_Num :(%lu) Successed !\n", actname, cha_id, type, dtradeMoney );
		return true;
	}
	else if( (state == CrystalTradeType::enumend)||( state == CrystalTradeType::enumstart) )
	{
		_snprintf_s( g_sql, sizeof( g_sql ), _TRUNCATE, "update %s set ishang = %d where act_name = '%s' and tradetype = %d and cha_id = %d",_get_table(), CrystalTradeType::enumhang, actname, type, cha_id);
		short sExec =  exec_sql_direct(g_sql);
		if (!DBOK(sExec))
		{
			LG("Crystal_msg","UpdateHangTradeForFailed ActName: [%s], Cha_id: [%d] TradeType: [%d], Changed TradeState to state( %d ) Failed !\n ", actname, cha_id, type, CrystalTradeType::enumhang );
			return false;
		}
		LG("Crystal_msg","UpdateHangTradeForFailed ActName: [%s], Cha_id: [%d] TradeType: [%d], Changed TradeState to state( %d ) Successed !\n ", actname, cha_id, type, CrystalTradeType::enumhang );
		return true;
	}
	else
	{
		LG("Crystal_error","UpdateHangTrade ActName: [%s], Cha_id: [%d] Error type!\n", actname, cha_id );
		return false;
	}
}
//�������ͻ�ùҵ�����
BOOL CTableCrystalTrade::GetHangNum(CrystalTradeType::TradeType type, int &hangNum)
{
	string buf[1];
	char filter[80];
	//select count(BusinessID) from dbo.CrystalTrade where ishang = 1 and tradetype = 0
	char* param = "count(BusinessID)";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, "ishang = %d and tradetype = %d", CrystalTradeType::enumhang, type );

	int l_retrow = 0;
	bool l_ret = _get_row(buf, 1, param, filter, &l_retrow);
	if( l_ret && l_retrow >= 0 )
	{
		hangNum = atoi(buf[0].c_str());
		return true;
	}
	return false;
}
//�޸Ĺ��ڣ�һ�ܣ��˵�����ѯ�����������������޸�
BOOL CTableCrystalTrade::ResetCrystalState( std::vector<vector<string>>&dataHangTrade )
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"select top 10 cha_id, cha_name, act_name, tradetype, crystal_num, crystal_price from %s with(nolock) where ishang = %d and createtime < getdate() - 7 ", _get_table(), CrystalTradeType::enumhang );
	if(!getalldata(g_sql, dataHangTrade))
		return false;
	return true;
}
//��ʱ�޸Ĺҵ�״̬����ֹ�ڲ����˵�ʱ����Ҳ����ҵ�
BOOL CTableCrystalTrade::ChangeStateByTemp( DWORD cha_id, CrystalTradeType::TradeType type, CrystalTradeType::TradeState state  )
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"update %s set ishang = %d where cha_id = %d and tradetype = %d ", _get_table(), state, cha_id,  type );
	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		LG("Crystal_msg","ChangeStateByTemp Cha_id: [%d] TradeType: [%d], Changed TradeState to state( %d ) Failed !\n ", cha_id, type, state );
		return false;
	}
	LG("Crystal_msg","ChangeStateByTemp Cha_id: [%d] TradeType: [%d], Changed TradeState to state( %d ) Successed !\n ", cha_id, type, state );
	return true;
}
//ȡ��ͣ�Ĺҵ���Ϣ
BOOL CTableCrystalTrade::GetCrystalState(CCharacter *pCha, CrystalTradeType::TradeType type, CrystalTradeType::TradeState& state, DWORD& dwNum, DWORD& dwPrice, DWORD& totalnum)
{
	string buf[4];
	char filter[225];

	char* param = "crystal_num, crystal_price, Totalnum, ishang";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, "cha_id = %d and tradetype = %d ", pCha->GetID(), type );

	int l_retrow = 0;
	bool l_ret = _get_row(buf, 4, param, filter, &l_retrow);
	if( l_ret && l_retrow >0 )
	{
		dwNum = atoi(buf[0].c_str());
		dwPrice = atoi(buf[1].c_str());
		totalnum = atoi(buf[2].c_str());
		state = (CrystalTradeType::TradeState)atoi( buf[3].c_str());
		return true;
	}
	return false;

}

BOOL CTableCrystalTrade::ResetCrystalTotalNum( CCharacter* pCha, DWORD dwNum, CrystalTradeType::TradeType type )
{
	_snprintf_s(g_sql,sizeof(g_sql),_TRUNCATE,"update %s set Totalnum = %d where cha_id = %d and tradetype = %d ", _get_table(), dwNum, pCha->GetID(),  type );
	short sExec =  exec_sql_direct(g_sql);
	if (!DBOK(sExec))
	{
		LG("Crystal_msg","ResetCrystalTotalNum Cha_id: [%d], tradetype [%d] Totalnum to : [%d] Failed !\n ", pCha->GetID(), type, dwNum );
		return false;
	}
	LG("Crystal_msg","ResetCrystalTotalNum Cha_id: [%d], tradetype [%d] Totalnum to : [%d] Successed !\n ", pCha->GetID(), type, dwNum );
	return true;
}

#endif

CGameDB game_db;

CGameDBPool* CGameDBPool::_instance = NULL;

CGameDBPool* CGameDBPool::Instance(int size)
{
	if(_instance == NULL)
	{
		_instance = new CGameDBPool(size);
	}

	return _instance;
}

CGameDBPool::CGameDBPool(int size) : m_iIndex(0)
{
	for(int i=0;i<size;i++)
	{
		CGameDB* pDB = new CGameDB();
		pDB->Init();

		m_DBPool.push_back(pDB);
	}
}

CGameDBPool::~CGameDBPool()
{
	for(vector<CGameDB*>::iterator it = m_DBPool.begin(); it != m_DBPool.end(); it++)
	{
		if((*it) != NULL)
		{
			delete (*it);
		}
	}

	m_DBPool.clear();
}

CGameDB* CGameDBPool::GetGameDB()
{
	m_Lock.Lock();
	CGameDB* pDB = NULL;
	if(m_DBPool.size() > 0)
	{
		pDB = m_DBPool[m_iIndex++ % m_DBPool.size()];
	}
	m_Lock.Unlock();

	return pDB;
}