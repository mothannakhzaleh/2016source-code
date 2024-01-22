#include "util.h"
#include "db.h"

#define SQLERR_FORMAT "SQL Error State:%s, Native Error Code: %lX, ODBC Error: %s\n"
#define COLTRUNC_WARNG "Number of columns in display truncated to %u\n"
#define NULLDATASTRING ""

#define SQL_SUC(sr) (((sr == SQL_SUCCESS) || (sr == SQL_SUCCESS_WITH_INFO) || (sr == SQL_NO_DATA_FOUND)) ? true : false)
#define DBFAIL(sr) ((sr != SQL_SUCCESS) && (sr != SQL_SUCCESS_WITH_INFO))


//TODO: Could be loaded from .CFG 
#define LOG_UTIL_DB_ENABLE 0
#ifdef _DEBUG
#define LOG_UTIL_DB_ENABLE 1
#endif

const char g_cchLogUtilDb = LOG_UTIL_DB_ENABLE;

cfl_db::cfl_db() : _henv(SQL_NULL_HENV), _hdbc(SQL_NULL_HDBC), _rslist()
{
    _connected = false;
    _dump_errinfo = false;
	_connstr = "";

	_rslist.clear();
}

cfl_db::~cfl_db()
{
    if (_connected)
    {
        disconn();
		_rslist.clear();
        _connected = false;
    }
}

void cfl_db::add(cfl_rs* rs)
{
	if (rs == NULL) return;

	vector<cfl_rs *>::iterator it = _rslist.begin();
	bool found = false;
	while (it != _rslist.end())
	{
		if (rs == *(it)) {found = true; break;}
		++ it;
	}

	if (!found) _rslist.push_back(rs);
}

bool cfl_db::handle_err(SQLHANDLE h, SQLSMALLINT t,
                        RETCODE r, char const* sql /* = NULL */,
						bool reconn /* = false */)
{
	//if (!_connected) return;

#define DBLOG printf
    SQLRETURN sqlret;
    SQLCHAR state[SQL_SQLSTATE_SIZE + 1] = {0};
    SQLINTEGER error;
	SQLCHAR msg[SQL_MAX_MESSAGE_LENGTH + 1] = {0};
    SQLSMALLINT msg_len;

	sqlret = SQLGetDiagRec(t, h, 1, state, &error, msg, SQL_MAX_MESSAGE_LENGTH, &msg_len);
    if (sqlret == SQL_ERROR || sqlret == SQL_INVALID_HANDLE) return false;

	if (_dump_errinfo)
	{
		//DBLOG(SQLERR_FORMAT, state, error, msg);

		if (g_cchLogUtilDb == 1)
			LG2("util_db", SQLERR_FORMAT, state, error, msg);

		LG2("util_db_error", SQLERR_FORMAT, state, error, msg);

		if (sql != NULL)
		{
			if (g_cchLogUtilDb == 1)
	            LG2("util_db", "[STMT:0x%x][SQLERR]: [%s]\n", h, sql);
			
			LG2("util_db_error", "[STMT:0x%x][SQLERR]: [%s]\n", h, sql);
		}
	}

	// Reconnect...
    if (reconn && _needreconn((char const *)state))
	{
		return _reconnt();
	}
	return false;
}

bool cfl_db::_needreconn(char const* state)
{
	bool ret = false;

#if 1
	if (strcmp(state, "HYT00") == 0) ret = true;
	else if (strcmp(state, "HYT01") == 0) ret = true;
	else if (strcmp(state, "01000") == 0) ret = true;
	else if (strcmp(state, "08S01") == 0) ret = true;
#endif

	return ret;
}

bool cfl_db::_reconnt()
{
	string err_info;
    cfl_rs* tmp = NULL;

	printf( "connecting database ...\n" );
	LG2("util_db_error", "connecting database...\n");
    vector<cfl_rs *>::iterator it = _rslist.begin();
    while (it != _rslist.end())
    {
        tmp = (cfl_rs *)*(it);
		if (g_cchLogUtilDb == 1)
	        LG2("util_db", "notify %p the disconn message\n", tmp);
        tmp->notify_discon(this);

        ++ it;
    }

	disconn();

	printf( "ready connect database...\n" );
	LG2("util_db_error", "ready connect database...\n");
	if (g_cchLogUtilDb == 1)
		LG2("util_db", "begin to reconnect database\n");
	while (!_connect(err_info))
	{
		if (g_cchLogUtilDb == 1)
			LG2("util_db", "reconnect database failed: %s\n", err_info.c_str());
		Sleep(1000);
		printf( "reconnect database...\n" );
		LG2("util_db_error", "reconnect database...\n");
	}

	printf( "reconnect database success!\n" );
	LG2("util_db_error", "reconnect database success!\n");
	if (g_cchLogUtilDb == 1)
		LG2("util_db", "reconnect database successfully\n");

	it = _rslist.begin();
	while (it != _rslist.end())
	{
		tmp = (cfl_rs *)*(it);
		if (g_cchLogUtilDb == 1)
			LG2("util_db", "notify %p the reconnect message\n", tmp);
		tmp->notify_reconn(this);

		++ it;
	}

	printf( "reconnect database ok!\n" );
	LG2("util_db_error", "reconnect database ok!\n");
	return true;
}

bool cfl_db::_connect(string& errinfo)
{
	bool ret = true;
	SQLRETURN sqlret;
	char outbuf[2048];
	SQLSMALLINT outlen = 0;

	do
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &_henv);
		if (sqlret == SQL_ERROR)
		{
			errinfo = "Unable to allocate an environment handle\n";
			ret = false;
			break;
		}

		// Let ODBC know this is an ODBC 3.0 application
		sqlret = SQLSetEnvAttr(_henv, SQL_ATTR_ODBC_VERSION,
			                   (SQLPOINTER)SQL_OV_ODBC3, SQL_IS_INTEGER);
		if (DBFAIL(sqlret))
		{
			handle_err(_henv, SQL_HANDLE_ENV, sqlret);

			errinfo = "Error in calling SQLSetEnvAttr\n";
			SQLFreeHandle(SQL_HANDLE_ENV, _henv);
			ret = false;
			break;
		}

		sqlret = SQLAllocHandle(SQL_HANDLE_DBC, _henv, &_hdbc);
		if (DBFAIL(sqlret))
		{
			handle_err(_henv, SQL_HANDLE_ENV, sqlret);

			errinfo = "Unable to allocate an dbc handle\n";
			SQLFreeHandle(SQL_HANDLE_DBC, _hdbc);
			SQLFreeHandle(SQL_HANDLE_ENV, _henv);
			ret = false;
			break;
		}

		//SQLSetConnectAttr(_hdbc, SQL_COPT_SS_MARS_ENABLED, (SQLPOINTER)SQL_MARS_ENABLED_YES, SQL_IS_UINTEGER);


		sqlret = SQLDriverConnectA(_hdbc, NULL, (SQLCHAR *)_connstr.c_str(),
								  SQL_NTS, (SQLCHAR *)outbuf, sizeof outbuf,
								  &outlen, SQL_DRIVER_NOPROMPT);
		if (DBFAIL(sqlret))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

            errinfo = "Unable to connect database\n";
			SQLFreeHandle(SQL_HANDLE_DBC, _hdbc);
			SQLFreeHandle(SQL_HANDLE_ENV, _henv);
			ret = false;
			break;
		}

		//char command[256];

		//sprintf(command, "use %s", DATABASE);
		//if (!SQL_SUCCEEDED(SQLExecDirect(_hdbc, (SQLCHAR *) command, SQL_NTS))) 
		//{
		//	handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

  //          errinfo = "Unable to connect database\n";
		//	SQLFreeHandle(SQL_HANDLE_DBC, _hdbc);
		//	SQLFreeHandle(SQL_HANDLE_ENV, _henv);
		//	ret = false;
		//	break;
		//}

        //handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

		//int v;
		//SQLGetConnectAttr(_hdbc, SQL_ATTR_CONNECTION_TIMEOUT,(SQLPOINTER)(&v), 0 ,NULL);
        sqlret = SQLSetConnectAttr(_hdbc, SQL_ATTR_CONNECTION_TIMEOUT,
								   (void *)10, 0);

		//SQLGetConnectAttr(_hdbc, SQL_ATTR_CONNECTION_TIMEOUT,(SQLPOINTER)(&v), 0 ,NULL);
		if (DBFAIL(sqlret))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

            errinfo = "Unable set timeout to database\n";
			SQLFreeHandle(SQL_HANDLE_DBC, _hdbc);
			SQLFreeHandle(SQL_HANDLE_ENV, _henv);
			ret = false;
			break;
		}

		//exec_sql_direct(_openDatabase.c_str());

		// Set connect flag...
		_connected = true;

	}
	while (0);

	return ret;
}

