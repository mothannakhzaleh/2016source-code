------------------------------------------------------------
--EventEntity.lua Created by knight 2005.5.16.
--
--定义各个地图上的事件实体
print( "loading EventEntity.lua" )
-------------------------------------------------------------

function InitGarnerEntity()

-----------创建入港
ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001 = GetResString("ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001")
CreateBerthEntity( ABANDONEDCITY_ABANDONEDCITYENTITY_LUA_000001, 455, 2, 31221, 36919, 0, 12, 310, 347, 0 )


end

InitGarnerEntity()
