//=============================================================================
// FileName: Parser.h
// Creater: ZhangXuedong
// Date: 2004.11.22
// Comment: scripts interface
//=============================================================================

#ifndef PARSER_H
#define PARSER_H

#include "tchar.h"

#include <lua.hpp>

#include "stdafx.h" //add by sunny 20080312

#define DOSTRING_PARAM_END	999999999
#define DOSTRING_RETURN_NUM	20
#define DOSTRING_RETURN_STRING_LEN	512

enum EScriptParamType
{
	enumSCRIPT_PARAM_NUMBER = 1,
	enumSCRIPT_PARAM_NUMBER_UNSIGNED,
	enumSCRIPT_PARAM_LIGHTUSERDATA,
	enumSCRIPT_PARAM_STRING,
	enumSCRIPT_PARAM_NUMBER_LONG64,
};

enum EScriptReturnType
{
	enumSCRIPT_RETURN_NONE,
	enumSCRIPT_RETURN_NUMBER,
	enumSCRIPT_RETURN_STRING,
};

class CParser
{
public:
	void	Init(lua_State *pLS);
	void	Free();

	int		DoString(const char *csString, char chRetType, int nRetNum, ...);
	bool	StringIsFunction(const char *csString) {lua_getglobal(m_pSLua, csString); return lua_isfunction(m_pSLua, -1);}
	int		GetReturnNumber(char chID) {if (chID >= DOSTRING_RETURN_NUM) return 0; return m_nDoStringRet[chID];}
	char*	GetReturnString(char chID) {if (chID >= DOSTRING_RETURN_NUM) return 0; return m_szDoStringRet[chID];}

	static int docall(lua_State* L, int narg, int clear)
	{
	  int base = lua_gettop(L) - narg; /* function index */
	  lua_pushcfunction(L, traceback); /* push traceback function */
	  lua_insert(L, base);			   /* put it under chunk and args */
	  int status = lua_pcall(L, narg, (clear ? 0 : LUA_MULTRET), base);
	  lua_remove(L, base); /* remove traceback function */
	  /* force a complete garbage collection in case of errors */
	  if(status != LUA_OK) lua_gc(L, LUA_GCCOLLECT, 0);
	  return status;
	}

	static int traceback(lua_State* L)
	{
	  if(!lua_isstring(L, 1))
	  { /* Non-string error object? Try metamethod. */
		if(lua_isnoneornil(L, 1) ||
		   !luaL_callmeta(L, 1, "__tostring") ||
		   !lua_isstring(L, -1))
		  return 1;		  /* Return non-string error object. */
		lua_remove(L, 1); /* Replace object by result of __tostring metamethod. */
	  }
	  luaL_traceback(L, L, lua_tostring(L, 1), 1);
	  return 1;
	}

	static int dolibrary(lua_State* L, const char* name)
	{
	  lua_getglobal(L, "require");
	  lua_pushstring(L, name);
	  return report(L, docall(L, 1, 1));
	}

	static int report(lua_State* L, int status)
	{
	  if(status && !lua_isnil(L, -1))
	  {
		const char* msg = lua_tostring(L, -1);
		if(msg == NULL) msg = "(error object is not a string)";
		l_message(msg);
		LG("luajit", msg);
		lua_pop(L, 1);
	  }
	  return status;
	}

	static void l_message(const char* msg)
	{
	  const char* progname = "LuaParser";
	  if(progname)
	  {
		fputs(progname, stderr);
		fputc(':', stderr);
		fputc(' ', stderr);
	  }
	  fputs(msg, stderr);
	  fputc('\n', stderr);
	  fflush(stderr);
	}

	static int dostring(lua_State* L, const char* s, const char* name)
	{
	  int status = luaL_loadbuffer(L, s, strlen(s), name) || docall(L, 0, 1);
	  return report(L, status);
	}
	static int dofile(lua_State* L, const char* name)
	{
	  int status = luaL_loadfile(L, name) || docall(L, 0, 1);
	  return report(L, status);
	}

protected:

private:
	bool	SetRetString(char chID, const char *cszString)
	{
		if (chID >= DOSTRING_RETURN_NUM) return false;
		//strncpy(m_szDoStringRet[chID], cszString, DOSTRING_RETURN_STRING_LEN - 1);
		strncpy_s( m_szDoStringRet[chID], sizeof(m_szDoStringRet[chID]), cszString, _TRUNCATE );
		//m_szDoStringRet[chID][DOSTRING_RETURN_STRING_LEN - 1] = '\0';
		return true;
	}

	lua_State	*m_pSLua; // lua½Å±¾½âÊÍÆ÷

	int			m_nDoStringRet[DOSTRING_RETURN_NUM];
	char		m_szDoStringRet[DOSTRING_RETURN_NUM][DOSTRING_RETURN_STRING_LEN];
};

extern CParser	g_CParser;

#endif // PARSER_H