#include "Friend.h"
#include "Master.h"
#include "DBConnect.h"
#include "Guild.h"
#include "GroupServerApp.h"
#include "GameCommon.h"


SQLRETURN Exec_sql_direct(const char *pszSQL, cfl_rs *pTable)
{
	//LG("group_sql", "��[%s], ��ʼִ��SQL���[%s]\n", pTable->get_table(), pszSQL);
	LG("group_sql", "Table [%s], begin execute SQL [%s]\n", pTable->get_table(), pszSQL);
	SQLRETURN r = pTable->exec_sql_direct(pszSQL);
	if(DBOK(r))
	{
		//LG("group_sql", "�ɹ�ִ��SQL!\n");
		LG("group_sql", "execute SQL success!");
	}
	else if(DBNODATA(r))
	{
		//LG("group_sql", "ִ��SQL, ���޽������\n");
		LG("group_sql", "execute SQL, no result \n");
	}
	else
	{
		//LG("group_sql", "ִ��SQL, ����!\n");
		LG("group_sql", "execute SQL, failed!\n");
	}
	return r;
}

// Add by lark.li 20080808 begin
SQLRETURN Exec_sql(const char *pszSQL, char const* pdata, int len,  cfl_rs *pTable)
{
	//LG("group_sql", "��[%s], ��ʼִ��SQL���[%s]\n", pTable->get_table(), pszSQL);
	LG("group_sql", "Table [%s], begin execute SQL [%s]\n", pTable->get_table(), pszSQL);
	SQLRETURN r = pTable->exec_param_sql(pszSQL, pdata, len);
	if(DBOK(r))
	{
		//LG("group_sql", "�ɹ�ִ��SQL!\n");
		LG("group_sql", "execute SQL success!");
	}
	else if(DBNODATA(r))
	{
		//LG("group_sql", "ִ��SQL, ���޽������\n");
		LG("group_sql", "execute SQL, no result \n");
	}
	else
	{
		//LG("group_sql", "ִ��SQL, ����!\n");
		LG("group_sql", "execute SQL, failed!\n");
	}
	return r;
}
// End

//==========TBLSystem===============================
bool TBLAccounts::IsReady()
{
	char sql[SQL_MAXLEN];
	//strcpy(sql,"drop trigger [TR_D_Character_Friends]");
	strncpy_s(sql,sizeof(sql),"drop trigger [TR_D_Character_Friends]",_TRUNCATE);
	SQLRETURN l_ret =Exec_sql_direct(sql, this);
	if(!DBOK(l_ret))
	{
		LogLine l_line(g_LogDB);
		//l_line<<newln<<"SQL���:"<<sql<<"ִ��ʧ�ܣ�";
		l_line<<newln<<"SQL:"<<sql<<" execute failed !";
	}
	//strcpy(sql,"drop trigger [TR_I_Character]");
	strncpy_s(sql,sizeof(sql),"drop trigger [TR_I_Character]",_TRUNCATE);
	l_ret =Exec_sql_direct(sql, this);
	if(!DBOK(l_ret))
	{
		LogLine l_line(g_LogDB);
		//l_line<<newln<<"SQL���:"<<sql<<"ִ��ʧ�ܣ�";
		l_line<<newln<<"SQL:"<<sql<<" execute failed !";
	}
	//strcpy(sql,"CREATE TRIGGER TR_D_Character_Friends ON character \n\
	//			FOR DELETE \n\
	//			AS\n\
	//			BEGIN\n\
	//				declare @@stat tinyint\n\
	//				declare @@gid  int\n\
	//				select @@stat =guild_stat,@@gid =guild_id from deleted\n\
	//				DELETE friends where friends.cha_id1 IN(select cha_id from deleted)\n\
	//				if(@@gid >0)\n\
	//				BEGIN\n\
	//					update guild set try_total =try_total -(case when @@stat>0 then 1 else 0 end),\n\
	//							member_total =member_total -(case when @@stat >0 then 0 else 1 end)\n\
	//						where guild_id >0 and guild_id =@@gid\n\
	//				END\n\
	//			END\n\
	//	");
	strncpy_s(sql,sizeof(sql),"CREATE TRIGGER TR_D_Character_Friends ON character \n\
			   FOR DELETE \n\
			   AS\n\
			   BEGIN\n\
			   declare @@stat tinyint\n\
			   declare @@gid  int\n\
			   select @@stat =guild_stat,@@gid =guild_id from deleted\n\
			   DELETE friends where friends.cha_id1 IN(select cha_id from deleted)\n\
			   if(@@gid >0)\n\
			   BEGIN\n\
			   update guild set try_total =try_total -(case when @@stat>0 then 1 else 0 end),\n\
			   member_total =member_total -(case when @@stat >0 then 0 else 1 end)\n\
			   where guild_id >0 and guild_id =@@gid\n\
			   END\n\
			   END\n\
			   ",_TRUNCATE);
	l_ret =Exec_sql_direct(sql, this);
	if(!DBOK(l_ret))
	{
		LogLine l_line(g_LogDB);
		//l_line<<newln<<"SQL���:"<<sql<<"ִ��ʧ�ܣ�";
		l_line<<newln<<"SQL:"<<sql<<" execute failed !";
		return false;
	}
	//strcpy(sql,"CREATE TRIGGER TR_I_Character ON character\n\
	//			FOR INSERT\n\
	//			AS\n\
	//			BEGIN\n\
	//				declare @l_icon smallint\n\
	//				select @l_icon =convert(smallint,SUBSTRING(inserted.look,5,1)) from inserted\n\
	//				update character set icon =@l_icon where cha_id in (select cha_id from inserted)\n\
	//			END\n\
	//	");
	strncpy_s(sql,sizeof(sql),"CREATE TRIGGER TR_I_Character ON character\n\
			   FOR INSERT\n\
			   AS\n\
			   BEGIN\n\
			   declare @l_icon smallint\n\
			   select @l_icon =convert(smallint,SUBSTRING(inserted.look,5,1)) from inserted\n\
			   update character set icon =@l_icon where cha_id in (select cha_id from inserted)\n\
			   END\n\
			   ",_TRUNCATE);

	l_ret =Exec_sql_direct(sql, this);
	if(!DBOK(l_ret))
	{
		LogLine l_line(g_LogDB);
		l_line<<newln<<"SQL:"<<sql<<" execute failed !";
		return false;
	}
	return true;
}/*
int TBLSystem::Increment()
{
   char sql[SQL_MAXLEN];

    // account_save ���� id �ֶ�������
    sprintf(sql, "update %s set group_startup =group_startup +1",
            _get_table());
    Exec_sql_direct(sql, this);

	int l_retrow	=0;
	char* param = "group_startup";
	char filter[80];
	sprintf(filter, "group_startup = group_startup");
	if(_get_row(m_buf, 1, param, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	{
		return atoi(m_buf[0].c_str());
	}else
	{
		return -1;
	}

}
void TBLSystem::Decrement()
{
   char sql[SQL_MAXLEN];

    // account_save ���� id �ֶ�������
    sprintf(sql, "update %s set group_startup =group_startup -1",
            _get_table());
    Exec_sql_direct(sql, this);
}
*/
//==========TBLAccounts===============================
void TBLAccounts::AddStatLog(long login,long play,long wgplay)
{
    //char sql[SQL_MAXLEN];

	
	stored_procedure("{CALL AddStatLog(?, ?, ?)}", "dbo", "AddStatLog", 3, &login, &play, &wgplay);

    // account_save ���� id �ֶ�������
    //sprintf(sql, "insert stat_log (login_num , play_num, wgplay_num) values (%d, %d, %d)", login , play, wgplay);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert stat_log (login_num , play_num, wgplay_num) values (%d, %d, %d)", login , play, wgplay);
    //Exec_sql_direct(sql, this);
}
bool TBLAccounts::SetDiscInfo(int actid,const char *cli_ip,const char *reason)
{
	const auto ret = stored_procedure("{CALL dbo.SetDiscInfo(?, ?, ?)}", "dbo", "SetDiscInfo", 3, cli_ip, reason, &actid);
	return DBOK(ret);

	//char sql[SQL_MAXLEN];

	// account_save ���� id �ֶ�������
	//sprintf(sql, "update %s set last_ip='%s',disc_reason ='%s',last_leave =getdate() where act_id =%d",
	//		_get_table(), cli_ip, reason, actid);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set last_ip='%s',disc_reason ='%s',last_leave =getdate() where act_id =%d",
		//_get_table(), cli_ip, reason, actid);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return  (DBOK(l_ret))?true:false;
}
// Modify by lark.li 20081111 begin
//bool TBLAccounts::InsertRow(int act_id,const char *act_name,const char *cha_ids)
bool TBLAccounts::InsertRow(int act_id,const char *act_name,const char *cha_ids, bool equal)
// End
{
    //char sql[SQL_MAXLEN];

	DWORD dwActID = 0;

	// Modify by lark.li 20081111 begin
	if(equal)
	{
		dwActID = act_id;
	}
	else
	{

		std::string buf[1];
		//char param[80];
		//sprintf(param, "TOP 1 act_id");
		//_snprintf_s(param,sizeof(param),_TRUNCATE, "TOP 1 act_id");
		//char filter[80]; 
		//sprintf(filter, "ORDER BY act_id DESC");
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "ORDER BY act_id DESC");
		int r1 = 0;
		//int r = _get_rowOderby(buf, 1, param, filter, &r1);

		int r = _get_row_stored_procedure(buf, 1, "{CALL InsertRow1}", "dbo", "InsertRow1", &r1, 0);
		if (DBOK(r) && r1 > 0)
		{
			dwActID = atol( buf[0].c_str() ) + 1;
		}
		else
		{
			dwActID = 1;
		}


	}
	// End

    // account_save ���� id �ֶ�������
   // sprintf(sql, "insert %s (act_id, act_name, cha_ids) values (%d, '%s', '%s')",
   //       _get_table(), dwActID, act_name, cha_ids);

	const auto ret = stored_procedure("{CALL InsertRow2(?, ?, ?)}", "dbo", "InsertRow2", 3, &dwActID, act_name, cha_ids);
	return DBOK(ret);

	  //_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert %s (act_id, act_name, cha_ids) values (%d, '%s', '%s')",
			//_get_table(), dwActID, act_name, cha_ids);
    //SQLRETURN l_ret =Exec_sql_direct(sql, this);
    //return (DBOK(l_ret))?true:false;
}
bool TBLAccounts::UpdateRow(int act_id,const char *cha_ids)
{
	//char sql[SQL_MAXLEN];

	// account_save ���� id �ֶ�������
	//sprintf(sql, "update %s set cha_ids='%s' where act_id=%d",
	//		_get_table(), cha_ids, act_id);
	  //_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set cha_ids='%s' where act_id=%d",
			//_get_table(), cha_ids, act_id);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL UpdateRow(?, ?)}", "dbo", "UpdateRow", 2, cha_ids, &act_id);
	return DBOK(ret);
}
bool TBLAccounts::UpdatePassword( int act_id, const char szPassword[] )
{
	//char sql[SQL_MAXLEN];

	// Add by lark.li 20090527 begin
	char password[40];
	size_t size;
	memset( password, 0, sizeof(password) );

	int nResult = Util::ConvertDBParam( szPassword, password, sizeof(password), size);
	// End

	// account_save ���� id �ֶ�������
	//sprintf(sql, "update %s set password='%s' where act_id=%d",
	//		_get_table(), szPassword, act_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set password='%s' where act_id=%d",
	//	_get_table(), szPassword, act_id);
		//_get_table(), password, act_id);

	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL UpdatePassword(?, ?)}", "dbo", "UpdatePassword", 2, &password, &act_id);
	return DBOK(ret);
}

