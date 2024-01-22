--------------------------------------------------------------------------
--									--
--									--
--				AddHelpNPC.lua				--
--									--
--									--
--------------------------------------------------------------------------
print( "Loading AddHelpNPC.lua" )
print( "------------------------------------" )
print( "Loading DONE!" )


--初始化帮助NPC
--此文件在GameServer地图初始化全部完成之后, 载入一次

ClearHelpNPC()
HELP_ADDHELPNPC_LUA_000001 = GetResString("HELP_ADDHELPNPC_LUA_000001")
AddHelpNPC(HELP_ADDHELPNPC_LUA_000001)