bool cfl_db::connect(char* source, char* userid, char* passwd, string& err_info)
{
    if (_connected)
    {
        err_info = "Already connected\n";
        return false;
    }

	bool ret = true;
	SQLRETURN sqlret;

    do
    {
        sqlret = SQLAllocHandle(SQL_HANDLE_ENV, SQL_NULL_HANDLE, &_henv);
        if (sqlret == SQL_ERROR)
        {
            err_info = "Unable to allocate an environment handle\n";
            ret = false;
            break;
        }

        // Let ODBC know this is an ODBC 3.0 application
        sqlret = SQLSetEnvAttr(_henv, SQL_ATTR_ODBC_VERSION,
                               (SQLPOINTER)SQL_OV_ODBC3,
                               SQL_IS_INTEGER);
        if (DBFAIL(sqlret))
        {
            handle_err(_henv, SQL_HANDLE_ENV, sqlret);

            err_info = "Error in calling SQLSetEnvAttr\n";
            SQLFreeHandle(SQL_HANDLE_ENV, _henv);
            ret = false;
            break;
        }

        sqlret = SQLAllocHandle(SQL_HANDLE_DBC, _henv, &_hdbc);
        if (DBFAIL(sqlret))
        {
            handle_err(_henv, SQL_HANDLE_ENV, sqlret);

            err_info = "Unable to allocate an dbc handle\n";
            SQLFreeHandle(SQL_HANDLE_DBC, _hdbc);
            SQLFreeHandle(SQL_HANDLE_ENV, _henv);
            ret = false;
            break;
        }

        sqlret = SQLConnect(_hdbc, (SQLCHAR *)source, SQL_NTS,
                            (SQLCHAR *)userid, SQL_NTS,
						    (SQLCHAR *)passwd, SQL_NTS);
        if (DBFAIL(sqlret))
        {
            handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

            err_info = "Unable to connect database\n";
            SQLFreeHandle(SQL_HANDLE_DBC, _hdbc);
            SQLFreeHandle(SQL_HANDLE_ENV, _henv);
            ret = false;
            break;
        }

        handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);

        // Set connect flag...
        _connected = true;
    }
	while (0);

    return ret;
}

bool cfl_db::connect(const char* servername, const char* database, const char* userid, const char* passwd,
                     string& err_info)
{
    if (_connected)
    {
        err_info = "Already connected\n";
        return false;
    }

	char conn_str[1024];    
    //sprintf(conn_str, "DRIVER={SQL Server};SERVER=%s;UID=%s;PWD=%s;DATABASE=%s",
	_snprintf_s(conn_str, sizeof(conn_str), _TRUNCATE, "DRIVER={SQL Server};SERVER=%s;UID=%s;PWD=%s;DATABASE=%s",
            servername, userid, passwd, database);

	// Save connect string
	_connstr = conn_str;

	// Add by lark.li 20080902 begin
	_openDatabase = string("use ") + string(database) + string(";");
	// End

	return _connect(err_info);
}

void cfl_db::disconn()
{
    if (_connected)
    {
        SQLDisconnect(_hdbc);

        SQLFreeHandle(SQL_HANDLE_DBC, _hdbc); _hdbc = SQL_NULL_HDBC;

        SQLFreeHandle(SQL_HANDLE_ENV, _henv); _henv = SQL_NULL_HENV;

        _connected = false;
    }
}

SQLRETURN cfl_db::exec_sql_direct(char const* sql, unsigned short timeout /* = 5 */)
{
	if (!_connected) return SQL_ERROR;

RECONNECT:

	SQLRETURN sqlret;
	SQLHSTMT hstmt = SQL_NULL_HSTMT;

	do
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if (DBFAIL(sqlret))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			break;
		}

        sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
		if (DBFAIL(sqlret))		
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			break;
		}

		sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
		switch (sqlret)
		{
		case SQL_SUCCESS_WITH_INFO:
			//handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
			// fall through
		case SQL_SUCCESS:
			break;

		case SQL_ERROR:
			{
				if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
			}
			return 0;

		default:
			if (g_cchLogUtilDb == 1)
				LG2("util_db", "SQLExecDirect return %d\n", sqlret);
		}
	}
	while (0);

	if (hstmt != SQL_NULL_HSTMT) SQLFreeHandle(SQL_HANDLE_STMT, hstmt);

	return sqlret;
}

bool cfl_db::begin_tran()
{
#if 1
	if (!_connected) return false;

	SQLRETURN sqlret = SQLSetConnectAttr(_hdbc, SQL_ATTR_AUTOCOMMIT,
										 (SQLPOINTER)SQL_AUTOCOMMIT_OFF,
                                         SQL_IS_POINTER);
	return (DBFAIL(sqlret)) ? false : true;
#endif

    return true;
}

bool cfl_db::commit_tran()
{
#if 1
	if (!_connected) return false;

	SQLEndTran(SQL_HANDLE_DBC, _hdbc, SQL_COMMIT);

	SQLRETURN sqlret = SQLSetConnectAttr(_hdbc, SQL_ATTR_AUTOCOMMIT,
										 (SQLPOINTER)SQL_AUTOCOMMIT_ON,
                                         SQL_IS_POINTER);
	return (DBFAIL(sqlret)) ? false : true;
#endif

    return true;
}

bool cfl_db::rollback()
{
#if 1
	if (!_connected) return false;

	SQLEndTran(SQL_HANDLE_DBC, _hdbc, SQL_ROLLBACK);

	SQLRETURN sqlret = SQLSetConnectAttr(_hdbc, SQL_ATTR_AUTOCOMMIT,
										 (SQLPOINTER)SQL_AUTOCOMMIT_ON,
										 SQL_IS_POINTER);
	return (DBFAIL(sqlret)) ? false : true;
#endif

    return true;
}



cfl_rs::cfl_rs(cfl_db* db) :
	_db(db), _hdbc(SQL_NULL_HDBC), _hstmt(SQL_NULL_HSTMT), _max_col(MAX_COL)
{
	attach_db(db);
	db->add(this);
}

cfl_rs::cfl_rs(cfl_db* db, char const* tbl_name, int max_col)
    : _db(db), _hdbc(SQL_NULL_HDBC), _hstmt(SQL_NULL_HSTMT), _tbl_name(tbl_name)
{
	attach_db(db);
	db->add(this);

    _max_col = max_col;
    _col_num = 0;
    _row_num = 0;
    _param_num = 0;
}

cfl_rs::~cfl_rs()
{
    if (_hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeHandle(SQL_HANDLE_STMT, _hstmt);
        _hstmt = SQL_NULL_HSTMT;
    }

	_hdbc = SQL_NULL_HDBC;
    _db = NULL;
}

void cfl_rs::attach_db(cfl_db* db)
{
	if (db != _db) return;

	_hdbc = db->get_dbc();
	//SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &_hstmt);
}

void cfl_rs::notify_discon(cfl_db* db)
{
    if (_db != db) return ;

#if 1
    if (_hstmt != SQL_NULL_HSTMT)
    {
		LG2("util_db_error", "notify_discon\n");
        SQLFreeHandle(SQL_HANDLE_STMT, _hstmt);
        _hstmt = SQL_NULL_HSTMT;
    }
#endif
}

void cfl_rs::notify_reconn(cfl_db* db)
{
	attach_db(db);
}

int cfl_rs::get_affected_rows()
{
	string	 l_buf[1];
	int		 l_affected_rows	=0;
	char const	*param		=" @@ROWCOUNT ";
	string	 l_tbl_name =_tbl_name;
	_tbl_name			="";
	bool l_ret = _get_row(l_buf,1,param,0,&l_affected_rows);
    _tbl_name			=l_tbl_name;
	if(!l_ret)
	{
		return -1;	//SQL错误
	}else if(l_affected_rows !=1)
	{
		return -2;	//获取值行数错误
	}
	return atoi(l_buf[0].c_str());
}
int cfl_rs::get_identity()
{
	string	 l_buf[1];
	int		 l_affected_rows	=0;
	char const	*param		=" ISNULL(@@IDENTITY,0) ";
	string	 l_tbl_name =_tbl_name;
	_tbl_name			="";
	bool l_ret = _get_row(l_buf,1,param,0,&l_affected_rows);
	_tbl_name			=l_tbl_name;
	if(!l_ret)
	{
		return -1;	//SQL错误
	}else if(l_affected_rows !=1)
	{
		return -2;	//获取值行数错误
	}
	return atoi(l_buf[0].c_str());
}

