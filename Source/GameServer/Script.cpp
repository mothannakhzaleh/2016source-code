// Script.cpp Created by knight-gongjian 2004.12.1.
//---------------------------------------------------------

#include "Script.h"
#include "NpcScript.h"
#include "CharScript.h"
#include "EntityScript.h"
#include "Parser.h"

//---------------------------------------------------------
extern const char* GetResPath(const char *pszRes);

CCharacter* g_pNoticeChar = NULL;
lua_State*	g_pLuaState = NULL;

BOOL InitLuaScript()
{
	g_pLuaState = lua_open();
	luaL_openlibs(g_pLuaState);

	if( !RegisterScript() )
		return FALSE;
	
	if( !LoadScript() )
		return FALSE;

	return TRUE;
}

BOOL CloseLuaScript()
{
	if( g_pLuaState ) lua_close( g_pLuaState );
	g_pLuaState = NULL;
	return TRUE;
}

BOOL RegisterScript()
{
	if( !RegisterCharScript() || !RegisterNpcScript() )
		return FALSE;

	if( !RegisterEntityScript() )
		return FALSE;

	return TRUE;
}

void ReloadLuaInit()
{
	CParser::dofile(g_pLuaState, GetResPath("script/initial.lua"));
}

void ReloadLuaSdk()
{	
	CParser::dofile(g_pLuaState, GetResPath("script/calculate/skilleffect.lua"));
	CParser::dofile( g_pLuaState, GetResPath("script/MisSdk/NpcSdk.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisSdk/MissionSdk.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisSdk/scriptsdk.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/ScriptDefine.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcDefine.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/templatesdk.lua") );

	// 由updateall会触发ai_sdk更新
	CParser::dofile(g_pLuaState, GetResPath("script/birth/birth_conf.lua"));
	CParser::dofile( g_pLuaState, GetResPath("script/ai/ai.lua") );
}

void ReloadNpcScript()
{
	// 装载NPC任务数据信息
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript01.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript02.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript03.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript04.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript05.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript06.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript07.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/MissionScript08.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/SendMission.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/EudemonScript.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/CharBornScript.lua") );

	// 装载NPC对话数据信息
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript01.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript02.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript03.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript04.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript05.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript06.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript07.lua") );
	CParser::dofile( g_pLuaState, GetResPath("script/MisScript/NpcScript08.lua") );
}

void ReloadEntity( const char szFileName[] )
{
	//lua_dofile( g_pLuaState, szFileName );
	CParser::dofile(g_pLuaState, szFileName);
}


BOOL LoadScript()
{
	ReloadLuaInit();
	ReloadLuaSdk();
	ReloadNpcScript();
	return TRUE;
}
