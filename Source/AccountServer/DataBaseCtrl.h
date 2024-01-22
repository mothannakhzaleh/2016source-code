#pragma once

#include "atltime.h"
#include <memory>
#include <map>
// Namespaces inside headers are not a good idea.
using namespace std;
#include "db.h"

class CSQLDatabase;

//此类只允许主线程调用
class CDataBaseCtrl
{
  public:
  CDataBaseCtrl(void);
  ~CDataBaseCtrl(void);
  bool CreateObject();
  void ReleaseObject();

  bool UserLogin(int nUserID, std::string strUserName, std::string strIP);
  bool UserLogout(int nUserID);

  bool OperAccountBan(std::string strActName, int iban); //Add by sunny.sun 20090828
  private:
  struct sPlayerData
  {
	CTime ctLoginTime;
  };
  typedef std::map<std::string, CDataBaseCtrl::sPlayerData> StringMap;

  private:
  bool Connect();
  bool IsConnect();
  void Disconnect();

  private:
  std::string	m_strServerIP;
  std::string	m_strServerDB;
  std::string	m_strUserID;
  std::string	m_strUserPwd;
  CSQLDatabase* m_pDataBase;

  std::unique_ptr<cfl_rs> db_mutator;
  cfl_db				  db_connection;
};
