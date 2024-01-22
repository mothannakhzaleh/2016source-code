#include "StdAfx.h"
#include ".\controlcommand.h"


struct sCommandInfo
{
	bool isAvailable;					//Whether the command is valid, this parameter can block some commands
	CString strCommandShowName;			//Chinese name of the command
	CString strCommandName;				//The actual operation instruction of the command, for example: "&move"
	bool bHasTarget;					//Whether the instruction needs to have a target object (the player's name)
	int nParamCounts;					//The number of parameters after the instruction (maximum value)
	int nDivideStart;					//The delimiter starts from the first number of parameters added, the number of parameters starts from 0, -1 means there is no delimiter (all are replaced by spaces)
	CString strHelpInfo;				//help instruction format
};


static sCommandInfo sCommandLine[COMMAND_LINE_MAX_COUNT]=
{
	{true,"The current number of people","@@ getusernum+",false,0,-1,"Description: Get the number of current online players, this command does not need parameters"},
	{true,"Player connection rate","@@ ping",true,0,-1,"Description: Get the network connection delay value of the specified player, this command does not need parameters"},
	{true,"My last connection","@@ getlastconnection",false,0,-1,"Description: Get your last connection status (disconnection reason), this command does not need parameters"},
	{true,"The last time the player connected","@@ getuserconnection",true,0,-1,"Description: Get the last connection status of the player (cause of disconnection), this command does not need parameters"},
	{true,"QUery player basic information","&qcha",true,0,-1,"Description: Get the basic information of the player, this command does not need parameters"},
	{true,"Publish system information","&notice",false,1,-1,"Description: Quick chat channel releases system information, format: please enter the content of the information directly in this line"},
	{true,"Invisibility","&hide",false,0,-1,"Description: GM special stealth skills, this command does not need parameters"},
	{true,"Reveal","&unhide",false,0,-1,"Explanation: GM special appearance skill, corresponding to stealth operation, this command does not need parameters"},
	{true,"Resurrection in situ","&relive",false,0,-1,"Description: GM dedicated self-resurrection, this command does not need parameters"},
	{true,"Move","&move",false,3,1,"Description: Teleport to the reachable position in the game, format: X coordinate Y coordinate [map name]"},
	{true,"Teleport to the player's position","&goto",true,0,-1,"Description: Teleport to the position of the specified player, this command does not need parameters"},
	{true,"Call the player to the side","&call",true,0,-1,"Description: Summon the specified player to their location, this command does not need parameters"},
	{true,"Kick player offline","&kick",true,0,-1,"Description: Kick the specified player offline, a special command for GM, this command does not need parameters"},
	{true,"Forbidden","@@ estop",true,1,0,"Description: Prohibit players from speaking, a special command for GM, format: please directly enter the ban time (minutes, at least 30 minutes) in this line"},
	{true,"Release","@@ delestop",true,0,-1,"Description: Unmute, GM special command, this command does not need parameters"},
};

CControlCommand::CControlCommand(void)
{
}

CControlCommand::~CControlCommand(void)
{
}

bool CControlCommand::IsAvailable(int index)
{
	return sCommandLine[index].isAvailable;
}

CString CControlCommand::GetCommandShowName(int index)
{
	return sCommandLine[index].strCommandShowName;
}

CString CControlCommand::GetCommandName(int index)
{
	return sCommandLine[index].strCommandName;
}

bool CControlCommand::HasTarget(int index)
{
	return sCommandLine[index].bHasTarget;
}

int CControlCommand::GetParamCounts(int index)
{
	return sCommandLine[index].nParamCounts;
}

int CControlCommand::GetDivideStart(int index)
{
	return sCommandLine[index].nDivideStart;
}

CString CControlCommand::GetHelpInfo(int index)
{
	return sCommandLine[index].strHelpInfo;
}

int CControlCommand::GetCommandLineCounts()
{
	return COMMAND_LINE_MAX_COUNT;
}

CString CControlCommand::AssembleCommand(int index,CString strName,CString strText)
{
	CString strRet=CControlCommand::GetCommandName(index);
	if (CControlCommand::HasTarget(index))
	{
		strRet+=" "+strName;
	}
	if (CControlCommand::GetParamCounts(index)==0)
	{
		return strRet;
	}
	int nPos=0,nParamCount=0;
	CString strParam;
	while (!(strParam=strText.Tokenize(" ,",nPos)).IsEmpty())
	{
		nParamCount++;
		int nDivideStart=CControlCommand::GetDivideStart(index);
		if (nDivideStart>=0 && nParamCount>nDivideStart)
		{
			strRet+=","+strParam;
		}
		else
		{
			strRet+=" "+strParam;
		}
	};
	if (nParamCount>CControlCommand::GetParamCounts(index))
	{
		return NULL;
	}
	return strRet;
}
