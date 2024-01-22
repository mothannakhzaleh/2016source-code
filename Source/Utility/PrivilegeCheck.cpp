#include "PrivilegeCheck.h"


PrivilegeCheck* PrivilegeCheck::_instance = NULL;

PrivilegeCheck::PrivilegeCheck(void)
{

}

PrivilegeCheck::~PrivilegeCheck(void)
{
}

PrivilegeCheck* PrivilegeCheck::Instance()
{
	if(_instance == NULL)
	{
		_instance = new PrivilegeCheck();
	}

	return _instance;
}

bool PrivilegeCheck::Init(const char* configFileName)
{
	fstream fs;
	fs.open(configFileName);

	char buf[255];

	char const* seps[2] = {"=",","};
	char* token;
	char* nexttoken;

	while(!fs.eof())
	{
		fs.getline(buf, 255);

		vector< string > item;
		CommandV commands;

		token = strtok_s( buf, seps[0] , &nexttoken);
		while( token != NULL )
		{
			item.push_back(token);

			token = strtok_s( NULL, seps[0] , &nexttoken);
		}

		if(item.size() == 2)
		{
			if(item[0].compare(0, 2, "//") == 0)
				continue;

			token = strtok_s( const_cast<char*>(item[1].c_str()), seps[1] , &nexttoken);
			while( token != NULL )
			{
				commands.push_back(token);

				token = strtok_s( NULL, seps[1] , &nexttoken);
			}

			m_mapPrivilege[atoi(item[0].c_str())] = commands;
		}
	}

	fs.close();

	return true;
}

bool PrivilegeCheck::HasPrivilege(int level, const char* command, const char* accountName, const char* ip)
{
	for(PrivilegeIt it = m_mapPrivilege.begin(); it != m_mapPrivilege.end(); it++)
	{
		if(it->first <= level)
		{
			for(CommandIt cit = it->second.begin(); cit != it->second.end(); cit++)
			{
				if(cit->compare(command) == 0)
					return true;
			}
		}
		else
			break;
	}

	return false;
}