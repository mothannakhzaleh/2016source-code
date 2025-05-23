/**
*  @file db.h
*
*  db.h, v 2.0 2004/11/24 13:14:05 shanghai China
*
*  @author claude Fan <fanyf2002@hotmail.com>
*
*/

#ifndef _DB_H_
#define _DB_H_

#include "sql.h"
#include "sqltypes.h"
#include "sqlext.h"
#include "vector"
#include <unordered_map>
#include <string>

// SQL2005
//#include <sqlncli.h>

#define DBOK(sr) ((sr == SQL_SUCCESS) || (sr == SQL_SUCCESS_WITH_INFO))
#define DBNODATA(sr) (sr == SQL_NO_DATA)
#define SQL_MAXLEN 8192                
#define MAX_PARAM_NUM 70

class cfl_rs;
class cfl_db
{
public:
    cfl_db();
    ~cfl_db();

public:
    void enable_errinfo(bool enable = true);
    bool is_errinfo_enable() const;
    bool handle_err(SQLHANDLE h, SQLSMALLINT t, RETCODE r, char const* sql = NULL, bool reconn = false);

	bool	connect(const char* servername, const char* database, const char* userid, const char* passwd,
                 string& err_info);
    SQLHDBC get_dbc() const;
	void add(cfl_rs* rs);
	void disconn();

    SQLRETURN exec_sql_direct(char const* sql, unsigned short timeout = 50);

	bool begin_tran();
	bool commit_tran();
	bool rollback();

protected:
	bool _connect(string& errinfo);

	bool _needreconn(char const* state);
	bool _reconnt();

private:
    bool connect(char* source, char* userid, char* passwd, string& err_info);

	bool _dump_errinfo;
    bool _connected;
	string _connstr;

    SQLHENV _henv;
    SQLHDBC _hdbc;

	vector<cfl_rs *> _rslist;

	string _openDatabase;
};

inline void cfl_db::enable_errinfo(bool enable /* = true */)
{
	_dump_errinfo = enable;
}
inline bool cfl_db::is_errinfo_enable() const
{
	return _dump_errinfo;
}
inline SQLHDBC cfl_db::get_dbc() const
{
	return _hdbc;
}


class cfl_rs
{
protected:

	void attach_db(cfl_db* db);
	bool handle_err(SQLHANDLE h, SQLSMALLINT t, RETCODE r, char const* sql = NULL, bool reconn = false);
	//void stmt_err(SQLRETURN r, char const* sql = NULL, bool reconn = false);
    char const* const _get_table() const;

public:
	cfl_rs(cfl_db* db);
	cfl_rs(cfl_db* db, char const* tbl_name, int max_col);
	virtual ~cfl_rs();


	struct SQLParamData
	{
	  SQLSMALLINT sql_data_type;
	  SQLULEN column_length;
	};

	SQLRETURN cache_stored_procedure(int numberOfParams, char const* schema, char const* procedure);
	// 简单接口
    SQLRETURN exec_sql_direct(char const* sql, unsigned short timeout = 50);

    SQLRETURN exec_sql(char const* sql, char const* pdata, int len, unsigned short timeout = 50);

	// Add by lark.li 20080808 begin
	SQLRETURN exec_param_sql(char const* sql, char const* pdata, int len, unsigned short timeout = 50);
	// End
	// Add by Mdr
	
	SQLRETURN safe_sql(char const* sql, ...);
	SQLRETURN stored_procedure(char const* sql,char const* schema, char const* procedure, ...);
	// Add by lark.li 20080808 negin
	bool _get_bin_field(char* field_text, SQLLEN& len, char* param, char* filter, int* affect_rows = NULL);
	// End

