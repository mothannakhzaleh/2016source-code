--------------------------------------------------------------------------
--									--
--									--
--mission.lua Created by Robin 2004.12.27.	--
--									--
--									--
--------------------------------------------------------------------------
print( "loading mission.lua" )

--lua函数返回值定义
LUA_FALSE					= 0
LUA_TRUE					= 1

MIS_TREENODE_INVALID	= 0	-- 无效类型
MIS_TREENODE_NOMAL		= 1	-- 普通任务
MIS_TREENODE_HISTORY	= 2	-- 历史任务
MIS_TREENODE_GUILD		= 3	-- 工会任务
MIS_TREENODE_MAIN		= 4	-- 主线任务

MisData = {}

function AddMisData( id, name, tp, x1, y1, map1, x2, y2, map2 )
	if id == nil or name == nil or tp == nil then
		MISSION_MISSION_LUA_000001 = GetResString("MISSION_MISSION_LUA_000001")
		print( MISSION_MISSION_LUA_000001, id, name, tp )
		return
	end

	if MisData[id] ~= nil then
		MISSION_MISSION_LUA_000002 = GetResString("MISSION_MISSION_LUA_000002")
		print( MISSION_MISSION_LUA_000002, id, MisData[id].name, MisData[id].tp, id, name, tp )
	end

	MisData[id] = {}
	MisData[id].name = name
	MisData[id].tp = tp
	MisData[id].x1 = x1
	MisData[id].y1 = y1
	MisData[id].map1 = map1
	MisData[id].x2 = x2
	MisData[id].y2 = y2
	MisData[id].map2 = map2

	--print( "设置任务：《"..name.."》 ID["..id.."] Type["..tp.."]" )
end

function GetMisData( id )
	if id == nil then
		MISSION_MISSION_LUA_000003 = GetResString("MISSION_MISSION_LUA_000003")
		print( MISSION_MISSION_LUA_000003 )
		return LUA_FALSE
	end

	if MisData[id] == nil or MisData[id].name == nil or MisData[id].tp == nil then
		MISSION_MISSION_LUA_000004 = GetResString("MISSION_MISSION_LUA_000004")
		print( MISSION_MISSION_LUA_000004..id )
		return LUA_FALSE
	end

	return LUA_TRUE, MisData[id].tp, MisData[id].name, MisData[id].x1, MisData[id].y1, MisData[id].map1, MisData[id].x2, MisData[id].y2, MisData[id].map2
end

MISSION_MISSION_LUA_000005 = GetResString("MISSION_MISSION_LUA_000005")
MISSION_MISSION_LUA_000005 = GetResString("MISSION_MISSION_LUA_000005")
MISSION_MISSION_LUA_000006 = GetResString("MISSION_MISSION_LUA_000006")
AddMisDataFromLua( 100, MISSION_MISSION_LUA_000006, MIS_TREENODE_NOMAL,0,0,MISSION_MISSION_LUA_000005,0,0,MISSION_MISSION_LUA_000005 )
