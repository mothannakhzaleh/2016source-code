------------------------------------------------------------
--EventEntity.lua Created by knight 2005.5.16.
--
--定义各个地图上的事件实体
print( "loading EventEntity.lua" )
-------------------------------------------------------------

--初始化加纳大陆的事件实体信息
function InitGarnerEntity()

	--创建加纳大陆港口实体
	ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
	CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 225065, 281984, 0, 1, 2231, 2827, 0 )
	ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
	CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 326048, 330919,-10, 5, 3260,3280, 0 )
	ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
	CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 230572, 112347,-10, 6, 2273,1122, 0 )
	ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
	CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 363213, 74776,-10, 7, 3590,755, 0 )
	ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
	CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 105831, 133151,-10, 2, 1058,1323, 0 )
	
	--创建箱子实体
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 456, 3, 159319, 275344, 129, 3973, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 456, 3, 163363, 265076, 69, 3973, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 456, 3, 161248, 271701, 84, 3973, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 457, 3, 154428, 270697, 99, 3974, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 457, 3, 154428, 270697, 99, 3974, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 457, 3, 153274, 274001, 144, 3974, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 456, 3, 163737, 277868, 189, 3975, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 456, 3, 157172, 267995, 204, 3975, 1, 180 )
	GARNER_GARNERENTITY_LUA_000001 = GetResString("GARNER_GARNERENTITY_LUA_000001")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000001, 456, 3, 154788, 264604, 159, 3975, 1, 180 )
	GARNER_GARNERENTITY_LUA_000002 = GetResString("GARNER_GARNERENTITY_LUA_000002")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000002, 457, 3, 221750, 254779, 144, 3977, 1, 180 )
	GARNER_GARNERENTITY_LUA_000003 = GetResString("GARNER_GARNERENTITY_LUA_000003")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000003, 458, 3, 97144, 266563, 144, 4073, 1, 180 )
	GARNER_GARNERENTITY_LUA_000003 = GetResString("GARNER_GARNERENTITY_LUA_000003")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000003, 458, 3, 91154, 263547, 99, 4073, 1, 180 )
	GARNER_GARNERENTITY_LUA_000003 = GetResString("GARNER_GARNERENTITY_LUA_000003")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000003, 458, 3, 90400, 266712, 84, 4073, 1, 180 )
	GARNER_GARNERENTITY_LUA_000004 = GetResString("GARNER_GARNERENTITY_LUA_000004")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000004, 458, 3, 114500, 314300, 84, 4089, 1, 180 )
	GARNER_GARNERENTITY_LUA_000004 = GetResString("GARNER_GARNERENTITY_LUA_000004")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000004, 458, 3, 117200, 315300, 84, 4089, 1, 180 )
	GARNER_GARNERENTITY_LUA_000004 = GetResString("GARNER_GARNERENTITY_LUA_000004")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000004, 458, 3, 121400, 315100, 84, 4089, 1, 180 )
	GARNER_GARNERENTITY_LUA_000004 = GetResString("GARNER_GARNERENTITY_LUA_000004")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000004, 458, 3, 122800, 310700, 84, 4089, 1, 180 )
	GARNER_GARNERENTITY_LUA_000004 = GetResString("GARNER_GARNERENTITY_LUA_000004")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000004, 458, 3, 115500, 308700, 84, 4089, 1, 180 )
	GARNER_GARNERENTITY_LUA_000004 = GetResString("GARNER_GARNERENTITY_LUA_000004")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000004, 458, 3, 120500, 305000, 84, 4089, 1, 180 )
	GARNER_GARNERENTITY_LUA_000005 = GetResString("GARNER_GARNERENTITY_LUA_000005")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000005, 468, 3, 109800, 257200, 84, 4092, 1, 180 )
	GARNER_GARNERENTITY_LUA_000005 = GetResString("GARNER_GARNERENTITY_LUA_000005")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000005, 468, 3, 107800, 260200, 84, 4092, 1, 180 )
	GARNER_GARNERENTITY_LUA_000005 = GetResString("GARNER_GARNERENTITY_LUA_000005")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000005, 468, 3, 112800, 257000, 84, 4092, 1, 180 )
	GARNER_GARNERENTITY_LUA_000006 = GetResString("GARNER_GARNERENTITY_LUA_000006")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000006, 463, 3, 126372, 296071, 114, 4086, 1, 180 )
	GARNER_GARNERENTITY_LUA_000006 = GetResString("GARNER_GARNERENTITY_LUA_000006")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000006, 463, 3, 124400, 293900, 114, 4086, 1, 180 )
	GARNER_GARNERENTITY_LUA_000006 = GetResString("GARNER_GARNERENTITY_LUA_000006")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000006, 463, 3, 126825, 306083, 144, 4086, 1, 180 )
	GARNER_GARNERENTITY_LUA_000007 = GetResString("GARNER_GARNERENTITY_LUA_000007")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000007, 466, 3, 154462, 313471, 96, 4085, 1, 180 )
	GARNER_GARNERENTITY_LUA_000007 = GetResString("GARNER_GARNERENTITY_LUA_000007")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000007, 466, 3, 156862, 318303, 174, 4085, 1, 180 )
	GARNER_GARNERENTITY_LUA_000007 = GetResString("GARNER_GARNERENTITY_LUA_000007")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000007, 466, 3, 161567, 315811, -34, 4085, 1, 180 )
	GARNER_GARNERENTITY_LUA_000008 = GetResString("GARNER_GARNERENTITY_LUA_000008")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000008, 458, 3, 88300, 257200, 99, 4093, 1, 180 )
	GARNER_GARNERENTITY_LUA_000008 = GetResString("GARNER_GARNERENTITY_LUA_000008")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000008, 458, 3, 99100, 265200, 99, 4093, 1, 180 )
	GARNER_GARNERENTITY_LUA_000008 = GetResString("GARNER_GARNERENTITY_LUA_000008")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000008, 458, 3, 102400, 251600, 99, 4093, 1, 180 )
	GARNER_GARNERENTITY_LUA_000009 = GetResString("GARNER_GARNERENTITY_LUA_000009")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000009, 456, 3, 102584, 306100, 144, 4087, 1, 180 )
	GARNER_GARNERENTITY_LUA_000010 = GetResString("GARNER_GARNERENTITY_LUA_000010")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000010, 220, 3, 132343, 264215, 249, 4090, 1, 180 )
	GARNER_GARNERENTITY_LUA_000010 = GetResString("GARNER_GARNERENTITY_LUA_000010")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000010, 220, 3, 126478, 266233, -154, 4090, 1, 180 )
	GARNER_GARNERENTITY_LUA_000010 = GetResString("GARNER_GARNERENTITY_LUA_000010")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000010, 220, 3, 120307, 262026, 294, 4090, 1, 180 )
	GARNER_GARNERENTITY_LUA_000011 = GetResString("GARNER_GARNERENTITY_LUA_000011")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000011, 458, 3, 68592, 263459, 39, 4094, 1, 180 )
	GARNER_GARNERENTITY_LUA_000011 = GetResString("GARNER_GARNERENTITY_LUA_000011")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000011, 458, 3, 68303, 270607, 9, 4094, 1, 180 )
	GARNER_GARNERENTITY_LUA_000011 = GetResString("GARNER_GARNERENTITY_LUA_000011")
	CreateResourceEntity( GARNER_GARNERENTITY_LUA_000011, 458, 3, 73415, 268141, 144, 4094, 1, 180 )


end

InitGarnerEntity()