	//@TableName	nvarchar(50),		-- 表名
	//@ReturnFields	nvarchar(200) = '*',	-- 需要返回的列 
	//@PageSize	int = 10,		-- 每页记录数
	//@PageIndex	int = 1,		-- 当前页码
	//@Where		nvarchar(200) = '',	-- 查询条件
	//@Orderfld	nvarchar(200),		-- 排序字段名 最好为唯一主键
	//@OrderType	int = 1,		-- 排序类型 1:降序 其它为升序
	//@TotalPage  int out,--总页数
	//@TotalRecord int out --总记录数
	// Add by lark.li 20080809 begin
	bool	get_page_data(char* tablename, char* param, int pagesize, int pageindex, char* filter, char* sort, int sorttype, int& totalpage, int& totalrecord, vector< vector< string > > &data, unsigned short timeout = 50);
	// End

	// 非阻塞(nolock)

	bool _get_row(string field_text[], int field_max_cnt, char const* param,
				  char const* filter, int* affect_rows = NULL);
	bool _get_rowSafely(string field_text[], int field_max_cnt, char const* param,
						char const* filter, int* affect_rows, ...);
	bool _get_row_stored_procedure(string field_text[], int field_max_cnt, char const* sql, char const* schema, char const* procedure,
						int* affect_rows, ...);

	// Similar as _get_row3
	bool _get_row_stored_procedure_whitespace(string field_text[], int field_max_cnt, char const* sql, char const* schema, char const* procedure,
								   int* affect_rows, ...);


	// 缺省锁，空格后数据截取掉
    bool _get_row3(string field_text[], int field_max_cnt, char* param,
                   char* filter, int* affect_rows = NULL);
    bool _get_rowOderby(string field_text[], int field_max_cnt, char* param,
                   char* filter, int* affect_rows = NULL);

	// Add by lark.li 20080528 begin
	bool	getalldata(const char* sql, vector< vector< string > > &data, unsigned short timeout = 50);
	// End

	// 高级接口
	bool begin_tran();
	bool commit_tran();
	bool rollback();

	// 其他接口
	int get_affected_rows();
	int get_identity();
    char const* const get_table() const;
    void notify_discon(cfl_db* db);
	void notify_reconn(cfl_db* db);
private:

	bool get(char const* sql, char const* pdata, int len, unsigned short timeout = 50);

protected:
    cfl_db* _db;
    string _tbl_name;
    int _max_col;

    SQLHDBC _hdbc;
    SQLHSTMT _hstmt;

    // temp buffer
    enum {MAX_COL = 64, MAX_DATALEN = 8192};
    UCHAR _buf[MAX_COL][MAX_DATALEN];
    SQLLEN _buf_len[MAX_COL];

    SWORD _col_num;
    SWORD _row_num;
    UINT _param_num;
	std::unordered_map<std::string, std::vector<SQLParamData>>  _cached_map;

	enum {OUTDAT_MAXLEN = 8192};
	char _dat[OUTDAT_MAXLEN];
};

inline char const* const cfl_rs::get_table() const
{
    return _get_table();
}


inline bool cfl_rs::handle_err(SQLHANDLE h, SQLSMALLINT t, RETCODE r,
							   char const* sql /* = NULL */,
							   bool reconn /* = false */)
{
	return _db->handle_err(h, t, r ,sql, reconn);
}

inline char const* const cfl_rs::_get_table() const
{
	return _tbl_name.c_str();
}
inline bool cfl_rs::begin_tran()
{
	return _db->begin_tran();
}
inline bool cfl_rs::commit_tran()
{
	return _db->commit_tran();
}
inline bool cfl_rs::rollback()
{
	return _db->rollback();
}

struct friend_dat
{
    unsigned long long memaddr; // VA in GameServer
    unsigned int cha_id; // id of character
    string relation; // relationship
    string cha_name; // name of character
    unsigned int icon_id;
    string motto;
};

class friend_tbl : public cfl_rs
{
public:
	//friend_tbl(cfl_db* db) : cfl_rs(db) {}
    friend_tbl(cfl_db* db) : cfl_rs(db, "friends", 10) {}
    virtual ~friend_tbl() {}

    bool get_friend_dat(friend_dat* farray, int& array_num, unsigned int cha_id, bool* drop = NULL);

};

class Util
{
public:
	static int ConvertDBParam(const char* param, char* buf, size_t size, size_t& count);
};

#endif //_DB_H_