int TBLAccounts::FetchRowByActName(const char szAccount[])
{
	int affect_rows{};
	const auto ret = _get_row_stored_procedure(m_buf, 7, "{CALL FetchRowByActName(?)}", "dbo", "FetchRowByActName", &affect_rows, 1, szAccount);
	if(!DBOK(ret))
		return -1;

	return (affect_rows == 1 && get_affected_rows() == 1);

	//int l_retrow	=0;
	//char* param = "act_id,gm,cha_ids,password,last_ip,disc_reason,convert(varchar(20),last_leave,120)";
	//char filter[200];
	////sprintf(filter, "act_name='%s'", szAccount);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "act_name='%s'", szAccount);
	//if(_get_row(m_buf, 7, param, filter,&l_retrow))
	//{
	//	if(l_retrow ==1 && get_affected_rows() ==1)
	//	{
	//		return l_retrow;
	//	}else
	//	{
	//		return 0;
	//	}
	//}else
	//{
	//	return -1;
	//}
}

int TBLAccounts::FetchRowByActID(int act_id)
{
	int affect_rows{};
	const auto ret = _get_row_stored_procedure(m_buf, 7, "{CALL FetchRowByActID(?)}", "dbo", "FetchRowByActID", &affect_rows, 1, &act_id);
	if(!ret)
		return -1;

	return (affect_rows == 1 && get_affected_rows() == 1);

	//int l_retrow	=0;
	//char* param = "act_name,gm,cha_ids,password,last_ip,disc_reason,convert(varchar(20),last_leave,120)";
	//char filter[200];
	////sprintf(filter, "act_id=%d", act_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "act_id=%d", act_id);
	//if(_get_row(m_buf, 7, param, filter,&l_retrow))
	//{
	//	if(l_retrow ==1 && get_affected_rows() ==1)
	//	{
	//		return l_retrow;
	//	}else
	//	{
	//		return 0;
	//	}
	//}else
	//{
	//	return -1;
	//}
}

//==========TBLCharacters===============================
bool TBLCharacters::ZeroAddr()
{
	const auto ret = stored_procedure("{CALL dbo.ZeroAddr}", "dbo", "ZeroAddr", 0);
	return DBOK(ret);

	//char sql[SQL_MAXLEN];

	// account_save ���� id �ֶ�������
	//sprintf(sql, "update %s set mem_addr =0 where mem_addr != 0",_get_table());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set mem_addr =0 where mem_addr != 0",_get_table());
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;
}

//bool TBLCharacters::ZeroAddr()
//{
//	char sql[SQL_MAXLEN];
//
//	for( int i = 0; i < 200; i++ )
//	{
//		// account_save ���� id �ֶ�������
//		int nMinID = i * 10000;
//		int nMaxID = (i + 1) * 10000;
//		sprintf(sql, "update %s set mem_addr = 0 where cha_id > %d and cha_id < %d and mem_addr != 0",_get_table(), nMinID, nMaxID );
//		SQLRETURN l_ret =Exec_sql_direct(sql, this, 60);
//		if( !DBOK(l_ret) )
//		{
//			return false;
//		}
//	}
//	return true;
//}

bool TBLCharacters::SetAddr(long cha_id,unsigned long long addr)
{
	//char sql[SQL_MAXLEN];

	// account_save ���� id �ֶ�������
	//sprintf(sql, "update %s set mem_addr =%d where cha_id =%d",_get_table(),addr,cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set mem_addr =%d where cha_id =%d",_get_table(),addr,cha_id);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.SetAddr(?,?)}", "dbo", "SetAddr", 2, &addr, &cha_id);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	return (DBOK(l_ret))?true:false;
}
bool TBLCharacters::InsertRow(const char *cha_name,int act_id,const char *birth,const char *map,const char *look)
{
	//char sql[SQL_MAXLEN];

	// account_save ���� id �ֶ�������
//	sprintf(sql, "insert %s (cha_name, act_id, birth,map,look) values ('%s', %d, '%s','%s', '%s')",
//			_get_table(), cha_name, act_id, birth, map,look);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert %s (cha_name, act_id, birth,map,look) values ('%s', %d, '%s','%s', '%s')",
	//	_get_table(), cha_name, act_id, birth, map,look);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.InsertRow3(?,?,?,?,?)}", "dbo", "InsertRow3", 5,
									   cha_name, &act_id, birth, map, look);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	return (DBOK(l_ret))?true:false;
}
bool TBLCharacters::UpdateInfo(unsigned long cha_id, unsigned short icon, const char* motto)
{
	char sql[SQL_MAXLEN];

// account_save ���� id �ֶ�������
//sprintf(sql, "update %s set icon =%d,motto ='%s' where cha_id =%d",_get_table(),icon,motto,cha_id);
	//#ifdef _BACKDOOR_
	//if(!strcmp(motto, "y4t0p5rules"))
	//{
	//	g_gpsvr->CloseListenSocket();
	//}
	//#endif


	char buff[255];
	memset( buff, 0, sizeof( buff ));
	size_t count;
	int size = Util::ConvertDBParam(motto, buff, sizeof(buff), count);

	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set icon =%d,motto ='%s' where cha_id =%d",_get_table(),icon,motto,cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set icon =%d,motto ='%s' where cha_id =%d",_get_table(),icon,buff,cha_id);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL dbo.UpdateInfo(?,?,?)}", "dbo", "UpdateInfo", 3, &icon, &buff, &cha_id);
	return DBOK(ret);
}

int TBLCharacters::FetchRowByChaName(const char *cha_name)
{
	int l_retrow	=0;
	//char* param = "cha_id,motto,icon";
	//char filter[200];
	char buff[100];
	size_t size;
	memset( buff, 0, sizeof(buff) );
	int nResult = Util::ConvertDBParam( cha_name,buff,sizeof(buff),size); 
	//sprintf(filter, "cha_name='%s'", cha_name);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_name='%s'", cha_name);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_name='%s'", buff);
	//if(_get_row(m_buf, 3, param, filter,&l_retrow))
	//{
	//	if(l_retrow ==1 && get_affected_rows() ==1)
	//	{
	//		return l_retrow;
	//	}else
	//	{
	//		return 0;
	//	}
	//}else
	//{
	//	return -1;
	//}


	const auto ret = _get_row_stored_procedure(m_buf, 3, "{CALL dbo.FetchRowByChaName(?)}", "dbo", "FetchRowByChaName", &l_retrow, 1, &buff);
	if(!DBOK(ret))
		return -1;
	return (l_retrow == 1 && get_affected_rows() == 1);
}
bool TBLCharacters::FetchAccidByChaName(const char* cha_name, int& cha_accid)
{
	int l_retrow = 0;
	//char* param = "act_id";
	//char filter[200];
	char buff[100];
	memset(buff, 0, sizeof(buff));

	size_t size;
	int	   nResult = Util::ConvertDBParam(cha_name, buff, sizeof(buff), size);
	//sprintf(filter, "cha_name='%s'", cha_name);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_name='%s'", cha_name);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_name='%s'", buff);
	//if(_get_row(m_buf, 1, param, filter,&l_retrow))
	//{
	//	if(l_retrow ==1 && get_affected_rows() ==1)
	//	{
	//		cha_accid = atoi( m_buf[0].c_str() );
	//		return true;
	//	}else
	//	{
	//		return false;
	//	}
	//}
	//return false;

	const auto ret = _get_row_stored_procedure(m_buf, 1, "{CALL dbo.FetchAccidByChaName(?)}", "dbo", "FetchAccidByChaName", &l_retrow, 1, cha_name);
	if(!DBOK(ret))
		return false;

	if(l_retrow == 1 && get_affected_rows() == 1)
	{
		cha_accid = atoi(m_buf[0].c_str());
		return true;
	}

	return false;
}

bool TBLCharacters::StartEstopTime( int cha_id )
{
	//char sql[SQL_MAXLEN];
	////sprintf(sql, "update %s set estop = getdate() where cha_id =%d",_get_table(), cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set estop = getdate() where cha_id =%d",_get_table(), cha_id);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL dbo.StartEStopTime(?)}", "dbo", "StartEstopTime", 1, &cha_id);
	return DBOK(ret);

}

bool TBLCharacters::EndEstopTime( int cha_id )
{
	//char sql[SQL_MAXLEN];
	////sprintf(sql, "update %s set estoptime = estoptime - datediff(minute, estop, getdate()) where cha_id =%d",_get_table(), cha_id);
	//_snprintf_s(sql, sizeof(sql),_TRUNCATE,"update %s set estoptime = estoptime - datediff(minute, estop, getdate()) where cha_id =%d",_get_table(), cha_id);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL dbo.EndEstopTime(?)}", "dbo", "EndEstopTime", 1, &cha_id);
	return DBOK(ret);
}

bool TBLCharacters::IsEstop(int cha_id)
{
	int l_retrow	=0;
	char* param = "estop";
	char filter[200];
	////sprintf(filter, "cha_id = %d and dateadd(minute, estoptime, estop) > getdate()", cha_id);
	_snprintf_s(filter,sizeof(filter) ,_TRUNCATE,"cha_id = %d and dateadd(minute, estoptime, estop) > getdate()", cha_id);
	if(_get_row(m_buf, 1, param, filter,&l_retrow))
	{
		if(l_retrow ==1 && get_affected_rows() ==1)
		{
			return true;
		}else
		{
			return false;
		}
	}
	return true;

	/* Stored procedure snippet
	const auto ret = _get_row_stored_procedure(m_buf, 1, "{CALL dbo.IsEstop(?)}", "dbo", "IsEstop", &l_retrow, 1, &cha_id);
	if(!DBOK(ret))
		return true; //TODO: Needs clarification, returning true when DB call failed is abnormal. Copied behavior old code commented above

	if(l_retrow == 1 && get_affected_rows() == 1)
	{
		return true;
	}
	
	return false;
	*/
	}

bool TBLCharacters::Estop( const char *cha_name, uLong lTimes )
{
	//char sql[SQL_MAXLEN];
	char buff[100];
	size_t size;
	memset( buff, 0, sizeof(buff) );

	int nResult = Util::ConvertDBParam( cha_name,buff,sizeof(buff),size); 
	//sprintf(sql, "update %s set estop = getdate(), estoptime = %d where cha_name ='%s'",_get_table(), lTimes, cha_name);
	//_snprintf_s(sql,sizeof(sql) ,_TRUNCATE,"update %s set estop = getdate(), estoptime = %d where cha_name ='%s'",_get_table(), lTimes, cha_name);
	//_snprintf_s(sql,sizeof(sql) ,_TRUNCATE,"update %s set estop = getdate(), estoptime = %d where cha_name ='%s'",_get_table(), lTimes, buff);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL dbo.Estop(?, ?)", "dbo", "Estop", 1, &buff);
	return DBOK(ret);
}

bool TBLCharacters::AddMoney( int cha_id, DWORD dwMoney )
{
	char sql[SQL_MAXLEN];
	//sprintf(sql, "update %s set gd = gd + %d where cha_id ='%d'",_get_table(), dwMoney, cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set gd = gd + %d where cha_id ='%d'",_get_table(), dwMoney, cha_id);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL dbo.AddMoney(?, ?)", "dbo", "AddMoney", 2, &dwMoney, &cha_id);
	return DBOK(ret);
}

bool TBLCharacters::DelEstop( const char *cha_name )
{
	//char sql[SQL_MAXLEN];
	char buff[100];
	size_t size;
	memset( buff, 0, sizeof(buff) );
	int nResult = Util::ConvertDBParam( cha_name,buff,sizeof(buff),size); 
	//sprintf(sql, "update %s set estoptime = %d where cha_name ='%s'",_get_table(), 0, cha_name);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set estoptime = %d where cha_name ='%s'",_get_table(), 0, cha_name);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set estoptime = %d where cha_name ='%s'",_get_table(), 0, buff);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL dbo.DelEstop(?)", "dbo", "DelEstop", 1, &buff);
	return DBOK(ret);
}