// Add bynlark.li 20080808 begin
bool cfl_rs::_get_bin_field(char* field_text, SQLLEN& len, char* param, char* filter, int* affect_rows)
{
    bool ret = false;
    char sql[SQL_MAXLEN];
    int i = 0;

    try {
        if (param == NULL) {
            //sprintf(sql, "select * from %s", _tbl_name.c_str());
			_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select * from %s", _tbl_name.c_str());
        } else {
		    if (_tbl_name.length() !=0) {
	            //sprintf(sql, "select %s from %s", param, _tbl_name.c_str());
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s from %s", param, _tbl_name.c_str());
		    } else {
			    //sprintf(sql, "select %s",param);
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s",param);
		    }
        }

        if ((strstr(param, "@@ROWCOUNT") == NULL) &&
            (strstr(param, "@@rowcount") == NULL) &&
            (strstr(_tbl_name.c_str(), "(nolock)") == NULL) &&
            (strstr(_tbl_name.c_str(), "(NOLOCK)") == NULL)) {
            //strcat(sql, " (nolock) ");
				strncat_s(sql, sizeof(sql), " (nolock) ", _TRUNCATE);
        }

        if (filter == NULL) {
        } else {
            //strcat(sql, " where ");
			strncat_s(sql, sizeof(sql), " where ", _TRUNCATE);
            //strcat(sql, filter);
			strncat_s(sql, sizeof(sql), filter, _TRUNCATE);
        }
    } catch (...) {
		if (g_cchLogUtilDb == 1)
	        LG2("util_db", "exception raised from _get_row exec\n");
        return false;
    }

	if (g_cchLogUtilDb == 1)
	    LG2("util_db", "_get_row [SQL]: [%s]\n", sql);

RECONNECT:

    // 执行查询操作
    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLSMALLINT col_num = 0;
    bool found = true;

    do
    {
        try {        
            sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }
            } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row alloc\n"); break;}

            try {
			constexpr uint64_t timeout{50};
			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (DBFAIL(sqlret))
            {
                if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
			    return false;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row exec\n"); break;}

        try {
            sqlret = SQLNumResultCols(hstmt, &col_num);

            col_num = min(col_num, 1);

            if (col_num <= 0)
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "col_num = 0 (<=0)\n", col_num);
                break;
            }

                SQLBindCol(hstmt, UWORD(1), SQL_C_BINARY, _buf[0], len, &_buf_len[0]);

        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row bind\n"); break;}

        try {
            sqlret = SQLFetch(hstmt); // only fetch the next row
            if (DBNODATA(sqlret))
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
                found = false;
            }
            else if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
                if (sqlret != SQL_SUCCESS_WITH_INFO)
                {
                    break;
                }
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row fetch\n"); break;}

        try {
            // 拷贝数据
            if (found)
            {
                // 取数据
				len = _buf_len[0];
                if (len == SQL_NULL_DATA)
                {
                    field_text[0] = 0x0;
                }
                else
                {
                    memcpy(field_text, _buf[0], len);
                }

                if (affect_rows != NULL)
                    *affect_rows = 1;
            }
            else
            {
                // 没有取到数据
                if (affect_rows != NULL)
                    *affect_rows = 0;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row copydata\n"); break;}

        ret = true;

    }
	while (0);

    try {
        if (hstmt != SQL_NULL_HSTMT) {    
            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row freestmt\n"); ret = false;}

    return ret;
}

SQLRETURN cfl_rs::cache_stored_procedure(int numberOfParams, char const* schema,char const* procedure) {

	SQLRETURN	   sqlret;
	SQLHSTMT	   hstmt	= SQL_NULL_HSTMT;
	SQLSMALLINT	   col_num	= 0;
	unsigned short timeout	= 50;
	bool		   found	= true;
	SQLINTEGER	   data_len = SQL_NTS;
	do
	{
		try
		{
			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
			if(DBFAIL(sqlret))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				break;
			}

		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from stored_procedure alloc\n");
			break;
		}
		try
		{
			constexpr auto timeout{50};
			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
			if(DBFAIL(sqlret))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				break;
			}
			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}

			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}

			LETimer t1;
			t1.Begin();
			SQLSMALLINT tempDataType;
			SQLLEN		tempColumnSize;
			SQLLEN		templenDataType;
			SQLLEN		templenColumnSize;

			SQLSMALLINT DataType[MAX_PARAM_NUM]	  = {0};
			SQLLEN		ColumnSize[MAX_PARAM_NUM] = {0};

			sqlret = SQLProcedureColumns(hstmt, NULL, 0, (SQLCHAR*)schema, SQL_NTS, (SQLCHAR*)procedure, SQL_NTS,
										 (SQLCHAR*)"%", SQL_NTS);

			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}

			sqlret = SQLBindCol(hstmt, 6, SQL_C_SHORT, &tempDataType, sizeof(tempDataType), &templenDataType);
			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}
			sqlret = SQLBindCol(hstmt, 8, SQL_C_LONG, &tempColumnSize, sizeof(tempColumnSize), &templenColumnSize);
			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}

			for(SQLUSMALLINT i = 0; i < numberOfParams+1; i++)
			{
				sqlret = SQLFetch(hstmt);
				if(DBFAIL(sqlret))
				{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
				}
				if(i == 0) continue; // SQL sends an extra int here...
				DataType[i-1]	  = tempDataType;
				ColumnSize[i-1] = tempColumnSize;
			}
			std::vector<SQLParamData> vect_params;
			// Store to cache.
			for(SQLUSMALLINT i = 0; i < numberOfParams; i++)
			{
				SQLParamData param;
				param.sql_data_type = DataType[i];
				param.column_length = ColumnSize[i];
				vect_params.push_back(param);
			}
			_cached_map.insert({std::string(procedure), vect_params});

			if(DBFAIL(sqlret))
			{
				break;
			}

		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row exec\n");
			break;
		}
	} while(0);
	if(hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeStmt(hstmt, SQL_CLOSE);
		SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
		SQLFreeStmt(hstmt, SQL_UNBIND);
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return sqlret;
	}




bool cfl_rs::_get_row_stored_procedure(string field_text[], int field_max_cnt, char const* sql, char const* schema, char const* procedure,
							 int* affect_rows, ...)

{
	bool ret = false;
	//char sql[SQL_MAXLEN];
	int i = 0;
	va_list arg_list;
	va_start(arg_list, affect_rows);
	int numberOfParameters = va_arg(arg_list, int);

    // Time complexity to find in an unordered_map: O(1) (average).
	std::vector<SQLParamData>* cached_params = nullptr;
	auto cache =  _cached_map.find(std::string(procedure));
	if (cache == _cached_map.end()) {
		// Procedure wasn't cached yet.
		cache_stored_procedure(numberOfParameters, schema, procedure);
		cache = _cached_map.find(std::string(procedure));

		if(cache != _cached_map.end())
		{
			cached_params = &(*cache).second;

		}
		else
		{
			LG2("util_db", "Could not find cached map for procedure: [%s]\n", procedure);
			return false;

		}

	}
	else
	{
		cached_params = &(*cache).second;
	}
	//

	try
	{


	} catch(...)
	{
		if(g_cchLogUtilDb == 1)
			LG2("util_db", "exception raised from stored_procedure exec\n");
		return false;
	}

	if(g_cchLogUtilDb == 1)
		LG2("util_db", "stored_procedure[SQL]: [%s]\n", procedure);

	// the bit bellow is simply safe_sql, but because of variadic arguments we cant call it here.
RECONNECT:

	SQLRETURN	   sqlret;
	SQLHSTMT	   hstmt	= SQL_NULL_HSTMT;
	SQLSMALLINT	   col_num	= 0;
	unsigned short timeout	= 50;
	bool		   found	= true;
	SQLINTEGER	   data_len = SQL_NTS;
	do
	{
		try
		{
			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
			if(DBFAIL(sqlret))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				break;
			}

		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from stored_procedure alloc\n");
			break;
		}
		try
		{
			constexpr auto timeout{50};
			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
			if(DBFAIL(sqlret))
			{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				break;
			}
			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}

			if(DBFAIL(sqlret))
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
			}

			// Time to bind parameters.
			for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
			{
				if (!cached_params) {

					break;

				}
				SQLSMALLINT sql_data_type = cached_params->at(i).sql_data_type;
				SQLULEN column_length = cached_params->at(i).column_length;
				const char* param_pointer = va_arg(arg_list, const char*);

				sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, sql_data_type, column_length, 0,
											(SQLPOINTER)param_pointer, 0, 0);

				if(DBFAIL(sqlret))
				{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
				}
				
			}
			va_end(arg_list);

			if(DBFAIL(sqlret))
			{
				break;
			}
			
			sqlret = SQLExecDirect(hstmt, (SQLCHAR*)sql, SQL_NTS);
			switch(sqlret)
			{
			case SQL_SUCCESS_WITH_INFO:
				//handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
				// fall through
			case SQL_SUCCESS:
				break;

			case SQL_ERROR:
			{
				if(handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true))
				{
					goto RECONNECT;
				}
			}
			break;

			case SQL_NO_DATA: // update or delete
				break;

			case SQL_NEED_DATA:
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
				break;
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row exec\n");
			break;
		}

		try
		{
			sqlret = SQLNumResultCols(hstmt, &col_num);

			col_num = min(col_num, field_max_cnt);
			col_num = min(col_num, MAX_COL);
			col_num = min(col_num, _max_col);

			if(col_num <= 0)
			{
				if(g_cchLogUtilDb == 1)
					LG2("util_db", "col_num = 0 (<=0)\n", col_num);
				break;
			}

			SQLLEN numRows;
			auto	   retCode = SQLRowCount(hstmt, &numRows);

			for(i = 0; i < col_num; ++i)
			{
				SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
						   MAX_DATALEN, &_buf_len[i]);
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row bind\n");
			break;
		}

		try
		{
			sqlret = SQLFetch(hstmt); // only fetch the next row
			if(DBNODATA(sqlret))
			{
				if(g_cchLogUtilDb == 1)
					LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
				found = false;
			} else if(sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
				if(sqlret != SQL_SUCCESS_WITH_INFO)
				{
					break;
				}
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row fetch\n");
			break;
		}

		try
		{
			// 拷贝数据
			if(found)
			{
				// 取数据
				for(i = 0; i < col_num; ++i)
				{
					if(_buf_len[i] == SQL_NULL_DATA)
					{
					  field_text[i] = NULLDATASTRING;
					} else
					{
					  field_text[i] = (char*)(_buf[i]);
					}
				}

				if(affect_rows != NULL)
					*affect_rows = 1;
			} else
			{
				// 没有取到数据
				if(affect_rows != NULL)
					*affect_rows = 0;
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row copydata\n");
			break;
		}

		ret = true;

	} while(0);

	if(hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeStmt(hstmt, SQL_CLOSE);
		SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
		SQLFreeStmt(hstmt, SQL_UNBIND);
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}
	return ret;
}

