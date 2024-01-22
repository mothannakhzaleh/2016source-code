#pragma once

#include <utility>
#include <vector>
#include <map>
#include <fstream>

using namespace std;

class PrivilegeCheck
{
private:
	PrivilegeCheck(void);
public:
	~PrivilegeCheck(void);

public:
	static PrivilegeCheck* Instance();	// 唯一实例
	bool	Init(const char* configFileName);
	bool	HasPrivilege(int level, const char* command, const char* accountName = "", const char* ip = "");
private:
	typedef vector<string> CommandV;			// 命令数组
	typedef map<int, CommandV> PrivilegeMap;	// 权限集合

	typedef CommandV::iterator CommandIt;		// 命令
	typedef PrivilegeMap::iterator PrivilegeIt;	// 权限

	static PrivilegeCheck* _instance;
	PrivilegeMap m_mapPrivilege;
};