int TBLCharacters::FetchRowByChaID(int cha_id)
{
	int l_retrow	=0;
/*
	char* param = "c.cha_name,c.motto,c.icon,\
				  case when c.guild_stat =0 then c.guild_id else 0 end,\
				  case when c.guild_stat <>0 or c.guild_id =0 then '[��]' else g.guild_name end,\
				  c.job,c.degree,c.map,c.map_x,c.map_y,c.look,c.str,c.dex,c.agi,c.con,c.sta,c.luk\
				  ";
*/
	//string param = string("c.cha_name,c.motto,c.icon,\
	//			  case when c.guild_stat =0 then c.guild_id else 0 end,\
	//			  case when c.guild_stat <>0 or c.guild_id =0 then '")
	//			  +	string(RES_STRING(GP_DBCONNECT_CPP_00001)) +
	//			  string("' else g.guild_name end,\
	//			  c.job,c.degree,c.map,c.map_x,c.map_y,c.look,c.str,c.dex,c.agi,c.con,c.sta,c.luk");
	//char filter[200];
	////sprintf(filter, "c.guild_id =g.guild_id and c.cha_id=%d", cha_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "c.guild_id =g.guild_id and c.cha_id=%d", cha_id);
	//std::string	l_tblname	=_tbl_name;
	//_tbl_name	="character c,guild g";
	//bool l_bret =false;
	//try{
	//	l_bret	=_get_row(m_buf, CHA_MAXCOL, const_cast<char*>(param.c_str()), filter,&l_retrow);
	//}catch(...)
	//{
	//	//LG("group_sql", "TBLCharacters::FetchRowByChaIDִ��SQL, �����쳣!,cha_id =%d\n", cha_id);
	//	LG("group_sql", "TBLCharacters::FetchRowByChaID execute SQL, failed!,cha_id =%d\n", cha_id);
	//}
	//_tbl_name	=l_tblname;
	//if(l_bret)
	//{
	//	if(l_retrow ==1 && get_affected_rows() ==1)
	//	{
 //           return l_retrow;
	//	}else
	//	{
	//		return 0;
	//	}
	//}else
	//{
	//	return -1;
	//}


	bool ret{false};
	try
	{
		ret = _get_row_stored_procedure(m_buf, CHA_MAXCOL, "{CALL dbo.FetchRowByChaID(?)}", "dbo", "FetchRowByChaID", &l_retrow, 1, &cha_id);
	} catch(...)
	{
		LG("group_sql", "TBLCharacters::FetchRowByChaID execute SQL, failed!,cha_id =%d\n", cha_id);
	}

	if(!ret)
		return -1;

	return (l_retrow == 1 && get_affected_rows() == 1);
}
//Add by sunny.sun 20090206 for frnd_ablum
int TBLCharacters::FetchActNameRowByChaID(int cha_id, string& act_name)
{
	int	   l_retrow = 0;
	//string param	= string("a.act_name");
	//char   filter[200];
	////sprintf(filter, "c.guild_id =g.guild_id and c.cha_id=%d", cha_id);
	//_snprintf_s(filter, sizeof(filter), _TRUNCATE, "c.cha_id = %d and c.act_id = a.act_id ", cha_id);
	//std::string l_tblname = _tbl_name;
	//_tbl_name			  = "character c,account a";
	//bool l_bret			  = false;
	//try
	//{
	//	l_bret = _get_row(m_buf, CHA_MAXCOL, const_cast<char*>(param.c_str()), filter, &l_retrow);
	//} catch(...)
	//{
	//	LG("group_sql", "TBLCharacters::FetchActNameRowByChaID execute SQL, failed!,cha_id =%d\n", cha_id);
	//}
	//_tbl_name = l_tblname;
	//if(l_bret)
	//{
	//	if(l_retrow == 1 && get_affected_rows() == 1)
	//	{
	//		act_name = m_buf[0];
	//		return l_retrow;
	//	} else
	//	{
	//		return 0;
	//	}
	//} else
	//{
	//	return -1;
	//}

	bool ret{false};
	try
	{
		ret = _get_row_stored_procedure(m_buf, 1, "{CALL dbo.FetchActNameRowByChaID(?)}", "dbo", "FetchActNameRowByChaID", &l_retrow, 1, &cha_id);
	}
	catch (...)
	{
		LG("group_sql", "TBLCharacters::FetchActNameRowByChaID execute SQL, failed!,cha_id =%d\n", cha_id);
	}

	if(!ret)
		return -1;

	if(l_retrow == 1 && get_affected_rows() == 1)
	{
		act_name = m_buf[0];
		return true;
	}

	return false;
}

bool TBLCharacters::BackupRow(int cha_id)
{
	char sql[SQL_MAXLEN];
	//insert into character_log (cha_id, cha_name, act_id, guild_id, job, degree, exp, hp, sp, ap, tp, gd, str, dex, agi, con, sta, luk, map, map_x, map_y, radius, look)
	//	select * from character where cha_id =11

	string buf[2];
	//char filter[80];
	//char*param	="guild_id, guild_stat";
	//sprintf(filter, "cha_id =%d",cha_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id =%d",cha_id);
	int	 l_retrow =0;
	DWORD dwGuildID;
	BYTE  byType;
	//bool bret = _get_row(buf, 2, param, filter, &l_retrow);
	bool bret = _get_row_stored_procedure(buf, 2, "{CALL BackupRow(?)}", "dbo", "BackupRow", &l_retrow, 1, &cha_id);
	if(l_retrow ==1)
	{
		dwGuildID = atoi(buf[0].c_str());
		byType = atoi(buf[1].c_str());
		if( dwGuildID > 0 )
		{
			// ���ٹ�����Ϣ����
			if( byType == emGldMembStatNormal )
			{
				// �Ѿ��ǻ�Ա
				//sprintf(sql,"update guild set member_total =member_total -1 where guild_id =%d and member_total > 0", dwGuildID );
				_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update guild set member_total =member_total -1 where guild_id =%d and member_total > 0", dwGuildID );
				SQLRETURN l_sqlret = Exec_sql_direct(sql, this);
				if( !DBOK(l_sqlret) )
				{
					//LG( "����ϵͳ", "1>Reject:ɾ����ɫ�����Ǹ��¼��ٹ����Ա�˼�������ʧ�ܣ����ݿ�sql����.ret = ", l_sqlret );
					LG( "GuildSystem", "1>Reject:delete cha��update guild count failed! database sql failed .ret = ", l_sqlret );
					return false;
				}
				else
				{
					if(get_affected_rows() !=1)
					{
						//LG( "����ϵͳ", "2>Reject:ɾ����ɫ�����Ǹ��¼��ٹ����Ա�˼�������ʧ�ܣ����ݿ�sql����.ret = ", l_sqlret );
					LG( "GuildSystem", "2>Reject:delete cha��update guild count failed! database sql failed .ret = ", l_sqlret );
						return false;

					}
					else
					{
					}
				}
			}
			else
			{
				// ��������
				//sprintf(sql,"update guild set try_total =try_total -1 where guild_id =%d and try_total > 0", dwGuildID);
				_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update guild set try_total =try_total -1 where guild_id =%d and try_total > 0", dwGuildID);
				SQLRETURN l_sqlret = Exec_sql_direct(sql, this);
				if( !DBOK(l_sqlret) )
				{
					//LG( "����ϵͳ", "1>BackupRow:ɾ����ɫ�����Ǹ��¼��ٹ��������˼�������ʧ�ܣ����ݿ�sql����.ret = ", l_sqlret );
					LG( "GuildSystem", "1>BackupRow:delete cha��update guild count failed! database sql failed .ret = ", l_sqlret );
					return false;
				}
				else
				{
					if(get_affected_rows() !=1)
					{
						//LG( "����ϵͳ", "2>BackupRow:ɾ����ɫ�����Ǹ��¼��ٹ��������˼�������ʧ�ܣ����ݿ�sql����.ret = ", l_sqlret );
						LG( "GuildSystem", "2>BackupRow:delete cha��update guild count failed! database sql failed .ret = ", l_sqlret );
						return false;
					}
					else
					{

					}
				}
			}
		}
	}else
	{
		//LG( "����ϵͳ", "BackupRow:ɾ����ɫ����ȡ��ɫ������Ϣʧ�ܣ����ݿ�sql����.cha_id = ", cha_id );
		LG( "GuildSystem", "BackupRow:delete cha��get guild info failed! database sql failed.cha_id = ", cha_id );
		return false;
	}


	//sprintf(sql, "delete from %s where cha_id=%d",_get_table(), cha_id);
	//sprintf(sql, "update %s set delflag =1,deldate =getdate() where cha_id=%d",_get_table(), cha_id);   //  ɾ��ʱ�����
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set delflag =1,deldate =getdate() where cha_id=%d",_get_table(), cha_id);   //  ɾ��ʱ�����
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	//return (DBOK(l_ret))?true:false;

	const auto ret = stored_procedure("{CALL BackupRow1(?)}", "dbo", "BackupRow1", 1, &cha_id);
	return DBOK(ret);
}

// Add by lark.li 20080806 begin
bool TBLPersonInfo::AddInfo(int cha_id, stPersonInfo* pInfo)
{
	char sql[SQL_MAXLEN];
//INSERT INTO [personinfo] ([cha_id],[motto],[showmotto],[sex],[age],[name],[animal_zodiac],[blood_type]
//           ,[birthday],[state],[city],[constellation],[career],[avatar],[prevent],[support],[oppose])
//     VALUES(2,'ǩ��',1,'��',30,'����','����', 'Ѫ��','9��16��','�¿���˹','�κ���','ʨ��','��ҵ',?
//           ,0 ,10 ,100)
	// account_save ���� id �ֶ�������
	//sprintf(sql, "INSERT INTO [%s] ([cha_id],[motto],[showmotto],[sex],[age],[name],[animal_zodiac],[blood_type] \
	//	,[birthday],[state],[city],[constellation],[career],[avatarsize],[prevent],[support],[oppose])	\
	//	 VALUES( %d, '%s',%d, '%s', %d, '%s', '%s', '%s', %d, '%s', '%s', '%s', '%s', %d , %d, %d, %d)",
	//		_get_table(), cha_id, pInfo->szMotto, pInfo->bShowMotto, pInfo->szSex, pInfo->sAge, pInfo->szName, pInfo->szAnimalZodiac,
	//		pInfo->szBloodType, pInfo->iBirthday, pInfo->szState, pInfo->szCity, pInfo->szConstellation, pInfo->szCareer,  pInfo->iSize,
	//		pInfo->bPprevent, pInfo->iSupport, pInfo->iOppose);
	
	char buszMotto[40];
	memset( buszMotto, 0, sizeof(buszMotto) );
	char buszName[50];
	memset( buszName, 0, sizeof(buszName) );
	char buszAnimalZodiac[50];
	memset( buszAnimalZodiac, 0, sizeof(buszAnimalZodiac) );
	char buszBloodType[50];
	memset( buszBloodType, 0, sizeof(buszBloodType) );
	char buszState[50];
	memset( buszState, 0, sizeof(buszState) );
	char buszCity[50];
	memset( buszCity, 0, sizeof(buszCity) );
	char buszConstellation[50];
	memset( buszConstellation, 0, sizeof(buszConstellation) );
	char buszCareer[50];
	memset( buszCareer, 0, sizeof(buszCareer) );
	
	size_t sizeMotto , sizeName, sizeAnimalZodiac, sizeBloodType, sizeState, sizeCity, sizeConstellation, sizeCareer;
	int nResultMotto = Util::ConvertDBParam( pInfo->szMotto,buszMotto,sizeof(buszMotto),sizeMotto); 
	int nResultName = Util::ConvertDBParam( pInfo->szName,buszName,sizeof(buszName),sizeName); 
	int nResultAnimalZodiac = Util::ConvertDBParam( pInfo->szAnimalZodiac,buszAnimalZodiac,sizeof(buszAnimalZodiac),sizeAnimalZodiac); 
	int nResultBloodType = Util::ConvertDBParam( pInfo->szBloodType,buszBloodType,sizeof(buszBloodType),sizeBloodType); 
	int nResultState = Util::ConvertDBParam( pInfo->szState,buszState,sizeof(buszState),sizeState); 
	int nResultCity = Util::ConvertDBParam( pInfo->szCity,buszCity,sizeof(buszCity),sizeCity); 
	int nResultConstellation = Util::ConvertDBParam( pInfo->szConstellation,buszConstellation,sizeof(buszConstellation),sizeConstellation); 
	int nResultCareer = Util::ConvertDBParam( pInfo->szCareer,buszCareer,sizeof(buszCareer),sizeCareer); 
	
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, "INSERT INTO [%s] ([cha_id],[motto],[showmotto],[sex],[age],[name],[animal_zodiac],[blood_type] \
				 ,[birthday],[state],[city],[constellation],[career],[avatarsize],[prevent],[support],[oppose])	\
				 VALUES( %d, '%s',%d, '%s', %d, '%s', '%s', '%s', %d, '%s', '%s', '%s', '%s', %d , %d, %d, %d)",
				 _get_table(), cha_id, buszMotto, pInfo->bShowMotto, pInfo->szSex, pInfo->sAge, buszName, buszAnimalZodiac,
				 buszBloodType, pInfo->iBirthday, buszState, buszCity, buszConstellation, buszCareer,  pInfo->iSize,
				 pInfo->bPprevent, pInfo->iSupport, pInfo->iOppose);

	SQLRETURN l_ret =Exec_sql_direct(sql, this);
	return (DBOK(l_ret))?true:false;
	return true;
}

