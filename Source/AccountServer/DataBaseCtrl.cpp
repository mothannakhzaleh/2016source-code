#define _CRTDBG_MAP_ALLOC
#include <stdlib.h>
#include <crtdbg.h>
#include "commrpc.h"
#include "util.h"

#include "databasectrl.h"
#include "inifile.h"
#include "GlobalVariable.h"
#include "AccountServer2.h"
#include "NetCommand.h"
#include "NetRetCode.h"


CDataBaseCtrl::CDataBaseCtrl(void)
{
  m_strServerIP = "";
  m_strServerDB = "";
  m_strUserID	= "";
  m_strUserPwd	= "";
  m_pDataBase	= NULL;
  db_mutator	= nullptr;
}

CDataBaseCtrl::~CDataBaseCtrl(void)
{
  if(IsConnect())
  {
	ReleaseObject();
  }
}

bool CDataBaseCtrl::CreateObject()
{
  //读取配置
  char			   buf[512];
  dbc::IniFile	   inf(g_strCfgFile.c_str());
  dbc::IniSection& is	  = inf["db"];
  std::string	   strTmp = "";
  try
  {
	//sprintf(buf, "dbserver");
	_snprintf_s(buf, sizeof(buf), "dbserver", _TRUNCATE);
	m_strServerIP = is[buf].c_str();
	//sprintf(buf, "db");
	_snprintf_s(buf, sizeof(buf), "db", _TRUNCATE);
	m_strServerDB = is[buf].c_str();
	//sprintf(buf, "userid");
	_snprintf_s(buf, sizeof(buf), "userid", _TRUNCATE);
	m_strUserID = is[buf].c_str();
	//sprintf(buf, "passwd");
	_snprintf_s(buf, sizeof(buf), "passwd", _TRUNCATE);
	strTmp = is[buf].c_str();
  } catch(std::exception const& e)
  {
	cout << e.what() << endl;
	return false;
  }
  dbpswd_out(strTmp.c_str(), (int)strTmp.length(), m_strUserPwd);

  if(!Connect()) return false;

  //初始化并测试数据库字段
  try
  {
	//m_pDataBase->ExecuteSQL("select ban from account_login");
	//m_pDataBase->ExecuteSQL("select ban from account_login where 1 = 2");
	db_mutator->exec_sql_direct("select ban from account_login where 1 = 2");
	//m_pDataBase->ExecuteSQL("select log_id, user_id, user_name, login_time, logout_time, login_ip from user_log");
	//m_pDataBase->ExecuteSQL("select log_id, user_id, user_name, login_time, logout_time, login_ip from user_log where 1= 2");
	
	db_mutator->exec_sql_direct("select log_id, user_id, user_name, login_time, logout_time, login_ip from user_log where 1= 2");
	//Add by sunny.sun 20090205
	//m_pDataBase->ExecuteSQL("select act_name, SessionKey, act_id, create_time, update_time from act_album where 1 = 2");
	db_mutator->exec_sql_direct("select act_name, SessionKey, act_id, create_time, update_time from act_album where 1 = 2");

  } catch(CSQLException* se)
  {
	LG("DBExcp", "Check data field failure! SQL Exception in CDataBaseCtrl::CreateObject(): %s\n", se->m_strError.c_str());
	printf("Check data field failure! SQL Exception in CDataBaseCtrl::CreateObject(): %s\r\n", se->m_strError.c_str());
	return false;
  } catch(...)
  {
	LG("DBExcp", "Check data field failure! unknown exception raised from CDataBaseCtrl::CreateObject()\n");
	printf("Check data field failure! unknown exception raised from CDataBaseCtrl::CreateObject()\n");
	return false;
  }

  return true;
}

void CDataBaseCtrl::ReleaseObject()
{
  Disconnect();
}

bool CDataBaseCtrl::Connect()
{
  if(IsConnect()) return true;

  //建立数据库对象
  try
  {
	//m_pDataBase = new CSQLDatabase();
	string	   err_info;
	const bool r = db_connection.connect(m_strServerIP.c_str(),m_strServerDB.c_str(), m_strUserID.c_str(), m_strUserPwd.c_str(), err_info);
	if(r)
	{
	  db_mutator = std::make_unique<cfl_rs>(&db_connection);
	}
	return r;
  } catch(std::bad_alloc& e)
  {
	LG("DBExcp", "CDataBaseCtrl::CreateObject() new failed: %s\n", e.what());
	m_pDataBase = NULL;
	return false;
  } catch(...)
  {
	LG("DBExcp", "CDataBaseCtrl::CreateObject() unknown exception\n");
	m_pDataBase = NULL;
	return false;
  }

  //连接数据库
  char buf[512] = {0};
  //sprintf(buf, "DRIVER={SQL Server};SERVER=%s;UID=%s;PWD=%s;DATABASE=%s",
  _snprintf_s(buf, sizeof(buf), _TRUNCATE, "DRIVER={SQL Server};SERVER=%s;UID=%s;PWD=%s;DATABASE=%s",
			  m_strServerIP.c_str(), m_strUserID.c_str(), m_strUserPwd.c_str(), m_strServerDB.c_str());

  if(!m_pDataBase->Open(buf))
  {
	SAFE_DELETE(m_pDataBase);
	return false;
  }
  m_pDataBase->SetAutoCommit(true);

  return true;
}

bool CDataBaseCtrl::IsConnect()
{
  return (db_mutator.get() != nullptr);
}

