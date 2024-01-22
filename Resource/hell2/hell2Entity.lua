------------------------------------------------------------
--EventEntity.lua Created by knight 2005.5.16.
--
--定义各个地图上的事件实体
print( "loading EventEntity.lua" )
-------------------------------------------------------------

function InitGarnerEntity()

-----------创建入港
ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 23500, 7500, -10, 12,245, 75, 0 )

end

InitGarnerEntity()