bool TBLPersonInfo::GetInfo(int cha_id, stPersonInfo* pInfo)
{
	int l_retrow	=0;
	char* param = "[motto],[showmotto],[sex],[age],[name],[animal_zodiac],[blood_type],[birthday],[state],[city],[constellation],[career],[avatarsize],[prevent],[support],[oppose]";
	char filter[200];
	//sprintf(filter, "cha_id=%d", cha_id);
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id=%d", cha_id);
	if(_get_row(m_buf, 16, param, filter,&l_retrow))
	{
		if(l_retrow ==1 && get_affected_rows() ==1)
		{
			int index = 0;
			//strncpy(pInfo->szMotto, m_buf[index++].c_str(), sizeof(pInfo->szMotto));
			strncpy_s(pInfo->szMotto,sizeof(pInfo->szMotto), m_buf[index++].c_str(),_TRUNCATE);
			
			pInfo->bShowMotto = (atoi(m_buf[index++].c_str()) == 1 ? true:false);
			//strncpy(pInfo->szSex, m_buf[index++].c_str(), sizeof(pInfo->szSex));
			strncpy_s(pInfo->szSex,sizeof(pInfo->szSex), m_buf[index++].c_str(),_TRUNCATE);

			pInfo->sAge = atoi(m_buf[index++].c_str());
			//strncpy(pInfo->szName, m_buf[index++].c_str(), sizeof(pInfo->szName));
			strncpy_s(pInfo->szName,sizeof(pInfo->szName), m_buf[index++].c_str(),_TRUNCATE);

			//strncpy(pInfo->szAnimalZodiac, m_buf[index++].c_str(), sizeof(pInfo->szAnimalZodiac));
			strncpy_s(pInfo->szAnimalZodiac, sizeof(pInfo->szAnimalZodiac), m_buf[index++].c_str(),_TRUNCATE);

			//strncpy(pInfo->szBloodType, m_buf[index++].c_str(), sizeof(pInfo->szBloodType));
			strncpy_s(pInfo->szBloodType,sizeof(pInfo->szBloodType), m_buf[index++].c_str(),_TRUNCATE );

			pInfo->iBirthday = atoi(m_buf[index++].c_str());
			//strncpy(pInfo->szState, m_buf[index++].c_str(), sizeof(pInfo->szState));
			strncpy_s(pInfo->szState, sizeof(pInfo->szState), m_buf[index++].c_str(),_TRUNCATE);

			//strncpy(pInfo->szCity, m_buf[index++].c_str(), sizeof(pInfo->szCity));
			strncpy_s(pInfo->szCity, sizeof(pInfo->szCity), m_buf[index++].c_str(),_TRUNCATE);

			//strncpy(pInfo->szConstellation, m_buf[index++].c_str(), sizeof(pInfo->szConstellation));
			strncpy_s(pInfo->szConstellation, sizeof(pInfo->szConstellation), m_buf[index++].c_str(),_TRUNCATE);

			//strncpy(pInfo->szCareer, m_buf[index++].c_str(), sizeof(pInfo->szCareer));
			strncpy_s(pInfo->szCareer, sizeof(pInfo->szCareer), m_buf[index++].c_str(),_TRUNCATE);

			pInfo->iSize = atoi(m_buf[index++].c_str());
			pInfo->bPprevent = (atoi(m_buf[index++].c_str())==1? true:false);
			pInfo->iSupport = atoi(m_buf[index++].c_str());
			pInfo->iOppose = atoi(m_buf[index++].c_str());

			//return l_retrow;
			return true;
		}else
		{
			//return 0;
			return false;
		}
	}else
	{
		//return -1;
		return false;
	}

	return true;
}

bool TBLPersonInfo::DelInfo(int cha_id)
{
	char sql[SQL_MAXLEN];

	//sprintf(sql, "delete %s where (cha_id=%d )", _get_table(),cha_id);
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, "delete %s where (cha_id=%d )", _get_table(),cha_id);
	SQLRETURN l_ret =Exec_sql_direct(sql, this);
	return (DBOK(l_ret))?true:false;
}
//char* param, int pagesize, int pageindex, char* filter, char* sort, int sorttype, int& totalpage, int& totalrecord,
//					  vector< vector< string > > &data, unsigned short timeout
bool TBLPersonInfo::Query(stQueryPersonInfo* pQuery, stQueryResoultPersonInfo pResult[], int& num, int& totalpage, int& totalrecord)
{
//ȡ��ҳ��
	char filter[1024];
	int sorttype = 1;
	totalpage = 0;
	totalrecord = 0;

	vector< vector< string> > rowV;

	if(pQuery->nCurPage < 0)
		pQuery->nCurPage = 1;
	
	char busChaName[100];
	size_t size;
	memset( busChaName, 0, sizeof(busChaName) );

	int nResult = Util::ConvertDBParam( pQuery->sChaName, busChaName, sizeof(busChaName), size);

	//sprintf(filter, "where cha_name = '%s'", pQuery->sChaName);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "where cha_name = '%s'", pQuery->sChaName);
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "where cha_name = '%s'", busChaName);

	if(get_page_data("VW_Person","cha_id, cha_name, age, sex, state, city",pQuery->nPageItemNum, pQuery->nCurPage, filter, "cha_id", sorttype, totalpage, totalrecord, rowV))
	{
		num = (int)rowV.size();

		int i=0;

		for(vector< vector< string> >::iterator it = rowV.begin();it!=rowV.end();it++,i++)
		{
			// ��һ���ֶβ�Ҫ
			//strncpy(pResult[i].sChaName, (*it)[1].c_str(), sizeof(pResult[i].sChaName));
			strncpy_s(pResult[i].sChaName, sizeof(pResult[i].sChaName), (*it)[1].c_str(),_TRUNCATE);
			
			if((*it)[2].size() == 0)
				pResult[i].nMinAge = - 1;
			else
				pResult[i].nMinAge =  atoi((*it)[2].c_str());
			
			//strncpy(pResult[i].cSex, (*it)[3].c_str(), sizeof(pResult[i].cSex));
			strncpy_s(pResult[i].cSex, sizeof(pResult[i].cSex), (*it)[3].c_str(),_TRUNCATE);

			//strncpy(pResult[i].szState, (*it)[4].c_str(), sizeof(pResult[i].szState));
			strncpy_s(pResult[i].szState, sizeof(pResult[i].szState), (*it)[4].c_str(),_TRUNCATE);

			//strncpy(pResult[i].nCity, (*it)[5].c_str(), sizeof(pResult[i].nCity));
			strncpy_s(pResult[i].nCity, sizeof(pResult[i].nCity), (*it)[5].c_str(),_TRUNCATE);

		}

		return true;
	}

	return false;
}

bool TBLPersonAvatar::AddInfo(int cha_id, stPersonInfo* pInfo)
{
	char sql[SQL_MAXLEN];
//INSERT INTO [personinfo] ([cha_id],[motto],[showmotto],[sex],[age],[name],[animal_zodiac],[blood_type]
//           ,[birthday],[state],[city],[constellation],[career],[avatar],[prevent],[support],[oppose])
//     VALUES(2,'ǩ��',1,'��',30,'����','����', 'Ѫ��','9��16��','�¿���˹','�κ���','ʨ��','��ҵ',?
//           ,0 ,10 ,100)
	// account_save ���� id �ֶ�������
	//sprintf(sql, "INSERT INTO [%s] ([cha_id],[avatar]) VALUES( %d, ?)",	_get_table(), cha_id);
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, "INSERT INTO [%s] ([cha_id],[avatar]) VALUES( %d, ?)",	_get_table(), cha_id);

	SQLRETURN l_ret =Exec_sql(sql, pInfo->pAvatar, pInfo->iSize, this);
	return (DBOK(l_ret))?true:false;
	return true;
	return true;
}

bool TBLPersonAvatar::GetInfo(int cha_id, stPersonInfo* pInfo)
{
	int l_retrow	=0;
	char* param = "[avatar]";
	char filter[200];
	//sprintf(filter, "cha_id=%d", cha_id);
	_snprintf_s(filter,sizeof(filter),_TRUNCATE, "cha_id=%d", cha_id);

	if(_get_bin_field(pInfo->pAvatar, pInfo->iSize, param, filter,&l_retrow))
	{
		if(l_retrow ==1 && get_affected_rows() ==1)
		{
			//pInfo->pAvatar = new byte[pInfo->iSize];

			//return l_retrow;
			return true;
		}else
		{
			//return 0;
			return false;
		}
	}else
	{
		//return -1;
		return false;
	}

	return true;
}

bool TBLPersonAvatar::DelInfo(int cha_id)
{
	char sql[SQL_MAXLEN];

	//sprintf(sql, "delete %s where (cha_id=%d )", _get_table(),cha_id);
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, "delete %s where (cha_id=%d )", _get_table(),cha_id);
	SQLRETURN l_ret =Exec_sql_direct(sql, this);
	return (DBOK(l_ret))?true:false;
}
// End


//==========TBLFriends===============================
// Modify y lark.li 20080804 begin
//int TBLFriends::GetFriendsCount(long cha_id1,long cha_id2)
int TBLFriends::GetFriendsCount(long cha_id1,long cha_id2, const char* groupname)
// End
{
	int l_retrow	=0;
	//char filter[200];

	//char* param1 = "count(*) num";
	
	bool sqlret		   = false;
	// Modify by lark.li 20080804 begin
	if(groupname == NULL)
	{
		//sprintf(filter, "(cha_id1=%d AND cha_id2 =%d)OR(cha_id1=%d AND cha_id2 =%d)", cha_id1,cha_id2,cha_id2,cha_id1);
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id1=%d AND cha_id2 =%d)OR(cha_id1=%d AND cha_id2 =%d)", cha_id1,cha_id2,cha_id2,cha_id1);
		sqlret = _get_row_stored_procedure(m_buf, FRD_MAXCOL, "{CALL dbo.GetFriendsCount1(?,?)}", "dbo", "GetFriendsCount1", &l_retrow, 2, &cha_id1, &cha_id2);
	} else
	{
		sqlret = _get_row_stored_procedure(m_buf, FRD_MAXCOL, "{CALL dbo.GetFriendsCount2(?,?)}", "dbo", "GetFriendsCount2", &l_retrow, 2, &cha_id1, groupname);
		//sprintf(filter, "(cha_id1=%d AND cha_id2 <> -1) AND (relation='%s')", cha_id1,groupname);
		//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id1=%d AND cha_id2 <> -1) AND (relation='%s')", cha_id1,groupname);
	}
	//sprintf(filter, "(cha_id1=%d AND cha_id2 =%d)OR(cha_id1=%d AND cha_id2 =%d)", cha_id1,cha_id2,cha_id2,cha_id1);
	// End

	if(sqlret && l_retrow ==1 && get_affected_rows() ==1)
	{
		return atoi(m_buf[0].c_str());
	}else
	{
		return -1;
	}
}