bool cfl_rs::_get_row_stored_procedure_whitespace(string field_text[], int field_max_cnt, char const* sql, char const* schema, char const* procedure,
									   int* affect_rows, ...)

{
		bool ret = false;
		int	 i = 0;

		va_list arg_list;
		va_start(arg_list, affect_rows);
		int numberOfParameters = va_arg(arg_list, int);

		// Time complexity to find in an unordered_map: O(1) (average).
		std::vector<SQLParamData>* cached_params = nullptr;
		auto					   cache		 = _cached_map.find(std::string(procedure));
		if(cache == _cached_map.end())
		{
		// Procedure wasn't cached yet.
		cache_stored_procedure(numberOfParameters, schema, procedure);
		cache = _cached_map.find(std::string(procedure));

		if(cache != _cached_map.end())
		{
			cached_params = &(*cache).second;

		} else
		{
			LG2("util_db", "Could not find cached map for procedure: [%s]\n", procedure);
			return false;
		}

		} else
		{
		cached_params = &(*cache).second;
		}
		//
		if(g_cchLogUtilDb == 1)
			LG2("util_db", "_get_row3 [SQL]: [%s]\n", sql);

	RECONNECT:

		// 执行查询操作
		SQLRETURN	sqlret;
		SQLHSTMT	hstmt	= SQL_NULL_HSTMT;
		SQLSMALLINT col_num = 0;
		bool		found	= true;

		do
		{
			try
			{
				sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
				if(DBFAIL(sqlret))
				{
					handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
					break;
				}
			} catch(...)
			{
				if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 alloc\n");
				break;
			}

			try
			{
				constexpr auto timeout{50};
				sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
				if(DBFAIL(sqlret))
				{
					handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
					break;
				}


				// Time to bind parameters.
				for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
				{
					if(!cached_params)
					{
					break;
					}
					SQLSMALLINT sql_data_type = cached_params->at(i).sql_data_type;
					SQLULEN column_length = cached_params->at(i).column_length;
					const char* param_pointer = va_arg(arg_list, const char*);

					sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, sql_data_type, column_length, 0,
											  (SQLPOINTER)param_pointer, 0, 0);

					if(DBFAIL(sqlret))
					{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
					}
				}
				va_end(arg_list);

				if(DBFAIL(sqlret))
				{
					break;
				}

				sqlret = SQLExecDirect(hstmt, (SQLCHAR*)sql, SQL_NTS);
				if(DBFAIL(sqlret))
				{
					if(handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true))
					{
					  goto RECONNECT;
					}
					return false;
				}
			} catch(...)
			{
				if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 exec\n");
				break;
			}

			try
			{
				sqlret = SQLNumResultCols(hstmt, &col_num);

				col_num = min(col_num, field_max_cnt);
				col_num = min(col_num, MAX_COL);
				col_num = min(col_num, _max_col);

				if(col_num <= 0)
				{
					if(g_cchLogUtilDb == 1)
					  LG2("util_db", "col_num = 0 (<=0)\n", col_num);
					break;
				}

				for(i = 0; i < col_num; ++i)
				{
					SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
							   MAX_DATALEN, &_buf_len[i]);
				}
			} catch(...)
			{
				if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 bind\n");
				break;
			}

			try
			{
				sqlret = SQLFetch(hstmt); // only fetch the next row
				if(DBNODATA(sqlret))
				{
					if(g_cchLogUtilDb == 1)
					  LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
					found = false;
				} else if(sqlret != SQL_SUCCESS)
				{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
					if(sqlret != SQL_SUCCESS_WITH_INFO)
					{
					  break;
					}
				}
			} catch(...)
			{
				if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 fetch\n");
				break;
			}

			try
			{
				// 拷贝数据
				if(found)
				{
					// 取数据
					for(i = 0; i < col_num; ++i)
					{
					  if(_buf_len[i] == SQL_NULL_DATA)
					  {
						field_text[i] = NULLDATASTRING;
					  } else
					  {
						char* p = strchr((char*)_buf[i], ' ');
						if(p != NULL)
						{
						  *p = '\0';
						}

						field_text[i] = (char*)(_buf[i]);
					  }
					}

					if(affect_rows != NULL)
					  *affect_rows = 1;
				} else
				{
					// 没有取到数据
					if(affect_rows != NULL)
					  *affect_rows = 0;
				}
			} catch(...)
			{
				if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 copydata\n");
				break;
			}

			ret = true;

		} while(0);

		try
		{
			if(hstmt != SQL_NULL_HSTMT)
			{
				SQLFreeStmt(hstmt, SQL_CLOSE);
				SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
				SQLFreeStmt(hstmt, SQL_UNBIND);
				SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 freestmt\n");
			ret = false;
		}

		return ret;
}


bool cfl_rs::_get_rowSafely(string field_text[], int field_max_cnt, char const* param,
							char const* filter, int* affect_rows, ...)
{
	bool ret = false;
	char sql[SQL_MAXLEN];
	int	 i = 0;

    va_list arg_list;
	va_start(arg_list, affect_rows);
    int numberOfParameters = va_arg(arg_list, int);
	SQLULEN		   dataLen[MAX_PARAM_NUM];
	SQLSMALLINT	   dataTypes[MAX_PARAM_NUM];
	SQLSMALLINT	   dataDecimalDigits[MAX_PARAM_NUM];
	SQLSMALLINT	   dataNullable[MAX_PARAM_NUM];

	try
	{
		if(param == NULL)
		{
			//sprintf(sql, "select * from %s", _tbl_name.c_str());
			_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select * from %s", _tbl_name.c_str());
		} else
		{
			if(_tbl_name.length() != 0)
			{
				//sprintf(sql, "select %s from %s", param, _tbl_name.c_str());
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s from %s", param, _tbl_name.c_str());
			} else
			{
				//sprintf(sql, "select %s",param);
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s", param);
			}
		}

		if((strstr(param, "@@ROWCOUNT") == NULL) &&
		   (strstr(param, "@@rowcount") == NULL) &&
		   (strstr(_tbl_name.c_str(), "(nolock)") == NULL) &&
		   (strstr(_tbl_name.c_str(), "(NOLOCK)") == NULL))
		{
			//strcat(sql, " (nolock) ");
			strncat_s(sql, sizeof(sql), " (nolock) ", _TRUNCATE);
		}

		if(filter == NULL)
		{
		} else
		{
			//strcat(sql, " where ");
			strncat_s(sql, sizeof(sql), " where ", _TRUNCATE);
			//strcat(sql, filter);
			strncat_s(sql, sizeof(sql), filter, _TRUNCATE);
		}
	} catch(...)
	{
		if(g_cchLogUtilDb == 1)
			LG2("util_db", "exception raised from _get_row exec\n");
		return false;
	}

	if(g_cchLogUtilDb == 1)
		LG2("util_db", "_get_row [SQL]: [%s]\n", sql);

    // the bit bellow is simply safe_sql, but because of variadic arguments we cant call it here.
RECONNECT:

	SQLRETURN	   sqlret;
	SQLHSTMT	   hstmt   = SQL_NULL_HSTMT;
	SQLSMALLINT	   col_num = 0;
	unsigned short timeout = 50;
	bool		   found = true;
	do
	{
        try{
		    sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		    if(DBFAIL(sqlret))
		    {
			    handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			    break;
		    }
	    }
	    catch(...)
	    {
		if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row alloc\n");
		break;
	    }
		try
		{
		constexpr auto timeout{50};
		sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
		if(DBFAIL(sqlret))
		{
				handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
				break;
		}
		sqlret = SQLPrepare(hstmt, (SQLCHAR*)sql, SQL_NTS);

		if(DBFAIL(sqlret))
		{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
		}
		for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
		{
			    // Get info for each parameter from the prepared statement.
			    sqlret = SQLDescribeParam(hstmt, i + 1, &dataTypes[i], &dataLen[i], &dataDecimalDigits[i], &dataNullable[i]);
		}
        if(DBFAIL(sqlret))
		{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
				break;
		}

		// Time to bind parameters.
		for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
		{
				const char*	  param_pointer		= va_arg(arg_list, const char*);
				
                if (dataTypes[i] == SQL_VARBINARY || dataTypes[i] == SQL_VARCHAR) {
                    // parameter provided will be null-terminated.
					sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, dataTypes[i], dataLen[i], dataDecimalDigits[i],
											  (SQLPOINTER)param_pointer, 0, 0);
				} else
				{
                    // Parameter size is given by data length.
					sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, dataTypes[i], dataLen[i], dataDecimalDigits[i],
											  (SQLPOINTER)param_pointer, 0, reinterpret_cast<SQLLEN*>(& dataLen[i]));
                                                                                      // casting unsigned to signed... why is the type different for sizes?
				}
				
				if(DBFAIL(sqlret))
				{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
				}
		}
		va_end(arg_list);

		if(DBFAIL(sqlret))
		{
				break;
		}

		sqlret = SQLExecute(hstmt);
		switch(sqlret)
		{
		case SQL_SUCCESS_WITH_INFO:
				//handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
				// fall through
		case SQL_SUCCESS:
				break;

		case SQL_ERROR:
		{
				if(handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true))
				{
					goto RECONNECT;
				}
		}
		break;

		case SQL_NO_DATA: // update or delete
				break;

		case SQL_NEED_DATA:
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
				break;
		}
		}
		catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row exec\n");
			break;
		}

        try
		{
			sqlret = SQLNumResultCols(hstmt, &col_num);

			col_num = min(col_num, field_max_cnt);
			col_num = min(col_num, MAX_COL);
			col_num = min(col_num, _max_col);

			if(col_num <= 0)
			{
				if(g_cchLogUtilDb == 1)
					LG2("util_db", "col_num = 0 (<=0)\n", col_num);
				break;
			}

            SQLLEN numRows;
			auto	   retCode = SQLRowCount(hstmt, &numRows);

			for(i = 0; i < col_num; ++i)
			{
				SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
						   MAX_DATALEN, &_buf_len[i]);
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row bind\n");
			break;
		}

		try
		{
			sqlret = SQLFetch(hstmt); // only fetch the next row
			if(DBNODATA(sqlret))
			{
				if(g_cchLogUtilDb == 1)
					LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
				found = false;
			} else if(sqlret != SQL_SUCCESS)
			{
				handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
				if(sqlret != SQL_SUCCESS_WITH_INFO)
				{
					break;
				}
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row fetch\n");
			break;
		}

		try
		{
			// 拷贝数据
			if(found)
			{
				// 取数据
				for(i = 0; i < col_num; ++i)
				{
					if(_buf_len[i] == SQL_NULL_DATA)
					{
					  field_text[i] = NULLDATASTRING;
					} else
					{
					  field_text[i] = (char*)(_buf[i]);
					}
				}

				if(affect_rows != NULL)
					*affect_rows = 1;
			} else
			{
				// 没有取到数据
				if(affect_rows != NULL)
					*affect_rows = 0;
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row copydata\n");
			break;
		}

		ret = true;


	} while(0);

	if(hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeStmt(hstmt, SQL_CLOSE);
		SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
		SQLFreeStmt(hstmt, SQL_UNBIND);
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}
	
	return ret;
;

}