void CDataBaseCtrl::Disconnect()
{
  if(db_mutator.get() != nullptr)
  {
	try
	{
	  //m_pDataBase->Close();
	  db_connection.disconn();
	} catch(...)
	{
	  LG("DBExcp", "Exception raised when CDataBaseCtrl::Disconnect()\n");
	}
	db_mutator = nullptr;
	//SAFE_DELETE(m_pDataBase);
  }
}

bool CDataBaseCtrl::UserLogin(int nUserID, string strUserName, string strIP)
{
  if(!strUserName.c_str() || strUserName == "")
  {
	LG("AccountServer", "CDataBaseCtrl::UserLogin: parameter strUserName is empty or null\n");
	return false;
  }
  //LG("AccountServer", "CDataBaseCtrl::UserLogin: UserName=[%s] \n", strUserName.c_str());
  if(!strIP.c_str()) strIP = "";

  //char buf[1024];
  //sprintf(buf,"insert into user_log (user_id, user_name, login_time, login_ip) values (%d, '%s', getdate(), '%s')",
  //_snprintf_s(buf, sizeof(buf), _TRUNCATE, "insert into user_log (user_id, user_name, login_time, login_ip) values (%d, '%s', getdate(), '%s')",
  //			  nUserID, strUserName.c_str(), strIP.c_str());
  //string strSQL = buf;
  if(!IsConnect()) Connect();

  if(IsConnect())
  {
	try
	{
	  //m_pDataBase->ExecuteSQL(strSQL.c_str());
	  const bool sqlret = db_mutator->stored_procedure("{CALL dbo.UserLogin(?,?,?)}", "dbo", "UserLogin", 3,
								   &nUserID, strUserName.c_str(), strIP.c_str());
	  if(DBOK(sqlret))
	  {
		return true;
	  }
	  else
	  {
		LG("stored_procedure", "Check stored procedure on UserLogin, params: %d, %s, %s", nUserID, strUserName.c_str(),
		   strIP.c_str());
		Disconnect();
		return false;
	  }
	} catch(CSQLException* se)
	{
	  LG("DBExcp", "SQL Exception in CDataBaseCtrl::UserLogin: %s\n", se->m_strError.c_str());
	} catch(...)
	{
	  LG("DBExcp", "unknown exception raised from CDataBaseCtrl::UserLogin\n");
	}
  }
  LG("AccountServer", "CDataBaseCtrl::UserLogin: A record of user login cannot be saved! UserID=%d UserName=%s IP=%s\n\n", nUserID, strUserName.c_str(), strIP.c_str());

  Disconnect();
  return false;
}

bool CDataBaseCtrl::UserLogout(int nUserID)
{
  //char buf[1024];
  //sprintf(buf,"update user_log set logout_time=getdate() where log_id=(select max(log_id) from user_log where user_id=%d)", nUserID);
  //_snprintf_s(buf, sizeof(buf), _TRUNCATE, "update user_log set logout_time=getdate() where log_id=(select max(log_id) from user_log where user_id=%d)", nUserID);
  //string strSQL = buf;
  if(!IsConnect()) Connect();

  if(IsConnect())
  {
	try
	{
	  //m_pDataBase->ExecuteSQL(strSQL.c_str());
	  const bool sqlret = db_mutator->stored_procedure("{CALL dbo.UserLogout(?)}", "dbo", "UserLogout", 1, &nUserID);
	  if(DBOK(sqlret))
	  {
		return true;
	  } else
	  {
		LG("stored_procedure", "Check stored procedure on UserLogout, params: %d", nUserID);
		Disconnect();
		return false;
	  }
	} catch(CSQLException* se)
	{
	  LG("DBExcp", "SQL Exception in CDataBaseCtrl::UserLogout: %s\n", se->m_strError.c_str());
	} catch(...)
	{
	  LG("DBExcp", "unknown exception raised from CDataBaseCtrl::UserLogout\n");
	}
  }
  LG("AccountServer", "CDataBaseCtrl::UserLogout: A record of user logout cannot be saved! UserID=%d \n", nUserID);

  Disconnect();
  return false;
}

bool CDataBaseCtrl::OperAccountBan(std::string strActName, int iban) //Add by sunny.sun 20090828
{
  if(!strActName.c_str() || strActName == "")
  {
	LG("AccountServer", "CDataBaseCtrl::OperAccountBan: parameter strActName is empty or null\n");
	return false;
  }
 // char buf[1024];
 // _snprintf_s(buf, sizeof(buf), _TRUNCATE, "update account_login set ban = %i where name = '%s'", iban, strActName.c_str());
  //string strSQL = buf;
  if(!IsConnect()) Connect();
  if(IsConnect())
  {
	try
	{
	  //m_pDataBase->ExecuteSQL(strSQL.c_str());
	  const bool sqlret = db_mutator->stored_procedure("{CALL dbo.OperAccountBan(?,?)}", "dbo", "OperAccountBan", 2, &iban, strActName.c_str());
	  if(DBOK(sqlret))
	  {
		return true;
	  } else
	  {
		LG("stored_procedure", "Check stored procedure on OperAccountBan, params: %d, %s", iban, strActName.c_str());
		Disconnect();
		return false;
	  }
	} catch(CSQLException* se)
	{
	  LG("DBExcp", "SQL Exception in CDataBaseCtrl::OperAccountBan: %s\n", se->m_strError.c_str());
	} catch(...)
	{
	  LG("DBExcp", "unknown exception raised from CDataBaseCtrl::OperAccountBan\n");
	}
  }
  LG("AccountServer", "CDataBaseCtrl::OperAccountBan: A record of user account cannot be ban! accName[%s]\n", strActName.c_str());

  Disconnect();
  return false;
}