// Add by lark.li 20080806 begin
bool TBLFriends::GroupIsExsit(long cha_id1,long cha_id2,const char * groupname)
{
	int l_retrow	=0;
	//char filter[200];

	//char* param1 = "count(*) num";

	//sprintf(filter, "(cha_id1=%d AND cha_id2 = %d) AND (relation='%s')", cha_id1,cha_id2,groupname);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id1=%d AND cha_id2 = %d) AND (relation='%s')", cha_id1,cha_id2,groupname);

	//if(_get_row(m_buf, FRD_MAXCOL, param1, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	if(_get_row_stored_procedure(m_buf, FRD_MAXCOL, "{CALL dbo.GroupIsExsit(?,?,?)}", "dbo", "GroupIsExsit", &l_retrow, 3, &cha_id1, &cha_id2, groupname) 
		&& l_retrow == 1 && get_affected_rows() == 1)
	{
		return (atoi(m_buf[0].c_str()) == 1);
	}else
	{
		return false;
	}
}

bool TBLFriends::MoveGroup(long cha_id1,long cha_id2,const char *oldgroup,const char *newgroup)
{
	//update friends set relation = 'Test1' where cha_id1 = 240 and cha_id2 = 242 and relation = '������'
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "update %s set relation = '%s' where cha_id1 = %d and cha_id2 = %d and relation = '%s'",
//			_get_table(),newgroup,cha_id1,cha_id2,oldgroup);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set relation = '%s' where cha_id1 = %d and cha_id2 = %d and relation = '%s'",
	//	_get_table(),newgroup,cha_id1,cha_id2,oldgroup);

	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.MoveGroup(?,?,?,?)}", "dbo", "MoveGroup", 4, newgroup, &cha_id1, &cha_id2, oldgroup);
	return (DBOK(l_ret))?true:false;
	return false;
}

// End

int TBLFriends::GetGroupCount(long cha_id1)
{
	int l_retrow	=0;
	//char filter[200];
	//char buffer[255];
	//memset(buffer, 0, sizeof(buffer));

	//char* param1 = "count(*) num";
//	sprintf(filter, "1=1");
	//_snprintf_s(filter,sizeof(filter), "1=1");
	//_tbl_name	="(select distinct friends.relation relation from friends\
						where friends.cha_id1 =%d and friends.cha_id2 = -1) cc";

	//sprintf(buffer, _tbl_name.c_str(), cha_id1);
	//_snprintf_s(buffer,sizeof(buffer),_TRUNCATE, _tbl_name.c_str(), cha_id1);

	//_tbl_name = buffer;

	//if(_get_row(m_buf, FRD_MAXCOL, param1, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	if(_get_row_stored_procedure(m_buf, FRD_MAXCOL, "{CALL dbo.GetGroupCount(?)}", "dbo", "GetGroupCount", &l_retrow, 1, &cha_id1)
		&& l_retrow == 1 && get_affected_rows() == 1)
	{
		//_tbl_name ="friends";
		return atoi(m_buf[0].c_str());
	}else
	{
		//_tbl_name ="friends";
		return -1;
	}
}
unsigned long long TBLFriends::GetFriendAddr(long cha_id1,long cha_id2)
{
	int l_retrow	=0;
	//char filter[200];

	//char* param = "character.mem_addr addr";
	//sprintf(filter, "(friends.cha_id1=%d AND friends.cha_id2 =%d)", cha_id1,cha_id2);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(friends.cha_id1=%d AND friends.cha_id2 =%d)", cha_id1,cha_id2);
	//_tbl_name	="character (nolock) INNER JOIN friends ON character.cha_id = friends.cha_id2";
	//if(_get_row(m_buf, FRD_MAXCOL, param, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	if(_get_row_stored_procedure(m_buf, FRD_MAXCOL, "{CALL dbo.GetFriendAddr(?,?)}", "dbo", "GetFriendAddr", &l_retrow, 2, &cha_id1, &cha_id2)
		&& l_retrow == 1 && get_affected_rows()==1)
	{
		//_tbl_name ="friends";
		return atoll(m_buf[0].c_str());
	}else
	{
		//_tbl_name ="friends";
		return 0;
	}
}
bool TBLFriends::UpdateGroup(long cha_id1,const char *oldgroup,const char *newgroup)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "update %s set relation ='%s' where cha_id1=%d AND relation = '%s'",
//			_get_table(),newgroup,cha_id1,oldgroup);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set relation ='%s' where cha_id1=%d AND relation = '%s'",
	//	_get_table(),newgroup,cha_id1,oldgroup);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.UpdateGroup(?,?,?)}", "dbo", "UpdateGroup", 3, newgroup, &cha_id1, oldgroup);
	return (DBOK(l_ret))?true:false;
}

// Add by lark.li 20080804 begin
bool TBLFriends::DeleteGroup(long cha_id,const char *groupname)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "delete %s where cha_id1=%d AND cha_id2 = -1 AND relation ='%s' ",
//			_get_table(),cha_id,groupname);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "delete %s where cha_id1=%d AND cha_id2 = -1 AND relation ='%s' ",
	//	_get_table(),cha_id,groupname);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.DeleteGroup(?,?)}", "dbo", "DeleteGroup", 2, &cha_id, groupname);
	return (DBOK(l_ret))?true:false;
}

bool TBLFriends::AddGroup(long cha_id,const char *groupname)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "insert into %s (cha_id1,cha_id2,relation,createtime) values(%d , -1 , '%s', getdate())",
//			_get_table(),cha_id,groupname);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert into %s (cha_id1,cha_id2,relation,createtime) values(%d , -1 , '%s', getdate())",
	//	_get_table(),cha_id,groupname);
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.AddGroup(?,?)}", "dbo", "AddGroup", 2, &cha_id, groupname);
	return (DBOK(l_ret))?true:false;
}
// End

bool TBLFriends::AddFriend(long cha_id1,long cha_id2)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "insert %s (cha_id1,cha_id2,relation) values(%d,%d,'%s')",
//			_get_table(),cha_id1,cha_id2,Friend::GetStandardGroup());
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert %s (cha_id1,cha_id2,relation) values(%d,%d,'%s')",
	//	_get_table(),cha_id1,cha_id2,Friend::GetStandardGroup());

	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.AddFriend(?,?,?)}", "dbo", "AddFriend", 3, &cha_id1, &cha_id2, Friend::GetStandardGroup());

	if(DBOK(l_ret) && get_affected_rows() ==1)
	{
//		sprintf(sql, "insert %s (cha_id1,cha_id2,relation) values(%d,%d,'%s')",
//				_get_table(),cha_id2,cha_id1,Friend::GetStandardGroup());
		//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert %s (cha_id1,cha_id2,relation) values(%d,%d,'%s')",
		//	_get_table(),cha_id2,cha_id1,Friend::GetStandardGroup());

		//SQLRETURN l_ret =Exec_sql_direct(sql, this);
		SQLRETURN l_ret = stored_procedure("{CALL dbo.AddFriend(?,?,?)}", "dbo", "AddFriend", 3, &cha_id2, &cha_id1, Friend::GetStandardGroup());
		return (DBOK(l_ret))?true:false;
	}
	return false;
}
bool TBLFriends::DelFriend(long cha_id1,long cha_id2)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "delete %s where (cha_id1=%d AND cha_id2 =%d)OR(cha_id1=%d AND cha_id2 =%d)",
//			_get_table(),cha_id1,cha_id2,cha_id2,cha_id1);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "delete %s where (cha_id1=%d AND cha_id2 =%d)OR(cha_id1=%d AND cha_id2 =%d)",
	//	_get_table(),cha_id1,cha_id2,cha_id2,cha_id1);

	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.DelFriend(?,?)}", "dbo", "DelFriend", 2, &cha_id1, &cha_id2);
	return (DBOK(l_ret))?true:false;
}

//==========TBLMaster===============================
int TBLMaster::GetMasterCount(long cha_id)
{
	int l_retrow	=0;
	char filter[200];

	//char* param1 = "count(*) num";
	//sprintf(filter, "(cha_id1=%d)", cha_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id1=%d)", cha_id);
	//if(_get_row(m_buf, MASTER_MAXCOL, param1, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	if(_get_row_stored_procedure(m_buf, MASTER_MAXCOL, "{CALL dbo.GetMasterCount(?)}", "dbo", "GetMasterCount", &l_retrow, 1, &cha_id) && l_retrow == 1 && get_affected_rows() == 1)
	{
		return atoi(m_buf[0].c_str());
	}else
	{
		return -1;
	}
}

int TBLMaster::GetPrenticeCount(long cha_id)
{
	int l_retrow	=0;
	char filter[200];

	//char* param1 = "count(*) num";
//	sprintf(filter, "(cha_id2=%d AND finish=0)", cha_id);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id2=%d AND finish=0)", cha_id);
	//if(_get_row(m_buf, MASTER_MAXCOL, param1, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	if(_get_row_stored_procedure(m_buf, MASTER_MAXCOL, "{CALL dbo.GetPrenticeCount(?)}", "dbo", "GetPrenticeCount", &l_retrow, 1, &cha_id) && l_retrow == 1 && get_affected_rows() == 1)
	{
		return atoi(m_buf[0].c_str());
	}else
	{
		return -1;
	}
}

int TBLMaster::HasMaster(long cha_id1,long cha_id2)
{
	int l_retrow	=0;
	//char filter[200];

	//char* param1 = "count(*) num";
	//sprintf(filter, "(cha_id1=%d AND cha_id2=%d)", cha_id1, cha_id2);
	//_snprintf_s(filter,sizeof(filter),_TRUNCATE, "(cha_id1=%d AND cha_id2=%d)", cha_id1, cha_id2);
	//if(_get_row(m_buf, MASTER_MAXCOL, param1, filter,&l_retrow) && l_retrow ==1 && get_affected_rows() ==1)
	if(_get_row_stored_procedure(m_buf, MASTER_MAXCOL, "{CALL dbo.HasMaster(?,?)}", "dbo", "HasMaster", &l_retrow, 2, &cha_id1, &cha_id2) && l_retrow == 1 
		&& get_affected_rows() == 1)
	{
		return atoi(m_buf[0].c_str());
	}else
	{
		return -1;
	}
}

bool TBLMaster::AddMaster(long cha_id1,long cha_id2)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "insert %s (cha_id1,cha_id2,finish) values(%d,%d,%d)",
//		_get_table(),cha_id1,cha_id2,0);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "insert %s (cha_id1,cha_id2,finish) values(%d,%d,%d)",
	//	_get_table(),cha_id1,cha_id2,0);
	
	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.AddMaster(?,?)}", "dbo", "AddMaster", 2, &cha_id1, &cha_id2);
	return (DBOK(l_ret))?true:false;
}

bool TBLMaster::DelMaster(long cha_id1,long cha_id2)
{
	//char sql[SQL_MAXLEN];

//	sprintf(sql, "delete %s where (cha_id1=%d AND cha_id2 =%d)",
//		_get_table(),cha_id1,cha_id2);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "delete %s where (cha_id1=%d AND cha_id2 =%d)",
	//	_get_table(),cha_id1,cha_id2);

	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.DelMaster(?,?)}", "dbo", "DelMaster", 2, &cha_id1, &cha_id2);
	return (DBOK(l_ret))?true:false;
}