bool cfl_rs::_get_row(string field_text[], int field_max_cnt, char const* param,
                      char const* filter, int* affect_rows /* = NULL */)
{
    bool ret = false;
    char sql[SQL_MAXLEN];
    int i = 0;

    try {
        if (param == NULL) {
            //sprintf(sql, "select * from %s", _tbl_name.c_str());
			_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select * from %s", _tbl_name.c_str());
        } else {
		    if (_tbl_name.length() !=0) {
	            //sprintf(sql, "select %s from %s", param, _tbl_name.c_str());
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s from %s", param, _tbl_name.c_str());
		    } else {
			    //sprintf(sql, "select %s",param);
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s",param);
		    }
        }

        if ((strstr(param, "@@ROWCOUNT") == NULL) &&
            (strstr(param, "@@rowcount") == NULL) &&
            (strstr(_tbl_name.c_str(), "(nolock)") == NULL) &&
            (strstr(_tbl_name.c_str(), "(NOLOCK)") == NULL)) {
            //strcat(sql, " (nolock) ");
				strncat_s(sql, sizeof(sql), " (nolock) ", _TRUNCATE);
        }

        if (filter == NULL) {
        } else {
            //strcat(sql, " where ");
			strncat_s(sql, sizeof(sql), " where ", _TRUNCATE);
            //strcat(sql, filter);
			strncat_s(sql, sizeof(sql), filter, _TRUNCATE);
        }
    } catch (...) {
		if (g_cchLogUtilDb == 1)
	        LG2("util_db", "exception raised from _get_row exec\n");
        return false;
    }

	if (g_cchLogUtilDb == 1)
	    LG2("util_db", "_get_row [SQL]: [%s]\n", sql);

RECONNECT:

  
    // 执行查询操作
    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLSMALLINT col_num = 0;
    bool found = true;

    do
    {
        try {        
            sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }
            } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row alloc\n"); break;}

            try {
			  constexpr uint64_t timeout{50};
			  sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (DBFAIL(sqlret))
            {
                if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
			    return false;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row exec\n"); break;}

        try {
            sqlret = SQLNumResultCols(hstmt, &col_num);

            col_num = min(col_num, field_max_cnt);
            col_num = min(col_num, MAX_COL);
            col_num = min(col_num, _max_col);

            if (col_num <= 0)
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "col_num = 0 (<=0)\n", col_num);
                break;
            }

            for (i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
                        MAX_DATALEN, &_buf_len[i]);
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row bind\n"); break;}

        try {
            sqlret = SQLFetch(hstmt); // only fetch the next row
            if (DBNODATA(sqlret))
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
                found = false;
            }
            else if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
                if (sqlret != SQL_SUCCESS_WITH_INFO)
                {
                    break;
                }
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row fetch\n"); break;}

        try {
            // 拷贝数据
            if (found)
            {
                // 取数据
                for (i = 0; i < col_num; ++ i)
                {
                    if (_buf_len[i] == SQL_NULL_DATA)
                    {
                        field_text[i] = NULLDATASTRING;
                    }
                    else
                    {
                        field_text[i] = (char *)(_buf[i]);
                    }
                }

                if (affect_rows != NULL)
                    *affect_rows = 1;
            }
            else
            {
                // 没有取到数据
                if (affect_rows != NULL)
                    *affect_rows = 0;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row copydata\n"); break;}

        ret = true;

    }
	while (0);

    try {
        if (hstmt != SQL_NULL_HSTMT) {    
            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row freestmt\n"); ret = false;}

    return ret;
}

bool cfl_rs::_get_row3(string field_text[], int field_max_cnt, char* param,
                       char* filter, int* affect_rows /* = NULL */)
{
    bool ret = false;
    char sql[SQL_MAXLEN];
    int i = 0;

    try {
        if (param == NULL)
        {
            //sprintf(sql, "select * from %s", _tbl_name.c_str());
			_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select * from %s", _tbl_name.c_str());
        }
        else
        {
            if(_tbl_name.length() !=0)
            {
                //sprintf(sql, "select %s from %s", param, _tbl_name.c_str());
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s from %s", param, _tbl_name.c_str());
            }else
            {
                //sprintf(sql, "select %s",param);
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s",param);
            }
        }

        if (filter == NULL)
        {
        }
        else
        {
            //strcat(sql, " where ");
			strncat_s(sql, sizeof(sql), " where ", _TRUNCATE);
            //strcat(sql, filter);
			strncat_s(sql, sizeof(sql), filter, _TRUNCATE);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 exec\n"); return false;}

	if (g_cchLogUtilDb == 1)
	    LG2("util_db", "_get_row3 [SQL]: [%s]\n", sql);

RECONNECT:

    // 执行查询操作
    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLSMALLINT col_num = 0;
    bool found = true;

    do
    {
        try {

            sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 alloc\n"); break;}

        try {
			constexpr uint64_t timeout{50};
		  sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (DBFAIL(sqlret))
            {
                if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
                return false;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 exec\n"); break;}

        try {
            sqlret = SQLNumResultCols(hstmt, &col_num);

            col_num = min(col_num, field_max_cnt);
            col_num = min(col_num, MAX_COL);
            col_num = min(col_num, _max_col);

            if (col_num <= 0)
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "col_num = 0 (<=0)\n", col_num);
                break;
            }

            for (i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
                    MAX_DATALEN, &_buf_len[i]);
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 bind\n"); break;}

        try {
            sqlret = SQLFetch(hstmt); // only fetch the next row
            if (DBNODATA(sqlret))
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
                found = false;
            }
            else if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
                if (sqlret != SQL_SUCCESS_WITH_INFO)
                {
                    break;
                }
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 fetch\n"); break;}

        try {
            // 拷贝数据
            if (found)
            {
                // 取数据
                for (i = 0; i < col_num; ++ i)
                {
                    if (_buf_len[i] == SQL_NULL_DATA)
                    {
                        field_text[i] = NULLDATASTRING;
                    }
                    else
                    {
                        char* p = strchr((char *)_buf[i], ' ');
                        if (p != NULL)
                        {
                            *p = '\0';
                        }

                        field_text[i] = (char *)(_buf[i]);
                    }
                }

                if (affect_rows != NULL)
                    *affect_rows = 1;
            }
            else
            {
                // 没有取到数据
                if (affect_rows != NULL)
                    *affect_rows = 0;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 copydata\n"); break;}

        ret = true;

    }
    while (0);

    try {
        if (hstmt != SQL_NULL_HSTMT)
        {    
            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 freestmt\n"); ret = false;}

    return ret;
}

bool cfl_rs::_get_rowOderby(string field_text[], int field_max_cnt, char* param,
					char* filter, int* affect_rows/* = NULL*/)
{
    bool ret = false;
    char sql[SQL_MAXLEN];
    int i = 0;

    try {
        if (param == NULL)
        {
            //sprintf(sql, "select * from %s", _tbl_name.c_str());
			_snprintf_s(sql, sizeof(sql), _TRUNCATE,  "select * from %s  with(nolock)", _tbl_name.c_str());
        }
        else
        {
            if(_tbl_name.length() !=0)
            {
                //sprintf(sql, "select %s from %s", param, _tbl_name.c_str());
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s from %s  with(nolock)", param, _tbl_name.c_str());
            }else
            {
                //sprintf(sql, "select %s",param);
				_snprintf_s(sql, sizeof(sql), _TRUNCATE, "select %s  with(nolock)",param);
            }
        }

        if (filter == NULL)
        {
        }
        else
        {
            //strcat(sql, " ");
			strncat_s(sql, sizeof(sql), " ", _TRUNCATE);
            //strcat(sql, filter);
			strncat_s(sql, sizeof(sql), filter, _TRUNCATE);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 exec\n"); return false;}

	if (g_cchLogUtilDb == 1)
	    LG2("util_db", "_get_row3 [SQL]: [%s]\n", sql);

RECONNECT:

    // 执行查询操作
    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLSMALLINT col_num = 0;
    bool found = true;

    do
    {
        try {

            sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 alloc\n"); break;}

        try {
			constexpr uint64_t timeout{50};
		  sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (DBFAIL(sqlret))
            {
                if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
                return false;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 exec\n"); break;}

        try {
            sqlret = SQLNumResultCols(hstmt, &col_num);

            col_num = min(col_num, field_max_cnt);
            col_num = min(col_num, MAX_COL);
            col_num = min(col_num, _max_col);

            if (col_num <= 0)
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "col_num = 0 (<=0)\n", col_num);
                break;
            }

            for (i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
                    MAX_DATALEN, &_buf_len[i]);
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 bind\n"); break;}

        try {
            sqlret = SQLFetch(hstmt); // only fetch the next row
            if (DBNODATA(sqlret))
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
                found = false;
            }
            else if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
                if (sqlret != SQL_SUCCESS_WITH_INFO)
                {
                    break;
                }
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 fetch\n"); break;}

        try {
            // 拷贝数据
            if (found)
            {
                // 取数据
                for (i = 0; i < col_num; ++ i)
                {
                    if (_buf_len[i] == SQL_NULL_DATA)
                    {
                        field_text[i] = NULLDATASTRING;
                    }
                    else
                    {
                        char* p = strchr((char *)_buf[i], ' ');
                        if (p != NULL)
                        {
                            *p = '\0';
                        }

                        field_text[i] = (char *)(_buf[i]);
                    }
                }

                if (affect_rows != NULL)
                    *affect_rows = 1;
            }
            else
            {
                // 没有取到数据
                if (affect_rows != NULL)
                    *affect_rows = 0;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 copydata\n"); break;}

        ret = true;

    }
    while (0);

    try {
        if (hstmt != SQL_NULL_HSTMT)
        {    
            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row3 freestmt\n"); ret = false;}

	return ret;
}

SQLRETURN cfl_rs::exec_sql_direct(char const* sql, unsigned short timeout /* = 5 */)
{
RECONNECT:

	SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
	//LG2("util_db", "SQL Statement Length: %d\n", strlen(sql));

	do
	{
        sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
        if (DBFAIL(sqlret))
        {
            handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
            break;
        }

		constexpr uint64_t timeout{50};
		sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
		if (DBFAIL(sqlret))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			break;
		}

		sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
		switch (sqlret)
		{
		case SQL_SUCCESS_WITH_INFO:
			//handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
			// fall through
		case SQL_SUCCESS:
			break;

		case SQL_ERROR:
			{
				if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
			}
			break;

		case SQL_NO_DATA: // update or delete
			break;
		}
	}
	while (0);

    if (hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        hstmt = SQL_NULL_HSTMT;
    }
    
	return sqlret;
}

SQLRETURN cfl_rs::stored_procedure(char const* sql,char const* schema, char const* procedure, ...)
{
	bool ret = false;
	//char sql[SQL_MAXLEN];
	int	 i = 0;
	va_list arg_list;
	va_start(arg_list, procedure);
	int numberOfParameters = va_arg(arg_list, int);
	double	time_1, time_2;
	LETimer t1;

	std::vector<SQLParamData>* cached_params = nullptr;
	auto					   cache		 = _cached_map.find(std::string(procedure));
	if(cache == _cached_map.end())
	{
		// Procedure wasn't cached yet.
		cache_stored_procedure(numberOfParameters, schema, procedure);
		cache = _cached_map.find(std::string(procedure));

		if(cache != _cached_map.end())
		{
			cached_params = &(*cache).second;

		} else
		{
			LG2("util_db", "Could not find cached map for procedure: [%s]\n", procedure);
			return SQL_ERROR;
		}

	} else
	{
		cached_params = &(*cache).second;
	}
	try
	{
	} catch(...)
	{
		if(g_cchLogUtilDb == 1)
			LG2("util_db", "exception raised from stored_procedure exec\n");
		return SQL_ERROR;
	}

	if(g_cchLogUtilDb == 1)
		LG2("util_db", "stored_procedure[SQL]: [%s]\n", procedure);

	// the bit bellow is simply safe_sql, but because of variadic arguments we cant call it here.
RECONNECT:

	SQLRETURN	   sqlret;
	SQLHSTMT	   hstmt	= SQL_NULL_HSTMT;
	SQLSMALLINT	   col_num	= 0;
	unsigned short timeout	= 50;
	bool		   found	= true;
	SQLINTEGER	   data_len = SQL_NTS;
	do
	{
		try
		{
			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
			if(DBFAIL(sqlret))
			{
					handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
					break;
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from stored_procedure alloc\n");
			break;
		}
		try
		{
			constexpr auto timeout{50};
			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
			if(DBFAIL(sqlret))
			{
					handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
					break;
			}
			if(DBFAIL(sqlret))
			{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
			}

			if(DBFAIL(sqlret))
			{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
			}


			// Time to bind parameters.
			for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
			{
					if(!cached_params)
					{
					break;
					}
					SQLSMALLINT sql_data_type = cached_params->at(i).sql_data_type;
					SQLULEN column_length = cached_params->at(i).column_length;
					const char* param_pointer = va_arg(arg_list, const char*);

					sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, sql_data_type, column_length, 0,
											  (SQLPOINTER)param_pointer, 0, 0);

					if(DBFAIL(sqlret))
					{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
					}
			};
			va_end(arg_list);

			if(DBFAIL(sqlret))
			{
					break;
			}

			sqlret = SQLExecDirect(hstmt, (SQLCHAR*)sql, SQL_NTS);
			switch(sqlret)
			{
			case SQL_SUCCESS_WITH_INFO:
					//handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
					// fall through
			case SQL_SUCCESS:
					break;

			case SQL_ERROR:
			{
					if(handle_err(hstmt, SQL_HANDLE_STMT, sqlret, procedure, true))
					{
					goto RECONNECT;
					}
			}
			break;

			case SQL_NO_DATA: // update or delete
					break;

			case SQL_NEED_DATA:
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret, procedure);
					break;
			}
		} catch(...)
		{
			if(g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row exec\n");
			break;
		}
	} while(0);

	if(hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeStmt(hstmt, SQL_CLOSE);
		SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
		SQLFreeStmt(hstmt, SQL_UNBIND);
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return sqlret;
}


SQLRETURN cfl_rs::safe_sql(char const* sql, ...)
{
RECONNECT:

	SQLRETURN  sqlret;
	SQLHSTMT   hstmt	= SQL_NULL_HSTMT;
	unsigned short timeout	= 50;
    va_list arg_list;
	va_start(arg_list, sql);

	int numberOfParameters = va_arg(arg_list,int);
	SQLULEN	       dataLen[MAX_PARAM_NUM]; 
    SQLSMALLINT	   dataTypes[MAX_PARAM_NUM];
	SQLSMALLINT	   dataDecimalDigits[MAX_PARAM_NUM];
	SQLSMALLINT	   dataNullable[MAX_PARAM_NUM];

	do
	{
		sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
		if(DBFAIL(sqlret))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			break;
		}

		sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
		if(DBFAIL(sqlret))
		{
			handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
			break;
		}

		sqlret = SQLPrepare(hstmt, (SQLCHAR*)sql, SQL_NTS);
		if(DBFAIL(sqlret))
		{
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			break;
		}

        for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
		{
			// Get info for each parameter from the prepared statement.
			sqlret = SQLDescribeParam(hstmt, i + 1, &dataTypes[i], &dataLen[i], &dataDecimalDigits[i], &dataNullable[i]);
		}

		if(DBFAIL(sqlret))
		{
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
			break;
		}

		// Time to bind parameters.
		for(SQLUSMALLINT i = 0; i < numberOfParameters; i++)
		{
			const char* param_pointer = va_arg(arg_list, const char*);

			if(dataTypes[i] == SQL_VARBINARY || dataTypes[i] == SQL_VARCHAR)
			{
					// parameter provided will be null-terminated.
					sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, dataTypes[i], dataLen[i], dataDecimalDigits[i],
											  (SQLPOINTER)param_pointer, 0, 0);
			} else
			{
					// Parameter size is given by data length.
					sqlret = SQLBindParameter(hstmt, i + 1, SQL_PARAM_INPUT, SQL_C_DEFAULT, dataTypes[i], dataLen[i], dataDecimalDigits[i],
											  (SQLPOINTER)param_pointer, 0, reinterpret_cast<SQLLEN*>(&dataLen[i]));
					// casting unsigned to signed... why is the type different for sizes?
			}

			if(DBFAIL(sqlret))
			{
					handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
					break;
			}
		}
		va_end(arg_list);


		if(DBFAIL(sqlret))
		{
			break;
		}

		sqlret = SQLExecute(hstmt);
		switch(sqlret)
		{
		case SQL_SUCCESS_WITH_INFO:
			//handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
			// fall through
		case SQL_SUCCESS:
			break;

		case SQL_ERROR:
		{
			if(handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true))
			{
					goto RECONNECT;
			}
		}
		break;

		case SQL_NO_DATA: // update or delete
			break;

		case SQL_NEED_DATA:
			handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
			break;
		}
	} while(0);

	if(hstmt != SQL_NULL_HSTMT)
	{
		SQLFreeStmt(hstmt, SQL_CLOSE);
		SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
		SQLFreeStmt(hstmt, SQL_UNBIND);
		SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
		hstmt = SQL_NULL_HSTMT;
	}

	return sqlret;
}




SQLRETURN cfl_rs::exec_sql(char const* sql, char const* pdata, int len, unsigned short timeout /* = 30 */)
{
RECONNECT:

    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLLEN data_len = SQL_NTS;

    do
    {
        sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
        if (DBFAIL(sqlret))
        {
            handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
            break;
        }

		sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
        if (DBFAIL(sqlret))
        {
            handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
            break;
        }

        sqlret = SQLPrepare(hstmt, (SQLCHAR *)sql, SQL_NTS);
        if (DBFAIL(sqlret))
        {
            handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
            break;
        }

        sqlret = SQLBindParameter(hstmt, 1, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_CHAR, len - 1, 0,
            (SQLPOINTER)pdata, len, &data_len);
        if (DBFAIL(sqlret))
        {
            handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
            break;
        }

        sqlret = SQLExecute(hstmt);
        switch (sqlret)
        {
        case SQL_SUCCESS_WITH_INFO:
            //handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
            // fall through
        case SQL_SUCCESS:
            break;

        case SQL_ERROR:
			{
				if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
			}
            break;

        case SQL_NO_DATA: // update or delete
            break;

        case SQL_NEED_DATA:
            handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
            break;
        }
    }
    while (0);

    if (hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeStmt(hstmt, SQL_CLOSE);
        SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
        SQLFreeStmt(hstmt, SQL_UNBIND);
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        hstmt = SQL_NULL_HSTMT;
    }

    return sqlret;
}

// Add by lark.li 20080808 begin
SQLRETURN cfl_rs::exec_param_sql(char const* sql, char const* pdata, int len, unsigned short timeout /* = 30 */)
{
RECONNECT:

    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLLEN data_len = len;

    do
    {
        sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
        if (DBFAIL(sqlret))
        {
            handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
            break;
        }

		sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
        if (DBFAIL(sqlret))
        {
            handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
            break;
        }

        sqlret = SQLPrepare(hstmt, (SQLCHAR *)sql, SQL_NTS);
        if (DBFAIL(sqlret))
        {
            handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
            break;
        }

        sqlret = SQLBindParameter(hstmt, 1, SQL_PARAM_INPUT, SQL_C_BINARY, SQL_BINARY, len, 0,
            (SQLPOINTER)pdata, 0, &data_len);
        if (DBFAIL(sqlret))
        {
            handle_err(hstmt, SQL_HANDLE_STMT, sqlret);
            break;
        }

        sqlret = SQLExecute(hstmt);
        switch (sqlret)
        {
        case SQL_SUCCESS_WITH_INFO:
            //handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
            // fall through
        case SQL_SUCCESS:
            break;

        case SQL_ERROR:
			{
				if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
			}
            break;

        case SQL_NO_DATA: // update or delete
            break;

        case SQL_NEED_DATA:
            handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
            break;
        }
    }
    while (0);

    if (hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeStmt(hstmt, SQL_CLOSE);
        SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
        SQLFreeStmt(hstmt, SQL_UNBIND);
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        hstmt = SQL_NULL_HSTMT;
    }

    return sqlret;
}

// End

bool cfl_rs::getalldata(const char* sql, vector< vector< string > >& data, unsigned short timeout)
{
	bool ret;

    // 执行查询操作
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
                break;
            }

			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

                if (sqlret != SQL_SUCCESS_WITH_INFO) break;
            }

            sqlret = SQLNumResultCols(hstmt, &col_num);
            col_num = min(col_num, MAX_COL);
            col_num = min(col_num, _max_col);

            // Bind Column
            for (int i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
            }

            // Fetch each Row
            for (int i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
            {
				vector< string > rowV;

                if (sqlret != SQL_SUCCESS) handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

				for(int j=0; j< col_num; j++)
				{
					rowV.push_back((char const *)_buf[j]);
				}

				data.push_back(rowV);
            }

            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            ret = true;

        } while (0);
    }
    catch (...)
    {
		if (g_cchLogUtilDb == 1)
	        LG2("util_db", "Exception raised when get friend data:\n%s\n", sql);
    }

    if (hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        hstmt = SQL_NULL_HSTMT;
    }

    return ret;
}

// Add by lark.li 20080809 begin
bool cfl_rs::get_page_data(char* tablename, char* param, int pagesize, int pageindex, char* filter, char* sort, int sorttype, int& totalpage, int& totalrecord,
					  vector< vector< string > > &data, unsigned short timeout)
{
	bool ret;

    // 执行查询操作
    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLSMALLINT col_num = 0;
    bool found = true;

    try
    {
        do
        {
			SQLLEN sql_nts = SQL_NTS;
			//SQLINTEGER num[2];

			//char tablename[32];
			//strncpy(tablename, _tbl_name.c_str(), sizeof(tablename));

			sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
            if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

			SQLFreeStmt(hstmt, SQL_UNBIND);
			SQLFreeStmt(hstmt, SQL_RESET_PARAMS);

			if((SQLBindParameter(hstmt, 1, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR, (SQLUINTEGER)strlen(tablename), 0, tablename, 0, &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 2, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR, (SQLUINTEGER)strlen(param), 0, param, 0, &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 3, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER, (SQLUINTEGER)sizeof(pagesize), 0, &pagesize, 0, &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 4, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER, (SQLUINTEGER)sizeof(pageindex), 0, &pageindex, 0, &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 5, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR, (SQLUINTEGER)strlen(filter), 0, filter, 0, &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 6, SQL_PARAM_INPUT, SQL_C_CHAR, SQL_VARCHAR, (SQLUINTEGER)strlen(sort), 0, sort, 0, &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 7, SQL_PARAM_INPUT, SQL_C_SLONG, SQL_INTEGER, (SQLUINTEGER)sizeof(sorttype), 0, &sorttype, 0, &sql_nts) != SQL_SUCCESS)
				/*||	(SQLBindParameter(hstmt, 8, SQL_PARAM_OUTPUT, SQL_C_SLONG, SQL_INTEGER, 10, 0, &num[0], sizeof(num[0]), &sql_nts) != SQL_SUCCESS)
				||	(SQLBindParameter(hstmt, 9, SQL_PARAM_OUTPUT, SQL_C_SLONG, SQL_INTEGER, 10, 0, &num[1], sizeof(num[1]),  &sql_nts) != SQL_SUCCESS)*/)
			{
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
			}

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *) "{call sys_Paging(?,?,?,?,?,?,?)}", SQL_NTS);
            if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, "{call sys_Paging(?,?,?,?,?,?,?)}");

                if (sqlret != SQL_SUCCESS_WITH_INFO) break;
            }

            sqlret = SQLNumResultCols(hstmt, &col_num);
            col_num = min(col_num, MAX_COL);
            col_num = min(col_num, _max_col);

			// Clear
			memset(_buf, 0, MAX_COL * MAX_DATALEN * sizeof(UCHAR));

            // Bind Column
            for (int i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
            }

            // Fetch each Row
            for (int i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
            {
				vector< string > rowV;

                if (sqlret != SQL_SUCCESS) handle_err(hstmt, SQL_HANDLE_STMT, sqlret, "{call sys_Paging(?,?,?,?,?,?,?,?,?)}");

				for(int j=0; j< col_num; j++)
				{
					rowV.push_back((char const *)_buf[j]);
				}

				data.push_back(rowV);
            }

			if(SQLMoreResults(hstmt) == SQL_SUCCESS)
			{
				sqlret = SQLNumResultCols(hstmt, &col_num);
				col_num = min(col_num, MAX_COL);
				col_num = min(col_num, _max_col);

				// Bind Column
				for (int i = 0; i < col_num; ++ i)
				{
					SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
				}

				// Fetch each Row
				for (int i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
				{
					totalpage = atoi((const char*)_buf[0]);
					totalrecord = atoi((const char*)_buf[1]);
				}
			}
            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            ret = true;

        } while (0);
    }
    catch (...)
    {
		if (g_cchLogUtilDb == 1)
	        LG2("util_db", "Exception raised when get friend data:\n%s\n", "{call sys_Paging2(?,?,?,?,?,?,?,?,?)}");
    }

    if (hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        hstmt = SQL_NULL_HSTMT;
    }

    return ret;
}
// End

bool cfl_rs::get(char const* sql, char const* pdata, int len, unsigned short timeout /* = 30 */)
{
RECONNECT:

    bool ret = false;
    //char sql[SQL_MAXLEN];
    int i = 0;

	if (g_cchLogUtilDb == 1)
	    LG2("util_db", "get() [SQL]: [%s]\n", sql);

    // 执行查询操作
    SQLRETURN sqlret;
    SQLHSTMT hstmt = SQL_NULL_HSTMT;
    SQLSMALLINT col_num = 0;
    bool found = true;

    do
    {
        try {

            sqlret = SQLAllocHandle(SQL_HANDLE_STMT, _hdbc, &hstmt);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from get() alloc\n"); break;}

        try {
			constexpr uint64_t timeout{50};
		    sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if (DBFAIL(sqlret))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (DBFAIL(sqlret))
            {
                if( handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql, true) )
				{
					goto RECONNECT;
				}
                return false;
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from get() exec\n"); break;}

        try {
            sqlret = SQLNumResultCols(hstmt, &col_num);
            if (col_num <= 0)
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "col_num = 0 (<=0)\n", col_num);
                break;
            }

            for (i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i],
                    MAX_DATALEN, &_buf_len[i]);
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row bind\n"); break;}

        try {
            sqlret = SQLFetch(hstmt); // only fetch the next row
            if (DBNODATA(sqlret))
            {
				if (g_cchLogUtilDb == 1)
	                LG2("util_db", "SQL didn't fetch any data [%s]\n", sql);
                found = false;
            }
            else if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);
                if (sqlret != SQL_SUCCESS_WITH_INFO)
                {
                    break;
                }
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row fetch\n"); break;}

        try {
            // 拷贝数据
            if (found)
            {
                // 取数据
                memcpy((void *)pdata, _buf[0], len);
            }
            else
            {
            }
        } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row copydata\n"); break;}

        ret = true;
    }
    while (0);

    try {
        if (hstmt != SQL_NULL_HSTMT)
        {    
            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        }
    } catch (...) {if (g_cchLogUtilDb == 1) LG2("util_db", "exception raised from _get_row freestmt\n"); ret = false;}

    return ret;
}


// friend table
static char const query_friend_format[SQL_MAXLEN] =
"select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( \
select distinct friends.relation relation from character with(nolock) INNER JOIN \
friends with(nolock) ON character.cha_id = friends.cha_id2 where friends.cha_id1 = %d) cc	\
union select '' cha_name,0 addr, -1 cha_id,friends.relation relation,0 icon,'' motto from friends	\
where friends.cha_id1 = %d and friends.cha_id2 = -1	\
union select friends.relation relation,count(character.mem_addr) addr,0 \
cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN friends ON \
character.cha_id = friends.cha_id2 where friends.cha_id1 = %d group by relation \
union select friends.relation relation,character.mem_addr addr,character.cha_id \
cha_id,character.cha_name cha_name,character.icon icon,character.motto motto \
from character INNER JOIN friends ON character.cha_id = friends.cha_id2 \
where friends.cha_id1 = %d order by relation,cha_id,icon";

bool friend_tbl::get_friend_dat(friend_dat* farray, int& array_num, unsigned int cha_id, bool* drop /* = NULL */)
{
    if (farray == NULL || array_num <= 0 || cha_id == 0) return false;

    bool ret = false;
    char sql[SQL_MAXLEN];
	// Modify by lark.li 20080804 begin
    //sprintf(sql, query_friend_format, cha_id, cha_id, cha_id);
	//sprintf(sql, query_friend_format, cha_id, cha_id, cha_id, cha_id);
	_snprintf_s(sql, sizeof(sql), _TRUNCATE, query_friend_format, cha_id, cha_id, cha_id, cha_id);
	// End

    // 执行查询操作
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
                break;
            }

            constexpr uint64_t timeout{50};
			sqlret = SQLSetStmtAttr(hstmt, SQL_ATTR_QUERY_TIMEOUT, SQLPOINTER(timeout), SQL_IS_UINTEGER);
            if ((sqlret != SQL_SUCCESS) && (sqlret != SQL_SUCCESS_WITH_INFO))
            {
                handle_err(_hdbc, SQL_HANDLE_DBC, sqlret);
                break;
            }

            sqlret = SQLExecDirect(hstmt, (SQLCHAR *)sql, SQL_NTS);
            if (sqlret != SQL_SUCCESS)
            {
                handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

                if (sqlret != SQL_SUCCESS_WITH_INFO) break;
            }

            sqlret = SQLNumResultCols(hstmt, &col_num);
            col_num = min(col_num, MAX_COL);
            col_num = min(col_num, _max_col);

            // Bind Column
			int i = 0;

            for (i = 0; i < col_num; ++ i)
            {
                SQLBindCol(hstmt, UWORD(i + 1), SQL_C_CHAR, _buf[i], MAX_DATALEN, &_buf_len[i]);
            }

            // Fetch each Row
            for (i = 0; ((sqlret = SQLFetch(hstmt)) == SQL_SUCCESS) || (sqlret == SQL_SUCCESS_WITH_INFO); ++ i)
            {
                if (i >= array_num)
                {
                    if (drop != NULL)
                        *drop = true;

                    break;
                }

                if (sqlret != SQL_SUCCESS) handle_err(hstmt, SQL_HANDLE_STMT, sqlret, sql);

                farray[i].relation = (char const *)_buf[0];
                farray[i].memaddr = atoi((char const *)_buf[1]);
                farray[i].cha_id = atoi((char const *)_buf[2]);
                farray[i].cha_name = (char const *)_buf[3];
                farray[i].icon_id = atoi((char const *)_buf[4]);
                farray[i].motto = (char const *)_buf[5];
            }

            array_num = i; // 取出的行数

            SQLFreeStmt(hstmt, SQL_CLOSE);
            SQLFreeStmt(hstmt, SQL_RESET_PARAMS);
            SQLFreeStmt(hstmt, SQL_UNBIND);
            ret = true;

        } while (0);
    }
    catch (...)
    {
		if (g_cchLogUtilDb == 1)
	        LG2("util_db", "Exception raised when get friend data:\n%s\n", sql);
    }

    if (hstmt != SQL_NULL_HSTMT)
    {
        SQLFreeHandle(SQL_HANDLE_STMT, hstmt);
        hstmt = SQL_NULL_HSTMT;
    }

    return ret;
}

// 如果成功转换则返回0
int Util::ConvertDBParam(const char* param, char* buf, size_t size, size_t& count)
{
	count = 0;

	if(param == NULL)
		return -1;

	size_t len = strlen(param);

	// 留下最后一个字符保存\0
	if(len >= size)
		return -1;

	const char* p1 = param;
	const char* p2 = NULL;

	while((p2 = strchr(p1, '\'')) != NULL)
	{

#if (_MSC_VER >= 1400 )
		strncpy_s(buf + count, (size - count), p1, (p2 - p1));
#else
		strncpy(buf + count, p1, (size - count));
#endif
		count += (p2 - p1);

#if (_MSC_VER >= 1400 )
		strncpy_s(buf + count, (size - count), "''", 2);
#else
		strncpy(buf + count, "''", (size - count));
#endif
		count += 2;

		p1 = p2 + 1;
	}

	if((p1 - param) < (int)len)
	{
#if (_MSC_VER >= 1400 )
		strncpy_s(buf + count, (size - count), p1, _TRUNCATE);
#else
		strncpy(buf + count, p1, (size - count));
#endif
		count += (p1 - param);
	}

	return 0;
}