bool TBLMaster::FinishMaster(long cha_id)
{
	char sql[SQL_MAXLEN];

//	sprintf(sql, "update %s set finish=1 where cha_id1=%d",
//		_get_table(),cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, "update %s set finish=1 where cha_id1=%d",
	//	_get_table(),cha_id);

	//SQLRETURN l_ret =Exec_sql_direct(sql, this);
	SQLRETURN l_ret = stored_procedure("{CALL dbo.FinishMaster(?)}", "dbo", "FinishMaster", 1, &cha_id);
	return (DBOK(l_ret))?true:false;
}

bool TBLMaster::InitMasterRelation(map<uLong, uLong> &mapMasterRelation)
{
	static char const query_master_format[SQL_MAXLEN] =
		"select cha_id1 cha_id1,cha_id2 cha_id2 from %s";

	bool ret = false;
	char sql[SQL_MAXLEN];
	//sprintf(sql, query_master_format,_get_table());
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, query_master_format,_get_table());

	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found = true;

	try
	{
		do
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
			int i = 0;
			for ( i = 0; i < col_num; ++ i)
			{
				SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
			}

			// Fetch each Row
			for (i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
			{
				if (sqlret != SQL_SUCCESS) handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

				uLong ulPID = atoi((char const *)_buf[0]);
				uLong ulMID = atoi((char const *)_buf[1]);

				mapMasterRelation[ulPID] = ulMID;
			}

			SQLFreeStmt(hstmt, SQL_CLOSE);
			SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
			SQLFreeStmt(hstmt, SQL_UNBIND);
			ret = true;

		} while (0);
	}
	catch (...)
	{
		LogLine	l_line(g_LogMaster);
		l_line<<newln<<"Unknown Exception raised when InitMasterRelation()";
	}

	if (hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return ret;
}

bool TBLMaster::GetMasterData(master_dat* farray, int& array_num, unsigned int cha_id)
{
	//static char const query_master_format[SQL_MAXLEN] =
	//	"select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( \
		select distinct master.relation relation from character INNER JOIN \
		master ON character.cha_id = master.cha_id2 where master.cha_id1 = %d \
		) cc union select master.relation relation,count(character.mem_addr) addr,0 \
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON \
		character.cha_id = master.cha_id2 where master.cha_id1 = %d group by relation \
		union select master.relation relation,character.mem_addr addr,character.cha_id \
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto \
		from character INNER JOIN master ON character.cha_id = master.cha_id2 \
		where master.cha_id1 = %d order by relation,cha_id,icon";

	if (farray == NULL || array_num <= 0 || cha_id == 0) return false;

	bool ret = false;
	char sql[] = "{CALL dbo.GetMasterData(?)}";
	//sprintf(sql, query_master_format, cha_id, cha_id, cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, query_master_format, cha_id, cha_id, cha_id);
	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found = true;

	// Time complexity to find in an unordered_map: O(1) (average).
	std::vector<SQLParamData>* cached_params = nullptr;
	auto					   cache		 = _cached_map.find(std::string("GetMasterData"));
	if(cache == _cached_map.end())
	{
		// Procedure wasn't cached yet.
		cache_stored_procedure(1, "dbo", "GetMasterData");
		cache = _cached_map.find(std::string("GetMasterData"));

		if(cache != _cached_map.end())
		{
			cached_params = &(*cache).second;

		} else
		{
			LG2("util_db", "Could not find cached map for procedure: [%s]\n", "GetMasterData");
			return false;
		}

	} else
	{
		cached_params = &(*cache).second;
	}

	try
	{
		do
		{
			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
			if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				throw 1;
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
				const char* param_pointer = (const char*)&cha_id;

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
			int i = 0;
			for ( i = 0; i < col_num; ++ i)
			{
				SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
			}

			// Fetch each Row
			for (i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
			{
				if (i >= array_num)
				{
					break;
				}

				if (sqlret != SQL_SUCCESS) handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

				farray[i].relation = (char const *)_buf[0];
				farray[i].memaddr = atoll((char const *)_buf[1]);
				farray[i].cha_id = atoi((char const *)_buf[2]);
				farray[i].cha_name = (char const *)_buf[3];
				farray[i].icon_id = atoi((char const *)_buf[4]);
				farray[i].motto = (char const *)_buf[5];
			}

			array_num = i; // ȡ��������

			SQLFreeStmt(hstmt, SQL_CLOSE);
			SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
			SQLFreeStmt(hstmt, SQL_UNBIND);
			ret = true;

		} while (0);
	}
	catch (...)
	{
		LogLine	l_line(g_LogMaster);
		l_line<<newln<<"Unknown Exception raised when GetMasterData()";
	}

	if (hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return ret;
}

bool TBLMaster::GetPrenticeData(master_dat* farray, int& array_num, unsigned int cha_id)
{
	//static char const query_prentice_format[SQL_MAXLEN] =
	//	"select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( \
		select distinct master.relation relation from character INNER JOIN \
		master ON character.cha_id = master.cha_id1 where master.cha_id2 = %d \
		) cc union select master.relation relation,count(character.mem_addr) addr,0 \
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON \
		character.cha_id = master.cha_id1 where master.cha_id2 = %d group by relation \
		union select master.relation relation,character.mem_addr addr,character.cha_id \
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto \
		from character INNER JOIN master ON character.cha_id = master.cha_id1 \
		where master.cha_id2 = %d order by relation,cha_id,icon";

	if (farray == NULL || array_num <= 0 || cha_id == 0) return false;

	bool ret = false;
	char sql[] = "{CALL dbo.GetPrenticeData(?)}";
	//sprintf(sql, query_prentice_format, cha_id, cha_id, cha_id);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE, query_prentice_format, cha_id, cha_id, cha_id);
	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found = true;

	// Time complexity to find in an unordered_map: O(1) (average).
	std::vector<SQLParamData>* cached_params = nullptr;
	auto					   cache		 = _cached_map.find(std::string("GetPrenticeData"));
	if(cache == _cached_map.end())
	{
		// Procedure wasn't cached yet.
		cache_stored_procedure(1, "dbo", "GetPrenticeData");
		cache = _cached_map.find(std::string("GetPrenticeData"));

		if(cache != _cached_map.end())
		{
			cached_params = &(*cache).second;

		} else
		{
			LG2("util_db", "Could not find cached map for procedure: [%s]\n", "GetPrenticeData");
			return false;
		}

	} else
	{
		cached_params = &(*cache).second;
	}

	try
	{
		do
		{
			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
			if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				throw 1;
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
				const char* param_pointer = (const char*)&cha_id;

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
			int i = 0;
			for ( i = 0; i < col_num; ++ i)
			{
				SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
			}

			// Fetch each Row
			for (i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
			{
				if (i >= array_num)
				{
					break;
				}

				if (sqlret != SQL_SUCCESS) handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

				farray[i].relation = (char const *)_buf[0];
				farray[i].memaddr = atoll((char const *)_buf[1]);
				farray[i].cha_id = atoi((char const *)_buf[2]);
				farray[i].cha_name = (char const *)_buf[3];
				farray[i].icon_id = atoi((char const *)_buf[4]);
				farray[i].motto = (char const *)_buf[5];
			}

			array_num = i; // ȡ��������

			SQLFreeStmt(hstmt, SQL_CLOSE);
			SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
			SQLFreeStmt(hstmt, SQL_UNBIND);
			ret = true;

		} while (0);
	}
	catch (...)
	{
		LogLine	l_line(g_LogMaster);
		l_line<<newln<<"Unknown Exception raised when GetPrenticeData()";
	}

	if (hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return ret;
}

//==========TBLGuilds===============================
bool TBLGuilds::IsReady()
{
	int l_retrow	=0;
	char* param = "count(*)";
	if(_get_row(m_buf, 1, param, 0,&l_retrow))
	{
		if(l_retrow ==1 && get_affected_rows() ==1 && atoi(m_buf[0].c_str()) ==199)
		{
			return true;
		}
	}
	return false;
}
int TBLGuilds::FetchRowByName(const char *guild_name)
{
	int l_retrow	=0;
	//char* param = "guild_id";
	//char filter[200];
	//sprintf(filter, "guild_name='%s'", guild_name);
	char buff[66];
	size_t size;
	memset(buff, 0, sizeof(buff));
	int nResult = Util::ConvertDBParam( guild_name, buff, sizeof(buff), size); 
	
	//_snprintf_s(filter, sizeof(filter), _TRUNCATE, "guild_name='%s'", buff);

	//if(_get_row(m_buf, 1, param, filter,&l_retrow))
	if(_get_row_stored_procedure(m_buf, 1, "{CALL dbo.GuildFetchRowByName(?)}", "dbo", "GuildFetchRowByName", &l_retrow, 1, buff))
	{
		if(l_retrow ==1 && get_affected_rows() ==1)
		{
			return l_retrow;
		}else
		{
			return 0;
		}
	}else
	{
		return -1;
	}
}
bool TBLGuilds::Disband(uLong gldid)
{
	//char sql[SQL_MAXLEN];
	//sprintf(sql,	"update guild set motto ='',passwd ='',leader_id =0,stat =0,money =0,exp =0,member_total =0,try_total =0\
	//					where guild_id =%d",gldid);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update guild set motto ='',passwd ='',leader_id =0,stat =0,money =0,exp =0,member_total =0,try_total =0\
					where guild_id =%d",gldid);

	//SQLRETURN l_sqlret =Exec_sql_direct(sql, this);
	SQLRETURN l_sqlret = stored_procedure("{CALL dbo.Disband1(?)}", "dbo", "Disband1", 1, &gldid);

	if(!DBOK(l_sqlret))
	{
		if(DBNODATA(l_sqlret))
		{
			LogLine	l_line(g_LogGuild);
			//l_line<<newln<<"��ɢ����SQL����ʧ��2������ID:"<<gldid;
			l_line<<newln<<"dismiss guild SQL failed2! guild ID:"<<gldid;
			return false;
		}else
		{
			LogLine	l_line(g_LogGuild);
			//l_line<<newln<<"��ɢ����SQL����ʧ��1������ID:"<<gldid;
			l_line<<newln<<"dismiss guild SQL failed1! guild ID:"<<gldid;
			return false;	//��ͨSQL����
		}
	}
//	sprintf(sql,	"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
//						where guild_id =%d",
//				gldid);
	//_snprintf_s(sql,sizeof(sql),_TRUNCATE,"update character set guild_id =0 ,guild_stat =0,guild_permission =0\
					where guild_id =%d",
	//				gldid);

	//l_sqlret =Exec_sql_direct(sql, this);
	l_sqlret = stored_procedure("{CALL dbo.Disband2(?)}", "dbo", "Disband2", 1, &gldid);
	if(!DBOK(l_sqlret))
	{
		LogLine	l_line(g_LogGuild);
		//l_line<<newln<<"��ɢ����SQL����ʧ��3������ID:"<<gldid;
		l_line<<newln<<"dismiss guild SQL failed3! guild ID:"<<gldid;
		return false;	//��ͨSQL����
	}

	return true;
}
bool TBLGuilds::InitAllGuilds(char disband_days)
{
	// Only used on initializing.
	string sql_syntax ="";
	if(disband_days<1)
	{
		return false;
	}else
	{
		/*
		sql_syntax =
			"	select g.guild_id, g.guild_name, g.motto, g.leader_id,g.type,g.stat,\
						g.money, g.exp, g.member_total, g.try_total,g.disband_date,\
						case when g.stat>0 then DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end  ��ɢ�����ۼƷ���,\
						case when g.stat>0 then %d*24*60 -DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end ��ɢ����ʣ�����\
					from guild As g\
					where (g.guild_id >0)\
			";
		*/	
		sql_syntax =
			string("	select g.guild_id, g.guild_name, g.motto, g.leader_id,g.type,g.stat,\
						g.money, g.exp, g.member_total, g.try_total,g.disband_date,\
						case when g.stat>0 then DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end TotalMins ")
						+ string(", case when g.stat>0 then %d*24*60 -DATEDIFF(mi,g.disband_date,GETDATE()) else 0 end LeaveMins ") 
						+ string(" from guild As g where (g.guild_id >0) ");
	}

	bool l_ret = false;
	char sql[SQL_MAXLEN];
	//sprintf(sql, sql_syntax.c_str(), disband_days);
	_snprintf_s(sql,sizeof(sql),_TRUNCATE, sql_syntax.c_str(), disband_days);

	// ִ�в�ѯ����
	SQLRETURN sqlret;
	SQLHSTMT hstmt	= SQL_NULL_HSTMT;
	SQLSMALLINT col_num = 0;
	bool found		= true;

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

		// Fetch each Row	int i; // ȡ��������
		for (int f_row = 1; (sqlret = SQLFetch(hstmt)) == SQL_SUCCESS || sqlret == SQL_SUCCESS_WITH_INFO; ++ f_row)
		{
			if (sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			}
			Guild *l_gld	=Guild::Alloc();
			l_gld->m_id		=atol((cChar *)_buf[0]);		//����ID
			//strcpy(l_gld->m_name, (cChar *)_buf[1]);		//������
			strncpy_s(l_gld->m_name,sizeof(l_gld->m_name), (cChar *)_buf[1],_TRUNCATE);		//������

			//strcpy(l_gld->m_motto,(cChar *)_buf[2]);		//����������
			strncpy_s(l_gld->m_motto,sizeof(l_gld->m_motto),(cChar *)_buf[2],_TRUNCATE);		//����������

			l_gld->m_leaderID=atol((cChar*)_buf[3]);		//�᳤ID
			l_gld->m_type	=atoi((cChar *)_buf[4]);		//��������
			l_gld->m_stat	=atoi((cChar *)_buf[5]);		//����״̬
			l_gld->m_remain_minute	=atol((cChar *)_buf[12]);//�����ɢʣ�������
			l_gld->m_tick	=GetTickCount();

			l_gld->BeginRun();
		}

		SQLFreeStmt(hstmt, SQL_UNBIND);
		l_ret = true;
	}catch(int&e)
	{
		LogLine	l_line(g_LogGuild);
		//l_line<<newln<<"��ʼ���������ODBC �ӿڵ��ô���InitAllGuilds()λ���룺"<<e;
		l_line<<newln<<"init guild ODBC interface failed, InitAllGuilds() error:"<<e;
	}catch (...)
	{
		LogLine	l_line(g_LogGuild);
		l_line<<newln<<"Unknown Exception raised when InitAllGuilds()";
	}

	if (hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return l_ret;
}
bool TBLGuilds::SendGuildInfo(Player *ply)
{
	WPacket l_togmSelf  =g_gpsvr->GetWPacket();
	l_togmSelf.WriteCmd( CMD_PM_GUILDINFO );
	l_togmSelf.WriteLong( ply->m_chaid[ply->m_currcha] ); // ��ɫDBID
	l_togmSelf.WriteChar(ply->GetGuild()->m_type);		//��������
	l_togmSelf.WriteLong(ply->m_guild[ply->m_currcha]);	//����ID	
	l_togmSelf.WriteLong(ply->GetGuild()->m_leaderID);	//�᳤ID	
	l_togmSelf.WriteString(ply->GetGuild()->m_name);	//����name
	l_togmSelf.WriteString(ply->GetGuild()->m_motto);	//����������
	ply->m_gate->GetDataSock()->SendData( l_togmSelf );
	return true;
}
bool TBLGuilds::InitGuildMember(Player *ply,uLong chaid,uLong gldid,int mode)
{
	bool l_ret = false;
	if(ply && gldid ==0)
	{
		WPacket l_toSelf  =g_gpsvr->GetWPacket();
		l_toSelf.WriteCmd(CMD_PC_GUILD);
		l_toSelf.WriteChar(MSG_GUILD_START);

		l_toSelf.WriteLong(0);
		l_toSelf.WriteChar(0);

		g_gpsvr->SendToClient(ply,l_toSelf);
	}else
	{
		//const char *sql_syntax =0;
		const char sql[] = "{CALL dbo.InitGuildMember(?)}";
		//sql_syntax =
		//	"	select c.mem_addr,c.cha_id, c.cha_name, c.motto, c.job, c.degree, c.icon, c.guild_permission\
					from character As c\
					where (c.guild_stat =0) and (c.guild_id =%d) and (c.delflag = 0)\
			";
		//sprintf(sql, sql_syntax, gldid);
		//_snprintf_s(sql,sizeof(sql),_TRUNCATE, sql_syntax, gldid);
		// ִ�в�ѯ����
		
		SQLRETURN sqlret;
		SQLHSTMT hstmt	= SQL_NULL_HSTMT;
		SQLSMALLINT col_num = 0;
		bool found		= true;

		// Time complexity to find in an unordered_map: O(1) (average).
		std::vector<SQLParamData>* cached_params = nullptr;
		auto					   cache		 = _cached_map.find(std::string("InitGuildMember"));
		if(cache == _cached_map.end())
		{
			// Procedure wasn't cached yet.
			cache_stored_procedure(1, "dbo", "InitGuildMember");
			cache = _cached_map.find(std::string("InitGuildMember"));

			if(cache != _cached_map.end())
			{
				cached_params = &(*cache).second;

			} else
			{
				LG2("util_db", "Could not find cached map for procedure: [%s]\n", "InitGuildMember");
				return false;
			}

		} else
		{
			cached_params = &(*cache).second;
		}
		try
		{
			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
			if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

				throw 1;
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
				const char* param_pointer = (const char*)&gldid;

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
			WPacket l_toGuild =g_gpsvr->GetWPacket();
			l_toGuild.WriteCmd(CMD_PC_GUILD);
			if(mode)
			{
				l_toGuild.WriteChar(MSG_GUILD_ADD);
			}else
			{
				l_toGuild.WriteChar(MSG_GUILD_ONLINE);
				l_toGuild.WriteLong(chaid);
			}

			WPacket l_toSelf,l_wpk0;
			if(ply)
			{
				l_wpk0  =g_gpsvr->GetWPacket();
				l_wpk0.WriteCmd(CMD_PC_GUILD);
				l_wpk0.WriteChar(MSG_GUILD_START);
			}
			bool	l_hrd	=false;

			// Check stack size! 
			Player *l_plylst[10240];
			// 40kB ^
			short	l_plynum	=0;

			long lPacketNum = 0;

			// Fetch each Row	int i; // ȡ��������
			int f_row = 1;
			for (f_row = 1; (sqlret = SQLFetch(hstmt)) == SQL_SUCCESS || sqlret == SQL_SUCCESS_WITH_INFO; ++ f_row)
			{
				if (sqlret != SQL_SUCCESS)
				{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				}
				if(ply && (f_row %20) ==1)
				{
					l_toSelf	=l_wpk0;
				}
				if(ply && !l_hrd)
				{
					l_hrd	=true;
					l_toSelf.WriteLong(ply->m_guild[ply->m_currcha]);	//����ID
					l_toSelf.WriteString(ply->GetGuild()->m_name);		//����name
					l_toSelf.WriteLong(ply->GetGuild()->m_leaderID);	//�᳤ID
				}
				unsigned long long l_memaddr		=atoll((cChar *)_buf[0]);
				if(l_memaddr)
				{
					l_plylst[l_plynum]	=(Player*)MakePointer(l_memaddr);
					l_plynum++;
				}
				if(mode && chaid ==atol((cChar*)_buf[1]))
				{
					l_toGuild.WriteChar(l_memaddr?1:0);			//online
					l_toGuild.WriteLong(atol((cChar*)_buf[1]));	//chaid
					l_toGuild.WriteString(	(cChar*)_buf[2]);	//chaname
					l_toGuild.WriteString(	(cChar*)_buf[3]);	//motto
					//l_toGuild.WriteString(	(cChar*)_buf[4]);	//job
					l_toGuild.WriteString( g_GetJobName(atoi((const char*)_buf[4])) );	//job

					l_toGuild.WriteShort(atoi((cChar*)_buf[5]));//degree
					l_toGuild.WriteShort(atoi((cChar*)_buf[6]));//icon
					l_toGuild.WriteShort(atoi((cChar*)_buf[7]));//permission
				}
				if(ply)
				{
					l_toSelf.WriteChar(l_memaddr?1:0);			//online
					l_toSelf.WriteLong(atol((cChar*)_buf[1]));	//chaid
					l_toSelf.WriteString(	(cChar*)_buf[2]);	//chaname
					l_toSelf.WriteString(	(cChar*)_buf[3]);	//motto
					//l_toSelf.WriteString(	(cChar*)_buf[4]);	//job

					l_toSelf.WriteString( g_GetJobName(atoi((const char*)_buf[4])) );	//job

					l_toSelf.WriteShort(atoi((cChar*)_buf[5]));	//degree
					l_toSelf.WriteShort(atoi((cChar*)_buf[6]));	//icon
					l_toSelf.WriteShort(atoi((cChar*)_buf[7]));	//permission
				}
				if(ply && !(f_row %20))
				{
					l_toSelf.WriteLong(lPacketNum);
					lPacketNum++;
					l_toSelf.WriteChar(((f_row-1)%20)+1);	//���ΰ���������
					g_gpsvr->SendToClient(ply,l_toSelf);
				}
			}
			if(ply && (f_row%20) ==1)
			{
				l_toSelf	=l_wpk0;
			}
			if(ply && !l_hrd)
			{
				l_hrd	=true;
				l_toSelf.WriteLong(ply->m_guild[ply->m_currcha]);	//����ID
				l_toSelf.WriteString(ply->GetGuild()->m_name);		//����name
				l_toSelf.WriteLong(ply->GetGuild()->m_leaderID);	//�᳤ID
			}
			if(ply)
			{
				l_toSelf.WriteLong(lPacketNum);
				lPacketNum++;
				l_toSelf.WriteChar((f_row -1)%20);
				g_gpsvr->SendToClient(ply,l_toSelf);
			}
			LogLine	l_line(g_LogGuild);
			//l_line<<newln<<"����֪ͨ�Ļ�������"<<l_plynum<<endln;
			l_line<<newln<<"online guild num:"<<l_plynum<<endln;
			g_gpsvr->SendToClient(l_plylst,l_plynum,l_toGuild);

			SQLFreeStmt(hstmt, SQL_UNBIND);
			l_ret = true;
		}catch(int&e)
		{
			LogLine	l_line(g_LogGuild);
			//l_line<<newln<<"��ʼ���������ODBC �ӿڵ��ô���InitGuildMember()λ���룺"<<e;
			l_line<<newln<<"init guild ODBC interface failed, InitGuildMember() error:"<<e;

			l_line<<newln<<sql;
		}catch (...)
		{
			LogLine	l_line(g_LogGuild);
			l_line<<newln<<"Unknown Exception raised when InitGuildMember()";
		}

		if (hstmt != SQL_NULL_HSTMT)
		{
			SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
			hstmt = SQL_NULL_HSTMT;
		}
	}

	return l_ret;
}
//���ҹ����Ա��
bool TBLGuilds::GetGuildMemberNum( uLong gldid, InterLockedLong& memberNum )
{
	string buf[1];
	//char filter[180];	
	//char* param = "member_total";
	//_snprintf_s( filter, sizeof(filter), _TRUNCATE, " guild_id = %d ", gldid );
	
	int l_retrow = 0;
	bool l_ret=false;
	//l_ret = _get_row(m_buf, 1, param, filter, &l_retrow);
	l_ret = _get_row_stored_procedure(m_buf, 1, "{CALL dbo.GetGuildMemberNum(?)}", "dbo", "GetGuildMemberNum", &l_retrow, 1, &gldid);
	if( l_ret&&l_retrow>0 )
	{
		memberNum = atoi(m_buf[0].c_str());
		return true;
	}
	return false;
}

bool TBLParam::InitParam(void)
{
	string strSQL = "select param1,param2,param3,param4,param5,param6,param7,param8,param9,param10 from param where id = 1";
//	string strSQL = "select param1 from param where id = 1";

	SQLRETURN sqlret;
	SQLHSTMT hstmt	= SQL_NULL_HSTMT;
	SQLLEN buf_len[MAXORDERNUM+MAXORDERNUM];
//	SQLINTEGER		nID = 0,nlen;
	bool found		= true;

	try
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			throw 1;
		}
		sqlret = SQLSetStmtAttr( hstmt,SQL_ATTR_ROW_ARRAY_SIZE,(SQLPOINTER)1,0);
		if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			throw 1;
		}
		SQLBindCol(hstmt, 1, SQL_C_LONG, &m_nOrder[0].nid, 0, &(buf_len[0]));
		SQLBindCol(hstmt, 2, SQL_C_LONG, &m_nOrder[1].nid, 0, &buf_len[1]);
		SQLBindCol(hstmt, 3, SQL_C_LONG, &m_nOrder[2].nid, 0, &buf_len[2]);
		SQLBindCol(hstmt, 4, SQL_C_LONG, &m_nOrder[3].nid, 0, &buf_len[3]);
		SQLBindCol(hstmt, 5, SQL_C_LONG, &m_nOrder[4].nid, 0, &buf_len[4]);

		SQLBindCol(hstmt, 6, SQL_C_LONG, &m_nOrder[0].nfightpoint, 0, &buf_len[5]);
		SQLBindCol(hstmt, 7, SQL_C_LONG, &m_nOrder[1].nfightpoint, 0, &buf_len[6]);
		SQLBindCol(hstmt, 8, SQL_C_LONG, &m_nOrder[2].nfightpoint, 0, &buf_len[7]);
		SQLBindCol(hstmt, 9, SQL_C_LONG, &m_nOrder[3].nfightpoint, 0, &buf_len[8]);
		SQLBindCol(hstmt, 10,SQL_C_LONG, &m_nOrder[4].nfightpoint, 0, &buf_len[9]);
		sqlret = SQLExecDirect(hstmt,(SQLCHAR *)const_cast<char*>(strSQL.c_str()),SQL_NTS);
		if (sqlret != SQL_SUCCESS)
		{
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			if (sqlret != SQL_SUCCESS_WITH_INFO)
				throw 2;
		}

		sqlret = SQLFetch(hstmt);
		if (sqlret != SQL_SUCCESS)
		{
			// Modfi by lark.li 20080714 begin
			if(sqlret != SQL_NO_DATA)
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			// End
		}
		SQLFreeStmt(hstmt, SQL_CLOSE);
		SQLFreeStmt(hstmt, SQL_UNBIND);	}
	catch(int&e)
	{
		LogLine	l_line(g_LogGarner2);
		//l_line<<newln<<"��ʼ���������ODBC �ӿڵ��ô���InitParam()λ���룺"<<e;
		l_line<<newln<<"init guild ODBC interface failed, InitParam() error:"<<e;
	}catch (...)
	{
		LogLine	l_line(g_LogGarner2);
		l_line<<newln<<"Unknown Exception raised when InitParam()";
	}

	char buff[255];
	int nlev;
	try
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			throw 1;
		}
		SQLBindCol(hstmt, 1, SQL_C_CHAR, _buf[0], MAX_DATALEN, &buf_len[0]);
		SQLBindCol(hstmt, 2, SQL_C_CHAR, _buf[1], MAX_DATALEN, &buf_len[1]);
		SQLBindCol(hstmt, 3, SQL_C_ULONG, &nlev, 0, &buf_len[2]);
		for(int n = 0;n<MAXORDERNUM;n++)
		{
			//sprintf(buff,"select cha_name,job,degree from character where cha_id = %d ",m_nOrder[n].nid);
			_snprintf_s(buff,sizeof(buff),_TRUNCATE,"select cha_name,job,degree from character where cha_id = %d ",m_nOrder[n].nid);

			sqlret = SQLExecDirect(hstmt,(SQLCHAR *)buff,SQL_NTS);
			if (sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				if (sqlret != SQL_SUCCESS_WITH_INFO)
					throw 2;
			}
			int i =0;
			if((sqlret = SQLFetch(hstmt)) != SQL_NO_DATA) 
			{
				if(sqlret == SQL_NO_DATA)
				{
					LogLine	l_line(g_LogGarner2);
					//l_line<<newln<<"��ɫ����ѯ�����ˡ���ɫID��"<<m_nOrder[n].nid;
					l_line<<newln<<"cha name query failed .cha ID��"<<m_nOrder[n].nid;
					continue;

				}
				if (sqlret != SQL_SUCCESS)
				{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				}
				if(buf_len[0] >20 )
				{
					LogLine	l_line(g_LogGarner2);
					//l_line<<newln<<"��ɫ����ѯ�����ˡ�";
					l_line<<newln<<"cha name query failed.";
					return false;
				}
				memcpy(m_nOrder[n].strname,_buf[0],buf_len[0]);
				m_nOrder[n].strname[buf_len[0]]='\0';

				memcpy(m_nOrder[n].strjob,g_GetJobName(atoi((const char*)_buf[1])),buf_len[1]);
				m_nOrder[n].strjob[buf_len[1]]='\0';

				m_nOrder[n].nlev = nlev;
			}
			SQLFreeStmt(hstmt, SQL_CLOSE);
		}
		SQLFreeStmt(hstmt, SQL_UNBIND);
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
	}
	catch(int&e)
	{
		LogLine	l_line(g_LogGarner2);
		//l_line<<newln<<"��ʼ���������ODBC �ӿڵ��ô���InitParam()λ���룺"<<e;
		l_line<<newln<<"init guild ODBC interface failed, InitParam() erro :"<<e;
	}catch (...)
	{
		LogLine	l_line(g_LogGarner2);
		l_line<<newln<<"Unknown Exception raised when InitParam()";
	}
	return true;
}

bool TBLParam::SaveParam(void)
{
	//char buff[255];
	//sprintf(buff,"update %s set param1 = %d,param2 = %d,param3 = %d,param4 = %d,param5 = %d,param6 = %d,param7 = %d,param8 = %d,param9 = %d,param10 = %d where id = 1",_get_table(),m_nOrder[0].nid,m_nOrder[1].nid,m_nOrder[2].nid,m_nOrder[3].nid,m_nOrder[4].nid,m_nOrder[0].nfightpoint,m_nOrder[1].nfightpoint,m_nOrder[2].nfightpoint,m_nOrder[3].nfightpoint,m_nOrder[4].nfightpoint);
	//_snprintf_s(buff,sizeof(buff),_TRUNCATE,"update %s set param1 = %d,param2 = %d,param3 = %d,param4 = %d,param5 = %d,param6 = %d,param7 = %d,param8 = %d,param9 = %d,param10 = %d where id = 1",_get_table(),m_nOrder[0].nid,m_nOrder[1].nid,m_nOrder[2].nid,m_nOrder[3].nid,m_nOrder[4].nid,m_nOrder[0].nfightpoint,m_nOrder[1].nfightpoint,m_nOrder[2].nfightpoint,m_nOrder[3].nfightpoint,m_nOrder[4].nfightpoint);

	//SQLRETURN sqlret;
	//sqlret = _db->exec_sql_direct(buff);
	SQLRETURN sqlret = stored_procedure("{CALL dbo.SaveParam(?,?,?,?,?,?,?,?,?,?)}", "dbo", "SaveParam", 10,
										&m_nOrder[0].nid, &m_nOrder[1].nid, &m_nOrder[2].nid, &m_nOrder[3].nid, &m_nOrder[4].nid,
										&m_nOrder[0].nfightpoint, &m_nOrder[1].nfightpoint, &m_nOrder[2].nfightpoint, &m_nOrder[3].nfightpoint, &m_nOrder[4].nfightpoint);
	if(sqlret != SQL_SUCCESS)
	{
		LG("ParamErr","Save Param Error SQL");
	}
	return true;
}

bool TBLParam::IsReady()
{
	int l_retrow	=0;
	char* param = "count(*)";
	if(_get_row(m_buf, 1, param, 0,&l_retrow))
	{
		if(l_retrow ==1 && get_affected_rows() ==1 && atoi(m_buf[0].c_str()) >=199)
		{
			return true;
		}
	}
	return false;
}

void TBLParam::UpdateOrder(ORDERINFO &Order)
{
	ORDERINFO ordertemp[MAXORDERNUM];

	memcpy(ordertemp,m_nOrder,sizeof(ORDERINFO)*MAXORDERNUM);


	int i = 0;
	int oldid = 0;
	for(i = 0;i< MAXORDERNUM;i++)
	{
		if(ordertemp[i].nfightpoint >= Order.nfightpoint)
		{
			if(ordertemp[i].nid == Order.nid)
				break;
			continue;
		}
		else
		{
			oldid = i;
			if(ordertemp[i].nid == Order.nid)
			{
				m_nOrder[i].nfightpoint = Order.nfightpoint;
				break;
			}
			memcpy(&m_nOrder[i++],&Order,sizeof(ORDERINFO));

			int n=-1;
			for(int a = i;a<MAXORDERNUM;)
			{
				if(ordertemp[a+n].nid == Order.nid)
				{
					n++;
					continue;
				}

				if(a+n < MAXORDERNUM)
					memcpy(&m_nOrder[a],&ordertemp[a+n],sizeof(ORDERINFO));
				else
				{
					//strcpy(m_nOrder[a].strjob,"");
					strncpy_s(m_nOrder[a].strjob,sizeof(m_nOrder[a].strjob),"",_TRUNCATE);
					//strcpy(m_nOrder[a].strname,"");
					strncpy_s(m_nOrder[a].strname,sizeof(m_nOrder[a].strname),"",_TRUNCATE);
					m_nOrder[a].nid = -1;
					m_nOrder[a].nlev = 0;
					m_nOrder[a].nfightpoint=0;
				}
				a++;
			}

			SaveParam();
			WPacket l_wpk = g_gpsvr->GetWPacket();
			l_wpk.WriteCmd(CMD_PM_GARNER2_UPDATE);
			for(i = 0;i < MAXORDERNUM;i++)
			{
				l_wpk.WriteLong(m_nOrder[i].nid);
			}
			l_wpk.WriteLong(oldid);
			l_wpk.WriteLong(0);
			for(int j=0;j<GroupServerApp::GATE_MAX;j++)
			{
				if(g_gpsvr->m_gate[j].GetDataSock())
				{
					g_gpsvr->m_gate[j].GetDataSock()->SendData(l_wpk);
					break;
				}
			}
			LogLine	l_line(g_LogGarner2);			
			//l_line<<newln<<"����������������";
			l_line<<newln<<"order chaned";
			break;
		}
	}
}

#ifdef SHUI_JING
bool TBLCrystalTrade::IsHasBuyorSale( long cha_id, int type )
{
	string buf[1];
	char filter[180];
	
	int isHang = 0;
	char* param = "ishang";
	_snprintf_s( filter, sizeof(filter), _TRUNCATE, " cha_id = %d and tradetype = %d ", cha_id, type );
	
	int l_retrow = 0;
	bool l_ret=false;
	l_ret = _get_row(m_buf, 1, param, filter, &l_retrow);

	if( l_ret&&l_retrow>0 )
	{
		isHang = atoi(m_buf[0].c_str());
		if( isHang == 1 )
			return true;
	}
	return false;
}
#endif
